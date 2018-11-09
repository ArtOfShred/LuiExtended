LUIE.CombatTextDeathListener = LUIE.CombatTextEventListener:Subclass()
local CTL = LUIE.CombatTextDeathListener

function CTL:New()
    local obj = LUIE.CombatTextEventListener:New()
	obj:RegisterForEvent(EVENT_UNIT_DEATH_STATE_CHANGED, function(...) self:OnEvent(...) end, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")
    return obj
end

function CTL:OnEvent(unitTag, isDead)
	if (LUIE.CombatText.SV.toggles.showDeath) then
		if isDead and "group" == string.sub(unitTag, 0, 5) then -- when group member dies
            if GetUnitName(unitTag) ~= GetUnitName("player") then
                self:TriggerEvent(LUIE.CombatTextConstants.eventType.DEATH, unitTag)
            end
		end
	end
end
