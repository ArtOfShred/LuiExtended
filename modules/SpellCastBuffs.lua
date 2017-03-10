------------------
-- Local namespace
LUIE.SpellCastBuffs = {}

-- Performance Enhancement
local SCB       = LUIE.SpellCastBuffs
local CI        = LUIE.CombatInfo
local UI        = LUIE.UI
local E         = LUIE.Effects
local A         = LUIE.GetAbility()
local strfmt    = string.format
local strformat = zo_strformat
local strfind   = zo_plainstrfind
local pairs     = pairs -- What does this do?

local moduleName = LUIE.name .. "_SpellCastBuffs"

local testEffectPrefix = "testEffect:"
local testEffectList   = { 22, 44, 55, 1800000 }

local playerName = strformat(SI_UNIT_NAME, GetUnitName("player"))

local windowTitles = {
    playerb     = "Player Buffs",
    playerd     = "Player Debuffs",
    player1     = "Player Buffs",
    player2     = "Player Debuffs",
    player_long = "Player Long Term Effects", -- "E"
    targetb     = "Target Buffs",
    targetd     = "Target Debuffs",
    target1     = "Target Buffs",
    target2     = "Target Debuffs",
}

SCB.Enabled = false
SCB.D = {
    IconSize                         = 40,
    BuffFontFace                     = "Fontin Regular",
    BuffFontStyle                    = "outline",
    BuffFontSize                     = 16,
    Alignment                        = "Centered",
    AlignmentVert                    = "Top",
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
    IgnoreVampLycanPlayer            = false,
    IgnoreVampLycanTarget            = false,
    IgnoreCyrodiilPlayer             = false,
    IgnoreCyrodiilTarget             = false,
    IgnoreBattleSpiritPlayer         = false,
    IgnoreBattleSpiritTarget         = false,
    IgnoreEsoPlusPlayer              = true,
    IgnoreEsoPlusTarget              = true,
    IgnoreDisguise                   = false,
    IgnoreCostume                    = false,
    IgnoreHat                        = false,
    IgnoreSkin                       = false,
    IgnorePolymorph                  = false,
    IgnoreAssistant                  = false,
    IgnorePet                        = false,
    IgnoreMount                      = false,
    LongTermEffectsSeparate          = true,
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
    HideTargetBuffs                  = false,
    HideTargetDebuffs                = false,
    HideGroundEffects                = false,
    ShowTriggered                    = true,
    ShowToggled                      = true,
}
SCB.SV = nil

local uiTlw                  = {} -- GUI
local containerRouting       = {}

-- Abilities and buffs
local g_uiProcAnimation      = {}
local g_uiCustomToggle       = {}
local g_actionBar            = {}
local g_triggeredSlots       = {}
local g_toggledSlots         = {}

local g_lastCast             = 0
local g_lastTarget           = nil
local g_effectsList          = { player1 = {}, player2 = {}, reticleover1 = {}, reticleover2 = {}, ground = {} }
local g_pendingGroundAbility = nil

-- Potions
local g_quickslotAbility    = nil
local g_quickslotLastSame   = false
local g_quickslotLastUsable = false

-- Self resurrection tracking
local g_playerActive = false
local g_playerDead   = false
local g_playerResurectStage = nil

-- Fast travel from any place in world
local g_recallEffectName   = "Recall Cooldown"
local g_recallIconFilename = "LuiExtended/media/icons/abilities/ability_innate_recall_cooldown.dds"

-- Font to be used on icons
-- "ZoFontWindowSubtitle" or ours:
--local g_buffsFont = "/LuiExtended/media/fonts/fontin_sans_r.otf|16|outline"
--local g_buffsFont = "$(MEDIUM_FONT)|17|outline"
local g_buffsFont

-- Padding distance between icons
local g_padding = 0

local g_horizAlign = CENTER
local v_horizAlign = MIDDLE
local g_horizSortInvert = false

