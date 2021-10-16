" show git status of lines on the sign column
" $ install git
Plug 'airblade/vim-gitgutter'

let g:gitgutter_map_keys = 0

" Update only on file open/write
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

nnoremap <Space>gn :GitGutterNextHunk<CR>
nnoremap <Space>gp :GitGutterPrevHunk<CR>
nmap     <Space>gD <Plug>(GitGutterPreviewHunk)
nmap     <Space>gR <Plug>(GitGutterUndoHunk)
nmap     <Space>gW <Plug>(GitGutterStageHunk)

nnoremap <C-L> :nohlsearch <Bar> checktime <Bar> diffupdate <Bar> syntax sync fromstart <Bar> GitGutterAll<CR><C-L>
