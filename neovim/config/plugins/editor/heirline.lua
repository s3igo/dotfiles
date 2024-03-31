local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local colors = {
    purple = utils.get_highlight('NightflyPurple').fg,
    gray = utils.get_highlight('NightflyAshBlue').fg,
    dark_gray = utils.get_highlight('NightflyGreyBlue').fg,
    white = utils.get_highlight('NightflyWhite').fg,
    orange = utils.get_highlight('NightflyTan').fg,
    blue = utils.get_highlight('NightflyBlue').fg,
    green = utils.get_highlight('NightflyEmerald').fg,
    red = utils.get_highlight('NightflyRed').fg,
    navy = '#384b5a',
    bg = '#092236',
}

local glyphs = {
    solid_right_arrow = '',
    right_arrow = '',
    solid_left_arrow = '',
    left_arrow = '',
}

local spacer = {
    hl = { bg = 'none' },
    provider = '%=',
}

local statusline = (function()
    local git = {
        condition = conditions.is_git_repo,
        init = function(self) self.status = vim.b.gitsigns_status_dict end,
        { -- branch
            hl = { fg = colors.white, bg = colors.bg },
            provider = function(self) return ' ' .. self.status.head .. ' ' end,
        },
        { -- separator
            condition = function(self)
                return self.status.added ~= 0 or self.status.changed ~= 0 or self.status.removed ~= 0
            end,
            hl = { fg = colors.gray, bg = colors.bg },
            provider = glyphs.right_arrow .. ' ',
        },
        { -- added
            hl = { fg = colors.green, bg = colors.bg },
            provider = function(self)
                local cnt = self.status.added or 0
                return cnt > 0 and '+' .. cnt .. ' '
            end,
        },
        { -- changed
            hl = { fg = colors.orange, bg = colors.bg },
            provider = function(self)
                local cnt = self.status.changed or 0
                return cnt > 0 and '~' .. cnt .. ' '
            end,
        },
        { -- removed
            hl = { fg = colors.red, bg = colors.bg },
            provider = function(self)
                local cnt = self.status.removed or 0
                return cnt > 0 and '-' .. cnt .. ' '
            end,
        },
        {
            hl = { fg = colors.bg, bg = colors.navy },
            provider = glyphs.solid_right_arrow,
        },
    }

    local lsp = {
        init = function(self)
            -- copilot
            self.copilot = {}
            local api = require('copilot.api')
            api.register_status_notification_handler(function(data) self.copilot.status = data.status end)
            -- diagnostics
            self.diagnostics = {}
            self.diagnostics.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.diagnostics.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            self.diagnostics.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            self.diagnostics.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,
        { -- copilot
            static = {
                colors = {
                    Normal = colors.gray,
                    InProgress = colors.orange,
                    Error = colors.red,
                },
            },
            hl = function(self) return { fg = self.colors[self.copilot.status] or colors.white, bg = colors.navy } end,
            provider = function(self)
                local status = self.copilot.status

                if not self.colors[status] then
                    return ' ' .. status .. ' '
                end

                return '   '
            end,
        },
        { -- separator
            condition = function(self)
                local is_diagnostics_enabled = self.diagnostics.errors > 0
                    or self.diagnostics.warnings > 0
                    or self.diagnostics.hints > 0
                    or self.diagnostics.info > 0

                local is_copilot_enabled = self.copilot.status ~= nil

                return is_diagnostics_enabled and is_copilot_enabled
            end,
            hl = { fg = colors.white, bg = colors.navy },
            provider = glyphs.right_arrow,
        },
        { -- diagnostics
            condition = conditions.has_diagnostics,
            update = { 'DiagnosticChanged', 'BufEnter' },
            {
                hl = { bg = colors.navy },
                provider = ' ',
            },
            {
                hl = { fg = colors.red, bg = colors.navy },
                provider = function(self)
                    local cnt = self.diagnostics.errors
                    return cnt > 0 and 'E:' .. cnt .. ' '
                end,
            },
            {
                hl = { fg = colors.orange, bg = colors.navy },
                provider = function(self)
                    local cnt = self.diagnostics.warnings
                    return cnt > 0 and 'W:' .. cnt .. ' '
                end,
            },
            {
                hl = { fg = colors.blue, bg = colors.navy },
                provider = function(self)
                    local cnt = self.diagnostics.hints
                    return cnt > 0 and 'H:' .. cnt .. ' '
                end,
            },
            {
                hl = { fg = colors.gray, bg = colors.navy },
                provider = function(self)
                    local cnt = self.diagnostics.info
                    return cnt > 0 and 'I:' .. cnt .. ' '
                end,
            },
        },
        {
            hl = { fg = colors.navy, bg = 'none' },
            provider = glyphs.solid_right_arrow,
        },
    }

    local file = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
        { -- filename
            hl = { fg = colors.gray, bg = 'none' },
            provider = function(self)
                local name = vim.fn.fnamemodify(self.filename, ':.')

                if #name == 0 then
                    return ' [No Name] '
                end

                if not conditions.width_percent_below(#name, 0.25) then
                    name = vim.fn.pathshorten(name)
                end

                return ' ' .. name .. ' '
            end,
        },
        { -- flag
            {
                condition = function() return vim.bo.modified end,
                hl = { fg = colors.orange },
                provider = '[+]',
            },
            {
                condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
                hl = { fg = colors.blue },
                provider = '[-]',
            },
        },
    }

    local ruler = {
        {
            hl = { fg = colors.navy, bg = 'none' },
            provider = glyphs.solid_left_arrow,
        },
        {
            hl = { fg = colors.white, bg = colors.navy },
            provider = ' %c ' .. glyphs.left_arrow .. ' %l/%L (%P) ',
        },
    }

    local info = {
        {
            hl = { fg = colors.bg, bg = colors.navy },
            provider = glyphs.solid_left_arrow,
        },
        {
            hl = { fg = colors.gray, bg = colors.bg },
            provider = ' ' .. vim.bo.shiftwidth .. ' ' .. glyphs.left_arrow,
        },
        {
            static = { unix = 'lf', dos = 'crlf', mac = 'cr' },
            hl = { fg = colors.gray, bg = colors.bg },
            provider = function(self) return ' ' .. self[vim.bo.fileformat] .. ' ' .. glyphs.left_arrow end,
        },
        {
            hl = { fg = colors.gray, bg = colors.bg },
            provider = ' ' .. vim.bo.fenc .. ' ',
        },
    }

    return {
        git,
        lsp,
        file,
        spacer,
        ruler,
        info,
    }
end)()

