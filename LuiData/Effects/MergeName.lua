-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LuiData

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

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
LUIE.Data.Effects.EffectMergeName = EffectMergeName
