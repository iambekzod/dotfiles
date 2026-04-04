set nocompatible
filetype plugin indent on

" display settings
set encoding=utf-8
set ruler
set showmatch
set showmode

" Formatting
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab

" etc
set nu
set lbr
set mouse=a
set autochdir
set title
set ttyfast

" Remap `jj` to Esc
imap jj <Esc>

" Search
set hlsearch
set ignorecase
set incsearch
set smartcase

" press F8 to turn the search results highlight off
noremap <F8> :nohl<CR>
inoremap <F8> <Esc>:nohl<CR>a

" Colorscheme
syntax on
let &t_Co = 256
set background=dark
colorscheme desert

" Return to last edit position when opening files
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
