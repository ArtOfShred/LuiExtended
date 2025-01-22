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
-- If this abilityId is up, then pull the duration from another active ability Id to set its duration (Unused - Might be useful in the future - Note this is supported in code)
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) EffectPullDuration
local EffectPullDuration =
{
}

--- @class (partial) EffectPullDuration
LuiData.Data.Effects.EffectPullDuration = EffectPullDuration
