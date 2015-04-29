" help.vim - print filetype specific help of word under the cursor
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:20 ==

function! eight#help#call( word )
  if &filetype =~ 'vim\|help'

    let word = matchstr( a:word, '\([bwtglsav]:\)\?\(\k\|-\)\+\((\|[+-]\?=\)\?' )
    if word =~ '=$'
      let word = "'" . substitute( word, '[+-]\?=', '', '' ) . "'"
    endif

    silent! exe 'help ' . word

  elseif &filetype == 'tex'

    let word = matchstr( a:word, '.\{-}\\\?\(\k\+\).*' )
    silent! exe 'help ' . word

  else

    let word = matchstr( a:word, '.\{-}\(\k\+\).*' )
    exe 'Man 3 ' . word

    return

  endif

  if v:errmsg != ''
    echohl ErrorMsg | echo v:errmsg | echohl None
  endif

  return
endfunction
