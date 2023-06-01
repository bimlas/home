return function(use)
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()

      vim.keymap.set({ 'n', 'v', 'o' }, '<F1>', '<cmd>Telescope keymaps<cr>', { desc = 'List keymaps' })
      vim.keymap.set({ 'n' }, '<space><c-o>', '<cmd>Telescope jumplist<cr>', { desc = 'Jump to previous position' })
      vim.keymap.set({ 'n' }, '<space>bb', '<cmd>Telescope buffers<cr>', { desc = 'List buffers' })
      vim.keymap.set({ 'n' }, '<space>ff', '<cmd>Telescope find_files previewer=false hidden=true<cr>',
        { desc = 'Find files' })
      vim.keymap.set({ 'n' }, '<space>fr', '<cmd>Telescope oldfiles previewer=false<cr>', { desc = 'Recent files' })
      vim.keymap.set({ 'n' }, '<space>ss', '<cmd>Telescope grep_string search= layout_strategy=vertical<cr>',
        { desc = 'Search files' })

      local telescope = require("telescope")
      local trouble = require("trouble.providers.telescope")

      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
          },
        },
        defaults = {
          mappings = {
            i = { ["<c-t>"] = trouble.smart_open_with_trouble },
            n = { ["<c-t>"] = trouble.smart_open_with_trouble },
          },
        },
        pickers = {
          buffers = {
            mappings = {
              i = { ["<c-x>"] = 'delete_buffer' },
              n = { ["<c-x>"] = 'delete_buffer' },
            }
          },
          lsp_references = {
            include_current_line = true,
          },
          colorscheme = {
            enable_preview = true
          },
        }
      }
      telescope.load_extension('fzf')
    end,
  }
end
