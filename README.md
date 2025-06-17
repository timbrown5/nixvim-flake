# NixVim + NvChad Configuration

This Neovim configuration combines the clean, modern UI of NvChad with the declarative power of NixVim.

## Features

- 🎨 **Beautiful UI** based on NvChad with Catppuccin theme
- 📦 **Fully declarative** configuration with NixVim and Nix flakes
- 🚀 **Modern UX** with [Snacks.nvim](https://github.com/folke/snacks.nvim) for file exploration, fuzzy finding, and notifications
- 💡 **LSP support** with built-in language servers for Lua, Nix, Python, TypeScript
- 🐛 **Python debugging** ready out-of-the-box with DAP (Debug Adapter Protocol)
- 🤖 **AI Assistant** with CodeCompanion for AI-assisted coding (Claude, OpenAI, local models)
- ✂️ **Smart snippets** with visual selection → snippet creation
- 📝 **Organized keybindings** with functional namespaces and which-key integration
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

## Essential Keybindings

**Leader key:** `<Space>`

### Core Operations

| Key          | Description                 |
| ------------ | --------------------------- |
| `<leader>W`  | Save file                   |
| `<leader>/`  | Open file explorer          |
| `<C-n>`      | Toggle file explorer        |
| `<leader>ff` | Find files                  |
| `<leader>fw` | Search in files (live grep) |
| `<leader>fb` | Find buffers                |
| `<leader>tt` | Toggle terminal             |

### Code & LSP

| Key          | Description         |
| ------------ | ------------------- |
| `gd`         | Go to definition    |
| `gr`         | Go to references    |
| `K`          | Hover documentation |
| `<leader>ca` | Code actions        |
| `<leader>rn` | Rename symbol       |
| `<leader>bf` | Format buffer       |

### AI Assistant

| Key          | Description         |
| ------------ | ------------------- |
| `<leader>ai` | Open AI chat        |
| `<leader>ac` | Chat with selection |
| `<leader>aa` | AI actions menu     |

### Snippets

| Key          | Description                   |
| ------------ | ----------------------------- |
| `<leader>sc` | Create snippet from selection |
| `<leader>se` | Edit snippets                 |
| `<Tab>`      | Expand snippet / jump forward |
| `<S-Tab>`    | Jump backward in snippet      |

### Debug (Python)

| Key          | Description              |
| ------------ | ------------------------ |
| `<leader>Db` | Toggle breakpoint        |
| `<leader>Dc` | Start/continue debugging |
| `<leader>Di` | Step into                |
| `<leader>Dj` | Step over                |

**💡 Tip:** Press `<leader>` and wait to see all available keybindings with descriptions!

## Documentation

### 📚 **Detailed Guides**

- **[Complete Keybindings](docs/keybindings.md)** - Full keybinding reference with all namespaces
- **[Customization Guide](docs/customization.md)** - Adding plugins, themes, formatters, and keybindings
- **[Debugging Guide](docs/debugging.md)** - Python debugging setup and advanced debugging features
- **[CodeCompanion Setup](docs/codecompanion.md)** - AI assistant configuration for Claude, OpenAI, and local models
- **[Snippet Management](docs/snippets.md)** - Creating and managing custom snippets

### 🎯 **Quick References**

- **Keybind Organization:** Uses functional namespaces (`<leader>f*` for find, `<leader>g*` for git, etc.)
- **File Organization:** See [project structure](docs/customization.md#file-organization)
- **Health Check:** Run `:checkhealth nixvim` to verify your setup

## Supported Languages & Tools

### Language Servers (LSP)

- **Lua** - lua_ls
- **Nix** - nixd
- **Python** - pyright
- **TypeScript/JavaScript** - ts_ls

### Formatters

- **Lua** - stylua
- **Nix** - nixfmt
- **JavaScript/TypeScript/React** - prettier
- **Python** - black + isort
- **Shell** - shfmt
- **Web** - prettier (HTML, CSS, JSON, YAML, Markdown)

### Tree-sitter

Syntax highlighting for: Lua, Vim, Nix, Markdown, JavaScript, TypeScript, Python, JSON, YAML, TOML, Bash, Regex, HTML, CSS, Dockerfile, Git files

## Performance Features

- **Startup optimization** with disabled unused providers
- **Lazy loading** - Plugins load only when needed
- **Smart autocommands** to reduce unnecessary operations
- **Byte-compiled Lua** for faster execution

## Getting Help

- **Built-in help:** Press `<leader>` and wait, or use `<leader>fh` to search help
- **Health check:** `:checkhealth nixvim` for configuration diagnostics
- **Quick view:** `<leader>vhc` for health status popup
- **Issues:** [GitHub Issues](https://github.com/yourusername/nixvim-flake/issues)

## Contributing

Feel free to open issues or submit pull requests. When adding new functionality, please follow the [keybind organization philosophy](docs/keybindings.md#keybind-organization) and update the relevant documentation.

## License

MIT License - see LICENSE file for details.
