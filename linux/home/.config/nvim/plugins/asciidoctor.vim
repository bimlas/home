" HABAMAX/VIM-ASCIIDOCTOR                                             "
" szovegreszek kommentelese
if !exists('g:vimrc_minimal_plugins')
  Plug 'habamax/vim-asciidoctor'

  let g:asciidoctor_syntax_conceal = 1
  let g:asciidoctor_folding = 1
  let g:asciidoctor_fold_options = 1
  let g:asciidoctor_fenced_languages = ['javascript', 'php','python']
endif
" }}}2
