------------------
-- SpellCastBuffs namespace
LUIE.SpellCastBuffs = {}

-- Performance Enhancement
local SCB           = LUIE.SpellCastBuffs
local CI            = LUIE.CombatInfo
local UI            = LUIE.UI
local E             = LUIE.Effects
local A             = LUIE.GetAbility()
local printToChat   = LUIE.PrintToChat
local strfmt		= string.format
local strformat	    = zo_strformat
local pairs 		= pairs

local moduleName    = LUIE.name .. "_SpellCastBuffs"

local testEffectPrefix = "Test Effect: "
local testEffectIds = { 999900, 999901, 999902, 999903, 999904 }
local testEffectList   = { 22, 44, 55, 300, 1800000 }

local hidePlayerEffects = { }
local hideTargetEffects = { }

local playerName = strformat(SI_UNIT_NAME, GetUnitName("player"))

local windowTitles = {
    playerb     = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERBUFFS),
    playerd     = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERDEBUFFS),
    player1     = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERBUFFS),
    player2     = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERDEBUFFS),
    player_long = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERLONGTERMEFFECTS),
    targetb     = GetString(SI_LUIE_SCB_WINDOWTITLE_TARGETBUFFS),
    targetd     = GetString(SI_LUIE_SCB_WINDOWTITLE_TARGETDEBUFFS),
    target1     = GetString(SI_LUIE_SCB_WINDOWTITLE_TARGETBUFFS),
    target2     = GetString(SI_LUIE_SCB_WINDOWTITLE_TARGETDEBUFFS),
}

SCB.Enabled = false
SCB.D = {
    IconSize                         = 40,
    LabelPosition                    = 0,
    BuffFontFace                     = "Fontin Regular",
    BuffFontStyle                    = "outline",
    BuffFontSize                     = 16,
    BuffShowLabel                    = true,
    Alignment                        = "Centered",
    AlignmentLongVert                = "Top",
    AlignmentLongHorz                = "Centered",
    SortDirection                    = "Left to Right",
    GlowIcons                        = false,
    RemainingText                    = true,
    RemainingTextColoured            = false,
    RemainingTextMillis              = true,
    RemainingCooldown                = true,
    FadeOutIcons                     = false,
    lockPositionToUnitFrames         = true,
    LongTermEffects_Player           = true,
    LongTermEffects_Target           = true,
    IgnoreMundusPlayer               = false,
    IgnoreMundusTarget               = false,
    IgnoreVampPlayer                 = false,
    IgnoreVampTarget                 = false,
    IgnoreLycanPlayer                = false,
    IgnoreLycanTarget                = false,
    IgnoreDiseasePlayer              = false,
    IgnoreDiseaseTarget              = false,
    IgnoreBitePlayer                 = false,
    IgnoreBiteTarget                 = false,
    IgnoreCyrodiilPlayer             = false,
    IgnoreCyrodiilTarget             = false,
    IgnoreBattleSpiritPlayer         = false,
    IgnoreBattleSpiritTarget         = false,
    IgnoreEsoPlusPlayer              = true,
    IgnoreEsoPlusTarget              = true,
    IgnoreSoulSummonsPlayer          = false,
    IgnoreSoulSummonsTarget          = false,
    IgnoreSetICDPlayer               = false,
    IgnoreSetICDTarget               = false,
	IgnoreFoodPlayer				 = false,
	IgnoreFoodTarget				 = false,
	IgnoreExperiencePlayer			 = false,
	IgnoreExperienceTarget			 = false,
    IgnoreDisguise                   = false,
    IgnoreCostume                    = true,
    IgnoreHat                        = true,
    IgnoreSkin                       = true,
    IgnorePolymorph                  = true,
    IgnoreAssistant                  = true,
    IgnorePet                        = true,
    IgnoreMount                      = false,
    LongTermEffectsSeparate          = true,
    LongTermEffectsReverse           = true,
    LongTermEffectsSeparateAlignment = 2,
    ShowBlockPlayer                  = true,
    ShowBlockTarget                  = true,
    StealthStatePlayer               = true,
    StealthStateTarget               = true,
    DisguiseStatePlayer              = true,
    DisguiseStateTarget              = true,
    ShowSprint                       = true,
    ShowGallop                       = true,
    ShowResurrectionImmunity         = true,
    ShowRecall                       = true,
    HidePlayerBuffs                  = false,
    HidePlayerDebuffs                = false,
    HideTargetBuffs                  = false,
    HideTargetDebuffs                = false,
    HideGroundEffects                = false,
}
SCB.SV = nil

local uiTlw                  = {} -- GUI
local containerRouting       = {}

-- Abilities and buffs
local g_actionBar            = {}  -- TODO: Remove once new ground target effect function is fully implemented.
local g_lastCast             = 0 -- TODO: Remove once new ground target effect function is fully implemented.
local g_currentDuelTarget    = nil
local g_effectsList          = { player1 = {}, player2 = {}, reticleover1 = {}, reticleover2 = {}, ground = {}, saved = {} }
local g_pendingGroundAbility = nil


-- Self resurrection tracking
local g_playerActive = false
local g_playerDead   = false
local g_playerResurectStage = nil

-- Font to be used on icons
-- "ZoFontWindowSubtitle" or ours:
--local g_buffsFont = "/LuiExtended/media/fonts/fontin_sans_r.otf|16|outline"
--local g_buffsFont = "$(MEDIUM_FONT)|17|outline"
local g_buffsFont

-- Padding distance between icons
local g_padding = 0

local g_horizAlign = CENTER
local g_longHorizAlign = CENTER
local g_longVertAlign = MIDDLE
local g_horizSortInvert = false

-- Some optimization
local abilityRouting = { "player1", "player2", "ground" }
local g_currentDisguise = GetItemId(0, 10) or 0

-- Double check that the slot is actually eligible for use
local function HasFailure( slotIndex )
    if ( HasCostFailure( slotIndex ) ) then
        return true
    elseif ( HasRequirementFailure( slotIndex ) ) then
        return true
    elseif ( HasWeaponSlotFailure( slotIndex ) ) then
        return true
    elseif ( HasTargetFailure( slotIndex ) ) then
        return true
    elseif ( HasRangeFailure( slotIndex ) ) then
        return true
    elseif ( HasStatusEffectFailure( slotIndex )  ) then
        return true
    elseif ( HasFallingFailure( slotIndex ) ) then
        return true
    elseif ( HasSwimmingFailure( slotIndex ) ) then
        return true
    elseif ( HasMountedFailure( slotIndex ) ) then
        return true
    elseif ( HasReincarnatingFailure( slotIndex ) ) then
        return true
    end
    return false
end


--[[
-- Simple linear tweening - no easing, no acceleration
local function LinearTween(t, b, c, d)
    return c*t/d + b
end

-- Quadratic easing in - accelerating from zero velocity
local function EaseInQuad(t, b, c, d)
    t = t / d
    return c*t*t + b
end
]]

-- Quadratic easing out - decelerating to zero velocity
local function EaseOutQuad(t, b, c, d)
    t = t / d
    return -c * t*(t-2) + b
end

--[[
-- Quadratic easing in/out - acceleration until halfway, then deceleration
local function EaseInOutQuad(t, b, c, d)
    t = t / (d/2);
    if (t < 1) then return c/2*t*t + b end
    t = t - 1
    return -c/2 * (t*(t-2) - 1) + b
end
]]--

--[[----------------------------------------------------------
    ACTIVE BUFF EFFECTS
    * Get a custom buff/debuff effect when the player casts a spell
    * Effects are listed as [name] = { self buff , self debuff , target debuff , cast time }
    * Of the cast time us "true" instead of number, the value will be read from API
--]]----------------------------------------------------------

local Effects = {

    ["Imperial Prison Item Set"]    = { 6.0, false, false, nil},

    -- Resto Staff
    [A.Skill_Grand_Healing]         = { true, false, false, nil }, -- ACCURATE
    
    -- Destro Staff
    [A.Skill_Wall_of_Fire]            = { false, false, 6.6, nil }, -- ACCURATE
    [A.Skill_Wall_Of_Storms]          = { false, false, 6.6, nil }, -- ACCURATE
    [A.Skill_Wall_of_Frost]           = { false, false, 6.6, nil }, -- ACCURATE
    [A.Skill_Unstable_Wall_of_Fire]   = { false, false, 6.6, nil }, -- ACCURATE
    [A.Skill_Unstable_Wall_of_Frost]  = { false, false, 6.6, nil }, -- ACCURATE
    [A.Skill_Unstable_Wall_of_Storms] = { false, false, 6.6, nil }, -- ACCURATE
    [A.Skill_Blockade_of_Fire]        = { false, false, 8.6, nil }, -- ACCURATE
    [A.Skill_Blockade_of_Frost]       = { false, false, 8.6, nil }, -- ACCURATE
    [A.Skill_Blockade_of_Storms]      = { false, false, 8.6, nil }, -- ACCURATE
    
    -- Dragonknight
    [A.Skill_Dragonknight_Standard]   = { false, false, true, nil }, -- ACCURATE
    [A.Skill_Shifting_Standard]     = { false, false, true, nil }, -- ACCURATE
    [A.Skill_Shift_Standard]        = { false, false, true, nil }, -- ACCURATE
    [A.Skill_Standard_of_Might]     = { true, false, true, nil }, -- ACCURATE
    
    -- Templar
    [A.Skill_Nova]                          = { false, false, true, 1.1 }, -- ACCURATE SO FAR
    
    
    -- NEEDS TO BE RESORTED STILL:

    -----------------------------------
    -- WEAPON SKILLS
    -----------------------------------

    -- Bow
    [A.Skill_Volley]                = { false, false, true, 2 },
    [A.Skill_Scorched_Earth]        = { false, false, true, 2 },
    [A.Skill_Arrow_Barrage]         = { false, false, true, 2 },

    -- Resto Staff
    [A.Skill_Healing_Springs]       = { true, false, false, nil },
    [A.Skill_Illustrious_Healing]   = { true, false, false, nil },

    -----------------------------------
    -- SORCERER
    -----------------------------------

    -- Dark Magic
    [A.Skill_Negate_Magic]          = { false, false, true, nil },
    [A.Skill_Absorption_Field]      = { true , false, true, nil },  -- Values here are completely accurate
    [A.Skill_Suppression_Field]     = { false , false, true, nil },

    [A.Skill_Daedric_Mines]         = { false, false, 36, 3.5 },
    [A.Skill_Daedric_Minefield]     = { false, false, 36, 3.5 },    -- Doesn't account for not having +20% duration passives, otherwise decently accurate
    [A.Skill_Daedric_Tomb]          = { false, false, 36, 0.5 },    -- Decent timer otherwise

    -- Daedric Summoning
    [A.Skill_Summon_Storm_Atronach]   = { false, false, true, 0.8 },  -- Values here are completely accurate
    [A.Skill_Greater_Storm_Atronach]  = { false, false, true, 0.8 },  -- Don't absolutely have to have this, player already gets a buff on them, but this gives us more feedback
    [A.Skill_Summon_Charged_Atronach] = { false, false, true, 0.8 },

    -- Storm Calling
    [A.Skill_Lightning_Splash]      = { false, false, true, nil },
    [A.Skill_Liquid_Lightning]      = { false, false, true, nil },
    [A.Skill_Lightning_Flood]       = { false, false, true, nil },

    -----------------------------------
    -- DRAGONKNIGHT
    -----------------------------------

    -- Draonic Power
    -- Could add inhale here eventually, gonna need to do it with a fake aura however (2.5 sec duration timer before it explodes)

    -- Earthen Heart
    [A.Skill_Ash_Cloud]             = { false, false, true, nil },
    [A.Skill_Cinder_Storm]          = { false, false, true, nil },
    [A.Skill_Eruption]              = { false, false, true, nil },

    -- Draconic Power

    -----------------------------------
    -- NIGHTBLADE
    -----------------------------------

    -- Assassination

    -- Shadow
    [A.Skill_Consuming_Darkness]        = { false, false, true, nil },
    [A.Skill_Bolstering_Darkness]       = { false, false, true, nil },
    [A.Skill_Veil_of_Blades]            = { false, false, true, nil },
    [A.Skill_Path_of_Darkness]          = { false, false, true, nil },
    [A.Skill_Refreshing_Path]           = { false, false, true, nil },
    [A.Skill_Twisting_Path]             = { false, false, true, nil },
    [A.Skill_Summon_Shade]              = { true, false, false, nil },
    [A.Skill_Dark_Shades]               = { true, false, false, nil },
    [A.Skill_Shadow_Image]              = { true, false, false, nil },

    -- Siphoning

    -----------------------------------
    -- TEMPLAR
    -----------------------------------

    -- Aedric Spear
    [A.Skill_Spear_Shards]                  = { false, false, true, 1 },
    [A.Skill_Luminous_Shards]               = { false, false, true, 1 }, -- This seems roughly accurate, trying to time it with the disorient, depends on latency
    [A.Skill_Blazing_Spear]                 = { false, false, true, 1 }, -- Possibly Hide later

    -- Dawn's Wrath
    [A.Skill_Solar_Prison]                  = { false, false, 11.3, 1.1 }, -- Rough estimate of Nova duration - the damage fires off a bit after VFX fade - Pretty happy with these values
    [A.Skill_Solar_Disturbance]             = { false, false, 11.3, 1.1 },

    -- Restoring Light
    [A.Skill_Cleansing_Ritual]              = { true, false, false, nil },
    [A.Skill_Extended_Ritual]               = { true, false, false, nil },
    [A.Skill_Purifying_Ritual]              = { true, false, true, nil },
    [A.Skill_Rune_Focus]                    = { true, false, false, nil },
    [A.Skill_Channeled_Focus]               = { true, false, false, nil },
    [A.Skill_Restoring_Focus]               = { true, false, false, nil },
    
    -----------------------------------
    -- WARDEN
    -----------------------------------
    
    -- Green Balance
    --

    -----------------------------------
    -- GUILDS
    -----------------------------------

    -- Fighter Guild
    [A.Skill_Trap_Beast]          		= { false, false, 60, 1.5 },
    [A.Skill_Rearming_Trap]         	= { false, false, 60, 1.5 },
    [A.Skill_Lightweight_Beast_Trap]	= { false, false, 60, 1.5 },
    [A.Skill_Circle_of_Protection]  	= { true, false, false, nil },
    [A.Skill_Turn_Undead]           	= { true, false, false, nil },
    [A.Skill_Ring_of_Preservation]  	= { true, false, false, nil },

    -- Mages Guild
    [A.Skill_Meteor]                = { false, false, 11.8, 0 },
    [A.Skill_Ice_Comet]             = { false, false, 11.8, 0 },    -- Might need some work on timer
    [A.Skill_Shooting_Star]         = { false, false, 11.8, 0 },
    -- Need to add Fire Rune here

    -- Undaunted
    [A.Skill_Trapping_Webs]         = { false, false, true, nil },
    [A.Skill_Shadow_Silk]           = { false, false, true, nil },
    [A.Skill_Tangling_Webs]         = { false, false, true, nil },

    -----------------------------------
    -- WORLD
    -----------------------------------

    -- Vampire
    [A.Skill_Bat_Swarm]             = { false, false, 5.5, 0.1 },
    [A.Skill_Clouding_Swarm]        = { false, false, 5.5, 0.1 }, -- These values are perfect. Also note, this isn't needed as this shows as a buff on the player as well.
    [A.Skill_Devouring_Swarm]       = { false, false, 5.5, 0.1 },

    -- Werewolf

    -----------------------------------
    -- AVA
    -----------------------------------

    -- AVA Assault
    --[A.Skill_Vigor]               = { 5, false, false, 0 },
    --[A.Skill_Echoing_Vigor]       = { 5, false, false, 0 },
    --[A.Skill_Resolving_Vigor]     = { 5, false, false, 0 },
    [A.Skill_Caltrops]              = { false, false, true, nil },
    [A.Skill_Anti_Cavalry_Caltrops] = { false, false, true, nil },
    [A.Skill_Razor_Caltrops]        = { false, false, true, nil },

    --AVA Support
    --Possibly add Siege shield here/remove active effect
}

