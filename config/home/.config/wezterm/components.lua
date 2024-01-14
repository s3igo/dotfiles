local wezterm = require('wezterm')

local M = {}

---@param text string
---@param fg string
---@param bg string
---@alias Underline 'None' | 'Single' | 'Double' | 'Curly' | 'Dotted' | 'Dashed'
---@alias Intensity 'Normal' | 'Bold' | 'Half'
---@alias Attr { underline?: Underline, intensity?: Intensity, italic?: boolean }
---@param attr? Attr
M.style = function(text, fg, bg, attr)
    return wezterm.format({
        { Foreground = { Color = fg } },
        { Background = { Color = bg } },
        { Attribute = { Underline = attr and attr.underline or 'None' } },
        { Attribute = { Intensity = attr and attr.intensity or 'Normal' } },
        { Attribute = { Italic = not not (attr and attr.italic) } },
        { Text = text },
        'ResetAttributes',
    })
end

---@param icon string
---@param text string
---@param fg string
---@param bg string
---@param edge string
---@return string, string
M.separator_left = function(icon, text, fg, bg, edge)
    return M.style(icon, bg, edge) .. M.style(' ' .. text .. ' ', fg, bg), bg
end

---@param icon string
---@param text string
---@param fg string
---@param bg string
---@param edge string
---@param attr? Attr
---@return string, string
M.separator_right = function(icon, text, fg, bg, edge, attr)
    return M.style(' ' .. text .. ' ', fg, bg, attr) .. M.style(icon, bg, edge), bg
end

return M
