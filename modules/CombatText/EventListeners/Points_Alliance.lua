LUIE.CombatTextPointsAllianceEventListener = LUIE.CombatTextEventListener:Subclass()
local CTL = LUIE.CombatTextPointsAllianceEventListener

function CTL:New()
    local obj = LUIE.CombatTextEventListener:New()
    obj:RegisterForEvent(EVENT_ALLIANCE_POINT_UPDATE, function(...) self:OnEvent(...) end)
    return obj
end

function CTL:OnEvent(alliancePoints, playSound, difference)
    if (LUIE.CombatText.SV.toggles.showPointsAlliance) then
        self:TriggerEvent(LUIE.CombatTextConstants.eventType.POINT, LUIE.CombatTextConstants.pointType.ALLIANCE_POINTS, difference)
    end
end