-- Table of associations we have to fix
local AbilityCustomToggleFix = {

    -- Restoration Staff
    [37243] = 62619, -- Blessing of Protection (Blessing of Protection - Rank 1)

    -- Dragonknight Skills (Draconic Power)
    [29004] = 29011, -- Dragon Blood (Dragon Blood - Rank 1)
    [33405] = 61871, -- Dragon Blood (Dragon Blood - Rank 2)
    [33616] = 61872, -- Dragon Blood (Dragon Blood - Rank 3)
    [33619] = 61873, -- Dragon Blood (Dragon Blood - Rank 4)
    
    [32744] = 61884, -- Green Dragon Blood (Green Dragon Blood - Rank 1)
    
    [32722] = 61891, -- Coagulating Blood (Coagulating Blood - Rank 1 )

    -- Dragonknight Skills (Earthen Heart)
    [31888] = 76537, -- Molten Armaments (Molten Armaments - Rank 1)

    -- Templar (Aedric Spear)
    [27501] = 27504, -- Sun Shield (Sun Shield - Rank 4)

}

local IsAbilityCustomToggleId = {

    -- Restoration Staff
    [28385] = true, -- Grand Healing (Grand Healing - Rank 1)
    [41244] = true, -- Grand Healing (Grand Healing - Rank 2)
    [41246] = true, -- Grand Healing (Grand Healing - Rank 3)
    [41248] = true, -- Grand Healing (Grand Healing - Rank 4)
    
    [37243] = true, -- Blessing of Protection (Blessing of Protection - Rank 1)
    
    [37232] = true, -- Steadfast Ward (Steadfast Ward - Rank 1)
    
    -- Dragonknight Skills (Draconic Power)
    [20319] = true, -- Spiked Armor (Spiked Armor - Rank 1)
    [23822] = true, -- Spiked Armor (Spiked Armor - Rank 2)
    [23825] = true, -- Spiked Armor (Spiked Armor - Rank 3)
    [23828] = true, -- Spiked Armor (Spiked Armor - Rank 4)
    
    [20328] = true, -- Hardened Armor (Hardened Armor - Rank 1)
    
    [20323] = true, -- Volatile Armor (Volatile Armor - Rank 1)
    
    [29004] = true, -- Dragon Blood (Dragon Blood - Rank 1)
    [33405] = true, -- Dragon Blood (Dragon Blood - Rank 2)
    [33616] = true, -- Dragon Blood (Dragon Blood - Rank 3)
    [33619] = true, -- Dragon Blood (Dragon Blood - Rank 4)
    
    [32744] = true, -- Green Dragon Blood (Green Dragon Blood - Rank 1)
    
    [32722] = true, -- Coagulating Blood (Coagulating Blood - Rank 1 )
    
    -- Dragonknight Skills (Earthen Heart)
    -- NEED TO FIX ALL RANKS OF MOLTEN WEP
    
    [29071] = true, -- Obsidian Shield (Obsidian Shield - Rank 1)
    [33862] = true, -- Obsidian Shield (Obsidian Shield - Rank 2)
    [33864] = true, -- Obsidian Shield (Obsidian Shield - Rank 3)
    [33866] = true, -- Obsidian Shield (Obsidian Shield - Rank 4)
    
    [29224] = true, -- Igneous Shield (Igneous Shield - Rank 1)
    
    [32673] = true, -- Fragmented Shield (Fragmeneted Shield - Rank 1)
    
    
    
    
    
    
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- RELATIVELY UNSORTED TEMP LIST HERE, ADDED FROM UESP SKILL TREE ABILITY ID'S, WILL BE MORE THROUGHLY PROCESSED IN THE FUTURE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    
    -- Alliance War (Assault)
    [61503] = true, -- Vigor
    [63236] = true, -- Vigor
    [63238] = true, -- Vigor
    [63240] = true, -- Vigor
    [61505] = true, -- Echoing Vigor
    [63243] = true, -- Echoing Vigor
    [63245] = true, -- Echoing Vigor
    [63247] = true, -- Echoing Vigor
    [61507] = true, -- Resolving Vigor
    [63249] = true, -- Resolving Vigor
    [63252] = true, -- Resolving Vigor
    [63255] = true, -- Resolving Vigor
    
    [38566] = true, -- Rapid Maneuver
    [46484] = true, -- Rapid Maneuver
    [46488] = true, -- Rapid Maneuver
    [46492] = true, -- Rapid Maneuver
    
    [40211] = true, -- Retreating Maneuver
    [46497] = true, -- Retreating Maneuver
    [46501] = true, -- Retreating Maneuver
    [46505] = true, -- Retreating Maneuver
    
    [40215] = true, -- Charging Maneuver
    [46509] = true, -- Charging Maneuver
    [46514] = true, -- Charging Maneuver
    [46519] = true, -- Charging Maneuver
    
    [61500] = true, -- Proximity Detonation
    [63296] = true, -- Proximity Detonation
    [63299] = true, -- Proximity Detonation
    [63302] = true, -- Proximity Detonation
    
    -- Alliance War (Support)
    [61511] = true, -- Guard
    [63308] = true, -- Guard
    [63313] = true, -- Guard
    [63318] = true, -- Guard
    
    [61536] = true, -- Mystic Guard
    [63323] = true, -- Mystic Guard
    [63329] = true, -- Mystic Guard
    [63335] = true, -- Mystic Guard
    
    [61529] = true, -- Stalwart  Guard
    [63341] = true, -- Stalwart  Guard
    [63346] = true, -- Stalwart  Guard
    [63351] = true, -- Stalwart  Guard
    
    -- Armor (Heavy)
    [29552] = true, -- Immovable
    [41078] = true, -- Immovable
    [41080] = true, -- Immovable
    [41082] = true, -- Immovable
    
    [39205] = true, -- Immovable Brute
    [41085] = true, -- Immovable Brute
    [41088] = true, -- Immovable Brute
    [41091] = true, -- Immovable Brute
    
    [39197] = true, -- Unstoppable
    [41097] = true, -- Unstoppable
    [41100] = true, -- Unstoppable
    [41103] = true, -- Unstoppable
    
    -- Armor (Light)
    [29338] = true, -- Annulment
    [41106] = true, -- Annulment
    [41107] = true, -- Annulment
    [41108] = true, -- Annulment
    
    [39186] = true, -- Dampen Magic
    [41109] = true, -- Dampen Magic
    [41111] = true, -- Dampen Magic
    [41113] = true, -- Dampen Magic
    
    [39182] = true, -- Harness Magicka
    [41115] = true, -- Harness Magicka
    [41118] = true, -- Harness Magicka
    [41121] = true, -- Harness Magicka
    
    -- Armor (Medium)
    [39195] = true, -- Shuffle
    [41127] = true, -- Shuffle
    [41129] = true, -- Shuffle
    [41131] = true, -- Shuffle
    
    -- Dragonknight
    [28967] = true, -- Inferno
    [34051] = true, -- Inferno
    [34056] = true, -- Inferno
    [34061] = true, -- Inferno
    
    [32853] = true, -- Flames of Oblivion
    [34066] = true, -- Flames of Oblivion
    [34073] = true, -- Flames of Oblivion
    [34080] = true, -- Flames of Oblivion
    
    [32881] = true, -- Cauterize
    [34088] = true, -- Cauterize
    [34094] = true, -- Cauterize
    [34100] = true, -- Cauterize
    
    [20319] = true, -- Spiked Armor
    [23822] = true, -- Spiked Armor
    [23825] = true, -- Spiked Armor
    [23828] = true, -- Spiked Armor
    
    [20328] = true, -- Hardened Armor
    [23846] = true, -- Hardened Armor
    [23851] = true, -- Hardened Armor
    [23856] = true, -- Hardened Armor
    
    [20323] = true, -- Volatile Armor
    [23834] = true, -- Volatile Armor
    [23838] = true, -- Volatile Armor
    [23842] = true, -- Volatile Armor
    
    [29004] = true, -- Dragon Blood
    [33405] = true, -- Dragon Blood
    [33616] = true, -- Dragon Blood
    [33619] = true, -- Dragon Blood
    
    [32744] = true, -- Green Dragon Blood
    [33622] = true, -- Green Dragon Blood
    [33627] = true, -- Green Dragon Blood
    [33632] = true, -- Green Dragon Blood
    
    [32722] = true, -- Coagulating Blood
    [33638] = true, -- Coagulating Blood
    [33642] = true, -- Coagulating Blood
    [33646] = true, -- Coagulating Blood
    
    [21007] = true, -- Reflective Scale
    [33741] = true, -- Reflective Scale
    [33742] = true, -- Reflective Scale
    [33743] = true, -- Reflective Scale
    
    [21014] = true, -- Reflective Plate
    [33745] = true, -- Reflective Plate
    [33747] = true, -- Reflective Plate
    [33749] = true, -- Reflective Plate
    
    [21017] = true, -- Dragon Fire Scale
    [33753] = true, -- Dragon Fire Scale
    [33757] = true, -- Dragon Fire Scale
    [33759] = true, -- Dragon Fire Scale
    
    [29071] = true, -- Obsidian Shield
    [33862] = true, -- Obsidian Shield
    [33864] = true, -- Obsidian Shield
    [33866] = true, -- Obsidian Shield
    
    [29224] = true, -- Igneous Shield
    [33868] = true, -- Igneous Shield
    [33870] = true, -- Igneous Shield
    [33872] = true, -- Igneous Shield
    
    [32673] = true, -- Fragmented Shield
    [33875] = true, -- Fragmented Shield
    [33878] = true, -- Fragmented Shield
    [33881] = true, -- Fragmented Shield
    
    [31888] = true, -- Molten Armaments
    [32171] = true, -- Molten Armaments
    [32172] = true, -- Molten Armaments
    [32173] = true, -- Molten Armaments
    
    -- Fighter's Guild
    [35737] = true, -- Circle of Protection
    [42501] = true, -- Circle of Protection
    [42505] = true, -- Circle of Protection
    [42509] = true, -- Circle of Protection
    
    [40181] = true, -- Turn Undead
    [42515] = true, -- Turn Undead
    [42522] = true, -- Turn Undead
    [42529] = true, -- Turn Undead
    
    [40169] = true, -- Ring of Preservation
    [42536] = true, -- Ring of Preservation
    [42542] = true, -- Ring of Preservation
    [42548] = true, -- Ring of Preservation
    
    [35762] = true, -- Expert Hunter
    [42602] = true, -- Expert Hunter
    [42606] = true, -- Expert Hunter
    [42610] = true, -- Expert Hunter
    
    [40194] = true, -- Evil Hunter
    [42614] = true, -- Evil Hunter
    [42619] = true, -- Evil Hunter
    [42624] = true, -- Evil Hunter
    
    [40195] = true, -- Camouflaged Hunter
    [42629] = true, -- Camouflaged Hunter
    [42635] = true, -- Camouflaged Hunter
    [42641] = true, -- Camouflaged Hunter
    
    [30920] = true, -- Magelight
    [42410] = true, -- Magelight
    [42414] = true, -- Magelight
    [42418] = true, -- Magelight
    [40478] = true, -- Inner Light
    [42422] = true, -- Inner Light
    [42426] = true, -- Inner Light
    [42430] = true, -- Inner Light
    [40483] = true, -- Radiant Magelight
    [42443] = true, -- Radiant Magelight
    [42449] = true, -- Radiant Magelight
    [42455] = true, -- Radiant Magelight
    
    -- Undaunted
    
    -- NOTE: Need to add ground auras for Altar here if possible
    
    [39369] = true, -- Bone Shield
    [43304] = true, -- Bone Shield
    [43307] = true, -- Bone Shield
    [43310] = true, -- Bone Shield
    
    [42138] = true, -- Spiked Bone Shield
    [43313] = true, -- Spiked Bone Shield
    [43318] = true, -- Spiked Bone Shield
    [43323] = true, -- Spiked Bone Shield
    
    [42176] = true, -- Bone Surge
    [43328] = true, -- Bone Surge
    [43331] = true, -- Bone Surge
    [43334] = true, -- Bone Surge
    
    -- Nightblade
    
    --[[ Messes up and won't disappear until dodge rolling for some reason, hiding for now
    [25375] = true, -- Shadow Cloak
    [36329] = true, -- Shadow Cloak
    [36333] = true, -- Shadow Cloak
    [36337] = true, -- Shadow Cloak
    
    [25380] = true, -- Shadowy Disguise
    [36356] = true, -- Shadowy Disguise
    [36362] = true, -- Shadowy Disguise
    [36368] = true, -- Shadowy Disguise
    
    [25377] = true, -- Dark Cloak
    [36341] = true, -- Dark Cloak
    [36346] = true, -- Dark Cloak
    [36351] = true, -- Dark Cloak
    ]]--
    
    [33211] = true, -- Summon Shade
    [36267] = true, -- Summon Shade
    [36271] = true, -- Summon Shade
    [36313] = true, -- Summon Shade
    
    [35434] = true, -- Dark Shades
    [36273] = true, -- Dark Shades
    [36278] = true, -- Dark Shades
    [36283] = true, -- Dark Shades
    
    [35441] = true, -- Shadow Image
    [36288] = true, -- Shadow Image
    [36293] = true, -- Shadow Image
    [36298] = true, -- Shadow Image
    
    [33319] = true, -- Siphoning Strikes
    [37955] = true, -- Siphoning Strikes
    [37966] = true, -- Siphoning Strikes
    [37977] = true, -- Siphoning Strikes
    
    [36908] = true, -- Leeching Strikes
    [37989] = true, -- Leeching Strikes
    [38002] = true, -- Leeching Strikes
    [38015] = true, -- Leeching Strikes
    
    [36935] = true, -- Siphoning Attacks
    [38028] = true, -- Siphoning Attacks
    [38039] = true, -- Siphoning Attacks
    [38050] = true, -- Siphoning Attacks
    
    -- Sorcerer
    -- Need these to show as toggles - will have to associate them with the active abilities that unlock
    --[[
    [23304] = true, -- Summon Unstable Familiar
    [30631] = true, -- Summon Unstable Familiar
    [30636] = true, -- Summon Unstable Familiar
    [30641] = true, -- Summon Unstable Familiar
    
    [23319] = true, -- Summon Unstable Clannfear
    [30647] = true, -- Summon Unstable Clannfear
    [30652] = true, -- Summon Unstable Clannfear
    [30657] = true, -- Summon Unstable Clannfear
    
    [23316] = true, -- Summon Volatile Familiar
    [30664] = true, -- Summon Volatile Familiar
    [30669] = true, -- Summon Volatile Familiar
    [30674] = true, -- Summon Volatile Familiar
    
    [24613] = true, -- Summon Wingled Twilight
    [30581] = true, -- Summon Wingled Twilight
    [30584] = true, -- Summon Wingled Twilight
    [30587] = true, -- Summon Wingled Twilight
    
    [24636] = true, -- Summon Twilight Tormentor
    [30592] = true, -- Summon Twilight Tormentor
    [30595] = true, -- Summon Twilight Tormentor
    [30598] = true, -- Summon Twilight Tormentor
    
    [24639] = true, -- Summon Twilight Matriarch
    [30618] = true, -- Summon Twilight Matriarch
    [30622] = true, -- Summon Twilight Matriarch
    [30626] = true, -- Summon Twilight Matriarch
    ]]--
    
    [28418] = true, -- Conjured Ward
    [30457] = true, -- Conjured Ward
    [30460] = true, -- Conjured Ward
    [30463] = true, -- Conjured Ward
    
    [29489] = true, -- Hardened Ward
    [30466] = true, -- Hardened Ward
    [30470] = true, -- Hardened Ward
    [30474] = true, -- Hardened Ward
    
    [29482] = true, -- Empowered Ward
    [30478] = true, -- Empowered Ward
    [30482] = true, -- Empowered Ward
    [30486] = true, -- Empowered Ward
    
    --[[  Disappears when refreshed, not sure why
    [24574] = true, -- Rune Prison
    [30182] = true, -- Rune Prison
    [30188] = true, -- Rune Prison
    [30194] = true, -- Rune Prison
    ]]--
    
    [23210] = true, -- Lightning Form
    [30229] = true, -- Lightning Form
    [30232] = true, -- Lightning Form
    [30235] = true, -- Lightning Form
    
    [23231] = true, -- Hurricane
    [30238] = true, -- Hurricane
    [30241] = true, -- Hurricane
    [30244] = true, -- Hurricane
    
    [23213] = true, -- Boundless Storm
    [30247] = true, -- Boundless Storm
    [30251] = true, -- Boundless Storm
    [30255] = true, -- Boundless Storm
    
    [23670] = true, -- Surge
    [30386] = true, -- Surge
    [30388] = true, -- Surge
    [30390] = true, -- Surge
    
    [23674] = true, -- Power Surge
    [30392] = true, -- Power Surge
    [30394] = true, -- Power Surge
    [30396] = true, -- Power Surge
    
    [23678] = true, -- Critical Surge
    [30398] = true, -- Critical Surge
    [30402] = true, -- Critical Surge
    [30406] = true, -- Critical Surge
    
    -- Templar
    --[[ -- These won't disappear when they end, hidden for now
    [22178] = true, -- Sun Shield
    [27493] = true, -- Sun Shield
    [27497] = true, -- Sun Shield
    [27501] = true, -- Sun Shield
    
    [22182] = true, -- Radiant Ward
    [27506] = true, -- Radiant Ward
    [27510] = true, -- Radiant Ward
    [27514] = true, -- Radiant Ward
    
    [22180] = true, -- Blazing Shield
    [27520] = true, -- Blazing Shield
    [27526] = true, -- Blazing Shield
    [27530] = true, -- Blazing Shield
    ]]--
    
    [22265] = true, -- Cleansing Ritual
    [27243] = true, -- Cleansing Ritual
    [27249] = true, -- Cleansing Ritual
    [27255] = true, -- Cleansing Ritual
    
    [22259] = true, -- Ritual of Retribution
    [27261] = true, -- Ritual of Retribution
    [27269] = true, -- Ritual of Retribution
    [27275] = true, -- Ritual of Retribution
    
    [22262] = true, -- Extended Ritual
    [27281] = true, -- Extended Ritual
    [27288] = true, -- Extended Ritual
    [27295] = true, -- Extended Ritual
    
    [22234] = true, -- Rune Focus
    [23968] = true, -- Rune Focus
    [23969] = true, -- Rune Focus
    [23970] = true, -- Rune Focus
    
    [22240] = true, -- Channeled Focus
    [23996] = true, -- Channeled Focus
    [23997] = true, -- Channeled Focus
    [23998] = true, -- Channeled Focus
    
    [22237] = true, -- Restoring Focus
    [23983] = true, -- Restoring Focus
    [23984] = true, -- Restoring Focus
    [23985] = true, -- Restoring Focus
    
    -- Warden
    [86050] = true, -- Betty Netch
    [86051] = true, -- Betty Netch
    [86052] = true, -- Betty Netch
    [86053] = true, -- Betty Netch
    
    [86054] = true, -- Blue Betty
    [86055] = true, -- Blue Betty
    [86056] = true, -- Blue Betty
    [86057] = true, -- Blue Betty
    
    [86058] = true, -- Bull Netch
    [86059] = true, -- Bull Netch
    [86060] = true, -- Bull Netch
    [86061] = true, -- Bull Netch
    
    [86037] = true, -- Falcon's Swiftness
    [86038] = true, -- Falcon's Swiftness
    [86039] = true, -- Falcon's Swiftness
    [86040] = true, -- Falcon's Swiftness
    
    [86041] = true, -- Deceptive Predator
    [86042] = true, -- Deceptive Predator
    [86043] = true, -- Deceptive Predator
    [86044] = true, -- Deceptive Predator
    
    [86045] = true, -- Bird of Prey
    [86046] = true, -- Bird of Prey
    [86047] = true, -- Bird of Prey
    [86048] = true, -- Bird of Prey
    
    -- Add aura for Healing Seed
    
    [85552] = true, -- Living Vines
    [93875] = true, -- Living Vines
    [93876] = true, -- Living Vines
    [93877] = true, -- Living Vines
    
    [85850] = true, -- Leeching Vines
    [93878] = true, -- Leeching Vines
    [93879] = true, -- Leeching Vines
    [93880] = true, -- Leeching Vines
    
    [85851] = true, -- Living Trellis
    [93881] = true, -- Living Trellis
    [93882] = true, -- Living Trellis
    [93883] = true, -- Living Trellis
    
    [85539] = true, -- Lotus Flower
    [93906] = true, -- Lotus Flower
    [93907] = true, -- Lotus Flower
    [93908] = true, -- Lotus Flower
    
    [85854] = true, -- Green Lotus
    [93909] = true, -- Green Lotus
    [93910] = true, -- Green Lotus
    [93911] = true, -- Green Lotus
    
    [85855] = true, -- Lotus Blossom
    [93912] = true, -- Lotus Blossom
    [93913] = true, -- Lotus Blossom
    [93914] = true, -- Lotus Blossom
    
    --[[ No aura
    [86122] = true, -- Frost Cloak
    [86123] = true, -- Frost Cloak
    [86124] = true, -- Frost Cloak
    [86125] = true, -- Frost Cloak
    
    [86126] = true, -- Expansive Frost Cloak
    [86127] = true, -- Expansive Frost Cloak
    [86128] = true, -- Expansive Frost Cloak
    [86129] = true, -- Expansive Frost Cloak
    
    [86130] = true, -- Ice Fortress
    [86131] = true, -- Ice Fortress
    [86132] = true, -- Ice Fortress
    [86133] = true, -- Ice Fortress
    ]]--
    
    -- Add aura for Impaling Shards
    
    --[[ -- Won't disappear after shield fades
    [86148] = true, -- Arctic Wind
    [86149] = true, -- Arctic Wind
    [86150] = true, -- Arctic Wind
    [86151] = true, -- Arctic Wind
    
    [86152] = true, -- Polar Wind
    [86153] = true, -- Polar Wind
    [86154] = true, -- Polar Wind
    [86155] = true, -- Polar Wind
    
    [86156] = true, -- Arctic Blast
    [86157] = true, -- Arctic Blast
    [86158] = true, -- Arctic Blast
    [86159] = true, -- Arctic Blast
    ]]--
    
    [86135] = true, -- Crystallized Shield
    [86136] = true, -- Crystallized Shield
    [86137] = true, -- Crystallized Shield
    [86138] = true, -- Crystallized Shield
    
    [86139] = true, -- Crystallized Slab
    [86140] = true, -- Crystallized Slab
    [86141] = true, -- Crystallized Slab
    [86142] = true, -- Crystallized Slab
    
    [86143] = true, -- Shimmering Shield
    [86144] = true, -- Shimmering Shield
    [86145] = true, -- Shimmering Shield
    [86146] = true, -- Shimmering Shield
    
    -- Weapon
    
    [28613] = true, -- Blade Cloak
    [40631] = true, -- Blade Cloak
    [40632] = true, -- Blade Cloak
    [40633] = true, -- Blade Cloak
    
    [38901] = true, -- Quick Cloak
    [40634] = true, -- Quick Cloak
    [40638] = true, -- Quick Cloak
    [40642] = true, -- Quick Cloak
    
    [38906] = true, -- Deadly Cloak
    [40646] = true, -- Deadly Cloak
    [40649] = true, -- Deadly Cloak
    [40651] = true, -- Deadly Cloak
    
    
    [28727] = true, -- Defensive Posture
    [41349] = true, -- Defensive Posture
    [41350] = true, -- Defensive Posture
    [41351] = true, -- Defensive Posture
    
    [38312] = true, -- Defensive Stance
    [41352] = true, -- Defensive Stance
    [41355] = true, -- Defensive Stance
    [41358] = true, -- Defensive Stance
    
    [38317] = true, -- Absorb Magic
    [41370] = true, -- Absorb Magic
    [41375] = true, -- Absorb Magic
    [41380] = true, -- Absorb Magic
    
    [28385] = true, -- Grand Healing
    [41244] = true, -- Grand Healing
    [41246] = true, -- Grand Healing
    [41248] = true, -- Grand Healing
    
    [40058] = true, -- Illustrious Healing
    [41251] = true, -- Illustrious Healing
    [41253] = true, -- Illustrious Healing
    [41255] = true, -- Illustrious Healing
    
    [40060] = true, -- Healing Springs
    [41257] = true, -- Healing Springs
    [41261] = true, -- Healing Springs
    [41265] = true, -- Healing Springs
    
    [28536] = true, -- Regeneration
    [41269] = true, -- Regeneration
    [41270] = true, -- Regeneration
    [41271] = true, -- Regeneration
    
    [40076] = true, -- Rapid Regeneration
    [41272] = true, -- Rapid Regeneration
    [41274] = true, -- Rapid Regeneration
    [41276] = true, -- Rapid Regeneration
    
    [40079] = true, -- Mutagen
    [41278] = true, -- Mutagen
    [41283] = true, -- Mutagen
    [41288] = true, -- Mutagen
    
    [37232] = true, -- Steadfast Ward
    [41306] = true, -- Steadfast Ward
    [41308] = true, -- Steadfast Ward
    [41310] = true, -- Steadfast Ward
    
    [41310] = true, -- Ward Ally
    [41294] = true, -- Ward Ally
    [41298] = true, -- Ward Ally
    [41302] = true, -- Ward Ally
    
    [40126] = true, -- Healing Ward
    [41312] = true, -- Healing Ward
    [41316] = true, -- Healing Ward
    [41320] = true, -- Healing Ward
    
    [28297] = true, -- Momentum
    [39868] = true, -- Momentum
    [39871] = true, -- Momentum
    [39881] = true, -- Momentum
    
    [38794] = true, -- Forward Momentum
    [39884] = true, -- Forward Momentum
    [39888] = true, -- Forward Momentum
    [39892] = true, -- Forward Momentum
    
    [38802] = true, -- Rally
    [39896] = true, -- Rally
    [39990] = true, -- Rally
    [39904] = true, -- Rally
   
}
   
