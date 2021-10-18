" List of possible newline charaters and encoding. Using the first option for
" new files.
" utf8:     The most used encoding
" utf-16le: Windows registry files (.reg) encoding
" cp1250:   Hungarian Windows default encoding
" default:  System default
set fileformats=unix,dos fileencodings=utf8,ucs-bom,cp1250,default,utf-16le

" For newly created buffers and files Vim does not shows the encoding without
" this
let &fileencoding = matchstr(&fileencodings, '^[^,]\+')

" Do not highlight `$()` in shell scripts with error color
let is_posix = 1

" Manual bongeszesenek lehetosege.
if !has('win32')
  runtime ftplugin/man.vim
endif
