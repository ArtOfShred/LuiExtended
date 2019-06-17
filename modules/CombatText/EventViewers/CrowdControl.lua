--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextCrowdControlEventViewer = LUIE.CombatTextEventViewer:Subclass()
local CombatTextEventViewer = LUIE.CombatTextCrowdControlEventViewer

local poolTypes = LUIE.Data.CombatTextConstants.poolType
local eventType = LUIE.Data.CombatTextConstants.eventType
local combatType = LUIE.Data.CombatTextConstants.combatType
local crowdControlTypes = LUIE.Data.CombatTextConstants.crowdControlType

function CombatTextEventViewer:New(...)
    local obj = LUIE.CombatTextEventViewer:New(...)
    obj:RegisterCallback(eventType.CROWDCONTROL, function(...) self:OnEvent(...) end)
    self.locationOffset = { [combatType.OUTGOING] = 0, [combatType.INCOMING] = 0 }
    self.activeCrowdControls = { [combatType.OUTGOING] = 0, [combatType.INCOMING] = 0 }
    return obj
end

function CombatTextEventViewer:OnEvent(crowdControlType, combatType)
    local S = LUIE.CombatText.SV

    --Label setup
    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)

    local size, color, text
    --Disoriented
    if (crowdControlType == crowdControlTypes.DISORIENTED) then
        color = S.colors.disoriented
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.disoriented, { text = GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED) })
    --Feared
    elseif (crowdControlType == crowdControlTypes.FEARED) then
        color = S.colors.feared
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.feared, { text = GetString(SI_LUIE_LAM_CT_SHARED_FEARED) })
    --Off Balanced
    elseif (crowdControlType == crowdControlTypes.OFFBALANCED) then
        color = S.colors.offBalanced
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.offBalanced, { text = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE) })
    --Silenced
    elseif (crowdControlType == crowdControlTypes.SILENCED) then
        color = S.colors.silenced
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.silenced, { text = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED) })
    --Stunned
    elseif (crowdControlType == crowdControlTypes.STUNNED) then
        color = S.colors.stunned
        size = S.fontSizes.crowdControl
        text = self:FormatString(S.formats.stunned, { text = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED) })
    end

    self:PrepareLabel(control.label, size, color, text)
    self:ControlLayout(control)

    --Control setup
    local panel, point, relativePoint = LUIE_CombatText_Outgoing, TOP, BOTTOM
    if (combatType == combatType.INCOMING) then
        panel = LUIE_CombatText_Incoming
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
    zo_callLater(function()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
        self.activeCrowdControls[combatType] = self.activeCrowdControls[combatType] - 1
        if (self.activeCrowdControls[combatType] == 0) then
            self.locationOffset[combatType] = 0
        end
    end, animation:GetDuration())
end
