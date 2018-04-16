-- List of all abilityId's that have been processed so far
-- These id's don't show up on the debug event for EVENT_COMBAT_EVENT or EVENT_EFFECT_CHANGED
debugAuras = {

-------------------------------------

            -- Temporary (for debugging NPC abilities)

            [46519] = true, -- Charging Manuever
            [101181] = true, -- Charging Manuever
            [57484] = true, -- Maor Gallop
            [46522] = true, -- Charging Manuever
            [46630] = true, -- Purge
            [46631] = true, -- Purge
            [41347] = true, -- Defensive Posture
            [41351] = true, -- Defensive Posture
            [63257] = true, -- Resolving Vigor
            [63255] = true, -- Resolving Vigor
            [63256] = true, -- Resolving Vigor
            [30043] = true, -- Dark Deal
            [30045] = true, -- Dark Exchange
            [30046] = true, -- Dark Exchange Heal
            [30406] = true, -- Critical Surge
            [62156] = true, -- Major Brutality
            [96474] = true, -- Surge Heal
            [39769] = true, -- Brawler
            [39771] = true, -- Brawler
            [39774] = true, -- Brawler
            [39772] = true, -- Brawler
            [39770] = true, -- Brawler Bleed
            [39892] = true, -- Forward Momentum
            [62398] = true, -- Forward Momentum
            [62397] = true, -- Momentum
            [62400] = true, -- Major Brutality
            [39984] = true, -- Dizzying Swing
            [39986] = true, -- Dizzying Swing
            [39987] = true, -- Dizzying Swing
            [39942] = true, -- Reverse Slice
            [39946] = true, -- Reverse Slice
            [39945] = true, -- Reverse Slice
            [80412] = true, -- Absorption Field
            [29881] = true, -- Absorption Field
            [62269] = true, -- Absorption Field
            [62267] = true, -- Absorption Field

            [81908] = true, -- Some Craglorn stuff
            [81904] = true, -- Some Craglorn stuff
            [81900] = true, -- Some Craglorn stuff
            [81914] = true, -- Some Craglorn stuff
            [81939] = true, -- Some Craglorn stuff
            [81898] = true, -- Some Craglorn stuff

            [33743] = true, -- Reflective Scale
            [23856] = true, -- Hardened Armor
            [31827] = true, -- Hardened Armor
            [23857] = true, -- Hardened Armor Damage Return
            [61834] = true, -- Major Ward
            [61835] = true, -- Major Resolve

            [73872] = true, -- Catapult (Orsinium)

            [36337] = true, -- Shadow Cloak
            [36340] = true, -- Shadow Cloak
            [77753] = true, -- Clairvoyance Fx

            [33670] = true, -- Take Flight
            [33669] = true, -- Take Flight
            [33668] = true, -- Take Flight
            [48758] = true, -- CC Immunity

            -- Sorc stuff --

            [62174] = true,
            [82801] = true,
            [30244] = true,
            [80497] = true,
            [80496] = true,
            [62173] = true,
            [81393] = true,
            [81391] = true,
            [40689] = true,
            [40599] = true,
            [40690] = true,
            [30245] = true,
            [40945] = true,
            [44552] = true,
            [40842] = true,
            [40944] = true,
            [81392] = true,
            [40600] = true,
            [81394] = true,
            [40687] = true,
            [40688] = true,
            [40744] = true,
            [40746] = true,
            [57480] = true,
            [101177] = true,
            [40946] = true,
            [00000] = true,

            -- POTIONS --
            -------------------------------------

            -- Crafted Potions (2 Traits)
            [64564] = true, -- Major Resolve (... of Armor)
            [79709] = true, -- Creeping Ravage Health (... of Creeping Ravage Health)
            [79857] = true, -- Minor Defile (... of Defile)
            [45236] = true, -- Increase Detection (... of Detection)
            [45222] = true, -- Major Fortitude (... of Health)
            [45239] = true, -- Unstoppable (... or Immovability)
            [45237] = true, -- Vanish (... of Invisiblity)
            [77767] = true, -- Clairvoyance Fx (... of Invisibility)
            [79705] = true, -- Lingering Restore Health (... of Lingering Health)
            [45224] = true, -- Major Intellect (... of Magicka)
            [79712] = true, -- of Protection (... of Protection)
            [46208] = true, -- Minor Fracture (... of Ravage Armor)
            [46113] = true, -- Health Potion Poison (... of Ravage Health)
            [46193] = true, -- Ravage Magicka (... of Ravage Magicka)
            [47204] = true, -- Minor Uncertainty (... of Ravage Spell Critical)
            [46202] = true, -- Minor Cowardice (... of Ravage Spell Power)
            [46206] = true, -- Minor Breach (... of Ravage Spell Protection)
            [46199] = true, -- Ravage Stamina (... of Ravage Stamina)
            [47203] = true, -- Minor Enervation (... of Ravage Weapon Critical)
            [46204] = true, -- Minor Maim (... of Ravage Weapon Power)
            [46210] = true, -- Hindrance (... of Slow)
            [64566] = true, -- Major Expedtion (... of Speed)
            [64570] = true, -- Major Prophecy (... of Spell Critical)
            [64558] = true, -- Major Sorcery (... of Spell Power)
            [64562] = true, -- Major Ward (... of Spell Protection)
            [45226] = true, -- Major Endurance (... of Stamina)
            [68565] = true, -- Stun (... of Stun)
            [79848] = true, -- Major Vitality (... of Major Vitality)
            [79844] = true, -- Minor Vulnerability (... of Minor Vulnerability)
            [64568] = true, -- Major Savagery (... of Weapon Critical)
            [64555] = true, -- Major Brutality (... of Weapon Power)

            -- Crafted Potions (3 Traits)
            [64565] = true, -- Major Resolve (... of Armor)
            -- (no ... of Creeping Ravage Health)
            [79860] = true, -- Minor Defile (... of Defile)
            [45458] = true, -- Increase Detection (... of Detection)
            [63670] = true, -- Major Fortitude (... of Health)
            [45463] = true, -- Unstoppable (... of Immovability)
            [45460] = true, -- Vanish (... of Invisibility)
            [77766] = true, -- Clairvoyance Fx (... of Invisibility)
            [79706] = true, -- Lingering Restore Health (... of Linger Health)
            [63676] = true, -- Major Intellect (... of Magicka)
            [79714] = true, -- Minor Protection (... of Protection)
            [46250] = true, -- Minor Fracture (... of Ravage Armor)
            [46217] = true, -- Health Potion Lingering Effect (... of Ravage Health)
            [46237] = true, -- Ravage Magicka (... of Ravage Magicka)
            -- (no ... of Ravage Spell Critical)
            [46244] = true, -- Minor Cowardice (... of Ravage Spell Power)
            [46248] = true, -- Reduce Spell Resistance (... of Ravage Spell Protection)
            [46240] = true, -- Ravage Stamina (... of Ravage Stamina)
            [47202] = true, -- Reduce Weapon Critical (... of Ravage Weapon Critical)
            [46246] = true, -- Minor Maim (... of Ravage Weapon Power)
            [46252] = true, -- Hindrance (... of Slow)
            [64567] = true, -- Major Expedition (... of Speed)
            [64572] = true, -- Major Prophecy (... of Spell Critical)
            [64561] = true, -- Major Sorcery (... of Spell Power)
            [64563] = true, -- Major Ward (... of Spell Protection)
            [63681] = true, -- Major Endurance (... of Stamina)
            -- (no... of Stun)
            [79850] = true, -- Major Vitality (... of Vitality)
            -- (no... of Vulnerability)
            [64569] = true, -- Major Savagery (... of Weapon Critical)
            [64554] = true, -- Major Brutality (... of Weapon Power)

            -- Vendor Potions + AVA Potions + Roguish Draughts
            [63672] = true, -- Major Fortitude (... of Health)
            [63678] = true, -- Major Intellect (... of Magicka)
            [63683] = true, -- Major Endurance (... of Stamina)
            [72935] = true, -- Major Endurance (Alliance Battle Draught)
            [72936] = true, -- Major Brutality (Alliance Battle Draught)
            [72928] = true, -- Major Fortitude (Alliance Health Draught)
            [72930] = true, -- Unstoppable (Alliance Health Draught)
            [72932] = true, -- Major Intellect (Alliance Spell Draught)
            [72933] = true, -- Major Sorcery (Alliance Spell Draught)
            [78054] = true, -- Major Endurance (Roguish Stealth Draught)
            [78058] = true, -- Vanish (Roguish Stealth Draught)
            [78057] = true, -- Clairvoyance Fx (Roguish Escape Draught)
            [78080] = true, -- Major Endurance (Roguish Escape Draught)
            [78081] = true, -- Major Expedition (Roguish Escape Draught)

            -- Crown Store Potions
            [68405] = true, -- Major Fortitude (Crown Tri-Restoration Potion)
            [68406] = true, -- Major Intellect (Crown Tri-Restoration Potion)
            [68408] = true, -- Major Endurance (Crown Tri-Restoration Potion)
            [86780] = true, -- Invisibility (Crown Invisibility Potion)
            [86782] = true, -- Clairvoyance Fx (Crown Invisibility Potion)
            [86683] = true, -- Major Intellect (Crown Spellcaster's Elixir)
            [86684] = true, -- Major Prophecy (Crown Spellcaster's Elixir)
            [86685] = true, -- Major Sorcery (Crown Spellcaster's Elixir)
            [86697] = true, -- Major Fortitude (Crown Survivor's Elixir)
            [86698] = true, -- Unstoppable (Crown Survivor's Elixir)
            [86699] = true, -- Invisiblity (Crown Survivor's Elixir)
            [86702] = true, -- Clairvoyance Fx (Crown Survivor's Elixir)
            [86693] = true, -- Major Endurance (Crown Warrior's Elixir)
            [86694] = true, -- Major Savagery (Crown Warrior's Elixir)
            [86695] = true, -- Major Brutality (Crown Warrior's Elixir)
            [92415] = true, -- Major Fortitude (Gold Coast Swift Survivor Elixir)
            [92418] = true, -- Major Expedition (Gold Coast Swift Survivor Elixir)
            [92416] = true, -- Unstoppable (Gold Coast Swift Survivor Elixir)

            -------------------------------------
            -- POTION UP FRONT EFFECTS
            -------------------------------------

            -- Crafted Potions (2 Traits)
            [45221] = true, -- Restore Health
            [45223] = true, -- Restore Magicka
            [46111] = true, -- Ravage Health
            [45225] = true, -- Restore Stamina

            -- Crafted Potions (3 Traits)
            [45382] = true, -- Restore Health
            [45385] = true, -- Restore Magicka
            [46215] = true, -- Damage Health
            [45388] = true, -- Restore Stamina

            -- Vendor Potions + AVA Potions + Roguish Draughts
            [17302] = true, -- Restore Health (Vendor)
            [17323] = true, -- Restore Magicka (Vendor)
            [17382] = true, -- Restore Stamina (Vendor)
            [72934] = true, -- Restore Stamina (Alliance Battle Draught)
            [72927] = true, -- Restore Health (Alliance Health Draught)
            [72931] = true, -- Restore Magicka (Alliance Spell Draught)
            [78053] = true, -- Restore Stamina (Roguish Stealth Draught)
            [78079] = true, -- Restore Stamina (Roguish Escape Draught)
            [68401] = true, -- Restore All Resources (Crown Tri-Restoration Potion)
            [68407] = true, -- Restore Magicka (Crown Tri-Restoration Potion)
            [68409] = true, -- Restore Stamina (Crown Tri-Restoration Potion)
            [86682] = true, -- Crown Spellcaster's Elixir (Crown Spellcaster's Elixir)
            [86696] = true, -- Crown Survivor's Elixir (Crown Survivor's Elixir)
            [86692] = true, -- Crown Warrior's Elixir (Crown Warrior's Elixir)
            [92414] = true, -- Crown Survivor's Elixir (Gold Coast Swift Survivor Elixir)

            -------------------------------------
            -- POISONS --
            -------------------------------------

            -- Crafted Poisons (2 Traits)
            [79133] = true, -- Drain Health (Drain Health Poison)
            [79134] = true, -- Restore Health (Drain Health Poison)
            [79025] = true, -- Ravage Health (Damage Health Poison)
            [82667] = true, -- Ravage Health (Damage Health Poison)
            [79137] = true, -- Drain Magicka (Drain Magicka Poison)
            [79138] = true, -- Restore Magicka (Drain Magicka Poison)
            [79037] = true, -- Ravage Magicka (Damage Magicka Poison)
            [79141] = true, -- Drain Stamina (Drain Stamina Poison)
            [79142] = true, -- Restore Stamina (Drain Stamina Poison)
            [79045] = true, -- Ravage Stamina (Damage Stamina Poison)
            [79284] = true, -- Drain Spell Resist (Ward-Draining Poison)
            [79285] = true, -- Minor Ward (Ward-Draining Poison)
            [79087] = true, -- Minor Breach (Breaching Poison)
            [79309] = true, -- Drain Physical Resist (Resolve-Draining Poison)
            [79310] = true, -- Minor Resolve (Resolve-Draining Poison)
            [79090] = true, -- Minor Fracture (Fracturing Poison)
            [79193] = true, -- Minor Cowardice (Sorcery-Draining Poison)
            [79221] = true, -- Minor Sorcery (Sorcery-Draining Poison)
            [79069] = true, -- Minor Cowardice (Cowardice Poison)
            [79280] = true, -- Drain Weapon Power (Brutality-Draining Poison)
            [79281] = true, -- Minor Brutality (Brutality-Draining Poison)
            [79083] = true, -- Minor Maim (Maiming Poison)
            [79446] = true, -- Minor Uncertainty (Prophecy-Draining Poison)
            [79447] = true, -- Minor Prophecy (Prophecy-Draining Poison)
            [79117] = true, -- Minor Uncertainty (Uncertainty Poison)
            [79450] = true, -- Minor Enervation (Savagery-Draining Poison)
            [79453] = true, -- Minor Savagery (Savagery-Draining Poison)
            [79113] = true, -- Minor Enervation (Enervating Poison)
            [79457] = true, -- Immobilize (Escapist's Poison)
            [79458] = true, -- Unstoppable (Escapist's Poison)
            [79122] = true, -- Immobilize (Entrapping Poison)
            [79996] = true, -- Revealing Poison (Stealth-Draining Poison)
            [80003] = true, -- Marking Poison (Conspicuous Poison)
            [79367] = true, -- Hindrance (Speed-Draining Poison)
            [79368] = true, -- Major Expedition (Speed-Draining Poison)
            [79094] = true, -- Hindrance (Hindering Poison)
            [79699] = true, -- Drain Health (Gradual Health Drain Poison)
            [81351] = true, -- Drain Health (Gradual Health Drain Poison)
            [79700] = true, -- Restore Health (Gradual Health Drain Poison)
            [79707] = true, -- Creeping Ravage Health (Gradual Ravage Health Poison)
            [79723] = true, -- Minor Vulnerability (Protection-Reversing Poison)
            [79725] = true, -- Minor Protection (Protection-Reversing Poison)
            [79715] = true, -- Minor Vulnerability (Vulnerability Poison)
            [79851] = true, -- Minor Defile (Vitality-Draining Poison)
            [79852] = true, -- Minor Vitality (Vitality-Draining Poison)
            [79861] = true, -- Minor Defile (Defiling Poison)

            -- Crafted Poisons (3 Traits)
            [79135] = true, -- Drain Health (Drain Health Poison)
            [79136] = true, -- Restore Health (Drain Health Poison)
            [78922] = true, -- Ravage Health (Damage Health Poison)
            [82668] = true, -- Ravage Health (Damage Health Poison)
            [79139] = true, -- Drain Magicka (Drain Magicka Poison)
            [79140] = true, -- Restore Magicka (Drain Magicka Poison)
            [79044] = true, -- Ravage Magicka (Damage Magicka Poison)
            [79143] = true, -- Drain Stamina (Drain Stamina Poison)
            [79144] = true, -- Restore Stamina (Drain Stamina Poison)
            [79046] = true, -- Ravage Stamina (Damage Stamina Poison)
            [79306] = true, -- Drain Spell Resist (Ward-Draining Poison)
            [79307] = true, -- Minor Ward (Ward-Draining Poison)
            [79086] = true, -- Minor Breach (Breaching Poison)
            [79311] = true, -- Drain Physical Resist (Resolve-Draining Poison)
            [79312] = true, -- Minor Resolve (Resolve-Draining Poison)
            [79091] = true, -- Minor Fracture (Fracturing Poison)
            [79278] = true, -- Drain Spell Power (Sorcery-Draining Poison)
            [79279] = true, -- Minor Sorcery (Sorcery-Draining Poison)
            [79082] = true, -- Minor Cowardice (Cowardice Poison)
            [79282] = true, -- Minor Maim (Brutality-Draining Poison)
            [79283] = true, -- Minor Brutality (Brutality-Draining Poison)
            [79085] = true, -- Minor Maim (Maiming Poison)
            [79448] = true, -- Drain Spell Crit (Prophecy-Draining Poison)
            [79449] = true, -- Minor Prophecy (Prophecy-Draining Poison)
            -- (no Uncertainty Poison)
            [79454] = true, -- Minor Enervation (Savagery-Draining Poison)
            [79455] = true, -- Minor Savagery (Savagery-Draining Poison)
            [79116] = true, -- Minor Enervation (Enervating Poison)
            [79459] = true, -- Immobilize (Escapist's Poison)
            [79460] = true, -- Unstoppable (Escapist's Poison)
            -- (no Entrapping Poison)
            [80002] = true, -- Revealing Poison (Stealth-Draining Poison)
            [80004] = true, -- Marking Poison (Conspicuous Poison)
            [79369] = true, -- Hindrance (Speed-Draining Poison)
            [79370] = true, -- Major Expedition (Speed-Draining Poison)
            [79102] = true, -- Hindrance (Hindering Poison)
            [79701] = true, --  Creeping Drain Health (Gradual Health Drain Poison)
            [81348] = true, -- Creeping Drain Helath (Gradual Health Drain Poison)
            [79702] = true, -- Lingering Restore Health (Gradual Health Drain Poison)
            -- (no Gradual Ravage Health Poison)
            -- (no Gradual Ravage Health Poison)
            [79726] = true, -- Minor Vulnerability (Protection-Reversing Poison)
            [79727] = true, -- Minor Protection (Protection-Reversing Poison)
            -- (no Vulnerability Poison)
            [79854] = true, -- Minor Defile (Vitality-Draining Poison)
            [79855] = true, -- Minor Vitality (Vitality-Draining Poison)
            [79862] = true, -- Minor Defile (Defiling Poison)

            -- Vendor Poisons
            [81553] = true, -- Ravage Health (Cloudy Damage Health Poison)
            [81551] = true, -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison)
            [81552] = true, -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison)
            [81554] = true, -- Hindrance (Cloudy Hindering Poison)

            -- Crown Poisons
            [88476] = true, -- Creeping Ravage Health (Crown Debilitating Poison)
            [88477] = true, -- Hindrance (Crown Debilitating Poison)
            [88471] = true, -- Drain Magicka (Crown Draining Poison)
            [88475] = true, -- Drain Stamina (Crown Draining Poison)
            [88473] = true, -- Restore Magicka (Crown Draining Poison)
            [88474] = true, -- Restore Stamina (Crown Draining Poison)
            [88469] = true, -- Minor Maim (Crown Enfeebling Poison)
            [88470] = true, -- Minor Defile (Crown Enfeebling Poison)
            [81274] = true, -- Ravage Health (Crown Lethal Poison)
            [81275] = true, -- Creeping Ravage Health (Crown Lethal Poison)
            [88462] = true, -- Immobilize (Crown Trapping Poison)
            [88463] = true, -- Hindrance (Crown Trapping Poison)

            -------------------------------------
            -- FOOD & DRINK --
            -------------------------------------

            -- General Events
            [47983] = true, -- Drink Bonus Duration
            [47984] = true, -- Food Bonus Duration
            [60315] = true, -- Eating Meal

            -- Crafted Food
            [61259] = true, -- Health Food (Green)
            [61260] = true, -- Magicka Food (Green)
            [61261] = true, -- Stamina Food (Green)
            [61294] = true, -- Magicka + Stamina Food (Blue)
            [61295] = true, -- Magicka Consumable
            [61255] = true, -- Health + Stamina Food (Blue)
            [61256] = true, -- Magicka Consumable
            [61257] = true, -- Health + Magicka Food (Blue)
            [61258] = true, -- Magicka Consumable
            [61218] = true, -- Triple Food (Purple)
            [61219] = true, -- Magicka Consumable
            [61220] = true, -- Magicka Consumable
            [72819] = true, -- Orzorga's Tripe Trifle Pocket (Blue)
            [72820] = true, -- Magicka Consumable
            [72822] = true, -- Orzorga's Blood Price Pie (Blue)
            [72823] = true, -- Magicka Consumable
            [72824] = true, -- Orzorga's Smoked Bear Haunch (Gold)
            [72825] = true, -- Magicka Consumable
            [72826] = true, -- Magicka Consumable
            [72827] = true, -- Magicka Consumable
            [100502] = true, -- Deregulated Mushroom Stew
            [100503] = true, -- Magicka Consumable
            [100498] = true, -- Clockwork Citrus Filet
            [100499] = true, -- Magicka Consumable
            [100500] = true, -- Magicka Consumable
            [100501] = true, -- Magicka Consumable

            -- Crafted Drink
            [61322] = true, -- Health Drink (Green)
            [61323] = true, -- Well Fed
            [61325] = true, -- Magicka Drink (Green)
            [61326] = true, -- Well Fed
            [61328] = true, -- Stamina Drink (Green)
            [61329] = true, -- Well Fed
            [61345] = true, -- Magicka + Stamina Drink (Blue)
            [61346] = true, -- Well Fed
            [61348] = true, -- Well Fed
            [61340] = true, -- Health + Stamina Drink (Blue)
            [61341] = true, -- Well Fed
            [61344] = true, -- Well Fed
            [61335] = true, -- Health + Magicka Drink (Blue)
            [61336] = true, -- Well Fed
            [61339] = true, -- Well Fed
            [61350] = true, -- Triple Drink (Purple)
            [61351] = true, -- Well Fed: Health Regen
            [61354] = true, -- Well Fed: Magicka Regen
            [61355] = true, -- Well Fed: Stamina Regen
            [72816] = true, -- Orzorga's Red Frothgar (Blue)
            [72817] = true, -- Magicka Consumable
            [100488] = true, -- Spring-Loaded Infusion
            [100490] = true, -- Magicka Consumable

            -- Crafted Seasonal Food
            [84681] = true, -- Crisp and Crunchy Pumpkin Skewer (Blue)
            [84682] = true, -- Increase Stamina
            [84683] = true, -- Witchfest Food: M, S, Meal
            [84709] = true, -- Crunchy Spider Skewer (Blue)
            [84710] = true, -- Increase Stamina Regen
            [84711] = true, -- Witchfest Food: Max M, Reg S,
            [84725] = true, -- Frosted Brains (Blue)
            [84728] = true, -- Increase Health Regen
            [84729] = true, -- Witchfest Food: M, H Reg Meal
            [84678] = true, -- Sweet Sanguine Apples (Green)
            [86789] = true, -- Alcaire Festival Sword-Pie (Green)
            [86749] = true, -- Jagga-Drenched "Mud Ball" (Blue)
            [86750] = true, -- Increase Stamina
            [86748] = true, -- New Life Food: Max M, S
            [86673] = true, -- Lava Foot Soup-and-Saltrice (Blue)
            [86674] = true, -- Increase Stamina Recovery
            [86669] = true, -- Newlife Food: Reg S, Max S, So
            [86560] = true, -- Old Aldmeri Orphan Gruel (Green)
            [86787] = true, -- Rajhin's Sugar Claws (Green)
            [89955] = true, -- Candied Jester's Coins (Blue)
            [89954] = true, -- Jesters Food: Max S, Reg M
            [89956] = true, -- Increase Max Magicka
            [89971] = true, -- Jewels of Misrule (Purple)
            [89953] = true, -- Jesters Food: Max H, Reg MS
            [89972] = true, -- Increase Magicka Recovery
            [88973] = true, -- Increase Health
            [89956] = true, -- Princess' Delight (Green)
            [89921] = true, -- Jesters Food: Butterflies
            [89919] = true, -- Jesters Food: Max M

            -- Crafted Seasonal Drink
            [84700] = true, -- Bowl of "Peeled Eyeballs" (Blue)
            [84701] = true, -- Increase Health Regen
            [84702] = true, -- Witchfest Drink: M, H, Flagon
            [84735] = true, -- Double Bloody Mara (Gold)
            [84736] = true, -- Increase Health
            [84737] = true, -- Witchfest Drink: Max MH, Flago
            [84720] = true, -- Ghastly Eye Bowl (Blue)
            [84722] = true, -- Increase Magicka Regen
            [84723] = true, -- Witchfest Food: Max M, Reg M,
            [84704] = true, -- Witchmother's Party Punch (Purple)
            [84705] = true, -- Increase Health Regen
            [84706] = true, -- Increase Health Regen
            [84731] = true, -- Witchmother's Potent Brew (Purple)
            [84734] = true, -- Witchfest Food: Max HM, Reg M,
            [84732] = true, -- Increase Health Regen
            [84733] = true, -- Increase Health Regen
            [86677] = true, -- Bergama Warning Fire (Blue)
            [86676] = true, -- Newlife Drink: Reg H, Max S, F
            [86678] = true, -- Increase Health Recovery
            [86746] = true, -- Betnikh Twice-Spiked Ale (Blue)
            [86745] = true, -- Newlife Drink: Reg H, M, Belch
            [86747] = true, -- Increase Health Recovery
            [86559] = true, -- Hissmir Fish-Eye Rye (Gold)
            [86558] = true, -- Newlife Drink: Reg MS, Flagon
            [86560] = true, -- Increase Stamina Recovery
            [86791] = true, -- Snow Bear Glow-Wine (Green)
            [89957] = true, -- Dubious Camoran Throne (Purple)
            [89939] = true, -- Jesters Food: Max HS, Reg S
            [89958] = true, -- Increase Stamina
            [89959] = true, -- Increase Health

            -- Vendor Food & Drink
            [66551] = true, -- Vendor Health Food (White)
            [66568] = true, -- Vendor Magicka Food (White)
            [66576] = true, -- Vendor Stamina Food (White)
            [66586] = true, -- Vendor Health Drink (White)
            [66588] = true, -- Well Fed
            [66590] = true, -- Vendor Magicka Drink (White)
            [66592] = true, -- Well Fed
            [66594] = true, -- Vendor Stamina Drink (White)
            [66596] = true, -- Well Fed

            -- AVA Food & Drink
            [72961] = true, -- Cyrodilic Field Bar (White)
            [72962] = true, -- Increase Max Health
            [72956] = true, -- Cyrodilic Field Tack (White)
            [72957] = true, -- Increase Max Health
            [72959] = true, -- Cyrodilic Field Treat (White)
            [72960] = true, -- Increase Max Health
            [72971] = true, -- Cyrodilic Field Tonic (White)
            [72972] = true, -- Well Fed
            [72973] = true, -- Well Fed
            [72965] = true, -- Cyrodilic Field Brew (White)
            [72966] = true, -- Well Fed
            [72967] = true, -- Well Fed
            [72968] = true, -- Cyrodilic Field Tea (White)
            [72969] = true, -- Well Fed
            [72970] = true, -- Well Fed

            -- Crown Food & Drink
            [85484] = true, -- Crown Crate Fortifying Meal
            [85485] = true, -- Increase Max Stamina
            [85486] = true, -- Increase Max Magicka
            [68411] = true, -- Crown Fortifying Meal
            [68412] = true, -- Increase Max Stamina
            [68413] = true, -- Increase Max Magicka
            [85497] = true, -- Crown Crate Refreshing Drink
            [85498] = true, -- Well Fed
            [85499] = true, -- Well Fed
            [85500] = true, -- Well Fed
            [68416] = true, -- Crown Refreshing Drink
            [68418] = true, -- Well Fed
            [68420] = true, -- Well Fed
            [68422] = true, -- Well Fed
            [92435] = true, -- Crown Combat Mystic's Stew
            [92434] = true, -- Increase Maximum Health and Ma
            [92437] = true, -- Increase Health
            [92474] = true, -- Crown Vigorous Ragout
            [92473] = true, -- Increase Maximum Health and St
            [92477] = true, -- Increase Health
            [92433] = true, -- Crown Stout Magic Liqueur
            [92432] = true, -- Crown Drink: M, H, Flagon
            [92436] = true, -- Increase Health Regen
            [92476] = true, -- Crown Vigorous Tincture
            [92475] = true, -- Crown Drink: M, H, Flagon
            [92478] = true, -- Increase Health Regen

            -------------------------------------
            -- MISC CONSUMABLES --
            -------------------------------------

            -- Experience Bonuses
            [64210] = true, -- Increased Experience (Psijic Ambrosia)
            [89683] = true, -- Increased Experience (Aetherial Ambrosia)
            [88445] = true, -- Increasde Experience (Mythic Aetherial Ambrosia)
            [66776] = true, -- Increased Experience (Crown Experience Scroll)
            [85501] = true, -- Increased Experience (Crown Crate Experience Scroll)
            [85502] = true, -- Increased Experience (Major Crown Crate Experience Scroll)
            [85503] = true, -- Increased Experience (Grand Crown Crate Experience Scroll)

            -- Other
            [68259] = true, -- 68235 Stun (Psijic Ambrosia Recipe, Fragment I-VII)
            [70582] = true, -- Roll 1d1000 (Merethic Resorative Resin)
            [70584] = true, -- 68235 Stun (Merethic Restorative Resin)
            [63427] = true, -- Clean Fish (Any Fish)
            [78052] = true, -- Minor Pardon (Counterfeit Pardon Edict)
            [76350] = true, -- Moderate Pardon (Leniency Edict)
            [76349] = true, -- Full Pardon (Grand Amnesty Edict)
            [68203] = true, -- Riding Lesson: Carry Capacity (Crown Lesson: Riding Capacity)
            [68356] = true, -- Riding Carry Track (Crown Lesson: Riding Capacity)
            [68533] = true, -- Carry Capacity Announcement Tr (Crown Lesson: Riding Capacity)
            [68201] = true, -- Riding Lesson: Speed (Crown Lesson: Riding Speed)
            [68472] = true, -- Riding Speed Tracking (Crown Lesson: Riding Speed)
            [68485] = true, -- Speed Announcement Tracker (Crown Lesson: Riding Speed)
            [68202] = true, -- Riding Lesson: Stamina(Crown Lesson: Riding Stamina)
            [68321] = true, -- Riding Stamina Tracking(Crown Lesson: Riding Stamina)
            [68528] = true, -- Stamina Announcement Tracker (Crown Lesson: Riding Stamina)
            [69293] = true, -- Sigil of Imperial Retreat (Sigil of Imperial Retreat)

            -- Seasonal
            [86792] = true, -- Eating (High Hrothgar Festival Mints)
            [86794] = true, -- Very Cold (High Hrothgar Festival Mints)
            [86739] = true, -- Drinking (Sailor's Warning Festival Grog)
            [86740] = true, -- Very Drunk (Sailor's Warning Festival Grog)
            [85353] = true, -- Sword Swallowing (Disposable Swallower's Sword)
            [85354] = true, -- Dagger Juggling (Disposable Juggling Knives)
            [85355] = true, -- Flame Juggling (Fire-Breather's Oil Bun)
            [87964] = true, -- Jester's Festival Illusion Daz (Sparkwreath Dazzler)
            [87965] = true, -- Jester's Festival Illusion Daz (Plume Dazzler)
            [87966] = true, -- Jester's Festival Illusion Daz (Spiral Dazzler)
            [88374] = true, -- Jester's Festival Illusion Daz (Sparkly Hat Dazzler)

            -------------------------------------
            -- MEMENTOS --
            -------------------------------------

            [26829] = true, -- Light of the Tribunal (Almalexia's Enchanted Lantern)
            [26736] = true, -- Bear Trap (Battered Bear Trap)
            [51555] = true, -- Bear Trap (Battered Bear Trap)
            [16846] = true, -- Blackfeather Court Whistle (Blackfeather Court Whistle)
            [41988] = true, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
            [39245] = true, -- Glimpse of the Forbidden (Discourse Amaranthine)
            [41950] = true, -- Fetish of Anger (Fetish of Anger)
            [21226] = true, -- Finvir's Trinket (Finvir's Trinket)
            [41948] = true, -- Glanir's Smoke Bomb (Glanir's Smoke Bomb)
            [25696] = true, -- Falcon Takeoff (Justal's Falcon)
            [25699] = true, -- Falcon Timer (Justal's Falcon)
            [25703] = true, -- Justal's Falcon (Justal's Falcon)
            [25701] = true, -- Q4333 Falcon land now (Justal's Falcon)
            [43700] = true, -- Wand of Finding (Lena's Wand of Finding)
            [43702] = true, -- Invis Chicken Delay (Lena's Wand of Finding)
            [43703] = true, -- Extracting... (Lena's Wand of Finding)
            [43704] = true, -- Extracting... (Lena's Wand of Finding)
            [43701] = true, -- Extracting... (Lena's Wand of Finding)
            --[6351] = true, -- CON_GhostlyFlash (Lodorr's Crown)
            [42076] = true, -- Tear (Mezha-dro's Sealing Amulet)
            [42080] = true, -- Tear (Mezha-dro's Sealing Amulet)
            [42105] = true, -- Nanwen's Sword (Nanwen's Sword)
            [34578] = true, -- Nirnroot Wine (Nirnroot Wine)
            --[8825] = true, -- Generic Crouch Fiddle Animatio (Questionable Meat Sack)
            [26339] = true, -- Eating (Questionable Meat Sack)
            [25369] = true, -- Sanguine's Goblet (Sanguine's Goblet)
            [42008] = true, -- Blessing of Root Sunder (Token of Root Sunder)
            [89550] = true, -- TROPHY Azura's Light (Twilight Shard)
            [42053] = true, -- Yokudan Salute (Yokudan Totem)
            --[12478] = true, -- CON_Ground Rise on (Yokudan Totem)
            [42067] = true, -- Explosion (Yokudan Totem)

            [79510] = true, -- TROPHY Blood Oath (Blade of the Blood Oath)
            [92862] = true, -- Ringing Bell (Dreamer's Chime)
            [92863] = true, -- Stun (Dreamer's Chime)
            --[00000] = true, -- BOX OF FORBIDDEN RELICS SAVED SPACE
            --[77785] = true, -- Rain of Coins (Coin of Illusory Riches)
            --[77786] = true, -- Stun (Coin of Illusory Riches)
            [73685] = true, -- Rkindaleft Trophy (Hidden Pressure Vent)
            [74151] = true, -- Stun (Hidden Pressure Vent)
            [73686] = true, -- Old Orsinium Trophy (Malacath's Wrathful Flame)
            [74232] = true, -- Stun (Malacath's Wrathful Flame)
            [77027] = true, -- Anniversary Cake - Forreals (Jubilee Cake)
            [87998] = true, -- Anniversary Cake (2nd Annual Jubilee Cake)
            [102009] = true, -- Anniversary Cake (3rd Annual Jubilee Cake)
            [77123] = true, -- Anniversary EXP Buff (Any Jubilee Cake)
            [81575] = true, -- Event - WitchFest Cauldron (Witchmother's Whistle)
            [84361] = true, -- Witchmother's Brew (Witchmother's Whistle)
            [84369] = true, -- Witchmother's Brew (Witchmother's Whistle)
            [86774] = true, -- Mudball (Mud Ball)
            [86777] = true, -- Mudball (Mud Ball)
            [86775] = true, -- Covered in Mud (Mud Ball)
            [86779] = true, -- Covered in Mud (Mud Ball)
            [87963] = true, -- Bestowed Cherry Blossoms (Cherry Blossom Branch)
            [91368] = true, -- Jester's Experience Boost Pie (The Pie of Misrule)
            [91369] = true, -- Jester's Experience Boost Pie (The Pie of Misrule)
            [91446] = true, -- Jester's Experience Boost Pie -- Breda's Bottomless Mead Mug
            [91450] = true, -- Breda's Magnificent Mead -- Breda's Bottomless Mead Mug
            [91451] = true, -- Breda's Magnificent Mead -- Breda's Bottomless Mead Mug
            [91452] = true, -- Breda's Magnificent Mead -- Breda's Bottomless Mead Mug
            [91453] = true, -- Breda's Magnificent Mead -- Breda's Bottomless Mead Mug
            [91449] = true, -- Breda's Magnificent Mead -- Breda's Bottomless Mead Mug

            [85344] = true, -- Atronach Aura (Storm Atronach Aura)
            [85349] = true, -- Atronach Transformation (Storm Atronach Transform)
            [85347] = true, -- Atronach Juggling (Storm Orb Juggle)
            [86976] = true, -- Spriggan Aura (Wild Hunt Leaf-Dance Aura)
            [86977] = true, -- Spriggan Transformation (Wild Hunt Transform)
            [86978] = true, -- Grand Spriggan Aura (Floral Swirl Aura)
            [92866] = true, -- Dwarven Globe (Dwarven Puzzle Orb)
            [92867] = true, -- Dwarven Tuning Forks (Dwaven Tonal Forks)
            [92868] = true, -- Dwarven Transformation (Dwemervamidium Mirage)

            [97273] = true, -- TROPHY Death Crate Mem 1 (Crow's Calling)
            [97275] = true, -- TROPHY Death Crate Mem 3 (Murderous Strike)
            [98378] = true, -- Murderous Strike (Murderous Strike)
            [97274] = true, -- Swarm of Crows (Swarm of Crows)

            [99318] = true, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
            [99319] = true, -- Flame Crate Memento 2 (Flame Pixie)
            [99320] = true, -- TROPHY Flame Crate Mem 3 (Flame Eruption)

            [101874] = true, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
            [101877] = true, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
            [101872] = true, -- _CRWN Dragon Priest Memento 3 (Bone Dragon Summons Focus)

            -------------------------------------
            -- PETS --
            -------------------------------------

            --[76364] = true, -- _CRWN_5s
            --[76365] = true, -- _CRWN_Echalette_Buck
            --[76367] = true, -- _CRWN_ResetPosture
            --[76368] = true, -- _CRWN_1s
            --[78642] = true, -- _CRWN_Jackal_Mouse
            --[78463] = true, -- _CRWN_Jackal_Digging
            --[81301] = true, -- _CRWN_Badger_EatCritter

            -------------------------------------
            -- OTHER COLLECTIBLES --
            -------------------------------------

            [77645] = true, -- Stealth (Pirharri the Smuggler)
            [77629] = true, -- Stun For Costumes, 3s (Various Polymorphs)
            [77630] = true, -- Stun For Costumes, 4s (Various Polymorphs)

            -------------------------------------
            -- ENCHANTS --
            -------------------------------------

            -- Jewelry Enchants
            [46751] = true, -- Increase Bash Damage (Glyph of Bashing)
            [46741] = true, -- Increase Potion Effect (Glyph of Potion Boost)
            [46742] = true, -- Reduce Potion Cooldown (Glyph of Potion Speed)
            [46733] = true, -- Reduce Stamina Cost (Glyph of Reduce Feat Cost)
            [26750] = true, -- Reduce Magicka Cost (Glyph of Reduce Spell Cost)
            [46739] = true, -- Reduce Block and Bash Cost (Glyph of Shielding)

            -- Weapon Enchants
            [28919] = true, -- Life Drain (Glyph of Absorb Health)
            [28921] = true, -- Life Drain (Glyph of Absorb Health)
            [46743] = true, -- Absorb Magicka (Glyph of Absorb Magicka)
            [46744] = true, -- Absorb Magicka (Glyph of Absorb Magicka)
            [46746] = true, -- Absorb Stamina (Glyph of Asborb Stamina)
            [46747] = true, -- Absorb Stamina (Glyph of Asborb Stamina)
            [17906] = true, -- Crusher (Glyph of Crushing)
            [46749] = true, -- Damaage Health (Glyph of Decrease Health)
            [17895] = true, -- Fiery Weapon (Glyph of Flame)
            [17904] = true, -- Befouled Weapon (Glyph of Foulness)
            [17897] = true, -- Frozen Weapon (Glyph of Frost)
            [17947] = true, -- Hardening (Glyph of Hardening)
            [21578] = true, -- Hardening (Glyph of Hardening)
            [17902] = true, -- Poisoned Weapon (Glyph of Poison)
            [40337] = true, -- Prismatic Weapon (Glyph of Prismatic Onslaught)
            [17899] = true, -- Charged Weapon (Glyph of Shock)
            [17945] = true, -- Weakening (Glyph of Weakening)
            [17910] = true, -- Weapon Damage (Glyph of Weapon Damage)
            [21230] = true, -- Berserker (Glyph of Weapon Damage)

            -------------------------------------
            -- STATUS EFFECT PROCS --
            -------------------------------------

            [18084] = true, -- Burning (Fire Status Effect)
            [21925] = true, -- Diseased (Disease Status Effect)
            [21927] = true, -- Major Defile (Disease Status Effect)
            [21481] = true, -- Chill (Frost Status Effect)
            [68368] = true, -- Minor Maim (Frost Status Effect)
            [95136] = true, -- Chill (Frost Status Effect)
            [21929] = true, -- Poisoned (Poison Status Effect)
            [21487] = true, -- Concussion (Shock Status Effect)
            [68359] = true, -- Minor Maim (Shock Status Effect)
            [95134] = true, -- Concussion (Shock Status Effect)

            -------------------------------------
            -- VULNERABILITY PROCS --
            -------------------------------------

            [68448] = true, -- Explosion (Fire Vulnerability Proc)
            [21480] = true, -- Explosion (Fire Vulnerability Proc)
            [68463] = true, -- Venom (Poison Vulnerability Proc)
            [68464] = true, -- Venom (Poison Vulnerability Proc)
            [68462] = true, -- Pestilence (Disease Vulnerability Proc)
            [68461] = true, -- Pestilence (Disease Vulnerability Proc)
            [68451] = true, -- Disintegration (Lightning Vulnerability Proc)
            [68455] = true, -- Disintegration (Lightning Vulnerability Proc)
            [68458] = true, -- Deep Freeze (Frost Vulnerability Proc)
            [68457] = true, -- Deep Freeze (Frost Vulnerability Proc)

            -------------------------------------
            -- EQUIPMENT --
            -------------------------------------

            -- Weapons
            [100473] = true, -- Chaotic Whirlwind (Asylum)
            [100301] = true, -- Piercing Spray (Asylum)
            [100302] = true, -- Piercing Spray (Asylum)
            [100293] = true, -- Disciplined Slash (Asylum)
            [100294] = true, -- Disciplined Slash (Asylum)
            [100461] = true, -- Defensive Position (Asylum)
            [100463] = true, -- Defensive Position (Asylum)
            [100465] = true, -- Defensive Position (Perfected) (Asylum)
            [100462] = true, -- Defensive Position (Asylum)
            [100464] = true, -- Defensive Position (Asylum)
            [100303] = true, -- Concentrated Forced (Asylum)
            [100304] = true, -- Concentrated Forced (Asylum)
            [100306] = true, -- Concentrated Forced (Asylum)
            [100307] = true, -- Timeless Blessing (Asylum)
            [100308] = true, -- Timeless Blessing (Asylum)

            [99597] = true, -- Chaotic Whirlwind (Perfected) (Asylum)
            [99362] = true, -- Piercing Spray (Perfected) (Asylum)
            [99363] = true, -- Piercing Spray (Perfected) (Asylum)
            [99360] = true, -- Disciplined Slash (P) (Asylum)
            [99361] = true, -- Disciplined Slash (Perfected) (Asylum)
            [99896] = true, -- Defensive Position (Asylum)
            [100454] = true, -- Defensive Position (Perfected) (Asylum)
            [100455] = true, -- Defensive Position (Asylum)
            [99920] = true, -- Defensive Position (Perfected) (Asylum)
            [99919] = true, -- Defensive Position (Perfected) (Asylum)
            [99596] = true, -- Concentrated Force (Perfected) (Asylum)
            [99987] = true, -- Concentrated Force (P) (Asylum)
            [99989] = true, -- Concentrated Force (P) (Asylum)
            [99550] = true, -- Timeless Blessing (Perfected) (Asylum)
            [99582] = true, -- Timeless Blessing (Perfected) (Asylum)

            [99805] = true, -- Cruel Flurry (Maelstrom)
            [99806] = true, -- Cruel Flurry (Maelstrom)
            [99851] = true, -- Thunderous Volley (Maelstrom)
            [99852] = true, -- Thunderous Volley (Maelstrom)
            [99854] = true, -- Thunderous Volley (Maelstrom)
            [99853] = true, -- Thunderous Volley (Maelstrom)
            [99787] = true, -- Merciless Charge (Maelstrom)
            [99789] = true, -- Merciless Charge (Maelstrom)
            [99801] = true, -- Rampaging Slash (Maelstrom)
            [100588] = true, -- Rampaging Slash (Maelstrom)
            [100586] = true, -- Rampaging Slash (Maelstrom)
            [100587] = true, -- Rampaging Slash (Maelstrom)
            [100589] = true, -- Rampaging Slash (Maelstrom)
            [99875] = true, -- Crushing Wall (Maelstrom)
            [100155] = true, -- Crushing Wall (Maelstrom)
            [99876] = true, -- Crushing Wall (Maelstrom)
            [99886] = true, -- Precise Regeneration (Maelstrom)
            [100161] = true, -- Precise Regeneration (Maelstrom)
            [100165] = true, -- Precise Regeneration (Maelstrom)
            [99887] = true, -- Precise Regeneration (Maelstrom)

            [99762] = true, -- Stinging Slashes (Master)
            [100070] = true, -- Stinging Slashes (Master)
            [99766] = true, -- Caustic Arrow (Master)
            [100105] = true, -- Caustic Arrow (Master)
            [99742] = true, -- Titanic Cleave (Master)
            [101798] = true, -- Titanic Cleave (Master)
            [99759] = true, -- Puncturing Remedy (Master)
            [99761] = true, -- Puncturing Remedy (Master)
            [100575] = true, -- Puncturing Remedy (Master)
            [99774] = true, -- Destructive Impact (Master)
            [99780] = true, -- Grand Rejuvenation (Master)
            [99781] = true, -- Grand Rejuvenation (Master)

            -- Monster Helms
            [59516] = true, -- Blood Spawn
            [59517] = true, -- Blood Spawn
            [61274] = true, -- Blood Spawn

            [59589] = true, -- Nightflame
            [59590] = true, -- Imperial Prison Item Set
            [59591] = true, -- Bogdan Totem
            [61381] = true, -- Imperial Prison Item Set

            [81068] = true, -- Chokethorn
            [81069] = true, -- Chokethorn
            [81077] = true, -- Chokethorn

            [97879] = true, -- Domihaus
            [97901] = true, -- Domihaus
            [97900] = true, -- Domihaus
            [97899] = true, -- Domihaus
            [97882] = true, -- Domihaus
            [97896] = true, -- Domihaus
            [97883] = true, -- Domihaus

            [97854] = true, -- Earthgore
            [97855] = true, -- Earthgore
            [97857] = true, -- Earthgore

            [84492] = true, -- Grothdarr
            [84504] = true, -- Grothdarr
            [84502] = true, -- Grothdarr

            [80560] = true, -- Iceheart
            [80561] = true, -- Iceheart
            [80562] = true, -- Iceheart
            [80563] = true, -- Iceheart

            [80524] = true, -- Ilambris
            [80529] = true, -- Ilambris
            [80526] = true, -- Ilambris
            [80527] = true, -- Ilambris
            [80525] = true, -- Ilambris

            [81687] = true, -- Infernal Guardian
            [83405] = true, -- Infernal Guardian
            [83390] = true, -- Infernal Guardian
            [83393] = true, -- Infernal Guardian
            [83409] = true, -- Infernal Guardian

            [80564] = true, -- Kra'gh
            [80566] = true, -- Kra'gh
            [80565] = true, -- Kra'gh

            [59585] = true, -- Lord Warden
            [59586] = true, -- Lord Warden
            [59587] = true, -- Lord Warden

            [59564] = true, -- Scourge Harvester (Malubeth)
            [85658] = true, -- Scourge Harvest (Malubeth)
            [59568] = true, -- Scourge Harvest (Malubeth)
            [61275] = true, -- Major Vitality (Malubeth)
            [59573] = true, -- Scourge Harvest (Malubeth)

            [59507] = true, -- Maw of the Infernal (Maw of the Infernal)
            [48796] = true, -- DUMMY (Maw of the Infernal)
            [59508] = true, -- Banished Cells Item Set (Maw of the Infernal)
            [60974] = true, -- Jagged Claw (Maw of the Infernal)
            [60971] = true, -- Fiery Breath (Maw of the Infernal)
            [60972] = true, -- Fiery Breath (Maw of the Infernal)
            [60973] = true, -- Fiery Jaws (Maw of the Infernal)

            [80482] = true, -- Major Ward (Mighty Chudan)
            [91983] = true, -- Major Resolve (Mighty Chudan)

            [66792] = true, -- Molag Kena
            [66808] = true, -- Molag Kena
            [66812] = true, -- Overkill

            [59592] = true, -- Nerien'eth
            [59594] = true, -- Crpyt of Hearts Item Set
            [59593] = true, -- Lich Crystal

            [80501] = true, -- Pirate Skeleton
            [81675] = true, -- Pirate Skeleton
            [80853] = true, -- Pirate Skeleton
            [85637] = true, -- Pirate Skeleton

            [80599] = true, -- Selene
            [80607] = true, -- Dummy
            [80600] = true, -- Selene
            [80604] = true, -- Selene
            [80609] = true, -- Dummy
            [80606] = true, -- Selene

            [80542] = true, -- Sellistrix
            [80545] = true, -- Sellistrix
            [80544] = true, -- Sellistrix
            [80549] = true, -- Sellistrix

            [81035] = true, -- Sentinel of Rkugamz
            [81036] = true, -- Sentinel of Rkugamz
            [81037] = true, -- Sentinel of Rkugamz
            [81038] = true, -- Sentinel of Rkugamz
            [81041] = true, -- Sentinel of Rkugamz

            [80951] = true, -- Shadowrend
            [80955] = true, -- Forward Charge
            [80954] = true, -- Shadowrend Summon
            [80980] = true, -- Shadowrend
            [80990] = true, -- Minor Maim
            [80989] = true, -- Shadowrend
            [81034] = true, -- Minor Maim

            [80481] = true, -- Minor Berserk (Slimecraw)

            [59489] = true, -- Spawn of Mephala
            [59497] = true, -- Spawn of Mephala
            [59498] = true, -- Mephala's Web
            [59499] = true, -- Mephala's Web

            [80520] = true, -- Stormfist
            [80523] = true, -- Stormfist
            [80522] = true, -- Stormfist
            [80521] = true, -- Stormfist

            [80592] = true, -- Swarm Mother
            [84419] = true, -- Swarm Mother Mask
            [80594] = true, -- Ability CC Immunity
            [80595] = true, -- CC Immunity
            [80593] = true, -- Swarm Mother Mask

            [59521] = true, -- Engine Guardian
            [60484] = true, -- Sphere Groundrise
            [59522] = true, -- Engine Guardian
            [59539] = true, -- Engine Guardian
            [59540] = true, -- Engine Guardian Stamina
            [59525] = true, -- Engine Guardian
            [59533] = true, -- Engine Guardian Magicka
            [59541] = true, -- Engine Guardian
            [59543] = true, -- Engine Guardian Health

            [80503] = true, -- The Troll King
            [80504] = true, -- The Troll King

            [102089] = true, -- Thurvokun
            [102094] = true, -- Thurvokun
            [102097] = true, -- Thurvokun
            [102100] = true, -- Thurvokun
            [102093] = true, -- Thurvokun
            [102095] = true, -- Thurvokun

            [80513] = true, -- Tremorscale
            [80517] = true, -- Tremorscale
            [80865] = true, -- Tremorscale
            [80866] = true, -- Tremorscale

            [59595] = true, -- Valkyn Skoria
            [66612] = true, -- CoA Trigger Cooldown
            [59596] = true, -- Valkyn Skoria
            [61273] = true, -- Valkyn Skoria

            [80483] = true, -- Velidreth
            [80487] = true, -- Hoarvor Mask
            [80488] = true, -- Hoarvor Mask
            [80856] = true, -- Hoarvor Mask
            [80864] = true, -- Hoarvor Mask
            [80489] = true, -- Hoarvor Mask
            [80490] = true, -- Velidreth

            [102125] = true, -- Zaan
            [102136] = true, -- Zaan
            [102142] = true, -- Zaan

            -- Crafted Sets
            [29124] = true, -- Ashen Grip
            [34502] = true, -- Ashen Grip

            [32799] = true, -- Alessia's Bulwark
            [34592] = true, -- Alessia's Bulwark

            [92768] = true, -- Assassin's Guile (Assassin's)

            [75745] = true, -- Clever Alchemist
            [75746] = true, -- Clever Alchemist

            [92769] = true, -- of Daedric Trickery (of Daedric Trickery)

            [92774] = true, -- Major Mending (of Daedric Trickery)
            [92771] = true, -- Major Expedition (of Daedric Trickery)
            [92775] = true, -- Major Heroism (of Daedric Trickery)
            [92776] = true, -- Major Vitality (of Daedric Trickery)
            [92773] = true, -- Major Protection (of Daedric Trickery)

            [29097] = true, -- Death's Wind
            [33764] = true, -- Death's Wind
            [52289] = true, -- Death's Wind

            [75927] = true, -- Eternal Hunt
            [75930] = true, -- Daedric Mines
            [75929] = true, -- Eternal Hunt
            [76533] = true, -- Eternal Hunt

            [79008] = true, -- Gladiator

            [32781] = true, -- Hist Bark
            [86555] = true, -- Hist Bark

            [99199] = true, -- Innate Axiom

            [32810] = true, -- Kagrenac's Hope
            [57207] = true, -- Kagrenac's Hope

            [29102] = true, -- Magnus' Gift (Magnus)
            [34381] = true, -- Magnus' Gift (Magnus)

            [99202] = true, -- Mechanical Acuity (of Mechanical Acuity)
            [99204] = true, -- Mechanical Acuity (of Mechanical Acuity)

            [71670] = true, -- Morkuldin (Morkuldin)
            [71671] = true, -- Morkuldin (Morkuldin)
            [71678] = true, -- Light Attack (Morkuldin)
            [71679] = true, -- Cleave (Morkuldin)


            [79103] = true, -- Pelinal's

            [32801] = true, -- Orgnum's

            [61783] = true, -- Redistributor (Redistribution)
            [61784] = true, -- Redistributor (Redistribution)

            [32816] = true, -- Shalidor's Curse
            [49126] = true, -- Shalidor's Curse

            [75724] = true, -- Tava's Favor
            [75726] = true, -- Tava's Favor

            [61851] = true, -- Armor Master (the Armor Master)
            [61870] = true, -- Armor Master (the Armor Master)
            [70352] = true, -- Armor Master (the Armor Master)

            [52712] = true, -- Way of the Arena (the Arena)

            [32804] = true, -- Eyes of Mara (the Eyes of Mara)

            [29113] = true, -- Night Mother's Gaze (the Night Mother's Gaze)
            [34386] = true, -- Night Mother's Gaze (the Night Mother's Gaze)

            [29108] = true, -- Night's Silence (the Night's Silence)

            [61780] = true, -- Noble's Conquest (Nobles Conquest)
            [61781] = true, -- Noble's Conquest (Nobles Conquest)
            [61782] = true, -- Minor Vulnerability

            [29119] = true, -- Armor of the Seducer (the Seducer)

            [32784] = true, -- Song of Lamae (the Song of Lamae)
            [34587] = true, -- Song of Lamae (the Song of Lamae)
            [34588] = true, -- Song of Lamae (the Song of Lamae)

            [60457] = true, -- Twice-Born Star (the Twice-Born Star)
            [61584] = true, -- Prep To Remove Mundus (the Twice-Born Star)

            [32782] = true, -- Willow's Path (the Willow's Path)

            [32759] = true, -- Torug's Pact (Torug's Pact)

            [71018] = true, -- Trial by Fire (Trials)
            [71055] = true, -- Trial by Fire Cooldown (Trials)
            [71067] = true, -- Trial by Shock (Trials)
            [71058] = true, -- Trial by Fire (Trials)
            [71019] = true, -- Trial by Frost (Trials)
            [71072] = true, -- Trial by Poison (Trials)
            [71069] = true, -- Trial by Disease (Trials)

            [29098] = true, -- Twilight's Embrace

            [79029] = true, -- Varen's Legacy
            [79089] = true, -- Varen's Wall
            [79093] = true, -- Remove Trigger

            [29120] = true, -- Vampire's Kiss
            [57170] = true, -- Vampire's Kiss

            [29109] = true, -- Whitestrake's Retribution (Whitestrake's)
            [49236] = true, -- Whitestrake's Retribution (Whitestrake's)

            -- Overland Sets (All Types)
            [85541] = true, -- Armor of the Trainee (of the Trainee)

            -- Overland Sets (Light)
            [77888] = true, -- Bahraha's Curse (of Bahraha's Curse)
            [75673] = true, -- Bahraha's Curse (of Bahraha's Curse)
            [75981] = true, -- Bahraha's Curse (of Bahraha's Curse)
            [75691] = true, -- Bahraha's Curse (of Bahraha's Curse)
            [75707] = true, -- Bahraha's Curse (of Bahraha's Curse)
            [75692] = true, -- Bahraha's Curse (of Bahraha's Curse)
            [75706] = true, -- Bahraha's Curse (of Bahraha's Curse)

            [32742] = true, -- Bloodthorn's Touch (Bloodthorn)
            [34522] = true, -- Bloodthorn's Touch (Bloodthorn)
            [57177] = true, -- Bloodthorn's Touch (Bloodthorn)

            [29092] = true, -- Dreamer's Mantle (Dreamer's)
            [31213] = true, -- Dreamer's Mantle (Dreamer's)
            [48913] = true, -- Dreamer's Mantle (Dreamer's)
            [57133] = true, -- Dreamer's Mantle (Dreamer's)

            [32803] = true, -- Queen's Elegance (Elegant)

            [32743] = true, -- Robes of the Hist (of Hist Sap)
            [85776] = true, -- Robes of the Hist (of Hist Sap)

            [52704] = true, -- Way of Martial Knowledge (of Martial Knowledge)
            [52705] = true, -- Way of Martial Knowledge (of Martial Knowledge)

            [32820] = true, -- Necropotence (of Necropotence)

            [29094] = true, -- Prisoner's Rags (Prisoner's)
            [85825] = true, -- Prisoner's Rags (Prisoner's)

            [79192] = true, -- Sithis' Touch (Sithis)
            [79200] = true, -- Major Berserk (Sithis)

            [85591] = true, -- Skooma Smuggler (Smuggler's)
            [85592] = true, -- Major Expedition (Smuggler's)

            [32725] = true, -- Stendarr's Embrace (of Stendarr)
            [85812] = true, -- Stendarr's Embrace (of Stendarr)

            [32728] = true, -- Syrabane's Grip (of Syrabane)
            [34506] = true, -- Syrabane's Grip (of Syrabane)

            [32741] = true, -- Shadow Dancer's Raiment (of the Shadow Dancer)

            [29095] = true, -- Silks of the Sun (of the Sun)

            [29101] = true, -- Robes of the Withered Hand (of the Withered Hand)
            [57172] = true, -- Robes of the Withered Hand (of the Withered Hand)
            [57173] = true, -- Robes of the Withered Hand (of the Withered Hand)
            [57175] = true, -- Robes of the Withered Hand (of the Withered Hand)

            [71656] = true, -- Trinimac's Valor (of Trinimac's Valor)
            [71664] = true, -- Trinimac's Valor (of Trinimac's Valor)
            [71657] = true, -- Trinimac's Valor (of Trinimac's Valor)
            [71658] = true, -- Trinimac's Valor (of Trinimac's Valor)

            [85567] = true, -- Vampire Lord (Vampire Lord's)

            [92761] = true, -- War Maiden (War Maiden's)

            [85596] = true, -- Ysgramor's Birthright (Ysgramor's)

            [92981] = true, -- Mad Tinkerer (Mad Tinkerer's)
            [93026] = true, -- Mad Tinkerer (Mad Tinkerer's)
            [92982] = true, -- Mad Tinkerer (Mad Tinkerer's)
            [92986] = true, -- Mad Tinkerer (Mad Tinkerer's)
            [93001] = true, -- Mad Tinkerer (Mad Tinkerer's)
            [93002] = true, -- Mad Tinkerer (Mad Tinkerer's)
            [93003] = true, -- Mad Tinkerer (Mad Tinkerer's)
            [92998] = true, -- Mad Tinkerer (Mad Tinkerer's)


            -- Overland Sets (Medium)

            [71102] = true, -- Briarheart
            [71106] = true, -- Briarheart
            [71107] = true, -- Briarheart

            [32734] = true, -- Darkstride (Darkstride)

            [93300] = true, -- Defiler (Defiler's)
            [93308] = true, -- Defiler (Defiler's)
            [93304] = true, -- Defiler (Defiler's)
            [93307] = true, -- Defiler (Defiler's)
            [93305] = true, -- Defiler (Defiler's)
            [93326] = true, -- Defiler (Defiler's)
            [100704] = true, -- Defiler (Defiler's)

            [29104] = true, -- Fiord's Legacy (Fiord's)

            [79181] = true, -- Flanking Strategist (of Flanking)

            [19165] = true, -- Night Terror (of Night Terror)
            [32836] = true, -- Night Terror (of Night Terror)
            [34875] = true, -- Night Terror (of Night Terror)

            [32822] = true, -- Salvation (of Salvation)

            [32808] = true, -- Senche's Bite (Senche's)
            [34611] = true, -- Senche's Bite (Senche's)

            [32750] = true, -- Stygian (Stygian)

            [67099] = true, -- Swamp Raider
            [67101] = true, -- Swamp Raider

            [85557] = true, -- Sword-Singer (Sword-Singer's)

            [76573] = true, -- Syvarra's Scales (of Syvarra's Scales)
            [75717] = true, -- Syvarra's Scales (of Syvarra's Scales)
            [76344] = true, -- Serpent's Spirit (of Syvarra's Scales)
            [75718] = true, -- Serpent's Spirit (of Syvarra's Scales)

            [51504] = true, -- Yokudan Air Stealth Detection (of the Air)
            [52708] = true, -- Way of Air (of the Air)
            [52709] = true, -- Way of Air (of the Air)

            [29107] = true, -- Night Mother's Embrace (of the Night Mother)

            [32751] = true, -- Ranger's Gait (of the Ranger)

            [29111] = true, -- Shadow of the Red Mountain (of the Red Mountain)
            [97806] = true, -- Shadow of the Red Mountain (of the Red Mountain)
            [34383] = true, -- Shadow of the Red Mountain (of the Red Mountain)

            [32828] = true, -- Twin Sisters (of the Twin Sisters)
            [34817] = true, -- Twin Sisters Bleed (of the Twin Sisters)

            [32829] = true, -- Wilderqueen's Arch (of the Wilderqueen)
            [34870] = true, -- Wilderqueen's Arch (of the Wilderqueen)

            [99266] = true, -- Unfathomable Darkness (of Unfathomable Darkness)
            [99267] = true, -- Unfathomable Darkness (of Unfathomable Darkness)
            [99268] = true, -- Unfathomable Darkness (of Unfathomable Darkness)

            [32729] = true, -- Hide of the Werewolf (Werewolf Hide)
            [34508] = true, -- Hide of the Werewolf (Werewolf Hide)

            [18991] = true, -- Witchman Armor (Witchman's)
            [18993] = true, -- Witchman Armor (Witchman's)
            [85818] = true, -- Witchman Armor (Witchman's)

            -- Overland Sets (Heavy)

            [32815] = true, -- Meridia's Blessed Armor (Blessed)
            [34711] = true, -- Meridia's Blessed Armor (Blessed)

            [57295] = true, -- Draugr's Heritage (of Draugr Heritage)
            [57298] = true, -- Draugr's Heritage (of Draugr Heritage)
            [57296] = true, -- Draugr's Heritage (of Draugr Heritage)
            [57297] = true, -- Draugr's Heritage (of Draugr Heritage)

            [99281] = true, -- Livewire
            [99282] = true, -- Livewire
            [99285] = true, -- Livewire
            [99286] = true, -- Livewire
            [99461] = true, -- Livewire

            [79110] = true, -- Hide of Morihaus (of Morihaus)
            [79315] = true, -- Hide of Horihaus (of Morihaus)
            [79506] = true, -- Hide of Morihaus (of Morihaus)
            [79123] = true, -- Hide of Morihaus (of Morihaus)
            [79507] = true, -- Tracker (of Morihaus)
            [79112] = true, -- Hide of Morihaus (of Morihaus)

            [32752] = true, -- Seventh Legion Brute (Seventh Legion's)
            [34526] = true, -- Seventh Legion Brute (Seventh Legion's)
            [57186] = true, -- Seventh Legion Brute (Seventh Legion's)

            [85593] = true, -- Minor Heroism (Shalk's)
            [85594] = true, -- Minor Heroism (Shalk's)

            [32838] = true, -- Soulshine (of Soulshine)

            [18996] = true, -- Akaviri Dragonguard (of the Dragon)

            [52710] = true, -- Way of Fire (of the Fire)
            [52711] = true, -- Fiery Weapon (of the Fire)

            [85570] = true, -- Green Pact (of the Green Pact)

            [32736] = true, -- Hatchling's Shell (of the Hatchling's Shell)
            [85797] = true, -- Hatchling's Shell (of the Hatchling's Shell)

            [85565] = true, -- Minor Vitality (of the Order of Diagna)

            [71077] = true, -- Mark of the Pariah (of the Pariah)

            [32814] = true, -- Storm Knight's Plate (of the Storm Knight)
            [57210] = true, -- Storm Knight's Plate (of the Storm Knight)
            [57209] = true, -- Storm Knight's Plate (of the Storm Knight)

            [85551] = true, -- Minor Protection (of the Vampire's Cloak)

            [29118] = true, -- Armor of the Veiled Heritance (of the Veiled Heritance)
            [33514] = true, -- Armor of the Veiled Heritance (of the Veiled Heritance)

            [32830] = true, -- Wyrd Tree's Blessing (of the Wyrd Tree)

            [29116] = true, -- Thunderbug's Carapace (Thunderbug's)
            [33497] = true, -- Thunderbug's Carapace (Thunderbug's)

            [92762] = true, -- Minor Toughness (Warrior-Poet's)

            -- Dungeon Sets (Light)

            [60418] = true, -- Burning Spellweave
            [61459] = true, -- Burning Spellweave
            [60419] = true, -- Burning Spellweave

            [102026] = true, -- Caluurion's Legacy
            [102060] = true, -- Caluurion's Legacy
            [102027] = true, -- Caluurion's Legacy (Fire)
            [102032] = true, -- Caluurion's Legacy (Ice)
            [102033] = true, -- Caluurion's Legacy (Disease)
            [102034] = true, -- Caluurion's Legacy (Shock)

            [97532] = true, -- Draugr's Rest
            [97538] = true, -- Draugr's Rest
            [97539] = true, -- Draugr's Rest

            [97572] = true, -- Flame Blossom
            [99144] = true, -- Flame Blossom
            [97573] = true, -- Flame Blossom
            [97574] = true, -- Flame Blossom

            [84340] = true, -- Gossamer (Gossamer)
            [84341] = true, -- Major Evasion (Gossamer)

            [101978] = true, -- Jorvuld's Guidance

            [85609] = true, -- Lamia's Song (Lamia's)
            [85610] = true, -- Lamia's Song (Lamia's)
            [85636] = true, -- Lamia's Song (Lamia's)

            [85604] = true, -- Light Speaker (Light Speaker's)

            [67093] = true, -- Overwhelming Surge (Overwhelming)
            [67129] = true, -- Overwhelming Surge (Overwhelming)
            [67136] = true, -- Overwhelming Surge (Overwhelming)

            [29099] = true, -- Prayer Shawl (of Prayer)
            [34504] = true, -- Prayer Shawl (of Prayer)

            [88764] = true, -- Sanctuary (of Sanctuary)
            [32834] = true, -- Sanctuary (of Sanctuary)

            [85603] = true, -- Spider Cultist Cowl (Spider Cultist's)

            [66899] = true, -- Spell Power Cure (Spell Power Cure)
            [69402] = true, -- WGT Heal Set (Spell Power Cure)
            [66902] = true, -- Spell Power Cure (Spell Power Cure)

            [67096] = true, -- Combat Physician (of the Combat Physician)
            [67098] = true, -- Combat Physician (of the Combat Physician)
            [69291] = true, -- ICP Light Heal Set (of the Combat Physician)

            [18987] = true, -- Shroud of the Lich (of the Lich)
            [57164] = true, -- Shroud of the Lich (of the Lich)

            [32826] = true, -- Magicka Furnace (of the Magicka Furnace)
            [34813] = true, -- Magicka Furnace (of the Magicka Furnace)

            [29100] = true, -- Noble Duelist's Silks (of the Noble Duelist)
            [34373] = true, -- Noble Duelist's Silks (of the Noble Duelist)

            [85606] = true, -- Netch's Touch (of the Netch's Touch)

            [67287] = true, -- Scathing Mage (of the Scathing Mage)
            [67288] = true, -- Scathing Mage (of the Scathing Mage)

            [59675] = true, -- Undaunted Unweaver (of the Undaunted Unweaver)
            [59676] = true, -- Undaunted Unweaver (of the Undaunted Unweaver)

            [57162] = true, -- Robes of the Warlock (of the Warlock)
            [57163] = true, -- Robes of the Warlock (of the Warlock)

            [88763] = true, -- Worm's Raiment (of the Worm Cult)
            [47367] = true, -- Worm's Raiment (of the Worm Cult)

            [85613] = true, -- Major Prophecy (Treasure Hunter's)

            -- Dungeon Sets (Medium)

            [85607] = true, -- Strength of the Automaton (Automaton's)

            [29105] = true, -- Barkskin
            [85977] = true, -- Barkskin
            [85978] = true, -- Barkskin

            [97567] = true, -- Blooddrinker

            [85617] = true, -- Bone Pirate's Tatters (Bone Pirate's)

            [84305] = true, -- Heem-Jas' Retribution (Heem-Jas')
            [84308] = true, -- Heem-Jas' Retribution (Heem-Jas')
            [84310] = true, -- Heem-Jas' Retribution (Heem-Jas')

            [88760] = true, -- Hircine's Veneer (Hircine's)
            [47365] = true, -- Hircine's Veneer (Hircine's)

            [32809] = true, -- Oblivion's Edge
            [34612] = true, -- Oblivion's Edge
            [57206] = true, -- Oblivion's Edge

            [97712] = true, -- Pillar of Nirn
            [97714] = true, -- Pillar of Nirn
            [97716] = true, -- Pillar of Nirn
            [97743] = true, -- Pillar of Nirn

            [102104] = true, -- Plague Slinger
            [102106] = true, -- Skeever Corpse
            [102113] = true, -- Plague Slinger

            [67140] = true, -- Sheer Venom (of Sheer Venom)
            [67926] = true, -- Sheer Venom (of Sheer Venom)
            [67927] = true, -- Sheer Venom (of Sheer Venom)
            [67141] = true, -- Sheer Venom (of Sheer Venom)

            [85624] = true, -- Spelunker (Spelunker's)
            [85626] = true, -- Spelunker (Spelunker's)
            [85635] = true, -- Spelunker (Spelunker's)

            [66939] = true, -- Storm Master (Storm Master's)
            [70297] = true, -- Storm Master (Storm Master's)
            [70298] = true, -- Storm Master (Storm Master's)

            [85622] = true, -- Sword Dancer (Sword Dancer's)

            [60059] = true, -- Sunderflame
            [60060] = true, -- Sunderflame
            [60416] = true, -- Sunderflame

            [32780] = true, -- Crusader (of the Crusader)
            [49220] = true, -- Extra dodge (of the Crusader)

            [85605] = true, -- Major Savagery (Toothrow)

            [67296] = true, -- Essence Thief (of the Essence Thief)
            [67324] = true, -- WGT Medium Set 1 (of the Essence Thief)
            [67298] = true, -- Essence Thief (of the Essence Thief)
            [67308] = true, -- Essence Thief (of the Essence Thief)
            [67326] = true, -- Essence Thief (of the Essence Thief)
            [67330] = true, -- Essence Thief (of the Essence Thief)
            [67334] = true, -- Essence Thief (of the Essence Thief)
            [70284] = true, -- Essence Thief (of the Essence Thief)
            [70290] = true, -- Essence Thief (of the Essence Thief)

            [59666] = true, -- Undaunted Infiltrator (of the Undaunted Infiltrator)
            [59667] = true, -- Undaunted Infiltrator (of the Undaunted Infiltrator)

            [29106] = true, -- Viper's Sting (of the Viper)
            [33691] = true, -- Viper's Sting (of the Viper)

            [101969] = true, -- Trappings of Invigoration
            [101970] = true, -- Trappings of Invigoration

            [84349] = true, -- Widowmaker
            [97851] = true, -- Widowmaker
            [84350] = true, -- Widowmaker

            -- Dungeon Sets (Heavy)

            [102008] = true, -- Curse of Doylemish
            [102023] = true, -- Curse of Doylemish

            [32825] = true, -- Duneripper's Scales (Duneripper)

            [32754] = true, -- Durok's Bane (of Durok's Bane)
            [34527] = true, -- Durok's Bane Major Defile (of Durok's Bane)

            [82890] = true, -- Ebon Armory (Ebon)
            [47362] = true, -- Ebon Armory (Ebon)

            [59694] = true, -- Embershield
            [59695] = true, -- Embershield
            [59696] = true, -- Embershield

            [97907] = true, -- Hagraven's Garden (Hagraven's)
            [97908] = true, -- Hagraven's Garden (Hagraven's)
            [97909] = true, -- Hagraven's Garden (Hagraven's)
            [97910] = true, -- Hagraven's Garden (Hagraven's)
            [97918] = true, -- Hagraven's Garden (Hagraven's)

            [29123] = true, -- The Ice Furnace (Ice Furnace)
            [34404] = true, -- Frostfire (Ice Furnace)

            [97616] = true, -- Ironblood (Ironblood)
            [97626] = true, -- Ironblood (Ironblood)
            [97627] = true, -- Major Protection (Ironblood)

            [67077] = true, -- Jolting Arms (Jolting)
            [67079] = true, -- WGT Heavy Set 2 (Jolting)
            [67078] = true, -- Jolting Arms (Jolting)
            [67080] = true, -- Shocking Bash (Jolting)

            [85619] = true, -- Knight-Errant's Mail (Knight-Errant's)
            [85620] = true, -- Knight-Errant's Mail (Knight-Errant's)

            [67202] = true, -- Leeching Plate (of Leeching)
            [69346] = true, -- Leeching Plate (of Leeching)
            [67205] = true, -- Leeching Plate (of Leeching)
            [69345] = true, -- Leeching Plate (of Leeching)
            [67204] = true, -- Leeching Plate (of Leeching)

            [84275] = true, -- Aspect of Mazzatun (of Mazzatun)
            [84277] = true, -- Aspect of Mazzatun (of Mazzatun)
            [84278] = true, -- Aspect of Mazzatun (of Mazzatun)
            [84279] = true, -- Aspect of Mazzatun (of Mazzatun)

            [85611] = true, -- Minor Force (of Medusa)

            [84353] = true, -- Hand of Mephala (of Mephala's Hand)
            [84354] = true, -- Hand of Mephala (of Mephala's Hand)
            [84357] = true, -- Hand of Mephala Webbing (of Mephala's Hand)
            [84355] = true, -- Hand of Mephala (of Mephala's Hand)
            [84358] = true, -- Minor Fracture (of Mephala's Hand)

            [32755] = true, -- Nikulas' Heavy Armor (of Nikulas)

            [85623] = true, -- Major Sorcery (Rattlecage)

            [32735] = true, -- Major Brutality (of the Dreugh King Slayer)
            [34511] = true, -- Major Expedition (of the Dreugh King Slayer)

            [66882] = true, -- Brands of the Imperium (of the Imperium)
            [66887] = true, -- Brands of the Imperium (of the Imperium)

            [29117] = true, -- Knightmare (of the Knightmare)
            [33512] = true, -- Minor Maim (of the Knightmare)

            [29115] = true, -- Sargeant's Mail (of the Sargeant)

            [67280] = true, -- Tormentor (of the Tormentor)
            [67281] = true, -- ICP Heavy Set 2 Hit W Taunt (of the Tormentor)
            [67283] = true, -- Tormentor Resistance (of the Tormentor)

            [59663] = true, -- Undaunted Bastion (of the Undaunted Bastion)
            [61200] = true, -- Undaunted Bastion (of the Undaunted Bastion)

            [32818] = true, -- Armor of Truth (of Truth)
            [86070] = true, -- Armor of Truth (of Truth)

            [101974] = true, -- Ulfnor's Favor

            -- Trial Sets (Hel Ra Citadel)

            [50971] = true, -- Berserking Warrior (Advancing Yokeda)
            [50978] = true, -- Berserking Warrior (Advancing Yokeda)

            [51300] = true, -- Immortal Warrior (Immortal Yokeda)
            [90937] = true, -- Immortal Warrior (Immortal Yokeda)
            [51302] = true, -- Immortal Warrior (Immortal Yokeda)
            [51401] = true, -- Immortal Warrior (Immortal Yokeda)
            [90938] = true, -- Immortal Warrior (Immortal Yokeda)

            [50990] = true, -- Defending Warrior (Resilient Yokeda)
            [86907] = true, -- Defending Warrior (Resilient Yokeda)
            [50992] = true, -- Defending Warrior (Resilient Yokeda)

            [61436] = true, -- Eternal Warrior (Eternal Yokeda)
            [76618] = true, -- Minor Aegis (Eternal Yokeda)
            [90940] = true, -- Eternal Warrior (Eternal Yokeda)
            [81527] = true, -- Eternal Warrior (Eternal Yokeda)
            [61437] = true, -- Eternal Warrior (Eternal Yokeda)
            [81529] = true, -- Eternal Warrior (Eternal Yokeda)
            [90939] = true, -- Eternal Warrior (Eternal Yokeda)

            -- Trial Sets (Aetherian Archive)

            [51314] = true, -- Destructive Mage (Aether ... of Destruction)
            [51315] = true, -- Destructive Mage (Aether ... of Destruction)
            [51320] = true, -- Mage Destruction Bomb (Aether ... of Destruction)

            [51442] = true, -- Healing Mage (of Mending)
            [51443] = true, -- Healing Bane (of Mending)

            [51432] = true, -- Wise Mage (Aether ... of Strategy)
            [51434] = true, -- Minor Vulnerability (Aether ... of Strategy)

            [76617] = true, -- Minor Slayer (of the Infallible Aether)
            [61438] = true, -- Infallible Mage (of the Infallible Aether)
            [81519] = true, -- Minor Vulnerability (of the Infallible Aether)

            -- Trial Sets (Sanctum Ophidia)

            [51132] = true, -- Poisonous Serpent (Ophidian ... of Venom)
            [51241] = true, -- Poisonous Serpent (Ophidian ... of Venom)

            [51170] = true, -- Twice-Fanged Serpent (of the Two-Fanged Snake)
            [51176] = true, -- Twice-Fanged Serpent (of the Two-Fanged Snake)

            [50995] = true, -- Quick Serpent (Ophidian... of Celerity)
            [50997] = true, -- Major Expedition (Ophidian... of Celerity)

            [61440] = true, -- Vicious Serpent (of the Vicious Ophidian)
            [98103] = true, -- Minor Slayer (of the Vicious Ophidian)
            [81524] = true, -- Quick Serpent (of the Vicious Ophidian)
            [81522] = true, -- Serpent Stamina (of the Vicious Ophidian)

            -- Trial Sets (Maw of Lorkhaj)

            [75797] = true, -- Moondancer (Moondancer)
            [75801] = true, -- Lunar Blessing (Moondancer)
            [75804] = true, -- Shadow Blessing (Moondancer)

            [75751] = true, -- Roar of Alkosh (of Alkosh)
            [98102] = true, -- Minor Slayer (of Alkosh)
            [78835] = true, -- Roar of Alkosh Miss (of Alkosh)
            [75752] = true, -- Roar of Alkosh (of Alkosh)
            [75753] = true, -- Line Breaker (of Alkosh)
            [76667] = true, -- Roar of Alkosh (of Alkosh)

            [75813] = true, -- Lunar Bastion (of the Lunar Bastion)
            [75815] = true, -- Lunar Bastion (of the Lunar Bastion)

            [75766] = true, -- Twilight Remedy (of Twilight Remedy)
            [75768] = true, -- Primal Heal (of Twilight Remedy)
            [75770] = true, -- Twilight Remedy (of Twilight Remedy)
            [76564] = true, -- Minor Force (of Twilight Remedy)

            -- Trial Sets (Halls of Fabrication)

            [93443] = true, -- Automated Defense (Automated Defense)
            [93444] = true, -- Major Aegis (Automated Defense)

            [93124] = true, -- Inventor's Guard (Inventor's Guard)
            [93125] = true, -- Major Aegis (Inventor's Guard)

            [93119] = true, -- Master Architect (Master Architect)
            [93120] = true, -- Major Slayer (Master Architect)

            [93441] = true, -- War Machine (War Machine)
            [93442] = true, -- Major Slayer (War Machine)

            -- Battleground Sets
            [92908] = true, -- Major Expedition (Coward's Gear)
            [92909] = true, -- Major Protection (Coward's Gear)

            [93099] = true, -- Knight Slayer
            [93104] = true, -- Knight Slayer

            [92914] = true, -- Vanguard's Challenge
            [92916] = true, -- Vanguard's Challenge

            [92920] = true, -- Wizard's Riposte (Wizard's Riposte)
            [92921] = true, -- Minor Maim (Wizard's Riposte)

            -- Imperial City Sets
            [61761] = true, -- Black Rose (of the Black Rose)
            [61762] = true, -- Black Rose (of the Black Rose)

            [79419] = true, -- Galerion's Revenge (Galerion's)
            [79421] = true, -- Mark of Revenge (Galerion's)
            [79770] = true, -- U10 AVA MA/LA 1 (Galerion's)
            [79771] = true, -- U10 AVA MA/LA 1 (Galerion's)
            [79420] = true, -- Galerion's Revenge (Galerion's)

            [79405] = true, -- Imperial Physique (Imperial Physique)
            [79411] = true, -- 4x Bonus (Imperial Physique)

            [61775] = true, -- Supporting Soldier Trigger (of Meritorious Service)
            [65706] = true, -- Meritorious Service (of Meritorious Service)
            [65707] = true, -- Meritorious Service (of Meritorious Service)

            [68933] = true, -- Phoenix (of the Phoenix)
            [90935] = true, -- Phoenix (of the Phoenix)
            [68935] = true, -- Phoenix (of the Phoenix)
            [70406] = true, -- Phoenix (of the Phoenix)
            [68938] = true, -- Phoenix (of the Phoenix)
            [90936] = true, -- Phoenix (of the Phoenix)
            [68940] = true, -- Phoenix (of the Phoenix)
            [70405] = true, -- Phoenix (of the Phoenix)

            [61763] = true, -- Powerful Assault Trigger (of the Powerful Assault)
            [61771] = true, -- Powerful Assault (of the Powerful Assault)
            [61774] = true, -- Powerful Assault (of the Powerful Assault)

            [68947] = true, -- Reactive Armor (Reactive)
            [68948] = true, -- Reactive Armor (Reactive)
            [69567] = true, -- Reactive Armor Effects (Reactive)

            [68973] = true, -- Shield Breaker (of the Shield Breaker)
            [68974] = true, -- Shield Breaker (of the Shield Breaker)

            [79362] = true, -- Thews of the Harbinger (of the Harbinger)
            [79363] = true, -- Thews of the Harbinger (of the Harbinger)

            [79464] = true, -- Vicecanon of Venom
            [79469] = true, -- Deadly Venom
            [79470] = true, -- Vicecanon of Venom Heal
            [79471] = true, -- Venom Heal

            -- Cyrodiil Sets (Light)

            [32802] = true, -- Almalexia's Mercy (of Almalexia's Mercy)
            [34605] = true, -- Almalexia's Mercy (of Almalexia's Mercy)

            [32779] = true, -- Robes of Alteration Mastery (of Alteration Mastery)

            [47355] = true, -- Grace of the Ancients (of Ancient Grace)

            [32819] = true, -- The Arch-Mage (of the Arch-Mage)
            [70392] = true, -- The Arch-Mage (of the Arch-Mage)

            [32827] = true, -- Curse Eater (Curse-Eating)

            [32833] = true, -- Light of Cyrodiil (of Cyrodiil's Light)

            [29093] = true, -- Desert Rose (of the Desert Rose)
            [33498] = true, -- Desert Rose (of the Desert Rose)

            [47351] = true, -- Buffer of the Swift (of the Swift)
            [47352] = true, -- Buffer of the Swift (of the Swift)

            -- Cyrodiil Sets (Medium)

            [32835] = true, -- Ward of Cyrodiil (of Cyrodiil's Ward)
            [49119] = true, -- Ward of Cyrodiil (Block) (of Cyrodiil's Ward)

            [47361] = true, -- Eagle Eye (Eagle-Eyed)

            [32823] = true, -- Hawk's Eye (of Hawk's Eye)

            [32731] = true, -- Kyne's Kiss (of Kyne's Kiss)
            [34509] = true, -- Kyne's Kiss (of Kyne's Kiss)
            [70492] = true, -- Kyne's Kiss (of Kyne's Kiss)

            [29112] = true, -- The Morag Tong (of the Morag Tong)
            [34384] = true, -- The Morag Tong (of the Morag Tong)

            [32807] = true, -- Sentry (of the Sentry)

            [32747] = true, -- Shadow Walker (of the Shadow Walker)
            [57180] = true, -- Shadow Walker (of the Shadow Walker)
            [57181] = true, -- Shadow Walker (of the Shadow Walker)

            [47353] = true, -- Shield of the Valiant (of the Valiant)

            [47357] = true, -- Vengeance Leech (of Vengeance Leech)
            [47358] = true, -- Vengeance Leech (of Vengeance Leech)
            [47359] = true, -- Vengeance Leech (of Vengeance Leech)
            [47360] = true, -- Vengeance Leech (of Vengeance Leech)

            -- Cyrodiil Sets (Heavy)

            [32824] = true, -- Affliction (Afflicted)
            [34787] = true, -- Affliction (Afflicted)

            [29122] = true, -- Beckoning Steel (of Beckoning Steel)
            [49237] = true, -- Beckoning Steel (of Beckoning Steel)

            [32837] = true, -- Crest of Cyrodiil (of Cyrodiil's Crest)
            [34876] = true, -- Major Defile (of Cyrodiil's Crest)

            [32800] = true, -- Elf Bane (of Elf Bane)

            [32831] = true, -- Ravager (Ravaging)
            [34872] = true, -- The Ravager (Ravaging)

            [29121] = true, -- Armor of the Alessian Order (of the Alessian Order)

            [47348] = true, -- Bastion of the Heartland (of the Heartland)
            [47350] = true, -- Bastion of the Heartland (of the Heartland)

            [32737] = true, -- The Juggernaut (of the Juggernaut)
            [34512] = true, -- The Juggernaut (of the Juggernaut)

            [47356] = true, -- Blessing of the Potentates (of the Potentates)

            -- Rewards for the Worthy Sets

            [76946] = true, -- Fasalla's Guile (of Fasalla's Guile)
            [76947] = true, -- Fasalla's Guile (of Fasalla's Guile)

            [76949] = true, -- Warrior's Fury (of Fury)
            [76950] = true, -- Warrior's Fury (of Fury)
            [76951] = true, -- 10 Stack Count FX Dummy (of Fury)

            [76940] = true, -- Leki's Focus (Leki's)

            [76932] = true, -- Marksman's Crest (Markman's)

            [76934] = true, -- Robes of Transmutation (Transmutation)
            [76936] = true, -- Robes of Transmutation (Transmutation)

            [76937] = true, -- Vicious Death (of Vicious Death)
            [82987] = true, -- Vicious Death (of Vicious Death)
            --[76938] = true, -- Vicious Death (of Vicious Death)

            -- DISGUISES

            [46281] = true, -- Necromancer Disguise (Bloodthorn Disguse)
            [31766] = true, -- Disguised (Colovian Uniform)
            [48429] = true, -- Gold Coast Courier Uniform (Courier Uniform)
            [33221] = true, -- Crown Disguise (Crown Dishdasha)
            [20175] = true, -- Dunmer Cultural Garb (Dunmer Cultural Garb)
            [33220] = true, -- Forebear Disguise (Forebear Dishdasha)
            [47574] = true, -- Fort Amol Guard Disguise (Fort Amol Guard Disguise)
            [38167] = true, -- Bleakrock Bandit Disguise (Frostedge Bandit Disguise)
            [39295] = true, -- Hallin's Stand Seventh Legion (Hallin's Stand Seventh Legion Disguise)
            [34267] = true, -- Imperial Disguise (Imperial Disguise)
            [31268] = true, -- Q4606 Disguise Watcher (Keeper's Gard)
            [31118] = true, -- Keeper's Garb (Keeper's Garb)
            [30879] = true, -- Shimmering Glow (Kollopi Essence)
            [35607] = true, -- Midnight Union Disguise (Midnight Union Disguise)
            [38878] = true, -- Northwind Disguise (Northwind Disguise)
            [43716] = true, -- Phaer Mercenary Disguise (Phaer Mercenary Disguise)
            [29986] = true, -- Disguise (Pirate Disguise)
            [43719] = true, -- Quendeluun Pact Disguise (Quendeluun Veiled Heritance Disguise)
            [28076] = true, -- Red Rook Disguise (Red Rook Disguise)
            [85204] = true, -- Scarlet Judge's Regalia (Scarlet Judge's Regalia)
            [33534] = true, -- Seaside Disguise (Sea Viper Armor)
            [27457] = true, -- Seadrake Disguise (Seadrake Disguise)
            [32045] = true, -- Servant Costume (Servant's Robes)
            [51906] = true, -- Q3854 Goblin Disguise (Shadowsilk Gem)
            [19013] = true, -- Steel Shrike Uniform (Steel Shrike Uniform)
            [19086] = true, -- Stormfist Disguise (Stormfist Disguise)
            [50177] = true, -- Vanguard Uniform (Vanguard Uniform)
            [43722] = true, -- First Auridon Marine Disguise (Vulkhel Guard Marine Disguise)

            -------------------------------------
            -- CHAMPION POINTS --
            -------------------------------------

            -- The Steed
            [59120] = true, -- Medium Armor Focus (The Steed)
            [92423] = true, -- Ironclad (The Steed)
            [62760] = true, -- Spell Shield (The Steed)
            [60384] = true, -- Resistant (The Steed)
            [60407] = true, -- Invigorating Bash (The Steed 10 - Invigorating Bash)
            [98313] = true, -- Invigorating Bash (The Steed 10 - Invigorating Bash)
            [63852] = true, -- Phase (The Steed 30 - Phase)
            [98294] = true, -- Phase (The Steed 30 - Phase)
            [61660] = true, -- Resilient (The Steed 75 - Resilient)
            [61661] = true, -- Resilient (The Steed 75 - Resilient)
            [64067] = true, -- Reinforced (The Steed 120 - Reinforced)
            [98314] = true, -- Reinforced (The Steed 120 - Reinforced)

            -- The Lady
            [60502] = true, -- Light Armor Focus (The Lady)
            [63850] = true, -- Thick Skinned (The Lady)
            [63844] = true, -- Hardy (The Lady)
            [63843] = true, -- Elemental Defender (The Lady)
            [63109] = true, -- Spell Absorption (The Lady 10 - Spell Absorption)
            [63110] = true,  -- Spell Absorption (The Lady 10 - Spell Absorption)
            [64079] = true, -- Shield Expert (The Lady 30 - Shield Expert)
            [60370] = true, -- Critical Leech (The Lady 75 - Critical Leech)
            [60371] = true, -- Critical Leech (The Lady 75 - Critical Leech)
            [59286] = true, -- Unchained (The Lady 120 - Unchained)
            [98316] = true, -- Unchained (The Lady 120 - Unchained)

            -- The Lord
            [60624] = true, -- Heavy Armor Focus (The Lord)
            [59948] = true, -- Bastion (The Lord)
            [59953] = true, -- Expert Defender (The Lord)
            [63851] = true, -- Quick Recovery (The Lord)
            [59300] = true, -- Field Physician (The Lord 10 - Field Physician)
            [98405] = true, -- Field Physician (The Lord 10 - Field Physician)
            [59582] = true, -- Infusion (The Lord 30 - Infusion)
            [98404] = true, -- Infusion (The Lord 30 - Infusion)
            [60427] = true, -- Revival (The Lord 75 - Revival)
            [98414] = true, -- Revival (The Lord 75 - Revival)
            [59893] = true, -- Determination (The Lord 120 - Determination)
            [61015] = true, -- Determination (The Lord 120 - Determination)

            -- The Tower
            [58899] = true, -- Bashing Focus (The Tower)
            [64077] = true, -- Sprinter (The Tower)
            [92425] = true, -- Siphoner (The Tower)
            [92428] = true, -- Siphoner (The Tower)
            [92431] = true, -- Warlord (The Tower)
            [60398] = true, -- Ensnare (The Tower 10 - Ensnare)
            [98308] = true, -- Ensnare (The Tower 10 - Ensnare)
            [60494] = true, -- Inspiration Boost (The Tower 30 - Inspiration Boost)
            [62516] = true, -- Mara's Gift (The Tower 75 - Mara's Gift)
            [62518] = true, -- Mara's Gift (The Tower 75 - Mara's Gift)
            [62274] = true, -- War Mount (The Tower 120 - War Mount)
            [64165] = true, -- War Mount (The Tower 120 - War Mount)

            -- The Lover
            [59346] = true, -- Mooncalf (The Lover)
            [59577] = true, -- Arcanist (The Lover)
            [60374] = true, -- Healthy (The Lover)
            [63854] = true, -- Tenacity (The Lover)
            [63663] = true, -- Plentiful Harvest (The Lover 10 - Plentiful Harvest)
            [63875] = true, -- Synergizer (The Lover 30 - Synergizer)
            [63878] = true, -- Synergizer (The Lover 30 - Synergizer)
            [60555] = true, -- Master Gatherer (The Lover 75 - Master Gatherer)
            [60560] = true, -- Windrunning (The Lover 125 - Windrunning)
            [64664] = true, -- Windrunning (The Lover 125 - Windrunning)
            [64665] = true, -- Windrunning (The Lover 125 - Windrunning)

            -- The Shadow
            [59298] = true, -- Befoul (The Shadow)
            [61548] = true, -- Shade (The Shadow)
            [60649] = true, -- Shadow Ward (The Shadow)
            [63863] = true, -- Tumbling (The Shadow)
            [56630] = true, -- Fortune Seeker (The Shadow 10 - Fortune Seeker)
            [60501] = true, -- Merchant Favored (The Shadow 30 - Merchant Favored)
            [60566] = true, -- Treasure Hunter (The Shadow 75 - Treasure Hunter)
            [61426] = true, -- Shadowstrike (The Shadow 120 - Shadowstrike)
            [64244] = true, -- Shadowstrike (The Shadow 120 - Shadowstrike)
            [64245] = true, -- Shadowstrike (The Shadow 120 - Shadowstrike)
            [77773] = true, -- Clairvoyance Fx (The Shadow 120 - Shadowstrike)

            -- The Apprentice
            [63848] = true, -- Elemental Expert (The Apprentice)
            [61555] = true, -- Spell Erosion (The Apprentice)
            [61680] = true, -- Elfborn (The Apprentice)
            [59630] = true, -- Blessed (The Apprentice)
            [63150] = true, -- Vengeance (The Apprentice 10 - Vengeance)
            [63152] = true, -- Vengeance Count (The Apprentice 10 - Vengeance)
            [63151] = true, -- Vengeance (The Apprentice 10 - Vengeance)
            [59626] = true, -- Spell Precision (The Apprentice 30 - Spell Precision)
            [59526] = true, -- Foresight (The Apprentice 75 - Foresight)
            [59530] = true, -- Foresight (The Apprentice 75 - Foresight)
            [63111] = true, -- Arcane Well (The Apprentice 120 - Arcane Well)
            [63114] = true, -- Arcane Well (The Apprentice 120 - Arcane Well)
            [88784] = true, -- Arcane Well (The Apprentice 120 - Arcane Well)

            -- The Atronach
            [92424] = true, -- Physical Weapon Expert (The Atronach)
            [60662] = true, -- Shattering Blows (The Atronach)
            [92134] = true, -- Master-at-Arms Expert (The Atronach)
            [60503] = true, -- Staff Expert (The Atronach)
            [63104] = true, -- Retaliation (The Atronach 10 - Retaliation)
            [63106] = true, -- Retaliation (The Atronach 10 - Retaliation)
            [60229] = true, -- Riposte (The Atronach 30 - Riposte)
            [60230] = true, -- Riposte (The Atronach 30 - Riposte)
            [63879] = true, -- Butcher (The Atronach 75 - Butcher)
            [60486] = true, -- Tactician (The Atronach 120 - Tactician)
            [63108] = true, -- Off-Balance (The Atronach 120 - Tactician)

            -- The Ritual
            [63847] = true, -- Thaumaturge (The Ritual)
            [59105] = true, -- Precise Strikes (The Ritual)
            [61546] = true, -- Piercing (The Ritual)
            [63868] = true, -- Mighty (The Ritual)
            [63099] = true, -- Opportunist (The Ritual 10 - Opportunist)
            [98307] = true, -- Opportunist (The Ritual 10 - Opportunist)
            [100408] = true, -- Opportunist (The Ritual 10 - Opportunist)
            [59418] = true, -- Perfect Strike (The Ritual 30 - Perfect Strike)
            [63880] = true, -- Exploiter (The Ritual 75 - Exploiter)
            [60413] = true, -- Last Stand (The Ritual 120 - Last Stand)
            [65133] = true, -- Major Heroism (The Ritual 120 - Last Stand)

            -------------------------------------
            -- PLAYER EFFECTS --
            -------------------------------------

            -- ROLL DODGE
            [28549] = true, -- Roll Dodge
            [29721] = true, -- Immobilize Immunity
            [69143] = true, -- Dodge Fatigue

            -- SPRINT
            [973] = true, -- Sprint
            [15356] = true, -- Sprint Drain

            -- CROUCH
            [20299] = true, -- Sneak
            [20304] = true, -- Crouch Slow
            [76463] = true, -- Clairvoyance Fx
            [20309] = true, -- Hidden
            [20307] = true, -- Trying to Hide
            [20301] = true, -- Crouch Drain
            [38127] = true, -- Remove Sprint
            [29177] = true, -- Flee
            [64420] = true, -- Remove Pet Stealth
            [26245] = true, -- Slam Stun

            -- MISC
            [15594] = true, -- Bonus vs off Balance
            --[20663] = true, -- Range Test Cast
            --[20667] = true, -- Heal Test Cast
            [28541] = true, -- Swap Weapons
            [25166] = true, -- Clumsy
            [10950] = true, -- Fall Snare
            [6811] = true, -- Recall
            [31221] = true, -- Skyshard Collect
            [32346] = true, -- Skyshard Collect
            [63601] = true, -- ESO Plus Member
            [47270] = true, -- Ritual of Mara

            -- MOUNT
            [36010] = true, -- Mount Up
            [37059] = true, -- Mount Up
            [37139] = true, -- Mount Up
            [36434] = true, -- Mount Up
            [42399] = true, -- Remove on Dismount
            [36432] = true, -- Dismount
            [36417] = true, -- Dismount
            [36419] = true, -- Dismount
            [46697] = true, -- Pause Mount Stamina Regen
            [42514] = true, -- Hard Dismount
            [43005] = true, -- Dismount
            [43770] = true, -- Boost
            [33439] = true, -- Mount Sprint (Generic)
            [33442] = true, -- Sprint Drain
            [41703] = true, -- Sprint
            [41704] = true, -- Sprint



            -- BLOCK
            [14890] = true, -- Block
            [16270] = true, -- Brace Cost
            [88724] = true, -- Brace Cost
            [86311] = true, -- Block FX
            [86310] = true, -- Stagger
            [86309] = true, -- Stun
            [86312] = true, -- Stun
            [45902] = true, -- Off-Balance
            [18713] = true, -- Remover

            -- BASH
            [55146] = true, -- Interrupt Bonus
            [21970] = true, -- Bash
            [21973] = true, -- Bash
            [21972] = true, -- Stagger
            [21971] = true, -- Bash Stun
            [48416] = true, -- Uber Attack
            [45982] = true, -- Bash Stun

            -- OFF-BALANCE EXPLOIT
            [20172] = true, -- Off-Balance Exploit
            [18793] = true, -- Off-Balance Exploit
            [16825] = true, -- Off-Balance Exploit

            -- BREAK FREE
            [16565] = true, -- Break Free
            [16566] = true, -- CC Immunity

            -- MUNDUS STONE EVENTS
            [14031] = true, -- Mundus Use
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

            -- DEATH/RESURRECTION
            [14644] = true, -- Revive (Death Dialog)
            [14646] = true, -- Recently Revived
            [26770] = true, -- Resurrect
            [55406] = true, -- Resurrect Trigger
            [55400] = true, -- Magicka Restore
            [55401] = true, -- Magicka Restore

            -- BASIC ATTACKS
            [16593] = true, -- Melee Snare
            --[64842] = true, -- Critter Smash
            [48532] = true, -- Charge Snare
            [61737] = true, -- Empower

            -- TAUNT EFFECTS
            [38254] = true, -- Taunt
            [52790] = true, -- Taunt Counter
            [38541] = true, -- Taunt
            [38542] = true, -- Taunt

            -- DISGUISE EFFECTS

            [50602] = true, -- Disguised
            [26237] = true, -- Disguise Warning Area
            [26238] = true, -- Disguise Warning Area
            [25584] = true, -- Discovered
            [25582] = true, -- Remove Disguise
            [26472] = true, -- Remove Disguise

            [25602] = true, -- Suspicious
            [25603] = true, -- Begin
            [25604] = true, -- Interact Complete
            [26223] = true, -- Remove Suspicious

            --[13371] = true, -- Acting Suspicious
            [13372] = true, -- Spotted

            -- MISC
            [22706] = true, -- Remove Sprint
            [20303] = true, -- Remove Sprint
            [38519] = true, -- Hiding
            [85701] = true, -- Dueling Flag
            --[2727] = true, -- Off-Balance
            [21263] = true, -- Ayleid Health Bonus

            --------------------------
            -- WORLD EVENTS
            --------------------------

            -- Daedric Anchor
            [13603] = true, -- CON_Destealth
            [44045] = true, -- Summon Victim
            [44056] = true, -- Summon Victim Spawn
            [48272] = true, -- Pester Victim
            [44058] = true, -- Draw the Blood
            [43982] = true, -- Sacrifice

            [46804] = true, -- Unexpected Sacrifice
            [46870] = true, -- Unexpected Sacrifice
            [46871] = true, -- Unexpected Sacrifice
            [46872] = true, -- Unexpected Sacrifice

            [43974] = true, -- Daedric Arrival
            [43972] = true, -- Daedric Arrival
            [86717] = true, -- Drop Anchor

            [46690] = true, -- Power of the Daedra
            [46689] = true, -- Vitality of the Daedra
            [51632] = true, -- Vitality of the Daedra
            [51633] = true, -- Vitality of the Daedra

            [44526] = true, -- Daedric Souls Basic
            [44635] = true, -- Daedric Souls Average
            [44636] = true, -- Daedric Souls Scary

            [95805] = true, -- Static Charge
            [95806] = true, -- Static Charge
            [95821] = true, -- Static Charge
            [95820] = true, -- Static Charge
            [95810] = true, -- Static Charge
            [95841] = true, -- Static Charge
            [95813] = true, -- Static Charge
            [96267] = true, -- Static Charge

            [56385] = true, -- DA Music Delay
            [46293] = true, -- Stun
            [46291] = true, -- Rain of Doom
            [46292] = true, -- Become Visible
            [46294] = true, -- Become Visible

            -- Daedric World Drop
            [51509] = true, -- Stun
            [51506] = true, -- Targetable Off
            [51505] = true, -- Portal Spawn
            [51507] = true, -- Targetable On

            --------------------------
            -- DRAGONKNIGHT PASSIVES
            --------------------------

            -- Ardent Flame
            [29424] = true, -- Combustion (Rank 1)
            [45011] = true, -- Combustion (Rank 2)
            [29430] = true, -- Warmth (Rank 1)
            [29436] = true, -- Warmth
            [45012] = true, -- Warmth (Rank 2)
            [45016] = true, -- Warmth
            [29439] = true, -- Searing Heat (Rank 1)
            [45023] = true, -- Searing Heat (Rank 2)
            [29451] = true, -- World in Ruin (Rank 1)
            [45029] = true, -- World in Ruin (Rank 2)

            -- Draconic Power
            [29455] = true, -- Iron Skin (Rank 1)
            [44922] = true, -- Iron Skin (Rank 2)
            [29457] = true, -- Burning Heart (Rank 1)
            [44933] = true, -- Burning Heart (Rank 2)
            [29460] = true, -- Elder Dragon (Rank 1)
            [44951] = true, -- Elder Dragon (Rank 2)
            [29462] = true, -- Scaled Armor (Rank 1)
            [44953] = true, -- Scaled Armor (Rank 2)

            -- Earthen Heart
            [29468] = true, -- Eternal Mountain (Rank 1)
            [44996] = true, -- Eternal Mountain (Rank 2)
            [29463] = true, -- Battle Roar (Rank 1)
            [29465] = true, -- Battle Roar
            [29466] = true, -- Battle Roar
            [29467] = true, -- Battle Roar
            [44984] = true, -- Battle Roar (Rank 2)
            [44986] = true, -- Battle Roar
            [44987] = true, -- Battle Roar
            [44988] = true, -- Battle Roar
            [29473] = true, -- Mountain's Blessing (Rank 1)
            [61798] = true, -- Minor Brutality
            [29474] = true, -- Mountain's Blessing
            [45001] = true, -- Mountain's Blessing (Rank 2)
            [61799] = true, -- Minor Brutality
            [45005] = true, -- Mountain's Blessing
            [29475] = true, -- Helping Hands (Rank 1)
            [29476] = true, -- Kynareth's Blessing
            [45009] = true, -- Helping Hands (Rank 2)
            [45010] = true, -- Kynareth's Blessing

            --------------------------
            -- DRAGONKNIGHT ACTIVE ABILITIES
            --------------------------

            [23806] = true, -- Lava Whip (Lava Whip - Rank 1)
            [23808] = true, -- Off Balance (Lava Whip - Rank 1)
            [20803] = true, -- Lava Whip (Lava Whip - Rank 2)
            [20804] = true, -- Off Balance (Lava Whip - Rank 2)
            [23809] = true, -- Lava Whip (Lava Whip - Rank 3)
            [23810] = true, -- Off Balance (Lava Whip - Rank 3)
            [23811] = true, -- Lava Whip (Lava Whip - Rank 4)
            [23812] = true, -- Off Balance (Lava Whip - Rank 4)

            [32842] = true, -- Molten Whip Passive (Molten Whip - Rank 1)
            [20805] = true, -- Molten Whip (Molten Whip - Rank 1)
            [20806] = true, -- Off Balance (Molten Whip - Rank 1)

            [20816] = true, -- Flame Lash (Flame Lash - Rank 1)
            [34117] = true, -- Off Balance (Flame Lash - Rank 1)
            [20824] = true, -- Power Lash (Flame Lash - Rank 1)
            [70742] = true, -- Off-Balance Exploit (Flame Lash - Rank 1)
            [70744] = true, -- Off-Balance Exploit (Flame Lash - Rank 1)
            [23105] = true, -- Power Lash (Flame Lash - Rank 1)
            [105196] = true, -- Power Lash (Flame Lash - Rank 1)

            [20657] = true, -- Searing Strike (Searing Strike - Rank 1)
            [44363] = true, -- Searing Strike (Searing Strike - Rank 1)
            [23882] = true, -- Searing Strike (Searing Strike - Rank 2)
            [44366] = true, -- Searing Strike (Searing Strike - Rank 2)
            [23884] = true, -- Searing Strike (Searing Strike - Rank 3)
            [44367] = true, -- Searing Strike (Searing Strike - Rank 3)
            [23886] = true, -- Searing Strike (Searing Strike - Rank 4)
            [44368] = true, -- Searing Strike (Searing Strike - Rank 4)

            [20668] = true, -- Venomous Claw (Venomous Claw - Rank 1)
            [44369] = true, -- Venomous Claw (Venomous Claw - Rank 1)
            [31810] = true, -- Venomous Claw (Venomous Claw - Rank 1)

            [32019] = true, -- Burning Embers (Burning Embers - Rank 1)
            [32018] = true, -- Burning Embers (Burning Embers - Rank 1)
            [20660] = true, -- Burning Embers (Burning Embers - Rank 1)
            [44373] = true, -- Burning Embers (Burning Embers - Rank 1)
            [31815] = true, -- Burning Embers (Burning Embers - Rank 1)

            --[20917] = true, -- Fiery Breath (Fiery Breath - Rank 1)
            --[31102] = true, -- Fiery Breath (Fiery Breath - Rank 1)
            --[34027] = true, -- Fiery Breath (Fiery Breath - Rank 2)
            --[34028] = true, -- Fiery Breath (Fiery Breath - Rank 2)
            --[34029] = true, -- Fiery Breath (Fiery Breath - Rank 3)
            --[34030] = true, -- Fiery Breath (Fiery Breath - Rank 3)
            --[34031] = true, -- Fiery Breath (Fiery Breath - Rank 4)
            --[34032] = true, -- Fiery Breath (Fiery Breath - Rank 4)

            --[20944] = true, -- Noxious Breath (Noxious Breath - Rank 1)
            --[31103] = true, -- Noxious Breath (Noxious Breath - Rank 1)
            --[48946] = true, -- Major Fracture (Noxious Breath - Rank 1)

            --[20930] = true, -- Engulfing Flames (Engulfing Flames - Rank 1)
            --[31104] = true, -- Engulfing Flames (Engulfing Flames - Rank 1)

            [67717] = true, -- Shackle Synergy Cooldown (Dragonknight Standard - All Ranks)
            [98438] = true, -- Shackle Damage (Dragonknight Standard - All Ranks)
            [98447] = true, -- Shackle Snare (Dragonknight Standard - All Ranks)
            [98437] = true, -- Shackle Area Effect (Dragonknight Standard - All Ranks)
            [98448] = true, -- Shackle Immune FX (Dragonknight Standard - All Ranks)

            [28988] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 1)
            [28995] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 1)
            [29230] = true, -- Major Defile (Dragonknight Standard - Rank 1)
            [102366] = true, -- Shackle Synergy Anchor (Dragonknight Standard - Rank 1)
            [32905] = true, -- Shackle (Dragonknight Standard - Rank 1)

            [33955] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 2)
            [33956] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 2)
            [33957] = true, -- Major Defile (Dragonknight Standard - Rank 2)
            [102367] = true, -- Shackle Synergy Anchor (Dragonknight Standard - Rank 2)
            [33958] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 2)

            [33959] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 3)
            [33960] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 3)
            [33961] = true, -- Major Defile (Dragonknight Standard - Rank 3)
            [102368] = true, -- Shackle Synergy Anchor (Dragonknight Standard - Rank 3)
            [33962] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 3)

            [33963] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 4)
            [33964] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 4)
            [33965] = true, -- Major Defile (Dragonknight Standard - Rank 4)
            [102369] = true, -- Shackle Synergy Anchor (Dragonknight Standard - Rank 4)
            [33966] = true, -- Dragonknight Standard (Dragonknight Standard - Rank 4)

            [32967] = true, -- Shifting Standard (Shifting Standard - Rank 1)
            [32958] = true, -- Shifting Standard (Shifting Standard - Rank 1)
            [70735] = true, -- Standard Cleanup (Shifting Standard - Rank 1)
            [32960] = true, -- Shifting Standard (Shifting Standard - Rank 1)
            [32961] = true, -- Shifting Standard (Shifting Standard - Rank 1)
            [102370] = true, -- Shackle Synergy Anchor (Shifting Standard - Rank 1)
            [32962] = true, -- Shifting Standard (Shifting Standard - Rank 1)
            [32963] = true, -- Shift Standard (Shifting Standard - Rank 1)
            [100100] = true, -- Shift Standard (Shifting Standard - Rank 1)
            [102376] = true, -- Shackle Synergy Anchor (Shifting Standard - Rank 1)
            [32966] = true, -- Shifting Standard (Shifting Standard - Rank 1)
            [32964] = true, -- Shifting Standard (Shifting Standard - Rank 1)
            [32965] = true, -- Shifting Standard (Shifting Standard - Rank 1)

            [32956] = true, -- Standard of Might (Standard of Might - Rank 1)
            [32957] = true, -- Standard of Might (Standard of Might - Rank 1)
            [32947] = true, -- Standard of Might (Standard of Might - Rank 1)
            [32948] = true, -- Standard of Might (Standard of Might - Rank 1)
            [32949] = true, -- Major Defile (Standard of Might - Rank 1)
            [102413] = true, -- Shackle Synergy Anchor (Standard of Might - Rank 1)
            [32950] = true, -- Standard of Might (Standard of Might - Rank 1)

            [20319] = true, -- Spiked Armor (Spiked Armor - Rank 1)
            [61815] = true, -- Major Resolve (Spiked Armor - Rank 1)
            [61816] = true, -- Major Ward (Spiked Armor - Rank 1)
            [20320] = true, -- Spiked Armor Damage Return (Spiked Armor - Rank 1)
            [23822] = true, -- Spiked Armor (Spiked Armor - Rank 2)
            [61820] = true, -- Major Resolve (Spiked Armor - Rank 2)
            [61821] = true, -- Major Ward (Spiked Armor - Rank 2)
            [23823] = true, -- Spiked Armor Damage Return (Spiked Armor - Rank 2)
            [23825] = true, -- Spiked Armor (Spiked Armor - Rank 3)
            [61823] = true, -- Major Resolve (Spiked Armor - Rank 3)
            [61824] = true, -- Major Ward (Spiked Armor - Rank 3)
            [23826] = true, -- Spiked Armor Damage Return (Spiked Armor - Rank 3)
            [23828] = true, -- Spiked Armor (Spiked Armor - Rank 4)
            [61825] = true, -- Major Resolve (Spiked Armor - Rank 4)
            [61826] = true, -- Major Ward (Spiked Armor - Rank 4)
            [23829] = true, -- Spiked Armor Damage Return (Spiked Armor - Rank 4)

            [20328] = true, -- Hardened Armor (Hardened Armor - Rank 1)
            [61827] = true, -- Major Resolve (Hardened Armor - Rank 1)
            [61828] = true, -- Major Ward (Hardened Armor - Rank 1)
            [31808] = true, -- Hardened Armor (Hardened Armor - Rank 1)
            [20329] = true, -- Hardened Armor Damage Return (Hardened Armor - Rank 1)

            [20323] = true, -- Volatile Armor (Volatile Armor - Rank 1)
            [61836] = true, -- Major Resolve (Volatile Armor - Rank 1)
            [61837] = true, -- Major Ward (Volatile Armor - Rank 1)
            [20324] = true, -- Volatle Armor Damage Return (Volatile Armor - Rank 1)
            [20326] = true, -- Volatile Armor (Volatile Armor - Rank 1)

            [32974] = true, -- Impale (Dark Talons - All Ranks)
            [48040] = true, -- Synergy Dummy (Dark Talons - All Ranks)

            [20245] = true, -- Dark Talons (Dark Talons - Rank 1)
            [20527] = true, -- Dark Talons (Dark Talons - Rank 1)
            [102690] = true, -- Ignite Synergy Ticker (Dark Talons - Rank 1)
            [32976] = true, -- Ignite Grant Ability (Dark Talons - Rank 1)
            [95174] = true, -- Dark Talons FX (Dark Talons - Rank 1)

            [32105] = true, -- Dark Talons (Dark Talons - Rank 2)
            [32107] = true, -- Dark Talons (Dark Talons - Rank 2)
            [102713] = true, -- Impale Synergy Ticker (Dark Talons - Rank 2)
            [33238] = true, -- Impale Grant Ability (Dark Talons - Rank 2)
            [95175] = true, -- Dark Talons FX (Dark Talons - Rank 2)

            [32108] = true, -- Dark Talons (Dark Talons - Rank 3)
            [32110] = true, -- Dark Talons (Dark Talons - Rank 3)
            [102714] = true, -- Impale Synergy Ticker (Dark Talons - Rank 3)
            [33240] = true, -- Impale Grant Ability (Dark Talons - Rank 3)
            [95176] = true, -- Dark Talons FX (Dark Talons - Rank 3)

            [32111] = true, -- Dark Talons (Dark Talons - Rank 4)
            [32113] = true, -- Dark Talons (Dark Talons - Rank 4)
            [102715] = true, -- Impale Synergy Ticker (Dark Talons - Rank 4)
            [33242] = true, -- Impale Grant Ability (Dark Talons - Rank 4)
            [95177] = true, -- Dark Talons FX (Dark Talons - Rank 4)

            [20252] = true, -- Burning Talons (Impale Grant Ability - Rank 1)
            [31898] = true, -- Burning Talons (Burning Talons - Rank 1)
            [20253] = true, -- Burning Talons (Burning Talons - Rank 1)
            [102716] = true, -- Ignite Synergy Ticker (Burning Talons - Rank 1)
            [33244] = true, -- Ignite Grant Ability (Burning Talons - Rank 1)
            [95178] = true, -- Dark Talons FX (Burning Talons - Rank 1)

            [20251] = true, -- Choking Talons (Choking Talons - Rank 1)
            [31899] = true, -- Minor Maim (Choking Talons - Rank 1)
            [20528] = true, -- Choking Talons (Choking Talons - Rank 1)
            [102720] = true, -- Ignite Synergy Ticker (Choking Talons - Rank 1)
            [33252] = true, -- Ignite Grant Ability (Choking Talons - Rank 1)
            [95182] = true, -- Dark Talons FX (Choking Talons - Rank 1)

            --[29004] = true, -- Dragon Blood (Dragon Blood - Rank 1)
            --[29010] = true, -- Dragon Blood (Dragon Blood - Rank 1)
            --[29011] = true, -- Major Fortitude (Dragon Blood - Rank 1)
            --[33405] = true, -- Dragon Blood (Dragon Blood - Rank 2)
            --[33614] = true, -- Dragon Blood (Dragon Blood - Rank 2)
            --[61871] = true, -- Major Fortitude (Dragon Blood - Rank 2)
            --[33616] = true, -- Dragon Blood (Dragon Blood - Rank 3)
            --[33617] = true, -- Dragon Blood (Dragon Blood - Rank 3)
            --[61872] = true, -- Major Fortitude (Dragon Blood - Rank 3)
            --[33619] = true, -- Dragon Blood (Dragon Blood - Rank 4)
            --[33620] = true, -- Dragon Blood (Dragon Blood - Rank 4)
            --[61873] = true, -- Major Fortitude (Dragon Blood - Rank 4)

            --[32744] = true, -- Green Dragon Blood (Dragon Blood - Rank 1)
            --[32745] = true, -- Green Dragon Blood (Dragon Blood - Rank 1)
            --[32748] = true, -- Major Endurance (Dragon Blood - Rank 1)
            --[61884] = true, -- Major Fortitude (Dragon Blood - Rank 1)
            --[91670] = true, -- Minor Vitality (Dragon Blood - Rank 1)

            --[32722] = true, -- Coagulating Blood (Coagulating Blood - Rank 1)
            --[32733] = true, -- Coagulating Blood Bonus Heal (Coagulating Blood - Rank 1)
            --[32723] = true, -- Coagulating Blood (Coagulating Blood - Rank 1)
            --[61891] = true, -- Major Fortitude (Coagulating Blood - Rank 1)

            --[18032] = true, -- Stun (Dragon Leap - All Ranks)

            [48744] = true, -- CC Immunity (Dragon Leap - Rank 1)
            [29012] = true, -- Dragon Leap (Dragon Leap - Rank 1)
            [29014] = true, -- Dragon Leap (Dragon Leap - Rank 1)
            [29016] = true, -- Dragon Leap (Dragon Leap - Rank 1)
            [48746] = true, -- CC Immunity (Dragon Leap - Rank 2)
            [33652] = true, -- Dragon Leap (Dragon Leap - Rank 2)
            [33653] = true, -- Dragon Leap (Dragon Leap - Rank 2)
            [33654] = true, -- Dragon Leap (Dragon Leap - Rank 2)
            [48749] = true, -- CC Immunity (Dragon Leap - Rank 3)
            [33655] = true, -- Dragon Leap (Dragon Leap - Rank 3)
            [33656] = true, -- Dragon Leap (Dragon Leap - Rank 3)
            [33657] = true, -- Dragon Leap (Dragon Leap - Rank 3)
            [48751] = true, -- CC Immunity (Dragon Leap - Rank 4)
            [33658] = true, -- Dragon Leap (Dragon Leap - Rank 4)
            [33659] = true, -- Dragon Leap (Dragon Leap - Rank 4)
            [33660] = true, -- Dragon Leap (Dragon Leap - Rank 4)

            [48753] = true, -- CC Immunity (Take Flight - Rank 1)
            [32719] = true, -- Take Flight (Take Flight - Rank 1)
            [32720] = true, -- Take Flight (Take Flight - Rank 1)
            [32721] = true, -- Take Flight (Take Flight - Rank 1)

            [48760] = true, -- CC Immunity (Ferocious Leap - Rank 1)
            [32715] = true, -- Ferocious Leap (Ferocious Leap - Rank 1)
            [32716] = true, -- Ferocious Leap (Ferocious Leap - Rank 1)
            [32717] = true, -- Ferocious Leap (Ferocious Leap - Rank 1)
            [61814] = true, -- Ferocious Leap (Ferocious Leap - Rank 1)

            [86798] = true, -- Knockdown Bonus Damage (Stonefist - Rank 1)
            [29032] = true, -- Stonefist (Stonefist - Rank 1)
            [29034] = true, -- Stonefist (Stonefist - Rank 1)
            [86802] = true, -- Knockdown Bonus Damage (Stonefist - Rank 2)
            [32190] = true, -- Stonefist (Stonefist - Rank 2)
            [32191] = true, -- Stonefist (Stonefist - Rank 2)
            [86803] = true, -- Knockdown Bonus Damage (Stonefist - Rank 3)
            [32192] = true, -- Stonefist (Stonefist - Rank 3)
            [32193] = true, -- Stonefist (Stonefist - Rank 3)
            [86804] = true, -- Knockdown Bonus Damage (Stonefist - Rank 4)
            [32194] = true, -- Stonefist (Stonefist - Rank 4)
            [32195] = true, -- Stonefist (Stonefist - Rank 4)

            [31820] = true, -- Obsidian Shard (Obsidian Shard - Rank 1)
            [31821] = true, -- Obsidian Shard (Obsidian Shard - Rank 1)
            [68763] = true, -- Obsidian Shard (Obsidian Shard - Rank 1)

            [86805] = true, -- Knockdown Bonus Damage (Stone Giant - Rank 1)
            [31816] = true, -- Stone Giant (Stone Giant - Rank 1)
            [31817] = true, -- Stone Giant (Stone Giant - Rank 1)
            [31818] = true, -- Minor Resolve (Stone Giant - Rank 1)

            [29043] = true, -- Molten Weapons (Molten Weapons - Rank 1)
            [92507] = true, -- Major Sorcery (Molten Weapons - Rank 1)
            [32151] = true, -- Molten Weapons (Molten Weapons - Rank 2)
            [92509] = true, -- Major Sorcery (Molten Weapons - Rank 2)
            [32154] = true, -- Molten Weapons (Molten Weapons - Rank 3)
            [92510] = true, -- Major Sorcery (Molten Weapons - Rank 3)
            [32156] = true, -- Molten Weapons (Molten Weapons - Rank 4)
            [92511] = true, -- Major Sorcery (Molten Weapons - Rank 4)

            [31874] = true, -- Igneous Weapons (Igneous Weapons - Rank 1)
            [76518] = true, -- Major Brutality (Igneous Weapons - Rank 1)
            [92503] = true, -- Major Sorcery (Igneous Weapons - Rank 1)

            [31888] = true, -- Molten Armaments (Molten Armaments - Rank 1)
            [76537] = true, -- Molten Armaments (Molten Armaments - Rank 1)
            [92512] = true, -- Major Sorcery (Molten Armaments - Rank 1)

            --[29071] = true, -- Obsidian Shield (Obsidian Shield - Rank 1)
            --[29072] = true, -- Obsidian Shield (Obsidian Shield - Rank 1)
            --[33862] = true, -- Obsidian Shield (Obsidian Shield - Rank 2)
            --[33863] = true, -- Obsidian Shield (Obsidian Shield - Rank 2)
            --[33864] = true, -- Obsidian Shield (Obsidian Shield - Rank 3)
            --[33865] = true, -- Obsidian Shield (Obsidian Shield - Rank 3)
            --[33866] = true, -- Obsidian Shield (Obsidian Shield - Rank 4)
            --[33867] = true, -- Obsidian Shield (Obsidian Shield - Rank 4)

            --[29224] = true, -- Igneous Shield (Igneous Shield - Rank 1)
            --[29225] = true, -- Obsidian Shield (Igneous Shield - Rank 1)
            --[55033] = true, -- Major Mending (Igneous Shield - Rank 1)

            --[32673] = true, -- Fragmented Shield (Fragmented Shield - Rank 1)
            --[32674] = true, -- Fragmented Shield (Fragmented Shield - Rank 1)
            --[32675] = true, -- Fragmented Shield (Fragmented Shield - Rank 1)

            [15957] = true, -- Magma Armor (Magma Armor - Rank 1)
            [15959] = true, -- Magma Armor (Magma Armor - Rank 1)
            [19976] = true, -- Magma Armor (Magma Armor - Rank 2)
            [19977] = true, -- Magma Armor (Magma Armor - Rank 2)
            [19979] = true, -- Magma Armor (Magma Armor - Rank 3)
            [19980] = true, -- Magma Armor (Magma Armor - Rank 3)
            [19982] = true, -- Magma Armor (Magma Armor - Rank 4)
            [19983] = true, -- Magma Armor (Magma Armor - Rank 4)

            [17874] = true, -- Magma Shell (Magma Shell - Rank 1)
            [17875] = true, -- Magma Shell (Magma Shell - Rank 1)
            [76483] = true, -- Magma Shell (Magma Shell - Rank 1)

            [17878] = true, -- Corrosive Armor (Corrosive Armor - Rank 1)
            [17879] = true, -- Corrosive Armor (Corrosive Armor - Rank 1)

            --------------------------
            -- SORCERER PASSIVES
            --------------------------

            -- Dark Magic
            [31386] = true, -- Unholy Knowledge (Rank 1)
            [45176] = true, -- Unholy Knowledge (Rank 2)
            [31383] = true, -- Blood Magic (Rank 1)
            [31384] = true, -- Blood Magic
            [45172] = true, -- Blood Magic (Rank 2)
            [45173] = true, -- Blood Magic
            [31378] = true, -- Persistance (Rank 1)
            [45165] = true, -- Persistance (Rank 2)
            [31389] = true, -- Exploitation (Rank 1)
            [62319] = true, -- Minor Prophecy
            [45181] = true, -- Exploitation (Rank 2)
            [62320] = true, -- Minor Prophecy

            -- Daedric Summoning
            [31398] = true, -- Rebate (Rank 1)
            [64860] = true, -- Rebate Magic
            [45198] = true, -- Rebate (Rank 2)
            [64861] = true, -- Rebate Magic
            [31396] = true, -- Power Stone (Rank 1)
            [45196] = true, -- Power Stone (Rank 2)
            [31417] = true, -- Daedric Protection (Rank 1)
            [45200] = true, -- Daedric Protection (Rank 2)
            [31412] = true, -- Expert Summoner (Rank 1)
            [31415] = true, -- Expert Summoner
            [45199] = true, -- Expert Summoner (Rank 2)
            [46198] = true, -- Expert Summoner

            -- Storm Calling
            [31419] = true, -- Capacitor (Rank 1)
            [45188] = true, -- Capacitor (Rank 2)
            [31421] = true, -- Energized (Rank 1)
            [45190] = true, -- Energized (Rank 2)
            [31422] = true, -- Implosion (Rank 1)
            [31424] = true, -- Implosion
            [82803] = true, -- Implosion
            [45192] = true, -- Implosion (Rank 2)
            [45194] = true, -- Implosion
            [82806] = true, -- Implosion
            [31425] = true, -- Expert Mage (Rank 1)
            [45195] = true, -- Expert Mage (Rank 2)

            --------------------------
            -- NIGHTBLADE PASSIVES
            --------------------------

            -- Assassination
            [36616] = true, -- Master Assassin (Rank 1)
            [45038] = true, -- Master Assassin (Rank 2)
            [36630] = true, -- Executioner (Rank 1)
            [101434] = true, -- Executioner
            [101435] = true, -- Executioner
            [36633] = true, -- Executioner
            [45048] = true, -- Executioner (Rank 2)
            [101437] = true, -- Executioner
            [101436] = true, -- Executioner
            [45050] = true, -- Executioner
            [36636] = true, -- Pressure Points (Rank 1)
            [45053] = true, -- Pressure Points (Rank 2)
            [36641] = true, -- Hemorrhage (Rank 1)
            [61882] = true, -- Minor Savagery
            [45060] = true, -- Hemorrhage (Rank 2)
            [61898] = true, -- Minor Savagery

            -- Shadow
            [36549] = true, -- Refreshing Shadows (Rank 1)
            [45103] = true, -- Refreshing Shadows (Rank 2)
            [18866] = true, -- Shadow Barrier (Rank 1)
            [18868] = true, -- Major Ward
            [66075] = true, -- Major Resolve
            [45071] = true, -- Shadow Barrier (Rank 2)
            [45076] = true, -- Major Ward
            [66083] = true, -- Major Resolve
            [36532] = true, -- Dark Vigor (Rank 1)
            [45084] = true, -- Dark Vigor (Rank 2)
            [36552] = true, -- Dark Veil (Rank 1)
            [45115] = true, -- Dark Veil (Rank 2)

            -- Siphoning
            [36560] = true, -- Catalyst (Rank 1)
            [63705] = true, -- Amphibious Regen
            [45135] = true, -- Catalyst (Rank 2)
            [63707] = true, -- Amphibious Regen
            [36595] = true, -- Magicka Flood (Rank 1)
            [45150] = true, -- Magicka Flood (Rank 2)
            [36603] = true, -- Soul Siphoner (Rank 1)
            [45155] = true, -- Soul Siphoner (Rank 2)
            [36587] = true, -- Transfer (Rank 1)
            [36589] = true, -- Transfer
            [45145] = true, -- Transfer (Rank 2)
            [45146] = true, -- Transfer

            --------------------------
            -- TEMPLAR PASSIVES
            --------------------------

            -- Aedric Spear
            [31698] = true, -- Piercing Spear (Rank 1)
            [44046] = true, -- Piercing Spear (Rank 2)
            [31708] = true, -- Spear Wall (Rank 1)
            [44721] = true, -- Spear Wall (Rank 2)
            [31718] = true, -- Burning Light (Rank 1)
            [31720] = true, -- Burning Light
            [80153] = true, -- Burning Light
            [44730] = true, -- Burning Light (Rank 2)
            [44731] = true, -- Burning Light
            [80170] = true, -- Burning Light
            [31565] = true, -- Balanced Warrior (Rank 1)
            [44732] = true, -- Balanced Warrior (Rank 2)

            -- Dawn's Wrath
            [31739] = true, -- Enduring Rays (Rank 1)
            [45214] = true, -- Enduring Rays (Rank 2)
            [31744] = true, -- Prism (Rank 1)
            [31746] = true, -- Prism
            [45216] = true, -- Prism (Rank 2)
            [45217] = true, -- Prism
            [31743] = true, -- Illuminate (Rank 1)
            [62799] = true, -- Minor Sorcery
            [45215] = true, -- Illuminate (Rank 2)
            [62800] = true, -- Minor Sorcery
            [31721] = true, -- Restoring Spirit (Rank 1)
            [45212] = true, -- Restoring Spirit (Rank 2)

            -- Restoring Light
            [31751] = true, -- Mending (Rank 1)
            [45206] = true, -- Mending (Rank 2)
            [31757] = true, -- Sacred Ground (Rank 1)
            [45207] = true, -- Sacred Ground (Rank 2)
            [77082] = true, -- Major Mending
            [80195] = true, -- Sacred Ground
            [80230] = true, -- Sacred Ground
            [80261] = true, -- Sacred Ground
            [31760] = true, -- Light Weaver (Rank 1)
            [45208] = true, -- Light Weaver (Rank 2)
            [52703] = true, -- Light Weaver Ultimate
            [31747] = true, -- Master Ritualist (Rank 1)
            [31748] = true, -- Soul Trap
            [45202] = true, -- Master Ritualist (Rank 2)
            [45203] = true, -- Soul Trap

            --------------------------
            -- TEMPLAR ACTIVE ABILITIES
            --------------------------

            [26114] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 1)
            [102904] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 1)
            [26116] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 1)
            [44426] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 1)
            [76908] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 1)
            [27179] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 2)
            [103096] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 2)
            [27180] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 2)
            [44429] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 2)
            [76909] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 2)
            [27182] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 3)
            [103097] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 3)
            [27184] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 3)
            [44430] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 3)
            [76910] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 3)
            [27186] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 4)
            [103099] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 3)
            [27187] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 4)
            [44431] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 4)
            [76911] = true, -- Puncturing Strikes (Puncturing Strikes - Rank 4)

            [26792] = true, -- Biting Jabs (Biting Jabs - Rank 1)
            [26795] = true, -- Major Savagery (Biting Jabs - Rank 1)
            [103212] = true, -- Biting Jabs (Biting Jabs - Rank 1)
            [26794] = true, -- Biting Jabs (Biting Jabs - Rank 1)
            [44432] = true, -- Biting Jabs (Biting Jabs - Rank 1)
            [76912] = true, -- Biting Jabs (Biting Jabs - Rank 1)

            [27189] = true, -- Biting Jabs (Biting Jabs - Rank 2)
            [27190] = true, -- Major Savagery (Biting Jabs - Rank 2)
            [103214] = true, -- Biting Jabs (Biting Jabs - Rank 2)
            [27192] = true, -- Biting Jabs (Biting Jabs - Rank 2)
            [44433] = true, -- Biting Jabs (Biting Jabs - Rank 2)
            [76913] = true, -- Biting Jabs (Biting Jabs - Rank 2)

            [27193] = true, -- Biting Jabs (Biting Jabs - Rank 3)
            [27194] = true, -- Major Savagery (Biting Jabs - Rank 3)
            [103215] = true, -- Biting Jabs (Biting Jabs - Rank 3)
            [27196] = true, -- Biting Jabs (Biting Jabs - Rank 3)
            [44434] = true, -- Biting Jabs (Biting Jabs - Rank 3)
            [76914] = true, -- Biting Jabs (Biting Jabs - Rank 3)

            [27197] = true, -- Biting Jabs (Biting Jabs - Rank 4)
            [27198] = true, -- Major Savagery (Biting Jabs - Rank 4)
            [103216] = true, -- Biting Jabs (Biting Jabs - Rank 4)
            [27200] = true, -- Biting Jabs (Biting Jabs - Rank 4)
            [44435] = true, -- Biting Jabs (Biting Jabs - Rank 4)
            [76915] = true, -- Biting Jabs (Biting Jabs - Rank 4)

            [55219] = true, -- Trigger (Puncturing Sweep - Rank 1)
            [26797] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 1)
            [103310] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 1)
            [55183] = true, -- Puncturing Sweep Healing (Puncturing Sweep - Rank 1)
            [26799] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 1)
            [44436] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 1)
            [76916] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 1)

            [55223] = true, -- Trigger (Puncturing Sweep - Rank 2)
            [27201] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 2)
            [103311] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 2)
            [55222] = true, -- Puncturing Sweep Healing (Puncturing Sweep - Rank 2)
            [27203] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 2)
            [44437] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 2)
            [76917] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 2)

            [55225] = true, -- Trigger (Puncturing Sweep - Rank 3)
            [27204] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 3)
            [103312] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 3)
            [55224] = true, -- Puncturing Sweep Healing (Puncturing Sweep - Rank 3)
            [27206] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 3)
            [44438] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 3)
            [76918] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 3)

            [55227] = true, -- Trigger (Puncturing Sweep - Rank 4)
            [27207] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 4)
            [103313] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 4)
            [55226] = true, -- Puncturing Sweep Healing (Puncturing Sweep - Rank 4)
            [27209] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 4)
            [44439] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 4)
            [76919] = true, -- Puncturing Sweep (Puncturing Sweep - Rank 4)

            [26158] = true, -- Piercing Javelin (Piercing Javelin - Rank 1)
            [37409] = true, -- Piercing Javelin (Piercing Javelin - Rank 1)
            [26162] = true, -- Piercing Javelin (Piercing Javelin - Rank 1)
            [26971] = true, -- Piercing Javelin (Piercing Javelin - Rank 2)
            [37411] = true, -- Piercing Javelin (Piercing Javelin - Rank 2)
            [26972] = true, -- Piercing Javelin (Piercing Javelin - Rank 2)
            [26973] = true, -- Piercing Javelin (Piercing Javelin - Rank 3)
            [37412] = true, -- Piercing Javelin (Piercing Javelin - Rank 3)
            [26974] = true, -- Piercing Javelin (Piercing Javelin - Rank 3)
            [26975] = true, -- Piercing Javelin (Piercing Javelin - Rank 4)
            [37413] = true, -- Piercing Javelin (Piercing Javelin - Rank 4)
            [26976] = true, -- Piercing Javelin (Piercing Javelin - Rank 4)

            [26802] = true, -- Aurora Javelin Damage Bonus (Aurora Javelin - Rank 1)
            [26800] = true, -- Aurora Javelin (Aurora Javelin - Rank 1)
            [37414] = true, -- Piercing Javelin (Aurora Javelin - Rank 1)
            [26801] = true, -- Aurora Javelin (Aurora Javelin - Rank 1)

            [26978] = true, -- Aurora Javelin Damage Bonus (Aurora Javelin - Rank 2)
            [26977] = true, -- Aurora Javelin (Aurora Javelin - Rank 2)
            [37415] = true, -- Piercing Javelin (Aurora Javelin - Rank 2)
            [26979] = true, -- Aurora Javelin (Aurora Javelin - Rank 2)

            [26981] = true, -- Aurora Javelin Damage Bonus (Aurora Javelin - Rank 3)
            [26980] = true, -- Aurora Javelin (Aurora Javelin - Rank 3)
            [37416] = true, -- Piercing Javelin (Aurora Javelin - Rank 3)
            [26982] = true, -- Aurora Javelin (Aurora Javelin - Rank 3)

            [26984] = true, -- Aurora Javelin Damage Bonus (Aurora Javelin - Rank 4)
            [26983] = true, -- Aurora Javelin (Aurora Javelin - Rank 4)
            [37417] = true, -- Piercing Javelin (Aurora Javelin - Rank 4)
            [26985] = true, -- Aurora Javelin (Aurora Javelin - Rank 4)

            [26804] = true, -- Binding Javelin (Binding Javelin - Rank 1)
            [32099] = true, -- Binding Javelin (Binding Javelin - Rank 1)
            [26805] = true, -- Binding Javelin (Binding Javelin - Rank 1)

            [26986] = true, -- Binding Javelin (Binding Javelin - Rank 2)
            [32103] = true, -- Binding Javelin (Binding Javelin - Rank 2)
            [26988] = true, -- Binding Javelin (Binding Javelin - Rank 2)

            [26989] = true, -- Binding Javelin (Binding Javelin - Rank 3)
            [32102] = true, -- Binding Javelin (Binding Javelin - Rank 3)
            [26991] = true, -- Binding Javelin (Binding Javelin - Rank 3)

            [26992] = true, -- Binding Javelin (Binding Javelin - Rank 4)
            [32101] = true, -- Binding Javelin (Binding Javelin - Rank 4)
            [26994] = true, -- Binding Javelin (Binding Javelin - Rank 4)

            [22149] = true, -- Focused Charge (Focused Charge - Rank 1)
            [22155] = true, -- Focused Charge (Focused Charge - Rank 1)
            [26508] = true, -- Charge (Focused Charge - Rank 1)
            [49204] = true, -- Focused Charge (Focused Charge - Rank 1)
            [49205] = true, -- Focused Charge (Focused Charge - Rank 1)

            [23709] = true, -- Focused Charge (Focused Charge - Rank 2)
            [23710] = true, -- Focused Charge (Focused Charge - Rank 2)
            [26510] = true, -- Charge (Focused Charge - Rank 2)
            [49206] = true, -- Focused Charge (Focused Charge - Rank 2)
            [49207] = true, -- Focused Charge (Focused Charge - Rank 2)

            [23713] = true, -- Focused Charge (Focused Charge - Rank 3)
            [23714] = true, -- Focused Charge (Focused Charge - Rank 3)
            [26512] = true, -- Charge (Focused Charge - Rank 3)
            [49208] = true, -- Focused Charge (Focused Charge - Rank 3)
            [49209] = true, -- Focused Charge (Focused Charge - Rank 3)

            [23716] = true, -- Focused Charge (Focused Charge - Rank 4)
            [23717] = true, -- Focused Charge (Focused Charge - Rank 4)
            [26513] = true, -- Charge (Focused Charge - Rank 4)
            [49210] = true, -- Focused Charge (Focused Charge - Rank 4)
            [49211] = true, -- Focused Charge (Focused Charge - Rank 4)

            [43585] = true, -- Explosive Charge AoE Dummy (Explosive Charge - All Ranks)

            [22161] = true, -- Explosive Charge (Explosive Charge - Rank 1)
            [22165] = true, -- Explosive Charge (Explosive Charge - Rank 1)
            [26522] = true, -- Charge (Explosive Charge - Rank 1)
            [49212] = true, -- Explosive Charge (Explosive Charge - Rank 1)
            [49213] = true, -- Explosive Charge (Explosive Charge - Rank 1)

            [23719] = true, -- Explosive Charge (Explosive Charge - Rank 2)
            [23720] = true, -- Explosive Charge (Explosive Charge - Rank 2)
            [26523] = true, -- Charge (Explosive Charge - Rank 2)
            [49214] = true, -- Explosive Charge (Explosive Charge - Rank 2)
            [49215] = true, -- Explosive Charge (Explosive Charge - Rank 2)

            [23722] = true, -- Explosive Charge (Explosive Charge - Rank 3)
            [23724] = true, -- Explosive Charge (Explosive Charge - Rank 3)
            [26524] = true, -- Charge (Explosive Charge - Rank 3)
            [49216] = true, -- Explosive Charge (Explosive Charge - Rank 3)
            [49217] = true, -- Explosive Charge (Explosive Charge - Rank 3)

            [23726] = true, -- Explosive Charge (Explosive Charge - Rank 4)
            [23727] = true, -- Explosive Charge (Explosive Charge - Rank 4)
            [26525] = true, -- Charge (Explosive Charge - Rank 4)
            [49218] = true, -- Explosive Charge (Explosive Charge - Rank 4)
            [49219] = true, -- Explosive Charge (Explosive Charge - Rank 4)

            [15540] = true, -- Toppling Charge (Toppling Charge - Rank 1)
            [15544] = true, -- Toppling Charge (Toppling Charge - Rank 1)
            [15546] = true, -- Toppling Charge (Toppling Charge - Rank 1)
            [26518] = true, -- Charge (Toppling Charge - Rank 1)
            [44422] = true, -- Toppling Charge (Toppling Charge - Rank 1)

            [23864] = true, -- Toppling Charge (Toppling Charge - Rank 2)
            [23866] = true, -- Toppling Charge (Toppling Charge - Rank 2)
            [23867] = true, -- Toppling Charge (Toppling Charge - Rank 2)
            [26519] = true, -- Charge (Toppling Charge - Rank 2)
            [44423] = true, -- Toppling Charge (Toppling Charge - Rank 2)

            [23869] = true, -- Toppling Charge (Toppling Charge - Rank 3)
            [23876] = true, -- Toppling Charge (Toppling Charge - Rank 3)
            [23877] = true, -- Toppling Charge (Toppling Charge - Rank 3)
            [26520] = true, -- Charge (Toppling Charge - Rank 3)
            [44424] = true, -- Toppling Charge (Toppling Charge - Rank 3)

            [23870] = true, -- Toppling Charge (Toppling Charge - Rank 4)
            [23872] = true, -- Toppling Charge (Toppling Charge - Rank 4)
            [23873] = true, -- Toppling Charge (Toppling Charge - Rank 4)
            [26521] = true, -- Charge (Toppling Charge - Rank 4)
            [44425] = true, -- Toppling Charge (Toppling Charge - Rank 4)

            [94973] = true, -- Blessed Shards (Spear Shards - All Ranks)
            [94974] = true, -- Blessed Shards (Spear Shards - All Ranks)
            [48052] = true, -- Spear Shards / Necrotic Orb CD (Spear Shards - All Ranks)

            [26188] = true, -- Spear Shards (Spear Shards - Rank 1)
            [26190] = true, -- Spear Shards (Spear Shards - Rank 1)
            [95932] = true, -- Spear Shards (Spear Shards - Rank 1)
            [95933] = true, -- Spear Shards (Spear Shards - Rank 1)
            [26189] = true, -- Spear Shards (Spear Shards - Rank 1)
            [26191] = true, -- Spear Shards (Spear Shards - Rank 1)
            [26827] = true, -- Spear Shards (Spear Shards - Rank 1)
            [26192] = true, -- Spear Shards (Spear Shards - Rank 1)
            [95931] = true, -- Spear Shards (Spear Shards - Rank 1)

            [27046] = true, -- Spear Shards (Spear Shards - Rank 2)
            [27071] = true, -- Spear Shards (Spear Shards - Rank 2)
            [95935] = true, -- Spear Shards (Spear Shards - Rank 2)
            [95936] = true, -- Spear Shards (Spear Shards - Rank 2)
            [27077] = true, -- Spear Shards (Spear Shards - Rank 2)
            [27072] = true, -- Spear Shards (Spear Shards - Rank 2)
            [27074] = true, -- Spear Shards (Spear Shards - Rank 2)
            [27070] = true, -- Spear Shards (Spear Shards - Rank 2)
            [95934] = true, -- Spear Shards (Spear Shards - Rank 2)

            [27059] = true, -- Spear Shards (Spear Shards - Rank 3)
            [27083] = true, -- Spear Shards (Spear Shards - Rank 3)
            [95938] = true, -- Spear Shards (Spear Shards - Rank 3)
            [95939] = true, -- Spear Shards (Spear Shards - Rank 3)
            [27089] = true, -- Spear Shards (Spear Shards - Rank 3)
            [27084] = true, -- Spear Shards (Spear Shards - Rank 3)
            [27086] = true, -- Spear Shards (Spear Shards - Rank 3)
            [27082] = true, -- Spear Shards (Spear Shards - Rank 3)
            [95937] = true, -- Spear Shards (Spear Shards - Rank 3)

            [27090] = true, -- Spear Shards (Spear Shards - Rank 4)
            [27092] = true, -- Spear Shards (Spear Shards - Rank 4)
            [95941] = true, -- Spear Shards (Spear Shards - Rank 4)
            [95942] = true, -- Spear Shards (Spear Shards - Rank 4)
            [27098] = true, -- Spear Shards (Spear Shards - Rank 4)
            [27093] = true, -- Spear Shards (Spear Shards - Rank 4)
            [27095] = true, -- Spear Shards (Spear Shards - Rank 4)
            [27091] = true, -- Spear Shards (Spear Shards - Rank 4)
            [95940] = true, -- Spear Shards (Spear Shards - Rank 4)

            [95928] = true, -- Holy Shards (Luminous Shards - All Ranks)
            [95927] = true, -- Holy Shards (Luminous Shards - All Ranks)
            [95926] = true, -- Holy Shards (Luminous Shards - All Ranks)
            [95925] = true, -- Holy Shards (Luminous Shards - All Ranks)
            [95924] = true, -- Spear Shards / Necrotic Orb CD (Luminous Shards - All Ranks)

            [26858] = true, -- Luminous Shards (Luminous Shards - Rank 1)
            [26860] = true, -- Luminous Shards (Luminous Shards - Rank 1)
            [95956] = true, -- Luminous Shards (Luminous Shards - Rank 1)
            [95957] = true, -- Luminous Shards (Luminous Shards - Rank 1)
            [26865] = true, -- Luminous Shards (Luminous Shards - Rank 1)
            [26861] = true, -- Luminous Shards (Luminous Shards - Rank 1)
            [26863] = true, -- Luminous Shards (Luminous Shards - Rank 1)
            [26859] = true, -- Luminous Shards (Luminous Shards - Rank 1)
            [95955] = true, -- Luminous Shards (Luminous Shards - Rank 1)

            [27102] = true, -- Luminous Shards (Luminous Shards - Rank 2)
            [27104] = true, -- Luminous Shards (Luminous Shards - Rank 2)
            [95960] = true, -- Luminous Shards (Luminous Shards - Rank 2)
            [95961] = true, -- Luminous Shards (Luminous Shards - Rank 2)
            [27110] = true, -- Luminous Shards (Luminous Shards - Rank 2)
            [27105] = true, -- Luminous Shards (Luminous Shards - Rank 2)
            [27107] = true, -- Luminous Shards (Luminous Shards - Rank 2)
            [27103] = true, -- Luminous Shards (Luminous Shards - Rank 2)
            [95959] = true, -- Luminous Shards (Luminous Shards - Rank 2)

            [27112] = true, -- Luminous Shards (Luminous Shards - Rank 3)
            [27114] = true, -- Luminous Shards (Luminous Shards - Rank 3)
            [95963] = true, -- Luminous Shards (Luminous Shards - Rank 3)
            [95964] = true, -- Luminous Shards (Luminous Shards - Rank 3)
            [27120] = true, -- Luminous Shards (Luminous Shards - Rank 3)
            [27115] = true, -- Luminous Shards (Luminous Shards - Rank 3)
            [27117] = true, -- Luminous Shards (Luminous Shards - Rank 3)
            [27113] = true, -- Luminous Shards (Luminous Shards - Rank 3)
            [95962] = true, -- Luminous Shards (Luminous Shards - Rank 3)

            [27122] = true, -- Luminous Shards (Luminous Shards - Rank 4)
            [27124] = true, -- Luminous Shards (Luminous Shards - Rank 4)
            [95966] = true, -- Luminous Shards (Luminous Shards - Rank 4)
            [95967] = true, -- Luminous Shards (Luminous Shards - Rank 4)
            [27130] = true, -- Luminous Shards (Luminous Shards - Rank 4)
            [27125] = true, -- Luminous Shards (Luminous Shards - Rank 4)
            [27127] = true, -- Luminous Shards (Luminous Shards - Rank 4)
            [27123] = true, -- Luminous Shards (Luminous Shards - Rank 4)
            [95965] = true, -- Luminous Shards (Luminous Shards - Rank 4)

            [26869] = true, -- Blazing Spear (Blazing Spear - Rank 1)
            [26878] = true, -- Blazing Spear (Blazing Spear - Rank 1)
            [44445] = true, -- Blazing Spear (Blazing Spear - Rank 1)
            [26880] = true, -- Blazing Spear (Blazing Spear - Rank 1)
            [26877] = true, -- Blazing Spear (Blazing Spear - Rank 1)
            [26872] = true, -- Blazing Spear (Blazing Spear - Rank 1)
            [26874] = true, -- Blazing Spear (Blazing Spear - Rank 1)
            [26871] = true, -- Blazing Spear (Blazing Spear - Rank 1)
            [26879] = true, -- Blazing Spear (Blazing Spear - Rank 1)

            [27145] = true, -- Blazing Spear (Blazing Spear - Rank 2)
            [27155] = true, -- Blazing Spear (Blazing Spear - Rank 2)
            [44448] = true, -- Blazing Spear (Blazing Spear - Rank 2)
            [27154] = true, -- Blazing Spear (Blazing Spear - Rank 2)
            [27153] = true, -- Blazing Spear (Blazing Spear - Rank 2)
            [27148] = true, -- Blazing Spear (Blazing Spear - Rank 2)
            [27150] = true, -- Blazing Spear (Blazing Spear - Rank 2)
            [27146] = true, -- Blazing Spear (Blazing Spear - Rank 2)
            [27147] = true, -- Blazing Spear (Blazing Spear - Rank 2)

            [27156] = true, -- Blazing Spear (Blazing Spear - Rank 3)
            [27166] = true, -- Blazing Spear (Blazing Spear - Rank 3)
            [44447] = true, -- Blazing Spear (Blazing Spear - Rank 3)
            [27165] = true, -- Blazing Spear (Blazing Spear - Rank 3)
            [27164] = true, -- Blazing Spear (Blazing Spear - Rank 3)
            [27159] = true, -- Blazing Spear (Blazing Spear - Rank 3)
            [27161] = true, -- Blazing Spear (Blazing Spear - Rank 3)
            [27157] = true, -- Blazing Spear (Blazing Spear - Rank 3)
            [27158] = true, -- Blazing Spear (Blazing Spear - Rank 3)

            [27167] = true, -- Blazing Spear (Blazing Spear - Rank 4)
            [27177] = true, -- Blazing Spear (Blazing Spear - Rank 4)
            [44449] = true, -- Blazing Spear (Blazing Spear - Rank 4)
            [27176] = true, -- Blazing Spear (Blazing Spear - Rank 4)
            [27175] = true, -- Blazing Spear (Blazing Spear - Rank 4)
            [27170] = true, -- Blazing Spear (Blazing Spear - Rank 4)
            [27172] = true, -- Blazing Spear (Blazing Spear - Rank 4)
            [27168] = true, -- Blazing Spear (Blazing Spear - Rank 4)
            [27169] = true, -- Blazing Spear (Blazing Spear - Rank 4)

            [22178] = true, -- Sun Shield (Sun Shield - Rank 1)
            [22179] = true, -- Sun Shield (Sun Shield - Rank 1)
            [26724] = true, -- Sun Shield Hit Bonus (Sun Shield - Rank 1)

            [27493] = true, -- Sun Shield (Sun Shield - Rank 2)
            [27496] = true, -- Sun Shield (Sun Shield - Rank 2)
            [27494] = true, -- Sun Shield Hit Bonus (Sun Shield - Rank 2)

            [27497] = true, -- Sun Shield (Sun Shield - Rank 3)
            [27500] = true, -- Sun Shield (Sun Shield - Rank 3)
            [27498] = true, -- Sun Shield Hit Bonus (Sun Shield - Rank 3)

            [27501] = true, -- Sun Shield (Sun Shield - Rank 4)
            [27504] = true, -- Sun Shield (Sun Shield - Rank 4)
            [27502] = true, -- Sun Shield Hit Bonus (Sun Shield - Rank 4)

            [22182] = true, -- Radiant Ward (Radiant Ward - Rank 1)
            [22183] = true, -- Radiant Ward (Radiant Ward - Rank 1)
            [26732] = true, -- Sun Shield Hit Bonus (Radiant Ward - Rank 1)

            [27506] = true, -- Radiant Ward (Radiant Ward - Rank 2)
            [27509] = true, -- Radiant Ward (Radiant Ward - Rank 2)
            [27507] = true, -- Sun Shield Hit Bonus (Radiant Ward - Rank 2)

            [27510] = true, -- Radiant Ward (Radiant Ward - Rank 3)
            [27513] = true, -- Radiant Ward (Radiant Ward - Rank 3)
            [27511] = true, -- Sun Shield Hit Bonus (Radiant Ward - Rank 3)

            [27514] = true, -- Radiant Ward (Radiant Ward - Rank 4)
            [27517] = true, -- Radiant Ward (Radiant Ward - Rank 4)
            [27515] = true, -- Sun Shield Hit Bonus (Radiant Ward - Rank 4)

            [22180] = true, -- Blazing Shield (Blazing Shield - Rank 1)
            [49091] = true, -- Blazing Shield (Blazing Shield - Rank 1)
            [49090] = true, -- Sun Shield Hit Bonus (Blazing Shield - Rank 1)
            [22184] = true, -- Blazing Shield (Blazing Shield - Rank 1)
            [60531] = true, -- Backlash (Blazing Shield - Rank 1)
            [22181] = true, -- Blazing Shield (Blazing Shield - Rank 1)

            [27520] = true, -- Blazing Shield (Blazing Shield - Rank 2)
            [49093] = true, -- Blazing Shield (Blazing Shield - Rank 2)
            [49092] = true, -- Sun Shield Hit Bonus (Blazing Shield - Rank 2)
            [27522] = true, -- Blazing Shield (Blazing Shield - Rank 2)
            [60532] = true, -- Backlash (Blazing Shield - Rank 2)
            [27521] = true, -- Blazing Shield (Blazing Shield - Rank 2)

            [27526] = true, -- Blazing Shield (Blazing Shield - Rank 3)
            [49095] = true, -- Blazing Shield (Blazing Shield - Rank 3)
            [49094] = true, -- Sun Shield Hit Bonus (Blazing Shield - Rank 3)
            [27528] = true, -- Blazing Shield (Blazing Shield - Rank 3)
            [60533] = true, -- Backlash (Blazing Shield - Rank 3)
            [27527] = true, -- Blazing Shield (Blazing Shield - Rank 3)

            [27530] = true, -- Blazing Shield (Blazing Shield - Rank 4)
            [49097] = true, -- Blazing Shield (Blazing Shield - Rank 4)
            [49096] = true, -- Sun Shield Hit Bonus (Blazing Shield - Rank 4)
            [27532] = true, -- Blazing Shield (Blazing Shield - Rank 4)
            [60534] = true, -- Backlash (Blazing Shield - Rank 4)
            [27531] = true, -- Blazing Shield (Blazing Shield - Rank 4)

            [22138] = true, -- Radial Sweep (Radial Sweep - Rank 1)
            [62593] = true, -- Radial Sweep (Radial Sweep - Rank 1)
            [62550] = true, -- Radial Sweep (Radial Sweep - Rank 1)

            [23782] = true, -- Radial Sweep (Radial Sweep - Rank 2)
            [62594] = true, -- Radial Sweep (Radial Sweep - Rank 2)
            [62553] = true, -- Radial Sweep (Radial Sweep - Rank 2)

            [23783] = true, -- Radial Sweep (Radial Sweep - Rank 3)
            [62595] = true, -- Radial Sweep (Radial Sweep - Rank 3)
            [62556] = true, -- Radial Sweep (Radial Sweep - Rank 3)

            [23784] = true, -- Radial Sweep (Radial Sweep - Rank 4)
            [62596] = true, -- Radial Sweep (Radial Sweep - Rank 4)
            [62557] = true, -- Radial Sweep (Radial Sweep - Rank 4)

            [22144] = true, -- Empowering Sweep (Empowering Sweep - Rank 1)
            [22146] = true, -- Empowering Sweep (Empowering Sweep - Rank 1)
            [22147] = true, -- Empowering Sweep (Empowering Sweep - Rank 1)
            [55214] = true, -- Empowering Sweep (Empowering Sweep - Rank 1)
            [62599] = true, -- Radial Sweep (Empowering Sweep - Rank 1)
            [62598] = true, -- Radial Sweep (Empowering Sweep - Rank 1)

            [23792] = true, -- Empowering Sweep (Empowering Sweep - Rank 2)
            [23796] = true, -- Empowering Sweep (Empowering Sweep - Rank 2)
            [23795] = true, -- Empowering Sweep (Empowering Sweep - Rank 2)
            [55750] = true, -- Empowering Sweep (Empowering Sweep - Rank 2)
            [62601] = true, -- Radial Sweep (Empowering Sweep - Rank 2)
            [62600] = true, -- Radial Sweep (Empowering Sweep - Rank 2)

            [23793] = true, -- Empowering Sweep (Empowering Sweep - Rank 3)
            [23799] = true, -- Empowering Sweep (Empowering Sweep - Rank 3)
            [23798] = true, -- Empowering Sweep Buff (Empowering Sweep - Rank 3)
            [55751] = true, -- Empowering Sweep (Empowering Sweep - Rank 3)
            [62603] = true, -- Radial Sweep (Empowering Sweep - Rank 3)
            [62602] = true, -- Radial Sweep (Empowering Sweep - Rank 3)

            [23794] = true, -- Empowering Sweep (Empowering Sweep - Rank 4)
            [23801] = true, -- Empowering Sweep (Empowering Sweep - Rank 4)
            [23800] = true, -- Empowering Sweep (Empowering Sweep - Rank 4)
            [55752] = true, -- Empowering Sweep (Empowering Sweep - Rank 4)
            [62605] = true, -- Radial Sweep (Empowering Sweep - Rank 4)
            [62604] = true, -- Radial Sweep (Empowering Sweep - Rank 4)

            [22139] = true, -- Crescent Sweep (Crescent Sweep - Rank 1)
            [22143] = true, -- Crescent Sweep (Crescent Sweep - Rank 1)
            [62607] = true, -- Radial Sweep (Crescent Sweep - Rank 1)
            [62606] = true, -- Radial Sweep (Crescent Sweep - Rank 1)

            [23785] = true, -- Crescent Sweep (Crescent Sweep - Rank 2)
            [23786] = true, -- Crescent Sweep (Crescent Sweep - Rank 2)
            [62609] = true, -- Radial Sweep (Crescent Sweep - Rank 2)
            [62608] = true, -- Radial Sweep (Crescent Sweep - Rank 2)

            [23787] = true, -- Crescent Sweep (Crescent Sweep - Rank 3)
            [23789] = true, -- Crescent Sweep (Crescent Sweep - Rank 3)
            [62611] = true, -- Radial Sweep (Crescent Sweep - Rank 3)
            [62610] = true, -- Radial Sweep (Crescent Sweep - Rank 3)

            [23788] = true, -- Crescent Sweep (Crescent Sweep - Rank 4)
            [23790] = true, -- Crescent Sweep (Crescent Sweep - Rank 4)
            [62613] = true, -- Radial Sweep (Crescent Sweep - Rank 4)
            [62612] = true, -- Radial Sweep (Crescent Sweep - Rank 4)

            [21726] = true, -- Sun Fire (Sun Fire - Rank 1)
            [21727] = true, -- Sun Fire (Sun Fire - Rank 1)
            [21728] = true, -- Sun Fire (Sun Fire - Rank 1)
            [62747] = true, -- Major Prophecy (Sun Fire - Rank 1)
            [24160] = true, -- Sun Fire (Sun Fire - Rank 2)
            [24161] = true, -- Sun Fire (Sun Fire - Rank 2)
            [24162] = true, -- Sun Fire (Sun Fire - Rank 2)
            [62748] = true, -- Major Prophecy (Sun Fire - Rank 2)
            [24167] = true, -- Sun Fire (Sun Fire - Rank 3)
            [24169] = true, -- Sun Fire (Sun Fire - Rank 3)
            [24170] = true, -- Sun Fire (Sun Fire - Rank 3)
            [62749] = true, -- Major Prophecy (Sun Fire - Rank 3)
            [24171] = true, -- Sun Fire (Sun Fire - Rank 4)
            [24172] = true, -- Sun Fire (Sun Fire - Rank 4)
            [24173] = true, -- Sun Fire (Sun Fire - Rank 4)
            [62750] = true, -- Major Prophecy (Sun Fire - Rank 4)

            [21729] = true, -- Vampire's Bane (Vampire's Bane - Rank 1)
            [21730] = true, -- Vampire's Bane (Vampire's Bane - Rank 1)
            [21731] = true, -- Vampire's Bane (Vampire's Bane - Rank 1)
            [62751] = true, -- Major Prophecy (Vampire's Bane - Rank 1)

            [24174] = true, -- Vampire's Bane (Vampire's Bane - Rank 2)
            [24175] = true, -- Vampire's Bane (Vampire's Bane - Rank 2)
            [24176] = true, -- Vampire's Bane (Vampire's Bane - Rank 2)
            [62752] = true, -- Major Prophecy (Vampire's Bane - Rank 2)

            [24177] = true, -- Vampire's Bane (Vampire's Bane - Rank 3)
            [24178] = true, -- Vampire's Bane (Vampire's Bane - Rank 3)
            [24179] = true, -- Vampire's Bane (Vampire's Bane - Rank 3)
            [62753] = true, -- Major Prophecy (Vampire's Bane - Rank 3)

            [24180] = true, -- Vampire's Bane (Vampire's Bane - Rank 4)
            [24181] = true, -- Vampire's Bane (Vampire's Bane - Rank 4)
            [24182] = true, -- Vampire's Bane (Vampire's Bane - Rank 4)
            [62754] = true, -- Major Prophecy (Vampire's Bane - Rank 4)

            [21732] = true, -- Reflective Light (Reflective Light - Rank 1)
            [21733] = true, -- Reflective Light (Reflective Light - Rank 1)
            [21734] = true, -- Reflective Light (Reflective Light - Rank 1)
            [62755] = true, -- Major Prophecy (Reflective Light - Rank 1)

            [24184] = true, -- Reflective Light (Reflective Light - Rank 2)
            [24185] = true, -- Reflective Light (Reflective Light - Rank 2)
            [24186] = true, -- Reflective Light (Reflective Light - Rank 2)
            [62756] = true, -- Major Prophecy (Reflective Light - Rank 2)

            [24187] = true, -- Reflective Light (Reflective Light - Rank 3)
            [24188] = true, -- Reflective Light (Reflective Light - Rank 3)
            [24189] = true, -- Reflective Light (Reflective Light - Rank 3)
            [62757] = true, -- Major Prophecy (Reflective Light - Rank 3)

            [24195] = true, -- Reflective Light (Reflective Light - Rank 4)
            [24196] = true, -- Reflective Light (Reflective Light - Rank 4)
            [24197] = true, -- Reflective Light (Reflective Light - Rank 4)
            [62758] = true, -- Major Prophecy (Reflective Light - Rank 4)

            [22057] = true, -- Solar Flare (Solar Flare - Rank 1)
            [24080] = true, -- Solar Flare (Solar Flare - Rank 2)
            [24101] = true, -- Solar Flare (Solar Flare - Rank 3)
            [24110] = true, -- Solar Flare (Solar Flare - Rank 4)

            [22110] = true, -- Dark Flare (Dark Flare - Rank 1)
            [63008] = true, -- Dark Flare Trauma (Dark Flare - Rank 1)
            [24686] = true, -- Major Defile (Dark Flare - Rank 1)

            [24129] = true, -- Dark Flare (Dark Flare - Rank 2)
            [63009] = true, -- Dark Flare Trauma (Dark Flare - Rank 2)
            [24702] = true, -- Major Defile (Dark Flare - Rank 2)

            [24139] = true, -- Dark Flare (Dark Flare - Rank 3)
            [63010] = true, -- Dark Flare Trauma (Dark Flare - Rank 3)
            [24703] = true, -- Major Defile (Dark Flare - Rank 3)

            [24147] = true, -- Dark Flare (Dark Flare - Rank 4)
            [63011] = true, -- Dark Flare Trauma (Dark Flare - Rank 4)
            [24153] = true, -- Major Defile (Dark Flare - Rank 4)

            [22095] = true, -- Solar Barrage (Solar Barrage - Rank 1)
            [100223] = true, -- Solar Barrage (Solar Barrage - Rank 1)
            [100218] = true, -- Solar Barrage (Solar Barrage - Rank 1)

            [24155] = true, -- Solar Barrage (Solar Barrage - Rank 2)
            [100224] = true, -- Solar Barrage (Solar Barrage - Rank 2)
            [100225] = true, -- Solar Barrage (Solar Barrage - Rank 2)

            [24156] = true, -- Solar Barrage (Solar Barrage - Rank 3)
            [100226] = true, -- Solar Barrage (Solar Barrage - Rank 3)
            [100227] = true, -- Solar Barrage (Solar Barrage - Rank 3)

            [24157] = true, -- Solar Barrage (Solar Barrage - Rank 4)
            [100228] = true, -- Solar Barrage (Solar Barrage - Rank 4)
            [100229] = true, -- Solar Barrage (Solar Barrage - Rank 4)

            [21761] = true, -- Backlash (Backlash - Rank 1)
            [22643] = true, -- Backlash D (Backlash - Rank 1)
            [89821] = true, -- Backlash (Backlash - Rank 1)
            [26411] = true, -- Backlash (Backlash - Rank 1)

            [27211] = true, -- Backlash (Backlash - Rank 2)
            [27214] = true, -- Backlash (Backlash - Rank 2)
            [89822] = true, -- Backlash (Backlash - Rank 2)
            [27217] = true, -- Backlash (Backlash - Rank 2)

            [27219] = true, -- Backlash (Backlash - Rank 3)
            [27222] = true, -- Backlash (Backlash - Rank 3)
            [89823] = true, -- Backlash (Backlash - Rank 3)
            [27225] = true, -- Backlash (Backlash - Rank 3)

            [27227] = true, -- Backlash (Backlash - Rank 4)
            [27228] = true, -- Backlash (Backlash - Rank 4)
            [89824] = true, -- Backlash (Backlash - Rank 4)
            [27233] = true, -- Backlash (Backlash - Rank 4)

            [69168] = true, -- Purifying Light Heal FX (Purifying Light - All Ranks)

            [21765] = true, -- Purifying Light (Purifying Light - Rank 1)
            [25802] = true, -- Purifying Light (Purifying Light - Rank 1)
            [89825] = true, -- Purifying Light (Purifying Light - Rank 1)
            [27544] = true, -- Purifying Light (Purifying Light - Rank 1)
            [68581] = true, -- Purifying Light Tick (Purifying Light - Rank 1)
            [21908] = true, -- Purifying Light (Purifying Light - Rank 1)

            [27534] = true, -- Purifying Light (Purifying Light - Rank 2)
            [27535] = true, -- Purifying Light (Purifying Light - Rank 2)
            [89826] = true, -- Purifying Light (Purifying Light - Rank 2)
            [27546] = true, -- Purifying Light (Purifying Light - Rank 2)
            [68586] = true, -- Purifying Light Tick (Purifying Light - Rank 2)
            [27537] = true, -- Purifying Light (Purifying Light - Rank 2)

            [27549] = true, -- Purifying Light (Purifying Light - Rank 3)
            [27550] = true, -- Purifying Light (Purifying Light - Rank 3)
            [89827] = true, -- Purifying Light (Purifying Light - Rank 3)
            [27556] = true, -- Purifying Light (Purifying Light - Rank 3)
            [68587] = true, -- Purifying Light Tick (Purifying Light - Rank 3)
            [27553] = true, -- Purifying Light (Purifying Light - Rank 3)

            [27558] = true, -- Purifying Light (Purifying Light - Rank 4)
            [27559] = true, -- Purifying Light (Purifying Light - Rank 4)
            [89684] = true, -- Purifying Light (Purifying Light - Rank 4)
            [27565] = true, -- Purifying Light (Purifying Light - Rank 4)
            [68582] = true, -- Purifying Light Tick (Purifying Light - Rank 4)
            [27562] = true, -- Purifying Light (Purifying Light - Rank 4)

            [21763] = true, -- Power of the Light (Power of the Light - Rank 1)
            [64144] = true, -- Minor Fracture (Power of the Light - Rank 1)
            [68588] = true, -- Minor Breach (Power of the Light - Rank 1)
            [25799] = true, -- Power of the Light (Power of the Light - Rank 1)
            [89828] = true, -- Power of the Light (Power of the Light - Rank 1)
            [27567] = true, -- Power of the Light (Power of the Light - Rank 1)

            [27569] = true, -- Power of the Light (Power of the Light - Rank 2)
            [64145] = true, -- Minor Fracture (Power of the Light - Rank 2)
            [68592] = true, -- Minor Breach (Power of the Light - Rank 2)
            [27570] = true, -- Power of the Light (Power of the Light - Rank 2)
            [89829] = true, -- Power of the Light (Power of the Light - Rank 2)
            [27576] = true, -- Power of the Light (Power of the Light - Rank 2)

            [27578] = true, -- Power of the Light (Power of the Light - Rank 3)
            [64146] = true, -- Minor Fracture (Power of the Light - Rank 3)
            [68591] = true, -- Minor Breach (Power of the Light - Rank 3)
            [27579] = true, -- Power of the Light (Power of the Light - Rank 3)
            [89830] = true, -- Power of the Light (Power of the Light - Rank 3)
            [27585] = true, -- Power of the Light (Power of the Light - Rank 3)

            [27587] = true, -- Power of the Light (Power of the Light - Rank 4)
            [64147] = true, -- Minor Fracture (Power of the Light - Rank 4)
            [68589] = true, -- Minor Breach (Power of the Light - Rank 4)
            [27588] = true, -- Power of the Light (Power of the Light - Rank 4)
            [89716] = true, -- Power of the Light (Power of the Light - Rank 4)
            [27594] = true, -- Power of the Light (Power of the Light - Rank 4)

            [21776] = true, -- Eclipse (Eclipse - Rank 1)
            [68657] = true, -- Eclipse (Eclipse - Rank 1)
            [27303] = true, -- Eclipse (Eclipse - Rank 2)
            [68695] = true, -- Eclipse (Eclipse - Rank 2)
            [27304] = true, -- Eclipse (Eclipse - Rank 3)
            [68701] = true, -- Eclipse (Eclipse - Rank 3)
            [27306] = true, -- Eclipse (Eclipse - Rank 4)
            [68708] = true, -- Eclipse (Eclipse - Rank 4)

            [22006] = true, -- Total Dark (Total Dark - Rank 1)
            [63083] = true, -- Total Dark (Total Dark - Rank 1)
            [68729] = true, -- Total Dark (Total Dark - Rank 1)
            [27313] = true, -- Total Dark (Total Dark - Rank 2)
            [63096] = true, -- Total Dark (Total Dark - Rank 2)
            [68742] = true, -- Total Dark (Total Dark - Rank 2)
            [27316] = true, -- Total Dark (Total Dark - Rank 3)
            [63097] = true, -- Total Dark (Total Dark - Rank 3)
            [68748] = true, -- Total Dark (Total Dark - Rank 3)
            [27324] = true, -- Total Dark (Total Dark - Rank 4)
            [63098] = true, -- Total Dark (Total Dark - Rank 4)
            [68757] = true, -- Total Dark (Total Dark - Rank 4)

            [22004] = true, -- Unstable Core (Unstable Core - Rank 1)
            [100211] = true, -- Eclipse Trigger (Unstable Core - Rank 1)
            [100210] = true, -- Eclipse (Unstable Core - Rank 1)
            [22005] = true, -- Unstable Core (Unstable Core - Rank 1)
            [27307] = true, -- Unstable Core (Unstable Core - Rank 2)
            [100213] = true, -- Eclipse Trigger (Unstable Core - Rank 2)
            [100212] = true, -- Eclipse (Unstable Core - Rank 2)
            [27308] = true, -- Unstable Core (Unstable Core - Rank 2)
            [27309] = true, -- Unstable Core (Unstable Core - Rank 3)
            [100215] = true, -- Eclipse Trigger (Unstable Core - Rank 3)
            [100214] = true, -- Eclipse (Unstable Core - Rank 3)
            [27310] = true, -- Unstable Core (Unstable Core - Rank 3)
            [27311] = true, -- Unstable Core (Unstable Core - Rank 4)
            [100217] = true, -- Eclipse Trigger (Unstable Core - Rank 4)
            [100216] = true, -- Eclipse (Unstable Core - Rank 4)
            [27312] = true, -- Unstable Core (Unstable Core - Rank 4)

            [63029] = true, -- Radiant Destruction (Radiant Destruction - Rank 1)
            [63952] = true, -- Radiant Destruction (Radiant Destruction - Rank 1)
            [63054] = true, -- Radiant Destruction (Radiant Destruction - Rank 2)
            [63953] = true, -- Radiant Destruction (Radiant Destruction - Rank 2)
            [63056] = true, -- Radiant Destruction (Radiant Destruction - Rank 3)
            [63954] = true, -- Radiant Destruction (Radiant Destruction - Rank 3)
            [63058] = true, -- Radiant Destruction (Radiant Destruction - Rank 4)
            [63955] = true, -- Radiant Destruction (Radiant Destruction - Rank 4)

            [69119] = true, -- Radiant Test! (Radiant Glory - Rank 1)
            [63044] = true, -- Radiant Glory (Radiant Glory - Rank 1)
            [69118] = true, -- Radiant Glory Heal (Radiant Glory - Rank 1)
            [63956] = true, -- Radiant Destruction (Radiant Glory - Rank 1)
            [69126] = true, -- Radiant Test! (Radiant Glory - Rank 2)
            [63060] = true, -- Radiant Glory (Radiant Glory - Rank 2)
            [69125] = true, -- Radiant Glory Heal (Radiant Glory - Rank 2)
            [63957] = true, -- Radiant Destruction (Radiant Glory - Rank 2)
            [69124] = true, -- Radiant Test! (Radiant Glory - Rank 3)
            [63063] = true, -- Radiant Glory (Radiant Glory - Rank 3)
            [69123] = true, -- Radiant Glory Heal (Radiant Glory - Rank 3)
            [63959] = true, -- Radiant Destruction (Radiant Glory - Rank 3)
            [69122] = true, -- Radiant Test! (Radiant Glory - Rank 4)
            [63066] = true, -- Radiant Glory (Radiant Glory - Rank 4)
            [69121] = true, -- Radiant Glory Heal (Radiant Glory - Rank 4)
            [63960] = true, -- Radiant Destruction (Radiant Glory - Rank 4)

            [63046] =  true, -- Radiant Oppression (Radiant Oppression - Rank 1)
            [104549] =  true, -- Radiant Oppression (Radiant Oppression - Rank 1)
            [63961] =  true, -- Radiant Destruction (Radiant Oppression - Rank 1)
            [63069] =  true, -- Radiant Oppression (Radiant Oppression - Rank 2)
            [104552] =  true, -- Radiant Oppression (Radiant Oppression - Rank 2)
            [63962] =  true, -- Radiant Destruction (Radiant Oppression - Rank 2)
            [63072] =  true, -- Radiant Oppression (Radiant Oppression - Rank 3)
            [104553] =  true, -- Radiant Oppression (Radiant Oppression - Rank 3)
            [63963] =  true, -- Radiant Destruction (Radiant Oppression - Rank 3)
            [63075] =  true, -- Radiant Oppression (Radiant Oppression - Rank 4)
            [104554] =  true, -- Radiant Oppression (Radiant Oppression - Rank 4)
            [63964] =  true, -- Radiant Destruction (Radiant Oppression - Rank 4)

            [48939] = true, -- Supernova (Nova - All Ranks)
            [31540] = true, -- Supernova (Nova - All Ranks)
            [31562] = true, -- Supernova (Nova - All Ranks)
            [102770] = true, -- Supernova Area Effect (Nova - All Ranks)

            [21752] = true, -- Nova (Nova - Rank 1)
            [21995] = true, -- Nova (Nova - Rank 1)
            [21976] = true, -- Nova (Nova - Rank 1)
            [21753] = true, -- Nova (Nova - Rank 1)
            [21754] = true, -- Nova (Nova - Rank 1)
            [102755] = true, -- Supernova Synergy Anchor (Nova - Rank 1)
            [31537] = true, -- Super Nova (Nova - Rank 1)

            [24044] = true, -- Nova (Nova - Rank 2)
            [24046] = true, -- Nova (Nova - Rank 2)
            [24048] = true, -- Nova (Nova - Rank 2)
            [24047] = true, -- Nova (Nova - Rank 2)
            [24045] = true, -- Nova (Nova - Rank 2)
            [102773] = true, -- Supernova Synergy Anchor (Nova - Rank 2)
            [31588] = true, -- Super Nova (Nova - Rank 2)

            [24052] = true, -- Nova (Nova - Rank 3)
            [24057] = true, -- Nova (Nova - Rank 3)
            [24059] = true, -- Nova (Nova - Rank 3)
            [24058] = true, -- Nova (Nova - Rank 3)
            [24056] = true, -- Nova (Nova - Rank 3)
            [102774] = true, -- Supernova Synergy Anchor (Nova - Rank 3)
            [31589] = true, -- Super Nova (Nova - Rank 3)

            [24063] = true, -- Nova (Nova - Rank 4)
            [24065] = true, -- Nova (Nova - Rank 4)
            [24067] = true, -- Nova (Nova - Rank 4)
            [24066] = true, -- Nova (Nova - Rank 4)
            [24064] = true, -- Nova (Nova - Rank 4)
            [102775] = true, -- Supernova Synergy Anchor (Nova - Rank 4)
            [31590] = true, -- Super Nova (Nova - Rank 4)

            [48938] = true, -- Gravity Crush (Solar Prison - All Ranks)
            [31603] = true, -- Gravity Crush (Solar Prison - All Ranks)
            [31604] = true, -- Gravity Crush (Solar Prison - All Ranks)
            [34443] = true, -- Gravity Crush (Solar Prison - All Ranks)
            [102782] = true, -- Gravity Crush (Solar Prison - All Ranks)

            [21755] = true, -- Solar Prison (Solar Prison - Rank 1)
            [22002] = true, -- Solar Prison (Solar Prison - Rank 1)
            [22003] = true, -- Solar Prison (Solar Prison - Rank 1)
            [21756] = true, -- Solar Prison (Solar Prison - Rank 1)
            [21757] = true, -- Solar Prison (Solar Prison - Rank 1)
            [102780] = true, -- Supernova Synergy Anchor (Solar Prison - Rank 1)
            [31598] = true, -- Super Nova (Solar Prison - Rank 1)

            [24288] = true, -- Solar Prison (Solar Prison - Rank 2)
            [24290] = true, -- Solar Prison (Solar Prison - Rank 2)
            [24293] = true, -- Solar Prison (Solar Prison - Rank 2)
            [24291] = true, -- Solar Prison (Solar Prison - Rank 2)
            [24289] = true, -- Solar Prison (Solar Prison - Rank 2)
            [102783] = true, -- Supernova Synergy Anchor (Solar Prison - Rank 2)
            [31599] = true, -- Super Nova (Solar Prison - Rank 2)

            [24295] = true, -- Solar Prison (Solar Prison - Rank 3)
            [24297] = true, -- Solar Prison (Solar Prison - Rank 3)
            [24300] = true, -- Solar Prison (Solar Prison - Rank 3)
            [24298] = true, -- Solar Prison (Solar Prison - Rank 3)
            [24296] = true, -- Solar Prison (Solar Prison - Rank 3)
            [102784] = true, -- Supernova Synergy Anchor (Solar Prison - Rank 3)
            [31600] = true, -- Super Nova (Solar Prison - Rank 3)

            [24301] = true, -- Solar Prison (Solar Prison - Rank 4)
            [24303] = true, -- Solar Prison (Solar Prison - Rank 4)
            [24306] = true, -- Solar Prison (Solar Prison - Rank 4)
            [24304] = true, -- Solar Prison (Solar Prison - Rank 4)
            [24302] = true, -- Solar Prison (Solar Prison - Rank 4)
            [102785] = true, -- Supernova Synergy Anchor (Solar Prison - Rank 4)
            [31601] = true, -- Super Nova (Solar Prison - Rank 4)

            [21758] = true, -- Solar Disturbance (Solar Disturbance - Rank 1)
            [22000] = true, -- Solar Disturbance (Solar Disturbance - Rank 1)
            [22001] = true, -- Solar Disturbance (Solar Disturbance - Rank 1)
            [21759] = true, -- Solar Disturbance (Solar Disturbance - Rank 1)
            [21760] = true, -- Solar Disturbance (Solar Disturbance - Rank 1)
            [24307] = true, -- Solar Disturbance Snare (Solar Disturbance - Rank 1)
            [102776] = true, -- Supernova Synergy Anchor (Solar Disturbance - Rank 1)
            [31597] = true, -- Super Nova (Solar Disturbance - Rank 1)

            [24308] = true, -- Solar Disturbance (Solar Disturbance - Rank 2)
            [24310] = true, -- Solar Disturbance (Solar Disturbance - Rank 2)
            [24312] = true, -- Solar Disturbance (Solar Disturbance - Rank 2)
            [24311] = true, -- Solar Disturbance (Solar Disturbance - Rank 2)
            [24313] = true, -- Solar Disturbance (Solar Disturbance - Rank 2)
            [24309] = true, -- Solar Disturbance Snare (Solar Disturbance - Rank 2)
            [102777] = true, -- Supernova Synergy Anchor (Solar Disturbance - Rank 2)
            [31596] = true, -- Super Nova (Solar Disturbance - Rank 2)

            [24314] = true, -- Solar Disturbance (Solar Disturbance - Rank 3)
            [24316] = true, -- Solar Disturbance (Solar Disturbance - Rank 3)
            [24318] = true, -- Solar Disturbance (Solar Disturbance - Rank 3)
            [24317] = true, -- Solar Disturbance (Solar Disturbance - Rank 3)
            [24319] = true, -- Solar Disturbance (Solar Disturbance - Rank 3)
            [24315] = true, -- Solar Disturbance Snare (Solar Disturbance - Rank 3)
            [102778] = true, -- Supernova Synergy Anchor (Solar Disturbance - Rank 3)
            [31595] = true, -- Super Nova (Solar Disturbance - Rank 3)

            [24320] = true, -- Solar Disturbance (Solar Disturbance - Rank 4)
            [24322] = true, -- Solar Disturbance (Solar Disturbance - Rank 4)
            [24324] = true, -- Solar Disturbance (Solar Disturbance - Rank 4)
            [24323] = true, -- Solar Disturbance (Solar Disturbance - Rank 4)
            [24325] = true, -- Solar Disturbance (Solar Disturbance - Rank 4)
            [24321] = true, -- Solar Disturbance Snare (Solar Disturbance - Rank 4)
            [102779] = true, -- Supernova Synergy Anchor (Solar Disturbance - Rank 4)
            [31591] = true, -- Super Nova (Solar Disturbance - Rank 4)

            [22250] = true, -- Rushed Ceremony (Rushed Ceremony - Rank 1)
            [24198] = true, -- Rushed Ceremony (Rushed Ceremony - Rank 2)
            [24201] = true, -- Rushed Ceremony (Rushed Ceremony - Rank 3)
            [24204] = true, -- Rushed Ceremony (Rushed Ceremony - Rank 4)

            [22253] = true, -- Honor the Dead (Honor the Dead - Rank 1)
            [35632] = true, -- Honor the Dead (Honor the Dead - Rank 1)
            [24207] = true, -- Honor the Dead (Honor the Dead - Rank 2)
            [35641] = true, -- Honor the Dead (Honor the Dead - Rank 2)
            [24210] = true, -- Honor the Dead (Honor the Dead - Rank 3)
            [35642] = true, -- Honor the Dead (Honor the Dead - Rank 3)
            [24213] = true, -- Honor the Dead (Honor the Dead - Rank 4)
            [35643] = true, -- Honor the Dead (Honor the Dead - Rank 4)

            [22256] = true, -- Breath of Life (Breath of Life - Rank 1)
            [44391] = true, -- Breath of Life (Breath of Life - Rank 1)
            [24216] = true, -- Breath of Life (Breath of Life - Rank 2)
            [44392] = true, -- Breath of Life (Breath of Life - Rank 2)
            [24219] = true, -- Breath of Life (Breath of Life - Rank 3)
            [44393] = true, -- Breath of Life (Breath of Life - Rank 3)
            [24222] = true, -- Breath of Life (Breath of Life - Rank 4)
            [44394] = true, -- Breath of Life (Breath of Life - Rank 4)

            [22304] = true, -- Healing Ritual (Healing Ritual - Rank 1)
            [22307] = true, -- Healing Ritual (Healing Ritual - Rank 1)
            [27334] = true, -- Healing Ritual (Healing Ritual - Rank 2)
            [27335] = true, -- Healing Ritual (Healing Ritual - Rank 2)
            [27340] = true, -- Healing Ritual (Healing Ritual - Rank 3)
            [27341] = true, -- Healing Ritual (Healing Ritual - Rank 3)
            [27342] = true, -- Healing Ritual (Healing Ritual - Rank 4)
            [27343] = true, -- Healing Ritual (Healing Ritual - Rank 4)

            [22327] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 1)
            [22331] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 1)
            [88456] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 1)
            [27346] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 2)
            [27348] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 2)
            [88457] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 2)
            [27349] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 3)
            [27351] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 3)
            [88458] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 3)
            [27352] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 4)
            [27354] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 4)
            [88459] = true, -- Ritual of Rebirth (Ritual of Rebirth - Rank 4)

            [22314] = true, -- Hasty Prayer (Hasty Prayer - Rank 1)
            [22318] = true, -- Hasty Prayer (Hasty Prayer - Rank 1)
            [27368] = true, -- Hasty Prayer (Hasty Prayer - Rank 2)
            [27371] = true, -- Hasty Prayer (Hasty Prayer - Rank 2)
            [27372] = true, -- Hasty Prayer (Hasty Prayer - Rank 3)
            [27375] = true, -- Hasty Prayer (Hasty Prayer - Rank 3)
            [27376] = true, -- Hasty Prayer (Hasty Prayer - Rank 4)
            [27379] = true, -- Hasty Prayer (Hasty Prayer - Rank 4)

            [26207] = true, -- Restoring Aura Passive (Restoring Aura - All Ranks)
            [26213] = true, -- Minor Fortitude (Restoring Aura - All Ranks)
            [26216] = true, -- Minor Intellect (Restoring Aura - All Ranks)
            [26215] = true, -- Minor Endurance (Restoring Aura - All Ranks)

            [26209] = true, -- Restoring Aura (Restoring Aura - Rank 1)
            [26220] = true, -- Minor Magickasteal (Restoring Aura - Rank 1)
            [88472] = true, -- Minor Magickasteal (Restoring Aura - Rank 1)

            [26995] = true, -- Restoring Aura (Restoring Aura - Rank 2)
            [26999] = true, -- Minor Magickasteal (Restoring Aura - Rank 2)
            [88479] = true, -- Minor Magickasteal (Restoring Aura - Rank 2)

            [27001] = true, -- Restoring Aura (Restoring Aura - Rank 3)
            [27005] = true, -- Minor Magickasteal (Restoring Aura - Rank 3)
            [88482] = true, -- Minor Magickasteal (Restoring Aura - Rank 3)

            [27007] = true, -- Restoring Aura (Restoring Aura - Rank 4)
            [27011] = true, -- Minor Magickasteal (Restoring Aura - Rank 4)
            [88484] = true, -- Minor Magickasteal (Restoring Aura - Rank 4)

            [26807] = true, -- Radiant Aura (Radiant Aura - Rank 1)
            [26809] = true, -- Minor Magickasteal (Radiant Aura - Rank 1)
            [88486] = true, -- Minor Magickasteal (Radiant Aura - Rank 1)

            [27013] = true, -- Radiant Aura (Radiant Aura - Rank 2)
            [27020] = true, -- Minor Magickasteal (Radiant Aura - Rank 2)
            [88487] = true, -- Minor Magickasteal (Radiant Aura - Rank 2)

            [27024] = true, -- Radiant Aura (Radiant Aura - Rank 3
            [27026] = true, -- Minor Magickasteal (Radiant Aura - Rank 3)
            [88488] = true, -- Minor Magickasteal (Radiant Aura - Rank 3)

            [27030] = true, -- Radiant Aura (Radiant Aura - Rank 4
            [27032] = true, -- Minor Magickasteal (Radiant Aura - Rank 4)
            [88489] = true, -- Minor Magickasteal (Radiant Aura - Rank 4)

            [26821] = true, -- Repentance (Repentance - Rank 1)
            [34366] = true, -- Repentance (Repentance - Rank 1)
            [26823] = true, -- Repentance Magicka Restore (Repentance - Rank 1)
            [26824] = true, -- Repentance Heal (Repentance - Rank 1)

            [27036] = true, -- Repentance (Repentance - Rank 2)
            [34369] = true, -- Repentance (Repentance - Rank 2)
            [27037] = true, -- Repentance Magicka Restore (Repentance - Rank 2)
            [27038] = true, -- Repentance Heal (Repentance - Rank 2)

            [27040] = true, -- Repentance (Repentance - Rank 3)
            [34370] = true, -- Repentance (Repentance - Rank 3)
            [27041] = true, -- Repentance Magicka Restore (Repentance - Rank 3)
            [27042] = true, -- Repentance Heal (Repentance - Rank 3)

            [27043] = true, -- Repentance (Repentance - Rank 4)
            [34371] = true, -- Repentance (Repentance - Rank 4)
            [27044] = true, -- Repentance Magicka Restore (Repentance - Rank 4)
            [27045] = true, -- Repentance Heal (Repentance - Rank 4)

            [22270] = true, -- Purify (Cleansing Ritual - All Ranks)
            [44013] = true, -- Purify (Cleansing Ritual - All Ranks)
            [22265] = true, -- Cleansing Ritual (Cleansing Ritual - Rank 1)
            [26286] = true, -- Healing Ritual (Cleansing Ritual - Rank 1)
            [26290] = true, -- Clensing Ritual Dummy (Cleansing Ritual - Rank 1)
            [26287] = true, -- Healing Ritual (Cleansing Ritual - Rank 1)
            [80540] = true, -- Cleansing Ritual (Cleansing Ritual - Rank 1)
            [26295] = true, -- Purify (Cleansing Ritual - Rank 1)

            [27243] = true, -- Cleansing Ritual (Cleansing Ritual - Rank 2)
            [27245] = true, -- Healing Ritual (Cleansing Ritual - Rank 2)
            [27246] = true, -- Clensing Ritual Dummy (Cleansing Ritual - Rank 2)
            [27248] = true, -- Healing Ritual (Cleansing Ritual - Rank 2)
            [80541] = true, -- Cleansing Ritual (Cleansing Ritual - Rank 2)
            [27247] = true, -- Purify (Cleansing Ritual - Rank 2)

            [27249] = true, -- Cleansing Ritual (Cleansing Ritual - Rank 3)
            [27250] = true, -- Healing Ritual (Cleansing Ritual - Rank 3)
            [27252] = true, -- Clensing Ritual Dummy (Cleansing Ritual - Rank 3)
            [27254] = true, -- Healing Ritual (Cleansing Ritual - Rank 3)
            [80543] = true, -- Cleansing Ritual (Cleansing Ritual - Rank 3)
            [27253] = true, -- Purify (Cleansing Ritual - Rank 3)

            [27255] = true, -- Cleansing Ritual (Cleansing Ritual - Rank 4)
            [27256] = true, -- Healing Ritual (Cleansing Ritual - Rank 4)
            [27258] = true, -- Clensing Ritual Dummy (Cleansing Ritual - Rank 4)
            [27260] = true, -- Healing Ritual (Cleansing Ritual - Rank 4)
            [80546] = true, -- Cleansing Ritual (Cleansing Ritual - Rank 4)
            [27259] = true, -- Purify (Cleansing Ritual - Rank 4)

            [22259] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
            [26298] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
            [80172] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
            [26299] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
            [26301] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
            [80547] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 1)
            [26300] = true, -- Purify (Ritual of Retribution - Rank 1)

            [27261] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 2)
            [27262] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 2)
            [80174] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 2)
            [27265] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 2)
            [27267] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 2)
            [80550] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 2)
            [27266] = true, -- Purify (Ritual of Retribution - Rank 2)

            [27269] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 3)
            [27270] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 3)
            [80175] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 3)
            [27272] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 3)
            [27274] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 3)
            [80551] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 3)
            [27273] = true, -- Purify (Ritual of Retribution - Rank 3)

            [27275] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 4)
            [27276] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 4)
            [80176] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 4)
            [27278] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 4)
            [27280] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 4)
            [80552] = true, -- Ritual of Retribution (Ritual of Retribution - Rank 4)
            [27279] = true, -- Purify (Ritual of Retribution - Rank 4)

            [22262] = true, -- Extended Ritual (Extended Ritual - Rank 1)
            [26303] = true, -- Extended Ritual (Extended Ritual - Rank 1)
            [26304] = true, -- Clensing Ritual Dummy (Extended Ritual - Rank 1)
            [26306] = true, -- Extended Ritual (Extended Ritual - Rank 1)
            [80553] = true, -- Extended Ritual (Extended Ritual - Rank 1)
            [26305] = true, -- Purify (Extended Ritual - Rank 1)

            [27281] = true, -- Extended Ritual (Extended Ritual - Rank 2)
            [27282] = true, -- Extended Ritual (Extended Ritual - Rank 2)
            [27284] = true, -- Clensing Ritual Dummy (Extended Ritual - Rank 2)
            [27286] = true, -- Extended Ritual (Extended Ritual - Rank 2)
            [80555] = true, -- Extended Ritual (Extended Ritual - Rank 2)
            [27285] = true, -- Purify (Extended Ritual - Rank 2)

            [27288] = true, -- Extended Ritual (Extended Ritual - Rank 3)
            [27289] = true, -- Extended Ritual (Extended Ritual - Rank 3)
            [27291] = true, -- Clensing Ritual Dummy (Extended Ritual - Rank 3)
            [27293] = true, -- Extended Ritual (Extended Ritual - Rank 3)
            [80556] = true, -- Extended Ritual (Extended Ritual - Rank 3)
            [27292] = true, -- Purify (Extended Ritual - Rank 3)

            [27295] = true, -- Extended Ritual (Extended Ritual - Rank 4)
            [27296] = true, -- Extended Ritual (Extended Ritual - Rank 4)
            [27298] = true, -- Clensing Ritual Dummy (Extended Ritual - Rank 4)
            [27300] = true, -- Extended Ritual (Extended Ritual - Rank 4)
            [80557] = true, -- Extended Ritual (Extended Ritual - Rank 4)
            [27299] = true, -- Purify (Extended Ritual - Rank 4)

            [22223] = true, -- Rite of Passage (Rite of Passage - Rank 1)
            [22225] = true, -- Rite of Passage (Rite of Passage - Rank 1)
            [26380] = true, -- Rite of Passage Self Snare (Rite of Passage - Rank 1)
            [27388] = true, -- Rite of Passage (Rite of Passage - Rank 2)
            [27390] = true, -- Rite of Passage (Rite of Passage - Rank 2)
            [27391] = true, -- Rite of Passage Self Snare (Rite of Passage - Rank 2)
            [27392] = true, -- Rite of Passage (Rite of Passage - Rank 3)
            [27394] = true, -- Rite of Passage (Rite of Passage - Rank 3)
            [27395] = true, -- Rite of Passage Self Snare (Rite of Passage - Rank 3)
            [27396] = true, -- Rite of Passage (Rite of Passage - Rank 4)
            [27398] = true, -- Rite of Passage (Rite of Passage - Rank 4)
            [27399] = true, -- Rite of Passage Self Snare (Rite of Passage - Rank 4)

            [101649] = true, -- Rune Focus (Rune Focus - All Ranks)

            [22236] = true, -- Major Resolve (Rune Focus - Rank 1)
            [44820] = true, -- Major Ward (Rune Focus - Rank 1)
            [22234] = true, -- Rune Focus (Rune Focus - Rank 1)
            [33516] = true, -- Summon Shade (Rune Focus - Rank 1)

            [44822] = true, -- Major Resolve (Rune Focus - Rank 2)
            [44821] = true, -- Major Ward (Rune Focus - Rank 2)
            [23968] = true, -- Rune Focus (Rune Focus - Rank 2)
            [33520] = true, -- Summon Shade (Rune Focus - Rank 2)

            [44824] = true, -- Major Resolve (Rune Focus - Rank 3)
            [44823] = true, -- Major Ward (Rune Focus - Rank 3)
            [23969] = true, -- Rune Focus (Rune Focus - Rank 3)
            [33519] = true, -- Summon Shade (Rune Focus - Rank 3)

            [44826] = true, -- Major Resolve (Rune Focus - Rank 4)
            [44825] = true, -- Major Ward (Rune Focus - Rank 4)
            [23970] = true, -- Rune Focus (Rune Focus - Rank 4)
            [33518] = true, -- Summon Shade (Rune Focus - Rank 4)

            [44828] = true, -- Major Resolve (Channeled Focus - Rank 1)
            [44827] = true, -- Major Ward (Channeled Focus - Rank 1)
            [22240] = true, -- Channeled Focus (Channeled Focus - Rank 1)
            [33524] = true, -- Summon Shade (Channeled Focus - Rank 1)
            [37009] = true, -- Channeled Focus (Channeled Focus - Rank 1)

            [44830] = true, -- Major Resolve (Channeled Focus - Rank 2)
            [44829] = true, -- Major Ward (Channeled Focus - Rank 2)
            [23996] = true, -- Channeled Focus (Channeled Focus - Rank 2)
            [33523] = true, -- Summon Shade (Channeled Focus - Rank 2)
            [37023] = true, -- Channeled Focus (Channeled Focus - Rank 2)

            [44832] = true, -- Major Resolve (Channeled Focus - Rank 3)
            [44831] = true, -- Major Ward (Channeled Focus - Rank 3)
            [23997] = true, -- Channeled Focus (Channeled Focus - Rank 3)
            [33522] = true, -- Summon Shade (Channeled Focus - Rank 3)
            [37024] = true, -- Channeled Focus (Channeled Focus - Rank 3)

            [44834] = true, -- Major Resolve (Channeled Focus - Rank 4)
            [44833] = true, -- Major Ward (Channeled Focus - Rank 4)
            [23998] = true, -- Channeled Focus (Channeled Focus - Rank 4)
            [33521] = true, -- Summon Shade (Channeled Focus - Rank 4)
            [37025] = true, -- Channeled Focus (Channeled Focus - Rank 4)

            [44836] = true, -- Major Resolve (Restoring Focus - Rank 1)
            [44835] = true, -- Major Ward (Restoring Focus - Rank 1)
            [37027] = true, -- Minor Vitality (Restoring Focus - Rank 1)
            [77056] = true, -- Minor Protection (Restoring Focus - Rank 1)
            [22237] = true, -- Restoring Focus (Restoring Focus - Rank 1)
            [101690] = true, -- Restoring Focus (Restoring Focus - Rank 1)
            [33528] = true, -- Restoring Focus (Restoring Focus - Rank 1)

            [44839] = true, -- Major Resolve (Restoring Focus - Rank 2)
            [44838] = true, -- Major Ward (Restoring Focus - Rank 2)
            [37031] = true, -- Minor Vitality (Restoring Focus - Rank 2)
            [77057] = true, -- Minor Protection (Restoring Focus - Rank 2)
            [23983] = true, -- Restoring Focus (Restoring Focus - Rank 2)
            [33527] = true, -- Restoring Focus (Restoring Focus - Rank 2)

            [44841] = true, -- Major Resolve (Restoring Focus - Rank 3)
            [44840] = true, -- Major Ward (Restoring Focus - Rank 3)
            [37032] = true, -- Minor Vitality (Restoring Focus - Rank 3)
            [77058] = true, -- Minor Protection (Restoring Focus - Rank 3)
            [23984] = true, -- Restoring Focus (Restoring Focus - Rank 3)
            [33526] = true, -- Restoring Focus (Restoring Focus - Rank 3)

            [44843] = true, -- Major Resolve (Restoring Focus - Rank 4)
            [44842] = true, -- Major Ward (Restoring Focus - Rank 4)
            [37033] = true, -- Minor Vitality (Restoring Focus - Rank 4)
            [77059] = true, -- Minor Protection (Restoring Focus - Rank 4)
            [23985] = true, -- Restoring Focus (Restoring Focus - Rank 4)
            [33525] = true, -- Restoring Focus (Restoring Focus - Rank 4)

            [22229] = true, -- Remembrance (Remembrance - Rank 1)
            [22231] = true, -- Remembrance (Remembrance - Rank 1)
            [26381] = true, -- Rite of Passage Self Snare (Remembrance - Rank 1)
            [22233] = true, -- Major Protection (Remembrance - Rank 1)

            [27401] = true, -- Remembrance (Remembrance - Rank 2)
            [27403] = true, -- Remembrance (Remembrance - Rank 2)
            [27406] = true, -- Rite of Passage Self Snare (Remembrance - Rank 2)
            [27405] = true, -- Major Protection (Remembrance - Rank 2)

            [27407] = true, -- Remembrance (Remembrance - Rank 3)
            [27409] = true, -- Remembrance (Remembrance - Rank 3)
            [27412] = true, -- Rite of Passage Self Snare (Remembrance - Rank 3)
            [27411] = true, -- Major Protection (Remembrance - Rank 3)

            [27413] = true, -- Remembrance (Remembrance - Rank 4)
            [27415] = true, -- Remembrance (Remembrance - Rank 4)
            [27418] = true, -- Rite of Passage Self Snare (Remembrance - Rank 4)
            [27417] = true, -- Major Protection (Remembrance - Rank 4)

            [22226] = true, -- Practiced Incantation (Practiced Incantation - Rank 1)
            [22228] = true, -- Practiced Incantation (Practiced Incantation - Rank 1)
            [26383] = true, -- Practiced Incantation (Practiced Incantation - Rank 1)

            [27419] = true, -- Practiced Incantation (Practiced Incantation - Rank 2)
            [27421] = true, -- Practiced Incantation (Practiced Incantation - Rank 2)
            [27422] = true, -- Practiced Incantation (Practiced Incantation - Rank 2)

            [27423] = true, -- Practiced Incantation (Practiced Incantation - Rank 3)
            [27425] = true, -- Practiced Incantation (Practiced Incantation - Rank 3)
            [27426] = true, -- Practiced Incantation (Practiced Incantation - Rank 3)

            [27427] = true, -- Practiced Incantation (Practiced Incantation - Rank 4)
            [27429] = true, -- Practiced Incantation (Practiced Incantation - Rank 4)
            [27430] = true, -- Practiced Incantation (Practiced Incantation - Rank 4)

            --------------------------
            -- WARDEN PASSIVES
            --------------------------

            -- Animal Companions
            [86064] = true, -- Bond With Nature (Rank 1)
            [88986] = true, -- Bond With Nature
            [86065] = true, -- Bond With Nature (Rank 2)
            [88988] = true, -- Bond With Nature
            [86062] = true, -- Savage Beast (Rank 1)
            [88512] = true, -- Savage Beast Ultimate
            [86063] = true, -- Savage Beast (Rank 2)
            [88513] = true, -- Transfer
            [86066] = true, -- Flourish (Rank 1)
            [86067] = true, -- Flourish (Rank 2)
            [86068] = true, -- Advanced Species (Rank 1)
            [86069] = true, -- Advanced Species (Rank 2)

            -- Green Balance
            [85882] = true, -- Accelerated Growth (Rank 1)
            [88525] = true, -- Major Mending
            [85883] = true, -- Accelerated Growth (Rank 2)
            [88528] = true, -- Major Mending
            [85878] = true, -- Nature's Gift (Rank 1)
            [88483] = true, -- Nature's Give
            [93054] = true, -- Nature's Gift
            [85879] = true, -- Nature's Gift (Rank 2)
            [93072] = true, -- Nature's Give
            [93073] = true, -- Nature's Gift
            [85876] = true, -- Emerald Moss (Rank 1)
            [85877] = true, -- Emerald Moss (Rank 2)
            [85880] = true, -- Maturation (Rank 1)
            [88492] = true, -- Minor Toughness
            [85881] = true, -- Maturation (Rank 2)
            [88509] = true, -- Minor Toughness

            -- Winter's Embrace
            [86191] = true, -- Glacial Presence (Rank 1)
            [86192] = true, -- Glacial Presence (Rank 2)
            [86189] = true, -- Frozen Armor (Rank 1)
            [86190] = true, -- Frozen Armor (Rank 2)
            [86193] = true, -- Icy Aura (Rank 1)
            [86194] = true, -- Icy Aura (Rank 2)
            [86195] = true, -- Piercing Cold (Rank 1)
            [86196] = true, -- Piercing Cold (Rank 2)

            --------------------------
            -- WARDEN ACTIVE ABILITIES
            --------------------------

            -- Dive
            [85995] = true, -- Dive (Dive - Rank 1)
            [85996] = true, -- Dive (Dive - Rank 2)
            [85997] = true, -- Dive (Dive - Rank 3)
            [85998] = true, -- Dive (Dive - Rank 4)

            -- Cutting Dive
            [85999] = true, -- Cutting Dive  (Cutting Dive - Rank 1)

            -- Scorch
            [86009] = true, -- Scorch (Scorch - Rank 1)
            [94412] = true, -- Gore (Scorch - Rank 1)
            [94409] = true, -- Gore (Scorch - Rank 1)
            [94410] = true, -- Gore (Scorch - Rank 1)
            [94411] = true, -- Sorch (Scorch - Rank 1)
            [86012] = true, -- Scorch (Scorch - Rank 2)
            [94416] = true, -- Gore (Scorch - Rank 2)
            [94413] = true, -- Gore (Scorch - Rank 2)
            [94414] = true, -- Gore (Scorch - Rank 2)
            [94415] = true, -- Sorch (Scorch - Rank 2)
            [86013] = true, -- Scorch (Scorch - Rank 3)
            [94420] = true, -- Gore (Scorch - Rank 3)
            [94417] = true, -- Gore (Scorch - Rank 3)
            [94418] = true, -- Gore (Scorch - Rank 3)
            [94419] = true, -- Sorch (Scorch - Rank 3)
            [93593] = true, -- Scorch (Scorch - Rank 4)
            [93594] = true, -- Gore (Scorch - Rank 4)
            [93634] = true, -- Gore (Scorch - Rank 4)
            [93596] = true, -- Gore (Scorch - Rank 4)
            [93595] = true, -- Sorch (Scorch - Rank 4)

            -- Fungal Growth
            [85536] = true, -- Fungal Growth (Fungal Growth - Rank 1)
            [93769] = true, -- Fungal Growth (Fungal Growth - Rank 2)
            [93770] = true, -- Fungal Growth (Fungal Growth - Rank 3)
            [93771] = true, -- Fungal Growth (Fungal Growth - Rank 4)

            -- Enchanted Growth
            [85862] = true, -- Enchanted Growth (Enchanted Growth - Rank 1)
            [86300] = true, -- Minor Intellect (Enchanted Growth - Rank 1)
            [87019] = true, -- Minor Endurance (Enchanted Growth - Rank 1)

            -- Healing Seed
            [85572] = true, -- Healing Seed (All Ranks)
            [85577] = true, -- Healing Seed Synergy (All Ranks)

            [85578] = true, -- Healing Seed (Healing Seed - Rank 1)
            [85585] = true, -- Healing Seed Dummy (Healing Seed - Rank 1)
            [85584] = true, -- Healing Seed Synergy Tick (Healing Seed - Rank 1)
            [85582] = true, -- Healing Seed Heal (Healing Seed - Rank 1)
            [85583] = true, -- Healing Seed Synergy (Healing Seed - Rank 1)
            [93802] = true, -- Healing Seed (Healing Seed - Rank 2)
            [93812] = true, -- Healing Seed Dummy (Healing Seed - Rank 2)
            [93814] = true, -- Healing Seed Synergy Tick (Healing Seed - Rank 2)
            [93811] = true, -- Healing Seed Heal (Healing Seed - Rank 2)
            [93813] = true, -- Healing Seed Synergy (Healing Seed - Rank 2)
            [93803] = true, -- Healing Seed (Healing Seed - Rank 3)
            [93816] = true, -- Healing Seed Dummy (Healing Seed - Rank 3)
            [93818] = true, -- Healing Seed Synergy Tick (Healing Seed - Rank 3)
            [93815] = true, -- Healing Seed Heal (Healing Seed - Rank 3)
            [93817] = true, -- Healing Seed Synergy (Healing Seed - Rank 3)
            [93804] = true, -- Healing Seed (Healing Seed - Rank 4)
            [93820] = true, -- Healing Seed Dummy (Healing Seed - Rank 4)
            [93822] = true, -- Healing Seed Synergy Tick (Healing Seed - Rank 4)
            [93819] = true, -- Healing Seed Heal (Healing Seed - Rank 4)
            [93821] = true, -- Healing Seed Synergy (Healing Seed - Rank 4)

            -- Frost Cloak
            [86122] = true, -- Frost Cloak (Frost Cloak - Rank 1)
            [86224] = true, -- Major Resolve (Frost Cloak - Rank 1)
            [86225] = true, -- Major Ward (Frost Cloak - Rank 1)
            [86123] = true, -- Frost Cloak (Frost Cloak - Rank 2)
            [94014] = true, -- Major Resolve (Frost Cloak - Rank 2)
            [94015] = true, -- Major Ward (Frost Cloak - Rank 2)
            [86124] = true, -- Frost Cloak (Frost Cloak - Rank 3)
            [94016] = true, -- Major Resolve (Frost Cloak - Rank 3)
            [94017] = true, -- Major Ward (Frost Cloak - Rank 3)
            [86125] = true, -- Frost Cloak (Frost Cloak - Rank 4)
            [94012] = true, -- Major Resolve (Frost Cloak - Rank 4)
            [94013] = true, -- Major Ward (Frost Cloak - Rank 4)

            -- Expansive Frost Cloak
            [86126] = true, -- Expansive Frost Cloak (Expansive Frost Cloak - Rank 1)
            [88758] = true, -- Major Resolve (Expansive Frost Cloak - Rank 1)
            [88759] = true, -- Major Ward (Expansive Frost Cloak - Rank 1)

            -- Impaling Shards
            [88920] = true, -- Impaling Shards Dummy (Impaling Shards - Rank 1)
            [86161] = true, -- Impaling Shards (Impaling Shards - Rank 1)
            [88783] = true, -- Impaling Shards (Impaling Shards - Rank 1)
            [86238] = true, -- Impaling Shards (Impaling Shards - Rank 1)
            [86162] = true, -- Impaling Shards Dummy (Impaling Shards - Rank 2)
            [94066] = true, -- Impaling Shards (Impaling Shards - Rank 2)
            [94067] = true, -- Impaling Shards (Impaling Shards - Rank 2)
            [94065] = true, -- Impaling Shards (Impaling Shards - Rank 2)
            [86163] = true, -- Impaling Shards Dummy (Impaling Shards - Rank 3)
            [94069] = true, -- Impaling Shards (Impaling Shards - Rank 3)
            [94070] = true, -- Impaling Shards (Impaling Shards - Rank 3)
            [94068] = true, -- Impaling Shards (Impaling Shards - Rank 3)
            [86164] = true, -- Impaling Shards Dummy (Impaling Shards - Rank 4)
            [94072] = true, -- Impaling Shards (Impaling Shards - Rank 4)
            [94073] = true, -- Impaling Shards (Impaling Shards - Rank 4)
            [94071] = true, -- Impaling Shards (Impaling Shards - Rank 4)

            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --

            ---------------------
            -- WEAPON SKILL LINES
            ---------------------

            -- UNARMED
            [23604] = true, -- Light Attack
            [18429] = true, -- Heavy Attack (Unarmed)
            [18430] = true, -- Heavy Attack
            [21991] = true, -- Heavy Attack Damage Bonus
            [18431] = true, -- Heavy Attack
            [60772] = true, -- Heavy Attack (Unarmed)

            -- TWO HANDED
            [16037] = true, -- Light Attack
            [16041] = true, -- Heavy Attack (2H)
            [17162] = true, -- Heavy Attack
            [17699] = true, -- Heavy Attack Damage Bonus
            [17163] = true, -- Heavy Attack
            [60757] = true, -- Heavy Attack (2H)

            [29387] = true, -- Forceful (Rank 1)
            [61022] = true, -- Strife Saved Damage
            [30821] = true, -- Forceful
            [45444] = true, -- Forceful (Rank 2)
            [61023] = true, -- Strife Saved Damage
            [45445] = true, -- Forceful

            [29375] = true, -- Heavy Weapons (Rank 1)
            [29383] = true, -- Heavy Weapons Bleed
            [45430] = true, -- Heavy Weapons (Rank 2)
            [45431] = true, -- Heavy Weapons Bleed

            [29388] = true, -- Balanced Blade (Rank 1)
            [45443] = true, -- Balanced Blade (Rank 2)

            [29389] = true, -- Follow Up (Rank 1)
            [60860] = true, -- Bonus Damage
            [45446] = true, -- Follow Up (Rank 2)
            [60888] = true, -- Bonus Damage

            [29391] = true, -- Battle Rush (Rank 1)
            [29392] = true, -- Battle Rush
            [45448] = true, -- Battle Rush (Rank 2)
            [45450] = true, -- Battle Rush

            -- ONE HAND AND SHIELD
            [15435] = true, -- Light Attack
            [15279] = true, -- Heavy Attack (1H)
            [15282] = true, -- Heavy Attack
            [17694] = true, -- Heavy Attack Damage Bonus
            [15829] = true, -- Heavy Attack
            [60759] = true, -- Heavy Attack (Shield)


            [29420] = true, -- Fortress (Rank 1)
            [45471] = true, -- Fortress (Rank 2)

            [29397] = true, -- Sword and Board (Rank 1)
            [45452] = true, -- Sword and Board (Rank 2)

            [29415] = true, -- Deadly Bash (Rank 1)
            [45469] = true, -- Deadly Bash (Rank 2)

            [29399] = true, -- Deflect Bolts (Rank 1)
            [45472] = true, -- Deflect Bolts (Rank 2)

            [29422] = true, -- Battlefield Mobility (Rank 1)
            [45473] = true, -- Battlefield Mobility (Rank 2)


            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --

            -- DUAL WIELD
            [16499] = true, -- Light Attack
            [16420] = true, -- Heavy Attack (Dual Wield)
            [17170] = true, -- Heavy Attack
            [17700] = true, -- Heavy Attack Damage Bonus
            [17169] = true, -- Heavy Attack
            [18622] = true, -- Heavy Attack (Dual Wield)
            [60758] = true, -- Heavy Attack (Dual Wield)
            [64546] = true, -- Heavy Attack Damage Bonus


            [18929] = true, -- Slaughter (Rank 1)
            [45476] = true, -- Slaughter (Rank 2)

            [30873] = true, -- Dual Wield Expert (Rank 1)
            [45477] = true, -- Dual Wield Expert (Rank 2)

            [30872] = true, -- Controlled Fury (Rank 1)
            [45478] = true, -- Controlled Fury (Rank 2)

            [21114] = true, -- Ruffian (Rank 1)
            [45481] = true, -- Ruffian (Rank 2)

            [30893] = true, -- Twin Blade and Blunt (Rank 1)
            [30894] = true, -- Twin Blade and Blunt Bleed
            [45482] = true, -- Twin Blade and Blunt (Rank 2)
            [45483] = true, -- Twin Blade and Blunt Bleed

            -- BOW
            [16688] = true, -- Light Attack
            [16691] = true, -- Heavy Attack (Bow)
            [17174] = true, -- Heavy Attack
            [17701] = true, -- Heavy Attack Damage Bonus
            [17173] = true, -- Heavy Attack
            [60761] = true, -- Heavy Attack (Bow)

            [30937] = true, -- Long Shots (Rank 1)
            [45494] = true, -- Long Shots (Rank 2)

            [30930] = true, -- Accuracy (Rank 1)
            [45492] = true, -- Accuracy (Rank 2)

            [30942] = true, -- Ranger (Rank 1)
            [45493] = true, -- Ranger (Rank 2)


            [30936] = true, -- Hawk Eye (Rank 1)
            [78854] = true, -- Hawk Eye
            [45497] = true, -- Hawk Eye (Rank 2)
            [78855] = true, -- Hawk Eye

            [30923] = true, -- Hasty Retreat (Rank 1)
            [98489] = true, -- Major Expedition
            [45498] = true, -- Hasty Retreat (Rank 2)
            [98490] = true, -- Major Expedition

            -- DESTRUCTION STAFF
            [16277] = true, -- Light Attack
            [16261] = true, -- Heavy Attack (Frost)
            [18405] = true, -- Heavy Attack
            [18404] = true, -- Heavy Attack Damage Bonus
            [18406] = true, -- Heavy Attack
            [60762] = true, -- Heavy Attack (Frost)

            [16165] = true, -- Light Attack
            [15383] = true, -- Heavy Attack (Flame)
            [15385] = true, -- Heavy Attack
            [23429] = true, -- Heavy Attack Damage Bonus
            [16321] = true, -- Heavy Attack
            [60763] = true, -- Heavy Attack (Fire)

            [18350] = true, -- Light Attack
            [18396] = true, -- Heavy Attack (Shock)
            [19277] = true, -- Shock Pulse
            [60764] = true, -- Heavy Attack (Shock)
            --[67107] = true, -- Partial Heavy Attack (Shock)

            [30948] = true, -- Tri Focus -- Rank 1
            [69774] = true, -- Tri Focus
            [34498] = true, -- Tri Focus
            [30951] = true, -- Shock
            [45500] = true, -- Tri Focus -- Rank 2
            [69773] = true, -- Tri Focus
            [45502] = true, -- Tri Focus
            [45505] = true, -- Shock

            [30957] = true, -- Penetrating Magic -- Rank 1
            [45509] = true, -- Penetrating Magic -- Rank 2

            [30962] = true, -- Elemental Force -- Rank 1
            [45512] = true, -- Elemental Force -- Rank 2

            [30959] = true, -- Ancient Knowledge -- Rank 1
            [45513] = true, -- Ancient Knowledge -- Rank 2

            [30965] = true, -- Destruction Expert -- Rank 1
            [30966] = true, -- Magicka Restore
            [45514] = true, -- Destruction Expert -- Rank 1
            [45515] = true, -- Magicka Restore

            -- RESTORATION STAFF
            [16145] = true, -- Light Attack
            [16212] = true, -- Heavy Attack
            [32760] = true, -- Heavy Attack (Restoration)
            [67106] = true, -- Partial Heavy Attack (Resto)
            [28469] = true, -- Heavy Attack
            [38591] = true, -- Heavy Attack

            [30973] = true, -- Essence Drain (Rank 1)
            [77918] = true, -- Major Mending
            [30978] = true, -- Essence Drain
            [45517] = true, -- Essence Drain (Rank 2)
            [77922] = true, -- Major Mending
            [45518] = true, -- Essence Drain

            [30980] = true, -- Restoration Expert (Rank 1)
            [45519] = true, -- Restoration Expert (Rank 2)

            [30972] = true, -- Cycle of Life (Rank 1)
            [45520] = true, -- Cycle of Life (Rank 2)

            [30869] = true, -- Absorb (Rank 1)
            [30971] = true, -- Absorb
            [45521] = true, -- Absorb (Rank 2)
            [45522] = true, -- Absorb

            [30981] = true, -- Restoration Master (Rank 1)
            [45524] = true, -- Restoration Master (Rank 2)

            -------------------------------
            -- WEAPON ACTIVES
            -------------------------------

            -- 1H + Shield
            [28306] = true, -- Puncture (Puncture - Rank 1)
            [28307] = true, -- Major Fracture (Puncture - Rank 1)
            [41473] = true, -- Puncture (Puncture - Rank 2)
            [62470] = true, -- Major Fracture (Puncture - Rank 2)
            [41475] = true, -- Puncture (Puncture - Rank 3)
            [62471] = true, -- Major Fracture (Puncture - Rank 3)
            [41477] = true, -- Puncture (Puncture - Rank 4)
            [62473] = true, -- Major Fracture (Puncture - Rank 4)

            [38256] = true, -- Ransack (Ransack - Rank 1)
            [62474] = true, -- Major Fracture (Ransack - Rank 1)
            [62475] = true, -- Minor Resolve (Ransack - Rank 1)

            [38250] = true, -- Pierce Armor (Pierce Armor - Rank 1)
            [62484] = true, -- Major Fracture (Pierce Armor - Rank 1)
            [62485] = true, -- Major Breach (Pierce Armor - Rank 1)

            [28304] = true, -- Low Slash (Low Slash - Rank 1)
            [28305] = true, -- Low Slash Snare (Low Slash - Rank 1)
            [29308] = true, -- Minor Main (Low Slash - Rank 1)
            [41387] = true, -- Low Slash (Low Slash - Rank 2)
            [41389] = true, -- Low Slash Snare (Low Slash - Rank 2)
            [62492] = true, -- Minor Main (Low Slash - Rank 2)
            [41391] = true, -- Low Slash (Low Slash - Rank 3)
            [41393] = true, -- Low Slash Snare (Low Slash - Rank 3)
            [62493] = true, -- Minor Main (Low Slash - Rank 3)
            [41394] = true, -- Low Slash (Low Slash - Rank 4)
            [41396] = true, -- Low Slash Snare (Low Slash - Rank 4)
            [62494] = true, -- Minor Main (Low Slash - Rank 4)

            [38268] = true, -- Deep Slash (Deep Slash - Rank 1)
            [60921] = true, -- Deep Slash (Deep Slash - Rank 1)
            [38271] = true, -- Deep Slash (Deep Slash - Rank 1)
            [62495] = true, -- Minor Maim (Deep Slash - Rank 1)

            [38264] = true, -- Heroic Slash (Heroic Slash - Rank 1)
            [38266] = true, -- Heroic Slash Snare (Heroic Slash - Rank 1)
            [62504] = true, -- Minor Maim (Heroic Slash - Rank 1)
            [62505] = true, -- Minor Heroism (Heroic Slash - Rank 1)

            -- DW
            [28607] = true, -- Flurry (Flurry - Rank 1)
            [81355] = true, -- Flurry (Flurry - Rank 1)
            [29227] = true, -- Flurry (Flurry - Rank 1)
            [40578] = true, -- Flurry (Flurry - Rank 2)
            [81364] = true, -- Flurry (Flurry - Rank 2)
            [40579] = true, -- Flurry (Flurry - Rank 2)
            [40580] = true, -- Flurry (Flurry - Rank 3)
            [81365] = true, -- Flurry (Flurry - Rank 3)
            [40581] = true, -- Flurry (Flurry - Rank 3)
            [40582] = true, -- Flurry (Flurry - Rank 4)
            [81367] = true, -- Flurry (Flurry - Rank 4)
            [40583] = true, -- Flurry (Flurry - Rank 4)

            [38857] = true, -- Rapid Strikes (Rapid Strikes - Rank 1)
            [38860] = true, -- Rapid Strikes (Rapid Strikes - Rank 1)
            [81368] = true, -- Rapid Strikes (Rapid Strikes - Rank 1)
            [38859] = true, -- Rapid Strikes (Rapid Strikes - Rank 1)

            [38846] = true, -- Bloodthirst (Bloodthirst - Rank 1)
            [81378] = true, -- Bloodthirst (Bloodthirst - Rank 1)
            [81380] = true, -- Bloodthirst (Bloodthirst - Rank 1)
            [81379] = true, -- Bloodthirst (Bloodthirst - Rank 1)
            [81381] = true, -- Bloodthirst (Bloodthirst - Rank 1)
            [38853] = true, -- Bloodthirst (Bloodthirst - Rank 1)

            [28379] = true, -- Twin Slashes (Twin Slashes - Rank 1)
            [35312] = true, -- Twin Slashes (Twin Slashes - Rank 1)
            [29293] = true, -- Twin Slashes Bleed (Twin Slashes - Rank 1)
            [40658] = true, -- Twin Slashes (Twin Slashes - Rank 2)
            [40659] = true, -- Twin Slashes (Twin Slashes - Rank 2)
            [40660] = true, -- Twin Slashes Bleed (Twin Slashes - Rank 2)
            [40661] = true, -- Twin Slashes (Twin Slashes - Rank 3)
            [40662] = true, -- Twin Slashes (Twin Slashes - Rank 3)
            [40663] = true, -- Twin Slashes Bleed (Twin Slashes - Rank 3)
            [40664] = true, -- Twin Slashes (Twin Slashes - Rank 4)
            [40665] = true, -- Twin Slashes (Twin Slashes - Rank 4)
            [40666] = true, -- Twin Slashes Bleed (Twin Slashes - Rank 4)

            [38839] = true, -- Rending Slashes (Rending Slashes - Rank 1)
            [38840] = true, -- Rending Slashes (Rending Slashes - Rank 1)
            [38841] = true, -- Rending Slashes Bleed (Rending Slashes - Rank 1)
            [38842] = true, -- Rending Slashes (Rending Slashes - Rank 1)

            [38845] = true, -- Blood Craze (Blood Craze - Rank 1)
            [38847] = true, -- Blood Craze (Blood Craze - Rank 1)
            [38848] = true, -- Blood Craze Bleed (Blood Craze - Rank 1)
            [38852] = true, -- Blood Craze (Blood Craze - Rank 1)

            -- DESTRUCTION STAFF
            [46340] = true, -- Force Shock (Force Shock - Rank 1)
            [46341] = true, -- Force Shock (Force Shock - Rank 1)
            [46343] = true, -- Force Shock (Force Shock - Rank 1)
            [48950] = true, -- Force Shock (Force Shock - Rank 2)
            [48951] = true, -- Force Shock (Force Shock - Rank 2)
            [48952] = true, -- Force Shock (Force Shock - Rank 2)
            [48953] = true, -- Force Shock (Force Shock - Rank 3)
            [48954] = true, -- Force Shock (Force Shock - Rank 3)
            [48955] = true, -- Force Shock (Force Shock - Rank 3)
            [48956] = true, -- Force Shock (Force Shock - Rank 4)
            [48957] = true, -- Force Shock (Force Shock - Rank 4)
            [48958] = true, -- Force Shock (Force Shock - Rank 4)

            [46348] = true, -- Crushing Shock (Crushing Shock - Rank 1)
            [46350] = true, -- Crushing Shock (Crushing Shock - Rank 1)
            [46351] = true, -- Crushing Shock (Crushing Shock - Rank 1)
            [48010] = true, -- Force Shock (Destruction) (Crushing Shock - Rank 1)
            [48009] = true, -- Stagger(Crushing Shock - Rank 1)
            [48011] = true, -- Uber Attack (Crushing Shock - Rank 1)

            [48959] = true, -- Crushing Shock (Crushing Shock - Rank 2)
            [48960] = true, -- Crushing Shock (Crushing Shock - Rank 2)
            [48961] = true, -- Crushing Shock (Crushing Shock - Rank 2)
            [48962] = true, -- Force Shock (Destruction) (Crushing Shock - Rank 2)
            [48963] = true, -- Stagger(Crushing Shock - Rank 2)
            [48964] = true, -- Uber Attack (Crushing Shock - Rank 2)

            [48965] = true, -- Crushing Shock (Crushing Shock - Rank 3)
            [48966] = true, -- Crushing Shock (Crushing Shock - Rank 3)
            [48967] = true, -- Crushing Shock (Crushing Shock - Rank 3)
            [48968] = true, -- Force Shock (Destruction) (Crushing Shock - Rank 3)
            [48969] = true, -- Stagger(Crushing Shock - Rank 3)
            [48970] = true, -- Uber Attack (Crushing Shock - Rank 3)

            [48971] = true, -- Crushing Shock (Crushing Shock - Rank 4)
            [48972] = true, -- Crushing Shock (Crushing Shock - Rank 4)
            [48973] = true, -- Crushing Shock (Crushing Shock - Rank 4)
            [48974] = true, -- Force Shock (Destruction) (Crushing Shock - Rank 4)
            [48975] = true, -- Stagger(Crushing Shock - Rank 4)
            [48976] = true, -- Uber Attack (Crushing Shock - Rank 4)

            [48019] = true, -- Hit Dummy (Force Pulse - All Ranks)

            [46356] = true, -- Force Pulse (Force Pulse - Rank 1)
            [46357] = true, -- Force Pulse (Force Pulse - Rank 1)
            [46358] = true, -- Force Pulse (Force Pulse - Rank 1)
            [48017] = true, -- Bounce 1 (Force Pulse - Rank 1)
            [48023] = true, -- Bounce 2 (Force Pulse - Rank 1)
            [48016] = true, -- Force Pulse (Force Pulse - Rank 1)

            [48977] = true, -- Force Pulse (Force Pulse - Rank 2)
            [48978] = true, -- Force Pulse (Force Pulse - Rank 2)
            [48980] = true, -- Force Pulse (Force Pulse - Rank 2)
            [48981] = true, -- Bounce 1 (Force Pulse - Rank 2)
            [48982] = true, -- Bounce 2 (Force Pulse - Rank 2)
            [48983] = true, -- Force Pulse (Force Pulse - Rank 2)
            [48979] = true, -- Force Pulse (Force Pulse - Rank 2)

            [48984] = true, -- Force Pulse (Force Pulse - Rank 3)
            [48985] = true, -- Force Pulse (Force Pulse - Rank 3)
            [48987] = true, -- Force Pulse (Force Pulse - Rank 3)
            [48988] = true, -- Bounce 1 (Force Pulse - Rank 3)
            [48989] = true, -- Bounce 2 (Force Pulse - Rank 3)
            [48990] = true, -- Force Pulse (Force Pulse - Rank 3)
            [48986] = true, -- Force Pulse (Force Pulse - Rank 3)

            [48991] = true, -- Force Pulse (Force Pulse - Rank 4)
            [48992] = true, -- Force Pulse (Force Pulse - Rank 4)
            [48994] = true, -- Force Pulse (Force Pulse - Rank 4)
            [48995] = true, -- Bounce 1 (Force Pulse - Rank 4)
            [48996] = true, -- Bounce 2 (Force Pulse - Rank 4)
            [48997] = true, -- Force Pulse (Force Pulse - Rank 4)
            [48993] = true, -- Force Pulse (Force Pulse - Rank 4)

            [68719] = true, -- Frozen (Wall of Elements - All Ranks) -- Frost
            [43192] = true, -- Fire Wall Damage Bonus (Wall of Elements - All Ranks) -- Fire

            [28858] = true, -- Wall of Elements (Wall of Elements - Rank 1)
            [28807] = true, -- Wall of Fire (Wall of Elements - Rank 1) -- Fire
            [62898] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 1) -- Fire
            [62897] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 1) -- Fire
            [62895] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 1) -- Fire
            [62896] = true, -- Wall of Fire (Wall of Elements - Rank 1) -- Fire
            [28854] = true, -- Wall of Storms (Wall of Elements - Rank 1) -- Storm
            [62969] = true, -- Wall of Storms (Wall of Elements - Rank 1) -- Storm
            [62970] = true, -- Wall of Storms (Wall of Elements - Rank 1) -- Storm
            [62967] = true, -- Wall of Storms (Wall of Elements - Rank 1) -- Storm
            [62971] = true, -- Wall of Storms (Wall of Elements - Rank 1) -- Storm
            [62968] = true, -- Off Balance (Wall of Elements - Rank 1) -- Storm
            [28849] = true, -- Wall of Frost (Wall of Elements - Rank 1) -- Frost
            [62930] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 1) -- Frost
            [62929] = true, -- Unstable Wall of Frost (Wall of Elements - Rank 1) -- Frost
            [62927] = true, -- Unstable Wall of Frost (Wall of Elements - Rank 1) -- Frost
            [62931] = true, -- Wall of Frost (Wall of Elements - Rank 1) -- Frost
            [62928] = true, -- Wall of Frost (Wall of Elements - Rank 1) -- Frost

            [41627] = true, -- Wall of Elements (Wall of Elements - Rank 2)
            [41628] = true, -- Wall of Fire (Wall of Elements - Rank 2) -- Fire
            [62902] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 2) -- Fire
            [62901] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 2) -- Fire
            [62899] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 2) -- Fire
            [62900] = true, -- Wall of Fire (Wall of Elements - Rank 2) -- Fire
            [41637] = true, -- Wall of Storms (Wall of Elements - Rank 2) -- Storm
            [62976] = true, -- Wall of Storms (Wall of Elements - Rank 2) -- Storm
            [62974] = true, -- Wall of Storms (Wall of Elements - Rank 2) -- Storm
            [62972] = true, -- Wall of Storms (Wall of Elements - Rank 2) -- Storm
            [62975] = true, -- Wall of Storms (Wall of Elements - Rank 2) -- Storm
            [62973] = true, -- Off Balance (Wall of Elements - Rank 2) -- Storm
            [41632] = true, -- Wall of Frost (Wall of Elements - Rank 2) -- Frost
            [62935] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 2) -- Frost
            [62934] = true, -- Unstable Wall of Frost (Wall of Elements - Rank 2) -- Frost
            [62932] = true, -- Unstable Wall of Frost (Wall of Elements - Rank 2) -- Frost
            [62936] = true, -- Wall of Frost (Wall of Elements - Rank 2) -- Frost
            [62933] = true, -- Wall of Frost (Wall of Elements - Rank 2) -- Frost

            [41642] = true, -- Wall of Elements (Wall of Elements - Rank 3)
            [41643] = true, -- Wall of Fire (Wall of Elements - Rank 3) -- Fire
            [62906] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 3) -- Fire
            [62905] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 3) -- Fire
            [62903] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 3) -- Fire
            [62904] = true, -- Wall of Fire (Wall of Elements - Rank 3) -- Fire
            [41652] = true, -- Wall of Storms (Wall of Elements - Rank 3) -- Storm
            [62981] = true, -- Wall of Storms (Wall of Elements - Rank 3) -- Storm
            [62979] = true, -- Wall of Storms (Wall of Elements - Rank 3) -- Storm
            [62977] = true, -- Wall of Storms (Wall of Elements - Rank 3) -- Storm
            [62980] = true, -- Wall of Storms (Wall of Elements - Rank 3) -- Storm
            [62978] = true, -- Off Balance (Wall of Elements - Rank 3) -- Storm
            [41647] = true, -- Wall of Frost (Wall of Elements - Rank 3) -- Frost
            [62940] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 3) -- Frost
            [62939] = true, -- Unstable Wall of Frost (Wall of Elements - Rank 3) -- Frost
            [62937] = true, -- Unstable Wall of Frost (Wall of Elements - Rank 3) -- Frost
            [62941] = true, -- Wall of Frost (Wall of Elements - Rank 3) -- Frost
            [62938] = true, -- Wall of Frost (Wall of Elements - Rank 3) -- Frost

            [41658] = true, -- Wall of Elements (Wall of Elements - Rank 4)
            [41659] = true, -- Wall of Fire (Wall of Elements - Rank 4) -- Fire
            [62910] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 4) -- Fire
            [62909] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 4) -- Fire
            [62907] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 4) -- Fire
            [62908] = true, -- Wall of Fire (Wall of Elements - Rank 4) -- Fire
            [41668] = true, -- Wall of Storms (Wall of Elements - Rank 4) -- Storm
            [62986] = true, -- Wall of Storms (Wall of Elements - Rank 4) -- Storm
            [62984] = true, -- Wall of Storms (Wall of Elements - Rank 4) -- Storm
            [62982] = true, -- Wall of Storms (Wall of Elements - Rank 4) -- Storm
            [62985] = true, -- Wall of Storms (Wall of Elements - Rank 4) -- Storm
            [62983] = true, -- Off Balance (Wall of Elements - Rank 4) -- Storm
            [41663] = true, -- Wall of Frost (Wall of Elements - Rank 4) -- Frost
            [62945] = true, -- Unstable Wall of Fire (Wall of Elements - Rank 4) -- Frost
            [62944] = true, -- Unstable Wall of Frost (Wall of Elements - Rank 4) -- Frost
            [62942] = true, -- Unstable Wall of Frost (Wall of Elements - Rank 4) -- Frost
            [62946] = true, -- Wall of Frost (Wall of Elements - Rank 4) -- Frost
            [62943] = true, -- Wall of Frost (Wall of Elements - Rank 4) -- Frost

            [39052] = true, -- Unstable Wall of Elements (Unstable Wall of Elements - Rank 1)
            [39053] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1) -- Fire
            [62813] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1) -- Fire
            [39057] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1) -- Fire
            [39055] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1) -- Fire
            [39054] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1) -- Fire
            [39056] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1) -- Fire
            [39073] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 1) -- Shock
            [62868] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1) -- Shock
            [39081] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 1) -- Shock
            [39078] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 1) -- Shock
            [39079] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 1) -- Shock
            [39080] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 1) -- Shock
            [39077] = true, -- Off Balance (Unstable Wall of Elements - Rank 1) -- Shock
            [39067] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 1) -- Frost
            [62840] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 1) -- Frost
            [39069] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 1) -- Frost
            [39070] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 1) -- Frost
            [39071] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 1) -- Frost
            [39072] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 1) -- Frost
            [39068] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 1) -- Frost

            [41673] = true, -- Unstable Wall of Elements (Unstable Wall of Elements - Rank 2)
            [41674] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 2) -- Fire
            [62823] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 2) -- Fire
            [62822] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 2) -- Fire
            [62818] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 2) -- Fire
            [62821] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 2) -- Fire
            [62817] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 2) -- Fire
            [41685] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 2) -- Shock
            [62877] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 2) -- Shock
            [62875] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 2) -- Shock
            [62871] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 2) -- Shock
            [62873] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 2) -- Shock
            [62872] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 2) -- Shock
            [62870] = true, -- Off Balance (Unstable Wall of Elements - Rank 2) -- Shock
            [41679] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 2) -- Frost
            [62848] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 2) -- Frost
            [62846] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 2) -- Frost
            [62843] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 2) -- Frost
            [62845] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 2) -- Frost
            [62841] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 2) -- Frost
            [62842] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 2) -- Frost

            [41691] = true, -- Unstable Wall of Elements (Unstable Wall of Elements - Rank 3)
            [41692] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 3) -- Fire
            [62830] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 3) -- Fire
            [62829] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 3) -- Fire
            [62825] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 3) -- Fire
            [62828] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 3) -- Fire
            [62824] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 3) -- Fire
            [41705] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 3) -- Shock
            [62886] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 3) -- Shock
            [62881] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 3) -- Shock
            [62879] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 3) -- Shock
            [62885] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 3) -- Shock
            [62884] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 3) -- Shock
            [62880] = true, -- Off Balance (Unstable Wall of Elements - Rank 3) -- Shock
            [41697] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 3) -- Frost
            [62856] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 3) -- Frost
            [62854] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 3) -- Frost
            [62851] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 3) -- Frost
            [62853] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 3) -- Frost
            [62849] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 3) -- Frost
            [62850] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 3) -- Frost

            [41711] = true, -- Unstable Wall of Elements (Unstable Wall of Elements - Rank 4)
            [41712] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 4) -- Fire
            [62837] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 4) -- Fire
            [62836] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 4) -- Fire
            [62832] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 4) -- Fire
            [62835] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 4) -- Fire
            [62831] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 4) -- Fire
            [41723] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 4) -- Shock
            [62894] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 4) -- Shock
            [62892] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 4) -- Shock
            [62888] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 4) -- Shock
            [62890] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 4) -- Shock
            [62889] = true, -- Unstable Wall of Storms (Unstable Wall of Elements - Rank 4) -- Shock
            [62887] = true, -- Off Balance (Unstable Wall of Elements - Rank 4) -- Shock
            [41717] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 4) -- Frost
            [62864] = true, -- Unstable Wall of Fire (Unstable Wall of Elements - Rank 4) -- Frost
            [62861] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 4) -- Frost
            [62858] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 4) -- Frost
            [62863] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 4) -- Frost
            [62857] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 4) -- Frost
            [62859] = true, -- Unstable Wall of Frost (Unstable Wall of Elements - Rank 4) -- Frost

            [39011] = true, -- Elemental Blockade (Elemental Blockade - Rank 1)
            [39012] = true, -- Blockade of Fire (Elemental Blockade - Rank 1) -- Fire
            [62914] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 1) -- Fire
            [62913] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 1) -- Fire
            [62911] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 1) -- Fire
            [62912] = true, -- Blockade of Fire (Elemental Blockade - Rank 1) -- Fire
            [39018] = true, -- Blockade of Storms (Elemental Blockade - Rank 1) -- Storm
            [62991] = true, -- Blockade of Storms (Elemental Blockade - Rank 1) -- Storm
            [62989] = true, -- Blockade of Storms (Elemental Blockade - Rank 1) -- Storm
            [62987] = true, -- Blockade of Storms (Elemental Blockade - Rank 1) -- Storm
            [62990] = true, -- Blockade of Storms (Elemental Blockade - Rank 1) -- Storm
            [62988] = true, -- Blockade of Storms (Elemental Blockade - Rank 1) -- Storm
            [39028] = true, -- Blockade of Frost (Elemental Blockade - Rank 1) -- Frost
            [62950] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 1) -- Frost
            [62949] = true, -- Unstable Wall of Frost (Elemental Blockade - Rank 1) -- Frost
            [62947] = true, -- Unstable Wall of Frost (Elemental Blockade - Rank 1) -- Frost
            [62951] = true, -- Blockade of Frost (Elemental Blockade - Rank 1) -- Frost
            [62948] = true, -- Blockade of Frost (Elemental Blockade - Rank 1) -- Frost

            [41738] = true, -- Elemental Blockade (Elemental Blockade - Rank 2)
            [41739] = true, -- Blockade of Fire (Elemental Blockade - Rank 2) -- Fire
            [62918] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 2) -- Fire
            [62917] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 2) -- Fire
            [62915] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 2) -- Fire
            [62916] = true, -- Blockade of Fire (Elemental Blockade - Rank 2) -- Fire
            [41748] = true, -- Blockade of Storms (Elemental Blockade - Rank 2) -- Storm
            [62996] = true, -- Blockade of Storms (Elemental Blockade - Rank 2) -- Storm
            [62994] = true, -- Blockade of Storms (Elemental Blockade - Rank 2) -- Storm
            [62992] = true, -- Blockade of Storms (Elemental Blockade - Rank 2) -- Storm
            [62995] = true, -- Blockade of Storms (Elemental Blockade - Rank 2) -- Storm
            [62993] = true, -- Blockade of Storms (Elemental Blockade - Rank 2) -- Storm
            [41743] = true, -- Blockade of Frost (Elemental Blockade - Rank 2) -- Frost
            [62955] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 2) -- Frost
            [62954] = true, -- Unstable Wall of Frost (Elemental Blockade - Rank 2) -- Frost
            [62952] = true, -- Unstable Wall of Frost (Elemental Blockade - Rank 2) -- Frost
            [62956] = true, -- Blockade of Frost (Elemental Blockade - Rank 2) -- Frost
            [62953] = true, -- Blockade of Frost (Elemental Blockade - Rank 2) -- Frost

            [41754] = true, -- Elemental Blockade (Elemental Blockade - Rank 3)
            [41755] = true, -- Blockade of Fire (Elemental Blockade - Rank 3) -- Fire
            [62922] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 3) -- Fire
            [62921] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 3) -- Fire
            [62919] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 3) -- Fire
            [62920] = true, -- Blockade of Fire (Elemental Blockade - Rank 3) -- Fire
            [41757] = true, -- Blockade of Storms (Elemental Blockade - Rank 3) -- Storm
            [63001] = true, -- Blockade of Storms (Elemental Blockade - Rank 3) -- Storm
            [62999] = true, -- Blockade of Storms (Elemental Blockade - Rank 3) -- Storm
            [62997] = true, -- Blockade of Storms (Elemental Blockade - Rank 3) -- Storm
            [63000] = true, -- Blockade of Storms (Elemental Blockade - Rank 3) -- Storm
            [62998] = true, -- Blockade of Storms (Elemental Blockade - Rank 3) -- Storm
            [41756] = true, -- Blockade of Frost (Elemental Blockade - Rank 3) -- Frost
            [62960] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 3) -- Frost
            [62959] = true, -- Unstable Wall of Frost (Elemental Blockade - Rank 3) -- Frost
            [62957] = true, -- Unstable Wall of Frost (Elemental Blockade - Rank 3) -- Frost
            [62961] = true, -- Blockade of Frost (Elemental Blockade - Rank 3) -- Frost
            [62958] = true, -- Blockade of Frost (Elemental Blockade - Rank 3) -- Frost

            [41769] = true, -- Elemental Blockade (Elemental Blockade - Rank 4)
            [41770] = true, -- Blockade of Fire (Elemental Blockade - Rank 4) -- Fire
            [62926] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 4) -- Fire
            [62925] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 4) -- Fire
            [62923] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 4) -- Fire
            [62924] = true, -- Blockade of Fire (Elemental Blockade - Rank 4) -- Fire
            [41772] = true, -- Blockade of Storms (Elemental Blockade - Rank 4) -- Storm
            [63006] = true, -- Blockade of Storms (Elemental Blockade - Rank 4) -- Storm
            [63004] = true, -- Blockade of Storms (Elemental Blockade - Rank 4) -- Storm
            [63002] = true, -- Blockade of Storms (Elemental Blockade - Rank 4) -- Storm
            [63005] = true, -- Blockade of Storms (Elemental Blockade - Rank 4) -- Storm
            [63003] = true, -- Blockade of Storms (Elemental Blockade - Rank 4) -- Storm
            [41771] = true, -- Blockade of Frost (Elemental Blockade - Rank 4) -- Frost
            [62965] = true, -- Unstable Wall of Fire (Elemental Blockade - Rank 4) -- Frost
            [62964] = true, -- Unstable Wall of Frost (Elemental Blockade - Rank 4) -- Frost
            [62962] = true, -- Unstable Wall of Frost (Elemental Blockade - Rank 4) -- Frost
            [62966] = true, -- Blockade of Frost (Elemental Blockade - Rank 4) -- Frost
            [62963] = true, -- Blockade of Frost (Elemental Blockade - Rank 4) -- Frost

            [29091] = true, -- Destructive Touch (Destructive Touch - Rank 1)
            [29073] = true, -- Flame Touch (Destructive Touch - Rank 1) -- Fire
            [62648] = true, -- Fire Touch (Destructive Touch - Rank 1) -- Fire
            [38172] = true, -- Stun After Knockback Movement (Destructive Touch - Rank 1) -- Fire
            [29075] = true, -- Fire Touch (destruction) (Destructive Touch - Rank 1) -- Fire
            [29089] = true, -- Shock Touch (Destructive Touch - Rank 1) -- Shock
            [62722] = true, -- Shock Touch (Destructive Touch - Rank 1) -- Shock
            [68536] = true, -- Shock Touch (Destructive Touch - Rank 1) -- Shock
            [29078] = true, -- Frost Touch (Destructive Touch - Rank 1) -- Frost
            [62692] = true, -- Frost Touch (Destructive Touch - Rank 1) -- Frost
            [30450] = true, -- Deep Freeze (Destructive Touch - Rank 1) -- Frost

            [40947] = true, -- Destructive Touch (Destructive Touch - Rank 2)
            [40948] = true, -- Flame Touch (Destructive Touch - Rank 2) -- Fire
            [62659] = true, -- Fire Touch (Destructive Touch - Rank 2) -- Fire
            [62661] = true, -- Stun After Knockback Movement (Destructive Touch - Rank 2) -- Fire
            [62660] = true, -- Fire Touch (destruction) (Destructive Touch - Rank 2) -- Fire
            [40953] = true, -- Shock Touch (Destructive Touch - Rank 2) -- Shock
            [62727] = true, -- Shock Touch (Destructive Touch - Rank 2) -- Shock
            [68542] = true, -- Shock Touch (Destructive Touch - Rank 2) -- Shock
            [40950] = true, -- Frost Touch (Destructive Touch - Rank 2) -- Frost
            [62695] = true, -- Frost Touch (Destructive Touch - Rank 2) -- Frost
            [62693] = true, -- Deep Freeze (Destructive Touch - Rank 2) -- Frost

            [40956] = true, -- Destructive Touch (Destructive Touch - Rank 3)
            [40957] = true, -- Flame Touch (Destructive Touch - Rank 3) -- Fire
            [62662] = true, -- Fire Touch (Destructive Touch - Rank 3) -- Fire
            [62664] = true, -- Stun After Knockback Movement (Destructive Touch - Rank 3) -- Fire
            [62663] = true, -- Fire Touch (destruction) (Destructive Touch - Rank 3) -- Fire
            [40962] = true, -- Shock Touch (Destructive Touch - Rank 3) -- Shock
            [62729] = true, -- Shock Touch (Destructive Touch - Rank 3) -- Shock
            [68541] = true, -- Shock Touch (Destructive Touch - Rank 3) -- Shock
            [40959] = true, -- Frost Touch (Destructive Touch - Rank 3) -- Frost
            [62698] = true, -- Frost Touch (Destructive Touch - Rank 3) -- Frost
            [62696] = true, -- Deep Freeze (Destructive Touch - Rank 3) -- Frost

            [40964] = true, -- Destructive Touch (Destructive Touch - Rank 4)
            [40965] = true, -- Flame Touch (Destructive Touch - Rank 4) -- Fire
            [62665] = true, -- Fire Touch (Destructive Touch - Rank 4) -- Fire
            [62667] = true, -- Stun After Knockback Movement (Destructive Touch - Rank 4) -- Fire
            [62666] = true, -- Fire Touch (destruction) (Destructive Touch - Rank 4) -- Fire
            [40970] = true, -- Shock Touch (Destructive Touch - Rank 4) -- Shock
            [62731] = true, -- Shock Touch (Destructive Touch - Rank 4) -- Shock
            [68540] = true, -- Shock Touch (Destructive Touch - Rank 4) -- Shock
            [40967] = true, -- Frost Touch (Destructive Touch - Rank 4) -- Frost
            [62701] = true, -- Frost Touch (Destructive Touch - Rank 4) -- Frost
            [62699] = true, -- Deep Freeze (Destructive Touch - Rank 4) -- Frost

            [38984] = true, -- Destructive Clench (Destructive Clench - Rank 1)
            [38985] = true, -- Flame Clench (Destructive Clench - Rank 1) -- Fire
            [62668] = true, -- Fire Clench (Destructive Clench - Rank 1) -- Fire
            [38987] = true, -- Stun After Knockback Movement (Destructive Clench - Rank 1) -- Fire
            [38986] = true, -- Fire Touch (destruction) (Destructive Clench - Rank 1) -- Fire
            [38993] = true, -- Shock Clench (Destructive Clench - Rank 1) -- Shock
            [62733] = true, -- Shock Clench (Destructive Clench - Rank 1) -- Shock
            [68635] = true, -- Shock Touch (Destructive Clench - Rank 1) -- Shock
            [62734] = true, -- Shock Clench Explosion (Destructive Clench - Rank 1) -- Shock
            [38989] = true, -- Frost Clench (Destructive Clench - Rank 1) -- Frost
            [62702] = true, -- Frost Clench (Destructive Clench - Rank 1) -- Frost
            [38990] = true, -- Deep Freeze (Destructive Clench - Rank 1) -- Frost

            [40977] = true, -- Destructive Clench (Destructive Clench - Rank 2)
            [40984] = true, -- Flame Clench (Destructive Clench - Rank 2) -- Fire
            [62671] = true, -- Fire Clench (Destructive Clench - Rank 2) -- Fire
            [62673] = true, -- Stun After Knockback Movement (Destructive Clench - Rank 2) -- Fire
            [62672] = true, -- Fire Touch (destruction) (Destructive Clench - Rank 2) -- Fire
            [40991] = true, -- Shock Clench (Destructive Clench - Rank 2) -- Shock
            [62736] = true, -- Shock Clench (Destructive Clench - Rank 2) -- Shock
            [62735] = true, -- Shock Clench (Destructive Clench - Rank 2) -- Shock
            [68637] = true, -- Shock Touch (Destructive Clench - Rank 2) -- Shock
            [62737] = true, -- Shock Clench Explosion (Destructive Clench - Rank 2) -- Shock
            [40988] = true, -- Frost Clench (Destructive Clench - Rank 2) -- Frost
            [62705] = true, -- Frost Clench (Destructive Clench - Rank 2) -- Frost
            [62703] = true, -- Deep Freeze (Destructive Clench - Rank 2) -- Frost

            [40995] = true, -- Destructive Clench (Destructive Clench - Rank 3)
            [40996] = true, -- Flame Clench (Destructive Clench - Rank 3) -- Fire
            [62675] = true, -- Fire Clench (Destructive Clench - Rank 3) -- Fire
            [62677] = true, -- Stun After Knockback Movement (Destructive Clench - Rank 3) -- Fire
            [62676] = true, -- Fire Touch (destruction) (Destructive Clench - Rank 3) -- Fire
            [41003] = true, -- Shock Clench (Destructive Clench - Rank 3) -- Shock
            [62739] = true, -- Shock Clench (Destructive Clench - Rank 3) -- Shock
            [62738] = true, -- Shock Clench (Destructive Clench - Rank 3) -- Shock
            [68639] = true, -- Shock Touch (Destructive Clench - Rank 3) -- Shock
            [62740] = true, -- Shock Clench Explosion (Destructive Clench - Rank 3) -- Shock
            [41000] = true, -- Frost Clench (Destructive Clench - Rank 3) -- Frost
            [62708] = true, -- Frost Clench (Destructive Clench - Rank 3) -- Frost
            [62706] = true, -- Deep Freeze (Destructive Clench - Rank 3) -- Frost

            [41006] = true, -- Destructive Clench (Destructive Clench - Rank 4)
            [41009] = true, -- Flame Clench (Destructive Clench - Rank 4) -- Fire
            [62679] = true, -- Fire Clench (Destructive Clench - Rank 4) -- Fire
            [62681] = true, -- Stun After Knockback Movement (Destructive Clench - Rank 4) -- Fire
            [62680] = true, -- Fire Touch (destruction) (Destructive Clench - Rank 4) -- Fire
            [41016] = true, -- Shock Clench (Destructive Clench - Rank 4) -- Shock
            [62742] = true, -- Shock Clench (Destructive Clench - Rank 4) -- Shock
            [68634] = true, -- Shock Touch (Destructive Clench - Rank 4) -- Shock
            [62743] = true, -- Shock Clench Explosion (Destructive Clench - Rank 4) -- Shock
            [41013] = true, -- Frost Clench (Destructive Clench - Rank 4) -- Frost
            [62711] = true, -- Frost Clench (Destructive Clench - Rank 4) -- Frost
            [62709] = true, -- Deep Freeze (Destructive Clench - Rank 4) -- Frost

            [38937] = true, -- Destructive Reach (Destructive Reach - Rank 1)
            [38944] = true, -- Flame Reach (Destructive Reach - Rank 1) -- Fire
            [62682] = true, -- Flame Reach (Destructive Reach - Rank 1) -- Fire
            [38946] = true, -- Stun After Knockback Movement (Destructive Reach - Rank 1) -- Fire
            [38945] = true, -- Flame Reach (destruction) (Destructive Reach - Rank 1) -- Fire
            [38978] = true, -- Shock Reach (Destructive Reach - Rank 1) -- Shock
            [62745] = true, -- Shock Reach (Destructive Reach - Rank 1) -- Shock
            [68574] = true, -- Shock Touch (Destructive Reach - Rank 1) -- Shock
            [38970] = true, -- Frost Reach (Destructive Reach - Rank 1) -- Frost
            [62712] = true, -- Frost Reach (Destructive Reach - Rank 1) -- Frost
            [38971] = true, -- Frost Grip (Destructive Reach - Rank 1) -- Frost

            [41029] = true, -- Destructive Reach (Destructive Reach - Rank 2)
            [41030] = true, -- Flame Reach (Destructive Reach - Rank 2) -- Fire
            [62685] = true, -- Flame Reach (Destructive Reach - Rank 2) -- Fire
            [62683] = true, -- Stun After Knockback Movement (Destructive Reach - Rank 2) -- Fire
            [62684] = true, -- Flame Reach (destruction) (Destructive Reach - Rank 2) -- Fire
            [41036] = true, -- Shock Reach (Destructive Reach - Rank 2) -- Shock
            [62764] = true, -- Shock Reach (Destructive Reach - Rank 2) -- Shock
            [68575] = true, -- Shock Touch (Destructive Reach - Rank 2) -- Shock
            [41033] = true, -- Frost Reach (Destructive Reach - Rank 2) -- Frost
            [62715] = true, -- Frost Reach (Destructive Reach - Rank 2) -- Frost
            [62713] = true, -- Frost Grip (Destructive Reach - Rank 2) -- Frost

            [41038] = true, -- Destructive Reach (Destructive Reach - Rank 3)
            [41039] = true, -- Flame Reach (Destructive Reach - Rank 3) -- Fire
            [62688] = true, -- Flame Reach (Destructive Reach - Rank 3) -- Fire
            [62686] = true, -- Stun After Knockback Movement (Destructive Reach - Rank 3) -- Fire
            [62687] = true, -- Flame Reach (destruction) (Destructive Reach - Rank 3) -- Fire
            [41045] = true, -- Shock Reach (Destructive Reach - Rank 3) -- Shock
            [62766] = true, -- Shock Reach (Destructive Reach - Rank 3) -- Shock
            [68576] = true, -- Shock Touch (Destructive Reach - Rank 3) -- Shock
            [41042] = true, -- Frost Reach (Destructive Reach - Rank 3) -- Frost
            [62718] = true, -- Frost Reach (Destructive Reach - Rank 3) -- Frost
            [62716] = true, -- Frost Grip (Destructive Reach - Rank 3) -- Frost

            [41047] = true, -- Destructive Reach (Destructive Reach - Rank 4)
            [41048] = true, -- Flame Reach (Destructive Reach - Rank 4) -- Fire
            [62691] = true, -- Flame Reach (Destructive Reach - Rank 4) -- Fire
            [62689] = true, -- Stun After Knockback Movement (Destructive Reach - Rank 4) -- Fire
            [62690] = true, -- Flame Reach (destruction) (Destructive Reach - Rank 4) -- Fire
            [41054] = true, -- Shock Reach (Destructive Reach - Rank 4) -- Shock
            [62768] = true, -- Shock Reach (Destructive Reach - Rank 4) -- Shock
            [68577] = true, -- Shock Touch (Destructive Reach - Rank 4) -- Shock
            [41051] = true, -- Frost Reach (Destructive Reach - Rank 4) -- Frost
            [62721] = true, -- Frost Reach (Destructive Reach - Rank 4) -- Frost
            [62719] = true, -- Frost Grip (Destructive Reach - Rank 4) -- Frost

            [29173] = true, -- Weakness to Elements (Weakness to Elements - Rank 1)
            [53881] = true, -- Major Spell Shatter (Weakness to Elements - Rank 1)
            [41544] = true, -- Weakness to Elements (Weakness to Elements - Rank 2)
            [62772] = true, -- Major Spell Shatter (Weakness to Elements - Rank 2)
            [41546] = true, -- Weakness to Elements (Weakness to Elements - Rank 3)
            [62773] = true, -- Major Spell Shatter (Weakness to Elements - Rank 3)
            [41548] = true, -- Weakness to Elements (Weakness to Elements - Rank 4)
            [62774] = true, -- Major Spell Shatter (Weakness to Elements - Rank 4)

            [39089] = true, -- Elemental Susceptibility (Elemental Susceptibility - Rank 1)
            [62775] = true, -- Major Breach (Elemental Susceptibility - Rank 1)

            [41550] = true, -- Elemental Susceptibility (Elemental Susceptibility - Rank 2)
            [62780] = true, -- Major Breach (Elemental Susceptibility - Rank 2)

            [41553] = true, -- Elemental Susceptibility (Elemental Susceptibility - Rank 3)
            [62783] = true, -- Major Breach (Elemental Susceptibility - Rank 3)

            [41556] = true, -- Elemental Susceptibility (Elemental Susceptibility - Rank 4)
            [62786] = true, -- Major Breach (Elemental Susceptibility - Rank 4)

            [39095] = true, -- Elemental Drain (Elemental Drain - Rank 1)
            [39100] = true, -- Minor Magickasteal (Elemental Drain - Rank 1)
            [62787] = true, -- Major Breach (Elemental Drain - Rank 1)
            [39099] = true, -- Minor Magickasteal (Elemental Drain - Rank 1)

            [41559] = true, -- Elemental Drain (Elemental Drain - Rank 2)
            [62790] = true, -- Minor Magickasteal (Elemental Drain - Rank 2)
            [62789] = true, -- Major Breach (Elemental Drain - Rank 2)
            [62788] = true, -- Minor Magickasteal (Elemental Drain - Rank 2)

            [41563] = true, -- Elemental Drain (Elemental Drain - Rank 3)
            [62793] = true, -- Minor Magickasteal (Elemental Drain - Rank 3)
            [62792] = true, -- Major Breach (Elemental Drain - Rank 3)
            [62791] = true, -- Minor Magickasteal (Elemental Drain - Rank 3)

            [41567] = true, -- Elemental Drain (Elemental Drain - Rank 4)
            [62796] = true, -- Minor Magickasteal (Elemental Drain - Rank 4)
            [62795] = true, -- Major Breach (Elemental Drain - Rank 4)
            [62794] = true, -- Minor Magickasteal (Elemental Drain - Rank 4)

            [28800] = true, -- Impulse (Impulse - Rank 1)
            [28794] = true, -- Fire Impulse (Impulse - Rank 1)
            [28799] = true, -- Shock Impulse (Impulse - Rank 1)
            [28798] = true, -- Frost Impulse (Impulse - Rank 1)

            [42949] = true, -- Impulse (Impulse - Rank 2)
            [42950] = true, -- Fire Impulse (Impulse - Rank 2)
            [42952] = true, -- Shock Impulse (Impulse - Rank 2)
            [42951] = true, -- Frost Impulse (Impulse - Rank 2)

            [42953] = true, -- Impulse (Impulse - Rank 3)
            [42954] = true, -- Fire Impulse (Impulse - Rank 3)
            [42956] = true, -- Shock Impulse (Impulse - Rank 3)
            [42955] = true, -- Frost Impulse (Impulse - Rank 3)

            [42957] = true, -- Impulse (Impulse - Rank 4)
            [42958] = true, -- Fire Impulse (Impulse - Rank 4)
            [42960] = true, -- Shock Impulse (Impulse - Rank 4)
            [42959] = true, -- Frost Impulse (Impulse - Rank 4)

            [39143] = true, -- Elemental Ring (Elemental Ring - Rank 1)
            [39145] = true, -- Elemental Ring (Fire Ring - Rank 1)
            [39149] = true, -- Elemental Ring (Fire Ring - Rank 1)
            [39147] = true, -- Elemental Ring (Shock Ring - Rank 1)
            [39153] = true, -- Elemental Ring (Shock Ring - Rank 1)
            [39146] = true, -- Elemental Ring (Frost Ring - Rank 1)
            [39151] = true, -- Elemental Ring (Frost Ring - Rank 1)

            [42961] = true, -- Elemental Ring (Elemental Ring - Rank 2)
            [42962] = true, -- Elemental Ring (Fire Ring - Rank 2)
            [42963] = true, -- Elemental Ring (Fire Ring - Rank 2)
            [42966] = true, -- Elemental Ring (Shock Ring - Rank 2)
            [42967] = true, -- Elemental Ring (Shock Ring - Rank 2)
            [42964] = true, -- Elemental Ring (Frost Ring - Rank 2)
            [42965] = true, -- Elemental Ring (Frost Ring - Rank 2)

            [42968] = true, -- Elemental Ring (Elemental Ring - Rank 3)
            [42969] = true, -- Elemental Ring (Fire Ring - Rank 3)
            [42970] = true, -- Elemental Ring (Fire Ring - Rank 3)
            [42973] = true, -- Elemental Ring (Shock Ring - Rank 3)
            [42974] = true, -- Elemental Ring (Shock Ring - Rank 3)
            [42971] = true, -- Elemental Ring (Frost Ring - Rank 3)
            [42972] = true, -- Elemental Ring (Frost Ring - Rank 3)

            [42975] = true, -- Elemental Ring (Elemental Ring - Rank 4)
            [42976] = true, -- Elemental Ring (Fire Ring - Rank 4)
            [42977] = true, -- Elemental Ring (Fire Ring - Rank 4)
            [42980] = true, -- Elemental Ring (Shock Ring - Rank 4)
            [42981] = true, -- Elemental Ring (Shock Ring - Rank 4)
            [42978] = true, -- Elemental Ring (Frost Ring - Rank 4)
            [42979] = true, -- Elemental Ring (Frost Ring - Rank 4)

            [39161] = true, -- Pulsar (Pulsar - Rank 1)
            [39162] = true, -- Flame Pulsar (Pulsar - Rank 1)
            [39167] = true, -- Storm Pulsar (Pulsar - Rank 1)
            [39181] = true, -- Minor Mangle (Pulsar - Rank 1)
            [39163] = true, -- Frost Pulsar (Pulsar - Rank 1)
            [39180] = true, -- Minor Mangle (Pulsar - Rank 1)

            [42982] = true, -- Pulsar (Pulsar - Rank 2)
            [42983] = true, -- Flame Pulsar (Pulsar - Rank 2)
            [42984] = true, -- Minor Mangle (Pulsar - Rank 2)
            [42987] = true, -- Storm Pulsar (Pulsar - Rank 2)
            [42988] = true, -- Minor Mangle (Pulsar - Rank 2)
            [42985] = true, -- Frost Pulsar (Pulsar - Rank 2)
            [42986] = true, -- Minor Mangle (Pulsar - Rank 2)

            [42989] = true, -- Pulsar (Pulsar - Rank 3)
            [42990] = true, -- Flame Pulsar (Pulsar - Rank 3)
            [42991] = true, -- Minor Mangle (Pulsar - Rank 3)
            [42994] = true, -- Storm Pulsar (Pulsar - Rank 3)
            [42995] = true, -- Minor Mangle (Pulsar - Rank 3)
            [42992] = true, -- Frost Pulsar (Pulsar - Rank 3)
            [42993] = true, -- Minor Mangle (Pulsar - Rank 3)

            [42996] = true, -- Pulsar (Pulsar - Rank 4)
            [42997] = true, -- Flame Pulsar (Pulsar - Rank 4)
            [42998] = true, -- Minor Mangle (Pulsar - Rank 4)
            [43001] = true, -- Storm Pulsar (Pulsar - Rank 4)
            [43002] = true, -- Minor Mangle (Pulsar - Rank 4)
            [42999] = true, -- Frost Pulsar (Pulsar - Rank 4)
            [43000] = true, -- Minor Mangle (Pulsar - Rank 4)

            [83619] = true, -- Elemental Storm (Elemental Storm - Rank 1)
            [83625] = true, -- Fire Storm (Elemental Storm - Rank 1)
            [83626] = true, -- Fire Storm (Elemental Storm - Rank 1)
            [83630] = true, -- Thunder Storm (Elemental Storm - Rank 1)
            [83631] = true, -- Thunder Storm (Elemental Storm - Rank 1)
            [83628] = true, -- Ice Storm (Elemental Storm - Rank 1)
            [83629] = true, -- Ice Storm (Elemental Storm - Rank 1)

            [86481] = true, -- Elemental Storm (Elemental Storm - Rank 2)
            [86488] = true, -- Fire Storm (Elemental Storm - Rank 2)
            [86489] = true, -- Fire Storm (Elemental Storm - Rank 2)
            [86500] = true, -- Thunder Storm (Elemental Storm - Rank 2)
            [86501] = true, -- Thunder Storm (Elemental Storm - Rank 2)
            [86494] = true, -- Ice Storm (Elemental Storm - Rank 2)
            [86495] = true, -- Ice Storm (Elemental Storm - Rank 2)

            [86483] = true, -- Elemental Storm (Elemental Storm - Rank 3)
            [86490] = true, -- Fire Storm (Elemental Storm - Rank 3)
            [86491] = true, -- Fire Storm (Elemental Storm - Rank 3)
            [86502] = true, -- Thunder Storm (Elemental Storm - Rank 3)
            [86503] = true, -- Thunder Storm (Elemental Storm - Rank 3)
            [86496] = true, -- Ice Storm (Elemental Storm - Rank 3)
            [86497] = true, -- Ice Storm (Elemental Storm - Rank 3)

            [86485] = true, -- Elemental Storm (Elemental Storm - Rank 4)
            [86492] = true, -- Fire Storm (Elemental Storm - Rank 4)
            [86493] = true, -- Fire Storm (Elemental Storm - Rank 4)
            [86504] = true, -- Thunder Storm (Elemental Storm - Rank 4)
            [86505] = true, -- Thunder Storm (Elemental Storm - Rank 4)
            [86498] = true, -- Ice Storm (Elemental Storm - Rank 4)
            [86499] = true, -- Ice Storm (Elemental Storm - Rank 4)

            [87309] = true, -- Icy Rage (Elemental Rage - All Ranks)

            [84434] = true, -- Elemental Rage (Elemental Rage - Rank 1)
            [85126] = true, -- Fiery Rage (Elemental Rage - Rank 1)
            [85127] = true, -- Fiery Rage (Elemental Rage - Rank 1)
            [85130] = true, -- Thunderous Rage (Elemental Rage - Rank 1)
            [85131] = true, -- Thunderous Rage (Elemental Rage - Rank 1)
            [85128] = true, -- Icy Rage (Elemental Rage - Rank 1)
            [85129] = true, -- Icy Rage (Elemental Rage - Rank 1)

            [86506] = true, -- Elemental Rage (Elemental Rage - Rank 2)
            [86512] = true, -- Fiery Rage (Elemental Rage - Rank 2)
            [86517] = true, -- Fiery Rage (Elemental Rage - Rank 2)
            [86524] = true, -- Thunderous Rage (Elemental Rage - Rank 2)
            [86525] = true, -- Thunderous Rage (Elemental Rage - Rank 2)
            [86518] = true, -- Icy Rage (Elemental Rage - Rank 2)
            [86519] = true, -- Icy Rage (Elemental Rage - Rank 2)

            [86508] = true, -- Elemental Rage (Elemental Rage - Rank 3)
            [86513] = true, -- Fiery Rage (Elemental Rage - Rank 3)
            [86514] = true, -- Fiery Rage (Elemental Rage - Rank 3)
            [86526] = true, -- Thunderous Rage (Elemental Rage - Rank 3)
            [86527] = true, -- Thunderous Rage (Elemental Rage - Rank 3)
            [86520] = true, -- Icy Rage (Elemental Rage - Rank 3)
            [86521] = true, -- Icy Rage (Elemental Rage - Rank 3)

            [86510] = true, -- Elemental Rage (Elemental Rage - Rank 4)
            [86515] = true, -- Fiery Rage (Elemental Rage - Rank 4)
            [86516] = true, -- Fiery Rage (Elemental Rage - Rank 4)
            [86528] = true, -- Thunderous Rage (Elemental Rage - Rank 4)
            [86529] = true, -- Thunderous Rage (Elemental Rage - Rank 4)
            [86522] = true, -- Icy Rage (Elemental Rage - Rank 4)
            [86523] = true, -- Icy Rage (Elemental Rage - Rank 4)

            [83642] = true, -- Eye of the Storm (Eye of the Storm - Rank 1)
            [83682] = true, -- Eye of Flame (Eye of the Storm - Rank 1)
            [83683] = true, -- Eye of Flame (Eye of the Storm - Rank 1)
            [83686] = true, -- Eye of Lightning (Eye of the Storm - Rank 1)
            [83687] = true, -- Eye of Lightning (Eye of the Storm - Rank 1)
            [83684] = true, -- Eye of Frost (Eye of the Storm - Rank 1)
            [83685] = true, -- Eye of Frost (Eye of the Storm - Rank 1)

            [86530] = true, -- Eye of the Storm (Eye of the Storm - Rank 2)
            [86536] = true, -- Eye of Flame (Eye of the Storm - Rank 2)
            [86537] = true, -- Eye of Flame (Eye of the Storm - Rank 2)
            [86548] = true, -- Eye of Lightning (Eye of the Storm - Rank 2)
            [86549] = true, -- Eye of Lightning (Eye of the Storm - Rank 2)
            [86542] = true, -- Eye of Frost (Eye of the Storm - Rank 2)
            [86543] = true, -- Eye of Frost (Eye of the Storm - Rank 2)

            [86532] = true, -- Eye of the Storm (Eye of the Storm - Rank 3)
            [86538] = true, -- Eye of Flame (Eye of the Storm - Rank 3)
            [86539] = true, -- Eye of Flame (Eye of the Storm - Rank 3)
            [86550] = true, -- Eye of Lightning (Eye of the Storm - Rank 3)
            [86551] = true, -- Eye of Lightning (Eye of the Storm - Rank 3)
            [86544] = true, -- Eye of Frost (Eye of the Storm - Rank 3)
            [86545] = true, -- Eye of Frost (Eye of the Storm - Rank 3)

            [86534] = true, -- Eye of the Storm (Eye of the Storm - Rank 4)
            [86540] = true, -- Eye of Flame (Eye of the Storm - Rank 4)
            [86541] = true, -- Eye of Flame (Eye of the Storm - Rank 4)
            [86552] = true, -- Eye of Lightning (Eye of the Storm - Rank 4)
            [86553] = true, -- Eye of Lightning (Eye of the Storm - Rank 4)
            [86546] = true, -- Eye of Frost (Eye of the Storm - Rank 4)
            [86547] = true, -- Eye of Frost (Eye of the Storm - Rank 4)

            -- RESTORATION STAFF
            [52515] = true, -- Grand Healing Fx (Grand Healing - All Ranks)
            [28385] = true, -- Grand Healing (Grand Healing - Rank 1)
            [28386] = true, -- Grand Healing (Grand Healing - Rank 1)
            [41244] = true, -- Grand Healing (Grand Healing - Rank 2)
            [41245] = true, -- Grand Healing (Grand Healing - Rank 2)
            [41246] = true, -- Grand Healing (Grand Healing - Rank 3)
            [41247] = true, -- Grand Healing (Grand Healing - Rank 3)
            [41248] = true, -- Grand Healing (Grand Healing - Rank 4)
            [41249] = true, -- Grand Healing (Grand Healing - Rank 4)

            [40058] = true, -- Illustrious Healing (Illustrious Healing - Rank 1)
            [40059] = true, -- Illustrious Healing (Illustrious Healing - Rank 1)

            [41251] = true, -- Illustrious Healing (Illustrious Healing - Rank 2)
            [41252] = true, -- Illustrious Healing (Illustrious Healing - Rank 2)

            [41253] = true, -- Illustrious Healing (Illustrious Healing - Rank 3)
            [41254] = true, -- Illustrious Healing (Illustrious Healing - Rank 3)

            [41255] = true, -- Illustrious Healing (Illustrious Healing - Rank 4)
            [41256] = true, -- Illustrious Healing (Illustrious Healing - Rank 4)

            [40060] = true, -- Healing Springs (Healing Springs - Rank 1)
            [40061] = true, -- Healing Springs (Healing Springs - Rank 1)
            [40062] = true, -- Healing Springs (Healing Springs - Rank 1)

            [41257] = true, -- Healing Springs (Healing Springs - Rank 2)
            [41258] = true, -- Healing Springs (Healing Springs - Rank 2)
            [41259] = true, -- Healing Springs (Healing Springs - Rank 2)

            [41261] = true, -- Healing Springs (Healing Springs - Rank 3)
            [41262] = true, -- Healing Springs (Healing Springs - Rank 3)
            [41263] = true, -- Healing Springs (Healing Springs - Rank 3)

            [41265] = true, -- Healing Springs (Healing Springs - Rank 4)
            [41266] = true, -- Healing Springs (Healing Springs - Rank 4)
            [41267] = true, -- Healing Springs (Healing Springs - Rank 4)

            [57452] = true, -- Regeneration Dummy (Regeneration - All Ranks)
            [46257] = true, -- Regeneration (Regeneration - Rank 1)
            [28536] = true, -- Regeneration (Regeneration - Rank 1)
            [46259] = true, -- Regeneration (Regeneration - Rank 2)
            [41269] = true, -- Regeneration (Regeneration - Rank 2)
            [41270] = true, -- Regeneration (Regeneration - Rank 3)
            [46260] = true, -- Regeneration (Regeneration - Rank 3)
            [41271] = true, -- Regeneration (Regeneration - Rank 4)
            [46261] = true, -- Regeneration (Regeneration - Rank 4)

            [57466] = true, -- Rapid Regeneration Dummy (Rapid Regeneration - All Ranks)

            [46262] = true, -- Regeneration (Rapid Regeneration - Rank 1)
            [40076] = true, -- Rapid Regeneration (Rapid Regeneration - Rank 1)

            [46263] = true, -- Regeneration (Rapid Regeneration - Rank 2)
            [41272] = true, -- Rapid Regeneration (Rapid Regeneration - Rank 2)

            [46264] = true, -- Regeneration (Rapid Regeneration - Rank 3)
            [41274] = true, -- Rapid Regeneration (Rapid Regeneration - Rank 3)

            [46265] = true, -- Regeneration (Rapid Regeneration - Rank 4)
            [41276] = true, -- Rapid Regeneration (Rapid Regeneration - Rank 4)

            [57468] = true, -- Mutagen Dummy (Mutagen - All Ranks)

            [46266] = true, -- Mutagen (Mutagen - Rank 1)
            [40079] = true, -- Mutagen (Mutagen - Rank 1)
            [40081] = true, -- Mutagen (Mutagen - Rank 1)

            [46267] = true, -- Mutagen (Mutagen - Rank 2)
            [41278] = true, -- Mutagen (Mutagen - Rank 2)
            [41280] = true, -- Mutagen (Mutagen - Rank 2)

            [46268] = true, -- Mutagen (Mutagen - Rank 3)
            [41283] = true, -- Mutagen (Mutagen - Rank 3)
            [41285] = true, -- Mutagen (Mutagen - Rank 3)

            [46269] = true, -- Mutagen (Mutagen - Rank 4)
            [41288] = true, -- Mutagen (Mutagen - Rank 4)
            [41290] = true, -- Mutagen (Mutagen - Rank 4)

            [37243] = true, -- Blessing of Protection (Blessing of Protection - Rank 1)
            [37247] = true, -- Minor Resolve (Blessing of Protection - Rank 1)
            [62619] = true, -- Minor Ward (Blessing of Protection - Rank 1)
            [38300] = true, -- Blessing of Protection (Blessing of Protection - Rank 1)
            [38299] = true, -- Blessing of Protection (Blessing of Protection - Rank 1)
            [38298] = true, -- Blessing of Protection (Blessing of Protection - Rank 1)

            [41139] = true, -- Blessing of Protection (Blessing of Protection - Rank 2)
            [62620] = true, -- Minor Resolve (Blessing of Protection - Rank 2)
            [62621] = true, -- Minor Ward (Blessing of Protection - Rank 2)
            [41142] = true, -- Blessing of Protection (Blessing of Protection - Rank 2)
            [41144] = true, -- Blessing of Protection (Blessing of Protection - Rank 2)
            [41141] = true, -- Blessing of Protection (Blessing of Protection - Rank 2)

            [41145] = true, -- Blessing of Protection (Blessing of Protection - Rank 3)
            [62622] = true, -- Minor Resolve (Blessing of Protection - Rank 3)
            [62623] = true, -- Minor Ward (Blessing of Protection - Rank 3)
            [41148] = true, -- Blessing of Protection (Blessing of Protection - Rank 3)
            [41147] = true, -- Blessing of Protection (Blessing of Protection - Rank 3)
            [41150] = true, -- Blessing of Protection (Blessing of Protection - Rank 3)

            [41151] = true, -- Blessing of Protection (Blessing of Protection - Rank 4)
            [62624] = true, -- Minor Resolve (Blessing of Protection - Rank 4)
            [62625] = true, -- Minor Ward (Blessing of Protection - Rank 4)
            [41154] = true, -- Blessing of Protection (Blessing of Protection - Rank 4)
            [41153] = true, -- Blessing of Protection (Blessing of Protection - Rank 4)
            [41156] = true, -- Blessing of Protection (Blessing of Protection - Rank 4)

            [40103] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 1)
            [62626] = true, -- Minor Resolve (Blessing of Restoration - Rank 1)
            [62627] = true, -- Minor Ward (Blessing of Restoration - Rank 1)
            [40106] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 1)
            [40108] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 1)
            [40105] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 1)

            [41157] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 2)
            [62628] = true, -- Minor Resolve (Blessing of Restoration - Rank 2)
            [62629] = true, -- Minor Ward (Blessing of Restoration - Rank 2)
            [41160] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 2)
            [41162] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 2)
            [41159] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 2)

            [41163] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 3)
            [62630] = true, -- Minor Resolve (Blessing of Restoration - Rank 3)
            [62631] = true, -- Minor Ward (Blessing of Restoration - Rank 3)
            [41166] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 3)
            [41168] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 3)
            [41165] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 3)

            [41169] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 4)
            [62632] = true, -- Minor Resolve (Blessing of Restoration - Rank 4)
            [62633] = true, -- Minor Ward (Blessing of Restoration - Rank 4)
            [41172] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 4)
            [41174] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 4)
            [41171] = true, -- Blessing of Restoration (Blessing of Restoration - Rank 4)

            [40094] = true, -- Combat Prayer (Combat Prayer - Rank 1)
            [62634] = true, -- Minor Resolve (Combat Prayer - Rank 1)
            [62635] = true, -- Minor Ward (Combat Prayer - Rank 1)
            [62636] = true, -- Minor Berserk (Combat Prayer - Rank 1)
            [40097] = true, -- Combat Prayer (Combat Prayer - Rank 1)
            [40096] = true, -- Combat Prayer (Combat Prayer - Rank 1)
            [40099] = true, -- Combat Prayer (Combat Prayer - Rank 1)

            [41175] = true, -- Combat Prayer (Combat Prayer - Rank 2)
            [62637] = true, -- Minor Resolve (Combat Prayer - Rank 2)
            [62638] = true, -- Minor Ward (Combat Prayer - Rank 2)
            [62639] = true, -- Minor Berserk (Combat Prayer - Rank 2)
            [41178] = true, -- Combat Prayer (Combat Prayer - Rank 2)
            [41181] = true, -- Combat Prayer (Combat Prayer - Rank 2)
            [41177] = true, -- Combat Prayer (Combat Prayer - Rank 2)

            [41182] = true, -- Combat Prayer (Combat Prayer - Rank 3)
            [62640] = true, -- Minor Resolve (Combat Prayer - Rank 3)
            [62641] = true, -- Minor Ward (Combat Prayer - Rank 3)
            [62642] = true, -- Minor Berserk (Combat Prayer - Rank 3)
            [41185] = true, -- Combat Prayer (Combat Prayer - Rank 3)
            [41188] = true, -- Combat Prayer (Combat Prayer - Rank 3)
            [41184] = true, -- Combat Prayer (Combat Prayer - Rank 3)

            [41189] = true, -- Combat Prayer (Combat Prayer - Rank 4)
            [62643] = true, -- Minor Resolve (Combat Prayer - Rank 4)
            [62644] = true, -- Minor Ward (Combat Prayer - Rank 4)
            [62645] = true, -- Minor Berserk (Combat Prayer - Rank 4)
            [41192] = true, -- Combat Prayer (Combat Prayer - Rank 4)
            [41195] = true, -- Combat Prayer (Combat Prayer - Rank 4)
            [41191] = true, -- Combat Prayer (Combat Prayer - Rank 4)

            [37232] = true, -- Steadfast Ward (Steadfast Ward - Rank 1)
            [37235] = true, -- Steadfast Ward (Steadfast Ward - Rank 1)
            [41306] = true, -- Steadfast Ward (Steadfast Ward - Rank 2)
            [41307] = true, -- Steadfast Ward (Steadfast Ward - Rank 2)
            [41308] = true, -- Steadfast Ward (Steadfast Ward - Rank 3)
            [41309] = true, -- Steadfast Ward (Steadfast Ward - Rank 3)
            [41310] = true, -- Steadfast Ward (Steadfast Ward - Rank 4)
            [41311] = true, -- Steadfast Ward (Steadfast Ward - Rank 4)

            [40130] = true, -- Ward Ally (Ward Ally - Rank 1)
            [41293] = true, -- Ward Ally (Ward Ally - Rank 1)
            [40132] = true, -- Ward Ally (Ward Ally - Rank 1)
            [40131] = true, -- Ward Ally (Ward Ally - Rank 1)

            [41294] = true, -- Ward Ally (Ward Ally - Rank 2)
            [41297] = true, -- Ward Ally (Ward Ally - Rank 2)
            [41296] = true, -- Ward Ally (Ward Ally - Rank 2)
            [41295] = true, -- Ward Ally (Ward Ally - Rank 2)

            [41298] = true, -- Ward Ally (Ward Ally - Rank 3)
            [41301] = true, -- Ward Ally (Ward Ally - Rank 3)
            [41300] = true, -- Ward Ally (Ward Ally - Rank 3)
            [41299] = true, -- Ward Ally (Ward Ally - Rank 3)

            [41302] = true, -- Ward Ally (Ward Ally - Rank 4)
            [41305] = true, -- Ward Ally (Ward Ally - Rank 4)
            [41304] = true, -- Ward Ally (Ward Ally - Rank 4)
            [41303] = true, -- Ward Ally (Ward Ally - Rank 4)

            [40126] = true, -- Healing Ward (Healing Ward - Rank 1)
            [40127] = true, -- Healing Ward (Healing Ward - Rank 1)
            [49068] = true, -- Grand Healing (Healing Ward - Rank 1)
            [40128] = true, -- Healing Ward (Healing Ward - Rank 1)

            [41212] = true, -- Healing Ward (Healing Ward - Rank 2)
            [41313] = true, -- Healing Ward (Healing Ward - Rank 2)
            [49069] = true, -- Grand Healing (Healing Ward - Rank 2)
            [41314] = true, -- Healing Ward (Healing Ward - Rank 2)

            [41317] = true, -- Healing Ward (Healing Ward - Rank 3)
            [41316] = true, -- Healing Ward (Healing Ward - Rank 3)
            [49071] = true, -- Grand Healing (Healing Ward - Rank 3)
            [41318] = true, -- Healing Ward (Healing Ward - Rank 3)

            [41321] = true, -- Healing Ward (Healing Ward - Rank 4)
            [41320] = true, -- Healing Ward (Healing Ward - Rank 4)
            [49070] = true, -- Grand Healing (Healing Ward - Rank 4)
            [41322] = true, -- Healing Ward (Healing Ward - Rank 4)

            [31531] = true, -- Force Siphon (Force Siphon - Rank 1)
            [88565] = true, -- Minor Lifesteal (Force Siphon - Rank 1)
            [33541] = true, -- Minor Lifesteal (Force Siphon - Rank 1)

            [41199] = true, -- Force Siphon (Force Siphon - Rank 2)
            [88568] = true, -- Minor Lifesteal (Force Siphon - Rank 2)
            [41200] = true, -- Minor Lifesteal (Force Siphon - Rank 2)

            [41203] = true, -- Force Siphon (Force Siphon - Rank 3)
            [88573] = true, -- Minor Lifesteal (Force Siphon - Rank 3)
            [41204] = true, -- Minor Lifesteal (Force Siphon - Rank 3)

            [41207] = true, -- Force Siphon (Force Siphon - Rank 4)
            [88574] = true, -- Minor Lifesteal (Force Siphon - Rank 4)
            [41208] = true, -- Minor Lifesteal (Force Siphon - Rank 4)

            [40109] = true, -- Siphon Spirit (Siphon Spirit - Rank 1)
            [88575] = true, -- Minor Lifesteal (Siphon Spirit - Rank 1)
            [88576] = true, -- Minor Lifesteal (Siphon Spirit - Rank 1)
            [40110] = true, -- Minor Lifesteal (Siphon Spirit - Rank 1)
            [40114] = true, -- Minor Magickasteal (Siphon Spirit - Rank 1)

            [41211] = true, -- Siphon Spirit (Siphon Spirit - Rank 2)
            [88584] = true, -- Minor Lifesteal (Siphon Spirit - Rank 2)
            [88585] = true, -- Minor Lifesteal (Siphon Spirit - Rank 2)
            [41219] = true, -- Minor Lifesteal (Siphon Spirit - Rank 2)
            [41216] = true, -- Minor Magickasteal (Siphon Spirit - Rank 2)

            [41220] = true, -- Siphon Spirit (Siphon Spirit - Rank 3)
            [88587] = true, -- Minor Lifesteal (Siphon Spirit - Rank 3)
            [88588] = true, -- Minor Lifesteal (Siphon Spirit - Rank 3)
            [41224] = true, -- Minor Lifesteal (Siphon Spirit - Rank 3)
            [41221] = true, -- Minor Magickasteal (Siphon Spirit - Rank 3)

            [41225] = true, -- Siphon Spirit (Siphon Spirit - Rank 4)
            [88604] = true, -- Minor Lifesteal (Siphon Spirit - Rank 4)
            [88605] = true, -- Minor Lifesteal (Siphon Spirit - Rank 4)
            [41229] = true, -- Minor Lifesteal (Siphon Spirit - Rank 4)
            [41226] = true, -- Minor Magickasteal (Siphon Spirit - Rank 4)

            [40116] = true, -- Quick Siphon (Quick Siphon - Rank 1)
            [88606] = true, -- Minor Lifesteal (Quick Siphon - Rank 1)
            [40117] = true, -- Minor Lifesteal (Quick Siphon - Rank 1)

            [41230] = true, -- Quick Siphon (Quick Siphon - Rank 2)
            [88625] = true, -- Minor Lifesteal (Quick Siphon - Rank 2)
            [41231] = true, -- Minor Lifesteal (Quick Siphon - Rank 2)

            [41234] = true, -- Quick Siphon (Quick Siphon - Rank 3)
            [88628] = true, -- Minor Lifesteal (Quick Siphon - Rank 3)
            [41236] = true, -- Minor Lifesteal (Quick Siphon - Rank 3)

            [41239] = true, -- Quick Siphon (Quick Siphon - Rank 4)
            [88634] = true, -- Minor Lifesteal (Quick Siphon - Rank 4)
            [41240] = true, -- Minor Lifesteal (Quick Siphon - Rank 4)

            [83552] = true, -- Panacea (Panacea - Rank 1)
            [83844] = true, -- Panacea (Panacea - Rank 1)

            [86421] = true, -- Panacea (Panacea - Rank 2)
            [86422] = true, -- Panacea (Panacea - Rank 2)

            [86423] = true, -- Panacea (Panacea - Rank 3)
            [86424] = true, -- Panacea (Panacea - Rank 3)

            [86425] = true, -- Panacea (Panacea - Rank 4)
            [86426] = true, -- Panacea (Panacea - Rank 4)

            [83850] = true, -- Life Giver (Life Giver - Rank 1)
            [83851] = true, -- Life Giver (Life Giver - Rank 1)
            [83867] = true, -- Life Giver (Life Giver - Rank 1)
            [83876] = true, -- Life Giver (Life Giver - Rank 1)

            [86428] = true, -- Life Giver (Life Giver - Rank 2)
            [83436] = true, -- Life Giver (Life Giver - Rank 2)
            [83429] = true, -- Life Giver (Life Giver - Rank 2)
            [83437] = true, -- Life Giver (Life Giver - Rank 2)

            [86441] = true, -- Life Giver (Life Giver - Rank 3)
            [86449] = true, -- Life Giver (Life Giver - Rank 3)
            [86442] = true, -- Life Giver (Life Giver - Rank 3)
            [86450] = true, -- Life Giver (Life Giver - Rank 3)

            [86454] = true, -- Life Giver (Life Giver - Rank 4)
            [86462] = true, -- Life Giver (Life Giver - Rank 4)
            [86455] = true, -- Life Giver (Life Giver - Rank 4)
            [86463] = true, -- Life Giver (Life Giver - Rank 4)

            [85132] = true, -- Light's Champion (Light's Champion - Rank 1)
            [85133] = true, -- Light's Champion (Light's Champion - Rank 1)
            [85154] = true, -- Major Force (Light's Champion - Rank 1)
            [85155] = true, -- Major Protection (Light's Champion - Rank 1)
            [86467] = true, -- Light's Champion (Light's Champion - Rank 2)
            [86470] = true, -- Light's Champion (Light's Champion - Rank 2)
            [86468] = true, -- Major Force (Light's Champion - Rank 2)
            [86469] = true, -- Major Protection (Light's Champion - Rank 2)
            [86471] = true, -- Light's Champion (Light's Champion - Rank 3)
            [86474] = true, -- Light's Champion (Light's Champion - Rank 3)
            [86472] = true, -- Major Force (Light's Champion - Rank 3)
            [86473] = true, -- Major Protection (Light's Champion - Rank 3)
            [86475] = true, -- Light's Champion (Light's Champion - Rank 4)
            [86478] = true, -- Light's Champion (Light's Champion - Rank 4)
            [86476] = true, -- Major Force (Light's Champion - Rank 4)
            [86477] = true, -- Major Protection (Light's Champion - Rank 4)

            -- ARMOR (ACTIVE SKILLS)
            [29556] = true, -- Evasion (Evasion - Rank 1)
            [63015] = true, -- Major Evasion (Evasion - Rank 1)
            [41124] = true, -- Evasion (Evasion - Rank 2)
            [63016] = true, -- Major Evasion (Evasion - Rank 2)
            [41125] = true, -- Evasion (Evasion - Rank 3)
            [63017] = true, -- Major Evasion (Evasion - Rank 3)
            [41126] = true, -- Evasion (Evasion - Rank 4)
            [63018] = true, -- Major Evasion (Evasion - Rank 4)

            [39195] = true, -- Shuffle (Shuffle - Rank 1)
            [63019] = true, -- Major Evasion (Shuffle - Rank 1)
            [39196] = true, -- Shuffle (Shuffle - Rank 1)

            [41127] = true, -- Shuffle (Shuffle - Rank 2)
            [63023] = true, -- Major Evasion (Shuffle - Rank 2)
            [64581] = true, -- Shuffle (Shuffle - Rank 2)
            [63022] = true, -- Shuffle (Shuffle - Rank 2)

            [41129] = true, -- Shuffle (Shuffle - Rank 3)
            [63026] = true, -- Major Evasion (Shuffle - Rank 3)
            [64582] = true, -- Shuffle (Shuffle - Rank 3)
            [63025] = true, -- Shuffle (Shuffle - Rank 3)

            [41131] = true, -- Shuffle (Shuffle - Rank 4)
            [63028] = true, -- Major Evasion (Shuffle - Rank 4)
            [64583] = true, -- Shuffle (Shuffle - Rank 4)
            [63027] = true, -- Shuffle (Shuffle - Rank 4)

            [39192] = true, -- Elude (Elude - Rank 1)
            [63030] = true, -- Major Evasion (Elude - Rank 1)
            [41133] = true, -- Elude (Elude - Rank 2)
            [63036] = true, -- Major Evasion (Elude - Rank 2)
            [41135] = true, -- Elude (Elude - Rank 3)
            [63040] = true, -- Major Evasion (Elude - Rank 3)
            [41137] = true, -- Elude (Elude - Rank 4)
            [63042] = true, -- Major Evasion (Elude - Rank 4)

            -- FIGHTER'S GUILD (ACTIVE SKILLS)

            [35721] = true, -- Silver Bolts (Silver Bolts - Rank 1)
            [35736] = true, -- Silver Bolts (Silver Bolts - Rank 1)
            [42647] = true, -- Silver Bolts (Silver Bolts - Rank 2)
            [42649] = true, -- Silver Bolts (Silver Bolts - Rank 2)
            [42651] = true, -- Silver Bolts (Silver Bolts - Rank 3)
            [42653] = true, -- Silver Bolts (Silver Bolts - Rank 3)
            [42655] = true, -- Silver Bolts (Silver Bolts - Rank 4)
            [42657] = true, -- Silver Bolts (Silver Bolts - Rank 4)

            [40300] = true, -- Silver Shards (Silver Shards - Rank 1)
            [40302] = true, -- Silver Shards (Silver Shards - Rank 1)
            [40327] = true, -- Silver Shards (Silver Shards - Rank 1)

            [42659] = true, -- Silver Shards (Silver Shards - Rank 2)
            [42663] = true, -- Silver Shards (Silver Shards - Rank 2)
            [42660] = true, -- Silver Shards (Silver Shards - Rank 2)

            [42665] = true, -- Silver Shards (Silver Shards - Rank 3)
            [42669] = true, -- Silver Shards (Silver Shards - Rank 3)
            [42666] = true, -- Silver Shards (Silver Shards - Rank 3)

            [42671] = true, -- Silver Shards (Silver Shards - Rank 4)
            [42675] = true, -- Silver Shards (Silver Shards - Rank 4)
            [42672] = true, -- Silver Shards (Silver Shards - Rank 4)

            [40336] = true, -- Silver Leash (Silver Leash - Rank 1)
            [40340] = true, -- Silver Bolts (Silver Leash - Rank 1)
            [42102] = true, -- Silver Leash (Silver Leash - Rank 1)
            [40342] = true, -- Tighten (Silver Leash - Rank 1)
            [40345] = true, -- Tighten (Silver Leash - Rank 1)
            [40344] = true, -- Tighten (Silver Leash - Rank 1)

            [42677] = true, -- Silver Leash (Silver Leash - Rank 2)
            [42681] = true, -- Silver Bolts (Silver Leash - Rank 2)
            [42680] = true, -- Silver Leash (Silver Leash - Rank 2)
            [42682] = true, -- Tighten (Silver Leash - Rank 2)
            [42684] = true, -- Tighten (Silver Leash - Rank 2)
            [42683] = true, -- Tighten (Silver Leash - Rank 2)

            [42687] = true, -- Silver Leash (Silver Leash - Rank 3)
            [42690] = true, -- Silver Bolts (Silver Leash - Rank 3)
            [42689] = true, -- Silver Leash (Silver Leash - Rank 3)
            [42692] = true, -- Tighten (Silver Leash - Rank 3)
            [42694] = true, -- Tighten (Silver Leash - Rank 3)
            [42693] = true, -- Tighten (Silver Leash - Rank 3)

            [42696] = true, -- Silver Leash (Silver Leash - Rank 4)
            [42699] = true, -- Silver Bolts (Silver Leash - Rank 4)
            [42698] = true, -- Silver Leash (Silver Leash - Rank 4)
            [42701] = true, -- Tighten (Silver Leash - Rank 4)
            [42703] = true, -- Tighten (Silver Leash - Rank 4)
            [42702] = true, -- Tighten (Silver Leash - Rank 4)

            [101696] = true, -- Circle of Protection (Circle of Protection - All Ranks)
            [35737] = true, -- Circle of Protection (Circle of Protection - Rank 1)
            [80271] = true, -- Minor Endurance (Circle of Protection - Rank 1)
            [35739] = true, -- Minor Protection (Circle of Protection - Rank 1)
            [35738] = true, -- Circle of Protection (Circle of Protection - Rank 1)
            [42501] = true, -- Circle of Protection (Circle of Protection - Rank 2)
            [80272] = true, -- Minor Endurance (Circle of Protection - Rank 2)
            [42503] = true, -- Minor Protection (Circle of Protection - Rank 2)
            [42502] = true, -- Circle of Protection (Circle of Protection - Rank 2)
            [42505] = true, -- Circle of Protection (Circle of Protection - Rank 3)
            [80274] = true, -- Minor Endurance (Circle of Protection - Rank 3)
            [42507] = true, -- Minor Protection (Circle of Protection - Rank 3)
            [42506] = true, -- Circle of Protection (Circle of Protection - Rank 3)
            [42509] = true, -- Circle of Protection (Circle of Protection - Rank 4)
            [80275] = true, -- Minor Endurance (Circle of Protection - Rank 4)
            [42511] = true, -- Minor Protection (Circle of Protection - Rank 4)
            [42510] = true, -- Circle of Protection (Circle of Protection - Rank 4)

            [101697] = true, -- Turn Undead (Turn Undead - Rank 1)
            [40181] = true, -- Turn Undead (Turn Undead - Rank 1)
            [80276] = true, -- Minor Endurance (Turn Undead - Rank 1)
            [40185] = true, -- Minor Protection (Turn Undead - Rank 1)
            [40184] = true, -- Turn Undead (Turn Undead - Rank 1)
            [41947] = true, -- Turn Undead (Turn Undead - Rank 1)
            [40187] = true, -- Turn Undead (Turn Undead - Rank 1)

            [42515] = true, -- Turn Undead (Turn Undead - Rank 2)
            [80278] = true, -- Minor Endurance (Turn Undead - Rank 2)
            [42517] = true, -- Minor Protection (Turn Undead - Rank 2)
            [42516] = true, -- Turn Undead (Turn Undead - Rank 2)
            [42520] = true, -- Turn Undead (Turn Undead - Rank 2)
            [42521] = true, -- Turn Undead (Turn Undead - Rank 2)

            [42522] = true, -- Turn Undead (Turn Undead - Rank 3)
            [80279] = true, -- Minor Endurance (Turn Undead - Rank 3)
            [42524] = true, -- Minor Protection (Turn Undead - Rank 3)
            [42523] = true, -- Turn Undead (Turn Undead - Rank 3)
            [42527] = true, -- Turn Undead (Turn Undead - Rank 3)
            [42528] = true, -- Turn Undead (Turn Undead - Rank 3)

            [42529] = true, -- Turn Undead (Turn Undead - Rank 4)
            [80280] = true, -- Minor Endurance (Turn Undead - Rank 4)
            [42531] = true, -- Minor Protection (Turn Undead - Rank 4)
            [42530] = true, -- Turn Undead (Turn Undead - Rank 4)
            [42534] = true, -- Turn Undead (Turn Undead - Rank 4)
            [42535] = true, -- Turn Undead (Turn Undead - Rank 4)

            [40169] = true, -- Ring of Preservation (Ring of Preservation - Rank 1)
            [80284] = true, -- Minor Endurance (Ring of Preservation - Rank 1)
            [40171] = true, -- Minor Protection (Ring of Preservation - Rank 1)
            [80293] = true, -- Ring of Preservation (Ring of Preservation - Rank 1)
            [101699] = true, -- Ring of Protection (Ring of Preservation - Rank 1)
            [40170] = true, -- Ring of Preservation (Ring of Preservation - Rank 1)

            [42536] = true, -- Ring of Preservation (Ring of Preservation - Rank 2)
            [42538] = true, -- Minor Endurance (Ring of Preservation - Rank 2)
            [80285] = true, -- Minor Protection (Ring of Preservation - Rank 2)
            [80289] = true, -- Ring of Preservation (Ring of Preservation - Rank 2)
            [42537] = true, -- Ring of Preservation (Ring of Preservation - Rank 2)

            [42542] = true, -- Ring of Preservation (Ring of Preservation - Rank 3)
            [42544] = true, -- Minor Endurance (Ring of Preservation - Rank 3)
            [80286] = true, -- Minor Protection (Ring of Preservation - Rank 3)
            [80294] = true, -- Ring of Preservation (Ring of Preservation - Rank 3)
            [42543] = true, -- Ring of Preservation (Ring of Preservation - Rank 3)

            [42548] = true, -- Ring of Preservation (Ring of Preservation - Rank 4)
            [42550] = true, -- Minor Endurance (Ring of Preservation - Rank 4)
            [80287] = true, -- Minor Protection (Ring of Preservation - Rank 4)
            [80295] = true, -- Ring of Preservation (Ring of Preservation - Rank 4)
            [42549] = true, -- Ring of Preservation (Ring of Preservation - Rank 4)

            [35765] = true, -- Sense Evil (Expert Hunter - All Ranks)
            [64509] = true, -- Major Savagery (Expert Hunter - All Ranks)
            [35762] = true, -- Expert Hunter (Expert Hunter - Rank 1)
            [80307] = true, -- Expert Hunter (Expert Hunter - Rank 1)
            [42602] = true, -- Expert Hunter (Expert Hunter - Rank 2)
            [80314] = true, -- Expert Hunter (Expert Hunter - Rank 2)
            [42606] = true, -- Expert Hunter (Expert Hunter - Rank 3)
            [80323] = true, -- Expert Hunter (Expert Hunter - Rank 3)
            [42610] = true, -- Expert Hunter (Expert Hunter - Rank 4)
            [80328] = true, -- Expert Hunter (Expert Hunter - Rank 4)

            [40194] = true, -- Evil Hunter (Evil Hunter - Rank 1)
            [80381] = true, -- Evil Hunter (Evil Hunter - Rank 1)
            [42614] = true, -- Evil Hunter (Evil Hunter - Rank 2)
            [80376] = true, -- Evil Hunter (Evil Hunter - Rank 2)
            [42619] = true, -- Evil Hunter (Evil Hunter - Rank 3)
            [80371] = true, -- Evil Hunter (Evil Hunter - Rank 3)
            [42624] = true, -- Evil Hunter (Evil Hunter - Rank 4)
            [80366] = true, -- Evil Hunter (Evil Hunter - Rank 4)

            [80469] = true, -- Sense Evil 1 (Camouflaged Hunter - Rank 1)
            [40195] = true, -- Camouflaged Hunter (Camouflaged Hunter - Rank 1)
            [80338] = true, -- Camouflaged Hunter (Camouflaged Hunter - Rank 1)
            [80471] = true, -- Minor Berserk (Camouflaged Hunter - Rank 1)

            [80507] = true, -- Sense Evil II (Camouflaged Hunter - Rank 2)
            [42629] = true, -- Camouflaged Hunter (Camouflaged Hunter - Rank 2)
            [80359] = true, -- Camouflaged Hunter (Camouflaged Hunter - Rank 2)
            [81508] = true, -- Minor Berserk (Camouflaged Hunter - Rank 2)

            [81510] = true, -- Sense Evil III (Camouflaged Hunter - Rank 3)
            [42635] = true, -- Camouflaged Hunter (Camouflaged Hunter - Rank 3)
            [80345] = true, -- Camouflaged Hunter (Camouflaged Hunter - Rank 3)
            [81511] = true, -- Minor Berserk (Camouflaged Hunter - Rank 3)

            [81513] = true, -- Sense Evil IV (Camouflaged Hunter - Rank 4)
            [42641] = true, -- Camouflaged Hunter (Camouflaged Hunter - Rank 4)
            [80352] = true, -- Camouflaged Hunter (Camouflaged Hunter - Rank 4)
            [81514] = true, -- Minor Berserk (Camouflaged Hunter - Rank 4)

            [35750] = true, -- Trap Beast (Trap Beast - Rank 1)
            [35757] = true, -- Summon Shade (Trap Beast - Rank 1)
            [35754] = true, -- Trap Beast (Trap Beast - Rank 1)
            [35756] = true, -- Trap Beast (Trap Beast - Rank 1)
            [35753] = true, -- Trap Beast (Trap Beast - Rank 1)
            [68595] = true, -- Minor Force (Trap Beast - Rank 1)

            [42706] = true, -- Trap Beast (Trap Beast - Rank 2)
            [42708] = true, -- Summon Shade (Trap Beast - Rank 2)
            [42712] = true, -- Trap Beast (Trap Beast - Rank 2)
            [42711] = true, -- Trap Beast (Trap Beast - Rank 2)
            [42710] = true, -- Trap Beast (Trap Beast - Rank 2)
            [68596] = true, -- Minor Force (Trap Beast - Rank 2)

            [42713] = true, -- Trap Beast (Trap Beast - Rank 3)
            [42715] = true, -- Summon Shade (Trap Beast - Rank 3)
            [42719] = true, -- Trap Beast (Trap Beast - Rank 3)
            [42718] = true, -- Trap Beast (Trap Beast - Rank 3)
            [42717] = true, -- Trap Beast (Trap Beast - Rank 3)
            [68597] = true, -- Minor Force (Trap Beast - Rank 3)

            [42720] = true, -- Trap Beast (Trap Beast - Rank 4)
            [42722] = true, -- Summon Shade (Trap Beast - Rank 4)
            [42726] = true, -- Trap Beast (Trap Beast - Rank 4)
            [42725] = true, -- Trap Beast (Trap Beast - Rank 4)
            [42724] = true, -- Trap Beast (Trap Beast - Rank 4)
            [68598] = true, -- Minor Force (Trap Beast - Rank 4)

            [40372] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 1)
            [40378] = true, -- Daedric Mines (Lightweight Beast Trap - Rank 1)
            [40377] = true, -- Summon Shade (Lightweight Beast Trap - Rank 1)
            [40376] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 1)
            [40375] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 1)
            [40374] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 1)
            [68628] = true, -- Minor Force (Lightweight Beast Trap - Rank 1)

            [42757] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 2)
            [42763] = true, -- Daedric Mines (Lightweight Beast Trap - Rank 2)
            [42762] = true, -- Summon Shade (Lightweight Beast Trap - Rank 2)
            [42761] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 2)
            [42760] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 2)
            [42759] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 2)
            [68629] = true, -- Minor Force (Lightweight Beast Trap - Rank 2)

            [42764] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 3)
            [42770] = true, -- Daedric Mines (Lightweight Beast Trap - Rank 3)
            [42769] = true, -- Summon Shade (Lightweight Beast Trap - Rank 3)
            [42768] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 3)
            [42767] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 3)
            [42766] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 3)
            [68630] = true, -- Minor Force (Lightweight Beast Trap - Rank 3)

            [42771] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 4)
            [42777] = true, -- Daedric Mines (Lightweight Beast Trap - Rank 4)
            [42776] = true, -- Summon Shade (Lightweight Beast Trap - Rank 4)
            [42775] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 4)
            [42774] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 4)
            [42773] = true, -- Lightweight Beast Trap (Lightweight Beast Trap - Rank 4)
            [68631] = true, -- Minor Force (Lightweight Beast Trap - Rank 4)

            [40382] = true, -- Rearming Trap (Rearming Trap - Rank 1)
            [40386] = true, -- Rearming Trap (Rearming Trap - Rank 1)
            [40389] = true, -- Rearming Trap (Rearming Trap - Rank 1)
            [40385] = true, -- Rearming Trap (Rearming Trap - Rank 1)
            [40384] = true, -- Rearming Trap (Rearming Trap - Rank 1)
            [68632] = true, -- Minor Force (Rearming Trap - Rank 1)
            [40388] = true, -- Rearming Trap (Rearming Trap - Rank 1)
            [40392] = true, -- Rearming Trap (Rearming Trap - Rank 1)
            [40391] = true, -- Rearming Trap (Rearming Trap - Rank 1)

            [42727] = true, -- Rearming Trap (Rearming Trap - Rank 2)
            [42728] = true, -- Summon Shade (Rearming Trap - Rank 2)
            [42731] = true, -- Rearming Trap (Rearming Trap - Rank 2)
            [42734] = true, -- Rearming Trap (Rearming Trap - Rank 2)
            [42732] = true, -- Rearming Trap (Rearming Trap - Rank 2)
            [68636] = true, -- Minor Force (Rearming Trap - Rank 2)
            [42733] = true, -- Rearming Trap (Rearming Trap - Rank 2)
            [42736] = true, -- Rearming Trap (Rearming Trap - Rank 2)
            [42730] = true, -- Rearming Trap (Rearming Trap - Rank 2)

            [42737] = true, -- Rearming Trap (Rearming Trap - Rank 3)
            [42738] = true, -- Summon Shade (Rearming Trap - Rank 3)
            [42741] = true, -- Rearming Trap (Rearming Trap - Rank 3)
            [42744] = true, -- Rearming Trap (Rearming Trap - Rank 3)
            [42742] = true, -- Rearming Trap (Rearming Trap - Rank 3)
            [68638] = true, -- Minor Force (Rearming Trap - Rank 3)
            [42743] = true, -- Rearming Trap (Rearming Trap - Rank 3)
            [42746] = true, -- Rearming Trap (Rearming Trap - Rank 3)
            [42740] = true, -- Rearming Trap (Rearming Trap - Rank 3)

            [42747] = true, -- Rearming Trap (Rearming Trap - Rank 4)
            [42748] = true, -- Summon Shade (Rearming Trap - Rank 4)
            [42751] = true, -- Rearming Trap (Rearming Trap - Rank 4)
            [42754] = true, -- Rearming Trap (Rearming Trap - Rank 4)
            [42752] = true, -- Rearming Trap (Rearming Trap - Rank 4)
            [68640] = true, -- Minor Force (Rearming Trap - Rank 4)
            [42753] = true, -- Rearming Trap (Rearming Trap - Rank 4)
            [42756] = true, -- Rearming Trap (Rearming Trap - Rank 4)
            [42750] = true, -- Rearming Trap (Rearming Trap - Rank 4)

            [35713] = true, -- Dawnbreaker (Dawnbreaker - Rank 1)
            [62305] = true, -- Dawnbreaker (Dawnbreaker - Rank 1)
            [42554] = true, -- Dawnbreaker (Dawnbreaker - Rank 2)
            [62307] = true, -- Dawnbreaker (Dawnbreaker - Rank 2)
            [42560] = true, -- Dawnbreaker (Dawnbreaker - Rank 3)
            [62308] = true, -- Dawnbreaker (Dawnbreaker - Rank 3)
            [42566] = true, -- Dawnbreaker (Dawnbreaker - Rank 4)
            [62309] = true, -- Dawnbreaker (Dawnbreaker - Rank 4)

            [40163] = true, -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker - Rank 1)
            [42498] = true, -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker - Rank 1)
            [40161] = true, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 1)
            [62310] = true, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 1)
            [42576] = true, -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker - Rank 2)
            [42577] = true, -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker - Rank 2)
            [42575] = true, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 2)
            [62311] = true, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 2)
            [42583] = true, -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker - Rank 3)
            [42584] = true, -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker - Rank 3)
            [42581] = true, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 3)
            [62312] = true, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 3)
            [42588] = true, -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker - Rank 4)
            [42589] = true, -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker - Rank 4)
            [42586] = true, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 4)
            [62313] = true, -- Flawless Dawnbreaker (Flawless Dawnbreaker - Rank 4)

            [40158] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 1)
            [40160] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 1)
            [62314] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 1)
            [42592] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 2)
            [42594] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 2)
            [62315] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 2)
            [42595] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 3)
            [42597] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 3)
            [62316] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 3)
            [42598] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 4)
            [42600] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 4)
            [62317] = true, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting - Rank 4)

            -- LIGHT ARMOR
            [29639] = true, -- Evocation (Rank 1)
            [45548] = true, -- Evocation (Rank 2)
            [45549] = true, -- Evocation (Rank 3)
            [29665] = true, -- Recovery (Rank 1)
            [45557] = true, -- Recovery (Rank 2)
            [29663] = true, -- Spell Warding (Rank 1)
            [45559] = true, -- Spell Warding (Rank 2)
            [29668] = true, -- Prodigy (Rank 1)
            [45561] = true, -- Prodigy (Rank 2)
            [29667] = true, -- Concentration (Rank 1)
            [45562] = true, -- Concentration (Rank 2)

            -- MEDIUM ARMOR
            [29743] = true, -- Dexterity (Rank 1)
            [45563] = true, -- Dexterity (Rank 2)
            [45564] = true, -- Dexterity (Rank 3)
            [29687] = true, -- Wind Walker (Rank 1)
            [45565] = true, -- Wind Walker (Rank 2)
            [29738] = true, -- Improved Sneak (Rank 1)
            [45567] = true, -- Improved Sneak (Rank 2)
            [29686] = true, -- Agility (Rank 1)
            [45572] = true, -- Agility (Rank 2)
            [29742] = true, -- Athletics (Rank 1)
            [45574] = true, -- Athletics (Rank 2)

            -- HEAVY ARMOR
            [29825] = true, -- Resolve (Rank 1)
            [45531] = true, -- Resolve (Rank 2)
            [45533] = true, -- Resolve (Rank 3)
            [29769] = true, -- Constitution (Rank 1)
            [58428] = true, -- Constitution
            [58503] = true, -- Constitution
            [45526] = true, -- Constitution (Rank 2)
            [58430] = true, -- Constitution
            [58431] = true, -- Constitution
            [29804] = true, -- Juggernaught (Rank 1)
            [45546] = true, -- Juggernaught (Rank 2)
            [29773] = true, -- Revitalize (Rank 1)
            [45528] = true, -- Revitalize (Rank 2)
            [29791] = true, -- Rapid Mending (Rank 1)
            [45529] = true, -- Rapid Mending (Rank 2)

            -- LEGERDEMAIN
            [63799] = true, -- Improved Hiding (Rank 1)
            [63800] = true, -- Improved Hiding (Rank 2)
            [63801] = true, -- Improved Hiding (Rank 3)
            [63802] = true, -- Improved Hiding (Rank 4)

            [63803] = true, -- Light Fingers (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63804] = true, -- Light Fingers (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63805] = true, -- Light Fingers (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63806] = true, -- Light Fingers (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [63807] = true, -- Trafficker (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63808] = true, -- Trafficker (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63809] = true, -- Trafficker (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63810] = true, -- Trafficker (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [63811] = true, -- Locksmith (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63812] = true, -- Locksmith (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63813] = true, -- Locksmith (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63814] = true, -- Locksmith (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [63815] = true, -- Kickback (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63816] = true, -- Kickback (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63817] = true, -- Kickback (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [63818] = true, -- Kickback (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            -- SOUL MAGIC
            [39266] = true, -- Soul Shatter (Rank 1)
            [39267] = true, -- Soul Shatter
            [39268] = true, -- Soul Shatter
            [45583] = true, -- Soul Shatter (Rank 2)
            [45584] = true, -- Soul Shatter
            [45585] = true, -- Soul Shatter

            [39269] = true, -- Soul Summons (Rank 1)
            [45590] = true, -- Soul Summons (Rank 2)
            [43752] = true, -- Soul Summons

            [39263] = true, -- Soul Lock (Rank 1)
            [39264] = true, -- Soul Trap
            [45580] = true, -- Soul Lock (Rank 2)
            [45582] = true, -- Soul Trap

            -- VAMPIRE
            [35770] = true, -- Vampirism Base
            [44767] = true, -- Sense Fed Upon
            [80225] = true, -- Timer Reducer
            [35771] = true, -- Stage 1 Vampirism
            [38414] = true, -- Stage 1 Vampirism
            [35776] = true, -- Stage 2 Vampirism
            [35774] = true, -- Stage 2 Vampirism
            [38415] = true, -- Stage 2 Vampirism
            [35783] = true, -- Stage 3 Vampirism
            [35784] = true, -- Stage 3 Vampirism
            [35785] = true, -- Stage 3 Vampirism
            [38416] = true, -- Stage 3 Vampirism
            [35792] = true, -- Stage 4 Vampirism
            [35790] = true, -- Stage 4 Vampirism
            [35791] = true, -- Stage 4 Vampirism
            [38417] = true, -- Stage 4 Vampirism

            [33152] = true, -- Feed
            [33177] = true, -- Feed
            [33175] = true, -- Feed
            [32901] = true, -- Essenece Drained

            [42054] = true, -- Savage Feeding (Rank 1)
            [33182] = true, -- Uber Attack
            [33183] = true, -- Off-Balance Self
            [46045] = true, -- Savage Feeding (Rank 2)
            [46047] = true, -- Uber Attack
            [46046] = true, -- Off-Balance Self

            [33095] = true, -- Supernatural Recovery (Rank 1)
            [46041] = true, -- Supernatural Recovery (Rank 2)


            [33091] = true, -- Blood Ritual (Rank 1)
            -- ================================================================================= THESE NEED CHECKED LATER
            [40349] = true, -- Feed
            [40351] = true, -- Feed
            [40350] = true, -- Feed
            [40353] = true, -- Uber Attack
            [40359] = true, -- Fed on ally
            --[40355] = true, -- Ally Feed
            [40360] = true, -- Vampirism
            -- ================================================================================= THESE NEED CHECKED LATER

            [33096] = true, -- Undeath (Rank 1)
            [46040] = true, -- Undeath (Rank 2)

            [33093] = true, -- Unnatural Resistance (Rank 1)

            [33090] = true, -- Dark Stalker (Rank 1)


            -- WEREWOLF
            [35658] = true, -- Lycanthrophy
            -- ROOM HERE FOR LUPINUS
            [39033] = true, -- Begin Werewolf
            [39035] = true, -- Werewolf
            [39023] = true, -- Charge Werewolf
            [39025] = true, -- Charge Werewolf
            [39038] = true, -- Werewolf Effects
            [39043] = true, -- TransformBonus Movement
            [39051] = true, -- Kill Trigger
            [48497] = true, -- Sense Fed Upon

            [39477] = true, -- De-Werewolf
            [39478] = true, -- Remove Sprint
            [80194] = true, -- Remove Pets

            [32464] = true, -- Light Attack
            [89146] = true, -- Werewolf Bleed
            [32477] = true, -- Heavy Attack (Were)
            [32479] = true, -- Heavy Attack
            [32478] = true, -- Heavy Attack Damage Bonus
            [32480] = true, -- Heavy Attack Werewolf
            [32494] = true, -- Heavy Attack
            [60773] = true, -- Stamina Return
            [40544] = true, -- Keep Corpse
            [40545] = true, -- Keep Corpse

            [32636] = true, -- Pursuit (Rank 1)
            [46142] = true, -- Pursuit (Rank 2)

            [32634] = true, -- Devour (Rank 1)
            [39050] = true, -- Devour Passive
            [33208] = true, -- Devour
            [33209] = true, -- Devour
            [37233] = true, -- Devour
            [48496] = true, -- Devour

            [32637] = true, -- Blood Rage (Rank 1)
            [33470] = true, -- Blood Rage
            [46135] = true, -- Blood Rage (Rank 2)
            [46136] = true, -- Blood Rage

            [32639] = true, -- Bloodmoon (Rank 1)

            [32638] = true, -- Savage Strength (Rank 1)
            [46139] = true, -- Savage Strength (Rank 2)

            [32641] = true, -- Call of the Pack (Rank 1)
            [80283] = true, -- Call of the Pack
            [46137] = true, -- Call of the Pack (Rank 2)
            [80282] = true, -- Call of the Pack

            -- DARK BROTHERHOOD
            [78219] = true, -- Blade of Woe (Rank 1)
            [76325] = true, -- Blade of Woe
            [77101] = true, -- Blade of Woe
            [77102] = true, -- Blade of Woe Snare
            [81101] = true, -- Assassins League Style Item Gi
            [81118] = true, -- Assassins League Style Item FX
            [81604] = true, -- Self Reveal

            [77392] = true, -- Scales of Pitiless Justice (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [77394] = true, -- Scales of Pitiless Justice II (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [77395] = true, -- Scales of Pitiless Justice III (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [79865] = true, -- Scales of Pitiless Justice IV (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [77397] = true, -- Padomaic Sprint (Rank 1)
            [79623] = true, -- Major Expedition (Blade of Woe Kill)
            [80392] = true, -- Major Expedition (Normal Kill)
            [77398] = true, -- Padomaic Sprint II (Rank 2)
            [79624] = true, -- Major Expedition (Blade of Woe Kill)
            [80394] = true, -- Major Expedition (Normal Kill)
            [77399] = true, -- Padomaic Sprint III (Rank 3)
            [79625] = true, -- Major Expedition (Blade of Woe Kill)
            [80396] = true, -- Major Expedition (Normal Kill)
            [79868] = true, -- Padomaic Sprint IV (Rank 4)
            [79877] = true, -- Major Expedition (Blade of Woe Kill)
            [80398] = true, -- Major Expedition (Normal Kill)

            [77396] = true, -- Shadowy Supplier (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion

            [77400] = true, -- Shadow Rider (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion

            [77401] = true, -- Spectral Assassin (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [80636] = true, -- Spectral Assassin

            -- FIGHTERS GUILD
            [29062] = true, -- Intimidating Presence (Rank 1)

            [35803] = true, -- Slayer (Rank 1)
            [45595] = true, -- Slayer (Rank 2)
            [45596] = true, -- Slayer (Rank 3)

            [35800] = true, -- Banish the Wicked (Rank 1)
            [35801] = true, -- Banish the Wicked
            [45597] = true, -- Banish the Wicked (Rank 2)
            [45598] = true, -- Banish the Wicked
            [45599] = true, -- Banish the Wicked (Rank 3)
            [45600] = true, -- Banish the Wicked

            [40393] = true, -- Skilled Tracker (Rank 1)

            [35804] = true, -- Bounty Hunter (Rank 1)

            -- MAGES GUILD
            [29061] = true, -- Persuasive Will (Rank 1)

            [40436] = true, -- Mage Adept (Rank 1)
            [45601] = true, -- Mage Adept (Rank 2)

            [40437] = true, -- Everlasting Magic (Rank 1)
            [45602] = true, -- Everlasting Magic (Rank 2)

            [40438] = true, -- Magicka Controller (Rank 1)
            [45603] = true, -- Magicka Controller (Rank 2)

            [43561] = true, -- Might of the Guild (Rank 1)
            [65507] = true, -- Empower
            [45607] = true, -- Might of the Guild (Rank 2)
            [65541] = true, -- Empower

            -- THIEVES GUILD
            [74580] = true, -- Finders Keepers (Rank 1)

            [76454] = true, -- Swiftly Forgotten (Rank 1)
            [76455] = true, -- Swiftly Forgotten II (Rank 2)
            [76456] = true, -- Swiftly Forgotten III (Rank 3)
            [76457] = true, -- Swiftly Forgotten IV (Rank 4)

            [76458] = true, -- Haggling (Rank 1)
            [76459] = true, -- Haggling II (Rank 2)
            [76460] = true, -- Haggling III (Rank 3)
            [76461] = true, -- Haggling IV (Rank 4)

            [76451] = true, -- Clemency (Rank 1)

            [76452] = true, -- Timely Escape (Rank 1)
            [77962] = true, -- Timely Escape Achievement
            [77963] = true, -- Timely Escape Achievement

            [76453] = true, -- Veil of Shadows (Rank 1)

            -- UNDAUNTED
            [55584] = true, -- Undaunted Command (Rank 1)
            [55606] = true, -- Undaunted Command
            [55607] = true, -- Undaunted Command Magicka Rest
            [55608] = true, -- Undaunted Command Stamina Rest
            [55676] = true, -- Undaunted Command (Rank 2)
            [55677] = true, -- Undaunted Command
            [55678] = true, -- Undaunted Command Magicka Rest
            [55679] = true, -- Undaunted Command Stamina Rest

            [55366] = true, -- Undaunted Mettle (Rank 1)
            [55386] = true, -- Undaunted Mettle (Rank 2)


            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --

            ---------------------------------------------
            -- AVA PASSIVES  ----------------------------
            ---------------------------------------------

            -- Assault
            [39248] = true, -- Continuous Attack (Rank 1)
            [39249] = true, -- Continuous Attack
            [45614] = true, -- Continuous Attack (Rank 2)
            [45617] = true, -- Continuous Attack
            [39254] = true, -- Reach (Rank 1)
            [45621] = true, -- Reach (Rank 2)
            [39252] = true, -- Combat Frenzy (Rank 1)
            [39253] = true, -- Combat Frenzy
            [45619] = true, -- Combat Frenzy (Rank 2)
            [45620] = true, -- Combat Frenzy

            -- Support
            [39255] = true, -- Magicka Aid (Rank 1)
            [45622] = true, -- Magicka Aid (Rank 2)
            [39259] = true, -- Combat Medic (Rank 1)
            [45624] = true, -- Combat Medic (Rank 2)
            [39261] = true, -- Battle Resurrection (Rank 1)
            [45625] = true, -- Battle Resurrection (Rank 2)

            ---------------------------------------------
            -- RACIALS  ---------------------------------
            ---------------------------------------------

            -- BRETON
            [36247] = true, -- Opportunist (Rank 1)
            [35995] = true, -- Gift of Magnus (Rank 1)
            [45259] = true, -- Gift of Magnus (Rank 2)
            [45260] = true, -- Gift of Magnus (Rank 3)
            [36266] = true, -- Spell Resistance (Rank 1)
            [45261] = true, -- Spell Resistance (Rank 2)
            [45262] = true, -- Spell Resistance (Rank 3)
            [36303] = true, -- Magicka Mastery (Rank 1)
            [45263] = true, -- Magicka Mastery (Rank 2)
            [45264] = true, -- Magicka Mastery (Rank 3)

            -- ORC
            [33293] = true, -- Craftsman (Rank 1)
            [33301] = true, -- Brawny (Rank 1)
            [45307] = true, -- Brawny (Rank 2)
            [45309] = true, -- Brawny (Rank 3)
            [84668] = true, -- Unflinching (Rank 1)
            [84670] = true, -- Unflinching (Rank 2)
            [84672] = true, -- Unflinching (Rank 3)
            [33304] = true, -- Swift Warrior (Rank 1)
            [45311] = true, -- Swift Warrior (Rank 2)
            [45312] = true, -- Swift Warrior (Rank 3)

            -- REDGUARD
            [84680] = true, -- Wayfarer (Rank 1)
            [36009] = true, -- Exhilaration (Rank 1)
            [45277] = true, -- Exhilaration (Rank 2)
            [45278] = true, -- Exhilaration (Rank 3)
            [36153] = true, -- Conditioning (Rank 1)
            [45279] = true, -- Conditioning (Rank 2)
            [45280] = true, -- Conditioning (Rank 3)
            [36546] = true, -- Adrenaline Rush (Rank 1)
            [36548] = true, -- Adrenaline Rush
            [45313] = true, -- Adrenaline Rush (Rank 2)
            [45314] = true, -- Adrenaline Rush
            [45315] = true, -- Adrenaline Rush (Rank 3)
            [45316] = true, -- Adrenaline Rush

            -- ALTMER
            [35965] = true, -- Highborn (Rank 1)
            [35993] = true, -- Spellcharge (Rank 1)
            [45273] = true, -- Spellcharge (Rank 2)
            [45274] = true, -- Spellcharge (Rank 3)
            --[35995] = true, -- Gift of Magnus (Rank 1) (Duplicate: Same as Breton)
            --[45259] = true, -- Gift of Magnus (Rank 2) (Duplicate: Same as Breton)
            --[45260] = true, -- Gift of Magnus (Rank 3) (Duplicate: Same as Breton)
            [35998] = true, -- Elemental Talent (Rank 1)
            [45275] = true, -- Elemental Talent (Rank 2)
            [45276] = true, -- Elemental Talent (Rank 3)

            -- BOSMER
            [36008] = true, -- Acrobat (Rank 1)
            [64279] = true, -- Y'ffre's Endurance (Rank 1)
            [64280] = true, -- Y'ffre's Endurance (Rank 2)
            [64281] = true, -- Y'ffre's Endurance (Rank 3)
            [36011] = true, -- Resist Affliction (Rank 1)
            [45317] = true, -- Resist Affliction (Rank 2)
            [45319] = true, -- Resist Affliction (Rank 3)
            [36022] = true, -- Stealthy (Rank 1)
            [45295] = true, -- Stealthy (Rank 2)
            [45296] = true, -- Stealthy (Rank 3)

            -- KHAJIIT
            [36063] = true, -- Cutpurse (Rank 1)
            [70386] = true, -- Nimble (Rank 1)
            [70388] = true, -- Nimble (Rank 2)
            [70390] = true, -- Nimble (Rank 3)
            --[36022] = true, -- Stealthy (Rank 1) (Duplicate: Same as Bosmer)
            --[45295] = true, -- Stealthy (Rank 2) (Duplicate: Same as Bosmer)
            --[45296] = true, -- Stealthy (Rank 3) (Duplicate: Same as Bosmer)
            [36067] = true, -- Carnage (Rank 1)
            [45299] = true, -- Carnage (Rank 2)
            [45301] = true, -- Carnage (Rank 3)

            -- ARGONIAN
            [36582] = true, -- Amphibian (Rank 1)
            [36568] = true, -- Resourceful (Rank 1)
            [49151] = true, -- Resourceful (Rank 1)
            [63694] = true, -- Resourceful
            [63695] = true, -- Resourceful
            [63696] = true, -- Resourceful
            [45243] = true, -- Resourceful (Rank 2)
            [63700] = true, -- Resourceful (Rank 2)
            [63697] = true, -- Resourceful
            [63698] = true, -- Resourceful
            [63699] = true, -- Resourceful
            [45247] = true, -- Resourceful (Rank 3)
            [63704] = true, -- Resourceful (Rank 3)
            [63701] = true, -- Resourceful
            [63702] = true, -- Resourceful
            [63703] = true, -- Resourceful
            [36583] = true, -- Argonian Resistance (Rank 1)
            [45253] = true, -- Argonian Resistance (Rank 2)
            [45255] = true, -- Argonian Resistance (Rank 3)
            [36585] = true, -- Quick Mend (Rank 1)
            [45257] = true, -- Quick Mend (Rank 2)
            [45258] = true, -- Quick Mend (Rank 3)

            -- DUNMER
            [36588] = true, -- Ashlander (Rank 1)
            [36591] = true, -- Dynamic (Rank 1)
            [45265] = true, -- Dynamic (Rank 2)
            [45267] = true, -- Dynamic (Rank 3)
            [36593] = true, -- Resist Flame (Rank 1)
            [45269] = true, -- Resist Flame (Rank 2)
            [45270] = true, -- Resist Flame (Rank 3)
            [36598] = true, -- Destructive Ancestry (Rank 1)
            [45271] = true, -- Destructive Ancestry (Rank 2)
            [45272] = true, -- Destructive Ancestry (Rank 3)

            -- NORD
            [36626] = true, -- Reveler (Rank 1)
            [36064] = true, -- Stalwart (Rank 1)
            [45297] = true, -- Stalwart (Rank 2)
            [45298] = true, -- Stalwart (Rank 3)
            [36627] = true, -- Resist Frost (Rank 1)
            [45303] = true, -- Resist Frost (Rank 2)
            [45304] = true, -- Resist Frost (Rank 3)
            [36628] = true, -- Rugged (Rank 1)
            [45305] = true, -- Rugged (Rank 2)
            [45306] = true, -- Rugged (Rank 3)

            -- IMPERIAL
            [36312] = true, -- Diplomat (Rank 1)
            [50903] = true, -- Tough (Rank 1)
            [50906] = true, -- Tough (Rank 2)
            [50907] = true, -- Tough (Rank 3)
            --[36153] = true, -- Conditioning (Rank 1) (Duplicate: Same as Redguard)
            --[45279] = true, -- Conditioning (Rank 2) (Duplicate: Same as Redguard)
            --[45280] = true, -- Conditioning (Rank 3) (Duplicate: Same as Redguard)
            [36155] = true, -- Red Diamond (Rank 1)
            [36214] = true, -- Red Diamond
            [45291] = true, -- Red Diamond (Rank 2)
            [45292] = true, -- Red Diamond
            [45293] = true, -- Red Diamond (Rank 3)
            [45294] = true, -- Red Diamond


            ---------------------------------------------
            -- CRAFTING  --------------------------------
            ---------------------------------------------

            -- ALCHEMY
            [45542] = true, -- Solvent Proficiency (Rank 0/1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [45543] = true, -- Solvent Proficiency (Rank 0/1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [45547] = true, -- Solvent Proficiency (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [45550] = true, -- Solvent Proficiency (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [45551] = true, -- Solvent Proficiency (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion
            [45552] = true, -- Solvent Proficiency (Rank 5) -- NOTE: No actual aura or event displayed for this, listed for completion
            [49163] = true, -- Solvent Proficiency (Rank 6) -- NOTE: No actual aura or event displayed for this, listed for completion
            [70042] = true, -- Solvent Proficiency (Rank 7) -- NOTE: No actual aura or event displayed for this, listed for completion
            [70043] = true, -- Solvent Proficiency (Rank 8) -- NOTE: No actual aura or event displayed for this, listed for completion

            [47480] = true, -- Keen Eye: Reagents (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47841] = true, -- Keen Eye: Reagents (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47842] = true, -- Keen Eye: Reagents (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [45569] = true, -- Medicinal Use (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [45571] = true, -- Medicinal Use (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [45573] = true, -- Medicinal Use (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [45577] = true, -- Chemistry (Rank 1)
            [45578] = true, -- Chemistry (Rank 2)
            [45579] = true, -- Chemistry (Rank 3)

            [45555] = true, -- Laboratory Use (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion

            [47831] = true, -- Snakeblood (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47832] = true, -- Snakeblood (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47834] = true, -- Snakeblood (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            -- BLACKSMITHING
            [47276] = true, -- Metalworking (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47277] = true, -- Metalworking (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47278] = true, -- Metalworking (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47279] = true, -- Metalworking (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47280] = true, -- Metalworking (Rank 5) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47281] = true, -- Metalworking (Rank 6) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48157] = true, -- Metalworking (Rank 7) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48158] = true, -- Metalworking (Rank 8) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48159] = true, -- Metalworking (Rank 9) -- NOTE: No actual aura or event displayed for this, listed for completion
            [70041] = true, -- Metalworking (Rank 10) -- NOTE: No actual aura or event displayed for this, listed for completion

            [47854] = true, -- Keen Eye: Ore (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47855] = true, -- Keen Eye: Ore (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47856] = true, -- Keen Eye: Ore (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48169] = true, -- Miner Hireling (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48170] = true, -- Miner Hireling (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48171] = true, -- Miner Hireling (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48163] = true, -- Metal Extraction (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48164] = true, -- Metal Extraction (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48165] = true, -- Metal Extraction (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48160] = true, -- Metallurgy (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48161] = true, -- Metallurgy (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48162] = true, -- Metallurgy (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [58784] = true, -- Metallurgy (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48166] = true, -- Temper Expertise (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48167] = true, -- Temper Expertise (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48168] = true, -- Temper Expertise (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            -- CLOTHING
            [47288] = true, -- Tailoring (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47289] = true, -- Tailoring (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47290] = true, -- Tailoring (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47291] = true, -- Tailoring (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47292] = true, -- Tailoring (Rank 5) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47293] = true, -- Tailoring (Rank 6) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48187] = true, -- Tailoring (Rank 7) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48188] = true, -- Tailoring (Rank 8) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48189] = true, -- Tailoring (Rank 9) -- NOTE: No actual aura or event displayed for this, listed for completion
            [70044] = true, -- Tailoring (Rank 10) -- NOTE: No actual aura or event displayed for this, listed for completion

            [47860] = true, -- Keen Eye: Cloth (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47861] = true, -- Keen Eye: Cloth (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47862] = true, -- Keen Eye: Cloth (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48199] = true, -- Outfitter Hireling (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48200] = true, -- Outfitter Hireling (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48201] = true, -- Outfitter Hireling (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48193] = true, -- Unraveling (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48194] = true, -- Unraveling (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48195] = true, -- Unraveling (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48190] = true, -- Stitching (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48191] = true, -- Stitching (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48192] = true, -- Stitching (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [58782] = true, -- Stitching (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48196] = true, -- Tannin Expertise (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48197] = true, -- Tannin Expertise (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48198] = true, -- Tannin Expertise (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            -- ENCHANTING
            [46758] = true, -- Aspect Improvement (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46759] = true, -- Aspect Improvement (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46760] = true, -- Aspect Improvement (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46763] = true, -- Aspect Improvement (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [46727] = true, -- Potency Improvement (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46729] = true, -- Potency Improvement (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46731] = true, -- Potency Improvement (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46735] = true, -- Potency Improvement (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46736] = true, -- Potency Improvement (Rank 5) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46740] = true, -- Potency Improvement (Rank 6) -- NOTE: No actual aura or event displayed for this, listed for completion
            [49112] = true, -- Potency Improvement (Rank 7) -- NOTE: No actual aura or event displayed for this, listed for completion
            [49113] = true, -- Potency Improvement (Rank 8) -- NOTE: No actual aura or event displayed for this, listed for completion
            [49114] = true, -- Potency Improvement (Rank 9) -- NOTE: No actual aura or event displayed for this, listed for completion
            [70045] = true, -- Potency Improvement (Rank 10) -- NOTE: No actual aura or event displayed for this, listed for completion

            [47851] = true, -- Keen Eye: Rune Stones -- Keen Eye: Rune Stones (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47852] = true, -- Keen Eye: Rune Stones -- Keen Eye: Rune Stones (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47853] = true, -- Keen Eye: Rune Stones -- Keen Eye: Rune Stones (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [46770] = true, -- Hireling (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46771] = true, -- Hireling (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46772] = true, -- Hireling (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [46767] = true, -- Runestone Extraction (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46768] = true, -- Runestone Extraction (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [46769] = true, -- Runestone Extraction (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            -- PROVISIONING
            [44625] = true, -- Recipe Quality (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44630] = true, -- Recipe Quality (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44631] = true, -- Recipe Quality (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [69953] = true, -- Recipe Quality (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [44590] = true, -- Recipe Improvement (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44595] = true, -- Recipe Improvement (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44597] = true, -- Recipe Improvement (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44598] = true, -- Recipe Improvement (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44599] = true, -- Recipe Improvement (Rank 5) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44650] = true, -- Recipe Improvement (Rank 6) -- NOTE: No actual aura or event displayed for this, listed for completion

            [44602] = true, -- Gourmand (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44609] = true, -- Gourmand (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44610] = true, -- Gourmand (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [44612] = true, -- Connoisseur (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44614] = true, -- Connoisseur (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44615] = true, -- Connoisseur (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [44616] = true, -- Chef (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44617] = true, -- Chef (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44619] = true, -- Chef (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [44620] = true, -- Brewer (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44621] = true, -- Brewer (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44624] = true, -- Brewer (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [44634] = true, -- Hireling (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44640] = true, -- Hireling (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [44641] = true, -- Hireling (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            -- WOODWORKING
            [47282] = true, -- Woodworking (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47283] = true, -- Woodworking (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47284] = true, -- Woodworking (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47285] = true, -- Woodworking (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47286] = true, -- Woodworking (Rank 5) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47287] = true, -- Woodworking (Rank 6) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48172] = true, -- Woodworking (Rank 7) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48173] = true, -- Woodworking (Rank 8) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48174] = true, -- Woodworking (Rank 9) -- NOTE: No actual aura or event displayed for this, listed for completion
            [70046] = true, -- Woodworking (Rank 10) -- NOTE: No actual aura or event displayed for this, listed for completion

            [47857] = true, -- Keen Eye: Wood (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47858] = true, -- Keen Eye: Wood (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [47859] = true, -- Keen Eye: Wood (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48184] = true, -- Lumberjack Hireling (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48185] = true, -- Lumberjack Hireling (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48186] = true, -- Lumberjack Hireling (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48178] = true, -- Wood Extraction (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48179] = true, -- Wood Extraction (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48180] = true, -- Wood Extraction (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48181] = true, -- Carpentry (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48182] = true, -- Carpentry (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48183] = true, -- Carpentry (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion
            [58783] = true, -- Carpentry (Rank 4) -- NOTE: No actual aura or event displayed for this, listed for completion

            [48175] = true, -- Resin Expertise (Rank 1) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48176] = true, -- Resin Expertise (Rank 2) -- NOTE: No actual aura or event displayed for this, listed for completion
            [48177] = true, -- Resin Expertise (Rank 3) -- NOTE: No actual aura or event displayed for this, listed for completion

            ---------------------------------------------













            [00000] = true,
            [00000] = true,
            [00000] = true,
            [00000] = true,




            -- GENERIC NPC COMBAT EVENTS
            [20542] = true, -- Prioritize Hit
            [38433] = true, -- Prioritize Hit
            [20546] = true, -- Prioritize Hit
            [37360] = true, -- No Light Attacks
            [15160] = true, -- Finesse Clear Cooldown
            [31373] = true, -- Modify Shared CD Ability
            [46858] = true, -- Second Wind
            [94793] = true, -- Prioritize Hit

            -- SHARED NPC PASSIVES
            [67950] = true, -- CC Immunity Plus -- Various NPC's
            [33097] = true, -- Scary Immunities -- Various NPC's
            [44176] = true, -- Flying Immunities -- Various NPC's
            [13739] = true, -- Backstabber -- Various NPC's
            [71904] = true, -- Increased Speed -- Dire Wolf / Sentinel

            [73768] = true, -- GEN 5 Hits -- Various NPC's
            [73769] = true, -- GEN 5 Hits -- Various NPC's
            [73772] = true, -- GEN 5 Hits -- Various NPC's

            [79147] = true, -- GEN 3 Hits -- Various NPC's
            [79148] = true, -- GEN 3 Hits -- Various NPC's
            [79149] = true, -- GEN 3 Hits -- Various NPC's

            [73916] = true, -- GEN 2 Hits -- Various NPC's
            [73917] = true, -- GEN 2 Hits -- Various NPC's
            [73919] = true, -- GEN 2 Hits -- Various NPC's

            [88283] = true, -- No Call Ally (is Ally) -- Summoner NPCs
            [88289] = true, -- No Call Ally (Failed) -- Summoner NPCs
            [89175] = true, -- No Call Ally 1:1 Ally Tracker -- Summoner NPCs
            [89176] = true, -- No Call Ally -- Summoner NPCs
            [89177] = true, -- No Call Ally -- Summoner NPCs

            -- SHARED NPC ACTIVE EVENTS
            [8239] = true, -- Hamstrung
            [10845] = true, -- Run Away! -- Humanoid NPC's
            [31813] = true, -- Run Away! -- Humanoid NPC's
            [82703] = true, -- Run Away! -- Humanoid NPC's
            [18386] = true, -- Run Away! -- Creatures
            [14249] = true, -- Surround -- Mostly Animals

            -- SHARED MISC
            [28301] = true, -- Ability CC Immunity
            [38117] = true, -- CC Immunity

            -- CRITTER EVENTS

            [79544] = true, -- Mischievous Dodge -- Nixad
            [79600] = true, -- Mischievous Dodge -- Nixad
            [79555] = true, -- Mischievous Dodge -- Nixad
            [79601] = true, -- Mischievous Dodge -- Nixad
            [79602] = true, -- Mischievous Dodge -- Nixad


            ---------------------------------
            -- FRIENDLY NPC EVENTS
            ---------------------------------

            [42905] = true, -- Recover
            [42937] = true, -- TargetPriorityException

            [48296] = true, -- Flare
            [48298] = true, -- Heat Wave
            [48299] = true, -- Heat Wave

            [48279] = true, -- Quick Strike
            [48278] = true, -- Heavy Attack

            ---------------------------------
            -- JUSTICE NPCS
            ---------------------------------

            [63903] = true, -- Guard Hit by CC
            [63153] = true, -- Guard Immunities
            [63154] = true, -- Guard Immunities
            [63163] = true, -- Guard Speed Boost
            [63174] = true, -- Guard Speed Boost
            [63168] = true, -- Cage Talons
            [63180] = true, -- JUST Used Talons Speed Boost
            [63182] = true, -- Talons Boost 1
            [63186] = true, -- JUST Guard Used Talons Speed B
            [63157] = true, -- Heavy Blow
            [63268] = true, -- Uppercut
            [63160] = true, -- Heavy Blow Knockdown
            [63261] = true, -- Heavy Blow
            [63265] = true, -- Uppercut
            [63263] = true, -- Heavy Blow Knockdown
            [64060] = true, -- Block Guard CC
            [63145] = true, -- Criminal's Bane
            [63148] = true, -- Major Defile
            [63149] = true, -- Criminal's Bane
            [63202] = true, -- Criminal's Bane
            [63926] = true, -- Pre-stack check
            [63095] = true, -- Focused Strike
            [63093] = true, -- Charge
            [63094] = true, -- Shield Charge
            [63198] = true, -- Fiery Chain
            [63200] = true, -- Firey Chain
            [63911] = true, -- Guard Stacking Damage
            [64134] = true, -- JUST Guard Evade
            [64150] = true, -- JUST Death Timer

            [64152] = true, -- JUST Unlock Death Bolts

            --[63086] = true, -- Guard Charge
            --[63258] = true, -- Guard Charge

            [64139] = true, -- Piercing Bolt
            [64267] = true, -- Focused Shot

            [63259] = true, -- Charge
            [63260] = true, -- Shield Charge

            [63179] = true, -- Flame Shard
            [63194] = true, -- Flame Shard
            [63197] = true, -- Magma Prison

            [63905] = true, -- Guard CC Break Timer
            [63906] = true, -- Guard CC Break Anim
            [63904] = true, -- Guard CC Immunity

            [78790] = true, -- Seek
            [78793] = true, -- Seek LOS
            [78802] = true, -- Seek
            [78803] = true, -- Seek
            [78804] = true, -- Seek
            [78760] = true, -- Confusion
            [78761] = true, -- LOS Tar
            [78762] = true, -- LOS Check
            [78764] = true, -- Confusion
            [78775] = true, -- Confusion
            [78767] = true, -- Confusion
            [78768] = true, -- Confusion
            [78769] = true, -- Confusion
            [78770] = true, -- Confusion
            [78766] = true, -- Confusion
            [78772] = true, -- Confusion
            [78771] = true, -- Confusion
            --[78675] = true, -- Confusion

            --[78743] = true, -- Flare
            --[78789] = true, -- Flare
            --[78750] = true, -- Revealed
            --[78746] = true, -- Flare
            --[78744] = true, -- Flare

            --[63424] = true, -- JUST Guard Awarness (Guard)

            [75613] = true, -- Shadowcloak Immunity (Mage Guard)
            --[77921] = true, -- Clairvoyance Tutorial (Mage Guard)
            [77919] = true, -- Clairvoyance Tutorial (Mage Guard)
            [77937] = true, -- Clairvoyance (Mage Guard)
            [77941] = true, -- Revealed
            [77943] = true, -- Clairvoyance (Mage Guard)
            [77917] = true, -- Empower Weapon: Flame (Mage Guard)
            [74502] = true, -- Focused Strike (Mage Guard)
            [74503] = true, -- Focused Strike (Mage Guard)
            [74504] = true, -- Focused Strike (Mage Guard)
            [74862] = true, -- Teleport Trap (Mage Guard)
            [74870] = true, -- Teleport Trap (Mage Guard)
            [74867] = true, -- Teleport Trap (Mage Guard)
            [74884] = true, -- Teleport Trap (Mage Guard)
            [74885] = true, -- Teleport Trap (Mage Guard)
            [74864] = true, -- Teleport Trap (Mage Guard)
            [74863] = true, -- Teleport Trap (Mage Guard)
            [74506] = true, -- Encase (Mage Guard)
            [74522] = true, -- Encase (Mage Guard)
            [74533] = true, -- Encase (Mage Guard)
            [74534] = true, -- Encase (Mage Guard)
            [74535] = true, -- Encase (Mage Guard)
            [74536] = true, -- Encase (Mage Guard)
            [74510] = true, -- Encase (Mage Guard)
            [74996] = true, -- Streak (Mage Guard)

            [77450] = true, -- Clairvoyance Tutorial (Mage Guard - Instanced)
            [77449] = true, -- Clairvoyance Tutorial (Mage Guard - Instanced)
            [72694] = true, -- Clairvoyance (Mage Guard - Instanced)
            [72695] = true, -- Revealed (Mage Guard - Instanced)
            [77444] = true, -- Clairvoyance (Mage Guard - Instanced)
            [78060] = true, -- Revealed (Mage Guard - Instanced)
            [75808] = true, -- Guard Speed Boost (Mage Guard - Instanced)
            [75809] = true, -- Guard Speed Boost (Mage Guard - Instanced)

            [54363] = true, -- Halt (Guard)
            [63625] = true, -- Arrest Stun (Guard)
            [64647] = true, -- Remove Effects (Guard)

            [77452] = true, -- Shadow Cloak Immunity (Basic Justice NPC)
            [78012] = true, -- Quick Strike (Basic Justice NPC)

            [62472] = true, -- Stab (Justice Rogue)
            [62506] = true, -- Thrown Dagger (Justice Rogue)

            [62408] = true, -- Bound Weapon (Justice Mage)
            [62409] = true, -- Fiery Wind (Justice Mage)
            [62502] = true, -- Fiery Wind (Justice Mage)
            [62407] = true, -- Fiery Touch (Justice Mage)
            [63828] = true, -- Fiery Touch (Justice Mage)

            [78265] = true, -- Alarm (Estate Marshal - DB)
            [80539] = true, -- Alarm (Estate Marshal - DB)
            [67567] = true, -- Generic Self Stun (Estate Marshal - DB)
            [78266] = true, -- Alarm (Estate Marshal - DB)

            [52471] = true, -- Nullify (Estate Spellbreaker - DB)
            [52474] = true, -- Nullify (Estate Spellbreaker - DB)
            [66669] = true, -- Nullify (Estate Spellbreaker - DB)

            [73226] = true, -- Hurried Ward (Mage Guard - DB)
            [73229] = true, -- Hurried Ward (Mage Guard - DB)
            [73230] = true, -- Hurried Ward (Mage Guard - DB)

            -- Traps & Interactables
            [62230] = true, -- Coldharbour Flames
            [62771] = true, -- Coldharbour Flames
            [62769] = true, -- Coldharbour Flames
            [62770] = true, -- Coldharbour Flames

            [72711] = true, -- Hidden (Hiding Spot)
            [72712] = true, -- Hiding Spot (Hiding Spot)
            [80262] = true, -- Hiding Spot (Hiding Spot)
            [77335] = true, -- Threat Drop (Hiding Spot)
            [77336] = true, -- Threat Drop (Hiding Spot)
            [77337] = true, -- Threat Drop (Hiding Spot)
            [77338] = true, -- Threat Drop (Hiding Spot)
            [77339] = true, -- Threat Drop (Hiding Spot)
            [75747] = true, -- Hiding Spot (Hiding Spot)

            -- HUMANOID NPCS
            [10618] = true, -- Quick Strike -- Shared
            [12437] = true, -- Quick Shot -- Shared
            [12456] = true, -- Ice Arrow -- Shared
            [10639] = true, -- Flare -- Shared
            [11604] = true, -- Is Fire Ranged -- Shared
            [43768] = true, -- Health Potion -- Shared
            [44471] = true, -- Roll Dodge -- Shared
            [44477] = true, -- Roll Dodge -- Shared
            [44480] = true, -- Roll Dodge -- Shared
            [44479] = true, -- Roll Left -- Shared
            [44482] = true, -- Roll Right -- Shared
            [39058] = true, -- Bear Trap -- Shared
            [39060] = true, -- Bear Trap -- Shared
            [39065] = true, -- Bear Trap -- Shared
            [40070] = true, -- Bear Trap -- Shared
            [64750] = true, -- Briarheart Set Resurrectable -- Shared

            [10648] = true, -- Throw Oil -- Synergies (Footsoldier)
            [11039] = true, -- Spread Out Sound -- Synergies (Footsoldier)
            [10824] = true, -- Oil Up -- Synergies (Footsoldier)
            [10650] = true, -- Oil Drenched -- Synergies (Footsoldier)
            [12439] = true, -- Burning Arrow -- Synergies (Archer)
            --[70413] = true, -- Burning Arrow (STILL TESTING)
            [14068] = true, -- Ignite -- Synergies (Archer)
            [14070] = true, -- Ignite -- Synergies (Archer)
            [10805] = true, -- Ignite -- Synergies (Fire Mage)
            [10814] = true, -- Ignite -- Synergies (Fire Mage)
            [10809] = true, -- Ignite -- Synergies (Fire Mage)
            [10825] = true, -- Ignite -- Synergies (Fire Mage)
            [10813] = true, -- Ignite -- Synergies (Fire Mage)
            [38261] = true, -- Ignite -- Synergies (Fire Mage)
            [38262] = true, -- Ignite -- Synergies (Fire Mage)
            [38260] = true, -- Ignite -- Synergies (Fire Mage)

            [31385] = true, -- Necromancer Synergy Move Back (Cultist)
            [31390] = true, -- Necromancer Synergy Move Back (Cultist)
            [31387] = true, -- Necromancer Synergy Kill Self (Cultist)
            [43756] = true, -- Necromancer Synergy Kill Self (Cultist)
            [43757] = true, -- Cultist Synergy Cast (Cultist)

            [14096] = true, -- Heavy Attack -- Footsoldier
            [27683] = true, -- Step Back -- Footsoldier
            [28499] = true, -- Throw Dagger -- Footsoldier
            [28502] = true, -- Throw Dagger -- Footsoldier
            [28504] = true, -- Throw Dagger -- Footsoldier

            [29400] = true, -- Power Bash -- Guard
            [29401] = true, -- Power Bash -- Guard
            [29402] = true, -- Power Bash -- Guard
            [29761] = true, -- Brace -- Guard
            [29759] = true, -- Brace Snare -- Guard
            [29762] = true, -- Blocked Stack -- Guard
            [29757] = true, -- Remove block -- Guard
            [29766] = true, -- Blocked Stack -- Guard
            [29765] = true, -- Uber Attack -- Guard
            [29767] = true, -- Uber Attack -- Guard

            [34917] = true, -- Low Slash -- Brute
            [34919] = true, -- Low Slash -- Brute
            [13705] = true, -- ready for rush -- Brute
            [42832] = true, -- ready for rush -- Brute
            [13701] = true, -- Focused Charge -- Brute
            [14924] = true, -- Focused Charge -- Brute
            [66623] = true, -- charge stun cleanup -- Brute
            [48542] = true, -- Focused Charge -- Brute
            [14935] = true, -- Charge -- Brute
            [14925] = true, -- Charge -- Brute
            [14926] = true, -- Charge -- Brute
            [14921] = true, -- Charge -- Brute
            [14930] = true, -- Charge -- Brute
            [14922] = true, -- Charge -- Brute
            [14923] = true, -- Charge -- Brute

            [26308] = true, -- Cleave -- Ravager
            [29378] = true, -- Uppercut -- Ravager
            [29379] = true, -- Uppercut -- Ravager
            [29380] = true, -- Uppercut -- Ravager

            [29035] = true, -- Quick Strike -- Rogue/Skirmisher
            [12381] = true, -- Assassinate -- Rogue/Skirmisher
            [28408] = true, -- Whirlwind -- Rogue/Skirmisher
            [85339] = true, -- Whirlwind -- Rogue/Skirmisher
            [45508] = true, -- Passing Through -- Rogue/Skirmisher
            [67928] = true, -- Passing Through Immunity -- Rogue/Skirmisher
            [67938] = true, -- Kill Me -- Rogue/Skirmisher
            [67939] = true, -- Damage Self -- Rogue/Skirmisher
            [67930] = true, -- Passing Through Cleanup -- Rogue/Skirmisher
            [45511] = true, -- Spread Out Sound -- Rogue/Skirmisher

            [35164] = true, -- Agony -- Berserker
            [76328] = true, -- Agony -- Berserker
            [35165] = true, -- Agony -- Berserker
            [76330] = true, -- Agony -- Berserker
            [10735] = true, -- Blood Craze -- Berserker
            [49252] = true, -- Blood Craze -- Berserker
            [49253] = true, -- Blood Craze -- Berserker
            [49254] = true, -- Blood Craze -- Berserker
            [44206] = true, -- Minor Maim -- Berserker
            [44208] = true, -- Heated Blades -- Berserker

            [34742] = true, -- Fiery Breath -- Dragonknight
            [34797] = true, -- Fiery Breath -- Dragonknight
            [34646] = true, -- Lava Whip -- Dragonknight
            [34647] = true, -- Lava Whip -- Dragonknight
            [34704] = true, -- Dark Talons -- Dragonknight
            [74472] = true, -- Dark Talons -- Dragonknight
            [34706] = true, -- Dark Talons -- Dragonknight
            [44227] = true, -- Dragonknight Standard -- Dragonknight
            [44228] = true, -- Dragonknight Standard -- Dragonknight
            [44229] = true, -- Dragonknight Standard -- Dragonknight
            [52041] = true, -- Blink Strike -- Dragonknight
            [52045] = true, -- Blink Strike -- Dragonknight
            [52051] = true, -- Blink Strike -- Dragonknight

            [29510] = true, -- Thunder Hammer -- Thundermaul
            [29511] = true, -- Thunder Hammer -- Thundermaul
            [17867] = true, -- Shock Aura -- Thundermaul
            [44407] = true, -- Lightning Form -- Thundermaul
            [44408] = true, -- Lightning Form -- Thundermaul

            [81219] = true, -- Shock -- Thundermaul
            [81215] = true, -- Shock Aura -- Thundermaul
            --[77905] = true, -- Knockback -- Thundermaul
            --[77906] = true, -- Stun -- Thundermaul
            --[57832] = true, -- CC Immunity Knock Back -- Thundermaul
            [81193] = true, -- Agonizing Strike -- Thundermaul
            [81195] = true, -- Agonizing Fury -- Thundermaul
            [81206] = true, -- Agonizing Bolts -- Thundermaul
            [81207] = true, -- Agonizing Bolts -- Thundermaul
            [81196] = true, -- Agonizing Fury -- Thundermaul
            [81197] = true, -- Agonizing Fury -- Thundermaul
            [81217] = true, -- Thunder Hammer -- Thundermaul
            [81218] = true, -- Thunder Hammer -- Thundermaul

            [73712] = true, -- Shadow Cloak -- Nightblade
            [73713] = true, -- Shadow Cloak -- Nightblade
            [36470] = true, -- Veiled Strike -- Nightblade
            [36471] = true, -- Veiled Strike -- Nightblade
            [36460] = true, -- Teleport Strike -- Nightblade
            [63821] = true, -- Teleport Strike -- Nightblade
            [63822] = true, -- Teleport Strike -- Nightblade
            [44345] = true, -- Soul Tether -- Nightblade
            [44349] = true, -- Soul Tether -- Nightblade
            [44352] = true, -- Soul Tether -- Nightblade
            [44350] = true, -- Soul Tether -- Nightblade
            [44346] = true, -- Soul Tether -- Nightblade
            [53462] = true, -- Siphoning Strikes
            [53469] = true, -- Leeching Strikes

            [37108] = true, -- Arrow Spray -- Archer
            [37109] = true, -- Arrow Spray -- Archer
            [37116] = true, -- Arrow Spray -- Archer
            [28628] = true, -- Volley -- Archer
            [28629] = true, -- Volley -- Archer
            [74978] = true, -- Taking Aim -- Archer
            [74980] = true, -- Taking Aim -- Archer

            [89460] = true, -- Set Area -- Pet Ranger
            [16571] = true, -- Set Area -- Pet Ranger
            [36609] = true, -- Set Area -- Pet Ranger
            [36499] = true, -- Roll Dodge -- Pet Ranger
            [88226] = true, -- Call Ally -- Pet Ranger
            [88227] = true, -- Call Ally -- Pet Ranger
            [88252] = true, -- Call Ally -- Pet Ranger
            [88251] = true, -- Call Ally -- Pet Ranger
            [89425] = true, -- Call Ally -- Pet Ranger
            [88281] = true, -- Call Ally -- Pet Ranger
            [88278] = true, -- Call Ally -- Pet Ranger
            [89233] = true, -- Call Ally -- Pet Ranger
            [44301] = true, -- Trap Beast -- Pet Ranger
            [44305] = true, -- Trap Beast -- Pet Ranger
            [44307] = true, -- Trap Beast -- Pet Ranger

            [15164] = true, -- Heat Wave -- Fire Mage
            [16588] = true, -- Heat Wave -- Fire Mage
            [47095] = true, -- Fire Rune -- Fire Mage
            [47096] = true, -- Fire Rune -- Fire Mage
            [47102] = true, -- Fire Rune -- Fire Mage
            [47101] = true, -- Fire Rune -- Fire Mage
            [47103] = true, -- Fire Rune -- Fire Mage

            [14524] = true, -- Shock -- Storm Mage
            [58693] = true, -- Thunder Thrall Check -- Storm Mage
            [29469] = true, -- Thunder Thrall -- Storm Mage
            [29471] = true, -- Thunder Thrall -- Storm Mage
            [29472] = true, -- Thunder Thrall -- Storm Mage
            [29470] = true, -- Thunder Thrall -- Storm Mage

            [12459] = true, -- Winter's Reach -- Frost Mage
            [12460] = true, -- Winter's Reach -- Frost Mage
            [14550] = true, -- Winter's Reach -- Frost Mage
            [14178] = true, -- Ice Barrier -- Frost Mage
            [49902] = true, -- Ice Barrier Immunity -- Frost Mage
            [60898] = true, -- Ice Barrier -- Frost Mage
            [14194] = true, -- Ice Barrier -- Frost Mage
            [29331] = true, -- Ice Barrier -- Frost Mage
            [7145] = true, -- Chilled -- Frost Mage

            [35151] = true, -- Spell Absorption -- Spirit Mage
            [14472] = true, -- Burdening Eye -- Spirit Mage
            [35149] = true, -- Burdening Eye -- Spirit Mage
            [89057] = true, -- Burdening Eye -- Spirit Mage
            [89042] = true, -- Burdening Eye -- Spirit Mage
            [14477] = true, -- Burden -- Spirit Mage
            [89063] = true, -- Burden -- Spirit Mage
            [37200] = true, -- Burden -- Spirit Mage
            [35141] = true, -- Burden -- Spirit Mage
            [35142] = true, -- Burden -- Spirit Mage
            [89041] = true, -- Burdening Eye -- Spirit Mage

            [37150] = true, -- Flare -- Battlemage
            [37028] = true, -- Quick Strike -- Battlemage
            [37029] = true, -- Quick Strike -- Battlemage
            [37030] = true, -- Quick Strike -- Battlemage
            [37021] = true, -- Empower Weapon: Flame -- Battlemage
            [37087] = true, -- Lightning Onslaught -- Battlemage
            [37156] = true, -- Lightning Onslaught -- Battlemage
            [37137] = true, -- Lightning Onslaught -- Battlemage
            [37129] = true, -- Ice Cage -- Battlemage
            [37131] = true, -- Ice Cage -- Battlemage
            [37132] = true, -- Ice Cage -- Battlemage
            [44216] = true, -- Negate Magic -- Battlemage
            [50108] = true, -- Negate Magic -- Battlemage

            [37126] = true, -- Entropic Flare -- Time Bomb Mage
            [36985] = true, -- Void -- Time Bomb Mage
            [36986] = true, -- Void -- Time Bomb Mage
            [14370] = true, -- Void -- Time Bomb Mage
            [36988] = true, -- Void -- Time Bomb Mage
            [36989] = true, -- Void -- Time Bomb Mage
            [36990] = true, -- Void -- Time Bomb Mage

            [56828] = true, -- Fright Force -- Fear Mage
            [14350] = true, -- Aspect of Terror -- Fear Mage
            [37084] = true, -- Aspect of Terror -- Fear Mage
            --[41952] = true, -- Generic Fear Snare -- Fear Mage
            [35849] = true, -- Shadow Cloak -- Fear Mage
            [35865] = true, -- Shadow Cloak -- Fear Mage
            [35850] = true, -- Shadow Cloak -- Fear Mage

            [44247] = true, -- Dark Shade -- Dreadweaver
            --[89005] = true, -- Dark Shade -- Dreadweaver
            [89006] = true, -- Dark Shade -- Dreadweaver
            [89008] = true, -- Dark Shade -- Dreadweaver
            [39729] = true, -- TargetPriorityException -- Dreadweaver
            [44250] = true, -- Dark Shade -- Dreadweaver
            [89017] = true, -- Dark Shade -- Dreadweaver
            [89010] = true, -- Corrode -- Dreadweaver - Dark Shade
            [89012] = true, -- Minor Maim -- Dreadweaver - Dark Shade
            [89016] = true, -- Dark Shade -- Dreadweaver
            [89455] = true, -- Dark Shade -- Dreadweaver

            [44323] = true, -- Dampen Magic -- Soulbrander
            [44258] = true, -- Radiant Magelight -- Soulbrander
            [44263] = true, -- Radiant Magelight -- Soulbrander
            [44259] = true, -- Magelight -- Soulbrander

            [29372] = true, -- Necrotic Spear -- Necromancer
            [5605] = true, -- Summon the Dead -- Necromancer
            [31848] = true, -- Summon the Dead -- Necromancer
            [88582] = true, -- Summon the Dead -- Necromancer
            [88583] = true, -- Summon the Dead -- Necromancer
            --[88586] = true, -- Summon the Dead -- Necromancer
            [88589] = true, -- Summon the Dead -- Necromancer
            --[88600] = true, -- Summon the Dead -- Necromancer
            --[88602] = true, -- Summon the Dead -- Necromancer
            --[88618] = true, -- Summon the Dead -- Necromancer
            --[88611] = true, -- Summon the Dead -- Necromancer
            [88613] = true, -- Summon the Dead -- Necromancer
            [88621] = true, -- Summon the Dead -- Necromancer
            [88622] = true, -- Summon the Dead -- Necromancer
            [88626] = true, -- Summon the Dead -- Necromancer
            [88627] = true, -- Summon the Dead -- Necromancer
            --[88601] = true, -- Summon the Dead -- Necromancer
            --[88593] = true, -- Summon the Dead -- Necromancer
            --[88617] = true, -- Summon the Dead -- Necromancer
            --[88596] = true, -- Summon the Dead -- Necromancer
            [88597] = true, -- Summon the Dead -- Necromancer
            [88598] = true, -- Summon the Dead -- Necromancer
            [88566] = true, -- Summon the Dead -- Necromancer
            [88554] = true, -- Summon the Dead -- Necromancer
            [88555] = true, -- Summon the Dead -- Necromancer
            [88561] = true, -- Summon the Dead -- Necromancer
            [13397] = true, -- Empower Undead -- Necromancer
            [88560] = true, -- Summon the Dead -- Necromancer
            [89230] = true, -- Summon the Dead -- Necromancer

            [7590] = true, -- Entropic Bolt -- Bonelord
            [35387] = true, -- Bone Cage -- Bonelord
            [88322] = true, -- Bone Cage -- Bonelord
            [35391] = true, -- Defiled Grave -- Bonelord
            [35383] = true, -- Summon Abomination -- Bonelord
            [35384] = true, -- Summon Abomination -- Bonelord
            [88522] = true, -- Summon Abomination -- Bonelord
            [88526] = true, -- Summon Abomination -- Bonelord
            [88507] = true, -- Summon Abomination -- Bonelord
            [88504] = true, -- Summon Abomination -- Bonelord
            [88503] = true, -- Summon Abomination -- Bonelord
            [89231] = true, -- Summon Abomination -- Bonelord
            [44339] = true, -- Bone Surge -- Bonelord

            [79803] = true, -- Covetous Return -- Healer
            [10601] = true, -- Minor Wound -- Healer
            [57534] = true, -- Focused Healing -- Healer
            [57536] = true, -- Spread Out Sound -- Healer
            [57537] = true, -- Focused Healing -- Healer
            [57538] = true, -- Focused Healing -- Healer
            [50931] = true, -- Healer Immune -- Healer
            [50975] = true, -- Healer Immune -- Healer
            [50966] = true, -- Healer Immune -- Healer
            [50998] = true, -- Rite of Passage -- Healer
            [44328] = true, -- Rite of Passage -- Healer
            [44329] = true, -- Rite of Passage -- Healer
            [44330] = true, -- Rite of Passage -- Healer
            [44331] = true, -- Rite of Passage Self Snare -- Healer

            [29669] = true, -- Coiled Lash -- Shaman
            [29520] = true, -- Aura of Protection -- Shaman
            [65314] = true, -- Aura of Protection -- Shaman
            [65432] = true, -- Aura of Protection -- Shaman
            [29521] = true, -- Aura of Protection -- Shaman
            [29595] = true, -- Aura of Protection -- Shaman
            [83073] = true, -- Summon Died -- Shaman
            [29597] = true, -- Combustion -- Shaman
            [29598] = true, -- Off Balance -- Shaman

            [68866] = true, -- War Horn -- Faction NPC
            [68867] = true, -- War Horn Battlecry -- Faction NPC
            [68868] = true, -- War Horn Battlecry -- Faction NPC
            [68869] = true, -- War Horn Battlecry -- Faction NPC
            [43644] = true, -- Barrier [monster synergy] -- Faction NPC
            [41793] = true, -- Anti-Cavalry Caltrops -- Faction NPC
            [38118] = true, -- Caltrops -- Faction NPC
            [38119] = true, -- Caltrops -- Faction NPC
            [38125] = true, -- Caltrops -- Faction NPC

            [65033] = true, -- Retaliation -- Winterborn Warrior (DLC)
            [69158] = true, -- Retaliation -- Winterborn Warrior (DLC)
            [69154] = true, -- Retaliation -- Winterborn Warrior (DLC)
            [67114] = true, -- Retaliation -- Winterborn Warrior (DLC)
            [69157] = true, -- Retaliation -- Winterborn Warrior (DLC)
            [69153] = true, -- Retaliation -- Winterborn Warrior (DLC)
            [1347] = true, -- Off-Balance -- Winterborn Warrior (DLC)
            [14883] = true, -- Off-Balance -- Winterborn Warrior (DLC)
            [4508] = true, -- Off-Balance -- Winterborn Warrior (DLC)
            [70070] = true, -- Heavy Strike -- Winterborn Warrior (DLC)
            [64980] = true, -- Javelin -- Winterborn Warrior (DLC)
            [69282] = true, -- Roll Dodge Back -- Winterborn Warrior (DLC)
            [69278] = true, -- Roll Dodge Back -- Winterborn Warrior (DLC)

            [54593] = true, -- Flare -- Winterborn Mage (DLC)
            [55909] = true, -- Grasping Vines -- Winterborn Mage (DLC)
            [55911] = true, -- Grasping Vines -- Winterborn Mage (DLC)
            [55917] = true, -- Grasping Vines -- Winterborn Mage (DLC)
            [55918] = true, -- Grasping Vines -- Winterborn Mage (DLC)
            [55916] = true, -- Grasping Vineburst -- Winterborn Mage (DLC)

            [64704] = true, -- Flames -- Winterborn Mage (DLC)
            [64711] = true, -- Flames -- Winterborn Mage (DLC)
            [64706] = true, -- Flames -- Winterborn Mage (DLC)
            [64707] = true, -- Flames -- Winterborn Mage (DLC)
            [64708] = true, -- Flames -- Winterborn Mage (DLC)
            [64709] = true, -- Flames -- Winterborn Mage (DLC)
            [64710] = true, -- Flames -- Winterborn Mage (DLC)
            [64712] = true, -- Flames -- Winterborn Mage (DLC)
            [64713] = true, -- Flames -- Winterborn Mage (DLC)
            [64714] = true, -- Flames -- Winterborn Mage (DLC)
            [64715] = true, -- Flames -- Winterborn Mage (DLC)
            [64716] = true, -- Flames -- Winterborn Mage (DLC)
            [64717] = true, -- Flames -- Winterborn Mage (DLC)
            [64718] = true, -- Flames -- Winterborn Mage (DLC)
            [64719] = true, -- Flames -- Winterborn Mage (DLC)
            [64720] = true, -- Flames -- Winterborn Mage (DLC)
            [64721] = true, -- Flames -- Winterborn Mage (DLC)
            [64722] = true, -- Flames -- Winterborn Mage (DLC)
            [64723] = true, -- Flames -- Winterborn Mage (DLC)
            [64724] = true, -- Flames -- Winterborn Mage (DLC)
            [64725] = true, -- Flames -- Winterborn Mage (DLC)
            [64726] = true, -- Flames -- Winterborn Mage (DLC)
            [64727] = true, -- Flames -- Winterborn Mage (DLC)

            [54184] = true, -- Revenge 2 -- Vosh Rakh Devoted (DLC)
            [53987] = true, -- Rally -- Vosh Rakh Devoted (DLC)
            [54397] = true, -- Rally -- Vosh Rakh Devoted (DLC)
            [65235] = true, -- Enrage -- Vosh Rakh Devoted (DLC)
            [65237] = true, -- Scary -- Vosh Rakh Devoted (DLC)
            [54027] = true, -- Divine Leap -- Vosh Rakh Devoted (DLC)
            [65183] = true, -- Divine Leap Target -- Vosh Rakh Devoted (DLC)
            [67272] = true, -- Invisible No Target -- Vosh Rakh Devoted (DLC)
            [67273] = true, -- End No Target -- Vosh Rakh Devoted (DLC)
            [54028] = true, -- Divine Leap -- Vosh Rakh Devoted (DLC)
            [82752] = true, -- Divine Leap -- Vosh Rakh Devoted (DLC)
            [67593] = true, -- Divine Leap Stagger -- Vosh Rakh Devoted (DLC)
            [54050] = true, -- Divine Leap Stun -- Vosh Rakh Devoted (DLC)

            [51000] = true, -- Cleave Stance -- Dremora Caitiff (DLC)
            [50927] = true, -- Enter Combat -- Dremora Caitiff (DLC)
            [51921] = true, -- Cleave Stance -- Dremora Caitiff (DLC)
            [51923] = true, -- Cleave Stance -- Dremora Caitiff (DLC)
            [51939] = true, -- Cleave Stance -- Dremora Caitiff (DLC)
            [51940] = true, -- Cleave Stance -- Dremora Caitiff (DLC)
            [51941] = true, -- Cleave Stance -- Dremora Caitiff (DLC)
            [51942] = true, -- Cleave Stance -- Dremora Caitiff (DLC)

            [72723] = true, -- Fool Me Once -- Sentinel (TG DLC)
            [74486] = true, -- Low Slash -- Sentinel (TG DLC)
            [74487] = true, -- Low Slash -- Sentinel (TG DLC)
            [74480] = true, -- Fiery Grip -- Sentinel (TG DLC)
            [74483] = true, -- Fiery Grip -- Sentinel (TG DLC)
            [72748] = true, -- Fool Me Once HOLD -- Sentinel (TG DLC)
            [72725] = true, -- Fool Me Once -- Sentinel (TG DLC)
            [77468] = true, -- Fool Me Once -- Sentinel (TG DLC)

            [74630] = true, -- Flare Trap Proxy -- Archer (TG DLC)
            [72716] = true, -- Uncanny Dodge -- Archer (TG DLC)
            [72717] = true, -- Uncanny Dodge SCU REM -- Archer (TG DLC)
            [72719] = true, -- Uncanny Dodge SCU REM -- Archer (TG DLC)
            [72214] = true, -- Poisoned Arrow -- Archer (TG DLC)
            [72217] = true, -- Poisoned Arrow -- Archer (TG DLC)
            [76089] = true, -- Snipe -- Archer (TG DLC)
            [72221] = true, -- Shadow Cloak -- Archer (TG DLC)
            [72222] = true, -- Shadow Cloak -- Archer (TG DLC)
            [72220] = true, -- Snipe -- Archer (TG DLC)
            [74628] = true, -- Flare Trap -- Archer (TG DLC)
            [74618] = true, -- Flare Trap -- Archer (TG DLC)
            [74627] = true, -- Flare Trap -- Archer (TG DLC)
            [77446] = true, -- Flare Trap -- Archer (TG DLC)
            [74619] = true, -- Flare Trap -- Archer (TG DLC)
            [74621] = true, -- Revealed -- Archer (TG DLC)
            [74620] = true, -- Flare Trap REM -- Archer (TG DLC)

            [77474] = true, -- Dutiful Fury -- Bodyguard (DB DLC)
            [77475] = true, -- Dutiful Fury -- Bodyguard (DB DLC)
            [77477] = true, -- Dutiful Fury -- Bodyguard (DB DLC)
            [77476] = true, -- Dutiful Fury -- Bodyguard (DB DLC)
            [77489] = true, -- Dutiful Fury -- Bodyguard (DB DLC)
            [81360] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77472] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [79523] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [81366] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77672] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77748] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77742] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77778] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77765] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77750] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77697] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77738] = true, -- 'Til Death -- Bodyguard (DB DLC)
            [77554] = true, -- Shard Shield -- Bodyguard (DB DLC)
            [77555] = true, -- Shard Shield -- Bodyguard (DB DLC)
            [79534] = true, -- Shard Shield -- Bodyguard (DB DLC)
            [83620] = true, -- Shard Shield -- Bodyguard (DB DLC)
            [83624] = true, -- Shard Shield -- Bodyguard (DB DLC)
            [77562] = true, -- Shard Shield -- Bodyguard (DB DLC)
            [77609] = true, -- Shard Shield -- Bodyguard (DB DLC)
            [77602] = true, -- Shard Shield -- Bodyguard (DB DLC)
            [77473] = true, -- Shield Charge -- Bodyguard (DB DLC)
            [77838] = true, -- Shield Charge -- Bodyguard (DB DLC)
            [77815] = true, -- Shield Charge -- Bodyguard (DB DLC)
            [77927] = true, -- Staggered -- Bodyguard (DB DLC)

            [77020] = true, -- Basilisk Powder (Tracker)
            [77089] = true, -- Basilisk Powder (Tracker)
            [77087] = true, -- Basilisk Powder (Tracker)
            [77086] = true, -- Basilisk Powder (Tracker)
            [79954] = true, -- Basilisk Powder (Tracker)
            [77019] = true, -- Pin (Tracker)
            [77030] = true, -- Pin (Tracker)
            [78432] = true, -- Lunge (Tracker)
            [79993] = true, -- Lunge (Tracker)
            [79955] = true, -- Lunge (Tracker)
            [78435] = true, -- Lunge (Tracker)
            [79930] = true, -- Lunge (Tracker)
            [79929] = true, -- Lunge (Tracker)
            [78664] = true, -- Lunge (Tracker)

            [88481] = true, -- Spectral Claw (Beastcaller)
            [88478] = true, -- Swarm (Beastcaller)
            [88371] = true, -- Dive (Beastcaller)
            [88393] = true, -- Dive (Beastcaller)
            [88394] = true, -- Gore (Beastcaller)
            [88395] = true, -- Gore (Beastcaller)
            [88400] = true, -- Gore (Beastcaller)
            [88409] = true, -- Raise the Earth (Beastcaller)
            [88657] = true, -- Feral Guardian (Beastcaller)
            [92303] = true, -- Despawn Override (Beastcaller)
            [92158] = true, -- Raise the Earth (Beastcaller)
            [92157] = true, -- Raise the Earth (Beastcaller)
            [92159] = true, -- Raise the Earth (Beastcaller)
            --[92156] = true, -- Summon the Dead (Beastcaller)

            [87854] = true, -- Quick Shot (Arbalest)
            [87855] = true, -- Arrow Stab (Arbalest)
            [87901] = true, -- Bombard (Arbalest)
            [90399] = true, -- Bombard (Arbalest)
            [87904] = true, -- Bombard (Arbalest)
            [87902] = true, -- Bombard (Arbalest)
            [87713] = true, -- Quakeshot (Arbalest)
            [87715] = true, -- Quakeshot (Arbalest)
            [87834] = true, -- Quakeshot (Arbalest)
            [87835] = true, -- Quakeshot (Arbalest)
            [87837] = true, -- Quakeshot (Arbalest)
            [87852] = true, -- Quakeshot (Arbalest)
            [87422] = true, -- Chilled Ground (Arbalest)
            [87491] = true, -- Chilled Ground (Arbalest)

            [86881] = true, -- Hack
            [86882] = true, -- Hack
            [86883] = true, -- Slash
            [86884] = true, -- Slash
            [85342] = true, -- Twin Slashes
            [85343] = true, -- Twin Slashes
            [85368] = true, -- Twin Slashes Bleed
            [86879] = true, -- Chop
            [86880] = true, -- Hack
            [85359] = true, -- Reverse Slash
            [85365] = true, -- Assassinate Bonus
            [86704] = true, -- Chop (Hleran Noble)
            [86705] = true, -- Lop (Hleran Noble)
            [85361] = true, -- Puncture (Hleran Noble)
            [85362] = true, -- Major Fracture (Hleran Noble)

            [87064] = true, -- Volcanic Debris (Fire-Binder)
            [87067] = true, -- Volcanic Debris (Fire-Binder)
            [87065] = true, -- Volcanic Debris (Fire-Binder)
            [92647] = true, -- Volcanic Debris (Fire-Binder)
            [87069] = true, -- Volcanic Debris (Fire-Binder)
            [87068] = true, -- Volcanic Debris (Fire-Binder)
            [87066] = true, -- Volcanic Debris (Fire-Binder)
            [88845] = true, -- Empower Atronach (Fire-Binder)
            --[92646] = true, -- Volcanic Debris (Fire-Binder)

            [81545] = true, -- Fright Force (Voidbringer)
            [76621] = true, -- Shadeway (Voidbringer)
            [76760] = true, -- Shadeway (Voidbringer)
            [76762] = true, -- Shadeway (Voidbringer)
            [76784] = true, -- Shadeway (Voidbringer)
            [76843] = true, -- Shadeway (Voidbringer)
            [76619] = true, -- Pool of Shadow (Voidbringer)
            [76623] = true, -- Pool of Shadow (Voidbringer)
            [76730] = true, -- Pool of Shadow (Voidbringer)
            [76624] = true, -- Pool of Shadow (Voidbringer)
            [76668] = true, -- Pool of Shadow (Voidbringer)
            [76669] = true, -- Pool of Shadow (Voidbringer)
            [76653] = true, -- Pool of Shadow (Voidbringer)
            [76729] = true, -- Pool of Shadow (Voidbringer)
            [76728] = true, -- Pool of Shadow (Voidbringer)
            [76821] = true, -- SHA Deepest Shadow BON (Voidbringer)
            [76620] = true, -- Shadowy Duplicate (Voidbringer)
            [77005] = true, -- Shadowy Duplicate (Voidbringer)
            [80211] = true, -- Shadowy Duplicate (Voidbringer)
            [76967] = true, -- Shadowy Duplicate (Voidbringer)
            [76979] = true, -- Shadowy Duplicate (Voidbringer)
            [76995] = true, -- Shadowy Duplicate (Voidbringer)
            [76969] = true, -- Shadowy Duplicate (Voidbringer)
            [76955] = true, -- Shadowy Duplicate (Voidbringer)
            [76957] = true, -- Shadowy Duplicate (Voidbringer)
            [81079] = true, -- Shadowy Duplicate (Voidbringer)
            [76998] = true, -- Shadowy Duplicate (Voidbringer)
            [76996] = true, -- Shadowy Duplicate (Voidbringer)
            [76985] = true, -- Shadowy Duplicate (Voidbringer)
            [77009] = true, -- Shadowy Duplicate (Voidbringer)

            [88361] = true, -- Vile Flare (Skaafin Masquer)
            [88327] = true, -- Shadeway (Skaafin Masquer)
            [88337] = true, -- Shadeway (Skaafin Masquer)
            [88338] = true, -- Shadeway (Skaafin Masquer)
            [88339] = true, -- Shadeway (Skaafin Masquer)
            [88341] = true, -- Shadeway (Skaafin Masquer)
            [88325] = true, -- Pool of Shadow (Skaafin Masquer)
            [88329] = true, -- Pool of Shadow (Skaafin Masquer)
            [88336] = true, -- Pool of Shadow (Skaafin Masquer)
            [88330] = true, -- Pool of Shadow (Skaafin Masquer)
            [88332] = true, -- Pool of Shadow (Skaafin Masquer)
            [88333] = true, -- Pool of Shadow (Skaafin Masquer)
            [88331] = true, -- Pool of Shadow (Skaafin Masquer)
            [88335] = true, -- Pool of Shadow (Skaafin Masquer)
            [88334] = true, -- Pool of Shadow (Skaafin Masquer)
            [88340] = true, -- Deep Denial (Skaafin Masquer)
            [88326] = true, -- Create Masque (Skaafin Masquer)
            [88353] = true, -- Create Masque (Skaafin Masquer)
            [88358] = true, -- Shadowy Duplicate (Skaafin Masquer)
            [88345] = true, -- Shadowy Duplicate (Skaafin Masquer)
            [88348] = true, -- Shadowy Duplicate (Skaafin Masquer)
            [88350] = true, -- Shadowy Duplicate (Skaafin Masquer)
            [88346] = true, -- Shadowy Duplicate (Skaafin Masquer)
            [88342] = true, -- Create Masque (Skaafin Masquer)
            [88383] = true, -- Create Masque (Skaafin Masquer)
            [88343] = true, -- Create Masque (Skaafin Masquer)
            [88360] = true, -- Create Masque (Skaafin Masquer)
            [88352] = true, -- Create Masque (Skaafin Masquer)
            [88351] = true, -- Shadowy Duplicate (Skaafin Masquer)
            [88349] = true, -- Shadowy Duplicate (Skaafin Masquer)
            [88354] = true, -- Shadowy Duplicate (Skaafin Masquer)

            [84817] = true, -- Skaafin Flare (Skaafin Witchling)
            [84815] = true, -- Skaafin Flare (Skaafin Witchling)
            [84818] = true, -- Fiendish Healing (Skaafin Witchling)
            [84831] = true, -- Fiendish Healing (Skaafin Witchling)
            [84829] = true, -- Fiendish Healing (Skaafin Witchling)
            [84833] = true, -- Fiendish Healing (Skaafin Witchling)
            [84820] = true, -- Fiendish Healing (Skaafin Witchling)
            [84821] = true, -- Fiendish Healing (Skaafin Witchling)

            --[84835] = true, -- Broken Pact (Skaafin)
            --[84851] = true, -- Broken Pact (Skaafin)
            --[84850] = true, -- Broken Pact (Skaafin)
            --[84838] = true, -- Broken Pact (Skaafin)
            --[84836] = true, -- Broken Pact (Skaafin)
            --[84837] = true, -- Broken Pact (Skaafin)

            -- CYRODIIL GUARDS
            [47717] = true, -- Quick Strike (Guard T1)
            [46220] = true, -- Puncture (Guard T1 + T2)
            [46221] = true, -- Puncture (Guard T1 + T2)
            [46830] = true, -- Bleeding Strike (Guard T2)
            [46832] = true, -- Bleeding (Guard T2)
            [46831] = true, -- Bleeding (Guard T2)
            [46834] = true, -- Power Bash (Guard T2)
            [72639] = true, -- Power Bash (Guard T2)
            [72641] = true, -- Power Bash (Guard T2)
            [74087] = true, -- Power Bash (Guard T2)
            [36304] = true, -- Razor Armor (Guard T2)
            [36306] = true, -- Razor Armor (Guard T2)
            [36305] = true, -- Spike Armor Damage Return (Guard T2)

            [7880] = true, -- Light Attack (Mage T1)
            [7881] = true, -- Guardian Storm (Mage T1)
            [7883] = true, --  Guardian Storm (Mage T1)
            [21629] = true, -- Mage's Lifesteal (Mage T1)
            [21632] = true, -- Lifesteal (Mage T1)
            [21631] = true, -- Lifesteal (Mage T1)
            [46335] = true, -- Crystal Shard (Mage T1)
            [46336] = true, -- Crystal Shard Stun (Mage T1)

            [46711] = true, -- Bound Aegis (Mage T2)
            [46726] = true, -- Shock Torrent (Mage T2)
            [46730] = true, -- Shock Torrent (Mage T2)
            [46818] = true, -- Lasting Storm (Mage T2)
            [46819] = true, -- Storm Damage (Mage T2)
            [46716] = true, -- Stolen Essence (Mage T2)
            [46719] = true, -- Stolen Essence (Mage T2)
            [46718] = true, -- Lifesteal (Mage T2)
            [46717] = true, -- Lifesteal (Mage T2)
            [46704] = true, -- Crystal Blast (Mage T2)
            [46706] = true, -- Crystal Shard Stun (Mage T2)
            [52806] = true, -- Unstable Core (Mage T2)
            [52808] = true, -- Unstable Core  (Mage T2)
            [75397] = true, -- Unstable Core (Mage T2)
            [75395] = true, -- Reflected FX (Mage T2)

            [57962] = true, -- Minor Wound (Mender T1)
            [46236] = true, -- Rune Focus (Mender T1)
            [46270] = true, -- Summon Shade (Mender T1)
            [46272] = true, -- Rune Focus (Mender T1)
            [21636] = true, -- Telekinetic Prison (Mender T1)
            [21638] = true, -- Telekinetic Disorient (Mender T1)
            [46839] = true, -- Major Wound (Mender T2)
            [46902] = true, -- Rune Power (Mender T2)
            [46903] = true, -- Summon Shade (Mender T2)
            [46904] = true, -- Rune Focus (Mender T2)
            [46905] = true, -- Shattering Prison (Mender T2)
            [46906] = true, -- Telekinetic Disorient (Mender T2)
            [46910] = true, -- Shattering Prison (Mender T2)
            [46847] = true, -- Potent Healing (Mender T2)
            [52862] = true, -- Health Boon (Mender T2)
            [22469] = true, -- Siege Shield (Mender T2)
            [22489] = true, -- Siege Bubble (Mender T2)
            [32423] = true, -- Siege heal (Mender T2)
            [51891] = true, -- Negate Magic (Mender T2)
            [51893] = true, -- Negate Magic (Mender T2)
            [51894] = true, -- Negate Magic (Mender T2)

            [52864] = true, -- Quick Shot (Archer T1)
            --[54257] = true, -- Upgraded Volley (Archer T2)
            --[54258] = true, -- Upgraded Volley (Archer T2)
            [54264] = true, -- Lethal Arrow (Archer T2)
            [54265] = true, -- Lethal Arrow (Archer T2)
            [54259] = true, -- Draining Shot (Archer T2)
            [54261] = true, -- Draining Shot (Archer T2)

            [16510] = true, -- Fire Salvo (Honor Guard T1)
            [15780] = true, -- Honor Guard Rage (Honor Guard T1)
            [32446] = true, -- Guardian Heal (Honor Guard T1)
            [32447] = true, -- Dragon Blood (Honor Guard T1)
            [35113] = true, -- Extended Chains (Honor Guard T1)
            [35115] = true, -- Pull (Honor Guard T1)
            [46990] = true, -- Improved Fire Torrent (Honor Guard T1)
            [46991] = true, -- Fire Torrent Burning (Honor Guard T1)
            [46992] = true, -- Crippling Rage (Honor Guard T1)
            [47001] = true, -- Crippling Rage (Honor Guard T1)
            [47004] = true, -- Guardian Heal (Honor Guard T1)
            [47005] = true, -- Dragon Blood (Honor Guard T1)
            [47019] = true, -- Puncturing Chains (Honor Guard T1)
            [47023] = true, -- Puncture (Honor Guard T1)
            [47020] = true, -- Pull (Honor Guard T1)
            [15781] = true, -- Triple Strike (Honor Guard T1 + T2)
            [15783] = true, -- Triple Strike (Honor Guard T1 + T2)
            [15782] = true, -- Triple Strike (Honor Guard T1 + T2)

            -- ANIMALS

            [5451] = true, -- Bite -- Alit
            [5452] = true, -- Lacerate -- Alit
            [84356] = true, -- Lacerate -- Alit
            [56984] = true, -- Laceration -- Alit
            [56983] = true, -- Laceration -- Alit

            [4413] = true, -- Swipe -- Bear
            [4415] = true, -- Crushing Swipe -- Bear
            [38772] = true, -- Crushing Swipe -- Bear
            [18273] = true, -- Crushing Swipe -- Bear
            [4416] = true, -- Savage Blows -- Bear
            [12380] = true, -- Savage Blows -- Bear
            [61594] = true, -- Savage Blows Bleeding -- Bear
            [4419] = true, -- Daunting Roar -- Bear

            [70355] = true, -- Bite -- Great Bear
            [70357] = true, -- Lunge -- Great Bear
            [70359] = true, -- Lunge -- Great Bear
            [70366] = true, -- Slam -- Great Bear
            [89189] = true, -- Slam -- Great Bear
            [69073] = true, -- Knockdown -- Great Bear
            [70372] = true, -- Ferocity -- Great Bear
            [70375] = true, -- Ferocity -- Great Bear
            [70376] = true, -- Ferocity -- Great Bear
            [70374] = true, -- Ferocity -- Great Bear

            [4583] = true, -- Bite -- Crocodile
            [9642] = true, -- Bite -- Crocodile
            [4587] = true, -- Crushing Chomp -- Crocodile
            [4591] = true, -- Sweep -- Crocodile
            [32051] = true, -- Sweep -- Crocodile
            [4594] = true, -- Ancient Skin -- Crocodile

            [8971] = true, -- Bite -- Duneripper
            [9643] = true, -- Bite -- Duneripper
            [8972] = true, -- Crushing Chomp -- Duneripper
            [8977] = true, -- Sweep -- Duneripper
            [32461] = true, -- Sweep -- Duneripper
            [8974] = true, -- Burrow -- Duneripper
            [42866] = true, -- Burrow -- Duneripper
            [82269] = true, -- DuneRipper Birth -- Duneripper

            [7214] = true, -- Bite -- Durzog
            [7221] = true, -- Rend -- Durzog
            [7227] = true, -- Rotbone -- Durzog
            [16878] = true, -- Rotbone -- Durzog

            [6304] = true, -- Swipe -- Dreugh
            [18002] = true, -- Slash -- Dreugh
            [18003] = true, -- Slash -- Dreugh
            [18005] = true, -- Slash -- Dreugh
            [6308] = true, -- Shocking Touch -- Dreugh
            [6328] = true, -- Shocking Rake -- Dreugh
            [27100] = true, -- Shocking Rake -- Dreugh

            [54374] = true, -- Tusks -- Echatere
            [54375] = true, -- Shockwave -- Echatere
            [54378] = true, -- Shockwave -- Echatere
            [68971] = true, -- Staggered -- Echatere
            [54380] = true, -- Headbutt -- Echatere
            [54382] = true, -- Headbutt -- Echatere
            [54381] = true, -- Headbutt -- Echatere

            [4628] = true, -- Scrape -- Giant Bat
            [60920] = true, -- Scrape -- Giant Bat
            [4632] = true, -- Screech -- Giant Bat
            [47321] = true, -- Screech -- Giant Bat
            [18319] = true, -- Screech -- Giant Bat
            [4630] = true, -- Draining Bite -- Giant Bat
            [18320] = true, -- Draining Bite -- Giant Bat

            [8540] = true, -- Strike -- Giant Snake
            [5240] = true, -- Lash -- Giant Snake
            [30214] = true, -- Lash -- Giant Snake
            [5242] = true, -- Kiss of Poison -- Giant Snake
            [21826] = true, -- Kiss of Poison -- Giant Snake
            [5244] = true, -- Shed Skin -- Giant Snake
            [21993] = true, -- Shed Skin -- Giant Snake

            [5440] = true, -- Bite -- Guar
            [5443] = true, -- Headbutt -- Guar
            [5441] = true, -- Dive -- Guar
            [84359] = true, -- Dive -- Guar

            [72803] = true, -- Hardened Shell - Haj Mota
            [74123] = true, -- Claw -- Haj Mota
            [72786] = true, -- Horn Strike -- Haj Mota
            [72787] = true, -- Horn Strike -- Haj Mota
            [73479] = true, -- Horn Strike -- Haj Mota
            [73481] = true, -- Horn Strike -- Haj Mota
            [74272] = true, -- Bite -- Haj Mota
            [76578] = true, -- Bite -- Haj Mota
            [72793] = true, -- Toxic Mucus -- Haj Mota
            [76577] = true, -- Toxic Mucous -- Haj Mota
            [72815] = true, -- Toxic Mucous -- Haj Mota
            [72794] = true, -- Toxic Pool -- Haj Mota
            [72795] = true, -- Toxic Pool -- Haj Mota
            [72796] = true, -- Bog Burst -- Haj Mota
            [72799] = true, -- Bog Burst -- Haj Mota
            [76183] = true, -- Bog Burst -- Haj Mota
            [72800] = true, -- Bog Burst -- Haj Mota
            [74336] = true, -- Bog Burst -- Haj Mota
            [74337] = true, -- Bog Burst -- Haj Mota
            [76184] = true, -- Bog Burst -- Haj Mota
            [72789] = true, -- Shockwave -- Haj Mota
            [75828] = true, -- Shockwave -- Haj Mota
            [73494] = true, -- Shockwave -- Haj Mota
            [73495] = true, -- Shockwave -- Haj Mota
            [73496] = true, -- Shockwave -- Haj Mota
            [73497] = true, -- Shockwave -- Haj Mota
            [73498] = true, -- Shockwave -- Haj Mota
            [73499] = true, -- Shockwave -- Haj Mota

            [5362] = true, -- Slam -- Kagouti
            [5363] = true, -- Chomp -- Kagouti
            [5926] = true, -- Toss -- Kagouti
            [42889] = true, -- Toss -- Kagouti
            [42888] = true, -- Toss -- Kagouti
            [18198] = true, -- Toss -- Kagouti
            [14202] = true, -- Charge
            [14196] = true, -- Charge
            [14819] = true, -- Charge
            [48544] = true, -- Charge
            [14825] = true, -- Charge
            [14828] = true, -- Charge
            [14829] = true, -- Charge
            [18751] = true, -- Charge

            [7170] = true, -- Rend -- Lion
            [60630] = true, -- Rend -- Lion
            [60641] = true, -- Claw -- Lion
            [7158] = true, -- Bite -- Lion
            [7161] = true, -- Double Strike -- Lion
            [7176] = true, -- Daunting Roar -- Lion
            [8705] = true, -- Weakness -- Lion

            [8596] = true, -- Swipe -- Mammoth
            [8601] = true, -- Vigorous Swipe -- Mammoth
            [8604] = true, -- Vigorous Swipe -- Mammoth
            [75633] = true, -- Vigorous Swipe -- Mammoth
            [75634] = true, -- Vigorous Swipes -- Mammoth
            [8600] = true, -- Stomp -- Mammoth
            [23164] = true, -- Stomp -- Mammoth
            [23230] = true, -- Charge -- Mammoth
            [48551] = true, -- Focused Charge -- Mammoth
            [23223] = true, -- Focused Charge -- Mammoth
            [23226] = true, -- Charge -- Mammoth
            [23221] = true, -- Charge -- Mammoth
            [23222] = true, -- Charge -- Mammoth
            [23225] = true, -- Charge -- Mammoth
            [23227] = true, -- Charge -- Mammoth
            [23224] = true, -- Charge -- Mammoth

            [4192] = true, -- Pincer -- Mudcrab
            [4224] = true, -- Double Claw Strike -- Mudcrab
            [4226] = true, -- Double Claw Strike -- Mudcrab
            [4200] = true, -- Unforgiving Claws -- Mudcrab
            [85082] = true, -- Unforgiving Claws -- Mudcrab
            [28825] = true, -- Scuttle -- Mudcrab
            [42841] = true, -- Scuttle -- Mudcrab

            [16667] = true, -- Slap -- Netch
            [16690] = true, -- Thrust -- Netch
            [16697] = true, -- Poisonbloom -- Netch
            [16698] = true, -- Poisonbloom -- Netch

            [7266] = true, -- Strike -- Nix-Hound
            [13416] = true, -- Strike -- Nix-Hound
            [7268] = true, -- Leech -- Nix-Hound
            [12303] = true, -- Leech -- Nix-Hound
            [18344] = true, -- Leech -- Nix-Hound
            [7273] = true, -- Dampworm -- Nix-Hound
            [38635] = true, -- Dampworm -- Nix-Hound
            [38640] = true, -- Dampworm -- Nix-Hound
            [7271] = true, -- Ambush -- Nix-Hound
            [18190] = true, -- Shadowstep -- Nix-Hound

            [5362] = true, -- Slam -- Skeever
            [21904] = true, -- Rend -- Skeever

            [21947] = true, -- Bite -- Wamasu
            [21949] = true, -- Sweep -- Wamasu
            [46833] = true, -- Sweep -- Wamasu
            [37178] = true, -- Sweep -- Wamasu
            [21951] = true, -- Repulsion Shock -- Wamasu
            [21952] = true, -- Repulsion Shock -- Wamasu
            [22045] = true, -- Static -- Wamasu
            [21956] = true, -- Charge -- Wamasu
            [21957] = true, -- Charge -- Wamasu
            [48556] = true, -- Focused Charge -- Wamasu
            [21960] = true, -- Focused Charge -- Wamasu
            [21964] = true, -- Charge -- Wamasu
            [21963] = true, -- Charge -- Wamasu
            [21961] = true, -- Charge -- Wamasu
            [21967] = true, -- Charge -- Wamasu
            [21962] = true, -- Charge -- Wamasu
            [21959] = true, -- Charge -- Wamasu

            [44781] = true, -- Swipe -- Welwa
            [45937] = true, -- Cleave -- Welwa
            [44791] = true, -- Rear Kick -- Welwa
            [44792] = true, -- Rear Kick -- Welwa
            [47942] = true, -- Charge -- Welwa
            [50714] = true, -- Focused Charge -- Welwa
            [52417] = true, -- Charge -- Welwa
            [45987] = true, -- Focused Charge -- Welwa
            [45990] = true, -- Charge -- Welwa
            [45986] = true, -- Charge -- Welwa
            [45991] = true, -- Charge -- Welwa
            [52828] = true, -- Charge -- Welwa
            [45984] = true, -- Charge -- Welwa
            [52829] = true, -- Charge -- Welwa
            [51842] = true, -- Snare Weakness -- Welwa
            [51843] = true, -- CON_Knockback&Knockdown -- Welwa
            [44782] = true, -- Roll Dodge -- Welwa
            [48697] = true, -- Roll Dodge -- Welwa
            [48698] = true, -- Roll Dodge -- Welwa

            [4022] = true, -- Bite -- Wolf
            [42844] = true, -- Rotbone -- Wolf
            [14523] = true, -- Helljoint -- Wolf
            [75818] = true, -- Helljoint -- Wolf
            [13808] = true, -- Call of the Pack -- Wolf
            [45720] = true, -- Call of the Pack -- Wolf
            [45721] = true, -- Call of the Pack -- Wolf
            [14272] = true, -- Call of the Pack -- Wolf
            [14273] = true, -- Call of the Pack -- Wolf
            [45751] = true, -- Call of the Pack -- Jackal
            [45753] = true, -- Call of the Pack -- Jackal
            [26658] = true, -- Call of the Pack -- Jackal
            --[26659] = true, -- Call of the Pack -- Jackal
            [4114] = true, -- Howl -- Wolf

            [76319] = true, -- Backstab -- Dire Wolf
            [80382] = true, -- Bite -- Dire Wolf
            [80383] = true, -- Bite -- Dire Wolf
            [76307] = true, -- Lunge -- Dire Wolf
            [76308] = true, -- Lunge -- Dire Wolf
            [76303] = true, -- Nip -- Dire Wolf
            [76304] = true, -- Nip -- Dire Wolf
            [76305] = true, -- Gnash -- Dire Wolf
            [76306] = true, -- Gnash -- Dire Wolf
            [76311] = true, -- Harry -- Dire Wolf
            [85656] = true, -- Harry -- Dire Wolf
            [76312] = true, -- Harry -- Dire Wolf
            [76313] = true, -- Harry -- Dire Wolf
            [80568] = true, -- Harry -- Dire Wolf
            [80569] = true, -- Harry -- Dire Wolf
            [80570] = true, -- Harry -- Dire Wolf
            [80571] = true, -- Harry -- Dire Wolf
            [76317] = true, -- Harry -- Dire Wolf
            [80576] = true, -- Harry Finder -- Dire Wolf
            [76324] = true, -- Baleful Call -- Dire Wolf
            [76322] = true, -- Baleful Call -- Dire Wolf

            -- DAEDRA
            [51256] = true, -- Siphon (Shared Daedra)

            [48092] = true, -- Swipe -- Air Atronach
            [48093] = true, -- Swipe -- Air Atronach
            [48096] = true, -- Flare -- Air Atronach
            [48121] = true, -- Heavy Attack -- Air Atronach
            [48137] = true, -- Tornado -- Air Atronach
            [81912] = true, -- CL-SS Flame Atronach spawn in -- Air Atronach
            [51261] = true, -- Combustion -- Air Atronach
            [51262] = true, -- Air Atronach Flame -- Air Atronach
            [51265] = true, -- Air Atronach Flame -- Air Atronach
            [51281] = true, -- Flame Tornado -- Air Atronach
            [51282] = true, -- Flame Tornado -- Air Atronach
            [49565] = true, -- CL-SS Storm Atronach spawn in -- Air Atronach
            [51272] = true, -- Combustion -- Air Atronach
            [51271] = true, -- Air Atronach Flame -- Air Atronach
            [51270] = true, -- Air Atronach Flame -- Air Atronach
            [50023] = true, -- Lightning Rod -- Air Atronach
            [88902] = true, -- Lightning Rod -- Air Atronach
            [50026] = true, -- Lightning Rod -- Air Atronach
            [81936] = true, -- CL-SS Frost Atronach spawn in -- Air Atronach
            [51268] = true, -- Combustion -- Air Atronach
            [51269] = true, -- Air Atronach Flame -- Air Atronach
            [51267] = true, -- Air Atronach Flame -- Air Atronach
            [50021] = true, -- Ice Vortex -- Air Atronach
            [50022] = true, -- Ice Vortex -- Air Atronach

            [9743] = true, -- Entropic Touch -- Banekin
            [9747] = true, -- Dire Wound -- Banekin
            [9748] = true, -- Envelop -- Banekin
            [9749] = true, -- Envelop -- Banekin

            [4798] = true, -- Headbutt -- Clannfear
            [4799] = true, -- Tail Spike -- Clannfear
            [84443] = true, -- Tail Spike -- Clannfear
            [93745] = true, -- Rending Leap -- Clannfear
            [93746] = true, -- Rending Leap -- Clannfear
            [94899] = true, -- Rending Leap -- Clannfear
            [93750] = true, -- Rending Leap -- Clannfear
            [93748] = true, -- Rending Leap Ranged -- Clannfear
            [91395] = true, -- Devour -- Clannfear
            [91398] = true, -- Devour -- Clannfear
            [91396] = true, -- Devour -- Clannfear

            [26551] = true, -- Strike -- Daedric Titan
            [32852] = true, -- Scourge Bolt -- Daedric Titan
            [26641] = true, -- Soul Flame -- Daedric Titan
            [32696] = true, -- Soul Flame -- Daedric Titan
            [35280] = true, -- Soul Flame -- Daedric Titan
            [35277] = true, -- Soul Flame -- Daedric Titan
            [73437] = true, -- Soul Flame -- Daedric Titan
            [35278] = true, -- Soul Flame -- Daedric Titan
            [26554] = true, -- Wing Gust -- Daedric Titan
            [33085] = true, -- Wing Gust -- Daedric Titan
            [33086] = true, -- Wing Gust -- Daedric Titan

            [4750] = true, -- Jagged Claw -- Daedroth
            [4778] = true, -- Fiery Jaws -- Daedroth
            [4771] = true, -- Fiery Breath -- Daedroth
            [4772] = true, -- Fiery Breath -- Daedroth
            [91946] = true, -- Ground Tremor -- Daedroth
            [91947] = true, -- Ground Tremor -- Daedroth
            [91952] = true, -- Ground Tremor -- Daedroth
            [91950] = true, -- Ground Tremor -- Daedroth
            [91955] = true, -- Ground Tremor -- Daedroth
            [91956] = true, -- Ground Tremor -- Daedroth
            [91953] = true, -- Ground Tremor -- Daedroth
            [91949] = true, -- Ground Tremor -- Daedroth
            [91937] = true, -- Burst of Embers -- Daedroth
            [91939] = true, -- Burst of Embers -- Daedroth
            [91941] = true, -- Burst of Embers -- Daedroth
            [91940] = true, -- Burst of Embers -- Daedroth
            [91943] = true, -- Burst of Embers -- Daedroth
            [91942] = true, -- Burst of Embers -- Daedroth
            [91938] = true, -- Burst of Embers -- Daedroth

            [18471] = true, -- Flare -- Flame Atronach
            [18472] = true, -- Flare -- Flame Atronach
            [15157] = true, -- Flare -- Flame Atronach
            [12254] = true, -- Flare -- Flame Atronach
            [26324] = true, -- Lava Geyser -- Flame Atronach
            [26325] = true, -- Lava Geyser -- Flame Atronach
            [4891] = true, -- Radiance -- Flame Atronach
            [4491] = true, -- Radiance -- Flame Atronach
            [26319] = true, -- Combustion -- Flame Atronach
            [50216] = true, -- Combustion -- Flame Atronach
            [50215] = true, -- Combustion -- Flame Atronach

            [4813] = true, -- Claw -- Flesh Atronach
            [63275] = true, -- Claw -- Flesh Atronach
            [16524] = true, -- Stomp -- Flesh Atronach
            [63276] = true, -- Stomp -- Flesh Atronach
            [4829] = true, -- Fire Brand -- Flesh Atronach
            [35413] = true, -- Fire Brand -- Flesh Atronach
            [4817] = true, -- Unyielding Mace -- Flesh Atronach
            [65234] = true, -- Snare Atronach -- Flesh Atronach
            [20226] = true, -- Stun -- Flesh Atronach
            [27326] = true, -- Unyielding Mace -- Flesh Atronach
            [23077] = true, -- Bleeding -- Flesh Atronach

            [67870] = true, -- Tremor AOE -- Flesh Colossus
            [67123] = true, -- Tremor -- Flesh Colossus
            [67637] = true, -- Falling Debris Projectile -- Flesh Colossus
            [67636] = true, -- Falling Debris -- Flesh Colossus
            [67626] = true, -- Debris Target 1 -- Flesh Colossus
            [67627] = true, -- Debris Target 2 -- Flesh Colossus
            [67628] = true, -- Debris Target 3 -- Flesh Colossus
            [67629] = true, -- Debris Target 4 -- Flesh Colossus
            [66869] = true, -- Pin -- Flesh Colossus
            [67076] = true, -- Self Snare -- Flesh Colossus
            [65709] = true, -- Pin -- Flesh Colossus
            [49820] = true, -- Stunned -- Flesh Colossus
            [65735] = true, -- Maisma Channel -- Flesh Colossus
            [50341] = true, -- Miasma Pool -- Flesh Colossus
            [65746] = true, -- Miasma Pool -- Flesh Colossus
            [53233] = true, -- Miasma Pool -- Flesh Colossus
            [67872] = true, -- Sweep -- Flesh Colossus
            [68824] = true, -- Sweep -- Flesh Colossus
            [68813] = true, -- Sweep Knockbavck -- Flesh Colossus
            [67829] = true, -- Sweep Line Origin -- Flesh Colossus
            [67831] = true, -- Sweep Line 1 -- Flesh Colossus
            [67834] = true, -- Sweep Line 2 -- Flesh Colossus
            [67835] = true, -- Sweep Line 3 -- Flesh Colossus
            [67842] = true, -- Sweep Shockwave -- Flesh Colossus
            [76128] = true, -- Stumble Forward -- Flesh Colossus
            [76139] = true, -- Stumble Forward -- Flesh Colossus
            [76140] = true, -- Stumble Forward -- Flesh Colossus
            [76130] = true, -- Stumble Forward -- Flesh Colossus
            [76131] = true, -- Stumble Forward -- Flesh Colossus
            [76143] = true, -- Stumble Forward -- Flesh Colossus
            [79001] = true, -- Stumble Forward -- Flesh Colossus
            [76145] = true, -- Stumble Forward -- Flesh Colossus
            [76146] = true, -- Stumble Forward -- Flesh Colossus
            [76129] = true, -- Stumble Forward -- Flesh Colossus
            [76134] = true, -- Stumble Forward -- Flesh Colossus
            [65755] = true, -- Staggered -- Flesh Colossus
            [76133] = true, -- Stumble Forward -- Flesh Colossus
            [68826] = true, -- Staggered -- Flesh Colossus
            [67766] = true, -- Ghastly Bellow -- Flesh Colossus
            [67772] = true, -- Enraged -- Flesh Colossus
            [49430] = true, -- Smash -- Flesh Colossus
            [49429] = true, -- Claw -- Flesh Colossus
            --[65744] = true, -- Staggered -- Flesh Colossus

            [17069] = true, -- Ice Spear -- Frost Atronach
            [5009] = true, -- Ice Shards -- Frost Atronach
            [33549] = true, -- Chilling Aura -- Frost Atronach
            [33551] = true, -- Chilling Aura -- Frost Atronach
            [5017] = true, -- Hoarfrost Fist -- Frost Atronach
            [44906] = true, -- Hoarfrost Fist -- Frost Atronach
            [44907] = true, -- Hoarfrost Fist -- Frost Atronach
            [44908] = true, -- Hoarfrost Fist -- Frost Atronach
            [33502] = true, -- Frozen Ground -- Frost Atronach
            [33506] = true, -- Frozen Ground -- Frost Atronach
            [33508] = true, -- Frozen Ground -- Frost Atronach
            [33509] = true, -- Frozen Ground -- Frost Atronach
            [33510] = true, -- Frozen Ground -- Frost Atronach
            [55476] = true, -- Fire Runes -- Frost Atronach
            [51644] = true, -- Fire Runes -- Frost Atronach
            [51645] = true, -- Frozen Ground -- Frost Atronach
            [51646] = true, -- Frozen Ground -- Frost Atronach

            [65926] = true, -- Slash -- Grievous Twilight
            [65845] = true, -- Rend -- Grievous Twilight
            [66643] = true, -- Rend -- Grievous Twilight
            [50596] = true, -- Shadow Bolt -- Grievous Twilight
            [50626] = true, -- Shadow Strike -- Grievous Twilight
            [60792] = true, -- Grevious Root Immune -- Grievous Twilight
            [50628] = true, -- Shadow Strike -- Grievous Twilight
            [50635] = true, -- Shadow Strike -- Grievous Twilight
            [65889] = true, -- Shadow Strike -- Grievous Twilight
            [65893] = true, -- Grevious Root Immune -- Grievous Twilight
            [65891] = true, -- Shadow Strike -- Grievous Twilight
            [65896] = true, -- Shadow Strike -- Grievous Twilight
            [65895] = true, -- Shadow Strike -- Grievous Twilight
            [50609] = true, -- Blend into Shadows -- Grievous Twilight

            [11076] = true, -- Chasten -- Harvester
            [11079] = true, -- Black Winter -- Harvester
            [26006] = true, -- Black Winter -- Harvester
            [26007] = true, -- Black Winter -- Harvester
            [26009] = true, -- Black Winter -- Harvester
            [26008] = true, -- Black Winter -- Harvester
            [74794] = true, -- Staggered -- Harvester
            [11083] = true, -- The Feast -- Harvester
            [26110] = true, -- The Feast -- Harvester
            [26017] = true, -- Creeping Doom -- Harvester
            [26018] = true, -- Creeping Doom -- Harvester
            [88070] = true, -- Creeping Doom -- Harvester
            [26069] = true, -- The Feast Registered Trigger -- Harvester
            [25987] = true, -- The Feast -- Harvester
            [25988] = true, -- The Feast -- Harvester
            [25989] = true, -- The Feast -- Harvester
            [25990] = true, -- The Feast -- Harvester
            [26085] = true, -- The Feast Tick -- Harvester
            [26084] = true, -- The Feast -- Harvester

            [8204] = true, -- Strike -- Ogrim
            [8205] = true, -- Regeneration -- Ogrim
            [70581] = true, -- Regeneration -- Ogrim
            [24689] = true, -- Body Slam -- Ogrim
            [24690] = true, -- Body Slam -- Ogrim
            [48553] = true, -- Focused Charge -- Ogrim
            [24694] = true, -- Body Slam -- Ogrim
            [24691] = true, -- Body Slam -- Ogrim
            [24699] = true, -- Body Slam -- Ogrim
            [24693] = true, -- Body Slam -- Ogrim
            [24700] = true, -- Body Slam -- Ogrim
            [24695] = true, -- Body Slam -- Ogrim
            [73380] = true, -- Been Blocked -- Ogrim
            [24692] = true, -- Body Slam -- Ogrim
            [91848] = true, -- Stomp -- Ogrim
            [91850] = true, -- Stomp -- Ogrim
            [91851] = true, -- Stomp -- Ogrim
            [91855] = true, -- Boulder Toss -- Ogrim
            [91870] = true, -- Boulder Toss -- Ogrim
            [91874] = true, -- Boulder Toss -- Ogrim
            [91871] = true, -- Boulder Toss -- Ogrim

            [6158] = true, -- Flare -- Scamp
            [6166] = true, -- Heat Wave -- Scamp
            [6167] = true, -- Heat Wave -- Scamp
            [6160] = true, -- Rain of Fire -- Scamp
            [6162] = true, -- Rain of Fire -- Scamp

            [8778] = true, -- Strike -- Spider Daedra
            [8808] = true, -- Spit -- Spider Daedra
            [8779] = true, -- Lightning Onslaught -- Spider Daedra
            [91901] = true, -- Lightning Onslaught -- Spider Daedra
            [91903] = true, -- Lightning Onslaught -- Spider Daedra
            [91904] = true, -- Lightning Onslaught -- Spider Daedra
            [38658] = true, -- Lightning Onslaught -- Spider Daedra
            [8782] = true, -- Lightning Storm -- Spider Daedra
            [20530] = true, -- Lightning Storm -- Spider Daedra
            [8773] = true, -- Summon Spiderling -- Spider Daedra
            [89303] = true, -- Summon Spiderling -- Spider Daedra
            [89301] = true, -- Summon Spiderling -- Spider Daedra
            [89302] = true, -- Summon Spiderling -- Spider Daedra
            [89300] = true, -- Summon Spiderling -- Spider Daedra
            [89306] = true, -- Web -- Spider Daedra
            [89307] = true, -- Web -- Spider Daedra

            [4858] = true, -- Bash -- Storm Atronach
            [13898] = true, -- Strike -- Storm Atronach
            [35220] = true, -- Impending Storm -- Storm Atronach
            [35222] = true, -- Impending Storm -- Storm Atronach
            [35228] = true, -- Impending Storm -- Storm Atronach
            [35229] = true, -- Impending Storm -- Storm Atronach
            [35230] = true, -- Impending Storm -- Storm Atronach
            [35231] = true, -- Impending Storm -- Storm Atronach
            [35234] = true, -- Impending Storm -- Storm Atronach
            [35247] = true, -- Impending Storm -- Storm Atronach
            [4864] = true, -- Storm Bound -- Storm Atronach
            [35240] = true, -- Storm Bound -- Storm Atronach
            [12287] = true, -- Storm Bound -- Storm Atronach
            [12288] = true, -- Storm Bound -- Storm Atronach
            [12286] = true, -- Storm Bound -- Storm Atronach

            [7095] = true, -- Heavy Attack -- Xivilai
            [44904] = true, -- Empower Weapon: Frost -- Xivilai
            [83072] = true, -- Frozen Edge -- Xivilai
            [49203] = true, -- Frozen Weapon -- Xivilai
            [88947] = true, -- Lightning Grasp -- Xivilai
            [88952] = true, -- Lightning Grasp -- Xivilai
            [88951] = true, -- Lightning Grasp -- Xivilai
            [88949] = true, -- Lightning Grasp -- Xivilai
            [7100] = true, -- Hand of Flame -- Xivilai
            [25747] = true, -- Hand of Flame -- Xivilai
            [25749] = true, -- Hand of Flame -- Xivilai
            [88968] = true, -- Hand of Flame -- Xivilai
            [88969] = true, -- Hand of Flame -- Xivilai
            [25728] = true, -- Hand of Flame -- Xivilai
            [7101] = true, -- Summon Daedra -- Xivilai
            [88976] = true, -- Summon Daedra -- Xivilai
            [25726] = true, -- Summon Daedra -- Xivilai
            [88974] = true, -- Summon Daedra -- Xivilai
            [88973] = true, -- Summon Daedra -- Xivilai
            [89232] = true, -- Summon Daedra -- Xivilai

            [4652] = true, -- Gaze -- Watcher
            [4653] = true, -- Shockwave -- Watcher
            [43817] = true, -- Shockwave Snare -- Watcher
            [95855] = true, -- Shockwave -- Watcher
            [95856] = true, -- Shockwave -- Watcher
            [53880] = true, -- Shockwave -- Watcher

            [9219] = true, -- Doom-Truth's Gaze -- Watcher
            [95915] = true, -- Doom-Truth's Gaze -- Watcher
            [95916] = true, -- Doom-Truth's Gaze -- Watcher
            [95917] = true, -- Doom-Truth's Gaze -- Watcher
            [95918] = true, -- Doom-Truth's Gaze -- Watcher
            [95890] = true, -- Doom-Truth's Gaze -- Watcher
            [9220] = true, -- Doom-Truth's Gaze -- Watcher
            [14518] = true, -- Doom-Truth's Gaze -- Watcher
            [14425] = true, -- Doom-Truth's Gaze -- Watcher
            [14462] = true, -- Doom-Truth's Gaze -- Watcher
            [14426] = true, -- Doom-Truth's Gaze -- Watcher
            [14546] = true, -- Doom-Truth's Gaze -- Watcher

            [12062] = true, -- Kick -- Winged Twilight
            [13690] = true, -- Kick -- Winged Twilight
            [6410] = true, -- Tail Clip -- Winged Twilight
            [63612] = true, -- Tail Clip -- Winged Twilight
            [6412] = true, -- Dusk's Howl -- Winged Twilight

            -- UNDEAD

            [38828] = true, -- Desecrated Ground -- Desecrated Ground
            [69900] = true, -- Desecrated Ground -- Desecrated Ground
            [69905] = true, -- Desecrated Ground -- Desecrated Ground
            [38829] = true, -- Desecrated Ground Bonus -- Desecrated Ground
            [38832] = true, -- Undead Synergy -- Desecrated Ground
            [38831] = true, -- Desecrated Ground -- Desecrated Ground
            [38834] = true, -- Desecrated Ground Snare -- Desecrated Ground
            [69950] = true, -- Desecrated Ground -- Desecrated Ground

            [25719] = true, -- Check for Vampire Allies -- Bloodfiend
            [8550] = true, -- Slash -- Bloodfiend
            [8551] = true, -- Slash -- Bloodfiend
            [8564] = true, -- Rending Slash -- Bloodfiend
            [8554] = true, -- Flurry -- Bloodfiend
            [9194] = true, -- Flurry -- Bloodfiend
            [8569] = true, -- Devastating Leap -- Bloodfiend
            [32023] = true, -- Generic Stagger Enemy -- Bloodfiend
            [48940] = true, -- Ambush -- Bloodfiend

            [5028] = true, -- Strike -- Bone Colossus
            [5050] = true, -- Bone Saw -- Bone Colossus
            [30590] = true, -- Bone Saw -- Bone Colossus
            [17206] = true, -- Bone Saw -- Bone Colossus
            [5030] = true, -- Voice to Wake the Dead -- Bone Colossus
            [5044] = true, -- Risen Dead -- Bone Colossus
            [88133] = true, -- Voice to Wake the Dead -- Bone Colossus
            [5033] = true, -- Voice to Wake the Dead -- Bone Colossus
            [5035] = true, -- Voice to Wake the Dead -- Bone Colossus
            [5036] = true, -- Voice to Wake the Dead -- Bone Colossus
            [17221] = true, -- Slap -- Bone Colossus
            [17207] = true, -- Necromantic Implosion -- Bone Colossus
            [88828] = true, -- Necromantic Implosion -- Bone Colossus
            [89533] = true, -- Necromantic Implosion -- Bone Colossus
            [49128] = true, -- Necromantic Implosion -- Bone Colossus
            [88132] = true, -- Voice to Wake the Dead -- Bone Colossus

            --[72980] = true, -- Singing Strike -- Defiled Aegis
            --[72981] = true, -- Singing Slice -- Defiled Aegis
            --[72979] = true, -- Dissonant Blow -- Defiled Aegis
            --[72995] = true, -- Symphony of Blades -- Defiled Aegis
            --[72996] = true, -- Symphony of Blades -- Defiled Aegis
            --[77612] = true, -- Symphony of Blades -- Defiled Aegis

            --[73020] = true, -- Shattered Harmony -- Defiled Aegis
            --[76180] = true, -- Shattered Harmony -- Defiled Aegis
            --[73021] = true, -- Shattered Harmony -- Defiled Aegis
            --[73025] = true, -- Tomb Guardian -- Defiled Aegis
            --[73322] = true, -- Shattered Harmony -- Defiled Aegis
            --[74993] = true, -- Shattered Harmony -- Defiled Aegis

            [8812] = true, -- Double Strike -- Ghost
            [8813] = true, -- Double Strike -- Ghost
            [18514] = true, -- Chill Touch -- Ghost
            [18515] = true, -- Chill Touch -- Ghost
            [18766] = true, -- Haunting Spectre -- Ghost
            [19137] = true, -- Haunting Spectre -- Ghost
            [19138] = true, -- Haunting Spectre -- Ghost
            [19140] = true, -- Haunting Spectre -- Ghost

            [9541] = true, -- Necrotic Spear -- Lich
            [20756] = true, -- Defiled Ground -- Lich
            [22521] = true, -- Defiled Ground -- Lich
            [22523] = true, -- Defiled Ground -- Lich
            [20812] = true, -- Defiled Ground -- Lich
            [22525] = true, -- Defiled Ground -- Lich
            [73925] = true, -- Soul Cage -- Lich
            [22602] = true, -- Soul Cage -- Lich
            [73927] = true, -- Soul Cage -- Lich
            [73928] = true, -- Soul Cage -- Lich
            [73930] = true, -- Soul Cage -- Lich
            [73932] = true, -- Soul Cage -- Lich
            [73933] = true, -- Soul Cage -- Lich
            [73938] = true, -- Soul Cage -- Lich
            [73936] = true, -- Soul Cage -- Lich
            [73935] = true, -- Soul Cage -- Lich
            [73929] = true, -- Soul Cage -- Lich
            [73931] = true, -- Soul Rupture -- Lich
            [73926] = true, -- Soul Cage -- Lich
            [73937] = true, -- Soul Cage -- Lich
            [73939] = true, -- Soul Rupture -- Lich
            [73934] = true, -- Soul Cage -- Lich

            [49702] = true, -- Entropic Flare -- Spellfiend
            [50456] = true, -- Entropic Flare -- Spellfiend
            [50182] = true, -- Consuming Energy -- Spellfiend
            [50183] = true, -- Consuming Energy -- Spellfiend
            [52398] = true, -- Consuming Energy -- Spellfiend

            --[68735] = true, -- Vampiric Drain -- Vampire
            --[68750] = true, -- Vampiric Drain -- Vampire
            --[68765] = true, -- Vampiric Drain -- Vampire
            --[68771] = true, -- Vampiric Drain Heal Dummy -- Vampire
            --[68772] = true, -- Vampiric Drain -- Vampire

            --[2849] = true, -- Claw Slash -- Werewolf
            --[4651] = true, -- Claw Slash -- Werewolf
            --[2850] = true, -- Swipe -- Werewolf
            --[2867] = true, -- Crushing Leap -- Werewolf
            --[45576] = true, -- Generic Stagger Enemy -- Werewolf
            --[3415] = true, -- Flurry -- Werewolf
            --[13950] = true, -- Flurry -- Werewolf
            --[9467] = true, -- Flurry -- Werewolf
            --[60636] = true, -- Flurry -- Werewolf
            --[60637] = true, -- Flurry -- Werewolf
            --[60638] = true, -- Flurry -- Werewolf
            --[60639] = true, -- Flurry -- Werewolf
            --[60640] = true, -- Flurry -- Werewolf
            --[44055] = true, -- Devour -- Werewolf
            --[44054] = true, -- Devour -- Werewolf
            --[5785] = true, -- Blood Scent -- Werewolf
            --[58529] = true, -- Blood Scent -- Werewolf
            --[27329] = true, -- Houndsman Transform -- Werewolf
            --[27344] = true, -- Houndsman Regen -- Werewolf
            --[27345] = true, -- Houndsman Stun -- Werewolf
            --[27362] = true, -- Houndsman Delay -- Werewolf
            --[27365] = true, -- MT Houndsman Removal -- Werewolf
            --[27382] = true, -- MT Houndsman -- Werewolf

            [4323] = true, -- Ice Bolt -- Wraith
            [4337] = true, -- Winter's Reach -- Wraith
            [4346] = true, -- Winter's Reach -- Wraith
            [43146] = true, -- Winter's Reach -- Wraith

            [2954] = true, -- Swipe -- Zombie
            [13972] = true, -- Swipe -- Zombie
            [63614] = true, -- Swipe -- Zombie
            [2969] = true, -- Pound -- Zombie
            [2960] = true, -- Vomit -- Zombie
            [30347] = true, -- Vomit -- Zombie

            -- DWEMER

            [20238] = true, -- Charge -- Synergy (Dwemer Spider)
            [19970] = true, -- Static Field -- Synergy (Dwemer Spider)
            [19997] = true, -- Static Field -- Synergy (Dwemer Spider)
            [20506] = true, -- Overcharge Trigger -- Synergy (Dwemer Spider)
            [27333] = true, -- Overcharge -- Synergy (Dwemer Spider)
            [20207] = true, -- Overcharge -- Synergy (Another Dwemer)
            [27458] = true, -- tell others -- Synergy (Another Dwemer)
            [20206] = true, -- Overcharge -- Synergy (Another Dwemer)
            [20221] = true, -- Overcharge -- Synergy (Another Dwemer)
            [20505] = true, -- Overcharge -- Synergy (Dwemer Spider - Source)
            [20222] = true, -- Overcharge -- Synergy (Another Dwemer)
            [20504] = true, -- Overcharge -- Synergy (Dwemer Spider - Source)
            [20220] = true, -- Overcharge -- Synergy (Dwemer Spider - Other)
            [52679] = true, -- Overcharge -- Synergy (Dwemer Sphere)
            [52680] = true, -- Overcharge -- Synergy (Dwemer Centurion)

            [11245] = true, -- Axe -- Dwemer Centurion
            [13783] = true, -- Hammer -- Dwemer Centurion
            [11247] = true, -- Sweeping Spin -- Dwemer Centurion
            [43554] = true, -- Sweeping Spin -- Dwemer Centurion
            [11262] = true, -- Sweeping Spin -- Dwemer Centurion
            [11246] = true, -- Steam Breath -- Dwemer Centurion
            [11282] = true, -- Steam Breath -- Dwemer Centurion

            [64423] = true, -- Sparks -- Dwemer Sentry
            [64463] = true, -- Static Shield -- Dwemer Sentry
            [84312] = true, -- Static Shield -- Dwemer Sentry
            [70133] = true, -- Static Shield -- Dwemer Sentry
            [64556] = true, -- Static Eruption -- Dwemer Sentry
            [64489] = true, -- Find Turret -- Dwemer Sentry
            [64508] = true, -- Find Turret -- Dwemer Sentry
            [64460] = true, -- Static Shield -- Dwemer Sentry
            [64479] = true, -- Thunderbolt -- Dwemer Sentry
            [64543] = true, -- Thunderbolt -- Dwemer Sentry
            [70134] = true, -- Static Shield -- Dwemer Sentry
            [68790] = true, -- Static Shield Explosion -- Dwemer Sentry

            [7484] = true, -- Blade -- Dwemer Sphere
            [7485] = true, -- Dart -- Dwemer Sphere
            [16031] = true, -- Ricochet Wave -- Dwemer Sphere
            [29832] = true, -- Ricochet Wave -- Dwemer Sphere
            [7520] = true, -- Steam Wall -- Dwemer Sphere
            [84216] = true, -- Steam Wall -- Dwemer Sphere
            [7544] = true, -- Quake -- Dwemer Sphere
            [46053] = true, -- Quake -- Dwemer Sphere

            [7719] = true, -- Shocking Touch -- Dwemer Spider
            [20507] = true, -- Double Strike -- Dwemer Spider
            [20508] = true, -- Double Strike -- Dwemer Spider
            [7717] = true, -- Detonation -- Dwemer Spider
            [15206] = true, -- Detonation -- Dwemer Spider
            [84019] = true, -- Detonation -- Dwemer Spider
            [13536] = true, -- Detonation -- Dwemer Spider

            -- INSECTS

            [5278] = true, -- Bite -- Assassin Beetle
            [6137] = true, -- Laceration -- Assassin Beetle
            [51736] = true, -- Bleeding -- Assassin Beetle
            [51735] = true, -- Bleeding -- Assassin Beetle
            [44198] = true, -- Ambush -- Assassin Beetle
            [5268] = true, -- Collywobbles -- Assassin Beetle
            [5273] = true, -- Collywobbles -- Assassin Beetle
            [13677] = true, -- Acid Blood -- Assassin Beetle
            [13681] = true, -- Acid Blood -- Assassin Beetle
            [13680] = true, -- Acid Blood -- Assassin Beetle
            [29822] = true, -- Shadow Step -- Assassin Beetle
            [91789] = true, -- Ambush -- Assassin Beetle
            [91791] = true, -- Feast -- Assassin Beetle

            [6754] = true, -- Pincer -- Giant Scorpion
            [6755] = true, -- Sting -- Giant Scorpion
            [13671] = true, -- Sting -- Giant Scorpion
            [6757] = true, -- Blurred Strike -- Giant Scorpion
            [9040] = true, -- Blurred Strike -- Giant Scorpion
            [6756] = true, -- Paralyze -- Giant Scorpion
            [12312] = true, -- Snare -- Giant Scorpion
            [6758] = true, -- Hardened Carapace -- Giant Scorpion

            [4731] = true, -- Bite -- Giant Spider
            [44086] = true, -- Fire Runes -- Giant Spider
            [5790] = true, -- Poisonous Burst -- Giant Spider
            [5685] = true, -- Corrosive Bite -- Giant Spider
            [8087] = true, -- Poison Spray -- Giant Spider
            [8088] = true, -- Poison Spray -- Giant Spider
            [4730] = true, -- Spit -- Giant Spider
            [4737] = true, -- Encase -- Giant Spider
            [47318] = true, -- Encase -- Giant Spider
            [13382] = true, -- Devour -- Giant Spider
            [20541] = true, -- Devour -- Giant Spider
            [13381] = true, -- Devour -- Giant Spider

            [9225] = true, -- Bite -- Giant Wasp
            [9226] = true, -- Sting -- Giant Wasp
            [25103] = true, -- Charge -- Giant Wasp
            [25110] = true, -- Charge -- Giant Wasp
            [48559] = true, -- Focused Charge -- Giant Wasp
            [25114] = true, -- Focused Charge -- Giant Wasp
            [25119] = true, -- Charge -- Giant Wasp
            [25116] = true, -- Charge -- Giant Wasp
            [25113] = true, -- Charge -- Giant Wasp
            [25120] = true, -- Charge -- Giant Wasp
            [25115] = true, -- Charge -- Giant Wasp
            [25111] = true, -- Charge -- Giant Wasp
            [25112] = true, -- Charge -- Giant Wasp
            [9229] = true, -- Inject Larva -- Giant Wasp
            [9237] = true, -- Larva Gestation -- Giant Wasp
            [54685] = true, -- Young Wasp Initialize -- Giant Wasp
            [9238] = true, -- Larva Burst -- Giant Wasp
            [9242] = true, -- Larva Burst -- Giant Wasp
            [10392] = true, -- Larva Burst -- Giant Wasp

            [6788] = true, -- Bite -- Hoarvor
            [6800] = true, -- Bloodletting -- Hoarvor
            [42292] = true, -- Bloodletting -- Hoarvor
            [6795] = true, -- Latch On -- Hoarvor
            [13585] = true, -- Latch On -- Hoarvor
            [13587] = true, -- Latch On -- Hoarvor

            [61248] = true, -- Necrotic Explosion -- Necrotic Hoarvor
            [61243] = true, -- Vile Bite -- Necrotic Hoarvor
            [69392] = true, -- Vile Bite Poison -- Necrotic Hoarvor
            [61244] = true, -- Fevered Retch -- Necrotic Hoarvor
            [61245] = true, -- Fevered Retch -- Necrotic Hoarvor
            [61360] = true, -- Infectious Swarm -- Necrotic Hoarvor
            [61380] = true, -- Infectious Swarm -- Necrotic Hoarvor
            [61377] = true, -- Infectious Swarm -- Necrotic Hoarvor
            [61372] = true, -- Infectious Swarm -- Necrotic Hoarvor
            [61374] = true, -- Infectious Swarm -- Necrotic Hoarvor
            [61375] = true, -- Infectious Swarm -- Necrotic Hoarvor
            [61376] = true, -- Infectious Swarm -- Necrotic Hoarvor
            [61427] = true, -- Necrotic Explosion -- Necrotic Hoarvor
            [61249] = true, -- Necrotic Explosion -- Necrotic Hoarvor
            [61388] = true, -- Necrotic Explosion Snare -- Necrotic Hoarvor

            [73166] = true, -- Bite -- Kotu Gava
            [73214] = true, -- Bite -- Kotu Gava
            [73215] = true, -- Bite -- Kotu Gava

            [73192] = true, -- Swarmburst -- Kotu Gava Broodmother
            [73184] = true, -- Vile Spit -- Kotu Gava Broodmother
            [73172] = true, -- Swarm -- Kotu Gava Broodmother
            [73173] = true, -- Swarm -- Kotu Gava Broodmother
            [73193] = true, -- Swarm -- Kotu Gava Broodmother
            [73177] = true, -- Swarmburst -- Kotu Gava Broodmother
            [73174] = true, -- Swarm -- Kotu Gava Broodmother
            [73176] = true, -- Swarm -- Kotu Gava Broodmother
            [73175] = true, -- Swarm -- Kotu Gava Broodmother
            [76579] = true, -- Bite -- Kotu Gava Broodmother
            [76580] = true, -- Bite -- Kotu Gava Broodmother
            [76581] = true, -- Bite -- Kotu Gava Broodmother
            [73199] = true, -- Swarmburst -- Kotu Gava Broodmother
            [73200] = true, -- Swarmburst -- Kotu Gava Broodmother
            [73194] = true, -- Swarmburst -- Kotu Gava Broodmother
            [73198] = true, -- Swarmburst -- Kotu Gava Broodmother
            [73195] = true, -- Swarmburst -- Kotu Gava Broodmother
            [73196] = true, -- Swarmburst -- Kotu Gava Broodmother
            [73197] = true, -- Swarmburst -- Kotu Gava Broodmother

            [8276] = true, -- Bite -- Kwama Scrib
            [83977] = true, -- Bite -- Kwama Scrib
            [8272] = true, -- Spit -- Kwama Scrib
            [47838] = true, -- Contagion -- Kwama Scrib
            [10916] = true, -- Burrow -- Kwama Scrib
            [42869] = true, -- Burrow -- Kwama Scrib

            [9287] = true, -- Bite -- Kwama Worker
            [9291] = true, -- Pounce -- Kwama Worker
            [83953] = true, -- Pounce -- Kwama Worker
            [14839] = true, -- Charge -- Kwama Worker
            [14841] = true, -- Charge -- Kwama Worker
            [48539] = true, -- Focused Charge -- Kwama Worker
            [14846] = true, -- Focused Charge -- Kwama Worker
            [18808] = true, -- Charge -- Kwama Worker
            [18810] = true, -- Charge -- Kwama Worker
            [14844] = true, -- Charge -- Kwama Worker
            [14845] = true, -- Charge -- Kwama Worker
            [18814] = true, -- Charge -- Kwama Worker
            [48540] = true, -- Charge -- Kwama Worker
            [18548] = true, -- Charge -- Kwama Worker
            [18546] = true, -- Shattered Ground -- Kwama Worker

            [15011] = true, -- Swipe -- Kwama Warrior
            [9763] = true, -- Smash -- Kwama Warrior
            [9764] = true, -- Smash -- Kwama Warrior
            [9769] = true, -- Excavation -- Kwama Warrior
            [18585] = true, -- Excavation -- Kwama Warrior
            [27463] = true, -- Excavation -- Kwama Warrior
            [49192] = true, -- Excavation -- Kwama Warrior
            [18567] = true, -- Excavation -- Kwama Warrior
            [18568] = true, -- Kwama Scrib Swarm -- Kwama Warrior

            [6127] = true, -- Bite -- Shalk
            [5260] = true, -- Flamethrower -- Shalk
            [10947] = true, -- Fiery Breath -- Shalk
            [5252] = true, -- Fire Bite -- Shalk
            [6129] = true, -- Fire Bite -- Shalk
            [5262] = true, -- Burning Ground -- Shalk
            [5265] = true, -- Burning Ground -- Shalk

            [5308] = true, -- Thunder Bite -- Thunderbug
            [8429] = true, -- Zap -- Thunderbug
            [65079] = true, -- Zap -- Thunderbug
            [26379] = true, -- Zap -- Thunderbug
            [26382] = true, -- Bolt -- Thunderbug
            [26412] = true, -- Thunderstrikes -- Thunderbug
            [34980] = true, -- Thunderstrikes -- Thunderbug

            -- MONSTER
            [10259] = true, -- Double Swipe -- Gargoyle
            [32672] = true, -- Double Swipe -- Gargoyle
            [10270] = true, -- Quake -- Gargoyle
            [10271] = true, -- Quake -- Gargoyle
            [10256] = true, -- Lacerate -- Gargoyle
            [25716] = true, -- Stun -- Gargoyle
            [25718] = true, -- Bleeding -- Gargoyle
            [25714] = true, -- Vampiric Touch -- Gargoyle
            [25715] = true, -- Vampiric Touch -- Gargoyle

            [8671] = true, -- Sweep -- Giant
            [46845] = true, -- Sweep -- Giant
            [8674] = true, -- Kick -- Giant
            [26124] = true, -- Shatter -- Giant
            [26129] = true, -- Shatter -- Giant
            [15715] = true, -- Obliterate -- Giant
            [43743] = true, -- Obliterate -- Giant
            [43742] = true, -- Obliterate -- Giant

            [2901] = true, -- Staff Strike -- Hag
            [2786] = true, -- Steal Essence -- Hag
            [21642] = true, -- Steal Essence -- Hag
            [3349] = true, -- Reflective Shadows -- Hag
            [2821] = true, -- Luring Snare -- Hag
            [32267] = true, -- Grapple -- Hag
            [32268] = true, -- Grapple -- Hag

            [10611] = true, -- Flare -- Hagraven
            [10615] = true, -- Raven Storm -- Hagraven
            [10616] = true, -- Raven Storm -- Hagraven
            [12426] = true, -- Raven Storm -- Hagraven
            [10613] = true, -- Fire Bomb -- Hagraven
            [10614] = true, -- Fire Bomb -- Hagraven
            [58220] = true, -- Surround -- Hagraven
            [58221] = true, -- Shadow Strike -- Hagraven
            [58222] = true, -- Shadow Strike -- Hagraven
            [64781] = true, -- Briar Heart Can Resurrect -- Hagraven
            [64786] = true, -- Briar Heart Resurrection -- Hagraven
            [64806] = true, -- Briarheart Resurrection -- Hagraven
            [64800] = true, -- Briarheart Resurrection -- Hagraven
            [64808] = true, -- Briarheart Resurrection -- Hagraven
            [65027] = true, -- Briarheart Resurrection -- Hagraven
            [65028] = true, -- System Shock -- Hagraven

            [4112] = true, -- Talon -- Harpy
            [4125] = true, -- Kick -- Harpy
            [24551] = true, -- Bolt -- Harpy
            [4684] = true, -- Bolt -- Harpy
            [4123] = true, -- Wing Slice -- Harpy
            [24369] = true, -- Wing Slice -- Harpy
            [13515] = true, -- Wind Gust -- Harpy
            [13516] = true, -- Wind Gust -- Harpy
            [13517] = true, -- Wind Gust -- Harpy
            [24604] = true, -- Charged Ground -- Harpy
            [8628] = true, -- Charged Ground -- Harpy
            [13523] = true, -- Charged Ground -- Harpy
            [4689] = true, -- Lightning Gale -- Harpy
            [4690] = true, -- Lightning Gale -- Harpy
            [4139] = true, -- Soar -- Harpy

            [9846] = true, -- Bite -- Ice Wraith
            [24929] = true, -- Shard Burst -- Ice Wraith
            [43809] = true, -- Shard Burst -- Ice Wraith
            [9853] = true, -- Shard Burst -- Ice Wraith
            [43810] = true, -- Shard Burst -- Ice Wraith
            [38920] = true, -- Shard Burst -- Ice Wraith
            [24877] = true, -- Shard Burst -- Ice Wraith
            [24865] = true, -- Blood in the Water -- Ice Wraith
            [24866] = true, -- Blood in the Water -- Ice Wraith
            [48549] = true, -- Focused Charge -- Ice Wraith
            [24870] = true, -- Blood in the Water -- Ice Wraith
            [24872] = true, -- Blood in the Water -- Ice Wraith
            [24869] = true, -- Blood in the Water -- Ice Wraith
            [46565] = true, -- Rubble -- Ice Wraith
            [46563] = true, -- Blood in the Water -- Ice Wraith

            [14801] = true, -- Flare -- Imp (Fire)
            [14802] = true, -- Fireball -- Imp (Fire)
            [17703] = true, -- Flame Ray -- Imp (Fire)
            [65078] = true, -- Flame Ray -- Imp (Fire)
            [17706] = true, -- Flame Ray -- Imp (Fire)

            [7732] = true, -- Bolt -- Imp (Lightning)
            [13648] = true, -- Spark -- Imp (Lightning)
            [8884] = true, -- Zap -- Imp (Lightning)
            [65077] = true, -- Zap -- Imp (Lightning)
            [14666] = true, -- Zap -- Imp (Lightning)

            [9670] = true, -- Strike -- Lamia
            [9671] = true, -- Howling Strike -- Lamia
            [89382] = true, -- Howling Strike -- Lamia
            [7830] = true, -- Shockwave -- Lamia Medica
            [9677] = true, -- Summon Spectral Lamia -- Lamia Medica
            [12074] = true, -- Summon Spectral Lamia -- Lamia Medica
            [9680] = true, -- Summon Spectral Lamia -- Lamia Medica
            [89399] = true, -- Summon Spectral Lamia -- Lamia Medica
            [89398] = true, -- Summon Spectral Lamia -- Lamia Medica
            [89400] = true, -- Summon Spectral Lamia -- Lamia Medica
            [7853] = true, -- Convalescence -- Lamia Medica
            [24745] = true, -- Harmony -- Lamia
            [7831] = true, -- Harmony -- Lamia
            [23358] = true, -- Harmony -- Lamia
            [24814] = true, -- Harmony -- Lamia
            [24817] = true, -- Harmony -- Lamia

            [3757] = true, -- Claw -- Lurcher
            [3860] = true, -- Pulverize -- Lurcher
            [32698] = true, -- Pulverize -- Lurcher
            [3855] = true, -- Crushing Limbs -- Lurcher
            [38554] = true, -- Stun -- Lurcher
            [3767] = true, -- Choking Pollen -- Lurcher
            [4769] = true, -- Choking Pollen -- Lurcher

            [75863] = true, -- Cleave -- Minotaur
            [75864] = true, -- Cleave -- Minotaur
            [75865] = true, -- Cleave -- Minotaur
            [75867] = true, -- Clobber -- Minotaur
            [80440] = true, -- Clobber -- Minotaur
            [80014] = true, -- Clobber -- Minotaur
            [75868] = true, -- Clobber -- Minotaur
            [75917] = true, -- Ram -- Minotaur
            [75920] = true, -- Ram -- Minotaur
            [75921] = true, -- Ram -- Minotaur
            [75919] = true, -- Ram -- Minotaur
            [75922] = true, -- Ram -- Minotaur
            [75872] = true, -- Flying Axe -- Minotaur
            [79541] = true, -- Flying Leap -- Minotaur
            [79539] = true, -- Flying Leap -- Minotaur
            [75925] = true, -- Elemental Weapon -- Minotaur
            [75928] = true, -- Elemental Pool -- Minotaur
            [75933] = true, -- Elemental Wave -- Minotaur

            [75949] = true, -- Fiery Surge -- Minotaur Shaman
            [77989] = true, -- Flame Wave -- Minotaur Shaman
            [75951] = true, -- Brimstone Hailfire -- Minotaur Shaman
            [75952] = true, -- Brimstone Hailfire -- Minotaur Shaman
            [75953] = true, -- Brimstone Hailfire -- Minotaur Shaman
            [75954] = true, -- Brimstone Hailfire -- Minotaur Shaman
            [75955] = true, -- Pillars of Nirn -- Minotaur Shaman
            [81577] = true, -- Pillars of Nirn -- Minotaur Shaman
            [75957] = true, -- Pillars of Nirn -- Minotaur Shaman
            [75980] = true, -- Pillar Eruption -- Minotaur Shaman
            [75976] = true, -- Pillar of Nirn -- Minotaur Shaman
            [81578] = true, -- Pillar of Nirn -- Minotaur Shaman
            [75978] = true, -- Pillar Explosion -- Minotaur Shaman

            [5520] = true, -- Frost Bolt -- Nereid
            [5559] = true, -- Icy Geyser -- Nereid
            [11024] = true, -- Icy Geyser -- Nereid
            [5540] = true, -- Hurricane -- Nereid
            [16040] = true, -- Hurricane -- Nereid
            [33459] = true, -- Hurricane -- Nereid

            [5254] = true, -- Punch -- Ogre
            [5257] = true, -- Backhand -- Ogre
            [5256] = true, -- Shockwave -- Ogre
            [34616] = true, -- Shockwave -- Ogre
            [6150] = true, -- Off Balance -- Ogre
            [5349] = true, -- Stagger -- Ogre
            [8069] = true, -- Intimidating Roar -- Ogre
            [24985] = true, -- Intimidating Roar -- Ogre
            [5881] = true, -- Smash -- Ogre
            [24948] = true, -- Smash -- Ogre
            [34627] = true, -- Smash -- Ogre
            [24949] = true, -- Smash -- Ogre
            [34614] = true, -- Smash -- Ogre

            [53136] = true, -- Frost Bolt -- Ogre Shaman
            [65434] = true, -- Frost Bolt -- Ogre Shaman
            [53773] = true, -- Frost Bolt -- Ogre Shaman
            [53774] = true, -- Frost Bolt -- Ogre Shaman
            [65469] = true, -- Frost Bolt -- Ogre Shaman
            [65470] = true, -- Frost Bolt -- Ogre Shaman
            --[82685] = true, -- CC (Crown Control) Shared Cool -- Ogre Shaman
            [53142] = true, -- Ice Pillar -- Ogre Shaman
            [54414] = true, -- Ice Pillar Initialize -- Ogre Shaman
            [34385] = true, -- Generic AOE -- Ogre Shaman
            [53145] = true, -- Ice Pillar Chill -- Ogre Shaman
            [53966] = true, -- Ice Pillar Chill -- Ogre Shaman
            [54256] = true, -- Ice Pillar Chill -- Ogre Shaman
            [54327] = true, -- Winter's Reach -- Ogre Shaman
            [74457] = true, -- Ice Pillar -- Ogre Shaman
            -- [82687] = true, -- S (Support) Shared Cool -- Ogre Shaman
            [64540] = true, -- Freeze Wounds -- Ogre Shaman
            [72069] = true, -- Freeze Wounds -- Ogre Shaman
            [70592] = true, -- Freeze Wounds -- Ogre Shaman
            [53137] = true, -- Freeze Wounds -- Ogre Shaman
            [72068] = true, -- Freeze Wounds -- Ogre Shaman
            [70591] = true, -- Freeze Wounds -- Ogre Shaman


            [2986] = true, -- Lacerate -- Spriggan
            [21582] = true, -- Nature's Swarm -- Spriggan
            [31699] = true, -- Nature's Swarm -- Spriggan
            [13475] = true, -- Healing Salve -- Spriggan
            [89083] = true, -- Healing Salve -- Spriggan
            [89084] = true, -- Healing Salve -- Spriggan
            [89085] = true, -- Healing Salve -- Spriggan
            [89099] = true, -- Summon Beast -- Spriggan
            [89143] = true, -- Summon Beast -- Spriggan
            [89119] = true, -- Summon Beast -- Spriggan
            [89127] = true, -- Summon Beast -- Spriggan
            [21570] = true, -- Backstep -- Spriggan
            [13477] = true, -- Control Beast -- Spriggan
            [89126] = true, -- Summon Beast -- Spriggan
            [89229] = true, -- Summon Beast -- Spriggan

            [42793] = true, -- Strangler: -- Strangler
            [42794] = true, -- Strangler: -- Strangler
            [9320] = true, -- Strike -- Strangler
            [14219] = true, -- Spit -- Strangler
            [9346] = true, -- Strangle -- Strangler
            [42211] = true, -- Strangle -- Strangler
            [9323] = true, -- Poisoned Ground -- Strangler
            [9321] = true, -- Grapple -- Strangler
            [9707] = true, -- Grapple -- Strangler
            [14221] = true, -- Grapple -- Strangler
            [64132] = true, -- Grapple Immunity -- Strangler

            [8926] = true, -- Regeneration -- Troll
            [61225] = true, -- Regeneration -- Troll
            [8925] = true, -- Slap -- Troll
            [44736] = true, -- Swinging Cleave -- Troll
            [44737] = true, -- Swinging Cleave -- Troll
            [9009] = true, -- Tremor -- Troll
            [9011] = true, -- Tremor -- Troll

            [48253] = true, -- Rock Toss -- Troll (Ranged)
            [60549] = true, -- Rock Toss -- Troll (Ranged)
            [48256] = true, -- Boulder Toss -- Troll (Ranged)
            [58655] = true, -- Turn -- Troll (Ranged)
            [48257] = true, -- Boulder Toss -- Troll (Ranged)
            [50387] = true, -- Boulder Toss -- Troll (Ranged)
            [48282] = true, -- Consuming Omen -- Troll (Ranged)
            [48287] = true, -- Consuming Omen -- Troll (Ranged)
            [48294] = true, -- Consuming Omen -- Troll (Ranged)
            [48297] = true, -- Consuming Omen -- Troll (Ranged)
            [48286] = true, -- Consuming Omen -- Troll (Ranged)
            [48288] = true, -- Consuming Omen -- Troll (Ranged)

            [76266] = true, -- Rip -- River Troll (DB DLC)
            [76268] = true, -- Lope -- River Troll (DB DLC)
            [76271] = true, -- Lope -- River Troll (DB DLC)
            [78834] = true, -- Lope -- River Troll (DB DLC)
            [76274] = true, -- Lope -- River Troll (DB DLC)

            [76295] = true, -- Crab Toss -- River Troll (DB DLC)
            [80506] = true, -- Crab Toss -- River Troll (DB DLC)
            [76297] = true, -- Crab Toss -- River Troll (DB DLC)
            [76302] = true, -- SW Spawn Stun -- River Troll (DB DLC)
            [76298] = true, -- Crab Toss -- River Troll (DB DLC)
            [81045] = true, -- Crab Toss -- River Troll (DB DLC)
            [76300] = true, -- Scuttle -- River Troll (DB DLC)
            [76277] = true, -- Close Wounds -- River Troll (DB DLC)
            [76278] = true, -- Close Wounds -- River Troll (DB DLC)
            [78314] = true, -- Close Wounds -- River Troll (DB DLC)

            [4304] = true, -- Assault -- Wisp
            [18634] = true, -- Assault -- Wisp
            [4309] = true, -- Dying Blast -- Wisp
            [64221] = true, -- Dying Blast -- Wisp

            [6596] = true, -- Summon Wisp -- Wispmother
            [64211] = true, -- Summon Wisp -- Wispmother
            [7976] = true, -- Rain of Wisps -- Wispmother
            [8025] = true, -- Rain of Wisps -- Wispmother
            [19043] = true, -- Rain of Wisps -- Wispmother
            [19050] = true, -- Rain of Wisps -- Wispmother
            [19056] = true, -- Rain of Wisps -- Wispmother
            [61204] = true, -- Rain of Wisps -- Wispmother
            [19061] = true, -- Rain of Wisps -- Wispmother
            [18040] = true, -- Clone -- Wispmother
            [18049] = true, -- Clone -- Wispmother
            [18060] = true, -- Clone -- Wispmother
            [18069] = true, -- Wispmother Surround Clone 1 -- Wispmother
            [18073] = true, -- Wispmother Surround Clone 2 -- Wispmother
            [18066] = true, -- Wispmother Surround -- Wispmother
            [19069] = true, -- Rain of Wisps -- Wispmother

            ---------------------------------
            -- MORROWIND DLC NPCS
            ---------------------------------

            [85199] = true, -- Scythe
            [85200] = true, -- Scythe
            [85197] = true, -- Snap
            [85198] = true, -- Snap
            [85201] = true, -- Bite
            [85202] = true, -- Gore
            [85084] = true, -- Shriek
            [85085] = true, -- Shriek

            [90765] = true, -- Acid Spray
            [90776] = true, -- Acid Spray
            [90777] = true, -- Acid Spray
            [90779] = true, -- Acid Spray
            [90781] = true, -- Acid Spray
            [90790] = true, -- Acid Spray
            [90780] = true, -- Acid Spray
            [90778] = true, -- Acid Pool
            [90809] = true, -- Acid Spray
            [90811] = true, -- Acid Spray
            [90810] = true, -- Acid Spray
            [90814] = true, -- Acid Spray
            [90813] = true, -- Acid Spray
            [90816] = true, -- Acid Spray
            [90812] = true, -- Acid Spray
            [90815] = true, -- Acid Pool
            [85172] = true, -- Winnow
            [94846] = true, -- Winnow
            [85175] = true, -- Winnow
            [85186] = true, -- Winnow
            [85173] = true, -- Winnow
            [85203] = true, -- Nix-Call
            [95389] = true, -- Nix-Call
            [90187] = true, -- Nix-Call
            [90190] = true, -- Nix-Call
            [89940] = true, -- Turret

            [93597] = true, -- Achievement (Cliff Strider)
            [85387] = true, -- Snap (Cliff Strider)
            [85388] = true, -- Stab (Cliff Strider)
            [93516] = true, -- Tail Lash (Cliff Strider)
            [85395] = true, -- Dive (Cliff Strider)
            [92129] = true, -- Dive (Cliff Strider)
            [92085] = true, -- Dive (Cliff Strider)
            [85398] = true, -- Dive (Cliff Strider)
            [90319] = true, -- Dive (Cliff Strider)
            [90320] = true, -- Dive (Cliff Strider)
            [85399] = true, -- Retch (Cliff Strider)
            [85420] = true, -- Retch (Cliff Strider)
            [85421] = true, -- Retch (Cliff Strider)
            [85436] = true, -- Frenzied Feast (Cliff Strider)
            [85448] = true, -- Frenzied Feast (Cliff Strider)
            [85390] = true, -- Slash (Cliff Strider Matriarch)
            [85391] = true, -- Slash (Cliff Strider Matriarch)
            [85394] = true, -- Slash (Cliff Strider Matriarch)
            [85392] = true, -- Slash (Cliff Strider Matriarch)
            [85393] = true, -- Slash (Cliff Strider Matriarch)

            [87022] = true, -- Summon Swarm
            [92017] = true, -- Summon Swarm
            [86561] = true, -- Snare
            [85645] = true, -- Bombard
            [85646] = true, -- Bomb
            [85522] = true, -- Ashen Wind
            [85524] = true, -- Ashen wind
            [85525] = true, -- Ashen Wind
            [85526] = true, -- Ashen Cloud
            [87125] = true, -- Heat Vents
            [87126] = true, -- Heat Vents
            [92018] = true, -- Summon Swarm

            [92083] = true, -- Slam
            [87062] = true, -- Fetcherfly Storm
            [87071] = true, -- Fetcherfly Storm
            [87072] = true, -- Fetcherfly Storm
            [87073] = true, -- Fetcherfly Storm
            [92075] = true, -- Fetcherfly Storm
            [87087] = true, -- Fetcherfly Storm
            [87095] = true, -- Colonize
            [92078] = true, -- Colonize
            [92079] = true, -- Colonize
            [92077] = true, -- Colonize
            [92081] = true, -- Colonize
            [87030] = true, -- Focused Swarm
            [87031] = true, -- Focused Swarm

            [85242] = true, -- Quick Shot
            [85255] = true, -- Shock Blast
            [88668] = true, -- Impulse Mine
            [88730] = true, -- Impulse Mine
            [88728] = true, -- Impluse Mine
            [85270] = true, -- Shock Barrage
            [85288] = true, -- Shock Barrage
            [91013] = true, -- Shock Barrage
            [85319] = true, -- Siege Ballista
            [91093] = true, -- Split Bolt
            [91094] = true, -- Split Bolt
            [91095] = true, -- Split Bolt
            [91096] = true, -- Split Bolt
            [91087] = true, -- Split Bolt
            [91092] = true, -- Split Bolt
            [85326] = true, -- Polarizing Field
            [85327] = true, -- Polarizing Field
            [85334] = true, -- Polarizing Field

            [87276] = true, -- Chomp
            [87310] = true, -- Run Away!
            [87312] = true, -- Run Away!

            [84825] = true, -- Slash
            [84826] = true, -- Slash
            [84827] = true, -- Rake
            [84834] = true, -- Rake

            [94903] = true, -- Spring
            [94908] = true, -- Spring
            [94907] = true, -- Spring

            [87237] = true, -- Spring
            [87242] = true, -- Spring
            [87241] = true, -- Spring

            [87247] = true, -- Devour
            [87988] = true, -- Devour
            [91413] = true, -- Devour
            [87252] = true, -- Devour
            [87253] = true, -- Devour
            [87251] = true, -- Devour
            [87385] = true, -- Devour
            [87386] = true, -- Devour
            [87987] = true, -- Devour

            [84944] = true, -- Hollow
            [91440] = true, -- Hollow
            [91439] = true, -- Hollow
            [84944] = true, -- Hollow
            [84967] = true, -- Hollow
            [84988] = true, -- Hollow
            [84990] = true, -- Hollow

            [87269] = true, -- Torpor
            [87270] = true, -- Torpor
            [87538] = true, -- Torpor
            [87536] = true, -- Torpor
            [89751] = true, -- Dispel Illusion
            [87271] = true, -- Torpor
            [87273] = true, -- Torpor
            [91426] = true, -- Match Health
            [87639] = true, -- Fade
            [91425] = true, -- Torpor
            [91433] = true, -- Torpor

            [89030] = true, -- Subduction
            [88246] = true, -- Iron Hand
            [88247] = true, -- Eruption
            [88282] = true, -- Rock Stomp
            [88286] = true, -- Rock Stomp
            [88296] = true, -- Rock Stomp
            [88285] = true, -- Rock Stomp
            [88295] = true, -- Rock Stomp
            [88261] = true, -- Lava Wave
            [88270] = true, -- Lava Wave
            [88271] = true, -- Lava Wave
            [88269] = true, -- Lava Wave
            [88272] = true, -- Lava Wave
            [88267] = true, -- Lava Wave
            [88266] = true, -- Lava Wave
            [89259] = true, -- Subduction
            [89260] = true, -- Subduction
            [89261] = true, -- Subduction
            [89258] = true, -- Subduction
            [88297] = true, -- Blast Furnace
            [88298] = true, -- Blast Furnace
            [88319] = true, -- Blast Furnace
            [88320] = true, -- Blast Furnace
            [88321] = true, -- Blast Furnace
            [88323] = true, -- Blast Furnace
            [88316] = true, -- Blast Furnace
            [88317] = true, -- Blast Furnace
            [88318] = true, -- Blast Furnace

            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --

            ------------------------------------------
            -- MAIN QUEST
            ------------------------------------------

            -- Tutorial (Soul Shriven in Coldharbour)
            [82077] = true, -- Portal In
            [90733] = true, -- Knockout
            [48675] = true, -- Vitality of the Titanborn

            [62805] = true, -- Stun
            [62802] = true, -- Targetable Off
            [62803] = true, -- Targetable On
            [62801] = true, -- Portal Spawn
            [75514] = true, -- Greater Protection
            [75527] = true, -- Ultimate Protection
            [64089] = true, -- Titan Bash
            [64091] = true, -- Power Bash
            [64772] = true, -- MQ1 Input Lock LAtk
            [64769] = true, -- MQ1 Input Lock LAtk
            [64092] = true, -- PermaStun
            [64133] = true, -- PermRoot
            [63883] = true, -- Major Protection
            [64029] = true, -- MQ1 Inpuit Lock Visual
            [61748] = true, -- Heavy Attack
            [64784] = true, -- MQ1 Tutorial Block Heavy
            [61956] = true, -- Off-Balance Timer
            [61980] = true, -- Off-Balance
            [61961] = true, -- Perma Set Off Balance Target
            [64677] = true, -- MQ1 Tutorial Perma Off-Balance
            [63900] = true, -- Major Protection die
            [64676] = true, -- MQ1 Tutorial Perma Off-Balance
            [61916] = true, -- Heat Wave
            [64798] = true, -- MQ1 Heat Wave (Tutorial)
            [75531] = true, -- Retarget
            [63737] = true, -- Heavy Attack
            [63684] = true, -- Uppercut
            [63685] = true, -- Uppercut Stun
            [63686] = true, -- Uppercut
            [63761] = true, -- Pound
            [63752] = true, -- Vomit
            [63753] = true, -- Vomit
            [64069] = true, -- Sentinel Barrier
            [64247] = true, -- MQ1 Input Lock Visual No Delay
            [63555] = true, -- MQ1 Sneak Atk Tutorial Trigger
            [63559] = true, -- MQ1 Sneak Tutorial Trigger
            [64072] = true, -- Eye of the Sentinel
            [48345] = true, -- Focused Healing
            [48346] = true, -- Minor Wound
            [63755] = true, -- Heat Wave
            [63756] = true, -- Heat Wave
            [51692] = true, -- Ground Rise on
            [63521] = true, -- Bone Crush
            [63522] = true, -- Bone Saw
            [61648] = true, -- Replenish Stamina
            [61644] = true, -- Incapacitating Terror
            [61646] = true, -- Incapacitating Terror
            [64074] = true, -- Incapacitating Terror
            [64166] = true, -- Major Protection
            [63398] = true, -- Backlash
            [63615] = true, -- Insight
            [64110] = true, -- Rending the Skein
            [63637] = true, -- Teleport
            [63633] = true, -- Escape Cold Harbor
            [63638] = true, -- Mq1_ExitLeap
            [63636] = true, -- Dummy
            [63635] = true, -- Escape Cold Harbor
            [64101] = true, -- Waking
            [25992] = true, -- CON_Screen Flash White
            [64112] = true, -- CON_Ground Rise on

            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --
            [00000] = true, --


            ------------------------------------------
            -- VVARDENFELL QUESTS/EVENTS
            ------------------------------------------

            -- Lava
            [11338] = true, -- In Lava
            [11339] = true, -- Lava Snare

            -- Tutorial
            [89095] = true, -- Slaver Clothes
            [92087] = true, -- Slaver Clothes
            [92106] = true, -- Slaver Clothes
            [92108] = true, -- Slaver Clothes
            [89096] = true, -- Slaver Clothes
            [88444] = true, -- Sit
            [93489] = true, -- Sit
            [92743] = true, -- Waking
            [47704] = true, -- Q4885 No Damage Follower
            [88453] = true, -- Bound
            [90591] = true, -- Manacled
            [74501] = true, -- Generic Stun 6s No Anim
            [94362] = true, -- Q5804 Player Hit Reaction
            [92245] = true, -- MQ1 Input Lock LAtk
            [92243] = true, -- MQ1 Input Lock LAtk
            [92248] = true, -- Q5804 Input Lock Visual
            [1718] = true, -- Attack
            [83416] = true, -- Heavy Attack
            [93577] = true, -- MQ1 Tutorial Block Heavy
            [92262] = true, -- Off-Balance Timer
            [92265] = true, -- Off-Balance
            [92263] = true, -- Perma Set Off Balance Target
            [92266] = true, -- MQ1 Tutorial Perma Off-Balance
            [92233] = true, -- Throw Dagger
            [92238] = true, -- MQ1 Heat Wave (Tutorial)
            [62546] = true, -- MQ1 Lockpick Grant
            [93604] = true, -- Q5804 Input Lock Visual
            [88904] = true, -- Metal Trap
            [88905] = true, -- Metal Trap
            [22337] = true, -- Generic Fade to Black 2s
            [92002] = true, -- Waking

            -- Tutorial NPC's
            [92668] = true, -- Whirlwind (Slaver Cutthroat)
            [92669] = true, -- Whirlwind (Slaver Cutthroat)
            [63269] = true, -- Heat Wave (Fist Mate Ulveni)
            [63270] = true, -- Heat Wave (Fist Mate Ulveni)

            -- Divine Conundrum (Main Quest)
            [91600] = true, -- Disintegration
            [91604] = true, -- Carapace
            [91603] = true, -- Disintegration
            [91005] = true, -- Q5803 Divination Beam

            -- Divine Inquiries (Main Quest)
            [85264] = true, -- Sacrifice
            [85265] = true, -- Sacrifice
            [85266] = true, -- Sacrifice

            -- A Web of Trouble (Sidequest)
            [91347] = true, -- Readying Signal
            [89266] = true, -- Summon Spider
            [89269] = true, -- Summon Spider
            [89276] = true, -- Summon Exploder
            [89278] = true, -- Summon Exploder
            [89277] = true, -- Summon Exploder
            [89268] = true, -- Summon Spider
            [89272] = true, -- Spider Explosion
            [89282] = true, -- Spider Explosion
            [89274] = true, -- Spider Explosion

            -- Like Blood from a Stone (Sidequest)
            [86649] = true, -- Accelerated Transposition
            [86743] = true, -- Accelerated Transposition
            [86646] = true, -- Accelerated Transposition
            [90511] = true, -- Accelerated Transposition

            -- The Memory Stone (Sidequest)
            [87342] = true, -- Vision of a Memory
            [87359] = true, -- Memory Projection

            -- Fleeing the Past (SQ)
            [92580] = true, -- Q5887 - AshurStealthOut
            [93993] = true, -- Assassinate
            [94461] = true, -- Jump
            [93994] = true, -- Whirlwind
            [93995] = true, -- Whirlwind
            [92585] = true, -- Drink Potion

            -- Family Reunion (IDK if MQ or SQ)
            [86979] = true, -- Summon Skaafin
            [86980] = true, -- Summon Skaafin
            [86981] = true, -- Summon Skaafin

            -- A Melodic Mistake (SQ)
            [85450] = true, -- Q5872 - Dwemer Sound - Far
            [89255] = true, -- Q5872 - Dwemer Sound - Mid
            [86862] = true, -- Powered Up
            [86865] = true, -- Powered Up
            [86608] = true, -- Q5872 - Dwarven Barrier
            [86633] = true, -- Barrier Break
            [89256] = true, -- Q5872 - Dwemer Sound - Near
            [86709] = true, -- Q5872 - Puzzle Solved
            [86714] = true, -- Q5872 - Gnisis Teleport Succes

            -- Hatching a Plan (SQ)
            [91411] = true, -- Q5883- CliffStriderSpawn
            [95519] = true, -- Generic Stun 3s No Anim

            -- Breaking Through the Fog
            [94842] = true, -- Dousing...

            -- Haunted Grounds (SQ)
            [93411] = true, -- Q5863 - MasterBossDies Farwen
            [93412] = true, -- Q5863 - MasterBossDies Farwen

            -- Reclaiming Vos (SQ)
            [87812] = true, -- Stealth Shader
            [85105] = true, -- Unstable Reaction
            [85537] = true, -- Summon Personal Guard

            -- Ancestral Adversity (SQ)
            [86197] = true, -- Q5882 harp Notes
            [89734] = true, -- Wall Dissolve
            [88403] = true, -- Flame Jet
            [88491] = true, -- Searing Flame
            [88411] = true, -- Hammer
            [88413] = true, -- Hammer
            [88405] = true, -- Hammer
            [88406] = true, -- Hammer
            [89663] = true, -- Hammer
            [89664] = true, -- Hammer
            [88404] = true, -- Blade
            [88454] = true, -- Blade
            [88455] = true, -- Blade
            [88510] = true, -- Staggered
            [92720] = true, -- Necrotic Wave
            [92722] = true, -- Stomp of Flame
            [92723] = true, -- Fire Backlash
            [92721] = true, -- CON_Knockback&Knockdown

            -- DELVE (Khartag Point)
            [89753] = true, -- Shocking Touch -- Old Rust-Eye
            [89754] = true, -- Shocking Touch -- Old Rust-Eye

            -- At Any Cost (SQ)
            [85651] = true, -- Flare -- Scamp
            [91773] = true, -- Dark Rejuvenation -- Xykenaz
            [91774] = true, -- Dark Rejuvenation FX -- Xykenaz

            -- Matus-Akin Egg Mine (Delve)
            [88415] = true, -- Awaken the Colony
            [88416] = true, -- Awaken the Colony
            [88438] = true, -- Summon Skaafin
            [88417] = true, -- Awaken the Colony
            [88439] = true, -- Summon Skaafin

            [88419] = true, -- Charge
            [88422] = true, -- Charge
            [88427] = true, -- Charge
            [88431] = true, -- Charge
            [88428] = true, -- Charge
            [88435] = true, -- Charge
            [88437] = true, -- Charge
            [88432] = true, -- Charge
            [88426] = true, -- Charge
            [88433] = true, -- Charge
            [88430] = true, -- Charge
            [88425] = true, -- Shattered Ground

            -- A Hireling of House Telvanni (SQ)
            [87351] = true, -- Water Geyser Warning
            [87348] = true, -- Water Geyser Burst
            [87349] = true, -- Water Geyser Burst
            [87350] = true, -- Water Geyser Burst

            -- The Magister Makes a Move (SQ)
            [89246] = true, -- Q5914 Nelos Notices
            [89247] = true, -- Q4636 Delayed Teleport Ext 01
            [89756] = true, -- Guardian Shockwave
            [89757] = true, -- Guardian Shockwave
            [84273] = true, -- Sweeping Spin
            [90808] = true, -- TV 4 CV Delay

            -- The Heart of a Telvanni (SQ)
            [87738] = true, -- Powder Bomb
            [89564] = true, -- Knockout
            [93289] = true, -- Q5922 Stun Capt
            [88244] = true, -- The Slavemaster's Chains

            -- Divine Delusions
            [86972] = true, -- Q5888 Chodala Magic Shield Fx
            [90630] = true, -- Frenzy
            [87958] = true, -- Ash Storm
            [87960] = true, -- Ash Storm
            [87959] = true, -- Ash Storm

            -- An Armiger's Duty (SQ)
            [89481] = true, -- Flame Jet
            [93583] = true, -- Taunt
            [90073] = true, -- Blinding Light
            [96174] = true, -- Q5877 - Q.Item Cooldown

            -- Divine Intervention (MQ)
            [86353] = true, -- Mechanical Possession
            [86417] = true, -- Inactive Centurion
            [86349] = true, -- Mechanical Possession
            [86355] = true, -- Mechanical Possession
            [92149] = true, -- VQ4 Fire Trap DoT
            [92150] = true, -- Fire Trap

            [91006] = true, -- Chodala's Shield
            [91669] = true, -- x
            [89909] = true, -- Tonal Inverter Ready
            [89910] = true, -- Tonal Inverter Ready
            [89911] = true, -- Tonal Inverter Ready
            [90080] = true, -- Tonal Inverter Ready
            [90952] = true, -- Tonal Inverter
            [90955] = true, -- Tonal Inverter
            [89901] = true, -- Tonal Inverter
            [91715] = true, -- Seryn's Connection
            [89904] = true, -- Tonal Inverter
            [89903] = true, -- Tonal Inverter

            [86815] = true, -- Daedric Bolt
            [90140] = true, -- Sunder's Echo
            [90149] = true, -- Sunder's Echo
            [90145] = true, -- Sunder's Echo
            [90143] = true, -- Sunder's Echo
            [90144] = true, -- Sunder's Echo
            [90148] = true, -- Sunder's Echo
            [90150] = true, -- Sunder's Echo
            [90146] = true, -- Sunder's Echo
            [90147] = true, -- Sunder's Echo

            [90139] = true, -- Empowered Strike
            [90141] = true, -- Empowered Strike
            [90142] = true, -- Empowered Strike

            [92304] = true, -- Q5893 Screen Flash White
            [88963] = true, -- Delay
            [90046] = true, -- Generic Stun + Headgrab 12s

            -- Divine Disaster (MQ)
            [92966] = true, -- Q5902_Screen Shake on Target
            [88465] = true, -- Skyfall
            [88466] = true, -- Skyfall
            [88467] = true, -- Skyfall
            [92536] = true, -- Vulnerability to Meteors

            -- Divine Restoration (MQ)
            [90181] = true, -- Oily Smoke
            [90182] = true, -- Oily Smoke
            [87101] = true, -- Blade Trap
            [87104] = true, -- Stun
            [87102] = true, -- Spinning Blade
            [87261] = true, -- Blade Vulnerability
            [91970] = true, -- Serrated Blade
            [91969] = true, -- Serrated Blade
            [89749] = true, -- Pulse
            [89750] = true, -- Pulse
            [89330] = true, -- Defensive Flare
            [92213] = true, -- Sparks
            [92228] = true, -- Pulse
            [92229] = true, -- Pulse
            [92227] = true, -- Pulse
            [92223] = true, -- Repair
            [92224] = true, -- Repair
            [92225] = true, -- Repair
            [89761] = true, -- Fabricate Beetle

            [90528] = true, -- Loyal Hound
            [87038] = true, -- Spinning Blades
            [87040] = true, -- Pinning Blades
            [87039] = true, -- Pinning Blades

            [87047] = true, -- Lunge
            [87053] = true, -- Lunge
            [87051] = true, -- Lunge
            [87048] = true, -- Lunge
            [87050] = true, -- Lunge
            [87049] = true, -- Lunge

            [87090] = true, -- Barbs
            [87096] = true, -- Barbs

            [90599] = true, -- Daedric Vigor
            [90501] = true, -- Tap the Divine
            [90525] = true, -- Phase Transition
            [90533] = true, -- Loyal Hound 1
            [90504] = true, -- VV-VQ5 Phase Transition
            [90502] = true, -- VV-VQ5 Phase Transition
            [92283] = true, -- Planar Shear
            [92284] = true, -- Planar Shear
            [90627] = true, -- targetable

            [90534] = true, -- Loyal Hound
            [90536] = true, -- Loyal Hound
            [90535] = true, -- Loyal Hound

            [90566] = true, -- Loyal Hound
            [90567] = true, -- Loyal Hound
            [90568] = true, -- Loyal Hound
            [90569] = true, -- Loyal Hound

            [87503] = true, -- Divine Hijack
            [90616] = true, -- Divine Hijack
            [87523] = true, -- Divine Hijack
            [87504] = true, -- Divine Hijack
            [87505] = true, -- Divine Hijack
            [90617] = true, -- Divine Hijack
            [87525] = true, -- Divine Hijack
            [87522] = true, -- Divine Hijack
            [90514] = true, -- Phase Transition

            [90524] = true, -- Divine Hijack
            [92411] = true, -- Contrived Portal
            [92412] = true, -- Contrived Portal
            [92413] = true, -- Contrived Portal

            -- Divine Blessings (MQ)
            [90572] = true, -- Q6003 - NP Ending Theater CV

            -- PUBLIC DUNGEON (The Forgotten Wastes)
            [88029] = true, -- Volcanic Activity (Deadfall)
            [91659] = true, -- Falling Rocks (Deadfall)
            [88030] = true, -- Falling Rocks (Deadfall)

            [92670] = true, -- Pyroclast (Meteor)
            [92671] = true, -- Pyroclast (Meteor)
            [92672] = true, -- Pyroclast (Meteor)

            [86930] = true, -- Volcanic Debris
            [86935] = true, -- Volcanic Debris
            [86932] = true, -- Volcanic Debris
            [90500] = true, -- Volcanic Debris
            [86934] = true, -- Volcanic Debris
            [86939] = true, -- Volcanic Debris
            [86938] = true, -- Volcanic Debris

            [92702] = true, -- Volcanic Debris
            [92705] = true, -- Volcanic Debris
            [92709] = true, -- Volcanic Debris
            [92703] = true, -- Volcanic Debris
            [92707] = true, -- Volcanic Debris
            [92706] = true, -- Volcanic Debris
            [92704] = true, -- Volcanic Debris

            [86983] = true, -- Succubus Touch
            [86984] = true, -- Succubus Touch
            [86989] = true, -- Succubus Touch

            -- PUBLIC DUNGEON (Nchuleftingth)
            [84510] = true, -- Searing Steam
            [84537] = true, -- Searing Steam
            [84527] = true, -- Searing Steam

            [90268] = true, -- Charge Whire Shock
            [90271] = true, -- Charge-Wire Shock
            [90269] = true, -- Charge-Wire Shock

            [90220] = true, -- Immune to Electricity

            [86634] = true, -- Swinging Cleave -- Mud-Tusk
            [86635] = true, -- Swinging Cleave -- Mud-Tusk
            [89210] = true, -- Boulder Toss -- Mud-Tusk
            [89234] = true, -- Turn -- Mud-Tusk
            [89240] = true, -- Boulder Toss -- Mud-Tusk
            [89239] = true, -- Boulder Toss -- Mud-Tusk
            [94935] = true, -- Tremor -- Mud-Tusk
            [94937] = true, -- Tremor -- Mud-Tusk
            [94936] = true, -- Tremor -- Mud-Tusk

            [86610] = true, -- Piston Thrust
            [86613] = true, -- Piston Thrust
            [86623] = true, -- Piston Thrust
            [86624] = true, -- Piston Thrust

            [90856] = true, -- Steam Piston
            [90860] = true, -- Spike Trap
            [90859] = true, -- Swinging Blades
            [90857] = true, -- Swinging Blades

            [86591] = true, -- Piston Thrust -- Guardian of Bthark
            [86592] = true, -- Piston Thrust -- Guardian of Bthark
            [86596] = true, -- Piston Thrust -- Guardian of Bthark
            [86595] = true, -- Piston Thrust -- Guardian of Bthark

            [69283] = true, -- Whirlwind Function -- Guardian of Bthark
            [69285] = true, -- Whirlwind Function -- Guardian of Bthark
            [69284] = true, -- Whirlwind Function -- Guardian of Bthark
            [69286] = true, -- Whirlwind Function -- Guardian of Bthark

            [86606] = true, -- Steam Breath -- Guardian of Bthark
            [86607] = true, -- Steam Breath -- Guardian of Bthark

            [90192] = true, -- Overcharge
            [90212] = true, -- Overcharge
            [90214] = true, -- Overcharge
            [90217] = true, -- Overcharge
            [90216] = true, -- Overcharge
            [90215] = true, -- Overcharge

            [71919] = true, -- Turret Occupied
            [71920] = true, -- Turret Mode

            [95731] = true, -- Dutiful Fury
            [86567] = true, -- Fire Runes
            [86568] = true, -- Fire Runes
            [86569] = true, -- Fire Runes
            [86566] = true, -- Fire Runes
            [86570] = true, -- Shield Charge
            [86574] = true, -- Shield Charge
            [86575] = true, -- Shield Charge
            [86576] = true, -- Staggered

            [73095] = true, -- In Lava
            [73103] = true, -- Lava

            [51634] = true, -- Shocking Touch
            [86659] = true, -- Auditory Signal
            [86680] = true, -- Auditory Signal
            [86691] = true, -- Overcharge
            [86690] = true, -- Overcharge
            [86688] = true, -- Overcharge
            [86689] = true, -- Overcharge

            [92135] = true, -- Nchuleftingth Electricity
            [92136] = true, -- Laser Snare
            [92138] = true, -- Laser Damage

            [89998] = true, -- Auditory Command
            [90004] = true, -- Auditory Command
            [90005] = true, -- Auditory Command
            [90006] = true, -- Auditory Command
            [90007] = true, -- Auditory Command
            [90008] = true, -- Auditory Command
            [90009] = true, -- Auditory Command
            [90010] = true, -- Auditory Command

            [84332] = true, -- Demolish
            [84333] = true, -- Demolish
            [84334] = true, -- Demolish
            [84336] = true, -- Demolish
            [89917] = true, -- Boss
            [89918] = true, -- Boss
            [90783] = true, -- Indominable
            [90788] = true, -- Indominable
            [84738] = true, -- Indominable
            [84739] = true, -- Indominable
            [84755] = true, -- Indominable
            [91407] = true, -- Indominable
            [90821] = true, -- Enable
            [90862] = true, -- Indominable
            [90863] = true, -- Indominable
            [90867] = true, -- Indominable
            [91485] = true, -- Indominable
            [90869] = true, -- Indominable
            [90870] = true, -- Indominable
            [90874] = true, -- Indominable
            [91486] = true, -- Indominable

            [84554] = true, -- Momentum
            --[84638] = true, -- Momentum
            [84606] = true, -- Momentum
            [84616] = true, -- Momentum

            [90597] = true, -- Overcharge Explusion
            [90598] = true, -- Overcharge Explusion

            [00000] = true, --
            [00000] = true, --

            -- TEMP TEMP TEMP
            [56975] = true, -- CH Steam Warning
            [32236] = true, -- Trap Regen Stopper Enemy

            [82137] = true, -- Spellfiends Frost
            [82138] = true, -- Spellfiends Storm
            [81911] = true, -- Spellfiends Fire

            [87368] = true, -- Crag shit 2
            [87371] = true, -- Crag shit 1
            [87383] = true, -- Crag shit 1

            ----------------------------------

            -- SEASONAL - Witches Harvest - All working, just need to organized eventually
            [83775] = true, -- Event - Q5742 WitchFest Intro -- The Witchmother's Bargain
            [83820] = true, -- Event Q5742 WitchFest Done -- The Witchmother's Bargain
            [82898] = true, -- Event - WitchFest Theater -- The Witchmother's Bargain

            -- SEASONAL -- New Life Festival
            [86075] = true, -- Breda's Magnificent Mead -- Breda's Magnificent Mead
            [84125] = true, -- Breton Male Dance -- Lava Foot Stomp
            [84187] = true, -- Breton Dance -- Lava Foot Stomp
            [85544] = true, -- Breton Dance -- Lava Foot Stomp
            [84126] = true, -- Breton Female Dance -- Lava Foot Stomp
            [84188] = true, -- Breton Dance -- Lava Foot Stomp
            [85540] = true, -- Breton Dance -- Lava Foot Stomp
            [86752] = true, -- Entertaining -- Lava Foot Stomp
            [84127] = true, -- Dunmer Male Dance -- Lava Foot Stomp
            [84189] = true, -- Dunmer Dance -- Lava Foot Stomp
            [85545] = true, -- Breton Dance -- Lava Foot Stomp
            [84128] = true, -- Dunmer Female Dance -- Lava Foot Stomp
            [84190] = true, -- Dunmer Dance -- Lava Foot Stomp
            [85546] = true, -- Breton Dance -- Lava Foot Stomp
            [84130] = true, -- Altmer Male Dance -- Lava Foot Stomp
            [84191] = true, -- Bosmer Dance -- Lava Foot Stomp
            [85547] = true, -- Breton Dance -- Lava Foot Stomp
            [84131] = true, -- Altmer Female Dance -- Lava Foot Stomp
            [84192] = true, -- Bosmer Dance -- Lava Foot Stomp
            [85548] = true, -- Breton Dance -- Lava Foot Stomp
            [84133] = true, -- Nord Dance -- Lava Foot Stomp
            [84194] = true, -- Nord Dance -- Lava Foot Stomp
            [85549] = true, -- Breton Dance -- Lava Foot Stomp
            [84528] = true, -- Flame Juggling -- Castle Charm Challenge
            [84530] = true, -- Flame Juggling -- Castle Charm Challenge
            [85561] = true, -- Breton Dance -- Castle Charm Challenge
            [84506] = true, -- Dagger Juggling -- Castle Charm Challenge
            [84507] = true, -- Dagger Juggling -- Castle Charm Challenge
            [85560] = true, -- Breton Dance -- Castle Charm Challenge
            [84533] = true, -- Sword Swallowing -- Castle Charm Challenge
            [84534] = true, -- Sword Swallowing -- Castle Charm Challenge
            [85562] = true, -- Breton Dance -- Castle Charm Challenge
            --[85351] = true, -- Self-Serve Mudbath -- Mud Ball Merriment (Likely unused)
            --[85352] = true, -- Covered in Mud -- Mud Ball Merriment (Likely unused)
            [84847] = true, -- Celebratory Belch -- Stonetooth Bash
            [85680] = true, -- Jump -- Snow Bear Plunge
            [83523] = true, -- Freezing -- Snow Bear Plunge
            [83544] = true, -- Cold -- Snow Bear Plunge
            [83522] = true, -- Warn -- Snow Bear Plunge
            [84330] = true, -- Mudball -- Mud Ball Merriment
            [84378] = true, -- Mudball -- Mud Ball Merriment
            [84335] = true, -- Covered in Mud -- Mud Ball Merriment
            [85639] = true, -- Covered in Mud -- Mud Ball Merriment

            -- SEASONAL -- Jester's Festival
            [88095] = true, -- Illusion Dazzler -- Royal Revelry
            [88123] = true, -- Illusion Dazzler -- Royal Revelry
            [88124] = true, -- Illusion Dazzler -- Royal Revelry
            [89243] = true, -- Butcher Awareness - A Noble Guest
            [89201] = true, -- Flare -- Springtime Flair
            [87474] = true, -- Flower Garland -- Springtime Flair

            -- SEASONAL -- Anniversary Event
            [88874] = true, -- Q5936 Destroy Voucher 2017 --

            -- SEASONAL -- Midyear Mayhem
            [92232] = true, -- Pelinal's Ferocity

            -- DARK BROTHERHOOD LITANY OF BLOOD EVENTS -- All working, just need to sort eventually
            [78933] = true, -- Litany of Blood Soul Steal
            [77170] = true, -- Delay Name Swap

}
