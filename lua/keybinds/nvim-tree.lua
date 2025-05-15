-- File explorer (Snacks explorer) keybindings
local map = vim.keymap.set

-- File explorer operations
map('n', '<C-n>', '<cmd>lua Snacks.explorer.toggle()<CR>', { desc = 'Toggle file explorer' })
map('n', '<leader>e', '<cmd>lua Snacks.explorer.focus()<CR>', { desc = 'Focus file explorer' })
