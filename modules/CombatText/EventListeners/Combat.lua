--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextCombatEventListener = LUIE.CombatTextEventListener:Subclass()
local CTL = LUIE.CombatTextCombatEventListener

local C = LUIE.CombatTextConstants
local E = LUIE.Effects
local AlertT = LUIE.AlertTable

local callLater = zo_callLater

local isWarned = {
    combat          = false,
    disoriented     = false,
    feared          = false,
    offBalanced     = false,
    silenced        = false,
    stunned         = false,
}

function CTL:New()
    local obj = LUIE.CombatTextEventListener:New()
    obj:RegisterForEvent(EVENT_PLAYER_ACTIVATED, function () self:OnPlayerActivated() end)
    obj:RegisterForEvent(EVENT_COMBAT_EVENT, function(...) self:OnCombatIn(...) end, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER) -- Target -> Player
    obj:RegisterForEvent(EVENT_COMBAT_EVENT, function(...) self:OnCombatOut(...) end, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER) -- Player -> Target
    obj:RegisterForEvent(EVENT_COMBAT_EVENT, function(...) self:OnCombatOut(...) end, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER_PET) -- Player Pet -> Target
    obj:RegisterForEvent(EVENT_PLAYER_COMBAT_STATE, function() self:CombatState() end)

    return obj
end

function CTL:OnPlayerActivated()
    if IsUnitInCombat("player") then
        isWarned.combat = true
    end
end

function CTL:OnCombatIn(...)
    local resultType, isError, abilityName, abilityGraphic, abilityAction_slotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow = ...

    local S = LUIE.CombatText.SV
    local combatType, togglesInOut = C.combatType.INCOMING, S.toggles.incoming
    abilityName = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

    local sourceNameCheck = zo_strformat("<<t:1>>", sourceName)

    -- Handle effects that override by UnitName
    if E.EffectOverrideByName[abilityId] then
        if E.EffectOverrideByName[abilityId][sourceNameCheck] then
            if E.EffectOverrideByName[abilityId][sourceNameCheck].name then
                abilityName = E.EffectOverrideByName[abilityId][sourceNameCheck].name
            end
        end
    end

    -- Handle effects that override by ZoneId
    if E.MapDataOverride[abilityId] then
        local index = GetCurrentMapZoneIndex()
        if E.MapDataOverride[abilityId][index] then
            if E.MapDataOverride[abilityId][index].name then
                abilityName = E.MapDataOverride[abilityId][index].name
            end
        end
    end

---------------------------------------------------------------------------------------------------------------------------------------
    --//RESULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Damage
    local isDamage, isDamageCritical, isDot, isDotCritical
        = C.isDamage[resultType], C.isDamageCritical[resultType], C.isDot[resultType], C.isDotCritical[resultType]
    --Healing
    local isHealing, isHealingCritical, isHot, isHotCritical
        = C.isHealing[resultType], C.isHealingCritical[resultType], C.isHot[resultType], C.isHotCritical[resultType]
    --Energize & Drain
    local isEnergize, isDrain
        = C.isEnergize[resultType], C.isDrain[resultType]
    --Mitigation
    local isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted
        = C.isMiss[resultType], C.isImmune[resultType], C.isParried[resultType], C.isReflected[resultType], C.isDamageShield[resultType], C.isDodged[resultType], C.isBlocked[resultType], C.isInterrupted[resultType]
    --Crowd Control
    local isDisoriented, isFeared, isOffBalanced, isSilenced, isStunned
        = C.isDisoriented[resultType], C.isFeared[resultType], C.isOffBalanced[resultType], C.isSilenced[resultType], C.isStunned[resultType]
    --Overflow
    local overkill, overheal
        = (S.common.overkill and overflow > 0 and (isDamage or isDamageCritical or isDot or isDotCritical) ), (S.common.overheal and overflow > 0 and (isHealing or isHealingCritical or isHot or isHotCritical) )
---------------------------------------------------------------------------------------------------------------------------------------
    --//COMBAT TRIGGERS//--
