return function(use)
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
      }

      vim.api.nvim_create_autocmd({"QuickFixCmdPost"}, { callback = function() vim.cmd('Trouble quickfix') end })
    end
  })
end
