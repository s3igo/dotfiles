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
    { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab({ confirm = true }) },
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },

    -- font size
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = '0', mods = 'SUPER', action = act.ResetFontAndWindowSize },
}

local leader = {
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
    { key = 'c', mods = 'CTRL', action = act.SpawnTab('CurrentPaneDomain') },

    -- workspace
    { key = 'n', mods = 'CTRL', action = act.SwitchWorkspaceRelative(1) },

    -- split
    { key = 'v', action = act.SplitHorizontal },
    { key = 's', action = act.SplitVertical },

    -- focus
    {
        key = 'h',
        mods = 'CTRL',
        action = act.Multiple({ { ActivatePaneDirection = 'Left' }, 'PopKeyTable' }),
    },
    {
        key = 'j',
        mods = 'CTRL',
        action = act.Multiple({ { ActivatePaneDirection = 'Down' }, 'PopKeyTable' }),
    },
    {
        key = 'k',
        mods = 'CTRL',
        action = act.Multiple({ { ActivatePaneDirection = 'Up' }, 'PopKeyTable' }),
    },
    {
        key = 'l',
        mods = 'CTRL',
        action = act.Multiple({ { ActivatePaneDirection = 'Right' }, 'PopKeyTable' }),
    },

    { key = '.', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = ',', mods = 'CTRL', action = act.ActivateTabRelative(-1) },

    -- resize
    { key = 'h', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Left', 3 }) },
    { key = 'j', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Down', 3 }) },
    { key = 'k', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Up', 3 }) },
    { key = 'l', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Right', 3 }) },

    -- mode
    { key = 'v', mods = 'CTRL', action = act.ActivateCopyMode },
    { key = 'y', mods = 'CTRL', action = act.QuickSelect },

    -- link
    { key = 'o', mods = 'CTRL', action = act.OpenLinkAtMouseCursor },
}

local copy_mode = {
    { key = 'q', action = act.CopyMode('Close') },

    -- start / end selection
    { key = 'v', action = act.CopyMode({ SetSelectionMode = 'Cell' }) },
    {
        key = 'v',
        mods = 'SHIFT',
        action = act.CopyMode({ SetSelectionMode = 'Line' }),
    },
    {
        key = 'v',
        mods = 'CTRL',
        action = act.CopyMode({ SetSelectionMode = 'Block' }),
    },

    {
        key = '[',
        mods = 'CTRL',
        action = act.CopyMode('ClearSelectionMode'),
    },
    {
        key = 'y',
        action = act.Multiple({
            { CopyTo = 'Clipboard' },
            { CopyMode = 'ClearSelectionMode' },
        }),
    },
    { key = 'Enter', action = act.Multiple({ { CopyTo = 'Clipboard' }, { CopyMode = 'Close' } }) },

    -- move selection
    { key = 'o', action = act.CopyMode('MoveToSelectionOtherEnd') },
    {
        key = 'o',
        mods = 'SHIFT',
        action = act.CopyMode('MoveToSelectionOtherEndHoriz'),
    },

    -- move cursor
    { key = 'w', action = act.CopyMode('MoveForwardWord') },
    { key = 'e', action = act.CopyMode('MoveForwardWordEnd') },
    { key = 'b', action = act.CopyMode('MoveBackwardWord') },

    { key = 'h', action = act.CopyMode('MoveLeft') },
    { key = 'j', action = act.CopyMode('MoveDown') },
    { key = 'k', action = act.CopyMode('MoveUp') },
    { key = 'l', action = act.CopyMode('MoveRight') },

    { key = '0', action = act.CopyMode('MoveToStartOfLine') },
    {
        key = 'h',
        mods = 'CTRL',
        action = act.CopyMode('MoveToStartOfLineContent'),
    },
    {
        key = 'j',
        mods = 'CTRL',
        action = act.CopyMode('MoveToScrollbackBottom'),
    },
    {
        key = 'k',
        mods = 'CTRL',
        action = act.CopyMode('MoveToScrollbackTop'),
    },
    {
        key = 'l',
        mods = 'CTRL',
        action = act.CopyMode('MoveToEndOfLineContent'),
    },

    {
        key = 'h',
        mods = 'SHIFT',
        action = act.CopyMode('MoveToViewportTop'),
    },
    {
        key = 'l',
        mods = 'SHIFT',
        action = act.CopyMode('MoveToViewportBottom'),
    },
    {
        key = 'm',
        mods = 'SHIFT',
        action = act.CopyMode('MoveToViewportMiddle'),
    },

    -- scroll
    { key = 'f', mods = 'CTRL', action = act.CopyMode('PageDown') },
    { key = 'b', mods = 'CTRL', action = act.CopyMode('PageUp') },

    {
        key = 'd',
        mods = 'CTRL',
        action = act.CopyMode({ MoveByPage = 0.5 }),
    },
    {
        key = 'u',
        mods = 'CTRL',
        action = act.CopyMode({ MoveByPage = -0.5 }),
    },

    -- jump
    { key = 'f', action = act.CopyMode({ JumpForward = { prev_char = false } }) },
    {
        key = 'f',
        mods = 'SHIFT',
        action = act.CopyMode({ JumpBackward = { prev_char = false } }),
    },
    { key = 't', action = act.CopyMode({ JumpForward = { prev_char = true } }) },
    {
        key = 't',
        mods = 'SHIFT',
        action = act.CopyMode({ JumpBackward = { prev_char = true } }),
    },

    { key = ',', action = act.CopyMode('JumpReverse') },
    { key = ';', action = act.CopyMode('JumpAgain') },
}

M.key_tables = { leader = leader, copy_mode = copy_mode }

M.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        action = act.OpenLinkAtMouseCursor,
    },
}

return wezterm.gui and M or {}
