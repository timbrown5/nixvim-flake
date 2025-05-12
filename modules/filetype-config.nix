{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Filetype-specific configurations with error handling
    extraConfigLua = ''
      -- Create an augroup for filetype-specific settings
      local filetype_group = vim.api.nvim_create_augroup("filetype_settings", { clear = true })
      
      -- Safe keymap function
      local function safe_keymap(mode, key, action, opts)
        local ok, error = pcall(vim.keymap.set, mode, key, action, opts)
        if not ok then
          vim.notify("Failed to set keymap " .. key .. ": " .. tostring(error), vim.log.levels.ERROR)
        end
      end
      
      -- Nix specific settings
      vim.api.nvim_create_autocmd("FileType", {
        group = filetype_group,
        pattern = "nix",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.commentstring = "# %s"
          
          -- Key mappings for nix files
          safe_keymap("n", "<leader>ne", ":edit flake.nix<CR>", { buffer = true, desc = "Edit flake.nix" })
          safe_keymap("n", "<leader>nb", ":!nix build<CR>", { buffer = true, desc = "Run nix build" })
          safe_keymap("n", "<leader>nf", ":!nix flake update<CR>", { buffer = true, desc = "Update flake inputs" })
        end
      })
      
      -- Lua specific settings
      vim.api.nvim_create_autocmd("FileType", {
        group = filetype_group,
        pattern = "lua",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          
          -- Expand 'vim.' when typing 'v.'
          safe_keymap("i", "v.", "vim.", { buffer = true })
          
          -- Get quick help with K
          safe_keymap("n", "K", function()
            local ok, _ = pcall(vim.lsp.buf.hover)
            if not ok then
              vim.notify("LSP hover not available", vim.log.levels.WARN)
            end
          end, { buffer = true, silent = true })
        end
      })
      
      -- Terraform/HCL specific settings
      vim.api.nvim_create_autocmd("FileType", {
        group = filetype_group,
        pattern = { "terraform", "tf", "hcl" },
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          
          -- Key mappings for terraform files
          safe_keymap("n", "<leader>ti", ":!terraform init<CR>", { buffer = true, desc = "Terraform init" })
          safe_keymap("n", "<leader>tp", ":!terraform plan<CR>", { buffer = true, desc = "Terraform plan" })
          safe_keymap("n", "<leader>ta", ":!terraform apply<CR>", { buffer = true, desc = "Terraform apply" })
          safe_keymap("n", "<leader>tv", ":!terraform validate<CR>", { buffer = true, desc = "Terraform validate" })
        end
      })
      
      -- Python specific settings
      vim.api.nvim_create_autocmd("FileType", {
        group = filetype_group,
        pattern = "python",
        callback = function()
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.expandtab = true
          
          -- Ruff configuration for formatting
          vim.g.python_formatter = "ruff"
          
          -- Key mappings for python files
          safe_keymap("n", "<leader>pr", ":!python %<CR>", { buffer = true, desc = "Run Python file" })
          safe_keymap("n", "<leader>pt", ":!pytest<CR>", { buffer = true, desc = "Run pytest" })
          safe_keymap("n", "<leader>pf", function()
            -- Format with ruff
            local ok, _ = pcall(vim.lsp.buf.format, { async = true, name = "ruff-lsp" })
            if not ok then
              vim.notify("Ruff formatter not available", vim.log.levels.WARN)
            end
          end, { buffer = true, desc = "Format with Ruff" })
          safe_keymap("n", "<leader>pi", function()
            -- Format and organize imports with ruff
            local params = {
              command = "ruff.organizeImports",
              arguments = { vim.uri_from_bufnr(0) },
            }
            local ok, _ = pcall(vim.lsp.buf.execute_command, params)
            if not ok then
              vim.notify("Ruff organize imports not available", vim.log.levels.WARN)
            end
          end, { buffer = true, desc = "Organize imports with Ruff" })
        end
      })
    '';
  };
}
