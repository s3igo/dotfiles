local M = {}

local wezterm = require('wezterm')
local utf8 = require('utf8')

local glyphs = {
    cpu = utf8.char(0xf4bc),
    co2 = utf8.char(0xf05e3),
}

local function get_co2(chissoku)
    local _, json = wezterm.run_child_process({
        chissoku,
        '--quiet',
        '--stdout.interval=1',
        '--stdout.iterations=1',
        '/dev/tty.usbmodem314201',
    })

    -- json is empty
    if json == nil or json == '' then
        return nil
    end

    -- wait for 1 second due to avoid the "Serial port busy" error
    wezterm.run_child_process({ 'sleep', '1' })

    return wezterm.json_parse(json).co2
end

local function split(str, pat)
    local t = {}
    for s in string.gmatch(str, pat) do
        table.insert(t, s)
    end
    return t
end

local function get_cpu_usage()
    local _, result = wezterm.run_child_process({ 'iostat', '-c', '2', 'disk0' })

    local line = split(result, '[^\r\n]+')[4]
    local value = split(line, '%S+')[6]

    return wezterm.pad_left(100 - value, 4)
end

---@param int integer
---@return string
local function add_comma(int)
    local result = ''
    local str = tostring(int)
    for i = 1, #str do
        result = result .. str:sub(i, i)
        if (#str - i) % 3 == 0 and i ~= #str then
            result = result .. ','
        end
    end
    return result
end

M.zellij = (function()
    local config = wezterm.config_builder()

    config.term = 'wezterm'
    config.scrollback_lines = 10000
    config.quick_select_patterns = {
        -- sha256 encoded with base64 (e.g. nix hash)
        'sha256-[A-Za-z0-9+/]*={0,3}',
        'sha256:[A-Za-z0-9+/]*={0,3}',
    }

    -- appearance
    config.color_scheme = 'iceberg-dark'
    config.text_background_opacity = 0.7

    -- window
    config.window_decorations = 'TITLE | RESIZE'
    config.window_background_opacity = 0.7
    config.window_close_confirmation = 'AlwaysPrompt'

    -- tab
    config.enable_tab_bar = false

    -- font
    config.font = wezterm.font('UDEV Gothic NFLG')
    config.font_size = 16

    -- input
    config.macos_forward_to_ime_modifier_mask = 'SHIFT | CTRL'
    config.send_composed_key_when_right_alt_is_pressed = false
    config.disable_default_key_bindings = true

    config.keys = {
        -- copy / paste
        { key = 'c', mods = 'SUPER', action = wezterm.action.CopyTo('Clipboard') },
        { key = 'c', mods = 'CTRL | SHIFT', action = wezterm.action.CopyTo('Clipboard') },
        { key = 'v', mods = 'SUPER', action = wezterm.action.PasteFrom('Clipboard') },
        { key = 'v', mods = 'CTRL | SHIFT', action = wezterm.action.PasteFrom('Clipboard') },
        { key = 's', mods = 'SUPER', action = wezterm.action.QuickSelect },

        -- window
        { key = 'h', mods = 'SUPER', action = wezterm.action.HideApplication },
        { key = 'm', mods = 'SUPER', action = wezterm.action.Hide },
        { key = 'n', mods = 'SUPER', action = wezterm.action.SpawnWindow },
        { key = 'w', mods = 'SUPER', action = wezterm.action.CloseCurrentTab({ confirm = true }) },
        { key = 'q', mods = 'SUPER', action = wezterm.action.QuitApplication },

        -- font size
        { key = '=', mods = 'SUPER', action = wezterm.action.IncreaseFontSize },
        { key = '-', mods = 'SUPER', action = wezterm.action.DecreaseFontSize },
        { key = '0', mods = 'SUPER', action = wezterm.action.ResetFontAndWindowSize },
    }

    config.mouse_bindings = {
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'SUPER',
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
    }

    return function(fish, chissoku)
        wezterm.on('co2', function() wezterm.GLOBAL.co2 = get_co2(chissoku) end)

        wezterm.on('cpu', function() wezterm.GLOBAL.cpu = get_cpu_usage() end)

        wezterm.on('update-status', function()
            wezterm.emit('co2')
            wezterm.emit('cpu')
        end)

        wezterm.on('format-window-title', function()
            local co2 = wezterm.GLOBAL.co2
            co2 = glyphs.co2 .. '  ' .. (co2 and add_comma(co2) .. ' ppm' or 'null')

            local cpu = wezterm.GLOBAL.cpu
            cpu = glyphs.cpu .. '  ' .. (cpu and cpu .. ' %' or 'null')

            return co2 .. '  |  ' .. cpu
        end)

        config.default_prog = { fish, '--login' }

        return config
    end
end)()

---@param colors table
---@param font any
---@param mappings table
---@param fish string
---@return table
M.default = function(colors, font, mappings, fish)
    return {
        -- general
        term = 'wezterm',
        scrollback_lines = 10000,
        default_prog = { fish, '--login' },
        quick_select_patterns = {
            -- sha256 encoded with base64 (e.g. nix hash)
            'sha256-[A-Za-z0-9+/]*={0,3}',
            'sha256:[A-Za-z0-9+/]*={0,3}',
        },

        -- appearance
        colors = colors,
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
        tab_max_width = 100,

        -- font
        font = font,
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
end

return M
