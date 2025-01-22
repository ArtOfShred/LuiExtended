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
-- Supports the above table by determining stack counts if needed.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) AddStackOnEvent
local AddStackOnEvent =
{

    [28759] = 0, -- Essence Siphon (Keeper Voranil) -- Note: Set to 0 here due to this event firing twice.
}

--- @class (partial) AddStackOnEvent
LuiData.Data.Effects.AddStackOnEvent = AddStackOnEvent
