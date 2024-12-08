--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

---@class (partial) Effects
local Effects = LUIE.Data.Effects

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged to display a Proc highlight / sound notification when an ability with a matching name appears as a buff.
--------------------------------------------------------------------------------------------------------------------------------
Effects.HasAbilityProc =
{
    [Abilities.Skill_Crystal_Fragments] = 46327,
}
