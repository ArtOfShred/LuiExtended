--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

local Effects = LUIE.Data.Effects

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- We don't add bar highlights for 0 duration abilities, a few abilities with dynamic durations show as 0 duration so we need this override table.
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddNoDurationBarHighlight =
{

    -- Necromancer
    [115240] = true, -- Bitter Harvest
    [124165] = true, -- Deaden Pain
    [124193] = true, -- Necrotic Potency
    [118814] = true, -- Enduring Undeath
}

Effects.IsGrimFocus =
{
    [122585] = true, -- Grim Focus
    [122587] = true, -- Relentless Focus
    [122586] = true, -- Merciless Resolve
}

Effects.IsBloodFrenzy =
{
    [172418] = true, -- Blood Frenzy
    [134166] = true, -- Simmering Frenzy
    [172648] = true, -- Sated Fury
}

-- Table of all Major / Minor Effects (Used by CombatInfo Bar Highlight to override the 0 duration on these abilities)
Effects.MajorMinor =
{
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
    [145977] = true, -- Major Brittle

    -- Slayer / Aegis
    [76618] = true, -- Minor Aegis
    [93123] = true, -- Major Aegis
    [76617] = true, -- Minor Slayer
    [93109] = true, -- Major Slayer

    -- Empower
    [61737] = true, -- Empower
}

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged to display a Proc highlight / sound notification when an ability with a matching name appears as a buff.
--------------------------------------------------------------------------------------------------------------------------------
Effects.HasAbilityProc =
{
    [Abilities.Skill_Crystal_Fragments] = 46327,
}

-- Also track this id on bar highlight
-- SECONDARY ID = ORIGINAL BAR HIGHLIGHT ID
Effects.BarHighlightExtraId =
{

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
    [38703] = 100302, -- Acid Spray --> Piercing Spray

    [28887] = 113627, -- Virulent Shot --> Scatter Shot
    [38674] = 113627, -- Virulent Shot --> Magnum Shot
    [131688] = 113627, -- Virulent Shot --> Draining Shot

    -- Mages Guild
    [40468] = 40465, -- Scalding Rune
    [40476] = 40470, -- Volcanic Rune

    -- Psijic Order
    [104085] = 104079, -- Time Freeze

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
Effects.BarHighlightCheckOnFade =
{

    -- Dragonknight
    [108798] = { id1 = 21014, unitTag = "player" }, -- Protective Plate
    [31898] = { id1 = 20253, id2 = 31898, unitTag = "reticleover" }, -- Burning Talons

    -- Nightblade
    [125314] = { duration = 90620, durationMod = 125314, unitTag = "player" }, -- Phantasmal Escape --> Major Evasion

    -- Warden
    [130139] = { id1 = 130140, id2 = 130139, unitTag = "reticleover" }, -- Off-Balance --> Cutting Dive / Off-Balance

    [86009] = { id1 = 178020, unitTag = "player" }, -- Scorch
    [86019] = { id1 = 146919, unitTag = "player" }, -- Subterranean Assault
    [86015] = { id1 = 178028, unitTag = "player" }, -- Deep Fissure

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
    --[100302] = { id1 = 38707, id2 = 100302, unitTag = "reticleover" }, -- Piercing Spray --> Bombard / Bombard / Piercing Spray
    [100302] = { id1 = 38703, id2 = 100302, unitTag = "reticleover" }, -- Piercing Spray --> Acid Spray / Piercing Spray

    --113627] = { id1 = 28887, id2 = 113627, unitTag = "reticleover" }, -- Virulent Shot --> Scatter Shot / Virulent Shot
    --113627] = { id1 = 38674, id2 = 113627, unitTag = "reticleover" }, -- Virulent Shot --> Magnum Shot / Virulent Shot
    [113627] = { id1 = 131688, id2 = 113627, unitTag = "reticleover" }, -- Virulent Shot --> Draining Shot / Virulent Shot

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

Effects.BarHighlightStack =
{

    -- Sorcerer
    [24330] = 2, -- Haunting Curse (Haunting Curse)
    [89491] = 1, -- Haunting Curse (Haunting Curse)

    -- Warden
    [86009] = 2, -- Scorch (Scorch)
    [178020] = 1, -- Scorch (Scorch)
    [86019] = 2, -- Subterranean Assault
    [146919] = 1, -- Subterranean Assault
    [86015] = 2, -- Deep Fissure
    [178028] = 1, -- Deep Fissure
}

