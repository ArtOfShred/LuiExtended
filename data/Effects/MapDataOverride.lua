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

---@class (partial) MapDataOverride
local MapDataOverride =
{
    [70355] = { [Zonenames.Zone_Deepwood_Barrow] = { icon = "LuiExtended/media/icons/abilities/ability_bear_bite_w.dds" } },               -- Bite (Great Bear)
    [70357] = { [Zonenames.Zone_Deepwood_Barrow] = { icon = "LuiExtended/media/icons/abilities/ability_bear_lunge_white.dds" } },          -- Lunge (Great Bear)
    [70359] = { [Zonenames.Zone_Deepwood_Barrow] = { icon = "LuiExtended/media/icons/abilities/ability_bear_lunge_white.dds" } },          -- Lunge (Great Bear)
    [70366] = { [Zonenames.Zone_Deepwood_Barrow] = { icon = "LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_white.dds" } }, -- Slam (Great Bear)
    [89189] = { [Zonenames.Zone_Deepwood_Barrow] = { icon = "LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_white.dds" } }, -- Slam (Great Bear)
    [69073] = { [Zonenames.Zone_Deepwood_Barrow] = { icon = "LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_white.dds" } }, -- Knockdown (Great Bear)
    [70374] = { [Zonenames.Zone_Deepwood_Barrow] = { icon = "LuiExtended/media/icons/abilities/ability_bear_ferocity_white.dds" } },       -- Ferocity (Great Bear)
}

---@class (partial) MapDataOverride
LUIE.Data.Effects.MapDataOverride = MapDataOverride
