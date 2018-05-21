------------------
-- AbilityTables namespace
local A = {}

-- TODO - need to add all major/minor effects here
-- ---------------------------------------------------
-- MAJOR/MINOR DEBUFFS & DEBUFFS ---------------------
-- ---------------------------------------------------

A.Skill_Minor_Breach                = 46206
A.Skill_Major_Breach                = 33363
A.Skill_Minor_Fracture              = 38688
A.Skill_Major_Fracture              = 28307
A.Skill_Minor_Vulnerability         = 51434
A.Skill_Major_Vulnerability         = 106754
A.Skill_Minor_Maim                  = 61856
A.Skill_Major_Maim                  = 92041
A.Skill_Major_Evasion               = 90620
A.Skill_Minor_Defile                = 61726
A.Skill_Major_Defile                = 38686
A.Skill_Major_Expedition            = 61840
A.Skill_Major_Vitality              = 61275
A.Skill_Minor_Magickasteal          = 40114
A.Skill_Minor_Lifesteal             = 33541
A.Skill_Minor_Sorcery               = 62799
A.Skill_Minor_Brutality             = 61798
A.Skill_Minor_Enveration            = 47202
A.Skill_Minor_Uncertainty           = 47204
A.Skill_Minor_Cowardice             = 46202
A.Skill_Minor_Mangle                = 39168

A.Skill_Minor_Slayer				= 76618
A.Skill_Minor_Aegis					= 76617

A.Skill_Off_Balance                 = 14062
A.Skill_Off_Balace_Immunity         = 102771

-- ---------------------------------------------------
-- INNATE ABILITIES ----------------------------------
-- ---------------------------------------------------

-- Simulated Auras
A.Innate_Recall_Penalty             = GetString(SI_LUIE_SKILL_RECALL_PENALTY) -- Recall Penalty
A.Innate_Vanity_Pet                 = GetString(SI_LUIE_SKILL_VANITY_PET) -- Vanity Pet
A.Innate_Mounted                    = GetString(SI_LUIE_SKILL_MOUNTED) -- Mounted
A.Innate_Resurrection_Immunity      = GetString(SI_LUIE_SKILL_RESURRECTION_IMMUNITY) -- Resurrection Immunity

-- Player Basic
A.Innate_Crouch                     = 20306 -- Crouch
A.Innate_Crouch_Stun                = GetString(SI_LUIE_SKILL_CROUCH_STUN) -- Crouch Stun
A.Innate_Disguised                  = 23553 -- Disguised
A.Innate_Hidden                     = 20309 -- Hidden
A.Innate_Sprint                     = 973   -- Sprint
A.Innate_Block                      = 14890 -- Block
A.Innate_Block_Stun                 = GetString(SI_LUIE_SKILL_BLOCK_STUN) -- Block Stun
A.Innate_Bash                       = 21970 -- Bash
A.Innate_Bash_Stun                  = 21971 -- Bash Stun
A.Innate_Gallop                     = GetString(SI_LUIE_SKILL_MOUNT_SPRINT) -- Gallop
A.Innate_Hard_Dismount              = 42514
A.Innate_Fall_Damage                = GetString(SI_LUIE_SKILL_FALL_DAMAGE) -- Fall Damage
A.Innate_Absorbing_Skyshard         = GetString(SI_LUIE_SKILL_ABSORBING_SKYSHARD) -- Absorbing Skyshard
A.Innate_Receiving_Boon             = GetString(SI_LUIE_SKILL_RECEIVING_BOON) -- Receiving Boon
A.Innate_Ayleid_Well                = GetString(SI_LUIE_SKILL_AYLEID_WELL) -- Ayleid Well
A.Innate_CC_Immunity                = 38117 -- CC Immunity
A.Innate_Stagger                    = 1834 -- Stagger

-- World
A.Innate_Drop_Anchor                = 86717 -- Drop Anchor
A.Innate_Anchor_Drop                = GetString(SI_LUIE_SKILL_ANCHOR_DROP) -- Anchor Drop
A.Innate_Power_of_the_Daedra        = 46690 -- Power of the Daedra

-- Weapon Attacks
A.Skill_Light_Attack                = 23604 -- Light Attack
A.Skill_Medium_Attack               = 39097 -- Medium Attack
A.Skill_Heavy_Attack                = 18431 -- Heavy Attack
A.Skill_Heavy_Attack_Dual_Wield     = 16420 -- Heavy Attack (Dual Wield)
A.Skill_Heavy_Attack_Werewolf       = 32480 -- Heavy Attack Werewolf
A.Skill_Heavy_Attack_Shock          = 18396 -- Heavy Attack (Shock)
A.Skill_Heavy_Attack_Main_Hand      = GetString(SI_LUIE_SKILL_PASSIVE_HEAVY_MAIN_HAND)
A.Skill_Heavy_Attack_Off_Hand       = GetString(SI_LUIE_SKILL_PASSIVE_HEAVY_OFF_HAND)

-- ---------------------------------------------------
-- COMSUMABLES & ITEMS -------------------------------
-- ---------------------------------------------------

