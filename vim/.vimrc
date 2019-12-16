runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

set nocompatible

set t_Co=256
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r

syntax on               " enable syntax highlighting
colorscheme solarized
set background=dark

filetype plugin indent on
autocmd BufRead *.sql set filetype=mysql

set number
set laststatus=2
set noruler

set hidden

set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab
set nowrap
set list
set backspace=indent,eol,start
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set hlsearch
set incsearch
set ignorecase
set showmatch

hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

" enable paste mode on <F2>
set pastetoggle=<F2>

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" highlight characters that go over 80 columns
if exists('+colorcolumn')
    set colorcolumn=81
    highlight ColorColumn ctermbg=red
else
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endif

" font on windows
if has("gui_running")
  if has("gui_win32")
" dirty hack
    set lines=999 columns=999
    set guifont=Consolas:h11:cANSI
  endif
endif
