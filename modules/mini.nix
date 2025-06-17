{ pkgs, lib, ... }:
{
  plugins.mini = {
    enable = true;
    modules = {
      pairs = {
        modes = {
          insert = true;
          command = false;
          terminal = false;
        };
        mappings = {
          "(" = {
            action = "open";
            pair = "()";
            neigh_pattern = "[^\\].";
          };
          "[" = {
            action = "open";
            pair = "[]";
            neigh_pattern = "[^\\].";
          };
          "{" = {
            action = "open";
            pair = "{}";
            neigh_pattern = "[^\\].";
          };
          ")" = {
            action = "close";
            pair = "()";
            neigh_pattern = "[^\\].";
          };
          "]" = {
            action = "close";
            pair = "[]";
            neigh_pattern = "[^\\].";
          };
          "}" = {
            action = "close";
            pair = "{}";
            neigh_pattern = "[^\\].";
          };
          "\"" = {
            action = "closeopen";
            pair = ''""'';
            neigh_pattern = "[^\\a].";
          };
          "'" = {
            action = "closeopen";
            pair = "''";
            neigh_pattern = "[^%a\\].";
          };
          "`" = {
            action = "closeopen";
            pair = "``";
            neigh_pattern = "[^\\].";
          };
        };
      };
      icons = {
        use_default_for = [
          "kind"
          "diagnostic"
          "git"
          "ui"
        ];
        lsp.kind.enabled = true;
      };
      surround = {
        mappings = {
          add = "<leader>sa";
          delete = "<leader>sd";
          replace = "<leader>sr";
          find = "<leader>sf";
          find_left = "<leader>sF";
          highlight = "<leader>sh";
          update_n_lines = "<leader>sn";
        };
      };
      ai = {
        n_lines = 50;
        custom_textobjects = {
          o = {
            pattern = "%b()";
          };
          c = {
            pattern = "%b{}";
          };
          b = {
            pattern = "%b[]";
          };
          q = {
            pattern = ''%b""'';
          };
          "*" = {
            pattern = "%b**";
          };
        };
        search_method = "cover_or_nearest";
      };
      jump = {
        mappings = {
          forward = "f";
          backward = "F";
          forward_till = "t";
          backward_till = "T";
          forward_repeat = ";";
          backward_repeat = ",";
        };
        highlight_duration = 500;
      };
      comment = {
        options = {
          custom_commentstring = null;
          ignore_blank_line = true;
          start_of_line = false;
          pad_comment_parts = true;
        };
        mappings = {
          comment = "gc";
          comment_line = "gcc";
          comment_visual = "gc";
          textobject = "gc";
        };
      };
    };
  };

  # Provide both namespaced surround operations and standard vim-surround keys for muscle memory
  keymaps = [
    {
      key = "sa";
      action = "<leader>sa";
      mode = "n";
      options.desc = "Surround add (standard key)";
    }
    {
      key = "sd";
      action = "<leader>sd";
      mode = "n";
      options.desc = "Surround delete (standard key)";
    }
    {
      key = "sr";
      action = "<leader>sr";
      mode = "n";
      options.desc = "Surround replace (standard key)";
    }
    {
      key = "sf";
      action = "<leader>sf";
      mode = "n";
      options.desc = "Surround find (standard key)";
    }
    {
      key = "sa";
      action = "<leader>sa";
      mode = "v";
      options.desc = "Surround add selection";
    }
  ];
}
