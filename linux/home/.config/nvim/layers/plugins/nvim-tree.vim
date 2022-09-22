" Directory tree sidebar
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

autocmd vimrc VimEnter * call EnableNvimTree()

function EnableNvimTree()
lua << CONFIG
  require("nvim-tree").setup()
CONFIG
endfunction

noremap  <Space>ft  :NvimTreeToggle<CR>
noremap  <Space>fT  :NvimTreeFindFile<CR>
