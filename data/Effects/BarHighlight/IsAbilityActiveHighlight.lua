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

Effects.IsAbilityActiveHighlight =
{
    -- Support
    [78338] = true; -- Guard (Guard)
    [81415] = true; -- Mystic Guard (Mystic Guard)
    [81420] = true; -- Stalwart Guard (Stalwart Guard)
};