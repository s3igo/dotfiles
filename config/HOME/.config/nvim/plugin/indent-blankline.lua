local status, indentBlankline = pcall(require, 'indent_blankline')
if (not status) then return end

indentBlankline.setup {
    char = '|',
    show_end_of_line = true,
    show_trailing_blankline_indent = false,
    -- tree-sitterが必要
    -- show_current_context = true,
    -- show_current_context_start = true,
}
