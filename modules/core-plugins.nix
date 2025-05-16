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
    snipe-nvim
    
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

  # Theme configuration - comprehensive Catppuccin setup
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      # Base theme settings
      flavour = "macchiato";
      transparent_background = true;
      no_italic = false;
      
      # Italic styling for syntax elements
      styles = {
        comments = [ "italic" ];
        conditionals = [ "italic" ];
        loops = [ "italic" ];
        functions = [ "italic" ];
        keywords = [ "italic" ];
        strings = [ ];
        variables = [ ];
        numbers = [ ];
        booleans = [ ];
        properties = [ ];
        types = [ "italic" ];
        operators = [ "italic" ];
      };
      
      # Inactive window transparency (90% opacity)
      dim_inactive = {
        enabled = true;
        percentage = 0.1;
      };
      
      # Plugin integrations
      integrations = {
        nvimtree = true;
        telescope = true;
        treesitter = true;
        gitsigns = true;
        which_key = true;
        native_lsp = {
          enabled = true;
          virtual_text = {
            errors = [ "italic" ];
            hints = [ "italic" ];
            warnings = [ "italic" ];
            information = [ "italic" ];
          };
          underlines = {
            errors = [ "underline" ];
            hints = [ "underline" ];
            warnings = [ "underline" ];
            information = [ "underline" ];
          };
        };
        cmp = true;
        dap = {
          enabled = true;
          enable_ui = true;
        };
        notify = true;
      };
    };
  };

  # UI components that work with NvChad
  plugins = {
    # Status line (NvChad uses its own statusline)
    lualine.enable = false;
    
    # Snacks.nvim - using NixVim's declarative config for everything except keymaps
    # Note: Keymaps are configured via Lua (lua/plugins/snacks-keybinds.lua) because
    # the NixVim module doesn't support the keymaps option.
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
        
        # Using Snacks.indent instead of indent-blankline-nvim
        indent = {
          enabled = true;
          scope = true;                   # Show scope guides
          char = "│";                     # Character for indent lines
          exclude_filetypes = ["help" "dashboard" "lazy" "mason" "notify"];
          highlight = [
            "CatppuccinaSubtext0"       # Base indent color from Catppuccin palette
            "CatppuccinaBlue"           # Contextual indentation color for scope
          ];
          smart_indent = true;            # Smarter indentation rules
          scope_start = true;             # Show line at scope start
          line_num = false;               # Don't show on line number column
        };
        
        # Using Snacks.terminal instead of toggleterm
        terminal = {
          enabled = true;
          direction = "float";            # Floating terminal window
          shell = "bash";                 # Default shell
          size = {
            width = 0.8;                  # 80% of window width
            height = 0.8;                 # 80% of window height 
          };
          border = "rounded";             # Border style
          mappings = {
            toggle = "<leader>tt";        # Toggle terminal
          };
        };
        
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
     
      keymaps = {
        lspBuf = {
          # Keep traditional Vim-style navigation (with Snacks picker)
          "gd" = {
            action = "Snacks.picker.lsp_definitions()";
            desc = "Go to definition";
          };
          "gr" = {
            action = "Snacks.picker.lsp_references()";
            desc = "Go to references";
          };
          "gi" = {
            action = "Snacks.picker.lsp_implementations()";
            desc = "Go to implementation";
          };
          "gt" = {
            action = "Snacks.picker.lsp_type_definitions()";
            desc = "Go to type definition";
          };
          
          # Standard hover shortcut
          "K" = {
            action = "hover";
            desc = "Hover documentation";
          };
          
          # New namespaced LSP commands
          "<leader>ld" = {
            action = "Snacks.picker.lsp_definitions()";
            desc = "LSP: Go to definition";
          };
          "<leader>lr" = {
            action = "Snacks.picker.lsp_references()";
            desc = "LSP: Go to references";
          };
          "<leader>li" = {
            action = "Snacks.picker.lsp_implementations()";
            desc = "LSP: Go to implementation";
          };
          "<leader>lt" = {
            action = "Snacks.picker.lsp_type_definitions()";
            desc = "LSP: Go to type definition";
          };
          "<leader>lh" = {
            action = "hover";
            desc = "LSP: Hover documentation";
          };
          "<leader>la" = {
            action = "code_action";
            desc = "LSP: Code action";
          };
          "<leader>ln" = {
            action = "rename";
            desc = "LSP: Rename";
          };
          "<leader>lf" = {
            action = "format";
            desc = "LSP: Format document";
          };
          "<leader>ls" = {
            action = "signature_help";
            desc = "LSP: Signature help";
          };
          
          # Move these from <leader>ca/rn to fully namespaced versions
          # While keeping the old bindings for compatibility
          "<leader>ca" = {
            action = "code_action";
            desc = "Code action";
          };
          "<leader>rn" = {
            action = "rename";
            desc = "Rename";
          };
          
          "<leader>lwa" = {
            action = "add_workspace_folder";
            desc = "LSP: Add workspace folder";
          };
          "<leader>lwr" = {
            action = "remove_workspace_folder";
            desc = "LSP: Remove workspace folder";
          };
          "<leader>lwl" = {
            action = "print(vim.inspect(vim.lsp.buf.list_workspace_folders()))";
            desc = "LSP: List workspace folders";
          };
        };
        
        diagnostic = {
          # Keep traditional next/prev diagnostics
          "[d" = {
            action = "goto_prev";
            desc = "Previous diagnostic";
          };
          "]d" = {
            action = "goto_next";
            desc = "Next diagnostic";
          };
          
          # Add namespaced versions
          "<leader>dp" = {
            action = "goto_prev";
            desc = "Diagnostics: Previous";
          };
          "<leader>dn" = {
            action = "goto_next";
            desc = "Diagnostics: Next";
          };
          "<leader>df" = {
            action = "open_float";
            desc = "Diagnostics: Float";
          };
          "<leader>dl" = {
            action = "Snacks.picker.diagnostics()";
            desc = "Diagnostics: List";
          };
          "<leader>dq" = {
            action = "setloclist";
            desc = "Diagnostics: To quickfix";
          };
        };
      };
    };
    
    # Comments
    comment.enable = true;
    
    # Auto pairs
    nvim-autopairs.enable = true;
  };
  
  # Add specific treesitter highlight settings not covered by Catppuccin
  extraConfigLua = ''
    -- Add specific treesitter highlight settings that aren't covered by Catppuccin config
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Additional syntax elements that benefit from italics
        vim.api.nvim_set_hl(0, "@parameter", { italic = true })
        vim.api.nvim_set_hl(0, "@attribute", { italic = true })
        vim.api.nvim_set_hl(0, "@variable.builtin", { italic = true })
        vim.api.nvim_set_hl(0, "@keyword.function", { italic = true })
        vim.api.nvim_set_hl(0, "@keyword.return", { italic = true })
        vim.api.nvim_set_hl(0, "@type.builtin", { italic = true })
        vim.api.nvim_set_hl(0, "@type.definition", { italic = true })
        vim.api.nvim_set_hl(0, "@type.qualifier", { italic = true })
        
        -- Line number colors using Catppuccin's palette
        -- Get Catppuccin highlights for regular line numbers
        local colors = require("catppuccin.palettes").get_palette()
        vim.api.nvim_set_hl(0, "LineNr", { 
          fg = colors.blue,  -- Using Catppuccin's blue
          bold = true 
        })
        
        -- Current line number with a more standout color
        vim.api.nvim_set_hl(0, "CursorLineNr", { 
          fg = colors.yellow,  -- Using Catppuccin's yellow
          bold = true 
        })
        
        -- Keep SignColumn transparent
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      end
    })
  '';
}

