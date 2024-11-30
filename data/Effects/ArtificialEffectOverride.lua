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
-- Using a separate chart for ZOS Artificial Effects just in case this is significantly expanded at any point -- Overrides Artificial Effect id name or icon.
--------------------------------------------------------------------------------------------------------------------------------
Effects.ArtificialEffectOverride =
{
    [0] = { name = zo_strgsub(GetArtificialEffectInfo(0), 'Plus', 'plus'); tooltip = Tooltips.Innate_ESO_Plus }; -- ESO Plus (used for Active Effects window)
    [1] = { tooltip = Tooltips.Innate_Battle_Spirit }; -- Battle Spirit (Cyrodiil, Duel, Battleground) (used for Active Effects window)
    [2] = { name = zo_strgsub(GetArtificialEffectInfo(1), 'For', 'for'); tooltip = Tooltips.Innate_Looking_for_Group }; -- Looking For Group (Dungeon Finder)
    [3] = { name = Abilities.Skill_Battle_Spirit; tooltip = Tooltips.Innate_Battle_Spirit_Imperial_City }; -- Battle Spirit Imperial City (used for Active Effects window)
    [4] = { tooltip = Tooltips.Innate_Battleground_Deserter }; -- Battleground Deserter Penalty
};
