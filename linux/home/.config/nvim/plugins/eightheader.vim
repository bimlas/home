" (fold)header-ek letrehozasa, egyeni foldtext, tartalomjegyzek formazasa...
Plug 'https://gitlab.com/bimlas/vim-eightheader'

let g:EightHeader_comment   = 'call tcomment#Comment(line("."), line("."), "CL")'
let g:EightHeader_uncomment = 'call tcomment#Comment(line("."), line("."), "UL")'

let &foldtext = "EightHeaderFolds(&tw, 'left', [ repeat('  ', v:foldlevel - 1), repeat(' ', v:foldlevel - 1) . '.', '' ], '', '')"
