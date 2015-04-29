" contact.vim - print contact and date
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.16 12:50 ==

function! eight#contact#call()
  call EightHeader( &tw, 'center', 1, ['', '=', strftime(' %Y.%m.%d %H:%M ==')], '', ' BimbaLaszlo (.github.io|gmail.com) ' )
endfunction
