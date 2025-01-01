--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

--- @class (partial) LuiExtended
local LUIE = LUIE
local SpellCastBuffs = LUIE.SpellCastBuffs

local Effects = LUIE.Data.Effects

local pairs = pairs
local string_format = string.format
local zo_strformat = zo_strformat
local zo_strgsub = zo_strgsub
local printtochat = LUIE.PrintToChat

-- Add millisecond timestamp to ability debug
--- @param message string Message to add timestamp to
--- @return string Formatted message with timestamp
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

--- Format unit name for debug messages
--- @param name string Raw unit name
--- @return string Formatted name
local function FormatUnitName(name)
    if name == LUIE.PlayerNameFormatted then
        return "Player"
    elseif name == "" then
        return "NIL"
    else
        return name
    end
end

--- @param abilityId integer Unique ID of the ability
--- @param overrideRank integer? Rank override for the ability
--- @param casterUnitTag string? Unit tag of the caster
--- @return string Formatted timing string
local function GetAbilityTimingString(abilityId, overrideRank, casterUnitTag)
    local channeled, durationValue = GetAbilityCastInfo(abilityId, overrideRank, casterUnitTag)
    local castStr = durationValue ~= 0 and string_format(" [Cast] %s", durationValue) or ""
    local chanStr = channeled and string_format(" [Chan] %s", durationValue) or ""
    return castStr .. chanStr
end

-- Helper functions for effect debug messages

--- Format unit name for effect messages
--- @param unitName string Raw unit name
--- @param unitTag string Unit tag
--- @return string Formatted name with tag
local function FormatEffectUnitName(unitName, unitTag)
    local formatted = zo_strformat("<<C:1>>", unitName)
    if formatted == LUIE.PlayerNameFormatted then
        formatted = "Player"
    end
    return formatted .. " (" .. unitTag .. ")"
end

--- Check if ability is hidden in Combat Metrics
--- @param abilityId integer Ability ID to check
--- @return string Hide status string
local function GetCMXHideStatus(abilityId)
    if CMX and CMX.CustomAbilityHide and CMX.CustomAbilityHide[abilityId] then
        return " + HIDDEN CMX"
    end
    return ""
end

--- Format message for hidden effects
--- @param icon string Formatted ability icon
--- @param abilityId integer Ability ID
--- @param name string Ability name
--- @param cmxStatus string CMX hide status
--- @param unitName string Formatted unit name
--- @return string Formatted message
local function FormatHiddenEffectString(icon, abilityId, name, cmxStatus, unitName)
    return string_format("%s|c00E200 [%d] %s: HIDDEN LUI%s: [Tag] %s|r",
        icon, abilityId, name, cmxStatus, unitName)
end

--- Get refresh status string for effects
--- @param abilityId integer Ability ID to check
--- @return string Refresh status string
local function GetEffectRefreshStatus(abilityId)
    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].refreshOnly then
        return " |c00E200(Hidden)|r "
    end
    return ""
end

--- Format effect change message based on change type
--- @param changeType integer Type of effect change
--- @param refreshStatus string Refresh status string
--- @param icon string Formatted ability icon
--- @param abilityId integer Ability ID
--- @param name string Ability name
--- @param unitName string Formatted unit name
--- @param duration number Effect duration
--- @return string Formatted message
local function FormatEffectChangeString(changeType, refreshStatus, icon, abilityId, name, unitName, duration)
    local prefix
    local suffix = ""

    if changeType == 1 then
        prefix = "|c00E200Gained:|r"
        suffix = string_format(" [Dur] %d", duration)
    elseif changeType == 2 then
        prefix = "|c00E200Faded:|r"
    else
        prefix = "|c00E200Refreshed:|r"
        suffix = string_format(" [Dur] %d", duration)
    end

    return string_format("%s %s%s [%d] %s: [Tag] %s%s", prefix, refreshStatus, icon, abilityId, name, unitName, suffix)
end

--- Format author-specific combat debug message
--- @param icon string Formatted ability icon
--- @param abilityId integer Ability ID
--- @param name string Ability name
--- @param cmxStatus string CMX hide status
--- @param source string Source name
--- @param target string Target name
--- @param result string Formatted result
--- @return string Formatted message
local function FormatAuthorCombatString(icon, abilityId, name, cmxStatus, source, target, result)
    return string_format("%s[%d] %s: HIDDEN LUI%s: [S] %s --> [T] %s [R] %s",
        icon, abilityId, name, cmxStatus, source, target, result)
