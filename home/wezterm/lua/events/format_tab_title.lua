local style = require('components').style

---@param tab_info table
---@return string
local function tab_title(tab_info)
    ---@type string
    local title = tab_info.tab_title
    return title and #title > 0 and title or tab_info.active_pane.title
end

---@param colors Colors
return function(colors)
    ---@param tab table
    ---@return string
    return function(tab)
        local title =
            style(' ' .. tab_title(tab) .. ' ', tab.is_active and colors.blue or colors.light_gray, colors.black)
        local zoomed = style(tab.active_pane.is_zoomed and '[Z] ' or '', colors.purple, colors.black)
        return title .. zoomed
    end
end
