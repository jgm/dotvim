syn match  diffRemoved "\[-\([^-]\|-[^\]]\)*-\]"
syn match  diffAdded "{+\([^+]\|+[^}]\)*+}"
syn match   diffFile "^diff"
syn match   diffIndexLine "^index"
syn match   diffLine "^\(+++\|---\|@@\)"

hi diffAdded cterm=bold ctermfg=DarkGreen
hi diffRemoved cterm=bold ctermfg=DarkRed
hi diffFile cterm=NONE ctermfg=DarkBlue
hi diffIndexLine cterm=NONE ctermfg=DarkBlue
hi diffLine cterm=NONE ctermfg=DarkBlue
