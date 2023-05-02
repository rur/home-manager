{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      colorscheme gruvbox
      let g:context_nvim_no_redraw = 1
      set mouse=a
      set number
      set termguicolors

" NERD Tree Config
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
      autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

      " Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

    '';
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      gruvbox-community
      vim-airline
      vim-nix
      vim-fugitive
      vim-gitgutter
      nerdtree
    ]; # Only loaded if programs.neovim.extraConfig is set
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
