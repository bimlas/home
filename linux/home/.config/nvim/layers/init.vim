" Dedicated autocommand group for .vimrc stuff
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913
augroup vimrc
  autocmd!
augroup END

" Nvim has no direct connection to the system clipboard ("+" register) without
" this
set clipboard+=unnamed

" I using Git grep most of the time instead of standard grepping tools.
let &grepprg = 'git grep -n'
