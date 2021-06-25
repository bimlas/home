" Add basic Linux tools (via Msys-Git) to the PATH.
let $PATH = $PATH . ';c:/app/git/usr/bin'

" Backslash (\) helyett forwardslash (/) hasznalat az utvonalakban
" (pl. <C-X><C-F> kiegeszitesenel).
" Tapasztalatbol mondhatom, hogy nem minden plugin szereti (pl. Jedi-vim) -
" ha valamelyik nem mukodik, probald meg kommentelve is.
" set shellslash

" :make ezt a programot hasznalja:
set makeprg=mingw32-make

if has('nvim')
  " Run `:CheckHealth` to verify.

  " pip2 install --upgrade neovim
  let g:python_host_prog = 'c:/app/python2/python.exe'
  " pip3 install --upgrade neovim
  " NOTE: If `:CheckHealth` not works, try `pip3 uninstall msgpack; pip3
  " install msgpack`.
  let g:python3_host_prog = 'c:/app/python3/python.exe'
  " gem update neovim
  let g:ruby_host_prog = 'c:/app/ruby/bin/ruby.exe'
  let g:ruby_default_path = ['c:/app/ruby']
endif
