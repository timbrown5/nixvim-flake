{
  config,
  pkgs,
  lib,
  ...
}: {
  # Configure Lua LSP runtime paths properly
  extraConfigLua = ''
    -- Set up Lua LSP properly with runtime paths
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    
    -- Configure Lua LSP after it's loaded
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "lua_ls" then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
              },
              -- Get the language server to recognize the `vim` global
              diagnostics = {
                globals = {'vim'},
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              -- Do not send telemetry data
              telemetry = {
                enable = false,
              },
            }
          })
        end
      end,
    })
  '';
}
