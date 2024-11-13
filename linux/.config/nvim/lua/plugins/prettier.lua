-- DISABLED, becuase it drops "module 'lspconfig.util' not found" and "module 'null-ls' not found" error and null-ls is deprecated. Trying to use CoC instead.

return function(use, cond)
  use({
    'muniftanjim/prettier.nvim',
    cond = cond,
    opt = true,
    requires = {
      { 'nvimtools/none-ls.nvim', { as = 'null-ls' }},
      'nvim-lua/plenary.nvim',
    },
    after = {
      'nvim-lspconfig'
    },
    config = function()
      -- npm install -g @fsouza/prettierd
      local null_ls = require("null-ls")

      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
      local event = "BufWritePre" -- or "BufWritePost"
      local async = event == "BufWritePost"
      null_ls.setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<space>=", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- format on save
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
              buffer = bufnr,
              group = group,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = async })
              end,
              desc = "[lsp] format on save",
            })
          end

          if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<space>=", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
          end
        end,
      })

      require("prettier").setup {
        bin = 'prettierd', -- or `prettierd`
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
