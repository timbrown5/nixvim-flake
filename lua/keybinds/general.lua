-- General keybindings
local map = vim.keymap.set

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic operations
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })

-- Better escape
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- Redo (reminder: <C-r> is redo, u is undo)
map('n', 'U', '<C-r>', { desc = 'Redo (also <C-r>)' })

-- Move lines up/down
map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Better indenting
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

-- Select all
map('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })

-- Center cursor after jumps
map('n', '<C-d>', '<C-d>zz', { desc = 'Jump down and center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Jump up and center' })
map('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })
