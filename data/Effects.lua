------------------
-- Effects namespace
LUIE.Effects = {}

-- Performance Enhancement
local E = LUIE.Effects
local T = LUIE.Tooltips
local A = LUIE.GetAbility()

-- List of abilities considered for Ultimate generation - used by CombatInfo to determine when Ultimate is being generated
E.IsWeaponAttack = {
    [A.Skill_Light_Attack]                  = true,
    [A.Skill_Heavy_Attack]                  = true,
    [A.Skill_Heavy_Attack_Dual_Wield]       = true,
    [A.Skill_Heavy_Attack_Werewolf]         = true,
    [A.Skill_Heavy_Attack_Shock]            = true,
}

-- List of toggle abilities
E.IsToggle = {
    -- Innate
    [20299] = true, -- Sneak (Innate) -- Used for hidden
    [20301] = true, -- Crouch (Innate) -- Used for invisibility
    [A.Innate_Disguised] = true, -- Disguised (Innate)
    [14890] = true, -- Block (Player)
    [40165] = true, -- Scene Choreo Brace (Monster Fight))
    [29761] = true, -- Brace (Guard)
    [973] = true, -- Sprint (Innate)
    [33439] = true, -- Mount Sprint (Generic)

    -- Sorcerer
    [23304] = true, -- Summon Unstable Familiar
    [23319] = true, -- Summon Unstable Clannfear
    [23316] = true, -- Summon Volatile Familiar
    [24613] = true, -- Summon Winged Twilight
    [24636] = true, -- Summon Twilight Tormentor
    [24639] = true, -- Summon Twilight Matriarch
    [24785] = true, -- Overload
    [24806] = true, -- Energy Overload
    [24804] = true, -- Power Overload

    -- Warden
    [85982] = true, -- Feral Guardian
    [85986] = true, -- Eternal Guardian
    [85990] = true, -- Wild Guardian

    -- Psijic Order
    [103923] = true, -- Concentrated Barrier
    [103966] = true, -- Concentrated Barrie
    [103543] = true, -- Mend Wounds
    [103747] = true, -- Mend Spirit
    [103755] = true, -- Symbiosis

    -- Support
    [80923] = true, -- Guard (Guard)
    [80947] = true, -- Mystic Guard (Mystic Guard)
    [64080] = true, -- Minor Vitality (Mystic Guard)
    [80983] = true, -- Stalwart Guard (Stalwart Guard)
    [80986] = true, -- Minor Force (Stalwart Guard)

    -- NPC Abilities
    [53462] = true, -- Siphoning Strikes (Nightblade)
    [44258] = true, -- Magelight (Soulbrander)
}

E.IsAbilityProc = {
    [A.Skill_Power_Lash]          = true,
    [A.Skill_Assassins_Will]      = true,
    [A.Skill_Assassins_Scourge]   = true,
}

E.HasAbilityProc = {
    [A.Skill_Crystal_Fragments]     = 46327,
}

-- Vampire / Lycantropy
E.IsVamp = {
    [35771] = true, -- Stage 1 Vampirism
    [35996] = true, -- Stage 2 Vampirism
    [35783] = true, -- Stage 3 Vampirism
    [35792] = true, -- Stage 4 Vampirism
}

E.IsLycan = {
    [35658] = true, -- Lycanthrophy
}

E.IsVampLycanDisease = {
    [39472] = true, -- Vampirism (NPC Bite)
    [40360] = true, -- Vampirism (Player Bite)
    [31068] = true, -- Sanies Lupinus (NPC Bite)
    [40521] = true, -- Sanies Lupinus (Player Bite)
}

E.IsVampLycanBite = {
    [40359] = true, -- Fed on ally (Vampire)
    [40525] = true, -- Bit an ally (Werewolf)
}

-- Mundus passives
E.IsBoon = {
    [13940] = true, -- The Warrior
    [13943] = true, -- The Mage
    [13974] = true, -- The Serpent
    [13975] = true, -- The Thief
    [13976] = true, -- The Lady
    [13977] = true, -- The Steed
    [13978] = true, -- The Lord
    [13979] = true, -- The Apprentice
    [13980] = true, -- The Ritual
    [13981] = true, -- The Lover
    [13982] = true, -- The Atronach
    [13984] = true, -- The Shadow
    [13985] = true, -- The Tower
}

-- Cyrodiil passives
E.IsCyrodiil = {

    [39671] = true, -- Emperorship Alliance Bonus
    [11346] = true, -- Home Keep Bonus -- CONFIRM
    [11341] = true, -- Enemy Keep Bonus I
    [11343] = true, -- Enemy Keep Bonus II
    [11345] = true, -- Enemy Keep Bonus III -- CONFIRM
    [11347] = true, -- Enemy Keep Bonus IV
    [11348] = true, -- Enemy Keep Bonus V
    [11350] = true, -- Enemy Keep Bonus VI
    [11352] = true, -- Enemy Keep Bonus VII
    [11353] = true, -- Enemy Keep Bonus VIII
    [11356] = true, -- Enemy Keep Bonus IX
    [15060] = true, -- Defensive Scroll Bonus I
    [16350] = true, -- Defensive Scroll Bonus II
    [15058] = true, -- Offensive Scroll Bonus I
    [16348] = true, -- Offensive Scroll Bonus II
    [66282] = true, -- Blessing of War -- CONFIRM
}

E.IsSoulSummons = {
    [43752] = true, -- Soul Summons
}

E.IsSetICD = {
    [90936] = true, -- Phoenix
    [90938] = true, -- Immortal Warrior
    [90939] = true, -- Eternal Warrior
}

E.IsFoodBuff = {
    -- Food Buff
    [61259] = true, -- Health Food
    [61260] = true, -- Magicka Food
    [61261] = true, -- Stamina Food
    [61294] = true, -- Magicka + Stamina Food
    [61255] = true, -- Health + Stamina Food
    [61257] = true, -- Health + Magicka Food
    [61218] = true, -- Triple Food
    [72819] = true, -- Orzorga's Tripe Trifle Pocket
    [72822] = true, -- Orzorga's Blood Price Pie
    [72824] = true, -- Orzorga's Smoked Bear Haunch
    [100502] = true, -- Deregulated Mushroom Stew
    [100498] = true, -- Clockwork Citrus Filet
    [107789] = true, -- Artaeum Takeaway Broth
    [107748] = true, -- Artaeum Pickled Fish Bowl
    [84681] = true, -- Crisp and Crunchy Pumpkin Skewer
    [84709] = true, -- Crunchy Spider Skewer
    [84725] = true, -- Frosted Brains
    [84678] = true, -- Sweet Sanguine Apples
    [86798] = true, -- Alcaire Festival Sword-Pie
    [86749] = true, -- Jagga-Drenched "Mud Ball"
    [86673] = true, -- Lava Foot Soup-and-Saltrice
    [86560] = true, -- Old Aldmeri Orphan Gruel
    [86787] = true, -- Rajhin's Sugar Claws
    [89955] = true, -- Candied Jester's Coins
    [89971] = true, -- Jewels of Misrule
    [89956] = true, -- Princess' Delight
    [66551] = true, -- Vendor Health Food
    [66568] = true, -- Vendor Magicka Food
    [66576] = true, -- Vendor Stamina Food
    [72961] = true, -- Cyrodilic Field Bar
    [72956] = true, -- Cyrodilic Field Tack
    [72959] = true, -- Cyrodilic Field Treat
    [85484] = true, -- Crown Crate Fortifying Meal
    [68411] = true, -- Crown Fortifying Meal
    [92435] = true, -- Crown Combat Mystic's Stew
    [92474] = true, -- Crown Vigorous Ragout

    -- Drink Buff
    [61322] = true, -- Health Drink
    [61325] = true, -- Magicka Drink
    [61328] = true, -- Stamina Drink
    [61345] = true, -- Magicka + Stamina Drink
    [61340] = true, -- Health + Stamina Drink
    [61335] = true, -- Health + Magicka Drink
    [61350] = true, -- Triple Drink
    [72816] = true, -- Orzorga's Red Frothgar
    [100488] = true, -- Spring-Loaded Infusion
    [84700] = true, -- Bowl of "Peeled Eyeballs"
    [84735] = true, -- Double Bloody Mara
    [84720] = true, -- Ghastly Eye Bowl
    [84704] = true, -- Witchmother's Party Punch
    [84731] = true, -- Witchmother's Potent Brew
    [86677] = true, -- Bergama Warning Fire
    [86746] = true, -- Betnikh Twice-Spiked Ale
    [86559] = true, -- Hissmir Fish-Eye Rye
    [86791] = true, -- Snow Bear Glow-Wine
    [89957] = true, -- Dubious Camoran Throne
    [66586] = true, -- Vendor Health Drink
    [66590] = true, -- Vendor Magicka Drink
    [66594] = true, -- Vendor Stamina Drink
    [72971] = true, -- Cyrodilic Field Tonic
    [72965] = true, -- Cyrodilic Field Brew
    [72968] = true, -- Cyrodilic Field Tea
    [85497] = true, -- Crown Crate Refreshing Drink
    [68416] = true, -- Crown Refreshing Drink
    [92433] = true, -- Crown Stout Magic Liqueur
    [92476] = true, -- Crown Vigorous Tincture
}

E.IsExperienceBuff = {
    -- Consumable
    [64210] = true, -- Psijic Ambrosia
    [89683] = true, -- Aetherial Ambrosia
    [88445] = true, -- Mythic Aetherial Ambrosia
    [66776] = true, -- Crown Experience Scroll
    [85501] = true, -- Crown Crate Experience Scroll
    [85502] = true, -- Major Crown Crate Experience Scroll
    [85503] = true, -- Grand Crown Crate Experience Scroll

    -- Event
    [91369] = true, -- The Pie of Misrule (Jester's Experience Boost Pie)
    [92232] = true, -- Pelinal's Ferocity
    [91449] = true, -- Breda's Magnificent Mead
    [86075] = true, -- Breda's Magnificent Mead

    -- RECHECK -- TODO
    [77123] = true, -- 2017 Anniversary EXP Buff
    [96118] = true, -- Witchmother's Boon
}

E.IsBlock = {
    [14890] = true, -- Block
    [29761] = true, -- Brace
    [40165] = true, -- Scene Choreo Brace
}

E.IsGrimFocus = {
    [61905] = true, -- Grim Focus
    [61928] = true, -- Relentless Focus
    [61920] = true, -- Merciless Resolve
}

E.IsGrimFocusOverride = {
    [61902] = true, -- Grim Focus
    [61927] = true, -- Relentless Focus
    [61919] = true, -- Merciless Resolve
}

E.IsGroundMineAura = {

    -- Nightblade
    [37475] = true, -- Manifestation of Terror (Nightblade)

    -- Sorcerer
    [24830] = true, -- Daedric Mines (Daedric Mines)
    [24847] = true, -- Daedric Mines (Daedric Tomb)
    [25158] = true, -- Daedric Mines (Daedric Minefield)

    -- Fighters Guild
    [35750] = true, -- Trap Beast (Trap Beast - Rank 1)
    [40382] = true, -- Rearming Trap (Rearming Trap)
    [40388] = true, -- Rearming Trap (Rearming Trap)
    [40372] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 1)

    -- Mages Guild
    [31632] = true, -- Fire Rune (Fire Rune)
    [40470] = true, -- Volcanic Rune (Volcanic Rune)
    [40465] = true, -- Scalding Rune (Scalding Rune)

}

E.IsGroundMineStack = {

    -- Sets
    [75930] = true, -- Deadric Mines (Eternal Hunt)

    -- Warden
    [86175] = true, -- Frozen Gate (Frozen Gate)
    [86179] = true, -- Frozen Device (Frozen Device)
    [86183] = true, -- Frozen Retreat (Frozen Retreat)

}

E.LinkedGroundMine = {

    [76631] = 37475, -- Manifestation of Terror (Nightblade)

    [24832] = 24830, -- Daedric Mines (Daedric Mines)
    [24833] = 24830, -- Daedric Mines (Daedric Mines)

    [24846] = 24847, -- Daedric Mines (Daedric Tomb)
    [24844] = 24847, -- Daedric Mines (Daedric Tomb)

    [25157] = 25158, -- Daedric Mines (Daedric Minefield)
    [25159] = 25158, -- Daedric Mines (Daedric Minefield)
    [25160] = 25158, -- Daedric Mines (Daedric Minefield)
    [25162] = 25158, -- Daedric Mines (Daedric Minefield)

}

-- Filter out Debuffs to always display regardless of whether they are sourced from the player - BY ID
E.DebuffDisplayOverrideId = {
    -- Basic (Shared)
    [2727] = true, -- Off-Balance (Generic)
    [102771] = true, -- Off Balance Immunity

    -- Player (Sets)
    [51315] = true, -- Destructive Mage (Aether ... of Destruction)
    [75753] = true, -- Line Breaker (of Alkosh)
    [93001] = true, -- Mad Tinkerer (Stun from Fabricant)

    -----------------
    -- Class
    ------------------

    -- Dragonknight
    [98447] = true, -- Shackle Snare (Dragonknight Standard Synergy)

    -- Templar
    [31562] = true, -- Supernova (Nova Synergy)
    [34443] = true, -- Gravity Crush (Solar Prison Synergy)

    -- Warden
    [87560] = true, -- Frozen Gate Root (Frozen Gate)
    [92039] = true, -- Frozen Gate Root (Frozen Device)
    [92060] = true, -- Frozen Retreat Root (Frozen Retreat)

    -- Werewolf
    [39122] = true, -- Off Balance (Ferocious Roar)
    [39123] = true, -- Ferocious Roar (Ferocious Roar)

    -- Human NPC's
    [88281] = true, -- Call Ally (Pet Ranger)
    [89017] = true, -- Dark Shade (Dreadweaver)
    [88561] = true, -- Summon the Dead (Necromancer)
    [88504] = true, -- Summon Abomination (Bonelord)
    [92158] = true, -- Raise the Earth (Beastcaller)
    [29597] = true, -- Combustion (Shaman)
    [29598] = true, -- Off Balance (Shaman)
    [89301] = true, -- Summon Spiderling (Spider Daedra)

    -- Insects
    [61372] = true, -- Infectious Swarm (Necrotic Hoarvor)

    -- Monsters
    [89399] = true, -- Summon Spectral Lamia (Lamia)
    [89127] = true, -- Summon Beast (Spriggan)
    [42794] = true, -- Strangler: (Strangler)
    [48294] = true, -- Consuming Omen (Troll - Ranged)

    -- Friendly NPC's

}

E.EffectHideWhenDead = {
    [33097] = true, -- Scary Immunities (Various NPC's)
    [44176] = true, -- Flying Immunities (Various NPC's)
}

-- Filter out Debuffs to always display regardless of whether they are sourced from the player - BY NAME
E.DebuffDisplayOverrideName = {
    [A.Skill_Minor_Breach]              = true,
    [A.Skill_Major_Breach]              = true,
    [A.Skill_Minor_Defile]              = true,
    [A.Skill_Major_Defile]              = true,
    [A.Skill_Minor_Fracture]            = true,
    [A.Skill_Major_Fracture]            = true,
    [A.Skill_Minor_Maim]                = true,
    [A.Skill_Major_Maim]                = true,
    [A.Skill_Minor_Vulnerability]       = true,
    [A.Skill_Major_Vulnerability]       = true,
    [A.Skill_Minor_Mangle]              = true,
    [A.Skill_Minor_Cowardice]           = true,
    [A.Skill_Minor_Enveration]          = true,
    [A.Skill_Minor_Uncertainty]         = true,
    [A.Skill_Minor_Magickasteal]        = true,
    [A.Skill_Minor_Lifesteal]           = true,
}

E.CastBreakingStatus = {

    [ACTION_RESULT_STAGGERED] = true,
    [ACTION_RESULT_STUNNED] = true,
    [ACTION_RESULT_KNOCKBACK] = true,
    [ACTION_RESULT_LEVITATED] = true,
    [ACTION_RESULT_FEARED] = true,
    [ACTION_RESULT_DISORIENTED] = true,

}

-- List of abilityId's that should immediately cancel the Cast Bar if detected
E.CastBreakingActions = {

    [28549] = true, -- Roll Dodge
    [14890] = true, -- Block
    [20309] = true, -- Hidden
    [973] = true, -- Sprint
    [33439] = true, -- Mount Sprint
    [6811] = true, -- Recall
    [69293] = true, -- Sigil of Imperial Retreat

    -- TODO:
    -- check stealth id timing for breaking + sprint/mount sprint
    -- make sure keep/IC recall stones work here

}

E.CastChannelOverride = {

    [33175] = true, -- Feed (Vampire)
    [40350] = true, -- Feed (Vampire - Bite Player)

    [32346] = true, -- Skyshard Collect
    [47270] = true, -- Ritual of Mara
    [14031] = true, -- Mundus Use
    [4197] = true, -- Recovering (NPC Duel)

    -- Seasonal Mementos & Items
    [86792] = true, -- Eating (High Hrothgar Festival Mints)
    [86739] = true, -- Drinking (Sailor's Warning Festival Grog)
    [85355] = true, -- Flame Juggling (Consumable Version)
    [85354] = true, -- Dagger Juggling (Consumable Verison)
    [85353] = true, -- Sword Swallowing (Consumable Version)
    [102077] = true, -- Jester's Festival Scintillator (Jester's Scintillator)

    -- Memento (Crown)
    [85347] = true, -- Storm Orb Juggle (Atronach Juggling)
    [97273] = true, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [99318] = true, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    [99319] = true, -- Flame Crate Memento 2 (Flame Pixie)
    [99320] = true, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    [101874] = true, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    [101877] = true, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    [101872] = true, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    [104324] = true, -- Psijic Pearl Summon (Psijic Celestial Orb)
    [104323] = true, -- Psijic Hourglass (Psijic Tautology Glass)
    [104325] = true, -- Psijic Disintegrate (Sapiarchic Discorporation Lens)
    [110482] = true, -- Rind-Renewing Pumpkin (Rind-Renewing Pumpkin)
    [110481] = true, -- Gourd-Gallows Stump (Gourd-Gallows Stump)

    -- Memento (Base)
    [43700] = true, -- Wand of Finding (Lena's Wand of Finding)
    [42076] = true, -- Tear (Mezha-dro's Sealing Amulet)
    [34578] = true, -- Nirnroot Wine (Nirnroot Wine)
    [42053] = true, -- Yokudan Salute (Yokudan Totem)

    -- Memento (DLC)
    [89550] = true, -- TROPHY Azura's Light (Twilight Shard)
    [79510] = true, -- TROPHY Blood Oath (Blade of the Blood Oath)

    -- Sets
    [90940] = true, -- Eternal Warrior
    [90937] = true, -- Immortal Warrior
    [90935] = true, -- Phoenix

    -- Quest
    [39367] = true, -- Altar Use (Shadow of Sancre Tor)
    [36421] = true, -- Drink with Lyris (Council of the Five Companions)
    [35192] = true, -- Q4620 Use Lodestone (Cast Adrift)
    [34567] = true, -- Q4621 PC Storm Drain (The Tempest Unleashed)
    [34701] = true, -- Q4621 Destory Horn (The Tempest Unleashed)
    [21364] = true, -- Casting... (The Serpent's Beacon)
    [22889] = true, -- Purifying... (Corruption Stones)
    [21968] = true, -- Binding Bear... (Silent Village)
    [22931] = true, -- Freeing Spirit... (An Act of Kindness)
    [23187] = true, -- Q4236 PC Untie Palith (The Veiled Choice)
    [47301] = true, -- Stunned (Passage Denied)
    [36710] = true, -- Q4833 Apply Snake Buff (Bosmer Insight)
    [36841] = true, -- Q4833 Apply Wolf Buff (Bosmer Insight)
    [36824] = true, -- Q4833 Apply Tiger Buff (Bosmer Insight)
    [37062] = true, -- Exorcise (The Unquiet Dead)
    [36996] = true, -- Bind Spirit (The Unquiet Dead)
    [37205] = true, -- Animus Geode (Eyes of Azura)
    [37211] = true, -- Q4854 Empower Heart (Eyes of Azura)
    [38246] = true, -- Animus Geode (Eyes of Azura)

    ---------------------------
    -- Seasonal Quest ---------
    ---------------------------

    -- New Life Festival
    [84847] = true, -- Celebratory Belch (Stonetooth Bash)
    [84125] = true, -- Breton Male Dance (Lava Foot Stomp)
    [84126] = true, -- Breton Female Dance (Lava Foot Stomp)
    [84127] = true, -- Dunmer Male Dance (Lava Foot Stomp)
    [84128] = true, -- Dunmer Female Dance (Lava Foot Stomp)
    [84130] = true, -- Altmer Male Dance (Lava Foot Stomp)
    [84131] = true, -- Altmer Female Dance (Lava Foot Stomp)
    [84133] = true, -- Nord Dance (Lava Foot Stomp)
    [84528] = true, -- Flame Juggling (Castle Charm Challenge)
    [84506] = true, -- Dagger Juggling (Castle Charm Challenge)
    [84533] = true, -- Sword Swallowing (Castle Charm Challenge)

}

E.CastDurationFix = {

    [37059] = 1165, -- Mount Up
    [14644] = 4000, -- Revive (Death Dialogue)
    [32346] = 5800, -- Skyshard Collect
    [47270] = 5600, -- Ritual of Mara
    [14031] = 5000, -- Mundus Use
    [4197] = 4000, -- Recovering (NPC Duel)

    [89469] = 5000, -- 68235 Stun
    [89645] = 5000, -- 68235 Stun
    [105217] = 5000, -- 68235 Stun
    [89654] = 5000, -- 68235 Stun

    -- Seasonal Mementos and Items
    [86792] = 3000, -- Eating (High Hrothgar Festival Mints)
    [86739] = 3000, -- Drinking (Sailor's Warning Festival Grog)
    [85355] = 12000, -- Flame Juggling (Consumable Version)
    [85354] = 12000, -- Dagger Juggling (Consumable Verison)
    [85353] = 12000, -- Sword Swallowing (Consumable Version)
    [102077] = 2000, -- Jester's Festival Scintillator (Jester's Scintillator)
    [81575] = 2000, -- Event - WitchFest Cauldron (Witchmother's Whistle)

    -- Memento (Crown)
    [85347] = 12000, -- Storm Orb Juggle (Atronach Juggling)
    [97273] = 9000, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [99318] = 9000, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    [99319] = 8000, -- Flame Crate Memento 2 (Flame Pixie)
    [99320] = 2000, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    [101874] = 10000, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    [101877] = 9000, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    [101872] = 5000, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    [104324] = 7500, -- Psijic Pearl Summon (Psijic Celestial Orb)
    [104323] = 6000, -- Psijic Hourglass (Psijic Tautology Glass)
    [104325] = 6500, -- Psijic Disintegrate (Sapiarchic Discorporation Lens)
    [110482] = 9000, -- Rind-Renewing Pumpkin (Rind-Renewing Pumpkin)
    [110481] = 1500, -- Gourd-Gallows Stump (Gourd-Gallows Stump)

    -- Memento (Base)
    [42076] = 8000, -- Tear (Mezha-dro's Sealing Amulet)
    [34578] = 8000, -- Nirnroot Wine (Nirnroot Wine)
    [42053] = 10000, -- Yokudan Salute (Yokudan Totem)

    -- Memento (DLC)
    [89550] = 9000, -- TROPHY Azura's Light (Twilight Shard)
    [79510] = 6500, -- TROPHY Blood Oath (Blade of the Blood Oath)
    [74151] = 2500, -- Stun (Hidden Pressure Vent)
    [92862] = 4500, -- Ringing Bell (Dreamer's Chime)

    [33175] = 6300, -- Feed (Vampire)
    [40350] = 5300, -- Feed (Vampire - Bite Player)
    [33208] = 3000, -- Devour (Werewolf)
    [39033] = 1100, -- Werewolf Transform Setup (Werewolf)
    [39477] = 1500, -- De-Werewolf (Werewolf)
    [75008] = 6500, -- Werewolf Transformation (Werewolf - Quest Transformation)

    -- Sets
    [90940] = 3000, -- Eternal Warrior
    [90937] = 3000, -- Immortal Warrior
    [90935] = 3000, -- Phoenix

    -- Quest
    [39367] = 10000, -- Altar Use (Shadow of Sancre Tor)
    [36421] = 3000, -- Drink with Lyris (Council of the Five Companions)
    [34701] = 1950, -- Q4621 Destory Horn (The Tempest Unleashed)
    [22448] = 3000, -- Q4266 Tie up Hendil (The First Patient)
    [22271] = 3000, -- Teleport Scroll AB (Depths of Madness)
    [23187] = 2000, -- Q4236 PC Untie Palith (The Veiled Choice)
    [47301] = 3000, -- Stunned (Passage Denied)
    [40504] = 3500, -- Q4922 Use Mantle on Device (The Orrery of Elden Root)
    [40557] = 3500, -- (12127) CFX_4922 Mantle Cast S (The Orrery of Elden Root)
    [36710] = 4000, -- Q4833 Apply Snake Buff (Bosmer Insight)
    [36841] = 4000, -- Q4833 Apply Wolf Buff (Bosmer Insight)
    [36824] = 4000, -- Q4833 Apply Tiger Buff (Bosmer Insight)
    [33701] = 1000, -- BurrowEND (Throne of the Wilderking)

    ---------------------------
    -- Seasonal Quest ---------
    ---------------------------

    -- New Life Festival
    [84847] = 5000, -- Celebratory Belch (Stonetooth Bash)
    [84125] = 10000, -- Breton Male Dance (Lava Foot Stomp)
    [84126] = 10000, -- Breton Female Dance (Lava Foot Stomp)
    [84127] = 10000, -- Dunmer Male Dance (Lava Foot Stomp)
    [84128] = 10000, -- Dunmer Female Dance (Lava Foot Stomp)
    [84130] = 10000, -- Altmer Male Dance (Lava Foot Stomp)
    [84131] = 10000, -- Altmer Female Dance (Lava Foot Stomp)
    [84133] = 10000, -- Nord Dance (Lava Foot Stomp)
    [84528] = 12000, -- Flame Juggling (Castle Charm Challenge)
    [84506] = 12000, -- Dagger Juggling (Castle Charm Challenge)
    [84533] = 12000, -- Sword Swallowing (Castle Charm Challenge)
    [83775] = 2000, -- Event - Q5742 WitchFest Intro (The Witchmother's Bargain)

}

E.IsCast = {

    ------------------------------
    -- Player Abilities ----------
    ------------------------------

    -- Innate
    [6811] = true, -- Recall
    [69293] = true, -- Sigil of Imperial Retreat
    [37059] = true, -- Mount Up
    [14031] = true, -- Mundus Use
    [14644] = true, -- Revive (Death Dialogue)
    [32346] = true, -- Skyshard Collect
    [47270] = true, -- Ritual of Mara

    [89469] = true, -- 68235 Stun
    [89645] = true, -- 68235 Stun
    [105217] = true, -- 68235 Stun
    [89654] = true, -- 68235 Stun
    [63427] = true, -- Clean Fish
    [78052] = true, -- Minor Pardon (Counterfeit Pardon Edict)
    [76350] = true, -- Moderate Pardon (Leniency Edict)
    [76349] = true, -- Full Pardon (Grand Amnesty Edict)

    [86792] = true, -- Eating (High Hrothgar Festival Mints)
    [86739] = true, -- Drinking (Sailor's Warning Festival Grog)

    -- Memento (Seasonal)
    [85355] = true, -- Flame Juggling (Consumable Version)
    [85354] = true, -- Dagger Juggling (Consumable Verison)
    [85353] = true, -- Sword Swallowing (Consumable Version)
    [87964] = true, -- Jester's Festival Illusion Daz (Sparkwreath Dazzler)
    [87965] = true, -- Jester's Festival Illusion Daz (Plume Dazzler)
    [87966] = true, -- Jester's Festival Illusion Daz (Spiral Dazzler)
    [88374] = true, -- Jester's Festival Illusion Daz (Sparkly Hat Dazzler)
    [87963] = true, -- Bestowed Cherry Blossoms (Cherry Blossom Branch)
    [102077] = true, -- Jester's Festival Scintillator (Jester's Scintillator)
    [81575] = true, -- Event - WitchFest Cauldron (Witchmother's Whistle)
    [104324] = true, -- Psijic Pearl Summon (Psijic Celestial Orb)
    [104323] = true, -- Psijic Hourglass (Psijic Tautology Glass)
    [104325] = true, -- Psijic Disintegrate (Sapiarchic Discorporation Lens)
    [110482] = true, -- Rind-Renewing Pumpkin (Rind-Renewing Pumpkin)
    [110481] = true, -- Gourd-Gallows Stump (Gourd-Gallows Stump)

    -- Memento (Crown)
    [85347] = true, -- Storm Orb Juggle (Atronach Juggling)
    [97273] = true, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [99318] = true, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    [99319] = true, -- Flame Crate Memento 2 (Flame Pixie)
    [99320] = true, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    [101874] = true, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    [101877] = true, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    [101872] = true, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)

    -- Memento (Base)
    [26736] = true, -- Bear Trap (Battered Bear Trap)
    [16846] = true, -- Blackfeather Court Whistle (Blackfeather Court Whistle)
    [41988] = true, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [41948] = true, -- Glanir's Smoke Bomb (Glanir's Smoke Bomb)
    [43700] = true, -- Wand of Finding (Lena's Wand of Finding)
    [42076] = true, -- Tear (Mezha-dro's Sealing Amulet)
    [42105] = true, -- Nanwen's Sword (Nanwen's Sword)
    [34578] = true, -- Nirnroot Wine (Nirnroot Wine)
    [25369] = true, -- Sanguine's Goblet (Sanguine's Goblet)
    [42008] = true, -- Blessing of Root Sunder (Token of Root Sunder)
    [42053] = true, -- Yokudan Salute (Yokudan Totem)

    -- Memento (DLC)
    [89550] = true, -- TROPHY Azura's Light (Twilight Shard)
    [79510] = true, -- TROPHY Blood Oath (Blade of the Blood Oath)
    [73686] = true, -- Old Orsinium Trophy (Malacath's Wrathful Flame)
    [74151] = true, -- Stun (Hidden Pressure Vent)
    [92862] = true, -- Ringing Bell (Dreamer's Chime)

    -- Class
    [43714] = true, -- Crystal Shard (Sorcerer)
    [46331] = true, -- Crystal Blast (Sorcerer)
    [46324] = true, -- Crystal Fragments (Sorcerer)
    [24584] = true, -- Dark Exchange (Sorcerer)
    [24595] = true, -- Dark Deal (Sorcerer)
    [24589] = true, -- Dark Conversion (Sorcerer)
    [23304] = true, -- Summon Unstable Familiar
    [23319] = true, -- Summon Unstable Clannfear
    [23316] = true, -- Summon Volatile Familiar
    [24613] = true, -- Summon Winged Twilight
    [24636] = true, -- Summon Twilight Tormentor
    [24639] = true, -- Summon Twilight Matriarch

    [26114] = true, -- Puncturing Strikes (Templar)
    [26792] = true, -- Biting Jabs (Templar)
    [26797] = true, -- Puncturing Sweep (Templar)
    [22057] = true, -- Solar Flare (Templar)
    [22110] = true, -- Dark Flare (Templar)
    [22095] = true, -- Solar Barrage (Templar)
    [63029] = true, -- Radiant Destruction (Templar)
    [63044] = true, -- Radiant Glory (Templar)
    [63046] = true, -- Radiant Oppression (Templar)
    [22223] = true, -- Rite of Passage (Templar)
    [22229] = true, -- Remembrance (Templar)
    [22226] = true, -- Practiced Incantation (Templar)

    [85982] = true, -- Feral Guardian (Warden)
    [85986] = true, -- Eternal Guardian (Warden)
    [85990] = true, -- Wild Guardian (Warden)

    -- Weapon
    [28279] = true, -- Uppercut (Two Handed)
    [38814] = true, -- Dizzying Swing (Two Handed)
    [38807] = true, -- Wrecking Blow (Two Handed)
    [28607] = true, -- Flurry (Dual Wield)
    [38857] = true, -- Rapid Strikes (Dual Wield)
    [38846] = true, -- Bloodthirst (Duel Wield)
    [28882] = true, -- Snipe (Bow)
    [38685] = true, -- Lethal Arrow (Bow)
    [38687] = true, -- Focused Aim (Bow)
    [83465] = true, -- Rapid Fire (Bow)
    [85257] = true, -- Toxic Barrage (Bow)

    [31531] = true, -- Force Siphon (Restoration Staff)
    [40109] = true, -- Siphon Spirit (Restoration Staff)

    -- World
    [39270] = true, -- Soul Strike (Soul Magic)
    [40420] = true, -- Soul Assault (Soul Magic)
    [40414] = true, -- Shatter Soul (Soul Magic)
    [33175] = true, -- Feed (Vampire)
    [40350] = true, -- Feed (Vampire - Bite Player)
    [39692] = true, -- Feed (Vampire - Quest)
    [32893] = true, -- Drain Essence (Vampire)
    [32986] = true, -- Mist Form (Vampire)
    [38963] = true, -- Elusive Mist (Vampire)
    [38965] = true, -- Baleful Mist (Vampire)
    [38949] = true, -- Invigorating Drain (Vampire)
    [38956] = true, -- Accelerating Drain (Vampire)
    [33208] = true, -- Devour (Werewolf)
    [32633] = true, -- Roar (Werewolf)
    [39113] = true, -- Ferocious Roar (Werewolf)
    [39114] = true, -- Rousing Roar (Werewolf)
    [39033] = true, -- Werewolf Transform Setup (Werewolf)
    [39477] = true, -- De-Werewolf (Werewolf)
    [40515] = true, -- Devour (Werewolf - Bite Player)
    [75008] = true, -- Werewolf Transformation (Werewolf - Quest Transformation)
    [40124] = true, -- Devour (Werewolf - Quest)

    -- Guild
    [103488] = true, -- Time Stop (Psijic Order)
    [104059] = true, -- Borrowed Time (Psijic Order)
    [103706] = true, -- Channeled Acceleration (Psijic Order)
    [39489] = true, -- Blood Altar (Undaunted)
    [41967] = true, -- Sanguine Altar (Undaunted)
    [41958] = true, -- Overflowing Altar (Undaunted)

    -- Alliance War
    [61487] = true, -- Magicka Detonation (Assault)
    [61491] = true, -- Inevitable Detonation (Assault)

    -- Sets
    [90940] = true, -- Eternal Warrior
    [90937] = true, -- Immortal Warrior
    [90935] = true, -- Phoenix

    -- NPC Basic
    [4197] = true, -- Recovering (NPC Duel)

    -- Quest
    [39367] = true, -- Altar Use (Shadow of Sancre Tor)
    [37827] = true, -- Stendarr's Protection (Shadow of Sancre Tor)
    [36421] = true, -- Drink with Lyris (Council of the Five Companions)
    [47186] = true, -- CHT Portal Killer (The Weight of Three Crown)
    [35192] = true, -- Q4620 Use Lodestone (Cast Adrift)
    [34567] = true, -- Q4621 PC Storm Drain (The Tempest Unleashed)
    [34701] = true, -- Q4621 Destory Horn (The Tempest Unleashed)
    [21364] = true, -- Casting... (The Serpent's Beacon)
    [21409] = true, -- Reading... (The Serpent's Beacon)
    [22889] = true, -- Purifying... (Corruption Stones)
    [22448] = true, -- Q4266 Tie up Hendil (The First Patient)
    [22271] = true, -- Teleport Scroll AB (Depths of Madness)
    [21968] = true, -- Binding Bear... (Silent Village)
    [21040] = true, -- Q4220 Spirit Layer Ability (The Mallari-Mora)
    [22931] = true, -- Freeing Spirit... (An Act of Kindness)
    [23187] = true, -- Q4236 PC Untie Palith (The Veiled Choice)
    [47301] = true, -- Stunned (Passage Denied)
    [37463] = true, -- The Grips of Madness
    [37583] = true, -- Q4868 Unlock Chapel
    [40504] = true, -- Q4922 Use Mantle on Device (The Orrery of Elden Root)
    [40557] = true, -- (12127) CFX_4922 Mantle Cast S (The Orrery of Elden Root)
    [35984] = true, -- Q4436 Summon Pirate (Luck of the Albatross)
    [43151] = true, -- Q4768 Use Bucket
    [36710] = true, -- Q4833 Apply Snake Buff (Bosmer Insight)
    [36841] = true, -- Q4833 Apply Wolf Buff (Bosmer Insight)
    [36824] = true, -- Q4833 Apply Tiger Buff (Bosmer Insight)
    [37062] = true, -- Exorcise (The Unquiet Dead)
    [36996] = true, -- Bind Spirit (The Unquiet Dead)
    [37205] = true, -- Animus Geode (Eyes of Azura)
    [37211] = true, -- Q4854 Empower Heart (Eyes of Azura)
    [38246] = true, -- Animus Geode (Eyes of Azura)
    [41325] = true, -- Blacksap's Brew (The Blacksap's Hold)
    [33066] = true, -- Q4586_ChangeClothes (The Witcher of Silatar)
    [33701] = true, -- BurrowEND (Throne of the Wilderking)

    ---------------------------
    -- Seasonal Quest ---------
    ---------------------------

    -- Jester's Festival
    [87474] = true, -- Flower Garland (Springtime Flair)

    -- New Life Festival
    [84847] = true, -- Celebratory Belch (Stonetooth Bash)
    [84125] = true, -- Breton Male Dance (Lava Foot Stomp)
    [84126] = true, -- Breton Female Dance (Lava Foot Stomp)
    [84127] = true, -- Dunmer Male Dance (Lava Foot Stomp)
    [84128] = true, -- Dunmer Female Dance (Lava Foot Stomp)
    [84130] = true, -- Altmer Male Dance (Lava Foot Stomp)
    [84131] = true, -- Altmer Female Dance (Lava Foot Stomp)
    [84133] = true, -- Nord Dance (Lava Foot Stomp)
    [84528] = true, -- Flame Juggling (Castle Charm Challenge)
    [84506] = true, -- Dagger Juggling (Castle Charm Challenge)
    [84533] = true, -- Sword Swallowing (Castle Charm Challenge)

    -- Witches Festival
    [83775] = true, -- Event - Q5742 WitchFest Intro (The Witchmother's Bargain)

}

-- Fix for a few goofy events that channel onto the player (or just where we need it).
E.CastOverride = {

    [4197] = true, -- Recovering (NPC Duel)
    [47186] = true, -- CHT Portal Killer (The Weight of Three Crown)

}

-- Some abilities cast into a channeled stun effect - we want these abilities to display the cast and channel if flagged.
E.MultiCast = {

    [42076] = true, -- Tear (Mezha-dro's Sealing Amulet)
    [42053] = true, -- Yokudan Salute (Yokudan Totem)

}

-- If one of these abilities stuns the player - we ignore the standard effect of breaking the cast bar.
E.IgnoreCastBarStun = {

    [36434] = true, -- Mount Stun
    [74232] = true, -- Stun (Malacath's Wrathful Flame)
    [92863] = true, -- Stun (Dreamer's Chime)
    [51401] = true, -- Immortal Warrior (Immortal Yokeda)
    [81529] = true, -- Eternal Warrior (Eternal Yokeda)
    [68938] = true, -- Phoenix (of the Phoenix)

}

-- Convert a cast time ability to channeled
E.CastChannelConvert = {

    [73686] = true, -- Old Orsinium Trophy (Malacath's Wrathful Flame)
    [92862] = true, -- Ringing Bell (Dreamer's Chime)

}

-- Adds this aura to a list of fake GROUND auras to display
-- Optional: name, icon
-- Required: buff, debuff, ground = true/false
E.EffectGroundDisplay = {
    -- Monster Sets
    [59590] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_bogdan.dds', name = A.Set_Bogdan_the_Nightflame, buff = true, debuff = false, ground = false }, -- Imperial Prison Item Set (Bogdan the Nightflame)
    [97901] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds', buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus)
    [97882] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds', buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus)
    [97855] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds', buff = true, debuff = false, ground = false }, -- Earthgore (Earthgore)
    [80529] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_ilambris_shock.dds', buff = false, debuff = false, ground = true }, -- Ilambris (Ilambris)
    [80527] = { icon = 'esoui/art/icons/ava_siege_ui_002.dds', buff = false, debuff = false, ground = true }, -- Ilambris (Ilambris)
    [59587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds', name = A.Set_Lord_Warden_Dusk, buff = true, debuff = false, ground = false }, -- Lord Warden (Lord Warden)
    [59568] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = A.Set_Malubeth_the_Scourger, buff = true, debuff = false, ground = false }, -- Scourge Harvest (Malubeth)
    [59508] = { icon = 'esoui/art/icons/achievement_ic_020.dds', name = A.Set_Maw_of_the_Infernal, buff = true, debuff = false, ground = false }, -- Banished Cells Item Set (Maw of the Infernal)
    [81036] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds', buff = true, debuff = false, ground = false }, -- Sentinel of Rkugamz
    [80954] = { icon = 'esoui/art/icons/achievement_ic_017.dds', name = A.Set_Shadowrend, buff = true, debuff = false, ground = false }, -- Shadowrend Summon (Shadowrend)
    [59497] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', buff = false, debuff = false, ground = true }, -- Spawn of Mephala (Spawn of Mephala)
    [80523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds', buff = false, debuff = false, ground = true }, -- Stormfist (Stormfist)
    [102093] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds', buff = false, debuff = false, ground = true }, -- Thurvokun
    --[102136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_zaan.dds', buff = true, debuff = false, ground = false }, -- Zaan -- Buff icon for Zaan, may reimplement if I add a way to override tooltips for these.

    -- Crafted Sets
    [75930] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds', name = A.Set_Eternal_Hunt, buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 7 }, -- Daedric Mines (Eternal Hunt)
    [71671] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_light_attack.dds', buff = true, debuff = false, ground = false }, -- Morkuldin (Morkuldin)
    [106784] = { name = A.Set_Dust_Cloud, buff = false, debuff = false, ground = true }, -- Dustcloud (Adept Rider's)

    -- Overland Sets
    [75691] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', buff = false, debuff = false, ground = true }, -- Bahraha's Curse

    -- Dungeon Sets
    [97538] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', buff = true, debuff = false, ground = false }, -- Draugr's Rest
    [102106] = { icon = 'esoui/art/icons/achievement_bossflavoreasy.dds', name = A.Set_Plague_Slinger, buff = false, debuff = false, ground = true }, -- Skeever Corpse
    [97908] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', buff = true, debuff = false, ground = true }, -- Hagraven's Garden (Hagraven's)
    [67205] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds', buff = false, debuff = false, ground = true }, -- Leeching Plate (of Leeching)
    [84354] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', buff = false, debuff = false, ground = true }, -- Hand of Mephala (of Mephala's Hand)

    -- Trial Sets
    [107141] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vestment_of_olirime.dds', name = A.Set_Vestment_of_Olorime, buff = true, debuff = false, ground = false }, -- Vestment of Olirime (Olirime's)
    [109084] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vestment_of_olirime.dds', name = A.Set_Vestment_of_Olorime, buff = true, debuff = false, ground = false }, -- Ideal Vestment of Olirime (Olirime's Perfect)
    [107095] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds', buff = true, debuff = false, ground = false, }, -- Mantle of Siroria (Siroria's)
    [109081] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds', name = A.Set_Mantle_of_Siroria, buff = true, debuff = false, ground = false, }, -- Ideal Mantle of Siroria (Perfect Siroria's)

    ---------------------------
    -- Class Abilities --------
    ---------------------------

    -- Dragonknight
    [28988] = { buff = false, debuff = false, ground = true }, -- Dragonknight Standard (Dragonknight Standard - Rank 1)
    [32958] = { buff = false, debuff = false, ground = true }, -- Shifting Standard (Shifting Standard - Rank 1)
    [32947] = { buff = false, debuff = false, ground = true }, -- Standard of Might (Standard of Might - Rank 1)
    [29059] = { buff = true, debuff = false, ground = false }, -- Ash Cloud (Ash Cloud)
    [20779] = { buff = true, debuff = false, ground = false }, -- Cinder Storm (Cinder Storm)
    [32710] = { buff = false, debuff = false, ground = true }, -- Eruption (Eruption)

    -- Nightblade
    [33195] = { buff = false, debuff = false, ground = true }, -- Path of Darkness (Path of Darkness)
    [36049] = { buff = false, debuff = false, ground = true }, -- Twisting Path (Twisting Path)
    [36028] = { buff = false, debuff = false, ground = true }, -- Refreshing Path (Refreshing Path)
    [38517] = { buff = true, debuff = false, ground = false }, -- Summon Shade (Summon Shade)
    [35438] = { name = A.Skill_Dark_Shade, buff = true, debuff = false, ground = false }, -- Dark Shade (Dark Shade)
    [38528] = { name = A.Skill_Shadow_Image, buff = true, debuff = false, ground = false }, -- Shadow (Shadow Image)
    [37475] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 2 }, -- Manifestation of Terror (Nightblade)
    [25411] = { buff = true, debuff = false, ground = false }, -- Consuming Darkness (Consuming Darkness)
    [36493] = { buff = true, debuff = false, ground = false }, -- Bolstering Darkness (Bolstering Darkness)
    [36485] = { buff = true, debuff = false, ground = false }, -- Veil of Blades (Veil of Blades)

    -- Sorcerer
    [24830] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3, icon = 'esoui/art/icons/ability_sorcerer_daedric_mines.dds' }, -- Daedric Mines (Daedric Mines)
    [24847] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3, icon = 'esoui/art/icons/ability_sorcerer_daedric_tomb.dds', name = A.Skill_Daedric_Tomb }, -- Daedric Mines (Daedric Tomb)
    [25158] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 5, icon = 'esoui/art/icons/ability_sorcerer_daedric_minefield.dds', name = A.Skill_Daedric_Minefield }, -- Daedric Mines (Daedric Minefield)
    [27706] = { buff = false, debuff = false, ground = true }, -- Negate Magic (Negate Magic)
    [28341] = { buff = false, debuff = false, ground = true }, -- Suppression Field (Suppression Field)
    [28348] = { buff = false, debuff = false, ground = true }, -- Absorption Field (Absorption Field)
    [23182] = { buff = false, debuff = false, ground = true }, -- Lightning Splash (Lightning Splash)
    [23200] = { buff = false, debuff = false, ground = true }, -- Liquid Lightning (Liquid Lightning)
    [23205] = { buff = false, debuff = false, ground = true }, -- Lightning Flood (Lightning Flood)

    -- Templar
    [95933] = { icon = 'esoui/art/icons/ability_templar_sun_strike.dds', buff = false, debuff = false, ground = true }, -- Spear Shards (Spear Shards - Rank 1)
    [95957] = { icon = 'esoui/art/icons/ability_templar_light_strike.dds', buff = false, debuff = false, ground = true }, -- Luminous Shards (Luminous Shards - Rank 1)
    [26880] = { icon = 'esoui/art/icons/ability_templarsun_thrust.dds', buff = false, debuff = false, ground = true }, -- Blazing Spear (Blazing Spear - Rank 1)
    [21976] = { buff = false, debuff = false, ground = true }, -- Nova (Nova - Rank 1)
    [22003] = { buff = false, debuff = false, ground = true }, -- Solar Prison (Solar Prison - Rank 1)
    [22001] = { buff = false, debuff = false, ground = true }, -- Solar Disturbance (Solar Disturbance - Rank 1)
    [80540] = { icon = 'esoui/art/icons/ability_templar_cleansing_ritual.dds', buff = true, debuff = false, ground = false }, -- Cleansing Ritual (Cleansing Ritual - Rank 1)
    [80547] = { icon = 'esoui/art/icons/ability_templar_purifying_ritual.dds', buff = true, debuff = false, ground = false }, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
    [80553] = { icon = 'esoui/art/icons/ability_templar_extended_ritual.dds', buff = true, debuff = false, ground = false }, -- Extended Ritual (Extended Ritual - Rank 1)
    [22234] = { buff = true, debuff = false, ground = false }, -- Rune Focus (Rune Focus)
    [22240] = { buff = true, debuff = false, ground = false }, -- Channeled Focus (Channeled Focus)
    [22237] = { buff = true, debuff = false, ground = false }, -- Restoring Focus (Restoring Focus)

    -- Warden Actives
    [86161] = { buff = false, debuff = false, ground = true }, -- Impaling Shards (Impaling Shards)
    [86165] = { buff = false, debuff = false, ground = true }, -- Gripping Shards (Gripping Shards)
    [86169] = { buff = false, debuff = false, ground = true }, -- Winter's Revenge (Winter's Revenge)
    [85578] = { buff = true, debuff = false, ground = false }, -- Healing Seed (Healing Seed)
    [85840] = { buff = true, debuff = false, ground = false }, -- Budding Seeds (Budding Seeds)
    [85845] = { buff = true, debuff = false, ground = false }, -- Corrupting Pollen (Corrupting Pollen)
    [85532] = { buff = true, debuff = false, ground = false }, -- Secluded Grove (Secluded Grove)
    [85804] = { buff = true, debuff = false, ground = false }, -- Enchanted Forest (Enchanted Forest)
    [85807] = { buff = true, debuff = false, ground = false }, -- Healing Thicket (Healing Thicket)
    [86175] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Gate (Frozen Gate)
    [86179] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Device (Frozen Device)
    [86183] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Retreat (Frozen Retreat)

    ---------------------------
    -- Bow --------------------
    ---------------------------

    [28876] = { buff = false, debuff = false, ground = true }, -- Volley (Volley)
    [38689] = { buff = false, debuff = false, ground = true }, -- Endless Hail (Endless Hail)
    [38695] = { buff = false, debuff = false, ground = true }, -- Arrow Barrage (Arrow Barrage)
    [85458] = { buff = false, debuff = false, ground = true }, -- Ballista (Ballista)

    ---------------------------
    -- Destruction Staff ------
    ---------------------------

    [28807] = { buff = false, debuff = false, ground = true }, -- Wall of Fire (Wall of Elements - Rank 1)
    [28854] = { buff = false, debuff = false, ground = true }, -- Wall of Storms (Wall of Elements - Rank 1)
    [28849] = { buff = false, debuff = false, ground = true }, -- Wall of Frost (Wall of Elements - Rank 1)
    [39053] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1)
    [39073] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 1)
    [39067] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 1)
    [39012] = { buff = false, debuff = false, ground = true }, -- Blockade of Fire (Elemental Blockade - Rank 1)
    [39018] = { buff = false, debuff = false, ground = true }, -- Blockade of Storms (Elemental Blockade - Rank 1)
    [39028] = { buff = false, debuff = false, ground = true }, -- Blockade of Frost (Elemental Blockade - Rank 1)
    [83625] = { buff = false, debuff = false, ground = true }, -- Fire Storm (Elemental Storm - Rank 1)
    [83630] = { buff = false, debuff = false, ground = true }, -- Thunder Storm (Elemental Storm - Rank 1)
    [83628] = { buff = false, debuff = false, ground = true }, -- Ice Storm (Elemental Storm - Rank 1)
    [85126] = { buff = false, debuff = false, ground = true }, -- Fiery Rage (Elemental Rage - Rank 1)
    [85130] = { buff = false, debuff = false, ground = true }, -- Thunderous Rage (Elemental Rage - Rank 1)
    [85128] = { buff = false, debuff = false, ground = true }, -- Icy Rage (Elemental Rage - Rank 1)

    ---------------------------
    -- Restoration Staff ------
    ---------------------------

    [28385] = { buff = true, debuff = false, ground = false }, -- Grand Healing (Grand Healing - Rank 1)
    [40058] = { buff = true, debuff = false, ground = false }, -- Illustrious Healing (Illustrious Healing - Rank 1)
    [40060] = { buff = true, debuff = false, ground = false }, -- Healing Springs (Healing Springs - Rank 1)

    ---------------------------
    -- Fighters Guild ---------
    ---------------------------

    [35737] = { buff = true, debuff = false, ground = false }, -- Circle of Protection (Circle of Protection - Rank 1)
    [40181] = { buff = true, debuff = false, ground = false }, -- Turn Undead (Turn Undead - Rank 1)
    [40169] = { buff = true, debuff = false, ground = false }, -- Ring of Preservation (Ring of Preservation - Rank 1)
    [35750] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Trap Beast (Trap Beast - Rank 1)
    [40382] = { buff = false, debuff = false, ground = true, stackAdd = 2, stackRemove = 2, stackReset = 2 }, -- Rearming Trap (Rearming Trap - Rank 1)
    [40388] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Rearming Trap (Rearming Trap - Rank 1)
    [40372] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 1)

    ---------------------------
    -- Mages Guild ------------
    ---------------------------

    [31632] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Fire Rune (Fire Rune)
    [40470] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Volcanic Rune (Volcanic Rune)
    [40465] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Scalding Rune (Scalding Rune)
    [63430] = { icon = 'esoui/art/icons/ability_mageguild_005.dds', buff = false, debuff = false, ground = true }, -- Meteor (Meteor)
    [63456] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds', buff = false, debuff = false, ground = true }, -- Ice Comet (Ice Comet)
    [63473] = { icon = 'esoui/art/icons/ability_mageguild_005_a.dds', buff = false, debuff = false, ground = true }, -- Shooting Star (Shooting Star)

    ---------------------------
    -- Undaunted --------------
    ---------------------------

    [39489] = { buff = true, debuff = false, ground = false }, -- Blood Altar (Blood Altar)
    [41967] = { buff = true, debuff = false, ground = false }, -- Sanguine Altar (Sanguine Altar)
    [41958] = { buff = true, debuff = false, ground = false }, -- Overflowing Altar (Overflowing Altar)
    [39425] = { buff = false, debuff = false, ground = true }, -- Trapping Webs (Trapping Webs)
    [41990] = { buff = false, debuff = false, ground = true }, -- Shadow Silk (Shadow Silk)
    [42012] = { buff = false, debuff = false, ground = true }, -- Tangling Webs (Tangling Webs)

    ---------------------------
    -- Assault ----------------
    ---------------------------

    [38549] = { icon = 'esoui/art/icons/ability_ava_001.dds', buff = false, debuff = false, ground = true }, -- Caltrops (Caltrops)
    [40265] = { icon = 'esoui/art/icons/ability_ava_001_a.dds', buff = false, debuff = false, ground = true }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40251] = { icon = 'esoui/art/icons/ability_ava_001_b.dds', name = A.Skill_Razor_Caltrops, buff = false, debuff = false, ground = true }, -- Caltrops (Razor Caltrops)

    ---------------------------
    -- Support ----------------
    ---------------------------

    [38570] = { buff = true, debuff = false, ground = false }, -- Siege Shield (Siege Shield)
    [40229] = { buff = true, debuff = false, ground = false }, -- Siege Weapon Shield (Siege Weapon Shield)
    [40226] = { buff = true, debuff = false, ground = false }, -- Propelling Shield (Propelling Shield)
    [61522] = { name = A.Skill_Lingering_Flare, buff = false, debuff = false, ground = true }, -- Nova (Lingering Flare)
}

-- This will create an effect on the player or target when X skill is detected as active. SCB creates the buff by the name listed here, this way if 3 or 4 effects all need to display for 1 ability, it will only show the one aura.
E.EffectCreateSkillAura = {
    -- icon, name
    -- removeOnEnd -- Remove this aura when one of these effects ends.
    -- consolidate -- Also use this when consolidated auras is enabled.
    -- extendedDisplay - This will only display if the option to display single effects is enabled as well.

    -- Dragonknight
    [75088] = { removeOnEnd = true, consolidate = true, extendedDisplay = true, abilityId = 28969 }, -- Major Prophecy --> Inferno
    [76420] = { removeOnEnd = true, consolidate = true, abilityId = 61945 }, -- Major Prophecy --> Flames of Oblivion
    [76426] = { removeOnEnd = true, consolidate = true, abilityId = 61945 }, -- Major Savagery --> Flames of Oblivion
    [76433] = { removeOnEnd = true, consolidate = true, extendedDisplay = true, abilityId = 76429 }, -- Major Prophecy --> Cauterize
    [29011] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 29004 }, -- Major Fortitude --> Dragon Blood
    [32748] = { removeOnEnd = false, consolidate = true, abilityId = 32744 }, -- Major Endurance --> Green Dragon Blood
    [61884] = { removeOnEnd = false, consolidate = true, abilityId = 32744 }, -- Major Fortitude --> Green Dragon Blood
    [91670] = { removeOnEnd = false, consolidate = true, abilityId = 32744 }, -- Minor Vitality --> Green Dragon Blood
    [91674] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 32722 }, -- Major Fortitude --> Coagulating Blood
    [92507] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 29043 }, -- Major Sorcery --> Molten Weapons
    [76518] = { removeOnEnd = false, consolidate = true, abilityId = 31874 }, -- Major Brutality --> Igneous Weapons
    [92503] = { removeOnEnd = false, consolidate = true, abilityId = 31874 }, -- Major Sorcery --> Igneous Weapons
    [31818] = { removeOnEnd = false, consolidate = true, abilityId = 31816 }, -- Minor Resolve (Stone Giant)
    [108801] = { removeOnEnd = false, consolidate = true, abilityId = 31816 }, -- Minor Ward (Stone Giant)

    -- Nightblade
    [90587] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 33375 }, -- Major Evasion --> Blur
    [90593] = { removeOnEnd = false, consolidate = true, abilityId = 35414 }, -- Major Evasion --> Mirage
    [61817] = { removeOnEnd = false, consolidate = true, abilityId = 35414 }, -- Minor Resolve --> Mirage
    [68512] = { removeOnEnd = false, consolidate = true, abilityId = 35414 }, -- Minor Ward --> Mirage
    [90620] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 35419 }, -- Major Evasion --> Double Take
    [34837] = { removeOnEnd = true, consolidate = true, extendedDisplay = true, abilityId = 34835 }, -- Minor Vitality --> Swallow Soul
    [33317] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 33316  }, --> Major Brutality --> Drain Power
    [36903] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 36901 }, --> Major Brutality --> Power Extraction
    [36894] = { removeOnEnd = false, consolidate = true, abilityId = 36891 }, -- Major Brutality --> Sap Essence
    [62240] = { removeOnEnd = false, consolidate = true, abilityId = 36891 }, -- Major Sorcery --> Sap Essence

    -- Templar
    [26213] = { removeOnEnd = true, consolidate = true, abilityId = 26209 }, -- Minor Fortitude (Restoring Aura - All Ranks)
    [26216] = { removeOnEnd = true, consolidate = true, abilityId = 26209 }, -- Minor Intellect (Restoring Aura - All Ranks)
    [26215] = { removeOnEnd = true, consolidate = true, abilityId = 26209 }, -- Minor Endurance (Restoring Aura - All Ranks)
    [22236] = { consolidate = true, abilityId = 22234 }, -- Major Resolve (Rune Focus - Rank 1)
    [44820] = { consolidate = true, abilityId = 22234 }, -- Major Ward (Rune Focus - Rank 1)
    [44828] = { consolidate = true, abilityId = 22240 }, -- Major Resolve (Channeled Focus - Rank 1)
    [44827] = { consolidate = true, abilityId = 22240 }, -- Major Ward (Channeled Focus - Rank 1)
    [44836] = { consolidate = true, abilityId = 22237 }, -- Major Resolve (Restoring Focus - Rank 1)
    [44835] = { consolidate = true, abilityId = 22237 }, -- Major Ward (Restoring Focus - Rank 1)
    [37027] = { consolidate = true, abilityId = 22237 }, -- Minor Vitality (Restoring Focus - Rank 1)
    [77056] = { consolidate = true, abilityId = 22237 }, -- Minor Protection (Restoring Focus - Rank 1)

    -- Warden
    [86267] = { consolidate = true, abilityId = 86037 }, -- Major Expedition --> Falcon's Swiftness
    [86268] = { consolidate = true, abilityId = 86037 }, -- Major Endurance --> Falcon's Swiftness
    [89076] = { consolidate = true, abilityId = 86041 }, -- Major Expedition --> Deceptive Predator
    [89077] = { consolidate = true, abilityId = 86041 }, -- Major Endurance --> Deceptive Predator
    [87861] = { consolidate = true, abilityId = 86041 }, -- Minor Evasion --> Deceptive Predator
    [89078] = { consolidate = true, abilityId = 86045 }, -- Major Expedition --> Bird of Prey
    [89079] = { consolidate = true, abilityId = 86045 }, -- Major Endurance --> Bird of Prey
    [87864] = { consolidate = true, abilityId = 86045 }, -- Minor Berserk --> Bird of Prey
    [86300] = { consolidate = true, abilityId = 85862 }, -- Minor Intellect (Enchanted Growth)
    [87019] = { consolidate = true, abilityId = 85862 }, -- Minor Endurance (Enchanted Growth)
    [86224] = { consolidate = true, abilityId = 86122 }, -- Major Resolve --> Frost Cloak
    [86225] = { consolidate = true, abilityId = 86122 }, -- Major Ward --> Frost Cloak
    [88758] = { consolidate = true, abilityId = 86126 }, -- Major Resolve --> Expansive Frost Cloak
    [88759] = { consolidate = true, abilityId = 86126 }, -- Major Ward --> Expansive Frost Cloak
    [88761] = { consolidate = true, abilityId = 86130 }, -- Major Resolve --> Ice Fortress
    [88762] = { consolidate = true, abilityId = 86130 }, -- Major Ward --> Ice Fortress
    [87194] = { consolidate = true, abilityId = 86130 }, -- Minor Protection --> Ice Fortress

    -- One Hand and Shield
    [62484] = { consolidate = true, abilityId = 38256 }, -- Major Fracture --> Pierce Armor
    [62485] = { consolidate = true, abilityId = 38256 }, -- Major Breach --> Pierce Armor

    -- Dual Wield
    [68807] = { consolidate = true, extendedDisplay = true, abilityId = 21157 }, -- Major Brutality (Hidden Blade)
    [68859] = { consolidate = true, extendedDisplay = true, abilityId = 38914 }, -- Major Brutality (Shrouded Daggers)
    [68814] = { consolidate = true, extendedDisplay = true, abilityId = 38910 }, -- Major Brutality (Flying Blade)

    -- Destruction Staff
    [53881] = { removeOnEnd = true, abilityId = 29173 }, -- Major Breach --> Weakness to Elements
    [62775] = { removeOnEnd = true, abilityId = 39089 }, -- Major Breach (Elemental Susceptibility - Rank 1)
    [62787] = { removeOnEnd = true, abilityId = 39095 }, -- Major Breach (Elemental Drain - Rank 1)
    [39100] = { removeOnEnd = true, abilityId = 39095 }, -- Minor Magickasteal (Elemental Drain - Rank 1)

    -- Restoration Staff
    [37247] = { consolidate = true, abilityId = 37243 }, -- Minor Resolve (Blessing of Protection - Rank 1)
    [62619] = { consolidate = true, abilityId = 37243 }, -- Minor Ward (Blessing of Protection - Rank 1)
    [62626] = { consolidate = true, abilityId = 40103, name = A.Skill_Blessing_of_Restoration }, -- Minor Resolve (Blessing of Restoration - Rank 1)
    [62627] = { consolidate = true, abilityId = 40103, name = A.Skill_Blessing_of_Restoration }, -- Minor Ward (Blessing of Restoration - Rank 1)
    [62634] = { consolidate = true, abilityId = 40094 }, -- Minor Resolve (Combat Prayer - Rank 1)
    [62635] = { consolidate = true, abilityId = 40094 }, -- Minor Ward (Combat Prayer - Rank 1)
    [62636] = { consolidate = true, abilityId = 40094 }, -- Minor Berserk (Combat Prayer - Rank 1)
    [88565] = { removeOnEnd = true, abilityId = 31531 }, -- Minor Lifesteal (Force Siphon - Rank 1)
    [88575] = { removeOnEnd = true, abilityId = 40109 }, -- Minor Lifesteal (Siphon Spirit - Rank 1)
    [88576] = { removeOnEnd = true, abilityId = 40109 }, -- Minor Lifesteal (Siphon Spirit - Rank 1)
    [88606] = { removeOnEnd = true, abilityId = 40116 }, -- Minor Lifesteal (Quick Siphon - Rank 1)

    -- Armor
    [63015] = { consolidate = true, extendedDisplay = true, abilityId = 29556 }, -- Major Evasion --> Evasion
    [63019] = { consolidate = true, extendedDisplay = true, abilityId = 39195 }, -- Major Evasion --> Shuffle
    [63030] = { consolidate = true, extendedDisplay = true, abilityId = 39192 }, -- Major Evasion --> Elude
    [63084] = { consolidate = true, abilityId = 29552 }, -- Major Resolve --> Immovable
    [63085] = { consolidate = true, abilityId = 29552 }, -- Major Ward --> Immovable
    [63134] = { consolidate = true, abilityId = 39205 }, -- Major Resolve --> Immovable Brute
    [63135] = { consolidate = true, abilityId = 39205 }, -- Major Ward --> Immovable Brute
    [63119] = { consolidate = true, abilityId = 39197 }, -- Major Resolve --> Unstoppable
    [63120] = { consolidate = true, abilityId = 39197 }, -- Major Ward --> Unstoppable

    -- Werewolf
    [39124] = { consolidate = true, extendedDisplay = true, abilityId = 39114 }, -- Major Brutality --> Rousing Roar

    -- Fighters Guild
    [80271] = { consolidate = true, removeOnEnd = true, abilityId = 35737  }, -- Minor Endurance --> Circle of Protection
    [35739] = { consolidate = true, removeOnEnd = true, abilityId = 35737 }, -- Minor Protection --> Circle of Protection
    [80276] = { consolidate = true, removeOnEnd = true, abilityId = 40181 }, -- Minor Endurance --> Turn Undead
    [40185] = { consolidate = true, removeOnEnd = true, abilityId = 40181 }, -- Minor Protection --> Turn Undead
    [80284] = { consolidate = true, removeOnEnd = true, abilityId = 40169 }, -- Minor Endurance --> Ring of Preservation
    [40171] = { consolidate = true, removeOnEnd = true, abilityId = 40169 }, -- Minor Protection --> Ring of Preservation
    [64509] = { consolidate = true, extendedDisplay = true, removeOnEnd = true, abilityId = 35762 }, -- Major Savagery --> Expert Hunter

    -- Mages Guild
    [77928] = { consolidate = true, extendedDisplay = true, removeOnEnd = true, abilityId = 30920 }, -- Major Prophecy --> Magelight
    [77945] = { consolidate = true, extendedDisplay = true, removeOnEnd = true, abilityId = 40478 }, -- Major Prophecy --> Inner Light
    [77958] = { consolidate = true, extendedDisplay = true, removeOnEnd = true, abilityId = 40483 }, -- Major Prophecy --> Radiant Magelight
    [40443] = { consolidate = true, abilityId = 40441 }, -- Balance --> Major Ward
    [80160] = { consolidate = true, abilityId = 40441 }, -- Balance --> Major Resolve

    -- Psijic Order
    [103521] = { consolidate = true, extendedDisplay = true, abilityId = 103503 }, -- Minor Force --> Accelerate
    [103708] = { consolidate = true, extendedDisplay = true, abilityId = 103706 }, -- Minor Force --> Channeled Acceleration
    [103712] = { consolidate = true, extendedDisplay = true, abilityId = 103710 }, -- Minor Force --> Race Against Time

    -- Assault
    [101161] = { consolidate = true, removeOnEnd = true, abilityId = 38566 }, -- Major Expedition (Rapid Maneuver)
    [57472] = { consolidate = true, removeOnEnd = true, abilityId = 38566 }, -- Major Gallop (Rapid Maneuver)
    [101169] = {consolidate = true, removeOnEnd = true, abilityId = 40211 }, -- Major Expedition (Retreating Maneuver)
    [57477] = { consolidate = true, removeOnEnd = true, abilityId = 40211 }, -- Major Gallop (Retreating Maneuver)
    [101178] = { consolidate = true, removeOnEnd = true, abilityId = 40215 }, -- Major Expedition (Charging Maneuver)
    [57481] = { consolidate = true, removeOnEnd = true, abilityId = 40215 }, -- Major Gallop (Charging Maneuver)

    -- Sets
    [106867] = { alwaysShow = true, abilityId = 106865 }, -- Major Evasion --> Grace of Gloom

    -- NPC's
    -- Always Show = show regardless of menu setting
    [65235] = { alwaysShow = true, removeOnEnd = true, abilityId = 33097 }, -- Enrage (Vosh Rakh Devoted)
    [50187] = { alwaysShow = true, removeOnEnd = true, abilityId = 33097 }, -- Enrage (Mantikora)
    [56689] = { alwaysShow = true, removeOnEnd = true, abilityId = 33097 }, -- Enraged (Mantikora)

}

-- Toggle a few options for some potentially useful skills.
function E.BarHighlightRefresh()
    if LUIE.CombatInfo.SV.ShowToggledSecondary then
        -- Dragonknight
        E.BarHighlightOverride[31816] = { newId = 31818, showFakeAura = true, secondary = true, noRemove = true } -- Stone Giant --> Minor Resolve

        -- Nightblade
        E.BarHighlightOverride[25255] = { newId = 25256, secondary = true } -- Veiled Strike --> Off Balance
        E.BarHighlightOverride[25260] = { newId = 34733, secondary = true } -- Surprise Attack --> Off Balance
        E.BarHighlightOverride[25267] = { newId = 34737, secondary = true } -- Concealed Weapon --> Off Balance

        -- Templar
        E.BarHighlightOverride[26792] = { duration = 8000, showFakeAura = true, secondary = true, noRemove = true } -- Biting Jabs --> Major Savagery
        E.BarHighlightOverride[22229] = { newId = 22233, showFakeAura = true, secondary = true, noRemove = true } -- Remembrance --> Major Protection

        -- Restoration Staff
        E.BarHighlightOverride[85132] = { newId = 85154, showFakeAura = true, secondary = true, noRemove = true } -- Light's Champion --> Major Force

        -- Werewolf
        E.BarHighlightOverride[32633] = { newId = 45821, secondary = true } -- Roar --> Off Balance
        E.BarHighlightOverride[39113] = { newId = 45834, secondary = true } -- Ferocious Roar --> Off Balance

        -- Mages Guild
        E.BarHighlightOverride[28567] = { newId = 63223, showFakeAura = true, secondary = true, noRemove = true } -- Entropy --> Major Sorcery
        E.BarHighlightOverride[40457] = { newId = 63227, showFakeAura = true, secondary = true, noRemove = true } -- Degeneration --> Major Sorcery
        E.BarHighlightOverride[40452] = { newId = 63231, showFakeAura = true, secondary = true, noRemove = true } -- Structured Entropy --> Major Sorcery
    else
        -- Dragonknight
        E.BarHighlightOverride[31816] = { newId = 31817} -- Stone Giant

        -- Nightblade
        E.BarHighlightOverride[25255] = { newId = 33185 } -- Veiled Strike
        E.BarHighlightOverride[25260] = { newId = 34734 } -- Surprise Attack
        E.BarHighlightOverride[25267] = { newId = 34736 } -- Concealed Weapon

        -- Templar
        E.BarHighlightOverride[26792] = { newId = 76912, duration = 2000, showFakeAura = true, noRemove = true } -- Biting Jabs
        E.BarHighlightOverride[22229] = { showFakeAura = true } -- Remembrance (Remembrance - Rank 1)

        -- Werewolf
        E.BarHighlightOverride[32633] = { newId = 45823 } -- Roar
        E.BarHighlightOverride[39113] = { newId = 45836 } -- Ferocious Roar

        -- Restoration Staff
        E.BarHighlightOverride[85132] = nil -- Light's Champion

        -- Mages Guild
        E.BarHighlightOverride[28567] = nil -- Entropy
        E.BarHighlightOverride[40457] = nil -- Degeneration
        E.BarHighlightOverride[40452] = nil -- Structured Entropy
    end
end

E.BarHighlightOverride = {
    -- newId = replace ID
    -- showFakeAura = USE EVENT_COMBAT_EVENT instead - allows auras to display even if they weren't applied. Should be used with major/minor effects.
    -- secondary = If menu option disabled, do not show this highlight
    -- noRemove = don't remove effect on fading -- Doesn't apply to hostile effects. Should be used with major/minor effects.
    -- duration = override duration

    ---------------------------
    -- Dragonknight -----------
    ---------------------------

    -- Ardent Flame
    [23806] = { newId = 23808, secondary = true }, -- Lava Whip --> Off Balance
    [20805] = { newId = 20806, secondary = true }, -- Molten Whip --> Off Balance
    [20816] = { newId = 34117, secondary = true }, -- Flame Lash --> Off Balance
    [20657] = { newId = 44363 }, -- Searing Strike
    [20668] = { newId = 44369 }, -- Venomous Claw
    [20660] = { newId = 44373 }, -- Burning Embers
    [20917] = { newId = 31102 }, -- Fiery Breath
    [20944] = { newId = 31103 }, -- Noxious Breath
    [20930] = { newId = 31104 }, -- Engulfing Flames
    [20492] = { newId = 76498, showFakeAura = true, secondary = true, noRemove = true }, -- Fiery Grip --> Major Expedition (Note doesn't refresh when longer duration Major Expedition is present)
    [20499] = { newId = 76506, showFakeAura = true, secondary = true, noRemove = true }, -- Empowering Chains --> Major Expedition (Note doesn't refresh when longer duration Major Expedition is present)
    [20496] = { newId = 76502, showFakeAura = true, secondary = true, noRemove = true }, -- Unrelenting Grip --> Major Expedition (Note doesn't refresh when longer duration Major Expedition is present)
    [32963] = { newId = 32958 }, -- Shifting Standard

    -- Draconic Power
    [20245] = { newId = 20527 }, -- Dark Talons
    [20252] = { newId = 31898 }, -- Burning Talons
    [20251] = { newId = 20528 }, -- Choking Talons
    [29004] = { showFakeAura = true, noRemove = true }, -- Dragon Blood
    [32744] = { showFakeAura = true, noRemove = true }, -- Green Dragon Blood
    [32722] = { showFakeAura = true, noRemove = true }, -- Coagulating Blood
    [31837] = { newId = 31841, showFakeAura = true }, -- Inhale
    [32792] = { newId = 32796, showFakeAura = true }, -- Deep Breath
    [32785] = { newId = 32788, showFakeAura = true }, -- Draw Essence
    [32715] = { newId = 61814 }, -- Ferocious Leap

    -- Earthen Heart
    [29032] = { newId = 29034}, -- Stonefist
    [31820] = { newId = 31821}, -- Obsidian Shard
    [31816] = { newId = 31817}, -- Stone Giant
    [29043] = { newId = 92507, showFakeAura = true, noRemove = true }, -- Molten Weapons --> Major Sorcery
    [31874] = { newId = 92503, showFakeAura = true, noRemove = true }, -- Igneous Weapons --> Major Sorcery
    [31888] = { newId = 76537 }, -- Molten Armaments

    ---------------------------
    -- Nightblade -------------
    ---------------------------

    -- Assassination
    [18342] = { newId = 25887 }, -- Teleport Strike
    [25493] = { newId = 35336 }, -- Lotus Fan
    [25484] = { newId = 25959 }, -- Ambush
    [33375] = { newId = 90587, showFakeAura = true, noRemove = true }, -- Blur --> Major Evasion
    [35414] = { newId = 90593, showFakeAura = true, noRemove = true }, -- Mirage --> Major Evasion
    [35419] = { newId = 90620, showFakeAura = true, noRemove = true }, -- Double Take --> Major Evasion
    [33398] = { newId = 61389 }, -- Death Stroke --> Damage Taken Increased
    [36508] = { newId = 61393 }, -- Incapacitating Strike --> Damage Taken Increased
    [36514] = { newId = 61400} , -- Soul Harvest --> Damage Taken Increased
    [25091] = { newId = 25093 }, -- Soul Shred

    -- Shadow
    [25255] = { newId = 33185 }, -- Veiled Strike
    [25260] = { newId = 34734 }, -- Surprise Attack
    [25267] = { newId = 34736 }, -- Concealed Weapon
    [25375] = { newId = 25376 }, -- Shadow Cloak
    [25380] = { newId = 25381 }, -- Shadowy Disguise
    [25352] = { showFakeAura = true, duration = 4000  }, -- Aspect of Terror
    [37470] = { showFakeAura = true, duration = 4000  }, -- Mass Hysteria
    [37475] = { newId = 76639, showFakeAura = true, duration = 4000 }, -- Manifestation of Terror
    [33211] = { newId = 38517 }, -- Summon Shade
    [35434] = { newId = 35438 }, -- Dark Shade --> Summon Shade
    [35441] = { newId = 38528 }, -- Shadow Image --> Shadow

    -- Siphoning
    [33291] = { newId = 33292 }, -- Strife
    [34838] = { newId = 34840 }, -- Funnel Health
    [34835] = { newId = 34836 }, -- Swallow Soul
    [33308] = { newId = 108925, secondary = true, noRemove = true }, -- Malevolent Offering
    [34721] = { newId = 108927, secondary = true, noRemove = true }, -- Shrewd Offering
    [34727] = { newId = 108932, secondary = true, noRemove = true }, -- Healthy Offering
    [33326] = { newId = 33329 }, -- Cripple
    [36943] = { newId = 36950 }, -- Debilitate
    [36957] = { newId = 36965 }, -- Crippling Grasp
    [33316] = { newId = 33317, showFakeAura = true, noRemove = true }, -- Drain Power --> Major Brutality
    [36901] = { newId = 36903, showFakeAura = true, noRemove = true }, -- Power Extraction --> Major Brutality
    [36891] = { newId = 36894, showFakeAura = true, noRemove = true }, -- Sap Essence --> Major Brutality

    ---------------------------
    -- Sorcerer ---------------
    ---------------------------

    -- Dark Magic
    [46331] = { newId = 46332 }, -- Crystal Blast
    [24371] = { newId = 24559 }, -- Rune Prison
    [24578] = { newId = 24581 }, -- Rune Cage
    [24828] = { newId = 24830 }, -- Daedric Mines
    [24842] = { newId = 24847 }, -- Daedric Tomb --> Daedric Mines
    [24834] = { newId = 25158 }, -- Daedric Minefield --> Daedric Mines

    -- Daedric Summoning
    [108840] = { newId = 108843 }, -- Summon Unstable Familiar --> Volatile Familiar
    [77182] = { newId = 88933 }, -- Summon Volatile Familiar --> Volatile Familiar
    [24330] = { duration = 12000, showFakeAura = true }, -- Haunting Curse
    [77140] = { newId = 88937 }, -- Summon Twilight Tormentor --> Twilight Tormentor
    [23634] = { newId = 80459 }, -- Summon Storm Atronach
    [23492] = { newId = 80463 }, -- Greater Storm Atronach
    [23495] = { newId = 80468 }, -- Summon Charged Atronach

    -- Storm Calling
    [18718] = { newId = 18746 }, -- Mages' Fury
    [19123] = { newId = 19125 }, -- Mages' Wrath
    [19109] = { newId = 19118 }, -- Endless Fury
    [23234] = { newId = 23235 }, -- Bolt Escape
    [23236] = { newId = 28482 }, -- Streak
    [23277] = { newId = 23278 }, -- Ball of Lightning

    ---------------------------
    -- Templar ----------------
    ---------------------------

    -- Aedric Spear
    [26114] = { newId = 76908, duration = 2000, showFakeAura = true, noRemove = true }, -- Puncturing Strikes
    [26792] = { newId = 76912, duration = 2000, showFakeAura = true, noRemove = true }, -- Biting Jabs
    [26797] = { newId = 76916, duration = 2000, showFakeAura = true, noRemove = true }, -- Puncturing Sweep
    [26158] = { newId = 26162 }, -- Piercing Javelin
    [26800] = { newId = 26801 }, -- Aurora Javelin
    [26804] = { newId = 26805 }, -- Binding Javelin
    [22149] = { newId = 49205 }, -- Focused Charge
    [22161] = { newId = 49213 }, -- Explosive Charge
    [15540] = { newId = 15546 }, -- Toppling Charge
    [26188] = { newId = 95933 }, -- Spear Shards (Spear Shards - Rank 1)
    [26858] = { newId = 95957 }, -- Luminous Shards (Luminous Shards - Rank 1)
    [26869] = { newId = 26880 }, -- Blazing Spear (Blazing Spear - Rank 1)
    [22178] = { newId = 22179 }, -- Sun Shield
    [22182] = { newId = 22183 }, -- Radiant Ward
    [22180] = { newId = 49091 }, -- Blazing Shield
    [22138] = { newId = 62593 }, -- Radial Sweep
    [22144] = { newId = 55214 }, -- Empowering Sweep
    [22139] = { newId = 62607 }, -- Crescent Sweep

    -- Dawn's Wrath
    [21726] = { newId = 21728 }, -- Sun Fire
    [21729] = { newId = 21731 }, -- Vampire's Bane
    [21732] = { newId = 21734 }, -- Reflective Light (Reflective Light - Rank 1)
    [22057] = { newId = 109418, secondary = true }, -- Solar Flare --> Empower
    [22110] = { newId = 24686 }, -- Dark Flare
    [21752] = { newId = 21976 }, -- Nova (Nova - Rank 1)
    [21755] = { newId = 22003 }, -- Solar Prison (Solar Prison - Rank 1)
    [21758] = { newId = 22001 }, -- Solar Disturbance (Solar Disturbance - Rank 1)

    -- Restoring Light
    [22253] = { newId = 35632, secondary = true }, -- Honor the Dead
    [22314] = { newId = 108935, secondary = true, showFakeAura = true, noRemove = true }, -- Hasty Prayer --> Minor Expedition
    [26209] = { newId = 26220 }, -- Restoring Aura
    [26807] = { newId = 26809 }, -- Radiant Aura
    [22265] = { newId = 80540 }, -- Cleansing Ritual (Cleansing Ritual - Rank 1)
    [22259] = { newId = 80547 }, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
    [22262] = { newId = 80553 }, -- Extended Ritual (Extended Ritual - Rank 1)
    [22223] = { showFakeAura = true }, -- Rite of Passage
    [22229] = { showFakeAura = true }, -- Remembrance
    [22226] = { showFakeAura = true }, -- Practiced Incantation

    ---------------------------
    -- Warden -----------------
    ---------------------------

    -- Animal Companions
    [86023] = { newId = 101703 }, -- Swarm
    [86027] = { newId = 101904 }, -- Fetcher Infection
    [86031] = { newId = 101944 }, -- Growing Swarm
    [86037] = { showFakeAura = true, noRemove = true }, -- Falcon's Swiftness
    [86041] = { showFakeAura = true, noRemove = true }, -- Deceptive Predator
    [86045] = { showFakeAura = true, noRemove = true }, -- Bird of Prey

    -- Green Balance
    [85682] = { newId = 86300, showFakeAura = true, noRemove = true }, -- Enchanted Growth --> Minor Intellect
    [85922] = { newId = 85840 }, -- Budding Seeds
    [85564] = { newId = 90266 }, -- Nature's Grasp
    [85858] = { newId = 87074 }, -- Nature's Embrace

    -- Winter's Embrace
    [86122] = { newId = 86224, showFakeAura = true, noRemove = true }, -- Frost Cloak --> Major Resolve
    [86126] = { newId = 88758, showFakeAura = true, noRemove = true }, -- Expansive Frost Cloak --> Major Resolve
    [86130] = { newId = 88761, showFakeAura = true, noRemove = true }, -- Ice Fortress --> Major Resolve
    [86148] = { newId = 90833 }, -- Arctic Wind
    [86152] = { newId = 90835 }, -- Polar Wind
    [86156] = { newId = 90834 }, -- Arctic Blast

    ---------------------------
    -- Two Handed -------------
    ---------------------------

    [38814] = { newId = 38816 }, -- Dizzying Swing
    [38788] = { newId = 38791 }, -- Stampede
    [20919] = { newId = 31059 }, -- Cleave --> Cleave Bleed
    [38745] = { newId = 38747 }, -- Carve --> Carve Bleed
    [38754] = { newId = 38759 }, -- Brawler --> Brawler Bleed
    [83216] = { newId = 83217 }, -- Berserker Strike
    [83229] = { newId = 83230 }, -- Onslaught
    [83238] = { newId = 83239 }, -- Berserker Rage

    ---------------------------
    -- One Hand and Shield ----
    ---------------------------

    [28306] = { newId = 28307, showFakeAura = true }, -- Puncture --> Major Fracture
    [38256] = { newId = 62474, showFakeAura = true }, -- Ransack --> Major Fracture
    [38250] = { newId = 62484, showFakeAura = true }, -- Pierce Armor --> Major Fracture
    [28304] = { newId = 29308, showFakeAura = true }, -- Low Slash --> Minor Maim
    [38268] = { newId = 62495, showFakeAura = true }, -- Deep Slash --> Minor Maim
    [38264] = { newId = 62504, showFakeAura = true }, -- Heroic Slash --> Minor Maim
    [28719] = { newId = 28720 }, -- Shield Charge
    [38401] = { newId = 38404 }, -- Shielded Assault
    [38405] = { newId = 38407 }, -- Invasion
    [28365] = { newId = 83433 }, -- Power Bash
    [38455] = { newId = 38838, showFakeAura = true }, -- Reverberating Bash --> Major Defile
    [38452] = { newId = 80625 }, -- Power Slam

    ---------------------------
    -- Dual Wield -------------
    ---------------------------

    [28379] = { newId = 29293 }, -- Twin Slashes --> Twin Slashes Bleed
    [38839] = { newId = 38841 }, -- Rending Slashes --> Rending Slashes Bleed
    [38845] = { newId = 38852 }, -- Blood Craze
    [38891] = { newId = 68801, showFakeAura = true, noRemove = true, secondary = true }, -- Whirling Blades --> Major Endurance
    [21157] = { newId = 68807, showFakeAura = true, noRemove = true }, -- Hidden Blade --> Major Brutality
    [38914] = { newId = 68859, showFakeAura = true, noRemove = true }, -- Shrouded Daggers --> Major Brutality
    [38910] = { newId = 68814, showFakeAura = true, noRemove = true }, -- Flying Blade --> Major Brutality
    [83600] = { newId = 85156 }, -- Lacerate
    [85187] = { newId = 85192 }, -- Rend
    [85179] = { newId = 85182 }, -- Thrive in Chaos

    ---------------------------
    -- Bow --------------------
    ---------------------------

    [38685] = { newId = 38686, showFakeAura = true, secondary = true }, -- Lethal Arrow --> Major Defile
    [38687] = { newId = 38699 }, -- Focused Aim
    [28879] = { newId = 28887 }, -- Scatter Shot
    [38672] = { newId = 38674 }, -- Magnum Shot
    [38669] = { newId = 38670 }, -- Draining Shot
    [31271] = { newId = 31272 }, -- Arrow Spray
    [38705] = { newId = 38707 }, -- Bombard
    [38701] = { newId = 38703 }, -- Acid Spray
    [28869] = { newId = 44540 }, -- Poison Arrow
    [38645] = { newId = 44545 }, -- Venom Arrow
    [38660] = { newId = 44549 }, -- Poison Injection
    [85257] = { newId = 85261 }, -- Toxic Barrage
    [85451] = { newId = 85458 }, -- Ballista

    ---------------------------
    -- Destruction Staff ------
    ---------------------------

    [46348] = { newId = 48011 }, -- Crushing Shock --> Uber Attack
    [29073] = { newId = 62648 }, -- Flame Touch (Destructive Touch - Rank 1)
    [29089] = { newId = 62722 }, -- Shock Touch (Destructive Touch - Rank 1)
    [29078] = { newId = 62692 }, -- Frost Touch (Destructive Touch - Rank 1)
    [38985] = { newId = 62668 }, -- Flame Clench (Destructive Clench - Rank 1)
    [38993] = { newId = 62733 }, -- Shock Clench (Destructive Clench - Rank 1)
    [38989] = { newId = 62702 }, -- Frost Clench (Destructive Clench - Rank 1)
    [38944] = { newId = 62682 }, -- Flame Reach (Destructive Reach - Rank 1)
    [38978] = { newId = 62745 }, -- Shock Reach (Destructive Reach - Rank 1)
    [38970] = { newId = 62712 }, -- Frost Reach (Destructive Reach - Rank 1)
    [29173] = { newId = 53881 }, -- Weakness to Elements (Weakness to Elements - Rank 1)
    [39089] = { newId = 62775 }, -- Elemental Susceptibility (Elemental Susceptibility - Rank 1)
    [39095] = { newId = 62787 }, -- Elemental Drain (Elemental Drain - Rank 1)
    [39162] = { newId = 39168, secondary = true }, -- Flame Pulsar --> Minor Mangle
    [39167] = { newId = 39181, secondary = true }, -- Storm Pulsar --> Minor Mangle
    [39163] = { newId = 39180, secondary = true }, -- Frost Pulsar --> Minor Mangle

    ---------------------------
    -- Restoration Staff ------
    ---------------------------

    [37243] = { showFakeAura = true, noRemove = true }, -- Blessing of Protection (Blessing of Protection - Rank 1)
    [40103] = { showFakeAura = true, noRemove = true }, -- Blessing of Restoration (Blessing of Restoration - Rank 1)
    [40094] = { showFakeAura = true, noRemove = true }, -- Combat Prayer (Combat Prayer - Rank 1)
    [31531] = { newId = 88565 }, -- Force Siphon (Force Siphon - Rank 1)
    [40109] = { newId = 88575 }, -- Siphon Spirit (Siphon Spirit - Rank 1)
    [40116] = { newId = 88606 }, -- Quick Siphon (Quick Siphon - Rank 1)

    ---------------------------
    -- Armor ------------------
    ---------------------------

    [29556] = { newId = 63015, showFakeAura = true, noRemove = true }, -- Evasion --> Major Evasion
    [39195] = { newId = 63019, showFakeAura = true, noRemove = true }, -- Shuffle  --> Major Evasion
    [39192] = { newId = 63030, showFakeAura = true, noRemove = true }, -- Elude --> Major Evasion
    [29552] = { showFakeAura = true, noRemove = true }, -- Immovable
    [39205] = { showFakeAura = true, noRemove = true }, -- Immovable Brute
    [39197] = { showFakeAura = true, noRemove = true }, -- Unstoppable

    ---------------------------
    -- Vampire ----------------
    ---------------------------

    [32893] = { newId = 68883 }, -- Drain Essence
    [38949] = { newId = 68892 }, -- Invigorating Drain
    [38956] = { newId = 81493 }, -- Accelerating Drain
    [88158] = { newId = 38932 }, -- Materialize --> Clouding Swarm

    ---------------------------
    -- Werewolf ---------------
    ---------------------------

    [32632] = { newId = 38425 }, -- Pounce
    [39105] = { newId = 39108 }, -- Brutal Pounce
    [39104] = { newId = 39106 }, -- Feral Pounce
    [58317] = { newId = 58318 }, -- Hircine's Rage
    [58325] = { newId = 58327 }, -- Hircine's Fortitude
    [32633] = { newId = 45823 }, -- Roar
    [39113] = { newId = 45836 }, -- Ferocious Roar
    [39114] = { newId = 39124, showFakeAura = true, noRemove = true }, -- Rousing Roar --> Major Brutality
    [58405] = { newId = 58406 }, -- Piercing Howl --> Piercing Howl Stun
    [58742] = { newId = 58743 }, -- Howl of Despair --> Howl of Despair Stun
    [58798] = { newId = 58800 }, -- Howl of Agony --> Piercing Howl Stun
    [58855] = { newId = 58856 }, -- Infectious Claws --> Infection
    [58864] = { newId = 58865 }, -- Claws of Anguish --> Infection
    [58879] = { newId = 58880 }, -- Claws of Life --> Infection

    ---------------------------
    -- Fighters Guild ---------
    ---------------------------

    [35721] = { newId = 35736 }, -- Silver Bolts
    [40300] = { newId = 40302 }, -- Silver Shards
    [40336] = { newId = 40340 }, -- Silver Leash
    [35750] = { newId = 68595, showFakeAura = true }, -- Trap Beast (Trap Beast - Rank 1)
    [40382] = { newId = 68632, showFakeAura = true }, -- Rearming Trap (Rearming Trap - Rank 1)
    [40372] = { newId = 68628, showFakeAura = true }, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 1)
    [35713] = { newId = 62305 }, -- Dawnbreaker (Dawnbreaker - Rank 1)
    [40161] = { newId = 62310 }, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 1)
    [40158] = { newId = 62314 }, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 1)

    ---------------------------
    -- Mages Guild ------------
    ---------------------------

    [31642] = { newId = 48131, secondary = true }, -- Equilibrium
    [40445] = { newId = 40449, showFakeAura = true }, -- Spell Symmetry (Spell Symmetry)
    [40441] = { newId = 40443, showFakeAura = true, noRemove = true }, -- Balance --> Major Ward
    [16536] = { newId = 63430 }, -- Meteor
    [40489] = { newId = 63456 }, -- Ice Comet
    [40493] = { newId = 63473 }, -- Shooting Star

    ---------------------------
    -- Psijic Order -----------
    ---------------------------

    [103488] = { newId = 104050 }, -- Time Stop
    [104059] = { newId = 104078 }, -- Borrowed Time
    [104079] = { newId = 104085 }, -- Time Freeze
    [103503] = { newId = 103521, showFakeAura = true, noRemove = true }, -- Accelerate --> Minor Force
    [103706] = { newId = 103708, showFakeAura = true, noRemove = true }, -- Channeled Acceleration --> Minor Force
    [103710] = { newId = 103712, showFakeAura = true, noRemove = true }, -- Race Against Time --> Minor Force
    [103543] = { hide = true }, -- Mend Wounds
    [103747] = { hide = true }, -- Mend Spirit
    [103755] = { hide = true }, -- Symbiosis

    ---------------------------
    -- Undaunted --------------
    ---------------------------

    [39475] = { newId = 41942, showFakeAura = true }, -- Inner Fire
    [42056] = { newId = 42059, showFakeAura = true }, -- Inner Rage
    [42060] = { newId = 42062, showFakeAura = true }, -- Inner Beast
    [39298] = { hide = true }, -- Necrotic Orb
    [42028] = { hide = true }, -- Mystic Orb
    [42038] = { hide = true }, -- Energy Orb

    ---------------------------
    -- Assault ----------------
    ---------------------------

    [38566] = { newId = 57472 }, -- Rapid Maneuver --> Major Gallop
    [40211] = { newId = 57477 }, -- Retreating Maneuver --> Major Gallop
    [40215] = { newId = 57481 }, -- Charging Maneuver --> Major Gallop
    [61503] = { newId = 61504 }, -- Vigor
    [61505] = { newId = 61506 }, -- Echoing Vigor
    [61507] = { newId = 61509 }, -- Resolving Vigor
    [33376] = { newId = 38549 }, -- Caltrops
    [40255] = { newId = 40265 }, -- Anti-Cavalry Caltrops
    [40242] = { newId = 40251 }, -- Razor Caltrops --> Caltrops
    [38563] = { newId = 38564 }, -- War Horn
    [40223] = { newId = 40224 }, -- Aggressive Horn
    [40220] = { newId = 40221 }, -- Sturdy Horn

    ---------------------------
    -- Support ----------------
    ---------------------------

    [38571] = { newId = 38572 }, -- Purge
    [40232] = { newId = 40233 }, -- Efficient Purge --> Purge
    [61489] = { newId = 61496 }, -- Revealing Flare
    [61519] = { newId = 61522 }, -- Lingering Flare --> Nova
    [61524] = { newId = 61528 }, -- Scorching Flare

}

E.DisguiseIcons = {
    [2571]  = { icon = 'LuiExtended/media/icons/disguises/disguise_midnight_union_disguise.dds', description = 'as a Midnight Union thief.', id = 35607 },
    [27266] = { icon = 'LuiExtended/media/icons/disguises/disguise_vanguard_uniform.dds', description = 'as a soldier in Tanval\'s Vanguard.', id = 50177 },
    [29536] = { icon = 'LuiExtended/media/icons/disguises/disguise_stormfist_disguise.dds', description = 'as a Stormfist soldier.', id = 19086 },
    [40283] = { icon = 'LuiExtended/media/icons/disguises/disguise_keepers_garb.dds', description = 'as a Keeper of the Shell.', id = 31118 },
    [40286] = { icon = 'LuiExtended/media/icons/disguises/disguise_seadrake_disguise.dds', description = 'as a Seadrake pirate.', id =  27457 },
    [40294] = { icon = 'LuiExtended/media/icons/disguises/disguise_pirate_disguise.dds', description = 'as a Blackheart Haven pirate.', id = 29986 },
    [40296] = { icon = 'LuiExtended/media/icons/disguises/disguise_red_rook_disguise.dds', description = 'as a Red Rook bandit.', id = 28076 },
    [42413] = { icon = 'LuiExtended/media/icons/disguises/disguise_colovian_uniform.dds', description = 'as a Colovian soldier.', id =  31766 },
    [42736] = { icon = 'LuiExtended/media/icons/disguises/disguise_servants_robes.dds', description = 'as a servant of Headman Bhosek.', id = 32045 },
    [43046] = { icon = 'LuiExtended/media/icons/disguises/disguise_forebear_dishdasha.dds', description = 'as a member of the Forebears.', id = 33220 },
    [43047] = { icon = 'LuiExtended/media/icons/disguises/disguise_crown_dishdasha.dds', description = 'as a member of the Crowns.', id = 33221 },
    [43508] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'in a Seaside Sanctuary disguise.', id = nil }, -- NO ICON (Probably doesn't exist)
    [43511] = { icon = 'LuiExtended/media/icons/disguises/disguise_sea_viper_armor.dds', description = 'as a Maormer soldier.', id = 33534 }, -- NO ICON
    [43515] = { icon = 'LuiExtended/media/icons/disguises/disguise_imperial_disguise.dds', description = 'as an Imperial soldier.', id = 34267 },
    [44448] = { icon = 'LuiExtended/media/icons/disguises/disguise_frostedge_bandit_disguise.dds', description = 'as a Frostedge bandit.', id = 38167 },
    [44580] = { icon = 'LuiExtended/media/icons/disguises/disguise_hollow_moon_garb.dds', description = 'as a member of the Hollow Moon.', id = nil },
    [44587] = { icon = 'LuiExtended/media/icons/disguises/disguise_northwind_disguise.dds', description = 'as a Stonetalon clan member.', id = 38878 },
    [44697] = { icon = 'LuiExtended/media/icons/disguises/disguise_hallins_stand_seventh_legion_disguise.dds', description = 'as a member of the Seventh Legion.', id = 39295 },
    [45006] = { icon = 'LuiExtended/media/icons/disguises/disguise_phaer_mercenary_disguise.dds', description = 'as a Phaer Mercenary.', id = 43716 },
    [45007] = { icon = 'LuiExtended/media/icons/disguises/disguise_quendeluun_veiled_heritance_disguise.dds', description = 'as a member of the invading Ebonheart Pact forces.', id = 43719 },
    [45008] = { icon = 'LuiExtended/media/icons/disguises/disguise_vulkhel_guard_marine_disguise.dds', description = 'as a First Auridon Marine.', id = 43722 },
    [45781] = { icon = 'LuiExtended/media/icons/disguises/disguise_kollopi_essence.dds', description = 'by the Kollopi Essence.', id = 30879 },
    [45803] = { icon = 'LuiExtended/media/icons/disguises/disguise_bloodthorn_disguise.dds', description = 'as a Bloodthorn Cultist.', id = 46281 },
    [54332] = { icon = 'LuiExtended/media/icons/disguises/disguise_fort_amol_guard_disguise.dds', description = 'as a Fort Amol guard.', id = 47574 },
    [54380] = { icon = 'LuiExtended/media/icons/disguises/disguise_steel_shrike_uniform.dds', description = 'as a member of the Steel Shrikes.', id = 19013 },
    [54483] = { icon = 'LuiExtended/media/icons/disguises/disguise_courier_uniform.dds', description = 'as a Gold Coast mercenary courier.', id = 48429 },
    [54994] = { icon = 'LuiExtended/media/icons/disguises/disguise_shadowsilk_gem.dds', description = 'as a Shadowsilk Goblin.', id = 51906 },
    [55014] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a member of Wolfbane Watch.', id = nil }, -- (Not sure it exists)
    [64260] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'in colorful Dark Elf clothing.', id = nil }, -- NO ICON (Not sure it exists)
    [71090] = { icon = 'LuiExtended/media/icons/disguises/disguise_servants_outfit.dds', description = 'as a servant of the Iron Wheel.', id = 27649 }, -- TODO: Check this ID is right
    [71541] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Castle Kvatch sentinel.', id = nil }, -- NO ICON (Not sure it exists)
    [71789] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Castle Kvatch sentinel.', id = nil }, -- NO ICON (Not sure it exists)
    --[79332] = { icon = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds', description = 'as a monk.' }, -- HAS AN AURA SO NOT NECESSARY (Note - we make an exception to HIDE this itemId to prevent errors)
    [79505] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Sentinel Guard.', id = nil }, -- NO ICON (Not sure it exists)
    [94209] = { icon = 'LuiExtended/media/icons/disguises/disguise_scarlet_judges_regalia.dds', description = 'as The Scarlet Judge.', id = 85204 },
    -- TODO: Are we missing Dunmer Cultural Garb?
}

E.AssistantIcons = {
    [GetCollectibleName(301)] = 'LuiExtended/media/icons/abilities/ability_innate_assistant_nuzhimeh.dds',
    [GetCollectibleName(300)] = 'LuiExtended/media/icons/abilities/ability_innate_assistant_pirharri.dds',
    [GetCollectibleName(267)] = 'LuiExtended/media/icons/abilities/ability_innate_assistant_tythis.dds',
}

E.AddNameAura = {

    -- World Bosses
    ['Norendo'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Soulfire Plateau)
    ['Eraman'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Soulfire Plateau)
    ['Quendia'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Soulfire Plateau)
    ['Quenyas'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Seaside Scarp Camp)
    ['Captain Blanchete'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Wreck of the Raptor)
    ['Snapjaw'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Heretic's Summons)
    ['The Nestmother'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Nestmothers Den)
    ['Anarume'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Heritance Proving Ground)

    ['Bavura the Blizzard'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Nindaeril's Perch)
    ['Nindaeril the Monsoon'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Nindaeril's Perch)
    ['Shagura'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Hircine's Henge)
    ['Gurgozu'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Hircine's Henge)
    ['Valanir\'s Shield'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Valanir's Rest)
    ['Lady Solace'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Lady Solace's Fen)
    ['Otho Rufinus'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Poacher Camp)
    ['Thugrub the Reformed'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Thugrub's Cave)

    ['Gathongor the Mauler'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Gathongor's Mine)
    ['Smiles-With-Knife'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Reconnaissance Camp)
    ['Maheelius'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Reconnaissance Camp)
    ['Navlos'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Reconnaissance Camp)
    ['Heart of Rootwater'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Rootwater Spring)
    ['Thodundor of the Hill'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Thodundor's View)
    ['Neiral'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Maormer Camp View)
    ['Hetsha'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Maormer Camp View)
    ['Jahlasri'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Maormer Camp View)


    -- Public Dungeon
    ['Nitch'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Toothmaul Gully)
    ['Thek Elf-Stabber'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Toothmaul Gully)
    ['Black Bessie'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Toothmaul Gully)
    ['Bloodroot'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Toothmaul Gully)
    ['Togga the Skewerer'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Toothmaul Gully)
    ['Dzeizik'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Toothmaul Gully)
    ['Slakkith'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Toothmaul Gully)
    ['Gorg'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Auridon (Toothmaul Gully)

    ['Great Thorn'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Root Sunder Ruins)
    ['The Devil Wrathmaw'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Root Sunder Ruins)
    ['Rootbiter'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Root Sunder Ruins)
    ['Silent Claw'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Root Sunder Ruins)
    ['Thick-Bark'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Root Sunder Ruins)
    ['Guardian of Root Sunder'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Grahtwood (Root Sunder Ruins)

    ['Lost Master'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Rulanyil's Fall)
    ['Utiasl'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Rulanyil's Fall)
    ['Skirar the Decaying'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Rulanyil's Fall)
    ['Magna Tharn'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Rulanyil's Fall)
    ['Hannat the Bonebringer'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Greenshade (Rulanyil's Fall)

    -- MSQ
    ['Ragjar'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Manifestation of Regret'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Ancient Clannfear'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Manifestation of Terror'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Mannimarco'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },

    -- Mages Guild
    ['Uncle Leo'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Haskill'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },

    -- Aldmeri Dominion
    ['High Kinlady Estre'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Mayor Aulus'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Prince Naemon'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Vicereeve Pelidil'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },

    -- Dolmen Bosses
    ['Dread Xivkyn Cauterizer'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Dread Xivkyn Dreadweaver'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Dread Xivkyn Voidstalker'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Vika'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Dylora'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Jansa'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    -- NPC's
    ['Flame Atronach'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_radiance.dds', name = A.Skill_Radiance } },
    ['Frost Atronach'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds', name = A.Skill_Chilling_Aura } },

    -- Bosses
    ['War Chief Ozozai'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Broodbirther'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } },
    ['Mad Griskild'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- A Web of Troubles
    ['Veya Releth'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell - Family Reunion
    ['Old Rust-Eye'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Delve -- Vvardenfell - Khartag Point
    ['Cliff Strider Matriarch'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Beckoner Morvayn'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Confessor Dradas'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Coaxer Veran'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Castigator Athin'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Stone-Boiler Omalas'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Brander Releth'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Mountain-Caller Hlaren'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Wakener Maras'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Nevena Nirith'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Mud-Tusk'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Guardian of Bthark'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Renduril the Hammer'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Friar Hadelar'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Steamreaver'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Artisan Lenarmen'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Nchulaeon the Eternal'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Nilarion the Cavalier'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Curate Erydno'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Inquires
    ['Savarak Fels'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Reclamining Vos
    ['Th\'krak the Tunnel-King'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Delve -- Vvardenfell -- Matus-Akin Egg Mine
    ['Slavemaster Arenim'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- The Heart of a Telvanni
    ['Chodala'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Intervention
    ['Clockwork Guardian'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Jovval Mortal-Bane'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Defense Core'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Mediator'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Mediator Core'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Assembly Core'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Barbas'] = { [1] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity } }, -- Quest -- Vvardenfell -- Divine Restoration
}

E.SynergyNameOverride = {
    ['Tonal Inverter'] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tonal_inverter.dds' }, -- Tonal Inverter (Divine Intervention)
    [A.Skill_Blade_of_Woe] = { icon = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds' }, -- Blade of Woe (Dark Brotherhood)
    [A.Skill_Black_Widows] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds' }, -- Black Widows (Undaunted)
    [A.Skill_Arachnophobia] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds' }, -- Arachnophobia (Undaunted)
    [A.Skill_Feed] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed (Vampire)
    [A.Skill_Devour] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Werewolf)
    [A.Skill_Feeding_Frenzy] = { icon = 'esoui/art/icons/ability_werewolf_005_b.dds' }, -- Feeding Frenzy (Werewolf)
    [A.Set_Shield_of_Ursus] = { icon = 'LuiExtended/media/icons/abilities/ability_set_haven_of_ursus.dds', name = A.Set_Ursus_Blessing }, -- Ursus's Blessing (Haven of Ursus)
}

E.BarNameOverride = {
    -- Dragonknight
    [A.Skill_Power_Lash] = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds', -- Power Lash (Flame Lash)

    -- Nightblade
    [A.Skill_Assassins_Will] = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', -- Assassin's Will (Grim Focus + Merciless Resolve)
    [A.Skill_Assassins_Scourge] = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', -- Assassin's Scourge (Grim Focus + Merciless Resolve)
}

E.EffectOverrideByName = {
    -- TUTORIAL

    [1718] =    { -- Attack (CH + Vvardenfell Tutorial)
                    ['Naryu Virian'] =              { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attacklight.dds' } -- Attack (Tutorial)
                },

    -- JUSTICE NPCS
    [37087] =   { -- Lightning Onslaught (Battlemage)
                    ['Estate Spellbreaker'] =       { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
                },
    [37156] =   { -- Lightning Onslaught (Battlemage)
                    ['Estate Spellbreaker'] =       { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
                },

    -- HUMAN NPCS
    [29521] =   { -- Aura of Protection (Shaman)
                    ['Aura of Protection'] =        { hide = true } -- Aura of Protection (Aura of Protection) -- Hides this buff only on the Goblin Aura of Protection to prevent duplicate display
                },

    [86704] =   { -- Chop (Peasant)
                    ['Hleran Noble'] =              { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_dagger_light.dds' }, -- Chop (Hleran Noble)
                },
    [86705] =   { -- Lop (Peasant)
                    ['Hleran Noble'] =              { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_dagger_light.dds' }, -- Lop (Hleran Noble)\
                },

    [88251] =   {
                    ['Great Bear'] =                { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_bear.dds' }, -- Call Ally (Pet Ranger)
                    ['Spider'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_tiger.dds' }, -- Call Ally (Pet Ranger)
                },

    [88248] =   {
                    ['Spider'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
                    ['Venomspit Spider'] =          { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
                    ['Websnare Spider'] =           { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
                },

    -- ANIMALS
    [7170] =    { -- Rend (Lion)
                    ['Lion'] =                      { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
                    ['Lioness'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                },
    [60630] =   { -- Rend (Lion)
                    ['Lion'] =                      { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
                    ['Lioness'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                },
    [60641] =   { -- Claw (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_claw.dds' }, -- Claw (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                },
    [7158] =    { -- Bite (Lion)
                    ['Lion'] =                      { icon = 'LuiExtended/media/icons/abilities/ability_lion_bite.dds' }, -- Bite (Lion)
                    ['Lioness'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_bite.dds' }, -- Bite (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                },
    [7161] =    { -- Double Strike (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_double_strike.dds' }, -- Double Strike (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                },
    [5362] =    { -- Slam (Skeever / Kagouti)
                    ['Kagouti'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)
                    ['Bull Kagouti'] =              { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)

                    ['Daedrat'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_slam.dds' }, -- Slam (Daedrat)
                },
    [21904] =   { -- Rend (Skeever)
                    ['Daedrat'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_rend.dds' }, -- Rend (Daedrat)
                },
    [4022] =    { -- Bite (Wolf)
                    ['Jackal'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_jackal_bite.dds' }, -- Bite (Jackal)
                },
    [42844] =   { -- Rotbone (Wolf)
                    ['Jackal'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_jackal_rotbone.dds' }, -- Rotbone (Wolf)
                },
    [14523] =   { -- Helljoint (Wolf)
                    ['Jackal'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
                },
    [75818] =   { -- Helljoint (Wolf)
                    ['Jackal'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
                },
    [8569] =    { -- Devastating Leap (Bloodfiend)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_devastating_leap.dds' }, -- Devastating Leap (Skaafin Miscreal)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_devastating_leap.dds' }, -- Devastating Leap (Skeleton)
                },
    [8550] =    { -- Slash (Bloodfiend)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Skeleton)
                    ['Bone Flayer'] =               { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
                    ['Risen Dead'] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Risen Dead)
                    ['Skaafin Wretch'] =            { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Wretch)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Miscreal)
                },
    [8551] =    { -- Slash (Bloodfiend)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Skeleton)
                    ['Bone Flayer'] =               { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
                    ['Risen Dead'] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Risen Dead)
                    ['Skaafin Wretch'] =            { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Wretch)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Miscreal)
                },
    [8564] =    { -- Rending Slash (Bloodfiend)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Skeleton)
                    ['Bone Flayer'] =               { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Bone Flayer)
                    ['Skaafin Wretch'] =            { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_rending_slash.dds' }, -- Rending Slash (Skaafin Wretch)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_rending_slash.dds' }, -- Rending Slash (Skaafin Miscreal)
                },
    [9194] =    { -- Flurry (Bloodfiend)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Skeleton)
                    ['Bone Flayer'] =               { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)
                    ['Skaafin Wretch'] =            { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_flurry.dds' }, -- Flurry (Skaafin Wretch)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_flurry.dds' }, -- Flurry (Skaafin Miscreal)
                },

    -- MONSTERS
    [9670] =    {
                    ['Spectral Lamia'] =            { icon = 'LuiExtended/media/icons/abilities/ability_lamia_strike_spectral.dds' }, -- Strike (Lamia)
                },

    [89119] =   {
                    ['Dire Wolf'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_wolf.dds' }, -- Summon Beast (Spriggan)
                    ['Websnare Spider'] =           { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
                    ['Spider'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
                    ['Venomspit Spider'] =          { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
                },
    [89102] =   {
                    ['Thunderbug'] =                { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_thunderbug.dds' }, -- Summon Beast (Spriggan)
                    ['Thunderbug Lord'] =           { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_thunderbug.dds' }, -- Summon Beast (Spriggan)
                    ['Hoarvor'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_hoarvor.dds' }, -- Summon Beast (Spriggan)
                },

    -- QUESTS
    [37021] =   {
                    ['Auroran Battlemage'] =        { icon = 'LuiExtended/media/icons/abilities/ability_mage_empower_weapon_flame_sword.dds' }, -- Empower Weapon: Flame (Auroran Battlemage)
                },
    [37028] =   {
                    ['Auroran Battlemage'] =        { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = A.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
                },
    [37029] =   {
                    ['Auroran Battlemage'] =        { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = A.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
                },
    [37030] =   {
                    ['Auroran Battlemage'] =        { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = A.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
                },
}

E.EffectSourceOverride = {
    [71678] = {pet = 'Morkuldin'}, -- Light Attack {Morkuldin}
    [71679] = {pet = 'Morkuldin'}, -- Cleave {Morkuldin}

    -- TRAPS
    [62769] = {source = A.Trap_Cold_Fire_Trap}, -- Coldharbour Flames {MQ Tutorial}
    [62770] = {source = A.Trap_Cold_Fire_Trap}, -- Coldharbour Flames {MQ Tutorial}
    [17314] = {source = A.Trap_Fire_Trap}, -- Fire Trap (Fire Trap)

    -- TRAPS (Go back over these)
    [92150] = {source = 'Dwarven Furnace'}, -- Fire Trap {Vvardenfell}
    [89481] = {source = 'Flame Jet Trap'}, -- Flame Jet {Vvardenfell}
    [88491] = {source = 'Flame Jet Trap'}, -- Searing Flame {Vvardenfell}
    [88411] = {source = 'Hammer Trap'}, -- Hammer {Vvardenfell}
    [88405] = {source = 'Hammer Trap'}, -- Hammer {Vvardenfell}
    [89663] = {source = 'Hammer Trap'}, -- Hammer {Vvardenfell}
    [89664] = {source = 'Hammer Trap'}, -- Hammer {Vvardenfell}
    [88404] = {source = 'Blade Trap'}, -- Blade {Vvardenfell}
    [88454] = {source = 'Blade Trap'}, -- Blade {Vvardenfell}
    [88455] = {source = 'Blade Trap'}, -- Blade {Vvardenfell}
    [91659] = {source = A.Trap_Falling_Rocks}, -- Falling Rocks {Vvardenfell}
    [92672] = {source = 'Red Mountain'}, -- Pyroclast  {Vvardenfell}
    [84527] = {source = 'Steam Vent'}, -- Searing Steam {Vvardenfell}

    -----------------------------------------------
    -- VVARDENFELL
    -----------------------------------------------

    -- Main Quest
    [88467] = {source = 'Baar Dau'}, -- Skyfall {Divine Disaster}
    [87102] = {source = 'Spinning Blade Trap'}, -- Spinning Blade {Divine Restoration}
    [91969] = {source = 'Spinning Blade Trap'}, -- Spinning Blade {Divine Restoration}
    [86743] = {source = 'Vapor Cloud'}, -- Accelerated Transposition {Like Blood from a Stone}

    -- Sidequests
    [89282] = {source = 'Exploding Spider'}, -- Spider Explosion {A Web of Trouble}
}

-- If one of these id's is applied then we set the buffSlot for ON_EFFECT_CHANGED to be a single name identifier to prevent more than one aura from appearing. Only works with unlimited duration or equal duration effects.
E.EffectMergeName = {

    [A.Skill_Overcharge] = "MERGED_EFFECT_OVERCHARGE",
	[A.Skill_Minor_Slayer] = "MERGED_EFFECT_SLAYER",
	[A.Skill_Minor_Aegis] = "MERGED_EFFECT_AEGIS",
    [A.Skill_Boulder_Toss] = "MERGED_EFFECT_BOULDER_TOSS",

}

E.EffectMergeId = {

    [21314] = "MERGED_EFFECT_SPIKE_TRAP_QUEST", -- Trap Sprung! (Auridon - An Act of Kindness)
    [47768] = "MERGED_EFFECT_CC_IMMUNITY_QUEST", -- RobS Immunities 6 Sec (Grahtwood - A Lasting Winter)

}

E.EffectHideSCT = { -- Force hide display of event (USED BY COMBAT CLOUD ONLY!!!)
    -- Player - Basic
    [20301] = true, -- Crouch Drain
    [15356] = true, -- Sprint Drain
    [55400] = true, -- Magicka Restore
    [55401] = true, -- Magicka Restore
    [45982] = true, -- Bash Stun

    -- Player - Champion Points
    [64245] = true, -- Shadowstrike

    -- Player - Weapons
    [18429] = true, -- Heavy Attack (Unarmed)
    [16041] = true, -- Heavy Attack (2H)
    [15279] = true, -- Heavy Attack (1H)
    [16420] = true, -- Heavy Attack (Dual Wield)
    [16691] = true, -- Heavy Attack (Bow)
    [16261] = true, -- Heavy Attack (Frost)
    [15383] = true, -- Heavy Attack (Flame)

    -- Player - Werewolf
    [111832] = true, -- Werewolf Transformation
    [111843] = true, -- Pack Leader
    [111844] = true, -- Werewolf Berserker

    -- Sets
    [32755] = true, -- Nikulas' Heavy Armor (of Nikulas)

    ----------------------------
    -- Nightblade
    ----------------------------

    [25375] = true, -- Shadow Cloak (Shadow Cloak)
    [25380] = true, -- Shadowy Disguise (Shadowy Disguise)
    [25412] = true, -- Consuming Darkness (Consuming Darkness)
    [36495] = true, -- Bolstering Darkness (Bolstering Darkness)
    [36487] = true, -- Veil of Blades (Veil of Blades)

    ----------------------------
    -- Dragonknight
    ----------------------------

    [21007] = true, -- Reflective Scale
    [21014] = true, -- Reflective Plate
    [21017] = true, -- Dragon Fire Scale
    [29126] = true, -- Ash Cloud
    [20780] = true, -- Cinder Storm
    [32712] = true, -- Eruption

    ----------------------------
    -- Sorcerer
    ----------------------------

    [26098] = true, -- Zap Snare (Summon Storm Atronach - All Morphs)
    [29824] = true, -- Negate Magic
    [47147] = true, -- Negate Magic
    [47160] = true, -- Suppression Field
    [47159] = true, -- Suppression Field
    [47168] = true, -- Absorption Field
    [47167] = true, -- Absorption Field

    ----------------------------
    -- Templar
    ----------------------------

    -- Passives
    [80195] = true, -- Sacred Ground (Sacred Ground - All Ranks) - Rune Focus
    [80230] = true, -- Sacred Ground (Sacred Ground - All Ranks) - Cleansing Ritual
    [80261] = true, -- Sacred Ground (Sacred Ground - All Ranks) - Rite of Passage

    -- Actives
    [24307] = true, -- Solar Disturbance Snare (Solar Disturbance - Rank 1)
    [37009] = true, -- Channeled Focus (Channeled Focus - Rank 1)
    [63020] = true, -- Repentance Remover (Repentance)

    ----------------------------
    -- Warden
    ----------------------------

    [87876] = true, -- Betty Netch (Betty Netch)
    [91475] = true, -- Restore Remover (Bull Netch)
    [86238] = true, -- Impaling Shards (Impaling Shards)
    [87448] = true, -- Gripping Shards (Gripping Shards)
    [88801] = true, -- Winter's Revenge (Gripping Shards)
    [86250] = true, -- Sleet Storm (Sleet Storm)
    [88858] = true, -- Northern Storm (Northern Storm)
    [88861] = true, -- Permafrost (Permafrost)

    ----------------------------
    -- One Hand and Shield
    ----------------------------

    [28727] = true, -- Defensive Posture (Defensive Posture)
    [38312] = true, -- Defensive Stance (Defensive Stance)
    [83301] = true, -- Spell Wall (Spell Wall)

    ----------------------------
    -- Destruction Staff
    ----------------------------

    [68719] = true, -- Frozen (Wall of Elements - All Ranks)
    [62928] = true, -- Wall of Frost (Wall of Elements - Rank 1)
    [39068] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 1)
    [62948] = true, -- Blockade of Frost (Elemental Blockade - Rank 1)
    [104825] = true, -- Icy Rage (Elemental Rage - All Ranks)

    ----------------------------
    -- Vampire Quest
    ----------------------------

    [39728] = true, -- VampInit_TheaterFeed
    [39509] = true, -- VampInit_PC Becomes a Vampire

    ----------------------------
    -- Psijic Order
    ----------------------------

    [103538] = true, -- Time Stop (Time Stop)
    [104007] = true, -- Time Stop (Time Stop)
    [104009] = true, -- Time Stop (Time Stop)
    [104071] = true, -- Borrowed Time (Borrowed Time)
    [104072] = true, -- Borrowed Time (Borrowed Time)
    [104073] = true, -- Borrowed Time (Borrowed Time)
    [104080] = true, -- Time Freeze (Time Freeze)
    [104081] = true, -- Time Freeze (Time Freeze)
    [104082] = true, -- Time Freeze (Time Freeze)
    [104083] = true, -- Time Freeze (Time Freeze)

    ----------------------------
    -- Undaunted
    ----------------------------

    [80079] = true, -- Trapping Webs (Trapping Webs)
    [80108] = true, -- Shadow Silk (Shadow Silk)
    [80130] = true, -- Tangling Webs (Tangling Webs)

    ----------------------------
    -- Assault
    ----------------------------

    [64118] = true, -- Hindered (Caltrops)

    -- Human NPC
    [10648] = true, -- Throw Oil (Synergy)
    [35391] = true, -- Defiled Grave (Bonelord)
    [87066] = true, -- Volanic Debris (Fire-Binder)

    -- Cyrodiil NPC
    [21632] = true, -- Lifesteal (Cryodiil Mage T1)
    [46718] = true, -- Stolen Essence (Cryodiil Mage T2)
    [51893] = true, -- Negate Magic (Cyrodiil Mender T1 + T2)

    -- Daedra NPC
    [35278] = true, -- Soul Flame (Daedric Titan)
    [51646] = true, -- Frozen Ground (Frost Atronach)
    [4829] = true, -- Fire Brand (Flesh Atronach)
    [6410] = true, -- Tail Clip (Winged Twilight)

    -- Undead NPC
    [22525] = true, -- Defiled Ground (Lich)
    [13972] = true, -- Swipe (Zombie)

    -- Monster
    [32268] = true, -- Grapple (Hag)
    [33459] = true, -- Hurricane (Nereid)
    [5881] = true, -- Smash (Ogre)
    [82685] = true, -- CC (Crown Control) Shared Cool
    [14221] = true, -- Grapple (Strangler)

    -- Main Quest
    [61648] = true, -- Replenish Stamina (Tutorial - Child of Bones)

    -- Mages Guild
    [40851] = true, -- Polymorph Snare (The Mad God's Bargain)

    -- Auridon
    [84047] = true, -- Defiled Ground (World Boss - Quenyas)

    -- Grahtwood
    [38748] = true, -- Aulus's Tongue (The Grips of Madness)

    -- Greenshade
    [83155] = true, -- Thunderous Smash (Thodundor of the Hill)

    -- Vvardenfell
    [82272] = true, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82273] = true, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [89903] = true, -- Tonal Inverter (Divine Intervention)
    [86989] = true, -- Succubus Touch (Echoes of a Fallen House)

    -- Nchuleftingth (Public Dungeon)
    [86624] = true, -- Piston Thrust (Dwarven Piston)
    [90857] = true, -- Spike Trap (Dwarven Piston)
    [84334] = true, -- Demolish (Nchulaeon the Eternal)
    [84336] = true, -- Demolish (Nchulaeon the Eternal)

    -- Forgotten Wastes (Public Dungeon)
    [86934] = true, -- Volcanic Debris
    [86938] = true, -- Volcanic Debris
    [92707] = true, -- Volcanic Debris
    [92704] = true, -- Volcanic Debris
}

E.EffectCleanseOverride = { -- Force hide display of cleanse alert (USED BY COMBAT CLOUD ONLY!!!)

    [27776] = true, -- Feeding (Daughter of Giants)
    [38215] = true -- Death's Gaze (Shadow of Sancre Tor)

}

-- Using a separate chart for ZOS Artificial Effects just in case this is significantly expanded at any point
E.ArtificialEffectOverride = {
    --[0] = { icon = 'esoui/art/icons/artificialeffect_battle-spirit.dds' }, -- Battle Spirit (Cyrodiil, Duel)
    [2] = { name = zo_strformat("<<1>> (<<2>>)", A.Skill_Battle_Spirit, A.Skill_Imperial_City) }, -- Battle Spirit Imperial City
    -- 3 = Battleground Deserter Penalty
}

-- Table of tooltips to add a third line to for Major/Minor effects. These describe the effect.
E.TooltipNameOverride = {
    [A.Skill_Minor_Resolve]         = T.Skill_Minor_Resolve,
    [A.Skill_Major_Resolve]         = T.Skill_Major_Resolve,
    [A.Skill_Minor_Ward]            = T.Skill_Minor_Ward,
    [A.Skill_Major_Ward]            = T.Skill_Major_Ward,
    [A.Skill_Minor_Fortitude]       = T.Skill_Minor_Fortitude,
    [A.Skill_Major_Fortitude]       = T.Skill_Major_Fortitude,
    [A.Skill_Minor_Endurance]       = T.Skill_Minor_Endurance,
    [A.Skill_Major_Endurance]       = T.Skill_Major_Endurance,
    [A.Skill_Minor_Intellect]       = T.Skill_Minor_Intellect,
    [A.Skill_Major_Intellect]       = T.Skill_Major_Intellect,
    [A.Skill_Minor_Sorcery]         = T.Skill_Minor_Sorcery,
    [A.Skill_Major_Sorcery]         = T.Skill_Major_Sorcery,
    [A.Skill_Minor_Prophecy]        = T.Skill_Minor_Prophecy,
    [A.Skill_Major_Prophecy]        = T.Skill_Major_Prophecy,
    [A.Skill_Minor_Brutality]       = T.Skill_Minor_Brutality,
    [A.Skill_Major_Brutality]       = T.Skill_Major_Brutality,
    [A.Skill_Minor_Savagery]        = T.Skill_Minor_Savagery,
    [A.Skill_Major_Savagery]        = T.Skill_Major_Savagery,
    [A.Skill_Minor_Berserk]         = T.Skill_Minor_Berserk,
    [A.Skill_Major_Berserk]         = T.Skill_Major_Berserk,
    [A.Skill_Minor_Force]           = T.Skill_Minor_Force,
    [A.Skill_Major_Force]           = T.Skill_Major_Force,
    [A.Skill_Minor_Vitality]        = T.Skill_Minor_Vitality,
    [A.Skill_Major_Vitality]        = T.Skill_Major_Vitality,
    [A.Skill_Minor_Mending]         = T.Skill_Minor_Mending,
    [A.Skill_Major_Mending]         = T.Skill_Major_Mending,
    [A.Skill_Minor_Protection]      = T.Skill_Minor_Protection,
    [A.Skill_Major_Protection]      = T.Skill_Major_Protection,
    [A.Skill_Minor_Evasion]         = T.Skill_Minor_Evasion,
    [A.Skill_Major_Evasion]         = T.Skill_Major_Evasion,
    [A.Skill_Minor_Expedition]      = T.Skill_Minor_Expedition,
    [A.Skill_Major_Expedition]      = T.Skill_Major_Expedition,
    [A.Skill_Major_Gallop]          = T.Skill_Major_Gallop,
    [A.Skill_Minor_Heroism]         = T.Skill_Minor_Heroism,
    [A.Skill_Major_Heroism]         = T.Skill_Major_Heroism,
    [A.Skill_Minor_Toughness]       = T.Skill_Minor_Toughness,
    [A.Skill_Major_Courage]         = T.Skill_Major_Courage,

    [A.Skill_Minor_Breach]          = T.Skill_Minor_Breach,
    [A.Skill_Major_Breach]          = T.Skill_Major_Breach,
    [A.Skill_Minor_Fracture]        = T.Skill_Minor_Fracture,
    [A.Skill_Major_Fracture]        = T.Skill_Major_Fracture,
    [A.Skill_Minor_Vulnerability]   = T.Skill_Minor_Vulnerability,
    [A.Skill_Minor_Maim]            = T.Skill_Minor_Maim,
    [A.Skill_Major_Maim]            = T.Skill_Major_Maim,
    [A.Skill_Minor_Defile]          = T.Skill_Minor_Defile,
    [A.Skill_Major_Defile]          = T.Skill_Major_Defile,
    [A.Skill_Minor_Magickasteal]    = T.Skill_Minor_Magickasteal,
    [A.Skill_Minor_Lifesteal]       = T.Skill_Minor_Lifesteal,
    [A.Skill_Minor_Enveration]      = T.Skill_Minor_Enveration,
    [A.Skill_Minor_Uncertainty]     = T.Skill_Minor_Uncertainty,
    [A.Skill_Minor_Cowardice]       = T.Skill_Minor_Cowardice,
    [A.Skill_Minor_Mangle]          = T.Skill_Minor_Mangle,

    [A.Skill_Empower]               = T.Skill_Empower,
    [A.Skill_Hindrance]             = T.Skill_Hindrance,
    [A.Skill_Stun]                  = T.Generic_Stun,
    [A.Skill_Off_Balance]           = T.Generic_Off_Balance,

    -- POTIONS
    [45239]                         = T.Generic_CC_Immunity, -- ... of Immovability (2 Traits)
    [45463]                         = T.Generic_CC_Immunity, -- ... of Immovability (3 Traits)
    [72930]                         = T.Generic_CC_Immunity, -- Alliance Health Draught
    [86698]                         = T.Generic_CC_Immunity, -- Gold Coast Survivor Elixir
    [92416]                         = T.Generic_CC_Immunity, -- Gold Coast Swift Survivor Elixir

    [45237]                         = T.Generic_Invisibility, -- ... of Invisibility (2 Traits)
    [45460]                         = T.Generic_Invisibility, -- ... of Invisibility (3 Traits)
    [86780]                         = T.Generic_Invisibility, -- Crown Invisibility Potion
    [86699]                         = T.Generic_Invisibility, -- Gold Coast Survivor Elixir
    [78058]                         = T.Generic_Invisibility, -- Roguish Escape Draught

    [79709]                         = T.Generic_Bleed, -- ... of Creeping Ravage Health (2 Traits)
    [46113]                         = T.Generic_Bleed, -- ... of Ravage Health (2 Traits)
    [46217]                         = T.Generic_Bleed, -- ... of Ravage Health (3 Traits)
    [45236]                         = T.Generic_Detection_Potion, -- ... of Detection (2 Traits)
    [45458]                         = T.Generic_Detection_Potion, -- ... of Detection (3 Traits)
    [79705]                         = T.Generic_HoT, -- ... of Lingering Restore Health (2 Traits)
    [79706]                         = T.Generic_HoT, -- ... of Lingering Restore Health (3 Traits)
    [46193]                         = T.Generic_Ravage_Magicka_Potion, -- ... of Ravage Magicka (2 Traits)
    [46237]                         = T.Generic_Ravage_Magicka_Potion, -- ... of Ravage Magicka (3 Traits)
    [46199]                         = T.Generic_Ravage_Stamina_Potion, -- ... of Ravage Stamina (2 Traits)
    [46240]                         = T.Generic_Ravage_Stamina_Potion, -- ... of Ravage Stamina (3 Traits)

    -- POISONS
    [79133]                         = T.Generic_Poison, -- ... of Drain Health (2 Traits)
    [79134]                         = T.Generic_HoT, -- ... of Drain Health (2 Traits)
    [79135]                         = T.Generic_Poison, -- ... of Drain Health (3 Traits)
    [79136]                         = T.Generic_HoT, -- ... of Drain Health (3 Traits)
    [79025]                         = T.Generic_Poison, -- ... of Ravage Health (2 Traits)
    [78922]                         = T.Generic_Poison, -- ... of Ravage Health (3 Traits)
    [79137]                         = T.Generic_Ravage_Magicka_Poison, -- of Drain Magicka (2 Traits)
    [79138]                         = T.Generic_Magicka_Regen, -- of Drain Magicka (2 Traits)
    [79037]                         = T.Generic_Ravage_Magicka_Poison, -- of Damage Magicka (2 Traits)
    [79139]                         = T.Generic_Ravage_Magicka_Poison, -- of Drain Magicka (3 Traits)
    [79140]                         = T.Generic_Magicka_Regen, -- of Drain Magicka (3 Traits)
    [79044]                         = T.Generic_Ravage_Magicka_Poison, -- of Damage Magicka (3 Traits)
    [79141]                         = T.Generic_Ravage_Stamina_Poison, -- of Drain Stamina (2 Traits)
    [79142]                         = T.Generic_Stamina_Regen, -- of Drain Stamina (2 Traits)
    [79045]                         = T.Generic_Ravage_Stamina_Poison, -- of Damage Stamina (2 Traits)
    [79143]                         = T.Generic_Ravage_Stamina_Poison, -- of Drain Stamina (3 Traits)
    [79144]                         = T.Generic_Stamina_Regen, -- of Drain Stamina (3 Traits)
    [79046]                         = T.Generic_Ravage_Stamina_Poison, -- of Damage Stamina (3 Traits)
    [79457]                         = T.Generic_Immobilize, -- Escapist's Poison (2 Traits)
    [79458]                         = T.Generic_CC_Immunity, -- Escapist's Poison (2 Traits)
    [79122]                         = T.Generic_Immobilize, -- Entrapping Poison (2 Traits)
    [79459]                         = T.Generic_Immobilize, -- Escapist's Poison (3 Traits)
    [79460]                         = T.Generic_CC_Immunity, -- Escapist's Poison (3 Traits)
    [79996]                         = T.Generic_Reveal, -- Stealth-Draining Poison (2 Traits)
    [80003]                         = T.Generic_Marked, -- Conspicuous Posion (2 Traits)
    [80002]                         = T.Generic_Reveal, -- Stealth-Draining Poison (2 Traits)
    [80004]                         = T.Generic_Marked, -- Conspicuous Posion (2 Traits)
    [79699]                         = T.Generic_Poison, -- ... of Gradual Drain Health (2 Traits)
    [79700]                         = T.Generic_HoT, -- ... of Gradual Drain Health (2 Traits)
    [79701]                         = T.Generic_Poison, -- ... of Gradual Drain Health (3 Traits)
    [79702]                         = T.Generic_HoT, -- ... of Gradual Drain Health (3 Traits)
    [79707]                         = T.Generic_Poison, -- ... of Gradual Ravage Health (2 Traits)

    [81553]                         = T.Generic_Poison, -- Cloudy Damage Health Poison
    [81551]                         = T.Generic_Poison, -- Cloudy Gradual Ravage Health Poison

    [88476]                         = T.Generic_Poison, -- Crown Debilitating Poison
    [88471]                         = T.Generic_Ravage_Magicka_Poison, -- Crown Draining Poison
    [88475]                         = T.Generic_Ravage_Stamina_Poison, -- Crown Draining Poison
    [88473]                         = T.Generic_Magicka_Regen, -- Crown Draining Poison
    [88474]                         = T.Generic_Stamina_Regen, -- Crown Draining Poison
    [88462]                         = T.Generic_Immobilize, -- Crown Trapping Poison
    [81274]                         = T.Generic_Poison, -- Crown Lethal Poison
    [81275]                         = T.Generic_Poison, -- Crown Lethal Poison

}

-- LUIE for the most part overwrites default ability tooltips due to the fact they are only exposed for buffs/debuffs that are on the player. In some cases there is no description with scaling or we need to still use the default where possible.
-- The most noteworthy case of this is Mundus Boons, where there is a tooltip but no description. We want to display a generic tooltip describing the effect if mousing over another player - but display the default for self.
E.TooltipUseDefault = {

[13940] = true, -- Boon: The Warrior
[13943] = true, -- Boon: The Mage
[13974] = true, -- Boon: The Serpent
[13975] = true, -- Boon: The Thief
[13976] = true, -- Boon: The Lady
[13977] = true, -- Boon: The Steed
[13978] = true, -- Boon: The Lord
[13979] = true, -- Boon: The Apprentice
[13980] = true, -- Boon: The Ritual
[13981] = true, -- Boon: The Lover
[13982] = true, -- Boon: The Atronach
[13984] = true, -- Boon: The Shadow
[13985] = true, -- Boon: The Tower

}

E.EffectOverride = {
    -- Override the display information for various effect auras:
    -- icon = Change Icon
    -- name = Change Name
    -- hide = Hide this aura from appearing
    -- type = 1 or BUFF_EFFECT_TYPE_DEBUFF
    -- duration = modify the duration display of this effect. ONLY NEGATIVE VALUES supported. This will subject x seconds from the duration of the effect. Can also set to 0 to display the buff for an unlimited amount of time until an action result of fade occurs.
    -- unbreakable = flag this aura as unremoveable and change border color to grey for debuffs or cyan for buffs
    -- forcedContainer = 'short' or 'long' - Forces a buff to appear in one of these containers
    -- consolidate = If the menu option to consolidate buffs is enabled, these auras will be hidden.

    -- TEMP MOVE LATER
    [64197] = { forcedContainer = 'short' }, -- Sanctuary Cyrodiil passive is considered unlimited duration, but the effect is only while the player is in the area. Should show up under short buffs.
    [54119] = { forcedContainer = 'short' }, -- Remembrance (The Anger of a King)

    -- Craglorn buffs
    [82294] = { icon = 'esoui/art/icons/achievement_craglorn_001.dds' }, -- Magicka Attunement
    [81894] = { icon = 'esoui/art/icons/achievement_craglorn_002.dds' }, -- Yokudan Might
    [82499] = { icon = 'esoui/art/icons/achievement_craglorn_003.dds' }, -- Nirncrux Infusion

    ----------------------------------------------------------------
    -- POTIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Potions (2 Traits)
    [64564] = { icon = 'LuiExtended/media/icons/potions/potion_007.dds', tooltip = A.Potion }, -- of Armor (Major Resolve)
    [79709] = { icon = 'LuiExtended/media/icons/potions/potion_014r.dds', tooltip = A.Potion }, -- of Creeping Ravage Health (Creeping Ravage Health)
    [79857] = { icon = 'LuiExtended/media/icons/potions/potion_007r.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Potion }, -- of Defile (Minor Defile)
    [45236] = { icon = 'LuiExtended/media/icons/potions/potion_009.dds', tooltip = A.Potion }, -- of Detection (Increase Detection)
    [45222] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion }, -- of Health (Major Fortitude)
    [45239] = { icon = 'LuiExtended/media/icons/potions/potion_008.dds', tooltip = A.Potion }, -- of Immovability (Unstoppable)
    [45237] = { icon = 'LuiExtended/media/icons/potions/potion_011.dds', name = A.Potion_Invisiblity, tooltip = A.Potion }, -- of Invisibility (Vanish)
    [79705] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds', tooltip = A.Potion }, -- of Lingering Health (Lingering Restore Health)
    [45224] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds', tooltip = A.Potion }, -- of Magicka (Major Intellect)
    [79712] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion }, -- of Protection (Minor Protection)
    [46208] = { icon = 'LuiExtended/media/icons/potions/potion_021.dds', tooltip = A.Potion }, -- of Ravage Armor (Minor Fracture)
    [46113] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = A.Potion_Ravage_Health, tooltip = A.Potion }, -- of Ravage Health (Health Potion Poison)
    [46193] = { icon = 'LuiExtended/media/icons/potions/potion_016.dds', tooltip = A.Potion }, -- of Ravage Magicka (Ravage Magicka)
    [47204] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds', tooltip = A.Potion }, -- of Ravage Spell Critical (Minor Uncertainty)
    [46202] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds', tooltip = A.Potion }, -- of Ravage Spell Power (Minor Cowardice)
    [46206] = { icon = 'LuiExtended/media/icons/potions/potion_018.dds', tooltip = A.Potion }, -- of Ravage Spell Protection (Minor Breach)
    [46199] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds', tooltip = A.Potion }, -- of Ravage Stamina (Ravage Stamina)
    [47203] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds', tooltip = A.Potion }, -- of Ravage Weapon Critical (Minor Enervation)
    [46204] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds', tooltip = A.Potion }, -- of Ravage Weapon Power (Minor Maim)
    [46210] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds', tooltip = A.Potion }, -- of Slow (Hindrance)
    [64566] = { icon = 'LuiExtended/media/icons/potions/potion_010.dds', tooltip = A.Potion }, -- of Speed (Major Expedition)
    [64570] = { icon = 'LuiExtended/media/icons/potions/potion_013.dds', tooltip = A.Potion }, -- of Spell Critical (Major Prophecy)
    [64558] = { icon = 'LuiExtended/media/icons/potions/potion_006.dds', tooltip = A.Potion }, -- of Spell Power (Major Sorcery)
    [64562] = { icon = 'LuiExtended/media/icons/potions/potion_004.dds', tooltip = A.Potion }, -- of Spell Protection (Major Ward)
    [45226] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds', tooltip = A.Potion }, -- of Stamina (Major Endurance)
    [68565] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', tooltip = A.Potion }, -- of Stun (Stun)
    [79848] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds', tooltip = A.Potion }, -- of Vitality (Major Vitality)
    [79844] = { icon = 'LuiExtended/media/icons/potions/potion_001r.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Potion }, -- of Vulnerability (Minor Vulnerability)
    [64568] = { icon = 'LuiExtended/media/icons/potions/potion_012.dds', tooltip = A.Potion }, -- of Weapon Critical (Major Savagery)
    [64555] = { icon = 'LuiExtended/media/icons/potions/potion_005.dds', tooltip = A.Potion }, -- of Weapon Power (Major Brutality)

    -- Crafted Potions (3 Traits)
    [64565] = { icon = 'LuiExtended/media/icons/potions/potion_007.dds', tooltip = A.Potion }, -- of Armor (Major Resolve)
    -- No ... of Creeping Ravage Health
    [79860] = { icon = 'LuiExtended/media/icons/potions/potion_007r.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Potion }, -- of Defile (Minor Defile)
    [45458] = { icon = 'LuiExtended/media/icons/potions/potion_009.dds', tooltip = A.Potion }, -- of Detection (Increase Detection)
    [63670] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion }, -- of Health (Major Fortitude)
    [45463] = { icon = 'LuiExtended/media/icons/potions/potion_008.dds', tooltip = A.Potion }, -- of Immovability (Unstoppable)
    [45460] = { icon = 'LuiExtended/media/icons/potions/potion_011.dds', name = A.Potion_Invisiblity, tooltip = A.Potion }, -- of Invisibility (Vanish)
    [79706] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds', tooltip = A.Potion }, -- of Lingering Health (Lingering Restore Health)
    [63676] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds', tooltip = A.Potion }, -- of Magicka (Major Intellect)
    [79714] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion }, -- of Protection (Minor Protection)
    [46250] = { icon = 'LuiExtended/media/icons/potions/potion_021.dds', tooltip = A.Potion }, -- of Ravage Armor (Minor Fracture)
    [46217] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = A.Potion_Ravage_Health, tooltip = A.Potion }, -- of Ravage Health (Health Potion Linger Effect) (Different name than 2 trait)
    [46237] = { icon = 'LuiExtended/media/icons/potions/potion_016.dds', tooltip = A.Potion }, -- of Ravage Magicka (Ravage Magicka)
    -- No ... of Ravage Spell Critical
    [46244] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds', tooltip = A.Potion }, -- of Ravage Spell Power (Minor Cowardice)
    [46248] = { icon = 'LuiExtended/media/icons/potions/potion_018.dds', tooltip = A.Potion }, -- of Ravage Spell Protection (Reduce Spell Resistance) (Should be Minor Breach)
    [46240] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds', tooltip = A.Potion }, -- of Ravage Stamina (Ravage Stamina)
    [47202] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds', tooltip = A.Potion }, -- of Ravage Weapon Critical (Reduce Weapon Critical) (Should be Minor Enervation)
    [46246] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds', tooltip = A.Potion }, -- of Ravage Weapon Power (Minor Maim)
    [46252] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds', tooltip = A.Potion }, -- of Slow (Hindrance)
    [64567] = { icon = 'LuiExtended/media/icons/potions/potion_010.dds', tooltip = A.Potion }, -- of Speed (Major Expedition)
    [64572] = { icon = 'LuiExtended/media/icons/potions/potion_013.dds', tooltip = A.Potion }, -- of Spell Critical (Major Prophecy)
    [64561] = { icon = 'LuiExtended/media/icons/potions/potion_006.dds', tooltip = A.Potion }, -- of Spell Power (Major Sorcery)
    [64563] = { icon = 'LuiExtended/media/icons/potions/potion_004.dds', tooltip = A.Potion }, -- of Spell Protection (Major Ward)
    [63681] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds', tooltip = A.Potion }, -- of Stamina (Major Endurance)
    -- No ... of Stun
    [79850] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds', tooltip = A.Potion }, -- of Vitality (Major Vitality)
    [79846] = { icon = 'LuiExtended/media/icons/potions/potion_001r.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Potion }, -- of Vulnerability (Minor Vulnerability)
    [64569] = { icon = 'LuiExtended/media/icons/potions/potion_012.dds', tooltip = A.Potion }, -- of Weapon Critical (Major Savagery)
    [64554] = { icon = 'LuiExtended/media/icons/potions/potion_005.dds', tooltip = A.Potion }, -- of Weapon Power (Major Brutality)

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [63672] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion  }, -- of Health (Major Fortitude)
    [63678] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds', tooltip = A.Potion }, -- of Magicka (Major Intellect)
    [63683] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds', tooltip = A.Potion }, -- of Stamina (Major Endurance)
    [72935] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds', tooltip = A.Potion }, -- Alliance Battle Draught (Major Endurance)
    [72936] = { icon = 'LuiExtended/media/icons/potions/potion_ava_yellow.dds', tooltip = A.Potion }, -- Alliance Battle Draught (Major Brutality)
    [72930] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds', tooltip = A.Potion }, -- Alliance Health Draught (Unstoppable )
    [72928] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds', tooltip = A.Potion }, -- Alliance Health Draught (Major Fortitude)
    [72933] = { icon = 'LuiExtended/media/icons/potions/potion_ava_teal.dds', tooltip = A.Potion }, -- Alliance Spell Draught (Major Sorcery)
    [72932] = { icon = 'LuiExtended/media/icons/potions/potion_ava_blue.dds', tooltip = A.Potion }, -- Alliance Spell Draught (Major Intellect)
    [78058] = { icon = 'LuiExtended/media/icons/potions/potion_ava_purple.dds', name = A.Potion_Invisiblity, tooltip = A.Potion }, -- Roguish Stealth Draught (Vanish)
    [78054] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds', tooltip = A.Potion }, -- Roguish Stealth Draught (Major Endurance)
    [78081] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds', tooltip = A.Potion }, -- Roguish Escape Draught (Major Expedition)
    [78080] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds', tooltip = A.Potion }, -- Roguish Escape Draught (Major Endurance)

    -- Crown Store Potions
    [68405] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Crown Tri-Restoration Potion (Major Fortitude)
    [68406] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', tooltip = A.Potion }, -- Crown Tri-Restoration Potion (Major Intellect)
    [68408] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', tooltip = A.Potion }, -- Crown Tri-Restoration Potion (Major Endurance)
    [86780] = { icon = 'LuiExtended/media/icons/potions/potion_crown_pink.dds', tooltip = A.Potion }, -- Crown Invisibility Potion (Invisibility)
    [86683] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', tooltip = A.Potion }, -- Crown Spellcaster's Elixir (Major Intellect)
    [86684] = { icon = 'LuiExtended/media/icons/potions/potion_crown_teal.dds', tooltip = A.Potion }, -- Crown Spellcaster's Elixir (Major Prophecy)
    [86685] = { icon = 'LuiExtended/media/icons/potions/potion_crown_teal.dds', tooltip = A.Potion }, -- Crown Spellcaster's Elixir (Major Sorcery)
    [86697] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Crown Survivor's Elixir (Major Fortitude)
    [86698] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Crown Survivor's Elixir (Unstoppable)
    [86699] = { icon = 'LuiExtended/media/icons/potions/potion_crown_pink_alt.dds', tooltip = A.Potion }, -- Crown Survivor's Elixir (Invisibility)
    [86693] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', tooltip = A.Potion }, -- Crown Warrior's Elixir (Major Endurance)
    [86694] = { icon = 'LuiExtended/media/icons/potions/potion_crown_yellow.dds', tooltip = A.Potion }, -- Crown Warrior's Elixir (Major Savagery)
    [86695] = { icon = 'LuiExtended/media/icons/potions/potion_crown_yellow.dds', tooltip = A.Potion }, -- Crown Warrior's Elixir (Major Brutality)
    [92415] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Major Fortitude (Gold Coast Swift Survivor Elixir)
    [92418] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', tooltip = A.Potion }, -- Major Expedition (Gold Coast Swift Survivor Elixir)
    [92416] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Unstoppable (Gold Coast Swift Survivor Elixir)

    ----------------------------------------------------------------
    -- POTION UP FRONT EFFECTS -------------------------------------
    ----------------------------------------------------------------

    --Crafted Potions (2 Traits)
    [45221] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health
    [45223] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka
    [46111] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds' }, -- Ravage Health
    [45225] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina

    --Crafted Potions (3 Traits)
    [45382] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health
    [45385] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka
    [46215] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = A.Potion_Ravage_Health }, -- Damage Health
    [45388] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [17302] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health (Vendor)
    [17323] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka (Vendor)
    [17328] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina (Vendor)
    [72934] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Alliance Battle Draught)
    [72927] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds' }, -- Restore Health (Alliance Health Draught)
    [72931] = { icon = 'LuiExtended/media/icons/potions/potion_ava_blue.dds' }, -- Restore Magicka (Alliance Spell Draught)
    [78053] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Roguish Stealth Draught)
    [78079] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Roguish Escape Draught)

    -- Crown Store Potions
    [68401] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = A.Potion_Restore_Health }, -- Restore All Resources (Crown Tri-Restoration Potion)
    [68407] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds' }, -- Restore Magicka (Crown Tri-Restoration Potion)
    [68409] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds' }, -- Restore Stamina (Crown Tri-Restoration Potion)
    [86682] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', name = A.Potion_Restore_Magicka }, -- Crown Spellcaster's Elixir (Crown Spellcaster's Elixir)
    [86696] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = A.Potion_Restore_Health }, -- Crown Survivor's Elixir (Crown Survivor's Elixir)
    [86692] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', name = A.Potion_Restore_Stamina }, -- Crown Warrior's Elixir (Crown Warrior's Elixir)
    [92414] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = A.Potion_Restore_Health }, -- Crown Survivor's Elixir (Gold Coast Swift Survivor Elixir)

    ----------------------------------------------------------------
    -- POSIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Poisons (2 Traits)
    [79133] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', tooltip = A.Poison }, -- Drain Health (Drain Health Poison) DEBUFF
    [79134] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', tooltip = A.Poison }, -- Restore Health (Drain Health Poison) BUFF
    [79025] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', tooltip = A.Poison }, -- Ravage Health (Damage Health Poison) DEBUFF
    [79137] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds', tooltip = A.Poison }, -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79138] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds', tooltip = A.Poison }, -- Restore Magicka (Drain Magicka Poison) BUFF
    [79037] = { icon = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds', tooltip = A.Poison }, -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79141] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', tooltip = A.Poison }, -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79142] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', tooltip = A.Poison }, -- Restore Stamina (Drain Stamina Poison) BUFF
    [79045] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', tooltip = A.Poison }, -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79284] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', tooltip = A.Poison }, -- Drain Spell Resist (Ward-Draining Poison) DEBUFF
    [79285] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', tooltip = A.Poison }, -- Minor Ward (Ward-Draining Poison) BUFF
    [79087] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', tooltip = A.Poison }, -- Minor Breach (Breaching Poison) DEBUFF
    [79309] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Drain Physical Resist (Resolve-Draining Poison) DEBUFF
    [79310] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Minor Resolve (Resolve-Draining Poison) BUFF
    [79090] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Minor Fracture (Fracturing Poison) DEBUFF
    [79193] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_r.dds', tooltip = A.Poison }, -- Minor Cowardice (Sorcery-Draining Poison) DEBUFF
    [79221] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_g.dds', tooltip = A.Poison }, -- Minor Sorcery (Sorcery-Draining Poison) BUFF
    [79069] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Cowardice (Cowardice Poison) DEBUFF
    [79280] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_r.dds', name = A.Skill_Minor_Maim, tooltip = A.Poison }, -- Drain Weapon Power (Brutality-Draining Poison) DEBUFF
    [79281] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_g.dds', tooltip = A.Poison }, -- Minor Brutality (Brutality-Draining Poison) BUFF
    [79083] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Maim (Maiming Poison) DEBUFF
    [79446] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Uncertainty (Prophecy-Draining Poison) DEBUFF
    [79447] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_g.dds', tooltip = A.Poison }, -- Minor Prophecy (Prophecy-Draining Poison) BUFF
    [79117] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Uncertainty (Uncertainty Poison) DEBUFF
    [79450] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Enervation (Savagery-Draining Poison) DEBUFF
    [79453] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_g.dds', tooltip = A.Poison }, -- Minor Savagery (Savagery-Draining Poison) BUFF
    [79113] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Enervation (Enervating Poison) DEBUFF
    [79457] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', tooltip = A.Poison }, -- Immobilize (Escapist's Poison) DEBUFF
    [79458] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', tooltip = A.Poison }, -- Unstoppable (Escapist's Poison) BUFF
    [79122] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', tooltip = A.Poison }, -- Immobilize (Entrapping Poison) DEBUFF
    [79996] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', name = A.Poison_Stealth_Draining_Poison, tooltip = A.Poison }, -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80003] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', name = A.Poison_Conspicuous_Poison, tooltip = A.Poison }, -- Marking Poison (Conspicuous Poison) DEBUFF
    [79367] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', name = A.Skill_Hindrance, tooltip = A.Poison }, -- Hindrance (Speed-Draining Poison) DEBUFF
    [79368] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', tooltip = A.Poison }, -- Major Expedition (Speed-Draining Poison) BUFF
    [79094] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', tooltip = A.Poison }, -- Hindrance (Hindering Poison) DEBUFF
    [79699] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', name = A.Poison_Creeping_Drain_Health, tooltip = A.Poison }, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79700] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', name = A.Poison_Lingering_Restore_Health, tooltip = A.Poison }, -- Restore Health (Gradual Health Drain Poison) BUFF
    [79707] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Creeping Ravage Health (Gradual Ravage Health Poison) DEBUFF
    [79723] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', tooltip = A.Poison }, -- Minor Vulnerability (Protection-Reversing Poison) DEBUFF
    [79725] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', tooltip = A.Poison }, -- Minor Protection (Protection-Reversing Poison) BUFF
    [79715] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', tooltip = A.Poison }, -- Minor Vulnerability (Vulnerability Poison) DEBUFF
    [79851] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Vitality-Draining Poison) DEBUFF
    [79852] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Minor Vitality (Vitality-Draining Poison) BUFF
    [79861] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Defiling Poison) DEBUFF

    -- Crafted Poisons (3 Traits)
    [79135] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', tooltip = A.Poison }, -- Drain Health (Drain Health Poison) DEBUFF
    [79136] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', tooltip = A.Poison }, -- Restore Health (Drain Health Poison) BUFF
    [78922] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', tooltip = A.Poison }, -- Ravage Health (Damage Health Poison) DEBUFF
    [79139] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds', tooltip = A.Poison }, -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79140] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds', tooltip = A.Poison }, -- Restore Magicka (Drain Magicka Poison) BUFF
    [79044] = { icon = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds', tooltip = A.Poison }, -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79143] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', tooltip = A.Poison }, -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79144] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', tooltip = A.Poison }, -- Restore Stamina (Drain Stamina Poison) BUFF
    [79046] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', tooltip = A.Poison }, -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79306] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', tooltip = A.Poison }, -- Drain Spell Resist (Ward-Draining Poison) DEBUFF
    [79307] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', tooltip = A.Poison }, -- Minor Ward (Ward-Draining Poison) BUFF
    [79086] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', tooltip = A.Poison }, -- Minor Breach (Breaching Poison) DEBUFF
    [79311] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Drain Physical Resist (Resolve-Draining Poison) DEBUFF
    [79312] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Minor Resolve (Resolve-Draining Poison) BUFF
    [79091] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Minor Fracture (Fracturing Poison) DEBUFF
    [79278] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_r.dds', tooltip = A.Poison }, -- Minor Cowardice (Sorcery-Draining Poison) DEBUFF
    [79279] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_g.dds', tooltip = A.Poison }, -- Minor Sorcery (Sorcery-Draining Poison) BUFF
    [79082] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Cowardice (Cowardice Poison) DEBUFF
    [79282] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_r.dds', tooltip = A.Poison }, -- Drain Weapon Power (Brutality-Draining Poison) DEBUFF
    [79283] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_g.dds', tooltip = A.Poison }, -- Minor Brutality (Brutality-Draining Poison) BUFF
    [79085] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Maim (Maiming Poison) DEBUFF
    [79448] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Uncertainty (Prophecy-Draining Poison) DEBUFF
    [79449] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_g.dds', tooltip = A.Poison }, -- Minor Prophecy (Prophecy-Draining Poison) BUFF
    -- No Uncertainty
    [79454] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Enervation (Savagery-Draining Poison) DEBUFF
    [79455] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_g.dds', tooltip = A.Poison }, -- Minor Savagery (Savagery-Draining Poison) BUFF
    [79116] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Enervation (Enervating Poison) DEBUFF
    [79459] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', tooltip = A.Poison }, -- Immobilize (Escapist's Poison) DEBUFF
    [79460] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', tooltip = A.Poison }, -- Unstoppable (Escapist's Poison) BUFF
    -- No Entrapping
    [80002] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', name = A.Poison_Stealth_Draining_Poison, tooltip = A.Poison }, -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80004] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', name = A.Poison_Conspicuous_Poison, tooltip = A.Poison }, -- Marking Poison (Conspicuous Poison) DEBUFF
    [79369] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', name = A.Skill_Hindrance, tooltip = A.Poison }, -- Hindrance (Speed-Draining Poison) DEBUFF
    [79370] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', tooltip = A.Poison }, -- Major Expedition (Speed-Draining Poison) BUFF
    [79102] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', name = A.Skill_Hindrance, tooltip = A.Poison }, -- Hindrance (Hindering Poison) DEBUFF
    [79701] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [81348] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79702] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Restore Health (Gradual Health Drain Poison) BUFF
    -- No Gradual Ravage Health
    [79726] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', tooltip = A.Poison }, -- Minor Vulnerability (Protection-Reversing Poison) DEBUFF
    [79727] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', tooltip = A.Poison }, -- Minor Protection (Protection-Reversing Poison) BUFF
    [79720] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', tooltip = A.Poison }, -- Minor Vulnerability (Vulnerability Poison) DEBUFF
    [79854] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Vitality-Draining Poison) DEBUFF
    [79855] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Minor Vitality (Vitality-Draining Poison) BUFF
    [79862] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Defiling Poison) DEBUFF

    -- Vendor Poisons
    [81553] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', tooltip = A.Poison }, -- Ravage Health (Cloudy Damage Health Poison) DEBUFF
    [81551] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison) DEBUFF
    [81554] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', tooltip = A.Poison }, -- Hindrance (Cloudy Hindering Poison) DEBUFF

    -- Crown Poisons
    [88476] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', tooltip = A.Poison }, -- Creeping Ravage Health (Crown Debilitating Poison)
    [88477] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', tooltip = A.Poison }, -- Hindrance (Crown Debilitating Poison)
    [88471] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_blue_r.dds', tooltip = A.Poison }, -- Drain Magicka (Crown Draining Poison)
    [88475] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', tooltip = A.Poison }, -- Drain Stamina (Crown Draining Poison)
    [88473] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_blue_g.dds', tooltip = A.Poison }, -- Restore Magicka (Crown Draining Poison)
    [88474] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_g.dds', tooltip = A.Poison }, -- Restore Stamina (Crown Draining Poison)
    [88469] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_yellow_r.dds', tooltip = A.Poison }, -- Minor Maim (Crown Enfeebling Poison)
    [88470] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Crown Enfeebling Poison)
    [81274] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds', tooltip = A.Poison }, -- Ravage Health (Crown Lethal Poison) DEBUFF
    [81275] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', tooltip = A.Poison }, -- Creeping Ravage Health (Crown Lethal Poison) DEBUFF
    [88462] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds', tooltip = A.Poison }, -- Immobilize (Crown Trapping Poison)
    [88463] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', tooltip = A.Poison }, -- Hindrance (Crown Trapping Poison)

    ----------------------------------------------------------------
    -- FOOD & DRINK ------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Food
    [61259] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', tooltip = T.Food_Crafted_Health }, -- Health Food
    [61260] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', tooltip = T.Food_Crafted_Magicka }, -- Magicka Food
    [61261] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', tooltip = T.Food_Crafted_Stamina }, -- Stamina Food
    [61294] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', tooltip = T.Food_Crafted_Magicka_Stamina }, -- Magicka + Stamina Food
    [61255] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', tooltip = T.Food_Crafted_Health_Stamina }, -- Health + Stamina Food
    [61257] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', tooltip = T.Food_Crafted_Health_Magicka }, -- Health + Magicka Food
    [61218] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_purple.dds', tooltip = T.Food_Crafted_Triple }, -- Triple Food
    [72819] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_tripe_trifle_pocket.dds', name = A.Food_Orzorgas_Tripe_Trifle_Pocket }, -- Orzorga's Tripe Trifle Pocket
    [72822] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_blood_price_pie.dds', name = A.Food_Orzorgas_Blood_Price_Pie }, -- Orzorga's Blood Price Pie
    [72824] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_bear_haunch.dds', name = A.Food_Orzorgas_Smoked_Bear_Haunch }, -- Orzorga's Smoked Bear Haunch
    [100502] = { icon = 'LuiExtended/media/icons/consumables/consumable_deregulated_mushroom_stew.dds' }, -- Deregulated Mushroom Stew
    [100498] = { icon = 'LuiExtended/media/icons/consumables/consumable_clockwork_citrus_filet.dds' }, -- Clockwork Citrus Filet
    [107789] = { icon = 'LuiExtended/media/icons/consumables/consumable_artaeum_takeaway_broth.dds' }, -- Artaeum Takeaway Broth
    [107748] = { icon = 'LuiExtended/media/icons/consumables/consumable_artaeum_pickled_fish_bowl.dds', name = A.Food_Artaeum_Pickled_Fish_Bowl }, -- Lure Allure (Artaeum Pickled Fish Bowl)

    -- Crafted Drink
    [61322] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Recovery), tooltip = T.Drink_Crafted_Health }, -- Health Drink
    [61323] = { hide = true }, -- Well Fed
    [61325] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Magicka_Recovery), tooltip = T.Drink_Crafted_Magicka }, -- Magicka Drink
    [61326] = { hide = true }, -- Well Fed
    [61328] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Stamina_Recovery), tooltip = T.Drink_Crafted_Stamina }, -- Stamina Drink
    [61329] = { hide = true }, -- Well Fed
    [61345] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Magicka_Stamina_Recovery), tooltip = T.Drink_Crafted_Magicka_Stamina }, -- Magicka + Stamina Drink
    [61346] = { hide = true }, -- Well Fed
    [61348] = { hide = true }, -- Well Fed
    [61340] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Stamina_Recovery), tooltip = T.Drink_Crafted_Health_Stamina }, -- Health + Stamina Drink
    [61341] = { hide = true }, -- Well Fed
    [61344] = { hide = true }, -- Well Fed
    [61335] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Magicka_Recovery), tooltip = T.Drink_Crafted_Health_Magicka }, -- Health + Magicka Drink
    [61336] = { hide = true }, -- Well Fed
    [61339] = { hide = true }, -- Well Fed
    [61350] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_purple.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Primary_Stat_Recovery), tooltip = T.Drink_Crafted_Triple }, -- Triple Drink
    [72816] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_red_frothgar.dds', name = A.Drink_Orzorgas_Red_Frothgar }, -- Orzorga's Red Frothgar
    [61354] = { hide = true }, -- Well Fed: Magicka Regen
    [100488] = { icon = 'LuiExtended/media/icons/consumables/consumable_spring-loaded_infusion.dds' }, -- Spring-Loaded Infusion
    [100490] = { hide = true }, -- Magicka Consumable
    [100489] = { hide = true }, -- Stamina Consumable

    -- Crafted Seasonal Food
    [84681] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_crisp_and_crunchy_pumpkin.dds', name = A.Food_Pumpkin_Snack_Skewer }, -- Crisp and Crunchy Pumpkin Snack Skewer
    [84709] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_crunchy_spider_skewer.dds' }, -- Crunchy Spider Skewer
    [84725] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_frosted_brains.dds', name = A.Food_Frosted_Brains }, -- Frosted Brains
    [84678] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds' }, -- Sweet Sanguine Apples (Generic shared id for other seasonal magicka food)
    [86789] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_alcaire_festival_sword-pie.dds' }, -- Alcaire Festival Sword-Pie
    [86749] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_jagga-drenched_mud_ball.dds', name = A.Food_Jagga_Drenched_Mud_Ball }, -- Jagga-Drenched "Mud Ball"
    [86673] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_lava_foot_soup-and-saltrice.dds', name = A.Food_Lava_Foot_Soup }, -- Lava Foot Soup-and-Saltrice
    [86787] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_rajhins_sugar_claws.dds' }, -- Rajhin's Sugar Claws
    [89955] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_candied_jesters_coins.dds' }, -- Candied Jester's Coins

    -- Crafted Seasonal Drink
    [84700] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bowl_of_peeled_eyeballs.dds', name = A.Drink_Bowl_of_Peeled_Eyeballs }, -- Bowl of "Peeled Eyeballs"
    [84735] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_double_bloody_mara.dds', tooltip = T.Drink_Double_Bloody_Mara }, -- Double Bloody Mara
    [84720] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_ghastly_eye_bowl.dds', name = A.Drink_Ghastly_Eye_Bowl }, -- Ghastly Eye Bowl
    [84704] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_party_punch.dds' }, -- Witchmother's Party Punch
    [84731] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_potent_brew.dds' }, -- Witchmother's Potent Brew
    [86677] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bergama_warning_fire.dds', name = A.Drink_Bergama_Warning_Fire }, -- Bergama Warning Fire
    [86746] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_betnikh_twice-spiked_ale.dds', name = A.Drink_Betnikh_Twice_Spiked_Ale }, -- Betnikh Twice-Spiked Ale
    [86559] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_hissmir_fish-eye_rye.dds', name = A.Drink_Hissmir_Fish_Eye_Rye, tooltip = T.Drink_Hissmir }, -- Hissmir Fish-Eye Rye
    [86791] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_snow_bear_glow-wine.dds', name = A.Drink_Snow_Bear_Glow_Wine }, -- Snow Bear Glow-Wine
    [89957] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_dubious_camoran_throne.dds' }, -- Dubious Camoran Throne
    [89971] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_jewels_of_misrule.dds' }, -- Jewels of Misrule

    -- Vendor Food & Drink
    [66551] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', tooltip = T.Food_Vendor_Health }, -- Vendor Health Food
    [66568] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', tooltip = T.Food_Vendor_Magicka }, -- Vendor Magicka Food
    [66576] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', tooltip = T.Food_Vendor_Stamina }, -- Vendor Stamina Food
    [66586] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Recovery), tooltip = T.Drink_Vendor_Health }, -- Vendor Health Drink
    [66590] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Magicka_Recovery), tooltip = T.Drink_Vendor_Magicka }, -- Vendor Magicka Drink
    [66594] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Stamina_Recovery), tooltip = T.Drink_Vendor_Stamina }, -- Vendor Stamina Drink

    -- AVA Food & Drink
    [72961] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_bar.dds', name = A.Food_Magicka_Stamina_Increase, tooltip = T.Food_Cyrodilic_Field_Bar }, -- Cyrodilic Field Bar
    [72956] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tack.dds', name = A.Food_Health_Stamina_Increase, tooltip = T.Food_Cyrodilic_Field_Tack }, -- Cyrodilic Field Tack
    [72959] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_treat.dds', name = A.Food_Health_Magicka_Increase, tooltip = T.Food_Cyrodilic_Field_Treat }, -- Cyrodilic Field Treat
    [72971] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tonic.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Magicka_Stamina_Recovery), tooltip = T.Drink_Cyrodilic_Field_Tonic }, -- Cyrodilic Field Tonic
    [72965] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_brew.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Stamina_Recovery), tooltip = T.Drink_Cyrodilic_Field_Brew }, -- Cyrodilic Field Brew
    [72968] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tea.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Magicka_Recovery), tooltip = T.Drink_Cyrodilic_Field_Tea }, -- Cyrodilic Field Tea

    -- Crown Food & Drink
    [85484] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_crate_food.dds', name = A.Food_Crown_Crate_Meal, tooltip = T.Food_Crown_Crate_Meal }, -- Crown Crate Fortifying Meal
    [68411] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_food.dds', name = A.Food_Crown_Meal, tooltip = T.Food_Crown_Meal }, -- Crown Fortifying Meal
    [85497] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_crate_drink.dds', name = A.Drink_Crown_Crate_Drink, tooltip = T.Drink_Crown_Crate_Drink }, -- Crown Crate Refreshing Drink
    [68416] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_drink.dds', name = A.Drink_Crown_Drink, tooltip = T.Drink_Crown_Drink }, -- Crown Refreshing Drink
    [92435] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_magickahealth_food.dds', name = A.Food_Crown_Combat_Mystics_Stew }, -- Crown Combat Mystic's Stew
    [92474] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_staminahealth_food.dds', name = A.Food_Crown_Vigorous_Ragout }, -- Crown Vigorous Ragout
    [92433] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_magickahealth_drink.dds', name = A.Drink_Crown_Stout_Magic_Liqueur }, -- Crown Stout Magic Liqueur
    [92476] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_staminahealth_drink.dds', name = A.Drink_Crown_Vigorous_Tincture }, -- Crown Vigorous Tincture

    -- Experience Bonuses
    [64210] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_psijic_ambrosia.dds', name = A.Experience_Psijic_Ambrosia, tooltip = T.Experience_Psijic_Ambrosia }, -- Psijic Ambrosia
    [89683] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_aetherial_ambrosia.dds', name = A.Experience_Aetherial_Ambrosia, tooltip = T.Experience_Aetherial_Ambrosia }, -- Aetherial Ambrosia
    [88445] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_mythic_aetherial_ambrosia.dds', name = A.Experience_Mythic_Ambrosia, tooltip = T.Experience_Mythic_Aetherial_Ambrosia }, -- Mythic Aetherial Ambrosia
    [66776] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_scroll.dds', name = A.Experience_Crown_Scroll, tooltip = T.Experience_Crown }, -- Crown Experience Scroll
    [85501] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_1.dds', name = A.Experience_Crown_Crate_Scroll_1, tooltip = T.Experience_Gold_Coast }, -- Gold Coast Experience Scroll
    [85502] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_2.dds', name = A.Experience_Crown_Crate_Scroll_2, tooltip = T.Experience_Major_Gold_Coast }, -- Major Gold Coast Experience Scroll
    [85503] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_3.dds', name = A.Experience_Crown_Crate_Scroll_3, tooltip = T.Experience_Grand_Gold_Coast }, -- Grand Gold Coast Experience Scroll

    -- Other
    [70582] = { hide = true }, -- Roll 1d1000 (Merethic Restorative Resin)
    [63427] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fillet_fish.dds', name = A.Innate_Fillet_Fish }, -- Clean Fish
    [78052] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_pardon_edict_low.dds', name = A.Innate_Pardon_Edict_Low }, -- Minor Pardon
    [76350] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_pardon_edict_medium.dds', name = A.Innate_Pardon_Edict_Medium }, -- Moderate Pardon
    [76349] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_pardon_edict_high.dds', name = A.Innate_Pardon_Edict_High }, -- Full Pardon

    -- Seasonal Mementos & Items
    [86792] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_mints.dds', name = A.Consumable_Festival_Mints }, -- Eating (High Hrothgar Festival Mints)
    [86794] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_mints.dds', name = A.Consumable_Festival_Mints, tooltip = T.Event_Festival_Mints, unbreakable = 1 }, -- Very Cold (High Hrothgar Festival Mints)
    [86739] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_grog.dds', name = A.Consumable_Sailors_Grog }, -- Drinking (Sailor's Warning Festival Grog)
    [86740] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_grog.dds', name = A.Consumable_Sailors_Grog, tooltip = T.Event_Festival_Grog, unbreakable = 1 }, -- Very Drunk (Sailor's Warning Festival Grog)
    [85355] = {icon = 'LuiExtended/media/icons/abilities/ability_event_torch_juggling.dds', name = A.Memento_Fire_Breathers_Torches, unbreakable = 1 }, -- Flame Juggling (Consumable Version)
    [85354] = {icon = 'LuiExtended/media/icons/abilities/ability_event_knife_juggling.dds', name = A.Memento_Jugglers_Knives, unbreakable = 1 }, -- Dagger Juggling (Consumable Verison)
    [85353] = {icon = 'LuiExtended/media/icons/abilities/ability_event_sword_swallowing.dds', name = A.Memento_Sword_Swallowers_Blade, unbreakable = 1 }, -- Sword Swallowing (Consumable Version)
    [86774] = { icon = 'esoui/art/icons/achievement_newlifefestival_001.dds', name = A.Memento_Mud_Ball }, -- Mudball (Mud Ball Pouch)
    [87964] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_1.dds', name = A.Consumable_Sparkwreath_Dazzler }, -- Jester's Festival Illusion Daz (Sparkwreath Dazzler)
    [87965] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_1.dds', name = A.Consumable_Plume_Dazzler }, -- Jester's Festival Illusion Daz (Plume Dazzler)
    [87966] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_1.dds', name = A.Consumable_Spiral_Dazzler }, -- Jester's Festival Illusion Daz (Spiral Dazzler)
    [88374] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_2.dds', name = A.Skill_Sparkly_Hat_Dazzler }, -- Jester's Festival Illusion Daz (Sparkly Hat Dazzler)
    [87963] = { icon = 'LuiExtended/media/icons/abilities/ability_event_flower_garland.dds', name = A.Memento_Cherry_Blossom_Branch }, -- Bestowed Cherry Blossoms (Cherry Blossom Branch)
    [102077] = { icon = 'LuiExtended/media/icons/mementos/memento_jesters_scintillator.dds', name = A.Memento_Jesters_Scintillator, unbreakable = 1 }, -- Jester's Festival Scintillator (Jester's Scintillator)
    [77027] = { hide = true }, -- Anniversary Cake - Forreals (Jubilee Cake)
    [87998] = { hide = true }, -- Anniversary Cake (2nd Annual Jubilee Cake)
    [102009] = { hide = true }, -- Anniversary Cake (3rd Annual Jubilee Cake)
    [77123] = { icon = 'LuiExtended/media/icons/mementos/memento_event_jubilee_cake.dds', name = A.Memento_Jubliee_Cake }, -- Anniversary EXP Buff -- TODO: Verify
    [81575] = { icon = 'LuiExtended/media/icons/mementos/memento_witchmothers_whistle.dds', name = A.Memento_Witchmothers_Whistle, hide = true }, -- Event - WitchFest Cauldron (Witchmother's Whistle)
    [96118] = { icon = 'LuiExtended/media/icons/abilities/ability_event_witchmothers_brew.dds', tooltip = T.Experience_Seasonal_Event } , -- Witchmother's Boon (Witchmother's Whistle)
    [84364] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84365] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84366] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84367] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84368] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84369] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [91369] = { icon = 'LuiExtended/media/icons/abilities/ability_event_steamy_spring_pie.dds', name = A.Memento_The_Pie_of_Misrule, tooltip = T.Experience_Seasonal_Event }, -- Jester's Experience Boost Pie (The Pie of Misrule)
    [92232] = { icon = 'LuiExtended/media/icons/abilities/ability_event_pelinals_ferocity.dds', tooltip = T.Experience_Seasonal_Pelinal }, -- Pelinal's Ferocity (Scroll of Pelinal's Ferocity)
    [91449] = { icon = 'LuiExtended/media/icons/abilities/ability_event_bredas_magnificent_mead.dds', tooltip = T.Experience_Seasonal_Event }, -- Breda's Magnificent Mead (Breda's Bottomless Mead Mug)
    [86075] = { icon = 'LuiExtended/media/icons/abilities/ability_event_bredas_magnificent_mead.dds', tooltip = T.Experience_Seasonal_Event }, -- Breda's Magnificent Mead (Breda's Magnificent Mead)

    -- Base Mementos
    [26829] = { icon = 'LuiExtended/media/icons/mementos/memento_almalexias_enchanted_lantern.dds', name = A.Memento_Almalexias_Lantern, unbreakable = 1, tooltip = T.Memento_Almalexias_Lantern }, -- Light of the Tribunal (Almalexia's Enchanted Lantern)
    [26736] = { icon = 'LuiExtended/media/icons/mementos/memento_battered_bear_trap.dds', name = A.Memento_Battered_Bear_Trap }, -- Bear Trap (Battered Bear Trap)
    [16846] = { icon = 'LuiExtended/media/icons/mementos/memento_blackfeather_court_whistle.dds', hide = true }, -- Blackfeather Court Whistle (Blackfeather Court Whistle)
    [41988] = {icon = 'LuiExtended/media/icons/mementos/memento_bonesnap_binding_stone.dds', unbreakable = 1, tooltip = T.Memento_Bonesnap_Binding_Talisman }, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = {icon = 'LuiExtended/media/icons/mementos/memento_discourse_amaranthine.dds', name = A.Memento_Discourse_Amaranthine, unbreakable = 1, tooltip = T.Memento_Discourse_Amaranthine }, -- Glimpse of the Forbidden (Discoure Amaranthine)
    [41950] = { icon = 'LuiExtended/media/icons/mementos/memento_fetish_of_anger.dds', tooltip = T.Memento_Fetish_of_Anger, unbreakable = 1 }, -- Fetish of Anger (Fetish of Anger)
    [21226] = { icon = 'LuiExtended/media/icons/mementos/memento_finvirs_trinket.dds', tooltip = T.Memento_Finvirs_Trinket, unbreakable = 1 }, -- Finvir's Trinket (Finvir's Trinket)
    [41948] = { icon = 'LuiExtended/media/icons/mementos/memento_glanirs_smoke_bomb.dds' }, -- Glanir's Smoke Bomb (Glanir's Smoke Bomb)
    [25703] = { hide = true }, -- Justal's Falcon (Justal's Falcon)
    [43700] = { hide = true, icon = 'LuiExtended/media/icons/mementos/memento_lenas_wand_of_finding.dds', name = A.Menento_Lenas_Wand_of_Finding }, -- Wand of Finding (Lena's Wand of Finding)
    [43702] = { hide = true }, -- Invis Chicken Delay (Lena's Wind of Finding)
    [43703] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [43704] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [43701] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [42076] = { icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds', name = A.Memento_Sealing_Amulet, unbreakable = 1 }, -- Tear (Mezha-dro's Sealing Amulet)
    [42105] = { icon = 'LuiExtended/media/icons/mementos/memento_nanwens_sword.dds' }, -- Nanwen's Sword (Nanwen's Sword)
    [34578] = { icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds', unbreakable = 1 }, -- Nirnroot Wine (Nirnroot Wine)
    [26339] = { icon = 'LuiExtended/media/icons/mementos/memento_questionable_meat_sack.dds', name = A.Memento_Mystery_Meat, unbreakable = 1, tooltip = T.Memento_Mystery_Meat }, -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = { icon = 'LuiExtended/media/icons/mementos/memento_sanguines_goblet.dds', name = A.Memento_Sanguines_Goblet, unbreakable = 1, tooltip = T.Memento_Sanguines_Goblet }, -- Sanguine's Goblet (Sanguine's Goblet)
    [42008] = { icon = 'LuiExtended/media/icons/mementos/memento_token_of_root_sunder.dds', name = A.Memento_Token_of_Root_Sunder, unbreakable = 1, tooltip = T.Memento_Token_of_Root_Sunder }, -- Blessing of Root Sunder (Token of Root Sunder)
    [42053] = { icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds', name = A.Memento_Yokudan_Totem, unbreakable = 1 }, -- Yokudan Salute (Yokudan Totem)

    -- DLC Mementos
    [89550] = { icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds', name = A.Memento_Twilight_Shard, unbreakable = 1 }, -- TROPHY Azura's Light (Twilight Shard)
    [79510] = { icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds', name = A.Memento_Blade_of_the_Blood_Oath, unbreakable = 1 }, -- TROPHY Blood Oath (Blade of the Blood Oath)

    [92862] = { hide = true, icon = 'LuiExtended/media/icons/mementos/memento_dreamers_chime.dds', name = A.Memento_Dreamers_Chime, unbreakable = 1 }, -- Dreamers Chime (Ringing Bell)
    [92863] = { hide = true }, -- Dreamers Chime (Stun)
    [77785] = { hide = true }, -- Rain of Coins (Coin of Illusory Riches)
    [77786] = { icon = 'LuiExtended/media/icons/mementos/memento_coin_of_illusory_riches.dds', name = A.Memento_Coin_of_Illusory_Riches, unbreakable = 1 }, -- Stun (Coin of Illusory Riches)

    [74151] = { icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds', name = A.Memento_Hidden_Pressure_Vent, unbreakable = 1 }, -- Stun (Hidden Pressure Vent)
    [73685] = { hide = true }, -- Rkindaleft Trophy (Hidden Pressure Vent)
    [73686] = { hide = true, icon = 'LuiExtended/media/icons/mementos/memento_malacaths_wrathful_flame.dds', name = A.Memento_Malacaths_Wrathful_Flame }, -- Old Orsinium Trophy (Malacath's Wrathful Flame)
    [74232] = { hide = true }, -- Stun (Malacath's Wrathful Flame)

    -- Crown Store Mementos
    [85344] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_aura.dds', name = A.Memento_Storm_Atronach_Aura, forcedContainer = 'short', tooltip = T.Memento_Storm_Atronach_Aura, unbreakable = 1 }, -- Atronach Aura (Storm Atronach Aura)
    [85349] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_transform.dds', name = A.Memento_Storm_Atronach_Transform, tooltip = T.Memento_Storm_Atronach_Transform, unbreakable = 1 }, -- Storm Atronach Transform (Atronach Transformation)
    [85347] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds', name = A.Memento_Storm_Orb_Juggle, unbreakable = 1 }, -- Storm Orb Juggle (Atronach Juggling)
    [86976] = { icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_leaf-dance_aura.dds', name = A.Memento_Wild_Hunt_Aura, forcedContainer = 'short', tooltip = T.Memento_Wild_Hunt_Leaf_Dance_Aura, unbreakable = 1 }, -- Spriggan Aura (Wild Hunt Leaf-Dance Aura)
    [86977] = {icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_transform.dds', name = A.Memento_Wild_Hunt_Transform, tooltip = T.Memento_Wild_Hunt_Transform, unbreakable = 1 }, -- Spriggan Transformation (Wild Hunt Transform)
    [86978] = { icon = 'LuiExtended/media/icons/mementos/memento_floral_swirl_aura.dds', name = A.Memento_Floral_Swirl_Aura, forcedContainer = 'short', tooltip = T.Memento_Floral_Swirl_Aura, unbreakable = 1 }, -- Grand Spriggan Aura (Floral Swirl Aura)
    [92866] = { icon = 'LuiExtended/media/icons/mementos/memento_dwarven_puzzle_orb.dds', name = A.Memento_Dwarven_Puzzle_Orb, unbreakable = 1, tooltip = T.Memento_Dwarven_Puzzle_Orb }, -- Dwarven Globe (Dwarven Puzzle Orb)
    [92867] = { icon = 'LuiExtended/media/icons/mementos/memento_dwarven_tonal_forks.dds', name = A.Memento_Dwarven_Tonal_Forks, unbreakable = 1, tooltip = T.Memento_Dwarven_Tonal_Forks }, -- Dwarven Tuning Forks (Dwarven Tonal Forks)
    [92868] = {icon = 'LuiExtended/media/icons/mementos/memento_dwemervamidium_mirage.dds', name = A.Memento_Dwemervamidium_Mirage, unbreakable = 1, tooltip = T.Memento_Dwemervamidium_Mirage }, -- Dwarven Transformation (Dwemervamidium Mirage)
    [97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds', name = A.Memento_Crows_Calling, unbreakable = 1 }, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [97274] = { icon = 'esoui/art/icons/achievement_update16_017.dds', name = A.Memento_Swarm_of_Crows, unbreakable = 1, tooltip = T.Memento_Swarm_of_Crows }, -- Swarm of Crows (Swarm of Crows)
    [98378] = { hide = true }, -- Murderous Strike (Murderous Strike)
    [99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds', name = A.Memento_Fiery_Orb, unbreakable = 1 }, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    [99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds', name = A.Memento_Flame_Pixie, unbreakable = 1 }, -- Flame Crate Memento 2 (Flame Pixie)
    [99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds', name = A.Memento_Flame_Eruption, unbreakable = 1 }, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    [101874] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_frost_shard.dds', name = A.Memento_Frost_Shard, unbreakable = 1 }, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    [101877] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_rune_of_levitation.dds', name = A.Memento_Rune_of_Levitation, unbreakable = 1 }, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    [101872] = { icon = 'LuiExtended/media/icons/mementos/memento_bone_dragon_summons_focus.dds', name = A.Memento_Dragon_Summons_Focus, unbreakable = 1 }, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    [104324] = { icon = 'LuiExtended/media/icons/mementos/memento_psijic_celestial_orb.dds', name = A.Memento_Psijic_Celestial_Orb, unbreakable = 1 }, -- Psijic Pearl Summon (Psijic Celestial Orb)
    [104323] = { icon = 'LuiExtended/media/icons/mementos/memento_psijic_tautology_glass.dds', name = A.Memento_Psijic_Tautology_Glass, unbreakable = 1 }, -- Psijic Hourglass (Psijic Tautology Glass)
    [104325] = { icon = 'LuiExtended/media/icons/mementos/memento_sapiarchic_discorporation_lens.dds', name = A.Memento_Sapiarchic_Discorporation, unbreakable = 1, hide = true }, -- Psijic Disintegrate (Sapiarchic Discorporation Lens)
    [110482] = { icon = 'LuiExtended/media/icons/mementos/memento_rind_renewing_pumpkin.dds', unbreakable = 1 }, -- Rind-Renewing Pumpkin (Rind-Renewing Pumpkin)
    [110481] = { icon = 'LuiExtended/media/icons/mementos/memento_gourd_gallows_stump.dds', unbreakable = 1 }, -- Gourd-Gallows Stump (Gourd-Gallows Stump)
    [110483] = { icon = 'LuiExtended/media/icons/mementos/memento_ghost_lantern.dds', name = A.Memento_Ghost_Lantern, unbreakable = 1, tooltip = T.Memento_Ghost_Lantern }, -- Ghost Lantern (Ghost Lantern)

    -- Non-Combat Pets
    [76364] = { hide = true }, -- _CRWN_5s (Echalette)
    [76365] = { hide = true }, -- _CRWN_Echalette_Buck (Echalette)
    [76367] = { hide = true }, -- _CRWN_ResetPosture (Echalette)
    [76368] = { hide = true }, -- _CRWN_1s (Turquoise Nixad)
    [78642] = { hide = true }, -- _CRWN_Jackal_Mouse (Jackal)
    [78643] = { hide = true }, -- _CRWN_Jackal_Digging (Jackal)

    [72955] = { hide = true }, -- _CRWN Pet Goat,Black (Sanguine's Black Goat)
    [81352] = { hide = true }, -- _CRWN_12.5s (Spotted Snow Senche-Leopard)

    -- Assistants
    [77645] = { hide = true }, -- Stealth (Pirharri the Smuggler)

    ----------------------------------------------------------------
    -- ENCHANTS ----------------------------------------------------
    ----------------------------------------------------------------

    [28919] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds' }, -- Life Drain (Glyph of Absorb Health)
    [28921] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds' }, -- Life Drain (Glyph of Absorb Health)
    [46743] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds' }, -- Absorb Magicka (Glyph of Absorb Magicka)
    [46744] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds' }, -- Absorb Magicka (Glyph of Absorb Magicka)
    [46746] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds' }, -- Absorb Stamina (Glyph of Absorb Stamina)
    [46747] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds' }, -- Absorb Stamina (Glyph of Absorb Stamina)
    [17906] = { icon = 'LuiExtended/media/icons/glyphs/glyph_crushing.dds', name = A.Item_Glyph_of_Crushing, tooltip = T.Item_Glyph_of_Crushing }, -- Crusher (Glyph of Crushing)
    [46749] = { icon = 'LuiExtended/media/icons/glyphs/glyph_decrease_health.dds', name = A.Item_Glyph_of_Decrease_Health }, -- Damage Health (Glyph of Decrease Health)
    [17895] = { icon = 'LuiExtended/media/icons/glyphs/glyph_flame.dds' }, -- Fiery Weapon (Glyph of Flame)
    [17904] = { icon = 'LuiExtended/media/icons/glyphs/glyph_foulness.dds' }, -- Befouled Weapon (Glyph of Foulness)
    [17897] = { icon = 'LuiExtended/media/icons/glyphs/glyph_frost.dds' }, -- Frozen Weapon (Glyph of Frost)
    --[17947] = { icon = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds', name = A.Item_Glyph_of_Hardening }, -- Hardening (Glyph of Hardening) (DUMMY EVENT }, HERE JUST IN CASE)
    [21578] = { icon = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds', name = A.Item_Glyph_of_Hardening, tooltip = T.Item_Glyph_of_Hardening }, -- Hardening (Glyph of Hardening)
    [17902] = { icon = 'LuiExtended/media/icons/glyphs/glyph_poison.dds' }, -- Poisoned Weapon (Glyph of Poison)
    [40337] = { icon = 'LuiExtended/media/icons/glyphs/glyph_prismatic.dds' }, -- Primatic Weapon (Glyph of Prismatic Onslaught)
    [17899] = { icon = 'LuiExtended/media/icons/glyphs/glyph_shock.dds' }, -- Charged Weapon (Glyph of Shock)
    [17945] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weakening.dds', name = A.Item_Glyph_of_Weakening, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Item_Glyph_of_Weakening, }, -- Weakening (Glyph of Weakening)
    --[17910] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds', name = A.Item_Glyph_of_Weapon_Damage }, -- Weapon Damage (Glyph of Weapon Damage) (DUMMY EVENT }, HERE JUST IN CASE)
    [21230] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds', name = A.Item_Glyph_of_Weapon_Damage, tooltip = T.Item_Glyph_of_Weapon_Damage }, -- Berserker (Glyph of Weapon Damage) (Added in case ever needed)

    ----------------------------------------------------------------
    -- STATUS EFFECT PROCS -----------------------------------------
    ----------------------------------------------------------------

    [18084] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_burning.dds', tooltip = T.Generic_Burn }, -- Burning (Fire Status Effect)
    [21925] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds' }, -- Diseased (Disease Status Effect)
    [21927] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds', tooltip = A.Proc_Diseased }, -- Major Defile (Disease Status Effect)
    [21481] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds', name = A.Proc_Chilled }, -- Chill (Frost Status Effect)
    [68368] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds', tooltip = A.Proc_Chilled }, -- Minor Maim (Frost Status Effect)
    [21929] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_poisoned.dds', tooltip = T.Generic_Poison }, -- Poisoned (Poison Status Effect)
    [21487] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds' }, -- Concussion (Shock Status Effect)
    [68359] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds', tooltip = A.Proc_Concussion }, -- Minor Vulnerability (Shock Status Effect)

    ----------------------------------------------------------------
    -- MUNDUS STONE BOONS ------------------------------------------
    ----------------------------------------------------------------

    [13940] = { tooltip = T.Boon_Warrior }, -- Boon: The Warrior
    [13943] = { tooltip = T.Boon_Mage }, -- Boon: The Mage
    [13974] = { tooltip = T.Boon_Serpent }, -- Boon: The Serpent
    [13975] = { tooltip = T.Boon_Thief }, -- Boon: The Thief
    [13976] = { tooltip = T.Boon_Lady }, -- Boon: The Lady
    [13977] = { tooltip = T.Boon_Steed }, -- Boon: The Steed
    [13978] = { tooltip = T.Boon_Lord }, -- Boon: The Lord
    [13979] = { tooltip = T.Boon_Apprentice }, -- Boon: The Apprentice
    [13980] = { tooltip = T.Boon_Ritual }, -- Boon: The Ritual
    [13981] = { tooltip = T.Boon_Lover }, -- Boon: The Lover
    [13982] = { tooltip = T.Boon_Atronach }, -- Boon: The Atronach
    [13984] = { tooltip = T.Boon_Shadow }, -- Boon: The Shadow
    [13985] = { tooltip = T.Boon_Tower }, -- Boon: The Tower

    ----------------------------------------------------------------
    -- EQUIPMENT ---------------------------------------------------
    ----------------------------------------------------------------

    -- Asylum Weapons
    [100302] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_piercing_spray.dds', tooltip = T.Set_Asylum_Bow }, -- Piercing Spray (Asylum Bow)
    [100294] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_disciplined_slash.dds' }, -- Disciplined Slash (Asylum 2H)
    [100462] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Asylum 1H + Shield)
    [100464] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Asylum 1H + Shield)
    [100308] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_timeless_blessing.dds', tooltip = T.Set_Aslyum_Restoration_Staff }, -- Timeless Blessing (Asylum Restoration Staff)
    [100306] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_concentrated_force.dds', tooltip = T.Set_Asylum_Destruction_Staff }, -- Concentrated Force (Asylum Destruction Staff)

    -- Asylum Weapons (Perfected)
    [99363] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_piercing_spray.dds', tooltip = T.Set_Asylum_Bow_Perfect }, -- Piercing Spray (Perfected) (Perfected Asylum Bow)
    [99361] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_disciplined_slash.dds' }, -- Disciplined Slash (Perfected) (Perfected Asylum 2H)
    [99920] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Perfected) (Perfected Asylum 1H + Shield)
    [99919] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Perfected) (Perfected Asylum 1H + Shield)
    [99582] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_timeless_blessing.dds', tooltip = T.Set_Aslyum_Restoration_Staff_P }, -- Timeless Blessing (Perfected) (Perfected Asylum Restoration Staff)
    [99989] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_concentrated_force.dds', name = A.Set_Asylum_Destruction_Staff, tooltip = T.Set_Asylum_Destruction_Staff_P }, -- Concentrated Force (P) (Asylum Destruction Staff)

    -- Maelstrom Weapons
    [99806] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_cruel_flurry.dds', tooltip = T.Set_Maelstrom_DW }, -- Cruel Flurry (Maelstrom Dual Wield)
    [99789] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_merciless_charge.dds', tooltip = T.Generic_Bleed }, -- Merciless Charge (Maelstrom 2H)
    [100588] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds', tooltip = T.Set_Maelstrom_1H }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [100587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [100589] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [99887] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_precise_regeneration.dds' }, -- Precise Regeneration (Maelstrom Restoration Staff)

    -- Master Weapons
    [99761] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_puncturing_remedy.dds' }, -- Puncturing Remedy (Master 1H + shield)
    [100575] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_puncturing_remedy.dds', tooltip = T.Set_Master_1H }, -- Puncturing Remedy (Master 1H + shield)
    [99781] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_grand_rejuvenation.dds' }, -- Grand Rejuvenation (Master Restoration Staff)

    -- Blackrose Weapons
    [113617] = { name = A.Skill_Major_Protection, tooltip = A.Set_Blackrose_DW }, -- Spectral Cloak (Blackrose DW)
    [113627] = { icon = 'LuiExtended/media/icons/abilities/ability_set_virulent_shot.dds', tooltip = T.Generic_Poison }, -- Virulent Shot (Blackrose Bow)
    [113553] = { icon = 'LuiExtended/media/icons/abilities/ability_set_radial_uppercut.dds' }, -- Radial Uppercut (Blackrose 2H)
    [113608] = { icon = 'LuiExtended/media/icons/abilities/ability_set_gallant_charge.dds', tooltip = T.Set_Blackrose_1H }, -- Gallant Charge (Blackrose 1H)
    [115003] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds', tooltip = T.Set_Blackrose_Destro_Staff }, -- Wild Impulse (Blackrose Destruction Staff)
    [114988] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }, -- Wild Impulse (Blackrose Destruction Staff)
    [115005] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }, -- Wild Impulse (Blackrose Destruction Staff)
    [115006] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }, -- Wild Impulse (Blackrose Destruction Staff)
    [113653] = { tooltip = A.Set_Blackrose_Resto_Staff }, -- Major Vitality (Blackrose Restoration Staff)

    -- Monster Sets
    [111505] = { icon = 'esoui/art/icons/vmh_killhulks.dds', tooltip = T.Set_Balorgh }, -- Balorgh (Balorgh)
    [59517] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_blood_spawn.dds', tooltip = T.Set_Blood_Spawn }, -- Blood Spawn (Blood Spawn)
    [61274] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_blood_spawn.dds' }, -- Blood Spawn (Blood Spawn)
    [59590] = { tooltip = T.Set_Bogdan_the_Nightflame }, -- Imperial Prison Item Set (Bogdan the Nightflame)
    [59591] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_bogdan.dds', name = A.Set_Bogdan_the_Nightflame }, -- Bogdan Totem (Bogdan the Nightflame)
    [81069] = { hide = true }, -- Chokethorn (Chokethorn)
    [81077] = { icon = 'esoui/art/icons/mh_hedgeguardian_strang.dds', tooltip = T.Set_Chokethorn }, -- Chokethorn (Chokethorn)
    [97901] = { tooltip = T.Set_Domihaus_Stamina_Damage }, -- Domihaus (Domihaus)
    [97900] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds', forcedContainer = 'short', groundLabel = true, tooltip = T.Set_Domihaus_Stamina_Buff }, -- Domihaus (Domihaus)
    [97899] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds' }, -- Domihaus (Domihaus)
    [97882] = { tooltip = T.Set_Domihaus_Magicka_Damage }, -- Domihaus (Domihaus)
    [97896] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds', forcedContainer = 'short', groundLabel = true, tooltip = T.Set_Domihaus_Magicka_Buff }, -- Domihaus (Domihaus)
    [97883] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds' }, -- Domihaus (Domihaus)
    [97855] = { tooltip = T.Set_Earthgore }, -- Earthgore (Earthgore)
    [97857] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds' }, -- Earthgore (Earthgore)
    [84504] = { icon = 'esoui/art/icons/achievement_update11_dungeons_033.dds', tooltip = T.Set_Grothdarr }, -- Grothdarr (Grothdarr)
    [84502] = { icon = 'esoui/art/icons/achievement_update11_dungeons_033.dds' }, -- Grothdarr (Grothdarr)
    [80562] = { icon = 'esoui/art/icons/achievement_wrothgar_042.dds', tooltip = T.Set_Iceheart }, -- Iceheart (Iceheart)
    [80561] = { icon = 'esoui/art/icons/achievement_wrothgar_042.dds' }, -- Iceheart (Iceheart)
    [80529] = { tooltip = T.Set_Ilambris_Shock }, -- Ilambris (Ilambris)
    [80526] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_ilambris_shock.dds' }, -- Ilambris (Ilambris)
    [80527] = { tooltip = T.Set_Ilambris_Fire }, -- Ilambris (Ilambris)
    [80525] = { icon = 'esoui/art/icons/ava_siege_ui_002.dds' }, -- Ilambris (Ilambris)
    [83405] = { hide = true }, -- Infernal Guardian (Infernal Guardian)
    [83409] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_infernal_guardian.dds' }, -- Infernal Guardian (Infernal Guardian)
    [80566] = { hide = true }, -- Kra'gh (Kra'gh)
    [80565] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_kragh.dds' }, -- Kra'gh (Kra'gh)
    [59586] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds', name = A.Set_Lord_Warden_Dusk, duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = T.Set_Lord_Warden_Ground }, -- Lord Warden (Lord Warden)
    [59587] = { tooltip = T.Set_Lord_Warden_Buff }, -- Lord Warden (Lord Warden)
    [59568] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = A.Set_Malubeth_the_Scourger, tooltip = T.Set_Malubeth }, -- Scourge Harvest (Malubeth)
    [59573] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = A.Set_Malubeth_the_Scourger }, -- Scourge Harvest (Malubeth)
    [59508] = { icon = 'esoui/art/icons/achievement_ic_020.dds', name = A.Set_Maw_of_the_Infernal, tooltip = T.Set_Maw_of_the_Infernal }, -- Banished Cells Item Set (Maw of the Infernal)
    [60974] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_maw_of_the_infernal.dds'}, -- Jagged Claw (Maw of the Infernal)
    [60972] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'}, -- Fiery Breath (Maw of the Infernal)
    [60973] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds'}, -- Fiery Jaws (Maw of the Infernal)
    [80482] = { tooltip = A.Set_Mighy_Chudan }, -- Major Ward (Mighty Chudan)
    [91983] = { tooltip = A.Set_Mighy_Chudan }, -- Major Resolve (Mighty Chudan)
    [66808] = { icon = 'LuiExtended/media/icons/abilities/ability_set_molag_kena.dds', tooltip = T.Set_Molag_Kena }, -- Molag Kena (Molag Kena)
    [66812] = { icon = 'LuiExtended/media/icons/abilities/ability_set_molag_kena.dds', tooltip = T.Set_Molag_Kena_Overkill }, -- Overkill (Molag Kena)
    [59593] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_nerieneth.dds', name = A.Set_Nerieneth }, -- Lich Crystal (Nerien'eth)
    [98421] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [98419] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [98420] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [81675] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [83288] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [83287] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [80853] = { tooltip = A.Set_Pirate_Skeleton }, -- Major Protection (Pirate Skeleton)
    [85637] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Set_Pirate_Skeleton }, -- Minor Defile (Pirate Skeleton)
    [80606] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_selene.dds' }, -- Selene (Selene)
    [80607] = { hide = true }, -- Dummy (Selene)
    [80609] = { hide = true }, -- Dummy (Selene)
    [80544] = { icon = 'esoui/art/icons/achievement_thievesguild_021.dds' }, -- Sellistrix (Sellistrix)
    [80549] = { icon = 'esoui/art/icons/achievement_thievesguild_021.dds', tooltip = T.Generic_Stun }, -- Sellistrix (Sellistrix)
    [81036] = { hide = true, tooltip = T.Set_Sentinel_of_Rkugamz }, -- Sentinel of Rkugamz
    [81038] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds' }, -- Sentinel of Rkugamz
    [81041] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds' }, -- Sentinel of Rkugamz
    [80955] = { hide = true }, -- Shadowrend (Shadowrend)
    [80954] = { hide = true, tooltip = T.Set_Shadowrend }, -- Shadowrend Summon (Shadowrend)
    [80980] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_headbutt.dds', name = A.Skill_Headbutt }, -- Shadowrend (Shadowrend)
    [80990] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds', tooltip = A.Set_Shadowrend }, -- Minor Maim (Shadowrend)
    [80989] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_tail_spike.dds', name = A.Skill_Tail_Spike }, -- Shadowrend (Shadowrend)
    [81034] = { tooltip = A.Set_Shadowrend }, -- Minor Maim (Shadowrend)
    [80481] = { tooltip = A.Set_Slimecraw }, -- Minor Berserk (Slimecraw)
    [59497] = { tooltip = T.Set_Spawn_of_Mephala }, -- Spawn of Mephala (Spawn of Mephala)
    [59498] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = A.Set_Spawn_of_Mephala }, -- Mephala's Web (Spawn of Mephala)
    [59499] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = A.Set_Spawn_of_Mephala, duration = 0, groundLabel = true, tooltip = T.Generic_Snare_50 }, -- Mephala's Web (Spawn of Mephala)
    [80523] = { tooltip = T.Set_Stormfist }, -- Stormfist (Stormfist)
    [80522] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds' }, -- Stormfist (Stormfist)
    [80521] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds' }, -- Stormfist (Stormfist)
    [84419] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = A.Set_Swarm_Mother },
    [80593] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = A.Set_Swarm_Mother },
    [59522] = { hide = true }, -- Engine Guardian
    [59540] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_stamina.dds', name = A.Set_Engine_Guardian, tooltip = T.Set_Engine_Guardian_Stamina }, -- Engine Guardian Stamina
    [59533] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_magicka.dds', name = A.Set_Engine_Guardian, tooltip = T.Set_Engine_Guardian_Magicka }, -- Engine Guardian Magicka
    [59543] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_health.dds', name = A.Set_Engine_Guardian, tooltip = T.Set_Engine_Guardian_Health }, -- Engine Guardian Health
    [80504] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_regeneration.dds', name = A.Set_The_Troll_King, tooltip = T.Set_The_Troll_King }, -- The Troll King
    [102097] = { tooltip = A.Set_Thurvokun }, -- Minor Maim (Thurvokun)
    [102100] = { tooltip = A.Set_Thurvokun }, -- Minor Defile (Thurvokun)
    [102093] = { tooltip = T.Set_Thurvokun }, -- Thurvokun (Thurvokun)
    [102094] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds' }, -- Thurvokun
    [80865] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds' }, -- Tremorscale
    [80866] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds', tooltip = T.Generic_Snare_70 }, -- Tremorscale
    [59596] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_valkyn_skoria.dds' }, -- Valkyn Skoria
    [61273] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_valkyn_skoria.dds' }, -- Valkyn Skoria
    [80490] = { icon = 'esoui/art/icons/achievement_update11_dungeons_035.dds' }, -- Velidreth
    [111354] = { tooltip = A.Set_Vykosa }, -- Major Maim (Vykosa)
    [102136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_zaan.dds', tooltip = T.Set_Zaan }, -- Zaan
    [102142] = { hide = true }, -- Zaan

    -- Crafted Sets
    [34502] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ashen_grip.dds' }, -- Ashen Grip
    [34592] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', tooltip = T.Set_Alessias_Bulwark }, -- Alessia's Bulwark
    [75746] = { icon = 'LuiExtended/media/icons/abilities/ability_set_clever_alchemist.dds', tooltip = T.Set_Clever_Alchemist }, -- Clever Alchemist
    [92774] = { tooltip = A.Set_Daedric_Trickery }, -- Major Mending (Daedric Trickery)
    [92771] = { tooltip = A.Set_Daedric_Trickery }, -- Major Expedition (Daedric Trickery)
    [92775] = { tooltip = A.Set_Daedric_Trickery }, -- Major Heroism (Daedric Trickery)
    [92776] = { tooltip = A.Set_Daedric_Trickery }, -- Major Vitality (Daedric Trickery)
    [92773] = { tooltip = A.Set_Daedric_Trickery }, -- Major Protection (Daedric Trickery)
    [33764] = { icon = 'LuiExtended/media/icons/abilities/ability_set_deaths_wind.dds', tooltip = T.Generic_Knockback }, -- Death's Wind
    [52289] = { icon = 'LuiExtended/media/icons/abilities/ability_set_deaths_wind.dds', hide = true }, -- Death's Wind
    [75930] = { tooltip = T.Set_Eternal_Hunt }, -- Eternal Hunt
    [75929] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds' }, -- Eternal Hunt
    [76533] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds', tooltip = T.Generic_Immobilize }, -- Eternal Hunt
    [86555] = { name = A.Skill_Major_Evasion, tooltip = A.Set_Hist_Bark }, -- Hist Bark
    [57207] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kagrenacs_hope.dds', hide = true }, -- Kagrenac's Hope
    [34381] = { hide = true }, -- Magnus
    [99204] = { icon = 'esoui/art/icons/achievement_update16_015.dds', tooltip = T.Set_Mechanical_Acuity }, -- Mechanical Acuity (of Mechanical Acuity)
    [71671] = { hide = true, tooltip = T.Set_Morkuldin }, -- Morkuldin (Morkuldin)
    [71678] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_light_attack.dds' }, -- Light Attack (Morkuldin)
    [71679] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_cleave.dds' }, -- Cleave (Morkuldin)
    [61784] = { icon = 'esoui/art/icons/achievement_028.dds', name = A.Set_Redistribution, hide = true }, -- Redistribution
    [49126] = { icon = 'esoui/art/icons/achievement_update15_036.dds' }, -- Shalidor's Curse
    [75726] = { icon = 'LuiExtended/media/icons/abilities/ability_set_tavas_favor.dds', tooltip = T.Set_Tavas_Favor }, -- Tava's Favor
    [61851] = { hide = true }, -- Armor Master
    [61870] = { icon = 'esoui/art/icons/ava_siege_hookpoint_005.dds', tooltip = T.Set_Armor_Master }, -- Armor Master
    [34386] = { tooltip = A.Skill_Night_Mothers_Gaze }, -- Major Fracture (Night Mother's Gaze)
    [61781] = { icon = 'LuiExtended/media/icons/abilities/ability_set_nobles_conquest.dds' }, -- Noble's Conquest
    [61782] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Skill_Nobles_Conquest }, -- Minor Vulnerability (Noble's Conquest)
    [34587] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Song of Lamae
    [34588] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Song of Lamae
    [71067] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee_alt.dds', tooltip = T.Set_Trials_Shock }, -- Trial by Shock (Trials)
    [71058] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_melee_alt.dds', tooltip = T.Set_Trials_Fire }, -- Trial by Fire (Trials)
    [71019] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cold_melee_alt.dds', tooltip = T.Set_Trials_Frost }, -- Trial by Frost (Trials)
    [71072] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_melee_alt.dds', tooltip = T.Set_Trials_Poison }, -- Trial by Poison (Trials)
    [71069] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_disease_melee_alt.dds', tooltip = T.Set_Trials_Disease }, -- Trial by Disease (Trials)
    [79089] = { icon = 'esoui/art/icons/achievement_ic_survival.dds', name = A.Set_Varens_Legacy, tooltip = T.Set_Varens_Legacy }, -- Varen's Wall (Varen's Legacy)
    [79093] = { hide = true }, -- Remove Trigger (Varen's Legacy)
    [57170] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vampires_kiss.dds', tooltip = T.Set_Vampires_Kiss }, -- Vampire's Kiss
    [49236] = { icon = 'LuiExtended/media/icons/abilities/ability_set_whitestrake.dds', tooltip = T.Set_Whitestrakes_Retribution }, -- Whitestake's Retribution (Whitestrake's)
    [106776] = { forcedContainer = 'short', tooltip = A.Set_Adept_Rider }, -- Major Evasion (Adept Rider's)
    [106790] = { forcedContainer = 'short', tooltip = A.Set_Adept_Rider, groundLabel = true }, -- Major Evasion (Adept Rider's)
    [106783] = { name = A.Set_Dust_Cloud }, -- Dustcloud Damage (Adept Rider's)
    [106784] = { tooltip = T.Set_Adept_Rider }, -- Dustcloud (Adept Rider's)
    [106804] = { icon = 'esoui/art/icons/achievement_su_mainquest_6.dds', name = A.Set_Nocturnals_Favor }, -- Nocturnal's Heal (Nocturnal's Favor)
    [106798] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sloads_semblance.dds', tooltip = T.Generic_Oblivion }, -- Sload's Semblance (Sload's)
    [113092] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sloads_semblance.dds', name = A.Set_Sloads_Semblance, hide = true }, -- Sload's Projectile (Sloads)
    [113185] = { icon = 'esoui/art/icons/mm_teaser.dds' }, -- Grave-Stake Collector (Grave-Stake Collector)
    [113237] = { icon = 'esoui/art/icons/mm_teaser.dds' }, -- Grave-Stake Collector (Grave-Stake Collector)
    [113312] = { stack = 3, tooltip = A.Set_Might_of_the_Lost_Legion }, -- Empower (Might of the Lost Legion)
    [114945] = { stack = 2, tooltip = A.Set_Might_of_the_Lost_Legion }, -- Empower (Might of the Lost Legion)
    [114952] = { stack = 1, tooltip = A.Set_Might_of_the_Lost_Legion }, -- Empower (Might of the Lost Legion)
    [113306] = { tooltip = A.Set_Naga_Shaman }, -- Minor Vitality (Naga Shaman)
    [113307] = { tooltip = A.Set_Naga_Shaman }, -- Minor Mending (Naga Shaman)

    -- Overland Sets (Light)
    [75691] = { tooltip = T.Set_Bahrahas_Curse }, -- Bahraha's Curse
    [75707] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds' }, -- Bahraha's Curse
    [75692] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds' }, -- Bahraha's Curse
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', tooltip = T.Generic_Snare_70, groundLabel = true }, -- Bahraha's Curse
    [34522] = { icon = 'esoui/art/icons/achievement_wrothgar_012.dds' }, -- Bloodthorn's Touch (Bloodthorn)
    [57177] = { icon = 'esoui/art/icons/achievement_wrothgar_012.dds' }, -- Bloodthorn's Touch (Bloodthorn)
    [48913] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds', tooltip = T.Generic_Knockdown }, -- Dreamer's Mantle (Dreamer's)
    [57133] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds' }, -- Dreamer's Mantle (Dreamer's)
    [85776] = { icon = 'esoui/art/icons/achievement_update11_dungeons_010.dds' }, -- Robes of the Hist (of Hist Sap)
    [52705] = { icon = 'LuiExtended/media/icons/abilities/ability_set_martial_knowledge.dds', tooltip = T.Set_Way_of_Martial_Knowledge }, -- Way of Martial Knowledge (of Martial Knowledge)
    [85825] = { icon = 'esoui/art/icons/achievement_update16_011.dds' }, -- Prisoner's Rags (Prisoner's)
    [79200] = { tooltip = A.Set_Sithis_Touch }, -- Major Berserk (Sithis' Touch)
    [85592] = { tooltip = A.Set_Skooma_Smuggler }, -- Major Expedition (Skooma Smuggler)
    [34506] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syrabane.dds' }, -- Syrabane's Grip (of Syrabane)
    [57173] = { icon = 'LuiExtended/media/icons/abilities/ability_set_withered_hand.dds' }, -- Withered Hand
    [57175] = { icon = 'LuiExtended/media/icons/abilities/ability_set_withered_hand.dds', hide = true }, -- Withered Hand
    [71657] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds' }, -- Trinimac's Valor
    [71658] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds' }, -- Trinimac's Valor
    [93026] = { hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [92982] = { hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [93002] = { icon = 'esoui/art/icons/achievement_update16_029.dds' }, -- Mad Tinkerer (Mad Tinkerer's)
    [93003] = { icon = 'esoui/art/icons/achievement_update16_029.dds', hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [93001] = { icon = 'esoui/art/icons/achievement_update16_029.dds', tooltip = T.Generic_Knockback }, -- Mad Tinkerer (Mad Tinkerer's)
    [106806] = { tooltip = A.Set_Wisdom_of_Vanus }, -- Major Mending (Wisdom of Vanus)

    -- Overland Sets (Medium)
    [71106] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Briarheart
    [71107] = { tooltip = T.Set_Briarheart }, -- Briarheart
    [93308] = { hide = true }, -- Defiler
    [93307] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }, -- Defiler
    [93305] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds', tooltip = T.Generic_Stun }, -- Defiler
    [93326] = { hide = true }, -- Defiler
    [100704] = { hide = true }, -- Defiler
    [34875] = { icon = 'LuiExtended/media/icons/abilities/ability_set_night_terror.dds' }, -- Night Terror (of Night Terror)
    [34611] = { icon = 'esoui/art/icons/perks_fighters_guild_002.dds', tooltip = T.Set_Senche }, -- Senche's Bite (Senche's)
    [76344] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syvarras_scales.dds', name = A.Set_Syvarras_Scales, hide = true }, -- Serpent's Spirit (Syvarra's Scales)
    [75718] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syvarras_scales.dds', name = A.Set_Syvarras_Scales, tooltip = T.Generic_Poison }, -- Serpent's Spirit (Syvarra's Scales)
    [52709] = { icon = 'LuiExtended/media/icons/abilities/ability_set_way_of_air.dds', tooltip = T.Set_Way_of_Air }, -- Way of Air (of the Air)
    [34383] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_infernal_guardian.dds' }, -- Shadow of the Red Mountain (of the Red Mountain)
    [34817] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twin_sisters.dds', name = A.Set_Twin_Sisters, tooltip = T.Generic_Bleed }, -- Twin Sisters Bleed
    [34870] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wilderqueen.dds', tooltip = T.Generic_Snare_30 }, -- Wilderqueen's Arch (of the Wilderqueen)
    [99268] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unfathomable_darkness.dds', tooltip = T.Set_Unfathomable_Darknesss }, -- Unfathomable Darkness (of Unfathomable Darkness)
    [99267] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unfathomable_darkness.dds', hide = true }, -- Unfathomable Darkness (of Unfathomable Darkness)
    [34508] = { icon = 'LuiExtended/media/icons/abilities/ability_set_werewolf_hide.dds' }, -- Hide of the Werewolf (Werewolf Hide)
    [18993] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Witchman Armor (Witchman's)
    [85818] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Witchman Armor (Witchman's)
    [106860] = { tooltip = A.Set_Gyphons_Ferocity }, -- Minor Expedition (Gyphon's Ferocity)
    [106861] = { tooltip = A.Set_Gyphons_Ferocity }, -- Minor Force (Gyphon's Ferocity)
    [114977] = { icon = 'esoui/art/icons/achievement_murkmire_friend_dead_water.dds' }, -- Dead-Water's Guile (Dead-Water's Guile)

    -- Overland Sets (Heavy)
    [34711] = { icon = 'LuiExtended/media/icons/abilities/ability_set_meridia.dds', tooltip = T.Generic_Blind }, -- Meridia's Blessed Armor (Blessed)
    [57298] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds', hide = true }, -- Draugr's Heritage
    [57296] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds', tooltip = T.Generic_Knockdown }, -- Draugr's Heritage
    [57297] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds' }, -- Draugr's Heritage
    [99286] = { icon = 'esoui/art/icons/achievement_vvardenfel_046.dds' }, -- Livewire
    [79123] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morihaus.dds' }, -- Hide of Morihaus (of Morihaus)
    [79112] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morihaus.dds', tooltip = T.Generic_Knockdown }, -- Hide of Morihaus (of Morihaus)
    [34526] = { icon = 'LuiExtended/media/icons/abilities/ability_set_seventh_legion.dds', tooltip = T.Generic_Weapon_Damage_5_Seconds }, -- Seventh Legion Brute (Seventh Legion)
    [57186] = { icon = 'LuiExtended/media/icons/abilities/ability_set_seventh_legion.dds' }, -- Seventh Legion Brute (Seventh Legion)
    [85593] = { tooltip = A.Set_Shalk_Exoskeleton }, -- Minor Heroism (Shalk's)
    [85594] = { icon = 'esoui/art/icons/ability_buff_minor_heroism.dds' }, -- Minor Heroism (Shalk's)
    [52711] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_melee.dds', name = A.Set_Way_of_Fire }, -- Fiery Weapon (Way of Fire)
    [112523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hatchlings_shell.dds', tooltip = T.Generic_Damage_Shield_15_Seconds }, -- Hatchling's Shell (of the Hatchling's Shell)
    [85565] = { tooltip = A.Set_Order_of_Diagna }, -- Minor Vitality (Order of Diagna)
    [57210] = { icon = 'LuiExtended/media/icons/abilities/ability_set_storm_knight.dds', tooltip = T.Set_Storm_Knight }, -- Storm Knight's Plate (of the Storm Knight)
    [57209] = { icon = 'LuiExtended/media/icons/abilities/ability_set_storm_knight.dds' }, -- Storm Knight's Plate (of the Storm Knight)
    [85551] = { tooltip = A.Set_Vampire_Cloak }, -- Minor Protection (Vampire's Cloak)
    [33514] = { icon = 'esoui/art/icons/perks_fighters_guild_003.dds', tooltip = T.Generic_Weapon_Damage_5_Seconds }, -- Armor of the Veiled Heritance (of the Veiled Heritance)
    [33497] = { icon = 'esoui/art/icons/achievement_vvardenfel_035.dds' }, -- Thunderbug's Carapace (Thunderbug's)
    [92762] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds', tooltip = A.Set_Warrior_Poet }, -- Minor Toughness (Warrior-Poet's)
    [106865] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grace_of_gloom.dds', tooltip = T.Set_Grace_of_Gloom }, -- Grace of Gloom (Gloom-Graced)
    [106867] = { tooltip = A.Set_Grace_of_Gloom }, -- Major Evasion (Gloom-Graced)
    [106868] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grace_of_gloom.dds' }, -- Grace of Gloom (Gloom-Graced)
    [113284] = { name = A.Skill_Minor_Heroism, tooltip = A.Set_Champion_of_the_Hist }, -- Champion of the Hist (Champion of the Hist)
    [113286] = { icon = 'esoui/art/icons/ability_buff_minor_heroism.dds' }, -- Minor Heroism (Champion of the Hist)

    -- Dungeon Sets (Light)
    [61459] = { icon = 'LuiExtended/media/icons/abilities/ability_set_burning_spellweave.dds', tooltip = T.Generic_Spell_Damage_8_Seconds }, -- Burning Spellweave
    [102027] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds', hide = true }, -- Caluurion's Legacy (Fire)
    [102032] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_ranged.dds', hide = true }, -- Caluurion's Legacy (Frost)
    [102033] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', hide = true }, -- Caluurion's Legacy (Disease)
    [102034] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Caluurion's Legacy (Shock)
    [97538] = { tooltip = T.Set_Draugrs_Rest }, -- Draugr's Rest (Draugr's Rest)
    [97539] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds' }, -- Draugr's Rest
    [97574] = { icon = 'LuiExtended/media/icons/abilities/ability_set_flame_blossom.dds' }, -- Flame Blossom
    [84341] = { tooltip = A.Set_Gossamer }, -- Major Evasion (Gossamer)
    [85610] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Lamia's Song (Lamia's)
    [67129] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds', tooltip = T.Set_Overwhelming_Surge }, -- Overwhelming Surge (Overwhelming)
    [67136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds' }, -- Overwhelming Surge (Overwhelming)
    [34504] = { icon = 'LuiExtended/media/icons/abilities/ability_set_prayer.dds', tooltip = T.Generic_Damage_Shield_6_Seconds }, -- Prayer Shawl (of Prayer)
    [32834] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds', tooltip = T.Set_Sanctuary }, -- Sanctuary (of Sanctuary)
    [66902] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_courage.dds', tooltip = A.Set_Spell_Power_Cure }, -- Spell Power Cure
    [67098] = { icon = 'LuiExtended/media/icons/abilities/ability_set_combat_physician.dds', tooltip = T.Generic_Damage_Shield_6_Seconds }, -- Combat Physician (of the Combat Physician)
    [57164] = { icon = 'esoui/art/icons/achievement_ic_014.dds', tooltip = T.Set_Shroud_of_the_Lich }, -- Shroud of the Lich (of the Lich)
    [34813] = { icon = 'LuiExtended/media/icons/abilities/ability_set_magicka_furnace.dds' }, -- Magicka Furnace (of the Magicka Furnace)
    [34373] = { name = A.Set_Noble_Duelist, tooltip = T.Generic_LA_HA_Damage_8_Seconds }, -- Noble Duelist's Silks (Noble Duelist)
    [67288] = { icon = 'esoui/art/icons/ava_siege_hookpoint_002.dds', tooltip = T.Generic_Spell_Damage_6_Seconds }, -- Scathing Mage (of the Scathing Mage)
    [59676] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_unweaver.dds', tooltip = T.Generic_LA_HA_Damage_10_Seconds }, -- Undaunted Unweaver (of the Undaunted Unweaver)
    [57163] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_027.dds' }, -- Robes of the Warlock (of the Warlock)
    [47367] = { icon = 'LuiExtended/media/icons/abilities/ability_set_worm_cult.dds', tooltip = T.Set_Worms_Raiment }, -- Worm's Raiment (of the Worm Cult)
    [85613] = { tooltip = A.Set_Treasure_Hunter }, -- Major Prophecy (Treasure Hunter's)
    [111377] = { tooltip = A.Set_Hanus_Compassion }, -- Major Heroism (Hanu's Compassion)
    [111380] = { tooltip = A.Set_Hanus_Compassion }, -- Major Heroism (Hanu's Compassion)
    [111204] = { icon = 'esoui/art/icons/achievement_thievesguild_003.dds', tooltip = T.Set_Moon_Hunter }, -- Moon Hunter (Moon Hunter)

    -- Dungeon Sets (Medium)
    [85977] = { icon = 'LuiExtended/media/icons/abilities/ability_set_barkskin.dds' }, -- Barkskin
    [85978] = { icon = 'LuiExtended/media/icons/abilities/ability_set_barkskin.dds' }, -- Barkskin
    [84310] = { tooltip = A.Set_Heem_Jas }, -- Major Berserk (Heem-Jas' Retribution)
    [47365] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds', tooltip = T.Set_Hircines_Veneer }, -- Hircine's Veneer (Hircine's)
    [85602] = { tooltip = A.Set_Jailbreaker }, -- Minor Expedition (Jailbreaker)
    [34612] = { hide = true }, -- Oblivion's Edge (of Oblivion)
    [57206] = { icon = 'LuiExtended/media/icons/abilities/ability_set_oblivion.dds' }, -- Oblivion's Edge (of Oblivion)
    [97716] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pillar_of_nirn.dds' }, -- Pillar of Nirn
    [97743] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pillar_of_nirn.dds', tooltip = T.Generic_Bleed }, -- Pillar of Nirn
    [102106] = { tooltip = T.Set_Plague_Slinger }, -- Skeever Corpse (Plague Slinger)
    [102113] = { icon = 'LuiExtended/media/icons/abilities/ability_set_plague_slinger.dds'} , -- Plague Slinger
    [67141] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sheer_venom.dds', tooltip = T.Generic_Poison }, -- Sheer Venom
    [60060] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sunderflame.dds' }, -- Sunderflame
    [85635] = { icon = 'LuiExtended/media/icons/abilities/ability_set_spelunker.dds' }, -- Spelunker (Spelunker's)
    [70297] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee.dds' }, -- Storm Master (Storm Master's)
    [70298] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee.dds', tooltip = T.Set_Storm_Master }, -- Storm Master (Storm Master's)
    [60416] = { tooltip = A.Set_Sunderflame }, -- Minor Fracture (Sunderflame)
    [108825] = { tooltip = A.Set_Sunderflame }, -- Minor Breach (Sunderflame)
    [49220] = { hide = true }, -- Extra dodge (of the Crusader)
    [67334] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds', tooltip = T.Set_Essence_Thief }, -- Essence Thief (of the Essence Thief)
    [70284] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }, -- Essence Thief (of the Essence Thief)
    [70290] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }, -- Essence Thief (of the Essence Thief)
    [59667] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_infiltrator.dds', tooltip = T.Generic_LA_HA_Damage_10_Seconds }, -- Undaunted Infiltrator (of the Undaunted Infiltrator)
    [33691] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vipers_sting.dds', tooltip = T.Generic_Poison }, -- Viper's Sting
    [85605] = { tooltip = A.Set_Toothrow }, -- Major Savagery (Toothrow)
    [101970] = { icon = 'LuiExtended/media/icons/abilities/ability_set_invigoration.dds' }, -- Trappings of Invigoration
    [84350] = { icon = 'esoui/art/icons/achievement_update11_dungeons_035.dds' }, -- Widowmaker
    [111387] = { icon = 'esoui/art/icons/mh_no_rage_cleanse.dds', tooltip = T.Set_Blood_Moon_Scent }, -- Blood Scent (Blood Moon)
    [111386] = { icon = 'LuiExtended/media/icons/abilities/ability_set_blood_moon.dds', tooltip = T.Set_Blood_Moon_Frenzied }, -- Frenzied (Blood Moon)
    [111216] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_bleed.dds', tooltip = T.Generic_Bleed }, -- Savage Werewolf (Savage Werewolf)

    -- Dungeon Sets (Heavy)
    [102023] = { icon = 'LuiExtended/media/icons/abilities/ability_set_curse_of_doylemish.dds' }, -- Curse of Doylemish
    [34527] = { tooltip = A.Set_Duroks_Bane }, -- Durok's Bane Major Defile (of Durok's Bane)
    [47362] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ebon.dds', tooltip = T.Set_Ebon_Armory }, -- Ebon Armory (Ebon)
    [59695] = { icon = 'LuiExtended/media/icons/abilities/ability_set_embershield.dds', tooltip = T.Set_Embershield }, -- Embershield (Embershield)
    [59696] = { icon = 'LuiExtended/media/icons/abilities/ability_set_embershield.dds' }, -- Embershield (Embershield)
    [97908] = { tooltip = T.Set_Hagravens_Garden}, -- Hagraven's Garden (Hagraven's)
    [97918] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds' }, -- Hagraven's Garden (Hagraven's)
    [114802] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', name = A.Set_Hagravens_Garden, tooltip = T.Generic_Knockback }, -- Stun (Hagraven's)
    [34404] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ice_furnace.dds', name = A.Set_Ice_Furnace }, -- Frostfire (Ice Furnace)
    [97626] = { icon = 'esoui/art/icons/achievement_update11_dungeons_036.dds', unbreakable = 1, tooltip = T.Generic_Snare_50 }, -- Ironblood
    [97627] = { tooltip = A.Set_Ironblood }, -- Major Protection (Ironblood)
    [67078] = { icon = 'LuiExtended/media/icons/abilities/ability_set_jolting.dds', tooltip = T.Set_Jolting_Arms }, -- Jolting Arms (Jolting)
    [67080] = { icon = 'LuiExtended/media/icons/abilities/ability_set_jolting.dds', name = A.Set_Jolting_Arms }, -- Shocking Bash (Jolting)
    [85620] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_028.dds' }, -- Knight-Errant's Mail (Knight-Errant's)
    [67205] = { tooltip = T.Set_Leeching_Plate }, -- Leeching Plate (of Leeching)
    [69345] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Leeching Plate (of Leeching)
    [67204] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Leeching Plate (of Leeching)
    [84277] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    [84278] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    [84279] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    [85611] = { tooltip = A.Set_Medusa }, -- Minor Force (of Medusa)
    [84354] = { tooltip = T.Set_Handle_of_Mephala }, -- Hand of Mephala (Mephala's Hand)
    [84357] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = A.Set_Hand_of_Mephala, duration = 0, tooltip = T.Generic_Snare_50, groundLabel = true }, -- Hand of Mephala Webbing (of Mephala's Hand)
    [84355] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds' }, -- Hand of Mephala (of Mephala's Hand)
    [84358] = { tooltip = A.Set_Hand_of_Mephala }, -- Hand of Mephala (of Mephala's Hand)
    [85623] = { tooltip = A.Set_Rattlecage }, -- Major Sorcery (Rattlecage)
    [32735] = { tooltip = A.Set_Dreugh_King_Slayer }, -- Major Brutality (Dreugh King Slayer)
    [34511] = { tooltip = A.Set_Dreugh_King_Slayer }, -- Major Expedition (Dreugh King Slayer)
    [66887] = { icon = 'LuiExtended/media/icons/abilities/ability_set_imperium.dds', tooltip = T.Generic_Damage_Shield_6_Seconds }, -- Brands of the Imperium (of the Imperium)
    [33512] = { tooltip = A.Set_Knightmare }, -- Minor Maim (of the Knightmare)
    [67283] = { icon = 'esoui/art/icons/achievement_ic_025_heroic.dds', name = A.Set_Tormentor, tooltip = T.Generic_Phy_Spell_Resist_15_Seconds }, -- Tormentor Resistance (of the Tormentor)
    [61200] = { icon = 'esoui/art/icons/achievement_undaunteddailies_003.dds', tooltip = T.Generic_Damage_Shield_6_Seconds }, -- Undaunted Bastion (of the Undaunted Bastion)
    [86070] = { icon = 'esoui/art/icons/achievement_thievesguild_034.dds', tooltip = T.Generic_Weapon_Damage_10_Seconds }, -- Armor of Truth (of Truth)
    [112414] = { icon = 'LuiExtended/media/icons/abilities/ability_set_haven_of_ursus.dds', tooltip = T.Generic_Damage_Shield_6_Seconds }, -- Ursus's Blessing (Haven of Ursus)
    [111445] = { icon = 'LuiExtended/media/icons/abilities/ability_set_haven_of_ursus.dds', tooltip = T.Generic_Damage_Shield_6_Seconds }, -- Ursus's Blessing (Haven of Ursus)
    [111221] = { tooltip = A.Set_Jailers_Tenacity }, -- Major Vitality (Jailer's Tenacity)

    -- Trial Sets (Hel Ra Citadel)
    [50978] = { icon = 'esoui/art/icons/achievement_update11_dungeons_001.dds', tooltip = T.Set_Berserking_Warrior }, -- Berserking Warrior (Advancing Yokeda)
    [90937] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds', unbreakable = 1, tooltip = T.Generic_Immunity }, -- Immortal Warrior (Immortal Yokeda)
    [90938] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Set_Immortal_Warrior, A.Set_Cooldown), tooltip = T.Set_Eternal_Immortal_Warrior }, -- Immortal Warrior (Immortal Yokeda)
    [86907] = { icon = 'LuiExtended/media/icons/abilities/ability_set_defending_warrior.dds' }, -- Defending Warrior (Resilient Yokeda)
    [50992] = { icon = 'LuiExtended/media/icons/abilities/ability_set_defending_warrior.dds' }, -- Defending Warrior (Resilient Yokeda)
    [76618] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_minor_aegis.dds', tooltip = T.Skill_Minor_Aegis }, -- Minor Aegis (Eternal Yokeda)
    [90940] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds', unbreakable = 1, tooltip = T.Generic_Immunity }, -- Eternal Warrior (Eternal Yokeda)
    [61437] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds' }, -- Eternal Warrior (Eternal Yokeda)
    [90939] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Set_Eternal_Warrior, A.Set_Cooldown), tooltip = T.Set_Eternal_Immortal_Warrior }, -- Eternal Warrior (Eternal Yokeda)

    -- Trial Sets (Aetherian Archive)
    [51315] = { icon = 'LuiExtended/media/icons/abilities/ability_set_destructive_mage.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Set_Destructive_Mage }, -- Destructive Mage (Aether... of Destruction)
    [51320] = { icon = 'LuiExtended/media/icons/abilities/ability_set_destructive_mage.dds', name = A.Set_Destructive_Mage }, -- Mage Destruction Bomb (Aether... of Destruction)
    [51443] = { icon = 'LuiExtended/media/icons/abilities/ability_set_healing_mage.dds', name = A.Set_Healing_Mage, tooltip = T.Set_Healing_Mage }, -- Healing Bane (of Mending)
    [51434] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Set_Wise_Mage }, -- Minor Vulnerability (Aether ... of Strategy)
    [76617] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds', tooltip = T.Skill_Minor_Slayer }, -- Minor Slayer (of the Infallible Aether)
    [81519] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Set_Infallible_Mage }, -- Minor Vulnerability (of the Infallible Aether)

    -- Trial Sets (Sanctum Ophidia)
    [51241] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vipers_sting.dds' }, -- Poisonous Serpent (Ophidian ... of Venom)
    [51176] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_010.dds', tooltip = T.Set_Twice_Fanged_Serpent }, -- Twice-Fanged Serpent (of the Two-Fanged Snake)
    [98103] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds', tooltip = T.Skill_Minor_Slayer }, -- Minor Slayer (of the Vicious Ophidian)
    [50997] = { tooltip = A.Set_Quick_Serpent }, -- Major Expedition (Ophidian.. of Celerity)
    [81524] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', name = A.Skill_Major_Expedition, tooltip = A.Set_Vicious_Serpent }, -- Quick Serpent (of the Vicious Ophidian)
    [81522] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicious_serpent.dds', name = A.Set_Vicious_Serpent }, -- Serpent Stamina (of the Vicious Ophidian)

    -- Trial Sets (Maw of Lorkhaj)
    [75801] = { icon = 'LuiExtended/media/icons/abilities/ability_set_moondancer_lunar.dds', tooltip = T.Generic_Magicka_Recovery_30_Seconds }, -- Lunar Blessing (Moondancer)
    [75804] = { icon = 'LuiExtended/media/icons/abilities/ability_set_moondancer_shadow.dds', tooltip = T.Generic_Spell_Damage_30_Seconds }, -- Shadow Blessing (Moondancer)
    [98102] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds', tooltip = T.Skill_Minor_Slayer }, -- Minor Slayer (of Alkosh)
    [75752] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds' }, -- Roar of Alkosh (of Alkosh)
    [75753] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds', tooltip = T.Set_Alkosh }, -- Line Breaker (of Alkosh)
    [76667] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds', tooltip = T.Generic_Bleed }, -- Roar of Alkosh (of Alkosh)
    [75815] = { icon = 'LuiExtended/media/icons/abilities/ability_set_lunar_bastion.dds', duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = T.Set_Lunar_Bastion }, -- Lunar Bastion (of the Lunar Bastion)
    [75770] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds', tooltip = T.Generic_HoT_1Sec_10Sec }, -- Twilight Remedy (of Twilight Remedy)
    [76564] = { tooltip = A.Set_Twilight_Remedy }, -- Minor Force (of Twilight Remedy)

    -- Trial Sets (Halls of Fabrication)
    [93444] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_aegis.dds', tooltip = T.Skill_Major_Aegis }, -- Major Aegis (Automated Defense)
    [93125] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_aegis.dds', tooltip = T.Skill_Major_Aegis }, -- Major Aegis (Inventor's Guard)
    [93120] = { icon = 'esoui/art/icons/achievement_vvardenfel_061.dds', tooltip = T.Skill_Major_Slayer }, -- Major Slayer (Master Architect)
    [93442] = { icon = 'esoui/art/icons/achievement_vvardenfel_061.dds', tooltip = T.Skill_Major_Slayer }, -- Major Slayer (War Machine)

    -- Trial Sets (Cloudrest)
    [107141] = { tooltip = T.Set_Vestment_of_Olorime }, -- Vestment of Olirime (Olirime's)
    [109994] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_courage.dds', tooltip = A.Set_Vestment_of_Olorime }, -- Major Courage (Olirime's)
    [109084] = { tooltip = T.Set_Vestment_of_Olorime }, -- Ideal Vestment of Olirime (Olirime's Perfect)
    [110020] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_courage.dds', tooltip = A.Set_Vestment_of_Olorime }, -- Major Courage (Olirime's Perfect)
    [107095] = { tooltip = T.Set_Mantle_of_Siroria }, -- Mantle of Siroria (Siroria's)
    [110118] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sirorias_boon.dds', tooltip = T.Set_Sirorias_Boon }, -- Siroria's Boon (Siroria's)
    [109081] = { tooltip = T.Set_Mantle_of_Siroria }, -- Ideal Mantle of Siroria (Siroria's)
    [110142] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sirorias_boon.dds', tooltip = T.Set_Sirorias_Boon }, -- Siroria's Boon (Perfect Siroria's)
    [110504] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds', tooltip = T.Set_Relequens }, -- Arms of Relequen (Perfect Relequen's)
    [107203] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds' }, -- Arms of Relequen (Perfect Relequen's)
    [110512] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds', name = A.Set_Arms_of_Relequen, tooltip = T.Set_Relequens }, -- Ideal Arms of Relequen (Relequen's)
    [109086] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds', name = A.Set_Arms_of_Relequen }, -- Ideal Arms of Relequen (Relequen's)
    [109976] = { tooltip = A.Set_Aegis_of_Galenwe }, -- Empower (Aegis of Galenwe)
    [109989] = { tooltip = A.Set_Aegis_of_Galenwe }, -- Empower (Ideal Aegis of Galenwe)

    -- Battleground Sets
    [92908] = { tooltip = A.Set_Cowards_Gear }, -- Major Expedition (Coward's Gear)
    [92909] = { tooltip = A.Set_Cowards_Gear }, -- Major Protection (Coward's Gear)
    [93104] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_oblivion.dds' }, -- Knight Slayer
    [92916] = { icon = 'esoui/art/icons/achievement_update15_041.dds', tooltip = T.Set_Vanguards_Challenge }, -- Vanguard's Challenge
    [92921] = { tooltip = A.Set_Wizards_Riposte }, -- Minor Maim (Wizard's Riposte)

    -- Imperial City Sets
    [61762] = { hide = true }, -- Black Rose (of the Black Rose)
    [79421] = { icon = 'LuiExtended/media/icons/abilities/ability_set_galerions_revenge.dds', tooltip = T.Set_Galerions_Revenge }, -- Mark of Revenge (Galerion's)
    [79420] = { icon = 'LuiExtended/media/icons/abilities/ability_set_galerions_revenge.dds' }, -- Galerion's Revenge (Galerion's)
    [65706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_meritorious_service.dds', tooltip = T.Set_Meritorius_Service }, -- Meritorious Service (of Meritorious Service)
    [90935] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds', unbreakable = 1, tooltip = T.Generic_Immunity }, -- Phoenix (of the Phoenix)
    [90936] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Set_Phoenix, A.Set_Cooldown), tooltip = T.Set_Phoenix }, -- Phoenix (of the Phoenix)
    [68940] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds' }, -- Phoenix (of the Phoenix)
    [70405] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds' }, -- Phoenix (of the Phoenix)
    [61771] = { icon = 'LuiExtended/media/icons/abilities/ability_set_powerful_assault.dds', tooltip = T.Generic_Weapon_Spell_Damage_15_Seconds }, -- Powerful Assault (of the Powerful Assault)
    [68974] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_oblivion.dds' }, -- Shield Breaker (of the Shield Breaker)
    [79363] = { icon = 'esoui/art/icons/achievement_029.dds' }, -- Thews of the Harbinger (of the Harbinger)
    [79469] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicecanon.dds', name = A.Set_Vicecannon_of_Venom, tooltip = T.Generic_Poison }, -- Deadly Venom (the Vicanon's)
    [79471] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicecanon.dds', name = A.Set_Vicecannon_of_Venom }, -- Deadly Venom (the Vicanon's)

    -- Cyrodiil Sets (Light)
    [34605] = { icon = 'LuiExtended/media/icons/abilities/ability_set_almalexias_mercy.dds' }, -- Almalexia's Mercy (of Almalexia's Mercy)
    [70392] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arch-mage.dds' }, -- The Arch-Mage (of the Arch-Mage)
    [111550] = { icon ='esoui/art/icons/achievement_darkbrotherhood_027.dds', tooltip = T.Set_Light_of_Cyrodiil }, -- Light of Cyrodiil (of Cyrodiil's Light)
    [112750] = { hide = true }, -- Light of Cyrodiil (of Cyrodiil's Light)
    [33498] = { icon = 'esoui/art/icons/achievement_update11_dungeons_007.dds' }, -- Desert Rose (of the Desert Rose)
    [47352] = { icon = 'LuiExtended/media/icons/abilities/ability_set_whitestrake.dds', tooltip = T.Generic_Damage_Shield_6_Seconds }, -- Buffer of the Swift (of the Swift)

    -- Cyrodiil Sets (Medium)
    [34876] = { tooltip = A.Set_Ward_of_Cyrodiil }, -- Major Defile (of Cyrodiil's Ward)
    [34509] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_kiss.dds' }, -- Kyne's Kiss (of Kyne's Kiss)
    [70492] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_kiss.dds' }, -- Kyne's Kiss (of Kyne's Kiss)
    [34384] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morag_tong.dds', tooltip = T.Set_Morag_Tong }, -- The Morag Tong (of the Morag Tong)
    [57180] = { icon = 'esoui/art/icons/achievement_thievesguild_011.dds' }, -- Shadow Walker (of the Shadow Walker)
    [57181] = { icon = 'esoui/art/icons/achievement_thievesguild_011.dds' }, -- Shadow Walker (of the Shadow Walker)
    [47358] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)
    [47359] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)
    [47360] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)

    -- Cyrodiil Sets (Heavy)
    [34787] = { icon = 'LuiExtended/media/icons/abilities/ability_set_affliction.dds' }, -- Affliction (Afflicted)
    [29122] = { hide = true }, -- Beckoning Steel (Beckoning Steel)

    [111575] = { icon = 'LuiExtended/media/icons/abilities/ability_set_crest_of_cyrodiil.dds' }, -- Crest of Cyrodiil (Cyrodiil's Crest)

    [34872] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_ravager.dds', tooltip = T.Generic_Weapon_Damage_10_Seconds }, -- The Ravager (Ravaging)
    [34512] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_juggernaut.dds' }, -- The Juggernaut (of the Juggernaut)

    -- Rewards for the Worthy Sets
    [113523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_battalion_defender.dds' }, -- Battalion Defender (Battalion Defender)
    [113355] = { tooltip = A.Set_Indomitable_Fury }, -- Indomitable Fury (Indomitable Fury)
    [113354] = { icon = 'esoui/art/icons/ability_buff_minor_heroism.dds' }, -- Indomitable Fury (Indomitable Fury)
    [113356] = { tooltip = A.Set_Indomitable_Fury }, -- Indomitable Fury (Indomitable Fury)
    [113461] = { icon = 'esoui/art/icons/achievement_murkmire_rescue_villagers.dds', name = A.Set_Soldier_of_Anguish, tooltip = T.Set_Soldier_of_Anguish }, -- Heal Absorption (Soldier of Anguish)
    [113382] = { icon = 'esoui/art/icons/achievement_blackrose_boss_5.dds', tooltip = T.Set_Spell_Strategist }, -- Spell Strategist (Spell Strategist)
    [113417] = { hide = true }, -- Spell Strategist (Spell Strategist)
    [113509] = { tooltip = A.Set_Steadfast_Hero }, -- Major Protection (Steadfast Hero)

    [76947] = { icon = 'esoui/art/icons/ability_debuff_minor_defile.dds', name = A.Skill_Minor_Defile, duration = 0 }, -- Fasalla's Guile (of Fasalla's Guile)
    [76950] = { icon = 'esoui/art/icons/ability_warrior_025.dds' }, -- Warrior's Fury (of Fury)
    [76936] = { icon = 'LuiExtended/media/icons/abilities/ability_set_transmutation.dds' }, -- Transmutation (of Transmutation)
    [76938] = { icon = 'esoui/art/icons/procs_003.dds' }, -- Vicious Death (of Vicious Death)

    -- Maelstrom Arena Sets
    [71264] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_melee_alt.dds', tooltip = T.Set_Succession_Flame }, -- Fire Ascendant (of Succession)
    [71265] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee_alt.dds', tooltip = T.Set_Succession_Shock  }, -- Lightning Ascendant (of Succession)
    [71266] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cold_melee_alt.dds', tooltip = T.Set_Succession_Frost }, -- Frost Ascendant (of Succession)
    [73296] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winterborn.dds', name = A.Set_Winterborn, duration = 0, groundLabel = true, tooltip = T.Generic_Snare_60 }, -- Winterborn Snare (Winterborn)
    [71646] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winterborn.dds' }, -- Winterborn (Winterborn)
    [71188] = { icon = 'esoui/art/icons/ability_rogue_019.dds', name = A.Set_Glorious_Defender, tooltip = T.Set_Glorious_Defender }, -- Glorious Defense (of Glory)
    [71605] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hunt_leader.dds' }, -- Hunt Leader (of the Hunt)
    [74106] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hunt_leader.dds' }, -- Hunt Leader (of the Hunt)
    [71193] = { icon = 'LuiExtended/media/icons/abilities/ability_set_para_bellum.dds', name = A.Set_Para_Bellum, duration = 0, forcedContainer = 'short', tooltip = T.Set_Para_Bellum }, -- Para Bellum Shield (Para Bellum)

    -- Dragonstar Arena Sets
    [29096] = { tooltip = A.Set_Healers_Habit }, -- Minor Mending (of the Healer)

    -- DISGUISES
    [82631] = { icon = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds', name = A.Disguise_Monks_Disguise }, -- Monk Disguise Timer (Monk's Disguise)

    ----------------------------------------------------------------
    -- CHAMPION POINTS ---------------------------------------------
    ----------------------------------------------------------------

    -- The Steed
    [98313] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_invigorating_bash.dds' }, -- Invigorating Bash
    [98294] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_phase.dds', tooltip = T.Champion_Phase }, -- Phase
    [61661] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_resilient.dds' }, -- Resilient
    [98314] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds', tooltip = T.Champion_Reinforced }, -- Reinforced

    -- The Lady
    [63110] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_spell_absorption.dds' }, -- Spell Absorption
    [60371] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_critical_leech.dds' }, -- Critical Leech
    [98316] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_unchained.dds', tooltip = T.Champion_Unchained }, -- Unchained

    -- The Lord
    [98404] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_infusion.dds', tooltip = T.Generic_Magicka_Recovery_10_Seconds }, -- Infusion
    [98414] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds', tooltip = T.Champion_Revival }, -- Revival
    [61015] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds', tooltip = T.Champion_Determination }, -- Determination

    -- The Tower
    [98308] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_ensnare.dds', tooltip = T.Champion_Ensnare }, -- Ensnare
    [92428] = { icon = 'esoui/art/icons/ability_healer_012.dds', tooltip = T.Champion_Siphoner }, -- Siphoner
    [62518] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_maras_gift.dds' }, -- Mara's Gift

    -- The Lover
    [63878] = { icon = 'esoui/art/icons/ability_healer_033.dds' }, -- Synergizer

    -- The Shadow
    [64244] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_shadowstrike.dds', tooltip = T.Champion_Shadowstrike }, -- Shadowstrike
    [64245] = { hide = true }, -- Shadowstrike

    -- The Apprentice
    [63152] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_vengeance.dds', name = A.Champion_Vengeance_Charge, tooltip = T.Champion_Vengeance_Charge }, -- Vengeance Count
    [63151] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_vengeance_full.dds', tooltip = T.Champion_Vengeance }, -- Vengeance
    [59530] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_foresight.dds', tooltip = T.Champion_Foresight }, -- Foresight
    [63114] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_arcane_well.dds' }, -- Arcane Well
    [88784] = { hide = true }, -- Arcane Well

    -- The Atronach
    [63106] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_retaliation.dds', tooltip = T.Champion_Retaliation }, -- Retaliation
    [60230] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_riposte.dds' }, -- Riposte
    [63108] = { name = A.Skill_Off_Balance, tooltip = A.Champion_Tactician }, -- Off-Balance (Tactician)

    -- The Ritual
    [98307] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_opportunist.dds', tooltip = T.Champion_Opportunist }, -- Opportunist
    [100408] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_opportunist.dds', tooltip = T.Champion_Opportunist }, -- Opportunist
    [65133] = { tooltip = A.Champion_Last_Stand }, -- Major Heroism (Last Stand)

    ----------------------------------------------------------------
    -- PLAYER ABILITIES - BASIC ------------------------------------
    ----------------------------------------------------------------

    -- Test
    [16415] = { tooltip = T.Generic_Test }, -- Test

    -- Roll Dodge
    [29721] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_roll_dodge.dds', tooltip = T.Innate_Immobilize_Immunity }, -- Immobilize Immunity
    [69143] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_dodge_fatigue.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Innate_Dodge_Fatigue }, -- Dodge Fatigue

    -- Crouch
    [20299] = { tooltip = T.Innate_Hidden }, -- Sneak
    [20309] = { tooltip = T.Innate_Invisible }, -- Crouch

    [20301] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', name = A.Innate_Crouch }, -- Crouch Drain
    [26245] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_018.dds', name = A.Innate_Stealth_Stun, tooltip = T.Generic_Stun }, -- Slam Stun (Stun from crouch attack)

    -- Sprint
    [973] = {  tooltip = T.Innate_Sprint }, -- Sprint
    [15356] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', name = A.Innate_Sprint }, -- Sprint Drain

    -- Misc
    [10950] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fall_snare.dds', name = A.Innate_Fall_Damage }, -- Fall Snare
    [6811] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recall.dds', tooltip = T.Innate_Recall_Penalty }, -- Recall
    [69293] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recall.dds', name = A.Innate_Recall }, -- Recall
    [14644] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_resurrection_immunity.dds', name = A.Innate_Revive }, -- Revive (Death Dialogue)
    [31221] = { hide = true }, -- Skyshard Collect (Aura on Skyshard when player collects it)
    [32346] = { icon = 'esoui/art/icons/ability_mage_050.dds', name = A.Innate_Absorbing_Skyshard, unbreakable = 1}, -- Skyshard Collect
    [63601] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_eso_plus_member.dds', tooltip = T.Innate_ESO_Plus }, -- ESO Plus Member
    [47270] = { icon = 'esoui/art/icons/achievement_update11_dungeons_017.dds', hide = true }, -- Ritual of Mara
    [2727] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance, tooltip = "" }, -- Off-Balance
    [102771] = { stack = 0, type = 1, tooltip = T.Generic_Off_Balance_Immunity }, -- Off Balance Immunity
    [85701] = { hide = true, tooltip = T.Innate_Battle_Spirit }, -- Dueling Flag
    [21263] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_ayleid_well.dds', name = A.Innate_Ayleid_Well, tooltip = T.Innate_Ayleid_Well }, -- Ayleid Health Bonus
    [100862] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_ayleid_well.dds', name = A.Innate_Ayleid_Well_Fortified, tooltip = T.Innate_Ayleid_Well_Fortified }, -- Ayleid Health Bonus
    [105188] = { hide = true }, -- Grim Focus Combat Trigger
    [105190] = { hide = true }, -- Grim Focus Combat Trigger
    [105192] = { hide = true }, -- Grim Focus Combat Trigger
    [105194] = { hide = true }, -- RF Combat Trigger

    -- Mount
    [37059] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds' }, -- Mount Up
    [42514] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds', unbreakable = 1, tooltip = T.Generic_Knockdown }, -- Hard Dismount
    [33439] = { tooltip = T.Innate_Gallop },

    -- Block
    [14890] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', forcedContainer = 'short', tooltip = T.Innate_Block }, -- Block
    [16270] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = A.Innate_Block }, -- Brace Cost
    [88724] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = A.Innate_Block }, -- Brace Cost
    [86310] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, hide = true, tooltip = T.Generic_Stagger }, -- Stagger (Player blocks NPC charged attack)
    [86309] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, tooltip = T.Generic_Stun }, -- Stun (Player blocks NPC charged attack)
    [86312] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, tooltip = T.Generic_Stun }, -- Stun (Player blocks Ogrim Body Slam)
    [45902] = { name = A.Skill_Off_Balance, tooltip = "" }, -- Off-Balance

    -- Bash
    [21970] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_bash.dds' }, -- Bash
    [21973] = { icon = '' }, -- Bash (Hides icon for interrupt)
    [21972] = { tooltip = T.Generic_Stagger }, -- Stagger
    [21971] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', tooltip = T.Generic_Stun }, -- Bash Stun (Stun from bashing cast)
    [45982] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', tooltip = T.Generic_Stun }, -- Bash Stun (Stun from bashing cast when NPC is pinned against an obstacle)

    -- Off-Balance Exploit
    [16825] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_off-balance_exploit.dds', tooltip = T.Generic_Knockdown }, -- Off-Balance Exploit

    -- Mundus Stone Events
    [14031] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mundus_use.dds', name = A.Innate_Receiving_Boon, unbreakable = 1}, -- Mundus Use

    -- Death/Resurrection
    [14646] = { tooltip = T.Innate_Resurrection_Immunity }, -- Recently Revived
    [55400] = { hide = true }, -- Magicka Restore
    [55401] = { hide = true }, -- Magicka Restore

    -- Basic Attacks
    [16593] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_melee_snare.dds', tooltip = T.Generic_Snare }, -- Melee Snare
    [48532] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_melee_snare.dds', hide = true }, -- Charge Snare
    --[61737] = { tooltip = T.Skill_Empower }, -- Empower
    [55080] = { hide = true }, -- Pet Hidden
    [28301] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', tooltip = T.Generic_CC_Immunity }, -- Crowd Control Immunity

    -- Taunt Effects
    [38254] = { icon = 'esoui/art/icons/ability_warrior_010.dds' }, -- Taunt
    [38541] = { icon = 'esoui/art/icons/ability_warrior_010.dds', tooltip = T.Innate_Taunt }, -- Taunt

    -- Disguise Effects
    [50602] = { tooltip = T.Innate_Disguised }, -- Disguised
    [13371] = { hide = true }, -- Acting Suspicious

    -- Pet Effects
    [63794] = { hide = true }, -- Taunt
    [112170] = { hide = true }, -- CC Immunity

    -- Housing
    [89469] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_create_station_blacksmith.dds', name = A.Innate_Create_Station_Blacksmith }, -- 68235 Stun
    [89645] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_create_station_clothing.dds', name = A.Innate_Create_Station_Clothing }, -- 68235 Stun
    [105217] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_create_station_jewelry.dds', name = A.Innate_Create_Station_Jewelry }, -- 68235 Stun
    [89654] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_create_station_woodwork.dds', name = A.Innate_Create_Station_Woodwork }, -- 68235 Stun

    ----------------------------------------------------------------
    -- WORLD EVENTS  -----------------------------------------------
    ----------------------------------------------------------------

    -- Daedric Anchor
    [86717] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_anchor_drop.dds', name = A.Innate_Anchor_Drop }, -- Drop Anchor
    [46690] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds' }, -- Power of the Daedra
    [46689] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = A.Innate_Power_of_the_Daedra }, -- Vitality of the Daedra
    [51632] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = A.Innate_Power_of_the_Daedra }, -- Vitality of the Daedra
    [51633] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = A.Innate_Power_of_the_Daedra }, -- Vitality of the Daedra
    [95813] = { type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1 }, -- Static Charge
    [46291] = { hide = true }, -- Rain of Doom
    [46293] = { hide = true }, -- Stun

    -- Misc World + Theater
    [822] = { hide = true }, -- Ward
    [48899] = { icon = 'esoui/art/icons/achievement_newlifefestival_007.dds', tooltip = T.Innate_Firelight }, -- Firelight

    ----------------------------------------------------------------
    -- DRAGONKNIGHT PASSIVES ---------------------------------------
    ----------------------------------------------------------------

    -- Ardent Flame
    [29424] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 1)
    [108806] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 1)
    [108809] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 1)
    [45011] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 2)
    [108816] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 2)
    [108815] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 2)
    [29436] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds' }, -- Warmth (Warmth - Rank 1)
    [45016] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds' }, -- Warmth (Warmth - Rank 2)
    [29451] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_world_in_ruin.dds' }, -- World in Ruin (World in Ruin - Rank 1)
    [45029] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_world_in_ruin.dds' }, -- World in Ruin (World in Ruin - Rank 2)

    -- Earthen Heart
    [29465] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [29466] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [29467] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [44986] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)
    [44987] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)
    [44988] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)
    [29468] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_eternal_mountain.dds' }, -- Eternal Mountain (Eternal Mountain - Rank 1)
    [44996] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_eternal_mountain.dds' }, -- Eternal Mountain (Eternal Mountain - Rank 2)
    [29474] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds' }, -- Mountain's Blessing (Mountain's Blessing - Rank 1)
    [45005] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds' }, -- Mountain's Blessing (Mountain's Blessing - Rank 1)
    [29475] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 1)
    [29476] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 1)
    [45009] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 2)
    [45010] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 2)

    ----------------------------------------------------------------
    -- DRAGONKNIGHT ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------

    -- Lava Whip / Molten Whip / Flame Lash
    [23808] =  { tooltip = A.Skill_Lava_Whip }, -- Off Balance (Lava Whip)
    [20806] = { tooltip = A.Skill_Molten_Whip }, -- Off Balance (Molten Whip)
    [34117] = { tooltip = A.Skill_Flame_Lash }, -- Off Balance (Flame Lash)
    [20824] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds' }, -- Power Lash (Flame Lash)
    [23105] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds', tooltip = T.Generic_HoT_1Sec_2Sec }, -- Power Lash (Flame Lash)

    -- Searing Strike / Venomous Claw /Burning Embers
    [44363] = { tooltip = T.Generic_Burn }, -- Searing Strike (Searing Strike)
    [44369] = { tooltip = T.Generic_Poison }, -- Venomous Claw (Venomous Claw)
    [44373] = { tooltip = T.Generic_Burn }, -- Burning Embers (Burning Embers)

    -- Fiery Breath / Noxious Breath / Engulfing Flames
    [31102] = { tooltip = T.Generic_Burn }, -- Fiery Breath (Fiery Breath)
    [31103] = { tooltip = T.Generic_Poison }, -- Noxious Breath (Noxious Breath)
    [48946] = { tooltip = A.Skill_Noxious_Breath }, -- Major Fracture (Noxious Breath)
    [31104] = { tooltip = T.Skill_Engulfing_Flames }, -- Engulfing Flames (Engulfing Flames)

    -- Fiery Grip / Empowering Chains / Unrelenting Grip
    [76498] = { tooltip = A.Skill_Fiery_Grip }, -- Major Expedition (Fiery Grip)
    [76506] = { tooltip = A.Skill_Empowering_Chains }, -- Major Expedition (Empowering Chains)
    [108679] = { tooltip = A.Skill_Empowering_Chains, stack = 2 }, -- Empower (Empowering Chains)
    [109206] = { tooltip = A.Skill_Empowering_Chains, stack = 1 }, -- Empower (Empowering Chains)
    [62004] = { hide = true }, -- Unrelenting Grip (Unrelenting Grip)
    [76502] = { tooltip = A.Skill_Unrelenting_Grip }, -- Major Expedition (Unrelenting Grip)
    [77105] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds' }, -- Unrelenting Grip (Unrelenting Grip)

    -- Inferno / Flames of Oblivion / Cauterize
    [75088] = { consolidateExtra = true, tooltip = A.Skill_Inferno }, -- Major Prophecy (Inferno)
    [28967] = { tooltip = T.Skill_Inferno_Active }, -- Inferno (Inferno)
    [28969] = { tooltip = T.Skill_Inferno_Base }, -- Inferno (Inferno)
    [76420] = { consolidate = true, tooltip = A.Skill_Flames_of_Oblivion }, -- Major Prophecy (Flames of Oblivion)
    [76426] = { consolidate = true, tooltip = A.Skill_Flames_of_Oblivion }, -- Major Savagery (Flames of Oblivion)
    [32853] = { tooltip = T.Skill_Inferno_Active }, -- Inferno (Inferno)
    [61945] = { tooltip = T.Skill_Flames_of_Oblivion_Base }, -- Inferno (Inferno)
    [76433] = { consolidateExtra = true, tooltip = A.Skill_Cauterize }, -- Major Prophecy (Cauterize)
    [32881] = { tooltip = T.Skill_Cauterize_Active }, -- Inferno (Inferno)
    [76429] = { tooltip = T.Skill_Cauterize_Base }, -- Inferno (Inferno)

    -- Dragonknight Standard
    [98438] = { name = A.Skill_Shackle }, -- Shackle Damage (Dragonknight Standard - Shackle Synergy)
    [98447] = { name = A.Skill_Shackle }, -- Shackle Snare (Dragonknight Standard - Shackle Synergy)
    [108805] = { hide = true }, -- Synergy Damage Bonus (Dragonknight Standard - Shackle Synergy)
    [29230] = { duration = 0 }, -- Major Defile (Dragonknight Standard)

    -- Shifting Standard
    [70735] = { hide = true }, -- Shifting Standard (Shifting Standard - Rank 1)
    [32961] = { duration = 0 }, -- Major Defile (Shifting Standard - Rank 1)
    [32965] = { duration = 0, name = A.Skill_Major_Defile }, -- Major Defile (Shifting Standard - Rank 1)

    -- Standard of Might
    [32949] = { duration = 0 }, -- Major Defile (Standard of Might - Rank 1)

    -- Spiked Armor
    [61815] = { consolidate = true }, -- Major Resolve (Spiked Armor - Rank 1)
    [61816] = { consolidate = true }, -- Major Ward (Spiked Armor - Rank 1)

    -- Hardened Armor
    [61827] = { consolidate = true }, -- Major Resolve (Hardened Armor - Rank 1)
    [61828] = { consolidate = true }, -- Major Ward (Hardened Armor - Rank 1)

    -- Volatile Armor
    [61836] = { consolidate = true }, -- Major Resolve (Volatile Armor - Rank 1)
    [61837] = { consolidate = true }, -- Major Ward (Volatile Armor - Rank 1)

    -- Dark Talons (Ignite Synergy)
    [108807] = { hide = true }, -- Synergy Damage Bonus (Dark Talons - Ignite Synergy)

    -- Burning Talons
    [20253] = { hideReduce = true }, -- Burning Talons (Burning Talons)

    -- Dragon Blood
    [29011] = { consolidateExtra = true }, -- Major Fortitude (Dragon Blood)

    -- Green Dragon Blood
    [32748] = { consolidate = true }, -- Major Endurance (Green Dragon Blood)
    [61884] = { consolidate = true }, -- Major Fortitude (Green Dragon Blood)
    [91670] = { consolidate = true }, -- Minor Vitality (Green Dragon Blood)

    -- Coagulating Blood
    [61891] = { hide = true }, -- Coagulating Blood Bonus Heal (Coagulating Blood)
    [91674] = { consolidateExtra = true }, -- Major Fortitude (Coagulating Blood)

    -- Inhale
    [31859] = { icon = 'esoui/art/icons/ability_dragonknight_012.dds', name = A.Skill_Inhale }, -- Inhale Heal (Inhale)

    -- Deep Breath
    [32795] = { icon = 'esoui/art/icons/ability_dragonknight_012_a.dds' }, -- Deep Breath (Deep Breath)
    [32797] = { icon = '' }, -- Deep Breath (Deep Breath) -- Hide for Interrupt notification on Combat Text

    -- Draw Essence
    [32786] = { icon = 'esoui/art/icons/ability_dragonknight_012_b.dds' }, -- Draw Essence (Draw Essence)
    [32789] = { hide = true, icon = 'esoui/art/icons/ability_dragonknight_012_b.dds' }, -- Draw Essence (Draw Essence)

    -- Dragon Leap
    [29016] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Dragon Leap - Rank 1)

    -- Obsidian Shard
    [68763] = { icon = 'esoui/art/icons/ability_dragonknight_013_b.dds' }, -- Obsidian Shard (Obsidian Shard - Rank 1)
    [31818] = { consolidate = true }, -- Minor Resolve (Stone Giant)
    [108801] = { consolidate = true }, -- Minor Ward (Stone Giant)

    -- Molten Weapons
    [92507] = { consolidateExtra = true }, -- Major Sorcery (Molten Weapons)

    -- Igneous Weapons
    [76518] = { consolidate = true }, -- Major Brutality (Igneous Weapons)
    [92503] = { consolidate = true }, -- Major Sorcery (Igneous Weapons)

    -- Shattering Rocks
    [108813] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, name = A.Skill_Shattering_Rocks }, -- Heal Trigger Shattering Rocks (Shattering Rocks - Rank 1)
    [108811] = { icon = 'esoui/art/icons/ability_dragonknight_014b.dds', name = A.Skill_Shattering_Rocks }, -- Shattering Rocks Heal (Shattering Rocks - Rank 1)

    -- Ash Cloud
    [29126] = { duration = 0 }, -- Ash Cloud (Ash Cloud)

    -- Cinder Storm
    [20780] = { duration = 0 }, -- Cinder Storm (Cinder Storm)

    -- Eruption
    [32712] = { duration = 0 }, -- Eruption (Eruption)

    -- Magma Shell
    [76483] = { refreshOnly = true }, -- Magma Shell (Magma Shell - Rank 1)

    ----------------------------------------------------------------
    -- NIGHTBLADE PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    -- Assassination
    [36616] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_master_assassin.dds' },
    [45038] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_master_assassin.dds' },
    [36630] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [101435] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [36633] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [45048] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    [101436] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    [45050] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    [36636] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_pressure_points.dds' },
    [45053] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_pressure_points.dds' },
    [36641] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_hemorrhage.dds' },
    [45060] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_hemorrhage.dds' },

    -- Shadow
    [36549] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_refreshing_shadows.dds' },
    [45103] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_refreshing_shadows.dds' },
    [18866] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_shadow_barrier.dds' },
    [45071] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_shadow_barrier.dds' },
    [36532] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_vigor.dds' },
    [45084] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_vigor.dds' },
    [36552] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_veil.dds' },
    [45115] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_veil.dds' },

    -- Siphoning
    [36560] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_catalyst.dds' }, -- Catalyst (Catalyst - Rank 1)
    [63705] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds' }, -- Amphibious Regen (Catalyst - Rank 1)
    [45135] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_catalyst.dds' }, -- Catalyst (Catalyst - Rank 2)
    [63707] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds' }, -- Amphibious Regen (Catalyst - Rank 2)
    [36595] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_magicka_flood.dds' },
    [45150] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_magicka_flood.dds' },
    [36603] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_soul_siphoner.dds' },
    [45155] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_soul_siphoner.dds' },
    [36587] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 1)
    [36589] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 1)
    [45145] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 2)
    [45146] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 2)

    ----------------------------------------------------------------
    -- NIGHTBLADE ACTIVES ------------------------------------------
    ----------------------------------------------------------------

    [61787] = { icon = 'esoui/art/icons/ability_nightblade_017_a.dds' }, -- Killer's Blade (Killer's Blade)
    [34851] = { hide = true }, -- Impale (Impale)
    [35334] = { icon = 'esoui/art/icons/ability_nightblade_008_a.dds' }, -- Lotus Fan (Lotus Fan)
    [90587] = { consolidateExtra = true }, -- Major Evasion (Blur)
    [90593] = { consolidate = true }, -- Major Evasion (Mirage)
    [61817] = { consolidate = true }, -- Minor Resolve (Mirage)
    [68512] = { consolidate = true }, -- Minor Ward (Mirage)
    [90620] = { consolidateExtra = true }, -- Major Evasion
    [33363] = { consolidate = true }, -- Major Breach (Mark Target)
    [63909] = { consolidate = true }, -- Major Fracture (Mark Target)
    [33373] = { hide = true, icon = 'esoui/art/icons/ability_nightblade_014.dds' }, -- Mark Target (Mark Target)
    [36980] = { consolidate = true }, -- Major Breach (Piercing Mark)
    [63915] = { consolidate = true }, -- Major Fracture (Piercing Mark)
    [36983] = { hide = true, icon = 'esoui/art/icons/ability_nightblade_014_b.dds', name = A.Skill_Piercing_Mark }, -- Mark Target (Piercing Mark)
    [36972] = { consolidate = true }, -- Major Breach (Reaper's Mark)
    [63919] = { consolidate = true }, -- Major Fracture (Reaper's Mark)
    [36975] = { hide = true, icon = 'esoui/art/icons/ability_nightblade_014_a.dds' }, -- Reaper's Mark (Reaper's Mark)
    [61907] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds' }, -- Assassin's Will (Grim Focus)
    [64047] = { consolidate = true }, -- Minor Berserk (Grim Focus)
    [61905] = { hide = true }, -- Grim Focus (Grim Focus)
    [61932] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds' }, -- Assassin's Scourge (Merciless Resolve)
    [64051] = { consolidate = true }, -- Minor Berserk (Relentless Focus)
    [62056] = { consolidate = true }, -- Minor Endurance (Relentless Focus)
    [61928] = { hide = true}, -- Relentless Focus (Relentless Focus)
    [61930] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds' }, -- Assassin's Will (Merciless Resolve)
    [62061] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', name = A.Skill_Assassins_Will }, -- Snare (Merciless Resolve)
    [64055] = { consolidate = true }, -- Minor Berserk (Merciless Resolve)
    [61920] = { hide = true }, -- Merciless Resolve (Merciless Resolve)
    [61389] = { icon = 'esoui/art/icons/ability_nightblade_007.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Death_Stroke, A.Skill_Vulnerability) }, -- Damage Taken Increased (Death Stroke)
    [61393] = { name = zo_strformat("<<1>> <<2>>", A.Skill_Incapacitating_Strike, A.Skill_Vulnerability) }, -- Damage Taken Increased (Incapacitating Strike)
    [61400] = { name = zo_strformat("<<1>> <<2>>", A.Skill_Soul_Harvest, A.Skill_Vulnerability) }, -- Damage Taken Increased (Soul Harvest)
    [36519] = { icon = 'esoui/art/icons/ability_nightblade_007_b.dds', name = A.Skill_Soul_Harvest }, -- Rapid Stroke Passive (Soul Harvest)

    -- Shadow
    [25375] = { hide = true }, -- Shadow Cloak (Shadow Cloak)
    [25380] = { hide = true }, -- Shadowy Disguise (Shadowy Disguise)
    [108913] = { consolidate = true }, -- Minor Protection (Dark Cloak)
    [33210] = { duration = 0, forcedContainer = 'short' }, -- Major Expedition (Path of Darkness)
    [36050] = { duration = 0, forcedContainer = 'short' }, -- Major Expedition (Twisting Path)
    [64005] = { duration = 0, forcedContainer = 'short' }, -- Major Expedtion (Refreshing Path)
    [64006] = { duration = 0, forcedContainer = 'short' }, -- Refreshing Path (Refreshing Path)
    [64001] = { name = A.Skill_Refreshing_Path }, -- Path of Darkness (Refreshing Path)
    [76683] = { name = A.Skill_Aspect_of_Terror }, -- Mass Hysteria (Aspect of Terror)
    [76629] = { hide = true }, -- Remove Trap (Manifestation of Terror)
    [76635] = { hide = true }, -- Remove Trap (Manifestation of Terror)
    [38208] = { hide = true }, -- Birth Manifestation of Terror (Manifestation of Terror)
    [76632] = { hide = true }, -- Manifestation of Terror (Manifestation of Terror)
    [76638] = { name = A.Skill_Manifestation_of_Terror }, -- Mass Hysteria (Manifestation of Terror)
    [65269] = { hide = true }, -- Shade Initialize (Summon Shade - All Morphs)
    [85086] = { hide = true }, -- Boss (Summon Shade - All Morphs)
    [33219] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds', name = A.Skill_Corrode }, -- Corrode (Shade) (Summon Shade - Summon Shade/Dark Shade)
    [38517] = { hide = true }, -- Summon Shade (Summon Shade)
    [35438] = { hide = true }, -- Summon Shade (Dark Shade)
    [108936] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_whirlwind.dds' }, -- Whirlwind (Dark Shade)
    [38528] = { hide = true }, -- Shadow (Shadow Image)
    [51556] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode_ranged.dds' }, -- Corrode (Shadow Image)
    [51558] = { name = A.Skill_Minor_Maim }, -- Shade Corrode (Shadow Image)
    [108808] = { hide = true}, -- Synergy Damage Bonus (Consuming Darkness - Hidden Refresh Synergy)
    [44871] = { forcedContainer = 'short' }, -- Major Protection (Consuming Darkness)
    [44862] = { forcedContainer = 'short' }, -- Major Protection (Bolstering Darkness)
    [44854] = { forcedContainer = 'short' }, -- Major Protection (Veil of Blades)
    [35469] = { hide = true }, -- Funnel Health (Funnel Health)
    [34837] = { consolidateExtra = true }, -- Minor Vitality (Swallow Soul)
    [108925] = { unbreakable = 1 }, -- Malevolent Offering (Malevolent Offering)
    [108927] = { unbreakable = 1 }, -- Shrewd Offering (Shrewd Offering)
    [108932] = { unbreakable = 1 }, -- Healthy Offering (Healthy Offering)
    [36943] = { hide = true }, -- Debilitate (Debilitate)
    [62196] = { icon = 'esoui/art/icons/ability_nightblade_006_a.dds' }, -- Debilitate (Debilitate)
    [36963] = { icon = 'esoui/art/icons/ability_nightblade_006_b.dds' }, -- Crippling Grasp (Crippling Grasp)
    [33321] = { icon = 'esoui/art/icons/ability_nightblade_003.dds' }, -- Siphoning Strikes (Siphoning Strikes)
    [33317] = { consolidateExtra = true }, -- Major Brutality (Drain Power)
    [36903] = { consolidateExtra = true }, -- Major Brutality (Power Extraction)
    [36894] = { consolidate = true }, -- Major Brutality (Sap Essence)
    [62240] = { consolidate = true }, -- Major Sorcery (Sap Essence)
    [36899] = { icon = 'esoui/art/icons/ability_nightblade_013_a.dds', name = A.Skill_Sap_Essence }, -- Sap Will (Sap Essence)
    [108814] = { hide = true }, -- Synergy Damage Bonus (Synergy - Soul Shred)
    [25171] = { icon = 'esoui/art/icons/ability_nightblade_018.dds' }, -- Soul Leech (Synergy - Soul Shred)
    [25091] = { hide = true }, -- Soul Shred (Soul Shred)
    [106133] = { icon = 'esoui/art/icons/ability_nightblade_018_b.dds' }, -- Soul Siphon (Soul Siphon)
    [35613] = { hide = true }, -- Soul Leech (Soul Siphon)
    [36606] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Soul Tether)
    [35462] = { name = A.Skill_Soul_Tether }, -- Soul Tether Leech (Soul Tether)
    [35461] = { hide = true }, -- Soul Leech (Soul Tether)

    ----------------------------------------------------------------
    -- SORCERER PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    -- Dark Magic
    [108858] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_persistence.dds', name = A.Passive_Persistence }, -- Persistance Cost Reduction (Persistence - Rank 1)
    [108862] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_persistence.dds', name = A.Passive_Persistence }, -- Persistance Cost Reduction (Persistence - Rank 2)
    [31384] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds' }, -- Blood Magic (Blood Magic - Rank 1)
    [45173] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds' }, -- Blood Magic (Blood Magic - Rank 2)

    -- Daedric Summoning
    [64860] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds', name = A.Passive_Rebate }, -- Rebate Magic (Rebate - Rank 1)
    [64861] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds', name = A.Passive_Rebate }, -- Rebate Magic (Rebate - Rank 2)
    [31415] = { hide = true }, -- Expert Summoner (Expert Summoner - Rank 1)
    [46198] = { hide = true }, -- Expert Summoner (Expert Summoner - Rank 2)

    -- Storm Calling
    [31424] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds' }, -- Implosion (Implosion - Rank 1)
    [82803] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds' }, -- Implosion (Implosion - Rank 1)
    [45194] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds' }, -- Implosion (Implosion - Rank 2)
    [82806] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_implosion.dds' }, -- Implosion (Implosion - Rank 2)

    ----------------------------------------------------------------
    -- SORCERER ACTIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Dark Magic
    [46327] = { icon = 'esoui/art/icons/ability_sorcerer_thunderstomp.dds' }, -- Crystal Fragments Proc (Crystal Fragments)
    [108832] = { icon = 'esoui/art/icons/ability_buff_major_vitality.dds' }, -- Major Vitality (Restraining Prison)
    [100118] = { icon = 'esoui/art/icons/ability_sorcerer_dark_haze.dds', name = A.Skill_Rune_Cage }, -- Petrify (Rune Cage)
    [24585] = { icon = 'esoui/art/icons/ability_sorcerer_dark_exchange.dds' }, -- Dark Exchange (Dark EXchange)
    [24587] = { icon = 'esoui/art/icons/ability_sorcerer_dark_exchange.dds', name = A.Skill_Dark_Exchange }, -- Dark Exchange Heal (Dark EXchange)
    [24596] = { icon = 'esoui/art/icons/ability_sorcerer_dark_deal.dds', name = A.Skill_Dark_Deal }, -- Dark Exchange (Dark Deal)
    [24597] = { icon = 'esoui/art/icons/ability_sorcerer_dark_deal.dds', name = A.Skill_Dark_Deal }, -- Dark Exchange Heal (Dark Deal)
    [24591] = { icon = 'esoui/art/icons/ability_sorcerer_dark_conversion.dds', name = A.Skill_Dark_Conversion }, -- Dark Exchange (Dark Conversion)
    [24592] = { icon = 'esoui/art/icons/ability_sorcerer_dark_conversion.dds', name = A.Skill_Dark_Conversion }, -- Dark Exchange Heal (Dark Conversion)
    [29824] = { duration = 0 }, -- Negate Magic (Negate Magic)
    [47147] = { duration = 0, hideReduce = true }, -- Negate Magic (Negate Magic)
    [47160] = { duration = 0 }, -- Suppression Field (Suppression Field)
    [47159] = { duration = 0, hideReduce = true }, -- Suppression Field (Suppression Field)
    [47168] = { duration = 0 }, -- Absorption Field (Absorption Field)
    [47167] = { duration = 0, hideReduce = true }, -- Absorption Field (Absorption Field)
    [80405] = { icon = 'esoui/art/icons/ability_sorcerer_rushing_winds.dds' }, -- Absorption Field (Absorption Field)

    -- Daedric Summoning
    [27287] = { hide = true }, -- Birth Unstable Familiar (Summon Unstable Familiar - All Morphs)
    [43963] = { hide = true }, -- Pet Bonus Threat (Summon Unstable Familiar - All Morphs)
    [27850] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_familiar_melee.dds' }, -- Familiar Melee (Summon Unstable Familiar + Summon Volatile Familiar)
    [108842] = { name = A.Skill_Familiar_Damage_Pulse }, -- Volatile Familiar Damage Pulsi (Summon Unstable Familiar)
    [108843] = { name = A.Skill_Familiar_Damage_Pulse }, -- Volatile Familiar (Summon Unstable Familiar)
    [29528] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_claw.dds', name = A.Skill_Headbutt }, -- Claw (Summon Unstable Clannfear)
    [29529] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_tail_spike.dds' }, -- Tail Spike (Summon Unstable Clannfear)
    [77187] = { name = A.Skill_Familiar_Damage_Pulse }, -- Volatile Familiar Damage Pulsi (Summon Volatile Familiar)
    [88933] = { name = A.Skill_Familiar_Damage_Pulse }, -- Volatile Familiar (Summon Volatile Familiar)
    [24617] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_zap.dds' }, -- Zap (Summon Winged Twilight - All Morphs)
    [28027] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_kick.dds' }, -- Kick (Summon Winged Twilight - All Morphs)
    [24739] = { hide = true }, -- Summon Winged Twilight (Summon Winged Twilight)
    [108847] = { name = A.Skill_Winged_Twilight_Restore }, -- Summon Twilight Matriarch (Summon Winged Twilight)
    [108846] = { name = A.Skill_Winged_Twilight_Restore }, -- Summon Twilight Matriarch (Summon Winged Twilight)
    [24742] = { hide = true }, -- Twilight Matriarch (Summon Twilight Matriarch)
    [77407] = { name = A.Skill_Twilight_Matriarch_Restore }, -- Summon Twilight Matriarch (Summon Twilight Matriarch)
    [77371] = { name = A.Skill_Twilight_Matriarch_Restore }, -- Summon Twilight Matriarch (Summon Twilight Matriarch)
    [24741] = { hide = true }, -- Twilight Tormentor (Summon Twilight Tormentor)
    [77354] = { name = A.Skill_Tormentor_Damage_Boost }, -- Summon Twilight Tormentor (Summon Twilight Tormentor)
    [88937] = { name = A.Skill_Tormentor_Damage_Boost }, -- Twilight Tormentor (Summon Twilight Tormentor)
    [23428] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_atronach_zap.dds' }, -- Atronach Zap (Summon Storm Atronach - All Morphs)
    [26098] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_atronach_zap.dds', name = A.Skill_Atronach_Zap, hideReduce = true }, -- Zap Snare (Summon Storm Atronach - All Morphs)
    [23659] = { icon = 'esoui/art/icons/ability_sorcerer_storm_atronach.dds' }, -- Summon Storm Atronach (Summon Storm Atronach)
    [80463] = { name = A.Skill_Greater_Storm_Atronach }, -- Summon Storm Atronach (Greater Storm Atronach)
    [23664] = { icon = 'esoui/art/icons/ability_sorcerer_greater_storm_atronach.dds' }, -- Greater Storm Atronach (Greater Storm Atronach)
    [80468] = { name = A.Skill_Summon_Charged_Atronach }, -- Summon Storm Atronach (Summon Charged Atronach)
    [23667] = { icon = 'esoui/art/icons/ability_sorcerer_endless_atronachs.dds' }, -- Summon Charged Atronach (Summon Charged Atronach)
    [29806] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [43764] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [43767] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [43765] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [43766] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [29809] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_lightning_strike.dds' }, -- Lightning Strike (Summon Charged Atronach)

    -- Storm Calling
    [18719] = { name = A.Skill_Mages_Fury }, -- Mages' Fury Explosion (Mages' Fury)
    [44483] = { name = A.Skill_Mages_Fury }, -- Mages' Fury Explosion (Mages' Fury)
    [19128] = { name = A.Skill_Mages_Wrath }, -- Mages' Wrath Explosion (Mages' Wrath)
    [44487] = { name = A.Skill_Mages_Wrath }, -- Mages' Wrath Explosion (Mages' Wrath)
    [24925] = { hide = true }, -- Endless fury dummy (Endless Fury)
    [24923] = { icon = 'esoui/art/icons/ability_sorcerer_endless_fury.dds', name = A.Skill_Endless_Fury }, -- Endless Fury Regeneration (Endless Fury)
    [19120] = { name = A.Skill_Endless_Fury }, -- Endless Fury Explosion (Endless Fury)
    [44491] = { name = A.Skill_Endless_Fury }, -- Endless Fury Explosion (Endless Fury)
    [62159] = { consolidate = true }, -- Major Resolve (Lightning Form)
    [62160] = { consolidate = true }, -- Major Ward (Lightning Form)
    [62167] = { consolidate = true }, -- Major Ward (Hurricane)
    [62168] = { consolidate = true }, -- Major Resolve (Hurricane)
    [82797] = { consolidate = true }, -- Minor Expedition (Hurricane)
    [62175] = { consolidate = true }, -- Major Resolve (Boundless Storm)
    [62176] = { consolidate = true }, -- Major Ward (Boundless Storm)
    [108607] = {hide = true }, -- Synergy Damage Bonus (Lightning Splash - Conduit Synergy)
    [23673] = { consolidate = true }, -- Major Brutality (Surge)
    [64492] = { icon = 'esoui/art/icons/ability_sorcerer_surge.dds' }, -- Surge (Surge)
    [96453] = { icon = 'esoui/art/icons/ability_sorcerer_surge.dds' }, -- Surge (Surge)
    [62062] = { consolidate = true }, -- Major Sorcery (Power Surge)
    [62060] = { consolidate = true }, -- Major Brutality (Power Surge)
    [64500] = { icon = 'esoui/art/icons/ability_sorcerer_power_surge.dds' }, -- Power Surge (Power Surge)
    [96457] = { icon = 'esoui/art/icons/ability_sorcerer_power_surge.dds' }, -- Power Surge (Power Surge)
    [62147] = { consolidate = true }, -- Major Brutality (Critical Surge)
    [23682] = { icon = 'esoui/art/icons/ability_sorcerer_critical_surge.dds', name = A.Skill_Critical_Surge }, -- Surge Heal (Critical Surge)
    [96461] = { icon = 'esoui/art/icons/ability_sorcerer_critical_surge.dds', name = A.Skill_Critical_Surge }, -- Surge Heal (Critical Surge)
    [51392] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Bolt Escape Fatigue
    [23283] = { hide = true }, -- Summoned Ball of Lightning (Ball of Lightning)
    [23284] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_intercept.dds', duration = 0, forcedContainer = 'short' }, -- Intercept (Ball of Lightning)
    [23279] = { hide = true }, -- Ball of Lightning (Ball of Lightning)
    [24810] = { icon = 'esoui/art/icons/ability_sorcerer_overload.dds', name = A.Skill_Overload_Heavy_Attack, hide = true }, -- Power Overload Heavy Attack (Power Overload)
    [24811] = { icon = 'esoui/art/icons/ability_sorcerer_overload.dds', name = A.Skill_Overload_Heavy_Attack }, -- Power Overload Heavy Attack (Power Overload)
    [29740] = { icon = 'esoui/art/icons/ability_sorcerer_energy_overload.dds' }, -- Energy Overload

    ----------------------------------------------------------------
    -- TEMPLAR PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Aedric Spear
    [31720] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 1)
    [80153] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 1)
    [44731] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 2)
    [80170] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 2)
    [31565] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_balanced_warrior.dds' }, -- Balanced Warrior
    [44732] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_balanced_warrior.dds' }, -- Balanced Warrior

    -- Dawn's Wrath
    [31746] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds' }, -- Prism (Prism - Rank 1)
    [45217] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds' }, -- Prism (Prism - Rank 2)
    [31721] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_restoring_spirit.dds' }, -- Restoring Spirt
    [45212] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_restoring_spirit.dds' }, -- Restoring Spirt

    -- Restoring Light
    [31757] = { icon = 'esoui/art/icons/ability_templar_032.dds' }, -- Sacred Ground
    [45207] = { icon = 'esoui/art/icons/ability_templar_032.dds' }, -- Sacred Ground
    [31759] = { duration = 0, forcedContainer = 'short' }, -- Minor Mending (Sacred Ground - Rank 1 & 2)
    [77082] = { duration = 0, forcedContainer = 'short' }, -- Minor Mending (Sacred Ground - Rank 1 & 2)
    [80195] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [80230] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [80261] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [31760] = { icon = 'esoui/art/icons/ability_templar_014.dds' }, -- Light Weaver
    [45208] = { icon = 'esoui/art/icons/ability_templar_014.dds' }, -- Light Weaver
    [52703] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_light_weaver.dds', name = A.Passive_Light_Weaver }, -- Light Weaver Ultimate (Light Weaver - Rank 1 & 2)

    ----------------------------------------------------------------
    -- TEMPLAR ACTIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- Aedric Spear
    [55183] = { icon = 'esoui/art/icons/ability_templar_reckless_attacks.dds', name = A.Skill_Puncturing_Sweep }, -- Puncturing Sweep Heal (Puncturing Sweep - Rank 1)
    [37414] = { name = A.Skill_Aurora_Javelin }, -- Piercing Javelin
    [26508] = { icon = '' }, -- Charge (Focused Charge - Rank 1) -- Hide for Interrupt notification on Combat Text
    [49204] = { icon = 'esoui/art/icons/ability_templar_focused_charge.dds' }, -- Focused Charge (Focused Charge - Rank 1)
    [49205] = { icon = 'esoui/art/icons/ability_templar_focused_charge.dds' }, -- Focused Charge (Focused Charge - Rank 1)
    [26522] = { hide = true, icon = '' }, -- Charge (Explosive Charge - Rank 1)
    [49213] = { icon = 'esoui/art/icons/ability_templar_double_tipped_charge.dds' }, -- Explosive Charge (Explosive Charge - Rank 1)
    [26518] = { icon = '' }, -- Charge (Toppling Charge - Rank 1)
    [44422] = { name = A.Skill_Off_Balance }, -- Toppling Charge (Toppling Charge - Rank 1)
    [108924] = { hide = true }, -- Synergy Damage Bonus (Spear Shards - Blessed Shards Synergy)
    [95931] = { icon = 'esoui/art/icons/ability_templar_sun_strike.dds' }, -- Spear Shards (Spear Shards - Rank 1)
    [108821] = { hide = true }, -- Synergy Damage Bonus (Luminous Shards - Holy Shards Synergy)
    [95955] = { icon = 'esoui/art/icons/ability_templar_light_strike.dds' }, -- Luminous Shards (Luminous Shards - Rank 1)
    [26724] = { hide = true }, -- Sun Shield Hit Bonus (Sun Shield - Rank 1)
    [26732] = { hide = true }, -- Sun Shield Hit Bonus (Radiant Ward - Rank 1)
    [49090] = { hide = true }, -- Sun Shield Hit Bonus (Blazing Shield - Rank 1)
    [22181] = { hide = true }, -- Blazing Shield (Blazing Shield - Rank 1)
    [22147] = { hide = true }, -- Empowering Sweep (Empowering Sweep - Rank 1)
    [62599] = { name = A.Skill_Empowering_Sweep }, -- Radial Sweep (Empowering Sweep - Rank 1)
    [62598] = { name = A.Skill_Empowering_Sweep }, -- Radial Sweep (Empowering Sweep - Rank 1)
    [62607] = { icon = 'esoui/art/icons/ability_templar_crescent_sweep.dds', name = A.Skill_Crescent_Sweep }, -- Radial Sweep (Crescent Sweep - Rank 1)
    [62606] = { icon = 'esoui/art/icons/ability_templar_crescent_sweep.dds', name = A.Skill_Crescent_Sweep }, -- Radial Sweep (Crescent Sweep - Rank 1)

    -- Dawn's Wrath
    [21727] = { icon = 'esoui/art/icons/ability_templar_sun_fire.dds' }, -- Sun Fire (Sun Fire - Rank 1)
    [21730] = { icon = 'esoui/art/icons/ability_templar_vampire_bane.dds' }, -- Vampire's Bane (Vampire's Bane - Rank 1)
    [21733] = { icon = 'esoui/art/icons/ability_templar_reflective_light.dds' }, -- Reflective Light (Reflective Light - Rank 1)
    [68581] = { name = A.Skill_Purifying_Light, icon = 'esoui/art/icons/ability_templar_purifying_light.dds', unbreakable = 1, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Purifying Light Tick (Purifying Light - Rank 1)
    [21908] = { icon = 'esoui/art/icons/ability_templar_purifying_light.dds' }, -- Purifying Light (Purifying Light - Rank 1)
    [64144] = { consolidate = true }, -- Minor Fracture (Power of the Light)
    [68588] = { consolidate = true }, -- Minor Breach (Power of the Light)
    [63083] = { icon = 'esoui/art/icons/ability_templar_total_dark.dds' }, -- Total Dark (Total Dark - Rank 1)
    [68729] = { icon = 'esoui/art/icons/ability_templar_total_dark.dds' }, -- Total Dark (Total Dark - Rank 1)
    [100211] = { icon = 'esoui/art/icons/ability_templar_unstable_core.dds', name = A.Skill_Unstable_Core }, -- Eclipse Trigger (Unstable Core - Rank 1)
    [100210] = { icon = 'esoui/art/icons/ability_templar_unstable_core.dds', name = A.Skill_Unstable_Core }, -- Eclipse (Unstable Core - Rank 1)
    [69118] = { icon = 'esoui/art/icons/ability_templar_under_exposure.dds', name = A.Skill_Radiant_Glory }, -- Radiant Glory Heal (Radiant Glory - Rank 1)
    [63956] = { icon = 'esoui/art/icons/ability_templar_under_exposure.dds' }, -- Radiant Glory (Radiant Glory - Rank 1)
    [63961] = { icon = 'esoui/art/icons/ability_templar_stendarr_aura.dds'}, -- Radiant Destruction (Radiant Oppression - Rank 1)
    [108822] = { hide = true }, -- Synergy Damage Bonus (Nova - Supernova Synergy)
    [21754] = { name = A.Skill_Major_Maim, duration = 0 }, -- Nova (Nova - Rank 1)
    [108823] = { hide = true }, -- Synergy Damage Bonus (Solar Prison - Gravity Crush Synergy)
    [21757] = { name = A.Skill_Major_Maim, duration = 0 }, -- Solar Prison (Solar Prison - Rank 1)
    [21760] = { name = A.Skill_Major_Maim, duration = 0 }, -- Solar Disturbance (Solar Disturbance - Rank 1)
    [24307] = { icon = 'esoui/art/icons/ability_templar_solar_disturbance.dds', name = A.Skill_Solar_Disturbance }, -- Solar Disturbance Snare (Solar Disturbance - Rank 1)

    -- Restoring Light
    [44391] = { icon = 'esoui/art/icons/ability_templar_breath_of_life.dds' }, -- Breath of Life (Breath of Life)
    [22307] = { icon = 'esoui/art/icons/ability_templar_healing_ritual.dds' }, -- Healing Ritual (Healing Ritual)
    [22331] = { icon = 'esoui/art/icons/ability_templar_ritual_of_rebirth.dds' }, -- Ritual of Rebirth (Ritual of Rebirth)
    [88456] = { icon = 'esoui/art/icons/ability_templar_ritual_of_rebirth.dds' }, -- Ritual of Rebirth (Ritual of Rebirth)
    [108935] = { icon = 'esoui/art/icons/ability_buff_minor_expedition.dds' }, -- Minor Expedition (Hasty Prayer)
    [26213] = { consolidate = true }, -- Minor Fortitude (Restoring Aura - All Morphs)
    [26216] = { consolidate = true }, -- Minor Intellect (Restoring Aura - All Morphs)
    [26215] = { consolidate = true }, -- Minor Endurance (Restoring Aura - All Morphs)
    [26220] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Restoring Aura)
    [88472] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Restoring Aura)
    [26809] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Radiant Aura)
    [88486] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Radiant Aura)
    [34366] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Repentance (Repentance - Rank 1)
    [26823] = { icon = 'esoui/art/icons/ability_templar_persistant_sigil.dds', name = A.Skill_Repentance }, -- Repentance Magicka Restore (Repentance - Rank 1)
    [26824] = { icon = 'esoui/art/icons/ability_templar_persistant_sigil.dds', name = A.Skill_Repentance }, -- Repentance Heal (Repentance - Rank 1)
    [108824] = { hide = true }, -- Synergy Damage Bonus (Cleansing Ritual - Purify Synergy)
    [44013] = { icon = 'esoui/art/icons/ability_templar_cleansing_ritual.dds' }, -- Purify (Cleansing Ritual - Purify Synergy)
    [26286] = { name = A.Skill_Cleansing_Ritual }, -- Healing Ritual (Cleansing Ritual - Rank 1)
    [26298] = { icon = 'esoui/art/icons/ability_templar_purifying_ritual.dds' }, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
    [80172] = { icon = 'esoui/art/icons/ability_templar_purifying_ritual.dds' }, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
    [26303] = { icon = 'esoui/art/icons/ability_templar_extended_ritual.dds' }, -- Extended Ritual (Extended Ritual - Rank 1)
    [22236] = { consolidate = true }, -- Major Resolve (Rune Focus - Rank 1)
    [44820] = { consolidate = true }, -- Major Ward (Rune Focus - Rank 1)
    [44828] = { consolidate = true }, -- Major Resolve (Channeled Focus - Rank 1)
    [44827] = { consolidate = true }, -- Major Ward (Channeled Focus - Rank 1)
    [37009] = { icon = 'esoui/art/icons/ability_templar_channeled_focus.dds' },  -- Channeled Focus (Channeled Focus - Rank 1)
    [44836] = { consolidate = true }, -- Major Resolve (Restoring Focus - Rank 1)
    [44835] = { consolidate = true }, -- Major Ward (Restoring Focus - Rank 1)
    [37027] = { consolidate = true }, -- Minor Vitality (Restoring Focus - Rank 1)
    [77056] = { consolidate = true }, -- Minor Protection (Restoring Focus - Rank 1)
    [22225] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds' }, -- Rite of Passage (Rite of Passage - Rank 1)
    [22231] = { icon = 'esoui/art/icons/ability_templar_remembrance.dds' }, -- Remembrance (Remembrance - Rank 1)
    [22228] = { icon = 'esoui/art/icons/ability_templar_practiced_incantation.dds' }, -- Practiced Incantation (Practiced Incantation - Rank 1)

    ----------------------------------------------------------------
    -- WARDEN PASSIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- Animal Companions
    [86064] = { name = A.Passive_Bond_with_Nature }, -- Bond With Nature (Bond With Nature - Rank 1)
    [88986] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_bond_with_nature.dds', name = A.Passive_Bond_with_Nature }, -- Bond With Nature (Bond With Nature - Rank 1)
    [86065] = { name = A.Passive_Bond_with_Nature }, -- Bond With Nature (Bond With Nature - Rank 2)
    [88988] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_bond_with_nature.dds', name = A.Passive_Bond_with_Nature }, -- Bond With Nature (Bond With Nature - Rank 2)
    [88512] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_savage_beast.dds', name = A.Passive_Savage_Beast }, -- Savage Beast Ultimate (Savage Beast - Rank 1)
    [88513] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_savage_beast.dds', name = A.Passive_Savage_Beast }, -- Transfer (Savage Beast - Rank 2)

    -- Green Balance
    [88483] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds', name = A.Passive_Natures_Gift }, -- Nature's Give (Nature's Gift - Rank 1)
    [93054] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds' }, -- Nature's Gift (Nature's Gift - Rank 1)
    [93072] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds', name = A.Passive_Natures_Gift }, -- Nature's Give (Nature's Gift - Rank 2)
    [93073] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds' }, -- Nature's Gift (Nature's Gift - Rank 2)
    [88492] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds' }, -- Minor Toughness (Maturation - Rank 1)
    [88509] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds' }, -- Minor Toughness (Maturation - Rank 2)

    ----------------------------------------------------------------
    -- WARDEN ACTIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- Animal Companions
    [94424] = { icon = 'esoui/art/icons/ability_warden_015_a.dds' }, -- Deep Fissure (Deep Fissure)
    [91416] = { forcedContainer = 'short' }, -- Fetcher Infection Bonus Damage (Fetcher Infection)
    [87929] = { consolidateExtra = true }, -- Major Sorcery (Betty Netch)
    [87876] = { icon = 'esoui/art/icons/ability_warden_017_a.dds' }, -- Betty Netch (Betty Netch)
    [89107] = { consolidateExtra = true }, -- Major Sorcery (Blue Betty)
    [89110] = { consolidate = true }, -- Major Brutality (Bull Netch)
    [95125] = { consolidate = true }, -- Major Sorcery (Bull Netch)
    [91475] = { icon = 'esoui/art/icons/ability_warden_017_b.dds', name = A.Skill_Bull_Netch }, -- Bull Netch (Bull Netch)
    [86267] = { consolidate = true }, -- Major Expedition (Falcon's Swiftness)
    [86268] = { consolidate = true }, -- Major Endurance (Falcon's Swiftness)
    [89076] = { consolidate = true }, -- Major Expedition (Deceptive Predator)
    [89077] = { consolidate = true }, -- Major Endurance (Deceptive Predator)
    [87861] = { consolidate = true }, -- Minor Evasion (Deceptive Predator)
    [89078] = { consolidate = true }, -- Major Expedition (Bird of Prey)
    [89079] = { consolidate = true }, -- Major Endurance (Bird of Prey)
    [87864] = { consolidate = true }, -- Minor Berserk (Bird of Prey)
    [101438] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity }, -- Bear Immunity (Feral Guardian - All Morphs)
    [89135] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds', name = A.Skill_Bite }, -- Swipe (Feral Guardian)
    [89128] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Feral Guardian)
    [89129] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Feral Guardian)
    [90284] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Guardian's Wrath (Feral Guardian)
    [93144] = { hide = true }, -- Guardian's Wrath Trigger (Feral Guardian)
    [109982] = { hide = true }, -- Eternal Guardian (Eternal Guardian)
    [105906] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds', name = A.Skill_Bite }, -- Swipe (Eternal Guardian)
    [105907] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Eternal Guardian)
    [105908] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Eternal Guardian)
    [94625] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Guardian's Wrath (Eternal Guardian)
    [94626] = { hide = true }, -- Guardian's Wrath Trigger (Eternal Guardian)
    [109983] = { hide = true }, -- Eternal Guardian Revive (Eternal Guardian)
    [110384] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_eternal_guardian_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Eternal_Guardian, A.Set_Cooldown) }, -- Eternal Guardian (Eternal Guardian)
    [89219] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds', name = A.Skill_Bite }, -- Swipe (Wild Guardian)
    [89220] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Wild Guardian)
    [92666] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Wild Guardian)
    [92163] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Guardian's Savagery (Wild Guardian)
    [93233] = { hide = true }, -- Guardian's Savagery Trigger (Wild Guardian)

    -- Green Balance
    [86300] = { consolidate = true }, -- Minor Intellect (Enchanted Growth)
    [87019] = { consolidate = true }, -- Minor Endurance (Enchanted Growth)
    [108826] = { hide = true }, -- Synergy Damage Bonus (Healing Seed - Harvest Synergy)
    [85582] = { name = A.Skill_Healing_Seed }, -- Healing Seed Heal (Healing Seed)
    [85841] = { name = A.Skill_Budding_Seeds }, -- Budding Seeds (Budding Seeds)
    [85925] = { name = A.Skill_Budding_Seeds }, -- Budding Seeds (Budding Seeds)
    [85846] = { name = A.Skill_Corrupting_Pollen }, -- Corrupting Pollen Heal (Corrupting Pollen)
    [85559] = { name = A.Skill_Living_Vines }, -- Living Vines Heal (Living Vines)
    [88721] = { name = A.Skill_Living_Trellis }, -- Living Trellis Heal (Living Trellis)
    [88723] = { icon = 'esoui/art/icons/ability_warden_010_b.dds', name = A.Skill_Living_Trellis }, -- Living Trellis Heal Burst (Living Trellis)
    [87061] = { consolidateExtra = true }, -- Major Savagery (Green Lotus)
    [86303] = { consolidateExtra = true }, -- Major Prophecy (Lotus Blossom)
    [88695] = { name = A.Skill_Lotus_Blossom }, -- Lotus Blossom Heal (Lotus Blossom)
    [94590] = { icon = 'esoui/art/icons/ability_warden_009_b.dds', name = A.Skill_Lotus_Blossom }, -- Lotus Blossom Heal (Lotus Blossom)
    [108943] = { icon = 'esoui/art/icons/ability_warden_011.dds', name = A.Skill_Natures_Grasp }, -- Nature's Grasp Ultimate Restor (Nature's Grasp)
    [108947] = { icon = 'esoui/art/icons/ability_warden_011_a.dds', name = A.Skill_Bursting_Vines }, -- Bursting Vines Ultimate Rest (Bursting Vines)
    [108945] = { icon = 'esoui/art/icons/ability_warden_011_b.dds', name = A.Skill_Natures_Embrace }, -- Nature's Embrace Ultimate Rest (Nature's Embrace)
    [85533] = { name = A.Skill_Secluded_Grove }, -- Secluded Grove Instant Heal (Secluded Grove)
    [85534] = { name = A.Skill_Secluded_Grove }, -- Secluded GroveTick Heal (Secluded Grove)
    [88748] = { name = A.Skill_Enchanted_Forest }, -- Enchanted Forest Burst (Enchanted Forest)
    [86357] = { icon = 'esoui/art/icons/ability_warden_012_a.dds', name = A.Skill_Enchanted_Forest }, -- Enchanted Forest Ultimate Rest (Enchanted Forest)
    [88750] = { name = A.Skill_Healing_Thicket }, -- Healing Thicket Instant Heal (Healing Thicket)

    -- Winter's Embrace
    [86224] = { consolidate = true }, -- Major Resolve (Frost Cloak)
    [86225] = { consolidate = true }, -- Major Ward (Frost Cloak)
    [88758] = { consolidate = true }, -- Major Resolve (Expansive Frost Cloak)
    [88759] = { consolidate = true }, -- Major Ward (Expansive Frost Cloak)
    [88761] = { consolidate = true }, -- Major Resolve (Ice Fortress)
    [88762] = { consolidate = true }, -- Major Ward (Ice Fortress)
    [87194] = { consolidate = true }, -- Minor Protection (Ice Fortress)
    [87443] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_root_frost.dds', name = A.Skill_Frozen }, -- Gripping Shards (Gripping Shards)
    [92068] = { icon = 'esoui/art/icons/ability_warden_002.dds', name = A.Skill_Crystallized_Shield }, -- Crystalized Shield (Crystallized Shield)
    [87224] = { icon = 'esoui/art/icons/ability_warden_002.dds', name = A.Skill_Crystallized_Shield }, -- Combat Restore Crystalized Shi (Crystallized Shield)
    [92168] = { icon = 'esoui/art/icons/ability_warden_002_a.dds', name = A.Skill_Crystallized_Slab }, -- Crystalized Slab (Crystallized Slab)
    [88766] = { icon = 'esoui/art/icons/ability_warden_002_a.dds', name = A.Skill_Crystallized_Slab }, -- Crystalized Slab Restore (Crystallized Slab)
    [93175] = { hide = true }, -- Crystallized Slab (Crystallized Slab)
    [92170] = { icon = 'esoui/art/icons/ability_warden_002_b.dds' }, -- Shimmering Shield (Shimmering Shield)
    [88771] = { icon = 'esoui/art/icons/ability_warden_002_b.dds', name = A.Skill_Shimmering_Shield }, -- Shimmering Shield Restore (Shimmering Shield)
    [87560] = { name = A.Skill_Frozen_Gate }, -- Frozen Gate Root (Frozen Gate)
    [92039] = { name = A.Skill_Frozen_Device }, -- Frozen Gate Root (Frozen Device)
    [92060] = { name = A.Skill_Frozen_Retreat }, -- Frozen Retreat Root (Frozen Retreat)
    [86249] = { forcedContainer = 'short' }, -- Major Protection (Sleet Storm)
    [86250] = { duration = 0 }, -- Sleet Storm (Sleet Storm)
    [88859] = { forcedContainer = 'short' }, -- Major Protection (Northern Storm)
    [88858] = { duration = 0 }, -- Northern Storm (Northern Storm)
    [88862] = { duration = 0, forcedContainer = 'short' }, -- Major Protection (Permafrost)
    [88861] = { duration = 0 }, -- Permafrost (Permafrost)
    [90943] = { icon = 'esoui/art/icons/ability_warden_006_b.dds' }, -- Permafrost (Permafrost)

    ----------------------------------------------------------------
    -- PLAYER WEAPON ATTACKS ---------------------------------------
    ----------------------------------------------------------------

    [23604] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attacklight.dds' }, -- Light Attack
    [18430] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [18431] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackheavy.dds' }, -- Heavy Attack
    [60772] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Unarmed)
    [16037] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [17162] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [17163] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack
    [60757] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (2H)
    [15435] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [15282] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [15829] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack
    [60759] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Shield)
    [16499] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [17170] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [17169] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = A.Skill_Heavy_Attack_Main_Hand }, -- Heavy Attack
    [18622] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = A.Skill_Heavy_Attack_Off_Hand }, -- Heavy Attack (Dual Wield)
    [60758] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Dual Wield)
    [16688] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds' }, -- Light Attack
    [17174] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [17173] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackheavy.dds' }, -- Heavy Attack
    [60761] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Bow)
    [16277] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attacklight.dds' }, -- Light Attack
    [18405] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [18406] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackheavy.dds' }, -- Heavy Attack
    [60762] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Frost)
    [16165] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attacklight.dds' }, -- Light Attack
    [15385] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [16321] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackheavy.dds' }, -- Heavy Attack
    [60763] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Fire)
    [18350] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attacklight.dds' }, -- Light Attack
    [18396] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Shock)
    [19277] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavypulse.dds', name = A.Skill_Heavy_Attack, hide = true }, -- Shock Pulse
    [60764] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Shock)
    [16145] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attacklight.dds' }, -- Light Attack
    [16212] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds' }, -- Heavy Attack
    [32760] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Restoration)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WEAPONS -------------------------------------
    ----------------------------------------------------------------

    -- Two Handed
    [30821] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds' }, -- Forceful (Rank 1)
    [45445] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds' }, -- Forceful (Rank 2)
    [29375] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_heavy_weapons.dds' }, -- Heavy Weapons (Rank 1)
    [29383] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = A.Passive_Heavy_Weapons }, -- Heavy Weapons Bleed (Rank 1)
    [45430] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_heavy_weapons.dds' }, -- Heavy Weapons (Rank 2)
    [45431] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = A.Passive_Heavy_Weapons }, -- Heavy Weapons Bleed (Rank 2)
    [29388] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_balanced_blade.dds' }, -- Balanced Blade (Rank 1)
    [45443] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_balanced_blade.dds' }, -- Balanced Blade (Rank 2)
    [29389] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_follow_up.dds' }, -- Follow Up (Follow Up - Rank 1)
    [60860] = { icon = 'esoui/art/icons/ability_warrior_018.dds' }, -- Bonus Damage (Follow Up - Rank 1)
    [45446] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_follow_up.dds' }, -- Follow Up (Follow Up - Rank 2)
    [60888] = { icon = 'esoui/art/icons/ability_warrior_018.dds', name = A.Passive_Follow_Up }, -- Bonus Damage (Follow Up - Rank 2)
    [29392] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_battle_rush.dds' }, -- Battle Rush (Battle Rush - Rank 1)
    [45450] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_battle_rush.dds' }, -- Battle Rush (Battle Rush - Rank 2)

    -- One Hand and Shield
    [29420] = { icon = 'esoui/art/icons/ability_weapon_029.dds' }, -- Fortress (Fortress - Rank 1)
    [45471] = { icon = 'esoui/art/icons/ability_weapon_029.dds' }, -- Fortress (Fortress - Rank 2)
    [29397] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_sword_and_board.dds' }, -- Sword and Board (Sword and Board - Rank 1)
    [45452] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_sword_and_board.dds' }, -- Sword and Board (Sword and Board - Rank 2)
    [29415] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_deadly_bash.dds' }, -- Deadly Bash (Deadly Bash - Rank 1)
    [45469] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_deadly_bash.dds' }, -- Deadly Bash (Deadly Bash - Rank 2)
    [29399] = { icon = 'esoui/art/icons/ability_weapon_003.dds' }, -- Deflect Bolts (Deflect Bolts - Rank 1)
    [45472] = { icon = 'esoui/art/icons/ability_weapon_003.dds' }, -- Deflect Bolts (Deflect Bolts - Rank 2)
    [29422] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_battlefield_mobility.dds' }, -- Battlefield Mobility (Battlefield Mobility - Rank 1)
    [45473] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_battlefield_mobility.dds' }, -- Battlefield Mobility (Battlefield Mobility - Rank 2)

    -- Dual Wield
    [30872] = { icon = 'esoui/art/icons/ability_weapon_020.dds' }, -- Controlled Fury (Controlled Fury - Rank 1)
    [45478] = { icon = 'esoui/art/icons/ability_weapon_020.dds' }, -- Controlled Fury (Controlled Fury - Rank 2)
    [21114] = { icon = 'esoui/art/icons/ability_weapon_012.dds' }, -- Ruffian (Ruffian - Rank 1)
    [45481] = { icon = 'esoui/art/icons/ability_weapon_012.dds' }, -- Ruffian (Ruffian - Rank 2)
    [30894] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = A.Passive_Twin_Blade_and_Blunt }, -- Twin Blade and Blunt Bleed (Rank 1)
    [45483] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = A.Passive_Twin_Blade_and_Blunt }, -- Twin Blade and Blunt Bleed (Rank 2)

    -- Bow
    [30930] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_accuracy.dds' }, -- Accuracy (Accuracy - Rank 1)
    [45492] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_accuracy.dds' }, -- Accuracy (Accuracy - Rank 2)
    [30942] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_ranger.dds' }, -- Ranger (Ranger) - Rank 1)
    [45493] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_ranger.dds' }, -- Ranger (Ranger) - Rank 2)
    [30936] = { icon = 'esoui/art/icons/ability_weapon_024.dds' }, -- Hawk Eye (Hawk Eye - Rank 1)
    [78854] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_hawk_eye.dds' }, -- Hawk Eye (Hawk Eye - Rank 1)
    [45497] = { icon = 'esoui/art/icons/ability_weapon_024.dds' }, -- Hawk Eye (Hawk Eye - Rank 2)
    [78855] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_hawk_eye.dds' }, -- Hawk Eye (Hawk Eye - Rank 2)
    [30923] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_hasty_retreat.dds' }, -- Hasty Retreat (Hasty Retreat - Rank 1)
    [45498] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_hasty_retreat.dds' }, -- Hasty Retreat (Hasty Retreat - Rank 2)

    -- Destruction Staff
    [30948] = { icon = 'LuiExtended/media/icons/abilities/passive_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 1)
    [69774] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 1)
    [45500] = { icon = 'LuiExtended/media/icons/abilities/passive_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 2)
    [69773] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 2)
    [30951] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds' }, -- Shock (Tri Focus - Rank 1)
    [45505] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds' }, -- Shock (Tri Focus - Rank 2)
    [30959] = { icon = 'esoui/art/icons/ability_weapon_007.dds' }, -- Ancient Knowledge (Ancient Knowledge - Rank 1)
    [45513] = { icon = 'esoui/art/icons/ability_weapon_007.dds' }, -- Ancient Knowledge (Ancient Knowledge - Rank 2)
    [30966] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_destruction_expert.dds' }, -- Magicka Restore (Destruction Expert - Rank 1)
    [45515] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_destruction_expert.dds', name = A.Passive_Destruction_Expert }, -- Magicka Restore (Destruction Expert - Rank 2)

    -- Restoration Staff
    [30973] = { icon = 'esoui/art/icons/ability_weapon_002.dds' }, -- Essence Drain (Essence Drain -  Rank 1)
    [30978] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds' }, -- Essence Drain (Essence Drain -  Rank 1)
    [45517] = { icon = 'esoui/art/icons/ability_weapon_002.dds' }, -- Essence Drain (Essence Drain -  Rank 2)
    [45518] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds' }, -- Essence Drain (Essence Drain -  Rank 2)
    [30971] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_absorb.dds' }, -- Absorb (Absorb - Rank 1)
    [45522] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_absorb.dds' }, -- Absorb (Absorb - Rank 2)
    [30981] = { icon = 'LuiExtended/media/icons/abilities/passive_restorationstaff_restoration_master.dds' }, -- Restoration Master
    [45524] = { icon = 'LuiExtended/media/icons/abilities/passive_restorationstaff_restoration_master.dds' }, -- Restoration Master

    -----------------------------------------
    -- TWO HANDED ACTIVES -------------------
    -----------------------------------------

    [38818] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds' }, -- Dizzying Swing (Dizzying Swing)
    [31059] = { icon = 'esoui/art/icons/ability_2handed_002.dds', name = A.Skill_Cleave }, -- Cleave Bleed (Cleave)
    [38747] = { icon = 'esoui/art/icons/ability_2handed_002_a.dds', name = A.Skill_Carve }, -- Carve Bleed (Carve)
    [38759] = { icon = 'esoui/art/icons/ability_2handed_002_b.dds', name = A.Skill_Brawler }, -- Brawler Bleed (Brawler)
    [38827] = { icon = 'esoui/art/icons/ability_2handed_004_b.dds' }, -- Reverse Slice (Reverse Slice)
    [61670] = { consolidateExtra = true }, -- Major Brutality (Momentum)
    [28299] = { icon = 'esoui/art/icons/ability_2handed_005.dds' }, -- Momentum (Momentum)
    [62387] = { consolidateExtra = true }, -- Major Brutality (Forward Momentum)
    [62385] = { icon = 'esoui/art/icons/ability_2handed_005_a.dds', name = A.Skill_Forward_Momentum }, -- Momentum (Forward Momentum)
    [62415] = { consolidateExtra = true }, -- Major Brutality (Rally)
    [38805] = { icon = 'esoui/art/icons/ability_2handed_005_b.dds' }, -- Rally (Rally)
    [83346] = { icon = 'esoui/art/icons/ability_2handed_006_a.dds' }, -- Onslaught (Onslaught)

    -----------------------------------------
    -- ONE HAND AND SHIELD ACTIVES ----------
    -----------------------------------------

    [62484] = { consolidate = true }, -- Major Fracture (Pierce Armor)
    [62485] = { consolidate = true }, -- Major Breach (Pierce Armor)
    [28305] = { name = A.Skill_Low_Slash }, -- Low Slash Snare (Low Slash)
    [38266] = { name = A.Skill_Heroic_Slash }, -- Heroic Slash Snare (Heroic Slash)
    [38398] = { icon = 'esoui/art/icons/ability_1handed_004_b.dds' }, -- Absorb Magic (Absorb Magic)
    [38407] = { name = A.Skill_Invasion }, -- Invasion (Invasion)

    -----------------------------------------
    -- DUAL WIELD ACTIVES -------------------
    -----------------------------------------

    [29293] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = A.Skill_Twin_Slashes }, -- Twin Slashes Bleed (Twin Slashes)
    [38841] = { icon = 'esoui/art/icons/ability_dualwield_001_a.dds', name = A.Skill_Rending_Slashes }, -- Rending Slashes Bleed (Rending Slashes)
    [38848] = { icon = 'esoui/art/icons/ability_dualwield_001_a.dds', name = A.Skill_Blood_Craze }, -- Blood Craze Bleed (Blood Craze)
    [62529] = { name = A.Skill_Quick_Cloak }, -- Blade Cloak (Quick Cloak)
    [62547] = { name = A.Skill_Deadly_Cloak }, -- Blade Cloak (Deadly Cloak)
    [68807] = { consolidateExtra = true }, -- Major Brutality (Hidden Blade)
    [68859] = { consolidateExtra = true }, -- Major Brutality (Shrouded Daggers)
    [68814] = { consolidateExtra = true }, -- Major Brutality (Flying Blade)

    -----------------------------------------
    -- BOW ACTIVES --------------------------
    -----------------------------------------

    [38698] = { hide = true }, -- Focused Aim (Focused Aim)
    [38688] = { consolidateExtra = true }, -- Minor Fracture (Focused Aim)
    [28888] = { icon = 'esoui/art/icons/ability_bow_004.dds' }, -- Scatter Shot (Scatter Shot)
    [38676] = { icon = 'esoui/art/icons/ability_bow_004_b.dds', name = A.Skill_Magnum_Shot }, -- Scatter Shot (Magnum Shot)
    [38675] = { icon = 'esoui/art/icons/ability_bow_004_b.dds', name = A.Skill_Magnum_Shot }, -- Scatter Shot (Magnum Shot)
    [38674] = { name = A.Skill_Magnum_Shot }, -- Scatter Shot (Magnum Shot)
    [38671] = { icon = 'esoui/art/icons/ability_bow_004_a.dds' }, -- Draining Shot (Draining Shot)
    [80764] = { name = A.Skill_Draining_Shot }, -- Draining Shot Heal (Draining Shot)
    [38706] = { icon = 'esoui/art/icons/ability_bow_005_a.dds' }, -- Bombard (Bombard)
    [38702] = { hideReduce = true }, -- Acid Spray (Acid Spray)
    [38648] = { icon = '' }, -- Poison Arrow (Venom Arrow)
    [38649] = { icon = 'esoui/art/icons/ability_bow_002_a.dds', name = A.Skill_Venom_Arrow }, -- Poison Arrow (Venom Arrow)
    [38650] = { name = A.Skill_Venom_Arrow }, -- Poison Arrow (Venom Arrow)

    -----------------------------------------
    -- DESTRUCTION STAFF ACTIVES ------------
    -----------------------------------------

    [48010] = { icon = '' }, -- Force Shock (Destruction) (Crushing Shock - Rank 1)
    [48009] = { icon = 'esoui/art/icons/ability_destructionstaff_001a.dds', name = A.Skill_Crushing_Shock }, -- Stagger (Crushing Shock - Rank 1)
    [48011] = { name = A.Skill_Crushing_Shock }, -- Uber Attack (Crushing Shock - Rank 1)
    [48016] = { icon = 'esoui/art/icons/ability_destructionstaff_001b.dds' }, -- Force Pulse (Force Pulse - Rank 1)
    [48022] = { icon = 'esoui/art/icons/ability_destructionstaff_001b.dds' }, -- Force Pulse (Force Pulse - Rank 1)
    [68719] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_root_frost.dds' }, -- Frozen (Wall of Elements - All Ranks) -- Frost
    [62928] = { duration = 0 }, -- Wall of Frost (Wall of Elements - Rank 1) -- Frost
    [39068] = { duration = 0 }, -- Unstable Wall of Frost (Unstable Wall of Elements) -- Frost
    [62948] = { duration = 0 }, -- Blockade of Frost (Elemental Blockade - Rank 1) -- Frost
    [62648] = { name = A.Skill_Flame_Touch }, -- Fire Touch (Destructive Touch - Rank 1) -- Fire
    [38172] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = A.Skill_Flame_Touch }, -- Stun After Knockback Movement (Destructive Touch - Rank 1) -- Fire
    [29075] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = A.Skill_Flame_Touch }, -- Fire Touch (destruction) (Destructive Touch - Rank 1) -- Fire
    [30450] = { icon = 'esoui/art/icons/ability_destructionstaff_005.dds', name = A.Skill_Frost_Touch }, -- Frost Touch (Destructive Touch - Rank 1) -- Frost
    [62668] = { name = A.Skill_Flame_Clench }, -- Fire Clench (Destructive Clench - Rank 1) -- Fire
    [38987] = { icon = 'esoui/art/icons/ability_destructionstaff_007_a.dds', name = A.Skill_Flame_Clench }, -- Stun After Knockback Movement (Destructive Clench - Rank 1) -- Fire
    [38986] = { icon = 'esoui/art/icons/ability_destructionstaff_007_a.dds', name = A.Skill_Flame_Clench }, -- Fire Touch (destruction) (Destructive Clench - Rank 1) -- Fire
    [68635] = { name = A.Skill_Shock_Clench }, -- Shock Touch (Destructive Clench - Rank 1) -- Shock
    [62734] = { name = A.Skill_Shock_Clench, hide = true }, -- Shock Clench Explosion (Destructive Clench - Rank 1) -- Shock
    [38990] = { icon = 'esoui/art/icons/ability_destructionstaff_005_a.dds', name = A.Skill_Frost_Clench }, -- Deep Freeze (Destructive Clench - Rank 1) -- Frost
    [38946] = { icon = 'esoui/art/icons/ability_destructionstaff_007_b.dds', name = A.Skill_Flame_Reach }, -- Stun After Knockback Movement (Destructive Reach - Rank 1) -- Fire
    [38945] = { icon = 'esoui/art/icons/ability_destructionstaff_007_b.dds', name = A.Skill_Flame_Reach }, -- Flame Reach (destruction) (Destructive Reach - Rank 1) -- Fire
    [68574] = { name = A.Skill_Shock_Reach }, -- Shock Touch (Destructive Reach - Rank 1) -- Shock
    [38971] = { icon = 'esoui/art/icons/ability_destructionstaff_005_b.dds', name = A.Skill_Frost_Reach }, -- Frost Grip (Destructive Reach - Rank 1) -- Frost
    [53881] = { consolidate = true }, -- Major Breach (Weakness to Elements)
    [62775] = { consolidate = true }, -- Major Breach (Elemental Susceptibility)
    [39100] = { consolidate = true }, -- Minor Magickasteal (Elemental Drain)
    [62787] = { consolidate = true }, -- Minor Magickasteal (Elemental Drain)
    [39099] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Elemental Drain - Rank 1)

    -----------------------------------------
    -- RESTORATION STAFF ACTIVES ------------
    -----------------------------------------

    [28386] = { icon = 'esoui/art/icons/ability_restorationstaff_004.dds' }, -- Grand Healing (Grand Healing - Rank 1)
    [40059] = { icon = 'esoui/art/icons/ability_restorationstaff_004b.dds' }, -- Illustrious Healing (Illustrious Healing - Rank 1)
    [40061] = { icon = 'esoui/art/icons/ability_restorationstaff_004a.dds' }, -- Healing Springs (Healing Springs - Rank 1)
    [40062] = { icon = 'esoui/art/icons/ability_restorationstaff_004a.dds' }, -- Healing Springs (Healing Springs - Rank 1)
    [37243] = { hide = true }, -- Blessing of Protection (Blessing of Protection - Rank 1)
    [37247] = { consolidate = true }, -- Minor Resolve (Blessing of Protection - Rank 1)
    [62619] = { consolidate = true }, -- Minor Ward (Blessing of Protection - Rank 1)
    [40103] = { hide = true, name = A.Skill_Blessing_of_Restoration }, -- Blessing of Restoration (Blessing of Restoration - Rank 1)
    [62626] = { consolidate = true }, -- Minor Resolve (Blessing of Restoration - Rank 1)
    [62627] = { consolidate = true }, -- Minor Ward (Blessing of Restoration - Rank 1)
    [40094] = { hide = true }, -- Combat Prayer (Combat Prayer - Rank 1)
    [62634] = { consolidate = true }, -- Minor Resolve (Combat Prayer - Rank 1)
    [62635] = { consolidate = true }, -- Minor Ward (Combat Prayer - Rank 1)
    [62636] = { consolidate = true }, -- Minor Berserk (Combat Prayer - Rank 1)
    [40128] = { hide = true }, -- Healing Ward (Healing Ward - Rank 1)
    [88565] = { consolidate = true }, -- Minor Lifesteal (Force Siphon)
    [33541] = { icon = 'esoui/art/icons/ability_buff_minor_lifesteal.dds' }, -- Minor Lifesteal (Force Siphon - Rank 1)
    [88575] = { consolidate = true }, -- Minor Lifesteal (Siphon Spirit)
    [88576] = { consolidate = true }, -- Minor Magickasteal (Siphon Spirit)
    [40110] = { icon = 'esoui/art/icons/ability_buff_minor_lifesteal.dds' }, -- Minor Lifesteal (Siphon Spirit - Rank 1)
    [40114] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Lifesteal (Siphon Spirit - Rank 1)
    [88606] = { consolidate = true }, -- Minor Lifesteal (Quick Siphon)
    [40117] = { icon = 'esoui/art/icons/ability_buff_minor_lifesteal.dds' }, -- Minor Lifesteal (Quick Siphon - Rank 1)

    ----------------------------------------------------------------
    -- ARMOR PASSIVES ----------------------------------------------
    ----------------------------------------------------------------

    -- Light Armor
    [29668] = { icon = 'esoui/art/icons/passive_armor_001.dds' }, -- Prodigy (Prodigy - Rank 1)
    [45561] = { icon = 'esoui/art/icons/passive_armor_001.dds' }, -- Prodigy (Prodigy - Rank 2)

    -- Heavy Armor
    [29825] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 1)
    [45531] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 2)
    [45533] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 3)
    [29769] = { icon = 'esoui/art/icons/ability_armor_013.dds' }, -- Constitution (Constitution - Rank 1)
    [58428] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 1)
    [58503] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 1)
    [45526] = { icon = 'esoui/art/icons/ability_armor_013.dds' }, -- Constitution (Constitution - Rank 2)
    [58430] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 2)
    [58431] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 2)
    [29773] = { icon = 'esoui/art/icons/passive_armor_014.dds' }, -- Revitalize (Revitalize - Rank 1)
    [45528] = { icon = 'esoui/art/icons/passive_armor_014.dds' }, -- Revitalize (Revitalize - Rank 2)

    ----------------------------------------------------------------
    -- ARMOR ACTIVES -----------------------------------------------
    ----------------------------------------------------------------

    -- LIGHT ARMOR
    [39188] = { hide = true }, -- Dampen Magic (Dampen Magic)

    -- MEDIUM ARMOR
    [63015] = { consolidateExtra = true }, -- Major Evasion (Evasion)
    [63019] = { consolidateExtra = true }, -- Major Evasion (Shuffle)
    [39196] = { noDuplicate = true }, -- Shuffle (Shuffle)
    [63030] = { consolidateExtra = true }, -- Major Evasion (Elude)

    -- HEAVY ARMOR
    [63084] = { consolidate = true }, -- Major Resolve (Immovable)
    [63085] = { consolidate = true }, -- Major Ward (Immovable)
    [63134] = { consolidate = true }, -- Major Resolve (Immovable Brute)
    [63135] = { consolidate = true }, -- Major Ward (Immovable Brute)
    [63119] = { consolidate = true }, -- Major Resolve (Unstoppable)
    [63120] = { consolidate = true }, -- Major Ward (Unstoppable)

    ----------------------------------------------------------------
    -- SOUL MAGIC PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    [39266] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 1)
    [39267] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 1)
    [39268] = { hide = true }, -- Soul Shatter (Soul Shatter - Rank 1)
    [45583] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 2)
    [45584] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 2)
    [45585] = { hide = true }, -- Soul Shatter (Soul Shatter - Rank 2)
    [39269] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_summons.dds' }, -- Soul Summons
    [45590] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_summons.dds' }, -- Soul Summons
    [43752] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_summons_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Passive_Soul_Summons, A.Set_Cooldown), tooltip = T.Skill_Soul_Summons }, -- Soul Summons
    [39263] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_lock.dds' }, -- Soul Lock
    [39264] = { hide = true }, -- Soul Trap (Soul Lock - Rank 1)
    [45580] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_lock.dds' }, -- Soul Lock
    [45582] = { hide = true }, -- Soul Trap (Soul Lock - Rank 2)

    ----------------------------------------------------------------
    -- SOUL MAGIC ACTIVES ------------------------------------------
    ----------------------------------------------------------------

    [26769] = { hide = true}, -- Soul Trap (Soul Trap)
    [40329] = { hide = true}, -- Soul Splitting Trap (Soul Splitting Trap)
    [40319] = { hide = true}, -- Consuming Trap (Consuming Trap)
    [40323] = { icon = 'esoui/art/icons/ability_otherclass_001_b.dds' }, -- Consuming Trap (Consuming Trap)
    [40321] = { icon = 'esoui/art/icons/ability_otherclass_001_b.dds' }, -- Consuming Trap (Consuming Trap)
    [40326] = { icon = 'esoui/art/icons/ability_otherclass_001_b.dds' }, -- Consuming Trap (Consuming Trap)

    ----------------------------------------------------------------
    -- VAMPIRE PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39472] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_noxiphilic_sanguivoria.dds', name = A.Passive_Noxiphilic_Sanguivoria }, -- Vampirism (Blood Ritual)
    [40360] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_noxiphilic_sanguivoria.dds', name = A.Passive_Noxiphilic_Sanguivoria }, -- Vampirism (Blood Ritual)
    [35771] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_1.dds', stack = 1 }, -- Stage 1 Vampirism (Vampire General)
    [35776] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_2.dds', stack = 2 }, -- Stage 2 Vampirism (Vampire General)
    [35783] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_3.dds', stack = 3 }, -- Stage 3 Vampirism (Vampire General)
    [35792] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_4.dds', stack = 4 }, -- Stage 4 Vampirism (Vampire General)
    [33152] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed
    [33177] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed
    [33175] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', unbreakable = 1 }, -- Feed (Vampire - Feed)
    [33182] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = A.Passive_Savage_Feeding }, -- Uber Attack (Savage Feeding - Rank 1)
    [33183] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance }, -- Off-Balance Self (Savage Feeding - Rank 1)
    [46047] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = A.Passive_Savage_Feeding }, -- Uber Attack (Savage Feeding - Rank 2)
    [46046] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance }, -- Off-Balance Self (Savage Feeding - Rank 2)
    [40349] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, duration = .95 }, -- Feed (Blood Ritual - Rank 1)
    [40351] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed (Blood Ritual - Rank 1)
    [40350] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', unbreakable = 1 }, -- Feed (Blood Ritual - Rank 1)
    [40353] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', name = A.Skill_Feed }, -- Uber Attack (Blood Ritual - Rank 1)
    [40359] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_ritual_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Passive_Blood_Ritual, A.Set_Cooldown) }, -- Fed on ally (Blood Ritual)

    ----------------------------------------------------------------
    -- VAMPIRE QUEST ---------------------------------------------
    ----------------------------------------------------------------

    [42821] = { hide = true }, -- VampInt_LamaeFirstFeed
    [44676] = { hide = true }, -- SELF SNARE
    [44222] = { hide = true }, -- VampireInitiation_Lamae
    [39728] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', name = A.Skill_Feed }, -- VampInit_TheaterFeed
    [39509] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_4.dds', name = A.Skill_Vampirism }, -- VampInit_PC Becomes a Vampire
    [39422] = { hide = true }, -- Mist Form
    [56684] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike
    [39692] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = -5.2 }, -- Feed
    [39698] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed
    [39693] = { hide = true }, -- Feed

    ----------------------------------------------------------------
    -- WEREWOLF PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    [35658] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_lycanthrophy.dds', tooltip = T.Skill_Lycanthrophy }, -- Lycanthrophy
    [31068] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_sanies_lupinus.dds', tooltip = T.Skill_Sanies_Lupinus }, -- Sanies Lupinus (from NPC Bite)
    [40521] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_sanies_lupinus.dds', tooltip = T.Skill_Sanies_Lupinus }, -- Sanies Lupinus (from Player Bite)
    [32464] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }, -- Light Attack
    [89146] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackbleed.dds', tooltip = T.Generic_Bleed }, -- Werewolf Bleed
    [32477] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Were)
    [32479] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [32480] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack Werewolf
    [32494] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Heavy Attack
    [60773] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Stamina Return
    [33208] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', hide = true }, -- Devour (Devour - Rank 1)
    [33209] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Devour - Rank 1)
    [40515] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Blood Moon)
    [40520] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', name = A.Skill_Devour, unbreakable = 1, tooltip = T.Generic_Stun }, -- Q3047 - Knockdown (Blood Moon)
    [40525] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_bloodmoon_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Passive_Bloodmoon, A.Set_Cooldown), tooltip = T.Skill_Blood_Moon }, -- Bit an Ally (Blood Moon)

    ----------------------------------------------------------------
    -- WEREWOLF ACTIVES --------------------------------------------
    ----------------------------------------------------------------

    [39124] = { consolidateExtra = true }, -- Major Brutality (Rousing Roar)
    [58406] = { name = A.Skill_Piercing_Howl }, -- Piercing Howl Stun (Piercing Howl)
    [58775] = { icon = 'esoui/art/icons/ability_werewolf_005_b.dds' }, -- Feeding Frenzy (Howl of Despair - Feeding Frenzy Synergy)
    [58743] = { name = A.Skill_Howl_of_Despair }, -- Howl of Despair Stun (Howl of Despair)
    [58744] = { hide = true }, -- Howl of Despair Synergy (Howl of Despair)
    [58800] = { name = A.Skill_Howl_of_Agony }, -- Piercing Howl Stun (Howl of Agony)
    [58856] = { name = A.Skill_Infectious_Claws }, -- Infection (Infectious Claws)
    [58865] = { name = A.Skill_Claws_of_Anguish }, -- Infection (Claws of Anguish)
    [58880] = { name = A.Skill_Claws_of_Life }, -- Infection (Claws of Life)

    [39477] = { hide = true }, -- De-Werewolf (Werewolf Transformation - All Morphs)

    [111832] = { tooltip = T.Generic_Fear }, -- Werewolf Transformation

    [111843] = { tooltip = T.Generic_Fear }, -- Pack Leader
    [80180] = { hide = true }, -- Birth Direwolf (Pack Leader)
    [80177] = { hide = true }, -- Pack Leader (Pack Leader)
    [80178] = { hide = true }, -- Pack Leader (Pack Leader)
    [80184] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge_pack_leader.dds' }, -- Lunge (Pack Leader)
    [80189] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Pack Leader)
    [80190] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Pack Leader)

    [111844] = { icon = 'esoui/art/icons/ability_werewolf_001_b.dds', tooltip = T.Generic_Fear }, -- Werewolf Berserker
    [89147] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackbleed.dds', name = A.Skill_Werewolf_Bleed, tooltip = T.Generic_Bleed }, -- Werewolf Berserker Bleed (Werewolf Bleed)

    ----------------------------------------------------------------
    -- WEREWOLF QUEST ABILITIES ------------------------------------
    ----------------------------------------------------------------

    [55885] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }, -- Light Attack
    [55886] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Were)
    [55888] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [55891] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack Werewolf
    [55890] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Heavy Attack
    [40124] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', hide = true }, -- Devour
    [40125] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour

    ----------------------------------------------------------------
    -- DARK BROTHERHOOD PASSIVES -----------------------------------
    ----------------------------------------------------------------

    [76325] = { icon = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds' }, -- Blade of Woe
    [79623] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 1) (Blade of Woe Kill)
    [79624] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 2) (Blade of Woe Kill)
    [79625] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 3) (Blade of Woe Kill)
    [79877] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 4) (Blade of Woe Kill)
    [80392] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 1) (Normal Kill)
    [80394] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 2) (Normal Kill)
    [80396] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 3) (Normal Kill)
    [80398] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds' }, -- Major Expedition (Padomaic Sprint - Rank 4) (Normal Kill)


    ----------------------------------------------------------------
    -- FIGHTERS GUILD PASSIVES -------------------------------------
    ----------------------------------------------------------------

    [29062] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_intimidating_presence.dds' },
    [35803] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    [45595] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    [45596] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    [35800] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 1)
    [35801] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 1)
    [45597] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45598] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45599] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 3)
    [45600] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 3)
    [40393] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_skilled_tracker.dds' },
    [35804] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_bounty_hunter.dds' },

    ----------------------------------------------------------------
    -- FIGHTERS GUILD ACTIVE ABILITIES -----------------------------
    ----------------------------------------------------------------

    [40340] = { icon = 'esoui/art/icons/ability_fightersguild_003_b.dds' }, -- Silver Leash (Silver Leash - Rank 1)
    [109354] = { icon = 'esoui/art/icons/ability_fightersguild_003_b.dds' }, -- Silver Leash (Silver Leash - Rank 1)
    [80271] = { forcedContainer = 'short', consolidate = true }, -- Minor Endurance (Circle of Protection - Rank 1)
    [35739] = { forcedContainer = 'short', consolidate = true }, -- Minor Protection (Circle of Protection - Rank 1)
    [80276] = { forcedContainer = 'short', consolidate = true }, -- Minor Endurance (Turn Undead - Rank 1)
    [40185] = { forcedContainer = 'short', consolidate = true }, -- Minor Protection (Turn Undead - Rank 1)
    [80284] = { forcedContainer = 'short', consolidate = true }, -- Minor Endurance (Ring of Preservation - Rank 1)
    [40171] = { forcedContainer = 'short', consolidate = true }, -- Minor Protection (Ring of Preservation - Rank 1)
    [64509] = { consolidateExtra = true }, -- Major Savagery
    [80307] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed }, -- Expert Hunter (Expert Hunter)
    [80381] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed }, -- Evil Hunter (Evil Hunter)
    [80338] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed }, -- Camouflaged Hunter (Camouflaged Hunter)
    [35753] = { hideReduce = true }, -- Trap Beast (Trap Beast - Rank 1)
    [40384] = { hideReduce = true }, -- Rearming Trap (Rearming Trap - Rank 1)
    [40391] = { hideReduce = true }, -- Rearming Trap (Rearming Trap - Rank 1)
    [40374] = { hideReduce = true }, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 1)

    ----------------------------------------------------------------
    -- MAGES GUILD PASSIVES ----------------------------------------
    ----------------------------------------------------------------

    [29061] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_persuasive_will.dds' }, -- Persuasive Will
    [40436] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_mage_adept.dds' }, -- Mage Adept (Rank 1)
    [45601] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_mage_adept.dds' }, -- Mage Adept (Rank 2)
    [40437] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_everlasting_magic.dds' }, -- Everlasting Magic (Rank 1)
    [45602] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_everlasting_magic.dds' }, -- Everlasting Magic (Rank 2)
    [40438] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_magicka_controller.dds' }, -- Magicka Controller (Rank 1)
    [45603] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_magicka_controller.dds' }, -- Magicka Controller (Rank 2)
    [43561] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_might_of_the_guild.dds' }, -- Might of the Guild (Rank 1)
    [45607] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_might_of_the_guild.dds' }, -- Might of the Guild (Rank 2)

    ----------------------------------------------------------------
    -- MAGES GUILD ACTIVE ABILITIES --------------------------------
    ----------------------------------------------------------------

    [77928] = { consolidateExtra = true }, -- Major Prophecy (Magelight)
    [31079] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed }, -- Magelight (Magelight)
    [77945] = { consolidateExtra = true }, -- Major Prophecy (Radiant Magelight)
    [40480] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Inner Light (Inner Light)
    [77958] = { consolidateExtra = true }, -- Major Prophecy (Radiant Magelight)
    [40484] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed }, -- Radiant Magelight (Radiant Magelight)
    [31633] = { hide = true }, -- Fire Rune (Fire Rune)
    [40477] = { icon = 'esoui/art/icons/ability_mageguild_001_a.dds', hide = true }, -- Volcanic Rune (Volcanic Rune)
    [40472] = { hide = true}, -- Volcanic Rune (Volcanic Rune)
    [40467] = { hide = true}, -- Scalding Rune (Scalding Rune)
    [48131] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Equilibrium (Equilibrium)
    [48136] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Spell Symmetry (Spell Symmetry)
    [40443] = { consolidate = true }, -- Major Ward (Balance)
    [80160] = { consolidate = true }, -- Major Resolve (Balance)
    [48141] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Balance (Balance)
    [16538] = { icon = 'esoui/art/icons/ability_mageguild_005.dds', name = A.Skill_Meteor }, -- Meteor Knockback (Meteor)
    [63457] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds' }, -- Ice Comet (Ice Comet)
    [63455] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds', name = A.Skill_Ice_Comet }, -- Ice Comet Knockback (Ice Comet)
    [63454] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds' }, -- Ice Comet (Ice Comet)
    [63472] = { icon = 'esoui/art/icons/ability_mageguild_005_a.dds' }, -- Shooting Star (Shooting Star)
    [40495] = { icon = 'esoui/art/icons/ability_mageguild_005_a.dds' }, -- Shooting Star (Shooting Star)

    ----------------------------------------------------------------
    -- PSIJIC ORDER PASSIVES ---------------------------------------
    ----------------------------------------------------------------

    [103820] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds' }, -- Spell Orb (Spell Orb - Rank 1)
    [103827] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', hide = true }, -- Spell Orb (Spell Orb - Rank 1)
    [103828] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', hide = true }, -- Spell Orb (Spell Orb - Rank 1)
    [103879] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds' }, -- Spell Orb (Spell Orb - Rank 2)
    [103880] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', hide = true }, -- Spell Orb (Spell Orb - Rank 2)
    [103881] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', hide = true }, -- Spell Orb (Spell Orb - Rank 2)
    [103923] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_concentrated_barrier.dds', forcedContainer = 'short' }, -- Concentrated Barrier (Concentrated Barrier - Rank 1)
    [103966] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_concentrated_barrier.dds', forcedContainer = 'short' }, -- Concentrated Barrier (Concentrated Barrier - Rank 2)

    ----------------------------------------------------------------
    -- PSIJIC ORDER ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------

    [104075] = { hideReduce = true }, -- Borrowed Time (Borrowed Time)
    [110420] = { icon = 'esoui/art/icons/ability_psijic_003.dds', name = A.Skill_Imbue_Weapon }, -- Imbue Weapon Restore (Imbue Weapon)
    [110421] = { icon = 'esoui/art/icons/ability_psijic_003_a.dds', name = A.Skill_Elemental_Weapon }, -- Elemental Weapon Restore (Elemental Weapon)
    [110422] = { icon = 'esoui/art/icons/ability_psijic_003_b.dds', name = A.Skill_Crushing_Weapon }, -- Crushing Weapon Restore ( Crushing Weapon)
    [103521] = { consolidateExtra = true }, -- Minor Force (Accelerate)
    [103708] = { consolidateExtra = true }, -- Minor Force (Channeled Acceleration)
    [103712] = { consolidateExtra = true }, -- Minor Force (Race Against Time)
    [107583] = { refreshOnly = true }, -- Mend Wounds (Mend Wounds)
    [107579] = { duration = 0, forcedContainer = 'short' }, -- Mend Wounds (Mend Wounds)
    [107629] = { refreshOnly = true }, -- Mend Spirit (Mend Spirit)
    [107632] = { forcedContainer = 'short' }, -- Major Resolve (Mend Spirit)
    [107631] = { forcedContainer = 'short' }, -- Major Ward (Mend Spirit)
    [107630] = { duration = 0, forcedContainer = 'short' }, -- Mend Spirit (Mend Spirit)
    [103752] = { forcedContainer = 'short' }, -- Major Resolve (Mend Spirit)
    [103751] = { forcedContainer = 'short' }, -- Major Ward (Mend Spirit)
    [107636] = { refreshOnly = true }, -- Symbiosis (Symbiosis)
    [107637] = { name = A.Skill_Symbiosis, duration = 0, forcedContainer = 'short' }, -- Symbiosis HA (Symbiosis)
    [103492] = { forcedContainer = 'short' }, -- Meditate (Meditate)
    [103500] = { icon = 'esoui/art/icons/ability_psijic_004.dds' }, -- Meditate (Meditate)
    [103501] = { icon = 'esoui/art/icons/ability_psijic_004.dds' }, -- Meditate (Meditate)
    [103652] = { forcedContainer = 'short' }, -- Deep Thoughts (Deep Thoughts)
    [103655] = { icon = 'esoui/art/icons/ability_psijic_004_a.dds' }, -- Deep Thoughts (Deep Thoughts)
    [103656] = { icon = 'esoui/art/icons/ability_psijic_004_a.dds' }, -- Deep Thoughts (Deep Thoughts)
    [103665] = { forcedContainer = 'short' }, -- Introspection (Introspection)
    [103668] = { icon = 'esoui/art/icons/ability_psijic_004_b.dds' }, -- Introspection (Introspection)
    [103669] = { icon = 'esoui/art/icons/ability_psijic_004_b.dds' }, -- Introspection (Introspection)

    ----------------------------------------------------------------
    -- UNDAUNTED PASSIVES ------------------------------------------
    ----------------------------------------------------------------

    [55584] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 1)
    [55606] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 1)
    [55607] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = A.Passive_Undaunted_Command }, -- Undaunted Command Magicka Rest (Undaunted Command - Rank 1)
    [55608] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = A.Passive_Undaunted_Command }, -- Undaunted Command Stamina Rest (Undaunted Command - Rank 1)
    [55676] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 2)
    [55677] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 2)
    [55678] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = A.Passive_Undaunted_Command }, -- Undaunted Command Stamina Rest (Undaunted Command - Rank 2)
    [55679] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = A.Passive_Undaunted_Command }, -- Undaunted Command Magicka Rest (Undaunted Command - Rank 2)
    [55366] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_mettle.dds' }, -- Undaunted Mettle (Undaunted Mettle - Rank 1)
    [55386] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_mettle.dds' }, -- Undaunted Mettle (Undaunted Mettle - Rank 2)

    ----------------------------------------------------------------
    -- UNDAUNTED ACTIVES -------------------------------------------
    ----------------------------------------------------------------

    [108782] = { hide = true }, -- Blood Funnel (Blood Altar - Blood Funnel Synergy)
    [80021] = { icon = 'esoui/art/icons/ability_buff_minor_lifesteal.dds' }, -- Minor Lifesteal (Blood Altar)
    [39501] = { icon = 'esoui/art/icons/ability_undaunted_001.dds' }, -- Blood Funnel (Blood Altar - Blood Funnel Synergy)
    [108787] = { hide = true }, -- Blood Feast (Overflowing Altar - Blood Feast Synergy)
    [41964] = { icon = 'esoui/art/icons/ability_undaunted_001_a.dds' }, -- Blood Feast (Overflowing Altar)
    [108788] = { hide = true }, -- Synergy Damage Bonus (Trapping Webs - Spawn Broodlings Synergy)
    [39430] = { icon = 'esoui/art/icons/ability_undaunted_003.dds' }, -- Spawn Broodlings (Trapping Webs - Spawn Broodlings Synergy)
    [39432] = { icon = 'esoui/art/icons/ability_undaunted_003.dds' }, -- Spawn Broodlings (Trapping Webs - Spawn Broodlings Synergy)
    [77245] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_bite.dds' }, -- Bite (Trapping Webs - Spawn Broodlings Synergy)
    [80079] = { duration = 0 }, -- Trapping Webs (Trapping Webs)
    [108791] = { hide = true }, -- Synergy Damage Bonus (Shadow Silk - Black Widows Synergy)
    [41994] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds' }, -- Black Widows (Shadow Silk - Black Widows Synergy)
    [41998] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds', name = A.Skill_Black_Widows }, -- Spawn Broodlings (Shadow Silk - Black Widows Synergy)
    [41999] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds', name = A.Skill_Black_Widows }, -- Spawn Broodlings (Shadow Silk - Black Widows Synergy)
    [42000] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_undaunted_black_widow_poison.dds' }, -- Black Widow Poison (Shadow Silk - Black Widows Synergy)
    [42007] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_black_widow_poison.dds' }, -- Black Widow Poison (Shadow Silk - Black Widows Synergy)
    [80108] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds', duration = 0 }, -- Shadow Silk (Shadow Silk)
    [80107] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds' }, -- Shadow Silk (Shadow Silk)
    [108792] = { hide = true }, -- Synergy Damage Bonus (Tangling Webs - Arachnophobia Synergy)
    [42016] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds' }, -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [42023] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds' }, -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [80130] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds', duration = 0 }, --  Tangling Webs (Tangling Webs)
    [80129] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds' }, --  Tangling Webs (Tangling Webs)
    [108793] = { hide = true }, -- Synergy Damage Bonus (Inner Fire - Radiate Synergy)
    [108794] = { hide = true }, -- Synergy Damage Bonus (Bone Shield - Bone Wall Synergy)
    [108797] = { hide = true }, -- Synergy Damage Bonus (Bone Surge - Spinal Surge Synergy)
    [108799] = { hide = true }, -- Synergy Damage Bonus (Necrotic Orb - Combustion Synergy)
    [85432] = { icon = 'esoui/art/icons/ability_undaunted_004.dds' }, -- Combustion (Necrotic Orb - Combustion Synergy)
    [108802] = { hide = true }, -- Synergy Damage Bonus (Energy Orb - Healing Combustion Synergy)
    [95041] = { icon = 'esoui/art/icons/ability_undaunted_004b.dds', name = A.Skill_Healing_Combustion }, -- Combustion (Energy Orb - Healing Combustion Synergy)
    [95042] = { icon = 'esoui/art/icons/ability_undaunted_004b.dds', name = A.Skill_Healing_Combustion }, -- Combustion (Energy Orb - Healing Combustion Synergy)
    [63511] = { icon = 'esoui/art/icons/ability_undaunted_004b.dds', name = A.Skill_Healing_Combustion }, -- Combustion (Energy Orb - Healing Combustion Synergy)

    ----------------------------------------------------------------
    -- ASSAULT PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39248] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 1)
    [39249] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 1)
    [45614] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 2)
    [45617] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 2)
    [39254] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_reach.dds' }, -- Reach
    [45621] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_reach.dds' }, -- Reach
    [39252] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 1)
    [39253] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 1)
    [45619] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 2)
    [45620] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 2)

    ----------------------------------------------------------------
    -- ASSAULT ACTIVES ---------------------------------------------
    ----------------------------------------------------------------

    [101161] = { consolidate = true, tooltip = zo_strformat("<<C:1>>", A.Skill_Rapid_Manuever) }, -- Major Expedition (Rapid Maneuver)
    [57472] = { consolidate = true, tooltip = zo_strformat("<<C:1>>", A.Skill_Rapid_Manuever) }, -- Major Gallop (Rapid Maneuver)
    [101169] = { consolidate = true, tooltip = zo_strformat("<<C:1>>", A.Skill_Retreating_Manuever) }, -- Major Expedition (Retreating Maneuver)
    [57477] = { consolidate = true, tooltip = zo_strformat("<<C:1>>", A.Skill_Retreating_Manuever) }, -- Major Gallop (Retreating Maneuver)
    [101178] = { consolidate = true, tooltip = zo_strformat("<<C:1>>", A.Skill_Charging_Manuever) }, -- Major Expedition (Charging Maneuver)
    [57481] = { consolidate = true, tooltip = zo_strformat("<<C:1>>", A.Skill_Charging_Manuever) }, -- Major Gallop (Charging Maneuver)
    [64118] = { name = A.Skill_Caltrops, duration = 0 }, -- Hindered (Caltrops - All Morphs)
    [40253] = { name = A.Skill_Razor_Caltrops }, -- Hindered (Razor Caltrops)
    [66482] = { hide = true }, -- Magicka Detonation (Magicka Detonation)
    [66491] = { hide = true }, -- Magicka Detonation (Inevitable Detonation)
    [66499] = { hide = true }, -- Magicka Detonation (Proximity Detonation)
    [63523] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds', consolidate = true }, -- Minor Toughness (War Horn)
    [63527] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds', consolidate = true }, -- Minor Toughness (Aggressive Horn)
    [40222] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds', consolidate = true }, -- Minor Toughness (Sturdy Horn)
    [63532] = { consolidate = true }, -- Minor Resolve (Sturdy Horn)
    [63571] = { consolidate = true }, -- Minor Ward (Sturdy Horn)

    ----------------------------------------------------------------
    -- SUPPORT PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39255] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_magicka_aid.dds' }, -- Magicka Aid
    [45622] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_magicka_aid.dds' }, -- Magicka Aid
    [39259] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_medic.dds' }, -- Combat Medic
    [45624] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_medic.dds' }, -- Combat Medic
    [39261] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_battle_resurrection.dds' }, -- Battle Resurrection
    [45625] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_battle_resurrection.dds' }, -- Battle Resurrection

    ----------------------------------------------------------------
    -- SUPPORT ACTIVES ---------------------------------------------
    ----------------------------------------------------------------

    [39844] = { duration = 0, forcedContainer = 'short' }, -- Siege Shield (Siege Shield)
    [40231] = { duration = 0, forcedContainer = 'short' }, -- Siege Weapon Shield (Siege Weapon Shield)
    [40227] = { duration = 0, forcedContainer = 'short' }, -- Propelling Shield (Siege Weapon Shield)
    [40237] = { hideReduce = true }, -- Reviving Barrier (Reviving Barrier)
    [40238] = { name = A.Skill_Reviving_Barrier }, -- Reviving Barrier Heal (Reviving Barrier)
    [40240] = { icon = 'esoui/art/icons/ability_ava_006_a.dds' }, -- Replenishing Barrier (Replenishing Barrier)
    [40241] = { icon = 'esoui/art/icons/ability_ava_006_a.dds' }, -- Replenishing Barrier (Replenishing Barrier)
    [40233] = { name = A.Skill_Efficient_Purge }, -- Purge (Efficient Purge)
    [40235] = { hide = true }, -- Cleanse (Cleanse)
    [61511] = { duration = 0, forcedContainer = 'short' }, -- Guard (Guard)
    [80923] = { duration = 0 }, -- Guard (Guard)
    [61536] = { duration = 0, forcedContainer = 'short' }, -- Mystic Guard (Mystic Guard)
    [80947] = { duration = 0 }, -- Mystic Guard (Mystic Guard)
    [80953] = { duration = 0, forcedContainer = 'short', consolidate = true }, -- Minor Vitality (Mystic Guard)
    [64080] = { duration = 0, consolidate = true }, -- Minor Vitality (Mystic Guard)
    [80945] = { icon = 'esoui/art/icons/ability_ava_mystic_guard.dds' }, -- Mystic Guard (Mystic Guard)
    [61529] = { duration = 0, forcedContainer = 'short' }, -- Stalwart Guard (Stalwart Guard)
    [80983] = { duration = 0 }, -- Stalwart Guard (Stalwart Guard)
    [80984] = { duration = 0, forcedContainer = 'short', consolidate = true }, -- Minor Force (Stalwart Guard)
    [80986] = { duration = 0, consolidate = true }, -- Minor Force (Stalwart Guard)
    [80981] = { icon = 'esoui/art/icons/ability_ava_stalwart_guard.dds' }, -- Stalwart Guard (Stalwart Guard)
    [61528] = { name = A.Skill_Scorching_Flare }, -- Scorching Flare Reveal (Scorching Flare)
    [61552] = { hideReduce = true }, -- Scorching Flare (Scorching Flare)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES RACIAL --------------------------------------
    ----------------------------------------------------------------

    [36247] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_opportunist.dds' }, -- Opportunist
    [35995] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus
    [45259] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus
    [45260] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus
    [36266] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance
    [45261] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance
    [45262] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance
    [36303] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery
    [45263] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery
    [45264] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery
    [33293] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_craftsman.dds' }, -- Craftsman
    [33301] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny
    [45307] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny
    [45309] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny
    [84668] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching
    [84670] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching
    [84672] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching
    [33304] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior
    [45311] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior
    [45312] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior
    [84680] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_wayfarer.dds' }, -- Wayfarer
    [36009] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Exhilaration
    [45277] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Exhilaration
    [45278] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Exhilaration
    [36153] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning
    [45279] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning
    [45280] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning
    [36546] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush
    [45313] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush
    [45315] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush
    [35965] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_highborn.dds' }, -- Highborn
    [35993] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spellcharge.dds' }, -- Spellcharge
    [45273] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spellcharge.dds' }, -- Spellcharge
    [45274] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spellcharge.dds' }, -- Spellcharge
    [35998] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent
    [45275] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent
    [45276] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent
    [36008] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_acrobat.dds' }, -- Acrobat
    [64279] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance
    [64280] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance
    [64281] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance
    [36011] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction
    [45317] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction
    [45319] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction
    [36022] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stealthy.dds' }, -- Stealthy
    [45295] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stealthy.dds' }, -- Stealthy
    [45296] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stealthy.dds' }, -- Stealthy
    [36063] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_cutpurse.dds' }, -- Cutpurse
    [70386] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble
    [70388] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble
    [70390] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble
    [36067] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage
    [45299] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage
    [45301] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage
    [36582] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_amphibian.dds' }, -- Amphibian
    [36568] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful
    [45243] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful
    [45247] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful
    [36583] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Rsistance
    [45253] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Rsistance
    [45255] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Rsistance
    [36585] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend
    [45257] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend
    [45258] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend
    [36588] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_ashlander.dds' }, -- Ashlander
    [36591] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic
    [45265] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic
    [45267] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic
    [36593] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame
    [45269] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame
    [45270] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame
    [36598] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry
    [45271] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry
    [45272] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry
    [36626] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_reveler.dds' }, -- Reveler
    [36064] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart
    [45297] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart
    [45298] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart
    [36627] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost
    [45303] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost
    [45304] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost
    [36628] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged
    [45305] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged
    [45306] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged
    [36312] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_diplomat.dds' }, -- Diplomat
    [50903] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough
    [50906] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough
    [50907] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough
    [36155] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }, -- Red Diamond
    [45291] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }, -- Red Diamond
    [45293] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }, -- Red Diamond
    [36548] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Adrenaline Rush - Rank 1)
    [45314] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Adrenaline Rush - Rank 2)
    [45316] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Adrenaline Rush - Rank 3)
    [63694] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63695] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63696] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63697] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63698] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63699] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63701] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)
    [63702] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)
    [63703] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)
    [36214] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 1)
    [45292] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 2)
    [45294] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 3)

    --[[
    [88480] = { hide = true }, -- Trap Triggerer (Various)
    [44029] = { icon = 'LuiExtended/media/icons/abilities/ability_slaughterfish.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Slaughterfish Attack (Environmental)
    [26530] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Bear Trap (Bear Trap)
    [65854] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spike Trap Snare (Spike Trap) (Orsinium - To Save a Chief)
    [65855] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Trap Sprung (Spike Trap) (Orsinium - To Save a Chief)
    [65856] = { hide = true }, -- Spike Trap (Spike Trap) (Orsinium - To Save a Chief)
    [20259] = { name = 'Sigil of Frost', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Sigil of Frost Snare (Sigil of Frost - Wrothgar - Coldwind's Den)
    [73103] = { hide = true }, -- Lava (Orsinium - The Hand of Morkul) (Lava)
    ]]--

    -- New Listing
    [73095] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = A.Trap_Lava }, -- In Lava (Vvardenfell - Nchuleftingth - Public Dungeon)
    --[[
    [89481] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Flame Jet (Vvardenfell -- An Armiger's Duty)
    [88403] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Flame Jet (Vvardenfell -- Ancestral Adversity)
    [88491] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Searing Flame (Vvardenfell -- Ancestral Adversity)
    [88510] = { name = A.Innate_Stagger, hide = true }, -- Staggered (Vvardenfell -- Ancestral Adversity)
    [88411] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88413] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88405] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88406] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [89663] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [89664] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88404] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    [88454] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    [88455] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    [87348] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser' }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87349] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser' }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87350] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', unbreakable = 1 }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [92150] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_dwarven_furnace.dds', name = 'Dwarven Furnace', hide = true }, -- Dwarven Furnace (Vvardenfell -- Divine Intervention)
    ]]--

    ----------------------------------------------------------------
    -- JUSTICE NPCS ------------------------------------------------
    ----------------------------------------------------------------

    [63153] = { hide = true }, -- Guard Immunities (Justice Guard)
    [63174] = { hide = true }, -- Guard Speed Boost (Justice Guard)
    [63148] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds' }, -- Major Defile (Justice Guard)
    [63095] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike.dds' }, -- Focused Strike (Justice Guard)
    [63157] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash }, -- Heavy Blow (Justice Guard)
    [63268] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash }, -- Uppercut (Justice Guard)
    [63160] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash }, -- Heavy Blow Knockdown (Justice Guard)
    [63261] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds' }, -- Heavy Blow (Justice Guard)
    [63265] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = A.Skill_Heavy_Blow }, -- Uppercut (Justice Guard)
    [63263] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = A.Skill_Heavy_Blow }, -- Heavy Blow Knockdown (Justice Guard)
    [63093] = { name = A.Skill_Shield_Charge }, -- Charge (Justice Guard 1H)
    [63259] = { name = A.Skill_Mighty_Charge }, -- Charge (Justice Guard 2H)
    [63260] = { icon = 'esoui/art/icons/ability_2handed_003.dds', name = A.Skill_Mighty_Charge }, -- Charge (Justice Guard 2H)
    [63198] = { name = A.Skill_Fiery_Grip }, -- Fiery Chain (Justice Guard)
    [63200] = { name = A.Skill_Fiery_Grip }, -- Firey Chain (Justice Guard)
    [64139] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_piercing_bolt.dds' }, -- Piercing Bolt (Justice Guard)
    [64267] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_shot.dds' }, -- Piercing Bolt (Justice Guard)
    [63911] = { hide = true }, -- Guard Stacking Damage
    [78804] = { hide = true }, -- Seek
    [78802] = { hide = true }, -- Seek
    [78760] = { hide = true }, -- Confusion
    [78764] = { hide = true }, -- Confusion
    [78775] = { hide = true }, -- Confusion
    [78767] = { hide = true }, -- Confusion
    [78768] = { hide = true }, -- Confusion
    [78769] = { hide = true }, -- Confusion
    [78770] = { hide = true }, -- Confusion
    [78766] = { hide = true }, -- Confusion
    [78772] = { hide = true }, -- Confusion
    [78771] = { hide = true }, -- Confusion
    [63179] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = A.Skill_Stonefist }, -- Flame Shard (Justice Guard 2H)
    [63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = A.Skill_Stonefist }, -- Flame Shard (Justice Guard 2H)
    [78743] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds' }, -- Revealed (Guard)
    [78789] = { hide = true }, -- Flare (Guard)
    [78750] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds' }, -- Revealed (Guard)
    [78744] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flare_trap.dds' }, -- Flare (Guard)
    [75613] = { hide = true }, -- Shadowcloak Immunity (Mage Guard)
    [77919] = { hide = true }, -- Clairvoyance Tutorial (Mage Guard)
    [77937] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds', name = A.Skill_Detection }, -- Clairvoyance (Mage Guard)
    [77941] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1 }, -- Revealed (Mage Guard)
    [77917] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_empower_weapon_flame.dds' }, -- Empower Weapon: Flame (Mage Guard)
    [74502] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    [74503] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    [74504] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    [74862] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_teleport_trap.dds' }, -- Teleport Trap (Mage Guard)
    [74870] = { hide = true }, -- Teleport Trap (Mage Guard)
    [74864] = { hide = true }, -- Teleport Trap (Mage Guard)
    [74863] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_teleport_trap.dds' }, -- Teleport Trap (Mage Guard)
    [77449] = { hide = true }, -- Clairvoyance Tutorial (Mage Guard - Instanced)
    [72694] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds', name = A.Skill_Detection }, -- Clairvoyance (Mage Guard - Instanced)
    [72695] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1 }, -- Revealed (Mage Guard - Instanced)
    [78060] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Revealed (Mage Guard - Instanced)
    [75809] = { hide = true }, -- Guard Speed Boost (Mage Guard - Instanced)
    [64647] = { hide = true }, -- Remove Effects (Guard)
    [73226] = { hide = true }, -- Hurried Ward (DB Guard)
    [77452] = { hide = true }, -- Shadow Cloak Immunity (Basic Justice NPC)
    [78012] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Basic Justice NPC)
    [62472] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_stab.dds' }, -- Stab (Justice Rogue)
    [62506] = { icon = 'esoui/art/icons/ability_dualwield_deadlycloak.dds', name = A.Skill_Throw_Dagger, hide = true }, -- Thrown Dagger (Justice Rogue)
    [78013] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', hide = true }, -- Quick Shot (Justice Archer)
    [62408] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bound_weapon.dds' }, -- Bound Weapon (Justice Mage)
    [62409] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds' }, -- Fiery Wind (Justice Mage)
    [62502] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds' }, -- Fiery Wind (Justice Mage)
    [62407] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', hide = true }, -- Fiery Touch (Justice Mage)
    [63828] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Fiery Touch (Justice Mage)
    [61984] = { hide = true }, -- Invisibility Potion (Justice Mage)
    [78265] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_alarm.dds', hide = true }, -- Alarm (Estate Marshal - DB)
    [78266] = { hide = true }, -- Alarm (Estate Marshal - DB)
    [52471] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_nullify.dds', hide = true }, -- Nullify (Estate Spellbreaker - DB)
    [52473] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_nullify.dds' }, -- Nullify (Estate Spellbreaker - DB)
    [52474] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_nullify.dds' }, -- Nullify (Estate Spellbreaker - DB)
    [66669] = { hide = true }, -- Nullify (Estate Spellbreaker - DB)
    [73229] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_hurried_ward.dds' }, -- Hurried Ward (Mage Guard - DB)

    ----------------------------------------------------------------
    -- NPC(Basic) --------------------------------------------------
    ----------------------------------------------------------------

    -- Shared NPC Passives
    [33097] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity }, -- Scary Immunities
    [44176] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_flying_immunities.dds' }, -- Flying Immunities
    [13739] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_backstabber.dds' }, -- Backstabber
    [73768] = { hide = true }, -- GEN 5 Hits
    [79147] = { hide = true }, -- GEN 3 Hits
    [73916] = { hide = true }, -- GEN 2 Hits

    -- Shared NPC Active Events
    [8239] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hamstrung.dds', name = A.Skill_Hamstring }, -- Hamstrung

    -- Standard NPC Abilities
    [2874] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Staggered (Generic Stagger applied to player by many different NPC abilities)

    -- Critter events
    [79544] = { hide = true }, -- Mischievous Dodge (Nixad)
    [79555] = { hide = true }, -- Mischievous Dodge (Nixad)
    [40165] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = A.Innate_Block, duration = 0 }, -- Scene Choreo Brace (Monster Fight)

    -- Friendly NPC Abilities
    [48330] = { hide = true }, -- Aspect of Terror (Abnur Tharn)
    [48331] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror_p.dds' }, -- Aspect of Terror (Abnur Tharn)
    [42905] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds' }, -- Recover
    [42937] = { hide = true }, -- TargetPriorityException

    [4197] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover, unbreakable = 1 }, -- Recovering
    [4198] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover }, -- PC Duel Heal

    -- Human NPC Abilities
    [18386] = { hide = true }, -- Run Away! (Used by various creatures)
    [10618] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Shared Human NPC)
    [12437] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', hide = true }, -- Quick Shot (Shared Human NPC)
    [12456] = { icon = 'esoui/art/icons/ability_mage_009.dds', hide = true }, -- Ice Arrow (Shared Human NPC)
    [10639] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', hide = true }, -- Flare (Shared Human NPC)
    [39060] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Bear Trap (Shared Human NPC)
    [39065] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }, -- Bear Trap (Shared Human NPC)
    [11039] = { hide = true }, -- Spread Out Sound (Synergy)
    [10650] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_oil_drenched.dds' }, -- Oil Drenched (Synergy)
    [12439] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', name = A.Skill_Ignite }, -- Burning Arrow (Synergy - Archer)
    [14068] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy - Archer)
    [10805] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy - Fire Mage)
    [10813] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy - Fire Mage)
    [38260] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy - Fire Mage)
    [31385] = { hide = true }, -- Necromancer Synergy Move Back
    [31390] = { hide = true }, -- Necromancer Synergy Move Back
    [31387] = { hide = true }, -- Necromancer Snergy Kill Self
    [43757] = { hide = true }, -- Cultist Synergy Cast
    [14096] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Footsoldier)
    [28499] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', hide = true }, -- Throw Dagger (Footsoldier)
    [28502] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds' }, -- Throw Dagger (Footsoldier)
    [28504] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', hideReduce = true }, -- Throw Dagger (Footsoldier)
    [29400] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Guard)
    [29401] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Guard)
    [29402] = { icon = 'esoui/art/icons/ability_1handed_005.dds', hide = true }, -- Power Bash (Guard)
    [29761] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = A.Innate_Block, duration = 0 }, -- Brace (Guard)
    [29762] = { hide = true }, -- Blocked Stack (Guard)
    [29757] = { hide = true }, -- Remove block (Guard)
    [29766] = { hide = true }, -- Blocked Stack (Guard)
    [29765] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, hide = true }, -- Uber Attack (Guard)
    [29767] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun }, -- Uber Attack (Guard)
    [84346] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun }, -- Uber Attack (Guard)
    [48542] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = A.Skill_Shield_Rush, hide = true }, -- Focused Charge (Brute)
    [14924] = { hide = true }, -- Focused Charge (Brute)
    [14925] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = A.Skill_Shield_Rush }, -- Charge (Brute)
    [14926] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = A.Skill_Shield_Rush }, -- Charge (Brute)
    [29378] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing }, -- Uppercut (Ravager)
    [29379] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing }, -- Uppercut (Ravager)
    [29380] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing, hide = true }, -- Uppercut (Ravager)
    [29035] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Rogue/Skirmisher)
    [28408] = { icon = 'esoui/art/icons/ability_dualwield_005.dds' }, -- Whirlwind (Rogue/Skirmisher)
    [12381] = { icon = 'esoui/art/icons/ability_rogue_063.dds' }, -- Assassinate (Rogue/Skirmisher)
    [35164] = { hide = true }, -- Agony (Pointless projectile travel time aura)
    [10735] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [49252] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [49253] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [49254] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [44206] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds' }, -- Minor Maim (Berserker)
    [34742] = { icon = 'esoui/art/icons/ability_dragonknight_004.dds' }, -- Fiery Breath (Dragonknight)
    [34647] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance }, -- Lava Whip (Dragonknight)
    [74472] = { icon = 'esoui/art/icons/ability_dragonknight_010.dds' }, -- Dark Talons (Dragonknight)
    [44227] = { icon = 'esoui/art/icons/ability_dragonknight_006.dds'}, -- Dragonknight Standard (Dragonknight - Elite)
    [44229] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', duration = 0 }, -- Major Defile (Dragonknight - Elite)
    [52041] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)
    [52045] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)
    [52051] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)
    [29510] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul)
    [29511] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul)
    [17867] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_aura.dds' }, -- Shock Aura (Thundermaul)
    [44408] = { icon = 'esoui/art/icons/ability_sorcerer_lightning_form.dds' }, -- Lightning Form (Thundermaul -- Boss)
    [81219] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_ranged.dds', hide = true }, -- Shock (Thundermaul -- Boss)
    [81215] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_blast.dds', name = A.Skill_Shock_Blast }, -- Shock Aura (Thundermaul -- Boss)
    [77906] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback }, -- Stun (Thundermaul -- Boss)
    [81193] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_bolt.dds', hide = true }, -- Agonizing Strike (Thundermaul -- Boss)
    [81196] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_snare.dds', displayStacks = true, maxStacks = 25, stack = 1 }, -- Agonizing Fury (Thundermaul -- Boss)
    [81197] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_snare.dds'}, -- Agonizing Fury (Thundermaul -- Boss)
    [81217] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul -- Boss)
    [81218] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul -- Boss)

    [73712] = { hide = true }, -- Shadow Cloak (Nightblade NPC) (Pointless .5 second aura applied on player)
    [73713] = { icon = 'esoui/art/icons/ability_nightblade_004.dds' }, -- Shadow Cloak (Nightblade)
    [36471] = { icon = 'esoui/art/icons/ability_nightblade_002.dds' }, -- Veiled Strike (Nightblade)
    [63822] = { icon = 'esoui/art/icons/ability_nightblade_008.dds' }, -- Teleport Strike (Nightblade)
    [44345] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds', hide = true }, -- Soul Tether (Nightblade - Elite)
    [44349] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Nightblade - Elite)
    [44352] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Nightblade - Elite)
    [44350] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Nightblade - Elite)
    [53462] = { icon = 'esoui/art/icons/ability_nightblade_003.dds' }, -- Siphoning Strikes (Nightblade - Elite)
    [37109] = { icon = 'esoui/art/icons/ability_bow_005.dds' }, -- Arrow Spray (Archer)
    [28628] = { icon = 'esoui/art/icons/ability_bow_003.dds' }, -- Volley (Archer)
    [74978] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_taking_aim.dds', hide = true }, -- Taking Aim (Archer)
    [74980] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_taking_aim.dds' }, -- Taking Aim (Archer)
    [89460] = { hide = true }, -- Set Area (Pet Ranger)
    [36499] = { hide = true }, -- Roll Dodge (Pet Ranger)
    [44301] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = A.Skill_Lightweight_Beast_Trap }, -- Trap Beast (Pet Ranger)
    [44305] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = A.Skill_Lightweight_Beast_Trap }, -- Trap Beast (Pet Ranger)
    [44307] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = A.Skill_Lightweight_Beast_Trap }, -- Trap Beast (Pet Ranger)
    [88251] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally.dds' }, -- Call Ally (Pet Ranger)
    [88248] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_durzog.dds' }, -- Call Ally (Pet Ranger)
    [89425] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_kwama.dds' }, -- Call Ally (Pet Ranger)
    [88275] = { hide = true }, -- Call Ally (Pet Ranger)
    [88265] = { hide = true }, -- Call Ally (Pet Ranger)
    [88288] = { hide = true }, -- Call Ally (Pet Ranger)
    [88268] = { hide = true }, -- Call Ally (Pet Ranger)
    [88281] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Call Ally (Pet Ranger)
    [88227] = { hide = true }, -- Call Ally (Pet Ranger)
    [88252] = { hide = true }, -- Call Ally (Pet Ranger)
    [15164] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds'}, -- Heat Wave (Fire Mage)
    [16588] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds', hide = true }, -- Heat Wave (Fire Mage)
    [47095] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_rune.dds' }, -- Fire Rune (Fire Mage)
    [47102] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_rune.dds' }, -- Fire Rune (Fire Mage)
    [14524] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_ranged.dds', hide = true }, -- Shock (Storm Mage)
    [29471] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_thrall.dds' }, -- Thunder Thrall (Storm Mage)
    [29470] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_thrall.dds' }, -- Thunder Thrall (Storm Mage)
    [29472] = { hide = true }, -- Thunder Thrall (Storm Mage) (self snare shows as buff)
    [12459] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    [12460] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    [14550] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    [14194] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_barrier.dds' }, -- Ice Barrier (Frost Mage)
    [7145] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_barrier.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Ice_Barrier, A.Proc_Chill), stack = 0 }, -- Ice Barrier (Frost Mage)

    [35151] = { icon = 'esoui/art/icons/ability_mage_064.dds' }, -- Spell Absorption (Spirit Mage)
    [14472] = { icon = 'esoui/art/icons/ability_mage_004.dds' }, -- Burdening Eye (Spirit Mage)
    [37200] = { icon = 'esoui/art/icons/ability_mage_004.dds' }, -- Burden (Spirit Mage)
    [35142] = { icon = 'esoui/art/icons/ability_mage_004.dds' }, -- Burden (Spirit Mage)
    [89057] = { hide = true }, -- Burdening Eye (Spirit Mage)
    [89042] = { hide = true }, -- Burdening Eye (Spirit Mage)
    [14477] = { hide = true }, -- Burdening (Spirit Mage)
    [35149] = { hide = true }, -- Burdening Eye (Spirit Mage)
    [37150] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Battlemage)
    [37028] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = A.Skill_Staff_Strike }, -- Quick Strike (Battlemage)
    [37029] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = A.Skill_Staff_Strike }, -- Quick Strike (Battlemage)
    [37030] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = A.Skill_Staff_Strike }, -- Quick Strike (Battlemage)
    [37021] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_empower_weapon_flame.dds' }, -- Empower Weapon: Flame (Battlemage)
    [37087] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
    [37156] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
    [37129] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds' }, -- Ice Cage (Battlemage)
    [37131] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds' }, -- Ice Cage (Battlemage)
    [37132] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds', duration = 0 }, -- Ice Cage (Battlemage)
    [44216] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds' }, -- Negate Magic (Battlemage)
    [50108] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds', duration = 0 }, -- Negate Magic (Battlemage)
    [50107] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds', duration = 0 }, -- Negate Magic (Battlemage)
    [37126] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds' }, -- Entropic Flare (Timb Bomb Mage)
    [36986] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds' }, -- Void (Time Bomb Mage)
    [14370] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds' }, -- Void (Time Bomb Mage)
    [56828] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force_p.dds', hide = true }, -- Fright Force (Fear Mage)
    [14350] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror_p.dds', hide = true }, -- Aspect of Terror (Fear Mage)
    [37084] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror_p.dds' }, -- Aspect of Terror (Fear Mage)
    [35865] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_vanish.dds', name = A.Skill_Vanish }, -- Shadow Cloak (Fear Mage)
    [44247] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89005] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89006] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89008] = { hide = true }, -- Dark Shade (Dreadweaver)
    [39729] = { hide = true }, -- TargetPriorityException (Dreadweaver)
    [44250] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89017] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -23, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dark Shade (Dreadweaver)
    [89010] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds' }, -- Corrode (Dreadweaver)
    [89012] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds' }, -- Minor Maim (Dreadweaver)
    [44323] = { icon = 'esoui/art/icons/ability_armor_003_a.dds' }, -- Dampen Magic (Soulbrander)
    [44258] = { icon = 'esoui/art/icons/ability_mageguild_002.dds', name = A.Skill_Magelight }, -- Radiant Magelight (Soulbrander)
    [44263] = { hide = true }, -- Radiant Magelight (Soulbrander)
    [44259] = { icon = 'esoui/art/icons/ability_mageguild_002.dds', hide = true }, -- Magelight (Soulbrander)
    [29372] = { icon = 'esoui/art/icons/ability_mage_027.dds', hide = true }, -- Necrotic Spear (Necromancer)
    [88554] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_the_dead.dds' }, -- Summon the Dead (Necromancer)
    [88555] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_the_dead.dds' }, -- Summon the Dead (Necromancer)
    [88561] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon the Dead (Necromancer)
    [13397] = { icon = 'esoui/art/icons/achievement_update15_030.dds' }, -- Empower Undead (Necromancer)
    [31848] = { hide = true }, -- Summon the Dead (Necromancer)
    [88582] = { hide = true }, -- Summon the Dead (Necromancer)
    [88583] = { hide = true }, -- Summon the Dead (Necromancer)
    [88599] = { hide = true }, -- Summon the Dead (Necromancer)
    [88590] = { hide = true }, -- Summon the Dead (Necromancer)
    [88591] = { hide = true }, -- Summon the Dead (Necromancer)
    [88592] = { hide = true }, -- Summon the Dead (Necromancer)
    [88586] = { hide = true }, -- Summon the Dead (Necromancer)
    [88589] = { hide = true }, -- Summon the Dead (Necromancer)
    [88600] = { hide = true }, -- Summon the Dead (Necromancer)
    [88602] = { hide = true }, -- Summon the Dead (Necromancer)
    [88618] = { hide = true }, -- Summon the Dead (Necromancer)
    [88611] = { hide = true }, -- Summon the Dead (Necromancer)
    [88607] = { hide = true }, -- Summon the Dead (Necromancer)
    [88613] = { hide = true }, -- Summon the Dead (Necromancer)
    [88621] = { hide = true }, -- Summon the Dead (Necromancer)
    [88615] = { hide = true }, -- Summon the Dead (Necromancer)
    [88610] = { hide = true }, -- Summon the Dead (Necromancer)
    [88608] = { hide = true }, -- Summon the Dead (Necromancer)
    [88614] = { hide = true }, -- Summon the Dead (Necromancer)
    [88622] = { hide = true }, -- Summon the Dead (Necromancer)
    [88616] = { hide = true }, -- Summon the Dead (Necromancer)
    [88626] = { hide = true }, -- Summon the Dead (Necromancer)
    [88627] = { hide = true }, -- Summon the Dead (Necromancer)
    [88601] = { hide = true }, -- Summon the Dead (Necromancer)
    [88593] = { hide = true }, -- Summon the Dead (Necromancer)
    [88617] = { hide = true }, -- Summon the Dead (Necromancer)
    [88596] = { hide = true }, -- Summon the Dead (Necromancer)
    [88566] = { hide = true }, -- Summon the Dead (Necromancer)
    [88597] = { hide = true }, -- Summon the Dead (Necromancer)
    [88598] = { hide = true }, -- Summon the Dead (Necromancer)
    [7590] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_entropic_bolt.dds' }, -- Entropic Bolt (Bonelord)
    [35387] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Bone Cage (Bonelord)
    [88322] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Bone Cage (Bonelord)
    [35391] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds', name = A.Skill_Bone_Cage }, -- Defiled Grave (Bonelord)
    [88504] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon Abomination (Bonelord)
    [88506] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_abomination.dds' }, -- Summon Abomination (Bonelord)
    [88507] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_abomination.dds' }, -- Summon Abomination (Bonelord)
    [44339] = { icon = 'esoui/art/icons/ability_undaunted_005a.dds' }, -- Bone Surge (Bonelord)
    [10601] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_minor_wound.dds', hide = true }, -- Minor Wound (Healer)
    [57534] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (Healer)
    [57537] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (Healer)
    [57538] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (Healer)
    [50966] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_healer_immune.dds', name = A.Skill_Defensive_Ward }, -- Healer Immune (Healer)
    [50931] = { hide = true }, -- Healer Immune (Healer)
    [50975] = { hide = true }, -- Healer Immune (Healer)
    [50998] = { hide = true }, -- Rite of Passage (Healer)
    [44328] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds', hide = true }, -- Rite of Passage (Healer)
    [44329] = { hide = true }, -- Rite of Passage (Healer)
    [29669] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_coiled_lash.dds', hide = true }, -- Coiled Lash (Shaman)
    [29520] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_aura_of_protection.dds' }, -- Aura of Protection (Shaman)
    [29521] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_aura_of_protection.dds' }, -- Aura of Protection (Shaman)
    [29597] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Combustion (Shaman)
    [65314] = { hide = true }, -- Aura of Protection (Shaman)
    [65432] = { hide = true }, -- Aura of Protection (Shaman)
    [83073] = { hide = true }, -- Summon Died (Shaman)
    [68866] = { icon = 'esoui/art/icons/ability_ava_003.dds' }, -- Warhorn (Faction NPCs)
    [68867] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [68868] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [68869] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [43644] = { hide = true, icon = 'esoui/art/icons/ability_ava_001.dds', name = A.Skill_Caltrops }, -- Barrier [monster synergy]  (Faction NPCs)
    [43645] = { hide = true, icon = 'esoui/art/icons/ability_ava_001.dds', name = A.Skill_Caltrops }, -- Barrier [monster synergy]  (Faction NPCs)
    [43646] = { hide = true, icon = 'esoui/art/icons/ability_ava_001.dds', name = A.Skill_Caltrops }, -- Barrier [monster synergy]  (Faction NPCs)
    [38119] = { icon = 'esoui/art/icons/ability_ava_001.dds', duration = 0 }, -- Caltrops  (Faction NPCs)
    [38125] = { icon = 'esoui/art/icons/ability_ava_001.dds' }, -- Caltrops  (Faction NPCs)
    [65033] = { icon = 'esoui/art/icons/ability_warrior_014.dds', hide = true }, -- Retaliation (Winterborn Warrior)
    [69158] = { icon = 'esoui/art/icons/ability_warrior_014.dds' }, -- Retaliation (Winterborn Warrior)
    [67114] = { icon = 'esoui/art/icons/ability_warrior_014.dds' }, -- Retaliation (Winterborn Warrior)
    [69157] = { icon = 'esoui/art/icons/ability_warrior_014.dds', hide = true }, -- Retaliation (Winterborn Warrior)
    [69153] = { icon = 'esoui/art/icons/ability_warrior_014.dds' }, -- Retaliation (Winterborn Warrior)
    [1347] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance }, -- Off-Balance (Winterborn Warrior)
    [70070] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Strike (Winterborn Warrior)
    [64980] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_javelin.dds', hide = true }, -- Javelin (Winterborn Warrior)
    [14883] = { icon = 'esoui/art/icons/achievement_030.dds', name = A.Skill_Off_Balace_Immunity }, -- Off-Balance (Winterborn Warrior)
    [69282] = { hide = true }, -- Roll Dodge Back (Winterborn Warrior)
    [54593] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Winterborn Mage)
    [55909] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (Winterborn Mage)
    [55911] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', hide = true }, -- Grasping Vines (Winterborn Mage)
    [55918] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (Winterborn Mage)
    [55916] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vineburst.dds' }, -- Grasping Vineburst (Winterborn Mage)
    [64704] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds', hide = true }, -- Flames (Winterborn Mage)
    [64711] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds', hide = true }, -- Flames (Winterborn Mage)
    [54184] = { hide = true }, -- Revenge 2 (Vosh Rakh Devoted)
    [54397] = { hide = true }, -- Rally (Vosh Rakh Devoted)
    [53987] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_inspire.dds', name = A.Skill_Inspire }, -- Rally (Vosh Rakh Devoted)
    [65235] = { icon = 'esoui/art/icons/ability_warrior_025.dds' }, -- Enrage (Vosh Rakh Devoted)
    [54027] = { icon = 'esoui/art/icons/ability_warrior_032.dds' }, -- Divine Leap (Vosh Rakh Devoted)
    [67272] = { hide = true }, -- Invisible No Target (Vosh Rakh Devoted)
    [54028] = { icon = 'esoui/art/icons/ability_warrior_032.dds' }, -- Divine Leap (Vosh Rakh Devoted)
    [67593] = { icon = 'esoui/art/icons/ability_warrior_032.dds', name = A.Skill_Divine_Leap, hide = true }, -- Divine Leap Stagger (Vosh Rakh Devoted)
    [54050] = { icon = 'esoui/art/icons/ability_warrior_032.dds', name = A.Skill_Divine_Leap, hide = true }, -- Divine Leap Stun (Vosh Rakh Devoted)
    [51000] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_cleave_stance.dds'}, -- Cleave Stance (Dremora Caitiff)
    [51923] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Great_Cleave }, -- Cleave Stance (Dremora Caitiff)
    [51940] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Great_Cleave }, -- Cleave Stance (Dremora Caitiff)
    [51942] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Great_Cleave }, -- Cleave Stance (Dremora Caitiff)
    [74480] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', hide = true }, -- Fiery Grip (Sentinel) (TG DLC)
    [74483] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds' }, -- Fiery Grip (Sentinel) (TG DLC)
    [72725] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage }, -- Fool Me Once (TG DLC)
    [72723] = { hide = true }, -- Fool Me Once (Sentinel) (TG DLC)
    [77468] = { hide = true }, -- Fool Me Once (Sentinel) (TG DLC)
    [74630] = { hide = true }, -- Flare Trap Proxy (Archer) (TG DLC)
    [72716] = { icon = 'esoui/art/icons/ability_rogue_015.dds' }, -- Uncanny Dodge (Archer) (TG DLC)
    [72719] = { hide = true }, -- Uncanny Dodge SUC REM (Archer) (TG DLC)
    [72214] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds' }, -- Poisoned Arrow (Archer) (TG DLC)
    [72217] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds' }, -- Poisoned Arrow (Archer) (TG DLC)
    [72222] = { icon = 'esoui/art/icons/ability_rogue_067.dds', name = A.Skill_Hide_in_Shadows }, -- Shadow Cloak (Archer) (TG DLC)
    [76089] = { icon = 'esoui/art/icons/ability_bow_001.dds', hide = true }, -- Snipe (Archer) (TG DLC)
    [72220] = { icon = 'esoui/art/icons/ability_bow_001.dds', hide = true }, -- Snipe (Archer) (TG DLC)
    [74619] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flare_trap.dds', hide = true }, -- Flare Trap (Archer) (TG DLC)
    [74621] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Revealed (Archer) (TG DLC)
    [74618] = { hide = true }, -- Flare Trap
    [74627] = { hide = true }, -- Flare Trap
    [74620] = { hide = true }, -- Flare Trap REM
    [77472] = { icon = 'esoui/art/icons/ability_warrior_030.dds' }, -- 'Til Death (Bodyguard) (DB DLC)
    [79523] = { icon = 'esoui/art/icons/ability_warrior_030.dds' }, -- 'Til Death (Bodyguard) (DB DLC)
    [77554] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77555] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', duration = 863700 }, -- Shard Shield (Bodyguard) (DB DLC)
    [77562] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77609] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds' }, -- Shard Shield (Bodyguard) (DB DLC)
    [77473] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Bodyguard) (DB DLC)
    [77815] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Bodyguard) (DB DLC)
    [77927] = { name = A.Innate_Stagger, hide = true }, -- Staggered (Bodyguard) (DB DLC)
    [77474] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77475] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77476] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77477] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77489] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77748] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77778] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77765] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77750] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [79534] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [83620] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [83624] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77838] = { hide = true }, -- Shield Charge (Bodyguard) (DB DLC)
    [77602] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77672] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover }, -- 'Til Death (Bodyguard) (DB DLC)
    [77742] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover }, -- 'Til Death (Bodyguard) (DB DLC)

    -- Cyrodiil
    [47717] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Cyrodiil Guard T1)
    [46830] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds' }, -- Bleeding Strike (Cyrodiil Guard T2)
    [46832] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', name = A.Skill_Bleeding_Strike }, -- Bleeding (Cyrodiil Guard T2)
    [46831] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', name = A.Skill_Bleeding_Strike }, -- Bleeding (Cyrodiil Guard T2)
    [46834] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Cyrodiil Guard T2)
    [72639] = { icon = 'esoui/art/icons/ability_1handed_005.dds', hide = true }, -- Power Bash (Cyrodiil Guard T2)
    [72641] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Cyrodiil Guard T2)
    [36304] = { name = A.Skill_Spiked_Armor }, -- Razor Armor (Cyrodiil Guard T2)
    [36306] = { hide = true }, -- Razor Armor (Cyrodiil Guard T2)
    [36305] = { name = A.Skill_Spiked_Armor }, -- Spike Armor Damage Return (Cyrodiil Guard T2)
    [7880] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = A.Skill_Shock_Torrent, hide = true }, -- Light Attack (Cyrodiil Mage T1)
    [46336] = { name = A.Skill_Crystal_Shard }, -- Crystal Shard Stun (Cyrodiil Mage T1)
    [21629] = { icon = 'esoui/art/icons/ability_mage_008.dds' }, -- Mage's Lifesteal (Cyrodiil Mage T1)
    [46711] = { hide = true }, -- Bound Aegis (Cyrodiil Mage T2)
    [46726] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = A.Skill_Improved_Shock_Torrent, hide = true }, -- Shock Torrent (Cyrodiil Mage T2)
    [46730] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = A.Skill_Improved_Shock_Torrent }, -- Shock Torrent (Cyrodiil Mage T2)
    [46819] = { icon = 'esoui/art/icons/ability_mage_068.dds', name = A.Skill_Lasting_Storm }, -- Storm Damage (Cyrodiil Mage T2)
    [46704] = { icon = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds' }, -- Crystal Blast (Cyrodiil Mage T2)
    [46706] = { icon = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds', name = A.Skill_Crystal_Blast }, -- Crystal Shard Stun (Cyrodiil Mage T2)
    [46716] = { icon = 'esoui/art/icons/ability_mage_008.dds', name = A.Skill_Steal_Essence }, -- Stolen Essence (Cyrodiil Mage T2)
    [46719] = { hide = true }, -- Stolen Essence (Cryodiil Mage T2) (Pointless aura)
    [75397] = { hide = true }, -- Unstable Core (Cryodiil Mage T2) (Pointless aura)
    [75395] = { hide = true }, -- Reflected FX (Cryodiil Mage T2) (Pointless aura)
    [57962] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_minor_wound.dds', hide = true }, -- Minor Wound (Cyrodiil Mender T1)
    [46272] = { duration = 0 }, -- Rune Focus (Cyrodiil Mender T1)
    [21638] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_telekinetic_disorient.dds', name = A.Skill_Telekinetic_Prison }, -- Telekinetic Disorient (Cyrodiil Mender T1)
    [46839] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_minor_wound.dds', hide = true }, -- Major Wound (Cyrodiil Mender T2)
    [46904] = { icon = 'esoui/art/icons/ability_templar_rune_focus.dds', duration = 0 }, -- Rune Focus (Cyrodiil Mender T2)
    [46906] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_telekinetic_disorient.dds', name = A.Skill_Shattering_Prison }, -- Telekinetic Disorient (Cyrodiil Mender T2)
    [46910] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_telekinetic_disorient.dds' }, -- Shattering Prison (Cyrodiil Mender T2)
    [52862] = { hide = true }, -- Health Boon (Cyrodiil Mender T2)
    [22469] = { hide = true }, -- Siege Shield (Cyrodiil Mender T1 + T2)
    [22489] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_healer_immune.dds', name = A.Skill_Siege_Barrier }, -- Siege Bubble (Cyrodiil Mender T1 + T2)
    [51893] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds', duration = 0 }, -- Negate Magic (Cyrodiil Mender T1 + T2)
    [51894] = { duration = 0 }, -- Negate Magic (Cyrodiil Mender T1 + T2)
    [52864] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds' }, -- Quick Shot (Cyrodiil Archer T1 + T2)
    [54258] = { name = A.Skill_Improved_Volley }, -- Upgraded Volley (Cyrodiil Archer T2)
    [54264] = { icon = 'esoui/art/icons/ability_bow_001_a.dds', hide = true }, -- Lethal Arrow (Cryodiil Archer T2)
    [54265] = { icon = 'esoui/art/icons/ability_bow_001_a.dds' }, -- Lethal Arrow (Cryodiil Archer T2)
    [54259] = { icon = 'esoui/art/icons/ability_bow_004_a.dds', hide = true }, -- Draining Shot (Cryodiil Archer T2)
    [54261] = { icon = 'esoui/art/icons/ability_bow_004_a.dds' }, -- Draining Shot (Cryodiil Archer T2)
    [16510] = { name = A.Skill_Fire_Torrent, hide = true }, -- Fire Salvo (Cyrodiil Honor Guard T1)
    [15780] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_aoe_alt.dds' }, -- Honor Guard Rage (Cyrodiil Honor Guard T1)
    [32446] = { icon = 'esoui/art/icons/ability_dragonknight_011.dds', name = A.Skill_Dragon_Blood }, -- Guardian Heal (Cyrodiil Honor Guard T1)
    [35113] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', hide = true }, -- Extended Chains (Cyrodiil Honor Guard T1)
    [35115] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Extended_Chains, hide = true }, -- Pull (Cyrodiil Honor Guard T1)
    [46992] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_snare_shock.dds' }, -- Cripping Rage (Cyrodiil Honor Guard T2)
    [47001] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_snare_shock.dds' }, -- Cripping Rage (Cyrodiil Honor Guard T2)
    [47004] = { icon = 'esoui/art/icons/ability_dragonknight_011.dds', name = A.Skill_Dragon_Blood }, -- Guardian Heal (Cyrodiil Honor Guard T2)
    [47019] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', hide = true }, -- Puncturing Chains (Cyrodiil Honor Guard T2)
    [47023] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Puncturing_Chains }, -- Puncture (Cyrodiil Honor Guard T2)
    [47020] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Puncturing_Chains, hide = true }, -- Pull (Cyrodiil Honor Guard T2)
    [15783] = { icon = 'esoui/art/icons/ability_warrior_022.dds' }, -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [15782] = { icon = 'esoui/art/icons/ability_warrior_022.dds' }, -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [46990] = { hide = true }, -- Improved Fire Torrent (Cyrodiil Honor Guard T2)
    [46991] = { icon = 'esoui/art/icons/ability_mage_011.dds', name = A.Skill_Improved_Fire_Torrent }, -- Fire Torrent Burning (Cryodiil Honor Guard T2)

    -- Animals
    [5451] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_bite.dds' }, -- Bite (Alit)
    [5452] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }, -- Lacerate (Alit)
    [84356] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }, -- Lacerate (Alit)
    [56984] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', name = A.Skill_Lacerate }, -- Laceration (Alit)
    [56983] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', name = A.Skill_Lacerate }, -- Laceration (Alit)
    [4413] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds', name = A.Skill_Bite }, -- Swipe (Bear)
    [4415] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Crushing Swipe (Bear)
    [38772] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Crushing Swipe (Bear)
    [18273] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Crushing Swipe (Bear)
    [4416] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }, -- Savage Blows (Bear)
    [12380] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }, -- Savage Blows (Bear)
    [61594] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds', name = A.Skill_Savage_Blows }, -- Savage Blows Bleeding (Bear)
    [70355] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds' }, -- Bite (Great Bear)
    [70357] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }, -- Lunge (Great Bear)
    [70359] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }, -- Lunge (Great Bear)
    [70366] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Slam (Great Bear)
    [89189] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Slam (Great Bear)
    [69073] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', name = A.Skill_Slam }, -- Knockdown (Great Bear)
    [70374] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity }, -- Ferocity (Great Bear)
    [70372] = { hide = true }, -- Ferocity (Great Bear)
    [70376] = { hide = true }, -- Ferocity (Great Bear)
    [70375] = { hide = true }, -- Ferocity (Great Bear)
    [4583] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Bite (Crocodile)
    [9642] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Bite (Crocodile)
    [4587] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_crushing_chomp.dds' }, -- Crushing Chomp (Crocodile)
    [4591] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }, -- Sweep (Crocodile)
    [32051] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }, -- Sweep (Crocodile)
    [4594] = { icon= 'LuiExtended/media/icons/abilities/ability_crocodile_ancient_skin.dds' }, -- Ancient Skin (Crocodile)
    [8971] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Bite (Duneripper)
    [9643] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Bite (Duneripper)
    [8972] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_crushing_chomp.dds' }, -- Crushing Chomp (Duneripper)
    [8977] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }, -- Sweep (Duneripper)
    [32461] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }, -- Sweep (Duneripper)
    [7214] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }, -- Bite (Durzog)
    [7221] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rend.dds' }, -- Rend (Durzog)
    [7227] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', name = A.Skill_Rip_and_Tear },-- Rotbone (Durzog)
    [16878] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', name = A.Skill_Rip_and_Tear }, -- Rotbone (Durzog)
    [6304] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_swipe.dds' }, -- Swipe (Dreugh)
    [18002] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [18003] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [18005] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [6308] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_touch.dds' }, -- Shocking Touch (Dreugh)
    [6328] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Dreugh)
    [27100] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Dreugh)
    [54374] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_tusks.dds' }, -- Tusks (Echatere)
    [54375] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }, -- Shockwave (Echatere)
    [54378] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }, -- Shockwave (Echatere)
    [68971] = { name = A.Innate_Stagger }, -- Staggered (Echatere - Shockwave)
    [54380] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }, -- Headbutt (Echatere)
    [54382] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }, -- Headbutt (Echatere)
    [54381] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }, -- Headbutt (Echatere)
    [60920] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_scrape.dds' }, -- Scrape (Giant Bat)
    [4632] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    [47321] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    [18319] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    [4630] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_draining_bite.dds' }, -- Draining Bite (Giant Bat)
    [8540] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_strike.dds' }, -- Strike (Giant Snake)
    [5240] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }, -- Lash (Giant Snake)
    [30214] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }, -- Lash (Giant Snake)
    [5242] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds' }, -- Kiss of Poison (Giant Snake)
    [21826] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds' }, -- Kiss of Poison (Giant Snake)
    [5244] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_shed_skin.dds'}, -- Shed Skin (Giant Snake)
    [5440] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_bite.dds' }, -- Bite (Guar)
    [5443] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_headbutt.dds' }, -- Headbutt (Guar)
    [5441] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds' }, -- Dive (Guar)
    [84359] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds' }, -- Dive (Guar)
    [5363] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }, -- Chomp (Kagouti)
    [5926] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }, -- Toss (Kagouti)
    [42889] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }, -- Toss (Kagouti)
    [42888] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds', hide = true }, -- Toss (Kagouti)
    [18198] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }, -- Toss (Kagouti)
    [14202] = { hide = true }, -- Charge (Kagouti)
    [14196] = { hide = true }, -- Charge (Kagouti)
    [14819] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds', name = A.Skill_Rush, hide = true }, -- Charge (Kagouti)
    [14825] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds', name = A.Skill_Rush }, -- Charge (Kagouti)
    [14828] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds', name = A.Skill_Rush }, -- Charge (Kagouti)
    [14829] = { hide = true }, -- Charge (Kagouti)
    [18751] = { hide = true }, -- Charge (Kagouti)
    [87310] = { hide = true }, -- Run Away! (Kagouti Whelp)
    [87312] = { hide = true }, -- Run Away! (Kagouti Whelp)
    [87276] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }, -- Chomp (Kagouti Whelp)
    [7170] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
    [60630] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
    [60641] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_claw.dds' }, -- Claw (Lion)
    [7158] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
    [7161] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_double_strike.dds' }, -- Double Strike (Lion)
    [8705] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds' }, -- Weakness (Lion)
    [8601] = { hide = true }, -- Vigorous Swipe (Mammoth)
    [75633] = { hide = true }, -- Vigorous Swipe (Mammoth)
    [75634] = { hide = true }, -- Vigorous Swipes (Mammoth)
    [8596] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_swipe.dds' }, -- Swipe (Mammoth)
    [8604] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_vigorous_swipes.dds', name = A.Skill_Vigorus_Swipes }, -- Vigorous Swipe (Mammoth)
    [8600] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }, -- Stomp (Mammoth)
    [23164] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }, -- Stomp (Mammoth)
    [48551] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = A.Skill_Stampede, hide = true}, -- Focused Charge (Mammoth)
    [23222] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = A.Skill_Stampede }, -- Charge (Mammoth)
    [23227] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = A.Skill_Stampede }, -- Charge (Mammoth)
    [23225] = { hide = true }, -- Charge (Mammoth) (Pointless aura that does nothing)
    [4192] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_pincer.dds' }, -- Pincer (Mudcrab)
    [4224] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }, -- Double Claw Strike (Mudcrab)
    [4226] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }, -- Double Claw Strike (Mudcrab)
    [4200] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }, -- Unforgiving Claws (Mudcrab)
    [85082] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }, -- Unforgiving Claws (Mudcrab)
    [42841] = { hide = true }, -- Scuttle (Mudcrab)
    [16667] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_slap.dds' }, -- Slap (Netch)
    [16690] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_thrust.dds' }, -- Thrust (Netch)
    [16697] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds' }, -- Poisonbloom (Netch)
    [16698] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds' }, -- Poisonbloom (Netch)
    [7266] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }, -- Strike (Nix-Hound)
    [13416] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }, -- Strike (Nix-Hound)
    [7268] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }, -- Leech (Nix-Hound)
    [12303] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }, -- Leech (Nix-Hound)
    [18344] = { hide = true }, -- Leech (Nix-Hound)
    [7273] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }, -- Dampworm (Nix-Hound)
    [38635] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }, -- Dampworm (Nix-Hound)
    [38640] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }, -- Dampworm (Nix-Hound)
    [5362] = { icon = 'LuiExtended/media/icons/abilities/ability_skeever_slam.dds' }, -- Slam (Skeever)
    [21904] = { icon = 'LuiExtended/media/icons/abilities/ability_skeever_rend.dds' }, -- Rend (Skeever)
    [21947] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_bite.dds' }, -- Bite (Wamasu)
    [21949] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }, -- Sweep (Wamasu)
    [46833] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }, -- Sweep (Wamasu)
    [37178] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }, -- Sweep (Wamasu)
    [21951] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds', hide = true }, -- Repulsion Shock (Wamasu)
    [21952] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds' }, -- Repulsion Shock (Wamasu)
    [22045] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_static.dds' }, -- Static (Wamasu)
    [48556] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = A.Skill_Barreling_Charge, hide = true }, -- Focused Charge (Wamasu)
    [21961] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = A.Skill_Barreling_Charge }, -- Charge (Wamasu)
    [21967] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = A.Skill_Barreling_Charge }, -- Charge (Wamasu)
    [21963] = { hide = true }, -- Charge (Wamasu) (Pointless aura that does nothing)
    [44781] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_swipe.dds', name = A.Skill_Bite }, -- Swipe (Welwa)
    [45937] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_cleave.dds', name = A.Skill_Swipe }, -- Cleave (Welwa)
    [44791] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }, -- Rear Kick (Welwa)
    [44792] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }, -- Rear Kick (Welwa)
    [52417] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = A.Skill_Blitz }, -- Charge (Welwa)
    [45986] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = A.Skill_Blitz }, -- Charge (Welwa)
    [45991] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = A.Skill_Blitz }, -- Charge (Welwa)
    [45984] = { hide = true }, -- Charge (Welwa)
    [4022] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_bite.dds' }, -- Bite (Wolf)
    [42844] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_rotbone.dds' }, -- Rotbone (Wolf)
    [14523] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds' }, -- Helljoint (Wolf)
    [75818] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds' }, -- Helljoint (Wolf)
    [14272] = { hide = true }, -- Call of the Pack (Wolf)
    [14273] = { hide = true }, -- Call of the Pack (Wolf)
    [26658] = { hide = true }, -- Call of the Pack (Jackal)
    [26659] = { hide = true }, -- Call of the Pack (Jackal)
    [72803] = { hide = true }, -- Hardened Shell (Haj Mota)
    [74123] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_claw.dds' }, -- Claw (Haj Mota)
    [72787] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }, -- Horn Strike (Haj Mota)
    [73481] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }, -- Horn Strike (Haj Mota)
    [74272] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds', hide = true }, -- Bite (Haj Mota)
    [76578] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds' }, -- Bite (Haj Mota)
    [72793] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', hide = true }, -- Toxic Mucus (Haj Mota)
    [76577] = { hide = true }, -- Toxic Mucous (Haj Mota)
    [72815] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', name = A.Skill_Toxic_Mucus }, -- Toxic Mucous (Haj Mota)
    [72794] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds', hide = true}, -- Toxic Pool (Haj Mota)
    [72796] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds', hide = true}, -- Bog Burst (Haj Mota)
    [72799] = { hide = true }, -- Bog Burst (Haj Mota)
    [76183] = { hide = true }, -- Bog Burst (Haj Mota)
    [72800] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    [74336] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    [74337] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    [76184] = { hide = true }, -- Bog Burst (Haj Mota)
    [72789] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Shockwave (Haj Mota)
    [73494] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Shockwave (Haj Mota)
    [76319] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_backstabber.dds', name = A.Skill_Backstabber }, -- Backstabber (Dire Wolf)
    [80382] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }, -- Bite (Dire Wolf)
    [80383] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }, -- Bite (Dire Wolf)
    [76307] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds' }, -- Lunge (Dire Wolf)
    [76308] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds' }, -- Lunge (Dire Wolf)
    [76303] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds' }, -- Nip (Dire Wolf)
    [76304] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds' }, -- Nip (Dire Wolf)
    [76305] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Dire Wolf)
    [76306] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Dire Wolf)
    [85656] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_harry.dds' }, -- Harry (Dire Wolf)
    [76312] = { hide = true }, -- Harry (Dire Wolf)
    [76324] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_baleful_call.dds' }, -- Baleful Call (Dire Wolf)
    [76322] = { hide = true }, -- Baleful Call (Dire Wolf)
    [85200] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_scythe.dds' }, -- Scythe (Nix-Ox)
    [85198] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_snap.dds' }, -- Snap (Nix-Ox)
    [85201] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_gore.dds', name = A.Skill_Gore }, -- Bite (Nix-Ox)
    [85202] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_gore.dds' }, -- Gore (Nix-Ox)
    [85084] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_shriek.dds', hide = true }, -- Shriek (Nix-Ox)
    [85085] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_shriek.dds', hide = true }, -- Shriek (Nix-Ox)
    [90765] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds', hide = true }, -- Acid Spray (Nix-Ox)
    [90776] = { hide = true }, -- Acid Spray (Nix-Ox)
    [90780] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds' }, -- Acid Spray (Nix-Ox)
    [90778] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_gtaoe.dds', hide = true }, -- Acid Pool (Nix-Ox)
    [90809] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds', hide = true }, -- Acid Spray (Nix-Ox)
    [90811] = { hide = true }, -- Acid Spray (Nix-Ox)
    [90812] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds' }, -- Acid Spray (Nix-Ox)
    [90815] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_gtaoe.dds', hide = true }, -- Acid Pool (Nix-Ox)
    [85172] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }, -- Winnow (Nix-Ox)
    [85175] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }, -- Winnow (Nix-Ox)
    [85186] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }, -- Winnow (Nix-Ox)
    [85173] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }, -- Winnow (Nix-Ox)
    [85203] = { icon = 'esoui/art/icons/ability_warrior_025.dds', hide = true, name = A.Skill_Enrage }, -- Nix-Call (Nix-Ox)
    [95389] = { hide = true }, -- Nix-Call (Nix-Ox)
    [90187] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage }, -- Nix-Call (Nix-Ox)
    [90190] = { hide = true }, -- Nix-Call (Nix-Ox)
    [89940] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', name = A.Skill_Bile_Spit }, -- Turret (Nix Hound)
    [85387] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_snap.dds' }, -- Snap (Cliff Strider)
    [85388] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_stab.dds' }, -- Stab (Cliff Strider)
    [93516] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_tail_lash.dds' }, -- Tail Lash (Cliff Strider)
    [85395] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }, -- Dive (Cliff Strider)
    [92085] = { hide = true }, -- Dive (Cliff Strider)
    [85398] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }, -- Dive (Cliff Strider)
    [90319] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }, -- Dive (Cliff Strider)
    [90320] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }, -- Dive (Cliff Strider)
    [85399] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch.dds' }, -- Retch (Cliff Strider)
    [85420] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch.dds' }, -- Retch (Cliff Strider)
    [85421] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch_aoe.dds' }, -- Retch (Cliff Strider)
    [85448] = { hide = true }, -- Frenzied Feast (Cliff Strider)
    [85390] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds', hide = true}, -- Slash (Cliff Strider Matriach)
    [85391] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)
    [85394] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)
    [85392] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds', hideReduce = true }, -- Slash (Cliff Strider Matriach)
    [85393] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)

    -- Daedra
    [51256] = { hide = true }, -- Siphon (Atronach Passive)
    [31115] = { icon = 'esoui/art/icons/achievement_089.dds', name = A.Skill_Summon_Daedric_Arch }, -- Summon Dark Anchor (Daedric Synergy)
    [59129] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity }, -- Generic Status Immune (Daedric Synergy)
    [94481] = { hide = true }, -- Summon Dark Anchor (Daedric Synergy)
    [68453] = { hide = true }, -- Explosive Charge (Daedric Synergy)
    [68449] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }, -- Explosive Charge (Daedric Synergy)
    [68452] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }, -- Explosive Charge (Daedric Synergy)
    [48092] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }, -- Swipe (Air Atronach)
    [48093] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }, -- Swipe (Air Atronach)
    [48096] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flare.dds' }, -- Flare (Air Atronach)
    [48121] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_heavy_attack.dds' }, -- Heavy Attack (Air Atronach)
    [48137] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_tornado.dds' }, -- Tornado (Air Atronach)
    [51269] = { hide = true }, -- Air Atronach Flame  (Air Atronach - Frost)
    [51267] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_frost.dds', name = A.Skill_Empower_Atronach_Frost }, -- Air Atronach Flame (Air Atronach - Frost)
    [50021] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds' }, -- Ice Vortex (Air Atronach - Frost)
    [50022] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Ice Vortex (Air Atronach - Frost)
    [51262] = { hide = true }, -- Air Atronach Flame (Air Atronach - Flame)
    [51265] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_flame.dds', name = A.Skill_Empower_Atronach_Flame }, -- Air Atronach Flame (Air Atronach - Flame)
    [51281] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }, -- Flame Tornado (Air Atronach)
    [51282] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }, -- Flame Tornado (Air Atronach)
    [51271] = { hide = true }, -- Air Atronach Flame (Air Atronach - Storm)
    [51270] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_storm.dds', name = A.Skill_Empower_Atronach_Storm }, -- Air Atronach Flame (Air Atronach - Storm)
    [50023] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds' }, -- Lightning Rod (Air Atronach)
    [88902] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds' }, -- Lightning Rod (Air Atronach)
    [50026] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Lightning Rod (Air Atronach)

    [9743] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_entropic_touch.dds' }, -- Entropic Touch (Banekin)
    [9747] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_dire_wound.dds' }, -- Dire Wound (Banekin)
    [9748] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }, -- Envelop (Banekin)
    [9749] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }, -- Envelop (Banekin)
    [4798] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt.dds' }, -- Headbutt (Clannfear)
    [4799] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike.dds' }, -- Tail Spike (Clannfear)
    [84443] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike.dds' }, -- Tail Spike (Clannfear)
    [93745] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Clannfear)
    [93750] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Clannfear)
    [93748] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds', name = A.Skill_Rending_Leap }, -- Rending Leap Ranged (Clannfear)
    [91395] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Devour (Clannfear)
    [91398] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds' }, -- Devour (Clannfear)
    [26551] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_strike.dds' }, -- Strike (Daedric Titan)
    [32852] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_ranged.dds' }, -- Scourge Bolt (Daedric Titan)
    [26641] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds' }, -- Soul Flame (Daedric Titan)
    [32696] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds' }, -- Soul Flame (Daedric Titan)
    [35280] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds' }, -- Soul Flame (Daedric Titan)
    [73437] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_gtaoe.dds' }, -- Soul Flame (Daedric Titan)
    [35278] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_gtaoe.dds' }, -- Soul Flame (Daedric Titan)
    [26554] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds' }, -- Wing Gust (Daedric Titan)
    [33085] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds' }, -- Wing Gust (Daedric Titan)
    [33086] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds' }, -- Wing Gust (Daedric Titan)
    [4750] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw.dds' }, -- Jagged Claw (Daedroth)
    [4778] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds' }, -- Fiery Jaws (Daedroth)
    [4771] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds', hide = true }, -- Fiery Breath (Daedroth)
    [4772] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds', hide = true }, -- Fiery Breath (Daedroth)
    [91946] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_tremor.dds', hide = true }, -- Ground Tremor (Daedroth)
    [91953] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_tremor.dds' }, -- Ground Tremor (Daedroth)
    [91949] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Ground Tremor (Daedroth)
    [91937] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds' }, -- Burst of Embers (Daedroth)
    [91941] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds', hide = true }, -- Burst of Embers (Daedroth)
    [91940] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds', hide = true }, -- Burst of Embers (Daedroth)
    [91943] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds' }, -- Burst of Embers (Daedroth)
    [91938] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_gtaoe.dds' }, -- Burst of Embers (Daedroth)
    [18471] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [18472] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [15157] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [12254] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [26324] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_lava_geyser.dds' }, -- Lava Geyser (Flame Atronach)
    [26325] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_lava_geyser.dds' }, -- Lava Geyser (Flame Atronach)
    [4491] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_radiance.dds' }, -- Radiance (Flame Atronach)
    [50216] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Combustion (Flame Atronach)
    [50215] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Combustion (Flame Atronach)
    [67870] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_tremor.dds', name = A.Skill_Tremor }, -- Tremor AOE (Flesh Colossus)
    [67123] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_tremor.dds' }, -- Tremor (Flesh Colossus)
    [67636] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_falling_debris.dds' }, -- Falling Debris (Flesh Colossus)
    [66869] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds' }, -- Pin (Flesh Colossus)
    [65709] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds' }, -- Pin (Flesh Colossus)
    [49820] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds', name = A.Skill_Pin }, -- Stunned (Flesh Colossus)
    [65735] = { hide = true }, -- Miasma Channel (Flesh Colossus)
    [53233] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_disease_gtaoe.dds' }, -- Miasma Pool (Flesh Colossus)
    [67872] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', hide = true }, -- Sweep (Flesh Colossus)
    [68824] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds' }, -- Sweep (Flesh Colossus)
    [68813] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', name = A.Skill_Sweep }, -- Sweep Knockback (Flesh Colossus)
    [68826] = { name = A.Innate_Stagger, hide = true }, -- Staggered (Flesh Colossus - Block Sweep)
    [67842] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Sweep Shockwave (Flesh Colossus)
    [76129] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_stumble_forward.dds' }, -- Stumble Forward (Flesh Colossus)
    [76134] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, hide = true }, -- Stumble Forward (Flesh Colossus)
    [65755] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, hide = true }, -- Staggered (Flesh Colossus)
    [76133] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, hide = true }, -- Stumble Forward (Flesh Colossus)
    [49430] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_smash.dds' }, -- Smash (Flesh Colossus)
    [49429] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_claw.dds' }, -- Claw (Flesh Colossus)
    [76128] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76139] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_stumble_forward.dds', hide = true }, -- Stumble Forward (Flesh Colossus)
    [76140] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76130] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76131] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76143] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [79001] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76145] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76146] = { hide = true }, -- Stumble Forward (Flesh Colossus) (Buff on Player)
    [67772] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage }, -- Enraged (Flesh Colossus)
    [63275] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_claw.dds' }, -- Claw (Flesh Atronach)
    [63276] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_stomp.dds' }, -- Stomp (Flesh Atronach)
    [4829] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_fire_brand.dds' }, -- Fire Brand (Flesh Atronach)
    [35413] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_fire_brand.dds' }, -- Fire Brand (Flesh Atronach)
    [4817] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds' }, -- Unyielding Mace (Flesh Atronach)
    [20226] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', name = A.Skill_Unyielding_Mace }, -- Stun (Flesh Atronach)
    [27326] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', hideReduce = true }, -- Unyielding Mace (Flesh Atronach)
    [23077] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', name = A.Skill_Unyielding_Mace }, -- Bleeding (Flesh Atronach)
    [17069] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_spear.dds' }, -- Ice Spear (Frost Atronach)
    [5009] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_shards.dds' }, -- Ice Shards (Frost Atronach)
    [33551] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds', internalStack = 0 }, -- Chilling Aura (Frost Atronach)
    [5017] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }, -- Hoarfrost Fist (Frost Atronach)
    [44906] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }, -- Hoarfrost Fist (Frost Atronach)
    [44907] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds', hide = true }, -- Hoarfrost Fist (Frost Atronach)
    [44908] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }, -- Hoarfrost Fist (Frost Atronach)
    [33502] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds' }, -- Frozen Ground (Frost Atronach)
    [51645] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds' }, -- Frozen Ground (Frost Atronach)
    [51646] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds', internalStack = 0, hide = true }, -- Frozen Ground (Frost Atronach)
    [65926] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_slash.dds' }, -- Slash (Grevious Twilight)
    [65845] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds' }, -- Rend (Grevious Twilight)
    [66643] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds' }, -- Rend (Grevious Twilight)
    [50596] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shadow_bolt.dds' }, -- Shadow Bolt (Grevious Twilight)
    [50626] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [50628] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [65889] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [65891] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [11076] = { icon = 'esoui/art/icons/ability_mage_029.dds', hide = true }, -- Chasten (Harvester)
    [11079] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_black_winter.dds', hide = true }, -- Black Winter (Harvester)
    [26008] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_black_winter.dds', hide = true }, -- Black Winter (Harvester)
    [74794] = { name = A.Innate_Stagger }, -- Black Winter (Harvester)
    [11083] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds' }, -- The Feast (Harvester)
    [26110] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds' }, -- The Feast (Harvester)
    [26017] = { hide = true }, -- Creeping Doom (The Feast)
    [26018] = { hide = true }, -- Creeping Doom (The Feast)
    [88070] = { hide = true }, -- Creeping Doom (The Feast)
    [8204] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_strike.dds' }, -- Strike (Ogrim)
    [8205] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_regeneration.dds' }, -- Regeneration (Ogrim)
    [48553] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', name = A.Skill_Body_Slam, hide = true },  -- Focused Charge (Ogrim)
    [24693] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', hide = true }, -- Body Slam (Ogrim)
    [24700] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds' }, -- Body Slam (Ogrim)
    [91848] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }, -- Stomp (Ogrim)
    [91850] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }, -- Stomp (Ogrim)
    [91851] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Stomp (Ogrim)
    [91855] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Ogrim)
    [91874] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Ogrim)
    [91871] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Ogrim)
    [6158] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Scamp)
    [6166] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Scamp)
    [6167] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Scamp)
    [6160] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_rain_of_fire.dds' }, -- Rain of Fire (Scamp)
    [6162] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_rain_of_fire.dds' }, -- Rain of Fire (Scamp)
    [8778] = { icon = 'LuiExtended/media/icons/abilities/ability_spiderdaedra_strike.dds' }, -- Strike (Spider Daedra)
    [8808] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', hide = true }, -- Spit (Spider Daedra)
    [8779] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Spider Daedra)
    [38658] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Spider Daedra)
    [8773] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_spiderling.dds' }, -- Summon Spiderling (Spider Daedra)
    [89303] = { hide = true }, -- Summon Spiderling (Spider Daedra)
    [89301] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon Spiderling (Spider Daedra)
    [89306] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds' }, -- Web (Spider Daedra - Spiderling)
    [89307] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', duration = 0 }, -- Web (Spider Daedra - Spiderling)
    [8782] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_storm.dds' }, -- Lightning Storm (Spider Daedra)
    [20530] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_storm.dds' }, -- Lightning Storm (Spider Daedra)
    [4858] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_bash.dds' }, -- Bash (Storm Atronach)
    [13898] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_strike.dds' }, -- Strike (Storm Atronach)
    [35220] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Storm Atronach)
    [35222] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Storm Atronach)
    [4864] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [35240] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [12287] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [12288] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', hideReduce = true }, -- Storm Bound (Storm Atronach)
    [12286] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [7095] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Xivilai)
    [83072] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_freezing_edge.dds' }, -- Freezing Edge (Xivilai)
    [49203] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_root_frost.dds' }, -- Frozen Weapon (Xivilai)
    [88947] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_pulse.dds' }, -- Lightning Grasp (Xivilai)
    [88949] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_pulse.dds' }, -- Lightning Grasp (Xivilai)
    [7100] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_hand_of_flame.dds'}, -- Hand of Flame (Xivilai)
    [25728] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_hand_of_flame.dds'}, -- Hand of Flame (Xivilai)
    [4652] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gaze.dds' }, -- Gaze (Watcher)
    [4653] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }, -- Shockwave (Watcher)
    [43817] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds', name = A.Skill_Shockwave }, -- Shockwave Snare (Watcher)
    [95855] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }, -- Shockwave (Watcher)
    [95856] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds', hide = true }, -- Shockwave (Watcher)
    [53880] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }, -- Shockwave (Watcher)
    [9219] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', hide = true }, -- Doom-Truth's Gaze (Watcher)
    [9220] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14518] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14425] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', hide = true }, -- Doom-Truth's Gaze (Watcher)
    [14426] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14546] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [12062] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds' }, -- Kick (Winged Twilight)
    [13690] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds' }, -- Kick (Winged Twilight)
    [6410] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_tail_clip.dds' }, -- Tail Clip (Winged Twilight)
    [63612] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_tail_clip.dds' }, -- Tail Clip (Winged Twilight)
    [6412] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_dusks_howl.dds' }, -- Dusk's Howl (Winged Twilight)
    [84825] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_slash.dds' }, -- Slash (Hunger)
    [84826] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_slash.dds' }, -- Slash (Hunger)
    [84827] = { hide = true }, -- Rake (Hunger)
    [84834] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_rake.dds' }, -- Rake (Hunger)
    [94903] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds' }, -- Spring (Hunger)
    [94908] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds', hide = true }, -- Spring (Hunger)
    [94907] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds' }, -- Spring (Hunger)
    [87237] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds' }, -- Spring (Hunger)
    [87242] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds', hide = true }, -- Spring (Hunger)
    [87241] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds' }, -- Spring (Hunger)
    [87247] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }, -- Devour (Hunger)
    [87988] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }, -- Devour (Hunger)
    [87252] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }, -- Devour (Hunger)
    [87253] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }, -- Devour (Hunger)
    [87251] = { hide = true }, -- Devour (Hunger)
    [87385] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds', hide = true }, -- Devour (Hunger)
    [87386] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }, -- Devour (Hunger)
    [87987] = { hide = true }, -- Devour (Hunger)
    [84944] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }, -- Hollow (Hunger)
    [91440] = { hide = true }, -- Hollow (Hunger)
    [91439] = { hide = true }, -- Hollow (Hunger)
    [84967] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }, -- Hollow (Hunger)
    [84988] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }, -- Hollow (Hunger)
    [84990] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }, -- Hollow (Hunger)
    [87269] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds', hide = true }, -- Torpor (Hunger)
    [87270] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor_aura.dds' }, -- Torpor (Hunger)
    [87538] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }, -- Torpor (Hunger)
    [87536] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }, -- Torpor (Hunger)
    [89751] = { hide = true }, -- Dispel Illusion (Hunger)
    [87271] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor_aura.dds' }, -- Torpor (Hunger)
    [87273] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor_aura.dds' }, -- Torpor (Hunger)
    [87639] = { hide = true }, -- Fade (Hunger)
    [91433] = { hide = true }, -- Fade (Voracity - Hunger Boss)
    [89030] = { hide = true }, -- Subduction (Iron Atronach)
    [88246] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_iron_hand.dds' }, -- Iron Hand (Iron Atronach)
    [88247] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_eruption.dds' }, -- Eruption (Iron Atronach)
    [88282] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp.dds' }, -- Rock Stomp (Iron Atronach)
    [88286] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp.dds' }, -- Rock Stomp (Iron Atronach)
    [88295] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp_ranged.dds' }, -- Rock Stomp (Iron Atronach)
    [88261] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds' }, -- Lava Wave (Iron Atronach)
    [88266] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds', hide = true }, -- Lava Wave (Iron Atronach)
    [95281] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds', hide = true }, -- Lava Wave (Iron Atronach)
    [89258] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_blast_furnace.dds', hide = true }, -- Subduction (Iron Atronach)
    [88297] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_blast_furnace.dds', hide = true }, -- Blast Furnace (Iron Atronach)
    [88323] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_blast_furnace.dds', hide = true }, -- Blast Furnace (Iron Atronach)

    -- Dwemer
    [7484] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_blade.dds' }, -- Blade (Dwemer Sphere)
    [7485] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_dart.dds' }, -- Dart (Dwemer Sphere)
    [16031] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Richochet Wave (Dwemer Sphere)
    [29832] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Richochet Wave (Dwemer Sphere)
    [7520] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_steam_wall.dds' }, -- Steam Wall (Dwemer Sphere)
    [84216] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_steam_wall.dds' }, -- Steam Wall (Dwemer Sphere)
    [7544] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_quake.dds' }, -- Quake (Dwemer Sphere)
    [46053] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_quake.dds' }, -- Quake (Dwemer Sphere)

    [11245] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_axe.dds' }, -- Axe (Dwemer Centurion)
    [13783] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_hammer.dds' }, -- Hammer (Dwemer Centurion)
    [11247] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }, -- Sweeping Spin (Dwemer Centurion)
    [43554] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }, -- Sweeping Spin (Dwemer Centurion)
    [11262] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }, -- Sweeping Spin (Dwemer Centurion)
    [11246] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds', hide = true }, -- Steam Breath (Dwemer Centurion)
    [11282] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds' }, -- Steam Breath (Dwemer Centurion)

    [7719] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }, -- Shocking Touch (Dwemer Spider)
    [20507] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_double_strike.dds' }, -- Double Strike (Dwemer Spider)
    [20508] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_double_strike.dds' }, -- Double Strike (Dwemer Spider)

    [7717] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Detonation (Dwemer Spider)
    [15206] = { hide = true }, -- Detonation (Dwemer Spider)
    [84019] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Detonation (Dwemer Spider)
    [13536] = { hide = true }, -- Detonation (Dwemer Spider)

    [64423] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Sparks (Dwemer Sentry)
    [84312] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds' }, -- Static Shield (Dwemer Sentry)
    [70133] = { hide = true }, -- Static Shield
    [64556] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds', name = A.Skill_Static_Shield }, -- Static Eruption (Dwemer Sentry)
    [64460] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds' }, -- Static Shield (Dwemer Sentry)
    [70134] = { hide = true }, -- Static Shield (Dwemer Sentry)
    [68790] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds', name = A.Skill_Static_Shield }, -- Static Shield Explosion (Dwemer Sentry)
    [64479] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Thunderbolt (Dwemer Sentry)
    [64543] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', hide = true }, -- Thunderbolt (Dwemer Sentry)
    [64489] = { hide = true }, -- Find Turret (Dwemer Sentry)
    [64508] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_turret_mode.dds', name = A.Skill_Turret_Mode }, -- Turret Mode (Dwemer Sentry)

    [85242] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_dart.dds', name = A.Skill_Dart, hide = true }, -- Quick Shot (Dwemer Arquebus)
    [85255] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_shock_blast.dds' }, -- Shock Blast (Dwemer Arquebus)
    [88668] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_impulse_mine.dds' }, -- Impulse Mine (Dwemer Arquebus)
    [88728] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_impulse_mine.dds' }, -- Impulse Mine (Dwemer Arquebus)
    [85270] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_torrent.dds' }, -- Shock Barrage (Dwemer Arquebus)
    [85288] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_torrent.dds', hide = true }, -- Shock Barrage (Dwemer Arquebus)
    [91013] = { hide = true }, -- Shock Barrage (Dwemer Arquebus)
    [85319] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds', name = A.Skill_Split_Bolt, hide = true }, -- Siege Ballista (Dwemer Arquebus)
    [91093] = { hide = true }, -- Split Bolt (Dwemer Arquebus)
    [91094] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds' }, -- Split Bolt (Dwemer Arquebus)
    [91095] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds' }, -- Split Bolt (Dwemer Arquebus)
    [91096] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds' }, -- Split Bolt (Dwemer Arquebus)

    [85326] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_polarizing_field.dds', hide = true }, -- Polarizing Field (Dwemer Arquebus)
    [85327] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_polarizing_field.dds', duration = 0 }, -- Polarizing Field (Dwemer Arquebus)
    [85334] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds', hide = true }, -- Polarizing Field (Dwemer Arquebus)

    [20238] = { hide = true }, -- Move Back (Dwemer Spider - Overcharge Synergy)
    [19970] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_static_field.dds' }, -- Static Field (Dwemer Spider)
    [19997] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_static_field.dds', hide = true }, -- Static Field (Dwemer Spider)
    [20506] = { hide = true }, -- Overcharge Trigger (Dwemer Spider - Overcharge Synergy)
    [27333] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge Trigger (Dwemer Spider - Overcharge Synergy)
    [27458] = { hide = true }, -- tell others (Dwemer Spider - Overcharge Synergy)
    --[20207] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20206] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20221] = { hide = true }, -- Overcharge (Dwemer Spider - Overcharge Synergy)

    [20505] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds', hide = true }, -- Overcharge (Overcharge)
    [20222] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds', hide = true }, -- Overcharge (Overcharge)
    [20504] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Overcharge)
    [20220] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Overcharge)
    [52679] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Overcharge)
    [52680] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Overcharge)

    ------------ FIX LATER ------------
    --[27333] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Dwemer Spider)
    --[20206] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Dwemer Spider)
    --[19997] = { hide = true }, -- Static Field (Dwemer Spider)
    --[20506] = { hide = true }, -- Overcharge Trigger (Dwemer Spider) (Duplicate Aura)
    --[20221] = { hide = true }, -- Overcharge (Dwemer Spider) (Duplicate Aura)

    -- Insects
    [5278] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_bite.dds' }, -- Bite (Assassin Beetle)
    [6137] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = A.Skill_Lacerate }, -- Laceration (Assassin Beetle)
    [51736] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = A.Skill_Lacerate }, -- Bleeding (Assassin Beetle)
    [51735] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = A.Skill_Lacerate }, -- Bleeding (Assassin Beetle)
    [5268] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_collywobbles.dds' }, -- Collywobbles (Assassin Beetle)
    [91789] = { hide = true }, -- Ambush (Assassin Beetle)
    [91791] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_feast.dds' }, -- Feast (Assassin Beetle)
    [13680] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_gtaoe.dds' }, -- Acid Blood (Assassin Beetle)
    [6754] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_pincer.dds' }, -- Pincer (Giant Scorpion)
    [6755] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds' }, -- Sting (Giant Scorpion)
    [13671] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds' }, -- Sting (Giant Scorpion)
    [6757] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }, -- Blurred Strike (Giant Scorpion)
    [9040] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }, -- Blurred Strike (Giant Scorpion)
    [6756] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds' }, -- Paralyze (Giant Scorpion)
    [12312] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds', name = A.Skill_Paralyze }, -- Snare (Giant Scorpion)
    [6758] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_hardened_carapace.dds' }, -- Hardened Carapace (Giant Scorpion)
    [4731] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_bite.dds' }, -- Bite (Giant Spider)
    [44086] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds', name = A.Skill_Poisonous_Burst }, -- Poisonous Burst (Giant Spider)
    [5790] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Poisonous Burst (Giant Spider)
    [5685] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds' }, -- Corrosive Bite (Giant Spider)
    [8087] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }, -- Poison Spray (Giant Spider)
    [8088] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }, -- Poison Spray (Giant Spider)
    [4730] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds' }, -- Spit (Giant Spider)
    [4737] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = A.Skill_Web }, -- Encase (Giant Spider)
    [47318] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = A.Skill_Web, duration = 0 }, -- Encase (Giant Spider)
    [13382] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_devour.dds' }, -- Devour (Giant Spider)
    [9225] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_bite.dds' }, -- Bite (Giant Wasp)
    [9226] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_sting.dds' }, -- Sting (Giant Wasp)
    [9229] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds' }, -- Inject Larva (Giant Wasp)
    [9237] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', name = A.Skill_Inject_Larva, unbreakable = 1 }, -- Larva Gestation (Giant Wasp)
    [9238] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_larva_burst.dds' }, -- Larva Burst (Giant Wasp)
    [48559] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = A.Skill_Zoom, hide = true }, -- Charge (Giant Wasp)
    [25119] = { hide = true }, -- Charge (Giant Wasp)
    [25113] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = A.Skill_Zoom }, -- Charge (Giant Wasp)
    [25120] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = A.Skill_Zoom }, -- Charge (Giant Wasp)
    [25112] = { hide = true }, -- Charge (Giant Wasp)
    [6788] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bite.dds' }, -- Bite (Hoarvor)
    [6800] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }, -- Bloodletting (Hoarvor)
    [42292] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }, -- Bloodletting (Hoarvor)
    [6795] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds' }, -- Latch On (Hoarvor)
    [13585] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds' }, -- Latch On (Hoarvor)
    [61243] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds' }, -- Vile Bite (Hoarvor DLC)
    [69392] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds', name = A.Skill_Vile_Bite }, -- Vile Bite Poison (Hoarvor DLC)
    [61244] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds' }, -- Fevered Retch (Hoarvor DLC)
    [61245] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds' }, -- Fevered Retch (Hoarvor DLC)
    [61360] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61377] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61372] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61374] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61376] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_poison.dds', hide = true }, -- Infectious Swarm (Hoarvor DLC)
    [61375] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_poison.dds', name = A.Skill_Infectious_Swarm }, -- Infectious Swarm (Hoarvor DLC)
    [61427] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds' }, -- Necrotic Explosion (Hoarvor DLC)
    [61249] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', hide = true }, -- Necrotic Explosion (Hoarvor DLC)
    [61388] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', name = A.Skill_Necrotic_Explosion, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Necrotic Explosion Snare (Hoarvor DLC)
    [83977] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamascrib_bite.dds' }, -- Bite (Kwama Scrib)
    [8272] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', name = A.Skill_Contagion, hide = true }, -- Spit (Kwama Scrib)
    [47838] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds' }, -- Contagion (Kwama Scrib)
    [42869] = { hide = true }, -- Burrow (Kwama Scrib)
    [9287] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_bite.dds' }, -- Bite (Kwama Worker)
    [9291] = { hide = true }, -- Pounce (Kwama Worker)
    [83953] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_pounce.dds' }, -- Pounce (Kwama Worker)
    [14839] = { hide = true }, -- Charge (Kwama Worker)
    [14841] = { hide = true}, -- Charge (Kwama Worker)
    [48539] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, hide = true }, -- Charge (Kwama Worker)
    [14846] = { hide = true }, -- Charge (Kwama Worker)
    [18808] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, hide = true }, -- Charge (Kwama Worker)
    [18810] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow }, -- Charge (Kwama Worker)
    [14844] = { hide = true }, -- Charge (Kwama Worker)
    [14845] = { hide = true }, -- Charge (Kwama Worker)
    [18814] = { hide = true }, -- Charge (Kwama Worker)
    [18546] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds', duration = 0 }, -- Shattered Ground (Kwama Worker)
    [15011] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_swipe.dds' }, -- Swipe -- Kwama Warrior
    [9763] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }, -- Smash -- Kwama Warrior
    [9764] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }, -- Smash -- Kwama Warrior
    [9769] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds' }, -- Excavation -- Kwama Warrior
    [18585] = { hide = true },  -- Excavation -- Kwama Warrior
    [27463] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds' }, -- Excavation -- Kwama Warrior
    [49192] = { hide = true }, -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)
    [18567] = { hide = true }, -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)
    [6127] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_bite.dds' }, -- Bite (Shalk)
    [5260] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds', name = A.Skill_Fiery_Breath }, -- Fiery Breath (Shalk)
    [10947] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds' }, -- Fiery Breath (Shalk)
    [5252] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds' }, -- Fire Bite (Shalk)
    [6129] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds' }, -- Fire Bite (Shalk)
    [5265] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_burning_ground.dds' }, -- Burning Ground (Shalk)
    [5308] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunder_bite.dds' }, -- Thunder Bite (Thunderbug)
    [8429] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds' }, -- Zap (Thunderbug)
    [65079] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds' }, -- Zap (Thunderbug)
    [26379] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Zap (Thunderbug)

    [26382] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds' }, -- Bolt (Thunderbug)
    [26412] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunderstrikes.dds' }, -- Thunderstrikes (Thunderbug)
    [34980] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunderstrikes.dds' }, -- Thunderstrikes (Thunderbug)
    [73166] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds', name = A.Skill_Leeching_Bite }, -- Bite (Kotu Gava)
    [73214] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds', name = A.Skill_Leeching_Bite }, -- Bite (Kotu Gava)
    [73215] = { hide = true }, -- Bite (Kotu Gava)
    [73184] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', hide = true }, -- Vile Spit (Kotu Gava Broodmother)
    [73172] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarm (Kotu Gava Broodmother)
    [73173] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarm (Kotu Gava Broodmother)
    [73193] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarm (Kotu Gava Broodmother)
    [73177] = { hide = true }, -- Swarmburst (Kotu Gava Broodmother)
    [73174] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [73175] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [73176] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [76579] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds', name = A.Skill_Leeching_Bite }, -- Bite (Kotu Gava Spawn)
    [76580] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds', name = A.Skill_Leeching_Bite }, -- Bite (Kotu Gava Spawn)
    [76581] = { hide = true }, -- Bite (Kotu Gava Spawn)
    [73199] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarmburst.dds' }, -- Swarmburst (Kotu Gava Broodmother)
    [73200] = { hide = true }, -- Swarmburst (Kotu Gava Broodmother)
    [73195] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73196] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73197] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73194] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_slime_alt.dds' }, -- Swarmburst (Kotu Gava Broodmother)
    [73198] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarmburst.dds' }, -- Swarmburst (Kotu Gava Broodmother)
    [87022] = { hide = true }, -- Summon Swarm (Fetcherfly Nest)
    [85524] = { hide = true }, -- Ashen Wind (Fetcherfly Swarm)
    [85525] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }, -- Ashen Wind (Fetcherfly Swarm)
    [85526] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }, -- Ashen Cloud (Fetcherfly Swarm)
    [85645] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_bombard.dds' }, -- Bombard (Fectherfly Nest)
    [85646] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_bombard.dds', name = A.Skill_Bombard }, -- Bomb (Fectherfly Nest)
    [87125] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_heat_vents.dds', hide = true }, -- Heat Vents (Fetcherfly Nest)
    [87126] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_heat_vents.dds' }, -- Heat Vents (Fetcherfly Nest)
    [92083] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_slam.dds' }, -- Slam (Fetcherfly Hive Golem)
    [87095] = { hide = true }, -- Colonize (Fetcherfly Hive Golem)
    [92078] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_colonize.dds', name = A.Skill_Fetcherfly_Colony }, -- Colonize (Fetcherfly Hive Golem)
    [92079] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_colonize.dds' }, -- Colonize (Fetcherfly Hive Golem)
    [92081] = { hide = true }, -- Colonize (Fetcherfly Hive Golem)
    [87062] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }, -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [92075] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }, -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [87030] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_focused_swarm.dds' }, -- Focused Swarm (Fetcherfly Hive Golem)
    [87031] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_focused_swarm.dds' }, -- Focused Swarm (Fetcherfly Hive Golem)

    -- Monsters
    [10259] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }, -- Double Swipe (Gargoyle)
    [32672] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }, -- Double Swipe (Gargoyle)
    [10270] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds' }, -- Quake (Gargoyle)
    [10271] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds' }, -- Quake (Gargoyle)
    [10256] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds' }, -- Lacerate (Gargoyle)
    [25716] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds', name = A.Skill_Lacerate }, -- Stun (Gargoyle)
    [25718] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds', name = A.Skill_Lacerate }, -- Stun (Gargoyle)
    [25714] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds' }, -- Vampiric Touch (Gargoyle)
    [46845] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_sweep.dds' }, -- Sweep (Giant)
    [8674] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_kick.dds' }, -- Sweep (Giant)
    [26124] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds' }, -- Shatter (Giant)
    [26129] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds', hide = true }, -- Shatter (Giant)
    [15715] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds' }, -- Obliterate (Giant)
    [43743] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds' }, -- Obliterate (Giant)
    [43742] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds' }, -- Obliterate (Giant)
    [2901] = { icon = 'LuiExtended/media/icons/abilities/ability_hag_staff_strike.dds' }, -- Staff Strike (Hag)
    [2786] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_steal_essence.dds' }, -- Steal Essence (Hag)
    [21642] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_steal_essence.dds' }, -- Steal Essence (Hag)
    [3349] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_reflective_shadows.dds' }, -- Reflective Shadows (Hag)
    [2821] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_luring_snare.dds', hide = true }, -- Luring Snare (Hag)
    [32267] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_luring_snare.dds', name = A.Skill_Luring_Snare }, -- Grapple (Hag)
    [10611] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_ranged.dds' }, -- Flare (Hagraven)
    [10615] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_raven_storm.dds' }, -- Raven Storm (Hagraven)
    [10616] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_raven_storm.dds' }, -- Raven Storm (Hagraven)
    [12426] = { name = A.Innate_Stagger }, -- Raven Storm (Hagraven)
    [10613] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_aoe_alt.dds' }, -- Fire Bomb (Hagraven)
    [10614] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_aoe_alt.dds' }, -- Fire Bomb (Hagraven)
    [64806] = { hide = true }, -- Briarheart Resurrection (Hagraven)
    [64808] = { icon = 'esoui/art/icons/ability_healer_028.dds', duration = 2.5 }, -- Briarheart Resurrection (Hagraven)
    [65027] = { icon = 'esoui/art/icons/ability_healer_028.dds' }, -- Briarheart Resurrection (Hagraven)

    [4112] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_talon.dds' }, -- Talon (Harpy)
    [4125] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_kick.dds' }, -- Kick (Harpy)
    [24551] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_zap.dds' }, -- Bolt (Harpy)
    [4684] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_zap.dds' }, -- Bolt (Harpy)
    [4123] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wing_slice.dds' }, -- Wing Slice (Harpy)
    [24369] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wing_slice.dds' }, -- Wing Slice (Harpy)
    [13515] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds' }, -- Wind Gust (Harpy)
    [13516] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds' }, -- Wind Gust (Harpy)
    [13517] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds' }, -- Wind Gust (Harpy)
    [24604] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_charged_ground.dds' }, -- Charged Ground (Harpy)
    [8628] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_charged_ground.dds' }, -- Charged Ground (Harpy)
    [4689] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Harpy)
    [4690] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Harpy)

    [9846] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_bite.dds' }, -- Bite (Ice Wraith)
    [43809] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds' }, -- Shard Burst (Ice Wraith)
    [43810] = { hide = true }, -- Shard Burst (Ice Wraith)
    [38920] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds' }, -- Shard Burst (Ice Wraith)
    [24877] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds' }, -- Shard Burst (Ice Wraith)
    [48549] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds', name = A.Skill_Assault, hide = true }, -- Focused Charge (Ice Wraith)
    [24869] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds', name = A.Skill_Assault }, -- Blood in the Water (Ice Wraith)
    [46563] = { icon = 'esoui/art/icons/ability_mage_020.dds' }, -- Blood in the Water (Ice Wraith)

    [14801] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds', hide = true }, -- Flare (Imp - Fire)
    [14802] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds', hide = true }, -- Fireball (Imp - Fire)
    [17703] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_flame_ray.dds' }, -- Flame Ray (Imp - Fire)
    [65078] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_flame_ray.dds' }, -- Flame Ray (Imp - Fire)
    [17706] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_flamestrike.dds' }, -- Flame Ray (Imp - Fire)

    [7732] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Bolt (Imp - Lightning)
    [13648] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Spark (Imp - Lightning)
    [8884] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_zap.dds' }, -- Zap (Imp - Lightning)
    [65077] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_zap.dds' }, -- Zap (Imp - Lightning)
    [14666] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Zap (Imp - Lightning)

    [88906] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_ranged.dds', hide = true }, -- Frost Bolt (Imp - Frost)
    [88918] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_ranged.dds', hide = true }, -- Frostball (Imp - Frost)

    [81794] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_frost_ray.dds' }, -- Frost Ray (Imp - Frost)
    [88907] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_frost_ray.dds', hide = true }, -- Frost Ray (Imp - Frost)
    [88915] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Frost Ray (Imp - Frost)
    [88908] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winterborn.dds' }, -- Frost Ray (Imp - Frost)

    [9670] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_strike.dds' }, -- Strike (Lamia)
    [9671] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_howling_strike.dds' }, -- Howling Strike (Lamia)
    [89382] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_howling_strike.dds' }, -- Howling Strike (Lamia)
    [9674] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Resonate (Lamia)
    [23281] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Resonate (Lamia)
    [7830] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_shockwave.dds', hide = true }, -- Shockwave (Lamia)
    [12074] = { hide = true }, -- Summon Spectral Lamia (Lamia)
    [9680] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_summon_spectral_lamia.dds' }, -- Summon Spectral Lamia (Lamia)
    [89399] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon Spectral Lamia (Lamia)
    [7835] = { icon = 'esoui/art/icons/ability_healer_033.dds', hide = true }, -- Convalescence (Lamia)
    [7831] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_harmony.dds' }, -- Harmony (Lamia)
    [24745] = { hide = true }, -- Harmony (Lamia)
    [23358] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_harmony.dds' }, -- Harmony (Lamia)
    [24814] = { hide = true }, -- Harmony (Lamia)

    [3757] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw.dds' }, -- Claw (Lurcher)
    [3860] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize.dds' }, -- Pulverize (Lurcher)
    [32698] = { name = A.Innate_Stagger }, -- Pulverize (Lurcher)
    [3855] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs.dds' }, -- Crushing Limbs (Lurcher)
    [38554] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs.dds', name = A.Skill_Crushing_Limbs }, -- Crushing Limbs (Lurcher)
    [3767] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen.dds', hide = true }, -- Choking Pollen (Lurcher)
    [4769] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen.dds' }, -- Choking Pollen (Lurcher)

    [5520] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_ranged.dds', hide = true }, -- Frost Bolt (Nereid)
    [5559] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds' }, -- Icy Geyser (Nereid)
    [11024] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds' }, -- Icy Geyser (Nereid)
    [5540] = { icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', hide = true }, -- Hurricane (Nereid)
    [16040] = { icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds' }, -- Hurricane (Nereid)
    [33459] = { icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds' }, -- Hurricane (Nereid)

    [5254] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_punch.dds' }, -- Punch (Ogre)
    [5257] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_backhand.dds' }, -- Backhand (Ogre)
    [5881] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Smash (Ogre)
    [24948] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Smash (Ogre)
    [34627] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Smash (Ogre)
    [24949] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Smash (Ogre)
    [34614] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds' }, -- Smash (Ogre)
    [5256] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Shockwave (Ogre)
    [34616] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Shockwave (Ogre)
    [5349] = { hide = true }, -- Stagger (Ogre - Shockwave)
    [8069] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds' }, -- Intimidating Roar (Ogre)
    [24985] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage }, -- Intimidating Roar (Ogre)

    [53136] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [65434] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [53773] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [53774] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [65469] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [65470] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [53142] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_ice_pillar.dds' }, -- Ice Pillar (Ogre Shaman)
    [74457] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_ice_pillar.dds' }, -- Ice Pillar (Ogre Shaman)
    [34385] = { hide = true }, -- Generic AOE (Ogre Shaman)
    [53966] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_ice_pillar.dds', duration = 0 }, -- Ice Pillar Chill (Ogre Shaman)
    [54327] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_root_frost.dds', name = A.Skill_Frozen }, -- Winter's Reach (Ogre Shaman)
    [64540] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_freeze_wounds.dds' }, -- Freeze Wounds (Ogre Shaman)
    [53137] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_freeze_wounds.dds' }, -- Freeze Wounds (Ogre Shaman)

    [2986] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_lacerate.dds' }, -- Lacerate (Spriggan)
    [21582] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm.dds' }, -- Nature's Swarm (Spriggan)
    [31699] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm.dds' }, -- Nature's Swarm (Spriggan)
    [13475] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_healing_salve.dds' }, -- Healing Salve (Spriggan)
    [89083] = { hide = true }, -- Healing Salve (Spriggan)
    [89084] = { hide = true }, -- Healing Salve (Spriggan)
    [89085] = { hide = true }, -- Healing Salve (Spriggan)

    [89143] = { hide = true }, -- Summon Beast (Spriggan)
    [89119] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast.dds' }, -- Summon Beast (Spriggan)
    [89102] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_tiger.dds' }, -- Summon Beast (Spriggan)
    [89157] = { hide = true }, -- Summon Beast (Spriggan)
    [89158] = { hide = true }, -- Summon Beast (Spriggan)
    [89159] = { hide = true }, -- Summon Beast (Spriggan)
    [89151] = { hide = true }, -- Summon Beast (Spriggan)
    [89154] = { hide = true }, -- Summon Beast (Spriggan)
    [89168] = { hide = true }, -- Summon Beast (Spriggan)
    [89170] = { hide = true }, -- Summon Beast (Spriggan)
    [89127] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon Beast (Spriggan)
    [21570] = { hide = true }, -- Backstep (Spriggan)
    [13477] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_control_beast.dds' }, -- Control Beast (Spriggan)

    [42793] = { hide = true }, -- Strangler: (Strangler)
    [42794] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Bash_Stun, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Strangler: (Strangler)
    [9320] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_strike.dds' }, -- Strike (Strangler)
    [14219] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds' }, -- Spit (Strangler)
    [9346] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_strangle.dds' }, -- Strangle (Strangler)
    [42211] = { hide = true }, -- Strangle (Strangler)
    [9322] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_poisoned_ground.dds' }, -- Poisoned Ground (Strangler)
    [9323] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_poisoned_ground.dds' }, -- Poisoned Ground (Strangler)
    [9321] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds' }, -- Grapple (Strangler)
    [9707] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds' }, -- Grapple (Strangler)
    [64132] = { hide = true }, -- Grapple Immunity (Strangler)

    [8926] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_regeneration.dds' }, -- Regeneration (Troll)
    [61225] = { hide = true }, -- Regeneration (Troll)
    [8925] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_slap.dds' }, -- Slap (Troll)
    [44736] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds', hide = true }, -- Swinging Cleave (Troll)
    [44737] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds' }, -- Swinging Cleave (Troll)
    [9009] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds', hide = true }, -- Tremor (Troll)
    [9011] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds' }, -- Tremor (Troll)

    [76266] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_rip.dds' }, -- Rip (River Troll)
    [76268] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }, -- Lope (River Troll)
    [78834] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }, -- Lope (River Troll)
    [76274] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Lope (River Troll)

    [76277] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_close_wounds.dds' }, -- Close Wounds (River Troll)
    [76295] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_crab_toss.dds' }, -- Crab Toss (River Troll)
    [80506] = { hide = true }, -- Crab Toss (River Troll)
    [76297] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_crab_toss.dds' }, -- Crab Toss (River Troll)
    [76298] = { hide = true }, -- Crab Toss (River Troll)
    [81045] = { hide = true }, -- Crab Toss (River Troll)
    [76300] = { hide = true }, -- Scuttle (River Troll)

    [48253] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_rock_toss.dds' }, -- Rock Toss (Troll - Ranged)
    [60549] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_rock_toss.dds' }, -- Rock Toss (Troll - Ranged)
    [48256] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Troll - Ranged)
    [48257] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Troll - Ranged)
    [50387] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Troll - Ranged)
    [48282] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds' }, -- Consuming Omen (Troll - Ranged)

    [48287] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds', hide = true }, -- Consuming Omen (Troll - Ranged)
    [48294] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Consuming Omen (Troll - Ranged)
    [48297] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds' }, -- Consuming Omen (Troll - Ranged)

    [4304] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_assault.dds' }, -- Assault (Wisp)
    [18634] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_assault.dds' }, -- Assault (Wisp)
    [4309] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_dying_blast.dds' }, -- Dying Blast (Wisp)
    [64221] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_dying_blast.dds' }, -- Dying Blast (Wisp)

    [7976] = { icon = 'LuiExtended/media/icons/abilities/ability_wispmother_rain_of_wisps.dds' }, -- Rain of Wisps (Wispmother)
    [64211] = { hide = true }, -- Summon Wisp (Wispmother)
    [8025] = { hide = true },-- Rain of Wisps (Wispmother)
    [19043] = { hide = true },-- Rain of Wisps (Wispmother)
    [19050] = { hide = true },-- Rain of Wisps (Wispmother)
    [19056] = { hide = true },-- Rain of Wisps (Wispmother)
    [61204] = { hide = true },-- Rain of Wisps Tracker (Wispmother)
    [19061] = { icon = 'LuiExtended/media/icons/abilities/ability_wispmother_rain_of_wisps.dds' }, -- Rain of Wisps (Wispmother)
    [18040] = { icon = 'LuiExtended/media/icons/abilities/ability_wispmother_clone.dds' }, -- Clone (Wispmother)
    [18049] = { icon = 'LuiExtended/media/icons/abilities/ability_wispmother_clone.dds' }, -- Clone (Wispmother)
    [18060] = { hide = true }, -- Clone (Wispmother)

    [75863] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_chop.dds' }, -- Chop (Minotaur)
    [75865] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_cleave.dds' }, -- Cleave (Minotaur)
    [75867] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_clobber.dds' }, -- Clobber (Minotaur)
    [80440] = { hide = true }, -- Clobber (Minotaur)
    [80014] = { hide = true }, -- Clobber (Minotaur)
    [75868] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_clobber.dds' }, -- Clobber (Minotaur)
    [75917] = { icon = 'esoui/art/icons/achievement_update15_015.dds' }, -- Ram (Minotaur)
    [75921] = { icon = 'esoui/art/icons/achievement_update15_015.dds' }, -- Ram (Minotaur)
    [75919] = { icon = 'esoui/art/icons/achievement_update15_015.dds' }, -- Ram (Minotaur)
    [75922] = { icon = 'esoui/art/icons/achievement_update15_015.dds' }, -- Ram (Minotaur)
    [79541] = { icon = 'esoui/art/icons/achievement_update15_022.dds', hide = true }, -- Flying Leap (Minotaur)
    [79539] = { icon = 'esoui/art/icons/achievement_update15_022.dds' }, -- Flying Leap (Minotaur)
    [75925] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_elemental_weapon.dds' }, -- Elemental Weapon (Minotaur)
    [75928] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe_alt.dds', hide = true }, -- Elemental Pool (Minotaur)
    [75933] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_heat_wave.dds', hide = true }, -- Elemental Wave (Minotaur)

    [75949] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fiery_surge.dds', hide = true }, -- Fiery Surge (Minotaur Shaman)
    [77989] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fiery_surge.dds', hide = true }, -- Flame Wave (Minotaur Shaman)
    [75951] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_snare_fire.dds' }, -- Brimstone Hailfire (Minotaur Shaman)
    [75953] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_snare_fire.dds', hide = true }, -- Brimstone Hailfire (Minotaur Shaman)
    [75954] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_snare_fire.dds', duration = 0}, -- Brimstone Hailfire (Minotaur Shaman)
    [75955] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Pillars of Nirn (Minotaur Shaman)
    [75980] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', name = A.Skill_Pillars_of_Nirn }, -- Pillars Eruption (Minotaur Shaman)
    [75976] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', name = A.Skill_Pillars_of_Nirn, hide = true }, -- Pillar of Nirn (Minotaur Shaman)
    [75978] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', name = A.Skill_Pillars_of_Nirn }, -- Pillar Explosion (Minotaur Shaman)
    [75994] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_molten_armor.dds' }, -- Molten Armor (Minotaur Shaman)

    [49395] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_punch.dds', name = A.Skill_Claw }, -- Punch (Mantikora)
    [49397] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_sweep.dds' }, -- Spear Sweep (Mantikora)
    [49499] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds' }, -- Spear Throw (Mantikora)
    [51231] = { hide = true }, -- locomotion override (Mantikora)
    [53836] = { hide = true }, -- Spear Throw (Mantikora)
    [49505] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds' }, -- Spear Throw (Mantikora)
    [49500] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds' }, -- Spear Throw (Mantikora)
    [53834] = { hide = true }, -- Get Spear Out (Mantikora)
    [49404] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_rear_up.dds' }, -- Rear Up (Mantikora)
    [49406] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_rear_up.dds' }, -- Rear Up (Mantikora)
    [49405] = { name = A.Innate_Stagger }, -- Rear Up (Mantikora)
    [49402] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_tail_whip.dds' }, -- Tail Whip (Mantikora)
    [49403] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_tail_whip.dds' }, -- Tail Whip (Mantikora)
    [51242] = { hide = true }, -- Enrage (Mantikora)
    [50187] = { icon = 'esoui/art/icons/ability_warrior_025.dds' }, -- Enrage (Mantikora)
    [56687] = { hide = true }, -- Enrage (Mantikora)
    [56688] = { hide = true }, -- Enrage (Mantikora)
    [87712] = { hide = true }, -- Enraged (Mantikora)
    [56689] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage }, -- Enraged (Mantikora)

    -- Undead
    [38829] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_desecrated_ground_bonus.dds', name = A.Skill_Desecrated_Ground, duration = 0 }, -- Desecrated Ground Bonus
    [38834] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_desecrated_ground_snare.dds', name = A.Skill_Desecrated_Ground }, -- Desecrated Ground Snare (Desecrated Ground - Undead Synergy)
    [69950] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_desecrated_ground_snare.dds' }, -- Desecrated Ground (Desecrated Ground - Undead Synergy)
    [8550] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_slash.dds' }, -- Slash (Bloodfiend)
    [8551] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_slash.dds' }, -- Slash (Bloodfiend)
    [8564] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_rending_slash.dds' }, -- Rending Slash (Bloodfiend)
    [9194] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_flurry.dds' }, -- Flurry (Bloodfiend)
    [8569] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_devastating_leap.dds' }, -- Devastating Leap (Bloodfiend)
    [32023] = { name = A.Innate_Stagger }, -- Generic Stagger Enemy (Bloodfiend)
    [5028] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_strike.dds' }, -- Strike (Bone Colossus)
    [5050] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', name = A.Skill_Colossal_Stomp }, -- Bone Saw (Bone Colossus)
    [30590] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', name = A.Skill_Colossal_Stomp }, -- Bone Saw (Bone Colossus)
    [17206] = { name = A.Innate_Stagger, hide = true }, -- Bone Saw (Bone Colossus)
    [5044] = { hide = true }, -- Risen Dead (Bone Colossus)
    [17221] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Slap (Bone Colossus - Risen Dead)
    [17207] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds', hide = true }, -- Necromantic Implosion (Bone Colossus - Risen Dead)
    [88828] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds' }, -- Necromantic Implosion (Bone Colossus - Risen Dead)
    [89533] = { hide = true }, -- Necromantic Implosion (Bone Colossus - Risen Dead)
    [8812] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds' }, -- Double Strike (Ghost)
    [8813] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds' }, -- Double Strike (Ghost)
    [18514] = { icon = 'esoui/art/icons/ability_mage_052.dds' }, -- Chill Touch (Ghost)
    [18515] = { icon = 'esoui/art/icons/ability_mage_052.dds' }, -- Chill Touch (Ghost)
    [19137] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds' }, -- Haunting Spectre (Ghost)
    [19138] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds' }, -- Haunting Spectre (Ghost)
    [19140] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds' }, -- Haunting Spectre (Ghost)
    [9541] = { icon = 'esoui/art/icons/ability_mage_027.dds' }, -- Necrotic Spear (Lich)
    [20812] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds' }, -- Defiled Ground (Lich)
    [22525] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds' }, -- Defiled Ground (Lich)
    [73925] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', hide = true }, -- Soul Cage (Lich)
    [73929] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', hide = true }, -- Soul Cage (Lich)
    [73931] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds' }, -- Soul Rupture (Lich)
    [73926] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = A.Skill_Soul_Rupture }, -- Soul Cage (Lich)
    [73937] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', hide = true }, -- Soul Cage (Lich)
    [73939] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds' }, -- Soul Rupture (Lich)
    [73934] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = A.Skill_Soul_Rupture }, -- Soul Cage (Lich)
    [49702] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shadow_bolt.dds' }, -- Entropic Flare (Spellfiend)
    [50456] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shadow_bolt.dds' }, -- Entropic Flare (Spellfiend)
    [50182] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds' }, -- Consuming Energy (Spellfiend)
    [50183] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds' }, -- Consuming Energy (Spellfiend)
    [52398] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds' }, -- Consuming Energy (Spellfiend)
    [68735] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Vampiric Drain (Vampire)
    [68750] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', hide = true }, -- Vampiric Drain (Vampire)
    [68765] = { hide = true }, -- Vampiric Drain (Vampire)
    [68771] = { hide = true }, -- Vampiric Drain (Vampire)
    [68772] = { hide = true }, -- Vampiric Drain (Vampire)
    [2849] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_claw_slash.dds' }, -- Claw Slash (Werewolf)
    [4651] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_claw_slash.dds' }, -- Claw Slash (Werewolf)
    [2850] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }, -- Swipe (Werewolf)
    [2867] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_crushing_leap.dds' }, -- Crushing Leap (Werewolf)
    [45576] = { name = A.Innate_Stagger }, -- Generic Stagger Enemy (Werewolf)
    [3415] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', hide = true }, -- Flurry (Werewolf)
    [13950] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [9467] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [60636] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [60637] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [60638] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [60639] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [60640] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [44055] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Werewolf)
    [4323] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_frost_ranged.dds' }, -- Ice Bolt (Wraith)
    [4337] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Wraith)
    [4346] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Wraith)
    [43146] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Wraith)
    [2954] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [13972] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [63614] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [2969] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }, -- Pound (Zombie)
    [2960] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Zombie)
    [30347] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Zombie)
    [72980] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_singing_strike.dds' }, -- Singing Strike (Defiled Aegis)
    [72981] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_singing_strike.dds' }, -- Singing Strike (Defiled Aegis)
    [72979] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_dissonant_blow.dds' }, -- Dissonant Blow (Defiled Aegis)
    [72995] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_symphony_of_blades.dds' }, -- Symphony of Blades (Defiled Aegis)
    [72996] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_symphony_of_blades.dds', hide = true }, -- Symphony of Blades (Defiled Aegis)
    [73020] = { hide = true }, -- Shattered Harmoney (Defiled Aegis)
    [73021] = { hide = true }, -- Shattered Harmony (Defiled Aegis)
    [76180] = { hide = true }, -- Shattered Harmony (Defiled Aegis)
    [73025] = { hide = true }, -- Tomb Guardian (Defiled Aegis)
    [73322] = { hide = true }, -- Shattered Harmony (Defiled Aegis)
    [74993] = { hide = true }, -- Shattered Harmony (Defiled Aegis)

    -- Vvardenfell NPC'S
    [88361] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force_o.dds', hide = true }, -- Vile Flare (Skaafin Masquer)
    [88327] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_o.dds' }, -- Shadeway (Skaafin Masquer)
    [88339] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_o.dds', hide = true }, -- Shadeway (Skaafin Masquer)
    [88341] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_o.dds' }, -- Shadeway (Skaafin Masquer)
    [88325] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds', hide = true }, -- Pool of Shadow (Skaafin Masquer)
    [88336] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88330] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88335] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88334] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88353] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88358] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88348] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_o.dds' }, -- Shadowy Duplicate (Skaafin Masquer)
    [88350] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88346] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_barrier_o.dds', name = A.Skill_Shadowy_Barrier, duration = 295 }, -- Shadowy Duplicate (Skaafin Masquer)
    [88342] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88383] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88351] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88349] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_o.dds' }, -- Shadowy Duplicate (Skaafin Masquer)
    [88354] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_o.dds' }, -- Shadowy Duplicate (Skaafin Masquer)
    [81545] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force_p.dds', hide = true }, -- Fright Force (Malacath Voidbringer)
    [76621] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_p.dds' }, -- Shadeway (Malacath Voidbringer)
    [76784] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_p.dds', hide = true }, -- Shadeway (Malacath Voidbringer)
    [76843] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_p.dds' }, -- Shadeway (Malacath Voidbringer)
    [76619] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds', hide = true }, -- Pool of Shadow (Malacath Voidbringer)
    [76730] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76624] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76729] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76728] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [77005] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [80211] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76979] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_p.dds' }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76995] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76969] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_barrier_p.dds', name = A.Skill_Shadowy_Barrier, duration = 295 }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76955] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76996] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76985] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_p.dds' }, -- Shadowy Duplicate (Malacath Voidbringer)
    [77009] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_p.dds' }, -- Shadowy Duplicate (Malacath Voidbringer)
    [84817] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_skaafin_flare.dds' }, -- Skaafin Flare (Skaafin Witchling)
    [84815] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_skaafin_flare.dds' }, -- Skaafin Flare (Skaafin Witchling)
    [84818] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fiendish_healing.dds' }, -- Fiendish Healing (Skaafin Witchling)
    [84829] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage }, -- Fiendish Healing (Skaafin Witchling)
    [84833] = { hide = true }, -- Fiendish Healing (Skaafin Witchling)
    [84835] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_broken_pact.dds', hide = true }, -- Broken Pact (Skaafin)
    [84837] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_broken_pact.dds', hide = true }, -- Broken Pact (Skaafin)
    [77020] = { hide = true }, -- Basilisk Powder (Tracker)
    [77089] = { icon = 'esoui/art/icons/ability_rogue_056.dds' }, -- Basilisk Powder (Tracker)
    [77087] = { icon = 'esoui/art/icons/ability_rogue_056.dds', hide = true }, -- Basilisk Powder (Tracker)
    [77086] = { icon = 'esoui/art/icons/ability_debuff_silence.dds' }, -- Basilisk Powder (Tracker)
    [79954] = { icon = 'esoui/art/icons/ability_rogue_056.dds' }, -- Basilisk Powder (Tracker)
    [77019] = { icon = 'esoui/art/icons/ability_rogue_055.dds', hide = true }, -- Pin (Tracker)
    [77030] = { icon = 'esoui/art/icons/ability_rogue_055.dds' }, -- Pin (Tracker)
    [78432] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [79955] = { hide = true}, -- Lunge (Tracker)
    [78435] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [79930] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [79929] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [88481] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_spectral_claw.dds' }, -- Spectral Claw (Beastcaller)
    [88478] = { icon = 'esoui/art/icons/ability_warden_014.dds', hide = true }, -- Swarm (Beastcaller)
    [88371] = { icon = 'esoui/art/icons/ability_warden_013.dds' }, -- Dive (Beastcaller)
    [88393] = { icon = 'esoui/art/icons/ability_warden_013.dds' }, -- Dive (Beastcaller)
    [88394] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_gore.dds' }, -- Gore (Beastcaller)
    [88400] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_gore.dds', hide = true }, -- Gore (Beastcaller)
    [88409] = { icon = 'esoui/art/icons/ability_warden_018.dds', name = A.Skill_Feral_Guardian }, -- Raise the Earth (Beastcaller)
    [92303] = { hide = true }, -- Despawn Override (Beastcaller)
    [92158] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -60, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Raise the Earth (Beastcaller)
    [87854] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', hide = true }, -- Quick Shot
    [87855] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_arrow_stab.dds' }, -- Arrow Stab (Arbalest)
    [87901] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bombard.dds' }, -- Bombard (Arbalest)
    [90399] = { hide = true}, -- Bombard (Arbalest)
    [87902] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bombard.dds', hide = true }, -- Bombard (Arbalest)
    [87713] = { icon = 'esoui/art/icons/ability_warrior_045.dds' }, -- Quakeshot (Arbalest)
    [87837] = { hide = true}, -- Quakeshot (Arbalest)
    [87852] = { hide = true}, -- Quakeshot (Arbalest)
    [87422] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_snare_frost.dds' }, -- Chilled Ground (Arbalest)
    [87491] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_snare_frost.dds' }, -- Chilled Ground (Arbalest)
    [86881] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }, -- Hack (Sixth House Supplicant)
    [86882] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }, -- Hack (Sixth House Supplicant)
    [86883] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }, -- Slash (Sixth House Supplicant)
    [86884] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }, -- Slash (Sixth House Supplicant)
    [85342] = { icon = 'esoui/art/icons/ability_dualwield_001.dds' }, -- Twin Slashes (Sixth House Supplicant)
    [85343] = { icon = 'esoui/art/icons/ability_dualwield_001.dds' }, -- Twin Slashes (Sixth House Supplicant)
    [85368] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = A.Skill_Twin_Slashes }, -- Twin Slashes Bleed (Sixth House Supplicant)
    [86879] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_light.dds' }, -- Chop (Drudge)
    [86880] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_light.dds' }, -- Hack (Drudge)
    [85359] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_heavy.dds', name = A.Skill_Clobber }, -- Reverse Slash (Drudge)
    [85365] = { hide = true }, -- Assassinate Bonus (Drudge)
    [86704] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_pickaxe_light.dds' }, -- Chop (Hleran Noble)
    [86705] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_pickaxe_light.dds' }, -- Lop (Hleran Noble)
    [85361] = { icon = 'esoui/art/icons/ability_1handed_002.dds' }, -- Puncture (Hleran Noble)
    [85362] = { icon = 'esoui/art/icons/ability_debuff_major_fracture.dds' }, -- Major Fracture (Hleran Noble)
    [87064] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris (Fire-Binder)
    [87065] = { hide = true }, -- Volcanic Debris (Fire-Binder)
    [92647] = { hide = true }, -- Volcanic Debris (Fire-Binder)
    [87069] = { icon = 'esoui/art/icons/ability_mage_006.dds', hide = true }, -- Volcanic Debris (Fire-Binder)
    [87068] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris (Fire-Binder)
    [87066] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris (Fire-Binder)
    [88845] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_empower_atronach.dds' }, -- Empower Atronach (Fire-Binder)

    ----------------------------------------------------------------
    -- EVENT QUESTS ---------------------------------------------
    ----------------------------------------------------------------

    -- Jester's Festival
    [87474] = { icon = 'LuiExtended/media/icons/abilities/ability_event_flower_garland.dds', name = A.Event_Petal_Pelters }, -- Flower Garland -- Springtime Flair

    -- New Life Festival
    [84847] = {icon = 'LuiExtended/media/icons/abilities/ability_event_celebratory_belch.dds', name = A.Skill_Celebratory_Belch, unbreakable = 1 }, -- Celebratory Belch (Stonetooth Bash)
    [83523] = { icon = 'LuiExtended/media/icons/abilities/ability_event_freezing.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Event_Freezing }, -- Freezing (Snow Bear Plunge)
    [83522] = { icon = 'LuiExtended/media/icons/abilities/ability_event_warm.dds', forcedContainer = 'short', tooltip = T.Event_Warm }, -- Warm (Snow Bear Plunge)

    -- Seasonal Quests (New Life Festival)
    [84125] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Breton Male Dance (Lava Foot Stomp)
    [84126] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Breton Female Dance (Lava Foot Stomp)
    [84127] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Dunmer Male Dance (Lava Foot Stomp)
    [84128] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Dunmer Female Dance (Lava Foot Stomp)
    [84130] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Altmer Male Dance (Lava Foot Stomp)
    [84131] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Altmer Female Dance (Lava Foot Stomp)
    [84133] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Nord Dance (Lava Foot Stomp)
    [84528] = {icon = 'LuiExtended/media/icons/abilities/ability_event_torch_juggling.dds', name = A.Skill_Torch_Juggling, unbreakable = 1 }, -- Flame Juggling (Castle Charm Challenge)
    [84506] = {icon = 'LuiExtended/media/icons/abilities/ability_event_knife_juggling.dds', name = A.Skill_Knife_Juggling, unbreakable = 1 }, -- Dagger Juggling (Castle Charm Challenge)
    [84533] = {icon = 'LuiExtended/media/icons/abilities/ability_event_sword_swallowing.dds', name = A.Skill_Sword_Swallowing, unbreakable = 1 }, -- Sword Swallowing (Castle Charm Challenge)
    [84330] = { icon = 'esoui/art/icons/achievement_newlifefestival_001.dds', name = A.Memento_Mud_Ball }, -- Mudball (Mud Ball Merriment)

    -- Seasonal Quests (Witches Festival)
    [83775] = { icon = 'LuiExtended/media/icons/mementos/memento_witchmothers_whistle.dds', name = A.Event_Crow_Caller }, -- Event - Q5742 WitchFest Intro (The Witchmother's Bargain)

    ----------------------------------------------------------------
    -- CYRODIIL ----------------------------------------------------
    ----------------------------------------------------------------

    [39671] = { icon = 'esoui/art/icons/achievement_midyearevent_009.dds' }, -- Emperorship Alliance Bonus
    [11346] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_home_keep_bonus.dds' }, -- Home Keep Bonus
    [11341] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 1 }, -- Enemy Keep Bonus I
    [11343] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 2 }, -- Enemy Keep Bonus II
    [11345] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 3 }, -- Enemy Keep Bonus III
    [11347] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 4 }, -- Enemy Keep Bonus IV
    [11348] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 5 }, -- Enemy Keep Bonus V
    [11350] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 6 }, -- Enemy Keep Bonus VI
    [11352] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 7 }, -- Enemy Keep Bonus VII
    [11353] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 8 }, -- Enemy Keep Bonus VIII
    [11356] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 9 }, -- Enemy Keep Bonus IX
    [15060] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_defensive_scroll_bonus.dds', stack = 1 }, -- Defensive Scroll Bonus I
    [16350] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_defensive_scroll_bonus.dds', stack = 2 }, -- Defensive Scroll Bonus II
    [15058] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_offensive_scroll_bonus.dds', stack = 1 }, -- Offensive Scroll Bonus I
    [16348] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_offensive_scroll_bonus.dds', stack = 2 }, -- Offensive Scroll Bonus II
    [66282] = { icon = 'esoui/art/icons/achievement_026.dds' }, -- Blessing of War

    [15177] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short' }, -- Elder Scroll of Altadoon
    [15178] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short' }, -- Elder Scroll of Mnem
    [22282] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short' }, -- Elder Scroll of Ghartok
    [22295] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short' }, -- Elder Scroll of Chim
    [22297] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short' }, -- Elder Scroll of Ni-Mohk
    [22299] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short' }, -- Elder Scroll of Alma Ruma

    [8350] = { hide = true }, -- Stronger Walls
    [8351] = { hide = true }, -- Stronger Doors
    [64674] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds', name = A.Skill_Detection }, -- Cyrodiil Guard See Stealth
    [8077] = { hide = true }, -- Increased Health
    [8639] = { hide = true }, -- Increased Damage
    [43754] = { hide = true }, -- Heavily Resistant Guards
    [8657] = { hide = true }, -- Heavily Armored Guards
    [8658] = { hide = true }, -- Eagle Eye Guards
    [25873] = { hide = true }, -- heal

    ----------------------------------------------------------------
    -- TRAPS -------------------------------------------------------
    ----------------------------------------------------------------

    -- Traps & World Hazards
    [62230] = { hide = true }, -- Coldharbour Flames (Flame Trap)
    [62771] = { hide = true }, -- Coldharbour Flames (Flame Trap)
    [62769] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds', name = A.Trap_Cold_Fire_Trap }, -- Coldharbour Flames (Flame Trap)
    [62770] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds', name = A.Trap_Cold_Fire_Trap }, -- Coldharbour Flames (Flame Trap)

    [20888] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds' }, -- Falling Rocks (Falling Rocks)
    [27479] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', unbreakable = 1 }, -- Falling Rocks (Falling Rocks)

    [21940] = { hide = true }, -- Spike Trap (Spike Trap)
    [21943] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', hide = true }, -- Spike Trap (Spike Trap)
    [21941] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', name = A.Trap_Spike_Trap, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Spike Trap Snare (Spike Trap)
    [21942] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', name = A.Trap_Spike_Trap, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Trap Sprung (Spike Trap)

    [20482] = { hide = true }, -- Mistwatch Collapse (Cave-In)
    [20483] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds' }, -- Falling Rocks (Cave-In)
    [29602] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds' }, -- Falling Rocks (Cave-In)

    [17198] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', unbreakable = 1 }, -- Fire Trap (Player)
    [31606] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds' }, -- Fire Trap (Player)
    [17314] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds' }, -- Fire Trap (Player)

    [26530] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Bear Trap (Bear Trap)
    [26531] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }, -- Bear Trap (Bear Trap)

    [20260] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_sigil_of_frost.dds', name = A.Trap_Sigil_of_Frost }, -- Rune Burst
    [20259] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_sigil_of_frost.dds', name = A.Trap_Sigil_of_Frost, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Sigil of Frost Snare

    -- Lava & Slaughterfish
    [44029] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Slaughterfish Attack (Slaughterfish)
    [44034] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds' }, -- Slaughterfish Attack (Slaughterfish)

    [19224] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = A.Trap_Lava }, -- In Lava (Lava - Halls of Torment)
    [11338] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = A.Trap_Lava }, -- In Lava (Lava - The Earth Forge)

    -- Hiding Spot
    [72711] = { hide = true }, -- Hidden (Hiding Spot)
    [77335] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77336] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77337] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77338] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77339] = { hide = true }, -- Threat Drop (Hiding Spot)
    [75747] = { hide = true }, -- Hiding Spot (Hiding Spot)

    ----------------------------------------------------------------
    -- MAIN QUEST --------------------------------------------------
    ----------------------------------------------------------------

    -- Tutorial - Soul Shriven in Coldharbour
    [75527] = { hide = true }, -- Ultimate Protection (Tutorial)
    [64091] = { hide = true }, -- Power Bash (Tutorial - Used on Lyris)
    [61748] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Tutorial)
    [63269] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_heat_wave.dds', name = A.Skill_Wall_of_Flames }, -- Heat Wave
    [63270] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_heat_wave.dds', name = A.Skill_Wall_of_Flames, hide = true }, -- Heat Wave
    [63737] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Dremora Churl)
    [63684] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing }, -- Uppercut (Dremora Caitiff)
    [63685] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing }, -- Uppercut Stun (Dremora Caitiff)
    [63686] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing }, -- Uppercut (Dremora Caitiff)
    [63761] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }, -- Pound (Feral Soul Shriven)
    [63752] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Feral Soul Shriven)
    [63753] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Feral Soul Shriven)
    [63755] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Skeletal Pyromancer)
    [63756] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds', hide = true }, -- Heat Wave - Used by Skeletal Pyromancer in Tutorial }, -- Heat Wave (Skeletal Pyromancer)
    [64072] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1 }, -- Eye of the Sentinel (CH Tutorial)
    [48345] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (The Prophet)
    [48346] = { hide = true }, -- Minor Wound (The Prophet)
    [63521] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw_tutorial.dds', name = A.Skill_Stomp }, -- Bone Crush (Child of Bones)
    [63522] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw_tutorial.dds', name = A.Skill_Stomp }, -- Bone Saw (Child of Bones)
    [61646] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_incapacitating_terror.dds', duration = 0}, -- Incapacitating Terror
    [64074] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_incapacitating_terror.dds'}, -- Incapacitating Terror
    [75514] = { hide = true }, -- Greater Protection - CH Tutorial pointless aura
    [1718] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = A.Skill_Light_Attack }, -- Attack
    [64772] = { hide = true }, -- MQ1 Input Lock LAtk - CH Tutorial pointless aura
    [63883] = { hide = true }, -- Major Protection - CH Tutorial pointless aura
    [64784] = { hide = true }, -- MQ1 Tutorial Block Heavy - CH Tutorial pointless aura
    [64798] = { hide = true }, -- MQ1 Heat Wave (Tutorial) - CH Tutorial pointless aura
    [61961] = { hide = true }, -- Perma Set Off Balance Target - CH Tutorial pointless aura
    [64677] = { hide = true }, -- MQ1 Tutorial Perma Off-Balance - CH Tutorial pointless aura
    [64069] = { hide = true }, -- Sentinel Barrier
    [64166] = { hide = true }, -- Major Protection - CH Tutorial pointless aura
    [63637] = { hide = true }, -- Teleport - CH Tutorial event when player teleports out

    -- Daughter of Giants
    [29994] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_inferno.dds' }, -- Inferno (Manifestation of Solitude)
    [27767] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Ancient Clannfear)
    [27769] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Ancient Clannfear)
    [27774] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds', name = A.Skill_Rending_Leap }, -- Knockdown (Ancient Clannfear)
    [27776] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds', name = A.Skill_Devour, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Feeding (Ancient Clannfear)
    [28718] = { hide = true }, -- Spawn (Manifestation of Terror)
    [28792] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gaze_alt.dds' }, -- Gaze (Manifestation of Terror)
    [28788] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds', name = A.Skill_Doom_Truths_Gaze }, -- MQ2_Boss_1_Doom-Truth'sGaze (Manifestation of Terror)
    [49958] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds', name = A.Skill_Doom_Truths_Gaze }, -- Fire Runes (Manifestation of Terror)
    [49961] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds' }, -- Doom-Truth's Gaze (Manifestation of Terror)
    [28723] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gravity_well.dds' }, -- Gravity Well (Manifestation of Terror)
    [28730] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gravity_well.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Gravity Well (Manifestation of Terror)
    [28745] = { hide = true }, -- Tentacle Whip (Manifestation of Terror)
    [28746] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_tentacle_whip.dds' }, -- Tentacle Whip (Manifestation of Terror)

    -- Castle of the Worm
    [41852] = { icon = 'LuiExtended/media/icons/abilities/ability_set_oblivion.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Necrotic, A.Skill_Barrier) }, -- Necrotic
    [16019] = { hide = true }, -- Bone Pile Explosion
    [33597] = { hide = true }, -- Invisible Underground
    [35794] = { hide = true }, -- Material Effect
    [33540] = { hide = true }, -- Intro Explosion
    [31244] = { hide = true }, -- Consuming Darkness
    [32563] = { hide = true }, -- Skeleton Stun Targetable
    [32561] = { hide = true }, -- Skeleton Stun
    [31232] = { hide = true }, -- Skeleton Stun Targetable
    [31222] = { hide = true }, -- Skeleton Stun
    [32557] = { hide = true }, -- Skeleton Stun Targetable
    [32555] = { hide = true }, -- Skeleton Stun
    [32558] = { hide = true }, -- Delay
    [32554] = { hide = true }, -- Delay
    [32564] = { hide = true }, -- Delay
    [32562] = { hide = true }, -- Ravager Weapons
    [32553] = { hide = true }, -- Ravager Weapons
    [32556] = { hide = true }, -- Fire Mage Weapons
    [34484] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds' }, -- Soul Cage (Mannimarco)
    [34470] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = A.Skill_Soul_Rupture }, -- Soul Cage (Mannimarco)
    [34463] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = A.Skill_Soul_Rupture }, -- Soul Cage (Mannimarco)
    [34458] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds' }, -- Soul Cage (Mannimarco)
    [34460] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds' }, -- Soul Cage (Mannimarco)
    [70409] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sloads_semblance.dds' }, -- Necromantic Barrier
    [31321] = { hide = true }, -- Disruption
    [31334] = { hide = true }, -- Oblivion
    [31480] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Overwhelming Power
    [31341] = { hide = true }, -- Unleashed Oblivion
    [14972] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- CON_Knockback&Knockdown
    [14973] = { name = A.Skill_Knockback }, -- Fire Backlash

    -- Halls of Torment
    [36672] = { hide = true }, -- Summon Sword Saint
    [36858] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Swordstorm (Tharn Doppleganger)
    [36860] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds', name = A.Skill_Swordstorm }, -- Swordstorm damage (Tharn Doppleganger)
    [44561] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- FGQ4 RGT Event Knockback
    [44563] = { name = A.Skill_Knockback }, -- Fire Backlash
    [37015] = { hide = true }, -- Lash of Torment
    [37173] = { icon = 'esoui/art/icons/ability_mage_010.dds' }, -- Flame Shield (Duchess of Anguish)
    [37176] = { hide = true }, -- Register (Duchess of Anguish)
    [37175] = { icon = 'esoui/art/icons/ability_mage_010.dds', name = A.Skill_Flame_Shield }, -- Flare Up (Duchess of Anguish)
    [38729] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_royal_strike.dds' }, -- Royal Strike (Duchess of Anguish)
    [38741] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_royal_strike.dds', name = A.Skill_Royal_Strike }, -- Royal Snare (Duchess of Anguish)
    [38728] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_daedra_fa_red.dds' }, -- Summon Daedra (Duchess of Anguish)

    -- Shadow of Sancre Tor
    [41021] = { hide = true }, -- Mannimarco's Triumph
    [39302] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_empower_atronach.dds' }, -- Necromantic Revival
    [39367] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_consecrate_shrine.dds', name = A.Skill_Consecrate_Shrine }, -- Altar Use
    [37827] = { hide = true, icon = 'esoui/art/icons/achievement_housing_033.dds', name = A.Skill_Remove_Ward }, -- Stendarr's Protection
    [46816] = { hide = true }, -- Shake
    [38207] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_death_bolt.dds', hide = true }, -- Death Bolt (Mannimarco)
    [41067] = { hide = true }, -- Dummy (Mannimarco)
    [40401] = { hide = true }, -- Daedric Step (Mannimarco)
    [40400] = { hide = true }, -- Daedric Step (Mannimarco)
    [40399] = { hide = true }, -- Daedric Step (Mannimarco)
    [38215] = { icon = 'esoui/art/icons/ability_mage_041.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Death's Gaze (Mannimarco)
    [38217] = { icon = 'esoui/art/icons/ability_mage_041.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, duration = 0 }, -- Death's Gaze (Mannimarco)
    [40425] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Shock, A.Skill_Nova) }, -- Impending Doom (Mannimarco)
    [40427] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Shock, A.Skill_Nova) }, -- Doom (Mannimarco)
    [40430] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Shock, A.Skill_Nova) }, -- Doom (Mannimarco)
    [41022] = { hide = true }, -- Nova (Mannimarco)
    [40429] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- IntroKB (Mannimarco)
    [40426] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback }, -- Staggering Roar (Mannimarco)

    [40973] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds', name = A.Skill_Unstable_Portal }, -- Portal Spawn (Mannimarco)
    [40978] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds', name = A.Skill_Unstable_Portal }, -- Portal Spawn (Mannimarco)
    [40981] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds', name = A.Skill_Unstable_Portal }, -- Portal Spawn (Mannimarco)

    [40976] = { hide = true }, -- dummy (Mannimarco)
    [44083] = { hide = true }, -- Ghostly (Mannimarco)
    [42083] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_stabilize.dds', name = A.Skill_Stabilize_Portal }, -- PortalHoldstun (Mannimarco)
    [40573] = { hide = true }, -- StopPortalStun (Mannimarco)
    [40980] = { hide = true }, -- dummy (Mannimarco)
    [40983] = { hide = true }, -- dummy (Mannimarco)

    [41196] = { hide = true }, -- Smash (Molag Bal)
    [41198] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- IntroKB (Mannimarco)
    [41197] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback }, -- Staggering Roar (Mannimarco)
    [41385] = { hide = true }, -- Dummystun (Molag Bal)

    -- Council of the Five Companions
    [36543] = { hide = true }, -- Portal Cast
    [36421] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_drink_mead.dds', name = A.Skill_Drink_Mead }, -- Drink with Lyris

    -- The Weight of Three Crowns
    [47186] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_close_unstable_rift.dds', name = A.Skill_Close_Unstable_Rift }, -- CHT Portal Killer


    ----------------------------------------------------------------
    -- QUESTS - FIGHTERS GUILD -------------------------------------
    ----------------------------------------------------------------

    -- Anchors from the Harbour
    [14974] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- CON_Knockback&KnockdownSelf
    [14975] = { name = A.Skill_Knockback }, -- Fire Backlash

    -- The Prismatic Core
    [39357] = { hide = true }, -- Necrobomb Camerashake
    [39577] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds' }, -- Palolel's Rage (Queen Palolel)
    [39579] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds', name = A.Skill_Palolels_Rage }, -- CON_Knockback&Knockdown (Queen Palolel)
    [39578] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds', name = A.Skill_Palolels_Rage }, -- Staggering Roar (Queen Palolel)

    -- Proving the Deed
    [25979] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', name = A.Skill_Prismatic_Light, unbreakable = 1 }, -- FG4 RGT Event Knockback
    [25980] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', name = A.Skill_Prismatic_Light }, -- FGQ4 RGT Event Knockback
    [25984] = { hide = true }, -- Subversion (Aelif)
    [64217] = { hide = true }, -- Damage Immunity Under 50% (Aelif)
    [64218] = { hide = true }, -- Combat Regen (Aelif)
    [64220] = { hide = true }, -- Base Damage Reduction (Aelif)

    -- Will of the Council
    [28939] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_heat_wave.dds', name = A.Skill_Flame_Blossom }, -- Heat Wave (Sees-All-Colors)
    [28946] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_heat_wave.dds', name = A.Skill_Flame_Blossom }, -- Heat Wave (Sees-All-Colors)
    [47758] = { hide = true }, -- Imprisonment
    [64111] = { hide = true }, -- Transformation

    ----------------------------------------------------------------
    -- QUESTS - MAGES GUILD ----------------------------------------
    ----------------------------------------------------------------

    -- Simply Misplaced
    [26406] = { stack = 1, stackAdd = 1 }, -- MG2 Captured Essence
    [31502] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Rock, A.Skill_Barrier), unbreakable = 1 }, -- MGQ2 Asakala Sahdina Barrier
    [31503] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Rock, A.Skill_Barrier), unbreakable = 1 }, -- MGQ2 Asakala Rashomta Barrier

    -- Circus of Cheerful Slaughter
    [29814] = { hide = true }, -- Ansei Ward
    [29815] = { hide = true }, -- Ansei Ward 3

    -- The Mad God's Bargain
    [39555] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_scamp.dds', hide = true }, -- Summon Scamp (Haskill)
    [39527] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_polymorph.dds', name = A.Skill_Polymorph_Skeleton }, -- Skeleton Trap (Haskill)
    [39533] = { hide = true }, -- Polymorph (Haskill)
    [40851] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_polymorph.dds', name = A.Skill_Polymorph_Skeleton }, -- Polymorph Snare (Haskill)
    [35533] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_drain_vitality.dds', name = A.Skill_Drain_Vitality }, -- Polymorph (Haskill)
    [39556] = { hide = true }, -- Transform Scamp
    [39558] = { hide = true }, -- Rabbit
    [39559] = { hide = true }, -- Atronach
    [39560] = { hide = true }, -- Netch
    [39391] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_pig.dds', name = A.Skill_Ungulate_Ordnance }, -- Summon Pig
    [39393] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_pig.dds' }, -- Ungulate Ordnance

    --------------------------------------
    -- QUEST / ZONES - ALDMERI DOMINION --
    --------------------------------------

    --------------------
    -- Khenarthi's Roost
    --------------------

    -- Cast Adrift
    [35192] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds', name = A.Skill_Drain_Energy }, -- Q4620 Use Lodestone

    -- Tears of the Two Moons
    [32766] = { hide = true }, -- 4625 Uldor's Possession
    [31649] = { hide = true }, -- 4625 Ward 1
    [31665] = { hide = true }, -- 4625 Ward 2
    [31652] = { hide = true }, -- 4625 Gathwen Destory Ward
    [33231] = { hide = true }, -- 4625 Ward Destory
    [33136] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_blessing.dds' }, -- Blessing (Gathwen)
    [35185] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_blessing.dds', name = A.Skill_Blessing, hide = true }, -- 4625 Heal (Gathwen)
    [32063] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Feedback
    [35195] = { hide = true }, -- No Heal Check
    [31709] = { hide = true }, -- 4625 Gathwen Beam Ritual
    [33278] = { hide = true }, -- Increased Speed
    [32060] = { hide = true }, -- Shocked
    [33285] = { hide = true }, -- 4625 Uldor Banish
    [32705] = { hide = true }, -- 4625 No Yell
    [31969] = { hide = true }, -- Wrath (Uldor)
    [31970] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', hide = true }, -- Wrath (Uldor)
    [33449] = { hide = true }, -- 4625 Stop Bolts
    [33403] = { hide = true }, -- Wrath (Uldor)
    [33404] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', hide = true }, -- Wrath (Uldor)

    -- The Perils of Diplomacy
    [32264] = { hide = true }, -- Unconscious

    -- The Tempest Unleashed
    [34567] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds', name = A.Skill_Drain_Energy }, -- Q4621 PC Storm Drain
    [34701] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds', name = A.Skill_Disruption }, -- Q4621 Destory Horn
    [34747] = { hide = true }, -- a

    -- Dark Knowledge
    [35265] = { hide = true }, -- Q4667 Stun
    [35268] = { hide = true }, -- Sahira Screams

    -- The Root of the Problem
    [31948] = { hide = true }, -- Burrow
    [31947] = { hide = true }, -- Burrow

    -- A Pinch of Sugar
    [32335] = { hide = true }, -- Q4692 Thunderthrow

    --------------------
    -- Auridon
    --------------------

    -- World Boss - Seaside Scarp Camp
    [84047] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds', duration = 0  }, -- Defiled Ground (Quenyas)
    [84045] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds', name = A.Skill_Defiled_Ground }, -- Seal of Defilement (Quenyas)
    [83782] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds' }, -- Staff Strike (Quenyas)
    [83783] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds' }, -- Bash (Quenyas)
    [83776] = { hide = true }, -- Dark Summons (Quenyas)
    [84283] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', name = A.Skill_Colossal_Stomp }, -- Coursing Bones (Oskana)
    [84285] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', name = A.Skill_Colossal_Stomp }, -- Coursing Bones (Oskana)
    [84284] = { name = A.Innate_Stagger, hide = true }, -- Coursing Bones (Oskana)

    -- World Boss - Heretic's Summons
    [82934] = { hide = true }, -- Shrieking Summons
    [83013] = { hide = true }, -- Daedric Explosion
    [82935] = { hide = true }, -- Summon Brood
    [82937] = { hide = true }, -- Summon Brood
    [83151] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt.dds', name = A.Skill_Headbutt }, -- Savage Claw (Snapjaw)
    [83150] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_whip.dds' }, -- Savage Claw (Snapjaw)
    [83009] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Snapjaw)
    [83011] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Snapjaw)
    [87989] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Snapjaw)
    [83012] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Devour (Snapjaw)
    [85649] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds' }, -- Devour (Snapjaw)
    [83049] = { hide = true }, -- Charge (Clannfear)
    [83040] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_ferocious_charge.dds', name = A.Skill_Ferocious_Charge }, -- Focused Charge (Clannfear)
    [83039] = { hide = true }, -- Ferocious Charge (Clannfear)
    [83035] = { hide = true }, -- Ferocious Charge (Clannfear)
    [83042] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_ferocious_charge.dds' }, -- Ferocious Charge (Clannfear)
    [83016] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', name = A.Skill_Daedric_Explosion }, -- Necrotic Explosion
    [83017] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', hide = true }, -- Daedric Explosion
    [83018] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Daedric Explosion

    -- World Boss - Heritance Proving Ground
    [47259] = { hide = true }, -- Frostarrows

    -- Rites of the Queen
    [48921] = { hide = true }, -- Ancestral Spirit
    [48924] = { hide = true }, -- Ancestral Spirit
    [48927] = { hide = true }, -- Ancestral Spirit

    -- The Unveiling
    [22718] = { hide = true }, -- Knock Out

    -- Lifting the Veil
    [23392] = { icon = 'LuiExtended/media/icons/disguises/disguise_altmer_glamour.dds', isDisguise = true }, -- Altmer Glamour

    -- Through the Ashes
    [48646] = { hide = true }, -- Magefire
    [2379] = { hide = true }, -- On Fire

    -- Breaking the Barrier
    [21876] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, unbreakable = 1 }, -- Q4260 West Barrier Teleport
    [21878] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, unbreakable = 1 }, -- Q4260 East Barrier Teleport

    -- Sever All Ties
    [22395] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, unbreakable = 1 }, -- Q4261 ROD Barrier Teleport
    [44138] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shockwave.dds', name = A.Skill_Shockwave }, -- Q4261 Estre Knockback
    [49224] = { hide = true }, -- Q4868 Aulus Knockback
    [44136] = { hide = true }, -- RobS Stun Perm

    -- The Serpent's Beacon
    [21364] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_maormer_rune.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Dispel, A.Skill_Barrier) }, -- Casting...
    [21409] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_teleport_scroll.dds', name = A.Skill_Teleport_Scroll }, -- Reading...

    -- Corruption Stones
    [22889] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_altmer_holy_symbol.dds', name = A.Skill_Purify, hide = true }, -- Purifying...

    -- The First Patient
    [22448] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bind_hands.dds', name = A.Skill_Bind_Hands }, -- Q4266 Tie up Hendil

    -- Depths of Madness
    [22158] = { hide = true }, -- Collecting with Magic Jar...
    [22141] = { hide = true }, -- Collecting...
    [22160] = { hide = true }, -- Collecting...
    [22187] = { hide = true }, -- Throwing Spore Potion
    [22271] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_teleport_scroll.dds', name = A.Skill_Teleport_Scroll }, -- Teleport Scroll AB

    -- Silent Village
    [21968] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_binding_gem.dds', name = A.Skill_Bind_Bear }, -- Binding Bear...
    [45784] = { hide = true }, -- Generic Spawn Fire Atronach AM

    -- The Mallari-Mora
    [28771] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_atherial_shift.dds', name = A.Skill_Aetherial_Shift, unbreakable = 1 }, -- Q4220 Thirster Stun (The Mallari-Mora)
    [21040] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_atherial_shift.dds', name = A.Skill_Aetherial_Shift }, -- Q4220 Spirit Layer Ability
    [21403] = { icon = 'esoui/art/icons/ability_mage_054.dds' }, -- Spiritual Cloak

    -- An Act of Kindness
    [22931] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_micro_etched_crystal.dds', name = A.Skill_Free_Spirit }, -- Freeing Spirit...
    [21315] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds' }, -- Spike Trap
    [21313] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', name = A.Trap_Spike_Trap, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, stack = 0 }, -- Crippled!
    [21314] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', name = A.Trap_Spike_Trap, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Trap Sprung!

    -- The Veiled Choice
    [23187] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bind_hands.dds', name = A.Skill_Unbind }, -- Q4236 PC Untie Palith

    -- Preventative Measure
    [23606] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback_crystal.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Crystal, A.Skill_Backfire), unbreakable = 1, tooltip = T.Generic_Stun }, -- Q4326 Crystal Backfire
    [24535] = { hide = true }, -- Disrupting...

    -- Blessings of the Eight
    [47149] = { hide = true }, -- Magefire
    [23159] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_divine_speed.dds', tooltip = T.Skill_Divine_Speed }, -- Divine Speed
    [22728] = { hide = true }, -- Water Beam
    [23217] = { hide = true }, -- Fire Beam

    -- Rightful Inheritance
    [24826] = { hide = true }, -- Spiteful Essence

    --------------------
    -- Grahtwood
    --------------------

    -- World Events
    [40035] = { hide = true }, -- GW CTen Swinging Axe (Peacemaker Achievement Location)

    -- World Boss - Nindaeril's Perch
    [83515] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }, -- Hunter's Pounce (Bavura the Blizzard)
    [83517] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }, -- Hunter's Pounce (Bavura the Blizzard)
    [84018] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds', tooltip = T.Generic_Stun }, -- Hunter's Pounce (Bavura the Blizzard)
    [83521] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }, -- Hunter's Pounce (Bavura the Blizzard)
    [83832] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge.dds' }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83833] = { hide = true }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83846] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge.dds' }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83855] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge.dds', tooltip = T.Generic_Stun }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83852] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge.dds' }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83548] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_mighty_roar.dds' }, -- Mighty Roar (Nindaeril the Monsoon)
    [83549] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_mighty_roar.dds', tooltip = T.Generic_Fear }, -- Mighty Roar (Nindaeril the Monsoon)

    -- Public Dungeon - Root Sunder Ruins
    [34176] = { hide = true }, -- Blue Flam (The Bonemonger)

    -- Public Dungeon - Root Sunder Ruins -- Forgotten Soul
    [91627] = { hide = true }, -- Root Sunder's Favor

    -- The Grips of Madness
    [37276] = { hide = true }, -- Q4868 Beast Person
    [37296] = { hide = true }, -- Q4868 Change Beast Person
    [37297] = { hide = true }, -- Q4868 Change Beast Person
    [37295] = { hide = true }, -- Q4868 Change Beast Person
    [38499] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', name = A.Skill_Lightning_Strike }, -- Wrath
    [38500] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', name = A.Skill_Lightning_Strike }, -- Wrath
    [37438] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', name = A.Skill_Lightning_Strike, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Stun }, -- Shocked
    [38516] = { hide = true }, -- Q4868 Rufinus Is Lightning
    [47720] = { hide = true }, -- RobS Stun 1 Sec
    [37463] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', name = A.Skill_Push }, -- Q4868 Push NPC
    [37465] = { hide = true }, -- Q4842 Despawn Self
    [38942] = { hide = true }, -- Q4868 Rufinus Is Shocked
    [38596] = { hide = true }, -- Q4842 Stun
    [37583] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_old_scroll.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Dispel, A.Skill_Barrier) }, -- Q4868 Unlock Chapel
    [38744] = { hide = true }, -- Q4868 Sheo Teleports Player
    [38720] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lightning_fury.dds', tooltip = T.Skill_Lightning_Fury }, -- Lightning Fury
    [47710] = { hide = true }, -- Lightning Fury
    [38748] = { icon = 'esoui/art/icons/ability_mage_036.dds', hide = true }, -- Aulus's Tongue
    [63710] = { icon = 'esoui/art/icons/ability_mage_036.dds', tooltip = T.Generic_Stun }, -- Aulus's Tongue
    [40702] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shockwave.dds', name = A.Skill_Shockwave }, -- Q4868 Aulus Knockback
    [44100] = { hide = true }, -- Q4868 Aulus Knockback
    [47709] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shockwave.dds', name = A.Skill_Shockwave }, -- Q4868 Aulus Knockback

    -- A Lasting Winter
    [38394] = { hide = true }, -- Shatter
    [47762] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity, duration = 3, tooltip = T.Generic_CC_Immunity }, -- Spawn Clone (General Endare)
    [47768] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity, tooltip = T.Generic_CC_Immunity }, -- RobS Immunities 6 Sec (General Endare)
    [38441] = { hide = true }, -- Become
    [47783] = { hide = true }, -- Become

    -- Heart of the Matter
    [45997] = { hide = true }, -- Q4386 Ukaezai Split 3
    [46188] = { hide = true }, -- Q4386 Ukaezai Faints
    [45998] = { hide = true }, -- Q4386 Ukaezai Book Summon
    [40849] = { icon = 'LuiExtended/media/icons/abilities/ability_set_oblivion.dds' }, -- Annihilation
    [39956] = { hide = true }, -- Heart of Anumaril
    [46036] = { hide = true }, -- Q4386 Ukaezai Split 2
    [46037] = { hide = true }, -- Q4386 Ukaezai Split 1

    -- The Orrery of Elden Root
    [41979] = { hide = true }, -- RobS Despawn Me Flag
    [40504] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_quest_mantles_shadow.dds', name = A.Skill_Mantles_Shadow }, -- Q4922 Use Mantle on Device
    [40557] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_quest_mantles_shadow.dds', name = A.Skill_Mantles_Shadow }, -- (12127) CFX_4922 Mantle Cast S
    [41863] = { hide = true }, -- Q4922 Orrery Rumble
    [14568] = { hide = true }, -- TEST_Ritual Arcane
    [40394] = { hide = true }, -- CFX_4922 Naemon Ogre Glow

    [43820] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }, -- Quaking Stomp (Prince Naemon)
    [43822] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }, -- Quaking Stomp (Prince Naemon)
    [43823] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds', name = A.Skill_Quaking_Stomp, unbreakable = 1, tooltip = T.Generic_Knockback }, -- IntroKB (Prince Naemon)
    [43821] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds', name = A.Skill_Quaking_Stomp }, -- Staggering Roar (Prince Naemon)
    [43827] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_projectile_vomit.dds', hide = true }, -- Projectile Vomit (Prince Naemon)
    [43828] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_projectile_vomit.dds', name = A.Skill_Projectile_Vomit }, -- Belch (Prince Naemon)
    [40396] = { hide = true }, -- Q4922 Ayrenn Divine Glow

    -- Passage Denied
    [47301] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_ayleid_wand_of_blockade.dds', name = A.Skill_Close_Portal }, -- Stunned

    -- The Blacksap's Hold
    [39247] = { hide = true }, -- RobS Stun .5 Sec
    [39244] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', name = A.Skill_Push }, -- Q4917 Push Player Back
    [39260] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', name = A.Skill_Push, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Knockback }, -- Q4917 Push Player Back
    [41342] = { hide = true }, -- 10 Second Timer
    [39312] = { hide = true }, -- CON_Portal Perm
    [39308] = { hide = true }, -- Stun
    [39384] = { hide = true }, -- Q4917 Lurcher Construct Ground
    [41325] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_blacksaps_brew.dds', tooltip = T.Skill_Blacksaps_Brew }, -- Blacksap's Brew

    -- Luck of the Albatross
    [35984] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_captains_whistle.dds', name = A.Skill_Call_for_Help }, -- Q4436 Summon Pirate

    -- Scars Never Fade
    [41339] = { hide = true }, -- RobS Stun 3 Sec
    [43151] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bucket_of_water.dds', name = A.Skill_Throw_Water }, -- Q4768 Use Bucket

    -- Keeper of the Bones
    [35854] = { hide = true }, -- Q4773 Dringoth Splode
    [35862] = { hide = true }, -- Possessed
    [35857] = { hide = true }, -- Q4773 Dringoth Proxy Splode

    -- Bosmer Insight
    [36438] = { hide = true }, -- Q4833
    [36544] = { hide = true }, -- Fast Jumper
    [35991] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_vision_journey.dds', tooltip = T.Skill_Vision_Journey }, -- Vision Journey
    [36883] = { hide = true }, -- Q4833 Teleport into Tree
    [36882] = { hide = true }, -- Q4833 Teleport into Tree
    [36710] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_snake_scales.dds', name = A.Skill_Snake_Scales }, -- Q4833 Apply Snake Buff
    [36713] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_snake_scales.dds', tooltip = T.Skill_Snakes_Scales }, -- Snake Scales
    [36841] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wolfs_pelt.dds', name = A.Skill_Wolfs_Pelt }, -- Q4833 Apply Wolf Buff
    [36843] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wolfs_pelt.dds', tooltip = T.Skill_Wolfs_Pelt }, -- Wolf's Pelt
    [36824] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tigers_fur.dds', name = A.Skill_Tigers_Fur }, -- Q4833 Apply Tiger Buff
    [36828] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tigers_fur.dds', tooltip = T.Skill_Tigers_Fur }, -- Tiger's Fur

    -- The Unquiet Dead
    [37062] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bone_scepter.dds', hide = true }, -- Exorcise
    [36887] = { hide = true }, -- Kithshade Stun
    [36766] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds', name = A.Skill_Feedback, tooltip = T.Generic_Stun, unbreakable = 1 }, -- Q4842 Stun Headgrab Knockback
    [36998] = { hide = true }, -- Bind Spirit
    [36996] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bone_scepter.dds' }, -- Bind Spirit
    [37365] = { hide = true }, -- Q4842 Stun

    -- Eyes of Azura
    [37205] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds', name = A.Skill_Soul_Binding, tooltip = T.Skill_Soul_Binding }, -- Animus Geode
    [37677] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds', name = A.Skill_Soul_Binding }, -- Geodesic Corruption
    [37211] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds', name = A.Skill_Empower_Heart }, -- Q4854 Empower Heart
    [37386] = { hide = true }, -- Vas out
    [38246] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds', name = A.Skill_Soul_Binding }, -- Animus Geode
    [37585] = { hide = true }, -- Q4854 Culanwe Fire B

    -- Flipping the Coin
    [39309] = { hide = true }, -- Q4983 Stone Cats

    --------------------
    -- Greenshade
    --------------------

    -- World Boss -- Rootwater's Spring
    [47084] = { hide = true }, -- Rootwater Healing Spring
    [47086] = { hide = true }, -- Rootwater Life Spring

    -- World Boss - Gathongor's Mine
    [84205] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds' }, -- Stinging Sputum (Gathongor the Mauler)
    [84206] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds', hide = true }, -- Stinging Sputum (Gathongor the Mauler)
    [84196] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Marsh Masher (Gathongor the Mauler)
    [84203] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Marsh Masher (Gathongor the Mauler)
    [84197] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Marsh Masher (Gathongor the Mauler)
    [84208] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_savage_swipe.dds' }, -- Savage Swipe (Gathongor the Mauler)
    [84209] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds', tooltip = T.Generic_Stun }, -- Wrecking Jaws (Gathongor the Mauler)
    [84211] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds' }, -- Wrecking Jaws (Gathongor the Mauler)
    [84210] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds', tooltip = T.Generic_Bleed }, -- Wrecking Jaws (Gathongor the Mauler)
    [84138] = { hide = true }, -- Minion of Stone (Gathongor the Mauler)
    [84139] = { hide = true }, -- Minion of Stone (Gathongor the Mauler)
    [84212] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds' }, -- Bog Slam (Gathongor the Mauler)
    [84214] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds', type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Generic_Knockdown }, -- Bog Slam (Gathongor the Mauler)
    [84213] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds' }, -- Bog Slam (Gathongor the Mauler)

    -- World Boss - Thodundor's View
    [83164] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_punch.dds' }, -- Clobber (Thodundor of the Hill)
    [83165] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_backhand.dds' }, -- Sweeping Backhand (Thodundor of the Hill)
    [83124] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds', tooltip = T.Generic_Fear }, -- Ferocious Bellow (Thodundor of the Hill)
    [83155] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Thunderous Smash (Thodundor of the Hill)
    [83156] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Thunderous Smash (Thodundor of the Hill)
    [83159] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Thunderous Smash (Thodundor of the Hill)
    [83157] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds', tooltip = T.Generic_Stun }, -- Thunderous Smash (Thodundor of the Hill)
    [83160] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Stone Crusher (Thodundor of the Hill)
    [83163] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Stone Crusher (Thodundor of the Hill)
    [83162] = { name = A.Skill_Off_Balance }, -- Stone Crusher (Thodundor of the Hill)
    [83161] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Stone Crusher (Thodundor of the Hill)
    [83136] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Ground Shock (Thodundor of the Hill)
    [83140] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Ground Shock (Thodundor of the Hill)
    [83141] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Ground Shock (Thodundor of the Hill)
    [83137] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Ground Shock (Thodundor of the Hill)
    [83777] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', hide = true }, -- Iron Grip (Thodundor of the Hill)
    [83780] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', tooltip = T.Generic_Stun }, -- Iron Grip (Thodundor of the Hill)

    -- Public Dungeon - Rulanyil's Fall
    [33581] = { hide = true }, -- DUN-RF_Event_Blue_Fire

    -- Audience with the Wilderking
    [37759] = { icon = 'esoui/art/icons/achievement_030.dds', tooltip = T.Skill_Spirit_Armor }, -- Spirit Armor

    -- The Witch of Silatar
    [33384] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_grasping_vines.dds', name = A.Skill_Restricting_Vines, unbreakable = 1, tooltip = T.Generic_Stun }, -- Q4586 Aranias Vine Stun
    [33066] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_change_clothes.dds', name = A.Skill_Change_Clothes, tooltip = T.Skill_Fancy_Clothing }, -- Q4586_ChangeClothes
    [49116] = { hide = true }, -- Q4586_HugeTree

    -- Throne of the Wilderking
    [35014] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wilderkings_protection.dds' }, -- Wilderking's Protection
    [33594] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', hide = true }, -- Fire
    [49897] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', unbreakable = 1, tooltip = T.Generic_Snare }, -- Fire
    [33701] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds', name = A.Skill_Burrow, hide = true }, -- BurrowEND
    [33829] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds', name = A.Skill_Burrow, tooltip = T.Skill_Burrow }, -- Burrowing
    [37506] = { hide = true }, -- Stealth
    [33727] = { hide = true }, -- BurrowEND

    -- Pelidil's End
    [33577] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_blast_furnace.dds' }, -- Maormer Fire
    [48049] = { hide = true }, -- Q4765 Block Dummy Fire
    [48054] = { hide = true }, -- Q475 Impact Increment
    [50765] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_gtaoe.dds', name = A.Skill_Serpent_Spit }, -- CON_AOE_Template1

    -- Retaking the Pass
    [45650] = { hide = true }, -- Indaenir's Spell
    [29504] = { tooltip = T.Skill_Shadow_Wood }, -- Q4546 Shade Layer

    ----------------------------------------------------------------
    -- IC QUEST RELATED & QUEST BOSS HIDDEN ------------------------
    ----------------------------------------------------------------

    --[[
    [68660] = { hide = true }, -- Q5489 Zolgar Death Countdown - The Lock and the Legion
    [68720] = { hide = true }, -- Q5489 Regilus Death Timer - The Lock and the Legion
    [82788] = { hide = true }, -- IC Harvester Door Exception - The Imperial Standard (Barracks Defense)
    [69403] = { hide = true }, -- Healing Immunity - The Imperial Standard (Barracks Defense)
    [59168] = { hide = true }, -- Size and Strength - The Watcher in the Walls (Clannfear Boss)
    [59940] = { hide = true }, -- Summoning Call - The Watcher in the Walls (Clannfear Boss)
    [59181] = { hide = true }, -- Charge - The Watcher in the Walls (Clannfear Boss)
    [80678] = { hide = true }, -- Chasten - The Watcher in the Walls (Harvester Boss)
    [80674] = { hide = true }, -- Black Winter - The Watcher in the Walls (Harvester Boss)
    [60905] = { hide = true }, -- Summon - The Watcher in the Walls (Harvester Boss)
    [80650] = { hide = true }, -- Body Slam -- The Watcher in the Walls (Ogrim Boss)
    [53429] = { hide = true }, -- Call Final Boss - The Watcher in the Walls (Ogrim Boss)
    [53500] = { hide = true }, -- Spirit Shield - The Watcher in the Walls (Final Boss)
    [53480] = { hide = true }, -- Summon Flame Atronach - The Watcher in the Walls (Final Boss)
    [53489] = { hide = true }, -- Summon Flame Atronach - The Watcher in the Walls (Final Boss)
    [80657] = { hide = true }, -- Fright Force - The Watcher in the Walls (Final Boss)
    ]]--

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    --[[
    [74875] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Catapult (The Hidden Harvest)
    [64734] = { name = 'Harpy Swoop', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Q5318 - Harpy Swoop In (The Hidden Harvest)
    [74104] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Grasping Vines (The Hidden Harvest)
    [74105] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (The Hidden Harvest)
    [64316] = { icon = 'LuiExtended/media/icons/abilities/ability_frost_fortress.dds' }, -- Frost Fortress (For King and Glory - Urfon Ice-Heart)
    [64363] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds' }, -- Savage Winds (For King and Glory - Urfon Ice-Heart)
    [66277] = { icon = 'LuiExtended/media/icons/equipment_disguise.dds', name = 'Vosh Rakh Illusion' }, -- Vosh Rakh Recruit Disg (The Anger of a King)
    [66397] = { icon = 'esoui/art/icons/ability_healer_027.dds' }, -- Avalian's Speed (The Anger of a King)
    [66399] = { icon = 'esoui/art/icons/ability_warrior_012.dds' }, -- Usunok's Strength (The Anger of a King)
    [66415] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Gust' }, -- Uppercut Stun (The Anger of a King)
    [53291] = { icon = 'esoui/art/icons/ability_destructionstaff_001a.dds', name = A.Skill_Crushing_Shock }, -- Uber Attack (The Anger of a King - Talviah Aliaria)
    [53302] = { icon = 'esoui/art/icons/ability_destructionstaff_008.dds', name = 'Minor Mangle' }, -- Icy Pulsar (The Anger of a King - Talviah Aliaria)
    [64430] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds' }, -- Royal Bash (Blood on a King's Hands)
    [66988] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Tear Down the Mountain (Blood on a King's Hands)
    [67084] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Tear Down the Mountain (Blood on a King's Hands)
    [65835] = { icon = 'esoui/art/icons/ability_restorationstaff_002.dds' }, -- Restoring Waves (Forcing the Faith)
    [72154] = { icon = 'esoui/art/icons/ability_debuff_levitate.dds' }, -- Choke (Draugr Dilemma)
    [69789] = { hide = true }, -- WG - Frozen Ice (Invitation to Orsinium - Olarz the Cunning)
    [69603] = { hide = true }, -- Q5318 - Siege Hits Above (The Hidden Harvest)
    [69552] = { hide = true }, -- Frozen Aura (For King and Glory - Urfon Ice-Heart)
    [64306] = { hide = true }, -- Frozen Fortress (For King and Glory - Urfon Ice-Heart)
    [69410] = { hide = true }, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart)
    [69404] = { hide = true }, -- Winter's Heed (For King and Glory - Urfon Ice-Heart)
    [69949] = { hide = true }, -- Kinetic Resonator Damage Limit (Quarry Conundrum)
    [65765] = { hide = true }, -- Q5348 - Poison Mist (To Save a Chief)
    [75403] = { hide = true }, -- Q5348 - Poison Mist (To Save a Chief)
    [65781] = { hide = true }, -- Poison Mist (To Save a Chief)
    [65780] = { hide = true }, -- Poison Mist (To Save a Chief)
    [65779] = { hide = true }, -- Poison Mist (To Save a Chief)
    [70646] = { hide = true }, -- VR Disguise Warning (The Anger of a King)
    [66408] = { hide = true }, -- Heat Wave (The Anger of a King)
    [66475] = { hide = true }, -- Q5468 - Speaker (The Anger of a King)
    [66476] = { hide = true }, -- Q5468 - Speaker Transfer (The Anger of a King)
    [53270] = { hide = true }, -- Frost Clench (The Anger of a King - Talviah Aliaria)
    [71177] = { hide = true }, -- Alga's Hold (The King's Gambit)
    [71178] = { hide = true }, -- Q5468 - Speaker Alga (The King's Gambit)
    [66903] = { hide = true }, -- Q5481 - Injure Solgra (Blood on a King's Hands)
    [74912] = { hide = true }, -- Archer's Focus (Blood on a King's Hands)
    [67898] = { hide = true }, -- Q5481 - Tracking (Blood on a King's Hands)
    [70546] = { hide = true }, -- Alga's Resilience (Blood on a King's Hands)
    [75103] = { hide = true }, -- The King's Anger (Blood on a King's Hands)
    [75116] = { hide = true }, -- The King's Anger (Blood on a King's Hands)
    [70540] = { hide = true }, -- Oil Fire (Blood on a King's Hands)

    -- Side Quests
    [65852] = { hide = true }, -- Shatter (Forcing the Faith)
    [65828] = { hide = true }, -- Lightning Jolt Synergy (Forcing the Faith)
    [65832] = { hide = true }, -- Restoring Waves Synergy (Forcing the Faith)
    [65834] = { hide = true }, -- Restoring Waves (Forcing the Faith)
    [70702] = { hide = true }, -- Tremors (Draugr Dilemma)
    [72153] = { hide = true }, -- Choke (Draugr Dilemma)
    [69172] = { hide = true }, -- Collapsing from Fatigue (Sorrow's Kiss)
    [65925] = { hide = true }, -- Q5466 Sphere Sparking (Tinker Trouble)

    -- Delves
    [69290] = { hide = true }, -- Call Ally (Nikolvara the Durzog Trainer - Nikolvara's Kennel)
    [69322] = { hide = true }, -- Call Ally (Nikolvara the Durzog Trainer - Nikolvara's Kennel)

    -- Public Dungeons Orsinium
    [74762] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Pyre Keeper Rugdrulz - Old Orsinium)
    [53829] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Lifting Strike' }, -- Uppercut Stun (Batunalulr - Old Orsinium)
    [53940] = { icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Pummel' }, -- Pummel Stun (Batunalulr - Old Orsinium)
    [53874] = { hide = true }, -- Pummel (Batunalulr - Old Orsinium)
    ]]--

    ----------------------------------------------------------------
    -- VVARDENFELL     ---------------------------------------------
    ----------------------------------------------------------------

    -- SQ (An Armiger's Duty)
    [90073] = { hide = true }, -- Blinding Light
    [89753] = { hide = true }, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [89754] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [86865] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_powered_up.dds' }, -- Powered Up (Centurion Mthgrazzen - A Melodic Mistake)
    [86633] = { hide = true }, -- Barrier Break (A Melodic Mistake)
    [85264] = { hide = true }, -- Sacrifice (Divine Inquiries)
    [85265] = { hide = true }, -- Sacrifice (Divine Inquiries)
    [85266] = { hide = true }, -- Sacrifice (Divine Inquiries)
    [92580] = { hide = true }, -- Q5887 - AshurStealthOut (Fleeing the Past)
    [95123] = { hide = true }, -- Q5933 - NaryuStuckProtection (A Purposeful Writ)
    [86981] = { hide = true }, -- Summon Skaafin (Vvardenfell - Various Quest NPC's)
    [85105] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_unstable_reaction.dds', hide = true }, -- Unstable Reaction (Reclaiming Vos)
    [85537] = { hide = true }, -- Summon Personal Guard (Reclaiming Vos)
    [92720] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds' }, -- Necrotic Wave (Vvardenfell -- Ancestral Adversity)
    [92722] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave' }, -- Stomp of Flame (Vvardenfell -- Ancestral Adversity)
    [92723] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave', hide = true }, -- Fire Backlash (Vvardenfell -- Ancestral Adversity)
    [92721] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave' }, -- CON_Knockback&Knockdown (Vvardenfell -- Ancestral Adversity)
    [86743] = { icon = 'esoui/art/icons/achievement_morrowind_031.dds', hide = true }, -- Accelerated Transposition (Like Blood from a Stone)
    [90511] = { icon = 'esoui/art/icons/achievement_morrowind_031.dds', hide = true }, -- Accelerated Transposition (Like Blood from a Stone)
    [88425] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Shattered Ground (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88416] = { hide = true }, -- Awaken the Colony (Th'krak the Tunnel-King -- Delve -- Matus-Akin Egg Mine)
    [88417] = { hide = true }, -- Awaken the Colony (Th'krak the Tunnel-King -- Delve -- Matus-Akin Egg Mine)
    [88419] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88422] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88427] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88431] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88432] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88426] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88433] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88435] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88437] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [14374] = { hide = true }, -- Generic Dwemer Smoke Plume
    [93221] = { hide = true }, -- Surprise!
    [16910] = { hide = true }, -- Corruption Aura (Objections and Obstacles)
    [89756] = { icon = 'esoui/art/icons/achievement_wrothgar_006.dds', name = 'Centurion Drop', unbreakable = 1 }, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [89757] = { icon = 'esoui/art/icons/achievement_wrothgar_006.dds', name = 'Centurion Drop' }, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [84273] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }, -- Sweeping Spin (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [87738] = { hide = true }, -- Powder Bomb (The Heart of a Telvanni)
    [89564] = { hide = true }, -- Knockout (The Heart of a Telvanni)
    [88244] = { hide = true }, -- The Slavemaster's Chains (The Heart of a Telvanni)
    [77541] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds', name = 'Mighty Strike' }, -- Brand's Cleave (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [77542] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds', name = 'Mighty Strike' }, -- Brand's Cleave (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82276] = { hide = true }, -- Dark Reach (The Heart of a Telvanni)
    [82274] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = A.Skill_Fiery_Grip }, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82275] = { name = A.Skill_Fiery_Grip }, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [89266] = { hide = true }, -- Summon Spider
    [89269] = { hide = true }, -- Summon Spider
    [89276] = { hide = true }, -- Summon Exploder
    [89278] = { hide = true }, -- Summon Exploder
    [89277] = { hide = true }, -- Summon Exploder
    [89268] = { hide = true }, -- Summon Spider
    [89282] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', hide = true }, -- Spider Explosion
    [89274] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spider Explosion
    [87958] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_ash_storm.dds' }, -- Ash Storm (Divine Delusions)
    [87959] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_ash_storm.dds' }, -- Ash Storm (Divine Delusions)
    [86972] = { hide = true }, -- Q5888 Chodala Magic Shield FX (Divine Delusions)
    [90630] = { hide = true }, -- Frenzy (Divine Delusions)
    [86353] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_mechanical_possession.dds' }, -- Mechanical Possession (Vvardenfell -- Divine Intervention)
    [86417] = { hide = true }, -- Mechanical Possession (Divine Intervention)
    [86349] = { hide = true }, -- Inactive Centurion (Divine Intervention)

    -- Vvardenfell MQ -- Divine Intervention
    [91006] = { hide = true }, -- Chodala's Shield
    [86815] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_ranged.dds' }, -- Daedric Bolt
    [90140] = { hide = true}, -- Sunder's Echo
    [90148] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Sunder's Echo
    [90146] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', hide = true }, -- Sunder's Echo
    [90147] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Sunder's Echo
    [90139] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    [90141] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    [90142] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    [88963] = {hide = true}, -- Delay

    -- VVARDENFELL MQ - Divine Disaster
    [88466] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', }, -- Skyfall
    [88467] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Skyfall
    [92536] = { hide = true }, -- Vulnerability to Meteors

    -- VVARDENFELL MQ - Divine Restoration
    [90181] = { icon = 'LuiExtended/media/icons/abilities/ability_clockworkguardian_oily_smoke.dds' }, -- Oily Smoke
    [90182] = { icon = 'LuiExtended/media/icons/abilities/ability_clockworkguardian_oily_smoke.dds' }, -- Oily Smoke
    [87104] = { hide = true}, -- Stun (Blade Trap - Divine Restoration)
    [87102] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = 'Spinning Blade Trap' }, -- Spinning Blade
    [91970] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = 'Spinning Blade Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Serrated Blade
    [91969] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = 'Spinning Blade Trap' }, -- Serrated Blade
    [89330] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_torrent.dds', hide = true }, -- Defensive Flare
    [89750] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Pulse
    [92213] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Sparks
    [92229] = { hide = true }, -- Pulse
    [92227] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Pulse
    [92225] = { icon = 'esoui/art/icons/achievement_vvardenfel_013.dds' }, -- Repair
    [89761] = { hide = true }, -- Fabricate Beetle
    [90528] = { hide = true}, -- Loyal Hound
    [87038] = { icon = 'esoui/art/icons/ability_rogue_026.dds'}, -- Spinning Blades
    [87040] = { icon = 'esoui/art/icons/ability_rogue_026.dds', name = 'Spinning Blades', hide = true}, -- Pinning Blades
    [87039] = { icon = 'esoui/art/icons/ability_rogue_026.dds', name = 'Spinning Blades'}, -- Pinning Blades
    [87047] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    [87051] = {hide = true}, -- Lunge
    [87048] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    [87050] = {icon = 'esoui/art/icons/ability_rogue_066.dds', hide = true}, -- Lunge
    [87049] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    [87090] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_fire_ranged.dds', hide = true}, -- Barbs
    [87096] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_fire_ranged.dds'}, -- Barbs
    [90599] = { hide = true }, -- Daedric Vigor
    [92284] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_planar_shear.dds' }, -- Planar Shear
    [90627] = { hide = true }, -- targetable
    [90566] = { hide = true }, -- Loyal Hound
    [90567] = { hide = true }, -- Loyal Hound
    [90568] = { hide = true }, -- Loyal Hound
    [90569] = { hide = true }, -- Loyal Hound
    [87503] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    [90616] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    [87525] = { hide = true }, -- Divine Hijack
    [87522] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    [90524] = { hide = true }, -- Divine Hijack
    [92413] = { hide = true }, -- Contrived Portal

    -- Tutorial
    [92245] = { hide = true }, -- MQ1 Input Lock LAtk
    [83416] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackheavy.dds'}, -- Heavy Attack
    [93577] = { hide = true }, -- MQ1 Tutorial Block Heavy
    [92263] = { hide = true }, -- Perma Set Off Balance Target
    [92266] = { hide = true }, -- MQ1 Tutorial Perma Off-Balance
    [92238] = { hide = true }, -- MQ1 Heat Wave (Tutorial)
    [88904] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', name = 'Bear Trap' }, -- Metal Trap
    [88905] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', name = 'Bear Trap' }, -- Metal Trap

    -- The Forgotten Wastes (Public Dungeon)
    [91659] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds', hide = true }, -- Falling Rocks -- Deadfall
    [88030] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds' }, -- Falling Rocks -- Deadfall
    [92671] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Pyroclast -- Meteor
    [92672] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds' }, -- Pyroclast -- Meteor
    [86983] = { icon = 'esoui/art/icons/ability_mage_018.dds', type = BUFF_EFFECT_TYPE_DEBUFF}, -- Succubus Touch
    [86984] = { hide = true }, -- Succubus Touch
    [86930] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86932] = { hide = true}, -- Volcanic Debris
    [90500] = { hide = true}, -- Volcanic Debris
    [86934] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86939] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86938] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92702] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92709] = { hide = true}, -- Volcanic Debris
    [92703] = { hide = true}, -- Volcanic Debris
    [92707] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92706] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92704] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris

    -- Nchuleftingth (Public Dungeon)
    [84527] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds' }, -- Searing Steam
    [90271] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }, -- Charge-Wire Shock (Dwarven Charge-Wire)
    [90269] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }, -- Charge-Wire Shock (Dwarven Charge-Wire)
    [90268] = { hide = true }, -- Charge Whire Shock -- Generic Flame Wave Target
    [92135] = { hide = true }, -- Nchuleftingth Electricity (Dwarven Charge-Wire)
    [86634] = { hide = true }, -- Swinging Cleave (Mud-Tusk)
    [86635] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds'}, -- Swinging Cleave (Mud-Tusk)
    [89210] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [89240] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [89239] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [94935] = { hide = true }, -- Tremor (Mud-Tusk)
    [94936] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds' }, -- Tremor (Mud-Tusk)
    [86613] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Piston Thrust (Dwarven Piston)
    [86623] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Piston Thrust (Dwarven Piston)
    [90860] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Spike Trap (Dwarven Piston)
    [90859] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Swinging Blades (Dwarven Piston)
    [86591] = { hide = true }, -- Piston Thrust
    [86592] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }, -- Piston Thrust
    [86596] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }, -- Piston Thrust
    [86595] = { hide = true }, -- Piston Thrust
    [69284] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_whirlwind_function.dds' }, -- Whirlwind Function (Guardian of Bthark)
    [86606] = { hide = true }, -- Steam Breath (Guardian of Bthark)
    [86607] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds' }, -- Steam Breath (Guardian of Bthark)
    [90192] = { hide = true }, -- Overcharge (Nchuleftingth)
    [90212] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [90214] = { hide = true }, -- Overcharge (Nchuleftingth)
    [90215] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [90216] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [90217] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [71919] = { hide = true}, -- Turret Occupied (Nchuleftingth)
    [71920] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_turret_mode.dds' }, -- Turret Occupied (Nchuleftingth)
    [86566] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_rune.dds' }, -- Fire Runes (Friar Hadelar)
    [86575] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Renduril the Hammer)
    [86570] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Renduril the Hammer)
    [86576] = { name = A.Innate_Stagger, hide = true }, -- Staggered (Renduril the Hammer)
    [95731] = { hide = true }, -- Dutiful Fury -- Renduril the Hammer
    [86574] = { hide = true }, -- Shield Charge -- Renduril the Hammer
    [51634] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }, -- Shocking Touch (Steamreaver - Nchuleftingth)
    [86680] = { hide = true }, -- Auditory Signal (Steamreaver)
    [86691] = { hide = true }, -- Overcharge (Nchuleftingth)
    [86690] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [86688] = { hide = true }, -- Overcharge (Nchuleftingth)
    [86689] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Nchuleftingth)
    [92136] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds', name = 'Overcharged Shock', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Laser Snare (Dwarven Charge-Wire)
    [92138] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds', name = 'Overcharged Shock' }, -- Laser Damage (Dwarven Charge-Wire)
    [89998] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90004] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90005] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90006] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90007] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90008] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90009] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90010] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [84333] = { icon = 'esoui/art/icons/achievement_vvardenfel_013.dds' }, -- Demolish (Nchulaeon the Eternal)
    [84336] = { icon = 'esoui/art/icons/achievement_vvardenfel_013.dds', hide = true }, -- Demolish (Nchulaeon the Eternal)
    [90788] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [84739] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [84755] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91407] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90821] = { hide = true }, -- Enable (Nchulaeon the Eternal)
    [90863] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90867] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91485] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90870] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90874] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91486] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [84606] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' , hide = true }, -- Momentum
    [84616] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Momentum
    [90597] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Overcharge Explusion
    [90598] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', hide = true }, -- Overcharge Explusion
}

-- Fake Buffs applied onto the player by NPCs or Events (Friendly)
E.FakeExternalBuffs = {
    [48345] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds', name = A.Skill_Focused_Healing, duration = 4000 }, -- Focused Healing (The Prophet)

    -- Quests
    [21403] = { icon = 'esoui/art/icons/ability_mage_054.dds', name = A.Skill_Spiritual_Cloak, duration = 60000, ignoreFade = true }, -- Spiritual Cloak (The Mallari-Mora)
}

 -- Fake Debuffs applied onto the player by NPCs or Events (Hostile)
E.FakeExternalDebuffs = {

    -- Nightblade
    [36964] = { icon = 'esoui/art/icons/ability_nightblade_006_b.dds', name = A.Skill_Crippling_Grasp, duration = 1500 }, -- Crippling Grasp (Crippling Grasp)

    -- Destruction Staff
    [38946] = { icon = 'esoui/art/icons/ability_destructionstaff_007_b.dds', name = A.Skill_Flame_Reach, duration = 1800 }, -- Stun After Knockback Movement (Destructive Reach - Rank 1) -- Fire

    -- Werewolf
    [40520] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', name = A.Skill_Devour, duration = 7000 }, -- Q3047 - Knockdown (Blood Moon)

    -- Item Sets
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', name = A.Set_Bahrahas_Curse, duration = 0 }, -- Bahraha's Curse

    -- Traps
    [27479] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = A.Trap_Falling_Rocks, duration = 2000 }, -- Falling Rocks (Falling Rocks)
    [29602] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = A.Trap_Falling_Rocks, duration = 2000 }, -- Falling Rocks (Cave-In)

    [17198] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', name = A.Trap_Fire_Trap, duration = 3500, ignoreFade = true }, -- Fire Trap (Player)

    [66153] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Trial of Flame', duration = 1500}, -- Trial of Flame (Wrothgar - Old Orsinium)
    [32246] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Steam Trap', duration = 2000}, -- Laser Snare (Steam Trap)

    -- Quest Traps
    [64535] = {icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', name = 'Chilling Wind', duration = 2000}, -- Chilling Wind (Orsinium - Sorrow's Kiss)
    [67586] = {icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = 'Avalanche', duration = 2500}, -- Avalanche (Orsinium - Sorrow's Kiss)

    -- Justice NPC's
    [63160] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash, duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63263] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = A.Skill_Heavy_Blow, duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63094] = { icon = 'esoui/art/icons/ability_1handed_003.dds', name = A.Skill_Shield_Charge, duration = 1500 }, -- Shield Charge (Justice Guard 1H)
    [63260] = { icon = 'esoui/art/icons/ability_2handed_003.dds', name = A.Skill_Mighty_Charge, duration = 1500 }, -- Shield Charge (Justice Guard 2H)
    [63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = A.Skill_Stonefist, duration = 6000 }, -- Flame Shard (Justice Guard 2H)
    [63168] = { icon = 'esoui/art/icons/ability_dragonknight_010.dds', name = A.Skill_Cage_Talons, duration = 3500, ignoreBegin = true }, -- Cage Talons (Justice Guard 1H + 2H)

    -- Standard NPC Abilities
    [29401] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash, duration = 3000 }, --Power Bash (NPC Disorient)
    [14926] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = A.Skill_Shield_Rush, duration = 2000 }, -- Charge (Human NPC)
    [10650] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_oil_drenched.dds', name = A.Skill_Oil_Drenched, duration = 0 }, -- Oil Drenched
    [79930] = { icon = 'esoui/art/icons/ability_rogue_066.dds', name = A.Skill_Lunge, duration = 2500 }, -- Lunge (Tracker) (Morrowind)

    -- Animals
    [69073] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', name = A.Skill_Slam, duration = 2000 }, -- Knockdown (Bear Orsinium)
    [74336] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds', name = A.Skill_Bog_Burst, duration = 2000 }, -- Bog Burst (Haj Mota)

    -- Daedra
    [50023] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds', name = A.Skill_Lightning_Rod, duration = 4000, ignoreBegin = true }, -- Lightning Rod (Air Atronach)
    [33551] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds', name = A.Skill_Chilling_Aura, duration = 0 }, -- Chilling Aura (Frost Atronach)
    [51646] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds', name = A.Skill_Frozen_Ground, duration = 0 }, -- Frozen Ground (Frost Atronach)
    [24700] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', name = A.Skill_Body_Slam, duration = 2000 }, -- Body Slam (Ogrim)
    [91851] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds', name = A.Skill_Stomp, duration = 2000 }, -- Stomp (Ogrim)
    [12287] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', name = A.Skill_Storm_Bound, duration = 8000 }, -- Storm Bound (Storm Atronach) (DOT)
    [12288] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', name = A.Skill_Storm_Bound, duration = 8000 }, -- Storm Bound (Storm Atronach) (Snare)
    [6412] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_dusks_howl.dds', name = A.Skill_Dusks_Howl, duration = 2000, ignoreBegin = true }, -- Dusk's Howl (Winged Twilight)

    -- Insects
    [9237] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', name = A.Skill_Inject_Larva, duration = 10000 }, -- Larva Gestation (Giant Wasp)
    [6795] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds', name = A.Skill_Latch_On, duration = 7500 }, -- Latch On (Hoarvor)
    [8429] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds', name = A.Skill_Zap, duration = 4000, ignoreBegin = true }, -- Zap (Thunderbug)

    -- Monsters
    [17703] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_flame_ray.dds', name = A.Skill_Flame_Ray, duration = 4000, ignoreBegin = true }, -- Flame Ray (Imp - Fire)
    [8884] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_zap.dds', name = A.Skill_Zap, duration = 4000, ignoreBegin = true }, -- Zap (Imp - Lightning)
    [81794] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_frost_ray.dds', name = A.Skill_Frost_Ray, duration = 4000, ignoreBegin = true }, -- Frost Ray (Imp - Frost)
    [48287] = {icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds', name = A.Skill_Consuming_Omen, duration = 1500}, -- Consuming Omen (Troll - Ranged) (Fake aura to replace bugged aura)

    -- Undead
    [38834] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_desecrated_ground_snare.dds', name = A.Skill_Desecrated_Ground, duration = 0 }, -- Desecrated Ground Snare (Desecrated Ground)
    [22525] = {icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds', name = A.Skill_Defiled_Ground, duration = 0}, -- Defiled Ground (Lich)
    [43146] = {icon = 'esoui/art/icons/ability_mage_037.dds', name = A.Skill_Winters_Reach, duration = 4000}, -- Winter's Reach (Wraith)

    -- Cyrodiil
    [72641] = {icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash, duration = 2000}, -- Power Bash (Cryodiil Guard T2)
    [55862] = {icon = 'LuiExtended/media/icons/abilities/ability_stormbound.dds', name = A.Skill_Storm_Bound, duration = 8000}, --Storm Bound --Used by Craglorn Boss Wamasu (DOT)
    [55863] = {icon = 'LuiExtended/media/icons/abilities/ability_stormbound.dds', name = A.Skill_Storm_Bound, duration = 8000}, --Storm Bound --Used by Craglorn Boss Wamasu (Snare)

    ------------------------------
    -- Quests --------------------
    ------------------------------

    -- Main Story
    [14972] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 2000 }, -- CON_Knockback&Knockdown (Castle of the Worm)
    [44561] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 3000 }, -- FGQ4 RGT Event Knockback (Lyris Doppleganger - Halls of Torment)
    [38741] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_royal_strike.dds', name = A.Skill_Royal_Strike, duration = 4000 }, -- Royal Snare (Duchess of Anguish - Halls of Torment)
    [40429] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 2000 }, -- IntroKB (Mannimarco - Shadow of Sancre Tor)
    [41198] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 2000 }, -- IntroKB (Mannimarco - Shadow of Sancre Tor)

    -- Fighter's Guild
    [14974] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 2000 }, -- CON_Knockback&KnockdownSelf (Anchors from the Harbour)
    [39579] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds', name = A.Skill_Palolels_Rage, duration = 2000 }, -- CON_Knockback&Knockdown (The Prismatic Core)
    [25979] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', name = A.Skill_Prismatic_Light, duration = 1000 }, -- FG4 RGT Event Knockback

    -- Mages Guild
    [31502] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Rock, A.Skill_Barrier), duration = 4000 }, -- MGQ2 Asakala Sahdina Barrier
    [31503] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Rock, A.Skill_Barrier), duration = 4000 }, -- MGQ2 Asakala Rashomta Barrier

    -- Aldmeri Dominion
    [21876] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, duration = 4500 }, -- Q4260 West Barrier Teleport (Breaking the Barrier)
    [21878] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, duration = 4500 }, -- Q4260 East Barrier Teleport (Breaking the Barrier)
    [22395] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, duration = 4000 }, -- Q4261 ROD Barrier Teleport (Sever All Ties)
    [28771] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_atherial_shift.dds', name = A.Skill_Aetherial_Shift, duration = 2000 }, -- Q4220 Thirster Stun (The Mallari-Mora)
    [23606] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback_crystal.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Crystal, A.Skill_Backfire), duration = 2000 }, -- Q4326 Crystal Backfire (Preventative Measure)
    [43823] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds', name = A.Skill_Quaking_Stomp, duration = 2150 }, -- IntroKB (Prince Naemon)
    [36766] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds', name = A.Skill_Feedback, duration = 5000 }, -- Q4842 Stun Headgrab Knockback (The Unquiet Dead)
    [33384] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_grasping_vines.dds', name = A.Skill_Restricting_Vines, duration = 4000 }, -- Q4586 Aranias Vine Stun
    [49897] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', name = A.Skill_Fire, duration = 2000 }, -- Fire

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    --[[
    [69794] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Frozen Ground', duration = 2000}, -- Frozen Ground (Invitation to Orsinium - Olarz the Cunning)
    [53272] = {icon = 'esoui/art/icons/ability_destructionstaff_005.dds', name = 'Frost Clench', duration = 500}, -- Frost Clench (The Anger of a King - Talviah Aliaria)
    [66875] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Royal Strike', duration = 1500}, -- Royal Strike (Blood on a King's Hands)
    [65186] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'The King\'s Chains', duration = 4000}, -- The King's Chains (Blood on a King's Hands)
    [67014] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Tear Down the Mountain', duration = 2000}, -- Tear Down the Mountain (Blood on a King's Hands)
    [73861] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Murky Water', duration = 0}, -- Murky Water (Blood and the Sacred Words)
    [73864] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Murky Water', duration = 3000}, -- Murky Water (Blood and the Sacred Words)
    [72128] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Harmonic Wave Impact', duration = 2000}, -- Harmonic Wave Impact (Rkindaleft - Resonant Centurion)
    [25265] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Decapitation Function', duration = 2000}, -- Decapitation Function (Rkindaleft - Vessel of the Auditor)
    [70316] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Vessel Knockback', duration = 2000}, -- Q5321 Centurian Knockback (Rkindaleft - Vessel of the Auditor)
    ]]--

    ----------------------------------------------------------------
    -- VVARDENFELL -------------------------------------------------
    ----------------------------------------------------------------

    -- The Forgotten Wastes (Public Dungeon)
    [88030] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds', name = A.Trap_Falling_Rocks, duration = 1500}, -- Falling Rocks -- Deadfall
    [87348] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', duration = 1500}, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87350] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', duration = 2000}, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [89756] = {icon = 'esoui/art/icons/achievement_wrothgar_006.dds', name = 'Centurion Drop', duration = 2000}, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
}

-- Fake buffs applied onto the player by self (also supports debuffs with debuff = true)
E.FakePlayerBuffs = {
    -- Misc Consumables
    --[85355] = {icon = 'LuiExtended/media/icons/mementos/memento_fire-breathers_torches.dds', name = A.Memento_Fire_Breathers_Torches, duration = 12000}, -- Flame Juggling (Consumable Version)
    --[85354] = {icon = 'LuiExtended/media/icons/mementos/memento_jugglers_knives.dds', name = A.Memento_Jugglers_Knives, duration = 12000}, -- Dagger Juggling (Consumable Verison)
    --[85353] = {icon = 'LuiExtended/media/icons/mementos/memento_sword-swallowers_blade.dds', name = A.Memento_Sword_Swallowers_Blade, duration = 12000}, -- Sword Swallowing (Consumable Version)

    -- Base Mementos
    [41988] = {icon = 'LuiExtended/media/icons/mementos/memento_bonesnap_binding_stone.dds', name = A.Memento_Bonesnap_Binding_Stone, duration = 10000}, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = {icon = 'LuiExtended/media/icons/mementos/memento_discourse_amaranthine.dds', name = A.Memento_Discourse_Amaranthine, duration = 10000}, -- Glimpse of the Forbidden (Discoure Amaranthine)
    --[42076] = {icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds', name = A.Memento_Sealing_Amulet, duration = 8000}, -- Tear (Mezha-dro's Sealing Amulet)
    --[34578] = {icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds', name = A.Memento_Nirnroot_Wine, duration = 8000}, -- Nirnroot Wine (Nirnroot Wine)
    [26339] = {icon = 'LuiExtended/media/icons/mementos/memento_questionable_meat_sack.dds', name = A.Memento_Mystery_Meat, duration = 5500}, -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = {icon = 'LuiExtended/media/icons/mementos/memento_sanguines_goblet.dds', name = A.Memento_Sanguines_Goblet, duration = 10000}, -- Sanguine's Goblet (Sanguine's Goblet)
    [42008] = {icon = 'LuiExtended/media/icons/mementos/memento_token_of_root_sunder.dds', name = A.Memento_Token_of_Root_Sunder, duration = 10000}, -- Blessing of Root Sunder (Token of Root Sunder)
    --[42053] = {icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds', name = A.Memento_Yokudan_Totem, duration = 10000}, -- Yokudan Salute (Yokudan Totem)

    -- DLC Mementos
    --[89550] = {icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds', name = A.Memento_Twilight_Shard, duration = 9000 }, -- TROPHY Azura's Light (Twilight Shard)
    --[79510] = {icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds', name = A.Memento_Blade_of_the_Blood_Oath, duration = 6500}, -- TROPHY Blood Oath (Blade of the Blood Oath)
    --[74151] = {icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds', name = A.Memento_Hidden_Pressure_Vent, duration = 2500}, -- Stun (Hidden Pressure Vent)

    -- Crown Store Mementos
    [85349] = {icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_transform.dds', name = A.Memento_Storm_Atronach_Transform, duration = 180000}, -- Storm Atronach Transform (Atronach Transformation)
    --[85347] = {icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds', name = A.Memento_Storm_Orb_Juggle, duration = 12000}, -- Storm Orb Juggle (Atronach Juggling)
    [86977] = {icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_transform.dds', name = A.Memento_Wild_Hunt_Transform, duration = 180000}, -- Spriggan Transformation (Wild Hunt Transform)
    [92868] = {icon = 'LuiExtended/media/icons/mementos/memento_dwemervamidium_mirage.dds', name = A.Memento_Dwemervamidium_Mirage, duration= 180000}, -- Dwarven Transformation (Dwemervamidium Mirage)
    --[97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds', name = A.Memento_Crows_Calling, duration = 9000 }, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [97274] = { icon = 'esoui/art/icons/achievement_update16_017.dds', name = A.Memento_Swarm_of_Crows, duration = 180000 }, -- Swarm of Crows (Swarm of Crows)

    --[99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds', name = A.Memento_Fiery_Orb, duration = 9000 }, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    --[99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds', name = A.Memento_Flame_Pixie, duration = 8000 }, -- Flame Crate Memento 2 (Flame Pixie)
    --[99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds', name = A.Memento_Flame_Eruption, duration = 2000 }, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    --[101874] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_frost_shard.dds', name = A.Memento_Frost_Shard, duration = 10000 }, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    --[101877] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_rune_of_levitation.dds', name = A.Memento_Rune_of_Levitation, duration = 9000 }, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    --[101872] = { icon = 'LuiExtended/media/icons/mementos/memento_bone_dragon_summons_focus.dds', name = A.Memento_Dragon_Summons_Focus, duration = 5000 }, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    [110483] = { icon = 'LuiExtended/media/icons/mementos/memento_ghost_lantern.dds', name = A.Memento_Ghost_Lantern, duration = 6800 }, -- Ghost Lantern (Ghost Lantern)

    -- Set Items
    --[59573] = { icon = 'esoui/art/icons/ability_buff_major_vitality.dds', name = A.Skill_Major_Vitality, duration = 510 }, -- Major Vitality (Malubeth) TODO: Doesn't work
    [98421] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [98419] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [98420] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [81675] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [83288] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [83287] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [71107] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds', name = A.Set_Briarheart, duration = 10000 }, -- Briarheart
    [97627] = { icon = 'esoui/art/icons/achievement_update11_dungeons_036.dds', name = A.Set_Ironblood, duration = 10000, debuff = true, shiftId = 97626 }, -- Ironblood

    -- Player (Basic)
    [973] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', name = A.Innate_Sprint, duration = 0}, -- Sprint
    [33439] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_mount_sprint.dds', name = A.Innate_Gallop, duration = 0}, -- Mount Sprint (Generic)
    --[32346] = {icon = 'esoui/art/icons/ability_mage_050.dds', name = A.Innate_Absorbing_Skyshard, duration = 5800}, -- Skyshard Collect
    --[14031] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_mundus_use.dds', name = A.Innate_Receiving_Boon, duration = 5000}, -- Mundus Use

    -----------------
    -- Class --------
    -----------------

    -- Dragonknight
    [32956] = { icon = 'esoui/art/icons/ability_dragonknight_006_b.dds', name = A.Skill_Standard_of_Might, duration = 0 }, -- Standard of Might (Standard of Might - Rank 1)
    [31841] = { icon = 'esoui/art/icons/ability_dragonknight_012.dds', name = A.Skill_Inhale, duration = 2500 }, -- Inhale
    [32796] = { icon = 'esoui/art/icons/ability_dragonknight_012_a.dds', name = A.Skill_Deep_Breath, duration = 2500 }, -- Deep Breath
    [32788] = { icon = 'esoui/art/icons/ability_dragonknight_012_b.dds', name = A.Skill_Draw_Essence, duration = 2500 }, -- Draw Essence

    -- Templar
    [22223] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds', name = A.Skill_Rite_Of_Passage, duration = 4000}, -- Rite of Passage (Rite of Passage - Rank 1)
    [22229] = { icon = 'esoui/art/icons/ability_templar_remembrance.dds', name = A.Skill_Remembrance, duration = 4000 }, -- Remembrance (Remembrance - Rank 1)
    [22226] = { icon = 'esoui/art/icons/ability_templar_practiced_incantation.dds', name = A.Skill_Practiced_Incantation, duration = 6000 }, -- Practiced Incantation (Practiced Incantation - Rank 1)

    -- Vampire
    --[40350] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', name = A.Skill_Feed, duration = 5300 }, -- Feed (Blood Ritual - Rank 1)
    --[33175] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', name = A.Skill_Feed, duration = 6300 }, -- Feed (Vampire - Feed)

    -- Mages Guild
    [40449] = { icon = 'esoui/art/icons/ability_mageguild_003_a.dds', name = A.Skill_Spell_Symmetry, duration = 5000 }, -- Spell Symmetry (Spell Symmetry)

    -- Seasonal Quests (New Life Festival)
    --[84125] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Breton Male Dance (Lava Foot Stomp)
    --[84126] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Breton Female Dance (Lava Foot Stomp)
    --[84127] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Dunmer Male Dance (Lava Foot Stomp)
    --[84128] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Dunmer Female Dance (Lava Foot Stomp)
    --[84130] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Altmer Male Dance (Lava Foot Stomp)
    --[84131] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Altmer Female Dance (Lava Foot Stomp)
    --[84133] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Nord Dance (Lava Foot Stomp)
    --[84528] = {icon = 'LuiExtended/media/icons/abilities/ability_event_torch_juggling.dds', name = A.Skill_Torch_Juggling, duration = 12000}, -- Flame Juggling (Castle Charm Challenge)
    --[84506] = {icon = 'LuiExtended/media/icons/abilities/ability_event_knife_juggling.dds', name = A.Skill_Knife_Juggling, duration = 12000}, -- Dagger Juggling (Castle Charm Challenge)
    --[84533] = {icon = 'LuiExtended/media/icons/abilities/ability_event_sword_swallowing.dds', name = A.Skill_Sword_Swallowing, duration = 12000}, -- Sword Swallowing (Castle Charm Challenge)
    --[84847] = {icon = 'LuiExtended/media/icons/abilities/ability_event_celebratory_belch.dds', name = A.Skill_Celebratory_Belch, duration = 5000}, -- Celebratory Belch (Stonetooth Bash)

    ------------------------------
    -- Quests --------------------
    ------------------------------

    -- Mages Guild
    [26406] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence.dds', name = A.Skill_Essence, duration = 0 }, -- MG2 Captured Essence (Simply Misplaced)
    [26634] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence_greater.dds', name = A.Skill_Sahdinas_Essence, duration = 0 }, -- MG2 Captured Sahdina Essence
    [26581] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence_greater.dds', name = A.Skill_Rashomtas_Essence, duration = 0 }, -- MG2 Captured Rashomta Essence

    -- Aldmeri Dominion
    [33066] = { icon = 'LuiExtended/media/icons/disguises/disguise_fancy_clothing.dds', name = A.Skill_Fancy_Clothing, duration = 0, long = true, ignoreBegin = true }, -- Q4586_ChangeClothes
    [29504] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_shadow_wood.dds', name = A.Skill_Shadow_Wood, duration = 0, long = true }, -- Q4546 Shade Layer

    -- Quest related (Craglorn)
    --[81807] = {icon = 'esoui/art/icons/achievement_104.dds', name = 'Power of the Stars', duration = 22000}, -- Power of the Stars (The Star-Gazers)

    -- Orsinium
    --[66453] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', name = 'Hiding', duration = 45000}, -- Hiding (A Question of Succession)
}

-- TODO: Fake buffs applied onto a target by the player
E.FakePlayerExternalBuffs = {

}

-- Fake debuffs applied onto a target by the player
E.FakePlayerDebuffs = {
    -- JUSTICE NPCS
    -- Disabled: Duration is too long and Guard always CC breaks. Maybe setup a calllater removal function?
    --[63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = A.Skill_Stonefist, duration = 6000 }, -- Flame Shard (Justice Guard 2H) -- If the player reflects

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    [86309] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, duration = 3000}, -- Stun (Player blocks NPC charged attack)
    [86312] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, duration = 3000}, -- Stun (Player blocks Ogrim Body Slam)

    -- Nightblade
    [36964] = { icon = 'esoui/art/icons/ability_nightblade_006_b.dds', name = A.Skill_Crippling_Grasp, duration = 1500 }, -- Crippling Grasp (Crippling Grasp)

    -- Destruction Staff
    [38946] = { icon = 'esoui/art/icons/ability_destructionstaff_007_b.dds', name = A.Skill_Flame_Reach, duration = 1800 }, -- Stun After Knockback Movement (Destructive Reach - Rank 1) -- Fire

    -- Dragonknight (Flame Lash)
    [70745] = {icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Power_Lash, duration = 2000}, -- Off-Balance Exploit (Flame Lash - Rank 1)

    -- Werewolf
    [40520] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', name = A.Skill_Devour, duration = 7000 }, -- Q3047 - Knockdown (Blood Moon)

    -- Item Sets
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', name = A.Set_Bahrahas_Curse, duration = 1100, overrideDuration = 0 }, -- Bahraha's Curse -- Note: We add 100 ms to buffer here because it doesn't really matter and stops flashing
}

-- We use this for debuffs applied on the player or on a target that don't need to check for a removal condition
-- Useful for effects like staggers where there is no way to break out of them for the short duration they are applied
E.FakeStagger = {
    -- Player Basic
    [42514] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds', name = A.Innate_Hard_Dismount, duration = 2000}, -- Hard Dismount (Player knocked off horse)

    -- Bow
    [38649] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Poison Arrow (Venom Arrow)

    -- Destruction Staff
    [48009] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Stagger (Crushing Shock)

    -- On Player
    [2874] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Staggered (Generic Stagger applied to player by many different NPC abilities)
    [29402] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Power Bash (Stagger when hit with Power Bash)
    [29765] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Uber Attack (Player staggers self by hitting Blocking NPC with Heavy Attack)
    [68971] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Staggered (Echatere - Shockwave)
    [12426] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Raven Storm (Hagraven)
    [32698] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Pulverize (Lurcher - Pulverize)
    [5349] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Stagger (Ogre - Shockwave)
    [49405] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Rear Up (Mantikora)
    [76134] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 600}, -- Stumble Forward (Flesh Colossus)
    [76133] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Stumble Forward (Flesh Colossus - Blocked)
    [65755] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 600}, -- Staggered (Flesh Colossus - Block Pin)
    [68826] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 600}, -- Staggered (Flesh Colossus - Block Sweep)
    [74794] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Black Winter (Harvester)
    [32023] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Generic Stagger Enemy (Bloodfiend)
    [17206] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Bone Saw(Bone Colossus)
    [45576] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Generic Stagger Enemy (Werewolf)
    [69157] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Retaliation (Winterborn Warrior)
    [69153] = {icon = 'esoui/art/icons/ability_warrior_014.dds', name = A.Skill_Retaliation, duration = 1000}, -- Retaliation (Winterborn Warrior)
    [54050] = {icon = 'esoui/art/icons/ability_warrior_032.dds', name = A.Skill_Divine_Leap, duration = 500}, -- Divine Leap Stun (Vosh Rakh Devoted)
    [77927] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Staggered (Bodyguard) (DB DLC)
    [72639] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Power Bash  (Cyrodiil Guard T2) (Stagger when hit with Power Bash)
    [74483] = {icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = A.Skill_Fiery_Grip, duration = 1000}, -- Fiery Grip (Sentinel) (TG DLC)
    [35115] = {icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Extended_Chains, duration = 1000},  -- Pull (Extended Chains) (Cyrodiil Guard T2)
    [47020] = {icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Puncturing_Chains, duration = 1000}, -- Pull (Puncturing Chains) (Cyrodiil Guard T2)

    -- Quest
    [84284] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Coursing Bones (Oskana)
    [84197] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Marsh Masher (Gathongor the Mauler)
    [83161] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Stone Crusher (Thodundor of the Hill)
    [83141] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Ground Shock (Thodundor of the Hill)

    --[[
    [52878] = {icon = 'esoui/art/icons/ability_dragonknight_005_b.dds', name = 'Empowering Chains', duration = 433}, -- Pull (Empowering Chains) (Rkindaleft - Sharga the Firestarter)
    [64322] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [72479] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [53290] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Stagger (The Anger of a King - Talviah Aliaria)
    [75463] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Magma Diver (The King's Gambit - Shield-Wife Razbela)
    [67156] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Kindlepitch Slick', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    [70543] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Oil Fire', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    ]]--

    -- Vvardenfell
    [86576] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Renduril the Hammer (Nchuleftingth)
    [88510] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Staggered (Vvardenfell -- Ancestral Adversity)

    -- On Target
    [86310] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 500}, -- Stagger (Player Blocks charged NPC attack)
    [21972] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 500}, -- Stagger (Player interrupts NPC cast)
}
