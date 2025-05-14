-- Which-key event configuration
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(args)
    if args.data == "which-key.nvim" then
      vim.api.nvim_exec_autocmds("User", { pattern = "WhichKeyReady" })
    end
  end
})
