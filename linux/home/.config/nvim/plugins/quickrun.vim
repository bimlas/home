" THINCA/VIM-QUICKRUN
" buffer, vagy kijelolt kod futtatasa
Plug 'thinca/vim-quickrun'

let g:quickrun_no_default_key_mappings = 1
" \     'hook/output_encode/encoding': 'default',
let g:quickrun_config = {
      \  '_':
      \  {
      \    'outputter':                     'buffer',
      \    'outputter/buffer/running_mark': '... RUNNING ...',
      \    'hook/cd/directory':             '%S:p:h',
      \    'hook/shebang/enable':           has('win32') ? 0 : 1,
      \  },
      \  'asciidoc':
      \  {
      \    'command':   'asciidoctor',
      \    'cmdopt':    '-o -',
      \    'outputter': 'browser'
      \  },
      \  'text':
      \  {
      \    'command':   'asciidoctor',
      \    'cmdopt':    '-o -',
      \    'outputter': 'browser'
      \  },
      \  'vimspec' :
      \  {
      \   'command' : g:pm_install_dir . '/vim-themis/bin/themis',
      \   'cmdopt'  : '--runtimepath ".."',
      \   'exec'    : '%c %o %s:p'
      \  },
      \  'rubyCustom':
      \  {
      \    'command': 'irb'
      \  },
      \}

autocmd vimrc FileType quickrun if has('win32') | set fileformat=dos | endif
