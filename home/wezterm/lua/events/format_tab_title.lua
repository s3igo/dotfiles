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
        text = string.rep(' ', pad_width) .. text .. string.rep(' ', pad_width + 1)
    end

    return wezterm.truncate_right(text, width)
end

---@param colors Colors
---@param glyphs Glyphs
return function(colors, glyphs)
    ---@param tab { tab_index: integer, is_active: boolean }
    ---@param tabs { is_active: boolean }[]
    ---@param max_width integer
    ---@return string
    return function(tab, tabs, _, _, _, max_width)
        -- conditions
        local is_active = tab.is_active
        local is_last_tab = tab.tab_index == #tabs - 1
        -- because `tab.tab_index` is 0 origin
        local next_tab_is_active = not is_last_tab and tabs[tab.tab_index + 2].is_active

        ---@return string
        local function text()
            ---@type string  to 1 origin
            local index = wezterm.pad_left(tab.tab_index + 1, 2) .. '. '
            -- 2 or 1 for the separator, 2 for the padding
            local extra_chars = is_last_tab and 4 or 3
            local available_width = max_width - extra_chars
            return fix_width(index .. tab_title(tab), available_width)
        end

        return (
            require('components').separator_right(
                glyphs.solid_right_arrow,
                text(),
                is_active and colors.black or colors.white,
                is_active and colors.yellow or colors.navy,
                is_last_tab and colors.black or next_tab_is_active and colors.yellow or colors.navy,
                { intensity = is_active and 'Bold' or 'Normal', italic = is_active }
            )
        )
    end
end
