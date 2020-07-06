--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Quests namespace
LUIE.Data.AbilityBlacklistPresets = {}
local BlacklistPresets = LUIE.Data.AbilityBlacklistPresets

local Abilities = LUIE.Data.Abilities

-- Minor Buffs
BlacklistPresets.MinorBuffs = {
    [Abilities.Skill_Minor_Resolve]               = true,
    [Abilities.Skill_Minor_Fortitude]             = true,
    [Abilities.Skill_Minor_Endurance]             = true,
    [Abilities.Skill_Minor_Intellect]             = true,
    [Abilities.Skill_Minor_Sorcery]               = true,
    [Abilities.Skill_Minor_Prophecy]              = true,
    [Abilities.Skill_Minor_Brutality]             = true,
    [Abilities.Skill_Minor_Savagery]              = true,
    [Abilities.Skill_Minor_Berserk]               = true,
    [Abilities.Skill_Minor_Force]                 = true,
    [Abilities.Skill_Minor_Vitality]              = true,
    [Abilities.Skill_Minor_Mending]               = true,
    [Abilities.Skill_Minor_Protection]            = true,
    [Abilities.Skill_Minor_Evasion]               = true,
    [Abilities.Skill_Minor_Expedition]            = true,
    [Abilities.Skill_Minor_Heroism]               = true,
    [Abilities.Skill_Minor_Toughness]             = true,
    --[Abilities.Skill_Minor_Courage]               = true,
}

-- Major Buffs
BlacklistPresets.MajorBuffs = {
    [Abilities.Skill_Major_Resolve]               = true,
    [Abilities.Skill_Major_Fortitude]             = true,
    [Abilities.Skill_Major_Endurance]             = true,
    [Abilities.Skill_Major_Intellect]             = true,
    [Abilities.Skill_Major_Sorcery]               = true,
    [Abilities.Skill_Major_Prophecy]              = true,
    [Abilities.Skill_Major_Brutality]             = true,
    [Abilities.Skill_Major_Savagery]              = true,
    [Abilities.Skill_Major_Vitality]              = true,
    [Abilities.Skill_Major_Mending]               = true,
    [Abilities.Skill_Major_Evasion]               = true,
    [Abilities.Skill_Major_Expedition]            = true,
    [Abilities.Skill_Major_Gallop]                = true,
    [Abilities.Skill_Major_Heroism]               = true,
    --[Abilities.Skill_Major_Courage]               = true,
}

-- Minor Debuffs
BlacklistPresets.MinorDebuffs = {
    [Abilities.Skill_Minor_Breach]                = true,
    [Abilities.Skill_Minor_Fracture]              = true,
    [Abilities.Skill_Minor_Vulnerability]         = true,
    [Abilities.Skill_Minor_Maim]                  = true,
    [Abilities.Skill_Minor_Defile]                = true,
    [Abilities.Skill_Minor_Magickasteal]          = true,
    [Abilities.Skill_Minor_Lifesteal]             = true,
    [Abilities.Skill_Minor_Enveration]            = true,
    [Abilities.Skill_Minor_Uncertainty]           = true,
    [Abilities.Skill_Minor_Cowardice]             = true,
    [Abilities.Skill_Minor_Mangle]                = true,
    [Abilities.Skill_Minor_Timidity]              = true,
}

-- Major Debuffs
BlacklistPresets.MajorDebuffs = {
    [Abilities.Skill_Major_Breach]                = true,
    [Abilities.Skill_Major_Fracture]              = true,
    [Abilities.Skill_Major_Defile]                = true,
}

-- High Priority Major Buffs
BlacklistPresets.MajorBuffsHigh = {
    [Abilities.Skill_Major_Berserk]               = true,
    [Abilities.Skill_Major_Force]                 = true,
    [Abilities.Skill_Major_Protection]            = true,
}

-- High Priority Major Debuffs
BlacklistPresets.MajorDebuffsHigh = {
    [Abilities.Skill_Major_Maim]                  = true,
    [Abilities.Skill_Major_Vulnerability]         = true,
}
