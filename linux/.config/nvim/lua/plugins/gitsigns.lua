return function(use, cond)
  use { 'lewis6991/gitsigns.nvim',
  cond = cond,
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
        end, { expr = true, desc = 'Git: Next hunk' })

        map('n', '<Space>gp', function()
          if vim.wo.diff then return '<Space>gp' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'Git: Previous hunk' })

        -- Actions
        map('n', '<Space>gD', gs.preview_hunk ,{ desc = 'Git: Preview hunk' })
        map({ 'n', 'v' }, '<Space>gW', ':Gitsigns stage_hunk<CR>', { desc = 'Git: Stage hunk' })
        map({ 'n', 'v' }, '<Space>gR', ':Gitsigns reset_hunk<CR>', { desc = 'Git: Reset hunk' })
        map('n', '<Space>gw', gs.stage_buffer, { desc = 'Git: Stage file' })
        map('n', '<Space>gr', gs.reset_buffer, { desc = 'Git: Reset file' })
        map('n', '<Space>gB', function() gs.blame_line { full = true } end, { desc = 'Git: Blame line'})
        -- map('n', '<Space>tb', gs.toggle_current_line_blame)
        map('n', '<Space>gd', gs.diffthis, { desc = 'Git: Diff file' })
        map('n', '<Space>gc', ':Gitsigns diffthis @<CR>', { desc = 'Git: Diff staged file' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }
  end
}

end
