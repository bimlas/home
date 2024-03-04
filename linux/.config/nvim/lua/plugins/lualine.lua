return function(use, cond)
  use {
    'nvim-lualine/lualine.nvim',
    cond = cond,
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', right_padding = 2, fmt = function(str) return str:sub(1, 1) end },
          },
          lualine_b = { 'filename' },
          lualine_c = { 'branch' },
          lualine_x = { 'nvim_lsp' },
          lualine_y = { 'filetype', 'diagnostics' },
          lualine_z = {
            { 'location', left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = { 'quickfix' },
      }
    end
  }
end