local get_bufs = function()
    return vim.tbl_filter(
        function(bufnr) return vim.api.nvim_get_option_value('buflisted', { buf = bufnr }) end,
        vim.api.nvim_list_bufs()
    )
end

local buflist_cache = {}

vim.api.nvim_create_autocmd({ 'VimEnter', 'UIEnter', 'BufAdd', 'BufDelete' }, {
    callback = function()
        vim.schedule(function()
            local buffers = get_bufs()
            for i, v in ipairs(buffers) do
                buflist_cache[i] = v
            end
            for i = #buffers + 1, #buflist_cache do
                buflist_cache[i] = nil
            end

            if #buflist_cache > 1 then
                vim.o.showtabline = 2
            elseif vim.o.showtabline ~= 1 then
                vim.o.showtabline = 1
            end
        end)
    end,
})

local tabline = (function()
    local filename = {
        provider = function(self)
            local name = self.filename
            return #name == 0 and ' [No Name] ' or ' ' .. vim.fn.fnamemodify(name, ':t') .. ' '
        end,
        hl = function(self) return { fg = (self.is_active or self.is_visible) and colors.blue or colors.dark_gray } end,
    }

    local flag = {
        {
            condition = function(self) return vim.api.nvim_get_option_value('modified', { buf = self.bufnr }) end,
            provider = '[+] ',
            hl = { fg = colors.orange },
        },
        {
            condition = function(self)
                return not vim.api.nvim_get_option_value('modifiable', { buf = self.bufnr })
                    or vim.api.nvim_get_option_value('readonly', { buf = self.bufnr })
            end,
            provider = '[-] ',
            hl = { fg = colors.blue },
        },
    }

    local file = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(self.bufnr) end,
        filename,
        flag,
    }

    return utils.make_buflist(file, nil, nil, function() return buflist_cache end, false)
end)()

require('heirline').setup({
    statusline = statusline,
    tabline = tabline,
})