-- Glyphs
A.Item_Glyph_of_Absorb_Health       = 28919
A.Item_Glyph_of_Absorb_Magicka      = 46743
A.Item_Glyph_of_Absorb_Stamina      = 46746
A.Item_Glyph_of_Crushing            = GetString(SI_LUIE_SKILL_GLYPH_CRUSHING)
A.Item_Glyph_of_Damage_Health       = 46749
A.Item_Glyph_of_Decrease_Health     = GetString(SI_LUIE_SKILL_GLYPH_DECREASE_HEALTH)
A.Item_Glyph_of_Flame               = 17895
A.Item_Glyph_of_Foulness            = 17904
A.Item_Glyph_of_Frost               = 17897
A.Item_Glyph_of_Hardening           = GetString(SI_LUIE_SKILL_GLYPH_HARDENING)
A.Item_Glyph_of_Poison              = 17902
A.Item_Glyph_of_Prismatic_Onslaught = 40337
A.Item_Glyph_of_Shock               = 17899
A.Item_Glyph_of_Weakening           = GetString(SI_LUIE_SKILL_GLYPH_WEAKENING)
A.Item_Glyph_of_Weapon_Damage       = GetString(SI_LUIE_SKILL_GLYPH_WEAPON_DAMAGE)

-- Elemental Status Effect
A.Proc_Burning                      = 18084
A.Proc_Diseased                     = 21925
A.Proc_Chill                        = 21481
A.Proc_Chilled                      = 7145
A.Proc_Poisoned                     = 21929
A.Proc_Concussion                   = 21487

-- Potions/Poisons
A.Potion_Invisiblity                = 3668
A.Potion_Ravage_Health              = 46111
A.Potion_Restore_Health             = 45221
A.Potion_Restore_Magicka            = 45223
A.Potion_Restore_Stamina            = 45225
A.Poison_Creeping_Drain_Health      = 79701
A.Poison_Lingering_Restore_Health   = 79702
A.Poison_Stealth_Draining_Poison    = GetString(SI_LUIE_SKILL_POISON_STEALTH_DRAIN)
A.Poison_Conspicuous_Poison         = GetString(SI_LUIE_SKILL_POISON_CONSPICUOUS)

-- Food/Drink
A.Food_Magicka_Stamina_Increase     = 61294
A.Food_Health_Stamina_Increase      = 61255
A.Food_Health_Magicka_Increase      = 61257
A.Food_Orzorgas_Tripe_Trifle_Pocket = GetString(SI_LUIE_SKILL_FOOD_ORZORGA_POCKET)
A.Food_Orzorgas_Blood_Price_Pie     = GetString(SI_LUIE_SKILL_FOOD_ORZORGA_PIE)
A.Food_Orzorgas_Smoked_Bear_Haunch  = GetString(SI_LUIE_SKILL_FOOD_ORZORGA_HAUNCH)
A.Food_Pumpkin_Snack_Skewer         = GetString(SI_LUIE_SKILL_FOOD_SNACK_SKEWER)
A.Food_Frosted_Brains               = GetString(SI_LUIE_SKILL_FOOD_FROSTED_BRAINS)
A.Food_Jagga_Drenched_Mud_Ball      = GetString(SI_LUIE_SKILL_FOOD_MUD_BALL)
A.Food_Lava_Foot_Soup               = GetString(SI_LUIE_SKILL_FOOD_LAVA_FOOT)
A.Food_Crown_Crate_Meal             = GetString(SI_LUIE_SKILL_FOOD_CROWN_CRATE_FOOD)
A.Food_Crown_Meal                   = GetString(SI_LUIE_SKILL_FOOD_CROWN_FOOD)
A.Food_Crown_Combat_Mystics_Stew    = GetString(SI_LUIE_SKILL_FOOD_CROWN_STEW)
A.Food_Crown_Vigorous_Ragout        = GetString(SI_LUIE_SKILL_FOOD_CROWN_RAGOUT)
A.Drink_Health_Recovery             = 61322
A.Drink_Magicka_Recovery            = 61325
A.Drink_Stamina_Recovery            = 61328
A.Drink_Magicka_Stamina_Recovery    = 61345
A.Drink_Health_Stamina_Recovery     = 61340
A.Drink_Health_Magicka_Recovery     = 61335
A.Drink_Primary_Stat_Recovery       = 61350
A.Drink_Increase                    = GetString(SI_LUIE_SKILL_DRINK_INCREASE)
A.Drink_Orzorgas_Red_Frothgar       = GetString(SI_LUIE_SKILL_DRINK_ORZORGA_FROTHGAR)
A.Drink_Bowl_of_Peeled_Eyeballs     = GetString(SI_LUIE_SKILL_DRINK_PEELED_EYEBALLS)
A.Drink_Ghastly_Eye_Bowl            = GetString(SI_LUIE_SKILL_DRINK_GHASTLY_EYE_BOWL)
A.Drink_Bergama_Warning_Fire        = GetString(SI_LUIE_SKILL_DRINK_WARNING_FIRE)
A.Drink_Betnikh_Twice_Spiked_Ale    = GetString(SI_LUIE_SKILL_DRINK_BETNIKH_ALE)
A.Drink_Hissmir_Fish_Eye_Rye        = GetString(SI_LUIE_SKILL_DRINK_FISH_EYE)
A.Drink_Snow_Bear_Glow_Wine         = GetString(SI_LUIE_SKILL_DRINK_GLOW_WINE)
A.Drink_Crown_Crate_Drink           = GetString(SI_LUIE_SKILL_DRINK_CROWN_CRATE_DRINK)
A.Drink_Crown_Drink                 = GetString(SI_LUIE_SKILL_DRINK_CROWN_DRINK)
A.Drink_Crown_Stout_Magic_Liqueur   = GetString(SI_LUIE_SKILL_DRINK_CROWN_LIQUEUR)
A.Drink_Crown_Vigorous_Tincture     = GetString(SI_LUIE_SKILL_DRINK_CROWN_TINCTURE)

