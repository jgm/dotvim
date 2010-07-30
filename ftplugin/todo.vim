set shiftwidth=4
set autoindent
setlocal foldmethod=indent
:nmap <Leader>td I[ ]
:nmap <Leader>tc :s/^\(\s*\)\[ \]/\1[x]/<cr>
:nmap <Leader>tu :s/^\(\s*\)\[x\]/\1[ ]/<cr>
