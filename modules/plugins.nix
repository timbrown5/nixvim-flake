{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Plugin management with built-in NixVim plugins
    plugins = {
      # Core plugins with latest API
      treesitter = {
        enable = true;
        nixGrammars = true; # Use Nix-provided grammars
        settings.ensure_installed = [ "python" "lua" "nix" "c" "hcl" "terraform" ];
      };
      
      # Code utilities
      gitsigns.enable = true;
      comment.enable = true; # Fixed: using correct plugin name
      indent-blankline = {
        enable = true;
        settings.scope.enabled = true;
      };
      
      # Navigation and UI
      which-key.enable = true;
      
      # LuaSnip with latest API
      luasnip = {
        enable = true;
        fromVscode = [];
      };
      
      # Add mini.nvim plugins with correct format
      mini = {
        enable = true;
        modules = {
          # Each module is an attribute with its own config
          icons = { };  # Empty config is fine for basic setup
        };
      };
      
      # Use built-in LSP signature plugin
      lsp-signature = {
        enable = true;
        settings = {
          bind = true;
          handler_opts = {
            border = "rounded";
          };
        };
      };
    };
    
    # External plugins (only those not available as built-in)
    extraPlugins = with pkgs.vimPlugins; [
      # Plugins not available as built-in NixVim plugins
      snacks-nvim
      leap-nvim
      
      # Dependencies
      vim-repeat
      plenary-nvim
      
      # Icons
      nvim-web-devicons
      
      # Language support - only include if really needed
      vim-terraform  # Keep if specific features needed beyond treesitter
    ];
    
    # Plugin configuration with error handling
    extraConfigLua = ''
      -- Safe require function
      local function safe_require(module_name)
        local ok, module = pcall(require, module_name)
        if not ok then
          vim.notify("Failed to load " .. module_name .. ": " .. tostring(module), vim.log.levels.ERROR)
          return nil
        end
        return module
      end
      
      -- Snacks setup
      local snacks = safe_require('snacks')
      if snacks then
        snacks.setup {
          explorer = { width = 30, side = "left" },
          picker = { previewer = true }
        }
      end

      -- Leap setup
      local leap = safe_require('leap')
      if leap then
        leap.add_default_mappings()
      end
      
      -- Initialize web-devicons
      local devicons = safe_require('nvim-web-devicons')
      if devicons then
        devicons.setup()
      end
      
      -- Configure which-key to use mini.icons
      local which_key = safe_require('which-key')
      if which_key then
        which_key.setup({
          icons = {
            breadcrumb = "»", 
            separator = "➜", 
            group = "+", 
          },
          -- Add this to enable mini.icons integration
          plugins = {
            presets = {
              operators = true,
              motions = true,
              text_objects = true,
              windows = true,
              nav = true,
              z = true,
              g = true,
            },
          },
        })
      end
    '';
  };
}
