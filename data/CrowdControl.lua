--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Effects namespace
LUIE.CrowdControl = {}
local CC = LUIE.CrowdControl

local aoeCounter = 0
CC.aoeTypesId = { }

-- Since there can't be gaps in the Aoe Priority list, we use a Counter to increment each Id added so its placed in the right priority.
-- Not some id's will not increment AoeCounter+1 - this is when Id's should have a shared priority due to the same ability having multiple damage id's.


-- TODO: Lets use these categories and build a table from them based off the menu settings, this ensures no priority gap
-- CC.aoePlayerUltimate
-- CC.aoePlayerNormal
-- CC.aoePlayerSet
-- CC.aoeNormal
-- CC.aoeElite
-- cc.aoeBoss
-- CC.aoeTrap
--
-- build into table in CCT file called CCT.aoeTypesId again

-- TODO: Lets use these categories and build a table from them based off the menu settings, this ensures no priority gap
-- CC.aoePlayerUltimate
-- CC.aoePlayerNormal
-- CC.aoePlayerSet
-- CC.aoeNormal
-- CC.aoeElite
-- cc.aoeBoss
-- CC.aoeTrap
--
-- build into table in CCT file called CCT.aoeTypesId again
local CC_AOE_PLAYER_ULTIMATE    = 1
local CC_AOE_PLAYER_NORMAL      = 2
local CC_AOE_PLAYER_SET         = 3
local CC_AOE_TRAP               = 4
local CC_AOE_NPC_BOSS           = 5
local CC_AOE_NPC_ELITE          = 6
local CC_AOE_NPC_NORMAL         = 7

-- TODO: Add this loop to CCT
--[[
if i = 1, 7 do
    for k, v in pairs(CC.i) do
        if v = 1 then counter = counter + 1 else counter = counter end
        CCT.aoeTypesId[k] = counter
    end
end ]]--

CC.aoeTypesId[104007] = aoeCounter+1 -- Time Stop
CC.aoeTypesId[104072] = aoeCounter+1 -- Borrowed Time
CC.aoeTypesId[104082] = aoeCounter+1 -- Time Freeze

-- PVE PRIORITY GUIDE
-- Player Ultimates
-- Player Abilities
-- Monster Helms
-- Traps/Environmental
-- Dungeon/Trial Bosses
-- ELITES & Quest Bosses
-- Normal NPC's

-- PLAYER ABILITIES

-- Dragonknight
CC.aoeTypesId[28995] = aoeCounter -- Dragonknight Standard
CC.aoeTypesId[32960] = aoeCounter -- Shifting Standard
CC.aoeTypesId[32964] = aoeCounter -- Shifting Standard
CC.aoeTypesId[32948] = aoeCounter -- Standard of Might
CC.aoeTypesId[32711] = aoeCounter+1 -- Eruption (Eruption)

-- Warden
CC.aoeTypesId[88783] = aoeCounter -- Impaling Shards (Impaling Shards)
CC.aoeTypesId[88791] = aoeCounter -- Gripping Shards (Gripping Shards)
CC.aoeTypesId[88802] = aoeCounter -- Winter's Revenge (Winter's Revenge)
CC.aoeTypesId[86247] = aoeCounter -- Sleet Storm (Sleet Storm)
CC.aoeTypesId[88860] = aoeCounter -- Northern Storm (Northern Storm)
CC.aoeTypesId[88863] = aoeCounter -- Permafrost (Permafrost)

-- Templar
CC.aoeTypesId[26192] = aoeCounter -- Spear Shards
CC.aoeTypesId[95931] = aoeCounter -- Spear Shards
CC.aoeTypesId[26859] = aoeCounter -- Luminous Shards
CC.aoeTypesId[95955] = aoeCounter -- Luminous Shards
CC.aoeTypesId[26871] = aoeCounter -- Blazing Spear
CC.aoeTypesId[26879] = aoeCounter -- Blazing Spear
CC.aoeTypesId[21753] = aoeCounter -- Nova
CC.aoeTypesId[21756] = aoeCounter -- Solar Prison
CC.aoeTypesId[21759] = aoeCounter -- Solar Disturbance
CC.aoeTypesId[80172] = aoeCounter+1 -- Ritual of Retribution (Ritual of Retribution)

-- Sorcerer
CC.aoeTypesId[23189] = aoeCounter -- Lightning Splash (Lightning Splash)
CC.aoeTypesId[23202] = aoeCounter -- Liquid Lightning (Liquid Lightning)
CC.aoeTypesId[23208] = aoeCounter -- Lightning Flood (Lightning Flood)
CC.aoeTypesId[80435] = aoeCounter+1 -- Suppression Field (Suppression Field)

-- Nightblade
CC.aoeTypesId[36052] = aoeCounter+1 -- Twisting Path (Twisting Path)
CC.aoeTypesId[36490] = aoeCounter+1 -- Veil of Blades (Veil of Blades)

-- Necromancer
CC.aoeTypesId[115254] = aoeCounter+1 -- Boneyard (Boneyard)
CC.aoeTypesId[117809] = aoeCounter -- Unnerving Boneyard (Unnerving Boneyard)
CC.aoeTypesId[117854] = aoeCounter -- Avid Boneyard (Avid Boneyard)

CC.aoeTypesId[116410] = aoeCounter+1 -- Shocking Siphon (Shocking Siphon)
CC.aoeTypesId[118766] = aoeCounter -- Detonating Siphon (Detonating Siphon)
CC.aoeTypesId[118011] = aoeCounter -- Mystic Siphon (Mystic Siphon)

