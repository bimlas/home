return function(use)
  -- use { 'rrethy/nvim-base16', config = function()
  --   -- vim.cmd('colorscheme base16-gruvbox-dark-pale')
  -- end }
  use { 'folke/tokyonight.nvim', config = function()
    vim.cmd('colorscheme tokyonight-storm')
  end}
  -- use { 'rebelot/kanagawa.nvim', config = function()
  --   -- vim.cmd('colorscheme kanagawa')
  -- end }
  -- use { 'mofiqul/vscode.nvim', config = function()
  --   -- vim.o.background = 'light'
  --   -- require('vscode').load()
  -- end }
end
