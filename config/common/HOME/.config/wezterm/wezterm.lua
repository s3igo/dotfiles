local wezterm = require('wezterm')
local act = wezterm.action

wezterm.on('update-right-status', function(window)
    local str = ''
    local table = window:active_key_table()
    if table then
        str = table .. '  '
    elseif window:leader_is_active() then
        str = 'leader' .. '  '
    end
    window:set_right_status(str)
end)

return {
    -- appearance
    color_scheme = 'NightOwl (Gogh)',
    -- color_scheme = 'Ayu Dark (Gogh)',
    -- color_scheme = 'Argonaut (Gogh)',

    window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
    window_background_opacity = 0.7,
    foreground_text_hsb = { brightness = 1.1 },
    inactive_pane_hsb = { saturation = 1, brightness = 1 },

    -- font
    font = wezterm.font('UDEV Gothic NFLG'),
    font_size = 16,
    line_height = 0.9,

    -- keybind
    -- disable_default_key_bindings = true,
    leader = { key = 's', mods = 'CTRL' },
    keys = {
        { key = 'v', mods = 'LEADER', action = act.SplitHorizontal },
        { key = 's', mods = 'LEADER', action = act.SplitVertical },
        { key = 'h', mods = 'LEADER|CTRL', action = act.ActivatePaneDirection('Left') },
        { key = 'j', mods = 'LEADER|CTRL', action = act.ActivatePaneDirection('Down') },
        { key = 'k', mods = 'LEADER|CTRL', action = act.ActivatePaneDirection('Up') },
        { key = 'l', mods = 'LEADER|CTRL', action = act.ActivatePaneDirection('Right') },
        { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
        { key = 'y', mods = 'LEADER|CTRL', action = act.QuickSelect },

        {
            key = 's',
            mods = 'CTRL',
            action = act.ActivateKeyTable({
                name = 'navigation',
                one_shot = false,
                timeout_milliseconds = 1000,
            }),
        },
    },
    key_tables = {
        navigation = {
            { key = 'h', action = act.AdjustPaneSize({ 'Left', 3 }) },
            { key = 'j', action = act.AdjustPaneSize({ 'Down', 3 }) },
            { key = 'k', action = act.AdjustPaneSize({ 'Up', 3 }) },
            { key = 'l', action = act.AdjustPaneSize({ 'Right', 3 }) },
            { key = 'n', action = act.ActivateTabRelative(1) },
            { key = 'p', action = act.ActivateTabRelative(-1) },
            { key = 'q', action = 'PopKeyTable' },
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
