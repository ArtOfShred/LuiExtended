-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiData
local LuiData = LuiData

local Unitnames = LuiData.Data.UnitNames
local Zonenames = LuiData.Data.ZoneNames
local Abilities = LuiData.Data.Abilities
local ZoneTable = LuiData.Data.ZoneTable

-- Map Name override - Sometimes we need to use GetMapName() instead of Location Name or ZoneId
--- @class (partial) AlertMapOverride
local AlertMapOverride =
{
    -- Slam (Great Bear)
    [70366] =
    {
        -- QUESTS
        [Zonenames.Zone_Deepwood_Barrow] = Unitnames.NPC_Great_Bear, -- Deepwood Vale (Greymoor Tutorial)
    },
}

--- @class (partial) AlertMapOverride
LuiData.Data.AlertMapOverride = AlertMapOverride
