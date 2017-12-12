CombatCloud_ResourcesUltimateEventListener = CombatCloud_EventListener:Subclass()
local C = CombatCloudConstants
local GetSlotAbilityCost = GetSlotAbilityCost


function CombatCloud_ResourcesUltimateEventListener:New()
    local obj = CombatCloud_EventListener:New()
    obj:RegisterForEvent(EVENT_POWER_UPDATE, function(...) self:OnEvent(...) end, REGISTER_FILTER_UNIT_TAG, 'player', REGISTER_FILTER_POWER_TYPE, POWERTYPE_ULTIMATE)
    obj:RegisterForEvent(EVENT_ACTION_SLOTS_FULL_UPDATE, function() self:UpdateMaximum() end)
    obj:RegisterForEvent(EVENT_ACTION_SLOT_ABILITY_SLOTTED, function() self:UpdateMaximum() end)
    self.powerInfo = { maximum = 0, wasNotified = false }
    self:UpdateMaximum()
    return obj
end

function CombatCloud_ResourcesUltimateEventListener:OnEvent(unit, powerPoolIndex, powerType, power, powerMax)
    local S = LUIE.CombatText.SV
    if (power <= 0 or not S.toggles.showUltimate or self.powerInfo.maximum == 0) then
        return
    end

    -- Check if we need to show the notification
    if (power >= self.powerInfo.maximum) then
        if (not self.powerInfo.wasNotified) then
            self:TriggerEvent(C.eventType.RESOURCE, C.resourceType.ULTIMATE, power)
            self.powerInfo.wasNotified = true
        end
    else
        self.powerInfo.wasNotified = false
    end
end

function CombatCloud_ResourcesUltimateEventListener:UpdateMaximum()
    self.powerInfo.maximum = GetSlotAbilityCost(ACTION_BAR_ULTIMATE_SLOT_INDEX + 1)
end