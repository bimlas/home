" Ne adjon ki hangot.
set vb t_vb=

if has( 'win32' )
  set guifont=Consolas:h11
else
  let &guifont = 'Monospace 11'
endif

" Ablak mereteinek megadasa.
" set lines=50
" let &columns = &foldcolumn + (&number ? &numberwidth : 0) + &textwidth
set lines=999
set columns=999

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
