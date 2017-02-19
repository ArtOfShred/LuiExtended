------------------
-- Local namespace
LUIE.SpellCastBuffs = {}

-- Performance Enhancement
local SCB       = LUIE.SpellCastBuffs
local CI        = LUIE.CombatInfo
local UI        = LUIE.UI
local E         = LUIE.Effects
local L         = LUIE.GetLocale()
local strfmt    = string.format
local strformat = zo_strformat
local strfind   = zo_plainstrfind
local pairs     = pairs -- What does this do?

local moduleName = LUIE.name .. '_SpellCastBuffs'

local testEffectPrefix = 'testEffect:'
local testEffectList   = { 22, 44, 55, 1800000 }

local playerName = zo_strformat(SI_UNIT_NAME, GetUnitName('player'))

local windowTitles = {
    player      = "Effects on Player",
    player1     = "Player Buffs",
    player2     = "Player Debuffs",
    player_long = 'Player Long Term Effects', -- 'E'
    target      = "Effects on Target",
    target1     = "Target Buffs",
    target2     = "Target Debuffs",
}
local containerRouting = {}

SCB.Enabled = false
SCB.D = {
    IconSize                 = 40,
    BuffFontFace             = "Fontin Regular",
    BuffFontStyle            = "outline",
    BuffFontSize             = 16,
    Alignment                = L.Setting_Center,
    AlignmentVert            = L.Setting_Middle,
    SortDirection            = L.Setting_OrderX[1],
    GlowIcons                = false,
    RemainingText            = true,
    RemainingTextColoured    = false,
    RemainingTextMillis      = true,
    RemainingCooldown        = true,
    FadeOutIcons             = false,
    lockPositionToUnitFrames = true,
    LongTermEffects_Player   = true,
    LongTermEffects_Target   = true,
    IgnoreDisguise           = false,
    IgnoreMundus             = false,
    IgnoreEquipment          = false,
    IgnoreVampLycan          = false,
    IgnoreCyrodiil           = false,
    LongTermEffectsSeparate  = true,
    LongTermEffectsSeparateAlignment = 2,
    StealthState             = true,
}
SCB.SV = nil

-- gui
local uiTlw     = {}

-- abilities and buffs
local uiProcAnimation = {}
local uiCustomToggle = {}
local ActionBar = {}
local TriggeredSlots = {}
local ToggledSlots = {}

local g_lastCast = 0
local g_lastTarget = nil
local g_effectsList = { player1 = {}, player2 = {}, reticleover1 = {}, reticleover2 = {}, ground = {} }
local g_pendingGroundAbility = nil

-- potions
local g_quickslotAbility    = nil
local g_quickslotLastSame   = false
local g_quickslotLastUsable = false

-- self resurrection tracking
local g_playerActive = false
local g_playerDead   = false
local g_playerResurectStage = nil

-- stealth tracking
local g_stealth = nil

local buffSource = ""
local buffTarget = ""

local PlayerCast = {}

local bufftable = {}

local HideDebuffToggle = {}

-- fast travel from any place in world
local recallEffectName = 'Recall Cooldown'
local recallIconFilename = '/esoui/art/icons/ability_rogue_053.dds'

-- font to be used on icons
-- 'ZoFontWindowSubtitle' or ours:
--local buffsFont = '/LuiExtended/media/fonts/fontin_sans_r.otf|16|outline'
--local buffsFont = "$(MEDIUM_FONT)|17|outline"
local buffsFont

-- padding distance between icons
local g_padding = 0

local g_horizAlign = CENTER
local v_horizAlign = MIDDLE
local g_horizSortInvert = false

--[[
 * Double check that the slot is actually eligible for use
 ]]--
local function HasFailure( slotIndex )
    if ( HasCostFailure( slotIndex ) ) then return true
    elseif ( HasRequirementFailure( slotIndex ) ) then return true
    elseif ( HasWeaponSlotFailure( slotIndex ) ) then return true
    elseif ( HasTargetFailure( slotIndex ) ) then return true
    elseif ( HasRangeFailure( slotIndex ) ) then return true
    elseif ( HasStatusEffectFailure( slotIndex )  ) then return true
    elseif ( HasFallingFailure( slotIndex ) ) then return true
    elseif ( HasSwimmingFailure( slotIndex ) ) then return true
    elseif ( HasMountedFailure( slotIndex ) ) then return true
    elseif ( HasReincarnatingFailure( slotIndex ) ) then return true end
    return false
end

--[[----------------------------------------------------------
    ACTIVE BUFF EFFECTS
    * Get a custom buff/debuff effect when the player casts a spell
    * Effects are listed as [name] = { self buff , self debuff , target debuff , cast time }
    * Of the cast time us "true" instead of number, the value will be read from API
--]]----------------------------------------------------------

local Effects = {

    -----------------------------------
    -- WEAPON SKILLS
    -----------------------------------

    -- Bow
    [L.Skill_Volley]                = { false, false, true, 2 },
    [L.Skill_Scorched_Earth]        = { false, false, true, 2 },
    [L.Skill_Arrow_Barrage]         = { false, false, true, 2 },

    -- Destro Staff
    [L.Skill_Wall_of_Fire]            = { false, false, 6.4, nil },
    [L.Skill_Wall_Of_Storms]          = { false, false, 6.4, nil },
    [L.Skill_Wall_of_Frost]           = { false, false, 6.4, nil },
    [L.Skill_Unstable_Wall_of_Fire]   = { false, false, 6.4, nil },
    [L.Skill_Unstable_Wall_of_Frost]  = { false, false, 6.4, nil },
    [L.Skill_Unstable_Wall_of_Storms] = { false, false, 6.4, nil }, --Tested these values manually to make them as close to accurate as possible
    [L.Skill_Blockade_of_Fire]        = { false, false, 8.3, nil },
    [L.Skill_Blockade_of_Frost]       = { false, false, 8.3, nil },
    [L.Skill_Blockade_of_Storms]      = { false, false, 8.3, nil },

    -- Resto Staff
    [L.Skill_Grand_Healing]         = { true, false, false, nil },
    [L.Skill_Healing_Springs]       = { true, false, false, nil }, --Possibly Hide later, hard to account for cast time, only cast time is the animation which can be anim cancelled
    [L.Skill_Illustrious_Healing]   = { true, false, false, nil },

    -----------------------------------
    -- SORCERER
    -----------------------------------

    -- Dark Magic
    [L.Skill_Negate_Magic]          = { false, false, true, nil },
    [L.Skill_Absorption_Field]      = { true , false, true, nil },  -- Values here are completely accurate
    [L.Skill_Suppression_Field]     = { false , false, true, nil },

    [L.Skill_Daedric_Mines]         = { false, false, 36, 3.5 },
    [L.Skill_Daedric_Minefield]     = { false, false, 36, 3.5 },    -- Doesn't account for not having +20% duration passives, otherwise decently accurate
    [L.Skill_Daedric_Tomb]          = { false, false, 36, 0.5 },    -- Decent timer otherwise

    -- Daedric Summoning
    [L.Skill_Summon_Storm_Atronach]   = { false, false, true, 0.8 },  -- Values here are completely accurate
    [L.Skill_Greater_Storm_Atronach]  = { false, false, true, 0.8 },  -- Don't absolutely have to have this, player already gets a buff on them, but this gives us more feedback
    [L.Skill_Summon_Charged_Atronach] = { false, false, true, 0.8 },

    -- Storm Calling
    [L.Skill_Lightning_Splash]      = { false, false, true, nil },
    [L.Skill_Liquid_Lightning]      = { false, false, true, nil },
    [L.Skill_Lightning_Flood]       = { false, false, true, nil },

    -----------------------------------
    -- DRAGONKNIGHT
    -----------------------------------

    -- Ardent Flame
    [L.Skill_Dragonknight_Standard] = { false, false, true, nil },
    [L.Skill_Shifting_Standard]     = { false, false, true, nil }, -- This is the new standard effect fired when moving Shifting Standard
    [L.Skill_Shift_Standard]        = { false, false, true, nil }, -- Would be better to add these as a fake aura later - Standard doesn't go away when you cast shifting
    [L.Skill_Standard_of_Might]     = { true, false, true, nil }, -- Also if mob dies before banner ends, the banner stops but icon persists

    -- Draonic Power
    -- Could add inhale here eventually, gonna need to do it with a fake aura however (2.5 sec duration timer before it explodes)

    -- Earthen Heart
    [L.Skill_Ash_Cloud]             = { false, false, true, nil },
    [L.Skill_Cinder_Storm]          = { false, false, true, nil },
    [L.Skill_Eruption]              = { false, false, true, nil },

    -- Draconic Power

    -----------------------------------
    -- NIGHTBLADE
    -----------------------------------

    -- Assassination

    -- Shadow
        [L.Skill_Consuming_Darkness]        = { false, false, true, nil },
        [L.Skill_Bolstering_Darkness]       = { false, false, true, nil },
        [L.Skill_Veil_of_Blades]            = { false, false, true, nil },
        [L.Skill_Path_of_Darkness]          = { false, false, true, nil },
        [L.Skill_Refreshing_Path]           = { false, false, true, nil },
        [L.Skill_Twisting_Path]             = { false, false, true, nil },
        [L.Skill_Summon_Shade]              = { true, false, false, nil },
        [L.Skill_Dark_Shades]               = { true, false, false, nil },
        [L.Skill_Shadow_Image]              = { true, false, false, nil },

    -- Siphoning

    -----------------------------------
    -- TEMPLAR
    -----------------------------------

    -- Aedric Spear
    [L.Skill_Spear_Shards]                  = { false, false, true, 1.6 },
    [L.Skill_Luminous_Shards]               = { false, false, true, 1.6 }, --This seems roughly accurate, trying to time it with the disorient, depends on latency
    [L.Skill_Blazing_Spear]                 = { false, false, true, 1.6 }, --Possibly Hide later

    -- Dawn's Wrath
    [L.Skill_Nova]                          = { false, false, 11.3, 1.1 },
    [L.Skill_Solar_Prison]                  = { false, false, 11.3, 1.1 }, --Rough estimate of Nova duration - the damage fires off a bit after VFX fade - Pretty happy with these values
    [L.Skill_Solar_Disturbance]             = { false, false, 11.3, 1.1 },

    -- Restoring Light
    [L.Skill_Cleansing_Ritual]              = { true, false, false, nil },
    [L.Skill_Extended_Ritual]               = { true, false, false, nil },
    [L.Skill_Purifying_Ritual]              = { true, false, true, nil },
    [L.Skill_Rune_Focus]                    = { true, false, false, nil },
    [L.Skill_Channeled_Focus]               = { true, false, false, nil },
    [L.Skill_Restoring_Focus]               = { true, false, false, nil },

    -----------------------------------
    -- GUILDS
    -----------------------------------

    -- Fighter Guild
    --[L.Skill_Trap_Beast]          = { 0, 28.8, 3.5, false }, -- FIXME: check duration on r4, add other 2 skills
    [L.Skill_Circle_of_Protection]  = { true, false, false, nil },
    [L.Skill_Turn_Undead]           = { true, false, false, nil },
    [L.Skill_Ring_of_Preservation]  = { true, false, false, nil },

    -- Mages Guild
    [L.Skill_Meteor]                = { false, false, 11.8, 0 },
    [L.Skill_Ice_Comet]             = { false, false, 11.8, 0 },    -- Might need some work on timer
    [L.Skill_Shooting_Star]         = { false, false, 11.8, 0 },
    -- Need to add Fire Rune here

    -- Undaunted
    [L.Skill_Trapping_Webs]         = { false, false, true, nil },
    [L.Skill_Shadow_Silk]           = { false, false, true, nil },
    [L.Skill_Tangling_Webs]         = { false, false, true, nil },

    -----------------------------------
    -- WORLD
    -----------------------------------

    -- Vampire
    [L.Skill_Bat_Swarm]             = { false, false, 5.5, 0.1 },
    [L.Skill_Clouding_Swarm]        = { false, false, 5.5, 0.1 }, -- These values are perfect. Also note, this isn't needed as this shows as a buff on the player as well.
    [L.Skill_Devouring_Swarm]       = { false, false, 5.5, 0.1 },

    -- Werewolf

    -----------------------------------
    -- AVA
    -----------------------------------

    -- AVA Assault
    --[L.Skill_Vigor]               = { 5, false, false, 0 },
    --[L.Skill_Echoing_Vigor]       = { 5, false, false, 0 },
    --[L.Skill_Resolving_Vigor]     = { 5, false, false, 0 },
    [L.Skill_Caltrops]              = { false, false, true, nil },
    [L.Skill_Anti_Cavalry_Caltrops] = { false, false, true, nil },
    [L.Skill_Razor_Caltrops]        = { false, false, true, nil },

    --AVA Support
    --Possibly add Siege shield here/remove active effect

}

