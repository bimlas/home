" AIRBLADE/VIM-ROOTER
" autochdir to project root when opening a buffer
"
"                            WARNING! DANGER!
"         Scripts which using the cwd will use the project root
" too! For example running a script with QuickRun will generate files to
"                     root instead of script's dir.
if !exists('g:vimrc_minimal_plugins')
  Plug 'airblade/vim-rooter'
endif
