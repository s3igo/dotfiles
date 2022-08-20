local wezterm = require 'wezterm';

local scheme = wezterm.color.get_builtin_schemes()['NightOwl (Gogh)']
local brightYellow = scheme.brights[4]

scheme.compose_cursor = brightYellow
scheme.cursor_fg = scheme.background

return {
    font = wezterm.font('UDEV Gothic NFLG'),
    font_size = 18,
    color_schemes = {
        ['NightOwl (Gogh)'] = scheme,
    },
    color_scheme = 'NightOwl (Gogh)',
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.7,
}
