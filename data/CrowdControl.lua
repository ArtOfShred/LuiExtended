--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Effects namespace
LUIE.Data.CrowdControl = {}
local CrowdControl = LUIE.Data.CrowdControl

-- CrowdControl.aoePlayerUltimate
-- CrowdControl.aoePlayerNormal
-- CrowdControl.aoePlayerSet
-- CrowdControl.aoeTrap
-- cc.aoeBoss
-- CrowdControl.aoeElite
-- CrowdControl.aoeNormal
CrowdControl.aoePlayerUltimate = {

    -- Dragonknight
    [28995] = true, -- Dragonknight Standard
    [32960] = true, -- Shifting Standard
    [32964] = true, -- Shifting Standard
    [32948] = true, -- Standard of Might

    -- Warden
    [86247] = true, -- Sleet Storm (Sleet Storm)
    [88860] = true, -- Northern Storm (Northern Storm)
    [88863] = true, -- Permafrost (Permafrost)

    -- Templar
    [21753] = true, -- Nova
    [21756] = true, -- Solar Prison
    [21759] = true, -- Solar Disturbance

    -- Nightblade
    [36490] = true, -- Veil of Blades (Veil of Blades)

    -- Necromancer
    [122178] = true, -- Frozen Colossus (Frozen Colossus)
    [122399] = true, -- Pestilent Colossus (Pestilent Colossus)
    [122400] = true, -- Pestilent Colossus (Pestilent Colossus)
    [122401] = true, -- Pestilent Colossus (Pestilent Colossus)
    [122392] = true, -- Glacial Colossus (Glacial Colossus)
    [118289] = true, -- Ravenous Goliath (Ravenous Goliath)

    -- Destruction Staff
    [85127] = true, --Fiery Rage
    [85131] = true, --Thunderous Rage
    [85129] = true, --Icy Rage
    [83683] = true, --Eye of Flame
    [83687] = true, --Eye of Lightning
    [83685] = true, --Eye of Frost
    [83626] = true, --Fire Storm
    [83631] = true, --Thunder Storm
    [83629] = true, --Ice Storm

    -- Mages Guild
    [63429] = true, -- Meteor
    [63454] = true, -- Ice Comet
    [63471] = true, -- Shooting Star

    -- Vampire
    [32625] = true, -- Bat Swarm
    [38935] = true, -- Clouding Swarm
    [38934] = true, -- Devouring Swarm

    -- Volendrung
    [116669] = true, -- Ebony Cyclone (Ruinous Cyclone)

}

CrowdControl.aoePlayerNormal = {

    -- Psijic Order
    [104007] = true, -- Time Stop
    [104072] = true, -- Borrowed Time
    [104082] = true, -- Time Freeze

    -- Dragonknight
    [32711] = true, -- Eruption (Eruption)

    -- Warden
    [88783] = true, -- Impaling Shards (Impaling Shards)
    [88791] = true, -- Gripping Shards (Gripping Shards)
    [88802] = true, -- Winter's Revenge (Winter's Revenge)

    -- Templar
    [26192] = true, -- Spear Shards
    [95931] = true, -- Spear Shards
    [26859] = true, -- Luminous Shards
    [95955] = true, -- Luminous Shards
    [26871] = true, -- Blazing Spear
    [26879] = true, -- Blazing Spear
    [80172] = true, -- Ritual of Retribution (Ritual of Retribution)

    -- Sorcerer
    [23189] = true, -- Lightning Splash (Lightning Splash)
    [23202] = true, -- Liquid Lightning (Liquid Lightning)
    [23208] = true, -- Lightning Flood (Lightning Flood)
    [80435] = true, -- Suppression Field (Suppression Field)

    -- Nightblade
    [36052] = true, -- Twisting Path (Twisting Path)

    -- Necromancer
    [115254] = true, -- Boneyard (Boneyard)
    [117809] = true, -- Unnerving Boneyard (Unnerving Boneyard)
    [117854] = true, -- Avid Boneyard (Avid Boneyard)

    [116410] = true, -- Shocking Siphon (Shocking Siphon)
    [118766] = true, -- Detonating Siphon (Detonating Siphon)
    [118011] = true, -- Mystic Siphon (Mystic Siphon)

    -- Destruction Staff
    [62896] = true, -- Wall of Fire
    [62971] = true, -- Wall of Storms
    [62931] = true, -- Wall of Frost
    [39054] = true, -- Unstable Wall of Fire
    [39079] = true, -- Unstable Wall of Storms
    [39071] = true, -- Unstable Wall of Frost
    [62912] = true, -- Blockade of Fire
    [62990] = true, -- Blockade of Storms
    [62951] = true, -- Blockade of Frost

    -- Bow
    [28877] = true, -- Volley
    [38690] = true, -- Endless Hail
    [38696] = true, -- Arrow Barrage

    -- Assault
    [38561] = true, -- Caltrops (Caltrops)
    [40267] = true, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40252] = true, -- Razor Caltrops (Razor Caltrops)

}

