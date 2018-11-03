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
T.Generic_Oblivion 					= GetString(SI_LUIE_SKILL_GENERIC_OBLIVION_TP)

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

T.Generic_Blind                     = GetString(SI_LUIE_SKILL_GENERIC_BLIND_TP)

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
-- EVENT ---------------------
-- ---------------------------------------------------

T.Event_Freezing = GetString(SI_LUIE_SKILL_EVENT_FREEZING)
T.Event_Warm = GetString(SI_LUIE_SKILL_EVENT_WARM)

-- ---------------------------------------------------
-- CHAMPION ---------------------
-- ---------------------------------------------------

T.Champion_Phase                    = GetString(SI_LUIE_SKILL_PHASE_TP)
T.Champion_Reinforced               = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_DAMAGE_SHIELD_TP), 3)
T.Champion_Unchained                = GetString(SI_LUIE_SKILL_UNCHAINED_TP)
T.Champion_Revival                  = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_DAMAGE_SHIELD_TP), 5)
T.Champion_Determination            = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_DAMAGE_SHIELD_TP), 15)
T.Champion_Siphoner                 = GetString(SI_LUIE_SKILL_SIPHONER_TP)
T.Champion_Ensnare                  = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_SNARE_PERCENTAGE_TP), 20)
T.Champion_Shadowstrike             = GetString(SI_LUIE_SKILL_GENERIC_INVISIBILITY_TP)
T.Champion_Foresight                = GetString(SI_LUIE_SKILL_FORESIGHT_TP)
T.Champion_Vengeance_Charge         = GetAbilityDescription(63150)
T.Champion_Vengeance                = GetString(SI_LUIE_SKILL_VENGEANCE_TP)
T.Champion_Retaliation              = GetString(SI_LUIE_SKILL_RETALIATION_TP)
T.Champion_Opportunist              = GetString(SI_LUIE_SKILL_OPPORTUNIST_TP)

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
T.Experience_Seasonal_Event         = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_HOUR_TP), "100", "2")
T.Experience_Seasonal_Pelinal       = zo_strformat(GetString(SI_LUIE_SKILL_EXPERIENCE_PELINAL), "2")

T.Event_Festival_Grog               = GetString(SI_LUIE_SKILL_EVENT_FESTIVAL_GROG)
T.Event_Festival_Mints              = GetString(SI_LUIE_SKILL_EVENT_FESTIVAL_MINTS)

-- Mementos
T.Memento_Almalexias_Lantern        = select(2, GetCollectibleInfo(341))
T.Memento_Bonesnap_Binding_Talisman = select(2, GetCollectibleInfo(348))
T.Memento_Discourse_Amaranthine     = select(2, GetCollectibleInfo(345))
T.Memento_Fetish_of_Anger           = select(2, GetCollectibleInfo(347))
T.Memento_Finvirs_Trinket           = select(2, GetCollectibleInfo(336))
T.Memento_Mystery_Meat              = select(2, GetCollectibleInfo(342))
T.Memento_Sanguines_Goblet          = select(2, GetCollectibleInfo(338))
T.Memento_Token_of_Root_Sunder      = select(2, GetCollectibleInfo(349))

-- Crown Mementos
T.Memento_Storm_Atronach_Aura       = select(2, GetCollectibleInfo(594))
T.Memento_Storm_Atronach_Transform  = select(2, GetCollectibleInfo(596))
T.Memento_Wild_Hunt_Leaf_Dance_Aura = select(2, GetCollectibleInfo(760))
T.Memento_Wild_Hunt_Transform       = select(2, GetCollectibleInfo(759))
T.Memento_Floral_Swirl_Aura         = select(2, GetCollectibleInfo(758))

T.Memento_Dwarven_Puzzle_Orb        = select(2, GetCollectibleInfo(1181))
T.Memento_Dwarven_Tonal_Forks       = select(2, GetCollectibleInfo(1182))
T.Memento_Dwemervamidium_Mirage     = select(2, GetCollectibleInfo(1183))
T.Memento_Swarm_of_Crows            = select(2, GetCollectibleInfo(1384))
T.Memento_Ghost_Lantern             = select(2, GetCollectibleInfo(5212))

-- ---------------------------------------------------
-- SETS ---------------------------------
-- ---------------------------------------------------

