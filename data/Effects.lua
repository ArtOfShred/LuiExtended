------------------
-- Effects namespace
LUIE.Effects = {}

-- Performance Enhancement
local E = LUIE.Effects
local A = LUIE.GetAbility()
local GetAbilityIcon = GetAbilityIcon

--[[----------------------------------------------------------
 * Transition functions:
 * * t - current time
 * * b - start value
 * * c - change in value
 * * d - duration
 * (t and d can be frames or seconds/milliseconds)
--]]----------------------------------------------------------

-- Simple linear tweening - no easing, no acceleration
function E.linearTween(t, b, c, d)
    return c*t/d + b
end

-- Quadratic easing in - accelerating from zero velocity
function E.easeInQuad(t, b, c, d)
    t = t / d
    return c*t*t + b
end

-- Quadratic easing out - decelerating to zero velocity
function E.easeOutQuad(t, b, c, d)
    t = t / d
    return -c * t*(t-2) + b
end

-- Quadratic easing in/out - acceleration until halfway, then deceleration
function E.easeInOutQuad(t, b, c, d)
    t = t / (d/2);
    if (t < 1) then return c/2*t*t + b end
    t = t - 1
    return -c/2 * (t*(t-2) - 1) + b
end

-- Helper function to return custom ability icon
function E.GetAbilityIcon(abilityName, abilityId)
    return E.AbilityIcon[abilityName or ''] or E.EffectIconOverride[abilityId] or GetAbilityIcon(abilityId)
end

-- List of abilities considered for Ultimate generation - same as in SCB
E.IsWeaponAttack = {
    [A.Skill_Light_Attack]              = true,
    [A.Skill_Heavy_Attack]              = true,
    [A.Skill_Heavy_Attack_Dual_Wield]   = true,
    [A.Skill_Heavy_Attack_Bow]          = true,
    [A.Skill_Heavy_Attack_Werewolf]     = true,
}

-- Completely ignored effects
E.IsEffectIgnored = {

}

-- List of toggle abilities
E.IsToggle = {
    [A.Toggled_Hidden]                      = true, -- Hidden (Innate)
    [A.Toggled_Disguised]                   = true, -- Disguised (Innate)
    [A.Toggled_Brace_Generic]               = true, -- Block (Innate)
    [A.Toggled_Sprint]                      = true, -- Sprint (Innate)
    [A.Toggled_Mount_Sprint]                = true, -- Mount Sprint (Generic) (Innate) -- NOTE: Renamed to Gallop in fake buffs
    [A.Toggled_Leeching_Strikes]            = true, -- Leeching Strikes (Nightblade)
    [A.Toggled_Unstable_Familiar]           = true, -- Summon Unstable Familiar (Sorcerer)
    [A.Toggled_Unstable_Clannfear]          = true, -- Summon Unstable Clannfear (Sorcerer)
    [A.Toggled_Volatile_Familiar]           = true, -- Summon Volatile Familiar (Sorcerer)
    [A.Toggled_Summon_Winged_Twilight]      = true, -- Summon Winged Twilight (Sorcerer)
    [A.Toggled_Summon_Twilight_Tormentor]   = true, -- Summon Twilight Tormentor (Sorcerer)
    [A.Toggled_Summon_Twilight_Matriarch]   = true, -- Summon Twilight Matriarch (Sorcerer)
    [A.Toggled_Bound_Armor]                 = true, -- Bound Armor (Sorcerer)
    [A.Toggled_Bound_Armaments]             = true, -- Bound Armaments (Sorcerer)
    [A.Toggled_Bound_Aegis]                 = true, -- Bound Aegis (Sorcerer)
    [A.Toggled_Overload]                    = true, -- Overload (Sorcerer)
    [A.Toggled_Energy_Overload]             = true, -- Energy Overload (Sorcerer)
    [A.Toggled_Power_Overload]              = true, -- Power Overload (Sorcerer)
    [A.Toggled_Guard]                       = true, -- Guard (Support)
    [A.Toggled_Mystic_Guard]                = true, -- Mystic Guard (Support)
    [A.Toggled_Stalwart_Guard]              = true, -- Stalwart Guard (Support)
}

-- Vampire / Lycantropy
E.IsVampLycan = {
    [A.VampLycan_Fed_on_ally]           = true,
    [A.VampLycan_Bit_an_ally]           = true,
    [A.VampLycan_Dark_Stalker]          = true,
    [A.VampLycan_Supernatural_Recovery] = true,
    [A.VampLycan_Stage_1_Vampirism]     = true,
    [A.VampLycan_Stage_2_Vampirism]     = true,
    [A.VampLycan_Stage_3_Vampirism]     = true,
    [A.VampLycan_Stage_4_Vampirism]     = true,
    [A.VampLycan_Vampirism]             = true,
    [A.VampLycan_Lycanthropy]           = true,
    [A.VampLycan_Call_of_the_Pack]      = true,
    [A.VampLycan_Sanies_Lupinus]        = true,
}

-- Mundus passives
E.IsBoon = {
    [A.Boon_Warrior]    = true,
    [A.Boon_Mage]       = true,
    [A.Boon_Serpent]    = true,
    [A.Boon_Thief]      = true,
    [A.Boon_Lady]       = true,
    [A.Boon_Steed]      = true,
    [A.Boon_Lord]       = true,
    [A.Boon_Apprentice] = true,
    [A.Boon_Ritual]     = true,
    [A.Boon_Lover]      = true,
    [A.Boon_Atronach]   = true,
    [A.Boon_Shadow]     = true,
    [A.Boon_Tower]      = true,
}

-- PvP related buffs
E.IsCyrodiil = {
    [11346] = true, -- Home Keep Bonus
    [11341] = true, -- Enemy Keep Bonus I
    [11343] = true, -- Enemy Keep Bonus II
    [11345] = true, -- Enemy Keep Bonus III
    [11347] = true, -- Enemy Keep Bonus IV
    [11348] = true, -- Enemy Keep Bonus V
    [11350] = true, -- Enemy Keep Bonus VI
    [11352] = true, -- Enemy Keep Bonus VII
    [11353] = true, -- Enemy Keep Bonus VIII
    [11356] = true, -- Enemy Keep Bonus IX
    [15060] = true, -- Defensive Scroll Bonus I
    [16350] = true, -- Defensive Scroll Bonus II
    [15058] = true, -- Offensive Scroll Bonus I
    [16348] = true, -- Offensive Scroll Bonus II
    [39671] = true, -- Emperorship Alliance Bonus
    [66282] = true, -- Blessing of War
}

E.IsBattleSpirit = {
    [12033] = true, -- Battle Spirit
}

-- ESO Plus Member
E.IsEsoPlus = {
    [63601] = true,
}

-- List of abilities that have to be purged when first damage is recorded
E.IsGroundMine = {
    [A.Skill_Daedric_Mines]     = true,
    [A.Skill_Daedric_Minefield] = true,
    [A.Skill_Daedric_Tomb]      = true,
    [A.Skill_Fire_Rune]         = true,
    [A.Skill_Scalding_Rune]     = true,
    [A.Skill_Volcanic_Rune]     = true,
    [A.Skill_Trap_Beast]        = true,
}

-- Taunts
E.IsTaunt = {
    [A.Skill_Puncture]      = true,
    [A.Skill_Pierce_Armor]  = true,
    [A.Skill_Ransack]       = true,
    [A.Skill_Inner_Fire]    = true,
    [A.Skill_Inner_Rage]    = true,
    [A.Skill_Inner_Beast]   = true,
}

-- Abilities icons that has to be override the API value returned by GetAbilityIcon(abilityId)
-- List only contains English names. Other languages will use game provided icons
E.AbilityIcon = {
    --[[
    -- Currencies icons
    ['Money']                           = '/EsoUI/Art/Icons/Item_Generic_CoinBag.dds',
    ['Alliance Points']                 = '/EsoUI/Art/Icons/Icon_AlliancePoints.dds',
    ['TelVar Stones']                   = '/EsoUI/Art/Icons/Icon_TelVarStone.dds',
    -- Fix Cleave Bleed Icons
    ['Cleave Bleed']                    = 'esoui/art/icons/ability_2handed_002.dds',
    ['Carve Bleed']                     = 'esoui/art/icons/ability_2handed_002_a.dds',
    ['Brawler Bleed']                   = 'esoui/art/icons/ability_2handed_002_b.dds',
    -- Fix Twin Slashes Bleed Icons
    ['Twin Slashes Bleed']              = 'esoui/art/icons/ability_dualwield_001.dds',
    ['Rending Slashes Bleed']           = 'esoui/art/icons/ability_dualwield_001_a.dds',
    ['Blood Craze Bleed']               = 'esoui/art/icons/ability_dualwield_001_b.dds',
    ['Feed']                            = '/esoui/art/icons/ability_vampire_002.dds', -- EN,FR
    [A.Effect_Magicka_Bomb]            = '/esoui/art/icons/death_recap_magic_ranged.dds', -- EN
    [A.Effect_Surge_Heal]               = '/esoui/art/icons/ability_sorcerer_critical_surge.dds',
    [A.Effect_Dark_Exchange_Heal]       = '/esoui/art/icons/ability_sorcerer_dark_exchange.dds',
    [A.Skill_Dark_Exchange]             = '/esoui/art/icons/ability_sorcerer_dark_exchange.dds',
    ['Blood Magic']                     = '/esoui/art/icons/ability_mage_026.dds', -- EN, ?
    [A.Skill_Healing_Ward]              = '/esoui/art/icons/ability_restorationstaff_001_a.dds',
    [A.Skill_Quick_Siphon]              = '/esoui/art/icons/ability_restorationstaff_005_b.dds',
    ]]--
    -- Temp Major/Minor Buffs before ZOS update adds them 
    ['Empower']                         = 'esoui/art/icons/ability_buff_major_empower.dds',
    ['Major Berserk']                   = 'esoui/art/icons/ability_buff_major_berserk.dds',
    ['Major Brutality']                 = 'esoui/art/icons/ability_buff_major_brutality.dds',
    --['Major Empower']                 = 'esoui/art/icons/ability_buff_major_empower.dds',
    ['Major Endurance']                 = 'esoui/art/icons/ability_buff_major_endurance.dds',
    ['Major Erosion']                   = 'esoui/art/icons/ability_buff_major_erosion.dds',
    ['Major Evasion']                   = 'esoui/art/icons/ability_buff_major_evasion.dds',
    ['Major Expedition']                = 'esoui/art/icons/ability_buff_major_expedition.dds',
    ['Major Force']                     = 'esoui/art/icons/ability_buff_major_force.dds',
    ['Major Fortitude']                 = 'esoui/art/icons/ability_buff_major_fortitude.dds',
    ['Major Heroism']                   = 'esoui/art/icons/ability_buff_major_heroism.dds',
    ['Major Intellect']                 = 'esoui/art/icons/ability_buff_major_intellect.dds',
    ['Major Lifesteal']                 = 'esoui/art/icons/ability_buff_major_lifesteal.dds',
    ['Major Magickasteal']              = 'esoui/art/icons/ability_buff_major_magickasteal.dds',
    ['Major Mending']                   = 'esoui/art/icons/ability_buff_major_mending.dds',
    ['Major Prophecy']                  = 'esoui/art/icons/ability_buff_major_prophecy.dds',
    ['Major Protection']                = 'esoui/art/icons/ability_buff_major_protection.dds',
    ['Major Resolve']                   = 'esoui/art/icons/ability_buff_major_resolve.dds',
    ['Major Savagery']                  = 'esoui/art/icons/ability_buff_major_savagery.dds',
    ['Major Sorcery']                   = 'esoui/art/icons/ability_buff_major_sorcery.dds',
    ['Major Vitality']                  = 'esoui/art/icons/ability_buff_major_vitality.dds',
    ['Major Ward']                      = 'esoui/art/icons/ability_buff_major_ward.dds',
    ['Minor Berserk']                   = 'esoui/art/icons/ability_buff_minor_berserk.dds',
    ['Minor Brutality']                 = 'esoui/art/icons/ability_buff_minor_brutality.dds',
    --['Minor Empower']                 = 'esoui/art/icons/ability_buff_minor_empower.dds',
    ['Minor Endurance']                 = 'esoui/art/icons/ability_buff_minor_endurance.dds',
    ['Minor Erosion']                   = 'esoui/art/icons/ability_buff_minor_erosion.dds',
    ['Minor Evasion']                   = 'esoui/art/icons/ability_buff_minor_evasion.dds',
    ['Minor Expedition']                = 'esoui/art/icons/ability_buff_minor_expedition.dds',
    ['Minor Force']                     = 'esoui/art/icons/ability_buff_minor_force.dds',
    ['Minor Fortitude']                 = 'esoui/art/icons/ability_buff_minor_fortitude.dds',
    ['Minor Heroism']                   = 'esoui/art/icons/ability_buff_minor_heroism.dds',
    ['Minor Intellect']                 = 'esoui/art/icons/ability_buff_minor_intellect.dds',
    ['Minor Lifesteal']                 = 'esoui/art/icons/ability_buff_minor_lifesteal.dds',
    ['Minor Magickasteal']              = 'esoui/art/icons/ability_buff_minor_magickasteal.dds',
    ['Minor Mending']                   = 'esoui/art/icons/ability_buff_minor_mending.dds',
    ['Minor Prophecy']                  = 'esoui/art/icons/ability_buff_minor_prophecy.dds',
    ['Minor Protection']                = 'esoui/art/icons/ability_buff_minor_protection.dds',
    ['Minor Resolve']                   = 'esoui/art/icons/ability_buff_minor_resolve.dds',
    ['Minor Savagery']                  = 'esoui/art/icons/ability_buff_minor_savagery.dds',
    ['Minor Sorcery']                   = 'esoui/art/icons/ability_buff_minor_sorcery.dds',
    ['Minor Vitality']                  = 'esoui/art/icons/ability_buff_minor_vitality.dds',
    ['Minor Ward']                      = 'esoui/art/icons/ability_buff_minor_ward.dds',
    ['Major Breach']                    = 'esoui/art/icons/ability_debuff_major_breach.dds',
    ['Major Cowardice']                 = 'esoui/art/icons/ability_debuff_major_cowardice.dds',
    ['Major Defile']                    = 'esoui/art/icons/ability_debuff_major_defile.dds',
    ['Major Enervation']                = 'esoui/art/icons/ability_debuff_major_enervation.dds',
    ['Major Fracture']                  = 'esoui/art/icons/ability_debuff_major_fracture.dds',
    ['Major Hindrance']                 = 'esoui/art/icons/ability_debuff_major_hindrance.dds',
    ['Major Maim']                      = 'esoui/art/icons/ability_debuff_major_maim.dds',
    ['Major Mangle']                    = 'esoui/art/icons/ability_debuff_major_mangle.dds',
    ['Major Uncertainty']               = 'esoui/art/icons/ability_debuff_major_uncertainty.dds',
    ['Major Vulnerability']             = 'esoui/art/icons/ability_debuff_major_vulnerability.dds',
    ['Minor Breach']                    = 'esoui/art/icons/ability_debuff_minor_breach.dds',
    ['Minor Cowardice']                 = 'esoui/art/icons/ability_debuff_minor_cowardice.dds',
    ['Minor Defile']                    = 'esoui/art/icons/ability_debuff_minor_defile.dds',
    ['Minor Enervation']                = 'esoui/art/icons/ability_debuff_minor_ennervation.dds',
    ['Minor Fracture']                  = 'esoui/art/icons/ability_debuff_minor_fracture.dds',
    ['Minor Hindrance']                 = 'esoui/art/icons/ability_debuff_minor_hindrance.dds',
    ['Minor Maim']                      = 'esoui/art/icons/ability_debuff_minor_maim.dds',
    ['Minor Mangle']                    = 'esoui/art/icons/ability_debuff_minor_mangle.dds',
    ['Minor Uncertainty']               = 'esoui/art/icons/ability_debuff_minor_uncertainty.dds',
    ['Minor Vulnerability']             = 'esoui/art/icons/ability_debuff_minor_vulnerability.dds',
}

-- Filter out Debuffs to always display regardless of whether they are sourced from the player - BY ID
E.DebuffDisplayOverrideId = {
    [2727] = true, -- Off-Balance
}

-- Filter out Debuffs to always display regardless of whether they are sourced from the player - BY NAME
E.DebuffDisplayOverrideName = {
    ['Major Breach']                    = true,
    ['Major Cowardice']                 = true,
    ['Major Defile']                    = true,
    ['Major Enervation']                = true,
    ['Major Fracture']                  = true,
    ['Major Hindrance']                 = true,
    ['Major Maim']                      = true,
    ['Major Mangle']                    = true,
    ['Major Uncertainty']               = true,
    ['Major Vulnerability']             = true,
    ['Minor Breach']                    = true,
    ['Minor Cowardice']                 = true,
    ['Minor Defile']                    = true,
    ['Minor Enervation']                = true,
    ['Minor Fracture']                  = true,
    ['Minor Hindrance']                 = true,
    ['Minor Maim']                      = true,
    ['Minor Mangle']                    = true,
    ['Minor Uncertainty']               = true,
    ['Minor Vulnerability']             = true,
}

