-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LUIE
--- @class (partial) LUIE.SpellCastBuffs
local SpellCastBuffs = LUIE.SpellCastBuffs
local Effects = LUIE.Data.Effects

-- -----------------------------------------------------------------------------
-- Core Lua function localizations
-- -----------------------------------------------------------------------------

local pairs = pairs
local string_format = string.format
local zo_strformat = zo_strformat
local zo_iconFormat = zo_iconFormat
local GetAbilityIcon = GetAbilityIcon
local GetAbilityName = GetAbilityName
local GetAbilityDuration = LUIE.GetAbilityDuration
local GetAbilityCastInfo = GetAbilityCastInfo
local DoesAbilityExist = DoesAbilityExist
local GetDisplayName = GetDisplayName
local GetZoneId = GetZoneId
local GetCurrentMapZoneIndex = GetCurrentMapZoneIndex
local GetPlayerLocationName = GetPlayerLocationName
local GetCurrentMapId = GetCurrentMapId
local GetCurrentMapIndex = GetCurrentMapIndex
local GetMapInfoById = GetMapInfoById
local tostring = tostring

local AddSystemMessage = LUIE.AddSystemMessage
local FormatMessage = LUIE.FormatMessage

-- -----------------------------------------------------------------------------
-- Constants
-- -----------------------------------------------------------------------------

local EFFECT_CHANGE_TYPES =
{
    GAINED = 1,
    FADED = 2,
    REFRESHED = 3,
}

-- -----------------------------------------------------------------------------
-- Convert RGB (0.5607843137, 0.5607843137, 0.5607843137) to hex
-- 0.5607843137 * 255 ≈ 143 (8F in hex)
local DEFAULT_TIMESTAMP_COLOR = "8F8F8F"
-- -----------------------------------------------------------------------------
local MESSAGE_COLORS =
{
    TIMESTAMP = LUIE.TimeStampColorize or DEFAULT_TIMESTAMP_COLOR,
    SUCCESS = "|c00E200",
}

-- -----------------------------------------------------------------------------
-- Utility Functions
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--- @param message string Message to format with timestamp
--- @return string Formatted message with timestamp
local function FormatDebugMessage(message)
    -- If pChat is enabled and showing timestamps, don't add our own
    return (pChat and pChat.db and pChat.db.showTimestamp) and message or FormatMessage(message, true)
end
-- -----------------------------------------------------------------------------
--- Format unit name for effect messages
--- @param name string Raw unit name
--- @return string Formatted name
local function FormatUnitName(name)
    return (name == LUIE.PlayerDisplayName) and "Player" or (name == "" and "NIL" or zo_strformat("<<C:1>>", name))
end
-- -----------------------------------------------------------------------------
--- Format unit name for effect messages
--- @param unitName string Raw unit name
--- @param unitTag string Unit tag
--- @return string Formatted name with tag
local function FormatEffectUnitName(unitName, unitTag)
    local formatted = (unitName == LUIE.PlayerDisplayName) and "Player" or zo_strformat("<<C:1>>", unitName)
    return formatted .. " (" .. unitTag .. ")"
end
-- -----------------------------------------------------------------------------
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
-- -----------------------------------------------------------------------------
--- @param abilityId integer Unique ID of the ability
--- @return string CMX hide status string
local function GetCMXHideStatus(abilityId)
    return (CMX and CMX.CustomAbilityHide and CMX.CustomAbilityHide[abilityId]) and " + HIDDEN CMX" or ""
end
-- -----------------------------------------------------------------------------
--- @param abilityId integer Unique ID of the ability
--- @return string Refresh status string
local function GetEffectRefreshStatus(abilityId)
    return (Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].refreshOnly) and " " .. MESSAGE_COLORS.SUCCESS .. "(Hidden)|r " or ""
end

-- -----------------------------------------------------------------------------
-- Message Formatters
-- -----------------------------------------------------------------------------

