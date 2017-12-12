CombatCloud_PointsAllianceEventListener = CombatCloud_EventListener:Subclass()

function CombatCloud_PointsAllianceEventListener:New()
    local obj = CombatCloud_EventListener:New()
    obj:RegisterForEvent(EVENT_ALLIANCE_POINT_UPDATE, function(...) self:OnEvent(...) end)
    return obj
end

function CombatCloud_PointsAllianceEventListener:OnEvent(alliancePoints, playSound, difference)
    if (LUIE.CombatText.SV.toggles.showPointsAlliance) then
        self:TriggerEvent(CombatCloudConstants.eventType.POINT, CombatCloudConstants.pointType.ALLIANCE_POINTS, difference)
    end
end