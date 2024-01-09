local utf8 = require('utf8')

---@param default_colors table
return function(default_colors)
    ---@alias ColorKeys
    ---| 'white'
    ---| 'black'
    ---| 'gray'
    ---| 'red'
    ---| 'green'
    ---| 'yellow'
    ---| 'blue'
    ---| 'purple'
    ---| 'navy'
    ---@alias Colors table<ColorKeys, string>
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

    ---@alias GlyphKeys
    ---| 'solid_right_arrow'
    ---| 'right_arrow'
    ---| 'solid_left_arrow'
    ---| 'left_arrow'
    ---| 'cpu'
    ---| 'co2'
    ---@alias Glyphs table<GlyphKeys, string>
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
    require('events.update_status')(colors, glyphs)
    require('events.custom.cpu_usage')
    require('events.custom.co2')
end
