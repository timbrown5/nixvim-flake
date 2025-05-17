{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.customPlugins.snacks;
in
{
  options.customPlugins.snacks = {
    enable = lib.mkEnableOption "Enable Snacks.nvim components";
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = with pkgs.vimPlugins; [
      snacks-nvim
      plenary-nvim
    ];

    plugins.snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        notifier = {
          enabled = true;
          render = "modern";
          timeout = 3000;
          icons = {
            error = "";
            warn = "";
            info = "";
            debug = "";
            trace = "✎";
          };
        };
        quickfile.enabled = true;

        indent = {
          enabled = true;
          # Using a table for scope fixes the error from paste.txt
          scope = {
            enabled = true;
            color = "CatppuccinaBlue";
          };
          char = "│";
          exclude_filetypes = [
            "help"
            "dashboard"
            "lazy"
            "mason"
            "notify"
          ];
          highlight = [
            "CatppuccinaSubtext0"
            "CatppuccinaBlue"
          ];
          smart_indent = true;
          scope_start = true;
          line_num = true;
        };

        terminal = {
          enabled = true;
          direction = "float";
          shell = "bash";
          size = {
            width = 0.8;
            height = 0.8;
          };
          border = "rounded";
          mappings = {
            toggle = "<leader>tt";
          };
        };

        image = {
          enabled = true;
          backend = "kitty";
          max_width = 100;
          max_height = 25;
          window = "float";
        };
        explorer = {
          enabled = true;
          position = "left";
          width = 30;
          icons = {
            closed = "";
            open = "";
            file = "";
            folder = "";
            folder_open = "";
          };
        };
        picker = {
          sources = {
            files = {
              hidden = true;
              follow = true;
              show_ignored = false;
            };
            grep = {
              hidden = true;
              follow = true;
            };
          };
        };
      };
    };

    extraPackages = with pkgs; [
      ripgrep
      fd

      imagemagick
      ghostscript
      tectonic
      mermaid-cli
    ];

    extraFiles."lua/plugins/snacks-keybinds.lua".source = ../lua/plugins/snacks-keybinds.lua;

    extraConfigLua = lib.mkAfter ''
      require('plugins.snacks-keybinds')
    '';
  };
}
