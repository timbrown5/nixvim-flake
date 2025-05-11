{
  config,
  pkgs,
  lib,
  ...
}: {
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
    
    # Use keymaps here, not in extraConfigLua - REMOVE DUPLICATES
    keymaps = {
      lspBuf = {
        # These are only defined here, not in extraConfigLua
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
  
  # Add minimal Lua for setting up LSP keybinding descriptions
  extraConfigLua = ''
    -- Use autocmd to describe LSP keybindings to which-key when LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        
        -- Register LSP keybindings with which-key using the latest format
        local wk = require("which-key")
        
        -- Buffer-local LSP mappings using latest which-key format
        wk.register({
          g = {
            d = { vim.lsp.buf.definition, "Go to definition" },
            r = { vim.lsp.buf.references, "References" },
          }
        }, { buffer = bufnr })
      end,
    })
  '';
}
