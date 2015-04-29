" Generate tags if the file is in a git repository.
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:25 ==

function! Tags( do_it )
  let oldredir = &shellredir
  set shellredir=1>
  " Remove trailing newline.
  let top = substitute( system( 'git rev-parse --show-toplevel' ), '\n$', '', '' )
  let &shellredir = oldredir
  if top == ''
    return
  endif
  if a:do_it
    let oldcd = getcwd()
    exe 'cd ' . top
    call system( 'ctags -R --tag-relative --exclude=.git --languages=-asciidoc,-text -f "'. top . '/.git/tags"' )
    exe 'cd ' . oldcd
  endif
  exe 'set tags+=' . top . '/.git/tags'
endfunction
