------------------
-- Tooltips namespace
LUIE.Tooltips = {}

-- Performance Enhancement
local T = LUIE.Tooltips
local A = LUIE.GetAbility()

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

T.Skill_Empower                     = GetString(SI_LUIE_SKILL_EMPOWER_TP)
T.Skill_Hindrance                   = GetString(SI_LUIE_SKILL_HINDRANCE_TP)

-- ---------------------------------------------------
-- GENERIC ---------------------
-- ---------------------------------------------------

T.Generic_Test                      = GetString(SI_LUIE_SKILL_TEST_TP)

T.Generic_Bleed                     = GetString(SI_LUIE_SKILL_GENERIC_BLEED_TP)
T.Generic_Disease                   = GetString(SI_LUIE_SKILL_GENERIC_DISEASE_TP)
T.Generic_Poison                    = GetString(SI_LUIE_SKILL_GENERIC_POISON_TP)
T.Generic_Burn                      = GetString(SI_LUIE_SKILL_GENERIC_BURN_TP)
T.Generic_Freeze                    = GetString(SI_LUIE_SKILL_GENERIC_FREEZE_TP)
T.Generic_Shock                     = GetString(SI_LUIE_SKILL_GENERIC_SHOCK_TP)

T.Generic_HoT                       = GetString(SI_LUIE_SKILL_GENERIC_HOT_TP)
T.Generic_Magicka_Regen             = GetString(SI_LUIE_SKILL_GENERIC_MGK_REGEN_TP)
T.Generic_Stamina_Regen             = GetString(SI_LUIE_SKILL_GENERIC_STAM_REGEN_TP)

T.Generic_Off_Balance               = GetString(SI_LUIE_SKILL_GENERIC_OFF_BALANCE_TP)
T.Generic_Off_Balance_Immunity      = GetString(SI_LUIE_SKILL_GENERIC_OFF_BALANCE_IMMUNITY_TP)
T.Generic_Snare                     = GetString(SI_LUIE_SKILL_GENERIC_SNARE_TP)
T.Generic_Immobilize                = GetString(SI_LUIE_SKILL_GENERIC_IMMOBILIZE_TP)
T.Generic_Stagger                   = GetString(SI_LUIE_SKILL_GENERIC_STAGGER_TP)
T.Generic_Stun                      = GetString(SI_LUIE_SKILL_GENERIC_STUN_TP)
T.Generic_Knockback                 = GetString(SI_LUIE_SKILL_GENERIC_KNOCKBACK_TP)
T.Generic_Knockdown                 = GetString(SI_LUIE_SKILL_GENERIC_KNOCKDOWN_TP)
T.Generic_Fear                      = GetString(SI_LUIE_SKILL_GENERIC_FEAR_TP)

T.Generic_CC_Immunity               = GetString(SI_LUIE_SKILL_GENERIC_CC_IMMUNITY_TP)
T.Generic_Invisibility              = GetString(SI_LUIE_SKILL_GENERIC_INVISIBILITY_TP)
T.Generic_Detection_Potion          = GetString(SI_LUIE_SKILL_GENERIC_DETECTION_POTION_TP)
T.Generic_Ravage_Magicka_Potion     = GetString(SI_LUIE_SKILL_GENERIC_RAVAGE_MAGICKA_POTION_TP)
T.Generic_Ravage_Stamina_Potion     = GetString(SI_LUIE_SKILL_GENERIC_RAVAGE_STAMINA_POTION_TP)

T.Generic_Ravage_Magicka_Poison     = GetString(SI_LUIE_SKILL_GENERIC_RAVAGE_MAGICKA_POISON_TP)
T.Generic_Ravage_Stamina_Poison     = GetString(SI_LUIE_SKILL_GENERIC_RAVAGE_STAMINA_POISON_TP)

T.Generic_Marked                    = GetString(SI_LUIE_SKILL_GENERIC_MARKED_TP)
T.Generic_Reveal                    = GetString(SI_LUIE_SKILL_GENERIC_REVEAL_TP)

-- ---------------------------------------------------
-- INNATE/WORLD ---------------------
-- ---------------------------------------------------

