local gps = require("nvim-gps")
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end } },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', { gps.get_location, cond = gps.is_available }},
    lualine_x = {{'fileformat', symbols = { 
	    unix = 'unix', 
        dos = 'dos', 
        mac = 'mac',}, 'filetype'}, 'encoding'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'hostname'},
    lualine_b = {{'buffers', mode = 3}},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  },
  extensions = {}
}