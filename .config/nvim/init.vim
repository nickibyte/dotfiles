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
	Plug 'ledger/vim-ledger'
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

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

" Remove trailing whitespace on save
	autocmd BufWritePre * %s/\s\+$//e

" Statusline
	let g:lightline = {
		\ 'colorscheme': 'gruvbox',
		\ 'active': {
		\	'right': [ [ 'time' ],
		\			   [ 'lineinfo' ],
		\			   [ 'fileformat', 'fileencoding', 'filetype' ] ]
		\ },
		\ 'component': {
		\	'time': "[%{strftime('%-I:%M')}]"
		\ },
		\ }
	set noshowmode

" Ledger
	au BufNewFile,BufRead *.dat setf ledger | comp ledger

	let g:ledger_date_format = '%Y-%m-%d'
	let g:ledger_decimal_sep = ','
	let g:ledger_default_commodity = '€'
	let g:ledger_commodity_before = 0
	let g:ledger_commodity_sep = ' '
	let g:ledger_align_at = 50

	" Copied from Justyn Shull's Blog (https://justyn.io/blog/automatically-sort-and-align-ledger-transactions-in-vim)
	function LedgerSort()
		:%! ledger -f - print --sort 'date, amount' --date-format '\%Y-\%m-\%d'
		:%LedgerAlign
	endfunction
	command LedgerSort call LedgerSort()

" Markdown
	set conceallevel=2
	let g:pandoc#syntax#conceal#use = 1
	let g:pandoc#syntax#conceal#urls = 1
	let g:pandoc#spell#enabled = 0

" Zettelkasten

	" Create Zettel
	" Copied from Vimways.org (https://vimways.org/2019/personal-notetaking-in-vim) and slightly modified
	function ZetEdit(...)

	  " build the file name (YYYYMMDDHHMM_lowercase-title-with-dashes-instead-of-spaces)
	  let l:sep = ''
	  if len(a:000) > 0
		let l:sep = '_'
	  endif
	  let l:fname = expand('~/zet/') . strftime("%Y%m%d%H%M") . l:sep . tolower(join(a:000, '-')) . '.md'

	  " edit the new file
	  exec "e " . l:fname

	  " enter pandoc YAML header (title, date, keywords) in the new file, move cursor to keywords section and enter insert mode
	  if len(a:000) > 0
		exec "normal ggO---\<cr>title: '" . join(a:000) . "'\<cr>date: '\<c-r>=strftime('%Y-%m-%d')\<cr>'\<cr>keywords: []\<cr>---\<cr>\<esc>2k0f]"
		exec "startinsert"
	  else
		exec "normal ggO---\<cr>title: ''\<cr>date: '\<c-r>=strftime('%Y-%m-%d')\<cr>'\<cr>keywords: []\<cr>---\<cr>\<esc>4k0f'l"
		exec "startinsert"
	  endif
	endfunction
	command -nargs=* Zet call ZetEdit(<f-args>)
