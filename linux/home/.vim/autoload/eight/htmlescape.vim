" htmlescape.vim - encode and decode html entites
"
" http://vim.wikia.com/wiki/HTML_entities
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:18 ==

function! eight#htmlescape#call( line1, line2, action )
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2

  if a:action       " must convert &amp; first
    execute range . 'sno/&/&amp;/eg'
    execute range . 'sno/</&lt;/eg'
    execute range . 'sno/>/&gt;/eg'
  else              " must convert & last
    execute range . 'sno/&lt;/</eg'
    execute range . 'sno/&gt;/>/eg'
    execute range . 'sno/&quot;/"/eg'
    execute range . 'sno/&amp;/&/eg'
  endif

  nohl
  let @/ = search
endfunction
