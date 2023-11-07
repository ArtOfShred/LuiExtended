--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local Debug = LUIE.Debug
local Info = LUIE.Info
local Error = LUIE.Error
local Warn = LUIE.Warn

LUIE.CombatTextResourceEventViewer = LUIE.CombatTextEventViewer:Subclass()
local CombatTextResourceEventViewer = LUIE.CombatTextResourceEventViewer

local poolTypes = LUIE.Data.CombatTextConstants.poolType
local eventType = LUIE.Data.CombatTextConstants.eventType
local resourceTypes = LUIE.Data.CombatTextConstants.resourceType

function CombatTextResourceEventViewer:New(...)
    local obj = LUIE.CombatTextEventViewer:New(...)
    obj:RegisterCallback(eventType.RESOURCE, function (...)
        self:OnEvent(...)
    end)
    self.locationOffset = 0 -- Simple way to avoid overlapping. When number of active notes is back to 0, the offset is also reset
    self.activeResources = 0
    return obj
end

function CombatTextResourceEventViewer:OnEvent(resourceType, value)
    local Settings = LUIE.CombatText.SV
    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)
    local size, color, text

    local function prepareLabelText(format, params)
        color = params.color
        size = params.size
        text = self:FormatString(format, params)
    end

    local function playAnimation(animationPoolType)
        local animation, animationPoolKey = self.poolManager:GetPoolObject(animationPoolType)
        animation:Apply(control)
        animation:Play()
        zo_callLater(function ()
            self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
            self.activeResources = self.activeResources - 1
            if self.activeResources == 0 then
                self.locationOffset = 0
            end
        end, animation:GetDuration())
    end

    -- Low Health
    if resourceType == resourceTypes.LOW_HEALTH then
        prepareLabelText(Settings.formats.resourceHealth, {
            value = value,
            text = GetString(LUIE_STRING_LAM_CT_SHARED_LOW_HEALTH),
            color = Settings.colors.lowHealth,
            size = Settings.fontSizes.resource,
        })
        playAnimation(poolTypes.ANIMATION_RESOURCE)
        -- Low Magicka
    elseif resourceType == resourceTypes.LOW_MAGICKA then
        prepareLabelText(Settings.formats.resourceMagicka, {
            value = value,
            text = GetString(LUIE_STRING_LAM_CT_SHARED_LOW_MAGICKA),
            color = Settings.colors.lowMagicka,
            size = Settings.fontSizes.resource,
        })
        playAnimation(poolTypes.ANIMATION_RESOURCE)
        -- Low Stamina
    elseif resourceType == resourceTypes.LOW_STAMINA then
        prepareLabelText(Settings.formats.resourceStamina, {
            value = value,
            text = GetString(LUIE_STRING_LAM_CT_SHARED_LOW_STAMINA),
            color = Settings.colors.lowStamina,
            size = Settings.fontSizes.resource,
        })
        playAnimation(poolTypes.ANIMATION_RESOURCE)
        -- Ultimate Ready
    elseif resourceType == resourceTypes.ULTIMATE then
        prepareLabelText(Settings.formats.ultimateReady, {
            text = GetString(LUIE_STRING_LAM_CT_SHARED_ULTIMATE_READY),
            color = Settings.colors.ultimateReady,
            size = Settings.fontSizes.readylabel,
        })
        playAnimation(poolTypes.ANIMATION_RESOURCE)
        -- Potion Ready
    elseif resourceType == resourceTypes.POTION then
        prepareLabelText(Settings.formats.potionReady, {
            text = GetString(LUIE_STRING_LAM_CT_SHARED_POTION_READY),
            color = Settings.colors.potionReady,
            size = Settings.fontSizes.readylabel,
        })
        playAnimation(poolTypes.ANIMATION_RESOURCE)
    end

    self:PrepareLabel(control.label, size, color, text)
    self:ControlLayout(control)
    control:SetAnchor(CENTER, LUIE_CombatText_Resource, TOP, 0, self.locationOffset * (Settings.fontSizes.resource + 5))
    self.locationOffset = self.locationOffset + 1
    self.activeResources = self.activeResources + 1

    if self.locationOffset == 4 then
        self.locationOffset = 0
    end

    if Settings.toggles.warningSound then
        if resourceType == resourceTypes.LOW_HEALTH or resourceType == resourceTypes.LOW_STAMINA or resourceType == resourceTypes.LOW_MAGICKA then
            PlaySound("Quest_StepFailed")
        end
    end

    coroutine.wrap(function ()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
    end)
    collectgarbage("step")
end
