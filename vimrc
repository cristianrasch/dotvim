" Helptags

" Important general settings
set nocompatible
syntax on
filetype plugin on

" Runtime options
runtime macros/matchit.vim
set rtp+=~/.fzf

" Encoding options
set fileencoding=utf-8
set encoding=utf-8

" Convenience options
set number
set relativenumber
set linebreak
set hidden
set ruler                          " Show current line and column position in file
set title                          " Show file title in terminal tab
set cursorline                     " Highlight current line
set cursorcolumn                   " Enable column highlighting
set showmatch                      " highlight matching [{()}]
set scrolloff=3
set wildmenu                       " Enhanced command line completion.
set wildmode=list:longest,full
set wildignore+=*/tmp/*,*.so,*.swp
set noerrorbells
set visualbell
set lazyredraw                     " redraw only when we need to
" set spell
set spelllang=en_us
" set spelllang=en_us,es_es,de_de
set mouse=

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
" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
" mkdir -p ~/.Vim/{swap,backup}
set swapfile
set directory^=~/.Vim/swap//
" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.1.0251")
  " consolidate the writebackups -- not a big
  " deal either way, since they usually get deleted
  set backupdir^=~/.Vim/backup//
end
set noundofile
set backspace=indent,eol,start
set history=200
set autoread                       " Reload files changed outside vim
set clipboard=unnamedplus
set nrformats-=octal               " 0-prefixed numbers are still decimal
set nrformats+=alpha               " Ctrl-X/Ctrl-A can increment letters too
set list
set listchars=nbsp:·,tab:▸\ ,eol:¬ " Invisible characters, à la TextMate
set wrap
set textwidth=119                  " Text wrapping
set colorcolumn=120                " 120 column
set synmaxcol=256                  " Don't highlight syntax pass this column
set switchbuf=useopen
set pastetoggle=<F3>
" Open file under cursor in a new vertical split
map <C-w>f <C-w>vgf
map <C-w>F <C-w>vgF " GOTO selected line number

" Highlight trailing whitespace
match ErrorMsg '\s\+$'
autocmd BufWritePre * :%s/\s\+$//e " removes trailing whitespace on save

" Editing shortcuts
nnoremap Y y$
let mapleader = "\<Space>"
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Split edit your vimrc. Type space, v, r in sequence to trigger
nmap <leader>vr :tabe $MYVIMRC<cr>
" Source (reload) your vimrc. Type space, s, o in sequence to trigger
nmap <leader>so :source $MYVIMRC<cr>
" cmap w!! w !sudo tee > /dev/null % " sudo write
" shortcuts for 3-way merge
map <Leader>1 :diffget LOCAL<CR>
map <Leader>2 :diffget BASE<CR>
map <Leader>3 :diffget REMOTE<CR>
map <Leader>w :w<CR>
map <leader>D :put =strftime('# %a %Y-%m-%d %H:%M:%S%z')<CR>
if has("patch-8.1.0360")
  set diffopt+=internal,algorithm:patience
endif

" Search options
set incsearch
set hlsearch                      " highlighting search matches
set ignorecase
set smartcase                     " don't ignore capitals in searches
set gdefault
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" open ack.vim
nnoremap <leader>a :Ack<space>
nnoremap <leader>l :LAck<space>
nnoremap <C-p> :GFiles --exclude-standard --others --cached<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>/ :Rg<Space>
map <leader>* :Ack <cword><CR>
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
set magic                         " For regular expressions turn magic on
" Turn on vim's very magic mode
" nnoremap / /\v
" vnoremap / /\v
" Make . work w/ visually selected lines
vnoremap . :normal.<CR>

" Status line options
set laststatus=2                  " Show status line
set showmode                      " Show what mode you're currently in
set showcmd                       " Show what commands you're typing
set modeline                      " Allow modelines

" Filetype mappings
autocmd BufRead,BufNewFile *.md setfiletype markdown
autocmd BufNewFile *.sh 0r ~/skeletons/bash.sh
" autocmd BufNewFile readme.md 0r ~/skeletons/readme.md

let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'javascript', 'vim']

" Navigation options
let s:default_path = escape(&path, '\ ') " store default value of 'path'
" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
autocmd BufRead *.rb,*.rake,*.js,*.py
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path
set suffixesadd+=.rb,.js,.py

" Navigation mappings
" Move vertically by visual line
:nmap j gj
:nmap k gk
" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Split options
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>w <C-W>w
nnoremap <silent> <leader>s :split<CR>
nnoremap <silent> <leader>v :vsplit<CR>
nnoremap <silent> <leader>q :close<CR>
noremap <silent> <leader>z :tab split<CR>

" Buffer navigation
nnoremap <leader>q :bd! <enter>

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
colorscheme gruvbox
" set t_Co=256

" GUI options
if has('gui_running')
  set lines=40 columns=99
  set guifont=Monospace\ 12
  set guioptions-=m           "remove menu bar
  set guioptions-=T           "remove toolbar
  set guioptions-=r           "remove right-hand scroll bar
  set guioptions-=L           "remove left-hand scroll bar
endif

set background=dark
" if hostname() == "laptop"
"   set background=light
" else
"   set background=dark
" endif

" Fixes & workarounds
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" Macro helpers
xnoremap Q :'<,'>:normal @q<CR>

" Plugin mappings
map <F2> :Vex<CR>
" map <F2> :Lexplore<CR>

" Plugin configs

let g:camelcasemotion_key = ','

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:rustfmt_autosave = 1

let g:netrw_liststyle = 3
let g:netrw_banner = 0
" 1 = horiz split, 2 vert split, 3 new tab, 4 prev win
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
let g:netrw_hide = 1
let g:netrw_dirhistmax = 0

let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml']

let g:user_emmet_install_global = 0
autocmd FileType html,css,eruby EmmetInstall
let g:user_emmet_settings = {
\  'xml' : {
\    'extends' : 'html',
\  },
\  'erb' : {
\    'extends' : 'html',
\  },
\  'htmldjango' : {
\    'extends' : 'html',
\  },
\}

let g:autotagCtagsCmd='ctags --recurse --languages=ruby,python .'
let g:autotagStopAt='/home/cristian/Documents/workspace'

" Copy the contents of the quickfix list to the args list
" This gives you a command called :Qargs which copies the items from your quickfix list
" into your args list
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

let g:ale_use_global_executables = 1
let g:ale_fix_on_save = 0
let g:ale_linters_explicit = 1
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:javascript_prettier_executable = 1
:nmap ]e :ALENextWrap<CR>
:nmap [e :ALEPreviousWrap<CR>
:nmap ]E :ALELast
:nmap [E :ALEFirst

" if getcwd() =~# '^\(/some/safe/path/\|/another/safe/path/\)'
if getcwd() =~# '^\(/home/cristian/Documents/workspace/\)'
  set secure exrc
endif

let g:vim_vue_plugin_config = {
  \'syntax': {
  \ 'template': ['html'],
  \ 'script': ['javascript'],
  \ 'style': ['css'],
  \},
  \'full_syntax': [],
  \'attribute': 0,
  \'keyword': 0,
  \'foldexpr': 0,
  \'init_indent': 0,
  \'debug': 0,
  \}
