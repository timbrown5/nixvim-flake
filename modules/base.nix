{
  pkgs,
  lib,
  config,
  ...
}: {
  # Using standard NixVim options pattern
  options = {
    nixvim-config = {
      enableOptionalDeps = lib.mkOption {
        type = lib.types.bool;
        description = "Enable all optional dependencies (ripgrep, fd, imagemagick, etc.)";
        default = false;
      };
    };
  };

  # All configuration should be in the config attribute
  config = {
    # Import Lua configuration from separate file
    extraConfigLua = builtins.readFile ../lua/base.lua;
  };
}
