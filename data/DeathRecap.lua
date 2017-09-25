------------------
-- Death Recap namespace
LUIE.DeathRecap = {}

local DR = LUIE.DeathRecap

-- Player ability death recaps, these all use Name + Icon detection for replacement
DR.DeathRecapPlayerBasic = {
    
    -- BASIC
    ['Bash'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_bash.dds' }, -- Bash (Innate)
    
    -- CHAMPION
    ['Riposte'] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_riposte.dds'}, -- Riposte (Champion)
    
    -- WEAPON ATTACKS
    ['Heavy Attack (Dual Wield)'] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = 'Heavy Attack'}, -- Heavy Attack (Melee)
    ['Heavy Attack (Shock)'] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds' },
    ['Shock Pulse'] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavypulse.dds', name = 'Heavy Attack (Shock Pulse)'}, -- Shock Pulse
    ['Shock'] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', name = 'Tri Focus (Shock)'}, -- Tri-Focus
    ['Twin Blade and Blunt Bleed'] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = 'Twin Blade and Blunt' }, -- Twin Blade and Blunt Bleed
    ['Heavy Weapons Bleed'] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = 'Heavy Weapons' }, -- Heavy Weapons Bleed
    ['Forceful'] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds' }, -- Forceful
    
    -- PASSIVES
    ['Burning Light'] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds'}, -- Burning Light
    ['Implosion'] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds'}, -- Implosion
    ['Soul Shatter'] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }, -- Soul Shatter
    
    -- GLYPHS
    ['Life Drain'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds', name = 'Life Drain Enchantment' }, -- Glyph of Absorb Health
    ['Absorb Magicka'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds', name = 'Absorb Magicka Enchantment' }, -- Glyph of Absorb Magicka
    ['Absorb Stamina'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds', name = 'Absorb Stamina Enchantment' }, -- Glyph of Absorb Stamina
    ['Damage Health'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_decrease_health.dds', name = 'Decrease Health Enchantment' }, -- Glyph of Decrease Health
    ['Fiery Weapon'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_flame.dds', name = 'Fiery Weapon Enchantment' }, -- Glyph of Flame
    ['Befouled Weapon'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_foulness.dds', name = 'Befouled Weapon Enchantment' }, -- Glyph of Foulness
    ['Frozen Weapon'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_frost.dds', name = 'Frozen Weapon Enchantment' }, -- Glyph of Frost
    ['Poisoned Weapon'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_poison.dds', name = 'Poisoned Weapon Enchantment' }, -- Glyph of Poison
    ['Prismatic Weapon'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_prismatic.dds', name = 'Prismatic Weapon Enchantment' }, -- Glyph of Prismatic Onslaught
    ['Charged Weapon'] = { icon = 'LuiExtended/media/icons/glyphs/glyph_shock.dds', name = 'Charged Weapon Enchantment' }, -- Glyph of Shock
    
    -- STATUS EFFECTS
    ['Burning'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_burning.dds' }, -- Burning (Fire Status Effect)
    ['Diseased'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds' }, -- Diseased (Disease Status Effect)
    ['Chill'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds' }, -- Chill (Frost Status Effect)
    ['Poisoned'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_poisoned.dds' }, -- Poisoned (Poison Status Effect)
    ['Concussion'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds' }, -- Concussion (Shock Status Effect)
    
    -- WEAPON SETS
    ['Merciless Charge'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_merciless_charge.dds' }, -- Merciless Charge (Maelstrom 2H)
    
    -- MONSTER HELMS
    ['Domihaus'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds' }, -- Domihaus (Domihaus) -- Unfortunately both use the same icon so we can't make separate icons for damage type
    ['Grothdarr'] = { icon = 'esoui/art/icons/achievement_update11_dungeons_033.dds' }, -- Grothdarr (Grothdarr)
    ['Iceheart'] = { icon = 'esoui/art/icons/achievement_wrothgar_042.dds' }, -- Iceheart (Iceheart)
    ['Infernal Guardian'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_infernal_guardian.dds' }, -- Infernal Guardian (Infernal Guardian)
    ['Kra\'gh'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_kragh.dds' }, -- Kra'gh (Kra'gh)
    ['Scourge Harvest'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = 'Malubeth the Scourger' }, -- Scourge Harvest (Malubeth)
    ['Jagged Claw'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_maw_of_the_infernal.dds'}, -- Jagged Claw (Maw of the Infernal)
    ['Fiery Jaws'] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds'}, -- Fiery Jaws (Maw of the Infernal)
    ['Lich Crystal'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_nerieneth.dds', name = 'Nerien\'eth' }, -- Lich Crystal (Nerien'eth)
    ['Selene'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_selene.dds' }, -- Selene (Selene)
    ['Sellistrix'] = { icon = 'esoui/art/icons/achievement_thievesguild_021.dds' }, -- Sellistrix (Sellistrix)
    ['Shadowrend'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_headbutt.dds', name = 'Headbutt' }, -- Shadowrend (Shadowrend)
    ['Mephala\'s Web'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = 'Spawn of Mephala' }, -- Mephala's Web (Spawn of Mephala)
    ['Stormfist'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds' }, -- Stormfist (Stormfist)
    ['Tremorscale'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds' }, -- Tremorscale
    ['Valkyn Skoria'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_valkyn_skoria.dds' }, -- Valkyn Skoria
    ['Velidreth'] = { icon = 'esoui/art/icons/achievement_update11_dungeons_035.dds' }, -- Velidreth
    
    -- CRAFTED SETS
    ['Ashen Grip'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ashen_grip.dds' }, -- Ashen Grip
    ['Eternal Hunt'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds' }, -- Eternal Hunt
    ['Song of Lamae'] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Song of Lamae
    
    
    
}

DR.DeathRecapPlayerAdvanced = {
    -- WEAPON ATTACKS
    ['Light Attack'] =              {
                                    ['/esoui/art/icons/death_recap_melee_basic.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds'}, -- Light Attack (Melee)
                                    ['/esoui/art/icons/death_recap_ranged_basic.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds'}, -- Light Attack (Bow)
                                    ['/esoui/art/icons/death_recap_magic_ranged.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attacklight.dds'}, -- Light Attack (Restoration Staff)
                                    ['/esoui/art/icons/death_recap_shock_ranged.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attacklight.dds' }, -- Light Attack (Lightning Staff)
                                    ['/esoui/art/icons/death_recap_fire_ranged.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attacklight.dds' }, -- Light Attack (Flame Staff)
                                    ['/esoui/art/icons/death_recap_cold_ranged.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attacklight.dds' }, -- Light Attack (Frost Staff)
                                    },
    ['Heavy Attack'] =              {
                                    ['/esoui/art/icons/death_recap_melee_basic.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds'}, -- Heavy Attack (Melee)
                                    ['/esoui/art/icons/death_recap_ranged_basic.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackheavy.dds'}, -- Heavy Attack (Bow)
                                    ['/esoui/art/icons/death_recap_magic_ranged.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds'}, -- Heavy Attack (Restoration Staff)
                                    ['/esoui/art/icons/death_recap_fire_ranged.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackheavy.dds' }, -- Heavy Attack (Flame Staff)
                                    ['/esoui/art/icons/death_recap_cold_ranged.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackheavy.dds' }, -- Heavy Attack (Frost Staff)
                                    },
                                    
    -- POISONS
    ['Ravage Health'] =             {
                                    ['/esoui/art/icons/crafting_poison_001_red_005.dds'] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds' }, -- Ravage Health
                                    ['/esoui/art/icons/death_recap_poison_melee.dds'] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds' }, -- Ravage Health
                                    },
    ['Drain Health'] =              {
                                    ['/esoui/art/icons/crafting_poison_002_red_005.dds'] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds' }, -- Drain Health
                                    ['/esoui/art/icons/crafting_poison_002_orange_005.dds'] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', name = 'Creeping Drain Health' }, -- Drain Health
                                    },
    ['Creeping Drain Health'] =     {
                                    ['/esoui/art/icons/crafting_poison_002_orange_005.dds'] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds'}, -- Creeping Drain Health
                                    },
    ['Creeping Ravage Health'] =    {
                                    ['/esoui/art/icons/crafting_poison_001_orange_005.dds'] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds' }, -- Creeping Ravage Health
                                    ['/esoui/art/icons/death_recap_poison_melee.dds'] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds' }, -- Creeping Ravage Health
                                    },
    
    -- ITEM SETS
    ['Ilambris'] =                  {
                                    ['/esoui/art/icons/death_recap_shock_aoe.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_ilambris_shock.dds' }, -- Ilambris (Ilambris)
                                    ['/esoui/art/icons/death_recap_fire_aoe.dds'] = { icon = 'esoui/art/icons/ava_siege_ui_002.dds' }, -- Ilambris (Ilambris)
                                    },
    ['Fiery Breath'] =              {
                                    ['/esoui/art/icons/death_recap_fire_aoe.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'}, -- Fiery Breath (Maw of the Infernal)
                                    },
}

-- For basic icon or name replacements, when the relevant ability icon/name can be bulk replaced by name
DR.DeathRecapBasicOverride = {

    -- HUMAN NPCS
    ['Quick Strike'] =          { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Shared NPC)
    ['Quick Shot'] =            { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds' }, -- Quick Shot (Shared NPC)
    ['Ice Arrow'] =             { icon = 'esoui/art/icons/ability_mage_009.dds' }, -- Ice Arrow (Shared NPC)
    ['Flare'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds'}, -- Flare (Shared NPC)
    ['Bear Trap'] =             { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }, -- Bear Trap (Shared NPC)
    ['Ignite'] =                { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy)

    ['Uppercut'] =              { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = 'Dizzying Swing' }, -- Uppercut (Ravager)
    ['Assassinate'] =           { icon = 'esoui/art/icons/ability_rogue_063.dds' }, -- Assassinate (Rogue/Skirmisher)
    ['Heavy Attack'] =          { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Footsoldier)
    ['Throw Dagger'] =          { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds' }, -- Throw Dagger (Footsoldier)
    ['Power Bash'] =            { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Guard)
    ['Charge'] =                { icon = 'esoui/art/icons/ability_warrior_011.dds', name = 'Focused Charge' }, -- Charge (Brute)
    ['Blood Craze'] =           { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    ['Thunder Hammer'] =        { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul)
    ['Shock Aura'] =            { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_aura.dds' }, -- Shock Aura (Thundermaul)
    ['Lightning Form'] =        { icon = 'esoui/art/icons/ability_sorcerer_lightning_form.dds' }, -- Lightning Form (Thundermaul)
    ['Soul Tether'] =           { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Nightblade)
    ['Dark Talons'] =           { icon = 'esoui/art/icons/ability_dragonknight_010.dds' }, -- Dark Talons (Dragonknight)
    ['Blink Strike'] =          { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)
    ['Taking Aim'] =            { icon = 'LuiExtended/media/icons/abilities/ability_weapon_taking_aim.dds' }, -- Taking Aim (Archer)
    ['Trap Beast'] =            { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = 'Lightweight Beast Trap' }, -- Trap Beast (Pet Ranger)
    ['Heat Wave'] =             { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Fire Mage)
    ['Fire Rune'] =             { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_runes.dds', name = 'Fire Runes' }, -- Fire Rune (Fire Mage)
    ['Shock'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_ranged.dds'} , -- Shock (Storm Mage)
    ['Thunder Thrall'] =        { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_thrall.dds' }, -- Thunder Thrall (Storm Mage)
    ['Winter\'s Reach'] =       { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    ['Burden'] =                { icon = 'esoui/art/icons/ability_mage_004.dds' }, -- Burden (Spirit Mage)
    ['Lightning Onslaught'] =   { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
    ['Ice Cage'] =              { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds' }, -- Ice Cage (Battlemage)
    ['Entropic Flare'] =        { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds' }, -- Entropic Flare (Timb Bomb Mage)
    ['Void'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds' }, -- Void (Time Bomb Mage)
    ['Fright Force'] =          { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force.dds' }, -- Fright Force (Fear Mage)
    ['Aspect of Terror'] =      { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror.dds' }, -- Aspect of Terror (Fear Mage)
    ['Corrode'] =               { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds' }, -- Corrode (Dreadweaver)
    ['Necrotic Spear'] =        { icon = 'esoui/art/icons/ability_mage_027.dds'}, -- Necrotic Spear (Necromancer)
    ['Entropic Bolt'] =         { icon = 'LuiExtended/media/icons/abilities/ability_mage_entropic_bolt.dds' }, -- Entropic Bolt (Bonelord)
    ['Bone Cage'] =             { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Bone Cage (Bonelord)
    ['Minor Wound'] =           { icon = 'LuiExtended/media/icons/abilities/ability_templar_minor_wound.dds' }, -- Minor Wound (Healer)
    ['Coiled Lash'] =           { icon = 'LuiExtended/media/icons/abilities/ability_healer_coiled_lash.dds', }, -- Coiled Lash (Shaman)
    ['Caltrops'] =              { icon = 'esoui/art/icons/ability_ava_001.dds' }, -- Caltrops (Faction NPC)
    ['Heavy Strike'] =          { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = 'Heavy Attack' }, -- Heavy Strike (Winterborn Warrior)
    ['Javelin'] =               { icon = 'LuiExtended/media/icons/abilities/ability_warrior_javelin.dds'}, -- Javelin (Winterborn Warrior)
    ['Retaliation'] =           { icon = 'esoui/art/icons/ability_warrior_014.dds' }, -- Retaliation (Winterborn Warrior)
    ['Grasping Vines'] =        { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (Winterborn Mage)
    ['Grasping Vineburst'] =    { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vineburst.dds' }, -- Grasping Vineburst (Winterborn Mage)
    ['Flames'] =                { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds' }, -- Flames (Winterborn Mage)
    ['Divine Leap'] =           { icon = 'esoui/art/icons/ability_warrior_032.dds' }, -- Divine Leap (Vosh Rakh Devoted)
    ['Cleave Stance'] =         { icon = 'esoui/art/icons/ability_warrior_016.dds', name = 'Great Cleave' }, -- Cleave Stance (Dremora Caitiff)
    ['Fiery Grip'] =            { icon = 'esoui/art/icons/ability_dragonknight_005.dds' }, -- Fiery Grip (Sentinel) (TG DLC)
    ['Flare Trap'] =            { icon = 'LuiExtended/media/icons/abilities/ability_trap_flare_trap.dds' }, -- Flare Trap (Archer) (TG DLC)
    ['Snipe'] =                 { icon = 'esoui/art/icons/ability_bow_001.dds' }, -- Snipe (Archer) (TG DLC)
    ['Poisoned Arrow'] =        { icon = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds' }, -- Poisoned Arrow (Archer) (TG DLC)
    ['Shard Shield'] =          { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds' }, -- Shard Shield (Bodyguard) (DB DLC)
    ['Shield Charge'] =         { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Bodyguard) (DB DLC)
    
    -- ANIMALS
    ['Crushing Swipe'] =        { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Crushing Swipe (Bear)
    ['Savage Blows'] =          { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }, -- Savage Blows (Bear)
    ['Savage Blows Bleeding'] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds', name = 'Savage Blows' }, -- Savage Blows (Bear)
    
    ['Shocking Rake'] =         { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Dreugh)
    
    ['Tusks'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_echatere_tusks.dds' }, -- Tusks (Echatere)
    
    ['Lash'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }, -- Lash (Giant Snake)
    ['Kiss of Poison'] =        { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds' }, -- Kiss of Poison (Giant Snake)
    
    ['Dive'] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds' }, -- Dive (Guar)
    
    ['Chomp'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }, -- Chomp (Kagouti)
    ['Toss'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }, -- Toss (Kagouti)
    
    ['Vigorous Swipe'] =        { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_vigorous_swipes.dds', name = 'Vigorous Swipes' }, -- Vigorous Swipe (Mammoth)
    
    ['Scrape'] =                { icon = 'LuiExtended/media/icons/abilities/ability_bat_scrape.dds' }, -- Scrape (Giant Bat)
    ['Screech'] =               { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    ['Draining Bite'] =         { icon = 'LuiExtended/media/icons/abilities/ability_bat_draining_bite.dds' }, -- Draining Bite (Giant Bat)
    
    ['Pincer'] =                { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_pincer.dds' }, -- Pincer (Mudcrab)
    ['Double Claw Strike'] =    { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }, -- Double Claw Strike (Mudcrab)
    ['Unforgiving Claws'] =     { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }, -- Unforgiving Claws (Mudcrab)
    
    ['Thrust'] =                { icon = 'LuiExtended/media/icons/abilities/ability_netch_thrust.dds' }, -- Thrust (Netch)
    ['Poisonbloom'] =           { icon = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds' }, -- Poisonbloom (Netch)
    
    ['Leech'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }, -- Leech (Nix-Hound)
    ['Dampworm'] =              { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }, -- Dampworm (Nix-Hound)
    
    ['Repulsion Shock'] =       { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds' }, -- Repulsion Shock (Wamasu)
    
    ['Rear Kick'] =             { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }, -- Rear Kick (Welwa)
    
    ['Rotbone'] =               { icon = 'LuiExtended/media/icons/abilities/ability_wolf_rotbone.dds' }, -- Rotbone (Wolf)
    ['Helljoint'] =             { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds' }, -- Helljoint (Wolf)
    
    ['Horn Strike'] =           { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }, -- Horn Strike (Haj Mota)
    ['Toxic Mucus'] =           { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds'}, -- Toxic Mucus (Haj Mota)
    ['Toxic Pool'] =            { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_slime.dds'}, -- Toxic Pool (Haj Mota)
    ['Bog Burst'] =             { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    ['Shockwave'] =             { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Shockwave (Haj Mota)
    
    ['Nip'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds' }, -- Nip (Dire Wolf)
    ['Gnash'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Dire Wolf)
    
    -- INSECTS
    ['Feast'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_feast.dds' }, -- Feast (Assassin Beetle)
    ['Acid Blood'] =            { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_poison.dds' }, -- Acid Blood (Assassin Beetle)
    
    ['Blurred Strike'] =        { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }, -- Blurred Strike (Giant Scorpion)
    ['Paralyze'] =              { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds' }, -- Paralyze (Giant Scorpion)
    
    ['Spit'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds' }, -- Spit (Giant Spider)
    
    ['Poisonous Burst'] =       { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Poisonous Burst (Giant Spider)
    ['Corrosive Bite'] =        { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds' }, -- Corrosive Bite (Giant Spider)
    ['Poison Spray'] =          { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }, -- Poison Spray (Giant Spider)
    
    ['Sting'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_wasp_sting.dds' }, -- Sting (Giant Wasp)
    ['Inject Larva'] =          { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds' }, -- Inject Larva (Giant Wasp)
    ['Larva Burst'] =           { icon = 'LuiExtended/media/icons/abilities/ability_wasp_larva_burst.dds' }, -- Larva Burst (Giant Wasp)
    
    ['Bloodletting'] =          { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }, -- Bloodletting (Hoarvor)
    ['Latch On'] =              { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds' }, -- Latch On (Hoarvor)
    
    ['Vile Bite'] =             { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds' }, -- Vile Bite (Hoarvor DLC)
    ['Vile Bite Poison'] =      { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds', name = 'Vile Bite' }, -- Vile Bite Poison (Hoarvor DLC)
    ['Fevered Retch'] =         { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds' }, -- Fevered Retch (Hoarvor DLC)
    ['Infectious Swarm'] =      { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    ['Necrotic Explosion'] =    { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds' }, -- Necrotic Explosion (Hoarvor DLC)
    
    ['Pounce'] =                { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_pounce.dds' }, -- Pounce (Kwama Worker)
    
    ['Excavation'] =            { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds' }, -- Excavation -- Kwama Warrior
    
    ['Fire Bite'] =             { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds' }, -- Fire Bite (Shalk)
    ['Burning Ground'] =        { icon = 'LuiExtended/media/icons/abilities/ability_shalk_burning_ground.dds' }, -- Burning Ground (Shalk)
    
    ['Thunder Bite'] =          { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunder_bite.dds' }, -- Thunder Bite (Thunderbug)
    ['Thunderstrikes'] =        { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunderstrikes.dds' }, -- Thunderstrikes (Thunderbug)
    
    ['Vile Spit'] =             { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds' }, -- Vile Spit (Kotu Gava Broodmother)
    ['Swarmburst'] =            { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarmburst (Kotu Gava Broodmother) 
    
    -- DAEDRA
    ['Tornado'] =               { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_tornado.dds' }, -- Tornado (Air Atronach)
    ['Flame Tornado'] =         { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }, -- Flame Tornado (Air Atronach - Flame)
    ['Lightning Rod'] =         { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds' }, -- Lightning Rod (Air Atronach - Storm)
    ['Ice Vortex'] =            { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds'}, -- Ice Vortex (Air Atronach - Frost)
    
    ['Body Slam'] =             { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds' }, -- Body Slam (Ogrim)
    
    -- MONSTERS
    ['Blood in the Water'] =    { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds', name = 'Assault' }, -- Blood in the Water (Ice Wraith)
    
    -- TRAPS
    ['Charge-Wire Shock'] =     { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }, -- Dwarven Charge-Wire (Nchuleftingth)
    ['Lava'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds' }, -- Lava
    ['In Lava'] =               { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = 'Lava' }, -- Lava
    
    -- MAIN QUEST
    ['Attack'] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = 'Light Attack' }, -- Light Attack
    ['Pound'] =             { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }, -- Pound (Feral Soul Shriven)
    ['Vomit'] =             { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Feral Soul Shriven)
    ['Bone Saw'] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds' }, -- Bone Saw (Bone Colossus)
    ['Incapacitating Terror']   = { icon = 'esoui/art/icons/ability_debuff_fear.dds'}, -- Incapacitating Terror (Child of Bones) -- Just in case
    
    -- VVARDENFELL
    ['Ash Storm'] =         { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_ash_storm.dds' }, -- Divine Intervention (Divine Delusions)
    ['Sunder\'s Echo'] =    { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Sunder's Echo (Divine Intervention)
    ['Empowered Strike'] =  { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike (Divine Intervention)
    ['Oily Smoke'] =        { icon = 'LuiExtended/media/icons/abilities/ability_clockworkguardian_oily_smoke.dds' }, -- Oily Smoke (Divine Restoration)
    ['Defensive Flare'] =   { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_torrent.dds' }, -- Defensive Flare (Divine Restoration)
    ['Pulse'] =             { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Pulse (Divine Restoration)
    ['Sparks'] =            { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds' }, -- Sparks (Divine Restoration)
    ['Spinning Blades'] =   { icon = 'esoui/art/icons/ability_rogue_026.dds' }, -- Spinning Blades (Divine Restoration)
    ['Lunge'] =             { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Divine Restoration)
    ['Barbs'] =             { icon = 'LuiExtended/media/icons/abilities/ability_rogue_fire_ranged.dds' }, -- Barbs (Divine Restoration)
    ['Planar Shear'] =      { icon = 'LuiExtended/media/icons/abilities/ability_trap_planar_shear.dds' }, -- Planar Shear (Divine Restoration)
    ['Divine Hijack'] =     { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack (Divine Restoration)
    
    ['Stomp of Flame'] =    { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave' }, -- Stomp of Flame (Ancestral Adversity)
    ['Unstable Reaction'] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_unstable_reaction.dds' }, -- Unstable Reaction (Reclaiming Vos)
    ['Water Geyser Burst'] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser' }, -- Water Geyser (Vvardenfell - A Hireling of House Telvanni)
    
    ['Sweeping Spin'] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds'}, -- Sweeping Spin (Mzandchend Guardian)
    
    ['Brand\'s Cleave'] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds', name = 'Mighty Strike' }, -- Dark Reach (Brand's Cleave -- Vvardenfell -- The Heart of a Telvanni)
    ['Dark Reach'] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = 'Fiery Grip'}, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    
    ['Puncture'] = { icon = 'esoui/art/icons/ability_1handed_002.dds' }, -- Puncture (Hleran Noble)
    
    ['Twin Slashes'] = { icon = 'esoui/art/icons/ability_dualwield_001.dds' }, -- Twin Slashes (Sixth House Supplicant)
    ['Twin Slashes Bleed'] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = 'Twin Slashes' }, -- Twin Slashes Bleed (Sixth House Supplicant)
    
    ['Swinging Cleave'] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds'}, -- Swinging Cleave (Mud-Tusk)
    ['Boulder Toss'] = { icon = 'LuiExtended/media/icons/abilities/ability_trollranged_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    ['Tremor'] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds' }, -- Tremor (Mud-Tusk)
    
    ['Piston Thrust'] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }, -- Piston Thrust (Guardian of Bthark)
    ['Whirlwind Function'] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_whirlwind_function.dds' }, -- Whirlwind Function (Guardian of Bthark)
    ['Steam Breath'] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds' }, -- Steam Breath (Guardian of Bthark)
    
    ['Fire Runes'] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_runes.dds' }, -- Fire Runes (Nchuleftingth - Friar Hadelar)
    
    ['Overcharge'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Nchuleftingth)
    
    ['Shocking Touch'] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }, -- Shocking Touch (Steamreaver - Nchuleftingth)
    
    ['Overcharge Expulsion'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Overcharge Explusion ( Nchulaeon -- Nchuleftingth)
    
}

-- Advanced death recap override: By specific source name: Allows icon, name, and source override (used to fix traps and dummy events with nonsense names)
DR.DeathRecapInfoOverride = {

    -- HUMAN NPC's
    ['Quick Strike'] =      { -- BATTLEMAGE MELEE
                            ['Heiress Alona'] =     { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = 'Staff Strike' }, -- Quick Strike (Battlemage)
                            ['Attendant Konia'] =   { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = 'Staff Strike' }, -- Quick Strike (Battlemage)
                            },    
                            
    ['Flare'] =             {
                            ['Air Atronach'] =      { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flare.dds' }, -- Flare (Air Atronach)
                            },
    ['Heavy Attack'] =      {
                            ['Air Atronach'] =      { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_heavy_attack.dds' }, -- Heavy Attack (Air Atronach)
                            },
    -- ANIMALS
    ['Helljoint'] =         {
                            ['Jackal'] =            { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
                            },
    
    ['Slap'] =              {
                            ['Bull Netch'] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_slap.dds' }, -- Slap (Netch)
                            ['Betty Netch'] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_slap.dds' }, -- Slap (Netch)
                            },
    ['Lunge'] =             {
                            -- Dire Wolf
                            ['Dire Wolf'] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds' }, -- Lunge (Dire Wolf)
    
                            -- Great Bear
                            ['Bear'] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }, -- Lunge (Great Bear)
                            ['Great Bear'] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }, -- Lunge (Great Bear)
                            
                            },
    ['Strike'] =            {
                            -- Giant Snake
                            ['Giant Snake'] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_strike.dds' }, -- Strike (Giant Snake)
                            
                            -- Nix-Hound
                            ['Nix-Hound'] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }, -- Strike (Nix-Hound)
                            },
    ['Slam'] =              {
                            -- GREAT BEAR
                            ['Bear'] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Slam (Great Bear)
                            ['Great Bear'] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Slam (Great Bear)
                            
                            -- KAGOUTI
                            ['Kagouti'] =           { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)
                            ['Bull Kagouti'] =      { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)
    
                            -- SKEEVER
                            ['Skeever'] =           { icon = 'LuiExtended/media/icons/abilities/ability_skeever_slam.dds' }, -- Slam (Skeever)
                            ['Daedrat'] =           { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_slam.dds' }, -- Slam (Daedrat)
                            },
    ['Rend'] =              {
                            -- DURZOG
                            ['Durzog'] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }, -- Rend (Durzog)
                            
                            -- LION
                            ['Lion'] =              { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
                            ['Lioness'] =           { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
                            ['Sabre Cat'] =         { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
                            ['Senche-Tiger'] =      { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche)
                            
                            -- SKEEVER
                            ['Skeever'] =           { icon = 'LuiExtended/media/icons/abilities/ability_skeever_rend.dds' }, -- Rend (Skeever)
                            ['Daedrat'] =           { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_rend.dds' }, -- Rend (Daedrat)
                            },
    ['Claw'] =              {
                            -- Lion
                            ['Lion'] =              { icon = 'LuiExtended/media/icons/abilities/ability_lion_claw.dds' }, -- Claw (Lion)
                            ['Lioness'] =           { icon = 'LuiExtended/media/icons/abilities/ability_lion_claw.dds' }, -- Claw (Lion)
                            ['Sabre Cat'] =         { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_claw.dds' }, -- Claw (Sabre Cat)
                            ['Senche-Tiger'] =      { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche)
                            
                            -- Haj Mota
                            ['Haj Mota'] =          { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_claw.dds' }, -- Claw (Haj Mota)
                            
                            },
    ['Double Strike'] =     {
                            ['Lion'] =              { icon = 'LuiExtended/media/icons/abilities/ability_lion_double_strike.dds' }, -- Double Strike (Lion)
                            ['Lioness'] =           { icon = 'LuiExtended/media/icons/abilities/ability_lion_double_strike.dds' }, -- Double Strike (Lion)
                            ['Sabre Cat'] =         { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_double_strike.dds' }, -- Double Strike (Lion)
                            ['Senche-Tiger'] =      { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche)
                            },
    ['Bite'] =              {
                            -- Alit
                            ['Alit'] =              { icon = 'LuiExtended/media/icons/abilities/ability_alit_bite.dds' }, -- Bite (Alit)
                            
                            -- Assassin Beetle
                            ['Assassin Beetle'] =   { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_bite.dds' }, -- Bite (Assassin Beetle)
                            
                            -- Durzog
                            ['Durzog'] =              { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }, -- Bite (Durzog)
                            
                            -- Great Bear
                            ['Bear'] =              { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds' }, -- Bite (Great Bear)
                            ['Great Bear'] =        { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds' }, -- Bite (Great Bear)
                            
                            -- Crocodile
                            ['Crocodile'] =         { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Bite (Crocodile)
                            
                            -- Dire Wolf
                            ['Dire Wolf'] =         { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }, -- Bite (Dire Wolf)
                            
                            -- Duneripper
                            ['Duneripper'] =        { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Bite (Duneripper)
                            ['Duneracer'] =         { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Bite (Duneripper)
                            
                            -- Giant Spider
                            ['Spider'] =            { icon = 'LuiExtended/media/icons/abilities/ability_spider_bite.dds' }, -- Bite (Giant Spider)
                            
                            -- Giant Wasp
                            ['Giant Wasp'] =        { icon = 'LuiExtended/media/icons/abilities/ability_wasp_bite.dds' }, -- Bite (Giant Wasp)
                            ['Wasp'] =              { icon = 'LuiExtended/media/icons/abilities/ability_wasp_bite.dds' }, -- Bite (Giant Wasp)
                            ['Young Wasp'] =        { icon = 'LuiExtended/media/icons/abilities/ability_wasp_bite.dds' }, -- Bite (Giant Wasp)
                            
                            -- Guar
                            ['Guar'] =              { icon = 'LuiExtended/media/icons/abilities/ability_guar_bite.dds' }, -- Bite (Guar)
                            
                            -- Haj Mota
                            ['Haj Mota'] =          { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds' }, -- Bite (Haj Mota)

                            -- Hoarvor
                            ['Hoarvor'] =           { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bite.dds' }, -- Bite (Hoarvor)
                            
                            -- Kwama Scrib
                            ['Kwama Scrib'] =       { icon = 'LuiExtended/media/icons/abilities/ability_kwamascrib_bite.dds' }, -- Bite (Kwama Scrib)
                            ['Strifeswarm Scrib'] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamascrib_bite.dds' }, -- Bite (Kwama Scrib)
                            
                            -- Kwama Worker
                            ['Kwama Worker'] =      { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_bite.dds' }, -- Bite (Kwama Worker)
                            ['Strifeswarm Brute'] =     { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_bite.dds' }, -- Bite (Kwama Worker)
                            
                            ['Kotu Gava'] =         { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds' }, -- Bite (Kotu Gava)
                            ['Kotu Gava Spawn'] =   { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds' }, -- Bite (Kotu Gava)
                            ['Kotu Gava Broodmother'] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds' }, -- Bite (Kotu Gava)
                            
                            -- Lion
                            ['Lion'] =              { icon = 'LuiExtended/media/icons/abilities/ability_lion_bite.dds' }, -- Bite (Lion)
                            ['Lioness'] =           { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
                            ['Sabre Cat'] =         { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_bite.dds' }, -- Bite (Sabre Cat)
                            ['Senche-Tiger'] =      { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche)
                            
                            -- Shalk
                            ['Shalk'] =              { icon = 'LuiExtended/media/icons/abilities/ability_shalk_bite.dds' }, -- Bite (Shalk)
                            
                            -- Wamasu
                            ['Wamasu'] =            { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_bite.dds' }, -- Bite (Wamasu)
                            
                            -- Wolf
                            ['Wolf'] =              { icon = 'LuiExtended/media/icons/abilities/ability_wolf_bite.dds' }, -- Bite (Wolf)
                            ['Jackal'] =            { icon = 'LuiExtended/media/icons/abilities/ability_jackal_bite.dds' }, -- Bite (Jackal)
                            
                            },
    ['Rotbone'] =           {
                            -- Durzog
                            ['Durzog'] =            { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', name = 'Rip and Tear' }, -- Rotbone (Durzog)
                            
                            -- Wolf
                            ['Jackal'] =            { icon = 'LuiExtended/media/icons/abilities/ability_jackal_rotbone.dds' }, -- Rotbone (Wolf)
                            },
    ['Crushing Chomp'] =
                            {
                            -- Crocodile
                            ['Crocodile'] =         { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Crushing Chomp (Crocodile)
                            
                            -- Duneripper
                            ['Duneripper'] =        { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Crushing Chomp (Duneripper)
                            ['Duneracer'] =         { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Crushing Chomp (Duneripper)
                            },
    ['Sweep'] =
                            {
                            -- Crocodile
                            ['Crocodile'] =         { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }, -- Sweep (Crocodile)
                            
                            -- Duneripper
                            ['Duneripper'] =        { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }, -- Sweep (Duneripper)
                            ['Duneracer'] =         { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }, -- Sweep (Duneripper)
                            
                            -- Wamasu
                            ['Wamasu'] =            { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }, -- Sweep (Wamasu)
                            
                            },
    ['Shockwave'] =         {
                            ['Echatere'] =         { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }, -- Shockwave (Echatere)
                            },
    ['Headbutt'] =          {
                            -- Echatere
                            ['Echatere'] =          { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }, -- Headbutt (Echatere)
                            
                            -- Guar
                            ['Guar'] =              { icon = 'LuiExtended/media/icons/abilities/ability_guar_headbutt.dds' }, -- Headbutt (Guar)
                            },
    ['Lacerate'] =          {
                            ['Alit'] =              { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }, -- Lacerate (Alit)
                            },
    ['Laceration'] =        {
                            -- Alit
                            ['Alit'] =              { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', name = 'Lacerate' }, -- Laceration (Alit)
                            
                            -- Assassin Beetle
                            ['Assassin Beetle'] =   { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = 'Lacerate' }, -- Laceration (Assassin Beetle)
                            },
    
    
    
    
    ['Shocking Touch'] =    {
                            -- Dreugh
                            ['Dreugh'] =            { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_touch.dds' }, -- Shocking Touch (Dreugh)
                            ['Old Rust-Eye'] =      { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_touch.dds' }, -- Shocking Touch (Dreugh)
                            },
    ['Swipe'] =             {
                            -- Air Atronach
                            ['Air Atronach'] =      { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }, -- Swipe (Air Atronach)
                            
                            -- Dreugh
                            ['Dreugh'] =            { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_swipe.dds' }, -- Swipe (Dreugh)
                            ['Old Rust-Eye'] =      { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_swipe.dds' }, -- Swipe (Dreugh)
                            
                            -- Bear
                            ['Bear'] =              { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds', name = 'Bite' }, -- Swipe (Bear)
                            
                            -- Kwama Warrior
                            ['Kwama Warrior'] =     { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_swipe.dds' }, -- Swipe -- Kwama Warrior
                            
                            -- Mammoth
                            ['Mammoth'] =           { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_swipe.dds' }, -- Swipe (Mammoth)
                            
                            -- Welwa
                            ['Welwa'] =             { icon = 'LuiExtended/media/icons/abilities/ability_welwa_swipe.dds', name = 'Bite' }, -- Swipe (Welwa)
                            },
    ['Smash'] =             {
                            ['Kwama Warrior'] =     { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }, -- Smash -- Kwama Warrior
                            },
    ['Cleave'] =            {
                            ['Welwa'] =             { icon = 'LuiExtended/media/icons/abilities/ability_welwa_cleave.dds', name = 'Swipe' }, -- Cleave (Welwa)
                            },
    ['Stomp'] =             {
                            ['Mammoth'] =           { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }, -- Stomp (Mammoth)
                            },
    ['Slash'] =             {
                            -- Dreugh
                            ['Dreugh'] =            { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
                            ['Old Rust-Eye'] =      { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
                            
                            -- Vvardenfell
                            ['Sixth House Supplicant'] =    { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Slash (Sixth House Supplicant) -- Vvardenfell
                            ['Cliff Strider Matriarch'] =   { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach) -- Vvardenfell

                            },
    ['Charge'] =            {
                            -- Kagouti
                            ['Kagouti'] =           { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds', name = 'Rush' }, -- Charge (Kagouti)
                            ['Bull Kagouti'] =      { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds', name = 'Rush' }, -- Charge (Kagouti)
    
                            -- Mammoth
                            ['Mammoth'] =           { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = 'Stampede' }, -- Charge (Mammoth)
                            
                            -- Giant Wasp
                            ['Giant Wasp'] =        { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = 'Zoom' }, -- Charge (Giant Wasp)
                            ['Wasp'] =              { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = 'Zoom' }, -- Charge (Giant Wasp)
                            ['Young Wasp'] =        { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = 'Zoom' }, -- Charge (Giant Wasp)
                            
                            -- Kwama Worker
                            ['Kwama Worker'] =      { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = 'Plow' }, -- Charge (Kwama Worker)
                            ['Strifeswarm Brute'] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = 'Plow' }, -- Charge (Kwama Worker)
                            
                            -- Wamasu
                            ['Wamasu'] =            { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = 'Barreling Charge' }, -- Charge (Wamasu)
                            
                            -- Welwa
                            ['Welwa'] =             { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = 'Blitz' }, -- Charge (Welwa)
                            
                            -- Clannfear
                            ['Clannfear'] =         { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_charge.dds', name = 'Rush' }, -- Charge (Clannfear)
                            },
    ['Bleeding'] =          {
                            ['Assassin Beetle'] =   { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = 'Lacerate' }, -- Bleeding (Assassin Beetle)
                            },
    ['Pincer'] =            {
                            ['Giant Scorpion'] =    { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_pincer.dds' }, -- Pincer (Giant Scorpion)
                            },
    ['Sting'] =             {
                            -- Giant Scorpion
                            ['Giant Scorpion'] =    { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds' }, -- Sting (Giant Scorpion)
                            },                        
    ['Fiery Breath'] =      {
                            ['Shalk'] =             { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds' }, -- Fiery Breath (Shalk)
                            },
    ['Zap'] =               {
                            -- Thunderbug
                            ['Thunderbug'] =        { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds' }, -- Zap (Thunderbug)
                            },
    ['Bolt'] =              {
                            -- Thunderbug
                            ['Thunderbug'] =        { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds' }, -- Bolt (Thunderbug)
                            },
    ['Spit'] =              {
                            -- Kwama Scrib
                            ['Kwama Scrib'] =       { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', name = 'Contagion' }, -- Spit (Giant Spider)
                            ['Strifeswarm Scrib'] =     { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', name = 'Contagion' }, -- Spit (Giant Spider)
                            },
    ['Swarm'] =             {
                            ['Kotu Gava Broodmother'] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarm (Kotu Gava Broodmother) 
                            },
    -- TRAPS
    ['Fire Trap'] =         {
                            ['Chest'] =             { icon = 'LuiExtended/media/icons/abilities/ability_trap_dwarven_furnace.dds', name = 'Dwarven Furnace', source = 'Dwarven Furnace' },
                            },
    ['Flame Jet'] =         {
                            ['Trap'] =              { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap', source = 'Flame Jet Trap' },
                            },
    ['Searing Flame'] =     {
                            ['Trap'] =              { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap', source = 'Flame Jet Trap' },
                            },
    ['Hammer'] =            {
                            ['Trap'] =              { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap', source = 'Hammer Trap' },
                            },
    ['Blade'] =             {
                            ['Trap'] =              { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap', source = 'Blade Trap' },
                            },
    ['Falling Rocks'] =     {
                            ['Deadfall'] =          { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds', source = 'Falling Rocks' },
                            },
    ['Pyroclast'] =         {
                            ['Meteor'] =            { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', source = 'Red Mountain' },
                            },
    ['Searing Steam'] =     {
                            ['Searing Steam'] =     { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds', source = 'Steam Vent' },
                            },
    ['Piston Thrust'] =     {
                            ['Steam Piston'] =      { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Piston Thrust (Dwarven Piston)
                            },
    ['Spike Trap'] =        {
                            ['Steam Piston'] =      { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Piston Thrust (Dwarven Piston)
                            },
    ['Laser Damage'] =      { 
                            ['Dwarven Charge-Wire'] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds', name = 'Overcharged Shock'}, -- Laser Damage (Dwarven Charge-Wire)
                            },
    ['Coldharbour Flames'] =    {
                                ['Flame Trap'] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds', name = 'Cold Fire Trap', source = 'Cold Fire Trap'}, -- Coldharbour Flames
                                },
    
    -----------------------------------------------
    -- MQ
    -----------------------------------------------
    
    ['Bone Saw'] =              {
                                ['Child of Bones'] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw_tutorial.dds' }, -- Bone Saw (Bone Colossus)
                                },

    -----------------------------------------------
    -- VVARDENFELL
    -----------------------------------------------
    -- Main Quest
    ['Daedric Bolt'] =
                            {
                            ['Chodala'] =           { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_ranged.dds' }, -- VVARDENFELL - Daedric Bolt (Chodala)
                            },
    ['Skyfall'] = 
                            {
                            ['Meteor'] =            { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', source = 'Baar Dau' }, -- Skyfall (Divine Disaster)
                            },
    ['Spinning Blade'] =    
                            {
                            ['Blade Trap'] =                { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = 'Spinning Blade Trap', source = 'Spinning Blade Trap' }, -- Spinning Blade (Divine Restoration)
                            },
    ['Serrated Blade'] =    
                            {   
                            ['Blade Trap'] =                { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = 'Spinning Blade Trap', source = 'Spinning Blade Trap' }, -- Serrated Blade (Divine Restoration)
                            },
    ['Accelerated Transposition'] = 
                            {
                            ['Poison'] =                    { icon = 'esoui/art/icons/achievement_morrowind_031.dds', source = 'Vapor Cloud' }, -- Accelerated Transposition (Like Blood from a Stone)
                            },
    -- Sidequests
    ['Spider Explosion'] =  { 
                            ['Spiderling'] =                { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', source = 'Exploding Spider'}, -- Spider Explosion (A Web of Trouble)
                            },
                            
    -- Delve/Public Dungeon/World
    ['Chop'] =              { 
                            ['Black Dart Cropper'] =                { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Chop (Cropper)
                            ['Black Dart Drudge'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Chop (Drudge)
                            ['Hleran Noble'] =                      { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Chop (Hleran Noble)
                            ['Sixth House Supplicant'] =            { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Chop (Sixth House Supplicant)
                            },
    ['Hack'] =              { 
                            ['Black Dart Cropper'] =                { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Hack (Cropper)
                            ['Black Dart Drudge'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Hack (Drudge)
                            ['Sixth House Supplicant'] =            { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Hack (Sixth House Supplicant)
                            },
    ['Reverse Slash'] =     { 
                            ['Black Dart Cropper'] =                { icon = 'esoui/art/icons/ability_2handed_001.dds', name = 'Uppercut' }, -- Reverse Slash (Cropper)
                            ['Black Dart Drudge'] =                 { icon = 'esoui/art/icons/ability_2handed_001.dds', name = 'Uppercut' }, -- Reverse Slash (Drudge)
                            ['Sixth House Supplicant'] =            { icon = 'esoui/art/icons/ability_2handed_001.dds', name = 'Uppercut' }, -- Reverse Slash (Sixth House Supplicant)
                            },
    ['Lop'] =               {
                            ['Hleran Noble'] =                      { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Lop (Hleran Noble)
                            ['Sixth House Supplicant'] =            { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Lop (Sixth House Supplicant
                            },
}

DR.DeathRecapTripleOverride = {

--[[
['Zap'] =       {
                ['Thunderbug'] =    {
                                    ['/esoui/art/icons/death_recap_shock_ranged.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds' }, -- Zap (Thunderbug)
                                    },
                },

-]]
['Lightning Rod'] = {
                    ['Air Atronach'] =  {
                                        ['/esoui/art/icons/death_recap_shock_aoe.dds'] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', name = 'Lightning Pulse' }, -- Lightning Rod (Air Atronach - Storm)
                                        },
                    },

}

-- Used for damage the player does to themself
DR.NoSourceOverride = {

    ['Health Potion Poison'] =      {
                                    ['/esoui/art/icons/consumable_potion_015_type_001.dds'] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = 'Ravage Health' }, -- Health Potion Poison
                                    },
    ['Health Potion Lingering Effect'] = {
                                    ['/esoui/art/icons/consumable_potion_015_type_001.dds'] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = 'Ravage Health' }, -- Health Potion Lingering Effect
                                    },
    ['Ravage Health'] =             {
                                    ['/esoui/art/icons/consumable_potion_015_type_001.dds'] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds' }, -- Ravage Health
                                    },
    ['Damage Health'] =             {
                                    ['/esoui/art/icons/consumable_potion_015_type_001.dds'] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = 'Ravage Health' }, -- Damage Health
                                    },
    ['Creeping Ravage Health'] =    {
                                    ['/esoui/art/icons/consumable_potion_014_type_001.dds'] = { icon = 'LuiExtended/media/icons/potions/potion_014r.dds' }, -- Creeping Ravage Health
                                    },

}
