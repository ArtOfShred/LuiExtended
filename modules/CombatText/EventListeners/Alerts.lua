--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextAlertEventListener = LUIE.CombatTextEventListener:Subclass()
local CTL = LUIE.CombatTextAlertEventListener

local C = LUIE.CombatTextConstants
local callLater = zo_callLater
local exploitRefireDelay = false

function CTL:New()
    local obj = LUIE.CombatTextEventListener:New()
    obj:RegisterForEvent(EVENT_DISPLAY_ACTIVE_COMBAT_TIP, function(...) self:OnEvent(...) end)
    return obj
end

function CTL:OnEvent(tipId)
    local S = LUIE.CombatText.SV
    local alert = tipId

    if (alert == 2) then
        if (S.toggles.showAlertExploit) and not exploitRefireDelay then
            self:TriggerEvent(C.eventType.ALERT, C.alertType.EXPLOIT, nil)
            exploitRefireDelay = true
            callLater(function() exploitRefireDelay = false end, 2000) --2 second buffer
        end
    end
end