-- Some optimization
local strHidden     = A.Effect_Hidden
local strDisguise   = "Disguised"
local strMounted    = "Mounted"
local iconMounted   = "LuiExtended/media/icons/mounts/mount_palomino_horse.dds"

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
    [A.Skill_Volley]                = { false, false, true, 2 },
    [A.Skill_Scorched_Earth]        = { false, false, true, 2 },
    [A.Skill_Arrow_Barrage]         = { false, false, true, 2 },

    -- Destro Staff
    [A.Skill_Wall_of_Fire]            = { false, false, 6.4, nil },
    [A.Skill_Wall_Of_Storms]          = { false, false, 6.4, nil },
    [A.Skill_Wall_of_Frost]           = { false, false, 6.4, nil },
    [A.Skill_Unstable_Wall_of_Fire]   = { false, false, 6.4, nil },
    [A.Skill_Unstable_Wall_of_Frost]  = { false, false, 6.4, nil },
    [A.Skill_Unstable_Wall_of_Storms] = { false, false, 6.4, nil }, -- Tested these values manually to make them as close to accurate as possible
    [A.Skill_Blockade_of_Fire]        = { false, false, 8.3, nil },
    [A.Skill_Blockade_of_Frost]       = { false, false, 8.3, nil },
    [A.Skill_Blockade_of_Storms]      = { false, false, 8.3, nil },

    -- Resto Staff
    [A.Skill_Grand_Healing]         = { true, false, false, nil },
    [A.Skill_Healing_Springs]       = { true, false, false, nil }, -- Possibly Hide later, hard to account for cast time, only cast time is the animation which can be anim cancelled
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

    -- Ardent Flame
    [A.Skill_Dragonknight_Standard] = { false, false, true, nil },
    [A.Skill_Shifting_Standard]     = { false, false, true, nil }, -- This is the new standard effect fired when moving Shifting Standard
    [A.Skill_Shift_Standard]        = { false, false, true, nil }, -- Would be better to add these as a fake aura later - Standard doesn't go away when you cast shifting
    [A.Skill_Standard_of_Might]     = { true, false, true, nil }, -- Also if mob dies before banner ends, the banner stops but icon persists

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
    [A.Skill_Nova]                          = { false, false, 11.3, 1.1 },
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
    -- GUILDS
    -----------------------------------

    -- Fighter Guild
    --[A.Skill_Trap_Beast]          = { 0, 28.8, 3.5, false }, -- FIXME: check duration on r4, add other 2 skills
    [A.Skill_Circle_of_Protection]  = { true, false, false, nil },
    [A.Skill_Turn_Undead]           = { true, false, false, nil },
    [A.Skill_Ring_of_Preservation]  = { true, false, false, nil },

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

local IsAbilityProc = {
    [A.Trigger_Assassins_Will]      = true,
    [A.Trigger_Assassins_Scourge]   = true,
    [A.Trigger_Power_Lash]          = true,
}

local HasAbilityProc = {
    [A.Skill_Crystal_Fragments]     = A.Trigger_Crystal_Fragments_Proc, -- Trigger_Crystal_Fragments_Passive
}

local IsAbilityCustomToggle = {
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
    [A.Skill_Spiked_Armor]          = true,
    [A.Skill_Volatile_Armor]        = true,
    [A.Skill_Hardened_Armor]        = true, -- Cut short by short duration shield effect
    --[A.Skill_Dragon_Blood]            = true,
    --[A.Skill_Green_Dragon_Blood]      = true,     -- Doesn't work, no ability to go along with cast, only Major/Minor effects
    --[A.Skill_Coagulating_Blood]       = true,
    [A.Skill_Reflective_Scale]      = true,
    [A.Skill_Reflective_Plate]      = true,
    [A.Skill_Dragon_Fire_Scale]     = true,

    --Dragonknight Skills (Earthen Heart)
    [A.Skill_Molten_Weapons]           = true,
    [A.Skill_Igneous_Weapons]          = true,
    [A.Skill_Molten_Armaments]         = true,
    [A.DamageShield_Obsidian_Shield]   = true,
    [A.DamageShield_Fragmented_Shield] = true,
    [A.DamageShield_Igneous_Shield]    = true,

    --Templar Skills (Aedric Spear)
    [A.DamageShield_Sun_Shield]     = true, -- These seem to fade on dodge roll, unlike other shields, I have no idea why
    [A.DamageShield_Radiant_Ward]   = true, -- These seem to fade on dodge roll, unlike other shields, I have no idea why
    [A.DamageShield_Blazing_Shield] = true, -- These seem to fade on dodge roll, unlike other shields, I have no idea why

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
    --[A.Skill_Grand_Healing]          = true, -- Doesn't work, no effect related to it
    --[A.Skill_Healing_Springs]        = true, -- Doesn't work, no effect related to it
    --[A.Skill_Illustrious_Healing]    = true, -- Doesn't work, no effect related to it
    [A.Skill_Regeneration]           = true,
    [A.Skill_Mutagen]                = true,
    [A.Skill_Rapid_Regeneration]     = true,
    -- Blessing of Protection + Morphs (not sure how to fix this, base effect is short duration)
    [A.DamageShield_Steadfast_Ward]  = true,
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

--[[----------------------------------------------------------
    CORRECTION TO BUFFS
    * By default some API provided buffType values seems incorrect, that is,
    * when the effect sounds like "debuff" it is still listed as "buff".
    * This table is used to correct such items
--]]----------------------------------------------------------

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
            -- Thus we do not create containers for player and target buffs on custom frames
            if v ~= "player1" and v ~= "target1" then
                uiTlw[v].iconHolder = UI.Control( uiTlw[v], nil, nil, false )
            end
            -- Create table to store created contols for icons
            uiTlw[v].icons = {}

            -- Add this top level window to global controls list, so it can be hidden
            -- We need to do it only when we control TopLevelWindows ourselves
            if uiTlw[v]:GetType() == CT_TOPLEVELCONTROL then
                LUIE.components[ moduleName .. v ] = uiTlw[v]
            end
        end
    end

    SCB.Reset()

    -- Register events
    EVENT_MANAGER:RegisterForUpdate(moduleName, 100, SCB.OnUpdate )

    -- Target Events
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TARGET_CHANGE,             SCB.OnTargetChange )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RETICLE_TARGET_CHANGED,    SCB.OnReticleTargetChanged )

    -- Buff Events
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

    EVENT_MANAGER:RegisterForEvent(moduleName .. "player",          EVENT_STEALTH_STATE_CHANGED, SCB.StealthStateChanged )
    EVENT_MANAGER:RegisterForEvent(moduleName .. "reticleover",     EVENT_STEALTH_STATE_CHANGED, SCB.StealthStateChanged )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "player",         EVENT_STEALTH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "reticleover",    EVENT_STEALTH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "reticleover" )
    
    EVENT_MANAGER:RegisterForEvent(moduleName,          EVENT_DISGUISE_STATE_CHANGED, SCB.DisguiseStateChanged )
    
    --[[
    EVENT_MANAGER:RegisterForEvent(moduleName .. "player",          EVENT_DISGUISE_STATE_CHANGED, SCB.DisguiseStateChanged )
    EVENT_MANAGER:RegisterForEvent(moduleName .. "reticleover",     EVENT_DISGUISE_STATE_CHANGED, SCB.DiguiseStateChanged )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "player",         EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "reticleover",    EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "reticleover" )
    ]]--

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
    
