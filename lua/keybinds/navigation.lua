-- Window navigation keybindings
local map = vim.keymap.set

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Navigate window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Navigate window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Navigate window up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Navigate window right' })

-- Split management
map('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
map('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
map('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })
