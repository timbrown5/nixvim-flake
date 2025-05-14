{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Plugin management with lazy loading
    plugins = {
      # Core plugins - load immediately as they're essential
      treesitter = {
        enable = true;
        nixGrammars = true;
        # Only install grammars for languages we actually use
        settings.ensure_installed = [ "python" "lua" "nix" "c" ];
      };
      
      # Defer non-essential UI plugins
      gitsigns = {
        enable = true;
        settings = {
          # Only load gitsigns in git repositories
          attach_to_untracked = false;
          current_line_blame = false; # Expensive operation
          current_line_blame_opts.delay = 500;
        };
      };
      
      comment.enable = true; # Lightweight, keep immediate
      
      # Defer indent guides - not needed immediately
      indent-blankline = {
        enable = true;
        settings = {
          scope.enabled = false; # Disable expensive scope calculation
          debounce = 200; # Increase debounce time
        };
      };
      
      # Which-key - defer slightly as it's not needed immediately
      which-key = {
        enable = true;
        settings = {
          plugins.presets = {
            operators = false; # Disable some presets for faster load
            motions = false;
            text_objects = false;
          };
        };
      };
      
      # LuaSnip - load on demand
      luasnip = {
        enable = true;
        fromVscode = [];
      };
      
      # Mini modules - selective loading
      mini = {
        enable = true;
        modules = {
          icons = { }; # Empty config is fine for basic setup
        };
      };
      
      # Defer LSP signature
      lsp-signature = {
        enable = true;
        settings = {
          bind = false; # Don't bind immediately
          floating_window = false; # Start with floating window disabled
          timer_interval = 200; # Slower timer
        };
      };
    };
    
    # Lazy load external plugins
    extraPlugins = with pkgs.vimPlugins; [
      # These will be configured for lazy loading
      snacks-nvim
      leap-nvim
      vim-repeat
      plenary-nvim
      nvim-web-devicons
    ];
    
    # Import plugin configuration from Lua file
    extraConfigLua = builtins.readFile ../lua/plugins.lua;
  };
}
