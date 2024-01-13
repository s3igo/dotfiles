local wezterm = require('wezterm')

local M = {}

---@param icon string
---@param text string
---@param fg string
---@param bg string
---@param edge string
---@return string, string
M.separator_left = function(icon, text, fg, bg, edge)
    return wezterm.format({
        { Foreground = { Color = bg } },
        { Background = { Color = edge } },
        { Text = icon },
        { Foreground = { Color = fg } },
        { Background = { Color = bg } },
        { Text = ' ' .. text .. ' ' },
    }),
        bg
end

---@param icon string
---@param text string
---@param fg string
---@param bg string
---@param edge string
---@return string, string
M.separator_right = function(icon, text, fg, bg, edge)
    return wezterm.format({
        { Foreground = { Color = fg } },
        { Background = { Color = bg } },
        { Text = ' ' .. text .. ' ' },
        { Foreground = { Color = bg } },
        { Background = { Color = edge } },
        { Text = icon },
    }),
        bg
end

return M
