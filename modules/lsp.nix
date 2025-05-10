{
  config,
  pkgs,
  lib,
  ...
}: {
  # LSP Configuration
  plugins.lsp = {
    enable = true;
    
    # LSP servers with latest format
    servers = {
      pyright.enable = true;
      ruff_lsp = {
        enable = true;
        package = lib.mkForce null;  # Let the user install ruff externally
        settings = {
          organizeImports = true;
          fixAll = true;
        };
      };
      
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            runtime.version = "LuaJIT";
            diagnostics.globals = [ "vim" "require" "pcall" "pairs" ];
            workspace = {
              library = lib.mkForce [];
              checkThirdParty = false;
            };
            telemetry.enable = false;
            format.enable = true;
          };
        };
      };
      
      nil_ls = {
        enable = true;
        settings = {
          formatting.command = [ "nixpkgs-fmt" ];
          diagnostics.ignored = [ "unused_binding" "unused_with" ];
          nix = {
            maxMemoryMB = 2048;
            flake.autoEvalInputs = true;
          };
        };
      };
      
      clangd.enable = true;
      terraformls.enable = true;
      tflint.enable = true;
    };
    
    keymaps = {
      lspBuf = {
        "gd" = "definition";
        "gr" = "references";
        "K" = "hover";
        "<leader>rn" = "rename";
        "<leader>ca" = "code_action";
        "<leader>f" = "format";
      };
    };

    onAttach = ''
      -- Set up Lua LSP runtime paths
      if client.name == "lua_ls" then
        client.server_capabilities.documentFormattingProvider = true
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
          Lua = {
            workspace = { library = vim.api.nvim_get_runtime_file("", true) }
          }
        })
      end
    '';
  };
  
  # Completion with nvim-cmp
  plugins.cmp = {
    enable = true;
    
    settings = {
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end
        '';
        "<S-Tab>" = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end
        '';
      };
      
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
      
      snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
      
      window = {
        completion = { 
          border = "rounded";
          winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None";
        };
        documentation = {
          border = "rounded";
          winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None";
        };
      };
      
      formatting = {
        fields = ["kind" "abbr" "menu"];
        format = ''
          function(entry, vim_item)
            local kind_icons = {
              Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
              Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
              Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎠",
              Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
              File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
              Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
              TypeParameter = "󰊄",
            }
            
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]", luasnip = "[Snip]", buffer = "[Buf]", path = "[Path]"
            })[entry.source.name]
            
            return vim_item
          end
        '';
      };
      
      experimental.ghost_text = true;
    };
  };
  
  # Required plugins
  extraPlugins = with pkgs.vimPlugins; [
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    luasnip
    friendly-snippets
  ];
  
  # Ruff installation instruction in Lua
  extraConfigLua = ''
    -- Install Ruff if not available
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.py",
      callback = function()
        -- Check if ruff is installed
        local is_ruff_installed = vim.fn.executable('ruff') == 1
        if not is_ruff_installed then
          vim.notify("Ruff is not installed. Please install it with: pip install ruff", vim.log.levels.WARN)
        end
      end,
      once = true,
    })
  '';
}
