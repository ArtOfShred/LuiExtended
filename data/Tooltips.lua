------------------
-- Tooltips namespace
LUIE.Tooltips = {}

-- Performance Enhancement
local T = LUIE.Tooltips

-- ---------------------------------------------------
-- MAJOR/MINOR DEBUFFS & DEBUFFS ---------------------
-- ---------------------------------------------------

-- Major/Minor Buffs
T.Skill_Minor_Resolve               = GetString(SI_LUIE_SKILL_MINOR_RESOLVE_TP)
T.Skill_Major_Resolve               = GetString(SI_LUIE_SKILL_MAJOR_RESOLVE_TP)
T.Skill_Minor_Ward                  = GetString(SI_LUIE_SKILL_MINOR_WARD_TP)
T.Skill_Major_Ward                  = GetString(SI_LUIE_SKILL_MAJOR_WARD_TP)
T.Skill_Minor_Fortitude             = GetString(SI_LUIE_SKILL_MINOR_FORTITUDE_TP)
T.Skill_Major_Fortitude             = GetString(SI_LUIE_SKILL_MAJOR_FORTITUDE_TP)
T.Skill_Minor_Endurance             = GetString(SI_LUIE_SKILL_MINOR_ENDURANCE_TP)
T.Skill_Major_Endurance             = GetString(SI_LUIE_SKILL_MAJOR_ENDURANCE_TP)
T.Skill_Minor_Intellect             = GetString(SI_LUIE_SKILL_MINOR_INTELLECT_TP)
T.Skill_Major_Intellect             = GetString(SI_LUIE_SKILL_MAJOR_INTELLECT_TP)
T.Skill_Minor_Sorcery               = GetString(SI_LUIE_SKILL_MINOR_SORCERY_TP)
T.Skill_Major_Sorcery               = GetString(SI_LUIE_SKILL_MAJOR_SORCERY_TP)
T.Skill_Minor_Prophecy              = GetString(SI_LUIE_SKILL_MINOR_PROPHECY_TP)
T.Skill_Major_Prophecy              = GetString(SI_LUIE_SKILL_MAJOR_PROPHECY_TP)
T.Skill_Minor_Brutality             = GetString(SI_LUIE_SKILL_MINOR_BRUTALITY_TP)
T.Skill_Major_Brutality             = GetString(SI_LUIE_SKILL_MAJOR_BRUTALITY_TP)
T.Skill_Minor_Savagery              = GetString(SI_LUIE_SKILL_MINOR_SAVAGERY_TP)
T.Skill_Major_Savagery              = GetString(SI_LUIE_SKILL_MAJOR_SAVAGERY_TP)
T.Skill_Minor_Berserk               = GetString(SI_LUIE_SKILL_MINOR_BERSERK_TP)
T.Skill_Major_Berserk               = GetString(SI_LUIE_SKILL_MAJOR_BERSERK_TP)
T.Skill_Minor_Force                 = GetString(SI_LUIE_SKILL_MINOR_FORCE_TP)
T.Skill_Major_Force                 = GetString(SI_LUIE_SKILL_MAJOR_FORCE_TP)
T.Skill_Minor_Vitality              = GetString(SI_LUIE_SKILL_MINOR_VITALITY_TP)
T.Skill_Major_Vitality              = GetString(SI_LUIE_SKILL_MAJOR_VITALITY_TP)
T.Skill_Minor_Mending               = GetString(SI_LUIE_SKILL_MINOR_MENDING_TP)
T.Skill_Major_Mending               = GetString(SI_LUIE_SKILL_MAJOR_MENDING_TP)
T.Skill_Minor_Protection            = GetString(SI_LUIE_SKILL_MINOR_PROTECTION_TP)
T.Skill_Major_Protection            = GetString(SI_LUIE_SKILL_MAJOR_PROTECTION_TP)
T.Skill_Minor_Evasion               = GetString(SI_LUIE_SKILL_MINOR_EVASION_TP)
T.Skill_Major_Evasion               = GetString(SI_LUIE_SKILL_MAJOR_EVASION_TP)
T.Skill_Minor_Expedition            = GetString(SI_LUIE_SKILL_MINOR_EXPEDITION_TP)
T.Skill_Major_Expedition            = GetString(SI_LUIE_SKILL_MAJOR_EXPEDITION_TP)
T.Skill_Major_Gallop                = GetString(SI_LUIE_SKILL_MAJOR_GALLOP_TP)
T.Skill_Minor_Heroism               = GetString(SI_LUIE_SKILL_MINOR_HEROISM_TP)
T.Skill_Major_Heroism               = GetString(SI_LUIE_SKILL_MAJOR_HEROISM_TP)
T.Skill_Minor_Toughness             = GetString(SI_LUIE_SKILL_MINOR_TOUGHNESS_TP)
T.Skill_Major_Courage               = GetString(SI_LUIE_SKILL_MAJOR_COURAGE_TP)

