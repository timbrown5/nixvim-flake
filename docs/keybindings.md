# Complete Keybindings Reference

**Leader key:** `<Space>`

This configuration uses functional namespaces to organize keybindings by purpose rather than plugin. For complete Neovim documentation, see `:help` or visit [Neovim Documentation](https://neovim.io/doc/).

## Basic Operations

| Key          | Mode   | Description                   |
| ------------ | ------ | ----------------------------- |
| `<leader>W`  | Normal | Save file                     |
| `<leader>WQ` | Normal | Save all and quit all windows |
| `<leader>qq` | Normal | Quit all windows              |
| `<leader>QQ` | Normal | Quit all without saving       |
| `jk`         | Insert | Exit insert mode              |
| `U`          | Normal | Redo                          |

## Movement & Navigation

| Key           | Mode   | Description                       |
| ------------- | ------ | --------------------------------- |
| `<C-h/j/k/l>` | Normal | Navigate between windows          |
| `<C-d>`       | Normal | Jump down and center              |
| `<C-u>`       | Normal | Jump up and center                |
| `n`           | Normal | Next search result and center     |
| `N`           | Normal | Previous search result and center |

## Line/Selection Movement

| Key     | Mode   | Description                   |
| ------- | ------ | ----------------------------- |
| `<A-j>` | Normal | Move line down                |
| `<A-k>` | Normal | Move line up                  |
| `<A-j>` | Visual | Move selection down           |
| `<A-k>` | Visual | Move selection up             |
| `<`     | Visual | Indent left (stay in visual)  |
| `>`     | Visual | Indent right (stay in visual) |

## Window Management

| Key          | Mode   | Description               |
| ------------ | ------ | ------------------------- |
| `<leader>wv` | Normal | Split window vertically   |
| `<leader>wh` | Normal | Split window horizontally |
| `<leader>we` | Normal | Make windows equal size   |
| `<leader>wx` | Normal | Close current window      |

## Tab Management

| Key          | Mode   | Description                    |
| ------------ | ------ | ------------------------------ |
| `<leader>to` | Normal | Open new tab                   |
| `<leader>tx` | Normal | Close current tab              |
| `<leader>tn` | Normal | Go to next tab                 |
| `<leader>tp` | Normal | Go to previous tab             |
| `<leader>tf` | Normal | Open current buffer in new tab |

## File Explorer ([Snacks.nvim](https://github.com/folke/snacks.nvim))

| Key         | Mode   | Description          |
| ----------- | ------ | -------------------- |
| `<C-n>`     | Normal | Toggle file explorer |
| `<leader>/` | Normal | Open file explorer   |

## Fuzzy Finding ([Snacks.nvim](https://github.com/folke/snacks.nvim))

| Key          | Mode   | Description                 |
| ------------ | ------ | --------------------------- |
| `<leader>ff` | Normal | Find files                  |
| `<leader>fw` | Normal | Live grep (search in files) |
| `<leader>fb` | Normal | Find buffers                |
| `<leader>fh` | Normal | Find help                   |
| `<leader>fr` | Normal | Recent files                |
| `<leader>fd` | Normal | Find diagnostics            |
| `<leader>fs` | Normal | Find symbols                |
| `<leader>fc` | Normal | Find commands               |
| `<leader>fk` | Normal | Find keymaps                |

## Buffer Management

| Key          | Mode   | Description                                                                  |
| ------------ | ------ | ---------------------------------------------------------------------------- |
| `<leader>vs` | Normal | View buffer switcher ([Snipe.nvim](https://github.com/leath-dub/snipe.nvim)) |
| `<leader>bf` | Normal | Format buffer with Conform                                                   |
| `<leader>bp` | Normal | Paste clipboard over buffer                                                  |
| `<leader>bd` | Normal | Delete all of buffer                                                         |
| `<leader>bD` | Normal | Delete all without copying                                                   |
| `<leader>bs` | Normal | Select entire buffer                                                         |

## Code & Formatting ([Conform.nvim](https://github.com/stevearc/conform.nvim))

| Key          | Mode   | Description                   |
| ------------ | ------ | ----------------------------- |
| `<leader>cf` | Normal | Format buffer with Conform    |
| `<leader>cF` | Visual | Format selection with Conform |

## View & Visual Operations

| Key           | Mode   | Description                   |
| ------------- | ------ | ----------------------------- |
| `<leader>vd`  | Normal | View dashboard                |
| `<leader>vh`  | Normal | View motion hints (temporary) |
| `<leader>vH`  | Normal | Toggle motion hints           |
| `<leader>vi`  | Normal | View image preview            |
| `<leader>vc`  | Normal | View clipboard image          |
| `<leader>vs`  | Normal | View buffer switcher          |
| `<leader>vhc` | Normal | View health check             |

## Notifications

| Key          | Mode   | Description               |
| ------------ | ------ | ------------------------- |
| `<leader>nh` | Normal | Show notification history |
| `<leader>nd` | Normal | Dismiss notifications     |
| `<leader>nt` | Normal | Test notification         |

## Git Operations ([Gitsigns](https://github.com/lewis6991/gitsigns.nvim))

| Key          | Mode   | Description           |
| ------------ | ------ | --------------------- |
| `<leader>gb` | Normal | Git blame line        |
| `<leader>gd` | Normal | Git diff current file |
| `<leader>gs` | Normal | Git stage hunk        |
| `<leader>gu` | Normal | Git unstage hunk      |
| `<leader>gr` | Normal | Git reset hunk        |
| `<leader>gp` | Normal | Git preview hunk      |
| `<leader>gn` | Normal | Git next hunk         |
| `<leader>gN` | Normal | Git previous hunk     |

## LSP (Language Server Protocol)

See [LSP documentation](https://neovim.io/doc/user/lsp.html) for more details.

### Quick Navigation

| Key  | Mode   | Description           |
| ---- | ------ | --------------------- |
| `gd` | Normal | Go to definition      |
| `gr` | Normal | Go to references      |
| `gi` | Normal | Go to implementation  |
| `gt` | Normal | Go to type definition |
| `K`  | Normal | Hover documentation   |

### Actions

| Key          | Mode   | Description   |
| ------------ | ------ | ------------- |
| `<leader>ca` | Normal | Code action   |
| `<leader>rn` | Normal | Rename symbol |

### LSP Menu (`<leader>l`)

| Key           | Mode   | Description                |
| ------------- | ------ | -------------------------- |
| `<leader>lf`  | Normal | Format document (LSP only) |
| `<leader>lh`  | Normal | Hover documentation        |
| `<leader>la`  | Normal | Code action                |
| `<leader>ln`  | Normal | Rename                     |
| `<leader>ls`  | Normal | Signature help             |
| `<leader>lgd` | Normal | Go to definition           |
| `<leader>lgr` | Normal | Go to references           |
| `<leader>lgi` | Normal | Go to implementation       |
| `<leader>lgt` | Normal | Go to type definition      |
| `<leader>lwa` | Normal | Add workspace folder       |
| `<leader>lwr` | Normal | Remove workspace folder    |

## Diagnostics

| Key          | Mode   | Description                  |
| ------------ | ------ | ---------------------------- |
| `[d`         | Normal | Previous diagnostic          |
| `]d`         | Normal | Next diagnostic              |
| `<leader>dp` | Normal | Previous diagnostic          |
| `<leader>dn` | Normal | Next diagnostic              |
| `<leader>df` | Normal | Show diagnostic float        |
| `<leader>dq` | Normal | Send diagnostics to quickfix |

## Debugging (DAP)

See [Debugging Guide](debugging.md) for complete debugging setup and usage.

| Key          | Mode          | Description                |
| ------------ | ------------- | -------------------------- |
| `<leader>Db` | Normal        | Toggle breakpoint          |
| `<leader>DB` | Normal        | Set conditional breakpoint |
| `<leader>Dl` | Normal        | Set log point              |
| `<leader>Dc` | Normal        | Continue debugging         |
| `<leader>Dr` | Normal        | Restart debugging          |
| `<leader>Dt` | Normal        | Terminate debugging        |
| `<leader>Di` | Normal        | Step into                  |
| `<leader>Dj` | Normal        | Step over                  |
| `<leader>Do` | Normal        | Step out                   |
| `<leader>Du` | Normal        | Toggle DAP UI              |
| `<leader>De` | Normal/Visual | Evaluate expression        |

## Extended Clipboard Operations

| Key          | Mode          | Description                            |
| ------------ | ------------- | -------------------------------------- |
| `<leader>xd` | Normal/Visual | Delete without copying to register     |
| `x`          | Normal        | Delete char without copying            |
| `<leader>xp` | Normal/Visual | Paste from yank register               |
| `<leader>P`  | Normal        | Paste from yank register before cursor |
| `<leader>xy` | Normal/Visual | Yank to system clipboard               |
| `<leader>Y`  | Normal        | Yank line to system clipboard          |

## Snippets

See [Snippet Management Guide](snippets.md) for complete snippet usage.

| Key          | Mode          | Description                                                 |
| ------------ | ------------- | ----------------------------------------------------------- |
| `<leader>sc` | Normal/Visual | Create new snippet (prefills from selection in visual mode) |
| `<leader>se` | Normal        | Edit existing snippets                                      |
| `<C-.>`      | Insert/Select | Expand snippet or jump to next placeholder                  |
| `<C-,>`      | Insert/Select | Jump to previous placeholder                                |

## AI Assistant (CodeCompanion)

See [CodeCompanion Setup Guide](codecompanion.md) for configuration details.

| Key          | Mode   | Description                 |
| ------------ | ------ | --------------------------- |
| `<leader>ai` | Normal | Open AI chat                |
| `<leader>ac` | Visual | Chat with current selection |
| `<leader>aa` | Normal | Show available actions      |

## Terminal

| Key          | Mode     | Description        |
| ------------ | -------- | ------------------ |
| `<leader>tt` | Normal   | Toggle terminal    |
| `<Esc><Esc>` | Terminal | Exit terminal mode |

## Surround Operations (Mini.nvim)

See [mini.nvim documentation](https://github.com/echasnovski/mini.nvim) for complete module documentation.

| Key                 | Mode   | Description             |
| ------------------- | ------ | ----------------------- |
| `sa` / `<leader>sa` | Normal | Add surrounding         |
| `sd` / `<leader>sd` | Normal | Delete surrounding      |
| `sr` / `<leader>sr` | Normal | Replace surrounding     |
| `sf` / `<leader>sf` | Normal | Find surrounding        |
| `<leader>sF`        | Normal | Find surrounding (left) |
| `<leader>sh`        | Normal | Highlight surrounding   |
| `<leader>sn`        | Normal | Update n lines          |

## Mini.nvim Modules

### Mini.comment

| Key   | Mode          | Description    |
| ----- | ------------- | -------------- |
| `gc`  | Normal/Visual | Toggle comment |
| `gcc` | Normal        | Comment line   |

### Mini.jump

| Key | Mode   | Description             |
| --- | ------ | ----------------------- |
| `f` | Normal | Jump forward to char    |
| `F` | Normal | Jump backward to char   |
| `t` | Normal | Jump forward till char  |
| `T` | Normal | Jump backward till char |
| `;` | Normal | Repeat forward jump     |
| `,` | Normal | Repeat backward jump    |

## Custom Commands

| Command               | Description                                   |
| --------------------- | --------------------------------------------- |
| `:checkhealth nixvim` | Run NixVim configuration health check         |
| `:FormatDisable`      | Disable autoformat-on-save globally           |
| `:FormatDisable!`     | Disable autoformat-on-save for current buffer |
| `:FormatEnable`       | Re-enable autoformat-on-save                  |
| `:FormatInfo`         | Show available formatters for current buffer  |

## Keybind Organization

This configuration uses **functional namespaces** rather than plugin-specific ones. Keybindings are organized by what you want to accomplish, not which plugin provides the functionality.

### Keybind Namespaces

| Namespace    | Purpose                 | Examples                                                        |
| ------------ | ----------------------- | --------------------------------------------------------------- |
| `<leader>a*` | **AI Assistant**        | Chat, actions, code analysis                                    |
| `<leader>b*` | **Buffer operations**   | Format, delete, select, paste over                              |
| `<leader>c*` | **Code operations**     | Format with specific tools, actions                             |
| `<leader>d*` | **Diagnostics**         | Navigate diagnostics, show information                          |
| `<leader>f*` | **Find & Search**       | Files, text, buffers, help, recent                              |
| `<leader>g*` | **Git operations**      | Blame, diff, stage, reset, navigate hunks                       |
| `<leader>l*` | **Language Server**     | LSP-specific actions, workspace management                      |
| `<leader>n*` | **Notifications**       | Show history, dismiss, test                                     |
| `<leader>s*` | **Snippets & Surround** | Create/edit snippets, surround text objects                     |
| `<leader>t*` | **Terminal & Tabs**     | Toggle terminal, tab management                                 |
| `<leader>v*` | **View & Visual**       | Dashboard, images, buffer switcher, health check                |
| `<leader>w*` | **Window Management**   | Split, resize, close windows                                    |
| `<leader>x*` | **Extended Clipboard**  | Delete without yank, paste from yank register, system clipboard |
| `<leader>D*` | **Debug operations**    | Breakpoints, stepping, DAP UI                                   |

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