CC.aoeTypesId[122178] = aoeCounter+1 -- Frozen Colossus (Frozen Colossus)

CC.aoeTypesId[122399] = aoeCounter+1 -- Pestilent Colossus (Pestilent Colossus)
CC.aoeTypesId[122400] = aoeCounter+1 -- Pestilent Colossus (Pestilent Colossus)
CC.aoeTypesId[122401] = aoeCounter+1 -- Pestilent Colossus (Pestilent Colossus)

CC.aoeTypesId[122392] = aoeCounter+1 -- Glacial Colossus (Glacial Colossus)

CC.aoeTypesId[118289] = aoeCounter+1 -- Ravenous Goliath (Ravenous Goliath)

CC.aoeTypesId[85127] = aoeCounter+1 --Fiery Rage
CC.aoeTypesId[85131] = aoeCounter+1 --Thunderous Rage
CC.aoeTypesId[85129] = aoeCounter+1 --Icy Rage
CC.aoeTypesId[83683] = aoeCounter+1 --Eye of Flame
CC.aoeTypesId[83687] = aoeCounter+1 --Eye of Lightning
CC.aoeTypesId[83685] = aoeCounter+1 --Eye of Frost
CC.aoeTypesId[83626] = aoeCounter+1 --Fire Storm
CC.aoeTypesId[83631] = aoeCounter+1 --Thunder Storm
CC.aoeTypesId[83629] = aoeCounter+1 --Ice Storm

CC.aoeTypesId[62896] = aoeCounter+1 -- Wall of Fire
CC.aoeTypesId[62971] = aoeCounter+1 -- Wall of Storms
CC.aoeTypesId[62931] = aoeCounter+1 -- Wall of Frost
CC.aoeTypesId[39054] = aoeCounter+1 -- Unstable Wall of Fire
CC.aoeTypesId[39079] = aoeCounter+1 -- Unstable Wall of Storms
CC.aoeTypesId[39071] = aoeCounter+1 -- Unstable Wall of Frost
CC.aoeTypesId[62912] = aoeCounter+1 -- Blockade of Fire
CC.aoeTypesId[62990] = aoeCounter+1 -- Blockade of Storms
CC.aoeTypesId[62951] = aoeCounter+1 -- Blockade of Frost

CC.aoeTypesId[63429] = aoeCounter -- Meteor
CC.aoeTypesId[63454] = aoeCounter -- Ice Comet
CC.aoeTypesId[63471] = aoeCounter -- Shooting Star

CC.aoeTypesId[32625] = aoeCounter+1 -- Bat Swarm
CC.aoeTypesId[38935] = aoeCounter+1 -- Clouding Swarm
CC.aoeTypesId[38934] = aoeCounter+1 -- Devouring Swarm

CC.aoeTypesId[28877] = aoeCounter -- Volley
CC.aoeTypesId[38690] = aoeCounter -- Endless Hail
CC.aoeTypesId[38696] = aoeCounter -- Arrow Barrage

CC.aoeTypesId[38561] = aoeCounter -- Caltrops (Caltrops)
CC.aoeTypesId[40267] = aoeCounter -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
CC.aoeTypesId[40252] = aoeCounter -- Razor Caltrops (Razor Caltrops)

-- Volendrung
CC.aoeTypesId[116669] = aoeCounter+1 -- Ebony Cyclone (Ruinous Cyclone)

-- MONSTER HELMS
CC.aoeTypesId[102136] = aoeCounter+1 -- Zaan
CC.aoeTypesId[59568] = aoeCounter+1 -- Malubeth
CC.aoeTypesId[80522] = aoeCounter+1 -- Stormfist
CC.aoeTypesId[59498] = aoeCounter+1 -- Mephala's Web (Spawm of Mephala)
CC.aoeTypesId[60972] = aoeCounter+1 -- Fiery Breath (Maw of the Infernal)
CC.aoeTypesId[80525] = aoeCounter+1 -- Ilambris
CC.aoeTypesId[80526] = aoeCounter -- Ilambris
CC.aoeTypesId[84502] = aoeCounter+1 -- Grothdarr
CC.aoeTypesId[80561] = aoeCounter+1 -- Iceheart
CC.aoeTypesId[97883] = aoeCounter+1 -- Domihaus
CC.aoeTypesId[97899] = aoeCounter -- Domihaus
CC.aoeTypesId[80565] = aoeCounter+1 -- Kra'gh

CC.aoeTypesId[106783] = aoeCounter+1 -- Dustcloud Damage (Adept Rider's)
CC.aoeTypesId[75692] = aoeCounter+1 -- Bahraha's Curse (of Bahraha's Curse)
CC.aoeTypesId[57209] = aoeCounter+1 -- Storm Knight's Plate (of the Storm Knight)
CC.aoeTypesId[59696] = aoeCounter+1 -- Embershield (Embershield)
CC.aoeTypesId[67204] = aoeCounter+1 -- Leeching Plate (of Leeching)
CC.aoeTypesId[102094] = aoeCounter+1 -- Thurvokun (Thurvokun)

CC.aoeTypesId[116920] = aoeCounter+1 -- Auroran's Thunder (Auroran's Thunder)

-- SIEGE
CC.aoeTypesId[104693] = aoeCounter+1 -- Meatbag Catapult
CC.aoeTypesId[104695] = aoeCounter+1 -- Scattershot Catapult

