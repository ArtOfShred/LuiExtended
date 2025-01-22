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

--- @class (partial) KeepUpgradeNameFix
local KeepUpgradeNameFix =
{
    [Abilities.Keep_Upgrade_Food_Mage_Abilities] = Abilities.Keep_Upgrade_Food_Mage_Abilities_Fix,
}


--- @class (partial) KeepUpgradeNameFix
LuiData.Data.Effects.KeepUpgradeNameFix = KeepUpgradeNameFix
