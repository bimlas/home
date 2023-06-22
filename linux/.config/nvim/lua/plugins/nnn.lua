return function(use)
  use { 'mcchrish/nnn.vim', config = function()
    require('nnn').setup({
      command = 'nnn -Hoe',
      set_default_mappings = 0,
      replace_netrw = 1,
      -- Do not map, cannot write new filename with `l`
      -- action = {
      --   ["l"] = "edit",
      -- },
    })
    vim.cmd([[
        let g:nnn#session = 'local'
        nnoremap <silent> <space>ft :NnnPicker %:p:h<CR>
      ]])
  end
  }
end
