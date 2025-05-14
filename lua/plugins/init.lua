-- Automatically load all plugin configurations
local config_path = vim.fn.stdpath('config') .. '/lua/plugins'

-- Read directory contents
local files = vim.fn.readdir(config_path, function(name)
  return name:match("%.lua$") and name ~= "init.lua"
end)

-- Load each plugin file
for _, filename in ipairs(files) do
  local module_name = filename:gsub("%.lua$", "")
  vim.schedule(function()
    local ok, err = pcall(require, "plugins." .. module_name)
    if not ok then
      vim.notify("Error loading plugin " .. module_name .. ": " .. err, vim.log.levels.ERROR)
    end
  end)
end
