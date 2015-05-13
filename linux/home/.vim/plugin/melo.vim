"                           MUNKAHELYI BEALLITASOK
" ============================================================================

command!  GCodeGetAllLimits  call GCodeGetAllLimits()
function! GCodeGetAllLimits()
  cd %:p:h
  args *.nc *.tap
  let @a = ''
  argdo normal ggVG"Ay
  new
  set buftype=nofile
  normal "ap
  normal zR
  :%GCodeGetLimits
endfunction

if $USERNAME == 'Laci'
  let g:statfugitive_disabled = 1
  augroup melo
    autocmd!
    autocmd  BufNewFile  *.txt  set fileencoding=default
    autocmd  BufRead     *.txt  if ! getfsize( expand( '%' ) ) | set fileencoding=default | endif
  augroup END
endif
