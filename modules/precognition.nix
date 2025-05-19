# In modules/precognition.nix

{ pkgs, lib, ... }:
{
  plugins.precognition = {
    enable = true;
    settings = {
      # Enable on startup
      startVisible = true;

      # Display settings
      showBlankVirtLine = true;
      highlightColor.link = "Comment";

      # Horizontal motion hints
      hints = {
        Caret.text = "^";
        Caret.prio = 2;

        Dollar.text = "$";
        Dollar.prio = 1;

        MatchingPair.text = "%";
        MatchingPair.prio = 5;

        Zero.text = "0";
        Zero.prio = 1;

        w.text = "w";
        w.prio = 10;

        b.text = "b";
        b.prio = 9;

        e.text = "e";
        e.prio = 8;

        W.text = "W";
        W.prio = 7;

        B.text = "B";
        B.prio = 6;

        E.text = "E";
        E.prio = 5;
      };

      # Vertical motion hints
      gutterHints = {
        G.text = "G";
        G.prio = 10;

        gg.text = "gg";
        gg.prio = 9;

        PrevParagraph.text = "{";
        PrevParagraph.prio = 8;

        NextParagraph.text = "}";
        NextParagraph.prio = 8;
      };

      # Disable in these file types
      disabled_fts = [
        "help"
        "dashboard"
        "lazy"
        "mason"
        "notify"
        "NvimTree"
        "terminal"
      ];
    };
  };

  # Add toggle and peek keybindings
  keymaps = [
    {
      key = "<leader>pp";
      action = "require('precognition').toggle()";
      mode = "n";
      lua = true;
      options.desc = "Toggle Precognition";
    }

    {
      key = "<leader>po";
      action = "require('precognition').peek()";
      mode = "n";
      lua = true;
      options.desc = "Peek Precognition (temporary)";
    }
  ];

  # Add to which-key
  extraConfigLua = ''
    -- Register precognition commands with which-key
    local ok, which_key = pcall(require, "which-key")
    if ok then
      which_key.register({
        p = { 
          name = "Precognition",
          p = "Toggle Precognition",
          o = "Peek Precognition"
        }
      }, { prefix = "<leader>" })
    end
  '';
}
