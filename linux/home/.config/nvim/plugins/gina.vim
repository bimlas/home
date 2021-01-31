" LAMBDALISUE/GINA.VIM
" git integration
" $ install git
if !exists('g:vimrc_minimal_plugins')
  Plug 'lambdalisue/gina.vim'
endif

autocmd vimrc VimEnter * call PostGina()
function! PostGina()
  call gina#custom#command#option('status', '--branch')
  call gina#custom#command#alias('status', 's')

  call gina#custom#command#option('show', '-p|--patch')
  call gina#custom#command#option('show', '--stat')
  call gina#custom#command#alias('show', 'sw')
  call gina#custom#command#option('sw', '-p|--patch')
  call gina#custom#command#option('sw', '--stat')

  call gina#custom#command#alias('log', 'l')
  call gina#custom#command#option('l', '--graph')
  call gina#custom#command#alias('log', 'la')
  call gina#custom#command#option('la', '--graph')
  call gina#custom#command#option('la', '--all')
  call gina#custom#command#alias('log', 'las')
  call gina#custom#command#option('las', '--graph')
  call gina#custom#command#option('las', '--all')
  call gina#custom#command#option('las', '--simplify-by-decoration')

  call gina#custom#command#option('diff', '--stat')
  call gina#custom#command#option('diff', '-p|--patch')
  call gina#custom#command#alias('diff', 'df')
  call gina#custom#command#option('df', '--stat')
  call gina#custom#command#option('df', '-p|--patch')
  call gina#custom#command#alias('diff', 'dfc')
  call gina#custom#command#option('dfc', '--stat')
  call gina#custom#command#option('dfc', '-p|--patch')
  call gina#custom#command#option('dfc', '--cached')

  call gina#custom#command#alias('commit', 'c')
  call gina#custom#command#alias('commit', 'ca')
  call gina#custom#command#option('ca', '--amend')
endfunction
