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
        quickfile.enabled = true;
        indent.enabled = true;
        scope.enabled = true;

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

        indent = {
          char = "│";
          priority = 1;
          exclude_filetypes = [
            "help"
            "dashboard"
            "lazy"
            "mason"
            "notify"
            "snacks_dashboard"
            "snacks_notif"
            "snacks_notif_history"
            "snacks_terminal"
            "snacks_win"
          ];

          scope = {
            enabled = true;
            priority = 200;
            char = "│";
            underline = false;
            only_current = false;
            hl = "SnacksIndentScope";
          };

          chunk = {
            enabled = true;
            only_current = false;
            priority = 200;
            hl = "SnacksIndentChunk";
            char = {
              corner_top = "╭";
              corner_bottom = "╰";
              horizontal = "─";
              vertical = "│";
              arrow = ">";
            };
          };
        };

        terminal = {
          enabled = true;
          direction = "bottom";
          shell = "bash";
          size = {
            height = 0.25;
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

    extraFiles."lua/plugins/snacks.lua".source = ../lua/plugins/snacks.lua;

    extraConfigLua = lib.mkAfter ''
      require('plugins.snacks')

      vim.g.snacks_indent = true
      vim.g.snacks_scope = true
    '';
  };
}
