cabbrev  argdo silent argdo silent

command  W  noautocmd write
command  Wall  noautocmd wall

command  MyCopyAbsolutePath
      \ let @+ = expand('%:p')
      \ | echo @+
command  MyCopyRelativePath
      \ let @+ = substitute(expand('%:p'), getcwd() . '/', '', '')
      \ | echo @+
command  MyCopyReference
      \ let @+ = substitute(expand('%:p'), getcwd() . '/', '', '') . ': ' . nvim_treesitter#statusline()
      \ | echo @+
