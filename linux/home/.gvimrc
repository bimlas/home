" Ne adjon ki hangot.
set vb t_vb=

if has( 'win32' )
  " Mivel a consolas nem jeleniti meg nehany utf8 karaktert, igy maradok a
  " dejavu-nal.
  " set guifont=Consolas:h11
  set guifont=DejaVu_Sans_Mono:h10
else
  let &guifont = 'DejaVu Sans Mono 10'
endif

" Ablak mereteinek megadasa.
" set lines=50
" let &columns = &foldcolumn + (&number ? &numberwidth : 0) + &textwidth
set lines=999 columns=999

" :help guioptions
set guioptions=cg

" A tabok neve ele irja ki a tab szamat.
let &guitablabel = " %N \| %t %m "
