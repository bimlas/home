" paros jelek gyors cserelese/torlese
Plug 'machakann/vim-sandwich'

let g:sandwich_no_default_key_mappings          = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings  = 1

nmap <Space>qa  <Plug>(operator-sandwich-add)
vmap <Space>qa  <Plug>(operator-sandwich-add)
nmap <Space>qs  <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <Space>qd  <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
