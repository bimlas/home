" Ne adjon ki hangot.
set vb t_vb=
set visualbell

if has( 'win32' )

  " set guifont=DejaVu_Sans_Mono:h11
  set guifont=Consolas:h11

  " Ablak teljes meretuve tetele.
  autocmd  GUIEnter  *  simalt ~xm

else

  let &guifont = 'Liberation Mono 11'

endif

" Ablak mereteinek megadasa.
set lines=50
let &columns = &foldcolumn + (&number ? &numberwidth : 0) + &textwidth

" Linux-on belassul tole... (-_-')
" set cursorcolumn
" set cursorline

" Toolbar kikapcsolasa.
set guioptions-=T

" Menusor kikapcsolasa.
set guioptions-=m

" A scroll-ok csak akkor latszodjanak, ha szukseg van rajuk?
set guioptions-=L
set guioptions-=R
" Mindig latszodjanak?
set guioptions-=l
set guioptions-=r
set guioptions+=b

" A tabok neve ele irja ki a tab szamat.
let &guitablabel = " %N \| %t %m "
