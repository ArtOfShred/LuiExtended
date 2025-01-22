-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiData
local LuiData = LuiData

local Tooltips = LuiData.Data.Tooltips
local Unitnames = LuiData.Data.UnitNames
local Zonenames = LuiData.Data.ZoneNames
local Abilities = LuiData.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- When a target name matches a string here, add id's in the table with the name and icon specified. We use this primarily to add CC Immunity buffs for bosses.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) AddNameAura
local AddNameAura =
{

    -- Target Dummy
    [Unitnames.Dummy_Robust_Target_Dromathra] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Robust_Target_Minotaur_Handler] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Soul_Sworn_Thrall] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Bloodknight] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Bone_Goliath_Reanimated] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Centurion_Dwarf_Brass] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Centurion_Lambent] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Centurion_Robust_Lambent] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Centurion_Robust_Refabricated] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Frost_Atronach] = { [1] = { id = 33097 } },
    [Unitnames.Target_Harrowing_Reaper_Trial] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Iron_Atronach] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Iron_Atronach_Trial] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Mournful_Aegis] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Skeleton_Humanoid] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Skeleton_Khajiit] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Skeleton_Argonian] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Skeleton_Robust_Humanoid] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Skeleton_Robust_Khajiit] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Skeleton_Robust_Argonian] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Stone_Atronach] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Stone_Husk] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Voriplasm] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_Wraith_of_Crows] = { [1] = { id = 33097 } },
    [Unitnames.Dummy_Target_The_Precursor] = { [1] = { id = 33097 } },

    -- Various Mobs
    [Unitnames.NPC_Daedroth] = { [1] = { id = 999013, zone = { [935] = true } } }, -- Daedroth

    -- World Bosses

    -- Auridon
    [Unitnames.Boss_Norendo] = { [1] = { id = 33097 } },           -- Auridon (Soulfire Plateau)
    [Unitnames.Boss_Eraman] = { [1] = { id = 33097 } },            -- Auridon (Soulfire Plateau)
    [Unitnames.Boss_Quendia] = { [1] = { id = 33097 } },           -- Auridon (Soulfire Plateau)
    [Unitnames.Boss_Quenyas] = { [1] = { id = 33097 } },           -- Auridon (Seaside Scarp Camp)
    [Unitnames.Boss_Captain_Blanchete] = { [1] = { id = 33097 } }, -- Auridon (Wreck of the Raptor)
    [Unitnames.Boss_Snapjaw] = { [1] = { id = 33097 } },           -- Auridon (Heretic's Summons)
    [Unitnames.Boss_The_Nestmother] = { [1] = { id = 33097 } },    -- Auridon (Nestmothers Den)
    [Unitnames.Boss_Anarume] = { [1] = { id = 33097 } },           -- Auridon (Heritance Proving Ground)

    -- Grahtwood
    [Unitnames.Boss_Bavura_the_Blizzard] = { [1] = { id = 33097 } },   -- Grahtwood (Nindaeril's Perch)
    [Unitnames.Boss_Nindaeril_the_Monsoon] = { [1] = { id = 33097 } }, -- Grahtwood (Nindaeril's Perch)
    [Unitnames.Boss_Shagura] = { [1] = { id = 33097 } },               -- Grahtwood (Hircine's Henge)
    [Unitnames.Boss_Gurgozu] = { [1] = { id = 33097 } },               -- Grahtwood (Hircine's Henge)
    [Unitnames.Boss_Valanirs_Shield] = { [1] = { id = 33097 } },       -- Grahtwood (Valanir's Rest)
    [Unitnames.Boss_Lady_Solace] = { [1] = { id = 33097 } },           -- Grahtwood (Lady Solace's Fen)
    [Unitnames.Boss_Otho_Rufinus] = { [1] = { id = 33097 } },          -- Grahtwood (Poacher Camp)
    [Unitnames.Boss_Thugrub_the_Reformed] = { [1] = { id = 33097 } },  -- Grahtwood (Thugrub's Cave)

    -- Greenshade
    [Unitnames.Boss_Gathongor_the_Mauler] = { [1] = { id = 33097 } },  -- Greenshade (Gathongor's Mine)
    [Unitnames.Boss_Smiles_With_Knife] = { [1] = { id = 33097 } },     -- Greenshade (Reconnaissance Camp)
    [Unitnames.Boss_Maheelius] = { [1] = { id = 33097 } },             -- Greenshade (Reconnaissance Camp)
    [Unitnames.Boss_Navlos] = { [1] = { id = 33097 } },                -- Greenshade (Reconnaissance Camp)
    [Unitnames.Boss_Heart_of_Rootwater] = { [1] = { id = 33097 } },    -- Greenshade (Rootwater Spring)
    [Unitnames.Boss_Thodundor_of_the_Hill] = { [1] = { id = 33097 } }, -- Greenshade (Thodundor's View)
    [Unitnames.Boss_Neiral] = { [1] = { id = 33097 } },                -- Greenshade (Maormer Camp View)
    [Unitnames.Boss_Hetsha] = { [1] = { id = 33097 } },                -- Greenshade (Maormer Camp View)
    [Unitnames.Boss_Jahlasri] = { [1] = { id = 33097 } },              -- Greenshade (Maormer Camp View)

    -- Malabal Tor
    [Unitnames.Boss_Thjormar_the_Drowned] = { [1] = { id = 33097 } },  -- Malabal Tor (Bitterpoint Strand)
    [Unitnames.Boss_Drowned_First_Mate] = { [1] = { id = 33097 } },    -- Malabal Tor (Bitterpoint Strand)
    [Unitnames.Boss_Dugan_the_Red] = { [1] = { id = 33097 } },         -- Malabal Tor (Dugan's Knoll)
    [Unitnames.Boss_Bagul] = { [1] = { id = 33097 } },                 -- Malabal Tor (Dugan's Knoll)
    [Unitnames.Boss_Fangoz] = { [1] = { id = 33097 } },                -- Malabal Tor (Dugan's Knoll)
    [Unitnames.Boss_Bone_Grappler] = { [1] = { id = 33097 } },         -- Malabal Tor (Bone Grappler's Nest)
    [Unitnames.Boss_Tallatta_the_Lustrous] = { [1] = { id = 33097 } }, -- Malabal Tor (Jagged Grotto)
    [Unitnames.Boss_Commander_Faldethil] = { [1] = { id = 33097 } },   -- Malabal Tor (River Edge)

    -- Reaper's March
    [Unitnames.Boss_Gravecaller_Niramo] = { [1] = { id = 33097 } },     -- Reaper's March (Reaper's Henge)
    [Unitnames.Boss_Varien] = { [1] = { id = 33097 } },                 -- Reaper's March (Reaper's Henge)
    [Unitnames.Boss_Dirge_of_Thorns] = { [1] = { id = 33097 } },        -- Reaper's March (Deathsong Cleft)
    [Unitnames.Boss_Ravenous_Loam] = { [1] = { id = 33097 } },          -- Reaper's March (Deathsong Cleft)
    [Unitnames.Boss_Queen_of_Three_Mercies] = { [1] = { id = 33097 } }, -- Reaper's March (Waterdancer Falls)
    [Unitnames.Boss_Overlord_Nur_dro] = { [1] = { id = 33097 } },       -- Reaper's March (Ushmal's Rest)
    [Unitnames.Boss_Big_Ozur] = { [1] = { id = 33097 } },               -- Reaper's March (Big Ozur's Valley)

    -- Glenumbra
    [Unitnames.Boss_Limbscather] = { [1] = { id = 33097 } },         -- Western Overlook (Glenumbra)
    [Unitnames.Boss_Salazar_the_Wolf] = { [1] = { id = 33097 } },    -- The Wolf's Camp (Glenumbra)
    [Unitnames.Boss_Lieutenant_Bran] = { [1] = { id = 33097 } },     -- The Wolf's Camp (Glenumbra)
    [Unitnames.Boss_Annyce] = { [1] = { id = 33097 } },              -- The Wolf's Camp (Glenumbra)
    [Unitnames.Boss_Asard_the_Putrid] = { [1] = { id = 33097 } },    -- The Wolf's Camp (Glenumbra)
    [Unitnames.Boss_Graufang] = { [1] = { id = 33097 } },            -- Seaview Point (Glenumbra)
    [Unitnames.Boss_Grivier_Bloodcaller] = { [1] = { id = 33097 } }, -- Balefire Island (Glenumbra)

    -- Stormhaven
    [Unitnames.Boss_Old_Widow_Silk] = { [1] = { id = 33097 } }, -- Spider Nest (Stormhaven)
    [Unitnames.Boss_Titanclaw] = { [1] = { id = 33097 } },      -- Mudcrab Beach (Stormhaven)
    [Unitnames.Boss_Brood_Queen] = { [1] = { id = 33097 } },    -- Dreugh Waters (Stormhaven)
    -- [Unitnames.Boss_Cousin_Scrag] = { [1] = { id = 33097 } }, -- Scrag's Larder (Stormhaven)

    -- Rivenspire
    [Unitnames.Boss_Aesar_the_Hatespinner] = { [1] = { id = 33097 } }, -- Aesar's Web (Rivenspire)
    [Unitnames.Boss_Magdelena] = { [1] = { id = 33097 } },             -- Magdelena's Haunt (Rivenspire)
    [Unitnames.Boss_Calixte_Darkblood] = { [1] = { id = 33097 } },     -- Old Kalgon's Keep (Rivenspire)
    [Unitnames.Boss_Louna_Darkblood] = { [1] = { id = 33097 } },       -- Old Kalgon's Keep (Rivenspire)
    [Unitnames.Boss_Lyse_Darkblood] = { [1] = { id = 33097 } },        -- Old Kalgon's Keep (Rivenspire)
    [Unitnames.Boss_Stroda_gra_Drom] = { [1] = { id = 33097 } },       -- East-Rock Landing (Rivenspire)
    [Unitnames.Boss_Desuuga_the_Siren] = { [1] = { id = 33097 } },     -- Siren's Cove (Rivenspire)

    -- Public Dungeon
    [Unitnames.Boss_Nitch] = { [1] = { id = 33097 } },                   -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Thek_Elf_Stabber] = { [1] = { id = 33097 } },        -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Black_Bessie] = { [1] = { id = 33097 } },            -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Bloodroot] = { [1] = { id = 33097 } },               -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Togga_the_Skewerer] = { [1] = { id = 33097 } },      -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Dzeizik] = { [1] = { id = 33097 } },                 -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Slakkith] = { [1] = { id = 33097 } },                -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Gorg] = { [1] = { id = 33097 } },                    -- Auridon (Toothmaul Gully)

    [Unitnames.Boss_Great_Thorn] = { [1] = { id = 33097 } },             -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_The_Devil_Wrathmaw] = { [1] = { id = 33097 } },      -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_Rootbiter] = { [1] = { id = 33097 } },               -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_Silent_Claw] = { [1] = { id = 33097 } },             -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_Thick_Bark] = { [1] = { id = 33097 } },              -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_Guardian_of_Root_Sunder] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)

    [Unitnames.Boss_Lost_Master] = { [1] = { id = 33097 } },             -- Greenshade (Rulanyil's Fall)
    [Unitnames.Boss_Utiasl] = { [1] = { id = 33097 } },                  -- Greenshade (Rulanyil's Fall)
    [Unitnames.Boss_Skirar_the_Decaying] = { [1] = { id = 33097 } },     -- Greenshade (Rulanyil's Fall)
    [Unitnames.Boss_Magna_Tharn] = { [1] = { id = 33097 } },             -- Greenshade (Rulanyil's Fall)
    [Unitnames.Boss_Hannat_the_Bonebringer] = { [1] = { id = 33097 } },  -- Greenshade (Rulanyil's Fall)

    -- MSQ
    [Unitnames.Boss_Ragjar] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Manifestation_of_Regret] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Ancient_Clannfear] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Manifestation_of_Terror] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Mannimarco] = { [1] = { id = 33097 } },

    -- Mages Guild
    [Unitnames.Boss_Uncle_Leo] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Haskill] = { [1] = { id = 33097 } },

    -- Aldmeri Dominion
    [Unitnames.Boss_High_Kinlady_Estre] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Mayor_Aulus] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Prince_Naemon] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Vicereeve_Pelidil] = { [1] = { id = 33097 } },

    -- Elsweyr Quests
    [Unitnames.Boss_Bahlokdaan] = { [1] = { id = 33097 } },

    -- Dolmen Bosses
    [Unitnames.NPC_Dread_Xivkyn_Cauterizer] = { [1] = { id = 33097 } },
    [Unitnames.NPC_Dread_Xivkyn_Dreadweaver] = { [1] = { id = 33097 } },
    [Unitnames.NPC_Dread_Xivkyn_Voidstalker] = { [1] = { id = 33097 } },
    [Unitnames.NPC_Dread_Xivkyn_Chillfiend] = { [1] = { id = 33097 } },
    [Unitnames.NPC_Dread_Xivkyn_Banelord] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Vika] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Dylora] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Jansa] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Medrike] = { [1] = { id = 33097 } },
    [Unitnames.Boss_Anaxes] = { [1] = { id = 33097 } },

    -- NPC's
    [Unitnames.NPC_Ice_Barrier] = { [1] = { id = 33097 } },
    -- [Unitnames.NPC_Aura_of_Protection] = { [1] = { id = 33097 } }, -- TODO: Not actually CC immune despite CC not doing anything (maybe switch to knockback immunity eventually)
    -- ['Ice Pillar'] = { [1] = { id = 33097 } }, -- TODO: Not actually CC immune despite CC not doing anything (maybe switch to knockback immunity eventually)

    -- Bosses
    ["War Chief Ozozai"] = { [1] = { id = 33097 } },
    ["Broodbirther"] = { [1] = { id = 33097 } },

    ["Mad Griskild"] = { [1] = { id = 33097 } },            -- Quest -- Vvardenfell -- A Web of Troubles
    ["Veya Releth"] = { [1] = { id = 33097 } },             -- Quest -- Vvardenfell - Family Reunion
    ["Old Rust-Eye"] = { [1] = { id = 33097 } },            -- Delve -- Vvardenfell - Khartag Point
    ["Cliff Strider Matriarch"] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Beckoner Morvayn"] = { [1] = { id = 33097 } },        -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Confessor Dradas"] = { [1] = { id = 33097 } },        -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Coaxer Veran"] = { [1] = { id = 33097 } },            -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Castigator Athin"] = { [1] = { id = 33097 } },        -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Stone-Boiler Omalas"] = { [1] = { id = 33097 } },     -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Brander Releth"] = { [1] = { id = 33097 } },          -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Mountain-Caller Hlaren"] = { [1] = { id = 33097 } },  -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Wakener Maras"] = { [1] = { id = 33097 } },           -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Nevena Nirith"] = { [1] = { id = 33097 } },           -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ["Mud-Tusk"] = { [1] = { id = 33097 } },                -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ["Guardian of Bthark"] = { [1] = { id = 33097 } },      -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ["Renduril the Hammer"] = { [1] = { id = 33097 } },     -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ["Friar Hadelar"] = { [1] = { id = 33097 } },           -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ["Steamreaver"] = { [1] = { id = 33097 } },             -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ["Artisan Lenarmen"] = { [1] = { id = 33097 } },        -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ["Nchulaeon the Eternal"] = { [1] = { id = 33097 } },   -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ["Nilarion the Cavalier"] = { [1] = { id = 33097 } },   -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ["Curate Erydno"] = { [1] = { id = 33097 } },           -- Quest -- Vvardenfell -- Divine Inquires
    ["Savarak Fels"] = { [1] = { id = 33097 } },            -- Quest -- Vvardenfell -- Reclamining Vos
    ["Th'krak the Tunnel-King"] = { [1] = { id = 33097 } }, -- Delve -- Vvardenfell -- Matus-Akin Egg Mine
    ["Slavemaster Arenim"] = { [1] = { id = 33097 } },      -- Quest -- Vvardenfell -- The Heart of a Telvanni
    ["Chodala"] = { [1] = { id = 33097 } },                 -- Quest -- Vvardenfell -- Divine Intervention
    ["Clockwork Guardian"] = { [1] = { id = 33097 } },      -- Quest -- Vvardenfell -- Divine Restoration
    ["Jovval Mortal-Bane"] = { [1] = { id = 33097 } },      -- Quest -- Vvardenfell -- Divine Restoration
    ["Clockwork Defense Core"] = { [1] = { id = 33097 } },  -- Quest -- Vvardenfell -- Divine Restoration
    ["Clockwork Mediator"] = { [1] = { id = 33097 } },      -- Quest -- Vvardenfell -- Divine Restoration
    ["Clockwork Mediator Core"] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ["Clockwork Assembly Core"] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ["Barbas"] = { [1] = { id = 33097 } },                  -- Quest -- Vvardenfell -- Divine Restoration

    --------------------------------------------
    -- ARENAS ----------------------------------
    --------------------------------------------

    -- Dragonstar Arena
    [Unitnames.Boss_Champion_Marcauld] = { [1] = { id = 33097 } },                              -- Champion Marcauld
    [Unitnames.Boss_Yavni_Frost_Skin] = { [1] = { id = 33097 } },                               -- Yavni Frost-Skin
    [Unitnames.Boss_Katti_Ice_Turner] = { [1] = { id = 33097 } },                               -- Katti Ice-Turner
    [Unitnames.Boss_Shilia] = { [1] = { id = 33097 } },                                         -- Shilia
    [Unitnames.Boss_Nak_tah] = { [1] = { id = 33097 } },                                        -- Nak'tah
    [Unitnames.Boss_Earthen_Heart_Knight] = { [1] = { id = 33097 } },                           -- Earthen Heart Knight
    [Unitnames.NPC_Anka_Ra_Shadowcaster] = { [1] = { id = 33097 } },                            -- Anka-Ra Shadowcaster
    [Unitnames.Boss_Anala_tuwha] = { [1] = { id = 33097 } },                                    -- Anal'a Tu'wha
    [Unitnames.NPC_Pacthunter_Ranger] = { [1] = { id = 33097 } },                               -- Pacthunter Ranger
    [Unitnames.Boss_Pishna_Longshot] = { [1] = { id = 33097 } },                                -- Pishna Longshot
    [Unitnames.Boss_Shadow_Knight] = { [1] = { id = 33097, zone = { [635] = true } } },         -- Shadow Knight (Dragonstar Arena)
    [Unitnames.Boss_Dark_Mage] = { [1] = { id = 33097, zone = { [635] = true } } },             -- Dark Mage (Dragonstar Arena)
    [Unitnames.NPC_Dwarven_Fire_Centurion] = { [1] = { id = 33097, zone = { [635] = true } } }, -- Dwarven Fire Centurion (Dragonstar Arena)
    [Unitnames.Boss_Mavus_Talnarith] = { [1] = { id = 33097 } },                                -- Mavus Talnarith
    [Unitnames.Boss_Zackael_Jonnicent] = { [1] = { id = 33097 } },                              -- Zackael Jonnicent
    [Unitnames.Boss_Rubyn_Jonnicent] = { [1] = { id = 33097 } },                                -- Rubyn Jonnicent
    [Unitnames.Boss_Vampire_Lord_Thisa] = { [1] = { id = 33097 } },                             -- Vampire Lord Thisa
    [Unitnames.Boss_Hiath_the_Battlemaster] = { [1] = { id = 33097 } },                         -- Hiath the Battlemaster

    -- Maelstrom Arena
    [Unitnames.Boss_Maxus_the_Many] = { [1] = { id = 33097 } },                           -- Maxus the Many
    [Unitnames.NPC_Clockwork_Sentry] = { [1] = { id = 33097, zone = { [677] = true } } }, -- Clockwork Sentry (Maelstrom Arena)
    [Unitnames.NPC_Queens_Pet] = { [1] = { id = 33097, zone = { [677] = true } } },       -- Queen's Pet (Maelstrom Arena)
    [Unitnames.NPC_Queens_Champion] = { [1] = { id = 33097, zone = { [677] = true } } },  -- Queen's Champion (Maelstrom Arena)
    [Unitnames.NPC_Queens_Advisor] = { [1] = { id = 33097, zone = { [677] = true } } },   -- Queen's Advisor (Maelstrom Arena)
    [Unitnames.Boss_Lamia_Queen] = { [1] = { id = 33097, zone = { [677] = true } } },     -- Lamia Queen (Maelstrom Arena)
    [Unitnames.Boss_The_Control_Guardian] = { [1] = { id = 33097 } },                     -- The Control Guardian
    [Unitnames.NPC_Troll_Breaker] = { [1] = { id = 33097 } },                             -- Troll Breaker
    [Unitnames.NPC_Ogre_Elder] = { [1] = { id = 33097, zone = { [677] = true } } },       -- Ogre Elder (Maelstrom Arena)
    [Unitnames.Boss_Matriarch_Runa] = { [1] = { id = 33097 } },                           -- Matriarch Runa

    --------------------------------------------
    -- DUNGEONS --------------------------------
    --------------------------------------------

    -- Banished Cells I
    [Unitnames.Boss_Cell_Haunter] = { [1] = { id = 33097 } },                 -- Cell Haunter
    [Unitnames.Boss_Shadowrend] = { [1] = { id = 33097 } },                   -- Shadowrend
    [Unitnames.Boss_Angata_the_Clannfear_Handler] = { [1] = { id = 33097 } }, -- Angata the Clannfear Handler
    [Unitnames.Boss_High_Kinlord_Rilis] = { [1] = { id = 33097 } },           -- High Kinlord Rilis

    -- Banished Cells II
    [Unitnames.Boss_Keeper_Areldur] = { [1] = { id = 33097 } },      -- Keeper Areldur
    [Unitnames.Boss_Maw_of_the_Infernal] = { [1] = { id = 33097 } }, -- Maw of the Infernal
    [Unitnames.Boss_Keeper_Voranil] = { [1] = { id = 33097 } },      -- Keeper Voranil
    [Unitnames.Boss_Keeper_Imiril] = { [1] = { id = 33097 } },       -- Keeper Imiril

    -- Elden Hollow I
    [Unitnames.Boss_Ancient_Spriggan] = { [1] = { id = 33097 } },   -- Ancient Spriggan
    [Unitnames.Boss_Akash_gra_Mal] = { [1] = { id = 33097 } },      -- Akash gra-Mal
    [Unitnames.Boss_Chokethorn] = { [1] = { id = 33097 } },         -- Chokethorn
    [Unitnames.Boss_Nenesh_gro_Mal] = { [1] = { id = 33097 } },     -- Nenesh gro-Mal
    [Unitnames.Boss_Leafseether] = { [1] = { id = 33097 } },        -- Leafseether
    [Unitnames.Boss_Canonreeve_Oraneth] = { [1] = { id = 33097 } }, -- Canonreeve Oraneth

    -- Elden Hollow II
    [Unitnames.Boss_Dubroze_the_Infestor] = { [1] = { id = 33097 } },  -- Dubroze the Infestor
    [Unitnames.Boss_Dark_Root] = { [1] = { id = 33097 } },             -- Dark Root
    [Unitnames.Boss_Azara_the_Frightener] = { [1] = { id = 33097 } },  -- Azara the Frightener
    [Unitnames.Boss_Shadow_Tendril] = { [1] = { id = 33097 } },        -- Shadow Tendril
    [Unitnames.Boss_Murklight] = { [1] = { id = 33097 } },             -- Murklight
    [Unitnames.Boss_The_Shadow_Guard] = { [1] = { id = 33097 } },      -- The Shadow Guard
    [Unitnames.Boss_Bogdan_the_Nightflame] = { [1] = { id = 33097 } }, -- Bogdan the Nightflame
    [Unitnames.Boss_Nova_Tendril] = { [1] = { id = 33097 } },          -- Nova Tendril

    -- City of Ash I
    [Unitnames.Boss_Golor_the_Banekin_Handler] = { [1] = { id = 33097 } }, -- Golor the Banekin Handler
    [Unitnames.Boss_Warden_of_the_Shrine] = { [1] = { id = 33097 } },      -- Warden of the Shrine
    [Unitnames.Boss_Infernal_Guardian] = { [1] = { id = 33097 } },         -- Infernal Guardian
    [Unitnames.Boss_Dark_Ember] = { [1] = { id = 33097 } },                -- Dark Ember
    [Unitnames.Boss_Rothariel_Flameheart] = { [1] = { id = 33097 } },      -- Rothariel Flameheart
    [Unitnames.Boss_Razor_Master_Erthas] = { [1] = { id = 33097 } },       -- Razor Master Erthas

    -- City of Ash II
    [Unitnames.Boss_Akezel] = { [1] = { id = 33097 } },                                  -- Akezel
    [Unitnames.Boss_Rukhan] = { [1] = { id = 33097 } },                                  -- Rukhan
    [Unitnames.Boss_Marruz] = { [1] = { id = 33097 } },                                  -- Marruz
    [Unitnames.NPC_Xivilai_Immolator] = { [1] = { id = 33097 } },                        -- Xivilai Immolator
    [Unitnames.NPC_Xivilai_Ravager] = { [1] = { id = 33097 } },                          -- Xivilai Ravager
    [Unitnames.Boss_Urata_the_Legion] = { [1] = { id = 33097 } },                        -- Urata the Legion
    [Unitnames.NPC_Flame_Colossus] = { [1] = { id = 33097 } },                           -- Flame Colossus
    [Unitnames.Boss_Horvantud_the_Fire_Maw] = { [1] = { id = 33097 } },                  -- Horvantud the Fire Maw
    [Unitnames.Boss_Ash_Titan] = { [1] = { id = 33097 } },                               -- Ash Titan
    [Unitnames.NPC_Air_Atronach] = { [1] = { id = 33097, zone = { [681] = true } } },    -- Air Atronach (City of Ash II)
    [Unitnames.NPC_Dremora_Hauzkyn] = { [1] = { id = 33097, zone = { [681] = true } } }, -- Dremora Hauzkyn (City of Ash II)
    [Unitnames.NPC_Fire_Ravager] = { [1] = { id = 33097 } },                             -- Fire Ravager
    [Unitnames.NPC_Xivilai_Fulminator] = { [1] = { id = 33097 } },                       -- Xivilai Fulminator
    [Unitnames.NPC_Xivilai_Boltaic] = { [1] = { id = 33097 } },                          -- Xivilai Fulminator
    [Unitnames.Boss_Valkyn_Skoria] = { [1] = { id = 33097 } },                           -- Valkyn Skoria

    -- Tempest Island
    [Unitnames.Boss_Sonolia_the_Matriarch] = { [1] = { id = 33097 } }, -- Sonolia the Matriarch
    [Unitnames.Boss_Valaran_Stormcaller] = { [1] = { id = 33097 } },   -- Valaran Stormcaller
    [Unitnames.NPC_Lightning_Avatar] = { [1] = { id = 33097 } },       -- Lightning Avatar
    [Unitnames.Boss_Yalorasse_the_Speaker] = { [1] = { id = 33097 } }, -- Yalorasse the Speaker
    [Unitnames.Boss_Stormfist] = { [1] = { id = 33097 } },             -- Stormfist
    [Unitnames.Boss_Commodore_Ohmanil] = { [1] = { id = 33097 } },     -- Commodore Ohmanil
    [Unitnames.Boss_Stormreeve_Neidir] = { [1] = { id = 33097 } },     -- Stormreeve Neidir

    -- Selene's Web
    [Unitnames.Boss_Treethane_Kerninn] = { [1] = { id = 33097 } }, -- Treethane Kerninn
    [Unitnames.Boss_Longclaw] = { [1] = { id = 33097 } },          -- Longclaw
    [Unitnames.Boss_Queen_Aklayah] = { [1] = { id = 33097 } },     -- Queen Aklayah
    [Unitnames.Boss_Foulhide] = { [1] = { id = 33097 } },          -- Foulhide
    [Unitnames.Boss_Mennir_Many_Legs] = { [1] = { id = 33097 } },  -- Mennir Many-Legs
    [Unitnames.Boss_Selene] = { [1] = { id = 33097 } },            -- Selene

    -- Spindleclutch I
    [Unitnames.Boss_Spindlekin] = { [1] = { id = 33097 } },             -- Spindlekin
    [Unitnames.Boss_Swarm_Mother] = { [1] = { id = 33097 } },           -- Swarm Mother
    [Unitnames.Boss_Cerise_the_Widow_Maker] = { [1] = { id = 33097 } }, -- Cerise the Widow-Maker
    [Unitnames.Boss_Big_Rabbu] = { [1] = { id = 33097 } },              -- Big Rabbu
    [Unitnames.Boss_The_Whisperer] = { [1] = { id = 33097 } },          -- The Whisperer
    [Unitnames.Boss_Praxin_Douare] = { [1] = { id = 33097 } },          -- Praxin Douare

    -- Spindleclutch II
    [Unitnames.Boss_Mad_Mortine] = { [1] = { id = 33097 } },                                          -- Mad Mortine
    [Unitnames.Boss_Blood_Spawn] = { [1] = { id = 33097 } },                                          -- Blood Spawn
    [Unitnames.NPC_Flesh_Atronach] = { [1] = { id = 33097, zone = { [936] = true, [932] = true } } }, -- Flesh Atronach
    [Unitnames.Boss_Urvan_Veleth] = { [1] = { id = 33097 } },                                         -- Urvan Veleth
    [Unitnames.Boss_Vorenor_Winterbourne] = { [1] = { id = 33097 } },                                 -- Vorenor Winterborne

    -- Wayrest Sewers I
    [Unitnames.Boss_Slimecraw] = { [1] = { id = 33097 } },           -- Slimecraw
    [Unitnames.Boss_Investigator_Garron] = { [1] = { id = 33097 } }, -- Investigator Garron
    [Unitnames.Boss_Uulgarg_the_Hungry] = { [1] = { id = 33097 } },  -- Uulgarg the Hungry
    [Unitnames.Boss_the_Rat_Whisperer] = { [1] = { id = 33097 } },   -- The Rat Whisperer
    [Unitnames.Boss_Varaine_Pellingare] = { [1] = { id = 33097 } },  -- Varaine Pellingare
    [Unitnames.Boss_Allene_Pellingare] = { [1] = { id = 33097 } },   -- Allene Pellingare

    -- Wayrest Sewers II
    [Unitnames.Boss_Malubeth_the_Scourger] = { [1] = { id = 33097 } }, -- Malubeth the Scourger
    [Unitnames.Boss_Skull_Reaper] = { [1] = { id = 33097 } },          -- Skull Reaper
    [Unitnames.Boss_Uulgarg_the_Risen] = { [1] = { id = 33097 } },     -- Uulgarg the Risen
    [Unitnames.Boss_Garron_the_Returned] = { [1] = { id = 33097 } },   -- Garron the Returned
    [Unitnames.Boss_The_Forgotten_One] = { [1] = { id = 33097 } },     -- The Forgotten One

    -- Crypt of Hearts I
    [Unitnames.Boss_The_Mage_Master] = { [1] = { id = 33097 } },     -- The Mage Master
    [Unitnames.Boss_Archmaster_Siniel] = { [1] = { id = 33097 } },   -- Archmaster Siniel
    [Unitnames.Boss_Deaths_Leviathan] = { [1] = { id = 33097 } },    -- Death's Leviathan
    [Unitnames.Boss_Dogas_the_Berserker] = { [1] = { id = 33097 } }, -- Dogas the Berserker
    [Unitnames.Boss_Ilambris_Athor] = { [1] = { id = 33097 } },      -- Ilambris-Athor
    [Unitnames.Boss_Ilambris_Zaven] = { [1] = { id = 33097 } },      -- Ilambris-Zaven

    -- Crypt of Hearts II
    [Unitnames.Boss_Ibelgast] = { [1] = { id = 33097 } },                                  -- Ibelgast
    [Unitnames.Boss_Ruzozuzalpamaz] = { [1] = { id = 33097 } },                            -- Ruzozuzalpamaz
    [Unitnames.NPC_Ibelgasts_Flesh_Atronach] = { [1] = { id = 33097 } },                   -- Ibelgasts Flesh Atronach
    [Unitnames.NPC_Ogrim] = { [1] = { id = 33097, zone = { [932] = true } } },             -- Ogrim
    [Unitnames.Boss_Chamber_Guardian] = { [1] = { id = 33097, zone = { [932] = true } } }, -- Chamber Guardian
    [Unitnames.Boss_Ilambris_Amalgam] = { [1] = { id = 33097 } },                          -- Ilambris Amalgam
    [Unitnames.Boss_Mezeluth] = { [1] = { id = 33097 } },                                  -- Mezeluth
    [Unitnames.Boss_Nerieneth] = { [1] = { id = 33097 } },                                 -- Nerien'eth
    [Unitnames.NPC_Wraith] = { [1] = { id = 33097, zone = { [932] = true } } },            -- Wraith
    [Unitnames.NPC_Student] = { [1] = { id = 33097, zone = { [932] = true } } },           -- Student

    -- Volenfell
    [Unitnames.Boss_Desert_Lioness] = { [1] = { id = 33097, zone = { [22] = true } } },          -- Desert Lioness
    [Unitnames.Boss_Desert_Lion] = { [1] = { id = 33097, zone = { [22] = true } } },             -- Desert Lion
    [Unitnames.Boss_Quintus_Verres] = { [1] = { id = 33097 } },                                  -- Quintus Verres
    [Unitnames.Boss_Monstrous_Gargoyle] = { [1] = { id = 33097 } },                              -- Monstrous Gargoyle
    [Unitnames.Boss_Boilbite] = { [1] = { id = 33097 } },                                        -- Boilbite
    [Unitnames.Boss_Boilbites_Assassin_Beetle] = { [1] = { id = 33097 } },                       -- Boilbite's Assassin Beetle
    [Unitnames.Boss_Unstable_Construct] = { [1] = { id = 33097 } },                              -- Unstable Construct
    [Unitnames.Boss_Unstable_Dwarven_Spider] = { [1] = { id = 33097, zone = { [22] = true } } }, -- Unstable Dwarven Spider
    [Unitnames.Boss_Tremorscale] = { [1] = { id = 33097 } },                                     -- Tremorscale
    [Unitnames.Boss_The_Guardians_Strength] = { [1] = { id = 33097 } },                          -- The Guardian's Strength
    [Unitnames.Boss_The_Guardians_Spark] = { [1] = { id = 33097 } },                             -- The Guardian's Spark
    [Unitnames.Boss_The_Guardians_Soul] = { [1] = { id = 33097 } },                              -- The Guardian's Soul

    -- Frostvault
    [Unitnames.NPC_Coldsnap_Ogre] = { [1] = { id = 33097 } }, -- Coldsnap Ogre
    [Unitnames.Boss_Icestalker] = { [1] = { id = 33097 } },   -- Icestalker
}

--- @class (partial) AddNameAura
LuiData.Data.Effects.AddNameAura = AddNameAura
