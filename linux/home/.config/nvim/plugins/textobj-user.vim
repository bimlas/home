" sajat text-object
Plug 'kana/vim-textobj-user'

" Blokkok, vagy tablazatok kijelolese - a kurzor elotti blokkhatarolot veszi
" alapul. Minden olyan sort, ahol csak ugyanaz a karakter szerepel
" blokkhatarnak veszi. A tablazatokat a ^.=\+$ formaban keresi meg, mert lehet
" pl. |===, vagy ;=== is.
autocmd vimrc FileType asciidoc,asciidoctor
      \ call textobj#user#plugin('adocblock', {
      \   '-': {
      \     'select-a-function': 'AdocBlockA',
      \     'select-a':          'ab',
      \     'select-i-function': 'AdocBlockI',
      \     'select-i':          'ib',
      \   }
      \ })
