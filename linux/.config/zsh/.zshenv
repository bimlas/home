export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.config/git/bin:$PATH

export EDITOR="nvim"

# Disable translations on command line (man pages, --help, TUI, etc)
# https://www.linuxquestions.org/questions/showthread.php?p=2274163#post2274163
export LANGUAGE=C

# View manuals in vim.
export MANPAGER="/bin/sh -c \"unset PAGER; col -b -x |         \
                 nvim -R                                       \
                 -c 'set nocp'                                 \
                 -c 'filetype plugin on'                       \
                 -c 'syntax enable'                            \
                 -c 'runtime ftplugin/man.vim'                 \
                 -c 'set ft=man ls=0 nosmd nonu nornu nolist'  \
                 -c 'map <CR> <C-]>'                           \
                 -c 'map q :q<CR>' - \""

# FZF default options
export FZF_DEFAULT_OPTS="--exact --multi \
    --bind=tab:accept \
    --bind=ctrl-j:accept \
    --bind=ctrl-space:toggle+down \
    --bind=ctrl-d:page-down \
    --bind=ctrl-u:page-up \
    --bind=ctrl-e:preview-page-down \
    --bind=ctrl-y:preview-page-up \
    --bind=ctrl-w:backward-kill-word \
    --bind=ctrl-a:select-all"
# Open Tmux pane for FZF
FZF_TMUX_OPTS="-d 40%"

# NNN default options
export NNN_PLUG='!:_|x-terminal-emulator;'
