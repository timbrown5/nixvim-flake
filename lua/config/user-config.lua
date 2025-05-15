-- User customizations
-- Add any custom Lua configuration here
-- This runs after NvChad is loaded

-- Example: Custom autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Example: Override NvChad settings
-- vim.g.nvchad_theme = "tokyonight"  -- Change theme

-- Example: Custom options
-- vim.opt.wrap = false
-- vim.opt.scrolloff = 8
-- vim.opt.sidescrolloff = 8

-- Example: Custom commands
vim.api.nvim_create_user_command("FormatToggle", function()
  vim.g.auto_format = not vim.g.auto_format
  vim.notify("Auto-format " .. (vim.g.auto_format and "enabled" or "disabled"))
end, {})

-- Example: Custom functions
_G.custom_functions = {}

_G.custom_functions.toggle_diagnostics = function()
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
    vim.notify("Diagnostics enabled")
  else
    vim.diagnostic.disable()
    vim.notify("Diagnostics disabled")
  end
end

-- Custom keybindings
local map = vim.keymap.set

-- Add your custom keybindings here
-- Examples:
-- map('n', '<leader>gg', ':LazyGit<CR>', { desc = 'Open LazyGit' })
-- map('n', '<leader>tt', ':ToggleTerm<CR>', { desc = 'Toggle terminal' })
-- map('n', '<leader>td', _G.custom_functions.toggle_diagnostics, { desc = 'Toggle diagnostics' })

-- Custom Snacks picker configurations
-- You can create custom pickers like this:
map('n', '<leader>fp', function()
  Snacks.picker({
    source = "files",
    title = "Project Files",
    cwd = vim.fn.getcwd(),
    layout = "vertical",
  })
end, { desc = 'Find project files' })

-- Or use the picker API for custom sources
-- Example: picker for TODO comments
map('n', '<leader>ft', function()
  Snacks.picker.grep({
    search = "TODO|FIXME|HACK|NOTE",
    regex = true,
    title = "Find TODOs",
  })
end, { desc = 'Find TODO comments' })
