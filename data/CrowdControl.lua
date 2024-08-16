--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

local CrowdControl = LUIE.Data.CrowdControl

-- CrowdControl.aoePlayerUltimate
-- CrowdControl.aoePlayerNormal
-- CrowdControl.aoePlayerSet
-- CrowdControl.aoeTrap
-- cc.aoeBoss
-- CrowdControl.aoeElite
-- CrowdControl.aoeNormal
-- Increment by 1 here if we want to change priority. Best way to do this is +1 for a new ability, and shared morphs or other damage sources from a shared attack don't increment.
-- Priority system doesn't support gaps so NEVER more than +1 here, also the FIRST ability in each tier needs to be +0 to prevent skips if a category is disabled in the options.
CrowdControl.aoePlayerUltimate =
{

    -- Dragonknight
    [28995] = 0, -- Dragonknight Standard
    [32960] = 0, -- Shifting Standard
    [32964] = 0, -- Shifting Standard
    [32948] = 0, -- Standard of Might

    -- Warden
    [86247] = 1, -- Sleet Storm (Sleet Storm)
    [88860] = 0, -- Northern Storm (Northern Storm)
    [88863] = 0, -- Permafrost (Permafrost)

    -- Templar
    [21753] = 1, -- Nova
    [21756] = 0, -- Solar Prison
    [21759] = 0, -- Solar Disturbance

    -- Nightblade
    [36490] = 1, -- Veil of Blades (Veil of Blades)

    -- Necromancer
    [122178] = 1, -- Frozen Colossus (Frozen Colossus)
    [122399] = 0, -- Pestilent Colossus (Pestilent Colossus)
    [122400] = 0, -- Pestilent Colossus (Pestilent Colossus)
    [122401] = 0, -- Pestilent Colossus (Pestilent Colossus)
    [122392] = 0, -- Glacial Colossus (Glacial Colossus)
    [118289] = 1, -- Ravenous Goliath (Ravenous Goliath)

    -- Sorcerer
    [80435] = 1, -- Suppression Field (Suppression Field)

    -- Arcanist
    [189793] = 1, -- The Unblinking Eye (The Unblinking Eye)
    [189839] = 0, -- The Tide King's Gaze (The Tide King's Gaze)
    [189837] = 0, -- The Tide King's Gaze (The Tide King's Gaze)?
    [191367] = 0, -- The Tide King's Gaze (The Tide King's Gaze)?
    [189869] = 1, -- The Languid Eye (The Languid Eye)
    [191889] = 1, -- The Languid Eye (The Languid Eye, Duration?)

    -- Destruction Staff
    [85127] = 1, --Fiery Rage
    [85131] = 0, --Thunderous Rage
    [85129] = 0, --Icy Rage
    [83683] = 1, --Eye of Flame
    [83687] = 0, --Eye of Lightning
    [83685] = 0, --Eye of Frost
    [83626] = 1, --Fire Storm
    [83631] = 0, --Thunder Storm
    [83629] = 0, --Ice Storm

    -- Mages Guild
    [63429] = 1, -- Meteor
    [63454] = 0, -- Ice Comet
    [63471] = 0, -- Shooting Star

    -- Vampire
    [38935] = 1, -- Swarming Scion

    -- Volendrung
    [116669] = 1, -- Ebony Cyclone (Ruinous Cyclone)
}

