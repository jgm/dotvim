" Vim syntax file
" Language:	Text with light markup conventions
" Author:       John MacFarlane

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"define Markdown groups
syn match  Keyword "^\s*[-*+]\s\+"  " list item
syn match  Keyword "^\s*\d\+\.\s\+" " list item
syn region Operator   start=/`/                   end=/`/ 
syn region Operator   start=/\s*``[^`]*/ skip=/`/ end=/[^`]*``\s*/
syn region Comment start=/^\s*>/              end=/$/ 
syn region Function start=/<!--/ end=/-->/

" headings
syn region Underlined      start="^##* "                 end="\($\|#\+\)"
syn match  Underlined      /^.\+\n=\+$/
syn match  Underlined      /^.\+\n-\+$/

" inline footnotes
syn region Comment start=/\^\[/ skip=/\[[^]]*\]/  end=/\]/

" links
"syn region String start=/\[/ end=/\]/

" code blocks - FIX: captures continuations on lists
" syn region Operator start=/^\s*\n\(    \|\t\)/ end=/.*\n\s*\n/

" math
syn region Operator start=/\$[^ \t\n$]/ end=/\$/ " inline math
syn region Operator start=/\$\$/ end=/\$\$/ " display math

let b:current_syntax = "text"