T.Innate_Immobilize_Immunity        = GetString(SI_LUIE_SKILL_IMMOBILIZE_IMMUNITY_TP)
T.Innate_Dodge_Fatigue              = GetString(SI_LUIE_SKILL_DODGE_FATIGUE_TP)
T.Innate_Hidden                     = GetString(SI_LUIE_SKILL_HIDDEN_TP)
T.Innate_Invisible                  = GetString(SI_LUIE_SKILL_INVISIBLE_TP)
T.Innate_Sprint                     = GetString(SI_LUIE_SKILL_SPRINT_TP)
T.Innate_Gallop                     = GetString(SI_LUIE_SKILL_GALLOP_TP)
T.Innate_Block                      = GetString(SI_LUIE_SKILL_BLOCK_TP)
T.Innate_Resurrection_Immunity      = GetString(SI_LUIE_SKILL_RESURRECTION_IMMUNITY_TP)
T.Innate_Taunt                      = GetString(SI_LUIE_SKILL_TAUNT_TP)
T.Innate_Disguised                  = GetString(SI_LUIE_SKILL_DISGUISE_TP)
T.Innate_Battle_Spirit              = GetString(SI_LUIE_SKILL_BATTLE_SPIRIT_TP)
T.Innate_Recall_Penalty             = GetString(SI_LUIE_SKILL_RECALL_PENALTY_TP)
T.Innate_Ayleid_Well                = GetString(SI_LUIE_SKILL_AYLEID_WELL_TP)
T.Innate_Ayleid_Well_Fortified      = GetString(SI_LUIE_SKILL_AYLEID_WELL_FORTIFIED_TP)
T.Innate_Firelight                  = GetString(SI_LUIE_SKILL_FIRELIGHT_TP)

T.Innate_ESO_Plus                   = GetString(SI_LUIE_SKILL_ESO_PLUS_TP)

T.Boon_Lady = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_LADY)
T.Boon_Lover = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_LOVER)
T.Boon_Lord = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_LORD)
T.Boon_Mage = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_MAGE)
T.Boon_Tower = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_TOWER)
T.Boon_Atronach = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_ATRONACH)
T.Boon_Serpent = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_SERPENT)
T.Boon_Shadow = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_SHADOW)
T.Boon_Ritual = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_RITUAL)
T.Boon_Thief = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_THIEF)
T.Boon_Warrior = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_WARRIOR)
T.Boon_Apprentice = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_APPRENTICE)
T.Boon_Steed = GetString(SI_LUIE_SKILL_MUNDUS_BASIC_STEED)

-- ---------------------------------------------------
-- SEASONAL ---------------------
-- ---------------------------------------------------

T.Seasonal_Freezing = GetString(SI_LUIE_SKILL_SEASONAL_FREEZING)
T.Seasonal_Warm = GetString(SI_LUIE_SKILL_SEASONAL_WARM)

-- ---------------------------------------------------
-- CHAMPION ---------------------
-- ---------------------------------------------------

T.Champion_Phase                    = GetAbilityDescription(63852)
T.Champion_Reinforced               = GetAbilityDescription(64067)
T.Champion_Unchained                = GetAbilityDescription(59286)
T.Champion_Infusion                 = GetAbilityDescription(59582)
T.Champion_Revival                  = GetAbilityDescription(60427)
T.Champion_Determination            = GetAbilityDescription(59893)
T.Champion_Siphoner                 = GetAbilityDescription(92425)
T.Champion_Ensnare                  = GetAbilityDescription(60398)
T.Champion_Shadowstrike             = GetAbilityDescription(61426)
T.Champion_Foresight                = GetAbilityDescription(59526)
T.Champion_Vengeance_Charge         = GetAbilityDescription(63150)
T.Champion_Vengeance                = GetString(SI_LUIE_SKILL_VENGEANCE_TP)
T.Champion_Retaliation              = GetAbilityDescription(63104)
T.Champion_Opportunist              = GetAbilityDescription(63099)

-- ---------------------------------------------------
-- COMSUMABLES & ITEMS -------------------------------
-- ---------------------------------------------------

T.Item_Glyph_of_Crushing            = GetString(SI_LUIE_SKILL_GLYPH_CRUSHING_TP)
T.Item_Glyph_of_Hardening           = GetString(SI_LUIE_SKILL_GLYPH_HARDENING_TP)
T.Item_Glyph_of_Weakening           = GetString(SI_LUIE_SKILL_GLYPH_WEAKENING_TP)
T.Item_Glyph_of_Weapon_Damage       = GetString(SI_LUIE_SKILL_GLYPH_WEAPON_DAMAGE_TP)

T.Food_Crafted_Health               = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68235:309:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Food_Crafted_Magicka              = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68238:309:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Food_Crafted_Stamina              = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68241:309:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Food_Crafted_Health_Magicka       = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68244:310:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Food_Crafted_Health_Stamina       = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68247:310:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Food_Crafted_Magicka_Stamina      = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68250:310:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Food_Crafted_Triple               = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68254:311:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))

T.Food_Vendor_Health                = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:57637:308:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Food_Vendor_Magicka               = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:57630:134:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Food_Vendor_Stamina               = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71252:308:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Food_Cyrodilic_Field_Bar          = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71076:307:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Food_Cyrodilic_Field_Tack         = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71074:307:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Food_Cyrodilic_Field_Treat        = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71075:307:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))

