" :PlugInstall to install these plugins
call plug#begin('~/.vim/plug')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/vimproc'
Plug 'eagletmt/ghcmod-vim'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/tabularize'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'

" initialize plugins
call plug#end()

set nocompatible
filetype off " temporarily

" Behave intelligently for type of file.
filetype plugin indent on
syntax on

" Set leader to comma.
let mapleader = ","

" Don't redraw screen while executing macros.
set nolazyredraw

" Give more context in viewport.
set scrolloff=3

" Scroll viewport faster.
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set nomodeline " for security reasons

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

" Show trailing whitespace, tabs
"highlight TabChar ctermbg=yellow guibg=yellow
highlight ExtraWhitespace ctermbg=Gray guibg=Gray
"match TabChar /\t\+/
match ExtraWhitespace /\s\+$/

" Show matching brackets.
set showmatch
set mat=5  " for half a sec

" Tabs:  default is two spaces.
set expandtab
set tabstop=8      " real tabs are 8
set softtabstop=4
set shiftwidth=4   " for autoindent
set shiftround     " indent to a multiple of shiftwidth
set autoindent

" Reflow paragraphs intelligently. using 'par'.
set formatprg="par -h -w64 -B=.,\?_A_a "
map <C-\> !}par -h -w64 -B=.,\?_A_a <cr>

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

" NOTE: Snipmate won't work in paste mode!
set pastetoggle=<F2> " formerly <C-a>

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

" toggle spelling
:map <Leader>s :set invspell<cr>

" If for aesthetic reasons you want a left margin in writing text...
function! GutterLeft()
  set number
  highlight LineNr ctermfg=Black
endfunction

" Use space and backspace for quick navigation forward/back.
noremap <Space> <PageDown>
noremap <BS> <PageUp>

" for text files set width
autocmd FileType text setlocal textwidth=64

" When editing a file, always jump to the last known cursor position. Don't
" do it when the position is invalid or when inside an event handler (happens
" when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" Highlight according to markdown conventions in text files.
" augroup text
"  autocmd BufRead *.txt set ai formatoptions=tcroqn2 comments=n:>
" augroup END

augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
  au! BufNewFile,BufFilePre,BufRead *.txt set filetype=markdown.pandoc
augroup END

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" thanks Douglas Potts).
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Use zl to list buffers, and go to matching buffer
" Type part of bufname after prompt.
nmap zl :ls!<CR>:buf

" Read abbreviations file if present.
if filereadable(expand("~/.vim/abbrevs.vim"))
    source ~/.vim/abbrevs.vim
endif

"-----------------------------------------------------------------------
" GUI Settings {
if has("gui_running")
  set background=dark
  colorscheme wombat " solarized
  set columns=80
  set lsp=3 " line spacing
  set guifont=DejaVu\ Sans\ Mono\ 10  " set in ~/.vimrc
  set guioptions=ce 
  "              ||
  "              |+-- use simple dialogs rather than pop-ups
  "              +  use GUI tabs, not console style tabs
  set lines=40
  set mousehide " hide the mouse cursor when typing
endif

" NERD_tree (file browser)
map <leader>n :NERDTreeToggle<CR>

function UploadICAL()
   let source = bufname("")
   let fullname = expand("%")
   exec ":! icalupload.py " . fullname
endfunction

map <Leader>ui :call UploadICAL()<cr>

" ,cd changes working directory to directory of file being edited
map ,cd :cd %:p:h<CR>

" for syntastic
map <silent> <Leader>e :Errors<CR>
" keep disabled until you do <Leader>S for errorr
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <Leader>S :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" enable filetype detection, plus loading of filetype plugins
filetype plugin on

" configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"
let g:haddock_docdir = "/usr/share/doc/ghc/"

" Haskell type signatures - from S. Visser

function! HaskellType()
  w
  execute "normal {j^YP"
  execute (".!ghc -XNoMonomorphismRestriction -w % -e \":t " . expand("<cword>") . "\"")
  redraw!
endfunction

function Haskell()
  map <buffer> <silent> tt :call HaskellType()<Cr>
  " more haskell stuff here
endfunction

autocmd BufRead,BufNewFile *.{ag,hs,lhs,ghs} call Haskell()

if &diff
   colorscheme desert256
endif


"-----------------------------------------------------------------------
" Custom digraphs

dig cl 8988 " left corner quote U+231C
dig cr 8989 " right corner quote U+231D

" makes vim default register = the system clipboard
set clipboard+=unnamed

function FixBS() " fix <BS> on OSX
   set t_kb=
   fixdel
endfunction

" Plugin settings

" gitgutter
set updatetime=250
" bindings:
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
" You can stage or undo an individual hunk when your cursor is in it:
" stage the hunk with <Leader>hs or
" undo it with <Leader>hu.

" key bindings for vim-fugitive
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>ga :Gwrite<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff<cr>

" this is for vim-airline
let g:airline_theme='papercolor'
set laststatus=2

" key bindings for ghc-mod
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" toggle nerdtree
map <Leader>n :NERDTreeToggle<CR>

" tabularize with haskell
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" vim-pandoc
" let g:pandoc#syntax#conceal#urls=1
let g:pandoc#syntax#conceal#use=0
" emphasis looks bad in macos terminal which doesn't have ital/bold:
let g:pandoc#syntax#style#emphases=0
