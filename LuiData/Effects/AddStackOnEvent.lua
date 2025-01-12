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
-- Supports the above table by determining stack counts if needed.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) AddStackOnEvent
local AddStackOnEvent =
{

    [28759] = 0, -- Essence Siphon (Keeper Voranil) -- Note: Set to 0 here due to this event firing twice.
}

--- @class (partial) AddStackOnEvent
LUIE.Data.Effects.AddStackOnEvent = AddStackOnEvent
