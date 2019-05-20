--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextPointsExperienceEventListener = LUIE.CombatTextEventListener:Subclass()
local CTL = LUIE.CombatTextPointsExperienceEventListener

local callLater = zo_callLater

function CTL:New()
    local obj = LUIE.CombatTextEventListener:New()
    obj:RegisterForEvent(EVENT_EXPERIENCE_UPDATE, function(...) self:OnEvent(...) end, REGISTER_FILTER_UNIT_TAG, 'player')
    self.gain = 0
    self.timeoutActive = false
    self.isChampion = IsUnitChampion('player')
    if (self.isChampion) then
        local earned = GetPlayerChampionPointsEarned()
        if earned < 3600 then
            self.previousXp = GetPlayerChampionXP()
            self.previousMaxXp = GetNumChampionXPInChampionPoint(earned)
        end
    end
    self.previousXp = self.previousXp or GetUnitXP('player')
    self.previousMaxXp = self.previousMaxXp or GetUnitXPMax('player')
    return obj
end

function CTL:OnEvent(unit, currentXp, maxXp)
    if LUIE.CombatText.SV.toggles.showPointsExperience then
        self.isChampion = IsUnitChampion('player')
        if (self.isChampion) then
            local earned = GetPlayerChampionPointsEarned()
            if earned < 3600 then
                maxXp = GetNumChampionXPInChampionPoint(earned)
                if (maxXp ~= nil) then
                    currentXp = GetPlayerChampionXP()
                end
            end
        end

        -- Calculate gained xp
        if (maxXp ~= self.previousMaxXp) or (currentXp < self.previousXp) then
            self.gain = self.gain + (self.previousMaxXp - self.previousXp + currentXp)
        else
            self.gain = self.gain + (currentXp - self.previousXp)
        end

        -- Remember values
        self.previousXp = currentXp
        self.previousMaxXp = maxXp

        -- Trigger custom event (500ms buffer)
        if (self.gain > 0 and not self.timeoutActive) then
            self.timeoutActive = true
            callLater(function()
                self:TriggerEvent(LUIE.CombatTextConstants.eventType.POINT, LUIE.CombatTextConstants.pointType.EXPERIENCE_POINTS, self.gain)
                self.gain = 0
                self.timeoutActive = false
            end, 500)
        end
    end
end
