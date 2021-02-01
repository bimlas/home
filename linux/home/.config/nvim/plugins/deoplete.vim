" SHOUGO/DEOPLETE.NVIM
" automatic code completion
" $ pip3 install neovim
if has('nvim') && has('python3')
  Plug 'shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'}

  let g:deoplete#enable_at_startup = 1

  autocmd vimrc VimEnter * call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])
  autocmd vimrc VimEnter * call deoplete#custom#source('ultisnips', 'rank', 1000)
  autocmd vimrc VimEnter * call deoplete#custom#option('enable_smart_case', 1)
  autocmd vimrc VimEnter * call deoplete#custom#option('sources',
        \ {'_': ["omni", "tag", "file/include", "syntax", "vim", "ultisnips", "buffer"]} )
endif
