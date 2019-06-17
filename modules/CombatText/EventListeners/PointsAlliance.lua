--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextPointsAllianceEventListener = LUIE.CombatTextEventListener:Subclass()
local CombatTextEventListener = LUIE.CombatTextPointsAllianceEventListener

local eventType = LUIE.Data.CombatTextConstants.eventType
local pointType = LUIE.Data.CombatTextConstants.pointType

function CombatTextEventListener:New()
    local obj = LUIE.CombatTextEventListener:New()
    obj:RegisterForEvent(EVENT_ALLIANCE_POINT_UPDATE, function(...) self:OnEvent(...) end)
    return obj
end

function CombatTextEventListener:OnEvent(alliancePoints, playSound, difference)
    if (LUIE.CombatText.SV.toggles.showPointsAlliance) then
        self:TriggerEvent(eventType.POINT, pointType.ALLIANCE_POINTS, difference)
    end
end
