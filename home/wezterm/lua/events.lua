local wezterm = require('wezterm')
local utf8 = require('utf8')

---@param default_colors table
---@param chissoku string
return function(default_colors, chissoku)
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
        light_gray = '#7c8f8f', -- NightflyGreyBlue
        navy = '#384b5a',
        dark = '#092236',
        orange = '#ecc48d',
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

    wezterm.on('format-tab-title', require('events.format_tab_title')(colors))
    wezterm.on('gui-startup', require('events.gui_startup'))
    wezterm.on('update-status', require('events.update_status')(colors, glyphs))
    wezterm.on('co2', require('events.custom.co2')(chissoku))
    wezterm.on('cpu-usage', require('events.custom.cpu_usage'))
end
