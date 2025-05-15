# NixVim + NvChad Configuration

This Neovim configuration combines the clean, modern UI of NvChad with the declarative power of NixVim. 

## Features

- 🎨 Beautiful UI based on NvChad
- 📦 Fully declarative configuration with NixVim and Nix flakes
- 🚀 Modern UX with [Snacks.nvim](https://github.com/braddero/snacks.nvim) for:
  - File explorer
  - Fuzzy finding
  - Notifications
  - Image preview (with Kitty terminal support)
- 💡 LSP support with built-in language servers
- 📝 Clean, organized keybindings

## Included Plugins

- **Core**: NvChad (UI and defaults)
- **Navigation**: Snacks explorer, picker
- **Code**: LSP, treesitter, blink.cmp for completion
- **UI**: Catppuccin theme, indent guides, Snacks notifications
- **Diagnostics**: Trouble.nvim for structured error display
- **Utilities**: Terminal, surround operations, image preview

## Installation

### Quick Start

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

### Adding to Your Existing Flake

Add this configuration to your existing Nix flake:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Add this repository as an input
    nixvim-flake = {
      url = "github:timbrown5/nixvim-flake/nvchad-base";
      # Optional: follow the same nixpkgs
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
          # Your existing configuration
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
          # Your existing configuration
          {
            home.packages = [
              nixvim-flake.packages.${system}.default
            ];
          }
        ];
      };

      # Development shell
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          nixvim-flake.packages.${system}.default
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

### File Explorer
- `<C-n>` - Toggle file explorer
- `<leader>e` - Focus file explorer

### Picker (Fuzzy Finding)
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
- `<leader>f` - Format file

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

### Terminal
- `<leader>tt` - Toggle terminal
- `<Esc><Esc>` - Exit terminal mode

### Tabs
- `<leader>to` - Open new tab
- `<leader>tx` - Close current tab
- `<leader>tn/tp` - Next/previous tab

## Customization

### Adding Plugins

Edit `modules/core-plugins.nix`:

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

Create a new file in `lua/keybinds/` for your plugin or feature:

```lua
-- lua/keybinds/my-plugin.lua
local map = vim.keymap.set
map('n', '<leader>mp', '<cmd>MyPluginCommand<CR>', { desc = 'My plugin command' })
```

Then add it to `lua/keybinds/init.lua`:

```lua
require('keybinds.my-plugin')
```

## Requirements

- Nix with flakes enabled
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Kitty terminal (for image preview)

## License

MIT
