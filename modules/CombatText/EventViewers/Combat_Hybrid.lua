LUIE.CombatTextCombatHybridEventViewer = LUIE.CombatTextEventViewer:Subclass()
local CTV = LUIE.CombatTextCombatHybridEventViewer

local strfmt     = string.format
local mathrandom = math.random
local mathmin    = math.min
local mathmax    = math.max
local tostring   = tostring

local callLater = zo_callLater
local C = LUIE.CombatTextConstants
local poolTypes = C.poolType

function CTV:New(...)
    local obj = LUIE.CombatTextEventViewer:New(...)
    obj:RegisterCallback(C.eventType.COMBAT, function(...) self:OnEvent(...) end)
    self.eventBuffer = {}
    self.activeControls = { [C.combatType.OUTGOING] = {}, [C.combatType.INCOMING] = {} }
    self.lastControl = {}
    return obj
end

function CTV:OnEvent(combatType, powerType, value, abilityName, abilityId, damageType, sourceName, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if (LUIE.CombatText.SV.animation.animationType ~= 'hybrid') then return end

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

    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)

    local textFormat, fontSize, textColor = self:GetTextAtributes(powerType, damageType, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if (hits > 1 and S.toggles.showThrottleTrailer) then
        value = strfmt('%d (%d)', value, hits)
    end
    if (combatType == C.combatType.INCOMING) and (S.toggles.incomingDamageOverride) and (isDamage or isDamageCritical) then
        textColor = S.colors.incomingDamageOverride
    end

    self:PrepareLabel(control.label, fontSize, textColor, self:FormatString(textFormat, { text = LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name or abilityName, value = value, powerType = powerType, damageType = damageType }))
    self:ControlLayout(control, abilityId, combatType, sourceName)

    -- Control setup
    local panel, point, relativePoint = LUIE_CombatText_Outgoing, TOP, BOTTOM
    if (combatType == C.combatType.INCOMING) then
        panel = LUIE_CombatText_Incoming
        if (S.animation.incoming.directionType == 'down') then
            point, relativePoint = BOTTOM, TOP
        end
    else
        if (S.animation.outgoing.directionType == 'down') then
            point, relativePoint = BOTTOM, TOP
        end
    end

    local w, h = panel:GetDimensions()
    local radiusW, radiusH = w / 4, h / 4
    local offsetX, offsetY = 0, 0

    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) then offsetX = mathrandom(-radiusW, radiusW)
    elseif (isDot or isHot) then offsetX = mathrandom(-radiusW, radiusW)
    elseif (isDamage or isHealing or isEnergize or isDrain or isDamageShield or isBlocked) then offsetX = mathrandom(-radiusW, radiusW) end

    if (point == TOP) then
        if (self.lastControl[combatType] == nil) then
            offsetY = -25
        else
            offsetY = mathmax(-25, select(6, self.lastControl[combatType]:GetAnchor(0)))
        end
        control:SetAnchor(point, panel, relativePoint, offsetX, offsetY)

        if (offsetY < 75 and self:IsOverlapping(control, self.activeControls[combatType])) then
            control:ClearAnchors()
            offsetY = select(6, self.lastControl[combatType]:GetAnchor(0)) + (fontSize * 1.5)
            control:SetAnchor(point, panel, relativePoint, offsetX, offsetY)
        end
    else
        if (self.lastControl[combatType] == nil) then
            offsetY = 25
        else
            offsetY = mathmin(25, select(6, self.lastControl[combatType]:GetAnchor(0)))
        end
        control:SetAnchor(point, panel, relativePoint, offsetX, offsetY)

        if (offsetY > -75 and self:IsOverlapping(control, self.activeControls[combatType])) then
            control:ClearAnchors()
            offsetY = select(6, self.lastControl[combatType]:GetAnchor(0)) - (fontSize * 1.5)
            control:SetAnchor(point, panel, relativePoint, offsetX, offsetY)
        end
    end

    self.activeControls[combatType][control:GetName()] = control
    self.lastControl[combatType] = control

    -- Animation setup
    local animationPoolType = poolTypes.ANIMATION_SCROLL
    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) then
        animationPoolType = poolTypes.ANIMATION_SCROLL_CRITICAL
    end

    local animation, animationPoolKey = self.poolManager:GetPoolObject(animationPoolType)

    local targetY = h + 250
    if (point == TOP) then targetY = -targetY end
    animation:GetStepByName('scroll'):SetDeltaOffsetY(targetY)

    animation:Apply(control)
    animation:Play()

    -- Add items back into pool after use
    callLater(function()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
        self.activeControls[combatType][control:GetName()] = nil
        if (self.lastControl[combatType] == control) then
            self.lastControl[combatType] = nil
        end
    end, animation:GetDuration())
end
