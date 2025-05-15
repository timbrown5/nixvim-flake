-- Git keybindings
local map = vim.keymap.set

-- Git operations
map('n', '<leader>gc', '<cmd>lua Snacks.picker.git_commits()<CR>', { desc = 'Git commits' })
map('n', '<leader>gb', '<cmd>lua Snacks.picker.git_branches()<CR>', { desc = 'Git branches' })
map('n', '<leader>gs', '<cmd>lua Snacks.picker.git_status()<CR>', { desc = 'Git status' })

-- Register which-key group
local ok, wk = pcall(require, 'which-key')
if ok then
  wk.add({
    { '<leader>g', group = 'Git' },
  })
end
