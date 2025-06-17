# CodeCompanion AI Setup (5-minute guide)

Quick setup for AI-assisted coding with Claude, OpenAI, or local models.

## 1. Set API Key

```bash
# Choose one:
export ANTHROPIC_API_KEY="your-claude-key"
export OPENAI_API_KEY="your-openai-key"
```

## 2. Create Config File

Create `~/.config/nvim/lua/codecompanion-config.lua`:

### For Claude:

```lua
return {
  strategies = {
    chat = { adapter = "claude" },
    inline = { adapter = "claude" },
  },
  adapters = {
    claude = {
      name = "claude",
      url = "https://api.anthropic.com",
      env = { api_key = "ANTHROPIC_API_KEY" },
      headers = {
        ["content-type"] = "application/json",
        ["anthropic-version"] = "2023-06-01",
      },
      parameters = {
        model = "claude-3-5-sonnet-20241022",
        max_tokens = 8192,
        temperature = 0.3,
      },
    },
  },
}
```

### For OpenAI:

```lua
return {
  strategies = {
    chat = { adapter = "openai" },
    inline = { adapter = "openai" },
  },
  adapters = {
    openai = {
      name = "openai",
      url = "https://api.openai.com/v1/chat/completions",
      env = { api_key = "OPENAI_API_KEY" },
      headers = { ["content-type"] = "application/json" },
      parameters = {
        model = "gpt-4",
        max_tokens = 4096,
        temperature = 0.3,
      },
    },
  },
}
```

## 3. Usage

| Key          | Description              |
| ------------ | ------------------------ |
| `<leader>ai` | Open AI chat             |
| `<leader>ac` | Chat about selected code |
| `<leader>aa` | Show AI actions          |

## Quick Snippets

Use these in Neovim to generate configurations quickly:

- `ccconfig<Tab>` - Full configuration template
- `claude<Tab>` - Claude provider
- `openai<Tab>` - OpenAI provider

## Troubleshooting

- **"Not configured" error**: Check config file exists and environment variable is set
- **API errors**: Verify your API key is valid and has credits
- **Connection issues**: Check internet connection and API endpoint URLs

### Rate Limiting

Configure rate limiting for API calls:

```lua
parameters = {
  model = "your-model",
  max_tokens = 4096,
  temperature = 0.3,
  -- Provider-specific rate limiting handled by API
},
```

### Multiple Providers

You can configure multiple providers and switch between them:

```lua
adapters = {
  claude = { ... }, -- For general coding
  openai = { ... }, -- For specific tasks
  local_model = { ... }, -- For privacy-sensitive work
},

strategies = {
  chat = {
    adapter = "claude", -- Default for chat
  },
  inline = {
    adapter = "local_model", -- Use local for inline suggestions
  },
},
```

### Environment-Specific Configuration

Create different configurations for different environments:

```lua
-- Check environment and adjust configuration
local env = os.getenv("NVIM_ENV") or "development"

local config = {
  strategies = {
    chat = {
      adapter = env == "work" and "local_model" or "claude",
    },
  },
  -- ... rest of config
}

return config
```

## Integration with Other Tools

### Git Integration

CodeCompanion works well with git workflows:

1. **Commit Message Generation**: Select diff, ask AI to write commit message
2. **Code Review**: Select changed code, ask for review
3. **Merge Conflict Resolution**: Ask AI to help resolve conflicts

### LSP Integration

CodeCompanion complements LSP features:

- **LSP provides**: Syntax, definitions, references
- **AI provides**: Explanations, suggestions, refactoring ideas
- **Together**: Complete development assistance

### Terminal Integration

Use CodeCompanion with terminal commands:

1. Run command in terminal (`<leader>tt`)
2. Copy error output
3. Ask AI for help with the error (`<leader>ai`)

## Performance Tips

### Optimizing Response Times

- Use shorter prompts for faster responses
- Adjust `max_tokens` based on expected response length
- Consider using faster models for simple tasks

### Managing API Costs

- Monitor your API usage through provider dashboards
- Use `max_tokens` to limit response length
- Consider local models for frequent, simple tasks

### Caching Responses

While CodeCompanion doesn't cache responses directly, you can:

- Save useful responses as snippets
- Create prompt templates for common tasks
- Use git to version control your configurations

## Contributing

### Adding New Providers

To add support for a new AI provider:

1. Create a new snippet template
2. Follow the existing provider structure
3. Test thoroughly with the new API
4. Update documentation

### Custom Actions

Extend CodeCompanion with custom actions:

```lua
-- In your configuration
custom_actions = {
  ["explain_with_examples"] = {
    prompt = "Explain this code and provide practical examples",
    placement = "chat",
  },
},
```

## Resources

- **CodeCompanion Documentation**: [Official Docs](https://github.com/olimorris/codecompanion.nvim)
- **API Documentation**:
  - [Anthropic Claude API](https://docs.anthropic.com/claude/reference/)
  - [OpenAI API](https://platform.openai.com/docs)
- **Local Models**:
  - [vLLM](https://vllm.readthedocs.io/)
  - [Ollama](https://ollama.ai/)
  - [LocalAI](https://localai.io/)

## Frequently Asked Questions

**Q: Can I use multiple API keys?**
A: Yes, set different environment variables for each provider and reference them in your configuration.

**Q: How do I switch between providers?**
A: Modify the `adapter` field in your strategies, or create multiple strategies.

**Q: Can I use local models?**
A: Yes, use the `vllm<Tab>` snippet and configure it to point to your local server.

**Q: Is my code sent to the AI provider?**
A: Yes, selected code is sent to the configured API. Use local models for sensitive code.

**Q: How do I update my configuration?**
A: Edit `~/.config/nvim/lua/codecompanion-config.lua` and restart Neovim, or use `:source %` to reload.

**Q: Can I create custom prompts?**
A: Yes, add them to the `prompt_library` section of your configuration, or create new snippets.
