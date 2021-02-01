" COHAMA/LEXIMA.VIM
" auto insert `end` (for VimL, Ruby, etc.) and pairing chars ({, [, <, etc)
Plug 'cohama/lexima.vim'

autocmd vimrc VimEnter * call PostLexima()
function! PostLexima()
  for key in ['Describe', 'Before', 'It']
    call lexima#add_rule({
          \ 'filetype': 'vimspec',
          \ 'at': '^\s*'.key.'\>.*\%#',
          \ 'char': '<CR>',
          \ 'input': '<CR>',
          \ 'input_after': '<CR>End',
          \ })
  endfor
endfunction

" Do not insert closing paired characters ('>', '}', '"').
let g:lexima_enable_basic_rules = 0

" Smacks up the popup menu (sometimes it selects the first element when I
" hiting space).
let g:lexima_enable_space_rules = 0
