# ~/.bashrc
#
# TIPP: If you opened in vim and don't know folding, press zR to open all
# folds.
#
# ========== BimbaLaszlo(.github.io|gmail.com) =========== 2014.08.19 20:49 ==

# Exit if the shell is not interactive.
if [[ -z "$PS1" ]]; then
  return
fi

# Turn off speaker.
xset b off

#                                  SHOPT                                  {{{1
# ============================================================================

# Extended pattern matching.
# man bash /extglob
shopt -s extglob

# Save the dimensions of terminal after each command. ($LINES, $COLUMNS)
shopt -s checkwinsize

# Continue the history instead of starting a new.
shopt -s histappend

# Save multiline commands to one line.
shopt -s cmdhist

#                                 HISTORY                                 {{{1
# ============================================================================

HISTSIZE=10000
HISTFILESIZE=10000

# Disable duplicated and blank lines in history.
HISTCONTROL=ignoreboth

# Save the command to the history when entering it instead of when leaving
# bash.
PROMPT_COMMAND='history -a'

#                    ENVIRONMENT VARIABLES, COMPLETION                    {{{1
# ============================================================================

# Command line completion.
if [[ -e '/etc/bash_completion' ]]; then
  source '/etc/bash_completion'
fi

# Add ~/bin to $PATh.
if [[ -e $HOME/bin ]] && [[ ! $PATH =~ $HOME/bin ]]; then
  PATH=$HOME/bin:$PATH
fi

# Custom prompt.
ps1_default="\e[0m"
ps1_cyan="\e[1;36m"
ps1_white="\e[1;37m"
ps1_red="\e[0;31m"

ps1_topleft="\342\224\214"
ps1_bottomleft="\342\224\224"
ps1_vertical="\342\224\200"

if [[ -e '/etc/bash_completion.d/git-prompt' ]]; then
  ps1_git='$(__git_ps1 "[$ps1_white%s$ps1_cyan]")'
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=true
  GIT_PS1_DESCRIBE_STYLE=describe
else
  ps1_git=
fi

PS1="\n$ps1_cyan$ps1_topleft$ps1_vertical"
PS1+="[$ps1_white\A$ps1_cyan]"
PS1+="$ps1_git "
PS1+="$ps1_white\w\n"
PS1+="$ps1_cyan$ps1_bottomleft$ps1_vertical "
PS1+="$(if [[ ${EUID} == 0 ]]; then echo $ps1_red; else echo $ps1_white; fi)\\$ $ps1_default"
export PS1

#                                   ALIAS                                 {{{1
# ============================================================================

alias pm-hibernate='echo "NEVER USE IT!"'
alias ls='ls -Av --color --group-directories-first'
alias grep='grep --color'
alias du='du -b'

alias asciidoctor="/media/nyolcas/app/asciidoctor/bin/asciidoctor -a allow-uri-read"

# Disable .vimrc in vim.tiny.
if [[ -e '/usr/bin/vim.tiny' ]]; then
  alias vim.tiny='vim.tiny -u NONE'
fi

# Use w3m as manual pager (in some case it does not works)
# if [[ -e '/usr/bin/w3mman' ]]; then
  # alias man='w3mman'
# fi

# Do not close the image after gnuplot.
if [[ -e '/usr/bin/gnuplot' ]]; then
  alias gnuplot='gnuplot -persist'
fi

#                                FUNCTIONS                                {{{1
# ============================================================================

# Start program then give back the prompt (to run programs with GUI)
x()
{
  nohup $* &> /dev/null &
}

# English-hungarian dictionary, download:
# https://github.com/BimbaLaszlo/vim-eight/blob/master/doc/szotar.txt
szotar()
{
  if [[ -e $HOME/.vim/bundle/vim-eight/doc/szotar.txt ]]; then
    grep "$@" $HOME/.vim/bundle/vim-eight/doc/szotar.txt
  else
    echo "ERROR: missing dictionary $HOME/.vim/bundle/vim-eight/doc/szotar.txt"
  fi
}