T.Food_Crown_Crate_Meal             = string.gsub(select(3, GetItemLinkOnUseAbilityInfo('|H1:item:94437:123:1:0:0:0:0:0:0:0:0:0:0:0:1:0:0:1:0:0:0|h|h')), GetString(SI_LUIE_SKILL_REMOVE_TOOLTIP_SCALED_LEVEL), "")
T.Food_Crown_Meal                   = string.gsub(select(3, GetItemLinkOnUseAbilityInfo('|H1:item:64711:123:1:0:0:0:0:0:0:0:0:0:0:0:1:0:0:1:0:0:0|h|h')), GetString(SI_LUIE_SKILL_REMOVE_TOOLTIP_SCALED_LEVEL), "")

T.Drink_Crafted_Health              = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68257:309:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Drink_Crafted_Magicka             = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68260:309:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Drink_Crafted_Stamina             = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68263:309:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Drink_Crafted_Health_Magicka      = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68266:310:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Drink_Crafted_Health_Stamina      = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68269:310:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Drink_Crafted_Magicka_Stamina     = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68272:310:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))
T.Drink_Crafted_Triple              = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:68276:311:50:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h'))

T.Drink_Vendor_Health               = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:57642:134:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Drink_Vendor_Magicka              = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71250:308:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Drink_Vendor_Stamina              = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:57654:134:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Drink_Cyrodilic_Field_Tonic       = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71079:307:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Drink_Cyrodilic_Field_Brew        = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71077:307:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))
T.Drink_Cyrodilic_Field_Tea         = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71078:307:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))

T.Drink_Crown_Crate_Drink           = string.gsub(select(3, GetItemLinkOnUseAbilityInfo('|H1:item:94438:123:1:0:0:0:0:0:0:0:0:0:0:0:1:0:0:1:0:0:0|h|h')), GetString(SI_LUIE_SKILL_REMOVE_TOOLTIP_SCALED_LEVEL), "")
T.Drink_Crown_Drink                 = string.gsub(select(3, GetItemLinkOnUseAbilityInfo('|H1:item:64712:123:1:0:0:0:0:0:0:0:0:0:0:0:1:0:0:1:0:0:0|h|h')), GetString(SI_LUIE_SKILL_REMOVE_TOOLTIP_SCALED_LEVEL), "")
T.Drink_Double_Bloody_Mara          = string.gsub(select(3, GetItemLinkOnUseAbilityInfo('|H1:item:87699:6:1:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h')), GetString(SI_LUIE_SKILL_REMOVE_TOOLTIP_DOUBLE_BLOODY_MARA), "")
T.Drink_Hissmir                     = string.gsub(select(3, GetItemLinkOnUseAbilityInfo('|H1:item:101879:6:1:0:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:0|h|h')), GetString(SI_LUIE_SKILL_REMOVE_TOOLTIP_HISSMIR), GetString(SI_LUIE_SKILL_ADD_TOOLTIP_HISSMIR))

T.Experience_Psijic_Ambrosia        = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_HALF_HOUR_TP), "50")
T.Experience_Aetherial_Ambrosia     = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_HALF_HOUR_TP), "100")
T.Experience_Mythic_Aetherial_Ambrosia = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_HALF_HOUR_TP), "150")
T.Experience_Crown                  = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_HOUR_TP), "50", "2")
T.Experience_Gold_Coast             = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_HOUR_TP), "50", "1")
T.Experience_Major_Gold_Coast       = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_HOUR_TP), "100", "1")
T.Experience_Grand_Gold_Coast       = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_HOUR_TP), "150", "1")

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

function LUIE.ProcessTooltipType(input, tooltip)

    -- dummy func, maybe use

end


--[[ Possibly use these at some point

LUIE.DynamicTooltips = { }

local DT = LUIE.DynamicTooltips

DT[20299]                           = function()
                                                local skillType, skillIndex, abilityIndex = GetSpecificSkillAbilityKeysByAbilityId(45038)
                                                local _, _, _, _, _, purchased, _, rankIndex = GetSkillAbilityInfo(skillType, skillIndex, abilityIndex)
                                                local duration = 2
                                                if purchased then
                                                    duration = duration + rankIndex
                                                end

                                                local tooltip = zo_strformat(GetString(SI_LUIE_SKILL_HIDDEN_TP), duration)

                                                return tooltip
                                    end




if DT[abilityId] then
DT[abilityId]()

Q.QuestItemModifyOnAdd[itemId]()

]]



function GLOBALSCRIPT()

    local itemLink = '|H1:item:71252:308:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'

    local abilityDescription = select(3, GetItemLinkOnUseAbilityInfo('|H1:item:71252:308:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'))

    d(abilityDescription)

end


