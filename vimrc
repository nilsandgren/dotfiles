"
" nils andgren's .vimrc
"   
"

" -----------------------------------------------
" -- text flow
" -----------------------------------------------
set autoindent
set cindent
set smarttab
" -- highlight matching braces
set showmatch
set tabstop=4
set shiftwidth=4
" -- insert tabs as spaces
set expandtab
set shiftround
set nowrap
" -- use syntax fold method, but set the level so
" -- high that it seems to be disabled
set foldmethod:syntax
set foldlevelstart=20
" -- i prefer case sensitivity
set noignorecase
" -- see NormIndent/GnuIndent further down
set cinoptions=>4,:4,=4,l1,i4,p5,t0,(0,u0,w1,m1



" -----------------------------------------------
" -- Indentation functions
" -----------------------------------------------

" Normal Indentation (In my opinion)
" Select lines and press ,G to indent
"
" int main()
" {
"     if (a == b)
"     {
"         c = func();
"     }
" }
"
fun! NormIndent()
  setlocal cinoptions=>4,:4,=4,l1,i4,p5,t0,(0,u0,w1,m1
  setlocal shiftwidth=4
  setlocal tabstop=4
endfun
map ,G :call NormIndent() <CR>

" GNU Intentation
" Select lines and press ,g to indent
"
" int main()
" {
"   if(a == b)
"     {
"       c = func();
"     }
" }
"
fun! GnuIndent()
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=1
  setlocal tabstop=8
endfun
map ,g :call GnuIndent() <CR>



" -----------------------------------------------
" -- the look
" -----------------------------------------------

" -- do not expose whitespace by default
set list lcs=tab:\ \ ,trail:\ 

" -- expose or hide whitespace
fun! ShowWhiteSpace()
  set list lcs=tab:._,trail:-
endfun
fun! HideWhiteSpace()
  set list lcs=tab:\ \ ,trail:\ 
endfun
map ,. :call ShowWhiteSpace() <CR>
map ,- :call HideWhiteSpace() <CR>

" -- underline current line
map ,u :set cursorline<CR>

set ruler



" -----------------------------------------------
" -- text color
" -----------------------------------------------

" -- syntax highlighting should be on
syntax on
let &t_Co=256

" -- select a color scheme
colorscheme desert
silent! colorscheme blackboard




" -----------------------------------------------
" -- show current C/C++ function
" -----------------------------------------------
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map ,f :call ShowFuncName() <CR>



" -----------------------------------------------
" -- copy and paste using a clipboard file
" -----------------------------------------------
" -- write selection to file
map ,c :w! /tmp/clipboard<CR>
" -- read selection from file
map ,v :r /tmp/clipboard<CR>



" -----------------------------------------------
" -- search behavior
" -----------------------------------------------
set incsearch
set hlsearch
map ,h :nohlsearch<CR>



" -----------------------------------------------
" -- code completion: tags and the taglist plugin
" --
" -- get it here:
" --   http://vim-taglist.sourceforge.net/
" --   http://vim.sourceforge.net/scripts/script.php?script_id=273
" --
" -----------------------------------------------
set wildmode=longest,list,full
set wildmenu
set tags=vimtags;/
" -- jump to definition: ,a
map ,a g]
" -- jump back: ,s
map ,s <C-T>
inoremap <Nul> <C-n>
" -- open taglist browser column: ,t
map ,t :TlistToggle<CR>



" -----------------------------------------------
" -- misc goodies
" -----------------------------------------------
set autowrite

" -- write swap files to this directory
set dir=>~/.vimswap

" -- use bash for as command line
set shell=/bin/bash

" -- invoke make: ,m
set makeprg=make
map ,m :!make<CR>

" -- yank to end of line
nnoremap Y y$

" -- delete line without copying
map <C-d><C-d> "_dd
" -- delete selection without copying
map <C-d> "_d

" -- real tabs in make files
autocmd BufEnter ?akefile* set noexpandtab

" -- remove blanks at end of line
map ,B :s:\s*$::<CR>

" -- semicolon to braces
map ,; :s/;/\r{\r}\r<CR>:nohlsearch<CR>

" -- increase and decrease numbers with ctrl + up/down arrows!
nnoremap <C-Up> <C-a>
nnoremap <C-Down> <C-x>

" -- git diff for current file
map ,d :!git diff %<CR>
" -- git log for current file
map ,l :!git log %<CR>
" -- git blame for current file
map ,b :!git blame %<CR>

" -- tabs
" -- jump one tab to the left
nnoremap ,<Left> :tabn<CR>
" -- jump one tab to the left
nnoremap ,<Right> :tabp<CR>
" -- open filename(:linenumber) under cursor in a new tab
" -- e.g. main.cpp:34
nnoremap ,o <C-w>gF

