" Ne adjon ki hangot.
set vb t_vb=

if has( 'win32' )
  " Consolas cannot display some UTF8 chars, but I keeping it as a fallback.
  set guifont=DejaVu_Sans_Mono:h10,Consolas:h10
else
  let &guifont = 'DejaVu Sans Mono 10'
endif

" Ablak mereteinek megadasa, ha nem a Total Commander lister programjakent
" mukodik.
if exists('g:vimrc_minimal_plugins')
  set lines=56 columns=160
else
  " set lines=50
  " let &columns = &foldcolumn + (&number ? &numberwidth : 0) + &textwidth
  set lines=999 columns=999

  " Az ablak bal-felso sarka a desktop-on (pixelben megadva).
  winpos 0 0
endif

" :help guioptions
set guioptions=c

" A tabok neve ele irja ki a tab szamat.
let &guitablabel = " %N \| %t %m "

" Don't show tooltip for the object under the mouse (don't using mouse).
set noballooneval
