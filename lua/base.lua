-- Basic vim options - set only essential options at startup
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false

-- Suppress deprecation warnings from plugins (temporary fix)
-- Remove this once plugins are updated
vim.g.deprecation_warnings = false

-- Faster startup options
vim.opt.updatetime = 300 -- Faster CursorHold
vim.opt.timeoutlen = 300 -- Faster which-key
vim.opt.ttimeoutlen = 0 -- Faster escape
vim.opt.lazyredraw = true -- Don't redraw during macros

-- Disable some built-in plugins for faster startup
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Defer font and clipboard settings
vim.defer_fn(function()
  -- Set font for GUI Neovim clients (like Neovide)
  vim.opt.guifont = "Maple Mono NL:h7"
  
  -- Clipboard
  if vim.fn.has('mac') == 1 then
    vim.opt.clipboard = "unnamedplus"
  elseif vim.fn.has('unix') == 1 then
    vim.opt.clipboard = "unnamedplus"
  end
end, 50)

-- Aliases
vim.g.viAlias = true
vim.g.vimAlias = true

-- Leader key
vim.g.mapleader = " "

-- Defer format on save setup
vim.defer_fn(function()
  vim.g.formatOnSave = true
end, 100)

-- Smart delete function - defer definition
vim.defer_fn(function()
  _G.smart_delete = function(motion)
    if motion == nil then
      vim.cmd('set opfunc=v:lua._G.smart_delete_opfunc')
      return 'g@'
    elseif motion == 'line' then
      vim.cmd('normal! "_dd')
    elseif motion == 'char' then
      vim.cmd('normal! "_d')
    end
    return ""
  end

  _G.smart_delete_opfunc = function(motion_type)
    vim.cmd('normal! `[v`]"_d')
  end
end, 100)
