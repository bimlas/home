" gdo.vim - run command in the root of the git repository or in the cwd
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.01.09 08:33 ==

function! eight#gdo#call( args )
  let oldcwd = getcwd()
  if exists( ':Gcd' )
    Gcd
  endif
  exe a:args
  exe 'cd ' . oldcwd
endfunction
