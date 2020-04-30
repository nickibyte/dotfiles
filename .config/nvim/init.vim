"
" Nickibyte's  init.vim
"


" Install vim-plug if necessary
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
    endif

" Load Plugins with vim-plug
    call plug#begin('~/.config/nvim/plugged')

    Plug 'morhetz/gruvbox'
    Plug 'itchyny/lightline.vim'
    Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'w0rp/ale'
    
    call plug#end()

" General
	set nocompatible
	filetype plugin indent on
	syntax on
	set encoding=utf-8
	set number
	set relativenumber
	set colorcolumn=80

	" Only display cursorline in current window
	augroup CursorLine
	  au!
	  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	  au WinLeave * setlocal nocursorline
	augroup END

	set termguicolors
	set background=dark
	let g:gruvbox_contrast_dark='medium'
	colorscheme gruvbox

	let mapleader=" "

" Clear search highlighting
	nnoremap <silent> <cr> :noh<CR><CR>

" Split navigation with CTRL + hjkl
	set splitbelow
	set splitright

	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Indentation
	set tabstop=4
	set shiftwidth=4
	set softtabstop=0
	set noexpandtab

" Code folding
	set foldmethod=indent
	set foldlevel=99

" Copy/paste to clipboard
	set clipboard+=unnamedplus

	vnoremap <leader>y "+y
	nnoremap <leader>y "+y
	nnoremap <leader>Y "+yg_

	nnoremap <leader>p "+p
	nnoremap <leader>P "+P
	vnoremap <leader>p "+p
	vnoremap <leader>P "+P

" Statusline
	let g:lightline={}
    let g:lightline.colorscheme='gruvbox'

" netrw