T.Set_Asylum_Bow                    = zo_strformat(GetString(SI_LUIE_SKILL_SET_ASYLUM_BOW), 45)
T.Set_Asylum_Bow_Perfect            = zo_strformat(GetString(SI_LUIE_SKILL_SET_ASYLUM_BOW), 50)
T.Set_Asylum_Destruction_Staff      = GetString(SI_LUIE_SKILL_SET_ASYLUM_DESTRUCTION_STAFF)
T.Set_Asylum_Destruction_Staff_P    = GetString(SI_LUIE_SKILL_SET_ASYLUM_DESTRUCTION_STAFF_PERFECT)
T.Set_Aslyum_Restoration_Staff      = zo_strformat(GetString(SI_LUIE_SKILL_SET_ASYLUM_RESTORATION_STAFF), 27)
T.Set_Aslyum_Restoration_Staff_P    = zo_strformat(GetString(SI_LUIE_SKILL_SET_ASYLUM_RESTORATION_STAFF), 30)
T.Set_Maelstrom_DW                  = GetString(SI_LUIE_SKILL_SET_MAELSTROM_DW)
T.Set_Maelstrom_1H                  = GetString(SI_LUIE_SKILL_SET_MAELSTROM_1H)
T.Set_Master_1H                     = GetString(SI_LUIE_SKILL_SET_MASTER_1H)
T.Set_Blackrose_1H                  = GetString(SI_LUIE_SKILL_SET_BLACKROSE_1H_TP)
T.Set_Blackrose_Destro_Staff        = GetString(SI_LUIE_SKILL_SET_BLACKROSE_DESTRO_TP)

T.Set_Balorgh                       = GetString(SI_LUIE_SKILL_SET_BALORGH)
T.Set_Blood_Spawn                   = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_ARMOR_SPELL_RESIST), 6)
T.Set_Bogdan_the_Nightflame         = GetString(SI_LUIE_SKILL_SET_BOGDAN)
T.Set_Chokethorn                    = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_HOT_TIME_XSEC_TP), 0.8, 4)
T.Set_Domihaus_Stamina_Buff         = GetString(SI_LUIE_SKILL_SET_DOMIHAUS_BUFF_STAMINA)
T.Set_Domihaus_Stamina_Damage       = GetString(SI_LUIE_SKILL_SET_DOMIHAUS_DAMAGE_STAMINA)
T.Set_Domihaus_Magicka_Buff         = GetString(SI_LUIE_SKILL_SET_DOMIHAUS_BUFF_MAGICKA)
T.Set_Domihaus_Magicka_Damage       = GetString(SI_LUIE_SKILL_SET_DOMIHAUS_DAMAGE_MAGICKA)
T.Set_Earthgore                     = GetString(SI_LUIE_SKILL_SET_EARTHGORE)
T.Set_Grothdarr                     = GetString(SI_LUIE_SKILL_SET_GROTHDARR)
T.Set_Iceheart                      = GetString(SI_LUIE_SKILL_SET_ICEHEART)
T.Set_Ilambris_Fire                 = zo_strformat(GetString(SI_LUIE_SKILL_SET_ILAMBRIS), GetString(SI_DAMAGETYPE3))
T.Set_Ilambris_Shock                = zo_strformat(GetString(SI_LUIE_SKILL_SET_ILAMBRIS), GetString(SI_DAMAGETYPE4))
T.Set_Lord_Warden_Ground            = GetString(SI_LUIE_SKILL_SET_LORD_WARDEN_GROUND)
T.Set_Lord_Warden_Buff              = GetString(SI_LUIE_SKILL_SET_LORD_WARDEN_BUFF)
T.Set_Malubeth                      = GetString(SI_LUIE_SKILL_SET_MALUBETH)
T.Set_Maw_of_the_Infernal           = GetString(SI_LUIE_SKILL_SET_MAW_OF_THE_INFERNAL)
T.Set_Molag_Kena_Overkill           = GetString(SI_LUIE_SKILL_SET_MOLAG_KENA_OVERKILL_TP)
T.Set_Molag_Kena                    = GetString(SI_LUIE_SKILL_SET_MOLAG_KENA_TP)
T.Set_Pirate_Skeleton               = GetString(SI_LUIE_SKILL_SET_PIRATE_SKELETON_TP)
T.Set_Sentinel_of_Rkugamz           = GetString(SI_LUIE_SKILL_SET_SENTINEL_OF_REKUGAMZ_TP)
T.Set_Shadowrend                    = GetString(SI_LUIE_SKILL_SET_SHADOWREND_TP)
T.Set_Spawn_of_Mephala              = GetString(SI_LUIE_SKILL_SET_SPAWN_OF_MEPHALA_TP)
-- TODO: Note disabled the TP below due to the damage not actually being part of the debuff as well. Probably should only combine tooltips on things like this if its a dot + snare for example. Might revisit.
--GetString(SI_LUIE_SKILL_SET_SPAWN_OF_MEPHALA_SNARE_TP) make sure to uncomment line in en.lua too
T.Set_Stormfist                     = GetString(SI_LUIE_SKILL_SET_STORMFIST_TP)
T.Set_Engine_Guardian_Health        = zo_strformat(GetString(SI_LUIE_SKILL_SET_ENGINE_GUARDIAN), GetString(SI_COMBATMECHANICTYPE_2))
T.Set_Engine_Guardian_Stamina       = zo_strformat(GetString(SI_LUIE_SKILL_SET_ENGINE_GUARDIAN), GetString(SI_COMBATMECHANICTYPE6))
T.Set_Engine_Guardian_Magicka       = zo_strformat(GetString(SI_LUIE_SKILL_SET_ENGINE_GUARDIAN), GetString(SI_COMBATMECHANICTYPE0))
T.Set_The_Troll_King                = GetString(SI_LUIE_SKILL_SET_THE_TROLL_KING_TP)
T.Set_Thurvokun                     = GetString(SI_LUIE_SKILL_SET_THURVOKUN_TP)
T.Set_Zaan                          = GetString(SI_LUIE_SKILL_SET_ZAAN_TP)