--- @class EffectChangeFormatter
local EffectChangeFormatter =
{
    [EFFECT_CHANGE_TYPES.GAINED] = function (duration)
        return MESSAGE_COLORS.SUCCESS .. "Gained:|r", string_format(" [Dur] %d", duration)
    end,
    [EFFECT_CHANGE_TYPES.FADED] = function ()
        return MESSAGE_COLORS.SUCCESS .. "Faded:|r", ""
    end,
    [EFFECT_CHANGE_TYPES.REFRESHED] = function (duration)
        return MESSAGE_COLORS.SUCCESS .. "Refreshed:|r", string_format(" [Dur] %d", duration)
    end,
}
-- -----------------------------------------------------------------------------
--- @param changeType integer Effect change type (gained/faded/refreshed)
--- @param refreshStatus string Refresh status string
--- @param icon string Icon texture path
--- @param abilityId integer Unique ID of the ability
--- @param name string Name of the ability
--- @param unitName string Name of the unit
--- @param duration integer Duration of the effect
--- @return string Formatted debug string
local function FormatEffectChangeString(changeType, refreshStatus, icon, abilityId, name, unitName, duration)
    local prefix, suffix = EffectChangeFormatter[changeType](duration)
    return string_format("%s %s%s [%d] %s: [Tag] %s%s", prefix, refreshStatus, icon, abilityId, name, unitName, suffix)
end
-- -----------------------------------------------------------------------------
--- @param icon string Icon texture path
--- @param abilityId integer Unique ID of the ability
--- @param name string Name of the ability
--- @param cmxStatus string CMX status string
--- @param unitName string Name of the unit
--- @return string Formatted debug string
local function FormatHiddenEffectString(icon, abilityId, name, cmxStatus, unitName)
    return string_format("%s%s [%d] %s: HIDDEN LUI%s: [Tag] %s|r", icon, MESSAGE_COLORS.SUCCESS, abilityId, name, cmxStatus, unitName)
end
-- -----------------------------------------------------------------------------
--- @param icon string Icon texture path
--- @param abilityId integer Unique ID of the ability
--- @param name string Name of the ability
--- @param cmxStatus string CMX status string
--- @param source string Source unit name
--- @param target string Target unit name
--- @param result string Debug result string
--- @return string Formatted debug string
local function FormatAuthorCombatString(icon, abilityId, name, cmxStatus, source, target, result)
    return string_format("%s[%d] %s: HIDDEN LUI%s: [S] %s --> [T] %s [R] %s", icon, abilityId, name, cmxStatus, source, target, result)
end

-- -----------------------------------------------------------------------------
-- Event Handlers
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--- Determines if an ability should be skipped in debug output based on filters
--- @param abilityId integer Unique ID of the ability to check
--- @return boolean True if the ability should be skipped, false otherwise
local function ShouldSkipAbility(abilityId)
    return LUIE.Data.DebugAuras[abilityId] and SpellCastBuffs.SV.ShowDebugFilter
end
-- -----------------------------------------------------------------------------
--- Gets formatted ability information including icon and name
--- @param abilityId integer Unique ID of the ability to get info for
--- @return table<string, string> Table containing formatted icon and name strings
local function GetAbilityInfo(abilityId)
    return
    {
        icon = zo_iconFormat(GetAbilityIcon(abilityId), 16, 16),
        name = zo_strformat("<<C:1>>", GetAbilityName(abilityId))
    }
end
-- -----------------------------------------------------------------------------
--- Sends a debug message to all chat windows
--- Formats the message and adds it to window 3 of each chat container
--- @param message string The debug message to send to chat
local function SendToChatWindows(message)
    if not CHAT_SYSTEM.primaryContainer then return end
    local formattedMessage = FormatDebugMessage(message)

    for _, container in ipairs(CHAT_SYSTEM.containers) do
        if container then
            local chatWindow = container.windows[3]
            if chatWindow == nil then
                chatWindow = container.windows[1]
            end
            container:AddEventMessageToWindow(chatWindow, formattedMessage, CHAT_CATEGORY_SYSTEM)
        end
    end
