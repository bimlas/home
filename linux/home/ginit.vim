" Neovim-specific .gvimrc

" Neovim doesn't know `has('gui_running')`, thus I have to decalre this in
" ginitrc.
if strftime("%H") >= 7 && strftime("%H") <= 17
  set background=light
else
  set background=dark
endif
