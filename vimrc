call pathogen#infect()                      " use pathogen
" Helptags

" Important general settings
set nocompatible
syntax on
filetype on
filetype plugin on

" Runtime options
runtime macros/matchit.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Encoding options
set fileencoding=utf-8
set encoding=utf-8

" Convenience options
set number
set linebreak
set hidden
set ruler                          " Show current line and column position in file
set title                          " Show file title in terminal tab
set cursorline                     " Highlight current line
set showmatch                      " highlight matching [{()}]
set scrolloff=3
set wildmenu                       " Enhanced command line completion.
set wildmode=longest,list          " Complete files like a shell.
set visualbell
set lazyredraw                     " redraw only when we need to

" Indententation options
filetype indent on
set autoindent
set smartindent
set tabstop=2                      " number of visual spaces per TAB
set softtabstop=2                  " number of spaces in tab when editing
set shiftwidth=2
set expandtab                      " tabs are spaces
set shiftround                     " round > and < to multiples of shiftwidth

" Everyday editing options
set undodir=~/.Vim/undo
set backup
set backupdir=~/.Vim/bkp
set writebackup
set directory=~/.Vim/swp
" set nobackup                       " Don't make a backup before overwriting a file.
" set nowritebackup                  " And again.
" set noswapfile                     " Don't save swap files.
set backspace=indent,eol,start
set history=100
set autoread                       " Reload files changed outside vim
set clipboard=unnamedplus
set nrformats-=octal               " 0-prefixed numbers are still decimal
set list
set listchars=nbsp:·,tab:▸\ ,eol:¬ " Invisible characters, à la TextMate
set colorcolumn=80                 " 80 column
autocmd BufWritePre * :%s/\s\+$//e " removes trailing whitespace on save
augroup autoSaveAndRead
  autocmd!
  autocmd TextChanged,InsertLeave,FocusLost * silent! wall
  autocmd CursorHold * silent! checktime
augroup END

" Editing shortcuts
nnoremap Y y$
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
cmap w!! w !sudo tee > /dev/null % " sudo write

" Search options
set incsearch
set hlsearch                      " highlighting search matches
set infercase
set smartcase
set gdefault
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" open ag.vim
nnoremap <leader>a :Ag<space>
" Turn on vim's very magic mode
nnoremap / /\v
vnoremap / /\v

" Status line options
set laststatus=2                  " Show status line
set showmode                      " Show what mode you're currently in
set showcmd                       " Show what commands you're typing
set modeline                      " Allow modelines

" Filetype mappings
autocmd BufRead,BufNewFile *.md setfiletype markdown

" Navigation mappings
" Move vertically by visual line
:nmap j gj
:nmap k gk

" Split options
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap to  :tabonly<CR>

" Remap the up & down keys when scrolling through " the command line history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Visual block mode
" Move selected block up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Easier window resizing
function! s:try_wincmd(cmd, default)
  if exists(':' . a:cmd)
    let cmd = v:count ? join([a:cmd, v:count]) : a:cmd
    execute cmd
  else
    execute join([v:count, 'wincmd', a:default])
  endif
endfunction
nnoremap <silent> <C-Up>    :<C-u>call <SID>try_wincmd('ObviousResizeUp',    '+')<CR>
nnoremap <silent> <C-Down>  :<C-u>call <SID>try_wincmd('ObviousResizeDown',  '-')<CR>
nnoremap <silent> <C-Left>  :<C-u>call <SID>try_wincmd('ObviousResizeLeft',  '<')<CR>
nnoremap <silent> <C-Right> :<C-u>call <SID>try_wincmd('ObviousResizeRight', '>')<CR>

" Coloring options
set t_Co=256
" colorscheme solarized
" set background=dark

" GUI options
if has('gui_running')
  set lines=40 columns=99
  set guifont=Monospace\ 12
  set guioptions-=m           "remove menu bar
  set guioptions-=T           "remove toolbar
  set guioptions-=r           "remove right-hand scroll bar
  set guioptions-=L           "remove left-hand scroll bar
endif

" Fixes & workarounds
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" Macro helpers
xnoremap Q :'<,'>:normal @q<CR>

" Plugin mappings
map <F2> :NERDTreeToggle<CR>

" Plugin configuration
" CamelCaseMotion
call camelcasemotion#CreateMotionMappings(',')
" Ctrlp
" let g:ctrlp_map = '<c-p>'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path = 0
" Make Ctrl-P plugin lot faster for git projects
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

let g:rustfmt_autosave = 1
