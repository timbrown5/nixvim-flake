# Python Debugging Guide

Python debugging is ready out-of-the-box with DAP (Debug Adapter Protocol).

## Quick Start

1. **Set a breakpoint**: Navigate to line, press `<leader>Db`
2. **Start debugging**: Press `<leader>Dc`, select "Launch file"
3. **Debug**: Use step commands (`<leader>Di`, `<leader>Dj`, `<leader>Do`)

## Debug Controls

| Key          | Description                |
| ------------ | -------------------------- |
| `<leader>Db` | Toggle breakpoint          |
| `<leader>DB` | Set conditional breakpoint |
| `<leader>Dl` | Set log point              |
| `<leader>Dc` | Start/Continue debugging   |
| `<leader>Dr` | Restart debugging          |
| `<leader>Dt` | Terminate debugging        |
| `<leader>Di` | Step into                  |
| `<leader>Dj` | Step over                  |
| `<leader>Do` | Step out                   |
| `<leader>Du` | Toggle DAP UI              |
| `<leader>De` | Evaluate expression        |

## Step-by-Step Debug Session

### 1. Set Breakpoints

```python
# example.py
def calculate(x, y):
    result = x + y  # <- Set breakpoint here (<leader>Db)
    return result * 2

def main():
    numbers = [1, 2, 3, 4, 5]
    for num in numbers:
        value = calculate(num, 10)  # <- Another breakpoint
        print(f"Result: {value}")

if __name__ == "__main__":
    main()
```

### 2. Start Debugging

- Press `<leader>Dc`
- Select "Launch file"
- DAP UI opens automatically

### 3. Debug Workflow

1. **When stopped at breakpoint**: Inspect variables in DAP UI
2. **Step through code**: `<leader>Di` (into), `<leader>Dj` (over)
3. **Evaluate expressions**: Select code → `<leader>De`
4. **Continue execution**: `<leader>Dc`

## Visual Indicators

- 🔴 **Breakpoint** - Red circle in sign column
- 🟡 **Conditional Breakpoint** - Yellow circle
- 📝 **Log Point** - Notebook icon
- ➡️ **Current Position** - Arrow showing execution point

## Advanced Features

### Conditional Breakpoints

1. Press `<leader>DB`
2. Enter condition: `x > 10`
3. Breakpoint only triggers when condition is true

### Log Points

1. Press `<leader>Dl`
2. Enter message: `Value is {x}`
3. Logs message without stopping execution

### Evaluate Expressions

- **Visual mode**: Select variable → `<leader>De`
- **DAP Console**: Type Python expressions directly
- **Variables panel**: Expand objects to see properties

## Troubleshooting

**Debugger not starting?**

- Check Python is in PATH: `which python3`
- Verify debugpy installed: `python3 -m pip install debugpy`
- Run `:checkhealth` to verify DAP setup

**Breakpoints not working?**

- Ensure file is saved before debugging
- Check breakpoint icon appears in sign column
- Verify Python syntax is correct

**Variables not showing?**

- Make sure DAP UI is open (`<leader>Du`)
- Check you're stopped at a breakpoint
- Variables only show in current scope

## Configuration

The debugging setup is pre-configured, but you can customize:

```lua
-- In your config (already included)
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return "python3"
    end,
  },
}
```

## Tips

- **Multi-file projects**: Breakpoints work across all Python files
- **Virtual environments**: Debugger respects your current Python environment
- **Import errors**: Use step-into to debug module loading issues
- **Performance**: Use step-over for library code, step-into for your code
