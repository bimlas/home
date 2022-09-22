vim.api.nvim_create_augroup("vimrc", { clear = true })

-- Nvim has no direct connection to the system clipboard ("+" register) without this
vim.opt.clipboard = vim.opt.clipboard + { 'unnamed' }

-- TEXTAREA

vim.opt.scrolloff = 3
vim.opt.virtualedit = 'onemore'
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = '↳'
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.listchars = { tab = '▶‒', nbsp = '∙', trail = '∙', extends = '▶', precedes = '◀' }
vim.opt.foldmethod = 'marker'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrapscan = false

-- INFOLINE

vim.opt.cmdheight = 2

-- Notify me about everything
vim.opt.report = 0

-- Completion in the command line:
-- - <Tab> expands string to the longest common part
-- - Second <Tab> shows all match
-- - Starting from the third will iterate on the list
vim.opt.wildmode = {'longest:full', 'full'}

-- DIFF

-- autocmd vimrc FileType diff setlocal nofoldenable

-- TUI

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- MAPS

vim.keymap.set('n', '<Space><Tab>', function () vim.cmd('b#') end)
