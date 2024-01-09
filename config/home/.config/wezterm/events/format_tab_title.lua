local wezterm = require('wezterm')

---@param tab_info table
---@return string
local function tab_title(tab_info)
    ---@type string
    local title = tab_info.tab_title
    return title and #title > 0 and title or tab_info.active_pane.title
end

---@param text string
---@param width integer
---@return string
local function fix_width(text, width)
    -- text is too short
    if #text < width then
        local pad_width = math.floor((width - #text) / 2)
        local pad = string.rep(' ', pad_width)
        text = pad .. text .. pad
    end

    return wezterm.truncate_right(text, width)
end

---@param colors Colors
---@param glyphs Glyphs
return function(colors, glyphs)
    ---@param tab { tab_index: integer, is_active: boolean }
    ---@param tabs { is_active: boolean }[]
    ---@param max_width integer
    wezterm.on('format-tab-title', function(tab, tabs, _, _, _, max_width)
        -- conditions
        local is_active = tab.is_active
        local is_first_tab = tab.tab_index == 0
        local is_last_tab = tab.tab_index == #tabs - 1
        -- because `tab.tab_index` is 0 origin
        local prev_tab_is_active = not is_first_tab and tabs[tab.tab_index].is_active

        local frontground = is_active and colors.black or colors.white
        local background = is_active and colors.yellow or colors.navy

        ---@return string
        local function left_separator()
            local fg = is_first_tab and colors.white or prev_tab_is_active and colors.yellow or colors.navy
            local bg = background
            return wezterm.format({
                { Foreground = { Color = fg } },
                { Background = { Color = bg } },
                { Text = glyphs.solid_right_arrow },
            })
        end

        ---@return string
        local function right_separator()
            return not is_last_tab and ''
                or wezterm.format({
                    { Foreground = { Color = background } },
                    { Background = { Color = colors.black } },
                    { Text = glyphs.solid_right_arrow },
                })
        end

        ---@return string
        local function title()
            ---@type string  to 1 origin
            local index = wezterm.pad_left(tab.tab_index + 1, 2) .. '. '
            -- 2 or 1 for the separator, 2 for the padding
            local extra_chars = is_last_tab and 4 or 3
            local available_width = max_width - extra_chars
            local text = fix_width(index .. tab_title(tab), available_width)

            return wezterm.format({
                { Foreground = { Color = frontground } },
                { Background = { Color = background } },
                { Attribute = { Intensity = is_active and 'Bold' or 'Normal' } },
                { Attribute = { Italic = is_active } },
                -- offset for left separator doesn't exist
                { Text = text .. '  ' },
                'ResetAttributes',
            })
        end

        return left_separator() .. title() .. right_separator()
    end)
end
