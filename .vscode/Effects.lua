
[84048] = {avoid = true,priority = 1,auradetect = true,cc = LUIE_CC_TYPE_SNARE,fakeName = Unitnames.Boss_Quenyas,sound = LUIE_ALERT_SOUND_TYPE_AOE,}, -- Defiled Ground (Quenyas)
[83776] = {summon = true,priority = 1,eventdetect = true,result = ACTION_RESULT_EFFECT_GAINED,fakeName = Unitnames.Boss_Quenyas,refire = 1000,sound = LUIE_ALERT_SOUND_TYPE_SUMMON,}, -- Dark Summons (Quenyas)
[84283] = {block = true,dodge = true,priority = 1,eventdetect = true,fakeName = Unitnames.Boss_Oskana,cc = LUIE_CC_TYPE_STAGGER,duration = 1500,sound = LUIE_ALERT_SOUND_TYPE_AOE_CC,}, -- Coursing Bones (Oskana)
[84286] = {summon = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,fakeName = Unitnames.Boss_Oskana,sound = LUIE_ALERT_SOUND_TYPE_SUMMON,}, -- -- Wake the Dead (Oskana)-- World Boss - Heretic's Summons
[82934] = {summon = true,priority = 1,auradetect = true,neverShowInterrupt = true,sound = LUIE_ALERT_SOUND_TYPE_SUMMON,},                                                                                                     -- Shrieking Summons (Snapjaw)
[83150] = { block = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, duration = 1200 }, -- Tail Whip (Snapjaw)
[83009] = {block = true,dodge = true,priority = 1,result = ACTION_RESULT_BEGIN,cc = LUIE_CC_TYPE_STUN,duration = 1500,}, -- Rending Leap (Snapjaw)
[83033] = {block = true,dodge = true,bs = true,priority = 2,eventdetect = true,result = ACTION_RESULT_BEGIN,fakeName = Unitnames.NPC_Clannfear,refire = 500,sound = LUIE_ALERT_SOUND_TYPE_AOE_CC,}, -- Focused Charge (Clannfear - Snapjaw)--
[83016] = { block = true, avoid = true, priority = 2, eventdetect = true, result = ACTION_RESULT_EFFECT_GAINED, refire = 250, duration = 1000, effectOnlyInterrupt = true, fakeName = Unitnames.NPC_Clannfear }, -- Necrotic Explosion (Clannfear - Snapjaw)-- World Boss - Nindaeril's Perch
[83515] = {block = true,bs = true,dodge = true,priority = 1,cc = LUIE_CC_TYPE_STUN,duration = 2000,result = ACTION_RESULT_BEGIN,}, -- Hunter's Pounce (Bavura the Blizzard)
[83832] = {block = true,dodge = true,priority = 1,eventdetect = true,cc = LUIE_CC_TYPE_STUN,result = ACTION_RESULT_BEGIN,fakeName = Unitnames.Boss_Nindaeril_the_Monsoon,}, -- Frenzied Charge (Nindaeril the Monsoon)
[83548] = {interrupt = true,priority = 1,eventdetect = true,cc = LUIE_CC_TYPE_FEAR,duration = 1000,result = ACTION_RESULT_BEGIN,fakeName = Unitnames.Boss_Nindaeril_the_Monsoon,}, -- Mighty Roar (Nindaeril the Monsoon)-- World Boss - Gathongor's Mine
[84205] = {avoid = true,priority = 1,result = ACTION_RESULT_BEGIN,eventdetect = true,bossName = true,duration = 1000,postCast = 4000,}, -- Stinging Sputum (Gathongor the Mauler)
[84196] = {avoid = true,priority = 1,result = ACTION_RESULT_BEGIN,duration = 1100,eventdetect = true,bossName = true,cc = LUIE_CC_TYPE_STAGGER,postCast = 2500,}, -- Marsh Masher (Gathongor the Mauler)
[84209] = {block = true,dodge = true,priority = 1,result = ACTION_RESULT_BEGIN,duration = 600,cc = LUIE_CC_TYPE_STUN,}, -- Wrecking Jaws (Gathongor the Mauler)
[84212] = {avoid = true,priority = 1,result = ACTION_RESULT_BEGIN,duration = 2100,cc = LUIE_CC_TYPE_STUN,eventdetect = true,bossName = true,}, -- Bog Slam (Gathongor the Mauler)-- World Boss - Thodundor's View
[83155] = { block = true, bs = true, dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, duration = 1300 }, -- Thunderous Smash (Thodundor of the Hill)
[83160] = {block = true,avoid = true,priority = 1,result = ACTION_RESULT_BEGIN,duration = 1800,cc = LUIE_CC_TYPE_STAGGER,eventdetect = true,bossName = true,}, -- Stone Crusher (Thodundor of the Hill)
[83136] = {block = true,avoid = true,priority = 1,result = ACTION_RESULT_BEGIN,duration = 800,cc = LUIE_CC_TYPE_SNARE,eventdetect = true,bossName = true,postCast = 1500,}, -- Ground Shock (Thodundor of the Hill)-- World Boss - Windshriek Strand
[84066] = {avoid = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,bossName = true,duration = 2500,postCast = 2500,}, -- Ground Shock (Skullbreaker)
[83651] = {avoid = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,refire = 500,bossName = true,duration = 4500,},                                                                                                            -- Feral Impact (Skullbreaker)
[84076] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, bossName = true }, -- Carrion Call (Skullbreaker)-- World Boss - Big Ozur's Valley
[83180] = { destroy = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, bossName = true }, -- Molten Pillar (Big Ozur)
[83206] = {block = true,avoid = true,priority = 1,eventdetect = true,result = ACTION_RESULT_EFFECT_GAINED,refire = 2000,bossName = true,}, -- Molten Shackles (Ice Pillar)
[83191] = {block = true,dodge = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,bossName = true,cc = LUIE_CC_TYPE_STUN,duration = 3800,}, -- Shaman Smash (Big Ozur)-- World Boss - The Wolf's Camp
[10149] = { power = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, refire = 5000 }, -- Guards Transform (Lieutenant Bran, Annyce)-- World Boss - Trapjaw's Cove
[83945] = {block = true,dodge = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,duration = 1200,cc = LUIE_CC_TYPE_STUN,bossName = true,}, -- Tail Sweep (Trapjaw)
[84028] = {interrupt = true,avoid = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,duration = 2000,bossName = true,postCast = 4000,}, -- Impending Storm (Trapjaw)
[84169] = {block = true,bs = true,dodge = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,cc = LUIE_CC_TYPE_STUN,bossName = true,}, -- Rolling Thunder (Trapjaw)
[83925] = {block = true,dodge = true,reflect = true,priority = 1,result = ACTION_RESULT_BEGIN,cc = LUIE_CC_TYPE_STUN,duration = 1700,},                                                                          -- Trapping Bolt (Trapjaw)
[83930] = { power = true, priority = 1, auradetect = true, noSelf = true }, -- Trapping Bolt (Trapjaw)-- World Boss - Spider Nest
[84150] = { summon = true, priority = 1, eventdetect = true, result = ACTION_RESULT_BEGIN, bossName = true },   -- Call of the Brood (Old Widow Silk)
[84151] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, cc = LUIE_CC_TYPE_STUN, duration = 400 }, -- Constricting Webs (Old Widow Silk)
[84548] = {block = true,avoid = true,priority = 1,eventdetect = true,refire = 1200,result = ACTION_RESULT_BEGIN,duration = 5100,bossName = true,},                                                                                                                    -- Venom Spray (Old Widow Silk)--
[84159] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, duration = 100, postCast = 500 }, -- Spit Poison (Old Widow Silk)
[84161] = { avoid = true, priority = 1, auradetect = true, refire = 10000, bossName = true, hiddenDuration = 10000 }, -- Spit Poison (Old Widow Silk)-- World Boss - Mudcrab Beach
[82965] = {avoid = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,duration = 7233,bossName = true,}, -- Crabuchet (Titanclaw)-- World Boss - Valeguard Tower
[84037] = {block = true,avoid = true,priority = 1,eventdetect = true,result = ACTION_RESULT_BEGIN,duration = 700,bossName = true,cc = LUIE_CC_TYPE_STUN,}, -- Petrifying Bellow (Menhir Stoneskin)
[84292] = {block = true,dodge = true,priority = 1,result = ACTION_RESULT_BEGIN,duration = 500,cc = LUIE_CC_TYPE_STUN,},                                                                                                            -- Graven Slash (Menhir Stoneskin)
[84014] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Awaken (Menhir Stoneskin)
[84029] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Awaken (Menhir Stoneskin)
[84417] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Awaken (Menhir Stoneskin)-- World Boss - Magdelena's Haunt
[83922] = { dodge = true, priority = 1, result = ACTION_RESULT_BEGIN, duration = 500, postCast = 1500 },      -- Curse of Terror (Magdelena)
[83880] = { power = true, priority = 1, auradetect = true, duration = 8000 },                                 -- Reflective Shadows (Magdelena)
[83227] = { summon = true, priority = 1, result = ACTION_RESULT_BEGIN, eventdetect = true, bossName = true }, -- Dark Resurrection (Magdelena)