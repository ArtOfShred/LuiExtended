--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Global Variables

-- LUIE_CC_TYPE
LUIE_CC_TYPE_STUN = 1 -- Stun
LUIE_CC_TYPE_KNOCKBACK = 2 -- Knockback
LUIE_CC_TYPE_PULL = 3 -- Pull
LUIE_CC_TYPE_DISORIENT = 4 -- Disorient
LUIE_CC_TYPE_FEAR = 5 -- Fear
LUIE_CC_TYPE_STAGGER = 6 -- Stagger
LUIE_CC_TYPE_SILENCE = 7 -- Silence
LUIE_CC_TYPE_SNARE = 8 -- Snare
LUIE_CC_TYPE_ROOT = 9 -- Immobilize
LUIE_CC_TYPE_UNBREAKABLE = 10 -- Unbreakable CC

-- LUIE_BUFF_TYPE
LUIE_BUFF_TYPE_BUFF = 1 -- Buff
LUIE_BUFF_TYPE_DEBUFF = 2 -- Debuff
LUIE_BUFF_TYPE_UB_BUFF = 3 -- Unbreakable buff
LUIE_BUFF_TYPE_UB_DEBUFF = 4 -- Unbreakable debuff
LUIE_BUFF_TYPE_GROUND_BUFF = 5 -- Ground aoe buffs
LUIE_BUFF_TYPE_GROUND_DEBUFF = 6 -- Ground aoe debuffs
LUIE_BUFF_TYPE_ENVIRONMENT_BUFF = 7 -- Area buff (entire zone, etc)
LUIE_BUFF_TYPE_ENVIRONMENT_DEBUFF = 8 -- Hazard (lava, shock water, entire zone/room, etc)
LUIE_BUFF_TYPE_NONE = 9

-- Add localized strings for this and use SI_blabla, # to get the right string for determing TYPE on buff mouseover
--[[
[1] = "Buff",
[2] = "Debuff",
[3] = "Unbreakable Buff",
[4] = "Unbreakable Debuff",
[5] = "Ground Buff",
[6] = "Ground Debuff",
[7] = "Environmental Buff"
[8] = "Environmental Debuff"
[9] = "None",
]]--


-- LUIE_COMBAT_ALERT_TYPE
LUIE_COMBAT_ALERT_TYPE_UNMIT = 1
LUIE_COMBAT_ALERT_TYPE_DESTROY = 2
LUIE_COMBAT_ALERT_TYPE_POWER = 3
LUIE_COMBAT_ALERT_TYPE_SUMMON = 4
LUIE_COMBAT_ALERT_TYPE_SHARED = 5

-- LUIE_QUEST_MESSAGE
LUIE_QUEST_MESSAGE_TURNIN = 1
LUIE_QUEST_MESSAGE_USE = 2
LUIE_QUEST_MESSAGE_EXHAUST = 3
LUIE_QUEST_MESSAGE_OFFER = 4
LUIE_QUEST_MESSAGE_DISCARD = 5
LUIE_QUEST_MESSAGE_CONFISCATE = 6
LUIE_QUEST_MESSAGE_COMBINE = 7
LUIE_QUEST_MESSAGE_MIX = 8
LUIE_QUEST_MESSAGE_BUNDLE = 9
LUIE_QUEST_MESSAGE_LOOT = 10
LUIE_QUEST_MESSAGE_OPEN = 11
LUIE_QUEST_MESSAGE_ADMINISTER = 12
LUIE_QUEST_MESSAGE_PLACE = 13
