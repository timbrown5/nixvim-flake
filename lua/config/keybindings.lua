-- Keybindings configuration
local map = vim.keymap.set

-- File operations
map('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
map('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = 'Focus file tree' })

-- Snacks picker (replacing Telescope)
map('n', '<leader>ff', ':lua Snacks.picker.files()<CR>', { desc = 'Find files' })
map('n', '<leader>fw', ':lua Snacks.picker.grep()<CR>', { desc = 'Live grep' })
map('n', '<leader>fb', ':lua Snacks.picker.buffers()<CR>', { desc = 'Find buffers' })
map('n', '<leader>fh', ':lua Snacks.picker.help()<CR>', { desc = 'Find help' })
map('n', '<leader>fo', ':lua Snacks.picker.oldfiles()<CR>', { desc = 'Recent files' })
map('n', '<leader>fg', ':lua Snacks.picker.git_status()<CR>', { desc = 'Git status' })
map('n', '<leader>gc', ':lua Snacks.picker.git_log()<CR>', { desc = 'Git commits' })
map('n', '<leader>fs', ':lua Snacks.picker.symbols()<CR>', { desc = 'Document symbols' })
map('n', '<leader>fd', ':lua Snacks.picker.diagnostics()<CR>', { desc = 'Diagnostics' })
map('n', '<leader>fc', ':lua Snacks.picker.commands()<CR>', { desc = 'Commands' })
map('n', '<leader>fk', ':lua Snacks.picker.keymaps()<CR>', { desc = 'Keymaps' })
map('n', '<leader>fn', ':lua Snacks.picker.notifications()<CR>', { desc = 'Notifications' })
map('n', '<leader><leader>', ':lua Snacks.picker.smart()<CR>', { desc = 'Smart picker' })

-- Quick access
map('n', '<leader>,', ':lua Snacks.picker.buffers()<CR>', { desc = 'Switch buffer' })
map('n', '<leader>/', ':lua Snacks.picker.grep_word()<CR>', { desc = 'Grep current word' })

-- LSP
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
map('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format' })

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
map('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostic list' })

-- Buffer navigation
map('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize windows
map('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- Terminal
map('n', '<leader>tt', ':terminal<CR>', { desc = 'Open terminal' })
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Better indenting
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

-- Move selected lines
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Search and replace
map('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = 'Replace word under cursor' })

-- Clear search highlighting
map('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlights' })

-- Quick fix list
map('n', '<leader>qo', ':copen<CR>', { desc = 'Open quickfix' })
map('n', '<leader>qc', ':cclose<CR>', { desc = 'Close quickfix' })
map('n', '[q', ':cprevious<CR>', { desc = 'Previous quickfix' })
map('n', ']q', ':cnext<CR>', { desc = 'Next quickfix' })
