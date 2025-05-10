{
  pkgs,
  lib,
  ...
}: {
  extraConfigLua = ''
    -- Basic vim options
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
    vim.opt.swapfile = false
    
    -- Clipboard
    if vim.fn.has('mac') == 1 then
      vim.opt.clipboard = "unnamedplus"
    elseif vim.fn.has('unix') == 1 then
      vim.opt.clipboard = "unnamedplus"
    end
    
    -- Aliases
    vim.g.viAlias = true
    vim.g.vimAlias = true
    
    -- Leader key
    vim.g.mapleader = " "
    
    -- Format on save
    vim.g.formatOnSave = true
    
    -- Smart delete function that doesn't affect registers
    _G.smart_delete = function(motion)
      if motion == nil then
        vim.cmd('set opfunc=v:lua.smart_delete_opfunc')
        return 'g@'
      else
        if motion == 'line' then
          vim.cmd('normal! "_dd')
        elseif motion == 'char' then
          vim.cmd('normal! "_d')
        end
      end
    end

    _G.smart_delete_opfunc = function(motion_type)
      vim.cmd('normal! `[v`]"_d')
    end
  '';
}
