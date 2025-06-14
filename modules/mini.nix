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
            pair = "\"\"";
            neigh_pattern = "[^\\].";
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
          add = "<leader>sa"; # Plugin-agnostic: surround add
          delete = "<leader>sd"; # Plugin-agnostic: surround delete
          replace = "<leader>sr"; # Plugin-agnostic: surround replace
          find = "<leader>sf"; # Plugin-agnostic: surround find
          find_left = "<leader>sF"; # Plugin-agnostic: surround find backward
          highlight = "<leader>sh"; # Plugin-agnostic: surround highlight
          update_n_lines = "<leader>sn"; # Plugin-agnostic: surround n-lines
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
            pattern = "%b\"\"";
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
          comment = "gc"; # Plugin-agnostic: general comment
          comment_line = "gcc"; # Plugin-agnostic: general comment line
          comment_visual = "gc"; # Plugin-agnostic: general comment visual
          textobject = "gc"; # Plugin-agnostic: general comment text object
        };
      };
    };
  };
}