end
-- -----------------------------------------------------------------------------
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
    if ShouldSkipAbility(abilityId) then return end

    local ability = GetAbilityInfo(abilityId)
    local source = FormatUnitName(sourceName)
    local target = FormatUnitName(targetName)
    local duration = GetAbilityDuration(abilityId, overrideRank, casterUnitTag) or 0
    local timingInfo = GetAbilityTimingString(abilityId, overrideRank, casterUnitTag)

    local message = string_format("%s [%d] %s: [S] %s --> [T] %s [D] %d%s [R] %s",
        ability.icon, abilityId, ability.name, source, target, duration, timingInfo, LUIE.Data.DebugResults[result])

    AddSystemMessage(FormatDebugMessage(message))
end

-- -----------------------------------------------------------------------------
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
    if ShouldSkipAbility(abilityId) then return end

    local ability = GetAbilityInfo(abilityId)
    local formattedUnitName = FormatEffectUnitName(unitName, unitTag)
    local effectOverride = Effects.EffectOverride[abilityId]

    if effectOverride and effectOverride.hide then
        local message = FormatHiddenEffectString(ability.icon, abilityId, ability.name, GetCMXHideStatus(abilityId), formattedUnitName)
        AddSystemMessage(FormatDebugMessage(message))
        return
    end

    local duration = (endTime - beginTime) * 1000
    local message = FormatEffectChangeString(changeType, GetEffectRefreshStatus(abilityId), ability.icon, abilityId, ability.name, formattedUnitName, duration)
    AddSystemMessage(FormatDebugMessage(message))
end

-- -----------------------------------------------------------------------------
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
    local effectOverride = Effects.EffectOverride[abilityId]
    if not (effectOverride and effectOverride.hide) then return end

    local ability = GetAbilityInfo(abilityId)
    local source = FormatUnitName(sourceName)
    local target = FormatUnitName(targetName)
    local cmxStatus = GetCMXHideStatus(abilityId)

    local message = FormatAuthorCombatString(ability.icon, abilityId, ability.name, cmxStatus, source, target, LUIE.Data.DebugResults[result])
    SendToChatWindows(message)
end

-- -----------------------------------------------------------------------------
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
    local effectOverride = Effects.EffectOverride[abilityId]
    if not (effectOverride and effectOverride.hide) then return end

    local ability = GetAbilityInfo(abilityId)
    local formattedUnitName = FormatEffectUnitName(unitName, unitTag)
    local cmxStatus = GetCMXHideStatus(abilityId)
    local refreshStatus = GetEffectRefreshStatus(abilityId)

    local message = FormatHiddenEffectString(ability.icon .. refreshStatus, abilityId, ability.name, cmxStatus, formattedUnitName)
    SendToChatWindows(message)
end

-- -----------------------------------------------------------------------------
--- Toggles the ability debug filter on/off.
--- When enabled, shows additional debug information for abilities.
function SpellCastBuffs.TempSlashFilter()
    SpellCastBuffs.SV.ShowDebugFilter = not SpellCastBuffs.SV.ShowDebugFilter
    AddSystemMessage(string_format("LUIE --- Ability Debug Filter %s ---", SpellCastBuffs.SV.ShowDebugFilter and "Enabled" or "Disabled"))
end

-- -----------------------------------------------------------------------------
--- Toggles ground damage aura visualization on/off.
--- When enabled, shows visual effects for ground-based damage areas.
--- Reloads player effects after toggling.
function SpellCastBuffs.TempSlashGround()
    SpellCastBuffs.SV.GroundDamageAura = not SpellCastBuffs.SV.GroundDamageAura
    AddSystemMessage(string_format("LUIE --- Ground Damage Auras %s ---", SpellCastBuffs.SV.GroundDamageAura and "Enabled" or "Disabled"))
    LUIE.SpellCastBuffs.ReloadEffects("player")
end

local function FormatCoords(number)
    return ("%05.02f"):format(zo_round(number * 10000) / 100)
end

local function FormatGPSCoords(number)
    return zo_round(number * 100000)
end

