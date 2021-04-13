--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Called from the menu and on initialization to update timestamp color when changed.
LUIE.TimeStampColorize = nil
function LUIE.UpdateTimeStampColor()
    LUIE.TimeStampColorize = ZO_ColorDef:New(unpack(LUIE.ChatAnnouncements.SV.TimeStampColor)):ToHex()
end

-- Toggle the display of the Alert Frame
function LUIE.SetupAlertFrameVisibility()
    ZO_AlertTextNotification:SetHidden(LUIE.SV.HideAlertFrame)
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
local function FormatMessage(msg, doTimestamp)
    local msg = msg or ""
    if doTimestamp then
        local timestring = GetTimeString()
        -- Color Code to match pChat default
        msg = string.format("|c%s[%s]|r %s", LUIE.TimeStampColorize, LUIE.CreateTimestamp(timestring), msg)
    end
    return msg
end

-- Hide all controls if needed
function LUIE.ToggleVisibility(hidden)
	for _, control in pairs( LUIE.Components ) do
		control:SetHidden( hidden )
	end
end

-- Easy Print to Chat
function LUIE.PrintToChat(msg, isSystem)
    if CHAT_SYSTEM.primaryContainer then
        if LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" then
            if not LUIE.ChatAnnouncements.SV.ChatBypassFormat and CHAT_SYSTEM.primaryContainer then
                -- Add timestamps if bypass is not enabled
                local msg = FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
                CHAT_ROUTER:AddSystemMessage(msg)
            else
                CHAT_ROUTER:AddSystemMessage(msg)
            end
        else
            -- If we have system messages sent to display in all windows then just print to all windows at once, otherwise send messages to individual tabs.
            if isSystem and LUIE.ChatAnnouncements.SV.ChatSystemAll then
                if not LUIE.ChatAnnouncements.SV.ChatBypassFormat then
                    -- Add timestamps if bypass is not enabled
                    local msg = FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
                    CHAT_ROUTER:AddSystemMessage(msg)
                else
                    CHAT_ROUTER:AddSystemMessage(msg)
                end
            else
                for k, cc in ipairs(CHAT_SYSTEM.containers) do
                    for i = 1, #cc.windows do
                        if LUIE.ChatAnnouncements.SV.ChatTab[i] == true then
                            local chatContainer = cc
                            if chatContainer then
                                local chatWindow = cc.windows[i]
                                local msg = FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)

                                -- Don't print into the Combat Metrics Log window if CMX is enabled.
                                local flagHide = false
                                if CMX and CMX.db and CMX.db.chatLog then
                                    if chatContainer:GetTabName(i) == CMX.db.chatLog.name then
                                        flagHide = true
                                    end
                                end
                                if not flagHide then
                                    chatContainer:AddEventMessageToWindow(chatWindow, msg, CHAT_CATEGORY_SYSTEM)
                                end
                            end
                        end
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
            value = string.format("%d", value)
        else
            value = string.format("%.1f", value)
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

-- Takes an input with a name identifier, title, text, and callback function to create a dialogue button
function LUIE.RegisterDialogueButton(identifier, title, text, callback)
    ESO_Dialogs[identifier] =
    {
        gamepadInfo =
        {
            dialogType = GAMEPAD_DIALOGS.BASIC,
        },
        canQueue = true,
        title =
        {
            text = title
        },
        mainText =
        {
            text = text
        },
        buttons =
        {
            {
                text = SI_DIALOG_CONFIRM,
                callback = callback
            },
            {
                text = SI_DIALOG_CANCEL,
            },
        },
    }
    return ESO_Dialogs[identifier]
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

-- Simple function that checks if player is in a PVP zone.
function LUIE.ResolvePVPZone()
    if IsUnitPvPFlagged('player') then
        return true
    else
        return false
    end
end

-- Pull the name for the current morph of a skill
function LUIE.GetSkillMorphName(abilityId)
    local skillType, skillIndex, abilityIndex, morphChoice, rankIndex = GetSpecificSkillAbilityKeysByAbilityId(abilityId)
    local abilityName = GetSkillAbilityInfo(skillType, skillIndex, abilityIndex)
    return abilityName
end

-- Pull the icon for the current morph of a skill
function LUIE.GetSkillMorphIcon(abilityId)
        local skillType, skillIndex, abilityIndex, morphChoice, rankIndex = GetSpecificSkillAbilityKeysByAbilityId(abilityId)
        local abilityIcon = select(2, GetSkillAbilityInfo(skillType, skillIndex, abilityIndex))
        return abilityIcon
end

-- Pull the AbilityId for the current morph of a skill
function LUIE.GetSkillMorphAbilityId(abilityId)
    local skillType, skillIndex, abilityIndex, morphChoice, rankIndex = GetSpecificSkillAbilityKeysByAbilityId(abilityId)
    local abilityId = GetSkillAbilityId(skillType, skillIndex, abilityIndex, false)
    return abilityId
end

-- Function to update the syntax for default Mundus Stone tooltips we pull (in order to retain scaling)
function LUIE.UpdateMundusTooltipSyntax(abilityId, tooltipText)
    -- Update syntax for The Lady, The Lover, and the Thief Mundus stones since they aren't consistent with other buffs.
    if abilityId == 13976 or abilityId == 13981 then -- The Lady / The Lover
        tooltipText = string.gsub(tooltipText, GetString(SI_LUIE_SKILL_MUNDUS_SUB_RES_PEN), GetString(SI_LUIE_SKILL_MUNDUS_SUB_RES_PEN_REPLACE))
    elseif abilityId == 13975 then -- The Thief
        tooltipText = string.gsub(tooltipText, GetString(SI_LUIE_SKILL_MUNDUS_SUB_THIEF), GetString(SI_LUIE_SKILL_MUNDUS_SUB_THIEF_REPLACE))
    end
    -- Replace "Increases your" with "Increase"
    tooltipText = string.gsub(tooltipText, GetString(SI_LUIE_SKILL_MUNDUS_STRING), GetString(SI_LUIE_SKILL_DRINK_INCREASE))
    return tooltipText
end
