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
    local _, result = wezterm.run_child_process({ 'iostat', '-c', '2' })
    local line = split(result, '[^\r\n]+')[4]
    return wezterm.pad_left(100 - split(line, '%S+')[6], 4)
end

wezterm.on('cpu-usage', function() wezterm.GLOBAL.cpu = get_cpu_usage() end)
