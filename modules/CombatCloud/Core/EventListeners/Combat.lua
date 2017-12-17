CombatCloud_CombatEventListener = CombatCloud_EventListener:Subclass()
local C = CombatCloudConstants
local AlertT = CombatCloudAlertTable
local callLater = zo_callLater
local refireDelay = { }

local isWarned = {
    combat          = false,
    cleanse         = false,
    disoriented     = false,
    feared          = false,
    offBalanced     = false,
    silenced        = false,
    stunned         = false,
}

function CombatCloud_CombatEventListener:New()
    local obj = CombatCloud_EventListener:New()
    obj:RegisterForEvent(EVENT_COMBAT_EVENT, function(...) self:OnEvent(...) end)
    obj:RegisterForEvent(EVENT_PLAYER_COMBAT_STATE, function() self:CombatState() end)
    obj:RegisterForEvent(EVENT_EFFECT_CHANGED, function(...) self:EffectChanged(...) end)
    return obj
end

function CombatCloud_CombatEventListener:EffectChanged(...)
    local changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer = ...
    local S, combatType, togglesInOut = LUIE.CombatText.SV, nil, nil
    local formattedIcon = zo_iconFormat(GetAbilityIcon(abilityId), 32, 32)
    
    if AlertT[abilityId] and AlertT[abilityId].auradetect and not refireDelay[abilityId] then
    
        effectName = zo_strformat("<<C:1>>", effectName)
        
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then effectName = LUIE.Effects.EffectOverride[abilityId].name end
        
        if changeType == EFFECT_RESULT_FADED then return end
        
        if LUIE.Effects.EffectOverrideByName[abilityId] then
            unitName = zo_strformat("<<t:1>>", unitName)
            if LUIE.Effects.EffectOverrideByName[abilityId][unitName] and LUIE.Effects.EffectOverrideByName[abilityId][unitName].icon then
                formattedIcon = zo_iconFormat(LUIE.Effects.EffectOverrideByName[abilityId][unitName].icon, 32, 32)
            end
        end
        
        if AlertT[abilityId].refire then
            refireDelay[abilityId] = true
            callLater(function() refireDelay[abilityId] = nil end, AlertT[abilityId].refire) --buffer by X time
        end
        
        if AlertT[abilityId].block or AlertT[abilityId].dodge or AlertT[abilityId].avoid or AlertT[abilityId].interrupt then
        
            -- Filter by priority
            if S.toggles.mitigationDungeon and not IsUnitInDungeon("player") or not S.toggles.mitigationDungeon then
                if AlertT[abilityId].priority == 3 and not S.toggles.mitigationRank3 then return end
                if AlertT[abilityId].priority == 2 and not S.toggles.mitigationRank2 then return end
                if AlertT[abilityId].priority == 1 and not S.toggles.mitigationRank1 then return end
            end
            
            local block
            local blockstagger
            local dodge
            local avoid
            local interrupt
            
            if AlertT[abilityId].notDirect then 
                isDirect = false
            else 
                isDirect = true
            end
        
            if AlertT[abilityId].block and (S.toggles.showAlertBlock) == true then
                if AlertT[abilityId].bs then
                    blockstagger = true
                else
                    block = true
                end
            end
            if AlertT[abilityId].dodge and (S.toggles.showAlertDodge) == true then
                dodge = true
            end
            if AlertT[abilityId].avoid and (S.toggles.showAlertDodge) == true then
                avoid = true
            end
            if AlertT[abilityId].interrupt and (S.toggles.showAlertInterrupt) == true then
                interrupt = true
            end
            
            if S.toggles.mitigationType == "Single Line" then
                self:TriggerEvent(C.eventType.ALERT, C.alertType.SHARED, effectName, formattedIcon, unitName, isDirect, block, blockstagger, dodge, avoid, interrupt)
            elseif S.toggles.mitigationType == "Multiple Lines" then
                if block and not blockstagger then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.BLOCK, effectName, formattedIcon, unitName, isDirect)
                end
                if blockstagger then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.BLOCKSTAGGER, effectName, formattedIcon, unitName, isDirect)
                end
                if dodge then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.DODGE, effectName, formattedIcon, unitName, isDirect)
                end
                if avoid then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.AVOID, effectName, formattedIcon, unitName, isDirect)
                end
                if interrupt then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.INTERRUPT, effectName, formattedIcon, unitName, isDirect)
                end
            end
        end
    end
