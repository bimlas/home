return function(use)
  use({
    'muniftanjim/prettier.nvim',
    requires = {
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require("null-ls").setup {
        timeout_ms = 5000,
        on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
          end
        end,
      }

      require("prettier").setup {
        bin = 'prettier', -- or `prettierd`
        filetypes = {
          "css",
          "graphql",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "less",
          "markdown",
          "scss",
          "typescript",
          "typescriptreact",
          "yaml",
          "sql", -- https://github.com/un-ts/prettier/tree/master/packages/sql#install
        },
      }
    end
  })
end
