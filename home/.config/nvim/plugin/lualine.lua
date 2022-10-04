local status, lualine = pcall(require, 'lualine')
if (not status) then return end

lualine.setup {
    options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_z = {
        'encoding',
        {
            'fileformat',
            fmt = function(str)
                local formats = {
                    unix = 'LF',
                    dos = 'CRLF',
                    mac = 'CR'
                }
                return formats[str]
            end
        },
        'filetype'
    },
    lualine_y = {
        {
            'bo:expandtab',
            fmt = function(str)
                if str == 'true' then
                    return 'spaces:'
                else
                    return 'tab size:'
                end
            end
        },
        'bo:tabstop',
    },
    lualine_x = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
