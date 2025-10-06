"
" nils andgren's .vimrc
"   
"

" -----------------------------------------------
" -- general
" -----------------------------------------------

" -- use comma as leader
let mapleader = ","

" -- allow space to get into insert mode
map <space> i


" -- auto write when changing buffers etc
set autowrite

" -- not vi compatible
set nocp

" -- use bash command line
set shell=/bin/bash

" -- write swap files to this directory
set dir=>~/.vimswap

" -- handle xterm-style Ctrl+arrow sequences
" -- check term to see if tmux/screen is used
if &term =~ '^screen'
    " -- tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif


" -----------------------------------------------
" -- text flow
" -----------------------------------------------
set smarttab
" -- highlight matching braces
set showmatch
" -- four spaces for tabs
set tabstop=4
set shiftwidth=4
" -- insert tabs as spaces
set expandtab
" -- round indent to shiftwidth
set shiftround
" -- do not generally wrap lines...
set nowrap
" -- ...but wrap text files
au BufRead,BufNewFile *.txt,*.md set wrap linebreak nolist textwidth=0 wrapmargin=0

" -- use syntax fold method, but set the level so
" -- high that it seems to be disabled
set foldmethod:syntax
set foldlevelstart=20
" -- use indent fold method for python files
au BufNewFile,BufRead,BufEnter *.py set foldmethod:indent

" -- i prefer case sensitivity
set noignorecase
" -- indentation
set autoindent
set cindent
set cinoptions=>4,:4,=4,l1,i4,p5,t0,(0,u0,w1,m1
set cinkeys-=0#
set indentkeys-=0#



" -----------------------------------------------
" -- the look
" -----------------------------------------------

set number
" -- set relativenumber

" -- do not expose whitespace by default
set list lcs=tab:\ \ ,trail:\ 

" -- expose or hide whitespace
fun! ShowWhiteSpace()
  set list lcs=tab:._,trail:-
endfun
fun! HideWhiteSpace()
  set list lcs=tab:\ \ ,trail:\ 
endfun
map <leader>. :call ShowWhiteSpace() <CR>
map <leader>- :call HideWhiteSpace() <CR>

" -- underline current line
map <leader>u :set cursorline<CR>
map <leader>U :set nocursorline<CR>

set ruler

" -- syntax highlighting should be on
syntax on
let &t_Co=256

" -- select a color scheme
colorscheme desert
" -- try to use blackboard - a non-standard color scheme
silent! colorscheme blackboard
" -- too much comments in our code, so fading them a bit
highlight Comment ctermfg=242

" -- dark gray separators in splits and folds
highlight VertSplit ctermfg=234 ctermbg=242
highlight StatusLine ctermfg=238 ctermbg=white
highlight StatusLineNC ctermfg=238 ctermbg=white
highlight Folded ctermfg=242 ctermbg=234

" -- colors when using vimdiff
highlight DiffAdd    ctermbg=22
highlight DiffDelete ctermbg=124
highlight DiffChange ctermbg=238
highlight DiffText   ctermbg=242

" -- mark column 100 & 120 in dark gray
highlight ColorColumn ctermbg=236
set colorcolumn=100,120
" -- 80 & 100 for python
au BufNewFile,BufRead,BufEnter
    \ *.py
    \ set colorcolumn=80,100

" -----------------------------------------------
" -- copy and paste using a clipboard file
" -----------------------------------------------
" -- write selection to file
map <leader>c :w! /tmp/clipboard<CR>
" -- read selection from file
map <leader>v :r /tmp/clipboard<CR>



" -----------------------------------------------
" -- search behavior
" -----------------------------------------------
" -- incremental search
set incsearch
" -- highlight matches
set hlsearch
map <leader>h :nohlsearch<CR>


" -----------------------------------------------
" -- command completion
" -----------------------------------------------
set wildmode=longest,list,full
set wildmenu


" -----------------------------------------------
" -- code completion
" -----------------------------------------------

" -- ctags and the taglist plugin
" -- get it here:
" --   http://vim-taglist.sourceforge.net/
" --   http://vim.sourceforge.net/scripts/script.php?script_id=273
"
" -- the tag file to use
set tags=/home/nan/vim-tags

" -- jump to definition (push on stack)
map <leader>a g]
map <C-Down> g]
" -- jump back (pop from stack)
map <leader>s <C-T>
map <C-Up> <C-T>

" -- resizing
map <S-Up> <cmd>resize +2<CR>
map <S-Down> <cmd>resize -2<CR>
map <S-Left> <cmd>vertical resize -2<CR>
map <S-Right> <cmd>vertical resize +2<CR>