-- Old Deprecated List, using this to pull values from as a reminder!
local IsAbilityCustomToggleName = {
    
        -- RESORTED:

    -- MAKE SURE REGENERATION WORKS WITHOUT NAME VERSION
    --[A.Skill_Regeneration]           = true,
    
    --Dragonknight Skills (Draconic Power)
    
    -- HAS NOT BEEN RESORTED YET:

    --Sorceror Skills (Dark Magic)
    --[A.Skill_Defensive_Rune]        = true, -- Doesn't work because of no aura, would be nice to have this highlight if possible.

    -- Sorceror Skills (Daedric Summoning)
    [A.DamageShield_Conjured_Ward]  = true,
    [A.DamageShield_Empowered_Ward] = true,
    [A.DamageShield_Hardened_Ward]  = true,

    -- Sorceror Skills (Storm Calling)
    [A.Skill_Lightning_Form]        = true,
    [A.Skill_Boundless_Storm]       = true,
    [A.Skill_Thundering_Presence]   = true,
    [A.Skill_Surge]                 = true,
    [A.Skill_Critical_Surge]        = true,
    [A.Skill_Power_Surge]           = true,

    --Dragonknight Skills (Ardent Flame)
    [A.Skill_Inferno]               = true,
    [A.Skill_Flames_Of_Oblivion]    = true,
    [A.Skill_Cauterize]             = true,

    --Dragonknight Skills (Draconic Power)
    --[A.Skill_Green_Dragon_Blood]      = true,     -- Doesn't work, no ability to go along with cast, only Major/Minor effects
    --[A.Skill_Coagulating_Blood]       = true,
    [A.Skill_Reflective_Scale]      = true,
    [A.Skill_Reflective_Plate]      = true,
    [A.Skill_Dragon_Fire_Scale]     = true,


    --Templar Skills (Aedric Spear)
    --[A.DamageShield_Sun_Shield]     = true, -- These seem to fade on dodge roll, unlike other shields, I have no idea why
    --[A.DamageShield_Radiant_Ward]   = true, -- These seem to fade on dodge roll, unlike other shields, I have no idea why
    --[A.DamageShield_Blazing_Shield] = true, -- These seem to fade on dodge roll, unlike other shields, I have no idea why

    --Nightblade Skills (Assassination)
    [A.Skill_Blur]                  = true,
    [A.Skill_Double_Take]           = true,
    [A.Skill_Mirage]                = true,
    [A.Skill_Grim_Focus]            = true,
    [A.Skill_Relentless_Focus]      = true,
    [A.Skill_Merciless_Resolve]     = true,
    -- Ambush Empower, possibly add here

    --Nightblade Skills (Shadow)
    [A.Skill_Shadow_Cloak]          = true,
    [A.Skill_Shadowy_Disguise]      = true,
    [A.Skill_Dark_Cloak]            = true,
    -- If POSSIBLE - ADD SHADE ABILITIES HERE (Also add proc effect for Shadow Image potentially)

    --Nightblade Skills (Siphoning)
    [A.Skill_Siphoning_Strikes]     = true,
    [A.Skill_Siphoning_Attacks]     = true,
    -- Cripple Major expedition, possibly add here
    -- Drain power Major Brutality, possibly add here

    --Two Handed
    [A.DamageShield_Brawler]        = true,
    -- IF POSSIBLE - ADD CARVE MINOR HEROISM
    -- Uppercut empower, possibly add here
    [A.Skill_Momentum]              = true,
    [A.Skill_Forward_Momentum]      = true,
    [A.Skill_Rally]                 = true,

    --One Hand and Shield
    -- IF POSSIBLE - ADD HEROIC SLASH MINOR HEROISM
    [A.Skill_Defensive_Posture]       = true,
    [A.Skill_Defensive_Stance]        = true,
    [A.Skill_Absorb_Magic]            = true,
    [A.DamageShield_Shielded_Assault] = true,

    --Dual Wield
    [A.Skill_Blade_Cloak]            = true,
    [A.Skill_Quick_Cloak]            = true,
    [A.Skill_Deadly_Cloak]           = true,
    -- IF POSSIBLE - ADD HIDDEN BLADE MAJOR BRUTALITY HERE

    --Bow - Possibly scatter shot indicator?

    --Resto Staff
    --[A.Skill_Healing_Springs]        = true, -- Doesn't work, no effect related to it
    --[A.Skill_Illustrious_Healing]    = true, -- Doesn't work, no effect related to it
    [A.Skill_Mutagen]                = true,
    [A.Skill_Rapid_Regeneration]     = true,
    [A.DamageShield_Ward_Ally]       = true,
    [A.DamageShield_Healing_Ward]    = true,

    --Light Armor
    [A.DamageShield_Annulment]       = true,
    [A.DamageShield_Dampen_Magic]    = true,
    [A.DamageShield_Harness_Magicka] = true,

    --Medium Armor
    --[A.Skill_Evasion]                = true,
    --[A.Skill_Elude]                  = true,      -- NOT SURE WHY THESE DON'T WORK
    --[A.Skill_Shuffle]                = true,

    --Heavy Armor
    [A.Skill_Immovable]              = true,
    [A.Skill_Immovable_Brute]        = true,        -- Only shows the CC Immunity duration, need to figure a way to make other buffs display
    [A.Skill_Unstoppable]            = true,

    --Werewolf
    [A.Skill_Hircines_Rage]          = true,        -- Breaks on dodge roll for some reason
    [A.Skill_Hircines_Fortitude]     = true,        -- Breaks on dodge roll for some reason

    --Fighter's Guild
    [A.Skill_Expert_Hunter]          = true,
    [A.Skill_Evil_Hunter]            = true,
    [A.Skill_Camouflaged_Hunter]     = true,

    --Mage's Guild
    [A.Skill_Magelight]              = true,
    [A.Skill_Inner_Light]            = true,
    [A.Skill_Radiant_Magelight]      = true,
    --[A.Skill_Entropy]              = true,
    --[A.Skill_Degeneration]         = true,
    --[A.Skill_Structured_Entropy]   = true,
    [A.Skill_Equilibrium]            = true,    -- Fades sooner than it should from other effects
    [A.Skill_Spell_Symmetry]         = true,
    [A.Skill_Balance]                = true,    -- Fades sooner than it should from other effects

    --Undaunted
    -- BLOOD ALTAR HERE (possibly GTAOE)
    [A.DamageShield_Bone_Shield]     = true,
    [A.DamageShield_Bone_Surge]      = true,
    [A.DamageShield_Spiked_Bone_Shield] = true,
    -- Necrotic Orb?? Can't decide what to do with this.

    --AVA Assault
    [A.Skill_Rapid_Maneuver]         = true,
    [A.Skill_Charging_Maneuver]      = true,
    [A.Skill_Retreating_Maneuver]    = true,
    [A.Skill_Vigor]                  = true,    -- Drops after rolling for some reason
    [A.Skill_Echoing_Vigor]          = true,    -- Drops after rolling for some reason
    [A.Skill_Resolving_Vigor]        = true,    -- Drops after rolling for some reason
    [A.Skill_Proximity_Detonation]   = true,

    --AVA Support
    [A.Skill_Siege_Shield]           = true, -- Behavior on Siege Shield's is kind of odd, only shows bar effect when standing inside it as it reapplies.
    [A.Skill_Propelling_Shield]      = true, -- Still, you can only have one shield up, and it's pretty hard to miss the thing.
    [A.Skill_Siege_Weapon_Shield]    = true, -- Possibly add GTAOE duration indicator as well
    [A.Skill_Purge]                  = true,
    [A.Skill_Cleanse]                = true,
    --[A.Skill_Efficient_Purge]      = true, -- Doesn't work for some reason
    
}

