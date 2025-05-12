{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Minimal LSP Configuration
    plugins.lsp = {
      enable = true;
      
      # Only enable essential LSP servers
      servers = {
        # Python tools
        pyright.enable = true;
        ruff = {
          enable = true;
          package = lib.mkForce null;  # Let the user install ruff externally
        };
        
        # Minimal Lua settings
        lua_ls = {
          enable = true;
          settings.Lua = {
            diagnostics.globals = [ "vim" ];
            telemetry.enable = false;
          };
        };
        
        # Nix support
        nil_ls.enable = true;
        
        # C/C++
        clangd.enable = true;
      };
      
      # Use keymaps here
      keymaps = {
        lspBuf = {
          "gd" = "definition";
          "gr" = "references";
          "K" = "hover";
          "<leader>lr" = "rename";
          "<leader>la" = "code_action";
          "<leader>lf" = "format";
        };
      };
    };
    
    # Simplified completion
    plugins.cmp = {
      enable = true;
      
      settings = {
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
        
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
      };
    };
    
    # Only include essential plugins
    extraPlugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
    ];
    
    # Add error handling for LSP keybinding descriptions
    extraConfigLua = ''
      -- Use autocmd to add descriptions to LSP keybindings for which-key
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          
          -- Safe require for which-key
          local ok, wk = pcall(require, "which-key")
          if ok then
            -- Add descriptions for existing keymaps
            wk.register({
              g = {
                d = { name = "Go to definition" },
                r = { name = "References" },
              },
              K = { name = "Hover" },
              ["<leader>l"] = {
                name = "+lsp",
                r = { name = "Rename" },
                a = { name = "Code action" },
                f = { name = "Format" },
              }
            }, { buffer = bufnr })
          end
        end,
      })
    '';
  };
}
