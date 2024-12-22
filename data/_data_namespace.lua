--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

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

---@class Effects
---@field AddNameAura table Table of effects that need name auras added
---@field AddNameOnBossEngaged table Table of effects that add names when boss is engaged
---@field AddNameOnEvent table Table of effects that add names on specific events
---@field AddNoDurationBarHighlight table Table of effects that should highlight without duration
---@field AddStackOnEvent table Table of effects that add stacks on specific events
---@field ArtificialEffectOverride table Table of artificial effect overrides
---@field AssistantIcons table Table of assistant icon definitions
---@field BarHighlightCheckOnFade table Table of effects to check highlight on fade
---@field BarHighlightDestroFix table Table of destruction staff highlight fixes
---@field BarHighlightExtraId table Table of additional effect IDs for highlighting
---@field BarHighlightOverride table Table of highlight override definitions
---@field BarHighlightStack table Table of stack-based highlight effects
---@field BarIdOverride table Table of bar ID overrides
---@field CreateSkillAura table Table of skill aura creation definitions
---@field DisguiseIcons table Table of disguise icon definitions
---@field FakeAddGroundDamageAura table Table of fake ground damage aura definitions
---@field FakeEffectGroundDisplay table Table of fake ground effect display definitions
---@field FakeExternalBuffs table Table of fake external buff definitions
---@field FakeExternalDebuffs table Table of fake external debuff definitions
---@field FakePlayerBuffs table Table of fake player buff definitions
---@field FakePlayerDebuffs table Table of fake player debuff definitions
---@field FakePlayerOfflineAura table Table of fake offline aura definitions
---@field FakeStagger table Table of fake stagger effect definitions
---@field HasAbilityProc table Table of ability proc definitions
---@field HideSCT table Table of effects to hide from SCT
---@field IsAbilityActiveGlow table Table of ability active glow effects
---@field IsAbilityActiveHighlight table Table of ability active highlight effects
---@field IsBloodFrenzy table Table of blood frenzy effect definitions
---@field IsGrimFocus table Table of grim focus effect definitions
---@field KeepUpgradeAlliance table Table of keep upgrade alliance definitions
---@field KeepUpgradeNameFix table Table of keep upgrade name fixes
---@field KeepUpgradeOverride table Table of keep upgrade overrides
---@field KeepUpgradeTooltip table Table of keep upgrade tooltip definitions
---@field MajorMinor table Table of major/minor effect definitions
---@field MapDataOverride table Table of map data overrides
---@field MergeId table Table of effect ID merge definitions
---@field MergeName table Table of effect name merge definitions
---@field Override table Table of general effect overrides
---@field OverrideByName table Table of name-based effect overrides
---@field PullDuration table Table of duration pull definitions
---@field RemoveAbilityActiveHighlight table Table of effects to remove active highlight
---@field SourceOverride table Table of effect source overrides
---@field SynergyNameOverride table Table of synergy name overrides
---@field TooltipUseDefault table Table of effects using default tooltips
---@field ZoneBuffs table Table of zone-specific buff definitions
---@field ZoneDataOverride table Table of zone data overrides

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
    Abilities = {},
    AbilityBlacklistPresets = {},
    AlertBossNameConvert = {},
    ---@diagnostic disable-next-line: missing-fields
    AlertMapOverride = {},
    AlertTable = {},
    AlertZoneOverride = {},
    CastBarTable = {},
    CollectibleTables = {},
    CombatTextBlacklistPresets = {},
    CombatTextConstants = {},
    CrowdControl =
    {
        IgnoreList = {},
        LavaAlerts = {},
        ReversedLogic = {},
        SpecialCC = {},
        aoeNPCBoss = {},
        aoeNPCElite = {},
        aoeNPCNormal = {},
        aoePlayerNormal = {},
        aoePlayerSet = {},
        aoePlayerUltimate = {},
        aoeTraps = {},
    },
    DebugResults = {},
    DebugAuras = {},
    Effects =
    {
        AddNameAura = {},
        AddNameOnBossEngaged = {},
        AddNameOnEvent = {},
        AddNoDurationBarHighlight = {},
        AddStackOnEvent = {},
        ArtificialEffectOverride = {},
        AssistantIcons = {},
        BarHighlightCheckOnFade = {},
        BarHighlightDestroFix = {},
        BarHighlightExtraId = {},
        BarHighlightOverride = {},
        BarHighlightStack = {},
        BarIdOverride = {},
        BlockAndBashCC = {},
        DebuffDisplayOverrideId = {},
        DebuffDisplayOverrideIdAlways = {},
        DebuffDisplayOverrideMajorMinor = {},
        DebuffDisplayOverrideName = {},
        ---@diagnostic disable-next-line: missing-fields
        DisguiseIcons = {}, ---@type DisguiseIcons
        EffectHideSCT = {},
        EffectMergeId = {},
        EffectMergeName = {},
        EffectOverride = {},
        EffectOverrideByName = {},
        EffectPullDuration = {},
        EffectSourceOverride = {},
        FakeExternalBuffs = {},
        FakeExternalDebuffs = {},
        FakePlayerBuffs = {},
        FakePlayerDebuffs = {},
        FakePlayerOfflineAura = {},
        FakeStagger = {},
        HasAbilityProc = {},
        HideGroundMineStacks = {},
        IsAbilityActiveGlow = {},
        IsAbilityActiveHighlight = {},
        IsAbilityICD = {},
        IsAllianceXPBuff = {},
        IsBlock = {},
        IsBloodFrenzy = {},
        IsBoon = {},
        IsCyrodiil = {},
        IsExperienceBuff = {},
        IsFoodBuff = {},
        IsGrimFocus = {},
        IsGroundMineAura = {},
        IsGroundMineDamage = {},
        IsGroundMineStack = {},
        IsLycan = {},
        IsSetICD = {},
        IsSoulSummons = {},
        IsVamp = {},
        IsVampLycanBite = {},
        IsVampLycanDisease = {},
        IsWeaponAttack = {},
        KeepUpgradeAlliance = {},
        KeepUpgradeNameFix = {},
        KeepUpgradeOverride = {},
        KeepUpgradeTooltip = {},
        LinkedGroundMine = {},
        MajorMinor = {},
        MapDataOverride = {},
        RemoveAbilityActiveHighlight = {},
        SynergyNameOverride = {},
        TooltipUseDefault = {},
        ZoneBuffs = {},
        ZoneDataOverride = {},
    },
    PetNames =
    {
        Assistants = {},
        Necromancer = {},
        Sets = {},
        Sorcerer = {},
        Warden = {},
    },
    ---@class (partial) Quests
    Quests = {},
    ---@class (partial) Tooltips
    Tooltips = {},
    ---@class (partial) UnitNames
    UnitNames = {},
    ---@class (partial) ZoneNames
    ZoneNames = {},
    ---@class (partial) ZoneTable
    ZoneTable = {},
}

---@class (partial) Data
LUIE.Data = Data
