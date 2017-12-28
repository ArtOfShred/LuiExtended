LUIE.CombatTextResourcesPotionEventListener = LUIE.CombatTextEventListener:Subclass()
local CTL = LUIE.CombatTextResourcesPotionEventListener
local callLater = zo_callLater

function CTL:New()
    local C = LUIE.CombatTextConstants
    local t = LUIE.CombatText.SV.toggles
    local actionButton = ZO_ActionBar_GetButton(ACTION_BAR_FIRST_UTILITY_BAR_SLOT + 1)
    local UpdateCooldown_Orig = actionButton.UpdateCooldown

    self.inCooldown = false

    local function UpdateCooldown_Hook(button, ...)
        UpdateCooldown_Orig(button, ...)
        
        local slotNum = button:GetSlot()
        
        if (GetSlotItemSound(slotNum) == ITEM_SOUND_CATEGORY_POTION) then
            if (not self.inCooldown and button.inCooldown) then
                local cooldown = button.cooldown:GetTimeLeft()
            
                if (cooldown > 0) then
                    self.inCooldown = true
                    local slotName = zo_strformat(SI_LINK_FORMAT_ITEM_NAME, GetSlotName(slotNum))
                    callLater(function()
                        self:TriggerEvent(C.eventType.RESOURCE, C.resourceType.POTION, slotName)
                        self.inCooldown = false
                    end, cooldown)
                end
            end  
        end
    end

    actionButton.UpdateCooldown = UpdateCooldown_Hook
end