end

--- Send message to all chat windows
--- @param message string Message to send
local function SendToChatWindows(message)
    if not CHAT_SYSTEM.primaryContainer then return end

    for _, cc in ipairs(CHAT_SYSTEM.containers) do
        local chatContainer = cc
        local chatWindow = cc.windows[2]
        if chatContainer then
            chatContainer:AddEventMessageToWindow(chatWindow, message, CHAT_CATEGORY_SYSTEM)
        end
    end
end

--- Handles debug output for combat events, displaying detailed information about ability usage
--- @param eventCode integer Event code (unused)
--- @param result ActionResult The result of the combat action (hit, miss, etc)
--- @param isError boolean Whether the action resulted in an error
--- @param abilityName string Name of the ability used
--- @param abilityGraphic integer Ability graphic ID (unused)
--- @param abilityActionSlotType ActionSlotType Type of action slot used
--- @param sourceName string Name of the ability source/caster
--- @param sourceType CombatUnitType Type of unit that is the source
--- @param targetName string Name of the ability target
--- @param targetType CombatUnitType Type of unit that is the target
--- @param hitValue integer Damage/healing value
--- @param powerType CombatMechanicFlags Type of resource affected
--- @param damageType DamageType Type of damage dealt
--- @param log boolean Whether to log this event
--- @param sourceUnitId integer Unique ID of source unit
--- @param targetUnitId integer Unique ID of target unit
--- @param abilityId integer Unique ID of the ability
--- @param overrideRank integer? Rank override for the ability
--- @param casterUnitTag string? Unit tag of the caster
function SpellCastBuffs.EventCombatDebug(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overrideRank, casterUnitTag)
    -- Skip if ability is filtered
    if LUIE.Data.DebugAuras[abilityId] and SpellCastBuffs.SV.ShowDebugFilter then
        return
    end

    -- Format ability information
    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))
    local ability = zo_strformat("<<C:1>>", nameFormatted)

    -- Format source and target names
    local source = FormatUnitName(zo_strformat("<<C:1>>", sourceName))
    local target = FormatUnitName(zo_strformat("<<C:1>>", targetName))

    -- Get ability timing information
    local duration = GetAbilityDuration(abilityId, overrideRank, casterUnitTag) or 0
    local timingInfo = GetAbilityTimingString(abilityId, overrideRank, casterUnitTag)

    -- Build and output the debug message
    local finalString = string_format("%s [%d] %s: [S] %s --> [T] %s [D] %d%s [R] %s",
        iconFormatted, abilityId, ability, source, target, duration, timingInfo,
        LUIE.Data.DebugResults[result])

    printtochat(MillisecondTimestampDebug(finalString))
end

--- Handles debug output for buff/debuff effect changes
--- @param eventCode integer Event code (unused)
--- @param changeType EffectResult Type of effect change (gained/faded/refreshed)
--- @param effectSlot integer Slot index of the effect
--- @param effectName string Name of the effect
--- @param unitTag string Unit tag of affected entity
--- @param beginTime number Start time of the effect
--- @param endTime number End time of the effect
--- @param stackCount integer Number of effect stacks
--- @param iconName string Icon texture path
--- @param buffType string Deprecated buff type
--- @param effectType BuffEffectType Type of effect (buff/debuff)
--- @param abilityType AbilityType Type of ability
--- @param statusEffectType StatusEffectType Type of status effect
--- @param unitName string Name of affected unit
--- @param unitId integer Unique ID of affected unit
--- @param abilityId integer Unique ID of the ability
--- @param castByPlayer CombatUnitType Source type of the effect
function SpellCastBuffs.EventEffectDebug(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    -- Skip if ability is filtered
    if LUIE.Data.DebugAuras[abilityId] and SpellCastBuffs.SV.ShowDebugFilter then
        return
    end

    -- Format ability information
    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

    -- Format unit name and check CMX hiding
    local formattedUnitName = FormatEffectUnitName(unitName, unitTag)
    local cmxHideStatus = GetCMXHideStatus(abilityId)

    -- Handle hidden effects
    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].hide then
        local hiddenString = FormatHiddenEffectString(iconFormatted, abilityId, nameFormatted, cmxHideStatus, formattedUnitName)
        CHAT_ROUTER:AddSystemMessage(MillisecondTimestampDebug(hiddenString))
        return
    end

    -- Calculate effect duration and get refresh status
    local duration = (endTime - beginTime) * 1000
    local refreshStatus = GetEffectRefreshStatus(abilityId)

    -- Build and output the effect message based on change type
    local finalString = FormatEffectChangeString(changeType, refreshStatus, iconFormatted, abilityId, nameFormatted, formattedUnitName, duration)
    printtochat(MillisecondTimestampDebug(finalString))
