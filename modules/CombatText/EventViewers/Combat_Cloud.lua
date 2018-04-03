LUIE.CombatTextCombatCloudEventViewer = LUIE.CombatTextEventViewer:Subclass()
local CTV = LUIE.CombatTextCombatCloudEventViewer

local strfmt     = string.format
local mathrandom = math.random
local mathsqrt   = math.sqrt
local tostring   = tostring

local callLater = zo_callLater
local C = LUIE.CombatTextConstants
local poolTypes = C.poolType

function CTV:New(...)
    local obj = LUIE.CombatTextEventViewer:New(...)
    obj:RegisterCallback(C.eventType.COMBAT, function(...) self:OnEvent(...) end)
    self.eventBuffer = {}
    return obj
end

function CTV:OnEvent(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if (LUIE.CombatText.SV.animation.animationType ~= 'cloud') then return end

    local T = LUIE.CombatText.SV.throttles

    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) and (not LUIE.CombatText.SV.toggles.throttleCriticals) then
        self:View(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted, 1)
    else
        local eventKey = strfmt('%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s', combatType, powerType, abilityName, abilityId, damageType, sourceName, tostring(isDamage), tostring(isDamageCritical), tostring(isHealing), tostring(isHealingCritical), tostring(isEnergize), tostring(isDrain), tostring(isDot), tostring(isDotCritical), tostring(isHot), tostring(isHotCritical), tostring(isMiss), tostring(isImmune), tostring(isParried), tostring(isReflected), tostring(isDamageShield), tostring(isDodged), tostring(isBlocked), tostring(isInterrupted))
        if (self.eventBuffer[eventKey] == nil) then
            self.eventBuffer[eventKey] = { value = value, hits = 1 }
            local throttleTime = 0
            if (isDamage) then throttleTime = T.damage
            elseif (isDamageCritical) then throttleTime = T.damagecritical
            elseif (isDot) then throttleTime = T.dot
            elseif (isDotCritical) then throttleTime = T.dotcritical
            elseif (isHealing) then throttleTime = T.healing
            elseif (isHealingCritical) then throttleTime = T.healingcritical
            elseif (isHot) then throttleTime = T.hot
            elseif (isHotCritical) then throttleTime = T.hotcritical end
            callLater(function() self:ViewFromEventBuffer(combatType, powerType, eventKey, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted) end, throttleTime)
        else
            self.eventBuffer[eventKey].value = self.eventBuffer[eventKey].value + value
            self.eventBuffer[eventKey].hits = self.eventBuffer[eventKey].hits + 1
        end
    end
end

function CTV:ViewFromEventBuffer(combatType, powerType, eventKey, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if not self.eventBuffer[eventKey] then return end
    local value = self.eventBuffer[eventKey].value
    local hits = self.eventBuffer[eventKey].hits
    self.eventBuffer[eventKey] = nil
    self:View(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted, hits)
end

function CTV:View(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted, hits)
    local S = LUIE.CombatText.SV

    -- Control setup
    local panel = LUIE_CombatText_Outgoing
    if (combatType == C.combatType.INCOMING) then panel = LUIE_CombatText_Incoming end
    local w, h = panel:GetDimensions()
    local radiusW, radiusH = w/2, h*2
    local offsetX, offsetY = nil, nil

    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) then
        offsetX, offsetY = mathrandom(-radiusW * .5, radiusW * .5), mathrandom(-radiusH * .5, radiusH * .5)
    elseif (isDot or isHot) then -- http://www.mathopenref.com/coordgeneralellipse.html
        offsetX = mathrandom(-radiusW * .95, radiusW * .95) -- Make radiusW a bit smaller to avoid horizontal animations
        offsetY = mathsqrt((radiusH) ^ 2 * (1 - (offsetX ^ 2 / (radiusW) ^ 2)))
        if (combatType == C.combatType.OUTGOING) then offsetY = -offsetY end
    elseif (isDamage or isHealing or isEnergize or isDrain or isDamageShield or isBlocked) then
        offsetX, offsetY = mathrandom(-radiusW, radiusW), mathrandom(-radiusH * .5, radiusH)
    end

    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)

    if (isDot or isHot) then
        control:SetAnchor(CENTER, panel, CENTER, 0, 0) -- Offsets are set in animation, not here
    else
        control:SetAnchor(CENTER, panel, CENTER, offsetX, offsetY)
    end

    -- Label setup in the correct order that the game handles damage
    local textFormat, fontSize, textColor = self:GetTextAtributes(powerType, damageType, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if (hits > 1 and S.toggles.showThrottleTrailer) then value = strfmt('%d (%d)', value, hits) end
    if (combatType == C.combatType.INCOMING) and (S.toggles.incomingDamageOverride) and (isDamage or isDamageCritical) then textColor = S.colors.incomingDamageOverride end

    self:PrepareLabel(control.label, fontSize, textColor, self:FormatString(textFormat, { text = LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name or abilityName, value = value, powerType = powerType, damageType = damageType }))
    self:ControlLayout(control, abilityId, combatType, sourceName)

    -- Animation setup
    local animationPoolType = poolTypes.ANIMATION_CLOUD
    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) then animationPoolType = poolTypes.ANIMATION_CLOUD_CRITICAL
    elseif (isDot or isHot) then animationPoolType = poolTypes.ANIMATION_CLOUD_FIREWORKS end
    local animation, animationPoolKey = self.poolManager:GetPoolObject(animationPoolType)

    if (animationPoolType == poolTypes.ANIMATION_CLOUD_FIREWORKS) then
        local moveStep = animation:GetStepByName('move')
        moveStep:SetDeltaOffsetX(offsetX)
        moveStep:SetDeltaOffsetY(offsetY)
    end

    animation:Apply(control)
    animation:Play()

    -- Add items back into pool after use
    callLater(function()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
    end, animation:GetDuration())
end
