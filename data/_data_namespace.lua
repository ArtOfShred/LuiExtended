--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

---@class Data
---@field public Abilities AbilityTables
---@field public AbilityBlacklistPresets BlacklistPresets
---@field public AlertBossNameConvert AlertBossNameConvert
---@field public AlertMapOverride AlertMapOverride
---@field public AlertTable AlertTable
---@field public AlertZoneOverride AlertZoneOverride
---@field public CastBarTable CastBarTable
---@field public CollectibleTables CollectibleTables
---@field public CombatTextBlacklistPresets BlacklistPresets
---@field public CombatTextConstants CombatTextConstants
---@field public CrowdControl CrowdControl
---@field public DebugResults DebugResults
---@field public DebugAuras DebugAuras
---@field public Effects Effects
---@field public PetNames PetNames
---@field public Quests Quests
---@field public Tooltips Tooltips
---@field public UnitNames UnitNames
---@field public ZoneNames ZoneNames
---@field public ZoneTable ZoneTable
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
