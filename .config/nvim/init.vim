let mapleader=" "

" Install vim-plug if necessary
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
    endif

" Load Plugins with vim-plug
    call plug#begin('~/.vim/plugged')
    
"    Plug 'altercation/vim-colors-solarized'
    Plug 'scrooloose/nerdtree'
    Plug 'w0rp/ale'
    Plug 'itchyny/lightline.vim'
    
    call plug#end()

" General
	set nocompatible
	filetype plugin indent on
	syntax on
	set encoding=utf-8
	set number
	set relativenumber
	
	set background=dark
"	colorscheme solarized

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
	set softtabstop=4
	set expandtab

" Code folding with space
	set foldmethod=indent
	set foldlevel=99

	nnoremap <space> za

" Statusline
    let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ }

" NERDTree file explorer
	map <C-n> :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  "Closes NERDTree with VIM

" netrw
