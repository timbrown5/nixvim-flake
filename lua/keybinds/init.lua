-- Basic keybindings that should be available even in fallback mode
-- This file is loaded by lua/config/fallback.lua when NvChad doesn't load properly

-- Helper function for easier keymapping
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic operations
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Better escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate window right" })

-- Split management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Center cursor after jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Jump down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Black hole register operations
map("n", "<leader>d", "\"_d", { desc = "Delete without yanking" })
map("n", "<leader>D", "\"_D", { desc = "Delete to end of line without yanking" })
map("n", "x", "\"_x", { desc = "Delete char without yanking" })

-- Better paste
map("v", "p", "\"_dP", { desc = "Paste without yanking" })

-- Load deferred keybindings if available
local ok, deferred = pcall(require, "keybinds.deferred")
if not ok then
  vim.notify("Deferred keybindings not loaded in fallback mode", vim.log.levels.INFO)
end

-- Return the module
return {
  -- We can add functions or variables here if needed
  setup = function()
    vim.notify("Basic keybindings loaded successfully", vim.log.levels.INFO)
  end
}
