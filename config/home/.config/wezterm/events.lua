local wezterm = require('wezterm')
local utf8 = require('utf8')
local default_colors = require('colors').default

---@alias Colors table<string, string>
---@type Colors
local colors = {
    white = default_colors.foreground,
    black = default_colors.background,
    gray = default_colors.brights[1],
    red = default_colors.brights[2],
    green = default_colors.ansi[4],
    yellow = default_colors.brights[4],
    blue = default_colors.ansi[5],
    purple = default_colors.ansi[6],
    navy = '#384B5A',
}

---@alias Glyphs table<string, string>
---@type Glyphs
local glyphs = {
    -- arrow
    solid_right_arrow = utf8.char(0xe0b0),
    right_arrow = utf8.char(0xe0b1),
    solid_left_arrow = utf8.char(0xe0b2),
    left_arrow = utf8.char(0xe0b3),
    -- icon
    cpu = utf8.char(0xf4bc),
    co2 = utf8.char(0xf05e3),
}

require('events.gui_startup')
require('events.format_tab_title')(colors, glyphs)

---@param str string
---@param pat string
---@return string[]
local function split(str, pat)
    local t = {}
    for s in string.gmatch(str, pat) do
        table.insert(t, s)
    end
    return t
end

---@return string
local function get_cpu_usage()
    local _, result = wezterm.run_child_process({ 'iostat', '-c', '2' })
    local line = split(result, '[^\r\n]+')[4]
    local value = wezterm.pad_left(100 - split(line, '%S+')[6], 4)
    return glyphs.cpu .. value .. ' %'
end

wezterm.on('cpu-usage', function() wezterm.GLOBAL.cpu = get_cpu_usage() end)

---@return integer | nil
local function get_co2()
    local _, json = wezterm.run_child_process({
        '/etc/profiles/per-user/s3igo/bin/chissoku',
        '--quiet',
        '--stdout.interval=1',
        '--stdout.iterations=1',
        '/dev/tty.usbmodem314201',
    })

    if json == nil or json == '' then
        return nil
    end

    wezterm.run_child_process({ 'sleep', '1' })

    return wezterm.json_parse(json).co2
end

wezterm.on('co2', function() wezterm.GLOBAL.co2 = get_co2() end)

---@param window table
---@param pane_info table
---@return boolean
local function is_valid_pane(window, pane_info)
    local is_startup = pane_info:pane_id() == 0
    local is_operating_confirmation_prompt = window:active_pane():pane_id() ~= pane_info:pane_id()
    return not is_startup and not is_operating_confirmation_prompt
end

wezterm.on('update-status', function(window, pane)
    ---@return string
    local function mode(end_fg)
        local current = window:active_key_table()
        local text = string.upper(current or '')
        local lookup = {
            leader = colors.blue,
            copy_mode = colors.yellow,
        }
        local bg = lookup[current] or colors.navy

        return wezterm.format({
            { Foreground = { Color = bg } },
            { Text = glyphs.solid_left_arrow },
            { Foreground = { Color = colors.black } },
            { Background = { Color = bg } },
            { Text = ' ' .. text .. ' ' },
            { Foreground = { Color = end_fg or colors.gray } },
            { Text = glyphs.solid_left_arrow },
        })
    end

    ---@return string
    local function cpu_usage()
        ---@type string | nil
        local value = wezterm.GLOBAL.cpu
        local text = value or 'null'

        if is_valid_pane(window, pane) then
            window:perform_action(wezterm.action.EmitEvent('cpu-usage'), pane)
        end

        return wezterm.format({
            { Foreground = { Color = colors.white } },
            { Background = { Color = colors.gray } },
            { Text = ' ' .. text .. ' ' },
        })
    end

    ---@return string
    local function co2()
        ---@type integer | nil
        local value = wezterm.GLOBAL.co2
        if is_valid_pane(window, pane) then
            window:perform_action(wezterm.action.EmitEvent('co2'), pane)
        end

        local lookup = {
            good = colors.blue,
            moderate = colors.green,
            bad = colors.yellow,
            very_bad = colors.red,
            extremely_bad = colors.purple,
        }

        local bg = value == nil and colors.white
            or value <= 1000 and lookup.good
            or value <= 1500 and lookup.moderate
            or value <= 2500 and lookup.bad
            or value <= 3500 and lookup.very_bad
            or lookup.extremely_bad

        ---@type string
        local text = (function()
            if type(value) == 'nil' then
                return 'null'
            end

            local value_str = tostring(value)

            -- add comma
            local str = ''
            for i = 1, #value_str do
                str = str .. value_str:sub(i, i)
                if (#value_str - i) % 3 == 0 and i ~= #value_str then
                    str = str .. ','
                end
            end

            return glyphs.co2 .. wezterm.pad_left(str, 6) .. ' ppm'
        end)()

        return wezterm.format({
            { Foreground = { Color = bg } },
            { Background = { Color = colors.gray } },
            { Text = glyphs.solid_left_arrow },
            { Foreground = { Color = colors.black } },
            { Background = { Color = bg } },
            { Text = ' ' .. text .. ' ' },
            { Foreground = { Color = colors.white } },
            { Text = glyphs.solid_left_arrow },
        })
    end

    ---@return string
    local function name()
        local _, user = wezterm.run_child_process({ 'whoami' })
        local _, host = wezterm.run_child_process({ 'scutil', '--get', 'LocalHostName' })
        local text = user:gsub('\n', '') .. '@' .. host:gsub('\n', '')

        return wezterm.format({
            { Foreground = { Color = colors.black } },
            { Background = { Color = colors.white } },
            { Text = ' ' .. text .. ' ' },
            'ResetAttributes',
        })
    end

    local function workspace()
        local text = window:active_workspace()
        return wezterm.format({
            { Foreground = { Color = colors.black } },
            { Background = { Color = colors.white } },
            { Attribute = { Intensity = 'Bold' } },
            { Text = ' [' .. text .. '] ' },
            'ResetAttributes',
        })
    end

    window:set_right_status(mode() .. cpu_usage() .. co2() .. name())
    window:set_left_status(workspace())
end)

