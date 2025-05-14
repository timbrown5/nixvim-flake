-- Lualine status line configuration
require('lualine').setup({
  options = {
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch"},
    lualine_c = {"filename"},
    lualine_x = {"filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"},
  },
  inactive_sections = {
    lualine_c = {"filename"},
    lualine_x = {"location"},
  },
})
