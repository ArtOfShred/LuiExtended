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

--- @class (partial) MapDataOverride
--- @field [integer] { [string]: { icon: string, name: string, hide: boolean } } # Maps ability IDs to zone-specific icon overrides
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

--- @class (partial) MapDataOverride
LuiData.Data.Effects.MapDataOverride = MapDataOverride
