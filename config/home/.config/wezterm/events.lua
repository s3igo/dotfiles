local wezterm = require('wezterm')
local utf8 = require('utf8')
local default_colors = require('colors').default

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

local glyph = {
    -- arrow
    solid_right_arrow = utf8.char(0xe0b0),
    right_arrow = utf8.char(0xe0b1),
    solid_left_arrow = utf8.char(0xe0b2),
    left_arrow = utf8.char(0xe0b3),
    -- icon
    cpu = utf8.char(0xf4bc),
    co2 = utf8.char(0xf05e3),
}

wezterm.on('gui-startup', function(cmd)
    local home = cmd or {}
    home.workspace = 'general'

    -- general workspace
    local g_tab_1, _, g_window_1 = wezterm.mux.spawn_window(home)
    g_tab_1:set_title('home')

    local g_tab_2, _, g_window_2 = g_window_1:spawn_tab({ cwd = wezterm.home_dir .. '/Desktop' })
    g_tab_2:set_title('desktop')

    local g_tab_3, _, g_window_3 = g_window_2:spawn_tab({ cwd = wezterm.home_dir .. '/Downloads' })
    g_tab_3:set_title('downloads')

    local g_tab_4, _, g_window_4 = g_window_3:spawn_tab({ cwd = wezterm.home_dir .. '/Dropbox' })
    g_tab_4:set_title('dropbox')

    local g_tab_5 = g_window_4:spawn_tab({ cwd = wezterm.home_dir .. '/Dropbox/univ' })
    g_tab_5:set_title('univ')

    -- development workspace
    local projects_root = wezterm.home_dir .. '/git/github.com/s3igo'
    local d_tab_1, _, d_window_1 = wezterm.mux.spawn_window({
        workspace = 'develop',
        cwd = wezterm.home_dir .. '/.dotfiles',
    })
    d_tab_1:set_title('dotfiles')

    local d_tab_2, _, d_window_2 = d_window_1:spawn_tab({ cwd = projects_root .. '/atcoder-rust' })
    d_tab_2:set_title('atcoder')

    local d_tab_3, _, d_window_3 = d_window_2:spawn_tab({ cwd = projects_root .. '/2023-second-semester' })
    d_tab_3:set_title('univ')

    local d_tab_4 = d_window_3:spawn_tab({ cwd = projects_root .. '/notes' })
    d_tab_4:set_title('notes')

    wezterm.mux.set_active_workspace('general')
end)

local function split(str, pat)
    local t = {}
    for s in string.gmatch(str, pat) do
        table.insert(t, s)
    end
    return t
end

local function get_cpu_usage()
    local _, result = wezterm.run_child_process({ 'iostat', '-c', '2' })
    local line = split(result, '[^\r\n]+')[4]
    local value = wezterm.pad_left(100 - split(line, '%S+')[6], 4)
    return glyph.cpu .. value .. ' %'
end

wezterm.on('cpu-usage', function() wezterm.GLOBAL.cpu = get_cpu_usage() end)

local function get_co2()
    local _, json = wezterm.run_child_process({
        '/etc/profiles/per-user/s3igo/bin/chissoku',
        '--quiet',
        '--stdout.interval=1',
        '--stdout.iterations=1',
        '/dev/tty.usbmodem314201',
    })
    if not json then
        return 'null'
    end

    -- matche any number of 2 or more digits
    return json:match('(%d%d+)') or 'null'
end

wezterm.on('co2', function() wezterm.GLOBAL.co2 = get_co2() end)

local function is_valid_pane(window, pane_info)
    local is_startup = pane_info:pane_id() == 0
    local is_operating_confirmation_prompt = window:active_pane():pane_id() ~= pane_info:pane_id()
    return not is_startup and not is_operating_confirmation_prompt
end

