-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiData
local LuiData = LuiData

local Tooltips = LuiData.Data.Tooltips
local Unitnames = LuiData.Data.UnitNames
local Zonenames = LuiData.Data.ZoneNames
local Abilities = LuiData.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- If one of these ability Names is applied then we set the buffSlot for ON_EFFECT_CHANGED to be a single name identifier to prevent more than one aura from appearing. Only works with unlimited duration or equal duration effects.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) EffectMergeName
local EffectMergeName =
{
    [Abilities.Skill_Overcharge] = "MERGED_EFFECT_OVERCHARGE",
    [Abilities.Skill_Boulder_Toss] = "MERGED_EFFECT_BOULDER_TOSS",
    [Abilities.Skill_Boss_CC_Immunity] = "MERGED_EFFECT_BOSS_IMMUNITIES", -- Scary Immunities
}

--- @class (partial) EffectMergeName
LuiData.Data.Effects.EffectMergeName = EffectMergeName
