--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextResourcesPowerEventListener = LUIE.CombatTextEventListener:Subclass()
local CombatTextResourcesPowerEventListener = LUIE.CombatTextResourcesPowerEventListener

local eventType = LUIE.Data.CombatTextConstants.eventType

function CombatTextResourcesPowerEventListener:New()
    local obj = LUIE.CombatTextEventListener:New()
    obj:RegisterForEvent(EVENT_POWER_UPDATE, function(...) self:OnEvent(...) end)
    self.powerInfo = {
        [POWERTYPE_HEALTH]  = { wasWarned = false, resourceType = LUIE.Data.CombatTextConstants.resourceType.LOW_HEALTH },
        [POWERTYPE_STAMINA] = { wasWarned = false, resourceType = LUIE.Data.CombatTextConstants.resourceType.LOW_STAMINA },
        [POWERTYPE_MAGICKA] = { wasWarned = false, resourceType = LUIE.Data.CombatTextConstants.resourceType.LOW_MAGICKA }
    }
    return obj
end

function CombatTextResourcesPowerEventListener:OnEvent(unit, powerPoolIndex, powerType, power, powerMax)
    if (unit == 'player' and self.powerInfo[powerType] ~= nil) then
        local t = LUIE.CombatText.SV.toggles
        local threshold

        if power <= 0 then
            return
        elseif powerType == POWERTYPE_HEALTH then
            if not t.showLowHealth then return end
            threshold = LUIE.CombatText.SV.healthThreshold or 35
        elseif powerType == POWERTYPE_STAMINA then
            if not t.showLowStamina then return end
            threshold = LUIE.CombatText.SV.staminaThreshold or 35
        elseif powerType == POWERTYPE_MAGICKA then
            if not t.showLowMagicka then return end
            threshold = LUIE.CombatText.SV.magickaThreshold or 35
        end

        local percent = power / powerMax * 100

        -- Check if we need to show the warning, else clear the warning
        if (percent < threshold and not self.powerInfo[powerType].wasWarned) then
            self:TriggerEvent(eventType.RESOURCE, self.powerInfo[powerType].resourceType, power)
            self.powerInfo[powerType].wasWarned = true
        elseif (percent > threshold + 10) then -- Add 10 to create some sort of buffer, else the warning can fire more than once depending on the power regen of the player
            self.powerInfo[powerType].wasWarned = false
        end
    end
end
