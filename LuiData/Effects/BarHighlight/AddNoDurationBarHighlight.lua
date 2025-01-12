-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LuiData

--- @class (partial) Effects
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
-- We don't add bar highlights for 0 duration abilities, a few abilities with dynamic durations show as 0 duration so we need this override table.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) AddNoDurationBarHighlight
local AddNoDurationBarHighlight =
{

    -- Necromancer
    [115240] = true, -- Bitter Harvest
    [124165] = true, -- Deaden Pain
    [124193] = true, -- Necrotic Potency
    [118814] = true, -- Enduring Undeath
}

--- @class (partial) AddNoDurationBarHighlight
LUIE.Data.Effects.AddNoDurationBarHighlight = AddNoDurationBarHighlight
