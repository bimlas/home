return function(use)
  use { 'phaazon/hop.nvim', branch = 'v2', config = function()
    local hop = require('hop')
    local hint = require('hop.hint').HintDirection
    hop.setup()
    vim.keymap.set({ 'n', 'v', 'o' }, 's', hop.hint_patterns)
    vim.keymap.set({ 'n', 'v', 'o' }, 'f',
      function() hop.hint_char1({ direction = hint.AFTER_CURSOR, current_line_only = true }) end)
    vim.keymap.set({ 'n', 'v', 'o' }, 'F',
      function() hop.hint_char1({ direction = hint.BEFORE_CURSOR, current_line_only = true }) end)
    vim.keymap.set({ 'n', 'v', 'o' }, 't',
      function() hop.hint_char1({ direction = hint.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end)
    vim.keymap.set({ 'n', 'v', 'o' }, 'T',
      function() hop.hint_char1({ direction = hint.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end)
    vim.keymap.set({ 'n', 'v', 'o' }, '<space>k',
      function() hop.hint_lines({ direction = hint.BEFORE_CURSOR }) end)
    vim.keymap.set({ 'n', 'v', 'o' }, '<space>j',
      function() hop.hint_lines({ direction = hint.AFTER_CURSOR }) end)
  end }
end
