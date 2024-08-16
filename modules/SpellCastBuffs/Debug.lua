--[[
    LuiExtended
    License: The MIT License (MIT)
--]]


---@class (partial) LuiExtended
local LUIE = LUIE
local SpellCastBuffs = LUIE.SpellCastBuffs

local Effects = LUIE.Data.Effects

local pairs = pairs
local string_format = string.format
local zo_strformat = zo_strformat
local zo_strgsub = zo_strgsub
local printtochat = LUIE.PrintToChat

-- Add millisecond timestamp to ability debug
local function MillisecondTimestampDebug(message)
    local currentTime = GetGameTimeMilliseconds()
    local timestamp = FormatTimeMilliseconds(currentTime, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_MILLISECONDS_NO_HOURS_OR_DAYS, TIME_FORMAT_DIRECTION_NONE)
    timestamp = zo_strgsub(timestamp, "HH", "")
    timestamp = zo_strgsub(timestamp, "H ", ":")
    timestamp = zo_strgsub(timestamp, "hh", "")
    timestamp = zo_strgsub(timestamp, "h ", ":")
    timestamp = zo_strgsub(timestamp, "m ", ":")
    timestamp = zo_strgsub(timestamp, "s ", ":")
    timestamp = zo_strgsub(timestamp, "A", "")
    timestamp = zo_strgsub(timestamp, "a", "")
    timestamp = zo_strgsub(timestamp, "ms", "")
    message = string_format("|c%s[%s]|r %s", LUIE.TimeStampColorize, timestamp, message)
    return message
end

-- Debug Display for Combat Events
function SpellCastBuffs.EventCombatDebug(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overrideRank, casterUnitTag)
    -- Don't display if this aura is already added to the filter
    if LUIE.DebugAuras[abilityId] and SpellCastBuffs.SV.ShowDebugFilter then
        return
    end

    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

    local source = zo_strformat("<<C:1>>", sourceName)
    local target = zo_strformat("<<C:1>>", targetName)
    local ability = zo_strformat("<<C:1>>", nameFormatted)
    local duration = GetAbilityDuration(abilityId, overrideRank, casterUnitTag) or 0
    local channeled, durationValue = GetAbilityCastInfo(abilityId, overrideRank, casterUnitTag)
    local showacasttime = "" or GetString(SI_ABILITY_TOOLTIP_CHANNEL_TIME_LABEL)
    local showachantime = "" or GetString(SI_ABILITY_TOOLTIP_CAST_TIME_LABEL)
    if channeled then
        showachantime = (" [Chan] " .. durationValue)
    end
    if durationValue ~= 0 then
        showacasttime = (" [Cast] " .. durationValue)
    end
    if source == LUIE.PlayerNameFormatted then
        source = "Player"
    end
    if target == LUIE.PlayerNameFormatted then
        target = "Player"
    end
    if source == "" and target == "" then
        source = "NIL"
        target = "NIL"
    end

    local formattedResult = LUIE.Data.DebugResults[result]

    local finalString = (iconFormatted .. " [" .. abilityId .. "] " .. ability .. ": [S] " .. source .. " --> [T] " .. target .. " [D] " .. duration .. showachantime .. showacasttime .. " [R] " .. formattedResult)
    finalString = MillisecondTimestampDebug(finalString)
    printtochat(finalString)
end

-- Debug Display for Effect Events
function SpellCastBuffs.EventEffectDebug(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    if LUIE.DebugAuras[abilityId] and SpellCastBuffs.SV.ShowDebugFilter then
        return
    end

    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

    unitName = zo_strformat("<<C:1>>", unitName)
    if unitName == LUIE.PlayerNameFormatted then
        unitName = "Player"
    end
    unitName = unitName .. " (" .. unitTag .. ")"

    local cmxHIDE
    if CMX and CMX.CustomAbilityHide and CMX.CustomAbilityHide[abilityId] then
        cmxHIDE = " + HIDDEN CMX"
    else
        cmxHIDE = ""
    end

    local finalString
    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].hide then
        finalString = (iconFormatted .. "|c00E200 [" .. abilityId .. "] " .. nameFormatted .. ": HIDDEN LUI" .. cmxHIDE .. ": [Tag] " .. unitName .. "|r")
        finalString = MillisecondTimestampDebug(finalString)
        -- Use CHAT_ROUTER to bypass some other addons modifying this string
        CHAT_ROUTER:AddSystemMessage(finalString)
        return
    end

    local duration = (endTime - beginTime) * 1000

    local refreshOnly = ""
    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].refreshOnly then
        refreshOnly = " |c00E200(Hidden)|r "
    end

    if changeType == 1 then
        finalString = ("|c00E200Gained:|r " .. refreshOnly .. iconFormatted .. " [" .. abilityId .. "] " .. nameFormatted .. ": [Tag] " .. unitName .. " [Dur] " .. duration)
    elseif changeType == 2 then
        finalString = ("|c00E200Faded:|r " .. iconFormatted .. " [" .. abilityId .. "] " .. nameFormatted .. ": [Tag] " .. unitName)
    else
        finalString = ("|c00E200Refreshed:|r " .. iconFormatted .. " (" .. changeType .. ") [" .. abilityId .. "] " .. nameFormatted .. ": [Tag] " .. unitName .. " [Dur] " .. duration)
    end
    finalString = MillisecondTimestampDebug(finalString)
    printtochat(finalString)
end

