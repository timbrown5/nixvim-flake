-- Trouble.nvim v3 configuration with LazyVim-style keybindings
local ok, trouble = pcall(require, "trouble")
if not ok then
  vim.notify("Failed to load trouble.nvim", vim.log.levels.ERROR)
  return
end

-- Trouble v3 setup (minimal configuration, v3 has smart defaults)
trouble.setup({
  modes = {
    diagnostics = {
      preview = {
        type = "split",
        relative = "editor",
        position = "bottom",
        size = 0.3,
      },
    },
  },
})

-- LazyVim-style keybindings for Trouble v3
local map = vim.keymap.set

-- Diagnostics
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })

-- LSP
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })

-- Location and Quickfix lists
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Navigation keymaps (previous/next) - v3 uses different approach
map("n", "[q", function()
  if trouble.is_open() then
    pcall(trouble.prev, { jump = true })
  else
    local ok, err = pcall(vim.cmd, "cprev")
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end, { desc = "Previous Trouble/Quickfix item" })

map("n", "]q", function()
  if trouble.is_open() then
    pcall(trouble.next, { jump = true })
  else
    local ok, err = pcall(vim.cmd, "cnext")
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end, { desc = "Next Trouble/Quickfix item" })

-- Register which-key groups (using new API)
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  wk.add({
    { "<leader>x", group = "diagnostics/quickfix" },
  })
end
