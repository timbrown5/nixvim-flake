# NixVim + NvChad Configuration

This Neovim configuration combines the clean, modern UI of NvChad with the declarative power of NixVim.

## Features

- 🎨 **Beautiful UI** based on NvChad with Catppuccin theme
- 📦 **Fully declarative** configuration with NixVim and Nix flakes
- 🚀 **Modern UX** with [Snacks.nvim](https://github.com/folke/snacks.nvim) for file exploration, fuzzy finding, and notifications
- 💡 **LSP support** with built-in language servers for Lua, Nix, Python, TypeScript
- 🐛 **Python debugging** ready out-of-the-box with DAP (Debug Adapter Protocol)
- 📝 **Organized keybindings** with which-key integration for discoverability
- 🔍 **Visual buffer switching** with Snipe.nvim for easy navigation
- 🖼️ **Image preview** support in Kitty terminal
- ⚡ **Performance optimized** with tree-sitter and modern completion
- 🎯 **Smart formatting** with Conform.nvim for 10+ languages
- 🔧 **Health monitoring** with integrated diagnostics

## Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/nixvim-flake
cd nixvim-flake

# Run directly
nix run .

# Or build it
nix build
./result/bin/nvim
```

## Requirements

- Nix with flakes enabled
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Kitty terminal (for image preview)

## Keybinding Organization Philosophy

This configuration uses **functional namespaces** rather than plugin-specific ones. Keybindings are organized by what you want to accomplish, not which plugin provides the functionality.

### Core Namespaces

| Namespace | Purpose | Examples |
|-----------|---------|----------|
| `<leader>b*` | **Buffer operations** | Format, delete, select, paste over |
| `<leader>c*` | **Code operations** | Format with specific tools, actions |
| `<leader>d*` | **Diagnostics & Delete** | Navigate diagnostics, delete without yanking |
| `<leader>f*` | **Find & Search** | Files, text, buffers, help, recent |
| `<leader>g*` | **Git operations** | Blame, diff, stage, reset, navigate hunks |
| `<leader>l*` | **Language Server** | LSP-specific actions, workspace management |
| `<leader>n*` | **Notifications** | Show history, dismiss, test |
| `<leader>s*` | **Splits & Surround** | Window splits, surround text objects |
| `<leader>t*` | **Terminal & Tabs** | Toggle terminal, tab management |
| `<leader>v*` | **View & Visual** | Dashboard, images, buffer switcher, health check |
| `<leader>D*` | **Debug operations** | Breakpoints, stepping, DAP UI |

### Design Principles

1. **Functional over Plugin-based**: `<leader>bf` (buffer format) instead of `<leader>cf` (conform format)
2. **Consistent Patterns**: Similar operations use similar key patterns across contexts
3. **Dual Accessibility**: Critical operations often have both namespaced and standard keys (e.g., surround: both `sa` and `<leader>sa`)
4. **Descriptive Multi-char**: Less frequent operations use longer, more descriptive keys (`<leader>vhc` for health check)
5. **Mode Awareness**: Same key different modes for related operations (visual vs normal mode formatting)

### Adding New Keybindings

When adding new functionality:

1. **Identify the primary function** (what does it accomplish?)
2. **Choose the appropriate namespace** (buffer? code? view? etc.)
3. **Check for conflicts** with existing bindings in that namespace
4. **Use consistent patterns** with similar operations
5. **Update which-key groups** to maintain discoverability

Example: Adding a new code action would go in `<leader>c*`, a new view operation in `<leader>v*`.

## Key Bindings

**Leader key:** `<Space>`

For complete Neovim documentation, see `:help` or visit [Neovim Documentation](https://neovim.io/doc/).

### Basic Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>w` | Normal | Save file |
| `jk` | Insert | Exit insert mode |
| `U` | Normal | Redo |

### Movement & Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `<C-h/j/k/l>` | Normal | Navigate between windows |
| `<C-d>` | Normal | Jump down and center |
| `<C-u>` | Normal | Jump up and center |
| `n` | Normal | Next search result and center |
| `N` | Normal | Previous search result and center |

### Line/Selection Movement
| Key | Mode | Description |
|-----|------|-------------|
| `<A-j>` | Normal | Move line down |
| `<A-k>` | Normal | Move line up |
| `<A-j>` | Visual | Move selection down |
| `<A-k>` | Visual | Move selection up |
| `<` | Visual | Indent left (stay in visual) |
| `>` | Visual | Indent right (stay in visual) |

### Window & Split Management
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Make splits equal size |
| `<leader>sx` | Normal | Close current split |

### Tab Management
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>to` | Normal | Open new tab |
| `<leader>tx` | Normal | Close current tab |
| `<leader>tn` | Normal | Go to next tab |
| `<leader>tp` | Normal | Go to previous tab |
| `<leader>tf` | Normal | Open current buffer in new tab |

### File Explorer ([Snacks.nvim](https://github.com/folke/snacks.nvim))
| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | Normal | Toggle file explorer |
| `<leader>e` | Normal | Open file explorer |

### Fuzzy Finding ([Snacks.nvim](https://github.com/folke/snacks.nvim))
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | Normal | Find files |
| `<leader>fw` | Normal | Live grep (search in files) |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fh` | Normal | Find help |
| `<leader>fr` | Normal | Recent files |
| `<leader>fd` | Normal | Find diagnostics |
| `<leader>fs` | Normal | Find symbols |
| `<leader>fc` | Normal | Find commands |
| `<leader>fk` | Normal | Find keymaps |

### Buffer Management
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>vs` | Normal | View buffer switcher ([Snipe.nvim](https://github.com/leath-dub/snipe.nvim)) |
| `<leader>bf` | Normal | Format buffer with Conform |
| `<leader>bp` | Normal | Paste clipboard over buffer |
| `<leader>bd` | Normal | Delete all of buffer |
| `<leader>bD` | Normal | Delete all without copying |
| `<leader>bs` | Normal | Select entire buffer |

### Code & Formatting ([Conform.nvim](https://github.com/stevearc/conform.nvim))
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cf` | Normal | Format buffer with Conform |
| `<leader>cF` | Visual | Format selection with Conform |

### View & Visual Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>vd` | Normal | View dashboard |
| `<leader>vh` | Normal | View motion hints (temporary) |
| `<leader>vH` | Normal | Toggle motion hints |
| `<leader>vi` | Normal | View image preview |
| `<leader>vc` | Normal | View clipboard image |
| `<leader>vs` | Normal | View buffer switcher |
| `<leader>vhc` | Normal | View health check |

### Notifications
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>nh` | Normal | Show notification history |
| `<leader>nd` | Normal | Dismiss notifications |
| `<leader>nt` | Normal | Test notification |

### Git Operations ([Gitsigns](https://github.com/lewis6991/gitsigns.nvim))
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gb` | Normal | Git blame line |
| `<leader>gd` | Normal | Git diff current file |
| `<leader>gs` | Normal | Git stage hunk |
| `<leader>gu` | Normal | Git unstage hunk |
| `<leader>gr` | Normal | Git reset hunk |
| `<leader>gp` | Normal | Git preview hunk |
| `<leader>gn` | Normal | Git next hunk |
| `<leader>gN` | Normal | Git previous hunk |

### LSP (Language Server Protocol)
See [LSP documentation](https://neovim.io/doc/user/lsp.html) for more details.

#### Quick Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Go to references |
| `gi` | Normal | Go to implementation |
| `gt` | Normal | Go to type definition |
| `K` | Normal | Hover documentation |

#### Actions
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ca` | Normal | Code action |
| `<leader>rn` | Normal | Rename symbol |

#### LSP Menu (`<leader>l`)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lf` | Normal | Format document (LSP only) |
| `<leader>lh` | Normal | Hover documentation |
| `<leader>la` | Normal | Code action |
| `<leader>ln` | Normal | Rename |
| `<leader>ls` | Normal | Signature help |
| `<leader>lgd` | Normal | Go to definition |
| `<leader>lgr` | Normal | Go to references |
| `<leader>lgi` | Normal | Go to implementation |
| `<leader>lgt` | Normal | Go to type definition |
| `<leader>lwa` | Normal | Add workspace folder |
| `<leader>lwr` | Normal | Remove workspace folder |

### Diagnostics
| Key | Mode | Description |
|-----|------|-------------|
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<leader>dp` | Normal | Previous diagnostic |
| `<leader>dn` | Normal | Next diagnostic |
| `<leader>df` | Normal | Show diagnostic float |
| `<leader>dq` | Normal | Send diagnostics to quickfix |

### Debugging (DAP)
See [nvim-dap documentation](https://github.com/mfussenegger/nvim-dap) for complete debugging guide.

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Db` | Normal | Toggle breakpoint |
| `<leader>DB` | Normal | Set conditional breakpoint |
| `<leader>Dl` | Normal | Set log point |
| `<leader>Dc` | Normal | Continue debugging |
| `<leader>Dr` | Normal | Restart debugging |
| `<leader>Dt` | Normal | Terminate debugging |
| `<leader>Di` | Normal | Step into |
| `<leader>Dj` | Normal | Step over |
| `<leader>Do` | Normal | Step out |
| `<leader>Du` | Normal | Toggle DAP UI |
| `<leader>De` | Normal/Visual | Evaluate expression |

### Clipboard & Registers
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>d` | Normal/Visual | Delete without copying to register |
| `x` | Normal | Delete char without copying |
| `<leader>p` | Normal/Visual | Paste from yank register |
| `<leader>P` | Normal | Paste from yank register before cursor |
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |

### Terminal
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tt` | Normal | Toggle terminal |
| `<Esc><Esc>` | Terminal | Exit terminal mode |

### Surround Operations (Mini.nvim)
See [mini.nvim documentation](https://github.com/echasnovski/mini.nvim) for complete module documentation.

| Key | Mode | Description |
|-----|------|-------------|
| `sa` / `<leader>sa` | Normal | Add surrounding |
| `sd` / `<leader>sd` | Normal | Delete surrounding |
| `sr` / `<leader>sr` | Normal | Replace surrounding |
| `sf` / `<leader>sf` | Normal | Find surrounding |
| `<leader>sF` | Normal | Find surrounding (left) |
| `<leader>sh` | Normal | Highlight surrounding |
| `<leader>sn` | Normal | Update n lines |

### Mini.nvim Modules

#### Mini.comment
| Key | Mode | Description |
|-----|------|-------------|
| `gc` | Normal/Visual | Toggle comment |
| `gcc` | Normal | Comment line |

#### Mini.jump
| Key | Mode | Description |
|-----|------|-------------|
| `f` | Normal | Jump forward to char |
| `F` | Normal | Jump backward to char |
| `t` | Normal | Jump forward till char |
| `T` | Normal | Jump backward till char |
| `;` | Normal | Repeat forward jump |
| `,` | Normal | Repeat backward jump |

### Custom Commands
| Command | Description |
|---------|-------------|
| `:checkhealth nixvim` | Run NixVim configuration health check |
| `:FormatDisable` | Disable autoformat-on-save globally |
| `:FormatDisable!` | Disable autoformat-on-save for current buffer |
| `:FormatEnable` | Re-enable autoformat-on-save |
| `:FormatInfo` | Show available formatters for current buffer |

## Supported Languages & Formatters

### Language Servers (LSP)
- **Lua** - lua_ls
- **Nix** - nixd
- **Python** - pyright
- **TypeScript/JavaScript** - ts_ls

### Formatters ([Conform.nvim](https://github.com/stevearc/conform.nvim))
- **Lua** - stylua
- **Nix** - nixfmt
- **JavaScript/TypeScript/React** - prettier
- **Python** - black + isort
- **Shell** - shfmt
- **Web** - prettier (HTML, CSS, JSON, YAML, Markdown)
- **Rust** - rustfmt (configured)
- **Go** - goimports + gofmt (configured)

### Treesitter Languages
Syntax highlighting and parsing for: Lua, Vim, Nix, Markdown, JavaScript, TypeScript, Python, JSON, YAML, TOML, Bash, Regex, HTML, CSS, Dockerfile, Git files

## Performance Features

- **Startup optimization** with disabled unused providers (Perl, Ruby)
- **Lazy provider loading** - Node.js provider loads only when working with JS/TS files
- **Byte-compiled Lua** for faster execution
- **Smart autocommands** to reduce unnecessary operations

## Health Monitoring

The configuration includes comprehensive health checking:

- **Notification-based**: `<leader>vhc` - Quick popup with status
- **Standard integration**: `:checkhealth nixvim` - Full diagnostic report
- **Monitors**: Plugin loading, formatter availability, LSP status, debug configuration

## Customization

### Adding Plugins

Edit the relevant module in `modules/`:

```nix
extraPlugins = with pkgs.vimPlugins; [
  # Add your plugins here
  plugin-name
];
```

### Changing Theme

Edit `modules/nvchad.nix`:

```nix
colorschemes.catppuccin = {
  enable = true;
  settings = {
    flavour = "mocha";  # or "latte", "frappe", "macchiato"
  };
};
```

### Adding Formatters

Edit `modules/conform.nix`:

```nix
formatters_by_ft = {
  # Add your language and formatter
  rust = [ "rustfmt" ];
  go = [ "goimports" "gofmt" ];
};

extraPackages = with pkgs; [
  # Add formatter packages
  rustfmt
  go
];
```

### Adding Keybindings

Follow the functional namespace philosophy:

```lua
-- lua/plugins/my-plugin.lua
local function safe_keymap(mode, key, action, opts)
  local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
  if not ok then
    vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
  end
end

-- Choose appropriate namespace based on function
safe_keymap('n', '<leader>mp', '<cmd>MyPluginCommand<CR>', { desc = 'My plugin command' })
```

Then add it to the relevant module in `modules/`:

```nix
extraFiles."lua/plugins/my-plugin.lua".source = ../lua/plugins/my-plugin.lua;

extraConfigLua = lib.mkAfter ''
  require('plugins.my-plugin')
'';
```

## File Organization

```
├── modules/                 # Nix configuration modules
│   ├── default.nix         # Main module imports and core config
│   ├── options.nix         # Neovim options and core keybindings
│   ├── nvchad.nix          # NvChad UI configuration
│   ├── snacks.nix          # Snacks.nvim plugin module
│   ├── core-plugins.nix    # Core plugins (LSP, DAP, etc.)
│   ├── mini.nix            # Mini.nvim configurations
│   ├── precognition.nix    # Motion hints plugin
│   └── conform.nix         # Formatting with Conform.nvim
├── lua/
│   ├── config/             # General Neovim configuration
│   │   ├── nvchad-config.lua
│   │   ├── user-config.lua
│   │   ├── fallback.lua
│   │   └── health-check.lua
│   └── plugins/            # Complete plugin configurations
│       ├── snacks.lua      # Snacks keybindings
│       ├── debugger.lua    # DAP setup and debugging keybindings
│       ├── snipe.lua       # Snipe setup and keybindings
│       └── which-key.lua   # Which-key configuration
```

## Included Plugins

- **Core Editing**: NvChad (UI), treesitter, blink.cmp (completion)
- **Navigation**: Snacks explorer, Snacks picker (fuzzy finding)
- **LSP Integration**: Language servers, diagnostics, code actions
- **Debugging**: nvim-dap, nvim-dap-ui, nvim-dap-virtual-text (Python debugging ready)
- **UI Enhancement**: Catppuccin theme, indent guides, notifications
- **Buffer Management**: Snipe.nvim (visual buffer switcher)
- **Formatting**: Conform.nvim (10+ language support)
- **Utilities**: Mini.nvim modules, terminal, image preview, motion hints
- **Git Integration**: Gitsigns with comprehensive git operations

## Python Debugging Guide

This configuration includes full debugging support for Python using the Debug Adapter Protocol (DAP).

### Step-by-Step Debug Guide

1. **Set a Breakpoint**
   - Open your Python file
   - Navigate to the line where you want to stop
   - Press `<leader>Db` to toggle a breakpoint
   - You should see a red circle (🔴) in the sign column

2. **Start Debugging**
   - Press `<leader>Dc` to start debugging
   - Select "Launch file" when prompted
   - The DAP UI will automatically open with panels showing variables, call stack, breakpoints, and console

3. **Debug Controls**
   Once stopped at a breakpoint:
   - `<leader
