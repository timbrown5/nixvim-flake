# Minimal NixVim + NvChad Configuration

This is a minimal working example of a NixVim configuration that integrates NvChad, providing a modern Neovim experience with the declarative power of Nix.

## Features

- ✨ NvChad integration with official nixpkgs packages
- 🚀 Modern completion with blink.cmp
- 🔍 Fast picker and file explorer with Snacks.nvim
- 🌳 File explorer with Snacks explorer
- 💡 LSP support for multiple languages
- 🎨 Beautiful UI with NvChad themes
- ⚡ Fast startup with lazy loading
- 📦 Fully reproducible with Nix

## Structure

```
.
├── flake.nix              # Main flake configuration
├── modules/               # Nix modules
│   ├── default.nix        # Main configuration module
│   ├── mappings.nix       # Empty (keybindings moved to Lua)
│   ├── options.nix        # Vim options
│   ├── nvchad.nix         # NvChad-specific configuration
│   └── core-plugins.nix   # Additional plugins
└── lua/
    ├── config/            # Lua configuration files
    │   ├── nvchad-init.lua   # NvChad initialization
    │   ├── user-config.lua   # User customizations
    │   └── keybindings.lua   # Loads all keybindings
    └── keybinds/          # Modular keybinding files
        ├── init.lua          # Loads all keybinding modules
        ├── general.lua       # General operations
        ├── navigation.lua    # Window/split navigation
        ├── file-tree.lua     # File explorer keybindings
        ├── snacks-picker.lua # Snacks picker bindings
        ├── snacks.lua        # Other Snacks utilities
        ├── lsp.lua          # LSP keybindings
        ├── git.lua          # Git operations
        ├── clipboard.lua     # Clipboard/register ops
        ├── terminal.lua      # Terminal keybindings
        ├── tabs.lua         # Tab management
        └── diagnostics.lua   # Diagnostic keybindings
```

## Usage

### Build and Run

```bash
# Clone the repository
git clone <your-repo>
cd nixvim-nvchad

# Run directly
nix run .

# Or build it
nix build .
result/bin/nvim

# Add to your system flake
{
  inputs.nixvim-nvchad.url = "github:yourusername/nixvim-nvchad";
  
  # In your configuration
  environment.systemPackages = [
    inputs.nixvim-nvchad.packages.${system}.default
  ];
}
```

### Key Bindings

#### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Quit
- `jk` - Exit insert mode (in insert mode)
- `u` - Undo
- `<C-r>` or `U` - Redo (capital U is easier to remember!)

#### Clipboard & Registers
- Default: yanking/deleting uses system clipboard
- `<leader>d` - Delete without copying to register
- `<leader>D` - Delete to end of line without copying
- `x` - Delete character without copying
- `<leader>p` - Paste from yank register (register 0)
- `<leader>P` - Paste from yank register before cursor
- `<leader>y` - Explicitly yank to system clipboard
- `<leader>Y` - Yank line to system clipboard

#### File Explorer
- `<C-n>` - Toggle file explorer
- `<leader>e` - Focus file explorer

#### Navigation
- `<C-h/j/k/l>` - Navigate between windows

#### Finding
- `<leader>ff` - Find files
- `<leader>fw` - Live grep (search in files)
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help
- `<leader>fr` - Recent files
- `<leader>fd` - Diagnostics
- `<leader>fs` - Symbols
- `<leader>fc` - Commands
- `<leader>fk` - Keymaps

#### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `gt` - Go to type definition
- `K` - Hover documentation
- `<leader>ca` - Code action
- `<leader>rn` - Rename
- `<leader>f` - Format file

#### Diagnostics
- `<leader>xx` - Toggle diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>d` - Show diagnostic float

#### Git
- `<leader>gc` - Git commits
- `<leader>gb` - Git branches
- `<leader>gs` - Git status

#### Splits & Tabs
- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally
- `<leader>se` - Equal split sizes
- `<leader>sx` - Close split
- `<leader>to` - New tab
- `<leader>tx` - Close tab

#### Terminal
- `<leader>tt` - Toggle terminal

## Customization

### Adding Plugins

Edit `modules/core-plugins.nix`:

```nix
extraPlugins = with pkgs.vimPlugins; [
  # Add your plugins here
  plugin-name
];
```

### Adding Language Servers

Edit `modules/nvchad.nix`:

```nix
lsp.servers = {
  # Add servers here
  rust_analyzer.enable = true;
};
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

### Adding Custom Keybindings

1. Create a new file in `lua/keybinds/` for your plugin or feature
2. Add your keybindings using `vim.keymap.set`
3. Add a `require` statement in `lua/keybinds/init.lua`

Example: `lua/keybinds/my-plugin.lua`
```lua
local map = vim.keymap.set
map('n', '<leader>mp', '<cmd>MyPluginCommand<CR>', { desc = 'My plugin command' })
```

### Custom Lua Configuration

Add your Lua code to `lua/config/user-config.lua`.

## Troubleshooting

1. **Check health**: Run `:checkhealth` in Neovim
2. **Clear cache**: 
   ```bash
   rm -rf ~/.local/share/nvim/nvchad
   rm -rf ~/.cache/nvim
   ```
3. **Update flake**: `nix flake update`
4. **Check logs**: Look at `:messages` for errors

## Requirements

- Nix with flakes enabled
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Git for some features

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
