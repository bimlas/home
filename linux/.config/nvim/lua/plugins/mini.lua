return function(use)
  use { 'echasnovski/mini.nvim', branch = 'stable',
    -- requires =
    -- {
    --   -- For Mini.ai text objects
    --   'nvim-treesitter/nvim-treesitter-textobjects'
    -- },
    config = function()

      -- -- kana/textobj-user
      -- -- Caused error on an update
      -- local spec_argument = require('mini.ai').gen_spec.argument
      -- local spec_treesitter = require('mini.ai').gen_spec.treesitter
      -- require('mini.ai').setup({
      --   search_method = 'cover',
      --   custom_textobjects = {
      --     [','] = spec_argument(),
      --     -- TODO: Not works on comment blocks, just lines
      --     -- c = spec_treesitter({ a = '@comment.outer', i = '@comment.inner' }),
      --     e = function()
      --       local from = { line = 1, col = 1 }
      --       local to = {
      --         line = vim.fn.line('$'), col = vim.fn.getline('$'):len()
      --       }
      --       return { from = from, to = to }
      --     end
      --
      --   }
      -- })

      -- require('mini.surround').setup(
      --   {
      --     mappings = {
      --       add = '<Space>qa', -- Add surrounding in Normal and Visual modes
      --       delete = '<Space>qd', -- Delete surrounding
      --       find = '', -- Find surrounding (to the right)
      --       find_left = '', -- Find surrounding (to the left)
      --       highlight = '<Space>qh', -- Highlight surrounding
      --       replace = '<Space>qr', -- Replace surrounding
      --       update_n_lines = '', -- Update `n_lines`
      --       suffix_last = '', -- Suffix to search with "prev" method
      --       suffix_next = '', -- Suffix to search with "next" method
      --     },
      --   })

      require('mini.comment').setup({})

      -- justinmk/vim-sneak
      -- NOTE: Interesting, but cannot achieve f/t, use Hop instead
      -- require('mini.jump2d').setup({
      --   labels = 'jkloifdsawehgur',
      --   allowed_windows = {
      --     not_current = false
      --   },
      -- })
      -- vim.keymap.set({'n', 'v', 'o'}, 's', '<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.query)<CR>', {})
      -- vim.keymap.set({'n', 'v', 'o'}, '<space>j', '<Cmd>lua MiniJump2d.start({ spotter = MiniJump2d.builtin_opts.line_start.spotter, allowed_lines = { cursor_at = false, cursor_before = false } })<CR>', {})
      -- vim.keymap.set({'n', 'v', 'o'}, '<space>k', '<Cmd>lua MiniJump2d.start({ spotter = MiniJump2d.builtin_opts.line_start.spotter, allowed_lines = { cursor_at = false, cursor_after = false } })<CR>', {})

      -- require('mini.bufremove').setup({})
      -- -- TODO: Force delete?
      -- vim.cmd([[
      --   command! Bd lua MiniBufremove.delete()
      -- ]])

      -- hrsh7th/nvim-cmp,
      -- Would be good, but a bit slow and adds nearly nothing to nvim-cmp
      -- require('mini.completion').setup({})
    end }
end