-- Experience Consumables
A.Experience_Psijic_Ambrosia        = GetString(SI_LUIE_SKILL_EXPERIENCE_PSIJIC_AMBROSIA) -- Psijic Ambrosia
A.Experience_Aetherial_Ambrosia     = GetString(SI_LUIE_SKILL_EXPERIENCE_AETHERIAL_AMBROSIA) -- Aetherial Ambrosia
A.Experience_Mythic_Ambrosia        = GetString(SI_LUIE_SKILL_EXPERIENCE_MYTHIC_AMBROSIA) -- Mythic Aetherial Ambrosia
A.Experience_Crown_Scroll           = GetString(SI_LUIE_SKILL_EXPERIENCE_CROWN_SCROLL) -- Crown Experience Scroll
A.Experience_Crown_Crate_Scroll_1   = GetString(SI_LUIE_SKILL_EXPERIENCE_CROWN_CRATE_SCROLL_1) -- Crown Crate Experience Scroll
A.Experience_Crown_Crate_Scroll_2   = GetString(SI_LUIE_SKILL_EXPERIENCE_CROWN_CRATE_SCROLL_2) -- Major Crown Crate Experience Scroll
A.Experience_Crown_Crate_Scroll_3   = GetString(SI_LUIE_SKILL_EXPERIENCE_CROWN_CRATE_SCROLL_3) -- Grand Crown Crate Experience Scroll

-- Misc Consumables
A.Consumable_Festival_Mints         = GetString(SI_LUIE_SKILL_CONSUMABLE_FESTIVAL_MINTS) -- High Hrothgar Festival Mints
A.Consumable_Sailors_Grog           = GetString(SI_LUIE_SKILL_CONSUMABLE_SAILORS_GROG) -- Sailor's Warning Festival Grog

-- Mementos
A.Memento_Almalexias_Lantern        = GetCollectibleName(341)
A.Memento_Bonesnap_Binding_Stone    = GetCollectibleName(348)
A.Memento_Nirnroot_Wine             = GetCollectibleName(344)
A.Memento_Mystery_Meat              = GetString(SI_LUIE_SKILL_COLLECTIBLE_MYSTERY_MEAT)
A.Memento_Sanguines_Goblet          = GetCollectibleName(338)
A.Memento_Token_of_Root_Sunder      = GetCollectibleName(349)
A.Memento_Storm_Atronach_Transform  = GetCollectibleName(596)
A.Memento_Wild_Hunt_Transform       = GetCollectibleName(759)
A.Memento_Dwemervamidium_Mirage     = GetCollectibleName(1183)
A.Memento_Swarm_of_Crows            = GetCollectibleName(1384)
A.Memento_Fire_Breathers_Torches    = GetCollectibleName(600)
A.Memento_Jugglers_Knives           = GetCollectibleName(598)
A.Memento_Sword_Swallowers_Blade    = GetCollectibleName(597)
A.Memento_Discourse_Amaranthine     = GetCollectibleName(345)
A.Memento_Sealing_Amulet            = GetCollectibleName(351)
A.Memento_Twilight_Shard            = GetCollectibleName(1158)
A.Memento_Yokudan_Totem             = GetCollectibleName(350)
A.Memento_Blade_of_the_Blood_Oath   = GetCollectibleName(390)
A.Memento_Dreamers_Chime            = GetCollectibleName(1229)
A.Memento_Hidden_Pressure_Vent      = GetCollectibleName(354)
A.Memento_Coin_of_Illusory_Riches   = GetCollectibleName(361)
A.Memento_Malacaths_Wrathful_Flame  = GetCollectibleName(353)
A.Memento_Jubliee_Cake              = 87998
A.Memento_Mud_Ball                  = 86749
A.Memento_Storm_Atronach_Aura       = GetCollectibleName(594)
A.Memento_Storm_Orb_Juggle          = GetCollectibleName(595)
A.Memento_Wild_Hunt_Aura            = GetCollectibleName(760)
A.Memento_Floral_Swirl_Aura         = GetCollectibleName(758)
A.Memento_Dwarven_Puzzle_Orb        = GetCollectibleName(1181)
A.Memento_Dwarven_Tonal_Forks       = GetCollectibleName(1182)
A.Memento_Crows_Calling             = GetCollectibleName(1383)
A.Memento_Fiery_Orb                 = GetCollectibleName(1481)
A.Memento_Flame_Pixie               = GetCollectibleName(1482)
A.Memento_Flame_Eruption            = GetCollectibleName(1483)
A.Memento_Frost_Shard               = GetCollectibleName(4707)
A.Memento_Rune_of_Levitation        = GetCollectibleName(4706)
A.Memento_Dragon_Summons_Focus      = GetCollectibleName(4708)
A.Memento_The_Pie_of_Misrule        = GetCollectibleName(1167)