local abilityRouting = { "player1", "player2", "ground" }

local IsAbilityProc = {
    [L.Trigger_Assassins_Will]      = true,
    [L.Trigger_Assassins_Scourge]   = true,
    [L.Trigger_Power_Lash]          = true,
    [L.Trigger_Deadly_Throw]        = true,
}

local HasAbilityProc = {
    [L.Skill_Crystal_Fragments]     = L.Trigger_Crystal_Fragments_Proc, --Trigger_Crystal_Fragments_Passive
}

local IsAbilityCustomToggle = {

    --Sorceror Skills (Dark Magic)
    --[L.Skill_Defensive_Rune]        = true, -- Doesn't work because of no aura, would be nice to have this highlight if possible.

    -- Sorceror Skills (Daedric Summoning)
    [L.DamageShield_Conjured_Ward]  = true,
    [L.DamageShield_Empowered_Ward] = true,
    [L.DamageShield_Hardened_Ward]  = true,

    -- Sorceror Skills (Storm Calling)
    [L.Skill_Lightning_Form]        = true,
    [L.Skill_Boundless_Storm]       = true,
    [L.Skill_Thundering_Presence]   = true,
    [L.Skill_Surge]                 = true,
    [L.Skill_Critical_Surge]        = true,
    [L.Skill_Power_Surge]           = true,

    --Dragonknight Skills (Ardent Flame)
    [L.Skill_Inferno]               = true,
    [L.Skill_Flames_Of_Oblivion]    = true,
    [L.Skill_Cauterize]             = true,

    --Dragonknight Skills (Draconic Power)
    [L.Skill_Spiked_Armor]          = true,
    [L.Skill_Volatile_Armor]        = true,
    [L.Skill_Hardened_Armor]        = true, --Cut short by short duration shield effect
    --[L.Skill_Dragon_Blood]            = true,
    --[L.Skill_Green_Dragon_Blood]      = true,     -- Doesn't work, no abiltiy to go along with cast, only Major/Minor effects
    --[L.Skill_Coagulating_Blood]       = true,
    [L.Skill_Reflective_Scale]      = true,
    [L.Skill_Reflective_Plate]      = true,
    [L.Skill_Dragon_Fire_Scale]     = true,

    --Dragonknight Skills (Earthen Heart)
    [L.Skill_Molten_Weapons]           = true,
    [L.Skill_Igneous_Weapons]          = true,
    [L.Skill_Molten_Armaments]         = true,
    [L.DamageShield_Obsidian_Shield]   = true,
    [L.DamageShield_Fragmented_Shield] = true,
    [L.DamageShield_Igneous_Shield]    = true,

    --Templar Skills (Aedric Spear)
    [L.DamageShield_Sun_Shield]     = true, --These seem to fade on dodge roll, unlike other shields, I have no idea why
    [L.DamageShield_Radiant_Ward]   = true, --These seem to fade on dodge roll, unlike other shields, I have no idea why
    [L.DamageShield_Blazing_Shield] = true, --These seem to fade on dodge roll, unlike other shields, I have no idea why

    --Nightblade Skills (Assassination)
    [L.Skill_Blur]                  = true,
    [L.Skill_Double_Take]           = true,
    [L.Skill_Mirage]                = true,
    [L.Skill_Grim_Focus]            = true,
    [L.Skill_Relentless_Focus]      = true,
    [L.Skill_Merciless_Resolve]     = true,
    -- Ambush Empower, possibly add here

    --Nightblade Skills (Shadow)
    [L.Skill_Shadow_Cloak]          = true,
    [L.Skill_Shadowy_Disguise]      = true,
    [L.Skill_Dark_Cloak]            = true,
    -- If POSSIBLE - ADD SHADE ABILITIES HERE (Also add proc effect for Shadow Image potentially)

    --Nightblade Skills (Siphoning)
    [L.Skill_Siphoning_Strikes]     = true,
    [L.Skill_Siphoning_Attacks]     = true,
    -- Cripple Major expedition, possibly add here
    -- Drain power Major Brutality, possibly add here

    --Two Handed
    [L.DamageShield_Brawler]        = true,
    -- IF POSSIBLE - ADD CARVE MINOR HEROISM
    -- Uppercut empower, possibly add here
    [L.Skill_Momentum]              = true,
    [L.Skill_Forward_Momentum]      = true,
    [L.Skill_Rally]                 = true,

    --One Hand and Shield
    -- IF POSSIBLE - ADD HEROIC SLASH MINOR HEROISM
    [L.Skill_Defensive_Posture]       = true,
    [L.Skill_Defensive_Stance]        = true,
    [L.Skill_Absorb_Magic]            = true,
    [L.DamageShield_Shielded_Assault] = true,

    --Dual Wield
    [L.Skill_Blade_Cloak]            = true,
    [L.Skill_Quick_Cloak]            = true,
    [L.Skill_Deadly_Cloak]           = true,
    -- IF POSSIBLE - ADD HIDDEN BLADE MAJOR BRUTALITY HERE

    --Bow - Possibly scatter shot indicator?

    --Resto Staff
    --[L.Skill_Grand_Healing]          = true, --Doesn't work, no effect related to it
    --[L.Skill_Healing_Springs]        = true, --Doesn't work, no effect related to it
    --[L.Skill_Illustrious_Healing]    = true, --Doesn't work, no effect related to it
    [L.Skill_Regeneration]           = true,
    [L.Skill_Mutagen]                = true,
    [L.Skill_Rapid_Regeneration]     = true,
    -- Blessing of Protection + Morphs (not sure how to fix this, base effect is short duration)
    [L.DamageShield_Steadfast_Ward]  = true,
    [L.DamageShield_Ward_Ally]       = true,
    [L.DamageShield_Healing_Ward]    = true,

    --Light Armor
    [L.DamageShield_Annulment]       = true,
    [L.DamageShield_Dampen_Magic]    = true,
    [L.DamageShield_Harness_Magicka] = true,

    --Medium Armor
    --[L.Skill_Evasion]                = true,
    --[L.Skill_Elude]                  = true,      --NOT SURE WHY THESE DON'T WORK
    --[L.Skill_Shuffle]                = true,

    --Heavy Armor
    [L.Skill_Immovable]              = true,
    [L.Skill_Immovable_Brute]        = true,        -- Only shows the CC Immunity duration, need to figure a way to make other buffs display
    [L.Skill_Unstoppable]            = true,

    --Werewolf
    [L.Skill_Hircines_Rage]          = true,        -- Breaks on dodge roll for some reason
    [L.Skill_Hircines_Fortitude]     = true,        -- Breaks on dodge roll for some reason

    --Fighter's Guild
    [L.Skill_Expert_Hunter]          = true,
    [L.Skill_Evil_Hunter]            = true,
    [L.Skill_Camouflaged_Hunter]     = true,

    --Mage's Guild
    [L.Skill_Magelight]              = true,
    [L.Skill_Inner_Light]            = true,
    [L.Skill_Radiant_Magelight]      = true,
    --[L.Skill_Entropy]              = true,
    --[L.Skill_Degeneration]         = true,
    --[L.Skill_Structured_Entropy]   = true,
    [L.Skill_Equilibrium]            = true,    --Fades sooner than it should from other effects
    [L.Skill_Spell_Symmetry]         = true,    --Works
    [L.Skill_Balance]                = true,    --Fades sooner than it should from other effects

    --Undaunted
    -- BLOOD ALTAR HERE (possibly GTAOE)
    [L.DamageShield_Bone_Shield]     = true,
    [L.DamageShield_Bone_Surge]      = true,
    [L.DamageShield_Spiked_Bone_Shield] = true,
    -- Necrotic Orb?? Can't decide what to do with this.

    --AVA Assault
    [L.Skill_Rapid_Maneuver]         = true,
    [L.Skill_Charging_Maneuver]      = true,
    [L.Skill_Retreating_Maneuver]    = true,
    [L.Skill_Vigor]                  = true,    -- Drops after rolling for some reason
    [L.Skill_Echoing_Vigor]          = true,    -- Drops after rolling for some reason
    [L.Skill_Resolving_Vigor]        = true,    -- Drops after rolling for some reason
    [L.Skill_Proximity_Detonation]   = true,

    --AVA Support
    [L.Skill_Siege_Shield]           = true, --Behavior on Siege Shield's is kind of odd, only shows bar effect when standing inside it as it reapplies.
    [L.Skill_Propelling_Shield]      = true, --Still, you can only have one shield up, and it's pretty hard to miss the thing.
    [L.Skill_Siege_Weapon_Shield]    = true, --Possibly add GTAOE duration indicator as well
    [L.Skill_Purge]                  = true,
    [L.Skill_Cleanse]                = true,
    --[L.Skill_Efficient_Purge]      = true, --Doesn't work for some reason

}

-- some optimization
local strHidden = L.Effect_Hidden
local strHomeKeep   = L.Passive_HomeKeepBonus
local strEnemyKeep  = L.Passive_EnemyKeepBonus

