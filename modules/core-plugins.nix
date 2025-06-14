{
  pkgs,
  lib,
  ...
}:
{
  extraPlugins = with pkgs.vimPlugins; [
    snipe-nvim
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
  ];

  plugins = {
    lualine.enable = false;

    gitsigns.enable = true;

    which-key.enable = true;

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
                globals = [
                  "vim"
                  "snipe"
                ];
              };
              workspace = {
                library = [
                  "\${third_party}/luassert/library"
                ];
              };
            };
          };
        };
        nixd.enable = true;
        pyright.enable = true;
        ts_ls.enable = true;
        bashls.enable = true;
      };

      keymaps = {
        lspBuf = {
          # Hover documentation
          "K" = {
            action = "hover";
            desc = "Hover documentation";
          };
          "<leader>lh" = {
            action = "hover";
            desc = "LSP: Hover documentation";
          };

          # Code actions
          "<leader>la" = {
            action = "code_action";
            desc = "LSP: Code action";
          };
          "<leader>ca" = {
            action = "code_action";
            desc = "Code action (community standard)";
          };

          # Rename
          "<leader>ln" = {
            action = "rename";
            desc = "LSP: Rename";
          };
          "<leader>rn" = {
            action = "rename";
            desc = "Rename (community standard)";
          };

          # Format
          "<leader>lf" = {
            action = "format";
            desc = "LSP: Format document";
          };

          # Signature help
          "<leader>ls" = {
            action = "signature_help";
            desc = "LSP: Signature help";
          };
          "<leader>k" = {
            action = "signature_help";
            desc = "Signature help (community standard)";
          };

          # Workspace operations
          "<leader>lwa" = {
            action = "add_workspace_folder";
            desc = "LSP: Add workspace folder";
          };
          "<leader>lwr" = {
            action = "remove_workspace_folder";
            desc = "LSP: Remove workspace folder";
          };

          # Navigation - Community standards
          "gd" = {
            action = "definition";
            desc = "Go to definition";
          };
          "gD" = {
            action = "declaration";
            desc = "Go to declaration";
          };
          "gr" = {
            action = "references";
            desc = "Go to references";
          };
          "gi" = {
            action = "implementation";
            desc = "Go to implementation";
          };
          "gt" = {
            action = "type_definition";
            desc = "Go to type definition";
          };

          # Navigation - LSP prefix alternatives
          "<leader>lgd" = {
            action = "definition";
            desc = "LSP: Go to definition";
          };
          "<leader>lgD" = {
            action = "declaration";
            desc = "LSP: Go to declaration";
          };
          "<leader>lgr" = {
            action = "references";
            desc = "LSP: Go to references";
          };
          "<leader>lgi" = {
            action = "implementation";
            desc = "LSP: Go to implementation";
          };
          "<leader>lgt" = {
            action = "type_definition";
            desc = "LSP: Go to type definition";
          };

          # Additional community standard
          "<leader>D" = {
            action = "type_definition";
            desc = "Type definition (community alternative)";
          };

          # Symbol operations
          "<leader>ws" = {
            action = "workspace_symbol";
            desc = "Workspace symbol";
          };
          "<leader>ds" = {
            action = "document_symbol";
            desc = "Document symbol";
          };

          # Call hierarchy (if supported)
          "<leader>ci" = {
            action = "incoming_calls";
            desc = "Incoming calls";
          };
          "<leader>co" = {
            action = "outgoing_calls";
            desc = "Outgoing calls";
          };
        };

        diagnostic = {
          # Community standards
          "[d" = {
            action = "goto_prev";
            desc = "Previous diagnostic";
          };
          "]d" = {
            action = "goto_next";
            desc = "Next diagnostic";
          };

          # LSP prefix alternatives
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
  };

  extraFiles = {
    "lua/plugins/which-key.lua".source = ../lua/plugins/which-key.lua;
    "lua/plugins/debugger.lua".source = ../lua/plugins/debugger.lua;
  };

  extraConfigLua = lib.mkAfter ''
    require("plugins.which-key")
    require('plugins.debugger')
  '';
}
