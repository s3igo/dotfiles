local wezterm = require('wezterm')

---@param cmd table
return function(cmd)
    local home = cmd or {}
    home.workspace = 'general'

    -- general workspace
    local g_tab_1, _, g_window_1 = wezterm.mux.spawn_window(home)
    g_tab_1:set_title('home')

    local g_tab_2, _, g_window_2 = g_window_1:spawn_tab({ cwd = wezterm.home_dir .. '/Desktop' })
    g_tab_2:set_title('desktop')

    local g_tab_3 = g_window_2:spawn_tab({ cwd = wezterm.home_dir .. '/Downloads' })
    g_tab_3:set_title('downloads')

    ---@type string development workspace
    local projects_root = wezterm.home_dir .. '/git/github.com/s3igo'
    local d_tab_1, _, d_window_1 = wezterm.mux.spawn_window({
        workspace = 'develop',
        cwd = wezterm.home_dir .. '/.dotfiles',
    })
    d_tab_1:set_title('dotfiles')

    local d_tab_2, _, d_window_2 = d_window_1:spawn_tab({ cwd = projects_root .. '/atcoder-log' })
    d_tab_2:set_title('atcoder')

    local d_tab_3, _, d_window_3 = d_window_2:spawn_tab({ cwd = projects_root .. '/2023-second-semester' })
    d_tab_3:set_title('univ')

    local d_tab_4 = d_window_3:spawn_tab({ cwd = projects_root .. '/note' })
    d_tab_4:set_title('note')

    wezterm.mux.set_active_workspace('general')
end