-- Major/Minor Debuffs
T.Skill_Minor_Breach                = GetString(SI_LUIE_SKILL_MINOR_BREACH_TP)
T.Skill_Major_Breach                = GetString(SI_LUIE_SKILL_MAJOR_BREACH_TP)
T.Skill_Minor_Fracture              = GetString(SI_LUIE_SKILL_MINOR_FRACTURE_TP)
T.Skill_Major_Fracture              = GetString(SI_LUIE_SKILL_MAJOR_FRACTURE_TP)
T.Skill_Minor_Vulnerability         = GetString(SI_LUIE_SKILL_MINOR_VULNERABILITY_TP)
T.Skill_Minor_Maim                  = GetString(SI_LUIE_SKILL_MINOR_MAIM_TP)
T.Skill_Major_Maim                  = GetString(SI_LUIE_SKILL_MAJOR_MAIM_TP)
T.Skill_Minor_Defile                = GetString(SI_LUIE_SKILL_MINOR_DEFILE_TP)
T.Skill_Major_Defile                = GetString(SI_LUIE_SKILL_MAJOR_DEFILE_TP)
T.Skill_Minor_Magickasteal          = GetString(SI_LUIE_SKILL_MINOR_MAGICKASTEAL_TP)
T.Skill_Minor_Lifesteal             = GetString(SI_LUIE_SKILL_MINOR_LIFESTEAL_TP)
T.Skill_Minor_Enveration            = GetString(SI_LUIE_SKILL_MINOR_ENERVATION_TP)
T.Skill_Minor_Uncertainty           = GetString(SI_LUIE_SKILL_MINOR_UNCERTAINTY_TP)
T.Skill_Minor_Cowardice             = GetString(SI_LUIE_SKILL_MINOR_COWARDICE_TP)
T.Skill_Minor_Mangle                = GetString(SI_LUIE_SKILL_MINOR_MANGLE_TP)

-- Aegis/Slayer
T.Skill_Minor_Aegis                 = GetString(SI_LUIE_SKILL_MINOR_AEGIS_TP)
T.Skill_Major_Aegis                 = GetString(SI_LUIE_SKILL_MAJOR_AEGIS_TP)

T.Skill_Minor_Slayer                = GetString(SI_LUIE_SKILL_MINOR_SLAYER_TP)
T.Skill_Major_Slayer                = GetString(SI_LUIE_SKILL_MAJOR_SLAYER_TP)

-- ---------------------------------------------------
-- GENERIC ---------------------
-- ---------------------------------------------------

T.Generic_Bleed                     = GetString(SI_LUIE_SKILL_GENERIC_BLEED_TP)
T.Generic_Disease                   = GetString(SI_LUIE_SKILL_GENERIC_DISEASE_TP)
T.Generic_Poison                    = GetString(SI_LUIE_SKILL_GENERIC_POISON_TP)
T.Generic_Burn                      = GetString(SI_LUIE_SKILL_GENERIC_BURN_TP)
T.Generic_Freeze                    = GetString(SI_LUIE_SKILL_GENERIC_FREEZE_TP)
T.Generic_Shock                     = GetString(SI_LUIE_SKILL_GENERIC_SHOCK_TP)

