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
  local not_as_tmux = function() return NVIM_AS_TMUX ~= true end

  require('plugins/colorscheme')(use, "true")
  require('plugins/lualine')(use, not_as_tmux)
  require('plugins/mini')(use, not_as_tmux)
  require('plugins/unimpaired')(use, not_as_tmux)
  require('plugins/abolish')(use, not_as_tmux)
  require('plugins/telescope')(use, not_as_tmux)
  require('plugins/nnn')(use, not_as_tmux)
  require('plugins/treesitter')(use, not_as_tmux)
  require('plugins/coc')(use, not_as_tmux)
  -- require('plugins/lsp')(use, not_as_tmux)
  -- require('plugins/prettier')(use, not_as_tmux)
  require('plugins/fugitive')(use, not_as_tmux)
  require('plugins/gitsigns')(use, not_as_tmux)

  -- Automatically set up your configuration after cloning packer.nvim
  use { 'wbthomason/packer.nvim' }
  if packer_bootstrap then
    print('Updating plugins...')
    require('packer').sync()
  end
end)
