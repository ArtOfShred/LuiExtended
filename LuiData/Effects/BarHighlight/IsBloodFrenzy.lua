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
LuiData.Data.Effects.IsBloodFrenzy = IsBloodFrenzy
