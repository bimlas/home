" Required by lots of plugins and settings
set nocompatible

" Dedicated autocommand group for .vimrc stuff
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913
augroup vimrc
  autocmd!
augroup END

" Add external binaries to PATH (like ctags, rg, etc.)
let $PATH .= (has('win32') ? ';' : ':') . $HOME . '/.vim/bin'

" Use only buffer's dir
set path=.

" I using Git grep most of the time instead of standard grepping tools.
let &grepprg = 'git grep -n'

" Fajlok elore megadott beallitasait hasznalhatja. (fajl elejen, vagy vegen
" talalhato vim-specifikus beallitasok)
set modeline

" Mindig az aktualis fajl konyvtara legyen a cwd.
" Tapasztalatbol mondhatom, hogy nem minden plugin szereti (pl. netrw,
" fugitive).
" UPDATE: a fugitive ugy tunik mar jol kezeli, viszont a vimfiler es unite
" nem.
" set autochdir

" Load project settings.
"
" Usefull for setting up tags to include another
" project's tag file.
" Before loading project-specific settings, reset `tags` to prevent mixing of
" not relevant tag files.
"
" Using a Git hook to generate tags.
" http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
" Triggered by vim-rooter's autocommand.
" https://github.com/airblade/vim-rooter
autocmd vimrc VimEnter * call LoadProjectSettings()
autocmd vimrc User RooterChDir call LoadProjectSettings()

function! LoadProjectSettings() "{{{
  set tags=.git/tags
  try
    source .lvimrc
  catch /^Vim\%((\a\+)\)\=:E484/
  endtry
endfunction "}}}