--------------------------------------------------------------------------------------------------------------------------------
-- Replaces the tracking ID on an ability bar ability with a different id for the purpose of tracking effect duration on Bar Highlight tracker.
--------------------------------------------------------------------------------------------------------------------------------
Effects.BarHighlightOverride =
{
    -- Optional
    -- newId = # -- Replace ID
    -- showFakeAura = true -- USE EVENT_COMBAT_EVENT instead - allows auras to display even if they weren't applied. Should be used with major/minor effects.
    -- noRemove = ture -- don't remove effect on fading or target change -- Doesn't apply to hostile effects. Should be used with major/minor effects.
    -- duration = # -- override duration
    -- hide = true -- Hide this bar highlight

    ---------------------------
    -- Dragonknight -----------
    ---------------------------

    -- Ardent Flame
    [23806] = { newId = 23808 }, -- Lava Whip --> Off Balance
    [20805] = { newId = 122658 }, -- Molten Whip --> Seething Fury
    [20816] = { newId = 164731 }, -- Flame Lash --> Off Balance
    [20824] = { newId = 164731 }, -- Flame Lash --> Off Balance
    [20657] = { newId = 44363 }, -- Searing Strike
    [20668] = { newId = 44369 }, -- Venomous Claw
    [20660] = { newId = 44373 }, -- Burning Embers
    [20917] = { newId = 31102 }, -- Fiery Breath
    [20944] = { newId = 31103 }, -- Noxious Breath
    [20930] = { newId = 31104 }, -- Engulfing Flames
    [20499] = { newId = 61737 }, -- Empowering Chains --> Empower
    [32963] = { newId = 32958 }, -- Shifting Standard

    -- Draconic Power
    [20245] = { newId = 20527 }, -- Dark Talons
    [20252] = { newId = 31898 }, -- Burning Talons
    [20251] = { newId = 20528 }, -- Choking Talons -- TODO: Possibly track Maim here as well
    [29004] = { showFakeAura = true, noRemove = true }, -- Dragon Blood
    [32744] = { showFakeAura = true, noRemove = true }, -- Green Dragon Blood
    [32722] = { showFakeAura = true, noRemove = true }, -- Coagulating Blood

    [21014] = { newId = 108798 }, -- Protective Plate
    [31837] = { newId = 31841, showFakeAura = true }, -- Inhale
    [32792] = { newId = 32796, showFakeAura = true }, -- Deep Breath
    [32785] = { newId = 32788, showFakeAura = true }, -- Draw Essence
    [29012] = { newId = 114590 }, -- Dragon Leap --> Stun
    [32719] = { newId = 114600 }, -- Take Flight --> Stun
    [32715] = { newId = 61814 }, -- Ferocious Leap

    -- Earthen Heart
    [133037] = { newId = 29032 }, -- Stonefist
    [133027] = { newId = 31816 }, -- Stone Giant
    [29043] = { newId = 92507, showFakeAura = true }, -- Molten Weapons --> Major Sorcery
    [31874] = { newId = 92503, showFakeAura = true }, -- Igneous Weapons --> Major Sorcery
    [31888] = { newId = 76537, showFakeAura = true }, -- Molten Armaments

    ---------------------------
    -- Nightblade -------------
    ---------------------------

    -- Assassination
    [18342] = { newId = 79717 }, -- Teleport Strike --> Minor Vulnerability
    [25493] = { newId = 35336 }, -- Lotus Fan
    [25484] = { newId = 79717 }, -- Ambush --> Minor Vulnerability
    [33375] = { newId = 61716 }, -- Blur --> Major Evasion
    [35414] = { newId = 61716 }, -- Mirage --> Major Evasion
    [35419] = { newId = 125314, noRemove = true }, -- Phantasmal Escape --> Major Evasion
    [61902] = { newId = 122585 }, -- Grim Focus
    [61927] = { newId = 122587 }, -- Relentless Focus
    [61919] = { newId = 122586 }, -- Merciless Resolve
    [33398] = { newId = 61389 }, -- Death Stroke --> Damage Taken Increased
    [36508] = { newId = 61393 }, -- Incapacitating Strike --> Damage Taken Increased
    [36514] = { newId = 61400 }, -- Soul Harvest --> Damage Taken Increased

    -- Shadow
    [25255] = { newId = 34733 }, -- Veiled Strike --> Off-Balance
    [25260] = { newId = 34733 }, -- Surprise Attack --> Off-Balance
    [25267] = { newId = 34736 }, -- Concealed Weapon
    [25375] = { newId = 25376 }, -- Shadow Cloak
    [25380] = { newId = 62141 }, -- Shadowy Disguise
    --[25352] = { }, -- Aspect of Terror -- TODO: Disabled because API won't return correct duration for Fear
    --[37470] = { }, -- Mass Hysteria -- TODO: Disabled because API won't return correct duration for Fear
    [33211] = { showFakeAura = true, noRemove = true }, -- Summon Shade
    [35434] = { showFakeAura = true, noRemove = true }, -- Dark Shade --> Summon Shade
    [35441] = { showFakeAura = true, noRemove = true }, -- Shadow Image --> Shadow
    [35445] = { newId = 35441, showFakeAura = true, noRemove = true }, -- Shadow Image Teleport --> Shadow

    -- Siphoning
    [33291] = { newId = 33292 }, -- Strife
    [34838] = { newId = 34841, noRemove = true }, -- Funnel Health
    [34835] = { newId = 34836 }, -- Swallow Soul
    [33308] = { newId = 108925, noRemove = true }, -- Malevolent Offering
    [34721] = { newId = 108927, noRemove = true }, -- Shrewd Offering
    [34727] = { newId = 108932, noRemove = true }, -- Healthy Offering
    [33326] = { newId = 33333 }, -- Cripple
    [36943] = { newId = 36947 }, -- Debilitate
    [36957] = { newId = 36960 }, -- Crippling Grasp
    [33316] = { newId = 33317, showFakeAura = true }, -- Drain Power --> Major Sorcery
    [36901] = { newId = 131344, showFakeAura = true }, -- Power Extraction --> Major Sorcery
    [36891] = { newId = 62240, showFakeAura = true }, -- Sap Essence --> Major Sorcery
    [25091] = { newId = 25093 }, -- Soul Shred
    [35460] = { newId = 35462 }, -- Soul Tether

    ---------------------------
    -- Sorcerer ---------------
    ---------------------------

    -- Dark Magic
    [24371] = { newId = 24559 }, -- Rune Prison
    [24578] = { newId = 24581 }, -- Rune Cage
    [24584] = { newId = 114903 }, -- Dark Exchange
    [24595] = { newId = 114908 }, -- Dark Deal
    [24589] = { newId = 114909 }, -- Dark Conversion
    [24828] = { newId = 24830 }, -- Daedric Mines
    [24842] = { newId = 24847 }, -- Daedric Tomb --> Daedric Mines
    [24834] = { newId = 25158 }, -- Daedric Minefield --> Daedric Mines

    -- Daedric Summoning
    [108840] = { newId = 108843 }, -- Summon Unstable Familiar --> Volatile Familiar
    [77182] = { newId = 88933 }, -- Summon Volatile Familiar --> Volatile Familiar
    [77140] = { newId = 88937 }, -- Summon Twilight Tormentor --> Twilight Tormentor
    [23634] = { newId = 80459 }, -- Summon Storm Atronach
    [23492] = { newId = 80463 }, -- Greater Storm Atronach
    [23495] = { newId = 80468 }, -- Summon Charged Atronach
    [24165] = { newId = 203447 }, -- Bound Armaments

    -- Storm Calling
    [18718] = { newId = 18746 }, -- Mages' Fury
    [19123] = { newId = 19125 }, -- Mages' Wrath
    [19109] = { newId = 19118 }, -- Endless Fury
    [23234] = { newId = 23235 }, -- Bolt Escape
    [23236] = { newId = 28482 }, -- Streak
    [23277] = { newId = 131383 }, -- Ball of Lightning

    ---------------------------
    -- Templar ----------------
    ---------------------------

    -- Aedric Spear
    [26158] = { newId = 37409 }, -- Piercing Javelin
    [26800] = { newId = 37414 }, -- Aurora Javelin
    [26804] = { newId = 32099 }, -- Binding Javelin
    [22149] = { newId = 49205 }, -- Focused Charge
    [22161] = { newId = 49213 }, -- Explosive Charge
    [15540] = { newId = 15546 }, -- Toppling Charge
    [26188] = { newId = 95933 }, -- Spear Shards (Spear Shards)
    [26858] = { newId = 95957 }, -- Luminous Shards (Luminous Shards)
    [26869] = { newId = 26880 }, -- Blazing Spear (Blazing Spear)
    [22178] = { newId = 22179 }, -- Sun Shield
    [22182] = { newId = 22183 }, -- Radiant Ward
    [22180] = { newId = 49091 }, -- Blazing Shield
    [22138] = { newId = 62593 }, -- Radial Sweep
    [22144] = { newId = 62599 }, -- Empowering Sweep
    [22139] = { newId = 62607 }, -- Crescent Sweep

    -- Dawn's Wrath
    [21726] = { newId = 21728 }, -- Sun Fire
    [21729] = { newId = 21731 }, -- Vampire's Bane
    [21732] = { newId = 21734 }, -- Reflective Light (Reflective Light)
    [22057] = { newId = 61737 }, -- Solar Flare --> Empower
    [22110] = { newId = 61737 }, -- Dark Flare --> Empower
    [21752] = { newId = 21976 }, -- Nova (Nova)
    [21755] = { newId = 22003 }, -- Solar Prison (Solar Prison)
    [21758] = { newId = 22001 }, -- Solar Disturbance (Solar Disturbance)

    -- Restoring Light
    [22253] = { newId = 35632 }, -- Honor the Dead
    [26209] = { newId = 88401 }, -- Restoring Aura --> Minor Magickasteal
    [26807] = { newId = 88401 }, -- Radiant Aura --> Minor Magickasteal
    [22265] = { showFakeAura = true }, -- Cleansing Ritual (Cleansing Ritual)
    [22259] = { showFakeAura = true }, -- Ritual of Retribution (Ritual of Retribution)
    [22262] = { showFakeAura = true }, -- Extended Ritual (Extended Ritual)

    [22240] = { newId = 37009 }, -- Channeled Focus
    [22237] = { newId = 114842 }, -- Restoring Focus

    [22223] = { showFakeAura = true }, -- Rite of Passage
    [22229] = { showFakeAura = true }, -- Remembrance
    [22226] = { showFakeAura = true }, -- Practiced Incantation

    ---------------------------
    -- Warden -----------------
    ---------------------------

    -- Animal Companions

    [85995] = { newId = 130129 }, -- Dive --> Off-Balance
    [85999] = { newId = 130139 }, -- Cutting Dive --> Off-Balance
    [86003] = { newId = 130145 }, -- Screaming Cliff Racer --> Off-Balance

    [86023] = { newId = 101703 }, -- Swarm
    [86027] = { newId = 101904 }, -- Fetcher Infection
    [86031] = { newId = 101944 }, -- Growing Swarm
    [86037] = { showFakeAura = true }, -- Falcon's Swiftness
    [86041] = { showFakeAura = true }, -- Deceptive Predator
    [86045] = { showFakeAura = true }, -- Bird of Prey

    -- Green Balance
    [85862] = { newId = 87019, showFakeAura = true }, -- Enchanted Growth --> Minor Endurance
    [85922] = { newId = 85840 }, -- Budding Seeds
    [85564] = { newId = 90266 }, -- Nature's Grasp
    [85858] = { newId = 87074 }, -- Nature's Embrace

    -- Winter's Embrace
    [86122] = { newId = 86224, showFakeAura = true }, -- Frost Cloak --> Major Resolve
    [86126] = { newId = 88758, showFakeAura = true }, -- Expansive Frost Cloak --> Major Resolve
    [86130] = { newId = 88761, showFakeAura = true }, -- Ice Fortress --> Major Resolve
    [86148] = { newId = 90833 }, -- Arctic Wind
    [86152] = { newId = 90835 }, -- Polar Wind
    [86156] = { newId = 90834 }, -- Arctic Blast --> Arctic Blast Stun

    [86135] = { showFakeAura = true }, -- Crystallized Shield --> Crystalized Shield
    [86139] = { showFakeAura = true }, -- Crystallized Slab --> Crystalized Slab
    [86143] = { showFakeAura = true }, -- Shimmering Shield --> Shimmering Shield

    ---------------------------
    -- Necromancer ------------
    ---------------------------

    [114860] = { newId = 114863 }, -- Blastbones
    [117330] = { newId = 114863 }, -- Blastbones
    [117690] = { newId = 117691 }, -- Blighted Blastbones
    [117693] = { newId = 117691 }, -- Blighted Blastbones
    [117749] = { newId = 117750 }, -- Stalking Blastbones
    [117773] = { newId = 117750 }, -- Relentless Blastbones --> Stalking Blastbones

    [115924] = { newId = 116445 }, -- Shocking Siphon
    [118763] = { newId = 118764 }, -- Detonating Siphon
    [118008] = { newId = 118009 }, -- Mystic Siphon

    [118226] = { newId = 125750 }, -- Ruinous Scythe --> Off Balance
    [118223] = { newId = 122625 }, -- Hungry Scythe

    [115238] = { newId = 115240 }, -- Bitter Harvest
    [118623] = { newId = 124165 }, -- Deaden Pain
    [118639] = { newId = 124193 }, -- Necrotic Potency

    [115177] = { newId = 121513 }, -- Grave Grasp
    [118308] = { newId = 118309 }, -- Ghostly Embrace
    [118352] = { newId = 118354 }, -- Empowering Grasp

    [114196] = { newId = 114206, showFakeAura = true }, -- Render Flesh --> Minor Defile
    [117883] = { newId = 117885, showFakeAura = true }, -- Resistant Flesh --> Minor Defile
    [117888] = { newId = 117890, showFakeAura = true }, -- Blood Sacrifice --> Minor Defile

    [115315] = { newId = 115326 }, -- Life amid Death
    [118017] = { newId = 118022 }, -- Renewing Undeath
    [118809] = { newId = 118814 }, -- Enduring Undeath

    [115926] = { newId = 116450 }, -- Restoring Tether
    [118070] = { newId = 118071 }, -- Braided Tether
    [118122] = { newId = 118123 }, -- Mortal Coil

    [118379] = { newId = 124999, showFakeAura = true }, -- Animate Blastbones

    ---------------------------
    -- Two Handed -------------
    ---------------------------

    [38807] = { newId = 61737 }, -- Wrecking Blow --> Empower
    [38814] = { newId = 131562 }, -- Dizzying Swing --> Off Balance
    [38788] = { newId = 38791 }, -- Stampede
    [38745] = { newId = 38747 }, -- Carve
    [38754] = { newId = 38763 }, -- Brawler

    [28448] = { newId = 99789 }, -- Critical Charge --> Merciless Charge
    [38778] = { newId = 99789 }, -- Critical Rush --> Merciless Charge

    [28297] = { showFakeAura = true, noRemove = true }, -- Momentum --> Major Brutality
    [38794] = { newId = 38797 }, -- Forward Momentum
    [83216] = { newId = 83217 }, -- Berserker Strike
    [83229] = { newId = 83230 }, -- Onslaught
    [83238] = { newId = 83239 }, -- Berserker Rage

    ---------------------------
    -- One Hand and Shield ----
    ---------------------------

    [28306] = { newId = 38254 }, -- Puncture --> Major Breach
    [38256] = { newId = 38254 }, -- Ransack --> Major Breach
    [38250] = { newId = 38254 }, -- Pierce Armor --> Major Breach
    [28304] = { newId = 61723 }, -- Low Slash --> Minor Maim
    [38268] = { newId = 61723 }, -- Deep Slash --> Minor Maim
    [38264] = { newId = 61723 }, -- Heroic Slash --> Minor Maim
    [28719] = { newId = 28720 }, -- Shield Charge
    [38401] = { newId = 38404 }, -- Shielded Assault
    [38405] = { newId = 38407 }, -- Invasion
    [38455] = { newId = 83446 }, -- Reverberating Bash
    [38452] = { newId = 80625 }, -- Power Slam --> Resentment

    ---------------------------
    -- Dual Wield -------------
    ---------------------------

    [28607] = { newId = 99806 }, -- Flurry --> Cruel Flurry
    [38857] = { newId = 99806 }, -- Rapid Strikes --> Cruel Flurry
    [38846] = { newId = 99806 }, -- Bloodthirst --> Cruel Flurry

    [28379] = { newId = 29293 }, -- Twin Slashes --> Twin Slashes Bleed
    [38839] = { newId = 38841 }, -- Rending Slashes --> Rending Slashes Bleed
    [38845] = { newId = 38852 }, -- Blood Craze

    [28591] = { newId = 100474 }, -- Whirlwind --> Chaotic Whirlwind
    [38891] = { newId = 100474 }, -- Whirling Blades --> Chaotic Whirlwind
    [38861] = { newId = 100474 }, -- Steel Tornado --> Chaotic Whirlwind

    [21157] = { newId = 61665 }, -- Hidden Blade --> Major Brutality
    [38914] = { newId = 61665 }, -- Shrouded Daggers --> Major Brutality
    [38910] = { newId = 126667 }, -- Flying Blade
    [126659] = { newId = 126667 }, -- Flying Blade

    [83600] = { newId = 85156 }, -- Lacerate
    [85187] = { newId = 85192 }, -- Rend
    [85179] = { newId = 85184 }, -- Thrive in Chaos

    ---------------------------
    -- Bow --------------------
    ---------------------------

    [38685] = { newId = 61726 }, -- Lethal Arrow --> Minor Defile
    [38687] = { newId = 61742 }, -- Focused Aim --> Minor Breach

    [28879] = { newId = 113627 }, -- Scatter Shot --> Virulent Shot
    [38672] = { newId = 113627 }, -- Magnum Shot --> Virulent Shot
    [38669] = { newId = 113627 }, -- Draining Shot --> Virulent Shot

    [31271] = { newId = 100302 }, -- Arrow Spray --> Piercing Spray
    [38705] = { newId = 100302 }, -- Bombard --> Piercing Spray
    [38701] = { newId = 100302 }, -- Acid Spray --> Piercing Spray

    [28869] = { newId = 44540 }, -- Poison Arrow
    [38645] = { newId = 44545 }, -- Venom Arrow
    [38660] = { newId = 44549 }, -- Poison Injection
    --[83465] = { newId = 55131, showFakeAura = true, duration = 4000 }, -- Rapid Fire --> CC Immunity
    [85257] = { newId = 85261 }, -- Toxic Barrage
    [85451] = { newId = 85458 }, -- Ballista

    ---------------------------
    -- Destruction Staff ------
    ---------------------------

    [46340] = { newId = 100306 }, -- Force Shock --> Concentrated Force (*VAS Destro*)
    [46348] = { newId = 100306 }, -- Crushing Shock --> Concentrated Force (*VAS Destro*)
    [46356] = { newId = 100306 }, -- Force Pulse --> Concentrated Force (*VAS Destro*)
    --[28807] = { newId = 28807 }, -- Wall of Fire
    --[28854] = { newId = 28854 }, -- Wall of Storms
    --[28849] = { newId = 28849 }, -- Wall of Frost
    --[39053] = { newId = 39053 }, -- Unstable Wall of Fire
    --[39073] = { newId = 39073 }, -- Unstable Wall of Storms
    --[39067] = { newId = 39067 }, -- Unstable Wall of Frost
    --[39012] = { newId = 39012 }, -- Blockade of Fire
    --[39018] = { newId = 39018 }, -- Blockade of Storms
    --[39028] = { newId = 39028 }, -- Blockade of Frost
    [29073] = { newId = 62648 }, -- Flame Touch
    [29089] = { newId = 62722 }, -- Shock Touch
    [29078] = { newId = 62692 }, -- Frost Touch
    [38985] = { newId = 140334 }, -- Flame Clench --> Destructive Impact (*Master Destro*)
    [38993] = { newId = 140334 }, -- Shock Clench --> Destructive Impact (*Master Destro*)
    [38989] = { newId = 38254 }, -- Frost Clench --> Taunt
    [38944] = { newId = 62682 }, -- Flame Reach
    [38978] = { newId = 62745 }, -- Shock Reach
    [38970] = { newId = 62712 }, -- Frost Reach
    [29173] = { newId = 61743 }, -- Weakness to Elements --> Major Breach
    [39089] = { newId = 39089 }, -- Elemental Susceptibility
    [39095] = { newId = 61743 }, -- Elemental Drain --> Major Breach
    [28794] = { newId = 115003 }, -- Fire Impulse --> Wild Impulse (*BRP Destro*)
    [28799] = { newId = 115003 }, -- Shock Impulse --> Wild Impulse (*BRP Destro*)
    [28798] = { newId = 115003 }, -- Frost Impulse --> Wild Impulse (*BRP Destro*)
    [39145] = { newId = 115003 }, -- Fire Ring --> Wild Impulse (*BRP Destro*)
    [39147] = { newId = 115003 }, -- Shock Ring --> Wild Impulse (*BRP Destro*)
    [39146] = { newId = 115003 }, -- Frost Ring --> Wild Impulse (*BRP Destro*)
    [39162] = { newId = 115003 }, -- Flame Pulsar --> Wild Impulse (*BRP Destro*)
    [39167] = { newId = 115003 }, -- Storm Pulsar --> Wild Impulse (*BRP Destro*)
    [39163] = { newId = 115003 }, -- Frost Pulsar --> Wild Impulse (*BRP Destro*)
    [83625] = { newId = 83625 }, -- Fire Storm
    [83630] = { newId = 83630 }, -- Thunder Storm
    [83628] = { newId = 83628 }, -- Icy Storm
    [83682] = { newId = 83682 }, -- Eye of Flame
    [83686] = { newId = 83686 }, -- Eye of Lightning
    [83684] = { newId = 83684 }, -- Eye of Frost
    [85126] = { newId = 85126 }, -- Fiery Rage
    [85130] = { newId = 85130 }, -- Thunderous Rage
    [85128] = { newId = 85128 }, -- Icy Rage

    ---------------------------
    -- Restoration Staff ------
    ---------------------------

    [37243] = { showFakeAura = true, noRemove = true }, -- Blessing of Protection (Blessing of Protection)
    [40103] = { showFakeAura = true, noRemove = true }, -- Blessing of Restoration (Blessing of Restoration)
    [40094] = { showFakeAura = true, noRemove = true }, -- Combat Prayer (Combat Prayer)
    [31531] = { newId = 86304 }, -- Force Siphon (Force Siphon)
    [40109] = { newId = 86304 }, -- Siphon Spirit (Siphon Spirit)
    [40116] = { newId = 86304 }, -- Quick Siphon (Quick Siphon)

    ---------------------------
    -- Armor ------------------
    ---------------------------

    [29556] = { newId = 63015, showFakeAura = true }, -- Evasion --> Major Evasion
    [39195] = { newId = 39196, showFakeAura = true }, -- Shuffle --> Major Evasion
    [39192] = { newId = 126958, showFakeAura = true }, -- Elude --> Major Evasion
    [29552] = { newId = 126581, noRemove = true }, -- Unstoppable
    [39205] = { newId = 126582, noRemove = true }, -- Immovable Brute
    [39197] = { newId = 126583, noRemove = true }, -- Immovable

    ---------------------------
    -- Soul Magic -------------
    ---------------------------

    [26768] = { newId = 126890 }, -- Soul Trap (Soul Trap)
    [40328] = { newId = 126895 }, -- Soul Splitting Trap (Soul Splitting Trap)
    [40317] = { newId = 126897 }, -- Consuming Trap (Consuming Trap)

    --[39270] = { newId = 55131, showFakeAura = true, duration = 5000 }, -- Soul Strike --> CC Immunity
    --[40420] = { newId = 55131, showFakeAura = true, duration = 6000 }, -- Soul Assault --> CC Immunity
    --[40414] = { newId = 55131, showFakeAura = true, duration = 5000 }, -- Shatter Soul --> CC Immunity

    ---------------------------
    -- Vampire ----------------
    ---------------------------

    [132141] = { newId = 172418 }, -- Blood Frenzy
    [134160] = { newId = 134166 }, -- Simmering Frenzy
    [135841] = { newId = 172648 }, -- Sated Fury

    [128709] = { newId = 128712 }, -- Mesmerize
    [137861] = { newId = 137865 }, -- Hypnosis
    [138097] = { newId = 138098 }, -- Stupefy

    ---------------------------
    -- Werewolf ---------------
    ---------------------------

    [32632] = { newId = 137156 }, -- Pounce --> Carnage
    [39105] = { newId = 137189 }, -- Brutal Pounce --> Brutal Carnage
    [39104] = { newId = 137164 }, -- Feral Pounce --> Feral Carnage

    [58317] = { newId = 137206, showFakeAura = true }, -- Hircine's Rage --> Major Berserk

    [32633] = { newId = 137257 }, -- Roar --> Off Balance
    [39113] = { newId = 137287 }, -- Ferocious Roar
    [39114] = { newId = 137312 }, -- Deafening Roar --> Off Balance
    [58855] = { newId = 58856 }, -- Infectious Claws
    [58864] = { newId = 58865 }, -- Claws of Anguish
    [58879] = { newId = 58880 }, -- Claws of Life

    ---------------------------
    -- Fighters Guild ---------
    ---------------------------

    [40336] = { newId = 40340 }, -- Silver Leash
    [40195] = { noRemove = true }, -- Camouflaged Hunter

    [35750] = { showFakeAura = true, noRemove = true }, -- Trap Beast
    [40382] = { showFakeAura = true, noRemove = true }, -- Barbed Trap
    [40372] = { showFakeAura = true, noRemove = true }, -- Lightweight Beast Trap

    [35713] = { newId = 62305 }, -- Dawnbreaker
    [40161] = { newId = 126312 }, -- Flawless Dawnbreaker
    [40158] = { newId = 62314 }, -- Dawnbreaker of Smiting

    ---------------------------
    -- Mages Guild ------------
    ---------------------------

    [28567] = { newId = 126370 }, -- Entropy
    [40457] = { newId = 126374 }, -- Degeneration --> Major Sorcery
    [40452] = { newId = 126371 }, -- Structured Entropy --> Major Sorcery

    [31642] = { newId = 48131 }, -- Equilibrium
    [40445] = { newId = 40449, showFakeAura = true }, -- Spell Symmetry (Spell Symmetry)
    [40441] = { newId = 48141, showFakeAura = true }, -- Balance
    [16536] = { newId = 63430 }, -- Meteor
    [40489] = { newId = 63456 }, -- Ice Comet
    [40493] = { newId = 63473 }, -- Shooting Star

    ---------------------------
    -- Psijic Order -----------
    ---------------------------

    [103488] = { newId = 104050 }, -- Time Stop
    [104059] = { newId = 104078 }, -- Borrowed Time
    [103503] = { newId = 103521, showFakeAura = true }, -- Accelerate --> Minor Force
    [103706] = { newId = 103708, showFakeAura = true }, -- Channeled Acceleration --> Minor Force
    [103710] = { newId = 103712, showFakeAura = true }, -- Race Against Time
    [103543] = { hide = true }, -- Mend Wounds
    [103747] = { hide = true }, -- Mend Spirit
    [103755] = { hide = true }, -- Symbiosis

    ---------------------------
    -- Undaunted --------------
    ---------------------------
    [39489] = { newId = 39489 }, -- blood altar
    [41967] = { newId = 41967 }, -- sanguine altar
    [41958] = { newId = 41958 }, -- overflowing altar
    [39425] = { newId = 39425 }, -- trapping webs
    [41990] = { newId = 41990 }, -- shadow silk
    [42012] = { newId = 42012 }, -- tangling webs
    [39475] = { newId = 38254 }, -- Inner Fire --> Taunt
    [42056] = { newId = 38254 }, -- Inner Rage --> Taunt
    [42060] = { newId = 42062 }, -- Inner Beast
    [39369] = { newId = 39369 }, -- bone shield
    [42138] = { newId = 42138 }, -- spiked bone shield
    [42176] = { newId = 42176 }, -- bone surge
    [39298] = { newId = 39298 }, -- necrotic orb
    [42028] = { newId = 42028 }, -- mystic orb
    [42038] = { newId = 42038 }, -- energy orb

    ---------------------------
    -- Assault ----------------
    ---------------------------

    [38566] = { newId = 61736 }, -- Rapid Maneuver --> Major Expedition
    [40211] = { newId = 61736 }, -- Retreating Maneuver --> Major Expedition
    [40215] = { newId = 61736 }, -- Charging Maneuver --> Major Expedition
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

    [61489] = { newId = 61498 }, -- Revealing Flare
    [61519] = { newId = 61522 }, -- Lingering Flare
    [61524] = { newId = 61526 }, -- Blinding Flare

    ---------------------------
    -- Volendrung -------------
    ---------------------------

    [116093] = { newId = 116364 }, -- Rourken's Rebuke
    [116095] = { newId = 116366 }, -- Pariah's Resolve
}

