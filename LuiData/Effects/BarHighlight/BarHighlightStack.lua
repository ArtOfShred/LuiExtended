-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LuiData

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------

--- @class (partial) BarHighlightStack
local BarHighlightStack =
{

    -- Sorcerer
    [24330] = 2, -- Haunting Curse (Haunting Curse)
    [89491] = 1, -- Haunting Curse (Haunting Curse)

    -- Warden
    [86009] = 2,  -- Scorch (Scorch)
    [178020] = 1, -- Scorch (Scorch)
    [86019] = 2,  -- Subterranean Assault
    [146919] = 1, -- Subterranean Assault
    [86015] = 2,  -- Deep Fissure
    [178028] = 1, -- Deep Fissure
}

--- @class (partial) BarHighlightStack
LUIE.Data.Effects.BarHighlightStack = BarHighlightStack
