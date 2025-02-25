" Helptags

" =====================================================
" BASIC CONFIGURATION
" =====================================================
set nocompatible
syntax on
filetype plugin on
filetype indent on
let mapleader = "\<Space>"

" =====================================================
" RUNTIME AND ENCODING
" =====================================================
runtime macros/matchit.vim
set rtp+=~/.fzf
set fileencoding=utf-8
set encoding=utf-8

" =====================================================
" VISUAL APPEARANCE AND DISPLAY
" =====================================================
set number
set relativenumber
set linebreak
set ruler                          " Show current line and column position in file
set title                          " Show file title in terminal tab
set cursorline                     " Highlight current line
set cursorcolumn                   " Enable column highlighting
set showmatch                      " highlight matching [{()}]
set scrolloff=3
set noerrorbells
set visualbell
set lazyredraw                     " redraw only when we need to
set list
set listchars=nbsp:·,tab:▸\ ,eol:¬ " Invisible characters, à la TextMate
set wrap
set textwidth=100                   " Text wrapping
set colorcolumn=101
set synmaxcol=256                  " Don't highlight syntax pass this column

" Highlight trailing whitespace
match ErrorMsg '\s\+$'
autocmd BufWritePre * :%s/\s\+$//e " removes trailing whitespace on save

" =====================================================
" COLORS AND THEMES
" =====================================================
colorscheme gruvbox
" set t_Co=256
set background=dark
" if hostname() == "laptop"
"   set background=light
" else
"   set background=dark
" endif

" =====================================================
" INDENTATION AND FORMATTING
" =====================================================
set autoindent
set smartindent
set tabstop=2                      " number of visual spaces per TAB
set softtabstop=2                  " number of spaces in tab when editing
set shiftwidth=2
set expandtab                      " tabs are spaces
set shiftround                     " round > and < to multiples of shiftwidth

" =====================================================
" FILE AND BUFFER MANAGEMENT
" =====================================================
set hidden
set swapfile
set directory^=~/.Vim/swap//
" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
set backupdir^=~/.Vim/backup//
set noundofile
set autoread                       " Reload files changed outside vim
set switchbuf=useopen
" Updates your current buffer (saves it). Then it closes all open buffers, then it
" reopens the last buffer
command Bd :up | %bd | e#
nmap <Leader>bd :Bd<CR>

" =====================================================
" SPELL CHECKING
" =====================================================
" set spell
set spelllang=en_us,es_es
" set spelllang=en_us,es_es,de_de

" =====================================================
" SEARCH OPTIONS
" =====================================================
set incsearch
set hlsearch                      " highlighting search matches
set ignorecase
set smartcase                     " don't ignore capitals in searches
set gdefault
set magic                         " For regular expressions turn magic on
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Turn on vim's very magic mode
" nnoremap / /\v
" vnoremap / /\v

