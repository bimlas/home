return function(use, cond)
  use {
    "neoclide/coc.nvim",
    cond = cond,
    branch = 'master',
    run = { 'npm ci', ':CocInstall coc-json coc-tsserver coc-prettier coc-sql coc-eslint coc-rust-analyzer @nomicfoundation/coc-solidity' },
    config = function()
      local keyset = vim.keymap.set
      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      -- NOTE: There's always a completion item selected by default, you may want to enable
      -- no select by setting `"suggest.noselect": true` in your configuration file
      -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
      -- other plugins before putting this into your config
      local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
        opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- Make <CR> to accept selected completion item or notify coc.nvim to format
      -- <C-g>u breaks current undo, please make your own choice
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      -- -- Use <c-j> to trigger snippets
      -- keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
      -- Use <c-space> to trigger completion
      keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

      keyset("i", "<c-s>", "CocActionAsync('showSignatureHelp')", { silent = true, expr = true })

      -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
      keyset("n", "<c-w>d", "<Plug>(coc-diagnostic-info)", { silent = true })
      keyset("n", "<c-w><c-d>", "<Plug>(coc-diagnostic-info)", { silent = true })
      keyset("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true })
      keyset("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true })

      -- GoTo code navigation
      keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
      keyset("n", "gry", "<Plug>(coc-type-definition)", { silent = true })
      -- keyset("n", "gri", "<Plug>(coc-implementation)", { silent = true })
      -- keyset("n", "grr", "<Plug>(coc-references)", { silent = true })
      -- Needs https://github.com/fannheyward/telescope-coc.nvim
      keyset("n", "gri", "<cmd>Telescope coc implementations<cr>", { silent = true })
      keyset("n", "grr", "<cmd>Telescope coc references<cr>", { silent = true })
      keyset("n", "gro", "<cmd>Telescope coc document_symbols symbols=method,function layout_strategy=vertical<CR>",
        { silent = true })

      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

      -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })


      -- Symbol renaming
      keyset("n", "<space>R", "<Plug>(coc-rename)", { silent = true })


      -- Formatting selected code
      keyset("x", "<space>=", "<Plug>(coc-format-selected)", { silent = true })
      keyset("n", "<space>=", "<Plug>(coc-format-selected)", { silent = true })

      -- Setup formatexpr specified filetype(s)
      vim.api.nvim_create_autocmd("FileType", {
        group = "CocGroup",
        pattern = "typescript,json",
        command = "setl formatexpr=CocAction('formatSelected')",
        desc = "Setup formatexpr specified filetype(s)."
      })

      -- Update signature help on jump placeholder
      vim.api.nvim_create_autocmd("User", {
        group = "CocGroup",
        pattern = "CocJumpPlaceholder",
        command = "call CocActionAsync('showSignatureHelp')",
        desc = "Update signature help on jump placeholder"
      })

      -- Apply codeAction to the selected region
      -- Example: `<leader>aap` for current paragraph
      local opts = { silent = true, nowait = true }
      -- keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
      -- keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

      -- Remap keys for apply code actions at the cursor position.
      keyset("n", "gra", "<Plug>(coc-codeaction-cursor)", opts)
      -- -- Remap keys for apply source code actions for current file.
      -- keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
      -- -- Apply the most preferred quickfix action on the current line.
      -- keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

      -- -- Remap keys for apply refactor code actions.
      -- keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
      -- keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
      -- keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

      -- Run the Code Lens actions on the current line
      keyset("n", "<space>A", "<Plug>(coc-codelens-action)", opts)

      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

      -- " Add `:Fold` command to fold current buffer
      vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

      -- Mappings for CoCList
      -- code actions and coc stuff
      ---@diagnostic disable-next-line: redefined-local
      local opts = { silent = true, nowait = true }
      -- Show all diagnostics
      keyset("n", "<space>e", ":<C-u>CocList diagnostics<cr>", opts)
      -- -- Manage extensions
      -- keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
      -- -- Show commands
      -- keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
      -- Find symbol of current document
      keyset("n", "<space>mo", ":<C-u>CocList outline<cr>", opts)
      -- Search workspace symbols
      keyset("n", "<space>ms", ":<C-u>CocList -I symbols<cr>", opts)
      -- -- Do default action for next item
      -- keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
      -- -- Do default action for previous item
      -- keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
      -- -- Resume latest coc list
      -- keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
    end
  }
end
