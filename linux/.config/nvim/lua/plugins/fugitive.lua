return function(use, cond)
  use({
    'tpope/vim-fugitive',
    cond = cond,
    requires = {
      -- To be able to open files on remote by `:GBrowse`
      'tpope/vim-rhubarb'
    }
  })
end
