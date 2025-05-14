-- Flash configuration (replaces Leap)
require('flash').setup({
  modes = {
    -- options for flash search
    search = {
      enabled = true,
    },
    -- options for flash character jump
    char = {
      enabled = true,
      jump_labels = true,
      multi_window = true,
    },
  },
  -- Settings for the jump labels
  label = {
    -- Allow uppercase labels
    uppercase = true,
    -- Show jump labels after the match
    after = true,
    -- Show jump labels before the match  
    before = false,
    -- Style the labels
    style = "overlay",
  },
})

-- Keymaps - Using 's' like leap
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set({ "c" }, "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
