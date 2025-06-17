# Snippet Management Guide

## Using Snippets

**Basic Usage**: Type trigger word + `<Tab>` to expand snippet

**Navigation**:

- `<Tab>` - Expand snippet or jump to next placeholder
- `<S-Tab>` - Jump to previous placeholder

## Adding Snippets

### From Visual Selection

1. Select text in visual mode
2. Press `<leader>sc`
3. Enter trigger word
4. Add description
5. Save

### Manual Creation

Create `.snippets` files in `~/.config/nvim/snippets/`:

```
snippets/
├── all/global.snippets      # Available everywhere
└── lua/general.snippets     # Language-specific
```

**VSCode Format**:

```json
{
  "hello": {
    "prefix": "hello",
    "body": ["Hello, ${1:world}!", "$0"],
    "description": "Simple greeting"
  }
}
```

**Placeholders**:

- `$1`, `$2` - Tab stops (jump order)
- `$0` - Final cursor position
- `${1:default}` - Tab stop with default text
- `$TM_SELECTED_TEXT` - Visual selection content

## Editing Snippets

**Browse & Edit**: Press `<leader>se` to open snippet browser

**Auto-reload**: Changes save automatically

**File Locations**:

- Global snippets: `snippets/all/`
- Language-specific: `snippets/{filetype}/`

## Troubleshooting

- **Not expanding**: Check filetype with `:set ft?`
- **Missing folders**: Run `:lua require('scissors').setup()`
- **Tab issues**: Verify LuaSnip + blink.cmp integration
