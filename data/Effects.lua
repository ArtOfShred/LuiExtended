--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Effects namespace
LUIE.Data.Effects = {}
local Effects = LUIE.Data.Effects

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities considered for Ultimate generation - used by CombatInfo to determine when Ultimate is being generated (Uses base abilityName sent to the listener - so we need the default names, not LUIE modified ones)
--------------------------------------------------------------------------------------------------------------------------------

Effects.IsWeaponAttack = {
    [Abilities.Skill_Light_Attack_Unarmed] = true, -- Light Attack (Unarmed)
    [Abilities.Skill_Heavy_Attack_Unarmed] = true, -- Heavy Attack (Unarmed)
    [Abilities.Skill_Light_Attack_Two_Handed] = true, -- Light Attack (Two Handed)
    [Abilities.Skill_Heavy_Attack_Two_Handed] = true, -- Heavy Attack (Two Handed)
    [Abilities.Skill_Light_Attack_One_Handed] = true, -- Light Attack (One Handed)
    [Abilities.Skill_Heavy_Attack_One_Handed] = true, -- Heavy Attack (One Handed)
    [Abilities.Skill_Light_Attack_Dual_Wield] = true, -- Light Attack (Dual Wield)
    [Abilities.Skill_Heavy_Attack_Dual_Wield] = true, -- Heavy Attack (Dual Wield)
    [Abilities.Skill_Light_Attack_Bow] = true, -- Light Attack (Bow)
    [Abilities.Skill_Heavy_Attack_Bow] = true, -- Heavy Attack (Bow)
    [Abilities.Skill_Light_Attack_Ice] = true, -- Light Attack (Ice)
    [Abilities.Skill_Heavy_Attack_Ice] = true, -- Heavy Attack (Ice)
    [Abilities.Skill_Light_Attack_Inferno] = true, -- Light Attack (Inferno)
    [Abilities.Skill_Heavy_Attack_Inferno] = true, -- Heavy Attack (Inferno)
    [Abilities.Skill_Light_Attack_Lightning] = true, -- Light Attack (Lightning)
    [Abilities.Skill_Heavy_Attack_Lightning] = true, -- Heavy Attack (Lightning)
    [Abilities.Skill_Light_Attack_Restoration] = true, -- Light Attack (Restoration)
    [Abilities.Skill_Heavy_Attack_Restoration] = true, -- Heavy Attack (Restoration)
    [Abilities.Skill_Light_Attack_Volendrung] = true, -- Light Attack (Volendrung)
    [Abilities.Skill_Heavy_Attack_Volendrung] = true, -- Heavy Attack (Volendrung)
}

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged as a Toggle. For the purpose of adding a "T" label to the buff icon.
--------------------------------------------------------------------------------------------------------------------------------
Effects.IsToggle = {
    -- Innate
    [20299] = true, -- Sneak -- Used for hidden
    [20309] = true, -- Hidden -- Used for invisibility
    [40165] = true, -- Scene Choreo Brace (Monster Fight))
    [29761] = true, -- Brace (Guard)

    -- Sets
    [117082] = true, -- Frozen Watcher (Frozen Watcher)
    [134930] = true, -- Duneripper's Scales (Duneripper)
    [135554] = true, -- Grave Guardian (Grave Guardian's)

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
    [103966] = true, -- Concentrated Barrier
    [103543] = true, -- Mend Wounds
    [103747] = true, -- Mend Spirit
    [103755] = true, -- Symbiosis
    [103492] = true, -- Meditate
    [103652] = true, -- Deep Thoughts
    [103665] = true, -- Introspection

    -- Support
    [80923] = true, -- Guard (Guard)
    [80947] = true, -- Mystic Guard (Mystic Guard)
    [80983] = true, -- Stalwart Guard (Stalwart Guard)

    -- Vampire
    [132141] = true, -- Blood Frenzy
    [134160] = true, -- Simmering Frenzy
    [135841] = true, -- Sated Fury
    [32986] = true, -- Mist Form
    [38963] = true, -- Elusive Mist
    [38965] = true, -- Blood Mist

    -- NPC Abilities
    [44258] = true, -- Magelight (Soulbrander)
}

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged to display a Proc highlight / sound notification in Combat Info when the Ability Bar is updated with a matching id.
--------------------------------------------------------------------------------------------------------------------------------
Effects.IsAbilityProc = {
    [20824] = true, -- Power Lash (Flame Lash)
    [61907] = true, -- Assassin's Will (Grim Focus)
    [61932] = true, -- Assassin's Scourge (Relentless Focus)
    [61930] = true, -- Assassin's Will (Merciless Resolve)
}

-- Flagged to update on a bar slot update
Effects.BaseForAbilityProc = {
    [20816] = true, -- Flash Lash
    [61902] = true, -- Grim Focus
    [61927] = true, -- Relentless Focus
    [61919] = true, -- Merciless Resolve

}

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged to display a Proc highlight / sound notification when an ability with a matching name appears as a buff.
--------------------------------------------------------------------------------------------------------------------------------
Effects.HasAbilityProc = {
    [Abilities.Skill_Crystal_Fragments] = 46327,
}

--------------------------------------------------------------------------------------------------------------------------------
-- Context Based Hidden Effects - Used by SpellCastBuffs.UpdateContextHideList to bulk hide certain abilities from displaying Buffs/Debuffs in the menu options.
--------------------------------------------------------------------------------------------------------------------------------

-- Vampire Stages
Effects.IsVamp = {
    [135397] = true, -- Vampire Stage 1
    [135399] = true, -- Vampire Stage 2
    [135400] = true, -- Vampire Stage 3
    [135402] = true, -- Vampire Stage 4
    [135412] = true, -- Vampire Stage 5
}

-- Werewolf Buff
Effects.IsLycan = {
    [35658] = true, -- Lycanthrophy
}

-- Werewolf & Vampire Precursor Diseases
Effects.IsVampLycanDisease = {
    [39472] = true, -- Noxiphilic Sanguivoria (NPC Bite)
    [40360] = true, -- Noxiphilic Sanguivoria (Player Bite)
    [31068] = true, -- Sanies Lupinus (NPC Bite)
    [40521] = true, -- Sanies Lupinus (Player Bite)
}

-- Werewolf & Vampire Bite cooldown timers
Effects.IsVampLycanBite = {
    [40359] = true, -- Fed on ally (Vampire)
    [40525] = true, -- Bit an ally (Werewolf)
}