-- ---------------------------------------------------
-- ITEM SETS -----------------------------------------
-- ---------------------------------------------------

A.Set_Asylum_Destruction_Staff      = 99596 -- Concentrated Force (Perfected)
A.Set_Bogdan_the_Nightflame         = GetString(SI_LUIE_SKILL_SET_BOGDAN_THE_NIGHTFLAME)
A.Set_Lord_Warden_Dusk              = GetString(SI_LUIE_SKILL_SET_LORD_WARDEN_DUSK)
A.Set_Malubeth_the_Scourger         = GetString(SI_LUIE_SKILL_SET_MALUBETH_THE_SCOURGER)
A.Set_Maw_of_the_Infernal           = 59507
A.Set_Nerieneth                     = 59592
A.Set_Shadowrend                    = 80989
A.Set_Spawn_of_Mephala              = 59497
A.Set_Swarm_Mother                  = 80592
A.Set_Engine_Guardian               = 59521
A.Set_The_Troll_King                = GetString(SI_LUIE_SKILL_SET_TROLL_KING)
A.Set_Redistribution                = GetString(SI_LUIE_SKILL_SET_REDISTRIBUTION)
A.Set_Varens_Legacy                 = 79029
A.Set_Syvarras_Scales               = 75717
A.Set_Twin_Sisters                  = 32828
A.Set_Way_of_Fire                   = 52710
A.Set_Plague_Slinger                = 102113
A.Set_Ice_Furnace                   = GetString(SI_LUIE_SKILL_SET_ICE_FURNACE)
A.Set_Jolting_Arms                  = 67077
A.Set_Hand_of_Mephala               = 84355
A.Set_Tormentor                     = 67282
A.Set_Immortal_Warrior              = 90938
A.Set_Eternal_Warrior               = 90939
A.Set_Destructive_Mage              = 51315
A.Set_Healing_Mage                  = 51442
A.Set_Vicious_Serpent               = 61440
A.Set_Phoenix                       = 90935
A.Set_Vicecannon_of_Venom           = 79464
A.Set_Bahrahas_Curse                = 75673
A.Set_Pirate_Skeleton               = 98421
A.Set_Briarheart                    = 71102
A.Set_Ironblood                     = 97626
A.Set_Cooldown                      = GetString(SI_LUIE_SKILL_SET_COOLDOWN)
A.Set_Eternal_Hunt                  = 75927
A.Set_Glorious_Defender             = 71180
A.Set_Para_Bellum                   = 71191
A.Set_Winterborn                    = 71644
A.Set_Grace_of_Gloom                = 106865
A.Set_Dust_Cloud                    = GetString(SI_LUIE_SKILL_DUST_CLOUD)
A.Set_Nocturnals_Favor              = 106803
A.Set_Vestment_of_Olorime           = 107117
A.Set_Mantle_of_Siroria             = 107093
A.Set_Arms_of_Relequen              = 107202

A.Disguise_Monks_Disguise           = GetString(SI_LUIE_SKILL_DISGUISE_MONKS_DISGUISE)

-- ---------------------------------------------------
-- CHAMPION ABILITIES --------------------------------
-- ---------------------------------------------------

A.Champion_Vengeance_Charge         = GetString(SI_LUIE_SKILL_VENGEANCE_CHARGE) -- Vengeance Counter
A.Champion_Riposte                  = 60230

-- ---------------------------------------------------
-- SKILL LINE PASSIVES -------------------------------
-- ---------------------------------------------------

-- Sorcerer
A.Passive_Persistence               = 31378
A.Passive_Rebate                    = 31398

-- Templar
A.Passive_Light_Weaver              = 31760

-- Warden
A.Passive_Bond_with_Nature          = GetString(SI_LUIE_SKILL_BOND_WITH_NATURE)
A.Passive_Savage_Beast              = 86062
A.Passive_Natures_Gift              = 93054

-- Weapon
A.Passive_Heavy_Weapons             = 29375
A.Passive_Follow_Up                 = 29389
A.Passive_Twin_Blade_and_Blunt      = 30893
A.Passive_Destruction_Expert        = 30965

-- Soul Magic
A.Passive_Soul_Summons              = 39269

-- Vampire
A.Passive_Savage_Feeding            = 42054
A.Passive_Blood_Ritual              = 33091
A.Passive_Noxiphilic_Sanguivoria    = GetString(SI_LUIE_SKILL_PASSIVE_NOXIPHILIC_SANGUIVORIA)

-- Werewolf
A.Passive_Bloodmoon                 = 32639

-- Undaunted
A.Passive_Undaunted_Command         = 55584

-- Racial
A.Passive_Red_Diamond               = 36155

