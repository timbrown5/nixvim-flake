# In modules/core-plugins.nix

{ pkgs, lib, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    snipe-nvim
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
  };

  extraFiles."lua/plugins/which-key.lua".source = ../lua/plugins/which-key.lua;

  extraConfigLua = lib.mkAfter ''
    require("plugins.which-key")
  '';
}
