# Troubleshooting Guide

**💡 TL;DR:** Most issues are solved by `:LspRestart` or checking you're in a project directory!

Quick fixes for the most common issues, ordered by frequency.

## Most Common Issues (Try These First)

### LSP not working (no code completion/errors)

**Symptoms:** No red underlines, no autocomplete, `gd` doesn't work

**Quick fixes:**

```vim
:LspRestart     " Most common fix - restart LSP
:LspInfo        " Check what's running
```

**Still not working?** You're probably not in a project directory. LSP needs files like `.git/`, `package.json`, `pyproject.toml` to detect the project root.

### Keybindings not working

**Symptoms:** `<leader>ff` does nothing, or wrong action happens

**Quick check:**

1. Press `<leader>` and wait - should show available commands
2. Check if you're in the right mode (some keys only work in normal/visual/insert)
3. Check leader key: `:echo mapleader` (should show a space)

### Terminal won't exit

**Symptoms:** Stuck in terminal, `<Esc>` doesn't work

**Fix:** Use `<C-\><C-n>` to exit terminal mode, then navigate normally

### AI Assistant not responding

**Symptoms:** `<leader>ai` shows "not configured"

**Fix:** Set your API key and restart Neovim:

```bash
export ANTHROPIC_API_KEY="your-key-here"
```

**Setup help:** See [CodeCompanion Setup Guide](codecompanion.md)

## Less Common Issues

### Formatter not working

**Symptoms:** `<leader>bf` doesn't change code formatting

**Quick fix:** File type probably not supported. Check: `:set ft?`

### Configuration changes not taking effect

**After editing Nix files:** `nix build && ./result/bin/nvim`
**After editing Lua files:** `:source %` or restart Neovim

### File explorer not showing

**Symptoms:** `<leader>/` doesn't work

**Quick fix:** `<C-n>` to toggle, or manually: `:lua Snacks.explorer()`

## When Nothing Above Works

### Run Health Checks

```vim
:checkhealth              " Overall health
:checkhealth lsp          " Language servers specifically
:checkhealth snacks       " File explorer
:checkhealth codecompanion " AI assistant
```

### Check Error Messages

```vim
:messages     " Recent error messages
:LspInfo      " LSP server status
```

### Get More Help

- **Debug Python issues:** See [Debugging Guide](debugging.md)
- **Configure AI properly:** See [CodeCompanion Setup](codecompanion.md)
- **Add custom features:** See [Customization Guide](customization.md)
- **Find all keybindings:** See [Complete Keybindings](keybindings.md)

### Nuclear Option

**Start fresh:** `nvim --clean` (loads no configuration)
**Reset config:** `git checkout HEAD~1 && nix build`

## Advanced Debugging

**Only if basic fixes don't work:**

### Enable Debug Logging

```vim
:set verbose=9
:redir > debug.log
# Reproduce issue
:redir END
:edit debug.log
```

### Emergency Recovery

- **Completely stuck:** `<C-c>` then `:qa!`
- **Config broken:** `nvim --clean` to start fresh
- **Can't save:** `:w !sudo tee %` to force save

### Still Stuck?

1. **Check messages:** `:messages`
2. **Ask AI about the error:** Select error text → `<leader>ac`
3. **Create issue:** Include `:checkhealth` and `:messages` output
