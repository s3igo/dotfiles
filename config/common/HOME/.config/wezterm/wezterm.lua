local wezterm = require('wezterm')
local act = wezterm.action
local colors = require('colors')

local font = wezterm.font('UDEV Gothic NFLG')

require('events')

return {
    term = 'wezterm',
    scrollback_lines = 10000,
    macos_forward_to_ime_modifier_mask = 'SHIFT | CTRL',
    send_composed_key_when_right_alt_is_pressed = false,

    -- appearance
    colors = colors.scheme,
    foreground_text_hsb = { saturation = 1.05, brightness = 1.1 },

    -- color_scheme = 'Argonaut (Gogh)',
    -- foreground_text_hsb = { saturation = 0.95, brightness = 1.1 },

    inactive_pane_hsb = { saturation = 0.6, brightness = 0.3 },

    window_decorations = 'TITLE | RESIZE',
    window_background_opacity = 0.7,

    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    tab_max_width = 24,

    -- font
    font = font,
    font_size = 16,
    line_height = 0.9,

    -- keybind
    -- disable_default_key_bindings = true,
    -- NOTE: To use the key repeat by `one_shot = false`, the built-in leader key is not used.
    keys = {
        {
            key = 's',
            mods = 'CTRL',
            action = act.ActivateKeyTable({
                name = 'leader',
                one_shot = false,
                timeout_milliseconds = 800,
            }),
        },
    },
    key_tables = {
        leader = {
            { key = 's', mods = 'CTRL', action = 'PopKeyTable' },

            -- rename tab
            {
                key = 'r',
                action = act.PromptInputLine({
                    description = 'Enter new name for tab',
                    action = wezterm.action_callback(function(window, _, line)
                        if line then
                            window:active_tab():set_title(line)
                        end
                    end),
                }),
            },

            -- split
            { key = 'v', action = act.SplitHorizontal },
            { key = 's', action = act.SplitVertical },

            -- focus
            {
                key = 'h',
                mods = 'CTRL',
                action = act.Multiple({ act.ActivatePaneDirection('Left'), 'PopKeyTable' }),
            },
            {
                key = 'j',
                mods = 'CTRL',
                action = act.Multiple({ act.ActivatePaneDirection('Down'), 'PopKeyTable' }),
            },
            {
                key = 'k',
                mods = 'CTRL',
                action = act.Multiple({ act.ActivatePaneDirection('Up'), 'PopKeyTable' }),
            },
            {
                key = 'l',
                mods = 'CTRL',
                action = act.Multiple({ act.ActivatePaneDirection('Right'), 'PopKeyTable' }),
            },

            { key = 'n', mods = 'CTRL', action = act.ActivateTabRelative(1) },
            { key = 'p', mods = 'CTRL', action = act.ActivateTabRelative(-1) },

            -- resize
            { key = 'h', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Left', 3 }) },
            { key = 'j', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Down', 3 }) },
            { key = 'k', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Up', 3 }) },
            { key = 'l', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Right', 3 }) },

            -- copy
            { key = '[', action = act.ActivateCopyMode },
            { key = 'y', mods = 'CTRL', action = act.QuickSelect },
        },
    },

    -- mousebind
    mouse_bindings = {
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'SUPER',
            action = act.OpenLinkAtMouseCursor,
        },
    },
}
