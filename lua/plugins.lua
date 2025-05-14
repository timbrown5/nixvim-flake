-- Automatically load all plugin configurations with priority support
local config_path = vim.fn.stdpath('config') .. '/lua/plugins'

-- Priority loading (lower number = loads first)
local priorities = {
  ["00-early"] = 1,    -- For plugins that must load first
  ["99-late"] = 99,    -- For plugins that should load last
}

-- Read directory contents
local files = vim.fn.readdir(config_path, function(name)
  return name:match("%.lua$")
end)

-- Sort files considering priority prefixes
table.sort(files, function(a, b)
  local a_priority = 50  -- default priority
  local b_priority = 50
  
  -- Check for priority prefix
  for prefix, priority in pairs(priorities) do
    if a:match("^" .. prefix) then a_priority = priority end
    if b:match("^" .. prefix) then b_priority = priority end
  end
  
  if a_priority ~= b_priority then
    return a_priority < b_priority
  end
  return a < b  -- alphabetical for same priority
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
