" writepre.vim - remove trailing whitespace, update contact header, ...
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.05.28 20:59 ==

function! eight#writepre#call()
  if &binary || g:writepre_disabled
    return
  endif

  " Save the position of cursor.
  let save_pos = winsaveview()

  " Index of last element in history.
  let index = histnr( 'search' )

  " __ WHITESPACE _________________________

  " The keepjumps disables the modifying of jumplist.
  silent! keepjumps lockmarks %s#\s\+$##ge          " Remove trailing whitespace
  silent! keepjumps lockmarks %s#\n\{3,}#\r\r#ge    " Multiply blank lines.
  silent! keepjumps lockmarks %s#\n\+\%$##e         " Blank lines on the end of the file.

  " __ UPDATE DATE ________________________

  if &filetype == 'help'
    keepjumps lockmarks 0 call EightHeader( 78, 'center', 1, ['*'.expand('%').'*', ' ', 'Last change: '.strftime('%Y. %m. %d.')], '', 'For Vim version 7.4' )
  endif

  " __ CONTACT HEADER _____________________

  silent! keepjumps lockmarks 0 /=\+ BimbaLaszlo.*= \d\+\.\d\+\.\d\+ \d\+:\d\+/ call eight#contact#call()

  if &filetype == 'asciidoc'
    silent! keepjumps lockmarks 0 /^BimbaLaszlo.*\n\d\+/ call setline( line( '.' ) + 1, strftime('%Y.%m.%d') )
    silent! keepjumps lockmarks 0 /^:revdate:/           call setline( '.', substitute( getline( '.' ), '^:revdate:\s*\zs.*', strftime('%Y.%m.%d'), '' ) )
  endif

  " Remove elements from history.
  for i in range( histnr( 'search' ) - index )
    call histdel( 'search', -1 )
  endfor

  " Restore cursor position.
  call winrestview( save_pos )
endfunction