T.Generic_Off_Balance               = GetString(SI_LUIE_SKILL_GENERIC_OFF_BALANCE_TP)
T.Generic_Snare                     = GetString(SI_LUIE_SKILL_GENERIC_SNARE_TP)
T.Generic_Immobilize                = GetString(SI_LUIE_SKILL_GENERIC_IMMOBILIZE_TP)
T.Generic_Stagger                   = GetString(SI_LUIE_SKILL_GENERIC_STAGGER_TP)
T.Generic_Stun                      = GetString(SI_LUIE_SKILL_GENERIC_STUN_TP)
T.Generic_Knockback                 = GetString(SI_LUIE_SKILL_GENERIC_KNOCKBACK_TP)
T.Generic_Knockdown                 = GetString(SI_LUIE_SKILL_GENERIC_KNOCKDOWN_TP)
T.Generic_Fear                      = GetString(SI_LUIE_SKILL_GENERIC_FEAR_TP)

T.Generic_CC_Immunity               = GetString(SI_LUIE_SKILL_GENERIC_CC_IMMUNITY_TP)

-- ---------------------------------------------------
-- INNATE/WORLD ---------------------
-- ---------------------------------------------------

T.Innate_Recall_Penalty             = GetString(SI_LUIE_SKILL_RECALL_PENALTY_TP)
T.Innate_Ayleid_Well                = GetString(SI_LUIE_SKILL_AYLEID_WELL_TP)
T.Innate_Ayleid_Well_Fortified      = GetString(SI_LUIE_SKILL_AYLEID_WELL_FORTIFIED_TP)
T.Innate_Firelight                  = GetString(SI_LUIE_SKILL_FIRELIGHT_TP)


-- ---------------------------------------------------
-- PLAYER ABILITIES ---------------------
-- ---------------------------------------------------

-- Soul Magic
T.Skill_Soul_Summons                = GetString(SI_LUIE_SKILL_SOUL_SUMMONS_TP)

-- Werewolf
T.Skill_Sanies_Lupinus              = GetString(SI_LUIE_SKILL_SANIES_LUPINUS_TP)
T.Skill_Lycanthrophy                = GetString(SI_LUIE_SKILL_LYCANTHROPHY_TP)
T.Skill_Blood_Moon                  = GetString(SI_LUIE_SKILL_BLOOD_MOON_TP)

-- ---------------------------------------------------
-- QUESTS ---------------------
-- ---------------------------------------------------

T.Skill_Divine_Speed                = GetString(SI_LUIE_SKILL_DIVINE_SPEED_TP)
T.Skill_Lightning_Fury              = GetString(SI_LUIE_SKILL_QUEST_LIGHTNING_FURY_TP)
T.Skill_Blacksaps_Brew              = GetString(SI_LUIE_SKILL_BLACKSAPS_BREW_TP)
T.Skill_Vision_Journey              = GetString(SI_LUIE_SKILL_VISION_JOURNEY_TP)
T.Skill_Snakes_Scales               = GetString(SI_LUIE_SKILL_SNAKE_SCALES_TP)
T.Skill_Wolfs_Pelt                  = GetString(SI_LUIE_SKILL_WOLFS_PELT_TP)
T.Skill_Tigers_Fur                  = GetString(SI_LUIE_SKILL_TIGERS_FUR_TP)
T.Skill_Soul_Binding                = GetString(SI_LUIE_SKILL_SOUL_BINDING_TP)
T.Skill_Spirit_Armor                = GetString(SI_LUIE_SKILL_SPIRIT_ARMOR_TP)
T.Skill_Fancy_Clothing              = GetString(SI_LUIE_SKILL_FANCY_CLOTHING_TP)
T.Skill_Burrow                      = GetString(SI_LUIE_SKILL_BURROW_TP)
T.Skill_Shadow_Wood                 = GetString(SI_LUIE_SKILL_SHADOW_WOOD_TP)














