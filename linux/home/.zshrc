# ~/.zshrc
# To set up zsh as the default shell, run
#
#   chsh -s /bin/zsh
#
# Log in again in to the desktop.

source $HOME/.sh_commons

autoload -U colors     && colors
autoload -U promptinit && promptinit

export FZF_COMPLETION_AUTO_COMMON_PREFIX=true
export FZF_COMPLETION_AUTO_COMMON_PREFIX_PART=true
source ~/bin/zsh/fzf-zsh-completion.sh

setopt prompt_subst

#                                 PROMPT                                  {{{1
# ============================================================================
# man zshmisc -> SIMPLE PROMPT ESCAPES, CONDITIONAL SUBSTRINGS IN PROMPTS

# Git prompt.
autoload -Uz vcs_info
# Enable only Git, disable others
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' formats $'\n%F{blue}│ %F{yellow}Git: %b '
zstyle ':vcs_info:*' actionformats $'\n%F{blue}│ %F{yellow}Git: %b %F{red}(%a) '

vcs_stash_info()
{
  stash=$(git stash list 2> /dev/null)
  if [[ -n "$stash" ]]; then
    echo '%F{red}(stash) '
  fi
}

kubernetes_info()
{
  kubernetes_context=$(cat ~/.kube/config 2>/dev/null| grep -o '^current-context: [^/]*' | cut -d' ' -f2)
  if [ -n "$kubernetes_context" ]; then
      echo "\n%F{blue}│ %F{green}Kubernetes: $kubernetes_context "
  fi
}

dirstack_info()
{
  count=$(dirs -v | tail +2 | wc -l)
  if [[ $count -gt 0 ]]; then
    echo "%F{blue}~$count "
  fi
}

nodejs_info()
{
  if [ -f package.json ]; then
    echo "\n%F{blue}│ %F{green}NodeJS: $(node --version)"
  fi
}

# Show username only if logged in through SSH
ssh_username="%f${SSH_TTY:+%n@%M }"

# Errorcode of last command
errorcode_info=$'%(?..%F{red}?%? )'

jobs_info='%1(j.%F{cyan}&%j .)'

# Indicate if the terminal has been opened from nnn
nnn_info="%F{yellow}${NNN:+NNN }${nnn:+NNN }"

# Owner of the prompt
dollar_or_percent='%(!.%F{red}#.%F{white}$)'

function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  vcs_info

  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    seconds=$(( ($now-$timer)/1000 ))

    elapsed_time=''
    if [[ $seconds -gt 5 ]]; then
      format='%-Ss'
      if [[ $seconds -gt 59 ]]; then format="%-Mm${format}"; fi
      if [[ $seconds -gt 3599 ]]; then format="%-Hh${format}"; fi
      elapsed_time="[%f$(date -u -d @${seconds} +"${format}")%F{blue}] "
    fi
    export elapsed_time
    unset timer
  fi
}

PROMPT=$'\n'
PROMPT+=$'%B%F{blue}┌'
PROMPT+=$'[%f%T%F{blue}] '
PROMPT+=$'${elapsed_time}'
PROMPT+=$'${ssh_username}'
PROMPT+='%F{blue}%~ '
PROMPT+=$'${vcs_info_msg_0_}'
PROMPT+=$'$(vcs_stash_info)'
PROMPT+=$'$(kubernetes_info)'
PROMPT+=$'$(nodejs_info)'
PROMPT+=$'\n%F{blue}└ '
PROMPT+=$'${nnn_info}'
PROMPT+=$'${jobs_info}'
PROMPT+=$'$(dirstack_info)'
PROMPT+=$'${errorcode_info}'
PROMPT+=$'${dollar_or_percent}'
PROMPT+=$'%f%b%k '


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

#                               KUBERNETES                                {{{2
# ____________________________________________________________________________

(which kubectl > /dev/null) && source <(kubectl completion zsh)

#                         JUMP TO RECENT DIRECTORY                        {{{1
# ____________________________________________________________________________

# Usage: `cd` to some directories, `cdr <Tab>` to jump to an earlier dir
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-max 100

#                           BATCH RENAME TOOL                             {{{1
# ____________________________________________________________________________

# Usage: `zmv '(*).(jpg|jpeg)' 'epcot-$1.$2'`, add -n for dry-run
autoload -U zmv


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

# Ctrl + Arrows to jump between words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Less-gready Ctrl-W
autoload -U select-word-style
select-word-style bash
export WORDCHARS='.-'

# Edit current command line
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Navi cheat sheet completion
# https://github.com/denisidoro/navi
if ( which navi > /dev/null ); then
  _navi_call() {
    local result="$(navi "$@" </dev/tty)"
    if [ -z "${result}" ]; then
      result="$(navi --print </dev/tty)"
    fi
    printf "%s" "$result"
  }

  _navi_widget() {
    local -r input="${LBUFFER}"
    local -r last_command="$(echo "${input}" | navi fn widget::last_command)"
    local find="$last_command"
    local replacement="$last_command"

    if [ -z "${last_command}" ]; then
      replacement="$(_navi_call --print)"
    elif [ "${LASTWIDGET}" = "_navi_widget" ] && [ "$input" = "$previous_output" ]; then
      find="$input"
      replacement="$(_navi_call --print --query "${previous_last_command:-$last_command}")"
    else
      replacement="$(_navi_call --print --best-match --query "${last_command}")"
    fi

    previous_last_command="$last_command"
    previous_output="${input//$find/$replacement}"

    zle kill-whole-line
    LBUFFER="${previous_output}"
    region_highlight=("P0 100 bold")
    zle redisplay
  }

  zle -N _navi_widget
  bindkey '^g' _navi_widget
fi
# }}}
