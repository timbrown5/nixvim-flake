{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixpkgs, nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, system, lib, ... }: 
      let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        
        # Build the configuration
        nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = {
            imports = [ ];
            
            # Basic vim options
            config = {
              vim = {
                viAlias = true;
                vimAlias = true;
                
                # Core editor features
                clipboard = {
                  register = "unnamedplus";
                  providers = {
                    wl-copy.enable = pkgs.stdenv.isLinux;
                    pbcopy.enable = pkgs.stdenv.isDarwin;
                  };
                };
                
                # UI settings
                mouse = "a";
                lineNumbers = "relative";
                updateTime = 100;
                
                # Tabs & indentation
                tabWidth = 2;
                expandTab = true;
                
                # System
                swapfile.enable = false;
              };
              
              # Global options
              globals = {
                mapleader = " ";
                maplocalleader = " ";
              };
              
              # Colorscheme settings - Catppuccin Macchiato
              colorschemes.catppuccin = {
                enable = true;
                flavour = "macchiato";
                terminalColors = true;
                integrations = {
                  cmp = true;
                  gitsigns = true;
                  nvimtree = false;
                  telescope = false;
                  treesitter = true;
                  dap = {
                    enable = true;
                    enable_ui = true;
                  };
                  native_lsp.enabled = true;
                  indent_blankline.enabled = true;
                };
              };
              
              # Loading screen with dashboard-nvim
              plugins.dashboard = {
                enable = true;
                hideStatusline = true;
                hideTabline = true;
                centerConfig = true;
                changeWhenVimResized = true;
                packages = {
                  enable = true;
                  enable_version = false;
                };
                project = {
                  enable = true;
                  limit = 5;
                  icon = "󰉋 ";
                  label = "Projects:";
                  action = "Snacks pick_project";
                };
                mru = {
                  enable = true;
                  limit = 5;
                  icon = "󰔛 ";
                  label = "Recent Files:";
                  action = "Snacks pick_files";
                };
                config = {
                  week_header.enable = true;
                  shortcut = {
                    { desc = "󰊳 Update", group = "@property", key = "u", action = "PackerUpdate" },
                    { desc = "󰈞 Files", group = "@property", key = "f", action = "Snacks pick_files" },
                    { desc = " Explorer", group = "@property", key = "e", action = "Snacks explorer" }
                  };
                };
              };
              
              # Snacks.nvim - replacement for telescope and neotree
              plugins.lsp.enable = true;

              extraPlugins = with pkgs.vimPlugins; [
                # Snacks.nvim (for explorer and picker)
                snacks-nvim
                # Snipe for quick movement
                leap-nvim
                # Dependencies for leap
                vim-repeat
                plenary-nvim
              ];
              
              # Configure Snacks and Leap (snipe)
              extraConfigLua = ''
                -- Snacks explorer and picker setup
                require('snacks').setup {
                  -- Explorer configuration
                  explorer = {
                    width = 30,
                    side = "left",
                    auto_open = false,
                  },
                  -- Picker configuration
                  picker = {
                    previewer = true,
                    layout_strategy = "flex",
                  }
                }

                -- Leap (snipe) setup
                require('leap').add_default_mappings()
                
                -- Smart delete function that doesn't affect registers
                _G.smart_delete = function(motion)
                  if motion == nil then
                    -- If no motion is provided, get motion from user
                    vim.cmd('set opfunc=v:lua.smart_delete_opfunc')
                    return 'g@'
                  else
                    -- Handle preset motions
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
                
                -- Keymaps for smart delete (no register pollution)
                vim.keymap.set('n', '<leader>d', function() return smart_delete() end, { expr = true, desc = "Delete without copying" })
                vim.keymap.set('n', '<leader>dd', function() smart_delete('line') end, { desc = "Delete line without copying" })
                vim.keymap.set('v', '<leader>d', '"_d', { desc = "Delete selection without copying" })
                
                -- Keymaps for snacks explorer and picker
                vim.keymap.set('n', '<leader>e', '<cmd>Snacks explorer<CR>', { desc = "Toggle Snacks Explorer" })
                vim.keymap.set('n', '<leader>ff', '<cmd>Snacks pick_files<CR>', { desc = "Find Files" })
                vim.keymap.set('n', '<leader>fg', '<cmd>Snacks live_grep<CR>', { desc = "Live Grep" })
                vim.keymap.set('n', '<leader>fb', '<cmd>Snacks buffers<CR>', { desc = "Find Buffers" })
                
                -- Format keymap
                vim.keymap.set('n', '<leader>f', function()
                  vim.lsp.buf.format({ async = true })
                end, { desc = "Format document" })
              '';
              
              # LSP Configuration
              plugins.lsp = {
                enable = true;
                servers = {
                  # Python
                  pyright.enable = true;
                  
                  # Lua
                  lua-ls = {
                    enable = true;
                    settings.telemetry.enable = false;
                    settings.Lua = {
                      diagnostics.globals = [ "vim" ];
                      workspace.library = [
                        "$${vim.env.VIMRUNTIME}/lua"
                        "$${vim.env.VIMRUNTIME}/lua/vim/lsp"
                      ];
                    };
                  };
                  
                  # Nix
                  nil_ls.enable = true;
                  
                  # C
                  clangd.enable = true;
                  
                  # Terraform
                  terraformls.enable = true;
                };
              };
              
              # Auto-formatting
              plugins.lsp-format.enable = true;
              
              # Completion with nvim-cmp
              plugins.cmp = {
                enable = true;
                autoEnableSources = true;
                settings = {
                  mapping = {
                    "<C-Space>" = "cmp.mapping.complete()";
                    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
                    "<C-e>" = "cmp.mapping.close()";
                    "<C-f>" = "cmp.mapping.scroll_docs(4)";
                    "<CR>" = "cmp.mapping.confirm({ select = true })";
                    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
                    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
                  };
                  snippet.expand = ''
                    function(args)
                      require('luasnip').lsp_expand(args.body)
                    end
                  '';
                  sources = [
                    { name = "path"; }
                    { name = "nvim_lsp"; }
                    { name = "buffer"; }
                    { name = "luasnip"; }
                  ];
                  formatting = {
                    fields = ["abbr" "kind" "menu"];
                    format = ''
                      function(_, vim_item)
                        vim_item.menu = ({
                          nvim_lsp = "[LSP]",
                          luasnip = "[Snippet]",
                          buffer = "[Buffer]",
                          path = "[Path]",
                        })[vim_item.source.name]
                        return vim_item
                      end
                    '';
                  };
                };
              };
              
              # Snippets
              plugins.luasnip.enable = true;
              
              # Debug setup
              plugins.dap = {
                enable = true;
                extensions = {
                  dap-python.enable = true;
                  dap-ui.enable = true;
                  dap-virtual-text.enable = true;
                };
                adapters = {
                  # Python
                  python = {};
                  
                  # C
                  cppdbg = {
                    name = "cppdbg";
                    type = "executable";
                    command = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
                  };
                };
                configurations = {
                  python = [
                    {
                      type = "python";
                      request = "launch";
                      name = "Launch file";
                      program = "''${file}";
                      pythonPath = "python";
                    }
                  ];
                  
                  cpp = [
                    {
                      name = "Launch";
                      type = "cppdbg";
                      request = "launch";
                      program = "''${workspaceFolder}/build/''${fileBasenameNoExtension}";
                      args = [];
                      stopAtEntry = true;
                      cwd = "''${workspaceFolder}";
                      environment = [];
                      externalConsole = false;
                      MIMode = "gdb";
                      miDebuggerPath = "${pkgs.gdb}/bin/gdb";
                      setupCommands = [
                        {
                          description = "Enable pretty-printing for gdb";
                          text = "-enable-pretty-printing";
                          ignoreFailures = true;
                        }
                      ];
                    }
                  ];
                };
              };
              
              # Key mappings
              maps = {
                normal = {
                  # LSP mappings
                  "<leader>ca" = { action = "vim.lsp.buf.code_action"; desc = "Code Action"; };
                  "<leader>rn" = { action = "vim.lsp.buf.rename"; desc = "Rename"; };
                  "gd" = { action = "vim.lsp.buf.definition"; desc = "Goto Definition"; };
                  "gr" = { action = "vim.lsp.buf.references"; desc = "References"; };
                  "K" = { action = "vim.lsp.buf.hover"; desc = "Hover Documentation"; };
                  
                  # Debug mappings - using leader+D (capital D) instead of d
                  "<leader>Db" = { action = "require('dap').toggle_breakpoint"; desc = "Toggle Breakpoint"; };
                  "<leader>Dc" = { action = "require('dap').continue"; desc = "Continue"; };
                  "<leader>Dj" = { action = "require('dap').step_over"; desc = "Step Over"; };
                  "<leader>Dk" = { action = "require('dap').step_back"; desc = "Step Back"; };
                  "<leader>Dl" = { action = "require('dap').step_into"; desc = "Step Into"; };
                  "<leader>Dq" = { action = "require('dap').terminate"; desc = "Terminate"; };
                  "<leader>Dr" = { action = "require('dap').repl.open"; desc = "Open REPL"; };
                  "<leader>Du" = { action = "require('dapui').toggle"; desc = "Toggle UI"; };
                  
                  # Register mappings
                  "<leader>p" = { action = "\"0p"; desc = "Paste from yank register (0)"; };
                  "<leader>P" = { action = "\"0P"; desc = "Paste before from yank register (0)"; };
                };
              };
              
              # Treesitter for syntax highlighting
              plugins.treesitter = {
                enable = true;
                ensureInstalled = [ "python" "lua" "nix" "c" "hcl" "terraform" ];
              };
              
              # Additional helpful plugins
              plugins.lspkind.enable = true;       # Pictograms for LSP completion items
              plugins.lualine.enable = true;       # Status line
              plugins.gitsigns.enable = true;      # Git decorations
              plugins.which-key.enable = true;     # Key binding hints
              plugins.comment.enable = true;       # Better commenting
              plugins.indent-blankline.enable = true; # Indentation guides
              
              # System clipboard helpers for macOS
              extraConfigLuaPre = lib.mkIf pkgs.stdenv.isDarwin ''
                vim.g.clipboard = {
                  name = "macOS-clipboard",
                  copy = {
                    ["+"] = "pbcopy",
                    ["*"] = "pbcopy",
                  },
                  paste = {
                    ["+"] = "pbpaste",
                    ["*"] = "pbpaste",
                  },
                  cache_enabled = 0,
                }
              '';
            };
          };
        };
      in {
        packages = {
          default = nvim;
        };
      };
    };
}
