" help.vim - regenerate helptags (if vundle or pathogen is missing)
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:19 ==

function! eight#helptags#call()
  for name in split( &runtimepath, ',' )
    if isdirectory( name . '/doc' )
      silent! exe 'helptags ' . name . '/doc'
    endif
  endfor
endfunction
