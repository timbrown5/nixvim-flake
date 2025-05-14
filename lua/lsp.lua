-- Start LSP servers on demand based on filetype
local function start_lsp_for_filetype()
  local filetype = vim.bo.filetype
  local client_names = {}
  
  if filetype == "python" then
    client_names = {"pyright", "ruff"}
  elseif filetype == "lua" then
    client_names = {"lua_ls"}
  elseif filetype == "nix" then
    client_names = {"nil_ls"}
  elseif filetype == "c" or filetype == "cpp" then
    client_names = {"clangd"}
  end
  
  for _, client_name in ipairs(client_names) do
    -- Use vim.lsp.get_clients() instead of deprecated get_active_clients()
    local clients = vim.lsp.get_clients({name = client_name})
    if #clients == 0 then
      vim.cmd("LspStart " .. client_name)
    end
  end
end

-- Auto-start LSP for the right filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python", "lua", "nix", "c", "cpp"},
  callback = function()
    vim.schedule(start_lsp_for_filetype)
  end
})

-- Defer loading LuaSnip
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    pcall(require, "luasnip")
  end
})

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function map(mode, key, action, desc)
      vim.keymap.set(mode, key, action, { buffer = args.buf, desc = desc })
    end
    
    -- LazyVim style LSP keymaps
    map('n', 'gd', vim.lsp.buf.definition, "Goto Definition")
    map('n', 'gr', vim.lsp.buf.references, "References")
    map('n', 'gD', vim.lsp.buf.declaration, "Goto Declaration")
    map('n', 'gI', vim.lsp.buf.implementation, "Goto Implementation")
    map('n', 'gy', vim.lsp.buf.type_definition, "Goto Type Definition")
    map('n', 'K', vim.lsp.buf.hover, "Hover")
    
    map('n', '<leader>ca', vim.lsp.buf.code_action, "Code Action")
    map('n', '<leader>cr', vim.lsp.buf.rename, "Rename")
    map('n', '<leader>cf', vim.lsp.buf.format, "Format")
    
    -- Signature help
    map('n', '<C-k>', vim.lsp.buf.signature_help, "Signature Help")
    map('i', '<C-k>', vim.lsp.buf.signature_help, "Signature Help")
    
    -- Register which-key descriptions
    local ok, wk = pcall(require, "which-key")
    if ok then
      wk.add({
        { "g", buffer = args.buf, group = "goto" },
        { "<leader>c", buffer = args.buf, group = "code" },
      })
    end
  end,
})
