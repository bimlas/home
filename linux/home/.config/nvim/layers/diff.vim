" :help diff-diffexpr: Added `--minimal` flag
"
"   -d
"   --minimal
"      Change the algorithm perhaps find a smaller set of changes. This makes
"      diff slower (sometimes much slower)

if &diffexpr == ''
  set diffexpr=MyDiff()
endif
function! MyDiff()
    let opt = ''
    if &diffopt =~ 'icase'
      let opt = opt . '-i '
    endif
    if &diffopt =~ 'iwhite'
      let opt = opt . '-b '
    endif
    silent execute '!diff -a --binary --minimal ' . opt . ' "' . v:fname_in . '" "' . v:fname_new . '" > "' . v:fname_out . '"'
endfunction

" Disable foldings in diffs
autocmd vimrc FileType diff setlocal nofoldenable
