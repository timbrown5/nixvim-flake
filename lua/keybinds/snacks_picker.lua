-- Snacks picker keybindings
local map = vim.keymap.set

-- File finding
map('n', '<leader>ff', '<cmd>lua Snacks.picker.files()<CR>', { desc = 'Find files' })
map('n', '<leader>fw', '<cmd>lua Snacks.picker.grep()<CR>', { desc = 'Live grep' })
map('n', '<leader>fb', '<cmd>lua Snacks.picker.buffers()<CR>', { desc = 'Find buffers' })
map('n', '<leader>fh', '<cmd>lua Snacks.picker.help()<CR>', { desc = 'Find help' })
map('n', '<leader>fr', '<cmd>lua Snacks.picker.recent_files()<CR>', { desc = 'Recent files' })
map('n', '<leader>fd', '<cmd>lua Snacks.picker.diagnostics()<CR>', { desc = 'Diagnostics' })
map('n', '<leader>fs', '<cmd>lua Snacks.picker.symbols()<CR>', { desc = 'Symbols' })
map('n', '<leader>fc', '<cmd>lua Snacks.picker.commands()<CR>', { desc = 'Commands' })
map('n', '<leader>fk', '<cmd>lua Snacks.picker.keymaps()<CR>', { desc = 'Keymaps' })

-- Register which-key group
local ok, wk = pcall(require, 'which-key')
if ok then
  wk.add({
    { '<leader>f', group = 'Find' },
  })
end
