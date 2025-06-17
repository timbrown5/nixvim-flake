{ pkgs, lib, ... }:
{
  # CodeCompanion - user manages configuration via snippets
  plugins.codecompanion.enable = true;

  # CodeCompanion keybindings
  keymaps = [
    {
      key = "<leader>ai";
      action = "<cmd>CodeCompanion<CR>";
      mode = "n";
      options.desc = "Open CodeCompanion chat";
    }
    {
      key = "<leader>ac";
      action = "<cmd>CodeCompanionChat<CR>";
      mode = "v";
      options.desc = "CodeCompanion chat with selection";
    }
    {
      key = "<leader>aa";
      action = "<cmd>CodeCompanionActions<CR>";
      mode = "n";
      options.desc = "CodeCompanion actions";
    }
  ];
}
