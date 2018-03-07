LUIE.AlertTable = {

-- PRIORITY NOTES:
    -- 1 = VMA/Trial/Dungeon
    -- 2 = ELITE NPC/QUEST BOSS
    -- 3 = Normal NPC
    
    -- bs = true -- Add indicator for Block Stagger to effect
    -- auradetect = true -- Detect aura application rather than using targeting info
    -- eventdetect = true -- Detect combat event application rather than using targeting info
    -- refire = "x" -- refire duration
    -- skipcheck = true -- display on any event fired rather than just event started
    
    -- TEMPLATE
    -- [00000] = { block = false, dodge = false, avoid = false, interrupt = false, priority = 3}, --
    -- TEMPLATE
    
    --------------------------------------------------
    -- JUSTICE NPC'S ---------------------------------
    --------------------------------------------------
    
    [63157] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = true}, -- Heavy Blow (Justice Guard 1H)
    [63261] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = true}, -- Heavy Blow (Justice Guard 2H)
    [63179] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = false}, -- Flame Shard (Justice Guard 2H)
    [78743] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, bs = false}, -- Flare (Justice Guard - Any)
    
    [74862] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, bs = false}, -- Teleport Trap (Mage Guard)
    
    [62409] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true, refire = 1500 }, -- Fiery Wind (Justice Mage NPC)
    [62472] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true }, -- Stab (Justice Dagger NPC)
    
    [78265] = { power = true, priority = 2 }, -- Alarm (Estate Marshal) (DB DLC)
    
    [52471] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, refire = 2000 }, -- Nullify (Estate Spellbreaker) (DB DLC)
    
    --------------------------------------------------
    -- STANDARD NPC'S --------------------------------
    --------------------------------------------------
    
    -- Synergy
    [10805] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true }, -- Ignite (Synergy)
    
    
    -- Abilities
    [29378] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Uppercut (Ravager)
    
    [28408] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true}, -- Whirlwind (Skirmisher)
    
    [37108] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Arrow Spray (Archer)
    [28628] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Volley (Archer)
    [74978] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Taking Aim (Archer)
    
    [14096] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Heavy Attack (Footsoldier)
    [28499] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Throw Dagger (Footsoldier)
    
    [29400] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Power Bash (Guard)
    
    [48542] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, auradetect = true, bs = true}, -- Focused Charge (Brute)
    
    [35164] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 3}, -- Agony (Berserker)
    
    [29510] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3 }, -- Thunder Hammer (Thundermaul)
    [17867] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3 }, -- Shock Aura (Thundermaul)
    
    [81215] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 2 }, -- Shock Aura (Thundermaul - Boss)
    [81217] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2 }, -- Thunder Hammer (Thundermaul)
    
    [36470] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Veiled Strike (Nightblade)
    [44345] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true }, -- Soul Tether (Nightblade)
    
    [34742] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3}, -- Fiery Breath (Dragonknight)
    [34646] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Lava Whip (Dragonknight)
    [44227] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2 }, -- Dragonknight Standard (Dragonknight - Elite)
    [52041] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = true }, -- Blink Strike (Dragonknight - Elite)
    
    [44301] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 3, auradetect = true, refire = 1500}, -- Trap Beast (Pet Ranger)
    
    [15164] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Heat Wave (Fire Mage)
    [47095] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Fire Rune (Fire Mage)
    
    [29471] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Thunder Thrall (Storm Mage)
    
    [12459] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Winter's Reach (Frost Mage)
    
    [35151] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true}, -- Spell Absorption (Spirit Mage)
    
    [14370] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, auradetect = true}, -- Void (Time Bomb Mage) 
    
    [37087] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Lightning Onslaught (Battlemage)
    [37129] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2}, -- Ice Cage (Battlemage)
    [44216] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2}, -- Negate Magic (Battlemage - Elite)
    
    [13397] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, notDirect = true, refire = 1000}, -- Empower Undead (Necromancer)
    [14350] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Aspect of Terror (Fear Mage)
    
    [35387] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Defiled Grave (Bonelord)
    
    [57534] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true}, -- Focused Healing (Healer)
    [44328] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 2, auradetect = true, notDirect = true}, -- Rite of Passage (Healer)
    
    [29520] = { destroy = true, auradetect = true, priority = 2 }, -- Aura of Protection (Shaman)
    
    [68866] = { power = true, auradetect = true, refire = 1000, priority = 2 }, -- War Horn (Faction NPC)
    [43644] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Barrier [monster synergy]  (Faction NPCs)
    
    [70070] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true }, -- Heavy Strike (Winterborn Warrior)
    [64980] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3 }, -- Javelin (Winterborn Warrior)
    [65033] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, skipcheck = true }, -- Retaliation (Winterborn Warrior)
    
    [55909] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Grasping Vines (Winterborn Mage)
    [64704] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true, refire = 1500 }, -- Flames (Winterborn Mage)
    
    [65235] = { power = true, auradetect = true, priority = 2, refire = 1000 }, -- Enrage (Vosh Rakh Devoted)
    [53987] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, notDirect = true }, -- Rally (Vosh Rakh Devoted)
    [54027] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, refire = 1600}, -- Divine Leap (Vosh Rakh Devoted)
    
    [51000] = { power = true, auradetect = true, priority = 2, refire = 1000 }, -- Cleave Stance (Dremora Caitiff) (Craglorn)
    
    [72725] = { power = true, auradetect = true, priority = 2, refire = 1000 }, -- Fool Me Once (Sentinel) (TG DLC)
    
    [76089] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Snipe (Archer) (TG DLC)
    --[72220] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Snipe (Archer) (TG DLC) -- This is cast from stealth - so for the time being, maybe hide.
    
    [77472] = { power = true, auradetect = true, priority = 2, refire = 1000 }, -- Til Death (Bodyguard) (DB DLC)
    [77554] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, notDirect = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77473] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Shield Charge (Bodyguard) (DB DLC)
    
    [77089] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Basilisk Powder (Tracker) (Morrowind)
    [77087] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Basilisk Powder (Tracker) (Morrowind)
    [77019] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Pin (Tracker) (Morrowind)
    [78432] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, refire = 1500}, -- Lunge (Tracker) (Morrowind)
    
    [88371] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Dive (Beastcaller) (Morrowind)
    [88394] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Gore (Beastcaller) (Morrowind)
    
    [87901] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Bombard (Arbalest) (Morrowind)
    [87422] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Chilled Ground (Arbalest) (Morrowind)
    [87713] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true}, -- Quakeshot (Arbalest) (Morrowind)
    
    [85359] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Reverse Slash (Drudge)
    
    [87064] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Volcanic Debris (Fire-Binder) (Morrowind)
    [88845] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, notDirect = true, auradetect = true }, -- Empower Atronach (Fire-Binder) (Morrowind)
    
    [76621] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3 }, -- Shadeway (Voidbringer) (Morrowind)
    [76619] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true }, -- Pool of Shadow (Voidbringer) (Morrowind)
    [76979] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Shadowy Duplicate (Voidbringer) (Morrowind)
    
    [88327] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3 }, -- Shadeway (Skaafin Masquer) (Morrowind)
    [88325] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true }, -- Pool of Shadow (Skaafin Masquer) (Morrowind)
    [88348] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Shadowy Duplicate (Skaafin Masquer) (Morrowind)
    
    [84818] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, notDirect = true, auradetect = true }, -- Fiendish Healing (Skaafin Witchling) (Morrowind)
    
    [84835] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true }, -- Broken Pact (Skaafin) (Morrowind)
    
    -- ANIMALS
    [5452] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true }, -- Lacerate (Alit)
    
    [4415] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true}, -- Crushing Swipe (Bear)
    [4416] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Savage Blows (Bear)
    
    [70366] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true}, -- Slam (Great Bear)
    
    [4591] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Sweep (Crocodile)
    [4594] = { power = true, auradetect = true, refire = 1000, priority = 2, ignoreRefresh = true}, -- Ancient Skin (Crocodile)
    
    [8977] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Sweep (Duneripper)
    
    [7227] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Rotbone (Durzog)
    
    [6308] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Shocking Touch (Dreugh)
    [6328] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, refire = 2000 }, -- Shocking Rake (Dreugh)
    
    [54375] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3}, -- Shockwave (Echatere)
    [54380] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true}, -- Headbutt (Echatere)
    
    [4632] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3}, -- Screech (Giant Bat)
    [4630] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, refire = 1500}, -- Draining Bite (Giant Bat)
    
    [5240] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Lash (Giant Snake)
    [5242] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Kiss of Poison (Giant Snake)
    [5244] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true}, -- Shed Skin (Giant Snake)
    
    [5441] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true }, -- Dive (Guar)
    
    [14819] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Charge (Kagouti)
    [5363] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Chomp (Kagouti)
    [5926] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true}, -- Toss (Kagouti)
    
    [7161] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Double Strike (Lion)
    
    [8604] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, refire = 5700, skipcheck = true}, -- Vigorous Swipe (Mammoth)
    [8600] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, skipcheck = true}, -- Stomp (Mammoth)
    [48551] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, auradetect = true}, -- Charge (Mammoth)
    
    [4200] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Unforgiving Claws (Mudcrab)
    
    [16690] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Thrust (Netch)
    [16697] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true, refire = 2000}, -- Poisonbloom (Netch)
    
    [7268] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 500}, -- Leech
    [7273] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true }, -- Dampworm (Nix-Hound)
    
    [21904] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Rend (Skeever)
    
    [21951] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2}, -- Repulsion Shock (Wamasu)
    [21949] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, eventdetect = true}, -- Sweep (Wamasu)
    [48556] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, auradetect = true}, -- Focused Charge (Wamasu)
    [22045] = { power = true, auradetect = true, priority = 2, refire = 1000}, --- Static (Wamasu)
    
    [44791] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Rear Kick (Welwa)
    [52417] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Charge (Welwa)
    
    [42844] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Rotbone (Wolf)
    [14523] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, refire = 1000}, -- Helljoint (Wolf)
    
    [72793] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 2}, -- Toxic Mucus (Haj Mota)
    [72796] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, auradetect = true}, -- Bog Burst (Haj Mota)
    [72789] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true}, -- Shockwave (Haj Mota)
    
    [76307] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Lunge (Dire Wolf)
    [76324] = { power = true, auradetect = true, priority = 2, refire = 1000}, -- Baleful Call (Dire Wolf)
    
    [85201] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Bite (Nix-Ox)
    [85084] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 750 }, -- Shriek (Nix-Ox)
    [90765] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 1000 }, -- Acid Spray (Nix-Ox)
    [90809] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 1000 }, -- Acid Spray (Nix-Ox)
    [85172] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true }, -- Winnow (Nix-Ox)
    [85203] = { power = true, auradetect = true, priority = 2, refire = 1000 }, -- Nix-Call (Nix-Ox)
    
    [85395] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3 }, -- Dive (Cliff Strider)
    [85399] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true }, -- Retch (Cliff Strider)
    [85390] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, refire = 750 }, -- Slash (Cliff Strider)
    
    -- INSECTS
    [6137] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Laceration (Assassin Beetle)
    [5268] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Collywobbles (Assassin Beetle)
    
    [6757] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Blurred Strike (Giant Scorpion)
    [6756] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3 }, -- Paralyze (Giant Scorpion)
    [6758] = { power = true, auradetect = true, refire = 1000, priority = 2, ignoreRefresh = true}, -- Hardened Carapace (Giant Scorpion)
    
    [44086] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true, refire = 850 }, -- Fire Runes (Giant Spider)
    [5685] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Corrosive Bite (Giant Spider)
    [8087] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 1200 }, -- Poison Spray (Giant Spider)
    [4737] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true }, -- Encase (Giant Spider)
    [13382] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true }, -- Devour (Giant Spider)
    
    [9226] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Sting (Wasp)
    [48559] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Focused Charge (Giant Wasp)
    [9229] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Inject Larva (Giant Wasp)
    
    [6800] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3 }, -- Bloodletting (Hoarvor)
    [6795] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3}, -- Latch On (Hoarvor)
    
    [61360] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true }, -- Infectious Swarm (Necrotic Hoarvor)
    [61244] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Fevered Retch (Necrotic Hoarvor)
    [61427] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, skipcheck = true, refire = 1000 }, -- Necrotic Explosion (Necrotic Hoarvor)
    
    [48539] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Focused Charge (Kwama Worker)
    
    [9769] = { block = true, dodge = true, avoid = false, interrupt = false, eventdetect = true }, -- Excavation (Kwama Warrior)
    
    [5260] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 750 }, -- Flamethrower (Shalk)
    [5252] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Fire Bite (Shalk)
    [5265] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, skipcheck = true, refire = 4100, notDirect = true}, -- Burning Ground (Shalk)
    
    [8429] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 600}, -- Zap (Thunderbug)
    [26412] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Thunderstrikes (Thunderbug)
    
    [73172] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Swarm (Kotu Gava)
    [73199] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, skipcheck = true, refire = 1000 }, -- Swarmburst (Kotu Gava Broodmother)
    
    [85645] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3 }, -- Bombard (Fetcherfly Nest)
    [87126] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, refire = 8000, skipcheck = true }, -- Heat Vents (Fetcherfly Nest)
    
    [92078] = { destroy = true, refire = 1000, priority = 2, eventdetect = true, skipcheck = true }, -- Colonize (Fetcherfly Hive Golem)
    [87062] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2 }, -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [87030] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2 }, -- Focused Swarm (Fetcherfly Hive Golem)
    
    -- DAEDRA
    [48121] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Heavy Attack (Air Atronach)
    [48137] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Tornado (Air Atronach)
    [51281] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 1500 }, -- Flame Tornado (Air Atronach)
    [50021] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Ice Vortex (Air Atronach)
    [50023] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 1000}, -- Lightning Rod (Air Atronach)
    
    [9747] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 3 }, -- Dire Wound (Banekin)
    [9748] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3 }, -- Envelop (Banekin)
    
    [4799] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true }, -- Tail Spike (Clannfear)
    [93745] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true }, -- Rending Leap (Clannfear)
    
    [26641] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2 }, -- Soul Flame (Daedric Titan)
    [26554] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 2 }, -- Wing Gust (Daedric Titan)
    
    [26324] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3 }, -- Lava Geyser (Flame Atronach)
    [50216] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, skipcheck = true, refire = 1000 }, -- Combustion (Flame Atronach)
    
    [5017] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2 }, -- Hoarfrost Fist (Frost Atronach)
    [33502] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2 }, -- Frozen Ground (Frost Atronach)
    
    [11079] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 2, eventdetect = true }, -- Black Winter (Harvester)
    
    [91848] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true }, -- Stomp (Ogrim)
    [91855] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3 }, -- Boulder Toss (Ogrim)
    
    [6166] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Heat Wave (Scamp) 
    [6160] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true}, -- Rain of Fire (Scamp) 
    
    [8779] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true }, -- Lightning Onslaught (Spider Daedra)
    [89306] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3 }, -- Web (Spiderling)
    [8782] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3 }, -- Lightning Storm (Spider Daedra)
    
    [35220] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 2, eventdetect = true }, -- Impending Storm (Storm Atronach)
    [4864] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 2, skipcheck = true }, -- Storm Bound (Storm Atronach)
    
    [7095] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true }, -- Heavy Attack (Xivilai)
    [88947] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3 }, -- Lightning Grasp (Xivilai)
    [7100] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3 }, -- Hand of Flame (Xivilai)
    
    [6410] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true }, -- Tail Clip (Winged Twilight)
    [6412] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3 }, -- Dusk's Howl (Winged Twilight)
    
    
    -- FLESH COLOSSUS (100% GOOD)
    [67870] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2 }, -- Tremor AOE (Flesh Colossus)
    [66869] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2 }, -- Pin (Flesh Colossus)
    [67872] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2 }, -- Sweep (Flesh Colossus)
    [76139] = { block = true, dodge = true, interrupt = false, priority = 2, auradetect = true }, -- Stumble Forward (Flesh Colossus)
    
    [8205] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true}, -- Regeneration (Ogrim)
    [48553] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Focused Charge (Ogrim)
    
    
    -- MONSTERS
    [43809] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true}, -- Shard Burst (Ice Wraith)
    [48549] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, auradetect = true}, -- Focused Charge (Ice Wraith)
    
    --------------------------------------------------
    -- MAIN QUEST ------------------------------------
    --------------------------------------------------
    
   -- [61748] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 1}, -- Heavy Attack (Tutorial) -- Default game tutorials display regardless
   -- [61916] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 1}, -- Heat Wave (Tutorial) -- Default game tutorials display regardless

    [63737] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Heavy Attack (Tutorial)
    [63684] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Uppercut (Tutorial)
    [63761] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Pound (Tutorial)
    [63752] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Vomit (Tutorial)
    [63755] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Heat Wave (Tutorial)

    --------------------------------------------------
    -- VVARDENFELL -----------------------------------
    --------------------------------------------------
    
    -- Tutorial
    -- [83416] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 1}, -- Heavy Attack (Tutorial) -- Default game tutorials display regardless
    -- [92233] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 1}, -- Throw Dagger (Tutorial) -- Default game tutorials display regardless
    [63269] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Heat Wave (Tutorial)
    
    -- Main Quest
    [87958] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 2 }, -- Ash Storm (Divine Delusions)
    [90139] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = true }, -- Empowered Strike (Divine Intervention)
    [90181] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2 , refire = 1500 }, -- Oily Smoke (Divine Restoration) 
    [87038] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = true}, -- Spinning Blades (Divine Restoration)
    [87047] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, refire = 1500 }, -- Lunge (Divine Restoration)
    [87090] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2}, -- Barbs (Divine Restoration)
    [90616] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, refire = 10000, skipcheck = true}, -- Divine Hijack (Divine Restoration)
    
    -- Sidequests
    [92720] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2}, -- Necrotic Wave (Ancestral Adversity)
    [77541] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2}, -- Brand's Cleave (The Heart of a Telvanni)
    
    -- Delves/Public Dungeons/World
    [88427] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Charge (Kwama Worker - Matus-Akin Egg Mine)
    
    [87276] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Chomp (Kagouti Whelp)
    
    [86983] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 2}, -- Succubus Touch (Echoes of a Fallen House)
    [86930] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 2}, -- Volcanic Debris (The Forgotten Wastes)
    [92702] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 2}, -- Volcanic Debris (The Forgotten Wastes)
    
    [89210] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Boulder Toss (Nchuleftingth - Mud-Tusk)

    [86570] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Shield Charge (Nchuleftingth - Renduril the Hammer)
    [90597] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2}, -- Overcharge Expulsion
}


--[[

-- Add IF needed for custom exploit messages

E.CombatAlertExploit = {

[45902] = true

}
]]--

--[[ NOTES

63269 - Remove block + add avoid if ever corrected!


]]--