-- ---------------------------------------------------
-- CLASS SKILLS --------------------------------------
-- ---------------------------------------------------

-- Dragonknight

A.Skill_Power_Lash                  = 20824
A.Skill_Fiery_Grip                  = 20492
A.Skill_Fiery_Breath                = 20917
A.Skill_Inferno                     = 28967
A.Skill_Flames_of_Oblivion          = 32853
A.Skill_Cauterize                   = 32881
A.Skill_Standard_of_Might           = 32947
A.Skill_Shackle                     = 32905
A.Skill_Spiked_Armor                = 20319
A.Skill_Dragon_Blood                = 29004
A.Skill_Green_Dragon_Blood          = 32744
A.Skill_Coagulating_Blood           = 32722
A.Skill_Inhale                      = 31837
A.Skill_Deep_Breath                 = 32792
A.Skill_Draw_Essence                = 32785
A.Skill_Stonefist                   = 29032
A.Skill_Stone_Giant                 = 31816
A.Skill_Molten_Weapons              = 29043
A.Skill_Igneous_Weapons             = 31874
A.Skill_Shattering_Rocks            = 32678

-- Nightblade
A.Skill_Blur                        = 33375
A.Skill_Mirage                      = 35414
A.Skill_Double_Take                 = 35419
A.Skill_Piercing_Mark               = 36968
A.Skill_Assassins_Will              = 61907
A.Skill_Assassins_Scourge           = 61932
A.Skill_Vulnerability               = GetString(SI_LUIE_SKILL_VULNERABILITY)
A.Skill_Death_Stroke                = 33398
A.Skill_Incapacitating_Strike       = 36508
A.Skill_Soul_Harvest                = 36514
A.Skill_Refreshing_Path             = 36028
A.Skill_Aspect_of_Terror            = 25352
A.Skill_Manifestation_of_Terror     = 37475
A.Skill_Corrode                     = 89010
A.Skill_Dark_Shade                  = 35434
A.Skill_Shadow_Image                = 35441
A.Skill_Swallow_Soul                = 34835
A.Skill_Crippling_Grasp             = 36957
A.Skill_Drain_Power                 = 33316
A.Skill_Power_Extraction            = 36901
A.Skill_Sap_Essence                 = 36891
A.Skill_Soul_Tether                 = 35460

-- Sorcerer
A.Skill_Crystal_Shard               = 43714
A.Skill_Crystal_Blast               = 46331
A.Skill_Crystal_Fragments           = 46324
A.Skill_Rune_Cage                   = 24578
A.Skill_Dark_Exchange               = 24584
A.Skill_Dark_Deal                   = 24595
A.Skill_Dark_Conversion             = 24589
A.Skill_Daedric_Tomb                = 24842
A.Skill_Daedric_Minefield           = 24834
A.Skill_Familiar_Damage_Pulse       = 108844
A.Skill_Winged_Twilight_Restore     = 108845
A.Skill_Tormentor_Damage_Boost      = GetString(SI_LUIE_SKILL_TORMENTOR_DAMAGE_BOOST)
A.Skill_Twilight_Matriarch_Restore  = 77369
A.Skill_Atronach_Zap                = 23428
A.Skill_Greater_Storm_Atronach      = 23492
A.Skill_Summon_Charged_Atronach     = 23495
A.Skill_Mages_Fury                  = 18718
A.Skill_Mages_Wrath                 = 19123
A.Skill_Endless_Fury                = 19109
A.Skill_Critical_Surge              = 23678
A.Skill_Overload                    = 24785
A.Skill_Overload_Heavy_Attack       = 24794

-- Templar
A.Skill_Puncturing_Sweep            = 26797
A.Skill_Aurora_Javelin              = 26800
A.Skill_Empowering_Sweep            = 22144
A.Skill_Crescent_Sweep              = 22139
A.Skill_Purifying_Light             = 21765
A.Skill_Unstable_Core               = 22004
A.Skill_Radiant_Glory               = 63044
A.Skill_Solar_Disturbance           = 21758
A.Skill_Restoring_Aura              = 26209
A.Skill_Repentance                  = 26821
A.Skill_Cleansing_Ritual            = 22265
A.Skill_Rune_Focus                  = 22234
A.Skill_Channeled_Focus             = 22240
A.Skill_Restoring_Focus             = 22237
A.Skill_Rite_Of_Passage             = 22223
A.Skill_Remembrance                 = 22229
A.Skill_Practiced_Incantation       = 22226

-- Warden
A.Skill_Bull_Netch                  = 86058
A.Skill_Falcons_Swiftness           = 86037
A.Skill_Deceptive_Predator          = 86041
A.Skill_Bird_of_Prey                = 86045
A.Skill_Feral_Guardian              = 85982
A.Skill_Eternal_Guardian            = 85986
A.Skill_Enchanted_Growth            = 85862
A.Skill_Healing_Seed                = 85578
A.Skill_Budding_Seeds               = 85840
A.Skill_Corrupting_Pollen           = 85845
A.Skill_Living_Vines                = 85552
A.Skill_Living_Trellis              = 85851
A.Skill_Lotus_Blossom               = 85855
A.Skill_Natures_Grasp               = 85564
A.Skill_Bursting_Vines              = 85859
A.Skill_Natures_Embrace             = 85858
A.Skill_Secluded_Grove              = 85532
A.Skill_Enchanted_Forest            = 85804
A.Skill_Healing_Thicket             = 85807
A.Skill_Frost_Cloak                 = 86122
A.Skill_Expansive_Frost_Cloak       = 86126
A.Skill_Ice_Fortress                = 86130
A.Skill_Crystallized_Shield         = 86135
A.Skill_Crystallized_Slab           = 86139
A.Skill_Shimmering_Shield           = 86143
A.Skill_Frozen_Gate                 = 86175
A.Skill_Frozen_Device               = 86179
A.Skill_Frozen_Retreat              = 86183

