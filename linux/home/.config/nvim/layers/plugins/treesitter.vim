" Parser to get better and faster syntax-highlighting and foldmethod

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldtext=substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend))
" set foldlevelstart=1
set foldminlines=1

autocmd vimrc VimEnter * call EnableTreeSitter()

function! EnableTreeSitter()
  lua <<EOF
  require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
}
EOF
endfunction
