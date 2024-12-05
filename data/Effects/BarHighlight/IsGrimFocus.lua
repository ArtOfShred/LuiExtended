--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE;

---@class (partial) Effects
local Effects = LUIE.Data.Effects;

local Tooltips = LUIE.Data.Tooltips;
local Unitnames = LUIE.Data.UnitNames;
local Zonenames = LUIE.Data.ZoneNames;
local Abilities = LUIE.Data.Abilities;

local zo_strformat = zo_strformat;

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------

Effects.IsGrimFocus =
{
    [122585] = true; -- Grim Focus
    [122587] = true; -- Relentless Focus
    [122586] = true; -- Merciless Resolve
};