local wezterm = require('wezterm')

---@param window table
---@param pane_info table
---@return boolean
local function is_valid_pane(window, pane_info)
    local is_startup = pane_info:pane_id() == 0
    local is_operating_confirmation_prompt = window:active_pane():pane_id() ~= pane_info:pane_id()
    return not is_startup and not is_operating_confirmation_prompt
end

---@param int integer
---@return string
local function add_comma(int)
    local result = ''
    local str = tostring(int)
    for i = 1, #str do
        result = result .. str:sub(i, i)
        if (#str - i) % 3 == 0 and i ~= #str then
            result = result .. ','
        end
    end
    return result
end

---@param window table
---@param pane table
---@param colors Colors
---@param glyphs Glyphs
return function(window, pane, colors, glyphs)
    ---@param text string
    ---@param fg string
    ---@param bg string
    ---@param edge string
    ---@return string, string
    local function left_arrow(text, fg, bg, edge)
        return require('components').separator_left(glyphs.solid_left_arrow, text, fg, bg, edge)
    end

    ---@return string, string
    local function mode()
        local current = window:active_key_table()
        local text = string.upper(current or '')
        local lookup = {
            leader = colors.blue,
            copy_mode = colors.yellow,
        }
        local bg = lookup[current] or colors.navy

        return left_arrow(text, colors.black, bg, colors.black)
    end

    ---@param edge string
    ---@return string, string
    local function cpu_usage(edge)
        ---@type string | nil
        local value = wezterm.GLOBAL.cpu
        local text = value == nil and 'null' or glyphs.cpu .. value .. ' %'

        if is_valid_pane(window, pane) then
            window:perform_action(wezterm.action.EmitEvent('cpu-usage'), pane)
        end

        return left_arrow(text, colors.white, colors.gray, edge)
    end

    ---@param edge string
    ---@return string, string
    local function co2(edge)
        ---@type integer | nil
        local value = wezterm.GLOBAL.co2
        if is_valid_pane(window, pane) then
            window:perform_action(wezterm.action.EmitEvent('co2'), pane)
        end

        local lookup = {
            good = colors.blue,
            moderate = colors.green,
            bad = colors.yellow,
            very_bad = colors.red,
            extremely_bad = colors.purple,
        }

        local bg = value == nil and colors.white
            or value <= 1000 and lookup.good
            or value <= 1500 and lookup.moderate
            or value <= 2500 and lookup.bad
            or value <= 3500 and lookup.very_bad
            or lookup.extremely_bad

        ---@type string
        local text
        if value == nil then
            text = 'null'
        else
            text = glyphs.co2 .. wezterm.pad_left(add_comma(value), 6) .. ' ppm'
        end

        return left_arrow(text, colors.black, bg, edge)
    end

    ---@param edge string
    ---@return string, string
    local function name(edge)
        local _, user = wezterm.run_child_process({ 'whoami' })
        local _, host = wezterm.run_child_process({ 'scutil', '--get', 'LocalHostName' })
        local text = user:gsub('\n', '') .. '@' .. host:gsub('\n', '')

        return left_arrow(text, colors.black, colors.yellow, edge)
    end

    local mode_styled, mode_bg = mode()
    local cpu_styled, cpu_bg = cpu_usage(mode_bg)
    local co2_styled, co2_bg = co2(cpu_bg)
    local name_styled = name(co2_bg)

    window:set_right_status(mode_styled .. cpu_styled .. co2_styled .. name_styled)
end
