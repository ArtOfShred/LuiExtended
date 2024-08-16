--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

---@class Data
---@field public Abilities table
---@field public AbilityBlacklistPresets table
---@field public AlertBossNameConvert table
---@field public AlertMapOverride table
---@field public AlertTable table
---@field public AlertZoneOverride table
---@field public CastBarTable table
---@field public CollectibleTables table
---@field public CombatTextBlacklistPresets table
---@field public CombatTextConstants table
---@field public CrowdControl table
---@field public DebugResults table
---@field public DebugAuras table
---@field public Effects table
---@field public PetNames table
---@field public Quests table
---@field public Tooltips table
---@field public UnitNames table
---@field public ZoneNames table
---@field public ZoneTable table
local Data =
{
    Abilities = {},
    AbilityBlacklistPresets = {},
    AlertBossNameConvert = {},
    AlertMapOverride = {},
    AlertTable = {},
    AlertZoneOverride = {},
    CastBarTable = {},
    CollectibleTables = {},
    CombatTextBlacklistPresets = {},
    CombatTextConstants = {},
    CrowdControl = {},
    DebugResults = {},
    DebugAuras = {},
    Effects = {},
    PetNames = {},
    Quests = {},
    Tooltips = {},
    UnitNames = {},
    ZoneNames = {},
    ZoneTable = {},
}

LUIE.Data = Data
