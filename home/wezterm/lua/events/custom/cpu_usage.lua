local wezterm = require('wezterm')

---@param str string
---@param pat string
---@return string[]
local function split(str, pat)
    local t = {}
    for s in string.gmatch(str, pat) do
        table.insert(t, s)
    end
    return t
end

---@return string
local function get_cpu_usage()
    ---@type _, string
    local _, result = wezterm.run_child_process({ 'iostat', '-c', '2', 'disk0' })

    local line = split(result, '[^\r\n]+')[4]
    local value = split(line, '%S+')[6]

    return wezterm.pad_left(100 - value, 4)
end

return function() wezterm.GLOBAL.cpu = get_cpu_usage() end
