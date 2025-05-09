-- DISABLED, becuase I have issues with Prettier and I have to restart several times when working on a huge TypeScript file. Trying to use CoC instead.

return function(use, cond)
  use {
    'neovim/nvim-lspconfig',
    cond = cond,
    after = {
      'nvim-cmp'
    },
    requires = {
      -- TODO:
      -- 'williamboman/mason.nvim',
      -- 'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',
    },
    config = function()
      -- require('mason').setup()
      -- require('mason-lspconfig').setup {
      --   ensure_installed = servers,
      -- }

      local servers = {
        'docker_compose_language_service', -- npm install -g @microsoft/compose-language-service
        'dockerls',                        -- npm install -g dockerfile-language-server-nodejs
        'eslint',                          -- npm install -g vscode-langservers-extracted
        'jsonls',                          -- npm install -g vscode-langservers-extracted
        'lua_ls',                          -- https://github.com/luals/lua-language-server
        'pylsp',                           -- pip install python-lsp-server
        'pyright',                         -- pip install pyright
        'solidity_ls',                     -- npm install -g vscode-solidity-server
        'vimls',                           -- npm install -g vim-language-server
        'vtsls',                           -- npm install -g @vtsls/language-server
        'yamlls',                          -- npm install -g yaml-language-server
        -- 'ts_ls',                           -- npm install -g typescript typescript-language-server
      }

      local settings = {
        yamlls = {
          yaml = {
            -- TODO: Docker Compose schema, or use https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#docker_compose_language_service and set ft=yaml.docker-compose
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = {
                "/.k8s/*.yaml",
                "/tmp/kubectl-edit-*.yaml" },
            }

            -- TODO: Works with GitHub Actions out of the box, does not works on Kubernetes files
            -- schemaStore = {
            --   enable = false,
            --   url = "",
            -- },
            -- schemas = require('schemastore').yaml.schemas({
            --   extra = {
            --     description = 'Kubernetes schema',
            --     fileMatch = { "**/.k8s/*.yaml", "/tmp/kubectl-edit-*.yaml" },
            --     name = 'Kubernetes schema',
            --     url =
            --     'https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json',
            --   }
            -- }),
          }
        },
        jsonls = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
        lua_ls = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }

      local on_attach = function(client, bufnr)
        vim.diagnostic.config({ virtual_text = false, jump = { float = true } })

        if client.name == "tsserver" then
          client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
        end

        if client.name == 'eslint' then
          vim.api.nvim_create_augroup('lsp_format_on_save', {
            clear = false
          })
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
        end

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gO",
          "<cmd>Telescope lsp_document_symbols layout_strategy=vertical<CR>", bufopts)
        vim.keymap.set("n", "grr", "<cmd>Telescope lsp_references layout_strategy=vertical<CR>", bufopts)
        vim.keymap.set("n", "gri", "<cmd>Telescope lsp_implementations layout_strategy=vertical<CR>", bufopts)

        -- Highlight cursor word
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false
          })
          vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
          })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local lspconfig = require('lspconfig')
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = settings[lsp],
        }
      end

      vim.api.nvim_create_augroup('docker_compose_language_service_filetype', {})
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        group = 'regular',
        pattern = 'docker-compose.*yml',
        command = ':set filetype=yaml.docker-compose'
      })
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    -- Needed to do not try to use requirements when `cond = false` (using Nvim as Tmux)
    disable = not cond,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      -- Snippet management
      -- 'hrsh7th/cmp-vsnip',
      -- 'hrsh7th/vim-vsnip',
      -- 'hrsh7th/vim-vsnip-integ',
      -- 'rafamadriz/friendly-snippets',
      -- LSP status in bottom-right corner of the window
    },
    config = function()
      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require 'cmp'
      cmp.setup {
        formatting = {
          fields = {
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu,
            cmp.ItemField.Kind,
          },
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-u>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              })
              -- elseif vim.fn["vsnip#available"](1) == 1 then
              --   feedkey("<Plug>(vsnip-expand-or-jump)", "")
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { 'i', 's' }),
          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
              -- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              --   feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
        }),
        sources = {
          -- { name = 'vsnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
        },
      }
    end
  }

  use {
    'stevearc/conform.nvim',
    cond = cond,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          ['*'] = { 'prettierd' } -- npm install -g prettierd
        },
        -- formatters = {
        --   prettierd = {
        --     append_args = {'--plugin=prettier-plugin-sql'}
        --   }
        -- },
        format_on_save = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          -- TODO: Does not formats by Prettier if this is specified
          -- lsp_format = "fallback",
        }
      })
    end
  }

  -- use {
  --   'j-hui/fidget.nvim',
  --   cond = cond,
  --   tag = 'v1.4.5',
  --   config = function()
  --     require('fidget').setup({})
  --   end
  -- }
end
