" syncwin.vim - Synchronise scrolling of windows like diff
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:17 ==

let s:sync_win = 0

function! eight#syncwin#call()
  let nr = winnr()
  let s:sync_win = 1 - s:sync_win

  " If a new window opened while syncwin enabled, then it will have reversed
  " behaviour without this.
  if ! s:sync_win
    windo set noscrollbind nocursorbind
    exe nr . 'wincmd w'
    return
  endif

  windo set scrollbind cursorbind nowrap
  exe nr . 'wincmd w'
  syncbind
  set scrollopt+=hor
endfunction
