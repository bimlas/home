" Neovim-specific .gvimrc

" Neovim bug on Windows: extra buffer opening
" https://github.com/equalsraf/neovim-qt/issues/417#issuecomment-397892072
if @% == ""
  bdelete
endif

" Neovim doesn't know `has('gui_running')`, thus I have to decalre this in
" ginitrc.
if strftime("%H") >= 7 && strftime("%H") <= 17
  set background=light
else
  set background=dark
endif
