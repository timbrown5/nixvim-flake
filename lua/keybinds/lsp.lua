-- LSP keybindings
local map = vim.keymap.set

-- LSP navigation
map('n', 'gd', '<cmd>lua Snacks.picker.lsp_definitions()<CR>', { desc = 'Go to definition' })
map('n', 'gr', '<cmd>lua Snacks.picker.lsp_references()<CR>', { desc = 'Go to references' })
map('n', 'gi', '<cmd>lua Snacks.picker.lsp_implementations()<CR>', { desc = 'Go to implementation' })
map('n', 'gt', '<cmd>lua Snacks.picker.lsp_type_definitions()<CR>', { desc = 'Go to type definition' })

-- LSP actions
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover' })
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Code action' })
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename' })
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { desc = 'Format' })

-- Register which-key group
local ok, wk = pcall(require, 'which-key')
if ok then
  wk.add({
    { '<leader>c', group = 'Code' },
  })
end
