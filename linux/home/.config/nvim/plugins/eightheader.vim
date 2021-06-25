" (fold)header-ek letrehozasa, egyeni foldtext, tartalomjegyzek formazasa...
Plug 'https://gitlab.com/bimlas/vim-eightheader'

let g:EightHeader_comment   = 'call tcomment#Comment(line("."), line("."), "CL")'
let g:EightHeader_uncomment = 'call tcomment#Comment(line("."), line("."), "UL")'

let &foldtext = "EightHeaderFolds(&tw, 'left', [ repeat('  ', v:foldlevel - 1), repeat(' ', v:foldlevel - 1) . '.', '' ], '', '')"

nnoremap <Space>x1  :silent call EightHeader(&tw, 'center', 0, '=', ' {' . '{{1', '')<CR><CR>
nnoremap <Space>x2  :silent call EightHeader(&tw, 'center', 0, '_', ' {' . '{{2', '')<CR><CR>
nnoremap <Space>x3  :silent call EightHeader(&tw, 'center', 0, '.', ' {' . '{{3', '')<CR><CR>
nnoremap <Space>x4  :silent call EightHeader(0 - (&tw / 2), 'left', 1, ['__', '_', ''], '', '\= " " . s:str . " "')<CR><CR>
nnoremap <Space>x8  :silent call EightHeader(78, 'left', 1, ' ', '{'.'{{' , '')<CR><CR>
nnoremap <Space>x9  :silent call EightHeader(78, 'left', 1, ' ', '}'.'}}' , '')<CR><CR>

autocmd vimrc FileType vim noremap <buffer> <Space>m8
\ :call EightHeader(78, 'left', 1, ' ', '{'.'{{2' , '')<CR><CR>

autocmd vimrc FileType help nnoremap <buffer> <Space>m1
\ :call EightHeader(78, 'left', 1, ' ', '\= "*".matchstr(s:str, ";\\@<=.*")."*"', '\= matchstr(s:str, ".*;\\@=")')<CR><CR>

autocmd vimrc FileType help noremap <buffer> <Space>m2
\ :call EightHeader(78, 'left', 1, '.', '\= "\|".matchstr(s:str, ";\\@<=.*")."\|"', '\= matchstr(s:str, ".*;\\@=")')<CR><CR>
