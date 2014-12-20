""""""""""""""""""" PLUGINS
runtime macros/matchit.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/csapprox'  " make GVim colorschemes work in terminal Vim
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
" Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'digitaltoad/vim-jade'
Plugin 'tpope/vim-unimpaired'
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()

"""""""""""""""""""" GLOBAL SETTINGS

" basic config
set nocompatible " disable vi compatibility
set ttyfast
set modelines=0 " prevent some security exploits
set encoding=utf-8
set scrolloff=3       " show 3 lines context when scrolling
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set backspace=indent,eol,start
set laststatus=2      " always show a status line
set undofile
set mouse=a
set wrap
set textwidth=79
set formatoptions=qrn1
" set colorcolumn=85

" tabs/spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" central backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" open new split panes to the right and bottom
set splitbelow
set splitright

""""""""""""""""""""""""" SEARCH

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" set foldmethod=indent
" set foldlevelstart=1

""""""""""""""""""""""""" MAPPINGS

let mapleader = ","

nnoremap <leader><space> :noh<cr>    " exit search

nnoremap j gj
nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap jj <ESC>

nnoremap <leader>e :E<CR> " open netrw file explorer in directory of current buffer
nnoremap <leader>_ <C-w>v<C-w>l " open vertical pane to the left
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>w :bprevious<CR>:bdelete #<CR> " close the current buffer without closing the window
nnoremap <leader><leader> <C-^>       " switch between the last two buffers

" replace word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/

"""""""""""""""""""""" APPEARANCE

colorscheme railscasts

set cursorline
set title
set ruler
set number
syntax on
filetype plugin indent on


"""""""""""""""""""""" PLUGIN CONFIG

" airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#enabled=0
" let g:airline#extensions#tabline#left_sep=' '      " vertical separators in
" tabline
" let g:airline#extensions#tabline#left_alt_sep = '|'

" NERDtree
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" bufexplorer

nnoremap <leader>b :BufExplorer<CR>

" CtrlP

let g:ctrlp_custom_ignore = 'node_modules'
" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


"""""""""""""""""""""" CUSTOM FUNCTIONS

" Toggle relative/absolute line numbering
function! NumberToggle()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	endif
endfunc

nnoremap <F10> :call NumberToggle()<CR>   " toggle from relativenumber back to number does not work
