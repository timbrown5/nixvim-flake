{ pkgs, lib, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };

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
        json = [ "prettier" ];
        yaml = [ "prettier" ];
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
            "--single-quote"
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
  ];

  keymaps = [
    {
      key = "<leader>cf";
      action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
      mode = "n";
      options.desc = "Format buffer with conform";
    }
    {
      key = "<leader>cF";
      action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true, range = { start = vim.fn.line('v'), ['end'] = vim.fn.line('.') } })<CR>";
      mode = "v";
      options.desc = "Format selection with conform";
    }
  ];

  extraConfigLua = ''
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
        vim.notify("Autoformat disabled for current buffer", vim.log.levels.INFO)
      else
        vim.g.disable_autoformat = true
        vim.notify("Autoformat disabled globally", vim.log.levels.INFO)
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      vim.notify("Autoformat enabled", vim.log.levels.INFO)
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    vim.api.nvim_create_user_command("FormatInfo", function()
      local conform = require("conform")
      local formatters = conform.list_formatters()
      if #formatters == 0 then
        vim.notify("No formatters available for this filetype", vim.log.levels.WARN)
      else
        local formatter_names = {}
        for _, formatter in ipairs(formatters) do
          table.insert(formatter_names, formatter.name)
        end
        vim.notify("Available formatters: " .. table.concat(formatter_names, ", "), vim.log.levels.INFO)
      end
    end, {
      desc = "Show available formatters for current buffer",
    })

    require("conform").setup({
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
    })
  '';
}
