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
-- When the player loads into the ZoneId listed below, add an unlimited duration long aura for the abilityId.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) ZoneBuffs
local ZoneBuffs =
{
    -- Daggerfall Covenant Quests
    [811] = 28358, -- Zone: Ancient Carzog's Demise (Base Zone: Betnikh) (Quest: Unearthing the Past) - Q4468 Orc Raider Disguise
}

--- @class (partial) ZoneBuffs
LuiData.Data.Effects.ZoneBuffs = ZoneBuffs
