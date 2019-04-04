--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local strfmt = string.format

-- Called from the menu and on initialization to update timestamp color when changed.
local TimeStampColorize
function LUIE.UpdateTimeStampColor()
    TimeStampColorize = ZO_ColorDef:New(unpack(LUIE.ChatAnnouncements.SV.TimeStampColor)):ToHex()
end

-- Return a formatted time
-- Stolen from pChat, thanks @Ayantir
function LUIE.CreateTimestamp(timeStr, formatStr)
    local formatStr = formatStr or LUIE.ChatAnnouncements.SV.TimeStampFormat

    -- Split up default timestamp
    local hours, minutes, seconds = timeStr:match("([^%:]+):([^%:]+):([^%:]+)")
    local hoursNoLead = tonumber(hours) -- Hours without leading zero
    local hours12NoLead = (hoursNoLead - 1)%12 + 1
    local hours12
    if (hours12NoLead < 10) then
        hours12 = "0" .. hours12NoLead
    else
        hours12 = hours12NoLead
    end
    local pUp = "AM"
    local pLow = "am"
    if (hoursNoLead >= 12) then
        pUp = "PM"
        pLow = "pm"
    end

    -- Create new one
    local timestamp = formatStr
    timestamp = timestamp:gsub("HH", hours)
    timestamp = timestamp:gsub("H",  hoursNoLead)
    timestamp = timestamp:gsub("hh", hours12)
    timestamp = timestamp:gsub("h",  hours12NoLead)
    timestamp = timestamp:gsub("m",  minutes)
    timestamp = timestamp:gsub("s",  seconds)
    timestamp = timestamp:gsub("A",  pUp)
    timestamp = timestamp:gsub("a",  pLow)

    return timestamp
end

-- FormatMessage helper function
function LUIE.FormatMessage(msg, doTimestamp)
    local msg = msg or ""
    if doTimestamp then
        local timestring = GetTimeString()
        -- Color Code to match pChat default
        msg = strfmt("|c%s[%s]|r %s", TimeStampColorize, LUIE.CreateTimestamp(timestring), msg)
    end
    return msg
end

-- Easy Print to Chat
function LUIE.PrintToChat(msg, isSystem)
    if LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" then
        if not LUIE.ChatAnnouncements.SV.ChatBypass and CHAT_SYSTEM.primaryContainer then
            local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
            -- Add timestamps if bypass is not enabled
            CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
        else
            -- Otherwise send as a normal message and let other addons handle this.
            CHAT_SYSTEM:AddMessage(msg)
        end
    else
        -- If we have system messages sent to display in all windows then just print to all windows at once, otherwise send messages to individual tabs.
        if CHAT_SYSTEM.primaryContainer then
            if isSystem and LUIE.ChatAnnouncements.SV.ChatSystemAll then
                local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
                -- Post as a System message so that it can appear in multiple tabs.
                CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
            else
                local chatContainer = CHAT_SYSTEM.primaryContainer
                for i = 1, #chatContainer.windows do
                    if LUIE.ChatAnnouncements.SV.ChatTab[i] == true then
                        local chatWindow = CHAT_SYSTEM.primaryContainer["windows"][i]
                        local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
                        chatContainer:AddEventMessageToWindow(chatWindow, msg, CHAT_CATEGORY_SYSTEM)
                    end
                end
            end
        end
    end
end

-- Returns a formatted number with commas
-- Function no comma to be added in a later date.
function LUIE.AbbreviateNumber(number, shorten, comma)
    if number > 0 and shorten then
        local value
        local suffix

        if number >= 1000000000 then
            value = number / 1000000000
            suffix = "G"
        elseif number >= 1000000 then
            value = number / 1000000
            suffix = "M"
        elseif number >= 1000 then
            value = number / 1000
            suffix = "k"
        else
            value = number
        end

        -- If we could not conver even to "G", return full number
        if value >= 1000 then
            if comma then
                value = ZO_LocalizeDecimalNumber(number)
                return value
            else
                return number
            end
        elseif value >= 100 or suffix == nil then
            value = strfmt("%d", value)
        else
            value = strfmt("%.1f", value)
        end

        if suffix ~= nil then
            value = value .. suffix
        end

        return value
    end

    -- Add commas if needed
    if comma then
        local value = ZO_LocalizeDecimalNumber(number)
        return value
    end

    return number
end

function LUIE.UpdateGuildData()
    local GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

-- Simple function to check veteran difficult (VMA isn't considered being in a Veteran Dungeon so we have to do some filtering)
function LUIE.ResolveVeteranDifficulty()
    if GetGroupSize() <= 1 and IsUnitUsingVeteranDifficulty('player') then
        return true
    elseif GetCurrentZoneDungeonDifficulty() == 2 or IsGroupUsingVeteranDifficulty() == true then
        return true
    else
        return false
    end
end

-- Simple function that checks for AvA / IC / BG Status and returns true if the player is in any of these
function LUIE.ResolvePVPZone()
    if IsPlayerInAvAWorld() == true or IsActiveWorldBattleground() == true or IsInImperialCity() == true then
        return true
    else
        return false
    end
end
