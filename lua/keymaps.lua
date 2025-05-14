-- LazyVim style keymaps
local function map(mode, key, action, opts)
  opts = opts or {}
  vim.keymap.set(mode, key, action, opts)
end

-- File operations
map('n', '<leader>fn', ':enew<CR>', { desc = "New File" })
map('n', '<leader>w', ':w<CR>', { desc = "Save file" })
map('n', '<leader>q', ':q<CR>', { desc = "Quit" })
map('n', '<leader>qa', ':qa<CR>', { desc = "Quit all" })

-- Window management
map('n', '<leader>ww', '<C-W>p', { desc = "Other window" })
map('n', '<leader>wd', '<C-W>c', { desc = "Delete window" })
map('n', '<leader>w-', '<C-W>s', { desc = "Split window below" })
map('n', '<leader>w|', '<C-W>v', { desc = "Split window right" })

-- Better navigation
map('n', '<C-h>', '<C-w>h', { desc = "Go to left window" })
map('n', '<C-j>', '<C-w>j', { desc = "Go to lower window" })
map('n', '<C-k>', '<C-w>k', { desc = "Go to upper window" })
map('n', '<C-l>', '<C-w>l', { desc = "Go to right window" })

-- Navigate buffers
map('n', '[b', ':bprevious<CR>', { desc = "Prev buffer" })
map('n', ']b', ':bnext<CR>', { desc = "Next buffer" })

-- Navigate tabs
map('n', '[t', ':tabprevious<CR>', { desc = "Prev tab" })
map('n', ']t', ':tabnext<CR>', { desc = "Next tab" })

-- Diagnostics navigation
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Better indenting
map('v', '<', '<gv', { desc = "Outdent" })
map('v', '>', '>gv', { desc = "Indent" })

-- Move lines
map('n', '<A-j>', ':m .+1<CR>==', { desc = "Move down" })
map('n', '<A-k>', ':m .-2<CR>==', { desc = "Move up" })
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = "Move down" })
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = "Move up" })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = "Move down" })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Better n and N
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = "Escape and clear hlsearch" })

-- Paste from yank register
map('n', '<leader>p', '"0p', { desc = "Paste from yank register (0)" })

-- Check health
map('n', '<leader>h', ':checkhealth nixvim<CR>', { desc = "Check NixVim health" })

-- Replace buffer with clipboard
map('n', '<leader>rb', function()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(vim.fn.getreg('+'), '\n'))
end, { desc = "Replace buffer with clipboard" })

-- Smart delete without copying (custom functionality)
map('n', '<leader>d', function() 
  if _G.smart_delete then
    return _G.smart_delete()
  else
    return ""
  end
end, { expr = true, desc = "Delete without copying" })

map('n', '<leader>dd', function() 
  if _G.smart_delete then
    _G.smart_delete('line')
  end
end, { desc = "Delete line without copying" })

map('v', '<leader>d', '"_d', { desc = "Delete without copying" })

-- File explorer
map('n', '<leader>e', function()
  vim.cmd('Snacks explorer')
end, { desc = "Explorer NeoTree (Root Dir)" })

map('n', '<leader>E', function()
  vim.cmd('Snacks explorer reveal')
end, { desc = "Explorer NeoTree (cwd)" })

-- Find files
map('n', '<leader><space>', function()
  vim.cmd('Snacks pick_files')
end, { desc = "Find Files (Root Dir)" })

map('n', '<leader>ff', function()
  vim.cmd('Snacks pick_files')
end, { desc = "Find Files (Root Dir)" })

map('n', '<leader>fF', function()
  vim.cmd('Snacks pick_files cwd=' .. vim.fn.getcwd())
end, { desc = "Find Files (cwd)" })

-- Grep
map('n', '<leader>/', function()
  vim.cmd('Snacks picker live_grep')
end, { desc = "Grep (Root Dir)" })

map('n', '<leader>sg', function()
  vim.cmd('Snacks picker live_grep')
end, { desc = "Grep (Root Dir)" })

map('n', '<leader>sG', function()
  vim.cmd('Snacks picker live_grep cwd=' .. vim.fn.getcwd())
end, { desc = "Grep (cwd)" })

-- Buffers
map('n', '<leader>,', function()
  vim.cmd('Snacks picker buffers')
end, { desc = "Switch Buffer" })

map('n', '<leader>bb', function()
  vim.cmd('Snacks picker buffers')
end, { desc = "Buffers" })

-- Buffer management
map('n', '<leader>bd', ':bd<CR>', { desc = "Delete Buffer" })
map('n', '<leader>bD', ':bd!<CR>', { desc = "Delete Buffer and Window" })

-- Tabs
map('n', '<leader><tab>l', ':tablast<CR>', { desc = "Last Tab" })
map('n', '<leader><tab>f', ':tabfirst<CR>', { desc = "First Tab" })
map('n', '<leader><tab><tab>', ':tabnew<CR>', { desc = "New Tab" })
map('n', '<leader><tab>]', ':tabnext<CR>', { desc = "Next Tab" })
map('n', '<leader><tab>d', ':tabclose<CR>', { desc = "Close Tab" })
map('n', '<leader><tab>[', ':tabprevious<CR>', { desc = "Previous Tab" })

-- Terminal
map('n', '<C-/>', ':terminal<CR>', { desc = "Terminal" })

-- Git
map('n', '<leader>gg', ':!lazygit<CR>', { desc = "Lazygit" })

-- UI toggles
map('n', '<leader>ul', ':set relativenumber!<CR>', { desc = "Toggle Relative Line Numbers" })
map('n', '<leader>uL', ':set number!<CR>', { desc = "Toggle Line Numbers" })
map('n', '<leader>uw', ':set wrap!<CR>', { desc = "Toggle Word Wrap" })

-- Register which-key groups
vim.defer_fn(function()
  local ok_wk, wk = pcall(require, "which-key")
  if ok_wk then
    wk.add({
      { "<leader><tab>", group = "tabs" },
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug/delete" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>q", group = "quit/session" },
      { "<leader>s", group = "search" },
      { "<leader>u", group = "ui" },
      { "<leader>w", group = "windows" },
      { "<leader>x", group = "diagnostics/quickfix" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
    })
  end
end, 200)
