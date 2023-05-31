local map = hs.keycodes.map
local keyDown = hs.eventtap.event.types.keyDown
local flagsChanged = hs.eventtap.event.types.flagsChanged
local keyStroke = hs.eventtap.keyStroke

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