{
  config,
  pkgs,
  lib,
  ...
}: let
  # Get theme from config
  theme = config._custom.theme or "catppuccin-macchiato";
  
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
  # _custom options for themes
  options._custom = {
    theme = lib.mkOption {
      type = lib.types.str;
      description = "Color theme to use";
      default = "catppuccin-macchiato";
    };
    
    customPkgs = lib.mkOption {
      type = lib.types.attrs;
      description = "Custom package set from overlay";
      default = pkgs;
    };
  };
  
  # Colorscheme configuration based on theme
  config = {
    # Catppuccin theme configuration with updated settings path
    colorschemes.catppuccin = lib.mkIf isCatppuccin {
      enable = true;
      settings = {
        flavour = if themeVariant != null then themeVariant else defaultFlavor;
        integrations = {
          cmp = true;
          gitsigns = true;
          treesitter = true;
          dap = {
            enable = true;
            enableUI = true;
          };
          native_lsp.enabled = true;
          indent_blankline.enabled = true;
        };
      };
    };
    
    # Custom theme configuration for non-catppuccin themes
    extraConfigLuaPre = lib.mkIf (!isCatppuccin) ''
      vim.cmd('packadd ${theme}')
      vim.cmd('colorscheme ${theme}')
    '';
    
    # Loading screen with dashboard-nvim
    plugins.alpha = {
      enable = true;
      layout = [
        { type = "padding"; val = 2; }
        { 
          type = "text";
          val = [
            "██████╗ ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
            "██╔══██╗██║╚██╗██╔╝██║   ██║██║████╗ ████║"
            "██████╔╝██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
            "██╔═══╝ ██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
            "██║     ██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
            "╚═╝     ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ];
          opts = {
            position = "center";
            hl = "Type";
          };
        }
        { type = "padding"; val = 2; }
        {
          type = "group";
          val = [
            {
              type = "button";
              val = "  Files";
              on_press = "Snacks pick_files";
              opts = {
                position = "center";
                shortcut = "f";
                cursor = 3;
                width = 30;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            }
            {
              type = "button";
              val = "  Explorer";
              on_press = "Snacks explorer";
              opts = {
                position = "center";
                shortcut = "e";
                cursor = 3;
                width = 30;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            }
          ];
          opts = {
            spacing = 1;
          };
        }
      ];
    };
    
    # Status line and indentation guides
    plugins.lualine.enable = true;
    plugins.indent-blankline.enable = true;
  };
}
