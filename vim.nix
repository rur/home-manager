{ pkgs, ... }:

let
  vim-tmux-navigator = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-tmux-navigator";
    src = pkgs.fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-tmux-navigator";
      rev = "cdd66d6a37d991bba7997d593586fc51a5b37aa8";
      hash = "sha256-gF1b5aBQTNQm2hCY5aR+RSU4cCNG356Yg6uPnlgqS4o=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      colorscheme gruvbox
      let g:context_nvim_no_redraw = 1
      set mouse=a
      set number
      set termguicolors
    '';
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      gruvbox-community
      vim-airline
      vim-nix
      vim-tmux-navigator
    ]; # Only loaded if programs.neovim.extraConfig is set
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
