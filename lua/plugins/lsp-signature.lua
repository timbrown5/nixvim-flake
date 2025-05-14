-- LSP signature configuration
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    require('lsp_signature').setup({
      bind = false,
      floating_window = false,
      timer_interval = 200,
      handler_opts = {
        border = "rounded"
      },
    })
  end,
})