T.Set_Alessias_Bulwark              = GetString(SI_LUIE_SKILL_SET_ALESSIAS_BULWARK)
T.Set_Clever_Alchemist              = GetString(SI_LUIE_SKILL_SET_CLEVER_ALCHEMIST)
T.Set_Eternal_Hunt                  = GetString(SI_LUIE_SKILL_SET_ETERNAL_HUNT)
T.Set_Morkuldin                     = GetString(SI_LUIE_SKILL_SET_MORKULDIN)
T.Set_Tavas_Favor                   = GetString(SI_LUIE_SKILL_SET_TAVAS_FAVOR)
T.Set_Armor_Master                  = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_ARMOR_SPELL_RESIST), 10)
T.Set_Trials_Fire                   = zo_strformat(GetString(SI_LUIE_SKILL_SET_TRIAL_BY_FIRE), GetString(SI_DAMAGETYPE3))
T.Set_Trials_Shock                  = zo_strformat(GetString(SI_LUIE_SKILL_SET_TRIAL_BY_FIRE), GetString(SI_DAMAGETYPE4))
T.Set_Trials_Frost                  = zo_strformat(GetString(SI_LUIE_SKILL_SET_TRIAL_BY_FIRE), GetString(SI_DAMAGETYPE6))
T.Set_Trials_Poison                 = zo_strformat(GetString(SI_LUIE_SKILL_SET_TRIAL_BY_FIRE), GetString(SI_DAMAGETYPE11))
T.Set_Trials_Disease                = zo_strformat(GetString(SI_LUIE_SKILL_SET_TRIAL_BY_FIRE), GetString(SI_DAMAGETYPE10))
T.Set_Varens_Legacy                 = GetString(SI_LUIE_SKILL_SET_VARENS_LEGACY)
T.Set_Vampires_Kiss                 = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_HOT_TIME_XSEC_TP), 2, 6)
T.Set_Whitestrakes_Retribution      = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_DAMAGE_SHIELD_TP), 10)
T.Set_Mechanical_Acuity             = GetString(SI_LUIE_SKILL_SET_MECHANICAL_ACUITY)
T.Set_Adept_Rider                   = GetString(SI_LUIE_SKILL_SET_ADEPT_RIDER)

