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

--- @class (partial) AddNameOnBossEngaged
local AddNameOnBossEngaged =
{
    [Unitnames.Boss_Razor_Master_Erthas] = { [Unitnames.NPC_Flame_Atronach] = 33097 }, -- Scary Immunities --> Razor Master Erthas --> Flame Atronach (City of Ash I)
    [Unitnames.Boss_Ilambris_Amalgam] = { [Unitnames.NPC_Skeleton] = 33097 },          -- Scary Immunities --> Ilambris Amalgam --> Skeleton (Crypt of Hearts II)
}

--- @class (partial) AddNameOnBossEngaged
LuiData.Data.Effects.AddNameOnBossEngaged = AddNameOnBossEngaged
