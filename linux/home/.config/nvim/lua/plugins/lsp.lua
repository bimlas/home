return function(use)
  use { 'neovim/nvim-lspconfig',
    requires = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      -- 'ray-x/lsp_signature.nvim',
      'hrsh7th/cmp-path',
      'l3mon4d3/luasnip',
      -- Highlight cursorword
      'rrethy/vim-illuminate',
      'b0o/schemastore.nvim',
    },
    config = function()

      local lspconfig = require('lspconfig')
      local luasnip = require('luasnip')
      require("luasnip.loaders.from_snipmate").lazy_load()
      require('illuminate').configure({ providers = { 'lsp', 'treesitter' } })
      -- require("lsp_signature").setup({ max_height = 1, hint_enable = false })

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      local servers = {
        'dockerls', -- npm install -g dockerfile-language-server-nodejs
        'tsserver', -- npm install -g typescript typescript-language-server
        'yamlls', -- npm install -g yaml-language-server
        -- TODO: Addditional settings for Kubernetes, Docker Compose, GitHub Actions, etc: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
        'jsonls', -- npm install -g vscode-langservers-extracted
        'eslint', -- npm install -g vscode-langservers-extracted
        -- TODO: Set up Prettier
        'vimls', -- npm install -g vim-language-server
        'sumneko_lua'
      }
      settings = {
        yamlls = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = { "/.k8s/*.yaml",
                "/tmp/kubectl-edit-*.yaml" },
            }
          }
        },
        jsonls = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
        sumneko_lua = {
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
        }
      }

      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      -- vim.keymap.set('n', '<space>e', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', "<cmd>TroubleToggle lsp_implementations<cr>", { silent = true, noremap = true })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, bufopts)
        -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>.', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<space>=', vim.lsp.buf.formatting, bufopts)

        if client.name == "tsserver" then
          client.server_capabilities.document_formatting = false -- 0.7 and earlier
          client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
        end
      end

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = settings[lsp],
        }
      end

      -- nvim-cmp setup
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
        },
      }

    end
  }
end
