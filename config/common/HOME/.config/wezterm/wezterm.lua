local wezterm = require('wezterm')
local act = wezterm.action
local utf8 = require('utf8')

local glyph = {
    -- arrow
    solid_right_arrow = utf8.char(0xe0b0),
    right_arrow = utf8.char(0xe0b1),
    solid_left_arrow = utf8.char(0xe0b2),
    left_arrow = utf8.char(0xe0b3),
    -- slant
    solid_right_shoulder = utf8.char(0xe0b8),
    right_shoulder = utf8.char(0xe0b9),
    solid_left_shoulder = utf8.char(0xe0ba),
    left_shoulder = utf8.char(0xe0bb),
}

local function modify_alpha(color, a)
    local h, s, l = wezterm.color.parse(color):hsla()
    return wezterm.color.from_hsla(h, s, l, a)
end

local scheme = wezterm.get_builtin_color_schemes()['NightOwl (Gogh)']
local font = wezterm.font('UDEV Gothic NFLG')

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

local tab_bg = '#011627'
local leader_bg = '#1d3b53'

wezterm.on('update-right-status', function(window)
    local mode = window:active_key_table() or ''
    local _, user = wezterm.run_child_process({ 'whoami' })
    local name = user:gsub('\n', '') .. '@' .. wezterm.hostname()

    window:set_right_status(wezterm.format({
        -- mode
        { Foreground = { Color = leader_bg } },
        { Text = glyph.solid_left_arrow },
        { Foreground = { Color = 'white' } },
        { Background = { Color = leader_bg } },
        { Text = ' ' .. string.upper(mode) .. ' ' },
        -- name
        { Foreground = { Color = tab_bg } },
        { Text = glyph.solid_left_arrow },
        { Foreground = { Color = 'white' } },
        { Background = { Color = tab_bg } },
        { Text = ' ' .. name .. ' ' },
    }))
end)

wezterm.on('format-tab-title', function(tab, _, _, _, _, max_width)
    local function tab_title(tab_info)
        local title = tab_info.tab_title
        return title and #title > 0 and title or tab_info.active_pane.title
    end

    local is_active = tab.is_active

    local bg = is_active and scheme.ansi[5] or leader_bg
    local fg = is_active and scheme.background or 'white'

    local index = wezterm.pad_left(tab.tab_index + 1, 2) .. '. '
    local title = index .. tab_title(tab)

    local extra_chars = 4 -- 2 for the shoulder, 2 for the padding

    local available_width = max_width - extra_chars
    if #title < available_width then
        local width = math.floor((available_width - #title) / 2)
        local pad = string.rep(' ', width)
        title = pad .. title .. pad
    end

    local content = wezterm.truncate_right(title, available_width)

    return {
        { Foreground = { Color = bg } },
        { Background = { Color = transparent_bg } },
        { Text = glyph.solid_left_shoulder },
        { Foreground = { Color = fg } },
        { Background = { Color = bg } },
        { Attribute = { Intensity = is_active and 'Bold' or 'Normal' } },
        { Attribute = { Italic = is_active } },
        { Text = ' ' .. content .. ' ' },
        { Foreground = { Color = bg } },
        { Background = { Color = transparent_bg } },
        { Text = glyph.solid_right_shoulder },
    }
end)

return {
    term = 'wezterm',
    scrollback_lines = 10000,
    macos_forward_to_ime_modifier_mask = 'SHIFT | CTRL',
    send_composed_key_when_right_alt_is_pressed = false,

    -- Appearance
    colors = colors,
    foreground_text_hsb = { saturation = 1.05, brightness = 1.1 },

    -- color_scheme = 'Argonaut (Gogh)',
    -- foreground_text_hsb = { saturation = 0.95, brightness = 1.1 },

    inactive_pane_hsb = { saturation = 0.6, brightness = 0.3 },

    window_decorations = 'TITLE | RESIZE',
    window_background_opacity = 0.7,

    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    tab_max_width = 24,

    -- Font
    font = font,
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
            { key = 's', mods = 'CTRL', action = 'PopKeyTable' },

            -- Rename tab
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
