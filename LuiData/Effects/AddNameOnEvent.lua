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
-- When a gain event or faded event fires for this id in the world, we add a buff aura to a specific unit name. Only usable for unique boss effects.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) AddNameOnEvent
local AddNameOnEvent =
{

    [46680] = { name = Unitnames.Boss_Deaths_Leviathan, id = 46680 }, -- Immolate Colossus -- Death's Leviathan (Crypt of Hearts I)
    [28759] = { name = Unitnames.Boss_Keeper_Voranil, id = 28759 },   -- Essence Siphon -- Keeper Voranil (Banished Cells II)
    [52167] = { name = Unitnames.Boss_Ilambris_Amalgam, id = 53600 }, -- Shock Form -- Ilambris Amalgam (Crypt of Hearts II)
    [52166] = { name = Unitnames.Boss_Ilambris_Amalgam, id = 53593 }, -- Fire Form -- Ilambris Amalgam (Crypt of Hearts II)
}

--- @class (partial) AddNameOnEvent
LUIE.Data.Effects.AddNameOnEvent = AddNameOnEvent
