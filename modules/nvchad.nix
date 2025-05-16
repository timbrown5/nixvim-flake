{ pkgs, ... }: {
  # NvChad configuration
  extraPlugins = with pkgs.vimPlugins; [
    # Core NvChad packages
    nvchad
    nvchad-ui
    
    # Theme
    catppuccin-nvim
    
    # Utilities
    snacks-nvim
    
    # Dependencies that NvChad expects
    plenary-nvim
    nvim-web-devicons
  ];

  # Ensure NvChad is loaded properly
  extraConfigVim = ''
    " Set runtimepath for NvChad
    set runtimepath^=${pkgs.vimPlugins.nvchad}
    set runtimepath^=${pkgs.vimPlugins.nvchad-ui}
  '';
  
  # Pre-configuration to ensure NvChad directories exist
  extraConfigLuaPre = ''
    -- Create necessary directories for NvChad (using official path style)
    local data_dir = vim.fn.stdpath("data")
    
    -- Set global variables for NvChad
    vim.g.base46_cache = data_dir .. "/nvchad/base46/"
    vim.g.nvchad_theme = "catppuccin"
    
    -- Create required directories
    vim.fn.mkdir(data_dir .. "/nvchad/base46", "p")
  '';

  # Theme configuration - using catppuccin
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "macchiato";
      transparent_background = false;
      integrations = {
        nvimtree = true;
        telescope = true;
        treesitter = true;
        gitsigns = true;
        which_key = true;
      };
    };
  };

  # UI components that work with NvChad
  plugins = {
    # Status line (NvChad uses its own statusline)
    lualine.enable = false;
    
    # Snacks.nvim for utilities including explorer and picker
    snacks = {
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
        # Image rendering support
        image = {
          enabled = true;
          backend = "kitty";  # Using kitty graphics protocol
          max_width = 100;    # Maximum width as percentage of window
          max_height = 25;    # Maximum height as percentage of window
          window = "float";   # Show images in floating window
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
      # Add Snacks keybindings
      keymaps = {
        # File explorer
        "<C-n>" = {
          action = "explorer.toggle";
          desc = "Toggle file explorer";
        };
        "<leader>e" = {
          action = "explorer.focus";
          desc = "Focus file explorer";
        };
        
        # Picker (fuzzy finding)
        "<leader>ff" = {
          action = "picker.files";
          desc = "Find files";
        };
        "<leader>fw" = {
          action = "picker.grep";
          desc = "Live grep"; 
        };
        "<leader>fb" = {
          action = "picker.buffers";
          desc = "Find buffers";
        };
        "<leader>fh" = {
          action = "picker.help";
          desc = "Find help";
        };
        "<leader>fr" = {
          action = "picker.recent_files";
          desc = "Recent files";
        };
        "<leader>fd" = {
          action = "picker.diagnostics";
          desc = "Diagnostics";
        };
        "<leader>fs" = {
          action = "picker.symbols";
          desc = "Symbols";
        };
        "<leader>fc" = {
          action = "picker.commands";
          desc = "Commands";
        };
        "<leader>fk" = {
          action = "picker.keymaps";
          desc = "Keymaps";
        };
        
        # Git operations
        "<leader>gc" = {
          action = "picker.git_commits";
          desc = "Git commits";
        };
        "<leader>gb" = {
          action = "picker.git_branches";
          desc = "Git branches";
        };
        "<leader>gs" = {
          action = "picker.git_status";
          desc = "Git status";
        };
        
        # Notifications
        "<leader>sn" = {
          action = "notifier.show_history";
          desc = "Show notification history";
        };
        "<leader>sd" = {
          action = "notifier.dismiss";
          desc = "Dismiss notifications";
        };
        "<leader>st" = {
          action = "notifier.notify('This is a test notification', 'info')";
          desc = "Test notification";
        };
        
        # Image preview
        "<leader>si" = {
          action = "image.show_current_file";
          desc = "Show image preview";
        };
        "<leader>sc" = {
          action = "image.show_clipboard";
          desc = "Show clipboard image";
        };
      };
    };
    
    # Git integration  
    gitsigns.enable = true;
    
    # Syntax highlighting
    treesitter = {
      enable = true;
      settings = {
        indent.enable = true;
        ensure_installed = [
          "lua"
          "vim"
          "vimdoc"
          "nix"
          "markdown"
          "javascript"
          "typescript"
          "python"
        ];
      };
    };
    
    # Completion (using blink.cmp as it's more modern)
    blink-cmp = {
      enable = true;
    };
    
    # LSP configuration with keybindings
    lsp = {
      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics = {
                globals = [ "vim" ];
              };
              workspace = {
                library = [
                  "\${third_party}/luassert/library"
                ];
              };
            };
          };
        };
        nil_ls.enable = true;
        pyright.enable = true;
        ts_ls.enable = true;
      };
      # Add LSP keybindings
      keymaps = {
        lspBuf = {
          # LSP buffer operations using Snacks picker
          "gd" = {
            lua = "Snacks.picker.lsp_definitions()";
            desc = "Go to definition";
          };
          "gr" = {
            lua = "Snacks.picker.lsp_references()";
            desc = "Go to references";
          };
          "gi" = {
            lua = "Snacks.picker.lsp_implementations()";
            desc = "Go to implementation";
          };
          "gt" = {
            lua = "Snacks.picker.lsp_type_definitions()";
            desc = "Go to type definition";
          };
          
          # Standard LSP operations
          "K" = {
            action = "hover";
            desc = "Hover documentation";
          };
          "<leader>ca" = {
            action = "code_action";
            desc = "Code action";
          };
          "<leader>rn" = {
            action = "rename";
            desc = "Rename";
          };
          "<leader>f" = {
            action = "format";
            desc = "Format document";
          };
        };
        diagnostic = {
          # Diagnostic navigation
          "[d" = {
            action = "goto_prev";
            desc = "Previous diagnostic";
          };
          "]d" = {
            action = "goto_next";
            desc = "Next diagnostic";
          };
          "<leader>df" = {
            action = "open_float";
            desc = "Show diagnostic float";
          };
        };
      };
    };
    
    # Comments
    comment.enable = true;
    
    # Auto pairs
    nvim-autopairs.enable = true;
  };
}
