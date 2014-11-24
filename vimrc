execute pathogen#infect()
" Helptags

" important general settings
set nocompatible
syntax on
filetype on
filetype plugin on

" encoding options
set fileencoding=utf-8
set encoding=utf-8

" convenience options
set number
set linebreak
set hidden
set ruler                         " Show current line and column position in file
set title                         " Show file title in terminal tab
set cursorline                    " Highlight current line
set scrolloff=3
set wildmenu                      " Enhanced command line completion.
set wildmode=longest,list         " Complete files like a shell.

" every day editing options
set backspace=indent,eol,start
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Don't save swap files.
set history=100
set autoread                      " Reload files changed outside vim
set clipboard=unnamedplus
set nrformats-=octal              " 0-prefixed numbers are still decimal

" status line options
set laststatus=2                  " Show status line
set showmode                      " Show what mode you’re currently in
set showcmd                       " Show what commands you’re typing
set modeline                      " Allow modelines

" runtime options
runtime macros/matchit.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" indententation options
filetype indent on
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround                    " round > and < to multiples of shiftwidth

" autocommands
autocmd BufWritePre * :%s/\s\+$//e " removes trailing whitespace on save
au! BufNewFile,BufRead *.erb,*.haml,*.mote setf html
" au! BufNewFile,BufRead *.erb,*.rhtml,*.mote setf eruby

" general mappings
map <F2> :NERDTreeToggle<CR>

" search options
set incsearch
set hlsearch " highlighting search matches
set ignorecase
set smartcase
set gdefault

" splits options and shortcuts
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-K> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-L> <C-W><C-L> "Ctrl-l to move right a split
nnoremap <C-H> <C-W><C-H> "Ctrl-h to move left a split

let g:ctrlp_show_hidden = 1

" editing relative to the current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" configure the deliMate plugin so that the '<' char
" isn't automatically matched
let delimitMate_matchpairs = "(:),[:],{:}"

" fixes and workarounds
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" remap the up & down keys when scrolling through
" the command line history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

:nmap j gj
:nmap k gk
:nmap <C-n> :bnext<CR>
:nmap <C-p> :bprev<CR>

colorscheme solarized
set background=dark

if has('gui_running')
  set guifont=Monospace\ 12
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif
