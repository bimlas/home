" Similar to FZF, but it's for NeoVim exactly

" TODO: Itt seems that `Telescope oldfiles` disables Treesitter folding

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

autocmd vimrc VimEnter * call s:SetupTelescope()

function! s:SetupTelescope()
lua << END
  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case"
        }
      }
    };
  require('telescope').load_extension('fzf')
END
endfunction
