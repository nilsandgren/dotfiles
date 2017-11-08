######################
# color prompt
case "$TERM" in
    #xterm-color|*-256color) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

######################
# typos
alias ks='echo KOTTFARSSAS; ls'
alias ös='echo As-Ösigt!; ls'
alias bim='echo "Bim! Bim!"; sleep 1; vim'
alias get='git'
alias gut='git'

######################
# vim
alias clear-vim-swap='rm -f ~/.vimswap/*'
alias v='vim'
alias ':e'='vim'
# tagging with ctags
alias tags='/home/nilsa/bin/tags.sh'

######################
# git
alias gpr='git pull --rebase'
alias gsu='git submodule update'
alias gst='git status'
alias gbr='git branch'
alias gca='git commit --amend'

######################
# frequent cds
alias cdc='cd /home/nilsa/git/monorepo'
# repackaging
alias cdr='cd /home/nilsa/git/monorepo/src/repackaging'
alias cdn='cd /mnt/lithium/home/nils.andgren'

######################
# frequent ssh targets
alias orbit='ssh root@10.16.16.14'
alias mb='ssh nilsa@miobuild'
alias saturn='ssh nilsa@saturn'

######################
# view bug tickets
function mantis()
{
  if [ "$1" -ge "20000" ] ; then
      gnome-open http://scyther.edgeware.tv/view.php?id=$1
  else
      gnome-open http://mantis.edgeware.tv/view.php?id=$1
  fi
}
alias mant='mantis'

function open_jira()
{
  gnome-open "https://jira.edgeware.tv/browse/$1" &> /dev/null
}
alias jira='open_jira'

######################
# misc
alias ll='ls -alF'
# create a directory and cd to it
mkdir_cd()
{
  mkdir -p $1 && cd $1
}
alias mkcd='mkdir_cd'

# fuzzy find
fuzzy_find()
{
    find . -iname "*$1*"
}
alias f=fuzzy_find

# "importante" file
# grep from
IMPORTANTE=/home/nilsa/Documents/importante.txt
importante_grep()
{
  grep -i "$@" "$IMPORTANTE"
}
alias impgrep='importante_grep'
# open
alias vimimp='vim "$IMPORTANTE"'

# print as decimal
alias dec='printf "%d\n" '
# print as hexadecimal
alias hex='printf "0x%x\n" '

# checkpatch.pl - pipe your diff to this alias
alias checkpatch='/home/nilsa/git/monorepo/utils/build-tools/checkpatch/checkpatch.pl --no-tree --no-signoff --show-types --max-line-length=100 --ignore SPLIT_STRING --ignore PREFER_PR_LEVEL --ignore CONST_STRUCT --ignore FILE_PATH_CHANGES -'

cd /home/nilsa/git/monorepo
source /home/nilsa/git/monorepo/docker-alias.sh
cd - > /dev/null

# copy paste using xclip
# copy file to clipboard
copy_to_clipboard()
{
    xclip -sel clip < "${1}"
}
alias ctrl-c='copy_to_clipboard'