-- Initialization
function SCB.Initialize( enabled )
    -- Load settings
    SCB.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "SpellCastBuffs", SCB.D )
    -- Correct read values
    if SCB.SV.IconSize < 30 or SCB.SV.IconSize > 60 then
        SCB.SV.IconSize = SCB.D.IconSize
    end

    -- If User does not want the Buffs tracking then exit right here
    if not enabled then
        return
    end
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
        uiTlw.playerb = UI.TopLevel( nil, nil )
        uiTlw.playerb:SetHandler( "OnMoveStop", function(self)
                SCB.SV.playerbOffsetX = self:GetLeft()
                SCB.SV.playerbOffsetY = self:GetTop()
            end )
        uiTlw.playerd = UI.TopLevel( nil, nil )
        uiTlw.playerd:SetHandler( "OnMoveStop", function(self)
                SCB.SV.playerdOffsetX = self:GetLeft()
                SCB.SV.playerdOffsetY = self:GetTop()
            end )
        containerRouting.player1 = "playerb"
        containerRouting.player2 = "playerd"
        
        local fragment1 = ZO_HUDFadeSceneFragment:New(uiTlw.playerb, 0, 0)
        local fragment2 = ZO_HUDFadeSceneFragment:New(uiTlw.playerd, 0, 0)

		SCENE_MANAGER:GetScene("hud"):AddFragment( fragment1 )
		SCENE_MANAGER:GetScene("hud"):AddFragment( fragment2 )
		SCENE_MANAGER:GetScene("hudui"):AddFragment( fragment1 )
		SCENE_MANAGER:GetScene("hudui"):AddFragment( fragment2 )
		SCENE_MANAGER:GetScene("siegeBar"):AddFragment( fragment1 )
		SCENE_MANAGER:GetScene("siegeBar"):AddFragment( fragment2 )
        
    end

    if SCB.SV.lockPositionToUnitFrames and LUIE.UnitFrames.CustomFrames.reticleover and LUIE.UnitFrames.CustomFrames.reticleover.buffs and LUIE.UnitFrames.CustomFrames.reticleover.debuffs then
        uiTlw.target1 = LUIE.UnitFrames.CustomFrames.reticleover.buffs
        uiTlw.target2 = LUIE.UnitFrames.CustomFrames.reticleover.debuffs
        containerRouting.reticleover1 = "target1"
        containerRouting.reticleover2 = "target2"
        containerRouting.ground = "target2"
    else
        uiTlw.targetb = UI.TopLevel( nil, nil )
        uiTlw.targetb:SetHandler( "OnMoveStop", function(self)
                SCB.SV.targetbOffsetX = self:GetLeft()
                SCB.SV.targetbOffsetY = self:GetTop()
            end )
        uiTlw.targetd = UI.TopLevel( nil, nil )
        uiTlw.targetd:SetHandler( "OnMoveStop", function(self)
                SCB.SV.targetdOffsetX = self:GetLeft()
                SCB.SV.targetdOffsetY = self:GetTop()
            end )
        containerRouting.reticleover1 = "targetb"
        containerRouting.reticleover2 = "targetd"
        containerRouting.ground = "targetd"
        
        local fragment1 = ZO_HUDFadeSceneFragment:New(uiTlw.targetb, 0, 0)
        local fragment2 = ZO_HUDFadeSceneFragment:New(uiTlw.targetd, 0, 0)

		SCENE_MANAGER:GetScene("hud"):AddFragment( fragment1 )
		SCENE_MANAGER:GetScene("hud"):AddFragment( fragment2 )
		SCENE_MANAGER:GetScene("hudui"):AddFragment( fragment1 )
		SCENE_MANAGER:GetScene("hudui"):AddFragment( fragment2 )
		SCENE_MANAGER:GetScene("siegeBar"):AddFragment( fragment1 )
		SCENE_MANAGER:GetScene("siegeBar"):AddFragment( fragment2 )
    end

    -- Separate container for players long buffs
    if true then
        uiTlw.player_long = UI.TopLevel( nil, nil )
        uiTlw.player_long:SetHandler( "OnMoveStop", function(self)
                if self.alignVertical then
                    SCB.SV.playerVOffsetX = self:GetLeft()
                    SCB.SV.playerVOffsetY = self:GetTop()
                else
                    SCB.SV.playerHOffsetX = self:GetLeft()
                    SCB.SV.playerHOffsetY = self:GetTop()
                end
            end )

        -- TODO: Implement change in vertical alignment
        if SCB.SV.LongTermEffectsSeparateAlignment == 1 then
            uiTlw.player_long.alignVertical = false
        elseif SCB.SV.LongTermEffectsSeparateAlignment == 2 then
            uiTlw.player_long.alignVertical = true
        end
        uiTlw.player_long.skipUpdate = 0
        containerRouting.player_long = "player_long"
        
        local fragment = ZO_HUDFadeSceneFragment:New(uiTlw.player_long, 0, 0)

		SCENE_MANAGER:GetScene("hud"):AddFragment( fragment )
		SCENE_MANAGER:GetScene("hudui"):AddFragment( fragment )
		SCENE_MANAGER:GetScene("siegeBar"):AddFragment( fragment )
    else
        containerRouting.player_long = containerRouting.player1
    end

    SCB.SetTlwPosition()

    -- Loop over created controls to...
    for _, v in pairs(containerRouting) do
        if uiTlw[v].preview == nil then
            -- Create background areas for preview position purposes
            --uiTlw[v].preview = UI.Backdrop( uiTlw[v], "fill", nil, nil, nil, true )
            uiTlw[v].preview = UI.Texture( uiTlw[v], "fill", nil, "/esoui/art/miscellaneous/inset_bg.dds", DL_BACKGROUND, true )
            uiTlw[v].previewLabel = UI.Label( uiTlw[v].preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", windowTitles[v] .. (SCB.SV.lockPositionToUnitFrames and v ~= "player_long" and " (locked)" or ""), false )

            -- create control that will hold the icons
            uiTlw[v].prevIconsCount = 0
            -- We need this container only for icons that are aligned in one row/column automatically.
            -- Thus we do not create containers for player and target buffs/debuffs on custom frames
            if v ~= "player1" and v ~= "player2" and v ~= "target1" and v ~= "target2" then
                uiTlw[v].iconHolder = UI.Control( uiTlw[v], nil, nil, false )
            end
            -- Create table to store created contols for icons
            uiTlw[v].icons = {}

        end
    end

    SCB.Reset()
    SCB.UpdateContextHideList()

    -- Register events
    EVENT_MANAGER:RegisterForUpdate(moduleName, 100, SCB.OnUpdate )

    -- Target Events
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TARGET_CHANGE,             SCB.OnTargetChange )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RETICLE_TARGET_CHANGED,    SCB.OnReticleTargetChanged )

    -- Buff Events
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_FULL_UPDATE,  SCB.OnSlotsFullUpdate )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED,       SCB.OnSlotUpdated )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_ABILITY_USED,  SCB.OnSlotAbilityUsed )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_EFFECT_CHANGED, SCB.OnEffectChanged )

    EVENT_MANAGER:RegisterForEvent("LUIE_Event1", EVENT_COMBAT_EVENT, SCB.OnCombatEventIn )
    EVENT_MANAGER:RegisterForEvent("LUIE_Event2", EVENT_COMBAT_EVENT, SCB.OnCombatEventOut )
    EVENT_MANAGER:RegisterForEvent("LUIE_Event3", EVENT_COMBAT_EVENT, SCB.OnCombatEventOut )
    EVENT_MANAGER:AddFilterForEvent("LUIE_Event1", EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false) -- Target -> Player
	EVENT_MANAGER:AddFilterForEvent("LUIE_Event2", EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false) -- Player -> Target
    EVENT_MANAGER:AddFilterForEvent("LUIE_Event3", EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER_PET, REGISTER_FILTER_IS_ERROR, false) -- Player Pet -> Target
    --EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COMBAT_EVENT, SCB.OnCombatEvent )
    --EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, false )

    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED,  SCB.OnDeath )

    EVENT_MANAGER:RegisterForEvent(moduleName .. "player",          EVENT_STEALTH_STATE_CHANGED, SCB.StealthStateChanged )
    EVENT_MANAGER:RegisterForEvent(moduleName .. "reticleover",     EVENT_STEALTH_STATE_CHANGED, SCB.StealthStateChanged )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "player",         EVENT_STEALTH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "reticleover",    EVENT_STEALTH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "reticleover" )

    EVENT_MANAGER:RegisterForEvent(moduleName .. "player",          EVENT_DISGUISE_STATE_CHANGED, SCB.DisguiseStateChanged )
    EVENT_MANAGER:RegisterForEvent(moduleName .. "reticleover",     EVENT_DISGUISE_STATE_CHANGED, SCB.DisguiseStateChanged )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "player",         EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "reticleover",    EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "reticleover" )
    
    -- Artificial Effects Handling
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ARTIFICIAL_EFFECT_ADDED, SCB.ArtificialEffectUpdate)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ARTIFICIAL_EFFECT_REMOVED, SCB.ArtificialEffectUpdate)

    -- Activate, Deactivate player, death, alive.
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED,   SCB.OnPlayerActivated )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_DEACTIVATED, SCB.OnPlayerDeactivated )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ALIVE, SCB.OnPlayerAlive )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_DEAD,  SCB.OnPlayerDead )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_VIBRATION,    SCB.OnVibration )

    -- Mount
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MOUNTED_STATE_CHANGED, SCB.MountStatus)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COLLECTIBLE_USE_RESULT, SCB.CollectibleUsed)

    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, SCB.DisguiseItem)
    EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN )
    
    -- Duel (For resolving Target battle spirit status)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_STARTED, SCB.DuelStart)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_FINISHED, SCB.DuelEnd)
end

function SCB.DuelStart()
    
    local duelState, characterName = GetDuelInfo()
    if duelState == 3 and not SCB.SV.IgnoreBattleSpiritTarget then
        g_currentDuelTarget = strformat(SI_UNIT_NAME, characterName)
        SCB.ReloadEffects("reticleover")
    end

end

function SCB.DuelEnd()

    g_currentDuelTarget = nil
    SCB.ReloadEffects("reticleover")

end

function SCB.InitializeDisguise()
    g_effectsList.player1["DisguiseType"] = nil
    if g_currentDisguise ~= 0 and not SCB.SV.IgnoreDisguise then

        -- Don't show Monk's Disguise since it already has an aura, and don't show Guild Tabard
        if g_currentDisguise == 79332 or g_currentDisguise == 55262 then
            return
        end

        local name = GetItemName(0, 10)
        local icon = E.DisguiseIcons[g_currentDisguise].icon
        g_effectsList.player1["DisguiseType"] = {
            target="player", type=1,
            name=name, icon=icon,
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "long",
            restart=true, iconNum=0
        }
    end
end

