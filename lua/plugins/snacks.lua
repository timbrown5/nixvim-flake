-- Snacks.nvim configuration with error handling
local ok, snacks = pcall(require, 'snacks')
if not ok then
  vim.notify("Failed to load snacks.nvim", vim.log.levels.ERROR)
  return
end

snacks.setup({
  -- Explorer configuration
  explorer = { 
    width = 30, 
    side = "left",
    auto_open = false,
  },
  -- Picker configuration
  picker = { 
    previewer = true,
    initial_mode = "insert",
  },
  -- Dashboard configuration
  dashboard = {
    width = 64,
    preset = {
      pick = "picker",
      keys = {
        { icon = " ", key = "f", action = "pick_files", desc = "Find Files" },
        { icon = " ", key = "n", action = "explorer", desc = "File Explorer" },
        { icon = " ", key = "r", action = "picker oldfiles", desc = "Recent Files" },
        { icon = " ", key = "g", action = "picker live_grep", desc = "Find Text" },
        { icon = " ", key = "c", action = [[lua vim.cmd("e $MYVIMRC")]], desc = "Config" },
        { icon = " ", key = "q", action = "quit", desc = "Quit" },
      },
    },
    header = [[
╭─────────────────────────────────────────────────────────────────────╮
│    ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗                    │
│    ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║                    │
│    ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║                    │
│    ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║                    │
│    ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║                    │
│    ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝                    │
╰─────────────────────────────────────────────────────────────────────╯
    ]],
  }
})

-- Open dashboard on startup if no files were opened
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc(-1) == 0 then
      -- Only try to open dashboard if snacks loaded successfully
      if pcall(require, 'snacks') then
        vim.cmd("Snacks dashboard")
      end
    end
  end,
})
