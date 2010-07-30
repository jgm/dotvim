set runtimepath+=~/.vim/addons/snipMate,~/.vim/addons/snipMate/after
set runtimepath+=~/.vim/addons/NERD_tree
set runtimepath+=~/.vim/addons/haskellmode
set runtimepath+=~/.vim/addons/utl

if filereadable(expand("~/.vim/abbrevs.vim"))
    source ~/.vim/abbrevs.vim
endif

syntax on
let mapleader = ","
" give more context in viewport
set scrolloff=3
set nomodeline " for security reasons
set nocompatible
set encoding=utf-8
set ffs=unix,dos
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent off
filetype plugin indent on 
set wildmenu
set wildmode=list:longest
set wildignore+=*.log,*.pdf,*.swp,*.o,*.py[co],*~
set backup
set backupdir=~/tmp,/tmp
set backspace=indent,eol,start
set visualbell
set ruler
" make tabs and trailing space visible on ,s
set list listchars=tab:»»,trail:·
" set listchars=tab:>-,trail:.,eol:$
nmap <silent> <leader>s :set nolist!<CR>
set showmatch " show matching brackets
set mat=5  " for half a sec
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set formatprg="par -h -w72 -B=.,\?_A_a "
map <C-\> !}par -h -B=.,\?_A_a <enter>
" go to nearest match as you type
set incsearch
set ignorecase
set smartcase
set title
set showcmd
" scroll viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"" disable arrow keys
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

" map F2 to toggle nerdtree
map <F2> :NERDTreeToggle<CR>

" switch ' and `
nnoremap ' `
nnoremap ` '

" This sets soft wrapping:
" set wrap linebreak textwidth=0

" .tex means latex, not plain tex:
let tex_flavor="latex"

" ignore these when using TAB key with :e
set suffixes=~,.aux,.bak,.bkp,.dvi,.hi,.o,.pdf,.gz,.idx,.log,.ps,.swp,.tar,.ilg,.bbl,.toc,.ind

:nmap ,w :w<cr>

" Don't force save when changing buffers
set hidden

set pastetoggle=<C-a>

" Remember more commands
set history=200

" Buffer movement
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

:function Html2Markdown()
:   let url = input("File or URL to convert to markdown? ", expand("<cfile>"), "file")
:   if url != ""
:       exec ":bad " . url
:       exec ":b " . url
:       exec ":r! curl " . url . " | pandoc -r html -t markdown -s 2>/dev/null"
:   endif
:endfunction

:map <Leader>m :call Html2Markdown()<cr>

:function Markdown2PDF()
:   let source = bufname("")
:   let basename = substitute(source, "\.[^.]*$", "", "")
:   exec ":! markdown2pdf " . source . " && open " . basename . ".pdf"
:endfunction

:map <Leader>p :call Markdown2PDF()<cr>

" use <Leader>g to go to a url in UTL format <url:blah>
:map <Leader>g :Utl<cr>
:let g:utl_opt_highlight_urls='yes'
:let g:utl_cfg_hdl_mt_generic = 'silent !open "%p"&'

" s skips whitespace and puts cursor on next non-whitespace char
:map s :call search('\S','ceW')<cr>
" S skips preceding whitespace and puts cursor on last non-whitespace char
:map S :call search('\S','bceW')<cr>

":function GutterLeft()
":   set number
":   highlight LineNr ctermfg=Black
":endfunction

":map <Leader>g :call GutterLeft()<cr>

"if &term == "xterm-color"
"  set t_kb=
"  fixdel
"endif

noremap <Space> <PageDown>
noremap <BS> <PageUp>

" for text files set width = 78 chars
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

syn match  Underlined /\s\s*$/ " one or more spaces at end of line

" markdown syntax highlighting
augroup text
  autocmd BufRead *.txt set ai formatoptions=tcroqn2 comments=n:>
augroup END

"   Edit another file in the same directory as the current file
"   uses expression to extract path from current file's path
"  (thanks Douglas Potts)
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" Use zl to list buffers, and go to matching buffer
" Type part of bufname after / prompt.
nmap zl :ls!<CR>:buf /

let potwiki_home = "$HOME/Wiki/WelcomePage"

" Visit todo list
nmap <Leader>td :e ~/Wiki/TodoList<CR>

:function SearchWiki(searchTerm)
:   exec ":vimgrep " . a:searchTerm . " ~/Wiki/*"
:   exec ":copen"
:endfunction

:function VimTips()
:   exec ":e ~/.vim/vimtips.txt"
:   exec "set foldmethod=marker"
:endfunction

command -nargs=1 Find call SearchWiki(<f-args>)

let g:proj_flags="imstvcg" 

" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc

" configure browser for haskell_doc.vim
let g:haddock_browser = "/usr/bin/firefox"
let g:haddock_docdir = "/home/jgm/ghc-6.12.1/share/doc/ghc"
