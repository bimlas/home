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

" Ablak mereteinek megadasa, ha nem a Total Commander lister programjakent
" mukodik.
if !exists('g:tcmd_lister')
  " set lines=50
  " let &columns = &foldcolumn + (&number ? &numberwidth : 0) + &textwidth
  set lines=999 columns=999

  " Az ablak bal-felso sarka a desktop-on (pixelben megadva).
  winpos 0 0
endif

" :help guioptions
set guioptions=cg

" A tabok neve ele irja ki a tab szamat.
let &guitablabel = " %N \| %t %m "

" Show tooltip for the object under the mouse.
set ballooneval
