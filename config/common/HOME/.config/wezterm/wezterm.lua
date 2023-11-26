local wezterm = require('wezterm')
local act = wezterm.action

wezterm.on('update-right-status', function(window)
    local _, user = wezterm.run_child_process({ 'whoami' })
    local name = user:gsub('\n', '') .. '@' .. wezterm.hostname()

    local mode = window:active_key_table() or ''

    window:set_right_status(wezterm.format({
        { Background = { Color = 'blue' } },
        { Text = mode },
        'ResetAttributes',
        { Text = '  ' .. name },
    }))
end)

local font_name = 'UDEV Gothic NFLG'
local scheme_name = 'NightOwl (Gogh)'
local scheme = wezterm.get_builtin_color_schemes()[scheme_name]

-- Set transparent tab bar by `text_background_opacity`, the fg and bg colors of the powerline glyph do not match.
local transparent_bg = (function(theme)
    local r, g, b = wezterm.color.parse(theme.background):srgba_u8()
    return 'rgba(' .. r .. ', ' .. g .. ', ' .. b .. ', 0.7)'
end)(scheme)

local glyph = {
    solid_right_arrow = utf8.char(0xe0b0),
    right_arrow = utf8.char(0xe0b1),
    solid_left_arrow = utf8.char(0xe0b2),
    left_arrow = utf8.char(0xe0b3),
}

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

return {
    term = 'wezterm',
    scrollback_lines = 10000,

    -- Appearance
    color_scheme = scheme_name,
    foreground_text_hsb = { saturation = 1.05, brightness = 1.1 },

    -- color_scheme = 'Argonaut (Gogh)',
    -- foreground_text_hsb = { saturation = 0.95, brightness = 1.1 },

    inactive_pane_hsb = { saturation = 0.6, brightness = 0.3 },

    window_decorations = 'TITLE | RESIZE',
    window_background_opacity = 0.7,
    window_frame = {
        font = wezterm.font({ family = font_name, weight = 'Bold' }),
        -- font_size = 14,
        -- window_hide = false,
    },

    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,

    -- colors = { tab_bar = { background = transparent_bg } },
    -- or
    text_background_opacity = 0.7,
    colors = { tab_bar = { background = scheme.background } },

    -- overwrite defaults
    -- colors = {
    --     tab_bar = (function(bg, fg, background)
    --         local elem = {
    --             bg_color = bg,
    --             fg_color = fg,
    --         }
    --         return {
    --             background = background,
    --             active_tab = elem,
    --             inactive_tab = elem,
    --             inactive_tab_hover = elem,
    --         }
    --     end)(scheme.background, scheme.foreground, transparent_bg),
    -- },

    -- font
    font = wezterm.font(font_name),
    font_size = 16,
    line_height = 0.9,

    window_padding = { top = 0, bottom = 0 },

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
