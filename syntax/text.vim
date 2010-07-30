" Vim syntax file
" Language:	Text with light markup conventions
" Author:       John MacFarlane

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"define Markdown groups
syn match  Underlined /   *$/ " two or more spaces at end of line
syn match  Keyword "^\s*[-*+]\s\+"  " list item
syn match  Keyword "^\s*\d\+\.\s\+" " list item
syn region Operator   start=/`/                   end=/`/ 
syn region Operator   start=/\s*``[^`]*/ skip=/`/ end=/[^`]*``\s*/
syn region Comment start=/^\s*>/              end=/$/ 
syn region Function start=/<!--/ end=/-->/

" headings
syn region NonText      start="^##* "                 end="\($\|#\+\)"
syn match  NonText      /^.\+\n=\+$/
syn match  NonText      /^.\+\n-\+$/

" inline footnotes
syn region Comment start=/\^\[/ skip=/\[[^]]*\]/  end=/\]/

" links
"syn region String start=/\[/ end=/\]/

" code blocks - FIX: captures continuations on lists
" syn region Operator start=/^\s*\n\(    \|\t\)/ end=/.*\n\s*\n/

let b:current_syntax = "text"