E.DisguiseIcons = {
    [2571]  = { name = 'Midnight Union Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_midnight_union_disguise.dds', description = 'as a Midnight Union thief.' },
    [27266] = { name = 'Vanguard Uniform', icon = 'LuiExtended/media/icons/disguises/disguise_vanguard_uniform.dds', description = 'as a soldier in Tanval\'s Vanguard.' },
    [29536] = { name = 'Stormfist Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_stormfist_disguise.dds', description = 'as a Stormfist soldier.' },
    [40283] = { name = 'Keeper\'s Garb', icon = 'LuiExtended/media/icons/disguises/disguise_keepers_garb.dds', description = 'as a Keeper of the Shell.' },
    [40286] = { name = 'Seadrake Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_seadrake_disguise.dds', description = 'as a Seadrake pirate.' },
    [40294] = { name = 'Pirate Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_pirate_disguise.dds', description = 'as a Blackheart Haven pirate.' },
    [40296] = { name = 'Red Rook Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_red_rook_disguise.dds', description = 'as a Red Rook bandit.' },
    [42413] = { name = 'Colovian Uniform', icon = 'LuiExtended/media/icons/disguises/disguise_colovian_uniform.dds', description = 'as a Colovian soldier.' },
    [42736] = { name = 'Servant\'s Robes', icon = 'LuiExtended/media/icons/disguises/disguise_servants_robes.dds', description = 'as a servant of Headman Bhosek.' },
    [43046] = { name = 'Forebear Dishdasha', icon = 'LuiExtended/media/icons/disguises/disguise_forebear_dishdasha.dds', description = 'as a member of the Forebears.' },
    [43047] = { name = 'Crown Dishdasha', icon = 'LuiExtended/media/icons/disguises/disguise_crown_dishdasha.dds', description = 'as a member of the Crowns.' },
    [43508] = { name = 'Seaside Sanctuary Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'in a Seaside Sanctuary disguise.' }, -- NO ICON (Probably doesn't exist)
    [43511] = { name = 'Sea Viper Armor', icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Maormer soldier.' }, -- NO ICON
    [43515] = { name = 'Imperial Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_imperial_disguise.dds', description = 'as an Imperial soldier.' },
    [44448] = { name = 'Frostedge Bandit Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_frostedge_bandit_disguise.dds', description = 'as a Frostedge bandit.' },
    [44580] = { name = 'Hollow Moon Garb', icon = 'LuiExtended/media/icons/disguises/disguise_hollow_moon_garb.dds', description = 'as a member of the Hollow Moon.' },
    [44587] = { name = 'Northwind Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_northwind_disguise.dds', description = 'as a Stonetalon clan member.' },
    [44697] = { name = 'Hallin\'s Stand Seventh Legion Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_hallins_stand_seventh_legion_disguise.dds', description = 'as a member of the Seventh Legion.' },
    [45006] = { name = 'Phaer Mercenary Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_phaer_mercenary_disguise.dds', description = 'as a Phaer mercenary.' },
    [45007] = { name = 'Quendeluun Veiled Heritance Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_quendeluun_veiled_heritance_disguise.dds', description = 'as a member of the invading Ebonheart Pact forces.' },
    [45008] = { name = 'Vulkhel Guard Marine Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_vulkhel_guard_marine_disguise.dds', description = 'as a First Auridon Marine.' },
    [45781] = { name = 'Kollopi Essence', icon = 'LuiExtended/media/icons/disguises/disguise_kollopi_essence.dds', description = 'by the Kollopi Essence.' },
    [45803] = { name = 'Bloodthorn Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_bloodthorn_disguise.dds', description = 'as a Bloodthorn Cultist.' },
    [54332] = { name = 'Fort Amol Guard Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_fort_amol_guard_disguise.dds', description = 'as a Fort Amol guard.' },
    [54380] = { name = 'Steel Shrike Uniform', icon = 'LuiExtended/media/icons/disguises/disguise_steel_shrike_uniform.dds', description = 'as a member of the Steel Shrikes.' },
    [54483] = { name = 'Courier Uniform', icon = 'LuiExtended/media/icons/disguises/disguise_courier_uniform.dds', description = 'as a Gold Coast mercenary courier.' },
    [54994] = { name = 'Shadowsilk Gem', icon = 'LuiExtended/media/icons/disguises/disguise_shadowsilk_gem.dds', description = 'as a Shadowsilk Goblin.' },
    [55014] = { name = 'Wolfbane Watch Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a member of Wolfbane Watch.' }, -- (Not sure it exists)
    [64260] = { name = 'Dunmer Cultural Garb', icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'in colorful Dark Elf clothing.' }, -- NO ICON (Not sure it exists)
    [71090] = { name = 'Servant\'s Outfit', icon = 'LuiExtended/media/icons/disguises/disguise_servants_outfit.dds', description = 'as a servant of the Iron Wheel.' },
    [71541] = { name = 'Castle Kvatch Sentinel Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Castle Kvatch sentinel.' }, -- NO ICON (Not sure it exists)
    [71789] = { name = 'Castle Kvatch Sentinel Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Castle Kvatch sentinel.' }, -- NO ICON (Not sure it exists)
    --[79332] = { name = 'Monk\'s Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds', description = 'as a monk.' }, -- HAS AN AURA SO NOT NECESSARY (Note - we make an exception to HIDE this itemId to prevent errors)
    [79505] = { name = 'Sentinel Guard Disguise', icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Sentinel Guard.' }, -- NO ICON (Not sure it exists)
    [55262] = { name = 'Guild Tabard', icon = 'LuiExtended/media/icons/disguises/disguise_guild_tabard.dds' },
}

E.MountIcons = {
    [1]  = { name = 'Sorrel Horse', icon = 'LuiExtended/media/icons/mounts/mount_sorrel_horse.dds' },
    [2]  = { name = 'Brown Paint Horse', icon = 'LuiExtended/media/icons/mounts/mount_brown_paint_horse.dds' },
    [3]  = { name = 'Bay Dun Horse', icon = 'LuiExtended/media/icons/mounts/mount_bay_dun_horse.dds' },
    [4]  = { name = 'Midnight Steed', icon = 'LuiExtended/media/icons/mounts/mount_midnight_steed.dds' },
    [5]  = { name = 'Imperial Horse', icon = 'LuiExtended/media/icons/mounts/mount_imperial_horse.dds' },
    [6]  = { name = 'Palomino Horse', icon = 'LuiExtended/media/icons/mounts/mount_palomino_horse.dds' },
    [8]  = { name = 'Green Narsis Guar', icon = 'LuiExtended/media/icons/mounts/mount_green_narsis_guar.dds' },
    [9]  = { name = 'Golden Eye Guar', icon = 'LuiExtended/media/icons/mounts/mount_golden_eye_guar.dds' },
    [10] = { name = 'Banded Guar Charger', icon = 'LuiExtended/media/icons/mounts/mount_banded_guar_charger.dds' },
    [12] = { name = 'Senche-Leopard', icon = 'LuiExtended/media/icons/mounts/mount_senche-leopard.dds' },
    [11] = { name = 'Tessellated Guar', icon = 'LuiExtended/media/icons/mounts/mount_tessellated_guar.dds' },
    [13] = { name = 'Clouded Senche-Leopard', icon = 'LuiExtended/media/icons/mounts/mount_clouded_senche-leopard.dds' },
    [14] = { name = 'Black Senche-Panther', icon = 'LuiExtended/media/icons/mounts/mount_black_senche-panther.dds' },
    [15] = { name = 'Senche-Lioness', icon = 'LuiExtended/media/icons/mounts/mount_senche-lioness.dds' },
    [19] = { name = 'Piebald Destrier', icon = 'LuiExtended/media/icons/mounts/mount_piebald_destrier.dds' },
    [20] = { name = 'White Mane Horse', icon = 'LuiExtended/media/icons/mounts/mount_white_mane_horse.dds' },
    [21] = { name = 'Dapple Grey Palfrey', icon = 'LuiExtended/media/icons/mounts/mount_dapple_grey_palfrey.dds'},
    [22] = { name = 'Striped Senche-Tiger', icon = 'LuiExtended/media/icons/mounts/mount_striped_senche-tiger.dds'},
    [23] = { name = 'Nightmare Courser', icon = 'LuiExtended/media/icons/mounts/mount_nightmare_courser.dds' },
    [25] = { name = 'Frost Mare', icon = 'LuiExtended/media/icons/mounts/mount_frost_mare.dds' },
    [26] = { name = 'Mind-Shriven Horse', icon = 'LuiExtended/media/icons/mounts/mount_mind-shriven_horse.dds' },
    [27] = { name = 'Cave Bear', icon = 'LuiExtended/media/icons/mounts/mount_cave_bear.dds' },
    [31] = { name = 'Snow Bear', icon = 'LuiExtended/media/icons/mounts/mount_snow_bear.dds' },
    [32] = { name = 'Black Bear', icon = 'LuiExtended/media/icons/mounts/mount_black_bear.dds' },
    [35] = { name = 'Hammerfell Camel', icon = 'LuiExtended/media/icons/mounts/mount_hammerfell_camel.dds' },
    [38] = { name = 'Dro-m\'Athra Senche', icon = 'LuiExtended/media/icons/mounts/mount_dro-mathra_senche.dds' },
    [40] = { name = 'Black Camel of Ill Omen', icon = 'LuiExtended/media/icons/mounts/mount_black_camel_of_ill_omen.dds' },
    [42] = { name = 'Pride-King Lion', icon = 'LuiExtended/media/icons/mounts/mount_pride-king_lion.dds' },
    [44] = { name = 'Wild Hunt Horse', icon = 'LuiExtended/media/icons/mounts/mount_wild_hunt_horse.dds' },
    [45] = { name = 'Wild Hunt Senche', icon = 'LuiExtended/media/icons/mounts/mount_wild_hunt_senche.dds' },
    [46] = { name = 'Wild Hunt Guar', icon = 'LuiExtended/media/icons/mounts/mount_wild_hunt_guar.dds' },
    [47] = { name = 'Wild Hunt Bear Mount', icon = 'LuiExtended/media/icons/mounts/mount_wild_hunt_bear.dds' },
    [49] = { name = 'Highland Wolf', icon = 'LuiExtended/media/icons/mounts/mount_highland_wolf.dds' },
    [50] = { name = 'Doom Wolf', icon = 'LuiExtended/media/icons/mounts/mount_doom_wolf.dds' },
    [52] = { name = 'Red Pit Wolf', icon = 'LuiExtended/media/icons/mounts/mount_red_pit_wolf.dds' },
    [54] = { name = 'Storm Atronach Horse', icon = 'LuiExtended/media/icons/mounts/mount_storm_atronach_horse.dds' },
    [55] = { name = 'Storm Atronach Senche', icon = 'LuiExtended/media/icons/mounts/mount_storm_atronach_senche.dds' },
    [56] = { name = 'Hist Guar', icon = 'LuiExtended/media/icons/mounts/mount_hist_guar.dds' },
    [60] = { name = 'Storm Atronach Camel', icon = 'LuiExtended/media/icons/mounts/mount_storm_atronach_camel.dds' },
    [63] = { name = 'Storm Atronach Bear', icon = 'LuiExtended/media/icons/mounts/mount_storm_atronach_bear.dds' },
    [64] = { name = 'Storm Atronach Guar', icon = 'LuiExtended/media/icons/mounts/mount_storm_atronach_guar.dds' },
    [65] = { name = 'Storm Atronach Wolf', icon = 'LuiExtended/media/icons/mounts/mount_storm_atronach_wolf.dds' },
    [66] = { name = 'Black Mane Lion', icon = 'LuiExtended/media/icons/mounts/mount_black_mane_lion.dds' },
    [67] = { name = 'Wild Hunt Wolf Mount', icon = 'LuiExtended/media/icons/mounts/mount_wild_hunt_wolf.dds' },
    [68] = { name = 'Wild Hunt Camel', icon = 'LuiExtended/media/icons/mounts/mount_wild_hunt_camel.dds' },
    [71] = { name = 'Alliance War Horse', icon = 'LuiExtended/media/icons/mounts/mount_alliance_war_horse.dds' }, -- AD
    [72] = { name = 'Alliance War Horse', icon = 'LuiExtended/media/icons/mounts/mount_alliance_war_horse.dds' }, -- EP
    [73] = { name = 'Alliance War Horse', icon = 'LuiExtended/media/icons/mounts/mount_alliance_war_horse.dds' }, -- DC
    [78] = { name = 'Sabre Cat', icon = 'LuiExtended/media/icons/mounts/mount_sabre_cat.dds'}
}

E.PetIcons = {
    ['Abecean Ratter Cat']          = 'LuiExtended/media/icons/pets/pet_abecean_ratter_cat.dds',
    ['Alik\'r Dune-Hound']          = 'LuiExtended/media/icons/pets/pet_alikr_dune-hound.dds',
    ['Alliance War Dog']            = 'LuiExtended/media/icons/pets/pet_alliance_war_dog.dds',
    ['Ancestor Moth Swarm']         = 'LuiExtended/media/icons/pets/pet_ancestor_moth_swarm.dds',
    ['Baby Netch']                  = 'LuiExtended/media/icons/pets/pet_baby_netch.dds',
    ['Bal Foyen Nix-Hound']         = 'LuiExtended/media/icons/pets/pet_bal_foyen_nix-hound.dds',
    ['Banekin']                     = 'LuiExtended/media/icons/pets/pet_banekin.dds',
    ['Bantam Guar']                 = 'LuiExtended/media/icons/pets/pet_bantam_guar.dds',
    ['Black Bear Cub']              = 'LuiExtended/media/icons/pets/pet_black_bear_cub.dds',
    ['Black Cat']                   = 'LuiExtended/media/icons/pets/pet_black_cat.dds',
    ['Black Mask Bear-Dog']         = 'LuiExtended/media/icons/pets/pet_black_mask_bear-dog.dds',
    ['Black Senche-Panther Kitten'] = 'LuiExtended/media/icons/pets/pet_black_senche-panther_kitten.dds',
    ['Blue Oasis Dragon Frog']      = 'LuiExtended/media/icons/pets/pet_blue_oasis_dragon_frog.dds',
    ['Bravil Retriever']            = 'LuiExtended/media/icons/pets/pet_bravil_retriever.dds',
    ['Bristlegut Piglet']           = 'LuiExtended/media/icons/pets/pet_bristlegut_piglet.dds',
    ['Cave Bear Cub']               = 'LuiExtended/media/icons/pets/pet_cave_bear_cub.dds',
    ['Chub Loon']                   = 'LuiExtended/media/icons/pets/pet_chub_loon.dds',
    ['Clouded Senche-Leopard Cub']  = 'LuiExtended/media/icons/pets/pet_clouded_senche-leopard_cub.dds',
    ['Cobalt Sep Adder']            = 'LuiExtended/media/icons/pets/pet_cobalt_sep_adder.dds',
    ['Colovian Badger']             = 'LuiExtended/media/icons/pets/pet_colovian_badger.dds',
    ['Crony Scrib']                 = 'LuiExtended/media/icons/pets/pet_crony_scrib.dds',
    ['Deadrat']                     = 'LuiExtended/media/icons/pets/pet_daedrat.dds',
    ['Daedric Scamp']               = 'LuiExtended/media/icons/pets/pet_daedric_scamp.dds',
    ['Dark Moons Lynx']             = 'LuiExtended/media/icons/pets/pet_dark_moons_lynx.dds',
    ['Desert Lynx']                 = 'LuiExtended/media/icons/pets/pet_desert_lynx.dds',
    ['Doom Wolf Pup']               = 'LuiExtended/media/icons/pets/pet_doom_wolf_pup.dds',
    ['Dragontail Goat']             = 'LuiExtended/media/icons/pets/pet_dragontail_goat.dds',
    ['Echalette']                   = 'LuiExtended/media/icons/pets/pet_echalette.dds',
    ['Fennec Fox']                  = 'LuiExtended/media/icons/pets/pet_fennec_fox.dds',
    ['Fiendroth']                   = 'LuiExtended/media/icons/pets/pet_fiendroth.dds',
    ['Freckled Guar']               = 'LuiExtended/media/icons/pets/pet_freckled_guar.dds',
    ['Haj Mota Hatchling']          = 'LuiExtended/media/icons/pets/pet_haj_mota_hatchling.dds',
    ['Helstrom Ancestor Lizard']    = 'LuiExtended/media/icons/pets/pet_helstrom_ancestor_lizard.dds',
    ['High Hrothgar Wraith']        = 'LuiExtended/media/icons/pets/pet_high_hrothgar_wraith.dds',
    ['Housecat']                    = 'LuiExtended/media/icons/pets/pet_housecat.dds',
    ['Imgakin Monkey']              = 'LuiExtended/media/icons/pets/pet_imgakin_monkey.dds',
    ['Infernal Sep Adder']          = 'LuiExtended/media/icons/pets/pet_infernal_sep_adder.dds',
    ['Jackal']                      = 'LuiExtended/media/icons/pets/pet_jackal.dds',
    ['Kindlespit Dragon Frog']      = 'LuiExtended/media/icons/pets/pet_kindlespit_dragon_frog.dds',
    ['Loyal Dwarven Sphere']        = 'LuiExtended/media/icons/pets/pet_loyal_dwarven_sphere.dds',
    ['Markarth Bear-Dog']           = 'LuiExtended/media/icons/pets/pet_markarth_bear-dog.dds',
    ['Monkey']                      = 'LuiExtended/media/icons/pets/pet_money.dds',
    ['Moonlight Senche-Tiger']      = 'LuiExtended/media/icons/pets/pet_moonlight_senche-tiger.dds',
    ['Necrotic Hoarvor']            = 'LuiExtended/media/icons/pets/pet_necrotic_hoarvor.dds',
    ['Nibenay Mudcrab']             = 'LuiExtended/media/icons/pets/pet_nibenay_mudcrab.dds',
    ['Northern Lynx']               = 'LuiExtended/media/icons/pets/pet_norther_lynx.dds',
    ['Orchid Nixad']                = 'LuiExtended/media/icons/pets/pet_orchid_nixad.dds',
    ['Pocket Mammoth']              = 'LuiExtended/media/icons/pets/pet_pocket_mammoth.dds',
    ['Psijic Domin Pig']            = 'LuiExtended/media/icons/pets/pet_psijic_domino_pig.dds',
    ['Purple Daggerback']           = 'LuiExtended/media/icons/pets/pet_purple_daggerback.dds',
    ['Razak\'s Opus']               = 'LuiExtended/media/icons/pets/pet_razaks_opus.dds',
    ['Red Pit Wolf Pup']            = 'LuiExtended/media/icons/pets/pet_red_pit_wolf_pup.dds',
    ['Rosy Netch Calf']             = 'LuiExtended/media/icons/pets/pet_rosy_netch_calf.dds',
    ['Rufous Mudcrab']              = 'LuiExtended/media/icons/pets/pet_rufous_mudcrab.dds',
    ['Sabre Cat Cub']               = 'LuiExtended/media/icons/pets/pet_sabre_cat_cub.dds',
    ['Sanguine\'s Black Goat']      = 'LuiExtended/media/icons/pets/pet_sanguines_black_goat.dds',
    ['Senche-Lion Cub']             = 'LuiExtended/media/icons/pets/pet_senche-lion_cub.dds',
    ['Sep Adder']                   = 'LuiExtended/media/icons/pets/pet_sep_adder.dds',
    ['Shornhelm Shepherd']          = 'LuiExtended/media/icons/pets/pet_shornhelm_shepherd.dds',
    ['Snow Bear Cub']               = 'LuiExtended/media/icons/pets/pet_snow_bear_cub.dds',
    ['Stonefire Scamp']             = 'LuiExtended/media/icons/pets/pet_stonefire_scamp.dds',
    ['Striated Pony Guar']          = 'LuiExtended/media/icons/pets/pet_striated_pony_guar.dds',
    ['Striped Senche-Panther']      = 'LuiExtended/media/icons/pets/pet_striped_senche-panther.dds',
    ['Sylvan Nixad']                = 'LuiExtended/media/icons/pets/pet_sylvan_nixad.dds',
    ['Tangerine Dragon Frog']       = 'LuiExtended/media/icons/pets/pet_tangerine_dragon_frog.dds',
    ['Turquoise Nixad']             = 'LuiExtended/media/icons/pets/pet_turquoise_nixad.dds',
    ['Vermilion Scuttler']          = 'LuiExtended/media/icons/pets/pet_vermilion_scuttler.dds',
    ['Whiterun Wolfhound']          = 'LuiExtended/media/icons/pets/pet_whiterun_wolfhound.dds',
    ['Windhelm Wolfhound']          = 'LuiExtended/media/icons/pets/pet_windhelm_wolfhound.dds',
}

E.AssistantIcons = {
    ['Nuzhimeh the Merchant']       = 'LuiExtended/media/icons/assistants/assistant_nuzhimeh_the_merchant.dds',
    ['Pirharri the Smuggler']       = 'LuiExtended/media/icons/assistants/assistant_pirharri_the_smuggler.dds',
    ['Tythis Andromo, the Banker']  = 'LuiExtended/media/icons/assistants/assistant_tythis_andromo_the_banker.dds',
}

E.PolymorphIcons = {
    ['Cadaverous Assassin'] = 'LuiExtended/media/icons/polymorphs/polymorph_cadvaerous_assassin.dds',
    ['Draugr']              = 'LuiExtended/media/icons/polymorphs/polymorph_draugr.dds',
    ['Maelstrom Baron']     = 'LuiExtended/media/icons/polymorphs/polymorph_maelstrom_baron.dds',
    ['Pumpkin Spectre']     = 'LuiExtended/media/icons/polymorphs/polymorph_pumpkin_spectre.dds',
    ['Scarecrow Spectre']   = 'LuiExtended/media/icons/polymorphs/polymorph_scarecrow_spectre.dds',
    ['Skeleton']            = 'LuiExtended/media/icons/polymorphs/polymorph_skeleton.dds',
    ['Werewolf Lord']       = 'LuiExtended/media/icons/polymorphs/polymorph_werewolf_lord.dds',
    ['Xivkyn Augur']        = 'LuiExtended/media/icons/polymorphs/polymorph_xivkyn_augur.dds',
    ['Xivkyn Dreadguard']   = 'LuiExtended/media/icons/polymorphs/polymorph_xivkyn_dreadguard.dds',
    ['Xivkyn Tormenter']    = 'LuiExtended/media/icons/polymorphs/polymorph_xivkyn_tormenter.dds',
}

E.SkinIcons = {
    ['Amber Plasm Skin Daub'] = 'LuiExtended/media/icons/skins/skin_amber_plasm_skin_daub.dds',
    ['Dro-m\'Athra']          = 'LuiExtended/media/icons/skins/skin_dro-mathra.dds',
    ['Mind-Shriven']          = 'LuiExtended/media/icons/skins/skin_mind-shriven.dds',
    ['Soul-Shriven']          = 'LuiExtended/media/icons/skins/skin_soul-shriven.dds',
    ['Spiderkith']            = 'LuiExtended/media/icons/skins/skin_spiderkith.dds',
}

E.HatIcons = {
    ['12-Point Antler Skullcap']        = 'LuiExtended/media/icons/hats/hat_12-point_antler_skullcap.dds',
    ['14-Point Antler Skullcap']        = 'LuiExtended/media/icons/hats/hat_14-point_antler_skullcap.dds',
    ['Abah\'s Watch Turban with Mask']  = 'LuiExtended/media/icons/hats/hat_abahs_watch_turban.dds',
    ['Abah\'s Watch Turban']            = 'LuiExtended/media/icons/hats/hat_abahs_watch_turban_with_mask.dds',
    ['Alliance Rider Hood']             = 'LuiExtended/media/icons/hats/hat_alliance_rider_hood.dds',
    ['Ass-Ears Jester Cap']             = 'LuiExtended/media/icons/hats/hat_ass-ears_jester_cap.dds',
    ['Bi-Color Coxcomb Cap']            = 'LuiExtended/media/icons/hats/hat_bi-color_coxcomb_cap.dds',
    ['Cadwell\'s Helm of Heroism']      = 'LuiExtended/media/icons/hats/hat_cadwells_helm_of_heroism.dds',
    ['\"Clever Man\" Wizard Hat']       = 'LuiExtended/media/icons/hats/hat_clever_man_wizard_hat.dds',
    ['Colovian Filigreed Hood']         = 'LuiExtended/media/icons/hats/hat_colovian_filigreed_hood.dds',
    ['Colovian Fur Hood']               = 'LuiExtended/media/icons/hats/hat_colovian_fur_hood.dds',
    ['Crown of Misrule']                = 'LuiExtended/media/icons/hats/hat_crown_of_misrule.dds',
    ['Dwarf-Style Mage\'s Hat']         = 'LuiExtended/media/icons/hats/hat_dwarf-style_mages_hat.dds',
    ['Feathered Bycoket Cap']           = 'LuiExtended/media/icons/hats/hat_feathered_bycoket_cap.dds',
    ['Fibonaccus Spiral Hat']           = 'LuiExtended/media/icons/hats/hat_fibonaccus_spiral_hat.dds',
    ['Flannel Forester\'s Hood']        = 'LuiExtended/media/icons/hats/hat_flannel_foresters_hood.dds',
    ['Fool\'s Cap and Masque']          = 'LuiExtended/media/icons/hats/hat_fools_cap_and_masque.dds',
    ['Forester\'s Hood with Flower']    = 'LuiExtended/media/icons/hats/hat_foresters_hood_with_flower.dds',
    ['Hedge Wizard\'s Claw Cap']        = 'LuiExtended/media/icons/hats/hat_hedge_wizards_claw_cap.dds',
    ['Imperial Mananaut Cap & Goggles'] = 'LuiExtended/media/icons/hats/hat_imperial_mananaut_cap_&_goggles.dds',
    ['Jhunal\'s Owl Mask']              = 'LuiExtended/media/icons/hats/hat_jhunals_owl_mask.dds',
    ['New Life Festival Cap']           = 'LuiExtended/media/icons/hats/hat_new_life_festival_cap.dds',
    ['New Life Monk\'s Ca']             = 'LuiExtended/media/icons/hats/hat_new_life_monks_cap.dds',
    ['Pumpkin Spectre Mask']            = 'LuiExtended/media/icons/hats/hat_pumpkin_spectre_mask.dds',
    ['Rajhin\'s Cat Mask']              = 'LuiExtended/media/icons/hats/hat_rajhins_cat_mask.dds',
    ['Rootbrim Hat with Flower']       = 'LuiExtended/media/icons/hats/hat_rootbrim_hat_with_flower.dds',
    ['Scarecrow Spectre Mask']          = 'LuiExtended/media/icons/hats/hat_scarecrow_spectre_mask.dds',
    ['Silvenari Felt Bycoket']          = 'LuiExtended/media/icons/hats/hat_silvenari_felt_bycoket.dds',
    ['Sun\'s Dusk Winter Hood']         = 'LuiExtended/media/icons/hats/hat_suns_dusk_winter_hood.dds',
    ['Upright Antler Skullcap']         = 'LuiExtended/media/icons/hats/hat_upright_antler_skullcap.dds',
    ['Vosh Rakh Ceremonial Mask']       = 'LuiExtended/media/icons/hats/hat_vosh_rakh_ceremonial_mask.dds',
    ['Wild Hunt Antler Skullcap']       = 'LuiExtended/media/icons/hats/hat_wild_hunt_antler_skullcap.dds',
    ['Wild Hunt Rootbrim Hat']          = 'LuiExtended/media/icons/hats/hat_wild_hunt_rootbrim_hat.dds',
    ['Z\'en Vengeance Kiss-Me-Not Cap'] = 'LuiExtended/media/icons/hats/hat_zen_vengeance_kiss-me-not_cap.dds',
}

E.CostumeIcons = {
    ['\"Brilliance\" Brocade Robes']     = 'LuiExtended/media/icons/costumes/costume_brilliance_brocade_robes.dds',
    ['\"Drifting Sand\" Tunic and Sash'] = 'LuiExtended/media/icons/costumes/costume_drifting_sand_tunic_and_sash.dds',
    ['\"Elder Council\" Tunic and Sash'] = 'LuiExtended/media/icons/costumes/costume_elder_council_tunic_and_sash.dds',
    ['\"Eternity\" Tunic with Pants']    = 'LuiExtended/media/icons/costumes/costume_eternity_tunic_with_pants.dds',
    ['\"Song of the Night\" Ensemble']   = 'LuiExtended/media/icons/costumes/costume_song_of_the_night_ensemble.dds',
    ['\"Vested Interest\" Banquet Garb'] = 'LuiExtended/media/icons/costumes/costume_vested_interest_banquet_garb.dds',
    ['Alliance Rider Outfit']            = 'LuiExtended/media/icons/costumes/costume_alliance_rider_outfit.dds',
    ['Ashlander Kagesh Tribe Armor']     = 'LuiExtended/media/icons/costumes/costume_ashlander_kagesh_tribe_armor.dds',
    ['Ashlander Mabrigash Hunt Clothes'] = 'LuiExtended/media/icons/costumes/costume_ashlander_mabrigash_hunt_clothes.dds',
    ['Ashlander Mabrigash Travel Wear']  = 'LuiExtended/media/icons/costumes/costume_ashlander_mabrigash_travel_wear.dds',
    ['Battlemage Palatine Armor']        = 'LuiExtended/media/icons/costumes/costume_battlemage_palatine_armor.dds',
    ['Battlemage Scout Captain Uniform'] = 'LuiExtended/media/icons/costumes/costume_battlemage_scout_captain_uniform.dds',
    ['Battlemage Tribune Armor']         = 'LuiExtended/media/icons/costumes/costume_battlemage_tribune_armor.dds',
    ['Black Hand Robe']                  = 'LuiExtended/media/icons/costumes/costume_black_hand_robe.dds',
    ['Black Marsh Keeper']               = 'LuiExtended/media/icons/costumes/costume_black_marsh_keeper.dds',
    ['Blacksmith']                       = 'LuiExtended/media/icons/costumes/costume_blacksmith.dds',
    ['Breton Hero Armor']                = 'LuiExtended/media/icons/costumes/costume_breton_hero_armor.dds',
    ['Cavalier of the Sworn Oath']       = 'LuiExtended/media/icons/costumes/costume_cavalier_of_the_sworn_oath.dds',
    ['Centurion Dress Armor']            = 'LuiExtended/media/icons/costumes/costume_centurion_dress_armor.dds',
    ['Centurion Field Armor']            = 'LuiExtended/media/icons/costumes/costume_centurion_field_armor.dds',
    ['Chef']                             = 'LuiExtended/media/icons/costumes/costume_chef.dds',
    ['City Isle Tunic Dress']            = 'LuiExtended/media/icons/costumes/costume_city_isle_tunic_dress.dds',
    ['Classic Ordinator Armor']          = 'LuiExtended/media/icons/costumes/costume_classic_ordinator_armor.dds',
    ['Corseted Riding Outfit']           = 'LuiExtended/media/icons/costumes/costume_corseted_riding_outfit.dds',
    ['Convenant Scout']                  = 'LuiExtended/media/icons/costumes/costume_covenant_scout.dds',
    ['Crafty Lerisa\'s Thief Outfit']    = 'LuiExtended/media/icons/costumes/costume_crafty_lerisas_thief_outfit.dds',
    ['Cyrod Gentry\'s Town Gown']        = 'LuiExtended/media/icons/costumes/costume_cyrod_gentrys_town_gown.dds',
    ['Cyrod Patrician Formal Gown']      = 'LuiExtended/media/icons/costumes/costume_cyro_patrician_formal_gown.dds',
    ['Dark Seducer']                     = 'LuiExtended/media/icons/costumes/costume_dark_seducer.dds',
    ['Dark Shaman']                      = 'LuiExtended/media/icons/costumes/costume_dark_shaman.dds',
    ['Desert Garden Gala Overdress']     = 'LuiExtended/media/icons/costumes/costume_desert_garden_gala_overdress.dds',
    ['Doeskin-and-Chamois Woods Wear']   = 'LuiExtended/media/icons/costumes/costume_doeskin-and-chamois_woods_wear.dds',
    ['Dominion Scout']                   = 'LuiExtended/media/icons/costumes/costume_dominion_scout.dds',
    ['Dragon Priest']                    = 'LuiExtended/media/icons/costumes/costume_dragon_priest.dds',
    ['Dragon Warrior']                   = 'LuiExtended/media/icons/costumes/costume_dragon_warrior.dds',
    ['East Skyrim Scout Outfit']         = 'LuiExtended/media/icons/costumes/costume_east_skyrim_scout_outfit.dds',
    ['Elven Hero Armor']                 = 'LuiExtended/media/icons/costumes/costume_elven_hero_armor.dds',
    ['Emperor\'s Regalia']               = 'LuiExtended/media/icons/costumes/costume_emperors_regalia.dds',
    ['Evening Dress']                    = 'LuiExtended/media/icons/costumes/costume_evening_dress.dds',
    ['Glenmoril Witch Robes']            = 'LuiExtended/media/icons/costumes/costume_glenmoril_witch_robes.dds',
    ['Golden Saint']                     = 'LuiExtended/media/icons/costumes/costume_golden_saint.dds',
    ['Graht-Climber\'s Active Wear']     = 'LuiExtended/media/icons/costumes/costume_graht-climbers_active_wear.dds',
    ['Hand of Almalexia Uniform']        = 'LuiExtended/media/icons/costumes/costume_hand_of_almalexia_uniform.dds',
    ['High-Collared Coin Ball Gown']     = 'LuiExtended/media/icons/costumes/costume_high-collared_coin_ball_gown.dds',
    ['Imperial Chancellor']              = 'LuiExtended/media/icons/costumes/costume_imperial_chancellor.dds',
    ['Imperial City Temple Tunic']       = 'LuiExtended/media/icons/costumes/costume_imperial_city_temple_tunic.dds',
    ['Imperial Guard Centurion Uniform'] = 'LuiExtended/media/icons/costumes/costume_imperial_guard_centurion_uniform.dds',
    ['Jaqspur']                          = 'LuiExtended/media/icons/costumes/costume_jaqspur.dds',
    ['Knight of the Flame']              = 'LuiExtended/media/icons/costumes/costume_knight_of_the_flame.dds',
    ['Lion Guard Elite']                 = 'LuiExtended/media/icons/costumes/costume_lion_guard_elite.dds',
    ['Lion Guard Knight']                = 'LuiExtended/media/icons/costumes/costume_lion_guard_knight.dds',
    ['Mages Guild Formal Robes']         = 'LuiExtended/media/icons/costumes/costume_mages_guild_formal_robes.dds',
    ['Mages Guild Leggings Uniform']     = 'LuiExtended/media/icons/costumes/costume_mages_guild_leggings_uniform.dds',
    ['Mages Guild Research Robes']       = 'LuiExtended/media/icons/costumes/costume_mages_guild_research_robes.dds',
    ['Majestic \"Dune Rider\" Ensemble'] = 'LuiExtended/media/icons/costumes/costume_majestic_dune_rider_ensemble.dds',
    ['Mannimarco']                       = 'LuiExtended/media/icons/costumes/costume_mannimarco.dds',
    ['Mask of Cheerful Slaughter']       = 'LuiExtended/media/icons/costumes/costume_mask_of_cheerful_slaughter.dds',
    ['Merchant Lord\'s Formal Regalia']  = 'LuiExtended/media/icons/costumes/costume_merchant_lords_formal_regalia.dds',
    ['Moth Priest']                      = 'LuiExtended/media/icons/costumes/costume_moth_priest.dds',
    ['Naryu\'s Assassin\'s Armor']       = 'LuiExtended/media/icons/costumes/costume_naryus_assassins_armor.dds',
    ['Nedic Duraki Armor']               = 'LuiExtended/media/icons/costumes/costume_nedic_duraki_armor.dds',
    ['Nedic Keptu Armor']                = 'LuiExtended/media/icons/costumes/costume_nedic_keptu_armor.dds',
    ['Nedic Perena Armor']               = 'LuiExtended/media/icons/costumes/costume_nedic_perena_armor.dds',
    ['Noble Dress']                      = 'LuiExtended/media/icons/costumes/costume_noble_dress.dds',
    ['Noble Suit']                       = 'LuiExtended/media/icons/costumes/costume_noble_suit.dds',
    ['Nord Hero Armor']                  = 'LuiExtended/media/icons/costumes/costume_nord_hero_armor.dds',
    ['Nordic Bather\'s Towel']           = 'LuiExtended/media/icons/costumes/costume_nordic_bathers_towel.dds',
    ['Off-the-Shoulder Evening Dress']   = 'LuiExtended/media/icons/costumes/costume_off-the-shoulder_evening_dress.dds',
    ['Old Orsinium Sentry']              = 'LuiExtended/media/icons/costumes/costume_old_orsinium_sentry.dds',
    ['Orcish Scout Armor']               = 'LuiExtended/media/icons/costumes/costume_orcish_scout_armor.dds',
    ['Ordinator Night-Raid Armor']       = 'LuiExtended/media/icons/costumes/costume_ordinator_night-raid_armor.dds',
    ['Pirate First Mate\'s outfit']      = 'LuiExtended/media/icons/costumes/costume_pirate_first_mates_outfit.dds',
    ['Pirate Sash and Bandolier Garb']   = 'LuiExtended/media/icons/costumes/costume_pirate_sash_and_bandolier_garb.dds',
    ['Pirate Swab Outfit']               = 'LuiExtended/media/icons/costumes/costume_pirate_swab_outfit.dds',
    ['Priest of the Green']              = 'LuiExtended/media/icons/costumes/costume_priest_of_the_green.dds',
    ['Regalia of the Orsimer King']      = 'LuiExtended/media/icons/costumes/costume_regalia_of_the_orsimer_king.dds',
    ['Royal Court Jester']               = 'LuiExtended/media/icons/costumes/costume_royal_court_jester.dds',
    ['Rumare Waterfront Casual Wear']    = 'LuiExtended/media/icons/costumes/costume_rumare_waterfront_casual_wear.dds',
    ['Sand-Kissed Salwar Ensemble']      = 'LuiExtended/media/icons/costumes/costume_sand-kissed_salwar_ensemble.dds',
    ['Shrouded Armor']                   = 'LuiExtended/media/icons/costumes/costume_shrouded_armor.dds',
    ['Soul-Shriven Armor Outfit']        = 'LuiExtended/media/icons/costumes/costume_soul-shriven_armor_outfit.dds',
    ['Soul-Shriven Leather Outfit']      = 'LuiExtended/media/icons/costumes/costume_soul-shriven_leather_outfit.dds',
    ['Soul-Shriven Ragged Clothing']     = 'LuiExtended/media/icons/costumes/costume_soul-shriven_ragged_clothing.dds',
    ['Summit Lord\'s Silken Robes']      = 'LuiExtended/media/icons/costumes/costume_summit_lords_silken_robes.dds',
    ['Thieves Guild Leathers']           = 'LuiExtended/media/icons/costumes/costume_thieves_guild_leathers.dds',
    ['Toxin Doctor']                     = 'LuiExtended/media/icons/costumes/costume_toxin_doctor.dds',
    ['Treasure Hunter']                  = 'LuiExtended/media/icons/costumes/costume_treasure_hunter.dds',
    ['Tree-Minder']                      = 'LuiExtended/media/icons/costumes/costume_tree-minder.dds',
    ['Treethane Ceremonial Dress']       = 'LuiExtended/media/icons/costumes/costume_treethane_ceremonial_dress.dds',
    ['Trinimac\'s Penitent Knight']      = 'LuiExtended/media/icons/costumes/costume_trinmacs_penitent_knight.dds',
    ['Valenwood Spinner']                = 'LuiExtended/media/icons/costumes/costume_valenwood_spinner.dds',
    ['Wedding Dress']                    = 'LuiExtended/media/icons/costumes/costume_wedding_dress.dds',
    ['Wedding Suit']                     = 'LuiExtended/media/icons/costumes/costume_wedding_suit.dds',
    ['West Skyrim Scout Outfit']         = 'LuiExtended/media/icons/costumes/costume_west_skyrim_scout_outfit.dds',
    ['Whisperweft Gala Wear']            = 'LuiExtended/media/icons/costumes/costume_whisperweft_gala_wear.dds',
    ['Winterborn Hunter\'s Costume']     = 'LuiExtended/media/icons/costumes/costume_winterborn_hunters_costume.dds',
    ['Winterborn Shaman\'s Costume']     = 'LuiExtended/media/icons/costumes/costume_winterborn_shamans_costume.dds',
    ['Winterborn Warrior\'s Costume']    = 'LuiExtended/media/icons/costumes/costume_winterborn_warriors_costume.dds',
    ['Wood Elf Vanguard']                = 'LuiExtended/media/icons/costumes/costume_wood_elf_vanguard.dds',
}

E.IsBossMob = {

    ['War Chief Ozozai'] = true,
    ['Broodbirther'] = true,

}

E.EffectTypeOverride = {
    [51392] = BUFF_EFFECT_TYPE_DEBUFF, -- Bolt Escape Fatigue
    [69143] = BUFF_EFFECT_TYPE_DEBUFF, -- Dodge Fatigue
    [69855] = BUFF_EFFECT_TYPE_DEBUFF, -- Volatile Poison (Arena)
    [73866] = BUFF_EFFECT_TYPE_DEBUFF, -- Volatile Poison (Arena)
    [8398]  = BUFF_EFFECT_TYPE_DEBUFF, -- Bleeding
    [59036] = BUFF_EFFECT_TYPE_DEBUFF, -- Serp Target (Not sure)
    [75672] = BUFF_EFFECT_TYPE_DEBUFF, -- Colossal Mark (Not sure)
    [75071] = BUFF_EFFECT_TYPE_DEBUFF, -- Shattered (Not sure)
    [57517] = BUFF_EFFECT_TYPE_DEBUFF, -- Grip of Lorkhaj (Not sure)
    -- Consumables
    [79857] = BUFF_EFFECT_TYPE_DEBUFF, -- of Defile (Minor Defile)
    [79860] = BUFF_EFFECT_TYPE_DEBUFF, -- of Defile (Minor Defile)
    [79844] = BUFF_EFFECT_TYPE_DEBUFF, -- of Vulnerability (Minor Vulnerability)
    -- Momentos
    [43700] = BUFF_EFFECT_TYPE_DEBUFF, -- Wand of Finding (Lena's Wand of Finding)
    -- Champion Points
    [60402] = BUFF_EFFECT_TYPE_DEBUFF, -- Ensnare
    -- General
    [44029] = BUFF_EFFECT_TYPE_DEBUFF, -- Slaughterfish Attack (Environmental)
    -- Traps
    [21941] = BUFF_EFFECT_TYPE_DEBUFF, -- Spike Trap Snare (Spike Trap)
    [21942] = BUFF_EFFECT_TYPE_DEBUFF, -- Trap Sprung (Spike Trap)
    [26530] = BUFF_EFFECT_TYPE_DEBUFF, -- Bear Trap (Bear Trap)
    [20259] = BUFF_EFFECT_TYPE_DEBUFF, -- Sigil of Frost Snare (Sigil of Frost - Wrothgar - Coldwind's Den)
    [65854] = BUFF_EFFECT_TYPE_DEBUFF, -- Spike Trap Snare (Spike Trap) (Orsinium - To Save a Chief)
    [65855] = BUFF_EFFECT_TYPE_DEBUFF, -- Trap Sprung (Spike Trap) (Orsinium - To Save a Chief)
    -- Human NPCs
    [39060] = BUFF_EFFECT_TYPE_DEBUFF, -- Bear Trap (Various NPC's)
    [74621] = BUFF_EFFECT_TYPE_DEBUFF, -- Revealed (Archer) (TG DLC)
    -- Daedra
    [50022] = BUFF_EFFECT_TYPE_DEBUFF, -- Ice Vortex (Air Atronach)
    -- Monsters
    -- Insects
    [61388] = BUFF_EFFECT_TYPE_DEBUFF, -- Necrotic Explosion Snare (Hoarvor DLC)
    -- Main Quest
    [64072] = BUFF_EFFECT_TYPE_DEBUFF, -- Eye of the Sentinel (CH Tutorial)
    -- Orsinium Events
    [74875] = BUFF_EFFECT_TYPE_DEBUFF, -- Catapult (The Hidden Harvest)
    [64734] = BUFF_EFFECT_TYPE_DEBUFF, -- Q5318 - Harpy Swoop In (The Hidden Harvest)
    [74104] = BUFF_EFFECT_TYPE_DEBUFF, -- Grasping Vines (The Hidden Harvest)
    [66988] = BUFF_EFFECT_TYPE_DEBUFF, -- Tear Down the Mountain (Blood on a King's Hands)
    [67084] = BUFF_EFFECT_TYPE_DEBUFF, -- Tear Down the Mountain (Blood on a King's Hands)
    -- Craglorn (Delves + World Events)
    [82328] = BUFF_EFFECT_TYPE_DEBUFF, -- Shock (Grandmother Thunder - Haddock's Market Delve Boss)
}

E.EffectIconOverride = { --Force a change to the icon displayed on an abilityId
    ----------------------------------------------------------------
    -- POTIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Potions (2 Traits)
    [64564] = 'LuiExtended/media/icons/potions/potion_007.dds', -- of Armor (Major Resolve)
    [79709] = 'LuiExtended/media/icons/potions/potion_014r.dds', -- of Creeping Ravage Health (Creeping Ravage Health)
    [79857] = 'LuiExtended/media/icons/potions/potion_007r.dds', -- of Defile (Minor Defile)
    [45236] = 'LuiExtended/media/icons/potions/potion_009.dds', -- of Detection (Increase Detection)
    [45222] = 'LuiExtended/media/icons/potions/potion_001.dds', -- of Health (Major Fortitude)
    [45239] = 'LuiExtended/media/icons/potions/potion_008.dds', -- of Immovability (Unstoppable)
    [45237] = 'LuiExtended/media/icons/potions/potion_011.dds', -- of Invisibility (Vanish)
    [79705] = 'LuiExtended/media/icons/potions/potion_014.dds', -- of Lingering Health (Lingering Restore Health)
    [45224] = 'LuiExtended/media/icons/potions/potion_002.dds', -- of Magicka (Major Intellect)
    [79712] = 'LuiExtended/media/icons/potions/potion_001.dds', -- of Protection (Minor Protection)
    [46208] = 'LuiExtended/media/icons/potions/potion_021.dds', -- of Ravage Armor (Minor Fracture)
    [46113] = 'LuiExtended/media/icons/potions/potion_015.dds', -- of Ravage Health (Health Potion Poison)
    [46193] = 'LuiExtended/media/icons/potions/potion_016.dds', -- of Ravage Magicka (Ravage Magicka)
    [47204] = 'LuiExtended/media/icons/potions/potion_020.dds', -- of Ravage Spell Critical (Minor Uncertainty)
    [46202] = 'LuiExtended/media/icons/potions/potion_020.dds', -- of Ravage Spell Power (Minor Cowardice)
    [46206] = 'LuiExtended/media/icons/potions/potion_018.dds', -- of Ravage Spell Protection (Minor Breach)
    [46199] = 'LuiExtended/media/icons/potions/potion_017.dds', -- of Ravage Stamina (Ravage Stamina)
    [47203] = 'LuiExtended/media/icons/potions/potion_019.dds', -- of Ravage Weapon Critical (Minor Enervation)
    [46204] = 'LuiExtended/media/icons/potions/potion_019.dds', -- of Ravage Weapon Power (Minor Maim)
    [46210] = 'LuiExtended/media/icons/potions/potion_017.dds', -- of Slow (Hindrance)
    [64566] = 'LuiExtended/media/icons/potions/potion_010.dds', -- of Speed (Major Expedition)
    [64570] = 'LuiExtended/media/icons/potions/potion_013.dds', -- of Spell Critical (Major Prophecy)
    [64558] = 'LuiExtended/media/icons/potions/potion_006.dds', -- of Spell Power (Major Sorcery)
    [64562] = 'LuiExtended/media/icons/potions/potion_004.dds', -- of Spell Protection (Major Ward)
    [45226] = 'LuiExtended/media/icons/potions/potion_003.dds', -- of Stamina (Major Endurance)
    [68565] = 'LuiExtended/media/icons/potions/potion_015.dds', -- of Stun (Stun)
    [79848] = 'LuiExtended/media/icons/potions/potion_014.dds', -- of Vitality (Major Vitality)
    [79844] = 'LuiExtended/media/icons/potions/potion_001r.dds', -- of Vulnerability (Minor Vulnerability)
    [64568] = 'LuiExtended/media/icons/potions/potion_012.dds', -- of Weapon Critical (Major Savagery)
    [64555] = 'LuiExtended/media/icons/potions/potion_005.dds', -- of Weapon Power (Major Brutality)

    -- Crafted Potions (3 Traits)
    [64565] = 'LuiExtended/media/icons/potions/potion_007.dds', -- of Armor (Major Resolve)
    -- No ... of Creeping Ravage Health
    [79860] = 'LuiExtended/media/icons/potions/potion_007r.dds', -- of Defile (Minor Defile)
    [45458] = 'LuiExtended/media/icons/potions/potion_009.dds', -- of Detection (Increase Detection)
    [63670] = 'LuiExtended/media/icons/potions/potion_001.dds', -- of Health (Major Fortitude)
    [45463] = 'LuiExtended/media/icons/potions/potion_008.dds', -- of Immovability (Unstoppable)
    [45460] = 'LuiExtended/media/icons/potions/potion_011.dds', -- of Invisibility (Vanish)
    [79706] = 'LuiExtended/media/icons/potions/potion_014.dds', -- of Lingering Health (Lingering Restore Health)
    [63676] = 'LuiExtended/media/icons/potions/potion_002.dds', -- of Magicka (Major Intellect)
    [79714] = 'LuiExtended/media/icons/potions/potion_001.dds', -- of Protection (Minor Protection)
    [46250] = 'LuiExtended/media/icons/potions/potion_021.dds', -- of Ravage Armor (Minor Fracture)
    [46217] = 'LuiExtended/media/icons/potions/potion_015.dds', -- of Ravage Health (Health Potion Linger Effect) (Different name than 2 trait)
    [46237] = 'LuiExtended/media/icons/potions/potion_016.dds', -- of Ravage Magicka (Ravage Magicka)
    -- No ... of Ravage Spell Critical
    [46244] = 'LuiExtended/media/icons/potions/potion_020.dds', -- of Ravage Spell Power (Minor Cowardice)
    [46248] = 'LuiExtended/media/icons/potions/potion_018.dds', -- of Ravage Spell Protection (Reduce Spell Resistance) (Should be Minor Breach)
    [46240] = 'LuiExtended/media/icons/potions/potion_017.dds', -- of Ravage Stamina (Ravage Stamina)
    [47202] = 'LuiExtended/media/icons/potions/potion_019.dds', -- of Ravage Weapon Critical (Reduce Weapon Critical) (Should be Minor Enervation)
    [46246] = 'LuiExtended/media/icons/potions/potion_019.dds', -- of Ravage Weapon Power (Minor Maim)
    [46252] = 'LuiExtended/media/icons/potions/potion_017.dds', -- of Slow (Hindrance)
    [64567] = 'LuiExtended/media/icons/potions/potion_010.dds', -- of Speed (Major Expedition)
    [64572] = 'LuiExtended/media/icons/potions/potion_013.dds', -- of Spell Critical (Major Prophecy)
    [64561] = 'LuiExtended/media/icons/potions/potion_006.dds', -- of Spell Power (Major Sorcery)
    [64563] = 'LuiExtended/media/icons/potions/potion_004.dds', -- of Spell Protection (Major Ward)
    [63681] = 'LuiExtended/media/icons/potions/potion_003.dds', -- of Stamina (Major Endurance)
    -- No ... of Stun
    [79850] = 'LuiExtended/media/icons/potions/potion_014.dds', -- of Vitality (Major Vitality)
    -- No ... of Vulnerability
    [64569] = 'LuiExtended/media/icons/potions/potion_012.dds', -- of Weapon Critical (Major Savagery)
    [64554] = 'LuiExtended/media/icons/potions/potion_005.dds', -- of Weapon Power (Major Brutality)

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [63672] = 'LuiExtended/media/icons/potions/potion_001.dds', -- of Health (Major Fortitude)
    [63678] = 'LuiExtended/media/icons/potions/potion_002.dds', -- of Magicka (Major Intellect)
    [63683] = 'LuiExtended/media/icons/potions/potion_003.dds', -- of Stamina (Major Endurance)
    [72935] = 'LuiExtended/media/icons/potions/potion_ava_green.dds', -- Alliance Battle Draught (Major Endurance)
    [72936] = 'LuiExtended/media/icons/potions/potion_ava_yellow.dds', -- Alliance Battle Draught (Major Brutality)
    [72930] = 'LuiExtended/media/icons/potions/potion_ava_red.dds', -- Alliance Health Draught (Unstoppable )
    [72928] = 'LuiExtended/media/icons/potions/potion_ava_red.dds', -- Alliance Health Draught (Major Fortitude)
    [72933] = 'LuiExtended/media/icons/potions/potion_ava_teal.dds', -- Alliance Spell Draught (Major Sorcery)
    [72932] = 'LuiExtended/media/icons/potions/potion_ava_blue.dds', -- Alliance Spell Draught (Major Intellect)
    [78058] = 'LuiExtended/media/icons/potions/potion_ava_purple.dds', -- Roguish Stealth Draught (Vanish)
    [78054] = 'LuiExtended/media/icons/potions/potion_ava_green.dds', -- Roguish Stealth Draught (Major Endurance)
    [78081] = 'LuiExtended/media/icons/potions/potion_ava_green.dds', -- Roguish Escape Draught (Major Expedition)
    [78080] = 'LuiExtended/media/icons/potions/potion_ava_green.dds', -- Roguish Escape Draught (Major Endurance)

    -- Crown Store Potions
    [68405] = 'LuiExtended/media/icons/potions/potion_crown_red.dds', -- Crown Tri-Restoration Potion (Major Fortitude)
    [68406] = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', -- Crown Tri-Restoration Potion (Major Intellect)
    [68408] = 'LuiExtended/media/icons/potions/potion_crown_green.dds', -- Crown Tri-Restoration Potion (Major Endurance)
    [86780] = 'LuiExtended/media/icons/potions/potion_crown_pink.dds', -- Crown Invisibility Potion (Invisibility)
    [86683] = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', -- Crown Spellcaster's Elixir (Major Intellect)
    [86684] = 'LuiExtended/media/icons/potions/potion_crown_teal.dds', -- Crown Spellcaster's Elixir (Major Prophecy)
    [86685] = 'LuiExtended/media/icons/potions/potion_crown_teal.dds', -- Crown Spellcaster's Elixir (Major Sorcery)
    [86697] = 'LuiExtended/media/icons/potions/potion_crown_red.dds', -- Crown Survivor's Elixir (Major Fortitude)
    [86698] = 'LuiExtended/media/icons/potions/potion_crown_red.dds', -- Crown Survivor's Elixir (Unstoppable)
    [86699] = 'LuiExtended/media/icons/potions/potion_crown_pink.dds', -- Crown Survivor's Elixir (Invisibility)
    [86693] = 'LuiExtended/media/icons/potions/potion_crown_green.dds', -- Crown Warrior's Elixir (Major Endurance)
    [86694] = 'LuiExtended/media/icons/potions/potion_crown_yellow.dds', -- Crown Warrior's Elixir (Major Savagery)
    [86695] = 'LuiExtended/media/icons/potions/potion_crown_yellow.dds', -- Crown Warrior's Elixir (Major Brutality)

    ----------------------------------------------------------------
    -- POTION UP FRONT EFFECTS -------------------------------------
    ----------------------------------------------------------------

    --Crafted Potions (2 Traits)
    [45221] = 'LuiExtended/media/icons/potions/potion_001.dds', -- Restore Health
    [45223] = 'LuiExtended/media/icons/potions/potion_002.dds', -- Restore Magicka
    [46111] = 'LuiExtended/media/icons/potions/potion_015.dds', -- Ravage Health
    [45225] = 'LuiExtended/media/icons/potions/potion_003.dds', -- Restore Stamina

    --Crafted Potions (3 Traits)
    [45382] = 'LuiExtended/media/icons/potions/potion_001.dds', -- Restore Health
    [45385] = 'LuiExtended/media/icons/potions/potion_002.dds', -- Restore Magicka
    [46215] = 'LuiExtended/media/icons/potions/potion_015.dds', -- Damage Health
    [45388] = 'LuiExtended/media/icons/potions/potion_003.dds', -- Restore Stamina

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [17302] = 'LuiExtended/media/icons/potions/potion_001.dds', -- Restore Health (Vendor)
    [17323] = 'LuiExtended/media/icons/potions/potion_002.dds', -- Restore Magicka (Vendor)
    [17328] = 'LuiExtended/media/icons/potions/potion_003.dds', -- Restore Stamina (Vendor)
    [72934] = 'LuiExtended/media/icons/potions/potion_ava_green.dds', -- Restore Stamina (Alliance Battle Draught)
    [72927] = 'LuiExtended/media/icons/potions/potion_ava_red.dds', -- Restore Health (Alliance Health Draught)
    [72931] = 'LuiExtended/media/icons/potions/potion_ava_blue.dds', -- Restore Magicka (Alliance Spell Draught)
    [78053] = 'LuiExtended/media/icons/potions/potion_ava_green.dds', -- Restore Stamina (Roguish Stealth Draught)
    [78079] = 'LuiExtended/media/icons/potions/potion_ava_green.dds', -- Restore Stamina (Roguish Escape Draught)

    [68401] = 'LuiExtended/media/icons/potions/potion_crown_red.dds', -- Restore All Resources (Crown Tri-Restoration Potion)
    [68407] = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', -- Restore Magicka (Crown Tri-Restoration Potion)
    [68409] = 'LuiExtended/media/icons/potions/potion_crown_green.dds', -- Restore Stamina (Crown Tri-Restoration Potion)
    [86682] = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', -- Crown Spellcaster's Elixir (Crown Spellcaster's Elixir)
    [86696] = 'LuiExtended/media/icons/potions/potion_crown_red.dds', -- Crown Survivor's Elixir (Crown Survivor's Elixir)
    [86692] = 'LuiExtended/media/icons/potions/potion_crown_green.dds', -- Crown Warrior's Elixir (Crown Warrior's Elixir)

    ----------------------------------------------------------------
    -- POSIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Poisons (2 Traits)
    [79133] = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', -- Drain Health (Drain Health Poison) DEBUFF
    [79134] = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', -- Restore Health (Drain Health Poison) BUFF
    [79025] = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', -- Ravage Health (Damage Health Poison) DEBUFF
    [82667] = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', -- Ravage Health (Damage Health Poison) DEBUFF
    [79137] = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds', -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79138] = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds', -- Restore Magicka (Drain Magicka Poison) BUFF
    [79037] = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds', -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79141] = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79142] = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', -- Restore Stamina (Drain Stamina Poison) BUFF
    [79045] = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79284] = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', -- Drain Spell Resist (Ward-Draining Poison) DEBUFF
    [79285] = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', -- Minor Ward (Ward-Draining Poison) BUFF
    [79087] = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', -- Minor Breach (Breaching Poison) DEBUFF
    [79309] = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', -- Drain Physical Resist (Resolve-Draining Poison) DEBUFF
    [79310] = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', -- Minor Resolve (Resolve-Draining Poison) BUFF
    [79090] = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', -- Minor Fracture (Fracturing Poison) DEBUFF
    [79193] = 'LuiExtended/media/icons/poisons/poison_2_cyan_r.dds', -- Minor Cowardice (Sorcery-Draining Poison) DEBUFF
    [79221] = 'LuiExtended/media/icons/poisons/poison_2_cyan_g.dds', -- Minor Sorcery (Sorcery-Draining Poison) BUFF
    [79069] = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', -- Minor Cowardice (Cowardice Poison) DEBUFF
    [79280] = 'LuiExtended/media/icons/poisons/poison_2_yellow_r.dds', -- Drain Weapon Power (Brutality-Draining Poison) DEBUFF
    [79281] = 'LuiExtended/media/icons/poisons/poison_2_yellow_g.dds', -- Minor Brutality (Brutality-Draining Poison) BUFF
    [79083] = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', -- Minor Maim (Maiming Poison) DEBUFF
    [79446] = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', -- Minor Uncertainty (Prophecy-Draining Poison) DEBUFF
    [79447] = 'LuiExtended/media/icons/poisons/poison_1_cyan_g.dds', -- Minor Prophecy (Prophecy-Draining Poison) BUFF
    [79117] = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', -- Minor Uncertainty (Uncertainty Poison) DEBUFF
    [79450] = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', -- Minor Enervation (Savagery-Draining Poison) DEBUFF
    [79453] = 'LuiExtended/media/icons/poisons/poison_1_yellow_g.dds', -- Minor Savagery (Savagery-Draining Poison) BUFF
    [79113] = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', -- Minor Enervation (Enervating Poison) DEBUFF
    [79457] = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', -- Immobilize (Escapist's Poison) DEBUFF
    [79458] = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', -- Unstoppable (Escapist's Poison) BUFF
    [79122] = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', -- Immobilize (Entrapping Poison) DEBUFF
    [79996] = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80003] = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', -- Marking Poison (Conspicuous Poison) DEBUFF
    [79367] = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', -- Hindrance (Speed-Draining Poison) DEBUFF
    [79368] = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', -- Major Expedition (Speed-Draining Poison) BUFF
    [79094] = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', -- Hindrance (Hindering Poison) DEBUFF
    [79699] = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [81351] = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79700] = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', -- Restore Health (Gradual Health Drain Poison) BUFF
    [79707] = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', -- Creeping Ravage Health (Gradual Ravage Health Poison) DEBUFF
    [81346] = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', -- Creeping Ravage Health (Gradual Ravage Health Poison) DEBUFF
    [79723] = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', -- Minor Vulnerability (Protection-Reversing Poison) DEBUFF
    [79725] = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', -- Minor Protection (Protection-Reversing Poison) BUFF
    [79715] = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', -- Minor Vulnerability (Vulnerability Poison) DEBUFF
    [79851] = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', -- Minor Defile (Vitality-Draining Poison) DEBUFF
    [79852] = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', -- Minor Vitality (Vitality-Draining Poison) BUFF
    [79861] = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', -- Minor Defile (Defiling Poison) DEBUFF

    -- Crafted Poisons (3 Traits)
    [79135] = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', -- Drain Health (Drain Health Poison) DEBUFF
    [79136] = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', -- Restore Health (Drain Health Poison) BUFF
    [78922] = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', -- Ravage Health (Damage Health Poison) DEBUFF
    [82668] = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', -- Ravage Health (Damage Health Poison) DEBUFF
    [79139] = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds', -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79140] = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds', -- Restore Magicka (Drain Magicka Poison) BUFF
    [79044] = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds', -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79143] = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79144] = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', -- Restore Stamina (Drain Stamina Poison) BUFF
    [79046] = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79306] = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', -- Drain Spell Resist (Ward-Draining Poison) DEBUFF
    [79307] = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', -- Minor Ward (Ward-Draining Poison) BUFF
    [79086] = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', -- Minor Breach (Breaching Poison) DEBUFF
    [79311] = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', -- Drain Physical Resist (Resolve-Draining Poison) DEBUFF
    [79312] = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', -- Minor Resolve (Resolve-Draining Poison) BUFF
    [79091] = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', -- Minor Fracture (Fracturing Poison) DEBUFF
    [79278] = 'LuiExtended/media/icons/poisons/poison_2_cyan_r.dds', -- Minor Cowardice (Sorcery-Draining Poison) DEBUFF
    [79279] = 'LuiExtended/media/icons/poisons/poison_2_cyan_g.dds', -- Minor Sorcery (Sorcery-Draining Poison) BUFF
    [79082] = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', -- Minor Cowardice (Cowardice Poison) DEBUFF
    [79282] = 'LuiExtended/media/icons/poisons/poison_2_yellow_r.dds', -- Drain Weapon Power (Brutality-Draining Poison) DEBUFF
    [79283] = 'LuiExtended/media/icons/poisons/poison_2_yellow_g.dds', -- Minor Brutality (Brutality-Draining Poison) BUFF
    [79085] = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', -- Minor Maim (Maiming Poison) DEBUFF
    [79448] = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', -- Minor Uncertainty (Prophecy-Draining Poison) DEBUFF
    [79449] = 'LuiExtended/media/icons/poisons/poison_1_cyan_g.dds', -- Minor Prophecy (Prophecy-Draining Poison) BUFF
    -- No Uncertainty
    [79454] = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', -- Minor Enervation (Savagery-Draining Poison) DEBUFF
    [79455] = 'LuiExtended/media/icons/poisons/poison_1_yellow_g.dds', -- Minor Savagery (Savagery-Draining Poison) BUFF
    [79116] = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', -- Minor Enervation (Enervating Poison) DEBUFF
    [79459] = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', -- Immobilize (Escapist's Poison) DEBUFF
    [79460] = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', -- Unstoppable (Escapist's Poison) BUFF
    -- No Entrapping
    [80002] = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80004] = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', -- Marking Poison (Conspicuous Poison) DEBUFF
    [79369] = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', -- Hindrance (Speed-Draining Poison) DEBUFF
    [79370] = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', -- Major Expedition (Speed-Draining Poison) BUFF
    [79102] = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', -- Hindrance (Hindering Poison) DEBUFF
    [79701] = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [81348] = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79702] = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', -- Restore Health (Gradual Health Drain Poison) BUFF
    -- No Gradual Ravage Health
    -- No Gradual Ravage Health
    [79726] = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', -- Minor Vulnerability (Protection-Reversing Poison) DEBUFF
    [79727] = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', -- Minor Protection (Protection-Reversing Poison) BUFF
    -- No Vulnerability
    [79854] = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', -- Minor Defile (Vitality-Draining Poison) DEBUFF
    [79855] = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', -- Minor Vitality (Vitality-Draining Poison) BUFF
    [79862] = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', -- Minor Defile (Defiling Poison) DEBUFF

    -- Vendor Poisons
    [81553] = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', -- Ravage Health (Cloudy Damage Health Poison) DEBUFF
    [81551] = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison) DEBUFF
    [81552] = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison) DEBUFF
    [81554] = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', -- Hindrance (Cloudy Hindering Poison) DEBUFF

    -- Crown Poisons
    [88476] = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', -- Creeping Ravage Health (Crown Debilitating Poison)
    [88477] = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', -- Hindrance (Crown Debilitating Poison)
    [88471] = 'LuiExtended/media/icons/poisons/poison_crown_blue_r.dds', -- Drain Magicka (Crown Draining Poison)
    [88475] = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', -- Drain Stamina (Crown Draining Poison)
    [88473] = 'LuiExtended/media/icons/poisons/poison_crown_blue_g.dds', -- Restore Magicka (Crown Draining Poison)
    [88474] = 'LuiExtended/media/icons/poisons/poison_crown_green_g.dds', -- Restore Stamina (Crown Draining Poison)
    [88469] = 'LuiExtended/media/icons/poisons/poison_crown_yellow_r.dds', -- Minor Maim (Crown Enfeebling Poison)
    [88470] = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', -- Minor Defile (Crown Enfeebling Poison)
    [81274] = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds', -- Ravage Health (Crown Lethal Poison) DEBUFF
    [81275] = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', -- Creeping Ravage Health (Crown Lethal Poison) DEBUFF
    [88462] = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds', -- Immobilize (Crown Trapping Poison)
    [88463] = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', -- Hindrance (Crown Trapping Poison)

    ----------------------------------------------------------------
    -- FOOD & DRINK ------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Food
    [61259] = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', -- Health Food
    [61260] = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', -- Magicka Food
    [61261] = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', -- Stamina Food
    [61294] = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', -- Magicka + Stamina Food
    [61255] = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', -- Health + Stamina Food
    [61257] = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', -- Health + Magicka Food
    [61218] = 'LuiExtended/media/icons/consumables/consumable_food_purple.dds', -- Triple Food
    [72819] = 'LuiExtended/media/icons/consumables/consumable_orzorga_tripe_trifle_pocket.dds', -- Orzorga's Tripe Trifle Pocket
    [72822] = 'LuiExtended/media/icons/consumables/consumable_orzorga_blood_price_pie.dds', -- Orzorga's Blood Price Pie
    [72824] = 'LuiExtended/media/icons/consumables/consumable_orzorga_bear_haunch.dds', -- Orzorga's Smoked Bear Haunch

    -- Crafted Drink
    [61322] = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', -- Health Drink
    [61325] = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', -- Magicka Drink
    [61328] = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', -- Stamina Drink
    [61345] = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', -- Magicka + Stamina Drink
    [61340] = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', -- Health + Stamina Drink
    [61335] = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', -- Health + Magicka Drink
    [61350] = 'LuiExtended/media/icons/consumables/consumable_drink_purple.dds', -- Triple Drink
    [72816] = 'LuiExtended/media/icons/consumables/consumable_orzorga_red_frothgar.dds', -- Orzorga's Red Frothgar

    -- Crafted Seasonal Food
    [84681] = 'LuiExtended/media/icons/consumables/consumable_event_crisp_and_crunchy_pumpkin.dds', -- Crisp and Crunchy Pumpkin Snack Skewer (UNTESTED)
    [84709] = 'LuiExtended/media/icons/consumables/consumable_event_crunchy_spider_skewer.dds', -- Crunchy Spider Skewer (UNTESTED)
    [84725] = 'LuiExtended/media/icons/consumables/consumable_event_frosted_brains.dds', -- Frosted Brains (UNTESTED)
    [84678] = 'LuiExtended/media/icons/consumables/consumable_event_sweet_sanguine_apples.dds', -- Sweet Sanguine Apples (UNTESTED)
    [86789] = 'LuiExtended/media/icons/consumables/consumable_event_alcaire_festival_sword-pie.dds', -- Alcaire Festival Sword-Pie (UNTESTED)
    [86749] = 'LuiExtended/media/icons/consumables/consumable_event_jagga-drenched_mud_ball.dds', -- Jagga-Drenched "Mud Ball" (UNTESTED)
    [86673] = 'LuiExtended/media/icons/consumables/consumable_event_lava_foot_soup-and-saltrice.dds', -- Lava Foot Soup-and-Saltrice (UNTESTED)
    [86560] = 'LuiExtended/media/icons/consumables/consumable_event_old_aldmeri_orphan_gruel.dds', -- Old Aldmeri Orphan Gruel (UNTESTED)
    [86787] = 'LuiExtended/media/icons/consumables/consumable_event_rajhins_sugar_claws.dds', -- Rajhin's Sugar Claws
    [89955] = 'LuiExtended/media/icons/consumables/consumable_event_candied_jesters_coins.dds', -- Candied Jester's Coins
    [89956] = 'LuiExtended/media/icons/consumables/consumable_event_princess_delight.dds', -- Princess' Delight

    -- Crafted Seasonal Drink
    [84700] = 'LuiExtended/media/icons/consumables/consumable_event_bowl_of_peeled_eyeballs.dds', -- Bowl of "Peeled Eyeballs"
    [84735] = 'LuiExtended/media/icons/consumables/consumable_event_double_bloody_mara.dds', -- Double Bloody Mara
    [84720] = 'LuiExtended/media/icons/consumables/consumable_event_ghastly_eye_bowl.dds', -- Ghastly Eye Bowl
    [84704] = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_party_punch.dds', -- Witchmother's Party Punch
    [84731] = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_potent_brew.dds', -- Witchmother's Potent Brew
    [86677] = 'LuiExtended/media/icons/consumables/consumable_event_bergama_warning_fire.dds', -- Bergama Warning Fire
    [86746] = 'LuiExtended/media/icons/consumables/consumable_event_betnikh_twice-spiked_ale.dds', -- Betnikh Twice-Spiked Ale
    [86559] = 'LuiExtended/media/icons/consumables/consumable_event_hissmir_fish-eye_rye.dds', -- Hissmir Fish-Eye Rye
    [86791] = 'LuiExtended/media/icons/consumables/consumable_event_snow_bear_glow-wine.dds', -- Snow Bear Glow-Wine
    [89957] = 'LuiExtended/media/icons/consumables/consumable_event_dubious_camoran_throne.dds', -- Dubious Camoran Throne
    [89971] = 'LuiExtended/media/icons/consumables/consumable_event_jewels_of_misrule.dds', -- Jewels of Misrule

    -- Vendor Food & Drink
    [66551] = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', -- Vendor Health Food
    [66568] = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', -- Vendor Magicka Food
    [66576] = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', -- Vendor Stamina Food
    [66586] = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', -- Vendor Health Drink
    [66590] = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', -- Vendor Magicka Drink
    [66594] = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', -- Vendor Stamina Drink

    -- AVA Food & Drink
    [72961] = 'LuiExtended/media/icons/consumables/consumable_ava_field_bar.dds', -- Cyrodilic Field Bar
    [72956] = 'LuiExtended/media/icons/consumables/consumable_ava_field_tack.dds', -- Cyrodilic Field Tack
    [72959] = 'LuiExtended/media/icons/consumables/consumable_ava_field_treat.dds', -- Cyrodilic Field Treat
    [72971] = 'LuiExtended/media/icons/consumables/consumable_ava_field_tonic.dds', -- Cyrodilic Field Tonic
    [72965] = 'LuiExtended/media/icons/consumables/consumable_ava_field_brew.dds', -- Cyrodilic Field Brew
    [72968] = 'LuiExtended/media/icons/consumables/consumable_ava_field_tea.dds', -- Cyrodilic Field Tea

    -- Crown Food & Drink
    [85484] = 'LuiExtended/media/icons/consumables/consumable_crown_crate_food.dds', -- Crown Crate Fortifying Meal
    [68411] = 'LuiExtended/media/icons/consumables/consumable_crown_food.dds', -- Crown Fortifying Meal
    [85497] = 'LuiExtended/media/icons/consumables/consumable_crown_crate_drink.dds', -- Crown Crate Refreshing Drink
    [68416] = 'LuiExtended/media/icons/consumables/consumable_crown_drink.dds', -- Crown Refreshing Drink

    -- Experience Bonuses
    [64210] = 'LuiExtended/media/icons/consumables/consumable_xp_psijic_ambrosia.dds', -- Psijic Ambrosia
    [88445] = 'LuiExtended/media/icons/consumables/consumable_xp_mythic_aetherial_ambrosia.dds', -- Mythic Aetherial Ambrosia
    [66776] = 'LuiExtended/media/icons/consumables/consumable_xp_scroll.dds', -- Crown Experience Scroll
    [85501] = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_1.dds', -- Crown Crate Experience Scroll
    [85502] = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_2.dds', -- Major Crown Crate Experience Scroll
    [85503] = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_3.dds', -- Grand Crown Crate Experience Scroll

    -- Misc Consumables
    [86794] = 'LuiExtended/media/icons/consumables/consumable_event_festival_mints.dds', -- Very Cold (High Hrothgar Festival Mints)
    [86740] = 'LuiExtended/media/icons/consumables/consumable_event_festival_grog.dds', -- Very Drunk (Sailor's Warning Festival Grog)

    -- Base Momentos
    [26829] = 'LuiExtended/media/icons/momentos/momento_almalexias_enchanted_lantern.dds', -- Light of the Tribunal (Almalexia's Enchanted Lantern)
    [41950] = 'LuiExtended/media/icons/momentos/momento_yokudan_totem.dds', -- Fetish of Anger (Fetish of Anger)
    [21226] = 'LuiExtended/media/icons/momentos/momento_finvirs_trinket.dds', -- Finvir's Trinket (Finvir's Trinket)
    [43700] = 'LuiExtended/media/icons/momentos/momento_lenas_wand_of_finding.dds', -- Wand of Finding (Lena's Wand of Finding)

    -- DLC Momentos
    [77786] = 'LuiExtended/media/icons/momentos/momento_coin_of_illusory_riches.dds', -- Stun (Coin of Illusory Riches)
    [74232] = 'LuiExtended/media/icons/momentos/momento_malacaths_wrathful_flame.dds', -- Stun (Malacath's Wrathful Flame)

    -- Seasonal Momentos
    [77123] = 'LuiExtended/media/icons/momentos/momento_event_jubilee_cake.dds', -- 2017 Anniversary EXP Buff (2nd Annual Jubilee Cake)
    [84369] = 'LuiExtended/media/icons/abilities/ability_event_witchmothers_brew.dds', -- Witchmother's Brew (Witchmother's Whistle)
    [86774] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Mudball (Mud Ball Pouch)
    [86777] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Mudball (Mud Ball Pouch)
    [86775] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Covered in Mud (Mud Ball Pouch)
    [86779] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Covered in Mud (Mud Ball Pouch)

    -- Crown Store Momentos
    [85344] = 'LuiExtended/media/icons/momentos/momento_storm_atronach_aura.dds', -- Atronach Aura (Storm Atronach Aura)
    [86976] = 'LuiExtended/media/icons/momentos/momento_wild_hunt_leaf-dance_aura.dds', -- Spriggan Aura (Wild Hunt Leaf-Dance Aura)
    [86978] = 'LuiExtended/media/icons/momentos/momento_floral_swirl_aura.dds', -- Grand Spriggan Aura (Floral Swirl Aura)

    -- Assistants
    [77645] = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', -- Stealth (Pirharri the Smuggler)

    ----------------------------------------------------------------
    -- ENCHANTS ----------------------------------------------------
    ----------------------------------------------------------------

    [28919] = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds', -- Life Drain (Glyph of Absorb Health)
    [28921] = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds', -- Life Drain (Glyph of Absorb Health)
    [46743] = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds', -- Absorb Magicka (Glyph of Absorb Magicka)
    [46744] = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds', -- Absorb Magicka (Glyph of Absorb Magicka)
    [46746] = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds', -- Absorb Stamina (Glyph of Absorb Stamina)
    [46747] = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds', -- Absorb Stamina (Glyph of Absorb Stamina)
    [17906] = 'LuiExtended/media/icons/glyphs/glyph_crushing.dds', -- Crusher (Glyph of Crushing)
    [46749] = 'LuiExtended/media/icons/glyphs/glyph_decrease_health.dds', -- Damage Health (Glyph of Decrease Health)
    [17895] = 'LuiExtended/media/icons/glyphs/glyph_flame.dds', -- Fiery Weapon (Glyph of Flame)
    [17904] = 'LuiExtended/media/icons/glyphs/glyph_foulness.dds', -- Befouled Weapon (Glyph of Foulness)
    [17897] = 'LuiExtended/media/icons/glyphs/glyph_frost.dds', -- Frozen Weapon (Glyph of Frost)
    --[17947] = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds', -- Hardening (Glyph of Hardening) (DUMMY EVENT, HERE JUST IN CASE)
    [21578] = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds', -- Hardening (Glyph of Hardening)
    [17902] = 'LuiExtended/media/icons/glyphs/glyph_poison.dds', -- Poisoned Weapon (Glyph of Poison)
    [40337] = 'LuiExtended/media/icons/glyphs/glyph_prismatic.dds', -- Primatic Weapon (Glyph of Prismatic Onslaught)
    [17899] = 'LuiExtended/media/icons/glyphs/glyph_shock.dds', -- Charged Weapon (Glyph of Shock)
    [17945] = 'LuiExtended/media/icons/glyphs/glyph_weakening.dds', -- Weakening (Glyph of Weakening)
    --[17910] = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds', -- Weapon Damage (Glyph of Weapon Damage) (DUMMY EVENT, HERE JUST IN CASE)
    --[21230] = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds', -- Berserker (Glyph of Weapon Damage) (Added in case ever needed)

    ----------------------------------------------------------------
    -- STATUS EFFECT PROCS -----------------------------------------
    ----------------------------------------------------------------

    [18084] = 'LuiExtended/media/icons/abilities/ability_innate_proc_burning.dds', -- Burning (Fire Status Effect)
    [21925] = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds', -- Diseased (Disease Status Effect)
    [21927] = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds', -- Major Defile (Disease Status Effect)
    [21481] = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds', -- Chill (Frost Status Effect)
    [68368] = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds', -- Minor Maim (Frost Status Effect)
    [21929] = 'LuiExtended/media/icons/abilities/ability_innate_proc_poisoned.dds', -- Poisoned (Poison Status Effect)
    [21487] = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds', -- Concussion (Shock Status Effect)
    [68359] = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds', -- Minor Vulnerability (Shock Status Effect)

    ----------------------------------------------------------------
    -- VULNERABILITY PROCS -----------------------------------------
    ----------------------------------------------------------------

    [68448] = 'LuiExtended/media/icons/abilities/ability_innate_proc_explosion.dds', -- Explosion (Fire Vulnerability Proc)
    [21480] = 'LuiExtended/media/icons/abilities/ability_innate_proc_explosion.dds', -- Explosion (Fire Vulnerability Proc)
    [68463] = 'LuiExtended/media/icons/abilities/ability_innate_proc_venom.dds', -- Venom (Poison Vulnerability Proc)
    [68464] = 'LuiExtended/media/icons/abilities/ability_innate_proc_venom.dds', -- Venom (Poison Vulnerability Proc)
    [68462] = 'LuiExtended/media/icons/abilities/ability_innate_proc_pestilence.dds', -- Pestilence (Disease Vulnerability Proc)
    [68461] = 'LuiExtended/media/icons/abilities/ability_innate_proc_pestilence.dds', -- Pestilence (Disease Vulnerability Proc)
    [68451] = 'LuiExtended/media/icons/abilities/ability_innate_proc_disintegration.dds', -- Disintegration (Lightning Vulnerability Proc)
    [68455] = 'LuiExtended/media/icons/abilities/ability_innate_proc_disintegration.dds', -- Disintegration (Lightning Vulnerability Proc)
    [68458] = 'LuiExtended/media/icons/abilities/ability_innate_proc_deep_freeze.dds', -- Deep Freeze (Frost Vulnerability Proc)
    [68457] = 'LuiExtended/media/icons/abilities/ability_innate_proc_deep_freeze.dds', -- Deep Freeze (Frost Vulnerability Proc)
    
    ----------------------------------------------------------------
    -- EQUIPMENT ---------------------------------------------------
    ----------------------------------------------------------------
    
    [82631] = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds', -- Monk Disguise Timer (Monk's Disguise)

    ----------------------------------------------------------------
    -- CHAMPION POINTS ---------------------------------------------
    ----------------------------------------------------------------

    -- The Steed
    [60409] = 'LuiExtended/media/icons/abilities/ability_champion_invigorating_bash.dds', -- Invigorating Bash
    [61661] = 'esoui/art/icons/ability_healer_003.dds', -- Resilient
    [64068] = 'LuiExtended/media/icons/abilities/ability_champion_reinforced.dds', -- Reinforced

    -- The Lady
    [63110] = 'esoui/art/icons/ability_mage_013.dds', -- Spell Absorption
    [60371] = 'esoui/art/icons/ability_healer_034.dds', -- Critical Leech
    [59287] = 'esoui/art/icons/ability_warrior_031.dds', -- Unchained

    -- The Lord
    [59583] = 'LuiExtended/media/icons/abilities/ability_champion_infusion.dds', -- Infusion
    [60428] = 'LuiExtended/media/icons/abilities/ability_champion_reinforced.dds', -- Revival
    [61015] = 'LuiExtended/media/icons/abilities/ability_champion_reinforced.dds', -- Determination

    -- The Tower
    [62518] = 'esoui/art/icons/ability_healer_004.dds', -- Mara's Gift

    -- The Lover
    [63878] = 'esoui/art/icons/ability_healer_013.dds', -- Synergizer

    -- The Shadow
    [64244] = 'esoui/art/icons/ability_rogue_054.dds', -- Shadowstrike
    [64245] = 'esoui/art/icons/ability_rogue_054.dds', -- Shadowstrike

    -- The Apprentice
    [63152] = 'esoui/art/icons/ability_mage_058.dds', -- Vengeance
    [63151] = 'LuiExtended/media/icons/abilities/ability_champion_vengeance.dds', -- Vengeance
    --[59530] = 'esoui/art/icons/ability_mage_045.dds' -- Foresight (Reserved if need to add later)
    [63114] = 'esoui/art/icons/ability_mage_038.dds', -- Arcane Well

    -- The Atronach
    --[63106] 'esoui/art/icons/ability_warrior_005.dds' -- Retaliation (Reserved if need to add later)
    [60230] = 'esoui/art/icons/ability_warrior_013.dds', -- Riposte
    --[63102] 'esoui/art/icons/ability_warrior_018.dds' -- Opportunist (Reserved if need to add later)
    [65133] = 'esoui/art/icons/ability_buff_major_heroism.dds', -- Major Heroism

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    -- Player Basic
    [28549] = 'LuiExtended/media/icons/abilities/ability_innate_roll_dodge.dds', -- Roll Dodge
    [69143] = 'LuiExtended/media/icons/abilities/ability_innate_dodge_fatigue.dds', -- Dodge Fatigue
    --[20309] = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', -- Hidden (Reserved here if it ever becomes visible)
    [20301] = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', -- Crouch Drain
    [26245] = 'LuiExtended/media/icons/abilities/ability_innate_slam_stun.dds', -- Slam Stun (Stun from crouch attack)
    --[973] = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', -- Sprint (Reserved here if it ever becomes visible)
    [15356] = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', -- Sprint Drain
    [10950] = 'LuiExtended/media/icons/abilities/ability_innate_fall_snare.dds', -- Fall Snare
    [63601] = 'LuiExtended/media/icons/abilities/ability_innate_eso_plus_member.dds', -- ESO Plus Member
    [47270] = 'esoui/art/icons/achievement_update11_dungeons_017.dds', -- Ritual of Mara
    [42514] = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds', -- Hard Dismount
    --[33439] = 'LuiExtended/media/icons/abilities/ability_innate_mount_sprint.dds', -- Mount Sprint (Generic) (Resevered here if it ever becomes visible)
    [14890] = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', -- Block
    [16270] = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', -- Brace Cost
    [88724] = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', -- Brace Cost
    [86310] = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', -- Stagger (Player blocks NPC charged attack)
    [86309] = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', -- Stun (Player blocks NPC charged attack)
    [86312] = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', -- Stun (Player blocks Ogrim Body Slam)
    [45902] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Off-Balance (Standard block/power attack off-balance)
    [21970] = 'LuiExtended/media/icons/abilities/ability_innate_bash.dds', -- Bash
    [21973] = '', -- Bash (Hides icon for interrupt)
    [21971] = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', -- Bash Stun (Stun from bashing cast)
    [2727] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Off-Balance
    [45982] = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', -- Bash Stun (Stun from bashing cast when NPC is pinned against an obstacle)
    [20172] = 'LuiExtended/media/icons/abilities/ability_innate_off-balance_exploit.dds', -- Off-Balance Exploit
    [16566] = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', -- CC Immunity
    [16593] = 'LuiExtended/media/icons/abilities/ability_innate_melee_snare.dds', -- Melee Snare

    ----------------------------------------------------------------
    -- DRAGONKNIGHT PASSIVES ---------------------------------------
    ----------------------------------------------------------------

    -- Ardent Flame
    [29436] = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds', -- Warmth (Warmth - Rank 1)
    [45016] = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds', -- Warmth (Warmth - Rank 2)

    -- Earthen Heart
    [29465] = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds', -- Battle Roar (Battle Roar - Rank 1)
    [29466] = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds', -- Battle Roar (Battle Roar - Rank 1)
    [29467] = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds', -- Battle Roar (Battle Roar - Rank 1)
    [44986] = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds', -- Battle Roar (Battle Roar - Rank 2)
    [44987] = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds', -- Battle Roar (Battle Roar - Rank 2)
    [44988] = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds', -- Battle Roar (Battle Roar - Rank 2)

    [61798] = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds', -- Minor Brutality (Mountain's Blessing - Rank 1)
    [29474] = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds', -- Mountain's Blessing (Mountain's Blessing - Rank 1)
    [61799] = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds', -- Minor Brutality (Mountain's Blessing - Rank 2)
    [45005] = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds', -- Mountain's Blessing (Mountain's Blessing - Rank 1)

    [29476] = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds', -- Kynareth's Blessing (Helping Hands - Rank 1)
    [45010] = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds', -- Kynareth's Blessing (Helping Hands - Rank 2)
    
    ----------------------------------------------------------------
    -- DRAGONKNIGHT ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------
    
    -- Lava Whip
    [23808] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Off Balance (Lava Whip - Rank 1)
    [20804] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Off Balance (Lava Whip - Rank 2)
    [23810] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Off Balance (Lava Whip - Rank 3)
    [23812] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Off Balance (Lava Whip - Rank 4)
    
    [29230] = 'esoui/art/icons/ability_debuff_major_defile.dds', -- Major Deflie (Dragonknight Standard - Rank 1)
    
    ----------------------------------------------------------------
    -- SORCERER PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    -- Dark Magic
    [31384] = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds', -- Blood Magic (Blood Magic - Rank 1)
    [45173] = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds', -- Blood Magic (Blood Magic - Rank 2)

    [62319] = 'LuiExtended/media/icons/abilities/ability_sorcerer_exploitation.dds', -- Minor Prophecy (Exploitation - Rank 1)
    [62320] = 'LuiExtended/media/icons/abilities/ability_sorcerer_exploitation.dds', -- Minor Prophecy (Exploitation - Rank 2)

    -- Daedric Summoning
    [64860] = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds', -- Rebate Magic (Rebate - Rank 1)
    [64861] = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds', -- Rebate Magic (Rebate - Rank 2)

    -- Storm Calling
    [31424] = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds', -- Implosion (Implosion - Rank 1)
    [82803] = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds', -- Implosion (Implosion - Rank 1)
    [45194] = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds', -- Implosion (Implosion - Rank 2)
    [82806] = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds', -- Implosion (Implosion - Rank 2)

    ----------------------------------------------------------------
    -- NIGHTBLADE PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    -- Assassination
    [36633] = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds', -- Executioner (Executioner - Rank 1)
    [45050] = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds', -- Executioner (Executioner - Rank 2)

    [61882] = 'LuiExtended/media/icons/abilities/ability_nightblade_hemorrhage.dds', -- Minor Savagery (Hemorrhage - Rank 1)
    [61898] = 'LuiExtended/media/icons/abilities/ability_nightblade_hemorrhage.dds', -- Minor Savagery (Hemorrhage - Rank 2)

    -- Shadow
    [18868] = 'LuiExtended/media/icons/abilities/ability_nightblade_shadow_barrier.dds', -- Major Ward (Shadow Barrier - Rank 1)
    [66075] = 'LuiExtended/media/icons/abilities/ability_nightblade_shadow_barrier.dds', -- Major Resolve (Shadow Barrier - Rank 1)
    [45076] = 'LuiExtended/media/icons/abilities/ability_nightblade_shadow_barrier.dds', -- Major Ward (Shadow Barrier - Rank 2)
    [66083] = 'LuiExtended/media/icons/abilities/ability_nightblade_shadow_barrier.dds', -- Major Resolve (Shadow Barrier - Rank 2)

    -- Siphoning
    [63705] = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds', -- Amphibious Regen (Catalyst - Rank 1)
    [63707] = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds', -- Amphibious Regen (Catalyst - Rank 2)

    [36589] = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds', -- Transfer (Transfer - Rank 1)
    [45146] = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds', -- Transfer (Transfer - Rank 2)

    ----------------------------------------------------------------
    -- TEMPLAR PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Aedric Spear
    [31720] = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds', -- Burning Light (Burning Light - Rank 1)
    [80153] = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds', -- Burning Light (Burning Light - Rank 1)
    [44731] = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds', -- Burning Light (Burning Light - Rank 2)
    [80170] = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds', -- Burning Light (Burning Light - Rank 2)

    -- Dawn's Wrath
    [31746] = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds', -- Prism (Prism - Rank 1)
    [45217] = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds', -- Prism (Prism - Rank 2)

    [62799] = 'LuiExtended/media/icons/abilities/ability_templar_illuminate.dds', -- Minor Sorcery (Illuminate - Rank 1)
    [62800] = 'LuiExtended/media/icons/abilities/ability_templar_illuminate.dds', -- Minor Sorcery (Illuminate - Rank 2)

    -- Restoring Light
    [77082] = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', -- Major Mending (Sacred Ground - Rank 1 & 2)
    [80230] = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', -- Sacred Ground (Sacred Ground - Rank 1 & 2)

    [52703] = 'LuiExtended/media/icons/abilities/ability_templar_illuminate.dds', -- Light Weaver Ultimate (Light Weaver - Rank 1 & 2)

    ----------------------------------------------------------------
    -- PLAYER WEAPON ATTACKS ---------------------------------------
    ----------------------------------------------------------------

    [23604] = 'LuiExtended/media/icons/abilities/ability_unarmed_attacklight.dds', -- Light Attack
    [18430] = 'LuiExtended/media/icons/abilities/ability_unarmed_attackmedium.dds', -- Heavy Attack
    [18431] = 'LuiExtended/media/icons/abilities/ability_unarmed_attackheavy.dds', -- Heavy Attack
    [60772] = 'LuiExtended/media/icons/abilities/ability_unarmed_attackrestore.dds', -- Heavy Attack (Unarmed)

    [16037] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', -- Light Attack
    [17162] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', -- Heavy Attack
    [17163] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', -- Heavy Attack
    [60757] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', -- Heavy Attack (2H)

    [15435] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', -- Light Attack
    [15282] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', -- Heavy Attack
    [15829] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', -- Heavy Attack
    [60759] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', -- Heavy Attack (Shield)

    [16499] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', -- Light Attack
    [17170] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', -- Heavy Attack
    [17169] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', -- Heavy Attack
    [18622] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', -- Heavy Attack (Dual Wield)
    [60758] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', -- Heavy Attack (Dual Wield)

    [16688] = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', -- Light Attack
    [17174] = 'LuiExtended/media/icons/abilities/ability_bow_attackmedium.dds', -- Heavy Attack
    [17173] = 'LuiExtended/media/icons/abilities/ability_bow_attackheavy.dds', -- Heavy Attack
    [60761] = 'LuiExtended/media/icons/abilities/ability_bow_attackrestore.dds', -- Heavy Attack (Bow)

    [16277] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attacklight.dds', -- Light Attack
    [18405] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackmedium.dds', -- Heavy Attack
    [18406] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackheavy.dds', -- Heavy Attack
    [60762] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', -- Heavy Attack (Frost)

    [16165] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attacklight.dds', -- Light Attack
    [15385] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackmedium.dds', -- Heavy Attack
    [16321] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackheavy.dds', -- Heavy Attack
    [60763] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', -- Heavy Attack (Fire)

    [18350] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attacklight.dds', -- Light Attack
    [18396] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', -- Heavy Attack (Shock)
    [19277] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavypulse.dds', -- Shock Pulse
    [60764] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', -- Heavy Attack (Shock)

    [16145] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attacklight.dds', -- Light Attack
    [16212] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds', -- Heavy Attack
    [32760] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', -- Heavy Attack (Restoration)
    [28469] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds', -- Heavy Attack
    [38591] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds', -- Heavy Attack

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WEAPONS -------------------------------------
    ----------------------------------------------------------------

    -- Two Handed
    [30821] = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds', -- Forceful (Rank 1)
    [45445] = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds', -- Forceful (Rank 2)
    [29383] = 'LuiExtended/media/icons/abilities/ability_2handed_heavy_weapons.dds', -- Heavy Weapons Bleed (Rank 1)
    [45431] = 'LuiExtended/media/icons/abilities/ability_2handed_heavy_weapons.dds', -- Heavy Weapons Bleed (Rank 2)
    [60860] = 'LuiExtended/media/icons/abilities/ability_2handed_follow_up.dds', -- Bonus Damage (Follow Up - Rank 1)
    [60888] = 'LuiExtended/media/icons/abilities/ability_2handed_follow_up.dds', -- Bonus Damage (Follow Up - Rank 2)
    [29392] = 'LuiExtended/media/icons/abilities/ability_2handed_battle_rush.dds', -- Battle Rush (Battle Rush - Rank 1)
    [45450] = 'LuiExtended/media/icons/abilities/ability_2handed_battle_rush.dds', -- Battle Rush (Battle Rush - Rank 2)

    -- Dual Wield
    [30894] = 'LuiExtended/media/icons/abilities/ability_dualwield_twin_blade_and_blunt.dds', -- Twin Blade and Blunt Bleed (Rank 1)
    [45483] = 'LuiExtended/media/icons/abilities/ability_dualwield_twin_blade_and_blunt.dds', -- Twin Blade and Blunt Bleed (Rank 2)

    -- Bow
    [78854] = 'LuiExtended/media/icons/abilities/ability_bow_hawk_eye.dds', -- Hawk Eye (Hawk Eye - Rank 1)
    [78855] = 'LuiExtended/media/icons/abilities/ability_bow_hawk_eye.dds', -- Hawk Eye (Hawk Eye - Rank 2)
    [68793] = 'LuiExtended/media/icons/abilities/ability_bow_hasty_retreat.dds', -- Major Expedition (Hasty Retreat - Rank 1)
    [68795] = 'LuiExtended/media/icons/abilities/ability_bow_hasty_retreat.dds', -- Major Expedition (Hasty Retreat - Rank 2)

    -- Destruction Staff
    [69774] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_tri_focus.dds', -- Tri Focus (Tri Focus - Rank 1)
    [69773] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_tri_focus.dds', -- Tri Focus (Tri Focus - Rank 2)
    [30951] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', -- Shock (Tri Focus - Rank 1)
    [45505] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', -- Shock (Tri Focus - Rank 2)
    [30966] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_destruction_expert.dds', -- Magicka Restore (Destruction Expert - Rank 1)
    [45515] = 'LuiExtended/media/icons/abilities/ability_destructionstaff_destruction_expert.dds', -- Magicka Restore (Destruction Expert - Rank 2)

    -- Restoration Staff
    [30978] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds', -- Essence Drain (Rank 1)
    [45518] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds', -- Essence Drain (Rank 2)
    [77918] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds', -- Major Mending (Essence Drain - Rank 1)
    [77922] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds', -- Major Mending (Essence Drain - Rank 2)
    [30971] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_absorb.dds', -- Absorb (Rank 1)
    [45522] = 'LuiExtended/media/icons/abilities/ability_restorationstaff_absorb.dds', -- Absorb (Rank 2)
    
    ----------------------------------------------------------------
    -- PLAYER ACTIVES WEAPONS --------------------------------------
    ----------------------------------------------------------------
    
    -- Destruction Staff
    [68719] = 'LuiExtended/media/icons/abilities/ability_weapon_snare_frost.dds', -- Frozen (Wall of Elements - All Ranks) -- Frost
    
    [62968] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Wall of Storms (Wall of Elements - Rank 1) -- Lightning
    [62973] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Wall of Storms (Wall of Elements - Rank 2) -- Lightning
    [62978] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Wall of Storms (Wall of Elements - Rank 3) -- Lightning
    [62983] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Wall of Storms (Wall of Elements - Rank 4) -- Lightning
    
    -- Restoration Staff
    [28386] = 'esoui/art/icons/ability_restorationstaff_004.dds', -- Grand Healing (Grand Healing - Rank 1)
    [41245] = 'esoui/art/icons/ability_restorationstaff_004.dds', -- Grand Healing (Grand Healing - Rank 2)
    [41247] = 'esoui/art/icons/ability_restorationstaff_004.dds', -- Grand Healing (Grand Healing - Rank 3)
    [41249] = 'esoui/art/icons/ability_restorationstaff_004.dds', -- Grand Healing (Grand Healing - Rank 4)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES ARMOR ---------------------------------------
    ----------------------------------------------------------------

    -- Heavy Armor
    [58428] = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds', -- Constitution (Constitution - Rank 1)
    [58503] = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds', -- Constitution (Constitution - Rank 1)
    [58430] = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds', -- Constitution (Constitution - Rank 2)
    [58431] = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds', -- Constitution (Constitution - Rank 2)
    [80000] = 'LuiExtended/media/icons/abilities/ability_armor_wrath.dds', -- Wrath (Wrath - Rank 1)
    [80012] = 'LuiExtended/media/icons/abilities/ability_armor_wrath.dds', -- Wrath (Wrath - Rank 2)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WORLD ---------------------------------------
    ----------------------------------------------------------------

    -- Soul Magic
    [39267] = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds', -- Soul Shatter (Soul Shatter - Rank 1)
    [45584] = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds', -- Soul Shatter (Soul Shatter - Rank 2)

    -- Vampire
    [35771] = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_1.dds', -- Stage 1 Vampirism (Vampire General)
    [35776] = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_2.dds', -- Stage 2 Vampirism (Vampire General)
    [35783] = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_3.dds', -- Stage 3 Vampirism (Vampire General)
    [35792] = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_4.dds', -- Stage 4 Vampirism (Vampire General)
    [33177] = 'esoui/art/icons/ability_vampire_002.dds', -- Feed
    [33182] = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', -- Uber Attack (Savage Feeding - Rank 1)
    [33183] = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', -- Off-Balance Self (Savage Feeding - Rank 2)
    [46047] = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', -- Uber Attack (Savage Feeding - Rank 1)
    [46046] = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', -- Off-Balance Self (Savage Feeding - Rank 2)
    [40349] = 'LuiExtended/media/icons/abilities/ability_vampire_blood_ritual.dds', -- Feed (Blood Ritual - Rank 1)
    [40351] = 'LuiExtended/media/icons/abilities/ability_vampire_blood_ritual.dds', -- Feed (Blood Ritual - Rank 1)
    [40353] = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', -- Uber Attack (Blood Ritual - Rank 1)
    [40360] = 'LuiExtended/media/icons/abilities/ability_vampire_noxiphilic_sanguivoria.dds', -- Vampirism (Blood Ritual - Rank 1)

    -- Werewolf
    [35658] = 'LuiExtended/media/icons/abilities/ability_werewolf_lycanthrophy.dds', -- Lycanthrophy
    [32464] = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds', -- Light Attack
    [89146] = 'LuiExtended/media/icons/abilities/ability_werewolf_attackbleed.dds', -- Werewolf Bleed
    [32479] = 'LuiExtended/media/icons/abilities/ability_werewolf_attackmedium.dds', -- Heavy Attack
    [32480] = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', -- Heavy Attack Werewolf
    [32494] = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', -- Heavy Attack
    [60773] = 'LuiExtended/media/icons/abilities/ability_werewolf_attackrestore.dds', -- Stamina Return
    [33209] = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', -- Devour (Devour - Rank 1)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES GUILDS --------------------------------------
    ----------------------------------------------------------------

    -- Dark Brotherhood
    [76325] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds', -- Blade of Woe
    [79623] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_padomaic_sprint.dds', -- Major Expedition (Padomaic Sprint - Rank 1) (Blade of Woe Kill)
    [79624] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_padomaic_sprint.dds', -- Major Expedition (Padomaic Sprint - Rank 2) (Blade of Woe Kill)
    [79625] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_padomaic_sprint.dds', -- Major Expedition (Padomaic Sprint - Rank 3) (Blade of Woe Kill)
    [79877] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_padomaic_sprint.dds', -- Major Expedition (Padomaic Sprint - Rank 4) (Blade of Woe Kill)
    [80392] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_padomaic_sprint.dds', -- Major Expedition (Padomaic Sprint - Rank 1) (Normal Kill)
    [80394] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_padomaic_sprint.dds', -- Major Expedition (Padomaic Sprint - Rank 2) (Normal Kill)
    [80396] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_padomaic_sprint.dds', -- Major Expedition (Padomaic Sprint - Rank 3) (Normal Kill)
    [80398] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_padomaic_sprint.dds', -- Major Expedition (Padomaic Sprint - Rank 4) (Normal Kill)

    -- Fighters Guild
    [35801] = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds', -- Banish the Wicked (Banish the Wicked - Rank 1)
    [45598] = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds', -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45600] = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds', -- Banish the Wicked (Banish the Wicked - Rank 3)

    -- Mages Guild
    [65507] = 'LuiExtended/media/icons/abilities/ability_mageguild_might_of_the_guild.dds', -- Empower (Might of the Guild - Rank 1)
    [65541] = 'LuiExtended/media/icons/abilities/ability_mageguild_might_of_the_guild.dds', -- Empower (Might of the Guild - Rank 2)

    -- Undaunted
    [55606] = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', -- Undaunted Command (Undaunted Command - Rank 1)
    [55607] = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', -- Undaunted Command Magicka Rest (Undaunted Command - Rank 1)
    [55608] = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', -- Undaunted Command Stamina Rest (Undaunted Command - Rank 1)
    [55677] = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', -- Undaunted Command (Undaunted Command - Rank 2)
    [55678] = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', -- Undaunted Command Stamina Rest (Undaunted Command - Rank 2)
    [55679] = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', -- Undaunted Command Magicka Rest (Undaunted Command - Rank 2)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES ALLIANCE WAR --------------------------------
    ----------------------------------------------------------------

    [39249] = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds', -- Continuous Attack (Continuous Attack - Rank 1)
    [45617] = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds', -- Continuous Attack (Continuous Attack - Rank 2)

    [39253] = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds', -- Combat Frenzy (Combat Frenzy - Rank 1)
    [45620] = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds', -- Combat Frenzy (Combat Frenzy - Rank 2)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES RACIAL --------------------------------------
    ----------------------------------------------------------------

    [36548] = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds', -- Adrenaline Rush (Adrenaline Rush - Rank 1)
    [45314] = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds', -- Adrenaline Rush (Adrenaline Rush - Rank 2)
    [45316] = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds', -- Adrenaline Rush (Adrenaline Rush - Rank 3)

    [63694] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 1)
    [63695] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 1)
    [63696] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 1)
    [63697] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 2)
    [63698] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 2)
    [63699] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 2)
    [63701] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 3)
    [63702] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 3)
    [63703] = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds', -- Resourceful (Resourceful - Rank 3)

    [36214] = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds', -- Star of the West (Red Diamond - Rank 1)
    [45292] = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds', -- Star of the West (Red Diamond - Rank 2)
    [45294] = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds', -- Star of the West (Red Diamond - Rank 3)

    -- TRAPS
    [44029] = 'LuiExtended/media/icons/abilities/ability_slaughterfish.dds', -- Slaughterfish Attack (Environmental)
    [21941] = 'esoui/art/icons/death_recap_environmental.dds', -- Spike Trap Snare (Spike Trap)
    [21942] = 'esoui/art/icons/death_recap_environmental.dds', -- Trap Sprung (Spike Trap)
    [65854] = 'esoui/art/icons/death_recap_environmental.dds', -- Spike Trap Snare (Spike Trap) (Orsinium - To Save a Chief)
    [65855] = 'esoui/art/icons/death_recap_environmental.dds', -- Trap Sprung (Spike Trap) (Orsinium - To Save a Chief)

    ----------------------------------------------------------------
    -- NPC(Basic) --------------------------------------------------
    ----------------------------------------------------------------

    -- SHARED NPC PASSIVES
    [33097] = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', -- Scary Immunities
    [44176] = 'LuiExtended/media/icons/abilities/ability_innate_flying_immunities.dds', -- Flying Immunities
    [13739] = 'esoui/art/icons/ability_rogue_046.dds', -- Backstabber

    -- SHARED NPC ACTIVE EVENTS
    [8239] = 'LuiExtended/media/icons/abilities/ability_innate_hamstrung.dds', -- Hamstrung

    -- SHARED NPC MISC
    [38117] = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', -- CC Immunity

    -- HUMAN NPC ABILITIES
    [10618] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', -- Quick Strike (Shared Human NPC)
    [12437] = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', -- Quick Shot (Shared Human NPC)
    [12456] = 'esoui/art/icons/ability_mage_009.dds', -- Ice Arrow (Shared Human NPC)
    [10639] = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', -- Flare (Shared Human NPC)
    [39060] = 'LuiExtended/media/icons/abilities/ability_rogue_bear_trap.dds', -- Bear Trap (Shared Human NPC)
    [39065] = 'LuiExtended/media/icons/abilities/ability_rogue_bear_trap.dds', -- Bear Trap (Shared Human NPC)

    [10648] = 'LuiExtended/media/icons/abilities/ability_warrior_throw_oil.dds', -- Throw Oil (Synergy)
    [10650] = 'LuiExtended/media/icons/abilities/ability_warrior_oil_drenched.dds', -- Oil Drenched (Synergy)
    [14068] = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', -- Ignite (Synergy)
    [10813] = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', -- Ignite (Synergy)
    [38260] = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', -- Ignite (Synergy)

    [14096] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', -- Heavy Attack (Footsoldier)
    [28499] = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', -- Throw Dagger (Footsoldier)
    [28502] = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', -- Throw Dagger (Footsoldier)
    [28504] = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', -- Throw Dagger (Footsoldier)

    [29400] = 'esoui/art/icons/ability_1handed_005.dds', -- Power Bash (Guard)
    [29401] = 'esoui/art/icons/ability_1handed_005.dds', -- Power Bash (Guard)
    [29402] = 'esoui/art/icons/ability_1handed_005.dds', -- Power Bash (Guard)
    [29765] = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', -- Uber Attack (Guard)
    [84346] = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', -- Uber Attack (Guard)

    [14925] = 'esoui/art/icons/ability_warrior_011.dds', -- Charge (Brute)
    [14926] = 'esoui/art/icons/ability_warrior_011.dds', -- Charge (Brute)

    [29379] = 'esoui/art/icons/ability_2handed_001.dds', -- Uppercut (Ravager)
    [29380] = 'esoui/art/icons/ability_2handed_001.dds', -- Uppercut (Ravager)

    [29035] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', -- Quick Strike (Rogue/Skirmisher)
    [12381] = 'esoui/art/icons/ability_rogue_063.dds', -- Assassinate (Rogue/Skirmisher)

    [10735] = 'esoui/art/icons/ability_dualwield_001_b.dds', -- Blood Craze (Berserker)
    [49252] = 'esoui/art/icons/ability_dualwield_001_b.dds', -- Blood Craze (Berserker)
    [49254] = 'esoui/art/icons/ability_dualwield_001_b.dds', -- Blood Craze (Berserker)
    [44206] = 'LuiExtended/media/icons/abilities/ability_weapon_heated_blades.dds', -- Minor Maim (formerly Heated Blades)

    [74472] = 'esoui/art/icons/ability_dragonknight_010.dds', -- Dark Talons (Dragonknight)

    [29511] = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds', -- Thunder Hammer (Thundermaul)
    [17867] = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_aura.dds', -- Shock Aura (Thundermaul)
    [44408] = 'esoui/art/icons/ability_sorcerer_lightning_form.dds', -- Lightning Form (Thundermaul)

    [36471] = 'esoui/art/icons/ability_nightblade_002.dds', -- Veiled Strike (Nightblade)
    [63822] = 'esoui/art/icons/ability_nightblade_008.dds', -- Teleport Strike (Nightblade)
    [44349] = 'esoui/art/icons/ability_nightblade_018_a.dds', -- Soul Tether (Nightblade)
    [44352] = 'esoui/art/icons/ability_nightblade_018_a.dds', -- Soul Tether (Nightblade)
    [44350] = 'esoui/art/icons/ability_nightblade_018_a.dds', -- Soul Tether (Nightblade)

    [37109] = 'esoui/art/icons/ability_bow_005.dds', -- Arrow Spray (Archer)
    [74978] = 'LuiExtended/media/icons/abilities/ability_bow_attackheavy.dds', -- Taking Aim (Archer)
    [74980] = 'LuiExtended/media/icons/abilities/ability_bow_attackheavy.dds', -- Taking Aim (Archer)

    [44305] = 'esoui/art/icons/ability_fightersguild_004.dds', -- Trap Beast (Pet Ranger)

    [16588] = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds', -- Heat Wave (Fire Mage)
    [47102] = 'LuiExtended/media/icons/abilities/ability_mage_fire_runes.dds', -- Fire Runes (Fire Mage)

    [14524] = 'LuiExtended/media/icons/abilities/ability_sorcerer_lightning_ranged.dds', -- Shock (Storm Mage)
    [29470] = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_thrall.dds', -- Thunder Thrall (Storm Mage)

    [14550] = 'esoui/art/icons/ability_mage_050.dds', -- Winter's Reach (Frost Mage)

    [37200] = 'esoui/art/icons/ability_mage_004.dds', -- Burden (Spirit Mage)
    [35142] = 'esoui/art/icons/ability_mage_004.dds', -- Burden (Spirit Mage)

    [37150] = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', -- Flare (Battlemage)
    [37028] = 'LuiExtended/media/icons/abilities/ability_mage_empower_weapon_flame_meleeattack.dds', -- Quick Strike (Battlemage)
    [37029] = 'LuiExtended/media/icons/abilities/ability_mage_empower_weapon_flame_meleeattack.dds', -- Quick Strike (Battlemage)
    [37030] = 'LuiExtended/media/icons/abilities/ability_mage_empower_weapon_flame_meleeattack.dds', -- Quick Strike (Battlemage)
    [37021] = 'LuiExtended/media/icons/abilities/ability_mage_empower_weapon_flame.dds', -- Empower Weapon: Flame (Battlemage)
    [37156] = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds', -- Lightning Onslaught (Battlemage)
    [37131] = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds', -- Ice Cage (Battlemage)
    [37132] = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds', -- Ice Cage (Battlemage)
    [50108] = 'esoui/art/icons/ability_sorcerer_monsoon.dds', -- Negate Magic (Battlemage)

    [37126] = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds', -- Entropic Flare (Timb Bomb Mage)
    [36986] = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds', -- Void (Time Bomb Mage)

    [56828] = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force.dds', -- Fright Force (Fear Mage)
    [14350] = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror.dds', -- Aspect of Terror (Fear Mage)
    [37084] = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror.dds', -- Aspect of Terror (Fear Mage)
    [35865] = 'esoui/art/icons/ability_nightblade_004.dds', -- Shadow Cloak (Fear Mage)

    [89017] = 'esoui/art/icons/ability_nightblade_001.dds', -- Dark Shade
    [89010] = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds', -- Corrode
    [89012] = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds', -- Minor Maim

    [44323] = 'esoui/art/icons/ability_armor_003_a.dds', -- Dampen Magic (Soulbrander)
    [44258] = 'esoui/art/icons/ability_mageguild_002_a.dds', -- Radiant Magelight (Soulbrander)

    [29372] = 'esoui/art/icons/ability_mage_027.dds', -- Necrotic Spear (Necromancer)
    [13377] = 'esoui/art/icons/crafting_runecrafter_plug_sp_003.dds', -- Reanimate Skeleton (Necromancer)
    [5614] = 'esoui/art/icons/crafting_runecrafter_plug_sp_003.dds', -- Voice to Wake the Dead (Necromancer)

    [7590] = 'esoui/art/icons/ability_mage_027.dds', -- Entropic Bolt (Gravesinger)
    [88322] = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds', -- Bone Cage (Gravesinger)
    [35391] = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds', -- Defiled Grave (Gravesinger)

    [10601] = 'LuiExtended/media/icons/abilities/ability_healer_minor_wound.dds', -- Minor Wound (Healer)
    [57534] = 'esoui/art/icons/ability_healer_016.dds', -- Focused Healing (Healer)
    [57537] = 'esoui/art/icons/ability_healer_016.dds', -- Focused Healing (Healer)
    [57538] = 'esoui/art/icons/ability_healer_016.dds', -- Focused Healing (Healer)

    [29669] = 'LuiExtended/media/icons/abilities/ability_healer_coiled_lash.dds', -- Coiled Lash (Shaman)
    [29521] = 'LuiExtended/media/icons/abilities/ability_healer_aura_of_protection.dds', -- Aura of Protection (Shaman)

    [68866] = 'esoui/art/icons/ability_ava_003.dds', -- Warhorn (Faction NPCs)
    [38119] = 'esoui/art/icons/ability_ava_001.dds', -- Caltrops  (Faction NPCs)
    [38125] = 'esoui/art/icons/ability_ava_001.dds', -- Caltrops  (Faction NPCs)

    [67114] = 'esoui/art/icons/ability_warrior_014.dds', -- Retaliation (Winterborn Warrior)
    [69157] = 'esoui/art/icons/ability_warrior_014.dds', -- Retaliation (Winterborn Warrior)
    [69153] = 'esoui/art/icons/ability_warrior_014.dds', -- Retaliation (Winterborn Warrior)
    [1347] = 'esoui/art/icons/ability_debuff_offbalance.dds', -- Off-Balance (Winterborn Warrior)
    [70070] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', -- Heavy Strike (Winterborn Warrior)
    [64980] = 'LuiExtended/media/icons/abilities/ability_warrior_javelin.dds', -- Javelin (Winterborn Warrior)

    [54593] = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', -- Flare (Winterborn Mage)
    [55911] = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', -- Grasping Vines (Winterborn Mage)
    [55918] = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', -- Grasping Vines (Winterborn Mage)
    [55916] = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vineburst.dds', -- Grasping Vineburst (Winterborn Mage)
    [64711] = 'LuiExtended/media/icons/abilities/ability_mage_hand_of_flame.dds', -- Flames (Winterborn Mage)

    [53987] = 'esoui/art/icons/ability_2handed_005_b.dds', -- Rally (Vosh Rakh Devoted)
    [65235] = 'esoui/art/icons/ability_warrior_025.dds', -- Enrage (Vosh Rakh Devoted)
    [54028] = 'esoui/art/icons/ability_warrior_032.dds', -- Divine Leap (Vosh Rakh Devoted)
    [67593] = 'esoui/art/icons/ability_warrior_032.dds', -- Divine Leap Stagger (Vosh Rakh Devoted)
    [54050] = 'esoui/art/icons/ability_warrior_032.dds', -- Divine Leap Stun (Vosh Rakh Devoted)

    [51923] = 'esoui/art/icons/ability_2handed_002.dds', -- Cleave Stance (Dremora Caitiff)
    [51940] = 'esoui/art/icons/ability_2handed_002.dds', -- Cleave Stance (Dremora Caitiff)
    [51942] = 'esoui/art/icons/ability_2handed_002.dds', -- Cleave Stance (Dremora Caitiff)

    [74480] = 'esoui/art/icons/ability_dragonknight_005.dds', -- Fiery Grip (Sentinel) (TG DLC)
    [74483] = 'esoui/art/icons/ability_dragonknight_005.dds', -- Fiery Grip (Sentinel) (TG DLC)

    [72716] = 'esoui/art/icons/ability_rogue_043.dds', -- Uncanny Dodge (Archer) (TG DLC)
    [72214] = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds', -- Poisoned Arrow (Archer) (TG DLC)
    [72217] = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds', -- Poisoned Arrow (Archer) (TG DLC)
    [76089] = 'esoui/art/icons/ability_bow_001.dds', -- Snipe (Archer) (TG DLC)
    [72220] = 'esoui/art/icons/ability_bow_001.dds', -- Snipe (Archer) (TG DLC)
    [74619] = 'LuiExtended/media/icons/abilities/ability_trap_flare_trap.dds', -- Flare Trap (Archer) (TG DLC)
    [74621] = 'esoui/art/icons/ability_debuff_reveal.dds', -- Revealed (Archer) (TG DLC)

    [77472] = 'esoui/art/icons/ability_warrior_030.dds', -- 'Til Death (Bodyguard) (DB DLC)
    [79523] = 'esoui/art/icons/ability_warrior_030.dds', -- 'Til Death (Bodyguard) (DB DLC)
    [77555] = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', -- Shard Shield (Bodyguard) (DB DLC)
    [77562] = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', -- Shard Shield (Bodyguard) (DB DLC)
    [77609] = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', -- Shard Shield (Bodyguard) (DB DLC)
    [77815] = 'esoui/art/icons/ability_1handed_003.dds', -- Shield Charge (Bodyguard) (DB DLC)

    -- ANIMALS
    [5451] = 'LuiExtended/media/icons/abilities/ability_alit_bite.dds', -- Bite (Alit)
    [84356] = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', -- Lacerate (Alit)
    [56984] = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', -- Laceration (Alit)
    [56983] = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', -- Laceration (Alit)

    [4413] = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds', -- Swipe (Bear)
    [38772] = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', -- Crushing Swipe (Bear)
    [18273] = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', -- Crushing Swipe (Bear)
    [4416] = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds', -- Savage Blows (Bear)
    [12380] = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds', -- Savage Blows (Bear)
    [61594] = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds', -- Savage Blows Bleeding (Bear)
    [70355] = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds', -- Bite (Bear)
    [70357] = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds', -- Lunge (Bear)
    [70359] = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds', -- Lunge (Bear)
    [89189] = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', -- Slam (Bear)
    [69073] = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', -- Knockdown (Bear)

    [4583] = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds', -- Bite (Crocodile)
    [9642] = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds', -- Bite (Crocodile)
    [4587] = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds', -- Crushing Chomp (Crocodile)
    [32051] = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds', -- Sweeping (Crocodile)

    [8971] = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds', -- Bite (Duneripper)
    [9643] = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds', -- Bite (Duneripper)
    [8972] =  'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds', -- Crushing Chomp (Duneripper)
    [32461] = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds', -- Sweep (Duneripper)

    [7214] = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds', -- Bite (Durzog)
    [7221] = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds', -- Rend (Durzog)
    [7227] = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', -- Rotbone (Durzog)
    [16878] = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', -- Rotbone (Durzog)

    [6304] = 'LuiExtended/media/icons/abilities/ability_dreugh_swipe.dds', -- Swipe (Dreugh)
    [18002] = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds', -- Slash (Dreugh)
    [18003] = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds', -- Slash (Dreugh)
    [18005] = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds', -- Slash (Dreugh)
    [6308] = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_touch.dds', -- Shocking Touch (Dreugh)
    [27100] = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds', -- Shocking Rake (Dreugh)

    [54374] = 'LuiExtended/media/icons/abilities/ability_echatere_tusks.dds', -- Tusks (Echatere)
    [54378] = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds', -- Shockwave (Echatere)
    [54382] = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds', -- Headbutt (Echatere)
    [54381] = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds', -- Headbutt (Echatere)

    [60920] = 'LuiExtended/media/icons/abilities/ability_bat_scrape.dds', -- Scrape (Giant Bat)
    [47321] = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds', -- Screech (Giant Bat)
    [18319] = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds', -- Screech (Giant Bat)
    [4630] = 'LuiExtended/media/icons/abilities/ability_bat_draining_bite.dds', -- Draining Bite (Giant Bat)

    [8540] = 'LuiExtended/media/icons/abilities/ability_snake_strike.dds', -- Strike (Giant Snake)
    [30214] = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds', -- Lash (Giant Snake)
    [5242] = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds', -- Kiss of Poison (Giant Snake)
    [21826] = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds', -- Kiss of Poison (Giant Snake)

    [5440] = 'LuiExtended/media/icons/abilities/ability_guar_bite.dds', -- Bite (Guar)
    [5443] = 'LuiExtended/media/icons/abilities/ability_guar_headbutt.dds', -- Headbutt (Guar)
    [84359] = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds', -- Dive (Guar)

    [5363] = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds', -- Chomp (Kagouti)
    [42889] = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds', -- Toss (Kagouti)
    [42888] = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds', -- Toss (Kagouti)
    [18198] = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds', -- Toss (Kagouti)

    [7170] = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds', -- Rend (Lion)
    [60630] = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds', -- Rend (Lion)
    [60641] = 'LuiExtended/media/icons/abilities/ability_lion_claw.dds', -- Claw (Lion)
    [7158] = 'LuiExtended/media/icons/abilities/ability_lion_bite.dds', -- Bite (Lion)
    [7161] = 'LuiExtended/media/icons/abilities/ability_lion_double_strike.dds', -- Double Strike (Lion)
    [8705] = 'LuiExtended/media/icons/abilities/ability_lion_daunting_roar.dds', -- Weakness (Lion)

    [8596] = 'LuiExtended/media/icons/abilities/ability_mammoth_swipe.dds', -- Swipe (Mammoth)
    [8604] = 'LuiExtended/media/icons/abilities/ability_mammoth_swipe.dds', -- Vigorous Swipe (Mammoth)
    [23164] = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds', -- Stomp (Mammoth)
    [23222] = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', -- Charge (Mammoth)
    [23227] = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', -- Charge (Mammoth)

    [4192] = 'LuiExtended/media/icons/abilities/ability_mudcrab_pincer.dds', -- Pincer (Mudcrab)
    [4224] = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds', -- Double Claw Strike (Mudcrab)
    [4226] = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds', -- Double Claw Strike (Mudcrab)
    [85082] = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds', -- Unforgiving Claws (Mudcrab)

    [16667] = 'LuiExtended/media/icons/abilities/ability_netch_slap.dds', -- Slap (Netch)
    [16690] = 'LuiExtended/media/icons/abilities/ability_netch_thrust.dds', -- Thrust (Netch)
    [16698] = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds', -- Poisonbloom (Netch)

    [7266] = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds', -- Strike (Nix-Hound)
    [13416] = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds', -- Strike (Nix-Hound)
    [12303] = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds', -- Leech (Nix-Hound)
    [38635] = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds', -- Dampworm (Nix-Hound)
    [38640] = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds', -- Dampworm (Nix-Hound)

    [5362] = 'LuiExtended/media/icons/abilities/ability_skeever_slam.dds', -- Slam (Skeever)
    [21904] = 'LuiExtended/media/icons/abilities/ability_skeever_rend.dds', -- Rend (Skeever)

    [21947] = 'LuiExtended/media/icons/abilities/ability_wamasu_bite.dds', -- Bite (Wamasu)
    [46833] = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds', -- Sweep (Wamasu)
    [37178] = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds', -- Sweep (Wamasu)
    [21952] = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds', -- Repulsion Shock (Wamasu)
    [21961] = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', -- Charge (Wamasu)
    [21967] = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', -- Charge (Wamasu)

    [44781] = 'LuiExtended/media/icons/abilities/ability_welwa_swipe.dds', -- Swipe (Welwa)
    [45937] = 'LuiExtended/media/icons/abilities/ability_welwa_cleave.dds', -- Cleave (Welwa)
    [44792] = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds', -- Rear Kick (Welwa)
    [45986] = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', -- Charge (Welwa)
    [45991] = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', -- Charge (Welwa)

    [4022] = 'LuiExtended/media/icons/abilities/ability_wolf_bite.dds', -- Bite (Wolf)
    [42844] = 'LuiExtended/media/icons/abilities/ability_wolf_rotbone.dds', -- Rotbone (Wolf)
    [14523] = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds', -- Helljoint (Wolf)
    [75818] = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds', -- Helljoint (Wolf)

    -- DAEDRA
    [51265] = 'LuiExtended/media/icons/abilities/ability_air_atronach_flame.dds', -- Air Atronach Flame (Air Atronach - Flame)
    [51270] = 'LuiExtended/media/icons/abilities/ability_air_atronach_storm.dds', -- Air Atronach Flame (Air Atronach - Storm)
    [51267] = 'LuiExtended/media/icons/abilities/ability_air_atronach_frost.dds', -- Air Atronach Flame (Air Atronach - Frost)
    [48092] = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds', -- Swipe (Air Atronach)
    [48093] = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds', -- Swipe (Air Atronach)
    [48096] = 'LuiExtended/media/icons/abilities/ability_airatronach_flare.dds', -- Flare (Air Atronach)
    [48121] = 'LuiExtended/media/icons/abilities/ability_airatronach_heavy_attack.dds', -- Heavy Attack (Air Atronach)
    [48137] = 'LuiExtended/media/icons/abilities/ability_airatronach_tornado.dds', -- Tornado (Air Atronach)
    [51282] = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds', -- Flame Tornado (Air Atronach)
    [50023] = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds', -- Lightning Rod (Air Atronach)
    [88902] = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds', -- Lightning Rod (Air Atronach)
    [50026] = 'LuiExtended/media/icons/abilities/ability_mage_shock_pulse.dds', -- Lightning Rod (Air Atronach)
    [50021] = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds', -- Ice Vortex (Air Atronach)
    [50022] = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds', -- Ice Vortex (Air Atronach)

    [9743] = 'LuiExtended/media/icons/abilities/ability_banekin_entropic_touch.dds', -- Entropic Touch (Banekin)
    [9747] = 'LuiExtended/media/icons/abilities/ability_banekin_dire_wound.dds', -- Dire Wound (Banekin)
    [9749] = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds', -- Envelop (Banekin)

    [4798] = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt.dds', -- Headbutt (Clannfear)
    [84443] = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike.dds', -- Tail Spike (Clannfear)
    [14825] = 'LuiExtended/media/icons/abilities/ability_clannfear_charge.dds', -- Charge (Clannfear)
    [14828] = 'LuiExtended/media/icons/abilities/ability_clannfear_charge.dds', -- Charge (Clannfear)

    [26551] = 'LuiExtended/media/icons/abilities/ability_daedrictitan_strike.dds', -- Strike (Daedric Titan)
    [32852] = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_ranged.dds', -- Scourge Bolt (Daedric Titan)
    [32696] = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', -- Soul Flame (Daedric Titan)
    [35280] = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', -- Soul Flame (Daedric Titan)
    [73437] = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', -- Soul Flame (Daedric Titan)
    [35278] = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', -- Soul Flame (Daedric Titan)
    [26554] = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds', -- Wing Gust (Daedric Titan)
    [33085] = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds', -- Wing Gust (Daedric Titan)
    [33086] = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds', -- Wing Gust (Daedric Titan)

    [4750] = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw.dds', -- Jagged Claw (Daedroth)
    [4778] = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds', -- Fiery Jaws (Daedroth)
    [4772] = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds', -- Fiery Breath (Daedroth)

    [18471] = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', -- Flare (Flame Atronach)
    [18472] = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', -- Flare (Flame Atronach)
    [15157] = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', -- Flare (Flame Atronach)
    [12254] = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', -- Flare (Flame Atronach)
    [26325] = 'LuiExtended/media/icons/abilities/ability_flameatronach_lava_geyser.dds', -- Lava Geyser (Flame Atronach)
    [4491] = 'LuiExtended/media/icons/abilities/ability_flameatronach_radiance.dds', -- Radiance (Flame Atronach)
    [50215] = 'LuiExtended/media/icons/abilities/ability_mage_fire_aoe.dds', -- Combustion (Flame Atronach)

    [67123] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_tremor.dds', -- Tremor (Flesh Colossus)
    [67636] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_falling_debris.dds', -- Falling Debris (Flesh Colossus)
    [65709] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds', -- Pin (Flesh Colossus)
    [49820] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds', -- Stunned (Flesh Colossus)
    [53233] = 'LuiExtended/media/icons/abilities/ability_innate_snare_disease.dds', -- Miasma Pool (Flesh Colossus)
    [67872] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', -- Sweep (Flesh Colossus)
    [68824] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', -- Sweep (Flesh Colossus)
    [68813] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', -- Sweep Knockback (Flesh Colossus)
    [67842] = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', -- Sweep Shockwave (Flesh Colossus)
    [76129] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_stumble_forward.dds', -- Stumble Forward (Flesh Colossus)
    [76134] = 'esoui/art/icons/ability_debuff_stagger.dds', -- Stumble Forward (Flesh Colossus)
    [65755] = 'esoui/art/icons/ability_debuff_stagger.dds', -- Staggered (Flesh Colossus)
    [76133] = 'esoui/art/icons/ability_debuff_stagger.dds', -- Stumble Forward (Flesh Colossus)
    [49429] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_smash.dds', -- Smash (Flesh Colossus)
    [65744] = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_claw.dds', -- Claw (Flesh Colossus)

    [63275] = 'LuiExtended/media/icons/abilities/ability_fleshatronach_claw.dds', -- Claw (Flesh Atronach)
    [63276] = 'LuiExtended/media/icons/abilities/ability_fleshatronach_stomp.dds', -- Stomp (Flesh Atronach)
    [35413] = 'LuiExtended/media/icons/abilities/ability_fleshatronach_fire_brand.dds', -- Fire Brand (Flesh Atronach)
    [4817] = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', -- Unyielding Mace (Flesh Atronach)
    [20226] = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', -- Stun (Flesh Atronach)
    [27326] = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', -- Unyielding Mace (Flesh Atronach)
    [23077] = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', -- Bleeding (Flesh Atronach)

    [17069] = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_spear.dds', -- Ice Spear (Frost Atronach)
    [5009] = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_shards.dds', -- Ice Shards (Frost Atronach)
    [33551] = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds', -- Chilling Aura (Frost Atronach)
    [44906] = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds', -- Hoarfrost Fist (Frost Atronach)
    [44907] = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds', -- Hoarfrost Fist (Frost Atronach)
    [44908] = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds', -- Hoarfrost Fist (Frost Atronach)
    [51645] = 'LuiExtended/media/icons/abilities/ability_mage_snare_frost.dds', -- Frozen Ground (Frost Atronach)
    [51646] = 'LuiExtended/media/icons/abilities/ability_mage_snare_frost.dds', -- Frozen Ground (Frost Atronach)

    [65926] = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_slash.dds', -- Slash (Grevious Twilight)
    [65845] = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds', -- Rend (Grevious Twilight)
    [66643] = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds', -- Rend (Grevious Twilight)
    [50596] = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_bolt.dds', -- Shadow Bolt (Grevious Twilight)
    [50628] = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds', -- Shadow Strike (Grevious Twilight)
    [65891] = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds', -- Shadow Strike (Grevious Twilight)

    [11076] = 'esoui/art/icons/ability_mage_029.dds', -- Chasten (Harvester)
    [26008] = 'LuiExtended/media/icons/abilities/ability_harvester_black_winter.dds', -- Black Winter (Harvester)
    [11083] = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds', -- The Feast (Harvester)
    [26110] = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds', -- The Feast (Harvester)

    [8204] = 'LuiExtended/media/icons/abilities/ability_ogrim_strike.dds', -- Strike (Ogrim)
    [24693] = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', -- Body Slam (Ogrim)
    [24700] = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', -- Body Slam (Ogrim)

    [6158] = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', -- Flare (Scamp)
    [6167] = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds', -- Heat Wave (Scamp)
    [6162] = 'LuiExtended/media/icons/abilities/ability_mage_rain_of_fire.dds', -- Rain of Fire (Scamp)

    [8778] = 'LuiExtended/media/icons/abilities/ability_spiderdaedra_strike.dds', -- Strike (Spider Daedra)
    [8808] = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', -- Spit (Spider Daedra)
    [38658] = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds', -- Lightning Onslaught (Spider Daedra)
    [20530] = 'LuiExtended/media/icons/abilities/ability_mage_lightning_storm.dds', -- Lightning Storm (Spider Daedra)
    [89307] = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', -- Web (Spider Daedra - Spiderling)

    [4858] = 'LuiExtended/media/icons/abilities/ability_stormatronach_bash.dds', -- Bash (Storm Atronach)
    [13898] = 'LuiExtended/media/icons/abilities/ability_stormatronach_strike.dds', -- Strike (Storm Atronach)
    [35222] = 'LuiExtended/media/icons/abilities/ability_mage_impending_storm.dds', -- Impending Storm (Storm Atronach)
    [4864] = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', -- Storm Bound (Storm Atronach)
    [35240] = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', -- Storm Bound (Storm Atronach)
    [12287] = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', -- Storm Bound (Storm Atronach)
    [12288] = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', -- Storm Bound (Storm Atronach)
    [12286] = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', -- Storm Bound (Storm Atronach)

    [7095] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', -- Heavy Attack (Xivilai)
    [83072] = 'LuiExtended/media/icons/abilities/ability_mage_freezing_edge.dds', -- Freezing Edge (Xivilai)
    [49203] = 'LuiExtended/media/icons/abilities/ability_mage_frozen_weapon.dds', -- Frozen Weapon (Xivilai)
    [88949] = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds', -- Lightning Grasp (Xivilai)
    [25728] = 'LuiExtended/media/icons/abilities/ability_mage_hand_of_flame.dds', -- Hand of Flame (Xivilai)

    [4652] = 'LuiExtended/media/icons/abilities/ability_watcher_gaze.dds', -- Gaze (Watcher)
    [4653] = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds', -- Shockwave (Watcher)
    [43817] = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds', -- Shockwave Snare (Watcher)
    [53880] = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds', -- Shockwave (Watcher)
    [9220] = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', -- Doom-Truth's Gaze (Watcher)
    [14518] = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', -- Doom-Truth's Gaze (Watcher)
    [14461] = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', -- Doom-Truth's Gaze (Watcher)
    [14547] = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', -- Doom-Truth's Gaze (Watcher)
    [14426] = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', -- Doom-Truth's Gaze (Watcher)
    [14546] = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', -- Doom-Truth's Gaze (Watcher)

    [12062] = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds', -- Kick (Winged Twilight)
    [13690] = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds', -- Kick (Winged Twilight)
    [63612] = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_tail_clip.dds', -- Tail Clip (Winged Twilight)
    [6412] = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_dusks_howl.dds', -- Dusk's Howl (Winged Twilight)

    --[[
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    --]]

    -- DWEMER
    [64508] = 'esoui/art/icons/ability_warrior_030.dds', -- Find Turret (Dwemer Sentry)
    [27333] = 'LuiExtended/media/icons/abilities/ability_dwemer_overcharge.dds', -- Overcharge (Dwemer Spider)
    [20206] = 'LuiExtended/media/icons/abilities/ability_dwemer_overcharge.dds', -- Overcharge (Dwemer Spider)

    -- INSECTS
    [5278] = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_bite.dds', -- Bite (Assassin Beetle)
    [5268] = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_collywobbles.dds', -- Collywobbles (Assassin Beetle)
    [6137] = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', -- Laceration (Assassin Beetle)
    [51736] = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', -- Bleeding (Assassin Beetle)
    [51735] = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', -- Bleeding (Assassin Beetle)
    [13680] = 'LuiExtended/media/icons/abilities/ability_innate_snare_poison.dds', -- Acid Blood (Assassin Beetle)

    [6754] = 'LuiExtended/media/icons/abilities/ability_scorpion_pincer.dds', -- Pincer (Giant Scorpion)
    [6755] = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds', -- Sting (Giant Scorpion)
    [13671] = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds', -- Sting (Giant Scorpion)
    [6757] = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds', -- Blurred Strike (Giant Scorpion)
    [9040] = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds', -- Blurred Strike (Giant Scorpion)
    [6756] = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds', -- Paralyze (Giant Scorpion)
    [12312] = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds', -- Snare (Giant Scorpion)

    [4731] = 'LuiExtended/media/icons/abilities/ability_spider_bite.dds', -- Bite (Giant Spider)
    [5790] = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds', -- Poisonous Burst (Giant Spider)
    [5685] = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds', -- Corrosive Bite (Giant Spider)
    [8088] = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds', -- Poison Spray (Giant Spider)
    [4730] = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', -- Spit (Giant Spider)
    [47318] = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', -- Encase (Giant Spider)

    [9225] = 'LuiExtended/media/icons/abilities/ability_wasp_bite.dds', -- Bite (Giant Wasp)
    [9226] = 'LuiExtended/media/icons/abilities/ability_wasp_sting.dds', -- Sting (Giant Wasp)
    [9229] = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', -- Inject Larva (Giant Wasp)
    [9237] = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', -- Larva Gestation (Giant Wasp)
    [9238] = 'LuiExtended/media/icons/abilities/ability_wasp_larva_burst.dds', -- Larva Burst (Giant Wasp)
    [25113] = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', -- Charge (Giant Wasp)
    [25120] = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', -- Charge (Giant Wasp)

    [6788] = 'LuiExtended/media/icons/abilities/ability_hoarvor_bite.dds', -- Bite (Hoarvor)
    [42292] = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds', -- Bloodletting (Hoarvor)
    [13585] = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds', -- Latch On (Hoarvor)
    [61243] = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds', -- Vile Bite (Hoarvor DLC)
    [69392] = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds', -- Vile Bite Poison (Hoarvor DLC)
    [61244] = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds', -- Fevered Retch (Hoarvor DLC)
    [61245] = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds', -- Fevered Retch (Hoarvor DLC)
    [61377] = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds', -- Infectious Swarm (Hoarvor DLC)
    [61372] = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds', -- Infectious Swarm (Hoarvor DLC)
    [61374] = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds', -- Infectious Swarm (Hoarvor DLC)
    [61249] = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', -- Necrotic Explosion (Hoarvor DLC)
    [61388] = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', -- Necrotic Explosion Snare (Hoarvor DLC)

    [83977] = 'LuiExtended/media/icons/abilities/ability_kwamascrib_bite.dds', -- Bite (Kwama Scrib)
    [8272] = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', -- Spit (Kwama Scrib)
    [47838] = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', -- Contagion (Kwama Scrib)

    [9287] = 'LuiExtended/media/icons/abilities/ability_kwamaworker_bite.dds', -- Bite (Kwama Worker)
    [83953] = 'LuiExtended/media/icons/abilities/ability_kwamaworker_pounce.dds', -- Pounce (Kwama Worker)
    [18546] = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds', -- Shattered Ground (Kwama Worker)
    [18808] = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', -- Charge (Kwama Worker)
    [18810] = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', -- Charge (Kwama Worker)

    [15011] = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_swipe.dds', -- Swipe -- Kwama Warrior
    [9763] = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds', -- Smash -- Kwama Warrior
    [9764] = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds', -- Smash -- Kwama Warrior
    [27463] = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds', -- Excavation -- Kwama Warrior

    [6127] = 'LuiExtended/media/icons/abilities/ability_shalk_bite.dds', -- Bite (Shalk)
    [10947] = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds', -- Fiery Breath (Shalk)
    [5252] = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds', -- Fire Bite (Shalk)
    [6129] = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds', -- Fire Bite (Shalk)
    [5265] = 'LuiExtended/media/icons/abilities/ability_shalk_burning_ground.dds', -- Burning Ground (Shalk)

    [5308] = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunder_bite.dds', -- Thunder Bite (Thunderbug)
    [8429] = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds', -- Zap (Thunderbug)
    [65079] = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds', -- Zap (Thunderbug)
    [26379] = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', -- Zap (Thunderbug)
    [26382] = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', -- Bolt (Thunderbug)
    [34980] = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunderstrikes.dds', -- Thunderstrikes (Thunderbug)

    -- MONSTERS
    [25716] = 'esoui/art/icons/ability_debuff_stun.dds', -- Stun (Gargoyle)
    [25714] = 'esoui/art/icons/ability_mage_026.dds', -- Vampiric Touch (Gargoyle)
    [43742] = 'esoui/art/icons/ability_debuff_knockback.dds', -- Obliterate (Giant)
    [32267] = 'esoui/art/icons/ability_debuff_levitate.dds', -- Grapple (Hag)
    [65027] = 'esoui/art/icons/ability_healer_028.dds', -- Briarheart Resurrection (Hag)
    [17703] = 'LuiExtended/media/icons/abilities/ability_imp_flameray.dds', -- Flame Ray (Imp Fire Beam)
    [8884] = 'esoui/art/icons/ability_mage_016.dds', -- Zap (Imp Lightning Beam)
    [24985] = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds', -- Intimidating Roar (Ogre)
    [34385] = 'esoui/art/icons/ability_mage_050.dds', -- Generic AOE (Ogre Mage)
    [54327] = 'esoui/art/icons/ability_mage_050.dds', -- Winter's Reach (Ogre Mage)
    [9346] = 'esoui/art/icons/ability_healer_034.dds', -- Strangle (Strangler)
    [9707] = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds', -- Grapple (Strangler)
    [8926] = 'esoui/art/icons/ability_healer_033.dds', -- Regeneration (Troll)
    [18040] = 'LuiExtended/media/icons/abilities/ability_wispmother_clone.dds', -- Clone (Wispmother)
    [18049] = 'LuiExtended/media/icons/abilities/ability_wispmother_clone.dds', -- Clone (Wispmother)

    -- UNDEAD
    [38834] = 'LuiExtended/media/icons/abilities/ability_innate_snare_defiled_ground.dds', -- Desecrated Ground Snare (Desecrated Ground - Undead Synergy)
    [69950] = 'LuiExtended/media/icons/abilities/ability_innate_snare_defiled_ground.dds', -- Desecrated Ground (Desecrated Ground - Undead Synergy)

    [8569] = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds', -- Devastating Leap (Bloodfiend)

    [5028] = 'LuiExtended/media/icons/abilities/ability_bonecolossus_strike.dds', -- Strike (Bone Colossus)
    [30590] = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', -- Bone Saw (Bone Colossus)
    [17221] = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds', -- Slap (Bone Colossus - Risen Dead)
    [88828] = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds', -- Necromantic Implosion (Bone Colossus - Risen Dead)

    [8550] = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds', -- Slash (Bone Flayer)
    [8551] = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds', -- Slash (Bone Flayer)
    [8564] = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds', -- Rending Slash (Bone Flayer)
    [9194] = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds', -- Flurry (Bone Flayer)

    [8812] = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds', -- Double Strike (Ghost)
    [8813] = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds', -- Double Strike (Ghost)
    [18514] = 'esoui/art/icons/ability_mage_052.dds', -- Chill Touch (Ghost)
    [18515] = 'esoui/art/icons/ability_mage_052.dds', -- Chill Touch (Ghost)
    [19138] = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds', -- Haunting Spectre (Ghost)
    [19140] = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds', -- Haunting Spectre (Ghost)

    [9541] = 'esoui/art/icons/ability_mage_027.dds', -- Necrotic Spear (Lich)
    [20812] = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds', -- Defiled Ground (Lich)
    [22525] = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds', -- Defiled Ground (Lich)
    [73929] = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', -- Soul Cage (Lich)
    [73931] = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', -- Soul Rupture (Lich)
    [73926] = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', -- Soul Cage (Lich)
    [73937] = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', -- Soul Cage (Lich)
    [73939] = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', -- Soul Rupture (Lich)
    [73934] = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', -- Soul Cage (Lich)

    [49702] = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds', -- Entropic Flare (Spellfiend)
    [50456] = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds', -- Entropic Flare (Spellfiend)
    [50183] = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds', -- Consuming Energy (Spellfiend)
    [52398] = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds', -- Consuming Energy (Spellfiend)

    [68735] = 'LuiExtended/media/icons/abilities/ability_vampire_vampiric_drain.dds', -- Vampiric Drain (Vampire)
    [68750] = 'LuiExtended/media/icons/abilities/ability_vampire_vampiric_drain.dds', -- Vampiric Drain (Vampire)

    [4323] = 'LuiExtended/media/icons/abilities/ability_mage_frost_ranged.dds', -- Ice Bolt (Wraith)
    [4346] = 'esoui/art/icons/ability_mage_050.dds', -- Winter's Reach (Wraith)
    [43146] = 'esoui/art/icons/ability_mage_050.dds', -- Winter's Reach (Wraith)

    [2954] = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds', -- Swipe (Zombie)
    [13972] = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds', -- Swipe (Zombie)
    [63614] = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds', -- Swipe (Zombie)
    [2969] = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds', -- Pound (Zombie)
    [30347] = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds', -- Vomit (Zombie)

    --[[
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    [00000] = 'LuiExtended/media/icons/abilities/ability_', --
    --]]

    -- CYRODIIL
    [12033] = 'LuiExtended/media/icons/abilities/ability_ava_battle_spirit.dds', -- Battle Spirit

    [47717] = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', -- Quick Strike (Cyrodiil Guard T1)
    [46830] = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', -- Bleeding Strike (Cyrodiil Guard T2)
    [46832] = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', -- Bleeding (Cyrodiil Guard T2)
    [46831] = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', -- Bleeding (Cyrodiil Guard T2)
    [46834] = 'esoui/art/icons/ability_1handed_005.dds', -- Power Bash (Cyrodiil Guard T2)
    [72639] = 'esoui/art/icons/ability_1handed_005.dds', -- Power Bash (Cyrodiil Guard T2)
    [72641] = 'esoui/art/icons/ability_1handed_005.dds', -- Power Bash (Cyrodiil Guard T2)

    [7880] = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', -- Light Attack (Cyrodiil Mage T1)
    [21629] = 'esoui/art/icons/ability_mage_008.dds', -- Mage's Lifesteal (Cyrodiil Mage T1)
    [21632] = 'esoui/art/icons/ability_mage_008.dds', -- Lifesteal (Cyrodiil Mage T1)
    [21631] = 'esoui/art/icons/ability_mage_008.dds', -- Lifesteal (Cyrodiil Mage T1)
    [46726] = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', -- Shock Torrent (Cyrodiil Mage T2)
    [46730] = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', -- Shock Torrent (Cyrodiil Mage T2)
    [46819] = 'esoui/art/icons/ability_mage_068.dds', -- Storm Damage (Cyrodiil Mage T2)
    [46716] = 'esoui/art/icons/ability_mage_008.dds', -- Stolen Essence (Cyrodiil Mage T2)
    [46718] = 'esoui/art/icons/ability_mage_008.dds', -- Lifesteal (Cyrodiil Mage T2)
    [46717] = 'esoui/art/icons/ability_mage_008.dds', -- Lifesteal (Cyrodiil Mage T2)
    [46704] = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds', -- Crystal Blast (Cyrodiil Mage T2)
    [46706] = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds', -- Crystal Shard Stun (Cyrodiil Mage T2)

    [57962] = 'LuiExtended/media/icons/abilities/ability_healer_minor_wound.dds', -- Minor Wound (Cyrodiil Mender T1)
    [21638] = 'LuiExtended/media/icons/abilities/ability_healer_telekinetic_disorient.dds', -- Telekinetic Disorient (Cyrodiil Mender T1)
    [46839] = 'LuiExtended/media/icons/abilities/ability_healer_minor_wound.dds', -- Major Wound (Cyrodiil Mender T2)
    [46904] = 'esoui/art/icons/ability_templar_rune_focus.dds', -- Rune Focus (Cyrodiil Mender T2)
    [46906] = 'LuiExtended/media/icons/abilities/ability_healer_telekinetic_disorient.dds', -- Telekinetic Disorient (Cyrodiil Mender T2)
    [46910] = 'LuiExtended/media/icons/abilities/ability_healer_telekinetic_disorient.dds', -- Shattering Prison (Cyrodiil Mender T2)
    [46847] = 'esoui/art/icons/ability_healer_016.dds', -- Potent Healing (Cyrodiil Mender T2)
    [51893] = 'esoui/art/icons/ability_sorcerer_monsoon.dds', -- Negate Magic (Cyrodiil Mender T1 + T2)

    [52864] = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', -- Quick Shot (Cyrodiil Archer T1 + T2)
    [54264] = 'esoui/art/icons/ability_bow_001_a.dds', -- Lethal Arrow (Cryodiil Archer T2)
    [54265] = 'esoui/art/icons/ability_bow_001_a.dds', -- Lethal Arrow (Cryodiil Archer T2)
    [54259] = 'esoui/art/icons/ability_bow_004_a.dds', -- Draining Shot (Cryodiil Archer T2)
    [54261] = 'esoui/art/icons/ability_bow_004_a.dds', -- Draining Shot (Cryodiil Archer T2)

    [15780] = 'LuiExtended/media/icons/abilities/ability_basic_r_shock_aoe.dds', -- Honor Guard Rage (Cyrodiil Honor Guard T1)
    [35113] = 'esoui/art/icons/ability_dragonknight_005_a.dds', -- Extended Chains (Cyrodiil Honor Guard T1)
    [35115] = 'esoui/art/icons/ability_dragonknight_005_a.dds', -- Pull (Cyrodiil Honor Guard T1)
    [46991] = 'esoui/art/icons/ability_mage_011.dds', -- Fire Torrent Burning (Cryodiil Honor Guard T2)
    [46992] = 'LuiExtended/media/icons/abilities/ability_basic_r_shock_aoe.dds', -- Cripping Rage (Cyrodiil Honor Guard T2)
    [47001] = 'LuiExtended/media/icons/abilities/ability_basic_r_shock_aoe.dds', -- Cripping Rage (Cyrodiil Honor Guard T2)
    [47019] = 'esoui/art/icons/ability_dragonknight_005_a.dds', -- Puncturing Chains (Cyrodiil Honor Guard T2)
    [47023] = 'esoui/art/icons/ability_dragonknight_005_a.dds', -- Puncture (Cyrodiil Honor Guard T2)
    [47020] = 'esoui/art/icons/ability_dragonknight_005_a.dds', -- Pull (Cyrodiil Honor Guard T2)
    [15783] = 'esoui/art/icons/ability_warrior_022.dds', -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [15782] = 'esoui/art/icons/ability_warrior_022.dds', -- Triple Strike (Cyrodiil Honor Guard T1 + T2)

    -- Seasonal Quests
    [86075] = 'LuiExtended/media/icons/abilities/ability_event_bredas_magnificent_mead.dds', -- Breda's Magnificent Mead (Breda's Magnificent Mead)
    [83523] = 'LuiExtended/media/icons/abilities/ability_event_freezing.dds', -- Freezing (Snow Bear Plunge)
    [83522] = 'LuiExtended/media/icons/abilities/ability_event_warm.dds', -- Warm (Snow Bear Plunge)
    [84330] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Mudball (Mud Ball Merriment)
    [84378] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Mudball (Mud Ball Merriment)
    [84335] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Covered in Mud (Mud Ball Merriment)
    [85639] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Covered in Mud (Mud Ball Merriment)
    [85351] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Self-Serve Mudbath (Mud Ball Merriment) (Seems to be unusued - added just in case)
    [85352] = 'LuiExtended/media/icons/momentos/momento_event_mud_ball.dds', -- Covered in Mud (Mud Ball Merriment) (Seems to be unusued - added just in case)

    [91369] = 'LuiExtended/media/icons/abilities/ability_event_steamy_spring_pie.dds', -- Jester's Experience Boost Pie (The Pie of Misrule)

    ----------------------------------------------------------------
    -- WORLD EVENTS ------------------------------------------------
    ----------------------------------------------------------------

    -- Amkaos + Kathutet + Ranyu (Torturers)
    [77906] = 'esoui/art/icons/ability_debuff_knockback.dds', -- Stun (Ranyu)

    -- CRAGLORN (Delves + World Events)
    [82328] = 'esoui/art/icons/death_recap_shock_aoe.dds', -- Shock (Grandmother Thunder - Haddock's Market Delve Boss)

    ----------------------------------------------------------------
    -- MAIN QUEST --------------------------------------------------
    ----------------------------------------------------------------
    [64072] = 'esoui/art/icons/ability_debuff_reveal.dds', -- Eye of the Sentinel (CH Tutorial)
    [63685] = 'esoui/art/icons/ability_2handed_001.dds', -- Uppercut Stun (CH Tutorial - Dremora Caitiff)

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    [74104] = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', -- Grasping Vines (The Hidden Harvest)
    [74105] = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', -- Grasping Vines (The Hidden Harvest)
    [64316] = 'LuiExtended/media/icons/abilities/ability_frost_fortress.dds', -- Frost Fortress (For King and Glory - Urfon Ice-Heart)
    [64363] = 'esoui/art/icons/ability_wrothgar_bitingcold.dds', -- Savage Winds (For King and Glory - Urfon Ice-Heart)
    [66277] = 'LuiExtended/media/icons/equipment_disguise.dds', -- Vosh Rakh Recruit Disg (The Anger of a King)
    [66397] = 'esoui/art/icons/ability_healer_027.dds', -- Avalian's Speed (The Anger of a King)
    [66399] = 'esoui/art/icons/ability_warrior_012.dds', -- Usunok's Strength (The Anger of a King)
    [66415] = 'esoui/art/icons/ability_debuff_knockback.dds', -- Uppercut Stun (The Anger of a King)
    [53291] = 'esoui/art/icons/ability_destructionstaff_001a.dds', -- Uber Attack (The Anger of a King - Talviah Aliaria)
    [53302] = 'esoui/art/icons/ability_destructionstaff_008.dds', -- Icy Pulsar (The Anger of a King - Talviah Aliaria)
    [64430] = 'esoui/art/icons/ability_debuff_knockback.dds', -- Royal Bash (Blood on a King's Hands)

    [65835] = 'esoui/art/icons/ability_restorationstaff_002.dds', -- Restoring Waves (Forcing the Faith)
    [72154] = 'esoui/art/icons/ability_debuff_levitate.dds', -- Choke (Draugr Dilemma)

    -- PUBLIC DUNGEONS ORSINIUM
    [74762] = 'esoui/art/icons/ability_dragonknight_009.dds', -- Dragon Leap (Pyre Keeper Rugdrulz - Old Orsinium)
    [53829] = 'esoui/art/icons/ability_debuff_knockback.dds', -- Uppercut Stun (Batunalulr - Old Orsinium)
    [53940] = 'esoui/art/icons/ability_debuff_stun.dds', -- Pummel Stun (Batunalulr - Old Orsinium)

}

-- Force rename a buff
-- Note that if we rename a buff, we can't override the icon by name unless we use this string - NOT RECOMMENDED
E.EffectNameOverride = {
    ----------------------------------------------------------------
    -- POTIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Potions (2 Traits)
    [45237] = 'Invisibility', -- Vanish (... of Invisibility)
    [46113] = 'Ravage Health', -- of Ravage Health (Health Potion Poison)

    -- Crafted Potions (3 Traits)
    [45460] = 'Invisibility', -- Vanish (... of Invisibility)
    [46217] = 'Ravage Health', -- of Ravage Health (Health Potion Linger Effect)
    [46248] = 'Minor Breach', -- of Ravage Spell Protection (Reduce Spell Resistance)
    [47202] = 'Minor Enervation', -- of Ravage Weapon Critical (Reduce Weapon Critical)

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [78058] = 'Invisibility', -- Vanish (Roguish Stealth Draught)

    -- Crown Store Potions
    [68401] = 'Restore Health', -- Restore All Resources (Crown Tri-Restoration Potion)
    [68407] = 'Restore Magicka', -- Restore Magicka (Crown Tri-Restoration Potion)
    [68409] = 'Restore Stamina', -- Restore Stamina (Crown Tri-Restoration Potion)
    [86682] = 'Restore Magicka', -- Crown Spellcaster's Elixir (Crown Spellcaster's Elixir)
    [86696] = 'Restore Health', -- Crown Survivor's Elixir (Crown Survivor's Elixir)
    [86692] = 'Restore Stamina', -- Crown Warrior's Elixir (Crown Warrior's Elixir)

    ----------------------------------------------------------------
    -- POTION UP FRONT EFFECTS -------------------------------------
    ----------------------------------------------------------------

    [46215] = 'Ravage Health', -- Damage Health

    ----------------------------------------------------------------
    -- POISONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Poisons (2 Traits)
    --[79133] = 'Drain Health', -- Drain Health Poison (Drain Helath Poison)
    --[79134] = 'Restore Health', -- Restore Health (Drain Health Poison)
    --[79025] = 'Ravage Health', -- Ravage Health (Damage Health Poison)
    --[82667] = 'Ravage Health', -- Ravage Health (Damage Health Poison)
    --[79137] = 'Drain Magicka', -- Drain Magicka (Drain Magicka Poison)
    --[79138] = 'Restore Magicka', -- Restore Magicka (Drain Magicka Poison)
    --[79037] = 'Ravage Magicka', -- Ravage Magicka (Damage Magicka Poison)
    --[79141] = 'Drain Stamina', -- Drain Stamina (Drain Stamina Poison)
    --[79142] = 'Restore Stamina', -- Restore Stamina (Drain Stamina Poison)
    --[79045] = 'Ravage Stamina', -- Ravage Stamina (Damage Stamina Poison)
    [79284] = 'Minor Breach', -- Ward-Draining Poison (2 Traits)
    [79309] = 'Minor Fracture', -- Resolve-Draining Poison (2 Traits)
    [79280] = 'Minor Maim', -- Brutality-Draining Poison (2 Traits)
    [79996] = 'Stealth-Draining Poison', -- Revealing Poison (Stealth-Draining Poison) (2 Traits)
    [80003] = 'Conspicuous Poison', -- Marking Poison (Conspicuous Poison) (2 Traits)
    [79699] = 'Creeping Drain Health', -- Drain Health (Gradual Health Drain Poison)
    [81351] = 'Creeping Drain Health', -- Drain Health (Gradual Health Drain Poison)
    [79700] = 'Lingering Restore Health', -- Restore Health (Gradual Health Drain Poison)
    --[79707] = 'Creeping Ravage Health', -- Creeping Ravage Health (Gradual Ravage Health Poison)
    --[81346] = 'Creeping Ravage Health', -- Creeping Ravage Health (Gradual Ravage Health Poison)

    -- Crafted Poisons (3 Traits)
    --[79135] = 'Drain Health', -- Drain Health Poison (Drain Helath Poison)
    --[79136] = 'Restore Health', -- Restore Health (Drain Health Poison)
    --[78922] = 'Ravage Health', -- Ravage Health (Damage Health Poison)
    --[82668] = 'Ravage Health', -- Ravage Health (Damage Health Poison)
    --[79139] = 'Drain Magicka', -- Drain Magicka (Drain Magicka Poison)
    --[79140] = 'Restore Magicka', -- Restore Magicka (Drain Magicka Poison)
    --[79044] = 'Ravage Magicka', -- Ravage Magicka (Damage Magicka Poison)
    --[79143] = 'Drain Stamina', -- Drain Stamina (Drain Stamina Poison)
    --[79144] = 'Restore Stamina', -- Restore Stamina (Drain Stamina Poison)
    --[79046] = 'Ravage Stamina', -- Ravage Stamina (Damage Stamina Poison)
    [79306] = 'Minor Breach', -- Ward-Draining Poison (3 Traits)
    [79311] = 'Minor Fracture', -- Resolve-Draining Poison (3 Traits)
    [79278] = 'Minor Cowardice', -- Sorcery-Draining Poison (3 Traits)
    [79448] = 'Minor Uncertainty', -- Prophecy-Draining Poison (3 Traits)
    [80002] = 'Stealth-Draining Poison', -- Revealing Poison (Stealth-Draining Poison) (3 Traits)
    [80004] = 'Conspicuous Poison', -- Marking Poison (Conspicuous Poison) (3 Traits)
    --[79701] = 'Creeping Drain Health', -- Creeping Drain Health (Gradual Health Drain Poison)
    --[81348] = 'Creeping Drain Health', -- Creeping Drain Health (Gradual Health Drain Poison)
    --[79702] = 'Lingering Restore Health', -- Lingering Restore Health (Gradual Health Drain Poison)

    ----------------------------------------------------------------
    -- FOOD & DRINK ------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Food
    [61294] = 'Increase Max Magicka & Max Stamina', -- Magicka + Stamina Food
    [61255] = 'Increase Max Health & Max Stamina', -- Health + Stamina Food
    [61257] = 'Increase Max Health & Max Magicka', -- Health + Magicka Food

    [72819] = 'Increase Max Health & Stamina Recovery', -- Orzorga's Tripe Trifle Pocket
    [72822] = 'Increase Max Health & Health Recovery', -- Orzorga's Blood Price Pie
    [72824] = 'Increase Max Health & All Primary Stat Recovery', -- Orzorga's Smoked Bear Haunch

    -- Crafted Drink
    [61322] = 'Increase Health Recovery', -- Health Drink
    [61325] = 'Increase Magicka Recovery', -- Magicka Drink
    [61328] = 'Increase Stamina Recovery', -- Stamina Drink

    [61345] = 'Increase Magicka Recovery & Stamina Recovery', -- Magicka + Stamina Drink
    [61340] = 'Increase Health Recovery & Stamina Recovery', -- Health + Stamina Drink
    [61335] = 'Increase Health Recovery & Magicka Recovery', -- Health + Magicka Drink

    [61350] = 'Increase All Primary Stat Recovery', -- Triple Drink

    [72816] = 'Increase Max Health & Magicka Recovery', -- Orzorga's Red Frothgar

    -- Crafted Seasonal Food
    [84681] = 'Increase Max Magicka & Max Stamina', -- Crisp and Crunchy Pumpkin Snack Skewer
    [84709] = 'Increase Max Magicka & Stamina Recovery', -- Crunchy Spider Skewer
    [84725] = 'Increase Max Magicka & Health Recovery', -- Frosted Brains
    [86749] = 'Increase Max Magicka & Max Stamina', -- Jagga-Drenched "Mud Ball"
    [86673] = 'Increase Max Stamina & Stamina Recovery', -- Lava Foot Soup-and-Saltrice
    [86560] = 'Increase Max Magicka', -- Old Aldmeri Orphan Gruel
    [89955] = 'Increase Max Stamina & Magicka Recovery', -- Candied Jester's Coins

    -- Crafted Seasonal Drink
    [84700] = 'Increase Magicka Recovery & Health Recovery', -- Bowl of "Peeled Eyeballs"
    [84735] = 'Increase Max Health & Max Magicka', -- Double Bloody Mara
    [84720] = 'Increase Max Magicka & Magicka Recovery', -- Ghastly Eye Bowl
    [84704] = 'Increase All Primary Stat Recovery', -- Witchmother's Party Punch
    [84731] = 'Increase Max Health & Max Magicka & Magicka Recovery', -- Witchmother's Potent Brew
    [86677] = 'Increase Max Stamina & Health Recovery', -- Bergama Warning Fire
    [86746] = 'Increase Magicka Recovery & Health Recovery', -- Betnikh Twice-Spiked Ale
    [86559] = 'Increase Magicka Recovery & Stamina Recovery & Fish Eye', -- Hissmir Fish-Eye Rye
    [89957] = 'Increase Max Health & Max Stamina & Stamina Recovery', -- Dubious Camoran Throne
    [89971] = 'Increase Max Health & Magicka Recovery & Stamina Recovery', -- Jewels of Misrule

    -- Vendor Food & Drink
    [66586] = 'Increase Health Recovery', -- Vendor Health Drink
    [66590] = 'Increase Magicka Recovery', -- Vendor Magicka Drink
    [66594] = 'Increase Stamina Recovery', -- Vendor Stamina Drink

    -- AVA Food & Drink
    [72961] = 'Increase Max Magicka & Max Stamina', -- Cyrodilic Field Bar
    [72956] = 'Increase Max Health & Max Stamina', -- Cyrodilic Field Tack
    [72959] = 'Increase Max Health & Max Magicka', -- Cyrodilic Field Treat
    [72971] = 'Increase Magicka Recovery & Stamina Recovery', -- Cyrodilic Field Tonic
    [72965] = 'Increase Health Recovery & Stamina Recovery', -- Cyrodilic Field Brew
    [72968] = 'Increase Health Recovery & Magicka Recovery', -- Cyrodilic Field Tea

    -- Crown Food & Drink
    [85497] = 'Increase All Primary Stat Recovery', -- Crown Crate Refreshing Drink
    [68416] = 'Increase All Primary Stat Recovery', -- Crown Refreshing Drink

    -- Experience Bonuses
    [64210] = 'Psijic Ambrosia', -- Psijic Ambrosia
    [88445] = 'Mythic Aetherial Ambrosia', -- Mythic Aetherial Ambrosia
    [66776] = 'Crown Experience Scroll', -- Crown Experience Scroll
    [85501] = 'Crown Crate Experience Scroll', -- Crown Crate Experience Scroll
    [85502] = 'Major Crown Crate Experience Scroll', -- Major Crown Crate Experience Scroll
    [85503] = 'Grand Crown Crate Experience Scroll', -- Grand Crown Crate Experience Scroll

    -- Misc Consumables
    [86794] = 'High Hrothgar Festival Mints', -- Very Cold (High Hrothgar Festival Mints)
    [86740] = 'Sailor\'s Warning Festival Grog', -- Very Drunk (Sailor's Warning Festival Grog)

    -- Base Momentos
    [26829] = 'Almalexia\'s Enchanted Lantern', -- Light of the Tribunal (Almalexia's Enchanted Lantern)
    [43700] = 'Lena\'s Wand of Finding', -- Wand of Finding (Lena's Wand of Finding)

    -- DLC Momentos
    [77786] = 'Coin of Illusory Riches', -- Stun (Coin of Illusory Riches)
    [74232] = 'Malacath\'s Wrathful Flame', -- Stun (Malacath's Wrathful Flame)

    -- Seasonal Momentos
    [77123] = '2nd Annual Jubilee Cake', -- 2017 Anniversary EXP Buff (2nd Annual Jubilee Cake)
    [86774] = 'Mud Ball', -- Mudball (Mud Ball Pouch)
    [86777] = 'Mud Ball', -- Mudball (Mud Ball Pouch)
    [86775] = 'Mud Ball', -- Covered in Mud (Mud Ball Pouch)
    [86779] = 'Mud Ball', -- Covered in Mud (Mud Ball Pouch)

    -- Crown Store Momentos
    [85344] = 'Storm Atronach Aura', -- Atronach Aura (Storm Atronach Aura)
    [86976] = 'Wild Hunt Leaf-Dance Aura', -- Spriggan Aura (Wild Hunt Leaf-Dance Aura)
    [86978] = 'Floral Swirl Aura', -- Grand Spriggan Aura (Floral Swirl Aura)

    -- Assistants
    [77645] = 'Hidden', -- Stealth (Pirharri the Smuggler)

    ----------------------------------------------------------------
    -- ENCHANTS ----------------------------------------------------
    ----------------------------------------------------------------

    [28919] = 'Absorb Health', -- Life Drain (Glyph of Absorb Health)
    [28921] = 'Absorb Health', -- Life Drain (Glyph of Absorb Health)
    --[46743] = 'Absorb Magicka', -- Absorb Magicka (Glyph of Absorb Magicka)
    --[46744] = 'Absorb Magicka', -- Absorb Magicka (Glyph of Absorb Magicka)
    --[46746] = 'Absorb Stamina', -- Absorb Stamina (Glyph of Absorb Stamina)
    --[46747] = 'Absorb Stamina', -- Absorb Stamina (Glyph of Absorb Stamina)
    [17906] = 'Crushing Enchantment', -- Crusher (Glyph of Crushing)
    [46749] = 'Decrease Health', -- Damage Health (Glyph of Decrease Health)
    --[17895] = 'Fiery Weapon', -- Fiery Weapon (Glyph of Flame)
    --[17904] = 'Befouled Weapon', -- Befouled Weapon (Glyph of Foulness)
    --[17897] = 'Frozen Weapon', -- Frozen Weapon (Glyph of Frost)
    --[17947] = 'Hardening Enchantment', -- Hardening (Glyph of Hardening) (DUMMY EVENT, HERE JUST IN CASE)
    [21578] = 'Hardening Enchantment', -- Hardening (Glyph of Hardening)
    --[17902] = 'Poisoned Weapon', -- Poisoned Weapon (Glyph of Poison)
    --[40337] = 'Prismatic Weapon', -- Primatic Weapon (Glyph of Prismatic Onslaught)
    --[17899] = 'Charged Weapon', -- Charged Weapon (Glyph of Shock)
    [17945] = 'Weakening Enchantment', -- Weakening (Glyph of Weakening)
    --[17910] = 'Weapon Damage Enchantment', -- Weapon Damage (Glyph of Weapon Damage) (DUMMY EVENT, HERE JUST IN CASE)
    --[21230] = 'Weapon Damage Enchantment', -- Berserker (Glyph of Weapon Damage) (Added in case ever needed)
    
    ----------------------------------------------------------------
    -- EQUIPMENT ---------------------------------------------------
    ----------------------------------------------------------------
    
    [82631] = 'Monk\'s Disguise', -- Monk Disguise Timer (Monk's Disguise)

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    -- Player Basic
    [20301] = 'Crouch', -- Crouch Drain
    [26245] = 'Crouch Stun', -- Slam Stun (Stun from crouch attack)
    [15356] = 'Sprint', -- Sprint Drain
    [10950] = 'Fall Damage', -- Fall Snare
    --[33439] = 'Gallop', -- Mount Sprint (Generic) (Resevered here if it ever becomes visible)
    [16270] = 'Block', -- Brace Cost
    [88724] = 'Block', -- Brace Cost
    [86310] = 'Block Stun', -- Stagger (Player blocks NPC charged attack)
    [86309] = 'Block Stun', -- Stun (Player blocks NPC charged attack)
    [86312] = 'Block Stun', -- Stun (Player blocks Ogrim Body Slam)

    ----------------------------------------------------------------
    -- DRAGONKNIGHT PASSIVES ---------------------------------------
    ----------------------------------------------------------------
    
    ----------------------------------------------------------------
    -- DRAGONKNIGHT ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------
    
    -- Lava Whip
    [23808] = 'Off-Balance', -- Off Balance (Lava Whip - Rank 1)
    [20804] = 'Off-Balance', -- Off Balance (Lava Whip - Rank 2)
    [23810] = 'Off-Balance', -- Off Balance (Lava Whip - Rank 3)
    [23812] = 'Off-Balance', -- Off Balance (Lava Whip - Rank 4)
    
    -- Spiked Armor
    [20320] = 'Spiked Armor', -- Spiked Armor Damage Return (Spiked Armor - Rank 1)
    [23823] = 'Spiked Armor', -- Spiked Armor Damage Return (Spiked Armor - Rank 2)
    [23826] = 'Spiked Armor', -- Spiked Armor Damage Return (Spiked Armor - Rank 3)
    [23829] = 'Spiked Armor', -- Spiked Armor Damage Return (Spiked Armor - Rank 4)
    
    [29230] = 'Major Defile', -- Major Deflie (Dragonknight Standard - Rank 1)

    ----------------------------------------------------------------
    -- SORCERER PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    -- Daedric Summoning
    [64860] = 'Rebate', -- Rebate Magic (Rebate - Rank 1)
    [64861] = 'Rebate', -- Rebate Magic (Rebate - Rank 2)

    ----------------------------------------------------------------
    -- NIGHTBLADE PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    -- Siphoning
    [63705] = 'Catalyst', -- Amphibious Regen (Catalyst - Rank 1)
    [63707] = 'Catalyst', -- Amphibious Regen (Catalyst - Rank 2)

    ----------------------------------------------------------------
    -- TEMPLAR PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Restoring Light
    [52703] = 'Light Weaver', -- Light Weaver Ultimate (Light Weaver - Rank 1 & 2)

    ----------------------------------------------------------------
    -- PLAYER WEAPON ATTACKS ---------------------------------------
    ----------------------------------------------------------------

    --[23604] = 'Light Attack (Unarmed)', -- Light Attack
    [18430] = 'Medium Attack', -- Heavy Attack
    --[18431] = 'Heavy Attack (Unarmed)', -- Heavy Attack
    [60772] = 'Heavy Attack', -- Heavy Attack (Unarmed)

    --[16037] = 'Light Attack', -- Light Attack
    [17162] = 'Medium Attack', -- Heavy Attack
    --[17163] = 'Heavy Attack', -- Heavy Attack
    [60757] = 'Heavy Attack', -- Heavy Attack (2H)

    --[15435] = 'Light Attack', -- Light Attack
    [15282] = 'Medium Attack', -- Heavy Attack
    --[15829] = 'Heavy Attack', -- Heavy Attack
    [60759] = 'Heavy Attack', -- Heavy Attack (Shield)

    --[16499] = 'Light Attack', -- Light Attack
    [17170] = 'Medium Attack', -- Heavy Attack
    [17169] = 'Heavy Attack (Main Hand)', -- Heavy Attack
    [18622] = 'Heavy Attack (Off Hand)', -- Heavy Attack (Dual Wield)
    [60758] = 'Heavy Attack', -- Heavy Attack (Dual Wield)

    --[16688] = 'Light Attack', -- Light Attack
    [17174] = 'Medium Attack', -- Heavy Attack
    --[17173] = 'Heavy Attack', -- Heavy Attack
    [60761] = 'Heavy Attack', -- Heavy Attack (Bow)

    --[16277] = 'Light Attack', -- Light Attack
    [18405] = 'Medium Attack', -- Heavy Attack
    --[18406] = 'Heavy Attack', -- Heavy Attack
    [60762] = 'Heavy Attack', -- Heavy Attack (Frost)

    --[16165] = 'Light Attack', -- Light Attack
    [15385] = 'Medium Attack', -- Heavy Attack
    --[16321] = 'Heavy Attack', -- Heavy Attack
    [60763] = 'Heavy Attack', -- Heavy Attack (Fire)

    --[18350] = 'Light Attack', -- Light Attack
    --[18396] = 'Heavy Attack (Shock)', -- Heavy Attack (Shock)
    [19277] = 'Heavy Attack (Shock Pulse)', -- Shock Pulse
    [60764] = 'Heavy Attack (Shock Pulse)', -- Heavy Attack (Shock)

    --[16145] = 'Light Attack', -- Light Attack
    --[16212] = 'Heavy Attack', -- Heavy Attack
    [32760] = 'Heavy Attack', -- Heavy Attack (Restoration)
    --[28469] = 'Heavy Attack', -- Heavy Attack
    --[38591] = 'Heavy Attack', -- Heavy Attack

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WEAPONS -------------------------------------
    ----------------------------------------------------------------

    -- Two Handed
    [29383] = 'Heavy Weapons', -- Heavy Weapons Bleed (Rank 1)
    [45431] = 'Heavy Weapons', -- Heavy Weapons Bleed (Rank 2)
    [60860] = 'Follow Up', -- Bonus Damage (Follow Up - Rank 1)
    [60888] = 'Follow Up', -- Bonus Damage (Follow Up - Rank 2)

    -- Dual Wield
    [30894] = 'Twin Blade and Blunt', -- Twin Blade and Blunt Bleed (Rank 1)
    [45483] = 'Twin Blade and Blunt', -- Twin Blade and Blunt Bleed (Rank 2)

    -- Destruction Staff
    [30951] = 'Tri Focus (Shock)', -- Shock (Tri Focus - Rank 1)
    [45505] = 'Tri Focus (Shock)', -- Shock (Tri Focus - Rank 2)
    [30966] = 'Destruction Expert', -- Magicka Restore (Destruction Expert - Rank 1)
    [45515] = 'Destruction Expert', -- Magicka Restore (Destruction Expert - Rank 2)
    
    ----------------------------------------------------------------
    -- PLAYER ACTIVES WEAPONS --------------------------------------
    ----------------------------------------------------------------

    [62928] = 'Wall of Frost', -- Wall of Frost Snare (Wall of Elements - Rank 1) -- Frost
    [62933] = 'Wall of Frost', -- Unstable Wall of Frost (Wall of Elements - Rank 2) -- Frost
    [62938] = 'Wall of Frost', -- Unstable Wall of Frost (Wall of Elements - Rank 3) -- Frost
    [62943] = 'Wall of Frost', -- Unstable Wall of Frost (Wall of Elements - Rank 4) -- Frost
    
    [62968] = 'Off-Balance', -- Wall of Storms (Wall of Elements - Rank 1) -- Lightning
    [62973] = 'Off-Balance', -- Wall of Storms (Wall of Elements - Rank 2) -- Lightning
    [62978] = 'Off-Balance', -- Wall of Storms (Wall of Elements - Rank 2) -- Lightning
    [62983] = 'Off-Balance', -- Wall of Storms (Wall of Elements - Rank 2) -- Lightning

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WORLD ----------------------------------------
    ----------------------------------------------------------------

    -- Vampire
    [33182] = 'Savage Feeding', -- Uber Attack (Savage Feeding - Rank 1)
    [33183] = 'Off-Balance', -- Off-Balance Self (Savage Feeding - Rank 2)
    [46047] = 'Savage Feeding', -- Uber Attack (Savage Feeding - Rank 1)
    [46046] = 'Off-Balance', -- Off-Balance Self (Savage Feeding - Rank 2)

    [40349] = 'Blood Ritual', -- Feed (Blood Ritual - Rank 1)
    [40351] = 'Blood Ritual', -- Feed (Blood Ritual - Rank 1)
    [40353] = 'Blood Ritual', -- Uber Attack (Blood Ritual - Rank 1)
    [40360] = 'Noxiphilic Sanguivoria', -- Vampirism (Blood Ritual - Rank 1)

    -- Werewolf
    --[32464] = 'Light Attack', -- Light Attack
    [89146] = 'Light Attack Bleed', -- Werewolf Bleed
    [32479] = 'Medium Attack', -- Heavy Attack
    [32480] = 'Heavy Attack', -- Heavy Attack Werewolf
    --[32494] = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', -- Heavy Attack
    [60773] = 'Heavy Attack', -- Stamina Return

    ----------------------------------------------------------------
    -- PLAYER PASSIVES GUILDS --------------------------------------
    ----------------------------------------------------------------

    -- Undaunted
    --[55606] = 'Undaunted Command', -- Undaunted Command (Undaunted Command - Rank 1)
    [55607] = 'Undaunted Command', -- Undaunted Command Magicka Rest (Undaunted Command - Rank 1)
    [55608] = 'Undaunted Command', -- Undaunted Command Stamina Rest (Undaunted Command - Rank 1)
    --[55677] = 'Undaunted Command', -- Undaunted Command (Undaunted Command - Rank 2)
    [55678] = 'Undaunted Command', -- Undaunted Command Stamina Rest (Undaunted Command - Rank 2)
    [55679] = 'Undaunted Command', -- Undaunted Command Magicka Rest (Undaunted Command - Rank 2)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES RACIALS -------------------------------------
    ----------------------------------------------------------------

    [36214] = 'Red Diamond', -- Star of the West (Red Diamond - Rank 1)
    [45292] = 'Red Diamond', -- Star of the West (Red Diamond - Rank 2)
    [45294] = 'Red Diamond', -- Star of the West (Red Diamond - Rank 3)

    -- TRAPS
    [21941] = 'Spike Trap', -- Spike Trap Snare (Spike Trap)
    [21942] = 'Spike Trap', -- Trap Sprung (Spike Trap)
    [65854] = 'Spike Trap', -- Spike Trap Snare (Spike Trap) (Orsinium - To Save a Chief)
    [65855] = 'Spike Trap', -- Trap Sprung (Spike Trap) (Orsinium - To Save a Chief)
    [20259] = 'Sigil of Frost', -- Sigil of Frost Snare (Sigil of Frost - Wrothgar - Coldwind's Den)

    ----------------------------------------------------------------
    -- NPC (BASIC) -------------------------------------------------
    ----------------------------------------------------------------

    -- SHARED NPC PASSIVES
    [33097] = 'CC Immunity', -- Scary Immunities
    [44176] = 'Flying Immunity', -- Flying Immunities
    --[13739] = 'Deal Extra Damage from Behind', -- Backstabber

    -- SHARED NPC ACTIVE EVENTS
    [8239] = 'Hamstring', -- Hamstrung

    -- HUMAN NPC ABILITIES
    [14925] = 'Focused Charge', -- Charge (Brute)
    [14926] = 'Focused Charge', -- Charge (Brute)
    [89017] = 'Summon Shade', -- Dark Shade (Dreadweaver)

    -- Standard NPC ABILITIES
    [2874] = 'Stagger', -- Staggered (Generic Stagger applied to player by many different NPC abilities)
    [29402] = 'Power Bash', -- Power Bash (Stagger when hit with Power Bash)
    [68971] = 'Stagger', -- Staggered (Echatere - Shockwave)
    [12426] = 'Stagger', -- Raven Storm (Hagraven)
    [32698] = 'Stagger', -- Staggered (Lurcher - Pulverize)
    [5349] = 'Stagger', -- Staggered (Ogre - Shockwave)
    [76134] = 'Stagger', -- Stumble Forward (Flesh Colossus)
    [76133] = 'Stagger', -- Stumble Forward (Flesh Colossus - Blocked)
    [65755] = 'Stagger', -- Staggered (Flesh Colossus - Block Pin)
    [68826] = 'Stagger', -- Staggered (Flesh Colossus - Block Sweep)
    [74794] = 'Stagger', -- Black Winter (Harvester)
    [32023] = 'Stagger', -- Generic Stagger Enemy (Bloodfiend)
    [17206] = 'Stagger', -- Bone Saw(Bone Colossus)
    [45576] = 'Stagger', -- Generic Stagger Enemy (Werewolf)
    [69157] = 'Retaliation', -- Retaliation (Winterborn Warrior)
    [29765] = 'Block Stun', -- Uber Attack (0 sec stagger on player when they hit a bracing NPC with heavy attack)
    [84346] = 'Block Stun', -- Uber Attack (3 sec stun on player when they hit a bracing NPC with heavy attack)
    [13377] = 'Risen Dead', -- Reanimate Skeleton (Necromancer)
    [5614] = 'Risen Dead', -- Voice to Wake the Dead (Necromancer)
    [35391] = 'Bone Cage', -- Defiled Grave (Gravesinger)
    [44259] = 'Radiant Magelight', -- Magelight (Elite Mage NPCs - Debuff when revealed)
    [34647] = 'Off-Balance', -- Lava Whip (Dragonknight) (Applied when hit by Lava Whip while CC'ed, Off-Balance)
    [67593] = 'Divine Leap', -- Divine Leap Stagger (Vosh Rakh Devoted)
    [54050] = 'Divine Leap', -- Divine Leap Stun (Vosh Rakh Devoted)
    [51923] = 'Cleave', -- Cleave Stance (Dremora Caitiff)
    [51940] = 'Cleave', -- Cleave Stance (Dremora Caitiff)
    [51942] = 'Cleave', -- Cleave Stance (Dremora Caitiff)
    [74621] = 'Flare Trap', -- Revealed (Archer) (TG DLC)
    [77927] = 'Stagger', -- Staggered (Bodyguard) (DB DLC)

    -- ANIMALS
    [56984] = 'Lacerate', -- Laceration (Alit)
    [56983] = 'Lacerate', -- Laceration (Alit)
    [4413] = 'Bite', -- Swipe (Bear)
    [61594] = 'Savage Blows', -- Savage Blows Bleeding (Bear)
    [69073] = 'Slam', -- Knockdown (Bear)
    [8604] = 'Vigorous Swipes', -- Vigorous Swipe (Mammoth)
    [44781] = 'Bite', -- Swipe (Welwa)

    -- DAEDRA
    [51265] = 'Empower: Flame', -- Air Atronach Flame (Air Atronach - Flame)
    [51270] = 'Empower: Storm', -- Air Atronach Flame (Air Atronach - Storm)
    [51267] = 'Empower: Frost', -- Air Atronach Flame (Air Atronach - Frost)
    [50026] = 'Lightning Pulse', -- Lightning Rod (Air Atronach)
    [20226] = 'Unyielding Mace', -- Stun (Flesh Atronach)
    [23077] = 'Unyielding Mace', -- Stun (Flesh Atronach)
    [49820] = 'Pin', -- Stunned (Flesh Colossus)
    [68813] = 'Sweep', -- Sweep Knockback (Flesh Colossus)
    [43817] = 'Shockwave', -- Shockwave Snare (Watcher)

    -- DWEMER
    [64508] = 'Turret', -- Find Turret (Dwemer Sentry)

    -- INSECTS
    [6137] = 'Lacerate', -- Laceration (Assassin Beetle)
    [51736] = 'Lacerate', -- Bleeding (Assassin Beetle)
    [51735] = 'Lacerate', -- Bleeding (Assassin Beetle)
    [12312] = 'Paralyze', -- Snare (Giant Scorpion - applied by Paralyze attack)
    [47318] = 'Web', -- Encase (Giant Spider)
    [9237] = 'Inject Larva', -- Larva Gestation (Giant Wasp)
    [69392] = 'Vile Bite', -- Vile Bite Poison (Hoarvor DLC)
    [61388] = 'Necrotic Explosion', -- Necrotic Explosion Snare (Hoarvor DLC)
    [8272] = 'Contagion', -- Spit (Kwama Scrib)
    [26379] = 'Zap Pulse', -- Zap (Thunderbug)

    -- MONSTERS
    [25716] = 'Lacerate', -- Stun (Gargoyle)
    [38554] = 'Crushing Limbs', -- Stun (Lurcher)
    [6150] = 'Shockwave', -- Ogre (Off Balance)
    [34385] = 'Ice Pillar Chill', -- Ogre Mage (Generic AOE)

    -- UNDEAD
    [38834] = 'Desecrated Ground', -- Desecrated Ground Snare
    [73926] = 'Soul Rupture', -- Soul Cage (Lich)
    [73934] = 'Soul Rupture', -- Soul Cage (Lich)

    -- CYRODIIL
    [46832] = 'Bleeding Strike', -- Bleeding (Cyrodiil Guard T2)
    [46831] = 'Bleeding Strike', -- Bleeding (Cyrodiil Guard T2)
    [36304] = 'Spiked Armor', -- Razor Armor (Cyrodiil Guard T2)
    [36305] = 'Spiked Armor', -- Spike Armor Damage Return (Cyrodiil Guard T2)
    [7880] = 'Shock Torrent', -- Light Attack (Cyrodiil Mage T1)
    --[21629] = 'Mage\'s Lifesteal', -- Mage's Lifesteal (Cyrodiil Mage T1)
    [21632] = 'Mage\'s Lifesteal', -- Lifesteal (Cyrodiil Mage T1)
    [21631] = 'Mage\'s Lifesteal', -- Lifesteal (Cyrodiil Mage T1)
    [46336] = 'Crystal Shard', -- Crystal Shard Stun (Cyrodiil Mage T1)
    [46726] = 'Improved Shock Torrent', -- Shock Torrent (Cyrodiil Mage T2)
    [46730] = 'Improved Shock Torrent', -- Shock Torrent (Cyrodiil Mage T2)
    [46819] = 'Lasting Storm', -- Storm Damage (Cyrodiil Mage T2)
    [46716] = 'Steal Essence', -- Stolen Essence (Cyrodiil Mage T2)
    [46718] = 'Steal Essence', -- Lifesteal (Cyrodiil Mage T2)
    [46717] = 'Steal Essence', -- Lifesteal (Cyrodiil Mage T2)
    [46706] = 'Crystal Blast', -- Crystal Shard Stun (Cyrodiil Mage T2)
    [21638] = 'Telekinetic Prison', -- Telekinetic Disorient (Cyrodiil Mender T1)
    [46906] = 'Shattering Prison', -- Telekinetic Disorient (Cyrodiil Mender T2)
    [54258] = 'Improved Volley', -- Upgraded Volley (Cyrodiil Archer T2)
    [16510] = 'Fire Torrent', -- Fire Salvo (Cyrodiil Honor Guard T1)
    [35115] = 'Extended Chains', -- Pull (Cyrodiil Honor Guard T1)
    [46991] = 'Improved Fire Torrent', -- Fire Torrent Burning (Cyrodiil Honor Guard T2)
    [47020] = 'Extended Chains', -- Pull (Cyrodiil Honor Guard T2)
    [47023] = 'Puncturing Chains', -- Puncture (Cyrodiil Honor Guard T2)

    -- Seasonal Quests
    [84330] = 'Mud Ball', -- Mudball (Mud Ball Merriment)
    [84378] = 'Mud Ball', -- Mudball (Mud Ball Merriment)
    [84335] = 'Mud Ball', -- Covered in Mud (Mud Ball Merriment)
    [85639] = 'Mud Ball', -- Covered in Mud (Mud Ball Merriment)
    [85351] = 'Mud Ball', -- Self-Serve Mudbath (Mud Ball Merriment) (Seems to be unusued - added just in case)
    [85352] = 'Mud Ball', -- Covered in Mud (Mud Ball Merriment) (Seems to be unusued - added just in case)
    
    [91369] = 'The Pie of Misrule', -- Jester's Experience Boost Pie (The Pie of Misrule)
    
    ----------------------------------------------------------------
    -- WORLD EVENTS ------------------------------------------------
    ----------------------------------------------------------------

    -- Amkaos + Kathutet + Ranyu (Torturers)
    [77906] = 'Shock Aura', -- Stun (Ranyu)

    ----------------------------------------------------------------
    -- MAIN QUEST --------------------------------------------------
    ----------------------------------------------------------------

    [63685] = 'Uppercut', -- Uppercut Stun (CH Tutorial - Dremora Caitiff)

    ----------------------------------------------------------------
    -- ORSINIUM ----------------------------------------------------
    ----------------------------------------------------------------

    [64734] = 'Harpy Swoop', -- Q5318 - Harpy Swoop In (The Hidden Harvest)
    [66277] = 'Vosh Rakh Illusion', -- Vosh Rakh Recruit Disg (The Anger of a King)
    [66415] = 'Gust', -- Uppercut Stun (The Anger of a King)
    [53291] = 'Crushing Shock', -- Uber Attack (The Anger of a King - Talviah Aliaria)
    [53302] = 'Minor Mangle', -- Icy Pulsar (The Anger of a King - Talviah Aliaria)
    [53829] = 'Lifting Strike', -- Uppercut Stun (Batunalulr - Old Orsinium)
    [53940] = 'Pummel', -- Pummel Stun (Batunalulr - Old Orsinium)
}

E.EffectForcedType = { --Force a change to the type buff container
    [14890] = "short", -- Block
    [23284] = "short", -- Not sure, I believe this is Guard projectile intercept.
    [64197] = "short", -- Sanctuary Cyrodiil passive is considered unlimited duration, but the effect is only while the player is in the area. Should show up under short buffs.
    [54119] = "short", -- Remembrance (The Anger of a King)
    [83522] = "short", -- Freezing (Snow Bear Plunge)
    [85344] = 'short', -- Atronach Aura (Storm Atronach Aura)
}

E.EffectForcedName = {
    -- Nothing here yet
}

E.IsAbilityIgnoredById = { --Remove an ability from display by abilityId
    -- Poisons
    [79025] = true, -- Ravage Health (Drain Health Poison) - Container
    [79699] = true, -- Drain Health (Gradual Health Drain Poison) - Container
    [79707] = true, -- Creeping Ravage Health (Gradual Ravage Health Poison) - Container
    [78922] = true, -- Ravage Health (Damage Health Poison) - Container
    [79701] = true, -- Creeping Drain Health (Gradual Health Drain Poison) - Container
    [81551] = true, -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison)- Container

    -- Food
    [84732] = true, -- Increase Health Regen (Witchmother's Potent Brew) - Odd event applied on zone transition with Witchmother's Potent Brew up
    [84733] = true,  -- Increase Health Regen (Witchmother's Potent Brew) - Odd event applied on zone transition with Witchmother's Potent Brew up
    [89958] = true, -- Increase Stamina (Dubious Camoran Throne) - Odd event applied on zone transition with Dubious Camoran Throne up
    [89959] = true, -- Increase Health (Dubious Camoran Throne) - Odd event applied on zone transition with Dubious Camoran Throne up
    -- Other
    [70582] = true, -- Roll 1d1000 (Merethic Restorative Resin)

    -- Momento's
    [81575] = true, -- Event - WitchFest Cauldron (Witchmother's Whistle)
    [16846] = true, -- Blackfeather Court Whistle (Blackfeather Court Whistle)
    [25703] = true, -- Justal's Falcon (Justal's Falcon)
    [43702] = true, -- Invis Chicken Delay (Lena's Wind of Finding)
    [43703] = true, -- Extracting... (Lena's Wind of Finding)
    [43704] = true, -- Extracting... (Lena's Wind of Finding)
    [43701] = true, -- Extracting... (Lena's Wind of Finding)
    [77785] = true, -- Rain of Coins (Coin of Illusory Riches)
    [73685] = true, -- Rkindaleft Trophy (Hidden Pressure Vent)
    [77027] = true, -- Anniversary Cake - Forreals (Jubilee Cake)
    [87998] = true, -- Anniversary Cake (2nd Annual Jubilee Cake)
    [86779] = true, -- Covered in Mud (Mud Ball Pouch)
    [87963] = true, -- Bestowed Cherry Blossoms (Cherry Blossom Branch)

    -- Status Effect Procs
    [21925] = true, -- Diseased (Disease Status Effect)

    -- Stuff
    [73333] = true, -- Crushing Wall Trigger
    [73874] = true, -- Crushing Wall Debuff
    [62175] = true, -- Major Resolve | Boundless storm 1
    [62176] = true, -- Major Ward | Boundless storm 1
    [62179] = true, -- Major Resolve | Boundless storm 2 ?
    [62180] = true, -- Major Ward | Boundless storm 2 ?
    [62184] = true, -- Major Resolve | Boundless storm 3 ?
    [62185] = true, -- Major Ward | Boundless storm 3 ?
    [62189] = true, -- Major Resolve | Boundless storm 4
    [62190] = true, -- Major Ward | Boundless storm 4
    [61846] = true, -- Major Resolve | Volatile Armor 4
    [61845] = true, -- Major Ward | Volatile Armor 4
    [62643] = true, -- Minor Resolve | Combat Prayer 4
    [62644] = true, -- Minor Ward | Combat Prayer 4
    [63119] = true, -- Major Resolve | Unstoppable 1
    [63120] = true, -- Major Ward | Unstoppable 1
    [63123] = true, -- Major Resolve | Unstoppable 2
    [63124] = true, -- Major Ward | Unstoppable 2
    [63127] = true, -- Major Resolve | Unstoppable 3
    [63128] = true, -- Major Ward | Unstoppable 3
    [63131] = true, -- Major Resolve | Unstoppable 4
    [63132] = true, -- Major Ward | Unstoppable 4

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    -- Off-Balance Exploit
    [18793] = true, -- Off-Balance Exploit

    -- Resurrection
    [55400] = true, -- Magicka Restore
    [55401] = true, -- Magicka Restore

    -- Sorcerer (Passives)
    [31415] = true, -- Expert Summoner (Expert Summoner - Rank 1)
    [46198] = true, -- Expert Summoner (Expert Summoner - Rank 2)

    -- Destruction Staff (Passives)
    [19277] = true, -- Shock Pulse (Lightning Staff)
    [30966] = true, -- Magicka Restore (Destruction Expert - Rank 1)
    [45515] = true, -- Magicka Restore (Destruction Expert - Rank 1)

    -- Soul Magic (Passives)
    [39268] = true, -- Soul Shatter (Soul Shatter - Rank 1)
    [45585] = true, -- Soul Shatter (Soul Shatter - Rank 2)
    [43752] = true, -- Soul Summons (Soul Summons - Rank 1)
    [39264] = true, -- Soul Trap (Soul Lock - Rank 1)
    [45582] = true, -- Soul Trap (Soul Lock - Rank 2)

    -- Vampire (Passives)
    [40359] = true, -- Fed on ally (Blood Ritual - Rank 1)

    -- Werewolf (Passives)
    [33208] = true, -- Devour (Devour - Rank 1)

    -- Racials
    [36548] = true, -- Adrenaline Rush (Adrenaline Rush - Rank 1)
    [45314] = true, -- Adrenaline Rush (Adrenaline Rush - Rank 2)
    [45316] = true, -- Adrenaline Rush (Adrenaline Rush - Rank 3)

    [36214] = true, -- Star of the West (Red Diamond - Rank 1)
    [45292] = true, -- Star of the West (Red Diamond - Rank 2)
    [45294] = true, -- Star of the West (Red Diamond - Rank 3)

    -- Traps
    [21943] = true, -- Spike Trap (Spike Trap) (Damage Component)
    [73103] = true, -- Lava (Orsinium - The Hand of Morkul) (Lava)
    [65856] = true, -- Spike Trap (Spike Trap) (Orsinium - To Save a Chief)

    -- BASIC NPC ABILITIES
    [67950] = true, -- CC Immunity Plus
    [88283] = true, -- No Call Ally (is Ally)
    [88289] = true, -- No Call Ally (Failed)
    [89175] = true, -- No Call Ally 1:1 Ally Tracker

    -- Shared NPC Misc
    [57832] = true, -- CC Immunity Knock Back

    -- Criter Events
    [79544] = true, -- Mischievous Dodge (Nixad)

    -- Human NPC's
    [86310] = true, -- Stagger (0 sec duration effect when player block NPC charged/heavy attack - Hiding to add fake aura)
    [12437] = true, -- Quick Shot
    [12456] = true, -- Ice Arrow
    [31813] = true, -- Run Away! (NPC runs away from player - Shows as buff on NPC)
    [18386] = true, -- Run Away! (Used by various creatures)
    [28301] = true, -- Ability CC Immunity (Trigger to apply 38117 on player)
    [28499] = true, -- Throw Dagger (Pointless projectile travel time aura)
    [29402] = true, -- Power Bash (0 sec stagger when hit - Hiding to add fake aura)
    [29762] = true, -- Blocked Stack (0 sec duration effect when player Heavy Attack connects with bracing NPC - Shows as passive for some reason)
    [29765] = true, -- Uber Attack (0 duration stagger when player hits Bracing NPC - Hiding to add fake aura)
    [35164] = true, -- Agony (Pointless projectile travel time aura)
    [74978] = true, -- Taking Aim (Archer) (Pointless debuff for projectile travel time)
    [43757] = true, -- Cultist Synergy Cast (Applied on summoned ghost, no point in displaying)
    [14524] = true, -- Shock (Pointless projectile travel time aura)
    [89057] = true, -- Burdening Eye (Spirit Mage)
    [89042] = true, -- Burdening Eye (Spirit Mage)
    [14477] = true, -- Burdening (Spirit Mage)
    [73768] = true, -- GEN 5 Hits (Pointless to display)
    [29372] = true, -- Necrotic Spear (Necromancer)
    [7590] = true, -- Entropic Bolt (Bonelord)
    [29669] = true, -- Coiled Lash (Pointless projectile travel time aura)
    [29520] = true, -- Aura of Protection (Redundant)
    [65314] = true, -- Aura of Protection (Redundant)
    [65432] = true, -- Aura of Protection (Redundant)
    [89460] = true, -- Set Area (Pet Ranger)
    [16588] = true, -- Heat Wave (Fire Mage) (Pointless debuff for damage that ignores dodge roll)
    [56828] = true, -- Fright Force (Pointless projectile travel time aura)
    [14350] = true, -- Aspect of Terror (Pointless projectile travel time aura)
    [73712] = true, -- Shadow Cloak (Nightblade NPC) (Pointless .5 second aura applied on player)
    [79803] = true, -- Covetous Return (Healer) (Passive on healer that doesn't seem to do anything)
    [10601] = true, -- Minor Wound (Healer) (Pointless projectile travel time aura)
    [50931] = true, -- Healer Immune (Healer)
    [65033] = true, -- Retaliation (Winterborn Warrior)
    [69157] = true, -- Retaliation (Winterborn Warrior)
    [14883] = true, -- Off-Balance (Winterborn Warrior)
    [64980] = true, -- Javelin (Winterborn Warrior)
    [64711] = true, -- Flames (Winterborn Mage)
    [54184] = true, -- Revenge 2 (Vosh Rakh Devoted)
    [67593] = true, -- Divine Leap Stagger (Vosh Rakh Devoted)
    [54050] = true, -- Divine Leap Stun (Vosh Rakh Devoted)
    [72723] = true, -- Fool Me Once (Sentinel) (TG DLC)
    [74480] = true, -- Fiery Grip (Sentinel) (TG DLC)
    [74630] = true, -- Flare Trap Proxy (Archer) (TG DLC)
    [76089] = true, -- Snipe (Archer) (TG DLC)
    [72220] = true, -- Snipe (Archer) (TG DLC)
    [74619] = true, -- Flare Trap (Archer) (TG DLC)
    [77474] = true, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77477] = true, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77489] = true, -- Dutiful Fury (Bodyguard) (DB DLC)
    [79534] = true, -- Shard Shield (Bodyguard) (DB DLC)
    [83624] = true, -- Shard Shield (Bodyguard) (DB DLC)
    [77562] = true, -- Shard Shield (Bodyguard) (DB DLC)
    [77927] = true, -- Staggered (Bodyguard) (DB DLC)
    [77602] = true, -- Shard Shield (Bodyguard) (DB DLC)

    -- ANIMALS
    [18198] = true, -- Toss (Kagouti) (Redundant Aura)
    [23225] = true, -- Charge (Mammoth) (Pointless aura that does nothing)
    [21963] = true, -- Charge (Wamasu) (Pointless aura that does nothing)
    [14272] = true, -- Call of the Pack (Summoned Wolf Passive 1)
    [14273] = true, -- Call of the Pack (Summoned Wolf Passive 2)
    [26658] = true, -- Call of the Pack (Summoned Jackal Passive 1)
    [26659] = true, -- Call of the Pack (Summoned Jackal Passive 2)

    -- DAEDRA
    [51256] = true, -- Siphon (Atronach Passive)
    [52053] = true, -- Lightning Road (Air Atronach - Storm) (Pointless aura)
    [67872] = true, -- Sweep (Flesh Colossus)
    [67842] = true, -- Sweep Shockwave (Flesh Colossus)
    [76140] = true, -- Stumble Forward (Flesh Colossus) (Swing 1)
    [76143] = true, -- Stumble Forward (Flesh Colossus) (Swing 2)
    [76145] = true, -- Stumble Forward (Flesh Colossus) (Swing 3)
    [76146] = true, -- Stumble Forward (Flesh Colossus) (Buff on Player)
    [76134] = true, -- Stumble Forward (Flesh Colossus) (Stagger on Player)
    [76133] = true, -- Stumble Forward (Flesh Colossus) (Block Stumble Forward)
    [65755] = true, -- Staggered (Flesh Colossus) (Block Pin)
    [68826] = true, -- Staggered (Flesh Colossus) (Block Sweep)
    [51646] = true, -- Frozen Ground (Frost Atronach) (Bugged, hiding to add temp solution Fake Stagger)
    [44907] = true, -- Hoarfrost Fist (Frost Atronach)
    [11076] = true, -- Chasten (Harvester) (Pointless projectile travel time aura)
    [26008] = true, -- Black Winter (Harvester) (Pointless aura applied for instant damage)
    [73916] = true, -- GEN 2 Hits (Pointless passive applied on the Feast)
    [24693] = true, -- Body Slam (Ogrim)
    [8808] = true, -- Spit (Spider Daedra)
    [88947] = true, -- Lightning Grasp (Xivilai) (Pointless aura)
    [25728] = true, -- Hand of Flame (Xivilai) (Pointless aura)

    -- DWEMER
    [64423] = true, -- Sparks (Dwemer Sentry)
    [64543] = true, -- Thunderbolt (Dwemer Sentry)
    [19997] = true, -- Static Field (Dwemer Spider)
    [20506] = true, -- Overcharge Trigger (Dwemer Spider) (Duplicate Aura)
    [20221] = true, -- Overcharge (Dwemer Spider) (Duplicate Aura)

    -- INSECTS
    [47318] = true, -- Encase (Giant Spider) (Hiding to create fake aura for correct timer)
    [61249] = true, -- Necrotic Explosion (Necrotic Hoarvor) (Pointless aura for damage component)
    [8272] = true, -- Spit (Kwama Scrib) (Pointless projectile travel time aura)
    [49192] = true, -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)
    [18567] = true, -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)
    [79147] = true, -- GEN 3 Hits (Kwama Scrib Summoned)
    [18808] = true, -- Charge (Kwama Worker) (Pointless aura that does nothing)

    -- MONSTERS
    [26129] = true, -- Shatter (Giant) (Pointless aura on damage event)
    [2821] = true, -- Luring Snare (Hag) (Pointless 2 sec buff on player)
    [5349] = true, -- Stagger (Ogre) (Hidden to add fake aura)
    [64132] = true, -- Grapple Immunity (Strangle) (Pointless buff on player)
    [48287] = true, -- Consuming Omen (Troll - Ranged) (Hiding to add fake aura)
    [48294] = true, -- Consuming Omen (Troll - Ranged) (Hiding to add fake aura)
    [64211] = true, -- Summon Wisp (Wispmother) (Pointless aura applied when Wispmother summons wisp)

    -- UNDEAD
    [17206] = true, -- Bone Saw (Bone Colossus)
    [73929] = true, -- Soul Cage (Lich) (Damage aura that doesn't need to display)
    [73937] = true, -- Soul Cage (Lich) (Damage aura that doesn't need to display)
    [68750] = true, -- Vampiric Drain (Vampire) (Damage aura that doesn't need to display)

    -- CYRODIIL
    [72639] = true, -- Power Bash - Odd Power Bash used by Cyrodiil Guards near Resource Nodes (0 sec stagger when hit - Hiding to add fake aura)
    [7880] = true, -- Light Attack (Cryodiil Mage T1) (Pointless travel time aura)
    [46726] = true, -- Shock Torrent (Cyrodiil Mage T2) (Pointless travel time aura)
    [46719] = true, -- Stolen Essence (Cryodiil Mage T2) (Pointless aura)
    [75397] = true, -- Unstable Core (Cryodiil Mage T2) (Pointless aura)
    [75395] = true, -- Reflected FX (Cryodiil Mage T2) (Pointless aura)
    [57962] = true, -- Minor Wound (Cyrodiil Mender T1) (Pointless travel time aura)
    [46272] = true, -- Rune Focus (Cyrodiil Mender T1) (Displays as 0 sec passive on player if guards are friendly)
    [46839] = true, -- Major Wound (Cryodiil Mender T2) (Pointless travel time aura)
    [46904] = true, -- Rune Focus (Cyrodiil Mender T2) (Displays as 0 sec passive on player if guards are friendly)
    [22469] = true, -- Siege Shield (Cyrodiil Mender T1 + T2)
    [16510] = true, -- Fire Salvo (Cyrodiil Honor Guard T1) (Pointless travel time aura)
    [35113] = true, -- Extended Chains (Cyrodiil Honor Guard T1) (Pointless travel time aura)
    [35115] = true, -- Pull (Cyrodiil Honor Guard T1) (Not working properly so hiding)
    [46990] = true, -- Improved Fire Torrent (Cyrodiil Honor Guard T2) (Pointless travel time aura)
    [47019] = true, -- Puncturing Chains (Cyrodiil Honor Guard T2) (Pointless travel time aura)
    [47020] = true, -- Pull (Cyrodiil Honor Guard T2) (Not working properly so hiding)
    [54264] = true, -- Lethal Arrow (Cryodiil Archer T2) (Pointless travel time aura)
    [54259] = true, -- Draining Shot (Cryodiil Archer T2) (Pointless travel time aura)

    -- Seasonal Quests
    [85639] = true, -- Covered in Mud (Mud Ball Merriment)
    [85352] = true, -- Covered in Mud (Mud Ball Merriment)
    [89243] = true, -- Butcher Awareness (A Noble Guest)

    ----------------------------------------------------------------
    -- WORLD EVENTS ------------------------------------------------
    ----------------------------------------------------------------

    -- Amkaos + Kathutet + Ranyu (Torturers)
    [81219] = true, -- Shock (Pointless projectile travel time aura)
    [81193] = true, -- Agonizing Strike (Pointless projectile travel time aura)

    ----------------------------------------------------------------
    -- MAIN QUEST RELATED ABILITIES THAT NEED HIDDEN ---------------
    ----------------------------------------------------------------
    [75514] = true, -- Greater Protection - CH Tutorial pointless aura
    [64772] = true, -- MQ1 Input Lock LAtk - CH Tutorial pointless aura
    [63883] = true, -- Major Protection - CH Tutorial pointless aura
    [64784] = true, -- MQ1 Tutorial Block Heavy - CH Tutorial pointless aura
    [64798] = true, -- MQ1 Heat Wave (Tutorial) - CH Tutorial pointless aura
    [61961] = true, -- Perma Set Off Balance Target - CH Tutorial pointless aura
    [64677] = true, -- MQ1 Tutorial Perma Off-Balance - CH Tutorial pointless aura
    [63270] = true, -- Heat Wave - Used by Forgemaster in Tutorial, Instant Damage but has aura for no reason
    [64069] = true, -- Sentinel Barrier - CH Tutorial pointless aura
    [63555] = true, -- MQ1 Sneak Atk Tutorial Trigger - CH Tutorial pointless aura
    [63559] = true, -- MQ1 Sneak Tutorial Trigger - CH Tutorial pointless aura
    [63756] = true, -- Heat Wave - Used by Skeletal Pyromancer in Tutorial, Instant Damage but has aura for no reason
    [61646] = true, -- Incapacitating Terror - CH Tutorial pointless aura (Reaplaced with Fake Aura)
    [64166] = true, -- Major Protection - CH Tutorial pointless aura
    [63637] = true, -- Teleport - CH Tutorial event when player teleports out

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    [69789] = true, -- WG - Frozen Ice (Invitation to Orsinium - Olarz the Cunning)
    [69603] = true, -- Q5318 - Siege Hits Above (The Hidden Harvest)
    [69552] = true, -- Frozen Aura (For King and Glory - Urfon Ice-Heart)
    [64306] = true, -- Frozen Fortress (For King and Glory - Urfon Ice-Heart)
    [69410] = true, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart)
    [69404] = true, -- Winter's Heed (For King and Glory - Urfon Ice-Heart)
    [69949] = true, -- Kinetic Resonator Damage Limit (Quarry Conundrum)
    [65765] = true, -- Q5348 - Poison Mist (To Save a Chief)
    [75403] = true, -- Q5348 - Poison Mist (To Save a Chief)
    [65781] = true, -- Poison Mist (To Save a Chief)
    [65780] = true, -- Poison Mist (To Save a Chief)
    [65779] = true, -- Poison Mist (To Save a Chief)
    [70646] = true, -- VR Disguise Warning (The Anger of a King)
    [66408] = true, -- Heat Wave (The Anger of a King)
    [66475] = true, -- Q5468 - Speaker (The Anger of a King)
    [66476] = true, -- Q5468 - Speaker Transfer (The Anger of a King)
    [53270] = true, -- Frost Clench (The Anger of a King - Talviah Aliaria)
    [71177] = true, -- Alga's Hold (The King's Gambit)
    [71178] = true, -- Q5468 - Speaker Alga (The King's Gambit)
    [85086] = true, -- Boss (The King's Gambit)
    [66903] = true, -- Q5481 - Injure Solgra (Blood on a King's Hands)
    [74912] = true, -- Archer's Focus (Blood on a King's Hands)
    [67898] = true, -- Q5481 - Tracking (Blood on a King's Hands)
    [70546] = true, -- Alga's Resilience (Blood on a King's Hands)
    [75103] = true, -- The King's Anger (Blood on a King's Hands)
    [75116] = true, -- The King's Anger (Blood on a King's Hands)
    [70540] = true, -- Oil Fire (Blood on a King's Hands)

    -- SIDE QUESTS
    [65852] = true, -- Shatter (Forcing the Faith)
    [65828] = true, -- Lightning Jolt Synergy (Forcing the Faith)
    [65832] = true, -- Restoring Waves Synergy (Forcing the Faith)
    [65834] = true, -- Restoring Waves (Forcing the Faith)
    [70702] = true, -- Tremors (Draugr Dilemma)
    [72153] = true, -- Choke (Draugr Dilemma)
    [69172] = true, -- Collapsing from Fatigue (Sorrow's Kiss)
    [65925] = true, -- Q5466 Sphere Sparking (Tinker Trouble)

    -- DELVES
    [69290] = true, -- Call Ally (Nikolvara the Durzog Trainer - Nikolvara's Kennel)
    [69322] = true, -- Call Ally (Nikolvara the Durzog Trainer - Nikolvara's Kennel)

    -- PUBLIC DUNGEONS
    [53874] = true, -- Pummel (Batunalulr - Old Orsinium)

    ----------------------------------------------------------------
    -- CRAGLORN EVENTS HIDDEN --------------------------------------
    ----------------------------------------------------------------

    -- Delves + Zone Events

    -- Main Quests
    [82042] = true, -- Q5130 - First Scene END Say (The Shattered and the Lost) (Pointless)
    [82134] = true, -- Q5130 - Back in Time Scene (The Shattered and the Lost) (Pointless)
    [82049] = true, -- Q5130 - Charging Amulet (The Shattered and the Lost) (Pointless)
    [82073] = true, -- Q5130 - Winery FIN Scene 1 (The Shattered and the Lost) (Pointless)
    [82075] = true, -- Q5130 - Winery FIN Scene 1 (The Shattered and the Lost) (Pointless)

    -- Repeatable Quests

    ----------------------------------------------------------------
    -- IC QUEST RELATED & QUEST BOSS HIDDEN ------------------------
    ----------------------------------------------------------------

    [68660] = true, -- Q5489 Zolgar Death Countdown - The Lock and the Legion
    [68720] = true, -- Q5489 Regilus Death Timer - The Lock and the Legion
    [82788] = true, -- IC Harvester Door Exception - The Imperial Standard (Barracks Defense)
    [69403] = true, -- Healing Immunity - The Imperial Standard (Barracks Defense)
    [59168] = true, -- Size and Strength - The Watcher in the Walls (Clannfear Boss)
    [59940] = true, -- Summoning Call - The Watcher in the Walls (Clannfear Boss)
    [59181] = true, -- Charge - The Watcher in the Walls (Clannfear Boss)
    [80678] = true, -- Chasten - The Watcher in the Walls (Harvester Boss)
    [80674] = true, -- Black Winter - The Watcher in the Walls (Harvester Boss)
    [60905] = true, -- Summon - The Watcher in the Walls (Harvester Boss)
    [80650] = true, -- Body Slam -- The Watcher in the Walls (Ogrim Boss)
    [53429] = true, -- Call Final Boss - The Watcher in the Walls (Ogrim Boss)
    [53500] = true, -- Spirit Shield - The Watcher in the Walls (Final Boss)
    [53480] = true, -- Summon Flame Atronach - The Watcher in the Walls (Final Boss)
    [53489] = true, -- Summon Flame Atronach - The Watcher in the Walls (Final Boss)
    [80657] = true, -- Fright Force - The Watcher in the Walls (Final Boss)
    [00000] = true,
    [00000] = true,
    [00000] = true,
    [00000] = true,
    [00000] = true,
    [00000] = true,
    [00000] = true,
    [00000] = true,

}

-- Fake Buffs applied onto the player by NPCs or Events (Friendly)
E.FakeExternalBuffs = {
    -- Nothing here yet
}

 -- Fake Debuffs applied onto the player by NPCs or Events (Hostile)
E.FakeExternalDebuffs = {
    -- Traps
    [29602] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Falling Rocks', duration = 2000}, -- Falling Rocks (Tripwire)
    [66153] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Trial of Flame', duration = 1500}, -- Trial of Flame (Wrothgar - Old Orsinium)
    [32246] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Steam Trap', duration = 2000}, -- Laser Snare (Steam Trap)

    -- Quest Traps
    [64535] = {icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', name = 'Chilling Wind', duration = 2000}, -- Chilling Wind (Orsinium - Sorrow's Kiss)
    [67586] = {icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = 'Avalanche', duration = 2500}, -- Avalanche (Orsinium - Sorrow's Kiss)

    -- Standard NPC Abilities
    [42514] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds', name = 'Hard Dismount', duration = 3000}, -- Hard Dismount (Player knocked off horse)
    [29401] = {icon = 'esoui/art/icons/ability_1handed_005.dds', name = 'Power Bash', duration = 3000}, --Power Bash (NPC Disorient)
    [29379] = {icon = 'esoui/art/icons/ability_2handed_001.dds', name = 'Uppercut', duration = 2500}, --Uppercut (NPC)
    [14926] = {icon = 'esoui/art/icons/ability_warrior_011.dds', name ='Focused Charge', duration = 2000}, -- Charge (Human NPC)
    [63822] = {icon = 'esoui/art/icons/ability_nightblade_008.dds', name = 'Teleport Strike', duration = 1500}, -- Teleport Strike (Nightblade)
    [44229] = {icon = 'esoui/art/icons/ability_dragonknight_006.dds', name = 'Dragonknight Standard', duration = 1200}, -- Dragonknight Standard (Dragonknight)
    [10650] = {icon = 'LuiExtended/media/icons/abilities/ability_warrior_oil_drenched.dds', name ='Oil Drenched', duration = 1100}, -- Oil Drenched
    [74483] = {icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = 'Fiery Grip', duration = 1000}, -- Fiery Grip (Sentinel) (TG DLC)

    -- Animals
    [69073] = {icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', name = 'Slam', duration = 2000}, -- Knockdown (Bear Orsinium)

    -- Daedra
    [50023] = {icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds', name = 'Lightning Rod', duration = 4000}, -- Lightning Rod (Air Atronach)
    [24700] = {icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', name = 'Body Slam', duration = 2000}, -- Body Slam (Ogrim)
    [12287] = {icon = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', name = 'Storm Bound', duration = 8000}, -- Storm Bound (Storm Atronach) (DOT)
    [12288] = {icon = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', name = 'Storm Bound', duration = 8000}, -- Storm Bound (Storm Atronach) (Snare)

    -- Insects
    [47318] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = 'Web', duration = 700}, -- Encase (Giant Spider)
    [9237] = {icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', name = 'Inject Larva', duration = 10000}, -- Larva Gestation (Giant Wasp)
    [8429] = {icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds', name = 'Zap', duration = 4000}, -- Zap (Thunderbug)

    -- Monsters
    [48287] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Consuming Omen', duration = 1500}, -- Consuming Omen (Troll - Ranged) (Fake aura to replace bugged aura)

    -- Undead
    [38834] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_defiled_ground.dds', name = 'Desecrated Ground', duration = 2100}, -- Desecrated Ground Snare (Desecrated Ground)
    [22525] = {icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds', name ='Defiled Ground', duration = 700}, -- Defiled Ground (Lich)
    [43146] = {icon = 'esoui/art/icons/ability_mage_050.dds', name = 'Winter\'s Reach', duration = 4000}, -- Winter's Reach (Wraith)

    -- CYRODIIL
    [72641] = {icon = 'esoui/art/icons/ability_1handed_005.dds', name = 'Power Bash', duration = 2000}, -- Power Bash (Cryodiil Guard T2)

    [55862] = {icon = 'LuiExtended/media/icons/abilities/ability_stormbound.dds', name = 'Storm Bound', duration = 8000}, --Storm Bound --Used by Craglorn Boss Wamasu (DOT)
    [55863] = {icon = 'LuiExtended/media/icons/abilities/ability_stormbound.dds', name = 'Storm Bound', duration = 8000}, --Storm Bound --Used by Craglorn Boss Wamasu (Snare)

    -- MAIN QUEST
    [61646] = {icon = 'esoui/art/icons/ability_debuff_fear.dds', name = 'Incapacitating Terror', duration = 0}, -- Incapacitating Terror - CH Tutorial - Fake aura to replace wierd one

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    [69794] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Frozen Ground', duration = 2000}, -- Frozen Ground (Invitation to Orsinium - Olarz the Cunning)
    [14974] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Knockback', duration = 2000}, -- CON_Knockback&KnockdownSelf (The Hand of Morkul)
    [53272] = {icon = 'esoui/art/icons/ability_destructionstaff_005.dds', name = 'Frost Clench', duration = 500}, -- Frost Clench (The Anger of a King - Talviah Aliaria)
    [66875] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Royal Strike', duration = 1500}, -- Royal Strike (Blood on a King's Hands)
    [65186] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'The King\'s Chains', duration = 4000}, -- The King's Chains (Blood on a King's Hands)
    [67014] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Tear Down the Mountain', duration = 2000}, -- Tear Down the Mountain (Blood on a King's Hands)
    [73861] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Murky Water', duration = 0}, -- Murky Water (Blood and the Sacred Words)
    [73864] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Murky Water', duration = 3000}, -- Murky Water (Blood and the Sacred Words)
    [72128] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Harmonic Wave Impact', duration = 2000}, -- Harmonic Wave Impact (Rkindaleft - Resonant Centurion)
    [25265] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Decapitation Function', duration = 2000}, -- Decapitation Function (Rkindaleft - Vessel of the Auditor)
    [70316] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Vessel Knockback', duration = 2000}, -- Q5321 Centurian Knockback (Rkindaleft - Vessel of the Auditor)

}

-- Fake buffs applied onto the player by self
E.FakePlayerBuffs = {
    -- Potions
    [77767] = {icon = 'esoui/art/icons/ability_rogue_067.dds', name = 'Hidden', duration = 0}, -- Clairvoyance Fx (... of Invisiblity)
    [77766] = {icon = 'esoui/art/icons/ability_rogue_067.dds', name = 'Hidden', duration = 0}, -- Clairvoyance Fx (... of Invisiblity)
    [78057] = {icon = 'esoui/art/icons/ability_rogue_067.dds', name = 'Hidden', duration = 0}, -- Clairvoyance Fx (Roguish Stealth Draught)
    [86782] = {icon = 'esoui/art/icons/ability_rogue_067.dds', name = 'Hidden', duration = 0}, -- Clairvoyance Fx (Crown Invisibility Potion)
    [86702] = {icon = 'esoui/art/icons/ability_rogue_067.dds', name = 'Hidden', duration = 0}, -- Clairvoyance Fx (Crown Survivor's Elixir)

    -- Misc Consumables
    [85355] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_torch.dds', name = 'Fire-Breather\'s Oil Bun', duration = 12000}, -- Flame Juggling (Consumable Version)
    [85354] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_knife.dds', name = 'Disposable Juggling Knives', duration = 12000}, -- Dagger Juggling (Consumable Verison)
    [85353] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_swallowable_sword.dds', name = 'Disposable Swallower\'s Sword', duration = 12000}, -- Sword Swallowing (Consumable Version)

    -- Base Momentos
    [41988] = {icon = 'LuiExtended/media/icons/momentos/momento_bonesnap_binding_stone.dds', name = 'Bonesnap Binding Stone', duration = 10000}, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = {icon = 'LuiExtended/media/icons/momentos/momento_discourse_amaranthine.dds', name = 'Discourse Amaranthine', duration = 10000}, -- Glimpse of the Forbidden (Discoure Amaranthine)
    [42076] = {icon = 'LuiExtended/media/icons/momentos/momento_mezha-dros_sealing_amulet.dds', name = 'Mezha-dro\'s Sealing Amulet', duration = 8000}, -- Tear (Mezha-dro's Sealing Amulet)
    [34578] = {icon = 'LuiExtended/media/icons/momentos/momento_nirnroot_wine.dds', name = 'Nirnroot Wine', duration = 8000}, -- Nirnroot Wine (Nirnroot Wine)
    [26339] = {icon = 'LuiExtended/media/icons/momentos/momento_questionable_meat_sack.dds', name = 'Mystery Meat', duration = 5500}, -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = {icon = 'LuiExtended/media/icons/momentos/momento_sanguines_goblet.dds', name = 'Sanguine\'s Goblet', duration = 10000}, -- Sanguine's Goblet (Sanguine's Goblet)
    [42008] = {icon = 'LuiExtended/media/icons/momentos/momento_token_of_root_sunder.dds', name = 'Token of Root Sunder', duration = 10000}, -- Blessing of Root Sunder (Token of Root Sunder)
    [42053] = {icon = 'LuiExtended/media/icons/momentos/momento_yokudan_totem.dds', name = 'Yokudan Totem', duration = 10000}, -- Yokudan Salute (Yokudan Totem)

    -- DLC Momentos
    [79510] = {icon = 'LuiExtended/media/icons/momentos/momento_blade_of_the_blood_oath.dds', name = 'Blade of the Blood Oath', duration = 6500}, -- TROPHY Blood Oath (Blade of the Blood Oath)
    [74151] = {icon = 'LuiExtended/media/icons/momentos/momento_hidden_pressure_vent.dds', name = 'Hidden Pressure Vent', duration = 2500}, -- Stun (Hidden Pressure Vent)

    -- Crown Store Momentos
    [85349] = {icon = 'LuiExtended/media/icons/momentos/momento_storm_atronach_transform.dds', name = 'Storm Atronach Transform', duration = 180000}, -- Storm Atronach Transform (Atronach Transformation)
    [85347] = {icon = 'LuiExtended/media/icons/momentos/momento_storm_atronach_juggle.dds', name = 'Storm Orb Juggle', duration = 12000}, -- Storm Orb Juggle (Atronach Juggling)
    [86977] = {icon = 'LuiExtended/media/icons/momentos/momento_wild_hunt_transform.dds', name = 'Wild Hunt Transform', duration = 15000}, -- Spriggan Transformation (Wild Hunt Transform)

    -- Enchants
    [21230] = {icon = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds', name = 'Weapon Damage Enchantment', duration = 5000}, -- Berserker (Glyph of Weapon Damage)
    [21578] = {icon = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds', name = 'Hardening Enchantment', duration = 5000}, -- Hardening (Glyph of Hardening)

    -- Champion Points
    [60428] = {icon = 'LuiExtended/media/icons/abilities/ability_champion_reinforced.dds', name = 'Revival', duration = 5000}, -- Revival
    [61015] = {icon = 'LuiExtended/media/icons/abilities/ability_champion_reinforced.dds', name = 'Determination', duration = 15000}, -- Determination
    [77773] = {icon = 'esoui/art/icons/ability_rogue_067.dds', name = 'Hidden', duration = 0}, -- Clairvoyance Fx (Shadowstrike)
    [59530] = {icon = 'esoui/art/icons/ability_mage_045.dds', name = 'Foresight', duration = 7000}, -- Foresight
    [63106] = {icon = 'esoui/art/icons/ability_warrior_005.dds', name = 'Retaliation', duration = 7000}, -- Retaliation
    [63102] = {icon = 'esoui/art/icons/ability_warrior_018.dds', name = 'Opportunist', duration = 7000}, -- Opportunist

    -- Player (Basic)
    [973] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', name = 'Sprint', duration = 0}, -- Sprint
    [33439] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_mount_sprint.dds', name = 'Gallop', duration = 0}, -- Mount Sprint (Generic)
    [32346] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_skyshard_collect.dds', name = 'Collecting Skyshard', duration = 5800}, -- Skyshard Collect
    [14031] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_mundus_use.dds', name = 'Receiving Boon', duration = 5000}, -- Mundus Use

    -- Seasonal Quests (New Life Festival)
    [84125] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', duration = 10000}, -- Breton Male Dance (Lava Foot Stomp)
    [84126] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', duration = 10000}, -- Breton Female Dance (Lava Foot Stomp)
    [84127] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', duration = 10000}, -- Dunmer Male Dance (Lava Foot Stomp)
    [84128] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', duration = 10000}, -- Dunmer Female Dance (Lava Foot Stomp)
    [84130] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', duration = 10000}, -- Altmer Male Dance (Lava Foot Stomp)
    [84131] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', duration = 10000}, -- Altmer Female Dance (Lava Foot Stomp)
    [84133] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', duration = 10000}, -- Nord Dance (Lava Foot Stomp)
    [84528] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_torch.dds', name = 'Torch Juggling', duration = 12000}, -- Flame Juggling (Castle Charm Challenge)
    [84506] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_knife.dds', name = 'Dagger Juggling', duration = 12000}, -- Dagger Juggling (Castle Charm Challenge)
    [84533] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_swallowable_sword.dds', name = 'Sword Swallowing', duration = 12000}, -- Sword Swallowing (Castle Charm Challenge)
    [84847] = {icon = 'LuiExtended/media/icons/abilities/ability_event_celebratory_belch.dds', name = 'Celebratory Belch', duration = 5000}, -- Celebratory Belch (Stonetooth Bash)

    -- QUEST RELATED (CRAGLORN)
    [81807] = {icon = 'esoui/art/icons/achievement_104.dds', name = 'Power of the Stars', duration = 22000}, -- Power of the Stars (The Star-Gazers)

    -- ORSINIUM
    [66453] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', name = 'Hiding', duration = 45000}, -- Hiding (A Question of Succession)

}

E.FakePlayerDebuffs = { -- Fake debuffs applied onto a target by the player
    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    [86309] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun', duration = 3000}, -- Stun (Player blocks NPC charged attack)
    [86312] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun', duration = 3000}, -- Stun (Player blocks Ogrim Body Slam)
    [74483] = {icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = 'Fiery Grip', duration = 1000}, -- Fiery Grip (Sentinel) (TG DLC) -- If the player reflects
    [17945] = {icon = 'LuiExtended/media/icons/glyphs/glyph_weakening.dds', name = 'Weakening Enchantment', duration = 5000}, -- Weakening (Glyph of Weakening)
    [17906] = {icon = 'LuiExtended/media/icons/glyphs/glyph_crushing.dds', name = 'Crushing Enchantment', duration = 5000}, -- Crusher (Glyph of Crushing)
    [21480] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_explosion.dds', name = 'Explosion', duration = 3000}, -- Explosion (Fire Vulnerability Proc)
    [68464] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_venom.dds', name = 'Venom', duration = 3000}, -- Venom (Poison Vulnerability Proc)
    [68461] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_pestilence.dds', name = 'Pestilence', duration = 3000}, -- Pestilence (Disease Vulnerability Proc)
    [68455] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_disintegration.dds', name = 'Disintegration', duration = 3000}, -- Disintegration (Lightning Vulnerability Proc)
    [68457] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_deep_freeze.dds', name = 'Deep Freeze', duration = 3000}, -- Deep Freeze (Frost Vulnerability Proc)
}

-- We use this for debuffs applied on the player or on a target that don't need to check for a removal condition
-- Useful for effects like staggers where there is no way to break out of them for the short duration they are applied
E.FakeStagger = {
    -- On Player
    [2874] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Staggered (Generic Stagger applied to player by many different NPC abilities)
    [29402] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Power Bash (Stagger when hit with Power Bash)
    [29765] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Uber Attack (Player staggers self by hitting Blocking NPC with Heavy Attack) NOT 100% NECCESARY
    [68971] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Staggered (Echatere - Shockwave)
    [12426] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Raven Storm (Hagraven)
    [32698] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Staggered (Lurcher - Pulverize)
    [5349] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Staggered (Ogre - Shockwave)
    [76134] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 600}, -- Stumble Forward (Flesh Colossus)
    [76133] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Stumble Forward (Flesh Colossus - Blocked)
    [65755] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 600}, -- Staggered (Flesh Colossus - Block Pin)
    [68826] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 600}, -- Staggered (Flesh Colossus - Block Sweep)
    [74794] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Black Winter (Harvester)
    [32023] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Generic Stagger Enemy (Bloodfiend)
    [17206] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Bone Saw(Bone Colossus)
    [45576] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Generic Stagger Enemy (Werewolf)
    [69157] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Retaliation (Winterborn Warrior)
    [69153] = {icon = 'esoui/art/icons/ability_warrior_014.dds', name = 'Retaliation', duration = 1000}, -- Retaliation (Winterborn Warrior)
    [54050] = {icon = 'esoui/art/icons/ability_warrior_032.dds', name = 'Divine Leap', duration = 500}, -- Divine Leap Stun (Vosh Rakh Devoted)
    [77927] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Staggered (Bodyguard) (DB DLC)
    [72639] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Power Bash  (Cyrodiil Guard T2) (Stagger when hit with Power Bash)
    [35115] = {icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = 'Extended Chains', duration = 1000},  -- Pull (Extended Chains) (Cyrodiil Guard T2)
    [47020] = {icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = 'Puncturing Chains', duration = 1000}, -- Pull (Puncturing Chains) (Cyrodiil Guard T2)
    [52878] = {icon = 'esoui/art/icons/ability_dragonknight_005_b.dds', name = 'Empowering Chains', duration = 433}, -- Pull (Empowering Chains) (Rkindaleft - Sharga the Firestarter)
    [33551] = {icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds', name = 'Chilling Aura', duration = 1100}, -- Chilling Aura (Frost Atronach) -- TEMPORARY FIX FOR THIS DEBUFF
    [51646] = {icon = 'LuiExtended/media/icons/abilities/ability_mage_snare_frost.dds', name = 'Frozen Ground', duration = 1000}, -- Frozen Ground (Frost Atronach) -- TEMPORARY FIX FOR THIS DEBUFF
    [48294] = {icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds', name = 'Consuming Omen', duration = 10000}, -- Consuming Omen (Troll - Ranged) -- TEMPORARY FIX FOR THIS DEBUFF (Since it can't be removed by Purge)
    [64322] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [72479] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [53290] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Stagger (The Anger of a King - Talviah Aliaria)
    [75463] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Magma Diver (The King's Gambit - Shield-Wife Razbela)
    [67156] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Kindlepitch Slick', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    [70543] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Oil Fire', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)

    -- On Target
    [86310] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 500}, -- Stagger (Player Blocks charged NPC attack)
    [21972] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 500}, -- Stagger (Player interrupts NPC cast)

}

E.FakeSelfAura = {
    -- Nothing here yet
}
