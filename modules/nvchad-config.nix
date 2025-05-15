{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Core options
    globals.mapleader = " ";
    
    # Add NvChad packages
    extraPlugins = with pkgs.vimPlugins; [
      nvchad
      nvchad-ui
    ];
    
    # Basic options that work well with NvChad
    opts = {
      termguicolors = true;
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      laststatus = 3;  # Global statusline
      showmode = false;
    };
    
    # Copy Lua files to the runtime path
    files."lua/config/nvchad-init.lua".source = ../lua/config/nvchad-init.lua;
    files."lua/config/keybindings.lua".source = ../lua/config/keybindings.lua;
    
    # Load Lua configuration files
    extraConfigLua = ''
      -- Load NvChad initialization
      require("config.nvchad-init")
      
      -- Load keybindings
      require("config.keybindings")
    '';
    
    # Minimal additional plugins that complement NvChad
    plugins = {
      # Treesitter for syntax highlighting
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      
      # LSP
      lsp = {
        enable = true;
        servers = {
          lua_ls = {
            enable = true;
            settings.Lua.diagnostics.globals = [ "vim" ];
          };
          nil_ls.enable = true;
          pyright.enable = true;
        };
      };
      
      # Blink.cmp for completion (replacing nvim-cmp)
      blink-cmp = {
        enable = true;
        settings = {
          fuzzy = {
            prebuiltBinaries = {
              download = false;  # Use Nix-built binaries
            };
          };
          sources = {
            default = [ "lsp" "path" "buffer" ];
            providers = {
              lsp = {
                name = "lsp";
                module = "blink.cmp.sources.lsp";
              };
              path = {
                name = "path";
                module = "blink.cmp.sources.path";
                opts = {
                  trailing_slash = false;
                  label_trailing_slash = true;
                  get_cwd = "vim.fn.getcwd";
                  show_hidden_files_by_default = false;
                };
              };
              buffer = {
                name = "buffer";
                module = "blink.cmp.sources.buffer";
              };
            };
          };
          completion = {
            documentation = {
              auto_show = true;
              window = {
                border = "rounded";
              };
            };
            menu = {
              draw = {
                columns = [
                  { label = "label_description"; gap = 1; }
                  { kind_icon = "kind"; }
                ];
              };
            };
            accept = {
              auto_brackets = {
                enabled = true;
              };
            };
          };
          appearance = {
            nerd_font_variant = "mono";
          };
          keymap = {
            preset = "default";
            "<C-space>" = { show = {}; };
            "<C-e>" = { hide = {}; };
            "<Tab>" = { select_next = { fallback = {}; }; };
            "<S-Tab>" = { select_prev = { fallback = {}; }; };
            "<Up>" = { select_prev = { fallback = {}; }; };
            "<Down>" = { select_next = { fallback = {}; }; };
            "<C-p>" = { select_prev = {}; };
            "<C-n>" = { select_next = {}; };
            "<C-b>" = { scroll_documentation_up = { fallback = {}; }; };
            "<C-f>" = { scroll_documentation_down = { fallback = {}; }; };
            "<CR>" = { accept = { fallback = {}; }; };
          };
        };
      };
      
      # File tree (NvChad includes this usually)
      nvim-tree = {
        enable = true;
        settings = {
          adaptive_size = true;
          git.enable = true;
          filters.dotfiles = false;
        };
      };
      
      # Git signs
      gitsigns.enable = true;
      
      # Which-key
      which-key = {
        enable = true;
        settings = {
          delay = 0;
          preset = "modern";
        };
      };
      
      # Snacks.nvim - modern utilities including picker
      snacks-nvim = {
        enable = true;
        settings = {
          picker = {
            enabled = true;
            layout = {
              preset = "default";  # or "telescope", "vertical", etc.
              reverse = false;
            };
          };
          # Optional: enable other snacks modules
          explorer = { enabled = false; };  # Use nvim-tree for now
          dashboard = { enabled = false; };  # Keep NvChad dashboard
        };
      };
    };
  };
}
