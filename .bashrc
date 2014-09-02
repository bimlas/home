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

# Colors.
clr_txtblk='\[\e[0;30m\]' # Black - Regular
clr_txtred='\[\e[0;31m\]' # Red
clr_txtgrn='\[\e[0;32m\]' # Green
clr_txtylw='\[\e[0;33m\]' # Yellow
clr_txtblu='\[\e[0;34m\]' # Blue
clr_txtpur='\[\e[0;35m\]' # Purple
clr_txtcyn='\[\e[0;36m\]' # Cyan
clr_txtwht='\[\e[0;37m\]' # White
clr_bldblk='\[\e[1;30m\]' # Black - Bold
clr_bldred='\[\e[1;31m\]' # Red
clr_bldgrn='\[\e[1;32m\]' # Green
clr_bldylw='\[\e[1;33m\]' # Yellow
clr_bldblu='\[\e[1;34m\]' # Blue
clr_bldpur='\[\e[1;35m\]' # Purple
clr_bldcyn='\[\e[1;36m\]' # Cyan
clr_bldwht='\[\e[1;37m\]' # White
clr_unkblk='\[\e[4;30m\]' # Black - Underline
clr_undred='\[\e[4;31m\]' # Red
clr_undgrn='\[\e[4;32m\]' # Green
clr_undylw='\[\e[4;33m\]' # Yellow
clr_undblu='\[\e[4;34m\]' # Blue
clr_undpur='\[\e[4;35m\]' # Purple
clr_undcyn='\[\e[4;36m\]' # Cyan
clr_undwht='\[\e[4;37m\]' # White
clr_bakblk='\[\e[40m\]'   # Black - Background
clr_bakred='\[\e[41m\]'   # Red
clr_bakgrn='\[\e[42m\]'   # Green
clr_bakylw='\[\e[43m\]'   # Yellow
clr_bakblu='\[\e[44m\]'   # Blue
clr_bakpur='\[\e[45m\]'   # Purple
clr_bakcyn='\[\e[46m\]'   # Cyan
clr_bakwht='\[\e[47m\]'   # White
clr_txtrst='\[\e[0m\]'    # Text Reset

# Special characters.
chr_topleft='\342\224\214'
chr_bottomleft='\342\224\224'
chr_vertical='\342\224\200'

# Command line completion.
if [[ -e '/etc/bash_completion' ]]; then
  source '/etc/bash_completion'
fi

# Add ~/bin to $PATh.
if [[ -e $HOME/bin ]] && [[ ! $PATH =~ $HOME/bin ]]; then
  PATH=$HOME/bin:$PATH
fi

# Custom prompt.
if [[ -e '/etc/bash_completion.d/git-prompt' ]]; then
  ps1_git='$(__git_ps1 "[%s]")'
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=true
  GIT_PS1_DESCRIBE_STYLE=describe
else
  ps1_git=
fi

PS1="\n$clr_bldcyn$chr_topleft$chr_vertical"
PS1+="[$clr_bldwht\A$clr_bldcyn]"
PS1+="$ps1_git "
PS1+="$clr_bldwht\w\n"
PS1+="$clr_bldcyn$chr_bottomleft$chr_vertical "
PS1+="$(if [[ ${EUID} == 0 ]]; then echo $clr_bldred; else echo $clr_bldwht; fi)\\$ $clr_txtrst"
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
