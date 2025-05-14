-- Leap.nvim configuration (lazy loaded)
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = "*",
  once = true,
  callback = function()
    require('leap').add_default_mappings()
  end
})
