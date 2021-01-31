" BIMLAS/DOTVIM
" sajat ~/.vim
Plug 'https://gitlab.com/bimlas/dotvim'

" Mindig mutassa a tabokat (megnyitott fajlokat, nem a TAB karakteret).
set tabline=%!dotvim#shorttabline#call()