--[[
 * Manually handled list of potion durations.
 * This 2 tables are taken from Srendarr
 ]]--
local PotionDurations = {
    [1] = { --standard potions from loot or from vendor. Potions can be any level, so duration is just estimated.
        [L.Potion_Sip]      = 4,    --lvl 1-5   3.3 + (1+5) / 2 * 0.257 = 4.071
        [L.Potion_Tincture] = 5.3,  --lvl 6-10
        [L.Potion_Serum]    = 6.6,  --lvl 11-15
        [L.Potion_Dram]     = 7.8,  --lvl 16-20
        [L.Potion_Effusion] = 9.1,  --lvl 21-35
        [L.Potion_Potion]   = 10.4, --lvl 26-30
        [L.Potion_Draught]  = 11.7, --lvl 31-35
        [L.Potion_Solution] = 13,   --lvl 36-40
        [L.Potion_Philter]  = 14.3, --lvl 41-45
        [L.Potion_Elixir]   = 15.8, --lvl 46-51 3.3 + (46+51) / 2 * 0.257 = 15.7645
        [L.Potion_Panacea]  = 18,   --VR 5      3.3 + 57.5 * 0.257 = 17.949
        [L.Potion_Distillate]=20.3, --VR10      3.3 + 66 * 0.257 = 20.262
        [L.Potion_Essence]  = 22.1, --VR15      3.3 + 73 * 0.257 = 22.061
    },
    [2] = { --crafted 2 ingredients potions with long buff
        [L.Potion_Sip]      = 10.5, --lvl 3      9 +  4 * 0.375 = 10.425  (9 + itemLevel * 0.375)
        [L.Potion_Tincture] = 13.1, --lvl 10     9 + 11 * 0.375 = 13.125
        [L.Potion_Dram]     = 16.8, --lvl 20     9 + 21 * 0.375 = 16.875
        [L.Potion_Draught]  = 20.6, --lvl 30     9 + 31 * 0.375 = 20.625
        [L.Potion_Solution] = 24.3, --lvl 40     9 + 41 * 0.375 = 24.375
        [L.Potion_Elixir]   = 28.8, --VR 1       9 + 53 * 0.375 = 28.875
        [L.Potion_Panacea]  = 31,   --VR 5       9 + 59 * 0.375 = 31.125
        [L.Potion_Distillate]=33.8, --VR10       9 + 66 * 0.375 = 33.750
        [L.Potion_Essence]  = 36.4, --VR15       9 + 73 * 0.375 = 36.375
    },
    [3] = {  --crafted 3 ingredients potions with long buff (+4 sec)
        [L.Potion_Sip]      = 14.5, --lvl 3
        [L.Potion_Tincture] = 17.1, --lvl 10
        [L.Potion_Dram]     = 20.8, --lvl 20
        [L.Potion_Draught]  = 24.6, --lvl 30
        [L.Potion_Solution] = 28.3, --lvl 40
        [L.Potion_Elixir]   = 32.8, --VR 1
        [L.Potion_Panacea]  = 35,   --VR 5
        [L.Potion_Distillate]=37.8, --VR10
        [L.Potion_Essence]  = 40.4, --VR15
    },
    [4] = {  --crafted 2 ingredients potions with short buff
        [L.Potion_Sip]      = 4.5,  --lvl 3     4 +  4 * 0.129 = 4.516
        [L.Potion_Tincture] = 5.4,  --lvl 10    4 + 11 * 0.129 = 5.419
        [L.Potion_Dram]     = 6.7,  --lvl 20    4 + 21 * 0.129 = 6.709
        [L.Potion_Draught]  = 8,    --lvl 30    4 + 31 * 0.129 = 7.999
        [L.Potion_Solution] = 9.3,  --lvl 40    4 + 41 * 0.129 = 9.289
        [L.Potion_Elixir]   = 10.8, --VR 1      4 + 53 * 0.129 = 10.837
        [L.Potion_Panacea]  = 11.6, --VR 5      4 + 59 * 0.129 = 11.611
        [L.Potion_Distillate]=12.5, --VR10      4 + 66 * 0.129 = 12.514
        [L.Potion_Essence]  = 13.4, --VR 5      4 + 73 * 0.129 = 13.417
    },
    [5] = {  --crafted 3 ingredients potions with short buff (+2 sec)
        [L.Potion_Sip]      = 6.5,  --lvl 3
        [L.Potion_Tincture] = 7.4,  --lvl 10
        [L.Potion_Dram]     = 8.7,  --lvl 20
        [L.Potion_Draught]  = 10,   --lvl 30
        [L.Potion_Solution] = 11.3, --lvl 40
        [L.Potion_Elixir]   = 12.8, --VR 1
        [L.Potion_Panacea]  = 13.6, --VR 5
        [L.Potion_Distillate]=14.5, --VR10
        [L.Potion_Essence]  = 15.4, --VR15
    },
}

local PotionEffects = { --buff, debuff, potionType
    --drop & vendor potions
    [17302] = {true, false, 1}, --health
    [17323] = {true, false, 1}, --magicka
    [17328] = {true, false, 1}, --stamina
    --crafted potions (positive effects)
    [45221] = {true, false, 2}, --Health
    [45223] = {true, false, 2}, --Magicka
    [45225] = {true, false, 2}, --Stamina
    [45227] = {true, false, 2}, --Spell Power
    [45228] = {true, false, 2}, --Weapon Power
    [45233] = {true, false, 2}, --Spell Protection
    [45234] = {true, false, 2}, --Armor
    [45235] = {true, false, 2}, --Speed
    [45236] = {true, false, 2}, --Detection
    [45237] = {true, false, 4}, --Invisiblity
    [45239] = {true, false, 4}, --Immovability
    [45241] = {true, false, 2}, --Weapon Crit
    [45382] = {true, false, 3}, --Health (longer duration)
    [45385] = {true, false, 3}, --Magicka (longer duration)
    [45388] = {true, false, 3}, --Stamina (longer duration)
    [45460] = {true, false, 5}, --Invisiblity (longer duration)
    [45463] = {true, false, 5}, --Immovability (longer duration)
    [45466] = {true, false, 3}, --Weapon Crit (longer duration)
    [47193] = {true, false, 2}, --Spell Crit
    [47195] = {true, false, 3}, --Spell Crit (longer duration)
    --crafted potions (negative effects)
    [46111] = {false, true, 2}, --Ravage Health
    [46193] = {false, true, 2}, --Ravage Magicka
    [46199] = {false, true, 2}, --Ravage Stamina
    [46202] = {false, true, 2}, --Ravage Spell Power
    [46204] = {false, true, 2}, --Ravage Weapon Power
    [46206] = {false, true, 2}, --Ravage Spell Protection
    [46210] = {false, true, 2}, --Slow
    [46215] = {false, true, 3}, --Ravage Health (longer duration)
    [46237] = {false, true, 3}, --Ravage Magicka (longer duration)
    [46240] = {false, true, 3}, --Ravage Stamina (longer duration)
    [46244] = {false, true, 2}, --Ravage Spell Power (longer duration)
    [46246] = {false, true, 3}, --Ravage Weapon Power (longer duration)
    [47203] = {false, true, 2}, --Ravage Weapon Critical
    [47204] = {false, true, 2}, --Ravage Spell Critical
    [47213] = {false, true, 2}, --Stun
}

--[[----------------------------------------------------------
    CORRECTION TO BUFFS
    * By default some API provided buffType values seems incorrect, that is,
    * when the effect sounds like "debuff" it is still listed as "buff".
    * This table is used to correct such items
--]]----------------------------------------------------------

--[[
 * Initialization
 ]]--
