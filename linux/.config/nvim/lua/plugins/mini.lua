return function(use, cond)
  use { 'echasnovski/mini.nvim', branch = 'stable',
    cond = cond,
    config = function()
      local spec_argument = require('mini.ai').gen_spec.argument
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup({
        search_method = 'cover',
        custom_textobjects = {
          [','] = spec_argument(),
          -- TODO: Not works on comment blocks, just lines
          -- c = spec_treesitter({ a = '@comment.outer', i = '@comment.inner' }),
          ['e'] = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'), col = vim.fn.getline('$'):len()
            }
            return { from = from, to = to }
          end

        }
      })

      require('mini.surround').setup(
        {
          mappings = {
            add = '<Space>qa',       -- Add surrounding in Normal and Visual modes
            delete = '<Space>qd',    -- Delete surrounding
            find = '',               -- Find surrounding (to the right)
            find_left = '',          -- Find surrounding (to the left)
            highlight = '<Space>qh', -- Highlight surrounding
            replace = '<Space>qr',   -- Replace surrounding
            update_n_lines = '',     -- Update `n_lines`
            suffix_last = '',        -- Suffix to search with "prev" method
            suffix_next = '',        -- Suffix to search with "next" method
          },
        })

      -- Has no fuzzy search
      -- require('mini.completion').setup(
      -- )

      -- Available in vanilla NeoVim
      -- require('mini.comment').setup({})
    end }
end