-- -----------------------------------------------------------------------------
--- Outputs current zone and map information to chat.
--- Retrieves and displays:
--- - Zone ID and location name
--- - Map ID and index
--- - Map name, type, content type
--- - Zone index and description
--- - GPS coordinates for player
function SpellCastBuffs.TempSlashZoneCheck()
    -- Set map to player location and handle callback
    if SetMapToPlayerLocation() == SET_MAP_RESULT_MAP_CHANGED then
        LUIE.callbackObject:FireCallbacks("OnWorldMapChanged")
    end

    local zoneid = GetZoneId(GetCurrentMapZoneIndex())
    local locName = GetPlayerLocationName()
    local mapid = GetCurrentMapId()
    local mapindex = GetCurrentMapIndex()
    local name, mapType, mapContentType, zoneIndex, description = GetMapInfoById(mapid)

    -- Get coordinates at different map levels
    local mapX, mapY = GetMapPlayerPosition("player")
    local zoneX, zoneY = mapX, mapY
    local worldX, worldY = mapX, mapY
    local mapName = GetMapName()
    local zoneName = mapName

    -- Handle dungeon/subzone cases
    if GetMapContentType() == MAP_CONTENT_DUNGEON or GetMapType() == MAPTYPE_SUBZONE then
        MapZoomOut()
        zoneName = GetMapName()
        zoneX, zoneY = GetMapPlayerPosition("player")
    end

    -- Get world coordinates (except for Coldharbour)
    if not (mapindex == 23 or GetCurrentMapIndex() == 23) then
        SetMapToMapListIndex(1) -- Tamriel
        worldX, worldY = GetMapPlayerPosition("player")
    end

    -- Reset map to player location
    if SetMapToPlayerLocation() == SET_MAP_RESULT_MAP_CHANGED then
        LUIE.callbackObject:FireCallbacks("OnWorldMapChanged")
    end

    local info =
    {
        { "--------------------" },
        { "ZONE & MAP INFO:" },
        { "--------------------" },
        { "Zone Id:",            zoneid },
        { "Location Name:",      locName },
        { "--------------------" },
        { "Map Id:",             mapid },
        { "Map Index:",          mapindex or "nil" },
        { "--------------------" },
        { "GPS Coordinates:" },
        { "Map:",                string_format("%s: %s×%s", mapName, FormatCoords(mapX), FormatCoords(mapY)) },
        { "Zone:",               string_format("%s: %s×%s", zoneName, FormatCoords(zoneX), FormatCoords(zoneY)) },
        { "World:",              string_format("Tamriel: %s×%s", FormatCoords(worldX), FormatCoords(worldY)) },
        { "--------------------" },
        { "Map Name:",           name },
        { "Map Type:",           mapType },
        { "Map Content Type:",   mapContentType },
        { "Zone Index:",         zoneIndex },
        { "Description:",        description },
        { "--------------------" },
    }

    for _, v in ipairs(info) do
        AddSystemMessage(#v == 1 and v[1] or string_format("%s %s", v[1], v[2]))
    end
end

-- -----------------------------------------------------------------------------
--- Checks for removed abilities by iterating through LUIE.Data.DebugAuras and checking if each ability still exists.
--- Outputs a list of ability IDs that no longer exist in the game to chat.
function SpellCastBuffs.TempSlashCheckRemovedAbilities()
    AddSystemMessage("Removed AbilityIds:")
    for abilityId in pairs(LUIE.Data.DebugAuras) do
        if not DoesAbilityExist(abilityId) then
            AddSystemMessage(tostring(abilityId))
        end
    end
end

-- -----------------------------------------------------------------------------
-- Slash Commands
-- -----------------------------------------------------------------------------
local DEBUG_COMMANDS =
{
    ["/filter"] = SpellCastBuffs.TempSlashFilter,
    ["/ground"] = SpellCastBuffs.TempSlashGround,
    ["/zonecheck"] = SpellCastBuffs.TempSlashZoneCheck,
    ["/abilitydump"] = SpellCastBuffs.TempSlashCheckRemovedAbilities,
}

-- -----------------------------------------------------------------------------
--- Initializes debug slash commands for authorized users only
--- Only users listed in AUTHORIZED_USERS will have access to these commands
--- The commands are registered to the global SLASH_COMMANDS table
if LUIE.IsDevDebugEnabled() then
    for command, handler in pairs(DEBUG_COMMANDS) do
        SLASH_COMMANDS[command] = handler
    end
end
-- -----------------------------------------------------------------------------