function SCB.Initialize( enabled )
    -- load settings
    SCB.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, 'SpellCastBuffs', SCB.D )
    -- correct read values
    if SCB.SV.IconSize < 30 or SCB.SV.IconSize > 60 then
        SCB.SV.IconSize = SCB.D.IconSize
    end

    -- if User does not want the Buffs tracking then exit right here
    if not enabled then return end
    SCB.Enabled = true

    -- Before we start creating controls, update icons font
    SCB.ApplyFont()

    -- Create controls

    -- We will not create TopLevelWindows when frames are locked to CustomFrames
    if SCB.SV.lockPositionToUnitFrames and LUIE.UnitFrames.CustomFrames.player and LUIE.UnitFrames.CustomFrames.player.buffs and LUIE.UnitFrames.CustomFrames.player.debuffs then
        uiTlw.player1 = LUIE.UnitFrames.CustomFrames.player.buffs
        uiTlw.player2 = LUIE.UnitFrames.CustomFrames.player.debuffs
        containerRouting.player1 = "player1"
        containerRouting.player2 = "player2"
    else
        uiTlw.player = UI.TopLevel( nil, nil )
        uiTlw.player:SetHandler( 'OnMoveStop', function(self)
                SCB.SV.playerOffsetX = self:GetLeft()
                SCB.SV.playerOffsetY = self:GetTop()
            end )
        containerRouting.player1 = "player"
        containerRouting.player2 = "player"
    end

    if SCB.SV.lockPositionToUnitFrames and LUIE.UnitFrames.CustomFrames.reticleover and LUIE.UnitFrames.CustomFrames.reticleover.buffs and LUIE.UnitFrames.CustomFrames.reticleover.debuffs then
        uiTlw.target1 = LUIE.UnitFrames.CustomFrames.reticleover.buffs
        uiTlw.target2 = LUIE.UnitFrames.CustomFrames.reticleover.debuffs
        containerRouting.reticleover1 = "target1"
        containerRouting.reticleover2 = "target2"
        containerRouting.ground = "target2"
    else
        uiTlw.target = UI.TopLevel( nil, nil )
        uiTlw.target:SetHandler( 'OnMoveStop', function(self)
                SCB.SV.targetOffsetX = self:GetLeft()
                SCB.SV.targetOffsetY = self:GetTop()
            end )
        containerRouting.reticleover1 = "target"
        containerRouting.reticleover2 = "target"
        containerRouting.ground = "target"
    end

    -- separate container for players long buffs
    if true then
        uiTlw.player_long = UI.TopLevel( nil, nil )
        uiTlw.player_long:SetHandler( 'OnMoveStop', function(self)
                if self.alignVertical then
                    SCB.SV.playerVOffsetX = self:GetLeft()
                    SCB.SV.playerVOffsetY = self:GetTop()
                else
                    SCB.SV.playerHOffsetX = self:GetLeft()
                    SCB.SV.playerHOffsetY = self:GetTop()
                end
            end )

        -- TODO: implement change in vertical alignment
        if SCB.SV.LongTermEffectsSeparateAlignment == 1 then
            uiTlw.player_long.alignVertical = false
        elseif SCB.SV.LongTermEffectsSeparateAlignment == 2 then
            uiTlw.player_long.alignVertical = true
        end
        uiTlw.player_long.skipUpdate = 0
        containerRouting.player_long = "player_long"
    else
        containerRouting.player_long = containerRouting.player1
    end

    SCB.SetTlwPosition()

    -- loop over created controls to...
    for _, v in pairs(containerRouting) do
        if uiTlw[v].preview == nil then

            -- create background areas for preview position purposes
            --uiTlw[v].preview = UI.Backdrop( uiTlw[v], "fill", nil, nil, nil, true )
            uiTlw[v].preview = UI.Texture( uiTlw[v], "fill", nil, "/esoui/art/miscellaneous/inset_bg.dds", DL_BACKGROUND, true )
            uiTlw[v].previewLabel = UI.Label( uiTlw[v].preview, {CENTER,CENTER}, nil, nil, 'ZoFontGameMedium', windowTitles[v] .. (SCB.SV.lockPositionToUnitFrames and v ~= "player_long" and ' (locked)' or ''), false )

            -- create control that will hold the icons
            uiTlw[v].prevIconsCount = 0
            -- we need this container only for icons that are aligned in one row/column automatically.
            -- thus we do not create containers for player and target buffs on custom frames
            if v ~= "player1" and v ~= "target1" then
                uiTlw[v].iconHolder = UI.Control( uiTlw[v], nil, nil, false )
            end
            -- create table to store created contols for icons
            uiTlw[v].icons = {}

            -- add this top level window to global controls list, so it can be hidden
            -- we need to do it only when we control TopLevelWindows ourselves
            if uiTlw[v]:GetType() == CT_TOPLEVELCONTROL then LUIE.components[ moduleName .. v ] = uiTlw[v] end
        end
    end

    SCB.Reset()

    -- Register events
    EVENT_MANAGER:RegisterForUpdate(moduleName, 100, SCB.OnUpdate )
    EVENT_MANAGER:RegisterForUpdate(moduleName..'CheckPotion', 200, SCB.CheckPotion )

    -- Target Events
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TARGET_CHANGE,             SCB.OnTargetChange )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RETICLE_TARGET_CHANGED,    SCB.OnReticleTargetChanged )

    -- Buff Events
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTIVE_QUICKSLOT_CHANGED,  SCB.OnActiveQuickslotChanged )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_FULL_UPDATE,  SCB.OnSlotsFullUpdate )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED,       SCB.OnSlotUpdated )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_UPDATE_COOLDOWNS,   SCB.OnUpdateCooldowns )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_ABILITY_USED,  SCB.OnSlotAbilityUsed )
    -- Tracking of finishing long-term buffs
    EVENT_MANAGER:RegisterForEvent(moduleName  .. "player",         EVENT_EFFECT_CHANGED, SCB.OnEffectChanged )
    EVENT_MANAGER:RegisterForEvent(moduleName  .. "reticleover",    EVENT_EFFECT_CHANGED, SCB.OnEffectChanged )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "player",         EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "reticleover",    EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG, "reticleover" )

    -- FIXME: Reenable later properly
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COMBAT_EVENT, SCB.OnCombatEvent )
    EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, false )

    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED,  SCB.OnDeath )

    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_STEALTH_STATE_CHANGED, SCB.StealthStateChanged )
    EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_STEALTH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )

    -- Activate, Deactivate player, death, alive.
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED,   SCB.OnPlayerActivated )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_DEACTIVATED, SCB.OnPlayerDeactivated )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ALIVE, SCB.OnPlayerAlive )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_DEAD,  SCB.OnPlayerDead )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_VIBRATION,    SCB.OnVibration )
end

--[[
 * Sets horizontal alignment of icon. Called from Settings Menu.
 * This is done simply by setting of iconHolder anchor.
 ]]--
function SCB.SetIconsAlignment( value )
    -- check correctness of argument value
    if value ~= L.Setting_Left and value ~= L.Setting_Center and value ~= L.Setting_Right then
        value = SCB.D.Alignment
    end
    SCB.SV.Alignment = value

    if not SCB.Enabled then return end

    g_horizAlign = ( value == L.Setting_Left ) and LEFT or ( value == L.Setting_Right ) and RIGHT or CENTER

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            uiTlw[v].iconHolder:ClearAnchors()
            if uiTlw[v].alignVertical then
                -- Might need to consolidate these two functions somehow, possibly consolidate all options so that Left = Top, Middle = Center, Right = Bottom
                uiTlw[v].iconHolder:SetAnchor( BOTTOM )
            else
                uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
            end
        end
    end
end

function SCB.SetIconsAlignmentVert( value )
    -- check correctness of argument value
    if value ~= L.Setting_Top and value ~= L.Setting_Middle and value ~= L.Setting_Bottom then
        value = SCB.D.AlignmentVert
    end
    SCB.SV.AlignmentVert = value

    if not SCB.Enabled then return end

    g_vertAlign = ( value == L.Setting_Top ) and TOP or ( value == L.Setting_Bottom ) and BOTTOM or MIDDLE

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            uiTlw[v].iconHolder:ClearAnchors()
            if uiTlw[v].alignVertical then
                -- Might need to consolidate these two functions somehow, possibly consolidate all options so that Left = Top, Middle = Center, Right = Bottom
                uiTlw[v].iconHolder:SetAnchor( g_vertAlign )
            else
                uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
            end
        end
    end
end

--[[
 * Sets horizontal sort direction. Called from Settings Menu.
 ]]--
function SCB.SetSortDirection( value )
    -- check correctness of argument value
    if value ~= L.Setting_OrderX[1] and value ~= L.Setting_OrderX[2] then
        value = SCB.D.SortDirection
    end
    SCB.SV.SortDirection = value

    g_horizSortInvert = (value == L.Setting_OrderX[2])
end

--[[
 * Reset position of windows. Called from Settings Menu.
 ]]--
function SCB.ResetTlwPosition()
    if not SCB.Enabled then return end
    SCB.SV.playerOffsetX = nil
    SCB.SV.playerOffsetY = nil
    SCB.SV.targetOffsetX = nil
    SCB.SV.targetOffsetX = nil
    SCB.SV.playerVOffsetX = nil
    SCB.SV.playerVOffsetY = nil
    SCB.SV.playerHOffsetX = nil
    SCB.SV.playerHOffsetY = nil
    SCB.SetTlwPosition()
end

--[[
 * Set position of windows. Called from .Initialize() and .ResetTlwPosition()
 ]]--
function SCB.SetTlwPosition()
    -- if icons are locked to custom frames, i.e. uiTlw[] is a CT_CONTROL of LUIE.UnitFrames.CustomFrames.player
    -- we do not have to do anything here. so just bail out

    -- otherwise set position of uiTlw[] which are CT_TOPLEVELCONTROLs to saved or default positions
    if uiTlw.player and uiTlw.player:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.player:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.playerOffsetX ~= nil and SCB.SV.playerOffsetY ~= nil then
            uiTlw.player:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerOffsetX, SCB.SV.playerOffsetY )
        else
            uiTlw.player:SetAnchor( BOTTOM, ZO_PlayerAttributeHealth, TOP, 0, -10 )
        end
    end

    if uiTlw.target and uiTlw.target:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.target:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.targetOffsetX ~= nil and SCB.SV.targetOffsetY ~= nil then
            uiTlw.target:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.targetOffsetX, SCB.SV.targetOffsetY )
        else
            uiTlw.target:SetAnchor( TOP, ZO_TargetUnitFramereticleover, BOTTOM, 0, 60 )
        end
    end

    if uiTlw.player_long then
        uiTlw.player_long:ClearAnchors()
        if uiTlw.player_long.alignVertical then
            if SCB.SV.playerVOffsetX ~= nil and SCB.SV.playerVOffsetY ~= nil then
                uiTlw.player_long:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerVOffsetX, SCB.SV.playerVOffsetY )
            else
                uiTlw.player_long:SetAnchor( BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, -3, -75 )
            end
        else
            if SCB.SV.playerHOffsetX ~= nil and SCB.SV.playerHOffsetY ~= nil then
                uiTlw.player_long:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerHOffsetX, SCB.SV.playerHOffsetY )
            else
                uiTlw.player_long:SetAnchor( BOTTOM, ZO_PlayerAttributeHealth, TOP, 0, -70 )
            end
        end
    end
end

--[[
 * Unlock windows for moving. Called from Settings Menu.
 ]]--
function SCB.SetMovingState( state )
    if not SCB.Enabled then return end

    -- set moving state
    if uiTlw.player and uiTlw.player:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.player:SetMouseEnabled( state )
        uiTlw.player:SetMovable( state )
    end
    if uiTlw.target and uiTlw.target:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.target:SetMouseEnabled( state )
        uiTlw.target:SetMovable( state )
    end
    if uiTlw.player_long then
        uiTlw.player_long:SetMouseEnabled( state )
        uiTlw.player_long:SetMovable( state )
    end

    -- show/hide preview
    for _, v in pairs(containerRouting) do
        uiTlw[v].preview:SetHidden( not state )
    end

    -- now create or remove test-effects icons
    for i = 1, #testEffectList do
        if state then
            SCB.CreatePreviewIcon( testEffectList[i] )
        else
            local effectName = testEffectPrefix .. testEffectList[i]
            g_effectsList.player1[effectName] = nil
            g_effectsList.player2[effectName] = nil
            g_effectsList.ground[effectName] = nil
        end
    end
end

--[[
 * Create preview icon for buff or debuff.
 ]]--
function SCB.CreatePreviewIcon( duration )
    SCB.NewEffects( {
        name = testEffectPrefix .. duration,
        icon = '/esoui/art/icons/icon_missing.dds',
        effects = { duration*1000, duration*1000+5, duration*1000, 0 }
    } )
end

