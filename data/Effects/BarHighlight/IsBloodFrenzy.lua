--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

--- @class (partial) LuiExtended
local LUIE = LUIE

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) IsBloodFrenzy
local IsBloodFrenzy =
{
    [172418] = true, -- Blood Frenzy
    [134166] = true, -- Simmering Frenzy
    [172648] = true, -- Sated Fury
}

--- @class (partial) IsBloodFrenzy
LUIE.Data.Effects.IsBloodFrenzy = IsBloodFrenzy
