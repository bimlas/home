" szoveg igazitasa nagyon intelligens modon, regex kifejezesekkel
Plug 'junegunn/vim-easy-align'

" A | az asciidoctor-nak megfelelo formazasokat is felismeri, az
" 'ignore_unmatched' miatt a leghosszabb sor vege utan fog kerulni a pattern,
" fuggetlenul attol, hogy abban szerepelt-e.
let g:easy_align_delimiters = {
      \ '|': {'pattern': '\(\(^\|\s\)\@<=\(\d\+\*\)\?\(\(\d\+\|\.\d\+\|\d\+\.\d\+\)+\)\?\([\^<>]\|\.[\^<>]\|[\^<>]\.[\^<>]\)\?[a-z]\?\)\?|', 'filter': 'v/^|=\+$/'},
      \ 't': {'pattern': '\t'},
      \ '\': {'pattern': '\\$', 'stick_to_left': 0, 'ignore_unmatched': 0},
      \ '<': {'pattern': '<<$', 'stick_to_left': 0, 'ignore_unmatched': 0},
      \ '+': {'pattern': ' +$', 'stick_to_left': 0, 'filter': 'v/^+$/', 'ignore_unmatched': 0},
      \ }

nmap <Space>xcc <Plug>(EasyAlign)ip
nmap <Space>xc  <Plug>(EasyAlign)
vmap <Space>xc  <Plug>(EasyAlign)
