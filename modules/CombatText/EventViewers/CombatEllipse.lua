--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextCombatEllipseEventViewer = LUIE.CombatTextEventViewer:Subclass()
local CTV = LUIE.CombatTextCombatEllipseEventViewer

local C = LUIE.CombatTextConstants
local AbbreviateNumber = LUIE.AbbreviateNumber

local strfmt = string.format
local callLater = zo_callLater

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
    if (LUIE.CombatText.SV.animation.animationType ~= 'ellipse') then return end

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
    value = AbbreviateNumber(value, S.common.abbreviateNumbers)

    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)

    local textFormat, fontSize, textColor = self:GetTextAtributes(powerType, damageType, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    if (hits > 1 and S.toggles.showThrottleTrailer) then
        value = strfmt('%s (%d)', value, hits)
    end
    if (combatType == C.combatType.INCOMING) and (S.toggles.incomingDamageOverride) and (isDamage or isDamageCritical) then
        textColor = S.colors.incomingDamageOverride
    end

    self:PrepareLabel(control.label, fontSize, textColor, self:FormatString(textFormat, { text = abilityName, value = value, powerType = powerType, damageType = damageType }))
    self:ControlLayout(control, abilityId, combatType, sourceName)

    -- Control setup
    local panel, point, relativePoint = LUIE_CombatText_Outgoing, BOTTOMRIGHT, TOPRIGHT
    if (combatType == C.combatType.INCOMING) then
        panel = LUIE_CombatText_Incoming
        if (S.animation.incoming.directionType == 'up') then
            point, relativePoint = TOPRIGHT, BOTTOMRIGHT
        end
    else
        if (S.animation.outgoing.directionType == 'up') then
            point, relativePoint = TOPRIGHT, BOTTOMRIGHT
        end
    end

    local offsetX, targetX = 0, -1
    local offsetY, targetY = 0, 1

    if (isDot or isHot or isEnergize or isDrain or isMiss or isImmune or isParried or isReflected or isDamageShield or isDodged or isBlocked or isInterrupted) then
        offsetY, targetY, targetX = 0.2, 0.8, -0.8
    end

    if (point == TOPRIGHT or point == TOPLEFT) then
        offsetY, targetY = -offsetY, -targetY
    end

--- Anchor points: -----------------------------
--  3 .. 1 .. 9
--  .    .    .
--  2 ..128.. 8
--  .    .    .
--  6 .. 4 .. 12
--
--  TOP + LEFT     = TOPLEFT     (1 + 2 = 3)
--  TOP + RIGHT    = TOPRIGHT    (1 + 8 = 9)
--  BOTTOM + LEFT  = BOTTOMLEFT  (4 + 2 = 6)
--  BOTTOM + RIGHT = BOTTOMRIGHT (4 + 8 = 12)
-------------------------------------------------

    if (panel:GetCenter()) > GuiRoot:GetWidth() / 2 then
        point, relativePoint = point - RIGHT + LEFT, relativePoint - RIGHT + LEFT
        targetX = -targetX
    end

    local w, h = panel:GetDimensions()
    control:SetAnchor(point, panel, relativePoint, offsetX * w, offsetY * h)

    if (point == TOPRIGHT or point == TOPLEFT) then
        if (self.lastControl[combatType] == nil) then
            offsetY = -25
        else
            offsetY = math.max(-25, select(6, self.lastControl[combatType]:GetAnchor(0)))
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
            offsetY = math.min(25, select(6, self.lastControl[combatType]:GetAnchor(0)))
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

    -- Animation Setup
    local animationXPoolType, animationYPoolType
    if (isDamageCritical or isHealingCritical or isDotCritical or isHotCritical) then
        animationXPoolType = poolTypes.ANIMATION_ELLIPSE_X_CRIT
        animationYPoolType = poolTypes.ANIMATION_ELLIPSE_Y_CRIT
    else
        animationXPoolType = poolTypes.ANIMATION_ELLIPSE_X
        animationYPoolType = poolTypes.ANIMATION_ELLIPSE_Y
    end

    local animationX, animationXPoolKey = self.poolManager:GetPoolObject(animationXPoolType)
    animationX:GetStepByName('scrollX'):SetDeltaOffsetX(targetX * (w * .35) )
    animationX:Apply(control.icon)
    animationX:Play()

    local animationY, animationYPoolKey = self.poolManager:GetPoolObject(animationYPoolType)
    local verticalOffset = (targetY * h + 550)
    if (point == TOPRIGHT or point == TOPLEFT) then
        verticalOffset = -verticalOffset
    end
    animationY:GetStepByName('scrollY'):SetDeltaOffsetY(verticalOffset)
    animationY:Apply(control)
    animationY:Play()

    -- Add items back into pool after use
    callLater(function()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationXPoolType, animationXPoolKey)
        self.poolManager:ReleasePoolObject(animationYPoolType, animationYPoolKey)
        self.activeControls[combatType][control:GetName()] = nil
        if (self.lastControl[combatType] == control) then
            self.lastControl[combatType] = nil
        end
    end, animationY:GetDuration())
end
