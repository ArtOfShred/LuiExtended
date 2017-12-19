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
    if E.EffectOverride[abilityId] and E.EffectOverride[abilityId].icon then 
        return E.EffectOverride[abilityId].icon
    else
        return E.AbilityIcon[abilityName or ''] or GetAbilityIcon(abilityId)
    end
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

-- TODO: TEMPORARY - Need to update with variants and make sure all these id's are correct.
-- Vampire / Lycantropy
E.IsVamp = {
    [35771] = true, -- Stage 1 Vampirism
    [35996] = true, -- Stage 2 Vampirism
    [35783] = true, -- Stage 3 Vampirism
    [35792] = true, -- Stage 4 Vampirism
}

E.IsLycan = {
    [35658] = true, -- Lycanthrophy
}

E.IsVampLycanDisease = {
    [40360] = true, -- Vampirism
    --[31068] = true, -- Sanies Lupinus
    [40521] = true, -- Sanies Lupinus
}

E.IsVampLycanBite = {
    [40359] = true, -- Fed on ally (Vampire)
    [40525] = true, -- Bit an ally (Werewolf)
}

-- Mundus passives
E.IsBoon = {
    [13940] = true, -- The Warrior
    [13943] = true, -- The Mage
    [13974] = true, -- The Serpent
    [13975] = true, -- The Thief
    [13976] = true, -- The Lady
    [13977] = true, -- The Steed
    [13978] = true, -- The Lord
    [13979] = true, -- The Apprentice
    [13980] = true, -- The Ritual
    [13981] = true, -- The Lover
    [13982] = true, -- The Atronach
    [13984] = true, -- The Shadow
    [13985] = true, -- The Tower
}

-- Currently hidden since update 14
E.IsBattleSpirit = {
    [12033] = true, -- Battle Spirit
}

-- TODO: TEMPORARY
-- Cyrodiil passives
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

E.IsSoulSummons = {
    [43752] = true, -- Soul Summons
}

E.IsSetICD = {
    [90938] = true, -- Immortal Warrior
    [90939] = true, -- Eternal Warrior
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
 
}

-- Filter out Debuffs to always display regardless of whether they are sourced from the player - BY ID
E.DebuffDisplayOverrideId = {
    [2727] = true, -- Off-Balance (Generic)
    
    -- Player (Sets)
    [51315] = true, -- Destructive Mage (Aether ... of Destruction)
    [60416] = true, -- Sunderflame
    
    -- Human NPC's
    [88281] = true, -- Call Ally (Pet Ranger)
    [89017] = true, -- Dark Shade (Dreadweaver)
    [88561] = true, -- Summon the Dead (Necromancer)
    [88504] = true, -- Summon Abomination (Bonelord)
    [29597] = true, -- Combustion (Shaman)
    [29598] = true, -- Off Balance (Shaman)
    
    -- unsorted below
    ----------------
    
    
    [25199] = true, -- Charge (Giant Wasp)
    [25112] = true, -- Charge (Giant Wasp)
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

-- Adds this aura to a list of fake GROUND auras to display
-- Optional: name, icon
-- Required: buff, debuff, ground = true/false
E.EffectGroundDisplay = {

    -- Monster Sets
    [59590] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_bogdan.dds', name = 'Bogdan the Nightflame', buff = true, debuff = false, ground = false }, -- Imperial Prison Item Set (Bogdan the Nightflame)
    [97901] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds', buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus) 
    [97882] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds', buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus)
    [97855] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds', buff = true, debuff = false, ground = false }, -- Earthgore (Earthgore)
    [80529] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_ilambris_shock.dds', buff = false, debuff = false, ground = true }, -- Ilambris (Ilambris)
    [80527] = { icon = 'esoui/art/icons/ava_siege_ui_002.dds', buff = false, debuff = false, ground = true }, -- Ilambris (Ilambris)
    [59587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds', name = 'Lord Warden Dusk', buff = true, debuff = false, ground = false }, -- Lord Warden (Lord Warden)
    [59568] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = 'Malubeth the Scourger', buff = true, debuff = false, ground = false }, -- Scourge Harvest (Malubeth)
    [59508] = { icon = 'esoui/art/icons/achievement_ic_020.dds', name = 'Maw of the Infernal', buff = true, debuff = false, ground = false }, -- Banished Cells Item Set (Maw of the Infernal)
    
    [81036] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarven_spider_heal.dds', buff = true, debuff = false, ground = false }, -- Sentinel of Rkugamz
    
    
    [80954] = { icon = 'esoui/art/icons/achievement_ic_017.dds', name = 'Shadowrend', buff = true, debuff = false, ground = false }, -- Shadowrend Summon (Shadowrend) 
    [59497] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', buff = false, debuff = false, ground = true }, -- Spawn of Mephala (Spawn of Mephala)   
    [80523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds', buff = false, debuff = false, ground = true }, -- Stormfist (Stormfist)
    
    -- Crafted Sets
    [71671] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_light_attack.dds', buff = true, debuff = false, ground = false }, -- Morkuldin (Morkuldin)
    
    -- Overland Sets
    [75691] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', buff = false, debuff = false, ground = true }, -- Bahraha's Curse
    
    -- Dungeon Sets
    [97538] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', buff = true, debuff = false, ground = false }, -- Draugr's Rest
    [97908] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', buff = true, debuff = false, ground = true }, -- Hagraven's Garden (Hagraven's)
    [67205] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds', buff = false, debuff = false, ground = true }, -- Leeching Plate (of Leeching)
    [84354] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', buff = false, debuff = false, ground = true }, -- Hand of Mephala (of Mephala's Hand)

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
    [43511] = { name = 'Sea Viper Armor', icon = 'LuiExtended/media/icons/disguises/disguise_sea_viper_armor.dds', description = 'as a Maormer soldier.' }, -- NO ICON
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
    [94209] = { name = 'Scarlet Judge\'s Regalia', icon = 'LuiExtended/media/icons/disguises/disguise_scarlet_judges_regalia.dds', description = 'as The Scarlet Judge.' }, -- NOT SURE IF ICON YET
}

E.AssistantIcons = {
    ['Nuzhimeh the Merchant']       = 'LuiExtended/media/icons/abilities/ability_innate_assistant_nuzhimeh.dds',
    ['Pirharri the Smuggler']       = 'LuiExtended/media/icons/abilities/ability_innate_assistant_pirharri.dds',
    ['Tythis Andromo, the Banker']  = 'LuiExtended/media/icons/abilities/ability_innate_assistant_tythis.dds',
}

E.IsBossMob = {

    ['War Chief Ozozai'] = true,
    ['Broodbirther'] = true,
    
    ['Mad Griskild'] = true, -- Quest -- Vvardenfell -- A Web of Troubles
    
    ['Veya Releth'] = true, -- Quest -- Vvardenfell - Family Reunion
    
    ['Old Rust-Eye'] = true, -- Delve -- Vvardenfell - Khartag Point
    
    ['Cliff Strider Matriarch'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Beckoner Morvayn'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Confessor Dradas'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Coaxer Veran'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Castigator Athin'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    
    
    ['Stone-Boiler Omalas'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Brander Releth'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Mountain-Caller Hlaren'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Wakener Maras'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Nevena Nirith'] = true, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    
    ['Mud-Tusk'] = true, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Guardian of Bthark'] = true, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Renduril the Hammer'] = true, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Friar Hadelar'] = true, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Steamreaver'] = true, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Artisan Lenarmen'] = true, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Nchulaeon the Eternal'] = true, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Nilarion the Cavalier'] = true, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth 
    
    ['Curate Erydno'] = true, -- Quest -- Vvardenfell -- Divine Inquires
    ['Savarak Fels'] = true, -- Quest -- Vvardenfell -- Reclamining Vos
    
    ['Th\'krak the Tunnel-King'] = true, -- Delve -- Vvardenfell -- Matus-Akin Egg Mine
    ['Slavemaster Arenim'] = true, -- Quest -- Vvardenfell -- The Heart of a Telvanni
    
    ['Chodala'] = true, -- Quest -- Vvardenfell -- Divine Intervention
    ['Clockwork Guardian'] = true, -- Quest -- Vvardenfell -- Divine Restoration
    ['Jovval Mortal-Bane'] = true, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Defense Core'] = true, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Mediator'] = true, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Mediator Core'] = true, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Assembly Core'] = true, -- Quest -- Vvardenfell -- Divine Restoration
    ['Barbas'] = true, -- Quest -- Vvardenfell -- Divine Restoration
    
}

E.SynergyNameOverride = {

    ['Tonal Inverter'] = 'LuiExtended/media/icons/abilities/ability_quest_tonal_inverter.dds', -- Tonal Inverter (Divine Intervention)
    ['Blade of Woe'] = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds', -- Blade of Woe (Dark Brotherhood)
    
}

