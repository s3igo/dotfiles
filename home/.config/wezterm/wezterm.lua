local wezterm = require 'wezterm';

local scheme = wezterm.color.get_builtin_schemes()['NightOwl (Gogh)']
local brightYellow = scheme.brights[4]

-- change `NightOwl` default colors
scheme.compose_cursor = brightYellow
scheme.cursor_fg = scheme.background

return {
    -- appearance
    color_schemes = { ['NightOwl (Gogh)'] = scheme, },
    color_scheme = 'NightOwl (Gogh)',
    window_background_opacity = 0.7,

    -- config
    hide_tab_bar_if_only_one_tab = true,

    -- font
    font = wezterm.font('UDEV Gothic NFLG'),
    font_size = 18,
    cell_width = 1.05,

    -- keybind
    disable_default_key_bindings = true,
    keys = {
        { key = 'c', mods = 'CMD', action = wezterm.action.Copy },
        { key = 'v', mods = 'CMD', action = wezterm.action.Paste },
        { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentTab { confirm = false }, },
        { key = 'q', mods = 'CMD', action = wezterm.action.QuitApplication },
    },
}
