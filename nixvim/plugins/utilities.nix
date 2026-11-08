# Utility plugins
{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      # Text alignment
      tabular

      # Snacks.nvim for terminal and notifications
      snacks-nvim
    ];

    extraConfigLua = ''
      -- Snacks.nvim setup for terminal and notifications
      require("snacks").setup({
        terminal = { enabled = true },
        notifier = { enabled = true },
      })
    '';
  };
}
