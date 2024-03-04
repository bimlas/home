return function(use, cond)
  use {
    "mcchrish/nnn.vim",
    cond = cond,
    config = function ()
      vim.g['nnn#command'] = 'nnn -dAHoe'
      vim.g['nnn#replace_netrw'] = 1
      vim.keymap.set({ 'n' }, '<space>ft', '<cmd>NnnPicker %:p:h<cr>', { desc = 'Browse files from current buffer)' })
    end
  }
end
