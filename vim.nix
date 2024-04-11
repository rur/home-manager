{ pkgs, ... }:
let
  #.... this is an example of fetching a plugin not found in nixpkgs
  vim-delve = pkgs.vimUtils.buildVimPlugin {
    name = "vim-delve";
    src = pkgs.fetchFromGitHub {
      owner = "sebdah";
      repo = "vim-delve";
      rev = "41d6ad294fb6dd5090f5f938318fc4ed73b6e1ea";
      sha256 = "sha256-wMDTMMvtjkPaWtlV6SWlQ5B7YVsJ4gjPZKPactW8HAE=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    plugins = with pkgs.vimPlugins; [
      ale
      vim-fugitive
      nvim-cmp
      cmp-buffer
      cmp-cmdline
      cmp_luasnip
      cmp-path
      cmp-nvim-lsp
      comment-nvim
      friendly-snippets
      luasnip
      nord-nvim
      onehalf
      null-ls-nvim
      nvim-autopairs
      nvim-lspconfig
      plenary-nvim
      popup-nvim
      telescope-nvim
      vim-nix

      lightline-vim
      splitjoin-vim
      tabular
      vim-mundo
      vim-polyglot
      vim-gitgutter
      nvim-tree-lua
      bufferline-nvim
      editorconfig-nvim

      vim-go
      vim-delve

      true-zen-nvim
    ];
    extraConfig = ''
      set encoding=utf-8
      set t_Co=256                      " moar colors
      set nocompatible                  " nocompatible is good for humans
      syntax enable                     " enable syntax highlighting...
      filetype plugin indent on         " depending on filetypes...
      runtime macros/matchit.vim        " with advanced matching capabilities
      set timeout tm=1000 ttm=10        " fix slight delay after pressing Esc then O
      set autoread                      " auto load files if vim detects change
      set autowrite                     " auto write files when moving around
      set nobackup                      " disable backup files...
      set noswapfile                    " and swap files
      set shortmess+=I                  " disable intro message

      " Style
      set termguicolors
      set background=dark
      silent! color gruvbox8
      set number                        " line numbers are cool
      set ruler                         " show the cursor position all the time
      set nocursorline                  " disable cursor line
      set showcmd                       " display incomplete commands
      set novisualbell                  " no flashes please
      set scrolloff=3                   " provide some context when editing
      set hidden                        " allow backgrounding buffers without writing them, and

      " Lua Configuration
      set runtimepath^=${./nvim}
      luafile ${./nvim}/init.lua
    '';
  };
}