wezterm.on('update-status', function(window, pane)
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
            { Text = glyph.solid_left_arrow },
            { Foreground = { Color = colors.black } },
            { Background = { Color = bg } },
            { Text = ' ' .. text .. ' ' },
            { Foreground = { Color = end_fg or colors.gray } },
            { Text = glyph.solid_left_arrow },
        })
    end

    local function cpu_usage()
        local text = wezterm.GLOBAL.cpu or 'undefined'

        if is_valid_pane(window, pane) then
            window:perform_action(wezterm.action.EmitEvent('cpu-usage'), pane)
        end

        return wezterm.format({
            { Foreground = { Color = colors.white } },
            { Background = { Color = colors.gray } },
            { Text = ' ' .. text .. ' ' },
        })
    end

    local function co2()
        local value = wezterm.GLOBAL.co2 or 'undefined'
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

        local bg = not tonumber(value) and colors.white
            or tonumber(value) <= 1000 and lookup.good
            or tonumber(value) <= 1500 and lookup.moderate
            or tonumber(value) <= 2500 and lookup.bad
            or tonumber(value) <= 3500 and lookup.very_bad
            or lookup.extremely_bad

        local text = (function()
            if not tonumber(value) then
                return value
            end

            -- add comma
            local str = ''
            for i = 1, #value do
                str = str .. value:sub(i, i)
                if (#value - i) % 3 == 0 and i ~= #value then
                    str = str .. ','
                end
            end

            return glyph.co2 .. wezterm.pad_left(str, 6) .. ' ppm'
        end)()

        return wezterm.format({
            { Foreground = { Color = bg } },
            { Background = { Color = colors.gray } },
            { Text = glyph.solid_left_arrow },
            { Foreground = { Color = colors.black } },
            { Background = { Color = bg } },
            { Text = ' ' .. text .. ' ' },
            { Foreground = { Color = colors.white } },
            { Text = glyph.solid_left_arrow },
        })
    end

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

local function tab_title(tab_info)
    local title = tab_info.tab_title
    return title and #title > 0 and title or tab_info.active_pane.title
end

local function fix_width(text, width)
    -- text is too short
    if #text < width then
        local pad_width = math.floor((width - #text) / 2)
        local pad = string.rep(' ', pad_width)
        text = pad .. text .. pad
    end

    return wezterm.truncate_right(text, width)
end

wezterm.on('format-tab-title', function(tab, tabs, _, _, _, max_width)
    -- conditions
    local is_active = tab.is_active
    local is_first_tab = tab.tab_index == 0
    local is_last_tab = tab.tab_index == #tabs - 1
    local prev_tab_is_active = not is_first_tab and tabs[tab.tab_index].is_active

    local frontground = is_active and colors.black or colors.white
    local background = is_active and colors.yellow or colors.navy

    local function left_separator()
        local fg = is_first_tab and colors.white or prev_tab_is_active and colors.yellow or colors.navy
        local bg = background
        return wezterm.format({
            { Foreground = { Color = fg } },
            { Background = { Color = bg } },
            { Text = glyph.solid_right_arrow },
        })
    end

    local function right_separator()
        return not is_last_tab and ''
            or wezterm.format({
                { Foreground = { Color = background } },
                { Background = { Color = colors.black } },
                { Text = glyph.solid_right_arrow },
            })
    end

    local function title()
        -- to 1 origin
        local index = wezterm.pad_left(tab.tab_index + 1, 2) .. '. '
        -- 2 or 1 for the separator, 2 for the padding
        local extra_chars = is_last_tab and 4 or 3
        local available_width = max_width - extra_chars
        local text = fix_width(index .. tab_title(tab), available_width)

        return wezterm.format({
            { Foreground = { Color = frontground } },
            { Background = { Color = background } },
            { Attribute = { Intensity = is_active and 'Bold' or 'Normal' } },
            { Attribute = { Italic = is_active } },
            -- offset for left separator doesn't exist
            { Text = text .. '  ' },
            'ResetAttributes',
        })
    end

    return left_separator() .. title() .. right_separator()
end)