--------------------------------------------------------------------------------------------------------------------------------
-- When a bar ability proc with a matching id appears, change the icon.
--------------------------------------------------------------------------------------------------------------------------------
Effects.BarIdOverride =
{
    -- Dragonknight
    [20824] = "LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds", -- Power Lash (Flame Lash)

    -- Nightblade
    [35445] = "LuiExtended/media/icons/abilities/ability_nightblade_shadow_image_teleport.dds", -- Shadow Image Teleport (Shadow Image)

    -- Dual Wield
    [126659] = "LuiExtended/media/icons/abilities/ability_weapon_flying_blade_jump.dds", -- Flying Blade (Flying Blade)

    -- Sorcerer
    [108840] = "esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds", -- Summon Unstable Familiar (Summon Unstable Familiar)
    [108845] = "esoui/art/icons/ability_sorcerer_lightning_prey_summoned.dds", -- Winged Twilight Restore (Summon Winged Twilight)

    -- Support
    [78338] = "esoui/art/icons/ability_ava_guard.dds", -- Guard (Guard)
    [81415] = "esoui/art/icons/ability_ava_mystic_guard.dds", -- Mystic Guard (Mystic Guard)
    [81420] = "esoui/art/icons/ability_ava_stalwart_guard.dds", -- Stalwart Guard (Stalwart Guard)
}