-- NORMAL
CC.aoeTypesId[37131] = aoeCounter+1 -- Ice Cage (Battlemage)
CC.aoeTypesId[10813] = aoeCounter+1 -- Ignite (Synergy - Fire Mage)
CC.aoeTypesId[38260] = aoeCounter+1 -- Ignite (Synergy - Fire Mage)
CC.aoeTypesId[28629] = aoeCounter+1 -- Volley (Archer)
CC.aoeTypesId[47102] = aoeCounter+1 -- Fire Rune (Fire Mage)
CC.aoeTypesId[14068] = aoeCounter+1 -- Ignite (Synergy - Archer)
CC.aoeTypesId[70414] = aoeCounter+1 -- Ignite (Synergy - Cyrodiil Archer)
CC.aoeTypesId[38125] = aoeCounter+1 -- Caltrops  (Faction NPCs)
CC.aoeTypesId[76730] = aoeCounter+1 -- Pool of Shadow (Voidbringer)
CC.aoeTypesId[76624] = aoeCounter+1 -- Pool of Shadow (Voidbringer)
CC.aoeTypesId[76729] = aoeCounter+1 -- Pool of Shadow (Voidbringer)
CC.aoeTypesId[76728] = aoeCounter+1 -- Pool of Shadow (Voidbringer)
CC.aoeTypesId[88336] = aoeCounter+1 -- Pool of Shadow (Skaafin Masquer)
CC.aoeTypesId[88330] = aoeCounter+1 -- Pool of Shadow (Skaafin Masquer)
CC.aoeTypesId[88335] = aoeCounter+1 -- Pool of Shadow (Skaafin Masquer)
CC.aoeTypesId[88334] = aoeCounter+1 -- Pool of Shadow (Skaafin Masquer)
CC.aoeTypesId[84837] = aoeCounter+1 -- Broken Pact (Skaafin)
CC.aoeTypesId[62502] = aoeCounter+1 -- Fiery Wind (Justice Mage)
CC.aoeTypesId[46819] = aoeCounter+1 -- Storm Damage (Cyrodiil Mage)
CC.aoeTypesId[7883] = aoeCounter+1 -- Guardian Storm (Cyrodiil Mage)
CC.aoeTypesId[8604] = aoeCounter+1 -- Vigorous Swipe (Mammoth)
CC.aoeTypesId[27100] = aoeCounter+1 -- Shocking Rake (Dreugh)
CC.aoeTypesId[16698] = aoeCounter+1 -- Poisonbloom (Netch)
CC.aoeTypesId[90778] = aoeCounter+1 -- Acid Pool (Nix-Ox)
CC.aoeTypesId[90815] = aoeCounter+1 -- Acid Pool (Nix-Ox)
CC.aoeTypesId[85421] = aoeCounter+1 -- Retch (Cliff Strider)
CC.aoeTypesId[85391] = aoeCounter+1 -- Slash (Cliff Strider)
CC.aoeTypesId[13680] = aoeCounter+1 -- Acid Blood (Assassin Beetle)
CC.aoeTypesId[10947] = aoeCounter+1 -- Fiery Breath (Shalk)
CC.aoeTypesId[5265] = aoeCounter+1 -- Burning Ground (Shalk)
CC.aoeTypesId[8088] = aoeCounter+1 -- Poison Spray (Giant Spider)
CC.aoeTypesId[87126] = aoeCounter+1 -- Heat Vents (Fetcherfly Nest)
CC.aoeTypesId[51282] = aoeCounter+1 -- Flame Tornado (Air Atronach - Flame)
CC.aoeTypesId[9749] = aoeCounter+1 -- Envelop (Banekin)
CC.aoeTypesId[73437] = aoeCounter+1 -- Soul Flame (Daedric Titan)
CC.aoeTypesId[4772] = aoeCounter+1 -- Fiery Breath (Daedroth)
CC.aoeTypesId[91938] = aoeCounter+1 -- Burst of Embers (Daedroth)
CC.aoeTypesId[51645] = aoeCounter+1 -- Frozen Ground (Frost Atronach)
CC.aoeTypesId[6162] = aoeCounter+1 -- Rain of Fire (Scamp)
CC.aoeTypesId[88323] = aoeCounter+1 -- Blast Furnace (Iron Atronach)
CC.aoeTypesId[69950] = aoeCounter+1 -- Desecrated Ground (Undead Synergy)
CC.aoeTypesId[73937] = aoeCounter+1 -- Soul Cage (Lich)
CC.aoeTypesId[73929] = aoeCounter+1 -- Soul Cage (Lich)
CC.aoeTypesId[20812] = aoeCounter+1 -- Defiled Ground (Lich)
CC.aoeTypesId[72996] = aoeCounter+1 -- Symphony of Blades (Defiled Aegis)
CC.aoeTypesId[8628] = aoeCounter+1 -- Charged Ground (Harpy)
CC.aoeTypesId[4769] = aoeCounter+1 -- Choking Pollen (Lurcher)
CC.aoeTypesId[16040] = aoeCounter+1 -- Hurricane (Nereid)
CC.aoeTypesId[19997] = aoeCounter+1 -- Static Field (Dwemer Spider - Synergy)
CC.aoeTypesId[91094] = aoeCounter -- Split Bolt (Dwemer Arquebus)
CC.aoeTypesId[91095] = aoeCounter -- Split Bolt (Dwemer Arquebus)
CC.aoeTypesId[91096] = aoeCounter -- Split Bolt (Dwemer Arquebus)
CC.aoeTypesId[103862] = aoeCounter+1 -- Deluge (Yaghra Spewer)
CC.aoeTypesId[103992] = aoeCounter+1 -- Luminescent Burn (Yaghra Spewer)
CC.aoeTypesId[105889] = aoeCounter+1 -- Pustulant Eruption (Yaghra Nightmare)

