--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities
local ZoneTable = LUIE.Data.ZoneTable

-- Map Name override - Sometimes we need to use GetMapName() instead of Location Name or ZoneId
---@class (partial) AlertMapOverride
local AlertMapOverride =
{
    -- Slam (Great Bear)
    [70366] =
    {
        -- QUESTS
        [Zonenames.Zone_Deepwood_Barrow] = Unitnames.NPC_Great_Bear, -- Deepwood Vale (Greymoor Tutorial)
    },
}

---@class (partial) AlertMapOverride
LUIE.Data.AlertMapOverride = AlertMapOverride
