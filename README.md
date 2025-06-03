# NixVim + NvChad Configuration

This Neovim configuration combines the clean, modern UI of NvChad with the declarative power of NixVim.

## Features

- 🎨 **Beautiful UI** based on NvChad with Catppuccin theme
- 📦 **Fully declarative** configuration with NixVim and Nix flakes
- 🚀 **Modern UX** with [Snacks.nvim](https://github.com/braddero/snacks.nvim) for file exploration, fuzzy finding, and notifications
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

### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Quit
- `jk` - Exit insert mode (in insert mode)
- `u` - Undo
- `<C-r>` or `U` - Redo

### Navigation
- `<C-h/j/k/l>` - Navigate between windows
- `<leader>sv/sh` - Split window vertically/horizontally
- `<leader>se` - Equal split sizes
- `<leader>sx` - Close split

### File Management
- `<C-n>` - Toggle file explorer
- `<leader>e` - Focus file explorer
- `<leader>S` - Open buffer menu (visual buffer switcher)

### Fuzzy Finding
- `<leader>ff` - Find files
- `<leader>fw` - Live grep (search in files)
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help
- `<leader>fr` - Recent files
- `<leader>fd` - Diagnostics
- `<leader>fs` - Symbols
- `<leader>fc` - Commands
- `<leader>fk` - Keymaps

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `gt` - Go to type definition
- `K` - Hover documentation
- `<leader>ca` - Code action
- `<leader>rn` - Rename
- `<leader>lf` - Format file

### Terminal
- `<leader>tt` - Toggle terminal
- `<Esc><Esc>` - Exit terminal mode

### Tabs
- `<leader>to` - Open new tab
- `<leader>tx` - Close current tab
- `<leader>tn/tp` - Next/previous tab

### Debugging
- `<leader>Db` - Toggle breakpoint
- `<leader>DB` - Set conditional breakpoint
- `<leader>Dl` - Set log point
- `<leader>Dc` - Continue debugging
- `<leader>Dr` - Restart debugging
- `<leader>Dt` - Terminate debugging
- `<leader>Di` - Step into
- `<leader>Dj` - Step over
- `<leader>Do` - Step out
- `<leader>Du` - Toggle DAP UI
- `<leader>De` - Evaluate expression

### Clipboard & Registers
- `<leader>d` - Delete without copying to register
- `<leader>D` - Delete to end of line without copying
- `x` - Delete char without copying
- `<leader>p` - Paste from yank register (register 0)
- `<leader>P` - Paste from yank register before cursor
- `<leader>y` - Explicitly yank to system clipboard
- `<leader>Y` - Yank line to system clipboard

### Snacks Utilities
- `<leader>sn` - Show notification history
- `<leader>sd` - Dismiss notifications
- `<leader>st` - Test notification
- `<leader>si` - Show image preview
- `<leader>sc` - Show clipboard image

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

Each plugin module owns its complete functionality. To remove a plugin, delete its module and Lua file.

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
