" git integration
" $ install git
Plug 'tpope/vim-fugitive'

nnoremap <Space>ga :Git commit --amend<CR>
nnoremap <Space>gc :Git commit<CR>
nnoremap <Space>gs :Git<CR>
nnoremap <Space>gd :Git diff<CR>
nnoremap <Space>gb :Git blame<CR>
nnoremap <Space>gg :silent Git grep --ignore-case '' -- ':/'<S-Left><S-Left><S-Left><Right>
nnoremap <Space>gG :silent Git grep --ignore-case -C3 '' -- ':/'<S-Left><S-Left><S-Left><Right>
nnoremap <Space>gl :Git la<CR>
nnoremap <Space>gL :Git log -- %<CR>
nmap     <Space>gw :Git add %<CR><C-L>

autocmd vimrc FileType fugitive setlocal nofoldenable

" Toggle hunks in git status
autocmd vimrc FileType fugitive nmap <buffer> l >
autocmd vimrc FileType fugitive nmap <buffer> h <

autocmd vimrc FileType fugitive nmap <buffer> <C-L> <Space>gs
