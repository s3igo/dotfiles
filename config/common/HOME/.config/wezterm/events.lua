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

    local bg = is_active and colors.default.ansi[5] or leader_bg
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
        { Foreground = { Color = bg } },
        { Background = { Color = colors.bg } },
        { Text = glyph.solid_left_shoulder },
        { Foreground = { Color = fg } },
        { Background = { Color = bg } },
        { Attribute = { Intensity = is_active and 'Bold' or 'Normal' } },
        { Attribute = { Italic = is_active } },
        { Text = ' ' .. content .. ' ' },
        { Foreground = { Color = bg } },
        { Background = { Color = colors.bg } },
        { Text = glyph.solid_right_shoulder },
    }
end)
