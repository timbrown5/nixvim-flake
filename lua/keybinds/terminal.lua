-- Terminal keybindings
local map = vim.keymap.set

-- Terminal toggle
map('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })

-- Terminal navigation
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Terminal navigate left' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Terminal navigate down' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Terminal navigate up' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Terminal navigate right' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Terminal normal mode' })

-- Register which-key group
local ok, wk = pcall(require, 'which-key')
if ok then
  wk.add({
    { '<leader>t', group = 'Terminal/Tabs' },
  })
end
