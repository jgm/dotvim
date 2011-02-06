"-----------------------------------------------------------------------
" Basic configuration.

filetype off " temporarily
call pathogen#runtime_append_all_bundles()

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
set autoindent

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

" Visit todo list
nmap <Leader>td :e ~/Wiki/TodoList<CR>

function! SearchWiki(searchTerm)
  exec ":vimgrep " . a:searchTerm . " ~/Wiki/*"
  exec ":copen"
endfunction

command -nargs=1 Find call SearchWiki(<f-args>)

" Convert markdown buffer to PDF.

function Markdown2PDF()
   let source = bufname("")
   let basename = expand("%:r")
   exec ":! markdown2pdf " . source
   exec ":Utl openLink " . basename . ".pdf"
endfunction

map <Leader>p :call Markdown2PDF()<cr><cr>

" Read abbreviations file if present.
if filereadable(expand("~/.vim/abbrevs.vim"))
    source ~/.vim/abbrevs.vim
endif

"-----------------------------------------------------------------------
" GUI Settings {
if has("gui_running")
  colorscheme zenburn
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
" Scripts and addons. These are managed by pathogen and live in bundle/.
" Most of them are git submodules, so I can keep up to date
"
" To add a submodule,
" git submodule add URL bundle/NAME
" git submodule init
" git commit
" git push
"
" After 'git pull', if submodules were added, you may need to
" git submodule init
" git submodule update

" To remove a submodule,
" Delete the relevant line from the .gitmodules file.
" Delete the relevant section from .git/config.
" Run git rm --cached path_to_submodule (no trailing slash).
" Commit and delete the now untracked submodule files.
"
" NERD_tree (file browser)
map <leader>n :NERDTreeToggle<CR>

" fuzzyfinder (fuzzy filename completion)
nmap <leader>b :FufBuffer<CR>
nmap <leader>f :call fuf#givenfile#launch('', 0, '> ', split(glob('./**/*'), "\n"))<CR>
let g:fuf_file_exclude = '\v\~$|\.(o|pdf|dvi|hi|exe|dll|bak|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
highlight Pmenu ctermbg=4 ctermfg=0
highlight PmenuSel ctermbg=0 ctermfg=4

" potwiki (personal wiki)
let potwiki_home = "$HOME/Wiki/WelcomePage"

function UploadICAL()
   let source = bufname("")
   let fullname = expand("%")
   exec ":! icalupload.py " . fullname
endfunction

map <Leader>ui :call UploadICAL()<cr>

" ,cd changes working directory to directory of file being edited
map ,cd :cd %:p:h<CR>

"-----------------------------------------------------------------------
" Custom digraphs

dig cl 8988 " left corner quote U+231C
dig cr 8989 " right corner quote U+231D

" makes vim default register = the system clipboard
set clipboard+=unnamed
