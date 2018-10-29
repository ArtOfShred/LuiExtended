LUIE.CombatTextDeathListener = LUIE.CombatTextEventListener:Subclass()
local CTD = LUIE.CombatTextDeathListener

function CTD:New()
    local obj = LUIE.CombatTextEventListener:New()
	obj:RegisterForEvent(EVENT_UNIT_DEATH_STATE_CHANGED, function(...) self:OnEvent(...) end, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")
    return obj
end

function CTL:OnEvent(eventCode, unitTag, isDead)
	if (LUIE.CombatText.SV.toggles.showDeath) then
		if isDead and "group" == string.sub(unitTag, 0, 5) then -- when group member dies
			self:TriggerEvent(LUIE.CombatTextConstants.eventType.DEATH, LUIE.CombatTextConstants.point
			CI.FireCombatEvent( eventCode, 'custom', false, '', '', 0, '', COMBAT_UNIT_TYPE_PLAYER, GetUnitName(unitTag), 'unitDeath', 1, 0, 0, false, 0, 0, 0 )
		end
	end
end
