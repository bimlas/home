return function(use)
  -- use { 'rrethy/nvim-base16', config = function()
  --   -- vim.cmd('colorscheme base16-gruvbox-dark-pale')
  -- end }
  use { 'folke/tokyonight.nvim', config = function()
    require("tokyonight").setup({
      on_highlights = function(highlights, colors)
        highlights.LineNr = {
          fg = colors.fg_sidebar,
          bg = colors.bg_sidebar
        }
        highlights.CursorLineNr = {
          fg = colors.teal,
          bg = colors.bg_sidebar
        }
      end
    })
    vim.cmd('colorscheme tokyonight-moon')
  end}
  -- use { 'rebelot/kanagawa.nvim', config = function()
  --   -- vim.cmd('colorscheme kanagawa')
  -- end }
  -- use { 'mofiqul/vscode.nvim', config = function()
  --   -- vim.o.background = 'light'
  --   -- require('vscode').load()
  -- end }
end