function SCB.Reset()
    if not SCB.Enabled then return end

    -- update padding between icons
    g_padding = math.floor(0.5 + SCB.SV.IconSize / 13)

    -- set size of top level window
    -- player
    if uiTlw.player and uiTlw.player:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.player:SetDimensions( 500, SCB.SV.IconSize + 6 )
    else
        uiTlw.player2:SetHeight( SCB.SV.IconSize )

        uiTlw.player1:SetHeight( SCB.SV.IconSize * 2)
        uiTlw.player1.firstAnchor = { TOPLEFT, TOP }
        uiTlw.player1.maxIcons = math.floor(  (uiTlw.player1:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )
    end

    -- target
    if uiTlw.target and uiTlw.target:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.target:SetDimensions( 500, SCB.SV.IconSize + 6 )
    else
        uiTlw.target2:SetHeight( SCB.SV.IconSize )

        uiTlw.target1:SetHeight( SCB.SV.IconSize * 2)
        uiTlw.target1.firstAnchor = { TOPLEFT, TOP }
        uiTlw.target1.maxIcons = math.floor(  (uiTlw.target1:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )
    end

    -- player long buffs
    if uiTlw.player_long then
        if uiTlw.player_long.alignVertical then
            uiTlw.player_long:SetDimensions( SCB.SV.IconSize + 6, 400 )
        else
            uiTlw.player_long:SetDimensions( 500, SCB.SV.IconSize + 6 )
        end
    end

    -- reset alignment and sort
    SCB.SetIconsAlignment( SCB.SV.Alignment )
    SCB.SetIconsAlignmentVert( SCB.SV.AlignmentVert )
    SCB.SetSortDirection( SCB.SV.SortDirection )

    local needs_reset = {}
    -- and reset sizes of already existing icons
    for _, container in pairs(containerRouting) do
        needs_reset[container] = true
    end
    for _, container in pairs(containerRouting) do
        if needs_reset[container] then
            for i = 1, #uiTlw[container].icons do
                SCB.ResetSingleIcon( container, uiTlw[container].icons[i], uiTlw[container].icons[i-1] )
            end
        end
        needs_reset[container] = false
    end

    if g_playerActive then
        SCB.ReloadEffects()
    end
end

function SCB.ResetSingleIcon( container, buff, AnchorItem )
    local buffSize = SCB.SV.IconSize
    local frameSize = 2 * buffSize + 4

    buff:SetHidden( true )
    --buff:SetAlpha( 1 )
    buff:SetDimensions( buffSize, buffSize )
    buff.frame:SetDimensions( frameSize, frameSize )
    buff.back:SetHidden( SCB.SV.GlowIcons )
    buff.frame:SetHidden( not SCB.SV.GlowIcons )
    buff.label:SetHidden( not SCB.SV.RemainingText )
    if buff.cd ~= nil then
        buff.cd:SetHidden(     not SCB.SV.RemainingCooldown )
        buff.iconbg:SetHidden( not SCB.SV.RemainingCooldown ) -- we do not need black icon background when there is no Cooldown control present
    end

    local inset = (SCB.SV.RemainingCooldown and buff.cd ~= nil) and 4 or 1

    buff.icon:ClearAnchors()
    buff.icon:SetAnchor( TOPLEFT, buff, TOPLEFT, inset, inset )
    buff.icon:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -inset, -inset )
    if buff.iconbg ~= nil then
        buff.iconbg:ClearAnchors()
        buff.iconbg:SetAnchor( TOPLEFT, buff, TOPLEFT, inset -1, inset -1)
        buff.iconbg:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -inset +1, -inset +1)
    end

    -- position all items except first one to the right of it's neighbour
    -- first icon is positioned automatically if the container is present
    buff:ClearAnchors()
    if AnchorItem == nil then
        -- First Icon is positioned only when the container is present,
        if uiTlw[container].iconHolder then
            if uiTlw[container].alignVertical then
                buff:SetAnchor( BOTTOM, uiTlw[container].iconHolder, BOTTOM, 0, 0 )
            else
                buff:SetAnchor( LEFT, uiTlw[container].iconHolder, LEFT, 0, 0 )
            end
        end

        -- For container without holder we will reanchor first icon all the time

    -- rest icons go one after another.
    else
        if uiTlw[container].alignVertical then
            buff:SetAnchor( BOTTOM, AnchorItem, TOP, 0, -g_padding )
        else
            buff:SetAnchor( LEFT, AnchorItem, RIGHT, g_padding, 0 )
        end
    end
end

function SCB.CreateSingleIcon(container, AnchorItem)

    local buff = UI.Backdrop( uiTlw[container], nil, nil, {0,0,0,0.5}, {0,0,0,1}, false )

    -- enable tooltip
    buff:SetMouseEnabled( true )
    buff:SetHandler('OnMouseEnter', ZO_Options_OnMouseEnter)
    buff:SetHandler('OnMouseExit',  ZO_Options_OnMouseExit)
    buff.data = {}

    -- border
    buff.back   = UI.Texture( buff, nil, nil, '/esoui/art/actionbar/abilityframe64_up.dds', nil, false )
    buff.back:SetAnchor(TOPLEFT, buff, TOPLEFT)
    buff.back:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT)
    -- glow border
    buff.frame  = UI.Texture( buff, {CENTER,CENTER}, nil, nil, nil, false )
    -- background
    if container ~= "player_long" and container ~= "target1" then
        buff.iconbg = UI.Texture( buff, nil, nil, '/esoui/art/actionbar/abilityinset.dds', DL_CONTROLS, true )
        buff.iconbg = UI.Backdrop( buff, nil, nil, {0,0,0,0.9}, {0,0,0,0.9}, false )
        buff.iconbg:SetDrawLevel(DL_CONTROLS)
    end
    -- icon itself
    buff.icon   = UI.Texture( buff, nil, nil, '/esoui/art/icons/icon_missing.dds', DL_CONTROLS, false )
    -- remaining text label
    buff.label = UI.Label( buff, nil, nil, nil, buffsFont, nil, false )
    buff.label:SetAnchor(TOPLEFT, buff, LEFT, -g_padding)
    buff.label:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT, g_padding, -2)
    -- cooldown circular control
    if buff.iconbg ~= nil then
        buff.cd = WINDOW_MANAGER:CreateControl(nil, buff, CT_COOLDOWN)
        buff.cd:SetAnchor( TOPLEFT, buff, TOPLEFT, 1, 1 )
        buff.cd:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -1, -1 )
        buff.cd:SetDrawLayer(DL_BACKGROUND)
    end

    SCB.ResetSingleIcon(container, buff, AnchorItem)
    return buff
end

--[[
 * Set proper colour of border and text on single buff element
 ]]--
