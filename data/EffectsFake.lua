--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

local Effects = LUIE.Data.Effects

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR FAKE EFFECTS
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Adds this aura to a list of fake Ground auras to display when the player casts them
--------------------------------------------------------------------------------------------------------------------------------
Effects.EffectGroundDisplay =
{
    -- Required:
    -- buff, debuff, ground = true/false -- Choose whether this effect shows up in any of these containers
    -- Optional:
    --name = '' -- Add a custom name
    --icon = '' -- Add a custom icon
    --stackAdd = # -- How many stacks to add when this effect begins (used for Ground Mines)
    --stackRemove = # -- How many stacks to remove when this effect ends (used for Ground Mines)
    --stackReset = # -- Maximum stack counter (used for Ground Mines)
    --noRemove = true -- Do not end this aura on EFFECT_RESULT_FADED

    -- Cyrodiil
    [88714] = { icon = "LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds", name = Abilities.Skill_Meatbag_Catapult, buff = false, debuff = false, ground = true }, -- Meatbag (Meatbag Catapult)
    [104700] = { icon = "LuiExtended/media/icons/abilities/ability_spell_gtaoe_oil_snare.dds", name = Abilities.Skill_Oil_Catapult, buff = false, debuff = false, ground = true }, -- Twisting Path (Oil Catapult)
    [104690] = { icon = "LuiExtended/media/icons/abilities/ability_ava_siege_scattershot_catapult.dds", name = Abilities.Skill_Scattershot_Catapult, buff = false, debuff = false, ground = true }, -- Twisting Path (Scattershot Catapult)

    -- Monster Sets
    [59590] = { icon = "LuiExtended/media/icons/abilities/ability_set_bogdan.dds", name = Abilities.Set_Bogdan_the_Nightflame, buff = true, debuff = false, ground = false }, -- Imperial Prison Item Set (Bogdan the Nightflame)
    [97882] = { icon = "LuiExtended/media/icons/abilities/ability_set_domihaus_fire.dds", buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus)
    [97855] = { icon = "LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds", buff = true, debuff = false, ground = false }, -- Earthgore (Earthgore)
    [80527] = { icon = "LuiExtended/media/icons/abilities/ability_set_ilambris.dds", buff = false, debuff = false, ground = true }, -- Ilambris (Ilambris)
    [59587] = { icon = "LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds", name = Abilities.Set_Lord_Warden_Dusk, buff = true, debuff = false, ground = false }, -- Lord Warden (Lord Warden)
    [59568] = { icon = "LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds", name = Abilities.Set_Scourge_Harvester, buff = true, debuff = false, ground = false, tooltip = Tooltips.Set_Malubeth_Heal }, -- Scourge Harvest (Malubeth)
    [59508] = { icon = "LuiExtended/media/icons/abilities/ability_set_maw_of_the_infernal.dds", name = Abilities.Set_Maw_of_the_Infernal, buff = true, debuff = false, ground = false }, -- Banished Cells Item Set (Maw of the Infernal)
    [81036] = { icon = "LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds", buff = true, debuff = false, ground = false }, -- Sentinel of Rkugamz
    [80954] = { icon = "LuiExtended/media/icons/abilities/ability_summon_shadow_proxy.dds", name = Abilities.Set_Shadowrend, buff = true, debuff = false, ground = false }, -- Shadowrend Summon (Shadowrend)
    [59497] = { icon = "LuiExtended/media/icons/abilities/ability_innate_web_white.dds", buff = false, debuff = false, ground = true }, -- Spawn of Mephala (Spawn of Mephala)
    [80523] = { icon = "LuiExtended/media/icons/abilities/ability_stormatronach_enervating_stone.dds", buff = false, debuff = false, ground = true }, -- Stormfist (Stormfist)
    [102093] = { icon = "LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds", buff = false, debuff = false, ground = true }, -- Thurvokun
    [59594] = { icon = "LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds", name = Abilities.Set_Nerieneth, buff = false, debuff = false, ground = true }, -- Crypt of Hearts Item Set (Nerien'eth)
    [80545] = { icon = "LuiExtended/media/icons/abilities/ability_set_sellistrix.dds", buff = false, debuff = false, ground = true }, -- Sellistrix (Sellistrix)
    --[102136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_zaan.dds', buff = true, debuff = false, ground = false }, -- Zaan -- Buff icon for Zaan, may reimplement if I add a way to override tooltips for these.

    -- Crafted Sets
    [75930] = { icon = "LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds", name = Abilities.Set_Eternal_Hunt, buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 7 }, -- Daedric Mines (Eternal Hunt)
    [71671] = { icon = "LuiExtended/media/icons/abilities/ability_set_morkuldin_summon.dds", buff = true, debuff = false, ground = false }, -- Morkuldin (Morkuldin)
    [113181] = { icon = "esoui/art/icons/mm_teaser.dds", buff = true, debuff = false, ground = false }, -- Grave-Stake Collector (Grave-Stake Collector)
    [121915] = { icon = "LuiExtended/media/icons/abilities/ability_set_honors_scorn.dds", name = Abilities.Set_Honors_Scorn, buff = false, debuff = false, ground = true }, -- Coldharbour's Favorite (Coldharbour's Favorite)
    [121912] = { icon = "LuiExtended/media/icons/abilities/ability_set_honors_love.dds", name = Abilities.Set_Honors_Love, buff = true, debuff = false, ground = false }, -- Coldharbour's Favorite (Coldharbour's Favorite)

    -- Overland Sets
    [75691] = { icon = "LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds", buff = false, debuff = false, ground = true }, -- Bahraha's Curse
    [71664] = { icon = "LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds", buff = false, debuff = false, ground = true }, -- Trinimac's Valor
    [135659] = { icon = "LuiExtended/media/icons/abilities/ability_set_winters_respite.dds", buff = true, debuff = false, ground = false }, -- Winter's Respite (of Winter's Respite)
    -- Dungeon Sets
    [97538] = { icon = "LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds", buff = true, debuff = false, ground = false }, -- Draugr's Rest
    [102106] = { icon = "esoui/art/icons/achievement_bossflavoreasy.dds", name = Abilities.Set_Plague_Slinger, buff = false, debuff = false, ground = true }, -- Skeever Corpse
    [97908] = { icon = "LuiExtended/media/icons/abilities/ability_set_hagravens_garden.dds", buff = true, debuff = false, ground = false }, -- Hagraven's Garden (Hagraven's)
    [67205] = { icon = "LuiExtended/media/icons/abilities/ability_set_leeching_plate.dds", buff = false, debuff = false, ground = true }, -- Leeching Plate (of Leeching)
    [84354] = { icon = "LuiExtended/media/icons/abilities/ability_innate_web_green.dds", buff = false, debuff = false, ground = true }, -- Hand of Mephala (of Mephala's Hand)
    [126924] = { icon = "LuiExtended/media/icons/abilities/ability_set_hollowfang.dds", buff = true, debuff = false, ground = false }, -- Hollowfang Thirst (Hollowfang Thirst)
    [133493] = { icon = "LuiExtended/media/icons/abilities/ability_set_aegis_caller.dds", name = Abilities.Set_Aegis_Caller, buff = false, debuff = false, ground = true }, -- Aegis Caller (Aegis Caller's)
    -- Trial Sets
    [107141] = { icon = "LuiExtended/media/icons/abilities/ability_set_olorime.dds", name = Abilities.Set_Vestment_of_Olorime, buff = true, debuff = false, ground = false }, -- Vestment of Olirime (Olorime's)
    [109084] = { icon = "LuiExtended/media/icons/abilities/ability_set_olorime.dds", name = Abilities.Set_Vestment_of_Olorime, buff = true, debuff = false, ground = false }, -- Ideal Vestment of Olirime (Olorime's Perfect)
    [107095] = { icon = "LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds", buff = true, debuff = false, ground = false }, -- Mantle of Siroria (Siroria's)
    [109081] = { icon = "LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds", name = Abilities.Set_Mantle_of_Siroria, buff = true, debuff = false, ground = false }, -- Ideal Mantle of Siroria (Perfect Siroria's)
    [136098] = { icon = "LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds", buff = true, debuff = false, ground = false }, -- Kyne's Blessing (of Kyne's Wind)
    [137995] = { icon = "LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds", buff = true, debuff = false, ground = false }, -- Kyne's Blessing (of Kyne's Wind (Perfect)) }

    -- Used only to flag abilities for Tooltips
    [75814] = { buff = false, debuff = false, ground = false }, -- Lunar Bastion (Lunar Bastion)

    ---------------------------
    -- Class Abilities --------
    ---------------------------

    -- Dragonknight
    [28988] = { buff = false, debuff = false, ground = true }, -- Dragonknight Standard (Dragonknight Standard)
    [32958] = { buff = false, debuff = false, ground = true, noRemove = true }, -- Shifting Standard (Shifting Standard)
    [32947] = { buff = false, debuff = false, ground = true }, -- Standard of Might (Standard of Might)
    [29059] = { buff = true, debuff = false, ground = false }, -- Ash Cloud (Ash Cloud)
    [20779] = { buff = true, debuff = false, ground = false }, -- Cinder Storm (Cinder Storm)
    [32710] = { buff = false, debuff = false, ground = true }, -- Eruption (Eruption)

    -- Nightblade
    [33195] = { buff = true, debuff = false, ground = false }, -- Path of Darkness (Path of Darkness)
    [36049] = { buff = false, debuff = false, ground = true }, -- Twisting Path (Twisting Path)
    [36028] = { buff = true, debuff = false, ground = false }, -- Refreshing Path (Refreshing Path)
    [38517] = { buff = true, debuff = false, ground = false }, -- Summon Shade (Summon Shade)
    [88662] = { buff = true, debuff = false, ground = false }, -- Summon Shade (Summon Shade) -- Khajiit
    [88663] = { buff = true, debuff = false, ground = false }, -- Summon Shade (Summon Shade) -- Argonian
    [35438] = { buff = true, debuff = false, ground = false }, -- Dark Shade (Dark Shade)
    [88677] = { buff = true, debuff = false, ground = false }, -- Dark Shade (Dark Shade) -- Khajiit
    [88678] = { buff = true, debuff = false, ground = false }, -- Dark Shade (Dark Shade) -- Argonian
    [38528] = { name = Abilities.Skill_Shadow_Image, buff = true, debuff = false, ground = false }, -- Shadow (Shadow Image)
    [88696] = { name = Abilities.Skill_Shadow_Image, buff = true, debuff = false, ground = false }, -- Shadow (Shadow Image) -- Khajiit
    [88697] = { name = Abilities.Skill_Shadow_Image, buff = true, debuff = false, ground = false }, -- Shadow (Shadow Image) -- Argonian
    [37475] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Manifestation of Terror (Nightblade)
    [25411] = { buff = true, debuff = false, ground = false }, -- Consuming Darkness (Consuming Darkness)
    [36493] = { buff = true, debuff = false, ground = false }, -- Bolstering Darkness (Bolstering Darkness)
    [36485] = { buff = true, debuff = false, ground = false }, -- Veil of Blades (Veil of Blades)

    -- Sorcerer
    [24830] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3, icon = "esoui/art/icons/ability_sorcerer_daedric_mines.dds" }, -- Daedric Mines (Daedric Mines)
    [24847] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3, icon = "esoui/art/icons/ability_sorcerer_daedric_tomb.dds", name = Abilities.Skill_Daedric_Tomb }, -- Daedric Mines (Daedric Tomb)
    [25158] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 5, icon = "esoui/art/icons/ability_sorcerer_daedric_minefield.dds", name = Abilities.Skill_Daedric_Minefield }, -- Daedric Mines (Daedric Minefield)
    [27706] = { buff = false, debuff = false, ground = true }, -- Negate Magic (Negate Magic)
    [28341] = { buff = false, debuff = false, ground = true }, -- Suppression Field (Suppression Field)
    [28348] = { buff = false, debuff = false, ground = true }, -- Absorption Field (Absorption Field)
    [23182] = { buff = false, debuff = false, ground = true }, -- Lightning Splash (Lightning Splash)
    [23200] = { buff = false, debuff = false, ground = true }, -- Liquid Lightning (Liquid Lightning)
    [23205] = { buff = false, debuff = false, ground = true }, -- Lightning Flood (Lightning Flood)
    [23279] = { icon = "LuiExtended/media/icons/abilities/ability_sorcerer_intercept.dds", name = Abilities.Skill_Intercept, buff = true, debuff = false, ground = false }, -- Ball of Lightning (Ball of Lightning)

    -- Templar
    [95933] = { icon = "esoui/art/icons/ability_templar_sun_strike.dds", buff = false, debuff = false, ground = true }, -- Spear Shards (Spear Shards)
    [95957] = { icon = "esoui/art/icons/ability_templar_light_strike.dds", buff = false, debuff = false, ground = true }, -- Luminous Shards (Luminous Shards)
    [26880] = { icon = "esoui/art/icons/ability_templarsun_thrust.dds", buff = false, debuff = false, ground = true }, -- Blazing Spear (Blazing Spear)
    [21976] = { icon = "esoui/art/icons/ability_templar_nova.dds", buff = false, debuff = false, ground = true }, -- Nova (Nova)
    [22003] = { icon = "esoui/art/icons/ability_templar_solar_prison.dds", buff = false, debuff = false, ground = true }, -- Solar Prison (Solar Prison)
    [22001] = { icon = "esoui/art/icons/ability_templar_solar_disturbance.dds", buff = false, debuff = false, ground = true }, -- Solar Disturbance (Solar Disturbance)

    [22234] = { buff = true, debuff = false, ground = false }, -- Rune Focus (Rune Focus)

    -- Used only to flag abilities for Tooltips
    [22265] = { buff = false, debuff = false, ground = false }, -- Cleansing Ritual (Cleansing Ritual)
    [22259] = { buff = false, debuff = false, ground = false }, -- Ritual of Retribution (Ritual of Retribution)
    [22262] = { buff = false, debuff = false, ground = false }, -- Extended Ritual (Extended Ritual)

    -- Warden
    [86161] = { buff = false, debuff = false, ground = true }, -- Impaling Shards (Impaling Shards)
    [86165] = { buff = false, debuff = false, ground = true }, -- Gripping Shards (Gripping Shards)
    [86169] = { buff = false, debuff = false, ground = true }, -- Winter's Revenge (Winter's Revenge)
    [85578] = { buff = true, debuff = false, ground = false }, -- Healing Seed (Healing Seed)
    [85840] = { buff = true, debuff = false, ground = false }, -- Budding Seeds (Budding Seeds)
    [85845] = { buff = true, debuff = false, ground = false }, -- Corrupting Pollen (Corrupting Pollen)
    [85532] = { buff = true, debuff = false, ground = false }, -- Secluded Grove (Secluded Grove)
    [85804] = { buff = true, debuff = false, ground = false }, -- Enchanted Forest (Enchanted Forest)
    [85807] = { buff = true, debuff = false, ground = false }, -- Healing Thicket (Healing Thicket)
    [86175] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Gate (Frozen Gate)
    [86179] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Device (Frozen Device)
    [86183] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Retreat (Frozen Retreat)

    -- Necromancer
    [115252] = { buff = false, debuff = false, ground = true }, -- Boneyard (Boneyard)
    [117805] = { buff = false, debuff = false, ground = true }, -- Unnerving Boneyard (Unnerving Boneyard)
    [117850] = { buff = false, debuff = false, ground = true }, -- Avid Boneyard (Avid Boneyard)

    [116445] = { buff = false, debuff = false, ground = true }, -- Shocking Siphon (Shocking Siphon)
    [118764] = { buff = false, debuff = false, ground = true }, -- Detonating Siphon (Detonating Siphon)
    [118009] = { buff = false, debuff = false, ground = true }, -- Mystic Siphon (Mystic Siphon)

    [122174] = { buff = false, debuff = false, ground = true }, -- Frozen Colossus (Frozen Colossus)
    [122395] = { buff = false, debuff = false, ground = true }, -- Pestilent Colossus (Pestilent Colossus)
    [122388] = { buff = false, debuff = false, ground = true }, -- Glacial Colossus (Glacial Colossus)

    [115093] = { buff = true, debuff = false, ground = false }, -- Bone Totem (Bone Totem)
    [118380] = { buff = true, debuff = false, ground = false }, -- Remote Totem (Remote Totem)
    [118404] = { buff = true, debuff = false, ground = false }, -- Agony Totem (Agony Totem)

    [115326] = { buff = true, debuff = false, ground = false, icon = "esoui/art/icons/ability_necromancer_016.dds" }, -- Life amid Death (Life amid Death)
    [118022] = { buff = true, debuff = false, ground = false, icon = "esoui/art/icons/ability_necromancer_016_a.dds" }, -- Renewing Undeath (Renewing Undeath)
    [118814] = { buff = true, debuff = false, ground = false, icon = "esoui/art/icons/ability_necromancer_016_b.dds" }, -- Enduring Undeath (Enduring Undeath)

    ---------------------------
    -- Two-Handed -------------
    ---------------------------

    [38791] = { buff = false, debuff = false, ground = true }, -- Stampede (Stampede)

    ---------------------------
    -- Bow --------------------
    ---------------------------

    [28876] = { buff = false, debuff = false, ground = true }, -- Volley (Volley)
    [38689] = { buff = false, debuff = false, ground = true }, -- Endless Hail (Endless Hail)
    [38695] = { buff = false, debuff = false, ground = true }, -- Arrow Barrage (Arrow Barrage)
    [85458] = { buff = false, debuff = false, ground = true }, -- Ballista (Ballista)

    ---------------------------
    -- Destruction Staff ------
    ---------------------------

    [28807] = { buff = false, debuff = false, ground = true }, -- Wall of Fire (Wall of Elements)
    [28854] = { buff = false, debuff = false, ground = true }, -- Wall of Storms (Wall of Elements)
    [28849] = { buff = false, debuff = false, ground = true }, -- Wall of Frost (Wall of Elements)
    [39053] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Fire (Unstable Wall of Elements)
    [39073] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Storms (Unstable Wall of Elements)
    [39067] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Frost (Unstable Wall of Elements)
    [39012] = { buff = false, debuff = false, ground = true }, -- Blockade of Fire (Elemental Blockade)
    [39018] = { buff = false, debuff = false, ground = true }, -- Blockade of Storms (Elemental Blockade)
    [39028] = { buff = false, debuff = false, ground = true }, -- Blockade of Frost (Elemental Blockade)
    [83625] = { buff = false, debuff = false, ground = true }, -- Fire Storm (Elemental Storm)
    [83630] = { buff = false, debuff = false, ground = true }, -- Thunder Storm (Elemental Storm)
    [83628] = { buff = false, debuff = false, ground = true }, -- Ice Storm (Elemental Storm)
    [85126] = { buff = false, debuff = false, ground = true }, -- Fiery Rage (Elemental Rage)
    [85130] = { buff = false, debuff = false, ground = true }, -- Thunderous Rage (Elemental Rage)
    [85128] = { buff = false, debuff = false, ground = true }, -- Icy Rage (Elemental Rage)

    ---------------------------
    -- Restoration Staff ------
    ---------------------------

    [28385] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Grand Healing (Grand Healing)
    [40058] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Illustrious Healing (Illustrious Healing)
    [40060] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Healing Springs (Healing Springs)

    ---------------------------
    -- Fighters Guild ---------
    ---------------------------

    [35737] = { buff = true, debuff = false, ground = false }, -- Circle of Protection (Circle of Protection)
    [40181] = { buff = true, debuff = false, ground = false }, -- Turn Evil (Turn Evil)
    [40169] = { buff = true, debuff = false, ground = false }, -- Ring of Preservation (Ring of Preservation)

    ---------------------------
    -- Mages Guild ------------
    ---------------------------

    [31632] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Fire Rune (Fire Rune)
    [40470] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Volcanic Rune (Volcanic Rune)
    [40465] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Scalding Rune (Scalding Rune)
    [63430] = { icon = "esoui/art/icons/ability_mageguild_005.dds", buff = false, debuff = false, ground = true }, -- Meteor (Meteor)
    [63456] = { icon = "esoui/art/icons/ability_mageguild_005_b.dds", buff = false, debuff = false, ground = true }, -- Ice Comet (Ice Comet)
    [63473] = { icon = "esoui/art/icons/ability_mageguild_005_a.dds", buff = false, debuff = false, ground = true }, -- Shooting Star (Shooting Star)

    ---------------------------
    -- Psijic Order -----------
    ---------------------------

    [104079] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Time Freeze (Time Freeze)

    ---------------------------
    -- Undaunted --------------
    ---------------------------

    [39489] = { buff = true, debuff = false, ground = false }, -- Blood Altar (Blood Altar)
    [41967] = { buff = true, debuff = false, ground = false }, -- Sanguine Altar (Sanguine Altar)
    [41958] = { buff = true, debuff = false, ground = false }, -- Overflowing Altar (Overflowing Altar)
    [39425] = { buff = false, debuff = false, ground = true }, -- Trapping Webs (Trapping Webs)
    [41990] = { buff = false, debuff = false, ground = true }, -- Shadow Silk (Shadow Silk)
    [42012] = { buff = false, debuff = false, ground = true }, -- Tangling Webs (Tangling Webs)

    [39298] = { buff = false, debuff = false, ground = true }, -- Necrotic Orb (Necrotic Orb)
    [42028] = { buff = false, debuff = false, ground = true }, -- Mystic Orb (Mystic Orb)
    [42038] = { buff = true, debuff = false, ground = false }, -- Energy Orb (Energy Orb)

    ---------------------------
    -- Assault ----------------
    ---------------------------

    [38549] = { icon = "esoui/art/icons/ability_ava_001.dds", buff = false, debuff = false, ground = true }, -- Caltrops (Caltrops)
    [40265] = { icon = "esoui/art/icons/ability_ava_001_a.dds", buff = false, debuff = false, ground = true }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40251] = { icon = "esoui/art/icons/ability_ava_001_b.dds", name = Abilities.Skill_Razor_Caltrops, buff = false, debuff = false, ground = true }, -- Caltrops (Razor Caltrops)

    ---------------------------
    -- Support ----------------
    ---------------------------

    [38570] = { buff = true, debuff = false, ground = false }, -- Siege Shield (Siege Shield)
    [40229] = { buff = true, debuff = false, ground = false }, -- Siege Weapon Shield (Siege Weapon Shield)
    [40226] = { buff = true, debuff = false, ground = false }, -- Propelling Shield (Propelling Shield)

    [61498] = { buff = false, debuff = false, ground = true }, -- Revealing Flare (Revealing Flare)
    [61522] = { name = Abilities.Skill_Lingering_Flare, buff = false, debuff = false, ground = true }, -- Nova (Lingering Flare)
    [61526] = { buff = false, debuff = false, ground = true }, -- Blinding Flare (Blinding Flare)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Buffs & Debuffs - Fake auras created by EVENT_COMBAT_EVENT for abilities that lack proper auras. Note tooltips & unbreakable status are determined in Effects.EffectOverride