end

--- Author-specific debug handler for combat events. Only processes hidden abilities.
--- @param eventCode integer Event code (unused)
--- @param result ActionResult The result of the combat action (hit, miss, etc)
--- @param isError boolean Whether the action resulted in an error
--- @param abilityName string Name of the ability used
--- @param abilityGraphic integer Ability graphic ID (unused)
--- @param abilityActionSlotType ActionSlotType Type of action slot used
--- @param sourceName string Name of the ability source/caster
--- @param sourceType CombatUnitType Type of unit that is the source
--- @param targetName string Name of the ability target
--- @param targetType CombatUnitType Type of unit that is the target
--- @param hitValue integer Damage/healing value
--- @param powerType CombatMechanicFlags Type of resource affected
--- @param damageType DamageType Type of damage dealt
--- @param log boolean Whether to log this event
--- @param sourceUnitId integer Unique ID of source unit
--- @param targetUnitId integer Unique ID of target unit
--- @param abilityId integer Unique ID of the ability
function SpellCastBuffs.AuthorCombatDebug(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
    -- Only process abilities that are marked as hidden in EffectOverride
    if not (Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].hide) then
        return
    end

    -- Format ability information
    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))
    local source = FormatUnitName(zo_strformat("<<C:1>>", sourceName))
    local target = FormatUnitName(zo_strformat("<<C:1>>", targetName))
    local cmxStatus = GetCMXHideStatus(abilityId)

    -- Build and send debug message to all chat windows
    local finalString = FormatAuthorCombatString(
        iconFormatted,
        abilityId,
        nameFormatted,
        cmxStatus,
        source,
        target,
        LUIE.Data.DebugResults[result]
    )

    SendToChatWindows(MillisecondTimestampDebug(finalString))
end

--- Author-specific debug handler for effect changes. Only processes hidden effects.
--- @param eventCode integer Event code (unused)
--- @param changeType EffectResult Type of effect change (gained/faded/refreshed)
--- @param effectSlot integer Slot index of the effect
--- @param effectName string Name of the effect
--- @param unitTag string Unit tag of affected entity
--- @param beginTime number Start time of the effect
--- @param endTime number End time of the effect
--- @param stackCount integer Number of effect stacks
--- @param iconName string Icon texture path
--- @param buffType string Deprecated buff type
--- @param effectType BuffEffectType Type of effect (buff/debuff)
--- @param abilityType AbilityType Type of ability
--- @param statusEffectType StatusEffectType Type of status effect
--- @param unitName string Name of affected unit
--- @param unitId integer Unique ID of affected unit
--- @param abilityId integer Unique ID of the ability
--- @param castByPlayer CombatUnitType Source type of the effect
function SpellCastBuffs.AuthorEffectDebug(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    -- Only process effects that are marked as hidden in EffectOverride
    if not (Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].hide) then
        return
    end

    -- Format ability and unit information
    local iconFormatted = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = zo_strformat("<<C:1>>", GetAbilityName(abilityId))
    local formattedUnitName = FormatEffectUnitName(unitName, unitTag)
    local cmxStatus = GetCMXHideStatus(abilityId)
    local refreshStatus = GetEffectRefreshStatus(abilityId)

    -- Build and send debug message to all chat windows
    local finalString = FormatHiddenEffectString(
        iconFormatted .. refreshStatus,
        abilityId,
        nameFormatted,
        cmxStatus,
        formattedUnitName
    )

    SendToChatWindows(MillisecondTimestampDebug(finalString))
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
    for k, v in pairs(LUIE.Data.DebugAuras) do
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
