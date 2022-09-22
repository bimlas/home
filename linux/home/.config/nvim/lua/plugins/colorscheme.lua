return function(use)
  use { 'rrethy/nvim-base16', config = function()
    vim.cmd('colorscheme base16-gruvbox-dark-pale')
  end }
end
