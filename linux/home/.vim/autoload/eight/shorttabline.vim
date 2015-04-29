" shorttabline.vim - list of tabs in terminal (found somewhere on the net)
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:17 ==

function! eight#shorttabline#call()
  let ret = ''

  for i in range(tabpagenr('$'))
    " select the color group for highlighting active tab
    if i + 1 == tabpagenr()
      let ret .= '%#TabLineSel#'
    else
      let ret .= '%#TabLineFill#'
    endif

    " find the buffername for the tablabel
    let buflist = tabpagebuflist(i+1)
    let winnr = tabpagewinnr(i+1)
    let buffername = bufname(buflist[winnr-1])
    let filename = fnamemodify(buffername,':t')

    " check if there is no name
    if filename == ''
      let filename = 'noname'
    endif

    let ret .= ' '.(i+1).':'

    " only show the first 6 letters of the name and
    " .. if the filename is more than 8 letters long
    if strlen(filename) >= 8
      let ret .= filename[0:5].'..'
    else
      let ret .= filename.''
    endif

    if getbufvar(buflist[winnr-1], "&modified")
      let ret .= '[+]'
    endif

    let ret .= ' '
  endfor

  " after the last tab fill with TabLineFill and reset tab page #
  let ret .= '%#TabLineFill#%T'

  return ret
endfunction
