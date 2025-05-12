{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enhanced completion animations and visual feedback
  extraConfigLua = ''
    -- Set up completion highlights for blinking effects
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Set up blinking effect for completion menu
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#89B4FA", bold = true })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#89B4FA", bold = true })
        vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#89B4FA" })
        vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#A6ADC8", italic = true })
        
        -- Set highlight for ghost text in completion
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", italic = true })
      end,
      group = vim.api.nvim_create_augroup("custom_completion_highlights", { clear = true }),
    })

    -- Set up completion animations - blinking cursor during completion
    vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineChanged" }, {
      pattern = "*",
      callback = function()
        local mode = vim.fn.getcmdtype()
        if mode == ":" or mode == "/" or mode == "?" then
          vim.opt.guicursor = vim.opt.guicursor + { "a:blinkon100" }
        end
      end,
      group = vim.api.nvim_create_augroup("cmdline_blink", { clear = true }),
    })

    vim.api.nvim_create_autocmd("CmdlineLeave", {
      pattern = "*",
      callback = function()
        vim.opt.guicursor = vim.opt.guicursor - { "a:blinkon100" }
      end,
      group = vim.api.nvim_get_augroup("cmdline_blink"),
    })

    -- Add visual cursor blinking when completion menu is visible
    vim.api.nvim_create_autocmd("CompleteChanged", {
      pattern = "*",
      callback = function()
        vim.opt.guicursor = vim.opt.guicursor + { "i:blinkon100" }
      end,
      group = vim.api.nvim_create_augroup("completion_blink", { clear = true }),
    })

    vim.api.nvim_create_autocmd("CompleteDone", {
      pattern = "*",
      callback = function()
        vim.opt.guicursor = vim.opt.guicursor - { "i:blinkon100" }
      end,
      group = vim.api.nvim_get_augroup("completion_blink"),
    })

    -- Python-specific completion settings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        -- Enhanced Python completions
        local cmp = require('cmp')
        cmp.setup.filetype('python', {
          sources = cmp.config.sources({
            { name = 'nvim_lsp', priority = 1000 },
            { name = 'luasnip', priority = 750 },
            { name = 'nvim_lsp_signature_help', priority = 500 },
            { name = 'buffer', priority = 250 },
            { name = 'path', priority = 100 },
          }),
          -- Use ghost text for current word completion in Python
          experimental = {
            ghost_text = {
              hl_group = "CmpGhostText",
            },
          },
          -- Add Python-specific matching and filtering
          matching = {
            disallow_fuzzy_matching = false,
            disallow_partial_matching = false,
            disallow_prefix_unmatching = false,
          },
        })
        
        -- Show parameter hints as you type
        require('lsp_signature').setup({
          bind = true,
          handler_opts = {
            border = "rounded",
          },
          hint_enable = true,
          hint_prefix = "🐍 ",
          hint_scheme = "String",
          hi_parameter = "Search",
          toggle_key = "<C-k>",
          select_signature_key = "<C-n>",
        })
      end,
      group = vim.api.nvim_create_augroup("python_completion_settings", { clear = true }),
    })
  '';
}
