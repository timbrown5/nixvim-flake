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
    # Catppuccin theme configuration - load immediately with all integrations
    colorschemes.catppuccin = lib.mkIf isCatppuccin {
      enable = true;
      settings = {
        flavour = if themeVariant != null then themeVariant else defaultFlavor;
        # Enable all integrations for proper initial display
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
          which_key = true;
          telescope = true;
          neotree = true;
          leap = true;
          dashboard = true;
          notify = true;
          mini = true;
        };
      };
    };
    
    # Custom theme configuration for non-catppuccin themes
    # Load immediately in extraConfigLuaPre
    extraConfigLuaPre = lib.mkIf (!isCatppuccin) ''
      vim.cmd('packadd ${theme}')
      vim.cmd('colorscheme ${theme}')
    '';
    
    # We'll set up Snacks dashboard in the Lua config
    # Remove alpha plugin configuration
    
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
  };
}
