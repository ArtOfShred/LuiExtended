--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SpellCastBuffs = LUIE.SpellCastBuffs

local Effects = LUIE.Data.Effects

local zo_strformat = zo_strformat

-- Add millisecond timestamp to ability debug
local function MillisecondTimestampDebug(message)
    local currentTime = GetGameTimeMilliseconds()
    local timestamp = FormatTimeMilliseconds(currentTime, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_MILLISECONDS_NO_HOURS_OR_DAYS, TIME_FORMAT_DIRECTION_NONE)
    timestamp = timestamp:gsub("HH", "")
    timestamp = timestamp:gsub("H ", ":")
    timestamp = timestamp:gsub("hh", "")
    timestamp = timestamp:gsub("h ", ":")
    timestamp = timestamp:gsub("m ", ":")
    timestamp = timestamp:gsub("s ", ":")
    timestamp = timestamp:gsub("A", "")
    timestamp = timestamp:gsub("a", "")
    timestamp = timestamp:gsub("ms", "")
    message = string.format("|c%s[%s]|r %s", LUIE.TimeStampColorize, timestamp, message)
    return message
end

-- Debug Display for Combat Events
function SpellCastBuffs.EventCombatDebug(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
    -- Don't display if this aura is already added to the filter
    if LUIE.DebugAuras[abilityId] and SpellCastBuffs.SV.ShowDebugFilter then return end

    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

    local source = zo_strformat("<<t:1>>", sourceName)
    local target = zo_strformat("<<t:1>>", targetName)
    local ability = zo_strformat("<<t:1>>", nameFormatted)
    local duration = GetAbilityDuration(abilityId)
    local channeled, castTime, channelTime = GetAbilityCastInfo(abilityId)
    local showacasttime = ""
    local showachantime = ""
    if channeled then
        showachantime = (" [Chan] " .. channelTime)
    end
    if castTime ~= 0 then
        showacasttime = (" [Cast] " .. castTime)
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

    local finalString = (iconFormatted .. " ["..abilityId.."] "..ability..": [S] "..source.." --> [T] "..target .. " [D] " .. duration .. showachantime .. showacasttime .. " [R] " .. formattedResult)
    finalString = MillisecondTimestampDebug(finalString)
    -- Use CHAT_ROUTER to bypass some other addons modifying this string
    CHAT_ROUTER:AddSystemMessage(finalString)
end

-- Debug Display for Effect Events
function SpellCastBuffs.EventEffectDebug(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    if LUIE.DebugAuras[abilityId] and SpellCastBuffs.SV.ShowDebugFilter then
        return
    end

    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

    unitName = zo_strformat("<<t:1>>", unitName)
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
        finalString = (iconFormatted .. "|c00E200 [" ..abilityId .. "] " .. nameFormatted.. ": HIDDEN LUI" .. cmxHIDE .. ": [Tag] ".. unitName .. "|r")
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
        finalString = ("|c00E200Gained:|r " .. refreshOnly .. iconFormatted .. " [" .. abilityId .. "] " ..nameFormatted .. ": [Tag] ".. unitName .. " [Dur] " .. duration )
    elseif changeType == 2 then
        finalString = ("|c00E200Faded:|r " .. iconFormatted .. " [" .. abilityId .. "] " .. nameFormatted .. ": [Tag] " .. unitName)
    else
        finalString = ("|c00E200Refreshed:|r " .. iconFormatted .. " (" .. changeType .. ") [" .. abilityId .. "] " ..nameFormatted .. ": [Tag] ".. unitName .. " [Dur] " .. duration )
    end
    finalString = MillisecondTimestampDebug(finalString)
    -- Use CHAT_ROUTER to bypass some other addons modifying this string
    CHAT_ROUTER:AddSystemMessage(finalString)

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

function SpellCastBuffs.TempSlashConsolidate()
    local consolidate = LUIE.SpellCastBuffs.SV.ExtraConsolidate

    if consolidate == true then
        LUIE.SpellCastBuffs.SV.ExtraConsolidate = false
        d("LUIE --- Consolidate Major/Minor Disabled ---")
    else
        LUIE.SpellCastBuffs.SV.ExtraConsolidate = true
        d("LUIE --- Consolidate Major/Minor Enabled ---")
    end

    LUIE.SpellCastBuffs.ReloadEffects("player")
end

local displayName = GetDisplayName()
if displayName == "@ArtOfShred" or displayName == "@ArtOfShredLegacy" then
    SLASH_COMMANDS["/filter"] = SpellCastBuffs.TempSlashFilter
    SLASH_COMMANDS["/ground"] = SpellCastBuffs.TempSlashGround
    SLASH_COMMANDS["/consolidate"] = SpellCastBuffs.TempSlashConsolidate
end