E.EffectOverrideByName = {
    -- TUTORIAL
    
    [1718] =    {
                ['Naryu Virian'] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attacklight.dds' } -- Attack (Tutorial)
                },
                
    -- JUSTICE NPCS
    [37087] =   { 
                ['Estate Spellbreaker'] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
                },
    [37156] =   { 
                ['Estate Spellbreaker'] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
                },
                
    -- HUMAN NPCS
    [29521] =   {
                ['Aura of Protection'] = { hide = true } -- Aura of Protection (Aura of Protection)
                },
                
    -- ANIMALS
    [7170] =    { 
                ['Lion'] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
                ['Lioness'] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
                ['Sabre Cat'] = { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
                ['Senche-Tiger'] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                },
    [60630] =   {
                ['Lion'] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
                ['Lioness'] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
                ['Sabre Cat'] = { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
                ['Senche-Tiger'] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                },
    [60641] =   {
                ['Sabre Cat'] = { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_claw.dds' }, -- Claw (Sabre Cat)
                ['Senche-Tiger'] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                },
    [7158] =    {
                ['Lion'] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_bite.dds' }, -- Bite (Lion)
                ['Lioness'] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
                ['Sabre Cat'] = { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_bite.dds' }, -- Bite (Sabre Cat)
                ['Senche-Tiger'] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                },
    [7161] =    { 
                ['Sabre Cat'] = { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_double_strike.dds' }, -- Double Strike (Sabre Cat)
                ['Senche-Tiger'] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                },
    [14819] =   {
                ['Kagouti'] =           { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds' }, -- Charge (Kagouti)
                ['Bull Kagouti'] =      { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds' }, -- Charge (Kagouti)
                },
    [14825] =   {
                ['Kagouti'] =           { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds' }, -- Charge (Kagouti)
                ['Bull Kagouti'] =      { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds' }, -- Charge (Kagouti)
                },
    [14828] =   {
                ['Kagouti'] =           { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds' }, -- Charge (Kagouti)
                ['Bull Kagouti'] =      { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds' }, -- Charge (Kagouti)
                },
    [5362] =    {
                ['Kagouti'] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)
                ['Bull Kagouti'] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)
                
                ['Daedrat'] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_slam.dds' }, -- Slam (Daedrat)
                },
    [21904] =   {
                ['Daedrat'] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_rend.dds' }, -- Rend (Daedrat)
                },
    [4022] =    {
                ['Jackal'] =            { icon = 'LuiExtended/media/icons/abilities/ability_jackal_bite.dds' }, -- Bite (Jackal)
                },
    [42844] =   {
                ['Jackal'] =            { icon = 'LuiExtended/media/icons/abilities/ability_jackal_rotbone.dds' }, -- Rotbone (Wolf)
                },
    [14523] =   {
                ['Jackal'] =            { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
                },
    [75818] =   {
                ['Jackal'] =            { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
                },

}

E.EffectHideOverride = { -- Force hide display of event (USED BY COMBAT CLOUD ONLY!!!)
    
    -- Player - Basic
    [55400] = true, -- Magicka Restore
    [55401] = true, -- Magicka Restore
    [45982] = true, -- Bash Stun
    
    -- Player - Champion Points
    [64245] = true, -- Shadowstrike
    
    -- Player - Weapons
    [18429] = true, -- Heavy Attack (Unarmed)
    [16041] = true, -- Heavy Attack (2H)
    [15279] = true, -- Heavy Attack (1H)
    [16420] = true, -- Heavy Attack (Dual Wield)
    [16691] = true, -- Heavy Attack (Bow)
    [16261] = true, -- Heavy Attack (Frost)
    [15383] = true, -- Heavy Attack (Flame)
    
    -- Sets
    [32755] = true, -- Nikulas' Heavy Armor (of Nikulas)
    
    
    
    ----------------------------
    -- Templar (Aedric Spear)
    ----------------------------
    
    -- Piercing Javelin
    [26162] = true, -- Piercing Javelin (Piercing Javelin - Rank 1)
    [26972] = true, -- Piercing Javelin (Piercing Javelin - Rank 2)
    [26974] = true, -- Piercing Javelin (Piercing Javelin - Rank 3)
    [26976] = true, -- Piercing Javelin (Piercing Javelin - Rank 4)
    
    -- Aurora Javelin
    [26801] = true, -- Aurora Javelin (Aurora Javelin - Rank 1)
    
    -- Binding Javelin
    [26805] = true, -- Binding Javelin (Binding Javelin - Rank 1)
    
    ----------------------------
    -- Destruction Staff
    ----------------------------
    
    [38172] = true, -- Stun After Knockback Movement (Destructive Touch - Rank 1) -- Fire
    [62661] = true, -- Stun After Knockback Movement (Destructive Touch - Rank 2) -- Fire
    [62664] = true, -- Stun After Knockback Movement (Destructive Touch - Rank 3) -- Fire
    [62667] = true, -- Stun After Knockback Movement (Destructive Touch - Rank 4) -- Fire
    
    [38987] = true, -- Stun After Knockback Movement (Destructive Clench - Rank 1) -- Fire
    
    [38946] = true, -- Stun After Knockback Movement (Destructive Reach - Rank 1) -- Fire
    
    -- MAIN QUEST
    [61648] = true, -- Replenish Stamina (Tutorial - Child of Bones)
    
    -- VVARDENFELL
    [82272] = true, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82273] = true, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    
    [89903] = true, -- Tonal Inverter (Divine Intervention)
    
    [86989] = true, -- Succubus Touch (Echoes of a Fallen House)
    
    -- Nchuleftingth (Public Dungeon)
    [86624] = true, -- Piston Thrust (Dwarven Piston)
    
    [90857] = true, -- Spike Trap (Dwarven Piston)
    
    [84334] = true, -- Demolish (Nchulaeon the Eternal)
    [84336] = true, -- Demolish (Nchulaeon the Eternal)
    
    -- Forgotten Wastes (Public Dungeon)
    
    [86934] = true, -- Volcanic Debris
    [86938] = true, -- Volcanic Debris
    [92707] = true, -- Volcanic Debris
    [92704] = true, -- Volcanic Debris
    
}

E.EffectForcedType = { --Force a change to the type buff container

    [14890] = "short", -- Block
    [23284] = "short", -- Not sure, I believe this is Guard projectile intercept.
    [64197] = "short", -- Sanctuary Cyrodiil passive is considered unlimited duration, but the effect is only while the player is in the area. Should show up under short buffs.
    [54119] = "short", -- Remembrance (The Anger of a King)
    [83522] = "short", -- Freezing (Snow Bear Plunge)
    [85344] = "short", -- Atronach Aura (Storm Atronach Aura)
    [86976] = "short", -- Spriggan Aura (Wild Hunt Leaf-Dance Aura)
    [86978] = "short", -- Grand Spriggan Aura (Floral Swirl Aura)
    
    [97900] = "short", -- Domihaus (Domihaus) 
    [97896] = "short", -- Domihaus (Domihaus) 
    
    [59586] = "short", -- Lord Warden (Lord Warden)
    
    [75815] = "short", -- Lunar Bastion (of the Lunar Bastion)
    
}

E.EffectForcedName = {
    -- Nothing here yet
}

-- Using a separate chart for ZOS Artificial Effects just in case this is significantly expanded at any point
E.ArtificialEffectOverride = {

    [0] = { icon = 'esoui/art/icons/achievement_dueling_002.dds', name = 'Dueling' }, -- Battle Spirit (Duel)
    [2] = { icon = 'esoui/art/icons/artificialeffect_battle-spirit.dds' }, -- Battle Spirit (BG)

}

-- MAYBE USE LATER
E.TooltipOverride = {

}

E.EffectOverride = {

    -- MISC START
    [51392] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Bolt Escape Fatigue

    ----------------------------------------------------------------
    -- POTIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Potions (2 Traits)
    [64564] = { icon = 'LuiExtended/media/icons/potions/potion_007.dds' }, -- of Armor (Major Resolve)
    [79709] = { icon = 'LuiExtended/media/icons/potions/potion_014r.dds' }, -- of Creeping Ravage Health (Creeping Ravage Health)
    [79857] = { icon = 'LuiExtended/media/icons/potions/potion_007r.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- of Defile (Minor Defile)
    [45236] = { icon = 'LuiExtended/media/icons/potions/potion_009.dds' }, -- of Detection (Increase Detection)
    [45222] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- of Health (Major Fortitude)
    [45239] = { icon = 'LuiExtended/media/icons/potions/potion_008.dds' }, -- of Immovability (Unstoppable)
    [45237] = { icon = 'LuiExtended/media/icons/potions/potion_011.dds', name = 'Invisibility' }, -- of Invisibility (Vanish)
    [79705] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds' }, -- of Lingering Health (Lingering Restore Health)
    [45224] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- of Magicka (Major Intellect)
    [79712] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- of Protection (Minor Protection)
    [46208] = { icon = 'LuiExtended/media/icons/potions/potion_021.dds' }, -- of Ravage Armor (Minor Fracture)
    [46113] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = 'Ravage Health' }, -- of Ravage Health (Health Potion Poison)
    [46193] = { icon = 'LuiExtended/media/icons/potions/potion_016.dds' }, -- of Ravage Magicka (Ravage Magicka)
    [47204] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds' }, -- of Ravage Spell Critical (Minor Uncertainty)
    [46202] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds' }, -- of Ravage Spell Power (Minor Cowardice)
    [46206] = { icon = 'LuiExtended/media/icons/potions/potion_018.dds' }, -- of Ravage Spell Protection (Minor Breach)
    [46199] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds' }, -- of Ravage Stamina (Ravage Stamina)
    [47203] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds' }, -- of Ravage Weapon Critical (Minor Enervation)
    [46204] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds' }, -- of Ravage Weapon Power (Minor Maim)
    [46210] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds' }, -- of Slow (Hindrance)
    [64566] = { icon = 'LuiExtended/media/icons/potions/potion_010.dds' }, -- of Speed (Major Expedition)
    [64570] = { icon = 'LuiExtended/media/icons/potions/potion_013.dds' }, -- of Spell Critical (Major Prophecy)
    [64558] = { icon = 'LuiExtended/media/icons/potions/potion_006.dds' }, -- of Spell Power (Major Sorcery)
    [64562] = { icon = 'LuiExtended/media/icons/potions/potion_004.dds' }, -- of Spell Protection (Major Ward)
    [45226] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- of Stamina (Major Endurance)
    [68565] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds' }, -- of Stun (Stun)
    [79848] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds' }, -- of Vitality (Major Vitality)
    [79844] = { icon = 'LuiExtended/media/icons/potions/potion_001r.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- of Vulnerability (Minor Vulnerability)
    [64568] = { icon = 'LuiExtended/media/icons/potions/potion_012.dds' }, -- of Weapon Critical (Major Savagery)
    [64555] = { icon = 'LuiExtended/media/icons/potions/potion_005.dds' }, -- of Weapon Power (Major Brutality)

    -- Crafted Potions (3 Traits)
    [64565] = { icon = 'LuiExtended/media/icons/potions/potion_007.dds' }, -- of Armor (Major Resolve)
    -- No ... of Creeping Ravage Health
    [79860] = { icon = 'LuiExtended/media/icons/potions/potion_007r.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- of Defile (Minor Defile)
    [45458] = { icon = 'LuiExtended/media/icons/potions/potion_009.dds' }, -- of Detection (Increase Detection)
    [63670] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- of Health (Major Fortitude)
    [45463] = { icon = 'LuiExtended/media/icons/potions/potion_008.dds' }, -- of Immovability (Unstoppable)
    [45460] = { icon = 'LuiExtended/media/icons/potions/potion_011.dds', name = 'Invisibility' }, -- of Invisibility (Vanish)
    [79706] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds' }, -- of Lingering Health (Lingering Restore Health)
    [63676] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- of Magicka (Major Intellect)
    [79714] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- of Protection (Minor Protection)
    [46250] = { icon = 'LuiExtended/media/icons/potions/potion_021.dds' }, -- of Ravage Armor (Minor Fracture)
    [46217] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = 'Ravage Health' }, -- of Ravage Health (Health Potion Linger Effect) (Different name than 2 trait)
    [46237] = { icon = 'LuiExtended/media/icons/potions/potion_016.dds' }, -- of Ravage Magicka (Ravage Magicka)
    -- No ... of Ravage Spell Critical
    [46244] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds' }, -- of Ravage Spell Power (Minor Cowardice)
    [46248] = { icon = 'LuiExtended/media/icons/potions/potion_018.dds' }, -- of Ravage Spell Protection (Reduce Spell Resistance) (Should be Minor Breach)
    [46240] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds' }, -- of Ravage Stamina (Ravage Stamina)
    [47202] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds' }, -- of Ravage Weapon Critical (Reduce Weapon Critical) (Should be Minor Enervation)
    [46246] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds' }, -- of Ravage Weapon Power (Minor Maim)
    [46252] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds' }, -- of Slow (Hindrance)
    [64567] = { icon = 'LuiExtended/media/icons/potions/potion_010.dds' }, -- of Speed (Major Expedition)
    [64572] = { icon = 'LuiExtended/media/icons/potions/potion_013.dds' }, -- of Spell Critical (Major Prophecy)
    [64561] = { icon = 'LuiExtended/media/icons/potions/potion_006.dds' }, -- of Spell Power (Major Sorcery)
    [64563] = { icon = 'LuiExtended/media/icons/potions/potion_004.dds' }, -- of Spell Protection (Major Ward)
    [63681] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- of Stamina (Major Endurance)
    -- No ... of Stun
    [79850] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds' }, -- of Vitality (Major Vitality)
    -- No ... of Vulnerability
    [64569] = { icon = 'LuiExtended/media/icons/potions/potion_012.dds' }, -- of Weapon Critical (Major Savagery)
    [64554] = { icon = 'LuiExtended/media/icons/potions/potion_005.dds' }, -- of Weapon Power (Major Brutality)

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [63672] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- of Health (Major Fortitude)
    [63678] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- of Magicka (Major Intellect)
    [63683] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- of Stamina (Major Endurance)
    [72935] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Alliance Battle Draught (Major Endurance)
    [72936] = { icon = 'LuiExtended/media/icons/potions/potion_ava_yellow.dds' }, -- Alliance Battle Draught (Major Brutality)
    [72930] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds' }, -- Alliance Health Draught (Unstoppable )
    [72928] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds' }, -- Alliance Health Draught (Major Fortitude)
    [72933] = { icon = 'LuiExtended/media/icons/potions/potion_ava_teal.dds' }, -- Alliance Spell Draught (Major Sorcery)
    [72932] = { icon = 'LuiExtended/media/icons/potions/potion_ava_blue.dds' }, -- Alliance Spell Draught (Major Intellect)
    [78058] = { icon = 'LuiExtended/media/icons/potions/potion_ava_purple.dds', name = 'Invisibility' }, -- Roguish Stealth Draught (Vanish)
    [78054] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Roguish Stealth Draught (Major Endurance)
    [78081] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Roguish Escape Draught (Major Expedition)
    [78080] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Roguish Escape Draught (Major Endurance)

    -- Crown Store Potions
    [68405] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds' }, -- Crown Tri-Restoration Potion (Major Fortitude)
    [68406] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds' }, -- Crown Tri-Restoration Potion (Major Intellect)
    [68408] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds' }, -- Crown Tri-Restoration Potion (Major Endurance)
    [86780] = { icon = 'LuiExtended/media/icons/potions/potion_crown_pink.dds' }, -- Crown Invisibility Potion (Invisibility)
    [86683] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds' }, -- Crown Spellcaster's Elixir (Major Intellect)
    [86684] = { icon = 'LuiExtended/media/icons/potions/potion_crown_teal.dds' }, -- Crown Spellcaster's Elixir (Major Prophecy)
    [86685] = { icon = 'LuiExtended/media/icons/potions/potion_crown_teal.dds' }, -- Crown Spellcaster's Elixir (Major Sorcery)
    [86697] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds' }, -- Crown Survivor's Elixir (Major Fortitude)
    [86698] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds' }, -- Crown Survivor's Elixir (Unstoppable)
    [86699] = { icon = 'LuiExtended/media/icons/potions/potion_crown_pink_alt.dds' }, -- Crown Survivor's Elixir (Invisibility)
    [86693] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds' }, -- Crown Warrior's Elixir (Major Endurance)
    [86694] = { icon = 'LuiExtended/media/icons/potions/potion_crown_yellow.dds' }, -- Crown Warrior's Elixir (Major Savagery)
    [86695] = { icon = 'LuiExtended/media/icons/potions/potion_crown_yellow.dds' }, -- Crown Warrior's Elixir (Major Brutality)
    
    [92415] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds' }, -- Major Fortitude (Gold Coast Swift Survivor Elixir)
    [92418] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds' }, -- Major Expedition (Gold Coast Swift Survivor Elixir)
    [92416] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds' }, -- Unstoppable (Gold Coast Swift Survivor Elixir)

    ----------------------------------------------------------------
    -- POTION UP FRONT EFFECTS -------------------------------------
    ----------------------------------------------------------------

    --Crafted Potions (2 Traits)
    [45221] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health
    [45223] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka
    [46111] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds' }, -- Ravage Health
    [45225] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina

    --Crafted Potions (3 Traits)
    [45382] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health
    [45385] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka
    [46215] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = 'Ravage Health' }, -- Damage Health
    [45388] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [17302] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health (Vendor)
    [17323] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka (Vendor)
    [17328] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina (Vendor)
    [72934] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Alliance Battle Draught)
    [72927] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds' }, -- Restore Health (Alliance Health Draught)
    [72931] = { icon = 'LuiExtended/media/icons/potions/potion_ava_blue.dds' }, -- Restore Magicka (Alliance Spell Draught)
    [78053] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Roguish Stealth Draught)
    [78079] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Roguish Escape Draught)

    -- Crown Store Potions
    [68401] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = 'Restore Health' }, -- Restore All Resources (Crown Tri-Restoration Potion)
    [68407] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds' }, -- Restore Magicka (Crown Tri-Restoration Potion)
    [68409] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds' }, -- Restore Stamina (Crown Tri-Restoration Potion)
    [86682] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', name = 'Restore Magicka' }, -- Crown Spellcaster's Elixir (Crown Spellcaster's Elixir)
    [86696] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = 'Restore Health' }, -- Crown Survivor's Elixir (Crown Survivor's Elixir)
    [86692] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', name = 'Restore Stamina' }, -- Crown Warrior's Elixir (Crown Warrior's Elixir)
    [92414] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = 'Restore Health' }, -- Crown Survivor's Elixir (Gold Coast Swift Survivor Elixir)

    ----------------------------------------------------------------
    -- POSIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Poisons (2 Traits)
    [79133] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds' }, -- Drain Health (Drain Health Poison) DEBUFF
    [79134] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds' }, -- Restore Health (Drain Health Poison) BUFF
    [79025] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds' }, -- Ravage Health (Damage Health Poison) DEBUFF
    [79137] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds' }, -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79138] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds' }, -- Restore Magicka (Drain Magicka Poison) BUFF
    [79037] = { icon = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds' }, -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79141] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds' }, -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79142] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds' }, -- Restore Stamina (Drain Stamina Poison) BUFF
    [79045] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds' }, -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79284] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds' }, -- Drain Spell Resist (Ward-Draining Poison) DEBUFF
    [79285] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds' }, -- Minor Ward (Ward-Draining Poison) BUFF
    [79087] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds' }, -- Minor Breach (Breaching Poison) DEBUFF
    [79309] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds' }, -- Drain Physical Resist (Resolve-Draining Poison) DEBUFF
    [79310] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds' }, -- Minor Resolve (Resolve-Draining Poison) BUFF
    [79090] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds' }, -- Minor Fracture (Fracturing Poison) DEBUFF
    [79193] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_r.dds' }, -- Minor Cowardice (Sorcery-Draining Poison) DEBUFF
    [79221] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_g.dds' }, -- Minor Sorcery (Sorcery-Draining Poison) BUFF
    [79069] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds' }, -- Minor Cowardice (Cowardice Poison) DEBUFF
    [79280] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_r.dds', name = 'Minor Maim' }, -- Drain Weapon Power (Brutality-Draining Poison) DEBUFF
    [79281] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_g.dds' }, -- Minor Brutality (Brutality-Draining Poison) BUFF
    [79083] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds' }, -- Minor Maim (Maiming Poison) DEBUFF
    [79446] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds' }, -- Minor Uncertainty (Prophecy-Draining Poison) DEBUFF
    [79447] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_g.dds' }, -- Minor Prophecy (Prophecy-Draining Poison) BUFF
    [79117] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds' }, -- Minor Uncertainty (Uncertainty Poison) DEBUFF
    [79450] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds' }, -- Minor Enervation (Savagery-Draining Poison) DEBUFF
    [79453] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_g.dds' }, -- Minor Savagery (Savagery-Draining Poison) BUFF
    [79113] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds' }, -- Minor Enervation (Enervating Poison) DEBUFF
    [79457] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds' }, -- Immobilize (Escapist's Poison) DEBUFF
    [79458] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds' }, -- Unstoppable (Escapist's Poison) BUFF
    [79122] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds' }, -- Immobilize (Entrapping Poison) DEBUFF
    [79996] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', name = 'Stealth-Draining Poison' }, -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80003] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', name = 'Conspicuous Poison' }, -- Marking Poison (Conspicuous Poison) DEBUFF
    [79367] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds' }, -- Hindrance (Speed-Draining Poison) DEBUFF
    [79368] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds' }, -- Major Expedition (Speed-Draining Poison) BUFF
    [79094] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds' }, -- Hindrance (Hindering Poison) DEBUFF
    [79699] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', name = 'Creeping Drain Health'}, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79700] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', name = 'Lingering Restore Health' }, -- Restore Health (Gradual Health Drain Poison) BUFF
    [79707] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds' }, -- Creeping Ravage Health (Gradual Ravage Health Poison) DEBUFF
    [79723] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds' }, -- Minor Vulnerability (Protection-Reversing Poison) DEBUFF
    [79725] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds' }, -- Minor Protection (Protection-Reversing Poison) BUFF
    [79715] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds' }, -- Minor Vulnerability (Vulnerability Poison) DEBUFF
    [79851] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds' }, -- Minor Defile (Vitality-Draining Poison) DEBUFF
    [79852] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds' }, -- Minor Vitality (Vitality-Draining Poison) BUFF
    [79861] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds' }, -- Minor Defile (Defiling Poison) DEBUFF

    -- Crafted Poisons (3 Traits)
    [79135] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds' }, -- Drain Health (Drain Health Poison) DEBUFF
    [79136] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds' }, -- Restore Health (Drain Health Poison) BUFF
    [78922] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds' }, -- Ravage Health (Damage Health Poison) DEBUFF
    [79139] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds' }, -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79140] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds' }, -- Restore Magicka (Drain Magicka Poison) BUFF
    [79044] = { icon = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds' }, -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79143] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds' }, -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79144] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds' }, -- Restore Stamina (Drain Stamina Poison) BUFF
    [79046] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds' }, -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79306] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds' }, -- Drain Spell Resist (Ward-Draining Poison) DEBUFF
    [79307] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds' }, -- Minor Ward (Ward-Draining Poison) BUFF
    [79086] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds' }, -- Minor Breach (Breaching Poison) DEBUFF
    [79311] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds' }, -- Drain Physical Resist (Resolve-Draining Poison) DEBUFF
    [79312] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds' }, -- Minor Resolve (Resolve-Draining Poison) BUFF
    [79091] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds' }, -- Minor Fracture (Fracturing Poison) DEBUFF
    [79278] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_r.dds' }, -- Minor Cowardice (Sorcery-Draining Poison) DEBUFF
    [79279] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_g.dds' }, -- Minor Sorcery (Sorcery-Draining Poison) BUFF
    [79082] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds' }, -- Minor Cowardice (Cowardice Poison) DEBUFF
    [79282] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_r.dds' }, -- Drain Weapon Power (Brutality-Draining Poison) DEBUFF
    [79283] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_g.dds' }, -- Minor Brutality (Brutality-Draining Poison) BUFF
    [79085] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds' }, -- Minor Maim (Maiming Poison) DEBUFF
    [79448] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds' }, -- Minor Uncertainty (Prophecy-Draining Poison) DEBUFF
    [79449] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_g.dds' }, -- Minor Prophecy (Prophecy-Draining Poison) BUFF
    -- No Uncertainty
    [79454] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds' }, -- Minor Enervation (Savagery-Draining Poison) DEBUFF
    [79455] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_g.dds' }, -- Minor Savagery (Savagery-Draining Poison) BUFF
    [79116] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds' }, -- Minor Enervation (Enervating Poison) DEBUFF
    [79459] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds' }, -- Immobilize (Escapist's Poison) DEBUFF
    [79460] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds' }, -- Unstoppable (Escapist's Poison) BUFF
    -- No Entrapping
    [80002] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', name = 'Stealth-Draining Poison' }, -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80004] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', name = 'Conspicuous Poison' }, -- Marking Poison (Conspicuous Poison) DEBUFF
    [79369] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds' }, -- Hindrance (Speed-Draining Poison) DEBUFF
    [79370] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds' }, -- Major Expedition (Speed-Draining Poison) BUFF
    [79102] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds' }, -- Hindrance (Hindering Poison) DEBUFF
    [79701] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds' }, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [81348] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds' }, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79702] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds' }, -- Restore Health (Gradual Health Drain Poison) BUFF
    -- No Gradual Ravage Health
    -- No Gradual Ravage Health
    [79726] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds' }, -- Minor Vulnerability (Protection-Reversing Poison) DEBUFF
    [79727] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds' }, -- Minor Protection (Protection-Reversing Poison) BUFF
    -- No Vulnerability
    [79854] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds' }, -- Minor Defile (Vitality-Draining Poison) DEBUFF
    [79855] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds' }, -- Minor Vitality (Vitality-Draining Poison) BUFF
    [79862] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds' }, -- Minor Defile (Defiling Poison) DEBUFF

    -- Vendor Poisons
    [81553] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds' }, -- Ravage Health (Cloudy Damage Health Poison) DEBUFF
    [81551] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds' }, -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison) DEBUFF
    [81554] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds' }, -- Hindrance (Cloudy Hindering Poison) DEBUFF

    -- Crown Poisons
    [88476] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds' }, -- Creeping Ravage Health (Crown Debilitating Poison)
    [88477] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds' }, -- Hindrance (Crown Debilitating Poison)
    [88471] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_blue_r.dds' }, -- Drain Magicka (Crown Draining Poison)
    [88475] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds' }, -- Drain Stamina (Crown Draining Poison)
    [88473] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_blue_g.dds' }, -- Restore Magicka (Crown Draining Poison)
    [88474] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_g.dds' }, -- Restore Stamina (Crown Draining Poison)
    [88469] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_yellow_r.dds' }, -- Minor Maim (Crown Enfeebling Poison)
    [88470] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds' }, -- Minor Defile (Crown Enfeebling Poison)
    [81274] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds' }, -- Ravage Health (Crown Lethal Poison) DEBUFF
    [81275] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds' }, -- Creeping Ravage Health (Crown Lethal Poison) DEBUFF
    [88462] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds' }, -- Immobilize (Crown Trapping Poison)
    [88463] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds' }, -- Hindrance (Crown Trapping Poison)

    ----------------------------------------------------------------
    -- FOOD & DRINK ------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Food
    [61259] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds' }, -- Health Food
    [61260] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds' }, -- Magicka Food
    [61261] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds' }, -- Stamina Food
    [61294] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds' }, -- Magicka + Stamina Food
    [61255] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds' }, -- Health + Stamina Food
    [61257] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds' }, -- Health + Magicka Food
    [61218] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_purple.dds' }, -- Triple Food
    [72819] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_tripe_trifle_pocket.dds', name = 'Orzorga\'s Tripe Trifle Pocket' }, -- Orzorga's Tripe Trifle Pocket
    [72822] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_blood_price_pie.dds', name = 'Orzorga\'s Blood Price Pie' }, -- Orzorga's Blood Price Pie
    [72824] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_bear_haunch.dds', name = 'Orzorga\'s Smoked Bear Haunch' }, -- Orzorga's Smoked Bear Haunch
    
    [100502] = { icon = 'LuiExtended/media/icons/consumables/consumable_deregulated_mushroom_stew.dds' }, -- Deregulated Mushroom Stew
    [100498] = { icon = 'LuiExtended/media/icons/consumables/consumable_clockwork_citrus_filet.dds' }, -- Clockwork Citrus Filet

    -- Crafted Drink
    [61322] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = 'Increase Health Recovery' }, -- Health Drink
    [61323] = { hide = true }, -- Well Fed
    [61325] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = 'Increase Magicka Recovery' }, -- Magicka Drink
    [61326] = { hide = true }, -- Well Fed
    [61328] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = 'Increase Stamina Recovery' }, -- Stamina Drink
    [61329] = { hide = true }, -- Well Fed
    [61345] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = 'Increase Magicka & Stamina Recovery' }, -- Magicka + Stamina Drink
    [61346] = { hide = true }, -- Well Fed
    [61348] = { hide = true }, -- Well Fed
    [61340] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = 'Increase Health & Stamina Recovery' }, -- Health + Stamina Drink
    [61341] = { hide = true }, -- Well Fed
    [61344] = { hide = true }, -- Well Fed
    [61335] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = 'Increase Health & Magicka Recovery' }, -- Health + Magicka Drink
    [61336] = { hide = true }, -- Well Fed
    [61339] = { hide = true }, -- Well Fed
    [61350] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_purple.dds', name = 'Increase All Primary Stat Recovery' }, -- Triple Drink
    [72816] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_red_frothgar.dds', name = 'Orzorga\'s Red Frothgar' }, -- Orzorga's Red Frothgar
    [61354] = { hide = true }, -- Well Fed: Magicka Regen
    [100488] = { icon = 'LuiExtended/media/icons/consumables/consumable_spring-loaded_infusion.dds' }, -- Spring-Loaded Infusion
    [100490] = { hide = true }, -- Magicka Consumable

    -- Crafted Seasonal Food
    [84681] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_crisp_and_crunchy_pumpkin.dds', name = 'Crisp and Crunchy Pumpkin Snack Skewer' }, -- Crisp and Crunchy Pumpkin Snack Skewer
    [84709] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_crunchy_spider_skewer.dds' }, -- Crunchy Spider Skewer
    [84725] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_frosted_brains.dds', name = 'Frosted Brains' }, -- Frosted Brains
    [84678] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds' }, -- Sweet Sanguine Apples (Generic shared id for other seasonal magicka food)
    [86789] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_alcaire_festival_sword-pie.dds' }, -- Alcaire Festival Sword-Pie
    [86749] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_jagga-drenched_mud_ball.dds', name = 'Jagga-Drenched \"Mud Ball\"' }, -- Jagga-Drenched "Mud Ball"
    [86673] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_lava_foot_soup-and-saltrice.dds', name = 'Lava Foot Soup-and-Saltrice' }, -- Lava Foot Soup-and-Saltrice
    [86787] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_rajhins_sugar_claws.dds' }, -- Rajhin's Sugar Claws
    [89955] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_candied_jesters_coins.dds' }, -- Candied Jester's Coins

    -- Crafted Seasonal Drink
    [84700] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bowl_of_peeled_eyeballs.dds', name = 'Bowl of \"Peeled Eyeballs\"' }, -- Bowl of "Peeled Eyeballs"
    [84735] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_double_bloody_mara.dds' }, -- Double Bloody Mara
    [84720] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_ghastly_eye_bowl.dds', name = 'Ghastly Eye Bowl' }, -- Ghastly Eye Bowl
    [84704] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_party_punch.dds' }, -- Witchmother's Party Punch
    [84731] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_potent_brew.dds' }, -- Witchmother's Potent Brew
    [86677] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bergama_warning_fire.dds', name = 'Bergama Warning Fire' }, -- Bergama Warning Fire
    [86746] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_betnikh_twice-spiked_ale.dds', name = 'Betnikh Twice-Spiked Ale' }, -- Betnikh Twice-Spiked Ale
    [86559] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_hissmir_fish-eye_rye.dds', name = 'Hissmir Fish-Eye Rye' }, -- Hissmir Fish-Eye Rye
    [86791] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_snow_bear_glow-wine.dds', name = 'Snow Bear Glow-Wine' }, -- Snow Bear Glow-Wine
    [89957] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_dubious_camoran_throne.dds' }, -- Dubious Camoran Throne
    [89971] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_jewels_of_misrule.dds' }, -- Jewels of Misrule

    -- Vendor Food & Drink
    [66551] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds' }, -- Vendor Health Food
    [66568] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds' }, -- Vendor Magicka Food
    [66576] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds' }, -- Vendor Stamina Food
    [66586] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = 'Increase Health Recovery' }, -- Vendor Health Drink
    [66590] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = 'Increase Magicka Recovery' }, -- Vendor Magicka Drink
    [66594] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = 'Increase Stamina Recovery' }, -- Vendor Stamina Drink

    -- AVA Food & Drink
    [72961] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_bar.dds', name = 'Increase Max Magicka & Stamina' }, -- Cyrodilic Field Bar
    [72956] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tack.dds', name = 'Increase Max Health & Stamina' }, -- Cyrodilic Field Tack
    [72959] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_treat.dds', name = 'Increase Max Health & Magicka' }, -- Cyrodilic Field Treat
    [72971] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tonic.dds', name = 'Increase Magicka & Stamina Recovery' }, -- Cyrodilic Field Tonic
    [72965] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_brew.dds', name = 'Increase Health & Stamina Recovery' }, -- Cyrodilic Field Brew
    [72968] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tea.dds', name = 'Increase Health & Magicka Recovery' }, -- Cyrodilic Field Tea

    -- Crown Food & Drink
    [85484] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_crate_food.dds', name = 'Crown Crate Fortifying Meal' }, -- Crown Crate Fortifying Meal
    [68411] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_food.dds', name = 'Crown Fortifying Meal' }, -- Crown Fortifying Meal
    [85497] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_crate_drink.dds', name = 'Crown Crate Refreshing Drink' }, -- Crown Crate Refreshing Drink
    [68416] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_drink.dds', name = 'Crown Refreshing Drink' }, -- Crown Refreshing Drink
    [92435] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_magickahealth_food.dds', name = 'Crown Combat Mystic\'s Stew'}, -- Crown Combat Mystic's Stew
    [92474] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_staminahealth_food.dds', name = 'Crown Vigorous Ragout'}, -- Crown Vigorous Ragout
    [92433] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_magickahealth_drink.dds', name = 'Crown Stout Magic Liqueur'}, -- Crown Stout Magic Liqueur
    [92476] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_staminahealth_drink.dds', name = 'Crown Vigorous Tincture'}, -- Crown Vigorous Tincture

    -- Experience Bonuses
    [64210] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_psijic_ambrosia.dds', name = 'Psijic Ambrosia' }, -- Psijic Ambrosia
    [89683] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_aetherial_ambrosia.dds', name = 'Aetherial Ambrosia' }, -- Aetherial Ambrosia
    [88445] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_mythic_aetherial_ambrosia.dds', name = 'Mythic Aetherial Ambrosia' }, -- Mythic Aetherial Ambrosia
    [66776] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_scroll.dds', name = 'Crown Experience Scroll' }, -- Crown Experience Scroll
    [85501] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_1.dds', name = 'Crown Crate Experience Scroll' }, -- Crown Crate Experience Scroll
    [85502] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_2.dds', name = 'Major Crown Crate Experience Scroll' }, -- Major Crown Crate Experience Scroll
    [85503] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_3.dds', name = 'Grand Crown Crate Experience Scroll' }, -- Grand Crown Crate Experience Scroll

    -- Other
    [70582] = { hide = true }, -- Roll 1d1000 (Merethic Restorative Resin)
    
    -- Seasonal Misc
    [86794] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_mints.dds', name = 'High Hrothgar Festival Mints' }, -- Very Cold (High Hrothgar Festival Mints)
    [86740] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_grog.dds', name = 'Sailor\'s Warning Festival Grog' }, -- Very Drunk (Sailor's Warning Festival Grog)
    
    [85355] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_torch.dds', name = 'Fire-Breather\'s Oil Bun', unbreakable = 1 }, -- Flame Juggling (Consumable Version)
    [85354] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_knife.dds', name = 'Disposable Juggling Knives', unbreakable = 1 }, -- Dagger Juggling (Consumable Verison)
    [85353] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_swallowable_sword.dds', name = 'Disposable Swallower\'s Sword', unbreakable = 1 }, -- Sword Swallowing (Consumable Version)

    -- Base Mementos
    [26829] = { icon = 'LuiExtended/media/icons/mementos/memento_almalexias_enchanted_lantern.dds', name = 'Almalexia\'s Enchanted Lantern' }, -- Light of the Tribunal (Almalexia's Enchanted Lantern)
    [41988] = {icon = 'LuiExtended/media/icons/mementos/memento_bonesnap_binding_stone.dds', unbreakable = 1 }, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = {icon = 'LuiExtended/media/icons/mementos/memento_discourse_amaranthine.dds', name = 'Discourse Amaranthine', unbreakable = 1 }, -- Glimpse of the Forbidden (Discoure Amaranthine)
    [41950] = { icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds' }, -- Fetish of Anger (Fetish of Anger)
    [21226] = { icon = 'LuiExtended/media/icons/mementos/memento_finvirs_trinket.dds' }, -- Finvir's Trinket (Finvir's Trinket)
    [43700] = { hide = true }, -- Wand of Finding (Lena's Wand of Finding)
    [43702] = { hide = true }, -- Invis Chicken Delay (Lena's Wind of Finding)
    [43703] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [43704] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [43701] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [42076] = { icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds', name = 'Mezha-dro\'s Sealing Amulet', unbreakable = 1 }, -- Tear (Mezha-dro's Sealing Amulet)
    [34578] = { icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds', unbreakable = 1 }, -- Nirnroot Wine (Nirnroot Wine)
    [89550] = { icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds', name = 'Twilight Shard', unbreakable = 1 }, -- TROPHY Azura's Light (Twilight Shard)
    [42053] = { icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds', name = 'Yokudan Totem', unbreakable = 1 }, -- Yokudan Salute (Yokudan Totem)
    
    [81575] = { hide = true }, -- Event - WitchFest Cauldron (Witchmother's Whistle)
    [16846] = { hide = true }, -- Blackfeather Court Whistle (Blackfeather Court Whistle)
    [25703] = { hide = true }, -- Justal's Falcon (Justal's Falcon)
    
    -- DLC Mementos
    [79510] = { icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds', name = 'Blade of the Blood Oath', unbreakable = 1 }, -- TROPHY Blood Oath (Blade of the Blood Oath)
    [92862] = { hide = true }, -- Dreamers Chime (Ringing Bell)
    [92863] = { icon = 'LuiExtended/media/icons/mementos/memento_dreamers_chime.dds', name = 'Dreamer\'s Chime', unbreakable = 1 }, -- Dreamers Chime (Stun)
    
    [77785] = { hide = true }, -- Rain of Coins (Coin of Illusory Riches)
    
    [74151] = {icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds', name = 'Hidden Pressure Vent', unbreakable = 1 }, -- Stun (Hidden Pressure Vent)
    
    [73685] = { hide = true }, -- Rkindaleft Trophy (Hidden Pressure Vent)
    [77786] = { icon = 'LuiExtended/media/icons/mementos/memento_coin_of_illusory_riches.dds', name = 'Coin of Illusory Riches', unbreakable = 1 }, -- Stun (Coin of Illusory Riches)
    [73686] = { hide = true }, -- Old Orsinium Trophy (Malacath's Wrathful Flame)
    [74232] = { icon = 'LuiExtended/media/icons/mementos/memento_malacaths_wrathful_flame.dds', name = 'Malacath\'s Wrathful Flame', unbreakable = 1 }, -- Stun (Malacath's Wrathful Flame)

    -- Seasonal Mementos
    [77027] = { hide = true }, -- Anniversary Cake - Forreals (Jubilee Cake)
    [87998] = { hide = true }, -- Anniversary Cake (2nd Annual Jubilee Cake)
    [77123] = { icon = 'LuiExtended/media/icons/mementos/memento_event_jubilee_cake.dds', name = '2nd Annual Jubilee Cake' }, -- 2017 Anniversary EXP Buff (2nd Annual Jubilee Cake)
    [84369] = { icon = 'LuiExtended/media/icons/abilities/ability_event_witchmothers_brew.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [86774] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball' }, -- Mudball (Mud Ball Pouch)
    [86777] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball' }, -- Mudball (Mud Ball Pouch)
    [86775] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball' }, -- Covered in Mud (Mud Ball Pouch)
    [86779] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball', hide = true }, -- Covered in Mud (Mud Ball Pouch)

    -- Crown Store Mementos
    [85344] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_aura.dds', name = 'Storm Atronach Aura' }, -- Atronach Aura (Storm Atronach Aura)
    [85347] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds', name = 'Storm Orb Juggle', unbreakable = 1 }, -- Storm Orb Juggle (Atronach Juggling)
    [86976] = { icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_leaf-dance_aura.dds', name = 'Wild Hunt Leaf-Dance Aura' }, -- Spriggan Aura (Wild Hunt Leaf-Dance Aura)
    [86978] = { icon = 'LuiExtended/media/icons/mementos/memento_floral_swirl_aura.dds', name = 'Floral Swirl Aura' }, -- Grand Spriggan Aura (Floral Swirl Aura)
    
    [92866] = { icon = 'LuiExtended/media/icons/mementos/memento_dwarven_puzzle_orb.dds', name = 'Dwarven Puzzle Orb' }, -- Dwarven Globe (Dwarven Puzzle Orb)
    [92867] = { icon = 'LuiExtended/media/icons/mementos/memento_dwarven_tonal_forks.dds', name = 'Dwarven Tonal Forks' }, -- Dwarven Tuning Forks (Dwarven Tonal Forks)
    
    [97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds', name = 'Crow\'s Calling', unbreakable = 1 }, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [98378] = { hide = true }, -- Murderous Strike (Murderous Strike)
    
    [99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds', name = 'Fiery Orb', unbreakable = 1 }, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    [99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds', name = 'Flame Pixie', unbreakable = 1 }, -- Flame Crate Memento 2 (Flame Pixie)
    [99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds', name = 'Flame Eruption', unbreakable = 1 }, -- TROPHY Flame Crate Mem 3 (Flame Eruption)

    -- Assistants
    [77645] = { hide = true }, -- Stealth (Pirharri the Smuggler)
    
    -- Seasonal Quests (New Life Festival)
    [84125] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', unbreakable = 1 }, -- Breton Male Dance (Lava Foot Stomp)
    [84126] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', unbreakable = 1 }, -- Breton Female Dance (Lava Foot Stomp)
    [84127] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', unbreakable = 1 }, -- Dunmer Male Dance (Lava Foot Stomp)
    [84128] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', unbreakable = 1 }, -- Dunmer Female Dance (Lava Foot Stomp)
    [84130] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', unbreakable = 1 }, -- Altmer Male Dance (Lava Foot Stomp)
    [84131] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', unbreakable = 1 }, -- Altmer Female Dance (Lava Foot Stomp)
    [84133] = {icon = 'LuiExtended/media/icons/abilities/ability_event_lava_foot_stomp.dds', name = 'Lava Foot Stomp', unbreakable = 1 }, -- Nord Dance (Lava Foot Stomp)
    [84528] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_torch.dds', name = 'Torch Juggling', unbreakable = 1 }, -- Flame Juggling (Castle Charm Challenge)
    [84506] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_knife.dds', unbreakable = 1 }, -- Dagger Juggling (Castle Charm Challenge)
    [84533] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_swallowable_sword.dds', unbreakable = 1 }, -- Sword Swallowing (Castle Charm Challenge)
    [84847] = {icon = 'LuiExtended/media/icons/abilities/ability_event_celebratory_belch.dds', unbreakable = 1 }, -- Celebratory Belch (Stonetooth Bash)

    ----------------------------------------------------------------
    -- ENCHANTS ----------------------------------------------------
    ----------------------------------------------------------------

    [28919] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds', name = 'Life Drain Enchantment' }, -- Life Drain (Glyph of Absorb Health)
    [28921] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds', name = 'Life Drain Enchantment' }, -- Life Drain (Glyph of Absorb Health)
    [46743] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds', name = 'Absorb Magicka Enchantment' }, -- Absorb Magicka (Glyph of Absorb Magicka)
    [46744] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds', name = 'Absorb Magicka Enchantment' }, -- Absorb Magicka (Glyph of Absorb Magicka)
    [46746] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds', name = 'Absorb Stamina Enchantment' }, -- Absorb Stamina (Glyph of Absorb Stamina)
    [46747] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds', name = 'Absorb Stamina Enchantment' }, -- Absorb Stamina (Glyph of Absorb Stamina)
    [17906] = { icon = 'LuiExtended/media/icons/glyphs/glyph_crushing.dds', name = 'Crushing Enchantment' }, -- Crusher (Glyph of Crushing)
    [46749] = { icon = 'LuiExtended/media/icons/glyphs/glyph_decrease_health.dds', name = 'Decrease Health Enchantment' }, -- Damage Health (Glyph of Decrease Health)
    [17895] = { icon = 'LuiExtended/media/icons/glyphs/glyph_flame.dds', name = 'Fiery Weapon Enchantment' }, -- Fiery Weapon (Glyph of Flame)
    [17904] = { icon = 'LuiExtended/media/icons/glyphs/glyph_foulness.dds', name = 'Befouled Weapon Enchantment' }, -- Befouled Weapon (Glyph of Foulness)
    [17897] = { icon = 'LuiExtended/media/icons/glyphs/glyph_frost.dds', name = 'Frozen Weapon Enchantment' }, -- Frozen Weapon (Glyph of Frost)
    --[17947] = { icon = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds' }, -- Hardening (Glyph of Hardening) (DUMMY EVENT }, HERE JUST IN CASE)
    [21578] = { icon = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds', name = 'Hardening Enchantment' }, -- Hardening (Glyph of Hardening)
    [17902] = { icon = 'LuiExtended/media/icons/glyphs/glyph_poison.dds', name = 'Poisoned Weapon Enchantment' }, -- Poisoned Weapon (Glyph of Poison)
    [40337] = { icon = 'LuiExtended/media/icons/glyphs/glyph_prismatic.dds', name = 'Prismatic Weapon Enchantment' }, -- Primatic Weapon (Glyph of Prismatic Onslaught)
    [17899] = { icon = 'LuiExtended/media/icons/glyphs/glyph_shock.dds', name = 'Charged Weapon Enchantment' }, -- Charged Weapon (Glyph of Shock)
    [17945] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weakening.dds', name = 'Weakening Enchantment', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Weakening (Glyph of Weakening)
    --[17910] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds' }, -- Weapon Damage (Glyph of Weapon Damage) (DUMMY EVENT }, HERE JUST IN CASE)
    [21230] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds', name = 'Weapon Damage Enchantment' }, -- Berserker (Glyph of Weapon Damage) (Added in case ever needed)

    ----------------------------------------------------------------
    -- STATUS EFFECT PROCS -----------------------------------------
    ----------------------------------------------------------------

    [18084] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_burning.dds' }, -- Burning (Fire Status Effect)
    [21925] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds' }, -- Diseased (Disease Status Effect)
    [21927] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds' }, -- Major Defile (Disease Status Effect)
    [21481] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds', name = 'Chilled' }, -- Chill (Frost Status Effect)
    [68368] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds' }, -- Minor Maim (Frost Status Effect)
    [21929] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_poisoned.dds' }, -- Poisoned (Poison Status Effect)
    [21487] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds' }, -- Concussion (Shock Status Effect)
    [68359] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds' }, -- Minor Vulnerability (Shock Status Effect)

    ----------------------------------------------------------------
    -- VULNERABILITY PROCS -----------------------------------------
    ----------------------------------------------------------------

    [68448] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_explosion.dds' }, -- Explosion (Fire Vulnerability Proc)
    [21480] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_explosion.dds' }, -- Explosion (Fire Vulnerability Proc)
    [68463] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_venom.dds' }, -- Venom (Poison Vulnerability Proc)
    [68464] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_venom.dds' }, -- Venom (Poison Vulnerability Proc)
    [68462] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_pestilence.dds' }, -- Pestilence (Disease Vulnerability Proc)
    [68461] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_pestilence.dds' }, -- Pestilence (Disease Vulnerability Proc)
    [68451] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_disintegration.dds' }, -- Disintegration (Lightning Vulnerability Proc)
    [68455] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_disintegration.dds' }, -- Disintegration (Lightning Vulnerability Proc)
    [68458] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_deep_freeze.dds' }, -- Deep Freeze (Frost Vulnerability Proc)
    [68457] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_deep_freeze.dds' }, -- Deep Freeze (Frost Vulnerability Proc)
    
    ----------------------------------------------------------------
    -- EQUIPMENT ---------------------------------------------------
    ----------------------------------------------------------------
    
    -- ASYLUM WEAPONS
    [100302] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_piercing_spray.dds' }, -- Piercing Spray (Asylum Bow)
    [100294] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_disciplined_slash.dds' }, -- Disciplined Slash (Asylum 2H)
    [100462] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Asylum 1H + Shield)
    [100464] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Asylum 1H + Shield)
    [100308] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_timeless_blessing.dds' }, -- Timeless Blessing (Asylum Resto Staff)
    [100306] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_concentrated_force.dds' }, -- Concentrated Force (Asylum Destruction Staff)
    
    -- ASYLUM WEAPONS (PERFECTED)
    [99363] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_piercing_spray.dds' }, -- Piercing Spray (Perfected) (Perfected Asylum Bow)
    [99361] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_disciplined_slash.dds' }, -- Disciplined Slash (Perfected) (Perfected Asylum 2H)
    [99920] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Perfected) (Perfected Asylum 1H + Shield)
    [99919] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Perfected) (Perfected Asylum 1H + Shield)
    [99582] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_timeless_blessing.dds' }, -- Timeless Blessing (Perfected) (Perfected Asylum Resto Staff)
    [99989] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_concentrated_force.dds', name = 'Concentrated Force (Perfected)' }, -- Concentrated Force (P) (Asylum Destruction Staff)
    
    -- MAELSTROM WEAPONS
    [99806] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_cruel_flurry.dds' }, -- Cruel Flurry (Maelstrom Dual Wield)
    [99789] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_merciless_charge.dds' }, -- Merciless Charge (Maelstrom 2H)
    [100588] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [100587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [100589] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [99876] = { hide = true}, -- Crushing Wall (Maelstrom Destro Staff)
    [99887] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_precise_regeneration.dds' }, -- Precise Regeneration (Maelstrom Resto Staff)
    
    -- MASTER WEAPONS
    [99761] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_puncturing_remedy.dds' }, -- Puncturing Remedy (Master 1H + shield)
    [100575] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_puncturing_remedy.dds' }, -- Puncturing Remedy (Master 1H + shield)
    [99781] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_grand_rejuvenation.dds' }, -- Grand Rejuvenation (Master Resto Staff)
    
    -- MONSTER SETS
    [59517] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_blood_spawn.dds' }, -- Blood Spawn (Blood Spawn)
    [61274] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_blood_spawn.dds' }, -- Blood Spawn (Blood Spawn)
    [59591] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_bogdan.dds', name = 'Bogdan the Nightflame' }, -- Bogdan Totem (Bogdan the Nightflame)
    [81069] = { hide = true }, -- Chokethorn (Chokethorn)
    [81077] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_chokethorn.dds' }, -- Chokethorn (Chokethorn)
    
    [97900] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds' }, -- Domihaus (Domihaus) 
    [97899] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds' }, -- Domihaus (Domihaus) 
    [97896] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds' }, -- Domihaus (Domihaus) 
    [97883] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds' }, -- Domihaus (Domihaus)
    
    [97857] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds' }, -- Earthgore (Earthgore)
    
    [84504] = { icon = 'esoui/art/icons/achievement_update11_dungeons_033.dds' }, -- Grothdarr (Grothdarr)
    [84502] = { icon = 'esoui/art/icons/achievement_update11_dungeons_033.dds' }, -- Grothdarr (Grothdarr)
    
    [80562] = { icon = 'esoui/art/icons/achievement_wrothgar_042.dds' }, -- Iceheart (Iceheart)
    [80561] = { icon = 'esoui/art/icons/achievement_wrothgar_042.dds' }, -- Iceheart (Iceheart)
    
    [80526] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_ilambris_shock.dds' }, -- Ilambris (Ilambris)
    [80525] = { icon = 'esoui/art/icons/ava_siege_ui_002.dds' }, -- Ilambris (Ilambris)
    
    [83405] = { hide = true }, -- Infernal Guardian (Infernal Guardian)
    [83409] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_infernal_guardian.dds' }, -- Infernal Guardian (Infernal Guardian)
    
    [80566] = { hide = true }, -- Kra'gh (Kra'gh)
    [80565] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_kragh.dds' }, -- Kra'gh (Kra'gh)
    
    [59586] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds', name = 'Lord Warden Dusk', duration = 0 }, -- Lord Warden (Lord Warden)
    
    [59568] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = 'Malubeth the Scourger' }, -- Scourge Harvest (Malubeth)
    [59573] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = 'Malubeth the Scourger' }, -- Scourge Harvest (Malubeth)
    
    [59508] = { icon = 'esoui/art/icons/achievement_ic_020.dds', name = 'Maw of the Infernal' }, -- Banished Cells Item Set (Maw of the Infernal)
    [60974] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_maw_of_the_infernal.dds'}, -- Jagged Claw (Maw of the Infernal)
    [60972] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'}, -- Fiery Breath (Maw of the Infernal)
    [60973] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds'}, -- Fiery Jaws (Maw of the Infernal)
    
    [66808] = { icon = 'LuiExtended/media/icons/abilities/ability_set_molag_kena.dds' }, -- Molag Kena (Molag Kena)
    [66812] = { icon = 'LuiExtended/media/icons/abilities/ability_set_molag_kena.dds' }, -- Overkill (Molag Kena)
    
    [59593] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_nerieneth.dds', name = 'Nerien\'eth' }, -- Lich Crystal (Nerien'eth)
    
    [85637] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Minor Defile (Pirate Skeleton)
    
    [80606] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_selene.dds' }, -- Selene (Selene)
    [80607] = { hide = true }, -- Dummy (Selene)
    [80609] = { hide = true }, -- Dummy (Selene)
    
    [80544] = { icon = 'esoui/art/icons/achievement_thievesguild_021.dds' }, -- Sellistrix (Sellistrix)
    [80549] = { icon = 'esoui/art/icons/achievement_thievesguild_021.dds' }, -- Sellistrix (Sellistrix)
    
    [81036] = { hide = true }, -- Sentinel of Rkugamz
    [81038] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarven_spider_heal.dds' }, -- Sentinel of Rkugamz
    [81041] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarven_spider_heal.dds' }, -- Sentinel of Rkugamz
    
    [80955] = { hide = true }, -- Shadowrend (Shadowrend)
    [80954] = { hide = true }, -- Shadowrend Summon (Shadowrend)
    [80980] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_headbutt.dds', name = 'Headbutt' }, -- Shadowrend (Shadowrend)
    [80990] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds' }, -- Minor Maim (Shadowrend)
    [80989] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_tail_spike.dds', name = 'Tail Spike' }, -- Shadowrend (Shadowrend)
    
    [59498] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = 'Spawn of Mephala' }, -- Mephala's Web (Spawn of Mephala)
    [59499] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = 'Spawn of Mephala', duration = 0}, -- Mephala's Web (Spawn of Mephala)
    
    [80522] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds' }, -- Stormfist (Stormfist)
    [80521] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds' }, -- Stormfist (Stormfist)
    
    [84419] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = 'Swarm Mother' },
    [80594] = { hide = true }, -- Ability CC Immunity (Swarm Mother)
    [80595] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds' }, -- CC Immunity (Swarm Mother)
    [80593] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = 'Swarm Mother' },
    
    [59522] = { hide = true }, -- Engine Guardian
    [59540] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_stamina.dds', name = 'Engine Guardian' }, -- Engine Guardian Stamina
    [59533] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_magicka.dds', name = 'Engine Guardian' }, -- Engine Guardian Magicka
    [59543] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_health.dds', name = 'Engine Guardian' }, -- Engine Guardian Health
    
    [80504] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_regeneration.dds', name = 'Troll King' }, -- The Troll King
    
    [80865] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds' }, -- Tremorscale
    [80866] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds' }, -- Tremorscale
    
    [59596] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_valkyn_skoria.dds' }, -- Valkyn Skoria
    [61273] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_valkyn_skoria.dds' }, -- Valkyn Skoria
    
    [80490] = { icon = 'esoui/art/icons/achievement_update11_dungeons_035.dds' }, -- Velidreth
    
    -- CRAFTED SETS
    [34502] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ashen_grip.dds' }, -- Ashen Grip
    [34592] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds' }, -- Alessia's Bulwark
    [75746] = { icon = 'LuiExtended/media/icons/abilities/ability_set_clever_alchemist.dds' }, -- Clever Alchemist
    
    [33764] = { icon = 'LuiExtended/media/icons/abilities/ability_set_deaths_wind.dds' }, -- Death's Wind
    [52289] = { icon = 'LuiExtended/media/icons/abilities/ability_set_deaths_wind.dds', hide = true }, -- Death's Wind
    
    [75929] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds' }, -- Eternal Hunt
    [76533] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds' }, -- Eternal Hunt
    
    [86555] = { name = 'Major Evasion' }, -- Hist Bark
    
    [57207] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kagrenacs_hope.dds', hide = true }, -- Kagrenac's Hope
    
    [34381] = { hide = true }, -- Magnus
    
    [99204] = { icon = 'esoui/art/icons/achievement_update16_015.dds' }, -- Mechanical Acuity (of Mechanical Acuity)
    
    [71671] = { hide = true }, -- Morkuldin (Morkuldin)
    
    [71678] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_light_attack.dds' }, -- Light Attack (Morkuldin)
    [71679] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_cleave.dds' }, -- Cleave (Morkuldin)
    
    [61784] = { icon = 'esoui/art/icons/achievement_028.dds', name = 'Redistribution', hide = true }, -- Redistribution
    
    [49126] = { icon = 'esoui/art/icons/achievement_update15_036.dds' }, -- Shalidor's Curse
    
    [75726] = { icon = 'LuiExtended/media/icons/abilities/ability_set_tavas_favor.dds' }, -- Tava's Favor
    
    [61851] = { hide = true }, -- Armor Master
    [61870] = { icon = 'esoui/art/icons/ava_siege_hookpoint_005.dds' }, -- Armor Master
    
    [34386] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Night Mother's Gaze
    
    [61781] = { icon = 'LuiExtended/media/icons/abilities/ability_set_nobles_conquest.dds' }, -- Noble's Conquest
    [61782] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Minor Vulnerability (Noble's Conquest)
    
    [34587] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Song of Lamae
    [34588] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Song of Lamae
    
    [71067] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee_alt.dds' }, -- Trial by Shock (Trials)
    [71058] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_melee_alt.dds' }, -- Trial by Fire (Trials)
    [71019] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cold_melee_alt.dds' }, -- Trial by Frost (Trials)
    [71072] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_melee_alt.dds' }, -- Trial by Poison (Trials)
    [71069] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_disease_melee_alt.dds' }, -- Trial by Disease (Trials)
    
    [79089] = { icon = 'esoui/art/icons/achievement_ic_survival.dds', name = 'Varen\'s Legacy' }, -- Varen's Wall (Varen's Legacy)
    [79093] = { hide = true }, -- Remove Trigger (Varen's Legacy)
    
    [57170] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vampires_kiss.dds' }, -- Vampire's Kiss
    
    [49236] = { icon = 'LuiExtended/media/icons/abilities/ability_set_whitestrake.dds' }, -- Whitestake's Retribution (Whitestrake's)
    
    -- Overland Sets (Light)
    
    [75707] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds' }, -- Bahraha's Curse
    [75692] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds' }, -- Bahraha's Curse
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds' }, -- Bahraha's Curse
    
    [34522] = { icon = 'esoui/art/icons/achievement_wrothgar_012.dds' }, -- Bloodthorn's Touch (Bloodthorn)
    [57177] = { icon = 'esoui/art/icons/achievement_wrothgar_012.dds' }, -- Bloodthorn's Touch (Bloodthorn)
    
    [48913] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds' }, -- Dreamer's Mantle (Dreamer's)
    [57133] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds' }, -- Dreamer's Mantle (Dreamer's)
    
    [85776] = { icon = 'esoui/art/icons/achievement_update11_dungeons_010.dds' }, -- Robes of the Hist (of Hist Sap)
    
    [52705] = { icon = 'LuiExtended/media/icons/abilities/ability_set_martial_knowledge.dds' }, -- Way of Martial Knowledge (of Martial Knowledge)
    
    [85825] = { icon = 'esoui/art/icons/achievement_update16_011.dds' }, -- Prisoner's Rags (Prisoner's)
    
    [34506] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syrabane.dds' }, -- Syrabane's Grip (of Syrabane)
    
    [57173] = { icon = 'LuiExtended/media/icons/abilities/ability_set_withered_hand.dds' }, -- Withered Hand
    [57175] = { icon = 'LuiExtended/media/icons/abilities/ability_set_withered_hand.dds', hide = true }, -- Withered Hand
    
    [71657] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds' }, -- Trinimac's Valor
    [71658] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds' }, -- Trinimac's Valor
    
    [93026] = { hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [92982] = { hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [93002] = { icon = 'esoui/art/icons/achievement_update16_029.dds' }, -- Mad Tinkerer (Mad Tinkerer's)
    [93003] = { icon = 'esoui/art/icons/achievement_update16_029.dds', hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [93001] = { icon = 'esoui/art/icons/achievement_update16_029.dds' }, -- Mad Tinkerer (Mad Tinkerer's)
    
    -- Overland Sets (Medium)
    
    [71106] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Briarheart
    
    [93308] = { hide = true }, -- Defiler
    [93307] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }, -- Defiler
    [93305] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }, -- Defiler
    [93326] = { hide = true }, -- Defiler
    
    [34875] = { icon = 'LuiExtended/media/icons/abilities/ability_set_night_terror.dds' }, -- Night Terror (of Night Terror)
    
    [34611] = { icon = 'esoui/art/icons/perks_fighters_guild_002.dds' }, -- Senche's Bite (Senche's)
    
    [67101] = { icon = 'LuiExtended/media/icons/abilities/ability_set_swamp_raider.dds'}, -- Swamp Raider
    
    [76344] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syvarras_scales.dds', name = 'Syvarra\'s Scales', hide = true }, -- Serpent's Spirit (Syvarra's Scales)
    [75718] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syvarras_scales.dds', name = 'Syvarra\'s Scales' }, -- Serpent's Spirit (Syvarra's Scales)
    
    [52709] = { icon = 'LuiExtended/media/icons/abilities/ability_set_way_of_air.dds' }, -- Way of Air (of the Air)
    
    [34383] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_infernal_guardian.dds' }, -- Shadow of the Red Mountain (of the Red Mountain)
    
    [34817] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twin_sisters.dds', name = 'Twin Sisters' }, -- Twin Sisters Bleed
    
    [34870] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wilderqueen.dds' }, -- Wilderqueen's Arch (of the Wilderqueen)
    
    [99268] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unfathomable_darkness.dds' }, -- Unfathomable Darkness (of Unfathomable Darkness)
    [99267] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unfathomable_darkness.dds', hide = true }, -- Unfathomable Darkness (of Unfathomable Darkness)
    
    [34508] = { icon = 'LuiExtended/media/icons/abilities/ability_set_werewolf_hide.dds' }, -- Hide of the Werewolf (Werewolf Hide)
    
    [18993] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Witchman Armor (Witchman's)
    [85818] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Witchman Armor (Witchman's)
    
    -- Overland Sets (Heavy)
    
    [34711] = { icon = 'LuiExtended/media/icons/abilities/ability_set_meridia.dds' }, -- Meridia's Blessed Armor (Blessed)
    
    [57298] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds', hide = true }, -- Draugr's Heritage
    [57296] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds' }, -- Draugr's Heritage
    [57297] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds' }, -- Draugr's Heritage
    
    [99286] = { icon = 'esoui/art/icons/achievement_vvardenfel_046.dds' }, -- Livewire
    
    [79123] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morihaus.dds' }, -- Hide of Morihaus (of Morihaus)
    [79112] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morihaus.dds' }, -- Hide of Morihaus (of Morihaus)
    
    [34526] = { icon = 'LuiExtended/media/icons/abilities/ability_set_seventh_legion.dds' }, -- Seventh Legion Brute (Seventh Legion)
    [57186] = { icon = 'LuiExtended/media/icons/abilities/ability_set_seventh_legion.dds' }, -- Seventh Legion Brute (Seventh Legion)
    
    [85594] = { icon = 'esoui/art/icons/ability_buff_minor_heroism.dds' }, -- Minor Heroism (Shalk's)
    
    [52711] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_melee.dds', name = 'Way of Fire' }, -- Fiery Weapon (Way of Fire)
    
    [85797] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hatchlings_shell.dds' }, -- Hatchling's Shell (of the Hatchling's Shell)
    
    [57210] = { icon = 'LuiExtended/media/icons/abilities/ability_set_storm_knight.dds' }, -- Storm Knight's Plate (of the Storm Knight)
    [57209] = { icon = 'LuiExtended/media/icons/abilities/ability_set_storm_knight.dds' }, -- Storm Knight's Plate (of the Storm Knight)
    
    [33514] = { icon = 'esoui/art/icons/perks_fighters_guild_003.dds' }, -- Armor of the Veiled Heritance (of the Veiled Heritance)
    
    [33497] = { icon = 'esoui/art/icons/achievement_vvardenfel_035.dds' }, -- Thunderbug's Carapace (Thunderbug's)
    
    [92762] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds' }, -- Minor Toughness (Warrior-Poet's)
    
    -- Dungeon Sets (Light)
    
    [61459] = { icon = 'LuiExtended/media/icons/abilities/ability_set_burning_spellweave.dds' }, -- Burning Spellweave
    
    [97539] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds' }, -- Draugr's Rest
    
    [97574] = { icon = 'LuiExtended/media/icons/abilities/ability_set_flame_blossom.dds' }, -- Flame Blossom
    
    [85610] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Lamia's Song (Lamia's)
    
    [67129] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds' }, -- Overwhelming Surge (Overwhelming)
    [67136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds' }, -- Overwhelming Surge (Overwhelming)
    
    [34504] = { icon = 'LuiExtended/media/icons/abilities/ability_set_prayer.dds' }, -- Prayer Shawl (of Prayer)
    
    [32834] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds' }, -- Sanctuary (of Sanctuary)
    
    [66902] = { icon = 'LuiExtended/media/icons/abilities/ability_set_spell_power_cure.dds' }, -- Spell Power Cure
    
    [67098] = { icon = 'LuiExtended/media/icons/abilities/ability_set_combat_physician.dds' }, -- Combat Physician (of the Combat Physician)
    
    [57164] = { icon = 'esoui/art/icons/achievement_ic_014.dds' }, -- Shroud of the Lich (of the Lich)
    
    [34813] = { icon = 'LuiExtended/media/icons/abilities/ability_set_magicka_furnace.dds' }, -- Magicka Furnace (of the Magicka Furnace)
    
    [67288] = { icon = 'esoui/art/icons/ava_siege_hookpoint_002.dds' }, -- Scathing Mage (of the Scathing Mage)
    
    [59676] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_unweaver.dds' }, -- Undaunted Unweaver (of the Undaunted Unweaver)
    
    [57163] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_027.dds' }, -- Robes of the Warlock (of the Warlock)
    
    [47367] = { icon = 'LuiExtended/media/icons/abilities/ability_set_worm_cult.dds'}, -- Worm's Raiment (of the Worm Cult)
    
    -- Dungeon Sets (Medium)
    
    [85977] = { icon = 'LuiExtended/media/icons/abilities/ability_set_barkskin.dds' }, -- Barkskin
    [85978] = { icon = 'LuiExtended/media/icons/abilities/ability_set_barkskin.dds' }, -- Barkskin
    
    [47365] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds' }, -- Hircine's Veneer (Hircine's)
    
    [34612] = { hide = true }, -- Oblivion's Edge (of Oblivion)
    [57206] = { icon = 'LuiExtended/media/icons/abilities/ability_set_oblivion.dds' }, -- Oblivion's Edge (of Oblivion)
    
    [97716] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pillar_of_nirn.dds' }, -- Pillar of Nirn
    [97743] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pillar_of_nirn.dds' }, -- Pillar of Nirn
    
    [67141] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_melee.dds'}, -- Sheer Venom
    
    [60060] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sunderflame.dds' }, -- Sunderflame
    [60416] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sunderflame.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Sunderflame
    
    [85635] = { icon = 'LuiExtended/media/icons/abilities/ability_set_spelunker.dds' }, -- Spelunker (Spelunker's)
    
    [70297] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee.dds' }, -- Storm Master (Storm Master's)
    [70298] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee.dds' }, -- Storm Master (Storm Master's)
    
    [49220] = { hide = true }, -- Extra Dodge (of the Crusader)
    
    [67334] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }, -- Essence Thief (of the Essence Thief)
    [70284] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }, -- Essence Thief (of the Essence Thief)
    [70290] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }, -- Essence Thief (of the Essence Thief)
    
    [59667] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_infiltrator.dds' }, -- Undaunted Infiltrator (of the Undaunted Infiltrator)
    
    [33691] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vipers_sting.dds' }, -- Viper's Sting
    
    [84350] = { icon = 'esoui/art/icons/achievement_update11_dungeons_035.dds' }, -- Widowmaker
    
    -- Dungeon Sets (Heavy
    
    [34527] = { name = 'Major Defile' }, -- Durok's Bane Major Defile (of Durok's Bane)
    
    [47362] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ebon.dds' }, -- Ebon Armory (Ebon)
    
    [59695] = { icon = 'LuiExtended/media/icons/abilities/ability_set_embershield.dds' }, -- Embershield (Embershield)
    [59696] = { icon = 'LuiExtended/media/icons/abilities/ability_set_embershield.dds' }, -- Embershield (Embershield)
    
    [34404] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ice_furnace.dds', name = 'Ice Furnace' }, -- Frostfire (Ice Furnace)
    
    [97626] = { icon = 'esoui/art/icons/achievement_update11_dungeons_036.dds', unbreakable = 1 }, -- Ironblood
    
    [67078] = { icon = 'LuiExtended/media/icons/abilities/ability_set_jolting.dds' }, -- Jolting Arms (Jolting)
    [67080] = { icon = 'LuiExtended/media/icons/abilities/ability_set_jolting.dds', name = 'Jolting Arms' }, -- Shocking Bash (Jolting)
    
    [85620] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_028.dds' }, -- Knight-Errant's Mail (Knight-Errant's)
    
    [69345] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Leeching Plate (of Leeching)
    [67204] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Leeching Plate (of Leeching)
    
    [84277] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    [84278] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    [84279] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    
    [84357] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = 'Hand of Mephala', duration = 0 }, -- Hand of Mephala Webbing (of Mephala's Hand)
    [84355] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds' }, -- Hand of Mephala (of Mephala's Hand)
    
    [66887] = { icon = 'LuiExtended/media/icons/abilities/ability_set_imperium.dds' }, -- Brands of the Imperium (of the Imperium)
    
    [67283] = { icon = 'esoui/art/icons/achievement_ic_025_heroic.dds', name = 'Tormentor' }, -- Tormentor Resistance (of the Tormentor)
    
    [61200] = { icon = 'esoui/art/icons/achievement_undaunteddailies_003.dds' }, -- Undaunted Bastion (of the Undaunted Bastion)
    
    [86070] = { icon = 'esoui/art/icons/achievement_thievesguild_034.dds' }, -- Armor of Truth (of Truth)
    
    -- Trial Sets (Hel Ra Citadel)
    
    [50978] = { icon = 'esoui/art/icons/achievement_update11_dungeons_001.dds' }, -- Berserking Warrior (Advancing Yokeda)
    
    [90937] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds', unbreakable = 1 }, -- Immortal Warrior (Immortal Yokeda)
    [90938] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds', name = "Immortal Warrior Cooldown" }, -- Immortal Warrior (Immortal Yokeda)
    
    [86907] = { icon = 'LuiExtended/media/icons/abilities/ability_set_defending_warrior.dds' }, -- Defending Warrior (Resilient Yokeda)
    [50992] = { icon = 'LuiExtended/media/icons/abilities/ability_set_defending_warrior.dds' }, -- Defending Warrior (Resilient Yokeda)
    
    [76618] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_minor_aegis.dds' }, -- Minor Aegis (Eternal Yokeda)
    [90940] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds', unbreakable = 1 }, -- Eternal Warrior (Eternal Yokeda)
    [61437] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds' }, -- Eternal Warrior (Eternal Yokeda)
    [90939] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds', name = "Eternal Warrior Cooldown" }, -- Eternal Warrior (Eternal Yokeda)
    
    -- Trial Sets (Aetherian Archive)
    
    [51315] = { icon = 'LuiExtended/media/icons/abilities/ability_set_destructive_mage.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Destructive Mage (Aether... of Destruction)
    [51320] = { icon = 'LuiExtended/media/icons/abilities/ability_set_destructive_mage.dds', name = 'Destructive Mage' }, -- Mage Destruction Bomb (Aether... of Destruction)
    
    [51443] = { icon = 'LuiExtended/media/icons/abilities/ability_set_healing_mage.dds', name = 'Healing Mage' }, -- Healing Bane (of Mending)
    
    [51434] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Minor Vulnerability (Aether ... of Strategy)
    
    [76617] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds' }, -- Minor Slayer (of the Infallible Aether)
    [81519] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Minor Vulnerability (of the Infallible Aether)
    
    -- Trial Sets (Sanctum Ophidia)
    
    [51241] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vipers_sting.dds' }, -- Poisonous Serpent (Ophidian ... of Venom)
    
    [51176] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_010.dds' }, -- Twice-Fanged Serpent (of the Two-Fanged Snake)
    
    [98103] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds' }, -- Minor Slayer (of the Vicious Ophidian)
    [81524] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', name = 'Major Expedition' }, -- Quick Serpent (of the Vicious Ophidian)
    [81522] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicious_serpent.dds', name = 'Vicious Serpent' }, -- Serpent Stamina (of the Vicious Ophidian)
    
    -- Trial Sets (Maw of Lorkhaj)
    
    [75801] = { icon = 'LuiExtended/media/icons/abilities/ability_set_moondancer_lunar.dds' }, -- Lunar Blessing (Moondancer)
    [75804] = { icon = 'LuiExtended/media/icons/abilities/ability_set_moondancer_shadow.dds' }, -- Shadow Blessing (Moondancer)
    
    [98102] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds' }, -- Minor Slayer (of Alkosh)
    [75752] = { icon = 'esoui/art/icons/achievement_026.dds' }, -- Roar of Alkosh (of Alkosh)
    [75753] = { icon = 'esoui/art/icons/achievement_026.dds', name = 'Roar of Alkosh' }, -- Line Breaker (of Alkosh)
    [76667] = { icon = 'esoui/art/icons/achievement_026.dds' }, -- Roar of Alkosh (of Alkosh)
    
    [75815] = { icon = 'LuiExtended/media/icons/abilities/ability_set_lunar_bastion.dds', duration = 0 }, -- Lunar Bastion (of the Lunar Bastion)
    
    [75770] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Twilight Remedy (of Twilight Remedy)
    
    -- Trial Sets (Halls of Fabrication)
    
    [93444] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_aegis.dds' }, -- Major Aegis (Automated Defense)
    [93125] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_aegis.dds' }, -- Major Aegis (Inventor's Guard)
    [93120] = { icon = 'esoui/art/icons/achievement_vvardenfel_061.dds' }, -- Major Slayer (Master Architect)
    [93442] = { icon = 'esoui/art/icons/achievement_vvardenfel_061.dds' }, -- Major Slayer (War Machine)
    
    -- Battleground Sets
    [93104] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_oblivion.dds' }, -- Knight Slayer
    
    [92916] = { icon = 'esoui/art/icons/achievement_update15_041.dds' }, -- Vanguard's Challenge
    
    -- Imperial City Sets
    [79421] = { icon = 'LuiExtended/media/icons/abilities/ability_set_galerions_revenge.dds' }, -- Mark of Revenge (Galerion's)
    [79420] = { icon = 'LuiExtended/media/icons/abilities/ability_set_galerions_revenge.dds' }, -- Galerion's Revenge (Galerion's)
    
    [65706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_meritorious_service.dds' }, -- Meritorious Service (of Meritorious Service)
    
    [90935] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds', unbreakable = 1 }, -- Phoenix (of the Phoenix)
    [90936] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds', name = "Phoenix Cooldown" }, -- Phoenix (of the Phoenix)
    [68940] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds' }, -- Phoenix (of the Phoenix)
    [70405] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds' }, -- Phoenix (of the Phoenix)
    
    [61771] = { icon = 'LuiExtended/media/icons/abilities/ability_set_powerful_assault.dds' }, -- Powerful Assault (of the Powerful Assault)
    
    [68974] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_oblivion.dds' }, -- Shield Breaker (of the Shield Breaker)
    
    [79363] = { icon = 'esoui/art/icons/achievement_029.dds' }, -- Thews of the Harbinger (of the Harbinger)
    
    [79469] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicecanon.dds', name = 'Vicecanon of Venom' }, -- Deadly Venom (the Vicanon's)
    [79471] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicecanon.dds', name = 'Vicecanon of Venom' }, -- Deadly Venom (the Vicanon's)
    
    -- Cyrodiil Sets (Light)
    
    [34605] = { icon = 'LuiExtended/media/icons/abilities/ability_set_almalexias_mercy.dds' }, -- Almalexia's Mercy (of Almalexia's Mercy)
    
    [70392] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arch-mage.dds' }, -- The Arch-Mage (of the Arch-Mage)
    
    [33498] = { icon = 'esoui/art/icons/achievement_update11_dungeons_007.dds' }, -- Desert Rose (of the Desert Rose)
    
    [47352] = { icon = 'LuiExtended/media/icons/abilities/ability_set_whitestrake.dds' }, -- Buffer of the Swift (of the Swift)
    
    -- Cyrodiil Sets (Medium)
    
    [34509] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_kiss.dds' }, -- Kyne's Kiss (of Kyne's Kiss)
    [70492] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_kiss.dds' }, -- Kyne's Kiss (of Kyne's Kiss)
    
    [34384] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morag_tong.dds' }, -- The Morag Tong (of the Morag Tong)
    
    [57180] = { icon = 'esoui/art/icons/achievement_thievesguild_011.dds' }, -- Shadow Walker (of the Shadow Walker)
    [57181] = { icon = 'esoui/art/icons/achievement_thievesguild_011.dds' }, -- Shadow Walker (of the Shadow Walker)
    
    [47358] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)
    [47359] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)
    [47360] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)
    
    -- Cyrodiil Sets (Heavy)
    
    [34787] = { icon = 'LuiExtended/media/icons/abilities/ability_set_affliction.dds' }, -- Affliction (Afflicted)
    
    [34872] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_ravager.dds' }, -- The Ravager (Ravaging)
    
    [34512] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_juggernaut.dds' }, -- The Juggernaut (of the Juggernaut)
    
    -- Rewards for the Worthy Sets
    
    [76947] = { icon = 'esoui/art/icons/ability_debuff_minor_defile.dds', name = 'Minor Defile' }, -- Fasalla's Guile (of Fasalla's Guile)
    
    [76950] = { icon = 'esoui/art/icons/ability_warrior_025.dds' }, -- Warrior's Fury (of Fury)
    
    [76936] = { icon = 'LuiExtended/media/icons/abilities/ability_set_transmutation.dds' }, -- Transmutation (of Transmutation)
    
    [76938] = { icon = 'esoui/art/icons/procs_003.dds' }, -- Vicious Death (of Vicious Death)
    
    -- DISGUISES
    [82631] = { icon = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds', name = 'Monk\'s Disguise' }, -- Monk Disguise Timer (Monk's Disguise)

    ----------------------------------------------------------------
    -- CHAMPION POINTS ---------------------------------------------
    ----------------------------------------------------------------

    -- The Steed
    [98313] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_invigorating_bash.dds' }, -- Invigorating Bash
    [98294] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_phase.dds' }, -- Phase
    [61661] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_resilient.dds' }, -- Resilient
    [98314] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds' }, -- Reinforced

    -- The Lady
    [63110] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_spell_absorption.dds' }, -- Spell Absorption
    [60371] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_critical_leech.dds' }, -- Critical Leech
    [98316] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_unchained.dds' }, -- Unchained

    -- The Lord
    [98404] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_infusion.dds' }, -- Infusion
    [98414] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds' }, -- Revival
    [61015] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds' }, -- Determination

    -- The Tower
    [98308] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_ensnare.dds' }, -- Ensnare
    [92428] = { icon = 'esoui/art/icons/ability_healer_012.dds' }, -- Siphoner
    [62518] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_maras_gift.dds' }, -- Mara's Gift

    -- The Lover
    [63878] = { icon = 'esoui/art/icons/ability_healer_033.dds' }, -- Synergizer

    -- The Shadow
    [64244] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_shadowstrike.dds' }, -- Shadowstrike
    [64245] = { hide = true }, -- Shadowstrike

    -- The Apprentice
    [63152] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_vengeance.dds', name = 'Vengeance' }, -- Vengeance Count
    [63151] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_vengeance_full.dds' }, -- Vengeance
    [59530] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_foresight.dds' }, -- Foresight
    [63114] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_arcane_well.dds' }, -- Arcane Well
    [88784] = { hide = true }, -- Arcane Well

    -- The Atronach
    [63106] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_retaliation.dds' }, -- Retaliation
    [60230] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_riposte.dds' }, -- Riposte
    [98307] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_opportunist.dds' }, -- Opportunist

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    -- Player Basic
    [29721] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_roll_dodge.dds' }, -- Immobilize Immunity
    [69143] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_dodge_fatigue.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dodge Fatigue
    --[20309] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds' }, -- Hidden (Reserved here if it ever becomes visible)
    [20301] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', name = 'Crouch' }, -- Crouch Drain
    [26245] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_018.dds', name = 'Crouch Stun' }, -- Slam Stun (Stun from crouch attack)
    --[973] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds' }, -- Sprint (Reserved here if it ever becomes visible)
    [15356] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', name = 'Sprint' }, -- Sprint Drain
    [10950] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fall_snare.dds', name = 'Fall Damage' }, -- Fall Snare
    [31221] = { hide = true }, -- Skyshard Collect (Aura on Skyshard when player collects it)
    [63601] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_eso_plus_member.dds' }, -- ESO Plus Member
    [47270] = { icon = 'esoui/art/icons/achievement_update11_dungeons_017.dds', unbreakable = 1 }, -- Ritual of Mara
    [42514] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds', unbreakable = 1 }, -- Hard Dismount
    --[33439] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mount_sprint.dds', name = 'Gallop' }, -- Mount Sprint (Generic) (Resevered here if it ever becomes visible)
    [32346] = { icon = 'esoui/art/icons/ability_mage_050.dds', name = 'Absorbing Skyshard', unbreakable = 1}, -- Skyshard Collect
    [14031] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mundus_use.dds', name = 'Receiving Boon', unbreakable = 1}, -- Mundus Use
    [14890] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds' }, -- Block
    [16270] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = 'Block' }, -- Brace Cost
    [88724] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = 'Block' }, -- Brace Cost
    [86310] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun', hide = true }, -- Stagger (Player blocks NPC charged attack)
    [86309] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun' }, -- Stun (Player blocks NPC charged attack)
    [86312] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun' }, -- Stun (Player blocks Ogrim Body Slam)
    [21970] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_bash.dds' }, -- Bash
    [21973] = { icon = '' }, -- Bash (Hides icon for interrupt)
    [21971] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds' }, -- Bash Stun (Stun from bashing cast)
    [2727] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds' }, -- Off-Balance
    [45982] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds' }, -- Bash Stun (Stun from bashing cast when NPC is pinned against an obstacle)
    [20172] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_off-balance_exploit.dds' }, -- Off-Balance Exploit
    [16566] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds' }, -- CC Immunity
    [16593] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_melee_snare.dds' }, -- Melee Snare
    [38254] = { icon = 'esoui/art/icons/ability_warrior_010.dds' }, -- Taunt
    [38541] = { icon = 'esoui/art/icons/ability_warrior_010.dds' }, -- Taunt
    [85701] = { hide = true }, -- Dueling Flag
    
    -- Off-Balance Exploit
    [18793] = { hide = true }, -- Off-Balance Exploit

    -- Resurrection
    [55400] = { hide = true }, -- Magicka Restore
    [55401] = { hide = true }, -- Magicka Restore
    
    -- Basic Abilities
    [48532] = { hide = true }, -- Charge Snare
    
    -- Disguise Effects
    [13371] = { hide = true }, -- Acting Suspicious
    
    -- Misc
    [21263] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_ayleid_well.dds', name = 'Ayleid Well'}, -- Ayleid Health Bonus
    
    ----------------------------------------------------------------
    -- WORLD EVENTS  -----------------------------------------------
    ----------------------------------------------------------------
    
    -- Daedric Anchor
    
    [86717] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_anchor_drop.dds', name = 'Anchor Drop' }, -- Drop Anchor
    
    [46690] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds' }, -- Power of the Daedra
    [46689] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = 'Power of the Daedra' }, -- Vitality of the Daedra
    [51632] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = 'Power of the Daedra' }, -- Vitality of the Daedra
    [51633] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = 'Power of the Daedra' }, -- Vitality of the Daedra
    
    [95813] = { type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1 }, -- Static Charge
    
    [46291] = { hide = true }, -- Rain of Doom
    [46293] = { hide = true }, -- Stun
    
    ----------------------------------------------------------------
    -- DRAGONKNIGHT PASSIVES ---------------------------------------
    ----------------------------------------------------------------

    -- Ardent Flame
    [29424] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 1)
    [45011] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 1)
    
    [29436] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds' }, -- Warmth (Warmth - Rank 1)
    [45016] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds' }, -- Warmth (Warmth - Rank 2)
    
    [29451] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_world_in_ruin.dds' }, -- World in Ruin (World in Ruin - Rank 1)
    [45029] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_world_in_ruin.dds' }, -- World in Ruin (World in Ruin - Rank 2)

    -- Earthen Heart
    [29465] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [29466] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [29467] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [44986] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)
    [44987] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)
    [44988] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)

    
    [29468] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_eternal_mountain.dds' }, -- Eternal Mountain (Eternal Mountain - Rank 1)
    [44996] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_eternal_mountain.dds' }, -- Eternal Mountain (Eternal Mountain - Rank 2)
    
    [29474] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds' }, -- Mountain's Blessing (Mountain's Blessing - Rank 1)
    [45005] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds' }, -- Mountain's Blessing (Mountain's Blessing - Rank 1)

    [29475] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 1)
    [29476] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 1)
    [45009] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 2)
    [45010] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 2)
    
    ----------------------------------------------------------------
    -- DRAGONKNIGHT ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------
    
    -- Lava Whip
    [23808] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Off Balance (Lava Whip - Rank 1)
    [20804] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Off Balance (Lava Whip - Rank 2)
    [23810] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Off Balance (Lava Whip - Rank 3)
    [23812] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Off Balance (Lava Whip - Rank 4)
    
    -- Molten Whip
    [20806] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Off Balance (Molten Whip - Rank 1)
    
    -- Flame Lash
    [34117] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Off Balance (Flame Lash - Rank 1)
    [23105] = { icon = 'esoui/art/icons/ability_warrior_025.dds' }, -- Power Lash (Power Lash - Rank 1)
    [70745] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = 'Power Lash' }, -- Off-Balance Exploit (Power Lash - Rank 1)
    
    -- Dragon Leap
    [18032] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds', name = 'Dragon Leap' }, -- Stun (Dragon Leap - All Ranks)
    [29016] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Dragon Leap - Rank 1)
    [33654] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Dragon Leap - Rank 2)
    [33657] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Dragon Leap - Rank 3)
    [33660] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Dragon Leap - Rank 4)
    
    -- Dragonknight Standard
    [36075] = { icon = 'esoui/art/icons/ability_mage_023.dds', hide = true }, -- Shackle (Dragonknight Standard - All Ranks)
    [76705] = { hide = true }, -- Immune (Dragonknight Standard - All Ranks)
    [29230] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', name = 'Major Defile' }, -- Major Deflie (Dragonknight Standard - Rank 1)
    [32905] = { hide = true }, -- Dragonknight Standard (Dragonknight Standard - Rank 1)
    [33957] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', name = 'Major Defile' }, -- Dragonknight Standard (Dragonknight Standard - Rank 2)
    [33958] = { hide = true }, -- Dragonknight Standard (Dragonknight Standard - Rank 2)
    [33961] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', name = 'Major Defile' }, -- Dragonknight Standard (Dragonknight Standard - Rank 3)
    [33962] = { hide = true }, -- Dragonknight Standard (Dragonknight Standard - Rank 3)
    [33965] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', name = 'Major Defile' }, -- Dragonknight Standard (Dragonknight Standard - Rank 4)
    [33966] = { hide = true }, -- Dragonknight Standard (Dragonknight Standard - Rank 4)
    
    [32961] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', name = 'Major Defile' }, -- Shifting Standard (Shifting Standard - Rank 1)
    [32965] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', name = 'Major Defile' }, -- Shifting Standard (Shifting Standard - Rank 1)
    [32963] = { name = 'Shifting Standard' }, -- Shift Standard (Shifting Standard - Rank 1)
    [32962] = { hide = true }, -- Shifting Standard (Shifting Standard - Rank 1)
    [32966] = { hide = true }, -- Shifting Standard (Shifting Standard - Rank 1)
    
    [32949] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', name = 'Major Defile' }, -- Standard of Might (Standard of Might - Rank 1)
    [32950] = { hide = true }, -- Standard of Might (Standard of Might - Rank 1)
    
    -- Spiked Armor
    [20320] = { name = 'Spiked Armor' }, -- Spiked Armor Damage Return (Spiked Armor - Rank 1)
    [23823] = { name = 'Spiked Armor' }, -- Spiked Armor Damage Return (Spiked Armor - Rank 2)
    [23826] = { name = 'Spiked Armor' }, -- Spiked Armor Damage Return (Spiked Armor - Rank 3)
    [23829] = { name = 'Spiked Armor' }, -- Spiked Armor Damage Return (Spiked Armor - Rank 4)
    
    -- Hardened Armor
    [20329] = { name = 'Hardened Armor' }, -- Hardened Armor Damage Return (Hardened Armor - Rank 1)
    
    -- Volatile Armor
    [20324] = { name = 'Volatile Armor' }, -- Volatile Armor Damage Return (Volatile Armor - Rank 1)
    
    -- Dark Talons
    [32976] = { hide = true }, -- Impale Grant Ability (Dark Talons - Rank 1)
    [33238] = { hide = true }, -- Impale Grant Ability (Dark Talons - Rank 2)
    [33240] = { hide = true }, -- Impale Grant Ability (Dark Talons - Rank 3)
    [33242] = { hide = true }, -- Impale Grant Ability (Dark Talons - Rank 4)
    
    -- Burning Talons
    [20253] = { icon = 'esoui/art/icons/ability_dragonknight_010_b.dds' }, -- Burning Talons (Burning Talons - Rank 1)
    [33244] = { hide = true }, -- Impale Grant Ability (Burning Talons - Rank 1)
    
    -- Choking Talons
    [33252] = { hide = true }, -- Impale Grant Ability (Choking Talons - Rank 1)

    -- Dragon Blood
    [29010] = { icon = 'esoui/art/icons/ability_dragonknight_011.dds' }, -- Dragon Blood (Dragon Blood - Rank 1)
    [33614] = { icon = 'esoui/art/icons/ability_dragonknight_011.dds' }, -- Dragon Blood (Dragon Blood - Rank 2)
    [33617] = { icon = 'esoui/art/icons/ability_dragonknight_011.dds' }, -- Dragon Blood (Dragon Blood - Rank 3)
    [33620] = { icon = 'esoui/art/icons/ability_dragonknight_011.dds' }, -- Dragon Blood (Dragon Blood - Rank 4)
    
    -- Green Dragon Blood
    [32745] = { icon = 'esoui/art/icons/ability_dragonknight_011_b.dds' }, -- Green Dragon Blood (Green Dragon Blood - Rank 1)
    
    -- Coagulating Blood
    [32733] = { hide = true }, -- Coagulating Blood Bonus Heal (Coagulating Blood - Rank 1)
    
    -- Obsidian Shard
    [68763] = { icon = 'esoui/art/icons/ability_dragonknight_013_b.dds', hide = true }, -- Obsidian Shard (Obsidian Shard - Rank 1)

    -- Corrosive Armor
    [17881] = { hide = true }, -- Corrosive Armor (Corrosive Armor - Rank 1)
    
    ----------------------------------------------------------------
    -- SORCERER PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    -- Dark Magic
    [31384] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds' }, -- Blood Magic (Blood Magic - Rank 1)
    [45173] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds' }, -- Blood Magic (Blood Magic - Rank 2)

    -- Daedric Summoning
    [64860] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds', name = 'Rebate' }, -- Rebate Magic (Rebate - Rank 1)
    [64861] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds', name = 'Rebate' }, -- Rebate Magic (Rebate - Rank 2)
    
    [31415] = { hide = true }, -- Expert Summoner (Expert Summoner - Rank 1)
    [46198] = { hide = true }, -- Expert Summoner (Expert Summoner - Rank 2)

    -- Storm Calling
    [31424] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds' }, -- Implosion (Implosion - Rank 1)
    [82803] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds' }, -- Implosion (Implosion - Rank 1)
    [45194] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds' }, -- Implosion (Implosion - Rank 2)
    [82806] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds' }, -- Implosion (Implosion - Rank 2)

    ----------------------------------------------------------------
    -- NIGHTBLADE PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    -- Assassination
    [36616] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_master_assassin.dds' },
    [45038] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_master_assassin.dds' },
    
    [36630] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [101435] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [36633] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [45048] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    [101436] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    [45050] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    
    [36636] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_pressure_points.dds' },
    [45053] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_pressure_points.dds' },
    
    [36641] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_hemorrhage.dds' },
    [45060] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_hemorrhage.dds' },

    -- Shadow
    [36549] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_refreshing_shadows.dds' },
    [45103] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_refreshing_shadows.dds' },
    
    [18866] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_shadow_barrier.dds' },
    [45071] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_shadow_barrier.dds' },
    
    [36532] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_vigor.dds' },
    [45084] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_vigor.dds' },
    
    [36552] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_veil.dds' },
    [45115] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_veil.dds' },
    
    -- Siphoning
    [36560] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_catalyst.dds' }, -- Catalyst (Catalyst - Rank 1)
    [63705] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds', name = 'Catalyst' }, -- Amphibious Regen (Catalyst - Rank 1)
    [45135] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_catalyst.dds' }, -- Catalyst (Catalyst - Rank 2)
    [63707] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds', name = 'Catalyst' }, -- Amphibious Regen (Catalyst - Rank 2)
    
    [36595] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_magicka_flood.dds' },
    [45150] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_magicka_flood.dds' },
    
    [36603] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_soul_siphoner.dds' },
    [45155] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_soul_siphoner.dds' },

    [36587] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 1)
    [36589] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 1)
    [45145] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 2)
    [45146] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 2)

    ----------------------------------------------------------------
    -- TEMPLAR PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Aedric Spear
    [31720] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 1)
    [80153] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 1)
    [44731] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 2)
    [80170] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 2)
    
    [31565] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_balanced_warrior.dds' }, -- Balanced Warrior
    [44732] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_balanced_warrior.dds' }, -- Balanced Warrior

    -- Dawn's Wrath
    [31746] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds' }, -- Prism (Prism - Rank 1)
    [45217] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds' }, -- Prism (Prism - Rank 2)
    
    [31721] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_restoring_spirit.dds' }, -- Restoring Spirt
    [45212] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_restoring_spirit.dds' }, -- Restoring Spirt

    -- Restoring Light
    [31757] = { icon = 'esoui/art/icons/ability_templar_032.dds' }, -- Sacred Ground
    [45207] = { icon = 'esoui/art/icons/ability_templar_032.dds' }, -- Sacred Ground
    [80195] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [80230] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [80261] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)

    [31760] = { icon = 'esoui/art/icons/ability_templar_014.dds' }, -- Light Weaver
    [45208] = { icon = 'esoui/art/icons/ability_templar_014.dds' }, -- Light Weaver
    [52703] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_light_weaver.dds', name = 'Light Weaver' }, -- Light Weaver Ultimate (Light Weaver - Rank 1 & 2)
    
    ----------------------------------------------------------------
    -- TEMPLAR ACTIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------
    
    -- Puncturing Sweep
    [55183] = { icon = 'esoui/art/icons/ability_templar_reckless_attacks.dds', name = 'Puncturing Sweep' }, -- Puncturing Sweep Heal (Puncturing Sweep - Rank 1)
    
    -- Aurora Javelin
    [37414] = { name = 'Aurora Javelin' }, -- Piercing Javelin (Aurora Javelin - Rank 1)
    
    -- Sun Fire
    [21727] = { icon = 'esoui/art/icons/ability_templar_sun_fire.dds' }, -- Sun Fire (Sun Fire - Rank 1)
    [24161] = { icon = 'esoui/art/icons/ability_templar_sun_fire.dds' }, -- Sun Fire (Sun Fire - Rank 2)
    [24169] = { icon = 'esoui/art/icons/ability_templar_sun_fire.dds' }, -- Sun Fire (Sun Fire - Rank 3)
    [24172] = { icon = 'esoui/art/icons/ability_templar_sun_fire.dds' }, -- Sun Fire (Sun Fire - Rank 4)
    
    -- Vampire's Bane
    [21730] = { icon = 'esoui/art/icons/ability_templar_vampire_bane.dds' }, -- Vampire's Bane (Vampire's Bane - Rank 1)
    
    -- Reflective Light
    [21733] = { icon = 'esoui/art/icons/ability_templar_vampire_bane.dds' }, -- Reflective Light (Reflective Light - Rank 1)
    
    -- Nova
    [31537] = { hide = true }, -- Supernova (Nova - All Ranks)
    [31540] = { icon = 'esoui/art/icons/ability_healer_013.dds' }, -- Supernova (Nova - All Ranks)
    
    -- Breath of Life
    [22256] = { hide = true }, -- Breath of Life (Breath of Life - Rank 1)
    [44391] = { icon = 'esoui/art/icons/ability_templar_breath_of_life.dds' }, -- Breath of Life (Breath of Life - Rank 1)
    
    -- Healing Ritual
    [22307] = { icon = 'esoui/art/icons/ability_templar_healing_ritual.dds', hide = true }, -- Healing Ritual (Healing Ritual - Rank 1)
    [27335] = { icon = 'esoui/art/icons/ability_templar_healing_ritual.dds', hide = true }, -- Healing Ritual (Healing Ritual - Rank 2)
    [27341] = { icon = 'esoui/art/icons/ability_templar_healing_ritual.dds', hide = true }, -- Healing Ritual (Healing Ritual - Rank 3)
    [27343] = { icon = 'esoui/art/icons/ability_templar_healing_ritual.dds', hide = true }, -- Healing Ritual (Healing Ritual - Rank 4)
    
    -- Ritual of Rebirth
    [22331] = { icon = 'esoui/art/icons/ability_templar_ritual_of_rebirth.dds', hide = true }, -- Ritual of Rebirth (Ritual of Rebirth - Rank 1)
    [88456] = { icon = 'esoui/art/icons/ability_templar_ritual_of_rebirth.dds' }, -- Ritual of Rebirth (Ritual of Rebirth - Rank 1)
    
    -- Hasty Prayer
    [22318] = { hide = true }, -- Hasty Prayer (Hasty Prayer - Rank 1)
    
    -- Rite of Passage
    [22225] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds' }, -- Rite of Passage (Rite of Passage - Rank 1)
    
    ----------------------------------------------------------------
    -- WARDEN PASSIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------
    
    -- Animal Companions
    [88986] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_bond_with_nature.dds' }, -- Bond With Nature (Bond With Nature - Rank 1)
    [88512] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_savage_beast.dds', name = 'Savage Beast' }, -- Savage Beast Ultimate (Savage Beast - Rank 1)
    [88988] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_bond_with_nature.dds' }, -- Bond With Nature (Bond With Nature - Rank 1)
    [88513] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_savage_beast.dds', name = 'Savage Beast' }, -- Transfer (Savage Beast - Rank 2)

    -- Green Balance
    [88483] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds', name = 'Nature\'s Gift' }, -- Nature's Give (Nature's Gift - Rank 1)
    [93054] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds' }, -- Nature's Gift (Nature's Gift - Rank 1)
    [93072] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds', name = 'Nature\'s Gift' }, -- Nature's Give (Nature's Gift - Rank 2)
    [93073] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds' }, -- Nature's Gift (Nature's Gift - Rank 2)
    
    [88492] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds' }, -- Minor Toughness (Maturation - Rank 1)
    [88509] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds' }, -- Minor Toughness (Maturation - Rank 2)
    
    ----------------------------------------------------------------
    -- PLAYER WEAPON ATTACKS ---------------------------------------
    ----------------------------------------------------------------

    [23604] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attacklight.dds' }, -- Light Attack
    [18430] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackmedium.dds', name = 'Medium Attack' }, -- Heavy Attack
    [18431] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackheavy.dds' }, -- Heavy Attack
    [60772] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackrestore.dds', name = 'Heavy Attack' }, -- Heavy Attack (Unarmed)

    [16037] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [17162] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = 'Medium Attack' }, -- Heavy Attack
    [17163] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack
    [60757] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', name = 'Heavy Attack' }, -- Heavy Attack (2H)

    [15435] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [15282] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = 'Medium Attack' }, -- Heavy Attack
    [15829] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack
    [60759] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', name = 'Heavy Attack' }, -- Heavy Attack (Shield)

    [16499] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [17170] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = 'Medium Attack' }, -- Heavy Attack
    [17169] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = 'Heavy Attack (Main Hand)' }, -- Heavy Attack
    [18622] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = 'Heavy Attack (Off Hand)' }, -- Heavy Attack (Dual Wield)
    [60758] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', name = 'Heavy Attack' }, -- Heavy Attack (Dual Wield)

    [16688] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds' }, -- Light Attack
    [17174] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackmedium.dds', name = 'Medium Attack' }, -- Heavy Attack
    [17173] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackheavy.dds' }, -- Heavy Attack
    [60761] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackrestore.dds', name = 'Heavy Attack' }, -- Heavy Attack (Bow)

    [16277] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attacklight.dds' }, -- Light Attack
    [18405] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackmedium.dds', name = 'Medium Attack' }, -- Heavy Attack
    [18406] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackheavy.dds' }, -- Heavy Attack
    [60762] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = 'Heavy Attack' }, -- Heavy Attack (Frost)

    [16165] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attacklight.dds' }, -- Light Attack
    [15385] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackmedium.dds', name = 'Medium Attack' }, -- Heavy Attack
    [16321] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackheavy.dds' }, -- Heavy Attack
    [60763] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = 'Heavy Attack' }, -- Heavy Attack (Fire)

    [18350] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attacklight.dds' }, -- Light Attack
    [18396] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds' }, -- Heavy Attack (Shock)
    [19277] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavypulse.dds', name = 'Heavy Attack (Shock Pulse)', hide = true }, -- Shock Pulse
    [60764] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = 'Heavy Attack (Shock Pulse)' }, -- Heavy Attack (Shock)

    [16145] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attacklight.dds' }, -- Light Attack
    [16212] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds' }, -- Heavy Attack
    [32760] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = 'Heavy Attack' }, -- Heavy Attack (Restoration)
    [28469] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds' }, -- Heavy Attack
    [38591] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds' }, -- Heavy Attack

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WEAPONS -------------------------------------
    ----------------------------------------------------------------

    -- Two Handed
    [30821] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds' }, -- Forceful (Rank 1)
    [45445] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds' }, -- Forceful (Rank 2)
    [29375] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_heavy_weapons.dds' }, -- Heavy Weapons (Rank 1)
    [29383] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = 'Heavy Weapons' }, -- Heavy Weapons Bleed (Rank 1)
    [45430] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_heavy_weapons.dds' }, -- Heavy Weapons (Rank 2)
    [45431] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = 'Heavy Weapons' }, -- Heavy Weapons Bleed (Rank 2)
    [29388] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_balanced_blade.dds' }, -- Balanced Blade (Rank 1)
    [45443] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_balanced_blade.dds' }, -- Balanced Blade (Rank 2)
    [29389] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_follow_up.dds' }, -- Follow Up (Follow Up - Rank 1)
    [60860] = { icon = 'esoui/art/icons/ability_warrior_018.dds', name = 'Follow Up' }, -- Bonus Damage (Follow Up - Rank 1)
    [45446] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_follow_up.dds' }, -- Follow Up (Follow Up - Rank 2)
    [60888] = { icon = 'esoui/art/icons/ability_warrior_018.dds', name = 'Follow Up' }, -- Bonus Damage (Follow Up - Rank 2)
    [29392] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_battle_rush.dds' }, -- Battle Rush (Battle Rush - Rank 1)
    [45450] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_battle_rush.dds' }, -- Battle Rush (Battle Rush - Rank 2)
    
    -- One Hand and Shield
    [29420] = { icon = 'esoui/art/icons/ability_weapon_029.dds' }, -- Fortress (Fortress - Rank 1)
    [45471] = { icon = 'esoui/art/icons/ability_weapon_029.dds' }, -- Fortress (Fortress - Rank 2)
    
    [29397] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_sword_and_board.dds' }, -- Sword and Board (Sword and Board - Rank 1)
    [45452] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_sword_and_board.dds' }, -- Sword and Board (Sword and Board - Rank 2)
    
    [29415] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_deadly_bash.dds' }, -- Deadly Bash (Deadly Bash - Rank 1)
    [45469] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_deadly_bash.dds' }, -- Deadly Bash (Deadly Bash - Rank 2)
    
    [29399] = { icon = 'esoui/art/icons/ability_weapon_003.dds' }, -- Deflect Bolts (Deflect Bolts - Rank 1)
    [45472] = { icon = 'esoui/art/icons/ability_weapon_003.dds' }, -- Deflect Bolts (Deflect Bolts - Rank 2)
    
    [29422] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_battlefield_mobility.dds' }, -- Battlefield Mobility (Battlefield Mobility - Rank 1)
    [45473] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_battlefield_mobility.dds' }, -- Battlefield Mobility (Battlefield Mobility - Rank 2)

    -- Dual Wield
    [30872] = { icon = 'esoui/art/icons/ability_weapon_020.dds' }, -- Controlled Fury (Controlled Fury - Rank 1)
    [45478] = { icon = 'esoui/art/icons/ability_weapon_020.dds' }, -- Controlled Fury (Controlled Fury - Rank 2)
    
    [21114] = { icon = 'esoui/art/icons/ability_weapon_012.dds' }, -- Ruffian (Ruffian - Rank 1)
    [45481] = { icon = 'esoui/art/icons/ability_weapon_012.dds' }, -- Ruffian (Ruffian - Rank 2)
    
    [30894] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = 'Twin Blade and Blunt' }, -- Twin Blade and Blunt Bleed (Rank 1)
    [45483] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = 'Twin Blade and Blunt' }, -- Twin Blade and Blunt Bleed (Rank 2)

    -- Bow
    
    [30930] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_accuracy.dds' }, -- Accuracy (Accuracy - Rank 1)
    [45492] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_accuracy.dds' }, -- Accuracy (Accuracy - Rank 2)
    
    [30942] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_ranger.dds' }, -- Ranger (Ranger) - Rank 1)
    [45493] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_ranger.dds' }, -- Ranger (Ranger) - Rank 2)
    
    [30936] = { icon = 'esoui/art/icons/ability_weapon_024.dds' }, -- Hawk Eye (Hawk Eye - Rank 1)
    [78854] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_hawk_eye.dds' }, -- Hawk Eye (Hawk Eye - Rank 1)
    [45497] = { icon = 'esoui/art/icons/ability_weapon_024.dds' }, -- Hawk Eye (Hawk Eye - Rank 2)
    [78855] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_hawk_eye.dds' }, -- Hawk Eye (Hawk Eye - Rank 2)
    [30923] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_hasty_retreat.dds' }, -- Hasty Retreat (Hasty Retreat - Rank 1)
    [98489] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Hasty Retreat - Rank 1)
    [45498] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_hasty_retreat.dds' }, -- Hasty Retreat (Hasty Retreat - Rank 2)
    [98490] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Hasty Retreat - Rank 2)

    -- Destruction Staff
    [30948] = { icon = 'LuiExtended/media/icons/abilities/passive_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 1)
    [69774] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 1)
    [45500] = { icon = 'LuiExtended/media/icons/abilities/passive_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 2)
    [69773] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 2)
    [30951] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', name = 'Tri Focus (Shock)' }, -- Shock (Tri Focus - Rank 1)
    [45505] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', name = 'Tri Focus (Shock)' }, -- Shock (Tri Focus - Rank 2)
    
    
    [30959] = { icon = 'esoui/art/icons/ability_weapon_007.dds' }, -- Ancient Knowledge (Ancient Knowledge - Rank 1)
    [45513] = { icon = 'esoui/art/icons/ability_weapon_007.dds' }, -- Ancient Knowledge (Ancient Knowledge - Rank 2)
    
    [30966] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_destruction_expert.dds', name = 'Destruction Expert', hide = true }, -- Magicka Restore (Destruction Expert - Rank 1)
    [45515] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_destruction_expert.dds', name = 'Destruction Expert', hide = true }, -- Magicka Restore (Destruction Expert - Rank 2)

    -- Restoration Staff
    
    [30973] = { icon = 'esoui/art/icons/ability_weapon_002.dds' }, -- Essence Drain (Essence Drain -  Rank 1)
    [30978] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds' }, -- Essence Drain (Essence Drain -  Rank 1)
    [45517] = { icon = 'esoui/art/icons/ability_weapon_002.dds' }, -- Essence Drain (Essence Drain -  Rank 2)
    [45518] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds' }, -- Essence Drain (Essence Drain -  Rank 2)
    [30971] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_absorb.dds' }, -- Absorb (Absorb - Rank 1)
    [45522] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_absorb.dds' }, -- Absorb (Absorb - Rank 2)
    
    [30981] = { icon = 'LuiExtended/media/icons/abilities/passive_restorationstaff_restoration_master.dds' }, -- Restoration Master
    [45524] = { icon = 'LuiExtended/media/icons/abilities/passive_restorationstaff_restoration_master.dds' }, -- Restoration Master
    
    ----------------------------------------------------------------
    -- PLAYER ACTIVES WEAPONS --------------------------------------
    ----------------------------------------------------------------
    
    -- 1H + Shield
    [28305] = { name = 'Low Slash' }, -- Low Slash Snare (Low Slash - Rank 1)
    [41389] = { name = 'Low Slash' }, -- Low Slash Snare (Low Slash - Rank 2)
    [41393] = { name = 'Low Slash' }, -- Low Slash Snare (Low Slash - Rank 3)
    [41396] = { name = 'Low Slash' }, -- Low Slash Snare (Low Slash - Rank 4)
    
    [38266] = { name = 'Heroic Slash' }, -- Heroic Slash Snare (Heroic Slash - Rank 1)
    
    -- Dual Wield
    [29293] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = 'Twin Slashes' }, -- Twin Slashes Bleed (Twin Slashes - Rank 1)
    [40660] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = 'Twin Slashes' }, -- Twin Slashes Bleed (Twin Slashes - Rank 2)
    [40663] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = 'Twin Slashes' }, -- Twin Slashes Bleed (Twin Slashes - Rank 3)
    [40666] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = 'Twin Slashes' }, -- Twin Slashes Bleed (Twin Slashes - Rank 4)
    
    [38841] = { icon = 'esoui/art/icons/ability_dualwield_001_a.dds', name = 'Rending Slashes' }, -- Rending Slashes Bleed (Rending Slashes - Rank 1)
    
    [38848] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds', name = 'Blood Craze' }, -- Blood Craze Bleed (Blood Craze - Rank 1)
    
    -----------------------------------------
    -- DESTRUCTION STAFF ACTIVES ------------
    -----------------------------------------
    
    -- Crushing Shock
    [48009] = { icon = 'esoui/art/icons/ability_destructionstaff_001a.dds', name = 'Crushing Shock' }, -- Stagger (Crushing Shock - Rank 1)
    [48011] = { name = 'Crushing Shock' }, -- Uber Attack (Crushing Shock - Rank 1)
    
    -- Force Pulse
    [48016] = { icon = 'esoui/art/icons/ability_destructionstaff_001b.dds' }, -- Force Pulse (Force Pulse - Rank 1)
    
    -- Wall of Elements
    [68719] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_snare_frost.dds' }, -- Frozen (Wall of Elements - All Ranks) -- Frost
    [62928] = { name = 'Wall of Frost' }, -- Wall of Frost Snare (Wall of Elements - Rank 1) -- Frost
    [62933] = { name = 'Wall of Frost' }, -- Unstable Wall of Frost (Wall of Elements - Rank 2) -- Frost
    [62938] = { name = 'Wall of Frost' }, -- Unstable Wall of Frost (Wall of Elements - Rank 3) -- Frost
    [62943] = { name = 'Wall of Frost' }, -- Unstable Wall of Frost (Wall of Elements - Rank 4) -- Frost
    
    [62968] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Wall of Storms (Wall of Elements - Rank 1) -- Lightning
    [62973] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Wall of Storms (Wall of Elements - Rank 2) -- Lightning
    [62978] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Wall of Storms (Wall of Elements - Rank 3) -- Lightning
    [62983] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Wall of Storms (Wall of Elements - Rank 4) -- Lightning
    
    -- Unstable Wall of Elements
    [39077] = { name = 'Off-Balance' }, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 1) -- Lightning
    
    
    -- Elemental Blockade
    [62988] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Blockade of Storms (Elemental Blockade - Rank 1) -- Lightning
    [62948] = { name = 'Blockade of Frost' }, -- Unstable Wall of Frost (Elemental Blockade - Rank 1) -- Frost
    
    -- Destructive Touch
    [62648] = { name = 'Flame Touch' }, -- Fire Touch (Destructive Touch - Rank 1) -- Fire
    [38172] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Touch' }, -- Stun After Knockback Movement (Destructive Touch - Rank 1) -- Fire
    [29075] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Touch' }, -- Fire Touch (destruction) (Destructive Touch - Rank 1) -- Fire
    [30450] = { name = 'Frost Touch' }, -- Deep Freeze (Destructive Touch - Rank 1) -- Frost
    [62659] = { name = 'Flame Touch' }, -- Fire Touch (Destructive Touch - Rank 2) -- Fire
    [62661] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Touch' }, -- Stun After Knockback Movement (Destructive Touch - Rank 2) -- Fire
    [62660] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Touch' }, -- Fire Touch (destruction) (Destructive Touch - Rank 2) -- Fire
    [62693] = { name = 'Frost Touch' }, -- Deep Freeze (Destructive Touch - Rank 2) -- Frost
    [62662] = { name = 'Flame Touch' }, -- Fire Touch (Destructive Touch - Rank 3) -- Fire
    [62664] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Touch' }, -- Stun After Knockback Movement (Destructive Touch - Rank 3) -- Fire
    [62663] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Touch' }, -- Fire Touch (destruction) (Destructive Touch - Rank 3) -- Fire
    [62696] = { name = 'Frost Touch' }, -- Deep Freeze (Destructive Touch - Rank 3) -- Frost
    [62665] = { name = 'Flame Touch' }, -- Fire Touch (Destructive Touch - Rank 4) -- Fire
    [62667] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Touch' }, -- Stun After Knockback Movement (Destructive Touch - Rank 4) -- Fire
    [62666] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Touch' }, -- Fire Touch (destruction) (Destructive Touch - Rank 4) -- Fire
    [62699] = { name = 'Frost Touch' }, -- Deep Freeze (Destructive Touch - Rank 4) -- Frost
    
    [29073] = { hide = true }, -- Flame Touch (Destructive Touch - Rank 1) -- Fire
    [29089] = { hide = true }, -- Shock Touch (Destructive Touch - Rank 1) -- Shock
    [29078] = { hide = true }, -- Frost Touch (Destructive Touch - Rank 1) -- Frost
    [40948] = { hide = true }, -- Flame Touch (Destructive Touch - Rank 2) -- Fire
    [40953] = { hide = true }, -- Shock Touch (Destructive Touch - Rank 2) -- Shock
    [40950] = { hide = true }, -- Frost Touch (Destructive Touch - Rank 2) -- Frost
    [40957] = { hide = true }, -- Flame Touch (Destructive Touch - Rank 3) -- Fire
    [40962] = { hide = true }, -- Shock Touch (Destructive Touch - Rank 3) -- Shock
    [40959] = { hide = true }, -- Frost Touch (Destructive Touch - Rank 3) -- Frost
    [40965] = { hide = true }, -- Flame Touch (Destructive Touch - Rank 4) -- Fire
    [40970] = { hide = true }, -- Shock Touch (Destructive Touch - Rank 4) -- Shock
    [40967] = { hide = true }, -- Frost Touch (Destructive Touch - Rank 4) -- Frost
    
    -- Destructive Clench
    [62668] = { name = 'Flame Clench' }, -- Fire Clench (Destructive Clench - Rank 1) -- Fire
    [38987] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Clench' }, -- Stun After Knockback Movement (Destructive Clench - Rank 1) -- Fire
    [38986] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Clench' }, -- Fire Touch (destruction) (Destructive Clench - Rank 1) -- Fire
    [68635] = { name = 'Shock Clench' }, -- Shock Touch (Destructive Clench - Rank 1) -- Shock
    [62734] = { name = 'Shock Clench' }, -- Shock Clench Explosion (Destructive Clench - Rank 1) -- Shock
    [38990] = { name = 'Frost Clench' }, -- Deep Freeze (Destructive Clench - Rank 1) -- Frost
    
    [38985] = { hide = true }, -- Flame Clench (Destructive Clench - Rank 1) -- Fire
    [38993] = { hide = true }, -- Shock Clench (Destructive Clench - Rank 1) -- Shock
    [38989] = { hide = true }, -- Frost Clench (Destructive Clench - Rank 1) -- Frost
    
    -- Destructive Reach
    [38946] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Reach' }, -- Stun After Knockback Movement (Destructive Reach - Rank 1) -- Fire
    [38945] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = 'Flame Reach' }, -- Flame Reach (destruction) (Destructive Reach - Rank 1) -- Fire
    [68574] = { name = 'Shock Reach' }, -- Shock Touch (Destructive Reach - Rank 1) -- Fire
    [38971] = { name = 'Frost Reach' }, -- Frost Grip (Destructive Reach - Rank 1) -- Frost
    
    [38944] = { hide = true }, -- Flame Reach (Destructive Reach - Rank 1) -- Fire
    [38978] = { hide = true }, -- Shock Reach (Destructive Reach - Rank 1) -- Shock
    [38970] = { hide = true }, -- Frost Reach (Destructive Reach - Rank 1) -- Frost
    
    -- Weakness to Elements
    [53881] = { icon = 'esoui/art/icons/ability_debuff_major_breach.dds', name = 'Major Breach' }, -- Major Spell Shatter (Weakness to Elements - Rank 1)
    [62772] = { icon = 'esoui/art/icons/ability_debuff_major_breach.dds', name = 'Major Breach' }, -- Major Spell Shatter (Weakness to Elements - Rank 2)
    [62773] = { icon = 'esoui/art/icons/ability_debuff_major_breach.dds', name = 'Major Breach' }, -- Major Spell Shatter (Weakness to Elements - Rank 3)
    [62774] = { icon = 'esoui/art/icons/ability_debuff_major_breach.dds', name = 'Major Breach' }, -- Major Spell Shatter (Weakness to Elements - Rank 4)
    
    -- Elemental Susceptibility
    [62775] = { icon = 'esoui/art/icons/ability_debuff_major_breach.dds', name = 'Major Breach' }, -- Major Spell Shatter (Elemental Susceptibility - Rank 1)
    
    -- Elemental Drain
    [62787] = { icon = 'esoui/art/icons/ability_debuff_major_breach.dds', name = 'Major Breach' }, -- Major Spell Shatter (Elemental Drain - Rank 1)
    [39099] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Elemental Drain - Rank 1)
    
    -----------------------------------------
    -- RESTORATION STAFF ACTIVES ------------
    -----------------------------------------
    
    -- Grand Healing
    [28386] = { icon = 'esoui/art/icons/ability_restorationstaff_004.dds' }, -- Grand Healing (Grand Healing - Rank 1)
    [41245] = { icon = 'esoui/art/icons/ability_restorationstaff_004.dds' }, -- Grand Healing (Grand Healing - Rank 2)
    [41247] = { icon = 'esoui/art/icons/ability_restorationstaff_004.dds' }, -- Grand Healing (Grand Healing - Rank 3)
    [41249] = { icon = 'esoui/art/icons/ability_restorationstaff_004.dds' }, -- Grand Healing (Grand Healing - Rank 4)
    
    -- Blessing of Protection
    [37243] = { hide = true }, -- Blessing of Protection (Blessing of Protection - Rank 1)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES ARMOR ---------------------------------------
    ----------------------------------------------------------------
    
    -- Light Armor
    [29668] = { icon = 'esoui/art/icons/passive_armor_001.dds' }, -- Prodigy (Prodigy - Rank 1)
    [45561] = { icon = 'esoui/art/icons/passive_armor_001.dds' }, -- Prodigy (Prodigy - Rank 2)
    
    -- Heavy Armor
    [29825] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 1)
    [45531] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 2)
    [45533] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 3)
    [29769] = { icon = 'esoui/art/icons/ability_armor_013.dds' }, -- Constitution (Constitution - Rank 1)
    [58428] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 1)
    [58503] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 1)
    [45526] = { icon = 'esoui/art/icons/ability_armor_013.dds' }, -- Constitution (Constitution - Rank 2)
    [58430] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 2)
    [58431] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 2)
    [29773] = { icon = 'esoui/art/icons/passive_armor_014.dds' }, -- Revitalize (Revitalize - Rank 1)
    [45528] = { icon = 'esoui/art/icons/passive_armor_014.dds' }, -- Revitalize (Revitalize - Rank 2)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WORLD ---------------------------------------
    ----------------------------------------------------------------

    -- Soul Magic
    [39266] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 1)
    [39267] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 1)
    [39268] = { hide = true }, -- Soul Shatter (Soul Shatter - Rank 1)
    [45583] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 2)
    [45584] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 2)
    [45585] = { hide = true }, -- Soul Shatter (Soul Shatter - Rank 2)
    
    [39269] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_summons.dds' }, -- Soul Summons
    [45590] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_summons.dds' }, -- Soul Summons
    [43752] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_summons.dds', name = 'Soul Summons Cooldown' }, -- Soul Summons
    
    [39263] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_lock.dds' }, -- Soul Lock
    [39264] = { hide = true }, -- Soul Trap (Soul Lock - Rank 1)
    [45580] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_lock.dds' }, -- Soul Lock
    [45582] = { hide = true }, -- Soul Trap (Soul Lock - Rank 2)

    -- Vampire
    [35771] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_1.dds' }, -- Stage 1 Vampirism (Vampire General)
    [35776] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_2.dds' }, -- Stage 2 Vampirism (Vampire General)
    [35783] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_3.dds' }, -- Stage 3 Vampirism (Vampire General)
    [35792] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_4.dds' }, -- Stage 4 Vampirism (Vampire General)
    [33177] = { icon = 'esoui/art/icons/ability_vampire_002.dds' }, -- Feed
    [33182] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = 'Savage Feeding' }, -- Uber Attack (Savage Feeding - Rank 1)
    [33183] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = 'Off-Balance' }, -- Off-Balance Self (Savage Feeding - Rank 2)
    [46047] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = 'Savage Feeding' }, -- Uber Attack (Savage Feeding - Rank 1)
    [46046] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = 'Off-Balance' }, -- Off-Balance Self (Savage Feeding - Rank 2)
    [40349] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_ritual.dds', name = 'Blood Ritual' }, -- Feed (Blood Ritual - Rank 1)
    [40351] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_ritual.dds', name = 'Blood Ritual' }, -- Feed (Blood Ritual - Rank 1)
    [40353] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = 'Blood Ritual' }, -- Uber Attack (Blood Ritual - Rank 1)
    
    [40359] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_ritual.dds', name = 'Blood Ritual Cooldown' }, -- Fed on Ally (Blood Ritual)
    [40360] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_noxiphilic_sanguivoria.dds', name = 'Noxiphilic Sanguivoria' }, -- Vampirism (Blood Ritual)

    -- Werewolf
    
    [33208] = { hide = true }, -- Devour (Devour - Rank 1)
    
    [35658] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_lycanthrophy.dds' }, -- Lycanthrophy
    [32464] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }, -- Light Attack
    [89146] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackbleed.dds', name = 'Light Attack Bleed' }, -- Werewolf Bleed
    [32479] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackmedium.dds', name = 'Medium Attack' }, -- Heavy Attack
    [32480] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = 'Heavy Attack' }, -- Heavy Attack Werewolf
    [32494] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Heavy Attack
    [60773] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackrestore.dds', name = 'Heavy Attack' }, -- Stamina Return
    [33209] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Devour - Rank 1)
    
    [40525] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_bloodmoon.dds', name = 'Bloodmoon Cooldown' }, -- Bit an Ally (Blood Moon)
    [40521] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_sanies_lupinus.dds' }, -- Sanies Lupinus (Blood Moon)
    
    

    ----------------------------------------------------------------
    -- PLAYER PASSIVES GUILDS --------------------------------------
    ----------------------------------------------------------------

    -- Dark Brotherhood
    [76325] = { icon = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds' }, -- Blade of Woe
    [79623] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 1) (Blade of Woe Kill)
    [79624] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 2) (Blade of Woe Kill)
    [79625] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 3) (Blade of Woe Kill)
    [79877] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 4) (Blade of Woe Kill)
    [80392] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 1) (Normal Kill)
    [80394] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 2) (Normal Kill)
    [80396] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 3) (Normal Kill)
    [80398] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 4) (Normal Kill)

    -- Fighters Guild
    [29062] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_intimidating_presence.dds' },
    
    [35803] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    [45595] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    [45596] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    
    [35800] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 1)
    [35801] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 1)
    [45597] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45598] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45599] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 3)
    [45600] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 3)
    
    [40393] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_skilled_tracker.dds' },
    
    [35804] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_bounty_hunter.dds' },
    
    -- Mages Guild
    [29061] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_persuasive_will.dds' }, -- Persuasive Will
    
    [40436] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_mage_adept.dds' },
    [45601] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_mage_adept.dds' },
    
    [40437] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_everlasting_magic.dds' },
    [45602] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_everlasting_magic.dds' },
    
    [40438] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_magicka_controller.dds' },
    [45603] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_magicka_controller.dds' },
    
    [43561] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_might_of_the_guild.dds' },
    [45607] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_might_of_the_guild.dds' },
    

    -- Undaunted
    [55584] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 1)
    [55606] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 1)
    [55607] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = 'Undaunted Command' }, -- Undaunted Command Magicka Rest (Undaunted Command - Rank 1)
    [55608] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = 'Undaunted Command' }, -- Undaunted Command Stamina Rest (Undaunted Command - Rank 1)
    [55676] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 2)
    [55677] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 2)
    [55678] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = 'Undaunted Command' }, -- Undaunted Command Stamina Rest (Undaunted Command - Rank 2)
    [55679] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = 'Undaunted Command' }, -- Undaunted Command Magicka Rest (Undaunted Command - Rank 2)
    
    [55366] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_mettle.dds' }, -- Undaunted Mettle (Undaunted Mettle - Rank 1)
    [55386] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_mettle.dds' }, -- Undaunted Mettle (Undaunted Mettle - Rank 2)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES ALLIANCE WAR --------------------------------
    ----------------------------------------------------------------

    [39248] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 1)
    [39249] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 1)
    [45614] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 2)
    [45617] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 2)
    
    [39254] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_reach.dds' }, -- Reach
    [45621] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_reach.dds' }, -- Reach

    [39252] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 1)
    [39253] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 1)
    [45619] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 2)
    [45620] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 2)
    
    [39255] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_magicka_aid.dds' }, -- Magicka Aid
    [45622] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_magicka_aid.dds' }, -- Magicka Aid
    
    [39259] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_medic.dds' }, -- Combat Medic
    [45624] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_medic.dds' }, -- Combat Medic
    
    [39261] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_battle_resurrection.dds' }, -- Battle Resurrection
    [45625] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_battle_resurrection.dds' }, -- Battle Resurrection

    ----------------------------------------------------------------
    -- PLAYER PASSIVES RACIAL --------------------------------------
    ----------------------------------------------------------------
    
    [36247] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_opportunist.dds' }, -- Opportunist
    
    [35995] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus 
    [45259] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus 
    [45260] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus 
    
    [36266] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance
    [45261] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance
    [45262] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance
    
    [36303] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery
    [45263] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery
    [45264] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery
    
    [33293] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_craftsman.dds' }, -- Craftsman
    
    [33301] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny
    [45307] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny
    [45309] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny
    
    
    [84668] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching
    [84670] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching
    [84672] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching
    
    [33304] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior
    [45311] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior
    [45312] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior
    
    [84680] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_wayfarer.dds' }, -- Wayfarer
    
    [36009] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Exhilaration
    [45277] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Exhilaration
    [45278] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Exhilaration
    
    [36153] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning
    [45279] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning
    [45280] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning
    
    [36546] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush
    [45313] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush
    [45315] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush
    
    [35965] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_highborn.dds' }, -- Highborn
    
    [35993] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spellcharge.dds' }, -- Spellcharge
    [45273] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spellcharge.dds' }, -- Spellcharge
    [45274] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spellcharge.dds' }, -- Spellcharge
    
    [35998] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent
    [45275] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent
    [45276] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent
    
    [36008] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_acrobat.dds' }, -- Acrobat
    
    [64279] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance
    [64280] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance
    [64281] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance
    
    [36011] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction
    [45317] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction
    [45319] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction
    
    [36022] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stealthy.dds' }, -- Stealthy
    [45295] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stealthy.dds' }, -- Stealthy
    [45296] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stealthy.dds' }, -- Stealthy
    
    [36063] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_cutpurse.dds' }, -- Cutpurse
    
    [70386] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble
    [70388] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble
    [70390] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble
    
    [36067] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage
    [45299] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage
    [45301] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage
    
    [36582] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_amphibian.dds' }, -- Amphibian
    
    [36568] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful
    [45243] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful
    [45247] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful
    
    [36583] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Rsistance
    [45253] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Rsistance
    [45255] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Rsistance
    
    [36585] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend
    [45257] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend
    [45258] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend
    
    [36588] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_ashlander.dds' }, -- Ashlander
    
    [36591] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic
    [45265] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic
    [45267] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic
    
    [36593] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame
    [45269] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame
    [45270] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame
    
    [36598] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry
    [45271] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry
    [45272] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry
    
    [36626] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_reveler.dds' }, -- Reveler
    
    [36064] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart
    [45297] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart
    [45298] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart
    
    [36627] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost
    [45303] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost
    [45304] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost
    
    [36628] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged
    [45305] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged
    [45306] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged
    
    [36312] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_diplomat.dds' }, -- Diplomat
    
    [50903] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough
    [50906] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough
    [50907] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough
    
    [36155] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds', hide = true }, -- Red Diamond
    [45291] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds', hide = true }, -- Red Diamond
    [45293] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds', hide = true }, -- Red Diamond
    
    [36548] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds', hide = true }, -- Adrenaline Rush (Adrenaline Rush - Rank 1)
    [45314] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds', hide = true }, -- Adrenaline Rush (Adrenaline Rush - Rank 2)
    [45316] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds', hide = true }, -- Adrenaline Rush (Adrenaline Rush - Rank 3)

    [63694] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63695] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63696] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63697] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63698] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63699] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63701] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)
    [63702] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)
    [63703] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)

    [36214] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds', name = 'Red Diamond' }, -- Star of the West (Red Diamond - Rank 1)
    [45292] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds', name = 'Red Diamond' }, -- Star of the West (Red Diamond - Rank 2)
    [45294] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds', name = 'Red Diamond' }, -- Star of the West (Red Diamond - Rank 3)

    -- TRAPS
    [88480] = { hide = true }, -- Trap Triggerer (Various)
    
    [44029] = { icon = 'LuiExtended/media/icons/abilities/ability_slaughterfish.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Slaughterfish Attack (Environmental)
    [21941] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spike Trap Snare (Spike Trap)
    [21942] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Trap Sprung (Spike Trap)
    [21943] = { hide = true }, -- Spike Trap (Spike Trap) (Damage Component)
    [26530] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Bear Trap (Bear Trap)
    [65854] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spike Trap Snare (Spike Trap) (Orsinium - To Save a Chief)
    [65855] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Trap Sprung (Spike Trap) (Orsinium - To Save a Chief)
    [65856] = { hide = true }, -- Spike Trap (Spike Trap) (Orsinium - To Save a Chief)
    [20259] = { name = 'Sigil of Frost', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Sigil of Frost Snare (Sigil of Frost - Wrothgar - Coldwind's Den)
    [73103] = { hide = true }, -- Lava (Orsinium - The Hand of Morkul) (Lava)
    
    -- New Listing
    [73095] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = 'Lava' }, -- In Lava (Vvardenfell - Nchuleftingth - Public Dungeon)
    [11338] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = 'Lava' }, -- In Lava (Various)
    
    [89481] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Flame Jet (Vvardenfell -- An Armiger's Duty)
    [88403] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Flame Jet (Vvardenfell -- Ancestral Adversity)
    [88491] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Searing Flame (Vvardenfell -- Ancestral Adversity)
    [88510] = { name = 'Stagger', hide = true }, -- Staggered (Vvardenfell -- Ancestral Adversity)
    
    [88411] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88413] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88405] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88406] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [89663] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [89664] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88404] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    [88454] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    [88455] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    
    [87348] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser' }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87349] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser' }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87350] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', unbreakable = 1 }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    
    [92150] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_dwarven_furnace.dds', name = 'Dwarven Furnace', hide = true }, -- Dwarven Furnace (Vvardenfell -- Divine Intervention)

    ----------------------------------------------------------------
    -- JUSTICE NPCS ------------------------------------------------
    ----------------------------------------------------------------
    
    [63153] = { hide = true }, -- Guard Immunities (Justice Guard)
    [63174] = { hide = true }, -- Guard Speed Boost (Justice Guard)
    
    [63148] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds' }, -- Major Defile (Justice Guard)
    [63095] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike.dds' }, -- Focused Strike (Justice Guard)
    
    [63157] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = 'Heavy Blow' }, -- Heavy Blow (Justice Guard)
    [63268] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = 'Heavy Blow' }, -- Uppercut (Justice Guard)
    [63160] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = 'Heavy Blow' }, -- Heavy Blow Knockdown (Justice Guard)
    
    [63261] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = 'Heavy Blow' }, -- Heavy Blow (Justice Guard)
    [63265] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = 'Heavy Blow' }, -- Uppercut (Justice Guard)
    [63263] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = 'Heavy Blow' }, -- Heavy Blow Knockdown (Justice Guard)
    
    [63093] = { name = 'Shield Charge' }, -- Charge (Justice Guard 1H)
    [63259] = { name = 'Mighty Charge' }, -- Charge (Justice Guard 2H)
    [63260] = { icon = 'esoui/art/icons/ability_2handed_003.dds', name = 'Mighty Charge' }, -- Charge (Justice Guard 2H)
    
    [63198] = { name = 'Fiery Grip' }, -- Fiery Chain (Justice Guard)
    [63200] = { name = 'Fiery Grip' }, -- Firey Chain (Justice Guard)
    
    [64139] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_piercing_bolt.dds' }, -- Piercing Bolt (Justice Guard)
    [64267] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_shot.dds' }, -- Piercing Bolt (Justice Guard)
    
    [63911] = { hide = true }, -- Guard Stacking Damage
    
    [78804] = { hide = true }, -- Seek
    [78802] = { hide = true }, -- Seek
    [78760] = { hide = true }, -- Confusion
    [78764] = { hide = true }, -- Confusion
    [78775] = { hide = true }, -- Confusion
    [78767] = { hide = true }, -- Confusion
    [78768] = { hide = true }, -- Confusion
    [78769] = { hide = true }, -- Confusion
    [78770] = { hide = true }, -- Confusion
    [78766] = { hide = true }, -- Confusion
    [78772] = { hide = true }, -- Confusion
    [78771] = { hide = true }, -- Confusion
    
    [63179] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = 'Stonefist' }, -- Flame Shard (Justice Guard 2H)
    [63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = 'Stonefist' }, -- Flame Shard (Justice Guard 2H)
    
    [78743] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds' }, -- Revealed (Guard)
    [78789] = { hide = true }, -- Flare (Guard)
    [78750] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds' }, -- Revealed (Guard)
    [78744] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flare_trap.dds' }, -- Flare (Guard)
     
    [75613] = { hide = true }, -- Shadowcloak Immunity (Mage Guard)
    [77919] = { hide = true }, -- Clairvoyance Tutorial (Mage Guard)
    [77937] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds', name = 'Detection' }, -- Clairvoyance (Mage Guard)
    [77941] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1 }, -- Revealed (Mage Guard)
    
    [77917] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_empower_weapon_flame.dds' }, -- Empower Weapon: Flame (Mage Guard)
    [74502] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    [74503] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    [74504] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    
    [74862] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_teleport_trap.dds' }, -- Teleport Trap (Mage Guard)
    [74870] = { hide = true }, -- Teleport Trap (Mage Guard)
    [74864] = { hide = true }, -- Teleport Trap (Mage Guard)
    [74863] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_teleport_trap.dds' }, -- Teleport Trap (Mage Guard)

    [77449] = { hide = true }, -- Clairvoyance Tutorial (Mage Guard - Instanced)
    [72694] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds', name = 'Detection' }, -- Clairvoyance (Mage Guard - Instanced)
    [72695] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1 }, -- Revealed (Mage Guard - Instanced)
    [78060] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Revealed (Mage Guard - Instanced)
    [75809] = { hide = true }, -- Guard Speed Boost (Mage Guard - Instanced)
    
    [64647] = { hide = true }, -- Remove Effects (Guard)
    
    
    [73226] = { hide = true }, -- Hurried Ward (DB Guard)
    
    [77452] = { hide = true }, -- Shadow Cloak Immunity (Basic Justice NPC)
    [78012] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Basic Justice NPC)
    [62472] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_stab.dds' }, -- Stab (Justice Rogue)
    [62506] = { icon = 'esoui/art/icons/ability_dualwield_deadlycloak.dds', name = 'Dagger Toss', hide = true }, -- Thrown Dagger (Justice Rogue)
    
    [62408] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bound_weapon.dds' }, -- Bound Weapon (Justice Mage)
    [62502] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds' }, -- Fiery Wind (Justice Mage)
    [62407] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', hide = true }, -- Fiery Touch (Justice Mage)
    [63828] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Fiery Touch (Justice Mage)
    
    [78265] = { hide = true }, -- Alarm (Estate Marshal - DB)
    [78266] = { hide = true }, -- Alarm (Estate Marshal - DB)
    
    [52471] = { hide = true }, -- Nullify (Estate Spellbreaker - DB)
    [52474] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_nullify.dds' }, -- Nullify (Estate Spellbreaker - DB)
    [66669] = { hide = true }, -- Nullify (Estate Spellbreaker - DB)
    
    [73229] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_hurried_ward.dds' }, -- Hurried Ward (Mage Guard - DB)
    
    -- TRAPS & INTERACTABLES
    
    [72711] = { hide = true }, -- Hidden (Hiding Spot)
    [77335] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77336] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77337] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77338] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77339] = { hide = true }, -- Threat Drop (Hiding Spot)
    [75747] = { hide = true }, -- Hiding Spot (Hiding Spot)
    
    ----------------------------------------------------------------
    -- NPC(Basic) --------------------------------------------------
    ----------------------------------------------------------------

    -- SHARED NPC PASSIVES
    [33097] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = 'CC Immunity' }, -- Scary Immunities
    [44176] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_flying_immunities.dds', name = 'Flying Immunity' }, -- Flying Immunities
    [13739] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_backstabber.dds' }, -- Backstabber
    
    [67950] = { hide = true }, -- CC Immunity Plus
    [88283] = { hide = true }, -- No Call Ally (is Ally)
    [88289] = { hide = true }, -- No Call Ally (Failed)
    [89175] = { hide = true }, -- No Call Ally 1:1 Ally Tracker
    
    -- FRIENDLY NPC's
    [42905] = { name = 'Recovering' }, -- Recover

    -- SHARED NPC ACTIVE EVENTS
    [8239] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hamstrung.dds', name = 'Hamstring' }, -- Hamstrung

    -- SHARED NPC MISC
    [38117] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds' }, -- CC Immunity
    [57832] = { hide = true }, -- CC Immunity Knock Back
    [28301] = { hide = true }, -- Ability CC Immunity (Trigger to apply 38117 on player)
    
    -- Standard NPC ABILITIES
    [2874] = { name = 'Stagger' }, -- Staggered (Generic Stagger applied to player by many different NPC abilities)
    
    -- Criter Events
    [79544] = { hide = true }, -- Mischievous Dodge (Nixad)
    
    -- FRIENDLY NPC's
    [42905] = { icon = 'esoui/art/icons/ability_debuff_stun.dds' }, -- Recover
    [42937] = { hide = true }, -- TargetPriorityException

    -- HUMAN NPC ABILITIES
    [31813] = { hide = true }, -- Run Away! (NPC runs away from player - Shows as buff on NPC)
    [18386] = { hide = true }, -- Run Away! (Used by various creatures)
    
    [10618] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Shared Human NPC)
    [12437] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', hide = true }, -- Quick Shot (Shared Human NPC)
    [12456] = { icon = 'esoui/art/icons/ability_mage_009.dds', hide = true }, -- Ice Arrow (Shared Human NPC)
    [10639] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', hide = true }, -- Flare (Shared Human NPC)
    [39060] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Bear Trap (Shared Human NPC)
    [39065] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }, -- Bear Trap (Shared Human NPC)

    [10648] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_oil.dds' }, -- Throw Oil (Synergy)
    [11039] = { hide = true }, -- Spread Out Sound (Synergy)
    [10650] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_oil_drenched.dds' }, -- Oil Drenched (Synergy)
    [14068] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy - Archer)
    [10813] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy - Fire Mage)
    [38260] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy - Fire Mage)

    [14096] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Footsoldier)
    [28499] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', hide = true }, -- Throw Dagger (Footsoldier)
    [28502] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds' }, -- Throw Dagger (Footsoldier)
    [28504] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds' }, -- Throw Dagger (Footsoldier)

    [29400] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Guard)
    [29401] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Guard)
    [29402] = { icon = 'esoui/art/icons/ability_1handed_005.dds', hide = true }, -- Power Bash (Guard)
    [29761] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = 'Block', duration = 0 }, -- Brace (Guard)
    [29765] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun', hide = true }, -- Uber Attack (Guard)
    [84346] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun' }, -- Uber Attack (Guard)
    [29762] = { hide = true }, -- Blocked Stack (Guard)
    [29757] = { hide = true }, -- Remove block (Guard)
    [29766] = { hide = true }, -- Blocked Stack (Guard)

    [48542] = { icon = 'esoui/art/icons/ability_warrior_011.dds', hide = true }, -- Focused Charge (Brute)
    [14924] = { hide = true }, -- Focused Charge (Brute)
    [14925] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = 'Focused Charge' }, -- Charge (Brute)
    [14926] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = 'Focused Charge' }, -- Charge (Brute)
    -- In case auras are added, setup for self stuns:
    [14930] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun' , hide = true},
    [14923] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun' , hide = true},
    -- End Charge Stun Setup

    [29378] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = 'Dizzying Swing' }, -- Uppercut (Ravager)
    [29379] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = 'Dizzying Swing' }, -- Uppercut (Ravager)
    [29380] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = 'Dizzying Swing', hide = true }, -- Uppercut (Ravager)

    [29035] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Rogue/Skirmisher)
    [12381] = { icon = 'esoui/art/icons/ability_rogue_063.dds' }, -- Assassinate (Rogue/Skirmisher)

    [35164] = { hide = true }, -- Agony (Pointless projectile travel time aura)
    [10735] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [49252] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [49253] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [49254] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [44206] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds' }, -- Minor Maim (Berserker)
    
    [34742] = { icon = 'esoui/art/icons/ability_dragonknight_004.dds' }, -- Fiery Breath (Dragonknight)
    [34647] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = 'Off-Balance' }, -- Lava Whip (Dragonknight)
    [74472] = { icon = 'esoui/art/icons/ability_dragonknight_010.dds' }, -- Dark Talons (Dragonknight)
    
    [44227] = { icon = 'esoui/art/icons/ability_dragonknight_006.dds'}, -- Dragonknight Standard (Dragonknight - Elite)
    [44229] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', duration = 0 }, -- Major Defile (Dragonknight - Elite)
    
    [52041] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)
    [52045] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)
    [52051] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)

    [29510] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul)
    [29511] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul)
    [17867] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_aura.dds' }, -- Shock Aura (Thundermaul)
    [44408] = { icon = 'esoui/art/icons/ability_sorcerer_lightning_form.dds' }, -- Lightning Form (Thundermaul)

    [73712] = { hide = true }, -- Shadow Cloak (Nightblade NPC) (Pointless .5 second aura applied on player)
    [73713] = { icon = 'esoui/art/icons/ability_nightblade_004.dds' }, -- Shadow Cloak (Nightblade)
    [36471] = { icon = 'esoui/art/icons/ability_nightblade_002.dds' }, -- Veiled Strike (Nightblade)
    [63822] = { icon = 'esoui/art/icons/ability_nightblade_008.dds' }, -- Teleport Strike (Nightblade)
    [44345] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds', hide = true }, -- Soul Tether (Nightblade - Elite)
    [44349] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Nightblade - Elite)
    [44352] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Nightblade - Elite)
    [44350] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Nightblade - Elite)
    [53462] = { icon = 'esoui/art/icons/ability_nightblade_003_a.dds', name = 'Leeching Strikes' }, -- Siphoning Strikes (Nightblade - Elite)

    [37109] = { icon = 'esoui/art/icons/ability_bow_005.dds' }, -- Arrow Spray (Archer)
    [28628] = { icon = 'esoui/art/icons/ability_bow_003.dds' }, -- Volley (Archer)
    [74978] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_taking_aim.dds', hide = true }, -- Taking Aim (Archer)
    [74980] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_taking_aim.dds' }, -- Taking Aim (Archer)

    [89460] = { hide = true }, -- Set Area (Pet Ranger)
    [36499] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_roll_dodge.dds' }, -- Roll Dodge (Pet Ranger)
    [44301] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = 'Lightweight Beast Trap' }, -- Trap Beast (Pet Ranger)
    [44305] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = 'Lightweight Beast Trap' }, -- Trap Beast (Pet Ranger)
    [44307] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = 'Lightweight Beast Trap' }, -- Trap Beast (Pet Ranger)
    [88251] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally.dds' }, -- Call Ally (Pet Ranger)
    [89425] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_kwama.dds' }, -- Call Ally (Pet Ranger)
    [88281] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = 'Weakness', duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Call Ally (Pet Ranger)
    [88227] = { hide = true }, -- Call Ally (Pet Ranger)
    [88252] = { hide = true }, -- Call Ally (Pet Ranger)
    
    [15164] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds'}, -- Heat Wave (Fire Mage)
    [16588] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds', hide = true }, -- Heat Wave (Fire Mage)
    [47095] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_runes.dds', name = 'Fire Runes'}, -- Fire Rune (Fire Mage)
    [47102] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_runes.dds', name = 'Fire Runes' }, -- Fire Rune (Fire Mage)

    [14524] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_ranged.dds', hide = true }, -- Shock (Storm Mage)
    [29471] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_thrall.dds' }, -- Thunder Thrall (Storm Mage)
    [29470] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_thrall.dds' }, -- Thunder Thrall (Storm Mage)
    [29472] = { hide = true }, -- Thunder Thrall (Storm Mage) (self snare shows as buff)

    [12459] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    [12460] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    [14550] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    [14194] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_barrier.dds' }, -- Ice Barrier (Frost Mage)
    [7145] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_barrier.dds', name = 'Ice Barrier Chill' }, -- Ice Barrier (Frost Mage)

    [35151] = { icon = 'esoui/art/icons/ability_mage_064.dds' }, -- Spell Absorption (Spirit Mage)
    [14472] = { icon = 'esoui/art/icons/ability_mage_004.dds' }, -- Burdening Eye (Spirit Mage)
    [37200] = { icon = 'esoui/art/icons/ability_mage_004.dds' }, -- Burden (Spirit Mage)
    [35142] = { icon = 'esoui/art/icons/ability_mage_004.dds' }, -- Burden (Spirit Mage)
    [89057] = { hide = true }, -- Burdening Eye (Spirit Mage)
    [89042] = { hide = true }, -- Burdening Eye (Spirit Mage)
    [14477] = { hide = true }, -- Burdening (Spirit Mage)
    [73768] = { hide = true }, -- GEN 5 Hits (Pointless to display)
    [35149] = { hide = true }, -- Burdening Eye (Spirit Mage)

    [37150] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Battlemage)
    [37028] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = 'Staff Strike' }, -- Quick Strike (Battlemage)
    [37029] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = 'Staff Strike' }, -- Quick Strike (Battlemage)
    [37030] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = 'Staff Strike' }, -- Quick Strike (Battlemage)
    [37021] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_empower_weapon_flame.dds' }, -- Empower Weapon: Flame (Battlemage)
    [37087] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
    [37156] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
    [37129] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds' }, -- Ice Cage (Battlemage)
    [37131] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds' }, -- Ice Cage (Battlemage)
    [37132] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds' }, -- Ice Cage (Battlemage)
    [44216] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds' }, -- Negate Magic (Battlemage)
    [50108] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds' }, -- Negate Magic (Battlemage)

    [37126] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds' }, -- Entropic Flare (Timb Bomb Mage)
    [36986] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds' }, -- Void (Time Bomb Mage)
    [14370] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds' }, -- Void (Time Bomb Mage)

    [56828] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force.dds', hide = true }, -- Fright Force (Fear Mage)
    [14350] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror.dds', hide = true }, -- Aspect of Terror (Fear Mage)
    [37084] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror.dds' }, -- Aspect of Terror (Fear Mage)
    [35865] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_vanish.dds', name = 'Vanish' }, -- Shadow Cloak (Fear Mage)
    [35850] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_vanish.dds', name = 'Vanish' }, -- Shadow Cloak (Fear Mage)

    [44247] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89005] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89008] = { hide = true }, -- Dark Shade (Dreadweaver)
    [39729] = { hide = true }, -- TargetPriorityException (Dreadweaver)
    [44250] = { hide = true }, -- Dark Shade (Dreadweaver)
    
    [89017] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = 'Weakness', duration = -23, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dark Shade (Dreadweaver)
    [89010] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds' }, -- Corrode (Dreadweaver)
    [89012] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds' }, -- Minor Maim (Dreadweaver)

    [44323] = { icon = 'esoui/art/icons/ability_armor_003_a.dds' }, -- Dampen Magic (Soulbrander)
    [44258] = { icon = 'esoui/art/icons/ability_mageguild_002_a.dds' }, -- Radiant Magelight (Soulbrander)
    [44259] = { name = 'Radiant Magelight', hide = true }, -- Magelight (Soulbrander)
    [44263] = { hide = true }, -- Radiant Magelight (Soulbrander)

    [29372] = { icon = 'esoui/art/icons/ability_mage_027.dds', hide = true }, -- Necrotic Spear (Necromancer)
    [88554] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_the_dead.dds' }, -- Summon the Dead (Necromancer)
    [88555] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_the_dead.dds' }, -- Summon the Dead (Necromancer)
    [88561] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = 'Weakness', duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon the Dead (Necromancer)
    [13397] = { icon = 'esoui/art/icons/achievement_update15_030.dds' }, -- Empower Undead (Necromancer)
    [43757] = { hide = true }, -- Cultist Synergy Cast (Applied on summoned ghost }, no point in displaying)
    [31848] = { hide = true }, -- Summon the Dead (Necromancer)
    [88582] = { hide = true }, -- Summon the Dead (Necromancer)
    [88583] = { hide = true }, -- Summon the Dead (Necromancer)
    [88586] = { hide = true }, -- Summon the Dead (Necromancer)
    
    [88600] = { hide = true }, -- Summon the Dead (Necromancer)
    [88602] = { hide = true }, -- Summon the Dead (Necromancer)
    [88618] = { hide = true }, -- Summon the Dead (Necromancer)
    [88611] = { hide = true }, -- Summon the Dead (Necromancer)
    [88621] = { hide = true }, -- Summon the Dead (Necromancer)
    [88622] = { hide = true }, -- Summon the Dead (Necromancer)
    [88601] = { hide = true }, -- Summon the Dead (Necromancer)
    [88593] = { hide = true }, -- Summon the Dead (Necromancer)
    [88617] = { hide = true }, -- Summon the Dead (Necromancer)
    [88596] = { hide = true }, -- Summon the Dead (Necromancer)    
    [88566] = { hide = true }, -- Summon the Dead (Necromancer)

    [7590] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_entropic_bolt.dds', hide = true }, -- Entropic Bolt (Bonelord)
    [35387] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Bone Cage (Bonelord)
    [88322] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Bone Cage (Bonelord)
    [35391] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds', name = 'Bone Cage' }, -- Defiled Grave (Bonelord)
    [88504] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = 'Weakness', duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon Abomination (Bonelord)
    [88507] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_abomination.dds' }, -- Summon Abomination (Bonelord)
    [44339] = { icon = 'esoui/art/icons/ability_undaunted_005a.dds' }, -- Bone Surge (Bonelord)
    [35384] = { hide = true }, -- Summon Abomination (Bonelord)
    [88522] = { hide = true }, -- Summon Abomination (Bonelord)
    [88526] = { hide = true }, -- Summon Abomination (Bonelord)

    [79803] = { hide = true }, -- Covetous Return (Healer) (Passive on healer that doesn't seem to do anything)
    [10601] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_minor_wound.dds', hide = true }, -- Minor Wound (Healer)
    [57534] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (Healer)
    [57537] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (Healer)
    [57538] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (Healer)
    
    [50966] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_healer_immune.dds', name = 'Defensive Ward' }, -- Healer Immune (Healer)
    [50931] = { hide = true }, -- Healer Immune (Healer)
    [50975] = { hide = true }, -- Healer Immune (Healer)
    [50998] = { hide = true }, -- Rite of Passage (Healer)
    
    [44328] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds' }, -- Rite of Passage (Healer)
    [44329] = { hide = true }, -- Rite of Passage (Healer)

    [29669] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_coiled_lash.dds', hide = true }, -- Coiled Lash (Shaman)
    [29520] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_aura_of_protection.dds' }, -- Aura of Protection (Shaman)
    [29521] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_aura_of_protection.dds' }, -- Aura of Protection (Shaman)
    [29597] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Combustion (Shaman)
    [29598] = { name = 'Off-Balance' }, -- Off Balance (Shaman)
    [65314] = { hide = true }, -- Aura of Protection (Redundant)
    [65432] = { hide = true }, -- Aura of Protection (Redundant)
    [83073] = { hide = true }, -- Summon Died (Shaman)

    [68866] = { icon = 'esoui/art/icons/ability_ava_003.dds' }, -- Warhorn (Faction NPCs)
    [68867] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [68868] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [68869] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [43644] = { hide = true }, -- Barrier [monster synergy]
    [38118] = { icon = 'esoui/art/icons/ability_ava_001.dds' }, -- Caltrops  (Faction NPCs)
    [38119] = { icon = 'esoui/art/icons/ability_ava_001.dds', duration = 0 }, -- Caltrops  (Faction NPCs)
    [38125] = { icon = 'esoui/art/icons/ability_ava_001.dds' }, -- Caltrops  (Faction NPCs)

    [65033] = { icon = 'esoui/art/icons/ability_warrior_014.dds', hide = true }, -- Retaliation (Winterborn Warrior)
    [69158] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = 'Block', duration = 0 }, -- Retaliation (Winterborn Warrior)
    [67114] = { icon = 'esoui/art/icons/ability_warrior_014.dds' }, -- Retaliation (Winterborn Warrior)
    [69157] = { icon = 'esoui/art/icons/ability_warrior_014.dds', hide = true }, -- Retaliation (Winterborn Warrior)
    [69153] = { icon = 'esoui/art/icons/ability_warrior_014.dds' }, -- Retaliation (Winterborn Warrior)
    [1347] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds' }, -- Off-Balance (Winterborn Warrior)
    [70070] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = 'Heavy Attack' }, -- Heavy Strike (Winterborn Warrior)
    [64980] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_javelin.dds', hide = true }, -- Javelin (Winterborn Warrior)
    [14883] = { hide = true }, -- Off-Balance (Winterborn Warrior)
    [69282] = { hide = true }, -- Roll Dodge Back (Winterborn Warrior)

    [54593] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Winterborn Mage)
    [55909] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (Winterborn Mage)
    [55911] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (Winterborn Mage)
    [55918] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (Winterborn Mage)
    [55916] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vineburst.dds' }, -- Grasping Vineburst (Winterborn Mage)
    [64704] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds', hide = true }, -- Flames (Winterborn Mage)
    [64711] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds', hide = true }, -- Flames (Winterborn Mage)

    [53987] = { icon = 'esoui/art/icons/ability_buff_minor_brutality.dds', name = 'Minor Brutality' }, -- Rally (Vosh Rakh Devoted)
    [65235] = { icon = 'esoui/art/icons/ability_warrior_025.dds' }, -- Enrage (Vosh Rakh Devoted)
    [54027] = { icon = 'esoui/art/icons/ability_warrior_032.dds' }, -- Divine Leap (Vosh Rakh Devoted)
    [67272] = { hide = true }, -- Invisible No Target (Vosh Rakh Devoted)
    [54028] = { icon = 'esoui/art/icons/ability_warrior_032.dds' }, -- Divine Leap (Vosh Rakh Devoted)
    [67593] = { icon = 'esoui/art/icons/ability_warrior_032.dds', name = 'Divine Leap', hide = true }, -- Divine Leap Stagger (Vosh Rakh Devoted)
    [54050] = { icon = 'esoui/art/icons/ability_warrior_032.dds', name = 'Divine Leap', hide = true }, -- Divine Leap Stun (Vosh Rakh Devoted)
    [54184] = { hide = true }, -- Revenge 2 (Vosh Rakh Devoted)
    [54397] = { hide = true }, -- Rally (Vosh Rakh Devoted)

    [51000] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_cleave_stance.dds'}, -- Cleave Stance (Dremora Caitiff)
    [51923] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = 'Great Cleave' }, -- Cleave Stance (Dremora Caitiff)
    [51940] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = 'Great Cleave' }, -- Cleave Stance (Dremora Caitiff)
    [51942] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = 'Great Cleave' }, -- Cleave Stance (Dremora Caitiff)

    [74480] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', hide = true }, -- Fiery Grip (Sentinel) (TG DLC)
    [74483] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds' }, -- Fiery Grip (Sentinel) (TG DLC)
    [72725] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = 'Enrage' }, -- Fool Me Once (TG DLC)
    [72723] = { hide = true }, -- Fool Me Once (Sentinel) (TG DLC)
    [77468] = { hide = true }, -- Fool Me Once (Sentinel) (TG DLC)
    
    [72716] = { icon = 'esoui/art/icons/ability_rogue_015.dds' }, -- Uncanny Dodge (Archer) (TG DLC)
    [72214] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds' }, -- Poisoned Arrow (Archer) (TG DLC)
    [72217] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds' }, -- Poisoned Arrow (Archer) (TG DLC)
    [72222] = { icon = 'esoui/art/icons/ability_rogue_067.dds', name = 'Hide in Shadows' }, -- Shadow Cloak (Archer) (TG DLC)
    [76089] = { icon = 'esoui/art/icons/ability_bow_001.dds', hide = true }, -- Snipe (Archer) (TG DLC)
    [72220] = { icon = 'esoui/art/icons/ability_bow_001.dds', hide = true }, -- Snipe (Archer) (TG DLC)
    [74619] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flare_trap.dds', hide = true }, -- Flare Trap (Archer) (TG DLC)
    [74621] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Revealed (Archer) (TG DLC)
    [74630] = { hide = true }, -- Flare Trap Proxy (Archer) (TG DLC)
    [72719] = { hide = true }, -- Uncanny Dodge SUC REM (Archer) (TG DLC)
    
    [74618] = { hide = true }, -- Flare Trap
    [74627] = { hide = true }, -- Flare Trap

    [77472] = { icon = 'esoui/art/icons/ability_warrior_030.dds' }, -- 'Til Death (Bodyguard) (DB DLC)
    [79523] = { icon = 'esoui/art/icons/ability_warrior_030.dds' }, -- 'Til Death (Bodyguard) (DB DLC)
    [77554] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77555] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', duration = 863700 }, -- Shard Shield (Bodyguard) (DB DLC)
    [77562] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77609] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds' }, -- Shard Shield (Bodyguard) (DB DLC)
    [77473] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Bodyguard) (DB DLC)
    [77815] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Bodyguard) (DB DLC)
    [77927] = { name = 'Stagger', hide = true }, -- Staggered (Bodyguard) (DB DLC)
    [77474] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77475] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77476] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77477] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77489] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77748] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77778] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77765] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77750] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [79534] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [83620] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [83624] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77838] = { hide = true }, -- Shield Charge (Bodyguard) (DB DLC)
    [77602] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77672] = { name = 'Recovery Invulnerability' }, -- 'Til Death (Bodyguard) (DB DLC)
    [77742] = { name = 'Recovery Invulnerability' }, -- 'Til Death (Bodyguard) (DB DLC)

    -- ANIMALS
    [5451] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_bite.dds' }, -- Bite (Alit)
    [5452] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }, -- Lacerate (Alit)
    [84356] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }, -- Lacerate (Alit)
    [56984] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', name = 'Lacerate' }, -- Laceration (Alit)
    [56983] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', name = 'Lacerate' }, -- Laceration (Alit)

    [4413] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds', name = 'Bite' }, -- Swipe (Bear)
    [38772] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Crushing Swipe (Bear)
    [18273] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Crushing Swipe (Bear)
    [4416] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }, -- Savage Blows (Bear)
    [12380] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }, -- Savage Blows (Bear)
    [61594] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds', name = 'Savage Blows' }, -- Savage Blows Bleeding (Bear)
    
    [70355] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds' }, -- Bite (Great Bear)
    [70357] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }, -- Lunge (Great Bear)
    [70359] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }, -- Lunge (Great Bear)
    [89189] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Slam (Great Bear)
    [69073] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', name = 'Slam' }, -- Knockdown (Great Bear)
    [70374] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = 'CC Immunity' }, -- Ferocity (Great Bear)
    [70372] = { hide = true }, -- Ferocity (Great Bear)
    [70376] = { hide = true }, -- Ferocity (Great Bear)
    [70375] = { hide = true }, -- Ferocity (Great Bear)

    [4583] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Bite (Crocodile)
    [9642] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Bite (Crocodile)
    [4587] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Crushing Chomp (Crocodile)
    [4591] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }, -- Sweep (Crocodile)
    [32051] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }, -- Sweep (Crocodile)
    [4594] = { icon= 'LuiExtended/media/icons/abilities/ability_crocodile_ancient_skin.dds' }, -- Ancient Skin (Crocodile)

    [8971] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Bite (Duneripper)
    [9643] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Bite (Duneripper)
    [8972] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Crushing Chomp (Duneripper)
    [8977] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }, -- Sweep (Duneripper)
    [32461] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }, -- Sweep (Duneripper)

    [7214] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }, -- Bite (Durzog)
    [7221] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }, -- Rend (Durzog)
    [7227] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', name = 'Rip and Tear' },-- Rotbone (Durzog)
    [16878] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', name = 'Rip and Tear' }, -- Rotbone (Durzog)

    [6304] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_swipe.dds' }, -- Swipe (Dreugh)
    [18002] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [18003] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [18005] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [6308] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_touch.dds' }, -- Shocking Touch (Dreugh)
    [27100] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Dreugh)

    [54374] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_tusks.dds' }, -- Tusks (Echatere)
    [54375] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }, -- Shockwave (Echatere)
    [54378] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }, -- Shockwave (Echatere)
    [68971] = { name = 'Stagger' }, -- Staggered (Echatere - Shockwave)
    [54382] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }, -- Headbutt (Echatere)
    [54381] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }, -- Headbutt (Echatere)

    [60920] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_scrape.dds' }, -- Scrape (Giant Bat)
    [4632] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    [47321] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    [18319] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    [4630] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_draining_bite.dds' }, -- Draining Bite (Giant Bat)

    [8540] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_strike.dds' }, -- Strike (Giant Snake)
    [5240] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }, -- Lash (Giant Snake)
    [30214] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }, -- Lash (Giant Snake)
    [5242] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds' }, -- Kiss of Poison (Giant Snake)
    [21826] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds' }, -- Kiss of Poison (Giant Snake)
    [5244] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_shed_skin.dds'}, -- Shed Skin (Giant Snake)

    [5440] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_bite.dds' }, -- Bite (Guar)
    [5443] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_headbutt.dds' }, -- Headbutt (Guar)
    [84359] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds' }, -- Dive (Guar)

    [5363] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }, -- Chomp (Kagouti)
    [42889] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }, -- Toss (Kagouti)
    [42888] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds', hide = true }, -- Toss (Kagouti)
    [18198] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }, -- Toss (Kagouti)

    [7170] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
    [60630] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
    [60641] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_claw.dds' }, -- Claw (Lion)
    [7158] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
    [7161] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_double_strike.dds' }, -- Double Strike (Lion)
    [8705] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds' }, -- Weakness (Lion)

    [8601] = { hide = true }, -- Vigorous Swipe (Mammoth)
    [75633] = { hide = true }, -- Vigorous Swipe (Mammoth)
    [75634] = { hide = true }, -- Vigorous Swipes (Mammoth)
    [8596] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_swipe.dds' }, -- Swipe (Mammoth)
    [8604] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_vigorous_swipes.dds', name = 'Vigorous Swipes' }, -- Vigorous Swipe (Mammoth)
    [8600] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }, -- Stomp (Mammoth)
    [23164] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }, -- Stomp (Mammoth)
    [48551] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = 'Stampede', hide = true}, -- Focused Charge (Mammoth)
    [23230] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds' }, -- Charge (Mammoth)
    [23222] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = 'Stampede' }, -- Charge (Mammoth)
    [23227] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = 'Stampede' }, -- Charge (Mammoth)
    [23225] = { hide = true }, -- Charge (Mammoth) (Pointless aura that does nothing)
    -- CHARGE SELF STUNS - IN CASE AURAS ARE EVER ADDED
    [23226] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Mammoth)
    [23221] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Mammoth)
    [23224] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Mammoth)
    -- END CHARGE SELF STUNS

    [4192] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_pincer.dds' }, -- Pincer (Mudcrab)
    [4224] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }, -- Double Claw Strike (Mudcrab)
    [4226] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }, -- Double Claw Strike (Mudcrab)
    [4200] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }, -- Unforgiving Claws (Mudcrab)
    [85082] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }, -- Unforgiving Claws (Mudcrab)
    [42841] = { hide = true }, -- Scuttle (Mudcrab)

    [16667] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_slap.dds' }, -- Slap (Netch)
    [16690] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_thrust.dds' }, -- Thrust (Netch)
    [16698] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds' }, -- Poisonbloom (Netch)

    [7266] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }, -- Strike (Nix-Hound)
    [13416] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }, -- Strike (Nix-Hound)
    [7268] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }, -- Leech (Nix-Hound)
    [12303] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }, -- Leech (Nix-Hound)
    [38635] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }, -- Dampworm (Nix-Hound)
    [38640] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }, -- Dampworm (Nix-Hound)
    [18344] = { hide = true }, -- Leech (Nix-Hound)

    [5362] = { icon = 'LuiExtended/media/icons/abilities/ability_skeever_slam.dds' }, -- Slam (Skeever)
    [21904] = { icon = 'LuiExtended/media/icons/abilities/ability_skeever_rend.dds' }, -- Rend (Skeever)

    [21947] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_bite.dds' }, -- Bite (Wamasu)
    [46833] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }, -- Sweep (Wamasu)
    [37178] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }, -- Sweep (Wamasu)
    [21951] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds', hide = true }, -- Repulsion Shock (Wamasu)
    [21952] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds' }, -- Repulsion Shock (Wamasu)
    [22045] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_static.dds' }, -- Static (Wamasu)
    
    
    [48556] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = 'Barreling Charge', hide = true }, -- Focused Charge (Wamasu)
    [21961] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = 'Barreling Charge' }, -- Charge (Wamasu)
    [21967] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = 'Barreling Charge' }, -- Charge (Wamasu)
    [21963] = { hide = true }, -- Charge (Wamasu) (Pointless aura that does nothing)
    -- CHARGE SELF STUNS - IN CASE AURAS ARE EVER ADDED
    [21964] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Wamasu)
    [21959] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Wamasu)
    -- END CHARGE SELF STUNS

    [44781] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_swipe.dds', name = 'Bite' }, -- Swipe (Welwa)
    [45937] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_cleave.dds', name = 'Swipe' }, -- Cleave (Welwa)
    [44791] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }, -- Rear Kick (Welwa)
    [44792] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }, -- Rear Kick (Welwa)
    [52417] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = 'Blitz' }, -- Charge (Welwa)
    [45986] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = 'Blitz' }, -- Charge (Welwa)
    [45991] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = 'Blitz' }, -- Charge (Welwa)
    [45984] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge Welwa
    
    [4022] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_bite.dds' }, -- Bite (Wolf)
    [42844] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_rotbone.dds' }, -- Rotbone (Wolf)
    [14523] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds' }, -- Helljoint (Wolf)
    [75818] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds' }, -- Helljoint (Wolf)
    [14272] = { hide = true }, -- Call of the Pack (Wolf)
    [14273] = { hide = true }, -- Call of the Pack (Wolf)
    [26658] = { hide = true }, -- Call of the Pack (Jackal)
    [26659] = { hide = true }, -- Call of the Pack (Jackal)
    
    [72803] = { hide = true }, -- Hardened Shell (Haj Mota)
    [74123] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_claw.dds' }, -- Claw (Haj Mota)
    [72787] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }, -- Horn Strike (Haj Mota)
    [73481] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }, -- Horn Strike (Haj Mota)
    [74272] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds', hide = true }, -- Bite (Haj Mota)
    [76578] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds' }, -- Bite (Haj Mota)
    [72793] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', hide = true }, -- Toxic Mucus (Haj Mota)
    [76577] = { hide = true }, -- Toxic Mucous (Haj Mota)
    [72815] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', name = 'Toxic Mucus'}, -- Toxic Mucous (Haj Mota)
    [72794] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_slime.dds', hide = true}, -- Toxic Pool (Haj Mota)
    [72796] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds', hide = true}, -- Bog Burst (Haj Mota)
    [72799] = { hide = true }, -- Bog Burst (Haj Mota)
    [76183] = { hide = true }, -- Bog Burst (Haj Mota)
    [72800] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    [74336] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    [74337] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    [76184] = { hide = true }, -- Bog Burst (Haj Mota)
    [73494] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Shockwave (Haj Mota)
    
    [76319] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_backstabber.dds', name = 'Backstabber' }, -- Backstabber (Dire Wolf)
    
    [80382] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }, -- Bite (Dire Wolf)
    [80383] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }, -- Bite (Dire Wolf)
    
    [76307] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds' }, -- Lunge (Dire Wolf)
    [76308] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds' }, -- Lunge (Dire Wolf)
    
    [76303] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds' }, -- Nip (Dire Wolf)
    [76304] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds' }, -- Nip (Dire Wolf)
    
    [76305] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Dire Wolf)
    [76306] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Dire Wolf)
    
    [85656] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_harry.dds' }, -- Harry (Dire Wolf)
    
    [76312] = { hide = true }, -- Harry (Dire Wolf)
    [76324] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_baleful_call.dds' }, -- Baleful Call (Dire Wolf)
    [76322] = { hide = true }, -- Baleful Call (Dire Wolf)
    
    -- DAEDRA
    [51256] = { hide = true }, -- Siphon (Atronach Passive)
    
    [48092] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }, -- Swipe (Air Atronach)
    [48093] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }, -- Swipe (Air Atronach)
    [48096] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flare.dds' }, -- Flare (Air Atronach)
    [48121] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_heavy_attack.dds' }, -- Heavy Attack (Air Atronach)
    [48137] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_tornado.dds' }, -- Tornado (Air Atronach)
    [51269] = { hide = true }, -- Air Atronach Flame  (Air Atronach - Frost)
    [51267] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_frost.dds', name = 'Empower Atronach: Frost' }, -- Air Atronach Flame (Air Atronach - Frost)
    [50021] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds' }, -- Ice Vortex (Air Atronach - Frost)
    [50022] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Ice Vortex (Air Atronach - Frost)
    [51262] = { hide = true }, -- Air Atronach Flame (Air Atronach - Flame)
    [51265] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_flame.dds', name = 'Empower Atronach: Flame' }, -- Air Atronach Flame (Air Atronach - Flame)
    [51282] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }, -- Flame Tornado (Air Atronach)
    
    [51271] = { hide = true }, -- Air Atronach Flame (Air Atronach - Storm)
    [51270] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_storm.dds', name = 'Empower Atronach: Storm' }, -- Air Atronach Flame (Air Atronach - Storm)
    [50023] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds' }, -- Lightning Rod (Air Atronach)
    [88902] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds' }, -- Lightning Rod (Air Atronach)
    [50026] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', name = 'Lightning Pulse' }, -- Lightning Rod (Air Atronach)

    

    [9743] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_entropic_touch.dds' }, -- Entropic Touch (Banekin)
    [9747] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_dire_wound.dds' }, -- Dire Wound (Banekin)
    [9749] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }, -- Envelop (Banekin)

    [4798] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt.dds' }, -- Headbutt (Clannfear)
    [84443] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike.dds' }, -- Tail Spike (Clannfear)
    
    [14202] = { hide = true }, -- Charge (Clannfear)
    [14196] = { hide = true }, -- Charge (Clannfear)
    [14819] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_charge.dds', name = 'Rush', hide = true }, -- Charge (Clannfear)
    [14825] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_charge.dds', name = 'Rush' }, -- Charge (Clannfear)
    [14828] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_charge.dds', name = 'Rush' }, -- Charge (Clannfear)
    [14829] = { hide = true }, -- Charge (Clannfear)
    [18751] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Clannfear)
    [14830] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Clannfear)

    [26551] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_strike.dds' }, -- Strike (Daedric Titan)
    [32852] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_ranged.dds' }, -- Scourge Bolt (Daedric Titan)
    [32696] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds' }, -- Soul Flame (Daedric Titan)
    [35280] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds' }, -- Soul Flame (Daedric Titan)
    [73437] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds' }, -- Soul Flame (Daedric Titan)
    [35278] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds' }, -- Soul Flame (Daedric Titan)
    [26554] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds' }, -- Wing Gust (Daedric Titan)
    [33085] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds' }, -- Wing Gust (Daedric Titan)
    [33086] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds' }, -- Wing Gust (Daedric Titan)

    [4750] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw.dds' }, -- Jagged Claw (Daedroth)
    [4778] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds' }, -- Fiery Jaws (Daedroth)
    [4772] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }, -- Fiery Breath (Daedroth)

    [18471] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [18472] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [15157] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [12254] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [26325] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_lava_geyser.dds' }, -- Lava Geyser (Flame Atronach)
    [4491] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_radiance.dds' }, -- Radiance (Flame Atronach)
    [50215] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Combustion (Flame Atronach)

    [67123] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_tremor.dds' }, -- Tremor (Flesh Colossus)
    [67636] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_falling_debris.dds' }, -- Falling Debris (Flesh Colossus)
    [65709] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds' }, -- Pin (Flesh Colossus)
    [49820] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds', name = 'Pin' }, -- Stunned (Flesh Colossus)
    [53233] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_disease.dds' }, -- Miasma Pool (Flesh Colossus)
    [67872] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', hide = true }, -- Sweep (Flesh Colossus)
    [68824] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds' }, -- Sweep (Flesh Colossus)
    [68813] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', name = 'Sweep' }, -- Sweep Knockback (Flesh Colossus)
    [68826] = { name = 'Stagger', hide = true }, -- Staggered (Flesh Colossus - Block Sweep)
    [67842] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Sweep Shockwave (Flesh Colossus)
    [76129] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_stumble_forward.dds' }, -- Stumble Forward (Flesh Colossus)
    [76134] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', hide = true }, -- Stumble Forward (Flesh Colossus)
    [65755] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', hide = true }, -- Staggered (Flesh Colossus)
    [76133] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', hide = true }, -- Stumble Forward (Flesh Colossus)
    [49429] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_smash.dds' }, -- Smash (Flesh Colossus)
    [65744] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_claw.dds' }, -- Claw (Flesh Colossus)
    [76140] = { hide = true }, -- Stumble Forward (Flesh Colossus) (Swing 1)
    [76143] = { hide = true }, -- Stumble Forward (Flesh Colossus) (Swing 2)
    [76145] = { hide = true }, -- Stumble Forward (Flesh Colossus) (Swing 3)
    [76146] = { hide = true }, -- Stumble Forward (Flesh Colossus) (Buff on Player)

    [63275] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_claw.dds' }, -- Claw (Flesh Atronach)
    [63276] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_stomp.dds' }, -- Stomp (Flesh Atronach)
    [35413] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_fire_brand.dds' }, -- Fire Brand (Flesh Atronach)
    [4817] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds' }, -- Unyielding Mace (Flesh Atronach)
    [20226] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', name = 'Unyielding Mace' }, -- Stun (Flesh Atronach)
    [27326] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds' }, -- Unyielding Mace (Flesh Atronach)
    [23077] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', name = 'Unyielding Mace' }, -- Bleeding (Flesh Atronach)

    [17069] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_spear.dds' }, -- Ice Spear (Frost Atronach)
    [5009] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_shards.dds' }, -- Ice Shards (Frost Atronach)
    [33551] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds' }, -- Chilling Aura (Frost Atronach)
    [44906] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }, -- Hoarfrost Fist (Frost Atronach)
    [44907] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds', hide = true }, -- Hoarfrost Fist (Frost Atronach)
    [44908] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }, -- Hoarfrost Fist (Frost Atronach)
    [51645] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds' }, -- Frozen Ground (Frost Atronach)
    [51646] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds', hide = true }, -- Frozen Ground (Frost Atronach)

    [65926] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_slash.dds' }, -- Slash (Grevious Twilight)
    [65845] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds' }, -- Rend (Grevious Twilight)
    [66643] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds' }, -- Rend (Grevious Twilight)
    [50596] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_bolt.dds' }, -- Shadow Bolt (Grevious Twilight)
    [50628] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [65891] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)

    [11076] = { icon = 'esoui/art/icons/ability_mage_029.dds', hide = true }, -- Chasten (Harvester)
    [26008] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_black_winter.dds', hide = true }, -- Black Winter (Harvester)
    [74794] = { name = 'Stagger' }, -- Black Winter (Harvester)
    [11083] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds' }, -- The Feast (Harvester)
    [26110] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds' }, -- The Feast (Harvester)
    [73916] = { hide = true }, -- GEN 2 Hits (Pointless passive applied on the Feast)

    [8204] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_strike.dds' }, -- Strike (Ogrim)
    
    [48553] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', name = 'Body Slam', hide = true },
    [24693] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', hide = true }, -- Body Slam (Ogrim)
    [24700] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds' }, -- Body Slam (Ogrim)
    -- SELF STUNS - IN CASE AURAS EVER ADDED
    [24699] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Body Slam (Ogrim)
    [24692] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Body Slam (Ogrim)
    -- END SELF STUNS

    [6158] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Scamp)
    [6167] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Scamp)
    [6162] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_rain_of_fire.dds' }, -- Rain of Fire (Scamp)

    [8778] = { icon = 'LuiExtended/media/icons/abilities/ability_spiderdaedra_strike.dds' }, -- Strike (Spider Daedra)
    [8808] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', hide = true }, -- Spit (Spider Daedra)
    [38658] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Spider Daedra)
    [20530] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_storm.dds' }, -- Lightning Storm (Spider Daedra)
    [89307] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds' }, -- Web (Spider Daedra - Spiderling)

    [4858] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_bash.dds' }, -- Bash (Storm Atronach)
    [13898] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_strike.dds' }, -- Strike (Storm Atronach)
    [35222] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Storm Atronach)
    [4864] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [35240] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [12287] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [12288] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [12286] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)

    [7095] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Xivilai)
    [83072] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_freezing_edge.dds' }, -- Freezing Edge (Xivilai)
    [49203] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_frozen_weapon.dds' }, -- Frozen Weapon (Xivilai)
    [88949] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Grasp (Xivilai)
    [25728] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_hand_of_flame.dds', hide = true }, -- Hand of Flame (Xivilai)
    [88947] = { hide = true }, -- Lightning Grasp (Xivilai) (Pointless aura)

    [4652] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gaze.dds' }, -- Gaze (Watcher)
    [4653] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }, -- Shockwave (Watcher)
    [43817] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds', name = 'Shockwave' }, -- Shockwave Snare (Watcher)
    [53880] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }, -- Shockwave (Watcher)
    [9220] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14518] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14461] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14547] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14426] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14546] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)

    [12062] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds' }, -- Kick (Winged Twilight)
    [13690] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds' }, -- Kick (Winged Twilight)
    [63612] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_tail_clip.dds' }, -- Tail Clip (Winged Twilight)
    [6412] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_dusks_howl.dds' }, -- Dusk's Howl (Winged Twilight)

    -- DWEMER
    [64508] = { icon = 'esoui/art/icons/ability_warrior_030.dds', name = 'Turret' }, -- Find Turret (Dwemer Sentry)
    [27333] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarven_overcharge.dds' }, -- Overcharge (Dwemer Spider)
    [20206] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarven_overcharge.dds' }, -- Overcharge (Dwemer Spider)
    [64423] = { hide = true }, -- Sparks (Dwemer Sentry)
    [64543] = { hide = true }, -- Thunderbolt (Dwemer Sentry)
    [19997] = { hide = true }, -- Static Field (Dwemer Spider)
    [20506] = { hide = true }, -- Overcharge Trigger (Dwemer Spider) (Duplicate Aura)
    [20221] = { hide = true }, -- Overcharge (Dwemer Spider) (Duplicate Aura)

    -- INSECTS
    [5278] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_bite.dds' }, -- Bite (Assassin Beetle)
    [6137] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = 'Lacerate' }, -- Laceration (Assassin Beetle)
    [51736] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = 'Lacerate' }, -- Bleeding (Assassin Beetle)
    [51735] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = 'Lacerate' }, -- Bleeding (Assassin Beetle)
    
    [5268] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_collywobbles.dds' }, -- Collywobbles (Assassin Beetle)
    [91789] = { hide = true }, -- Ambush (Assassin Beetle)
    [91791] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_feast.dds' }, -- Feast (Assassin Beetle)
    
    [13680] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_poison.dds' }, -- Acid Blood (Assassin Beetle)

    [6754] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_pincer.dds' }, -- Pincer (Giant Scorpion)
    [6755] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds' }, -- Sting (Giant Scorpion)
    [13671] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds' }, -- Sting (Giant Scorpion)
    [6757] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }, -- Blurred Strike (Giant Scorpion)
    [9040] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }, -- Blurred Strike (Giant Scorpion)
    [6756] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds' }, -- Paralyze (Giant Scorpion)
    [12312] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds', name = 'Paralyze' }, -- Snare (Giant Scorpion)
    [6758] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_hardened_carapace.dds' }, -- Hardened Carapace (Giant Scorpion)

    [4731] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_bite.dds' }, -- Bite (Giant Spider)
    [44086] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds', name = 'Poisonous Burst' }, -- Poisonous Burst (Giant Spider)
    [5790] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Poisonous Burst (Giant Spider)
    [5685] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds' }, -- Corrosive Bite (Giant Spider)
    [8088] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }, -- Poison Spray (Giant Spider)
    
    [4730] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds' }, -- Spit (Giant Spider)
    [47318] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = 'Web' }, -- Encase (Giant Spider)

    [9225] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_bite.dds' }, -- Bite (Giant Wasp)
    [9226] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_sting.dds' }, -- Sting (Giant Wasp)
    [9229] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds' }, -- Inject Larva (Giant Wasp)
    [9237] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', name = 'Inject Larva', unbreakable = 1 }, -- Larva Gestation (Giant Wasp)
    [9238] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_larva_burst.dds' }, -- Larva Burst (Giant Wasp)
    
    [48559] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = 'Zoom', hide = true }, -- Charge (Giant Wasp)
    [25119] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Giant Wasp)
    [25112] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Giant Wasp)
    [25113] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = 'Zoom' }, -- Charge (Giant Wasp)
    [25120] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = 'Zoom' }, -- Charge (Giant Wasp)

    [6788] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bite.dds' }, -- Bite (Hoarvor)
    [6800] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }, -- Bloodletting (Hoarvor)
    [42292] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }, -- Bloodletting (Hoarvor)
    [6795] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds' }, -- Latch On (Hoarvor)
    [13585] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds' }, -- Latch On (Hoarvor)
    
    [61243] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds' }, -- Vile Bite (Hoarvor DLC)
    [69392] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds', name = 'Vile Bite' }, -- Vile Bite Poison (Hoarvor DLC)
    [61244] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds' }, -- Fevered Retch (Hoarvor DLC)
    [61245] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds' }, -- Fevered Retch (Hoarvor DLC)
    [61377] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61372] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61374] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61249] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', hide = true }, -- Necrotic Explosion (Hoarvor DLC)
    [61388] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', name = 'Necrotic Explosion', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Necrotic Explosion Snare (Hoarvor DLC)

    [83977] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamascrib_bite.dds' }, -- Bite (Kwama Scrib)
    [8272] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', name = 'Contagion', hide = true }, -- Spit (Kwama Scrib)
    [47838] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds' }, -- Contagion (Kwama Scrib)
    [42869] = { hide = true }, -- Burrow (Kwama Scrib)

    [9287] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_bite.dds' }, -- Bite (Kwama Worker)
    [9291] = { hide = true }, -- Pounce (Kwama Worker)
    [83953] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_pounce.dds' }, -- Pounce (Kwama Worker)
    [18546] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Shattered Ground (Kwama Worker)
    [14839] = { hide = true }, -- Charge (Kwama Worker)
    [14841] = { hide = true}, -- Charge (Kwama Worker)
    [48539] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = 'Plow', hide = true }, -- Charge (Kwama Worker)
    [14846] = { hide = true }, -- Charge (Kwama Worker)
    [18808] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = 'Plow', hide = true }, -- Charge (Kwama Worker)
    [18810] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = 'Plow' }, -- Charge (Kwama Worker)
    [14844] = { hide = true }, -- Charge (Kwama Worker)
    [14845] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Kwama Worker)
    [18814] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Kwama Worker)

    [15011] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_swipe.dds' }, -- Swipe -- Kwama Warrior
    [9763] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }, -- Smash -- Kwama Warrior
    [9764] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }, -- Smash -- Kwama Warrior
    [18585] = { hide = true },  -- Excavation -- Kwama Warrior
    [27463] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds' }, -- Excavation -- Kwama Warrior
    [49192] = { hide = true }, -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)
    [18567] = { hide = true }, -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)
    [79147] = { hide = true }, -- GEN 3 Hits (Kwama Scrib Summoned)

    [6127] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_bite.dds' }, -- Bite (Shalk)
    [10947] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds' }, -- Fiery Breath (Shalk)
    [5252] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds' }, -- Fire Bite (Shalk)
    [6129] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds' }, -- Fire Bite (Shalk)
    [5265] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_burning_ground.dds' }, -- Burning Ground (Shalk)

    [5308] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunder_bite.dds' }, -- Thunder Bite (Thunderbug)
    [8429] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds' }, -- Zap (Thunderbug)
    [65079] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds' }, -- Zap (Thunderbug)
    [26379] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', name = 'Zap Pulse' }, -- Zap (Thunderbug)
    
    [26382] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds' }, -- Bolt (Thunderbug)
    [26412] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunderstrikes.dds' }, -- Thunderstrikes (Thunderbug)
    [34980] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunderstrikes.dds' }, -- Thunderstrikes (Thunderbug)
    
    [73166] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds' }, -- Bite (Kotu Gava)
    [73214] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds' }, -- Bite (Kotu Gava)
    [73215] = { hide = true }, -- Bite (Kotu Gava)
    
    [73184] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', hide = true }, -- Vile Spit (Kotu Gava Broodmother)
    [73172] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarm (Kotu Gava Broodmother)
    [73173] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarm (Kotu Gava Broodmother)
    [73193] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarm (Kotu Gava Broodmother)
    [73177] = { hide = true }, -- Swarmburst (Kotu Gava Broodmother)
    [73174] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [73175] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [73176] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [76579] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds' }, -- Bite (Kotu Gava Spawn)
    [76580] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds' }, -- Bite (Kotu Gava Spawn)
    [76581] = { hide = true }, -- Bite (Kotu Gava Spawn)
    [73200] = { hide = true }, -- Swarmburst (Kotu Gava Broodmother)
    [73195] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73196] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73197] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73194] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarmburst (Kotu Gava Broodmother)
    [73198] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarmburst (Kotu Gava Broodmother)
    
    -- MONSTERS
    [25716] = { icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Lacerate' }, -- Stun (Gargoyle)
    [25714] = { icon = 'esoui/art/icons/ability_mage_026.dds' }, -- Vampiric Touch (Gargoyle)
    [43742] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds' }, -- Obliterate (Giant)
    [32267] = { icon = 'esoui/art/icons/ability_debuff_levitate.dds' }, -- Grapple (Hag)
    [64808] = { icon = 'esoui/art/icons/ability_healer_028.dds', duration = 2.5 }, -- Briarheart Resurrection (Hagraven)
    [65027] = { icon = 'esoui/art/icons/ability_healer_028.dds' }, -- Briarheart Resurrection (Hagraven)
    [12426] = { name = 'Stagger' }, -- Raven Storm (Hagraven)
    [32698] = { name = 'Stagger' }, -- Staggered (Lurcher - Pulverize)
    [5349] = { name = 'Stagger', hide = true }, -- Staggered (Ogre - Shockwave) 
    [38554] = { name = 'Crushing Limbs' }, -- Stun (Lurcher)
    [6150] = { name = 'Shockwave' }, -- Ogre (Off Balance)
    [17703] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_flameray.dds' }, -- Flame Ray (Imp Fire Beam)
    [8884] = { icon = 'esoui/art/icons/ability_mage_016.dds' }, -- Zap (Imp Lightning Beam)
    [24985] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds' }, -- Intimidating Roar (Ogre)
    [34385] = { icon = 'esoui/art/icons/ability_mage_050.dds', name = 'Ice Pillar Chill' }, -- Generic AOE (Ogre Mage)
    [54327] = { icon = 'esoui/art/icons/ability_mage_050.dds' }, -- Winter's Reach (Ogre Mage)
    [9346] = { icon = 'esoui/art/icons/ability_healer_034.dds' }, -- Strangle (Strangler)
    [9707] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds' }, -- Grapple (Strangler)
    [8926] = { icon = 'esoui/art/icons/ability_healer_033.dds' }, -- Regeneration (Troll)
    [18040] = { icon = 'LuiExtended/media/icons/abilities/ability_wispmother_clone.dds' }, -- Clone (Wispmother)
    [18049] = { icon = 'LuiExtended/media/icons/abilities/ability_wispmother_clone.dds' }, -- Clone (Wispmother)
    [26129] = { hide = true }, -- Shatter (Giant) (Pointless aura on damage event)
    [2821] = { hide = true }, -- Luring Snare (Hag) (Pointless 2 sec buff on player)
    [64806] = { hide = true }, -- Briarheart Resurrection (Hagraven)
    [64132] = { hide = true }, -- Grapple Immunity (Strangle) (Pointless buff on player)
    [48287] = { hide = true }, -- Consuming Omen (Troll - Ranged) (Hiding to add fake aura)
    [48294] = { hide = true }, -- Consuming Omen (Troll - Ranged) (Hiding to add fake aura)
    [64211] = { hide = true }, -- Summon Wisp (Wispmother) (Pointless aura applied when Wispmother summons wisp)

    -- UNDEAD
    [38834] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_defiled_ground.dds', name = 'Desecrated Ground' }, -- Desecrated Ground Snare (Desecrated Ground - Undead Synergy)
    [69950] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_defiled_ground.dds' }, -- Desecrated Ground (Desecrated Ground - Undead Synergy)

    [8569] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }, -- Devastating Leap (Bloodfiend)
    [32023] = { name = 'Stagger' }, -- Generic Stagger Enemy (Bloodfiend

    [5028] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_strike.dds' }, -- Strike (Bone Colossus)
    [30590] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds' }, -- Bone Saw (Bone Colossus)
    [17206] = { name = 'Stagger', hide = true }, -- Bone Saw (Bone Colossus)
    [17221] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Slap (Bone Colossus - Risen Dead)
    [88828] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds' }, -- Necromantic Implosion (Bone Colossus - Risen Dead)

    [8550] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
    [8551] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
    [8564] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Bone Flayer)
    [9194] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)

    [8812] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds' }, -- Double Strike (Ghost)
    [8813] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds' }, -- Double Strike (Ghost)
    [18514] = { icon = 'esoui/art/icons/ability_mage_052.dds' }, -- Chill Touch (Ghost)
    [18515] = { icon = 'esoui/art/icons/ability_mage_052.dds' }, -- Chill Touch (Ghost)
    [19138] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds' }, -- Haunting Spectre (Ghost)
    [19140] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds' }, -- Haunting Spectre (Ghost)

    [9541] = { icon = 'esoui/art/icons/ability_mage_027.dds' }, -- Necrotic Spear (Lich)
    [20812] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Defiled Ground (Lich)
    [22525] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Defiled Ground (Lich)
    [73929] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', hide = true }, -- Soul Cage (Lich)
    [73931] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds' }, -- Soul Rupture (Lich)
    [73926] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = 'Soul Rupture' }, -- Soul Cage (Lich)
    [73937] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', hide = true }, -- Soul Cage (Lich)
    [73939] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds' }, -- Soul Rupture (Lich)
    [73934] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = 'Soul Rupture' }, -- Soul Cage (Lich)

    [49702] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds' }, -- Entropic Flare (Spellfiend)
    [50456] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds' }, -- Entropic Flare (Spellfiend)
    [50183] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds' }, -- Consuming Energy (Spellfiend)
    [52398] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds' }, -- Consuming Energy (Spellfiend)

    [68735] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampiric_drain.dds' }, -- Vampiric Drain (Vampire)
    [68750] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampiric_drain.dds', hide = true }, -- Vampiric Drain (Vampire)
    
    [45576] = { name = 'Stagger' }, -- Generic Stagger Enemy (Werewolf)

    [4323] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_frost_ranged.dds' }, -- Ice Bolt (Wraith)
    [4346] = { icon = 'esoui/art/icons/ability_mage_050.dds' }, -- Winter's Reach (Wraith)
    [43146] = { icon = 'esoui/art/icons/ability_mage_050.dds' }, -- Winter's Reach (Wraith)

    [2954] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [13972] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [63614] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [2969] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }, -- Pound (Zombie)
    [30347] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Zombie)
    
    -- MONSTERS
    
    [48549] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds', name = 'Assault', hide = true }, -- Focused Charge (Ice Wraith)
    [24869] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds', name = 'Assault' }, -- Blood in the Water (Ice Wraith)
    
    -- CYRODIIL
    [12033] = { icon = 'esoui/art/icons/artificialeffect_battle-spirit.dds' }, -- Battle Spirit

    [47717] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Cyrodiil Guard T1)
    [46830] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds' }, -- Bleeding Strike (Cyrodiil Guard T2)
    [46832] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', name = 'Bleeding Strike' }, -- Bleeding (Cyrodiil Guard T2)
    [46831] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', name = 'Bleeding Strike' }, -- Bleeding (Cyrodiil Guard T2)
    [36304] = { name = 'Spiked Armor' }, -- Razor Armor (Cyrodiil Guard T2)
    [36305] = { name = 'Spiked Armor' }, -- Spike Armor Damage Return (Cyrodiil Guard T2)
    [46834] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Cyrodiil Guard T2)
    [72639] = { icon = 'esoui/art/icons/ability_1handed_005.dds', hide = true }, -- Power Bash (Cyrodiil Guard T2)
    [72641] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Cyrodiil Guard T2)

    [7880] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = 'Shock Torrent', hide = true }, -- Light Attack (Cyrodiil Mage T1)
    [21629] = { icon = 'esoui/art/icons/ability_mage_008.dds' }, -- Mage's Lifesteal (Cyrodiil Mage T1)
    [21632] = { icon = 'esoui/art/icons/ability_mage_008.dds', name = 'Mage\'s Lifesteal' }, -- Lifesteal (Cyrodiil Mage T1)
    [21631] = { icon = 'esoui/art/icons/ability_mage_008.dds', name = 'Mage\'s Lifesteal' }, -- Lifesteal (Cyrodiil Mage T1)
    [46336] = { name = 'Crystal Shard' }, -- Crystal Shard Stun (Cyrodiil Mage T1)
    [46726] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = 'Improved Shock Torrent', hide = true }, -- Shock Torrent (Cyrodiil Mage T2)
    [46730] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = 'Improved Shock Torrent' }, -- Shock Torrent (Cyrodiil Mage T2)
    [46819] = { icon = 'esoui/art/icons/ability_mage_068.dds', name = 'Lasting Storm' }, -- Storm Damage (Cyrodiil Mage T2)
    [46716] = { icon = 'esoui/art/icons/ability_mage_008.dds', name = 'Steal Essence' }, -- Stolen Essence (Cyrodiil Mage T2)
    [46718] = { icon = 'esoui/art/icons/ability_mage_008.dds', name = 'Steal Essence' }, -- Lifesteal (Cyrodiil Mage T2)
    [46717] = { icon = 'esoui/art/icons/ability_mage_008.dds', name = 'Steal Essence' }, -- Lifesteal (Cyrodiil Mage T2)
    [46704] = { icon = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds' }, -- Crystal Blast (Cyrodiil Mage T2)
    [46706] = { icon = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds', name = 'Crystal Blast' }, -- Crystal Shard Stun (Cyrodiil Mage T2)
    [46719] = { hide = true }, -- Stolen Essence (Cryodiil Mage T2) (Pointless aura)
    [75397] = { hide = true }, -- Unstable Core (Cryodiil Mage T2) (Pointless aura)
    [75395] = { hide = true }, -- Reflected FX (Cryodiil Mage T2) (Pointless aura)

    [57962] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_minor_wound.dds', hide = true }, -- Minor Wound (Cyrodiil Mender T1)
    [21638] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_telekinetic_disorient.dds', name = 'Telekinetic Prison' }, -- Telekinetic Disorient (Cyrodiil Mender T1)
    [46839] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_minor_wound.dds', hide = true }, -- Major Wound (Cyrodiil Mender T2)
    [46904] = { icon = 'esoui/art/icons/ability_templar_rune_focus.dds', hide = true }, -- Rune Focus (Cyrodiil Mender T2)
    [46906] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_telekinetic_disorient.dds', name = 'Shattering Prison' }, -- Telekinetic Disorient (Cyrodiil Mender T2)
    [46910] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_telekinetic_disorient.dds' }, -- Shattering Prison (Cyrodiil Mender T2)
    [46847] = { icon = 'esoui/art/icons/ability_healer_016.dds' }, -- Potent Healing (Cyrodiil Mender T2)
    [51893] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds' }, -- Negate Magic (Cyrodiil Mender T1 + T2)
    [46272] = { hide = true }, -- Rune Focus (Cyrodiil Mender T1) (Displays as 0 sec passive on player if guards are friendly)
    [22469] = { hide = true }, -- Siege Shield (Cyrodiil Mender T1 + T2)

    [52864] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds' }, -- Quick Shot (Cyrodiil Archer T1 + T2)
    [54264] = { icon = 'esoui/art/icons/ability_bow_001_a.dds', hide = true }, -- Lethal Arrow (Cryodiil Archer T2)
    [54265] = { icon = 'esoui/art/icons/ability_bow_001_a.dds' }, -- Lethal Arrow (Cryodiil Archer T2)
    [54259] = { icon = 'esoui/art/icons/ability_bow_004_a.dds', hide = true }, -- Draining Shot (Cryodiil Archer T2)
    [54261] = { icon = 'esoui/art/icons/ability_bow_004_a.dds' }, -- Draining Shot (Cryodiil Archer T2)
    [54258] = { name = 'Improved Volley' }, -- Upgraded Volley (Cyrodiil Archer T2)

    [16510] = { name = 'Fire Torrent', hide = true }, -- Fire Salvo (Cyrodiil Honor Guard T1)
    [15780] = { icon = 'LuiExtended/media/icons/abilities/ability_basic_r_shock_aoe.dds' }, -- Honor Guard Rage (Cyrodiil Honor Guard T1)
    [35113] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', hide = true }, -- Extended Chains (Cyrodiil Honor Guard T1)
    [35115] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = 'Extended Chains', hide = true }, -- Pull (Cyrodiil Honor Guard T1)
    [46991] = { icon = 'esoui/art/icons/ability_mage_011.dds', name = 'Improved Fire Torrent' }, -- Fire Torrent Burning (Cryodiil Honor Guard T2)
    [46992] = { icon = 'LuiExtended/media/icons/abilities/ability_basic_r_shock_aoe.dds' }, -- Cripping Rage (Cyrodiil Honor Guard T2)
    [47001] = { icon = 'LuiExtended/media/icons/abilities/ability_basic_r_shock_aoe.dds' }, -- Cripping Rage (Cyrodiil Honor Guard T2)
    [47019] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', hide = true }, -- Puncturing Chains (Cyrodiil Honor Guard T2)
    [47023] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = 'Puncturing Chains' }, -- Puncture (Cyrodiil Honor Guard T2)
    [47020] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = 'Extended Chains', hide = true }, -- Pull (Cyrodiil Honor Guard T2)
    [15783] = { icon = 'esoui/art/icons/ability_warrior_022.dds' }, -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [15782] = { icon = 'esoui/art/icons/ability_warrior_022.dds' }, -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [46990] = { hide = true }, -- Improved Fire Torrent (Cyrodiil Honor Guard T2) (Pointless travel time aura)
    
    -- VVARDENFELL NPC'S
    [88361] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_vile_flare.dds' }, -- Vile Flare (Skaafin Masquer)
    [88339] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Shadeway (Skaafin Masquer)
    [88341] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Shadeway (Skaafin Masquer)
    [88336] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88330] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88335] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88334] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88346] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate.dds' }, -- Shadowy Duplicate (Skaafin Masquer)
    [88349] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate.dds' }, -- Shadowy Duplicate (Skaafin Masquer)
    [88354] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate.dds' }, -- Shadowy Duplicate (Skaafin Masquer)
    
    [81545] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force.dds' }, -- Fright Force (Malacath Voidbringer)
    [76784] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Shadeway (Malacath Voidbringer)
    [76843] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Shadeway (Malacath Voidbringer)
    [76730] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76624] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76729] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76728] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76969] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate.dds' }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76985] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate.dds' }, -- Shadowy Duplicate (Malacath Voidbringer)
    [77709] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate.dds' }, -- Shadowy Duplicate (Malacath Voidbringer)
    
    [77089] = { icon = 'esoui/art/icons/ability_rogue_056.dds' }, -- Basilisk Powder (Tracker)
    [77087] = { icon = 'esoui/art/icons/ability_rogue_056.dds' }, -- Basilisk Powder (Tracker)
    [77086] = { icon = 'esoui/art/icons/ability_debuff_silence.dds' }, -- Basilisk Powder (Tracker)
    [79954] = { icon = 'esoui/art/icons/ability_rogue_056.dds' }, -- Basilisk Powder (Tracker)
    [77019] = { icon = 'esoui/art/icons/ability_rogue_055.dds' }, -- Pin (Tracker)
    [77030] = { icon = 'esoui/art/icons/ability_rogue_055.dds' }, -- Pin (Tracker)
    [78435] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [79930] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [79929] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    
    [84817] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_skaafin_flare.dds' }, -- Skaafin Flare (Skaafin Witchling)
    [84815] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_skaafin_flare.dds' }, -- Skaafin Flare (Skaafin Witchling)
    
    [86879] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Chop (Drudge)
    [86880] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Hack (Drudge)
    [85359] = { icon = 'esoui/art/icons/ability_2handed_001.dds', name = 'Uppercut' }, -- Reverse Slash (Drudge)
    
    [85365] = { hide = true }, -- Assassinate Bonus (Drudge)

    [87310] = { hide = true }, -- Run Away! (Kagouti Whelp)
    [87312] = { hide = true }, -- Run Away! (Kagouti Whelp)
    [87276] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }, -- Chomp (Kagouti Whelp)
    
    [86704] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Chop (Hleran Noble)
    [86705] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Lop (Hleran Noble)
    [85361] = { icon = 'esoui/art/icons/ability_1handed_002.dds' }, -- Puncture (Hleran Noble)
    [85362] = { icon = 'esoui/art/icons/ability_debuff_major_fracture.dds' }, -- Major Fracture (Hleran Noble)
    
    [86881] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Hack (Sixth House Supplicant)
    [86882] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Hack (Sixth House Supplicant)
    [86883] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Slash (Sixth House Supplicant)
    [86884] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Slash (Sixth House Supplicant)
    [85342] = { icon = 'esoui/art/icons/ability_dualwield_001.dds' }, -- Twin Slashes (Sixth House Supplicant)
    [85343] = { icon = 'esoui/art/icons/ability_dualwield_001.dds' }, -- Twin Slashes (Sixth House Supplicant)
    [85368] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = 'Twin Slashes' }, -- Twin Slashes Bleed (Sixth House Supplicant)
    
    --[88481] = '' }, -- Spectral Claw (Beastcaller)
    [88478] = { icon = 'esoui/art/icons/ability_warden_014.dds' }, -- Swarm (Beastcaller)
    [88393] = { icon = 'esoui/art/icons/ability_warden_013.dds' }, -- Dive (Beastcaller)
    [88400] = { icon = 'esoui/art/icons/ability_warden_015.dds' }, -- Gore (Beastcaller)
    [88409] = { icon = 'esoui/art/icons/ability_warden_018.dds' }, -- Raise the Earth (Beastcaller)
    [92158] = { icon = 'esoui/art/icons/ability_warden_018.dds' }, -- Raise the Earth (Beastcaller)
    
    [87854] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds' }, -- Quick Shot
    [87855] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_arrow_stab.dds' }, -- Arrow Stab (Arbalest)
    [87902] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bombard.dds' }, -- Bombard (Arbalest)
    [87491] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_snare_frost.dds' }, -- Chilled Ground (Arbalest)

    -- Seasonal Quests
    [86075] = { icon = 'LuiExtended/media/icons/abilities/ability_event_bredas_magnificent_mead.dds' }, -- Breda's Magnificent Mead (Breda's Magnificent Mead)
    [83523] = { icon = 'LuiExtended/media/icons/abilities/ability_event_freezing.dds' }, -- Freezing (Snow Bear Plunge)
    [83522] = { icon = 'LuiExtended/media/icons/abilities/ability_event_warm.dds' }, -- Warm (Snow Bear Plunge)
    [84330] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball' }, -- Mudball (Mud Ball Merriment)
    [84378] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball' }, -- Mudball (Mud Ball Merriment)
    [84335] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball' }, -- Covered in Mud (Mud Ball Merriment)
    [85639] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball', hide = true }, -- Covered in Mud (Mud Ball Merriment)
    [85351] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball' }, -- Self-Serve Mudbath (Mud Ball Merriment) (Seems to be unusued - added just in case)
    [85352] = { icon = 'LuiExtended/media/icons/mementos/memento_event_mud_ball.dds', name = 'Mud Ball', hide = true }, -- Covered in Mud (Mud Ball Merriment) (Seems to be unusued - added just in case)

    [91369] = { icon = 'LuiExtended/media/icons/abilities/ability_event_steamy_spring_pie.dds', name = 'The Pie of Misrule' }, -- Jester's Experience Boost Pie (The Pie of Misrule)
    
    [92232] = { icon = 'LuiExtended/media/icons/abilities/ability_event_pelinals_ferocity.dds' }, -- Pelinal's Ferocity (Scroll of Pelinal's Ferocity)
    
    [89243] = { hide = true }, -- Butcher Awareness (A Noble Guest)

    ----------------------------------------------------------------
    -- WORLD EVENTS ------------------------------------------------
    ----------------------------------------------------------------

    -- Amkaos + Kathutet + Ranyu (Torturers)
    [81219] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_ranged.dds', hide = true }, -- Shock (Ranyu)
    [81215] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_aura.dds' }, -- Shock Aura (Ranyu)
    [77906] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Knockback' }, -- Stun (Ranyu)
    [81193] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_bolt.dds', hide = true }, -- Agonizing Strike (Ranyu)
    [81196] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_aoe.dds' }, -- Agonizing Fury (Ranyu)
    [81197] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_aoe.dds' }, -- Agonizing Fury (Ranyu)
    [81218] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Ranyu)

    -- CRAGLORN (Delves + World Events)
    [82328] = { icon = 'esoui/art/icons/death_recap_shock_aoe.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shock (Grandmother Thunder - Haddock's Market Delve Boss)
    
    -- Main Quests
    [82042] = { hide = true }, -- Q5130 - First Scene END Say (The Shattered and the Lost) (Pointless)
    [82134] = { hide = true }, -- Q5130 - Back in Time Scene (The Shattered and the Lost) (Pointless)
    [82049] = { hide = true }, -- Q5130 - Charging Amulet (The Shattered and the Lost) (Pointless)
    [82073] = { hide = true }, -- Q5130 - Winery FIN Scene 1 (The Shattered and the Lost) (Pointless)
    [82075] = { hide = true }, -- Q5130 - Winery FIN Scene 1 (The Shattered and the Lost) (Pointless)


    ----------------------------------------------------------------
    -- MAIN QUEST --------------------------------------------------
    ----------------------------------------------------------------
    
    -- TUTORIAL - Soul Shriven in Coldharbour
    
    [75527] = { hide = true }, -- Ultimate Protection (Tutorial)
    
    [64091] = { hide = true }, -- Power Bash (Tutorial - Used on Lyris)
    
    [61748] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Tutorial)
    
    [63737] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Dremora Churl)
    
    [63684] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = 'Dizzying Swing' }, -- Uppercut (Dremora Caitiff)
    [63685] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = 'Dizzying Swing' }, -- Uppercut Stun (Dremora Caitiff)
    [63686] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = 'Dizzying Swing' }, -- Uppercut (Dremora Caitiff)
    
    [63761] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }, -- Pound (Feral Soul Shriven)
    
    [63752] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Feral Soul Shriven)
    [63753] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Feral Soul Shriven)
    
    [62230] = { hide = true }, -- Coldharbour Flames (Flame Trap)
    [62771] = { hide = true }, -- Coldharbour Flames (Flame Trap)
    [62769] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds', name = 'Cold Fire Trap'}, -- Coldharbour Flames (Flame Trap)
    [62770] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds', name = 'Cold Fire Trap'}, -- Coldharbour Flames (Flame Trap)
    
    [63755] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Skeletal Pyromancer)
    [63756] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds', hide = true }, -- Heat Wave - Used by Skeletal Pyromancer in Tutorial }, -- Heat Wave (Skeletal Pyromancer)
    
    [64072] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1, name = 'Eye of the Sentinel' }, -- Eye of the Sentinel (CH Tutorial)
    
    [48345] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (The Prophet)
    [48346] = { hide = true }, -- Minor Wound (The Prophet)
    
    [63522] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw_tutorial.dds', name = 'Stomp' }, -- Bone Saw (Bone Colossus)
    
    [61646] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_incapacitating_terror.dds', duration = 0}, -- Incapacitating Terror
    [64074] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_incapacitating_terror.dds'}, -- Incapacitating Terror
    
    [75514] = { hide = true }, -- Greater Protection - CH Tutorial pointless aura
    [64772] = { hide = true }, -- MQ1 Input Lock LAtk - CH Tutorial pointless aura
    [63883] = { hide = true }, -- Major Protection - CH Tutorial pointless aura
    [64784] = { hide = true }, -- MQ1 Tutorial Block Heavy - CH Tutorial pointless aura
    [64798] = { hide = true }, -- MQ1 Heat Wave (Tutorial) - CH Tutorial pointless aura
    [61961] = { hide = true }, -- Perma Set Off Balance Target - CH Tutorial pointless aura
    [64677] = { hide = true }, -- MQ1 Tutorial Perma Off-Balance - CH Tutorial pointless aura
    [64069] = { hide = true }, -- Sentinel Barrier
    [64166] = { hide = true }, -- Major Protection - CH Tutorial pointless aura
    [63637] = { hide = true }, -- Teleport - CH Tutorial event when player teleports out
    
    ----------------------------------------------------------------
    -- IC QUEST RELATED & QUEST BOSS HIDDEN ------------------------
    ----------------------------------------------------------------

    [68660] = { hide = true }, -- Q5489 Zolgar Death Countdown - The Lock and the Legion
    [68720] = { hide = true }, -- Q5489 Regilus Death Timer - The Lock and the Legion
    [82788] = { hide = true }, -- IC Harvester Door Exception - The Imperial Standard (Barracks Defense)
    [69403] = { hide = true }, -- Healing Immunity - The Imperial Standard (Barracks Defense)
    [59168] = { hide = true }, -- Size and Strength - The Watcher in the Walls (Clannfear Boss)
    [59940] = { hide = true }, -- Summoning Call - The Watcher in the Walls (Clannfear Boss)
    [59181] = { hide = true }, -- Charge - The Watcher in the Walls (Clannfear Boss)
    [80678] = { hide = true }, -- Chasten - The Watcher in the Walls (Harvester Boss)
    [80674] = { hide = true }, -- Black Winter - The Watcher in the Walls (Harvester Boss)
    [60905] = { hide = true }, -- Summon - The Watcher in the Walls (Harvester Boss)
    [80650] = { hide = true }, -- Body Slam -- The Watcher in the Walls (Ogrim Boss)
    [53429] = { hide = true }, -- Call Final Boss - The Watcher in the Walls (Ogrim Boss)
    [53500] = { hide = true }, -- Spirit Shield - The Watcher in the Walls (Final Boss)
    [53480] = { hide = true }, -- Summon Flame Atronach - The Watcher in the Walls (Final Boss)
    [53489] = { hide = true }, -- Summon Flame Atronach - The Watcher in the Walls (Final Boss)
    [80657] = { hide = true }, -- Fright Force - The Watcher in the Walls (Final Boss)

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    [74875] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Catapult (The Hidden Harvest)
    [64734] = { name = 'Harpy Swoop', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Q5318 - Harpy Swoop In (The Hidden Harvest)
    [74104] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Grasping Vines (The Hidden Harvest)
    [74105] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (The Hidden Harvest)
    [64316] = { icon = 'LuiExtended/media/icons/abilities/ability_frost_fortress.dds' }, -- Frost Fortress (For King and Glory - Urfon Ice-Heart)
    [64363] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds' }, -- Savage Winds (For King and Glory - Urfon Ice-Heart)
    [66277] = { icon = 'LuiExtended/media/icons/equipment_disguise.dds', name = 'Vosh Rakh Illusion' }, -- Vosh Rakh Recruit Disg (The Anger of a King)
    [66397] = { icon = 'esoui/art/icons/ability_healer_027.dds' }, -- Avalian's Speed (The Anger of a King)
    [66399] = { icon = 'esoui/art/icons/ability_warrior_012.dds' }, -- Usunok's Strength (The Anger of a King)
    [66415] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Gust' }, -- Uppercut Stun (The Anger of a King)
    [53291] = { icon = 'esoui/art/icons/ability_destructionstaff_001a.dds', name = 'Crushing Shock' }, -- Uber Attack (The Anger of a King - Talviah Aliaria)
    [53302] = { icon = 'esoui/art/icons/ability_destructionstaff_008.dds', name = 'Minor Mangle' }, -- Icy Pulsar (The Anger of a King - Talviah Aliaria)
    [64430] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds' }, -- Royal Bash (Blood on a King's Hands)
    [66988] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Tear Down the Mountain (Blood on a King's Hands)
    [67084] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Tear Down the Mountain (Blood on a King's Hands)

    [65835] = { icon = 'esoui/art/icons/ability_restorationstaff_002.dds' }, -- Restoring Waves (Forcing the Faith)
    [72154] = { icon = 'esoui/art/icons/ability_debuff_levitate.dds' }, -- Choke (Draugr Dilemma)
    
    [69789] = { hide = true }, -- WG - Frozen Ice (Invitation to Orsinium - Olarz the Cunning)
    [69603] = { hide = true }, -- Q5318 - Siege Hits Above (The Hidden Harvest)
    [69552] = { hide = true }, -- Frozen Aura (For King and Glory - Urfon Ice-Heart)
    [64306] = { hide = true }, -- Frozen Fortress (For King and Glory - Urfon Ice-Heart)
    [69410] = { hide = true }, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart)
    [69404] = { hide = true }, -- Winter's Heed (For King and Glory - Urfon Ice-Heart)
    [69949] = { hide = true }, -- Kinetic Resonator Damage Limit (Quarry Conundrum)
    [65765] = { hide = true }, -- Q5348 - Poison Mist (To Save a Chief)
    [75403] = { hide = true }, -- Q5348 - Poison Mist (To Save a Chief)
    [65781] = { hide = true }, -- Poison Mist (To Save a Chief)
    [65780] = { hide = true }, -- Poison Mist (To Save a Chief)
    [65779] = { hide = true }, -- Poison Mist (To Save a Chief)
    [70646] = { hide = true }, -- VR Disguise Warning (The Anger of a King)
    [66408] = { hide = true }, -- Heat Wave (The Anger of a King)
    [66475] = { hide = true }, -- Q5468 - Speaker (The Anger of a King)
    [66476] = { hide = true }, -- Q5468 - Speaker Transfer (The Anger of a King)
    [53270] = { hide = true }, -- Frost Clench (The Anger of a King - Talviah Aliaria)
    [71177] = { hide = true }, -- Alga's Hold (The King's Gambit)
    [71178] = { hide = true }, -- Q5468 - Speaker Alga (The King's Gambit)
    [85086] = { hide = true }, -- Boss (The King's Gambit)
    [66903] = { hide = true }, -- Q5481 - Injure Solgra (Blood on a King's Hands)
    [74912] = { hide = true }, -- Archer's Focus (Blood on a King's Hands)
    [67898] = { hide = true }, -- Q5481 - Tracking (Blood on a King's Hands)
    [70546] = { hide = true }, -- Alga's Resilience (Blood on a King's Hands)
    [75103] = { hide = true }, -- The King's Anger (Blood on a King's Hands)
    [75116] = { hide = true }, -- The King's Anger (Blood on a King's Hands)
    [70540] = { hide = true }, -- Oil Fire (Blood on a King's Hands)

    -- SIDE QUESTS
    [65852] = { hide = true }, -- Shatter (Forcing the Faith)
    [65828] = { hide = true }, -- Lightning Jolt Synergy (Forcing the Faith)
    [65832] = { hide = true }, -- Restoring Waves Synergy (Forcing the Faith)
    [65834] = { hide = true }, -- Restoring Waves (Forcing the Faith)
    [70702] = { hide = true }, -- Tremors (Draugr Dilemma)
    [72153] = { hide = true }, -- Choke (Draugr Dilemma)
    [69172] = { hide = true }, -- Collapsing from Fatigue (Sorrow's Kiss)
    [65925] = { hide = true }, -- Q5466 Sphere Sparking (Tinker Trouble)
    
    -- DELVES
    [69290] = { hide = true }, -- Call Ally (Nikolvara the Durzog Trainer - Nikolvara's Kennel)
    [69322] = { hide = true }, -- Call Ally (Nikolvara the Durzog Trainer - Nikolvara's Kennel)

    
    -- PUBLIC DUNGEONS ORSINIUM
    [74762] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Pyre Keeper Rugdrulz - Old Orsinium)
    [53829] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Lifting Strike' }, -- Uppercut Stun (Batunalulr - Old Orsinium)
    [53940] = { icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Pummel' }, -- Pummel Stun (Batunalulr - Old Orsinium)
    [53874] = { hide = true }, -- Pummel (Batunalulr - Old Orsinium)
    
    ----------------------------------------------------------------
    -- VVARDENFELL     ---------------------------------------------
    ----------------------------------------------------------------
    
    -- SQ (An Armiger's Duty)
    [90073] = { hide = true }, -- Blinding Light
    
    
    [89753] = { hide = true }, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [89754] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    
    [86865] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencolossus_powered_up.dds' }, -- Powered Up (Centurion Mthgrazzen - A Melodic Mistake)
    [86633] = { hide = true }, -- Barrier Break (A Melodic Mistake)
    
    [85264] = { hide = true }, -- Sacrifice (Divine Inquiries)
    [85265] = { hide = true }, -- Sacrifice (Divine Inquiries)
    [85266] = { hide = true }, -- Sacrifice (Divine Inquiries)
    
    [92580] = { hide = true }, -- Q5887 - AshurStealthOut (Fleeing the Past)
    
    [95123] = { hide = true }, -- Q5933 - NaryuStuckProtection (A Purposeful Writ)
    
    [86981] = { hide = true }, -- Summon Skaafin (Vvardenfell - Various Quest NPC's)
    
    [85105] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_unstable_reaction.dds', hide = true }, -- Unstable Reaction (Reclaiming Vos)
    [85537] = { hide = true }, -- Summon Personal Guard (Reclaiming Vos)
    [47720] = { hide = true }, -- RobS Stun 1 Sec (Reclaiming Vos)
    
    [92720] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds' }, -- Necrotic Wave (Vvardenfell -- Ancestral Adversity)
    [92722] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave' }, -- Stomp of Flame (Vvardenfell -- Ancestral Adversity)
    [92723] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave', hide = true }, -- Fire Backlash (Vvardenfell -- Ancestral Adversity)
    [92721] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave' }, -- CON_Knockback&Knockdown (Vvardenfell -- Ancestral Adversity)
    
    [86743] = { icon = 'esoui/art/icons/achievement_morrowind_031.dds', hide = true }, -- Accelerated Transposition (Like Blood from a Stone)
    [90511] = { icon = 'esoui/art/icons/achievement_morrowind_031.dds', hide = true }, -- Accelerated Transposition (Like Blood from a Stone)
    
    [88425] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Shattered Ground (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88416] = { hide = true }, -- Awaken the Colony (Th'krak the Tunnel-King -- Delve -- Matus-Akin Egg Mine)
    [88417] = { hide = true }, -- Awaken the Colony (Th'krak the Tunnel-King -- Delve -- Matus-Akin Egg Mine)
    
    [88419] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88422] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88427] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = 'Plow', hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88431] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88432] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88426] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = 'Plow' }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88433] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = 'Plow', hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88435] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88437] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    
    [14374] = { hide = true }, -- Generic Dwemer Smoke Plume
    [93221] = { hide = true }, -- Surprise!
    
    [16910] = { hide = true }, -- Corruption Aura (Objections and Obstacles)
    
    [89756] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_drop.dds', name = 'Centurion Drop', unbreakable = 1 }, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [89757] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_drop.dds', name = 'Centurion Drop' }, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [84273] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }, -- Sweeping Spin (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    
    [87738] = { hide = true }, -- Powder Bomb (The Heart of a Telvanni)
    [89564] = { hide = true }, -- Knockout (The Heart of a Telvanni)
    [88244] = { hide = true }, -- The Slavemaster's Chains (The Heart of a Telvanni)
    
    [77541] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds', name = 'Mighty Strike' }, -- Brand's Cleave (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [77542] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds', name = 'Mighty Strike' }, -- Brand's Cleave (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    
    [82276] = { hide = true }, -- Dark Reach (The Heart of a Telvanni)
    [82274] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = 'Fiery Grip' }, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82275] = { name = 'Fiery Grip' }, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    
    [89266] = { hide = true }, -- Summon Spider
    [89269] = { hide = true }, -- Summon Spider
    [89276] = { hide = true }, -- Summon Exploder
    [89278] = { hide = true }, -- Summon Exploder
    [89277] = { hide = true }, -- Summon Exploder
    [89268] = { hide = true }, -- Summon Spider
    
    [89282] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', hide = true }, -- Spider Explosion
    [89274] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spider Explosion
    
    [87958] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_ash_storm.dds' }, -- Ash Storm (Divine Delusions)
    [87959] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_ash_storm.dds' }, -- Ash Storm (Divine Delusions)
    [86972] = { hide = true }, -- Q5888 Chodala Magic Shield FX (Divine Delusions)
    [90630] = { hide = true }, -- Frenzy (Divine Delusions)
    
    [86353] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_mechanical_possession.dds' }, -- Mechanical Possession (Vvardenfell -- Divine Intervention)
    [86417] = { hide = true }, -- Mechanical Possession (Divine Intervention)
    [86349] = { hide = true }, -- Inactive Centurion (Divine Intervention)
    
    -- VVARDENFELL MQ -- Divine Intervention
    [91006] = { hide = true }, -- Chodala's Shield
    [86815] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_ranged.dds' }, -- Daedric Bolt
    [90140] = { hide = true}, -- Sunder's Echo
    [90148] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Sunder's Echo
    [90146] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', hide = true }, -- Sunder's Echo
    [90147] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Sunder's Echo
    
    [90139] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    [90141] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    [90142] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    
    [88963] = {hide = true}, -- Delay
    
    -- VVARDENFELL MQ - Divine Disaster
    [88466] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', }, -- Skyfall
    [88467] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Skyfall
    [92536] = { hide = true }, -- Vulnerability to Meteors
    
    -- VVARDENFELL MQ - Divine Restoration
    [90181] = { icon = 'LuiExtended/media/icons/abilities/ability_clockworkguardian_oily_smoke.dds' }, -- Oily Smoke
    [90182] = { icon = 'LuiExtended/media/icons/abilities/ability_clockworkguardian_oily_smoke.dds' }, -- Oily Smoke
    
    [87104] = { hide = true}, -- Stun (Blade Trap - Divine Restoration)
    [87102] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = "Spinning Blade Trap" }, -- Spinning Blade
    [91970] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = "Spinning Blade Trap", type = BUFF_EFFECT_TYPE_DEBUFF }, -- Serrated Blade
    [91969] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = "Spinning Blade Trap" }, -- Serrated Blade
    [89330] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_torrent.dds', hide = true }, -- Defensive Flare
    [89750] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Pulse
    
    [92213] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Sparks
    [92229] = { hide = true }, -- Pulse
    [92227] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Pulse
    [92225] = { icon = 'esoui/art/icons/achievement_vvardenfel_013.dds' }, -- Repair
    [89761] = { hide = true }, -- Fabricate Beetle
    
    [90528] = { hide = true}, -- Loyal Hound
    
    [87038] = { icon = 'esoui/art/icons/ability_rogue_026.dds'}, -- Spinning Blades
    [87040] = { icon = 'esoui/art/icons/ability_rogue_026.dds', name = 'Spinning Blades', hide = true}, -- Pinning Blades
    [87039] = { icon = 'esoui/art/icons/ability_rogue_026.dds', name = 'Spinning Blades'}, -- Pinning Blades
    
    [87047] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    [87051] = {hide = true}, -- Lunge
    [87048] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    [87050] = {icon = 'esoui/art/icons/ability_rogue_066.dds', hide = true}, -- Lunge
    [87049] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    
    [87090] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_fire_ranged.dds', hide = true}, -- Barbs
    [87096] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_fire_ranged.dds'}, -- Barbs
    
    [90599] = { hide = true }, -- Daedric Vigor
    [92284] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_planar_shear.dds' }, -- Planar Shear
    [90627] = { hide = true }, -- targetable
    
    [90566] = { hide = true }, -- Loyal Hound
    [90567] = { hide = true }, -- Loyal Hound
    [90568] = { hide = true }, -- Loyal Hound
    [90569] = { hide = true }, -- Loyal Hound
    
    [87503] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    [90616] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    [87525] = { hide = true }, -- Divine Hijack
    
    [87522] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    
    [90524] = { hide = true }, -- Divine Hijack
    [92413] = { hide = true }, -- Contrived Portal
    
    -- TUTORIAL
    [92245] = { hide = true }, -- MQ1 Input Lock LAtk
    [1718] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = 'Light Attack' }, -- Attack
    [83416] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackheavy.dds'}, -- Heavy Attack
    [93577] = { hide = true }, -- MQ1 Tutorial Block Heavy
    [92263] = { hide = true }, -- Perma Set Off Balance Target
    [92266] = { hide = true }, -- MQ1 Tutorial Perma Off-Balance
    [92238] = { hide = true }, -- MQ1 Heat Wave (Tutorial)
    
    [88904] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', name = 'Bear Trap' }, -- Metal Trap
    [88905] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', name = 'Bear Trap' }, -- Metal Trap
    
    [63269] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_heat_wave.dds', name = 'Wall of Flame' }, -- Heat Wave
    [63270] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_heat_wave.dds', name = 'Wall of Flame', hide = true }, -- Heat Wave
    
    -- THE FORGOTTEN WASTES (PUBLIC DUNGEON)
    [91659] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds', hide = true }, -- Falling Rocks -- Deadfall
    [88030] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds' }, -- Falling Rocks -- Deadfall
    
    [92671] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Pyroclast -- Meteor
    [92672] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds' }, -- Pyroclast -- Meteor
    
    [86983] = { icon = 'esoui/art/icons/ability_mage_018.dds', type = BUFF_EFFECT_TYPE_DEBUFF}, -- Succubus Touch
    [86984] = { hide = true }, -- Succubus Touch
    
    [85390] = { hide = true}, -- Slash (Cliff Strider Matriach)
    [85391] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)
    [85394] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)
    [85392] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)
    [85393] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)
    
    [86930] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86932] = { hide = true}, -- Volcanic Debris
    [90500] = { hide = true}, -- Volcanic Debris
    [86934] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86939] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86938] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    
    [92702] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92709] = { hide = true}, -- Volcanic Debris
    [92703] = { hide = true}, -- Volcanic Debris
    [92707] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92706] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92704] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    
    -- NCHULEFTINGTH (PUBLIC DUNGEON)
    
    [84527] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds' }, -- Searing Steam
    
    [90271] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }, -- Charge-Wire Shock (Dwarven Charge-Wire)
    [90269] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }, -- Charge-Wire Shock (Dwarven Charge-Wire)
    [90268] = { hide = true }, -- Charge Whire Shock -- Generic Flame Wave Target
    [92135] = { hide = true }, -- Nchuleftingth Electricity (Dwarven Charge-Wire)
    
    [86634] = { hide = true }, -- Swinging Cleave (Mud-Tusk)
    [86635] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds'}, -- Swinging Cleave (Mud-Tusk)
    [89210] = { icon = 'LuiExtended/media/icons/abilities/ability_trollranged_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [89240] = { icon = 'LuiExtended/media/icons/abilities/ability_trollranged_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [89239] = { icon = 'LuiExtended/media/icons/abilities/ability_trollranged_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [94935] = { hide = true }, -- Tremor (Mud-Tusk)
    [94936] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds' }, -- Tremor (Mud-Tusk)
    
    [86613] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Piston Thrust (Dwarven Piston)
    [86623] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Piston Thrust (Dwarven Piston)
    
    [90860] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Spike Trap (Dwarven Piston)
    [90859] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Swinging Blades (Dwarven Piston)
    
    [86591] = { hide = true }, -- Piston Thrust
    [86592] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }, -- Piston Thrust
    [86596] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }, -- Piston Thrust
    [86595] = { hide = true }, -- Piston Thrust
    
    [69284] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_whirlwind_function.dds' }, -- Whirlwind Function (Guardian of Bthark)
    
    [86606] = { hide = true }, -- Steam Breath (Guardian of Bthark)
    [86607] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds' }, -- Steam Breath (Guardian of Bthark)
    
    [90192] = { hide = true }, -- Overcharge (Nchuleftingth)
    [90212] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarven_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [90214] = { hide = true }, -- Overcharge (Nchuleftingth)
    
    [90215] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Nchuleftingth)
    [90216] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Nchuleftingth)
    [90217] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Nchuleftingth)
    
    [71919] = { hide = true}, -- Turret Occupied (Nchuleftingth)
    [71920] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_turret_mode.dds' }, -- Turret Occupied (Nchuleftingth)
    
    [86566] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_runes.dds' }, -- Fire Runes (Friar Hadelar)
    [86575] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Renduril the Hammer)
    [86570] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Renduril the Hammer)
    [86576] = { name = 'Stagger', hide = true }, -- Staggered (Renduril the Hammer)
    [95731] = { hide = true }, -- Dutiful Fury -- Renduril the Hammer
    [86574] = { hide = true }, -- Shield Charge -- Renduril the Hammer
    
    [51634] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }, -- Shocking Touch (Steamreaver - Nchuleftingth)
    [86680] = { hide = true }, -- Auditory Signal (Steamreaver)
    [86691] = { hide = true }, -- Overcharge (Nchuleftingth)
    [86690] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarven_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [86688] = { hide = true }, -- Overcharge (Nchuleftingth)
    [86689] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Nchuleftingth)
    
    [92136] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds', name = 'Overcharged Shock', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Laser Snare (Dwarven Charge-Wire)
    [92138] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds', name = 'Overcharged Shock' }, -- Laser Damage (Dwarven Charge-Wire)
    
    [89998] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90004] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90005] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90006] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90007] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90008] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90009] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90010] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    
    [84333] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_demolish.dds' }, -- Demolish (Nchulaeon the Eternal)
    [84336] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_demolish.dds', hide = true }, -- Demolish (Nchulaeon the Eternal)
    
    [90788] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [84739] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [84755] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91407] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90821] = { hide = true }, -- Enable (Nchulaeon the Eternal)
    [90863] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90867] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91485] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90870] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90874] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91486] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    
    [84606] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' , hide = true }, -- Momentum
    [84616] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Momentum
    
    [90597] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Overcharge Explusion
    [90598] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', hide = true }, -- Overcharge Explusion
    
}

