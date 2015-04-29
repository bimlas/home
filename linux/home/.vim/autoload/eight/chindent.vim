" chindent.vim - change the indentation of lines
"
" The first argument is the old value count in spaces, the second is the new.
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:17 ==

function eight#chindent#call( start, stop, oldwidth, newwidth ) range
  let save_sw = &shiftwidth
  let save_ts = &tabstop
  let save_et = &expandtab

  let &shiftwidth = a:oldwidth
  let &tabstop    = a:oldwidth
  set noexpandtab

  silent exe a:start . ',' . a:stop . ' >'

  let &shiftwidth = a:newwidth
  let &tabstop    = a:newwidth
  set expandtab

  silent exe a:start . ',' . a:stop . ' <'

  let &shiftwidth = save_sw
  let &tabstop    = save_ts
  let &expandtab  = save_et
endfunction
