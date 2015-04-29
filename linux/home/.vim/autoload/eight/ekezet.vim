" ekezet.vim - remove accents from lines
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:20 ==

function! eight#ekezet#call( start, stop ) range
  for i in range( a:start, a:stop )
    let line = tr( getline( i ), 'ÁÉÍÓÖŐÚÜŰáéíóöőúüű', 'AEIOOOUUUaeiooouuu' )
    call setline( i, line )
  endfor
endfunction
