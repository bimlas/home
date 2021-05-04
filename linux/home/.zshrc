# ~/.zshrc
# To set up zsh as the default shell, run
#
#   chsh -s /bin/zsh
#
# Log in again in to the desktop.

autoload -U colors     && colors
autoload -U promptinit && promptinit
source ~/bin/zsh/fzf-zsh-completion.sh

export ZSHZ_CMD=cdd
source ~/bin/zsh/zsh-z.plugin.zsh

setopt prompt_subst

#                                 PROMPT                                  {{{1
# ============================================================================

# Git prompt.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' formats $'\n│ %F{yellow}Git: %b'
precmd () { vcs_info }

# Python virtualenv.
export VIRTUAL_ENV_DISABLE_PROMPT=1
function virtualenv_info()
{
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv="\n│ %F{green}Python$(python -c 'import sys; print(sys.version_info.major)') virtualenv: ${VIRTUAL_ENV##*/}"
  else
    venv=''
  fi
  echo $venv
}

# Indicate if the terminal has been opened from nnn
nnn_info()
{
  if [[ -v 'NNN' || -v 'nnn' ]]; then
    echo "%F{yellow}NNN "
  fi
}

jobs_info()
{
  jobs | prompt_jobs_info.sh %F{cyan} %F{green} %F{red} | sed 's/.\+/\n│ %F{cyan}Jobs: &\n/'
}

# Errorcode of last command
errorcode_info=$'%(?..\n│ %F{red}Error code: %?)'

PROMPT=$'\n%B%F{blue}┌[%f%T%F{blue}%B]%f %~ %F{blue}${vcs_info_msg_0_}%F{blue}$(virtualenv_info)%F{blue}${errorcode_info}%F{blue}$(jobs_info)\n%F{blue}└ $(nnn_info)%(!.%F{red}#.%F{white}$)%f%b '

#                            COMPLETE OPTIONS                             {{{1
# ============================================================================
# See `man zshcompsys` for more information.

# Custom completion scripts
fpath=(~/.zsh/completion $fpath)

autoload -U compinit && compinit

# Show hidden files too.
_comp_options+=(globdots)

# Use builtin completion menu. (?)
zstyle ':completion:*' use-compctl true

# Show description for argument completions.
zstyle ':completion:*' verbose true

# List newly installed executables (without restarting Zsh).
zstyle ':completion:*' rehash true

# Set up types of completion.
zstyle ':completion:*' completer _complete _approximate _expand

# Case insensitive match.
zstyle ':completion:*' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Ignore completion to commands we don't have.
zstyle ':completion:*:functions' ignored-patterns '_*'

# Show hidden files too and match case-insensitively.
zstyle ':completion:*' list-dirs-first true

# Highlight currently completed element (hit Tab more than once).
zstyle ':completion:*' menu select=1
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Print the group name of completions before the exact elements.
zstyle ':completion:*' format $'\n%F{yellow}== %d%f'

# Don't know exactly whats these doing, but I copied from Debian's .zshrc.
zstyle ':completion:*' auto-description 'specify: %d'

# All different types of matches displayed separately
zstyle ':completion:*' group-name ''

# FZF tab-completion specific
zstyle ':completion:*' fzf-search-display true
# Preview `git diff` when completing git add
zstyle ':completion::*:git::git,add,*' fzf-completion-opts --preview='
for arg in {+1}; do
  { git diff --color=always -- "$arg" } 2>/dev/null
done'
# Compare with master when completing git checkout
zstyle ':completion::*:git::git,checkout,*' fzf-completion-opts --preview='
for arg in {+1}; do
  { git --no-pager log --oneline --graph --right-only --date-order --boundary --pretty="format:%s" master.."$arg" } 2>/dev/null
done'
# Use the same colors for listing files as `ls`.
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Custom completion for `kill`.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#                           PYTHON PIP COMPLETE                           {{{2
# ____________________________________________________________________________

function _pip_completion
{
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
compctl -K _pip_completion pip2
compctl -K _pip_completion pip3

#                                   FZF                                   {{{2
# ____________________________________________________________________________
#
# https://github.com/junegunn/fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#                                  OTHER                                  {{{1
# ============================================================================

setopt NO_BEEP
setopt NUMERIC_GLOB_SORT

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# Recursive search on history.
bindkey '^p'   history-beginning-search-backward
bindkey '^[[A' history-beginning-search-backward  # Up (on TTY)
bindkey '^[OA' history-beginning-search-backward  # Up (on Xterm)
bindkey '^n'   history-beginning-search-forward
bindkey '^[[B' history-beginning-search-forward   # Down (on TTY)
bindkey '^[OB' history-beginning-search-forward   # Down (on Xterm)
                                                                         # }}}
source $HOME/.sh_commons