inoremap <Nul> <C-n>

" -- toggle taglist browser
map <leader>T :TlistToggle<CR>
" -- toggle NERDTree
map <leader>e :NERDTreeToggle<CR>
map <leader>t :NERDTreeToggle<CR>

" -- don't scan #include files for symbols
set complete-=i

" -- omni-completion using OmniCppComplete:
"    http://www.vim.org/scripts/script.php?script_id=1520
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" -- c
au BufNewFile,BufRead,BufEnter
    \ *.cpp,*.cc,*.c,*.hpp,*.hh,*.h
    \ set omnifunc=omni#cpp#complete#Main

" -- rust
au BufNewFile,BufRead,BufEnter
    \ *.rs
    \ set omnifunc=syntaxcomplete#Complete

" -- insert first candidate into text buffer
let OmniCpp_SelectFirstItem = 2

" -- hide preview window when candidate has been inserted
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" -----------------------------------------------
" -- build results in quickfix list
" -----------------------------------------------
set makeprg=rustc
fun! VimBuild()
    " clear quickfix list
    call setqflist([])
    " clear scratch buffer without echoing "Press ENTER..."
    silent! !clear
    silent! !echo "Building..."
    make
    " open quickfix list if it has any content
    cwindow 14
endfun
" -- make with <leader>m
map <leader>m :call VimBuild()<cr>


" -----------------------------------------------
" -- grep-related
" -----------------------------------------------

" -- grep and open results in quickfix list
fun! QuickFixGrep(pattern)
  " recursive grep in current directory
  let banana = shellescape(a:pattern)
  echo banana
  " skip non-existing files and binary files
  silent execute "grep! -sIR " . shellescape(a:pattern) . " ."
  " open quickfix list
  copen
endfun
nnoremap <leader>g :call QuickFixGrep(expand("<cword>")) <CR>

" -- edit filename(:linenumber) (e.g. main.cpp:34) under
" -- cursor in a new tab. useful when dealing with grep output
nnoremap <leader>o <C-w>gF


" -----------------------------------------------
" -- misc goodies
" -----------------------------------------------

" -- Switch tabs
map <C-Left> gT
map <C-Right> gt


" -- rustfmt current buffer
fun! RustFormat()
  let cursor_pos = getpos('.')
  :%!rustfmt %
  :e!
  call setpos('.', cursor_pos)
endfun
map <leader>f :call RustFormat() <CR>

" -- clang-format current buffer
function ClangFormat()
  if !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction
map <leader>F :call ClangFormat() <CR>

" -- remember last editing position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1
      \ && line("'\"") <= line("$")
      \ | exe "normal! g'\""
      \ | endif
endif

" -- yank to end of line
nnoremap Y y$

" -- delete line without copying
map <C-d><C-d> "_dd
" -- delete selection without copying
map <C-d> "_d

" -- real tabs in make files
autocmd BufNewFile,BufRead,BufEnter ?akefile* set noexpandtab

" -- real tabs in golang files
autocmd BufNewFile,BufRead,BufEnter *.go set noexpandtab

" -- turn off syntax highlighting for markdown files
" autocmd BufEnter *.md set syn=off

" -- remove blanks at end of line
map <leader>B :s:\s*$::<CR>

" -- semicolon to braces
map <leader> :s/;/\r{\r}\r<CR>:nohlsearch<CR>

" -- reload file without mercy
map <leader>r :edit!<CR>

" -- show hexadecimal representation of current word
fun! ShowAsHex(decString)
  echohl ModeMsg
  let output = printf("Hex: 0x%04x", a:decString)
  echo output
  echohl none
endfun
map "h :call ShowAsHex(expand('<cword>')) <CR>

" -- show decimal representation of current word
fun! ShowAsDec(hexString)
  echohl ModeMsg
  let output = printf("Dec: %u", a:hexString)
  echo output
  echohl none
endfun
map "d :call ShowAsDec(expand('<cword>')) <CR>


" -----------------------------------------------
" -- git
" -----------------------------------------------
" -- git command on current file
fun! GitCommand(command)
  silent! !clear
  exec "!git " . a:command . " %"
endfun
" -- git diff for current file
map <leader>d :call GitCommand("diff") <CR>
" -- git log for current file
map <leader>l :call GitCommand("log -p") <CR>
" -- git blame for current file
map <leader>b :call GitCommand("blame") <CR>


" -----------------------------------------------
" -- include local config file if available
" -----------------------------------------------
silent! source .vimrc_local