-- Account specific DEBUG for ArtOfShred (These are only registered to give me some additional debug options)
function SpellCastBuffs.AuthorCombatDebug(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

    local source = zo_strformat("<<C:1>>", sourceName)
    local target = zo_strformat("<<C:1>>", targetName)
    local ability = zo_strformat("<<C:1>>", nameFormatted)
    if source == LUIE.PlayerNameFormatted then
        source = "Player"
    end
    if target == LUIE.PlayerNameFormatted then
        target = "Player"
    end
    if source == "" and target == "" then
        source = "NIL"
        target = "NIL"
    end

    local cmxHIDE
    if CMX and CMX.CustomAbilityHide and CMX.CustomAbilityHide[abilityId] then
        cmxHIDE = " + HIDDEN CMX"
    else
        cmxHIDE = ""
    end

    local formattedResult = LUIE.Data.DebugResults[result]

    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].hide then
        local finalString = (iconFormatted .. "[" .. abilityId .. "] " .. nameFormatted .. ": HIDDEN LUI" .. cmxHIDE .. ": [S] " .. source .. " --> [T] " .. target .. " [R] " .. formattedResult)
        finalString = MillisecondTimestampDebug(finalString)
        if CHAT_SYSTEM.primaryContainer then
            for k, cc in ipairs(CHAT_SYSTEM.containers) do
                local chatContainer = cc
                local chatWindow = cc.windows[2]
                if chatContainer then
                    chatContainer:AddEventMessageToWindow(chatWindow, finalString, CHAT_CATEGORY_SYSTEM)
                end
            end
        end
    end
end

-- Account specific DEBUG for ArtOfShred (These are only registered to give me some additional debug options)
function SpellCastBuffs.AuthorEffectDebug(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

    unitName = zo_strformat("<<C:1>>", unitName)
    if unitName == LUIE.PlayerNameFormatted then
        unitName = "Player"
    end
    unitName = unitName .. " (" .. unitTag .. ")"

    local cmxHIDE
    if CMX and CMX.CustomAbilityHide and CMX.CustomAbilityHide[abilityId] then
        cmxHIDE = " + HIDDEN CMX"
    else
        cmxHIDE = ""
    end

    local refreshOnly = ""
    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].refreshOnly then
        refreshOnly = " |c00E200(Refresh Only - Hidden)|r "
    end

    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].hide then
        local finalString = (iconFormatted .. refreshOnly .. "|c00E200 [" .. abilityId .. "] " .. nameFormatted .. ": HIDDEN LUI" .. cmxHIDE .. ": [Tag] " .. unitName .. "|r")
        finalString = MillisecondTimestampDebug(finalString)
        if CHAT_SYSTEM.primaryContainer then
            for k, cc in ipairs(CHAT_SYSTEM.containers) do
                local chatContainer = cc
                local chatWindow = cc.windows[2]
                if chatContainer then
                    chatContainer:AddEventMessageToWindow(chatWindow, finalString, CHAT_CATEGORY_SYSTEM)
                end
            end
        end
    end
end

function SpellCastBuffs.TempSlashFilter()
    local filter = LUIE.SpellCastBuffs.SV.ShowDebugFilter

    if filter == true then
        LUIE.SpellCastBuffs.SV.ShowDebugFilter = false
        d("LUIE --- Ability Debug Filter Disabled ---")
    else
        LUIE.SpellCastBuffs.SV.ShowDebugFilter = true
        d("LUIE --- Ability Debug Filter Enabled ---")
    end
end

function SpellCastBuffs.TempSlashGround()
    local ground = LUIE.SpellCastBuffs.SV.GroundDamageAura

    if ground == true then
        LUIE.SpellCastBuffs.SV.GroundDamageAura = false
        d("LUIE --- Ground Damage Auras Disabled ---")
    else
        LUIE.SpellCastBuffs.SV.GroundDamageAura = true
        d("LUIE --- Ground Damage Auras Enabled ---")
    end

    LUIE.SpellCastBuffs.ReloadEffects("player")
end

function SpellCastBuffs.TempSlashZoneCheck()
    printtochat("--------------------")
    printtochat("ZONE & MAP INFO:")
    printtochat("--------------------")
    local zoneid = GetZoneId(GetCurrentMapZoneIndex())
    printtochat("Zone Id: " .. zoneid)
    local locName = GetPlayerLocationName()
    printtochat("Location Name: " .. locName)
    printtochat("--------------------")
    local mapid = GetCurrentMapId()
    printtochat("Map Id: " .. mapid)
    local mapindex = GetCurrentMapIndex()
    if mapindex then -- this value can return nil
        printtochat("Map Index: " .. mapindex)
    else
        printtochat("Map Index: nil")
    end
    printtochat("--------------------")
    local name, mapType, mapContentType, zoneIndex, description = GetMapInfoById(mapid)
    printtochat("Map Name: " .. name)
    printtochat("Map Type: " .. mapType)
    printtochat("Map Content Type: " .. mapContentType)
    printtochat("Zone Index: " .. zoneIndex)
    printtochat("Description: " .. description)
    printtochat("--------------------")
end

function SpellCastBuffs.TempSlashCheckRemovedAbilities()
    d("Removed AbilityIds:")
    for k, v in pairs(LUIE.DebugAuras) do
        if not DoesAbilityExist(k) then
            d(k)
        end
    end
end

local displayName = GetDisplayName()
if displayName == "@ArtOfShred" or displayName == "@ArtOfShredPTS" or displayName == "@ArtOfShredLegacy" or displayName == "@HammerOfGlory" or displayName == "@dack_janiels" then
    SLASH_COMMANDS["/filter"] = SpellCastBuffs.TempSlashFilter
    SLASH_COMMANDS["/ground"] = SpellCastBuffs.TempSlashGround
    SLASH_COMMANDS["/zonecheck"] = SpellCastBuffs.TempSlashZoneCheck
    SLASH_COMMANDS["/abilitydump"] = SpellCastBuffs.TempSlashCheckRemovedAbilities
end
