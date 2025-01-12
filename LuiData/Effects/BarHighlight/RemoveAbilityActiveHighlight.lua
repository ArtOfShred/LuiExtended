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
--- @class (partial) RemoveAbilityActiveHighlight
local RemoveAbilityActiveHighlight =
{
    -- Vampire
    [132141] = true, -- Blood Frenzy
    [134160] = true, -- Simmering Frenzy
    [135841] = true, -- Sated Fury
}

--- @class (partial) RemoveAbilityActiveHighlight
LUIE.Data.Effects.RemoveAbilityActiveHighlight = RemoveAbilityActiveHighlight
