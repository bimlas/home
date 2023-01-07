return function(use)
  use({
    'justinmk/vim-sneak',
    config = function()
      vim.g['sneak#label'] = 1
      vim.api.nvim_set_keymap('', 'f',
        "<Plug>Sneak_f"
        , {})
      vim.api.nvim_set_keymap('', 'F',
        "<Plug>Sneak_F"
        , {})
      vim.api.nvim_set_keymap('', 't',
        "<Plug>Sneak_t"
        , {})
      vim.api.nvim_set_keymap('', 'T',
        "<Plug>Sneak_T"
        , {})
      vim.api.nvim_set_keymap('', 's',
        "<Plug>Sneak_s"
        , {})
      vim.api.nvim_set_keymap('', 'S',
        "<Plug>Sneak_S"
        , {})
    end
  })
end