function SCB.DisguiseItem(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if slotId == 10 then
        g_effectsList.player1["DisguiseType"] = nil
        g_currentDisguise = GetItemId(0, 10) or 0
        SCB.CollectibleBuff()
        if g_currentDisguise == 0 then
            return
        elseif g_currentDisguise ~= 0 and not SCB.SV.IgnoreDisguise then

            -- Don't show Monk's Disguise since it already has an aura, and don't show Guild Tabard
            if g_currentDisguise == 79332 or g_currentDisguise == 55262 then
                return
            end

            local name = GetItemName(0, 10)
            local icon = E.DisguiseIcons[g_currentDisguise].icon
            g_effectsList.player1["DisguiseType"] =
                {
                    target="player", type=1,
                    name=name, icon=icon,
                    dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                    forced = "long",
                    restart=true, iconNum=0
                }
        end
    end
end

function SCB.MountStatus(eventCode, mounted)
    -- Remove icon first
    g_effectsList.player1["Mount"] = nil

    if mounted and not SCB.SV.IgnoreMount then

        g_effectsList.player1["Mount"] =
            {
                target="player", type=1,
                name=A.Innate_Mounted, icon='LuiExtended/media/icons/abilities/ability_innate_mounted.dds',
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "long",
                restart=true, iconNum=0
            }
    end
end

function SCB.CollectibleUsed(eventCode, result, isAttemptingActivation)
    local latency = GetLatency()
    latency = latency + 100
    zo_callLater (SCB.CollectibleBuff, latency)
end

function SCB.CollectibleBuff()
    -- PETS
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET) > 0 and not SCB.SV.IgnorePet and not IsPlayerInAvAWorld() then
        local Collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET)
            g_effectsList.player1["PetType"] =
                {
                        target="player", type=1,
                        name=A.Innate_Vanity_Pet, icon='LuiExtended/media/icons/abilities/ability_innate_pet.dds',
                        dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                        forced = "long",
                        restart=true, iconNum=0
                }
    else
        g_effectsList.player1["PetType"] = nil
    end

    -- ASSISTANTS
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT) > 0 and not SCB.SV.IgnoreAssistant and not IsPlayerInAvAWorld() then
        local Collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT)
        local CollectibleName = GetCollectibleName(Collectible)

        local iconAssistant = E.AssistantIcons[CollectibleName] ~= nil and E.AssistantIcons[CollectibleName] or ''

            g_effectsList.player1["AssistantType"] =
                {
                        target="player", type=1,
                        name=CollectibleName, icon=iconAssistant,
                        dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                        forced = "long",
                        restart=true, iconNum=0
                }
    else
        g_effectsList.player1["AssistantType"] = nil
    end

end

-- Sets horizontal alignment of icon. Called from Settings Menu.
-- This is done simply by setting of iconHolder anchor.
function SCB.SetIconsAlignment( value )
    -- Check correctness of argument value
    if value ~= "Left" and value ~= "Centered" and value ~= "Right" then
        value = SCB.D.Alignment
    end
    SCB.SV.Alignment = value

    if not SCB.Enabled then
        return
    end

    g_horizAlign = ( value == "Left" ) and LEFT or ( value == "Right" ) and RIGHT or CENTER

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            uiTlw[v].iconHolder:ClearAnchors()
            if uiTlw[v].alignVertical then
                -- Might need to consolidate these two functions somehow, possibly consolidate all options so that Left = Top, Middle = Center, Right = Bottom
                uiTlw[v].iconHolder:SetAnchor( g_longVertAlign )
            else
                if v == "player_long" then
                    uiTlw[v].iconHolder:SetAnchor( g_longHorizAlign )
                else
                    uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
                end
            end
        end
    end
end

function SCB.SetIconsAlignmentLongVert( value )
    -- Check correctness of argument value
    if value ~= "Top" and value ~= "Middle" and value ~= "Bottom" then
        value = SCB.D.AlignmentLongVert
    end
    SCB.SV.AlignmentLongVert = value

    if not SCB.Enabled then
        return
    end

    g_longVertAlign = ( value == "Top" ) and TOP or ( value == "Bottom" ) and BOTTOM or MIDDLE

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            uiTlw[v].iconHolder:ClearAnchors()
            if uiTlw[v].alignVertical then
                -- Might need to consolidate these two functions somehow, possibly consolidate all options so that Left = Top, Middle = Center, Right = Bottom
                uiTlw[v].iconHolder:SetAnchor( g_longVertAlign )
            else
                if v == "player_long" then
                    uiTlw[v].iconHolder:SetAnchor( g_longHorizAlign )
                else
                    uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
                end
            end
        end
    end
end

function SCB.SetIconsAlignmentLongHorz( value )
    -- Check correctness of argument value
    if value ~= "Left" and value ~= "Centered" and value ~= "Right" then
        value = SCB.D.AlignmentLongHorz
    end
    SCB.SV.AlignmentLongHorz = value

    if not SCB.Enabled then
        return
    end

    g_longHorizAlign = ( value == "Left" ) and LEFT or ( value == "Right" ) and RIGHT or CENTER

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            uiTlw[v].iconHolder:ClearAnchors()
            if uiTlw[v].alignVertical then
                -- Might need to consolidate these two functions somehow, possibly consolidate all options so that Left = Top, Middle = Center, Right = Bottom
                uiTlw[v].iconHolder:SetAnchor( g_longVertAlign )
            else
                if v == "player_long" then
                    uiTlw[v].iconHolder:SetAnchor( g_longHorizAlign )
                else
                    uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
                end
            end
        end
    end
end

-- Sets horizontal sort direction. Called from Settings Menu.
function SCB.SetSortDirection( value )
    -- Check correctness of argument value
    if value ~= "Left to Right" and value ~= "Right to Left" then
        value = SCB.D.SortDirection
    end
    SCB.SV.SortDirection = value

    g_horizSortInvert = (value == "Right to Left")
end

-- Reset position of windows. Called from Settings Menu.
function SCB.ResetTlwPosition()
    if not SCB.Enabled then
        return
    end
    SCB.SV.playerbOffsetX = nil
    SCB.SV.playerbOffsetY = nil
    SCB.SV.playerdOffsetX = nil
    SCB.SV.playerdOffsetY = nil
    SCB.SV.targetbOffsetX = nil
    SCB.SV.targetbOffsetY = nil
    SCB.SV.targetdOffsetX = nil
    SCB.SV.targetdOffsetY = nil
    SCB.SV.playerVOffsetX = nil
    SCB.SV.playerVOffsetY = nil
    SCB.SV.playerHOffsetX = nil
    SCB.SV.playerHOffsetY = nil
    SCB.SetTlwPosition()
end

-- Set position of windows. Called from .Initialize() and .ResetTlwPosition()
function SCB.SetTlwPosition()
    -- If icons are locked to custom frames, i.e. uiTlw[] is a CT_CONTROL of LUIE.UnitFrames.CustomFrames.player
    -- We do not have to do anything here. so just bail out

    -- Otherwise set position of uiTlw[] which are CT_TOPLEVELCONTROLs to saved or default positions
    if uiTlw.playerb and uiTlw.playerb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.playerb:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.playerbOffsetX ~= nil and SCB.SV.playerbOffsetY ~= nil then
            uiTlw.playerb:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerbOffsetX, SCB.SV.playerbOffsetY )
        else
            uiTlw.playerb:SetAnchor( BOTTOM, ZO_PlayerAttributeHealth, TOP, 0, -10 )
        end
    end

    if uiTlw.playerd and uiTlw.playerd:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.playerd:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.playerdOffsetX ~= nil and SCB.SV.playerdOffsetY ~= nil then
            uiTlw.playerd:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerdOffsetX, SCB.SV.playerdOffsetY )
        else
            uiTlw.playerd:SetAnchor( BOTTOM, ZO_PlayerAttributeHealth, TOP, 0, -60 )
        end
    end

    if uiTlw.targetb and uiTlw.targetb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.targetb:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.targetbOffsetX ~= nil and SCB.SV.targetbOffsetY ~= nil then
            uiTlw.targetb:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.targetbOffsetX, SCB.SV.targetbOffsetY )
        else
            uiTlw.targetb:SetAnchor( TOP, ZO_TargetUnitFramereticleover, BOTTOM, 0, 60 )
        end
    end

    if uiTlw.targetd and uiTlw.targetd:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.targetd:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.targetdOffsetX ~= nil and SCB.SV.targetdOffsetY ~= nil then
            uiTlw.targetd:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.targetdOffsetX, SCB.SV.targetdOffsetY )
        else
            uiTlw.targetd:SetAnchor( TOP, ZO_TargetUnitFramereticleover, BOTTOM, 0, 110 )
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

-- Unlock windows for moving. Called from Settings Menu.
function SCB.SetMovingState(state)
    if not SCB.Enabled then
        return
    end

    -- Set moving state
    if uiTlw.playerb and uiTlw.playerb:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.playerb:SetMouseEnabled( state )
        uiTlw.playerb:SetMovable( state )
    end
    if uiTlw.playerd and uiTlw.playerd:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.playerd:SetMouseEnabled( state )
        uiTlw.playerd:SetMovable( state )
    end
    if uiTlw.targetb and uiTlw.targetb:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.targetb:SetMouseEnabled( state )
        uiTlw.targetb:SetMovable( state )
    end
    if uiTlw.targetd and uiTlw.targetd:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.targetd:SetMouseEnabled( state )
        uiTlw.targetd:SetMovable( state )
    end
    if uiTlw.player_long then
        uiTlw.player_long:SetMouseEnabled( state )
        uiTlw.player_long:SetMovable( state )
    end

    -- Show/hide preview
    for _, v in pairs(containerRouting) do
        uiTlw[v].preview:SetHidden( not state )
    end

    -- Now create or remove test-effects icons
    for i = 1, #testEffectList do
        if state then
            SCB.CreatePreviewIcon( testEffectIds[i], testEffectList[i] )
        else
            local abilityId = testEffectIds[i]
            g_effectsList.player1[abilityId] = nil
            g_effectsList.player2[abilityId] = nil
            g_effectsList.ground[abilityId] = nil
        end
    end
end

-- Create preview icon for buff or debuff.
function SCB.CreatePreviewIcon( id, duration )
    SCB.NewEffects( {
        id = id,
        name = testEffectPrefix .. duration,
        icon = "/esoui/art/icons/icon_missing.dds",
        effects = { duration*1000, duration*1000+5, duration*1000, 0 }
    } )
end

function SCB.Reset()
    if not SCB.Enabled then
        return
    end

    -- Update padding between icons
    g_padding = math.floor(0.5 + SCB.SV.IconSize / 13)

    -- Set size of top level window
    -- Player
    if uiTlw.playerb and uiTlw.playerb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.playerb:SetDimensions( 500, SCB.SV.IconSize + 6 )
        uiTlw.playerd:SetDimensions( 500, SCB.SV.IconSize + 6 )
    else
        uiTlw.player2:SetHeight( SCB.SV.IconSize )
        uiTlw.player2.firstAnchor = { TOPLEFT, TOP }
        uiTlw.player2.maxIcons = math.floor(  (uiTlw.player2:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )

        uiTlw.player1:SetHeight( SCB.SV.IconSize)
        uiTlw.player1.firstAnchor = { TOPLEFT, TOP }
        uiTlw.player1.maxIcons = math.floor(  (uiTlw.player1:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )
    end

    -- Target
    if uiTlw.targetb and uiTlw.targetb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.targetb:SetDimensions( 500, SCB.SV.IconSize + 6 )
        uiTlw.targetd:SetDimensions( 500, SCB.SV.IconSize + 6 )
    else
        uiTlw.target2:SetHeight( SCB.SV.IconSize )
        uiTlw.target2.firstAnchor = { TOPLEFT, TOP }
        uiTlw.target2.maxIcons = math.floor(  (uiTlw.target2:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )

        uiTlw.target1:SetHeight( SCB.SV.IconSize)
        uiTlw.target1.firstAnchor = { TOPLEFT, TOP }
        uiTlw.target1.maxIcons = math.floor(  (uiTlw.target1:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )
    end

    -- Player long buffs
    if uiTlw.player_long then
        if uiTlw.player_long.alignVertical then
            uiTlw.player_long:SetDimensions( SCB.SV.IconSize + 6, 400 )
        else
            uiTlw.player_long:SetDimensions( 500, SCB.SV.IconSize + 6 )
        end
    end

    -- Reset alignment and sort
    SCB.SetIconsAlignment( SCB.SV.Alignment )
    SCB.SetIconsAlignmentLongVert( SCB.SV.AlignmentLongVert )
    SCB.SetIconsAlignmentLongHorz( SCB.SV.AlignmentLongHorz )
    SCB.SetSortDirection( SCB.SV.SortDirection )

    local needs_reset = {}
    -- And reset sizes of already existing icons
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
    buff.label:SetAnchor(TOPLEFT, buff, LEFT, -g_padding, -SCB.SV.LabelPosition)
    buff.label:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT, g_padding, -2)
    buff.label:SetHidden( not SCB.SV.RemainingText )
	buff.stack:SetAnchor(CENTER, buff, BOTTOMLEFT, 0, 0)
	buff.stack:SetAnchor(CENTER, buff, TOPRIGHT, -g_padding * 3, g_padding * 3)
	buff.stack:SetHidden( true )
	
    if buff.cd ~= nil then
        buff.cd:SetHidden(     not SCB.SV.RemainingCooldown )
        buff.iconbg:SetHidden( not SCB.SV.RemainingCooldown ) -- We do not need black icon background when there is no Cooldown control present
    end

    local inset = (SCB.SV.RemainingCooldown and buff.cd ~= nil) and 3 or 1

    buff.icon:ClearAnchors()
    buff.icon:SetAnchor( TOPLEFT, buff, TOPLEFT, inset, inset )
    buff.icon:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -inset, -inset )
    if buff.iconbg ~= nil then
        buff.iconbg:ClearAnchors()
        buff.iconbg:SetAnchor( TOPLEFT, buff, TOPLEFT, inset, inset)
        buff.iconbg:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -inset, -inset)
    end

    -- Position all items except first one to the right of it's neighbour
    -- First icon is positioned automatically if the container is present
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

    -- Rest icons go one after another.
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

    -- Enable tooltip
    buff:SetMouseEnabled( true )
    buff:SetHandler("OnMouseEnter", ZO_Options_OnMouseEnter)
    buff:SetHandler("OnMouseExit",  ZO_Options_OnMouseExit)
    buff.data = {}

    -- Border
    buff.back   = UI.Texture( buff, nil, nil, "/esoui/art/actionbar/abilityframe64_up.dds", nil, false )
    buff.back:SetAnchor(TOPLEFT, buff, TOPLEFT)
    buff.back:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT)
    -- Glow border
    buff.frame  = UI.Texture( buff, {CENTER,CENTER}, nil, nil, nil, false )
    -- Background
    if container ~= "player_long" then
        buff.iconbg = UI.Texture( buff, nil, nil, "/esoui/art/actionbar/abilityinset.dds", DL_CONTROLS, true )
        buff.iconbg = UI.Backdrop( buff, nil, nil, {0,0,0,0.9}, {0,0,0,0.9}, false )
        buff.iconbg:SetDrawLevel(DL_CONTROLS)
    end
    -- Icon itself
    buff.icon   = UI.Texture( buff, nil, nil, "/esoui/art/icons/icon_missing.dds", DL_CONTROLS, false )
    -- Remaining text label
    buff.label = UI.Label( buff, nil, nil, nil, g_buffsFont, nil, false )
    buff.label:SetAnchor(TOPLEFT, buff, LEFT, -g_padding, -SCB.SV.LabelPosition)
    buff.label:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT, g_padding, -2)
	-- Stack label
	buff.stack = UI.Label( buff, nil, nil, nil, g_buffsFont, nil, false )
	buff.stack:SetAnchor(CENTER, buff, BOTTOMLEFT, 0, 0)
	buff.stack:SetAnchor(CENTER, buff, TOPRIGHT, -g_padding * 3, g_padding * 3)
    -- Cooldown circular control
    if buff.iconbg ~= nil then
        buff.cd = WINDOW_MANAGER:CreateControl(nil, buff, CT_COOLDOWN)
        buff.cd:SetAnchor( TOPLEFT, buff, TOPLEFT, 1, 1 )
        buff.cd:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -1, -1 )
        buff.cd:SetDrawLayer(DL_BACKGROUND)
    end

    SCB.ResetSingleIcon(container, buff, AnchorItem)
    return buff
