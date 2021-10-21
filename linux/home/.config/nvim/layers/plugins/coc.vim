" automatic code completion with language server protocol (lsp)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
      \   'coc-explorer',
      \   'coc-pairs',
      \   'coc-tsserver',
      \   'coc-eslint',
      \   'coc-prettier',
      \ ]
" For configuration, see ~/.config/nvim/coc-settings.json

set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}

augroup plugin_coc
  autocmd!

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command MyRenameSymbol call CocAction('refactor')
command MyJumpToSymbolDeifinition call CocAction('jumpDefinition')
command MyJumpToSymbolReferences call CocAction('jumpReferences')
command MyOutlineDocument call CocAction('showOutline')

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Space>ft <Cmd>CocCommand explorer --position=floating --floating-position=right-center --floating-width=50<CR>
nmap <silent> gR <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
