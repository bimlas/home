return function(use, cond)
  -- use { 'rrethy/nvim-base16', cond = cond, config = function()
  --   vim.cmd('colorscheme base16-gruvbox-dark-pale')
  -- end }
  use { 'folke/tokyonight.nvim', cond = cond, config = function()
    require("tokyonight").setup({
      on_highlights = function(highlights, colors)
        highlights.LineNr = {
          fg = colors.fg_sidebar,
          bg = colors.bg_sidebar
        }
        highlights.SignColumn = {
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
  end }
  -- use { "EdenEast/nightfox.nvim", cond = cond, config = function()
  --   vim.cmd("colorscheme nightfox")
  -- end }
  -- use { 'craftzdog/solarized-osaka.nvim', cond = cond, config = function()
  --   require('solarized-osaka').setup({
  --     transparent = false,
  --   })
  --   vim.cmd("colorscheme solarized-osaka")
  -- end }
  -- use { 'rebelot/kanagawa.nvim', cond = cond, config = function()
  --   vim.cmd('colorscheme kanagawa')
  -- end }
  -- use { 'mofiqul/vscode.nvim', cond = cond, config = function()
  --   -- vim.o.background = 'light'
  --   require('vscode').load()
  -- end }
end
