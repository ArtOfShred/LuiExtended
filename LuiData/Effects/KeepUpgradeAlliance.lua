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

--- @class (partial) KeepUpgradeAlliance
local KeepUpgradeAlliance =
{
    [Abilities.Keep_Upgrade_Food_Honor_Guard_Abilities] =
    {
        [1] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_ad.dds",
        [2] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_ep.dds",
        [3] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_dc.dds",
    },
}


--- @class (partial) KeepUpgradeAlliance
LuiData.Data.Effects.KeepUpgradeAlliance = KeepUpgradeAlliance
