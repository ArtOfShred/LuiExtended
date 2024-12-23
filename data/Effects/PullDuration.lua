--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- If this abilityId is up, then pull the duration from another active ability Id to set its duration (Unused - Might be useful in the future - Note this is supported in code)
--------------------------------------------------------------------------------------------------------------------------------
---@class (partial) EffectPullDuration
local EffectPullDuration =
{
}

---@class (partial) EffectPullDuration
LUIE.Data.Effects.EffectPullDuration = EffectPullDuration
