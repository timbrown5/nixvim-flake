{ pkgs, lib, ... }:
{
  plugins.dashboard = {
    enable = true;
    settings = {
      theme = "hyper";
      shortcut_type = "number";
      config = {
        header = [
          "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
          "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ""
          "The greatest teacher, failure is. - Yoda"
          ""
        ];
        shortcut = [
          {
            desc = "󰈞  Find File";
            group = "@property";
            action = "lua Snacks.picker.files()";
            key = "f";
          }
          {
            desc = "󰈔  New File";
            group = "Label";
            action = "ene | startinsert";
            key = "n";
          }
          {
            desc = "󰊄  Find Text";
            group = "DiagnosticHint";
            action = "lua Snacks.picker.grep()";
            key = "g";
          }
          {
            desc = "󰋚  Recent Files";
            group = "Number";
            action = "lua Snacks.picker.recent()";
            key = "r";
          }
          {
            desc = "󰒓  Config";
            group = "Constant";
            action = "lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})";
            key = "c";
          }
          {
            desc = "󰗼  Quit";
            group = "DiagnosticError";
            action = "qa";
            key = "q";
          }
        ];
        mru = {
          limit = 10;
          icon = "󰈚 ";
          label = "Recent Files";
          cwd_only = true;
        };
        footer = [
          ""
        ];
      };
    };
  };

  # Record startup time as early as possible for accurate dashboard timing
  extraConfigVim = ''
    lua vim.g.start_time = vim.fn.reltime()
  '';

  extraConfigLua = ''
    vim.keymap.set('n', '<leader>d', ':Dashboard<CR>', { desc = 'Open Dashboard' })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dashboard",
      callback = function()
        vim.defer_fn(function()
          local buf = vim.api.nvim_get_current_buf()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          local ns_id = vim.api.nvim_create_namespace("dashboard_rainbow")
          
          local colors = {
            "DiagnosticError",
            "DiagnosticWarn", 
            "DiagnosticHint",
            "String",
            "Function",
            "Statement"
          }
          
          local color_index = 1
          local found_blank = false
          
          for i = 1, #lines do
            local line = lines[i]
            if line and line ~= "" and not found_blank then
              if color_index <= #colors then
                vim.api.nvim_buf_add_highlight(buf, ns_id, colors[color_index], i - 1, 0, -1)
                color_index = color_index + 1
              end
            elseif line == "" and color_index > 1 then
              found_blank = true
            elseif found_blank and line and line ~= "" then
              vim.api.nvim_buf_add_highlight(buf, ns_id, "Special", i - 1, 0, -1)
              break
            end
          end
          
          local startup_time = vim.fn.reltimestr(vim.fn.reltime(vim.g.start_time))
          local startup_ms = tonumber(startup_time) * 1000
          
          local was_modifiable = vim.bo[buf].modifiable
          vim.bo[buf].modifiable = true
          
          local footer_line = string.format("⚡ Loaded in %.0fms", startup_ms)
          vim.api.nvim_buf_set_lines(buf, #lines, #lines, false, { "", footer_line })
          vim.api.nvim_buf_add_highlight(buf, 0, "Comment", #lines, 0, -1)
          
          vim.bo[buf].modifiable = was_modifiable
        end, 50)
      end,
    })
  '';
}
