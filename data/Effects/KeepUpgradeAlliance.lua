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

---@class (partial) KeepUpgradeAlliance
local KeepUpgradeAlliance =
{
    [Abilities.Keep_Upgrade_Food_Honor_Guard_Abilities] =
    {
        [1] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_ad.dds",
        [2] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_ep.dds",
        [3] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_dc.dds",
    },
}


---@class (partial) KeepUpgradeAlliance
LUIE.Data.Effects.KeepUpgradeAlliance = KeepUpgradeAlliance
