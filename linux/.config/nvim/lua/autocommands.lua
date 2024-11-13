-- Save your most used SQL queries to a file which opens when you open your editor in PGCli by CTRL-X CTRL-E
-- Copy the saved queries by <CR> to the query editor

local saved_queries_file = '/media/bimlas/data/magpie/queries.sql'

vim.api.nvim_create_augroup('regular', {})
vim.api.nvim_create_autocmd({'WinResized'}, {
  group = 'regular',
  command = 'wincmd ='
})

vim.api.nvim_create_augroup('pgcli_editor', {})
vim.api.nvim_create_autocmd({'VimEnter'}, {
  group = 'pgcli_editor',
  pattern = {'/tmp/*.sql'},
  callback = function()
    vim.cmd('vsplit ' .. saved_queries_file .. ' | set filetype=sql | wincmd w')
    local buffer = tonumber(vim.cmd('echo bufnr("' .. saved_queries_file .. '")'))
    vim.opt.foldmethod = 'marker'
    vim.keymap.set({'n'}, '<cr>', function ()
      vim.cmd('normal yap')
      vim.cmd('1 wincmd w')
      vim.cmd('normal p')
    end, {desc = 'Copy query to editor', buffer = buffer})
  end,
})
vim.api.nvim_create_autocmd({'QuitPre', 'WinClosed'}, {
  group = 'pgcli_editor',
  pattern = {'/tmp/*.sql'},
  callback = function()
    vim.cmd('bdelete ' .. saved_queries_file)
  end,
})


vim.api.nvim_create_augroup('zsh_zle_editor', {})
vim.api.nvim_create_autocmd({'VimEnter'}, {
  group = 'zsh_zle_editor',
  pattern = {'/tmp/zsh*'},
  callback = function()
    vim.cmd('set filetype=bash')
  end,
})
