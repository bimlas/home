return function(use, cond)
  -- LSP servers mostly working by Mason LSP config, but formatters need other solutions, like Conform
  use {
    "williamboman/mason.nvim",
    cond = cond,
    config = function()
      local ensure_installed = {
        'prettier',
        -- 'vtsls',
        -- 'sql-formatter',
        'eslint_d',
        -- 'lua-language-server',
      }
      require("mason").setup()
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end
  }

  -- Works if the name of the server is the same in Mason and LSPConfig list
  -- Not sure how to specify Schemastore for Yaml
  use {
    "williamboman/mason-lspconfig.nvim",
    requires = {
      "neovim/nvim-lspconfig",
    },
    after = "mason.nvim",
    cond = cond,
    config = function()
      require("mason-lspconfig").setup({
        -- See https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
        ensure_installed = {
          'eslint',
          'vtsls',
          'lua_ls',
          'yamlls'
        }
      })
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end
      }
    end
  }

  -- WARNING: Cannot run Eslint -> Prettier, it fails to run Prettier mostly, cannot set up to run Eslint (LSP) first then Prettier
  use {
    "stevearc/conform.nvim",
    cond = cond,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          ['*'] = { 'prettier' }
        },
        default_format_opts = {
          lsp_format = "first",
          timeout_ms = 3000,
          async = false,
        },
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = 'Format on save',
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end
  }
end
