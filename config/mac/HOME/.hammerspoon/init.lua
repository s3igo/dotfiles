local map = hs.keycodes.map
local keyDown = hs.eventtap.event.types.keyDown
local flagsChanged = hs.eventtap.event.types.flagsChanged
local function keyStroke(mods, char, delay)
    delay = delay or 0
    hs.eventtap.keyStroke(mods, char, delay)
end

local function remap(mods, key, func)
    return hs.hotkey.bind(mods, key, func, nil, func)
end

local remapKeys = {
    remap({'ctrl'}, '[', function() keyStroke({}, 'escape') end),
    remap({'ctrl'}, 'h', function() keyStroke({}, 'delete') end),
    remap({'ctrl'}, 'm', function() keyStroke({}, 'return') end),
    remap({'ctrl'}, 'u', function() keyStroke({'cmd'}, 'delete') end),
    remap({'ctrl'}, 'w', function() keyStroke({'alt'}, 'delete') end),
    remap({'rightalt'}, 'f', function() keyStroke({'alt'}, 'right') end),
    remap({'rightalt'}, 'b', function() keyStroke({'alt'}, 'left') end),
}

local function handleGlobalAppEvent(name, event, app)
    if event == hs.application.watcher.activated then
        if name == 'Alacritty' or name == 'Code' then
            for i, key in ipairs(remapKeys) do
                key:disable()
            end
        else
            for i, key in ipairs(remapKeys) do
                key:enable()
            end
        end
    end
end
appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-- left/right_cmd to eisuu/kana
local isCmdAsModifier = false
local function switchInputSourceEvent(event)
    local eventType = event:getType()
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    local isCmd = flags['cmd']

    if eventType == keyDown then
        if isCmd then
            isCmdAsModifier = true
        end
    elseif eventType == flagsChanged then
        if not isCmd then
            if isCmdAsModifier == false then
                if keyCode == map['cmd'] then
                    keyStroke({}, 0x66, 0) -- eisuu
                elseif keyCode == map['rightcmd'] then
                    keyStroke({}, 0x68, 0) -- kana
                end
            end
            isCmdAsModifier = false
        end
    end
end
eventTap = hs.eventtap.new({keyDown, flagsChanged}, switchInputSourceEvent)
eventTap:start()
