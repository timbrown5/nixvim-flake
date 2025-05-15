-- Diagnostics keybindings
local map = vim.keymap.set

-- Diagnostics
map('n', '<leader>xx', '<cmd>TroubleToggle<CR>', { desc = 'Toggle diagnostics' })
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = 'Previous diagnostic' })
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = 'Next diagnostic' })
map('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Show diagnostic float' })

-- Register which-key group
local ok, wk = pcall(require, 'which-key')
if ok then
  wk.add({
    { '<leader>x', group = 'Diagnostics' },
  })
end