-- ---------------------------------------------------
-- WEAPON SKILLS -------------------------------------
-- ---------------------------------------------------

-- Restoration Staff
A.Skill_Blessing_of_Protection      = 37243
A.Skill_Blessing_of_Restoration     = GetString(SI_LUIE_SKILL_BLESSING_OF_RESTORATION)
A.Skill_Combat_Prayer               = 40094
A.Skill_Force_Siphon                = 31531
A.Skill_Siphon_Spirit               = 40109
A.Skill_Quick_Siphon                = 40116

-- Destruction Staff
A.Skill_Crushing_Shock              = 46348
A.Skill_Frozen                      = 68719
A.Skill_Flame_Touch                 = 29073
A.Skill_Frost_Touch                 = 29078
A.Skill_Flame_Clench                = 38985
A.Skill_Shock_Clench                = 38993
A.Skill_Frost_Clench                = 38989

A.Skill_Flame_Reach                 = 38944
A.Skill_Shock_Reach                 = 38978
A.Skill_Frost_Reach                 = 38970

A.Skill_Weakness_to_Elements        = 29173
A.Skill_Elemental_Susceptibility    = 39089
A.Skill_Elemental_Drain             = 39095

-- Two-Handed
A.Skill_Dizzying_Swing              = 38814
A.Skill_Stampede                    = 38788
A.Skill_Cleave                      = 20919
A.Skill_Carve                       = 38745
A.Skill_Brawler                     = 38754
A.Skill_Forward_Momentum            = 38794

-- One Hand & Shield
A.Skill_Pierce_Armor                = 38250
A.Skill_Low_Slash                   = 28304
A.Skill_Heroic_Slash                = 38264
A.Skill_Shield_Charge               = 28719
A.Skill_Invasion                    = 38405
A.Skill_Power_Bash                  = 28365

-- Dual Wield
A.Skill_Twin_Slashes                = 28379
A.Skill_Rending_Slashes             = 38839
A.Skill_Blood_Craze                 = 38845
A.Skill_Quick_Cloak                 = 38901
A.Skill_Deadly_Cloak                = 38906
A.Skill_Hidden_Blade                = 21157
A.Skill_Shrouded_Daggers            = 38914
A.Skill_Flying_Blade                = 38910

-- Bow
A.Skill_Magnum_Shot                 = 38672
A.Skill_Draining_Shot               = 38669
A.Skill_Bombard                     = 38705
A.Skill_Venom_Arrow                 = 38645

-- ---------------------------------------------------
-- ARMOR SKILLS --------------------------------------
-- ---------------------------------------------------

A.Skill_Evasion                     = 29556
A.Skill_Shuffle                     = 39195
A.Skill_Elude                       = 39192

A.Skill_Immovable                   = 29552
A.Skill_Immovable_Brute             = 39205
A.Skill_Unstoppable                 = 39197

-- ---------------------------------------------------
-- VAMPIRE SKILLS -----------------------------------
-- ---------------------------------------------------

A.Skill_Feed                        = 33152

-- ---------------------------------------------------
-- WEREWOLF SKILLS -----------------------------------
-- ---------------------------------------------------

A.Skill_Werewolf_Bleed              = 89146
A.Skill_Devour                      = 32634
A.Skill_Rousing_Roar                = 39114
A.Skill_Piercing_Howl               = 58405
A.Skill_Feeding_Frenzy              = 58775
A.Skill_Howl_of_Despair             = 58742
A.Skill_Howl_of_Agony               = 58798
A.Skill_Infectious_Claws            = 58855
A.Skill_Claws_of_Anguish            = 58864
A.Skill_Claws_of_Life               = 58879
A.Skill_Werewolf_Fear               = 39045

-- ---------------------------------------------------
-- GUILD SKILLS --------------------------------------
-- ---------------------------------------------------

-- Dark Brotherhood
A.Skill_Blade_of_Woe                = 78219

-- Fighters Guild
A.Skill_Circle_of_Protection        = 35737
A.Skill_Turn_Undead                 = 40181
A.Skill_Ring_of_Preservation        = 40169
A.Skill_Expert_Hunter               = 35762
A.Skill_Revealed                    = 11717
A.Skill_Trap_Beast                  = 35750
A.Skill_Rearming_Trap               = 40382
A.Skill_Lightweight_Beast_Trap      = 40372

