local wezterm = require('wezterm')
local utf8 = require('utf8')
local colors = require('colors')

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
    -- icon
    cpu = utf8.char(0xf4bc),
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

    local d_tab_4 = d_window_3:spawn_tab({ cwd = projects_root .. '/note' })
    d_tab_4:set_title('note')

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

wezterm.on('update-status', function(window, pane)
    local gray = colors.default.brights[1]
    local blue = '#384B5A'

    local function mode()
        local current = window:active_key_table()
        local text = string.upper(current or '')
        local lookup = {
            leader = colors.default.ansi[5],
            copy_mode = '#F4E49D',
        }
        local mode_bg = lookup[current] or colors.default.ansi[8]

        return wezterm.format({
            { Foreground = { Color = mode_bg } },
            { Text = glyph.solid_left_arrow },
            { Foreground = { Color = 'black' } },
            { Background = { Color = mode_bg } },
            { Text = ' ' .. text .. ' ' },
            { Foreground = { Color = gray } },
            { Text = glyph.solid_left_arrow },
        })
    end

    local function cpu_usage()
        local text = wezterm.GLOBAL.cpu or 'undefined'

        local is_startup = pane:pane_id() == 0
        local is_operating_confirmation_prompt = window:active_pane():pane_id() ~= pane:pane_id()
        -- is valid pane
        if not is_startup and not is_operating_confirmation_prompt then
            window:perform_action(wezterm.action.EmitEvent('cpu-usage'), pane)
        end

        return wezterm.format({
            { Foreground = { Color = 'white' } },
            { Background = { Color = gray } },
            { Text = ' ' .. text .. ' ' },
            { Foreground = { Color = blue } },
            { Text = glyph.solid_left_arrow },
        })
    end

    local function name()
        local _, user = wezterm.run_child_process({ 'whoami' })
        local text = user:gsub('\n', '') .. '@' .. wezterm.hostname()

        return wezterm.format({
            { Foreground = { Color = 'white' } },
            { Background = { Color = blue } },
            { Text = ' ' .. text .. ' ' },
        })
    end

    local function workspace()
        local text = window:active_workspace()
        return wezterm.format({
            { Foreground = { Color = 'white' } },
            { Background = { Color = blue } },
            { Text = ' [' .. text .. '] ' },
        })
    end

    window:set_right_status(mode() .. cpu_usage() .. name())
    window:set_left_status(workspace())
end)

local function tab_title(tab_info)
    local title = tab_info.tab_title
    return title and #title > 0 and title or tab_info.active_pane.title
end

wezterm.on('format-tab-title', function(tab, tabs, _, _, _, max_width)
    -- conditions
    local is_active = tab.is_active
    local is_first_tab = tab.tab_index == 0
    local is_last_tab = tab.tab_index == #tabs - 1
    local prev_tab_is_active = not is_first_tab and tabs[tab.tab_index].is_active

    -- color constants
    local yellow = '#FAB80D'
    local gray = colors.default.brights[1]
    local black = colors.default.background

    local title_fg = is_active and black or 'white'
    local title_bg = is_active and yellow or gray

    local function left_separator()
        local blue = '#384B5A'
        local fg = is_first_tab and blue or prev_tab_is_active and yellow or gray
        local bg = title_bg
        return wezterm.format({
            { Foreground = { Color = fg } },
            { Background = { Color = bg } },
            { Text = glyph.solid_right_arrow },
        })
    end

    local function right_separator()
        return not is_last_tab and ''
            or wezterm.format({
                { Foreground = { Color = title_bg } },
                { Background = { Color = colors.bg } },
                { Text = glyph.solid_right_arrow },
            })
    end

    local function title()
        local index = wezterm.pad_left(tab.tab_index + 1, 2) .. '. '
        local text = index .. tab_title(tab)
        -- 2 or 1 for the shoulder, 2 for the padding
        local extra_chars = is_last_tab and 4 or 3

        local available_width = max_width - extra_chars

        if #text < available_width then
            local width = math.floor((available_width - #text) / 2)
            local function pad(w) return string.rep(' ', w) end
            text = pad(width - 1) .. text .. pad(width + 1)
        end

        return wezterm.format({
            { Foreground = { Color = title_fg } },
            { Background = { Color = title_bg } },
            { Attribute = { Intensity = is_active and 'Bold' or 'Normal' } },
            { Attribute = { Italic = is_active } },
            { Text = ' ' .. wezterm.truncate_right(text, available_width) .. ' ' },
            'ResetAttributes',
        })
    end

    return left_separator() .. title() .. right_separator()
end)
