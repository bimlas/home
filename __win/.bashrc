# ~/.bashrc
# For msys/git bash.

if [[ -z "$PS1" ]]; then
  return
fi

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s extglob
shopt -s checkwinsize

ps1_default="\033[0m"
ps1_cyan="\033[1;36m"
ps1_white="\033[1;37m"
ps1_red="\033[0;31m"

ps1_topleft="\342\224\214"
ps1_bottomleft="\342\224\224"
ps1_vertical="\342\224\200"

source /etc/git-completion.bash
ps1_git='$(__git_ps1 "[$ps1_white%s$ps1_cyan]")'
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=true
GIT_PS1_DESCRIBE_STYLE=describe

PS1="\n$ps1_cyan$ps1_topleft$ps1_vertical"
PS1+="[$ps1_white\A$ps1_cyan]"
PS1+="$ps1_git "
PS1+="$ps1_white\w\n"
PS1+="$ps1_cyan$ps1_bottomleft$ps1_vertical "
PS1+="$(if [[ ${EUID} == 0 ]]; then echo $ps1_red; else echo $ps1_white; fi)\\$ $ps1_default"
export PS1

alias ls='ls -Av --color --group-directories-first'
alias grep='grep --color'
alias du='du -b'
