" Ne adjon ki hangot.
set vb t_vb=

if has( 'win32' )
  " Mivel a consolas nem jeleniti meg nehany utf8 karaktert, igy maradok a
  " dejavu-nal.
  " set guifont=Consolas:h11
  set guifont=DejaVu_Sans_Mono:h10
else
  let &guifont = 'Monospace 10'
endif

" Ablak mereteinek megadasa.
" set lines=50
" let &columns = &foldcolumn + (&number ? &numberwidth : 0) + &textwidth
set lines=999 columns=999

" Linux-on belassul tole... (-_-')
" set cursorcolumn cursorline

" Toolbar kikapcsolasa.
set guioptions-=T

" Menusor kikapcsolasa.
set guioptions-=m

" Dialogus ablakok helyett a terminalban megszokott modon tegye fel a
" kerdeseit.
set guioptions+=c

" A scroll-ok csak akkor latszodjanak, ha szukseg van rajuk?
set guioptions-=L
set guioptions-=R
" Mindig latszodjanak?
set guioptions-=l
set guioptions-=r
set guioptions-=b

" A tabok neve ele irja ki a tab szamat.
let &guitablabel = " %N \| %t %m "