-- Mages Guild
A.Skill_Magelight                   = 30920
A.Skill_Inner_Light                 = 40478
A.Skill_Radiant_Magelight           = 40483
A.Skill_Spell_Symmetry              = 40445
A.Skill_Balance                     = 40441
A.Skill_Meteor                      = 16536
A.Skill_Ice_Comet                   = 40489

-- Psijic Order
A.Skill_Imbue_Weapon                = 103483
A.Skill_Elemental_Weapon            = 103571
A.Skill_Crushing_Weapon             = 103623
A.Skill_Accelerate                  = 103503
A.Skill_Channeled_Acceleration      = 103706
A.Skill_Race_Against_Time           = 103710
A.Skill_Symbiosis                   = 103755

-- Undaunted
A.Skill_Black_Widows                = 41994
A.Skill_Arachnophobia               = 42016
A.Skill_Healing_Combustion          = 63507

-- ---------------------------------------------------
-- ALLIANCE WAR --------------------------------------
-- ---------------------------------------------------

-- Assault
A.Skill_Rapid_Maneuver              = 38566
A.Skill_Retreating_Maneuver         = 40211
A.Skill_Charging_Maneuver           = 40215
A.Skill_Caltrops                    = 33376
A.Skill_Razor_Caltrops              = 40242

-- Support
A.Skill_Efficient_Purge             = 40232
A.Skill_Lingering_Flare             = 61519
A.Skill_Scorching_Flare             = 61524
A.Skill_Reviving_Barrier            = 40237

-- ---------------------------------------------------
-- CYRODIIL ------------------------------------------
-- ---------------------------------------------------

A.Skill_Battle_Spirit               = GetString(SI_LUIE_SKILL_BATTLE_SPIRIT)

-- ---------------------------------------------------
-- NPC ABILITIES -------------------------------------
-- ---------------------------------------------------

-- Shared/Basic

A.Skill_Hamstring                   = 70068
A.Skill_Backstabber                 = 13739

-- Human
A.Skill_Oil_Drenched                = 10650
A.Skill_Shield_Rush                 = GetString(SI_LUIE_SKILL_SHIELD_RUSH)
A.Skill_Knockback                   = 77905
A.Skill_Weakness                    = 8705
A.Skill_Staff_Strike                = 2901
A.Skill_Ice_Barrier                 = 14178
A.Skill_Vanish                      = 24687
A.Skill_Bone_Cage                   = 35387
A.Skill_Defensive_Ward              = GetString(SI_LUIE_SKILL_DEFENSIVE_WARD)
A.Skill_Great_Cleave                = GetString(SI_LUIE_SKILL_GREAT_CLEAVE)
A.Skill_Retaliation                 = 65033
A.Skill_Divine_Leap                 = 54027
A.Skill_Inspire                     = GetString(SI_LUIE_SKILL_INSPIRE)
A.Skill_Hide_in_Shadows             = GetString(SI_LUIE_SKILL_HIDE_IN_SHADOWS)
A.Skill_Recovering                  = 4197
A.Skill_Lunge                       = 78664
A.Skill_Clobber                     = 24671
A.Skill_Shadowy_Barrier             = GetString(SI_LUIE_SKILL_SHADOWY_BARRIER)

-- Justice
A.Skill_Cage_Talons                 = 63168
A.Skill_Heavy_Blow                  = 63157
A.Skill_Mighty_Charge               = GetString(SI_LUIE_SKILL_MIGHTY_CHARGE)
A.Skill_Throw_Dagger                = 28499
A.Skill_Detection                   = GetString(SI_LUIE_SKILL_DETECTION)

-- Cyrodiil
A.Skill_Shock_Torrent               = 46726
A.Skill_Improved_Shock_Torrent      = GetString(SI_LUIE_SKILL_IMPROVED_SHOCK_TORRENT)
A.Skill_Steal_Essence               = 2786
A.Skill_Lasting_Storm               = 46818
A.Skill_Bleeding_Strike             = 46830
A.Skill_Telekinetic_Prison          = 21636
A.Skill_Shattering_Prison           = 46905
A.Skill_Siege_Barrier               = GetString(SI_LUIE_SKILL_SIEGE_BARRIER)
A.Skill_Fire_Torrent                = GetString(SI_LUIE_SKILL_FIRE_TORRENT)
A.Skill_Improved_Fire_Torrent       = 46990
A.Skill_Extended_Chains             = 35113
A.Skill_Puncturing_Chains           = GetString(SI_LUIE_SKILL_PUNCTURING_CHAINS)
A.Skill_Improved_Volley             = GetString(SI_LUIE_SKILL_IMPROVED_VOLLEY)

-- Animals
A.Skill_Lacerate                    = 5452
A.Skill_Bite                        = 17957
A.Skill_Savage_Blows                = 4416
A.Skill_Slam                        = 70366
A.Skill_Rip_and_Tear                = GetString(SI_LUIE_SKILL_RIP_AND_TEAR)
A.Skill_Rush                        = 14380
A.Skill_Vigorus_Swipes              = 75634
A.Skill_Barreling_Charge            = GetString(SI_LUIE_SKILL_BARRELING_CHARGE)
A.Skill_Swipe                       = 2850
A.Skill_Blitz                       = GetString(SI_LUIE_SKILL_BLITZ)
A.Skill_Toxic_Mucus                 = 72793
A.Skill_Bog_Burst                   = 72796
A.Skill_Gore                        = 85202
A.Skill_Bile_Spit                   = 64559

