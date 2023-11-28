local wezterm = require('wezterm')
local act = wezterm.action

-- NOTE: To use the key repeat by `one_shot = false`, the built-in leader key is not used.

local keys = {
    {
        key = 's',
        mods = 'CTRL',
        action = act.ActivateKeyTable({
            name = 'leader',
            one_shot = false,
            timeout_milliseconds = 800,
        }),
    },
}

local key_tables = {
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
}

local mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'SUPER',
        action = act.OpenLinkAtMouseCursor,
    },
}

return {
    keys = keys,
    key_tables = key_tables,
    mouse_bindings = mouse_bindings,
}
