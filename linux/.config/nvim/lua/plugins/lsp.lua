-- DISABLED, becuase I have issues with Prettier and I have to restart several times when working on a huge TypeScript file. Trying to use CoC instead.

return function(use, cond)
  use { 'neovim/nvim-lspconfig',
    cond = cond,
    requires = {
      -- 'williamboman/mason.nvim',
      -- 'williamboman/mason-lspconfig.nvim',
      -- TODO: Replacebale by builtin completion? https://www.reddit.com/r/neovim/comments/1d7j0c1/a_small_gist_to_use_the_new_builtin_completion/
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      -- Snippet management
      -- 'hrsh7th/cmp-vsnip',
      -- 'hrsh7th/vim-vsnip',
      -- 'hrsh7th/vim-vsnip-integ',
      -- 'rafamadriz/friendly-snippets',
      -- LSP status in bottom-right corner of the window
      { 'j-hui/fidget.nvim', tag = 'v1.4.5' },
      -- Schemas for GitHub Actions, Kubernetes YAML files, etc.
      'b0o/schemastore.nvim',
    },
    config = function()
      local servers = {
        'dockerls',    -- npm install -g dockerfile-language-server-nodejs
        'ts_ls',       -- npm install -g typescript typescript-language-server
        'pylsp',       -- pip install python-lsp-server
        'pyright',     -- pip install pyright
        'yamlls',      -- npm install -g yaml-language-server
        -- TODO: Addditional settings for Kubernetes, Docker Compose, GitHub Actions, etc: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
        'jsonls',      -- npm install -g vscode-langservers-extracted
        'eslint',      -- npm install -g vscode-langservers-extracted
        -- TODO: Set up Prettier
        'vimls',       -- npm install -g vim-language-server
        'lua_ls',      -- https://github.com/luals/lua-language-server
        'solidity_ls', -- npm install -g vscode-solidity-server
      }

      local settings = {
        yamlls = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = {
                "/.k8s/*.yaml",
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
        }
      }

      -- require('mason').setup()
      -- require('mason-lspconfig').setup {
      --   ensure_installed = servers,
      -- }

      require('fidget').setup({})

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local function on_list(options)
        vim.fn.setqflist({}, ' ', options)
        vim.api.nvim_command('tabnew | copen | cfirst')
      end

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        vim.diagnostic.config({ virtual_text = false })

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gro",
          "<cmd>Telescope lsp_document_symbols layout_strategy=vertical<CR>", bufopts)
        vim.keymap.set("n", "grr", "<cmd>Telescope lsp_references layout_strategy=vertical<CR>", bufopts)
        vim.keymap.set("n", "gri", "<cmd>Telescope lsp_implementations layout_strategy=vertical<CR>", bufopts)
        -- Open references in new tab to be able to preview without messing up windows
        -- vim.keymap.set('n', 'gr', function () vim.lsp.buf.references(nil, {on_list=on_list}) end, { desc = 'LSP: List references of symbol under the cursor', silent = true })
        -- vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations layout_strategy=vertical<cr>", { silent = true, noremap = true })

        if client.name == "tsserver" then
          client.server_capabilities.document_formatting = false        -- 0.7 and earlier
          client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
        end

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

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      -- nvim-cmp setup
      -- local lspkind = require('lspkind')
      local cmp = require 'cmp'
      cmp.setup {
        formatting = {
          fields = {
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu,
            cmp.ItemField.Kind,
          },
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered()
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-u>'] = cmp.mapping.scroll_docs(4),
          -- ['<CR>'] = cmp.mapping.confirm {
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   select = true,
          -- },
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
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
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
end
