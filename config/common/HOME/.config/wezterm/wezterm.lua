local wezterm = require('wezterm')
local act = wezterm.action

wezterm.on('update-right-status', function(window)
    local str = ''
    local table = window:active_key_table()
    if table then
        str = table .. '  '
        -- elseif window:leader_is_active() then
        --     str = 'leader' .. '  '
    end
    window:set_right_status(str)
end)

return {
    -- Appearance
    color_scheme = 'NightOwl (Gogh)',
    foreground_text_hsb = { saturation = 1.05, brightness = 1.1 },

    -- color_scheme = 'Argonaut (Gogh)',
    -- foreground_text_hsb = { saturation = 0.95, brightness = 1.1 },

    window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
    window_background_opacity = 0.7,
    inactive_pane_hsb = { saturation = 1, brightness = 1 },

    -- font
    font = wezterm.font('UDEV Gothic NFLG'),
    font_size = 16,
    line_height = 0.9,

    -- Keybind
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
            -- Split
            { key = 'v', action = act.SplitHorizontal },
            { key = 's', action = act.SplitVertical },

            -- Focus
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

            -- Resize
            { key = 'h', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Left', 3 }) },
            { key = 'j', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Down', 3 }) },
            { key = 'k', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Up', 3 }) },
            { key = 'l', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Right', 3 }) },

            -- Copy
            { key = '[', action = act.ActivateCopyMode },
            { key = 'y', mods = 'CTRL', action = act.QuickSelect },

            { key = 's', mods = 'CTRL', action = 'PopKeyTable' },
        },
    },

    -- Mousebind
    mouse_bindings = {
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'SUPER',
            action = act.OpenLinkAtMouseCursor,
        },
    },
}
