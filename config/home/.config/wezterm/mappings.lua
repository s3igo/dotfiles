local wezterm = require('wezterm')
local act = wezterm.action

local M = {}

M.keys = {
    -- NOTE: To use the key repeat by `one_shot = false`, the built-in leader key is not used.
    {
        key = 's',
        mods = 'CTRL',
        action = act.ActivateKeyTable({
            name = 'leader',
            one_shot = false,
            timeout_milliseconds = 800,
        }),
    },

    -- copy / paste
    { key = 'c', mods = 'SUPER', action = act.CopyTo('Clipboard') },
    { key = 'c', mods = 'CTRL | SHIFT', action = act.CopyTo('Clipboard') },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom('Clipboard') },
    { key = 'v', mods = 'CTRL | SHIFT', action = act.PasteFrom('Clipboard') },

    -- window
    { key = 'h', mods = 'SUPER', action = act.HideApplication },
    { key = 'm', mods = 'SUPER', action = act.Hide },
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab({ confirm = true }) },
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },
}

M.key_tables = {
    leader = {
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

        -- spawn
        { key = 'n', mods = 'CTRL', action = act.SpawnWindow },
        { key = 't', mods = 'CTRL', action = act.SpawnTab('CurrentPaneDomain') },

        -- split
        { key = 'v', --[[ mods = 'CTRL', ]] action = act.SplitHorizontal },
        { key = 's', --[[ mods = 'CTRL', ]] action = act.SplitVertical },

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

        { key = '.', mods = 'CTRL', action = act.ActivateTabRelative(1) },
        { key = ',', mods = 'CTRL', action = act.ActivateTabRelative(-1) },

        -- resize
        { key = 'h', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Left', 3 }) },
        { key = 'j', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Down', 3 }) },
        { key = 'k', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Up', 3 }) },
        { key = 'l', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Right', 3 }) },

        -- mode
        { key = 'c', mods = 'CTRL', action = act.ActivateCopyMode },
        { key = 'y', mods = 'CTRL', action = act.QuickSelect },
    },
}

M.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        -- mods = 'SUPER',
        action = act.OpenLinkAtMouseCursor,
    },
}

return M
