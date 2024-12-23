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

--------------------------------------------------------------------------------------------------------------------------------
-- Icon to display for Assistant Collectibles
--------------------------------------------------------------------------------------------------------------------------------
---@class (partial) AssistantIcons
local AssistantIcons =
{
    [GetCollectibleName(301)] = "LuiExtended/media/icons/assistants/assistant_nuzhimeh.dds",
    [GetCollectibleName(300)] = "LuiExtended/media/icons/assistants/assistant_pirharri.dds",
    [GetCollectibleName(267)] = "LuiExtended/media/icons/assistants/assistant_tythis.dds",
    [GetCollectibleName(6376)] = "LuiExtended/media/icons/assistants/assistant_ezabi.dds",
    [GetCollectibleName(6378)] = "LuiExtended/media/icons/assistants/assistant_fezez.dds",
    [GetCollectibleName(8994)] = "LuiExtended/media/icons/assistants/assistant_crowbanker.dds",
    [GetCollectibleName(8995)] = "LuiExtended/media/icons/assistants/assistant_crowmerchant.dds",
    [GetCollectibleName(9743)] = "LuiExtended/media/icons/assistants/assistant_factotumbanker.dds",
    [GetCollectibleName(9744)] = "LuiExtended/media/icons/assistants/assistant_factotummerchant.dds",
    [GetCollectibleName(9745)] = "LuiExtended/media/icons/assistants/assistant_ghrasharog.dds",
    [GetCollectibleName(10184)] = "LuiExtended/media/icons/assistants/assistant_giladil.dds",
	[GetCollectibleName(10618)] = "LuiExtended/media/icons/new_assistants/assistant_zuqoth.dds",
}

---@class (partial) AssistantIcons
LUIE.Data.Effects.AssistantIcons = AssistantIcons
