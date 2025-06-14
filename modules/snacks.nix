{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.customPlugins.snacks;
in
{
  options.customPlugins.snacks = {
    enable = lib.mkEnableOption "Enable Snacks.nvim components";
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = with pkgs.vimPlugins; [
      snacks-nvim
      plenary-nvim
    ];

    plugins.snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        quickfile.enabled = true;
        indent.enabled = true;
        scope.enabled = true;

        dashboard = {
          enabled = true;
          sections = [
            {
              section = "header";
              padding = [
                0
                1
              ];
            }
            {
              section = "keys";
              gap = 0;
              padding = 1;
            }
            {
              section = "recent_files";
              limit = 8;
              gap = 0;
              padding = 1;
            }
            {
              section = "terminal";
              icon = " ";
              title = "Git Status";
              enabled = "function() return Snacks.git.get_root() ~= nil end";
              cmd = "git status --short --branch --renames";
              height = 5;
              padding = 1;
              ttl = 300;
              indent = 3;
            }
            { section = "startup"; }
          ];
          preset = {
            keys = [
              {
                icon = "󰈞 ";
                desc = "Find File";
                action = ":lua Snacks.dashboard.pick('files')";
                key = "f";
              }
              {
                icon = "󰈔 ";
                desc = "New File";
                action = ":ene | startinsert";
                key = "n";
              }
              {
                icon = "󰊄 ";
                desc = "Find Text";
                action = ":lua Snacks.dashboard.pick('live_grep')";
                key = "g";
              }
              {
                icon = "󰋚 ";
                desc = "Recent Files";
                action = ":lua Snacks.dashboard.pick('oldfiles')";
                key = "r";
              }
              {
                icon = "󰗼 ";
                desc = "Quit";
                action = ":qa";
                key = "q";
              }
            ];
            header = "";
          };
        };

        notifier = {
          enabled = true;
          timeout = 3000;
        };

        indent = {
          char = "│";
          scope.enabled = true;
          chunk.enabled = true;
        };

        terminal.enabled = true;
        image.enabled = true;
        explorer.enabled = true;
        picker.enabled = true;
      };
    };

    keymaps = [
      {
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        mode = "t";
        options.desc = "Exit terminal mode";
      }
      {
        key = "<leader>tt";
        action = "<cmd>lua Snacks.terminal()<CR>";
        mode = "n";
        options.desc = "Toggle terminal";
      }
    ];

    extraPackages = with pkgs; [
      ripgrep
      fd
    ];

    extraFiles = {
      "lua/plugins/snacks.lua".source = ../lua/plugins/snacks.lua;
      "lua/plugins/snacks-dashboard.lua".text = ''
        local M = {}

        -- Mock lazy.stats before anything else
        package.preload['lazy.stats'] = function()
          return { stats = function() return { loaded = 0, count = 0, startuptime = 0 } end }
        end

        vim.g.start_time = vim.g.start_time or vim.fn.reltime()

        local header_lines = {
          "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗",
          "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║",
          "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║",
          "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║",
          "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
          "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
          "",
          "The greatest teacher, failure is. - Yoda",
          ""
        }

        local rainbow_colors = {
          "DiagnosticError", "DiagnosticWarn", "DiagnosticHint",
          "String", "Function", "Statement"
        }

        function M.setup()
          local snacks_ok, snacks = pcall(require, "snacks")
          if not snacks_ok then
            vim.notify("Snacks not available for dashboard setup", vim.log.levels.WARN)
            return
          end

          -- Override the header section
          snacks.dashboard.sections.header = function()
            return function()
              local items = {}
              for i, line in ipairs(header_lines) do
                local hl = i <= 6 and rainbow_colors[i] or (line:match("greatest teacher") and "Special" or "SnacksDashboardHeader")
                table.insert(items, { text = {{ line, hl = hl }}, align = "center" })
              end
              return items
            end
          end

          -- Override the startup section
          snacks.dashboard.sections.startup = function()
            return function()
              local startup_ms = tonumber(vim.fn.reltimestr(vim.fn.reltime(vim.g.start_time))) * 1000

              local plugin_count = 0
              for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
                local plugin_name = path:match(".*/pack/.*/start/([^/]+)$")
                if plugin_name and
                   not plugin_name:match("^site") and
                   not plugin_name:match("^nvim%-") and
                   plugin_name ~= "nvim" and
                   (vim.fn.isdirectory(path .. "/plugin") == 1 or vim.fn.isdirectory(path .. "/lua") == 1) then
                  plugin_count = plugin_count + 1
                end
              end

              return {
                { text = {{ string.format("⚡ Loaded in %.0fms", startup_ms), hl = "Comment" }}, align = "center", padding = { 1, 0 } },
                { text = {{ string.format("📦 %d plugins loaded", plugin_count), hl = "Comment" }}, align = "center" }
              }
            end
          end

          -- Set up the dashboard keymap
          vim.keymap.set('n', '<leader>vd', function()
            snacks.dashboard()
          end, { desc = 'View dashboard' })
        end

        return M
      '';
    };

    extraConfigVim = ''
      lua vim.g.start_time = vim.fn.reltime()
      lua package.preload['lazy.stats'] = function() return { stats = function() return { loaded = 0, count = 0, startuptime = 0 } end } end
    '';

    extraConfigLua = lib.mkAfter ''
      -- Mock lazy.stats early to prevent Snacks dashboard errors
      package.preload['lazy.stats'] = function()
        return { stats = function() return { loaded = 0, count = 0, startuptime = 0 } end }
      end

      require('plugins.snacks')
      require('plugins.snacks-dashboard').setup()
    '';
  };
}
