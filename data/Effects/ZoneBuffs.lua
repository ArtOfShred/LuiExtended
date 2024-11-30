--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE;

---@class Effects
local Effects = LUIE.Data.Effects;

local Tooltips = LUIE.Data.Tooltips;
local Unitnames = LUIE.Data.UnitNames;
local Zonenames = LUIE.Data.ZoneNames;
local Abilities = LUIE.Data.Abilities;

local zo_strformat = zo_strformat;

--------------------------------------------------------------------------------------------------------------------------------
-- When the player loads into the ZoneId listed below, add an unlimited duration long aura for the abilityId.
--------------------------------------------------------------------------------------------------------------------------------
Effects.ZoneBuffs =
{
    -- Daggerfall Covenant Quests
    [811] = 28358; -- Zone: Ancient Carzog's Demise (Base Zone: Betnikh) (Quest: Unearthing the Past) - Q4468 Orc Raider Disguise
};
