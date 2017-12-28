LUIE.AlertTable = {

-- PRIORITY NOTES:
    -- 1 = VMA/Trial/Dungeon
    -- 2 = ELITE NPC/QUEST BOSS
    -- 3 = Normal NPC
    
    -- bs = true -- Add indicator for Block Stagger to effect
    -- auradetect = true -- Detect aura application rather than using targetting info
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
    
    [62472] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true }, -- Stab (Justice Dagger NPC)
    
    --------------------------------------------------
    -- STANDARD NPC'S --------------------------------
    --------------------------------------------------
    
    [29378] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Uppercut (Ravager)
    
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
    
    [36470] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Veiled Strike (Nightblade)
    
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
    [37129] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Ice Cage (Battlemage)
    [44216] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2}, -- Negate Magic (Battlemage - Elite)
    
    [13397] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true}, -- Empower Undead (Necromancer)
    [14350] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Aspect of Terror (Fear Mage)
    
    [35387] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Defiled Grave (Bonelord)
    
    [57534] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true}, -- Focused Healing (Healer)
    [44328] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 2, auradetect = true, notDirect = true}, -- Rite of Passage (Healer)
    
    [38118] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, skipcheck = true}, -- Caltrops  (Faction NPCs)
    
    [70070] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true }, -- Heavy Strike (Winterborn Warrior)
    [64980] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3 }, -- Javelin (Winterborn Warrior)
    [65033] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, skipcheck = true }, -- Retaliation (Winterborn Warrior)
    
    [55909] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Grasping Vines (Winterborn Mage)
    [64704] = { block = true, dodge = false, avoid = true, interrupt = true, priority = 3, auradetect = true }, -- Flames (Winterborn Mage)
    
    [54027] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, refire = 1600}, -- Divine Leap (Vosh Rakh Devoted)
    
    [76089] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Snipe (Archer) (TG DLC)
    [72220] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Snipe (Archer) (TG DLC)
    
    [77473] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Shield Charge (Bodyguard) (DB DLC)
    
    -- ANIMALS
    [4416] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Savage Blows (Bear)
    
    [4591] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Sweep (Crocodile)
    [8977] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Sweep (Duneripper)
    
    [7227] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Rotbone (Durzog)
    
    [6308] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Shocking Touch (Dreugh)
    
    [54375] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3}, -- Shockwave (Echatere)
    
    [4632] = { block = true, dodge = false, avoid = false, interrupt = false, priority = 3}, -- Screech (Giant Bat)
    [4630] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, refire = 1500}, -- Draining Bite (Giant Bat)
    
    [5240] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Lash (Giant Snake)
    [5242] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Kiss of Poison (Giant Snake)
    [5244] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, auradetect = true, notDirect = true}, -- Shed Skin (Giant Snake)
    
    [5363] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Chomp (Kagouti)
    
    [7161] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Double Strike (Lion)
    
    [8604] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, refire = 5700, skipcheck = true}, -- Vigorous Swipe (Mammoth)
    [8600] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, skipcheck = true}, -- Stomp (Mammoth)
    [48551] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, auradetect = true}, -- Charge (Mammoth)
    
    [4200] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Unforgiving Claws (Mudcrab)
    
    [16690] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Thrust (Netch)
    [16698] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, skipcheck = true, refire = 7000}, -- Poisonbloom (Netch)
    
    [7268] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 500}, -- Leech
    
    [21904] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Rend (Skeever)
    
    [21951] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 2}, -- Repulsion Shock (Wamasu)
    [48556] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, auradetect = true}, -- Focused Charge (Wamasu)
    
    [44791] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Rear Kick (Welwa)
    [52417] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Charge (Welwa)
    
    [42844] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Rotbone (Wolf)
    [14523] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3, refire = 1000}, -- Helljoint (Wolf)
    
    [72793] = { block = false, dodge = true, avoid = false, interrupt = false, priority = 2}, -- Toxic Mucus (Haj Mota)
    [72796] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 2, auradetect = true}, -- Bog Burst (Haj Mota)
    
    [76307] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Lunge (Dire Wolf)
    
    -- INSECTS
    [6137] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Laceration (Assassin Beetle)
    [5268] = { block = true, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Collywobbles (Assassin Beetle)
    
    [6757] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Blurred Strike (Giant Scorpion)
    [6756] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3 }, -- Paralyze (Giant Scorpion)
    
    [44086] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, auradetect = true, refire = 850 }, -- Fire Runes (Giant Spider)
    [5685] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Corrosive Bite (Giant Spider)
    [8088] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3, skipcheck = true, refire = 4100 }, -- Poison Spray (Giant Spider)
    
    [9226] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Sting (Wasp)
    [48559] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Focused Charge (Giant Wasp)
    [9229] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Inject Larva (Giant Wasp)
    
    [6800] = { block = true, dodge = false, avoid = true, interrupt = false, priority = 3 }, -- Bloodletting (Hoarvor)
    [6795] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3}, -- Latch On (Hoarvor)
    
    [61244] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Fevered Retch (Hoarvor)
    
    [48539] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Focused Charge (Kwama Worker)
    
    [5252] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Fire Bite (Shalk)
    [5265] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3, skipcheck = true, refire = 4100}, -- Burning Ground (Shalk)
    
    [8429] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 600}, -- Zap (Thunderbug)
    [26412] = { block = false, dodge = false, avoid = true, interrupt = true, priority = 3}, -- Thunderstrikes (Thunderbug)
    
    [73172] = { block = false, dodge = true, avoid = false, interrupt = true, priority = 3}, -- Swarm (Kotu Gava)
    
    -- DAEDRA
    [48121] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Heavy Attack (Air Atronach)
    [48137] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3}, -- Tornado (Air Atronach)
    [50021] = { block = false, dodge = false, avoid = true, interrupt = false, priority = 3}, -- Ice Vortex (Air Atronach)
    [50023] = { block = false, dodge = false, avoid = false, interrupt = true, priority = 3, refire = 600}, -- Lightning Rod (Air Atronach)
    
    
    
    [14819] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Charge (Clannfear)
    
    [48553] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true, auradetect = true}, -- Focused Charge (Ogrim)
    
    -- MONSTERS
    [48549] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, auradetect = true}, -- Focused Charge (Ogrim)
    
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
    
    [85359] = { block = true, dodge = true, avoid = false, interrupt = false, priority = 3, bs = true}, -- Reverse Slash (Drudge)
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