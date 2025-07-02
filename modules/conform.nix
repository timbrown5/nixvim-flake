{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.plugins.conform-nvim;
in
{
  options.plugins.conform-nvim = {
    autoFormatOnSave = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable auto-format on save by default. Can be toggled at runtime.";
    };
  };

  config = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        # Set format_on_save to null to disable it - we'll handle this in extraConfigLua
        format_on_save = null;

        formatters_by_ft = {
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          html = [ "prettier" ];
          css = [ "prettier" ];
          scss = [ "prettier" ];
          json = [ "jq" ];
          yaml = [ "yamlfmt" ];
          markdown = [ "prettier" ];
          python = [
            "black"
            "isort"
          ];
          sh = [ "shfmt" ];
          bash = [ "shfmt" ];
          rust = [ "rustfmt" ];
          go = [
            "goimports"
            "gofmt"
          ];
        };

        formatters = {
          stylua = {
            prepend_args = [
              "--indent-type"
              "Spaces"
              "--indent-width"
              "2"
            ];
          };
          prettier = {
            prepend_args = [
              "--tab-width"
              "2"
            ];
          };
          black = {
            prepend_args = [
              "--line-length"
              "88"
            ];
          };
          shfmt = {
            prepend_args = [
              "-i"
              "2"
              "-ci"
            ];
          };
        };
      };
    };

    extraPackages = with pkgs; [
      stylua
      nixfmt-classic
      nodePackages.prettier
      black
      python313Packages.isort
      shfmt
      jq
      yamlfmt
    ];

    keymaps = [
      {
        key = "<leader>bf";
        action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
        mode = "n";
        options.desc = "Format buffer";
      }
      {
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
        mode = "n";
        options.desc = "Format buffer";
      }
      {
        key = "<leader>cF";
        action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true, range = { start = vim.fn.line('v'), ['end'] = vim.fn.line('.') } })<CR>";
        mode = "v";
        options.desc = "Format selection";
      }
      {
        key = "<leader>ft";
        action = "<cmd>FormatToggle<CR>";
        mode = "n";
        options.desc = "Toggle auto-format on save";
      }
    ];

    extraConfigLua = ''
      -- Set initial auto-format state based on Nix config
      vim.g.enable_autoformat = ${if cfg.autoFormatOnSave then "true" else "false"}

      -- Setup conform with conditional format on save
      require("conform").setup({
        format_on_save = function(bufnr)
          -- Check global and buffer-specific disable flags
          if not vim.g.enable_autoformat or vim.b[bufnr].disable_autoformat then
            return nil
          end
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end,
      })

      -- Toggle auto-format on save
      vim.api.nvim_create_user_command("FormatToggle", function()
        vim.g.enable_autoformat = not vim.g.enable_autoformat
        local status = vim.g.enable_autoformat and "ENABLED" or "DISABLED"
        vim.notify("Auto-format on save: " .. status, vim.log.levels.INFO)
      end, {
        desc = "Toggle auto-format on save globally",
      })

      -- Disable auto-format for current buffer only
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
          vim.notify("Auto-format disabled for current buffer", vim.log.levels.INFO)
        else
          vim.g.enable_autoformat = false
          vim.notify("Auto-format disabled globally", vim.log.levels.INFO)
        end
      end, {
        desc = "Disable auto-format (! for buffer only)",
        bang = true,
      })

      -- Enable auto-format
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.enable_autoformat = true
        vim.notify("Auto-format enabled", vim.log.levels.INFO)
      end, {
        desc = "Enable auto-format on save",
      })

      -- Show formatter info and current state
      vim.api.nvim_create_user_command("FormatInfo", function()
        local conform = require("conform")
        local formatters = conform.list_formatters()

        -- Show formatter availability
        if #formatters == 0 then
          vim.notify("No formatters available for this filetype", vim.log.levels.WARN)
        else
          local formatter_names = {}
          for _, formatter in ipairs(formatters) do
            table.insert(formatter_names, formatter.name)
          end
          vim.notify("Available formatters: " .. table.concat(formatter_names, ", "), vim.log.levels.INFO)
        end

        -- Show current auto-format state
        local global_status = vim.g.enable_autoformat and "enabled" or "disabled"
        local buffer_status = vim.b.disable_autoformat and "disabled" or "enabled"
        vim.notify(
          "Auto-format state - Global: " .. global_status .. ", Buffer: " .. buffer_status,
          vim.log.levels.INFO
        )
      end, {
        desc = "Show formatter info and auto-format status",
      })

      -- Show current status in a simple way
      vim.api.nvim_create_user_command("FormatStatus", function()
        local global_status = vim.g.enable_autoformat and "ON" or "OFF"
        local buffer_status = vim.b.disable_autoformat and " (buffer disabled)" or ""
        vim.notify("Auto-format: " .. global_status .. buffer_status, vim.log.levels.INFO)
      end, {
        desc = "Show current auto-format status",
      })
    '';
  };
}
