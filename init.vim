" :PlugInstall to install these plugins
call plug#begin('~/.vim/plug')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/tabularize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-speeddating'
Plug 'vim-scripts/loremipsum'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'neovimhaskell/haskell-vim'
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': 'master'}
Plug 'MrcJkb/haskell-tools.nvim', { 'branch': '1.x.x' }

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

" Highlight PmenuThumb with readable background
highlight PMenu ctermbg=gray
highlight PMenuThumb ctermbg=gray

"match TabChar /\t\+/
match ExtraWhitespace /\s\+$/

" Show matching brackets.
set showmatch
set mat=5  " for half a sec

" Tabs:  default is two spaces.
set expandtab
set tabstop=8      " real tabs are 8
set softtabstop=4
set shiftwidth=2   " for autoindent
set shiftround     " indent to a multiple of shiftwidth
set autoindent
set cindent

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

" Instead of ctrl-O, ctrl-I, leader b/f for back/forward in jumplist
noremap <leader>f <C-I>
noremap <leader>b <C-O>

" for text files set width
autocmd FileType text setlocal textwidth=64
autocmd FileType tex setlocal textwidth=64
autocmd FileType markdown setlocal textwidth=64
autocmd FileType vimwiki setlocal foldlevel=99

" When editing a file, always jump to the last known cursor position. Don't
" do it when the position is invalid or when inside an event handler (happens
" when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" Highlight according to markdown conventions in text files.
augroup markdown
  autocmd BufRead *.md set filetype=markdown ai formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *.txt set ai filetype=markdown formatoptions=tcroqn2 comments=n:>
augroup END

" vim-markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1

let g:zettel_fzf_command = 'ls *.md'
" use [[Page]] for links instead of [Page](Page)
let g:zettel_link_format="[[%title]]"

hi htmlItalic             gui=underline cterm=underline

" augroup pandoc_syntax
"   au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
"   au! BufNewFile,BufFilePre,BufRead *.txt set filetype=markdown.pandoc
" augroup END

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
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind %"
  endif
endfunction
map <leader>n :call NERDTreeToggleInCurDir()<CR>

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

" for haskell-vim
let g:haskell_indent_if = 3
" if foo
"    then ...
let g:haskell_indent_case = 2
" case foo of
"   bar ->
let g:haskell_indent_let = 4
" let foo = ...
"     bar
let g:haskell_indent_after_bare_where = 1
" where
"  foo =
let g:haskell_indent_do = 2
let g:haskell_indent_guard = 2
" f x y
"   |
let g:cabal_indent_section = 2
" executable name
"   main-is:

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
let g:gitgutter_enabled=0
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

" undo-tree
map <leader>u :UndotreeToggle<cr>

" ctrl-p
let g:ctrlp_map = '<leader>p'

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" fold markdown headings in vimwiki
let g:vimwiki_folding = 'expr'
augroup vimwiki
  noremap <leader><leader> za
augroup END

" " CoC config
" runtime cocinit.vim

if has('nvim')
" nvim only stuff here
  lua require('haskell-tools-setup')
  lua require('typescript-setup')
  lua require('telescope-setup')
endif