---------------------------------------------------------------------------------------------------------------------------------------
    if
       (isDodged and togglesInOut.showDodged) or
       (isMiss and togglesInOut.showMiss) or
       (isImmune and togglesInOut.showImmune) or
       (isReflected and togglesInOut.showReflected) or
       (isDamageShield and togglesInOut.showDamageShield) or
       (isParried and togglesInOut.showParried) or
       (isBlocked and togglesInOut.showBlocked) or
       (isInterrupted and togglesInOut.showInterrupted) or
       (isDot and togglesInOut.showDot and ( hitValue > 0 or overkill )) or
       (isDotCritical and togglesInOut.showDot and ( hitValue > 0 or overkill )) or
       (isHot and togglesInOut.showHot and ( hitValue > 0 or overheal )) or
       (isHotCritical and togglesInOut.showHot and ( hitValue > 0 or overheal )) or
       (isHealing and togglesInOut.showHealing and ( hitValue > 0 or overheal )) or
       (isHealingCritical and togglesInOut.showHealing and ( hitValue > 0 or overheal )) or
       (isDamage and togglesInOut.showDamage and ( hitValue > 0 or overkill )) or
       (isDamageCritical and togglesInOut.showDamage and ( hitValue > 0 or overkill )) or
       (isEnergize and togglesInOut.showEnergize and (powerType == POWERTYPE_MAGICKA or powerType == POWERTYPE_STAMINA)) or
       (isEnergize and togglesInOut.showUltimateEnergize and powerType == POWERTYPE_ULTIMATE) or
       (isDrain and togglesInOut.showDrain and (powerType == POWERTYPE_MAGICKA or powerType == POWERTYPE_STAMINA)) then
       if overkill or overheal then
            hitValue = hitValue + overflow
       end
       if not E.EffectHideSCT[abilityId] then -- Check if ability is on the hide list
            if (S.toggles.inCombatOnly and isWarned.combat) or (not S.toggles.inCombatOnly) then --Check if 'in combat only' is ticked
                self:TriggerEvent(C.eventType.COMBAT, combatType, powerType, hitValue, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
            end
       end
    end
---------------------------------------------------------------------------------------------------------------------------------------
    --//CROWD CONTROL TRIGGERS//--
---------------------------------------------------------------------------------------------------------------------------------------
    if (isWarned.combat) then --Only show CC/Debuff events when in combat
        --Disoriented
        if (isDisoriented and togglesInOut.showDisoriented) then
            if (isWarned.disoriented) then
                PlaySound('Ability_Failed') --will play a sound every disoriented event afterwards, as any failed action during a CC retriggers the event, causing text flood if buttons are spammed
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.DISORIENTED, combatType)
                isWarned.disoriented = true
                callLater(function() isWarned.disoriented = false end, 1000) end --1 second buffer
        end
        --Feared
        if (isFeared and togglesInOut.showFeared) then
            if (isWarned.feared) then
                PlaySound('Ability_Failed')
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.FEARED, combatType)
                isWarned.feared = true
                callLater(function() isWarned.feared = false end, 1000) end --1 second buffer
        end
        --OffBalanced
        if (isOffBalanced and togglesInOut.showOffBalanced) then
            if (isWarned.offBalanced) then
                PlaySound('Ability_Failed')
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.OFFBALANCED, combatType)
                isWarned.offBalanced = true
                callLater(function() isWarned.offBalanced = false end, 1000) end --1 second buffer
        end
        --Silenced
        if (isSilenced and togglesInOut.showSilenced) then
            if (isWarned.silenced) then
                PlaySound('Ability_Failed')
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.SILENCED, combatType)
                isWarned.silenced = true
                callLater(function() isWarned.silenced = false end, 1000) end --1 second buffer
        end
        --Stunned
        if (isStunned and togglesInOut.showStunned) then
            if (isWarned.stunned) then
                PlaySound('Ability_Failed')
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.STUNNED, combatType)
                isWarned.stunned = true
                callLater(function() isWarned.stunned = false end, 1000) end --1 second buffer
        end
    end
end

function CTL:OnCombatOut(...)
    local resultType, isError, abilityName, abilityGraphic, abilityAction_slotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow = ...

    -- Don't display duplicate messages for events sourced from the player that target the player
    if targetType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER_PET then return end

    local S = LUIE.CombatText.SV
    local combatType, togglesInOut = C.combatType.OUTGOING, S.toggles.outgoing
    abilityName = zo_strformat("<<C:1>>", GetAbilityName(abilityId))

---------------------------------------------------------------------------------------------------------------------------------------
    --//RESULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Damage
    local isDamage, isDamageCritical, isDot, isDotCritical
        = C.isDamage[resultType], C.isDamageCritical[resultType], C.isDot[resultType], C.isDotCritical[resultType]
    --Healing
    local isHealing, isHealingCritical, isHot, isHotCritical
        = C.isHealing[resultType], C.isHealingCritical[resultType], C.isHot[resultType], C.isHotCritical[resultType]
    --Energize & Drain
    local isEnergize, isDrain
        = C.isEnergize[resultType], C.isDrain[resultType]
    --Mitigation
    local isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted
        = C.isMiss[resultType], C.isImmune[resultType], C.isParried[resultType], C.isReflected[resultType], C.isDamageShield[resultType], C.isDodged[resultType], C.isBlocked[resultType], C.isInterrupted[resultType]
    --Crowd Control
    local isDisoriented, isFeared, isOffBalanced, isSilenced, isStunned
        = C.isDisoriented[resultType], C.isFeared[resultType], C.isOffBalanced[resultType], C.isSilenced[resultType], C.isStunned[resultType]
    --Overflow
    local overkill, overheal
        = (S.common.overkill and overflow > 0 and (isDamage or isDamageCritical or isDot or isDotCritical) ), (S.common.overheal and overflow > 0 and (isHealing or isHealingCritical or isHot or isHotCritical) )