CrowdControl.aoePlayerSet = {

    -- Sets
    [102136] = true, -- Zaan
    [59568] = true, -- Malubeth
    [80522] = true, -- Stormfist
    [59498] = true, -- Mephala's Web (Spawm of Mephala)
    [60972] = true, -- Fiery Breath (Maw of the Infernal)
    [80525] = true, -- Ilambris
    [80526] = true, -- Ilambris
    [84502] = true, -- Grothdarr
    [80561] = true, -- Iceheart
    [97883] = true, -- Domihaus
    [97899] = true, -- Domihaus
    [80565] = true, -- Kra'gh
    [106783] = true, -- Dustcloud Damage (Adept Rider's)
    [75692] = true, -- Bahraha's Curse (of Bahraha's Curse)
    [57209] = true, -- Storm Knight's Plate (of the Storm Knight)
    [59696] = true, -- Embershield (Embershield)
    [67204] = true, -- Leeching Plate (of Leeching)
    [102094] = true, -- Thurvokun (Thurvokun)
    [116920] = true, -- Auroran's Thunder (Auroran's Thunder)

    -- Siege
    [104693] = true, -- Meatbag Catapult
    [104695] = true, -- Scattershot Catapult

}

CrowdControl.aoeTraps = {

    -- TODO: Will need to add better categories here eventually
    [87949] = true, -- Lava (Foyada Quarry)
    [44034] = true, -- Slaughterfish Attack (Stirk)
    [113082] = true, -- Slaughterfish Attack (Cyrodiil)
    [19224] = true, -- In Lava (Halls of Torment)
    [11338] = true, -- In Lava (The Earth Forge)
    [16589] = true, -- Fire (Dummy ID for zone based name override) -- TODO: Maybe do something here
    [56277] = true, -- Lava (City of Ash II)
    [5140] = true, -- Lava (Dragonstar Arena)

    [62770] = true, -- Coldharbour Flames (Flame Trap) - Coldharbour Tutorial
    [21943] = true, -- Spike Trap (Spike Trap)
    [53169] = true, -- Spike Trap (Spike Trap) - Dragonstar Arena
    [26531] = true, -- Bear Trap (Bear Trap)
    [31086] = true, -- Trap (Trap) - Selene's Web

    [17314] = true, -- Fire Trap (Player)
    [72888] = true, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = true, -- Fire Attack 2 (Fire) -- Banished Cells II

    [92757] = true, -- Spinning Blade (Ald Carac)

    [117508] = true, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117622] = true, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117598] = true, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117139] = true, -- Spinning Blade (Blade Trap - Elinhir Private Arena)

    [92150] = true, -- Fire Trap (Vvardenfell -- Divine Delusions)
    [87102] = true, -- Spinning Blade (Vvardenfell -- Divine Restoration)
    [92284] = true, -- Planar Shear (Vvardenfell -- Divine Restoration)
    [86743] = true, -- Accelerated Transposition (Vvardenfell -- Like Blood from a Stone)
    [84527] = true, -- Searing Steam (Vvardenfell - Nchuleftingth)
    [90271] = true, -- Charge-Wire Shock (Vvardenfell - Nchuleftingth)
    [92138] = true, -- Laser Damage (Vvardenfell - Nchuleftingth)

    -- Dragonstar Arena
    [53341] = true, -- Biting Cold (Player)
    [60421] = true, -- Biting Cold (Player)
    [83498] = true, -- Poisonous Cloud (Poison Cloud)
    [83468] = true, -- Restoring Nature (Nature's Blessing)

    -- Maelstrom Arena
    [69101] = true, -- Shock (Generator)
    [66797] = true, -- Spinning Blade (Blade Trap)
    [67871] = true, -- Shock (Water)
    [72525] = true, -- Frigid Waters (Player)
    [67808] = true, -- Frigid Waters (Player)

    -- City of Ash II
    [56068] = true, -- Slag Geyser (Lava Pool)

}

