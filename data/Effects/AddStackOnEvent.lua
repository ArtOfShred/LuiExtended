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
-- Supports the above table by determining stack counts if needed.
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddStackOnEvent =
{

    [28759] = 0; -- Essence Siphon (Keeper Voranil) -- Note: Set to 0 here due to this event firing twice.
};