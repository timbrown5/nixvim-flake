{ pkgs, ... }: {
  extraConfigVim = ''
    set runtimepath^=${pkgs.vimPlugins.nvchad}
    set runtimepath^=${pkgs.vimPlugins.nvchad-ui}
  '';
  
  extraConfigLuaPre = ''
    local data_dir = vim.fn.stdpath("data")
    vim.g.base46_cache = data_dir .. "/nvchad/base46/"
    vim.g.nvchad_theme = "catppuccin"
    vim.fn.mkdir(data_dir .. "/nvchad/base46", "p")
  '';

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "macchiato";
      transparent_background = true;
      no_italic = false;
      
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
      
      dim_inactive = {
        enabled = true;
        percentage = 0.1;
      };
      
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

  plugins = {
    lualine.enable = false;
    
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
        
        indent = {
          enabled = true;
          scope = true;
          char = "│";
          exclude_filetypes = ["help" "dashboard" "lazy" "mason" "notify"];
          highlight = [
            "CatppuccinaSubtext0"
            "CatppuccinaBlue"
          ];
          smart_indent = true;
          scope_start = true;
          line_num = false;
        };
        
        terminal = {
          enabled = true;
          direction = "float";
          shell = "bash";
          size = {
            width = 0.8;
            height = 0.8;
          };
          border = "rounded";
          mappings = {
            toggle = "<leader>tt";
          };
        };
        
        image = {
          enabled = true;
          backend = "kitty";
          max_width = 100;
          max_height = 25;
          window = "float";
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
    
    gitsigns.enable = true;
    
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
    
    blink-cmp = {
      enable = true;
    };
    
    lsp = {
      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics = {
                globals = [ "vim" "snipe" ];
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
          "K" = {
            action = "hover";
            desc = "Hover documentation";
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
        };
        
        diagnostic = {
          "[d" = {
            action = "goto_prev";
            desc = "Previous diagnostic";
          };
          "]d" = {
            action = "goto_next";
            desc = "Next diagnostic";
          };
          
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
          "<leader>dq" = {
            action = "setloclist";
            desc = "Diagnostics: To quickfix";
          };
        };
      };
    };
    
    comment.enable = true;
    nvim-autopairs.enable = true;
  };
  
  extraConfigLua = ''
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "@parameter", { italic = true })
        vim.api.nvim_set_hl(0, "@attribute", { italic = true })
        vim.api.nvim_set_hl(0, "@variable.builtin", { italic = true })
        vim.api.nvim_set_hl(0, "@keyword.function", { italic = true })
        vim.api.nvim_set_hl(0, "@keyword.return", { italic = true })
        vim.api.nvim_set_hl(0, "@type.builtin", { italic = true })
        vim.api.nvim_set_hl(0, "@type.definition", { italic = true })
        vim.api.nvim_set_hl(0, "@type.qualifier", { italic = true })
        
        local colors = require("catppuccin.palettes").get_palette()
        vim.api.nvim_set_hl(0, "LineNr", { 
          fg = colors.blue,
          bold = true 
        })
        
        vim.api.nvim_set_hl(0, "CursorLineNr", { 
          fg = colors.yellow,
          bold = true 
        })
        
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      end
    })
  '';
}
