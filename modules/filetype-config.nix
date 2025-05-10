{
  config,
  pkgs,
  lib,
  ...
}: {
  # Filetype-specific configurations
  extraConfigLua = ''
    -- Create an augroup for filetype-specific settings
    local filetype_group = vim.api.nvim_create_augroup("filetype_settings", { clear = true })
    
    -- Nix specific settings
    vim.api.nvim_create_autocmd("FileType", {
      group = filetype_group,
      pattern = "nix",
      callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.commentstring = "# %s"
        
        -- Key mappings for nix files
        vim.keymap.set("n", "<leader>ne", ":edit flake.nix<CR>", { buffer = true, desc = "Edit flake.nix" })
        vim.keymap.set("n", "<leader>nb", ":!nix build<CR>", { buffer = true, desc = "Run nix build" })
        vim.keymap.set("n", "<leader>nf", ":!nix flake update<CR>", { buffer = true, desc = "Update flake inputs" })
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
        vim.keymap.set("i", "v.", "vim.", { buffer = true })
        
        -- Get quick help with K
        vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", { buffer = true, silent = true })
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
        vim.keymap.set("n", "<leader>ti", ":!terraform init<CR>", { buffer = true, desc = "Terraform init" })
        vim.keymap.set("n", "<leader>tp", ":!terraform plan<CR>", { buffer = true, desc = "Terraform plan" })
        vim.keymap.set("n", "<leader>ta", ":!terraform apply<CR>", { buffer = true, desc = "Terraform apply" })
        vim.keymap.set("n", "<leader>tv", ":!terraform validate<CR>", { buffer = true, desc = "Terraform validate" })
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
        vim.keymap.set("n", "<leader>pr", ":!python %<CR>", { buffer = true, desc = "Run Python file" })
        vim.keymap.set("n", "<leader>pt", ":!pytest<CR>", { buffer = true, desc = "Run pytest" })
        vim.keymap.set("n", "<leader>pf", function()
          -- Format with ruff
          vim.lsp.buf.format({ async = true, name = "ruff-lsp" })
        end, { buffer = true, desc = "Format with Ruff" })
        vim.keymap.set("n", "<leader>pi", function()
          -- Format and organize imports with ruff
          local params = {
            command = "ruff.organizeImports",
            arguments = { vim.uri_from_bufnr(0) },
          }
          vim.lsp.buf.execute_command(params)
        end, { buffer = true, desc = "Organize imports with Ruff" })
      end
    })
  '';
}
