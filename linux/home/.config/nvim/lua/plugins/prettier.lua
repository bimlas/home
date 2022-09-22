return function(use)
  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'muniftanjim/prettier.nvim'
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
          end
        end,
      })

      local prettier = require("prettier")

      prettier.setup({
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
        },
      })

    end
  })
end