--------------------------------------------------------------------------------------------------------------------------------
-- When a bar ability proc with a matching id appears, display the toggle highlight
--------------------------------------------------------------------------------------------------------------------------------

-- Switch backbar slotId's when we have a certain type of staff equipped
-- Back Bar ID will unfortunately return either the base ability or the element type of the Staff we are using in our current weapon pair, so have to check for ALL of these conditions
Effects.BarHighlightDestroFix =
{
    -- Base Ability
    [28858] = { [WEAPONTYPE_FIRE_STAFF] = 28807, [WEAPONTYPE_LIGHTNING_STAFF] = 28854, [WEAPONTYPE_FROST_STAFF] = 28849 }, -- Wall of Elements
    [39052] = { [WEAPONTYPE_FIRE_STAFF] = 39053, [WEAPONTYPE_LIGHTNING_STAFF] = 39073, [WEAPONTYPE_FROST_STAFF] = 39067 }, -- Unstable Wall of Elements
    [39011] = { [WEAPONTYPE_FIRE_STAFF] = 39012, [WEAPONTYPE_LIGHTNING_STAFF] = 39018, [WEAPONTYPE_FROST_STAFF] = 39028 }, -- Elemental Blockade
    [29091] = { [WEAPONTYPE_FIRE_STAFF] = 29073, [WEAPONTYPE_LIGHTNING_STAFF] = 29089, [WEAPONTYPE_FROST_STAFF] = 29078 }, -- Destructive Touch
    [38984] = { [WEAPONTYPE_FIRE_STAFF] = 38985, [WEAPONTYPE_LIGHTNING_STAFF] = 38993, [WEAPONTYPE_FROST_STAFF] = 38989 }, -- Destructive Clench
    [38937] = { [WEAPONTYPE_FIRE_STAFF] = 38944, [WEAPONTYPE_LIGHTNING_STAFF] = 38978, [WEAPONTYPE_FROST_STAFF] = 38970 }, -- Destructive Reach
    [28800] = { [WEAPONTYPE_FIRE_STAFF] = 28794, [WEAPONTYPE_LIGHTNING_STAFF] = 28799, [WEAPONTYPE_FROST_STAFF] = 28798 }, -- Impulse
    [39143] = { [WEAPONTYPE_FIRE_STAFF] = 39145, [WEAPONTYPE_LIGHTNING_STAFF] = 39147, [WEAPONTYPE_FROST_STAFF] = 39146 }, -- Elemental Ring
    [39161] = { [WEAPONTYPE_FIRE_STAFF] = 39162, [WEAPONTYPE_LIGHTNING_STAFF] = 39167, [WEAPONTYPE_FROST_STAFF] = 39163 }, -- Pulsar

    -- Fire Staff
    [28807] = { [WEAPONTYPE_FIRE_STAFF] = 28807, [WEAPONTYPE_LIGHTNING_STAFF] = 28854, [WEAPONTYPE_FROST_STAFF] = 28849 }, -- Wall of Elements
    [39053] = { [WEAPONTYPE_FIRE_STAFF] = 39053, [WEAPONTYPE_LIGHTNING_STAFF] = 39073, [WEAPONTYPE_FROST_STAFF] = 39067 }, -- Unstable Wall of Elements
    [39012] = { [WEAPONTYPE_FIRE_STAFF] = 39012, [WEAPONTYPE_LIGHTNING_STAFF] = 39018, [WEAPONTYPE_FROST_STAFF] = 39028 }, -- Elemental Blockade
    [29073] = { [WEAPONTYPE_FIRE_STAFF] = 29073, [WEAPONTYPE_LIGHTNING_STAFF] = 29089, [WEAPONTYPE_FROST_STAFF] = 29078 }, -- Destructive Touch
    [38985] = { [WEAPONTYPE_FIRE_STAFF] = 38985, [WEAPONTYPE_LIGHTNING_STAFF] = 38993, [WEAPONTYPE_FROST_STAFF] = 38989 }, -- Destructive Clench
    [38944] = { [WEAPONTYPE_FIRE_STAFF] = 38944, [WEAPONTYPE_LIGHTNING_STAFF] = 38978, [WEAPONTYPE_FROST_STAFF] = 38970 }, -- Destructive Reach
    [28794] = { [WEAPONTYPE_FIRE_STAFF] = 28794, [WEAPONTYPE_LIGHTNING_STAFF] = 28799, [WEAPONTYPE_FROST_STAFF] = 28798 }, -- Impulse
    [39145] = { [WEAPONTYPE_FIRE_STAFF] = 39145, [WEAPONTYPE_LIGHTNING_STAFF] = 39147, [WEAPONTYPE_FROST_STAFF] = 39146 }, -- Elemental Ring
    [39162] = { [WEAPONTYPE_FIRE_STAFF] = 39162, [WEAPONTYPE_LIGHTNING_STAFF] = 39167, [WEAPONTYPE_FROST_STAFF] = 39163 }, -- Pulsar

    -- Lightning Staff
    [28854] = { [WEAPONTYPE_FIRE_STAFF] = 28807, [WEAPONTYPE_LIGHTNING_STAFF] = 28854, [WEAPONTYPE_FROST_STAFF] = 28849 }, -- Wall of Elements
    [39073] = { [WEAPONTYPE_FIRE_STAFF] = 39053, [WEAPONTYPE_LIGHTNING_STAFF] = 39073, [WEAPONTYPE_FROST_STAFF] = 39067 }, -- Unstable Wall of Elements
    [39018] = { [WEAPONTYPE_FIRE_STAFF] = 39012, [WEAPONTYPE_LIGHTNING_STAFF] = 39018, [WEAPONTYPE_FROST_STAFF] = 39028 }, -- Elemental Blockade
    [29089] = { [WEAPONTYPE_FIRE_STAFF] = 29073, [WEAPONTYPE_LIGHTNING_STAFF] = 29089, [WEAPONTYPE_FROST_STAFF] = 29078 }, -- Destructive Touch
    [38993] = { [WEAPONTYPE_FIRE_STAFF] = 38985, [WEAPONTYPE_LIGHTNING_STAFF] = 38993, [WEAPONTYPE_FROST_STAFF] = 38989 }, -- Destructive Clench
    [38978] = { [WEAPONTYPE_FIRE_STAFF] = 38944, [WEAPONTYPE_LIGHTNING_STAFF] = 38978, [WEAPONTYPE_FROST_STAFF] = 38970 }, -- Destructive Reach
    [28799] = { [WEAPONTYPE_FIRE_STAFF] = 28794, [WEAPONTYPE_LIGHTNING_STAFF] = 28799, [WEAPONTYPE_FROST_STAFF] = 28798 }, -- Impulse
    [39147] = { [WEAPONTYPE_FIRE_STAFF] = 39145, [WEAPONTYPE_LIGHTNING_STAFF] = 39147, [WEAPONTYPE_FROST_STAFF] = 39146 }, -- Elemental Ring
    [39167] = { [WEAPONTYPE_FIRE_STAFF] = 39162, [WEAPONTYPE_LIGHTNING_STAFF] = 39167, [WEAPONTYPE_FROST_STAFF] = 39163 }, -- Pulsar

    -- Frost Staff
    [28849] = { [WEAPONTYPE_FIRE_STAFF] = 28807, [WEAPONTYPE_LIGHTNING_STAFF] = 28854, [WEAPONTYPE_FROST_STAFF] = 28849 }, -- Wall of Elements
    [39067] = { [WEAPONTYPE_FIRE_STAFF] = 39053, [WEAPONTYPE_LIGHTNING_STAFF] = 39073, [WEAPONTYPE_FROST_STAFF] = 39067 }, -- Unstable Wall of Elements
    [39028] = { [WEAPONTYPE_FIRE_STAFF] = 39012, [WEAPONTYPE_LIGHTNING_STAFF] = 39018, [WEAPONTYPE_FROST_STAFF] = 39028 }, -- Elemental Blockade
    [29078] = { [WEAPONTYPE_FIRE_STAFF] = 29073, [WEAPONTYPE_LIGHTNING_STAFF] = 29089, [WEAPONTYPE_FROST_STAFF] = 29078 }, -- Destructive Touch
    [38990] = { [WEAPONTYPE_FIRE_STAFF] = 38985, [WEAPONTYPE_LIGHTNING_STAFF] = 38993, [WEAPONTYPE_FROST_STAFF] = 38989 }, -- Destructive Clench
    [38970] = { [WEAPONTYPE_FIRE_STAFF] = 38944, [WEAPONTYPE_LIGHTNING_STAFF] = 38978, [WEAPONTYPE_FROST_STAFF] = 38970 }, -- Destructive Reach
    [28798] = { [WEAPONTYPE_FIRE_STAFF] = 28794, [WEAPONTYPE_LIGHTNING_STAFF] = 28799, [WEAPONTYPE_FROST_STAFF] = 28798 }, -- Impulse
    [39146] = { [WEAPONTYPE_FIRE_STAFF] = 39145, [WEAPONTYPE_LIGHTNING_STAFF] = 39147, [WEAPONTYPE_FROST_STAFF] = 39146 }, -- Elemental Ring
    [39163] = { [WEAPONTYPE_FIRE_STAFF] = 39162, [WEAPONTYPE_LIGHTNING_STAFF] = 39167, [WEAPONTYPE_FROST_STAFF] = 39163 }, -- Pulsar
}

Effects.IsAbilityActiveHighlight =
{
    -- Support
    [78338] = true, -- Guard (Guard)
    [81415] = true, -- Mystic Guard (Mystic Guard)
    [81420] = true, -- Stalwart Guard (Stalwart Guard)
}

Effects.RemoveAbilityActiveHighlight =
{
    -- Vampire
    [132141] = true, -- Blood Frenzy
    [134160] = true, -- Simmering Frenzy
    [135841] = true, -- Sated Fury
}

Effects.IsAbilityActiveGlow =
{

    [20824] = true, -- Power Lash (Flame Lash)

    [126659] = true, -- Flying Blade (Flying Blade)

    [137156] = true, -- Carnage (Pounce)
    [137184] = true, -- Brutal Carnage (Brutal Pounce)
    [137164] = true, -- Feral Carnage (Feral Pounce)
}