end

function SCB.InitializeDisguise()
    g_effectsList.player1["DisguiseType"] = nil
    if g_currentDisguise ~= 0 and not SCB.SV.IgnoreDisguise then
    
        -- Hide from display if we have a costume or polymorph and the disguise is a guild tabard
        if g_currentDisguise == 55262 and (GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH) > 0 or GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_COSTUME) > 0) then
            return
        end
        
        local name = E.DisguiseIcons[g_currentDisguise].name
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

function SCB.DisguiseItem(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if slotId == 10 then
        g_effectsList.player1["DisguiseType"] = nil
        g_currentDisguise = GetItemId(0, 10) or 0
        SCB.CollectibleBuff()
        if g_currentDisguise == 0 then
            return
        elseif g_currentDisguise ~= 0 and not SCB.SV.IgnoreDisguise then
        
            -- Hide from display if we have a costume or polymorph and the disguise is a guild tabard
            if g_currentDisguise == 55262 and (GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH) > 0 or GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_COSTUME) > 0) then
                return
            end
        
            local name = E.DisguiseIcons[g_currentDisguise].name
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
        local mountType = GetMountSkinId()
        --d("Skin ID = " .. mountType)
        
        strMounted = E.MountIcons[mountType] ~= nil and E.MountIcons[mountType].name or "Mounted"
        iconMounted = E.MountIcons[mountType] ~= nil and E.MountIcons[mountType].icon or "LuiExtended/media/icons/mounts/mount_palomino_horse.dds"
        g_effectsList.player1["Mount"] = 
            {
                target="player", type=1,
                name=strMounted, icon=iconMounted,
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "long",
                restart=true, iconNum=0
            }
    end
end

function SCB.CollectibleUsed(eventCode, result, isAttemptingActivation)
    local latency = GetLatency()
    latency = latency + 50
    zo_callLater (SCB.CollectibleBuff, latency)
    
end

