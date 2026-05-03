# NixVim configuration - modular setup
# This is the main entry point that imports all nixvim modules
{ pkgs, ... }:
{
  imports = [
    # Core configuration
    ./nixvim/core/options.nix
    ./nixvim/core/keymaps.nix

    # UI components
    ./nixvim/ui/colorscheme.nix
    ./nixvim/ui/nvim-tree.nix
    ./nixvim/ui/bufferline.nix
    ./nixvim/ui/statusline.nix

    # Plugin modules
    ./nixvim/plugins/lsp.nix
    ./nixvim/plugins/completion.nix
    ./nixvim/plugins/treesitter.nix
    ./nixvim/plugins/telescope.nix
    ./nixvim/plugins/git.nix
    ./nixvim/plugins/editing.nix
    ./nixvim/plugins/claude-code.nix
    ./nixvim/plugins/language-specific.nix
    ./nixvim/plugins/utilities.nix
  ];

  programs.nixvim = {
    enable = true;

    # Set aliases
    viAlias = true;
    vimAlias = true;
  };
}
