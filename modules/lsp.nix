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
      
      # Keymaps are handled in lua/lsp.lua
      # Empty here to avoid duplication
      keymaps.lspBuf = {};
    };
    
    # Optimize completion settings
    plugins.cmp = {
      enable = true;
      
      settings = {
        # Reduce completion sources for faster startup
        sources = [
          { name = "nvim_lsp"; priority = 1000; }
          { 
            name = "buffer"; 
            priority = 500;
            option.get_bufnrs.__raw = ''
              function()
                return { vim.api.nvim_get_current_buf() }
              end
            '';
          }
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
    
    # Import LSP configuration from Lua file
    extraConfigLua = builtins.readFile ../lua/lsp.lua;
  };
}
