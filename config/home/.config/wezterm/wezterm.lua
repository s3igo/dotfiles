local wezterm = require('wezterm')
local colors = require('colors')
local mappings = require('mappings')

require('events')

return {
    -- general
    term = 'wezterm',
    scrollback_lines = 10000,

    -- appearance
    colors = colors.scheme,
    text_background_opacity = 0.7,
    foreground_text_hsb = { saturation = 1.05, brightness = 1.1 },
    inactive_pane_hsb = { saturation = 0.6, brightness = 0.3 },

    -- window
    window_decorations = 'TITLE | RESIZE',
    window_background_opacity = 0.7,
    window_close_confirmation = 'AlwaysPrompt',

    -- tab
    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    tab_max_width = 24,

    -- font
    font = wezterm.font('UDEV Gothic NFLG'),
    font_size = 16,
    line_height = 0.9,

    -- input
    macos_forward_to_ime_modifier_mask = 'SHIFT | CTRL',
    send_composed_key_when_right_alt_is_pressed = false,
    disable_default_key_bindings = true,
    keys = mappings.keys,
    key_tables = mappings.key_tables,
    mouse_bindings = mappings.mouse_bindings,
}
