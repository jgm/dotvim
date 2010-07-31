"-----------------------------------------------------------------------
" Basic configuration.

" Set leader to comma.
let mapleader = ","

" Don't redraw screen while executing macros.
set nolazyredraw

" Behave intelligently for type of file.
filetype plugin indent on

" Syntax highlighting.
function! SyntaxToggle()
  execute "syntax" exists("g:syntax_on") ? "off" : "on"
endfunction
nmap <leader>s :call SyntaxToggle()<cr><C-l><cr>
syntax on

" Give more context in viewport.
set scrolloff=3

" Scroll viewport faster.
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set nomodeline " for security reasons
set nocompatible

" Encoding and line breaks.
set encoding=utf-8
set ffs=unix,dos

set grepprg=grep\ -nH\ $*

" Completion for file open etc.
set wildmenu
set wildmode=list:longest
set wildignore+=*.log,*.pdf,*.swp,*.o,*.hi,*.py[co],*~

" Ignore these when using TAB key with :e
set suffixes=~,.aux,.bak,.bkp,.dvi,.hi,.o,.pdf,.gz,.idx,.log,.ps,.swp,.tar,.ilg,.bbl,.toc,.ind

" Create backup files ending in ~, in ~/tmp or, if
" that is not possible, in the working directory.
set backup
set backupdir=~/tmp,.

" Flexible backspace: allow backspacing over autoindent, line breaks, start of
" insert.
set backspace=indent,eol,start

" No audible bell.
set visualbell

" Show line and column position of cursor, with percentage.
set ruler

" Make tabs and trailing space visible on ,l
set listchars=tab:>-,trail:.
set list
nmap <silent> <leader>l :set invlist list?<cr>

" Show matching brackets.
set showmatch
set mat=5  " for half a sec

" Tabs:  default is two spaces.
set expandtab
set tabstop=8      " real tabs are 8
set softtabstop=2
set shiftwidth=2   " for autoindent
set shiftround     " indent to a multiple of shiftwidth

" Reflow paragraphs intelligently. using 'par'.
set formatprg="par -h -w78 -B=.,\?_A_a "
map <C-\> !}par -h -w78 -B=.,\?_A_a <cr>

" Go to nearest match as you type.
set incsearch
set ignorecase  " ignore case in search and tags
set smartcase   " unless the pattern contains uppercase

" Set title of window according to filename.
set title

" Show command on last line.
set showcmd

"" Disable arrow keys.
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

" Switch ' and `
nnoremap ' `
nnoremap ` '

" This sets soft wrapping:
" set wrap linebreak textwidth=0

:nmap ,w :w<cr>

" Don't force save when changing buffers
set hidden

" Don't try to auto-indent pastes.
set paste
set pastetoggle=<C-a>

" Remember more commands.
set history=200

" Buffer movement (C-n - next, C-p - previous).
map <C-n> :bn<cr>
map <C-p> :bp<cr>

" Tab movement
" gt next tab
" gT prev tab
" 3gt tab 3

" Split window movement
map <F4> <C-W><C-W>
map <C-Up> <C-W><Up>
map <C-Down> <C-W><Down>
map <C-Right> <C-W><Right>
map <C-Left> <C-W><Left>

" Use <Leader>g to go to a url under cursor in UTL format <url:blah>
:map <Leader>g :Utl<cr>
:let g:utl_opt_highlight_urls='yes'
:let g:utl_cfg_hdl_mt_generic = 'silent !open "%p"&'

" s skips whitespace and puts cursor on next non-whitespace char
:map s :call search('\S','ceW')<cr>
" S skips preceding whitespace and puts cursor on last non-whitespace char
:map S :call search('\S','bceW')<cr>

" If for aesthetic reasons you want a left margin in writing text...
function! GutterLeft()
  set number
  highlight LineNr ctermfg=Black
endfunction

" Use space and backspace for quick navigation forward/back.
noremap <Space> <PageDown>
noremap <BS> <PageUp>

" for text files set width = 78 chars
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position. Don't
" do it when the position is invalid or when inside an event handler (happens
" when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" Highlight according to markdown conventions in text files.
augroup text
  autocmd BufRead *.txt set ai formatoptions=tcroqn2 comments=n:>
augroup END

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" thanks Douglas Potts).
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Use zl to list buffers, and go to matching buffer
" Type part of bufname after prompt.
nmap zl :ls!<CR>:buf 

" My local wiki.
let potwiki_home = "$HOME/Wiki/WelcomePage"

" Visit todo list
nmap <Leader>td :e ~/Wiki/TodoList<CR>

function! SearchWiki(searchTerm)
  exec ":vimgrep " . a:searchTerm . " ~/Wiki/*"
  exec ":copen"
endfunction

command -nargs=1 Find call SearchWiki(<f-args>)

" Read abbreviations file if present.
if filereadable(expand("~/.vim/abbrevs.vim"))
    source ~/.vim/abbrevs.vim
endif

"-----------------------------------------------------------------------
" GUI Settings {
if has("gui_running")
  colorscheme desert256
  set columns=80
  " set guifont=DejaVu\ Sans\ Mono\ 8  " set in ~/.vimrc
  set guioptions=ce 
  "              ||
  "              |+-- use simple dialogs rather than pop-ups
  "              +  use GUI tabs, not console style tabs
  set lines=40
  set mousehide " hide the mouse cursor when typing
endif

"-----------------------------------------------------------------------
" Scripts and addons. Each is put in its own subdirectory of
" ~/.vim/addons. To uninstall a plugin, just delete its subdirectory.
" To deactivate an addon without uninstalling it, just comment out the
" 'set runtimepath' line for it below.

" Activate snipMate (Textmate-like snippets)
set runtimepath+=~/.vim/addons/snipMate,~/.vim/addons/snipMate/after

" Activate NERD_tree (file browser)
set runtimepath+=~/.vim/addons/NERD_tree
map <leader>n :NERDTreeToggle<CR>

" Activate haskellmode
" set runtimepath+=~/.vim/addons/haskellmode
" au Bufenter *.hs compiler ghc
let g:proj_flags="imstvcg" 
" configure browser for haskell_doc.vim
let g:haddock_browser = "/usr/bin/firefox"
let g:haddock_docdir = "/home/jgm/ghc-6.12.1/share/doc/ghc"

" Active utl (active links)
set runtimepath+=~/.vim/addons/utl

" Activate fuzzyfinder (fuzzy filename completion)
set runtimepath+=~/.vim/addons/fuzzyfinder
map <leader>f <ESC>:FufFile **/<CR>


