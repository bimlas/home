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

autocmd vimrc FileType ruby call TextObjMapsRuby()
function! TextObjMapsRuby()
  omap <buffer> ab <Plug>(textobj-ruby-block-a)
  omap <buffer> ib <Plug>(textobj-ruby-block-i)
  omap <buffer> af <Plug>(textobj-ruby-function-a)
  omap <buffer> if <Plug>(textobj-ruby-function-i)

  vmap <buffer> ab <Plug>(textobj-ruby-block-a)
  vmap <buffer> ib <Plug>(textobj-ruby-block-i)
  vmap <buffer> af <Plug>(textobj-ruby-function-a)
  vmap <buffer> if <Plug>(textobj-ruby-function-i)
endfunction

autocmd vimrc FileType python call TextObjMapsPython()
function! TextObjMapsPython()
  omap <buffer> af <Plug>(textobj-python-function-a)
  omap <buffer> if <Plug>(textobj-python-function-i)

  vmap <buffer> af <Plug>(textobj-python-function-a)
  vmap <buffer> if <Plug>(textobj-python-function-i)
endfunction

function! AdocBlockA()
  if search('^\(.\)\1\+$\|^.=\+$', 'Wb') == 0 | return 0 | endif
  let searchfor = getline('.')
  let block_start = getpos('.')
  call search(searchfor, 'W')
  let block_stop = getpos('.')
  return ['V', block_start, block_stop]
endfunction

function! AdocBlockI()
  if search('^\(.\)\1\+$\|^.=\+$', 'Wb') == 0 | return 0 | endif
  let searchfor = getline('.')
  normal j
  let block_start = getpos('.')
  call search(searchfor, 'W')
  normal k
  let block_stop = getpos('.')
  return ['V', block_start, block_stop]
endfunction
