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

    --[[
    --Cleanse is in the Combat listener
    if (alert == 1) then
        if (S.toggles.showAlertBlock) then
            self:TriggerEvent(C.eventType.ALERT, C.alertType.BLOCK, nil)
        end
        ]]--
    if (alert == 2) then
        if (S.toggles.showAlertExploit) and not exploitRefireDelay then
            self:TriggerEvent(C.eventType.ALERT, C.alertType.EXPLOIT, nil)
            exploitRefireDelay = true
            callLater(function() exploitRefireDelay = false end, 2000) --2 second buffer
        end
    end
    --[[
    elseif (alert == 3) then
        if (S.toggles.showAlertInterrupt) then
            self:TriggerEvent(C.eventType.ALERT, C.alertType.INTERRUPT, nil)
        end
    elseif (alert == 4) then
        if (S.toggles.showAlertDodge) then
            self:TriggerEvent(C.eventType.ALERT, C.alertType.DODGE, nil)
        end
    end

    ]]--
end