CC.aoeTypesId[94936] = aoeCounter+1 -- Tremor (Nchuleftingth - Mud-Tusk)
CC.aoeTypesId[86566] = aoeCounter+1 -- Fire Runes (Nchuleftingth - Friar Hadelar)
CC.aoeTypesId[89754] = aoeCounter+1 -- Shocking Rake (Old Rust-Eye - Khartag Point)

-- TRAPS
CC.aoeTypesId[87949] = aoeCounter -- Lava (Foyada Quarry)
CC.aoeTypesId[44034] = aoeCounter -- Slaughterfish Attack (Stirk)
CC.aoeTypesId[113082] = aoeCounter -- Slaughterfish Attack (Cyrodiil)
CC.aoeTypesId[19224] = aoeCounter -- In Lava (Halls of Torment)
CC.aoeTypesId[11338] = aoeCounter -- In Lava (The Earth Forge)
CC.aoeTypesId[16589] = aoeCounter -- Fire (Dummy ID for zone based name override) -- TODO: Maybe do something here
CC.aoeTypesId[56277] = aoeCounter -- Lava (City of Ash II)
CC.aoeTypesId[5140] = aoeCounter -- Lava (Dragonstar Arena)

CC.aoeTypesId[62770] = aoeCounter+1 -- Coldharbour Flames (Flame Trap) - Coldharbour Tutorial
CC.aoeTypesId[21943] = aoeCounter+1 -- Spike Trap (Spike Trap)
CC.aoeTypesId[53169] = aoeCounter+1 -- Spike Trap (Spike Trap) - Dragonstar Arena
CC.aoeTypesId[26531] = aoeCounter+1 -- Bear Trap (Bear Trap)
CC.aoeTypesId[31086] = aoeCounter+1 -- Trap (Trap) - Selene's Web

CC.aoeTypesId[17314] = aoeCounter+1 -- Fire Trap (Player)
CC.aoeTypesId[72888] = aoeCounter+1 -- Fire Attack 1 (Fire) -- Banished Cells II
CC.aoeTypesId[72889] = aoeCounter+1 -- Fire Attack 2 (Fire) -- Banished Cells II

CC.aoeTypesId[92757] = aoeCounter+1 -- Spinning Blade (Ald Carac)

CC.aoeTypesId[117508] = aoeCounter+1 -- Shock Wall (Lightning Trap - Elinhir Private Arena)
CC.aoeTypesId[117622] = aoeCounter+1 -- Shock Wall (Lightning Trap - Elinhir Private Arena)
CC.aoeTypesId[117598] = aoeCounter+1 -- Shock Wall (Lightning Trap - Elinhir Private Arena)
CC.aoeTypesId[117139] = aoeCounter+1 -- Spinning Blade (Blade Trap - Elinhir Private Arena)

CC.aoeTypesId[92150] = aoeCounter+1 -- Fire Trap (Vvardenfell -- Divine Delusions)
CC.aoeTypesId[87102] = aoeCounter+1 -- Spinning Blade (Vvardenfell -- Divine Restoration)
CC.aoeTypesId[92284] = aoeCounter+1 -- Planar Shear (Vvardenfell -- Divine Restoration)
CC.aoeTypesId[86743] = aoeCounter+1 -- Accelerated Transposition (Vvardenfell -- Like Blood from a Stone)
CC.aoeTypesId[84527] = aoeCounter+1 -- Searing Steam (Vvardenfell - Nchuleftingth)
CC.aoeTypesId[90271] = aoeCounter+1 -- Charge-Wire Shock (Vvardenfell - Nchuleftingth)
CC.aoeTypesId[92138] = aoeCounter+1 -- Laser Damage (Vvardenfell - Nchuleftingth)

-- ELITES
CC.aoeTypesId[44228] = aoeCounter+1 -- Dragonknight Standard (Dragonknight - Elite)
CC.aoeTypesId[81197] = aoeCounter+1 -- Agonizing Fury (Thundermaul - Boss)
CC.aoeTypesId[21952] = aoeCounter+1 -- Repulsion Shock (Wamasu)
CC.aoeTypesId[55867] = aoeCounter+1 -- Repulsion Shock (Wamasu - Boss)
CC.aoeTypesId[72794] = aoeCounter+1 -- Toxic Pool (Haj Mota)
CC.aoeTypesId[53233] = aoeCounter+1 -- Miasma Pool (Flesh Colossus)
CC.aoeTypesId[52866] = aoeCounter+1 -- Volley (Cyrodiil Archer)
CC.aoeTypesId[54258] = aoeCounter+1 -- Upgraded Volley (Cyrodiil Archer)
CC.aoeTypesId[10271] = aoeCounter+1 -- Quake (Gargoyle)
CC.aoeTypesId[9011] = aoeCounter+1 -- Tremor (Troll)
CC.aoeTypesId[75928] = aoeCounter+1 -- Elemental Pool (Minotaur)
CC.aoeTypesId[75953] = aoeCounter+1 -- Brimstone Hailfire (Minotaur Shaman)
CC.aoeTypesId[75976] = aoeCounter+1 -- Pillar of Nirn (Minotaur Shaman)
CC.aoeTypesId[75980] = aoeCounter+1 -- Pillar Eruption (Minotaur Shaman)
CC.aoeTypesId[11282] = aoeCounter+1 -- Steam Breath (Dwemer Centurion)