CrowdControl.aoePlayerNormal =
{

    -- Psijic Order
    [104007] = 0, -- Time Stop
    [104072] = 0, -- Borrowed Time
    [104082] = 0, -- Time Freeze

    -- Dragonknight
    [32711] = 1, -- Eruption (Eruption)

    -- Warden
    [220630] = 1, -- Warden's Burst (Warden Scribing Class Charm Initial Cast)
    [220639] = 0, -- Warden's Burst (Warden Scribing Class Charm Initial Cast)

    [221173] = 1, -- Warden's Contingency (Warden Scribing Class Charm Initial Cast)
    [221174] = 0, -- Warden's Contingency (Warden Scribing Class Charm Initial Cast)

    --[130406] = 0, -- Arctic Blast (Arctic Blast)
    [88783] = 1, -- Impaling Shards (Impaling Shards)
    [88791] = 0, -- Gripping Shards (Gripping Shards)
    [88802] = 0, -- Winter's Revenge (Winter's Revenge)

    -- Templar
    [26192] = 1, -- Spear Shards
    [95931] = 0, -- Spear Shards
    [26859] = 0, -- Luminous Shards
    [95955] = 0, -- Luminous Shards
    [26871] = 0, -- Blazing Spear
    [26879] = 0, -- Blazing Spear
    [80172] = 1, -- Ritual of Retribution (Ritual of Retribution)

    -- Sorcerer
    [23189] = 1, -- Lightning Splash (Lightning Splash)
    [23202] = 0, -- Liquid Lightning (Liquid Lightning)
    [23208] = 0, -- Lightning Flood (Lightning Flood)

    -- Nightblade
    [36052] = 1, -- Twisting Path (Twisting Path)

    -- Necromancer
    [115254] = 1, -- Boneyard (Boneyard)
    [117809] = 0, -- Unnerving Boneyard (Unnerving Boneyard)
    [117854] = 0, -- Avid Boneyard (Avid Boneyard)

    --[116410] = 1, -- Shocking Siphon (Shocking Siphon)
    --[118766] = 0, -- Detonating Siphon (Detonating Siphon)
    --[118011] = 0, -- Mystic Siphon (Mystic Siphon)

    -- Arcanist
    [194844] = 0, -- Fatecarver Snare (Exhausting Fatecarver)
    [194842] = 1, -- Fatecarver (Fatecarver)
    [194843] = 1, -- Fatecarver (Fatecarver, Area)
    [185805] = 1, -- Fatecarver (Fatecarver, Area)
    [20185805] = 1, -- Fatecarver (Fatecarver, Area)
    [30185805] = 1, -- Fatecarver (Fatecarver, Area)
    [40185805] = 1, -- Fatecarver (Fatecarver, Area)
    [186366] = 1, -- Pragmatic Fatecarver (Pragmatic Fatecarver)
    [186370] = 0, -- Pragmatic Fatecarver (Pragmatic Fatecarver, Area)
    [20186366] = 1, -- Pragmatic Fatecarver (Pragmatic Fatecarver, Area)
    [30186366] = 1, -- Pragmatic Fatecarver (Pragmatic Fatecarver, Area)
    [40186366] = 1, -- Pragmatic Fatecarver (Pragmatic Fatecarver, Area)
    [183122] = 1, -- Exhausting Fatecarver (Exhausting Fatecarver, Area)
    [184291] = 0, -- Exhausting Fatecarver (Exhausting Fatecarver)
    [20183122] = 1, -- Exhausting Fatecarver (Exhausting Fatecarver, Area)
    [30183122] = 1, -- Exhausting Fatecarver (Exhausting Fatecarver, Area)
    [40183122] = 1, -- Exhausting Fatecarver (Exhausting Fatecarver, Area)
    [183123] = 0, -- Exhausting Fatecarver (Exhausting Fatecarver, Area)
    -- [185817] = 1,   -- Abyssal Impact (Abyssal Impact)
    [186772] = 1, -- Abyssal Impact (Abyssal Impact)
    -- [20185817] = 1, -- Abyssal Impact (Abyssal Impact)
    -- [30185817] = 1, -- Abyssal Impact (Abyssal Impact)
    -- [40185817] = 1, -- Abyssal Impact (Abyssal Impact)
    -- [183006] = 0,   -- Cephaliarch's Flail (Cephaliarch's Flail)
    [183009] = 0, -- Cephaliarch's Flail (Cephaliarch's Flail)
    -- [20183006] = 0, -- Cephaliarch's Flail (Cephaliarch's Flail)
    -- [30183006] = 0, -- Cephaliarch's Flail (Cephaliarch's Flail)
    -- [40183006] = 0, -- Cephaliarch's Flail (Cephaliarch's Flail)
    -- [185823] = 0,   -- Tentacular Dread (Tentacular Dread)
    [186773] = 0, -- Tentacular Dread (Tentacular Dread)
    -- [20185823] = 0, -- Tentacular Dread (Tentacular Dread)
    -- [30185823] = 0, -- Tentacular Dread (Tentacular Dread)
    -- [40185823] = 0, -- Tentacular Dread (Tentacular Dread)
    -- [185840] = 0, -- Rune of Displacement (Rune of Displacement, DOT)
    [187526] = 0, -- Rune of Displacement (Rune of Displacement)
    -- [185841] = 0, -- Rune of Displacement (Rune of Displacement)
    -- [195205] = 0, -- Rune of Displacement (Rune of Displacement)
    -- [195206] = 0, -- Rune of Displacement (Rune of Displacement, DOT)
    -- [195210] = 0, -- Rune of Displacement (Rune of Displacement)
    -- [198413] = 0, -- Rune of Displacement (Rune of Displacement)
    -- [186832] = 0, -- Runeguard of Still Waters (Runeguard of Still Waters Immobilize)
    -- [191083] = 1, -- Rune of Displacement (Rune of Displacement) -- Seen in Cyrodiil
    -- [187526] = 1, -- Rune of Displacement (Rune of Displacement) -- Seen in Cyrodiil
    -- [187513] = 1, -- Rune of Displacement (Rune of Displacement) -- Seen in Cyrodiil

    -- Destruction Staff
    [62896] = 1, -- Wall of Fire
    [62971] = 0, -- Wall of Storms
    [62931] = 0, -- Wall of Frost
    [39054] = 1, -- Unstable Wall of Fire
    [39079] = 0, -- Unstable Wall of Storms
    [39071] = 0, -- Unstable Wall of Frost
    [62912] = 1, -- Blockade of Fire
    [62990] = 0, -- Blockade of Storms
    [62951] = 0, -- Blockade of Frost

    -- Two-Handed
    [126474] = 1, -- Stampede

    -- Bow
    [28877] = 1, -- Volley
    [38690] = 0, -- Endless Hail
    [38696] = 0, -- Arrow Barrage
    [38707] = 0, -- Bombard

    -- Undaunted
    [39299] = 1, -- Necrotic Orb
    [42029] = 1, -- Mystic Orb

    -- Fighters Guild
    [35753] = 1, -- Trap Beast Immobilize (Trap Beast)
    [40384] = 1, -- Barbed Trap Immobilize (Barbed Trap)
    [40374] = 1, -- Lightweight Beast Trap Immobilize (Lightweight Beast Trap)

    -- Assault
    [38561] = 1, -- Caltrops (Caltrops)
    [40267] = 0, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40252] = 0, -- Razor Caltrops (Razor Caltrops)
    [113771] = 0, -- Razor Caltrops (Razor Caltrops)

    -- Vampire
    [38968] = 0, -- Blood Mist (Blood Mist)

}

