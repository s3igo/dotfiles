local wezterm = require('wezterm')

---@param window table
---@param pane_info table
---@return boolean
local function is_valid_pane(window, pane_info)
    local is_startup = pane_info:pane_id() == 0
    local is_operating_confirmation_prompt = window:active_pane():pane_id() ~= pane_info:pane_id()
    return not is_startup and not is_operating_confirmation_prompt
end

---@param colors Colors
---@param glyphs Glyphs
return function(colors, glyphs)
    wezterm.on('update-status', function(window, pane)
        ---@return string
        local function mode(end_fg)
            local current = window:active_key_table()
            local text = string.upper(current or '')
            local lookup = {
                leader = colors.blue,
                copy_mode = colors.yellow,
            }
            local bg = lookup[current] or colors.navy

            return wezterm.format({
                { Foreground = { Color = bg } },
                { Text = glyphs.solid_left_arrow },
                { Foreground = { Color = colors.black } },
                { Background = { Color = bg } },
                { Text = ' ' .. text .. ' ' },
                { Foreground = { Color = end_fg or colors.gray } },
                { Text = glyphs.solid_left_arrow },
            })
        end

        ---@return string
        local function cpu_usage()
            ---@type string | nil
            local value = wezterm.GLOBAL.cpu
            local text = value == nil and 'null' or glyphs.cpu .. value .. ' %'

            if is_valid_pane(window, pane) then
                window:perform_action(wezterm.action.EmitEvent('cpu-usage'), pane)
            end

            return wezterm.format({
                { Foreground = { Color = colors.white } },
                { Background = { Color = colors.gray } },
                { Text = ' ' .. text .. ' ' },
            })
        end

        ---@return string
        local function co2()
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
            local text = (function()
                if type(value) == 'nil' then
                    return 'null'
                end

                local value_str = tostring(value)

                -- add comma
                local str = ''
                for i = 1, #value_str do
                    str = str .. value_str:sub(i, i)
                    if (#value_str - i) % 3 == 0 and i ~= #value_str then
                        str = str .. ','
                    end
                end

                return glyphs.co2 .. wezterm.pad_left(str, 6) .. ' ppm'
            end)()

            return wezterm.format({
                { Foreground = { Color = bg } },
                { Background = { Color = colors.gray } },
                { Text = glyphs.solid_left_arrow },
                { Foreground = { Color = colors.black } },
                { Background = { Color = bg } },
                { Text = ' ' .. text .. ' ' },
                { Foreground = { Color = colors.white } },
                { Text = glyphs.solid_left_arrow },
            })
        end

        ---@return string
        local function name()
            local _, user = wezterm.run_child_process({ 'whoami' })
            local _, host = wezterm.run_child_process({ 'scutil', '--get', 'LocalHostName' })
            local text = user:gsub('\n', '') .. '@' .. host:gsub('\n', '')

            return wezterm.format({
                { Foreground = { Color = colors.black } },
                { Background = { Color = colors.white } },
                { Text = ' ' .. text .. ' ' },
                'ResetAttributes',
            })
        end

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

        window:set_right_status(mode() .. cpu_usage() .. co2() .. name())
        window:set_left_status(workspace())
    end)
end
