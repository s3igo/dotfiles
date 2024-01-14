local wezterm = require('wezterm')
local components = require('components')

---@param window table
---@param colors Colors
---@param glyphs Glyphs
return function(window, colors, glyphs)
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

    ---@return string
    local function edge()
        ---@type boolean
        local first_tab_is_active = window:mux_window():tabs_with_info()[1].is_active
        return components.style(
            glyphs.solid_right_arrow,
            colors.white,
            first_tab_is_active and colors.yellow or colors.navy
        )
    end

    window:set_left_status(workspace() .. edge())
end
