{
  pkgs,
  lib,
  ...
}:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      # Language-specific formatters with priority order
      formatters_by_ft = {
        python = [
          "ruff_format"
          "black"
        ]; # Ruff first, Black fallback
        javascript = [ "prettier" ]; # Prettier for JS
        typescript = [ "prettier" ]; # Prettier for TS
        json = [
          "jq"
          "prettier"
        ]; # jq first, prettier fallback
        yaml = [
          "yq"
          "prettier"
        ]; # yq first, prettier fallback
        markdown = [ "prettier" ]; # Prettier for Markdown
        lua = [ "stylua" ]; # StyLua for Lua
        nix = [ "nixfmt" ]; # nixfmt for Nix
        rust = [ "rustfmt" ]; # rustfmt for Rust
        go = [
          "gofmt"
          "goimports"
        ]; # gofmt first, goimports fallback
        sh = [ "shfmt" ]; # shfmt for shell scripts
        css = [ "prettier" ]; # Prettier for CSS
        html = [ "prettier" ]; # Prettier for HTML
        xml = [ "prettier" ]; # Prettier for XML
      };

      # Auto-format on save with LSP fallback
      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true; # This is the key! Falls back to LSP if no formatter
      };

      # Formatter configurations
      formatters = {
        ruff_format = {
          command = "ruff";
          args = [
            "format"
            "--stdin-filename"
            "$FILENAME"
            "-"
          ];
          stdin = true;
        };

        black = {
          command = "black";
          args = [
            "--quiet"
            "-"
          ];
          stdin = true;
        };

        prettier = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "$FILENAME"
          ];
          stdin = true;
        };

        stylua = {
          command = "stylua";
          args = [ "-" ];
          stdin = true;
        };

        nixfmt = {
          command = "nixfmt";
          stdin = true;
        };

        rustfmt = {
          command = "rustfmt";
          args = [
            "--emit"
            "stdout"
          ];
          stdin = true;
        };

        gofmt = {
          command = "gofmt";
          stdin = true;
        };

        goimports = {
          command = "goimports";
          stdin = true;
        };

        shfmt = {
          command = "shfmt";
          args = [
            "-i"
            "2"
          ];
          stdin = true;
        };

        jq = {
          command = "jq";
          args = [ "." ];
          stdin = true;
        };

        yq = {
          command = "yq";
          args = [ "." ];
          stdin = true;
        };

        ruff_organize_imports = {
          command = "ruff";
          args = [
            "check"
            "--select"
            "I"
            "--fix"
            "--stdin-filename"
            "$FILENAME"
            "-"
          ];
          stdin = true;
        };
      };
    };
  };

  extraPackages = with pkgs; [
    ripgrep
    fd
  ];

  extraFiles = {
    "lua/plugins/conform.lua".source = ../lua/plugins/conform.lua;
  };

  # Load the conform Lua configuration
  extraConfigLua = ''
    require('plugins.conform')
  '';
}
