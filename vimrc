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
set wildmode=full                 " Complete files like a shell.

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
set statusline=%y\ %f\ %=TL:\ %L
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

" tab navigation shortcuts
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

let mapleader=","

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

" UI options
colorscheme solarized
set background=dark
