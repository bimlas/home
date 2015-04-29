" run.vim - run file
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.01.09 08:37 ==

function! eight#run#call( args )
  let oldcwd = getcwd()
  cd %:h
  exe '!% ' . a:args
  exe 'cd ' . oldcwd
endfunction
