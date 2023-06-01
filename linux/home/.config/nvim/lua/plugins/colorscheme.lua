return function(use)
  use { 'rrethy/nvim-base16', config = function()
    -- vim.cmd('colorscheme base16-gruvbox-dark-pale')
  end }
  use { 'folke/tokyonight.nvim', config = function()
    -- vim.cmd('colorscheme tokyonight-night')
  end}
  use { 'rebelot/kanagawa.nvim', config = function()
    vim.cmd('colorscheme kanagawa')
  end }
  use { 'luisiacc/gruvbox-baby', config = function()
    vim.g.gruvbox_baby_background_color = 'medium'
    -- vim.cmd('colorscheme gruvbox-baby')
  end }
end
