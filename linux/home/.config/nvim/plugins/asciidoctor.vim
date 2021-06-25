" szovegreszek kommentelese
Plug 'habamax/vim-asciidoctor'

let g:asciidoctor_syntax_conceal = 1
let g:asciidoctor_folding = 1
let g:asciidoctor_fold_options = 1
let g:asciidoctor_fenced_languages = ['javascript', 'php','python']

autocmd vimrc BufEnter *.adoc set filetype=asciidoctor
autocmd vimrc FileType asciidoc,asciidoctor vnoremap <Space>mq :AdocFormat<CR>$hD
