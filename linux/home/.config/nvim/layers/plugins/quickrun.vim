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
      \  'python':
      \  {
      \    'commnand': 'python3'
      \  },
      \  'rubyCustom':
      \  {
      \    'command': 'irb'
      \  },
      \}

noremap         <Space>mr  :QuickRun<CR>
noremap  <expr> <Space>mR  ':QuickRun ' . &filetype . 'Custom<CR>'

autocmd vimrc FileType quickrun if has('win32') | set fileformat=dos | endif
