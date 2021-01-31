" MACHAKANN/VIM-SANDWICH
" paros jelek gyors cserelese/torlese
if !exists('g:vimrc_minimal_plugins')
  Plug 'machakann/vim-sandwich'
endif

let g:sandwich_no_default_key_mappings          = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings  = 1
