local wezterm = require('wezterm')

---@return integer | nil
local function get_co2()
    ---@type _, string | nil
    local _, json = wezterm.run_child_process({
        '/etc/profiles/per-user/s3igo/bin/chissoku',
        '--quiet',
        '--stdout.interval=1',
        '--stdout.iterations=1',
        '/dev/tty.usbmodem314201',
    })

    -- json is empty
    if json == nil or json == '' then
        return nil
    end

    -- wait for 1 second due to avoid the "Serial port busy" error
    wezterm.run_child_process({ 'sleep', '1' })

    return wezterm.json_parse(json).co2
end

return function() wezterm.GLOBAL.co2 = get_co2() end