CrowdControl.aoePlayerSet =
{

    -- Sets
    [102136] = 0, -- Zaan
    [59568] = 1, -- Malubeth
    [80522] = 1, -- Stormfist
    [59498] = 1, -- Mephala's Web (Spawm of Mephala)
    [60972] = 1, -- Fiery Breath (Maw of the Infernal)
    [80526] = 1, -- Ilambris
    [84502] = 1, -- Grothdarr
    [80561] = 1, -- Iceheart
    [97883] = 1, -- Domihaus
    [97899] = 0, -- Domihaus
    [80565] = 1, -- Kra'gh
    [75692] = 1, -- Bahraha's Curse (of Bahraha's Curse)
    [57209] = 1, -- Storm Knight's Plate (of the Storm Knight)
    [67136] = 1, -- Overwhelming Surge (Overwhelming)
    [59696] = 1, -- Embershield (Embershield)
    [67204] = 1, -- Leeching Plate (of Leeching)
    [102094] = 1, -- Thurvokun (Thurvokun)
    [116920] = 1, -- Auroran's Thunder (Auroran's Thunder)
    [133494] = 1, -- Aegis Caller (Aegis Caller's)
    [137526] = 1, -- Hunter's Venom (Venomous)
    [143077] = 1, -- Stone Husk (Stone Husk)
    [167679] = 1, -- Nunatak (Nunatak)
    [167683] = 0, -- Nunatak Immobilize (Nunatak)
    [159277] = 0, -- Rush of Agony (Rush of Agony)
    [159275] = 1, -- Rush of Agony (Rush of Agony)
    [159391] = 0, -- Dark Convergence (Dark Convergence)
    [160317] = 0, -- Dark Convergence (Dark Convergence)
    [159386] = 1, -- Dark Convergence (Dark Convergence)
    [159387] = 1, -- Dark Convergence (Dark Convergence)
    [188886] = 0, -- Time Disruption (Snare, Judement of Akatosh)
    [189859] = 1, -- Time Disruption (AoE, Judement of Akatosh)

    -- Siege
    [104693] = 1, -- Meatbag Catapult
    [104695] = 1, -- Scattershot Catapult
    [138556] = 1, -- Shock Lancer
    [138434] = 1, -- Fire Lancer
    [138552] = 1, -- Frost Lancer
}

