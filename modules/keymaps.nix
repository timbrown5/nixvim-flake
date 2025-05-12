{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Core keybindings
    globals.mapleader = " ";
    
    # Essential keymaps only - defer the rest
    keymaps = [
      # Essential register mapping
      {
        mode = "n";
        key = "<leader>p";
        action = ''"0p'';
        options.desc = "Paste from yank register (0)";
      }
      
      # Health check
      {
        mode = "n";
        key = "<leader>h";
        action = ":checkhealth nixvim<CR>";
        options.desc = "Check NixVim health";
      }
      
      # Replace entire buffer with clipboard - simple solution
      {
        mode = "n";
        key = "<leader>rb";
        action = ":lua vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(vim.fn.getreg('+'), '\\n'))<CR>";
        options.desc = "Replace buffer with clipboard";
      }
    ];
    
    # Defer most keymaps and plugin setup
    extraConfigLua = ''
      -- Defer keymaps that depend on functions
      vim.defer_fn(function()
        -- Safe keymap function
        local function safe_keymap(mode, key, action, opts)
          local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
          if not ok then
            vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
          end
        end
        
        -- Smart delete keymaps (after function is defined)
        safe_keymap('n', '<leader>d', function() 
          if _G.smart_delete then
            return _G.smart_delete()
          else
            return ""
          end
        end, { expr = true, desc = "Delete without copying" })
        
        safe_keymap('n', '<leader>dd', function() 
          if _G.smart_delete then
            _G.smart_delete('line')
          end
        end, { desc = "Delete line without copying" })
        
        safe_keymap('v', '<leader>d', '"_d', { desc = "Delete selection without copying" })
        
        -- Snacks mappings (lazy loaded)
        safe_keymap('n', '\\', function()
          vim.cmd('Snacks explorer')
        end, { desc = "Toggle Explorer" })
        
        safe_keymap('n', '<leader>ff', function()
          vim.cmd('Snacks pick_files')
        end, { desc = "Find Files" })
        
        safe_keymap('n', '<leader>fg', function()
          vim.cmd('Snacks picker live_grep')
        end, { desc = "Live Grep" })
      end, 100)
      
      -- Super lazy DAP keymaps - only set up when DAP is actually loaded
      vim.api.nvim_create_autocmd("User", {
        pattern = "DapReady",
        once = true,
        callback = function()
          local function safe_keymap(mode, key, action, opts)
            local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
            if not ok then
              vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
            end
          end
          
          -- DAP keymaps
          safe_keymap('n', '<leader>Db', function() 
            local ok, dap = pcall(require, 'dap')
            if ok then
              dap.toggle_breakpoint()
            end
          end, { desc = "Toggle breakpoint" })
          
          safe_keymap('n', '<leader>Dc', function() 
            local ok, dap = pcall(require, 'dap')
            if ok then
              dap.continue()
            end
          end, { desc = "Start/Continue debugging" })
          
          safe_keymap('n', '<leader>Dj', function() 
            local ok, dap = pcall(require, 'dap')
            if ok then
              dap.step_over()
            end
          end, { desc = "Step over" })
          
          safe_keymap('n', '<leader>Du', function() 
            local ok, dapui = pcall(require, 'dapui')
            if ok then
              dapui.toggle()
            end
          end, { desc = "Toggle DAP UI" })
        end
      })
      
      -- Lazy load which-key
      vim.defer_fn(function()
        local ok_wk, wk = pcall(require, "which-key")
        if ok_wk then
          wk.setup({
            icons = {
              breadcrumb = "»", 
              separator = "➜", 
              group = "+", 
            },
            window = {
              border = "single",
              position = "bottom",
            },
            ignore_missing = true,
          })
          
          -- Register which-key groups
          wk.register({
            ["<leader>"] = {
              f = { name = "+find" },
              D = { name = "+debug" },
              l = { name = "+lsp" },
              r = { 
                name = "+replace",
                b = { name = "Replace buffer with clipboard" }
              },
            }
          })
        end
      end, 200) -- Defer more than other plugins
    '';
    
    # Which-key plugin - minimal config
    plugins.which-key = {
      enable = true;
      settings = {
        ignore_missing = true;
        triggers_nowait = []; # Don't trigger immediately
        triggers_blacklist = {
          i = [ "j" "k" ]; # Don't trigger in insert mode
        };
      };
    };
  };
}
