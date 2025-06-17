{ pkgs, lib, ... }:
{
  plugins.luasnip = {
    enable = true;

    # Load friendly-snippets and user snippets
    fromVscode = [
      {
        lazyLoad = true;
        paths = "${pkgs.vimPlugins.friendly-snippets}";
      }
      {
        lazyLoad = true;
        paths = "~/.config/nvim/snippets";
      }
    ];
  };

  # Add friendly-snippets and nvim-scissors as dependencies
  extraPlugins = with pkgs.vimPlugins; [
    friendly-snippets
    nvim-scissors
  ];

  # Basic navigation keybindings
  keymaps = [
    # Expand or jump forward
    {
      key = "<Tab>";
      action = "<cmd>lua require('luasnip').expand_or_jump()<CR>";
      mode = [
        "i"
        "s"
      ];
      options = {
        desc = "Expand snippet or jump forward";
        silent = true;
      };
    }

    # Jump backward
    {
      key = "<S-Tab>";
      action = "<cmd>lua require('luasnip').jump(-1)<CR>";
      mode = [
        "i"
        "s"
      ];
      options = {
        desc = "Jump backward in snippet";
        silent = true;
      };
    }

    # Edit snippets (convenience keymap)
    {
      key = "<leader>se";
      action = "<cmd>lua require('scissors').editSnippet()<CR>";
      mode = "n";
      options.desc = "Edit snippets";
    }

    # Add snippet from visual selection (nvim-scissors)
    {
      key = "<leader>sa";
      action = "<cmd>lua require('scissors').addNewSnippet()<CR>";
      mode = [
        "n"
        "x"
      ];
      options.desc = "Add new snippet (prefills from selection in visual mode)";
    }
  ];

  # Reference the external snippet files
  extraFiles = {
    "snippets/lua/codecompanion.snippets".source = ../snippets/lua/codecompanion.snippets;
    "snippets/lua/codecompanion-providers.snippets".source =
      ../snippets/lua/codecompanion-providers.snippets;
    "snippets/all/global.snippets".source = ../snippets/all/global.snippets;
  };

  extraConfigLua = lib.mkAfter ''
    -- Create user snippet directories
    local snippet_dir = vim.fn.stdpath("config") .. "/snippets"
    vim.fn.mkdir(snippet_dir, "p")

    -- Configure nvim-scissors
    require("scissors").setup({
      snippetDir = snippet_dir,
      -- Use telescope if available (you have snacks.nvim picker)
      editSnippetPopup = {
        height = 0.4,
        width = 0.6,
        border = "rounded",
      },
    })
  '';
}
