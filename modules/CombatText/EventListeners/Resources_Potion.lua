LUIE.CombatTextResourcesPotionEventListener = LUIE.CombatTextEventListener:Subclass()
local CTL = LUIE.CombatTextResourcesPotionEventListener
local inCooldown = false

function CTL:New()
	local obj = LUIE.CombatTextEventListener:New()
	obj:RegisterForUpdate("PotionCooldown", 100, function() self:PotionCooldown() end)
	return obj
end

function CTL:PotionCooldown()
	local t = LUIE.CombatText.SV.toggles
	if not t.showPotionReady then return end
	
	local slotIndex = GetCurrentQuickslot()
	if (GetSlotItemSound(slotIndex) == ITEM_SOUND_CATEGORY_POTION) then
        local _, duration = GetSlotCooldownInfo( slotIndex )
		local isInCooldown = duration > 0
		
		if isInCooldown then
			if inCooldown == false and duration > 5000 then inCooldown = true end
		else
			if inCooldown == true then
				local C = LUIE.CombatTextConstants
				local slotName = zo_strformat(SI_LINK_FORMAT_ITEM_NAME, GetSlotName(slotNum))
				self:TriggerEvent(C.eventType.RESOURCE, C.resourceType.POTION, slotName)
				inCooldown = false
			end
		end
    end
end