T.Set_Bahrahas_Curse                = GetString(SI_LUIE_SKILL_SET_BAHRAHAS_CURSE_TP)
T.Set_Way_of_Martial_Knowledge      = GetString(SI_LUIE_SKILL_SET_WAY_OF_MARTIAL_KNOWLEDGE_TP)
T.Set_Briarheart                    = GetString(SI_LUIE_SKILL_SET_BRIARHEART_TP)
T.Set_Senche                        = GetString(SI_LUIE_SKILL_SET_SENCHE_TP)
T.Set_Way_of_Air                    = GetString(SI_LUIE_SKILL_SET_GENERIC_WEP_SPELL_DAMAGE_TIME_TP)
T.Set_Unfathomable_Darknesss        = GetString(SI_LUIE_SKILL_SET_UNFATHOMABLE_DARKNESS_TP)
T.Set_Storm_Knight                  = GetString(SI_LUIE_SKILL_SET_STORM_KNIGHT_TP)
T.Set_Grace_of_Gloom                = GetString(SI_LUIE_SKILL_SET_GRACE_OF_GLOOM_TP)
T.Set_Draugrs_Rest                  = GetString(SI_LUIE_SKILL_SET_DRAUGRS_REST_TP)
T.Set_Overwhelming_Surge            = GetString(SI_LUIE_SKILL_SET_OVERWHELMING_SURGE_TP)
T.Set_Sanctuary                     = GetString(SI_LUIE_SKILL_SANCTUARY_TP)
T.Set_Shroud_of_the_Lich            = GetString(SI_LUIE_SKILL_SHROUD_OF_THE_LICH_TP)
T.Set_Noble_Duelist                 = GetString(SI_LUIE_SKILL_SET_NOBLE_DUELIST_TP)
T.Set_Worms_Raiment                 = GetString(SI_LUIE_SKILL_SET_WORMS_RAIMENT_TP)
T.Set_Moon_Hunter                   = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_SPELL_DAMAGE_DURATION), 6)
T.Set_Hircines_Veneer               = GetString(SI_LUIE_SKILL_SET_HIRCINES_VENEER_TP)
T.Set_Plague_Slinger                = GetString(SI_LUIE_SKILL_PLAGUE_SLINGER_TP)
T.Set_Storm_Master                  = GetString(SI_LUIE_SKILL_SET_STORM_MASTER_TP)
T.Set_Essence_Thief                 = GetString(SI_LUIE_SKILL_SET_ESSENCE_THIEF_TP)
T.Set_Blood_Moon_Scent              = GetString(SI_LUIE_SKILL_SET_BLOOD_SCENT)
T.Set_Blood_Moon_Frenzied           = GetString(SI_LUIE_SKILL_SET_FRENIZED)
T.Set_Ebon_Armory                   = GetString(SI_LUIE_SKILL_SET_EBON_ARMORY)
T.Set_Embershield                   = GetString(SI_LUIE_SKILL_SET_EMBERSHIELD)
T.Set_Hagravens_Garden              = GetString(SI_LUIE_SKILL_SET_HAGRAVENS_GARDEN)
T.Set_Jolting_Arms                  = GetString(SI_LUIE_SKILL_SET_JOLTING_ARMS)
T.Set_Leeching_Plate                = GetString(SI_LUIE_SKILL_SET_LEECHING_PLATE_TP)
T.Set_Handle_of_Mephala             = GetString(SI_LUIE_SKILL_SET_HAND_OF_MEPHALA_TP)
T.Set_Berserking_Warrior            = GetString(SI_LUIE_SKILL_SET_BERSERKING_WARRIOR_TP)
T.Set_Eternal_Immortal_Warrior      = GetString(SI_LUIE_SKILL_SET_ETERNAL_IMMORTAL_WARRIOR_TP)
T.Set_Destructive_Mage              = GetString(SI_LUIE_SKILL_SET_DESTRUCTIVE_MAGE_TP)
T.Set_Healing_Mage                  = GetString(SI_LUIE_SKILL_SET_HEALING_MAGE_TP)
T.Set_Twice_Fanged_Serpent          = GetString(SI_LUIE_SKILL_SET_TWICE_FANGED_SERPENT_TP)
T.Set_Alkosh                        = GetString(SI_LUIE_SKILL_SET_ALKOSH_TP)
T.Set_Lunar_Bastion                 = GetString(SI_LUIE_SKILL_SET_LUNAR_BASTION_TP)
T.Set_Vestment_of_Olorime           = GetString(SI_LUIE_SKILL_SET_VESTMENT_OF_OLORIME_TP)
T.Set_Mantle_of_Siroria             = GetString(SI_LUIE_SKILL_SET_MANTLE_OF_SIRORIA_TP)
T.Set_Sirorias_Boon                 = GetString(SI_LUIE_SKILL_SET_SIRORIAS_BOON_TP)
T.Set_Relequens                     = GetString(SI_LUIE_SKILL_SET_RELEQUENS_TP)
T.Set_Vanguards_Challenge           = GetString(SI_LUIE_SKILL_SET_VANGUARDS_CHALLENGE_TP)
T.Set_Galerions_Revenge             = GetString(SI_LUIE_SKILL_SET_GALERIONS_REVENGE_TP)
T.Set_Meritorius_Service            = GetString(SI_LUIE_SKILL_SET_MERITORIUS_SERVICE_TP)
T.Set_Phoenix                       = GetString(SI_LUIE_SKILL_SET_PHOENIX_TP)
T.Set_Soldier_of_Anguish            = GetString(SI_LUIE_SKILL_SET_SOLDIER_OF_ANGUISH_TP)
T.Set_Spell_Strategist              = GetString(SI_LUIE_SKILL_SET_SPELL_STRATEGIST_TP)
T.Set_Succession_Flame              = zo_strformat(GetString(SI_LUIE_SKILL_SET_SUCCESSION_TP), GetString(SI_DAMAGETYPE3))
T.Set_Succession_Shock              = zo_strformat(GetString(SI_LUIE_SKILL_SET_SUCCESSION_TP), GetString(SI_DAMAGETYPE4))
T.Set_Succession_Frost              = zo_strformat(GetString(SI_LUIE_SKILL_SET_SUCCESSION_TP), GetString(SI_DAMAGETYPE6))
T.Set_Para_Bellum                   = GetString(SI_LUIE_SKILL_SET_PARA_BELLUM_TP)
T.Set_Glorious_Defender             = GetString(SI_LUIE_SKILL_SET_GLORIOUS_DEFENDER_TP)
T.Set_Light_of_Cyrodiil             = GetString(SI_LUIE_SKILL_SET_CYRODIILS_LIGHT_TP)
T.Set_Morag_Tong                    = GetString(SI_LUIE_SKILL_SET_MORAG_TONG_TP)

