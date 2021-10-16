source $HOME/.config/nvim/layers/init.vim
if has('win32')
  source $HOME/.config/nvim/layers/win32.vim
endif
source $HOME/.config/nvim/layers/readwrite.vim
source $HOME/.config/nvim/layers/textarea.vim
source $HOME/.config/nvim/layers/infoline.vim
source $HOME/.config/nvim/layers/statusline.vim
source $HOME/.config/nvim/layers/diff.vim
source $HOME/.config/nvim/layers/tui.vim
if has('gui_running')
  source $HOME/.config/nvim/layers/gui.vim
endif
source $HOME/.config/nvim/layers/commands.vim
source $HOME/.config/nvim/layers/maps.vim
source $HOME/.config/nvim/layers/plugins.vim
