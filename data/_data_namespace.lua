--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE;

---@class CrowdControl
---@field aoeNPCBoss table
---@field aoeNPCElite table
---@field aoeNPCNormal table
---@field aoePlayerNormal table
---@field aoePlayerSet table
---@field aoePlayerUltimate table
---@field aoeTraps table
---@field IgnoreList table
---@field LavaAlerts table
---@field ReversedLogic table
---@field SpecialCC table

---@class (partial) Data
---@field Abilities AbilityTables
---@field AbilityBlacklistPresets BlacklistPresets
---@field AlertBossNameConvert AlertBossNameConvert
---@field AlertMapOverride AlertMapOverride
---@field AlertTable AlertTable
---@field AlertZoneOverride AlertZoneOverride
---@field CastBarTable CastBarTable
---@field CollectibleTables CollectibleTables
---@field CombatTextBlacklistPresets BlacklistPresets
---@field CombatTextConstants CombatTextConstants
---@field CrowdControl CrowdControl
---@field DebugResults DebugResults
---@field DebugAuras DebugAuras
---@field Effects Effects
---@field PetNames PetNames
---@field Quests Quests
---@field Tooltips Tooltips
---@field UnitNames UnitNames
---@field ZoneNames ZoneNames
---@field ZoneTable ZoneTable
local Data =
{
    Abilities = {};
    AbilityBlacklistPresets = {};
    AlertBossNameConvert = {};
    AlertMapOverride = {};
    AlertTable = {};
    AlertZoneOverride = {};
    CastBarTable = {};
    CollectibleTables = {};
    CombatTextBlacklistPresets = {};
    CombatTextConstants = {};
    CrowdControl = {
        IgnoreList = {};
        LavaAlerts = {};
        ReversedLogic = {};
        SpecialCC = {};
        aoeNPCBoss = {};
        aoeNPCElite = {};
        aoeNPCNormal = {};
        aoePlayerNormal = {};
        aoePlayerSet = {};
        aoePlayerUltimate = {};
        aoeTraps = {};
    };
    DebugResults = {};
    DebugAuras = {};
    Effects = {
        AddNameAura = {};
        AddNameOnBossEngaged = {};
        AddNameOnEvent = {};
        AddNoDurationBarHighlight = {};
        AddStackOnEvent = {};
        ArtificialEffectOverride = {};
        AssistantIcons = {};
        BarHighlightCheckOnFade = {};
        BarHighlightDestroFix = {};
        BarHighlightExtraId = {};
        BarHighlightOverride = {};
        BarHighlightStack = {};
        BarIdOverride = {};
        BlockAndBashCC = {};
        DebuffDisplayOverrideId = {};
        DebuffDisplayOverrideIdAlways = {};
        DebuffDisplayOverrideMajorMinor = {};
        DebuffDisplayOverrideName = {};
        DisguiseIcons = {}; ---@type DisguiseIcons
        EffectHideSCT = {};
        EffectMergeId = {};
        EffectMergeName = {};
        EffectOverride = {};
        EffectOverrideByName = {};
        EffectPullDuration = {};
        EffectSourceOverride = {};
        FakeExternalBuffs = {};
        FakeExternalDebuffs = {};
        FakePlayerBuffs = {};
        FakePlayerDebuffs = {};
        FakePlayerOfflineAura = {};
        FakeStagger = {};
        HasAbilityProc = {};
        HideGroundMineStacks = {};
        IsAbilityActiveGlow = {};
        IsAbilityActiveHighlight = {};
        IsAbilityICD = {};
        IsAllianceXPBuff = {};
        IsBlock = {};
        IsBloodFrenzy = {};
        IsBoon = {};
        IsCyrodiil = {};
        IsExperienceBuff = {};
        IsFoodBuff = {};
        IsGrimFocus = {};
        IsGroundMineAura = {};
        IsGroundMineDamage = {};
        IsGroundMineStack = {};
        IsLycan = {};
        IsSetICD = {};
        IsSoulSummons = {};
        IsVamp = {};
        IsVampLycanBite = {};
        IsVampLycanDisease = {};
        IsWeaponAttack = {};
        KeepUpgradeAlliance = {};
        KeepUpgradeNameFix = {};
        KeepUpgradeOverride = {};
        KeepUpgradeTooltip = {};
        LinkedGroundMine = {};
        MajorMinor = {};
        MapDataOverride = {};
        RemoveAbilityActiveHighlight = {};
        SynergyNameOverride = {};
        TooltipUseDefault = {};
        ZoneBuffs = {};
        ZoneDataOverride = {};
    };
    PetNames = {
        Assistants = {};
        Necromancer = {};
        Sets = {};
        Sorcerer = {};
        Warden = {};
    };
    ---@class (partial) Quests
    Quests = {};
    ---@class (partial) Tooltips
    Tooltips = {};
    ---@class (partial) UnitNames
    UnitNames = {};
    ---@class (partial) ZoneNames
    ZoneNames = {};
    ---@class (partial) ZoneTable
    ZoneTable = {};
};

---@class (partial) Data
LUIE.Data = Data;
