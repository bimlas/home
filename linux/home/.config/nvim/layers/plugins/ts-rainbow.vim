" Rainbow parentheses using Treesitter

Plug 'p00f/nvim-ts-rainbow'

autocmd vimrc VimEnter * call s:SetupTsRainbow()

function! s:SetupTsRainbow()
lua << END
  require'nvim-treesitter.configs'.setup {
    rainbow = {
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags
    }
  }
END
endfunction