-- Mundus passives
Effects.IsBoon = {
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

-- Cyrodiil Scrolls
Effects.IsCyrodiil = {
    [15060] = true, -- Defensive Scroll Bonus I
    [16350] = true, -- Defensive Scroll Bonus II
    [15058] = true, -- Offensive Scroll Bonus I
    [16348] = true, -- Offensive Scroll Bonus II
}

-- Soul Summons
Effects.IsSoulSummons = {
    [43752] = true, -- Soul Summons
}

-- Internal Cooldown for  set procs
Effects.IsSetICD = {
    [129477] = true, -- Immortal Warrior
    [127235] = true, -- Eternal Warrior
    [127032] = true, -- Phoenix
    [142401] = true, -- Juggernaut
    [117397] = true, -- Exhausted Sentry (of the Sentry)
}

-- Internal Cooldown for ability procs
Effects.IsAbilityICD = {
    [151113] = true, -- Expert Evasion (Champion)
    [134254] = true, -- Winded (Champion)
}

-- Food & Drink Buffs
Effects.IsFoodBuff = {
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
    [86787] = true, -- Rajhin's Sugar Claws
    [89955] = true, -- Candied Jester's Coins
    [89971] = true, -- Jewels of Misrule
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
    [127596] = true, -- Bewitched Sugar Skulls

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
    [127531] = true, -- Corrupting Bloody Mara
    [127572] = true, -- Pack Leader's Bone Broth
}

-- Experience Buffs
Effects.IsExperienceBuff = {
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
    [91449] = true, -- Breda's Magnificent Mead
    [86075] = true, -- Breda's Magnificent Mead
    [77123] = true, -- Anniversary EXP Buff
    [118985] = true, -- Anniversary EXP Buff
    [136348] = true, -- Anniversary EXP Buff
    [152514] = true, -- Anniversary EXP Buff
    [96118] = true, -- Witchmother's Boon
}

Effects.IsAllianceXPBuff = {

    -- Consumable
    [147466] = true, -- Alliance Skill Gain (Alliance War Skill Line Scroll)
    [137733] = true, -- Alliance Skill Gain (Alliance War Skill Line Scroll, Major)
    [147467] = true, -- Alliance Skill Gain (Alliance War Skill Line Scroll, Grand)
    [147687] = true, -- Alliance Skill Gain 50% Boost (Colovian War Torte)
    [147733] = true, -- Alliance Skill Gain 100% Boost (Molten War Torte)
    [147734] = true, -- Alliance Skill Gain 150% Boost (White-Gold War Torte)

    -- Event
    [92232] = true, -- Pelinal's Ferocity

    -- World
    [66282] = true, -- Blessing of War

}

-- Block buffs (NPC and Player)
Effects.IsBlock = {
    [29761] = true, -- Brace
    [40165] = true, -- Scene Choreo Brace
}

--------------------------------------------------------------------------------------------------------------------------------
-- Grim Focus Id's - Used by SpellCastBuffs to track the id's for Grim Focus & its morphs - These id's are merged with the Override for stack tracking
--------------------------------------------------------------------------------------------------------------------------------
Effects.IsGrimFocus = {
    [122585] = true, -- Grim Focus
    [122587] = true, -- Relentless Focus
    [122586] = true, -- Merciless Resolve
}

Effects.IsSimmeringFrenzy = {
    [134166] = true, -- Simmering Frenzy
}

--------------------------------------------------------------------------------------------------------------------------------
-- Grim Focus Override Id's - Used by SpellCastBuffs to track the id's for Grim Focus & its morphs - These id's are merged with the base buff for stack tracking
--------------------------------------------------------------------------------------------------------------------------------
Effects.IsGrimFocusOverride = {
    [61902] = true, -- Grim Focus
    [61927] = true, -- Relentless Focus
    [61919] = true, -- Merciless Resolve
}

Effects.IsSimmeringFrenzyOverride = {
    [134160] = true, -- Simmering Frenzy
}

--------------------------------------------------------------------------------------------------------------------------------
-- Ground Mine Auras tracking
--------------------------------------------------------------------------------------------------------------------------------
Effects.IsGroundMineAura = {
    -- Nightblade
    [37475] = true, -- Manifestation of Terror (Nightblade)

    -- Sorcerer
    [24830] = true, -- Daedric Mines (Daedric Mines)
    [24847] = true, -- Daedric Mines (Daedric Tomb)
    [25158] = true, -- Daedric Mines (Daedric Minefield)

    -- Fighters Guild
    [35750] = true, -- Trap Beast (Trap Beast)
    [40382] = true, -- Barbed Trap (Barbed Trap)
    [40372] = true, -- Lightweight Beast Trap (Lightweight Beast Trap)

    -- Mages Guild
    [31632] = true, -- Fire Rune (Fire Rune)
    [40470] = true, -- Volcanic Rune (Volcanic Rune)
    [40465] = true, -- Scalding Rune (Scalding Rune)

    -- Psijic Order
    [104079] = true, -- Time Freeze (Time Freeze)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Effects in this category will not have their stack count for mines display (This is effectively used for creating fake mines) for the purpose of some effects
--------------------------------------------------------------------------------------------------------------------------------
Effects.HideGroundMineStacks = {
    [104079] = true, -- Time Freeze (Time Freeze)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Abilities flagged as Ground Mines that need a stack counter, when an EFFECT_RESULT_FADED event occurs for these buffs decrement by 1 instead of being removed
--------------------------------------------------------------------------------------------------------------------------------
Effects.IsGroundMineStack = {
    -- Sets
    [75930] = true, -- Deadric Mines (Eternal Hunt)

    -- Warden
    [86175] = true, -- Frozen Gate (Frozen Gate)
    [86179] = true, -- Frozen Device (Frozen Device)
    [86183] = true, -- Frozen Retreat (Frozen Retreat)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Linked id's for tracking ground mine explosions - These id's all all merged into one and considered for the purpose of reducing the stack count of certain mine abilities
--------------------------------------------------------------------------------------------------------------------------------
Effects.LinkedGroundMine = {
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

--------------------------------------------------------------------------------------------------------------------------------
-- Tracking for CC triggered from blocking/bashing enemies, we filter this out in Combat Alerts so they don't erroneously interrupt casts.
--------------------------------------------------------------------------------------------------------------------------------
Effects.BlockAndBashCC = {
    [21972] = true, -- Stagger
    [21971] = true, -- Bash Stun
    [48416] = true, -- Uber Attack
    [45982] = true, -- Bash Stun
    [86310] = true, -- Stagger
    [86309] = true, -- Stun
    [86312] = true, -- Stun
}

--------------------------------------------------------------------------------------------------------------------------------
-- Filter out Debuffs to always display regardless of whether they are sourced from the player - useful for some odd effects that get applied by the player or a player pet but aren't actually sourced from them on the API
--------------------------------------------------------------------------------------------------------------------------------
Effects.DebuffDisplayOverrideId = {
    ----------------------------------------------------------------
    -- INNATE / SHARED ---------------------------------------------
    ----------------------------------------------------------------

    -- Basic (Shared)
    [16593] = true, -- Melee Snare

    ----------------------------------------------------------------
    -- HOUSING TARGET DUMMY ----------------------------------------
    ----------------------------------------------------------------

    [120007] = true, -- Crusher
    [120011] = true, -- Engulfing Flames
    [120018] = true, -- Roar of Alkosh

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    -- Glyphs
    [17906] = true, -- Crusher (Glyph of Crushing)
    [17945] = true, -- Weakening (Glyph of Weakening)

    -- Item Sets
    [127070] = true, -- Way of Martial Knowledge (... of Martial Knowledge)
    [93305] = true, -- Defiler (Defiler's)
    [51315] = true, -- Destructive Mage (Aether ... of Destruction)
    [75753] = true, -- Line-Breaker (of Alkosh)
    [93001] = true, -- Mad Tinkerer (Stun from Fabricant)
    [126597] = true, -- Touch of Z'en (Z'en's)
    [126631] = true, -- Blight Seed (Azureblight)
    [80990] = true, -- Shadowrend (Shadowrend)
    [81034] = true, --Shadowrend (Shadowrend)
    [80866] = true, -- Tremorscale (Tremorscale)
    [100302] = true, -- Piercing Spray (Asylum Bow)
    [34384] = true, -- The Morag Tong (of the Morag Tong)
    [142610] = true, -- Flame Weakness (of the Catalyst)
    [142652] = true, -- Frost Weakness (of the Catalyst)
    [142653] = true, -- Shock Weakness (of the Catalyst)

    -- Dragonknight
    [134336] = true, -- Stagger (Stone Giant)
    [98447] = true, -- Shackle Snare (Dragonknight Standard Synergy)

    -- Sorcerer
    [143808] = true, -- Crystal Weapon (Crystal Weapon)

    -- Templar
    [31562] = true, -- Supernova (Nova Synergy)
    [34443] = true, -- Gravity Crush (Solar Prison Synergy)

    -- Warden
    [89129] = true, -- Crushing Swipe (Feral Guardian)
    [105908] = true, -- Crushing Swipe (Eternal Guardian)
    [92666] = true, -- Crushing Swipe (Wild Guardian)

    -- Necromancer
    [118618] = true, -- Pure Agony (Agony Totem)

    -- Warden
    [87560] = true, -- Frozen Gate Root (Frozen Gate)
    [92039] = true, -- Frozen Gate Root (Frozen Device)
    [92060] = true, -- Frozen Retreat Root (Frozen Retreat)

    -- Undaunted
    [42007] = true, -- Black Widow Poison (Shadow Silk - Black Widow Synergy)

    -- Werewolf
    [127161] = true, -- Lunge (Pack Leader)

}

-- These will always show regardless of the menu setting since they may indicate important information (self applied debuffs on enemy NPCs)
Effects.DebuffDisplayOverrideIdAlways = {

    ----------------------------------------------------------------
    -- BASIC -----------------------------------------------
    ----------------------------------------------------------------

    [134599] = true, -- Off Balance Immunity
    --[132831] = true, -- Major Vulnerability Invulnerability -- TODO: Likely remove

    ----------------------------------------------------------------
    -- NPC ABILITIES -----------------------------------------------
    ----------------------------------------------------------------

    -- Human NPC's
    [88281] = true, -- Call Ally (Pet Ranger)
    [89017] = true, -- Dark Shade (Dreadweaver)
    [88561] = true, -- Summon the Dead (Necromancer)
    [88504] = true, -- Summon Abomination (Bonelord)
    [92158] = true, -- Raise the Earth (Beastcaller)
    [29597] = true, -- Combustion (Shaman)
    [89301] = true, -- Summon Spiderling (Spider Daedra)

    -- Monsters
    [89399] = true, -- Summon Spectral Lamia (Lamia)
    [89127] = true, -- Summon Beast (Spriggan)
    [42794] = true, -- Strangler: (Strangler)
    [48294] = true, -- Consuming Omen (Troll - Ranged)

    ----------------------------------------------------------------
    -- WORLD BOSSES ------------------------------------------------
    ----------------------------------------------------------------

    [84172] = true, -- Charge (Trapjaw)

    ----------------------------------------------------------------
    -- ARENAS ------------------------------------------------------
    ----------------------------------------------------------------

    -- Maelstrom Arena
    [72450] = true, -- Interrupted (Troll Breaker)

}

-- Add Major/Minor Id's to list to show always even if not sourced from the player
Effects.DebuffDisplayOverrideMajorMinor = {
    [61742] = true, -- Minor Breach
    [79717] = true, -- Minor Vulnerability
    [61723] = true, -- Minor Maim
    [61726] = true, -- Minor Defile
    [88401] = true, -- Minor Magickasteal
    [86304] = true, -- Minor Lifesteal
    [79907] = true, -- Minor Enervation
    [79895] = true, -- Minor Uncertainty
    [79867] = true, -- Minor Cowardice
    [61733] = true, -- Minor Mangle
    [140699] = true, -- Minor Timidity
    [145975] = true, -- Minor Brittle
    [61743] = true, -- Major Breach
    [106754] = true, -- Major Vulnerability
    [61725] = true, -- Major Maim
    [61727] = true, -- Major Defile
    [147643] = true, -- Major Cowardice
    --[145977] = true, -- Major Brittle
}

-- Table of all Major / Minor Effects (Used by CombatInfo Bar Highlight to override the 0 duration on these abilities)
Effects.MajorMinor = {
    -- Major / Minor Buffs
    [61693] = true, -- Minor Resolve
    [61694] = true, -- Major Resolve
    [61697] = true, -- Minor Fortitude
    [61698] = true, -- Major Fortitude
    [61704] = true, -- Minor Endurance
    [61705] = true, -- Major Endurance
    [61706] = true, -- Minor Intellect
    [61707] = true, -- Major Intellect
    [61685] = true, -- Minor Sorcery
    [61687] = true, -- Major Sorcery
    [61691] = true, -- Minor Prophecy
    [61689] = true, -- Major Prophecy
    [61662] = true, -- Minor Brutality
    [61665] = true, -- Major Brutality
    [61666] = true, -- Minor Savagery
    [61667] = true, -- Major Savagery
    [61744] = true, -- Minor Berserk
    [61745] = true, -- Major Berserk
    [61746] = true, -- Minor Force
    [61747] = true, -- Major Force
    [61549] = true, -- Minor Vitality
    [61713] = true, -- Major Vitality
    [61710] = true, -- Minor Mending
    [61711] = true, -- Major Mending
    [61721] = true, -- Minor Protection
    [61722] = true, -- Major Protection
    [61715] = true, -- Minor Evasion
    [61716] = true, -- Major Evasion
    [61735] = true, -- Minor Expedition
    [61736] = true, -- Major Expedition
    [63569] = true, -- Major Gallop
    [61708] = true, -- Minor Heroism
    [61709] = true, -- Major Heroism
    [88490] = true, -- Minor Toughness
    [147417] = true, -- Minor Courage
    [109966] = true, -- Major Courage

    -- Major / Minor Debuffs
    [61742] = true, -- Minor Breach
    [61743] = true, -- Major Breach
    [79717] = true, -- Minor Vulnerability
    [106754] = true, -- Major Vulnerability
    [61723] = true, -- Minor Maim
    [61725] = true, -- Major Maim
    [61726] = true, -- Minor Defile
    [61727] = true, -- Major Defile
    [88401] = true, -- Minor Magickasteal
    [86304] = true, -- Minor Lifesteal
    [79907] = true, -- Minor Enervation
    [79895] = true, -- Minor Uncertainty
    [79867] = true, -- Minor Cowardice
    [147643] = true, -- Major Cowardice
    [61733] = true, -- Minor Mangle
    [140699] = true, -- Minor Timidity
    [145975] = true, -- Minor Brittle
    --[145977] = true, -- Major Brittle (Unused)

    -- Slayer / Aegis
    [76618] = true, -- Minor Aegis
    [93123] = true, -- Major Aegis
    [76617] = true, -- Minor Slayer
    [93109] = true, -- Major Slayer

    -- Empower
    [61737] = true, -- Empower
}

--------------------------------------------------------------------------------------------------------------------------------
-- Filter out Debuffs to always display regardless of whether they are sourced from the player - BY NAME
--------------------------------------------------------------------------------------------------------------------------------
Effects.DebuffDisplayOverrideName = {
    [Abilities.Skill_Off_Balance]               = true,
}

--------------------------------------------------------------------------------------------------------------------------------
-- Adds this aura to a list of fake Ground auras to display when the player casts them
--------------------------------------------------------------------------------------------------------------------------------
Effects.EffectGroundDisplay = {
    -- Required:
        -- buff, debuff, ground = true/false -- Choose whether this effect shows up in any of these containers
    -- Optional:
        --name = '' -- Add a custom name
        --icon = '' -- Add a custom icon
        --stackAdd = # -- How many stacks to add when this effect begins (used for Ground Mines)
        --stackRemove = # -- How many stacks to remove when this effect ends (used for Ground Mines)
        --stackReset = # -- Maximum stack counter (used for Ground Mines)
        --noRemove = true -- Do not end this aura on EFFECT_RESULT_FADED

    -- Cyrodiil
    [88714] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds', name = Abilities.Skill_Meatbag_Catapult, buff = false, debuff = false, ground = true }, -- Meatbag (Meatbag Catapult)
    [104700] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_oil_snare.dds', name = Abilities.Skill_Oil_Catapult, buff = false, debuff = false, ground = true }, -- Twisting Path (Oil Catapult)
    [104690] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_scattershot_catapult.dds', name = Abilities.Skill_Scattershot_Catapult, buff = false, debuff = false, ground = true }, -- Twisting Path (Scattershot Catapult)

    -- Monster Sets
    [59590] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bogdan.dds', name = Abilities.Set_Bogdan_the_Nightflame, buff = true, debuff = false, ground = false }, -- Imperial Prison Item Set (Bogdan the Nightflame)
    [97901] = { icon = 'LuiExtended/media/icons/abilities/ability_set_domihaus_stone.dds', buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus)
    [97882] = { icon = 'LuiExtended/media/icons/abilities/ability_set_domihaus_fire.dds', buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus)
    [97855] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds', buff = true, debuff = false, ground = false }, -- Earthgore (Earthgore)
    [80527] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris.dds', buff = false, debuff = false, ground = true }, -- Ilambris (Ilambris)
    [59587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds', name = Abilities.Set_Lord_Warden_Dusk, buff = true, debuff = false, ground = false }, -- Lord Warden (Lord Warden)
    [59568] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = Abilities.Set_Scourge_Harvester, buff = true, debuff = false, ground = false, tooltip = Tooltips.Set_Malubeth_Heal  }, -- Scourge Harvest (Malubeth)
    [59508] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maw_of_the_infernal.dds', name = Abilities.Set_Maw_of_the_Infernal, buff = true, debuff = false, ground = false }, -- Banished Cells Item Set (Maw of the Infernal)
    [81036] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds', buff = true, debuff = false, ground = false }, -- Sentinel of Rkugamz
    [80954] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_shadow_proxy.dds', name = Abilities.Set_Shadowrend, buff = true, debuff = false, ground = false }, -- Shadowrend Summon (Shadowrend)
    [59497] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_white.dds', buff = false, debuff = false, ground = true }, -- Spawn of Mephala (Spawn of Mephala)
    [80523] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_enervating_stone.dds', buff = false, debuff = false, ground = true }, -- Stormfist (Stormfist)
    [102093] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds', buff = false, debuff = false, ground = true }, -- Thurvokun
    [59594] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds', name = Abilities.Set_Nerieneth, buff = false, debuff = false, ground = true }, -- Crypt of Hearts Item Set (Nerien'eth)
    [80545] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sellistrix.dds', buff = false, debuff = false, ground = true }, -- Sellistrix (Sellistrix)
    --[102136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_zaan.dds', buff = true, debuff = false, ground = false }, -- Zaan -- Buff icon for Zaan, may reimplement if I add a way to override tooltips for these.

    -- Crafted Sets
    [75930] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds', name = Abilities.Set_Eternal_Hunt, buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 7 }, -- Daedric Mines (Eternal Hunt)
    [71671] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_summon.dds', buff = true, debuff = false, ground = false }, -- Morkuldin (Morkuldin)
    [113181] = { icon = 'esoui/art/icons/mm_teaser.dds', buff = true, debuff = false, ground = false }, -- Grave-Stake Collector (Grave-Stake Collector)
    [121915] = { icon = 'LuiExtended/media/icons/abilities/ability_set_honors_scorn.dds', name = Abilities.Set_Honors_Scorn, buff = false, debuff = false, ground = true }, -- Coldharbour's Favorite (Coldharbour's Favorite)
    [121912] = { icon = 'LuiExtended/media/icons/abilities/ability_set_honors_love.dds', name = Abilities.Set_Honors_Love, buff = true, debuff = false, ground = false }, -- Coldharbour's Favorite (Coldharbour's Favorite)

    -- Overland Sets
    [75691] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds', buff = false, debuff = false, ground = true }, -- Bahraha's Curse
    [71664] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds', buff = false, debuff = false, ground = true }, -- Trinimac's Valor
    [135659] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winters_respite.dds', buff = true, debuff = false, ground = false }, -- Winter's Respite (of Winter's Respite)

    -- Dungeon Sets
    [97538] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', buff = true, debuff = false, ground = false }, -- Draugr's Rest
    [102106] = { icon = 'esoui/art/icons/achievement_bossflavoreasy.dds', name = Abilities.Set_Plague_Slinger, buff = false, debuff = false, ground = true }, -- Skeever Corpse
    [97908] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hagravens_garden.dds', buff = true, debuff = false, ground = false }, -- Hagraven's Garden (Hagraven's)
    [67205] = { icon = 'LuiExtended/media/icons/abilities/ability_set_leeching_plate.dds', buff = false, debuff = false, ground = true }, -- Leeching Plate (of Leeching)
    [84354] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_green.dds', buff = false, debuff = false, ground = true }, -- Hand of Mephala (of Mephala's Hand)
    [126924] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hollowfang.dds', buff = true, debuff = false, ground = false }, -- Hollowfang Thirst (Hollowfang Thirst)
    [133493] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aegis_caller.dds', name = Abilities.Set_Aegis_Caller, buff = false, debuff = false, ground = true }, -- Aegis Caller (Aegis Caller's)

    -- Trial Sets
    [107141] = { icon = 'LuiExtended/media/icons/abilities/ability_set_olorime.dds', name = Abilities.Set_Vestment_of_Olorime, buff = true, debuff = false, ground = false }, -- Vestment of Olirime (Olorime's)
    [109084] = { icon = 'LuiExtended/media/icons/abilities/ability_set_olorime.dds', name = Abilities.Set_Vestment_of_Olorime, buff = true, debuff = false, ground = false }, -- Ideal Vestment of Olirime (Olorime's Perfect)
    [107095] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds', buff = true, debuff = false, ground = false }, -- Mantle of Siroria (Siroria's)
    [109081] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds', name = Abilities.Set_Mantle_of_Siroria, buff = true, debuff = false, ground = false }, -- Ideal Mantle of Siroria (Perfect Siroria's)
    [136098] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds', buff = true, debuff = false, ground = false }, -- Kyne's Blessing (of Kyne's Wind)
    [137995] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds', buff = true, debuff = false, ground = false }, -- Kyne's Blessing (of Kyne's Wind (Perfect))

    -- Used only to flag abilities for Tooltips
    [75814] = { buff = false, debuff = false, ground = false }, -- Lunar Bastion (Lunar Bastion)

    ---------------------------
    -- Class Abilities --------
    ---------------------------

    -- Dragonknight
    [28988] = { buff = false, debuff = false, ground = true }, -- Dragonknight Standard (Dragonknight Standard)
    [32958] = { buff = false, debuff = false, ground = true, noRemove = true }, -- Shifting Standard (Shifting Standard)
    [32947] = { buff = false, debuff = false, ground = true }, -- Standard of Might (Standard of Might)
    [29059] = { buff = true, debuff = false, ground = false }, -- Ash Cloud (Ash Cloud)
    [20779] = { buff = true, debuff = false, ground = false }, -- Cinder Storm (Cinder Storm)
    [32710] = { buff = false, debuff = false, ground = true }, -- Eruption (Eruption)

    -- Nightblade
    [33195] = { buff = true, debuff = false, ground = false }, -- Path of Darkness (Path of Darkness)
    [36049] = { buff = false, debuff = false, ground = true }, -- Twisting Path (Twisting Path)
    [36028] = { buff = true, debuff = false, ground = false }, -- Refreshing Path (Refreshing Path)
    [38517] = { buff = true, debuff = false, ground = false }, -- Summon Shade (Summon Shade)
    [88662] = { buff = true, debuff = false, ground = false }, -- Summon Shade (Summon Shade) -- Khajiit
    [88663] = { buff = true, debuff = false, ground = false }, -- Summon Shade (Summon Shade) -- Argonian
    [35438] = { buff = true, debuff = false, ground = false }, -- Dark Shade (Dark Shade)
    [88677] = { buff = true, debuff = false, ground = false }, -- Dark Shade (Dark Shade) -- Khajiit
    [88678] = { buff = true, debuff = false, ground = false }, -- Dark Shade (Dark Shade) -- Argonian
    [38528] = { name = Abilities.Skill_Shadow_Image, buff = true, debuff = false, ground = false }, -- Shadow (Shadow Image)
    [88696] = { name = Abilities.Skill_Shadow_Image, buff = true, debuff = false, ground = false }, -- Shadow (Shadow Image) -- Khajiit
    [88697] = { name = Abilities.Skill_Shadow_Image, buff = true, debuff = false, ground = false }, -- Shadow (Shadow Image) -- Argonian
    [37475] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 2 }, -- Manifestation of Terror (Nightblade)
    [25411] = { buff = true, debuff = false, ground = false }, -- Consuming Darkness (Consuming Darkness)
    [36493] = { buff = true, debuff = false, ground = false }, -- Bolstering Darkness (Bolstering Darkness)
    [36485] = { buff = true, debuff = false, ground = false }, -- Veil of Blades (Veil of Blades)

    -- Sorcerer
    [24830] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3, icon = 'esoui/art/icons/ability_sorcerer_daedric_mines.dds' }, -- Daedric Mines (Daedric Mines)
    [24847] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3, icon = 'esoui/art/icons/ability_sorcerer_daedric_tomb.dds', name = Abilities.Skill_Daedric_Tomb }, -- Daedric Mines (Daedric Tomb)
    [25158] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 5, icon = 'esoui/art/icons/ability_sorcerer_daedric_minefield.dds', name = Abilities.Skill_Daedric_Minefield }, -- Daedric Mines (Daedric Minefield)
    [27706] = { buff = false, debuff = false, ground = true }, -- Negate Magic (Negate Magic)
    [28341] = { buff = false, debuff = false, ground = true }, -- Suppression Field (Suppression Field)
    [28348] = { buff = false, debuff = false, ground = true }, -- Absorption Field (Absorption Field)
    [23182] = { buff = false, debuff = false, ground = true }, -- Lightning Splash (Lightning Splash)
    [23200] = { buff = false, debuff = false, ground = true }, -- Liquid Lightning (Liquid Lightning)
    [23205] = { buff = false, debuff = false, ground = true }, -- Lightning Flood (Lightning Flood)
    [23279] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_intercept.dds', name = Abilities.Skill_Intercept, buff = true, debuff = false, ground = false }, -- Ball of Lightning (Ball of Lightning)

    -- Templar
    [95933] = { icon = 'esoui/art/icons/ability_templar_sun_strike.dds', buff = false, debuff = false, ground = true }, -- Spear Shards (Spear Shards)
    [95957] = { icon = 'esoui/art/icons/ability_templar_light_strike.dds', buff = false, debuff = false, ground = true }, -- Luminous Shards (Luminous Shards)
    [26880] = { icon = 'esoui/art/icons/ability_templarsun_thrust.dds', buff = false, debuff = false, ground = true }, -- Blazing Spear (Blazing Spear)
    [21976] = { icon = 'esoui/art/icons/ability_templar_nova.dds', buff = false, debuff = false, ground = true }, -- Nova (Nova)
    [22003] = { icon = 'esoui/art/icons/ability_templar_solar_prison.dds', buff = false, debuff = false, ground = true }, -- Solar Prison (Solar Prison)
    [22001] = { icon = 'esoui/art/icons/ability_templar_solar_disturbance.dds', buff = false, debuff = false, ground = true }, -- Solar Disturbance (Solar Disturbance)

    [22234] = { buff = true, debuff = false, ground = false }, -- Rune Focus (Rune Focus)

    -- Used only to flag abilities for Tooltips
    [22265] = { buff = false, debuff = false, ground = false }, -- Cleansing Ritual (Cleansing Ritual)
    [22259] = { buff = false, debuff = false, ground = false }, -- Ritual of Retribution (Ritual of Retribution)
    [22262] = { buff = false, debuff = false, ground = false }, -- Extended Ritual (Extended Ritual)

    -- Warden
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

    -- Necromancer
    [115252] = { buff = false, debuff = false, ground = true }, -- Boneyard (Boneyard)
    [117805] = { buff = false, debuff = false, ground = true }, -- Unnerving Boneyard (Unnerving Boneyard)
    [117850] = { buff = false, debuff = false, ground = true }, -- Avid Boneyard (Avid Boneyard)

    [116445] = { buff = false, debuff = false, ground = true  }, -- Shocking Siphon (Shocking Siphon)
    [118764] = { buff = false, debuff = false, ground = true  }, -- Detonating Siphon (Detonating Siphon)
    [118009] = { buff = false, debuff = false, ground = true  }, -- Mystic Siphon (Mystic Siphon)

    [122174] = { buff = false, debuff = false, ground = true }, -- Frozen Colossus (Frozen Colossus)
    [122395] = { buff = false, debuff = false, ground = true }, -- Pestilent Colossus (Pestilent Colossus)
    [122388] = { buff = false, debuff = false, ground = true }, -- Glacial Colossus (Glacial Colossus)

    [115093] = { buff = true, debuff = false, ground = false }, -- Bone Totem (Bone Totem)
    [118380] = { buff = true, debuff = false, ground = false }, -- Remote Totem (Remote Totem)
    [118404] = { buff = true, debuff = false, ground = false }, -- Agony Totem (Agony Totem)

    [115326] = { buff = true, debuff = false, ground = false, icon = 'esoui/art/icons/ability_necromancer_016.dds' }, -- Life amid Death (Life amid Death)
    [118022] = { buff = true, debuff = false, ground = false, icon = 'esoui/art/icons/ability_necromancer_016_a.dds' }, -- Renewing Undeath (Renewing Undeath)
    [118814] = { buff = true, debuff = false, ground = false, icon = 'esoui/art/icons/ability_necromancer_016_b.dds' }, -- Enduring Undeath (Enduring Undeath)

    ---------------------------
    -- Two-Handed -------------
    ---------------------------

    [38791] = { buff = false, debuff = false, ground = true }, -- Stampede (Stampede)

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

    [28807] = { buff = false, debuff = false, ground = true }, -- Wall of Fire (Wall of Elements)
    [28854] = { buff = false, debuff = false, ground = true }, -- Wall of Storms (Wall of Elements)
    [28849] = { buff = false, debuff = false, ground = true }, -- Wall of Frost (Wall of Elements)
    [39053] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Fire (Unstable Wall of Elements)
    [39073] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Storms (Unstable Wall of Elements)
    [39067] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Frost (Unstable Wall of Elements)
    [39012] = { buff = false, debuff = false, ground = true }, -- Blockade of Fire (Elemental Blockade)
    [39018] = { buff = false, debuff = false, ground = true }, -- Blockade of Storms (Elemental Blockade)
    [39028] = { buff = false, debuff = false, ground = true }, -- Blockade of Frost (Elemental Blockade)
    [83625] = { buff = false, debuff = false, ground = true }, -- Fire Storm (Elemental Storm)
    [83630] = { buff = false, debuff = false, ground = true }, -- Thunder Storm (Elemental Storm)
    [83628] = { buff = false, debuff = false, ground = true }, -- Ice Storm (Elemental Storm)
    [85126] = { buff = false, debuff = false, ground = true }, -- Fiery Rage (Elemental Rage)
    [85130] = { buff = false, debuff = false, ground = true }, -- Thunderous Rage (Elemental Rage)
    [85128] = { buff = false, debuff = false, ground = true }, -- Icy Rage (Elemental Rage)

    ---------------------------
    -- Restoration Staff ------
    ---------------------------

    [28385] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Grand Healing (Grand Healing)
    [40058] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Illustrious Healing (Illustrious Healing)
    [40060] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Healing Springs (Healing Springs)

    ---------------------------
    -- Fighters Guild ---------
    ---------------------------

    [35737] = { buff = true, debuff = false, ground = false }, -- Circle of Protection (Circle of Protection)
    [40181] = { buff = true, debuff = false, ground = false }, -- Turn Evil (Turn Evil)
    [40169] = { buff = true, debuff = false, ground = false }, -- Ring of Preservation (Ring of Preservation)
    [35750] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Trap Beast (Trap Beast)
    [40382] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Barbed Trap (Barbed Trap)
    [40372] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Lightweight Beast Trap (Lightweight Beast Trap)

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
    -- Psijic Order -----------
    ---------------------------

    [104079] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Time Freeze (Time Freeze)

    ---------------------------
    -- Undaunted --------------
    ---------------------------

    [39489] = { buff = true, debuff = false, ground = false }, -- Blood Altar (Blood Altar)
    [41967] = { buff = true, debuff = false, ground = false }, -- Sanguine Altar (Sanguine Altar)
    [41958] = { buff = true, debuff = false, ground = false }, -- Overflowing Altar (Overflowing Altar)
    [39425] = { buff = false, debuff = false, ground = true }, -- Trapping Webs (Trapping Webs)
    [41990] = { buff = false, debuff = false, ground = true }, -- Shadow Silk (Shadow Silk)
    [42012] = { buff = false, debuff = false, ground = true }, -- Tangling Webs (Tangling Webs)

    [39298] = { buff = false, debuff = false, ground = true }, -- Necrotic Orb (Necrotic Orb)
    [42028] = { buff = false, debuff = false, ground = true }, -- Mystic Orb (Mystic Orb)
    [42038] = { buff = true, debuff = false, ground = false }, -- Energy Orb (Energy Orb)

    ---------------------------
    -- Assault ----------------
    ---------------------------

    [38549] = { icon = 'esoui/art/icons/ability_ava_001.dds', buff = false, debuff = false, ground = true }, -- Caltrops (Caltrops)
    [40265] = { icon = 'esoui/art/icons/ability_ava_001_a.dds', buff = false, debuff = false, ground = true }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40251] = { icon = 'esoui/art/icons/ability_ava_001_b.dds', name = Abilities.Skill_Razor_Caltrops, buff = false, debuff = false, ground = true }, -- Caltrops (Razor Caltrops)

    ---------------------------
    -- Support ----------------
    ---------------------------

    [38570] = { buff = true, debuff = false, ground = false }, -- Siege Shield (Siege Shield)
    [40229] = { buff = true, debuff = false, ground = false }, -- Siege Weapon Shield (Siege Weapon Shield)
    [40226] = { buff = true, debuff = false, ground = false }, -- Propelling Shield (Propelling Shield)

    [61498] = { buff = false, debuff = false, ground = true }, -- Revealing Flare (Revealing Flare)
    [61522] = { name = Abilities.Skill_Lingering_Flare, buff = false, debuff = false, ground = true }, -- Nova (Lingering Flare)
    [61526] = { buff = false, debuff = false, ground = true }, -- Blinding Flare (Blinding Flare)
}

--------------------------------------------------------------------------------------------------------------------------------
-- This will create an effect on the player or target when X skill is detected as active. SpellCastBuffs creates the buff by the name listed here, this way if 3 or 4 effects all need to display for 1 ability, it will only show the one aura.
--------------------------------------------------------------------------------------------------------------------------------
Effects.EffectCreateSkillAura = {
    -- Required:
        -- abilityId = #
    -- Optional:
        --name = '' -- Add a custom name
        --icon = '' -- Add a custom icon
        -- removeOnEnd = true -- Remove this aura when one of these effects ends.
        -- requiredStack = number -- Requires this number of stacks to apply

    [65235] = { removeOnEnd = true, abilityId = 33097 }, -- Enrage (Vosh Rakh Devoted)
    [50187] = { removeOnEnd = true, abilityId = 33097 }, -- Enrage (Mantikora)
    [56689] = { removeOnEnd = true, abilityId = 33097 }, -- Enraged (Mantikora)
    [72725] = { removeOnEnd = true, abilityId = 28301 }, -- Fool Me Once (Sentinel) (TG DLC)
}

--------------------------------------------------------------------------------------------------------------------------------
-- We don't add bar highlights for 0 duration abilities, a few abilities with dynamic durations show as 0 duration so we need this override table.
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddNoDurationBarHighlight = {

    -- Necromancer
    [115240] = true, -- Bitter Harvest
    [124165] = true, -- Deaden Pain
    [124193] = true, -- Necrotic Potency
    [118814] = true, -- Enduring Undeath

}

-- Also track this id on bar highlight
-- SECONDARY ID = ORIGINAL BAR HIGHLIGHT ID
Effects.BarHighlightExtraId = {

    -- Dragonknight
    [20253] = 31898, -- Burning Talons
    [61785] = 32685, -- Fossilize

    -- Sorcerer
    [89491] = 24330, -- Haunting Curse
    [132946] = 28482, -- Streak

    -- Warden
    [130140] = 130139, -- Cutting Dive --> Off-Balance
    [87194] = 88761, -- Minor Protection --> Major Resolve (Ice Fortress)

    -- Necromancer
    [143915] = 121513, -- Grave Grasp
    [143917] = 121513, -- Grave Grasp
    [118325] = 118309, -- Ghostly Embrace
    [143945] = 118309, -- Ghostly Embrace
    [143948] = 118354, -- Empowering Grasp
    [143949] = 118354, -- Empowering Grasp

    -- Bow
    [38707] = 100302, -- Bombard --> Piercing Spray
    [38706] = 100302, -- Bombard --> Piercing Spray
    [38703] = 100302, -- Acid Spray --> Piercing Spray

    [28887] = 113627, -- Virulent Shot --> Scatter Shot
    [38674] = 113627, -- Virulent Shot --> Magnum Shot
    [131688] = 113627, -- Virulent Shot --> Draining Shot

    -- Mages Guild
    [40468] = 40465, -- Scalding Rune
    [40476] = 40470, -- Volcanic Rune

    -- Psijic Order
    [104085] = 104079, -- Time Freeze

    -- Soul Magic
    [126890] = 126891, -- Soul Trap
    [126895] = 126894, -- Soul Splitting Trap
    [126897] = 126898, -- Consuming Trap

    -- Werewolf
    [32633] = 137257, -- Roar --> Off Balance
    [39114] = 137312, --> Deafening Roar --> Off Balance -- TODO: Could possibly track Major Breach/Minor Maim

    -- Vampire
    [138130] = 138098, -- Stupefy

}

-- When the primary tracked effect fades, do an iteration over player buffs to see if another buff is present, if so trigger bar highlight for it
-- ORIGINAL TRACKED ID = OTHER ID'S TO CHECK FOR
-- Priority is ID1 > ID2 if present
-- If duration value is set to an ID, the duration will be pulled from this ID
-- If durationMod value is set to an ID, this value will be subtracted from the final duration (UNUSED)
-- Note that any secondary id's for Bar Highlight in the table above will set their id to the original tracked id here
-- Note all effects will check unitTag unless an id2Tag or id3Tag are specified in which case they will switch unitTags when searching for other ids.
Effects.BarHighlightCheckOnFade = {

    -- Dragonknight
    [108798] = { id1 = 21014, unitTag = "player" }, -- Protective Plate
    [31898] = { id1 = 20253, id2 = 31898, unitTag = "reticleover" }, -- Burning Talons

    -- Nightblade
    [125314] = { duration = 90620, durationMod = 125314, unitTag = "player" }, -- Phantasmal Escape --> Major Evasion

    -- Sorcerer
    [24165] = { id1 = 24165, unitTag = "player" }, -- Bound Armaments

    -- Warden
    [130139] = { id1 = 130140, id2 = 130139, unitTag = "reticleover" }, -- Off-Balance --> Cutting Dive / Off-Balance

    [85552] = { id1 = 85552, unitTag = "player" }, -- Living Vines (If player mouses over target with this ability and mouses off and has this ability on themselves, we want to resume that)
    [85850] = { id1 = 85850, unitTag = "player" }, -- Leeching Vines (If player mouses over target with this ability and mouses off and has this ability on themselves, we want to resume that)
    [85851] = { id1 = 85851, unitTag = "player" }, -- Living Trellis (If player mouses over target with this ability and mouses off and has this ability on themselves, we want to resume that)
    --[85807] = { id1 = 91819, unitTag = "player" }, -- Healing Thicket -- TODO: Doesn't work for some reason

    -- Necromancer
    [121513] = { id1 = 121513, id2 = 143915, id3 = 143917, unitTag = "reticleover" }, -- Minor Maim --> Grave Grasp / Minor Maim
    [118309] = { id1 = 118309, id2 = 118325, id3 = 143945, unitTag = "reticleover" }, -- Minor Maim --> Ghostly Embrace / Minor Maim
    [118354] = { id1 = 118354, id2 = 143948, id3 = 143949, unitTag = "reticleover" }, -- Minor Maim --> Empowering Grasp / Minor Maim

    -- Two Handed
    [38797] = { duration = 38794, durationMod = 38797, unitTag = "player" }, -- Forward Momentum --> Major Brutality / Minor Endurance

    -- Dual Wield
    [126667] = { id1 = 61665, unitTag = "player" }, -- Flying Blade --> Major Bruality

    -- Bow
    [100302] = {
    { id1 = 38707, id2 = 38706, id3 = 100302, unitTag = "reticleover" }, -- Piercing Spray --> Bombard / Bombard / Piercing Spray
    { id1 = 38703, id2 = 100302, unitTag = "reticleover" }, -- Piercing Spray --> Acid Spray / Piercing Spray
    },
    [113627] = {
    { id1 = 28887, id2 = 113627, unitTag = "reticleover" }, -- Virulent Shot --> Scatter Shot / Virulent Shot
    { id1 = 38674, id2 = 113627, unitTag = "reticleover" }, -- Virulent Shot --> Magnum Shot / Virulent Shot
    { id1 = 131688, id2 = 113627, unitTag = "reticleover" }, -- Virulent Shot --> Draining Shot / Virulent Shot
    },
    -- Medium Armor
    [39196] = { duration = 63019, durationMod = 39196, unitTag = "player" }, -- Shuffle --> Major Evasion

    -- Heavy Armor
    [126581] = { duration = 63084, durationMod = 126581, unitTag = "player" }, -- Unstoppable --> Major Resolve
    [126582] = { duration = 63134, durationMod = 126582, unitTag = "player" }, -- Immovable Brute --> Major Resolve
    [126583] = { duration = 63119, durationMod = 126583, unitTag = "player" }, -- Immovable --> Major Resolve

    -- Werewolf

    [137257] = { id1 = 137257, id2 = 32633, unitTag = "reticleover" }, -- Off Balance --> Roar / Off Balance
    [137312] = { id1 = 137312, id2 = 39114, unitTag = "reticleover" }, -- Off Balance --> Deafening Roar / Off Balance

    -- Fighters Guild
    [35750] = { duration = 68595, unitTag = "player" }, -- Trap Beast --> Minor Force
    [40382] = { duration = 68632, unitTag = "player" }, -- Barbed Trap --> Minor Force
    [40372] = { duration = 68628, unitTag = "player" }, -- Lightweight Beast Trap --> Minor Force

    -- Mages Guild
    [40449] = { id1 = 48136, unitTag = "player" }, -- Spell Symmetry
    [48141] = { duration = 80160, durationMod = 48141, unitTag = "player" }, -- Balance --> Major Resolve

    -- Support
    [40237] = { id1 = 40238, unitTag = "player" }, -- Reviving Barrier --> Reviving Barrier Heal

    -- Volendrung
    [116366] = { duration = 116374, durationMod = 116366, unitTag = "player" }, -- Pariah's Resolve

}



--------------------------------------------------------------------------------------------------------------------------------
-- Data for icon & description to show for the fake Disguise buff applied to the player.
--------------------------------------------------------------------------------------------------------------------------------
Effects.DisguiseIcons = {
    -- Required:
        -- icon = '' -- Icon to use
        -- description = '' -- String to use for description when equipped (used by Chat Announcements)
        -- id = # -- Ability id to pull a tooltip description from

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
    [64260] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'in colorful Dark Elf clothing.', id = 20175 }, -- NO ICON (Not sure it exists)
    [71090] = { icon = 'LuiExtended/media/icons/disguises/disguise_servants_outfit.dds', description = 'as a servant of the Iron Wheel.', id = 27649 }, -- TODO: Check this ID is right
    [71541] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Castle Kvatch sentinel.', id = nil }, -- NO ICON (Not sure it exists)
    [71789] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Castle Kvatch sentinel.', id = nil }, -- NO ICON (Not sure it exists)
    --[79332] = { icon = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds', description = 'as a monk.' }, -- HAS AN AURA SO NOT NECESSARY (Note - we make an exception to HIDE this itemId to prevent errors)
    [79505] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Sentinel Guard.', id = nil }, -- NO ICON (Not sure it exists)
    [94209] = { icon = 'LuiExtended/media/icons/disguises/disguise_scarlet_judges_regalia.dds', description = 'as The Scarlet Judge.', id = 85204 },

    [0] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'by the Earring of Disguise.', id = nil }, -- Generic Disguise override - at least the Arenthia quest in Reaper's March applies a disguise without utilizing an item
    [55262] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'by the Earring of Disguise.', id = nil }, -- Compatibility - for Arenthia quest is player is wearing a Guild Tabard
}

