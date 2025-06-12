{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.nvchad;
in
{
  options.nvchad = {
    enable = lib.mkEnableOption "Enable NvChad Neovim UI";
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = with pkgs.vimPlugins; [
      nvchad
      nvchad-ui
      catppuccin-nvim
      nvim-web-devicons
    ];

    extraConfigVim = ''
      set runtimepath^=${pkgs.vimPlugins.nvchad}
      set runtimepath^=${pkgs.vimPlugins.nvchad-ui}
    '';

    extraConfigLuaPre = ''
      local data_dir = vim.fn.stdpath("data")
      vim.g.base46_cache = data_dir .. "/nvchad/base46/"
      vim.g.nvchad_theme = "catppuccin"
      vim.fn.mkdir(data_dir .. "/nvchad/base46", "p")
    '';

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "macchiato";
        transparent_background = true;
        no_italic = false;

        styles = {
          comments = [ "italic" ];
          conditionals = [ ];
          loops = [ ];
          functions = [ ];
          keywords = [ "italic" ];
          strings = [ "italic" ];
          variables = [ "italic" ];
          numbers = [ ];
          booleans = [ "italic" ];
          properties = [ ];
          types = [ "italic" ];
          operators = [ "italic" ];
        };

        dim_inactive = {
          enabled = false;
          percentage = 0.15;
        };

        integrations = {
          nvimtree = true;
          telescope = true;
          treesitter = true;
          gitsigns = true;
          which_key = true;
          native_lsp = {
            enabled = true;
            virtual_text = {
              errors = [ "italic" ];
              hints = [ "italic" ];
              warnings = [ "italic" ];
              information = [ "italic" ];
            };
            underlines = {
              errors = [ "underline" ];
              hints = [ "underline" ];
              warnings = [ "underline" ];
              information = [ "underline" ];
            };
          };
          cmp = true;
          dap = {
            enabled = true;
            enable_ui = true;
          };
          notify = true;
        };
      };
    };

    extraConfigLua = ''
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "@parameter", { italic = true })
          vim.api.nvim_set_hl(0, "@attribute", { italic = true })
          vim.api.nvim_set_hl(0, "@variable.builtin", { italic = true })
          vim.api.nvim_set_hl(0, "@keyword.function", { italic = true })
          vim.api.nvim_set_hl(0, "@keyword.return", { italic = true })
          vim.api.nvim_set_hl(0, "@type.builtin", { italic = true })
          vim.api.nvim_set_hl(0, "@type.definition", { italic = true })
          vim.api.nvim_set_hl(0, "@type.qualifier", { italic = true })
          
          local colors = require("catppuccin.palettes").get_palette()
          vim.api.nvim_set_hl(0, "LineNr", { 
            fg = colors.blue,
            bold = true 
          })
          
          vim.api.nvim_set_hl(0, "CursorLineNr", { 
            fg = colors.yellow,
            bold = true 
          })
          
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        end
      })
    '';
  };
}
