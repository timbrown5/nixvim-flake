-- Simple folding configuration using treesitter
-- No additional plugins required!

-- Enable folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Nice fold text
vim.opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
}

-- Custom fold text function for better display
vim.cmd [[
  function! CustomFoldText()
    let line = getline(v:foldstart)
    let foldedLineCount = v:foldend - v:foldstart + 1
    let fillCount = winwidth(0) - len(line) - len(foldedLineCount) - 10
    return line . repeat(' ', fillCount) . ' ' . foldedLineCount . ' lines 󰁂'
  endfunction
  set foldtext=CustomFoldText()
]]

-- Keymaps for folding
local map = vim.keymap.set


-- Navigation
map('n', '[z', 'zk', { desc = "Previous fold" })
map('n', ']z', 'zj', { desc = "Next fold" })

-- Basic operations
map('n', '<leader>za', 'za', { desc = "Toggle fold" })
map('n', '<leader>zc', 'zc', { desc = "Close fold" })
map('n', '<leader>zo', 'zo', { desc = "Open fold" })
map('n', '<leader>zR', 'zR', { desc = "Open all folds" })
map('n', '<leader>zM', 'zM', { desc = "Close all folds" })
map('n', '<leader>zr', 'zr', { desc = "Open folds (reduce level)" })
map('n', '<leader>zm', 'zm', { desc = "Close folds (increase level)" })

-- Set fold levels
for i = 0, 5 do
  map('n', '<leader>z' .. i, ':set foldlevel=' .. i .. '<CR>', 
    { desc = "Set fold level " .. i })
end

-- Quick fold preview (poor man's version)
map('n', '<leader>zp', function()
  local foldclosed = vim.fn.foldclosed('.')
  if foldclosed ~= -1 then
    -- Temporarily open fold, wait, then close
    vim.cmd('normal! zo')
    vim.defer_fn(function()
      vim.cmd('normal! zc')
    end, 1000) -- Show for 1 second
  end
end, { desc = "Preview fold" })

-- Register which-key groups
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  wk.add({
    { "<leader>z", group = "fold" },
  })
end