CrowdControl.aoeTraps =
{

    [87949] = 0, -- Lava (Foyada Quarry)
    [44034] = 0, -- Slaughterfish Attack (Stirk)
    [113082] = 0, -- Slaughterfish Attack (Cyrodiil)
    [19224] = 0, -- In Lava (Halls of Torment)
    [11338] = 0, -- In Lava (The Earth Forge)
    [56277] = 0, -- Lava (City of Ash II)
    [5140] = 0, -- Lava (Dragonstar Arena)

    [62770] = 0, -- Coldharbour Flames (Flame Trap) - Soul Shriven in Coldharbour
    [21943] = 0, -- Spike Trap (Spike Trap)
    [53169] = 0, -- Spike Trap (Spike Trap) - Dragonstar Arena
    [26531] = 0, -- Bear Trap (Bear Trap)
    [31086] = 0, -- Trap (Trap) - Selene's Web
    [20260] = 0, -- Rune Burst (Sigil of Frost)
    [33594] = 0, -- Fire (Fire) -- Greenshade - Throne of the Wilderking

    [17314] = 0, -- Fire Trap (Player)
    [72888] = 0, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = 0, -- Fire Attack 2 (Fire) -- Banished Cells II

    [27940] = 0, -- Laser Damage (Generic Flame Wave Shooter) -- Stros M'Kai
    [32245] = 0, -- Searing Steam (Steam Trap) -- Stros M'Kai

    [26040] = 0, -- Steam Blast (Steam Vent) -- Volenfell
    [26089] = 0, -- Steam Blast (Steam Vent) -- Volenfell
    [26077] = 1, -- Steam Blast (Steam Vent) -- Volenfell
    [26091] = 1, -- Steam Blast (Steam Vent) -- Volenfell

    [110416] = 1, -- Putrid Cloud (Gas Blossom) -- Housing
    [110542] = 1, -- Stunted Current (Static Pitcher) -- Housing
    [111258] = 1, -- Surprise Attack (Lantern Mantis) -- Housing
    [111261] = 1, -- Surprise Attack (Lantern Mantis) -- Housing

    [92757] = 0, -- Spinning Blade (Ald Carac)

    [117508] = 0, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117622] = 0, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117598] = 0, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117139] = 0, -- Spinning Blade (Blade Trap - Elinhir Private Arena)

    [92150] = 0, -- Fire Trap (Vvardenfell -- Divine Delusions)
    [87102] = 0, -- Spinning Blade (Vvardenfell -- Divine Restoration)
    [92284] = 0, -- Planar Shear (Vvardenfell -- Divine Restoration)
    [86743] = 0, -- Accelerated Transposition (Vvardenfell -- Like Blood from a Stone)
    [84527] = 0, -- Searing Steam (Vvardenfell - Nchuleftingth)
    [90271] = 0, -- Charge-Wire Shock (Vvardenfell - Nchuleftingth)
    [92138] = 0, -- Laser Damage (Vvardenfell - Nchuleftingth)

    -- Quests
    [31970] = 1, -- Wrath (Tears of the Two Moons)
    [33404] = 0, -- Wrath (Tears of the Two Moons)
    [38499] = 1, -- Wrath (The Grips of Madness)
    [33577] = 1, -- Maormer Fire (Pelidil's End)

    -- Dragonstar Arena
    [53341] = 0, -- Biting Cold (Player)
    [60421] = 0, -- Biting Cold (Player)
    [83498] = 0, -- Poisonous Cloud (Poison Cloud)
    [83468] = 0, -- Restoring Nature (Nature's Blessing)

    -- Maelstrom Arena
    [69101] = 0, -- Shock (Generator)
    [66797] = 0, -- Spinning Blade (Blade Trap)
    [67871] = 0, -- Shock (Water)
    [72525] = 0, -- Frigid Waters (Player)
    [67808] = 0, -- Frigid Waters (Player)

    -- City of Ash II
    [56068] = 0, -- Slag Geyser (Lava Pool)
}

CrowdControl.aoeNPCBoss =
{

    -- Vvardenfell
    [94936] = 0, -- Tremor (Nchuleftingth - Mud-Tusk)
    [86566] = 1, -- Fire Runes (Nchuleftingth - Friar Hadelar)
    [89754] = 1, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [90148] = 1, -- Sunder's Echo (Vvardenfell -- Divine Intervention)
    [90146] = 0, -- Sunder's Echo (Vvardenfell -- Divine Intervention)
    [69284] = 1, -- Whirlwind Function (Guardian of Bthark -- Nchuleftingth)
    [86607] = 1, -- Steam Breath (Guardian of Bthark -- Nchuleftingth)

    -- Elsweyr
    [124352] = 1, -- Flame Aura (Bahlokdaan)

    -- World Bosses
    [84045] = 1, -- Seal of Defilement (Quenyas) - World Boss - Seaside Scarp Camp
    [84206] = 1, -- Stinging Sputum (Gathongor the Mauler) - World Boss - Gathongor's Mine
    [83668] = 1, -- Feral Impact (Skullbreaker) - World Boss - Windshriek Strand
    [83671] = 1, -- Feral Impact (Skullbreaker) - World Boss - Windshriek Strand
    [84160] = 1, -- Spit Poison (Old Widow Silk) - World Boss - Spider Nest
    [84549] = 1, -- Venom Spray (Old Widow Silk) - World Boss - Spider Nest
    [83000] = 1, -- Crabuchet (Titanclaw) - World Boss - Mudcrab Beach
    [83021] = 1, -- Crabuchet (Titanclaw) - World Boss - Mudcrab Beach

    -- Quests
    [36860] = 1, -- Swordstorm Damage (MSQ - Halls of Torment)
    [87959] = 1, -- Ash Storm (Vvardenfell -- Divine Delusions)

    -- Dragonstar Arena
    [53660] = 1, -- Power Overload Heavy Attack (Nak'tah)
    [54084] = 1, -- Corrosive Armor (Earthen Heart Knight)
    [52903] = 1, -- Standard of Might (Anal'a Tu'wha0)
    [52933] = 1, -- Solar Disturbance (Shadow Knight)
    [55086] = 1, -- Poison Mist (Vampire Lord Thisa)
    [55092] = 1, -- Devouring Swarm (Vampire Lord Thisa)
    [55104] = 1, -- Marked for Death (Hiath the Battlemaster)
    [55182] = 0, -- Marked for Death (Hiath the Battlemaster)

    -- Maelstrom Arena
    [68197] = 1, -- Necrotic Essence (Necrotic Orb)
    [70901] = 1, -- Defiled Grave (Maxus the Many) -- NORMAL
    [72149] = 0, -- Defiled Grave (Maxus the Many) -- VETERAN
    [69366] = 1, -- Barrage Function (Centurion Champion)
    [69316] = 1, -- Electric Shield (Centurion Champion)
    [73880] = 1, -- Call Lightning (Lamia Queen)
    [67758] = 1, -- Queen's Poison (Lamia Queen)
    [68537] = 1, -- Overcharged Bolt (The Control Guardian)
    [70860] = 1, -- Overheated Flame (The Control Guardian)
    [68543] = 1, -- Overheated Volley (The Control Guardian)

    -- Banished Cells I
    [19027] = 1, -- Dead Zone (Skeletal Destroyer)
    [33188] = 1, -- Daedric Tempest (High Kinlord Rilis)

    -- Banished Cells II
    [28904] = 1, -- Immolating Bite (Maw of the Infernal)
    [49149] = 1, -- Breath of Flame (Maw of the Infernal)
    [29020] = 1, -- Berserker Frenzy (Keeper Voranil)
    [31727] = 1, -- Corruption (Keeper Imiril)
    [48800] = 1, -- Daedric Tempest (High Kinlord Rilis)
    [48815] = 0, -- Daedric Tempest (High Kinlord Rilis)

    -- Elden Hollow I
    [16017] = 1, -- Berserker Frenzy (Akasha gra-Mal)
    [25300] = 0, -- Berserker Frenzy (Akasha gra-Mal)
    [25301] = 0, -- Berserker Frenzy (Akasha gra-Mal)
    [25302] = 0, -- Berserker Frenzy (Akasha gra-Mal)
    [42601] = 1, -- Necrotic Circle (Canonreeve Oraneth)

    -- Elden Hollow II
    --[34377] = 1, -- Flame Geyser (Dubroze the Infestor)
    [32972] = 1, -- Consuming Shadow (Murklight)
    [33050] = 1, -- Eclipse (Murklight)
    [33103] = 1, -- Spout Shadow (The Shadow Guard)
    [33434] = 1, -- Daedric Flame (Bogdan the Nightflame)

    -- City of Ash I
    [34960] = 1, -- Blazing Fire (Warden of the Shrine)
    [35145] = 1, -- Consuming Fire (Infernal Guardian)
    [34204] = 1, -- Burning Field (Rothariel Flameheart)

    -- City of Ash II
    [56415] = 1, -- Fire Runes (Urata the Legion)
    [55314] = 1, -- Slag Breath (Horvantud the Fire Maw)
    [55334] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [55321] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [55336] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [55327] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [55338] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [56010] = 1, -- Ground Quake (Horvantud the Fire Maw)
    [56151] = 1, -- Ethereal Flame (Ash Titan)
    [55175] = 1, -- Molten Rain (Ash Titan)
    [54637] = 1, -- Flame Tornado (Air Atronach)
    [55756] = 1, -- Burning (Valkyn Skoria)

    -- Tempest Island
    [26619] = 1, -- Shock (Sudden Storm)
    [6108] = 1, -- Lightning Storm (Yalorasse the Speaker)
    [26752] = 1, -- Enervating Stone (Stormfist)
    [26517] = 1, -- Electrical Shock (Twister)

    -- Selene's Web
    [30908] = 1, -- Summon Primal Swarm (Treethane Kerninn)
    [30773] = 1, -- Arrow Rain (Longclaw)
    [31150] = 1, -- Poison Burst (Longclaw)
    [31203] = 1, -- Venomous Burst (Queen Aklayah)

    -- Spindleclutch II
    [28006] = 1, -- Cave In (Blood Spawn)
    [47332] = 0, -- Cave-In (Blood Spawn)
    [27603] = 1, -- Blood Pool (Urvan Veleth)
    [27906] = 1, -- Blood Pool (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [25591] = 1, -- Necrotic Essence (Investigator Garron)

    -- Wayrest Sewers II
    [36625] = 1, -- Scourging Spark (Malubeth the Scourger)
    [36869] = 1, -- Scorching Flames (Uulgarg the Risen)
    [36944] = 1, -- Necrotic Barrage (Garron the Returned)

    -- Crypt of Hearts I
    [22716] = 1, -- Necrotic Ritual (Archmaster Siniel)
    [46950] = 1, -- Fire Trail (Death's Leviathan)
    [22432] = 1, -- Electric Prison (Lightning Rod)
    [22388] = 1, -- Rain Fire (Ilambris-Zaven)
    [22398] = 1, -- Call Lightning (Ilambris-Athor)
    [22401] = 0, -- Call Lightning (Ilambris-Athor)
    [22403] = 0, -- Call Lightning (Ilambris-Athor)

    -- Crypt of Hearts II
    [51883] = 1, -- Creeping Storm (Creeping Storm)
    [52286] = 1, -- Rain Fire (Ilambris Amalgam)
    [52335] = 0, -- Rain Fire (Ilambris Amalgam)
    [52279] = 1, -- Call Lightning (Ilambris Amalgam)
    [52339] = 0, -- Call Lightning (Ilambris Amalgam)
    [52082] = 1, -- Cursed Ground (Nerien'eth)
    [53157] = 0, -- Cursed Ground (Nerien'eth)
    [53134] = 1, -- Tortured Souls (Soul Cage)

    -- Volenfell
    [25030] = 1, -- Twisted Steel (Quintus Verres)
    [25143] = 1, -- Burning Ground (Quintus Verres)
    [25223] = 1, -- Heaving Quake (Quintus Verres)
    [25674] = 1, -- Flame Burst (Boilbite)
    [25675] = 1, -- Flame Burst (Boilbite)
    [25676] = 1, -- Flame Burst (Boilbite)
    [25677] = 1, -- Flame Burst (Boilbite)
    [44113] = 1, -- Barrage Function (The Guardian's Spark)
    [25213] = 1, -- Whirlwind Function (The Guardian's Strength)
}

CrowdControl.aoeNPCElite =
{

    -- Overland / Standard NPC's
    [44228] = 0, -- Dragonknight Standard (Dragonknight - Elite)
    [81197] = 1, -- Agonizing Fury (Thundermaul - Boss)
    [21952] = 1, -- Repulsion Shock (Wamasu)
    [55867] = 0, -- Repulsion Shock (Wamasu - Boss)
    [72794] = 1, -- Toxic Pool (Haj Mota)
    [53233] = 1, -- Miasma Pool (Flesh Colossus)
    [52866] = 1, -- Volley (Cyrodiil Archer)
    [54258] = 1, -- Upgraded Volley (Cyrodiil Archer)
    [10271] = 1, -- Quake (Gargoyle)
    [9011] = 1, -- Tremor (Troll)
    [48297] = 1, -- Consuming Omen (Troll - Ranged)
    [19061] = 1, -- Rain of Wisps (Wispmother)
    [75928] = 1, -- Elemental Pool (Minotaur)
    [75953] = 1, -- Brimstone Hailfire (Minotaur Shaman)
    [75976] = 1, -- Pillar of Nirn (Minotaur Shaman)
    [75980] = 1, -- Pillar Eruption (Minotaur Shaman)
    [11282] = 1, -- Steam Breath (Dwemer Centurion)

    -- World
    [95841] = 1, -- Static Charge (Dark Anchor)

    -- Quests
    [50765] = 1, -- CON_AOE_Template1 (Pelidil's End)

    -- Summerset
    [105889] = 1, -- Pustulant Eruption (Yaghra Nightmare)

    -- Dragonstar Arena
    [53314] = 1, -- Flame Volley (Sovngarde Ranger)
    [53280] = 1, -- Unstable Wall of Frost (Sovngarde Icemage)
    [53614] = 1, -- Thundering Presence (Nak'tah)
    [53625] = 1, -- Lightning Flood (Nak'tah)
    [56824] = 1, -- Puncturing Sweep (House Dres Templar)
    [54161] = 1, -- Berserker Frenzy (House Dres Slaver)
    [54080] = 1, -- Cinder Storm (Earthen Heart Knight)
    [52892] = 1, -- Flames of Oblivion (Anal'a Tu'wha)
    [55981] = 1, -- Ice Charge (Dwarven Ice Centurion)

    -- Maelstrom Arena
    [72159] = 1, -- Static Field (Dwarven Spider)
    [72203] = 1, -- Overcharge (Scavenger Thunder-Smith)
}

CrowdControl.aoeNPCNormal =
{

    [37131] = 0, -- Ice Cage (Battlemage)
    [10813] = 1, -- Ignite (Synergy - Fire Mage)
    [38260] = 0, -- Ignite (Synergy - Fire Mage)
    [28629] = 1, -- Volley (Archer)
    [47102] = 1, -- Fire Rune (Fire Mage)
    [14068] = 1, -- Ignite (Synergy - Archer)
    [70414] = 0, -- Ignite (Synergy - Cyrodiil Archer)
    [38125] = 1, -- Caltrops  (Faction NPCs)
    [76624] = 1, -- Pool of Shadow (Voidbringer)
    [76728] = 0, -- Pool of Shadow (Voidbringer)
    [88336] = 0, -- Pool of Shadow (Skaafin Masquer)
    [88330] = 0, -- Pool of Shadow (Skaafin Masquer)
    [88335] = 0, -- Pool of Shadow (Skaafin Masquer)
    [88334] = 0, -- Pool of Shadow (Skaafin Masquer)
    [84837] = 1, -- Broken Pact (Skaafin Witchling)
    [87902] = 1, -- Bombard (Arbalest)
    [62502] = 1, -- Fiery Wind (Justice Mage)
    [46819] = 1, -- Storm Damage (Cyrodiil Mage)
    [7883] = 1, -- Guardian Storm (Cyrodiil Mage)
    [8604] = 1, -- Vigorous Swipe (Mammoth)
    [27100] = 1, -- Shocking Rake (Dreugh)
    [16698] = 1, -- Poisonbloom (Netch)
    [90778] = 1, -- Acid Pool (Nix-Ox)
    [90815] = 0, -- Acid Pool (Nix-Ox)
    [85421] = 1, -- Retch (Cliff Strider)
    [85391] = 1, -- Slash (Cliff Strider)
    [13680] = 1, -- Acid Blood (Assassin Beetle)
    [61374] = 1, -- Infectious Swarm (Necrotic Hoarvor)
    [10947] = 1, -- Fiery Breath (Shalk)
    [5265] = 1, -- Burning Ground (Shalk)
    [8088] = 1, -- Poison Spray (Giant Spider)
    [87126] = 1, -- Heat Vents (Fetcherfly Nest)
    [51282] = 1, -- Flame Tornado (Air Atronach - Flame)
    [9749] = 1, -- Envelop (Banekin)
    [73437] = 1, -- Soul Flame (Daedric Titan)
    [4772] = 1, -- Fiery Breath (Daedroth)
    [91938] = 1, -- Burst of Embers (Daedroth)
    [51645] = 1, -- Frozen Ground (Frost Atronach)
    [6162] = 1, -- Rain of Fire (Scamp)
    [88323] = 1, -- Blast Furnace (Iron Atronach)
    [69950] = 1, -- Desecrated Ground (Undead Synergy)
    [73937] = 1, -- Soul Cage (Lich)
    [73929] = 0, -- Soul Cage (Lich)
    [20812] = 1, -- Defiled Ground (Lich)
    [72996] = 1, -- Symphony of Blades (Defiled Aegis)
    [8628] = 1, -- Charged Ground (Harpy)
    [4769] = 1, -- Choking Pollen (Lurcher)
    [16040] = 1, -- Hurricane (Nereid)
    [19997] = 1, -- Static Field (Dwemer Spider - Synergy)
    [91094] = 1, -- Split Bolt (Dwemer Arquebus)
    [91095] = 0, -- Split Bolt (Dwemer Arquebus)
    [91096] = 0, -- Split Bolt (Dwemer Arquebus)
    [103862] = 1, -- Deluge (Yaghra Spewer)
    [103992] = 1, -- Luminescent Burn (Yaghra Spewer)
    [121644] = 1, -- Defiled Ground (Euraxian Necromancer)
}

-- List of effects sourced by the player that damage self that should be shown
CrowdControl.LavaAlerts =
{
    -- Player
    [115607] = true, -- Dismount Stun (Mount)
    [141004] = true, -- Dismount Stun (Passenger Mount)

    -- Consumables
    [68565] = true, -- Stun (Potion of Stun)

    -- World
    [95841] = true, -- Static Charge (Dark Anchor)

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

    -- Wayrest Sewers II
    [49052] = true, -- Pellingare Prison (Allene Pellingare)
}

CrowdControl.IgnoreList =
{
    -- PVP
    [178127] = true, -- Diseased
    [178118] = true, -- Overcharged
    [21927] = true, -- Minor Defile
    --[88402] = true, -- Minor Magickasteal -- TODO: This id isn't the heal anymore so don't think this is needed here
    [148798] = true, -- Minor Magickasteal
    [40079] = true, -- Radiating Regeneration
    [57468] = true, -- Radiating Regeneration
    [187942] = true, -- Minor Fortitude
    [146697] = true, -- Minor Brittle
    [187940] = true, -- Minor Courage
    [178123] = true, -- Sundered
    [62775] = true, -- Major Breach
    [95136] = true, -- Chill
    [68368] = true, -- Minor Maim
    [187941] = true, -- Minor Endurance
    [187943] = true, -- Minor Intellect

    -- World
    [54363] = true, -- Halt (Guard)
    [4197] = true, -- Recovering (NPC Duel)

    -- Quests
    [34499] = true, -- Corruption Beam (The Blight of the Bosmer)

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

    -- Elsweyr
    [121032] = true, -- Bash (Grand Adept Ma'hja-dro) (Bright Moons, Warm Sands)
    [121035] = true, -- Staggered (Grand Adept Ma'hja-dro) (Bright Moons, Warm Sands)

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

    -- Dreadsail Reef
    [166794] = true, -- Raging Current -- Dreadsail Reef

    -- Endless Archive
    [192956] = true, -- Enter the Endless
    [194570] = true, -- Enter the Endless
    [192972] = true, -- Enter the Endless
    [194571] = true, -- Enter the Endless
    [202803] = true, -- Enter the Endless (Group)
    [212065] = true, -- Enter the Endless
    [203125] = true, -- Verse Select
    [203101] = true, -- Vision Select
    [211431] = true, -- Side Content Transporter
    [211433] = true, -- Side Content Selector (Group)
    [192506] = true, -- Unstable Metamorphosis

    -- Lucient Citadel
    [218509] = true, -- Arcane Encumberance

    ----------------
    -- Miscelaneous
    ----------------

    -- Snare Effects
    [8239] = true, -- Hamstring
    [160949] = true, -- Warmth
    [127795] = true, -- Living Dark
    [101693] = true, -- Arrow Spray
    [10650] = true, -- Oil Drenched
    [85656] = true, -- Harry
}

-- Not implemented - list of abilities that ACTION_RESULT_GAINED_DURATION fires in the opposite order of normal
CrowdControl.ReversedLogic =
{
    -- Quests
    [21876] = true, -- Q4260 West Barrier Teleport
    [21878] = true, -- Q4260 East Barrier Teleport
    [39260] = true, -- Q4917 Push Player Back (Grahtwood - The Blacksap's Hold)

    -- World Bosses
    [83124] = true, -- Ferocious Bellow (Greenshade - World Boss - Thodundor's View)

    -- Dungeons
    [26716] = true, -- Skyward Slam (Stormfist) -- Tempest Island
    [34848] = true, -- Primal Sweep -- Wayrest Sewers
}

-- Use on ACTION_RESULT_EFFECT_GAINED
CrowdControl.SpecialCC =
{
    [55756] = true, -- Burning (Valkyn Skoria)
}
