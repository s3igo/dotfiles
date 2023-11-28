local wezterm = require('wezterm')

local function modify_alpha(color, a)
    local h, s, l = wezterm.color.parse(color):hsla()
    return wezterm.color.from_hsla(h, s, l, a)
end

local scheme = wezterm.get_builtin_color_schemes()['NightOwl (Gogh)']

-- NOTE: Set transparent tab bar by `text_background_opacity`,
-- the fg and bg colors of the powerline glyph do not match.
local transparent_bg = modify_alpha(scheme.background, 0.7)

local colors = scheme
colors.cursor_fg = 'black'
colors.tab_bar = {
    background = transparent_bg,
    inactive_tab_hover = {
        bg_color = scheme.background,
        fg_color = scheme.foreground,
    },
}

return {
    default = scheme,
    scheme = colors,
    bg = transparent_bg,
}
