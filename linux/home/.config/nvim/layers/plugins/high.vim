" all-in-one highlighter plugin
" WIP
Plug 'https://gitlab.com/bimlas/vim-high'

let g:high_lighters = {
      \ 'words': {'_hlgroups': []},
      \ 'unite_directory': {'whitelist': ['unite', 'denite']},
      \ 'invisible_space': {},
      \ }

for color in ['8ccbea', 'a4e57e', 'ffdb72', 'ff7272', 'ffb3ff', '9999ff']
  exe 'autocmd vimrc ColorScheme,VimEnter * highlight! HighWords'.color.' guibg=#'.color.' guifg=#000000'
  let g:high_lighters.words._hlgroups += ['HighWords'.color]
endfor

autocmd vimrc CursorHold *
      \ let pos = winnr()
      \ | windo call high#UpdateGroups()
      \ | exe pos.'wincmd w'
