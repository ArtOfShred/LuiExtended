CombatCloud_CrowdControlEventViewer = CombatCloud_EventViewer:Subclass()

local callLater = zo_callLater
local C = CombatCloudConstants
local L = CombatCloudLocalization
local poolTypes = CombatCloudConstants.poolType
local crowdControlTypes = CombatCloudConstants.crowdControlType

function CombatCloud_CrowdControlEventViewer:New(...)
    local obj = CombatCloud_EventViewer:New(...)
    obj:RegisterCallback(CombatCloudConstants.eventType.CROWDCONTROL, function(...) self:OnEvent(...) end)
    self.locationOffset = { [C.combatType.OUTGOING] = 0, [C.combatType.INCOMING] = 0 }
    self.activeCrowdControls = { [C.combatType.OUTGOING] = 0, [C.combatType.INCOMING] = 0 }
    return obj
end

function CombatCloud_CrowdControlEventViewer:OnEvent(crowdControlType, combatType)
    local S = LUIE.CombatText.SV

    --Label setup
    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)

    local size, color, text
    --Disoriented
    if (crowdControlType == crowdControlTypes.DISORIENTED) then
        color = S.colors.disoriented
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.disoriented, { text = L.disoriented })
    --Feared
    elseif (crowdControlType == crowdControlTypes.FEARED) then
        color = S.colors.feared
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.feared, { text = L.feared })
    --Off Balanced
    elseif (crowdControlType == crowdControlTypes.OFFBALANCED) then
        color = S.colors.offBalanced
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.offBalanced, { text = L.offBalanced })
    --Silenced
    elseif (crowdControlType == crowdControlTypes.SILENCED) then
        color = S.colors.silenced
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.silenced, { text = L.silenced })
    --Stunned
    elseif (crowdControlType == crowdControlTypes.STUNNED) then
        color = S.colors.stunned
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.stunned, { text = L.stunned })
    end

    self:PrepareLabel(control.label, size, color, text)
    self:ControlLayout(control)

    --Control setup
    local panel, point, relativePoint = CombatCloud_Outgoing, TOP, BOTTOM
    if (combatType == C.combatType.INCOMING) then
        panel = CombatCloud_Incoming
        if (S.animation.incoming.directionType == 'down') then
            point, relativePoint = BOTTOM, TOP
        end
    else
        if (S.animation.outgoing.directionType == 'down') then
            point, relativePoint = BOTTOM, TOP
        end
    end

    if (point == TOP) then
        control:SetAnchor(point, panel, relativePoint, 0, -(self.locationOffset[combatType] * (S.fontSizes.crowdControl + 5)))
    else
        control:SetAnchor(point, panel, relativePoint, 0, self.locationOffset[combatType] * (S.fontSizes.crowdControl + 5))
    end
    
    self.locationOffset[combatType] = self.locationOffset[combatType] + 1
    self.activeCrowdControls[combatType] = self.activeCrowdControls[combatType] + 1

    --Get animation
    local animationPoolType = poolTypes.ANIMATION_SCROLL_CRITICAL
    local animation, animationPoolKey = self.poolManager:GetPoolObject(animationPoolType)
    animation:Apply(control)
    animation:Play()

    --Add items back into pool after animation
    callLater(function()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
        self.activeCrowdControls[combatType] = self.activeCrowdControls[combatType] - 1
        if (self.activeCrowdControls[combatType] == 0) then self.locationOffset[combatType] = 0 end
    end, animation:GetDuration())
end