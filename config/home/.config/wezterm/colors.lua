local wezterm = require('wezterm')

local function modify_alpha(color, a)
    local h, s, l = wezterm.color.parse(color):hsla()
    return wezterm.color.from_hsla(h, s, l, a)
end

local default = wezterm.get_builtin_color_schemes()['NightOwl (Gogh)']

-- NOTE: Set transparent tab bar by `text_background_opacity`,
-- the fg and bg colors of the powerline glyph do not match.
local bg = modify_alpha(default.background, 0.7)

local scheme = default
scheme.cursor_fg = 'black'
scheme.tab_bar = {
    background = bg,
    inactive_tab_hover = {
        bg_color = default.background,
        fg_color = default.foreground,
    },
}

return {
    default = default,
    scheme = scheme,
    bg = bg,
}