--------------------------------------------------------------------------------------------------------------------------------
-- Icon to display for Assistant Collectibles
--------------------------------------------------------------------------------------------------------------------------------
Effects.AssistantIcons = {
    [GetCollectibleName(301)] = 'LuiExtended/media/icons/assistants/assistant_nuzhimeh.dds',
    [GetCollectibleName(300)] = 'LuiExtended/media/icons/assistants/assistant_pirharri.dds',
    [GetCollectibleName(267)] = 'LuiExtended/media/icons/assistants/assistant_tythis.dds',
    [GetCollectibleName(6376)] = 'LuiExtended/media/icons/assistants/assistant_ezabi.dds',
    [GetCollectibleName(6378)] = 'LuiExtended/media/icons/assistants/assistant_fezez.dds',
    [GetCollectibleName(8994)] = 'LuiExtended/media/icons/assistants/assistant_crowbanker.dds',
    [GetCollectibleName(8995)] = 'LuiExtended/media/icons/assistants/assistant_crowmerchant.dds',
    [GetCollectibleName(9743)] = 'LuiExtended/media/icons/assistants/assistant_factotumbanker.dds',
    [GetCollectibleName(9744)] = 'LuiExtended/media/icons/assistants/assistant_factotummerchant.dds',
	[GetCollectibleName(9745)] = 'LuiExtended/media/icons/assistants/assistant_ghrasharog.dds',
	[GetCollectibleName(10184)] = 'LuiExtended/media/icons/assistants/assistant_giladil.dds',
}