function SCB.CollectibleBuff()
    -- PETS
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET) > 0 and not SCB.SV.IgnorePet then
        local Collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET)
        local CollectibleName = GetCollectibleName(Collectible)
        
        local strPet = CollectibleName
        local iconPet = E.PetIcons[CollectibleName] ~= nil and E.PetIcons[CollectibleName] or "LuiExtended/media/icons/pets/pet_pet_bravil_retriever.dds"
        
            g_effectsList.player1["PetType"] = 
                {
                        target="player", type=1,
                        name=strPet, icon=iconPet,
                        dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                        forced = "long",
                        restart=true, iconNum=0
                }
    else
        g_effectsList.player1["PetType"] = nil
    end
    
    -- ASSISTANTS
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT) > 0 and not SCB.SV.IgnoreAssistant then
        local Collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT)
        local CollectibleName = GetCollectibleName(Collectible)
        
        local strAssistant = CollectibleName
        local iconAssistant = E.AssistantIcons[CollectibleName] ~= nil and E.AssistantIcons[CollectibleName] or "LuiExtended/media/icons/skins/skin_generic.dds"
       
            g_effectsList.player1["AssistantType"] = 
                {
                        target="player", type=1,
                        name=strAssistant, icon=iconAssistant,
                        dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                        forced = "long",
                        restart=true, iconNum=0
                }
    else
        g_effectsList.player1["AssistantSkinType"] = nil
    end
    
    -- Check here to see if we have a disguise - hides polymorph or costume.
    local DisguiseOn = GetItemId(0, 10) or 0
    SCB.InitializeDisguise() -- Reload disguise setup
    if DisguiseOn ~= 0 and DisguiseOn ~= 55262 then
        g_effectsList.player1["PolymorphType"] = nil
        g_effectsList.player1["CostumeType"] = nil
        g_effectsList.player1["HatType"] = nil
        g_effectsList.player1["SkinType"] = nil
    end
    
    -- POLYMORPH
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH) > 0 and not SCB.SV.IgnorePolymorph then
        local Collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH)
        local CollectibleName = GetCollectibleName(Collectible)
        
        local strPolymorph = CollectibleName
        local iconPolymorph = E.PolymorphIcons[CollectibleName] ~= nil and E.PolymorphIcons[CollectibleName] or "LuiExtended/media/icons/costumes/costume_generic.dds"
            if DisguiseOn == 0 or DisguiseOn == 55262 then
                g_effectsList.player1["PolymorphType"] = 
                    {
                            target="player", type=1,
                            name=strPolymorph, icon=iconPolymorph,
                            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                            forced = "long",
                            restart=true, iconNum=0
                    }
            end
            g_effectsList.player1["CostumeType"] = nil
            g_effectsList.player1["HatType"] = nil
            g_effectsList.player1["SkinType"] = nil
    else
        g_effectsList.player1["PolymorphType"] = nil
    end
    
    -- COSTUMES
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_COSTUME) > 0 and not SCB.SV.IgnoreCostume then
        local Collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_COSTUME)
        local CollectibleName = GetCollectibleName(Collectible)
        
        local strCostume = CollectibleName
        local iconCostume = E.CostumeIcons[CollectibleName] ~= nil and E.CostumeIcons[CollectibleName] or "LuiExtended/media/icons/costumes/costume_generic.dds"
            if (DisguiseOn == 0 or DisguiseOn == 55262) and GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH) == 0 then
                g_effectsList.player1["CostumeType"] = 
                    {
                            target="player", type=1,
                            name=strCostume, icon=iconCostume,
                            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                            forced = "long",
                            restart=true, iconNum=0
                    }
            end
    else
        g_effectsList.player1["CostumeType"] = nil
    end
    
    -- HATS
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_HAT) > 0 and not SCB.SV.IgnoreHat then
        local Collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_HAT)
        local CollectibleName = GetCollectibleName(Collectible)
        
        local strHat = CollectibleName
        local iconHat = E.HatIcons[CollectibleName] ~= nil and E.HatIcons[CollectibleName] or "LuiExtended/media/icons/costumes/costume_generic.dds"
            if (DisguiseOn == 0 or DisguiseOn == 55262) and GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH) == 0 then
                g_effectsList.player1["HatType"] = 
                    {
                            target="player", type=1,
                            name=strHat, icon=iconHat,
                            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                            forced = "long",
                            restart=true, iconNum=0
                    }
            end
    else
        g_effectsList.player1["HatType"] = nil
    end
    
    -- SKINS
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_SKIN) > 0 and not SCB.SV.IgnoreSkin then
        local Collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_SKIN)
        local CollectibleName = GetCollectibleName(Collectible)
        
        local strSkin = CollectibleName
        local iconSkin = E.SkinIcons[CollectibleName] ~= nil and E.SkinIcons[CollectibleName] or "LuiExtended/media/icons/skins/skin_generic.dds"
            if (DisguiseOn == 0 or DisguiseOn == 55262) and GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH) == 0 then
                g_effectsList.player1["SkinType"] = 
                    {
                            target="player", type=1,
                            name=strSkin, icon=iconSkin,
                            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                            forced = "long",
                            restart=true, iconNum=0
                    }
            end
    else
        g_effectsList.player1["SkinType"] = nil
    end
    
end

        
--[[
 * Sets horizontal alignment of icon. Called from Settings Menu.
 * This is done simply by setting of iconHolder anchor.
 ]]--
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
                uiTlw[v].iconHolder:SetAnchor( BOTTOM )
            else
                uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
            end
        end
    end
end

function SCB.SetIconsAlignmentVert( value )
    -- Check correctness of argument value
    if value ~= "Top" and value ~= "Middle" and value ~= "Bottom" then
        value = SCB.D.AlignmentVert
    end
    SCB.SV.AlignmentVert = value

    if not SCB.Enabled then
        return
    end

    g_vertAlign = ( value == "Top" ) and TOP or ( value == "Bottom" ) and BOTTOM or MIDDLE

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
            SCB.CreatePreviewIcon( testEffectList[i] )
        else
            local effectName = testEffectPrefix .. testEffectList[i]
            g_effectsList.player1[effectName] = nil
            g_effectsList.player2[effectName] = nil
            g_effectsList.ground[effectName] = nil
        end
    end
end

