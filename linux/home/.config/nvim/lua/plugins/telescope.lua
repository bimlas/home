return function(use)
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
          }
        },
      };
      require('telescope').load_extension('fzf')

      vim.cmd([[
        nnoremap <F1>      :Telescope commands<CR>
        nnoremap <Space>?  :Telescope keymaps<CR>
        nnoremap <Space>bb :Telescope buffers<CR>
        nnoremap <Space>ff :Telescope find_files previewer=false hidden=true<CR>
        nnoremap <Space>fr :Telescope oldfiles previewer=false<CR>
        nnoremap <Space><C-O> :Telescope jumplist<CR>
        nnoremap <Space>ss :Telescope grep_string search= layout_strategy=vertical<CR>
      ]])

      local telescope = require("telescope")
      local trouble = require("trouble.providers.telescope")

      telescope.setup {
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
          }
        }
      }
    end,
  }
end
