# Core Neovim options and settings
{
  programs.nixvim.opts = {
    # File handling
    backup = false;
    swapfile = false;
    writebackup = false;
    autoread = true;
    autowrite = true;
    undofile = true;

    # UI
    number = true;
    relativenumber = false;
    cursorline = true;
    signcolumn = "yes";
    termguicolors = true;
    showmode = false;
    showcmd = true;
    ruler = true;
    scrolloff = 8;
    sidescrolloff = 8;
    wrap = false;

    # Editing
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    smartindent = true;

    # Spell checking
    spelloptions = "noplainbuffer,camel";

    # Search
    hlsearch = true;
    ignorecase = true;
    smartcase = true;

    # Completion
    completeopt = ["menuone" "noselect"];
    pumheight = 10;

    # Performance
    updatetime = 300;
    timeoutlen = 1000;

    # Splits
    splitbelow = true;
    splitright = true;

    # Clipboard
    clipboard = "unnamedplus";

    # Misc
    mouse = "a";
    fileencoding = "utf-8";
    conceallevel = 0;
    cmdheight = 2;
    showtabline = 2;
    numberwidth = 4;
    hidden = true;
  };

  programs.nixvim.extraConfigVim = ''
    set encoding=utf-8
    set t_Co=256
    set nocompatible
    syntax enable
    filetype plugin indent on
    runtime macros/matchit.vim
    set timeout tm=1000 ttm=10
    set novisualbell
    set whichwrap+=<,>,[,],h,l
    set formatoptions-=cro
  '';

  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
}
