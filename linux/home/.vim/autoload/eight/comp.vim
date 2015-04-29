" comp.vim - compile without makefile, the errors displayed in quickfix window
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.16 12:49 ==

let g:COMPFLAGS = ''

function! eight#comp#call( args )
  if a:args != ''
    let flags = a:args
  else
    let flags = g:COMPFLAGS
  endif

  let project_dir = exists( 'b:git_dir' ) ? fnamemodify( b:git_dir, ':h' ) . '/' : ''
  if filereadable( project_dir . 'makefile' )
    make -C project_dir -f makefile
    return
  endif

  let save_makeprg = &makeprg

  " __ GCC ________________________________

  if &filetype =~ '^\(c\|cpp\)$'
    compiler gcc

    if &filetype == 'c'
      let &makeprg = 'gcc'
    elseif &filetype == 'cpp'
      let &makeprg = 'g++'
    endif

    let &makeprg .= ' -o "' . expand( '%:r' ) . '" -Wall "' . expand( '%' ) . '" ' . flags
  endif

  " __ PYTHON______________________________

  if &filetype == 'python'
    compiler pyunit
    let &makeprg = 'python3 "' . expand( '%' ) . '" ' . flags
  endif

  " __ RUBY _______________________________

  if &filetype == 'ruby'
    compiler ruby
    let &makeprg = 'ruby "' . expand( '%' ) . '" ' . flags
  endif

  " __ DOCBOOK ____________________________

  if &filetype == 'docbk'
    compiler xmllint
    set errorformat+=%*[^:]\ error\ :\ %m
    let &makeprg = 'xmlto ' . (flags != '' ? flags : 'txt') . ' "' . expand( '%' ) . '"'
  endif

  " __ LATEX ______________________________

  if &filetype == 'tex'
    compiler tex
    let &makeprg = 'pdflatex -interaction nonstopmode "' . expand( '%' ) . '" ' . flags
  endif

  " _______________________________________

  echo "COMP: " . &makeprg
  silent make
  " A kimenet bemasolasa egy uj bufferba.
  " new | execute '.!' . &makeprg

  let &makeprg = save_makeprg
  redraw!
endfunction
