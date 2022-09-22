return function(use)

  use { 'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require("nvim-tree").setup({
        git = { ignore = false }
      })
      vim.cmd([[
        noremap  <Space>ft  :NvimTreeToggle<CR>
        noremap  <Space>fT  :NvimTreeFindFile<CR>
      ]])
    end
  }
end