---------------------------------------------------------------------------------------------------------------------------------------
    --//COMBAT TRIGGERS//--
---------------------------------------------------------------------------------------------------------------------------------------

    if
       (isDodged and togglesInOut.showDodged) or
       (isMiss and togglesInOut.showMiss) or
       (isImmune and togglesInOut.showImmune) or
       (isReflected and togglesInOut.showReflected) or
       (isDamageShield and togglesInOut.showDamageShield) or
       (isParried and togglesInOut.showParried) or
       (isBlocked and togglesInOut.showBlocked) or
       (isInterrupted and togglesInOut.showInterrupted) or
       (isDot and togglesInOut.showDot and ( hitValue > 0 or overkill )) or
       (isDotCritical and togglesInOut.showDot and ( hitValue > 0 or overkill )) or
       (isHot and togglesInOut.showHot and ( hitValue > 0 or overheal )) or
       (isHotCritical and togglesInOut.showHot and ( hitValue > 0 or overheal )) or
       (isHealing and togglesInOut.showHealing and ( hitValue > 0 or overheal )) or
       (isHealingCritical and togglesInOut.showHealing and ( hitValue > 0 or overheal )) or
       (isDamage and togglesInOut.showDamage and ( hitValue > 0 or overkill )) or
       (isDamageCritical and togglesInOut.showDamage and ( hitValue > 0 or overkill )) or
       (isEnergize and togglesInOut.showEnergize and (powerType == POWERTYPE_MAGICKA or powerType == POWERTYPE_STAMINA)) or
       (isEnergize and togglesInOut.showUltimateEnergize and powerType == POWERTYPE_ULTIMATE) or
       (isDrain and togglesInOut.showDrain and (powerType == POWERTYPE_MAGICKA or powerType == POWERTYPE_STAMINA)) then
       if overkill or overheal then
            hitValue = hitValue + overflow
       end
       if not E.EffectHideSCT[abilityId] then -- Check if ability is on the hide list
            if (S.toggles.inCombatOnly and isWarned.combat) or (not S.toggles.inCombatOnly) then --Check if 'in combat only' is ticked
                self:TriggerEvent(C.eventType.COMBAT, combatType, powerType, hitValue, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
            end
       end
    end
---------------------------------------------------------------------------------------------------------------------------------------
    --//CROWD CONTROL TRIGGERS//--
---------------------------------------------------------------------------------------------------------------------------------------
    if (isWarned.combat) then --Only show CC/Debuff events when in combat
        --Disoriented
        if (isDisoriented and togglesInOut.showDisoriented) then
            if (isWarned.disoriented) then
                PlaySound('Ability_Failed') --will play a sound every disoriented event afterwards, as any failed action during a CC retriggers the event, causing text flood if buttons are spammed
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.DISORIENTED, combatType)
                isWarned.disoriented = true
                callLater(function() isWarned.disoriented = false end, 1000) end --1 second buffer
        end
        --Feared
        if (isFeared and togglesInOut.showFeared) then
            if (isWarned.feared) then
                PlaySound('Ability_Failed')
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.FEARED, combatType)
                isWarned.feared = true
                callLater(function() isWarned.feared = false end, 1000) end --1 second buffer
        end
        --OffBalanced
        if (isOffBalanced and togglesInOut.showOffBalanced) then
            if (isWarned.offBalanced) then
                PlaySound('Ability_Failed')
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.OFFBALANCED, combatType)
                isWarned.offBalanced = true
                callLater(function() isWarned.offBalanced = false end, 1000) end --1 second buffer
        end
        --Silenced
        if (isSilenced and togglesInOut.showSilenced) then
            if (isWarned.silenced) then
                PlaySound('Ability_Failed')
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.SILENCED, combatType)
                isWarned.silenced = true
                callLater(function() isWarned.silenced = false end, 1000) end --1 second buffer
        end
        --Stunned
        if (isStunned and togglesInOut.showStunned) then
            if (isWarned.stunned) then
                PlaySound('Ability_Failed')
            else
                self:TriggerEvent(C.eventType.CROWDCONTROL, C.crowdControlType.STUNNED, combatType)
                isWarned.stunned = true
                callLater(function() isWarned.stunned = false end, 1000) end --1 second buffer
        end
    end

end

---------------------------------------------------------------------------------------------------------------------------------------
    --//COMBAT STATE EVENTS & TRIGGERS//--
---------------------------------------------------------------------------------------------------------------------------------------
function CTL:CombatState(inCombat)
    local S = LUIE.CombatText.SV

    if not isWarned.combat then
        isWarned.combat = true
        if S.toggles.showInCombat then
            self:TriggerEvent(C.eventType.POINT, C.pointType.IN_COMBAT, nil)
        end
    else
        isWarned.combat = false
        if S.toggles.showOutCombat then
            self:TriggerEvent(C.eventType.POINT, C.pointType.OUT_COMBAT, nil)
        end
    end
end
