" triv.vim - use translate.google.com via translate.rb in vim
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:26 ==

let g:triv_lang = ['hu', 'en']
let g:triv_win_height = 10
let g:triv_win_placement = 'botright'

let g:triv_visible = 0
let g:triv_buffers = [0, 0]
let g:triv_windows = [0, 0]

function! TrivInitBuf( nr )
  let g:triv_buffers[a:nr] = winbufnr( 0 )
  let g:triv_windows[a:nr] = winnr()
  exe 'nnoremap  <buffer>  <CR>   :call TrivTranslate(' . a:nr . ')<CR>'
  nnoremap       <buffer>  <Del>  :%d<CR>
  setlocal buftype=nofile bufhidden=hide noswapfile
endfunction

function! TrivToggle()
  if !executable( 'translate' )
    echo 'translate command not available, please run: gem install google-translate'
    return
  endif
  if ! g:triv_visible
    exe g:triv_win_placement . g:triv_win_height . ' new'
    call TrivInitBuf( 0 )
    vnew
    call TrivInitBuf( 1 )
  endif
endfunction

function! TrivTranslate( nr )
  " Join the lines in the buffer.
  let input = join( getbufline( g:triv_buffers[a:nr], 0, '$' ) )
  " Switch to the another window
  exe g:triv_windows[!a:nr] . 'wincmd w'
  " Delete the contents of the buffer.
  %d
  " Do the translation (and leave out error messages).
  let shellredir = &shellredir
  set shellredir=1>
  silent! exe 'read !translate ' . g:triv_lang[a:nr] . ':' . g:triv_lang[!a:nr] . ' "' . input . '"'
  let &shellredir = shellredir

endfunction
