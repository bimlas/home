-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print('Installing Packer...')
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  require('plugins/colorscheme')(use)
  require('plugins/lualine')(use)
  require('plugins/web-devicons')(use)
  require('plugins/mini')(use)
  -- require('plugins/sneak')(use)
  require('plugins/fzf')(use)
  require('plugins/telescope')(use)
  require('plugins/trouble')(use)
  -- require('plugins/nvim-tree')(use)
  require('plugins/nnn')(use)
  require('plugins/comment')(use)
  require('plugins/treesitter')(use)
  require('plugins/lsp')(use)
  require('plugins/prettier')(use)
  require('plugins/fugitive')(use)
  require('plugins/gitsigns')(use)
  -- require('plugins/delaytrain')(use)

  -- Automatically set up your configuration after cloning packer.nvim
  use { 'wbthomason/packer.nvim' }
  if packer_bootstrap then
    print('Updating plugins...')
    require('packer').sync()
  end
end)
