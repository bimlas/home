" JUNEGUNN/FZF.VIM
" the fuzzy finder
if !exists('g:vimrc_minimal_plugins')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endif
