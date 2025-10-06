" nilsa color scheme - based on blackboard by Ben Wyrosdick
"

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "nilsa"

" Basics
highlight Normal ctermfg=45
highlight Comment ctermfg=248
highlight Constant ctermfg=72
highlight LineNr ctermfg=240

" Searching
highlight Search ctermfg=white ctermbg=234

" Todos
highlight Todo ctermfg=red ctermbg=234

" Menus, e.g. tab completion popup
highlight Pmenu ctermfg=lightgray ctermbg=234
highlight PmenuSel ctermfg=white ctermbg=234

" Separators in splits and folds
highlight VertSplit ctermfg=234 ctermbg=242
highlight StatusLine ctermfg=238 ctermbg=white
highlight StatusLineNC ctermfg=238 ctermbg=white
highlight Folded ctermfg=242 ctermbg=234

" Color column
highlight ColorColumn ctermbg=236

" vimdiff
highlight DiffAdd    ctermbg=22
highlight DiffDelete ctermbg=124
highlight DiffChange ctermbg=238
highlight DiffText   ctermbg=242
