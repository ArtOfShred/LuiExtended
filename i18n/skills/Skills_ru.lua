--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Skill names & Tooltips localization
-- Translation by: KiriX
local strings = {

    ----------------------------------------------------------------
    -- INNATE SKILLS -----------------------------------------------
    ----------------------------------------------------------------

    -- Mundus Stones
    SI_LUIE_SKILL_MUNDUS_BASIC_LADY =                    "Повышает ваши магическую и физическую сопротивляемости на |cFFFFFF2752|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_LOVER =                   "Повышает ваши магическую и физическую проникновение на |cFFFFFF2752|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_LORD =                    "Повышает ваш макс.запас Здоровья на |cFFFFFF2230|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_MAGE =                    "Повышает ваш макс.запас Магии на |cFFFFFF2028|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_TOWER =                   "Повышает ваш макс. Запас сил на |cFFFFFF2028|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_ATRONACH =                "Повышает ваше восстановление Магии на |cFFFFFF238|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_SERPENT =                 "Повышает ваше восстановление Запаса сил на |cFFFFFF238|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_SHADOW =                  "Повышает ваш критический урон на |cFFFFFF9|r%.",
    SI_LUIE_SKILL_MUNDUS_BASIC_RITUAL =                  "Повышает наносимое вами исцеление на |cFFFFFF10|r%.",
    SI_LUIE_SKILL_MUNDUS_BASIC_THIEF =                   "Повышает ваш рейтинг критического удара Оружием и Заклинаниями на |cFFFFFF1533|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_WARRIOR =                 "Повышает ваш урон от Оружия на |cFFFFFF238|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_APPRENTICE =              "Повышает ваш урон от Заклинаний на |cFFFFFF238|r.",
    SI_LUIE_SKILL_MUNDUS_BASIC_STEED =                   "Повышает вашу скорость передвижения на |cFFFFFF10|r% и восстановление Здоровья на |cFFFFFF238|r.",

    -- Player Innate
    SI_LUIE_SKILL_RECALL_PENALTY =                       "Штраф перемещения",
    SI_LUIE_SKILL_MOUNTED =                              "Верхом",
    SI_LUIE_SKILL_RESURRECTION_IMMUNITY =                "Иммун воскрешения",
    SI_LUIE_SKILL_SOUL_GEM_RESURRECTION =                "Воскрешение камнем душ",
    SI_LUIE_SKILL_STEALTH_STUN =                         "Стан из невидимости",
    SI_LUIE_SKILL_FALL_DAMAGE =                          "Урон от падения",
    SI_LUIE_SKILL_ABSORBING_SKYSHARD =                   "Поглощение небесного осколка",
    SI_LUIE_SKILL_RECEIVING_BOON =                       "Получение бонуса Мундуса",
    SI_LUIE_SKILL_MOUNT_SPRINT =                         "Галоп",
    SI_LUIE_SKILL_BLOCK_STUN =                           "Стан от блока",
    SI_LUIE_SKILL_AYLEID_WELL =                          "Айлейдский колодец",
    SI_LUIE_SKILL_AYLEID_WELL_TP =                       "Повышение здоровья на |cFFFFFF10|r% в течение |cFFFFFF10|r минут.",
    SI_LUIE_SKILL_AYLEID_WELL_FORTIFIED =                "Усиленный Айлейдский колодец",
    SI_LUIE_SKILL_AYLEID_WELL_FORTIFIED_TP =             "Повышение здоровья на |cFFFFFF10|r% в течение |cFFFFFF30|r минут.",
    SI_LUIE_SKILL_IMMOBILIZE_IMMUNITY_TP =               "Immune to immobilization effects for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SNARE_IMMOBILIZE_IMMUNITY_TP =         "Immune to snare and immobilization effects for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_DODGE_FATIGUE_TP =                     "Consecutive roll dodging costs |cFFFFFF33|r% more Stamina per stack for the next |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_HIDDEN_TP =                            "Крадётесь и сокрыты от чужих глаз.\n\nРасходуется Запас сил при движении.",
    SI_LUIE_SKILL_INVISIBLE_TP =                         "Сокрыты от чужих глаз магией или окружающей средой.",
    SI_LUIE_SKILL_SPRINT_TP =                            "Спринт, скорость передвижения увеличена на |cFFFFFF40|r%.\n\nРасходуется Запас сил при движении.",
    SI_LUIE_SKILL_GALLOP_TP =                            "Галоп, скорость передвижения увеличена на |cFFFFFF30|r%.\n\nРасходуется Запас сил ездового животного при движении.",
    SI_LUIE_SKILL_BLOCK_TP =                             "Блокируется атака, получаемый урон снижен и действует иммунитет к оглушающим и отбрасывающим эффектам .",
    SI_LUIE_SKILL_RESURRECTION_IMMUNITY_TP =             "Reviving. Immune to damage and all negative effects.", -- TODO: Translate
    SI_LUIE_SKILL_TAUNT_TP =                             "Спровоцирован. Этот противник фокусирует все атаки на вас.",
    SI_LUIE_SKILL_DISGUISE_TP =                          "Маскировка. Вы можете быть обнаружены часовыми или выполняя подозрительную деятельность.\n\nПолучение урона снимет вашу маскировку.",
    SI_LUIE_SKILL_BATTLE_SPIRIT_TP =                     "• Здоровье увеличено на |cFFFFFF5000|r\n• Получаемый урон, исцеление и щиты от урона уменьшены на |cFFFFFF50|r%\n• Дальность действия способностей действующих на расстоянии |cFFFFFF28|r метров и более увеличена на |cFFFFFF8|r",
    SI_LUIE_SKILL_RECALL_PENALTY_TP =                    "Вы недавно пользовались перемещением к дорожному святилищу и должно заплатить дополнительное золото, чтобы воспользоваться им вновь.",
    SI_LUIE_SKILL_BATTLEGROUND_DESERTER_TP =             "You left a Battleground match early and cannot queue again or earn Alliance points from any PvP sources.", -- TODO: Translate

    ----------------------------------------------------------------
    -- ITEM / CONSUMABLE TOOLTIPS ----------------------------------
    ----------------------------------------------------------------

    -- Glyphs
    SI_LUIE_SKILL_GLYPH_CRUSHING =                       "Crushing (Зачарование)",
    SI_LUIE_SKILL_GLYPH_DECREASE_HEALTH =                "Снижение здоровья",
    SI_LUIE_SKILL_GLYPH_HARDENING =                      "Hardening (Зачарование)",
    SI_LUIE_SKILL_GLYPH_WEAKENING =                      "Weakening (Зачарование)",
    SI_LUIE_SKILL_GLYPH_WEAPON_DAMAGE =                  "Урон от оружия (Зачарование)",
    SI_LUIE_SKILL_GLYPH_HARDENING_TP =                   "Absorbing damage for |cFFFFFF7|r seconds.",
    SI_LUIE_SKILL_GLYPH_WEAKENING_TP =                   "Reduce Weapon and Spell Damage for |cFFFFFF5|r seconds.",
    SI_LUIE_SKILL_GLYPH_WEAPON_DAMAGE_TP =               "Increase Weapon and Spell Damage for |cFFFFFF5|r seconds.", -- TODO: Translate this block

    -- Crafting Station Creation
    SI_LUIE_SKILL_CRAFTING_STATION_JEWELRY =             "Настройка Ювелирной станции",
    SI_LUIE_SKILL_CRAFTING_STATION_BLACKSMITH =          "Настройка Кузницы",
    SI_LUIE_SKILL_CRAFTING_STATION_CLOTHING =            "Настройка Портняжного станка",
    SI_LUIE_SKILL_CRAFTING_STATION_WOODWORK =            "Настройка Столярного верстака",

    -- Consumable / Food / Drink
    SI_LUIE_SKILL_POISON_STEALTH_DRAIN =                 "Яд скрытности",
    SI_LUIE_SKILL_POISON_CONSPICUOUS =                   "Яд обнаружения",
    SI_LUIE_SKILL_DRINK_INCREASE =                       "Повышение",
    SI_LUIE_SKILL_REMOVE_TOOLTIP_SCALED_LEVEL =          "Сила эффектов зависит от вашего уровня.", -- Note this needs to be an exact match to the description in Crown Crate food/drink items for it to be correctly removed in each localization.
    SI_LUIE_SKILL_REMOVE_TOOLTIP_DOUBLE_BLOODY_MARA =    "Если вы вампир, кровь, входящая в состав этого напитка, постепенно утоляет ваш голод.\nСила эффектов зависит от вашего уровня.", -- Must be exact match in each localization
    SI_LUIE_SKILL_REMOVE_TOOLTIP_HISSMIR =               "Этот напиток также дает вам понимание того, какая рыба водится в различных водоемах, и наделяет особым вниманием к местам рыбной ловли поблизости.\nСила эффектов зависит от вашего уровня.", -- Must be exact match in each localization
    SI_LUIE_SKILL_ADD_TOOLTIP_HISSMIR =                  "\n\nЭтот напиток также дает вам понимание того, какая рыба водится в различных водоемах, и наделяет особым вниманием к местам рыбной ловли поблизости.",
    SI_LUIE_SKILL_ESO_PLUS_TP =                          "Увеличивает получаемые Опыт, Золото и Вдохновение на |cffffff10|r%. Увеличивает скорость исследования особенностей на |cffffff10|r%.",

    -- Collectible
    SI_LUIE_SKILL_COLLECTIBLE_MYSTERY_MEAT =             "Mystery Meat",

    -- Experience
    SI_LUIE_SKILL_EXPERIENCE_HALF_HOUR_TP =              "Увеличивает получаемый опыт на |cffffff<<1>>|r% в течение |cffffff30|r минут.",
    SI_LUIE_SKILL_EXPERIENCE_HOUR_TP =                   "Увеличивает получаемый опыт на |cffffff<<1>>|r% в течение |cffffff<<2>>|r <<2[часа/часов]>>.",
    SI_LUIE_SKILL_EXPERIENCE_PELINAL =                   "Увеличивает получаемые Очки Альянса и опыт, получаемый за убийство игроков на |cffffff100|r% в течение |cffffff<<1>>|r <<1[часа/часов]>>.",

    -- Misc
    SI_LUIE_SKILL_FILLET_FISH =                          "Чистка рыбы",
    SI_LUIE_SKILL_COUNTERFEIT_PARDON_EDICT =             "Поддельный указ о помиловании",
    SI_LUIE_SKILL_LENIENCY_EDICT =                       "Указ о смягчении наказания",
    SI_LUIE_SKILL_GRAND_AMNESTY_EDICT =                  "Указ о большой амнистии",
    SI_LUIE_SKILL_REVELRY_PIE_TP =                       "Covered in pie! Delicious!.", -- TODO: Translate

    ----------------------------------------------------------------
    -- EVENT TOOLTIPS ----------------------------------------------
    ----------------------------------------------------------------

    SI_LUIE_SKILL_EVENT_FREEZING =                       "Вы замерзаете и скорость вашего передвижения замедлена. Найдите костёр, чтобы согреться.",
    SI_LUIE_SKILL_EVENT_WARM =                           "Вы прижимаетесь к ближайшему костру, чтобы согреться. Время замерзания сокращается на |cffffff10|r секунд каждую |cffffff1|r секунду.",
    SI_LUIE_SKILL_EVENT_FESTIVAL_GROG =                  "You are feeling a bit... disoriented.", -- TODO: Translate
    SI_LUIE_SKILL_EVENT_FESTIVAL_MINTS =                 "Вы ОЧЕНЬ замерзли.",

    ----------------------------------------------------------------
    -- MAJOR / MINOR EFFECTS ---------------------------------------
    ----------------------------------------------------------------

    -- Major / Minor Buffs
    SI_LUIE_SKILL_MINOR_RESOLVE_TP =                     "Повышает физическую сопротивляемость на |cffffff1320|r.",
    SI_LUIE_SKILL_MAJOR_RESOLVE_TP =                     "Повышает физическую сопротивляемость на |cffffff5280|r.",
    SI_LUIE_SKILL_MINOR_WARD_TP =                        "Повышает магическую сопротивляемость на |cffffff1320|r.",
    SI_LUIE_SKILL_MAJOR_WARD_TP =                        "Повышает магическую сопротивляемость на |cffffff5280|r.",
    SI_LUIE_SKILL_MINOR_FORTITUDE_TP =                   "Повышает восстановление здоровья на |cffffff10|r%.",
    SI_LUIE_SKILL_MAJOR_FORTITUDE_TP =                   "Повышает восстановление здоровья на |cffffff20|r%.",
    SI_LUIE_SKILL_MINOR_ENDURANCE_TP =                   "Повышает восстановление запаса сил на |cffffff10|r%.",
    SI_LUIE_SKILL_MAJOR_ENDURANCE_TP =                   "Повышает восстановление запаса сил на |cffffff20|r%.",
    SI_LUIE_SKILL_MINOR_INTELLECT_TP =                   "Повышает восстановление магии на |cffffff10|r%.",
    SI_LUIE_SKILL_MAJOR_INTELLECT_TP =                   "Повышает восстановление магии на |cffffff20|r%.",
    SI_LUIE_SKILL_MINOR_SORCERY_TP =                     "Повышает урон от заклинаний на |cffffff10|r%.",
    SI_LUIE_SKILL_MAJOR_SORCERY_TP =                     "Повышает урон от заклинаний на |cffffff20|r%.",
    SI_LUIE_SKILL_MINOR_PROPHECY_TP =                    "Повышает рейтинг критического удара заклинаниями на |cffffff1320|r.",
    SI_LUIE_SKILL_MAJOR_PROPHECY_TP =                    "Повышает рейтинг критического удара заклинаниями на |cffffff2191|r.",
    SI_LUIE_SKILL_MINOR_BRUTALITY_TP =                   "Повышает урон от оружия на |cffffff10|r%.",
    SI_LUIE_SKILL_MAJOR_BRUTALITY_TP =                   "Повышает урон от оружия на |cffffff20|r%.",
    SI_LUIE_SKILL_MINOR_SAVAGERY_TP =                    "Повышает рейтинг критического удара оружием на |cffffff1320|r.",
    SI_LUIE_SKILL_MAJOR_SAVAGERY_TP =                    "Повышает рейтинг критического удара оружием на |cffffff2191|r.",
    SI_LUIE_SKILL_MINOR_BERSERK_TP =                     "Повышает наносимый урон на |cffffff8|r%.",
    SI_LUIE_SKILL_MAJOR_BERSERK_TP =                     "Повышает наносимый урон на |cffffff25|r%.",
    SI_LUIE_SKILL_MINOR_FORCE_TP =                       "Повышает критический урон на |cffffff10|r%.",
    SI_LUIE_SKILL_MAJOR_FORCE_TP =                       "Повышает критический урон на |cffffff15|r%.",
    SI_LUIE_SKILL_MINOR_VITALITY_TP =                    "Повышает получаемое исцеление на |cffffff8|r%.",
    SI_LUIE_SKILL_MAJOR_VITALITY_TP =                    "Повышает получаемое исцеление на |cffffff30|r%.",
    SI_LUIE_SKILL_MINOR_MENDING_TP =                     "Повышает наносимое исцеление на |cffffff8|r%.",
    SI_LUIE_SKILL_MAJOR_MENDING_TP =                     "Повышает наносимое исцеление на |cffffff25|r%.",
    SI_LUIE_SKILL_MINOR_PROTECTION_TP =                  "Снижает получаемый урон на |cffffff8|r%.",
    SI_LUIE_SKILL_MAJOR_PROTECTION_TP =                  "Снижает получаемый урон на |cffffff30|r%.",
    SI_LUIE_SKILL_MINOR_EVASION_TP =                     "Снижает получаемый урон от атак по площади на |cffffff10|r%.",
    SI_LUIE_SKILL_MAJOR_EVASION_TP =                     "Снижает получаемый урон от атак по площади на |cffffff25|r%.",
    SI_LUIE_SKILL_MINOR_EXPEDITION_TP =                  "Повышает скорость передвижения на |cffffff10|r%.",
    SI_LUIE_SKILL_MAJOR_EXPEDITION_TP =                  "Повышает скорость передвижения на |cffffff30|r%.",
    SI_LUIE_SKILL_MAJOR_GALLOP_TP =                      "Повышает скорость передвижения верхом на |cffffff30|r%.",
    SI_LUIE_SKILL_MINOR_HEROISM_TP =                     "Даёт |cffffff1|r очков ульты каждые |cffffff1.5|r секунды.",
    SI_LUIE_SKILL_MAJOR_HEROISM_TP =                     "Даёт |cffffff3|r очков ульты каждые |cffffff1.5|r секунды.",
    SI_LUIE_SKILL_MINOR_TOUGHNESS_TP =                   "Повышает здоровье на |cffffff10|r%.",
    SI_LUIE_SKILL_MINOR_COURAGE_TP =                     "Повышает урон от оружия и заклинаний на |cffffff129|r.",
    SI_LUIE_SKILL_MAJOR_COURAGE_TP =                     "Повышает урон от оружия и заклинаний на |cffffff258|r.",

    -- Major / Minor Debuffs
    SI_LUIE_SKILL_MINOR_BREACH_TP =                      "Снижает магическую сопротивляемость на |cffffff1320|r.",
    SI_LUIE_SKILL_MAJOR_BREACH_TP =                      "Снижает магическую сопротивляемость на |cffffff5280|r.",
    SI_LUIE_SKILL_MINOR_FRACTURE_TP =                    "Снижает физическую сопротивляемость на |cffffff1320|r.",
    SI_LUIE_SKILL_MAJOR_FRACTURE_TP =                    "Снижает физическую сопротивляемость на |cffffff5280|r.",
    SI_LUIE_SKILL_MAJOR_FRACTURE_NPC_TP =                "Снижает физическую сопротивляемость на |cffffff4000|r.",
    SI_LUIE_SKILL_MINOR_VULNERABILITY_TP =               "Увеличивает получаемый урон на |cffffff8|r%.",
    SI_LUIE_SKILL_MAJOR_VULNERABILITY_TP =               "Увеличивает получаемый урон на |cffffff30|r%.",
    SI_LUIE_SKILL_MINOR_MAIM_TP =                        "Снижает наносимый урон на |cffffff15|r%.",
    SI_LUIE_SKILL_MAJOR_MAIM_TP =                        "Снижает наносимый урон на |cffffff30|r%.",
    SI_LUIE_SKILL_MINOR_DEFILE_TP =                      "Снижает получаемое исцеление и восстановление здоровья на |cffffff15|r%.",
    SI_LUIE_SKILL_MAJOR_DEFILE_TP =                      "Снижает получаемое исцеление и восстановление здоровья на |cffffff30|r%.",
    SI_LUIE_SKILL_MINOR_MAGICKASTEAL_TP =                "Восстанавливает |cffffff300|r магии каждую |cffffff1|r секунду, при получении урона.",
    SI_LUIE_SKILL_MINOR_LIFESTEAL_TP =                   "Восстанавливает |cffffff600|r здоровья каждую |cffffff1|r секунду, при получении урона.",
    SI_LUIE_SKILL_MINOR_ENERVATION_TP =                  "Снижает критический урон на |cffffff10|r%.",
    SI_LUIE_SKILL_MINOR_UNCERTAINTY_TP =                 "Снижает рейтинг критического удара оружием и заклинаниями на |cffffff657|r.",
    SI_LUIE_SKILL_MINOR_COWARDICE_TP =                   "Увеличивает стоимость абсолютной способности на |cffffff60|r%.",
    SI_LUIE_SKILL_MINOR_MANGLE_TP =                      "Снижает макс. здоровье на |cffffff10|r%.",
    SI_LUIE_SKILL_HINDRANCE_TP =                         "Снижает скорость передвижения на |cffffff40|r%.",

    -- Slayer / Aegis
    SI_LUIE_SKILL_MINOR_SLAYER_TP =                      "Ваши атаки наносят на |cffffff5|r% больше урона по противникам в Подземельях, Испытаниях и на Аренах.",
    SI_LUIE_SKILL_MAJOR_SLAYER_TP =                      "Ваши атаки наносят на |cffffff15|r% больше урона по противникам в Подземельях, Испытаниях и на Аренах.",
    SI_LUIE_SKILL_MINOR_AEGIS_TP =                       "Вы получаете на |cffffff5|r% меньше урона от противников в Подземельях, Испытаниях и на Аренах.",
    SI_LUIE_SKILL_MAJOR_AEGIS_TP =                       "Вы получаете на |cffffff15|r% меньше урона от противников в Подземельях, Испытаниях и на Аренах.",

    -- Empower
    SI_LUIE_SKILL_EMPOWER_TP =                           "Увеличивает урон от вашей следующей обычной атаки на |cffffff40|r%.",

    ----------------------------------------------------------------
    -- CHAMPION POINT SKILLS ---------------------------------------
    ----------------------------------------------------------------

    SI_LUIE_SKILL_PHASE_TP =                             "Повышает Физическую и Магическую сопротивляемости на |cFFFFFF660|r в течение |cFFFFFF3|r секунд.",
    SI_LUIE_SKILL_UNCHAINED_TP =                         "Снижает расход Запаса сил на вашу следующую способность, применённую в течение |cFFFFFF5|r секунд на |cFFFFFF80|r%.",
    SI_LUIE_SKILL_FORESIGHT_TP =                         "Снижает расход Магии на вашу следующую способность, применённую в течение |cFFFFFF7|r секунд на |cFFFFFF80|r%.",
    SI_LUIE_SKILL_RETALIATION_TP =                       "Ваша следующая Обычная атака, проведённая в течение |cFFFFFF7|r секунд наносит |cFFFFFF30|r% дополнительного урона.",
    SI_LUIE_SKILL_OPPORTUNIST_TP =                       "Ваша следующая способность, наносящая Физический урон, применённая в течение |cFFFFFF7|r секунд наносит |cFFFFFF15|r% дополнительного урона.",
    SI_LUIE_SKILL_SIPHONER_TP =                          "Снижает Здоровье, Магию и Запас сил, а также их восстановление на |cFFFFFF3|r секунд.",
    SI_LUIE_SKILL_VENGEANCE_TP =                         "Ваша следующая способность, расходующая магию, применённая в течение |cFFFFFF5|r секунд обязательно нанесёт Критический удар.",
    SI_LUIE_SKILL_VENGEANCE_CHARGE =                     "Месть",

    ----------------------------------------------------------------
    -- GENERIC / SHARED TOOLTIPS -----------------------------------
    ----------------------------------------------------------------

    -- Test Effect
    SI_LUIE_SKILL_TEST_TP =                              "Это тестовый эффект.",

    -- Damage over Time / Heal over Time
    SI_LUIE_SKILL_GENERIC_DOT_NO_TICK_TP =               "Afflicted with SUBSTRING over time for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_DOT_TP =                       "Afflicted with SUBSTRING every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_HOT_TP =                       "Healing every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_HOT_POTION_TP =                "Healing every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_HOT_CHANNEL_TP =               "Healing every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>> while the channel is maintained.",

    -- Ground over Time
    SI_LUIE_SKILL_GENERIC_GROUND_AOE_TP =                "Taking SUBSTRING every |cFFFFFF<<2>>|r <<2[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_GROUND_HEAL_TP =               "Healing every |cFFFFFF<<2>>|r <<2[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_GROUND_AOE_SNARE_TP =          "Taking SUBSTRING every |cFFFFFF<<2>>|r <<2[second/seconds]>> and Movement Speed reduced by |cFFFFFF<<3>>|r%.",

    -- Resistances
    SI_LUIE_SKILL_GENERIC_PHYSICAL_RESIST_TP =                   "Increase Physical Resistance for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_GENERIC_SPELL_RESIST_NO_DUR_TP =               "Increase Spell Resistance.",
    SI_LUIE_SKILL_GENERIC_PHY_SPELL_RESIST =                     "Повышает Физическую и Магическую сопротивляемости на |cffffff<<1>>|r секунд.",
    SI_LUIE_SKILL_GENERIC_PHY_SPELL_RESIST_NO_DUR_TP =           "Increase Physical and Spell Resistance.",
    SI_LUIE_SKILL_GENERIC_PHY_SPELL_RESIST_NO_DUR_VALUE_TP =     "Increase Physical and Spell Resistance by |cFFFFFF<<2>>|r.",

    SI_LUIE_SKILL_GENERIC_REDUCE_PHY_SPELL_RESIST_TP =           "Reduce Physical and Spell Resistance for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_GENERIC_REDUCE_PHY_SPELL_RESIST_NO_DUR_TP =    "Reduce Physical and Spell Resistance.",

    -- Resource Regeneration, Shields
    SI_LUIE_SKILL_GENERIC_HEALTH_RECOVERY_TP =           "Increase Health Recovery for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_GENERIC_MGK_REGEN_TP =                 "Restoring Magicka every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_MGK_REGEN_POTION_TP =          "Restoring Magicka every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_STAM_REGEN_TP =                "Restoring Stamina every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_STAM_REGEN_POTION_TP =         "Restoring Stamina every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_DAMAGE_SHIELD_NO_DUR_TP =      "Поглощение урона.",
    SI_LUIE_SKILL_GENERIC_DAMAGE_SHIELD_TP =             "Поглощение урона в течение |cFFFFFF<<1>>|r секунд.", -- TODO: End - Translate this Block

    -- Stealth / Detection
    SI_LUIE_SKILL_GENERIC_MARKED_TP =                    "Помечен на |cFFFFFF<<1>>|r секунд. Вы видны для противника, который пометил вас, даже если уходите в скрытность.",
    SI_LUIE_SKILL_GENERIC_REVEAL_TP =                    "Обнаружен на |cFFFFFF<<1>>|r секунд. Вы не можете уйти в невидимость.",
    SI_LUIE_SKILL_GENERIC_REVEAL_NO_DUR_TP =             "Revealed. You are unable to stealth.", -- TODO: Translate
    SI_LUIE_SKILL_GENERIC_INVISIBILITY_TP =              "Invisible for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_DETECTION_POTION_TP =          "Stealth Detection increased by |cffffff20|r meters for |cFFFFFF<<1>>|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_GENERIC_DETECTION_NPC_TP =             "Revealing nearby stealthed and invisible enemies.", -- TODO: Translate

    -- Crowd Control / Immunity
    SI_LUIE_SKILL_GENERIC_OFF_BALANCE_IMMUNITY_TP =      "Иммунитет к эффектам, которые выводят из равновесия и делают уязвимым.",
    SI_LUIE_SKILL_GENERIC_OFF_BALANCE_TP =               "Off Balance for |cFFFFFF<<1>>|r <<1[second/seconds]>>.", -- TODO: Translate this Block
    SI_LUIE_SKILL_GENERIC_SNARE_TP =                     "Movement Speed reduced by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_SNARE_NO_DUR_TP =              "Movement Speed reduced by |cFFFFFF<<2>>|r%.",
    SI_LUIE_SKILL_GENERIC_IMMOBILIZE_TP =                "Immobilized for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_IMMOBILIZE_NO_DUR_TP =         "Immobilized.",
    SI_LUIE_SKILL_GENERIC_STAGGER_TP =                   "Staggered.",
    SI_LUIE_SKILL_GENERIC_STUN_TP =                      "Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_STUN_NO_DUR_TP =               "Stunned.",
    SI_LUIE_SKILL_GENERIC_LEVITATE_TP =                  "Levitated for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_KNOCKBACK_TP =                 "Knocked back for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_KNOCKDOWN_TP =                 "Knocked down for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_FEAR_TP =                      "Feared for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_FEAR_NO_DUR_TP =               "Feared.",
    SI_LUIE_SKILL_GENERIC_SILENCE_TP =                   "Silenced for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_GENERIC_SILENCE_NO_DUR_TP =            "Silenced.", -- TODO: END - Translate this Block
    SI_LUIE_SKILL_GENERIC_BLIND_TP =                     "Ослеплён на |cFFFFFF<<1>>|r секунд. |cffffff100|r% шанс пропустить все атаки.",
    SI_LUIE_SKILL_GENERIC_CC_IMMUNITY_TP =               "Иммунитет к отбрасыванию и прочим ограничивающим эффектам на |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_GENERIC_SCARY_IMMUNITIES_TP =          "Immune to all crowd control and movement impairing effects.", -- TODO: Translate
    SI_LUIE_SKILL_GENERIC_FLYING_IMMUNITIES_TP =         "Immune to movement imparing effects.", -- TODO: Translate
    SI_LUIE_SKILL_SET_GENERIC_IMMUNITY_TP =              "Immune to damage and all negative effects for |cffffff<<1>>|r <<1[second/seconds]>>.", -- TODO: Translate
    SI_LUIE_SKILL_GENERIC_DISORIENT_TP =                 "Disoriented for |cffffff<<1>>|r <<1[second/seconds]>>.", -- TODO: Translate

    -- Ravage Potions / Poisons
    SI_LUIE_SKILL_GENERIC_RAVAGE_MAGICKA_POTION_TP =     "Увеличивает стоимость способностей, расходующих Магию на |cffffff60|r%.",
    SI_LUIE_SKILL_GENERIC_RAVAGE_STAMINA_POTION_TP =     "Увеличивает стоимость способностей, расходующих Запас сил на |cffffff60|r%.",
    SI_LUIE_SKILL_GENERIC_RAVAGE_MAGICKA_POISON_TP =     "Увеличивает стоимость способностей, расходующих Магию на |cffffff10|r%.",
    SI_LUIE_SKILL_GENERIC_RAVAGE_STAMINA_POISON_TP =     "Увеличивает стоимость способностей, расходующих Запас сил на |cffffff10|r.%",

    -- Generic Stat Buffs
    SI_LUIE_SKILL_SET_GENERIC_WEP_SPELL_DAMAGE_TIME_TP = "Увеличивает урон от Оружия и Заклинаний на |cffffff<<1>>|r секунд.",
    SI_LUIE_SKILL_SET_GENERIC_WEP_DAMAGE_TIME_TP       = "Увеличивает урон от Оружия на |cffffff<<1>>|r секунд.",
    SI_LUIE_SKILL_SET_GENERIC_SPELL_DAMAGE_TIME_TP     = "Увеличивает урон от Заклинаний на |cffffff<<1>>|r секунд.",
    SI_LUIE_SKILL_SET_GENERIC_LA_HA_DAMAGE =             "Ваши обычные и силовые атаки наносят дополнительный урон в течение |cffffff<<1>>|r секунд.",
    SI_LUIE_SKILL_SET_GENERIC_MAG_RECOVERY_TIME_TP     = "Увеличивает восстановление Магии на |cffffff<<1>>|r секунд.",

    SI_LUIE_SKILL_GENERIC_ENRAGE =                       "Increase damage done by |cFFFFFF<<2>>|r% for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_GENERIC_ENRAGE_NO_DUR =                "Increase damage done by |cFFFFFF<<2>>|r%.",
    SI_LUIE_SKILL_GENERIC_ENRAGE_DAMAGE_TAKEN_NO_DUR =   "Increase damage done by |cFFFFFF<<2>>|r% and increase damage taken by |cFFFFFF<<3>>|r%.",
    SI_LUIE_SKILL_GENERIC_ENRAGE_DAMAGE_REDUCE_NO_DUR =  "Increase damage done by cFFFFFF<<2>>|r% and reduce damage taken by |cFFFFFF<<3>>|r%.",

    ----------------------------------------------------------------
    -- CLASS SKILLS ------------------------------------------------
    ----------------------------------------------------------------

    -- Dragonknight Skills
    SI_LUIE_SKILL_SEETHING_FURY_TP =                     "Increase the damage of your next Molten Whip by |cffffff33|r% and your Weapon and Spell Damage by |cffffff125|r for |cffffff<<1>>|r seconds.\n\nThis effect can stack up to |cffffff3|r times.",
    SI_LUIE_SKILL_VENOMOUS_CLAW_TP =                     "Afflicted with Poison Damage every |cFFFFFF2|r seconds for |cffffff<<1>>|r seconds.\n\nDeals |cFFFFFF12|r% increased damage every |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_BURNING_EMBERS_TP =                    "Подвержен урону от Огня каждые |cFFFFFF2|r секунды в течение |cffffff<<1>>|r секунд.\n\nИсцеляет рыцаря-дракона на |cffffff75|r% от нанесённого урона по завершению действия эффекта.",
    SI_LUIE_SKILL_ENGULFING_FLAMES_TP =                  "Подвержен урону от Огня каждые |cFFFFFF2|r секунды в течение |cffffff<<1>>|r секунд.\n\nIncrease damage taken from Fire Damage attacks by |cffffff10|r%.",
    SI_LUIE_SKILL_ENGULFING_FLAMES_DUMMY_TP =            "Increase damage taken from Fire Damage attacks by |cffffff10|r%.",
    SI_LUIE_SKILL_INFERNO_TP =                           "Запускает в ближайшего противника огненный шар, наносящий урон от Огня  каждые |cffffff5|r секунд в течение |cffffff15|r секунд.",
    SI_LUIE_SKILL_FLAMES_OF_OBLIVION_TP =                "Launch a fireball at |cffffff2|r enemies, dealing Flame Damage every |cffffff5|r seconds for |cffffff15|r seconds.",
    SI_LUIE_SKILL_CAUTERIZE_TP =                         "Запускает в ближайшего союзника огненный шар, чтобы прижечь его раны, каждые |cffffff5|r секунды в течение |cffffff15|r секунд.",
    SI_LUIE_SKILL_DRAGONKIGHT_STANDARD_TP =              "Enemies within the radius of the standard take Flame Damage every |cffffff1|r second and have Major Defile applied to them.", -- TODO: Translate
    SI_LUIE_SKILL_STANDARD_OF_MIGHT_TP =                 "Увеличивает наносимый урон и снижает получаемый урон, пока находитесь в радиусе действия штандарта.",
    SI_LUIE_SKILL_SPIKED_ARMOR_TP =                      "Return Magic Damage to any enemy that uses a direct damage attack against you for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_HARDENED_ARMOR_TP =                    "Return Magic Damage to any enemy that uses a direct damage attack against you for |cffffff<<1>>|r seconds.\n\nAbsorbing damage for |cffffff6|r seconds.",
    SI_LUIE_SKILL_BURNING_TALONS_TP =                    "Afflicted with Flame Damage every |cFFFFFF1|r second and immobilized for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_PROTECTIVE_SCALE_TP =                  "Reduce damage taken from projectiles by |cffffff50|r% for |cffffff6|r seconds.",
    SI_LUIE_SKILL_PROTECTIVE_PLATE_TP =                  "Reduce damage taken from projectiles by |cffffff50|r% for |cffffff6|r seconds.\n\nImmune to snare and immobilization effects for |cffffff2|r seconds.",
    SI_LUIE_SKILL_DRAGON_FIRE_SCALE_TP =                 "Reduce damage taken from projectiles by |cffffff50|r% for |cffffff6|r seconds.\n\nWhen you are hit with a projectile, you retaliate by launching a fiery orb at the attacker that deals Flame Damage. This effect can occur once every half second.",
    SI_LUIE_SKILL_INHALE_TP =                            "After |cffffff2.5|r seconds, you exhale fire, dealing Flame Damage to enemies within |cFFFFFF8|r meters.", -- TODO: Translate
    SI_LUIE_SKILL_DRAW_ESSENCE_TP =                      "After |cffffff2.5|r seconds, you exhale fire, dealing Flame Damage to enemies within |cFFFFFF8|r meters and restoring |cffffff10|r% of the ability's cost for each enemy hit as Magicka.", -- TODO: Translate
    SI_LUIE_SKILL_MOLTEN_ARMAMENTS_TP =                  "Увеличивает урон полностью заряженных Силовых атак  на |cffffff40|r% в течение |cffffff<<1>>|r секунд.",
    SI_LUIE_SKILL_PETRIFY_STUN_TP =                      "Обращён в камень и оглушён на |cffffff<<1>>|r секунд. Вы не можете атаковать или двигаться во время оглушения.\n\nПо окончанию действия оглушения, получаете Магический урон.",
    SI_LUIE_SKILL_FOSSILIZE_STUN_TP =                    "Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen the stun ends, take Magic Damage and become immobilized for |cffffff3|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SHATTERING_ROCKS_STUN_TP =             "Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen the stun ends, take Magic Damage and your next attack used within |cffffff4|r seconds heals your target.", -- TODO: Translate
    SI_LUIE_SKILL_SHATTERING_ROCKS_TP =                  "Your next attack used within |cffffff<<1>>|r seconds heals your target.", -- TODO: Translate
    SI_LUIE_SKILL_ASH_CLOUD_TP =                         "Enemies in the ash cloud have their Movement Speed reduced by |cffffff70|r%, while you and allies are healed every |cffffff1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_ERUPTION_TP =                          "Enemies in the ash cloud have their Movement Speed reduced by |cffffff70|r% and take Flame Damage every |cffffff1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_MAGMA_ARMOR_TP =                       "Incoming damage is limited to |cffffff3|r% of your Max Health and nearby enemies take Flame Damage every |cffffff1|r second for |cffffff<<1>>|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_CORROSIVE_ARMOR_TP =                   "Incoming damage is limited to |cffffff3|r% of your Max Health and nearby enemies take Poison Damage every |cffffff1|r second for |cffffff<<1>>|r seconds.\n\nWhile active, your attacks ignore all Physical Resistance.", -- TODO: Translate

    -- Nightblade Skills
    SI_LUIE_SKILL_DEATH_STROKE_DEBUFF =                  "Увеличивает урон, получаемый от Клинка ночи на |cFFFFFF20|r% в течение |cFFFFFF6|r секунд.",
    SI_LUIE_SKILL_INCAPACITATING_STRIKE =                "Increase damage taken from the Nightblade by |cFFFFFF20|r% for |cFFFFFF6|r seconds.\n\nSilenced for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_SURPRISE_ATTACK_TP =                   "Reduce Physical Resistance by |cFFFFFF5|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SHADOWY_DISGUISE_TP =                  "Invisible for |cFFFFFF<<2>>|r seconds.\n\nYour next direct damage attack used within |cFFFFFF<<1>>|r seconds will always be a Critical Strike.", -- TODO: Translate
    SI_LUIE_SKILL_GRIM_FOCUS_TP =                        "For |cFFFFFF<<1>>|r seconds, hitting an enemy with |cFFFFFF5|r Light or Heavy Attacks changes this ability into Assassin's Will, allowing you to fire a single shot from a spectral bow for half cost at an enemy to deal Magic Damage.\n\nEach stack reduces damage taken by |cFFFFFF3|r%, persisting even after <<2>> fades as long as you remain in combat.\n\nStacks are lost when firing the spectral bow.",
    SI_LUIE_SKILL_RELENTLESS_FOCUS_TP =                  "For |cFFFFFF<<1>>|r seconds, hitting an enemy with |cFFFFFF5|r Light or Heavy Attacks changes this ability into Assassin's Scourge, allowing you to fire a single shot from a spectral bow for half cost at an enemy to deal Disease Damage.\n\nEach stack reduces damage taken by |cFFFFFF3|r%, persisting even after <<2>> fades as long as you remain in combat.\n\nStacks are lost when firing the spectral bow.",
    SI_LUIE_SKILL_GRIM_FOCUS_DEFENSE_TP =                "Reduce damage taken by |cFFFFFF3|r%, stacking up to |cFFFFFF5|r times.\n\nStacks are lost when firing the spectral bow or exiting combat.",
    SI_LUIE_SKILL_PATH_OF_DARKNESS_TP =                  "You and allies in the corridor of shadows gain Major Expedition for |cFFFFFF4|r seconds every |cFFFFFF1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_TWISTING_PATH_TP =                     "You and allies in the corridor of shadows gain Major Expedition for |cFFFFFF4|r seconds every |cFFFFFF1|r second, while enemies in the area take Magic Damage every |cFFFFFF1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_REFRESHING_PATH_TP =                   "You and allies in the corridor of shadows gain Major Expedition for |cFFFFFF4|r seconds, and heal every |cFFFFFF1|r second for |cFFFFFF2|r seconds.\n\nThis effect is reapplied every |cFFFFFF1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_MANIFESTATION_OF_TERROR_TP =           "Взрывается, когда близко подходит противник, призывая тёмного духа, который пугает до |cFFFFFF6|r противников на |cFFFFFF4|r секунды.",
    SI_LUIE_SKILL_SUMMON_SHADE_TP =                      "Ваша теневая копия сражается на вашей стороне в течение |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_SHADOW_IMAGE_TP =                      "Ваша теневая копия стоит на месте и атакует противников на расстоянии в течение |cFFFFFF<<1>>|r секунд.\n\nПока тень призвана, вы можете активировать способность снова, чтобы переместиться к тени.",
    SI_LUIE_SKILL_CORROSIVE_SPIN_TP =                    "Corrosive Spin",
    SI_LUIE_SKILL_HIDDEN_REFRESH_TP =                    "Invisible, healing every |cFFFFFF0.5|r seconds, and Movement Speed increased by |cFFFFFF70|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_CONSUMING_DARKNESS_TP =                "Enemies in the ring of shadow have their Movement Speed reduced by |cFFFFFF70|r%, while you and allies gain Major Protection.\n\nAllies in the area can activate the |cFFFFFFHidden Refresh|r synergy.", -- TODO: Translate
    SI_LUIE_SKILL_BOLSTERING_DARKNESS_TP =               "Enemies in the ring of shadow have their Movement Speed reduced by |cFFFFFF70|r%, while you and allies gain Major Protection in the ring and even after leaving it.\n\nAllies in the area can activate the |cFFFFFFHidden Refresh|r synergy.", -- TODO: Translate
    SI_LUIE_SKILL_VEIL_OF_BLADES_TP =                    "Enemies in the ring of shadow have their Movement Speed reduced by |cFFFFFF70|r% and take Magic Damage every |cFFFFFF1|r second, while you and allies gain Major Protection.\n\nAllies in the area can activate the |cFFFFFFHidden Refresh|r synergy.", -- TODO: Translate
    SI_LUIE_SKILL_MALEVOLENT_OFFERING_TP =               "Высасывает здоровье каждую |cFFFFFF1|r секунду в течение |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_CRIPPLE_TP =                           "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds.\n\nMovement Speed reduced by |cFFFFFF<<2>>|r% for |cFFFFFF4|r seconds.",
    SI_LUIE_SKILL_CRIPPLING_GRASP_TP =                   "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds.\n\nMovement Speed reduced by |cFFFFFF30|r% for |cFFFFFF4|r seconds.\n\nImmobilized for |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_SIPHONING_STRIKES_TP =                 "Ваши обычные и силовые атаки исцеляют вас в течение |cFFFFFF20|r секунд. Полностью заряженная силовая атака исцеляет в два раза больше.",
    SI_LUIE_SKILL_LEECHING_STRIKES_TP =                  "Ваши обычные и силовые атаки исцеляют вас и восстанавливают Запас сил в течение |cFFFFFF20|r секунд. Полностью заряженная силовая атака восстанавливает в два раза больше ресурсов.\n\nВы восстанавливаете дополнительно до |cFFFFFF4270|r Запаса сил по истечению эффекта, в зависимости от времени действия Leeching Strikes.",
    SI_LUIE_SKILL_SIPHONING_ATTACKS_TP =                 "Ваши обычные и силовые атаки исцеляют вас и восстанавливают Магию в течение |cFFFFFF20|r секунд. Полностью заряженная силовая атака восстанавливает в два раза больше ресурсов.\n\nВы восстанавливаете дополнительно до |cFFFFFF4270|r Магии по истечению эффекта, в зависимости от времени действия Siphoning Attacks.",
    SI_LUIE_SKILL_SOUL_TETHER_TP =                       "Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF8|r seconds.\n\nStunned for |cFFFFFF4|r seconds.",
    SI_LUIE_SKILL_REFRESHING_PATH_GROUND =               "Healing every |cFFFFFF1|r second.\n\nThe effect persists for |cFFFFFF2|r seconds after leaving the path.",

    -- Sorcerer
    SI_LUIE_SKILL_PERSISTENCE =                          "Reduce the cost of your next Magicka or Stamina ability used within |cFFFFFF4|r seconds by |cFFFFFF<<1>>|r%.", -- TODO: Translate
    SI_LUIE_SKILL_CRYSTAL_FRAGMENTS_TP =                 "Ваше следующее применение Crystal Fragments в течение |cFFFFFF<<1>>|r секунд происходит мгновенно, наносит на |cFFFFFF20|r% больше урона, и расходует на |cFFFFFF50|r% меньше Магии.",
    SI_LUIE_SKILL_SHATTERING_PRISON_TP =                 "Immobilized for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThe shards deal Magic Damage when the effect ends.", -- TODO: Translate
    SI_LUIE_SKILL_RUNE_CAGE_TP =                         "Imprisoned in a sphere of dark magic and stunned for |cFFFFFF<<1>>|r seconds.\n\nDeals Magic Damage if the stun lasts the full duration.", -- TODO: Translate
    SI_LUIE_SKILL_DEFENSIVE_RUNE_TP =                    "Следующий противник, который атакует вас, окажется заперт в тесную сферу тёмной магии, оглушающую вскоре его на |cFFFFFF3|r секунды.",
    SI_LUIE_SKILL_DAEDRIC_MINES_TP =                     "Взрывается, когда близко подходит противник, нанося Магический урон и обездвиживая его на |cFFFFFF1.5|r секунды.",
    SI_LUIE_SKILL_NEGATE_MAGIC_TP =                      "Enemies in the globe are stunned.\n\nEnemy players will be silenced rather than stunned.", -- TODO: Translate
    SI_LUIE_SKILL_SUPPRESSION_FIELD_TP =                 "Enemies in the globe are stunned and take Magic Damage every |cFFFFFF0.5|r seconds.\n\nEnemy players will be silenced rather than stunned.", -- TODO: Translate
    SI_LUIE_SKILL_ABSORPTION_FIELD_TP =                  "Enemies in the globe are stunned, while you and allies are healed every |cFFFFFF0.5|r seconds.\n\nEnemy players will be silenced rather than stunned.", -- TODO: Translate
    SI_LUIE_SKILL_UNSTABLE_FAMILIAR_TP =                 "Unstable Familiar сражается на вашей стороне. Нестабильный прислужник останется, пока не будет убит или отозван.",
    SI_LUIE_SKILL_UNSTABLE_CLANNFEAR_TP =                "Unstable Clannfear сражается на вашей стороне. Нестабильный кланфир останется, пока не будет убит или отозван.",
    SI_LUIE_SKILL_VOLATILE_FAMILIAR_TP =                 "Volatile Familiar сражается на вашей стороне. Взрывной прислужник останется, пока не будет убит или отозван.",
    SI_LUIE_SKILL_FAMILIAR_DAMAGE_PULSE_SELF_TP =        "Your familiar is pulsing waves of unstable electricity, dealing Shock Damage to nearby enemies every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_FAMILIAR_DAMAGE_PULSE_TP =             "Pulsing waves of unstable electricity, dealing Shock Damage to nearby enemies every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_FAMILIAR_DAMAGE_PULSE_SELF_STUN_TP =   "Your familiar is pulsing waves of volatile electricity, dealing Shock Damage to nearby enemies every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nThe final pulse will stun all enemies hit for |cFFFFFF3|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_FAMILIAR_DAMAGE_PULSE_STUN_TP =        "Pulsing waves of volatile electricity, dealing Shock Damage to nearby enemies every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nThe final pulse will stun all enemies hit for |cFFFFFF3|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_UNSTABLE_PULSE =                       "Нестабильное пульсирование",
    SI_LUIE_SKILL_VOLATILE_PULSE =                       "Переменное пульсирование",
    SI_LUIE_SKILL_DAEDRIC_CURSE_TP =                     "After |cFFFFFF6|r seconds the rune detonates, dealing Magic Damage to you and nearby allies.", -- TODO: Translate
    SI_LUIE_SKILL_DAEDRIC_PREY_TP =                      "After |cFFFFFF6|r seconds the rune detonates, dealing Magic Damage to you and nearby allies.\n\nWhile the curse is active, the Sorcerer's pets deal an additional |cFFFFFF55|r% damage to you.", -- TODO: Translate
    SI_LUIE_SKILL_HAUNTING_CURSE_TP =                    "After |cFFFFFF3.5|r seconds the rune detonates, dealing Magic Damage and splashing to nearby allies.\n\nThe curse will apply a second time, detonating again after |cFFFFFF8.5|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_WINGED_TWILIGHT_TP =                   "Winged Twilight сражается на вашей стороне. Крылатый сумрак останется, пока не будет убит или отозван.",
    SI_LUIE_SKILL_TWILIGHT_TORMENTOR_TP =                "Twilight Tormentor сражается на вашей стороне. Сумрак-мучитель останется, пока не будет убит или отозван.",
    SI_LUIE_SKILL_TWILIGHT_MATRIARCH_TP =                "Twilight Matriarch сражается на вашей стороне. Сумрак-матриарх останется, пока не будет убит или отозван.",
    SI_LUIE_SKILL_TORMENTOR_DAMAGE_BOOST_SELF_TP =       "Increase Twilight Tormentor damage against enemies above |cFFFFFF50|r% Health by |cFFFFFF53|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_TORMENTOR_DAMAGE_BOOST_TP =            "Increase damage against enemies above |cFFFFFF50|r% Health by |cFFFFFF53|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_BOUND_ARMOR_TP =                       "Увеличивает на |cFFFFFF36|r% блокируемый урон на |cFFFFFF3|r секунды.",
    SI_LUIE_SKILL_ATRONACH_ZAP_TP =                      "Afflicted with Shock Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.", -- TODO: Translate this Block
    SI_LUIE_SKILL_STORM_ATRONACH_TP =                    "An immobile storm atronach zaps the closest enemy, dealing Shock Damage every |cFFFFFF1|r second.\n\nAn ally near the atronach can activate the |cFFFFFFCharged Lightning|r synergy.",
    SI_LUIE_SKILL_CHARGED_ATRONACH_TP =                  "An immobile storm atronach zaps the closest enemy, dealing Shock Damage every |cFFFFFF1|r second, and periodically deals Shock Damage to enemies around it.\n\nAn ally near the atronach can activate the |cFFFFFFCharged Lightning|r synergy.",
    SI_LUIE_SKILL_MAGES_FURY_TP =                        "Falling below |cFFFFFF20%|r Health causes an explosion, dealing Shock Damage to you and nearby allies.",
    SI_LUIE_SKILL_ENDLESS_FURY_TP =                      "Falling below |cFFFFFF20%|r Health causes an explosion, dealing Shock Damage to you and nearby allies.\n\nRestore Magicka to the Sorcerer on death.",
    SI_LUIE_SKILL_LIGHTNING_FORM_TP =                    "Enemies within |cFFFFFF5|r meters take Shock Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_HURRICANE_TP =                         "Enemies within |cFFFFFF5|r meters take Physical Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nThe winds grow in damage and size, increasing up to |cFFFFFF150|r% more damage and up to |cFFFFFF9|r meters in size.",
    SI_LUIE_SKILL_LIGHTNING_SPLASH_TP =                  "Enemies standing in the storm energy take Shock Damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_SURGE_TP =                             "Dealing a Critical Strike heals you. This effect can occur once every |cFFFFFF1|r second.", -- TODO: Translate this Block
    SI_LUIE_SKILL_BOLT_ESCAPE_FATIGUE_TP =               "Consecutive Bolt Escape casts cost |cFFFFFF50|r% more Magicka per stack for the next |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_INTERCEPT_TP =                         "Заклинания, направленные в вас, будут поглощены |cFFFFFFBall of Lightning|r.",
    SI_LUIE_SKILL_OVERLOAD_TP =                          "Обычные атаки заменены шаровыми молниями, наносящими урон от Электричества, а Силовые атаки сжигают противников уроном от Электричества в радиусе от атакуемой цели.\n\nАтаки расходуют очки абсолютной способности, пока они не закончатся или пока способность не будет отключена.",
    SI_LUIE_SKILL_ENERGY_OVERLOAD_TP =                   "Обычные атаки заменены шаровыми молниями, наносящими урон от Электричества, а Силовые атаки сжигают противников уроном от Электричества в радиусе от атакуемой цели.\n\nОбычные и Силовые атаки восстанавливают Магию.\n\nАтаки расходуют очки абсолютной способности, пока они не закончатся или пока способность не будет отключена.",
    SI_LUIE_SKILL_SUPPRESSION_FIELD_STUN =               "Stunned and taking Magic Damage every |cFFFFFF0.5|r seconds.",
    SI_LUIE_SKILL_SUPPRESSION_FIELD_SILENCE =            "Silenced and taking Magic Damage every |cFFFFFF0.5|r seconds.",

    -- Templar
    SI_LUIE_SKILL_SPEAR_SHARDS_TP =                      "Enemies in the radius of the spear take Magic Damage every |cFFFFFF1|r second.\n\nAn ally near the spear can activate the |cFFFFFFBlessed Shards|r synergy.", -- TODO: Translate this Block
    SI_LUIE_SKILL_LUMINOUS_SHARDS_TP =                   "Enemies in the radius of the spear take Magic Damage every |cFFFFFF1|r second.\n\nAn ally near the spear can activate the |cFFFFFFHoly Shards|r synergy.",
    SI_LUIE_SKILL_BLAZING_SHIELD_TP =                    "Absorbing damage for |cFFFFFF<<1>>|r seconds.\n\nWhen the shield expires it explodes outward, dealing |cFFFFFF38|r% of the damage it absorbed as Magic Damage to enemies within |cFFFFFF5|r meters.",
    SI_LUIE_SKILL_RADIAL_SWEEP_TP =                      "Enemies within |cFFFFFF8|r meters take Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_EMPOWERING_SWEEP_TP =                  "Enemies within |cFFFFFF8|r meters take Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nWhile this ability is active you gain |cFFFFFFEmpower|r.",
    SI_LUIE_SKILL_SUN_FIRE_TP =                          "Afflicted with Flame Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nMovement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<2>>|r seconds.",
    SI_LUIE_SKILL_SUN_FIRE_SNARE_TP =                    "Afflicted with Flame Damage every |cFFFFFF2|r seconds for |cFFFFFF<<2>>|r seconds.\n\nMovement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SOLAR_BARRAGE_TP =                     "Enemies within |cFFFFFF8|r meters take Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nWhile this ability is active you gain |cFFFFFFEmpower|r.",
    SI_LUIE_SKILL_BACKLASH_TP =                          "|cFFFFFF20|r% of all damage taken for the next |cFFFFFF<<1>>|r seconds will be copied and released as Magic Damage when the effect ends.",
    SI_LUIE_SKILL_PURIFYING_LIGHT_TP =                   "|cFFFFFF20|r% of all damage taken for the next |cFFFFFF<<1>>|r seconds will be copied and released as Magic Damage when the effect ends.\n\nWhen the effect ends, a pool of sunlight remains attached to you, healing the Templar and their allies if they are nearby every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.", -- TODO: Translate this Block
    SI_LUIE_SKILL_PURIFYING_LIGHT_HOT_TP =               "Исцеляет ближайших врагов каждые |cFFFFFF2|r секунды в течение |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_POWER_OF_THE_LIGHT_TP =                "|cFFFFFF20|r% of all damage taken for the next |cFFFFFF<<1>>|r seconds will be copied and released as Physical Damage when the effect ends.", -- TODO: Translate this Block
    SI_LUIE_SKILL_ECLIPSE_TP =                           "Take Magic Damage each time you use a direct damage attack for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_TOTAL_DARK_TP =                        "Take Magic Damage and heal the Templar each time you use a direct damage attack for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_UNSTABLE_CORE_TP =                     "Take Magic Damage each time you use a direct damage attack for |cFFFFFF<<1>>|r seconds.\n\nAfter |cFFFFFF<<1>>|r seconds, the magnetic energy explodes, dealing Magic Damage to you and nearby allies.",
    SI_LUIE_SKILL_RADIANT_DESTRUCTION_TP =               "Afflicted with Magic Damage every |cFFFFFF0.75|r seconds for |cFFFFFF<<1>>|r seconds. Deals up to |cFFFFFF480|r% more damage if you are below |cFFFFFF50|r% Health.",
    SI_LUIE_SKILL_NOVA_TP =                              "Enemies in the nova take Magic Damage every |cFFFFFF1|r second and have Major Maim applied to them.\n\nAn ally near the fragment can activate the |cFFFFFFSupernova|r synergy.",
    SI_LUIE_SKILL_SOLAR_PRISON_TP =                      "Enemies in the nova take Magic Damage every |cFFFFFF1|r second and have Major Maim applied to them.\n\nAn ally near the fragment can activate the |cFFFFFFGravity Crush|r synergy.",
    SI_LUIE_SKILL_SOLAR_DISTURBANCE_TP =                 "Enemies in the nova take Magic Damage every |cFFFFFF1|r second and have Major Maim applied to them.\n\nMajor Maim persists on enemies who leave the area for |cFFFFFF<<2>>|r seconds.\n\nAn ally near the fragment can activate the |cFFFFFFSupernova|r synergy.",
    SI_LUIE_SKILL_CLEANSING_RITUAL_TP =                  "You and allies in the area are healed every |cFFFFFF2|r seconds.\n\nAllies in the area can activate the |cFFFFFFPurify|r synergy.",
    SI_LUIE_SKILL_CLEANSING_RITUAL_RETRIBUTION_TP =      "You and allies in the area are healed every |cFFFFFF2|r seconds, while enemies take Magic Damage every |cFFFFFF2|r seconds.\n\nAllies in the area can activate the |cFFFFFFPurify|r synergy.",
    SI_LUIE_SKILL_RITE_OF_PASSAGE_TP =                   "Healing you and allies within |cFFFFFF20|r meters every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.", -- TODO: Translate

    -- Warden
    SI_LUIE_SKILL_BOND_WITH_NATURE =                     "Bond with Nature",
    SI_LUIE_SKILL_SCORCH_TP =                            "Через |cFFFFFF3|r секунды, наносит Магический урон противникам перед вами на расстоянии до |cFFFFFF20|r метров.",
    SI_LUIE_SKILL_SUB_ASSAULT_TP =                       "Через |cFFFFFF3|r секунды, наносит Физический урон и накладывает Major Fracture на |cFFFFFF5|r секунд противникам перед вами на расстоянии до |cFFFFFF20|r метров.",
    SI_LUIE_SKILL_DEEP_FISSURE_TP =                      "Через |cFFFFFF3|r секунды, наносит Магический урон и накладывает Major Breach на |cFFFFFF5|r секунд противникам перед вами на расстоянии до |cFFFFFF20|r метров.",
    SI_LUIE_SKILL_FETCHER_INFECTION_BONUS_DAMAGE_TP =    "Ваше следующее применение Fetcher Infection нанесёт на |cFFFFFF50|r% больше урона.",
    SI_LUIE_SKILL_GROWING_SWARM_TP =                     "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends, the fetcherflies infect up to |cFFFFFF6|r nearby allies.", -- TODO: Translate
    SI_LUIE_SKILL_BETTY_NETCH_TP =                       "Восстанавливает |cFFFFFF4800|r Магии в течение |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_BLUE_BETTY_TP =                        "Восстанавливает |cFFFFFF5376|r Магии в течение |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_BULL_NETCH_TP =                        "Восстанавливает |cFFFFFF5376|r Запаса сил в течение |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_FERAL_GUARDIAN_TP =                    "На вашей стороне сражается гризли. Гризли остаётся, пока не будет убит или отозван.\n\nВы можете активировать Guardian's Wrath за |cFFFFFF75|r очков ульты, чтобы медведь нанёс сильный удар противнику, наносящий Магический урон.",
    SI_LUIE_SKILL_ETERNAL_GUARDIAN_TP =                  "На вашей стороне сражается гризли. Гризли остаётся, пока не будет убит или отозван.\n\nРаз в минуту гризли автоматически возрождается снова, если будет убит.\n\nВы можете активировать Guardian's Wrath за |cFFFFFF75|r очков ульты, чтобы медведь нанёс сильный удар противнику, наносящий Магический урон.",
    SI_LUIE_SKILL_WILD_GUARDIAN_TP =                     "На вашей стороне сражается гризли. Гризли остаётся, пока не будет убит или отозван.\n\nВы можете активировать Guardian's Savagery за |cFFFFFF75|r очков ульты, чтобы медведь нанёс сильный удар противнику, наносящий Физический урон.",
    SI_LUIE_SKILL_GUARDIANS_WRATH_TP =                   "Цель атаки Guardian's Wrath.",
    SI_LUIE_SKILL_GUARDIANS_SAVAGERY_TP =                "Цель атаки Guardian's Savagery.",
    SI_LUIE_SKILL_ETERNAL_GUARDIAN_COOLDOWN_TP =         "Ваш медведь только что был возрождён и не может снова возродиться автоматически.",
    SI_LUIE_SKILL_HEALING_SEED_TP =                      "After |cFFFFFF6|r seconds, heals you and allies in the area.\n\nAn ally within the field can activate the |cFFFFFFHarvest|r synergy.", -- TODO: Translate
    SI_LUIE_SKILL_BUDDING_SEEDS_TP =                     "After |cFFFFFF6|r seconds, heals you and allies in the area.\n\nWhile the field grows, you can activate this ability again to cause it to instantly bloom.\n\nAn ally within the field can activate the |cFFFFFFHarvest|r synergy.", -- TODO: Translate
    SI_LUIE_SKILL_CORRUPTING_POLLEN_TP =                 "After |cFFFFFF6|r seconds, heals you and allies in the area.\n\nEnemies who enter the field are afflicted with Major Defile.\n\nAn ally within the field can activate the |cFFFFFFHarvest|r synergy.",
    SI_LUIE_SKILL_LIVING_VINES_TP =                      "Исцеляет вас, когда вы получаете урон, действует в течение |cFFFFFF<<1>>|r секунд. Эффект может срабатывать раз в |cFFFFFF1|r секунду.",
    SI_LUIE_SKILL_LEECHING_VINES_TP =                    "Исцеляет вас, когда вы получаете урон, действует в течение |cFFFFFF<<1>>|r секунд. Эффект может срабатывать раз в |cFFFFFF1|r секунду.\n\nЛозы накладывают Minor Lifesteal на противника, который наносит вам урон, на |cFFFFFF10|r секунд.",
    SI_LUIE_SKILL_LIVING_TRELLIS_TP =                    "Исцеляет вас, когда вы получаете урон, действует в течение |cFFFFFF<<1>>|r секунд. Эффект может срабатывать раз в |cFFFFFF1|r секунду.\n\nКогда лозы исчезают, дополнительно восстанавливает здоровье.",
    SI_LUIE_SKILL_LOTUS_FLOWER_TP =                      "Your Light and Heavy Attacks heal you or an ally within |cFFFFFF28|r meters for |cFFFFFF20|r seconds. Fully charged Heavy Attacks restore three times the value.",
    SI_LUIE_SKILL_NATURES_GRASP_TP =                     "Исцеляет каждую |cFFFFFF1|r секунду в течение |cFFFFFF<<1>>|r секунд.\n\nХранитель получает |cFFFFFF3|r очка ульты, когда эффект заканчивается, если находится в бою.",
    SI_LUIE_SKILL_NATURES_GRASP_SELF_TP =                "Исцеляет каждую |cFFFFFF1|r секунду в течение |cFFFFFF<<1>>|r секунд.\n\nВы получаете |cFFFFFF3|r очка ульты, когда эффект заканчивается, если находитесь в бою.",
    SI_LUIE_SKILL_SECLUDED_GROVE_TP =                    "Healing you and allies in the area every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_HEALING_THICKET_TP =                   "Every |cFFFFFF1|r second apply a |cFFFFFF4.1|r second duration heal over time effect on you and allies in the |cFFFFFF8|r meter radius of the healing forest.", -- TODO: Translate
    SI_LUIE_SKILL_IMPALING_SHARDS_TP =                   "Enemies in the area take Frost Damage and have their movement speed reduced by |cFFFFFF30|r% for |cFFFFFF3|r seconds every |cFFFFFF1|r second.\n\nThis ability has a higher chance to apply the Chilled status effect.",
    SI_LUIE_SKILL_CRYSTALLIZED_SHIELD_TP =               "Поглощает урон максимум |cFFFFFF3|r снарядов.\n\nКаждый раз при поглощении снаряда вы восстанавливаете Магии.",
    SI_LUIE_SKILL_CRYSTALLIZED_SLAB_TP =                 "Поглощает урон максимум |cFFFFFF3|r снарядов.\n\nКаждый раз при поглощении снаряда вы восстанавливаете Магии и запускаете обратно во врага ледяной шар, наносящий урон от Мороза.",
    SI_LUIE_SKILL_SHIMMERING_SHIELD_TP =                 "Поглощает урон максимум |cFFFFFF3|r снарядов.\n\nКаждый раз при поглощении снаряда вы восстанавливаете Магии и даёт Major Heroism в течение |cFFFFFF6|r секунд.",
    SI_LUIE_SKILL_FROZEN_GATE_TP =                       "Detonates when a enemy comes close, dealing Frost Damage, teleporting the enemy to you, and immobilizing them for |cFFFFFF3|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_FROZEN_DEVICE_TP =                     "Взрывается при приближении противника, нанося урон от Мороза, перемещая противника к вам и обездвиживая его на |cFFFFFF3|r секунды и накладывая Major Maim на |cFFFFFF4|r секунд.",
    SI_LUIE_SKILL_FROZEN_RETREAT_TP =                    "Detonates when a enemy comes close, dealing Frost Damage, teleporting the enemy to you, and immobilizing them for |cFFFFFF3|r seconds.\n\nAn ally in the portal can activate the |cFFFFFFIcy Escape|r synergy.", -- TODO: Translate
    SI_LUIE_SKILL_SLEET_STORM_TP =                       "Enemies in the storm take Frost Damage and have their movement speed reduced by |cFFFFFF40|r% every |cFFFFFF1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_PERMAFROST_TP =                        "Enemies in the storm take Frost Damage and have their movement speed reduced by |cFFFFFF40|r% every |cFFFFFF1|r second.\n\nDamaging an enemy three times with the storm will stun them for |cFFFFFF3|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_PERMAFROST_GROUND_TP =                 "Taking Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF40|r%.\n\nIf you take damage from the storm three times, you will be stunned for |cFFFFFF3|r seconds.",

    -- Necromancer
    SI_LUIE_SKILL_FLAME_SKULL_TP =                       "Every third cast of <<2>> deals |cFFFFFF20|r% increased damage.",
    SI_LUIE_SKILL_RICOCHET_SKULL_TP =                    "Every third cast of Ricochet Skull deals |cFFFFFF20|r% increased damage and will bounce up to |cFFFFFF2|r times to other nearby enemies.",

    SI_LUIE_SKILL_BLASTBONES_TP =                        "A flaming skeleton runs toward your target and explodes when it gets close to them, dealing Flame Damage to all enemies within |cFFFFFF6|r meters.\n\nThe skeleton remains for |cFFFFFF8|r seconds or until it explodes.",
    SI_LUIE_SKILL_BLIGHTED_BLASTBONES_TP =               "A decaying skeleton runs toward your target and explodes when it gets close to them, dealing Disease Damage to all enemies within |cFFFFFF6|r meters and applying Major Defile to them for |cFFFFFF4|r seconds.\n\nThe skeleton remains for |cFFFFFF8|r seconds or until it explodes.",
    SI_LUIE_SKILL_STALKING_BLASTBONES_TP =               "A flaming skeleton runs toward your target and explodes when it gets close to them, dealing Flame Damage to all enemies within |cFFFFFF6|r meters.\n\nEvery second the skeleton spends chasing its target increases the damage of the explosion by |cFFFFFF10|r% up to a maximum of |cFFFFFF50|r% more damage.\n\nThe skeleton remains for |cFFFFFF8|r seconds or until it explodes.",

    SI_LUIE_SKILL_BONEYARD_TP =                          "Enemies in the |cFFFFFF6|r meter radius of the graveyard take Frost Damage every |cFFFFFF1|r second.\n\nAn ally standing in the graveyard can activate the |cFFFFFFGrave Robber|r synergy.",
    SI_LUIE_SKILL_UNNERVING_BONEYARD_TP =                "Enemies in the |cFFFFFF6|r meter radius of the graveyard take Frost Damage every |cFFFFFF1|r second and have Major Breach and Major Fracture applied to them..\n\nAn ally standing in the graveyard can activate the |cFFFFFFGrave Robber|r synergy.",
    SI_LUIE_SKILL_AVID_BONEYARD_TP =                     "Enemies in the |cFFFFFF6|r meter radius of the graveyard take Frost Damage every |cFFFFFF1|r second.\n\nYou or an ally standing in the graveyard can activate the |cFFFFFFGrave Robber|r synergy.",

    SI_LUIE_SKILL_SKELETAL_MAGE_TP =                     "A skeletal mage fights at your side. The skeletal mage remains for |cFFFFFF<<1>>|r seconds.\n\nThe mage attacks the closest enemy every |cFFFFFF2|r seconds, dealing Shock Damage.",
    SI_LUIE_SKILL_SKELETAL_ARCHER_TP =                   "A skeletal archer fights at your side. The skeletal archer remains for |cFFFFFF<<1>>|r seconds.\n\nThe archer attacks the closest enemy every |cFFFFFF2|r seconds, dealing Physical Damage.\n\nEach time the archer deals damage, its next attack will do |cFFFFFF10|r% more damage than the previous attack.",
    SI_LUIE_SKILL_SKELETAL_ARCANIST_TP =                 "A skeletal arcanist fights at your side. The skeletal arcanist remains for |cFFFFFF<<1>>|r seconds.\n\nThe arcanist attacks the closest enemy every |cFFFFFF2|r seconds, dealing Shock Damage to them and enemies with |cFFFFFF4|r meters.",

    SI_LUIE_SKILL_SHOCKING_SIPHON_TP =                   "Enemies within |cFFFFFF5|r meters of the corpse and between you and the corpse take Shock Damage over |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SHOCKING_SIPHON_GROUND_TP =            "Taking rapidly ticking Shock Damage.",

    SI_LUIE_SKILL_FROZEN_COLOSSUS_TP =                   "A Frozen Colossus smashes the ground three times over |cFFFFFF3|r seconds, dealing Frost Damage to enemies within |cFFFFFF8|r meters.\n\nEach smash applies Major Vulnerability for any enemy hit for |cFFFFFF3|r seconds.",

    ----------------------------------------------------------------
    -- WEAPON SKILLS -----------------------------------------------
    ----------------------------------------------------------------

    -- Shared
    SI_LUIE_SKILL_PASSIVE_HEAVY_MAIN_HAND =              "Силовая атака (Ведущая рука)",
    SI_LUIE_SKILL_PASSIVE_HEAVY_OFF_HAND =               "Силовая атака (Вторая рука)",

    -- Two-Handed
    SI_LUIE_SKILL_FOLLOW_UP_TP =                         "Ваша следующая атака с прямым уроном, нанесённая в течение |cFFFFFF7|r секунд нанесёт |cFFFFFF<<1>>|r% дополнительного урона.",
    SI_LUIE_SKILL_BATTLE_RUSH_TP =                       "Увеличивает восстановление Запаса сил на |cFFFFFF<<1>>|r% в течение |cFFFFFF10|r секунд.",
    SI_LUIE_SKILL_RALLY_TP =                             "Healing every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds, and for additional Health when Rally expires.\n\nThe final heal is increased by up to |cFFFFFF564|r%, in proportion to the length of time Rally has been active.", -- TODO: Translate
    SI_LUIE_SKILL_BERSERKER_STRIKE_TP =                  "Увеличивает в течение |cFFFFFF<<1>>|r секунд Физическую и Магическую сопротивляемости на величину, равную проигнорированному способностью Berserker Strike сопротивлению цели.",
    SI_LUIE_SKILL_ONSLAUGHT_TP =                         "Увеличивает в течение |cFFFFFF<<1>>|r секунд Физическую и Магическую сопротивляемости на величину, равную проигнорированному способностью Onslaught сопротивлению цели.",
    SI_LUIE_SKILL_BERSERKER_RAGE_TP =                    "Увеличивает в течение |cFFFFFF<<1>>|r секунд Физическую и Магическую сопротивляемости на величину, равную проигнорированному способностью Berserker Rage сопротивлению цели.\n\nВы получаете иммунитет к обездвиживанию, замедлению и обезмолвливанию на время действия эффекта.",

    -- One Hand and Shield
    SI_LUIE_SKILL_DEFENSIVE_POSTURE_TP =                 "Отражает обратной в противника следующий направленный в вас снаряд заклинания, выпущенный в течение |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_DEFENSIVE_STANCE_TP =                  "Отражает обратной в противника следующий направленный в вас снаряд заклинания, выпущенный в течение |cFFFFFF<<1>>|r секунд.\n\nОтражённый снаряд оглушает цель на |cFFFFFF4|r секунды.",
    SI_LUIE_SKILL_ABSORB_MAGIC_TP =                      "Поглощает урон следующего направленного в вас снаряда заклинания, выпущенный в течение |cFFFFFF<<1>>|r секунд и исцеляет вас на |cFFFFFF15|r% от вашего максимального запаса Здоровья.",
    SI_LUIE_SKILL_POWER_SLAM_TP =                        "Ваше следующее применение способности Power Slam в течение |cFFFFFF<<1>>|r секунд наносит |cFFFFFF25|r% дополнительного урона.",
    SI_LUIE_SKILL_SHIELD_WALL_TP =                       "Автоматически блокирует все атаки в течение |cFFFFFF<<1>>|r секунд, не расходуя ресурсов.",
    SI_LUIE_SKILL_SPELL_WALL_TP =                        "Автоматически блокирует все атаки и отражает снаряды в течение |cFFFFFF<<1>>|r секунд, не расходуя ресурсов.",
    SI_LUIE_SKILL_SHIELD_DISCIPLINE_TP =                 "Автоматически блокирует все атаки в течение |cFFFFFF<<1>>|r секунд, не расходуя ресурсов.\n\nВаши способности из ветки Одноручного оружия и Щита расходуют на |cFFFFFF100|r% меньше ресурсов, пока активно.",

    -- Dual Wield
    SI_LUIE_SKILL_RENDING_SLASHES_TP =                   "Afflicted with Bleeding Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_BLOOD_CRAZE_TP =                       "Подвержен Кровотечению каждые |cFFFFFF2|r секунды в течение |cFFFFFF<<1>>|r секунд.\n\nАтакуюие вас исцеляются каждые |cFFFFFF2|r секунды, пока активная способность Blood Craze.",
    SI_LUIE_SKILL_BLOOD_CRAZE_HEAL_TP =                  "Исцеляет каждые |cFFFFFF2|r секунды в течение |cFFFFFF<<1>>|r секунд, пока на вашей цели активе эффект Blood Craze.",
    SI_LUIE_SKILL_BLADE_CLOAK_TP =                       "Кольцо летающих острых лезвий окружает вас, нанося Физический урон всем ближайшим противникам каждые |cFFFFFF3|r секунды в течение |cFFFFFF<<1>>|r секунд.",
    SI_LUIE_SKILL_LACERATE_TP =                          "Afflicted with Bleeding Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nEvery time this effect deals damage, your attacker heals for |cFFFFFF50|r% of the damage done.", -- TODO: Translate
    SI_LUIE_SKILL_THRIVE_IN_CHAOS_TP =                   "Увеличивает наносимый урон на |cFFFFFF5|r% за каждый удар способностью Thrive in Chaos, максимум на |cFFFFFF30|r%.",

    -- Bow
    SI_LUIE_SKILL_HAWK_EYE_TP =                          "Increase the damage of your Bow abilities by |cFFFFFF<<1>>|r% for |cFFFFFF5|r seconds, stacking up to |cFFFFFF5|r times.",
    SI_LUIE_SKILL_VOLLEY_TP =                            "Arrows rain down from the sky, dealing Physical Damage to enemies in the target area every |cFFFFFF0.5|r seconds.",
    SI_LUIE_SKILL_ENDLESS_HAIL_TP =                      "Arrows rain down from the sky, dealing Physical Damage to enemies in the target area every |cFFFFFF0.5|r seconds.",
    SI_LUIE_SKILL_DRAINING_SHOT_TP =                     "Stunned for |cFFFFFF<<1>>|r seconds.\n\nWhen the stun ends, your attacker heals.",
    SI_LUIE_SKILL_BOMBARD_TP =                           "Immobilized and Movement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_POISON_INJECTION_TP =                  "Afflicted with Poison Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nDeals up to |cFFFFFF200|r% more damage in proportion to your missing health under |cFFFFFF50|r%.",
    SI_LUIE_SKILL_BALLISTA_TP =                          "Your ballista turret unleashes a barrage of arrows, dealing Physical Damage over |cFFFFFF<<1>>|r seconds.",

    -- Destruction Staff
    SI_LUIE_HEAVY_ATTACK_LIGHTNING_STAFF_TP =            "Afflicted with Shock Damage over time for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Shock Damage if the channel is finished.",
    SI_LUIE_SKILL_WOE_FIRE_TP =                          "Enemies standing in the elemental barrier take Flame Damage every |cFFFFFF1|r second.\n\nBurning enemies take |cFFFFFF20|r% more damage from this ability.",
    SI_LUIE_SKILL_WOE_FROST_TP =                         "Enemies standing in the elemental barrier take Frost Damage and have their Movement Speed reduced by |cFFFFFF40|r% every |cFFFFFF1|r second.\n\nChilled enemies become frozen and are immobilized for |cFFFFFF4|r seconds.",
    SI_LUIE_SKILL_WOE_SHOCK_TP =                         "Enemies standing in the elemental barrier take Shock Damage every |cFFFFFF1|r second.\n\nConcussed enemies are set Off Balance for |cFFFFFF5|r seconds.",
    SI_LUIE_SKILL_UWOE_FIRE_TP =                         "Enemies standing in the elemental barrier take Flame Damage every |cFFFFFF1|r second.\n\nBurning enemies take |cFFFFFF20|r% more damage from this ability.\n\nThe wall explodes when it expires, dealing additional Flame Damage.",
    SI_LUIE_SKILL_UWOE_FROST_TP =                        "Enemies standing in the elemental barrier take Frost Damage and have their Movement Speed reduced by |cFFFFFF40|r% every |cFFFFFF1|r second.\n\nChilled enemies become frozen and are immobilized for |cFFFFFF4|r seconds.\n\nThe wall explodes when it expires, dealing additional Frost Damage.",
    SI_LUIE_SKILL_UWOE_SHOCK_TP =                        "Enemies standing in the elemental barrier take Shock Damage every |cFFFFFF1|r second.\n\nConcussed enemies are set Off Balance for |cFFFFFF5|r seconds.\n\nThe wall explodes when it expires, dealing additional Shock Damage.",
    SI_LUIE_SKILL_FLAME_TOUCH_TP =                       "Afflicted with Flame Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nKnocked back for |cFFFFFF1.8|r seconds.",
    SI_LUIE_SKILL_FLAME_TOUCH_ALT_TP =                   "Afflicted with Flame Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds.\n\nKnocked back for |cFFFFFF1.8|r seconds.",
    SI_LUIE_SKILL_SHOCK_TOUCH_TP =                       "Afflicted with Shock Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nStunned for |cFFFFFF2.5|r seconds.",
    SI_LUIE_SKILL_SHOCK_TOUCH_ALT_TP =                   "Afflicted with Shock Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds.\n\nStunned for |cFFFFFF2.5|r seconds.",
    SI_LUIE_SKILL_FROST_TOUCH_TP =                       "Afflicted with Frost Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nImmobilized for |cFFFFFF4|r seconds.",
    SI_LUIE_SKILL_FROST_TOUCH_ALT_TP =                   "Afflicted with Frost Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds.\n\nImmobilized for |cFFFFFF4|r seconds.",
    SI_LUIE_SKILL_FROST_CLENCH_TP =                      "Afflicted with Frost Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nImmobilized for |cFFFFFF6.5|r seconds.",
    SI_LUIE_SKILL_FROST_CLENCH_ALT_TP =                  "Afflicted with Frost Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds.\n\nImmobilized for |cFFFFFF6.5|r seconds.",
    SI_LUIE_SKILL_ELEMENTAL_STORM_TP =                   "A cataclysmic storm builds for |cFFFFFF2|r seconds then lays waste to all enemies in the area, dealing <<1>> Damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_ICY_RAGE_TP =                          "A cataclysmic storm builds for |cFFFFFF2|r seconds then lays waste to all enemies in the area, dealing Frost Damage every |cFFFFFF1|r second.\n\nImmobilizes enemies hit for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_EYE_OF_THE_STORM_TP =                  "A cataclysmic storm builds around you for |cFFFFFF2|r seconds then lays waste to all enemies within |cFFFFFF8|r meters, dealing <<1>> Damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_WALL_OF_ELEMENTS_GROUND_FIRE =         "Taking Flame Damage every |cFFFFFF1|r second.\n\nIf you are Burning, take |cFFFFFF20|r% more damage from this ability.",
    SI_LUIE_SKILL_WALL_OF_ELEMENTS_GROUND_FROST =        "Taking Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF40|r%.\n\nIf you are Chilled you will be immobilized for |cFFFFFF4|r seconds.",
    SI_LUIE_SKILL_WALL_OF_ELEMENTS_GROUND_SHOCK =        "Taking Shock Damage every |cFFFFFF1|r second.\n\nIf you are Concussed you will be set Off Balance for |cFFFFFF5|r seconds.",
    SI_LUIE_SKILL_U_WALL_OF_ELEMENTS_GROUND_FIRE =       "Taking Flame Damage every |cFFFFFF1|r second.\n\nIf you are Burning, take |cFFFFFF20|r% more damage from this ability.\n\nThe wall explodes when it expires, dealing additional Flame Damage.",
    SI_LUIE_SKILL_U_WALL_OF_ELEMENTS_GROUND_FROST =      "Taking Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF40|r%.\n\nIf you are Chilled you will be immobilized for |cFFFFFF4|r seconds.\n\nThe wall explodes when it expires, dealing additional Frost Damage.",
    SI_LUIE_SKILL_U_WALL_OF_ELEMENTS_GROUND_SHOCK =      "Taking Shock Damage every |cFFFFFF1|r second.\n\nIf you are Concussed you will be set Off Balance for |cFFFFFF5|r seconds.\n\nThe wall explodes when it expires, dealing additional Shock Damage.",

    -- Restoration Staff
    SI_LUIE_SKILL_BLESSING_OF_RESTORATION =              "Blessing of Restoration",
    SI_LUIE_SKILL_MUTAGEN =                              "Healing every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nIf you fall below |cFFFFFF20%|r Health, the Mutagen is consumed but instantly heals and removes |cFFFFFF1|r harmful effect.",
    SI_LUIE_SKILL_HEALING_WARD =                         "Absorbing damage for |cFFFFFF<<1>>|r seconds.\n\nWhen the shield expires, heal based of the shield's remaining strength.",
    SI_LUIE_SKILL_LIGHTS_CHAMPION =                      "Healing every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nGain Major Force and Major Protection for |cFFFFFF5|r seconds every time this effect heals.",

    ----------------------------------------------------------------
    -- ARMOR SKILLS ------------------------------------------------
    ----------------------------------------------------------------

    -- Light Armor
    SI_LUIE_SKILL_HARNESS_MAGICKA =                      "Absorbing damage for |cFFFFFF<<1>>|r seconds.\n\nWhile active, up to three times when spell damage is absorbed, you restore Magicka.",

    ----------------------------------------------------------------
    -- WORLD SKILLS ------------------------------------------------
    ----------------------------------------------------------------

    -- Soul Magic
    SI_LUIE_SKILL_SOUL_SUMMONS_TP =                      "Вы недавно воскресли без затрат Камня душ и не можете воскреснуть сова не потратив камня душ в течение |cFFFFFF<<1>>|r час.", -- TODO: Check Translation
    SI_LUIE_SKILL_SOUL_TRAP =                            "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker fills a soul gem if you die under this effect.",
    SI_LUIE_SKILL_CONSUMING_TRAP =                       "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker fills a soul gem and restores Health, Magicka, and Stamina if you die under this effect.",

    -- Werewolf
    SI_LUIE_SKILL_SANIES_LUPINUS_TP =                    "Вы были укушены Оборотнем и заразились Гнойным люпинусом.",
    SI_LUIE_SKILL_LYCANTHROPHY_TP =                      "Вы можете обратиться в дикого Оборотня.\n\nВы получаете на |cFFFFFF25|r% больше урона от Яда, пока находитесь в форме Вервольфа.",
    SI_LUIE_SKILL_BLOOD_MOON_TP =                        "Вы укусили другого игрока. Вы не сможете сделать этого снова в течение |cFFFFFF7|r дней.", -- TODO: Check Translation
    SI_LUIE_SKILL_FEEDING_FREZNY_TP =                    "Empowered for |cFFFFFF<<1>>|r seconds, increasing the damage of your Light Attacks by |cFFFFFF40|r%.",
    SI_LUIE_SKILL_CLAWS_OF_LIFE_TP =                     "Afflicted with Disease Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nEvery time this effect deals damage, your attacker heals for |cFFFFFF50|r% of the damage done.",
    SI_LUIE_SKILL_WEREWOLF_TRANSFORMATION_TP =           "Transformed into a werewolf.\n\nWhile transformed, your Light Attacks apply a bleed over |cFFFFFF4|r seconds, your Heavy Attacks deal |cFFFFFF50|r% splash damage, and your Max Stamina is increased by |cFFFFFF30|r%.",
    SI_LUIE_SKILL_PACK_LEADER_TP =                       "Transformed into a werewolf.\n\nWhile transformed, your Light Attacks apply a bleed over |cFFFFFF4|r seconds, your Heavy Attacks deal |cFFFFFF50|r% splash damage, and your Max Stamina is increased by |cFFFFFF30|r%.\n\nSummon two direwolves while transformed. If killed, they return after |cFFFFFF10|r seconds.",

    -- Vampire
    SI_LUIE_SKILL_PASSIVE_NOXIPHILIC_SANGUIVORIA =       "Noxiphilic Sanguivoria",
    SI_LUIE_SKILL_NOXIPHILIC_SANGUIVORIA_TP =            "You have been bitten by a Vampire and contracted Noxiphilic Sanguivoria.",
    SI_LUIE_SKILL_VAMPIRISM_STAGE1_TP =                  "• Using Vampire abilities advances your vampirism stage\n• Feeding reduces your vampirism stage, sneak up behind an enemy humanoid to feed",
    SI_LUIE_SKILL_VAMPIRISM_STAGE2_TP =                  "• Reduce Health Recovery by |cFFFFFF25|r%\n• Increase Fire Damage taken by |cFFFFFF15|r%\n• Vampire abilities cost |cFFFFFF7|r% less and advance your vampirism stage\n• Feeding reduces your vampirism stage, sneak up behind an enemy humanoid to feed",
    SI_LUIE_SKILL_VAMPIRISM_STAGE3_TP =                  "• Reduce Health Recovery by |cFFFFFF50|r%\n• Increase Fire Damage taken by |cFFFFFF20|r%\n• Vampire abilities cost |cFFFFFF14|r% less and advance your vampirism stage\n• Feeding reduces your vampirism stage, sneak up behind an enemy humanoid to feed",
    SI_LUIE_SKILL_VAMPIRISM_STAGE4_TP =                  "• Reduce Health Recovery by |cFFFFFF75|r%\n• Increase Fire Damage taken by |cFFFFFF25|r%\n• Vampire abilities cost |cFFFFFF21|r% less and advance your vampirism stage\n• Feeding reduces your vampirism stage, sneak up behind an enemy humanoid to feed",
    SI_LUIE_SKILL_FEED_TP =                              "A Vampire is draining your life force, healing every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds and reducing their vampirism Stage when the effect ends.\n\nStunned for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_BLOOD_RITUAL_TP =                      "You have fed on another player. You may not do so again for |cFFFFFF7|r days.",
    SI_LUIE_SKILL_PROFANE_SYMBOL =                       "Profane Symbol",
    SI_LUIE_SKILL_DRAIN_ESSENCE_TP =                     "Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds. Each tick heals the vampire for |cFFFFFF20|r% of their missing health.",
    SI_LUIE_SKILL_INVIGORATING_DRAIN_TP =                "Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds. Each tick heals the vampire for |cFFFFFF20|r% of their missing health and generates |cFFFFFF2|r Ultimate.",
    SI_LUIE_SKILL_MIST_FORM_TP =                         "Reduce damage taken by |cFFFFFF75|r% for |cFFFFFF<<1>>|r seconds.\n\nImmune to all disabling and immobilization effects while active, but cannot be healed and Magicka Recovery is disabled.",
    SI_LUIE_SKILL_BALEFUL_MIST_TP =                      "Reduce damage taken by |cFFFFFF75|r% and enemies within |cFFFFFF5|r meters take Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nImmune to all disabling and immobilization effects while active, but cannot be healed and Magicka Recovery is disabled.",
    SI_LUIE_SKILL_BAT_SWARM_TP =                         "Enemies within |cFFFFFF10|r meters take Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_DEVOURING_SWARM_TP =                   "Enemies within |cFFFFFF10|r meters take Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nThe bats heal you for each enemy they damage.",
    SI_LUIE_SKILL_DEVOURING_SWARM_GROUND_TP =            "Taking Magic Damage every |cFFFFFF1|r second.\n\nEach tick heals the Vampire.",

    ----------------------------------------------------------------
    -- GUILD SKILLS ------------------------------------------------
    ----------------------------------------------------------------

    -- Fighters Guild
    SI_LUIE_SKILL_CIRCLE_OF_PROTECTION_TP =              "You and allies in the rune gain Minor Protection and Minor Endurance.",
    SI_LUIE_SKILL_RING_OF_PRESERVATION_TP =              "You and allies in the rune have the cost of Roll Dodge reduced by |cFFFFFF20|r% and gain Minor Protection and Minor Endurance.",
    SI_LUIE_SKILL_RING_OF_PRESERVATION_GROUND_TP =       "The cost of Roll Dodge is reduced by |cFFFFFF20|r%.",
    SI_LUIE_SKILL_EXPERT_HUNTER_TP =                     "Revealing stealthed and invisible enemies within |cFFFFFF6|r meters for |cFFFFFF<<1>>|r seconds.\n\nExposed enemies cannot return to stealth or invisibility for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_EVIL_HUNTER_TP =                       "Revealing stealthed and invisible enemies within |cFFFFFF6|r meters for |cFFFFFF<<1>>|r seconds.\n\nExposed enemies cannot return to stealth or invisibility for |cFFFFFF3|r seconds.\n\nWhile active the Stamina costs of your Fighters Guild abilities are reduced by |cFFFFFF25|r%.",
    SI_LUIE_SKILL_TRAP_BEAST_TP =                        "Triggers when an enemy comes close, dealing Physical Damage and afflicting them with Bleeding Damage for |cFFFFFF6|r seconds as well as immobilizing them.\n\nWhen triggered, grants you Minor Force for |cFFFFFF8|r seconds.",
    SI_LUIE_SKILL_TRAP_BEAST_DEBUFF_TP =                 "Afflicted with Bleeding Damage every |cFFFFFF2|r seconds and immobilized for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_REARMING_TRAP_TP =                     "Triggers when an enemy comes close, dealing Physical Damage and afflicting them with Bleeding Damage for |cFFFFFF6|r seconds as well as immobilizing them.\n\nWhen triggered, grants you Minor Force for |cFFFFFF8|r seconds.\n\nAfter being triggered the trap resets and can be triggered one more time.",
    SI_LUIE_SKILL_DAWNBREAKER_OF_SMITING_TP =            "Afflicted with Bleeding Damage every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.\n\nStunned for |cFFFFFF2|r seconds.",

    -- Mages Guild
    SI_LUIE_SKILL_RADIANT_MAGELIGHT_TP =                 "Revealing stealthed and invisible enemies within |cFFFFFF12|r meters for |cFFFFFF<<1>>|r seconds.\n\nExposed enemies cannot return to stealth or invisibility for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_ENTROPY_TP =                           "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker heals every |cFFFFFF6|r seconds while Entropy remains active.",
    SI_LUIE_SKILL_STRUCTURED_ENTROPY_TP =                "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker heals every |cFFFFFF6|r seconds while Structured Entropy remains active.",
    SI_LUIE_SKILL_DEGENERATION_TP =                      "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker heals every |cFFFFFF6|r seconds while Degeneration remains active.\n\nLight and Heavy attacks made against you by your attacker have a |cFFFFFF15|r% chance to heal them for |cFFFFFF100|r% of the damage dealt.",
    SI_LUIE_SKILL_FIRE_RUNE_TP =                         "When triggered, the rune blasts all enemies in the target area for Flame Damage.",
    SI_LUIE_SKILL_VOLCANIC_RUNE_TP =                     "When triggered, the rune blasts all enemies in the target area for Flame Damage, knocks them into the air, and stuns them for |cFFFFFF4|r seconds.",
    SI_LUIE_SKILL_SCALDING_RUNE_TP =                     "When triggered, the rune blasts all enemies in the target area for Flame Damage and afflicts them with additional Flame Damage over time.",
    SI_LUIE_SKILL_EQUILIBRIUM_TP =                       "Reduce healing done and damage shield strength by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SPELL_SYMMETRY_TP =                    "Reduce the cost of your next Magicka ability used within |cFFFFFF<<1>>|r seconds by |cFFFFFF28|r%.",
    SI_LUIE_SKILL_METEOR_TP =                            "Enemies in the impact area take Flame Damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_ICE_COMET_TP =                         "Enemies in the impact area take Frost Damage every |cFFFFFF1|r second.",

    -- Psijic Order
    SI_LUIE_SKILL_SPELL_ORB_TP =                         "When you cast a Psijic Order ability while you are in combat, you generate a spell charge.\n\nWhen you reach |cFFFFFF5|r spell charges, you launch a spell orb at the closest enemy to you dealing Magic Damage or Physical Damage, whichever is higher.",
    SI_LUIE_SKILL_CONCENTRATED_BARRIER_TP =              "Absorbing damage while blocking.\n\nThis damage shield recharges back to full strength after you spend |cFFFFFF10|r seconds not blocking.",
    SI_LUIE_SKILL_TIME_STOP_TP =                         "Gradually being slowed over time for |cFFFFFF2|r seconds.\n\nIf you are still in the area of effect at end of this duration you will be stunned for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_TIME_BORROWED_TIME_TP =                "Gradually being slowed over time for |cFFFFFF2|r seconds.\n\nIf you are still in the area of effect at end of this duration you will be stunned and have the next |cFFFFFF5000|r points of healing negated for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_TIME_BORROWED_TIME_STUN_TP =           "Negating the next |cFFFFFF5000|r points of healing for |cFFFFFF<<1>>|r seconds.\n\nStunned for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_TIME_FREEZE_TP =                       "Gradually being slowed over time for |cFFFFFF4|r seconds.\n\nIf you are still in the area of effect at end of this duration you will be stunned for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_IMBUE_WEAPON_TP =                      "Your next Light Attack used within |cFFFFFF2|r seconds deals additional Physical Damage.\n\nIf the power is not consumed in time, regain a portion of the resources spent.",
    SI_LUIE_SKILL_ELEMENTAL_WEAPON_TP =                  "Your next Light Attack used within |cFFFFFF2|r seconds deals additional Magic Damage and applies the Burning, Concussion, or Chill status effect.\n\nIf the power is not consumed in time, regain a portion of the resources spent.",
    SI_LUIE_SKILL_CRUSHING_WEAPON_TP =                   "Your next Light Attack used within |cFFFFFF2|r seconds deals additional Physical Damage and heals you for |cFFFFFF25|r% of the damage done.\n\nIf the power is not consumed in time, regain a portion of the resources spent.",
    SI_LUIE_SKILL_MEND_WOUNDS_TP =                       "Your Light and Heavy attacks are replaced with healing abilities that can only be used on allies.\n\nYour Light Attack launches a restorative sphere at your ally, instantly healing them.\n\nYour Heavy Attack heals every |cFFFFFF1|r second and restores Magicka to you while channeling.",
    SI_LUIE_SKILL_MEND_SPIRIT_TP =                       "Your Light and Heavy attacks are replaced with healing abilities that can only be used on allies.\n\nYour Light Attack launches a restorative sphere at your ally, instantly healing them.\n\nYour Heavy Attack heals every |cFFFFFF1|r second and restores Magicka to you while channeling.\n\nAfter you heal an ally you grant them Major Resolve and Major Ward for |cFFFFFF5|r seconds.",
    SI_LUIE_SKILL_SYMBIOSIS_TP =                         "Your Light and Heavy attacks are replaced with healing abilities that can only be used on allies.\n\nYour Light Attack launches a restorative sphere at your ally, instantly healing them.\n\nYour Heavy Attack heals every |cFFFFFF1|r second and restores Magicka to you while channeling.\n\nYou heal yourself for |cFFFFFF50|r% of the amount of healing done to the ally.",
    SI_LUIE_SKILL_MEDITATE_TP =                          "Healing and restoring Magicka and Stamina every |cFFFFFF1|r second.\n\nYou will remain in a meditative state until you toggle this ability off or are interrupted.",
    SI_LUIE_SKILL_INTROSPECTION_TP =                     "Healing and restoring Magicka and Stamina every |cFFFFFF1|r second.\n\nMaintaining the channel increases the Health restored by |cFFFFFF10|r% every tick, up to a maximum of |cFFFFFF50|r%.\n\nYou will remain in a meditative state until you toggle this ability off or are interrupted.",

    -- Undaunted
    SI_LUIE_SKILL_BLOOD_ALTAR_TP =                       "Enemies within |cFFFFFF28|r meters of the Altar are afflicted with Minor Lifesteal.\n\nAllies in the area can activate the |cFFFFFFBlood Funnel|r synergy, healing for |cFFFFFF40|r% of their Max Health.",
    SI_LUIE_SKILL_OVERFLOWING_ALTAR_TP =                 "Enemies within |cFFFFFF28|r meters of the Altar are afflicted with Minor Lifesteal.\n\nAllies in the area can activate the |cFFFFFFBlood Feast|r synergy, healing for |cFFFFFF65|r% of their Max Health.",
    SI_LUIE_SKILL_TRAPPING_WEBS_TP =                     "Enemies caught in the webs are snared, reducing their Movement Speed by |cFFFFFF50|r%.\n\nAfter |cFFFFFF5|r seconds the webs explode, dealing Poison Damage to enemies within.\n\nA ranged ally targeting an enemy in the webs can activate the |cFFFFFFSpawn Broodlings|r synergy.",
    SI_LUIE_SKILL_SHADOW_SILK_TP =                       "Enemies caught in the webs are snared, reducing their Movement Speed by |cFFFFFF50|r%.\n\nAfter |cFFFFFF5|r seconds the webs explode, dealing Poison Damage to enemies within.\n\nA ranged ally targeting an enemy in the webs can activate the |cFFFFFFBlack Widows|r synergy.",
    SI_LUIE_SKILL_TANGLING_WEBS_TP =                     "Enemies caught in the webs are snared, reducing their Movement Speed by |cFFFFFF50|r%.\n\nAfter |cFFFFFF5|r seconds the webs explode, dealing Poison Damage to enemies within.\n\nA ranged ally targeting an enemy in the webs can activate the |cFFFFFFArachnophobia|r synergy.",
    SI_LUIE_SKILL_TRAPPING_WEBS_SNARE_TP =               "Movement Speed reduced by |cFFFFFF50|r%.\n\nAfter |cFFFFFF5|r seconds the webs explode, dealing Poison damage.",
    SI_LUIE_SKILL_RADIATE_TP =                           "Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends, you and nearby allies take additional Magic Damage.",
    SI_LUIE_SKILL_SPAWN_BROODLINGS_TP =                  "Attacking nearby enemies. The spider remains for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_BONE_SHIELD_TP =                       "Absorbing damage for |cFFFFFF<<1>>|r seconds.\n\nAn ally near you can activate the |cFFFFFFBone Wall|r synergy.",
    SI_LUIE_SKILL_SPIKED_BONE_SHIELD_TP =                "Absorbing damage for |cFFFFFF<<1>>|r seconds and returning |cFFFFFF43|r% of any direct damage absorbed back to the enemy.\n\nAn ally near you can activate the |cFFFFFFBone Wall|r synergy.",
    SI_LUIE_SKILL_BONE_SURGE_TP =                        "Absorbing damage for |cFFFFFF<<1>>|r seconds.\n\nAn ally near you can activate the |cFFFFFFSpinal Surge|r synergy.",

    ----------------------------------------------------------------
    -- AVA SKILLS --------------------------------------------------
    ----------------------------------------------------------------

    -- Assault
    SI_LUIE_SKILL_CONTINUOUS_ATTACK_RANK_1_TP =          "Increase Weapon and Spell Damage by |cFFFFFF5|r% and Magicka and Stamina Recovery by |cFFFFFF10|r% for |cFFFFFF10|r minutes.",
    SI_LUIE_SKILL_CONTINUOUS_ATTACK_RANK_2_TP =          "Increase Weapon and Spell Damage by |cFFFFFF10|r% and Magicka and Stamina Recovery by |cFFFFFF20|r% for |cFFFFFF10|r minutes.",
    SI_LUIE_SKILL_RAPID_MANEUVER_TP =                    "Gain Major Expedition and Major Gallop for |cFFFFFF<<1>>|r seconds.\n\nThe effect ends if you cast any spell on an enemy or ally.",
    SI_LUIE_SKILL_RETREATING_MANEUEVER_TP =              "Gain Major Expedition and Major Gallop for |cFFFFFF<<1>>|r seconds.\n\nAttacks from behind deal |cFFFFFF15|r% less damage while this effect persists.\n\nThe effect ends if you cast any spell on an enemy or ally.",
    SI_LUIE_SKILL_CHARGING_MANEUVER_TP =                 "Gain Major Expedition and Major Gallop for |cFFFFFF<<1>>|r seconds.\n\nThe effect ends if you cast any spell on an enemy or ally, but you gain Minor Expedition for |cFFFFFF8|r seconds.",
    SI_LUIE_SKILL_CALTROPS_TP =                          "Enemies standing in the caltrops take Physical Damage every |cFFFFFF1|r second and have their Movement Speed reduced by |cFFFFFF30|r%.",
    SI_LUIE_SKILL_ANTI_CAVALRY_CALTROPS_TP =             "Enemies standing in the caltrops take Physical Damage every |cFFFFFF1|r second and have their Movement Speed reduced by |cFFFFFF30|r%.\n\nThe caltrops rapidly drain the Mount Stamina of any enemy in the area.",
    SI_LUIE_SKILL_ANTI_CAVALRY_CALTROPS_DEBUFF_TP =      "Taking Physical Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF30|r%.\n\nThe caltrops rapidly drain Mount Stamina.",
    SI_LUIE_SKILL_MAGICKA_DETONATION_TP =                "Cursed with a magical bomb that explodes after |cFFFFFF<<1>>|r seconds, dealing Magic Damage to you and any allies within |cFFFFFF8|r meters.\n\nEach ally within the bomb's radius increases the damage by |cFFFFFF25|r%, up to a maximum of |cFFFFFF250|r% increased damage.",
    SI_LUIE_SKILL_INEVITABLE_DETONATION_TP =             "Cursed with a magical bomb that explodes after |cFFFFFF<<1>>|r seconds, dealing Magic Damage to you and any allies within |cFFFFFF8|r meters.\n\nEach ally within the bomb's radius increases the damage by |cFFFFFF25|r%, up to a maximum of |cFFFFFF250|r% increased damage.\n\nIf the bomb is dispelled or removed early, the explosion is triggered immediately.",
    SI_LUIE_SKILL_PROXIMITY_DETONATION_TP =              "Charging a magical bomb that explodes after |cFFFFFF<<1>>|r seconds, dealing Magic Damage to all enemies within |cFFFFFF8|r meters.\n\nEach enemy within the bomb's radius increases the damage by |cFFFFFF25|r%, up to a maximum of |cFFFFFF250|r% increased damage.",
    SI_LUIE_SKILL_WAR_HORN_TP =                          "Increase Max Stamina and Max Magicka by |cFFFFFF10|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_WAR_HORN_DUMMY_TP =                    "Increase Max Stamina and Max Magicka.",

    -- Support
    SI_LUIE_SKILL_SIEGE_SHIELD_TP =                      "Reduce damage taken from siege weapons by |cFFFFFF50|r%.",
    SI_LUIE_SKILL_SIEGE_SHIELD_GROUND_TP =               "A protective sphere guards you and allies, reducing damage taken from siege weapons while in the bubble by |cFFFFFF50|r%.",
    SI_LUIE_SKILL_SIEGE_WEAPON_SHIELD_TP =               "Reduce damage taken from siege weapons by |cFFFFFF50|r%.\n\nYour siege weapons take |cFFFFFF90|r% reduced damage from enemy siege weapons.",
    SI_LUIE_SKILL_SIEGE_WEAPON_SHIELD_GROUND_TP =        "A protective sphere guards you and allies, reducing damage taken from siege weapons while in the bubble by |cFFFFFF50|r%.\n\nYou and allies' siege weapons in the bubble take |cFFFFFF90|r% reduced damage from enemy siege weapons.",
    SI_LUIE_SKILL_PROPELLING_SHIELD_TP =                 "Reduce damage taken from siege weapons by |cFFFFFF50|r% and increase the range of abilities with a range greater than |cFFFFFF20|r meters by |cFFFFFF7|r meters.\n\nDoes not effect Leap, Move Position, and Pull abilities.",
    SI_LUIE_SKILL_PROPELLING_SHIELD_GROUND_TP =          "A protective sphere guards you and allies, reducing damage taken from siege weapons while in the bubble by |cFFFFFF50|r%.\n\nIncrease the range of you and allies' abilities with a range greater than |cFFFFFF20|r meters by |cFFFFFF7|r meters in the bubble.\n\nDoes not effect Leap, Move Position, and Pull abilities.",
    SI_LUIE_SKILL_PURGE_TP =                             "Reduce the duration of new negative effects applied on you by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_GUARD_SELF_TP =                        "While the lifebond holds, |cFFFFFF30|r% of the damage your ally takes is redistributed to you.",
    SI_LUIE_SKILL_GUARD_OTHER_TP =                       "While the lifebond holds, |cFFFFFF30|r% of the damage you take is redistributed to your ally.",
    SI_LUIE_SKILL_REVEALING_FLARE_TP =                   "Revealed. You are unable to stealth.\n\nMovement Speed reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_LINGERING_FLARE_TP =                   "Enemies in the target area are revealed and have their Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_SCORCHING_FLARE_TP =                   "Revealed. You are unable to stealth.\n\nAfflicted with Flame Damage every |cFFFFFF1.5|r seconds and Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_REVIVING_BARRIER_TP =                  "Absorbing damage and healing every |cFFFFFF1.5|r seconds for |cFFFFFF30|r seconds.",

    ----------------------------------------------------------------
    -- RACIAL SKILLS -----------------------------------------------
    ----------------------------------------------------------------

    SI_LUIE_SKILL_HUNTERS_EYE_TP =                       "Increase Movement Speed by |cFFFFFF<<1>>|r% and Physical and Spell Penetration by |cFFFFFF<<2>>|r for |cFFFFFF6|r seconds.",

    ----------------------------------------------------------------
    -- CYRODIIL ----------------------------------------------------
    ----------------------------------------------------------------

    SI_LUIE_SKILL_AVA_SANCTUARY_TP =                     "While in a Sanctuary, you cannot attack other players and other players cannot attack you.",
    SI_LUIE_SKILL_STOW_SIEGE_WEAPON =                    "Stow Siege Weapon",
    SI_LUIE_SKILL_DEPLOY =                               "Deploy",
    SI_LUIE_SKILL_PACT =                                 "Pact",
    SI_LUIE_SKILL_COVENANT =                             "Covenant",
    SI_LUIE_SKILL_DOMINION =                             "Dominion",
    SI_LUIE_SKILL_LIGHTNING_BALLISTA =                   "Lightning Ballista",
    SI_LUIE_SKILL_LIGHTNING_BALLISTA_BOLT_TP =           "Afflicted with Shock Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds. Each tick drains |cFFFFFF10|r% of your Max Magicka.",
    SI_LUIE_SKILL_MEATBAG_CATAPULT_TP =                  "Healing and Health Recovery reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_MEATBAG_CATAPULT_GROUND_TP =           "Enemies in the area take Disease Damage every |cFFFFFF1|r second and suffer |cFFFFFF50|r% reduced Healing and Health Recovery for |cFFFFFF6|r seconds.",
    SI_LUIE_SKILL_OIL_CATAPULT_GROUND_TP =               "Enemies in the oil are snared, reducing their Movement Speed by |cFFFFFF50|r% for |cFFFFFF6|r seconds.",
    SI_LUIE_SKILL_SCATTERSHOT_CATAPULT_TP =              "Increase damage taken from all sources by |cFFFFFF20|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SCATTERSHOT_CATAPULT_GROUND_TP =       "Enemies in the area take Physical Damage every |cFFFFFF1|r second and take |cFFFFFF20|r% more damage from all sources for |cFFFFFF6|r seconds.",
    SI_LUIE_SKILL_COLD_STONE_TREBUCHET =                 "Cold Stone Trebuchet",
    SI_LUIE_SKILL_COLD_FIRE_TREBUCHET =                  "Cold Fire Trebuchet",
    SI_LUIE_SKILL_COLD_FIRE_BALLISTA =                   "Cold Fire Ballista",
    SI_LUIE_SKILL_GUARD_DETECTION =                      "Vigilance",
    SI_LUIE_SKILL_GUARD_DETECTION_TP =                   "Guards are particularly vigilant and can see nearby players that are hiding in stealth.",
    SI_LUIE_SKILL_BLESSING_OF_WAR_TP =                   "Increase Alliance Points earned by |cFFFFFF20|r% for |cFFFFFF1|r hour.\n\nOnly active while in Cyrodiil or Cyrodiil delves.",
    SI_LUIE_SKILL_PUNCTURE_CYRODIIL_TP =                 "Increase damage taken by |cFFFFFF30|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_RAZOR_ARMOR_TP =                       "Reduce damage taken by |cFFFFFF30|r% for |cFFFFFF<<1>>|r seconds.\n\nWhile active the armor returns Physical Damage to attackers.",
    SI_LUIE_SKILL_PUNCTURING_CHAINS_TP =                 "Increase damage taken by |cFFFFFF21.5|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_UNSTABLE_CORE_CYRODIIL_TP =            "Your single target ranged abilities are reflected back on you for |cFFFFFF<<1>>|r seconds.\n\nThe core explodes when this effect ends, dealing Magic Damage.",
    SI_LUIE_SKILL_SHATTERING_PRISON_CYRODIIL_TP =        "Disoriented for |cffffff<<1>>|r <<1[second/seconds]>>.\n\nThe prison shatters when this effect ends, dealing Magic Damage.",
    SI_LUIE_SKILL_LETHAL_ARROW_CYRODIIL_TP =             "Reduce healing received by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SIEGE_SHIELD_CYRODIIL_TP =             "Negate damage taken from Siege Weapons for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_POWER_BASH_CYRODIIL_TP =               "Stunned for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends you will be disoriented for |cffffff15|r seconds.",
    SI_LUIE_SKILL_ELDER_SCROLL_TP =                      "Carrying the |cFFFFFF<<1>>|r.",
    SI_LUIE_SKILL_MEATBAG_CATAPULT_AOE_TP =              "Taking Disease Damage every |cFFFFFF1|r second.\n\nHealing and Health Recovery reduced by |cFFFFFF50|r% for |cFFFFFF6|r seconds whenever you take damage from this effect.",
    SI_LUIE_SKILL_SCATTERSHOT_CATAPULT_AOE_TP =          "Taking Physical Damage every |cFFFFFF1|r second.\n\nIncrease damage taken from all sources by |cFFFFFF20|r% for |cFFFFFF6|r seconds whenever you take damage from this effect.",

    SI_LUIE_SKILL_CONSUME_LIFEFORCE =                    "Consume Lifeforce",
    SI_LUIE_SKILL_RUINOUS_CYCLONE =                      "After |cFFFFFF2|r seconds, enemies within |cFFFFFF8|r meters take Physical Damage every |cFFFFFF0.5|r seconds for |cFFFFFF7|r seconds as long as the channel is maintained.\n\nEnemies within |cFFFFFF15|r meters are pulled closer to you while channeling.",

    ----------------------------------------------------------------
    -- BATTLEGROUNDS -----------------------------------------------
    ----------------------------------------------------------------

    SI_LUIE_SKILL_MARK_OF_THE_WORM_TP =                  "Cursed with a magical bomb that explodes after |cFFFFFF<<1>>|r seconds, dealing Magic Damage.",

    ----------------------------------------------------------------
    -- TRAPS -------------------------------------------------------
    ----------------------------------------------------------------

    SI_LUIE_SKILL_LAVA_STACK_TP =                        "Taking increasing Flame Damage every |cFFFFFF0.75|r seconds.\n\nDamage taken increased by |cFFFFFF75|r% per stack.",
    SI_LUIE_SKILL_LAVA_TP =                              "Taking Flame Damage every |cFFFFFF0.75|r seconds.",
    SI_LUIE_SKILL_LAVA_TRAP =                            "Lava Trap",
    SI_LUIE_SKILL_LIGHTNING_TRAP =                       "Lightning Trap",
    SI_LUIE_SKILL_SPIKE_TRAP_TP =                        "Movement Speed reduced by |cFFFFFF25|r% for |cFFFFFF5|r seconds.\n\nImmobilized for |cFFFFFF0.8|r seconds.",
    SI_LUIE_SKILL_SPIKE_TRAP_AURIDON_TP =                "Movement Speed reduced by |cFFFFFF25|r% for |cFFFFFF10|r seconds.\n\nThis effect stacks up to |cFFFFFF3|r times, to a maximum of |cFFFFFF75|r% Movement Speed reduction.\n\nStunned for |cFFFFFF1|r second.",

    ----------------------------------------------------------------
    -- SETS --------------------------------------------------------
    ----------------------------------------------------------------

    -- Set Names
    SI_LUIE_SKILL_SET_BOGDAN_THE_NIGHTFLAME =            "Bogdan the Nightflame",
    SI_LUIE_SKILL_SET_LORD_WARDEN_DUSK =                 "Lord Warden Dusk",
    SI_LUIE_SKILL_SET_MALUBETH_THE_SCOURGER =            "Malubeth the Scourger",
    SI_LUIE_SKILL_SET_TROLL_KING =                       "Troll King",
    SI_LUIE_SKILL_SET_REDISTRIBUTION =                   "Redistribution",
    SI_LUIE_SKILL_SET_ICE_FURNACE =                      "Ice Furnace",
    SI_LUIE_SKILL_SET_COOLDOWN =                         "Перезарядка", -- Used as suffix for certain abilities internal cooldown
    SI_LUIE_SKILL_DISGUISE_MONKS_DISGUISE =              "Monk\'s Disguise",

    -- Weapon Sets
    SI_LUIE_SKILL_SET_ASYLUM_BOW =                       "Your next Snipe, Scatter Shot, or Poison Arrow used within |cffffff6|r seconds deals |cffffff<<1>>|r% additional damage.", -- TODO: Translate
    SI_LUIE_SKILL_SET_ASYLUM_DESTRUCTION_STAFF =         "Каждое третье применение Force Shock в течение |cffffff10|r секунд будет всегда накладывать эффекты Burning, Concussion и Chilled.",
    SI_LUIE_SKILL_SET_ASYLUM_DESTRUCTION_STAFF_PERFECT = "Каждое второе применение Force Shock в течение |cffffff10|r секунд будет всегда накладывать эффекты Burning, Concussion и Chilled.",
    SI_LUIE_SKILL_SET_ASYLUM_RESTORATION_STAFF =         "Reduce the cost of your Magicka and Stamina healing abilities by |cffffff<<1>>|r% for |cffffff3|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_MAELSTROM_DW =                     "Ваше следующие применение DoT-способности в течение |cffffff10|r секунд даст |cffffff2003|r урона Заклинаниями и Оружием.",
    SI_LUIE_SKILL_SET_MAELSTROM_1H =                     "Ваша следующая полностью заряженная Силовая атака, применённая в течение |cffffff5|r секунд дополнительно восстановит |cffffff2000|r Магии и Запаса сил.",
    SI_LUIE_SKILL_SET_MASTER_1H =                        "Gain up to |cffffff2500|r Spell and Physical Resistance for |cffffff3|r seconds based off the amount you healed with Puncturing Remedy.", -- TODO: Translate
    SI_LUIE_SKILL_SET_BLACKROSE_1H_TP =                  "Снижает стоимость применения следующей способности ветки Одноручного оружия и щита на |cffffff100|r%.",
    SI_LUIE_SKILL_SET_BLACKROSE_DESTRO_TP =              "Afflicted with consecutive Flame, Shock, and Frost Damage every |cffffff2|r seconds for |cffffff8|r seconds.", -- TODO: Translate

    -- Monster Helms
    SI_LUIE_SKILL_SET_BALORGH =                          "Увеличивает урон от Оружия и Заклинаний на значение, вдвое большее, чем потраченные при применении ульты очки, на |cFFFFFF10|r секунд.",
    SI_LUIE_SKILL_SET_BOGDAN =                           "You and allies within |cFFFFFF5|r meters of the totem are healed every |cFFFFFF1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_SET_DOMIHAUS_BUFF_STAMINA =            "Повышает урон от Оружия, пока находитесь в круге.",
    SI_LUIE_SKILL_SET_DOMIHAUS_DAMAGE_STAMINA =          "Enemies on the edge of the ring take Physical Damage every |cffffff1|r second.\n\nIncrease Weapon Damage while standing within the ring.",
    SI_LUIE_SKILL_SET_DOMIHAUS_BUFF_MAGICKA =            "Повышает урон от Заклинаний, пока находитесь в круге.",
    SI_LUIE_SKILL_SET_DOMIHAUS_DAMAGE_MAGICKA =          "Enemies on the edge of the ring take Flame Damage every |cffffff1|r second.\n\nIncrease Spell Damage while standing within the ring.", -- TODO: Translate
    SI_LUIE_SKILL_SET_EARTHGORE =                        "You and allies in the pool of blood are healed every |cFFFFFF1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_SET_GROTHDARR =                        "Enemies within |cFFFFFF8|r meters take Flame Damage every |cFFFFFF1|r секунду в течение |cFFFFFF5|r секунд.",
    SI_LUIE_SKILL_SET_ICEHEART =                         "Absorbing damage for |cFFFFFF<<1>>|r seconds.\n\nEnemies within |cFFFFFF5|r meters take Frost Damage every |cFFFFFF1|r second while the damage shield holds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_ILAMBRIS =                         "Enemies within |cffffff4|r meters of the meteor shower take <<1>> Damage every |cFFFFFF1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_SET_LORD_WARDEN_BUFF =                 "You and allies within |cFFFFFF8|r meters of the shadow orb have increased Physical and Spell Resistance.", -- TODO: Translate
    SI_LUIE_SKILL_SET_MALUBETH =                         "Высасывает здоровье каждые |cFFFFFF0.5|r секунды в течение |cFFFFFF4|r секунд, пока луч активен.",
    SI_LUIE_SKILL_SET_MAW_OF_THE_INFERNAL =              "A fire breathing Daedroth fights at your side. The daedroth remains for |cFFFFFF15|r seconds or until killed.", -- TODO: Translate
    SI_LUIE_SKILL_SET_MIGHTY_CHUDAN =                    "Mighty Chudan",
    SI_LUIE_SKILL_SET_MOLAG_KENA_TP =                    "При нанесении урона |cFFFFFF2|r последовательными обычными атаками, активируется способность |cFFFFFFOverload|r на |cFFFFFF6|r секунд.",
    SI_LUIE_SKILL_SET_MOLAG_KENA_OVERKILL_TP =           "Увеличивает урон от Оружия и Заклинания, но повышает стоимость способностей на |cFFFFFF20|r% в течение |cFFFFFF6|r секунд.",
    SI_LUIE_SKILL_SET_PIRATE_SKELETON_TP =               "Gain Major Protection and Minor Defile for |cFFFFFF12|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_SENTINEL_OF_REKUGAMZ_TP =          "After |cFFFFFF2|r seconds, you and allies within |cffffff5|r meters of the Dwemer Spider are healed every |cffffff1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_SET_SHADOWREND_TP =                    "A shadowy Clannfear fights at your side. The clannfear remains for |cFFFFFF15|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_SLIMECRAW =                        "Slimecraw",
    SI_LUIE_SKILL_SET_SPAWN_OF_MEPHALA_TP =              "Противники в радиусе |cffffff4|r метров от паутины получают урон Ядом каждую |cffffff1|r секунду, а их скорость передвижения снижена на  |cffffff50|r% в течение |cffffff10|r секунд.",
    SI_LUIE_SKILL_SET_STORMFIST_TP =                     "Enemies within |cffffff4|r meters of the thunderfist take Shock Damage every |cffffff1|r second.\n\nAfter |cffffff3|r seconds the fist closes, dealing Physical Damage.", -- TODO: Translate
    SI_LUIE_SKILL_STORMFIST_GROUND_TP =                  "Taking Shock Damage every |cFFFFFF1|r second.\n\nAfter |cffffff3|r seconds the fist closes, dealing Physical Damage.", -- TODO: Translate
    SI_LUIE_SKILL_SET_ENGINE_GUARDIAN =                  "Восстанавливает <<1>> каждые |cffffff0.5|r секунды в течение |cffffff6.5|r секунд.",
    SI_LUIE_SKILL_SET_THE_TROLL_KING_TP =                "Восстановление Здоровья увеличено в течение |cffffff10|r секунд.",
    SI_LUIE_SKILL_SET_THURVOKUN_TP =                     "Enemies in the pool take Disease Damage every |cffffff1|r second and are afflicted with Minor Maim and Minor Defile for |cffffff4|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_ZAAN_TP =                          "Afflicted with Flame Damage every |cffffff1|r second for |cffffff5|r seconds while the beam holds.\n\nDeals |cFFFFFF50|r% increased damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_SET_ENERGY_CHARGE =                    "Energy Charge",
    SI_LUIE_SKILL_SET_ENERGY_CHARGE_TP =                 "Gain an Energy Charge for |cffffff<<1>>|r seconds when you block an attack.\n\nWhen you gain |cffffff6|r charges, release the energy, restoring Stamina and Magicka and Healing.",
    SI_LUIE_SKILL_SET_MERIDIAS_FAVOR_TP =                "Restoring Magicka or Stamina, whichever maximum is higher, every |cffffff1|r second for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_SET_AURORANS_THUNDER_TP =              "Enemies in a cone in front of you take Shock Damage every |cffffff0.5|r seconds for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_SET_TZOGVINS_WARBAND_TP =              "Increase Weapon Critical for |cffffff10|r seconds, stacking up to |cffffff10|r times.\n\nAt max stacks, you also gain Minor Force.",
    SI_LUIE_SKILL_SET_FROZEN_WATCHER_TP =                "Nearby enemies take Frost Damage every |cffffff1|r second while you are blocking.\n\nYour blizzard has a |cffffff15|r% chance of inflicting Chilled on enemies damaged.",

    -- Crafted Sets
    SI_LUIE_SKILL_SET_ALESSIAS_BULWARK =                 "Урон от Оружия снижен на |cffffff10|r% в течение |cFFFFFF5|r секунд.",
    SI_LUIE_SKILL_SET_CLEVER_ALCHEMIST =                 "Урон от оружие и Заклинаний увеличен в течение |cFFFFFF15|r секунд.",
    SI_LUIE_SKILL_SET_ETERNAL_HUNT =                     "Взрывается при приближении противника, нанося урон Ядом и обездвиживая их на |cFFFFFF1.5|r секунды.",
    SI_LUIE_SKILL_SET_MORKULDIN =                        "An animated weapon fights at your side. The animated weapon remains for |cFFFFFF15|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_TAVAS_FAVOR =                      "Generating |cFFFFFF3|r Ultimate every |cFFFFFF1|r second for |cFFFFFF3|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_TRIAL_BY_FIRE =                    "Повышает <<1>> сопротивляемость в течении |cffffff4|r секунд.",
    SI_LUIE_SKILL_SET_VARENS_LEGACY =                    "Your next direct damage area of effect attack used within |cFFFFFF<<1>>|r seconds deals additional damage.", -- TODO: Translate
    SI_LUIE_SKILL_SET_MECHANICAL_ACUITY =                "Повышает шанс критического удара Заклинанием и Оружием до |cFFFFFF100|r% в течение |cffffff5|r секунд.",
    SI_LUIE_SKILL_SET_ADEPT_RIDER =                      "Enemies in the dust cloud take Physical Damage every |cffffff1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_SET_SENCHE_RAHTS_GRIT =                "Increase healing received by |cffffff6|r% and Physical and Spell Resistance for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_SET_VASTARIES_TUTELAGE =               "Increase Weapon and Spell Damage and reduce the Magicka, Stamina, and Health cost of abilities by |cffffff10|r% for |cffffff<<1>>|r seconds.",

    -- Light / Medium / Heavy Armor Sets
    SI_LUIE_SKILL_SET_BAHRAHAS_CURSE_TP =                "Enemies in the desecrated ground take Magic Damage every |cffffff1|r second and have their Movement Speed reduced by |cffffff70|r%.\n\nYou heal for |cffffff100|r% of the damage done.", -- TODO: Translate
    SI_LUIE_SKILL_BAHRAHAS_CURSE_GROUND_TP =             "Taking Magic Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF70|r%.\n\nEach tick heals your attacker.", -- TODO: Translate
    SI_LUIE_SKILL_SET_WAY_OF_MARTIAL_KNOWLEDGE_TP =      "Increase damage taken from the next attack by |cffffff10|r%.", -- TODO: Translate
    SI_LUIE_SKILL_SET_BRIARHEART_TP =                    "Ваши критические удары исцеляют вас в течение |cffffff10|r секунд.",
    SI_LUIE_SKILL_SET_SENCHE_TP =                        "Увеличен урон от Оружия и шанс критического удара на |cffffff5|r секунд.",
    SI_LUIE_SKILL_SET_UNFATHOMABLE_DARKNESS_TP =         "Every |cffffff3|r seconds a crow will be sent to peck the closest enemy within |cffffff12|r meters, dealing Physical Damage.", -- TODO: Translate
    SI_LUIE_SKILL_SET_SHALK_EXOSKELETON =                "Shalk Exoskeleton",
    SI_LUIE_SKILL_SET_ORDER_OF_DIAGNA =                  "Order of Diagna",
    SI_LUIE_SKILL_SET_STORM_KNIGHT_TP =                  "Enemies within |cffffff5|r meters take Shock Damage every |cffffff2|r seconds for |cffffff6|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_VAMPIRE_CLOAK =                    "Vampire Cloak",
    SI_LUIE_SKILL_SET_WARRIOR_POET =                     "Warrior-Poet",
    SI_LUIE_SKILL_SET_GRACE_OF_GLOOM_TP =                "Your Light and Heavy Attacks heal you for the next |cffffff5|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_DRAUGRS_REST_TP =                  "You and allies within |cffffff5|r meters of the consecrated circle heal every |cffffff1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_SET_OVERWHELMING_SURGE_TP =            "The closest enemy within |cffffff12|r meters takes Shock Damage every |cffffff1|r second for |cffffff6|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SANCTUARY_TP =                         "Увеличивает получаемое исцеление на |cffffff12|r%.",
    SI_LUIE_SKILL_SHROUD_OF_THE_LICH_TP =                "Увеличивает восстановление Магии на |cffffff20|r секунд.",
    SI_LUIE_SKILL_SET_NOBLE_DUELIST =                    "Noble Duelist's Silks",
    SI_LUIE_SKILL_SET_WORMS_RAIMENT_TP =                 "Снижает стоимость способностей, расходующих Магию, на |cffffff4|r%.",
    SI_LUIE_SKILL_SET_HIRCINES_VENEER_TP =               "Снижает стоимость способностей, расходующих Запас сил, на |cffffff4|r%.",
    SI_LUIE_SKILL_SET_JAILBREAKER =                      "Jailbreaker",
    SI_LUIE_SKILL_PLAGUE_SLINGER_TP =                    "Выпускает ядовитый шар в ближайшего противника, нанося урон от Яда каждую |cffffff1|r секунду в течение |cffffff<<1>>|r секунд.",
    SI_LUIE_SKILL_SET_STORM_MASTER_TP =                  "Ваши Обычные атаки наносят урон от Электричества в течение |cffffff20|r секунд.",
    SI_LUIE_SKILL_SET_TOOTHROW =                         "Toothrow",
    SI_LUIE_SKILL_SET_BLOOD_SCENT =                      "When you deal Critical Damage with a melee Light Attack, you gain a stack of Blood Scent for |cffffff8|r seconds.\n\nWhen you gain |cffffff5|r stacks, you become Frenzied for |cffffff5|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_FRENIZED =                         "Увеличивает урон от Обычных атак и их скорость на |cffffff50|r% а течение |cffffff5|r секунд.",
    SI_LUIE_SKILL_SET_EBON_ARMORY =                      "Увеличивает максимальное Здоровье.",
    SI_LUIE_SKILL_SET_EMBERSHIELD =                      "Increase Spell Resistance.\n\nEnemies within |cffffff5|r meters take Flame Damage every |cffffff1|r second for |cffffff6|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_HAGRAVENS_GARDEN =                 "Any damage you take from enemies outside of the preservation is reduced by |cffffff50|r%.\n\nThe first time an enemy tries to enter the preservation they are knocked back |cffffff5|r meters.", -- TODO: Translate
    SI_LUIE_SKILL_SET_JOLTING_ARMS =                     "Increase Spell Resistance for |cffffff<<1>>|r seconds and your next Bash deals additional Shock Damage.", -- TODO: Translate
    SI_LUIE_SKILL_SET_LEECHING_PLATE_TP =                "Enemies in the |cffffff5|r meter radius of the poison cloud take Poison Damage every |cffffff1|r second.\n\nYou heal for |cffffff100|r% of the damage dealt.",
    SI_LUIE_SKILL_SET_MEDUSA =                           "Medusa",
    SI_LUIE_SKILL_SET_HAND_OF_MEPHALA_TP =               "Enemies in the web have their Movement Speed reduced by |cffffff50|r% for |cffffff5|r seconds.\n\nAfter |cffffff5|r seconds the webs burst into venom, dealing Poison Damage and applying Minor Fracture to any enemy hit for |cffffff5|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_RATTLECAGE =                       "Rattlecage",
    SI_LUIE_SKILL_SET_DREUGH_KING_SLAYER =               "Dreugh King Slayer",
    SI_LUIE_SKILL_LEECHING_PLATE_GROUND_TP =             "Taking Poison Damage every |cFFFFFF1|r second.\n\nEach tick heals your attacker for |cffffff100|r% of the damage dealt.",
    SI_LUIE_SKILL_HAND_OF_MEPHALA_GROUND_TP =            "Movement Speed reduced by |cffffff50|r%.\n\nAfter |cffffff5|r seconds the webs burst into venom, dealing Poison Damage and applying Minor Fracture for |cffffff5|r seconds.",

    -- Trial Sets
    SI_LUIE_SKILL_SET_BERSERKING_WARRIOR_TP =            "Increase Weapon Critical for |cffffff<<1>>|r seconds, stacking up to |cffffff5|r times.", -- TODO: Translate
    SI_LUIE_SKILL_SET_ETERNAL_IMMORTAL_WARRIOR_TP =      "Вы недавно были обращены в статую и не можете избежать смерти этим способом снова.",
    SI_LUIE_SKILL_SET_DESTRUCTIVE_MAGE_TP =              "Когда другой игрок поразит эту же цель полностью заряженной Силовой атакой, бомба взорвётся, нанося Магический урон всем противникам в радиусе |cffffff8|r метров.",
    SI_LUIE_SKILL_SET_HEALING_MAGE_TP =                  "Снижает урон от Оружия на |cffffff3|r секунды.",
    SI_LUIE_SKILL_SET_TWICE_FANGED_SERPENT_TP =          "Повышает Физическое пробитие на |cffffff3|r секунды, суммируется до |cffffff5|r раз.",
    SI_LUIE_SKILL_SET_LUNAR_BASTION_TP =                 "Absorb damage every |cffffff2|r seconds while standing in the lunar blessing.", -- TODO: Translate
    SI_LUIE_SKILL_SET_VESTMENT_OF_OLORIME_TP =           "You and allies standing in the circle of might gain Major Courage for |cffffff30|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_MANTLE_OF_SIRORIA_TP =             "Standing in the ring grants you a stack of Siroria's Boon every |cffffff1|r second.", -- TODO: Translate
    SI_LUIE_SKILL_SET_SIRORIAS_BOON_TP =                 "Увеличивает урон от Заклинаний на |cffffff30|r в течение |cffffff5|r секунд, суммируется максимум до |cffffff20|r раз.",
    SI_LUIE_SKILL_SET_RELEQUENS_TP =                     "Afflicted with Physical damage every |cffffff1|r second for |cffffff5|r seconds.", -- TODO: Translate
    SI_LUIE_SKILL_SET_EYE_OF_NAHVIINTAAS =               "Reduce the Magicka, Stamina, and Health cost of abilities by |cffffff12|r% for |cffffff<<1>>|r seconds.",

    -- Battleground Sets
    SI_LUIE_SKILL_SET_COWARDS_GEAR =                     "Coward's Gear",
    SI_LUIE_SKILL_SET_VANGUARDS_CHALLENGE_TP =           "Наносите на |cffffff100|r% больше урона игроку, который провоцирует вас, но на |cffffff50|r% меньше урона другим игрокам в течение |cffffff15|r секунд.",

    -- Imperial City Sets
    SI_LUIE_SKILL_SET_GALERIONS_REVENGE_TP =             "Marked for |cffffff15|r seconds.\n\nIf |cffffff6|r Marks of Revenge are applied they detonate for Magic Damage.", -- TODO: Translate
    SI_LUIE_SKILL_SET_MERITORIUS_SERVICE_TP =            "Increase Physical and Spell Resistance for |cffffff2|r minutes.", -- TODO: Translate
    SI_LUIE_SKILL_SET_PHOENIX_TP =                       "Вы недавно возродились как феникс и не можете избежать смерти этим способом снова.",
    SI_LUIE_SKILL_SET_VICECANON_OF_VENOM_TP =            "Afflicted with Poison Damage every |cffffff1|r second for |cffffff<<1>>|r seconds.\n\nEach tick heals your attacker.",

    -- Alliance War Sets
    SI_LUIE_SKILL_SET_SOLDIER_OF_ANGUISH_TP =            "Нивелирует получаемое исцеление в течение |cffffff4|r секунд.",
    SI_LUIE_SKILL_SET_SPELL_STRATEGIST_TP =              "Увеличивает урон от Заклинаний против цели в течение |cffffff5|r секунд.",
    SI_LUIE_SKILL_SET_SUCCESSION_TP =                    "Увеличивает урон от Заклинаний атакам, наносящим урон с типом \"<<1>>\", в течение |cffffff4|r секунд.",
    SI_LUIE_SKILL_SET_PARA_BELLUM_TP =                   "Даёт щит от урона, если вы не получали никакого урона в течение как минимум |cffffff10|r секунд.",
    SI_LUIE_SKILL_SET_GLORIOUS_DEFENDER_TP =             "|cffffff100|r% шанс уклониться от следующей атаки.",
    SI_LUIE_SKILL_SET_HEALERS_HABIT =                    "Healer's Habit",
    SI_LUIE_SKILL_SET_CYRODIILS_LIGHT_TP =               "Ваша следующая способность, расходующая Магию, применённая в течение |cffffff30|r секунд, будет применена бесплатно.",
    SI_LUIE_SKILL_SET_MORAG_TONG_TP =                    "Увеличивает урон, получаемый от способностей с уроном от Яда, на |cffffff10|r% в течение |cffffff5|r секунд.",
    SI_LUIE_SKILL_SET_WARRIORS_FURY_TP =                 "Increase Weapon Damage for |cffffff6|r seconds when you take Critical Damage, stacking up to |cffffff25|r times.",
    SI_LUIE_SKILL_SET_ROBES_OF_TRANSMUTATION_TP =        "Increase Critical Resistance for |cffffff20|r seconds.",
    SI_LUIE_SKILL_SET_BECKONING_STEEL_TP =               "Reduce damage taken from projectiles by |cffffff10|r%.",
    SI_LUIE_SKILL_SET_SENTRY_TP =                        "Dramatically increase Stealth Detection radius for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_SET_SENTRY_ICD_TP =                    "You have recently crouched to increase detection and cannot do so again.",

    ----------------------------------------------------------------
    -- NPC ABILITY / QUEST TOOLTIPS --------------------------------
    ----------------------------------------------------------------

    SI_LUIE_SKILL_ANCHOR_DROP =                          "Anchor Drop",
    SI_LUIE_SKILL_SHIELD_RUSH =                          "Shield Rush",
    SI_LUIE_SKILL_BLITZ =                                "Blitz",
    SI_LUIE_SKILL_BARRELING_CHARGE =                     "Barreling Charge",
    SI_LUIE_SKILL_ZOOM =                                 "Zoom",
    SI_LUIE_SKILL_PLOW =                                 "Plow",
    SI_LUIE_SKILL_DEFENSIVE_WARD =                       "Defensive Ward",
    SI_LUIE_SKILL_INSPIRE =                              "Inspire",
    SI_LUIE_SKILL_HIDE_IN_SHADOWS =                      "Hide in Shadows",
    SI_LUIE_SKILL_SHADOWY_BARRIER =                      "Shadowy Barrier",
    SI_LUIE_SKILL_MIGHTY_CHARGE =                        "Mighty Charge",
    SI_LUIE_SKILL_DETECTION =                            "Detection",
    SI_LUIE_SKILL_IMPROVED_SHOCK_TORRENT =               "Improved Shock Torrent",
    SI_LUIE_SKILL_SIEGE_BARRIER =                        "Siege Barrier",
    SI_LUIE_SKILL_PUNCTURING_CHAINS =                    "Puncturing Chains",
    SI_LUIE_SKILL_IMPROVED_VOLLEY =                      "Improved Volley",
    SI_LUIE_SKILL_FIRE_TORRENT =                         "Fire Torrent",
    SI_LUIE_SKILL_RIP_AND_TEAR =                         "Rip and Tear",
    SI_LUIE_SKILL_LEECHING_BITE =                        "Leeching Bite",
    SI_LUIE_SKILL_FETCHERFLY_COLONY =                    "Fetcherfly Colony",
    SI_LUIE_SKILL_EMPOWER_ATRONACH_FLAME =               "Empower Atronach: Flame",
    SI_LUIE_SKILL_EMPOWER_ATRONACH_FROST =               "Empower Atronach: Frost",
    SI_LUIE_SKILL_EMPOWER_ATRONACH_STORM =               "Empower Atronach: Storm",
    SI_LUIE_SKILL_EMPOWER_ATRONACH_FLAME_TP =            "The death of a nearby Flame Atronach has empowered this Air Atronach, granting it the use of |cFFFFFFFlame Tornado|r for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_EMPOWER_ATRONACH_FLAME_UNLIMITED_TP =  "This Air Atronach is empowered, granting it the use of |cFFFFFFFlame Tornado|r.",
    SI_LUIE_SKILL_EMPOWER_ATRONACH_STORM_TP =            "The death of a nearby Storm Atronach has empowered this Air Atronach, granting it the use of |cFFFFFFLightning Rod|r for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_EMPOWER_ATRONACH_FROST_TP =            "The death of a nearby Frost Atronach has empowered this Air Atronach, granting it the use of |cFFFFFFIce Vortex|r for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_STORM_BOUND_TP =                       "Afflicted with Shock Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_CHILLING_AURA_TP =                     "Nearby enemies have their Movement Speed reduced by |cFFFFFF20|r%.",
    SI_LUIE_SKILL_RADIANCE_TP =                          "Nearby enemies take Flame Damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_LIGHTNING_ROD_TP =                     "Afflicted with Shock Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Shock Damage if the channel is finished.",
    SI_LUIE_SKILL_COLOSSAL_STOMP =                       "Colossal Stomp",
    SI_LUIE_SKILL_DUST_CLOUD =                           "Dust Cloud",
    SI_LUIE_SKILL_BATTLE_SPIRIT =                        "Battle Spirit",
    SI_LUIE_SKILL_COLD_FIRE_TRAP =                       "Cold Fire Trap",
    SI_LUIE_SKILL_LAVA_FOOT_STOMP =                      "Lava Foot Stomp",
    SI_LUIE_SKILL_KNIFE_JUGGLING =                       "Knife Juggling",
    SI_LUIE_SKILL_TORCH_JUGGLING =                       "Torch Juggling",
    SI_LUIE_SKILL_WALL_OF_FLAMES =                       "Wall of Flames",
    SI_LUIE_SKILL_TRAIL_OF_FLAMES =                      "Trail of Flames",
    SI_LUIE_SKILL_CONSECRATE_SHRINE =                    "Consecrate Shrine",
    SI_LUIE_SKILL_UNSTABLE_PORTAL =                      "Unstable Portal",
    SI_LUIE_SKILL_STABILIZE_PORTAL =                     "Stabilize Portal",
    SI_LUIE_SKILL_CLOSE_UNSTABLE_RIFT =                  "Close Unstable Rift",
    SI_LUIE_SKILL_FLAME_BLOSSOM =                        "Flame Blossom",
    SI_LUIE_SKILL_SAHDINAS_ESSENCE =                     "Sahdina's Essence",
    SI_LUIE_SKILL_RASHOMTAS_ESSENCE =                    "Rashomta's Essence",
    SI_LUIE_SKILL_POLYMORPH_SKELETON =                   "Polymorph: Skeleton",
    SI_LUIE_SKILL_DRAIN_ENERGY =                         "Drain Energy",
    SI_LUIE_SKILL_FIRELIGHT_TP =                         "Увеличивает Запас сил на |cFFFFFF5|r% в течение |cFFFFFF30|r минут.",
    SI_LUIE_SKILL_BARRIER_REBUKE =                       "Barrier Rebuke",
    SI_LUIE_SKILL_TELEPORT_SCROLL =                      "Teleport Scroll",
    SI_LUIE_SKILL_BIND_HANDS =                           "Bind Hands",
    SI_LUIE_SKILL_BIND_BEAR =                            "Bind Bear",
    SI_LUIE_SKILL_IMPROVED =                             "Improved",
    SI_LUIE_SKILL_AETHERIAL_SHIFT =                      "Aetherial Shift",
    SI_LUIE_SKILL_FREE_SPIRIT =                          "Free Spirit",
    SI_LUIE_SKILL_UNBIND =                               "Unbind",
    SI_LUIE_SKILL_BACKFIRE =                             "Backfire",
    SI_LUIE_SKILL_DIVINE_SPEED_TP =                      "A divine blessing boosts your Movement Speed for |cFFFFFF2|r minutes.", -- TODO: ADD % -- TODO: Translate
    SI_LUIE_SKILL_QUEST_LIGHTNING_FURY_TP =              "Lightning courses through your body causing all weapon attacks to deal Shock Damage.", -- TODO: Translate
    SI_LUIE_SKILL_MANTLES_SHADOW =                       "Mantle's Shadow",
    SI_LUIE_SKILL_THROW_WATER =                          "Throw Water",
    SI_LUIE_SKILL_VISION_JOURNEY_TP =                    "Вам открывается истинная природа леса.",
    SI_LUIE_SKILL_SNAKE_SCALES_TP =                      "Увеличивает наносимый урон на |cffffff5|r% и снижает получаемый урон на |cffffff5|r% пока вы в Гратвуде.",
    SI_LUIE_SKILL_WOLFS_PELT_TP =                        "Увеличивает скорость передвижения на |cffffff4|r% и наносимый урон на |cffffff5|r% пока вы в Гратвуде.",
    SI_LUIE_SKILL_TIGERS_FUR_TP =                        "Увеличивает скорость передвижения на |cffffff4|r% и снижает получаемый урон на |cffffff5|r% пока вы в Гратвуде.",
    SI_LUIE_SKILL_SOUL_BINDING_TP =                      "Вызывает ослабленную душу даэдра, заряжающую сигильскую жеоду.",
    SI_LUIE_SKILL_EMPOWER_TWILIT_HEART =                 "Empower Twilit Heart",
    SI_LUIE_SKILL_BLACKSAPS_BREW_TP =                    "Повышает скорость передвижения на |cffffff4|r% и снижает получаемый урон на |cffffff10|r% в течение |cffffff30|r минут.",
    SI_LUIE_SKILL_SPIRIT_ARMOR_TP =                      "Увеличивает броню на |cffffff5|r%.",
    SI_LUIE_SKILL_RESTRICTING_VINES =                    "Restricting Vines",
    SI_LUIE_SKILL_CHANGE_CLOTHES =                       "Change Clothes",
    SI_LUIE_SKILL_FANCY_CLOTHING =                       "Fancy Clothing",
    SI_LUIE_SKILL_FANCY_CLOTHING_TP =                    "Dressed to impress!",
    SI_LUIE_SKILL_BURROW_TP =                            "Вы защищены от вреда и сокрыты земным покровом.",
    SI_LUIE_SKILL_SERPENT_SPIT =                         "Serpent Spit",
    SI_LUIE_SKILL_SHADOW_WOOD =                          "Shadow Wood",
    SI_LUIE_SKILL_SHADOW_WOOD_TP =                       "Слуга тени принца Неймона утащил вас в Теневое древо.",
    SI_LUIE_SKILL_BEAR_FEROCITY_TP =                     "Immune to all crowd control and movement impairing effects for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_BOSS_CC_IMMUNITY =                     "Boss Immunities",
    SI_LUIE_SKILL_SLAUGHTERFISH_ATTACK_TP =              "You are being devoured by a swarm of Slaughterfish, turn back before it's too late!",
    SI_LUIE_SKILL_RECOVER_TP =                           "Wounded and out of the fight, recovering Health over |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_RECOVER_DUEL_TP =                      "Wounded and recovering, you will heal after |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_BACKSTABBER_TP =                       "Increase damage done by |cffffff20|r% when you attack an enemy from behind.",
    SI_LUIE_SKILL_HARDENED_CARAPACE_TP =                 "Reduce damage taken by |cffffff<<1>>|r% for each stack remaining.\n\nLose one stack upon taking any damage.",
    SI_LUIE_SKILL_CLEAVE_STANCE_TP =                     "Cleaving with wild abandon for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_DEFENSIVE_WARD_TP =                    "Reduce damage taken by |cFFFFFF75|r% for |cFFFFFF<<1>>|r seconds as long as the channel is maintained.",
    SI_LUIE_SKILL_SOUL_TETHER_NPC_TP =                   "Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF8|r seconds.\n\nStunned for |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_SIPHONING_STRIKES_NPC_TP =             "Your attacks heal you while this ability is toggled on.",
    SI_LUIE_SKILL_FOCUSED_HEALING_TP =                   "Healing every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds while the channel is maintained.\n\nHealing doubles in power after |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_RITE_OF_PASSAGE_NPC_TP =               "Reduce damage taken by |cFFFFFF80|r% while the channel is maintained.",
    SI_LUIE_SKILL_INJECT_LARVA_TP =                      "You have been injected with a wasp larva. At the end of its |cFFFFFF<<1>>|r second gestation, it will burst out of you, dealing Physical Damage and spawning a Young Wasp.",
    SI_LUIE_SKILL_THROW_DAGGER_TP =                      "Afflicted with Bleeding Damage every |cFFFFFF1|r second for |cFFFFFF8|r seconds.\n\nMovement Speed reduced by |cFFFFFF40|r% for |cFFFFFF4|r seconds.",
    SI_LUIE_SKILL_AGONY_TP =                             "Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen this effect ends you will be afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF7|r seconds.",
    SI_LUIE_SKILL_HARMONY_TP =                           "Reduce damage taken by |cFFFFFF20|r% for |cFFFFFF<<1>>|r seconds as long as another Lamia is nearby.",
    SI_LUIE_SKILL_SUMMON_SPECTRAL_LAMIA_TP =             "A Spectral Lamia fights at your side. The lamia remains for |cFFFFFF2|r minutes or until killed.",
    SI_LUIE_SKILL_WEAKNESS_NPC_SUMMON_TP =               "Reduce damage done by |cFFFFFF50|r% as long as a summoned creature fights at your side.",
    SI_LUIE_SKILL_WEAKNESS_LION_TP =                     "Reduce damage done by |cFFFFFF15|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_ICE_BARRIER_TP =                       "Intercepting frontal attacks for the caster for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_DEVOUR_CLANNFEAR_TP =                  "Afflicted with Bleeding Damage every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds. \n\nEach tick heals the clannfear.",
    SI_LUIE_SKILL_AURA_OF_PROTECTION_TP =                "The Shaman and allies within the radius of the aura take |cFFFFFF25|r% less damage for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_AURA_OF_PROTECTION_OTHER_TP =          "Reduce damage taken by |cFFFFFF25|r% while in proximity of the Aura of Protection.",
    SI_LUIE_SKILL_AGONIZING_FURY_TP =                    "Movement Speed reduced by |cFFFFFF10|r% for |cFFFFFF<<1>>|r seconds.\n\nThis effect stacks up to |cFFFFFF5|r times, to a maximum of |cFFFFFF50|r% Movement Speed reduction.",
    SI_LUIE_SKILL_GRASPING_VINES_TP =                    "Afflicted with Bleeding Damage every |cFFFFFF0.5|r seconds and immobilized for |cFFFFFF<<1>>|r seconds.\n\nThe vines explode at the end of the duration, dealing fire damage if you do not move away.",
    SI_LUIE_SKILL_RETALIATION_NPC_TP =                   "Blocking and counterattacking any incoming hits for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_BRIARHEART_RESURRECTION_TP =           "A Hagraven has restarted the beating briarheart of this enemy, restoring them to life.",
    SI_LUIE_SKILL_ENRAGE_DEVOTED_TP =                    "Increase damage done by |cFFFFFF20|r% for |cFFFFFF2|r minutes.",
    SI_LUIE_SKILL_ICE_PILLAR_TP =                        "Nearby enemies are chilled, reducing their Movement Speed by |cFFFFFF60|r%.\n\nThe Ogre Shaman's Frost Bolts will apply a |cFFFFFF4|r second immobilize on any chilled targets.",
    SI_LUIE_SKILL_SUMMON_BEAST_TP =                      "A beast fights at your side. The beast remains for |cFFFFFF2|r minutes or until killed.",
    SI_LUIE_SKILL_CONTROL_BEAST_TP =                     "Increase damage done by |cFFFFFF83|r% for |cFFFFFF<<1>>|r seconds while the channel is maintained.",
    SI_LUIE_SKILL_HEALING_SALVE_TP =                     "Healing every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds while the channel is maintained.\n\nHealing doubles in power after |cFFFFFF2|r seconds, leading into a stronger burst heal at the end of the channel.",
    SI_LUIE_SKILL_LATCH_ON_TP =                          "Afflicted with Bleeding Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach tick heals the hoarvor.",
    SI_LUIE_SKILL_KOTU_GAVA_SWARM_TP =                   "Afflicted with Poison Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nAfter |cFFFFFF<<2>>|r <<2[second/seconds]>>, a swarm of Kotu Gava will spawn around you.",
    SI_LUIE_SKILL_HARDENED_SHELL_TP =                    "Chance when hit to reduce damage taken by |cFFFFFF50|r%.",
    SI_LUIE_SKILL_UNCANNY_DODGE_TP =                     "Unable to be taken off guard. Will always dodge the initial hit when engaged.",
    SI_LUIE_SKILL_BLOCK_NPC_TP =                         "Brace for attack, reducing damage taken and granting immunity to Stun and Knockback effects.\n\nIncoming melee Heavy Attacks will be counterattacked while active.",
    SI_LUIE_SKILL_CALL_ALLY_TP =                         "A summoned beast ally fights at your side. The beast remains for |cFFFFFF2|r minutes or until killed.",
    SI_LUIE_SKILL_VAMPIRIC_DRAIN_TP =                    "Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach tick heals the vampire.",
    SI_LUIE_SKILL_DEVOUR_HUNGER_TP =                     "Stunned and afflicted with Bleeding Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends you will be knocked back for |cFFFFFF1.5|r seconds.",
    SI_LUIE_SKILL_TORPOR_TP =                            "You are hallucinating.",
    SI_LUIE_SKILL_COLONIZE_TP =                          "After |cFFFFFF5|r seconds this Fetcherfly Colony will turn into a nest.",
    SI_LUIE_SKILL_FERAL_GUARDIAN_NPC_TP =                "A grizzly fights at your side. The grizzly remains for |cFFFFFF1|r minute or until killed.",
    SI_LUIE_SKILL_BASILISK_POWDER_TP =                   "Stunned and Silenced for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SHADOWY_DUPLICATE_TP =                 "Detonating after |cFFFFFF<<1>>|r seconds, dealing Magic Damage to nearby enemies and stunning them for |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_SHADOWY_BARRIER_TP =                   "Absorbing damage for |cFFFFFF5|r seconds.",
    SI_LUIE_SKILL_FIENDISH_HEALING_TP =                  "Healing every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds while the channel is maintained.\n\nHealing doubles in power after |cFFFFFF2|r seconds.\n\nEach tick enrages the Skaafin, increasing damage done by |cFFFFFF20|r%.",
    SI_LUIE_SKILL_SLASH_CLIFF_STRIDER_TP =               "Afflicted with Bleeding Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_WAR_HORN_NPC_TP =                      "Increase Max Health by |cFFFFFF15|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_RADIANT_MAGELIGHT_NPC_TP =             "Revealing nearby stealthed and invisible enemies.\n\nReduce damage taken from stealth attacks by |cFFFFFF50|r%.",
    SI_LUIE_SKILL_SUMMON_SPIDERLING_TP =                 "A spiderling fights at your side. The spiderling remains for |cFFFFFF2|r minutes or until killed.",
    SI_LUIE_SKILL_UNYIELDING_MACE_TP =                   "Afflicted with Bleeding Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF8|r seconds.\n\nStunned for |cFFFFFF1.5|r seconds.",
    SI_LUIE_SKILL_REFLECTIVE_SHADOWS_TP =                "Reflecting projectiles for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_STEAL_ESSENCE_TP =                     "Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Magic Damage if the channel is finished.",
    SI_LUIE_SKILL_DAMPEN_MAGIC_TP =                      "Absorbing |cFFFFFF40|r% of incoming Flame, Frost, Shock, and Magic Damage for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_FLAME_RAY_TP =                         "Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Flame Damage if the channel is finished.",
    SI_LUIE_SKILL_FROST_RAY_TP =                         "Afflicted with Frost Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Frost Damage if the channel is finished.",
    SI_LUIE_SKILL_LACERATE_GARGOYLE_TP =                 "Afflicted with Bleeding Damage every |cFFFFFF2.5|r seconds for |cFFFFFF16.5|r seconds.\n\nKnocked down for |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_VAMPIRIC_TOUCH_GARGOYLE_TP =           "Single target direct damage attacks restore Health.",
    SI_LUIE_SKILL_SUMMON_THE_DEAD_TP =                   "An risen undead companion fights at your side. The undead remains for |cFFFFFF2|r minutes or until killed.",
    SI_LUIE_SKILL_BURDENING_EYE_TP =                     "The Burdening Eye seeks out a nearby enemy and explodes, dealing Magic Damage and reducing the targets Movement Speed by |cFFFFFF80|r% for |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_SPELL_ABSORPTION_TP =                  "Reduce Flame, Frost, Shock, and Magic Damage taken by |cFFFFFF90|r% for |cFFFFFF<<1>>|r seconds while the channel is maintained.",
    SI_LUIE_SKILL_SHARD_SHIELD_TP =                      "Absorbing damage for |cFFFFFF5|r minutes.\n\nWhen the shield takes damage, as long as absorption remains, your attacker takes Physical Damage and is stunned for |cFFFFFF1.2|r seconds.",
    SI_LUIE_SKILL_TIL_DEATH_TP =                         "Protected from death by a bodyguard. When you take lethal damage the bodyguard will swap places with you and absorb the killing blow, providing you with immunity to damage and all negative effects for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_TIL_DEATH_SELF_TP =                    "Protecting a nearby ally from death. When your ally takes lethal damage, swap places with them and absorb the killing blow, providing you with immunity to damage and all negative effects for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_DUTIFUL_FURY_TP =                      "When a nearby ally takes damage, you enrage, causing your next attack to deal |cFFFFFF5|r% additional damage.",
    SI_LUIE_SKILL_DUTIFUL_FURY_PROC_TP =                 "Your next attack deals |cFFFFFF5|r% additional damage.",
    SI_LUIE_SKILL_ELEMENTAL_WEAPON_NPC_TP =              "Augment your next |cFFFFFF3|r uses of Chop or Cleave for |cFFFFFF<<1>>|r seconds.\n\nChop creates an elemental pool on the ground that deals Flame Damage every |cFFFFFF0.7|r seconds for |cFFFFFF5.5|r seconds.\n\nCleave fires 3 elemental waves, dealing Flame Damage to enemies in the path.",
    SI_LUIE_SKILL_BALEFUL_CALL_TP =                      "Increase Max Health and damage done by |cFFFFFF33|r%.",
    SI_LUIE_SKILL_REGENERATION_TROLL_TP =                "Regenerating Health every |cFFFFFF2.5|r seconds.",
    SI_LUIE_SKILL_CONSUMING_OMEN_TP =                    "Dealing Magic Damage to nearby allies every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_CONSUMING_OMEN_SNARE_TP =              "Movement speed reduced by |cFFFFFF50|r% for |cFFFFFF1.5|r seconds.",
    SI_LUIE_SKILL_CLOSE_WOUNDS_TP =                      "Healing every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds while the channel is maintained, leading into a stronger burst heal at the end of the channel.",
    SI_LUIE_SKILL_STATIC_FIELD_TP =                      "Enemies in the field take Shock Damage every |cFFFFFF1|r second while allied Dwemer can draw power from the field to |cFFFFFFOvercharge|r, increasing their damage done by |cFFFFFF25|r%.",
    SI_LUIE_SKILL_SHOCK_BARRAGE_TP =                     "Being targeted and bombarded by Shock Barrage, taking Shock Damage every |cFFFFFF0.75|r seconds for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_POLARIZING_FIELD_TP =                  "While active, the Polarizing Field returns Shock Damage to attackers.",
    SI_LUIE_SKILL_STATIC_SHIELD_TP =                     "Absorbing damage for |cFFFFFF<<1>>|r seconds.\n\nIf the shield is not destroyed it will detonate at the end of the duration, dealing Shock Damage to nearby enemies.",
    SI_LUIE_SKILL_TURRET_MODE_TP =                       "Charged by a power conduit, enabling the Sentry to shield itself with |cFFFFFFStatic Shield|r and use the |cFFFFFFThunderbolt|r ability.",
    SI_LUIE_SKILL_STATIC_CHARGE_TP =                     "Residual static energy from the Dolmen is suppressing your Health Recovery and you will be targeted by Static Charge, taking Oblivion damage.\n\nMove to reduce to the static buildup.",
    SI_LUIE_SKILL_INCAPACITATING_TERROR_TP =             "Feared and taking Frost Damage every |cFFFFFF3|r seconds.",
    SI_LUIE_SKILL_SPIRITUAL_CLOAK_TP =                   "Prevent Soul Thirsters from pulling you into the spirit realm.",
    SI_LUIE_SKILL_BLESSING_GATHWEN_TP =                  "Reduce damage taken by |cFFFFFF3|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_MAIM_NPC_TP =                          "Reduce damage done by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_DRAIN_ESSENCE_NPC_TP =                 "Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach tick heals the caster.",
    SI_LUIE_SKILL_SUMMON_DARK_PROXY_TP =                 "A shadowy Clannfear fights at your side. The clannfear remains for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SUMMON_CLANNFEAR_TP =                  "A Clannfear fights at your side. The clannfear remains for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_POOL_OF_FIRE =                         "Pool of Fire",
    SI_LUIE_SKILL_SISTERS_BOND =                         "Sister's Bond",
    SI_LUIE_SKILL_CURSE_OF_SUFFERING_TP =                "Afflicted with with Magic Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF40|r%.\n\nEnter the Red Sigil to remove the curse.",
    SI_LUIE_SKILL_CURSE_OF_DOMINANCE_TP =                "Afflicted with with Magic Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF40|r%.\n\nEnter the Black Sigil to remove the curse.",
    SI_LUIE_SKILL_HEAL_SPORES =                          "Healing Spores",
    SI_LUIE_SKILL_SUMMON_STRANGLER_SAPLINGS =            "Summon Strangler Saplings",
    SI_LUIE_SKILL_SIPHON_MAGICKA =                       "Siphon Magicka",
    SI_LUIE_SKILL_SIPHON_MAGICKA_TP =                    "Draining |cFFFFFF5|r% Max Magicka every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SIPHON_STAMINA =                       "Siphon Stamina",
    SI_LUIE_SKILL_SIPHON_STAMINA_TP =                    "Draining |cFFFFFF5|r% Max Stamina every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_DARK_ROOT_STAMINA_TP =                 "Dramatically increase Max Stamina and Stamina Recovery.",
    SI_LUIE_SKILL_DARK_ROOT_MAGICKA_TP =                 "Dramatically increase Max Magicka and Magicka Recovery.",
    SI_LUIE_SKILL_SHADOW_TENDRIL =                       "Shadow Tendril",
    SI_LUIE_SKILL_NOVA_TENDRIL =                         "Nova Tendril",
    SI_LUIE_SKILL_BLAZING_ARROW_TP =                     "Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nPut out the flames by jumping in the water.",
    SI_LUIE_SKILL_BLAZING_EMBERS_TP =                    "Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF5|r seconds.\n\nPut out the flames by jumping in the water.",
    SI_LUIE_SKILL_OBLIVION_GATE =                        "Oblivion Gate",
    SI_LUIE_SKILL_ENRAGED_FORTITUDE =                    "Enraged Fortitude",
    SI_LUIE_SKILL_ENRAGE_HORVANTUD =                     "Increase damage done by |cFFFFFF5|r%, stacking up to |cFFFFFF3|r times.",
    SI_LUIE_SKILL_FLAME_TSUNAMI =                        "Flame Tsunami",
    SI_LUIE_SKILL_FLAME_TSUNAMI_TP =                     "Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF2|r seconds.\n\nStunned for |cFFFFFF1.5|r seconds.",
    SI_LUIE_SKILL_FLAME_TORNADO_SHIELD_TP =              "Absorbing |cFFFFFF35|r% of damage taken for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    SI_LUIE_SKILL_IGNORE_PAIN =                          "Ignore Pain",
    SI_LUIE_SKILL_IGNORE_PAIN_TP =                       "Reduce damage taken by |cFFFFFF95|r%.",
    SI_LUIE_SKILL_MAGMA_PRISON_TP =                      "Stunned and afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_VOLCANIC_SHIELD =                      "Volcanic Shield",
    SI_LUIE_SKILL_VOLCANIC_SHIELD_TP =                   "Absorbing damage and launching bolts of fire at all nearby enemies every |cFFFFFF1|r second while the shield holds.",
    SI_LUIE_SKILL_SIGIL_OF_HASTE_TP =                    "Increase Movement Speed by |cffffff40|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SIGIL_OF_POWER_TP =                    "Increase Weapon and Spell Damage by |cFFFFFF<<1>>|r for |cFFFFFF30|r seconds.",
    SI_LUIE_SKILL_SIGIL_OF_HEALING_TP =                  "Healing for |cFFFFFF10|r% of your Max Health every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SIGIL_OF_DEFENSE_TP =                  "Reduce damage taken by |cffffff50|r% and reflect all projectiles cast at you for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_DEFILED_GRAVE_TP =                     "Immobilized and taking Magic Damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_SUDDEN_STORM =                         "Sudden Storm",
    SI_LUIE_SKILL_BACKSTAB_TP =                          "Afflicted with Bleeding Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF60|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_CALL_STORM_ATRONACH =                  "Call Storm Atronachs",
    SI_LUIE_SKILL_ENERVATING_STONE_TP =                  "Stunned and taking Shock Damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_ETHEREAL_CHAIN_TP =                    "Levitated and afflicted with Magic Damage every |cFFFFFF1.5|r seconds for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_PRIMAL_SWARM =                         "Primal Swarm",
    SI_LUIE_SKILL_ENSNARE_TP =                           "Stunned for |cFFFFFF4|r seconds.\n\nMovement Speed reduced by |cFFFFFF50|r% for |cFFFFFF8|r seconds.",
    SI_LUIE_SKILL_MIRROR_WARD_TP =                       "Reflect all projectiles cast at you.",
    SI_LUIE_SKILL_POISON_SHOT_TP =                       "Afflicted with Poison Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds, stacking indefinitely.",
    SI_LUIE_SKILL_VENOMOUS_BURST_TP =                    "You and nearby allies take Poison Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SELENES_ROSE =                         "Selene's Roses",
    SI_LUIE_SKILL_WEB_WRAP_TP =                          "Wrapped in webs and unable to take any actions for |cFFFFFF<<1>>|r seconds. Break free to remove.",
    SI_LUIE_SKILL_PRIMAL_MAUL =                          "Primal Maul",
    SI_LUIE_SKILL_ROOT_GUARD =                           "Root Guard",
    SI_LUIE_SKILL_EARTH_MENDER =                         "Earth Mender",
    SI_LUIE_SKILL_TRUE_SHOT =                            "True Shot",
    SI_LUIE_SKILL_SENCHE_SPIRIT =                        "Senche Spirit",
    SI_LUIE_SKILL_INJECT_POISON_TP =                     "Afflicted with Poison Damage every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.\n\nKnocked back for |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_SPAWN_HATCHLINGS =                     "Spawn Hatchlings",
    SI_LUIE_SKILL_FIGHTERS_BOON_TP =                     "Increase Armor by |cFFFFFF559|r for |cFFFFFF2|r minutes.",
    SI_LUIE_SKILL_ENERVATING_SEAL_TP =                   "Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds. Each tick drains |cFFFFFF15|r% of your Max Stamina and Magicka.",
    SI_LUIE_SKILL_BLOOD_POOL_TP =                        "Taking Physical Damage every |cFFFFFF<<2>>|r <<2[second/seconds]>>. Each tick heals the Vampire.",
    SI_LUIE_SKILL_WRACKING_PAIN =                        "Wracking Pain",
    SI_LUIE_SKILL_METEORIC_STRIKE =                      "Meteoric Strike",

    SI_LUIE_SKILL_EXPERT_HUNTER_NPC_TP =                 "|cFFFFFF20|r% chance on hit to deal additional Magic Damage to Undead and Daedric enemies for |cFFFFFF<<1>>|r seconds.\n\nKilling an Undead or Daedric enemy increases the duration by |cFFFFFF15|r seconds.",
    SI_LUIE_SKILL_CIRCLE_OF_PROTECTION_NPC_TP =          "Healing every |cFFFFFF1|r second and damage taken reduced by |cFFFFFF55|r%.",
    SI_LUIE_SKILL_PIERCE_ARMOR_NPC_TP =                  "Reduce Physical and Spell Resistance by |cFFFFFF43|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_BITING_COLD_TP =                       "Taking Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF10|r%.\n\nThis effect stacks up to |cFFFFFF8|r times, to a maximum of |cFFFFFF80|r% Movement Speed reduction.",
    SI_LUIE_SKILL_BITING_COLD_VET_TP =                   "Taking increasing Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF10|r%.\n\nDamage taken increased by |cFFFFFF22|r% per stack.\n\nThe snare stacks up to |cFFFFFF8|r times, to a maximum of |cFFFFFF80|r% Movement Speed reduction.",
    SI_LUIE_SKILL_FROST_CLENCH_NPC_TP =                  "Stunned for |cFFFFFF0.5|r seconds.\n\nImmobilized for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_UWOF_NPC_TP =                          "Taking Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF60|r%.\n\nThe wall explodes when it expires, dealing additional Frost Damage.",
    SI_LUIE_SKILL_ELEMENTAL_SUSCEPTIBILITY_NPC_TP =      "Reduce Spell Resistance by |cFFFFFF30|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_WITHER_TP =                            "Increase damage taken by |cffffff15|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_EMBER_EXPLOSION_TP =                   "|cFFFFFF40|r% chance to miss all attacks for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_THUNDERING_PRESENCE_NPC_TP =           "Increase Physical and Spell Resistance by |cFFFFFF23100|r and enemies within |cFFFFFF5|r meters take Shock Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_BOUND_AEGIS_NPC_TP =                   "Reduce damage taken by |cffffff20|r%.",
    SI_LUIE_SKILL_MARK_TARGET_NPC_TP =                   "Reduce Physical and Spell Resistance by |cFFFFFF75|r% for |cFFFFFF<<1>>|r seconds.\n\nThe Nightblade heals for |cFFFFFF40|r% of their Max Health if you die under this effect.",
    SI_LUIE_SKILL_ENSLAVEMENT_TP =                       "Afflicted with Magic Damage every |cFFFFFF1|r second and Movement Speed gradually reduced over time by up to |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_MOLTEN_ARMAMENTS_NPC_TP =              "Increase Weapon and Spell Damage for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_CINDER_STORM_NPC_TP =                  "Taking Flame Damage every |cffffff1|r second, |cFFFFFF30|r% chance to miss all attacks, and Movement Speed reduced by |cffffff70|r%.",
    SI_LUIE_SKILL_CAUSTIC_ARMOR =                        "Caustic Armor",
    SI_LUIE_SKILL_CORROSIVE_ARMOR_NPC_TP =               "Incoming damage is limited to |cffffff3|r% of your Max Health and nearby enemies suffer |cFFFFFF34|r% reduced Weapon Damage and take Flame Damage and every |cffffff1|r second for |cffffff<<1>>|r seconds.",
    SI_LUIE_SKILL_CORROSIVE_ARMOR_NPC_DEBUFF_TP =        "Taking Flame Damage every |cffffff1|r second and Weapon Damage reduced by |cFFFFFF34|r%.",
    SI_LUIE_SKILL_PETRIFY_NPC_TP =                       "Stunned and absorbing damage for |cFFFFFF<<1>>|r seconds.\n\nThe stun breaks after taking enough damage.",
    SI_LUIE_SKILL_CELESTIAL_WARD_TP =                    "While standing in the ward you are protected from Celestial Blast.\n\nHealing every |cffffff0.25|r seconds.",
    SI_LUIE_SKILL_CELESTIAL_BLAST_TP =                   "Targeted by Celestial Blast, after |cFFFFFF<<1>>|r seconds you will take a massive amount of Unmitigable Damage and be stunned for |cFFFFFF4|r seconds.\n\nEnter the lit Celestial Rune to protect yourself.",
    SI_LUIE_SKILL_STANDARD_OF_MIGHT_NPC_TP =             "Increase damage done and reduce damage taken by |cFFFFFF35|r% while standing within the radius of the standard.",
    SI_LUIE_SKILL_STANDARD_OF_MIGHT_NPC_GROUND_TP =      "Taking Flame Damage every |cFFFFFF1|r second and healing received reduced by |cFFFFFF50|r%.",
    SI_LUIE_SKILL_DRAINING_POISON_TP =                   "Afflicted with Poison Damage every |cFFFFFF1|r second and Magicka and Stamina Recovery reduced for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_NATURES_BLESSING =                     "Nature's Blessing",
    SI_LUIE_SKILL_NATURES_BLESSING_TP =                  "Nature's Blessing deals increased Unmitigable Damage for each stack for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_NATURES_BLESSING_GROUND_TP =           "Restoring |cFFFFFF13|r% of your Max Stamina and Magicka every |cFFFFFF1|r second.\n\nTaking stacking Unmitigable Damage every |cFFFFFF1|r second.",
    SI_LUIE_SKILL_ACID_SPRAY_NPC_TP =                    "Afflicted with Poison Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_SUMMON_DAEDRIC_TITAN =                 "Summon Daedric Titan",
    SI_LUIE_SKILL_DARK_FLARE_NPC_TP =                    "Reduce healing received by |cFFFFFF40%|r.",
    SI_LUIE_SKILL_PURIFYING_LIGHT_NPC_TP =               "|cFFFFFF33|r% of all damage taken for the next |cFFFFFF<<1>>|r seconds will be copied and released as Magic Damage when the effect ends.\n\nWhen the effect ends, a pool of sunlight remains on the ground, healing the Templar and their allies if they are nearby every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.",
    SI_LUIE_SKILL_UNSTABLE_CORE_NPC_TP =                 "Your single target ranged abilities are reflected back on you for |cFFFFFF<<1>>|r seconds.\n\nThe core explodes when this effect ends, dealing Magic Damage to you and nearby allies.",
    SI_LUIE_SKILL_SEARING_LIGHT_TP =                     "|cFFFFFF50|r% chance to miss all attacks for |cFFFFFF4|r seconds.\n\nStunned for |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_SOLAR_DISTURBANCE_NPC_TP =             "Taking Magic Damage every |cFFFFFF1|r second, damage done reduced by |cFFFFFF25|r%, and Movement Speed reduced by |cffffff60|r%.",
    SI_LUIE_SKILL_DARK_DEAL_NPC_TP =                     "Increase Physical and Spell Resistance, and heal every |cFFFFFF1|r second after |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_ICE_CHARGE_TP =                        "You and nearby allies take Frost Damage every |cFFFFFF2|r seconds, and Movement Speed reduced by |cFFFFFF90|r% for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_POISON_MIST_TP =                       "Reduce damage taken by |cFFFFFF75|r% and enemies within |cFFFFFF5|r meters take Poison Damage every |cFFFFFF1.5|r seconds for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_DRAIN_ESSENCE_VAMP_NPC_TP =            "Stunned and afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach tick heals the vampire.",
    SI_LUIE_SKILL_MALEFIC_WREATH_TP =                    "Stunned for |cFFFFFF<<1>>|r seconds.\n\nTake Magic Damage when the effect ends, increased for each second the effect lasts.\n\nThe stun breaks after taking damage.",
    SI_LUIE_SKILL_CRIPPLING_GRASP_NPC_TP =               "Afflicted with Magic Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF20|r% for |cFFFFFF8|r seconds.\n\nImmobilized for |cFFFFFF3|r seconds.",
    SI_LUIE_SKILLPOWER_EXTRACTION_NPC_TP =               "Increase damage done by |cFFFFFF10|r% for each enemy hit by Power Extraction.",
    SI_LUIE_SKILL_MARKED_FOR_DEATH_TP =                  "You and nearby allies take Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nWhen the effect ends, a deadly pool of fire will drop on the ground beneath your feet.",
    SI_LUIE_SKILL_ENRAGE_FG_GLADIATOR_TP =               "Increase damage done by |cFFFFFF100|r% and increase damage taken by |cFFFFFF20|r% per stack.",
    SI_LUIE_SKILL_EMPOWERED_BY_THE_LIGHT =               "Empowered by the Light",
    SI_LUIE_SKILL_ARENA_TORCH =                          "Arena Torch",
    SI_LUIE_SKILL_TORCH_GRAB_TP =                        "Carrying a torch and silenced for |cFFFFFF<<1>>|r seconds, you can use the torch to reignite a bonfire.",
    SI_LUIE_SKILL_WARMING_AURA_TP =                      "Protected from Biting Cold by the warmth of a bonfire.",
    SI_LUIE_SKILL_GROWING_TORMENT_TP =                   "Increase damage done by |cFFFFFF6|r% per stack.",
    SI_LUIE_SKILL_DEFENSIVE_PROTOCOL =                   "Defensive Protocol",
    SI_LUIE_SKILL_DEFENSIVE_PROTOCOL_TP =                "Absorbing damage and unable to take any action, while nearby enemies take Shock Damage every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_OVERCHARGED_DWEMER_TP =                "Striking distant enemies with bolts, dealing Shock Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_OVERHEATED_DWEMER_TP =                 "Venting flames, dealing Flame Damage to nearby enemies every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_OVERHEATED_DWEMER_VET_TP =             "Venting flames, dealing Flame Damage to nearby enemies every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDistant enemies will be bombarded with a volley of flames every |cFFFFFF2|r seconds.",
    SI_LUIE_SKILL_VENTING_FLAMES =                       "Venting Flames",
    SI_LUIE_SKILL_VOLTAIC_OVERLOAD_TP =                  "Nearby enemies take Shock Damage every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds.",
    SI_LUIE_SKILL_FRIGID_WATERS_TP =                     "Taking increasing Frost Damage every |cFFFFFF1|r second.\n\nDamage taken increased by |cFFFFFF100|r% per stack.",
    SI_LUIE_SKILL_COLD_SNAP_TP =                         "Increase damage taken from Cold Snap by |cFFFFFF<<2>>|r% per stack.",
    SI_LUIE_SKILL_SUMMON_DEATHLESS_WOLF =                "Summon Deathless Wolf",
    SI_LUIE_SKILL_BLADE_TRAP_VMA =                       "Afflicted with Bleeding Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nThis effect stacks up to |cFFFFFF25|r times, dealing |cFFFFFF5|r% increased damage per stack.",
    SI_LUIE_SKILL_ENERGIZE =                             "Energize",
    SI_LUIE_SKILL_REFLECTIVE_SCALE =                     "Reflective Scale",
}

for stringId, stringValue in pairs(strings) do
    ZO_CreateStringId(stringId, stringValue)
    SafeAddVersion(stringId, 1)
end