-- Fake Buffs applied onto the player by NPCs or Events (Friendly)
E.FakeExternalBuffs = {
    
    [48345] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds', name = 'Focused Healing', duration = 4000, norefresh = true }, -- Focused Healing (The Prophet)
    
}

 -- Fake Debuffs applied onto the player by NPCs or Events (Hostile)
E.FakeExternalDebuffs = {

    -- Player
    [18396] = {icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', name = 'Heavy Attack (Shock)', duration = 1800, norefresh = true}, -- Heavy Attack (Shock)
    
    -- Item Sets
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', name = 'Bahraha\'s Curse', duration = 0 }, -- Bahraha's Curse

    -- Traps
    [29602] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Falling Rocks', duration = 2000}, -- Falling Rocks (Tripwire)
    [66153] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Trial of Flame', duration = 1500}, -- Trial of Flame (Wrothgar - Old Orsinium)
    [32246] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Steam Trap', duration = 2000}, -- Laser Snare (Steam Trap)

    -- Quest Traps
    [64535] = {icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', name = 'Chilling Wind', duration = 2000}, -- Chilling Wind (Orsinium - Sorrow's Kiss)
    [67586] = {icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = 'Avalanche', duration = 2500}, -- Avalanche (Orsinium - Sorrow's Kiss)

    
    -- Justice NPC's
    [63160] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = 'Heavy Blow', duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63263] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = 'Heavy Blow', duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63094] = { icon = 'esoui/art/icons/ability_1handed_003.dds', name = 'Shield Charge', duration = 1500 }, -- Shield Charge (Justice Guard 1H)
    [63260] = { icon = 'esoui/art/icons/ability_2handed_003.dds', name = 'Mighty Charge', duration = 1500 }, -- Shield Charge (Justice Guard 2H)
    [63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = 'Stonefist', duration = 6000 }, -- Flame Shard (Justice Guard 2H)
    
    -- Standard NPC Abilities
    [42514] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds', name = 'Hard Dismount', duration = 2000}, -- Hard Dismount (Player knocked off horse)
    [29401] = {icon = 'esoui/art/icons/ability_1handed_005.dds', name = 'Power Bash', duration = 3000}, --Power Bash (NPC Disorient)
    [14926] = {icon = 'esoui/art/icons/ability_warrior_011.dds', name ='Focused Charge', duration = 2000}, -- Charge (Human NPC)
    [63822] = {icon = 'esoui/art/icons/ability_nightblade_008.dds', name = 'Teleport Strike', duration = 1500}, -- Teleport Strike (Nightblade)
    [10650] = {icon = 'LuiExtended/media/icons/abilities/ability_warrior_oil_drenched.dds', name ='Oil Drenched', duration = 0}, -- Oil Drenched
    [74483] = {icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = 'Fiery Grip', duration = 1000}, -- Fiery Grip (Sentinel) (TG DLC)

    -- Animals
    [69073] = {icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', name = 'Slam', duration = 2000}, -- Knockdown (Bear Orsinium)
    
    [74336] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds', name = 'Bog Burst', duration = 2000}, -- Bog Burst (Haj Mota)

    -- Daedra
    [50023] = {icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds', name = 'Lightning Rod', duration = 4000}, -- Lightning Rod (Air Atronach)
    [24700] = {icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', name = 'Body Slam', duration = 2000}, -- Body Slam (Ogrim)
    [12287] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', name = 'Storm Bound', duration = 8000}, -- Storm Bound (Storm Atronach) (DOT)
    [12288] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', name = 'Storm Bound', duration = 8000}, -- Storm Bound (Storm Atronach) (Snare)

    -- Insects
    [9237] = {icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', name = 'Inject Larva', duration = 10000}, -- Larva Gestation (Giant Wasp)
    [6795] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds', name = 'Latch On', duration = 7500 }, -- Latch On (Hoarvor)
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
    
    ----------------------------------------------------------------
    -- VVARDENFELL -------------------------------------------------
    ----------------------------------------------------------------
    
    -- THE FORGOTTEN WASTES (PUBLIC DUNGEON)
    [88030] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds', name = 'Falling Rocks', duration = 1500}, -- Falling Rocks -- Deadfall
    [87348] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', duration = 1500}, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87350] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', duration = 2000}, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [89756] = {icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_drop.dds', name = 'Centurion Drop', duration = 2000}, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)

}

-- Fake buffs applied onto the player by self (also supports debuffs with debuff = true)
E.FakePlayerBuffs = {

    -- Misc Consumables
    [85355] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_torch.dds', name = 'Fire-Breather\'s Oil Bun', duration = 12000}, -- Flame Juggling (Consumable Version)
    [85354] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_jugglers_knife.dds', name = 'Disposable Juggling Knives', duration = 12000}, -- Dagger Juggling (Consumable Verison)
    [85353] = {icon = 'LuiExtended/media/icons/consumables/consumable_event_swallowable_sword.dds', name = 'Disposable Swallower\'s Sword', duration = 12000}, -- Sword Swallowing (Consumable Version)

    -- Base Mementos
    [41988] = {icon = 'LuiExtended/media/icons/mementos/memento_bonesnap_binding_stone.dds', name = 'Bonesnap Binding Stone', duration = 10000}, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = {icon = 'LuiExtended/media/icons/mementos/memento_discourse_amaranthine.dds', name = 'Discourse Amaranthine', duration = 10000}, -- Glimpse of the Forbidden (Discoure Amaranthine)
    [42076] = {icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds', name = 'Mezha-dro\'s Sealing Amulet', duration = 8000}, -- Tear (Mezha-dro's Sealing Amulet)
    [34578] = {icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds', name = 'Nirnroot Wine', duration = 8000}, -- Nirnroot Wine (Nirnroot Wine)
    [26339] = {icon = 'LuiExtended/media/icons/mementos/memento_questionable_meat_sack.dds', name = 'Mystery Meat', duration = 5500}, -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = {icon = 'LuiExtended/media/icons/mementos/memento_sanguines_goblet.dds', name = 'Sanguine\'s Goblet', duration = 10000}, -- Sanguine's Goblet (Sanguine's Goblet)
    [89550] = {icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds', name = 'Twilight Shard', duration = 9000 }, -- TROPHY Azura's Light (Twilight Shard)
    [42008] = {icon = 'LuiExtended/media/icons/mementos/memento_token_of_root_sunder.dds', name = 'Token of Root Sunder', duration = 10000}, -- Blessing of Root Sunder (Token of Root Sunder)
    [42053] = {icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds', name = 'Yokudan Totem', duration = 10000}, -- Yokudan Salute (Yokudan Totem)

    -- DLC Mementos
    [79510] = {icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds', name = 'Blade of the Blood Oath', duration = 6500}, -- TROPHY Blood Oath (Blade of the Blood Oath)
    [74151] = {icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds', name = 'Hidden Pressure Vent', duration = 2500}, -- Stun (Hidden Pressure Vent)

    -- Crown Store Mementos
    [85349] = {icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_transform.dds', name = 'Storm Atronach Transform', duration = 180000}, -- Storm Atronach Transform (Atronach Transformation)
    [85347] = {icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds', name = 'Storm Orb Juggle', duration = 12000}, -- Storm Orb Juggle (Atronach Juggling)
    [86977] = {icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_transform.dds', name = 'Wild Hunt Transform', duration = 15000}, -- Spriggan Transformation (Wild Hunt Transform)
    [92868] = {icon = 'LuiExtended/media/icons/mementos/memento_dwemervamidium_mirage.dds', name = 'Dwemervamidium Mirage', duration= 180000}, -- Dwarven Transformation (Dwemervamidium Mirage)
    
    [97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds', name = 'Crow\'s Calling', duration = 9000 }, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [97274] = { icon = 'LuiExtended/media/icons/mementos/memento_swarm_of_crows.dds', name = 'Swarm of Crows', duration = 180000 }, -- Swarm of Crows (Swarm of Crows)
    
    [99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds', name = 'Fiery Orb', unbreakable = 1, duration = 9000 }, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    [99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds', name = 'Flame Pixie', unbreakable = 1, duration = 8000 }, -- Flame Crate Memento 2 (Flame Pixie)
    [99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds', name = 'Flame Eruption', unbreakable = 1, duration = 2000 }, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    
    -- Set Items
    [59573] = { icon = 'esoui/art/icons/ability_buff_major_vitality.dds', name = 'Major Vitality', duration = 510 }, -- Major Vitality (Malubeth)
    [81675] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = 'Pirate Skeleton', duration = 12000 }, -- Pirate Skeleton
    
    [71107] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds', name = 'Briareart', duration = 10000 }, -- Briarheart
    
    [97626] = { icon = 'esoui/art/icons/achievement_update11_dungeons_036.dds', name = 'Ironblood', duration = 10000, debuff = true }, -- Ironblood
    
    -- Player (Basic)
    [973] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', name = 'Sprint', duration = 0}, -- Sprint
    [33439] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_mount_sprint.dds', name = 'Gallop', duration = 0}, -- Mount Sprint (Generic)
    [32346] = {icon = 'esoui/art/icons/ability_mage_050.dds', name = 'Absorbing Skyshard', duration = 5800}, -- Skyshard Collect
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

-- Fake buffs applied onto a target by the player
E.FakePlayerExternalBuffs = {

}

E.FakePlayerDebuffs = { -- Fake debuffs applied onto a target by the player

    ----------------------------------------------------------------
    -- PLAYER BASIC ------------------------------------------------
    ----------------------------------------------------------------
    
    [18396] = {icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', name = 'Heavy Attack (Shock)', duration = 1800, norefresh = true}, -- Heavy Attack (Shock)

    -- JUSTICE NPCS
    [63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = 'Stonefist', duration = 6000 }, -- Flame Shard (Justice Guard 2H) -- If the player reflects
    
    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    [86309] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun', duration = 3000}, -- Stun (Player blocks NPC charged attack)
    [86312] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Block Stun', duration = 3000}, -- Stun (Player blocks Ogrim Body Slam)
    [74483] = {icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = 'Fiery Grip', duration = 1000}, -- Fiery Grip (Sentinel) (TG DLC) -- If the player reflects
    [21480] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_explosion.dds', name = 'Explosion', duration = 3000}, -- Explosion (Fire Vulnerability Proc)
    [68464] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_venom.dds', name = 'Venom', duration = 3000}, -- Venom (Poison Vulnerability Proc)
    [68461] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_pestilence.dds', name = 'Pestilence', duration = 3000}, -- Pestilence (Disease Vulnerability Proc)
    [68455] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_disintegration.dds', name = 'Disintegration', duration = 3000}, -- Disintegration (Lightning Vulnerability Proc)
    [68457] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_deep_freeze.dds', name = 'Deep Freeze', duration = 3000}, -- Deep Freeze (Frost Vulnerability Proc)
    
    -- Dragonknight (Flame Lash)
    [70745] = {icon = 'esoui/art/icons/ability_warrior_025.dds', name = 'Power Lash', duration = 2000}, -- Off-Balance Exploit (Flame Lash - Rank 1)
    
    -- Item Sets
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', name = 'Bahraha\'s Curse', duration = 0 }, -- Bahraha's Curse
    
}

-- We use this for debuffs applied on the player or on a target that don't need to check for a removal condition
-- Useful for effects like staggers where there is no way to break out of them for the short duration they are applied
E.FakeStagger = {

    -- Destruction Staff
    [48009] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Stagger (Crushing Shock - Rank 1)
    
    -- Justice NPC's
    [63200] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = 'Fiery Grip', duration = 1000 }, -- Firey Chain (Justice Guard)
    
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
    
    -- VVARDENFELL
    [86576] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Renduril the Hammer (Nchuleftingth)
    [88510] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 433}, -- Staggered (Vvardenfell -- Ancestral Adversity)

    -- On Target
    [86310] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 500}, -- Stagger (Player Blocks charged NPC attack)
    [21972] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = 'Stagger', duration = 500}, -- Stagger (Player interrupts NPC cast)
    
}

E.FakeSelfAura = {
    -- Nothing here yet
}

E.FakeFlippedBuffs = {

}

E.FakeDuplicate = {

    -- Dragonknight 
    --[29043] = {icon = 'esoui/art/icons/ability_dragonknight_015.dds', name = 'Molten Weapons'}, -- Molten Weapons (Molten Weapons - Rank 1)
    --[32151] = {icon = 'esoui/art/icons/ability_dragonknight_015.dds', name = 'Molten Weapons'}, -- Molten Weapons (Molten Weapons - Rank 2)
    --[32154] = {icon = 'esoui/art/icons/ability_dragonknight_015.dds', name = 'Molten Weapons'}, -- Molten Weapons (Molten Weapons - Rank 3)
    --[32156] = {icon = 'esoui/art/icons/ability_dragonknight_015.dds', name = 'Molten Weapons'}, -- Molten Weapons (Molten Weapons - Rank 4)
    
    --[31874] = {icon = 'esoui/art/icons/ability_dragonknight_015_a.dds', name = 'Igneous Weapons'}, -- Igneous Weapons (Igneous Weapons - Rank 1
    
    [29011] = {icon = 'esoui/art/icons/ability_dragonknight_011.dds', name = 'Dragon Blood'}, -- Dragon Blood (Dragon Blood - Rank 1)
    [61871] = {icon = 'esoui/art/icons/ability_dragonknight_011.dds', name = 'Dragon Blood'}, -- Dragon Blood (Dragon Blood - Rank 2)
    [61872] = {icon = 'esoui/art/icons/ability_dragonknight_011.dds', name = 'Dragon Blood'}, -- Dragon Blood (Dragon Blood - Rank 3)
    [61873] = {icon = 'esoui/art/icons/ability_dragonknight_011.dds', name = 'Dragon Blood'}, -- Dragon Blood (Dragon Blood - Rank 4)
    
    [61884] = {icon = 'esoui/art/icons/ability_dragonknight_011_b.dds', name = 'Green Dragon Blood'}, -- Green Dragon Blood (Green Dragon Blood - Rank 1)
    
    [61891] = {icon = 'esoui/art/icons/ability_dragonknight_011_a.dds', name = 'Coagulating Blood'}, -- Coagulating Blood (Coagulating Blood - Rank 1)
    
    -- Destruction Staff
    [62775] = {icon = 'esoui/art/icons/ability_destructionstaff_011b.dds', name = 'Elemental Susceptibility'}, -- Major Spell Shatter (Elemental Susceptibility - Rank 1)

    -- Human NPC's
    [53987] = { icon = 'esoui/art/icons/ability_buff_minor_sorcery.dds', name = 'Minor Sorcery' }, -- Rally (Vosh Rakh Devoted)
    [65235] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = 'CC Immunity'}, -- Enrage (Vosh Rakh Devoted)
    
}
