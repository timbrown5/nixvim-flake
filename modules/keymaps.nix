{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Core keybindings
  globals.mapleader = " ";

  # Custom keymaps in Lua
  extraConfigLua = ''
    -- Smart delete without copying
    vim.keymap.set('n', '<leader>d', function() return smart_delete() end, { expr = true, desc = "Delete without copying" })
    vim.keymap.set('n', '<leader>dd', function() smart_delete('line') end, { desc = "Delete line without copying" })
    vim.keymap.set('v', '<leader>d', '"_d', { desc = "Delete selection without copying" })

    -- Snacks mappings
    vim.keymap.set('n', '\\', '<cmd>Snacks explorer<CR>', { desc = "Toggle Explorer" })
    vim.keymap.set('n', '<leader>ff', '<cmd>Snacks pick_files<CR>', { desc = "Find Files" })
    vim.keymap.set('n', '<leader>fg', '<cmd>Snacks live_grep<CR>', { desc = "Live Grep" })

    -- Configure which-key with updated spec format
    require("which-key").setup({
      icons = {
        breadcrumb = "»", 
        separator = "➜", 
        group = "+", 
      },
      window = {
        border = "single",
        position = "bottom",
      },
      ignore_missing = true, -- Prevents warnings about missing mappings
    })

    -- Register which-key groups using the LATEST spec format
    local wk = require("which-key")

    -- Define the prefix groups with the updated format
    wk.register({
      ["<leader>"] = {
        f = { name = "+find" },
        D = { name = "+debug" },
        l = { name = "+lsp" },
        -- Removed the check group since we're not using multiple check shortcuts
      }
    })
  '';

  # DAP keymaps with standard keymaps approach
  keymaps = [
    # Register mappings
    {
      mode = "n";
      key = "<leader>p";
      action = "\"0p";
      options.desc = "Paste from yank register (0)";
    }

    # DAP mappings
    {
      mode = "n";
      key = "<leader>Db";
      action = "require('dap').toggle_breakpoint";
      options.desc = "Toggle breakpoint";
    }
    {
      mode = "n";
      key = "<leader>Dc";
      action = "require('dap').continue";
      options.desc = "Start/Continue debugging";
    }
    {
      mode = "n";
      key = "<leader>Dj";
      action = "require('dap').step_over";
      options.desc = "Step over";
    }
    {
      mode = "n";
      key = "<leader>Du";
      action = "require('dapui').toggle";
      options.desc = "Toggle DAP UI";
    }

    # Just keep the main health check keymap
    {
      mode = "n";
      key = "<leader>h";
      action = ":checkhealth nixvim<CR>";
      options.desc = "Check NixVim health";
    }
  ];

  # Which-key plugin with minimal configuration
  plugins.which-key = {
    enable = true;
    # Configuration moved to extraConfigLua
  };
}
