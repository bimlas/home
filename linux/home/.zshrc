# ~/.zshrc
# To set up zsh as the default shell, run
#
#   chsh -s /bin/zsh
#
# Log in again in to the desktop.

#                                 PROMPT                                  {{{1
# ============================================================================

setopt prompt_subst

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' formats '%F{blue}[%F{28}%b%F{blue}]'
zstyle ':vcs_info:*' enable git
precmd () { vcs_info }

PROMPT=$'\n%B%F{blue}┌─${vcs_info_msg_0_}%B%f %~\n%F{blue}└─ %(!.%F{red}#.%F{white}$)%f%b '
RPROMPT='%B%(?..%F{red}[%?])%F{blue}[%f%T%F{blue}]%b%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{blue}[%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue}]%f%b"

#                            COMPLETE OPTIONS                             {{{1
# ============================================================================

autoload -U compinit
compinit

# Copied from debian's default .zshrc.
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format $'\n%F{yellow}== Completing %d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#                                  OTHER                                  {{{1
# ============================================================================

setopt NO_BEEP

# Delete part of path instead of the whole one.
bindkey '^W' vi-backward-kill-word
                                                                         # }}}
source $HOME/.sh_commons
