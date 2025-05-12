{
  config,
  pkgs,
  lib,
  ...
}: {
  # Add health check configuration under config
  config = {
    extraConfigLua = ''
      -- Create a custom health module for the NixVim configuration
      _G.nixvim_health = {}
      
      -- Health check implementation
      _G.nixvim_health.check = function()
        local health = require('vim.health')
        local start = health.start
        local ok = health.ok
        local warn = health.warn
        local error = health.error
        local info = health.info
        
        -- Check if optional dependencies are enabled in config
        local optional_deps_enabled = ${if config.nixvim-config.enableOptionalDeps then "true" else "false"}
        
        -- Check search tools
        start("Checking search tools")
        
        -- Check ripgrep
        if vim.fn.executable("rg") == 1 then
          ok("Ripgrep is installed")
        else
          if optional_deps_enabled then
            warn("Ripgrep was enabled in config but executable not found")
          else
            info("Ripgrep is not installed (enable with enableOptionalDeps)")
            info("  Without Ripgrep, live grep searches will be slower")
          end
        end
        
        -- Check fd
        if vim.fn.executable("fd") == 1 then
          ok("fd is installed")
        else
          if optional_deps_enabled then
            warn("fd was enabled in config but executable not found")
          else
            info("fd is not installed (enable with enableOptionalDeps)")
            info("  Without fd, file finding will use slower alternatives")
          end
        end
        
        -- Check optional document processing tools
        start("Checking document processing tools")
        
        -- Check ImageMagick
        local has_magick = vim.fn.executable("magick") == 1 or vim.fn.executable("convert") == 1
        if has_magick then
          ok("ImageMagick is installed")
        else
          if optional_deps_enabled then
            warn("ImageMagick was enabled in config but executable not found")
          else
            info("ImageMagick is not installed (enable with enableOptionalDeps)")
            info("  Without ImageMagick, only PNG images can be displayed")
          end
        end
        
        -- Check Ghostscript
        if vim.fn.executable("gs") == 1 then
          ok("Ghostscript is installed")
        else
          if optional_deps_enabled then
            warn("Ghostscript was enabled in config but executable not found")
          else
            info("Ghostscript is not installed (enable with enableOptionalDeps)")
            info("  Without Ghostscript, PDF files cannot be rendered")
          end
        end
        
        -- Check LaTeX
        local has_latex = vim.fn.executable("tectonic") == 1 or vim.fn.executable("pdflatex") == 1
        if has_latex then
          ok("LaTeX compiler is installed")
        else
          if optional_deps_enabled then
            warn("LaTeX was enabled in config but executable not found")
          else
            info("LaTeX compiler is not installed (enable with enableOptionalDeps)")
            info("  Without LaTeX, math expressions cannot be rendered")
          end
        end
        
        -- Check Mermaid CLI
        if vim.fn.executable("mmdc") == 1 then
          ok("Mermaid CLI is installed")
        else
          if optional_deps_enabled then
            warn("Mermaid CLI was enabled in config but executable not found")
          else
            info("Mermaid CLI is not installed (enable with enableOptionalDeps)")
            info("  Without Mermaid CLI, diagrams cannot be rendered")
          end
        end
      end
    '';

    # Use the new submodule syntax for extraFiles
    extraFiles = {
      "lua/health/nixvim.lua" = {
        text = ''
          -- Health check module for NixVim
          return {
            check = function()
              -- Call the global health check function
              return _G.nixvim_health.check()
            end
          }
        '';
      };
    };
  };
}
