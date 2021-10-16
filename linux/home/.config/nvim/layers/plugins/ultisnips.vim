" template engine (see on GitHub: it's awesome!)
" NOTE: it has a filetype autocommand which fails if the plugin is not
" activated, so the trigger is `on_ft`.
if has('python3')
  Plug 'sirver/ultisnips'

  let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
  let g:UltiSnipsListSnippets        = '<C-G>'
endif
