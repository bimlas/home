return function(use)
  use({
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require('hop').setup({})
      vim.api.nvim_set_keymap('', 'f',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
        , {})
      vim.api.nvim_set_keymap('', 'F',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
        , {})
      vim.api.nvim_set_keymap('', 't',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
        , {})
      vim.api.nvim_set_keymap('', 'T',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
        , {})
      vim.api.nvim_set_keymap('', 's',
        "<cmd>lua require'hop'.hint_char2({})<cr>"
        , {})
    end
  })
end
