--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextCombatCloudEventViewer = LUIE.CombatTextEventViewer:Subclass()
local CombatTextCombatCloudEventViewer = LUIE.CombatTextCombatCloudEventViewer

local CombatTextConstants = LUIE.Data.CombatTextConstants
local AbbreviateNumber = LUIE.AbbreviateNumber

function CombatTextCombatCloudEventViewer:New(...)
    local obj = LUIE.CombatTextEventViewer:New(...)
    obj:RegisterCallback(CombatTextConstants.eventType.COMBAT, function(...) self:OnEvent(...) end)
    self.eventBuffer = {}
    return obj
end

function CombatTextCombatCloudEventViewer:OnEvent(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if (LUIE.CombatText.SV.animation.animationType ~= 'cloud') then return end

    local T = LUIE.CombatText.SV.throttles

    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) and (not LUIE.CombatText.SV.toggles.throttleCriticals) then
        self:View(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted, 1)
    else
        local eventKey = string.format('%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s', combatType, powerType, abilityName, abilityId, damageType, sourceName, tostring(isDamage), tostring(isDamageCritical), tostring(isHealing), tostring(isHealingCritical), tostring(isEnergize), tostring(isDrain), tostring(isDot), tostring(isDotCritical), tostring(isHot), tostring(isHotCritical), tostring(isMiss), tostring(isImmune), tostring(isParried), tostring(isReflected), tostring(isDamageShield), tostring(isDodged), tostring(isBlocked), tostring(isInterrupted))
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
            zo_callLater(function() self:ViewFromEventBuffer(combatType, powerType, eventKey, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted) end, throttleTime)
        else
            self.eventBuffer[eventKey].value = self.eventBuffer[eventKey].value + value
            self.eventBuffer[eventKey].hits = self.eventBuffer[eventKey].hits + 1
        end
    end
end

function CombatTextCombatCloudEventViewer:ViewFromEventBuffer(combatType, powerType, eventKey, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if not self.eventBuffer[eventKey] then return end
    local value = self.eventBuffer[eventKey].value
    local hits = self.eventBuffer[eventKey].hits
    self.eventBuffer[eventKey] = nil
    self:View(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted, hits)
end

function CombatTextCombatCloudEventViewer:View(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted, hits)
    local S = LUIE.CombatText.SV
    value = AbbreviateNumber(value, S.common.abbreviateNumbers)

    -- Control setup
    local panel = LUIE_CombatText_Outgoing
    if (combatType == CombatTextConstants.combatType.INCOMING) then panel = LUIE_CombatText_Incoming end
    local w, h = panel:GetDimensions()
    local radiusW, radiusH = w/2, h*2
    local offsetX, offsetY = nil, nil

    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) then
        offsetX, offsetY = math.random(-radiusW * .5, radiusW * .5), math.random(-radiusH * .5, radiusH * .5)
    elseif (isDot or isHot) then -- http://www.mathopenref.com/coordgeneralellipse.html
        offsetX = math.random(-radiusW * .95, radiusW * .95) -- Make radiusW a bit smaller to avoid horizontal animations
        offsetY = math.sqrt((radiusH) ^ 2 * (1 - (offsetX ^ 2 / (radiusW) ^ 2)))
        if (combatType == CombatTextConstants.combatType.OUTGOING) then offsetY = -offsetY end
    elseif (isDamage or isHealing or isEnergize or isDrain or isDamageShield or isBlocked) then
        offsetX, offsetY = math.random(-radiusW, radiusW), math.random(-radiusH * .5, radiusH)
    end

    local control, controlPoolKey = self.poolManager:GetPoolObject(CombatTextConstants.poolType.CONTROL)

    if (isDot or isHot) then
        control:SetAnchor(CENTER, panel, CENTER, 0, 0) -- Offsets are set in animation, not here
    else
        control:SetAnchor(CENTER, panel, CENTER, offsetX, offsetY)
    end

    -- Label setup in the correct order that the game handles damage
    local textFormat, fontSize, textColor = self:GetTextAtributes(powerType, damageType, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if (hits > 1 and S.toggles.showThrottleTrailer) then value = string.format('%s (%d)', value, hits) end
    if (combatType == CombatTextConstants.combatType.INCOMING) and (S.toggles.incomingDamageOverride) and (isDamage or isDamageCritical) then textColor = S.colors.incomingDamageOverride end

    self:PrepareLabel(control.label, fontSize, textColor, self:FormatString(textFormat, { text = abilityName, value = value, powerType = powerType, damageType = damageType }))
    self:ControlLayout(control, abilityId, combatType, sourceName)

    -- Animation setup
    local animationPoolType = CombatTextConstants.poolType.ANIMATION_CLOUD
    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) then animationPoolType = CombatTextConstants.poolType.ANIMATION_CLOUD_CRITICAL
    elseif (isDot or isHot) then animationPoolType = CombatTextConstants.poolType.ANIMATION_CLOUD_FIREWORKS end
    local animation, animationPoolKey = self.poolManager:GetPoolObject(animationPoolType)

    if (animationPoolType == CombatTextConstants.poolType.ANIMATION_CLOUD_FIREWORKS) then
        local moveStep = animation:GetStepByName('move')
        moveStep:SetDeltaOffsetX(offsetX)
        moveStep:SetDeltaOffsetY(offsetY)
    end

    animation:Apply(control)
    animation:Play()

    -- Add items back into pool after use
    zo_callLater(function()
        self.poolManager:ReleasePoolObject(CombatTextConstants.poolType.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
    end, animation:GetDuration())
end