-- icon = '' -- Set an icon to use
-- name = '' -- Set a name to use
-- duration = # -- Set the duration of the effect (Note "GET" will pull the value from the API)
-- ignoreFade = true -- Ignore ACTION_RESULT_EFFECT_FADED
-- ignoreBegin = true -- Ignore ACTION_RESULT_BEGIN - Emulates the same functionality as refreshOnly in Effects.EffectOverride. For stopping auras from being created for travel times.
-- refreshOnly = -- Ignore ACTION_RESULT_BEGIN & ACTION_RESULT_EFFECT_GAINED
-- shiftId = # -- Shift the ability id displayed to use this id instead, for tooltip compatibility in some cases.
-- overrideDuration = true -- Set duration to display as 0, but preserve the correct duration so this effect doesn't fade improperly.
-- debuff = true -- Set this to display as a debuff
-- long = Force buff to display in the "long" container if it exists (only compatible with BUFFS)

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Buffs applied onto the player by NPCs or Events (Friendly)
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakeExternalBuffs =
{

    -- Quests
    [21403] = { duration = 60000, ignoreFade = true }, -- Spiritual Cloak (The Mallari-Mora)

    -- Elsweyr Quests
    [124310] = { duration = 10000 }, -- Master's Shield (Grand Adept Ma'hja-dro)

    ----------------
    -- Dungeons ----
    ----------------

    -- Elden Root II
    [32655] = { duration = 0 }, -- Fortification (Fortified Guardian)
    [32614] = { duration = 0 }, -- Empowered (Mystic Guardian)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Debuffs applied onto the player by NPCs or Events (Hostile)
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakeExternalDebuffs =
{

    -- Necromancer
    [118242] = { duration = 1000 }, -- Beckoning Armor (Beckoning Armor)

    -- Destruction Staff
    [38946] = { duration = 1800 }, -- Stun After Knockback Movement (Destructive Reach) -- Fire

    -- Vampire
    [40349] = { duration = 23000 }, -- Feed (Blood Ritual - Rank 1)

    -- Werewolf
    [40520] = { duration = 7000 }, -- Q3047 - Knockdown (Blood Moon - Rank 1)

    -- Item Sets
    [75706] = { duration = 0 }, -- Bahraha's Curse

    -- Traps
    [27479] = { duration = 2000 }, -- Falling Rocks (Falling Rocks)
    [29602] = { duration = 2000 }, -- Falling Rocks (Cave-In)

    [31606] = { duration = 0 }, -- Fire Trap (Player)
    [72890] = { duration = 0 }, -- Laser Snare (Fire)

    [32246] = { duration = 0 }, -- Searing Steam (Steam Trap) -- Stros M'Kai

    --[66153] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Trial of Flame', duration = 1500}, -- Trial of Flame (Wrothgar - Old Orsinium)
    --[32246] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Steam Trap', duration = 2000}, -- Laser Snare (Steam Trap)

    -- Quest Traps
    -- TODO: Orsinium
    --[64535] = {icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', name = 'Chilling Wind', duration = 2000}, -- Chilling Wind (Orsinium - Sorrow's Kiss)
    --[67586] = {icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = 'Avalanche', duration = 2500}, -- Avalanche (Orsinium - Sorrow's Kiss)

    -- Justice NPC's
    [63160] = { duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63263] = { duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63094] = { duration = 1500 }, -- Shield Charge (Justice Guard 1H)
    [63260] = { duration = 1500 }, -- Shield Charge (Justice Guard 2H)
    [63194] = { duration = 6000 }, -- Flame Shard (Justice Guard 2H)
    [63168] = { duration = 3500, ignoreBegin = true }, -- Cage Talons (Justice Guard 1H + 2H)

    -- Standard NPC Abilities
    [29401] = { duration = 3000 }, --Power Bash (NPC Disorient)
    [14926] = { duration = 2000 }, -- Charge (Human NPC)
    [10650] = { duration = 0 }, -- Oil Drenched
    [79930] = { duration = 2500 }, -- Lunge (Tracker) (Morrowind)

    -- Animals
    [69073] = { duration = 2000 }, -- Knockdown (Bear Orsinium)
    [74336] = { duration = 2000 }, -- Bog Burst (Haj Mota)
    [14523] = { duration = 6000, ignoreBegin = true }, -- Helljoint (Wolf)
    [85394] = { duration = 8000 }, -- Slash (Cliff Strider Matriach)
    [55862] = { duration = 8000 }, --Storm Bound (Wamasu - Boss) (DOT)
    [55863] = { duration = 8000 }, --Storm Bound (Wamasu - Boss) (SNARE)

    -- Daedra
    [50023] = { duration = 4000, ignoreBegin = true }, -- Lightning Rod (Air Atronach)
    [51646] = { duration = 0 }, -- Frozen Ground (Frost Atronach)
    [24700] = { duration = 2000 }, -- Body Slam (Ogrim)
    [91851] = { duration = 2000 }, -- Stomp (Ogrim)
    [6412] = { duration = 2000, ignoreBegin = true }, -- Dusk's Howl (Winged Twilight)

    -- Insects
    [9237] = { duration = 10000 }, -- Larva Gestation (Giant Wasp)
    [6795] = { duration = 7500 }, -- Latch On (Hoarvor)
    [61372] = { duration = 4000 }, -- Infectious Swarm (Necrotic Hoarvor)
    [8429] = { duration = 4000, ignoreBegin = true }, -- Zap (Thunderbug)

    -- Monsters
    [51354] = { duration = 500 }, -- Petrify (Gargoyle)
    [17703] = { duration = 4000, ignoreBegin = true }, -- Flame Ray (Imp - Fire)
    [8884] = { duration = 4000, ignoreBegin = true }, -- Zap (Imp - Lightning)
    [81794] = { duration = 4000, ignoreBegin = true }, -- Frost Ray (Imp - Frost)
    [95288] = { duration = 0 }, -- Hurricane (Nereid)
    [48287] = { duration = 1500 }, -- Consuming Omen (Troll - Ranged) (Fake aura to replace bugged aura)

    -- Undead
    [38834] = { duration = 0 }, -- Desecrated Ground Snare (Desecrated Ground)
    [22525] = { duration = 0 }, -- Defiled Ground (Lich)
    [43146] = { duration = 4000 }, -- Winter's Reach (Wraith)

    -- Traps
    [49897] = { duration = 0 }, -- Fire (Fire) -- Throne of the Wilderking
    [11338] = { duration = 0 }, -- Lava -- In Lava
    [55925] = { duration = 0 }, -- Lava (City of Ash II)

    ------------------------------
    -- Quests --------------------
    ------------------------------

    -- Main Story
    [14972] = { duration = 2000 }, -- CON_Knockback&Knockdown (Castle of the Worm)
    [44561] = { duration = 3000 }, -- FGQ4 RGT Event Knockback (Lyris Doppleganger - Halls of Torment)
    [38741] = { duration = 4000 }, -- Royal Snare (Duchess of Anguish - Halls of Torment)
    [40429] = { duration = 2000 }, -- IntroKB (Mannimarco - Shadow of Sancre Tor)
    [41198] = { duration = 2000 }, -- IntroKB (Mannimarco - Shadow of Sancre Tor)

    -- Fighter's Guild
    [39579] = { duration = 2000 }, -- CON_Knockback&Knockdown (The Prismatic Core)
    [25979] = { duration = 1000 }, -- FG4 RGT Event Knockback

    -- Mages Guild
    [31502] = { duration = 4000 }, -- MGQ2 Asakala Sahdina Barrier
    [31503] = { duration = 4000 }, -- MGQ2 Asakala Rashomta Barrier

    -- Aldmeri Dominion
    [21876] = { duration = 4500 }, -- Q4260 West Barrier Teleport (Breaking the Barrier)
    [21878] = { duration = 4500 }, -- Q4260 East Barrier Teleport (Breaking the Barrier)
    [22395] = { duration = 4000 }, -- Q4261 ROD Barrier Teleport (Sever All Ties)
    [28771] = { duration = 2000 }, -- Q4220 Thirster Stun (The Mallari-Mora)
    [23606] = { duration = 2000 }, -- Q4326 Crystal Backfire (Preventative Measure)
    [43823] = { duration = 2150 }, -- IntroKB (Prince Naemon)
    [36766] = { duration = 5000 }, -- Q4842 Stun Headgrab Knockback (The Unquiet Dead)
    [33384] = { duration = 4000 }, -- Q4586 Aranias Vine Stun

    -- Elsweyr
    [121645] = { duration = 8000 }, -- Defiled Ground (Euraxian Necromancer) (Bright Moons, Warm Sands)
    [125268] = { duration = 2500 }, -- Headbutt (Bahlokdaan)

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    --[[
    [69794] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Frozen Ground', duration = 2000}, -- Frozen Ground (Invitation to Orsinium - Olarz the Cunning)
    [53272] = {icon = 'esoui/art/icons/ability_destructionstaff_005.dds', name = 'Frost Clench', duration = 500}, -- Frost Clench (The Anger of a King - Talviah Aliaria)
    [66875] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Royal Strike', duration = 1500}, -- Royal Strike (Blood on a King's Hands)
    [65186] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'The King\'s Chains', duration = 4000}, -- The King's Chains (Blood on a King's Hands)
    [67014] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Tear Down the Mountain', duration = 2000}, -- Tear Down the Mountain (Blood on a King's Hands)
    [73861] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Murky Water', duration = 0}, -- Murky Water (Blood and the Sacred Words)
    [73864] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Murky Water', duration = 3000}, -- Murky Water (Blood and the Sacred Words)
    [72128] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Harmonic Wave Impact', duration = 2000}, -- Harmonic Wave Impact (Rkindaleft - Resonant Centurion)
    [25265] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Decapitation Function', duration = 2000}, -- Decapitation Function (Rkindaleft - Vessel of the Auditor)
    [70316] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Vessel Knockback', duration = 2000}, -- Q5321 Centurian Knockback (Rkindaleft - Vessel of the Auditor)
    ]]
    --

    ----------------------------------------------------------------
    -- VVARDENFELL -------------------------------------------------
    ----------------------------------------------------------------

    -- The Forgotten Wastes (Public Dungeon)
    [88030] = { duration = 1500 }, -- Falling Rocks -- Deadfall
    [87348] = { duration = 1500 }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87350] = { duration = 2000 }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [89756] = { duration = 2000 }, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)

    ----------------------------------------------------------------
    -- ARENAS ----------------------------------------------------
    ----------------------------------------------------------------

    -- Dragonstar Arena
    [27920] = { duration = 1800 }, -- Generic Knockback Stun (House Dres Templar)
    [54068] = { duration = 500 }, -- Fossilize (Earthen Heart Knight)
    [54405] = { duration = 4000 }, -- Celestial Blast (Anka-Ra Shadowcaster)
    [52910] = { duration = 6000 }, -- Dark Flare Trauma (Shadow Knight)
    [56065] = { duration = 12000 }, -- Ice Charge (Dwarven Ice Centurion)
    [83477] = { duration = 4000 }, -- Volcanic Rune (Mavus Talnarith)

    -- Maelstrom Arena
    [73877] = { duration = 2000 }, -- Piercing Shriek (Lamia Queen)
    [72705] = { duration = 10000 }, -- Cold Snap (Leimenid Oracle)
    [71997] = { duration = 10000 }, -- Cold Snap (Leimenid Oracle)
    [71940] = { duration = 8000 }, -- Frost Breath (Huntsman Chillbane)
    [71720] = { duration = 2000 }, -- Stun (Matriarch Runa)

    ----------------------------------------------------------------
    -- DUNGEONS ----------------------------------------------------
    ----------------------------------------------------------------

    -- Banished Cells II
    [35680] = { duration = 2250 }, -- Immolating Bite (Maw of the Infernal)
    [27828] = { duration = 2500 }, -- Crushing Blow (Keeper Voranil)
    [28570] = { duration = 5000 }, -- Levitate (High Kinlord Rilis)
    [28462] = { duration = 5000 }, -- Levitate (High Kinlord Rilis)

    -- Elden Hollow I
    [25310] = { duration = 2500 }, -- Executioners Strike (Akash gra-Mal)
    [25348] = { duration = 6000, refreshOnly = true }, -- Necrotic Circle (Canonreeve Oraneth)
    [46800] = { duration = 1200 }, -- Necrotic Circle (Canonreeve Oraneth)

    -- Elden Hollow II
    [33334] = { ignoreBegin = true, duration = 7500 }, -- Latch On Stamina (Frenzied Guardian)
    [33337] = { ignoreBegin = true, duration = 7500 }, -- Latch On Magicka (Mystic Guardian)
    [33164] = { duration = 4000, ignoreBegin = true }, -- Incite Fear (Shadow Tendril)
    [35372] = { duration = 3500 }, -- Emerge (Bogdan the Nightflame)

    -- City of Ash I
    [25036] = { duration = 2000 }, -- Crushing Blow (Golor the Banekin Handler)
    [34948] = { duration = 25000 }, -- Burning Embers (Razor Master Erthas)
    [49138] = { duration = 1500 }, -- Oblivion Portal

    -- City of Ash II
    [54139] = { duration = 3000 }, -- Blazing Embers (Marruz)
    [53978] = { duration = 3000 }, -- Blazing Arrow (Marruz)
    [54145] = { duration = 1000 }, -- Fire Chain (Rukhan)
    [54098] = { duration = 2000 }, -- CON_Knockback&Knockdown (Rukhan)
    [56813] = { duration = 2000 }, -- CON_Knockback&Knockdown (Xivilai Ravager)

    [56307] = { duration = 3000 }, -- Fiery Jaws (Horvantud the Fire Maw)
    [54873] = { duration = 2000 }, -- Heavy Slash
    [56357] = { duration = 2000 }, -- Fire Swarm (Ash Titan)
    [55502] = { duration = 1500 }, -- Meteor (Valkyn Skoria)
    [55383] = { duration = 2000 }, -- Flame Strike (Valkyn Skoria)
    [55756] = { duration = 7500 }, -- Burning (Fire Stab)

    -- Tempest Island
    [26676] = { duration = 2000 }, -- IntroKB (Valaran Stormcaller)
    [28391] = { duration = 2500 }, -- Q4538 Stoen Explosion (Conduit Stone)
    [26716] = { duration = 2800 }, -- Skyward Slam (Stormfist)
    [26938] = { duration = 0 }, -- Enervating Stone (Stormfist)

    -- Selene's Web
    [31247] = { duration = 4000 }, -- Ensnare
    [31248] = { duration = 8000 }, -- Ensnare
    [30905] = { duration = 2000 }, -- IntroKB (Spectral Senche-Tiger)

    -- Spindleclutch I
    [18116] = { duration = 3500 }, -- Arachnophobia (The Whisperer)
    [46219] = { duration = 2500 }, -- Web Blast (The Whisperer)

    -- Spindleclutch II
    [18054] = { duration = 8000 }, -- Entangled (The Whisperer Nightmare)
    [18051] = { duration = 2000 }, -- Encased (The Whisperer Nightmare)
    [43176] = { duration = 1200 }, -- Shocked (Blood Essence)
    [61444] = { duration = 1200 }, -- Shocked (Blood Essence)
    [32100] = { duration = 3500 }, -- Arachnophobia (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [34848] = { duration = 2000 }, -- Primal Sweep (Slimecraw)
    [25531] = { duration = 2000 }, -- Tidal Slash (Varaine Pellingare)

    -- Wayrest Sewers II
    [36431] = { duration = 10000 }, -- Rend Soul (Malubeth the Scourger)
    [36870] = { duration = 5000 }, -- Scorching Flames (Uulgarg the Risen)
    [36900] = { duration = 35000 }, -- Haunting Spectre (The Forgotten One)
    [36535] = { duration = 2000 }, -- Spinning Cleave (Varaine Pellingare)
    [36398] = { duration = 2500 }, -- Bludgeon (Varaine Pellingare)
    [35839] = { duration = 12000 }, -- Necrotic Arrow (Allene Pellingare)

    -- Crypt of Hearts I
    [46692] = { duration = 2500 }, -- CON_Knockback&Knockdown (Ilambris-Athor)
    [44088] = { duration = 2000 }, -- CON_Knockback&Knockdown (Ilambris-Zaven)

    -- Crypt of Hearts II
    [53598] = { duration = 2000 }, -- Shock Form (Ilambris Amalgam)
    [53591] = { duration = 2000 }, -- CON_Knockback&Knockdown (Ilambris Amalgam)
    [51111] = { duration = 5000 }, -- Rise and Fall (Mezeluth)
    [51824] = { duration = 2500 }, -- Fulminating Void (Mezeluth)
    [53442] = { duration = 6000 }, -- Lethal Stab (Nerien'eth)
    [51995] = { duration = 2250 }, -- Heavy Slash (Nerien'eth)

    -- Volenfell
    [25649] = { duration = 4000, ignoreBegin = true }, -- Debilitating Roar (Desert Lion)
    [46314] = { duration = 2500 }, -- CON_Knockback&Knockdown (Monstrous Gargoyle)
    [42930] = { duration = 6000 }, -- Petrifying Bellow (Monstrous Gargoyle)
    [29166] = { duration = 2000 }, -- CON_Knockback&Knockdown (Tremorscale)
    [25265] = { duration = 2000 }, -- Decapitation Function (The Guardian's Soul)

    -- Frostvault
    [117486] = { duration = 18000 }, -- Bleed (Coldsnap Goblin - Shared)
    [109808] = { duration = 0 }, -- Frostbite (Icestalker)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake buffs applied onto the player by self (also supports debuffs with debuff = true)
-- onlyExtra -- Only display this if the Show Extra Buffs menu option is enabled
-- onlyExtended -- Only display this if the Show Extra Buffs menu option with "Extend Settings to Single Aura Effects" is enabled.
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakePlayerBuffs =
{
    -- Misc Consumables
    --[85355] = {icon = 'LuiExtended/media/icons/mementos/memento_fire-breathers_torches.dds', name = Abilities.Memento_Fire_Breathers_Torches, duration = 12000}, -- Flame Juggling (Consumable Version)
    --[85354] = {icon = 'LuiExtended/media/icons/mementos/memento_jugglers_knives.dds', name = Abilities.Memento_Jugglers_Knives, duration = 12000}, -- Dagger Juggling (Consumable Verison)
    --[85353] = {icon = 'LuiExtended/media/icons/mementos/memento_sword-swallowers_blade.dds', name = Abilities.Memento_Sword_Swallowers_Blade, duration = 12000}, -- Sword Swallowing (Consumable Version)

    -- Base Mementos
    [41988] = { duration = 10000 }, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = { duration = 10000 }, -- Glimpse of the Forbidden (Discoure Amaranthine)
    --[42076] = {icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds', name = Abilities.Memento_Sealing_Amulet, duration = 8000}, -- Tear (Mezha-dro's Sealing Amulet)
    --[34578] = {icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds', name = Abilities.Memento_Nirnroot_Wine, duration = 8000}, -- Nirnroot Wine (Nirnroot Wine)
    [26339] = { duration = 5500 }, -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = { duration = 10000 }, -- Sanguine's Goblet (Sanguine's Goblet)
    [42008] = { duration = 10000 }, -- Blessing of Root Sunder (Token of Root Sunder)
    --[42053] = {icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds', name = Abilities.Memento_Yokudan_Totem, duration = 10000}, -- Yokudan Salute (Yokudan Totem)

    -- DLC Mementos
    --[89550] = {icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds', name = Abilities.Memento_Twilight_Shard, duration = 9000 }, -- TROPHY Azura's Light (Twilight Shard)
    --[79510] = {icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds', name = Abilities.Memento_Blade_of_the_Blood_Oath, duration = 6500}, -- TROPHY Blood Oath (Blade of the Blood Oath)
    --[74151] = {icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds', name = Abilities.Memento_Hidden_Pressure_Vent, duration = 2500}, -- Stun (Hidden Pressure Vent)

    -- Crown Store Mementos
    [85349] = { duration = 180000 }, -- Storm Atronach Transform (Atronach Transformation)
    --[85347] = {icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds', name = Abilities.Memento_Storm_Orb_Juggle, duration = 12000}, -- Storm Orb Juggle (Atronach Juggling)
    [86977] = { duration = 180000 }, -- Spriggan Transformation (Wild Hunt Transform)
    [92868] = { duration = 180000 }, -- Dwarven Transformation (Dwemervamidium Mirage)
    --[97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds', name = Abilities.Memento_Crows_Calling, duration = 9000 }, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [97274] = { duration = 180000 }, -- Swarm of Crows (Swarm of Crows)

    --[99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds', name = Abilities.Memento_Fiery_Orb, duration = 9000 }, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    --[99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds', name = Abilities.Memento_Flame_Pixie, duration = 8000 }, -- Flame Crate Memento 2 (Flame Pixie)
    --[99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds', name = Abilities.Memento_Flame_Eruption, duration = 2000 }, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    --[101874] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_frost_shard.dds', name = Abilities.Memento_Frost_Shard, duration = 10000 }, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    --[101877] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_rune_of_levitation.dds', name = Abilities.Memento_Rune_of_Levitation, duration = 9000 }, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    --[101872] = { icon = 'LuiExtended/media/icons/mementos/memento_bone_dragon_summons_focus.dds', name = Abilities.Memento_Dragon_Summons_Focus, duration = 5000 }, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    [110483] = { duration = 6800 }, -- Ghost Lantern (Ghost Lantern)

    -- Set Items
    [149413] = { duration = 0 }, -- Wrath of Elements (Vateshran Destruction Staff)
    [98421] = { duration = 15000 }, -- Pirate Skeleton
    [98419] = { duration = 15000 }, -- Pirate Skeleton
    [98420] = { duration = 15000 }, -- Pirate Skeleton
    [81675] = { duration = 15000 }, -- Pirate Skeleton
    [83288] = { duration = 15000 }, -- Pirate Skeleton
    [83287] = { duration = 15000 }, -- Pirate Skeleton
    --[124303] = { duration = 3000 }, -- Senche-Raht's Grit (Senche-Raht's)
    [117082] = { duration = 0 }, -- Frozen Watcher (Frozen Watcher)
    [134930] = { duration = 0 }, -- Duneripper's Scales
    [135554] = { duration = 0 }, -- Grave Guardian (Grave Guardian's)
    [106867] = { duration = 10000 }, -- Grace of Gloom (Gloom-Graced)
    [139552] = { duration = 0, long = true }, -- Snow Treaders (Snow Treaders)

    -- Set ICD's
    [129477] = { duration = 20000, debuff = true }, -- Immortal Warrior
    [127235] = { duration = 60000, shiftId = 999010, debuff = true }, -- Eternal Warrior
    [127032] = { duration = 60000, shiftId = 999011, debuff = true }, -- Phoenix
    [142401] = { duration = 60000, shiftId = 999012, debuff = true }, -- Juggernaut

    -- Player (Basic)
    [123970] = { duration = 3000 }, -- Lesser Reincarnate

    -----------------
    -- Class --------
    -----------------

    -- Dragonknight
    [32956] = { duration = 0 }, -- Standard of Might (Standard of Might)

    [29004] = { duration = "GET", onlyExtended = true }, -- Dragon Blood
    [32744] = { duration = "GET", onlyExtra = true }, -- Green Dragon Blood
    [32722] = { duration = "GET", onlyExtended = true }, -- Coagulating Blood

    [92507] = { duration = "GET", shiftId = 29043, onlyExtra = true }, -- Molten Weapons
    [92503] = { duration = "GET", shiftId = 31874, onlyExtra = true }, -- Igneous Weapons

    [31841] = { duration = 2500 }, -- Inhale
    [32796] = { duration = 2500 }, -- Deep Breath
    [32788] = { duration = 2500 }, -- Draw Essence

    -- Nightblade
    [90587] = { duration = "GET", shiftId = 33375, onlyExtended = true }, -- Blur
    [90593] = { duration = "GET", shiftId = 35414, onlyExtra = true }, -- Mirage
    [90620] = { duration = "GET", shiftId = 35419, onlyExtended = true }, -- Phantasmal Escape

    [33317] = { duration = "GET", shiftId = 33316, onlyExtra = true }, -- Drain Power
    [131344] = { duration = "GET", shiftId = 36901, onlyExtra = true }, -- Power Extraction
    [62240] = { duration = "GET", shiftId = 36891, onlyExtra = true }, -- Sap Essence

    -- Templar
    [22223] = { duration = 4000 }, -- Rite of Passage (Rite of Passage)
    [22229] = { duration = 4000 }, -- Remembrance (Remembrance)
    [22226] = { duration = 6000 }, -- Practiced Incantation (Practiced Incantation)

    -- Warden
    [87019] = { duration = "GET", onlyExtra = true, shiftId = 85862 }, -- Minor Endurance (Enchanted Growth)

    [86224] = { duration = "GET", onlyExtended = true, shiftId = 86122 }, -- Major Resolve (Frost Cloak)
    [88758] = { duration = "GET", onlyExtended = true, shiftId = 86126 }, -- Major Resolve (Expansive Frost Cloak)
    [88761] = { duration = "GET", onlyExtra = true, shiftId = 86130 }, -- Major Resolve (Ice Fortress)

    [86135] = { duration = "GET" }, -- Crystalized Shield (Crystallized Shield)
    [86139] = { duration = "GET" }, -- Crystalized Slab (Crystallized Slab)
    [86143] = { duration = "GET" }, -- Shimmering Shield (Shimmering Shield)

    -- Two Handed
    [28297] = { duration = "GET", onlyExtra = true }, -- Momentum
    [38794] = { duration = "GET", onlyExtra = true }, -- Forward Momentum

    -- Restoration Staff
    [37243] = { duration = "GET", onlyExtended = true, ignoreFade = true }, -- Blessing of Protection (Blessing of Protection)
    [40103] = { duration = "GET", onlyExtended = true, ignoreFade = true }, -- Blessing of Restoration (Blessing Of Restoration)
    [40094] = { duration = "GET", onlyExtra = true, ignoreFade = true }, -- Combat Prayer (Combat Prayer)

    -- Mages Guild
    [40449] = { duration = "GET" }, -- Spell Symmetry (Spell Symmetry)

    -- Psijic Order
    [122260] = { duration = "GET" }, -- Race Against Time (Race Against Time)

    -- Armor
    [63015] = { duration = "GET", onlyExtended = true, shiftId = 29556 }, -- Major Evasion (Evasion)
    [63019] = { duration = "GET", onlyExtended = true, shiftId = 39195 }, -- Major Evasion (Shuffle)
    [126958] = { duration = "GET" }, -- Elude (Elude)

    -- Vampire
    [145002] = { duration = 5000, debuff = true }, -- Blood for Blood (Blood for Blood)

    -- Werewolf
    [137206] = { duration = "GET", debuff = true }, -- Major Berserk (Hircine's Rage)

    -- Alliance War
    [101161] = { duration = "GET", shiftId = 38566, onlyExtended = true }, -- Rapid Maneuever (Rapid Maneuver)
    [101169] = { duration = "GET", shiftId = 40211 }, -- Retreating Maneuever (Retreating Maneuver)
    [101178] = { duration = "GET", shiftId = 40215, onlyExtra = true }, -- Charging Maneuver (Charging Maneuver)

    -- Seasonal Quests (New Life Festival)
    --[84125] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Breton Male Dance (Lava Foot Stomp)
    --[84126] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Breton Female Dance (Lava Foot Stomp)
    --[84127] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Dunmer Male Dance (Lava Foot Stomp)
    --[84128] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Dunmer Female Dance (Lava Foot Stomp)
    --[84130] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Altmer Male Dance (Lava Foot Stomp)
    --[84131] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Altmer Female Dance (Lava Foot Stomp)
    --[84133] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Nord Dance (Lava Foot Stomp)
    --[84528] = {icon = 'LuiExtended/media/icons/mementos/memento_fire_breathers_torches.dds', name = Abilities.Skill_Torch_Juggling, duration = 12000}, -- Flame Juggling (Castle Charm Challenge)
    --[84506] = {icon = 'LuiExtended/media/icons/mementos/memento_jugglers_knives.dds', name = Abilities.Skill_Knife_Juggling, duration = 12000}, -- Dagger Juggling (Castle Charm Challenge)
    --[84533] = {icon = 'LuiExtended/media/icons/mementos/memento_sword_swallowers_blade.dds', name = Abilities.Skill_Sword_Swallowing, duration = 12000}, -- Sword Swallowing (Castle Charm Challenge)
    --[84847] = {icon = 'LuiExtended/media/icons/abilities/ability_quest_celebratory_belch.dds', name = Abilities.Skill_Celebratory_Belch, duration = 5000}, -- Celebratory Belch (Stonetooth Bash)

    ------------------------------
    -- Quests --------------------
    ------------------------------

    -- Mages Guild
    [26406] = { duration = 0 }, -- MG2 Captured Essence (Simply Misplaced)
    [26634] = { duration = 0 }, -- MG2 Captured Sahdina Essence
    [26581] = { duration = 0 }, -- MG2 Captured Rashomta Essence

    -- Aldmeri Dominion Quests
    [33066] = { icon = "LuiExtended/media/icons/disguises/disguise_fancy_clothing.dds", name = Abilities.Skill_Fancy_Clothing, duration = 0, long = true, ignoreBegin = true }, -- Q4586_ChangeClothes
    [34842] = { icon = "LuiExtended/media/icons/disguises/disguise_fancy_clothing_female.dds", name = Abilities.Skill_Fancy_Clothing, duration = 0, long = true, ignoreBegin = true }, -- Q4586_ChangeClothesFEMALE
    --[29504] = { duration = 0, long = true }, -- Q4546 Shade Layer
    --[34597] = { duration = 0, long = true }, -- Q4690 Forest Spirit Layer

    -- Quest related (Craglorn)
    --[81807] = {icon = 'esoui/art/icons/achievement_104.dds', name = 'Power of the Stars', duration = 22000}, -- Power of the Stars (The Star-Gazers)

    -- Orsinium
    --[66453] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', name = 'Hiding', duration = 45000}, -- Hiding (A Question of Succession)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake offline auras created by the player
-- ground == true - Set the target to ground instead of player.
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakePlayerOfflineAura =
{
    -- Sets
    [75814] = { duration = "GET" }, -- Lunar Bastion (Lunar Bastion)

    -- Templar
    [22265] = { duration = "GET" }, -- Cleansing Ritual (Cleansing Ritual)
    [22259] = { duration = "GET" }, -- Ritual of Retribution (Ritual of Retribution)
    [22262] = { duration = "GET" }, -- Extended Ritual (Extended Ritual)

    -- Fighter's Guild
    [35750] = { duration = "GET", ground = true }, -- Trap Beast (Trap Beast)
    [40382] = { duration = "GET", ground = true }, -- Barbed Trap (Barbed Trap)
    [40372] = { duration = "GET", ground = true }, -- Lightweight Beast Trap (Lightweight Beast Trap)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake debuffs applied onto a target by the player
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakePlayerDebuffs =
{
    -- JUSTICE NPCS
    -- Disabled: Duration is too long and Guard always CC breaks. Maybe setup a calllater removal function?
    --[63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = Abilities.Skill_Stonefist, duration = 6000 }, -- Flame Shard (Justice Guard 2H) -- If the player reflects

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    [86309] = { duration = 3000 }, -- Stun (Player blocks NPC charged attack)
    [86312] = { duration = 3000 }, -- Stun (Player blocks Ogrim Body Slam)

    -- Necromancer
    [118242] = { duration = 1000 }, -- Beckoning Armor (Beckoning Armor)

    -- Destruction Staff
    [38946] = { duration = 1800 }, -- Stun After Knockback Movement (Destructive Reach) -- Fire

    -- Vampire
    [40349] = { duration = 23000 }, -- Feed (Blood Ritual - Rank 1)

    -- Werewolf
    [40520] = { duration = 7000 }, -- Q3047 - Knockdown (Blood Moon - Rank 1)

    -- Item Sets
    [75706] = { duration = 1100, overrideDuration = true }, -- Bahraha's Curse -- Note: We add 100 ms to buffer here because it doesn't really matter and stops flashing
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Stagger Effects - For debuffs applied on the player or on a target that don't need to check for a removal condition (Useful for effects like staggers where this is no way to break out of them for the short duration they are applied.
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakeStagger =
{
    -- Player Basic
    [115607] = { duration = 2000 }, -- Hard Dismount (Mount)
    [141004] = { duration = 2000 }, -- Hard Dismount (Passenger Mount)

    -- Dual Wield
    [126640] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Hidden Blade)
    [126650] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Shrouded Daggers)
    [126655] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Flying Blade)

    -- Bow
    [38649] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Poison Arrow (Venom Arrow)

    -- Destruction Staff
    [48009] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Crushing Shock)

    -- On Player
    [2874] = { duration = 433 }, -- Staggered (Generic Stagger applied to player by many different NPC abilities)
    [29402] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Power Bash (Stagger when hit with Power Bash)
    [29765] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Uber Attack (Player staggers self by hitting Blocking NPC with Heavy Attack)
    [68971] = { duration = 433 }, -- Staggered (Echatere - Shockwave)
    [12426] = { duration = 433 }, -- Raven Storm (Hagraven)
    [32698] = { duration = 433 }, -- Pulverize (Lurcher - Pulverize)
    [5349] = { duration = 433 }, -- Stagger (Ogre - Shockwave)
    [49405] = { duration = 433 }, -- Rear Up (Mantikora)
    [76133] = { duration = 433 }, -- Stumble Forward (Flesh Colossus - Blocked)
    [65755] = { duration = 600 }, -- Staggered (Flesh Colossus - Block Pin)
    [68826] = { duration = 600 }, -- Staggered (Flesh Colossus - Block Sweep)
    [74794] = { duration = 433 }, -- Black Winter (Harvester)
    [32023] = { duration = 433 }, -- Generic Stagger Enemy (Bloodfiend)
    [17206] = { duration = 433 }, -- Bone Saw (Bone Colossus)
    [45576] = { duration = 433 }, -- Generic Stagger Enemy (Werewolf)
    [69157] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Retaliation (Winterborn Warrior)
    [69153] = { duration = 1000 }, -- Retaliation (Winterborn Warrior)
    [54050] = { duration = 500 }, -- Divine Leap Stun (Vosh Rakh Devoted)
    [77927] = { duration = 433 }, -- Staggered (Bodyguard) (DB DLC)
    [74483] = { duration = 1000 }, -- Fiery Grip (Sentinel) (TG DLC)
    [35115] = { duration = 1000 }, -- Pull (Extended Chains) (Cyrodiil Guard T2)
    [47020] = { duration = 1000 }, -- Pull (Puncturing Chains) (Cyrodiil Guard T2)

    -- Quest
    [144339] = { duration = 433 }, -- Staggered (Prince Boar) - A Foe Most Porcine
    [84284] = { duration = 433 }, -- Coursing Bones (Oskana)
    [84197] = { duration = 433 }, -- Marsh Masher (Gathongor the Mauler)
    [83161] = { duration = 433 }, -- Stone Crusher (Thodundor of the Hill)
    [83141] = { duration = 433 }, -- Ground Shock (Thodundor of the Hill)

    --[[
    [64322] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [72479] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [75463] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433}, -- Magma Diver (The King's Gambit - Shield-Wife Razbela)
    [67156] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Kindlepitch Slick', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    [70543] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Oil Fire', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    ]]
    --

    -- Vvardenfell
    [86576] = { duration = 433 }, -- Renduril the Hammer (Nchuleftingth)
    [88510] = { duration = 433 }, -- Staggered (Vvardenfell -- Ancestral Adversity)

    -- Elsweyr
    [121476] = { duration = 433 }, -- Devastating Leap (Bone Flayer) (Bright Moons, Warm Sands)

    -- On Target
    [86310] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 500 }, -- Stagger (Player Blocks charged NPC attack)
    [21972] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 500 }, -- Stagger (Player interrupts NPC cast)

    -- Dragonstar Arena
    [53290] = { icon = "esoui/art/icons/ability_debuff_stagger.dds", name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Sovngarde Icemage)

    -- Maelstrom Arena
    [72012] = { duration = 700 }, -- Stagger (Iceberg)
    [71938] = { duration = 600 }, -- Frost Nova (Huntsman Chillbane)
    [72750] = { duration = 433 }, -- Freezing Stomp (Matriarch Runa)

    -----------------
    -- Dungeons -----
    -----------------

    -- Elden Hollow I
    [44093] = { duration = 433 }, -- Battlecry (Akash gra-Mal)
    [44092] = { duration = 433 }, -- Generic Stagger Enemy (Chokethorn)

    -- City of Ash I
    [44090] = { duration = 433 }, -- Generic Stagger Enemy (Infernal Guardian)
    [44089] = { duration = 433 }, -- Generic Stagger Enemy (Infernal Guardian)

    -- City of Ash II
    [55657] = { duration = 433 }, -- Venomous Explosion (Venomous Skeleton)
    [56264] = { duration = 500 }, -- Stagger (Horvantud the Fire Maw)
    [54221] = { duration = 500 }, -- Monstrous Cleave (Ash Titan)
    [54859] = { duration = 500 }, -- Stagger (Ash Titan)
    [56551] = { duration = 433 }, -- Lava Quake (Valkyn Skoria)

    -- Tempest Island
    [46737] = { duration = 433 }, -- Piercing Shriek (Sonolia the Matriarch)
    [46808] = { duration = 100 }, -- Stagger (Twister)

    -- Crypt of Hearts II
    [53403] = { duration = 433 }, -- Thunder Fist (Ilambris Amalgam)
    [51543] = { duration = 433 }, -- Necrotic Blast (Nerien'eth)
    [51867] = { duration = 567 }, -- Force Pulse (Nerien'eth)
    [52494] = { duration = 567 }, -- Ebony Whirlwind (Nerien'eth)

    -- Frostvault
    [117291] = { duration = 433 }, -- Stagger (Coldsnap Ogre)
    [109810] = { duration = 600 }, -- Frozen Aura (Icestalker)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Ground Damaging Effect Auras - We use EffectOverride to pull information for these unlike the other tables above.
-- duration = duration of the effect
-- type = BUFF_EFFECT_TYPE_BUFF or BUFF_EFFECT_TYPE_DEBUFF
-- merge = Simple merge functionality for id's - these will be considered the same ID so as not to display multiple auras (for effects that have consecutive hits with different id's like Pestilent Colossus)
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddGroundDamageAura =
{

    --------------------
    -- PLAYER
    --------------------

    -- Siege
    [104693] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Meatbag Catapult
    [104695] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Scattershot Catapult

    -- Sets
    [59591] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Bogdan Totem (Bogdan the Nightflame)
    [97883] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Domihaus (Domihaus)
    [97899] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Domihaus (Domihaus)
    [97857] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Earthgore (Earthgore)
    [84502] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Grothdarr (Grothdarr)
    [80526] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ilambris
    [81038] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Sentinel of Rkugamz
    [59498] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spawn of Mephala
    [80522] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stormfist
    [102094] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Thurvokun
    [75692] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Bahraha's Curse
    [97539] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Draugr's Rest
    [67204] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Leeching Plate (of Leeching)
    [133494] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Aegis Caller (Aegis Caller's)
    [135658] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Winter's Respite (of Winter's Respite)

    -- Dragonknight
    [28995] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dragonknight Standard
    [32960] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shifting Standard
    [32964] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shifting Standard
    [32948] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Standard of Might

    [61772] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Ash Cloud (Ash Cloud)
    [34791] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Cinder Storm (Cinder Storm)
    [32711] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Eruption (Eruption)

    -- Nightblade
    [36052] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Twisting Path (Twisting Path)
    [64006] = { duration = 2000, type = BUFF_EFFECT_TYPE_BUFF }, -- Refreshing Path (Refreshing Path)
    [36490] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Veil of Blades (Veil of Blades)

    -- Sorcerer
    [23189] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Splash (Lightning Splash)
    [23202] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Liquid Lightning (Liquid Lightning)
    [23208] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Flood (Lightning Flood)
    [80435] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Suppression Field (Suppression Field)
    [80405] = { duration = 600, type = BUFF_EFFECT_TYPE_BUFF }, -- Absorption Field (Absorption Field)

    -- Templar
    [95931] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spear Shards
    [95955] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Luminous Shards
    [26879] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blazing Spear

    [26286] = { duration = 2100, type = BUFF_EFFECT_TYPE_BUFF }, -- Healing Ritual (Cleansing Ritual)
    [80172] = { duration = 2100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ritual of Retribution
    [26303] = { duration = 2100, type = BUFF_EFFECT_TYPE_BUFF }, -- Extended Ritual

    [112145] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Rune Focus (Rune Focus)
    [112166] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Channeled focus (Channeled Focus)
    [112167] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Rune Focus Circle Bonus (Restoring Focus)

    [22225] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Rite of Passage
    [22231] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Remembrance
    [22228] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Practiced Incantation

    [21753] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Nova
    [21756] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Solar Prison
    [21759] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Solar Disturbance

    -- Warden
    [130406] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Arctic Blast (Arctic Blast)

    [129434] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Budding Seeds (Budding Seeds)

    [85534] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Secluded Grove (Secluded Grove)
    [88747] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Enchanted Forest (Enchanted Forest)
    [88783] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Impaling Shards (Impaling Shards)
    [88791] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Gripping Shards (Gripping Shards)
    [88802] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Winter's Revenge (Winter's Revenge)

    [86247] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Sleet Storm (Sleet Storm)
    [88860] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Northern Storm (Northern Storm)
    [88863] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Permafrost (Permafrost)

    -- Necromancer
    [115254] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Boneyard (Boneyard)
    [117809] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unnerving Boneyard (Unnerving Boneyard)
    [117854] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Avid Boneyard (Avid Boneyard)

    [116410] = { duration = 500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shocking Siphon (Shocking Siphon)
    [118766] = { duration = 500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Detonating Siphon (Detonating Siphon)
    [118011] = { duration = 500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Mystic Siphon (Mystic Siphon)

    [122178] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frozen Colossus (Frozen Colossus)
    [122399] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 2 }, -- Pestilent Colossus (Pestilent Colossus)
    [122400] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 2 }, -- Pestilent Colossus (Pestilent Colossus)
    [122401] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 2 }, -- Pestilent Colossus (Pestilent Colossus)
    [122392] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Glacial Colossus (Glacial Colossus)

    [118289] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ravenous Goliath (Ravenous Goliath)

    [115385] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Life amid Death (Life amid Death)
    [118021] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Renewing Undeath (Renewing Undeath)
    [118813] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Enduring Undeath (Enduring Undeath)

    -- Two-Handed
    [126474] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stampede (Stampede)

    -- Bow
    [28877] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Volley)
    [38690] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Endless Hail (Endless Hail)
    [38696] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Arrow Barrage (Arrow Barrage)

    -- Destruction Staff
    [62896] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Fire
    [62971] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Storms
    [62931] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Frost
    [39054] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Fire
    [39079] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Storms
    [39071] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Frost
    [62912] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Fire
    [62990] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Storms
    [62951] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Frost

    [83626] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Fire Storm
    [83631] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Thunder Storm
    [83629] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Ice Storm
    [85127] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Fiery Rage
    [85131] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Thunderous Rage
    [85129] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Icy Rage
    [83683] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Flame
    [83687] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Lightning
    [83685] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Frost

    -- Restoration Staff
    [28386] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Grand Healing
    [40059] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Illustrious Healing
    [40061] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Healing Springs

    -- Fighters Guild
    [80293] = { duration = 600, type = BUFF_EFFECT_TYPE_BUFF }, -- Ring of Preservation (Ring of Preservation)

    -- Mages Guild
    [63429] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Meteor (Meteor)
    [63454] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ice Comet (Ice Comet)
    [63471] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shooting Star (Shooting Star)

    -- Undaunted
    [39299] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Orb (Necrotic Orb)
    [42029] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Mystic Orb (Mystic Orb)
    [42039] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Energy Orb (Energy Orb)

    -- Vampire
    [38935] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Swarming Scion

    -- Assault
    [38561] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Caltrops (Caltrops)
    [40267] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40252] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Razor Caltrops (Razor Caltrops)

    -- Volendrung
    [116669] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ebony Cyclone (Ruinous Cyclone)

    --------------------
    -- TRAPS
    --------------------

    [17314] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Trap (Player)

    [72888] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Attack 2 (Fire) -- Banished Cells II

    [33594] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire (Fire) -- Throne of the Wilderking

    [27940] = { duration = 350, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Laser Damage (Generic Flame Wave Shooter) -- Stros M'Kai
    [32245] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Searing Steam (Steam Trap) -- Stros M'Kai

    [26040] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Steam Blast (Steam Vent) -- Volenfell
    [26089] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Steam Blast (Steam Vent) -- Volenfell
    [26091] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Steam Blast (Steam Vent) -- Volenfell
    [26077] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Steam Blast (Steam Vent) -- Volenfell

    [110416] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Putrid Cloud (Gas Blossom) -- Housing
    [110542] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stunted Current (Static Pitcher) -- Housing

    --------------------
    -- NPC
    --------------------

    -- Cyrodiil
    [7883] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Guardian Storm (Cyrodiil Mage)
    [46819] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Storm Damage (Cyrodiil Mage)
    [52866] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Cyrodiil Archer)
    [54258] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Upgraded Volley (Cyrodiil Archer)
    [70414] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Cyrodiil Archer)

    -- Human
    [38125] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Caltrops  (Faction NPCs)
    [14068] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Archer Synergy)
    [10813] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Mage Synergy)
    [38260] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Mage Synergy)
    [28629] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Archer)
    [47102] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Rune (Fire Mage)
    [37131] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ice Cage (Battlemage)
    [44228] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dragonknight Standard (Dragonknight - NPC)

    [76624] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Voidbringer)
    [76728] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Voidbringer)

    [88330] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Masquer)
    [88334] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Masquer)

    [84837] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Broken Pact (Skaafin Witchling)

    -- Animal
    [16698] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poisonbloom (Netch)
    [90778] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Pool (Nix-Ox)
    [90815] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Pool (Nix-Ox)
    [85421] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Retch (Cliff Strider)

    -- Insect
    [13680] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Blood (Assassin Beetle)
    [5265] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burning Ground (Shalk)
    [72794] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Toxic Pool (Haj Mota)
    [87126] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Heat Vents (Fetcherfly Nest)

    -- Monsters
    [4769] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Choking Pollen (Lurcher)
    [16040] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Hurricane (Nereid)
    [75928] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Elemental Pool (Minotaur)
    [75953] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Brimstone Hailfire (Minotaur Shaman)
    [75976] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pillar of Nirn (Minotaur Shaman)
    [8628] = { duration = 800, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Charged Ground (Harpy)
    [103862] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Deluge (Yaghra Spewer)
    [103992] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Luminescent Burn (Yaghra Spewer)

    -- Daedra
    [9749] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Envelop (Banekin)
    [91938] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burst of Embers (Daedroth)
    [51645] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frozen Ground (Frost Atronach)
    [6162] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Rain of Fire (Scamp)
    [88323] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blast Furnace (Iron Atronach)
    [73437] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Flame (Daedric Titan)
    [53233] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Miasma Pool (Flesh Colossus)

    -- Undead
    [20812] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Ground (Lich)
    [73929] = { duration = 1000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Cage (Lich)
    [73937] = { duration = 1000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Cage (Lich)
    [69950] = { duration = 2100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Desecrated Ground (Desecrated Ground - Undead Synergy)

    -- Dwemer
    [19997] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Static Field (Dwemer Spider)

    [91094] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)
    [91095] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)
    [91096] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)

    ------------------
    -- WORLD BOSSES --
    ------------------

    -- Auridon
    [84045] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Seal of Defilement (Quenyas)

    -- Greenshade
    [84206] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stinging Sputum (Gathongor the Mauler)

    -- Stormhaven
    [84160] = { duration = 2100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spit Poison (Old Widow Silk)
    [83000] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Crabuchet (Titanclaw)

    ------------------
    -- QUESTS --------
    ------------------

    -- Elsweyr
    [121644] = { duration = 800, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Ground (Euraxian Necromancer) (Bright Moons, Warm Sands)

    -- Summerset

    ------------------
    -- ARENAS --------
    ------------------

    -- Dragonstar Arena
    [53314] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Flame Volley (Sovngarde Ranger)
    [53280] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Frost (Sovngarde Icemage)

    [53341] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Biting Cold (Biting Cold)
    [60421] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Biting Cold (Biting Cold)

    [83498] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poisonous Cloud (Poison Cloud)
    [53625] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Flood (Nak'tah)
    [54080] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Cinder Storm (Earthen Heart Knight)
    [52903] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Standard of Might (Anal'a Tu'wha)
    [83468] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Restoring Nature (Nature's Blessing)
    [52933] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Solar Disturbance (Shadow Knight)
    [55086] = { duration = 1700, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poison Mist (Vampire Lord Thisa)
    [55092] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Devouring Swarm (Vampire Lord Thisa)
    [55182] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Marked for Death (Hiath the Battlemaster)

    -- Maelstrom Arena
    [68197] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Essence (Necrotic Orb)
    [70901] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Grave (Maxus the Many)
    [72149] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Grave (Maxus the Many)

    [69101] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shock (Generator)
    [66797] = { duration = 333, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spinning Blade (Blade Trap)
    [69102] = { duration = 600, type = BUFF_EFFECT_TYPE_BUFF }, -- Heal (Generator)
    [69316] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Electric Shield (Centurion Champion)

    [67871] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shock (Water)
    [67758] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Queen's Poison (Lamia Queen)
    [68358] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Queen's Radiance (Lamia Queen)
    [72159] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Static Field (Dwarven Spider)
    [70860] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Overheated Flame (The Control Guardian)

    [72525] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frigid Waters (Player)
    [67808] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frigid Waters (Player)

    ------------------
    -- DUNGEONS ------
    ------------------

    -- Banished Cells I
    [19027] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dead Zone (Skeletal Destroyer)
    [33188] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)

    -- Banished Cells II
    [28904] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Immolating Bite (Maw of the Infernal)
    [31727] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Corruption (Daedric Chaos)
    [48800] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)
    [48815] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)

    -- Elden Hollow I
    [42601] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Circle (Canonreeve Oraneth)

    -- Elden Hollow II
    [32972] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Consuming Shadow (Murklight)
    [33050] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Eclipse (Murklight)
    [33103] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spout Shadow (The Shadow Guard)
    [33434] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Flame (Bogdan the Nightflame)

    -- City of Ash I
    [34960] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blazing Fire (Warden of the Shrine)
    [34204] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burning Field

    -- City of Ash II
    [56415] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Runes (Urata the Legion)
    [56151] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ethereal Flame (Ash Titan)

    -- Tempest Island
    [26619] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shock (Sudden Storm)
    [6108] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Storm
    [26752] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Enervating Stone (Stormfist)

    -- Selene's Web
    [30908] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon Primal Swarm (Treethane Kerninn)
    [30773] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Arrow Rain (Longclaw)
    [31150] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poison Burst (Longclaw)

    -- Spindleclutch II
    [27603] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blood Pool (Urvan Veleth)
    [27906] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blood Pool (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [25591] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Essence (Necrotic Orb)

    -- Wayrest Sewers II
    [36625] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Scourging Spark (Malubeth the Scourger)
    [36869] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Scorching Flames (Uulgarg the Risen)

    -- Crypt of Hearts I
    [22716] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Ritual (Archmaster Siniel)
    [46950] = { duration = 900, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Trail (Death's Leviathan)
    [22432] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Electric Prison (Ilambris-Athor)
    [22388] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Rain Fire (Ilambris-Zaven)

    -- Crypt of Hearts II
    [51883] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Creeping Storm (Creeping Storm)
    [52286] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 3 }, -- Rain Fire (Ilambris-Zaven)
    [52335] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 3 }, -- Rain Fire (Ilambris-Zaven)
    [52082] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Cursed Ground (Nerien'eth)
    [53157] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Cursed Ground (Nerien'eth)
    [53134] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Tortured Souls (Nerien'eth)

    -- Volenfell
    [25143] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burning Ground (Quintus Verres)
}
