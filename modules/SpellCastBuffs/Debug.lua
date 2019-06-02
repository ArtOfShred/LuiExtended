--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SCB = LUIE.SpellCastBuffs
local E = LUIE.Effects

local strformat = zo_strformat
local iconFormat = zo_iconFormat

-- Debug Display for Combat Events
function SCB.EventCombatDebug(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
    -- Don't display if this aura is already added to the filter
    if LUIE.DebugAuras[abilityId] and SCB.SV.ShowDebugFilter then return end

    local iconFormatted = iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = strformat("<<C:1>>", GetAbilityName(abilityId))

    local source = strformat("<<t:1>>", sourceName)
    local target = strformat("<<t:1>>", targetName)
    local ability = strformat("<<t:1>>", nameFormatted)
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

    local formattedResult = LUIE.DebugResults[result]

    d(iconFormatted .. " ["..abilityId.."] "..ability..": [S] "..source.." --> [T] "..target .. " [D] " .. duration .. showachantime .. showacasttime .. " [R] " .. formattedResult)
end

-- Debug Display for Effect Events
function SCB.EventEffectDebug(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    if LUIE.DebugAuras[abilityId] and SCB.SV.ShowDebugFilter then
        return
    end

    local iconFormatted = iconFormat(GetAbilityIcon(abilityId), 16, 16)
    local nameFormatted = strformat("<<C:1>>", GetAbilityName(abilityId))

    unitName = strformat("<<t:1>>", unitName)
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

    if E.EffectOverride[abilityId] and E.EffectOverride[abilityId].hide then
        d(iconFormatted .. "|c00E200 [" ..abilityId .. "] " .. nameFormatted.. ": HIDDEN LUI" .. cmxHIDE .. ": [Tag] ".. unitName .. "|r")
        return
    end

    local duration = (endTime - beginTime) * 1000

    local refreshOnly = ""
    if E.EffectOverride[abilityId] and E.EffectOverride[abilityId].refreshOnly then
        refreshOnly = " |c00E200(Hidden)|r "
    end

    if changeType == 1 then
        d("|c00E200Gained:|r " .. refreshOnly .. iconFormatted .. " [" .. abilityId .. "] " ..nameFormatted .. ": [Tag] ".. unitName .. " [Dur] " .. duration )
    elseif changeType == 2 then
        d("|c00E200Faded:|r " .. iconFormatted .. " [" .. abilityId .. "] " .. nameFormatted .. ": [Tag] " .. unitName)
    else
        d("|c00E200Refreshed:|r " .. iconFormatted .. " (" .. changeType .. ") [" .. abilityId .. "] " ..nameFormatted .. ": [Tag] ".. unitName .. " [Dur] " .. duration )
    end
end

function SCB.TempSlashFilter()
    local filter = LUIE.SpellCastBuffs.SV.ShowDebugFilter

    if filter == true then
        LUIE.SpellCastBuffs.SV.ShowDebugFilter = false
        d("LUIE --- Ability Debug Filter Disabled ---")
    else
        LUIE.SpellCastBuffs.SV.ShowDebugFilter = true
        d("LUIE --- Ability Debug Filter Enabled ---")
    end
end

function SCB.TempSlashGround()
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

function SCB.TempSlashConsolidate()
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
    SLASH_COMMANDS["/filter"] = SCB.TempSlashFilter
    SLASH_COMMANDS["/ground"] = SCB.TempSlashGround
    SLASH_COMMANDS["/consolidate"] = SCB.TempSlashConsolidate
end
