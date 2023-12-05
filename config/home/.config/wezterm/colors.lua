local wezterm = require('wezterm')

-- local function modify_alpha(color, a)
--     local h, s, l = wezterm.color.parse(color):hsla()
--     return wezterm.color.from_hsla(h, s, l, a)
-- end

local M = {}

M.default = wezterm.get_builtin_color_schemes()['NightOwl (Gogh)']

-- override default colors
M.scheme = M.default
M.scheme.cursor_fg = 'black'
M.scheme.tab_bar = {
    background = M.scheme.background,
    inactive_tab_hover = {
        bg_color = M.scheme.background,
        fg_color = M.scheme.foreground,
    },
}

return M
