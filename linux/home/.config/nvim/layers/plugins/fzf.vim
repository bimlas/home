" the fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" nnoremap <F1>      :Commands<CR>
" nnoremap <Space>?  :Maps<CR>
" nnoremap <Space>bb :Buffers<CR>
" nnoremap <Space>ff :Files<CR>
" nnoremap <Space>fr :History<CR>
nnoremap <Space>mt :Tags<CR>
nnoremap <Space>ss :Rg<CR>
nnoremap <Space>sl :Lines<CR>
