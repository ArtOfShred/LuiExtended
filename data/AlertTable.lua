------------------
-- AlertTable namespace
LUIE.AlertTable = {}

-- Performance Enhancement
local U = LUIE.UnitNames
local A = LUIE.GetAbility()

local AlertTable = {
    -- PRIORITY NOTES:
    -- 1 = VMA/Trial/Dungeon
    -- 2 = ELITE NPC/QUEST BOSS
    -- 3 = Normal NPC

    -- bs = true -- Add indicator for Block Stagger to effect
    -- auradetect = true -- Detect aura application rather than using targeting info
    -- eventdetect = true -- Detect combat event application rather than using targeting info
    -- refire = "x" -- refire duration
    -- fakeName = string -- Set this name for the source
    -- skipcheck = true -- display on any event fired rather than just event started

    -- TEMPLATE
    -- [00000] = { block = false, dodge = false, avoid = false, interrupt = false, priority = 3}, --
    -- TEMPLATE

    -- skipcheck -- DEPRICATE
    -- eventDetect -- doesn't need a result, ignoreRefresh = ignores refresh event here
    -- result = ONLY ON THIS ACTION RESULT!!!!

    --------------------------------------------------
    -- JUSTICE NPC'S ---------------------------------
    --------------------------------------------------

    [63157] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = true, result = ACTION_RESULT_BEGIN }, -- Heavy Blow (Justice Guard 1H)
    [63261] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = true, result = ACTION_RESULT_BEGIN }, -- Heavy Blow (Justice Guard 2H)
    [63179] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 2, bs = false, result = ACTION_RESULT_BEGIN }, -- Flame Shard (Justice Guard 2H)
    [78743] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, bs = false, result = ACTION_RESULT_BEGIN }, -- Flare (Justice Guard - Any)

    [74862] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, bs = false, result = ACTION_RESULT_BEGIN }, -- Teleport Trap (Mage Guard)

    [62409] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true, refire = 1500, result = ACTION_RESULT_BEGIN }, -- Fiery Wind (Justice Mage NPC)
    [62472] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Stab (Justice Dagger NPC)

    [78265] = { power = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Alarm (Estate Marshal) (DB DLC)

    [52471] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Nullify (Estate Spellbreaker) (DB DLC)

    [73229] = { power = true, priority = 2, auradetect = true, ignoreRefresh = true }, -- Hurried Ward (Guard - DB Mage)

    --------------------------------------------------
    -- STANDARD NPC'S --------------------------------
    --------------------------------------------------

    -- Shared
    [39058] = { avoid = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN, notDirect = true }, -- Bear Trap (Bear Trap)

    -- Synergy
    [12439] = { avoid = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Burning Arrow (Synergy)
    [10805] = { avoid = true, interrupt = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Ignite (Synergy)

    -- Abilities
    [29378] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Uppercut (Ravager)

    [28408] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Whirlwind (Skirmisher)

    [37108] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Arrow Spray (Archer)
    [28628] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Volley (Archer)
    [74978] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Taking Aim (Archer)

    [14096] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Heavy Attack (Footsoldier)
    [28499] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Throw Dagger (Footsoldier)

    [29400] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Power Bash (Guard)
    [29761] = { power = true, priority = 3, auradetect = true }, -- Brace (Guard)

    [13701] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, bs = true, result = ACTION_RESULT_BEGIN }, -- Focused Charge (Brute)

    [35164] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Agony (Berserker)

    [29510] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Thunder Hammer (Thundermaul)
    [17867] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Shock Aura (Thundermaul)
    [81215] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Shock Aura (Thundermaul - Boss)
    [81195] = { avoid = true, priority = 2, auradetect = true, notDirect = true }, -- Agonizing Fury (Thundermaul - Boss)
    [81217] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Thunder Hammer (Thundermaul - Boss)

    [36470] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Veiled Strike (Nightblade)
    [44345] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Soul Tether (Nightblade)

    [34742] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Fiery Breath (Dragonknight)
    [34646] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Lava Whip (Dragonknight)
    [44227] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Dragonknight Standard (Dragonknight - Elite)
    [52041] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, bs = true, result = ACTION_RESULT_BEGIN }, -- Blink Strike (Dragonknight - Elite)

    [88251] = { summon = true, priority = 2, auradetect = true }, -- Call Ally (Pet Ranger)
    [88248] = { summon = true, priority = 2, auradetect = true }, -- Call Ally (Pet Ranger)
    [89425] = { summon = true, priority = 2, auradetect = true }, -- Call Ally (Pet Ranger)
    [44301] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 3, auradetect = true , ignoreRefresh = true }, -- Trap Beast (Pet Ranger)

    [15164] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Heat Wave (Fire Mage)
    [47095] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Fire Rune (Fire Mage)

    [29471] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Thunder Thrall (Storm Mage)

    [12459] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Winter's Reach (Frost Mage)

    [35151] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true }, -- Spell Absorption (Spirit Mage)
    [14472] = { summon = true, priority = 2, auradetect = true }, -- Burdening Eye (Spirit Mage)

    [14370] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, auradetect = true }, -- Void (Time Bomb Mage)

    [37087] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Lightning Onslaught (Battlemage)
    [37129] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Ice Cage (Battlemage)
    [44216] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Negate Magic (Battlemage - Elite)

    [88554] = { summon = true, priority = 2, auradetect = true }, -- Summon the Dead (Necromancer)
    [88555] = { summon = true, priority = 2, auradetect = true }, -- Summon the Dead (Necromancer)
    [88556] = { summon = true, priority = 2, auradetect = true }, -- Summon the Dead (Necromancer)
    [13397] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, notDirect = true, result = ACTION_RESULT_BEGIN, refire = 1000 }, -- Empower Undead (Necromancer)

    [14350] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Aspect of Terror (Fear Mage)

    [44250] = { summon = true, priority = 2, auradetect = true }, -- Dark Shade (Dreadweaver)

    [35387] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Defiled Grave (Bonelord)
    [88506] = { summon = true, priority = 2, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Summon Abomination (Bonelord)
    [88507] = { summon = true, priority = 2, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Summon Abomination (Bonelord)

    [50966] = { power = true, auradetect = true, priority = 2 }, -- Healer Immune (Healer - Craglorn/DLC)
    [44328] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 2, auradetect = true, notDirect = true }, -- Rite of Passage (Healer)

    [29520] = { destroy = true, auradetect = true, priority = 2 }, -- Aura of Protection (Shaman)

    [68866] = { power = true, auradetect = true, refire = 1000, priority = 2 }, -- War Horn (Faction NPC)
    [43644] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Barrier [monster synergy]  (Faction NPCs)
    [43645] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Barrier [monster synergy]  (Faction NPCs)
    [43646] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Barrier [monster synergy]  (Faction NPCs)

    [70070] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Heavy Strike (Winterborn Warrior)
    [64980] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Javelin (Winterborn Warrior)
    [65033] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Retaliation (Winterborn Warrior)

    [55909] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Grasping Vines (Winterborn Mage)
    [64704] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true, refire = 1500, result = ACTION_RESULT_BEGIN }, -- Flames (Winterborn Mage)

    [65235] = { power = true, auradetect = true, priority = 2 }, -- Enrage (Vosh Rakh Devoted)
    [53987] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, notDirect = true, result = ACTION_RESULT_BEGIN }, -- Rally (Vosh Rakh Devoted)
    [54027] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, refire = 1600, result = ACTION_RESULT_BEGIN }, -- Divine Leap (Vosh Rakh Devoted)

    [51000] = { power = true, auradetect = true, priority = 2 }, -- Cleave Stance (Dremora Caitiff) (Craglorn)

    [72725] = { power = true, auradetect = true, priority = 2 }, -- Fool Me Once (Sentinel) (TG DLC)

    [76089] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Snipe (Archer) (TG DLC)
    --[72220] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Snipe (Archer) (TG DLC) -- This is cast from stealth - so for the time being, maybe hide.
    [72222] = { power = true, auradetect = true, priority = 2 }, -- Shadow Cloak (Archer) (TG DLC)

    [77472] = { power = true, auradetect = true, priority = 2 }, -- Til Death (Bodyguard) (DB DLC)
    [77554] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, notDirect = true, result = ACTION_RESULT_BEGIN }, -- Shard Shield (Bodyguard) (DB DLC)
    [77473] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Shield Charge (Bodyguard) (DB DLC)

    [77089] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Basilisk Powder (Tracker) (Morrowind)
    [77087] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Basilisk Powder (Tracker) (Morrowind)
    [77019] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Pin (Tracker) (Morrowind)
    [78432] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Lunge (Tracker) (Morrowind)

    [88371] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Dive (Beastcaller) (Morrowind)
    [88394] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Gore (Beastcaller) (Morrowind)
    [88409] = { summon = true, priority = 2, auradetect = true }, -- Raise the Earth (Beastcaller)

    [87901] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Bombard (Arbalest) (Morrowind)
    [87422] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Chilled Ground (Arbalest) (Morrowind)
    [87713] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Quakeshot (Arbalest) (Morrowind)

    [85359] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Reverse Slash (Drudge)

    [87064] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Volcanic Debris (Fire-Binder) (Morrowind)
    [88845] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, notDirect = true, auradetect = true }, -- Empower Atronach (Fire-Binder) (Morrowind)

    [76621] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Shadeway (Voidbringer) (Morrowind)
    [76619] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Pool of Shadow (Voidbringer) (Morrowind)
    [76979] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Shadowy Duplicate (Voidbringer) (Morrowind)

    [88327] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Shadeway (Skaafin Masquer) (Morrowind)
    [88325] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Pool of Shadow (Skaafin Masquer) (Morrowind)
    [88348] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Shadowy Duplicate (Skaafin Masquer) (Morrowind)

    [84818] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, notDirect = true, auradetect = true }, -- Fiendish Healing (Skaafin Witchling) (Morrowind)

    [84835] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true }, -- Broken Pact (Skaafin) (Morrowind)

    -- ANIMALS
    [5452] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Lacerate (Alit)

    [4415] = { block = true, dodge = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Crushing Swipe (Bear)
    [4416] = { block = true, dodge = true, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Savage Blows (Bear)

    [70366] = { block = true, dodge = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Slam (Great Bear)

    [4591] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Sweep (Crocodile)
    [4594] = { power = true, auradetect = true, priority = 2, ignoreRefresh = true, refire = 500 }, -- Ancient Skin (Crocodile)

    [8977] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Sweep (Duneripper)

    [7227] = { block = true, dodge = true, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Rotbone (Durzog)

    [6308] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Shocking Touch (Dreugh)
    [6328] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN, refire = 2000 }, -- Shocking Rake (Dreugh)

    [54375] = { avoid = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Shockwave (Echatere)
    [54380] = { block = true, dodge = true, priority = 3, bs = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Headbutt (Echatere)

    [4632] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Screech (Giant Bat)
    [4630] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, refire = 1500, result = ACTION_RESULT_BEGIN }, -- Draining Bite (Giant Bat)

    [5240] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Lash (Giant Snake)
    [5242] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Kiss of Poison (Giant Snake)
    [5244] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true }, -- Shed Skin (Giant Snake)

    [5441] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Dive (Guar)

    [14196] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Charge (Kagouti)
    [5363] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Chomp (Kagouti)
    [5926] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Toss (Kagouti)
    [87276] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Chomp (Kagouti Whelp)

    [7161] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Double Strike (Lion)

    [8601] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN, refire = 600 }, -- Vigorous Swipe (Mammoth)
    [8600] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_EFFECT_GAINED }, -- Stomp (Mammoth)
    [23230] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Charge (Mammoth)

    [4200] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Unforgiving Claws (Mudcrab)

    [16690] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Thrust (Netch)
    [16697] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN, refire = 1800 }, -- Poisonbloom (Netch)

    [7268] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 500, result = ACTION_RESULT_BEGIN }, -- Leech
    [7273] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Dampworm (Nix-Hound)

    [21904] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Rend (Skeever)

    [21951] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Repulsion Shock (Wamasu)
    [21949] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Sweep (Wamasu)
    [21957] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Charge (Wamasu)
    [22045] = { power = true, auradetect = true, priority = 2 }, --- Static (Wamasu)

    [44791] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Rear Kick (Welwa)
    [50714] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true }, -- Charge (Welwa)

    [42844] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Rotbone (Wolf)
    [14523] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, refire = 1000, result = ACTION_RESULT_BEGIN }, -- Helljoint (Wolf)
    [14272] = { summon = true, auradetect = true, priority = 2 }, -- Call of the Pack (Wolf)
    [26658] = { summon = true, auradetect = true, priority = 2 }, -- Call of the Pack (Jackal)

    [72793] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Toxic Mucus (Haj Mota)
    [72796] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Bog Burst (Haj Mota)
    [72789] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Shockwave (Haj Mota)

    [76307] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Lunge (Dire Wolf)
    [76324] = { power = true, auradetect = true, priority = 2, refire = 1000 }, -- Baleful Call (Dire Wolf)

    [85201] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Bite (Nix-Ox)
    [85084] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 750, result = ACTION_RESULT_BEGIN }, -- Shriek (Nix-Ox)
    [90765] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 1000, result = ACTION_RESULT_BEGIN }, -- Acid Spray (Nix-Ox)
    [90809] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 1000, result = ACTION_RESULT_BEGIN }, -- Acid Spray (Nix-Ox)
    [85172] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Winnow (Nix-Ox)
    [85203] = { power = true, auradetect = true, priority = 2, refire = 1000 }, -- Nix-Call (Nix-Ox)

    [85395] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Dive (Cliff Strider)
    [85399] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Retch (Cliff Strider)
    [85390] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, refire = 750, result = ACTION_RESULT_BEGIN }, -- Slash (Cliff Strider)

    -- INSECTS
    [6137] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Laceration (Assassin Beetle)
    [5268] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Collywobbles (Assassin Beetle)

    [6757] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Blurred Strike (Giant Scorpion)
    [6756] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Paralyze (Giant Scorpion)
    [6758] = { power = true, auradetect = true, priority = 2, ignoreRefresh = true, refire = 500 }, -- Hardened Carapace (Giant Scorpion)

    [44086] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true, ignoreRefresh = true }, -- Fire Runes (Giant Spider)
    [5685] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Corrosive Bite (Giant Spider)
    [8087] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 1200, result = ACTION_RESULT_BEGIN }, -- Poison Spray (Giant Spider)
    [4737] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Encase (Giant Spider)
    [13382] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN, notDirect = true }, -- Devour (Giant Spider)

    [9226] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Sting (Wasp)
    [25110] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Focused Charge (Giant Wasp)
    [9229] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Inject Larva (Giant Wasp)

    [6800] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Bloodletting (Hoarvor)
    [6795] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Latch On (Hoarvor)

    [61244] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Fevered Retch (Necrotic Hoarvor)
    [61360] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Infectious Swarm (Necrotic Hoarvor)
    [61427] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Necrotic Explosion (Necrotic Hoarvor)

    [14841] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Focused Charge (Kwama Worker)

    [9769] = { block = true, dodge = true, avoid = false, interrupt = false, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Excavation (Kwama Warrior)

    [5260] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 750, result = ACTION_RESULT_BEGIN }, -- Flamethrower (Shalk)
    [5252] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Fire Bite (Shalk)
    [5262] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, notDirect = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Burning Ground (Shalk)

    [8429] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 750, result = ACTION_RESULT_BEGIN }, -- Zap (Thunderbug)
    [26412] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Thunderstrikes (Thunderbug)

    [73172] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN  }, -- Swarm (Kotu Gava Broodmother)
    [73199] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Swarmburst (Kotu Gava Broodmother)

    [85645] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Bombard (Fetcherfly Nest)
    [87125] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Heat Vents (Fetcherfly Nest)

    [92078] = { destroy = true, priority = 2, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Colonize (Fetcherfly Hive Golem)
    [87062] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [87030] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Focused Swarm (Fetcherfly Hive Golem)

    -- DAEDRA
    [31115] = { destroy = true, refire = 1000, priority = 2, auradetect = true }, -- Summon Dark Anchor (Daedric Synergy)
    [68449] = { avoid = true, refire = 1000, priority = 3 }, -- Explosive Charge (Daedric Synergy)

    [48121] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Heavy Attack (Air Atronach)
    [48137] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Tornado (Air Atronach)

    [51262] = { power = true, auradetect = true, priority = 2 }, -- Air Atronach Flame (Air Atronach)
    [51271] = { power = true, auradetect = true, priority = 2 }, -- Air Atronach Flame (Air Atronach)
    [51269] = { power = true, auradetect = true, priority = 2 }, -- Air Atronach Flame (Air Atronach)

    [51281] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN, refire = 1500 }, -- Flame Tornado (Air Atronach)
    [50021] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Ice Vortex (Air Atronach)
    [50023] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 800, result = ACTION_RESULT_BEGIN }, -- Lightning Rod (Air Atronach)

    [9747] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Dire Wound (Banekin)
    [9748] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Envelop (Banekin)

    [4799] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Tail Spike (Clannfear)
    [93745] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Rending Leap (Clannfear)

    [26641] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Soul Flame (Daedric Titan)
    [26554] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Wing Gust (Daedric Titan)

    [4771] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, refire = 1250, result = ACTION_RESULT_BEGIN },-- Fiery Breath (Daedroth)
    [91946] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Ground Tremor (Daedroth)
    [91937] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Burst of Embers (Daedroth)

    [26324] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Lava Geyser (Flame Atronach)
    [50216] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, refire = 250 }, -- Combustion (Flame Atronach)

    [5017] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Hoarfrost Fist (Frost Atronach)
    [33502] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Frozen Ground (Frost Atronach)

    [50626] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Shadow Strike (Grevious Twilight)
    [65889] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Shadow Strike (Grevious Twilight)

    [4829] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Fire Brand (Flesh Atronach)
    [4817] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Unyielding Mace (Flesh Atronach)

    [67870] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Tremor AOE (Flesh Colossus)
    [66869] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Pin (Flesh Colossus)
    [67872] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Sweep (Flesh Colossus)
    [76139] = { block = true, dodge = true, interrupt = false, priority = 2, auradetect = true }, -- Stumble Forward (Flesh Colossus)
    --[67772] = { power = true, priority = 2, auradetect = true }, -- Enraged (Flesh Colossus)
    [49430] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Smash (Flesh Colossus)
    [49429] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Claw (Flesh Colossus)

    [11079] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Black Winter (Harvester)

    [8205] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true }, -- Regeneration (Ogrim)
    [24690] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Focused Charge (Ogrim)
    [91848] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Stomp (Ogrim)
    [91855] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Boulder Toss (Ogrim)

    [6166] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Heat Wave (Scamp)
    [6160] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Rain of Fire (Scamp)

    [8779] = { block = true, dodge = false, avoid = false, interrupt = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Lightning Onslaught (Spider Daedra)
    [89306] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Web (Spiderling)
    [8782] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Lightning Storm (Spider Daedra)
    [8773] = { summon = true, priority = 2, auradetect = true }, -- Summon Spiderling (Spider Daedra)

    [35220] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Impending Storm (Storm Atronach)
    [4864] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 2, result = ACTION_RESULT_EFFECT_GAINED, refire = 100 }, -- Storm Bound (Storm Atronach)

    [7095] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Heavy Attack (Xivilai)
    [88947] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Lightning Grasp (Xivilai)
    [7100] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Hand of Flame (Xivilai)
    [25726] = { summon = true, priority = 2, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Summon Daedra (Xivilai)

    [4653] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true }, -- Shockwave (Watcher)
    [9219] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2, eventdetect = true, refire = 1750 }, -- Doom-Truth's Gaze (Watcher)
    [14425] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2 }, -- Doom-Truth's Gaze (Watcher)

    [6410] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Tail Clip (Winged Twilight)
    [6412] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Dusk's Howl (Winged Twilight)

    [94903] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Spring (Hunger)
    [87237] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Spring (Hunger)
    [87247] = { block = true, refire = 400, priority = 2, result = ACTION_RESULT_BEGIN }, -- Devour (Hunger)
    [84944] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Hollow (Hunger)
    [87269] = { avoid = true, eventdetect = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Torpor (Hunger)

    [88282] = { avoid = true, eventdetect = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Rock Stomp (Iron Atronach)
    [88261] = { block = true, eventdetect = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Lava Wave (Iron Atronach)
    [88297] = { avoid = true, auradetect = true, priority = 2 }, -- Blast Furnace (Iron Atronach)

    -- UNDEAD
    [8569] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Devastating Leap (Bloodfiend)

    [5050] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Bone Saw (Bone Colossus)
    [5030] = { summon = true, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Voice to Wake the Dead (Bone Colossus)
    [17207] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, auradetect = true }, -- Necromantic Implosion (Risen Dead)

    [18514] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Chill Touch (Ghost)
    [19137] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Haunting Spectre (Ghost)

    [73925] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2, result = ACTION_RESULT_BEGIN }, -- Soul Cage (Lich)

    [50182] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Consuming Energy (Spellfiend)

    [68735] = { interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Vampiric Drain (Vampire)

    [2867] = { block = true, bs = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Crushing Leap (Werewolf)
    [3415] = { block = true, dodge = true, priority = 3, eventdetect = true, refire = 1100, result = ACTION_RESULT_BEGIN }, -- Flurry (Werewolf)
    [44055] = { interrupt = true, priority = 3, eventdetect = true, notDirect = true, result = ACTION_RESULT_BEGIN }, -- Devour (Werewolf)
    --[5785] = { power = true, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Blood Scent (Werewolf)

    [4337] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Winter's Reach (Wraith)

    [2969] = { block = true, dodge = true, avoid = false, interrupt = false, bs = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Pound (Zombie)
    [2960] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Vomit (Zombie)

    [72979] = { block = true, bs = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Dissonant Blow (Defiled Aegis)
    [72995] = { interrupt = true, dodge = true, priority = 2, eventdetect = true, refire = 1100, result = ACTION_RESULT_BEGIN }, -- Symphony of Blades (Defiled Aegis) -- Higher priority because damage is very high
    [76180] = { power = true, auradetect = true, priority = 2 }, -- Shattered Harmony (Defiled Aegis)

    -- MONSTERS
    [10270] = { block = true, avoid = true, priority = 2, eventdetect = true, refire = 1000, result = ACTION_RESULT_BEGIN }, -- Quake (Gargoyle)
    [10256] = { block = true, bs = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Lacerate (Gargoyle)

    [26124] = { avoid = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Shatter (Giant)
    [15715] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Shatter (Giant)

    [2786] = { interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN, refire = 1250 }, -- Steal Essence (Hag)
    [2821] = { block = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Luring Snare (Hag)
    [3349] = { power = true, priority = 2, auradetect = true }, -- Reflective Shadows (Hag)

    [10615] = { avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Raven Storm (Hagraven)
    [10613] = { avoid = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Fire Bomb (Hagraven)
    [64808] = { power = true, priority = 2, auradetect = true }, -- Briarheart Ressurection (Hagraven)

    [4123] = { block = true, bs = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Wing Slice (Harpy)
    [13515] = { block = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Wind Gust (Harpy)
    [24604] = { avoid = true, interrupt = true, eventdetect = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Charged Ground (Harpy)
    [4689] = { avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Lightning Gale (Harpy)

    [43809] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true }, -- Shard Burst (Ice Wraith)
    [24866] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Focused Charge (Ice Wraith)

    [17703] = { block = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN, refire = 750 }, -- Flame Ray (Imp - Fire)
    [8884] = { block = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN, refire = 750 }, -- Zap (Imp - Lightning)
    [81794] = { block = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN, refire = 750 }, -- Frost Ray (Imp - Frost)

    [9671] = { block = true, bs = true, eventdetect = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Howling Strike (Lamia)
    [9674] = { avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Resonate (Lamia)
    [7835] = { interrupt = true, notDirect = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Convalescence (Lamia)
    [7831] = { interrupt = true, notDirect = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN, refire = 2500 }, -- Harmony (Lamia)
    [9680] = { summon = true, auradetect = true, priority = 2 }, -- Summon Spectral Lamia

    [3860] = { block = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Pulverize (Lurcher)
    [3855] = { block = true, bs = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Crushing Limbs (Lurcher)
    [3767] = { avoid = true, interrupt = true, priority = 3, eventdetect = true, refire = 1100, result = ACTION_RESULT_BEGIN }, -- Choking Pollen (Lurcher)

    [5559] = { avoid = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Icy Geyser (Nereid)
    [5540] = { avoid = true, interrupt = true, priority = 3, auradetect = true }, -- Hurricane (Nereid)

    [24985] = { power = true, auradetect = true, priority = 3 }, -- Intimidating Roar (Ogre)
    [5881] = { block = true, bs = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Smash (Ogre)
    [5256] = { block = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Shockwave (Ogre)

    [53142] = { destroy = true, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Ice Pillar (Ogre Shaman)
    [64540] = { interrupt = true, priority = 3, eventdetect = true, notDirect = true, result = ACTION_RESULT_BEGIN }, -- Freeze Wounds (Ogre Shaman)
    [53137] = { interrupt = true, priority = 3, eventdetect = true, notDirect = true, result = ACTION_RESULT_BEGIN }, -- Freeze Wounds (Ogre Shaman)

    [21582] = { block = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Nature's Swarm (Spriggan)
    [13475] = { interrupt = true, priority = 3, auradetect = true, notDirect = true }, -- Healing Salve (Spriggan)
    [13477] = { interrupt = true, priority = 3, eventdetect = true, notDirect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Control Beast (Spriggan)
    [89119] = { summon = true, priority = 2, auradetect = true }, -- Summon Beast (Spriggan)
    [89102] = { summon = true, priority = 2, auradetect = true }, -- Summon Beast (Spriggan)

    [9346] = { interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Strangle (Strangler)
    [9322] = { avoid = true, priority = 3, auradetect = true }, -- Poisoned Ground (Strangler)
    [9321] = { block = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Grapple (Strangler)

    [44736] = { block = true, dodge = true, priority = 2, eventdetect = true, refire = 2000, result = ACTION_RESULT_BEGIN }, -- Swinging Cleave (Troll)
    [9009] = { avoid = true, priority = 2, eventdetect = true, refire = 300, result = ACTION_RESULT_BEGIN }, -- Tremor (Troll)

    [76268] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Lope (River Troll)
    [76277] = { interrupt = true, notDirect = true, priority = 2, eventdetect = true, refire = 1000, result = ACTION_RESULT_BEGIN }, -- Close Wounds (River Troll)
    [76295] = { block = true, avoid = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Crab Toss (River Troll)

    [48256] = { block = true, avoid = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Boulder Toss (Troll - Ranged)
    [48282] = { interrupt = true, avoid = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Consuming Omen (Troll - Ranged)

    [4309] = { block = true, avoid = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Dying Blast (Wisp)

    [7976] = { avoid = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Rain of Wisps (Wispmother)
    [18040] = { power = true, priority = 2, auradetect = true }, -- Clone (Wispmother)

    [75867] = { block = true, bs = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Clobber (Minotaur)
    [75917] = { block = true, dodge = true, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Ram (Minotaur)
    [79541] = { block = true, dodge = true, priority = 2, auradetect = true, result = ACTION_RESULT_BEGIN }, -- Flying Leap (Minotaur)
    [75925] = { power = true, auradetect = 2, priority = 2, ignoreRefresh = true }, -- Elemental Weapon (Minotaur)

    [75951] = { avoid = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Brimstone Hailfire (Minotaur Shaman)
    [75955] = { avoid = true, priority = 2, eventdetect = true, refire = 1000, result = ACTION_RESULT_BEGIN }, -- Pillars of Nirn (Minotaur Shaman)
    [75994] = { power = true, priority = 2, auradetect = true, ignoreRefresh = true }, -- Molten Armor (Minotaur Shaman)

    [49499] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Spear Throw (Mantikora)
    [49404] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Rear Up (Mantikora)
    [49402] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Tail Whip (Mantikora)
    [50187] = { power = true, priority = 2, auradetect = true }, -- Enrage (Mantikora)
    [56689] = { power = true, priority = 2, auradetect = true }, -- Enraged (Mantikora)

    [104479] = { block = true, bs = true, dodge = true, interrupt = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Reave (Yaghra Strider)
    [105214] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Lunge (Yaghra Strider)
    [105330] = { interrupt = true, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN, notDirect = true }, -- Frenzy (Yaghra Strider)

    [103804] = { interrupt = true, avoid = true, eventdetect = true, priority = 2, result = ACTION_RESULT_BEGIN, refire = 800 }, -- Deluge (Yaghra Strider)
    [103931] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Luminescent Mark (Yaghra Spewer)

    -- DWEMER
    [16031] = { avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Ricochet Wave (Dwemer Sphere)
    [7520] = { block = true, bs = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Steam Wall (Dwemer Sphere)
    [7544] = { block = true, dodge = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Quake (Dwemer Sphere)

    [11247] = { block = true, dodge = true, priority = 2, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Sweeping Spin (Dwemer Centurion)
    [11246] = { avoid = true, priority = 2, eventdetect = true, refire = 2000, result = ACTION_RESULT_BEGIN }, -- Steam Breath (Dwemer Centurion)

    [20507] = { block = true, bs = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Double Strike (Dwemer Spider)
    [7717] = { block = true, avoid = true, priority = 3, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Detonation (Dwemer Spider)
    [19970] = { power = true, priority = 3, auradetect = true }, -- Static Field (Dwemer Spider - Overcharge Synergy)
    --[20207] = { interrupt = true, priority = 3, eventdetect = true, notDirect = true }, -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20505] = { block = true, avoid = true, priority = 3, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, refire = 250 }, -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20222] = { block = true, avoid = true, priority = 3, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, refire = 250 }, -- Overcharge (Dwemer Spider - Overcharge Synergy)

    [64479] = { block = true, avoid = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Thunderbolt (Dwemer Sentry)

    [88668] = { block = true, avoid = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Impulse Mine (Dwemer Arquebus)
    [85270] = { interrupt = true, priority = 3, refire = 1500, result = ACTION_RESULT_BEGIN }, -- Shock Barrage (Dwemer Arquebus)
    [85319] = { avoid = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Siege Ballista (Dwemer Arquebus)
    [85326] = { interrupt = true, priority = 3, eventdetect = true, refire = 1000, notDirect = true, result = ACTION_RESULT_BEGIN }, -- Polarizing Field (Dwemer Arquebus)

    --------------------------------------------------
    -- FRIENDLY NPC ----------------------------------
    --------------------------------------------------

    [42905] = { power = true, priority = 1, auradetect = true }, -- Recover (Friendly NPC)

    --------------------------------------------------
    -- MAIN QUEST ------------------------------------
    --------------------------------------------------

    -- MSQ Tutorial (Soul Shriven in Coldharbour)
    -- [61748] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 1}, -- Heavy Attack (Tutorial) -- Default game tutorials display regardless
    -- [61916] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 1}, -- Heat Wave (Tutorial) -- Default game tutorials display regardless
    [63269] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Heat Wave (Tutorial)
    [63737] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Heavy Attack (Tutorial)
    [63684] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Uppercut (Tutorial)
    [63761] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, result = ACTION_RESULT_BEGIN }, -- Pound (Tutorial)
    [63752] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, result = ACTION_RESULT_BEGIN }, -- Vomit (Tutorial)
    [63755] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Heat Wave (Tutorial)
    [63521] = { block = true, dodge = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Bone Crush (Tutorial)

    -- MSQ 2 (Daughter of Giants)
    [27767] = { block = true, bs = true, dodge = true, priority = 2 }, -- Rending Leap (Ancient Clannfear)
    [28788] = { block = true, priority = 2, eventdetect = true }, -- MQ2_Boss1_Doom-Truth'sGaze (Manifestation of Terror)
    [28723] = { avoid = true, priority = 2, eventdetect = true, refire = 500 }, -- Gravity Well (Manifestation of Terror)

    -- MSQ 4 (Castle of the Worm)
    [34484] = { block = true, avoid = true, priority = 2, skipcheck = true, refire = 500 }, -- Soul Cage (Mannimarco)

    -- MSQ 6 (Halls of Torment)
    [36858] = { interrupt = true, avoid = true, priority = 2, eventdetect = true, refire = 1500 }, -- Swordstorm (Tharn Doppleganger)
    [37173] = { interrupt = true, priority = 2, eventdetect = true, notDirect = true }, -- Flame Shield (Duchess of Anguish)
    [38729] = { block = true, interrupt = true, priority = 2, refire = 500 }, -- Royal Strike (Duchess of Anguish)

    -- MSQ 7 (Shadow of Sancre Tor)
    [39302] = { interrupt = true, priority = 2, eventdetect = true, notDirect = true, refire = 1000 }, -- Necromantic Revival
    [38215] = { interrupt = true, priority = 2, refire = 1000 }, -- Death's Gaze (Mannimarco)
    [40425] = { avoid = true, priority = 2 }, -- Impending Doom (Mannimarco)
    [40973] = { power = true, priority = 2, eventdetect = true }, -- Portal Spawn (Mannimarco)
    [40978] = { power = true, priority = 2, eventdetect = true }, -- Portal Spawn (Mannimarco)
    [40981] = { power = true, priority = 2, eventdetect = true }, -- Portal Spawn (Mannimarco)

    --------------------------------------------------
    -- GUILD QUESTS ----------------------------------
    --------------------------------------------------

    -- The Prismatic Core
    [39577] = { block = true, interrupt = true, priority = 2 }, -- Palolel's Rage (Queen Palolel)

    -- Will of the Council
    [28939] = { avoid = true, priority = 2, eventdetect = true, refire = 2000 }, -- Heat Wave (Sees-All-Colors)

    -- The Mad God's Bargain
    [39555] = { interrupt = true, priority = 2, eventdetect = true, refire = 1500 }, -- Summon Scamp (Haskill)
    [39527] = { interrupt = true, avoid = true, block = true, priority = 2, refire = 1500 }, -- Skeleton Trap (Haskill)
    [35533] = { interrupt = true, priority = 2, refire = 1500 }, -- Polymorph (Haskill)
    [39391] = { interrupt = true, priority = 2, eventdetect = true, refire = 1500 }, -- Summon Pig (Haskill)

    --------------------------------------------------
    -- AD QUESTS -------------------------------------
    --------------------------------------------------

    -- World Boss - Seaside Scarp Camp
    [84283] = { block = true, dodge = true, priority = 1, eventdetect = true }, -- Coursing Bones (Oskana)

    -- World Boss - Heretic's Summons
    [83150] = { block = true, dodge = true, priority = 1 }, -- Tail Whip (Snapjaw)
    [83009] = { block = true, dodge = true, priority = 1 }, -- Rending Leap (Snapjaw)
    [83040] = { block = true, dodge = true, bs = true, priority = 1, eventdetect = true, skipcheck = true }, -- Focused Charge (Clannfear - Snapjaw)
    [83016] = { block = true, priority = 1, refire = 1000, eventdetect = true, skipcheck = true }, -- Necrotic Explosion (Clannfear - Snapjaw)

    -- Sever All Ties
    [44138] = { interrupt = true, avoid = true, priority = 2, eventdetect = true }, -- Q4261 Estre Knockback (High Kinlady Estre)

    -- World Boss - Nindaeril's Perch
    [83515] = { block = true, bs = true, dodge = true, priority = 1 }, -- Hunter's Pounce (Bavura the Blizzard)
    [83832] = { block = true, dodge = true, priority = 1, eventdetect = true }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83548] = { interrupt = true, avoid = true, priority = 1, eventdetect = true }, -- Mighty Roar (Nindaeril the Monsoon)

    -- The Grips of Madness
    [38748] = { block = true, interrupt = true, priority = 2 }, -- Aulus's Tongue (Mayor Aulus)
    [40702] = { avoid = true, priority = 2, eventdetect = true }, -- Q4868 Aulus Knockback (Mayor Aulus)

    -- The Orrery of Elden Root
    [43820] = { dodge = true, avoid = true, priority = 2, eventdetect = true }, -- Quaking Stomp (Prince Naemon)
    [43827] = { avoid = true, priority = 2, auradetect = true }, -- Projectile Vomit (Prince Naemon)

    -- World Boss - Gathongor's Mine
    [84205] = { avoid = true, priority = 1 }, -- Stinging Sputum (Gathongor the Mauler)
    [84196] = { avoid = true, priority = 1 }, -- Marsh Masher (Gathongor the Mauler)
    [84209] = { block = true, dodge = true, priority = 1 }, -- Wrecking Jaws (Gathongor the Mauler)
    [84212] = { avoid = true, priority = 1 }, -- Bog Slam (Gathongor the Mauler)

    -- World Boss - Thodundor's View
    [83155] = { block = true, bs = true, dodge = true, priority = 1 }, -- Thunderous Smash (Thodundor of the Hill)
    [83160] = { block = true, avoid = true, priority = 1 }, -- Stone Crusher (Thodundor of the Hill)
    [83136] = { block = true, avoid = true, priority = 1 }, -- Ground Shock (Thodundor of the Hill)

    --------------------------------------------------
    -- VVARDENFELL -----------------------------------
    --------------------------------------------------

    -- Tutorial
    -- [83416] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 1}, -- Heavy Attack (Tutorial) -- Default game tutorials display regardless
    -- [92233] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 1}, -- Throw Dagger (Tutorial) -- Default game tutorials display regardless
    [92668] = { block = true, dodge = true, priority = 3, eventdetect = true, result = ACTION_RESULT_BEGIN }, -- Whirlwind (Slaver Cutthroat)

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

    [86983] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 2}, -- Succubus Touch (Echoes of a Fallen House)
    [86930] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 2}, -- Volcanic Debris (The Forgotten Wastes)
    [92702] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 2}, -- Volcanic Debris (The Forgotten Wastes)

    [89210] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Boulder Toss (Nchuleftingth - Mud-Tusk)

    [86570] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Shield Charge (Nchuleftingth - Renduril the Hammer)
    [90597] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 2}, -- Overcharge Expulsion

    --------------------------------------------------
    -- SUMMERSET -------------------------------------
    --------------------------------------------------

    [105601] = { block = true, avoid = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Explosive Toxins (Yaghra Larva)

    [107282] = { block = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Impale (Yaghra Nightmare)
    [105867] = { avoid = true, priority = 2, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Pustulant Explosion (Yaghra Nightmare)

    --------------------------------------------------
    -- ARENAS ----------------------------------------
    --------------------------------------------------

    -- Maelstrom Arena

    [70892] = { avoid = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Bone Cage (Maxus the Many)
    [72148] = { avoid = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Bone Cage (Maxus the Many)
    [67765] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Multiply (Maxus the Many)
    [67656] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Multiply (Maxus the Many)
    [69515] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Multiply (Maxus the Many)
    [67691] = { power = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Reunite (Maxus the Many)

    --------------------------------------------------
    -- DUNGEONS --------------------------------------
    --------------------------------------------------

    -- Banished Cells I
    [47587] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Tail Smite (Shadowrend)
    [21886] = { summon = true, priority = 1, auradetect = true }, -- Summon Dark Proxy (Shadowrend)
    [18772] = { interrupt = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, notDirect = true, bossName = true }, -- Feeding (Shadowrend)
    [18708] = { summon = true, priority = 1, auradetect = true }, -- Summon Clannfear (Angata the Clannfear Handler)
    [19025] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Dead Zone (Skeletal Destroyer)

    [33189] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Crushing Blow (High Kinlord Rilis)
    [18840] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Soul Blast (High Kinlord Rilis)
    [18875] = { avoid = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Daedric Tempest (High Kinlord Rilis)

    -- Banished Cells II
    [49150] = { block = true, avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, refire = 1500, bossName = true }, -- Cone of Rot (Maw of the Infernal)
    [27826] = { block = true, bs = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Crushing Blow (Keeper Voranil)
    [29018] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, refire = 750, eventdetect = true, bossName = true }, -- Berserker Frenzy (Keeper Voranil)
    [28750] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Essence Siphon (Keeper Voranil)
    [29143] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Daedric Blast (Keeper Imiril)
    [28962] = { power = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Sister's Love (Sister Sihna / Sister Vera)
    [48799] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, refire = 1500, bossName = true }, -- Daedric Tempest (High Kinlord Rilis)
    [48814] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, refire = 1500, bossName = true }, -- Daedric Tempest (High Kinlord Rilis)

    -- Elden Hollow I
    [16834] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Executioner's Strike (Akash gra-Mal)
    [15999] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Leaping Strike (Akash gra-Mal)
    [16016] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Berserker Frenzy (Akash gra-Mal)

    [9910] = { destroy = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, bossName = true }, -- Summon Saplings (Chokethorn)
    [9930] = { interrupt = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, notDirect = true, refire = 1000, fakeName = U.NPC_Strangler_Saplings }, -- Heal Spores (Chokethorn)
    [9875] = { avoid = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, bossName = true }, -- Fungal Burst (Chokethorn)

    [44223] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, fakeName = U.Boss_Leafseether }, -- Inhale (Leafseether)

    [9845] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Rotting Bolt (Canonreeve Oraneth)
    [16262] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Necrotic Circle (Canonreeve Oraneth)
    [9944] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Necrotic Burst (Canonreeve Oraneth)
    [9839] = { power = true, priority = 1, auradetect = true, ignoreRefresh = true }, -- Bone Hurricane (Canonreeve Oraneth)

    -- Elden Hollow II
    [34376] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, refire = 1500 }, -- Flame Geyser (Dubroze the Infestor)
    [32707] = { summon = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Summon Guardians (Dark Root)
    [33334] = { interrupt = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, fakeName = U.NPC_Frenzied_Guardian }, -- Latch On Stamina (Frenzied Guardian)
    [33337] = { interrupt = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, fakeName = U.NPC_Mystic_Guardian }, -- Latch On Magicka (Mystic Guardian)
    [32890] = { power = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Gleaming Light (Dark Root)
    [33533] = { power = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Glaring Light (Dark Root)
    [33535] = { power = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Brightening Light (Dark Root)

    [33170] = { destroy = true, priority = 1, auradetect = true }, -- Hate (Shadow Tendril)

    [33052] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Shadow Stomp (Murklight)
    [32832] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, refire = 1750, bossName = true }, -- Consuming Shadow (Murklight)
    [32975] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Eclipse (Murklight)

    [33102] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, refire = 1250, bossName = true }, -- Spout Shadow (The Shadow Guard)

    [33432] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Daedric Flame (Bogdan the Nightflame)
    [33480] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Pulverize (Bogdan the Nightflame)
    [33492] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Pulverize (Bogdan the Nightflame)
    [33494] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Pulverize (Bogdan the Nightflame)
    [34260] = { destroy = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, fakeName = U.Boss_Nova_Tendril, refire = 1000 }, -- Shadow (Nova Tendril)

    -- City of Ash I
    [31101] = { block = true, avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Cleave (Golor the Banekin Handler)
    [25034] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Crushing Blow (Golor the Banekin Handler)
    [33604] = { summon = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Summon Banekin (Golor the Banekin Handler)

    [34607] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Measured Uppercut (Warden of the Shrine)
    [34654] = { avoid = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, auradetect = true, bossName = true }, -- Fan of Flames (Warden of the Shrine)
    [34620] = { avoid = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, auradetect = true, bossName = true }, -- Fan of Flames (Warden of the Shrine)

    [34190] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Thorny Backhand (Infernal Guardian)
    [34189] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Ground Slam (Infernal Guardian)
    [35061] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Consuming Fire (Infernal Guardian)
    [34183] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Tunneling Roots (Infernal Guardian)

    [44278] = { block = true, avoid = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED }, -- Lava Geyser (Dark Ember)

    [34198] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true}, -- Burning Field (Rothariel Flameheart)
    [34205] = { power = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, auradetect = true }, -- Deception (Rothariel Flameheart)

    [34901] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Blazing Arrow (Razor Master Erthas)
    [34805] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Release Flame (Razor Master Erthas)
    [34623] = { summon = true, priority = 1, auradetect = true, bossName = true }, -- Summon Flame Atronach (Razor Master Erthas)
    [34780] = { summon = true, priority = 1, auradetect = true, bossName = true }, -- Summon Flame Atranach (Razor Master Erthas)

    -- City of Ash II
    [53999] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, fakeName = A.Skill_Oblivion_Gate }, -- Summon (Flame Atronach)
    [54021] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Release Flame (Marruz)
    [53976] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Blazing Arrow (Marruz)
    [54025] = { interrupt = true, priority = 1, auradetect = true, notDirect = true, fakeName = U.Boss_Akezel }, -- Spell Absorption (Akezel)
    [53994] = { interrupt = true, priority = 1, eventdetect = true, notDirect = true, fakeName = U.Boss_Akezel, result = ACTION_RESULT_BEGIN }, -- Focused Healing (Akezel)
    [54096] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, fakeName = U.Boss_Rukhan }, -- Pyrocasm (Rukhan)

    [56811] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, fakeName = U.NPC_Xivilai_Ravager }, -- Pyrocasm (Xivilai Ravager)

    [56414] = { avoid = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Fire Runes (Urata the Legion)
    [54225] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Multiply (Urata the Legion)
    [56098] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Multiply (Urata the Legion)
    [56104] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Multiply (Urata the Legion)
    [56131] = { power = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Reunite (Urata the Legion)

    [56186] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, fakeName = U.NPC_Flame_Colossus }, -- Voice to Wake the Dead (Bone Colossus)

    [55203] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Seismic Tremor (Horvantud the Fire Maw)
    [56002] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Seismic Tremor (Horvantud the Fire Maw)
    [55312] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Slag Breath (Horvantud the Fire Maw)
    [55333] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Fiery Breath (Horvantud the Fire Maw)
    [55320] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Fiery Breath (Horvantud the Fire Maw)
    [55335] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Fiery Breath (Horvantud the Fire Maw)
    [55326] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Fiery Breath (Horvantud the Fire Maw)
    [55337] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Fiery Breath (Horvantud the Fire Maw)
    [57618] = { power = true, priority = 1, auradetect = true, ignoreRefresh = true }, -- Damage Shield (Horvantud the Fire Maw)

    [55315] = { power = true, priority = 1, auradetect = true }, -- Slag Breath (Horvantud the Fire Maw)
    [55324] = { power = true, priority = 1, auradetect = true }, -- Enrage 2 (Horvantud the Fire Maw)
    [55329] = { power = true, priority = 1, auradetect = true }, -- Enrage 3 (Horvantud the Fire Maw)

    [54218] = { block = true, dodge = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, bossName = true }, -- Monstrous Cleave (Ash Titan)
    [54895] = { block = true, avoid = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, bossName = true }, -- Molten Rain (Ash Titan)
    [54699] = { avoid = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, bossName = true }, -- Fire Swarm (Ash Titan)

    [58468] = { power = true, auradetect = true, priority = 1 }, -- Shadow Cloak (Ash Titan)
    [54783] = { power = true, auradetect = true, priority = 1 }, -- Air Atronach Flame (Air Atronach)
    [54366] = { avoid = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, refire = 1500, fakeName = U.NPC_Air_Atronach }, -- Flame Tornado (Air Atronach)

    [58280] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, bossName = true }, -- Scary Summon 1 (Xivilai Fulminator / Boltaic)
    [56601] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, bossName = true }, -- Scary Summon 2 (Xivilai Fulminator / Boltaic)

    [55513] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Flame Bolt (Valkyn Skoria)
    [55387] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Meteor Strike (Valkyn Skoria)
    [55514] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Call the Flames (Valkyn Skoria)
    [55426] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Magma Prison (Valkyn Skoria)
    [55024] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Lava Quake (Valkyn Skoria)
    [55500] = { power = true, priority = 1, auradetect = true, ignoreRefresh = true }, -- Rock Shield (Valkyn Skoria)

    -- Tempest Island
    [46732] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true, refire = 1000 }, -- Sonic Scream (Sonolia the Matriarch)

    [26370] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Slash (Valaran Stormcaller)
    [26628] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Enervating Bolt (Valaran Stormcaller)
    [26592] = { summon = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, bossName = true }, -- Lightning Avatar (Valaran Stormcaller)

    [6106] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Lightning Storm (Yalorasse the Speaker)

    [26748] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true, refire = 1000 }, -- Enervating Stone (Stormfist)
    [26714] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Skyward Slam (Stormfist)
    [26833] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Summon Storm Atronach (Stormfist)
    [26790] = { power = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true, refire = 60000 }, -- Unstable Explosion (Stormfist)

    [27039] = { interrupt = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true, refire = 600 }, -- Ethereal Chain (Commodore Ohmanil)

    [27596] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Lightning Strike (Stormreeve Neider)
    [26741] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Swift Wind (Stormreeve Neider)
    [26712] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Gust of Wind (Stormreeve Neider)

    -- Selene's Web
    [30909] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, refire = 2000, bossName = true }, -- Ensnare (Treethane Kerninn)
    [30907] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Summon Primal Swarm (Treethane Kerninn)

    [30781] = { power = true, priority = 1, auradetect = true }, -- Mirror Ward (Longclaw)
    [30772] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true, refire = 1250 }, -- Arrow Rain (Longclaw)
    [30779] = { summon = true, priority = 1, auradetect = true, refire = 500, fakeName = '' }, -- Spirit Form (Senche Spirit)
    [31096] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Poison Burst (Longclaw)

    [31202] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Venomous Burst (Queen Aklayah)
    [31205] = { power = true, priority = 1, auradetect = true, noSelf = true }, -- Venomous Burst (Queen Aklayah)

    [30996] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Vicious Maul (Foulhide)
    [30812] = { avoid = true, block = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Trampling Charge (Foulhide)
    [31002] = { summon = true, priority = 1, auradetect = true, fakeName = '', refire = 5000 }, -- Intro (Selene's Rose)

    [31241] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, bossName = true }, -- Summon Spiders (Mennir Many-Legs)

    [31052] = { power = true, priority = 1, auradetect = true, noSelf = true }, -- Web Wrap (Selene)
    [30731] = { block = true, dodge = true, priority = 1, auradetect = true }, -- Summon Primal Spirit (Selene)
    [30896] = { dodge = true, priority = 1, auradetect = true, bossName = true }, -- Summon Senche Spirit (Selene)

    [31986] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Summon Melee (Selene)
    [31984] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Summon Healer (Selene)
    [31985] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED }, -- Summon Archer (Selene)

    -- Spindleclutch I
    [46147] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, bossName = true }, -- Summon Swarm (Spindlekin)

    [22034] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Inject Poison (Swarm Mother)
    [17964] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Impeding Webs (Swarm Mother)
    [17960] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Arachnid Leap (Swarm Mother)
    [18559] = { summon = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, eventdetect = true, refire = 1000, bossName = true }, -- Spawn Broodling (Swarm Mother)

    [18111] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Arachnophobia (Swarm Mother)
    [18078] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Web Blast (Swarm Mother)
    [35572] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Grappling Web (Swarm Mother)
    [18058] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Daedric Explosion (Swarm Mother)

    -- Spindleclutch II
    [28093] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Vicious Smash (Blood Spawn)
    [27995] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Cave-In (Blood Spawn)
    [47331] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true, refire = 60000 }, -- Cave-In (Blood Spawn)
    [47198] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, auradetect = true, refire = 5000, fakeName = '' }, -- Falling Rocks (Cave In)

    [28438] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Dummy (Praxin Douare)
    [18036] = { block = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, fakeName = U.NPC_The_Whisperer_Nightmare, refire = 2500 }, -- Grappling Web (The Whisperer Nightmare)

    [27965] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Despair (Praxin Douare)
    [27741] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Despair (Praxin Douare)
    [27703] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Harrowing Ring (Praxin Douare)
    [61443] = { power = true, priority = 1, auradetect = true, noSelf = true }, -- Harrowing Ring (Praxin Douare)

    [27435] = { power = true, priority = 1, auradetect = true }, -- Monstrous Growth (Flesh Atronach)
    [27437] = { power = true, priority = 1, auradetect = true }, -- Monstrous Growth (Flesh Atronach)

    [27600] = { avoid = true, priority = 1, result = ACTION_RESULT_EFFECT_GAINED, auradetect = true }, -- Blood Pool (Urvan Veleth)

    [27905] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Blood Pool (Vorenor Winterbourne)
    [27897] = { unmit = true, priority = 1, result = ACTION_RESULT_BEGIN }, -- Open Wounds (Vorenor Winterbourne)
    [27791] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Blood Frenzy (Vorenor Winterbourne)

    [31672] = { power = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true, refire = 2500 }, -- Thrall Feast (Vorenor Winterbourne)

    -- Frostvault
    [109574] = { block = true, interrupt = true, priority = 3, result = ACTION_RESULT_BEGIN, refire = 3250 }, -- Fire Power (Coldsnap Harrier)
    [117352] = { block = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Whirlwind (Coldsnap Snowstalker)

    [117290] = { block = true, avoid = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Shockwave (Coldsnap Ogre)
    [117287] = { block = true, bs = true, dodge = true, priority = 2, result = ACTION_RESULT_BEGIN }, -- Crushing Blow (Coldsnap Ogre)

    [117326] = { block = true, priority = 3, result = ACTION_RESULT_EFFECT_GAINED, refire = 250 }, -- Ice Comet (Coldsnap Skysplitter)

    [109827] = { block = true, avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Boulder Toss (Icestalker)
    [109811] = { avoid = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Ground Slam (Icestalker)
    [109837] = { interrupt = true, priority = 1,  result = ACTION_RESULT_BEGIN, eventdetect = true, notDirect = true }, -- Frenzied Pummeling (Icestalker)
    [109806] = { block = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true }, -- Frozen Aura (Icestalker)
    [83430] = { block = true, bs = true, dodge = true, priority = 3, result = ACTION_RESULT_BEGIN }, -- Skeletal Smash (Ice Wraith)
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

-- Export string data to global namespace
LUIE.AlertTable = AlertTable
