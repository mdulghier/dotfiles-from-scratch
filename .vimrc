" basic config
set nocompatible " disable vi compatibility
set ttyfast
set modelines=0 " prevent some security exploits

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'altercation/solarized', { 'rtp': 'vim-colors-solarized' }
Plugin 'jonathanfilip/vim-lucius'

call vundle#end()


" theme & appearance
set background=dark
colorscheme lucius
" call togglebg#map("<F5>")

set cursorline
set title
set ruler
set relativenumber
syntax on
filetype plugin indent on

" tabs/spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set backspace=indent,eol,start
set laststatus=2
set undofile
set mouse=a

" central backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

let mapleader = ","

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" quit search
nnoremap <leader><space> :noh<cr>

nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

nnoremap j gj
nnoremap k gk

" unmap F1 key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" jj as alternative ESC to keep fingers on the home row
inoremap jj <ESC>

" open new pane to the left of the current pane
nnoremap <leader>w <C-w>v<C-w>l

" pane navigation
nnoremap <C-h> <C-w>h   " to left pane
nnoremap <C-j> <C-w>j   " to pane below
nnoremap <C-k> <C-w>k   " to pane above
nnoremap <C-l> <C-w>l   " to right pane


" NERDtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

