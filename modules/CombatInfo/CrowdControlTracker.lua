--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- CombatInfo namespace
local CI = LUIE.CombatInfo
LUIE.CI.CrowdControlTracker = {}
local CCT = LUIE.CI.CrowdControlTracker

-- REMOVE AS NEEDED
local UI = LUIE.UI
local E = LUIE.Effects
local CBT = LUIE.CastBarTable
local A = LUIE.GetAbility()

local printToChat = LUIE.PrintToChat
local strfmt = string.format
local strformat = zo_strformat
local callLater = zo_callLater

local eventManager  = EVENT_MANAGER
local sceneManager  = SCENE_MANAGER
local windowManager = WINDOW_MANAGER

local moduleName = LUIE.name .. "_CombatInfo"

----------------------------------
----------------------------------
----------------------------------

local PriorityOne, PriorityTwo, PriorityThree, PriorityFour, PrioritySix

local CCT_STAGGER_DURATION = 800
local CCT_AREA_DURATION=1100
local CCT_GRACE_TIME = 5

local CCT_ICON_FONT = "$(GAMEPAD_BOLD_FONT)|25|thick-outline"
local CCT_STAGGER_FONT = "$(GAMEPAD_BOLD_FONT)|36|thick-outline"
local CCT_ZOS_DEFAULT_ICON = "/esoui/art/icons/ability_mage_065.dds"

local CCT_DEFAULT_STUN_ICON = "/esoui/art/inventory/gamepad/gp_inventory_icon_apparel.dds"
local CCT_DEFAULT_FEAR_ICON = "/esoui/art/compass/ava_murderball_neutral.dds"
local CCT_DEFAULT_DISORIENT_ICON = "/esoui/art/ava/ava_rankicon64_grandoverlord.dds"
local CCT_DEFAULT_SILENCE_ICON = "/esoui/art/icons/heraldrycrests_misc_eye_01.dds"

local CCT_DEFAULT_IMMUNE_ICON = "/esoui/art/screens_app/load_ourosboros.dds"

local CCT_DEFAULT_ICONBORDER = "/esoui/art/actionbar/debuff_frame.dds"
local CCT_ICONBORDER = "CrowdControlTracker/img/border.dds"

local CCT_SET_SCALE_FROM_SV = true
local CCT_BREAK_FREE_ID = 16565
local CCT_NEGATE_MAGIC_ID = 47158
local CCT_NEGATE_MAGIC_1_ID = 51894
local CCT_ICON_MISSING="icon_missing"

local ACTION_RESULT_AREA_EFFECT=669966

CCT.controlTypes={
	ACTION_RESULT_STUNNED,
	ACTION_RESULT_FEARED,
	ACTION_RESULT_DISORIENTED,
	ACTION_RESULT_SILENCED,
	ACTION_RESULT_STAGGERED,
	ACTION_RESULT_AREA_EFFECT,
}

CCT.actionResults = {
	[ACTION_RESULT_STUNNED]           = true,
	[ACTION_RESULT_FEARED]            = true,
	[ACTION_RESULT_DISORIENTED]       = true,
}

CCT.controlText={
	[ACTION_RESULT_STUNNED] 	      = "STUNNED",
	[ACTION_RESULT_FEARED] 		      = "FEARED",
	[ACTION_RESULT_DISORIENTED]       = "DISORIENTED",
	[ACTION_RESULT_SILENCED] 	      = "SILENCED",
	[ACTION_RESULT_STAGGERED] 	      = "STAGGER",
	[ACTION_RESULT_IMMUNE] 		      = "IMMUNE",
	[ACTION_RESULT_DODGED] 		      = "DODGED",
	[ACTION_RESULT_BLOCKED] 		  = "BLOCKED",
	[ACTION_RESULT_BLOCKED_DAMAGE]    = "BLOCKED",
	[ACTION_RESULT_AREA_EFFECT]       = "AREA DAMAGE",
}

CCT.aoeHitTypes={
	[ACTION_RESULT_BLOCKED] 			= true,
	[ACTION_RESULT_BLOCKED_DAMAGE] 		= true,
	[ACTION_RESULT_CRITICAL_DAMAGE] 	= true,
	[ACTION_RESULT_DAMAGE] 				= true,
	[ACTION_RESULT_DAMAGE_SHIELDED] 	= true,
	[ACTION_RESULT_IMMUNE] 				= true,
	[ACTION_RESULT_MISS] 	 			= true,
	[ACTION_RESULT_PARTIAL_RESIST] 		= true,
	[ACTION_RESULT_REFLECTED] 			= true,
	[ACTION_RESULT_RESIST] 				= true,
	[ACTION_RESULT_WRECKING_DAMAGE] 	= true,
	[ACTION_RESULT_SNARED] 	            = true,
    [ACTION_RESULT_DOT_TICK]            = true,
    [ACTION_RESULT_DOT_TICK_CRITICAL]   = true,
}

function CCT:OnOff()
	if CI.SV.sct.enabled and not (CI.SV.sct.enabledOnlyInCyro and not LUIE.ResolvePVPZone()) then
		if not self.addonEnabled then
			self.addonEnabled=true
			EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_ACTIVATED, self.Activated)
			EVENT_MANAGER:RegisterForEvent(self.name, EVENT_COMBAT_EVENT, function(...) self:OnCombat(...) end)
			EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_STUNNED_STATE_CHANGED, function(...) self:OnStunnedState(...) end)
			EVENT_MANAGER:RegisterForEvent(self.name, EVENT_UNIT_DEATH_STATE_CHANGED, function(eventCode, unitTag, isDead) if isDead then self:FullReset() end end)
			EVENT_MANAGER:AddFilterForEvent(self.name, EVENT_UNIT_DEATH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player")
			self:GeneratePriorityTable()
			self.Activated()
		end
	else
		if self.addonEnabled then
			self.addonEnabled=false
			EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_PLAYER_ACTIVATED)
			EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_COMBAT_EVENT)
			EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_PLAYER_STUNNED_STATE_CHANGED)
			EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_UNIT_DEATH_STATE_CHANGED)
			CC_Tracker:SetHidden(true)
		end
	end
end

function CCT.Initialize()
	CCT:OnOff()
	if CI.SV.sct.enabled then
		CCT.currentlyPlaying=nil
		CCT.breakFreePlaying=nil
		CCT.immunePlaying=nil
		CCT:FullReset()
	end
end
