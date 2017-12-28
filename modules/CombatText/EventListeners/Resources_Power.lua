LUIE.CombatTextResourcesPowerEventListener = LUIE.CombatTextEventListener:Subclass()
local CTL = LUIE.CombatTextResourcesPowerEventListener

function CTL:New()
    local obj = LUIE.CombatTextEventListener:New()
    obj:RegisterForEvent(EVENT_POWER_UPDATE, function(...) self:OnEvent(...) end)
    self.powerInfo = {
        [POWERTYPE_HEALTH]  = { wasWarned = false, resourceType = LUIE.CombatTextConstants.resourceType.LOW_HEALTH },
        [POWERTYPE_STAMINA] = { wasWarned = false, resourceType = LUIE.CombatTextConstants.resourceType.LOW_STAMINA },
        [POWERTYPE_MAGICKA] = { wasWarned = false, resourceType = LUIE.CombatTextConstants.resourceType.LOW_MAGICKA }
    }
    self.executeAlerts = {}
    return obj
end

function CTL:OnEvent(unit, powerPoolIndex, powerType, power, powerMax)
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
            self:TriggerEvent(LUIE.CombatTextConstants.eventType.RESOURCE, self.powerInfo[powerType].resourceType, power)
            self.powerInfo[powerType].wasWarned = true
        elseif (percent > threshold + 10) then -- Add 10 to create some sort of buffer, else the warning can fire more than once depending on the power regen of the player
            self.powerInfo[powerType].wasWarned = false
        end
    --EXECUTE ALERT
    elseif (LUIE.CombatText.SV.toggles.showAlertExecute and unit == 'reticleover' and powerType == POWERTYPE_HEALTH and IsUnitAttackable('reticleover') and GetUnitReaction('reticleover') ~= UNIT_REACTION_NEUTRAL and not IsUnitDead('reticleover')) then
        local threshold = LUIE.CombatText.SV.executeThreshold or 20
        local alertFrequency = LUIE.CombatText.SV.executeFrequency or 8
        local unitName = GetRawUnitName('reticleover')

        local percent = power / powerMax * 100
        local now = GetFrameTimeSeconds()
        local alertTime = self.executeAlerts[unitName] or 0

        if percent <= threshold then
            if now - alertTime > alertFrequency then
                self:TriggerEvent(LUIE.CombatTextConstants.eventType.ALERT, LUIE.CombatTextConstants.alertType.EXECUTE, zo_round(percent))
                self.executeAlerts[unitName] = now
            end
        else
            for name, alertTime in pairs(self.executeAlerts) do
                if now - alertTime > alertFrequency then
                    self.executeAlerts[name] = nil
                end
            end
        end
    end
end