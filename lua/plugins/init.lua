-- Main plugin loader - simple and robust
local config_path = vim.fn.stdpath('config') .. '/lua/plugins'

-- Get list of plugin files
local plugin_files = vim.fn.glob(config_path .. '/*.lua', false, true)

-- Filter and load each plugin file
for _, filepath in ipairs(plugin_files) do
  local filename = vim.fn.fnamemodify(filepath, ':t')
  
  -- Skip init.lua
  if filename ~= 'init.lua' then
    -- Use dofile instead of require to avoid module caching issues
    vim.schedule(function()
      local ok, err = pcall(dofile, filepath)
      if not ok then
        vim.notify('Error loading plugin ' .. filename .. ': ' .. tostring(err), vim.log.levels.ERROR)
      end
    end)
  end
end
