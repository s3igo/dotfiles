local wezterm = require('wezterm')

---@param window table
---@param colors Colors
return function(window, colors)
    ---@return string
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

    window:set_left_status(workspace())
end
