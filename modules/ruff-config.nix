{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Configure ruff for Python
  extraConfigLua = ''
    -- Set up default config file for ruff
    local ruff_config = {
      line_length = 88,
      select = { "E", "F", "I", "B" },  -- Core rules
      ignore = { "E501" },              -- Handled by formatter
      fix = true,
      format_code = true,
    }

    -- Write ruff config to disk when editing Python files
    local function setup_ruff_config()
      local config_path = vim.fn.getcwd() .. "/.ruff.toml"
      
      -- Only create the config if it doesn't exist
      if vim.fn.filereadable(config_path) == 0 then
        local config_lines = {}
        
        -- Convert the Lua table to TOML format
        table.insert(config_lines, "# Ruff configuration")
        table.insert(config_lines, "line-length = " .. ruff_config.line_length)
        
        -- Add select rules
        table.insert(config_lines, "[lint]")
        table.insert(config_lines, "select = [")
        for _, rule in ipairs(ruff_config.select) do
          table.insert(config_lines, '  "' .. rule .. '",')
        end
        table.insert(config_lines, "]")
        
        -- Add ignore rules
        table.insert(config_lines, "ignore = [")
        for _, rule in ipairs(ruff_config.ignore) do
          table.insert(config_lines, '  "' .. rule .. '",')
        end
        table.insert(config_lines, "]")
                
        -- Add format settings
        table.insert(config_lines, "[format]")
        table.insert(config_lines, 'quote-style = "double"')
        table.insert(config_lines, 'indent-style = "space"')
        
        -- Write the config to disk
        vim.fn.writefile(config_lines, config_path)
      end
    end

    -- Set up autocmd to create ruff config in Python projects
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        setup_ruff_config()
      end,
      once = true,
    })
  '';
}
