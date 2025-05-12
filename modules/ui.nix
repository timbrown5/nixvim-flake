{
  config,
  pkgs,
  lib,
  ...
}: let
  # Get theme from config
  theme = config.nixvim-config.theme or "catppuccin-macchiato";
  
  # Parse theme string
  themeParts = builtins.match "([a-z]+)(-[a-z]+)?" theme;
  themeBase = if themeParts != null then builtins.elemAt themeParts 0 else theme;
  themeVariant = if themeParts != null && builtins.length themeParts > 1 && builtins.elemAt themeParts 1 != null
                 then builtins.substring 1 (builtins.stringLength (builtins.elemAt themeParts 1)) (builtins.elemAt themeParts 1)
                 else null;
                 
  # Check if theme is the default Catppuccin theme
  isCatppuccin = themeBase == "catppuccin";
  
  # Default flavor for Catppuccin
  defaultFlavor = "macchiato";
in {
  # Options for themes using standard pattern
  options.nixvim-config = {
    theme = lib.mkOption {
      type = lib.types.str;
      description = "Color theme to use";
      default = "catppuccin-macchiato";
    };
  };
  
  # Colorscheme configuration based on theme
  config = {
    # Catppuccin theme configuration - minimal integrations for startup
    colorschemes.catppuccin = lib.mkIf isCatppuccin {
      enable = true;
      settings = {
        flavour = if themeVariant != null then themeVariant else defaultFlavor;
        # Reduce integrations for faster startup
        integrations = {
          cmp = false; # Load on demand
          gitsigns = false; # Load on demand
          treesitter = true; # Keep for syntax
          dap = {
            enable = false;
            enableUI = false;
          };
          native_lsp.enabled = true;
          indent_blankline.enabled = false;
          # Disable other integrations
          telescope = false;
          neotree = false;
          which_key = false;
        };
      };
    };
    
    # Custom theme configuration for non-catppuccin themes
    extraConfigLuaPre = lib.mkIf (!isCatppuccin) ''
      vim.cmd('packadd ${theme}')
      vim.cmd('colorscheme ${theme}')
    '';
    
    # Simplified loading screen - alpha is lighter than dashboard
    plugins.alpha = {
      enable = true;
      layout = [
        { type = "padding"; val = 2; }
        { 
          type = "text";
          val = [
            "Neovim"
          ];
          opts = {
            position = "center";
            hl = "Type";
          };
        }
        { type = "padding"; val = 1; }
        {
          type = "group";
          val = [
            {
              type = "button";
              val = "  [f] Files";
              on_press = "Snacks pick_files";
              opts = {
                position = "center";
                shortcut = "f";
                cursor = 3;
                width = 20;
                align_shortcut = "left";
                hl_shortcut = "Keyword";
              };
            }
            {
              type = "button";
              val = "  [e] Explorer";
              on_press = "Snacks explorer";
              opts = {
                position = "center";
                shortcut = "e";
                cursor = 3;
                width = 20;
                align_shortcut = "left";
                hl_shortcut = "Keyword";
              };
            }
          ];
        }
      ];
    };
    
    # Defer lualine - not needed immediately
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          globalstatus = true; # One statusline for all windows
          refresh = {
            statusline = 1000; # Refresh every second
            tabline = 1000;
            winbar = 1000;
          };
        };
        # Minimal sections
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch"];
          lualine_c = ["filename"];
          lualine_x = ["filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
        inactive_sections = {
          lualine_c = ["filename"];
          lualine_x = ["location"];
        };
      };
    };
    
    # Defer indent-blankline
    plugins.indent-blankline = {
      enable = true;
      settings = {
        enabled = true;
        debounce = 200; # Longer debounce
      };
    };
    
    # Defer loading of UI components
    extraConfigLua = ''
      -- Defer lualine setup to improve startup
      vim.defer_fn(function()
        local ok, lualine = pcall(require, 'lualine')
        if ok then
          lualine.setup()
        end
      end, 100)
      
      -- Defer indent-blankline
      vim.defer_fn(function()
        local ok, ibl = pcall(require, 'ibl')
        if ok then
          ibl.setup()
        end
      end, 150)
    '';
  };
}