end

function CombatCloud_CombatEventListener:OnEvent(...)
    local resultType, isError, abilityName, abilityGraphic, abilityAction_slotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId = ...
    local S, combatType, togglesInOut = LUIE.CombatText.SV, nil, nil
    abilityName = zo_strformat("<<C:1>>", abilityName)
---------------------------------------------------------------------------------------------------------------------------------------
    --//INCOMING OUTGOING DIRECION//--
---------------------------------------------------------------------------------------------------------------------------------------
    if (C.isPlayer[targetType]) then --Incoming
        combatType = C.combatType.INCOMING
        togglesInOut = S.toggles.incoming
    elseif (C.isPlayer[sourceType]) then --Outgoing
        combatType = C.combatType.OUTGOING
        togglesInOut = S.toggles.outgoing
    else return end
    
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
---------------------------------------------------------------------------------------------------------------------------------------
    --//COMBAT TRIGGERS//--
---------------------------------------------------------------------------------------------------------------------------------------
    if 
       (isDodged and togglesInOut.showDodged) or
       (isMiss and togglesInOut.showMiss) or
       (isImmune and togglesInOut.showImmune) or
       (isReflected and S.toggles.outgoing.showReflected) or --If incoming is allowed, it will display whenever you cast reflect spells but with just outgoing it displays whenever incoming damage is reflected
       (isDamageShield and togglesInOut.showDamageShield) or
       (isParried and togglesInOut.showParried) or
       (isBlocked and togglesInOut.showBlocked) or
       (isInterrupted and togglesInOut.showInterrupted) or
       (isDot and togglesInOut.showDot and hitValue > 0) or
	   (isDotCritical and togglesInOut.showDot and hitValue > 0) or
       (isHot and togglesInOut.showHot and hitValue > 0) or
	   (isHotCritical and togglesInOut.showHot and hitValue > 0) or
       (isHealing and togglesInOut.showHealing and hitValue > 0) or
	   (isHealingCritical and togglesInOut.showHealing and hitValue > 0) or
       (isDamage and togglesInOut.showDamage and hitValue > 0) or
	   (isDamageCritical and togglesInOut.showDamage and hitValue > 0) or
       (isEnergize and togglesInOut.showEnergize and (powerType == POWERTYPE_MAGICKA or powerType == POWERTYPE_STAMINA)) or
       (isEnergize and togglesInOut.showUltimateEnergize and powerType == POWERTYPE_ULTIMATE) or
       (isDrain and togglesInOut.showDrain and not (abilityName == "Sprint Drain") and not (abilityName == "Crouch Drain") and (powerType == POWERTYPE_MAGICKA or powerType == POWERTYPE_STAMINA)) then
       if not LUIE.Effects.EffectHideOverride[abilityId] then -- Check if ability is on the hide list
            if (S.toggles.inCombatOnly and isWarned.combat) or (not S.toggles.inCombatOnly) then --Check if 'in combat only' is ticked
                self:TriggerEvent(C.eventType.COMBAT, combatType, powerType, hitValue, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
            end
       end
    end
---------------------------------------------------------------------------------------------------------------------------------------
    --//CROWD CONTROL & CLEANSE TRIGGERS//--
---------------------------------------------------------------------------------------------------------------------------------------
    if (isWarned.combat) then --Only show CC/Debuff events when in combat
        --Cleanse
        if (isDot and S.toggles.showAlertCleanse and not isWarned.cleanse and not C.isPlayer[sourceType]) then
            local formattedIcon = zo_iconFormat(GetAbilityIcon(abilityId), 32, 32)
            if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then abilityName = LUIE.Effects.EffectOverride[abilityId].name end
            self:TriggerEvent(C.eventType.ALERT, C.alertType.CLEANSE, abilityName, formattedIcon)
            isWarned.cleanse = true
            callLater(function() isWarned.cleanse = false end, 5000) --5 second buffer
        end
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
    
    -- NEW ALERTS
    if AlertT[abilityId] and sourceName ~= nil and sourceName ~= "" and (C.isPlayer[targetType]) and (resultType == ACTION_RESULT_BEGIN or resultType == ACTION_RESULT_BEGIN_CHANNEL or AlertT[abilityId].skipcheck) and not refireDelay[abilityId] then
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then abilityName = LUIE.Effects.EffectOverride[abilityId].name end
        local formattedIcon = zo_iconFormat(GetAbilityIcon(abilityId), 32, 32)
        
        if resultType == ACTION_RESULT_EFFECT_FADED then return end
        
        if LUIE.Effects.EffectOverrideByName[abilityId] then
            sourceName = zo_strformat("<<t:1>>", sourceName)
            if LUIE.Effects.EffectOverrideByName[abilityId][sourceName] and LUIE.Effects.EffectOverrideByName[abilityId][sourceName].icon then
                formattedIcon = zo_iconFormat(LUIE.Effects.EffectOverrideByName[abilityId][sourceName].icon, 32, 32)
            end
        end
        
        if AlertT[abilityId].refire then
            refireDelay[abilityId] = true
            callLater(function() refireDelay[abilityId] = nil end, AlertT[abilityId].refire) --buffer by X time
        end

        if AlertT[abilityId].block or AlertT[abilityId].dodge or AlertT[abilityId].avoid or AlertT[abilityId].interrupt then
        
            -- Filter by priority
            if S.toggles.mitigationDungeon and not IsUnitInDungeon("player") or not S.toggles.mitigationDungeon then
                if AlertT[abilityId].priority == 3 and not S.toggles.mitigationRank3 then return end
                if AlertT[abilityId].priority == 2 and not S.toggles.mitigationRank2 then return end
                if AlertT[abilityId].priority == 1 and not S.toggles.mitigationRank1 then return end
            end
        
            local isDirect
            local block
            local blockstagger
            local dodge
            local avoid
            local interrupt
            
            if AlertT[abilityId].notDirect then 
                isDirect = false
            else 
                isDirect = true
            end
        
            if AlertT[abilityId].block and (S.toggles.showAlertBlock) == true then
                if AlertT[abilityId].bs then
                    blockstagger = true
                else
                    block = true
                end
            end
            if AlertT[abilityId].dodge and (S.toggles.showAlertDodge) == true then
                dodge = true
            end
            if AlertT[abilityId].avoid and (S.toggles.showAlertAvoid) == true then
                avoid = true
            end
            if AlertT[abilityId].interrupt and (S.toggles.showAlertInterrupt) == true then
                interrupt = true
            end
            
            if S.toggles.mitigationType == "Single Line" then
                self:TriggerEvent(C.eventType.ALERT, C.alertType.SHARED, abilityName, formattedIcon, sourceName, isDirect, block, blockstagger, dodge, avoid, interrupt)
            elseif S.toggles.mitigationType == "Multiple Lines" then
                if block and not blockstagger then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.BLOCK, abilityName, formattedIcon, sourceName, isDirect)
                end
                if blockstagger then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.BLOCKSTAGGER, abilityName, formattedIcon, sourceName, isDirect)
                end
                if dodge then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.DODGE, abilityName, formattedIcon, sourceName, isDirect)
                end
                if avoid then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.AVOID, abilityName, formattedIcon, sourceName, isDirect)
                end
                if interrupt then
                    self:TriggerEvent(C.eventType.ALERT, C.alertType.INTERRUPT, abilityName, formattedIcon, sourceName, isDirect)
                end
            end
        end
    end
    --[[ EXPLOIT ALERT (IF WE NEED TO ADD TO ANY OFF-BALANCE)
    if LUIE.Effects.CombatAlertExploit[abilityId] and targetName ~= nil and targetName ~= "" and (C.isPlayer[sourceType]) and resultType == ACTION_RESULT_OFFBALANCE then
        if (S.toggles.showAlertExploit) then
            self:TriggerEvent(C.eventType.ALERT, C.alertType.EXPLOIT, nil)
        end
    end
    ]]--
end

---------------------------------------------------------------------------------------------------------------------------------------
    --//COMBAT STATE EVENTS & TRIGGERS//--
---------------------------------------------------------------------------------------------------------------------------------------
function CombatCloud_CombatEventListener:CombatState(inCombat)
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