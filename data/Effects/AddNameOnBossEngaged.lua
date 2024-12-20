--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE;

---@class Effects
local Effects = LUIE.Data.Effects;

local Tooltips = LUIE.Data.Tooltips;
local Unitnames = LUIE.Data.UnitNames;
local Zonenames = LUIE.Data.ZoneNames;
local Abilities = LUIE.Data.Abilities;

local zo_strformat = zo_strformat;


Effects.AddNameOnBossEngaged =
{
    [Unitnames.Boss_Razor_Master_Erthas] = { [Unitnames.NPC_Flame_Atronach] = 33097 }; -- Scary Immunities --> Razor Master Erthas --> Flame Atronach (City of Ash I)
    [Unitnames.Boss_Ilambris_Amalgam] = { [Unitnames.NPC_Skeleton] = 33097 }; -- Scary Immunities --> Ilambris Amalgam --> Skeleton (Crypt of Hearts II)
};
