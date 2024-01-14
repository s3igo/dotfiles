---@param colors Colors
---@param glyphs Glyphs
return function(colors, glyphs)
    ---@param window table
    ---@param pane table
    return function(window, pane)
        require('events.update_status.right')(window, pane, colors, glyphs)
        require('events.update_status.left')(window, colors, glyphs)
    end
end
