local components = require('components')

---@param window table
---@param colors Colors
---@param glyphs Glyphs
return function(window, colors, glyphs)
    window:set_left_status(
        components.separator_right(
            glyphs.solid_right_arrow,
            window:active_workspace(),
            colors.white,
            colors.navy,
            colors.black
        )
    )
end
