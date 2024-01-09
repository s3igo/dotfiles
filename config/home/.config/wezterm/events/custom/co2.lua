local wezterm = require('wezterm')

---@return integer | nil
local function get_co2()
    local _, json = wezterm.run_child_process({
        '/etc/profiles/per-user/s3igo/bin/chissoku',
        '--quiet',
        '--stdout.interval=1',
        '--stdout.iterations=1',
        '/dev/tty.usbmodem314201',
    })

    if json == nil or json == '' then
        return nil
    end

    wezterm.run_child_process({ 'sleep', '1' })

    return wezterm.json_parse(json).co2
end

wezterm.on('co2', function() wezterm.GLOBAL.co2 = get_co2() end)

