-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiData
local LuiData = LuiData

local Unitnames = LuiData.Data.UnitNames
local Zonenames = LuiData.Data.ZoneNames
local Abilities = LuiData.Data.Abilities
local ZoneTable = LuiData.Data.ZoneTable

--- @class (partial) AlertZoneOverride
local AlertZoneOverride =
{

    [7835] =
    {                                                                 -- Convalescence (Lamia)
        [131] = Unitnames.NPC_Lamia_Curare,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Lamia_Curare, -- Tempest Island
    },
    [9680] =
    {                                                                 -- Summon Spectral Lamia
        [131] = Unitnames.NPC_Lamia_Curare,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Lamia_Curare, -- Tempest Island
    },

    [35220] =
    { -- Impending Storm (Storm Atronach)

        -- DUNGEONS
        [681] = Unitnames.NPC_Storm_Atronach,                           -- City of Ash II
        [131] = Unitnames.NPC_Storm_Atronach,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Storm_Atronach, -- Tempest Island
    },

    [54021] =
    { -- Release Flame (Marruz)

        -- DUNGEONS
        [681] = Unitnames.NPC_Xivilai_Immolator, -- City of Ash II
    },

    [4591] =
    { -- Sweep (Crocodile)

        -- DUNGEONS
        [681] = Unitnames.NPC_Crocodile, -- City of Ash II
    },

    [34742] =
    { -- Fiery Breath (Dragonknight)

        -- DUNGEONS
        [176] = Unitnames.NPC_Dremora_Kynval,   -- City of Ash I
        [681] = Unitnames.NPC_Dremora_Kynval,   -- City of Ash 2
        [22] = Unitnames.NPC_Imperial_Overseer, -- Volenfell
    },

    [57534] =
    { -- Focused Healing (Healer)

        -- DUNGEONS
        -- [126] = Unitnames.NPC_Darkfern_Healer, -- Elden Hollow I -- Can't add because of Thalmor healers at the beginning of the dungeon.
        [931] = Unitnames.NPC_Dremora_Invoker,                            -- Elden Hollow II
        [681] = Unitnames.NPC_Dremora_Gandrakyn,                          -- City of Ash II
        [131] = Unitnames.NPC_Sea_Viper_Healer,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Sea_Viper_Healer, -- Tempest Island
        [932] = Unitnames.NPC_Spiderkith_Cauterizer,                      -- Crypt of Hearts II
        [22] = Unitnames.NPC_Treasure_Hunter_Healer,                      -- Volenfell
    },

    [35151] =
    { -- Spell Absorption (Spirit Mage)

        -- DUNGEONS
        [931] = Unitnames.NPC_Dremora_Invoker, -- Elden Hollow II
    },
    [14472] =
    { -- Burdening Eye (Spirit Mage)

        -- DUNGEONS
        [931] = Unitnames.NPC_Dremora_Invoker, -- Elden Hollow II
    },

    [12459] =
    {                                                -- Winter's Reach (Frost Mage)
        -- QUESTS
        [1160] = Unitnames.NPC_Icereach_Chillrender, -- Deepwood Vale (Greymoor)
        -- DUNGEONS
        [380] = Unitnames.NPC_Banished_Mage,         -- Banished Cells I
    },
    [14194] =
    {                                                -- Ice Barrier (Frost Mage)
        -- QUESTS
        [1160] = Unitnames.NPC_Icereach_Chillrender, -- Deepwood Vale (Greymoor)
        -- DUNGEONS
        [380] = Unitnames.NPC_Banished_Mage,         -- Banished Cells I
    },

    [4337] =
    {                                        -- Winter's Reach (Wraith)
        -- DUNGEONS
        [380] = Unitnames.Boss_Cell_Haunter, -- Banished Cells I
        [935] = Unitnames.NPC_Wraith,        -- Banished Cells II (Summon Only)
        [130] = Unitnames.NPC_Wraith,        -- Crypt of Hearts I
    },

    [36985] =
    {                                             -- Void (Time Bomb Mage)
        [555] = Unitnames.Boss_Vicereeve_Pelidil, -- Abecean Sea

        -- DUNGEONS
        [130] = Unitnames.NPC_Skeletal_Runecaster, -- Crypt of Hearts I
        [932] = Unitnames.Boss_Mezeluth,           -- Crypt of Hearts II
    },

    [29471] =
    {                                                                 -- Thunder Thrall (Storm Mage)
        [Zonenames.Zone_Tanzelwil] = Unitnames.NPC_Ancestral_Tempest, -- Tanzelwil
        [416] = Unitnames.NPC_Ancestral_Tempest,                      -- Inner Tanzelwil
        [810] = Unitnames.Elite_Canonreeve_Malanie,                   -- Smuggler's Tunnel (Auridon)
        -- [Zonenames.Zone_Castle_Rilis] = Unitnames.NPC_Skeletal_Tempest, -- Castle Rilis (Auridon) -- Can't, elite here stops this from working
        [392] = Unitnames.NPC_Skeletal_Tempest,                       -- The Vault of Exile (Auridon)
        [394] = Unitnames.Elite_Uricantar,                            -- Ezduiin Undercroft (Auridon)

        -- DC Zones
        [534] = Unitnames.Elite_King_Demog,        -- King Demog (Stros M'Kai)

        [389] = Unitnames.NPC_Spectral_Storm_Mage, -- Reliquary Ruins
        [555] = Unitnames.NPC_Sea_Viper_Tempest,   -- Abecean Sea

        -- DUNGEONS
        [681] = Unitnames.NPC_Urata_Elementalist,   -- City of Ash II
        [932] = Unitnames.NPC_Spiderkith_Enervator, -- Crypt of Hearts II
    },
    [29510] =
    {                                                                    -- Thunder Hammer (Thundermaul)
        [Zonenames.Zone_Maormer_Invasion_Camp] = Unitnames.Elite_Arstul, -- Maormer Invasion Camp (Auridon)
        [394] = Unitnames.NPC_Thundermaul,                               -- Ezduiin Undercroft (Auridon)
        [399] = Unitnames.NPC_Skeletal_Thundermaul,                      -- Wansalen (Auridon - Delve)

        [435] = Unitnames.NPC_Sainted_Charger,                           -- Cathedral of the Golden Path
        [555] = Unitnames.NPC_Sea_Viper_Charger,                         -- Abecean Sea

        -- Greymoor
        [1160] = Unitnames.NPC_Icereach_Charger, -- Deepwood Vale (Greymoor)

        -- DUNGEONS
        [131] = Unitnames.NPC_Sea_Viper_Charger,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Sea_Viper_Charger, -- Tempest Island
    },
    [17867] =
    {                                                                    -- Shock Aura (Thundermaul)
        [Zonenames.Zone_Maormer_Invasion_Camp] = Unitnames.Elite_Arstul, -- Maormer Invasion Camp (Auridon)
        [394] = Unitnames.NPC_Thundermaul,                               -- Ezduiin Undercroft (Auridon)
        [399] = Unitnames.NPC_Skeletal_Thundermaul,                      -- Wansalen (Auridon - Delve)

        [435] = Unitnames.NPC_Sainted_Charger,                           -- Cathedral of the Golden Path
        [555] = Unitnames.NPC_Sea_Viper_Charger,                         -- Abecean Sea

        -- Greymoor
        [1160] = Unitnames.NPC_Icereach_Charger, -- Deepwood Vale (Greymoor)

        -- DUNGEONS
        [126] = Unitnames.Boss_Nenesh_gro_Mal,                             -- Elden Hollow I
        [131] = Unitnames.NPC_Sea_Viper_Charger,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Sea_Viper_Charger, -- Tempest Island
    },
    [29520] =
    { -- Aura of Protection (Shaman)

        -- DUNGEONS
        [931] = Unitnames.Boss_The_Shadow_Guard, -- Elden Hollow II
        -- [176] = Unitnames.NPC_Dremora_Hauzkyn, -- City of Ash I -- Can't use due to Dremora Shaman
    },
    [28408] =
    { -- Whirlwind (Skirmisher)

        -- QUESTS
        [968] = Unitnames.NPC_Slaver_Cutthroat,                                        -- Firemoth Island (Vvardenfell)

        [Zonenames.Zone_Mathiisen] = Unitnames.NPC_Heritance_Cutthroat,                -- Mathiisen (Auridon)
        [810] = Unitnames.NPC_Heritance_Cutthroat,                                     -- Smuggler's Tunnel (Auridon)
        -- [Zonenames.Zone_Castle_Rilis] = Unitnames.NPC_Skeletal_Striker, -- Castle Rilis (Auridon) -- Can't, elite here stops this from working
        [392] = Unitnames.NPC_Skeletal_Striker,                                        -- The Vault of Exile (Auridon)
        [Zonenames.Zone_Soulfire_Plateau] = Unitnames.NPC_Skeletal_Slayer,             -- Soulfire Plateau (Auridon)
        [Zonenames.Zone_Silsailen] = Unitnames.NPC_Heritance_Cutthroat,                -- Silsailen (Auridon)
        [Zonenames.Zone_Errinorne_Isle] = Unitnames.NPC_Heritance_Cutthroat,           -- Errinorne Isle (Auridon)
        [Zonenames.Zone_Quendeluun] = Unitnames.NPC_Heritance_Cutthroat,               -- Quendeluun (Auridon)
        [Zonenames.Zone_Wansalen] = Unitnames.NPC_Heritance_Cutthroat,                 -- Quendeluun (Auridon) - For a little section with npcs outside of the delv near Quendeluun.
        [393] = Unitnames.NPC_Heritance_Cutthroat,                                     -- Saltspray Cave (Auridon)
        [390] = Unitnames.NPC_Heritance_Cutthroat,                                     -- The Veiled Keep
        [Zonenames.Zone_Heritance_Proving_Ground] = Unitnames.NPC_Heritance_Cutthroat, -- Heritance Proving Ground (Auridon)
        [Zonenames.Zone_Isle_of_Contemplation] = Unitnames.Elite_Karulae,              -- Isle of Contemplation (Auridon)

        [548] = Unitnames.NPC_Bandit_Rogue,                                            -- Silatar

        -- DUNGEONS
        [126] = Unitnames.NPC_Darkfern_Stalker,                                 -- Elden Hollow I
        -- [176] = Unitnames.NPC_Dagonite_Assassin, -- City of Ash I -- Can't use due to Assassin Exemplar
        [681] = Unitnames.NPC_Urata_Militant,                                   -- City of Ash II
        [Zonenames.Zone_Tempest_Island] = Unitnames.Boss_Yalorasse_the_Speaker, -- Tempest Island
    },
    [37108] =
    {                                                                                 -- Arrow Spray (Archer)
        -- QUESTS
        [0] = Unitnames.NPC_Skeletal_Archer,                                          -- The Wailing Prison (Soul Shriven in Coldharbour)
        [968] = Unitnames.NPC_Slaver_Archer,                                          -- Firemoth Island (Vvardenfell)
        [1013] = Unitnames.NPC_Dessicated_Archer,                                     -- Summerset (The Mind Trap)

        [Zonenames.Zone_Maormer_Invasion_Camp] = Unitnames.NPC_Sea_Viper_Deadeye,     -- Maormer Invasion Camp (Auridon)
        [Zonenames.Zone_South_Beacon] = Unitnames.NPC_Sea_Viper_Deadeye,              -- South Beacon (Auridon)
        [Zonenames.Zone_Mathiisen] = Unitnames.NPC_Heritance_Deadeye,                 -- Mathiisen (Auridon)
        [810] = Unitnames.NPC_Heritance_Deadeye,                                      -- Smuggler's Tunnel (Auridon)
        -- [Zonenames.Zone_Castle_Rilis] = Unitnames.NPC_Skeletal_Archer, -- Castle Rilis (Auridon) -- Can't, elite here stops this from working
        [392] = Unitnames.NPC_Skeletal_Archer,                                        -- The Vault of Exile (Auridon)
        [Zonenames.Zone_Soulfire_Plateau] = Unitnames.NPC_Skeletal_Archer,            -- Soulfire Plateau (Auridon)
        [Zonenames.Zone_Hightide_Keep] = Unitnames.NPC_Skeletal_Archer,               -- Hightide Keep (Auridon)
        [Zonenames.Zone_Errinorne_Isle] = Unitnames.NPC_Heritance_Deadeye,            -- Errinorne Isle (Auridon)
        [Zonenames.Zone_Captain_Blanchetes_Ship] = Unitnames.NPC_Ghost_Viper_Deadeye, -- Captain Blanchete's Ship (Auridon)
        [Zonenames.Zone_Ezduiin] = Unitnames.NPC_Spirit_Deadeye,                      -- Ezduiin (Auridon)
        [Zonenames.Zone_Quendeluun] = Unitnames.Elite_Centurion_Earran,               -- Quendeluun (Auridon)
        [393] = Unitnames.Elite_Malangwe,                                             -- Saltspray Cave (Auridon)
        [390] = Unitnames.NPC_Heritance_Deadeye,                                      -- The Veiled Keep
        [Zonenames.Zone_Heritance_Proving_Ground] = Unitnames.NPC_Heritance_Deadeye,  -- Heritance Proving Ground (Auridon)

        -- Daggerfall Covenant
        [Zonenames.Zone_The_Grave] = Unitnames.NPC_Grave_Archer, -- Stros M'Kai

        --
        [435] = Unitnames.NPC_Sainted_Archer, -- Cathedral of the Golden Path

        -- Greymoor
        [1160] = Unitnames.NPC_Icereach_Thornslinger, -- Deepwood Vale (Greymoor)

        -- DUNGEONS
        [130] = Unitnames.NPC_Skeletal_Archer,                             -- Crypt of Hearts I
        [380] = Unitnames.NPC_Banished_Archer,                             -- Banished Cells I
        [935] = Unitnames.NPC_Banished_Archer,                             -- Banished Cells II
        [126] = Unitnames.NPC_Darkfern_Archer,                             -- Elden Hollow I
        [681] = Unitnames.NPC_Xivilai_Immolator,                           -- City of Ash II
        [131] = Unitnames.NPC_Sea_Viper_Deadeye,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Sea_Viper_Deadeye, -- Tempest Island
        [932] = Unitnames.NPC_Spiderkith_Wefter,                           -- Crypt of Hearts II
    },
    [28628] =
    {                                                                                 -- Volley (Archer)
        -- QUESTS
        [968] = Unitnames.NPC_Slaver_Archer,                                          -- Firemoth Island (Vvardenfell)
        [1013] = Unitnames.NPC_Dessicated_Archer,                                     -- Summerset (The Mind Trap)

        [Zonenames.Zone_Maormer_Invasion_Camp] = Unitnames.NPC_Sea_Viper_Deadeye,     -- Maormer Invasion Camp (Auridon)
        [Zonenames.Zone_South_Beacon] = Unitnames.NPC_Sea_Viper_Deadeye,              -- South Beacon (Auridon)
        [Zonenames.Zone_Mathiisen] = Unitnames.NPC_Heritance_Deadeye,                 -- Mathiisen (Auridon)
        [810] = Unitnames.NPC_Heritance_Deadeye,                                      -- Smuggler's Tunnel (Auridon)
        -- [Zonenames.Zone_Castle_Rilis] = Unitnames.NPC_Skeletal_Archer, -- Castle Rilis (Auridon) -- Can't, elite here stops this from working
        [392] = Unitnames.NPC_Skeletal_Archer,                                        -- The Vault of Exile (Auridon)
        [Zonenames.Zone_Soulfire_Plateau] = Unitnames.NPC_Skeletal_Archer,            -- Soulfire Plateau (Auridon)
        [Zonenames.Zone_Hightide_Keep] = Unitnames.NPC_Skeletal_Archer,               -- Hightide Keep (Auridon)
        [Zonenames.Zone_Errinorne_Isle] = Unitnames.NPC_Heritance_Deadeye,            -- Errinorne Isle (Auridon)
        [Zonenames.Zone_Captain_Blanchetes_Ship] = Unitnames.NPC_Ghost_Viper_Deadeye, -- Captain Blanchete's Ship (Auridon)
        [Zonenames.Zone_Ezduiin] = Unitnames.NPC_Spirit_Deadeye,                      -- Ezduiin (Auridon)
        [Zonenames.Zone_Quendeluun] = Unitnames.Elite_Centurion_Earran,               -- Quendeluun (Auridon)
        [393] = Unitnames.Elite_Malangwe,                                             -- Saltspray Cave (Auridon)
        [390] = Unitnames.NPC_Heritance_Deadeye,                                      -- The Veiled Keep
        [Zonenames.Zone_Heritance_Proving_Ground] = Unitnames.NPC_Heritance_Deadeye,  -- Heritance Proving Ground (Auridon)

        -- Daggerfall Covenant
        [Zonenames.Zone_The_Grave] = Unitnames.NPC_Grave_Archer, -- Stros M'Kai

        --
        [435] = Unitnames.NPC_Sainted_Archer, -- Cathedral of the Golden Path

        -- Greymoor
        [1160] = Unitnames.NPC_Icereach_Thornslinger, -- Deepwood Vale (Greymoor)

        -- DUNGEONS
        [130] = Unitnames.NPC_Skeletal_Archer,                             -- Crypt of Hearts I
        [380] = Unitnames.NPC_Banished_Archer,                             -- Banished Cells I
        [935] = Unitnames.NPC_Banished_Archer,                             -- Banished Cells II
        [126] = Unitnames.NPC_Darkfern_Archer,                             -- Elden Hollow I
        [681] = Unitnames.NPC_Xivilai_Immolator,                           -- City of Ash II
        [131] = Unitnames.NPC_Sea_Viper_Deadeye,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Sea_Viper_Deadeye, -- Tempest Island
        [932] = Unitnames.NPC_Spiderkith_Wefter,                           -- Crypt of Hearts II
    },
    [12439] =
    {                                                                                 -- Burning Arrow (Synergy)
        -- QUESTS
        [968] = Unitnames.NPC_Slaver_Archer,                                          -- Firemoth Island (Vvardenfell)
        [1013] = Unitnames.NPC_Dessicated_Archer,                                     -- Summerset (The Mind Trap)

        [Zonenames.Zone_Maormer_Invasion_Camp] = Unitnames.NPC_Sea_Viper_Deadeye,     -- South Beacon (Auridon)
        [Zonenames.Zone_South_Beacon] = Unitnames.NPC_Sea_Viper_Deadeye,              -- South Beacon (Auridon)
        [Zonenames.Zone_Mathiisen] = Unitnames.NPC_Heritance_Deadeye,                 -- Mathiisen (Auridon)
        [810] = Unitnames.NPC_Heritance_Deadeye,                                      -- Smuggler's Tunnel (Auridon)
        -- [Zonenames.Zone_Castle_Rilis] = Unitnames.NPC_Skeletal_Archer, -- Castle Rilis (Auridon) -- Can't, elite here stops this from working
        [392] = Unitnames.NPC_Skeletal_Archer,                                        -- The Vault of Exile (Auridon)
        [Zonenames.Zone_Soulfire_Plateau] = Unitnames.NPC_Skeletal_Archer,            -- Soulfire Plateau (Auridon)
        [Zonenames.Zone_Hightide_Keep] = Unitnames.NPC_Skeletal_Archer,               -- Hightide Keep (Auridon)
        [Zonenames.Zone_Errinorne_Isle] = Unitnames.NPC_Heritance_Deadeye,            -- Errinorne Isle (Auridon)
        [Zonenames.Zone_Captain_Blanchetes_Ship] = Unitnames.NPC_Ghost_Viper_Deadeye, -- Captain Blanchete's Ship (Auridon)
        [Zonenames.Zone_Ezduiin] = Unitnames.NPC_Spirit_Deadeye,                      -- Ezduiin (Auridon)
        [Zonenames.Zone_Quendeluun] = Unitnames.Elite_Centurion_Earran,               -- Quendeluun (Auridon)
        [393] = Unitnames.Elite_Malangwe,                                             -- Saltspray Cave (Auridon)
        [390] = Unitnames.NPC_Heritance_Deadeye,                                      -- The Veiled Keep
        [Zonenames.Zone_Heritance_Proving_Ground] = Unitnames.NPC_Heritance_Deadeye,  -- Heritance Proving Ground (Auridon)

        -- Daggerfall Covenant
        [534] = Unitnames.NPC_Grave_Archer, -- Stros M'Kai

        --
        [435] = Unitnames.NPC_Sainted_Archer, -- Cathedral of the Golden Path

        -- DUNGEONS
        [130] = Unitnames.NPC_Skeletal_Archer, -- Crypt of Hearts I
        [380] = Unitnames.NPC_Banished_Archer, -- Banished Cells I
        [935] = Unitnames.NPC_Banished_Archer, -- Banished Cells II
        [126] = Unitnames.NPC_Darkfern_Archer, -- Elden Hollow I
        [176] = Unitnames.NPC_Dagonite_Archer, -- City of Ash I
    },

    [26324] =
    { -- Lava Geyser (Flame Atronach)

        -- DUNGEONS
        [935] = Unitnames.NPC_Flame_Atronach, -- Banished Cells II
        [176] = Unitnames.NPC_Flame_Atronach, -- City of Ash I
        [681] = Unitnames.NPC_Flame_Atronach, -- City of Ash II
    },

    -- [88554] = { -- Summon the Dead (Necromancer)
    --
    -- },
    [88555] =
    {                                                                                 -- Summon the Dead (Necromancer)
        [Zonenames.Zone_Tower_of_the_Vale] = Unitnames.Elite_Sanessalmo,              -- Tower of the Vale (Auridon)
        [Zonenames.Zone_Quendeluun] = Unitnames.NPC_Pact_Necromancer,                 -- Quendeluun (Auridon)
        [Zonenames.Zone_Wansalen] = Unitnames.NPC_Pact_Necromancer,                   -- Quendeluun (Auridon) - For a little section with npcs outside of the delv near Quendeluun.
        [Zonenames.Zone_Torinaan] = Unitnames.Elite_Vregas,                           -- Torinaan (Auridon)

        [395] = Unitnames.NPC_Dremora_Narkynaz,                                       -- The Refuge of Dread
        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Veiled_Necromancer,                -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Veiled_Necromancer,         -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Veiled_Necromancer,      -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Veiled_Necromancer, -- Hectahame Ritual Chamber
    },
    -- [88556] = { -- Summon the Dead (Necromancer)
    --

    [13397] =
    {                                                -- Empower Undead (Necromancer)
        -- DUNGEONS
        [932] = Unitnames.NPC_Spiderkith_Broodnurse, -- Crypt of Hearts II
    },

    -- },
    [10805] =
    {                                                                          -- Ignite (Synergy)
        -- QUESTS
        [1013] = Unitnames.NPC_Dessicated_Fire_Mage,                           -- Summerset (The Mind Trap)
        -- Auridon
        [Zonenames.Zone_Silsailen] = Unitnames.NPC_Heritance_Incendiary,       -- Silsailen (Auridon)
        [Zonenames.Zone_Tower_of_the_Vale] = Unitnames.Elite_Minantilles_Rage, -- Tower of the Vale (Auridon)
        [Zonenames.Zone_Quendeluun] = Unitnames.NPC_Pact_Pyromancer,           -- Quendeluun (Auridon)
        [Zonenames.Zone_Wansalen] = Unitnames.NPC_Pact_Pyromancer,             -- Quendeluun (Auridon) - For a little section with npcs outside of the delv near Quendeluun.

        --
        [389] = Unitnames.NPC_Skeletal_Infernal,                                   -- Reliquary Ruins
        [548] = Unitnames.NPC_Bandit_Incendiary,                                   -- Silitar
        [555] = Unitnames.Boss_Vicereeve_Pelidil,                                  -- Abecean Sea
        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Veiled_Infernal,                -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Veiled_Infernal,         -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Veiled_Infernal,      -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Veiled_Infernal, -- Hectahame Ritual Chamber

        -- Daggerfall Covenant
        [534] = Unitnames.NPC_Dogeater_Witch, -- Stros M'Kai

        -- DUNGEONS
        -- [130] = Unitnames.NPC_Skeletal_Pyromancer, -- Crypt of Hearts I -- Can't use because The Mage Master's Slave(s) also use these spells
        [380] = Unitnames.NPC_Scamp,                     -- Banished Cells I
        [935] = Unitnames.NPC_Dremora_Kyngald,           -- Banished Cells II
        [126] = Unitnames.NPC_Darkfern_Flamerender,      -- Elden Hollow I
        [176] = Unitnames.NPC_Scamp,                     -- City of Ash I
        [22] = Unitnames.NPC_Treasure_Hunter_Incendiary, -- Volenfell
    },
    [15164] =
    { -- Heat Wave (Fire Mage)

        -- QUESTS
        [0] = Unitnames.NPC_Skeletal_Pyromancer,                               -- The Wailing Prison (Soul Shriven in Coldharbour)
        [1013] = Unitnames.NPC_Dessicated_Fire_Mage,                           -- Summerset (The Mind Trap)

        [Zonenames.Zone_Silsailen] = Unitnames.NPC_Heritance_Incendiary,       -- Silsailen (Auridon)
        [Zonenames.Zone_Tower_of_the_Vale] = Unitnames.Elite_Minantilles_Rage, -- Tower of the Vale (Auridon)
        [Zonenames.Zone_Quendeluun] = Unitnames.NPC_Pact_Pyromancer,           -- Quendeluun (Auridon)
        [Zonenames.Zone_Wansalen] = Unitnames.NPC_Pact_Pyromancer,             -- Quendeluun (Auridon) - For a little section with npcs outside of the delv near Quendeluun.

        --
        [389] = Unitnames.NPC_Skeletal_Infernal,                                   -- Reliquary Ruins
        [548] = Unitnames.NPC_Bandit_Incendiary,                                   -- Silitar
        [555] = Unitnames.Boss_Vicereeve_Pelidil,                                  -- Abecean Sea
        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Veiled_Infernal,                -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Veiled_Infernal,         -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Veiled_Infernal,      -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Veiled_Infernal, -- Hectahame Ritual Chamber

        -- Daggerfall Covenant
        [534] = Unitnames.NPC_Dogeater_Witch, -- Stros M'Kai

        -- DUNGEONS
        -- [130] = Unitnames.NPC_Skeletal_Pyromancer, -- Crypt of Hearts I -- Can't use because The Mage Master's Slave(s) also use these spells
        [380] = Unitnames.Boss_Angata_the_Clannfear_Handler, -- Banished Cells I
        [935] = Unitnames.NPC_Dremora_Kyngald,               -- Banished Cells II
        [126] = Unitnames.NPC_Darkfern_Flamerender,          -- Elden Hollow I
        [681] = Unitnames.NPC_Dremora_Kyngald,               -- City of Ash II
        [932] = Unitnames.NPC_Spiderkith_Cauterizer,         -- Crypt of Hearts II
        [22] = Unitnames.NPC_Treasure_Hunter_Incendiary,     -- Volenfell
    },
    [47095] =
    {                                                                          -- Fire Rune (Fire Mage)
        -- QUESTS
        [1013] = Unitnames.NPC_Dessicated_Fire_Mage,                           -- Summerset (The Mind Trap)
        -- Auridon
        [Zonenames.Zone_Silsailen] = Unitnames.NPC_Heritance_Incendiary,       -- Silsailen (Auridon)
        [Zonenames.Zone_Tower_of_the_Vale] = Unitnames.Elite_Minantilles_Rage, -- Tower of the Vale (Auridon)
        [Zonenames.Zone_Quendeluun] = Unitnames.NPC_Pact_Pyromancer,           -- Quendeluun (Auridon)
        [Zonenames.Zone_Wansalen] = Unitnames.NPC_Pact_Pyromancer,             -- Quendeluun (Auridon) - For a little section with npcs outside of the delv near Quendeluun.

        --
        [389] = Unitnames.NPC_Skeletal_Infernal,                                   -- Reliquary Ruins
        [548] = Unitnames.NPC_Bandit_Incendiary,                                   -- Silitar
        [555] = Unitnames.Boss_Vicereeve_Pelidil,                                  -- Abecean Sea
        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Veiled_Infernal,                -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Veiled_Infernal,         -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Veiled_Infernal,      -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Veiled_Infernal, -- Hectahame Ritual Chamber

        -- Daggerfall Covenant
        [534] = Unitnames.NPC_Dogeater_Witch, -- Stros M'Kai

        -- DUNGEONS
        -- [130] = Unitnames.NPC_Skeletal_Pyromancer, -- Crypt of Hearts I -- Can't use because The Mage Master's Slave(s) also use these spells
        [380] = Unitnames.Boss_Angata_the_Clannfear_Handler, -- Banished Cells I
        [935] = Unitnames.NPC_Dremora_Kyngald,               -- Banished Cells II
        [126] = Unitnames.NPC_Darkfern_Flamerender,          -- Elden Hollow I
        [681] = Unitnames.NPC_Dremora_Kyngald,               -- City of Ash II
        [932] = Unitnames.NPC_Spiderkith_Cauterizer,         -- Crypt of Hearts II
        [22] = Unitnames.NPC_Treasure_Hunter_Incendiary,     -- Volenfell
    },

    [8779] =
    {                                          -- Lightning Onslaught (Spider Daedra)
        [395] = Unitnames.Elite_Mezelukhebruz, -- The Refuge of Dread

        -- DUNGEONS
        [935] = Unitnames.NPC_Spider_Daedra, -- Banished Cells II (Summon Only)
    },
    [8782] =
    {                                          -- Lightning Storm (Spider Daedra)
        [395] = Unitnames.Elite_Mezelukhebruz, -- The Refuge of Dread

        -- DUNGEONS
        [935] = Unitnames.NPC_Spider_Daedra, -- Banished Cells II (Summon Only)
    },
    [8773] =
    {                                          -- Summon Spiderling (Spider Daedra)
        [395] = Unitnames.Elite_Mezelukhebruz, -- The Refuge of Dread
    },
    [4799] =
    {                                                        -- Tail Spike (Clannfear)
        [395] = Unitnames.Elite_Marrow,                      -- The Refuge of Dread
        [Zonenames.Zone_Torinaan] = Unitnames.NPC_Clannfear, -- Torinaan (Auridon)

        -- QUESTS
        [0] = Unitnames.NPC_Clannfear, -- The Wailing Prison (Soul Shriven in Coldharbour)

        -- DUNGEONS
        [380] = Unitnames.NPC_Clannfear, -- Banished Cells I
        [935] = Unitnames.NPC_Clannfear, -- Banished Cells II
        [681] = Unitnames.NPC_Clannfear, -- City of Ash II
    },
    [93745] =
    {                                                        -- Rending Leap (Clannfear)
        [395] = Unitnames.Elite_Marrow,                      -- The Refuge of Dread
        [Zonenames.Zone_Torinaan] = Unitnames.NPC_Clannfear, -- Torinaan (Auridon)

        -- DUNGEONS
        [380] = Unitnames.NPC_Clannfear, -- Banished Cells I
        [935] = Unitnames.NPC_Clannfear, -- Banished Cells II
        [681] = Unitnames.NPC_Clannfear, -- City of Ash II
    },

    [4653] =
    {                                  -- Shockwave (Watcher)
        [389] = Unitnames.NPC_Watcher, -- Reliquary Ruins
    },
    [9219] =
    {                                  -- Doom-Truth's Gaze (Watcher)
        [389] = Unitnames.NPC_Watcher, -- Reliquary Ruins
    },
    [14425] =
    {                                  -- Doom-Truth's Gaze (Watcher)
        [389] = Unitnames.NPC_Watcher, -- Reliquary Ruins
    },

    [4771] =
    {                                      -- Fiery Breath (Daedroth)
        [435] = Unitnames.Elite_Free_Will, -- Cathedral of the Golden Path
        [935] = Unitnames.NPC_Daedroth,    -- Banished Cells II
    },
    [91946] =
    {                                      -- Ground Tremor (Daedroth)
        [435] = Unitnames.Elite_Free_Will, -- Cathedral of the Golden Path
        [935] = Unitnames.NPC_Daedroth,    -- Banished Cells II
    },

    [50182] =
    {                                   -- Consuming Energy (Spellfiend)
        [932] = Unitnames.NPC_Skeleton, -- Crypt of Hearts II
    },

    [10270] =
    {                                   -- Quake (Gargoyle)
        [383] = Unitnames.NPC_Gargoyle, -- Grahtwood (for Nairume's Prison)
    },
    [13701] =
    {                                        -- Focused Charge (Brute)
        [548] = Unitnames.NPC_Bandit_Savage, -- Silatar

        -- DUNGEONS
        [131] = Unitnames.NPC_Sea_Viper_Strongarm,                           -- Tempest Island
        [Zonenames.Zone_Tempest_Island] = Unitnames.NPC_Sea_Viper_Strongarm, -- Tempest Island
    },

    [37087] =
    {                                  -- Lightning Onslaught (Battlemage)
        [548] = Unitnames.Elite_Baham, -- Silatar

        -- DUNGEONS
        [935] = Unitnames.NPC_Dremora_Clasher, -- Banished Cells II
    },
    [37129] =
    {                                  -- Ice Cage (Battlemage)
        [548] = Unitnames.Elite_Baham, -- Silatar

        -- DUNGEONS
        [130] = Unitnames.Boss_The_Mage_Master, -- Crypt of Hearts I
        [935] = Unitnames.NPC_Dremora_Clasher,  -- Banished Cells II
        [932] = Unitnames.Boss_Ibelgast,        -- Crypt of Hearts II
    },
    [44216] =
    {                                  -- Negate Magic (Battlemage - Elite)
        [548] = Unitnames.Elite_Baham, -- Silatar

        -- DUNGEONS
        [130] = Unitnames.Boss_The_Mage_Master, -- Crypt of Hearts I
        [932] = Unitnames.Boss_Ibelgast,        -- Crypt of Hearts II
    },

    [3767] =
    {                                                                              -- Choking Pollen (Lurcher)
        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Corrupt_Lurcher,                -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Corrupt_Lurcher,         -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Corrupt_Lurcher,      -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Corrupt_Lurcher, -- Hectahame Ritual Chamber
        [559] = Unitnames.NPC_Corrupt_Lurcher,                                     -- Valenheart

        -- DUNGEONS
        [931] = Unitnames.NPC_Daedric_Lurcher, -- Elden Hollow II
    },
    [21582] =
    {                                                                              -- Nature's Swarm (Spriggan)
        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Corrupt_Spriggan,               -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Corrupt_Spriggan,        -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Corrupt_Spriggan,     -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Corrupt_Lurcher, -- Hectahame Ritual Chamber
    },
    [13477] =
    {                                                                              -- Control Beast (Spriggan)
        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Corrupt_Spriggan,               -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Corrupt_Spriggan,        -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Corrupt_Spriggan,     -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Corrupt_Lurcher, -- Hectahame Ritual Chamber
    },
    [89102] =
    {                                                                              -- Summon Beast (Spriggan)
        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Corrupt_Spriggan,               -- Hectaham
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Corrupt_Spriggan,        -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Corrupt_Spriggan,     -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Corrupt_Lurcher, -- Hectahame Ritual Chamber
    },

    [35387] =
    {                                                                              -- Defiled Grave (Bonelord)
        [399] = Unitnames.Elite_Nolonir,                                           -- Wansalen (Auridon - Delve)

        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Veiled_Bonelord,                -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Veiled_Bonelord,         -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Veiled_Bonelord,      -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Veiled_Bonelord, -- Hectahame Ritual Chamber

        -- DUNGEONS
        [935] = Unitnames.NPC_Dremora_Hauzkyn, -- Banished Cells II
    },
    [88507] =
    {                                                                              -- Summon Abomination (Bonelord)
        [399] = Unitnames.Elite_Nolonir,                                           -- Wansalen (Auridon - Delve)

        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Veiled_Bonelord,                -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Veiled_Bonelord,         -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Veiled_Bonelord,      -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Veiled_Bonelord, -- Hectahame Ritual Chamber

        -- DUNGEONS
        [935] = Unitnames.NPC_Dremora_Hauzkyn, -- Banished Cells II
    },
    [5050] =
    {                                                                            -- Bone Saw (Bone Colossus)
        [Zonenames.Zone_Hightide_Keep] = Unitnames.Elite_Garggeel,               -- Hightide Keep (Auridon)
        [399] = Unitnames.NPC_Bone_Colossus,                                     -- Wansalen (Auridon - Delve)

        [Zonenames.Zone_Hectahame] = Unitnames.NPC_Bone_Colossus,                -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = Unitnames.NPC_Bone_Colossus,         -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = Unitnames.NPC_Bone_Colossus,      -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = Unitnames.NPC_Bone_Colossus, -- Hectahame Ritual Chamber

        -- DUNGEONS
        [130] = Unitnames.NPC_Bone_Colossus,       -- Crypt of Hearts I
        [380] = Unitnames.Boss_Skeletal_Destroyer, -- Banished Cells I
        [935] = Unitnames.NPC_Bone_Colossus,       -- Banished Cells II (Summon Only)
        [681] = Unitnames.NPC_Flame_Colossus,      -- City of Ash II
    },
    [5030] =
    {                                                              -- Voice to Wake the Dead (Bone Colossus)
        [Zonenames.Zone_Hightide_Keep] = Unitnames.Elite_Garggeel, -- Hightide Keep (Auridon)
        [399] = Unitnames.NPC_Bone_Colossus,                       -- Wansalen (Auridon - Delve) -- TODO: Is this needed?

        -- DUNGEONS
        [130] = Unitnames.NPC_Bone_Colossus,       -- Crypt of Hearts I
        [380] = Unitnames.Boss_Skeletal_Destroyer, -- Banished Cells I
    },

    [22521] =
    {                                           -- Defiled Ground (Lich)
        [559] = Unitnames.Boss_Shade_of_Naemon, -- Valenheart

        -- DUNGEONS
        [130] = Unitnames.Boss_Uulkar_Bonehand, -- Crypt of Hearts I
    },
    [19137] =
    { -- Haunting Spectre (Ghost)

        -- DUNGEONS
        [935] = Unitnames.NPC_Ghost, -- Banished Cells II (Summon Only)
        [130] = Unitnames.NPC_Ghost, -- Crypt of Hearts I
    },
    [73925] =
    {                                           -- Soul Cage (Lich)
        [559] = Unitnames.Boss_Shade_of_Naemon, -- Valenheart

        -- DUNGEONS
        [130] = Unitnames.Boss_Uulkar_Bonehand, -- Crypt of Hearts I
    },

    [44736] =
    {                                                             -- Swinging Cleave (Troll)
        [Zonenames.Zone_Castle_Rilis] = Unitnames.NPC_Troll,      -- Castle Rilis (Auridon) -- TODO: Probably can do all of Auridon
        [Zonenames.Zone_Nine_Prow_Landing] = Unitnames.NPC_Troll, -- Nine-Prow Landing (Auridon) -- TODO: Probably can do all of Auridon
    },
    [9009] =
    {                                                             -- Tremor (Troll)
        [Zonenames.Zone_Castle_Rilis] = Unitnames.NPC_Troll,      -- Castle Rilis (Auridon) -- TODO: Probably can do all of Auridon
        [Zonenames.Zone_Nine_Prow_Landing] = Unitnames.NPC_Troll, -- Nine-Prow Landing (Auridon) -- TODO: Probably can do all of Auridon
    },
    [3415] =
    {                                     -- Flurry (Werewolf)
        [392] = Unitnames.Elite_Sorondil, -- The Vault of Exile (Auridon)
    },

    [4415] =
    {                               -- Crushing Swipe (Bear)
        [381] = Unitnames.NPC_Bear, -- Auridon
    },

    [5789] =
    {                                            -- Fire Runes (Giant Spider)
        -- QUESTS
        [393] = Unitnames.NPC_Spider,            -- Saltspray Cave (Auridon)
        [1160] = Unitnames.NPC_Frostbite_Spider, -- Deepwood Vale (Greymoor)

        -- DUNGEONS
        [932] = Unitnames.NPC_Spider, -- Crypt of Hearts II
    },
    [8087] =
    {                                 -- Poison Spray (Giant Spider)
        -- QUESTS
        [393] = Unitnames.NPC_Spider, -- Saltspray Cave (Auridon)
    },
    [4737] =
    {                                 -- Encase (Giant Spider)
        -- QUESTS
        [393] = Unitnames.NPC_Spider, -- Saltspray Cave (Auridon)
    },
    [13382] =
    {                                 -- Devour (Giant Spider)
        -- QUESTS
        [393] = Unitnames.NPC_Spider, -- Saltspray Cave (Auridon)

        -- DUNGEONS
        [932] = Unitnames.NPC_Spider, -- Crypt of Hearts II
    },

    [6166] =
    {                                -- Heat Wave (Scamp)
        [381] = Unitnames.NPC_Scamp, -- Auridon

        -- DUNGEONS
        [380] = Unitnames.NPC_Scamp, -- Banished Cells I
        [935] = Unitnames.NPC_Scamp, -- Banished Cells II (Summon Only)
        [931] = Unitnames.NPC_Scamp, -- Elden Hollow II
        [176] = Unitnames.NPC_Scamp, -- City of Ash I
        [681] = Unitnames.NPC_Scamp, -- City of Ash II
    },
    [6160] =
    {                                -- Rain of Fire (Scamp)
        [381] = Unitnames.NPC_Scamp, -- Auridon

        -- DUNGEONS
        [380] = Unitnames.NPC_Scamp, -- Banished Cells I
        [935] = Unitnames.NPC_Scamp, -- Banished Cells II (Summon Only)
        [931] = Unitnames.NPC_Scamp, -- Elden Hollow II
        [176] = Unitnames.NPC_Scamp, -- City of Ash I
        [681] = Unitnames.NPC_Scamp, -- City of Ash II
    },

    [88947] =
    { -- Lightning Grasp (Xivilai)

        -- DUNGEONS
        [935] = Unitnames.NPC_Xivilai, -- Banished Cells I
    },
    [7100] =
    { -- Hand of Flame (Xivilai)

        -- DUNGEONS
        [935] = Unitnames.NPC_Xivilai, -- Banished Cells I
    },
    [25726] =
    { -- Summon Daedra (Xivilai)

        -- DUNGEONS
        [935] = Unitnames.NPC_Xivilai, -- Banished Cells I
    },
    [4829] =
    { -- Fire Brand (Flesh Atronach)

        -- DUNGEONS
        [935] = Unitnames.NPC_Flesh_Atronach, -- Banished Cells I (Summon Only)
        [932] = Unitnames.NPC_Flesh_Atronach, -- Crypt of Hearts II
    },
    [6412] =
    { -- Dusk's Howl (Winged Twilight)

        -- DUNGEONS
        [935] = Unitnames.NPC_Winged_Twilight,       -- Banished Cells I
        [931] = Unitnames.Boss_Azara_the_Frightener, -- Elden Hollow II
    },

    [24690] =
    { -- Focused Charge (Ogrim)

        -- DUNGEONS
        [935] = Unitnames.NPC_Flame_Ogrim, -- Banished Cells II (Summon Only)
        [932] = Unitnames.NPC_Ogrim,       -- Crypt of Hearts II
    },
    [91848] =
    { -- Stomp (Ogrim)

        -- DUNGEONS
        [935] = Unitnames.NPC_Flame_Ogrim, -- Banished Cells II (Summon Only)
        [932] = Unitnames.NPC_Ogrim,       -- Crypt of Hearts II
    },
    [91855] =
    { -- Boulder Toss (Ogrim)

        -- DUNGEONS
        [935] = Unitnames.NPC_Flame_Ogrim, -- Banished Cells II (Summon Only)
        [932] = Unitnames.NPC_Ogrim,       -- Crypt of Hearts II
    },

    [28939] =
    { -- Heat Wave (Sees-All-Colors)

        -- DUNGEONS
        [935] = Unitnames.Boss_Keeper_Areldur, -- Banished Cells II
    },

    [5452] =
    {                               -- Lacerate (Alit)
        -- QUESTS
        [968] = Unitnames.NPC_Alit, -- Firemoth Island (Vvardenfell)

        -- DUNGEONS
        -- [126] = Unitnames.NPC_Alit, -- Elden Hollow I (Can't use because Alit's are right next to Leafseether and can easily also be casting this)
    },

    [5441] =
    {                               -- Dive (Guar)
        -- QUESTS
        [968] = Unitnames.NPC_Guar, -- Firemoth Island (Vvardenfell)
    },

    [85395] =
    {                                        -- Dive (Cliff Strider)
        -- QUESTS
        [968] = Unitnames.NPC_Cliff_Strider, -- Firemoth Island (Vvardenfell)
    },
    [85399] =
    {                                        -- Retch (Cliff Strider)
        -- QUESTS
        [968] = Unitnames.NPC_Cliff_Strider, -- Firemoth Island (Vvardenfell)
    },

    [26412] =
    {                                          -- Thunderstrikes (Thunderbug)
        [126] = Unitnames.NPC_Thunderbug_Lord, -- Elden Hollow I
    },
    [9322] =
    {                                    -- Poisoned Ground (Strangler)
        [126] = Unitnames.NPC_Strangler, -- Elden Hollow I
        [681] = Unitnames.NPC_Strangler, -- City of Ash II
    },
    [14272] =
    {                               -- Call of the Pack (Wolf)
        [534] = Unitnames.NPC_Wolf, -- Stros M'Kai
    },

    [16031] =
    {                                            -- Steam Wall (Dwemer Sphere)
        -- QUESTS
        [534] = Unitnames.Elite_Tempered_Sphere, -- Stros M'Kai

        -- DUNGEONS
        [22] = Unitnames.NPC_Dwarven_Sphere, -- Volenfell
    },
    [7544] =
    {                                            -- Quake (Dwemer Sphere)
        -- QUESTS
        [534] = Unitnames.Elite_Tempered_Sphere, -- Stros M'Kai

        -- DUNGEONS
        [22] = Unitnames.NPC_Dwarven_Sphere, -- Volenfell
    },

    [11247] =
    {                                           -- Sweeping Spin (Dwemer Centurion)
        -- DUNGEONS
        [22] = Unitnames.NPC_Dwarven_Centurion, -- Volenfell
    },
    [11246] =
    {                                           -- Steam Breath (Dwemer Centurion)
        -- DUNGEONS
        [22] = Unitnames.NPC_Dwarven_Centurion, -- Volenfell
    },

    [135612] =
    {                                           -- Frost Wave (Matron Urgala)
        -- QUESTS
        [1160] = Unitnames.Elite_Matron_Urgala, -- Deepwood Vale (Greymoor Tutorial)
    },

    [70366] =
    {                                                                  -- Slam (Great Bear)
        -- QUESTS
        [Zonenames.Zone_Deepwood_Vale] = Unitnames.NPC_Feral_Guardian, -- Deepwood Vale (Greymoor Tutorial)
    },

    [88371] =
    {                                                -- Dive (Beastcaller) (Morrowind)
        [1160] = Unitnames.NPC_Icereach_Beastcaller, -- Deepwood Vale (Greymoor)
    },
    [88394] =
    {                                                -- Gore (Beastcaller) (Morrowind)
        [1160] = Unitnames.NPC_Icereach_Beastcaller, -- Deepwood Vale (Greymoor)
    },
    [88409] =
    {                                                -- Raise the Earth (Beastcaller)
        [1160] = Unitnames.NPC_Icereach_Beastcaller, -- Deepwood Vale (Greymoor)
    },
    [8977] =
    {                                    -- Sweep (Duneripper)
        -- DUNGEONS
        [22] = Unitnames.NPC_Duneripper, -- Volenfell
    },

    [25211] =
    {                                                 -- Whirlwind Function (The Guardian's Strength)
        -- DUNGEONS
        [22] = Unitnames.Boss_The_Guardians_Strength, -- Volenfell
    },
    [25262] =
    {                                                 -- Hammer Strike (The Guardian's Soul)
        -- DUNGEONS
        [22] = Unitnames.Boss_The_Guardians_Strength, -- Volenfell
    },

    [63752] =
    {                                           -- Vomit (Tutorial)
        [0] = Unitnames.NPC_Feral_Soul_Shriven, -- The Wailing Prison (Soul Shriven in Coldharbour)
    },
    [63521] =
    {                                         -- Bone Crush (Tutorial)
        [0] = Unitnames.Elite_Child_of_Bones, -- The Wailing Prison (Soul Shriven in Coldharbour)
    },
    [107282] =
    {                                              -- Impale (Yaghra Nightmare)
        [1013] = Unitnames.Elite_Yaghra_Nightmare, -- Summerset (The Mind Trap)
    },
    [105867] =
    {                                              -- Pustulant Explosion (Yaghra Nightmare)
        [1013] = Unitnames.Elite_Yaghra_Nightmare, -- Summerset (The Mind Trap)
    },

    [121643] =
    {                                                -- Defiled Ground (Euraxian Necromancer)
        [1106] = Unitnames.NPC_Euraxian_Necromancer, -- Elsweyr (Bright Moons, Warm Sands)
    },

    [5240] =
    {                                      -- Lash (Giant Snake)
        [534] = Unitnames.Elite_Deathfang, -- Deathfang (Stros M'Kai)
    },
}

--- @class (partial) AlertZoneOverride
LuiData.Data.AlertZoneOverride = AlertZoneOverride
