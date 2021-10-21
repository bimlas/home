cabbrev  argdo silent argdo silent

command  W  noautocmd write
command  Wall  noautocmd wall

command  MyCopyRelativePath
      \ let @+ = substitute(expand('%:p'), getcwd() . '/', '', '')
      \ | echo @+
command  MyCopyReference
      \ let @+ = substitute(expand('%:p'), getcwd() . '/', '', '') . ': ' . nvim_treesitter#statusline()
      \ | echo @+
