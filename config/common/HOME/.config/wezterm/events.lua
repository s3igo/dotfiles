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

-- update cpu usage every 1 second
wezterm.on('cpu-usage', function() wezterm.GLOBAL.cpu = get_cpu_usage() end)
wezterm.on('update-status', function(window, pane)
    local mode = string.upper(window:active_key_table() or '')

    local cpu = wezterm.GLOBAL.cpu or 'undefined'
    window:perform_action(wezterm.action.EmitEvent('cpu-usage'), pane)

    local name = (function()
        local _, user = wezterm.run_child_process({ 'whoami' })
        return user:gsub('\n', '') .. '@' .. wezterm.hostname()
    end)()

    local mode_bg = colors.default.ansi[5]
    local cpu_bg = colors.default.brights[1]
    local name_bg = colors.default.background

    window:set_right_status(wezterm.format({
        -- mode
        { Foreground = { Color = mode_bg } },
        { Text = glyph.solid_left_arrow },
        { Foreground = { Color = 'black' } },
        { Background = { Color = mode_bg } },
        { Text = ' ' .. mode .. ' ' },
        -- cpu usage
        { Foreground = { Color = cpu_bg } },
        { Text = glyph.solid_left_arrow },
        { Foreground = { Color = 'white' } },
        { Background = { Color = cpu_bg } },
        { Text = ' ' .. cpu .. ' ' },
        -- name
        { Foreground = { Color = name_bg } },
        { Text = glyph.solid_left_arrow },
        { Foreground = { Color = 'white' } },
        { Background = { Color = name_bg } },
        { Text = ' ' .. name .. ' ' },
    }))
end)

wezterm.on('format-tab-title', function(tab, _, _, _, _, max_width)
    local function tab_title(tab_info)
        local title = tab_info.tab_title
        return title and #title > 0 and title or tab_info.active_pane.title
    end

    local is_active = tab.is_active

    local bg = is_active and colors.default.ansi[5] or colors.default.brights[1]
    local fg = is_active and colors.default.background or 'white'

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
        -- left shoulder
        { Foreground = { Color = bg } },
        { Background = { Color = colors.bg } },
        { Text = glyph.solid_left_shoulder },
        -- content
        { Foreground = { Color = fg } },
        { Background = { Color = bg } },
        { Attribute = { Intensity = is_active and 'Bold' or 'Normal' } },
        { Attribute = { Italic = is_active } },
        { Text = ' ' .. content .. ' ' },
        -- right shoulder
        { Foreground = { Color = bg } },
        { Background = { Color = colors.bg } },
        { Text = glyph.solid_right_shoulder },
    }
end)
