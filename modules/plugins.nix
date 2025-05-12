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
    
    # Optimized plugin configuration with lazy loading
    extraConfigLua = ''
      -- Defer plugin loading
      vim.schedule(function()
        -- Load Snacks after startup
        local ok, snacks = pcall(require, 'snacks')
        if ok then
          snacks.setup({
            explorer = { 
              width = 30, 
              side = "left",
              -- Don't auto-open
              auto_open = false,
            },
            picker = { 
              previewer = true,
              -- Reduce initial buffer size
              initial_mode = "insert",
            }
          })
        end
        
        -- Load web-devicons after startup
        local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
        if devicons_ok then
          devicons.setup()
        end
      end)
      
      -- Lazy load Leap on first use
      vim.api.nvim_create_autocmd("CmdlineEnter", {
        pattern = "*",
        once = true,
        callback = function()
          local leap_ok, leap = pcall(require, 'leap')
          if leap_ok then
            leap.add_default_mappings()
          end
        end
      })
      
      -- Defer which-key setup
      vim.defer_fn(function()
        local which_key_ok, which_key = pcall(require, 'which-key')
        if which_key_ok then
          which_key.setup({
            icons = {
              breadcrumb = "»", 
              separator = "➜", 
              group = "+", 
            },
            -- Minimal presets for faster startup
            plugins = {
              presets = {
                operators = false,
                motions = false,
                text_objects = true,
                windows = true,
                nav = true,
                z = true,
                g = true,
              },
            },
          })
        end
      end, 50) -- Defer by 50ms
    '';
  };
}
