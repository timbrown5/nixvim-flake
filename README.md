# NixVim with NvChad

A minimal Neovim configuration using NixVim with the official NvChad packages from nixpkgs. This gives you the NvChad experience with the declarative power of Nix.

## Features

- **Official NvChad packages**: Uses `vimPlugins.nvchad` and `vimPlugins.nvchad-ui` from nixpkgs
- **Minimal configuration**: Just enough setup to get NvChad working properly
- **Extensible**: Easy to add plugins and customizations
- **NixVim benefits**: Reproducible, declarative configuration

## How it works

This configuration uses the official NvChad packages from nixpkgs:
- `vimPlugins.nvchad` - The core NvChad configuration
- `vimPlugins.nvchad-ui` - NvChad's UI components (statusline, tabline, etc.)

The configuration:
1. Loads the NvChad packages
2. Sets up minimal required options
3. Initializes NvChad's configuration
4. Adds essential plugins that integrate well with NvChad

## Installation

```bash
# Clone the repository
git clone https://github.com/your-username/nixvim-nvchad.git
cd nixvim-nvchad

# Run directly
nix run .

# Or build
nix build
```

## File Structure

```
.
├── flake.nix                 # Main flake configuration
├── lua/                      # Lua configuration files
│   ├── nvchad-init.lua      # NvChad initialization
│   ├── keybindings.lua      # All keybindings
│   └── user-config.lua      # User customizations
└── modules/
    ├── nvchad-config.nix    # NvChad setup and core plugins
    └── user-config.nix      # User customizations
```

## Customization

### Adding Plugins

Edit `modules/user-config.nix`:

```nix
extraPlugins = with pkgs.vimPlugins; [
  vim-surround
  hop-nvim
  # Add more plugins here
];
```

### Adding Keybindings

Edit `lua/keybindings.lua` or add custom keybindings in `lua/user-config.lua`:

```lua
-- In keybindings.lua for core keybindings
map('n', '<leader>ff', ':lua Snacks.picker.files()<CR>', { desc = 'Find files' })

-- In user-config.lua for user-specific keybindings
map('n', '<leader>gg', ':LazyGit<CR>', { desc = 'Open LazyGit' })
```

### Adding LSP Servers

Edit `modules/user-config.nix`:

```nix
plugins.lsp.servers = {
  tsserver.enable = true;
  gopls.enable = true;
};
```

### Custom Lua Configuration

Edit `lua/user-config.lua` for any Lua customizations:

```lua
-- Custom settings
vim.opt.wrap = false
vim.opt.scrolloff = 8

-- Override NvChad theme
vim.g.nvchad_theme = "tokyonight"

-- Custom functions and commands
vim.api.nvim_create_user_command("MyCommand", function()
  -- Implementation
end, {})
```

The advantage of having separate Lua files is that you get full LSP support (syntax highlighting, completion, diagnostics) when editing them in Neovim.

## Default Keybindings

All keybindings are now defined in `lua/keybindings.lua`. Some highlights:

| Key | Description |
|-----|-------------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<C-n>` | Toggle file tree |
| `<leader>e` | Focus file tree |
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>f` | Format |

Many more keybindings are available - check `lua/keybindings.lua` for the complete list.

## Default Keybindings

The configuration includes basic keybindings that work with NvChad:

| Key | Description |
|-----|-------------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<C-n>` | Toggle file tree |
| `<leader>e` | Focus file tree |
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |

Many more keybindings are available through NvChad's default configuration.

## Included Plugins

- **NvChad core**: Base configuration and UI
- **Treesitter**: Syntax highlighting
- **LSP**: Language server support (lua_ls, nil_ls, pyright by default)
- **Blink.cmp**: Modern, performant completion plugin
- **Telescope**: Fuzzy finder
- **nvim-tree**: File explorer
- **gitsigns**: Git integration
- **which-key**: Keymap hints

## Tips

1. NvChad's full documentation is available at [nvchad.com](https://nvchad.com)
2. You can change the theme by setting `vim.g.nvchad_theme` in the Lua configuration
3. The configuration is minimal on purpose - add only what you need
4. Check `:checkhealth` after installation to ensure everything is working

## Troubleshooting

1. If the UI doesn't look right, make sure you have a [Nerd Font](https://www.nerdfonts.com/) installed
2. Run `:checkhealth` to diagnose issues
3. Check the NvChad cache directory: `~/.local/share/nvim/nvchad/`

## License

This configuration is available under the MIT license.