-- Create preview icon for buff or debuff.
function SCB.CreatePreviewIcon( duration )
    SCB.NewEffects( {
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

        uiTlw.player1:SetHeight( SCB.SV.IconSize * 2)
        uiTlw.player1.firstAnchor = { TOPLEFT, TOP }
        uiTlw.player1.maxIcons = math.floor(  (uiTlw.player1:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )
    end

    -- Target
    if uiTlw.targetb and uiTlw.targetb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.targetb:SetDimensions( 500, SCB.SV.IconSize + 6 )
        uiTlw.targetd:SetDimensions( 500, SCB.SV.IconSize + 6 )
    else
        uiTlw.target2:SetHeight( SCB.SV.IconSize )

        uiTlw.target1:SetHeight( SCB.SV.IconSize * 2)
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
    SCB.SetIconsAlignmentVert( SCB.SV.AlignmentVert )
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
    buff.label:SetHidden( not SCB.SV.RemainingText )
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
    buff.label:SetAnchor(TOPLEFT, buff, LEFT, -g_padding)
    buff.label:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT, g_padding, -2)
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
function SCB.SetSingleIconBuffType(buff, buffType)
    local contextType
    local colour
    if buffType == 1 then
        contextType = "buff"
        colour = {0,1,0,1}
    else
        contextType = "debuff"
        colour = {1,0,0,1}
    end
    -- {0.07, 0.45, 0.8}

    buff.frame:SetTexture("/esoui/art/actionbar/" .. contextType .. "_frame.dds")
    buff.label:SetColor( unpack( SCB.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
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
        CHAT_SYSTEM:AddMessage("LUIE_SpellCastBuffs: There was a problem with selecting required font. Falling back to game default.")
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

-- Runs on the EVENT_ACTION_UPDATE_COOLDOWNS listener.
-- This handler fires every time the player uses an active ability.
function SCB.OnUpdateCooldowns()
    -- Maybe process a ground-target spell
    if ( g_pendingGroundAbility ~= nil ) then
        -- Cast ability
        if not SCB.SV.HideGroundEffects then
            SCB.NewEffects( g_pendingGroundAbility )
        end
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
function SCB.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)

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

    -- If the source of the buff isn't the player or the buff is not on the AbilityId or AbilityName override list then we don't display it
    if unitTag ~= "player" then
        if effectType == 2 and not (castByPlayer == 1 or castByPlayer == 2) and not (E.DebuffDisplayOverrideId[abilityId] or E.DebuffDisplayOverrideName[effectName]) then
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

    -- Ignore some buffs (by abilityId or by effectName)
    if E.IsEffectIgnored[ effectName ] or E.IsAbilityIgnoredById[abilityId] or
        ( SCB.SV.IgnoreMundusPlayer and E.IsBoon[ effectName ] and unitTag == "player" ) or
        ( SCB.SV.IgnoreMundusTarget and E.IsBoon[ effectName ] and unitTag == "reticleover"  ) or
        ( SCB.SV.IgnoreVampLycanPlayer and E.IsVampLycan[ effectName ] and unitTag == "player" ) or
        ( SCB.SV.IgnoreVampLycanTarget and E.IsVampLycan[ effectName ] and unitTag == "reticleover"  ) or
        ( SCB.SV.IgnoreCyrodiilPlayer and E.IsCyrodiil[abilityId] and unitTag == "player" ) or
        ( SCB.SV.IgnoreCyrodiilTarget and E.IsCyrodiil[abilityId] and unitTag == "reticleover"  ) or
        ( SCB.SV.IgnoreBattleSpiritPlayer and E.IsBattleSpirit[abilityId] and unitTag == "player" ) or
        ( SCB.SV.IgnoreBattleSpiritTarget and E.IsBattleSpirit[abilityId] and unitTag == "reticleover"  ) or
        ( SCB.SV.IgnoreEsoPlusPlayer and E.IsEsoPlus[abilityId] and unitTag == "player" ) or -- Hide ESO Plus Member buff on the player frame if the option is turned on
        ( SCB.SV.IgnoreEsoPlusTarget and E.IsEsoPlus[abilityId] and unitTag == "reticleover" ) -- Hide ESO Plus Member buff on the player frame if the option is turned on
    then return end

    -- Override some buff info
    if E.EffectTypeOverride[abilityId] then
        effectType = E.EffectTypeOverride[abilityId]
    end

    -- Allows us to overwrite Ability Icons in one of two ways, by specific abilityId or by effectName
    iconName = E.EffectIconOverride[abilityId] or E.AbilityIcon[effectName or ""] or iconName

    -- Allows us to overwrite Ability Names (Note that using this may break certain hidden icon functionality, should only be used when neccesary. Use base ability ID only for other modifications)
    effectName = E.EffectNameOverride[abilityId] or effectName

    local forcedType = E.EffectForcedType[abilityId] or E.EffectForcedName[effectName]

    -- Where the new icon will go into
    local context = unitTag .. effectType

    -- Exit here if there is no container to hold this effect
    if not containerRouting[context] then
        return
    end

    if changeType == EFFECT_RESULT_FADED then -- delete Effect
        g_effectsList[context][abilityId] = nil

        -- Also delete visual enhancements from skill bar
        if unitTag == "player" then
            -- Stop any proc animation associated with this effect
            if abilityType == ABILITY_TYPE_BONUS and g_triggeredSlots[effectName] and g_uiProcAnimation[g_triggeredSlots[effectName]] then
                g_uiProcAnimation[g_triggeredSlots[effectName]]:Stop()
            end

            -- Switch off custom toggle highlight
            if g_toggledSlots[effectName] and g_uiCustomToggle[g_toggledSlots[effectName]] then
                g_uiCustomToggle[g_toggledSlots[effectName]]:SetHidden(true)
            end
        end

    -- Create Effect
    else
        local duration = endTime - beginTime

        --[[ Old Block Code
        if abilityType == ABILITY_TYPE_BLOCK then
            g_effectsList[context][ abilityId ] = {
                        target=unitTag, type=effectType,
                        id=abilityId, name=effectName, icon=iconName,
                        dur=0, starts=0, ends=nil, -- ends=nil : last buff in sorting
                        forced="short",
                        restart=true, iconNum=0 }
            -- clear groud pending ability
            g_pendingGroundAbility = nil
        ]]--

        -- Buffs are created based on their ability ID, this allows buffs with the same display name to show up.
        g_effectsList[context][ abilityId ] = {
                    target=unitTag, type=effectType,
                    id=abilityId, name=effectName, icon=iconName,
                    dur=1000*duration, starts=1000*beginTime, ends=(duration > 0) and (1000*endTime) or nil,
                    forced=forcedType,
                    restart=true, iconNum=0 }

        -- Also create visual enhancements from skill bar
        if unitTag == "player" then
            -- start any proc animation associated with this effect
            if abilityType == ABILITY_TYPE_BONUS and g_triggeredSlots[effectName] then
                if SCB.SV.ShowTriggered then
                    SCB.PlayProcAnimations(g_triggeredSlots[effectName])
                end
            end

            -- Switch on custom toggle highlight
            if g_toggledSlots[effectName] then
                if SCB.SV.ShowToggled then
                    SCB.ShowCustomToggle(g_toggledSlots[effectName])
                end
            end
        end
    end
end

-- List of all damage results for analysis in following function
 -- This also includes SHIELDED result that is not included in CI module
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

    -- Ignore error events
    if isError then
        return
    end

    -- Try to remove effect like Ground Runes and Traps
    if E.IsGroundMine[abilityName] and IsResultDamage[result]
        and ( targetType == COMBAT_UNIT_TYPE_NONE or targetType == COMBAT_UNIT_TYPE_OTHER)
        then
        g_effectsList.ground[ abilityName ] = nil
    end

    -- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on player by target)
    if E.FakeExternalBuffs[abilityId] ~= nil then
        iconName = E.FakeExternalBuffs[abilityId].icon
        effectName = E.FakeExternalBuffs[abilityId].name
        duration = E.FakeExternalBuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
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

    -- Creatures fake debuff icons for debuffs without an aura - These refresh on reapplication/removal (Applied on player by target)
    if E.FakeExternalDebuffs[abilityId] ~= nil then
        iconName = E.FakeExternalDebuffs[abilityId].icon
        effectName = E.FakeExternalDebuffs[abilityId].name
        duration = E.FakeExternalDebuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
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

    -- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on player by player OR applied on target by player)
    if E.FakePlayerBuffs[abilityId] ~= nil then

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
            g_effectsList.player1[ abilityId ] = {
            type=1,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        elseif source == playerName and target ~= playerName and target ~= nil then -- Can add an aura for buffs applied on target by player, can't be removed other than via timing out
            if SCB.SV.HideTargetBuffs then
                return
            end
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

    -- Creates fake debuff icons for debuffs without an aura - These refresh on reapplication/removal (Applied on target by player)
    if E.FakePlayerDebuffs[abilityId] ~= nil then
        iconName = E.FakePlayerDebuffs[abilityId].icon
        effectName = E.FakePlayerDebuffs[abilityId].name
        duration = E.FakePlayerDebuffs[abilityId].duration
        effectType = EFFECT_TYPE_DEBUFF
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        if source == playerName and target ~= nil then
            if SCB.SV.HideTargetDebuffs then
                return
            end
            g_effectsList.reticleover2[ abilityId ] = {
            type=effectType,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        end
    end

    -- Simulates fake debuff icons for stagger effects - works for both (target -> player) and (player -> target) - DOES NOT REFRESH - Only expiration condition is the timer
    if E.FakeStagger[abilityId] ~= nil then
        iconName = E.FakeStagger[abilityId].icon
        effectName = E.FakeStagger[abilityId].name
        duration = E.FakeStagger[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        if source ~= "" and target == playerName then
            g_effectsList.player2[ abilityId ] = {
            type=EFFECT_TYPE_DEBUFF,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0 }
        elseif source == playerName and target ~= nil then
            if SCB.SV.HideTargetDebuffs then
                return
            end
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
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
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

    -- And toggle buttons
    if unitTag == "player" then
        for slotNum = 3, 8 do
            if g_uiCustomToggle[slotNum] then
                g_uiCustomToggle[slotNum]:SetHidden(true)
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
        if effectType == 2 then
            -- Fudge this value to send to SCB.OnEffectChanged if this is a debuff
            if castByPlayer == true then
            castByPlayer = 1
            else
                castByPlayer = 5
            end
        end
        SCB.OnEffectChanged(0, 3, buffSlot, buffName, unitTag, timeStarted, timeEnding, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, unitName, 0--[[unitId]], abilityId, castByPlayer)
    end

    -- create custom buff icon for Recall Cooldown effect
    if SCB.SV.ShowRecall and unitTag == "player" then
        local recallRemain, _ = GetRecallCooldown()
        if recallRemain > 0 then
            local currentTime = GetGameTimeMilliseconds()
            g_effectsList["player1"][ g_recallEffectName ] = {
                        target="player", type=1,
                        name=g_recallEffectName, icon=g_recallIconFilename,
                        dur=recallRemain, starts=currentTime, ends=currentTime+recallRemain,
                        forced = "long",
                        restart=true, iconNum=0 }
        end
    end
    
    if unitTag == "reticleover" then
        if SCB.SV.StealthStateTarget then
            local stealthState = GetUnitStealthState ("reticleover")
            if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) then
                g_effectsList.reticleover1[ strHidden ] =
                {
                    type=1,
                    name=strHidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
                    dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                    forced = "short",
                    restart=true, iconNum=0
                }
            else
                g_effectsList.reticleover1[ strHidden ] = nil
            end
        end
        
        if SCB.SV.DisguiseStateTarget then
            --d("checking for disguise")
            local disguiseState = GetUnitDisguiseState ("reticleover")
            --d("Disguise State: " .. disguiseState )
            if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
                -- Trigger a buff
                g_effectsList.reticleover1[ strDisguise ] =
                {
                    type=1,
                    name=strDisguise, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
                    dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                    forced = "short",
                    restart=true, iconNum=0
                }
            -- Else remove buff
            else
                g_effectsList.reticleover1[ strDisguise ] = nil
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

-- Called from EVENT_ACTION_SLOT_ABILITY_USED listener
-- Check for whether a spell is being cast
function SCB.OnSlotAbilityUsed(eventCode, slotNum)
    -- Clear stored ground-target ability
    g_pendingGroundAbility = nil

    -- Get the used ability
    local ability = g_actionBar[slotNum]

    if ability then -- Only proceed if this button is being watched
        -- Get the time
        local currentTime = GetGameTimeMilliseconds()

        -- avoid failure and button mashing
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

    -- Remove saved triggered proc information
    for abilityName, slot in pairs(g_triggeredSlots) do
        if (slot == slotNum) then
            g_triggeredSlots[abilityName] = nil
        end
    end
    -- Stop possible proc animation
    if g_uiProcAnimation[slotNum] and g_uiProcAnimation[slotNum]:IsPlaying() then
        g_uiProcAnimation[slotNum]:Stop()
    end

    -- Remove custom toggle information and custom highlight
    for abilityName, slot in pairs(g_toggledSlots) do
        if (slot == slotNum) then
            g_toggledSlots[abilityName] = nil
        end
    end
    if g_uiCustomToggle[slotNum] then
        g_uiCustomToggle[slotNum]:SetHidden(true)
    end

    -- Bail out if slot is not used
    if not IsSlotUsed(slotNum) then
        g_actionBar[slotNum] = nil
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

    g_actionBar[slotNum] = {
        id      = ability_id,
        name    = abilityName,
        type    = mechanicType,
        cost    = abilityCost,
        icon    = GetSlotTexture(slotNum),
        ground  = ( GetAbilityTargetDescription(ability_id) == "Ground" ),
        effects = effects
    }

    -- Check if currently this ability is in proc state
    local proc = HasAbilityProc[abilityName]
    if IsAbilityProc[abilityName] then
        if SCB.SV.ShowTriggered then
            SCB.PlayProcAnimations(slotNum)
        end
    elseif proc then
        g_triggeredSlots[proc] = slotNum
        if g_effectsList.player1[proc] then
            if SCB.SV.ShowTriggered then
                SCB.PlayProcAnimations(slotNum)
            end
        end
    end

    -- Check if current skill is our custom toggle skill and save it
    if IsAbilityCustomToggle[abilityName] then
        g_toggledSlots[abilityName] = slotNum
        if g_effectsList.player1[ability_id] then
            if SCB.SV.ShowToggled then
                SCB.ShowCustomToggle(slotNum)
            end
        end
    end
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

-- Starts proc animation
function SCB.PlayProcAnimations(slotNum)
    if not g_uiProcAnimation[slotNum] then
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

        g_uiProcAnimation[slotNum] = procLoopTimeline
    end
    if g_uiProcAnimation[slotNum] then
        if not g_uiProcAnimation[slotNum]:IsPlaying() then
            g_uiProcAnimation[slotNum]:PlayFromStart()
        end
    end
end

-- Displays custom toggle texture
function SCB.ShowCustomToggle(slotNum)
    if not g_uiCustomToggle[slotNum] then
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

        g_uiCustomToggle[slotNum] = toggleTexture
    end
    if g_uiCustomToggle[slotNum] then
        g_uiCustomToggle[slotNum]:SetHidden(false)
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
                -- Switch off custom toggle highlight
                if g_toggledSlots[k] and g_uiCustomToggle[g_toggledSlots[k]] then
                    g_uiCustomToggle[g_toggledSlots[k]]:SetHidden(true)
                end

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
    if g_horizSortInvert and not uiTlw[container].alignVertical then
        istart, iend, istep = iconsNum, 1, -1
    else
        istart, iend, istep = 1, iconsNum, 1
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
                    row = row + 1
                    next_row_break = next_row_break + uiTlw[container].maxIcons
                end
            end
        end

        -- If previously this icon was used for different effect, then setup it again
        if effect.iconNum ~= index then
            effect.iconNum = index
            effect.restart = true
            SCB.SetSingleIconBuffType(buff, effect.type)
            buff.data.tooltipText = effect.name --.. " || " .. (effect.id or "?")
            buff.icon:SetTexture(effect.icon)
            buff:SetAlpha(1)
            buff:SetHidden(false)
            if not remain then
                buff.label:SetText( E.IsToggle[effect.name] and "T" or nil )
                -- buff.label:SetText( E.IsToggle[effect.name] and "T" or E.IsVampStage(effect) and ("Fuck" .. E.IsVampStage(effect)) or nil ) -- Deprecated
            end
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
                buff.label:SetText( strfmt(SCB.SV.RemainingTextMillis and "%.1f" or "%.2d", remain/1000) )
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

        -- Now possibly fade out expiring icon
        if SCB.SV.FadeOutIcons and remain ~= nil and remain < 2000 then
            --buff:SetAlpha( 0.05 + remain/2106 )
            buff:SetAlpha(E.easeOutQuad(remain, 0, 1, 2000))
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
        if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) then
            -- Trigger a buff
            g_effectsList.player1[ strHidden ] =
            {
                type=1,
                name=strHidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }

        -- Else remove buff
        else
            g_effectsList.player1[ strHidden ] = nil
        end
    end

    if SCB.SV.StealthStateTarget and unitTag == "reticleover" then
        if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) then
            -- Trigger a buff
            g_effectsList.reticleover1[ strHidden ] =
            {
                type=1,
                name=strHidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        -- Else remove buff
        else
            g_effectsList.reticleover1[ strHidden ] = nil
        end
    end
    
end

function SCB.DisguiseStateChanged( eventCode , unitTag , disguiseState )

    if SCB.SV.DisguiseStatePlayer and unitTag == "player" then
        if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
            -- Trigger a buff
            g_effectsList.player1[ strDisguise ] =
            {
                type=1,
                name=strDisguise, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }

        -- Else remove buff
        else
            g_effectsList.player1[ strDisguise ] = nil
        end
    end

    if SCB.SV.DisguiseStatePlayer and unitTag == "reticleover" then
        if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
            -- Trigger a buff
            g_effectsList.reticleover1[ strDisguise ] =
            {
                type=1,
                name=strDisguise, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        -- Else remove buff
        else
            g_effectsList.reticleover1[ strDisguise ] = nil
        end
    end
    
end

function SCB.OnPlayerActivated(eventCode)
    -- Write current Action Bar and quick slot state
    SCB.OnSlotsFullUpdate(eventCode)

    g_playerActive = true
    g_playerResurectStage = nil
    
    if not SCB.SV.IgnoreMount and IsMounted() then zo_callLater(function() SCB.MountStatus(eventCode, true) end , 50) end
    if not SCB.SV.IgnoreDisguise then zo_callLater(SCB.InitializeDisguise, 50) end

    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET) > 0
    or GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT) > 0
    or GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_POLYMORPH) > 0 
    or GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_SKIN) > 0
    or GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_COSTUME) > 0 then
		zo_callLater(function() SCB.CollectibleBuff( eventCode, 0, true) end, 50)
    end
    
    SCB.ReloadEffects( "player" )
    
    if SCB.SV.DisguiseStatePlayer then
        local disguiseState = GetUnitDisguiseState ("player")
        if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
            -- Trigger a buff
            g_effectsList.player1[ strDisguise ] =
            {
                type=1,
                name=strDisguise, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }
        -- Else remove buff
        else
            g_effectsList.player1[ strDisguise ] = nil
        end
    end
    
    if SCB.SV.StealthStatePlayer then
        local stealthState = GetUnitStealthState ("player")
        if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) then
            -- Trigger a buff
            g_effectsList.player1[ strHidden ] =
            {
                type=1,
                name=strHidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "short",
                restart=true, iconNum=0
            }

        -- Else remove buff
        else
            g_effectsList.player1[ strHidden ] = nil
        end
    end
    
    if isUnitDead("player") then g_playerDead = true end -- Sets the player to dead if reloading UI or loading in while dead.
    
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
            name = "Resurrection Immunity",
            icon = "LuiExtended/media/icons/abilities/ability_innate_resurrection_immunity.dds",
            effects = {10000, 0, 0, 0}
        } )
    else
        -- This event does not seem to have anything to do with player self-resurrection
        g_playerResurectStage = nil
    end
end
