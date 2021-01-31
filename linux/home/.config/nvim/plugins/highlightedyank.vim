" MACHAKANN/VIM-HIGHLIGHTEDYANK
" make the yanked region apparent
if !exists('g:vimrc_minimal_plugins')
  Plug 'machakann/vim-highlightedyank'
endif

map y <Plug>(highlightedyank)
