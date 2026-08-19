set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "nilsa"

" Basics
highlight Normal ctermfg=152
highlight Comment ctermfg=248
highlight Constant ctermfg=71
highlight LineNr ctermfg=240
highlight Type ctermfg=114
highlight Special ctermfg=246
highlight Identifier ctermfg=36
highlight Function ctermfg=36
highlight PreProc ctermfg=37

" Searching
highlight Search ctermfg=166 ctermbg=black

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

" Rust
highlight rustArrowCharacter ctermfg=66
highlight rustAsync          ctermfg=145
highlight rustAwait          ctermfg=145
highlight rustEnum           ctermfg=106
highlight rustEnumVariant    ctermfg=107
highlight rustOperator       ctermfg=66
highlight rustPanic          ctermfg=208
highlight rustQuestionMark   ctermfg=208
highlight rustUnsafeKeyword  ctermfg=208
