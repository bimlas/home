return function(use)
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()

      vim.keymap.set({ 'n' }, '<space><c-o>', '<cmd>Telescope jumplist<cr>', { desc = 'Jump to previous position' })
      vim.keymap.set({ 'n' }, '<space>bb', '<cmd>Telescope buffers<cr>', { desc = 'List buffers' })
      vim.keymap.set({ 'n' }, '<space>ff', '<cmd>Telescope find_files previewer=false hidden=true<cr>',
        { desc = 'Find files' })
      vim.keymap.set({ 'n' }, '<space>fr', '<cmd>Telescope oldfiles previewer=false<cr>', { desc = 'Recent files' })
      -- vim.keymap.set({ 'n' }, '<space>ft', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', { desc = 'Browse files from current buffer)' })
      -- vim.keymap.set({ 'n' }, '<space>fT', '<cmd>Telescope file_browser<cr>', { desc = 'Browse files' })
      vim.keymap.set({ 'n' }, '<space>ss', '<cmd>Telescope grep_string search= layout_strategy=vertical<cr>',
        { desc = 'Search files' })

      local telescope = require("telescope")
      -- local trouble = require("trouble.providers.telescope")
      local actions = require "telescope.actions"
      -- local fb_actions = require "telescope".extensions.file_browser.actions

      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          -- file_browser = {
          --   hijack_netrw = true,
          --
          --   previewer = false,
          --   sorting_strategy = 'ascending',
          --   layout_config = {
          --     prompt_position = 'top',
          --   },
          --
          --   hidden = { file_browser = true, folder_browser = true },
          --   -- Move directories to the top
          --   grouped = true,
          --   dir_icon = '',
          --   -- Hide ../ on the top of the list
          --   hide_parent_dir = true,
          --
          --   initial_mode = 'normal',
          --   mappings = {
          --     n = {
          --       ["l"] = actions.select_default,
          --       ["h"] = fb_actions.goto_parent_dir,
          --       ["<c-u>"] = actions.results_scrolling_up,
          --       ["<c-d>"] = actions.results_scrolling_down,
          --     }
          --   }
          -- }
        },
        defaults = {
          -- Show file path above preview window
          dynamic_preview_title = true,
          -- mappings = {
          --   i = { ["<c-t>"] = trouble.smart_open_with_trouble },
          --   n = { ["<c-t>"] = trouble.smart_open_with_trouble },
          -- },
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
      -- telescope.load_extension('file_browser')
    end,
  }
end