-- Insects
A.Skill_Paralyze                    = 6756
A.Skill_Poisonous_Burst             = 5790
A.Skill_Web                         = 58521
A.Skill_Inject_Larva                = 9229
A.Skill_Zoom                        = GetString(SI_LUIE_SKILL_ZOOM)
A.Skill_Latch_On                    = 6795
A.Skill_Vile_Bite                   = 61243
A.Skill_Infectious_Swarm            = 61360
A.Skill_Necrotic_Explosion          = 61427
A.Skill_Contagion                   = 47838
A.Skill_Plow                        = GetString(SI_LUIE_SKILL_PLOW)
A.Skill_Zap                         = 8429
A.Skill_Leeching_Bite               = GetString(SI_LUIE_SKILL_LEECHING_BITE)
A.Skill_Fetcherfly_Colony           = GetString(SI_LUIE_SKILL_FETCHERFLY_COLONY)

-- Daedra
A.Skill_Empower_Atronach_Flame      = GetString(SI_LUIE_SKILL_EMPOWER_ATRONACH_FLAME)
A.Skill_Empower_Atronach_Frost      = GetString(SI_LUIE_SKILL_EMPOWER_ATRONACH_FROST)
A.Skill_Empower_Atronach_Storm      = GetString(SI_LUIE_SKILL_EMPOWER_ATRONACH_STORM)
A.Skill_Lightning_Rod               = 50023
A.Skill_Headbutt                    = 54380
A.Skill_Tail_Spike                  = 4799
A.Skill_Rending_Leap                = 93745
A.Skill_Radiance                    = 4891
A.Skill_Unyielding_Mace             = 4817
A.Skill_Tremor                      = 67123
A.Skill_Pin                         = 65709
A.Skill_Sweep                       = 67872
A.Skill_Enrage                      = 71696
A.Skill_Chilling_Aura               = 33549
A.Skill_Frozen_Ground               = 33502
A.Skill_Body_Slam                   = 24689
A.Skill_Stomp                       = 91848
A.Skill_Storm_Bound                 = 4864
A.Skill_Shockwave                   = 4653
A.Skill_Dusks_Howl                  = 6412

-- Undead
A.Skill_Desecrated_Ground           = 38828
A.Skill_Colossal_Stomp              = GetString(SI_LUIE_SKILL_COLOSSAL_STOMP)
A.Skill_Defiled_Ground              = 22521
A.Skill_Soul_Rupture                = 73931
A.Skill_Winters_Reach               = 4337

-- Monsters
A.Skill_Luring_Snare                = 2821
A.Skill_Assault                     = 4304
A.Skill_Flame_Ray                   = 17703
A.Skill_Frost_Ray                   = 81794
A.Skill_Consuming_Omen              = 48282
A.Skill_Crushing_Limbs              = 3855
A.Skill_Pillars_of_Nirn             = 75955
A.Skill_Claw                        = 27922

-- Dwemer
A.Skill_Static_Shield               = 64463
A.Skill_Dart                        = 7485
A.Skill_Split_Bolt                  = 91093
A.Skill_Turret_Mode                 = 71045
A.Skill_Overcharge                  = 27333

-- ---------------------------------------------------
-- TRAPS ---------------------------------------------
-- ---------------------------------------------------

A.Trap_Cold_Fire_Trap               = GetString(SI_LUIE_SKILL_COLD_FIRE_TRAP)
A.Trap_Falling_Rocks                = 20886

-- ---------------------------------------------------
-- QUEST ABILITIES -----------------------------------
-- ---------------------------------------------------

-- Seasonal
A.Skill_Lava_Foot_Stomp             = GetString(SI_LUIE_SKILL_LAVA_FOOT_STOMP)
A.Skill_Dagger_Juggling             = 84506
A.Skill_Torch_Juggling              = GetString(SI_LUIE_SKILL_TORCH_JUGGLING)
A.Skill_Sword_Swallowing            = 84533
A.Skill_Celebratory_Belch           = 84847

-- MSQ
A.Skill_Wall_of_Flames              = GetString(SI_LUIE_SKILL_WALL_OF_FLAMES)
A.Skill_Focused_Healing             = 48345

-- ---------------------------------------------------
-- OTHER EFFECTS -------------------------------------
-- ---------------------------------------------------

-- Sanctum Ophidia
A.Effect_Magicka_Bomb               = 59036

-- vMOL Debuffs
A.Effect_Colossal_Mark              = 75672
A.Effect_Shattered                  = 75071
A.Effect_Shattered2                 = 73250
A.Effect_Grip_of_Lorkaj             = 57517
A.Effect_Unstable_Void              = 74488
A.Effect_Curse_Duration             = 25000


-- Replace ability IDs with names
local pairs = pairs
for k, v in pairs(A) do
    if type(v) == "number" then
        A[k] = GetAbilityName(v)
    end
end

-- Export string data to global namespace
LUIE.GetAbility = function() return A end
