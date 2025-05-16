{ pkgs, ... }: {
  # Additional core plugins
  extraPlugins = with pkgs.vimPlugins; [
    # UI enhancements
    indent-blankline-nvim
    
    # Better quickfix
    trouble-nvim
    
    # Surround operations
    vim-surround
    
    # Better terminal
    toggleterm-nvim
  ];

  plugins = {
    # Icons support (explicitly enable to avoid warnings)
    web-devicons.enable = true;
    
    # Indent guides
    indent-blankline = {
      enable = true;
      settings = {
        scope = {
          enabled = true;
          show_start = true;
        };
      };
    };
    
    # Trouble for better diagnostics
    trouble = {
      enable = true;
      settings = {
        auto_close = true;
      };
      keymaps = {
        "<leader>xx" = {
          action = "toggle";
          desc = "Toggle diagnostics";
        };
        "<leader>xw" = {
          action = "toggle_workspace_diagnostics";
          desc = "Workspace diagnostics";
        };
        "<leader>xd" = {
          action = "toggle_document_diagnostics";
          desc = "Document diagnostics";
        };
        "<leader>xq" = {
          action = "toggle_quickfix";
          desc = "Quickfix list";
        };
      };
    };
    
    # Terminal with keybindings
    toggleterm = {
      enable = true;
      settings = {
        size = 15;
        open_mapping = "<leader>tt";
        direction = "float";
        shade_terminals = true;
      };
      # Terminal keybindings
      keymaps = {
        # Terminal navigation keys
        "<C-h>" = {
          action = "<C-\\><C-n><C-w>h";
          mode = "t";  # terminal mode
          desc = "Terminal navigate left";
        };
        "<C-j>" = {
          action = "<C-\\><C-n><C-w>j";
          mode = "t";
          desc = "Terminal navigate down";
        };
        "<C-k>" = {
          action = "<C-\\><C-n><C-w>k";
          mode = "t";
          desc = "Terminal navigate up";
        };
        "<C-l>" = {
          action = "<C-\\><C-n><C-w>l";
          mode = "t";
          desc = "Terminal navigate right";
        };
        "<Esc><Esc>" = {
          action = "<C-\\><C-n>";
          mode = "t";
          desc = "Terminal normal mode";
        };
      };
    };
    
    # Which key registrations
    which-key = {
      enable = true;
      settings = {
        delay = 500;
        plugins = {
          spelling = {
            enabled = true;
          };
        };
        window = {
          border = "rounded";
        };
      };
      registrations = {
        "<leader>f" = {
          name = "Find";
        };
        "<leader>g" = {
          name = "Git";
        };
        "<leader>t" = {
          name = "Terminal & Tabs";
        };
        "<leader>x" = {
          name = "Diagnostics";
        };
        "<leader>c" = {
          name = "Code";
        };
        "<leader>s" = {
          name = "Split & Snacks";
        };
      };
    };
  };
}
