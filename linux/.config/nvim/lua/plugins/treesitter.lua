return function(use)
  use { 'nvim-treesitter/nvim-treesitter',
    requires =
    {
      { 'nvim-treesitter/nvim-treesitter-context',
        config = {
          mode = 'topline',
          max_lines = -1,
          patterns = {
            default = {
              'class',
              'function',
              'method',
              'for',
              'while',
              'if',
              'switch',
              'case',
              'try',
            },
          }
        }
      },
      { 'mfussenegger/nvim-treehopper',
        config = function()
          vim.cmd('omap     <silent> v :<C-U>lua require("tsht").nodes()<CR>')
          vim.cmd('xnoremap <silent> v :lua require("tsht").nodes()<CR>')
        end
      },
      { 'p00f/nvim-ts-rainbow' }
    },
    config = function()

      require('nvim-treesitter.configs').setup({
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        -- Sometimes it's buggy, shows errors, making editor unable to use
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gb",
            node_incremental = "gb",
          },
        },
        rainbow = {
          enable = true,
          extended_mode = true,
        }
      })
    end
  }
end
