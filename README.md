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

## Adding to Your Existing Flake

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixvim-flake = {
      url = "github:timbrown5/nixvim-flake/nvchad-base";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim-flake, ... }:
    let
      system = "x86_64-linux"; # Or your system
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # NixOS module
      nixosConfigurations.yourHost = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ pkgs, ... }: {
            environment.systemPackages = [
              nixvim-flake.packages.${system}.default
            ];
          })
        ];
      };

      # Home Manager module
      homeConfigurations.yourUser = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.packages = [
              nixvim-flake.packages.${system}.default
            ];
          }
        ];
      };
    };
}
```

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
| `<C-a>` | Normal | Select all |

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
| `<leader>e` | Normal | Focus file explorer |

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
| `<leader>S` | Normal | Open visual buffer switcher ([Snipe.nvim](https://github.com/leath-dub/snipe.nvim)) |
| `<leader>bf` | Normal | Format buffer |
| `<leader>bp` | Normal | Paste clipboard over buffer |
| `<leader>bd` | Normal | Delete all of buffer |
| `<leader>bD` | Normal | Delete all without copying |

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
| `<leader>lf` | Normal | Format file |
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
| `<leader>D` | Normal | Delete to end of line without copying |
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

### Snacks Utilities
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sn` | Normal | Show notification history |
| `<leader>sd` | Normal | Dismiss notifications |
| `<leader>st` | Normal | Test notification |
| `<leader>si` | Normal | Show image preview |
| `<leader>sc` | Normal | Show clipboard image |

### Motion Hints ([Precognition.nvim](https://github.com/tris203/precognition.nvim))
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>pp` | Normal | Toggle motion hints |
| `<leader>po` | Normal | Peek motion hints (temporary) |

### Mini.nvim Modules
See [mini.nvim documentation](https://github.com/echasnovski/mini.nvim) for complete module documentation.

#### Mini.surround
| Key | Mode | Description |
|-----|------|-------------|
| `ma` | Normal | Add surrounding |
| `md` | Normal | Delete surrounding |
| `mr` | Normal | Replace surrounding |
| `mf` | Normal | Find surrounding |
| `mF` | Normal | Find surrounding (left) |
| `mh` | Normal | Highlight surrounding |
| `mn` | Normal | Update n lines |

#### Mini.comment
| Key | Mode | Description |
|-----|------|-------------|
| `mgc` | Normal/Visual | Toggle comment |
| `mgcc` | Normal | Comment line |

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
| `:FormatDisable` | Disable autoformat-on-save globally |
| `:FormatDisable!` | Disable autoformat-on-save for current buffer |
| `:FormatEnable` | Re-enable autoformat-on-save |

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

### Adding Keybindings

Create a new file in `lua/plugins/` for your plugin:

```lua
-- lua/plugins/my-plugin.lua
local function safe_keymap(mode, key, action, opts)
  local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
  if not ok then
    vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
  end
end

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
│   └── precognition.nix    # Motion hints plugin
├── lua/
│   ├── config/             # General Neovim configuration
│   │   ├── nvchad-config.lua
│   │   ├── user-config.lua
│   │   └── fallback.lua
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
- **Utilities**: Mini.nvim modules, terminal, image preview, motion hints

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
   - `<leader>Di` - Step into functions
   - `<leader>Dj` - Step over (next line)
   - `<leader>Do` - Step out of current function
   - `<leader>Dc` - Continue execution
   - `<leader>Dr` - Restart debugging session
   - `<leader>Dt` - Terminate debugging

4. **Inspect Variables**
   - **Visual Selection**: Select a variable name in visual mode, press `<leader>De` to evaluate
   - **DAP UI Variables Panel**: Shows all local/global variables, expand objects to see properties
   - **DAP Console**: Type Python expressions to evaluate in current context

5. **Advanced Features**
   - **Conditional Breakpoints**: Press `<leader>DB`, enter a condition (e.g., "x > 10")
   - **Log Points**: Press `<leader>Dl`, enter a message to log (e.g., "Value is {x}")

### Example Debug Session
```python
# example.py
def calculate(x, y):
    result = x + y  # Set breakpoint here (<leader>Db)
    return result * 2

def main():
    numbers = [1, 2, 3, 4, 5]
    for num in numbers:
        value = calculate(num, 10)  # Set breakpoint here too
        print(f"Result: {value}")

if __name__ == "__main__":
    main()
```

Debug workflow:
1. Set breakpoints on the marked lines
2. Press `<leader>Dc` and select "Launch file"
3. When stopped at first breakpoint, inspect `x` and `y` variables
4. Press `<leader>Dj` to step over the addition
5. Use `<leader>De` to evaluate expressions like `result * 3`
6. Press `<leader>Dc` to continue to next iteration

### Visual Indicators
- 🔴 **Breakpoint** - Red circle in sign column
- 🟡 **Conditional Breakpoint** - Yellow circle
- 📝 **Log Point** - Notebook icon
- ➡️ **Current Position** - Arrow showing where execution is paused

## License

MIT
