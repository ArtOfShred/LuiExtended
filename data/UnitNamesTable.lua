--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- UnitNames namespace
LUIE.UnitNames = {}

local UnitNames = {
    -- TODO: MAYBE in the future can localize these names, for the time being this table exists for that purpose.

    ----------------------------------------------------------------
    -- NORMAL NPC NAMES --------------------------------------------
    ----------------------------------------------------------------

    NPC_Flame_Atronach                    = 'Flame Atronach',
    NPC_Frost_Atronach                    = 'Frost Atronach',
    NPC_Ice_Barrier                       = 'Ice Barrier',

    ----------------------------------------------------------------
    -- QUESTS ------------------------------------------------------
    ----------------------------------------------------------------



    ----------------------------------------------------------------
    -- WORLD BOSSES ------------------------------------------------
    ----------------------------------------------------------------



    ----------------------------------------------------------------
    -- PUBLIC DUNGEONS ---------------------------------------------
    ----------------------------------------------------------------


    ----------------------------------------------------------------
    -- ARENAS ------------------------------------------------------
    ----------------------------------------------------------------

    -- Dragonstar Arena
    NPC_Fighters_Guild_Gladiator          = 'Fighters Guild Gladiator',
    Boss_Champion_Marcauld                = 'Champion Marcauld',
    NPC_Sovngarde_Slayer                  = 'Sovngarde Slayer',
    NPC_Sovngarde_Icemage                 = 'Sovngarde Icemage',
    NPC_Sovngarde_Ranger                  = 'Sovngarde Ranger',
    Boss_Yavni_Frost_Skin                 = 'Yavni Frost-Skin',
    Boss_Katti_Ice_Turner                 = 'Katti Ice-Turner',
    Boss_Shilia                           = 'Shilia',
    Boss_Nak_tah                          = 'Nak\'tah',
    NPC_House_Dres_Slaver                 = 'House Dres Slaver',
    Boss_Earthen_Heart_Knight             = 'Earthen Heart Knight',
    NPC_Anka_Ra_Shadowcaster              = 'Anka-Ra Shadowcaster',
    Boss_Anala_tuwha                      = 'Anal\'a Tu\'wha',
    NPC_Pacthunter_Ranger                 = 'Pacthunter Ranger',
    Boss_Pishna_Longshot                  = 'Pishna Longshot',
    NPC_Daedric_Sacrifice                 = 'Daedric Sacrifice',
    Boss_Shadow_Knight                    = 'Shadow Knight',
    Boss_Dark_Mage                        = 'Dark Mage',
    NPC_Dwarven_Fire_Centurion            = 'Dwarven Fire Centurion',
    NPC_Dwarven_Sphere                    = 'Dwarven Sphere',
    Boss_Mavus_Talnarith                  = 'Mavus Talnarith',
    NPC_Graveoath_Ravener                 = 'Graveoath Ravener',
    Boss_Zackael_Jonnicent                = 'Zackael Jonnicent',
    Boss_Rubyn_Jonnicent                  = 'Rubyn Jonnicent',
    Boss_Vampire_Lord_Thisa               = 'Vampire Lord Thisa',
    Boss_Hiath_the_Battlemaster           = 'Hiath the Battlemaster',

    -- Maelstrom Arena
    Boss_Maxus_the_Many                   = 'Maxus the Many',

    ----------------------------------------------------------------
    -- DUNGEONS ----------------------------------------------------
    ----------------------------------------------------------------

    -- Banished Cells I
    Boss_Cell_Haunter                     = 'Cell Haunter',
    Boss_Shadowrend                       = 'Shadowrend',
    Boss_Angata_the_Clannfear_Handler     = 'Angata the Clannfear Handler',
    Boss_High_Kinlord_Rilis               = 'High Kinlord Rilis',
    NPC_The_Feast                         = 'The Feast',

    -- Banished Cells II
    Boss_Keeper_Areldur                   = 'Keeper Areldur',
    Boss_Maw_of_the_Infernal              = 'Maw of the Infernal',
    Boss_Keeper_Voranil                   = 'Keeper Voranil',
    Boss_Keeper_Imiril                    = 'Keeper Imiril',

    -- Elden Hollow I
    Boss_Ancient_Spriggan                 = 'Ancient Spriggan',
    Boss_Akash_gra_Mal                    = 'Akash gra-Mal',
    Boss_Chokethorn                       = 'Chokethorn',
    NPC_Strangler_Saplings                = 'Strangler Saplings',
    Boss_Nenesh_gro_Mal                   = 'Nenesh gro-Mal',
    Boss_Leafseether                      = 'Leafseether',
    Boss_Canonreeve_Oraneth               = 'Canonreeve Oraneth',

    -- Elden Hollow II
    Boss_Dubroze_the_Infestor             = 'Dubroze the Infestor',
    Boss_Dark_Root                        = 'Dark Root',
    NPC_Frenzied_Guardian                 = 'Frenzied Guardian',
    NPC_Mystic_Guardian                   = 'Mystic Guardian',
    Boss_Azara_the_Frightener             = 'Azara the Frightener',
    Boss_Shadow_Tendril                   = 'Shadow Tendril',
    Boss_Murklight                        = 'Murklight',
    Boss_The_Shadow_Guard                 = 'The Shadow Guard',
    Boss_Bogdan_the_Nightflame            = 'Bogdan the Nightflame',
    Boss_Nova_Tendril                     = 'Nova Tendril',

    -- City of Ash I
    Boss_Golor_the_Banekin_Handler        = 'Golor the Banekin Handler',
    Boss_Warden_of_the_Shrine             = 'Warden of the Shrine',
    Boss_Infernal_Guardian                = 'Infernal Guardian',
    Boss_Dark_Ember                       = 'Dark Ember',
    Boss_Rothariel_Flameheart             = 'Rothariel Flameheart',
    Boss_Razor_Master_Erthas              = 'Razor Master Erthas',

    -- City of Ash II
    Boss_Akezel                           = 'Akezel',
    Boss_Rukhan                           = 'Rukhan',
    Boss_Marruz                           = 'Marruz',
    NPC_Xivilai_Immolator                 = 'Xivilai Immolator',
    NPC_Xivilai_Ravager                   = 'Xivilai Ravager',
    NPC_Venomous_Skeleton                 = 'Venomous Skeleton',
    Boss_Urata_the_Legion                 = 'Urata the Legion',
    NPC_Flame_Colossus                    = 'Flame Colossus',
    Boss_Horvantud_the_Fire_Maw           = 'Horvantud the Fire Maw',
    Boss_Ash_Titan                        = 'Ash Titan',
    NPC_Air_Atronach                      = 'Air Atronach',
    NPC_Dremora_Hauzkyn                   = 'Dremora Hauzkyn',
    NPC_Fire_Ravager                      = 'Fire Ravager',
    NPC_Xivilai_Fulminator                = 'Xivilai Fulminator',
    NPC_Xivilai_Boltaic                   = 'Xivilai Boltaic',
    Boss_Valkyn_Skoria                    = 'Valkyn Skoria',

    -- Tempest Island
    Boss_Sonolia_the_Matriarch            = 'Sonolia the Matriarch',
    Boss_Valaran_Stormcaller              = 'Valaran Stormcaller',
    NPC_Lightning_Avatar                  = 'Lightning Avatar',
    Boss_Yalorasse_the_Speaker            = 'Yalorasse the Speaker',
    Boss_Stormfist                        = 'Stormfist',
    Boss_Commodore_Ohmanil                = 'Commodore Ohmanil',
    Boss_Stormreeve_Neidir                = 'Stormreeve Neidir',

    -- Selene's Web
    Boss_Treethane_Kerninn                = 'Treethane Kerninn',
    Boss_Longclaw                         = 'Longclaw',
    Boss_Queen_Aklayah                    = 'Queen Aklayah',
    Boss_Foulhide                         = 'Foulhide',
    Boss_Mennir_Many_Legs                 = 'Mennir Many-Legs',
    Boss_Selene                           = 'Selene',

    -- Spindleclutch I
    Boss_Spindlekin                       = 'Spindlekin',
    Boss_Swarm_Mother                     = 'Swarm Mother',
    Boss_Cerise_the_Widow_Maker           = 'Cerise the Widow-Maker',
    Boss_Big_Rabbu                        = 'Big Rabbu',
    Boss_The_Whisperer                    = 'The Whisperer',

    Boss_Praxin_Douare                    = 'Praxin Douare',

    -- Spindleclutch II
    Boss_Mad_Mortine                      = 'Mad Mortine',
    Boss_Blood_Spawn                      = 'Blood Spawn',
    NPC_The_Whisperer_Nightmare           = 'The Whisperer Nightmare',
    NPC_Flesh_Atronach                    = 'Flesh Atronach',
    Boss_Urvan_Veleth                     = 'Urvan Veleth',
    Boss_Vorenor_Winterbourne             = 'Vorenor Winterbourne',

    -- Frostvault
    NPC_Coldsnap_Ogre                     = 'Coldsnap Ogre',
    Boss_Icestalker                       = 'Icestalker',
}

-- Export string data to global namespace
LUIE.UnitNames = UnitNames
