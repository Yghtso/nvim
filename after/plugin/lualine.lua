require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = "catppuccin",
        section_separators = { '', '' },
        component_separators = { '', '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
