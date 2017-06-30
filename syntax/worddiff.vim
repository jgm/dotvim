syn region diffRemoved start=/\[-/ end=/-\]/
syn region diffAdded start=/{+/ end=/+}/
syn match   diffFile "^diff.*"
syn match   diffIndexLine "^index.*"
syn match   diffLine "^\(+++\|---\|@@\).*"

hi diffAdded cterm=bold ctermfg=DarkGreen
hi diffRemoved cterm=bold ctermfg=DarkRed
hi diffFile cterm=NONE ctermfg=DarkBlue
hi diffIndexLine cterm=NONE ctermfg=Grey
hi diffLine cterm=NONE ctermfg=Grey
