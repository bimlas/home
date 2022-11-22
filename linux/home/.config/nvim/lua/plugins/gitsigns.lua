return function(use)
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        sign_priority                = 99,
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'rounded',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach                    = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', '<Space>gn', function()
            if vim.wo.diff then return '<Space>gn' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '<Space>gp', function()
            if vim.wo.diff then return '<Space>gp' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map({ 'n', 'v' }, '<Space>gW', ':Gitsigns stage_hunk<CR>')
          map({ 'n', 'v' }, '<Space>gR', ':Gitsigns reset_hunk<CR>')
          map('n', '<Space>gw', gs.stage_buffer)
          -- map('n', '<Space>gu', gs.undo_stage_hunk)
          map('n', '<Space>gr', gs.reset_buffer)
          map('n', '<Space>gD', gs.preview_hunk)
          map('n', '<Space>gB', function() gs.blame_line { full = true } end)
          -- map('n', '<Space>tb', gs.toggle_current_line_blame)
          map('n', '<Space>gd', gs.diffthis)
          map('n', '<Space>gc', ':Gitsigns diffthis @<CR>')
          -- map('n', '<Space>gD', function() gs.diffthis('~') end)
          -- map('n', '<Space>gd', gs.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  }

end
