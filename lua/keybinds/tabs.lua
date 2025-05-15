-- Tab management keybindings
local map = vim.keymap.set

-- Tab operations
map('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
map('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
map('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' })
map('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' })
map('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' })
