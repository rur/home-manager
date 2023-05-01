{ pkgs, ... }: {
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
    ]; # Only loaded if programs.neovim.extraConfig is set
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