T.Generic_Immunity                  = GetString(SI_LUIE_SKILL_SET_GENERIC_IMMUNITY_TP)
T.Generic_Snare_30                  = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_SNARE_PERCENTAGE_TP), 30)
T.Generic_Snare_50                  = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_SNARE_PERCENTAGE_TP), 50)
T.Generic_Snare_60                  = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_SNARE_PERCENTAGE_TP), 60)
T.Generic_Snare_70                  = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_SNARE_PERCENTAGE_TP), 70)
T.Generic_Damage_Shield_6_Seconds   = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_DAMAGE_SHIELD_TP), 6)
T.Generic_Damage_Shield_15_Seconds  = zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_DAMAGE_SHIELD_TP), 15)
T.Generic_Weapon_Damage_5_Seconds   = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_WEP_DAMAGE_TIME_TP), 5)
T.Generic_Weapon_Damage_10_Seconds  = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_WEP_DAMAGE_TIME_TP), 10)
T.Generic_Spell_Damage_6_Seconds    = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_SPELL_DAMAGE_TIME_TP), 6)
T.Generic_Spell_Damage_8_Seconds    = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_SPELL_DAMAGE_TIME_TP), 8)
T.Generic_Spell_Damage_30_Seconds   = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_SPELL_DAMAGE_TIME_TP), 30)
T.Generic_LA_HA_Damage_8_Seconds    = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_LA_HA_DAMAGE), 8)
T.Generic_LA_HA_Damage_10_Seconds    = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_LA_HA_DAMAGE), 10)
T.Generic_Phy_Spell_Resist_15_Seconds = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_ARMOR_SPELL_RESIST), 15)
T.Generic_Magicka_Recovery_10_Seconds = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_MAG_RECOVERY_TIME_TP), 10)
T.Generic_Magicka_Recovery_30_Seconds = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_MAG_RECOVERY_TIME_TP), 30)
T.Generic_HoT_1Sec_10Sec =              zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_HOT_TIME_1SEC_TP), 10)
T.Generic_HoT_1Sec_2Sec =              zo_strformat(GetString(SI_LUIE_SKILL_GENERIC_HOT_TIME_1SEC_TP), 2)
T.Generic_Weapon_Spell_Damage_15_Seconds = zo_strformat(GetString(SI_LUIE_SKILL_SET_GENERIC_WEP_SPELL_DAMAGE_TIME_TP), 15)

-- Player Skills

-- Dragonknight
T.Skill_Engulfing_Flames = GetString(SI_LUIE_SKILL_ENGULFING_FLAMES_TP)
T.Skill_Inferno_Base = GetAbilityDescription(28967)
T.Skill_Inferno_Active = GetString(SI_LUIE_SKILL_INFERNO_TP)
T.Skill_Flames_of_Oblivion_Base = GetAbilityDescription(32853)
T.Skill_Cauterize_Base = GetAbilityDescription(32881)
T.Skill_Cauterize_Active = GetString(SI_LUIE_SKILL_CAUTERIZE_TP)

--zo_strformat(GetString(SI_LUIE_SKILL_SET_CLEVER_ALCHEMIST), string.sub( GetAbilityDescription(75745):gsub("[^0-9]", ""), 0, -3) )

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


