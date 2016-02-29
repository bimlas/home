# ~/.zshrc
# To set up zsh as the default shell, run
#
#   chsh -s /bin/zsh
#
# Log in again in to the desktop.

autoload -U colors     && colors
autoload -U promptinit && promptinit
setopt prompt_subst

#                                 VI-MODE                                 {{{1
# ============================================================================

# Use Vim bindings.
bindkey -v

# Escape from Vi-mode to normal mode.
bindkey -M viins '^o' vi-cmd-mode

# Vi-mode indicator for prompt.
# https://zeitkraut.de/posts/2014-06-29-howto-zsh-vi-style.html
local vi_normal_marker="%{$fg[red]%}%B[N]%b%{$reset_color%}"
local vi_insert_marker="%{$fg[blue]%}%B[I]%b%{$reset_color%}"
local vi_unknown_marker="%{$fg[red]%}%B[?]%b%{$reset_color%}"
local vi_mode="$vi_insert_marker"
vi_mode_indicator () {
  case ${KEYMAP} in
    (vicmd)      echo $vi_normal_marker ;;
    (main|viins) echo $vi_insert_marker ;;
    (*)          echo $vi_unknown_marker ;;
  esac
}

# Reset mode-marker and prompt whenever the keymap changes.
function zle-line-init zle-keymap-select {
  vi_mode="$(vi_mode_indicator)"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

#                                 PROMPT                                  {{{1
# ============================================================================

# Git prompt.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' formats '%F{blue}[%F{green}%b%F{blue}]'
precmd () { vcs_info }

PROMPT=$'\n%B%F{blue}┌─${vcs_info_msg_0_}%B%f %~\n%F{blue}└─ %(!.%F{red}#.%F{white}$)%f%b '
RPROMPT='%B%(?..%F{red}[%?])%F{blue}[%f%T%F{blue}]%b%f${vi_mode}'

ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{blue}[%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue}]%f%b"

#                            COMPLETE OPTIONS                             {{{1
# ============================================================================
# See `man zshcompsys` for more information.

autoload -U compinit && compinit

# Show hidden files too.
_comp_options+=(globdots)

# Use builtin completion menu. (?)
zstyle ':completion:*' use-compctl false

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

# Use the same colors for listing files as `ls`.
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Custom completion for `kill`.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

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
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
                                                                         # }}}
source $HOME/.sh_commons
