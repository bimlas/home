return function(use, cond)
  use { 'nvim-treesitter/nvim-treesitter',
    cond = cond,
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        ignore_install = {},
        sync_install = false,
        -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        -- Sometimes it's buggy, shows errors, making editor unable to use
        ensure_installed = {
          'bash',
          'comment',
          'css',
          'diff',
          'dockerfile',
          'git_config',
          'git_rebase',
          'gitattributes',
          'gitcommit',
          'html',
          'javascript',
          'json',
          'lua',
          'regex',
          'solidity',
          'sql',
          'typescript',
          'vim',
          'yaml',
        }, 
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }

  -- Drops error in newer Nvim versions
  -- use {
  --   -- For Mini.ai text objects
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  --   cond = cond,
  --   after = { 'nvim-treesitter' }
  -- }

  use { 'nvim-treesitter/nvim-treesitter-context',
    cond = cond,
    after = { 'nvim-treesitter' },
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
  }
end
