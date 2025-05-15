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
    
    # LSP configuration
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
    };
    
    # Comments
    comment.enable = true;
    
    # Auto pairs
    nvim-autopairs.enable = true;
    
    # Which key
    which-key = {
      enable = true;
      settings = {
        delay = 500;
      };
    };
  };
}