-- BOSSES
CC.aoeTypesId[84045] = aoeCounter+1 -- Seal of Defilement (Quenyas) - World Boss - Seaside Scarp Camp
CC.aoeTypesId[84206] = aoeCounter+1 -- Stinging Sputum (Gathongor the Mauler) - World Boss - Gathongor's Mine

-- QUESTS
CC.aoeTypesId[36860] = aoeCounter+1 -- Swordstorm Damage (MSQ - Halls of Torment)

CC.aoeTypesId[87959] = aoeCounter+1 -- Ash Storm (Vvardenfell -- Divine Delusions)

CC.aoeTypesId[90148] = aoeCounter+1 -- Sunder's Echo (Vvardenfell -- Divine Intervention)
CC.aoeTypesId[90146] = aoeCounter+1 -- Sunder's Echo (Vvardenfell -- Divine Intervention)

CC.aoeTypesId[90182] = aoeCounter+1 -- Oily Smoke (Vvardenfell -- Divine Restoration)
CC.aoeTypesId[69284] = aoeCounter+1 -- Whirlwind Function (Guardian of Bthark -- Nchuleftingth)
CC.aoeTypesId[86607] = aoeCounter+1 -- Steam Breath (Guardian of Bthark -- Nchuleftingth) -- Leaving here because it does massive damage

--------------------
-- Arenas
--------------------

