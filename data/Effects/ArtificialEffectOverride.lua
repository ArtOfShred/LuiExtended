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

local ESO_Plus_Member = function ()
    local displayName, _, _, _, _, _, _ = GetArtificialEffectInfo(0)
    return displayName
end
--------------------------------------------------------------------------------------------------------------------------------
-- Using a separate chart for ZOS Artificial Effects just in case this is significantly expanded at any point -- Overrides Artificial Effect id name or icon.
--------------------------------------------------------------------------------------------------------------------------------
---@class (partial) ArtificialEffectOverride
local ArtificialEffectOverride =
{
    [0] = { name = ESO_Plus_Member(), tooltip = Tooltips.Innate_ESO_Plus },                                             -- ESO Plus (used for Active Effects window)
    [1] = { tooltip = Tooltips.Innate_Battle_Spirit },                                                                  -- Battle Spirit (Cyrodiil, Duel, Battleground) (used for Active Effects window)
    [2] = { name = zo_strgsub(GetArtificialEffectInfo(1), "For", "for"), tooltip = Tooltips.Innate_Looking_for_Group }, -- Looking For Group (Dungeon Finder)
    [3] = { name = Abilities.Skill_Battle_Spirit, tooltip = Tooltips.Innate_Battle_Spirit_Imperial_City },              -- Battle Spirit Imperial City (used for Active Effects window)
    [4] = { tooltip = Tooltips.Innate_Battleground_Deserter },                                                          -- Battleground Deserter Penalty
}

---@class (partial) ArtificialEffectOverride
LUIE.Data.Effects.ArtificialEffectOverride = ArtificialEffectOverride