end

 -- Set proper colour of border and text on single buff element
function SCB.SetSingleIconBuffType(buff, buffType, unbreakable)
    local contextType
    local colour
    if not unbreakable or unbreakable == 0 then
        if buffType == 1 then
            contextType = "buff"
            colour = {0,1,0,1}
        else
            contextType = "debuff"
            colour = {1,0,0,1}
        end
    elseif unbreakable == 1 then
        if buffType == 1 then
            contextType = "buff"
            colour = {0,1,1,1}
        else
            contextType = "debuff"
            colour = {.88,.88,1,1}
        end
    end
    -- {0.07, 0.45, 0.8}

    buff.frame:SetTexture("/esoui/art/actionbar/" .. contextType .. "_frame.dds")
    buff.label:SetColor( unpack( SCB.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
	buff.stack:SetColor( unpack( SCB.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
    if buff.cd ~= nil then
        buff.cd:SetFillColor( unpack(colour) )
    end
end

-- Updates local variable with new font and resets all existing icons
function SCB.ApplyFont()
    if not SCB.Enabled then
        return
    end

    -- First try selecting font face
    local fontName = LUIE.Fonts[SCB.SV.BuffFontFace]
    if not fontName or fontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT))
        fontName = "$(MEDIUM_FONT)"
    end

    local fontStyle = ( SCB.SV.BuffFontStyle and SCB.SV.BuffFontStyle ~= "" ) and SCB.SV.BuffFontStyle or "outline"
    local fontSize = ( SCB.SV.BuffFontSize and SCB.SV.BuffFontSize > 0 ) and SCB.SV.BuffFontSize or 17

    g_buffsFont = fontName .. "|" .. fontSize .. "|" .. fontStyle

    local needs_reset = {}
    -- And reset sizes of already existing icons
    for _, container in pairs(containerRouting) do
        needs_reset[container] = true
    end
    for _, container in pairs(containerRouting) do
        if needs_reset[container] then
            for i = 1, #uiTlw[container].icons do
                uiTlw[container].icons[i].label:SetFont(g_buffsFont)
            end
        end
        needs_reset[container] = false
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
function SCB.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    
    if castByPlayer == COMBAT_UNIT_TYPE_PLAYER then
        if g_pendingGroundAbility and g_pendingGroundAbility.id == abilityId and changeType == EFFECT_RESULT_GAINED then
            -- Cast ability
            if not SCB.SV.HideGroundEffects then
                SCB.NewEffects( g_pendingGroundAbility )
            end
            -- Clear the ground target queue
            g_pendingGroundAbility = nil
        end
        
        -- Create fake ground aura
        if E.EffectGroundDisplay[abilityId] then
            if changeType ~= EFFECT_RESULT_FADED then
                local duration = endTime - beginTime
                
                local groundType = { }
                groundType[1] = { info = E.EffectGroundDisplay[abilityId].buff, context = "player1", type = 1 }
                groundType[2] = { info = E.EffectGroundDisplay[abilityId].debuff, context = "player2", type = BUFF_EFFECT_TYPE_DEBUFF }
                groundType[3] = { info = E.EffectGroundDisplay[abilityId].ground, context = "ground", type = BUFF_EFFECT_TYPE_DEBUFF }
                iconName = E.EffectGroundDisplay[abilityId].icon or iconName
                effectName = E.EffectGroundDisplay[abilityId].name or effectName
                
                for i = 1, 3 do
                    if groundType[i].info == true then
                        g_effectsList[groundType[i].context][ abilityId ] = {
                            target="player", type=groundType[i].type,
                            id=abilityId, name=effectName, icon=iconName,
                            dur=1000*duration, starts=1000*beginTime, ends=(duration > 0) and (1000*endTime) or nil,
                            forced=nil,
                            restart=true, iconNum=0,
                            unbreakable=0 }
                    end
                end
            end
        end
        
    end
    
    if SCB.SV.HidePlayerBuffs and effectType == 1 and unitTag == "player" then
        return
    end
    if SCB.SV.HidePlayerDebuffs and effectType == 2 and unitTag == "player" then
        return
    end
    if SCB.SV.HideTargetBuffs and effectType == 1 and unitTag ~= "player" then
        return
    end
    if SCB.SV.HideTargetDebuffs and effectType == 2 and unitTag ~= "player" then
        return
    end
    --d(strfmt("OnEffectChanged %d: %s[%s] / %d/%d/%d [%s-%d] %d", changeType, effectName, unitTag, effectType, abilityType, statusEffectType, unitName, unitId, abilityId ))

    -- Track only effects on self or target debuffs
    if unitTag ~= "player" and unitTag ~= "reticleover" then
        return
    end
    
    effectName = strformat("<<C:1>>", effectName)
    local unbreakable = 0
   
    if E.EffectOverride[abilityId] then
        if E.EffectOverride[abilityId].hide == true then return end
        effectType = E.EffectOverride[abilityId].type or effectType
        iconName = E.EffectOverride[abilityId].icon or E.AbilityIcon[effectName or ""] or iconName
        effectName = E.EffectOverride[abilityId].name or effectName
        unbreakable = E.EffectOverride[abilityId].unbreakable or 0
    end
    
    if E.EffectOverrideByName[abilityId] then
        unitName = strformat("<<t:1>>", unitName)
        if E.EffectOverrideByName[abilityId][unitName] then
            if E.EffectOverrideByName[abilityId][unitName].hide then 
                return
            end
            iconName = E.EffectOverrideByName[abilityId][unitName].icon or E.AbilityIcon[effectName or ""] or iconName
            effectName = E.EffectOverrideByName[abilityId][unitName].name or effectName
        end
    end
               
    -- If the source of the buff isn't the player or the buff is not on the AbilityId or AbilityName override list then we don't display it
    if unitTag ~= "player" then
        if effectType == 2 and not (castByPlayer == 1) and not (E.DebuffDisplayOverrideId[abilityId] or E.DebuffDisplayOverrideName[effectName]) then
            return
        end
    end

    -- If block is not toggled to be displayed for player, don't show icon for it. Want to show it for targets regardless.
    if abilityType == ABILITY_TYPE_BLOCK and unitTag == "player" and not SCB.SV.ShowBlockPlayer then
        return
    end

    if abilityType == ABILITY_TYPE_BLOCK and unitTag == "reticleover" and not SCB.SV.ShowBlockTarget then
        return
    end
    
    -- Hide effects if chosen in the options menu
    if hidePlayerEffects[abilityId] and unitTag == "player" then
        return
    end
    
    if hideTargetEffects[abilityId] and unitTag == "reticleover" then
        return
    end
        
    local forcedType = E.EffectForcedType[abilityId] or E.EffectForcedName[effectName]
	
	if unitTag == "reticleover" and abilityId == 92428 and not IsUnitPlayer('reticleover') then return end 

    -- Where the new icon will go into
    local context = unitTag .. effectType

    -- Exit here if there is no container to hold this effect
    if not containerRouting[context] then
        return
    end

    if changeType == EFFECT_RESULT_FADED then -- delete Effect
        g_effectsList[context][effectSlot] = nil
        if E.FakeDuplicate[ abilityId ] then
            g_effectsList[context][ E.FakeDuplicate[abilityId].name ] = nil
        end
        
    -- Create Effect
    else
        local duration = endTime - beginTime
        
        if E.EffectOverride[abilityId] and E.EffectOverride[abilityId].duration then
            if E.EffectOverride[abilityId].duration == 0 then 
                duration = 0 
            else
               duration = duration - E.EffectOverride[abilityId].duration
            end
            endTime = endTime - E.EffectOverride[abilityId].duration
        end

        -- Buffs are created based on their ability ID, this allows buffs with the same display name to show up.
        g_effectsList[context][ effectSlot ] = {
                    target=unitTag, type=effectType,
                    id=abilityId, name=effectName, icon=iconName,
                    dur=1000*duration, starts=1000*beginTime, ends=(duration > 0) and (1000*endTime) or nil,
                    forced=forcedType,
                    restart=true, iconNum=0,
					stack = stackCount,
                    unbreakable=unbreakable }
           
        -- Create a fake container for certain major/minor buffs
        if E.FakeDuplicate[ abilityId ] then
                g_effectsList[context][ E.FakeDuplicate[abilityId].name ] = {
                    target=unitTag, type=effectType,
                    name=E.FakeDuplicate[abilityId].name, icon=E.FakeDuplicate[abilityId].icon,
                    dur=1000*duration, starts=1000*beginTime, ends=(duration > 0) and (1000*endTime) or nil,
                    forced=forcedType,
                    restart=true, iconNum=0,
					stack = stackCount,
                    unbreakable=unbreakable }
        end
    end
end

function SCB.ArtificialEffectUpdate(eventCode, effectId)

    if effectId then g_effectsList.player1[effectId] = nil end

    for effectId in ZO_GetNextActiveArtificialEffectIdIter do
            local displayName, iconFile, effectType, _, startTime = GetArtificialEffectInfo(effectId)
            --local forcedType = E.EffectForcedType[artificialEffectId]
            -- Bail out if we don't have Battle Spirit display for the player on
            
            if (effectId == 0 or effectId == 2) and SCB.SV.IgnoreBattleSpiritPlayer then return end

            g_effectsList.player1[ effectId ] = {
                target="player", type=effectType,
                id=effectId, name = displayName, icon = iconFile,
                dur=0, starts=startTime, ends=nil,
                --forced = forcedType,
                restart=true, iconNum=0,
                }
    end    
end

-- List of all damage results for analysis in following function
 -- This also includes SHIELDED result that is not included in CI module
local IsResultDamage = {
    [ACTION_RESULT_DAMAGE]          	= true,
    [ACTION_RESULT_BLOCKED_DAMAGE]  	= true,
    [ACTION_RESULT_DAMAGE_SHIELDED] 	= true,
    [ACTION_RESULT_CRITICAL_DAMAGE] 	= true,
    [ACTION_RESULT_DOT_TICK]        	= true,
    [ACTION_RESULT_DOT_TICK_CRITICAL]	= true,
}

--[[
 * Runs on the EVENT_COMBAT_EVENT listener.
 * This handler fires every time ANY combat activity happens. Very-very often.
 * We use it to remove mines from active target debuffs
 * As well as create fake buffs/debuffs for events with no active effect present.
 ]]--
 
 -- Combat Event (Target = Player)
function SCB.OnCombatEventIn( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
 
	if not (E.FakeExternalBuffs[abilityId] or E.FakeExternalDebuffs[abilityId] or E.FakePlayerBuffs[abilityId] or E.FakeStagger[abilityId]) then return end
 
	local unbreakable
	local stack
	local iconName
	local effectName
	local duration
	local effectType
	
    if E.EffectOverride[abilityId] then
        unbreakable = E.EffectOverride[abilityId].unbreakable or 0
		stack = E.EffectOverride[abilityId].stack or 1
	else
		unbreakable = 0
		stack = 1
    end
	
	-- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on player by target)
    if E.FakeExternalBuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        if E.FakeExternalBuffs[abilityId].norefresh == true and (result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_FADED) then return end
        g_effectsList.player1[ abilityId ] = nil
        iconName = E.FakeExternalBuffs[abilityId].icon
        effectName = E.FakeExternalBuffs[abilityId].name
        duration = E.FakeExternalBuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        if source ~= "" and target == playerName then
            g_effectsList.player1[ abilityId ] = {
            type=1,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0,
            unbreakable=unbreakable }
        end
    end
	
	-- Creates fake debuff icons for debuffs without an aura - These refresh on reapplication/removal (Applied on player by target)
    if E.FakeExternalDebuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        if E.FakeExternalDebuffs[abilityId].norefresh == true and (result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_FADED) then return end
        g_effectsList.player2[ abilityId ] = nil
        iconName = E.FakeExternalDebuffs[abilityId].icon
        effectName = E.FakeExternalDebuffs[abilityId].name
        duration = E.FakeExternalDebuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        if source ~= "" and target == playerName then
            g_effectsList.player2[ abilityId ] = {
            type=BUFF_EFFECT_TYPE_DEBUFF,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0,
            unbreakable=unbreakable }
        end
    end
	
	-- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on player by player)
    if E.FakePlayerBuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        if E.FakePlayerBuffs[abilityId].norefresh == true and (result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_FADED) then return end
        g_effectsList.player1[ abilityId ] = nil
        if abilityId == 973 and not SCB.SV.ShowSprint then
            return
        end
        if abilityId == 33439 and not SCB.SV.ShowGallop then
            return
        end

        iconName = E.FakePlayerBuffs[abilityId].icon
        effectName = E.FakePlayerBuffs[abilityId].name
        duration = E.FakePlayerBuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        if source == playerName and target == playerName then
            if E.FakePlayerBuffs[abilityId].debuff == true then -- If the "buff" is flagged as a debuff, then display it here instead
                g_effectsList.player2[ abilityId ] = {
                type=BUFF_EFFECT_TYPE_DEBUFF,
                id=abilityId, name=effectName, icon=iconName,
                dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                forced = "short",
                restart=true, iconNum=0,
                unbreakable=unbreakable }
            else -- Otherwise, display as a normal buff
                g_effectsList.player1[ abilityId ] = {
                type=1,
                id=abilityId, name=effectName, icon=iconName,
                dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                forced = "short",
                restart=true, iconNum=0,
                unbreakable=unbreakable }
            end
        end
    end
	
	    -- Simulates fake debuff icons for stagger effects - works for both (target -> player) and (player -> target) - DOES NOT REFRESH - Only expiration condition is the timer
    if E.FakeStagger[abilityId] then
        if E.FakeStagger[abilityId].norefresh == true and (result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_FADED) then return end
        iconName = E.FakeStagger[abilityId].icon
        effectName = E.FakeStagger[abilityId].name
        duration = E.FakeStagger[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        local unitName = strformat("<<t:1>>", GetUnitName("reticleover") )
        if source ~= "" and target == playerName then
            g_effectsList.player2[ abilityId ] = {
            type=BUFF_EFFECT_TYPE_DEBUFF,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0,
            unbreakable=unbreakable }
        end
    end
	
end

 -- Combat Event (Source = Player)
function SCB.OnCombatEventOut( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
	if targetType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER_PET then return end
	
	if not (E.IsGroundMine[abilityName] or E.FakePlayerExternalBuffs[abilityId] or E.FakePlayerDebuffs[abilityId] or E.FakeStagger[abilityId]) then return end
	
	-- Try to remove effect like Ground Runes and Traps
    if E.IsGroundMine[abilityName] and IsResultDamage[result] and ( targetType == COMBAT_UNIT_TYPE_NONE or targetType == COMBAT_UNIT_TYPE_OTHER) then
		for k, v in pairs(g_effectsList.ground) do
			if v.name == abilityName then 
				g_effectsList.ground[ k ] = nil
			end
		end
    end
    
    local unbreakable
	local stack
	local iconName
	local effectName
	local duration
	local effectType
	
    if E.EffectOverride[abilityId] then
        unbreakable = E.EffectOverride[abilityId].unbreakable or 0
		stack = E.EffectOverride[abilityId].stack or 1
	else
		unbreakable = 0
		stack = 1
    end
	
	-- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on target by player)
    if E.FakePlayerExternalBuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        if E.FakePlayerExternalBuffs[abilityId].norefresh == true and (result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_FADED) then return end
        g_effectsList.reticleover1[ abilityId ] = nil
        if not DoesUnitExist("reticleover") then return end
        if GetUnitReaction("reticleover") == UNIT_REACTION_HOSTILE then return end
        if IsUnitDead(unitTag) then return end
        iconName = E.FakePlayerExternalBuffs[abilityId].icon
        effectName = E.FakePlayerExternalBuffs[abilityId].name
        duration = E.FakePlayerExternalBuffs[abilityId].duration
        effectType = BUFF_EFFECT_TYPE_DEBUFF
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        local unitName = strformat("<<t:1>>", GetUnitName("reticleover") )
        if unitName ~= target then return end
        if source == playerName and target ~= nil then
            if SCB.SV.HideTargetBuffs then
                return
            end
			g_effectsList.reticleover1[ abilityId ] = {
			type=effectType,
			id=abilityId, name=effectName, icon=iconName,
			dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
			forced = "short",
			restart=true, iconNum=0,
			unbreakable=unbreakable }
        end
    end
	
	-- Creates fake debuff icons for debuffs without an aura - These refresh on reapplication/removal (Applied on target by player)
    if E.FakePlayerDebuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        if E.FakePlayerDebuffs[abilityId].norefresh == true and (result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_FADED) then return end
        g_effectsList.reticleover2[ abilityId ] = nil
        if not DoesUnitExist("reticleover") then end
        --if GetUnitReaction("reticleover") ~= UNIT_REACTION_HOSTILE then return end
        if IsUnitDead(unitTag) then return end
        iconName = E.FakePlayerDebuffs[abilityId].icon
        effectName = E.FakePlayerDebuffs[abilityId].name
        duration = E.FakePlayerDebuffs[abilityId].duration
        effectType = BUFF_EFFECT_TYPE_DEBUFF
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        local unitName = strformat("<<t:1>>", GetUnitName("reticleover") )
        --if unitName ~= target then return end
        if source == playerName and target ~= nil then
            if SCB.SV.HideTargetDebuffs then
                return
            end
			if unitName == target then
				g_effectsList.ground[ abilityId ] = {
				type=effectType,
				id=abilityId, name=effectName, icon=iconName,
				dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
				forced = "short",
				restart=true, iconNum=0,
				unbreakable=unbreakable,
				savedName = targetName }
			else
				g_effectsList.saved[ abilityId ] = {
				type=effectType,
				id=abilityId, name=effectName, icon=iconName,
				dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
				forced = "short",
				restart=true, iconNum=0,
				unbreakable=unbreakable,
				savedName = targetName }
			end
        end
    end
	
	-- Simulates fake debuff icons for stagger effects - works for both (target -> player) and (player -> target) - DOES NOT REFRESH - Only expiration condition is the timer
    if E.FakeStagger[abilityId] then
        if E.FakeStagger[abilityId].norefresh == true and (result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_FADED) then return end
        iconName = E.FakeStagger[abilityId].icon
        effectName = E.FakeStagger[abilityId].name
        duration = E.FakeStagger[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        local unitName = strformat("<<t:1>>", GetUnitName("reticleover") )
        if source == playerName and target ~= nil then
            if SCB.SV.HideTargetDebuffs then
                return
            end
			if unitName == target then
				g_effectsList.ground[ abilityId ] = {
				type=BUFF_EFFECT_TYPE_DEBUFF,
				id=abilityId, name=effectName, icon=iconName,
				dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
				forced = "short",
				restart=true, iconNum=0,
				unbreakable=unbreakable,
				savedName = targetName }
			else
				g_effectsList.saved[ abilityId ] = {
				type=BUFF_EFFECT_TYPE_DEBUFF,
				id=abilityId, name=effectName, icon=iconName,
				dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
				forced = "short",
				restart=true, iconNum=0,
				unbreakable=unbreakable,
				savedName = targetName }
			end
        end
    end
	
end

-- Runs on the EVENT_UNIT_DEATH_STATE_CHANGED listener.
-- This handler fires every time a valid unitTag dies or is resurrected
function SCB.OnDeath(eventCode, unitTag, isDead)
    -- Wipe buffs
    if isDead then
        for effectType = 1, 2 do
            g_effectsList[ unitTag .. effectType ] = {}
        end
    end
end

--[[
 * Runs on the EVENT_TARGET_CHANGE listener.
 * This handler fires every time the someone target changes.
 * This function is needed in case the player teleports via Way Shrine
 ]]--
function SCB.OnTargetChange(eventCode, unitTag)
    if unitTag ~= "player" then
        return
    end
    SCB.OnReticleTargetChanged(eventCode)
end

-- Runs on the EVENT_RETICLE_TARGET_CHANGED listener.
-- This handler fires every time the player's reticle target changes
function SCB.OnReticleTargetChanged(eventCode)
    SCB.ReloadEffects("reticleover")
end

-- Used to clear existing LET.effectsList.unitTag and to request game API to fill it again
function SCB.ReloadEffects(unitTag)

    -- If unitTag was not provided, consider it as Player
    local unitTag = unitTag or "player"

    -- clear existing
    g_effectsList[unitTag .. 1] = {}
    g_effectsList[unitTag .. 2] = {}

    -- Fill it again
    --d( "refresh" )
    for i = 1, GetNumBuffs(unitTag) do
        local unitName = GetRawUnitName(unitTag)
        local buffName, timeStarted, timeEnding, buffSlot, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer = GetUnitBuffInfo(unitTag, i)
        -- Fudge this value to send to SCB.OnEffectChanged if this is a debuff
        if castByPlayer == true then
        castByPlayer = 1
        else
            castByPlayer = 5
        end
        SCB.OnEffectChanged(0, 3, buffSlot, buffName, unitTag, timeStarted, timeEnding, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, unitName, 0--[[unitId]], abilityId, castByPlayer)
    end
    
    if not SCB.SV.HideTargetBuffs then
        local unitName = GetUnitName(unitTag)
        -- We need to check to make sure the mob is not dead, and also check to make sure the unitTag is not the player (just in case someones name exactly matches that of a boss NPC)
        if E.IsBossMob[unitName] and GetUnitReaction(unitTag) == UNIT_REACTION_HOSTILE and not (IsUnitDead(unitTag) and unitTag == "player") then
            g_effectsList.reticleover1[ "Boss CC Immunity" ] = {
            type=1,
            name=A.Innate_CC_Immunity, icon="LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds",
            dur=0, starts=1, ends=nil,
            forced = "short",
            restart=true, iconNum=0 }
        end
    end

    -- create custom buff icon for Recall Cooldown effect
    if SCB.SV.ShowRecall and unitTag == "player" then
        local recallRemain, _ = GetRecallCooldown()
        if recallRemain > 0 then
            local currentTime = GetGameTimeMilliseconds()
            g_effectsList["player1"][ A.Innate_Recall_Penalty ] = {
                        target="player", type=1,
                        name=A.Innate_Recall_Penalty, icon='LuiExtended/media/icons/abilities/ability_innate_recall_cooldown.dds',
                        dur=recallRemain, starts=currentTime, ends=currentTime+recallRemain,
                        forced = "long",
                        restart=true, iconNum=0,
                        unbreakable=1 }
        end
    end
    
    -- Add Battle Spirit icon to player in Cyrodiil (Artifical effect Id adds it for Battlegrounds)
    if unitTag =="player" and IsInAvAZone() and not SCB.SV.IgnoreBattleSpiritPlayer then
        g_effectsList.player1[ "Battle Spirit" ] =
            {
            target ="player", type=1,
            name="Battle Spirit", icon = "esoui/art/icons/artificialeffect_battle-spirit.dds",
            dur=0, starts=1, ends=nil,
            forced = "long",
            restart=true, iconNum=0
            }
    end
    
    -- Add Battle Spirit icon to target in Cyrodiil or Battlegrounds
    if unitTag == "reticleover" and ( IsInAvAZone() or IsActiveWorldBattleground() or GetUnitName(unitTag) == g_currentDuelTarget ) and IsUnitPlayer("reticleover") and not SCB.SV.IgnoreBattleSpiritTarget then
        g_effectsList.reticleover1[ "Battle Spirit" ] =
            {
            target ="player", type=1,
            name="Battle Spirit", icon = "esoui/art/icons/artificialeffect_battle-spirit.dds",
            dur=0, starts=1, ends=nil,
            forced = "short",
            restart=true, iconNum=0
            }
    end

    if unitTag == "reticleover" then
	
		for _, effectsList in pairs( {g_effectsList.ground, g_effectsList.saved} ) do
			--local container = containerRouting[context]

			for k, v in pairs(effectsList) do
			
				if v.savedName ~= nil then
					local UnitName = strformat(SI_UNIT_NAME, GetUnitName(unitTag))
					if UnitName == v.savedName then
						if g_effectsList.saved[k] then
							g_effectsList.ground[k] = g_effectsList.saved[k]
							g_effectsList.ground[k].iconNum = 0
							g_effectsList.saved[k] = nil
						end
					else
						if g_effectsList.ground[k] then 
							g_effectsList.saved[k] = g_effectsList.ground[k]
							g_effectsList.ground[k] = nil
						end
					end
				end
			end
		end
    
        if not SCB.SV.IgnoreBattleSpiritTarget then
            if ( ( IsInAvAZone() or IsActiveWorldBattleground() ) and IsUnitPlayer("reticleover") ) or GetUnitName(unitTag) == g_currentDuelTarget then
                g_effectsList.reticleover1[ "Battle Spirit" ] =
                {
                target ="player", type=1,
                name="Battle Spirit", icon = "esoui/art/icons/artificialeffect_battle-spirit.dds",
                dur=0, starts=1, ends=nil,
                forced = "short",
                restart=true, iconNum=0
                }
            end
        end
            
        if SCB.SV.StealthStateTarget then
            local stealthState = GetUnitStealthState ("reticleover")
            if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED) and IsUnitPlayer("reticleover") then
                g_effectsList.reticleover1[ A.Innate_Hidden ] =
                {
                    type=1,
                    name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
                    dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                    forced = "short",
                    restart=true, iconNum=0
                }
            
            elseif ( stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) and IsUnitPlayer("reticleover") then
                g_effectsList.reticleover1[ A.Innate_Hidden ] =
                {
                    type=1,
                    name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_invisible.dds",
                    dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                    forced = "short",
                    restart=true, iconNum=0
                }
            else
                g_effectsList.reticleover1[ A.Innate_Hidden ] = nil
            end
        end

        if SCB.SV.DisguiseStateTarget then
            --d("checking for disguise")
            local disguiseState = GetUnitDisguiseState ("reticleover")
            --d("Disguise State: " .. disguiseState )
            if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
                -- Trigger a buff
                g_effectsList.reticleover1[ A.Innate_Disguised ] =
                {
                    type=1,
                    name=A.Innate_Disguised, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
                    dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                    forced = "short",
                    restart=true, iconNum=0
                }
            -- Else remove buff
            else
                g_effectsList.reticleover1[ A.Innate_Disguised ] = nil
            end
        end
    end
end

-- Process new ability buff effects
function SCB.NewEffects( ability )
    -- Get the time
    local currentTime = GetGameTimeMilliseconds()

    -- Try manually tracked effects first
    local effects = ability.effects
    if ( effects ~= nil ) then

        for i = 1, 3 do
            local context = abilityRouting[i]
            
            if effects[i] and effects[i] > 0 then
                -- Update or create new effect
                if g_effectsList[context][ability.id] ~= nil then
                    g_effectsList[context][ability.id].ends = currentTime + effects[4] + effects[i]
                    g_effectsList[context][ability.id].restart = true
                else
                    g_effectsList[context][ability.id] = {
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

-- Called from EVENT_ACTION_SLOT_ABILITY_USED listener
-- Check for whether a spell is being cast
function SCB.OnSlotAbilityUsed(eventCode, slotNum)
    -- Clear stored ground-target ability
    g_pendingGroundAbility = nil

    -- Get the used ability
    local currentTime = GetGameTimeMilliseconds()
    local ability = g_actionBar[slotNum]

    if ability then -- Only proceed if this button is being watched
        -- Get the time

        -- Avoid failure and button mashing
        if not HasFailure( slotNum ) and ( currentTime > g_lastCast + 250 ) then

            -- Don't process effects immediately for ground-target spells
            if ability.ground then
                g_pendingGroundAbility = ability

            else
                -- Run all routines associated with selected ability
                if not SCB.SV.HideGroundEffects then
                    SCB.NewEffects( ability )
                end

                -- Flag the last cast time
                g_lastCast = currentTime
            end
        end
 
    end
    
end

-- Called from EVENT_ACTION_SLOT_UPDATED listener
function SCB.OnSlotUpdated(eventCode, slotNum)
    --d( strfmt("%d: %s(%d)", slotNum, GetSlotName(slotNum), GetSlotBoundId(slotNum) ) )
    -- Look only for action bar slots
    if slotNum < 3 or slotNum > 8 then
        return
    end

    -- Bail out if slot is not used
    if not IsSlotUsed(slotNum) then
        g_actionBar[slotNum] = nil
        return
    end

    -- Get the slotted ability ID
    local ability_id = GetSlotBoundId(slotNum)

    -- Get additional ability information
    local abilityName = E.EffectOverride[ability_id] and E.EffectOverride[ability_id].name or GetAbilityName(ability_id) -- GetSlotName(slotNum)
    -- Localization ^^ here. We will use English name from here onwards.
    local abilityCost, mechanicType = GetSlotAbilityCost(slotNum)
    -- Get API information for this ability
    local channeled, castTime, channelTime = GetAbilityCastInfo(ability_id)
    local duration = GetAbilityDuration(ability_id)

    local effects = nil
    
    if Effects[ abilityName ] then
        effects = {}
        for i = 1, 4 do
            if not Effects[ abilityName  ][i] or Effects[ abilityName  ][i] == 0 then
                effects[i] = 0
            elseif Effects[ abilityName  ][i] == true then
                effects[i] = (i < 4) and duration or castTime
            else
                effects[i] = Effects[ abilityName ][i] * 1000
            end
        end
    end

    g_actionBar[slotNum] = {
        id      = ability_id,
        name    = abilityName,
        type    = mechanicType,
        cost    = abilityCost,
        icon    = GetSlotTexture(slotNum),
        ground  = ( GetAbilityTargetDescription(ability_id) == "Ground" ),
        effects = effects,
        duration = duration,
        slotNum=slotNum
    }

end

function SCB.OnSlotsFullUpdate(eventCode, isHotbarSwap)
    -- If the event was triggered by a weapon swap we need to clear ground-target stored ability
    if isHotbarSwap then
        g_pendingGroundAbility = nil
    end

    -- Update action bar skills
    g_actionBar = {}
    for i = 3, 8 do
        SCB.OnSlotUpdated(eventCode, i)
    end
end

-- Helper function to sort buffs
local function buffSort(x, y)
    -- Sort pernament effects
    if (x.ends == nil and y.ends == nil) or (x.dur == 0 and y.dur == 0) then
        return (x.starts == y.starts) and (x.name < y.name) or (x.starts < y.starts)

    -- Both non-permanent
    elseif x.dur ~= 0 and y.dur ~= 0 then
        return x.ends > y.ends

    -- One permanent, one not
    else
        return (x.dur == 0)
    end
end

-- Runs OnUpdate - 100 ms buffer
function SCB.OnUpdate(currentTime)
    -- local currentTime = GetGameTimeMilliseconds()

    local buffsSorted = {}
    local needs_update = {}
    -- And reset sizes of already existing icons
    for _, container in pairs(containerRouting) do
        needs_update[container] = true
        -- Prepare sort container
        if buffsSorted[container] == nil then
            buffsSorted[container] = {}
        end
    end

    -- Filter expired events. and build array for sorting
    for context, effectsList in pairs(g_effectsList) do
        local container = containerRouting[context]

        for k, v in pairs(effectsList) do
        
            -- Remove effect (that is not permanent and has duration)
            if v.ends ~= nil and v.dur > 0 and v.ends < currentTime then
                effectsList[k] = nil

            -- Or append to correct container
            elseif container then
                -- Add icons to to-be-sorted list only if effect already started
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

    -- Sort effects in container and draw them on screen
    for _, container in pairs(containerRouting) do
        if needs_update[container] then
            table.sort(buffsSorted[container], buffSort)
            SCB.updateIcons( currentTime, buffsSorted[container], container )
        end
        needs_update[container] = false
    end
end

function SCB.updateIcons( currentTime, sortedList, container )
    -- Speial workaround for container with player long buffs. We do not need to update it every 100ms, but rather 3 times less often
    if uiTlw[container].skipUpdate then
        uiTlw[container].skipUpdate = uiTlw[container].skipUpdate + 1
        if uiTlw[container].skipUpdate > 1 then
            uiTlw[container].skipUpdate = 0
        else
            return
        end
    end

    local iconsNum = #sortedList

    -- Chose direction of iteration
    local istart, iend, istep
    -- Reverse the order for right aligned icons
    if container == "player_long" and SCB.SV.LongTermEffectsReverse then
        if g_horizSortInvert and not uiTlw[container].alignVertical then
            istart, iend, istep = iconsNum, 1, -1
        else
            istart, iend, istep = iconsNum, 1, -1
        end
    else
        if g_horizSortInvert and not uiTlw[container].alignVertical then
            istart, iend, istep = iconsNum, 1, -1
        else
            istart, iend, istep = 1, iconsNum, 1
        end
    end
    
    -- Size of icon+padding
    local iconSize = SCB.SV.IconSize + g_padding

    -- Set width of contol that holds icons. This will make alignment automatic
    if uiTlw[container].iconHolder then
        if uiTlw[container].alignVertical then
            uiTlw[container].iconHolder:SetDimensions( 0, iconSize*iconsNum - g_padding )
        else
            uiTlw[container].iconHolder:SetDimensions( iconSize*iconsNum - g_padding, 0 )
        end
    end

    -- Prepare variables for manual alignment of icons
    local row = 0   -- row counter for multi-row placement
    local next_row_break = 1

    -- Iterate over list of sorted icons
    local index = 0 -- Global icon counter
    for i = istart, iend, istep do
        -- Get current buff definition
        local effect = sortedList[i]
        index = index + 1
        -- Check if the icon for buff #index exists otherwise create new icon
        if uiTlw[container].icons[index] == nil then
            uiTlw[container].icons[index] = SCB.CreateSingleIcon(container, uiTlw[container].icons[index-1])
        end

        -- Calculate remaining time
        local remain = ( effect.ends ~= nil ) and ( effect.ends - currentTime ) or nil

        local buff = uiTlw[container].icons[index]

        -- Perform manual alignment
        if not uiTlw[container].iconHolder then
            if iconsNum ~= uiTlw[container].prevIconsCount and index == next_row_break --[[ and horizontal orientation of container ]] then
                -- Padding of first icon in a row
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
                -- Determine if we need to make next row
                if uiTlw[container].maxIcons then
                    -- If buffs then stack down
                    if container == "player1" or container == "target1" then
                        row = row + 1
                    -- If debuffs then stack up
                    elseif container == "player2"  or container == "target2" then
                        row = row -1
                    end
                    next_row_break = next_row_break + uiTlw[container].maxIcons
                end
            end
        end

        -- If previously this icon was used for different effect, then setup it again
        if effect.iconNum ~= index then
            effect.iconNum = index
            effect.restart = true
            SCB.SetSingleIconBuffType(buff, effect.type, effect.unbreakable)
            buff.data.tooltipText = effect.name --.. " || " .. (effect.id or "?")
            buff.icon:SetTexture(effect.icon)
            buff:SetAlpha(1)
            buff:SetHidden(false)
            if not remain then
                buff.label:SetText( E.IsToggle[effect.name] and "T" or nil )
                -- buff.label:SetText( E.IsToggle[effect.name] and "T" or E.IsVampStage(effect) and (E.IsVampStage(effect)) or nil ) -- Deprecated
            end
        end
		
		if effect.stack and effect.stack > 1 then
			buff.stack:SetText( strfmt("%s", effect.stack) )
			buff.stack:SetHidden(false)
		else
			buff.stack:SetHidden(true)
		end

        -- For update remaining text. For temporary effects this is not very efficient, but we have not much such effects
        if remain then
            if remain > 86400000 then -- more then 1 day
                buff.label:SetText( strfmt("%d d", math.floor( remain/86400000 )) )
            elseif remain > 6000000 then -- over 100 minutes - display XXh
                buff.label:SetText( strfmt("%dh", math.floor( remain/3600000 )) )
            elseif remain > 600000 then -- over 10 minutes - display XXm
                buff.label:SetText( strfmt("%dm", math.floor( remain/60000 )) )
            elseif remain > 60000 or container == "player_long" then
                local m = math.floor( remain/60000 )
                local s = remain/1000 - 60*m
                buff.label:SetText( strfmt("%d:%.2d", m, s) )
            else
                buff.label:SetText( strfmt(SCB.SV.RemainingTextMillis and "%.1f" or "%.1d", remain/1000) )
            end
        end
        if effect.restart and buff.cd ~= nil then
            -- Modify recall cooldown to always display as if the full CD was 10 minutes.
            if effect.name == A.Innate_Recall_Penalty then effect.dur = 600000 end
            if remain == nil or effect.dur == nil or effect.dur == 0 then
                buff.cd:StartCooldown(0, 0, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_REMAINING, false )
            else
                buff.cd:StartCooldown(remain, effect.dur, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_UNTIL, false )
                effect.restart = false
            end
        end

        -- Now possibly fade out expiring icon
        if SCB.SV.FadeOutIcons and remain ~= nil and remain < 2000 then
            --buff:SetAlpha( 0.05 + remain/2106 )
            buff:SetAlpha(EaseOutQuad(remain, 0, 1, 2000))
        end
    end

    -- Hide rest of icons
    for i = iconsNum+1, #uiTlw[container].icons do
        uiTlw[container].icons[i]:SetHidden(true)
    end

    -- Save icon number processed to compare in next update iteration
    uiTlw[container].prevIconsCount = iconsNum
end

-- Runs on the EVENT_STEALTH_STATE_CHANGED listener.
-- Watches for changes in a stealth state to display custom buff icon
function SCB.StealthStateChanged( eventCode , unitTag , stealthState )
    if SCB.SV.StealthStatePlayer and unitTag == "player" then
        if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED) then
            g_effectsList.player1[ A.Innate_Hidden ] =
            {
                type=1,
                name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        
        elseif ( stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) then
            g_effectsList.player1[ A.Innate_Hidden ] =
            {
                type=1,
                name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_invisible.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        else
            g_effectsList.player1[ A.Innate_Hidden ] = nil
        end
    end

    if SCB.SV.StealthStateTarget and unitTag == "reticleover" then
        if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED) and IsUnitPlayer("reticleover") then
            g_effectsList.reticleover1[ A.Innate_Hidden ] =
            {
                type=1,
                name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        
        elseif ( stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) and IsUnitPlayer("reticleover") then
            g_effectsList.reticleover1[ A.Innate_Hidden ] =
            {
                type=1,
                name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_invisible.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        else
            g_effectsList.reticleover1[ A.Innate_Hidden ] = nil
        end
    end

end

function SCB.DisguiseStateChanged( eventCode , unitTag , disguiseState )
    if SCB.SV.DisguiseStatePlayer and unitTag == "player" then
        if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
            -- Trigger a buff
            g_effectsList.player1[ A.Innate_Disguised ] =
            {
                type=1,
                name=A.Innate_Disguised, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }

        -- Else remove buff
        else
            g_effectsList.player1[ A.Innate_Disguised ] = nil
        end
    end

    if SCB.SV.DisguiseStatePlayer and unitTag == "reticleover" then
        if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
            -- Trigger a buff
            g_effectsList.reticleover1[ A.Innate_Disguised ] =
            {
                type=1,
                name=A.Innate_Disguised, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        -- Else remove buff
        else
            g_effectsList.reticleover1[ A.Innate_Disguised ] = nil
        end
    end

end

function SCB.OnPlayerActivated(eventCode)
    -- Write current Action Bar and quick slot state
    SCB.OnSlotsFullUpdate(eventCode)

    g_playerActive = true
    g_playerResurectStage = nil

    if not SCB.SV.IgnoreMount and IsMounted() then 
        zo_callLater(function() SCB.MountStatus(eventCode, true) end , 50)
    end
    if not SCB.SV.IgnoreDisguise then 
        zo_callLater(SCB.InitializeDisguise, 50)
    end

    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET) > 0
    or GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT) > 0 then
		zo_callLater(function() SCB.CollectibleBuff( eventCode, 0, true) end, 50)
    end

    SCB.ReloadEffects( "player" )
    
    local duelState, characterName = GetDuelInfo()
    if duelState == 3 and not SCB.SV.IgnoreBattleSpiritTarget then
        g_currentDuelTarget = strformat(SI_UNIT_NAME, characterName)
        SCB.ReloadEffects("reticleover")
    end
    
    if IsInAvAZone() and not SCB.SV.IgnoreBattleSpiritPlayer then
        g_effectsList.player1[ "Battle Spirit" ] =
            {
            target ="player", type=1,
            name="Battle Spirit", icon = "esoui/art/icons/artificialeffect_battle-spirit.dds",
            dur=0, starts=1, ends=nil,
            forced = "long",
            restart=true, iconNum=0
            }
    end

    if SCB.SV.DisguiseStatePlayer then
        local disguiseState = GetUnitDisguiseState ("player")
        if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
            -- Trigger a buff
            g_effectsList.player1[ A.Innate_Disguised ] =
            {
                type=1,
                name=A.Innate_Disguised, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        -- Else remove buff
        else
            g_effectsList.player1[ A.Innate_Disguised ] = nil
        end
    end

    if SCB.SV.StealthStatePlayer then
        local stealthState = GetUnitStealthState ("player")
        if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED) then
            g_effectsList.player1[ A.Innate_Hidden ] =
            {
                type=1,
                name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        
        elseif ( stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) then
            g_effectsList.player1[ A.Innate_Hidden ] =
            {
                type=1,
                name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_invisible.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        else
            g_effectsList.player1[ A.Innate_Hidden ] = nil
        end
    end
    
    -- Checks for Artificial effects on the player just in case they have no buffs/debuffs present to trigger OnEffectUpdate
    SCB.ArtificialEffectUpdate()

    -- Sets the player to dead if reloading UI or loading in while dead.
    if IsUnitDead("player") then
        g_playerDead = true
    end

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
    if not g_playerActive or not g_playerDead then
        return
    end

    g_playerDead = false

    -- This is a good place to reload player buffs, as they were wiped on death
    SCB.ReloadEffects( "player" )

    -- now let start sequence to determine how the player become alive
    g_playerResurectStage = 1
    --[[If it was self resurrection, then there will be 4 EVENT_VIBRATION:
    First - 600ms, second - 0ms to switch first one off
    Third - 350ms, fourth - 0ms to switch third one off.
    So now we'll listen in the vibration event and progress g_playerResurectStage with first 2 events.
    And then on correct third event we'll create a buff. --]]
end

function SCB.OnPlayerDead(eventCode)
    if not g_playerActive then
        return
    end
    g_playerDead = true
end

function SCB.OnVibration(eventCode, duration, coarseMotor, fineMotor, leftTriggerMotor, rightTriggerMotor)
    if not g_playerResurectStage then
        return
    end
    if g_playerResurectStage == 1 and duration == 600 then
        g_playerResurectStage = 2
    elseif g_playerResurectStage == 2 and duration == 0 then
        g_playerResurectStage = 3
    elseif g_playerResurectStage == 3 and duration == 350 and SCB.SV.ShowResurrectionImmunity then
        -- We got correct sequence, so let us create a buff and reset the g_playerResurectStage
        g_playerResurectStage = nil
        SCB.NewEffects( {
            id = 999999,
            name = A.Innate_Resurrection_Immunity,
            icon = 'LuiExtended/media/icons/abilities/ability_innate_resurrection_immunity.dds',
            effects = {10000, 0, 0, 0}
        } )
    else
        -- This event does not seem to have anything to do with player self-resurrection
        g_playerResurectStage = nil
    end
end

function SCB.UpdateContextHideList()

    hidePlayerEffects = { }
    hideTargetEffects = { }

    if SCB.SV.IgnoreMundusPlayer then
        for k, v in pairs(E.IsBoon) do
            hidePlayerEffects[k] = v
        end
    end

    if SCB.SV.IgnoreMundusTarget then
        for k, v in pairs(E.IsBoon) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreVampPlayer then
        for k, v in pairs(E.IsVamp) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreVampTarget then
        for k, v in pairs(E.IsVamp) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreLycanPlayer then
        for k, v in pairs(E.IsLycan) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreLycanTarget then
        for k, v in pairs(E.IsLycan) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreDiseasePlayer then
        for k, v in pairs(E.IsVampLycanDisease) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreDiseaseTarget then
        for k, v in pairs(E.IsVampLycanDisease) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreBitePlayer then
        for k, v in pairs(E.IsVampLycanBite) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreBiteTarget then
        for k, v in pairs(E.IsVampLycanBite) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreCyrodiilPlayer then
        for k, v in pairs(E.IsCyrodiil) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreCyrodiilTarget then
        for k, v in pairs(E.IsCyrodiil) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreEsoPlusPlayer then
        hidePlayerEffects[63601] = true
    end
    if SCB.SV.IgnoreEsoPlusTarget then
        hideTargetEffects[63601] = true
    end
    if SCB.SV.IgnoreSoulSummonsPlayer then
        for k, v in pairs(E.IsSoulSummons) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreSoulSummonsTarget then
        for k, v in pairs(E.IsSoulSummons) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreSetICDPlayer then
        for k, v in pairs(E.IsSetICD) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreSetICDTarget then
        for k, v in pairs(E.IsSetICD) do
            hideTargetEffects[k] = v
        end
    end
	
	if SCB.SV.IgnoreFoodPlayer then
		for k, v in pairs(E.IsFoodBuff) do
			hidePlayerEffects[k] = v
		end
	end
	if SCB.SV.IgnoreFoodTarget then
		for k, v in pairs(E.IsFoodBuff) do
			hideTargetEffects[k] = v
		end
	end
	
	if SCB.SV.IgnoreExperiencePlayer then
		for k, v in pairs(E.IsExperienceBuff) do
			hidePlayerEffects[k] = v
		end
	end
	if SCB.SV.IgnoreExperienceTarget then
		for k, v in pairs(E.IsExperienceBuff) do
			hideTargetEffects[k] = v
		end
	end

    -- TODO:
    -- Add block here
    -- Add food here?
    -- if SCB.SV.ShowBlockPlayer then -- Currently we use ability_type to hide/show this, maybe add here later when I can determine NPC block abilities
    -- if SCB.SV.ShowBlockTarget then

end
