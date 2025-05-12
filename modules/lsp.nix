{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Minimal LSP Configuration with lazy loading
    plugins.lsp = {
      enable = true;
      
      # Configure servers to start on demand
      servers = {
        # Python - only start when opening Python files
        pyright = {
          enable = true;
          autostart = false; # Don't start automatically
        };
        ruff = {
          enable = true;
          package = lib.mkForce null;
          autostart = false;
        };
        
        # Lua - only for Neovim config files
        lua_ls = {
          enable = true;
          autostart = false;
          settings.Lua = {
            diagnostics.globals = [ "vim" ];
            telemetry.enable = false;
            # Reduce workspace scanning
            workspace.checkThirdParty = false;
            completion.workspaceWord = false;
          };
        };
        
        # Nix - only for Nix files
        nil_ls = {
          enable = true;
          autostart = false;
        };
        
        # C/C++ - only for C/C++ files
        clangd = {
          enable = true;
          autostart = false;
        };
      };
      
      # Minimal keymaps
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
    
    # Optimize completion settings
    plugins.cmp = {
      enable = true;
      
      settings = {
        # Reduce completion sources for faster startup
        sources = [
          # LSP completion (highest priority)
          { name = "nvim_lsp"; priority = 1000; }
          
          # Buffer completion (only current buffer for performance)
          { 
            name = "buffer"; 
            priority = 500;
            option.get_bufnrs.__raw = ''
              function()
                return { vim.api.nvim_get_current_buf() }
              end
            '';
          }
          
          # Path completion (lowest priority)
          { name = "path"; priority = 300; }
        ]; 
        # Faster completion
        performance = {
          debounce = 60; # Faster debounce
          throttle = 30; # Faster throttle
          max_view_entries = 15; # Limit entries
        };
        
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
        
        snippet.expand = ''
          function(args) require('luasnip').lsp_expand(args.body) end
        '';
      };
    };
    
    # Minimal plugins - load others on demand
    extraPlugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
    ];
    
    # Optimized LSP startup
    extraConfigLua = ''
      -- Start LSP servers on demand based on filetype
      local function start_lsp_for_filetype()
        local filetype = vim.bo.filetype
        local client_names = {}
        
        if filetype == "python" then
          client_names = {"pyright", "ruff"}
        elseif filetype == "lua" then
          client_names = {"lua_ls"}
        elseif filetype == "nix" then
          client_names = {"nil_ls"}
        elseif filetype == "c" or filetype == "cpp" then
          client_names = {"clangd"}
        end
        
        for _, client_name in ipairs(client_names) do
          local clients = vim.lsp.get_active_clients({name = client_name})
          if #clients == 0 then
            vim.cmd("LspStart " .. client_name)
          end
        end
      end
      
      -- Auto-start LSP for the right filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"python", "lua", "nix", "c", "cpp"},
        callback = function()
          vim.schedule(start_lsp_for_filetype)
        end
      })
      
      -- Defer loading LuaSnip
      vim.api.nvim_create_autocmd("InsertEnter", {
        once = true,
        callback = function()
          pcall(require, "luasnip")
        end
      })
      
      -- Defer which-key descriptions
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          
          -- Defer which-key registration
          vim.defer_fn(function()
            local ok, wk = pcall(require, "which-key")
            if ok then
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
          end, 100)
        end,
      })
    '';
  };
}
