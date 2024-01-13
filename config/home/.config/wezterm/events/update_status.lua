local wezterm = require('wezterm')

---@param colors Colors
---@param glyphs Glyphs
return function(colors, glyphs)
    wezterm.on('update-status', function(window, pane)
        require('events.update_status.right')(window, pane, colors, glyphs)
        require('events.update_status.left')(window, colors)
    end)
end
