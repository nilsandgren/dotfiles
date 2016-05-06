# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PATH="$HOME/bin:$PATH"
export PATH=${PATH}:~/android/android-sdk-linux/tools
# PATH="$PATH:$HOME/bin"

export EDITOR=/usr/bin/vim

#EdgeWare stuff
alias svlog='svn log --limit=1'
# alias snow='xsnow -notrees -nosanta -norudolf -snowflakes 300 -xspeed 4 -yspeed 6 -wsnowdepth 10 -ssnowdepth 30 -nokeepsnow'
# alias snow='xsnow -notrees -nosanta -norudolf -nokeepsnow'
alias sf_ftp='ncftp -u telia_6 -p T3qH3L mediaftp.sfanytime.com'

function mio_login()
{
    if ! [ $1 ]; then
        ssh root@10.16.0.137
    else
        ssh root@10.16.0.$1
    fi
}
alias mio='mio_login'
alias wtv='ssh root@10.16.0.71'

function color_st()
{
  git status "$1" | less -R
}

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
  gnome-open "https://edgeware.atlassian.net/browse/$1"
}
alias jira='open_jira'

# typos
alias ks='echo KOTTFARSSAS; ls'
alias ös='echo As-Ösigt!; ls'
alias bim='echo "Bim! Bim!"; sleep 1; vim'
alias get='git'
alias gut='git'

# vim
alias clear-vim-swap='rm -f ~/.vimswap/*'
alias v='vim'
alias ':e'='vim'

# git
alias gpr='git pull --rebase'
alias gsu='git submodule update'
alias gst='git status'
alias gbr='git branch -avv | cut -c -97 | sed -e "s/$/.../g"'

alias cd1='cd /home/nilsa/git/esb1001'
alias cd2='cd /home/nilsa/git/monorepo/src/esb2001'
alias cd4='cd /home/nilsa/git/esb1004'

# cd to the currently most popular project
alias cdc='cd /home/nilsa/git/monorepo'
# cd to the (never popular) isagw project
alias cdi='cd /home/nilsa/git/isa-gw'

alias mb='ssh nilsa@miobuild'
alias saturn='ssh nilsa@saturn'

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
IMPORTANTE=/mnt/lithium/nilsa/Documents/importante.txt
importante_grep()
{
  grep -i "$@" "$IMPORTANTE"
}
alias impgrep='importante_grep'
# open
alias vimimp='vim "$IMPORTANTE"'
