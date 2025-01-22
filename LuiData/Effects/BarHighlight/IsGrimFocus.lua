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
--- @class (partial) IsGrimFocus
local IsGrimFocus =
{
    [122585] = true, -- Grim Focus
    [122587] = true, -- Relentless Focus
    [122586] = true, -- Merciless Resolve
}

--- @class (partial) IsGrimFocus
LuiData.Data.Effects.IsGrimFocus = IsGrimFocus