CrowdControl.aoeNPCBoss = {

    -- Summerset
    [105889] = true, -- Pustulant Eruption (Yaghra Nightmare)

    -- Vvardenfell
    [94936] = true, -- Tremor (Nchuleftingth - Mud-Tusk)
    [86566] = true, -- Fire Runes (Nchuleftingth - Friar Hadelar)
    [89754] = true, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [90148] = true, -- Sunder's Echo (Vvardenfell -- Divine Intervention)
    [90146] = true, -- Sunder's Echo (Vvardenfell -- Divine Intervention)
    [69284] = true, -- Whirlwind Function (Guardian of Bthark -- Nchuleftingth)
    [86607] = true, -- Steam Breath (Guardian of Bthark -- Nchuleftingth)

    -- World Bosses
    [84045] = true, -- Seal of Defilement (Quenyas) - World Boss - Seaside Scarp Camp
    [84206] = true, -- Stinging Sputum (Gathongor the Mauler) - World Boss - Gathongor's Mine

    -- Quests
    [36860] = true, -- Swordstorm Damage (MSQ - Halls of Torment)
    [87959] = true, -- Ash Storm (Vvardenfell -- Divine Delusions)

    -- Dragonstar Arena
    [53660] = true, -- Power Overload Heavy Attack (Nak'tah)
    [54084] = true, -- Corrosive Armor (Earthen Heart Knight)
    [52903] = true, -- Standard of Might (Anal'a Tu'wha0)
    [52933] = true, -- Solar Disturbance (Shadow Knight)
    [55086] = true, -- Poison Mist (Vampire Lord Thisa)
    [55092] = true, -- Devouring Swarm (Vampire Lord Thisa)
    [55104] = true, -- Marked for Death (Hiath the Battlemaster)
    [55182] = true, -- Marked for Death (Hiath the Battlemaster)

    -- Maelstrom Arena
    [68197] = true, -- Necrotic Essence (Necrotic Orb)
    [70901] = true, -- Defiled Grave (Maxus the Many) -- NORMAL
    [72149] = true, -- Defiled Grave (Maxus the Many) -- VETERAN
    [69366] = true, -- Barrage Function (Centurion Champion)
    [69316] = true, -- Electric Shield (Centurion Champion)
    [73880] = true, -- Call Lightning (Lamia Queen)
    [67758] = true, -- Queen's Poison (Lamia Queen)
    [68537] = true, -- Overcharged Bolt (The Control Guardian)
    [70860] = true, -- Overheated Flame (The Control Guardian)
    [68543] = true, -- Overheated Volley (The Control Guardian)

    -- Banished Cells I
    [19027] = true, -- Dead Zone (Skeletal Destroyer)
    [33188] = true, -- Daedric Tempest (High Kinlord Rilis)

    -- Banished Cells II
    [28904] = true, -- Immolating Bite (Maw of the Infernal)
    [29020] = true, -- Berserker Frenzy (Keeper Voranil)
    [31727] = true, -- Corruption (Keeper Imiril)
    [48800] = true, -- Daedric Tempest (High Kinlord Rilis)
    [48815] = true, -- Daedric Tempest (High Kinlord Rilis)

    -- Elden Hollow I
    [16017] = true, -- Berserker Frenzy (Akasha gra-Mal)
    [25300] = true, -- Berserker Frenzy (Akasha gra-Mal)
    [25301] = true, -- Berserker Frenzy (Akasha gra-Mal)
    [25302] = true, -- Berserker Frenzy (Akasha gra-Mal)
    [42601] = true, -- Necrotic Circle (Canonreeve Oraneth)

    -- Elden Hollow II
    [34377] = true, -- Flame Geyser (Dubroze the Infestor)
    [32972] = true, -- Consuming Shadow (Murklight)
    [33050] = true, -- Eclipse (Murklight)
    [33103] = true, -- Spout Shadow (The Shadow Guard)
    [33434] = true, -- Daedric Flame (Bogdan the Nightflame)

    -- City of Ash I
    [34960] = true, -- Blazing Fire (Warden of the Shrine)
    [35145] = true, -- Consuming Fire (Infernal Guardian)
    [34204] = true, -- Burning Field (Rothariel Flameheart)

    -- City of Ash II
    [56415] = true, -- Fire Runes (Urata the Legion)
    [55314] = true, -- Slag Breath (Horvantud the Fire Maw)
    [55334] = true, -- Fiery Breath (Horvantud the Fire Maw)
    [55321] = true, -- Fiery Breath (Horvantud the Fire Maw)
    [55336] = true, -- Fiery Breath (Horvantud the Fire Maw)
    [55327] = true, -- Fiery Breath (Horvantud the Fire Maw)
    [55338] = true, -- Fiery Breath (Horvantud the Fire Maw)
    [56010] = true, -- Ground Quake (Horvantud the Fire Maw)
    [56151] = true, -- Ethereal Flame (Ash Titan)
    [55175] = true, -- Molten Rain (Ash Titan)
    [54637] = true, -- Flame Tornado (Air Atronach)
    [55756] = true, -- Burning (Valkyn Skoria)

    -- Tempest Island
    [26619] = true, -- Shock (Sudden Storm)
    [6108] = true, -- Lightning Storm (Yalorasse the Speaker)
    [26752] = true, -- Enervating Stone (Stormfist)
    [26517] = true, -- Electrical Shock (Twister)

    -- Selene's Web
    [30908] = true, -- Summon Primal Swarm (Treethane Kerninn)
    [30773] = true, -- Arrow Rain (Longclaw)
    [31150] = true, -- Poison Burst (Longclaw)
    [31203] = true, -- Venomous Burst (Queen Aklayah)

    -- Spindleclutch II
    [28006] = true, -- Cave In (Blood Spawn)
    [47332] = true, -- Cave-In (Blood Spawn)
    [27603] = true, -- Blood Pool (Urvan Veleth)
    [27906] = true, -- Blood Pool (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [25591] = true, -- Necrotic Essence (Investigator Garron)

}

CrowdControl.aoeNPCElite = {

    -- Overland / Standard NPC's
    [44228] = true, -- Dragonknight Standard (Dragonknight - Elite)
    [81197] = true, -- Agonizing Fury (Thundermaul - Boss)
    [21952] = true, -- Repulsion Shock (Wamasu)
    [55867] = true, -- Repulsion Shock (Wamasu - Boss)
    [72794] = true, -- Toxic Pool (Haj Mota)
    [53233] = true, -- Miasma Pool (Flesh Colossus)
    [52866] = true, -- Volley (Cyrodiil Archer)
    [54258] = true, -- Upgraded Volley (Cyrodiil Archer)
    [10271] = true, -- Quake (Gargoyle)
    [9011] = true, -- Tremor (Troll)
    [75928] = true, -- Elemental Pool (Minotaur)
    [75953] = true, -- Brimstone Hailfire (Minotaur Shaman)
    [75976] = true, -- Pillar of Nirn (Minotaur Shaman)
    [75980] = true, -- Pillar Eruption (Minotaur Shaman)
    [11282] = true, -- Steam Breath (Dwemer Centurion)

    -- Dragonstar Arena
    [53314] = true, -- Flame Volley (Sovngarde Ranger)
    [53280] = true, -- Unstable Wall of Frost (Sovngarde Icemage)
    [53614] = true, -- Thundering Presence (Nak'tah)
    [53625] = true, -- Lightning Flood (Nak'tah)
    [56824] = true, -- Puncturing Sweep (House Dres Templar)
    [54161] = true, -- Berserker Frenzy (House Dres Slaver)
    [54080] = true, -- Cinder Storm (Earthen Heart Knight)
    [52892] = true, -- Flames of Oblivion (Anal'a Tu'wha)
    [25213] = true, -- Whirlwind Function (Dwarven Fire Centurion)
    [55981] = true, -- Ice Charge (Dwarven Ice Centurion)

    -- Maelstrom Arena
    [72159] = true, -- Static Field (Dwarven Spider)
    [72203] = true, -- Overcharge (Scavenger Thunder-Smith)

}

CrowdControl.aoeNPCNormal = {

    [37131] = true, -- Ice Cage (Battlemage)
    [10813] = true, -- Ignite (Synergy - Fire Mage)
    [38260] = true, -- Ignite (Synergy - Fire Mage)
    [28629] = true, -- Volley (Archer)
    [47102] = true, -- Fire Rune (Fire Mage)
    [14068] = true, -- Ignite (Synergy - Archer)
    [70414] = true, -- Ignite (Synergy - Cyrodiil Archer)
    [38125] = true, -- Caltrops  (Faction NPCs)
    [76730] = true, -- Pool of Shadow (Voidbringer)
    [76624] = true, -- Pool of Shadow (Voidbringer)
    [76729] = true, -- Pool of Shadow (Voidbringer)
    [76728] = true, -- Pool of Shadow (Voidbringer)
    [88336] = true, -- Pool of Shadow (Skaafin Masquer)
    [88330] = true, -- Pool of Shadow (Skaafin Masquer)
    [88335] = true, -- Pool of Shadow (Skaafin Masquer)
    [88334] = true, -- Pool of Shadow (Skaafin Masquer)
    [84837] = true, -- Broken Pact (Skaafin)
    [62502] = true, -- Fiery Wind (Justice Mage)
    [46819] = true, -- Storm Damage (Cyrodiil Mage)
    [7883] = true, -- Guardian Storm (Cyrodiil Mage)
    [8604] = true, -- Vigorous Swipe (Mammoth)
    [27100] = true, -- Shocking Rake (Dreugh)
    [16698] = true, -- Poisonbloom (Netch)
    [90778] = true, -- Acid Pool (Nix-Ox)
    [90815] = true, -- Acid Pool (Nix-Ox)
    [85421] = true, -- Retch (Cliff Strider)
    [85391] = true, -- Slash (Cliff Strider)
    [13680] = true, -- Acid Blood (Assassin Beetle)
    [10947] = true, -- Fiery Breath (Shalk)
    [5265] = true, -- Burning Ground (Shalk)
    [8088] = true, -- Poison Spray (Giant Spider)
    [87126] = true, -- Heat Vents (Fetcherfly Nest)
    [51282] = true, -- Flame Tornado (Air Atronach - Flame)
    [9749] = true, -- Envelop (Banekin)
    [73437] = true, -- Soul Flame (Daedric Titan)
    [4772] = true, -- Fiery Breath (Daedroth)
    [91938] = true, -- Burst of Embers (Daedroth)
    [51645] = true, -- Frozen Ground (Frost Atronach)
    [6162] = true, -- Rain of Fire (Scamp)
    [88323] = true, -- Blast Furnace (Iron Atronach)
    [69950] = true, -- Desecrated Ground (Undead Synergy)
    [73937] = true, -- Soul Cage (Lich)
    [73929] = true, -- Soul Cage (Lich)
    [20812] = true, -- Defiled Ground (Lich)
    [72996] = true, -- Symphony of Blades (Defiled Aegis)
    [8628] = true, -- Charged Ground (Harpy)
    [4769] = true, -- Choking Pollen (Lurcher)
    [16040] = true, -- Hurricane (Nereid)
    [19997] = true, -- Static Field (Dwemer Spider - Synergy)
    [91094] = true, -- Split Bolt (Dwemer Arquebus)
    [91095] = true, -- Split Bolt (Dwemer Arquebus)
    [91096] = true, -- Split Bolt (Dwemer Arquebus)
    [103862] = true, -- Deluge (Yaghra Spewer)
    [103992] = true, -- Luminescent Burn (Yaghra Spewer)

    -- Quests
    [90182] = true, -- Oily Smoke (Vvardenfell -- Divine Restoration) -- TODO: Check, maybe is elite?

}


-- List of effects sourced by the player that damage self that should be shown
CrowdControl.LavaAlerts = {
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
CrowdControl.UnbreakableList ={
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

CrowdControl.IgnoreList ={
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
CrowdControl.ReversedLogic = {
    [39260] = true, -- Q4917 Push Player Back (Grahtwood - The Blacksap's Hold)
    [83124] = true, -- Ferocious Bellow (Greenshade - World Boss - Thodundor's View)

    -- Dungeons
    [26716] = true, -- Skyward Slam (Stormfist) -- Tempest Island
}

-- Use on ACTION_RESULT_EFFECT_GAINED
CrowdControl.SpecialCC = {
    [55756] = true, -- Burning (Valkyn Skoria)
}
