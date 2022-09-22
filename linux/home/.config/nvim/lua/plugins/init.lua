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
  require('plugins/hop')(use)
  require('plugins/fzf')(use)
  require('plugins/telescope')(use)
  require('plugins/trouble')(use)
  require('plugins/nvim-tree')(use)
  require('plugins/comment')(use)
  require('plugins/treesitter')(use)
  require('plugins/lsp')(use)
  require('plugins/prettier')(use)
  require('plugins/gitsigns')(use)

  use {
  'rmagatti/goto-preview',
  config = function()
    require('goto-preview').setup {}

    vim.cmd([[
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
]])
  end
}

  use { 'echasnovski/mini.nvim', branch = 'stable', config = function()
    -- kana/textobj-user
    require('mini.ai').setup({})

    require('mini.surround').setup(
      {
        mappings = {
          add = '<Space>qa', -- Add surrounding in Normal and Visual modes
          delete = '<Space>qd', -- Delete surrounding
          find = '', -- Find surrounding (to the right)
          find_left = '', -- Find surrounding (to the left)
          highlight = '<Space>qh', -- Highlight surrounding
          replace = '<Space>qr', -- Replace surrounding
          update_n_lines = '', -- Update `n_lines`
          suffix_last = '', -- Suffix to search with "prev" method
          suffix_next = '', -- Suffix to search with "next" method
        },
      })

      require('mini.comment').setup({})

      -- require('mini.bufremove').setup({})
      -- TODO: Force delete?
      -- vim.cmd([[
      --   nmap <Space>bd :lua MiniBufremove.delete()<CR>
      -- ]])
  end }

  -- Automatically set up your configuration after cloning packer.nvim
  use { 'wbthomason/packer.nvim' }
  if packer_bootstrap then
    print('Updating plugins...')
    require('packer').sync()
  end
end)