-- Dragonstar Arena
CC.aoeTypesId[53341] = aoeCounter+1 -- Biting Cold (Player)
CC.aoeTypesId[60421] = aoeCounter+1 -- Biting Cold (Player)
CC.aoeTypesId[53314] = aoeCounter+1 -- Flame Volley (Sovngarde Ranger)
CC.aoeTypesId[53280] = aoeCounter+1 -- Unstable Wall of Frost (Sovngarde Icemage)
CC.aoeTypesId[83498] = aoeCounter+1 -- Poisonous Cloud (Poison Cloud)
CC.aoeTypesId[53614] = aoeCounter+1 -- Thundering Presence (Nak'tah)
CC.aoeTypesId[53625] = aoeCounter+1 -- Lightning Flood (Nak'tah)
CC.aoeTypesId[53660] = aoeCounter+1 -- Power Overload Heavy Attack (Nak'tah)
CC.aoeTypesId[56824] = aoeCounter+1 -- Puncturing Sweep (House Dres Templar)
CC.aoeTypesId[54161] = aoeCounter+1 -- Berserker Frenzy (House Dres Slaver)
CC.aoeTypesId[54080] = aoeCounter+1 -- Cinder Storm (Earthen Heart Knight)
CC.aoeTypesId[54084] = aoeCounter+1 -- Corrosive Armor (Earthen Heart Knight)
CC.aoeTypesId[52903] = aoeCounter+1 -- Standard of Might (Anal'a Tu'wha0)
CC.aoeTypesId[52892] = aoeCounter+1 -- Flames of Oblivion (Anal'a Tu'wha)
CC.aoeTypesId[83468] = aoeCounter+1 -- Restoring Nature (Nature's Blessing)
CC.aoeTypesId[52933] = aoeCounter+1 -- Solar Disturbance (Shadow Knight)
CC.aoeTypesId[25213] = aoeCounter+1 -- whirlwind Function (Dwarven Fire Centurion)
CC.aoeTypesId[55981] = aoeCounter+1 -- Ice Charge (Dwarven Ice Centurion)
CC.aoeTypesId[55086] = aoeCounter+1 -- Poison Mist (Vampire Lord Thisa)
CC.aoeTypesId[55092] = aoeCounter+1 -- Devouring Swarm (Vampire Lord Thisa)
CC.aoeTypesId[55104] = aoeCounter+1 -- Marked for Death (Hiath the Battlemaster)
CC.aoeTypesId[55182] = aoeCounter+1 -- Marked for Death (Hiath the Battlemaster)

-- Maelstrom Arena
CC.aoeTypesId[68197] = aoeCounter+1 -- Necrotic Essence (Necrotic Orb)
CC.aoeTypesId[70901] = aoeCounter+1 -- Defiled Grave (Maxus the Many) -- NORMAL
CC.aoeTypesId[72149] = aoeCounter+1 -- Defiled Grave (Maxus the Many) -- VETERAN
CC.aoeTypesId[69101] = aoeCounter+1 -- Shock (Generator)
CC.aoeTypesId[66797] = aoeCounter+1 -- Spinning Blade (Blade Trap)
CC.aoeTypesId[69366] = aoeCounter+1 -- Barrage Function (Centurion Champion)
CC.aoeTypesId[69316] = aoeCounter+1 -- Electric Shield (Centurion Champion)
CC.aoeTypesId[67871] = aoeCounter+1 -- Shock (Water)
CC.aoeTypesId[73880] = aoeCounter+1 -- Call Lightning (Lamia Queen)
CC.aoeTypesId[67758] = aoeCounter+1 -- Queen's Poison (Lamia Queen)
CC.aoeTypesId[72159] = aoeCounter+1 -- Static Field (Dwarven Spider)
CC.aoeTypesId[68537] = aoeCounter+1 -- Overcharged Bolt (The Control Guardian)
CC.aoeTypesId[70860] = aoeCounter+1 -- Overheated Flame (The Control Guardian)
CC.aoeTypesId[68543] = aoeCounter+1 -- Overheated Volley (The Control Guardian)
CC.aoeTypesId[72203] = aoeCounter+1 -- Overcharge (Scavenger Thunder-Smith)
CC.aoeTypesId[72525] = aoeCounter+1 -- Frigid Waters (Player)
CC.aoeTypesId[67808] = aoeCounter+1 -- Frigid Waters (Player)

--------------------
-- Dungeons
--------------------

-- Banished Cells I
CC.aoeTypesId[19027] = aoeCounter+1 -- Dead Zone (Skeletal Destroyer)
CC.aoeTypesId[33188] = aoeCounter+1 -- Daedric Tempest (High Kinlord Rilis)

-- Banished Cells II
CC.aoeTypesId[28904] = aoeCounter+1 -- Immolating Bite (Maw of the Infernal)
CC.aoeTypesId[29020] = aoeCounter+1 -- Berserker Frenzy (Keeper Voranil)
CC.aoeTypesId[31727] = aoeCounter+1 -- Corruption (Keeper Imiril)
CC.aoeTypesId[48800] = aoeCounter+1 -- Daedric Tempest (High Kinlord Rilis)
CC.aoeTypesId[48815] = aoeCounter+1 -- Daedric Tempest (High Kinlord Rilis)

-- Elden Hollow I
CC.aoeTypesId[16017] = aoeCounter+1 -- Berserker Frenzy (Akasha gra-Mal)
CC.aoeTypesId[25300] = aoeCounter -- Berserker Frenzy (Akasha gra-Mal)
CC.aoeTypesId[25301] = aoeCounter -- Berserker Frenzy (Akasha gra-Mal)
CC.aoeTypesId[25302] = aoeCounter -- Berserker Frenzy (Akasha gra-Mal)
CC.aoeTypesId[42601] = aoeCounter -- Necrotic Circle (Canonreeve Oraneth)

-- Elden Hollow II
CC.aoeTypesId[34377] = aoeCounter+1 -- Flame Geyser (Dubroze the Infestor)
CC.aoeTypesId[32972] = aoeCounter+1 -- Consuming Shadow (Murklight)
CC.aoeTypesId[33050] = aoeCounter+1 -- Eclipse (Murklight)
CC.aoeTypesId[33103] = aoeCounter+1 -- Spout Shadow (The Shadow Guard)
CC.aoeTypesId[33434] = aoeCounter+1 -- Daedric Flame (Bogdan the Nightflame)

-- City of Ash I
CC.aoeTypesId[34960] = aoeCounter+1 -- Blazing Fire (Warden of the Shrine)
CC.aoeTypesId[35145] = aoeCounter+1 -- Consuming Fire (Infernal Guardian)
CC.aoeTypesId[34204] = aoeCounter+1 -- Burning Field (Rothariel Flameheart)

-- City of Ash II
CC.aoeTypesId[56415] = aoeCounter+1 -- Fire Runes (Urata the Legion)
CC.aoeTypesId[55314] = aoeCounter+1 -- Slag Breath (Horvantud the Fire Maw)
CC.aoeTypesId[55334] = aoeCounter+1 -- Fiery Breath (Horvantud the Fire Maw)
CC.aoeTypesId[55321] = aoeCounter+1 -- Fiery Breath (Horvantud the Fire Maw)
CC.aoeTypesId[55336] = aoeCounter+1 -- Fiery Breath (Horvantud the Fire Maw)
CC.aoeTypesId[55327] = aoeCounter+1 -- Fiery Breath (Horvantud the Fire Maw)
CC.aoeTypesId[55338] = aoeCounter+1 -- Fiery Breath (Horvantud the Fire Maw)
CC.aoeTypesId[56010] = aoeCounter+1 -- Ground Quake (Horvantud the Fire Maw)
CC.aoeTypesId[56151] = aoeCounter+1 -- Ethereal Flame (Ash Titan)
CC.aoeTypesId[55175] = aoeCounter+1 -- Molten Rain (Ash Titan)
CC.aoeTypesId[54637] = aoeCounter+1 -- Flame Tornado (Air Atronach)
CC.aoeTypesId[56068] = aoeCounter+1 -- Slag Geyser (Lava Pool)
CC.aoeTypesId[55756] = aoeCounter+1 -- Burning (Valkyn Skoria)

-- Tempest Island
CC.aoeTypesId[26619] = aoeCounter+1 -- Shock (Sudden Storm)
CC.aoeTypesId[6108] = aoeCounter+1 -- Lightning Storm (Yalorasse the Speaker)
CC.aoeTypesId[26752] = aoeCounter+1 -- Enervating Stone (Stormfist)
CC.aoeTypesId[26517] = aoeCounter+1 -- Electrical Shock (Twister)

-- Selene's Web
CC.aoeTypesId[30908] = aoeCounter+1 -- Summon Primal Swarm (Treethane Kerninn)
CC.aoeTypesId[30773] = aoeCounter+1 -- Arrow Rain (Longclaw)
CC.aoeTypesId[31150] = aoeCounter+1 -- Poison Burst (Longclaw)
CC.aoeTypesId[31203] = aoeCounter+1 -- Venomous Burst (Queen Aklayah)

-- Spindleclutch II
CC.aoeTypesId[28006] = aoeCounter+1 -- Cave In (Blood Spawn)
CC.aoeTypesId[47332] = aoeCounter+1 -- Cave-In (Blood Spawn)
CC.aoeTypesId[27603] = aoeCounter+1 -- Blood Pool (Urvan Veleth)
CC.aoeTypesId[27906] = aoeCounter+1 -- Blood Pool (Vorenor Winterbourne)

-- Wayrest Sewers I
CC.aoeTypesId[25591] = aoeCounter+1 -- Necrotic Essence (Investigator Garron)

-- List of effects sourced by the player that damage self that should be shown
CC.LavaAlerts = {
    -- Player
    [115607] = true, -- Dismount Stun

    -- Consumables
    [68565] = true, -- Stun (Potion of Stun)

    -- Battlegrounds
    [87949] = true, -- Lava (Foyada Quarry)

    -- Traps & World
    [44034] = true, -- Slaughterfish Attack (Stirk)
    [113082] = true, -- Slaughterfish Attack (Cyrodiil)
    [19224] = true, -- In Lava (Halls of Torment)
    [11338] = true, -- In Lava (The Earth Forge)
    [56277] = true, -- Lava (City of Ash II)
	[5140] = true, -- Lava (Dragonstar Arena)

    [17314] = true, -- Fire Trap (Player)

    -- Quests
    [14974] = true, -- CON_Knockback&Knockdown (Anchors from the Harbour)
    [31502] = true, -- MGQ2 Asakala Sahdina Barrier (Simply Misplaced)
    [31503] = true, -- MGQ2 Asakala Rashomta Barrier (Simply Misplaced)
    [21876] = true, -- Q4260 West Barrier Teleport (Breaking the Barrier)
    [21878] = true, -- Q4260 East Barrier Teleport (Breaking the Barrier)
    [22395] = true, -- Q4261 ROD Barrier Teleport (Sever All Ties)
    [23606] = true, -- Q4326 Crystal Backfire (Preventative Measure)
    [37438] = true, -- Shocked (The Grips of Madness)
    [36766] = true, -- Q4842 Stun Headgrab Knockback (The Unquiet Dead)

	--------------
    -- Arenas ----
    --------------

    -- Dragonstar Arena
    [53341] = true, -- Biting Cold (Player)
    [60421] = true, -- Biting Cold (Player)
	[54405] = true, -- Celestial Blast (Player)

	-- Maelstrom Arena
	[72525] = true, -- Frigid Waters (Player)
	[67808] = true, -- Frigid Waters (Player)

    --------------
    -- Dungeons --
    --------------

    -- Elden Hollow II
    [30455] = true, -- Arachnophobia (The Opus of Torment)

    -- City of Ash I
    [70113] = true, -- Soul Scream (Scroll of Glorious Battle)

    -- City of Ash II
    [56563] = true, -- Book (Frigid Tome)

    -- Selene's Web
    [58521] = true, -- Web (Selene)
}

-- List of CC that can't be removed with Break Free
CC.UnbreakableList ={
    -- Player
    [115607] = true, -- Dismount Stun
    [40520] = true, -- Q3047 - Knockdown (Player Werewolf Bite stun)

    -- Quests
    [14972] = true, -- CON_Knockback&Knockdown (Castle of the Worm)
    [14974] = true, -- CON_Knockback&Knockdown (Anchors from the Harbour)
    [25979] = true, -- FG4 RGT Event Knockback (Proving the Deed)
    [31502] = true, -- MGQ2 Asakala Sahdina Barrier (Simply Misplaced)
    [31503] = true, -- MGQ2 Asakala Rashomta Barrier (Simply Misplaced)
    [32063] = true, -- Feedback (Tears of the Two Moons)
    [21876] = true, -- Q4260 West Barrier Teleport (Breaking the Barrier)
    [21878] = true, -- Q4260 East Barrier Teleport (Breaking the Barrier)
    [22395] = true, -- Q4261 ROD Barrier Teleport (Sever All Ties)
    [28771] = true, -- Q4220 Thirster Stun (The Mallari-Mora)
    [21314] = true, -- Trap Sprung! (An Act of Kindness)
    [23606] = true, -- Q4326 Crystal Backfire (Preventative Measure)
    [37438] = true, -- Shocked (The Grips of Madness)
    [43823] = true, -- IntroKB (The Orrery of Elden Root)
    [36766] = true, -- Q4842 Stun Headgrab Knockback (The Unquiet Dead)
    [33384] = true, -- Q4586 Aranias Vine Stun (The Witch of Silatar)

	-----------------
    -- ARENAS
    -----------------

	-- Dragonstar Arena
	[54405] = true, -- Celestial Blast (Player)

	-- Maelstrom Arena
	[71720] = true, -- Stun (Matriarch Runa)

    -----------------
    -- DUNGEONS
    -----------------

    -- Banished Cells II
    [33191] = true, -- Crushing Blow (High Kinlord Rilis)
    [18847] = true, -- Soul Blast (High Kinlord Rilis)

    -- Banished Cells II
    [35680] = true, -- Immolating Bite (Maw of the Infernal)
    [28772] = true, -- Stun (High Kinlord Rilis)
    [28774] = true, -- Stun (High Kinlord Rilis)

    -- Elden Hollow I
    [46800] = true, -- Necrotic Circle (Canonreeve Oraneth)
    [27890] = true, -- Darkness Below (Elden Hollow)

    -- Elden Hollow II
    [35372] = true, -- Emerge (Bogdan the Nightflame)
    [30455] = true, -- Arachnophobia (The Opus of Torment)

    -- City of Ash I
    [25036] = true, -- Crushing Blow (Golor the Banekin Handler)
    [34609] = true, -- Measured Uppercut (Warden of the Shrine)
    [49138] = true, -- Oblivion Portal

    -- City of Ash II
    [54768] = true, -- Backdraft (Ash Titan - Theater)
    [54224] = true, -- Monstrous Cleave (Ash Titan)
    [54873] = true, -- Heavy Slash (Ash Titan)
    [55575] = true, -- Meteor Strike (Valkyn Skoria)
    [55391] = true, -- Meteor Strike (Valkyn Skoria)
    [56563] = true, -- Book (Frigid Tome)
    [70113] = true, -- Soul Scream (Scroll of Glorious Battle)

    -- Tempest Island
    [26676] = true, -- IntroKB (Valaran Stormcaller)
    [26372] = true, -- Crushing Blow (Valaran Stormcaller)
    [28391] = true, -- Q4538 Stoen Explosion (Conduit Stone)
    [26716] = true, -- Skyward Slam (Stormfist)
    [26851] = true, -- Summon Storm Atronach (Stormfist)
    [26836] = true, -- Summon Storm Atronach (Stormfist)
    [46809] = true, -- Gust of Wind (Stormreeve Neider)

    -- Selene's Web
    [31247] = true, -- Ensnare (Treethane Kerninn)
    [58521] = true, -- Web (Selene)
    [30969] = true, -- Summon Primal Spirit (Selene)
    [30905] = true, -- IntroKB (Selene)

    -- Spindleclutch I
    [22087] = true, -- Inject Poison (Swarm Mother)
    [18116] = true, -- Arachnophobia (The Whisperer)
    [46219] = true, -- Web Blast (The Whisperer)
    [22033] = true, -- Daedric Explosion (The Whisperer)

    -- Spindleclutch II
    [47140] = true, -- Knockdown (Bloodspawn)
    [61442] = true, -- Harrowing Ring (Praxin Douare)
    [43176] = true, -- Shocked (Praxin Douare)
    [61444] = true, -- Shocked (Praxin Douare)
    [32100] = true, -- Arachnophobia (Vorenor Winterbourne)

	-- Wayrest Sewers I
	[48932] = true, -- Backlash (Investigator Garron)
	[25531] = true, -- Tidal Slash (Varaine Pellingare)
	[35051] = true, -- Penetrating Daggers (Allene Pellingare)

    -- Frostvault
    [116666] = true, -- Skeletal Smash (Icestalker) -- Frostvault
    [109835] = true, -- Frenzied Pummeling (Icestalker) -- Frostvault

    -- TODO: Resort/check later
    [88467] = true, -- Skyfall (Vvardenfell -- Divine Disaster)
    [89756] = true, -- Guardian Shockwave (Vvardenfell -- The Magister Makes a Move)
    [92671] = true, -- Pyroclast (Vvardenfell -- The Forgotten Wastes)
}

CC.IgnoreList ={
    [54363] = true, -- Halt (Guard)
    [4197] = true, -- Recovering (NPC Duel)

    -- Quests

    -- Vampire
    [44670] = true, -- Vamp Theater Head Grab Stun (Scion of the Blood Matron)

    -- MSQ
    [64072] = true, -- Eye of the Sentinel (Tutorial)
    [61646] = true, -- Incapacitating Terror (Tutorial)
    [28737] = true, -- Recovery (Manifestation of Terror)
    [48077] = true, -- Q4971 Shali Cast (Saved)
    [32060] = true, -- Shocked (Tears of the Two Moons)
    [38108] = true, -- Q4868 Sheo Teleports Player (The Grips of Madness)
    [35645] = true, -- Q4768 PC Tribunal Layer 2 Stun (Scars Never Fade)

	----------------
	-- Arenas
	----------------

    -- Dragonstar Arena
	[55221] = true, -- Sucked Under (Player)
	[55641] = true, -- Stun (Light of Boethia)

    ----------------
    -- Dungeons
    ----------------

    -- Banished Cells II
    [46433] = true, -- DUN_BCH_Knockback&Knockdown (High Kinlord Rilis)

    -- Elden Hollow I
    [25723] = true, -- CON_Knockback&Knockdown (Bakkhara)

    -- City of Ash II
    [55429] = true, -- Magma Prison (Valkyn Skoria)

    -- Tempest Island
    [26938] = true, -- Enervating Stone (Stormfist)

    -- Frostvault
    [109838] = true, -- End Stun (Icestalker) -- Frostvault
    [119461] = true, -- Teleport Failsafe (Border Chk) -- Frostvault
}

-- Not implemented - list of abilities that ACTION_RESULT_GAINED_DURATION fires in the opposite order of normal
CC.ReversedLogic = {
    [39260] = true, -- Q4917 Push Player Back (Grahtwood - The Blacksap's Hold)
    [83124] = true, -- Ferocious Bellow (Greenshade - World Boss - Thodundor's View)

    -- Dungeons
    [26716] = true, -- Skyward Slam (Stormfist) -- Tempest Island
}

-- Use on ACTION_RESULT_EFFECT_GAINED
CC.SpecialCC = {
    [55756] = true, -- Burning (Valkyn Skoria)
}
