local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  vim.notify("which-key not loaded", vim.log.levels.WARN)
  return
end

which_key.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = false,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "single",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 1, 2, 1, 2 },
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  ignore_missing = false,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  show_help = true,
  triggers = "auto",
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

-- Register main groups with the proper v3 syntax
which_key.register({
  b = { name = "Buffer" },
  c = { name = "Code" },
  d = { name = "Diagnostics/Delete" },
  D = { name = "Debug" },
  f = { name = "Find/Files" },
  g = { name = "Git" },
  l = { name = "LSP" },
  m = { name = "Mini" },
  s = { name = "Split/Snacks" },
  t = { name = "Terminal/Tabs" },
  w = { name = "Window" },
  z = { name = "Fold" },
}, { prefix = "<leader>" })

-- Register subgroups
which_key.register({
  w = { name = "Workspace" },
}, { prefix = "<leader>l" })
