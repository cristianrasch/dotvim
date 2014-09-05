execute pathogen#infect()
" Helptags

set nocompatible
set encoding=utf-8
set linebreak
set hidden
set number
set laststatus=2                  " Show status line
set statusline=%y\ %f\ %=TL:\ %L
set showmode                      " Show what mode you’re currently in
set showcmd                       " Show what commands you’re typing
set modeline                      " Allow modelines
set ruler                         " Show current line and column position in file
set title                         " Show file title in terminal tab
set cursorline                    " Highlight current line
set scrolloff=3
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Don't save swap files.
set background=dark
set history=100
set autoread                      " Reload files changed outside vim
set clipboard=unnamedplus

syntax on
" colorscheme solarized
filetype on
filetype plugin on

runtime macros/matchit.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Indententation
filetype indent on
set autoindent
set ts=2 sts=2 sw=2 expandtab

" Removes trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

map <F2> :NERDTreeToggle<CR>

" Search
set incsearch
set hlsearch " highlighting search matches
set ignorecase
set smartcase

" Splits
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-K> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-L> <C-W><C-L> "Ctrl-l to move right a split
nnoremap <C-H> <C-W><C-H> "Ctrl-h to move left a split

" Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" Edit relative to the current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

let delimitMate_matchpairs = "(:),[:],{:}"
