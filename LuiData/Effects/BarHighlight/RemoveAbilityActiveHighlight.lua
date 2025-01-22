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
--- @class (partial) RemoveAbilityActiveHighlight
local RemoveAbilityActiveHighlight =
{
    -- Vampire
    [132141] = true, -- Blood Frenzy
    [134160] = true, -- Simmering Frenzy
    [135841] = true, -- Sated Fury
}

--- @class (partial) RemoveAbilityActiveHighlight
LuiData.Data.Effects.RemoveAbilityActiveHighlight = RemoveAbilityActiveHighlight
