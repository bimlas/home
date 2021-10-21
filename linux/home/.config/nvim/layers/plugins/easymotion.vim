" vim motion (in buffer) on speed

" WARNING: Jumping to line (<Space>j) causing false ESLint warnings, overrides
" colors in Coc-Explorer

Plug 'easymotion/vim-easymotion'

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'ASDFGHJKLUIOPQWER'

" Show target as UPPERCASE, allow jump with lowercase.
let g:EasyMotion_use_upper = 1

" Allow jump to foldlines too.
let g:EasyMotion_skipfoldedline = 0

" Stay in the same column when using <Plug>(easymotion-sol-j)
let g:EasyMotion_startofline = 0

map s         <Plug>(easymotion-s2)
map t         <Plug>(easymotion-tl)
map T         <Plug>(easymotion-Tl)
map t         <Plug>(easymotion-tl)
map T         <Plug>(easymotion-Tl)
map f         <Plug>(easymotion-fl)
map F         <Plug>(easymotion-Fl)
map <Leader>n <Plug>(easymotion-n)
map <Leader>N <Plug>(easymotion-N)
map é         <Plug>(easymotion-next)
map É         <Plug>(easymotion-prev)

map <Space>j <Plug>(easymotion-sol-j)
map <Space>k <Plug>(easymotion-sol-k)
" Stay in the same column.
map <Space>J <Plug>(easymotion-j)
map <Space>K <Plug>(easymotion-k)

autocmd vimrc VimEnter * EMCommandLineNoreMap <C-J> <CR>
