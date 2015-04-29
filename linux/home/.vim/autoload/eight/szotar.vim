" szotar.vim - search for regex in 'szotar.txt' and show in quickfix window
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:17 ==

function! eight#szotar#call( word )
  if len( a:word )
    exe 'vimgrep /' . a:word . '/j ~/.vim/bundle/vim-eight/doc/szotar.txt'
  else
    help szotar
  endif
endfunction