" =====================================================
" COMMAND-LINE AND STATUS LINE OPTIONS
" =====================================================
set wildmenu                       " Enhanced command line completion.
set wildmode=list:longest,full
set wildignore+=*/tmp/*,*.so,*.swp
set laststatus=2                  " Show status line
set showmode                      " Show what mode you're currently in
set showcmd                       " Show what commands you're typing
set modeline                      " Allow modelines

" =====================================================
" EDITING AND TEXT MANIPULATION
" =====================================================
set backspace=indent,eol,start
set history=200
set clipboard=unnamedplus
set nrformats-=octal               " 0-prefixed numbers are still decimal
set nrformats+=alpha               " Ctrl-X/Ctrl-A can increment letters too
set pastetoggle=<F3>
set mouse=

" Editing shortcuts
nnoremap Y y$
let mapleader = "\<Space>"
" reselect pasted text
nnoremap gp `[v`]
" Make . work w/ visually selected lines
vnoremap . :normal.<CR>
" sudo write
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" cmap w!! w !sudo tee > /dev/null % " sudo write

" Macro helpers
xnoremap Q :'<,'>:normal @q<CR>

" =====================================================
" NAVIGATION AND MOVEMENT
" =====================================================
" Move vertically by visual line
:nmap j gj
:nmap k gk
" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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
set suffixesadd+=.rb,.py,.js,.rs

" =====================================================
" WINDOW AND SPLIT MANAGEMENT
" =====================================================
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" nnoremap <leader>w <C-W>w " already mapped to save buffer contents
nnoremap <silent> <leader>s :split<CR>
nnoremap <silent> <leader>v :vsplit<CR>
nnoremap <silent> <leader>x :close<CR>
noremap <silent> <leader>z :tab split<CR>

" Open file under cursor in a new vertical split
map <C-w>f <C-w>vgf
map <C-w>F <C-w>vgF " GOTO selected line number

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

" =====================================================
" BUFFER NAVIGATION
" =====================================================
nnoremap <leader>q :bd! <enter>
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" copy the path to the current file path into your system clipboard
map <leader>ap :let @+=expand("%:p")<CR> " absolute path
map <leader>rp :let @+=expand("%")<CR> " relative path
map <leader>dn :let @+=expand("%:p:h")<CR> " directory name
map <leader>fn :let @+=expand("%:t")<CR> " file name
map <leader>ln :let @+=fnamemodify(expand("%"), ":~:.") . ":" . line(".")<CR>
map <leader>w :w<CR>

" =====================================================
" TAB NAVIGATION
" =====================================================
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap to  :tabonly<CR>

" =====================================================
" VIMRC MANAGEMENT
" =====================================================
" Split edit your vimrc. Type space, v, r in sequence to trigger
nmap <leader>vr :vsp $MYVIMRC<cr>
" Source (reload) your vimrc. Type space, s, o in sequence to trigger
nmap <leader>so :source $MYVIMRC<cr>

" =====================================================
" SEARCH AND FUZZY FINDING
" =====================================================
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
" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" =====================================================
" GIT AND DIFF TOOLS
" =====================================================
" shortcuts for 3-way merge
map <Leader>1 :diffget LOCAL<CR>
map <Leader>2 :diffget BASE<CR>
map <Leader>3 :diffget REMOTE<CR>
set diffopt+=internal,algorithm:patience

" =====================================================
" UTILITY FUNCTIONS
" =====================================================
map <leader>D :put =strftime('# %a %Y-%m-%d %H:%M:%S%z')<CR>
" open the file with your favorite application in the background (don't hold the editor back)
nnoremap gX :silent :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

" Copy the contents of the quickfix list to the args list
" This gives you a command called :Qargs which copies the items from your quickfix list
" into your args list
" command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
" function! QuickfixFilenames()
"   let buffer_numbers = {}
"   for quickfix_item in getqflist()
"     let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
"   endfor
"   return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
" endfunction

" =====================================================
" GUI OPTIONS
" =====================================================
if has('gui_running')
  " set lines=40 columns=99
  set guifont=JetBrains\ Mono\ 10
  set guioptions-=m           "remove menu bar
  set guioptions-=T           "remove toolbar
  set guioptions-=r           "remove right-hand scroll bar
  set guioptions-=L           "remove left-hand scroll bar
endif

" =====================================================
" FIXES & WORKAROUNDS
" =====================================================
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" =====================================================
" FILETYPE SPECIFIC SETTINGS
" =====================================================
autocmd BufRead,BufNewFile *.md setfiletype markdown
autocmd BufNewFile *.sh 0r ~/.vim/skeletons/bash.sh
" autocmd BufNewFile readme.md 0r ~/skeletons/readme.md
autocmd FileType html,eruby,htmldjango,vue set omnifunc=htmlcomplete#CompleteTags
" More abbreviation examples: https://jovica.org/posts/vim_abbreviations/
autocmd Filetype python :iabbrev ippp from pprint import pprint<CR>import sys<CR>print("===", file=sys.stderr)

let g:markdown_fenced_languages = ['html', 'javascript', 'ruby', 'python', 'rust']

" =====================================================
" PLUGIN CONFIGURATIONS
" =====================================================
" Plugin mappings
map <F2> :Vex<CR>
" map <F2> :Lexplore<CR>

" --------- CamelCase Motion ---------
let g:camelcasemotion_key = ','

" --------- Ripgrep Configuration ---------
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading
  set grepformat=%f:%l:%c:%m
  let g:ackprg = 'rg --vimgrep --smart-case --no-heading'
endif

" --------- Netrw File Explorer ---------
let g:netrw_liststyle = 3
let g:netrw_banner = 0
" 1 = horiz split, 2 vert split, 3 new tab, 4 prev win
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
let g:netrw_hide = 1
let g:netrw_dirhistmax = 0

" --------- Emmet Configuration ---------
let g:user_emmet_install_global = 0
autocmd FileType html,css,eruby,htmldjango,vue EmmetInstall
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
\  'vue' : {
\    'extends' : 'html',
\  },
\}

" --------- Ctags Configuration ---------
:set tags=.tags
let g:autotagTagsFile=".tags"
" let g:autotagCtagsCmd='ctags -f .tags --languages=ruby,python .'
" let g:autotagCtagsCmd='ctags --recurse --languages=ruby,python .'
let g:autotagStopAt='/home/cristian/Documents/workspace'

" --------- ALE (Asynchronous Lint Engine) ---------
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_use_global_executables = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
let g:ale_linters_explicit = 1
" let g:ale_completion_enabled = 1
" ALE provides an omni-completion function you can use for triggering completion manually with:
" <C-x><C-o>
" set omnifunc=ale#completion#OmniFunc
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['trim_whitespace', 'remove_trailing_lines'],
\}
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
:nmap ]e :ALENextWrap<CR>
:nmap [e :ALEPreviousWrap<CR>
:nmap ]E :ALELast
:nmap [E :ALEFirst
:nmap gd :ALEGoToDefinition<CR>
:nmap gr :ALEFindReferences -quickfix<CR>:copen<CR>
:nmap gh :ALEHover<CR>
:nmap gs :ALESymbolSearch -relative<space>

" --------- LSP Configuration ---------
" let g:lsp_fold_enabled = 0
" let g:lsp_document_highlight_enabled = 0
" let g:lsp_settings_filetype_python = ['pylsp']

" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gD <plug>(lsp-declaration)
"     nmap <buffer> gs <plug>(lsp-document-symbol-search)
"     nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gI <plug>(lsp-implementation)
"     nmap <buffer> gT <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"     nnoremap <buffer> <expr><leader>d lsp#scroll(+10)
"     nnoremap <buffer> <expr><leader>u lsp#scroll(-10)

"     " let g:lsp_format_sync_timeout = 1000
"     " autocmd! BufWritePre *.py call execute('LspDocumentFormatSync')
" endfunction

" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END

" --------- Completion Configuration ---------
" Tab completion
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" let g:asyncomplete_auto_popup = 0
" imap <c-@> <Plug>(asyncomplete_force_refresh)
" allow modifying the completeopt variable, or it will
" be overridden all the time
" let g:asyncomplete_auto_completeopt = 0
" set completeopt=menuone,noinsert,noselect,preview
" To auto close preview window when completion is done.
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" As-you-type autocomplete
" set completeopt=menu,menuone,preview,noselect,noinsert
" so that Vim's popup menu doesn't select the first completion item,
" but rather just inserts the longest common text of all matches;
" and the menu will come up even if there's only one match
" set completeopt=longest,menuone

" --------- Vue.js Plugin Configuration ---------
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

" --------- Go Language Configuration ---------
" map <leader>gb :GoBuild <CR>
" map <leader>gr :GoRun <CR>
" map <leader>gi :GoInstall <CR>
" map <leader>gt :GoTest <CR>
" map <leader>gtf :GoTestFunc <CR>
" map <leader>gd :GoDoc <CR>
" map <leader>gdb :GoDocBrowser <CR>
" map <leader>gi :GoImport <CR>
" map <leader>gr :GoRename <CR>

" =====================================================
" SECURITY
" =====================================================
" if getcwd() =~# '^\(/some/safe/path/\|/another/safe/path/\)'
if getcwd() =~# '^\(/home/cristian/Documents/workspace/\)'
  set secure exrc
endif