function SCB.SetSingleIconBuffType(buff, buffType)
    local contextType
    local colour
    if buffType == 1 then
        contextType = 'buff'
        colour = {0,1,0,1}
    else
        contextType = 'debuff'
        colour = {1,0,0,1}
    end
    -- {0.07, 0.45, 0.8}

    buff.frame:SetTexture('/esoui/art/actionbar/' .. contextType .. '_frame.dds')
    buff.label:SetColor( unpack( SCB.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
    if buff.cd ~= nil then buff.cd:SetFillColor( unpack(colour) ) end
end

--[[
 * Updates local variable with new font and resets all existing icons
 ]]--
function SCB.ApplyFont()
    if not SCB.Enabled then return end

    -- first try selecting font face
    local fontName = LUIE.Fonts[SCB.SV.BuffFontFace]
    if not fontName or fontName == '' then
        CHAT_SYSTEM:AddMessage('LUIE_SpellCastBuffs: There was a problem with selecting required font. Falling back to game default.')
        fontName = "$(MEDIUM_FONT)"
    end

    local fontStyle = ( SCB.SV.BuffFontStyle and SCB.SV.BuffFontStyle ~= '' ) and SCB.SV.BuffFontStyle or 'outline'
    local fontSize = ( SCB.SV.BuffFontSize and SCB.SV.BuffFontSize > 0 ) and SCB.SV.BuffFontSize or 17

    buffsFont = fontName .. '|' .. fontSize .. '|' .. fontStyle

    local needs_reset = {}
    -- and reset sizes of already existing icons
    for _, container in pairs(containerRouting) do
        needs_reset[container] = true
    end
    for _, container in pairs(containerRouting) do
        if needs_reset[container] then
            for i = 1, #uiTlw[container].icons do
                uiTlw[container].icons[i].label:SetFont(buffsFont)
            end
        end
        needs_reset[container] = false
    end

end

--[[
 * Check for whether a potion becomes available from cooldown
 * Runs OnUpdate - 200 ms buffer
 ]]--
function SCB.CheckPotion()

    -- Get the cooldown
    local usable = ZO_ActionBar_GetButton(9).usable

    -- Create alerts or new buff icons only if quick slot was not changed recently
    if g_quickslotLastSame and g_quickslotAbility then

        -- Trigger an alert if the potion has just become available
        if ( usable and not g_quickslotLastUsable ) then
            CI.CreatePotionAlert(g_quickslotAbility) -- (g_quickslotAbility.name)
        end

    end

    -- Update the potion status
    g_quickslotLastSame = true
    g_quickslotLastUsable = usable
end

--[[
 * Runs on the EVENT_ACTIVE_QUICKSLOT_CHANGED listener.
 * This handler fires every time the player make changes to quick slot.
 ]]--
function SCB.OnActiveQuickslotChanged(eventCode, slotNum)
    g_quickslotLastSame = false
    local abilityId = GetSlotBoundId(slotNum)
    local potionEffect = PotionEffects[abilityId]
    if potionEffect then
        g_quickslotAbility = GetSlotName(slotNum)
    else
        g_quickslotAbility = nil
    end
end

--[[
 * Runs on the EVENT_ACTION_UPDATE_COOLDOWNS listener.
 * This handler fires every time the player uses an active ability.
 ]]--
function SCB.OnUpdateCooldowns()
    -- Maybe process a ground-target spell
    if ( g_pendingGroundAbility ~= nil ) then
        -- Cast ability
        SCB.NewEffects( g_pendingGroundAbility )
        -- Clear the ground target queue
        g_pendingGroundAbility = nil
    end
end

--[[
 * Runs on the EVENT_EFFECT_CHANGED listener.
 * This handler fires every long-term effect added or removed:
 *   integer changeType,
 *   integer effectSlot,
 *   string effectName,
 *   string unitTag,
 *   number beginTime,
 *   number endTime,
 *   integer stackCount,
 *   string iconName,
 *   string buffType,
 *   integer effectType,
 *   integer abilityType,
 *   integer statusEffectType
 ]]--
function SCB.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId)
    --CHAT_SYSTEM:AddMessage(strfmt('OnEffectChanged %d: %s[%s] / %d/%d/%d [%s-%d] %d', changeType, effectName, unitTag, effectType, abilityType, statusEffectType, unitName, unitId, abilityId ))

    --printToChat ( "On effect changed! --> " .. changeType)

    -- track only effects on self or target debuffs
    if unitTag ~= 'player' and unitTag ~= 'reticleover' then return end

    --if effectType == 2 and changeType == 2 and HideDebuffToggle[abilityId] then HideDebuffToggle[abilityId] = false end -- Alot of debuffs when reapplied don't refresh, they end then apply. This will reset if this happens.

    if (effectType == 2 and HideDebuffToggle[abilityId]) and not (E.DebuffDisplayOverrideId[abilityId] or E.DebuffDisplayOverrideName[effectName]) then
            return
    end

    -- Ignore some buffs (by abilityId or by effectName)
    if E.IsEffectIgnored[ effectName ] or E.IsAbilityIgnoredById[abilityId] or
        ( SCB.SV.IgnoreDisguise and abilityType == ABILITY_TYPE_CHANGEAPPEARANCE ) or
        ( SCB.SV.IgnoreMundus and E.IsBoon[ effectName ] ) or
        ( SCB.SV.IgnoreEquipment and E.IsEquipmentSet[ effectName ] ) or
        ( SCB.SV.IgnoreVampLycan and E.IsVampLycan[ effectName ] ) or
        ( SCB.SV.IgnoreCyrodiil and (E.IsCyrodiil[ effectName ] or strfind(effectName, 'Keep Bonus') or strfind(effectName, strHomeKeep) or strfind(effectName, strEnemyKeep) ) )
    then return end

    -- Override some buff info
    if E.EffectTypeOverride[abilityId] then
        effectType = E.EffectTypeOverride[abilityId]
    end

    -- Allows us to overwrite Ability Icons in one of two ways, by specific abilityId or by effectName
    iconName = E.EffectIconOverride[abilityId] or E.AbilityIcon[effectName or ''] or iconName

    -- Allows us to overwrite Ability Names (Note that using this may break certain hidden icon functionality, should only be used when neccesary. Use base ability ID only for other modifications)
    effectName = E.EffectNameOverride[abilityId] or effectName

    -- Where the new icon will go into
    local context = unitTag .. effectType

    -- Exit here if there is no container to hold this effect
    if not containerRouting[context] then return end

    if changeType == EFFECT_RESULT_FADED then -- delete Effect
        g_effectsList[context][abilityId] = nil

        -- also delete visual enhancements from skill bar
        if unitTag == "player" then
            -- stop any proc animation associated with this effect
            if abilityType == ABILITY_TYPE_BONUS and TriggeredSlots[effectName] and uiProcAnimation[TriggeredSlots[effectName]] then
                uiProcAnimation[TriggeredSlots[effectName]]:Stop()
            end

            -- switch off custom toggle highlight
            if ToggledSlots[effectName] and uiCustomToggle[ToggledSlots[effectName]] then
                uiCustomToggle[ToggledSlots[effectName]]:SetHidden(true)
            end
        end

    -- create Effect
    else
        local duration = endTime - beginTime

        -- Block has an aura, but 0 duration, this allows it to display as a toggleable effect.
        if abilityType == ABILITY_TYPE_BLOCK then
            g_effectsList[context][ abilityId ] = {
                        target=unitTag, type=effectType,
                        id=abilityId, name=effectName, icon=iconName,
                        dur=0, starts=0, ends=nil, -- ends=nil : last buff in sorting
                        forced="short",
                        restart=true, iconNum=0 }
            -- clear groud pending ability
            g_pendingGroundAbility = nil
        else
            -- Buffs are created based on their ability ID, this allows buffs with the same display name to show up.
            g_effectsList[context][ abilityId ] = {
                        target=unitTag, type=effectType,
                        id=abilityId, name=effectName, icon=iconName,
                        dur=1000*duration, starts=1000*beginTime, ends=(duration > 0) and (1000*endTime) or nil,
                        forced=E.EffectForcedType[abilityId],
                        restart=true, iconNum=0 }
        end

        -- also create visual enhancements from skill bar
        if unitTag == "player" then
            -- start any proc animation associated with this effect
            if abilityType == ABILITY_TYPE_BONUS and TriggeredSlots[effectName] then
                SCB.PlayProcAnimations(TriggeredSlots[effectName])
            end

            -- switch on custom toggle highlight
            if ToggledSlots[effectName] then
                SCB.ShowCustomToggle(ToggledSlots[effectName])
            end
        end
    end
end

--[[
 * List of all damage results for analysis in following function
 * This also includes SHIELDED result that is not included in CI module
 ]]--
local IsResultDamage = {
    [ACTION_RESULT_DAMAGE]          = true,
    [ACTION_RESULT_BLOCKED_DAMAGE]  = true,
    [ACTION_RESULT_DAMAGE_SHIELDED] = true,
    [ACTION_RESULT_CRITICAL_DAMAGE] = true,
    [ACTION_RESULT_DOT_TICK]        = true,
    [ACTION_RESULT_DOT_TICK_CRITICAL]= true,
}

--[[
 * Runs on the EVENT_COMBAT_EVENT listener.
 * This handler fires every time ANY combat activity happens. Very-very often.
 * We use it to remove mines from active target debuffs
 * As well as create fake buffs/debuffs for events with no active effect present.
 ]]--
function SCB.OnCombatEvent( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )

    -- ignore error events
    if isError then return end

    buffSource = zo_strformat("<<t:1>>",sourceName)
    buffTarget = zo_strformat("<<t:1>>",targetName)

    --printToChat ( "Ability ID: " .. abilityId .. ": " .. sourceName .. " --> " .. targetName)

    -- try to remove effect like Ground Runes and Traps
    if E.IsGroundMine[abilityName] and IsResultDamage[result]
        and ( targetType == COMBAT_UNIT_TYPE_NONE or targetType == COMBAT_UNIT_TYPE_OTHER)
        then
        g_effectsList.ground[ abilityName ] = nil
    end

------------------------------------------------------------------------------------

    -- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on player by target)
    if E.FakeExternalBuffs[abilityId] ~= nil then
        iconName = E.FakeExternalBuffs[abilityId].icon
        effectName = E.FakeExternalBuffs[abilityId].name
        duration = E.FakeExternalBuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = zo_strformat("<<t:1>>",sourceName)
        local target = zo_strformat("<<t:1>>",targetName)
        if source ~= "" and target == playerName then
            g_effectsList.player1[ abilityId ] = {
            type=EFFECT_TYPE_DEBUFF,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        elseif source == "" and target == playerName then
            g_effectsList.player1[ abilityId ] = nil
        end
    end

------------------------------------------------------------------------------------

    -- Creatures fake debuff icons for debuffs without an aura - These refresh on reapplication/removal (Applied on player by target)
    if E.FakeExternalDebuffs[abilityId] ~= nil then
        iconName = E.FakeExternalDebuffs[abilityId].icon
        effectName = E.FakeExternalDebuffs[abilityId].name
        duration = E.FakeExternalDebuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = zo_strformat("<<t:1>>",sourceName)
        local target = zo_strformat("<<t:1>>",targetName)
        if source ~= "" and target == playerName then
            g_effectsList.player2[ abilityId ] = {
            type=EFFECT_TYPE_DEBUFF,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        elseif source == "" and target == playerName then
            g_effectsList.player2[ abilityId ] = nil
        end
    end

------------------------------------------------------------------------------------

    -- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on player by player OR applied on target by player)
    if E.FakePlayerBuffs[abilityId] ~= nil then
        iconName = E.FakePlayerBuffs[abilityId].icon
        effectName = E.FakePlayerBuffs[abilityId].name
        duration = E.FakePlayerBuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = zo_strformat("<<t:1>>",sourceName)
        local target = zo_strformat("<<t:1>>",targetName)
        if source == playerName and target == playerName then
            g_effectsList.player1[ abilityId ] = {
            type=1,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        elseif source == playerName and target ~= playerName and target ~= nil then -- Can add an aura for buffs applied on target by player, can't be removed other than via timing out
            g_effectsList.reticleover1[ abilityId ] = {
            type=1,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        elseif source == "" and target == playerName then
            g_effectsList.player1[ abilityId ] = nil
        end
    end

------------------------------------------------------------------------------------

    -- Creates fake debuff icons for debuffs without an aura - These refresh on reapplication/removal (Applied on target by player)
    if E.FakePlayerDebuffs[abilityId] ~= nil then
        iconName = E.FakePlayerDebuffs[abilityId].icon
        effectName = E.FakePlayerDebuffs[abilityId].name
        duration = E.FakePlayerDebuffs[abilityId].duration
        effectType = EFFECT_TYPE_DEBUFF
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = zo_strformat("<<t:1>>",sourceName)
        local target = zo_strformat("<<t:1>>",targetName)
        if source == playerName and target ~= nil then
            g_effectsList.ground[ abilityId ] = {
            type=effectType,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        end
    end

------------------------------------------------------------------------------------

    -- Simulates fake debuff icons for stagger effects - works for both (target -> player) and (player -> target) - DOES NOT REFRESH - Only expiration condition is the timer
    if E.FakeStagger[abilityId] ~= nil then
        iconName = E.FakeStagger[abilityId].icon
        effectName = E.FakeStagger[abilityId].name
        duration = E.FakeStagger[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = zo_strformat("<<t:1>>",sourceName)
        local target = zo_strformat("<<t:1>>",targetName)
        if source ~= "" and target == playerName then
            g_effectsList.player2[ abilityId ] = {
            type=EFFECT_TYPE_DEBUFF,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        elseif source == playerName and target ~= nil then
            g_effectsList.reticleover2[ abilityId ] = {
            type=EFFECT_TYPE_DEBUFF,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        end
    end

    -- Simulates fake buffs/debuffs on the player frame for self applied buffs/debuffs that do not display correctly - DOES NOT REFRESH - Only expiration condition is the timer
    if E.FakeSelfAura[abilityId] ~= nil then
        iconName = E.FakeSelfAura[abilityId].icon
        effectName = E.FakeSelfAura[abilityId].name
        duration = E.FakeSelfAura[abilityId].duration
        style = E.FakeSelfAura[abilityId].style
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = zo_strformat("<<t:1>>",sourceName)
        local target = zo_strformat("<<t:1>>",targetName)
        if source == playerName and target == playerName and style == buff then -- Used for certain self applied buffs we need to simulate to fix incorrect display
            g_effectsList.player1[ abilityId ] = {
            type=1,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        elseif source == playerName and target == playerName and style == debuff then -- Used for certain self applied buffs we need to simulate to fix incorrect display
            g_effectsList.player2[ abilityId ] = {
            type=EFFECT_TYPE_DEBUFF,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        end
    end

    if result == 2250 then
        return
    else
        if buffSource == "" and buffTarget == "" then
            HideDebuffToggle[abilityId] = true
        end

        if buffSource ~= "" and buffTarget ~= "" then
            HideDebuffToggle[abilityId] = false
        end
    end

------------------------------------------------------------------------------------

end

--[[
 * Runs on the EVENT_UNIT_DEATH_STATE_CHANGED listener.
 * This handler fires every time a valid unitTag dies or is resurrected
 ]]--
function SCB.OnDeath(eventCode, unitTag, isDead)
    -- Wipe buffs
    if isDead then
        for effectType = 1, 2 do
            g_effectsList[ unitTag .. effectType ] = {}
        end
    end

    -- and toggle buttons
    if unitTag == 'player' then
        for slotNum = 3, 8 do
            if uiCustomToggle[slotNum] then
                uiCustomToggle[slotNum]:SetHidden(true)
            end
        end
    end
end

--[[
 * Runs on the EVENT_TARGET_CHANGE listener.
 * This handler fires every time the someone target changes.
 * This function is needed in case the player teleports via Way Shrine
 ]]--
function SCB.OnTargetChange(eventCode, unitTag)
    if unitTag ~= "player" then return end
    SCB.OnReticleTargetChanged(eventCode)
end

--[[
 * Runs on the EVENT_RETICLE_TARGET_CHANGED listener.
 * This handler fires every time the player's reticle target changes
 ]]--
function SCB.OnReticleTargetChanged(eventCode)
    SCB.ReloadEffects('reticleover')
end

--[[
 * Used to clear existing LET.effectsList.unitTag and to request game API to fill it again
 ]]--
function SCB.ReloadEffects(unitTag)

    -- if unitTag was not provided, consider it as Player
    local unitTag = unitTag or "player"

    -- clear existing
    g_effectsList[unitTag .. 1] = {}
    g_effectsList[unitTag .. 2] = {}

    -- fill it again

    --printToChat ( "refresh" )

    for i = 1, GetNumBuffs(unitTag) do
        local unitName = GetRawUnitName(unitTag)
        local buffName, timeStarted, timeEnding, buffSlot, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer = GetUnitBuffInfo(unitTag, i)
        if effectType == 2 and castByPlayer then HideDebuffToggle[abilityId] = false end
        if effectType == 2 and not castByPlayer then  HideDebuffToggle[abilityId] = true end
        SCB.OnEffectChanged(0, 3, buffSlot, buffName, unitTag, timeStarted, timeEnding, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, unitName, 0--[[unitId]], abilityId)
    end

    -- create custom buff icon for Recall Cooldown effect
    if unitTag == "player" then
        local recallRemain, _ = GetRecallCooldown()
        if recallRemain > 0 then
            local currentTime = GetGameTimeMilliseconds()
            g_effectsList["player1"][ recallEffectName ] = {
                        target="player", type=1,
                        name=recallEffectName, icon=recallIconFilename,
                        dur=recallRemain, starts=currentTime, ends=currentTime+recallRemain,
                        forced = "long",
                        restart=true, iconNum=0 }
        end
    end

end

--[[
 * Process new ability buff effects
 ]]--
function SCB.NewEffects( ability )

    -- Get the time
    local currentTime = GetGameTimeMilliseconds()

    -- Try manually tracked effects first
    local effects = ability.effects
    if ( effects ~= nil ) then

        for i = 1, 3 do
            local context = abilityRouting[i]

            if effects[i] and effects[i] > 0 then
                -- update or create new effect
                if g_effectsList[context][ability.name] ~= nil then
                    g_effectsList[context][ability.name].ends = currentTime + effects[4] + effects[i]
                    g_effectsList[context][ability.name].restart = true
                else
                    g_effectsList[context][ability.name] = {
                        target  = ( i < 3 ) and "player" or "reticleover",
                        type    = ( i == 1 ) and 1 or 2,
                        name    = ability.name,
                        icon    = ability.icon,
                        dur     = effects[i],
                        starts  = currentTime + effects[4],
                        ends    = currentTime + effects[4] + effects[i],
                        restart = true,
                        iconNum = 0
                    }
                end
            end

        end

    end
end

-- Callback functions

--[[
 * Called from EVENT_ACTION_SLOT_ABILITY_USED listener
 *
 * Check for whether a spell is being cast
 ]]--
function SCB.OnSlotAbilityUsed(eventCode, slotNum)

    -- clear stored ground-target ability
    g_pendingGroundAbility = nil

        -- Get the used ability
    local ability = ActionBar[slotNum]

    if ability then -- only proceed if this button is being watched

        -- Get the time
        local currentTime = GetGameTimeMilliseconds()

        -- avoid failure and button mashing
        if not HasFailure( slotNum ) and ( currentTime > g_lastCast + 250 ) then

            -- Don't process effects immediately for ground-target spells
            if ability.ground then
                g_pendingGroundAbility = ability

            else
                -- Run all routines associated with selected ability
                SCB.NewEffects( ability )

                -- Flag the last cast time
                g_lastCast = currentTime
            end
        end
    end
end

--[[
 * Called from EVENT_ACTION_SLOT_UPDATED listener
 ]]--
function SCB.OnSlotUpdated(eventCode, slotNum)
    --CHAT_SYSTEM:AddMessage( strfmt("%d: %s(%d)", slotNum, GetSlotName(slotNum), GetSlotBoundId(slotNum) ) )

    -- Look only for action bar slots
    if slotNum < 3 or slotNum > 8 then return end

    -- remove saved triggered proc information
    for abilityName, slot in pairs(TriggeredSlots) do
        if (slot == slotNum) then
            TriggeredSlots[abilityName] = nil
        end
    end
    -- stop possible proc animation
    if uiProcAnimation[slotNum] and uiProcAnimation[slotNum]:IsPlaying() then
        uiProcAnimation[slotNum]:Stop()
    end

    -- remove custom toggle information and custom highlight
    for abilityName, slot in pairs(ToggledSlots) do
        if (slot == slotNum) then
            ToggledSlots[abilityName] = nil
        end
    end
    if uiCustomToggle[slotNum] then
        uiCustomToggle[slotNum]:SetHidden(true)
    end

    -- Bail out if slot is not used
    if not IsSlotUsed(slotNum) then
        ActionBar[slotNum] = nil
        return
    end

    -- Get the slotted ability ID
    local ability_id = GetSlotBoundId(slotNum)

    -- Get additional ability information
    local abilityName = GetAbilityName(ability_id) -- GetSlotName(slotNum)
    -- Localization ^^ here. We will use English name from here onwards.
    local abilityCost, mechanicType = GetSlotAbilityCost(slotNum)
    -- Get API information for this ability
    local channeled, castTime, channelTime = GetAbilityCastInfo(ability_id)
    local duration = GetAbilityDuration(ability_id)

    local effects = nil
    if Effects[ abilityName ] then
        effects = {}
        for i = 1, 4 do
            if not Effects[ abilityName ][i] or Effects[ abilityName ][i] == 0 then
                effects[i] = 0
            elseif Effects[ abilityName ][i] == true then
                effects[i] = (i < 4) and duration or castTime
            else
                effects[i] = Effects[ abilityName ][i] * 1000
            end
        end
    end

    ActionBar[slotNum] = {
        id      = ability_id,
        name    = abilityName,
        type    = mechanicType,
        cost    = abilityCost,
        icon    = GetSlotTexture(slotNum),
        ground  = ( GetAbilityTargetDescription(ability_id) == L.Ability_Target_Description_Ground ),
        effects = effects
    }

    -- check if currently this ability is in proc state
    local proc = HasAbilityProc[abilityName]
    if IsAbilityProc[abilityName] then
        SCB.PlayProcAnimations(slotNum)
    elseif proc then
        TriggeredSlots[proc] = slotNum
        if g_effectsList.player1[proc] then
            SCB.PlayProcAnimations(slotNum)
        end
    end

    -- check if current skill is our custom toggle skill and save it
    if IsAbilityCustomToggle[abilityName] then
        ToggledSlots[abilityName] = slotNum
        if g_effectsList.player1[ability_id] then
            SCB.ShowCustomToggle(slotNum)
        end
    end
end

function SCB.OnSlotsFullUpdate(eventCode, isHotbarSwap)
    -- if the event was triggered by a weapon swap we need to clear ground-target stored ability
    if isHotbarSwap then
        g_pendingGroundAbility = nil
    end

    -- update action bar skills
    ActionBar = {}
    for i = 3, 8 do
        SCB.OnSlotUpdated(eventCode, i)
    end
end

--[[
 * Starts proc animation
 ]]--
function SCB.PlayProcAnimations(slotNum)
    if not uiProcAnimation[slotNum] then
        local actionButton = ZO_ActionBar_GetButton(slotNum)
        local procLoopTexture = WINDOW_MANAGER:CreateControl("$(parent)Loop_LUIE", actionButton.slot, CT_TEXTURE)
        procLoopTexture:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
        procLoopTexture:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"))
        procLoopTexture:SetTexture("/esoui/art/actionbar/abilityhighlight_mage_med.dds")
        procLoopTexture:SetBlendMode(TEX_BLEND_MODE_ADD)
        procLoopTexture:SetDrawLevel(2)
        procLoopTexture:SetHidden(true)

        local procLoopTimeline = ANIMATION_MANAGER:CreateTimelineFromVirtual("UltimateReadyLoop", procLoopTexture)
        procLoopTimeline.procLoopTexture = procLoopTexture

        procLoopTimeline.onPlay = function(self) self.procLoopTexture:SetHidden(false) end
        procLoopTimeline.onStop = function(self) self.procLoopTexture:SetHidden(true) end

        procLoopTimeline:SetHandler("OnPlay", procLoopTimeline.onPlay)
        procLoopTimeline:SetHandler("OnStop", procLoopTimeline.onStop)

        uiProcAnimation[slotNum] = procLoopTimeline
    end
    if uiProcAnimation[slotNum] then
        if not uiProcAnimation[slotNum]:IsPlaying() then
            uiProcAnimation[slotNum]:PlayFromStart()
        end
    end
end

--[[
 * Displays custom toggle texture
 ]]--
function SCB.ShowCustomToggle(slotNum)
    if not uiCustomToggle[slotNum] then
        local actionButton = ZO_ActionBar_GetButton(slotNum)
        local toggleTexture = WINDOW_MANAGER:CreateControl("$(parent)Toggle_LUIE", actionButton.slot, CT_TEXTURE)
        toggleTexture:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
        toggleTexture:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"))
        toggleTexture:SetTexture("/esoui/art/actionbar/actionslot_toggledon.dds")
        toggleTexture:SetBlendMode(TEX_BLEND_MODE_ADD)
        toggleTexture:SetDrawLayer(0)
        toggleTexture:SetDrawLevel(0)
        toggleTexture:SetDrawTier(2)
        toggleTexture:SetColor(0.5,1,0.5,1)
        toggleTexture:SetHidden(true)

        uiCustomToggle[slotNum] = toggleTexture
    end
    if uiCustomToggle[slotNum] then
        uiCustomToggle[slotNum]:SetHidden(false)
    end
end

--[[
 * Helper function to sort buffs
 ]]--
local function buffSort(x, y)
    -- sort pernament effects
    if (x.ends == nil and y.ends == nil) or (x.dur == 0 and y.dur == 0) then
        return (x.starts == y.starts) and (x.name < y.name) or (x.starts < y.starts)

    -- both non-permanent
    elseif x.dur ~= 0 and y.dur ~= 0 then
        return x.ends > y.ends

    -- one permanent, one not
    else
        return (x.dur == 0)
    end
end

--[[
 * Runs OnUpdate - 100 ms buffer
 ]]--
function SCB.OnUpdate(currentTime)
    -- local currentTime = GetGameTimeMilliseconds()

    local buffsSorted = {}

    local needs_update = {}
    -- and reset sizes of already existing icons
    for _, container in pairs(containerRouting) do
        needs_update[container] = true
        -- prepare sort container
        if buffsSorted[container] == nil then
            buffsSorted[container] = {}
        end
    end

    -- filter expired events. and build array for sorting
    for context, effectsList in pairs(g_effectsList) do
        local container = containerRouting[context]

        for k, v in pairs(effectsList) do

            -- remove effect (that is not permanent and has duration)
            if v.ends ~= nil and v.dur > 0 and v.ends < currentTime then
                effectsList[k] = nil
                -- switch off custom toggle highlight
                if ToggledSlots[k] and uiCustomToggle[ToggledSlots[k]] then
                    uiCustomToggle[ToggledSlots[k]]:SetHidden(true)
                end

            -- or append to correct container
            elseif container then
                -- add icons to to-be-sorted list only if effect already started
                if v.starts < currentTime then
                    -- Filter Long-Term effects:
                    -- Always show debuffs and short-term buffs
                    if v.type == 2 or v.forced == "short" or not (v.forced == "long" or v.ends == nil or v.dur == 0 or v.ends-currentTime > 120000) then
                        table.insert(buffsSorted[container], v)

                    -- Show long-term target buffs in same container
                    elseif v.target == "reticleover" and SCB.SV.LongTermEffects_Target then
                        table.insert(buffsSorted[container], v)

                    -- Show long-term player buffs
                    elseif v.target == "player" and SCB.SV.LongTermEffects_Player then
                        -- Choose container for long-term player buffs
                        if SCB.SV.LongTermEffectsSeparate then
                            table.insert(buffsSorted.player_long, v)
                        else
                            table.insert(buffsSorted[container], v)
                        end

                    end
                end
            end

        end
    end

    -- sort effects in container and draw them on screen
    for _, container in pairs(containerRouting) do
        if needs_update[container] then
            table.sort(buffsSorted[container], buffSort)
            SCB.updateIcons( currentTime, buffsSorted[container], container )
        end
        needs_update[container] = false
    end
end

function SCB.updateIcons( currentTime, sortedList, container )

    -- speial workaround for container with player long buffs. We do not need to update it every 100ms, but rather 3 times less often
    if uiTlw[container].skipUpdate then
        uiTlw[container].skipUpdate = uiTlw[container].skipUpdate + 1
        if uiTlw[container].skipUpdate > 1 then
            uiTlw[container].skipUpdate = 0
        else
            return
        end
    end

    local iconsNum = #sortedList

    -- chose direction of iteration
    local istart, iend, istep
    -- reverse the order for right aligned icons
    if g_horizSortInvert and not uiTlw[container].alignVertical then
        istart, iend, istep = iconsNum, 1, -1
    else
        istart, iend, istep = 1, iconsNum, 1
    end

    -- size of icon+padding
    local iconSize = SCB.SV.IconSize + g_padding

    -- Set width of contol that holds icons. This will make alignment automatic
    if uiTlw[container].iconHolder then
        if uiTlw[container].alignVertical then
            uiTlw[container].iconHolder:SetDimensions( 0, iconSize*iconsNum - g_padding )
        else
            uiTlw[container].iconHolder:SetDimensions( iconSize*iconsNum - g_padding, 0 )
        end
    end

    -- prepare variables for manual alignment of icons
    local row = 0   -- row counter for multi-row placement
    local next_row_break = 1

    -- iterate over list of sorted icons
    local index = 0 -- global icon counter
    for i = istart, iend, istep do
        -- get current buff definition
        local effect = sortedList[i]
        index = index + 1
        -- check if the icon for buff #index exists otherwise create new icon
        if uiTlw[container].icons[index] == nil then
            uiTlw[container].icons[index] = SCB.CreateSingleIcon(container, uiTlw[container].icons[index-1])
        end

        -- calculate remaining time
        local remain = ( effect.ends ~= nil ) and ( effect.ends - currentTime ) or nil

        -- Deprecated
        -- manually adjust this value to constant one for vampirism stages, so we can print textual value
        --if E.IsVampStage(effect) then
        --  remain = nil
        --end

        local buff = uiTlw[container].icons[index]

        -- perform manual alignment
        if not uiTlw[container].iconHolder then
            if iconsNum ~= uiTlw[container].prevIconsCount and index == next_row_break --[[ and horizontal orientation of container ]] then
                -- padding of first icon in a row
                local anchor, leftPadding
                if g_horizAlign == LEFT then
                    anchor = TOPLEFT
                    leftPadding = g_padding
                elseif g_horizAlign == RIGHT then
                    anchor = TOPRIGHT
                    leftPadding = - math.min(uiTlw[container].maxIcons, iconsNum-uiTlw[container].maxIcons*row) * iconSize - g_padding
                else
                    anchor = TOP
                    leftPadding = - 0.5 * ( math.min(uiTlw[container].maxIcons, iconsNum-uiTlw[container].maxIcons*row) * iconSize - g_padding )
                end

                buff:ClearAnchors()
                buff:SetAnchor( TOPLEFT, uiTlw[container], anchor, leftPadding, row*iconSize )
                -- determine if we need to make next row
                if uiTlw[container].maxIcons then
                    row = row + 1
                    next_row_break = next_row_break + uiTlw[container].maxIcons
                end
            end
        end

        -- if previously this icon was used for different effect, then setup it again
        if effect.iconNum ~= index then
            effect.iconNum = index
            effect.restart = true
            SCB.SetSingleIconBuffType(buff, effect.type)
            buff.data.tooltipText = effect.name --.. ' || ' .. (effect.id or '?')
            buff.icon:SetTexture(effect.icon)
            buff:SetAlpha(1)
            buff:SetHidden(false)
            if not remain then
                buff.label:SetText( E.IsToggle[effect.name] and 'T' or nil )
                -- buff.label:SetText( E.IsToggle[effect.name] and 'T' or E.IsVampStage(effect) and ("Fuck" .. E.IsVampStage(effect)) or nil ) -- Deprecated
            end
        end

        -- for update remaining text. For temporary effects this is not very efficient, but we have not much such effects
        if remain then
            if remain > 86400000 then -- more then 1 day
                buff.label:SetText( strfmt('%d d', math.floor( remain/86400000 )) )
            elseif remain > 6000000 then -- over 100 minutes - display XXh
                buff.label:SetText( strfmt('%dh', math.floor( remain/3600000 )) )
            elseif remain > 600000 then -- over 10 minutes - display XXm
                buff.label:SetText( strfmt('%dm', math.floor( remain/60000 )) )
            elseif remain > 60000 or container == "player_long" then
                local m = math.floor( remain/60000 )
                local s = remain/1000 - 60*m
                buff.label:SetText( strfmt('%d:%.2d', m, s) )
            else
                buff.label:SetText( strfmt(SCB.SV.RemainingTextMillis and '%.1f' or '%.2d', remain/1000) )
            end
        end
        if effect.restart and buff.cd ~= nil then
            if remain == nil or effect.dur == nil or effect.dur == 0 then
                buff.cd:StartCooldown(0, 0, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_UNTIL, false )
            elseif remain > 8000 then
                buff.cd:StartCooldown(100000, 100000, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_UNTIL, false )
            else
                buff.cd:StartCooldown(remain, 8000, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_UNTIL, false )
                effect.restart = false
            end
        end

        -- now possibly fade out expiring icon
        if SCB.SV.FadeOutIcons and remain ~= nil and remain < 2000 then
            --buff:SetAlpha( 0.05 + remain/2106 )
            buff:SetAlpha(E.easeOutQuad(remain, 0, 1, 2000))
        end
    end

    -- hide rest of icons
    for i = iconsNum+1, #uiTlw[container].icons do
        uiTlw[container].icons[i]:SetHidden(true)
    end

    -- save icon number processed to compare in next update iteration
    uiTlw[container].prevIconsCount = iconsNum
end

--[[
 * Runs on the EVENT_STEALTH_STATE_CHANGED listener.
 * Watches for changes in a stealth state to display custom buff icon
 ]]--
function SCB.StealthStateChanged( eventCode , unitTag , stealthState )
    if unitTag ~= 'player' then return end

    if ( SCB.SV.StealthState and
        ( stealthState == STEALTH_STATE_HIDDEN or
        stealthState == STEALTH_STATE_STEALTH or
        stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED or
        stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED )
        --and ( g_stealth == STEALTH_STATE_DETECTED or g_stealth == STEALTH_STATE_NONE )
        ) then

        -- Trigger a buff
        g_effectsList.player1[ strHidden ] = {
                        type=1,
                        name=strHidden, icon='LuiExtended/media/icons/abilities/ability_innate_hidden.dds',
                        dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                        forced = "short",
                        restart=true, iconNum=0 }

    -- else remove buff
    else
        g_effectsList.player1[ strHidden ] = nil
    end

    -- Save the previous stealthed state
    g_stealth = stealthState
end

function SCB.OnPlayerActivated(eventCode)
    -- Write current Action Bar and quick slot state
    SCB.OnSlotsFullUpdate(eventCode)
    SCB.OnActiveQuickslotChanged(eventCode, GetCurrentQuickslot())

    g_playerActive = true
    g_playerResurectStage = nil

    SCB.ReloadEffects( "player" )
end

function SCB.OnPlayerDeactivated(eventCode)
    g_playerActive = false
    g_playerResurectStage = nil
end

function SCB.OnPlayerAlive(eventCode)
    --[[-- If player clicks "Resurrect at Wayshrine", then player is first deactivated,
    then he is transferred to new position,
    then he becomes alive -->>-- this event
    then player is activated again.
    Thus to register resurrection we need to work in this function if player is already active. --]]--
    if not g_playerActive or not g_playerDead then return end

    g_playerDead = false

    -- this is a good place to reload player buffs, as they were wiped on death
    SCB.ReloadEffects( "player" )

    -- now let start sequence to determine how the player become alive
    g_playerResurectStage = 1
    --[[-- If it was self resurrection, then there will be 4 EVENT_VIBRATION:
    First - 600ms, second - 0ms to switch first one off
    Third - 350ms, fourth - 0ms to switch third one off.
    So now we'll listen in the vibration event and progress g_playerResurectStage with first 2 events.
    And then on correct third event we'll create a buff. --]]--
end

function SCB.OnPlayerDead(eventCode)
    if not g_playerActive then return end
    g_playerDead = true
end

function SCB.OnVibration(eventCode, duration, coarseMotor, fineMotor, leftTriggerMotor, rightTriggerMotor)
    if not g_playerResurectStage then return end
    if g_playerResurectStage == 1 and duration == 600 then
        g_playerResurectStage = 2
    elseif g_playerResurectStage == 2 and duration == 0 then
        g_playerResurectStage = 3
    elseif g_playerResurectStage == 3 and duration == 350 then
        -- we got correct sequence, so let us create a buff and reset the g_playerResurectStage
        g_playerResurectStage = nil
        SCB.NewEffects( {
            name = 'Resurrection Immunity',
            icon = 'LuiExtended/media/icons/abilities/ability_player_resurrection_immunity.dds',
            effects = {10000, 0, 0, 0}
        } )
    else
        -- this event does not seem to have anything to do with player self-resurrection
        g_playerResurectStage = nil
    end
end
