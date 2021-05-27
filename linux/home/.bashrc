# ~/.bashrc
#
# TIPP: If you opened in vim and don't know folding, press zR to open all
# folds.
#
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

# Exit if the shell is not interactive.
if [[ -z "$PS1" ]]; then
  return
fi

source $HOME/.sh_commons

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
HISTCONTROL=ignoreboth:erasedups

# Save the command to the history when entering it instead of when leaving
# bash.
PROMPT_COMMAND='history -a'

#                                 COLORS                                  {{{1
# ============================================================================

clr_txtblk='\e[0;30m' # Black - Regular
clr_txtred='\e[0;31m' # Red
clr_txtgrn='\e[0;32m' # Green
clr_txtylw='\e[0;33m' # Yellow
clr_txtblu='\e[0;34m' # Blue
clr_txtpur='\e[0;35m' # Purple
clr_txtcyn='\e[0;36m' # Cyan
clr_txtwht='\e[0;37m' # White
clr_bldblk='\e[1;30m' # Black - Bold
clr_bldred='\e[1;31m' # Red
clr_bldgrn='\e[1;32m' # Green
clr_bldylw='\e[1;33m' # Yellow
clr_bldblu='\e[1;34m' # Blue
clr_bldpur='\e[1;35m' # Purple
clr_bldcyn='\e[1;36m' # Cyan
clr_bldwht='\e[1;37m' # White
clr_unkblk='\e[4;30m' # Black - Underline
clr_undred='\e[4;31m' # Red
clr_undgrn='\e[4;32m' # Green
clr_undylw='\e[4;33m' # Yellow
clr_undblu='\e[4;34m' # Blue
clr_undpur='\e[4;35m' # Purple
clr_undcyn='\e[4;36m' # Cyan
clr_undwht='\e[4;37m' # White
clr_bakblk='\e[40m'   # Black - Background
clr_bakred='\e[41m'   # Red
clr_bakgrn='\e[42m'   # Green
clr_bakylw='\e[43m'   # Yellow
clr_bakblu='\e[44m'   # Blue
clr_bakpur='\e[45m'   # Purple
clr_bakcyn='\e[46m'   # Cyan
clr_bakwht='\e[47m'   # White
clr_txtrst='\e[0m'    # Text Reset

#                    ENVIRONMENT VARIABLES, COMPLETION                    {{{1
# ============================================================================

# Special characters.
chr_topleft='\342\224\214'
chr_bottomleft='\342\224\224'
chr_horizontal='\342\224\200'
chr_vertical='\342\224\202'

# Command line completion.
if [[ -e '/etc/bash_completion' ]]; then
  source '/etc/bash_completion'
fi

## Custom prompt.
## Slows down the prompt...
# GIT_PS1_SHOWDIRTYSTATE=true
# GIT_PS1_SHOWSTASHSTATE=true
# GIT_PS1_SHOWUNTRACKEDFILES=true
# GIT_PS1_SHOWUPSTREAM=true
# GIT_PS1_DESCRIBE_STYLE=describe
## Debian
# if [[ -e '/etc/bash_completion.d/git-prompt' ]]; then
#   source /etc/bash_completion.d/git-prompt
## Arch
# elif [[ -e '/usr/share/git/git-prompt.sh' ]]; then
#   source /usr/share/git/git-prompt.sh
# fi

my_git_prompt='`if (git rev-parse --is-inside-work-tree &> /dev/null); then echo -e "'
my_git_prompt+='\n'$chr_vertical'  '$clr_bldylw'Git: '
my_git_prompt+=$clr_bldred
my_git_prompt+='$(git status --porcelain --short -z | sed "s/.\+/* /")'
my_git_prompt+='$(git show-ref stash | sed "s/.\+/$ /")'
my_git_prompt+=$clr_bldylw
my_git_prompt+='$(if (git symbolic-ref -q HEAD &>/dev/null); then git for-each-ref --format="%(refname:short) '$clr_bldwht'%(upstream:trackshort)'$clr_bldylw' %(upstream:remotename)" $(git symbolic-ref -q HEAD); else echo "'$clr_bldred'DETACHED @ $(git rev-parse --short HEAD)"; fi)'
my_git_prompt+='"; fi`'

export JOBS_PROMPT_TEXT="$clr_bldcyn"
my_jobs_info='$('
my_jobs_info+='jobs'
my_jobs_info+='| jobs_prompt'
my_jobs_info+='| sed "s/.\\+/\\n'$chr_vertical'  Jobs: & \\n/")'

PS1="$clr_bldcyn$(printf '_%.0s' {1..78})"
PS1+="\n$clr_bldcyn$chr_topleft$chr_horizontal"
PS1+="[$clr_bldwht\A$clr_bldcyn] "
PS1+="$clr_bldwht\w"
PS1+="$clr_bldcyn$my_git_prompt"
PS1+="$clr_bldcyn$my_jobs_info"
PS1+="\n$clr_bldcyn$chr_bottomleft$chr_horizontal "
PS1+="$(if [[ ${EUID} == 0 ]]; then echo $clr_bldred; else echo $clr_bldwht; fi)\\$ $clr_txtrst"
export PS1

#                                   FZF                                   {{{2
# ____________________________________________________________________________
#
# https://github.com/junegunn/fzf

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
