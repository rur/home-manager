" General settings {{{
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
                                  " remember marks/undo for backgrounded buffers
" Mouse
set mouse=a                       " we love the mouse
if !has('nvim')
  set ttymouse=xterm2             " and we want it to be fast
endif
set mousehide                     " but hide it when we're writing

" Whitespace
set wrap                          " wrap long lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set softtabstop=2                 " when deleting, treat spaces as tabs
set expandtab                     " use spaces, not tabs
set list                          " show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set autoindent                    " keep indentation level when no indent is found

" Wild life
set wildmenu                      " wildmenu gives autocompletion to vim
set wildmode=list:longest,full    " autocompletion shouldn't jump to the first match
set wildignore+=*.scssc,*.sassc,*.csv,*.pyc,*.xls,*.rbi
set wildignore+=tmp/**,node_modules/**,bower_components/**

" List chars
set listchars=""                  " reset the listchars
set listchars=tab:▸\ ,eol:¬       " a tab should display as "▸ ", end of lines as "¬"
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " the character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " the character to show in the first column when wrap is
                                  " off and the line continues beyond the left of the screen
set fillchars+=vert:\             " set vertical divider to empty space

" Searching
set hlsearch                      " highlight matches...
nohlsearch                        " but don't highlight last search when reloading
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " unless they contain at least one capital letter

" Windows
set splitright                    " create new horizontal split on the right
set splitbelow                    " create new vertical split below the current window

" Status line
set laststatus=2
" }}}

" FileType settings {{{
if has("autocmd")
  " in Makefiles use real tabs, not tabs expanded to spaces
  augroup filetype_make
    au!
    au FileType make setl ts=8 sts=8 sw=8 noet
  augroup END

  " make sure all markdown files have the correct filetype set and setup wrapping
  augroup filetype_markdown
    au!
    au FileType markdown setl tw=75 | syntax sync fromstart
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
  augroup END

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  augroup filetype_python
    au!
    au FileType python setl sts=4 ts=4 sw=4
  augroup END

  " delete Fugitive buffers when they become inactive
  augroup filetype_fugitive
    au!
    au BufReadPost fugitive://* set bufhidden=delete
  augroup END

  " fold automatically with triple {
  augroup filetype_vim
    au!
    au FileType vim,javascript,python,c setlocal foldmethod=marker nofoldenable
  augroup END

  " enable <CR> in command line window and quickfix
  augroup enable_cr
    au!
    au CmdwinEnter * nnoremap <buffer> <CR> <CR>
    au BufWinEnter quickfix nnoremap <buffer> <CR> <CR>
  augroup END

  " disable automatic comment insertion
  augroup auto_comments
    au!
    au FileType * setlocal formatoptions-=ro
  augroup END

  " disable numbers in terminal windows
  if has('nvim')
    augroup terminal_numbers
      au!
      au TermOpen * setlocal nonumber
    augroup END
  endif

  " fold multiline haskell comments
  augroup haskell_comments
    au!
    au FileType haskell setlocal foldmethod=marker foldmarker={-,-}
  augroup END

  " run all formatters
  if !exists('g:vscode')
    augroup fmt
      au!
      au BufWritePre * Neoformat
    augroup END

    " remember last location in file, but not for commit messages,
    " or when the position is invalid or inside an event handler,
    " or when the mark is in the first line, that is the default
    " position when opening a file. See :help last-position-jump
    augroup last_position
      au!
      au BufReadPost *
        \ if &filetype !~ '^git\c' && line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    augroup END
  endif
endif
" }}}

" Mappings {{{
let mapleader=','

" Y u no consistent?
nnoremap Y y$

" disable man page for word under cursor
nnoremap K <Nop>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

" expand %% to current directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>
nmap <Leader>e :e %%

" easy way to switch between latest files
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>vs :execute "vsplit " . bufname("#")<CR>
nnoremap <Leader>sp :execute "split " . bufname("#")<CR>

" find merge conflict markers
nnoremap <silent> <Leader>cf <Esc>/\v^[<=>]{7}( .*\|$)<CR>

" show colorcolumn
nnoremap <silent> <Leader>sc :set colorcolumn=80<CR>

" copy current path
nnoremap <silent> <Leader>p :let @* = expand("%")<CR>

" easy substitutions
nnoremap <Leader>r :%s///gc<Left><Left><Left>
nnoremap <Leader>R :%s:::gc<Left><Left><Left>

" remove whitespaces and windows EOL
command! KillWhitespace :normal :%s/\s\+$//e<CR><C-O><CR>
command! KillControlM :normal :%s/<C-V><C-M>//e<CR><C-O><CR>
nnoremap <Leader>kw :KillWhitespace<CR>
nnoremap <Leader>kcm :KillControlM<CR>

" easy global search
nnoremap <C-S> :Rg <C-R><C-W><CR>
vnoremap <C-S> y<Esc>:Rg <C-R>"<CR>

" easier navigation between split windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

nnoremap <M-p> :GFiles<CR>
nnoremap <M-P> :Files<CR>

" disable cursor keys in normal mode
nnoremap <Left>  :echo "no!"<CR>
nnoremap <Right> :echo "no!"<CR>
nnoremap <Up>    :echo "no!"<CR>
nnoremap <Down>  :echo "no!"<CR>

