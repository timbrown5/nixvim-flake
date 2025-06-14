{ pkgs, lib, ... }:
{
  plugins.precognition = {
    enable = true;
    settings = {
      startVisible = true;

      showBlankVirtLine = true;
      highlightColor.link = "Comment";

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

  keymaps = [
    {
      key = "<leader>vH";
      action = "<cmd>lua require('precognition').toggle()<CR>";
      mode = "n";
      options.desc = "Toggle motion hints";
    }
    {
      key = "<leader>vh";
      action = "<cmd>lua require('precognition').peek()<CR>";
      mode = "n";
      options.desc = "View motion hints (temporary)";
    }
  ];
}
