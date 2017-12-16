CombatCloud_ResourceEventViewer = CombatCloud_EventViewer:Subclass()

local L = CombatCloudLocalization
local callLater = zo_callLater
local poolTypes = CombatCloudConstants.poolType
local resourceTypes = CombatCloudConstants.resourceType

function CombatCloud_ResourceEventViewer:New(...)
    local obj = CombatCloud_EventViewer:New(...)
    obj:RegisterCallback(CombatCloudConstants.eventType.RESOURCE, function(...) self:OnEvent(...) end)
    self.locationOffset = 0 -- Simple way to avoid overlapping. When number of active notes is back to 0, the offset is also reset
    self.activeResources = 0
    return obj
end

function CombatCloud_ResourceEventViewer:OnEvent(resourceType, value)
    local S = LUIE.CombatText.SV

    --Label setup
    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)

    local size, color, text
    --Low Health
    if (resourceType == resourceTypes.LOW_HEALTH) then
        color = S.colors.lowHealth
        size = S.fontSizes.resource
        text = self:FormatString(S.formats.resource, { value = value, text = GetString(SI_LUIE_LAM_CT_SHARED_LOW_HEALTH) })
    --Low Magicka
    elseif (resourceType == resourceTypes.LOW_MAGICKA) then
        color = S.colors.lowMagicka
        size = S.fontSizes.resource
        text = self:FormatString(S.formats.resource, { value = value, text = GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA) })
    --Low Stamina
    elseif (resourceType == resourceTypes.LOW_STAMINA) then
        color = S.colors.lowStamina
        size = S.fontSizes.resource
        text = self:FormatString(S.formats.resource, { value = value, text = GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA) })
    --Ultimate Ready
    elseif (resourceType == resourceTypes.ULTIMATE) then
        color = S.colors.ultimateReady
        size = S.fontSizes.resource
        text = self:FormatString(S.formats.ultimateReady, { text = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY) })
    elseif (resourceType == resourceTypes.POTION) then
        color = S.colors.potionReady
        size = S.fontSizes.resource
        text = self:FormatString(S.formats.potionReady, { text = GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY) })
    end

    self:PrepareLabel(control.label, size, color, text)
    self:ControlLayout(control)

    --Control setup
    control:SetAnchor(CENTER, CombatCloud_Resource, TOP, 0, self.locationOffset * (S.fontSizes.resource + 5))
    self.locationOffset = self.locationOffset + 1
    self.activeResources = self.activeResources + 1

    --Get animation
    local animationPoolType = poolTypes.ANIMATION_RESOURCE
    if (resourceType == resourceTypes.LOW_HEALTH or resourceType == resourceTypes.LOW_MAGICKA or resourceType == resourceTypes.LOW_STAMINA) then
        animationPoolType = poolTypes.ANIMATION_RESOURCE
    end
    local animation, animationPoolKey = self.poolManager:GetPoolObject(animationPoolType)
    animation:Apply(control)
    animation:Play()

    --Warning sound
    if S.toggles.warningSound then
        if resourceType == resourceTypes.LOW_HEALTH or resourceType == resourceTypes.LOW_STAMINA or resourceType == resourceTypes.LOW_MAGICKA then
            PlaySound('Quest_StepFailed')
        end
    end

    --Add items back into pool after animation
    callLater(function()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
        self.activeResources = self.activeResources - 1
        if (self.activeResources == 0) then self.locationOffset = 0 end
    end, animation:GetDuration())
end