--------------------------------------------------------------------------------------------------------------------------------
-- When a target name matches a string here, add id's in the table with the name and icon specified. We use this primarily to add CC Immunity buffs for bosses.
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddNameAura = {

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
    [Unitnames.NPC_Daedroth] = { [1] = { id = 999013, zone = { [935] = true }, } }, -- Daedroth

    -- World Bosses

    -- Auridon
    [Unitnames.Boss_Norendo] = { [1] = { id = 33097 } }, -- Auridon (Soulfire Plateau)
    [Unitnames.Boss_Eraman] = { [1] = { id = 33097 } }, -- Auridon (Soulfire Plateau)
    [Unitnames.Boss_Quendia] = { [1] = { id = 33097 } }, -- Auridon (Soulfire Plateau)
    [Unitnames.Boss_Quenyas] = { [1] = { id = 33097 } }, -- Auridon (Seaside Scarp Camp)
    [Unitnames.Boss_Captain_Blanchete] = { [1] = { id = 33097 } }, -- Auridon (Wreck of the Raptor)
    [Unitnames.Boss_Snapjaw] = { [1] = { id = 33097 } }, -- Auridon (Heretic's Summons)
    [Unitnames.Boss_The_Nestmother] = { [1] = { id = 33097 } }, -- Auridon (Nestmothers Den)
    [Unitnames.Boss_Anarume] = { [1] = { id = 33097 } }, -- Auridon (Heritance Proving Ground)

    -- Grahtwood
    [Unitnames.Boss_Bavura_the_Blizzard] = { [1] = { id = 33097 } }, -- Grahtwood (Nindaeril's Perch)
    [Unitnames.Boss_Nindaeril_the_Monsoon] = { [1] = { id = 33097 } }, -- Grahtwood (Nindaeril's Perch)
    [Unitnames.Boss_Shagura] = { [1] = { id = 33097 } }, -- Grahtwood (Hircine's Henge)
    [Unitnames.Boss_Gurgozu] = { [1] = { id = 33097 } }, -- Grahtwood (Hircine's Henge)
    [Unitnames.Boss_Valanirs_Shield] = { [1] = { id = 33097 } }, -- Grahtwood (Valanir's Rest)
    [Unitnames.Boss_Lady_Solace] = { [1] = { id = 33097 } }, -- Grahtwood (Lady Solace's Fen)
    [Unitnames.Boss_Otho_Rufinus] = { [1] = { id = 33097 } }, -- Grahtwood (Poacher Camp)
    [Unitnames.Boss_Thugrub_the_Reformed] = { [1] = { id = 33097 } }, -- Grahtwood (Thugrub's Cave)

    -- Greenshade
    [Unitnames.Boss_Gathongor_the_Mauler] = { [1] = { id = 33097 } }, -- Greenshade (Gathongor's Mine)
    [Unitnames.Boss_Smiles_With_Knife] = { [1] = { id = 33097 } }, -- Greenshade (Reconnaissance Camp)
    [Unitnames.Boss_Maheelius] = { [1] = { id = 33097 } }, -- Greenshade (Reconnaissance Camp)
    [Unitnames.Boss_Navlos] = { [1] = { id = 33097 } }, -- Greenshade (Reconnaissance Camp)
    [Unitnames.Boss_Heart_of_Rootwater] = { [1] = { id = 33097 } }, -- Greenshade (Rootwater Spring)
    [Unitnames.Boss_Thodundor_of_the_Hill] = { [1] = { id = 33097 } }, -- Greenshade (Thodundor's View)
    [Unitnames.Boss_Neiral] = { [1] = { id = 33097 } }, -- Greenshade (Maormer Camp View)
    [Unitnames.Boss_Hetsha] = { [1] = { id = 33097 } }, -- Greenshade (Maormer Camp View)
    [Unitnames.Boss_Jahlasri] = { [1] = { id = 33097 } }, -- Greenshade (Maormer Camp View)

    -- Malabal Tor
    [Unitnames.Boss_Thjormar_the_Drowned] = { [1] = { id = 33097 } }, -- Malabal Tor (Bitterpoint Strand)
    [Unitnames.Boss_Drowned_First_Mate] = { [1] = { id = 33097 } }, -- Malabal Tor (Bitterpoint Strand)
    [Unitnames.Boss_Dugan_the_Red] = { [1] = { id = 33097 } }, -- Malabal Tor (Dugan's Knoll)
    [Unitnames.Boss_Bagul] = { [1] = { id = 33097 } }, -- Malabal Tor (Dugan's Knoll)
    [Unitnames.Boss_Fangoz] = { [1] = { id = 33097 } }, -- Malabal Tor (Dugan's Knoll)
    [Unitnames.Boss_Bone_Grappler] = { [1] = { id = 33097 } }, -- Malabal Tor (Bone Grappler's Nest)
    [Unitnames.Boss_Tallatta_the_Lustrous] = { [1] = { id = 33097 } }, -- Malabal Tor (Jagged Grotto)
    [Unitnames.Boss_Commander_Faldethil] = { [1] = { id = 33097 } }, -- Malabal Tor (River Edge)

    -- Reaper's March
    [Unitnames.Boss_Gravecaller_Niramo] = { [1] = { id = 33097 } }, -- Reaper's March (Reaper's Henge)
    [Unitnames.Boss_Varien] = { [1] = { id = 33097 } }, -- Reaper's March (Reaper's Henge)
    [Unitnames.Boss_Dirge_of_Thorns] = { [1] = { id = 33097 } }, -- Reaper's March (Deathsong Cleft)
    [Unitnames.Boss_Ravenous_Loam] = { [1] = { id = 33097 } }, -- Reaper's March (Deathsong Cleft)
    [Unitnames.Boss_Queen_of_Three_Mercies] = { [1] = { id = 33097 } }, -- Reaper's March (Waterdancer Falls)
    [Unitnames.Boss_Overlord_Nur_dro] = { [1] = { id = 33097 } }, -- Reaper's March (Ushmal's Rest)
    [Unitnames.Boss_Big_Ozur] = { [1] = { id = 33097 } }, -- Reaper's March (Big Ozur's Valley)

    -- Glenumbra
    [Unitnames.Boss_Limbscather] = { [1] = { id = 33097 } }, -- Western Overlook (Glenumbra)
    [Unitnames.Boss_Salazar_the_Wolf] = { [1] = { id = 33097 } }, -- The Wolf's Camp (Glenumbra)
    [Unitnames.Boss_Lieutenant_Bran] = { [1] = { id = 33097 } }, -- The Wolf's Camp (Glenumbra)
    [Unitnames.Boss_Annyce] = { [1] = { id = 33097 } }, -- The Wolf's Camp (Glenumbra)
    [Unitnames.Boss_Asard_the_Putrid] = { [1] = { id = 33097 } }, -- The Wolf's Camp (Glenumbra)
    [Unitnames.Boss_Graufang] = { [1] = { id = 33097 } }, -- Seaview Point (Glenumbra)
    [Unitnames.Boss_Grivier_Bloodcaller] = { [1] = { id = 33097 } }, -- Balefire Island (Glenumbra)

    -- Stormhaven
    [Unitnames.Boss_Old_Widow_Silk] = { [1] = { id = 33097 } }, -- Spider Nest (Stormhaven)
    [Unitnames.Boss_Titanclaw] = { [1] = { id = 33097 } }, -- Mudcrab Beach (Stormhaven)
    [Unitnames.Boss_Brood_Queen] = { [1] = { id = 33097 } }, -- Dreugh Waters (Stormhaven)
    --[Unitnames.Boss_Cousin_Scrag] = { [1] = { id = 33097 } }, -- Scrag's Larder (Stormhaven)

    -- Rivenspire
    [Unitnames.Boss_Aesar_the_Hatespinner] = { [1] = { id = 33097 } }, -- Aesar's Web (Rivenspire)
    [Unitnames.Boss_Magdelena] = { [1] = { id = 33097 } }, -- Magdelena's Haunt (Rivenspire)
    [Unitnames.Boss_Calixte_Darkblood] = { [1] = { id = 33097 } }, -- Old Kalgon's Keep (Rivenspire)
    [Unitnames.Boss_Louna_Darkblood] = { [1] = { id = 33097 } }, -- Old Kalgon's Keep (Rivenspire)
    [Unitnames.Boss_Lyse_Darkblood] = { [1] = { id = 33097 } }, -- Old Kalgon's Keep (Rivenspire)
    [Unitnames.Boss_Stroda_gra_Drom] = { [1] = { id = 33097 } }, -- East-Rock Landing (Rivenspire)
    [Unitnames.Boss_Desuuga_the_Siren] = { [1] = { id = 33097 } }, -- Siren's Cove (Rivenspire)

    -- Public Dungeon
    [Unitnames.Boss_Nitch] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Thek_Elf_Stabber] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Black_Bessie] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Bloodroot] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Togga_the_Skewerer] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Dzeizik] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Slakkith] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    [Unitnames.Boss_Gorg] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)

    [Unitnames.Boss_Great_Thorn] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_The_Devil_Wrathmaw] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_Rootbiter] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_Silent_Claw] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_Thick_Bark] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    [Unitnames.Boss_Guardian_of_Root_Sunder] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)

    [Unitnames.Boss_Lost_Master] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)
    [Unitnames.Boss_Utiasl] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)
    [Unitnames.Boss_Skirar_the_Decaying] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)
    [Unitnames.Boss_Magna_Tharn] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)
    [Unitnames.Boss_Hannat_the_Bonebringer] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)

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
    --[Unitnames.NPC_Aura_of_Protection] = { [1] = { id = 33097 } }, -- TODO: Not actually CC immune despite CC not doing anything (maybe switch to knockback immunity eventually)
    --['Ice Pillar'] = { [1] = { id = 33097 } }, -- TODO: Not actually CC immune despite CC not doing anything (maybe switch to knockback immunity eventually)

    -- Bosses
    ['War Chief Ozozai'] = { [1] = { id = 33097 } },
    ['Broodbirther'] = { [1] = { id = 33097 } },

    ['Mad Griskild'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- A Web of Troubles
    ['Veya Releth'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell - Family Reunion
    ['Old Rust-Eye'] = { [1] = { id = 33097 } }, -- Delve -- Vvardenfell - Khartag Point
    ['Cliff Strider Matriarch'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Beckoner Morvayn'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Confessor Dradas'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Coaxer Veran'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Castigator Athin'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Stone-Boiler Omalas'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Brander Releth'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Mountain-Caller Hlaren'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Wakener Maras'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Nevena Nirith'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Mud-Tusk'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Guardian of Bthark'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Renduril the Hammer'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Friar Hadelar'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Steamreaver'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Artisan Lenarmen'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Nchulaeon the Eternal'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Nilarion the Cavalier'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Curate Erydno'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Inquires
    ['Savarak Fels'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Reclamining Vos
    ['Th\'krak the Tunnel-King'] = { [1] = { id = 33097 } }, -- Delve -- Vvardenfell -- Matus-Akin Egg Mine
    ['Slavemaster Arenim'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- The Heart of a Telvanni
    ['Chodala'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Intervention
    ['Clockwork Guardian'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Jovval Mortal-Bane'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Defense Core'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Mediator'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Mediator Core'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Assembly Core'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Barbas'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration

    --------------------------------------------
    -- ARENAS ----------------------------------
    --------------------------------------------

    -- Dragonstar Arena
    [Unitnames.Boss_Champion_Marcauld] = { [1] = { id = 33097 } }, -- Champion Marcauld
    [Unitnames.Boss_Yavni_Frost_Skin] = { [1] = { id = 33097 } }, -- Yavni Frost-Skin
    [Unitnames.Boss_Katti_Ice_Turner] = { [1] = { id = 33097 } }, -- Katti Ice-Turner
    [Unitnames.Boss_Shilia] = { [1] = { id = 33097 } }, -- Shilia
    [Unitnames.Boss_Nak_tah] = { [1] = { id = 33097 } }, -- Nak'tah
    [Unitnames.Boss_Earthen_Heart_Knight] = { [1] = { id = 33097 } }, -- Earthen Heart Knight
    [Unitnames.NPC_Anka_Ra_Shadowcaster] = { [1] = { id = 33097 } }, -- Anka-Ra Shadowcaster
    [Unitnames.Boss_Anala_tuwha] = { [1] = { id = 33097 } }, -- Anal'a Tu'wha
    [Unitnames.NPC_Pacthunter_Ranger] = { [1] = { id = 33097 } }, -- Pacthunter Ranger
    [Unitnames.Boss_Pishna_Longshot] = { [1] = { id = 33097 } }, -- Pishna Longshot
    [Unitnames.Boss_Shadow_Knight] = { [1] = { id = 33097, zone = { [635] = true }, } }, -- Shadow Knight (Dragonstar Arena)
    [Unitnames.Boss_Dark_Mage] = { [1] = { id = 33097, zone = { [635] = true }, } }, -- Dark Mage (Dragonstar Arena)
    [Unitnames.NPC_Dwarven_Fire_Centurion] = { [1] = { id = 33097, zone = { [635] = true }, } }, -- Dwarven Fire Centurion (Dragonstar Arena)
    [Unitnames.Boss_Mavus_Talnarith] =  { [1] = { id = 33097 } }, -- Mavus Talnarith
    [Unitnames.Boss_Zackael_Jonnicent] =  { [1] = { id = 33097 } }, -- Zackael Jonnicent
    [Unitnames.Boss_Rubyn_Jonnicent] =  { [1] = { id = 33097 } }, -- Rubyn Jonnicent
    [Unitnames.Boss_Vampire_Lord_Thisa] =  { [1] = { id = 33097 } }, -- Vampire Lord Thisa
    [Unitnames.Boss_Hiath_the_Battlemaster] =  { [1] = { id = 33097 } }, -- Hiath the Battlemaster

    -- Maelstrom Arena
    [Unitnames.Boss_Maxus_the_Many] = { [1] = { id = 33097 } }, -- Maxus the Many
    [Unitnames.NPC_Clockwork_Sentry] = { [1] = { id = 33097, zone = { [677] = true }, } }, -- Clockwork Sentry (Maelstrom Arena)
    [Unitnames.NPC_Queens_Pet] = { [1] = { id = 33097, zone = { [677] = true }, } }, -- Queen's Pet (Maelstrom Arena)
    [Unitnames.NPC_Queens_Champion] = { [1] = { id = 33097, zone = { [677] = true }, } }, -- Queen's Champion (Maelstrom Arena)
    [Unitnames.NPC_Queens_Advisor] = { [1] = { id = 33097, zone = { [677] = true }, } }, -- Queen's Advisor (Maelstrom Arena)
    [Unitnames.Boss_Lamia_Queen] = { [1] = { id = 33097, zone = { [677] = true }, } }, -- Lamia Queen (Maelstrom Arena)
    [Unitnames.Boss_The_Control_Guardian] = { [1] = { id = 33097 } }, -- The Control Guardian
    [Unitnames.NPC_Troll_Breaker] = { [1] = { id = 33097 } }, -- Troll Breaker
    [Unitnames.NPC_Ogre_Elder] = { [1] = { id = 33097, zone = { [677] = true }, } }, -- Ogre Elder (Maelstrom Arena)
    [Unitnames.Boss_Matriarch_Runa] = { [1] = { id = 33097 } }, -- Matriarch Runa

    --------------------------------------------
    -- DUNGEONS --------------------------------
    --------------------------------------------

    -- Banished Cells I
    [Unitnames.Boss_Cell_Haunter] = { [1] = { id = 33097 } }, -- Cell Haunter
    [Unitnames.Boss_Shadowrend] = { [1] = { id = 33097 } }, -- Shadowrend
    [Unitnames.Boss_Angata_the_Clannfear_Handler] = { [1] = { id = 33097 } }, -- Angata the Clannfear Handler
    [Unitnames.Boss_High_Kinlord_Rilis] = { [1] = { id = 33097 } }, -- High Kinlord Rilis

    -- Banished Cells II
    [Unitnames.Boss_Keeper_Areldur] = { [1] = { id = 33097 } }, -- Keeper Areldur
    [Unitnames.Boss_Maw_of_the_Infernal] = { [1] = { id = 33097 } }, -- Maw of the Infernal
    [Unitnames.Boss_Keeper_Voranil] = { [1] = { id = 33097 } }, -- Keeper Voranil
    [Unitnames.Boss_Keeper_Imiril] = { [1] = { id = 33097 } }, -- Keeper Imiril

    -- Elden Hollow I
    [Unitnames.Boss_Ancient_Spriggan] = { [1] = { id = 33097 } }, -- Ancient Spriggan
    [Unitnames.Boss_Akash_gra_Mal] = { [1] = { id = 33097 } }, -- Akash gra-Mal
    [Unitnames.Boss_Chokethorn]  = { [1] = { id = 33097 } }, -- Chokethorn
    [Unitnames.Boss_Nenesh_gro_Mal]  = { [1] = { id = 33097 } }, -- Nenesh gro-Mal
    [Unitnames.Boss_Leafseether]  = { [1] = { id = 33097 } }, -- Leafseether
    [Unitnames.Boss_Canonreeve_Oraneth]  = { [1] = { id = 33097 } }, -- Canonreeve Oraneth

    -- Elden Hollow II
    [Unitnames.Boss_Dubroze_the_Infestor] = { [1] = { id = 33097 } }, -- Dubroze the Infestor
    [Unitnames.Boss_Dark_Root] = { [1] = { id = 33097 } }, -- Dark Root
    [Unitnames.Boss_Azara_the_Frightener] = { [1] = { id = 33097 } }, -- Azara the Frightener
    [Unitnames.Boss_Shadow_Tendril] = { [1] = { id = 33097 } }, -- Shadow Tendril
    [Unitnames.Boss_Murklight] = { [1] = { id = 33097 } }, -- Murklight
    [Unitnames.Boss_The_Shadow_Guard] = { [1] = { id = 33097 } }, -- The Shadow Guard
    [Unitnames.Boss_Bogdan_the_Nightflame] = { [1] = { id = 33097 } }, -- Bogdan the Nightflame
    [Unitnames.Boss_Nova_Tendril] = { [1] = { id = 33097 } }, -- Nova Tendril

    -- City of Ash I
    [Unitnames.Boss_Golor_the_Banekin_Handler] = { [1] = { id = 33097 } }, -- Golor the Banekin Handler
    [Unitnames.Boss_Warden_of_the_Shrine] = { [1] = { id = 33097 } }, -- Warden of the Shrine
    [Unitnames.Boss_Infernal_Guardian] = { [1] = { id = 33097 } }, -- Infernal Guardian
    [Unitnames.Boss_Dark_Ember] = { [1] = { id = 33097 } }, -- Dark Ember
    [Unitnames.Boss_Rothariel_Flameheart] = { [1] = { id = 33097 } }, -- Rothariel Flameheart
    [Unitnames.Boss_Razor_Master_Erthas] = { [1] = { id = 33097 } }, -- Razor Master Erthas

    -- City of Ash II
    [Unitnames.Boss_Akezel] = { [1] = { id = 33097 } }, -- Akezel
    [Unitnames.Boss_Rukhan] = { [1] = { id = 33097 } }, -- Rukhan
    [Unitnames.Boss_Marruz] = { [1] = { id = 33097 } }, -- Marruz
    [Unitnames.NPC_Xivilai_Immolator] = { [1] = { id = 33097 } }, -- Xivilai Immolator
    [Unitnames.NPC_Xivilai_Ravager] = { [1] = { id = 33097 } }, -- Xivilai Ravager
    [Unitnames.Boss_Urata_the_Legion] = { [1] = { id = 33097 } }, -- Urata the Legion
    [Unitnames.NPC_Flame_Colossus] = { [1] = { id = 33097 } }, -- Flame Colossus
    [Unitnames.Boss_Horvantud_the_Fire_Maw] = { [1] = { id = 33097 } }, -- Horvantud the Fire Maw
    [Unitnames.Boss_Ash_Titan] = { [1] = { id = 33097 } }, -- Ash Titan
    [Unitnames.NPC_Air_Atronach] = { [1] = { id = 33097, zone = { [681] = true }, } }, -- Air Atronach (City of Ash II)
    [Unitnames.NPC_Dremora_Hauzkyn] = { [1] = { id = 33097, zone = { [681] = true }, } }, -- Dremora Hauzkyn (City of Ash II)
    [Unitnames.NPC_Fire_Ravager] = { [1] = { id = 33097 } }, -- Fire Ravager
    [Unitnames.NPC_Xivilai_Fulminator] = { [1] = { id = 33097 } }, -- Xivilai Fulminator
    [Unitnames.NPC_Xivilai_Boltaic] = { [1] = { id = 33097 } }, -- Xivilai Fulminator
    [Unitnames.Boss_Valkyn_Skoria] = { [1] = { id = 33097 } }, -- Valkyn Skoria

    -- Tempest Island
    [Unitnames.Boss_Sonolia_the_Matriarch] = { [1] = { id = 33097 } }, -- Sonolia the Matriarch
    [Unitnames.Boss_Valaran_Stormcaller] = { [1] = { id = 33097 } }, -- Valaran Stormcaller
    [Unitnames.NPC_Lightning_Avatar] = { [1] = { id = 33097 } }, -- Lightning Avatar
    [Unitnames.Boss_Yalorasse_the_Speaker] = { [1] = { id = 33097 } }, -- Yalorasse the Speaker
    [Unitnames.Boss_Stormfist] = { [1] = { id = 33097 } }, -- Stormfist
    [Unitnames.Boss_Commodore_Ohmanil] = { [1] = { id = 33097 } }, -- Commodore Ohmanil
    [Unitnames.Boss_Stormreeve_Neidir] = { [1] = { id = 33097 } }, -- Stormreeve Neidir

    -- Selene's Web
    [Unitnames.Boss_Treethane_Kerninn] = { [1] = { id = 33097 } }, -- Treethane Kerninn
    [Unitnames.Boss_Longclaw] = { [1] = { id = 33097 } }, -- Longclaw
    [Unitnames.Boss_Queen_Aklayah] = { [1] = { id = 33097 } }, -- Queen Aklayah
    [Unitnames.Boss_Foulhide] = { [1] = { id = 33097 } }, -- Foulhide
    [Unitnames.Boss_Mennir_Many_Legs] = { [1] = { id = 33097 } }, -- Mennir Many-Legs
    [Unitnames.Boss_Selene] = { [1] = { id = 33097 } }, -- Selene

    -- Spindleclutch I
    [Unitnames.Boss_Spindlekin] = { [1] = { id = 33097 } }, -- Spindlekin
    [Unitnames.Boss_Swarm_Mother] = { [1] = { id = 33097 } }, -- Swarm Mother
    [Unitnames.Boss_Cerise_the_Widow_Maker] = { [1] = { id = 33097 } }, -- Cerise the Widow-Maker
    [Unitnames.Boss_Big_Rabbu] = { [1] = { id = 33097 } }, -- Big Rabbu
    [Unitnames.Boss_The_Whisperer] = { [1] = { id = 33097 } }, -- The Whisperer
    [Unitnames.Boss_Praxin_Douare] = { [1] = { id = 33097 } }, -- Praxin Douare

    -- Spindleclutch II
    [Unitnames.Boss_Mad_Mortine] = { [1] = { id = 33097 } }, -- Mad Mortine
    [Unitnames.Boss_Blood_Spawn] = { [1] = { id = 33097 } }, -- Blood Spawn
    [Unitnames.NPC_Flesh_Atronach] = { [1] = { id = 33097, zone = { [936] = true, [932] = true }, } }, -- Flesh Atronach
    [Unitnames.Boss_Urvan_Veleth] = { [1] = { id = 33097 } }, -- Urvan Veleth
    [Unitnames.Boss_Vorenor_Winterbourne] = { [1] = { id = 33097 } }, -- Vorenor Winterborne

    -- Wayrest Sewers I
    [Unitnames.Boss_Slimecraw] = { [1] = { id = 33097 } }, -- Slimecraw
    [Unitnames.Boss_Investigator_Garron] = { [1] = { id = 33097 } }, -- Investigator Garron
    [Unitnames.Boss_Uulgarg_the_Hungry] = { [1] = { id = 33097 } }, -- Uulgarg the Hungry
    [Unitnames.Boss_the_Rat_Whisperer] = { [1] = { id = 33097 } }, -- The Rat Whisperer
    [Unitnames.Boss_Varaine_Pellingare] = { [1] = { id = 33097 } }, -- Varaine Pellingare
    [Unitnames.Boss_Allene_Pellingare] = { [1] = { id = 33097 } }, -- Allene Pellingare

    -- Wayrest Sewers II
    [Unitnames.Boss_Malubeth_the_Scourger] = { [1] = { id = 33097 } }, -- Malubeth the Scourger
    [Unitnames.Boss_Skull_Reaper] = { [1] = { id = 33097 } }, -- Skull Reaper
    [Unitnames.Boss_Uulgarg_the_Risen] = { [1] = { id = 33097 } }, -- Uulgarg the Risen
    [Unitnames.Boss_Garron_the_Returned] = { [1] = { id = 33097 } }, -- Garron the Returned
    [Unitnames.Boss_The_Forgotten_One] = { [1] = { id = 33097 } }, -- The Forgotten One

    -- Crypt of Hearts I
    [Unitnames.Boss_The_Mage_Master] = { [1] = { id = 33097 } }, -- The Mage Master
    [Unitnames.Boss_Archmaster_Siniel] = { [1] = { id = 33097 } }, -- Archmaster Siniel
    [Unitnames.Boss_Deaths_Leviathan] = { [1] = { id = 33097 } }, -- Death's Leviathan
    [Unitnames.Boss_Dogas_the_Berserker] = { [1] = { id = 33097 } }, -- Dogas the Berserker
    [Unitnames.Boss_Ilambris_Athor] = { [1] = { id = 33097 } }, -- Ilambris-Athor
    [Unitnames.Boss_Ilambris_Zaven] = { [1] = { id = 33097 } }, -- Ilambris-Zaven

    -- Crypt of Hearts II
    [Unitnames.Boss_Ibelgast] = { [1] = { id = 33097 } }, -- Ibelgast
    [Unitnames.Boss_Ruzozuzalpamaz] = { [1] = { id = 33097 } }, -- Ruzozuzalpamaz
    [Unitnames.NPC_Ibelgasts_Flesh_Atronach] = { [1] = { id = 33097 } }, -- Ibelgasts Flesh Atronach
    [Unitnames.NPC_Ogrim] = { [1] = { id = 33097, zone = { [932] = true }, } }, -- Ogrim
    [Unitnames.Boss_Chamber_Guardian] = { [1] = { id = 33097, zone = { [932] = true }, } }, -- Chamber Guardian
    [Unitnames.Boss_Ilambris_Amalgam] = { [1] = { id = 33097 } }, -- Ilambris Amalgam
    [Unitnames.Boss_Mezeluth] = { [1] = { id = 33097 } }, -- Mezeluth
    [Unitnames.Boss_Nerieneth] = { [1] = { id = 33097 } }, -- Nerien'eth
    [Unitnames.NPC_Wraith] = { [1] = { id = 33097, zone = { [932] = true }, } }, -- Wraith
    [Unitnames.NPC_Student] = { [1] = { id = 33097, zone = { [932] = true }, } }, -- Student

    -- Volenfell
    [Unitnames.Boss_Desert_Lioness] = { [1] = { id = 33097, zone = { [22] = true }, } },-- Desert Lioness
    [Unitnames.Boss_Desert_Lion] = { [1] = { id = 33097, zone = { [22] = true }, } },-- Desert Lion
    [Unitnames.Boss_Quintus_Verres] = { [1] = { id = 33097 } }, -- Quintus Verres
    [Unitnames.Boss_Monstrous_Gargoyle] = { [1] = { id = 33097 } }, -- Monstrous Gargoyle
    [Unitnames.Boss_Boilbite] = { [1] = { id = 33097 } }, -- Boilbite
    [Unitnames.Boss_Boilbites_Assassin_Beetle] = { [1] = { id = 33097 } }, -- Boilbite's Assassin Beetle
    [Unitnames.Boss_Unstable_Construct] = { [1] = { id = 33097 } }, -- Unstable Construct
    [Unitnames.Boss_Unstable_Dwarven_Spider] = { [1] = { id = 33097, zone = { [22] = true }, } },-- Unstable Dwarven Spider
    [Unitnames.Boss_Tremorscale] = { [1] = { id = 33097 } }, -- Tremorscale
    [Unitnames.Boss_The_Guardians_Strength] = { [1] = { id = 33097 } }, -- The Guardian's Strength
    [Unitnames.Boss_The_Guardians_Spark] = { [1] = { id = 33097 } }, -- The Guardian's Spark
    [Unitnames.Boss_The_Guardians_Soul] = { [1] = { id = 33097 } }, -- The Guardian's Soul

    -- Frostvault
    [Unitnames.NPC_Coldsnap_Ogre] = { [1] = { id = 33097 } }, -- Coldsnap Ogre
    [Unitnames.Boss_Icestalker] = { [1] = { id = 33097 } }, -- Icestalker
}

Effects.AddNameOnBossEngaged = {

    [Unitnames.Boss_Razor_Master_Erthas] = {
        [Unitnames.NPC_Flame_Atronach] = 33097, -- Scary Immunities --> Razor Master Erthas --> Flame Atronach (City of Ash I)
    },
    [Unitnames.Boss_Ilambris_Amalgam] = {
        [Unitnames.NPC_Skeleton] = 33097, -- Scary Immunities --> Ilambris Amalgam --> Skeleton (Crypt of Hearts II)
    },

}

--------------------------------------------------------------------------------------------------------------------------------
-- When a gain event or faded event fires for this id in the world, we add a buff aura to a specific unit name. Only usable for unique boss effects.
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddNameOnEvent = {

    [46680] = { name = Unitnames.Boss_Deaths_Leviathan, id = 46680 }, -- Immolate Colossus -- Death's Leviathan (Crypt of Hearts I)
    [28759] = { name = Unitnames.Boss_Keeper_Voranil, id = 28759 }, -- Essence Siphon -- Keeper Voranil (Banished Cells II)
    [52167] = { name = Unitnames.Boss_Ilambris_Amalgam, id = 53600 }, -- Shock Form -- Ilambris Amalgam (Crypt of Hearts II)
    [52166] = { name = Unitnames.Boss_Ilambris_Amalgam, id = 53593 }, -- Fire Form -- Ilambris Amalgam (Crypt of Hearts II)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Supports the above table by determining stack counts if needed.
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddStackOnEvent = {

    [28759] = 0, -- Essence Siphon (Keeper Voranil) -- Note: Set to 0 here due to this event firing twice.

}

--------------------------------------------------------------------------------------------------------------------------------
-- When the player loads into the ZoneId listed below, add an unlimited duration long aura for the abilityId.
--------------------------------------------------------------------------------------------------------------------------------
Effects.ZoneBuffs = {
    -- Daggerfall Covenant Quests
    [811] = 28358, -- Zone: Ancient Carzog's Demise (Base Zone: Betnikh) (Quest: Unearthing the Past) - Q4468 Orc Raider Disguise


}

--------------------------------------------------------------------------------------------------------------------------------
-- Synergy Icon Overrides - When a synergy with a matching ability name appears, change the icon or name.
--------------------------------------------------------------------------------------------------------------------------------
Effects.SynergyNameOverride = {
    ['Tonal Inverter'] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tonal_inverter.dds' }, -- Tonal Inverter (Divine Intervention)
    [Abilities.Skill_Blade_of_Woe] = { icon = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds' }, -- Blade of Woe (Dark Brotherhood)
    [Abilities.Skill_Black_Widow] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds' }, -- Black Widow (Undaunted)
    [Abilities.Skill_Arachnophobia] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds' }, -- Arachnophobia (Undaunted)
    [Abilities.Skill_Devour] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Werewolf)
    [Abilities.Set_Shield_of_Ursus] = { icon = 'LuiExtended/media/icons/abilities/ability_set_haven_of_ursus.dds', name = Abilities.Set_Ursus_Blessing }, -- Ursus's Blessing (Haven of Ursus)
    -- World Bosses
    [Abilities.Skill_Remove_Bolt] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_trapping_bolt.dds' }, -- Remove Bolt (Trapjaw)
    -- Dungeons
    [Abilities.Skill_Free_Ally] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_free_ally.dds' }, -- Free Ally (Selene) -- Selene's Web
    [Abilities.Skill_Resist_Necrosis] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_resist_necrosis.dds' }, -- Resist Necrosis (Nerien'eth) -- Crypt of Hearts II
    -- Sets
    [Abilities.Set_Sanguine_Burst] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hollowfang.dds' }, -- Sanguine Burst (Lady Thorn)
}

--------------------------------------------------------------------------------------------------------------------------------
-- When a bar ability proc with a matching id appears, change the icon.
--------------------------------------------------------------------------------------------------------------------------------
Effects.BarIdOverride = {
    -- Dragonknight
    [20824] = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds', -- Power Lash (Flame Lash)

    -- Nightblade
    [61907] = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', -- Assassin's Will (Grim Focus)
    [61932] = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', -- Assassin's Scourge (Relentless Focus)
    [61930] = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', -- Assassin's Will (Merciless Resolve)
    [35445] = 'LuiExtended/media/icons/abilities/ability_nightblade_shadow_image_teleport.dds', -- Shadow Image Teleport (Shadow Image)

    -- Dual Wield
    [126659] = 'LuiExtended/media/icons/abilities/ability_weapon_flying_blade_jump.dds', -- Flying Blade (Flying Blade)

    -- Sorcerer
    [108840] = 'esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds', -- Summon Unstable Familiar (Summon Unstable Familiar)
    [108845] = 'esoui/art/icons/ability_sorcerer_lightning_prey_summoned.dds', -- Winged Twilight Restore (Summon Winged Twilight)

    -- Support
    [78338] = 'esoui/art/icons/ability_ava_guard.dds', -- Guard (Guard)
    [81415] = 'esoui/art/icons/ability_ava_mystic_guard.dds', -- Mystic Guard (Mystic Guard)
    [81420] = 'esoui/art/icons/ability_ava_stalwart_guard.dds', -- Stalwart Guard (Stalwart Guard)
}

--------------------------------------------------------------------------------------------------------------------------------
-- When a bar ability proc with a matching id appears, display the toggle highlight
--------------------------------------------------------------------------------------------------------------------------------

Effects.IsAbilityActiveHighlight = {
    -- Support
    [78338] = true, -- Guard (Guard)
    [81415] = true, -- Mystic Guard (Mystic Guard)
    [81420] = true, -- Stalwart Guard (Stalwart Guard)
}

Effects.IsAbilityActiveGlow = {
    [126659] = true, -- Flying Blade (Flying Blade)

    [137156] = true, -- Carnage (Pounce)
    [137184] = true, -- Brutal Carnage (Brutal Pounce)
    [137164] = true, -- Feral Carnage (Feral Pounce)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Table of effects to adjust only based off a specific target - this allows us to override the name/icon or hide an effect only when the source is a specific NPC. Used to change icons for attacks with the same id coming from different types of animals, etc...
--------------------------------------------------------------------------------------------------------------------------------
Effects.EffectOverrideByName = {
    [10618] = { -- Quick Strike (Shared)
        [Unitnames.NPC_Xivilai] =                { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_xivilai_light.dds' }, -- Xivilai

        -- QUESTS
        [Unitnames.Elite_Vaekar_the_Forgemaster] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_1h_light.dds' }, -- Vaekar the Forgemaster (Soul Shriven in Coldharbour)
        [Unitnames.NPC_Dremora_Caitiff] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_light.dds' }, -- Dremora Caitiff (Soul Shriven in Coldharbour)
        [Unitnames.NPC_Skeletal_Ravager] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_light.dds' }, -- Skeletal Ravager (Soul Shriven in Coldharbour)
        [Unitnames.NPC_Dremora_Baunekyn] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_light.dds' }, -- Dremora Baunekyn (Soul Shriven in Coldharbour)ability_spell_mace_2h_light.dds

        -- Vvardenfell
        [Unitnames.Elite_First_Mate_Ulveni] =    { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_1h_light.dds' }, -- First Mate Ulveni (Broken Bonds)

        [Unitnames.Elite_Amuur] =                { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_cleaver_attack_light.dds' }, -- Amuur (Auridon - The First Patient)

        -- Daggerfall Covenant
        [Unitnames.Elite_Gornog] =               { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_light.dds' }, -- Gornog (Stros M'Kai - Innocent Scoundrel)
        [Unitnames.NPC_Drake_Brigand] =          { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_light.dds' }, -- Drake Brigand (Stros M'Kai)

        -- Elsweyr
        [Unitnames.Elite_Captain_Carvain] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_1h_light.dds' }, -- Captain Carvain (Elsweyr - Bright Moons, Warm Sands)

        -- Greymoor
        [Unitnames.Elite_Vitrus_the_Bloody] =    { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_light.dds' }, -- Vitrus the Bloody (Greymoor - Bound in Blood)
        [Unitnames.NPC_Icereach_Brute] =         { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_light.dds' }, -- Icereach Brute (Greymoor - Bound in Blood)
        [Unitnames.NPC_Icereach_Charger] =       { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_light.dds' }, -- Icereach Charger (Greymoor - Bound in Blood)

        -- DUNGEONS
        [Unitnames.NPC_Darkfern_Mauler] =        { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_light_reach.dds' }, -- Darkfern Mauler (Elden Hollow I)
        [Unitnames.Boss_Nenesh_gro_Mal] =        { icon = 'LuiExtended/media/icons/abilities/ability_spell_club2h_light_attack.dds' }, -- Nenesh gro Mal (Elden Hollow I)
        [Unitnames.NPC_Dremora_Berserker] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_light.dds' }, -- Dremora Berserker (City of Ash I)
        [Unitnames.Boss_The_Mage_Master] =       { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_light.dds' }, -- The Mage Master (Crypt of Hearts I)
        [Unitnames.Boss_Dogas_the_Berserker] =   { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_light.dds' }, -- Dogas the Berserker (Crypt of Hearts I)
        [Unitnames.NPC_Dremora_Kynval] =         { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_1h_light.dds' }, -- Dremora Kynval (City of Ash I)
        [Unitnames.Boss_Rukhan] =                { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_light.dds' }, -- Rukhan (City of Ash I)
        [Unitnames.NPC_Xivilai_Ravager] =        { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_light.dds' }, -- Xivilai Ravager (City of Ash I)
        [Unitnames.NPC_Fire_Ravager] =           { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_light.dds' }, -- Fire Ravager (City of Ash I)
        [Unitnames.NPC_Xivilai_Boltaic] =        { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_light.dds' }, -- Fire Ravager (City of Ash I)
        [Unitnames.NPC_Sea_Viper_Strongarm] =    { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_light.dds' }, -- Sea Viper Strongarm (Tempest Island)
        [Unitnames.NPC_Sea_Viper_Berserker] =    { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_light.dds' }, -- Sea Viper Berserker (Tempest Island)
        [Unitnames.NPC_Sea_Viper_Charger] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_light.dds' }, -- Sea Viper Charger (Tempest Island)
        [Unitnames.Boss_Commodore_Ohmanil] =     { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_light.dds' }, -- Commodore Ohmanil (Tempest Island)
        [Unitnames.Boss_Ibelgast] =              { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_light.dds' }, -- Ibelgast (Crypt of Hearts II)
        [Unitnames.NPC_Spiderkith_Venifex] =     { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_light.dds' }, -- Spiderkith Venifex (Crypt of Hearts II)
        [Unitnames.NPC_Spiderkith_Warper] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_dagger_1h_light.dds' }, -- Spiderkith Warper (Crypt of Hearts II)
        [Unitnames.Boss_Chamber_Guardian] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_light.dds' }, -- Chamber Guardian (Crypt of Hearts II)
    },

    [29035] = { -- Quick Strike (Rogue/Skirmisher)
        -- QUESTS
        [Unitnames.NPC_Slaver_Cutthroat] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_dagger_1h_light.dds' }, -- Firemoth Island (Vvardenfell - Broken Bonds) -- Slaver Cutthroat

        -- Daggerfall Covenant
        [Unitnames.NPC_Dogeater_Skirmisher] =   { icon = 'LuiExtended/media/icons/abilities/ability_spell_dagger_1h_light.dds' }, -- Dogeater Skirmisher (Stros M'Kai)
        [Unitnames.NPC_Drake_Cutthroat] =       { icon = 'LuiExtended/media/icons/abilities/ability_spell_dagger_1h_light.dds' }, -- Drake Cutthroat (Stros M'Kai)
    },

    [26332] = { -- Slash (Valaran Stormcaller)
        [Unitnames.NPC_Lightning_Avatar] =       { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light_ethereal.dds' }, -- Lightning Avatar (Tempest Island)
    },
    [14096] = { -- Heavy Attack (Footsoldier)
        [Unitnames.Elite_Amuur] =                { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_cleaver_attack_heavy.dds' }, -- Amuur (The First Patient)
    },

    -- HUMAN NPCS
    [29521] = { -- Aura of Protection (Shaman)
        [Unitnames.NPC_Aura_of_Protection] =      { hide = true } -- Aura of Protection (Aura of Protection) -- Hides this buff only on the Goblin Aura of Protection to prevent duplicate display
    },
    [86704] = { -- Chop (Peasant)
        [Unitnames.NPC_Hleran_Noble] =            { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_dagger_light.dds' }, -- Chop (Hleran Noble)
    },
    [86705] = { -- Lop (Peasant)
        [Unitnames.NPC_Hleran_Noble] =            { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_dagger_light.dds' }, -- Lop (Hleran Noble)
    },

    [88251] = {
        [Unitnames.NPC_Great_Bear] =              { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_bear.dds' }, -- Call Ally (Pet Ranger)
        [Unitnames.NPC_Spider] =                  { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
        [Unitnames.NPC_Senche_Tiger] =            { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_tiger.dds' }, -- Call Ally (Pet Ranger)
    },

    [88248] = {
        [Unitnames.NPC_Spider] =                  { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
        [Unitnames.NPC_Venomspit_Spider ] =        { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
        [Unitnames.NPC_Websnare_Spider] =         { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
    },

    -- ANIMALS
    [7170] = { -- Rend (Lion)
        [Unitnames.NPC_Lion] =                    { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
        [Unitnames.Boss_Desert_Lion] =            { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
        [Unitnames.NPC_Lioness] =                 { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
        [Unitnames.Boss_Desert_Lioness] =          { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
        [Unitnames.NPC_Sabre_Cat] =               { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
        [Unitnames.NPC_Senche_Tiger] =            { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        [Unitnames.Boss_Nindaeril_the_Monsoon] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend_white.dds' }, -- Rend (Senche-Tiger)
        ['The Tiger'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        [Unitnames.NPC_Spectral_Senche_Tiger] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        ['Esh\'tabe'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        ['Raakhet'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        ['Razorclaw'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        [Unitnames.NPC_Senche_Panther] =          { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Unitnames.Boss_Silentpaw] =               { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Unitnames.Boss_Heartstalker] =            { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Unitnames.Boss_Nighteyes] =               { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Unitnames.Boss_Shadowhiskers] =           { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Abilities.Skill_Senche_Spirit] =           { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend_ghost.dds' }, -- Rend (Senche Spirit)
    },
    [60630] = { -- Rend (Lion)
        [Unitnames.NPC_Lion] =                    { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
        [Unitnames.Boss_Desert_Lion] =            { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
        [Unitnames.NPC_Lioness] =                 { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
        [Unitnames.Boss_Desert_Lioness] =          { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
        [Unitnames.NPC_Sabre_Cat] =               { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
        [Unitnames.NPC_Senche_Tiger] =            { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        [Unitnames.Boss_Nindaeril_the_Monsoon] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend_white.dds' }, -- Rend (Senche-Tiger)
        ['The Tiger'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        [Unitnames.NPC_Spectral_Senche_Tiger] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        ['Esh\'tabe'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        ['Raakhet'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        ['Razorclaw'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
        [Unitnames.NPC_Senche_Panther] =          { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Unitnames.Boss_Silentpaw] =               { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Unitnames.Boss_Heartstalker] =            { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Unitnames.Boss_Nighteyes] =               { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Unitnames.Boss_Shadowhiskers] =           { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend.dds' }, -- Rend (Senche-Panther)
        [Abilities.Skill_Senche_Spirit] =           { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_rend_ghost.dds' }, -- Rend (Senche Spirit)
    },
    [60641] = { -- Claw (Lion)
        [Unitnames.NPC_Sabre_Cat] =               { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_claw.dds' }, -- Claw (Sabre Cat)
        [Unitnames.NPC_Senche_Tiger] =            { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
        [Unitnames.Boss_Nindaeril_the_Monsoon] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw_white.dds' }, -- Claw (Senche-Tiger)
        ['The Tiger'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
        [Unitnames.NPC_Spectral_Senche_Tiger] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
        ['Esh\'tabe'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
        ['Raakhet'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
        ['Razorclaw'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
    },
    [7158] = { -- Bite (Lion)
        [Unitnames.NPC_Lion] =                    { icon = 'LuiExtended/media/icons/abilities/ability_lion_bite.dds' }, -- Bite (Lion)
        [Unitnames.NPC_Lioness] =                 { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
        [Unitnames.Boss_Desert_Lioness] =          { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
        [Unitnames.NPC_Sabre_Cat] =               { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_bite.dds' }, -- Bite (Sabre Cat)
        [Unitnames.NPC_Senche_Tiger] =            { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
        [Unitnames.Boss_Nindaeril_the_Monsoon] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite_white.dds' }, -- Bite (Senche-Tiger)
        ['The Tiger'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
        [Unitnames.NPC_Spectral_Senche_Tiger] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
        ['Esh\'tabe'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
        ['Raakhet'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
        ['Razorclaw'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
        [Unitnames.NPC_Senche_Panther] =          { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_bite.dds' }, -- Bite (Senche-Panther)
        [Unitnames.Boss_Silentpaw] =               { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_bite.dds' }, -- Bite (Senche-Panther)
        [Unitnames.Boss_Heartstalker] =            { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_bite.dds' }, -- Bite (Senche-Panther)
        [Unitnames.Boss_Nighteyes] =               { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_bite.dds' }, -- Bite (Senche-Panther)
        [Unitnames.Boss_Shadowhiskers] =           { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_bite.dds' }, -- Bite (Senche-Panther)
        [Abilities.Skill_Senche_Spirit] =           { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_bite_ghost.dds' }, -- Bite (Senche Spirit)
    },
    [7161] = { -- Double Strike (Lion)
        [Unitnames.NPC_Sabre_Cat] =               { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_double_strike.dds' }, -- Double Strike (Sabre Cat)
        [Unitnames.NPC_Senche_Tiger] =            { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
        [Unitnames.Boss_Nindaeril_the_Monsoon] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike_white.dds' }, -- Double Strike (Senche-Tiger)
        ['The Tiger'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
        [Unitnames.NPC_Spectral_Senche_Tiger] =   { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
        ['Esh\'tabe'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
        ['Raakhet'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
        ['Razorclaw'] =               { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
        [Unitnames.NPC_Senche_Panther] =          { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_double_strike.dds' }, -- Double Strike (Senche-Panther)
        [Unitnames.Boss_Silentpaw] =               { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_double_strike.dds' }, -- Double Strike (Senche-Panther)
        [Unitnames.Boss_Heartstalker] =            { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_double_strike.dds' }, -- Double Strike (Senche-Panther)
        [Unitnames.Boss_Nighteyes] =               { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_double_strike.dds' }, -- Double Strike (Senche-Panther)
        [Unitnames.Boss_Shadowhiskers] =           { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_double_strike.dds' }, -- Double Strike (Senche-Panther)
        [Abilities.Skill_Senche_Spirit] =           { icon = 'LuiExtended/media/icons/abilities/ability_senchepanther_double_strike_ghost.dds' }, -- Double Strike (Senche Spirit)
    },
    [5362] = { -- Slam (Skeever / Kagouti)
        [Unitnames.NPC_Kagouti] =                 { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)
        [Unitnames.NPC_Bull_Kagouti] =            { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)
        [Unitnames.NPC_Daedrat] =                 { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_slam.dds' }, -- Slam (Daedrat)
    },
    [21904] = { -- Rend (Skeever)
        [Unitnames.NPC_Daedrat] =                 { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_rend.dds' }, -- Rend (Daedrat)
    },
    [4022] = { -- Bite (Wolf)
        [Unitnames.NPC_Jackal] =                  { icon = 'LuiExtended/media/icons/abilities/ability_jackal_bite.dds' }, -- Bite (Jackal)
    },
    [42844] = { -- Rotbone (Wolf)
        [Unitnames.NPC_Jackal] =                  { icon = 'LuiExtended/media/icons/abilities/ability_jackal_rotbone.dds' }, -- Rotbone (Wolf)
    },
    [14523] = { -- Helljoint (Wolf)
        [Unitnames.NPC_Jackal] =                  { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
    },
    [75818] = { -- Helljoint (Wolf)
        [Unitnames.NPC_Jackal] =                  { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
    },
    [8569] = { -- Devastating Leap (Bloodfiend)
        [Unitnames.NPC_Skeleton] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_devastating_leap.dds' }, -- Devastating Leap (Skeleton)
        [Unitnames.NPC_Bone_Flayer] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_devastating_leap.dds' }, -- Devastating Leap (Skeleton)
        [Unitnames.NPC_Bone_Reaver] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_devastating_leap.dds' }, -- Devastating Leap (Skeleton)
        [Unitnames.NPC_Risen_Dead] =              { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_devastating_leap.dds' }, -- Devastating Leap (Skeleton)
        [Unitnames.NPC_Graveoath_Ravener] =   { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_devastating_leap.dds' }, -- Devastating Leap (Graveoath Ravener)
        [Unitnames.NPC_Skaafin_Wretch] =        { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_devastating_leap.dds' }, -- Devastating Leap (Skaafin Miscreal)
        [Unitnames.NPC_Skaafin_Miscreal] =        { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_devastating_leap.dds' }, -- Devastating Leap (Skaafin Miscreal)
    },
    [8550] = { -- Slash (Bloodfiend)
        [Unitnames.NPC_Venomous_Skeleton] =   { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Venomous Skeleton) -- City of Ash II
        [Unitnames.NPC_Skeleton] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Skeleton)
        [Unitnames.NPC_Bone_Flayer] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
        [Unitnames.NPC_Bone_Reaver] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
        [Unitnames.NPC_Risen_Dead] =              { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Risen Dead)
        [Unitnames.NPC_Graveoath_Ravener] =   { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Graveoath Ravener)
        [Unitnames.NPC_Skaafin_Wretch] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Wretch)
        [Unitnames.NPC_Skaafin_Miscreal] =        { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Miscreal)
    },
    [8551] = { -- Slash (Bloodfiend)
        [Unitnames.NPC_Venomous_Skeleton] =   { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Venomous Skeleton) -- City of Ash II
        [Unitnames.NPC_Skeleton] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Skeleton)
        [Unitnames.NPC_Bone_Flayer] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
        [Unitnames.NPC_Bone_Reaver] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
        [Unitnames.NPC_Risen_Dead] =              { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Risen Dead)
        [Unitnames.NPC_Graveoath_Ravener] =   { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Graveoath Ravener)
        [Unitnames.NPC_Skaafin_Wretch] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Wretch)
        [Unitnames.NPC_Skaafin_Miscreal] =        { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Miscreal)
    },
    [8564] = { -- Rending Slash (Bloodfiend)
        [Unitnames.NPC_Skeleton] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Skeleton)
        [Unitnames.NPC_Bone_Flayer] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Bone Flayer)
        [Unitnames.NPC_Bone_Reaver] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Bone Flayer)
        [Unitnames.NPC_Risen_Dead] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Bone Flayer)
        [Unitnames.NPC_Graveoath_Ravener] =   { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Graveoath Ravener)
        [Unitnames.NPC_Skaafin_Wretch] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_rending_slash.dds' }, -- Rending Slash (Skaafin Wretch)
        [Unitnames.NPC_Skaafin_Miscreal] =        { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_rending_slash.dds' }, -- Rending Slash (Skaafin Miscreal)
    },
    [8554] = { -- Flurry (Bloodfiend)
        [Unitnames.NPC_Skeleton] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Skeleton)
        [Unitnames.NPC_Bone_Flayer] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)
        [Unitnames.NPC_Bone_Reaver] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)
        [Unitnames.NPC_Risen_Dead] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)
        [Unitnames.NPC_Graveoath_Ravener] =   { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Graveoath Ravener)
        [Unitnames.NPC_Skaafin_Wretch] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_flurry.dds' }, -- Flurry (Skaafin Wretch)
        [Unitnames.NPC_Skaafin_Miscreal] =        { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_flurry.dds' }, -- Flurry (Skaafin Miscreal)
    },
    [9194] = { -- Flurry (Bloodfiend)
        [Unitnames.NPC_Skeleton] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Skeleton)
        [Unitnames.NPC_Bone_Flayer] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)
        [Unitnames.NPC_Bone_Reaver] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)
        [Unitnames.NPC_Risen_Dead] =             { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)
        [Unitnames.NPC_Graveoath_Ravener] =   { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Graveoath Ravener)
        [Unitnames.NPC_Skaafin_Wretch] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_flurry.dds' }, -- Flurry (Skaafin Wretch)
        [Unitnames.NPC_Skaafin_Miscreal] =        { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_flurry.dds' }, -- Flurry (Skaafin Miscreal)
    },

    -- MONSTERS
    [9670] = {
        [Unitnames.NPC_Spectral_Lamia] =          { icon = 'LuiExtended/media/icons/abilities/ability_lamia_strike_spectral.dds' }, -- Strike (Lamia)
    },

    [89119] = { -- Base = Bear
        [Unitnames.NPC_Dire_Wolf] =               { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_wolf.dds' }, -- Summon Beast (Spriggan)
        [Unitnames.NPC_Websnare_Spider] =         { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
        [Unitnames.NPC_Spider] =                  { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
        [Unitnames.NPC_Venomspit_Spider] =        { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
    },
    [89102] = { -- Base = Senche-Tiger
        [Unitnames.NPC_Thunderbug] =              { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_thunderbug.dds' }, -- Summon Beast (Spriggan)
        [Unitnames.NPC_Thunderbug_Lord] =         { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_thunderbug.dds' }, -- Summon Beast (Spriggan)
        [Unitnames.NPC_Hoarvor] =                 { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_hoarvor.dds' }, -- Summon Beast (Spriggan)
        [Unitnames.NPC_Lion] =                    { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_lion.dds' }, -- Summon Beast (Spriggan)
        [Unitnames.NPC_Lioness] =                 { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_lioness.dds' }, -- Summon Beast (Spriggan)
    },

    [3757] = { -- Claw (Lurcher)
        [Unitnames.Boss_Limbscather] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_red.dds' }, -- Limbscather (Glenumbra)
    },
    [3860] = { -- Pulverize (Lurcher)
        [Unitnames.Boss_Limbscather] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_red.dds' }, -- Limbscather (Glenumbra)
    },
    [3855] = { -- Crushing Limbs (Lurcher)
        [Unitnames.Boss_Limbscather] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Limbscather (Glenumbra)
    },
    [38554] = { -- Crushing Limbs (Lurcher)
        [Unitnames.Boss_Limbscather] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Limbscather (Glenumbra)
    },
    [3767] = { -- Choking Pollen (Lurcher)
        [Unitnames.Boss_Limbscather] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Limbscather (Glenumbra)
    },
    [4769] = { -- Choking Pollen (Lurcher)
        [Unitnames.Boss_Limbscather] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Limbscather (Glenumbra)
    },
    [5278] = { -- Bite (Assassin Beetle)
        [Unitnames.Boss_Boilbite] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_bite.dds' }, -- Boilbite (Volenfell)
    },
    [91791] = { -- Feast (Assassin Beetle)
        [Unitnames.Boss_Boilbite] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_feast.dds' }, -- Boilbite (Volenfell)
    },

    -- CYRODIIL
    [64674] = { -- Cyrodiil Guard See Stealth
        [Unitnames.NPC_Guard_AD]                            = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ad.dds' }, -- Dominion Guard
        [Unitnames.NPC_Honor_Guard_AD]                      = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_honor_ad.dds' }, -- Dominion Honor Guard
        [Unitnames.NPC_Temple_Guard_AD]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ad.dds' }, -- Dominion Temple Guard
        [Unitnames.NPC_Mender_AD]                           = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ad.dds' }, -- Dominion Mender
        [Unitnames.NPC_Mage_Guard_AD]                       = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ad.dds' }, -- Dominion Mage Guard
        [Unitnames.NPC_Skirmisher_AD]                       = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ad.dds' }, -- Dominion Skirmisher
        [Unitnames.NPC_Archer_Guard_AD]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ad.dds' }, -- Dominion Archer Guard
        [Unitnames.NPC_Guard_DC]                            = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_dc.dds' }, -- Covenant Guard
        [Unitnames.NPC_Honor_Guard_DC]                      = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_honor_dc.dds' }, -- Covenant Honor Guard
        [Unitnames.NPC_Temple_Guard_DC]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_dc.dds' }, -- Covenant Temple Guard
        [Unitnames.NPC_Mender_DC]                           = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_dc.dds' }, -- Covenant Mender
        [Unitnames.NPC_Mage_Guard_DC]                       = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_dc.dds' }, -- Covenant Mage Guard
        [Unitnames.NPC_Skirmisher_DC]                       = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_dc.dds' }, -- Covenant Skirmisher
        [Unitnames.NPC_Archer_Guard_DC]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_dc.dds' }, -- Covenant Archer Guard
        [Unitnames.NPC_Guard_EP]                            = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ep.dds' }, -- Pact Guard
        [Unitnames.NPC_Honor_Guard_EP]                      = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_honor_ep.dds' }, -- Pact Honor Guard
        [Unitnames.NPC_Temple_Guard_EP]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ep.dds' }, -- Pact Temple Guard
        [Unitnames.NPC_Mender_EP]                           = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ep.dds' }, -- Pact Mender
        [Unitnames.NPC_Mage_Guard_EP]                       = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ep.dds' }, -- Pact Mage Guard
        [Unitnames.NPC_Skirmisher_EP]                       = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ep.dds' }, -- Pact Skirmisher
        [Unitnames.NPC_Archer_Guard_EP]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance_ep.dds' }, -- Pact Archer Guard
    },
    [15780] = { -- Honor Guard Rage (Cyrodiil Honor Guard T1)
         [Unitnames.NPC_Honor_Guard_AD]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_honor_guard_rage_ad.dds' }, -- Dominion Honor Guard
         [Unitnames.NPC_Honor_Guard_DC]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_honor_guard_rage_dc.dds' }, -- Covenant Honor Guard
         [Unitnames.NPC_Honor_Guard_EP]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_honor_guard_rage_ep.dds' }, -- Pact Honor Guard
    },
    [46992] = { -- Crippling Rage (Cyrodiil Honor Guard T2)
         [Unitnames.NPC_Honor_Guard_AD]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_honor_guard_rage_ad.dds' }, -- Dominion Honor Guard
         [Unitnames.NPC_Honor_Guard_DC]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_honor_guard_rage_dc.dds' }, -- Covenant Honor Gaurd
         [Unitnames.NPC_Honor_Guard_EP]                     = { icon = 'LuiExtended/media/icons/abilities/ability_spell_honor_guard_rage_ep.dds' }, -- Pact Honor Guard
    },

    [21677] = { -- Wall of Souls
        [Unitnames.NPC_Burdening_Eye] = { hide = true }, -- Burdening Eye
        [Unitnames.NPC_Daedroth] = { hide = true }, -- Daedroth
        [Unitnames.NPC_Daedric_Titan] = { hide = true }, -- Daedric Titan
    },

    -- QUESTS
    [37028] = {
        [Unitnames.NPC_Auroran_Battlemage] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds', name = Abilities.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
    },
    [37029] = {
        [Unitnames.NPC_Auroran_Battlemage] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds', name = Abilities.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
    },
    [37030] = {
        [Unitnames.NPC_Auroran_Battlemage] =      { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds', name = Abilities.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
    },

    -- GENERIC
    [44176] = { -- Flying Immunities
       [Unitnames.Boss_Cell_Haunter] = { hide = true }, -- Cell Haunter (Banished Cells I)
       [Unitnames.NPC_The_Feast] = { hide = true }, -- The Feast
       [Unitnames.Boss_Azara_the_Frightener] = { hide = true }, -- Azara the Frightener (Elden Hollow II)
       [Unitnames.Boss_Dark_Ember] = { hide = true }, -- Dark Ember (City of Ash I)
       [Unitnames.Boss_Lady_Solace] = { hide = true}, -- Grahtwood (Lady Solace's Fen)
       [Unitnames.Boss_Valanir_the_Restless] = { hide = true }, -- Grahtwood (Valanir's Rest)
       [Unitnames.Boss_Shade_of_Naemon] = { hide = true }, -- Greenshade (Striking at the Heart)
       [Unitnames.Boss_Tallatta_the_Lustrous] = { hide = true }, -- Malabal Tor (Vulkwasten)
       [Unitnames.Boss_Queen_of_Three_Mercies] = { hide = true }, -- Reaper's March (Waterdancer Falls)
       [Unitnames.NPC_Watcher] = { hide = true }, -- Watcher
       [Unitnames.Boss_Magdelena] = { hide = true }, -- Magdelena (Magdelena's Haunt)
       [Unitnames.Boss_Desuuga_the_Siren] = { hide = true }, -- Desuuga the Siren (Siren's Cove)
       [Unitnames.Boss_Uulkar_Bonehand] = { hide = true }, -- Uulkar Bonehand (Crypt of Hearts I)
       [Unitnames.NPC_Wraith] = { hide = true, zone = { [932] = true } }, -- Wraith (Crypt of Hearts II)
       [Unitnames.NPC_Student] = { hide = true, zone = { [932] = true } }, -- Wraith (Crypt of Hearts II)
    },
}

--------------------------------------------------------------------------------------------------------------------------------
-- Override source name = when one of these abilities hits change the source to match this name. Used for death recap to rename odd trap or source names for damage.
-- source = '' -- Change source name
-- pet = '' -- Change or remove pet name
-- removePlayer = true -- If for some reason a damage effect is sourced from the player, set it to not be flagged as isPlayer == true in order to stop AVA rank, etc from showing.
--------------------------------------------------------------------------------------------------------------------------------
Effects.EffectSourceOverride = {

    -- PLAYER SETS
    [71678] = { pet = Abilities.Set_Morkuldin }, -- Morkuldin (Morkuldin Sword)
    [71679] = { pet = Abilities.Set_Morkuldin }, -- Morkuldin Cleave (Morkuldin Sword)

    -- PLAYER ABILITIES
    [33219] = { pet = Abilities.Skill_Shade }, -- Corrosive Strike (Dark Shade)
    [123945] = { pet = Abilities.Skill_Dark_Shade }, -- Corrosive Flurry (Dark Shade)
    [108936] = { pet = Abilities.Skill_Dark_Shade }, -- Corrosive Slash (Dark Shade)
    [51556] = { pet = Abilities.Skill_Shadow_Image }, -- Corrosive Arrow (Shadow Image)

    -- BATTLEGROUNDS

    -- TRAPS
    [62769] = { source = Abilities.Trap_Cold_Fire_Trap }, -- Coldharbour Flames (MQ Tutorial)
    [62770] = { source = Abilities.Trap_Cold_Fire_Trap }, -- Coldharbour Flames (MQ Tutorial)
    [17314] = { source = Abilities.Trap_Fire_Trap, addSource = true }, -- Fire Trap (Fire Trap)

    [21943] = { source = Abilities.Trap_Spike_Trap }, -- Spike Trap (Corpse Masher) -- Stros M'Kai

    [72888] = { source = Abilities.Trap_Fire_Trap }, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = { source = Abilities.Trap_Fire_Trap }, -- Fire Attack 2 (Fire) -- Banished Cells II

    [33594] = { source = Abilities.Skill_Flames }, -- Fire (Fire) -- Throne of the Wilderking

    [20483] = { source = Abilities.Trap_Falling_Rocks }, -- Falling Rocks

    [27940] = { source = Abilities.Trap_Charge_Wire }, -- Laser Damage (Generic Flame Wave Shooter) -- Stros M'Kai
    [32245] = { source = Abilities.Trap_Steam_Vent }, -- Searing Steam (Steam Trap) -- Stros M'Kai

    -- CYRODIIL
    [21707] = { source = Unitnames.NPC_Dremora_Channeler }, -- Imperial Law (Player) NPC_Dremora_Channeler

    -- ENVIRONMENTAL
    [44034] = { source = Abilities.Trap_Slaughterfish, addSource = true }, -- Slaughterfish Attack
    [113082] = { source = Abilities.Trap_Slaughterfish, addSource = true }, -- Slaughterfish Attack

    [19224] = { source = Abilities.Trap_Lava, addSource = true }, -- In Lava (Halls of Torment)
    [11338] = { source = Abilities.Trap_Lava, addSource = true }, -- In Lava (Earth Forge)
    [56277] = { source = Abilities.Trap_Lava, addSource = true }, -- In Lava (City of Ash II)
    [5140] = { source = Abilities.Trap_Lava, addSource = true }, -- Dragonstar Arena (City of Ash II)

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
    [91659] = {source = Abilities.Trap_Falling_Rocks }, -- Falling Rocks {Vvardenfell}
    [92672] = {source = 'Red Mountain'}, -- Pyroclast  {Vvardenfell}
    [84527] = {source = 'Steam Vent'}, -- Searing Steam {Vvardenfell}

    -----------------------------------------------
    -- QUESTS
    -----------------------------------------------

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

    -----------------------------------------------
    -- ARENAS
    -----------------------------------------------

    -- Dragonstar Arena
    [55341] = { source = Abilities.Skill_Biting_Cold, addSource = true }, -- Biting Cold (Player)
    [60421] = { source = Abilities.Skill_Biting_Cold, addSource = true }, -- Biting Cold (Player)
    [83441] = { source = Unitnames.NPC_Anka_Ra_Shadowcaster, addSource = true }, -- Celestial Blast (Player)
    [55182] = { source = Unitnames.Boss_Hiath_the_Battlemaster }, -- Marked for Death (Hiath the Battlemaster)

    -- Maelstrom Arena
    [67871] = { source = Unitnames.Boss_Lamia_Queen }, -- Shock (Water)
    [72525] = { source = Abilities.Skill_Frigid_Waters, addSource = true }, -- Frigid Waters (Player)
    [67808] = { source = Abilities.Skill_Frigid_Waters, addSource = true }, -- Frigid Waters (Player)

    -----------------------------------------------
    -- DUNGEONS
    -----------------------------------------------

    -- City of Ash I
    [34820] = { pet = '' }, -- Lava Pitch (Release Flame)
    [34951] = { pet = '' }, -- Blazing Embers (Release Flame)

    -- City of Ash II
    [54133] = { pet = '' }, -- Blazing Embers (Marruz)
    [56034] = { pet = '' }, -- Ground Tremor (Horvantud the Fire Maw)
    [55756] = { pet = '' }, -- Burning (Valkyn Skoria)
    [56068] = { source = Abilities.Skill_Slag_Geyser }, -- Slag Geyser (Lava Pools)

    -- Selene's Web
    [31086] = { source = Abilities.Skill_Bear_Trap }, -- Trap (Trap)
    [30901] = { pet = '' }, -- IntroKB (Spectral Senche-Tiger)

    -- Spindleclutch II
    [31611] = { source = Abilities.Skill_Cave_In }, -- Crushing Rocks (Cave In)
    [87373] = { source = Abilities.Skill_Cave_In }, -- Cave-In (Collapsed Ceiling)
    [86418] = { source = Unitnames.Boss_Praxin_Douare, pet = '', removePlayer = true }, -- Harrowing Ring (Blood Essence)
    [27655] = { source = Unitnames.Boss_Praxin_Douare, pet = '', removePlayer = true }, -- Harrowing Ring (Blood Essence)

    -- Crypt of Hearts I
    [22432] = { pet = '' }, -- Electric Prison (Lightning Rod)

    -- Crypt of Hearts II
    [51883] = { pet = '' }, -- Creeping Storm (Creeping Storm)
}

--------------------------------------------------------------------------------------------------------------------------------
-- If one of these ability Names is applied then we set the buffSlot for ON_EFFECT_CHANGED to be a single name identifier to prevent more than one aura from appearing. Only works with unlimited duration or equal duration effects.
--------------------------------------------------------------------------------------------------------------------------------
Effects.EffectMergeName = {
    [Abilities.Skill_Overcharge] = "MERGED_EFFECT_OVERCHARGE",
    [Abilities.Skill_Boulder_Toss] = "MERGED_EFFECT_BOULDER_TOSS",
    [Abilities.Skill_Boss_CC_Immunity] = "MERGED_EFFECT_BOSS_IMMUNITIES", -- Scary Immunities
}

--------------------------------------------------------------------------------------------------------------------------------
-- If one of these id's is applied then we set the buffSlot for ON_EFFECT_CHANGED to be a single name identifier to prevent more than one aura from appearing. Only works with unlimited duration or equal duration effects.
--------------------------------------------------------------------------------------------------------------------------------
Effects.EffectMergeId = {
    [47768] = "MERGED_EFFECT_CC_IMMUNITY_QUEST", -- RobS Immunities 6 Sec (Grahtwood - A Lasting Winter)
}



--------------------------------------------------------------------------------------------------------------------------------
-- Using a separate chart for ZOS Artificial Effects just in case this is significantly expanded at any point -- Overrides Artificial Effect id name or icon.
--------------------------------------------------------------------------------------------------------------------------------
Effects.ArtificialEffectOverride = {
    [0] = { tooltip = Tooltips.Innate_Battle_Spirit }, -- Battle Spirit (Cyrodiil, Duel, Battleground) (used for Active Effects window)
    [1] = { name = string.gsub(GetArtificialEffectInfo(1), "For", "for"), tooltip = Tooltips.Innate_Looking_for_Group }, -- Looking For Group (Dungeon Finder)
    [2] = { name = Abilities.Skill_Battle_Spirit, tooltip = Tooltips.Innate_Battle_Spirit_Imperial_City }, -- Battle Spirit Imperial City (used for Active Effects window)
    [3] = { tooltip = Tooltips.Innate_Battleground_Deserter }, -- Battleground Deserter Penalty
}

--------------------------------------------------------------------------------------------------------------------------------
-- LUIE for the most part overwrites default ability tooltips due to the fact they are only exposed for buffs/debuffs that are on the player. In some cases there is no description with scaling or we need to still use the default where possible.
-- The most noteworthy case of this is Mundus Boons, where there is a tooltip but no description. We want to display a generic tooltip describing the effect if mousing over another player - but display the default value with accurate number for self.
--------------------------------------------------------------------------------------------------------------------------------
Effects.TooltipUseDefault = {
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

--------------------------------------------------------------------------------------------------------------------------------
-- Override various information displayed for Effect auras
-- NEVER use a base skill line ability here, ALWAYS use alternate id's as replacements, we don't want to mess with skills in the skill window, ability bar, etc...
--------------------------------------------------------------------------------------------------------------------------------
function Effects.UpdateEffectOnSkillUpdate()
    -- Mages Guild
    Effects.EffectOverride[40465].tooltip = zo_strformat(GetString(SI_LUIE_SKILL_SCALDING_RUNE_TP), (GetAbilityDuration(40468) / 1000) + GetNumPassiveSkillRanks(GetSkillLineIndicesFromSkillLineId(44), select(2, GetSkillLineIndicesFromSkillLineId(44)), 8) )
end

Effects.KeepUpgradeOverride = {
    [Abilities.Keep_Upgrade_Food_Guard_Range]           = "LuiExtended/media/icons/keepupgrade/upgrade_food_guard_range.dds",
    [Abilities.Keep_Upgrade_Food_Heartier_Guards]       = "LuiExtended/media/icons/keepupgrade/upgrade_food_heartier_guards.dds",
    [Abilities.Keep_Upgrade_Food_Resistant_Guards]      = "LuiExtended/media/icons/keepupgrade/upgrade_food_resistant_guards.dds",
    [Abilities.Keep_Upgrade_Food_Stronger_Guards]       = "LuiExtended/media/icons/keepupgrade/upgrade_food_stronger_guards.dds",
    [Abilities.Keep_Upgrade_Ore_Armored_Guards]         = "LuiExtended/media/icons/keepupgrade/upgrade_ore_armored_guards.dds",
    [Abilities.Keep_Upgrade_Ore_Corner_Build]           = "LuiExtended/media/icons/keepupgrade/upgrade_ore_corner_build.dds",
    [Abilities.Keep_Upgrade_Ore_Siege_Platform]         = "LuiExtended/media/icons/keepupgrade/upgrade_ore_siege_platform.dds",
    [Abilities.Keep_Upgrade_Ore_Stronger_Walls]         = "LuiExtended/media/icons/keepupgrade/upgrade_ore_stronger_walls.dds",
    [Abilities.Keep_Upgrade_Ore_Wall_Regeneration]      = "LuiExtended/media/icons/keepupgrade/upgrade_ore_wall_regeneration.dds",
    [Abilities.Keep_Upgrade_Wood_Archer_Guard]          = "LuiExtended/media/icons/keepupgrade/upgrade_wood_archer_guard.dds",
    [Abilities.Keep_Upgrade_Wood_Door_Regeneration]     = "LuiExtended/media/icons/keepupgrade/upgrade_wood_door_regeneration.dds",
    [Abilities.Keep_Upgrade_Wood_Siege_Cap]             = "LuiExtended/media/icons/keepupgrade/upgrade_wood_siege_cap.dds",
    [Abilities.Keep_Upgrade_Wood_Stronger_Doors]        = "LuiExtended/media/icons/keepupgrade/upgrade_wood_stronger_doors.dds",
    [Abilities.Keep_Upgrade_Food_Mender_Abilities]      = "LuiExtended/media/icons/keepupgrade/upgrade_food_mender.dds",
    [Abilities.Keep_Upgrade_Food_Mage_Abilities]        = "LuiExtended/media/icons/keepupgrade/upgrade_food_mage.dds",
    [Abilities.Keep_Upgrade_Food_Guard_Abilities]       = "LuiExtended/media/icons/keepupgrade/upgrade_food_guard.dds",
}

Effects.KeepUpgradeAlliance = {
    [Abilities.Keep_Upgrade_Food_Honor_Guard_Abilities] = {
        [1] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_ad.dds",
        [2] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_ep.dds",
        [3] = "LuiExtended/media/icons/keepupgrade/upgrade_food_honor_guard_dc.dds",
    },
}

Effects.KeepUpgradeNameFix = {
    [Abilities.Keep_Upgrade_Food_Mage_Abilities]        = Abilities.Keep_Upgrade_Food_Mage_Abilities_Fix,
}

Effects.KeepUpgradeTooltip = {
    [Abilities.Keep_Upgrade_Food_Guard_Range]           = Tooltips.Keep_Upgrade_Food_Guard_Range,
    [Abilities.Keep_Upgrade_Food_Heartier_Guards]       = Tooltips.Keep_Upgrade_Food_Heartier_Guards,
    [Abilities.Keep_Upgrade_Food_Resistant_Guards]      = Tooltips.Keep_Upgrade_Food_Resistant_Guards,
    [Abilities.Keep_Upgrade_Food_Stronger_Guards]       = Tooltips.Keep_Upgrade_Food_Stronger_Guards,
    [Abilities.Keep_Upgrade_Ore_Armored_Guards]         = Tooltips.Keep_Upgrade_Ore_Armored_Guards,
    [Abilities.Keep_Upgrade_Ore_Corner_Build]           = Tooltips.Keep_Upgrade_Ore_Corner_Build,
    [Abilities.Keep_Upgrade_Ore_Siege_Platform]         = Tooltips.Keep_Upgrade_Ore_Siege_Platform,
    [Abilities.Keep_Upgrade_Ore_Stronger_Walls]         = Tooltips.Keep_Upgrade_Ore_Stronger_Walls,
    [Abilities.Keep_Upgrade_Ore_Wall_Regeneration]      = Tooltips.Keep_Upgrade_Ore_Wall_Regeneration,
    [Abilities.Keep_Upgrade_Wood_Archer_Guard]          = Tooltips.Keep_Upgrade_Wood_Archer_Guard,
    [Abilities.Keep_Upgrade_Wood_Door_Regeneration]     = Tooltips.Keep_Upgrade_Wood_Door_Regeneration,
    [Abilities.Keep_Upgrade_Wood_Siege_Cap]             = Tooltips.Keep_Upgrade_Wood_Siege_Cap,
    [Abilities.Keep_Upgrade_Wood_Stronger_Doors]        = Tooltips.Keep_Upgrade_Wood_Stronger_Doors,
    [Abilities.Keep_Upgrade_Food_Mender_Abilities]      = Tooltips.Keep_Upgrade_Food_Mender_Abilities,
    [Abilities.Keep_Upgrade_Food_Mage_Abilities]        = Tooltips.Keep_Upgrade_Food_Mage_Abilities,
    [Abilities.Keep_Upgrade_Food_Honor_Guard_Abilities] = Tooltips.Keep_Upgrade_Food_Honor_Guard_Abilities,
    [Abilities.Keep_Upgrade_Food_Guard_Abilities]       = Tooltips.Keep_Upgrade_Food_Guard_Abilities,
}


--------------------------------------------------------------------------------------------------------------------------------
-- If this abilityId is up, then pull the duration from another active ability Id to set its duration (Unused - Might be useful in the future)
--------------------------------------------------------------------------------------------------------------------------------
--[[
Effects.EffectPullDuration = {
}
]]--

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Buffs & Debuffs - Fake auras created by EVENT_COMBAT_EVENT for abilities that lack proper auras. Note tooltips & unbreakable status are determined in Effects.EffectOverride

    -- icon = '' -- Set an icon to use
    -- name = '' -- Set a name to use
    -- duration = # -- Set the duration of the effect
    -- ignoreFade = true -- Don't remove this effect when it fades.
    -- ignoreBegin = true -- Ignore effect begin and only apply on refresh - Emulates the same functionality as refreshOnly in Effects.EffectOverride. For stopping auras from being created for travel times.
    -- shiftId = # -- Shift the ability id displayed to use this id instead, for tooltip compatibility in some cases.
    -- overrideDuration = true -- Set duration to display as 0, but preserve the correct duration so this effect doesn't fade improperly.

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Buffs applied onto the player by NPCs or Events (Friendly)
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakeExternalBuffs = {

    -- Quests
    [21403] = { duration = 60000, ignoreFade = true }, -- Spiritual Cloak (The Mallari-Mora)

    -- Elsweyr Quests
    [124310] = { duration = 10000 }, -- Master's Shield (Grand Adept Ma'hja-dro)

    ----------------
    -- Dungeons ----
    ----------------

    -- Elden Root II
    [32655] = { duration = 0 }, -- Fortification (Fortified Guardian)
    [32614] = { duration = 0 }, -- Empowered (Mystic Guardian)
}

--------------------------------------------------------------------------------------------------------------------------------
 -- Fake Debuffs applied onto the player by NPCs or Events (Hostile)
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakeExternalDebuffs = {

    -- Necromancer
    [118242] = { duration = 1000 }, -- Beckoning Armor (Beckoning Armor)

    -- Destruction Staff
    [38946] = { duration = 1800 }, -- Stun After Knockback Movement (Destructive Reach) -- Fire

    -- Vampire
    [40349] = { duration = 23000 }, -- Feed (Blood Ritual - Rank 1)

    -- Werewolf
    [40520] = { duration = 7000 }, -- Q3047 - Knockdown (Blood Moon - Rank 1)

    -- Item Sets
    [75706] = { duration = 0 }, -- Bahraha's Curse

    -- Traps
    [27479] = { duration = 2000 }, -- Falling Rocks (Falling Rocks)
    [29602] = { duration = 2000 }, -- Falling Rocks (Cave-In)

    [31606] = { duration = 0 }, -- Fire Trap (Player)
    [72890] = { duration = 0 }, -- Laser Snare (Fire)

    [32246] = { duration = 0 }, -- Searing Steam (Steam Trap) -- Stros M'Kai

    --[66153] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Trial of Flame', duration = 1500}, -- Trial of Flame (Wrothgar - Old Orsinium)
    --[32246] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Steam Trap', duration = 2000}, -- Laser Snare (Steam Trap)

    -- Quest Traps
    -- TODO: Orsinium
    --[64535] = {icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', name = 'Chilling Wind', duration = 2000}, -- Chilling Wind (Orsinium - Sorrow's Kiss)
    --[67586] = {icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = 'Avalanche', duration = 2500}, -- Avalanche (Orsinium - Sorrow's Kiss)

    -- Justice NPC's
    [63160] = { duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63263] = { duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63094] = { duration = 1500 }, -- Shield Charge (Justice Guard 1H)
    [63260] = { duration = 1500 }, -- Shield Charge (Justice Guard 2H)
    [63194] = { duration = 6000 }, -- Flame Shard (Justice Guard 2H)
    [63168] = { duration = 3500, ignoreBegin = true }, -- Cage Talons (Justice Guard 1H + 2H)

    -- Standard NPC Abilities
    [29401] = { duration = 3000 }, --Power Bash (NPC Disorient)
    [14926] = { duration = 2000 }, -- Charge (Human NPC)
    [10650] = { duration = 0 }, -- Oil Drenched
    [79930] = { duration = 2500 }, -- Lunge (Tracker) (Morrowind)

    -- Animals
    [69073] = { duration = 2000 }, -- Knockdown (Bear Orsinium)
    [74336] = { duration = 2000 }, -- Bog Burst (Haj Mota)
    [14523] = { duration = 6000, ignoreBegin = true }, -- Helljoint (Wolf)
    [85394] = { duration = 8000 }, -- Slash (Cliff Strider Matriach)
    [55862] = { duration = 8000 }, --Storm Bound (Wamasu - Boss) (DOT)
    [55863] = { duration = 8000 }, --Storm Bound (Wamasu - Boss) (SNARE)

    -- Daedra
    [50023] = { duration = 4000, ignoreBegin = true }, -- Lightning Rod (Air Atronach)
    [51646] = { duration = 0 }, -- Frozen Ground (Frost Atronach)
    [24700] = { duration = 2000 }, -- Body Slam (Ogrim)
    [91851] = { duration = 2000 }, -- Stomp (Ogrim)
    [6412] = { duration = 2000, ignoreBegin = true }, -- Dusk's Howl (Winged Twilight)

    -- Insects
    [9237] = { duration = 10000 }, -- Larva Gestation (Giant Wasp)
    [6795] = { duration = 7500 }, -- Latch On (Hoarvor)
    [61372] = { duration = 4000 }, -- Infectious Swarm (Necrotic Hoarvor)
    [8429] = { duration = 4000, ignoreBegin = true }, -- Zap (Thunderbug)

    -- Monsters
    [51354] = { duration = 500 }, -- Petrify (Gargoyle)
    [17703] = { duration = 4000, ignoreBegin = true }, -- Flame Ray (Imp - Fire)
    [8884] = { duration = 4000, ignoreBegin = true }, -- Zap (Imp - Lightning)
    [81794] = { duration = 4000, ignoreBegin = true }, -- Frost Ray (Imp - Frost)
    [95288] = { duration = 0 }, -- Hurricane (Nereid)
    [48287] = { duration = 1500}, -- Consuming Omen (Troll - Ranged) (Fake aura to replace bugged aura)

    -- Undead
    [38834] = { duration = 0 }, -- Desecrated Ground Snare (Desecrated Ground)
    [22525] = { duration = 0 }, -- Defiled Ground (Lich)
    [43146] = { duration = 4000 }, -- Winter's Reach (Wraith)

    -- Traps
    [49897] = { duration = 0 }, -- Fire (Fire) -- Throne of the Wilderking
    [11338] = { duration = 0 }, -- Lava -- In Lava
    [55925] = { duration = 0 }, -- Lava (City of Ash II)

    ------------------------------
    -- Quests --------------------
    ------------------------------

    -- Main Story
    [14972] = { duration = 2000 }, -- CON_Knockback&Knockdown (Castle of the Worm)
    [44561] = { duration = 3000 }, -- FGQ4 RGT Event Knockback (Lyris Doppleganger - Halls of Torment)
    [38741] = { duration = 4000 }, -- Royal Snare (Duchess of Anguish - Halls of Torment)
    [40429] = { duration = 2000 }, -- IntroKB (Mannimarco - Shadow of Sancre Tor)
    [41198] = { duration = 2000 }, -- IntroKB (Mannimarco - Shadow of Sancre Tor)

    -- Fighter's Guild
    [39579] = { duration = 2000 }, -- CON_Knockback&Knockdown (The Prismatic Core)
    [25979] = { duration = 1000 }, -- FG4 RGT Event Knockback

    -- Mages Guild
    [31502] = { duration = 4000 }, -- MGQ2 Asakala Sahdina Barrier
    [31503] = { duration = 4000 }, -- MGQ2 Asakala Rashomta Barrier

    -- Aldmeri Dominion
    [21876] = { duration = 4500 }, -- Q4260 West Barrier Teleport (Breaking the Barrier)
    [21878] = { duration = 4500 }, -- Q4260 East Barrier Teleport (Breaking the Barrier)
    [22395] = { duration = 4000 }, -- Q4261 ROD Barrier Teleport (Sever All Ties)
    [28771] = { duration = 2000 }, -- Q4220 Thirster Stun (The Mallari-Mora)
    [23606] = { duration = 2000 }, -- Q4326 Crystal Backfire (Preventative Measure)
    [43823] = { duration = 2150 }, -- IntroKB (Prince Naemon)
    [36766] = { duration = 5000 }, -- Q4842 Stun Headgrab Knockback (The Unquiet Dead)
    [33384] = { duration = 4000 }, -- Q4586 Aranias Vine Stun

    -- Elsweyr
    [121645] = { duration = 8000 }, -- Defiled Ground (Euraxian Necromancer) (Bright Moons, Warm Sands)
    [125268] = { duration = 2500 }, -- Headbutt (Bahlokdaan)

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
    [88030] = { duration = 1500 }, -- Falling Rocks -- Deadfall
    [87348] = { duration = 1500 }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87350] = { duration = 2000 }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [89756] = { duration = 2000 }, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)

    ----------------------------------------------------------------
    -- ARENAS ----------------------------------------------------
    ----------------------------------------------------------------

    -- Dragonstar Arena
    [27920] = { duration = 1800 }, -- Generic Knockback Stun (House Dres Templar)
    [54068] = { duration = 500 }, -- Fossilize (Earthen Heart Knight)
    [54405] = { duration = 4000 }, -- Celestial Blast (Anka-Ra Shadowcaster)
    [52910] = { duration = 6000 }, -- Dark Flare Trauma (Shadow Knight)
    [56065] = { duration = 12000 }, -- Ice Charge (Dwarven Ice Centurion)
    [83477] = { duration = 4000 }, -- Volcanic Rune (Mavus Talnarith)

    -- Maelstrom Arena
    [73877] = { duration = 2000 }, -- Piercing Shriek (Lamia Queen)
    [72705] = { duration = 10000 }, -- Cold Snap (Leimenid Oracle)
    [71997] = { duration = 10000 }, -- Cold Snap (Leimenid Oracle)
    [71940] = { duration = 8000 }, -- Frost Breath (Huntsman Chillbane)
    [71720] = { duration = 2000 }, -- Stun (Matriarch Runa)

    ----------------------------------------------------------------
    -- DUNGEONS ----------------------------------------------------
    ----------------------------------------------------------------

    -- Banished Cells II
    [35680] = { duration = 2250 }, -- Immolating Bite (Maw of the Infernal)
    [27828] = { duration = 2500 }, -- Crushing Blow (Keeper Voranil)
    [28570] = { duration = 5000 }, -- Levitate (High Kinlord Rilis)
    [28462] = { duration = 5000 }, -- Levitate (High Kinlord Rilis)

    -- Elden Hollow I
    [25310] = { duration = 2500 }, -- Executioners Strike (Akash gra-Mal)
    [25348] = { duration = 6000, refreshOnly = true }, -- Necrotic Circle (Canonreeve Oraneth)
    [46800] = { duration = 1200 }, -- Necrotic Circle (Canonreeve Oraneth)

    -- Elden Hollow II
    [33334] = { ignoreBegin = true, duration = 7500 }, -- Latch On Stamina (Frenzied Guardian)
    [33337] = { ignoreBegin = true, duration = 7500 }, -- Latch On Magicka (Mystic Guardian)
    [33164] = { duration = 4000, ignoreBegin = true }, -- Incite Fear (Shadow Tendril)
    [35372] = { duration = 3500 }, -- Emerge (Bogdan the Nightflame)

    -- City of Ash I
    [25036] = { duration = 2000 }, -- Crushing Blow (Golor the Banekin Handler)
    [34948] = { duration = 25000 }, -- Burning Embers (Razor Master Erthas)
    [49138] = { duration = 1500 }, -- Oblivion Portal

    -- City of Ash II
    [54139] = { duration = 3000 }, -- Blazing Embers (Marruz)
    [53978] = { duration = 3000 }, -- Blazing Arrow (Marruz)
    [54145] = { duration = 1000 }, -- Fire Chain (Rukhan)
    [54098] = { duration = 2000 }, -- CON_Knockback&Knockdown (Rukhan)
    [56813] = { duration = 2000 }, -- CON_Knockback&Knockdown (Xivilai Ravager)

    [56307] = { duration = 3000 }, -- Fiery Jaws (Horvantud the Fire Maw)
    [54873] = { duration = 2000 }, -- Heavy Slash
    [56357] = { duration = 2000 }, -- Fire Swarm (Ash Titan)
    [55502] = { duration = 1500 }, -- Meteor (Valkyn Skoria)
    [55383] = { duration = 2000 }, -- Flame Strike (Valkyn Skoria)
    [55756] = { duration = 7500 }, -- Burning (Fire Stab)

    -- Tempest Island
    [26676] = { duration = 2000 }, -- IntroKB (Valaran Stormcaller)
    [28391] = { duration = 2500 }, -- Q4538 Stoen Explosion (Conduit Stone)
    [26716] = { duration = 2800 }, -- Skyward Slam (Stormfist)
    [26938] = { duration = 0 }, -- Enervating Stone (Stormfist)

    -- Selene's Web
    [31247] = { duration = 4000 }, -- Ensnare
    [31248] = { duration = 8000 }, -- Ensnare
    [30905] = { duration = 2000 }, -- IntroKB (Spectral Senche-Tiger)

    -- Spindleclutch I
    [18116] = { duration = 3500 }, -- Arachnophobia (The Whisperer)
    [46219] = { duration = 2500 }, -- Web Blast (The Whisperer)

    -- Spindleclutch II
    [18054] = { duration = 8000 }, -- Entangled (The Whisperer Nightmare)
    [18051] = { duration = 2000 }, -- Encased (The Whisperer Nightmare)
    [43176] = { duration = 1200 }, -- Shocked (Blood Essence)
    [61444] = { duration = 1200 }, -- Shocked (Blood Essence)
    [32100] = { duration = 3500 }, -- Arachnophobia (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [34848] = { duration = 2000 }, -- Primal Sweep (Slimecraw)
    [25531] = { duration = 2000 }, -- Tidal Slash (Varaine Pellingare)

    -- Wayrest Sewers II
    [36431] = { duration = 10000 }, -- Rend Soul (Malubeth the Scourger)
    [36870] = { duration = 5000 }, -- Scorching Flames (Uulgarg the Risen)
    [36900] = { duration = 35000 }, -- Haunting Spectre (The Forgotten One)
    [36535] = { duration = 2000 }, -- Spinning Cleave (Varaine Pellingare)
    [36398] = { duration = 2500 }, -- Bludgeon (Varaine Pellingare)
    [35839] = { duration = 12000 }, -- Necrotic Arrow (Allene Pellingare)

    -- Crypt of Hearts I
    [46692] = { duration = 2500 }, -- CON_Knockback&Knockdown (Ilambris-Athor)
    [44088] = { duration = 2000 }, -- CON_Knockback&Knockdown (Ilambris-Zaven)

    -- Crypt of Hearts II
    [53598] = { duration = 2000 }, -- Shock Form (Ilambris Amalgam)
    [53591] = { duration = 2000 }, -- CON_Knockback&Knockdown (Ilambris Amalgam)
    [51111] = { duration = 5000 }, -- Rise and Fall (Mezeluth)
    [51824] = { duration = 2500 }, -- Fulminating Void (Mezeluth)
    [53442] = { duration = 6000 }, -- Lethal Stab (Nerien'eth)
    [51995] = { duration = 2250 }, -- Heavy Slash (Nerien'eth)

    -- Volenfell
    [25649] = { duration = 4000, ignoreBegin = true }, -- Debilitating Roar (Desert Lion)
    [46314] = { duration = 2500 }, -- CON_Knockback&Knockdown (Monstrous Gargoyle)
    [42930] = { duration = 6000 }, -- Petrifying Bellow (Monstrous Gargoyle)
    [29166] = { duration = 2000 }, -- CON_Knockback&Knockdown (Tremorscale)
    [25265] = { duration = 2000 }, -- Decapitation Function (The Guardian's Soul)

    -- Frostvault
    [117486] = { duration = 18000 }, -- Bleed (Coldsnap Goblin - Shared)
    [109808] = { duration = 0 }, -- Frostbite (Icestalker)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake buffs applied onto the player by self (also supports debuffs with debuff = true)
-- onlyExtra -- Only display this if the Show Extra Buffs menu option is enabled
-- onlyExtended -- Only display this if the Show Extra Buffs menu option with "Extend Settings to Single Aura Effects" is enabled.
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakePlayerBuffs = {
    -- Misc Consumables
    --[85355] = {icon = 'LuiExtended/media/icons/mementos/memento_fire-breathers_torches.dds', name = Abilities.Memento_Fire_Breathers_Torches, duration = 12000}, -- Flame Juggling (Consumable Version)
    --[85354] = {icon = 'LuiExtended/media/icons/mementos/memento_jugglers_knives.dds', name = Abilities.Memento_Jugglers_Knives, duration = 12000}, -- Dagger Juggling (Consumable Verison)
    --[85353] = {icon = 'LuiExtended/media/icons/mementos/memento_sword-swallowers_blade.dds', name = Abilities.Memento_Sword_Swallowers_Blade, duration = 12000}, -- Sword Swallowing (Consumable Version)

    -- Base Mementos
    [41988] = { duration = 10000 }, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = { duration = 10000 }, -- Glimpse of the Forbidden (Discoure Amaranthine)
    --[42076] = {icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds', name = Abilities.Memento_Sealing_Amulet, duration = 8000}, -- Tear (Mezha-dro's Sealing Amulet)
    --[34578] = {icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds', name = Abilities.Memento_Nirnroot_Wine, duration = 8000}, -- Nirnroot Wine (Nirnroot Wine)
    [26339] = { duration = 5500 }, -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = { duration = 10000 }, -- Sanguine's Goblet (Sanguine's Goblet)
    [42008] = { duration = 10000 }, -- Blessing of Root Sunder (Token of Root Sunder)
    --[42053] = {icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds', name = Abilities.Memento_Yokudan_Totem, duration = 10000}, -- Yokudan Salute (Yokudan Totem)

    -- DLC Mementos
    --[89550] = {icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds', name = Abilities.Memento_Twilight_Shard, duration = 9000 }, -- TROPHY Azura's Light (Twilight Shard)
    --[79510] = {icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds', name = Abilities.Memento_Blade_of_the_Blood_Oath, duration = 6500}, -- TROPHY Blood Oath (Blade of the Blood Oath)
    --[74151] = {icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds', name = Abilities.Memento_Hidden_Pressure_Vent, duration = 2500}, -- Stun (Hidden Pressure Vent)

    -- Crown Store Mementos
    [85349] = { duration = 180000 }, -- Storm Atronach Transform (Atronach Transformation)
    --[85347] = {icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds', name = Abilities.Memento_Storm_Orb_Juggle, duration = 12000}, -- Storm Orb Juggle (Atronach Juggling)
    [86977] = { duration = 180000 }, -- Spriggan Transformation (Wild Hunt Transform)
    [92868] = { duration = 180000 }, -- Dwarven Transformation (Dwemervamidium Mirage)
    --[97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds', name = Abilities.Memento_Crows_Calling, duration = 9000 }, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [97274] = { duration = 180000 }, -- Swarm of Crows (Swarm of Crows)

    --[99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds', name = Abilities.Memento_Fiery_Orb, duration = 9000 }, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    --[99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds', name = Abilities.Memento_Flame_Pixie, duration = 8000 }, -- Flame Crate Memento 2 (Flame Pixie)
    --[99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds', name = Abilities.Memento_Flame_Eruption, duration = 2000 }, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    --[101874] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_frost_shard.dds', name = Abilities.Memento_Frost_Shard, duration = 10000 }, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    --[101877] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_rune_of_levitation.dds', name = Abilities.Memento_Rune_of_Levitation, duration = 9000 }, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    --[101872] = { icon = 'LuiExtended/media/icons/mementos/memento_bone_dragon_summons_focus.dds', name = Abilities.Memento_Dragon_Summons_Focus, duration = 5000 }, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    [110483] = { duration = 6800 }, -- Ghost Lantern (Ghost Lantern)

    -- Set Items
    [149413] = { duration = 0 }, -- Wrath of Elements (Vateshran Destruction Staff)
    [98421] = { duration = 15000 }, -- Pirate Skeleton
    [98419] = { duration = 15000 }, -- Pirate Skeleton
    [98420] = { duration = 15000 }, -- Pirate Skeleton
    [81675] = { duration = 15000 }, -- Pirate Skeleton
    [83288] = { duration = 15000 }, -- Pirate Skeleton
    [83287] = { duration = 15000 }, -- Pirate Skeleton
    --[124303] = { duration = 3000 }, -- Senche-Raht's Grit (Senche-Raht's)
    [117082] = { duration = 0 }, -- Frozen Watcher (Frozen Watcher)
    [134930] = { duration = 0 }, -- Duneripper's Scales
    [135554] = { duration = 0 }, -- Grave Guardian (Grave Guardian's)
    [106867] = { duration = 10000 }, -- Grace of Gloom (Gloom-Graced)
    [139552] = { duration = 0, long = true }, -- Snow Treaders (Snow Treaders)

    -- Set ICD's
    [129477] = { duration = 20000, debuff = true }, -- Immortal Warrior
    [127235] = { duration = 60000, shiftId = 999010, debuff = true }, -- Eternal Warrior
    [127032] = { duration = 60000, shiftId = 999011, debuff = true }, -- Phoenix
    [142401] = { duration = 60000, shiftId = 999012, debuff = true }, -- Juggernaut

    -- Player (Basic)
    [123970] = { duration = 3000 }, -- Lesser Reincarnate
    --[32346] = {icon = 'esoui/art/icons/achievement_u24_smallzone_skyshard.dds', name = Abilities.Innate_Absorbing_Skyshard, duration = 5800}, -- Skyshard Collect
    --[14031] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_mundus_use.dds', name = Abilities.Innate_Receiving_Boon, duration = 5000}, -- Mundus Use

    -----------------
    -- Class --------
    -----------------

    -- Dragonknight
    [32956] = { duration = 0 }, -- Standard of Might (Standard of Might)

    [29004] = { duration = "GET", onlyExtended = true }, -- Dragon Blood
    [32744] = { duration = "GET", onlyExtra = true }, -- Green Dragon Blood
    [32722] = { duration = "GET", onlyExtended = true }, -- Coagulating Blood

    [92507] = { duration = "GET", shiftId = 29043, onlyExtra = true }, -- Molten Weapons
    [92503] = { duration = "GET", shiftId = 31874, onlyExtra = true }, -- Igneous Weapons

    [31841] = { duration = 2500 }, -- Inhale
    [32796] = { duration = 2500 }, -- Deep Breath
    [32788] = { duration = 2500 }, -- Draw Essence

    -- Nightblade
    [90587] = { duration = "GET", shiftId = 33375, onlyExtended = true }, -- Blur
    [90593] = { duration = "GET", shiftId = 35414, onlyExtra = true }, -- Mirage
    [90620] = { duration = "GET", shiftId = 35419, onlyExtended = true }, -- Phantasmal Escape

    [33317] = { duration = "GET", shiftId = 33316, onlyExtra = true }, -- Drain Power
    [131344] = { duration = "GET", shiftId = 36901, onlyExtra = true }, -- Power Extraction
    [62240] = { duration = "GET", shiftId = 36891, onlyExtra = true }, -- Sap Essence

    -- Templar
    [22223] = { duration = 4000 }, -- Rite of Passage (Rite of Passage)
    [22229] = { duration = 4000 }, -- Remembrance (Remembrance)
    [22226] = { duration = 6000 }, -- Practiced Incantation (Practiced Incantation)

    -- Warden
    [87019] = { duration = "GET", onlyExtra = true, shiftId = 85862 }, -- Minor Endurance (Enchanted Growth)

    [86224] = { duration = "GET", onlyExtended = true, shiftId = 86122 }, -- Major Resolve (Frost Cloak)
    [88758] = { duration = "GET", onlyExtended = true, shiftId = 86126 }, -- Major Resolve (Expansive Frost Cloak)
    [88761] = { duration = "GET", onlyExtra = true, shiftId = 86130 }, -- Major Resolve (Ice Fortress)

    [92068] = { duration = "GET" }, -- Crystalized Shield (Crystallized Shield)
    [92168] = { duration = "GET" }, -- Crystalized Slab (Crystallized Slab)
    [92170] = { duration = "GET" }, -- Shimmering Shield (Shimmering Shield)

    -- Two Handed
    [28297] = { duration = "GET", onlyExtra = true }, -- Momentum
    [38794] = { duration = "GET", onlyExtra = true }, -- Forward Momentum

    -- Restoration Staff
    [37243] = { duration = "GET", onlyExtended = true, ignoreFade = true }, -- Blessing of Protection (Blessing of Protection)
    [40103] = { duration = "GET", onlyExtended = true, ignoreFade = true }, -- Blessing of Restoration (Blessing Of Restoration)
    [40094] = { duration = "GET", onlyExtra = true, ignoreFade = true }, -- Combat Prayer (Combat Prayer)

    -- Mages Guild
    [40449] = { duration = "GET" }, -- Spell Symmetry (Spell Symmetry)

    -- Psijic Order
    [122260] = { duration = "GET" }, -- Race Against Time (Race Against Time)

    -- Armor
    [63015] = { duration = "GET", onlyExtended = true, shiftId = 29556 }, -- Major Evasion (Evasion)
    [63019] = { duration = "GET", onlyExtended = true, shiftId = 39195 }, -- Major Evasion (Shuffle)
    [126958] = { duration = "GET" }, -- Elude (Elude)

    -- Vampire
    [145002] = { duration = 5000, debuff = true }, -- Blood for Blood (Blood for Blood)

    -- Werewolf
    [137206] = { duration = "GET", debuff = true }, -- Major Berserk (Hircine's Rage)

    -- Alliance War
    [101161] = { duration = "GET", shiftId = 38566, onlyExtended = true }, -- Rapid Maneuever (Rapid Maneuver)
    [101169] = { duration = "GET", shiftId = 40211 }, -- Retreating Maneuever (Retreating Maneuver)
    [101178] = { duration = "GET", shiftId = 40215, onlyExtra = true }, -- Charging Maneuver (Charging Maneuver)

    -- Seasonal Quests (New Life Festival)
    --[84125] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Breton Male Dance (Lava Foot Stomp)
    --[84126] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Breton Female Dance (Lava Foot Stomp)
    --[84127] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Dunmer Male Dance (Lava Foot Stomp)
    --[84128] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Dunmer Female Dance (Lava Foot Stomp)
    --[84130] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Altmer Male Dance (Lava Foot Stomp)
    --[84131] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Altmer Female Dance (Lava Foot Stomp)
    --[84133] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = Abilities.Skill_Lava_Foot_Stomp, duration = 10000}, -- Nord Dance (Lava Foot Stomp)
    --[84528] = {icon = 'LuiExtended/media/icons/mementos/memento_fire_breathers_torches.dds', name = Abilities.Skill_Torch_Juggling, duration = 12000}, -- Flame Juggling (Castle Charm Challenge)
    --[84506] = {icon = 'LuiExtended/media/icons/mementos/memento_jugglers_knives.dds', name = Abilities.Skill_Knife_Juggling, duration = 12000}, -- Dagger Juggling (Castle Charm Challenge)
    --[84533] = {icon = 'LuiExtended/media/icons/mementos/memento_sword_swallowers_blade.dds', name = Abilities.Skill_Sword_Swallowing, duration = 12000}, -- Sword Swallowing (Castle Charm Challenge)
    --[84847] = {icon = 'LuiExtended/media/icons/abilities/ability_quest_celebratory_belch.dds', name = Abilities.Skill_Celebratory_Belch, duration = 5000}, -- Celebratory Belch (Stonetooth Bash)

    ------------------------------
    -- Quests --------------------
    ------------------------------

    -- Mages Guild
    [26406] = { duration = 0 }, -- MG2 Captured Essence (Simply Misplaced)
    [26634] = { duration = 0 }, -- MG2 Captured Sahdina Essence
    [26581] = { duration = 0 }, -- MG2 Captured Rashomta Essence

    -- Aldmeri Dominion Quests
    [33066] = { icon = 'LuiExtended/media/icons/disguises/disguise_fancy_clothing.dds', name = Abilities.Skill_Fancy_Clothing, duration = 0, long = true, ignoreBegin = true }, -- Q4586_ChangeClothes
    [34842] = { icon = 'LuiExtended/media/icons/disguises/disguise_fancy_clothing_female.dds', name = Abilities.Skill_Fancy_Clothing, duration = 0, long = true, ignoreBegin = true }, -- Q4586_ChangeClothesFEMALE
    --[29504] = { duration = 0, long = true }, -- Q4546 Shade Layer
    --[34597] = { duration = 0, long = true }, -- Q4690 Forest Spirit Layer

    -- Quest related (Craglorn)
    --[81807] = {icon = 'esoui/art/icons/achievement_104.dds', name = 'Power of the Stars', duration = 22000}, -- Power of the Stars (The Star-Gazers)

    -- Orsinium
    --[66453] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', name = 'Hiding', duration = 45000}, -- Hiding (A Question of Succession)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake offline auras created by the player
-- ground == true - Set the target to ground instead of player.
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakePlayerOfflineAura = {

    -- Sets
    [75814] = { duration = "GET" }, -- Lunar Bastion (Lunar Bastion)

    -- Templar
    [22265] = { duration = "GET" }, -- Cleansing Ritual (Cleansing Ritual)
    [22259] = { duration = "GET" }, -- Ritual of Retribution (Ritual of Retribution)
    [22262] = { duration = "GET" }, -- Extended Ritual (Extended Ritual)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake debuffs applied onto a target by the player
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakePlayerDebuffs = {
    -- JUSTICE NPCS
    -- Disabled: Duration is too long and Guard always CC breaks. Maybe setup a calllater removal function?
    --[63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = Abilities.Skill_Stonefist, duration = 6000 }, -- Flame Shard (Justice Guard 2H) -- If the player reflects

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    [86309] = { duration = 3000 }, -- Stun (Player blocks NPC charged attack)
    [86312] = { duration = 3000 }, -- Stun (Player blocks Ogrim Body Slam)

    -- Necromancer
    [118242] = { duration = 1000 }, -- Beckoning Armor (Beckoning Armor)

    -- Destruction Staff
    [38946] = { duration = 1800 }, -- Stun After Knockback Movement (Destructive Reach) -- Fire

    -- Vampire
    [40349] = { duration = 23000 }, -- Feed (Blood Ritual - Rank 1)

    -- Werewolf
    [40520] = { duration = 7000 }, -- Q3047 - Knockdown (Blood Moon - Rank 1)

    -- Item Sets
    [75706] = { duration = 1100, overrideDuration = true }, -- Bahraha's Curse -- Note: We add 100 ms to buffer here because it doesn't really matter and stops flashing
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Stagger Effects - For debuffs applied on the player or on a target that don't need to check for a removal condition (Useful for effects like staggers where this is no way to break out of them for the short duration they are applied.
--------------------------------------------------------------------------------------------------------------------------------
Effects.FakeStagger = {
    -- Player Basic
    [115607] = { duration = 2000 }, -- Hard Dismount (Mount)
    [141004] = { duration = 2000 }, -- Hard Dismount (Passenger Mount)

    -- Dual Wield
    [126640] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Hidden Blade)
    [126650] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Shrouded Daggers)
    [126655] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Flying Blade)

    -- Bow
    [38649] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Poison Arrow (Venom Arrow)

    -- Destruction Staff
    [48009] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Crushing Shock)

    -- On Player
    [2874] = { duration = 433 }, -- Staggered (Generic Stagger applied to player by many different NPC abilities)
    [29402] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Power Bash (Stagger when hit with Power Bash)
    [29765] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Uber Attack (Player staggers self by hitting Blocking NPC with Heavy Attack)
    [68971] = { duration = 433 }, -- Staggered (Echatere - Shockwave)
    [12426] = { duration = 433 }, -- Raven Storm (Hagraven)
    [32698] = { duration = 433 }, -- Pulverize (Lurcher - Pulverize)
    [5349] = { duration = 433 }, -- Stagger (Ogre - Shockwave)
    [49405] = { duration = 433 }, -- Rear Up (Mantikora)
    [76134] = { duration = 600 }, -- Stumble Forward (Flesh Colossus)
    [76133] = { duration = 433 }, -- Stumble Forward (Flesh Colossus - Blocked)
    [65755] = { duration = 600 }, -- Staggered (Flesh Colossus - Block Pin)
    [68826] = { duration = 600 }, -- Staggered (Flesh Colossus - Block Sweep)
    [74794] = { duration = 433 }, -- Black Winter (Harvester)
    [32023] = { duration = 433 }, -- Generic Stagger Enemy (Bloodfiend)
    [17206] = { duration = 433 }, -- Bone Saw (Bone Colossus)
    [45576] = { duration = 433 }, -- Generic Stagger Enemy (Werewolf)
    [69157] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Retaliation (Winterborn Warrior)
    [69153] = { duration = 1000 }, -- Retaliation (Winterborn Warrior)
    [54050] = { duration = 500 }, -- Divine Leap Stun (Vosh Rakh Devoted)
    [77927] = { duration = 433 }, -- Staggered (Bodyguard) (DB DLC)
    [74483] = { duration = 1000 }, -- Fiery Grip (Sentinel) (TG DLC)
    [35115] = { duration = 1000 },  -- Pull (Extended Chains) (Cyrodiil Guard T2)
    [47020] = { duration = 1000 }, -- Pull (Puncturing Chains) (Cyrodiil Guard T2)

    -- Quest
    [144339] = { duration = 433 }, -- Staggered (Prince Boar) - A Foe Most Porcine
    [84284] = { duration = 433 }, -- Coursing Bones (Oskana)
    [84197] = { duration = 433 }, -- Marsh Masher (Gathongor the Mauler)
    [83161] = { duration = 433 }, -- Stone Crusher (Thodundor of the Hill)
    [83141] = { duration = 433 }, -- Ground Shock (Thodundor of the Hill)

    --[[
    [64322] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [72479] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [75463] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433}, -- Magma Diver (The King's Gambit - Shield-Wife Razbela)
    [67156] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Kindlepitch Slick', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    [70543] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Oil Fire', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    ]]--

    -- Vvardenfell
    [86576] = { duration = 433 }, -- Renduril the Hammer (Nchuleftingth)
    [88510] = { duration = 433 }, -- Staggered (Vvardenfell -- Ancestral Adversity)

    -- Elsweyr
    [121476] = { duration = 433 }, -- Devastating Leap (Bone Flayer) (Bright Moons, Warm Sands)

    -- On Target
    [86310] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 500 }, -- Stagger (Player Blocks charged NPC attack)
    [21972] = { duration = 500 }, -- Stagger (Player interrupts NPC cast)

    -- Dragonstar Arena
    [53290] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = Abilities.Innate_Stagger, duration = 433 }, -- Stagger (Sovngarde Icemage)

    -- Maelstrom Arena
    [72012] = { duration = 700 }, -- Stagger (Iceberg)
    [71938] = { duration = 600 }, -- Frost Nova (Huntsman Chillbane)
    [72750] = { duration = 433 }, -- Freezing Stomp (Matriarch Runa)

    -----------------
    -- Dungeons -----
    -----------------

    -- Elden Hollow I
    [44093] = { duration = 433 }, -- Battlecry (Akash gra-Mal)
    [44092] = { duration = 433 }, -- Generic Stagger Enemy (Chokethorn)

    -- City of Ash I
    [44090] = { duration = 433 }, -- Generic Stagger Enemy (Infernal Guardian)
    [44089] = { duration = 433 }, -- Generic Stagger Enemy (Infernal Guardian)

    -- City of Ash II
    [55657] = { duration = 433 }, -- Venomous Explosion (Venomous Skeleton)
    [56264] = { duration = 500 }, -- Stagger (Horvantud the Fire Maw)
    [54221] = { duration = 500 }, -- Monstrous Cleave (Ash Titan)
    [54859] = { duration = 500 }, -- Stagger (Ash Titan)
    [56551] = { duration = 433 }, -- Lava Quake (Valkyn Skoria)

    -- Tempest Island
    [46737] = { duration = 433 }, -- Piercing Shriek (Sonolia the Matriarch)
    [46808] = { duration = 100 }, -- Stagger (Twister)

    -- Crypt of Hearts II
    [53403] = { duration = 433 }, -- Thunder Fist (Ilambris Amalgam)
    [51543] = { duration = 433 }, -- Necrotic Blast (Nerien'eth)
    [51867] = { duration = 567 }, -- Force Pulse (Nerien'eth)
    [52494] = { duration = 567 }, -- Ebony Whirlwind (Nerien'eth)

    -- Frostvault
    [117291] = { duration = 433 }, -- Stagger (Coldsnap Ogre)
    [109810] = { duration = 600 }, -- Frozen Aura (Icestalker)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Ground Damaging Effect Auras - We use EffectOverride to pull information for these unlike the other tables above.
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddGroundDamageAura = {

    --------------------
    -- PLAYER
    --------------------

    -- Siege
    [104693] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Meatbag Catapult
    [104695] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Scattershot Catapult

    -- Sets
    [59591] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Bogdan Totem (Bogdan the Nightflame)
    [97899] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Domihaus (Domihaus)
    [97883] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Domihaus (Domihaus)
    [97857] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Earthgore (Earthgore)
    [84502] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Grothdarr (Grothdarr)
    [80526] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ilambris
    [81038] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Sentinel of Rkugamz
    [59498] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spawn of Mephala
    [80522] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stormfist
    [102094] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Thurvokun
    [75692] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Bahraha's Curse
    [97539] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Draugr's Rest
    [67204] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Leeching Plate (of Leeching)
    [133494] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Aegis Caller (Aegis Caller's)
    [135658] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Winter's Respite (of Winter's Respite)

    -- Dragonknight
    [28995] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dragonknight Standard
    [32960] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shifting Standard
    [32964] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shifting Standard
    [32948] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Standard of Might

    [61772] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Ash Cloud (Ash Cloud)
    [34791] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Cinder Storm (Cinder Storm)
    [32711] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Eruption (Eruption)

    -- Nightblade
    [36052] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Twisting Path (Twisting Path)
    [64006] = { duration = 2000, type = BUFF_EFFECT_TYPE_BUFF }, -- Refreshing Path (Refreshing Path)
    [36490] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Veil of Blades (Veil of Blades)

    -- Sorcerer
    [23189] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Splash (Lightning Splash)
    [23202] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Liquid Lightning (Liquid Lightning)
    [23208] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Flood (Lightning Flood)
    [80435] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Suppression Field (Suppression Field)
    [80405] = { duration = 600, type = BUFF_EFFECT_TYPE_BUFF }, -- Absorption Field (Absorption Field)

    -- Templar
    [95931] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spear Shards
    [95955] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Luminous Shards
    [26879] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blazing Spear

    [26286] = { duration = 2100, type = BUFF_EFFECT_TYPE_BUFF }, -- Healing Ritual (Cleansing Ritual)
    [80172] = { duration = 2100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ritual of Retribution
    [26303] = { duration = 2100, type = BUFF_EFFECT_TYPE_BUFF }, -- Extended Ritual

    [112145] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Rune Focus (Rune Focus)
    [112166] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Channeled focus (Channeled Focus)
    [112167] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Rune Focus Circle Bonus (Restoring Focus)

    [22225] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Rite of Passage
    [22231] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Remembrance
    [22228] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Practiced Incantation

    [21753] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Nova
    [21756] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Solar Prison
    [21759] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Solar Disturbance

    -- Warden
    [130400] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Arctic Wind (Arctic Wind)
    [130402] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Polar Wind (Polar Wind)
    [130406] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Arctic Blast (Arctic Blast)

    [129434] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Budding Seeds (Budding Seeds)

    [85534] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Secluded Grove (Secluded Grove)
    [88747] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Enchanted Forest (Enchanted Forest)
    [88783] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Impaling Shards (Impaling Shards)
    [88791] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Gripping Shards (Gripping Shards)
    [88802] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Winter's Revenge (Winter's Revenge)

    [86247] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Sleet Storm (Sleet Storm)
    [88860] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Northern Storm (Northern Storm)
    [88863] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Permafrost (Permafrost)

    -- Necromancer
    [115254] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Boneyard (Boneyard)
    [117809] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unnerving Boneyard (Unnerving Boneyard)
    [117854] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Avid Boneyard (Avid Boneyard)

    [116410] = { duration = 500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shocking Siphon (Shocking Siphon)
    [118766] = { duration = 500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Detonating Siphon (Detonating Siphon)
    [118011] = { duration = 500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Mystic Siphon (Mystic Siphon)

    [122178] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frozen Colossus (Frozen Colossus)
    [122399] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 2 }, -- Pestilent Colossus (Pestilent Colossus)
    [122400] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 2 }, -- Pestilent Colossus (Pestilent Colossus)
    [122401] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 2 }, -- Pestilent Colossus (Pestilent Colossus)
    [122392] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Glacial Colossus (Glacial Colossus)

    [118289] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ravenous Goliath (Ravenous Goliath)

    [115385] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Life amid Death (Life amid Death)
    [118021] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Renewing Undeath (Renewing Undeath)
    [118813] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Enduring Undeath (Enduring Undeath)

    -- Two-Handed
    [126474] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stampede (Stampede)

    -- Bow
    [28877] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Volley)
    [38690] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Endless Hail (Endless Hail)
    [38696] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Arrow Barrage (Arrow Barrage)

    -- Destruction Staff
    [62896] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Fire
    [62971] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Storms
    [62931] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Frost
    [39054] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Fire
    [39079] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Storms
    [39071] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Frost
    [62912] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Fire
    [62990] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Storms
    [62951] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Frost

    [83626] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Fire Storm
    [83631] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Thunder Storm
    [83629] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Ice Storm
    [85127] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Fiery Rage
    [85131] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Thunderous Rage
    [85129] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Icy Rage
    [83683] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Flame
    [83687] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Lightning
    [83685] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Frost

    -- Restoration Staff
    [28386] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Grand Healing
    [40059] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Illustrious Healing
    [40061] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Healing Springs

    -- Fighters Guild
    [80293] = { duration = 600, type = BUFF_EFFECT_TYPE_BUFF }, -- Ring of Preservation (Ring of Preservation)

    -- Mages Guild
    [63429] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Meteor (Meteor)
    [63454] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ice Comet (Ice Comet)
    [63471] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shooting Star (Shooting Star)

    -- Undaunted
    [39299] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Orb (Necrotic Orb)
    [42029] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Mystic Orb (Mystic Orb)
    [42039] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Energy Orb (Energy Orb)

    -- Vampire
    [38935] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Swarming Scion

    -- Assault
    [38561] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Caltrops (Caltrops)
    [40267] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40252] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Razor Caltrops (Razor Caltrops)

    -- Volendrung
    [116669] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ebony Cyclone (Ruinous Cyclone)

    --------------------
    -- TRAPS
    --------------------

    [17314] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Trap (Player)

    [72888] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Attack 2 (Fire) -- Banished Cells II

    [33594] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire (Fire) -- Throne of the Wilderking

    [27940] = { duration = 350, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Laser Damage (Generic Flame Wave Shooter) -- Stros M'Kai
    [32245] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Searing Steam (Steam Trap) -- Stros M'Kai

    [26040] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Steam Blast (Steam Vent) -- Volenfell
    [26089] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Steam Blast (Steam Vent) -- Volenfell
    [26091] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Steam Blast (Steam Vent) -- Volenfell
    [26077] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Steam Blast (Steam Vent) -- Volenfell

    [110416] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Putrid Cloud (Gas Blossom) -- Housing
    [110542] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stunted Current (Static Pitcher) -- Housing

    --------------------
    -- NPC
    --------------------

    -- Cyrodiil
    [7883] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Guardian Storm (Cyrodiil Mage)
    [46819] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Storm Damage (Cyrodiil Mage)
    [52866] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Cyrodiil Archer)
    [54258] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Upgraded Volley (Cyrodiil Archer)
    [70414] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Cyrodiil Archer)

    -- Human
    [38125] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Caltrops  (Faction NPCs)
    [14068] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Archer Synergy)
    [10813] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Mage Synergy)
    [38260] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Mage Synergy)
    [28629] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Archer)
    [47102] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Rune (Fire Mage)
    [37131] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ice Cage (Battlemage)
    [44228] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dragonknight Standard (Dragonknight - NPC)

    [76624] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Voidbringer)
    [76728] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Voidbringer)

    [88330] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Masquer)
    [88334] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Masquer)

    [84837] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Broken Pact (Skaafin Witchling)

    -- Animal
    [16698] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poisonbloom (Netch)
    [90778] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Pool (Nix-Ox)
    [90815] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Pool (Nix-Ox)
    [85421] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Retch (Cliff Strider)

    -- Insect
    [13680] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Blood (Assassin Beetle)
    [5265] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burning Ground (Shalk)
    [72794] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Toxic Pool (Haj Mota)
    [87126] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Heat Vents (Fetcherfly Nest)

    -- Monsters
    [4769] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Choking Pollen (Lurcher)
    [16040] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Hurricane (Nereid)
    [75928] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Elemental Pool (Minotaur)
    [75953] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Brimstone Hailfire (Minotaur Shaman)
    [75976] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pillar of Nirn (Minotaur Shaman)
    [8628] = { duration = 800, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Charged Ground (Harpy)
    [103862] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Deluge (Yaghra Spewer)
    [103992] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Luminescent Burn (Yaghra Spewer)

    -- Daedra
    [9749] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Envelop (Banekin)
    [91938] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burst of Embers (Daedroth)
    [51645] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frozen Ground (Frost Atronach)
    [6162] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Rain of Fire (Scamp)
    [88323] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blast Furnace (Iron Atronach)
    [73437] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Flame (Daedric Titan)
    [53233] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Miasma Pool (Flesh Colossus)

    -- Undead
    [20812] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Ground (Lich)
    [73929] = { duration = 1000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Cage (Lich)
    [73937] = { duration = 1000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Cage (Lich)
    [69950] = { duration = 2100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Desecrated Ground (Desecrated Ground - Undead Synergy)

    -- Dwemer
    [19997] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Static Field (Dwemer Spider)

    [91094] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)
    [91095] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)
    [91096] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)

    ------------------
    -- WORLD BOSSES --
    ------------------

    -- Auridon
    [84045] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Seal of Defilement (Quenyas)

    -- Greenshade
    [84206] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stinging Sputum (Gathongor the Mauler)

    -- Stormhaven
    [84160] = { duration = 2100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spit Poison (Old Widow Silk)
    [83000] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Crabuchet (Titanclaw)

    ------------------
    -- QUESTS --------
    ------------------

    -- Elsweyr
    [121644] = { duration = 800, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Ground (Euraxian Necromancer) (Bright Moons, Warm Sands)

    -- Summerset

    ------------------
    -- ARENAS --------
    ------------------

    -- Dragonstar Arena
    [53314] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Flame Volley (Sovngarde Ranger)
    [53280] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Frost (Sovngarde Icemage)

    [53341] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Biting Cold (Biting Cold)
    [60421] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Biting Cold (Biting Cold)

    [83498] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poisonous Cloud (Poison Cloud)
    [53625] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Flood (Nak'tah)
    [54080] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Cinder Storm (Earthen Heart Knight)
    [52903] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Standard of Might (Anal'a Tu'wha)
    [83468] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Restoring Nature (Nature's Blessing)
    [52933] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Solar Disturbance (Shadow Knight)
    [55086] = { duration = 1700, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poison Mist (Vampire Lord Thisa)
    [55092] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Devouring Swarm (Vampire Lord Thisa)
    [55182]  = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Marked for Death (Hiath the Battlemaster)

    -- Maelstrom Arena
    [68197] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Essence (Necrotic Orb)
    [70901] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Grave (Maxus the Many)
    [72149] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Grave (Maxus the Many)

    [69101] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shock (Generator)
    [66797] = { duration = 333, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spinning Blade (Blade Trap)
    [69102] = { duration = 600, type = BUFF_EFFECT_TYPE_BUFF }, -- Heal (Generator)
    [69316] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Electric Shield (Centurion Champion)

    [67871] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shock (Water)
    [67758] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Queen's Poison (Lamia Queen)
    [68358] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Queen's Radiance (Lamia Queen)
    [72159] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Static Field (Dwarven Spider)
    [70860] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Overheated Flame (The Control Guardian)

    [72525] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frigid Waters (Player)
    [67808] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frigid Waters (Player)

    ------------------
    -- DUNGEONS ------
    ------------------

    -- Banished Cells I
    [19027] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dead Zone (Skeletal Destroyer)
    [33188] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)

    -- Banished Cells II
    [28904] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Immolating Bite (Maw of the Infernal)
    [31727] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Corruption (Daedric Chaos)
    [48800] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)
    [48815] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)

    -- Elden Hollow I
    [42601] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Circle (Canonreeve Oraneth)

    -- Elden Hollow II
    [32972] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Consuming Shadow (Murklight)
    [33050] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Eclipse (Murklight)
    [33103] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spout Shadow (The Shadow Guard)
    [33434] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Flame (Bogdan the Nightflame)

    -- City of Ash I
    [34960] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF },-- Blazing Fire (Warden of the Shrine)
    [34204] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burning Field

    -- City of Ash II
    [56415] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Runes (Urata the Legion)
    [56151] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ethereal Flame (Ash Titan)

    -- Tempest Island
    [26619] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shock (Sudden Storm)
    [6108] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Storm
    [26752] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Enervating Stone (Stormfist)

    -- Selene's Web
    [30908] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon Primal Swarm (Treethane Kerninn)
    [30773] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Arrow Rain (Longclaw)
    [31150] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poison Burst (Longclaw)

    -- Spindleclutch II
    [27603] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blood Pool (Urvan Veleth)
    [27906] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blood Pool (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [25591] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Essence (Necrotic Orb)

    -- Wayrest Sewers II
    [36625] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Scourging Spark (Malubeth the Scourger)
    [36869] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Scorching Flames (Uulgarg the Risen)

    -- Crypt of Hearts I
    [22716] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Necrotic Ritual (Archmaster Siniel)
    [46950] = { duration = 900, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Trail (Death's Leviathan)
    [22432] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Electric Prison (Ilambris-Athor)
    [22388] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Rain Fire (Ilambris-Zaven)

    -- Crypt of Hearts II
    [51883] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Creeping Storm (Creeping Storm)
    [52286] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 3 }, -- Rain Fire (Ilambris-Zaven)
    [52335] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 3 }, -- Rain Fire (Ilambris-Zaven)
    [52082] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Cursed Ground (Nerien'eth)
    [53157] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Cursed Ground (Nerien'eth)
    [53134] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Tortured Souls (Nerien'eth)

    -- Volenfell
    [25143] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burning Ground (Quintus Verres)
}

--------------------------------------------------------------------------------------------------------------------------------
-- When GetZoneId(GetCurrentMapZoneIndex()) matches this filter, customize the ability based off this criteria.
--------------------------------------------------------------------------------------------------------------------------------
Effects.ZoneDataOverride = {

    -- TUTORIAL AREAS

    [11338] = { -- In Lava
        [968] = { name = Abilities.Skill_Flames, icon = 'LuiExtended/media/icons/abilities/ability_trap_fire.dds', source = Abilities.Skill_Flames }, -- Firemoth Island (Vvardenfell - Broken Bonds)
    },
    [121005] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_heavy.dds' }, -- Heavy Attack (Vitrus the Bloody)
    },

    [70355] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite_black.dds' }, -- Bite (Great Bear)
    },
    [70357] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge_black.dds' }, -- Lunge (Great Bear)
    },
    [70359] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge_black.dds' }, -- Lunge (Great Bear)
    },
    [70366] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_black.dds' }, -- Slam (Great Bear)
    },
    [89189] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_black.dds' }, -- Slam (Great Bear)
    },
    [69073] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_black.dds' }, -- Knockdown (Great Bear)
    },
    [70374] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_ferocity_black.dds' }, -- Ferocity (Great Bear)
    },

    [80382] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite_white.dds' }, -- Bite (Dire Wolf)
        },
    [80383] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite_white.dds' }, -- Bite (Dire Wolf)
        },
    [76307] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge_white.dds' }, -- Lunge (Dire Wolf)
        },
    [76308] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge_white.dds' }, -- Lunge (Dire Wolf)
        },
    [76303] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip_white.dds' }, -- Nip (Dire Wolf)
        },
    [76304] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip_white.dds' }, -- Nip (Dire Wolf)
        },
    [76305] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash_white.dds' }, -- Gnash (Dire Wolf)
        },
    [76306] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash_white.dds' }, -- Gnash (Dire Wolf)
        },
    [76311] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_harry_white.dds' }, -- Harry (Dire Wolf)
        },
    [85656] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_harry_white.dds' }, -- Harry (Dire Wolf)
        },
    [76324] = {
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_baleful_call_white.dds' }, -- Baleful Call (Dire Wolf)
    },

    -- ALDMERI DOMINION

    [77905] = { -- Knockback (Giant)
        -- QUESTS
        [1013] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_impale.dds' }, -- Summerset (The Mind Trap) -- Yaghra Nightmare
        [381] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_shock_aura.dds', name = Abilities.Skill_Shock_Blast }, -- Auridon - Captain Blanchete
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_gore.dds', name = Abilities.Skill_Gore }, -- Deepwood Vale (Greymoor)
    },
    [77906] = { -- Stun (Giant)
        -- QUESTS
        [1013] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_impale.dds' }, -- Summerset (The Mind Trap) -- Yaghra Nightmare
        [381] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_shock_aura.dds', name = Abilities.Skill_Shock_Blast }, -- Auridon - Captain Blanchete
        [1160] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_gore.dds', name = Abilities.Skill_Gore }, -- Deepwood Vale (Greymoor)
    },

    -- DUNGEONS

    [10618] = { -- Quick Strike (Shared)
        -- DUNGEONS
        [931] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_light.dds' }, -- Elden Hollow II
    },

    [60920] = { -- Scrape (Giant Bat)
        [146] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_scrape_dark.dds' }, -- Wayrest Sewers
        [933] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_scrape_dark.dds' }, -- Wayrest Sewers II
    },
    [4632] = { -- Screech (Giant Bat)
        [146] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech_dark.dds' }, -- Wayrest Sewers
        [933] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech_dark.dds' }, -- Wayrest Sewers II
    },
    [47321] = { -- Screech (Giant Bat)
        [146] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech_dark.dds' }, -- Wayrest Sewers
        [933] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech_dark.dds' }, -- Wayrest Sewers II
    },
    [18319] = { -- Screech (Giant Bat)
        [146] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech_dark.dds' }, -- Wayrest Sewers
        [933] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech_dark.dds' }, -- Wayrest Sewers II
    },
    [4630] = { -- Draining Bite (Giant Bat)
        [146] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_draining_bite_dark.dds' }, -- Wayrest Sewers
        [933] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_draining_bite_dark.dds' }, -- Wayrest Sewers II
    },

    [21582] = { -- Nature's Swarm (Spriggan)
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm_red.dds' }, -- Hectahame Ritual Chamber
    },
    [31699] = { -- Nature's Swarm (Spriggan)
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm_red.dds' }, -- Hectahame Ritual Chamber
    },
    [13475] = { -- Healing Salve (Spriggan)
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_healing_salve_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_healing_salve_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_healing_salve_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_healing_salve_red.dds' }, -- Hectahame Ritual Chamber
    },
    [13477] = { -- Control Beast (Spriggan)
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_control_beast_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_control_beast_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_control_beast_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_control_beast_red.dds' }, -- Hectahame Ritual Chamber
    },

    [3757] = { -- Claw (Lurcher)
        [931] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_red.dds' }, -- Elden Hollow II
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_red.dds' }, -- Valenheart
        [559] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_red.dds' }, -- Hectahame Ritual Chamber
        [108] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_green.dds' }, -- Greenshade
    },
    [3860] = { -- Pulverize (Lurcher)
        [931] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_red.dds' }, -- Elden Hollow II
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_red.dds' }, -- Hectahame Ritual Chamber
        [559] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_red.dds' }, -- Valenheart
        [108] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_green.dds' }, -- Greenshade
    },
    [3855] = { -- Crushing Limbs (Lurcher)
        [931] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Elden Hollow II
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Hectahame Ritual Chamber
        [559] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Valenheart
        [108] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_green.dds' }, -- Greenshade
    },
    [38554] = { -- Crushing Limbs (Lurcher)
        [931] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Elden Hollow II
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Hectahame Ritual Chamber
        [559] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_red.dds' }, -- Valenheart
        [108] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs_green.dds' }, -- Greenshade
    },
    [3767] = { -- Choking Pollen (Lurcher)
        [931] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Elden Hollow II
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Hectahame Ritual Chamber
        [559] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Valenheart
        [108] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_green.dds' }, -- Greenshade
    },
    [4769] = { -- Choking Pollen (Lurcher)
        [931] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Elden Hollow II
        [Zonenames.Zone_Hectahame] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Hectahame
        [Zonenames.Zone_Hectahame_Armory] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Hectahame Armory
        [Zonenames.Zone_Hectahame_Arboretum] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Hectahame Arboretum
        [Zonenames.Zone_Hectahame_Ritual_Chamber] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Hectahame Ritual Chamber
        [559] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_red.dds' }, -- Valenheart
        [108] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen_green.dds' }, -- Greenshade
    },

    [9039] = {  -- Snare (Selene's Rose)
        [31] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_lash.dds', name = Abilities.Skill_Lash }, -- Selene's Web
        [933] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_scourging_spark_snare.dds', name = Abilities.Skill_Scourging_Spark }, -- Wayrest Sewers II
    },
    [33097] = { -- Scary Immunities (Flesh Atronach)
        [936] = { hide = true }, -- Spindleclutch II
    },
    [48281] = { -- Slash (Keeper Voranil)
        [935] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_light.dds' }, -- Banished Cells II
    },
    [27826] = { -- Crushing Blow (Yalorasse the Speaker)
        [58] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_dw_crushing_blow.dds', name = Abilities.Skill_Precision_Strike }, -- Tempest Island
        [935] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_slam.dds', name = Abilities.Skill_Crushing_Blow }, -- Banished Cells II
    },
    [27827] = { -- Crushing Blow (Yalorasse the Speaker)
        [58] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_dw_crushing_blow.dds', name = Abilities.Skill_Precision_Strike }, -- Tempest Island
        [935] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_slam.dds', name = Abilities.Skill_Crushing_Blow }, -- Banished Cells II
    },
    [27828] = { -- Crushing Blow  (Yalorasse the Speaker)
        [58] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_dw_crushing_blow.dds', name = Abilities.Skill_Precision_Strike }, -- Tempest Island
        [935] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_slam.dds', name = Abilities.Skill_Crushing_Blow }, -- Banished Cells II
    },
    [25034] = { -- Crushing Blow (Golor the Banekin Handler)
        [22] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_mighty_swing.dds', name = Abilities.Skill_Mighty_Swing }, -- Volenfell
    },
    [25035] = { -- Crushing Blow (Golor the Banekin Handler)
        [22] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_mighty_swing.dds', name = Abilities.Skill_Mighty_Swing }, -- Volenfell
    },
    [25036] = { -- Crushing Blow (Golor the Banekin Handler)
        [22] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_mighty_swing.dds', name = Abilities.Skill_Mighty_Swing }, -- Volenfell
    },

    -- QUESTS
    [1718] = { -- Attack (CH + Vvardenfell Tutorial)
        [809] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_light.dds' }, -- The Wailing Prison (MSQ - Tutorial) -- Dremora Churl
        [968] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_unarmed_light.dds' } -- Firemoth Island (Vvardenfell - Broken Bonds) -- Naryu
    },
    [61748] = { -- Heavy Attack (CH Tutorial)
        [809] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_heavy.dds' }, -- The Wailing Prison (MSQ - Tutorial) -- Dreamora Kynval
    },
    [14096] = { -- Heavy Attack (Footsoldier)
        [809] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_1h_heavy.dds' }, -- The Wailing Prison (MSQ - Tutorial) -- Dreamora Kynval
    },

}

Effects.MapDataOverride = {

    [70355] = {
        [Zonenames.Zone_Deepwood_Barrow] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite_w.dds' }, -- Bite (Great Bear)
    },
    [70357] = {
        [Zonenames.Zone_Deepwood_Barrow] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge_white.dds' }, -- Lunge (Great Bear)
    },
    [70359] = {
        [Zonenames.Zone_Deepwood_Barrow] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge_white.dds' }, -- Lunge (Great Bear)
    },
    [70366] = {
        [Zonenames.Zone_Deepwood_Barrow] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_white.dds' }, -- Slam (Great Bear)
    },
    [89189] = {
        [Zonenames.Zone_Deepwood_Barrow] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_white.dds' }, -- Slam (Great Bear)
    },
    [69073] = {
        [Zonenames.Zone_Deepwood_Barrow] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe_white.dds' }, -- Knockdown (Great Bear)
    },
    [70374] = {
        [Zonenames.Zone_Deepwood_Barrow] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_ferocity_white.dds' }, -- Ferocity (Great Bear)
    },

}
