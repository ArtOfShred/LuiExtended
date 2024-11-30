--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Skill names & Tooltips localization
-- Translation by: KiriX
local strings =
{

    ----------------------------------------------------------------
    -- INNATE SKILLS -----------------------------------------------
    ----------------------------------------------------------------

    -- Mundus Stones
    -- TODO: Translations need syntax updated (en strings changed as follows):
    -- "Increases your" --> "Increase"
    -- "Spell and Physical" --> "Physical and Spell"
    -- "Critical Strike ratings" --> "Critical"
    LUIE_STRING_SKILL_MUNDUS_BASIC_LADY = 'Повышает ваши магическую и физическую сопротивляемости на |cFFFFFF2744|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_LOVER = 'Повышает ваши магическую и физическую проникновение на |cFFFFFF2744|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_LORD = 'Повышает ваш макс.запас Здоровья на |cFFFFFF2225|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_MAGE = 'Повышает ваш макс.запас Магии на |cFFFFFF2023|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_TOWER = 'Повышает ваш макс. Запас сил на |cFFFFFF2023|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_ATRONACH = 'Повышает ваше восстановление Магии на |cFFFFFF310|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_SERPENT = 'Повышает ваше восстановление Запаса сил на |cFFFFFF310|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_SHADOW = 'Повышает ваш критический урон на |cFFFFFF11|r%.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_RITUAL = 'Повышает наносимое вами исцеление на |cFFFFFF8|r%.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_THIEF = 'Повышает ваш рейтинг критического удара Оружием и Заклинаниями на |cFFFFFF1333|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_WARRIOR = 'Повышает ваш урон от Оружия на |cFFFFFF238|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_APPRENTICE = 'Повышает ваш урон от Заклинаний на |cFFFFFF238|r.';
    LUIE_STRING_SKILL_MUNDUS_BASIC_STEED = 'Повышает вашу скорость передвижения на |cFFFFFF10|r% и восстановление Здоровья на |cFFFFFF238|r.';

    -- Mundus Substitute strings for scaled default tooltips
    -- TODO: Needs translated, strings must be an exact match with default tooltip
    LUIE_STRING_SKILL_MUNDUS_SUB_THIEF = 'Critical Strike ratings';
    LUIE_STRING_SKILL_MUNDUS_SUB_THIEF_REPLACE = 'Critical';
    LUIE_STRING_SKILL_MUNDUS_SUB_RES_PEN = 'Spell and Physical';
    LUIE_STRING_SKILL_MUNDUS_SUB_RES_PEN_REPLACE = 'Physical and Spell';
    LUIE_STRING_SKILL_MUNDUS_STRING = 'Increases your';

    -- Player Innate
    LUIE_STRING_SKILL_RECALL_PENALTY = 'Штраф перемещения';
    LUIE_STRING_SKILL_RESURRECTION_IMMUNITY = 'Иммун воскрешения';
    LUIE_STRING_SKILL_SOUL_GEM_RESURRECTION = 'Воскрешение камнем душ';
    LUIE_STRING_SKILL_FALL_DAMAGE = 'Урон от падения';
    LUIE_STRING_SKILL_ABSORBING_SKYSHARD = 'Поглощение небесного осколка';
    LUIE_STRING_SKILL_RECEIVING_BOON = 'Получение бонуса Мундуса';
    --LUIE_STRING_SKILL_MOUNT_SPRINT =                         "Галоп",
    LUIE_STRING_SKILL_AYLEID_WELL = 'Айлейдский колодец';
    LUIE_STRING_SKILL_AYLEID_WELL_TP = 'Повышение здоровья на |cFFFFFF10|r% в течение |cFFFFFF10|r минут.';
    LUIE_STRING_SKILL_AYLEID_WELL_FORTIFIED = 'Усиленный Айлейдский колодец';
    LUIE_STRING_SKILL_AYLEID_WELL_FORTIFIED_TP = 'Повышение здоровья на |cFFFFFF10|r% в течение |cFFFFFF30|r минут.';
    LUIE_STRING_SKILL_IMMOBILIZE_IMMUNITY_TP = 'Immune to immobilization effects for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SNARE_IMMOBILIZE_IMMUNITY_TP = 'Immune to snare and immobilization effects for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DODGE_FATIGUE_TP = 'Consecutive roll dodging costs |cFFFFFF33|r% more Stamina per stack for the next |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_HIDDEN_TP = 'Crouched and concealed from sight.\n\nMovement speed reduced by |cFFFFFF<<1>>|r%.\n\nWhile hidden and moving, costs |cFFFFFF<<2>>|r Stamina every |cFFFFFF0.5|r seconds and Stamina Recovery is disabled.';
    LUIE_STRING_SKILL_HIDDEN_NO_SPEED_TP = 'Crouched and concealed from sight.\n\nWhile hidden and moving, costs |cFFFFFF<<1>>|r Stamina every |cFFFFFF0.5|r seconds and Stamina Recovery is disabled.';
    LUIE_STRING_SKILL_INVISIBLE_TP = 'Сокрыты от чужих глаз магией или окружающей средой.';
    --LUIE_STRING_SKILL_SPRINT_TP =                            "Спринт, скорость передвижения увеличена на |cFFFFFF40|r%.\n\nРасходуется Запас сил при движении.",
    --LUIE_STRING_SKILL_GALLOP_TP =                            "Галоп, скорость передвижения увеличена на |cFFFFFF30|r%.\n\nРасходуется Запас сил ездового животного при движении.",
    LUIE_STRING_SKILL_BRACE_TP = 'Brace for attack, reducing damage taken by |cFFFFFF<<1>>|r% and movement speed by |cFFFFFF<<2>>|r% while granting immunity to Stun and Knockback effects.\n\nDrains |cFFFFFF<<3>>|r <<4>> on a successful block.';
    LUIE_STRING_SKILL_RESURRECTION_IMMUNITY_TP = 'Reviving. Immune to damage and all negative effects.';
    LUIE_STRING_SKILL_TAUNT_TP = 'Спровоцирован.';
    LUIE_STRING_SKILL_TAUNT_OTHER_TP = 'This enemy is taunted and will concentrate all attacks on you for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DISGUISE_TP = 'Disguised. You can be revealed by sentries or performing suspicious activity.\n\nTaking any damage other than fall damage will destroy your disguise.';
    LUIE_STRING_SKILL_BATTLE_SPIRIT_TP = '• Reduce damage taken and shield strength by |cFFFFFF50|r%\n• Reduce healing received by |cFFFFFF55|r%\n• Reduce Health Recovery by |cFFFFFF50|r%\n• Increase the range of abilities with a range greater than |cFFFFFF28|r meters by |cFFFFFF8|r meters';
    LUIE_STRING_SKILL_BATTLE_SPIRIT_IMPERIAL_CITY_TP = '• Reduce damage taken and shield strength by |cFFFFFF50|r%\n• Reduce healing received by |cFFFFFF55|r%\n• Reduce Health Recovery by |cFFFFFF50|r%';
    LUIE_STRING_SKILL_RECALL_PENALTY_TP = 'Вы недавно пользовались перемещением к дорожному святилищу и должно заплатить дополнительное золото, чтобы воспользоваться им вновь.';
    LUIE_STRING_SKILL_BATTLEGROUND_DESERTER_TP = 'You left a Battleground match early and cannot queue again or earn Alliance points from any PvP sources.';
    LUIE_STRING_SKILL_LOOKING_FOR_GROUP_TP = '• Increase Max Health by |cFFFFFF20|r%\n• Increase Weapon and Spell Damage by |cFFFFFF25|r%';

    ----------------------------------------------------------------
    -- ITEM / CONSUMABLE TOOLTIPS ----------------------------------
    ----------------------------------------------------------------

    -- Glyphs
    LUIE_STRING_SKILL_GLYPH_WEAKENING_TP = 'Reduce Weapon and Spell Damage for |cFFFFFF<<1>>|r seconds.';

    -- Crafting Station Creation
    LUIE_STRING_SKILL_CRAFTING_STATION = 'Attune Crafting Station';

    -- Consumable / Food / Drink
    LUIE_STRING_SKILL_POISON_STEALTH_DRAIN = 'Яд скрытности';
    LUIE_STRING_SKILL_POISON_CONSPICUOUS = 'Яд обнаружения';
    LUIE_STRING_SKILL_DRINK_INCREASE = 'Повышение';
    LUIE_STRING_SKILL_REMOVE_TOOLTIP_SCALED_LEVEL = 'Сила эффектов зависит от вашего уровня.'; -- Note this needs to be an exact match to the description in Crown Crate food/drink items for it to be correctly removed in each localization.
    LUIE_STRING_SKILL_REMOVE_TOOLTIP_DOUBLE_BLOODY_MARA = 'If you are a vampire, the blood in this drink will also purify you, reducing your Stage by 1.\nThese effects are scaled based on your level.'; -- Must be exact match in each localization
    LUIE_STRING_SKILL_REMOVE_TOOLTIP_HISSMIR = 'Этот напиток также дает вам понимание того, какая рыба водится в различных водоемах, и наделяет особым вниманием к местам рыбной ловли поблизости.\nСила эффектов зависит от вашего уровня.'; -- Must be exact match in each localization
    LUIE_STRING_SKILL_ADD_TOOLTIP_HISSMIR = '\n\nЭтот напиток также дает вам понимание того, какая рыба водится в различных водоемах, и наделяет особым вниманием к местам рыбной ловли поблизости.';
    LUIE_STRING_SKILL_REMOVE_TOOLTIP_ARTAEUM_BOWL = 'Also increases'; -- Must be exact match in each localization
    LUIE_STRING_SKILL_ADD_TOOLTIP_ARTAEUM_BOWL = '\n\nAlso increases';
    LUIE_STRING_SKILL_REMOVE_TOOLTIP_TWICE_SPIKED_ALE = 'This drink is very gassy.\nThese effects are scaled based on your level.'; -- Must be exact match in each localization
    LUIE_STRING_SKILL_REMOVE_TOOLTIP_PACK_LEADERS_BROTH = 'If you are a werewolf, the rich marrow will also slightly ease your transformation.\nThese effects are scaled based on your level.'; -- Must be exact match in each localization
    LUIE_STRING_SKILL_ADD_TOOLTIP_PACK_LEADERS_BROTH = '\nIf you are a werewolf, the rich marrow will also slightly ease your transformation.';
    LUIE_STRING_SKILL_REMOVE_TOOLTIP_DISASTROUSLY_BLOODY = 'If you are a vampire, the tainted blood in this drink will corrupt you, increasing your Stage to 4.\nThese effects are scaled based on your level.'; -- Must be exact match in each localization
    LUIE_STRING_SKILL_ESO_PLUS_TP = 'Увеличивает получаемые Опыт, Золото и Вдохновение на |cFFFFFF10|r%.\nУвеличивает скорость исследования особенностей на |cFFFFFF10|r%.';

    -- Collectible
    LUIE_STRING_SKILL_COLLECTIBLE_MYSTERY_MEAT = 'Mystery Meat';
    LUIE_STRING_SKILL_COLLECTIBLE_VANITY_PET_TP = 'You have an active Non-Combat Pet.';

    -- Experience
    LUIE_STRING_SKILL_EXPERIENCE_HALF_HOUR_TP = 'Увеличивает получаемый опыт на |cFFFFFF<<1>>|r% в течение |cFFFFFF30|r минут.';
    LUIE_STRING_SKILL_EXPERIENCE_HOUR_TP = 'Увеличивает получаемый опыт на |cFFFFFF<<1>>|r% в течение |cFFFFFF<<2>>|r <<2[часа/часов]>>.';
    LUIE_STRING_SKILL_EXPERIENCE_PELINAL = 'Увеличивает получаемые Очки Альянса и опыт, получаемый за убийство игроков на |cFFFFFF100|r% в течение |cFFFFFF<<1>>|r <<1[часа/часов]>>.';
    LUIE_STRING_SKILL_EXPERIENCE_ALLIANCE_HALF_HOUR_TP = 'Increase Alliance Rank and Alliance War Skill Line progression by |cFFFFFF<<1>>|r% for |cFFFFFF30|r minutes.';
    LUIE_STRING_SKILL_EXPERIENCE_ALLIANCE_HOUR_TP = 'Increase Alliance Rank and Alliance War Skill Line progression by |cFFFFFF<<1>>|r% for |cFFFFFF1|r hour.';

    -- Misc
    LUIE_STRING_SKILL_FILLET_FISH = 'Чистка рыбы';
    LUIE_STRING_SKILL_COUNTERFEIT_PARDON_EDICT = 'Поддельный указ о помиловании';
    LUIE_STRING_SKILL_LENIENCY_EDICT = 'Указ о смягчении наказания';
    LUIE_STRING_SKILL_GRAND_AMNESTY_EDICT = 'Указ о большой амнистии';
    LUIE_STRING_SKILL_REVELRY_PIE_TP = 'Covered in pie! Delicious!';

    ----------------------------------------------------------------
    -- EVENT TOOLTIPS ----------------------------------------------
    ----------------------------------------------------------------

    LUIE_STRING_SKILL_EVENT_FREEZING = 'Вы замерзаете и скорость вашего передвижения замедлена. Найдите костёр, чтобы согреться.';
    LUIE_STRING_SKILL_EVENT_WARM = 'Вы прижимаетесь к ближайшему костру, чтобы согреться. Время замерзания сокращается на |cFFFFFF10|r секунд каждую |cFFFFFF1|r секунду.';
    LUIE_STRING_SKILL_EVENT_FESTIVAL_GROG = 'You are feeling a bit... disoriented.';
    LUIE_STRING_SKILL_EVENT_FESTIVAL_MINTS = 'Вы ОЧЕНЬ замерзли.';

    ----------------------------------------------------------------
    -- MAJOR / MINOR EFFECTS ---------------------------------------
    ----------------------------------------------------------------

    -- Major / Minor Buffs
    LUIE_STRING_SKILL_MINOR_RESOLVE_TP = 'Increase Physical and Spell Resistance by |cFFFFFF2974|r.';
    LUIE_STRING_SKILL_MAJOR_RESOLVE_TP = 'Increase Physical and Spell Resistance by |cFFFFFF5948|r.';
    LUIE_STRING_SKILL_MINOR_FORTITUDE_TP = 'Повышает восстановление здоровья на |cFFFFFF15|r%.';
    LUIE_STRING_SKILL_MAJOR_FORTITUDE_TP = 'Повышает восстановление здоровья на |cFFFFFF30|r%.';
    LUIE_STRING_SKILL_MINOR_ENDURANCE_TP = 'Повышает восстановление запаса сил на |cFFFFFF15|r%.';
    LUIE_STRING_SKILL_MAJOR_ENDURANCE_TP = 'Повышает восстановление запаса сил на |cFFFFFF30|r%.';
    LUIE_STRING_SKILL_MINOR_INTELLECT_TP = 'Повышает восстановление магии на |cFFFFFF15|r%.';
    LUIE_STRING_SKILL_MAJOR_INTELLECT_TP = 'Повышает восстановление магии на |cFFFFFF30|r%.';
    LUIE_STRING_SKILL_MINOR_SORCERY_TP = 'Повышает урон от заклинаний на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MAJOR_SORCERY_TP = 'Повышает урон от заклинаний на |cFFFFFF20|r%.';
    LUIE_STRING_SKILL_MINOR_PROPHECY_TP = 'Increase Spell Critical rating by |cFFFFFF1314|r, increasing your Spell Critical chance by |cFFFFFF6|r%.';
    LUIE_STRING_SKILL_MAJOR_PROPHECY_TP = 'Increase Spell Critical rating by |cFFFFFF2629|r, increasing your Spell Critical chance by |cFFFFFF12|r%.';
    LUIE_STRING_SKILL_MINOR_BRUTALITY_TP = 'Повышает урон от оружия на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MAJOR_BRUTALITY_TP = 'Повышает урон от оружия на |cFFFFFF20|r%.';
    LUIE_STRING_SKILL_MINOR_SAVAGERY_TP = 'Increase Weapon Critical rating by |cFFFFFF1314|r, increasing your Weapon Critical chance by |cFFFFFF6|r%.';
    LUIE_STRING_SKILL_MAJOR_SAVAGERY_TP = 'Increase Weapon Critical rating by |cFFFFFF2629|r, increasing your Weapon Critical chance by |cFFFFFF12|r%.';
    LUIE_STRING_SKILL_MINOR_BERSERK_TP = 'Повышает наносимый урон на |cFFFFFF5|r%.';
    LUIE_STRING_SKILL_MAJOR_BERSERK_TP = 'Повышает наносимый урон на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MINOR_FORCE_TP = 'Повышает критический урон на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MAJOR_FORCE_TP = 'Повышает критический урон на |cFFFFFF20|r%.';
    LUIE_STRING_SKILL_MINOR_VITALITY_TP = 'Повышает получаемое исцеление на |cFFFFFF8|r%.';
    LUIE_STRING_SKILL_MAJOR_VITALITY_TP = 'Повышает получаемое исцеление на |cFFFFFF16|r%.';
    LUIE_STRING_SKILL_MINOR_MENDING_TP = 'Повышает наносимое исцеление на |cFFFFFF8|r%.';
    LUIE_STRING_SKILL_MAJOR_MENDING_TP = 'Повышает наносимое исцеление на |cFFFFFF16|r%.';
    LUIE_STRING_SKILL_MINOR_PROTECTION_TP = 'Снижает получаемый урон на |cFFFFFF5|r%.';
    LUIE_STRING_SKILL_MAJOR_PROTECTION_TP = 'Снижает получаемый урон на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MINOR_EVASION_TP = 'Reduce damage taken from area of effect attacks by |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MAJOR_EVASION_TP = 'Reduce damage taken from area of effect attacks by |cFFFFFF20|r%.';
    LUIE_STRING_SKILL_MINOR_EXPEDITION_TP = 'Повышает скорость передвижения на |cFFFFFF15|r%.';
    LUIE_STRING_SKILL_MAJOR_EXPEDITION_TP = 'Повышает скорость передвижения на |cFFFFFF30|r%.';
    LUIE_STRING_SKILL_MAJOR_GALLOP_TP = 'Повышает скорость передвижения верхом на |cFFFFFF30|r%.';
    LUIE_STRING_SKILL_MINOR_HEROISM_TP = 'Даёт |cFFFFFF1|r очков ульты каждые |cFFFFFF1.5|r секунды.';
    LUIE_STRING_SKILL_MAJOR_HEROISM_TP = 'Даёт |cFFFFFF3|r очков ульты каждые |cFFFFFF1.5|r секунды.';
    LUIE_STRING_SKILL_MINOR_TOUGHNESS_TP = 'Повышает здоровье на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MINOR_COURAGE_TP = 'Повышает урон от оружия и заклинаний на |cFFFFFF215|r.';
    LUIE_STRING_SKILL_MAJOR_COURAGE_TP = 'Повышает урон от оружия и заклинаний на |cFFFFFF430|r.';

    -- Major / Minor Debuffs
    LUIE_STRING_SKILL_MINOR_BREACH_TP = 'Reduce Physical and Spell Resistance by |cFFFFFF2974|r.';
    LUIE_STRING_SKILL_MAJOR_BREACH_TP = 'Reduce Physical and Spell Resistance by |cFFFFFF5948|r.';
    LUIE_STRING_SKILL_MAJOR_FRACTURE_NPC_TP = 'Снижает физическую сопротивляемость на |cFFFFFF4000|r.';
    LUIE_STRING_SKILL_MINOR_VULNERABILITY_TP = 'Увеличивает получаемый урон на |cFFFFFF5|r%.';
    LUIE_STRING_SKILL_MAJOR_VULNERABILITY_TP = 'Увеличивает получаемый урон на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MINOR_MAIM_TP = 'Снижает наносимый урон на |cFFFFFF5|r%.';
    LUIE_STRING_SKILL_MAJOR_MAIM_TP = 'Снижает наносимый урон на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MINOR_DEFILE_TP = 'Снижает получаемое исцеление и восстановление здоровья на |cFFFFFF8|r%.';
    LUIE_STRING_SKILL_MAJOR_DEFILE_TP = 'Снижает получаемое исцеление и восстановление здоровья на |cFFFFFF16|r%.';
    LUIE_STRING_SKILL_MINOR_MAGICKASTEAL_TP = 'Enemies that attack you restore |cFFFFFF168|r Magicka every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_MINOR_MAGICKASTEAL_OTHER_TP = 'Restore |cFFFFFF168|r Magicka every |cFFFFFF1|r second when damaged.';
    LUIE_STRING_SKILL_MINOR_LIFESTEAL_TP = 'Enemies that attack you restore |cFFFFFF600|r Health every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_MINOR_LIFESTEAL_OTHER_TP = 'Restore |cFFFFFF600|r Health every |cFFFFFF1|r second when damaged.';
    LUIE_STRING_SKILL_MINOR_ENERVATION_TP = 'Reduce Critical Damage done by |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MINOR_UNCERTAINTY_TP = 'Reduce Weapon and Spell Critical rating by |cFFFFFF1320|r, reducing your Weapon and Spell Critical chance by |cFFFFFF6|r%.';
    LUIE_STRING_SKILL_MINOR_COWARDICE_TP = 'Reduce Weapon and Spell Damage by |cFFFFFF215|r.';
    LUIE_STRING_SKILL_MAJOR_COWARDICE_TP = 'Reduce Weapon and Spell Damage by |cFFFFFF430|r.';
    LUIE_STRING_SKILL_MINOR_MANGLE_TP = 'Снижает макс. здоровье на |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MINOR_TIMIDITY_TP = 'Drain |cFFFFFF1|r Ultimate every |cFFFFFF1.5|r seconds while in combat.';
    LUIE_STRING_SKILL_MINOR_BRITTLE_TP = 'Increase Critical Damage taken by |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_MAJOR_BRITTLE_TP = 'Increase Critical Damage taken by |cFFFFFF20|r%.';

    -- Slayer / Aegis
    LUIE_STRING_SKILL_MINOR_SLAYER_TP = 'Ваши атаки наносят на |cFFFFFF5|r% больше урона по противникам в Подземельях, Испытаниях и на Аренах.';
    LUIE_STRING_SKILL_MAJOR_SLAYER_TP = 'Ваши атаки наносят на |cFFFFFF10|r% больше урона по противникам в Подземельях, Испытаниях и на Аренах.';
    LUIE_STRING_SKILL_MINOR_AEGIS_TP = 'Вы получаете на |cFFFFFF5|r% меньше урона от противников в Подземельях, Испытаниях и на Аренах.';
    LUIE_STRING_SKILL_MAJOR_AEGIS_TP = 'Вы получаете на |cFFFFFF10|r% меньше урона от противников в Подземельях, Испытаниях и на Аренах.';

    -- Empower
    LUIE_STRING_SKILL_EMPOWER_TP = 'Increase damage done with Heavy Attacks against monsters by |cFFFFFF70|r%.';

    -- Potions
    LUIE_STRING_SKILL_SPELL_RESISTANCE_POTION_TP = 'Increase Spell Resistance by |cFFFFFF5280|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_PHYSICAL_RESISTANCE_POTION_TP = 'Increase Physical Resistance by |cFFFFFF5280|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_RAVAGE_ARMOR_TP = 'Reduce Physical Resistance by |cFFFFFF1320|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_RAVAGE_SPELL_PROTECTION_TP = 'Reduce Spell Resistance by |cFFFFFF1320|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SPELL_RESISTANCE_POISON_TP = 'Increase Spell Resistance by |cFFFFFF1320|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_PHYSICAL_RESISTANCE_POISON_TP = 'Increase Physical Resistance by |cFFFFFF1320|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    ----------------------------------------------------------------
    -- CHAMPION POINT SKILLS ---------------------------------------
    ----------------------------------------------------------------

    -- Craft
    LUIE_STRING_SKILL_SHADOWSTRIKE_TP = 'Invisible for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhile under this effect you can cast Blade of Woe.';

    -- Warfare
    LUIE_STRING_SKILL_ENLIVENING_OVERFLOW_TP = 'Increase Health, Magicka, and Stamina Recovery by |cFFFFFF0.5|r% of the casters Max Magicka, up to a cap of |cFFFFFF150|r, for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_FORESIGHT_TP = 'Reduce the cost of your Magicka and Stamina healing abilities by |cFFFFFF75|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_RIPOSTE_TP = 'Your next direct damage attack used within |cFFFFFF<<1>>|r <<1[second/seconds]>> deals |cFFFFFF33|r% additional damage.';

    -- Fitness
    LUIE_STRING_SKILL_EXPERT_EVASION_TP = 'You have recently benefitted from a free Roll Dodge and may not do so again for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_WINDED_TP = 'You have recently benefitted from a reactive Break Free effect and may not do so again for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_UNCHAINED_TP = 'Reduce the cost of your next Stamina ability used within |cFFFFFF<<1>>|r seconds by |cFFFFFF<<2>>|r%.';

    ----------------------------------------------------------------
    -- GENERIC / SHARED TOOLTIPS -----------------------------------
    ----------------------------------------------------------------

    -- Test Effect
    LUIE_STRING_SKILL_TEST_TP = 'Это тестовый эффект.';

    -- Generic Recovery
    LUIE_STRING_SKILL_GENERIC_STAMINA_RECOVERY_NO_DUR_TP = 'Increase Stamina Recovery by |cFFFFFF<<2>>|r.';
    LUIE_STRING_SKILL_GENERIC_MAGICKA_RECOVERY_NO_DUR_TP = 'Increase Magicka Recovery by |cFFFFFF<<2>>|r.';

    LUIE_STRING_SKILL_GENERIC_INCREASE_HEALING_RECEIVED_NO_DUR_TP = 'Увеличивает получаемое исцеление на |cFFFFFF<<2>>|r%.';

    -- Damage over Time / Heal over Time
    LUIE_STRING_SKILL_GENERIC_DOT_NO_TICK_TP = 'Afflicted with SUBSTRING over time for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_DOT_TP = 'Afflicted with SUBSTRING every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_DOT_SNARE_TP = 'Afflicted with SUBSTRING every |cFFFFFF<<2>>|r <<2[second/seconds]>> and Movement Speed reduced by |cFFFFFF<<3>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_HOT_TP = 'Healing every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_HOT_CHANNEL_TP = 'Healing every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>> while the channel is maintained.';

    -- Ground over Time
    LUIE_STRING_SKILL_GENERIC_GROUND_AOE_TP = 'Taking SUBSTRING every |cFFFFFF<<2>>|r <<2[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_GROUND_HEAL_TP = 'Healing every |cFFFFFF<<2>>|r <<2[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_GROUND_AOE_SNARE_TP = 'Taking SUBSTRING every |cFFFFFF<<2>>|r <<2[second/seconds]>> and Movement Speed reduced by |cFFFFFF<<3>>|r%.';
    LUIE_STRING_SKILL_GENERIC_GROUND_AOE_STACK_TP = 'Taking increasing SUBSTRING every |cFFFFFF<<2>>|r <<2[second/seconds]>>.\n\nDamage taken increased by |cFFFFFF<<3>>|r% per stack.';

    -- Resistances
    LUIE_STRING_SKILL_GENERIC_PHYSICAL_RESIST_TP = 'Increase Physical Resistance for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_GENERIC_SPELL_RESIST_NO_DUR_TP = 'Increase Spell Resistance.';
    LUIE_STRING_SKILL_GENERIC_PHY_SPELL_RESIST = 'Повышает Физическую и Магическую сопротивляемости на |cFFFFFF<<1>>|r секунд.';
    LUIE_STRING_SKILL_GENERIC_PHY_SPELL_RESIST_VALUE_TP = 'Increase Physical and Spell Resistance by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_PHY_SPELL_RESIST_NO_DUR_TP = 'Increase Physical and Spell Resistance.';
    LUIE_STRING_SKILL_GENERIC_PHY_SPELL_RESIST_NO_DUR_VALUE_TP = 'Increase Physical and Spell Resistance by |cFFFFFF<<2>>|r.';

    LUIE_STRING_SKILL_GENERIC_REDUCE_PHY_SPELL_RESIST_VALUE_TP = 'Reduce Physical and Spell Resistance by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_REDUCE_PHY_SPELL_RESIST_TP = 'Reduce Physical and Spell Resistance for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_REDUCE_PHY_SPELL_RESIST_NO_DUR_TP = 'Reduce Physical and Spell Resistance.';
    LUIE_STRING_SKILL_GENERIC_REDUCE_PHY_SPELL_RESIST_NO_DUR_VALUE_TP = 'Reduce Physical and Spell Resistance by |cFFFFFF<<2>>|r.';

    LUIE_STRING_SKILL_GENERIC_REDUCE_PHYSICAL_RESIST_VALUE_TP = 'Reduce Physical Resistance by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_GENERIC_REDUCE_WEP_SPELL_DMG_PERCENTAGE_TP = 'Reduce Weapon and Spell Damage by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_REDUCE_WEP_SPELL_DMG_VALUE_TP = 'Reduce Weapon and Spell Damage by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_GENERIC_LOWER_MAX_HP_TP = 'Reduce Max Health by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_GENERIC_REDUCE_DAMAGE_DONE_TP = 'Reduce damage done by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_REDUCE_HEALING_RECEIVED_TP = 'Reduce healing received by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    -- Resource Regeneration, Shields
    LUIE_STRING_SKILL_GENERIC_HEALTH_RECOVERY_TP = 'Increase Health Recovery for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_MGK_REGEN_TP = 'Restoring Magicka every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_MGK_REGEN_VALUE_TP = 'Restoring |cFFFFFF<<3>>|r Magicka every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_STAM_REGEN_TP = 'Restoring Stamina every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_STAM_REGEN_VALUE_TP = 'Restoring |cFFFFFF<<3>>|r Stamina every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_DAMAGE_SHIELD_NO_DUR_TP = 'Поглощение урона.';
    LUIE_STRING_SKILL_GENERIC_DAMAGE_SHIELD_TP = 'Поглощение урона в течение |cFFFFFF<<1>>|r секунд.';
    LUIE_STRING_SKILL_GENERIC_DAMAGE_SHIELD_PERCENT_TP = 'Absorbing |cFFFFFF<<2>>|r% of damage taken for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    -- Stealth / Detection
    LUIE_STRING_SKILL_GENERIC_MARKED_TP = 'Помечен на |cFFFFFF<<1>>|r секунд. Вы видны для противника, который пометил вас, даже если уходите в скрытность.';
    LUIE_STRING_SKILL_GENERIC_TRAUMA_TP = 'Negate the next |cFFFFFF2000|r points of healing received for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_REVEAL_TP = 'Обнаружен на |cFFFFFF<<1>>|r секунд. Вы не можете уйти в невидимость.';
    LUIE_STRING_SKILL_GENERIC_REVEAL_NO_DUR_TP = 'Revealed. You are unable to stealth.';
    LUIE_STRING_SKILL_GENERIC_INVISIBILITY_TP = 'Invisible for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_DETECTION_TP = 'Increase Stealth Detection by |cFFFFFF20|r meters for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_DETECTION_NPC_TP = 'Revealing nearby stealthed and invisible enemies.';

    -- Crowd Control / Immunity
    LUIE_STRING_SKILL_GENERIC_OFF_BALANCE_IMMUNITY_TP = 'Immune to effects that exploit off balance targets for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_MAJOR_VULNERABILITY_IMMUNITY = 'Major Vulnerability Immunity';
    LUIE_STRING_SKILL_GENERIC_MAJOR_VULNERABILITY_IMMUNITY_TP = 'Immune to Major Vulnerability for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_OFF_BALANCE_TP = 'Off Balance for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_OFF_BALANCE_NO_DUR_TP = 'Off Balance.';
    LUIE_STRING_SKILL_GENERIC_SNARE_TP = 'Movement Speed reduced by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_SNARE_NO_DUR_TP = 'Movement Speed reduced by |cFFFFFF<<2>>|r%.';
    LUIE_STRING_SKILL_GENERIC_IMMOBILIZE_TP = 'Immobilized for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_IMMOBILIZE_NO_DUR_TP = 'Immobilized.';
    LUIE_STRING_SKILL_GENERIC_STAGGER_TP = 'Staggered.';
    LUIE_STRING_SKILL_GENERIC_STUN_TP = 'Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_STUN_NO_DUR_TP = 'Stunned.';
    LUIE_STRING_SKILL_GENERIC_LEVITATE_TP = 'Levitated for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_KNOCKBACK_TP = 'Knocked back for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_KNOCKDOWN_TP = 'Knocked down for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_KNOCKDOWN_NO_DUR_TP = 'Knocked down.';
    LUIE_STRING_SKILL_GENERIC_FEAR_TP = 'Feared for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_FEAR_NO_DUR_TP = 'Feared.';
    LUIE_STRING_SKILL_GENERIC_SILENCE_TP = 'Silenced for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_SILENCE_NO_DUR_TP = 'Silenced.';
    LUIE_STRING_SKILL_GENERIC_BLIND_TP = 'Ослеплён на |cFFFFFF<<1>>|r секунд. |cFFFFFF100|r% шанс пропустить все атаки.';
    LUIE_STRING_SKILL_GENERIC_CC_IMMUNITY_TP = 'Иммунитет к отбрасыванию и прочим ограничивающим эффектам на |cFFFFFF<<1>>|r секунд.';
    LUIE_STRING_SKILL_GENERIC_SCARY_IMMUNITIES_TP = 'Immune to all crowd control and movement-impairing effects.';
    LUIE_STRING_SKILL_GENERIC_SCARY_IMMUNITIES_DUR_TP = 'Immune to all crowd control and movement-impairing effects for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_FLYING_IMMUNITIES_TP = 'Immune to movement imparing effects.';
    LUIE_STRING_SKILL_SET_GENERIC_IMMUNITY_TP = 'Immune to damage and all negative effects for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_IMMUNITY_PERMANENT_TP = 'Immune to damage and all negative effects.';
    LUIE_STRING_SKILL_GENERIC_DAMAGE_IMMUNITY_PERMANENT_TP = 'Immune to damage.';
    LUIE_STRING_SKILL_GENERIC_DISORIENT_TP = 'Disoriented for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_DISORIENT_NO_DUR_TP = 'Disoriented.';

    -- Ravage Potions / Poisons
    LUIE_STRING_SKILL_GENERIC_RAVAGE_HEALTH_POTION_TP = 'Afflicted with unmitigable SUBSTRING every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThis damage cannot be absorbed by a damage shield.';
    --LUIE_STRING_SKILL_GENERIC_RAVAGE_MAGICKA_POTION_TP =     "Increase the cost of Magicka abilities by |cFFFFFF60|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    --LUIE_STRING_SKILL_GENERIC_RAVAGE_STAMINA_POTION_TP =     "Increase the cost of Stamina abilities by |cFFFFFF60|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.",
    LUIE_STRING_SKILL_GENERIC_RAVAGE_MAGICKA_POISON_TP = 'Increase the cost of Magicka abilities by |cFFFFFF10|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_RAVAGE_STAMINA_POISON_TP = 'Increase the cost of Stamina abilities by |cFFFFFF10|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    -- Generic Stat Buffs
    LUIE_STRING_SKILL_SET_GENERIC_WEP_SPELL_DAMAGE_TIME_TP = 'Increase Weapon and Spell Damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_WEP_SPELL_DAMAGE_TIME_VALUE_TP = 'Increase Weapon and Spell Damage by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_WEP_DAMAGE_TIME_TP = 'Increase Weapon Damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_WEP_DAMAGE_VALUE_TIME_TP = 'Increase Weapon Damage by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_SPELL_DAMAGE_TIME_TP = 'Increase Spell Damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_SPELL_DAMAGE_TIME_VALUE_TP = 'Increase Spell Damage by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_LA_HA_DAMAGE_TP = 'Your Light and Heavy Attacks deal additional damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_LA_HA_DAMAGE_VALUE_TP = 'Your Light and Heavy Attacks deal an additional |cFFFFFF<<2>>|r damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_MAG_RECOVERY_TIME_TP = 'Increase Magicka Recovery for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_MAG_RECOVERY_TIME_VALUE_TP = 'Increase Magicka Recovery by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_SET_GENERIC_CRITICAL_DAMAGE_TP = 'Increase Critical Damage by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_GENERIC_INCREASE_DAMAGE_TAKEN_TP = 'Increase damage taken by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_REDUCE_DAMAGE_TAKEN_TP = 'Reduce damage taken by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_GENERIC_ENRAGE = 'Increase damage done by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_GENERIC_ENRAGE_NO_DUR = 'Increase damage done by |cFFFFFF<<2>>|r%.';
    LUIE_STRING_SKILL_GENERIC_ENRAGE_DAMAGE_TAKEN_NO_DUR = 'Increase damage done by |cFFFFFF<<2>>|r% and increase damage taken by |cFFFFFF<<3>>|r%.';
    LUIE_STRING_SKILL_GENERIC_ENRAGE_DAMAGE_REDUCE_NO_DUR = 'Increase damage done by |cFFFFFF<<2>>|r% and reduce damage taken by |cFFFFFF<<3>>|r%.';
    LUIE_STRING_SKILL_GENERIC_ENRAGE_STACK_PERMANENT_TP = 'Increase damage done by |cFFFFFF<<2>>|r% per stack.';

    LUIE_STRING_SKILL_GENERIC_MOVEMENT_SPEED_TP = 'Increase Movement Speed by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_GENERIC_PHYSICAL_SPELL_PEN_TP = 'Increase Physical and Spell Penetration by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_SET_GENERIC_ICD_TP = 'You have recently benefitted from the effects of <<2>> and may not do so again for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_GENERIC_ICD_MINUTES_TP = 'You have recently benefitted from the effects of <<2>> and may not do so again for |cFFFFFF<<3>>|r <<3[minute/minutes]>>.';

    LUIE_STRING_SKILL_SET_GENERIC_REDUCE_WEAPON_DAMAGE_TIME_VALUE_TP = 'Reduce Weapon Damage by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    LUIE_STRING_SKILL_INCREASE_MAX_MAGICKA_DURATION_PERCENTAGE_TP = 'Increase Max Magicka by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    ----------------------------------------------------------------
    -- CLASS SKILLS ------------------------------------------------
    ----------------------------------------------------------------

    -- Dragonknight Skills
    LUIE_STRING_SKILL_SEETHING_FURY_TP = 'Increase the damage of your next Molten Whip by |cFFFFFF33|r% and your Weapon and Spell Damage by |cFFFFFF75|r for |cFFFFFF<<1>>|r seconds.\n\nThis effect can stack up to |cFFFFFF3|r times.';
    LUIE_STRING_SKILL_VENOMOUS_CLAW_TP = 'Afflicted with Poison Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nDeals |cFFFFFF12|r% more damage every |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_BURNING_EMBERS_TP = 'Подвержен урону от Огня каждые |cFFFFFF2|r секунды в течение |cFFFFFF<<1>>|r секунд.\n\nИсцеляет рыцаря-дракона на |cFFFFFF75|r% от нанесённого урона по завершению действия эффекта.';
    LUIE_STRING_SKILL_ENGULFING_FLAMES_TP = 'Подвержен урону от Огня каждые |cFFFFFF2|r секунды в течение |cFFFFFF<<1>>|r секунд.\n\nIncrease damage taken from Flame Damage attacks by up to |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_ENGULFING_FLAMES_DUMMY_TP = 'Increase damage taken from Flame Damage attacks by |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_INFERNO_TP = 'Launch a fireball at the nearest enemy every |cFFFFFF5|r seconds for |cFFFFFF15|r seconds, dealing Flame Damage.';
    LUIE_STRING_SKILL_FLAMES_OF_OBLIVION_TP = 'Launch a fireball at |cFFFFFF2|r enemies every |cFFFFFF5|r seconds for |cFFFFFF15|r seconds, dealing Flame Damage.';
    LUIE_STRING_SKILL_CAUTERIZE_TP = 'Launch a fireball at yourself or an ally to cauterize their wounds every |cFFFFFF5|r seconds for |cFFFFFF15|r seconds.';
    LUIE_STRING_SKILL_DRAGONKNIGHT_STANDARD_TP = 'Enemies within the |cFFFFFF8|r meter radius of the standard take Flame Damage every |cFFFFFF1|r second and have Major Defile applied to them.\n\nAn ally near the standard can activate the |cFFFFFFShackle|r synergy.';
    LUIE_STRING_SKILL_DRAGONKNIGHT_STANDARD_GROUND_TP = 'Taking Flame Damage every |cFFFFFF<<2>>|r <<2[second/seconds]>> and afflicted with Major Defile.';
    LUIE_STRING_SKILL_STANDARD_OF_MIGHT_TP = 'Increase damage done and reduce damage taken by |cFFFFFF15|r% while standing within the radius of the standard.\n\nAn ally near the standard can activate the |cFFFFFFShackle|r synergy.';
    LUIE_STRING_SKILL_SHIFTING_STANDARD_TP = 'Enemies within the |cFFFFFF8|r meter radius of the standard take Flame Damage every |cFFFFFF1|r second and have Major Defile applied to them.\n\nActivating this ability again allows you to move the standard to your location.\n\nAn ally near the standard can activate the |cFFFFFFShackle|r synergy.';
    LUIE_STRING_SKILL_SPIKED_ARMOR_TP = 'Return Magic Damage to any enemy that uses a direct damage attack against you for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_HARDENED_ARMOR_TP = 'Return Magic Damage to any enemy that uses a direct damage attack against you for |cFFFFFF<<1>>|r seconds.\n\nAbsorbing damage for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_BURNING_TALONS_TP = 'Afflicted with Flame Damage every |cFFFFFF1|r second and immobilized for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_PROTECTIVE_SCALE_TP = 'Reduce damage taken from projectiles by |cFFFFFF50|r% for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_PROTECTIVE_PLATE_TP = 'Reduce damage taken from projectiles by |cFFFFFF50|r% for |cFFFFFF6|r seconds.\n\nImmune to snare and immobilization effects for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_DRAGON_FIRE_SCALE_TP = 'Reduce damage taken from projectiles by |cFFFFFF50|r% for |cFFFFFF6|r seconds.\n\nWhen you are hit with a projectile, you retaliate by launching a fiery orb at the attacker that deals Flame Damage. This effect can occur once every half second.';
    LUIE_STRING_SKILL_INHALE_TP = 'After |cFFFFFF2.5|r seconds, you exhale fire, dealing Flame Damage to enemies within |cFFFFFF8|r meters.';
    LUIE_STRING_SKILL_DRAW_ESSENCE_TP = "After |cFFFFFF2.5|r seconds, you exhale fire, dealing Flame Damage to enemies within |cFFFFFF8|r meters and restoring |cFFFFFF10|r% of the ability's cost for each enemy hit as Magicka.";
    LUIE_STRING_SKILL_MOLTEN_ARMAMENTS_TP = 'Увеличивает урон полностью заряженных Силовых атак  на |cFFFFFF50|r% в течение |cFFFFFF<<1>>|r секунд.';
    LUIE_STRING_SKILL_PETRIFY_STUN_TP = 'Обращён в камень и оглушён на |cFFFFFF<<1>>|r секунд. Вы не можете атаковать или двигаться во время оглушения.\n\nПо окончанию действия оглушения, получаете Магический урон.';
    LUIE_STRING_SKILL_FOSSILIZE_STUN_TP = 'Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen the stun ends, take Magic Damage and become immobilized for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_SHATTERING_ROCKS_STUN_TP = 'Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen the stun ends, take Magic Damage and your attacker is healed.';
    LUIE_STRING_SKILL_ASH_CLOUD_TP = 'Enemies in the ash cloud have their Movement Speed reduced by |cFFFFFF70|r%, while you and allies are healed every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_ERUPTION_TP = 'Enemies in the ash cloud have their Movement Speed reduced by |cFFFFFF70|r% and take Flame Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_MAGMA_ARMOR_TP = 'Incoming damage is limited to |cFFFFFF3|r% of your Max Health and nearby enemies take Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_CORROSIVE_ARMOR_TP = 'Incoming damage is limited to |cFFFFFF3|r% of your Max Health and nearby enemies take Poison Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nWhile active, this ability and your Direct Damage dealt ignores enemy Physical Resistance.';
    LUIE_STRING_SKILL_STONEFIST_TP = 'Debris is ripped from the ground and held around you for |cFFFFFF12|r seconds.\n\nActivating Stonefist again allows you to launch part of the debris at an enemy, dealing Physical Damage, up to |cFFFFFF3|r times. The final cast stuns for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_STONE_GIANT_TP = 'Debris is ripped from the ground and held around you for |cFFFFFF12|r seconds.\n\nActivating Stone Giant again allows you to launch part of the debris at an enemy, dealing Physical Damage, up to |cFFFFFF3|r times. The final cast stuns for |cFFFFFF3|r seconds.\n\nEach hit applies Stagger, increasing damage taken by |cFFFFFF65|r per stack for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_STAGGER_TP = 'Increase damage taken by |cFFFFFF65|r per stack for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF3|r times when you are hit by Stone Giant.';

    -- Nightblade Skills
    LUIE_STRING_SKILL_MARK_TARGET_TP = 'You have been marked for death by a Nightblade.\n\nThe Nightblade heals for |cFFFFFF40|r% of their Max Health if you die under this effect.';
    LUIE_STRING_SKILL_REAPERS_MARK_TP = 'You have been marked for death by a Nightblade.\n\nThe Nightblade heals for |cFFFFFF60|r% of their Max Health and gains Major Berserk for |cFFFFFF5|r seconds if you die under this effect.';
    LUIE_STRING_SKILL_DEATH_STROKE_DEBUFF = 'Увеличивает урон, получаемый от Клинка ночи на |cFFFFFF20|r% в течение |cFFFFFF6|r секунд.';
    LUIE_STRING_SKILL_INCAPACITATING_STRIKE = 'Increase damage taken from the Nightblade by |cFFFFFF20|r% for |cFFFFFF6|r seconds.\n\nStunned for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_SHADOWY_DISGUISE_TP = 'Invisible for |cFFFFFF<<1>>|r seconds.\n\nYour next direct damage attack used within |cFFFFFF<<1>>|r seconds will always be a Critical Strike.';
    LUIE_STRING_SKILL_RELENTLESS_FOCUS_TP = "For |cFFFFFF<<1>>|r seconds, hitting an enemy with a Light or Heavy Attack increases your Critical Damage and Healing by |cFFFFFF2|r%, up to |cFFFFFF5|r times.\n\nWhile active, hitting an enemy with |cFFFFFF5|r Light or Heavy Attacks converts this ability into Assassin's Scourge, allowing you to fire a spectral arrow for half cost that deals Disease Damage, and heals for |cFFFFFF33|r% of the damage dealt if you are within melee range.\n\nStacks persist after Relentless Focus fades, but are lost when firing the spectral arrow.";
    LUIE_STRING_SKILL_MERCILESS_RESOLVE_TP = "For |cFFFFFF<<1>>|r seconds, hitting an enemy with a Light or Heavy Attack increases your Critical Damage and Healing by |cFFFFFF2|r%, up to |cFFFFFF5|r times.\n\nWhile active, hitting an enemy with |cFFFFFF5|r Light or Heavy Attacks converts this ability into Assassin's Will, allowing you to fire a spectral arrow for half cost that deals Magic Damage, and heals for |cFFFFFF50|r% of the damage dealt if you are within melee range.\n\nStacks persist after Merciless Resolve fades, but are lost when firing the spectral arrow.";
    LUIE_STRING_SKILL_GRIM_FOCUS_TP = "For |cFFFFFF<<1>>|r seconds, hitting an enemy with a Light or Heavy Attack increases your Critical Damage and Healing by |cFFFFFF2|r%, up to |cFFFFFF5|r times.\n\nWhile active, hitting an enemy with |cFFFFFF5|r Light or Heavy Attacks converts this ability into Assassin's Will, allowing you to fire a spectral arrow for half cost that deals Magic Damage, and heals for |cFFFFFF33|r% of the damage dealt if you are within melee range.\n\nStacks persist after Grim Focus fades, but are lost when firing the spectral arrow.";
    LUIE_STRING_SKILL_GRIM_FOCUS_DEFENSE_TP = 'Increase Critical Damage and Healing by |cFFFFFF2|r%, stacking up to |cFFFFFF5|r times.\n\nStacks are lost when firing the spectral bow.';
    LUIE_STRING_SKILL_PATH_OF_DARKNESS_TP = 'You and allies in the corridor of shadows gain Major Expedition for |cFFFFFF4|r seconds every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_TWISTING_PATH_TP = 'You and allies in the corridor of shadows gain Major Expedition for |cFFFFFF4|r seconds every |cFFFFFF1|r second, while enemies in the area take Magic Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_REFRESHING_PATH_TP = 'You and allies in the corridor of shadows gain Major Expedition for |cFFFFFF4|r seconds and heal every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_MANIFESTATION_OF_TERROR_TP = 'Detonates when a enemy comes within |cFFFFFF6|r meters, summoning a dark spirit to terrify up to |cFFFFFF6|r enemies, causing them to cower in fear for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_SUMMON_SHADE_TP = "A shade version of yourself fights at your side for |cFFFFFF<<1>>|r seconds.\n\nThe shade slashes at an enemy, dealing Magic Damage. The shade's attacks inflict Minor Maim for |cFFFFFF4|r seconds.";
    LUIE_STRING_SKILL_DARK_SHADE_TP = "A shade version of yourself fights at your side for |cFFFFFF<<1>>|r seconds.\n\nThe shade slashes at an enemy, dealing Magic Damage and occasionally whirlwinds, dealing Magic Damage to enemies within |cFFFFFF6|r meters. The shade's attacks inflict Minor Maim for |cFFFFFF4|r seconds.";
    LUIE_STRING_SKILL_SHADOW_IMAGE_TP = "A shade version of yourself stays in place and attacks an enemy from range for |cFFFFFF<<1>>|r seconds.\n\nThe shade shoots at an enemy, dealing Magic Damage. The shade's attacks inflict Minor Maim for |cFFFFFF4|r seconds.\n\nWhile the shade is summoned, you can activate this ability again to teleport to the shade's location.";
    LUIE_STRING_SKILL_CORROSIVE_SPIN_TP = 'Corrosive Spin';
    LUIE_STRING_SKILL_HIDDEN_REFRESH_TP = 'Invisible, healing every |cFFFFFF1|r second, and Movement Speed increased by |cFFFFFF70|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_CONSUMING_DARKNESS_TP = 'Enemies in the ring of shadow have their Movement Speed reduced by |cFFFFFF70|r%, while you and allies gain Major Protection.\n\nAllies in the area can activate the |cFFFFFFHidden Refresh|r synergy.';
    LUIE_STRING_SKILL_BOLSTERING_DARKNESS_TP = 'Enemies in the ring of shadow have their Movement Speed reduced by |cFFFFFF70|r%, while you and allies gain Major Protection in the ring and even after leaving it.\n\nAllies in the area can activate the |cFFFFFFHidden Refresh|r synergy.';
    LUIE_STRING_SKILL_VEIL_OF_BLADES_TP = 'Enemies in the ring of shadow have their Movement Speed reduced by |cFFFFFF70|r% and take Magic Damage every |cFFFFFF1|r second, while you and allies gain Major Protection.\n\nAllies in the area can activate the |cFFFFFFHidden Refresh|r synergy.';
    LUIE_STRING_SKILL_MALEVOLENT_OFFERING_TP = 'Высасывает здоровье каждую |cFFFFFF1|r секунду в течение |cFFFFFF<<1>>|r секунд.';
    LUIE_STRING_SKILL_CRIPPLE_TP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds.\n\nMovement Speed reduced by |cFFFFFF<<2>>|r% for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_CRIPPLING_GRASP_TP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds.\n\nMovement Speed reduced by |cFFFFFF30|r% for |cFFFFFF4|r seconds.\n\nImmobilized for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_DEBILITATE_TP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds. Each tick applies the Overcharged status effect.\n\nMovement Speed reduced by |cFFFFFF<<2>>|r% for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_SIPHONING_STRIKES_TP = 'Ваши обычные и силовые атаки исцеляют вас в течение |cFFFFFF20|r секунд. Полностью заряженная силовая атака исцеляет в два раза больше.';
    LUIE_STRING_SKILL_LEECHING_STRIKES_TP = 'Your Light and Heavy Attacks heal you and restore |cFFFFFF106|r Stamina for |cFFFFFF20|r seconds. Fully charged Heavy Attacks restore twice the value.\n\nYou restore up to |cFFFFFF4270|r additional Stamina when the effect ends, based on the length of time Leeching Strikes was active.';
    LUIE_STRING_SKILL_SIPHONING_ATTACKS_TP = 'Your Light and Heavy Attacks heal you and restore |cFFFFFF106|r Magicka for |cFFFFFF20|r seconds. Fully charged Heavy Attacks restore twice the value.\n\nYou restore up to |cFFFFFF4270|r additional Magicka when the effect ends, based on the length of time Siphoning Attacks was active.';
    LUIE_STRING_SKILL_SOUL_TETHER_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF8|r seconds.\n\nStunned for |cFFFFFF4|r seconds.';

    -- Sorcerer
    LUIE_STRING_SKILL_PERSISTENCE = 'Your next Health, Magicka, or Stamina ability used within |cFFFFFF4|r seconds costs |cFFFFFF<<1>>|r% less.';
    LUIE_STRING_SKILL_CRYSTAL_WEAVER_TP = 'Your next non-Ultimate ability cast within |cFFFFFF<<1>>|r <<1[second/seconds]>> costs |cFFFFFF10|r% less.';
    LUIE_STRING_SKILL_CRYSTAL_WEAPON_TP = "Your next Light or Heavy Attack used within |cFFFFFF<<1>>|r <<1[second/seconds]>> deals additional Physical Damage and reduces the target's Armor by |cFFFFFF1000|r for |cFFFFFF5|r seconds.";
    LUIE_STRING_SKILL_CRYSTAL_FRAGMENTS_TP = 'Ваше следующее применение Crystal Fragments в течение |cFFFFFF<<1>>|r секунд происходит мгновенно, наносит на |cFFFFFF66|r% больше урона, и расходует на |cFFFFFF50|r% меньше Магии.';
    LUIE_STRING_SKILL_SHATTERING_PRISON_TP = 'Immobilized for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThe shards deal Magic Damage when the effect ends.';
    LUIE_STRING_SKILL_RUNE_CAGE_TP = 'Imprisoned in a sphere of dark magic and stunned for |cFFFFFF<<1>>|r seconds.\n\nDeals Magic Damage if the stun lasts the full duration.';
    LUIE_STRING_SKILL_DEFENSIVE_RUNE_TP = 'Следующий противник, который атакует вас, окажется заперт в тесную сферу тёмной магии, оглушающую вскоре его на |cFFFFFF3|r секунды.';
    LUIE_STRING_SKILL_DAEDRIC_MINES_TP = 'Взрывается, когда близко подходит противник, нанося Магический урон и обездвиживая его на |cFFFFFF2|r секунды.';
    LUIE_STRING_SKILL_NEGATE_MAGIC_TP = 'Enemies in the globe are stunned.\n\nEnemy players will be silenced rather than stunned.';
    LUIE_STRING_SKILL_SUPPRESSION_FIELD_TP = 'Enemies in the globe are stunned and take Magic Damage every |cFFFFFF1|r second.\n\nEnemy players will be silenced rather than stunned.';
    LUIE_STRING_SKILL_ABSORPTION_FIELD_TP = 'Enemies in the globe are stunned, while you and allies are healed every |cFFFFFF1|r second.\n\nEnemy players will be silenced rather than stunned.';
    LUIE_STRING_SKILL_UNSTABLE_FAMILIAR_TP = "Unstable Familiar сражается на вашей стороне. Нестабильный прислужник останется, пока не будет убит или отозван.\n\nThe familiar's attacks deal Shock Damage.\n\nYou can activate the familiar's special ability, dealing Shock Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds to enemies near him.";
    LUIE_STRING_SKILL_UNSTABLE_CLANNFEAR_TP = "Unstable Clannfear сражается на вашей стороне. Нестабильный кланфир останется, пока не будет убит или отозван.\n\nThe clannfear's headbutt deals Physical Damage, while its tail spike hits enemies within |cFFFFFF6|r meters for Physical Damage after |cFFFFFF1|r second.\n\nYou can activate the clannfear's special ability, healing you and the clannfear.";
    LUIE_STRING_SKILL_VOLATILE_FAMILIAR_TP = "Volatile Familiar сражается на вашей стороне. Взрывной прислужник останется, пока не будет убит или отозван.\n\nThe familiar's attacks deal Shock Damage.\n\nYou can activate the familiar's special ability, dealing Shock Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds to enemies near him. The final pulse will stun all enemies hit for |cFFFFFF3|r seconds.";
    LUIE_STRING_SKILL_FAMILIAR_DAMAGE_PULSE_SELF_TP = 'Your familiar is pulsing waves of unstable electricity, dealing Shock Damage to nearby enemies every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_FAMILIAR_DAMAGE_PULSE_TP = 'Pulsing waves of unstable electricity, dealing Shock Damage to nearby enemies every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_FAMILIAR_DAMAGE_PULSE_SELF_STUN_TP = 'Your familiar is pulsing waves of volatile electricity, dealing Shock Damage to nearby enemies every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nThe final pulse will stun all enemies hit for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_FAMILIAR_DAMAGE_PULSE_STUN_TP = 'Pulsing waves of volatile electricity, dealing Shock Damage to nearby enemies every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nThe final pulse will stun all enemies hit for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_UNSTABLE_PULSE = 'Нестабильное пульсирование';
    LUIE_STRING_SKILL_VOLATILE_PULSE = 'Переменное пульсирование';
    LUIE_STRING_SKILL_DAEDRIC_CURSE_TP = 'After |cFFFFFF6|r seconds the rune detonates, dealing Magic Damage to you and nearby allies.';
    LUIE_STRING_SKILL_DAEDRIC_PREY_TP = "After |cFFFFFF6|r seconds the rune detonates, dealing Magic Damage to you and nearby allies.\n\nWhile the curse is active, the Sorcerer's pets deal an additional |cFFFFFF55|r% damage to you.";
    LUIE_STRING_SKILL_HAUNTING_CURSE_TP = 'After |cFFFFFF3.5|r seconds the rune detonates, dealing Magic Damage and splashing to nearby allies.\n\nThe curse will apply a second time, detonating again after |cFFFFFF8.5|r seconds.';
    LUIE_STRING_SKILL_WINGED_TWILIGHT_TP = "Winged Twilight сражается на вашей стороне. Крылатый сумрак останется, пока не будет убит или отозван.\n\nThe winged twilight's zaps deal Shock Damage and its kicks deal Shock Damage.\n\nYou can activate the winged twilight's special ability, causing it to heal the winged twilight and one other friendly target.";
    LUIE_STRING_SKILL_TWILIGHT_TORMENTOR_TP = "Twilight Tormentor сражается на вашей стороне. Сумрак-мучитель останется, пока не будет убит или отозван.\n\nThe twilight tormentor's zaps deal Shock Damage and its kicks deal Shock Damage.\n\nYou can activate the twilight tormentor's special ability, causing it to deal |cFFFFFF53|r% more damage to enemies above |cFFFFFF50|r% health for |cFFFFFF15|r seconds.";
    LUIE_STRING_SKILL_TWILIGHT_MATRIARCH_TP = "Twilight Matriarch сражается на вашей стороне. Сумрак-матриарх останется, пока не будет убит или отозван.\n\nThe twilight matriarch's zaps deal Shock Damage and its kicks deal Shock Damage\n\nYou can activate the twilight matriarch's special ability, causing it to heal the matriarch and up to 2 other friendly tagets.";
    LUIE_STRING_SKILL_TORMENTOR_DAMAGE_BOOST_SELF_TP = 'Increase Twilight Tormentor damage against enemies above |cFFFFFF50|r% Health by |cFFFFFF53|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_TORMENTOR_DAMAGE_BOOST_TP = 'Increase damage against enemies above |cFFFFFF50|r% Health by |cFFFFFF53|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BOUND_ARMOR_TP = 'Увеличивает на |cFFFFFF<<2>>|r% блокируемый урон на |cFFFFFF<<1>>|r секунды.';
    LUIE_STRING_SKILL_BOUND_ARMAMENTS_SKILL_TP = 'For |cFFFFFF<<1>>|r seconds, hitting an enemy with a Light or Heavy Attack summons a Bound weapon for |cFFFFFF10|r seconds, up to |cFFFFFF4|r times.\n\nYou can reactivate the ability for half cost to arm the weapons, causing them to strike your target for Physical Damage every |cFFFFFF0.3|r seconds.';
    LUIE_STRING_SKILL_BOUND_ARMAMENTS_STACK_TP = 'For |cFFFFFF<<1>>|r seconds up to |cFFFFFF4|r Bound weapons will hover near you.\n\nReactivating Bound Armaments will arm the weapons, causing them to strike your target for Physical Damage every |cFFFFFF0.3|r seconds.';
    LUIE_STRING_SKILL_STORM_ATRONACH_TP = 'An immobile storm atronach zaps the closest enemy, dealing Shock Damage every |cFFFFFF1|r second.\n\nAn ally near the atronach can activate the |cFFFFFFCharged Lightning|r synergy.';
    LUIE_STRING_SKILL_CHARGED_ATRONACH_TP = 'An immobile storm atronach zaps the closest enemy, dealing Shock Damage every |cFFFFFF1|r second, and periodically deals Shock Damage to enemies around it.\n\nAn ally near the atronach can activate the |cFFFFFFCharged Lightning|r synergy.';
    LUIE_STRING_SKILL_MAGES_FURY_TP = 'Falling below |cFFFFFF20%|r Health causes an explosion, dealing Shock Damage to you and nearby allies.';
    LUIE_STRING_SKILL_ENDLESS_FURY_TP = 'Falling below |cFFFFFF20%|r Health causes an explosion, dealing Shock Damage to you and nearby allies.\n\nRestore Magicka to the Sorcerer on death.';
    LUIE_STRING_SKILL_LIGHTNING_FORM_TP = 'Enemies within |cFFFFFF5|r meters take Shock Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_HURRICANE_TP = 'Enemies within |cFFFFFF5|r meters take Physical Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nThe winds grow in damage and size, increasing up to |cFFFFFF150|r% more damage and up to |cFFFFFF9|r meters in size.';
    LUIE_STRING_SKILL_LIGHTNING_SPLASH_TP = 'Enemies standing in the |cFFFFFF<<2>>|r meter radius of the storm energy take Shock Damage every |cFFFFFF1|r second.\n\nAn ally standing within the nexus can activate the |cFFFFFFConduit|r synergy.';
    LUIE_STRING_SKILL_SURGE_TP = 'Dealing Critical Damage heals you. This effect can occur once every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_POWER_SURGE_TP = 'Activating a Critical Heal causes the ability to heal you and allies within |cFFFFFF18|r meters. This effect can occur once every |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_BOLT_ESCAPE_FATIGUE_TP = 'Consecutive Bolt Escape casts cost |cFFFFFF33|r% more Magicka per stack for the next |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_INTERCEPT_TP = 'A Ball of Lightning absorbs all projectiles directed at you for the next |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_OVERLOAD_TP = 'Обычные атаки заменены шаровыми молниями, наносящими урон от Электричества, а Силовые атаки сжигают противников уроном от Электричества в радиусе от атакуемой цели.\n\nАтаки расходуют очки абсолютной способности, пока они не закончатся или пока способность не будет отключена.';
    LUIE_STRING_SKILL_ENERGY_OVERLOAD_TP = 'Обычные атаки заменены шаровыми молниями, наносящими урон от Электричества, а Силовые атаки сжигают противников уроном от Электричества в радиусе от атакуемой цели.\n\nОбычные и Силовые атаки восстанавливают Магию.\n\nАтаки расходуют очки абсолютной способности, пока они не закончатся или пока способность не будет отключена.';
    LUIE_STRING_SKILL_SUPPRESSION_FIELD_STUN = 'Stunned and taking Magic Damage every |cFFFFFF0.5|r seconds.';
    LUIE_STRING_SKILL_SUPPRESSION_FIELD_SILENCE = 'Silenced and taking Magic Damage every |cFFFFFF0.5|r seconds.';

    -- Templar
    LUIE_STRING_SKILL_SPEAR_SHARDS_TP = 'Enemies in the |cFFFFFF8|r meter radius of the spear take Magic Damage every |cFFFFFF1|r second.\n\nAn ally near the spear can activate the |cFFFFFFBlessed Shards|r synergy.';
    LUIE_STRING_SKILL_LUMINOUS_SHARDS_TP = 'Enemies in the |cFFFFFF8|r meter radius of the spear take Magic Damage every |cFFFFFF1|r second.\n\nAn ally near the spear can activate the |cFFFFFFHoly Shards|r synergy.';
    LUIE_STRING_SKILL_BLAZING_SHIELD_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen the shield expires it explodes outward, dealing |cFFFFFF40|r% of the damage it absorbed as Magic Damage to enemies within |cFFFFFF5|r meters.';
    LUIE_STRING_SKILL_RADIAL_SWEEP_TP = 'Enemies within |cFFFFFF8|r meters take Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SUN_FIRE_TP = 'Afflicted with Flame Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nMovement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<2>>|r seconds.';
    LUIE_STRING_SKILL_SUN_FIRE_SNARE_TP = 'Afflicted with Flame Damage every |cFFFFFF2|r seconds for |cFFFFFF<<2>>|r seconds.\n\nMovement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SOLAR_BARRAGE_TP = 'Enemies within |cFFFFFF8|r meters take Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BACKLASH_TP = '|cFFFFFF20|r% of all damage taken for the next |cFFFFFF<<1>>|r seconds will be copied and released as Magic Damage when the effect ends.';
    LUIE_STRING_SKILL_PURIFYING_LIGHT_TP = '|cFFFFFF20|r% of all damage taken for the next |cFFFFFF<<1>>|r seconds will be copied and released as Magic Damage when the effect ends.\n\nWhen the effect ends, a pool of sunlight remains attached to you, healing the Templar and their allies if they are nearby every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_POWER_OF_THE_LIGHT_TP = '|cFFFFFF20|r% of all damage taken for the next |cFFFFFF<<1>>|r seconds will be copied and released as Physical Damage when the effect ends.';
    LUIE_STRING_SKILL_ECLIPSE_TP = 'Using a Direct Damage attack harms you with growing intensity.\n\nYour first attack reduces your movement speed by |cFFFFFF30|r% for |cFFFFFF4|r seconds, your second attack immobilizes you for |cFFFFFF3|r seconds, and your third attack stuns you for |cFFFFFF3|r seconds.\n\nThe effects can activate once every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_LIVING_DARK_TP = 'Enveloped in a lightless sphere for |cFFFFFF<<1>>|r seconds. Anytime an enemy uses a Direct Damage attack aganst you, the sphere lashes back, immobilizing them for |cFFFFFF3|r seconds and healing you.\n\nThese effects can occur once every half second.';
    LUIE_STRING_SKILL_UNSTABLE_CORE_TP = 'Using a Direct Damage attack deals increasing Magic Damage to you and allies within |cFFFFFF5|r meters, and harms you with growing intensity.\n\nYour first attack reduces your movement speed by |cFFFFFF30|r% for |cFFFFFF4|r seconds, your second attack immobilizes you for |cFFFFFF3|r seconds, and your third attack stuns you for |cFFFFFF3|r seconds.\n\nThe effects can activate once every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_RADIANT_DESTRUCTION_TP = 'Afflicted with Magic Damage every |cFFFFFF0.75|r seconds for |cFFFFFF<<1>>|r seconds. Deals up to |cFFFFFF480|r% more damage if you are below |cFFFFFF50|r% Health.';
    LUIE_STRING_SKILL_NOVA_TP = 'Enemies in the |cFFFFFF8|r meter radius of the nova take Magic Damage every |cFFFFFF1|r second and have Major Maim applied to them.\n\nAn ally near the fragment can activate the |cFFFFFFSupernova|r synergy.';
    LUIE_STRING_SKILL_NOVA_GROUND_TP = 'Taking Magic Damage every |cFFFFFF1|r second and afflicted with Major Maim.';
    LUIE_STRING_SKILL_SOLAR_PRISON_TP = 'Enemies in the |cFFFFFF8|r meter radius of the nova take Magic Damage every |cFFFFFF1|r second and have Major Maim applied to them.\n\nAn ally near the fragment can activate the |cFFFFFFGravity Crush|r synergy.';
    LUIE_STRING_SKILL_SOLAR_DISTURBANCE_TP = 'Enemies in the |cFFFFFF8|r meter radius of the nova take Magic Damage every |cFFFFFF1|r second and have Major Maim applied to them.\n\nMajor Maim persists on enemies who leave the area for |cFFFFFF<<2>>|r seconds.\n\nAn ally near the fragment can activate the |cFFFFFFSupernova|r synergy.';
    LUIE_STRING_SKILL_SOLAR_DISTURBANCE_GROUND_TP = 'Taking Magic Damage every |cFFFFFF1|r second.\n\nEach time you take damage you are afflicted with Major Maim for |cFFFFFF<<2>>|r seconds.';
    LUIE_STRING_SKILL_CLEANSING_RITUAL_TP = 'You and allies in the |cFFFFFF12|r meter radius of sacred light are healed every |cFFFFFF2|r seconds.\n\nAllies in the area can activate the |cFFFFFFPurify|r synergy.';
    LUIE_STRING_SKILL_CLEANSING_RITUAL_RETRIBUTION_TP = 'Enemies in the |cFFFFFF12|r meter radius of sacred light take Magic Damage every |cFFFFFF2|r seconds and the damage increases by |cFFFFFF5|r% per tick.\n\nAllies in the area can activate the |cFFFFFFPurify|r synergy.';
    LUIE_STRING_SKILL_RITE_OF_PASSAGE_TP = 'Healing you and allies within |cFFFFFF20|r meters every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SACRED_GROUND_TP = 'Increase block mitigation by |cFFFFFF10|r% while standing on Sacred Ground.';
    LUIE_STRING_SKILL_RUNE_FOCUS_TP = 'Standing in the |cFFFFFF3|r meter radius of the rune heals you every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_CHANNELED_FOCUS_TP = 'Restoring |cFFFFFF242|r Magicka every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nStanding in the |cFFFFFF3|r meter radius of the rune heals you every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_RESTORING_FOCUS_TP = 'Restoring |cFFFFFF242|r Stamina every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nStanding in the |cFFFFFF3|r meter radius of the rune heals you every |cFFFFFF1|r second.';

    -- Warden
    LUIE_STRING_SKILL_BOND_WITH_NATURE = 'Bond with Nature';
    LUIE_STRING_SKILL_CUTTING_DIVE_TP = 'Afflicted with Bleed Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nThis effect stacks up to |cFFFFFF7|r times.';
    LUIE_STRING_SKILL_SCORCH_TP = 'Через |cFFFFFF3|r секунды, наносит Магический урон противникам перед вами на расстоянии до |cFFFFFF20|r метров.';
    LUIE_STRING_SKILL_SUB_ASSAULT_TP = 'After |cFFFFFF3|r seconds, deal Poison Damage to enemies up to |cFFFFFF20|r meters in front of you.';
    LUIE_STRING_SKILL_SUB_ASSAULT_ECHO_TP = 'After |cFFFFFF3|r seconds, deal Poison Damage to enemies up to |cFFFFFF20|r meters in front of you.\n\nAfter the shalk complete their attack, they burrow again for |cFFFFFF3|r seconds and then resurface again.';
    LUIE_STRING_SKILL_DEEP_FISSURE_TP = 'Через |cFFFFFF3|r секунды, наносит Магический урон и накладывает Major Breach на |cFFFFFF5|r секунд противникам перед вами на расстоянии до |cFFFFFF20|r метров.';
    LUIE_STRING_SKILL_FETCHER_INFECTION_BONUS_DAMAGE_TP = 'Ваше следующее применение Fetcher Infection нанесёт на |cFFFFFF50|r% больше урона.';
    LUIE_STRING_SKILL_GROWING_SWARM_TP = 'Afflicted with Bleed Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nAllies within |cFFFFFF5|r meters take Bleed Damage every |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_BETTY_NETCH_TP = 'Every |cFFFFFF5|r seconds, the netch removes |cFFFFFF1|r negative effect from you.';
    LUIE_STRING_SKILL_BLUE_BETTY_TP = 'Restoring |cFFFFFF192|r Magicka every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEvery |cFFFFFF5|r seconds, the netch removes |cFFFFFF1|r negative effect from you.';
    LUIE_STRING_SKILL_BULL_NETCH_TP = 'Restoring |cFFFFFF192|r Stamina every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEvery |cFFFFFF5|r seconds, the netch removes |cFFFFFF1|r negative effect from you.';
    LUIE_STRING_SKILL_FERAL_GUARDIAN_TP = "На вашей стороне сражается гризли. Гризли остаётся, пока не будет убит или отозван.\n\nThe grizzly swipes at an enemy, dealing Magic Damage, and sometimes swipes all enemies in front of it, dealing Magic Damage and stunning them for |cFFFFFF2|r seconds.\n\nВы можете активировать Guardian's Wrath за |cFFFFFF75|r очков ульты, чтобы медведь нанёс сильный удар противнику, наносящий Магический урон. Deals |cFFFFFF100|r% more damage to enemies below |cFFFFFF25|r% Health.";
    LUIE_STRING_SKILL_ETERNAL_GUARDIAN_TP = "На вашей стороне сражается гризли. Гризли остаётся, пока не будет убит или отозван.\n\nThe grizzly swipes at an enemy, dealing Magic Damage, and sometimes swipes all enemies in front of it, dealing Magic Damage and stunning them for |cFFFFFF2|r seconds.\n\nВы можете активировать Guardian's Wrath за |cFFFFFF75|r очков ульты, чтобы медведь нанёс сильный удар противнику, наносящий Магический урон. Deals |cFFFFFF100|r% more damage to enemies below |cFFFFFF25|r% Health.\n\nРаз в минуту гризли автоматически возрождается снова, если будет убит.";
    LUIE_STRING_SKILL_WILD_GUARDIAN_TP = "На вашей стороне сражается гризли. Гризли остаётся, пока не будет убит или отозван.\n\nThe grizzly swipes at an enemy, dealing Physical Damage, and sometimes swipes all enemies in front of it, dealing Physical Damage and stunning them for |cFFFFFF2|r seconds.\n\nВы можете активировать Guardian's Savagery за |cFFFFFF75|r очков ульты, чтобы медведь нанёс сильный удар противнику, наносящий Физический урон. Deals |cFFFFFF100|r% more damage to enemies below |cFFFFFF25|r% Health.";
    LUIE_STRING_SKILL_GUARDIANS_WRATH_TP = "Цель атаки Guardian's Wrath.";
    LUIE_STRING_SKILL_GUARDIANS_SAVAGERY_TP = "Цель атаки Guardian's Savagery.";
    LUIE_STRING_SKILL_ETERNAL_GUARDIAN_COOLDOWN_TP = 'Ваш медведь только что был возрождён и не может снова возродиться автоматически.';
    LUIE_STRING_SKILL_HEALING_SEED_TP = 'After |cFFFFFF6|r seconds, heals you and allies within the |cFFFFFF8|r meter field of flowers.\n\nAn ally within the field can activate the |cFFFFFFHarvest|r synergy.';
    LUIE_STRING_SKILL_BUDDING_SEEDS_TP = 'After |cFFFFFF6|r seconds, heals you and allies within the |cFFFFFF8|r meter field of flowers.\n\nWhile the field grows, you and allies are healed every |cFFFFFF1|r second.\n\nYou can activate this ability again to cause it to instantly bloom.\n\nAn ally within the field can activate the |cFFFFFFHarvest|r synergy.';
    LUIE_STRING_SKILL_CORRUPTING_POLLEN_TP = 'After |cFFFFFF6|r seconds, heals you and allies within the |cFFFFFF8|r meter field of flowers.\n\nEnemies who enter the field are afflicted with Major Defile.\n\nAn ally within the field can activate the |cFFFFFFHarvest|r synergy.';
    LUIE_STRING_SKILL_LIVING_VINES_TP = 'Исцеляет вас, когда вы получаете урон, действует в течение |cFFFFFF<<1>>|r секунд. Эффект может срабатывать раз в |cFFFFFF1|r секунду.';
    LUIE_STRING_SKILL_LEECHING_VINES_TP = 'Исцеляет вас, когда вы получаете урон, действует в течение |cFFFFFF<<1>>|r секунд. Эффект может срабатывать раз в |cFFFFFF1|r секунду.\n\nЛозы накладывают Minor Lifesteal на противника, который наносит вам урон, на |cFFFFFF10|r секунд.';
    LUIE_STRING_SKILL_LIVING_TRELLIS_TP = 'Исцеляет вас, когда вы получаете урон, действует в течение |cFFFFFF<<1>>|r секунд. Эффект может срабатывать раз в |cFFFFFF1|r секунду.\n\nКогда лозы исчезают, дополнительно восстанавливает здоровье.';
    LUIE_STRING_SKILL_LOTUS_FLOWER_TP = 'Your Light and Heavy Attacks heal you or an ally within |cFFFFFF28|r meters for |cFFFFFF20|r seconds. Fully charged Heavy Attacks restore three times the value.';
    LUIE_STRING_SKILL_NATURES_GRASP_TP = 'Исцеляет каждую |cFFFFFF1|r секунду в течение |cFFFFFF<<1>>|r секунд.\n\nХранитель получает |cFFFFFF3|r очка ульты, когда эффект заканчивается, если находится в бою.';
    LUIE_STRING_SKILL_NATURES_GRASP_SELF_TP = 'Исцеляет каждую |cFFFFFF1|r секунду в течение |cFFFFFF<<1>>|r секунд.\n\nВы получаете |cFFFFFF3|r очка ульты, когда эффект заканчивается, если находитесь в бою.';
    LUIE_STRING_SKILL_SECLUDED_GROVE_TP = 'Healing you and allies in the |cFFFFFF8|r meter radius of the healing forest every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_HEALING_THICKET_TP = 'Every |cFFFFFF1|r second apply a |cFFFFFF4|r second duration heal over time effect on you and allies in the |cFFFFFF8|r meter radius of the healing forest.';
    LUIE_STRING_SKILL_IMPALING_SHARDS_TP = 'Enemies in the |cFFFFFF6|r meter radius of icy shards take Frost Damage and have their movement speed reduced by |cFFFFFF30|r% for |cFFFFFF3|r seconds every |cFFFFFF1|r second.\n\nThis ability has a higher chance to apply the Chilled status effect.';
    LUIE_STRING_SKILL_CRYSTALLIZED_SHIELD_TP = 'Поглощает урон максимум |cFFFFFF3|r снарядов.\n\nКаждый раз при поглощении снаряда вы восстанавливаете Магии.';
    LUIE_STRING_SKILL_CRYSTALLIZED_SLAB_TP = 'Поглощает урон максимум |cFFFFFF3|r снарядов.\n\nКаждый раз при поглощении снаряда вы восстанавливаете Магии и запускаете обратно во врага ледяной шар, наносящий урон от Мороза.';
    LUIE_STRING_SKILL_SHIMMERING_SHIELD_TP = 'Поглощает урон максимум |cFFFFFF3|r снарядов.\n\nКаждый раз при поглощении снаряда вы восстанавливаете Магии и даёт Major Heroism в течение |cFFFFFF6|r секунд.';
    LUIE_STRING_SKILL_FROZEN_GATE_TP = 'Detonates when an enemy enters the |cFFFFFF5|r meter radius of the gate, dealing Frost Damage, teleporting the enemy to you, and immobilizing them for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_FROZEN_DEVICE_TP = 'Detonates when an enemy enters the |cFFFFFF5|r meter radius of the gate, dealing Frost Damage, teleporting the enemy to you, immobilizing them for |cFFFFFF3|r seconds, and applying Major Maim for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_FROZEN_RETREAT_TP = 'Detonates when an enemy enters the |cFFFFFF5|r meter radius of the gate, dealing Frost Damage, teleporting the enemy to you, and immobilizing them for |cFFFFFF3|r seconds.\n\nAn ally in the portal can activate the |cFFFFFFIcy Escape|r synergy.';
    LUIE_STRING_SKILL_SLEET_STORM_TP = 'Enemies in the |cFFFFFF10|r meter radius of the storm take Frost Damage and have their movement speed reduced by |cFFFFFF40|r% every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_PERMAFROST_TP = 'Enemies in the |cFFFFFF10|r meter radius of the storm take Frost Damage and have their movement speed reduced by |cFFFFFF70|r% every |cFFFFFF1|r second.\n\nEach hit applies the Chilled status effect.';
    LUIE_STRING_SKILL_PERMAFROST_GROUND_TP = 'Taking Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF70|r%.\n\nEach time you take damage you are afflicted with the Chilled status effect.';
    LUIE_STRING_SKILL_ARCTIC_BLAST_TP = 'Healing every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nWhile the effect persists, the winds pulse outwards, dealing Frost Damage every |cFFFFFF1|r second to enemies within |cFFFFFF6|r meters. Enemies hit by this effect |cFFFFFF3|r times are stunned for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_ARCTIC_BLAST_GROUND_TP = 'Taking Frost Damage every |cFFFFFF1|r second.\n\nIf you take damage from Arctic Blast |cFFFFFF3|r times, you will be stunned for |cFFFFFF4|r seconds.';

    -- Necromancer
    LUIE_STRING_SKILL_REUSABLE_PARTS_TP = 'Reduce the cost of your next Blastbones, Skeletal Mage, or Spirit Mender by |cFFFFFF<<1>>|r%.';
    LUIE_STRING_SKILL_FLAME_SKULL_TP = 'Every third cast of <<2>> deals |cFFFFFF20|r% increased damage.';
    LUIE_STRING_SKILL_RICOCHET_SKULL_TP = 'Every third cast of Ricochet Skull deals |cFFFFFF20|r% increased damage and will bounce up to |cFFFFFF2|r times to other nearby enemies.';
    LUIE_STRING_SKILL_BLASTBONES_TP = 'A flaming skeleton runs toward your target and explodes when it gets close to them, dealing Flame Damage to all enemies within |cFFFFFF6|r meters.\n\nThe skeleton remains for |cFFFFFF8|r seconds or until it explodes.\n\nCreates a corpse on death.';
    LUIE_STRING_SKILL_BLIGHTED_BLASTBONES_TP = 'A decaying skeleton runs toward your target and explodes when it gets close to them, dealing Disease Damage to all enemies within |cFFFFFF6|r meters and applying Major Defile to them for |cFFFFFF4|r seconds.\n\nThe skeleton remains for |cFFFFFF8|r seconds or until it explodes.\n\nCreates a corpse on death.';
    LUIE_STRING_SKILL_STALKING_BLASTBONES_TP = 'A flaming skeleton runs toward your target and explodes when it gets close to them, dealing Flame Damage to all enemies within |cFFFFFF6|r meters.\n\nEvery second the skeleton spends chasing its target increases the damage of the explosion by |cFFFFFF10|r% up to a maximum of |cFFFFFF50|r% more damage.\n\nThe skeleton remains for |cFFFFFF8|r seconds or until it explodes.\n\nCreates a corpse on death.';
    LUIE_STRING_SKILL_BONEYARD_TP = 'Enemies in the |cFFFFFF6|r meter radius of the graveyard take Frost Damage every |cFFFFFF1|r second.\n\nAn ally standing in the graveyard can activate the |cFFFFFFGrave Robber|r synergy.';
    LUIE_STRING_SKILL_UNNERVING_BONEYARD_TP = 'Enemies in the |cFFFFFF6|r meter radius of the graveyard take Frost Damage every |cFFFFFF1|r second and are afflicted with Major Breach.\n\nAn ally standing in the graveyard can activate the |cFFFFFFGrave Robber|r synergy.';
    LUIE_STRING_SKILL_UNNERVING_BONEYARD_GROUND_TP = 'Taking Frost Damage every |cFFFFFF<<2>>|r <<2[second/seconds]>> and afflicted with Major Breach.';
    LUIE_STRING_SKILL_AVID_BONEYARD_TP = 'Enemies in the |cFFFFFF6|r meter radius of the graveyard take Frost Damage every |cFFFFFF1|r second.\n\nYou or an ally standing in the graveyard can activate the |cFFFFFFGrave Robber|r synergy.';
    LUIE_STRING_SKILL_SKELETAL_MAGE_TP = 'A skeletal mage fights at your side. The skeletal mage remains for |cFFFFFF<<1>>|r seconds.\n\nThe mage attacks the closest enemy every |cFFFFFF2|r seconds, dealing Shock Damage.\n\nCreates a corpse on death.';
    LUIE_STRING_SKILL_SKELETAL_ARCHER_TP = 'A skeletal archer fights at your side. The skeletal archer remains for |cFFFFFF<<1>>|r seconds.\n\nThe archer attacks the closest enemy every |cFFFFFF2|r seconds, dealing Physical Damage.\n\nEach time the archer deals damage, its next attack will do |cFFFFFF5|r% more damage than the previous attack.\n\nCreates a corpse on death.';
    LUIE_STRING_SKILL_SKELETAL_ARCANIST_TP = 'A skeletal arcanist fights at your side. The skeletal arcanist remains for |cFFFFFF<<1>>|r seconds.\n\nThe arcanist attacks the closest enemy every |cFFFFFF2|r seconds, dealing Shock Damage to them and enemies within |cFFFFFF4|r meters.\n\nCreates a corpse on death.';
    LUIE_STRING_SKILL_SHOCKING_SIPHON_TP = 'Enemies within |cFFFFFF5|r meters of the corpse and between you and the corpse take Shock Damage over |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SHOCKING_SIPHON_GROUND_TP = 'Taking rapidly ticking Shock Damage.';
    LUIE_STRING_SKILL_DETONATING_SIPHON_TP = 'Enemies within |cFFFFFF5|r meters of the corpse and between you and the corpse take Disease Damage over |cFFFFFF<<1>>|r seconds.\n\nWhen the siphon ends it causes the corpse to explode, dealing additional Disease Damage to all enemies within |cFFFFFF5|r meters of the corpse.';
    LUIE_STRING_SKILL_DETONATING_SIPHON_GROUND_TP = 'Taking rapidly ticking Disease Damage.\n\nWhen the siphon ends it causes the corpse to explode, dealing Disease Damage to you and nearby allies.';
    LUIE_STRING_SKILL_MYSTIC_SIPHON_TP = 'Enemies within |cFFFFFF5|r meters of the corpse and between you and the corpse take Shock Damage over |cFFFFFF<<1>>|r seconds.\n\nYou also restore |cFFFFFF1260|r Magicka over |cFFFFFF<<1>>|r seconds while siphoning the corpse.';
    LUIE_STRING_SKILL_FROZEN_COLOSSUS_TP = 'A frostbitten Flesh Colossus smashes the ground three times over |cFFFFFF3|r seconds, dealing Frost Damage to enemies within |cFFFFFF8|r meters.\n\nDealing damage applies Major Vulnerability to any enemy hit for |cFFFFFF12|r seconds.';
    LUIE_STRING_SKILL_FROZEN_COLOSSUS_GROUND_TP = 'Taking Frost Damage every |cFFFFFF1|r second.\n\nWhen you take damage from this effect you are afflicted with Major Vulnerability for |cFFFFFF12|r seconds.';
    LUIE_STRING_SKILL_PESTILENT_COLOSSUS_TP = 'A pestilent Flesh Colossus smashes the ground three times over |cFFFFFF3|r seconds, dealing increasing Disease Damage to enemies within |cFFFFFF8|r meters.\n\nDealing damage applies Major Vulnerability to any enemy hit for |cFFFFFF12|r seconds.';
    LUIE_STRING_SKILL_PESTILENT_COLOSSUS_GROUND_TP = 'Taking Disease Damage every |cFFFFFF1|r second.\n\nWhen you take damage from this effect you are afflicted with Major Vulnerability for |cFFFFFF12|r seconds.';
    LUIE_STRING_SKILL_GLACIAL_COLOSSUS_TP = 'A frostbitten Flesh Colossus smashes the ground three times over |cFFFFFF3|r seconds, dealing Frost Damage to enemies within |cFFFFFF8|r meters.\n\nThe final smash stuns all enemies hit for |cFFFFFF<<2>>|r seconds.\n\nDealing damage applies Major Vulnerability to any enemy hit for |cFFFFFF12|r seconds.';
    LUIE_STRING_SKILL_GLACIAL_COLOSSUS_GROUND_TP = 'Taking Frost Damage every |cFFFFFF1|r second.\n\nWhen you take damage from this effect you are afflicted with Major Vulnerability for |cFFFFFF12|r seconds.\n\nThe final hit will knock you down for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_BONE_TOTEM_TP = 'You and allies within the |cFFFFFF6|r meter radius of the totem gain Minor Protection.\n\nAfter |cFFFFFF2|r seconds, the totem begins fearing nearby enemies every |cFFFFFF2|r seconds, causing them to cower in place for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_AGONY_TOTEM_TP = 'You and allies within the |cFFFFFF6|r meter radius of the totem gain Minor Protection.\n\nAfter |cFFFFFF2|r seconds, the totem begins fearing nearby enemies every |cFFFFFF2|r seconds, causing them to cower in place for |cFFFFFF4|r seconds.\n\nAllies can activate the |cFFFFFFPure Agony|r synergy.';
    LUIE_STRING_SKILL_BONE_GOLIATH_TRANSFORMATION_TP = 'Transformed into a Bone Goliath for |cFFFFFF<<1>>|r seconds.\n\nWhile transformed, your Light Attacks and Heavy Attacks restore Health.\n\nYou cannot generate Ultimate while transformed.';
    LUIE_STRING_SKILL_PUMMELING_GOLIATH_TP = 'Transformed into a Pummeling Goliath for |cFFFFFF<<1>>|r seconds.\n\nWhile transformed, your Light Attacks and Heavy Attacks restore Health.\n\nYour bash attacks hit multiple targets in front of you and deal additional damage.\n\nYou cannot generate Ultimate while transformed.';
    LUIE_STRING_SKILL_RAVENOUS_GOLIATH_TP = 'Transformed into a Ravenous Goliath for |cFFFFFF<<1>>|r seconds.\n\nWhile transformed, your Light Attacks and Heavy Attacks restore Health.\n\nYou deal Magic Damage to nearby enemies every |cFFFFFF1|r second and heal for |cFFFFFF100|r% of the damage done.\n\nYou cannot generate Ultimate while transformed.';
    LUIE_STRING_SKILL_RAVENOUS_GOLIATH_GROUND_TP = 'Taking Magic Damage every |cFFFFFF1|r second.\n\nThe Necromancer heals for |cFFFFFF100|r% of the damage done.';
    LUIE_STRING_SKILL_RESISTANT_FLESH_TP = 'Increase Physical and Spell Resistance by |cFFFFFF50|r% of the amount healed by the last cast of Resistant Flesh for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_LIFE_AMID_DEATH_TP = 'Healing you and allies within |cFFFFFF8|r meters of the consumed corpse every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SPIRIT_MENDER_TP = 'A ghostly spirit stays by your side. The ghostly spirit remains for |cFFFFFF<<1>>|r seconds.\n\nThe spirit heals you or the lowest Health ally around you every |cFFFFFF2|r seconds.\n\nCreates a corpse on death.';
    LUIE_STRING_SKILL_SPIRIT_GUARDIAN_TP = 'A ghostly spirit stays by your side. The ghostly spirit remains for |cFFFFFF<<1>>|r seconds.\n\nThe spirit heals you or the lowest Health ally around you every |cFFFFFF2|r seconds.\n\nWhile active, |cFFFFFF10|r% of the damage you take is transferred to the spirit instead.\n\nCreates a corpse on death.';
    LUIE_STRING_SKILL_RESTORING_TETHER_TP = 'You and all allies between you and the corpse heal over |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BRAIDED_TETHER_TP = 'You, all allies within |cFFFFFF5|r meters of you, and all allies between you and the corpse heal over |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_MORTAL_COIL_TP = 'You and all allies between you and the corpse heal over |cFFFFFF<<1>>|r seconds.\n\nYou also restore |cFFFFFF1260|r Stamina over |cFFFFFF<<1>>|r seconds while siphoning the corpse.';
    LUIE_STRING_SKILL_BONE_ARMOR_TP = 'Gain Major Resolve for |cFFFFFF<<1>>|r seconds.\n\nCreates a corpse when the effect completes.';
    LUIE_STRING_SKILL_BECKONING_ARMOR_TP = 'Gain Major Resolve for |cFFFFFF<<1>>|r seconds.\n\nWhile active, enemies that strike you with ranged attacks will be pulled toward you once every |cFFFFFF3|r seconds.\n\nCreates a corpse when the effect completes.';
    LUIE_STRING_SKILL_SUMMONERS_ARMOR_TP = 'Gain Major Resolve for |cFFFFFF<<1>>|r seconds.\n\nWhile active, reduces the cost of Blastbones, Skeletal Mage, and Spirit Mender by |cFFFFFF15|r%.\n\nCreates a corpse when the effect completes.';

    ----------------------------------------------------------------
    -- WEAPON SKILLS -----------------------------------------------
    ----------------------------------------------------------------

    -- Two-Handed
    LUIE_STRING_SKILL_FOLLOW_UP_TP = 'Ваша следующая атака с прямым уроном, нанесённая в течение |cFFFFFF7|r секунд нанесёт |cFFFFFF<<1>>|r% дополнительного урона.';
    LUIE_STRING_SKILL_BATTLE_RUSH_TP = 'Увеличивает восстановление Запаса сил на |cFFFFFF<<1>>|r% в течение |cFFFFFF10|r секунд.';
    LUIE_STRING_SKILL_RALLY_TP = 'You heal when Rally ends. The final heal is increased by |cFFFFFF15|r% every |cFFFFFF1|r second, up to a maximum of |cFFFFFF300|r%.';
    LUIE_STRING_SKILL_STAMPEDE_TP = 'Enemies in the |cFFFFFF5|r meter radius of sundered ground take Physical Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_BERSERKER_STRIKE_TP = 'Увеличивает в течение |cFFFFFF<<1>>|r секунд Физическую и Магическую сопротивляемости на величину, равную проигнорированному способностью Berserker Strike сопротивлению цели.';
    LUIE_STRING_SKILL_ONSLAUGHT_TP = 'Your Direct Damage attacks ignore Physical and Spell Resistance equal to the amount of armor of the target hit by Onslaught for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BERSERKER_RAGE_TP = 'Увеличивает в течение |cFFFFFF<<1>>|r секунд Физическую и Магическую сопротивляемости на величину, равную проигнорированному способностью Berserker Rage сопротивлению цели.\n\nВы получаете иммунитет к обездвиживанию, замедлению и обезмолвливанию на время действия эффекта.';

    -- One Hand and Shield
    LUIE_STRING_SKILL_DEFENSIVE_POSTURE_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nReflect the next projectile cast at you within |cFFFFFF6|r seconds. This effect can occur once per cast.';
    LUIE_STRING_SKILL_ABSORB_MISSILE_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhile the shield persists, you are healed the next time a harmful Direct Damage projectile hits you. This effect can occur once per cast.';
    LUIE_STRING_SKILL_REVEBERATING_BASH_TP = 'Stunned for |cFFFFFF<<1>>|r seconds. After the stun ends, take Physical Damage.';
    LUIE_STRING_SKILL_RESENTMENT_TP = 'Increase the damage of your next Power Slam used within |cFFFFFF<<1>>|r seconds by |cFFFFFF5|r%.\n\nThis effect stacks up to |cFFFFFF10|r times and you gain a stack when blocking any attack.';
    LUIE_STRING_SKILL_SHIELD_WALL_TP = 'Автоматически блокирует все атаки в течение |cFFFFFF<<1>>|r секунд, не расходуя ресурсов.';
    LUIE_STRING_SKILL_SPELL_WALL_TP = 'Автоматически блокирует все атаки и отражает снаряды в течение |cFFFFFF<<1>>|r секунд, не расходуя ресурсов.';
    LUIE_STRING_SKILL_SHIELD_DISCIPLINE_TP = 'Автоматически блокирует все атаки в течение |cFFFFFF<<1>>|r секунд, не расходуя ресурсов.\n\nВаши способности из ветки Одноручного оружия и Щита расходуют на |cFFFFFF100|r% меньше ресурсов, пока активно.';

    -- Dual Wield
    LUIE_STRING_SKILL_RENDING_SLASHES_TP = 'Afflicted with Bleed Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BLOOD_CRAZE_TP = 'Подвержен Кровотечению каждые |cFFFFFF2|r секунды в течение |cFFFFFF<<1>>|r секунд.\n\nАтакуюие вас исцеляются каждые |cFFFFFF2|r секунды, пока активная способность Blood Craze.';
    LUIE_STRING_SKILL_BLOOD_CRAZE_HEAL_TP = 'Исцеляет каждые |cFFFFFF2|r секунды в течение |cFFFFFF<<1>>|r секунд, пока на вашей цели активе эффект Blood Craze.';
    LUIE_STRING_SKILL_BLADE_CLOAK_TP = 'A protective cloak of razors surrounds you, dealing Physical Damage to all enemies within |cFFFFFF5|r meters every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_LACERATE_TP = 'Afflicted with Bleed Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker heals for |cFFFFFF50|r% of the damage done.';
    LUIE_STRING_SKILL_THRIVE_IN_CHAOS_TP = 'Увеличивает наносимый урон на |cFFFFFF6|r% за каждый удар способностью Thrive in Chaos, максимум на |cFFFFFF36|r%.';
    LUIE_STRING_SKILL_FLYING_BLADE_TP = 'Your attacker can jump to you within the next |cFFFFFF<<1>>|r seconds, dealing Physical Damage and granting them Major Brutality for |cFFFFFF40|r seconds.';

    -- Bow
    LUIE_STRING_SKILL_HAWK_EYE_TP = 'Increase the damage of your Bow abilities by |cFFFFFF<<1>>|r% for |cFFFFFF5|r seconds, stacking up to |cFFFFFF5|r times.';
    LUIE_STRING_SKILL_VOLLEY_TP = 'Arrows rain down from the sky, dealing Physical Damage to enemies in the target |cFFFFFF<<1>>|r meter radius every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_POISON_INJECTION_TP = 'Afflicted with Poison Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nDeals up to |cFFFFFF100|r% more damage in proportion to your missing health under |cFFFFFF50|r%.';
    LUIE_STRING_SKILL_BALLISTA_TP = 'Your ballista turret unleashes a barrage of arrows, dealing Physical Damage over |cFFFFFF<<1>>|r seconds.';

    -- Destruction Staff
    LUIE_STRING_HEAVY_ATTACK_LIGHTNING_STAFF_TP = 'Afflicted with Shock Damage over time for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Shock Damage if the channel is finished.';
    LUIE_STRING_HEAVY_ATTACK_RESTORATION_STAFF_TP = 'Afflicted with Magic Damage over time for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Magic Damage if the channel is finished.';
    LUIE_STRING_SKILL_WOE_FIRE_TP = 'Enemies standing in the elemental barrier take Flame Damage every |cFFFFFF1|r second.\n\nBurning enemies take |cFFFFFF20|r% more damage from this ability.';
    LUIE_STRING_SKILL_WOE_FROST_TP = 'Enemies standing in the elemental barrier take Frost Damage every |cFFFFFF1|r second.\n\nChilled enemies become frozen and are immobilized for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_WOE_SHOCK_TP = 'Enemies standing in the elemental barrier take Shock Damage every |cFFFFFF1|r second.\n\nConcussed enemies are set Off Balance for |cFFFFFF7|r seconds.';
    LUIE_STRING_SKILL_UWOE_FIRE_TP = 'Enemies standing in the elemental barrier take Flame Damage every |cFFFFFF1|r second.\n\nBurning enemies take |cFFFFFF20|r% more damage from this ability.\n\nThe barrier explodes when it expires, dealing additional Flame Damage.';
    LUIE_STRING_SKILL_UWOE_FROST_TP = 'Enemies standing in the elemental barrier take Frost Damage every |cFFFFFF1|r second.\n\nChilled enemies become frozen and are immobilized for |cFFFFFF4|r seconds.\n\nThe barrier explodes when it expires, dealing additional Frost Damage and applying Unstable Frost Shield to you and allies within |cFFFFFF18|r meters for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_UWOE_SHOCK_TP = 'Enemies standing in the elemental barrier take Shock Damage every |cFFFFFF1|r second.\n\nConcussed enemies are set Off Balance for |cFFFFFF7|r seconds.\n\nThe barrier explodes when it expires, dealing additional Shock Damage.';
    LUIE_STRING_SKILL_ELEMENTAL_STORM_TP = 'A cataclysmic storm builds for |cFFFFFF2|r seconds then lays waste to all enemies in the target |cFFFFFF8|r meter area, dealing <<1>> Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_ICY_RAGE_TP = 'A cataclysmic storm builds for |cFFFFFF2|r seconds then lays waste to all enemies in the target |cFFFFFF8|r meter area, dealing Frost Damage every |cFFFFFF1|r second.\n\nImmobilizes enemies hit for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_EYE_OF_THE_STORM_TP = 'A cataclysmic storm builds around you for |cFFFFFF2|r seconds then lays waste to all enemies within |cFFFFFF8|r meters, dealing <<1>> Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_WALL_OF_ELEMENTS_GROUND_FIRE = 'Taking Flame Damage every |cFFFFFF1|r second.\n\nIf you are Burning, take |cFFFFFF20|r% more damage from this ability.';
    LUIE_STRING_SKILL_WALL_OF_ELEMENTS_GROUND_FROST = 'Taking Frost Damage every |cFFFFFF1|r second.\n\nIf you are Chilled you will be immobilized for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_WALL_OF_ELEMENTS_GROUND_SHOCK = 'Taking Shock Damage every |cFFFFFF1|r second.\n\nIf you are Concussed you will be set Off Balance for |cFFFFFF7|r seconds.';
    LUIE_STRING_SKILL_U_WALL_OF_ELEMENTS_GROUND_FIRE = 'Taking Flame Damage every |cFFFFFF1|r second.\n\nIf you are Burning, take |cFFFFFF20|r% more damage from this ability.\n\nThe wall explodes when it expires, dealing additional Flame Damage.';
    LUIE_STRING_SKILL_U_WALL_OF_ELEMENTS_GROUND_FROST = 'Taking Frost Damage every |cFFFFFF1|r second.\n\nIf you are Chilled you will be immobilized for |cFFFFFF4|r seconds.\n\nThe wall explodes when it expires, dealing additional Frost Damage.';
    LUIE_STRING_SKILL_U_WALL_OF_ELEMENTS_GROUND_SHOCK = 'Taking Shock Damage every |cFFFFFF1|r second.\n\nIf you are Concussed you will be set Off Balance for |cFFFFFF7|r seconds.\n\nThe wall explodes when it expires, dealing additional Shock Damage.';
    LUIE_STRING_SKILL_WOE_FROST_SHIELD_TP = 'Absorbing damage taken from projectiles for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    -- Restoration Staff
    LUIE_STRING_SKILL_GRAND_HEALING = 'Healing you and allies in the |cFFFFFF<<2>>|r meter area every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_HEALING_SPRINGS = 'Healing you and allies in the |cFFFFFF<<2>>|r meter area every |cFFFFFF1|r second.\n\nYou restore |cFFFFFF30|r Magicka every time you or an ally is healed.';
    LUIE_STRING_SKILL_BLESSING_OF_RESTORATION = 'Blessing of Restoration';
    LUIE_STRING_SKILL_HEALING_WARD = "Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhile the shield persists, heal for |cFFFFFF33|r% of the shield's remaining strength every |cFFFFFF1|r second.";
    LUIE_STRING_SKILL_LIGHTS_CHAMPION = 'Healing every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nGain Major Force for |cFFFFFF8|r seconds each time this effect heals.';

    ----------------------------------------------------------------
    -- ARMOR SKILLS ------------------------------------------------
    ----------------------------------------------------------------

    -- Light Armor
    LUIE_STRING_SKILL_HARNESS_MAGICKA = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhile active, whenever the shield absorbs damage, you restore Magicka. This effect can occur up to |cFFFFFF3|r times.';

    -- Medium Armor
    LUIE_STRING_SKILL_MEDIUM_ARMOR_EVASION = 'Reduce damage taken from area of effect attacks by |cFFFFFF<<1>>|r% for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_ELUDE = 'When you take damage from a direct area of effect attack, you gain Major Expedition for |cFFFFFF1|r second per piece of Medium Armor worn.';

    -- Heavy Armor
    LUIE_STRING_SKILL_UNSTOPPABLE = 'Movement Speed reduced by |cFFFFFF65|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_UNSTOPPABLE_BRUTE = 'Decrease the cost of Break Free by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r seconds.\n\nMovement Speed reduced by |cFFFFFF65|r% for the duration.';
    LUIE_STRING_SKILL_IMMOVABLE = 'Increase the amount of damage you block by |cFFFFFF<<2>>|r% for |cFFFFFF<<1>>|r seconds.\n\nMovement Speed reduced by |cFFFFFF<<3>>|r% for the duration.';

    ----------------------------------------------------------------
    -- WORLD SKILLS ------------------------------------------------
    ----------------------------------------------------------------

    -- Soul Magic
    LUIE_STRING_SKILL_SOUL_SUMMONS_TP = 'You have recently revived without spending a soul gem and may not do so again.';
    LUIE_STRING_SKILL_SOUL_TRAP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker fills a soul gem if you die under this effect.';
    LUIE_STRING_SKILL_CONSUMING_TRAP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker fills a soul gem and restores Health, Magicka, and Stamina if you die under this effect.';

    -- Werewolf
    LUIE_STRING_SKILL_SANIES_LUPINUS_TP = 'Вы были укушены Оборотнем и заразились Гнойным люпинусом.';
    LUIE_STRING_SKILL_LYCANTHROPHY_TP = 'Вы можете обратиться в дикого Оборотня.\n\nВы получаете на |cFFFFFF25|r% больше урона от Яда, пока находитесь в форме Вервольфа.';
    LUIE_STRING_SKILL_BLOOD_MOON_TP = 'Вы укусили другого игрока. Вы не сможете сделать этого снова в течение |cFFFFFF7|r дней.'; -- TODO: Check Translation
    LUIE_STRING_SKILL_CLAWS_OF_LIFE_TP = 'Afflicted with Disease Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nThe werewolf heals for |cFFFFFF100|r% of the damage done.';
    LUIE_STRING_SKILL_WEREWOLF_TRANSFORMATION_TP = 'Transformed into a werewolf.\n\nWhile transformed your Max Stamina is increased by |cFFFFFF30|r%.\n\nYou cannot generate Ultimate while transformed.';
    LUIE_STRING_SKILL_WEREWOLF_BERSERKER_TP = 'Transformed into a werewolf.\n\nWhile transformed, your Light Attacks apply a bleed over |cFFFFFF4|r seconds, your Heavy Attacks deal |cFFFFFF50|r% splash damage, and your Max Stamina is increased by |cFFFFFF30|r%.\n\nYou cannot generate Ultimate while transformed.';
    LUIE_STRING_SKILL_PACK_LEADER_TP = 'Transformed into a werewolf.\n\nWhile transformed your Max Stamina is increased by |cFFFFFF30|r%, you take |cFFFFFF10|r% less damage, and you summon two direwolves. You also grant yourself and nearby allies Minor Courage.\n\nYou cannot generate Ultimate while transformed.';
    LUIE_STRING_SKILL_CARNAGE_PROC_TP = 'For |cFFFFFF<<1>>|r seconds you can cast <<2>>.';
    LUIE_STRING_SKILL_CARNAGE_TP = 'Afflicted with Bleed Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nDeals up to |cFFFFFF450|r% more damage in proportion to your missing health under |cFFFFFF100|r%.';
    LUIE_STRING_SKILL_FERAL_CARNAGE_TP = 'Afflicted with Bleed Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nDeals up to |cFFFFFF450|r% more damage in proportion to your missing health under |cFFFFFF100|r%.\n\nEach time this effect deals damage the werewolf restores |cFFFFFF100|r Stamina.';
    LUIE_STRING_SKILL_BRUTAL_CARNAGE_BUFF_TP = 'Increase Weapon Damage by |cFFFFFF100|r for |cFFFFFF10|r seconds, stacking up to |cFFFFFF6|r times for each enemy hit by Brutal Carnage.';
    LUIE_STRING_SKILL_HIRCINES_FORTITUDE_TP = "Gain Health and Stamina Recovery equal to |cFFFFFF5|r% of the amount you healed with Hircine's Fortitude, up to a maximum of |cFFFFFF333|r, for |cFFFFFF<<1>>|r seconds.";
    LUIE_STRING_SKILL_FEROCIOUS_ROAR_TP = 'Increase Heavy Attack casting speed by |cFFFFFF33|r% for |cFFFFFF<<1>>|r seconds.';

    -- Vampire
    LUIE_STRING_SKILL_NOXIPHILIC_SANGUIVORIA_TP = 'You have been bitten by a Vampire and contracted Noxiphilic Sanguivoria.';
    LUIE_STRING_SKILL_VAMPIRISM = 'Vampirism';
    LUIE_STRING_SKILL_VAMPIRISM_STAGE1_TP = 'You are slightly corrupted from the influence of Vampirism.\n\n• Health Recovery: -|cFFFFFF10|r%\n• Flame Damage Taken: +|cFFFFFF5|r%\n• Regular Ability Costs: +|cFFFFFF3|r%\n• Vampire Ability Costs: -|cFFFFFF6|r%';
    LUIE_STRING_SKILL_VAMPIRISM_STAGE2_TP = 'You are moderately corrupted from the influence of Vampirism.\n\n• Health Recovery: -|cFFFFFF30|r%\n• Flame Damage Taken: +|cFFFFFF8|r%\n• Regular Ability Costs: +|cFFFFFF5|r%\n• Vampire Ability Costs: -|cFFFFFF10|r%';
    LUIE_STRING_SKILL_VAMPIRISM_STAGE3_TP = 'You are heavily corrupted from the influence of Vampirism.\n\n• Health Recovery: -|cFFFFFF60|r%\n• Flame Damage Taken: +|cFFFFFF13|r%\n• Regular Ability Costs: +|cFFFFFF8|r%\n• Vampire Ability Costs: -|cFFFFFF16|r%';
    LUIE_STRING_SKILL_VAMPIRISM_STAGE4_TP = 'You are completely corrupted from the influence of Vampirism.\n\n• Health Recovery: -|cFFFFFF100|r%\n• Flame Damage Taken: +|cFFFFFF20|r%\n• Regular Ability Costs: +|cFFFFFF12|r%\n• Vampire Ability Costs: -|cFFFFFF24|r%';
    LUIE_STRING_SKILL_VAMPIRISM_STAGE5_TP = 'You are completely corrupted from the influence of Vampirism.\n\n• Health Recovery: -|cFFFFFF0|r%\n• Flame Damage Taken: +|cFFFFFF0|r%\n• Regular Ability Costs: +|cFFFFFF0|r%\n• Vampire Ability Costs: -|cFFFFFF24|r%';
    LUIE_STRING_SKILL_BLOOD_RITUAL_TP = 'You have fed on another player. You may not do so again for |cFFFFFF7|r days.';
    LUIE_STRING_SKILL_UNNATURAL_MOVEMENT_TP = 'You are invisible as long as you continue sprinting.';
    LUIE_STRING_SKILL_BLOOD_FOR_BLOOD_TP = 'You cannot be healed by allies for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_BLOOD_FRENZY_TP = 'Increase Weapon and Spell Damage by |cFFFFFF630|r while draining Health every |cFFFFFF1|r second.\n\nWhile toggled on, the Health cost of this ability increases by |cFFFFFF20|r% every second and you cannot be healed by anyone other than yourself.';
    LUIE_STRING_SKILL_SIMMERING_FRENZY_TP = 'Increase Weapon and Spell Damage by |cFFFFFF660|r while draining Health every |cFFFFFF1|r second.\n\nWhile toggled on, the Health cost of this ability increases by |cFFFFFF20|r% and the Weapon and Spell Damage bonus increases by |cFFFFFF10|r% every second. You also cannot be healed by anyone other than yourself.';
    LUIE_STRING_SKILL_SATED_FURY_TP = 'Increase Weapon and Spell Damage by |cFFFFFF660|r while draining Health every |cFFFFFF1|r second.\n\nWhile toggled on, the Health cost of this ability increases by |cFFFFFF20|r% every second and you cannot be healed by anyone other than yourself.\n\nWhen you toggle this ability off, you heal for |cFFFFFF33|r% of the total Health cost you spent while it was toggled on.';
    LUIE_STRING_SKILL_VAMPIRIC_DRAIN_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach time this effect deals damage it heals the vampire for |cFFFFFF23|r% of their missing Health.';
    LUIE_STRING_SKILL_DRAIN_VIGOR_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach time this effect deals damage it heals the vampire for |cFFFFFF23|r% of their missing Health and restores |cFFFFFF5|r% of their missing Stamina.';
    LUIE_STRING_SKILL_EXHILARATING_DRAIN_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach time this effect deals damage it heals the vampire for |cFFFFFF23|r% of their missing Health and grants them |cFFFFFF4|r% Ultimate.';
    LUIE_STRING_SKILL_STUPEFY_TP = 'Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen this effect ends your Movement Speed will be reduced by |cFFFFFF53|r% for |cFFFFFF5|r seconds.';
    LUIE_STRING_SKILL_MIST_FORM_TP = 'Reduce damage taken by |cFFFFFF75|r% as long as you maintain the channel.\n\nImmune to all disabling and immobilization effects, but you cannot be healed and your Magicka Recovery is disabled.';
    LUIE_STRING_SKILL_BLOOD_MIST_TP = 'Reduce damage taken by |cFFFFFF75|r% as long as you maintain the channel.\n\nWhile in this form you deal Magic Damage every |cFFFFFF1|r second to enemies within |cFFFFFF5|r meters and heal for the damage caused.\n\nImmune to all disabling and immobilization effects, but you cannot be healed and your Magicka Recovery is disabled.';
    LUIE_STRING_SKILL_BLOOD_SCION_TP = 'Transformed into a monstrous creature of the night for |cFFFFFF<<1>>|r seconds, increasing your Max Health, Magicka, and Stamina by |cFFFFFF10000|r.\n\nWhile transformed you heal for |cFFFFFF15|r% of all damage you deal and can see enemies through walls.\n\nYou cannot generate Ultimate while transformed.';
    LUIE_STRING_SKILL_SWARMING_SCION_TP = 'Transformed into a monstrous creature of the night for |cFFFFFF<<1>>|r seconds, increasing your Max Health, Magicka, and Stamina by |cFFFFFF10000|r.\n\nWhile transformed you heal for |cFFFFFF15|r% of all damage you deal and can see enemies through walls.\n\nBats also swarm around you and shred enemies within |cFFFFFF10|r meters, dealing Magic Damage every |cFFFFFF1|r second.\n\nYou cannot generate Ultimate while transformed.';
    LUIE_STRING_SKILL_PROFANE_SYMBOL = 'Profane Symbol';

    ----------------------------------------------------------------
    -- GUILD SKILLS ------------------------------------------------
    ----------------------------------------------------------------

    -- Fighters Guild
    LUIE_STRING_SKILL_CIRCLE_OF_PROTECTION_TP = 'You and allies in the |cFFFFFF5|r meter radius of the rune gain Minor Protection and Minor Endurance.';
    LUIE_STRING_SKILL_RING_OF_PRESERVATION_TP = 'You and allies in the |cFFFFFF5|r meter radius of the rune gain Minor Protection and Minor Endurance and are healed every |cFFFFFF0.5|r seconds.';
    LUIE_STRING_SKILL_EXPERT_HUNTER_TP = 'Revealing stealthed and invisible enemies within |cFFFFFF6|r meters for |cFFFFFF<<1>>|r seconds.\n\nExposed enemies cannot return to stealth or invisibility for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_EVIL_HUNTER_TP = 'Revealing stealthed and invisible enemies within |cFFFFFF6|r meters for |cFFFFFF<<1>>|r seconds.\n\nExposed enemies cannot return to stealth or invisibility for |cFFFFFF3|r seconds.\n\nWhile active, increases the damage of your Stamina costing Fighters Guild abilities by |cFFFFFF25|r%.';
    LUIE_STRING_SKILL_TRAP_BEAST_TP = 'Triggers when an enemy comes within |cFFFFFF2.5|r meters of the trap, dealing Physical Damage and additional Physical Damage over |cFFFFFF10|r seconds, granting you Minor Force for the duration.\n\nEnemies who activate the trap are immobilized for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_TRAP_BEAST_DEBUFF_TP = 'Afflicted with Physical Damage every |cFFFFFF2|r seconds for |cFFFFFF10|r seconds and immobilized for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_BARBED_TRAP_TP = 'Triggers when an enemy comes within |cFFFFFF2.5|r meters of the trap, dealing Physical Damage and additional Physical Damage over |cFFFFFF18|r seconds, granting you Minor Force for the duration.\n\nEnemies who activate the trap are immobilized for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_BARBED_TRAP_DEBUFF_TP = 'Afflicted with Physical Damage every |cFFFFFF2|r seconds for |cFFFFFF18|r seconds and immobilized for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_FLAWLESS_DAWNBREAKER_TP = 'Increase Weapon Damage by |cFFFFFF300|r for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DAWNBREAKER_OF_SMITING_TP = 'Afflicted with Physical Damage every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.\n\nStunned for |cFFFFFF2|r seconds.';

    -- Mages Guild
    LUIE_STRING_SKILL_RADIANT_MAGELIGHT_TP = 'Revealing stealthed and invisible enemies within |cFFFFFF12|r meters for |cFFFFFF<<1>>|r seconds.\n\nExposed enemies cannot return to stealth or invisibility for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_STRUCTURED_ENTROPY_TP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker heals every |cFFFFFF2|r seconds while Structured Entropy remains active.';
    LUIE_STRING_SKILL_FIRE_RUNE_TP = 'When triggered, the rune blasts all enemies in the target |cFFFFFF3|r meter area for Flame Damage.';
    LUIE_STRING_SKILL_VOLCANIC_RUNE_TP = 'When triggered, the rune blasts all enemies in the target |cFFFFFF3|r meter area for Flame Damage, knocks them into the air, and stuns them for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_SCALDING_RUNE_TP = 'When triggered, the rune blasts all enemies in the target |cFFFFFF3|r meter area for Flame Damage and afflicts them with additional Flame Damage over |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_EQUILIBRIUM_TP = 'Reduce healing done and damage shield strength by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SPELL_SYMMETRY_TP = 'Reduce the cost of your next Magicka ability used within |cFFFFFF<<1>>|r seconds by |cFFFFFF33|r%.';
    LUIE_STRING_SKILL_METEOR_TP = 'Enemies in the |cFFFFFF5|r meter impact area take Flame Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_ICE_COMET_TP = 'Enemies in the |cFFFFFF5|r meter impact area take Frost Damage every |cFFFFFF1|r second.';

    -- Psijic Order
    LUIE_STRING_SKILL_SPELL_ORB_TP = 'When you cast a Psijic Order ability while you are in combat, you generate a spell charge.\n\nWhen you reach |cFFFFFF5|r spell charges, you launch a spell orb at the closest enemy to you dealing Magic Damage or Physical Damage, whichever is higher.';
    LUIE_STRING_SKILL_CONCENTRATED_BARRIER_TP = 'Absorbing damage while Bracing.\n\nThis damage shield recharges back to full strength after you spend |cFFFFFF10|r seconds not Bracing.';
    LUIE_STRING_SKILL_TIME_STOP_TP = 'Gradually being slowed over time for |cFFFFFF2|r seconds.\n\nIf you are still in the area of effect at end of this duration you will be stunned for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_TIME_BORROWED_TIME_TP = 'Gradually being slowed over time for |cFFFFFF2|r seconds.\n\nIf you are still in the area of effect at end of this duration you will be stunned and have the next |cFFFFFF5000|r points of healing negated for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_TIME_BORROWED_TIME_STUN_TP = 'Negating the next |cFFFFFF5000|r points of healing for |cFFFFFF<<1>>|r seconds.\n\nStunned for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_TIME_FREEZE_TP = 'Gradually being slowed over time for |cFFFFFF4|r seconds.\n\nIf you are still in the area of effect at end of this duration you will be stunned for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_TIME_FREEZE_GROUND_TP = 'Gradually reducing the Movement Speed of enemies within the |cFFFFFF8|r meter radius of the target location.\n\nAt the end of the duration, enemies are stunned for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_IMBUE_WEAPON_TP = 'Your next Light Attack used within |cFFFFFF2|r seconds deals additional Physical Damage.\n\nIf the power is not consumed in time, you restore |cFFFFFF60|r% of the cost in Stamina.';
    LUIE_STRING_SKILL_ELEMENTAL_WEAPON_TP = 'Your next Light Attack used within |cFFFFFF2|r seconds deals additional Magic Damage and applies the Burning, Concussion, or Chill elemental status effect.\n\nIf the power is not consumed in time, you restore |cFFFFFF60|r% of the cost in Magicka.';
    LUIE_STRING_SKILL_CRUSHING_WEAPON_TP = 'Your next Light Attack used within |cFFFFFF2|r seconds deals additional Physical Damage and heals you for |cFFFFFF28|r% of the damage done.\n\nIf the power is not consumed in time, you restore |cFFFFFF60|r% of the cost in Stamina.';
    LUIE_STRING_SKILL_MEND_WOUNDS_TP = 'Your Light and Heavy attacks are replaced with healing abilities that can only be used on allies.\n\nYour Light Attack launches a restorative sphere at your ally, instantly healing them.\n\nYour Heavy Attack heals every |cFFFFFF1|r second and restores Magicka to you while channeling.';
    LUIE_STRING_SKILL_MEND_SPIRIT_TP = 'Your Light and Heavy attacks are replaced with healing abilities that can only be used on allies.\n\nYour Light Attack launches a restorative sphere at your ally, instantly healing them.\n\nYour Heavy Attack heals every |cFFFFFF1|r second and restores Magicka to you while channeling.\n\nAfter you heal an ally you grant them Major Resolve for |cFFFFFF5|r seconds.';
    LUIE_STRING_SKILL_SYMBIOSIS_TP = 'Your Light and Heavy attacks are replaced with healing abilities that can only be used on allies.\n\nYour Light Attack launches a restorative sphere at your ally, instantly healing them.\n\nYour Heavy Attack heals every |cFFFFFF1|r second and restores Magicka to you while channeling.\n\nYou heal yourself for |cFFFFFF50|r% of the amount of healing done to the ally.';
    LUIE_STRING_SKILL_MEDITATE_TP = 'Healing and restoring Magicka and Stamina every |cFFFFFF1|r second.\n\nYou will remain in a meditative state until you toggle this ability off or are interrupted.';
    LUIE_STRING_SKILL_INTROSPECTION_TP = 'Healing and restoring Magicka and Stamina every |cFFFFFF1|r second.\n\nMaintaining the channel increases the Health restored by |cFFFFFF10|r% every tick, up to a maximum of |cFFFFFF50|r%.\n\nYou will remain in a meditative state until you toggle this ability off or are interrupted.';

    -- Undaunted
    LUIE_STRING_SKILL_BLOOD_ALTAR_TP = 'Enemies within |cFFFFFF28|r meters of the Altar are afflicted with Minor Lifesteal.\n\nAllies in the area can activate the |cFFFFFFBlood Funnel|r synergy.';
    LUIE_STRING_SKILL_OVERFLOWING_ALTAR_TP = 'Enemies within |cFFFFFF28|r meters of the Altar are afflicted with Minor Lifesteal.\n\nAllies in the area can activate the |cFFFFFFBlood Feast|r synergy.';
    LUIE_STRING_SKILL_TRAPPING_WEBS_TP = 'Enemies caught in the |cFFFFFF4|r meter radius of webs are snared, reducing their Movement Speed by |cFFFFFF50|r%.\n\nAfter |cFFFFFF10|r seconds the webs explode, dealing Poison Damage to enemies within.\n\nA ranged ally targeting an enemy in the webs can activate the |cFFFFFFSpawn Broodling|r synergy.';
    LUIE_STRING_SKILL_SHADOW_SILK_TP = 'Enemies caught in the |cFFFFFF4|r meter radius of webs are snared, reducing their Movement Speed by |cFFFFFF50|r%.\n\nAfter |cFFFFFF10|r seconds the webs explode, dealing Poison Damage to enemies within.\n\nA ranged ally targeting an enemy in the webs can activate the |cFFFFFFBlack Widow|r synergy.';
    LUIE_STRING_SKILL_TANGLING_WEBS_TP = 'Enemies caught in the |cFFFFFF4|r meter radius of webs are snared, reducing their Movement Speed by |cFFFFFF50|r%.\n\nAfter |cFFFFFF10|r seconds the webs explode, dealing Poison Damage to enemies within.\n\nA ranged ally targeting an enemy in the webs can activate the |cFFFFFFArachnophobia|r synergy.';
    LUIE_STRING_SKILL_TRAPPING_WEBS_SNARE_TP = 'Movement Speed reduced by |cFFFFFF50|r%.\n\nAfter |cFFFFFF10|r seconds the webs explode, dealing Poison damage.';
    LUIE_STRING_SKILL_RADIATE_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends, you and nearby allies take additional Magic Damage.';
    LUIE_STRING_SKILL_SPAWN_BROODLING_TP = 'Attacking nearby enemies. The spider remains for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BONE_SHIELD_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nAn ally near you can activate the |cFFFFFFBone Wall|r synergy.';
    LUIE_STRING_SKILL_SPIKED_BONE_SHIELD_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>> and returning |cFFFFFF138|r% of direct damage absorbed back to the enemy.\n\nAn ally near you can activate the |cFFFFFFBone Wall|r synergy.';
    LUIE_STRING_SKILL_BONE_SURGE_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nAn ally near you can activate the |cFFFFFFSpinal Surge|r synergy.';
    LUIE_STRING_SKILL_INNER_BEAST_TP = 'Your attacker deals |cFFFFFF5|r% more damage to you for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_NECROTIC_ORB_TP = 'A globe of annihilation slowly floats forward, dealing Magic Damage to enemies within |cFFFFFF8|r meters every |cFFFFFF1|r second.\n\nAn ally near the globe can activate the |cFFFFFFCombustion|r synergy.';
    LUIE_STRING_SKILL_ENERGY_ORB_TP = 'A globe of regeneration slowly floats forward, healing you and nearby allies within |cFFFFFF8|r meters every |cFFFFFF1|r second.\n\nAn ally near the globe can activate the |cFFFFFFHealing Combustion|r synergy.';

    ----------------------------------------------------------------
    -- AVA SKILLS --------------------------------------------------
    ----------------------------------------------------------------

    -- Assault
    LUIE_STRING_SKILL_CONTINUOUS_ATTACK_RANK_1_TP = 'Increase Weapon and Spell Damage by |cFFFFFF5|r% and Magicka and Stamina Recovery by |cFFFFFF10|r% for |cFFFFFF10|r minutes.';
    LUIE_STRING_SKILL_CONTINUOUS_ATTACK_RANK_2_TP = 'Increase Weapon and Spell Damage by |cFFFFFF10|r% and Magicka and Stamina Recovery by |cFFFFFF20|r% for |cFFFFFF10|r minutes.';
    LUIE_STRING_SKILL_RETREATING_MANEUEVER_TP = 'Attacks from behind deal |cFFFFFF15|r% less damage.';
    LUIE_STRING_SKILL_CALTROPS_TP = 'Enemies standing in the |cFFFFFF8|r meter radius of the caltrops take Physical Damage every |cFFFFFF1|r second and have their Movement Speed reduced by |cFFFFFF50|r%.';
    LUIE_STRING_SKILL_RAZOR_CALTROPS_TP = 'Enemies standing in the |cFFFFFF8|r meter radius of the caltrops take Physical Damage every |cFFFFFF1|r second and have their Movement Speed reduced by |cFFFFFF50|r%.\n\nThe caltrops apply Major Breach to any enemy damaged for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_RAZOR_CALTROPS_DEBUFF_TP = 'Taking Physical Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF50|r%.\n\nTaking damage from the caltrops afflicts you with Major Breach for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_ANTI_CAVALRY_CALTROPS_TP = 'Enemies standing in the |cFFFFFF8|r meter radius of the caltrops take Physical Damage every |cFFFFFF1|r second and have their Movement Speed reduced by |cFFFFFF50|r%.\n\nThe caltrops rapidly drain the Mount Stamina of any enemy in the area.';
    LUIE_STRING_SKILL_ANTI_CAVALRY_CALTROPS_DEBUFF_TP = 'Taking Physical Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF50|r%.\n\nThe caltrops rapidly drain Mount Stamina.';
    LUIE_STRING_SKILL_MAGICKA_DETONATION_TP = "Cursed with a magical bomb that explodes after |cFFFFFF<<1>>|r seconds, dealing Magic Damage to you and any allies within |cFFFFFF8|r meters.\n\nEach ally within the bomb's radius increases the damage by |cFFFFFF25|r%.";
    LUIE_STRING_SKILL_INEVITABLE_DETONATION_TP = "Cursed with a magical bomb that explodes after |cFFFFFF<<1>>|r seconds, dealing Magic Damage to you and any allies within |cFFFFFF8|r meters.\n\nIf the bomb is dispelled or removed early, the explosion is triggered immediately.\n\nEach ally within the bomb's radius increases the damage by |cFFFFFF25|r%.";
    LUIE_STRING_SKILL_PROXIMITY_DETONATION_TP = "Charging a magical bomb that explodes after |cFFFFFF<<1>>|r seconds, dealing Magic Damage to all enemies within |cFFFFFF8|r meters.\n\nEach enemy within the bomb's radius increases the damage by |cFFFFFF25|r%.";
    LUIE_STRING_SKILL_WAR_HORN_TP = 'Increase Max Stamina and Magicka by |cFFFFFF10|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_WAR_HORN_DUMMY_TP = 'Increase Max Stamina and Magicka by |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_STURDY_HORN_TP = 'Increase Max Stamina and Magicka by |cFFFFFF10|r% for |cFFFFFF30|r seconds.\n\nIncrease Critical Resistance by |cFFFFFF1320|r for |cFFFFFF10|r seconds.';

    -- Support
    LUIE_STRING_SKILL_SIEGE_SHIELD_TP = 'Reduce damage taken from siege weapons by |cFFFFFF50|r%.';
    LUIE_STRING_SKILL_SIEGE_SHIELD_GROUND_TP = 'A protective sphere guards you and allies, reducing damage taken from siege weapons while in the |cFFFFFF10|r meter radius of the bubble by |cFFFFFF50|r%.';
    LUIE_STRING_SKILL_SIEGE_WEAPON_SHIELD_TP = 'Reduce damage taken from siege weapons by |cFFFFFF50|r%.\n\nYour siege weapons take |cFFFFFF75|r% reduced damage from enemy siege weapons.';
    LUIE_STRING_SKILL_SIEGE_WEAPON_SHIELD_GROUND_TP = "A protective sphere guards you and allies, reducing damage taken from siege weapons while in the |cFFFFFF10|r meter radius of the bubble by |cFFFFFF50|r%.\n\nyou and allies' siege weapons in the bubble take |cFFFFFF75|r% reduced damage from enemy siege weapons.";
    LUIE_STRING_SKILL_PROPELLING_SHIELD_TP = 'Reduce damage taken from siege weapons by |cFFFFFF50|r% and increase the range of abilities with a range greater than |cFFFFFF20|r meters by |cFFFFFF7|r meters.\n\nDoes not effect Leap, Move Position, and Pull abilities.';
    LUIE_STRING_SKILL_PROPELLING_SHIELD_GROUND_TP = "A protective sphere guards you and allies, reducing damage taken from siege weapons while in the |cFFFFFF10|r meter radius of the bubble by |cFFFFFF50|r%.\n\nIncrease the range of you and allies' abilities with a range greater than |cFFFFFF20|r meters by |cFFFFFF7|r meters in the bubble.\n\nDoes not effect Leap, Move Position, and Pull abilities.";
    LUIE_STRING_SKILL_GUARD_SELF_TP = 'While the lifebond holds, |cFFFFFF30|r% of the damage your ally takes is redistributed to you.';
    LUIE_STRING_SKILL_GUARD_OTHER_TP = 'While the lifebond holds, |cFFFFFF30|r% of the damage you take is redistributed to your ally.';
    LUIE_STRING_SKILL_REVEALING_FLARE_TP = 'Stealthed and invisible enemies in the |cFFFFFF10|r meter radius of the flare are revealed.\n\nExposed enemies cannot return to stealth or invisibility for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_BLINDING_FLARE_TP = 'Stealthed and invisible enemies in the |cFFFFFF10|r meter radius of the flare are revealed.\n\nExposed enemies are stunned for |cFFFFFF4|r seconds, and cannot return to stealth or invisiblity for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_REPLENISHING_BARRIER_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen the ward dissolves, the caster restores |cFFFFFF4|r Ultimate and |cFFFFFF1000|r Magicka.';

    ----------------------------------------------------------------
    -- CYRODIIL ----------------------------------------------------
    ----------------------------------------------------------------

    LUIE_STRING_SKILL_AVA_SANCTUARY_TP = 'While in a Sanctuary, you cannot attack other players and other players cannot attack you.';
    LUIE_STRING_SKILL_STOW_SIEGE_WEAPON = 'Stow Siege Weapon';
    LUIE_STRING_SKILL_DEPLOY = 'Deploy';
    LUIE_STRING_SKILL_PACT = 'Pact';
    LUIE_STRING_SKILL_COVENANT = 'Covenant';
    LUIE_STRING_SKILL_DOMINION = 'Dominion';
    LUIE_STRING_SKILL_LIGHTNING_BALLISTA = 'Lightning Ballista';
    LUIE_STRING_SKILL_LIGHTNING_BALLISTA_BOLT_TP = 'Afflicted with Shock Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds. Each tick drains |cFFFFFF10|r% of your Max Magicka.';
    LUIE_STRING_SKILL_MEATBAG_CATAPULT_GROUND_TP = 'Enemies in the area take Disease Damage every |cFFFFFF1|r second and suffer |cFFFFFF50|r% reduced healing received for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_OIL_CATAPULT_GROUND_TP = 'Enemies in the oil are snared, reducing their Movement Speed by |cFFFFFF50|r% for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_SCATTERSHOT_CATAPULT_GROUND_TP = 'Enemies in the area take Physical Damage every |cFFFFFF1|r second and take |cFFFFFF25|r% more damage from all sources for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_COLD_STONE_TREBUCHET = 'Cold Stone Trebuchet';
    LUIE_STRING_SKILL_COLD_FIRE_TREBUCHET = 'Cold Fire Trebuchet';
    LUIE_STRING_SKILL_COLD_FIRE_BALLISTA = 'Cold Fire Ballista';
    LUIE_STRING_SKILL_GUARD_DETECTION = 'Vigilance';
    LUIE_STRING_SKILL_GUARD_DETECTION_TP = 'Guards are particularly vigilant and can see nearby players that are hiding in stealth.';
    LUIE_STRING_SKILL_BLESSING_OF_WAR_TP = 'Increase Alliance Points earned by |cFFFFFF20|r% for |cFFFFFF1|r hour.\n\nOnly active while in Cyrodiil or Cyrodiil delves.';
    LUIE_STRING_SKILL_HOME_KEEP_BONUS_TP = 'Increase Alliance Points, Experience Points, and Gold earned by |cFFFFFF5|r%.';
    LUIE_STRING_SKILL_ENEMY_KEEP_BONUS_TP = 'Increase Alliance Points, Experience Points, and Gold earned by |cFFFFFF<<1>>|r%.\nIncrease Weapon and Spell Critical by |cFFFFFF<<2>>|r%.';
    LUIE_STRING_SKILL_EDGE_KEEP_BONUS = 'Edge Keep Bonus';
    LUIE_STRING_SKILL_EDGE_KEEP_BONUS_TP = 'Increase Alliance Points earned by |cFFFFFF<<1>>|r%.';
    LUIE_STRING_SKILL_DEFENSIVE_SCROLL_BONUS_TP = 'Increase Physical and Spell Resistance by |cFFFFFF<<1>>|r%.';
    LUIE_STRING_SKILL_OFFENSIVE_SCROLL_BONUS_TP = 'Increase Weapon and Spell Damage by |cFFFFFF<<1>>|r%.';
    LUIE_STRING_SKILL_EMPERORSHIP_ALLIANCE_BONUS_TP = 'Increase Max Health based on the amount of Home Keeps owned.\n\nCurrect Bonus: |cFFFFFF<<1>>|r';
    LUIE_STRING_SKILL_RAZOR_ARMOR_TP = 'Reduce damage taken by |cFFFFFF30|r% for |cFFFFFF<<1>>|r seconds.\n\nWhile active the armor returns Physical Damage to attackers.';
    LUIE_STRING_SKILL_UNSTABLE_CORE_CYRODIIL_TP = 'Your single target ranged abilities are reflected back on you for |cFFFFFF<<1>>|r seconds.\n\nThe core explodes when this effect ends, dealing Magic Damage.';
    LUIE_STRING_SKILL_SHATTERING_PRISON_CYRODIIL_TP = 'Disoriented for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThe prison shatters when this effect ends, dealing Magic Damage.';
    LUIE_STRING_SKILL_SIEGE_SHIELD_CYRODIIL_TP = 'Negate damage taken from Siege Weapons for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_POWER_BASH_CYRODIIL_TP = 'Stunned for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends you will be disoriented for |cFFFFFF15|r seconds.';
    LUIE_STRING_SKILL_ELDER_SCROLL_TP = 'Carrying the |cFFFFFF<<1>>|r.';
    LUIE_STRING_SKILL_MEATBAG_CATAPULT_AOE_TP = 'Taking Disease Damage every |cFFFFFF1|r second.\n\nReduce healing received by |cFFFFFF50|r% for |cFFFFFF6|r seconds whenever you take damage from this effect.';
    LUIE_STRING_SKILL_SCATTERSHOT_CATAPULT_AOE_TP = 'Taking Physical Damage every |cFFFFFF1|r second.\n\nIncrease damage taken by |cFFFFFF25|r% for |cFFFFFF6|r seconds whenever you take damage from this effect.';
    LUIE_STRING_SKILL_RUNE_FOCUS_CYRODIIL_TP = 'Absorbing damage every |cFFFFFF0.5|r seconds while standing in the rune focus.';

    LUIE_STRING_SKILL_CONSUME_LIFEFORCE = 'Consume Lifeforce';
    LUIE_STRING_SKILL_RUINOUS_CYCLONE = 'Enemies within |cFFFFFF8|r meters take Physical Damage every |cFFFFFF0.5|r seconds for |cFFFFFF7|r seconds as long as the channel is maintained.\n\nEnemies within |cFFFFFF15|r meters are pulled closer to you while channeling.';

    ----------------------------------------------------------------
    -- BATTLEGROUNDS -----------------------------------------------
    ----------------------------------------------------------------

    LUIE_STRING_SKILL_MARK_OF_THE_WORM_TP = 'Cursed with a magical bomb that explodes after |cFFFFFF<<1>>|r seconds, dealing Magic Damage.';

    ----------------------------------------------------------------
    -- TRAPS -------------------------------------------------------
    ----------------------------------------------------------------

    LUIE_STRING_SKILL_LAVA_TRAP = 'Lava Trap';
    LUIE_STRING_SKILL_LIGHTNING_TRAP = 'Lightning Trap';
    LUIE_STRING_SKILL_SPIKE_TRAP_TP = 'Movement Speed reduced by |cFFFFFF25|r% for |cFFFFFF5|r seconds.\n\nImmobilized for |cFFFFFF0.8|r seconds.';
    LUIE_STRING_SKILL_SPIKE_TRAP_AURIDON_TP = 'Movement Speed reduced by |cFFFFFF25|r% for |cFFFFFF10|r seconds.\n\nThis effect stacks up to |cFFFFFF3|r times, to a maximum of |cFFFFFF75|r% Movement Speed reduction.\n\nStunned for |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_STATIC_PITCHER_TP = 'Taking Shock Damage every |cFFFFFF<<2>>|r <<2[second/seconds]>>. Each tick drains |cFFFFFF10|r% of your Max Stamina and Magicka.';
    LUIE_STRING_SKILL_STUNTED_CURRENT_TP = 'Reduce Stamina Recovery by |cFFFFFF359|r and Magicka Recovery by |cFFFFFF212|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    ----------------------------------------------------------------
    -- SETS --------------------------------------------------------
    ----------------------------------------------------------------

    -- Set Names
    LUIE_STRING_SKILL_SET_BOGDAN_THE_NIGHTFLAME = 'Bogdan the Nightflame';
    LUIE_STRING_SKILL_SET_LORD_WARDEN_DUSK = 'Lord Warden Dusk';
    LUIE_STRING_SKILL_SET_TROLL_KING = 'Troll King';
    LUIE_STRING_SKILL_SET_ICE_FURNACE = 'Ice Furnace';
    LUIE_STRING_SKILL_SET_COOLDOWN = 'Перезарядка'; -- Used as suffix for certain abilities internal cooldown
    LUIE_STRING_SKILL_DISGUISE_MONKS_DISGUISE = "Monk's Disguise";
    LUIE_STRING_SKILL_SET_IRONBLOOD_TP = 'Reduce damage taken by |cFFFFFF30|r% but reduce Movement Speed by |cFFFFFF50|r%.';

    -- Disguises
    LUIE_STRING_SKILL_DISGUISE_GENERIC_TP = 'You are wearing a disguise.';
    LUIE_STRING_SKILL_DISGUISE_KOLLOPI_ESSENCE_TP = 'Cloaked in a haze of forest moths, preventing Wood Orcs from detecting you.\n\nWill not work in PvP enabled areas.';
    LUIE_STRING_SKILL_DISGUISE_SEA_VIPER_ARMOR_TP = 'Disguised as a Maormer Soldier.';
    LUIE_STRING_SKILL_DISGUISE_VULKHEL_GUARD_TP = 'Disguised as a First Auridon Marine.';
    LUIE_STRING_SKILL_DISGUISE_PHAER_MERCENARY_TP = 'Disguised as a Phaer Mercenary.';
    LUIE_STRING_SKILL_DISGUISE_QUENDELUUN_TP = 'Disguised as a member of the invading Ebonheart Pact forces.';
    LUIE_STRING_SKILL_DISGUISE_SEADRAKE_TP = 'Disguised as a Seadrake pirate.';
    LUIE_STRING_SKILL_DISGUISE_SERVANTS_ROBES_TP = 'Disguised as a servant of Headman Bhosek.';
    LUIE_STRING_SKILL_DISGUISE_BLOODTHORN_DISGUISE_TP = 'Disguised as a Bloodthorn Cultist.';

    -- Weapon Sets
    LUIE_STRING_SKILL_SET_ASYLUM_DUAL_WIELD = 'Enemies within |cFFFFFF4|r meters take Physical Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_ASYLUM_BOW = 'Reduce Physical Resistance against Bow attacks by |cFFFFFF6600|r for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_ASYLUM_DESTRUCTION_STAFF = 'Каждое третье применение Force Shock в течение |cFFFFFF<<1>>|r секунд будет всегда накладывать эффекты Burning, Concussion и Chilled.';
    LUIE_STRING_SKILL_SET_ASYLUM_RESTORATION_STAFF = 'Reduce the cost of your Magicka and Stamina healing abilities by |cFFFFFF21|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_MAELSTROM_DW = 'Your single target damage over time abilities used within |cFFFFFF<<1>>|r seconds gain |cFFFFFF1690|r Spell and Weapon Damage.';
    LUIE_STRING_SKILL_SET_MAELSTROM_1H = 'Your next fully-charged Heavy Attack used within |cFFFFFF5|r seconds restores |cFFFFFF1904|r Magicka and Stamina.';
    LUIE_STRING_SKILL_SET_MASTER_1H = 'Gain Spell and Physical Resistance equal to the amount you healed or overhealed with Puncturing Remedy for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_MASTER_RESTO = 'Restoring |cFFFFFF117|r Magicka and Stamina every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_BLACKROSE_DUAL_WIELD = 'Reduce damage taken and increase damage done by |cFFFFFF10|r% for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_SET_BLACKROSE_1H_TP = 'Reduce the cost of your next non-Shield Charge One Hand and Shield ability cast within |cFFFFFF<<1>>|r seconds by |cFFFFFF100|r%.';
    LUIE_STRING_SKILL_SET_BLACKROSE_DESTRO_TP = 'Afflicted with consecutive Flame, Shock, and Frost Damage for |cFFFFFF8|r seconds.';
    LUIE_STRING_SKILL_SET_VATESHRAN_2H_TP = 'Increase Weapon Damage by |cFFFFFF38|r per stack for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF5|r times when you cast a Stamina ability while in combat with Momentum active.\n\nUpon reaching max stacks, your next Heavy Attack will consume all stacks and release a violent explosion of energy around you, dealing Physical Damage to all enemies within |cFFFFFF8|r meters.';
    LUIE_STRING_SKILL_SET_VATESHRAN_1H_TP = 'After |cFFFFFF<<1>>|r <<1[second/seconds]>>, apply Major Maim to enemies within |cFFFFFF12|r meters for |cFFFFFF10|r seconds.';
    LUIE_STRING_SKILL_SET_VATESHRAN_DESTRO_TP = 'Tethered to your attacker for |cFFFFFF<<1>>|r seconds. You and allies touching the tether take random Flame, Shock, or Frost damage every |cFFFFFF1|r second.\n\nThe tether breaks if you move beyond |cFFFFFF15|r meters away from your attacker.';
    LUIE_STRING_SKILL_SET_VATESHRAN_DESTRO_BUFF_TP = 'Increase the damage dealt by Wrath of Elements by |cFFFFFF1|r%, stacking up to |cFFFFFF20|r times whenever it deals damage.';
    LUIE_STRING_SKILL_SET_VATESHRAN_RESTO_TP = 'Tethered to your attacker for |cFFFFFF<<1>>|r seconds. Your attacker and their allies touching the tether restore |cFFFFFF175|r Magicka and Stamina every |cFFFFFF1|r second.\n\nThe tether breaks if you move beyond |cFFFFFF15|r meters away from your attacker.';

    -- Monster Helms
    LUIE_STRING_SKILL_SET_BALORGH = 'Increase Weapon and Spell Damage equal to the cost of your last Ultimate used and Physical and Spell Penetration equal to |cFFFFFF23|r times the amount for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_BOGDAN = 'You and allies within |cFFFFFF5|r meters of the totem are healed every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SET_DOMIHAUS_BUFF = 'Increase Weapon and Spell Damage by |cFFFFFF300|r while standing within the ring.';
    LUIE_STRING_SKILL_SET_DOMIHAUS_DAMAGE = 'Enemies on the edge of the ring take Flame Damage and Physical Damage every |cFFFFFF1|r second.\n\nIncrease Weapon and Spell Damage by |cFFFFFF300|r while standing within the ring.';
    LUIE_STRING_SKILL_SET_EARTHGORE = 'Healing the lowest Health group member in the |cFFFFFF7|r meter pool every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SET_GROTHDARR = 'Enemies within |cFFFFFF8|r meters take Flame Damage every |cFFFFFF1|r секунду в течение |cFFFFFF5|r секунд.';
    LUIE_STRING_SKILL_SET_ICEHEART = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nEnemies within |cFFFFFF5|r meters take Frost Damage every |cFFFFFF1|r second while the damage shield holds.';
    LUIE_STRING_SKILL_SET_ILAMBRIS = 'Enemies within |cFFFFFF4|r meters of the meteor shower take Flame Damage and Shock Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SET_ILAMBRIS_GROUND = 'Taking Flame and Shock Damage every |cFFFFFF<<2>>|r <<2[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_LORD_WARDEN_BUFF = 'You and group members within |cFFFFFF8|r meters of the shadow orb gain |cFFFFFF3180|r Physical and Spell Resistance.';
    LUIE_STRING_SKILL_SET_MALUBETH_DAMAGE = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds while the beam holds.\n\nYour attacker heals for |cFFFFFF100|r% of the damage done.';
    LUIE_STRING_SKILL_SET_MALUBETH_HEAL = 'Restoring Health every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds while the beam holds.';
    LUIE_STRING_SKILL_SET_MAW_OF_THE_INFERNAL = "A fire breathing Daedroth fights at your side. The daedroth remains for |cFFFFFF<<1>>|r seconds or until killed.\n\nThe daedroth's attacks deal Flame Damage.";
    LUIE_STRING_SKILL_SET_MOLAG_KENA_TP = 'When you deal damage with |cFFFFFF2|r consecutive light attacks, you trigger |cFFFFFFOverkill|r for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_SET_MOLAG_KENA_OVERKILL_TP = 'Increase Weapon and Spell Damage by |cFFFFFF560|r but increase the cost of your abilities by |cFFFFFF8|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_PIRATE_SKELETON_TP = 'Gain Major Protection but become afflicted with Minor Defile for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_SENTINEL_OF_REKUGAMZ_TP = 'After |cFFFFFF2|r seconds, you and allies within |cFFFFFF5|r meters of the Dwemer Spider are healed and restore |cFFFFFF125|r Magicka and Stamina every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SET_SENTINEL_OF_REKUGAMZ_GROUND_TP = 'Healing and restoring |cFFFFFF125|r Magicka and Stamina every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SET_SHADOWREND_TP = "A shadowy Clannfear fights at your side. The clannfear remains for |cFFFFFF<<1>>|r seconds.\n\nThe Clannfear's attacks deal Magic Damage and reduce their target's damage done by |cFFFFFF5|r% for |cFFFFFF2|r seconds.";
    LUIE_STRING_SKILL_SET_SPAWN_OF_MEPHALA_TP = 'Противники в радиусе |cFFFFFF4|r метров от паутины получают урон Ядом каждую |cFFFFFF1|r секунду, а их скорость передвижения снижена на  |cFFFFFF50|r% в течение |cFFFFFF10|r секунд.';
    LUIE_STRING_SKILL_SET_STORMFIST_TP = 'Enemies within |cFFFFFF4|r meters of the thunderfist take Shock Damage every |cFFFFFF1|r second.\n\nAfter |cFFFFFF3|r seconds the fist closes, dealing Physical Damage.';
    LUIE_STRING_SKILL_STORMFIST_GROUND_TP = 'Taking Shock Damage every |cFFFFFF1|r second.\n\nAfter |cFFFFFF3|r seconds the fist closes, dealing Physical Damage.';
    LUIE_STRING_SKILL_SET_ENGINE_GUARDIAN = 'Restoring |cFFFFFF550|r <<1>> every |cFFFFFF0.5|r seconds for |cFFFFFF7|r seconds.';
    LUIE_STRING_SKILL_SET_THE_TROLL_KING_TP = 'Increase Health Recovery by |cFFFFFF925|r for |cFFFFFF10|r seconds.';
    LUIE_STRING_SKILL_SET_THURVOKUN_TP = 'Enemies in the growing pool of desecrated bile take Disease Damage every |cFFFFFF1|r second and are afflicted with Minor Maim and Minor Defile for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_SET_THURVOKUN_GROUND_TP = 'Taking Disease Damage every |cFFFFFF1|r second.\n\nEach time you take damage you are afflicted with Minor Maim and Minor Defile for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_SET_ZAAN_TP = 'Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds while the beam holds.\n\nDeals |cFFFFFF100|r% increased damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SET_ENERGY_CHARGE = 'Energy Charge';
    LUIE_STRING_SKILL_SET_ENERGY_CHARGE_TP = 'Gain an Energy Charge for |cFFFFFF<<1>>|r seconds when you block an attack.\n\nWhen you gain |cFFFFFF6|r Charges, release the energy, restoring |cFFFFFF5350|r Stamina and Magicka and healing.\n\nAfter releasing the Charges, you cannot regain new Charges for |cFFFFFF14|r seconds.';
    LUIE_STRING_SKILL_SET_MERIDIAS_FAVOR_TP = 'Restoring |cFFFFFF570|r Magicka or Stamina, whichever maximum is higher, every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_AURORANS_THUNDER_TP = 'Enemies in a |cFFFFFF10|r meter cone in front of you take Shock Damage every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_TZOGVINS_WARBAND_TP = 'Increase Weapon Critical by |cFFFFFF134|r for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF10|r times when you deal Critical Damage. At max stacks, you also gain Minor Force.\n\nThis effect can occur once every half second.';
    LUIE_STRING_SKILL_SET_FROZEN_WATCHER_TP = 'Enemies within |cFFFFFF6|r meters of you take Frost Damage every |cFFFFFF1|r second while you are blocking.\n\nYour blizzard has a |cFFFFFF15|r% chance of inflicting Chilled on enemies damaged.';
    LUIE_STRING_SKILL_MAARSELOK_TP = 'Afflicted with Disease Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals |cFFFFFF5|r% increased damage for each negative effect on you, up to |cFFFFFF150|r% additional damage.';
    LUIE_STRING_SKILL_NERIENETH_TP = 'After |cFFFFFF2|r seconds the Lich Crystal explodes, dealing Magic Damage to enemies within |cFFFFFF4|r meters of the crystal.';
    LUIE_STRING_SKILL_SELLISTRIX_TP = 'After |cFFFFFF1.5|r seconds the earthquake erupts, dealing Physical Damage to enemies in a |cFFFFFF4|r meter radius and stunning them for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_SET_MERIDIAS_BLESSED_ARMOR_TP = 'Dodging all incoming dodgeable attacks for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    -- Mythic Items
    LUIE_STRING_SKILL_SET_SNOW_TREADERS_TP = 'Immune to Snare and Immobilization effects that can be cleansed, but you cannot Sprint.';
    LUIE_STRING_SKILL_SET_BLOODLORDS_EMBRACE_TP = 'When your attacker blocks an attack from you, they restore |cFFFFFF1535|r Magicka.\n\nThis effect can occur every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SET_THRASSIAN_STANGLERS_TP = '• Increase Weapon and Spell Damage by |cFFFFFF150|r per stack.\n• Reduce Max Health by |cFFFFFF120|r per stack.\n• Reduce damage shield strength by |cFFFFFF1|r% per stack.\n\nStacks up to |cFFFFFF50|r times when you kill an enemy.';

    -- Crafted Sets
    LUIE_STRING_SKILL_SET_ETERNAL_HUNT = 'Detonates when an enemy enters the |cFFFFFF2.5|r meter radius of the rune, dealing Poison Damage and immoblizing them for |cFFFFFF1.5|r seconds.';
    LUIE_STRING_SKILL_SET_MORKULDIN = 'An animated weapon fights at your side. The animated weapon remains for |cFFFFFF15|r seconds.';
    LUIE_STRING_SKILL_SET_TAVAS_FAVOR = 'Generating |cFFFFFF4|r Ultimate every |cFFFFFF1|r second for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_SET_VARENS_LEGACY = 'Your next direct damage area of effect attack used within |cFFFFFF<<1>>|r seconds deals |cFFFFFF3290|r additional damage.';
    LUIE_STRING_SKILL_SET_MECHANICAL_ACUITY = 'Повышает шанс критического удара Заклинанием и Оружием до |cFFFFFF100|r% в течение |cFFFFFF<<1>>|r секунд.';
    --LUIE_STRING_SKILL_SET_SENCHE_RAHTS_GRIT =                "Increase healing received by |cFFFFFF6|r% and Physical and Spell Resistance by |cFFFFFF2585|r for |cFFFFFF<<1>>|r seconds.",
    LUIE_STRING_SKILL_SET_VASTARIES_TUTELAGE = 'Increase Weapon and Spell Damage by |cFFFFFF258|r and reduce the cost of non-Ultimate abilities by |cFFFFFF10|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_SLOADS_TP = 'Taking |cFFFFFF3|r% of your Max Health as Oblivion Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThis effect can deal a maximum of |cFFFFFF3000|r Oblivion Damage per tick.';
    LUIE_STRING_SKILL_SET_GRAVE_STAKE_COLLECTOR_TP = 'When you touch the grave-stake, restore |cFFFFFF4564|r Stamina and Magicka.\n\nOnly one grave-stake can appear at a time.';
    LUIE_STRING_SKILL_SET_COLDHARBOURS_FAVORITE_HEAL_TP = 'After |cFFFFFF<<1>>|r <<1[second/seconds]>> Honor casts a healing spell on you and group members within |cFFFFFF6|r meters that heals over time for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_SET_COLDHARBOURS_FAVORITE_DAMAGE_TP = 'After |cFFFFFF<<1>>|r <<1[second/seconds]>> Honor explodes, afflicting enemies within |cFFFFFF6|r meters with Magic Damage over time for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_SET_STUHNS_FAVOR_TP = 'Increase Physical and Spell Penetration by |cFFFFFF<<2>>|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThe duration is refreshed when you deal damage to an enemy who is Off Balance.';
    LUIE_STRING_SKILL_SET_DRAGONS_APPETITE_TP = "Dealing non-Bleed damage to Bleeding enemies generates a persistent stack of Dragon's Appetite, up to once per half second.\n\nUpon reaching |cFFFFFF10|r stacks you consume Dragon's Appetite and heal.";

    -- Light / Medium / Heavy Armor Sets
    LUIE_STRING_SKILL_SET_ELEGANCE_LA_TP = 'Your next Health, Magicka, or Stamina ability used within |cFFFFFF<<1>>|r <<1[second/seconds]>> costs |cFFFFFF10|r% less.';
    LUIE_STRING_SKILL_SET_ELEGANCE_HA_TP = 'Your next direct damage attack used within |cFFFFFF<<1>>|r <<1[second/seconds]>> deals |cFFFFFF2610|r additional damage against the first enemy you hit.';
    LUIE_STRING_SKILL_SET_BAHRAHAS_CURSE_TP = 'Enemies in the |cFFFFFF3.5|r meter radius of desecrated ground take Magic Damage every |cFFFFFF1|r second and have their Movement Speed reduced by |cFFFFFF70|r%.\n\nYou heal for |cFFFFFF100|r% of the damage done.';
    LUIE_STRING_SKILL_BAHRAHAS_CURSE_GROUND_TP = 'Taking Magic Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF60|r%.\n\nYour attacker heals for |cFFFFFF100|r% of the damage done.';
    LUIE_STRING_SKILL_SET_BRIARHEART_TP = 'Increase Weapon Damage by |cFFFFFF450|r for |cFFFFFF<<1>>|r seconds.\n\nWhile this effect is active your Critical Strikes heal you.';
    LUIE_STRING_SKILL_SET_UNFATHOMABLE_DARKNESS_TP = 'Every |cFFFFFF3|r seconds a crow will be sent to peck the closest enemy within |cFFFFFF12|r meters, dealing Physical Damage.';
    LUIE_STRING_SKILL_SET_STORM_KNIGHT_TP = 'Enemies within |cFFFFFF5|r meters take Shock Damage every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_SET_DRAUGRS_REST_TP = 'You and group members within |cFFFFFF5|r meters of the consecrated circle heal every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SET_OVERWHELMING_SURGE_TP = 'Enemies within |cFFFFFF8|r meters take Shock Damage every |cFFFFFF1|r second for |cFFFFFF6|r seconds.\n\n|cFFFFFF15|r% of the damage you deal this way is restored to you as Magicka.';
    LUIE_STRING_SKILL_SET_NOBLE_DUELIST = "Noble Duelist's Silks";
    LUIE_STRING_SKILL_PLAGUE_SLINGER_TP = 'After |cFFFFFF1|r second, launch five posion balls over |cFFFFFF5|r seconds, dealing Poison Damage every |cFFFFFF1|r second to the nearest enemy within |cFFFFFF10|r meters of the Skeever Corpse.';
    LUIE_STRING_SKILL_SET_BLOOD_SCENT = 'When you deal damage with a melee Light Attack, you gain a stack of Blood Scent for |cFFFFFF8|r seconds.\n\nWhen you gain |cFFFFFF5|r stacks, you become Frenzied for |cFFFFFF5|r seconds, increasing your melee Light Attack damage by |cFFFFFF55|r% and attack speed by |cFFFFFF50|r%. This effect can occur once every |cFFFFFF15|r seconds.';
    LUIE_STRING_SKILL_SET_FRENIZED = 'Increase melee Light Attack damage by |cFFFFFF55|r% and attack speed by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_EBON_ARMORY = 'Increase Max Health by |cFFFFFF1000|r.';
    LUIE_STRING_SKILL_SET_EMBERSHIELD = 'Increase Physical and Spell Resistance by |cFFFFFF3300|r.\n\nEnemies within |cFFFFFF5|r meters take Flame Damage every |cFFFFFF1|r second for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_SET_HAGRAVENS_GARDEN = 'You and up to |cFFFFFF5|r group members in the |cFFFFFF8|r meter radius of the preservation of nature gain Major Protection.';
    LUIE_STRING_SKILL_SET_JOLTING_ARMS = 'Increase Physical and Spell Resistance by |cFFFFFF4620|r for |cFFFFFF<<1>>|r seconds and your next Bash deals additional damage.';
    LUIE_STRING_SKILL_SET_LEECHING_PLATE_TP = 'Enemies in the |cFFFFFF5|r meter cloud of leeching poison take Poison Damage every |cFFFFFF1|r second.\n\nYou heal for |cFFFFFF100|r% of the damage done.';
    LUIE_STRING_SKILL_SET_HAND_OF_MEPHALA_TP = 'Enemies in the web have their Movement Speed reduced by |cFFFFFF33|r% and are afflicted with Minor Breach.\n\nAfter |cFFFFFF5|r seconds the webs burst into venom, dealing Poison Damage.';
    LUIE_STRING_SKILL_HAND_OF_MEPHALA_GROUND_TP = 'Movement Speed reduced by |cFFFFFF33|r%.\n\nAfter |cFFFFFF5|r seconds the webs burst into venom, dealing Poison Damage.';
    LUIE_STRING_SKILL_LEECHING_PLATE_GROUND_TP = 'Taking Poison Damage every |cFFFFFF1|r second.\n\nYour attacker heals for |cFFFFFF100|r% of the damage done.';
    LUIE_STRING_SKILL_HOLLOWFANG_THIRST_TP = 'After |cFFFFFF2|r seconds the ball of Hemoglobin explodes, restoring |cFFFFFF2523|r Magicka and applying Minor Vitality to you and group members within |cFFFFFF6|r meters of the ball for |cFFFFFF9|r seconds.';
    LUIE_STRING_SKILL_TOUCH_OF_ZEN_TP = 'Taking |cFFFFFF1|r% more damage for each damage over time effect your attacker has afflicted you with, up to |cFFFFFF5|r%.';
    LUIE_STRING_SKILL_SET_BLIGHT_SEED_TP = 'When your attacker deals damage with a damage over time effect, you are infected with a stack of Blight Seed for |cFFFFFF<<1>>|r seconds.\n\nAt |cFFFFFF20|r stacks, the Blight Seeds explode, dealing Disease Damage to you and allies within |cFFFFFF6|r meters.';
    LUIE_STRING_SKILL_RENALDS_RESOLVE_TP = 'Increase healing taken by |cFFFFFF1|r% and Physical and Spell Resistance by |cFFFFFF420|r per stack for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF9|r times when you deal direct damage.\n\nThis effect can occur once every half second.';
    LUIE_STRING_SKILL_DRAGONS_DEFILEMENT_TP = 'Enemies within |cFFFFFF8|r meters are afflicted with Minor Breach.';
    LUIE_STRING_SKILL_DRAGONGUARD_TACTICS_TP = 'Increase Weapon Critical by |cFFFFFF476|r for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF5|r times when you deal direct damage to an enemy from the front or their sides.\n\nYou can only gain one stack every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SENCHALS_DUTY_TP = "Gain a persistent stack of Senchal's Duty, stacking up to |cFFFFFF10|r times when you deal direct damage with a non-Heavy Attack.\n\nAfter completing a fully-charged Heavy Attack, restore |cFFFFFF757|r Stamina and Magicka for each stack of Senchal's Duty and consume them.\n\nYou can only gain one stack of Senchal's Duty every |cFFFFFF1|r second.";
    LUIE_STRING_SKILL_TRINIMACS_VALOR_TP = 'After |cFFFFFF2|r seconds the fragment of Trinimac explodes, healing you and group members while dealing Magic Damage to enemies in within |cFFFFFF5|r meters of the fragment.';
    LUIE_STRING_SKILL_SET_SEVENTH_LEGION_TP = 'Increase Weapon Damage by |cFFFFFF341|r and Health Recovery by |cFFFFFF341|r for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_RAVAGER_TP = "Increase Weapon Damage by |cFFFFFF146|r for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF4|r times when you attempt to reduce a target's Physical or Spell Resistance.\n\nThis effect can occur once every second.\n\nUpon reaching |cFFFFFF4|r stacks, the duration is doubled but can no longer be refreshed.";
    LUIE_STRING_SKILL_SET_HATCHLINGS_SHELL_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThis shield replenishes to absorb |cFFFFFF20|r% of your Max Health in damage for |cFFFFFF15|r seconds every |cFFFFFF15|r seconds.';
    LUIE_STRING_SKILL_SET_DUNERIPPERS_SCALES_TP = 'Increase Physical and Spell Resistance by |cFFFFFF5310|r while you are blocking.';
    LUIE_STRING_SKILL_KJALNARS_NIGHTMARE_TP = 'Marked for |cFFFFFF5|r seconds, stacking up to |cFFFFFF5|r times when your attacker damages you with a Light Attack.\n\nAt |cFFFFFF5|r stacks, an undodgeable skeletal hand attacks you after |cFFFFFF1|r second, knocking you into the air and stunning you for |cFFFFFF3|r seconds or dealing Magic Damage if you cannot be stunned.\n\nYou can only receive a stack once per second.';
    LUIE_STRING_SET_HITIS_HEARTH_TP = 'You and group members within |cFFFFFF10|r meters heal every |cFFFFFF1|r second and have the cost of Sprint, Block, and Roll Dodge reduced by |cFFFFFF5|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SET_HITIS_HEARTH_GROUND_TP = 'Healing every |cFFFFFF1|r second and reduces the cost of Sprint, Block, and Roll Dodge by |cFFFFFF5|r%.';
    LUIE_STRING_SET_DRAUGRKIN_TP = 'Increase damage taken from your attacker by |cFFFFFF617|r for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SET_AEGIS_CALLER_TP = 'After |cFFFFFF2.5|r seconds, the Lesser Aegis spins its blades, dealing Bleed Damage every |cFFFFFF1|r second to enemies within a |cFFFFFF6|r meter radius.';
    LUIE_STRING_SET_GRAVE_GUARDIAN_TP = 'You and group members within |cFFFFFF8|r meters gain |cFFFFFF4430|r Physical and Spell Resistance while you are blocking.';
    LUIE_STRING_SET_WINTERS_RESPITE_TP = 'You and group members in the |cFFFFFF8|r meter radius of healing frost restore Health every |cFFFFFF1|r second.';
    LUIE_STRING_SET_HUNTERS_VENOM_TP = 'You and any player opposed to your attacker within a |cFFFFFF6|r meter radius take Poison Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SET_SHEER_VENOM_TP = 'Afflicted with Poison Damage every |cFFFFFF1|r seconds for |cFFFFFF<<1>>|r seconds.\n\nDeals up to |cFFFFFF100|r% more damage in proportion to your missing health under |cFFFFFF100|r%.';
    LUIE_STRING_SET_ELEMENTAL_CATALYST_TP = 'Increase Critical Damage taken by |cFFFFFF3|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SET_CRIMSON_TWILIGHT_TP = 'After |cFFFFFF<<1>>|r <<1[second/seconds]>>, violently siphon the mist of blood into your body, dealing Bleed Damage to enemies within |cFFFFFF8|r meters and healing you for |cFFFFFF100|r% of the damage done.';
    LUIE_STRING_SET_STONE_HUSK_DOT_TP = 'Tethered for |cFFFFFF<<1>>|r <<1[second/seconds]>>. You and your allies touching the tether take physical damage every |cFFFFFF1|r second.\n\nEach time this effect deals damage your attacker gains a stack of Husk Drain.';
    LUIE_STRING_SET_STONE_HUSK_HUSK_DRAIN_TP = 'Gaining stacks each time the tether deals damage.\n\nWhen the tether ends, you consume the stacks and gain |cFFFFFF30|r Weapon Damage per stack consumed for |cFFFFFF5|r seconds.';
    LUIE_STRING_SET_STONE_HUSK_BUFF_TP = 'Increase Weapon Damage by |cFFFFFF30|r per stack of Stone Husk consumed for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SET_VOIDCALLER_TP = 'Increase Spell Damage by |cFFFFFF24|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>, stacking up to |cFFFFFF20|r times when you take damage.\n\nThis effect can occur once every half second.\n\nUpon reaching |cFFFFFF20|r stacks, the duration is doubled but can no longer be refreshed.';

    -- Trial Sets
    LUIE_STRING_SKILL_SET_BERSERKING_WARRIOR_TP = 'Increase Weapon Critical by |cFFFFFF305|r for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF10|r times when you deal melee damage.\n\nThis effect can occur once every half second.';
    LUIE_STRING_SKILL_SET_DESTRUCTIVE_MAGE_TP = 'When an attacker damages you with a fully-charged Heavy Attack they detonate the bomb, dealing Magic Damage to you and allies within |cFFFFFF8|r meters.';
    LUIE_STRING_SKILL_SET_TWICE_FANGED_SERPENT_TP = 'Increase Physical Penetration by |cFFFFFF544|r for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF10|r times when you deal damage.\n\nThis effect can occur once every half second.';
    LUIE_STRING_SKILL_SET_LUNAR_BASTION_TP = 'You and group members within the |cFFFFFF8|r meter radius of the lunar blessing are granted a damage shield that lasts |cFFFFFF4|r seconds every |cFFFFFF2|r seconds.\n\nThe shield stacks up to |cFFFFFF6|r times.';
    LUIE_STRING_SKILL_SET_LUNAR_BASTION_GROUND_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThis effect is refreshed every |cFFFFFF2|r seconds while standing in the lunar blessing, and stacks up to |cFFFFFF6|r times.';
    LUIE_STRING_SKILL_SET_VESTMENT_OF_OLORIME_TP = 'You and group members standing in the circle of might gain Major Courage for |cFFFFFF20|r seconds.';
    LUIE_STRING_SKILL_SET_MANTLE_OF_SIRORIA_TP = "Standing in the ring grants you a stack of Siroria's Boon every |cFFFFFF1|r second.";
    LUIE_STRING_SKILL_SET_SIRORIAS_BOON_TP = 'Increase Spell Damage by |cFFFFFF52|r for |cFFFFFF5|r seconds, stacking up to |cFFFFFF10|r times when standing in the ring of fire.';
    LUIE_STRING_SKILL_SET_EYE_OF_NAHVIINTAAS = 'Reduce the cost of non-Ultimate abilities by |cFFFFFF12|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_HARMFUL_WINDS = 'Harmful Winds';
    LUIE_STRING_SKILL_SET_RELEQUEN_TP = 'Afflicted with Physical Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds, stacking up to |cFFFFFF10|r times when your attacker damages you with a Light or Heavy Attack.';
    LUIE_STRING_SKILL_SET_KYNES_BLESSING_TP = "You and group members standing in the |cFFFFFF8|r meter radius of Kyne's Blessing restore |cFFFFFF420|r Stamina and Magicka every |cFFFFFF1|r second.";
    --LUIE_STRING_SKILL_SET_KYNES_BLESSING_GROUND_TP =       "Restoring |cFFFFFF399|r Stamina and Magicka every |cFFFFFF1|r second.",
    LUIE_STRING_SKILL_SET_GIANTS_ENDURANCE_TP = "Increase Weapon Damage by |cFFFFFF41|r, stacking up to |cFFFFFF10|r times when you deal Critical Damage.\n\nCompleting a fully-charged Heavy Attack removes Giant's Endurance and grants Giant's Might for |cFFFFFF15|r seconds, increasing your Weapon Damage by |cFFFFFF63|r per stack removed.\n\nYou can only gain a stack of Giant's Endurance once every half second.";
    LUIE_STRING_SKILL_SET_GIANTS_MIGHT_TP = "Increase Weapon Damage by |cFFFFFF63|r per stack of Giant's Endurance consumed for |cFFFFFF<<1>>|r seconds.";
    LUIE_STRING_SKILL_ROAR_OF_ALKOSH_TP = 'Reduce Physical and Spell Resistance by the initial damage done by Roar of Alkosh for |cFFFFFF10|r seconds.';

    -- Battleground Sets
    --LUIE_STRING_SKILL_SET_COWARDS_GEAR_TP =                  "While Sprinting you gain Major Expedition and Major Protection.",
    LUIE_STRING_SKILL_SET_VANGUARDS_CHALLENGE_TP = 'Deal |cFFFFFF35|r% more damage to the player that taunted you, but |cFFFFFF35|r% less damage to all other players for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';

    -- Imperial City Sets
    LUIE_STRING_SKILL_SET_GALERIONS_REVENGE_TP = 'Marked for |cFFFFFF15|r seconds, stacking up to |cFFFFFF5|r times when your attacker damages you with a Light or Heavy Attack.\n\nAt |cFFFFFF5|r stacks, the Marks of Revenge detonate, dealing Magic Damage.\n\nYou can only receive a stack once per second.';
    LUIE_STRING_SKILL_SET_VICECANON_OF_VENOM_TP = 'Afflicted with Poison Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nYour attacker heals for |cFFFFFF100|r% of the damage done.';

    -- Arena Sets
    LUIE_STRING_SKILL_SET_SOLDIER_OF_ANGUISH_TP = 'Negate the next |cFFFFFF4830|r points of healing received for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_SPELL_STRATEGIST_TP = 'Your attacker gains |cFFFFFF460|r additional Spell Damage against you for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_SUCCESSION_TP = 'Increase Spell Damage by |cFFFFFF492|r for <<1>> dealing attacks for |cFFFFFF4|r seconds.\n\nThis effect can occur once every |cFFFFFF4|r seconds per element.';
    LUIE_STRING_SKILL_SET_PARA_BELLUM_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThe shield will replenish every |cFFFFFF10|r seconds.';
    LUIE_STRING_SKILL_SET_GLORIOUS_DEFENDER_TP = 'Dodge the next dodgeable attack directed at you within |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_HEX_SIPHON_TP = 'Increase Spell Damage by |cFFFFFF88|r for |cFFFFFF8|r seconds, stacking up to |cFFFFFF6|r times for each enemy hit by Hex Siphon.';
    LUIE_STRING_SKILL_SET_EXPLOSIVE_REBUKE_TP = 'Tagged with an explosive bomb for |cFFFFFF<<1>>|r seconds.\n\nWhen your attacker hits you with a fully-charged Heavy Attack, the bomb detonates, dealing Flame Damage to you and all allies within |cFFFFFF8|r meters.';

    -- Alliance War Sets
    LUIE_STRING_SKILL_SET_CYRODIILS_LIGHT_TP = 'Ваша следующая способность, расходующая Магию, применённая в течение |cFFFFFF30|r секунд, будет применена бесплатно.';
    LUIE_STRING_SKILL_SET_MORAG_TONG_TP = 'Increase damage taken from Poison and Disease attacks by |cFFFFFF10|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_SET_WARRIORS_FURY_TP = 'Increase Weapon Damage by |cFFFFFF24|r for |cFFFFFF<<1>>|r <<1[second/seconds]>>, stacking up to |cFFFFFF20|r times when you take damage.\n\nThis effect can occur once every half second.\n\nUpon reaching |cFFFFFF20|r stacks, the duration is doubled but can no longer be refreshed.';
    LUIE_STRING_SKILL_SET_ROBES_OF_TRANSMUTATION_TP = 'Increase Critical Resistance by |cFFFFFF1400|r for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SET_BECKONING_STEEL_TP = 'Reduce damage taken from projectiles by |cFFFFFF10|r%.';
    LUIE_STRING_SKILL_SET_SENTRY_TP = 'Dramatically increase Stealth Detection for |cFFFFFF<<1>>|r seconds.';

    ----------------------------------------------------------------
    -- NPC ABILITY / QUEST TOOLTIPS --------------------------------
    ----------------------------------------------------------------

    LUIE_STRING_SKILL_ANCHOR_DROP = 'Anchor Drop';
    LUIE_STRING_SKILL_SHIELD_RUSH = 'Shield Rush';
    LUIE_STRING_SKILL_BLITZ = 'Blitz';
    LUIE_STRING_SKILL_BARRELING_CHARGE = 'Barreling Charge';
    LUIE_STRING_SKILL_ZOOM = 'Zoom';
    LUIE_STRING_SKILL_PLOW = 'Plow';
    LUIE_STRING_SKILL_DEFENSIVE_WARD = 'Defensive Ward';
    LUIE_STRING_SKILL_INSPIRE = 'Inspire';
    LUIE_STRING_SKILL_HIDE_IN_SHADOWS = 'Hide in Shadows';
    LUIE_STRING_SKILL_SHADOWY_BARRIER = 'Shadowy Barrier';
    LUIE_STRING_SKILL_MIGHTY_CHARGE = 'Mighty Charge';
    LUIE_STRING_SKILL_DETECTION = 'Detection';
    LUIE_STRING_SKILL_IMPROVED_SHOCK_TORRENT = 'Improved Shock Torrent';
    LUIE_STRING_SKILL_SIEGE_BARRIER = 'Siege Barrier';
    LUIE_STRING_SKILL_PUNCTURING_CHAINS = 'Puncturing Chains';
    LUIE_STRING_SKILL_IMPROVED_VOLLEY = 'Improved Volley';
    LUIE_STRING_SKILL_FIRE_TORRENT = 'Fire Torrent';
    LUIE_STRING_SKILL_RIP_AND_TEAR = 'Rip and Tear';
    LUIE_STRING_SKILL_LEECHING_BITE = 'Leeching Bite';
    LUIE_STRING_SKILL_FETCHERFLY_COLONY = 'Fetcherfly Colony';
    LUIE_STRING_SKILL_EMPOWER_ATRONACH_FLAME = 'Empower Atronach: Flame';
    LUIE_STRING_SKILL_EMPOWER_ATRONACH_FROST = 'Empower Atronach: Frost';
    LUIE_STRING_SKILL_EMPOWER_ATRONACH_STORM = 'Empower Atronach: Storm';
    LUIE_STRING_SKILL_EMPOWER_ATRONACH_FLAME_TP = 'Empowered by Flame, granting the use of |cFFFFFFFlame Tornado|r for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_EMPOWER_ATRONACH_FLAME_UNLIMITED_TP = 'Empowered by Flame, granting the use of |cFFFFFFFlame Tornado|r.';
    LUIE_STRING_SKILL_EMPOWER_ATRONACH_STORM_TP = 'Empowered by Storm, granting the use of |cFFFFFFLightning Rod|r for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_EMPOWER_ATRONACH_FROST_TP = 'Empowered by Frost, granting the use of |cFFFFFFIce Vortex|r for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_STORM_BOUND_TP = 'Afflicted with Shock Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_CHILLING_AURA_TP = 'Enemies within |cFFFFFF2.5|r meters have their Movement Speed reduced by |cFFFFFF20|r%.';
    LUIE_STRING_SKILL_RADIANCE_TP = 'Enemies within |cFFFFFF3|r meters take Flame Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_LIGHTNING_ROD_TP = 'Afflicted with Shock Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Shock Damage if the channel is finished.';
    LUIE_STRING_SKILL_COLOSSAL_STOMP = 'Colossal Stomp';
    LUIE_STRING_SKILL_BATTLE_SPIRIT = 'Battle Spirit';
    LUIE_STRING_SKILL_COLD_FIRE_TRAP = 'Cold Fire Trap';
    LUIE_STRING_SKILL_LAVA_FOOT_STOMP = 'Lava Foot Stomp';
    LUIE_STRING_SKILL_KNIFE_JUGGLING = 'Knife Juggling';
    LUIE_STRING_SKILL_TORCH_JUGGLING = 'Torch Juggling';
    LUIE_STRING_SKILL_WALL_OF_FLAMES = 'Wall of Flames';
    LUIE_STRING_SKILL_TRAIL_OF_FLAMES = 'Trail of Flames';
    LUIE_STRING_SKILL_CONSECRATE_SHRINE = 'Consecrate Shrine';
    LUIE_STRING_SKILL_UNSTABLE_PORTAL = 'Unstable Portal';
    LUIE_STRING_SKILL_STABILIZE_PORTAL = 'Stabilize Portal';
    LUIE_STRING_SKILL_CLOSE_UNSTABLE_RIFT = 'Close Unstable Rift';
    LUIE_STRING_SKILL_FLAME_BLOSSOM = 'Flame Blossom';
    LUIE_STRING_SKILL_SAHDINAS_ESSENCE = "Sahdina's Essence";
    LUIE_STRING_SKILL_RASHOMTAS_ESSENCE = "Rashomta's Essence";
    LUIE_STRING_SKILL_POLYMORPH_SKELETON = 'Polymorph: Skeleton';
    LUIE_STRING_SKILL_DRAIN_ENERGY = 'Drain Energy';
    LUIE_STRING_SKILL_FIRELIGHT_TP = 'Увеличивает Запас сил на |cFFFFFF5|r% в течение |cFFFFFF30|r минут.';
    LUIE_STRING_SKILL_BARRIER_REBUKE = 'Barrier Rebuke';
    LUIE_STRING_SKILL_TELEPORT_SCROLL = 'Teleport Scroll';
    LUIE_STRING_SKILL_BIND_HANDS = 'Bind Hands';
    LUIE_STRING_SKILL_BIND_BEAR = 'Bind Bear';
    LUIE_STRING_SKILL_IMPROVED = 'Improved';
    LUIE_STRING_SKILL_AETHERIAL_SHIFT = 'Aetherial Shift';
    LUIE_STRING_SKILL_FREE_SPIRIT = 'Free Spirit';
    LUIE_STRING_SKILL_UNBIND = 'Unbind';
    LUIE_STRING_SKILL_BACKFIRE = 'Backfire';
    LUIE_STRING_SKILL_DIVINE_SPEED_TP = 'Increase Movement Speed by |cFFFFFF45|r% for |cFFFFFF2|r minutes.';
    LUIE_STRING_SKILL_QUEST_LIGHTNING_FURY_TP = 'Lightning courses through your body causing all weapon attacks to deal Shock Damage.';
    LUIE_STRING_SKILL_MANTLES_SHADOW = "Mantle's Shadow";
    LUIE_STRING_SKILL_THROW_WATER = 'Throw Water';
    LUIE_STRING_SKILL_VISION_JOURNEY_TP = 'Вам открывается истинная природа леса.';
    LUIE_STRING_SKILL_SNAKE_SCALES_TP = 'Увеличивает наносимый урон на |cFFFFFF5|r% и снижает получаемый урон на |cFFFFFF5|r% пока вы в Гратвуде.';
    LUIE_STRING_SKILL_WOLFS_PELT_TP = 'Увеличивает скорость передвижения на |cFFFFFF4|r% и наносимый урон на |cFFFFFF5|r% пока вы в Гратвуде.';
    LUIE_STRING_SKILL_TIGERS_FUR_TP = 'Увеличивает скорость передвижения на |cFFFFFF4|r% и снижает получаемый урон на |cFFFFFF5|r% пока вы в Гратвуде.';
    LUIE_STRING_SKILL_SOUL_BINDING_TP = 'Вызывает ослабленную душу даэдра, заряжающую сигильскую жеоду.';
    LUIE_STRING_SKILL_EMPOWER_TWILIT_HEART = 'Empower Twilit Heart';
    LUIE_STRING_SKILL_BLACKSAPS_BREW_TP = 'Повышает скорость передвижения на |cFFFFFF4|r% и снижает получаемый урон на |cFFFFFF10|r% в течение |cFFFFFF30|r минут.';
    LUIE_STRING_SKILL_SPIRIT_ARMOR_TP = 'Increase Armor by |cFFFFFF5|r% for |cFFFFFF15|r minutes.';
    LUIE_STRING_SKILL_RESTRICTING_VINES = 'Restricting Vines';
    LUIE_STRING_SKILL_CHANGE_CLOTHES = 'Change Clothes';
    LUIE_STRING_SKILL_FANCY_CLOTHING = 'Fancy Clothing';
    LUIE_STRING_SKILL_FANCY_CLOTHING_TP = 'Dressed to impress!';
    LUIE_STRING_SKILL_BURROW_TP = 'Burrowing underground, protecting you from harm and concealing you.';
    LUIE_STRING_SKILL_SERPENT_SPIT = 'Serpent Spit';
    LUIE_STRING_SKILL_SHADOW_WOOD = 'Shadow Wood';
    LUIE_STRING_SKILL_SHADOW_WOOD_TP = 'The Shade of Naemon has dragged you into the Shadow Wood.\n\nWhile in the Shadow Wood, deal |cFFFFFF95|r% less damage to the Shade of Naemon.';
    LUIE_STRING_SKILL_BOSS_CC_IMMUNITY = 'Boss Immunities';
    LUIE_STRING_SKILL_SLAUGHTERFISH_ATTACK_TP = "You are being devoured by a swarm of Slaughterfish, turn back before it's too late!";
    LUIE_STRING_SKILL_RECOVER_TP = 'Wounded and out of the fight, recovering Health over |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_RECOVER_DUEL_TP = 'Wounded and recovering, you will heal after |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BACKSTABBER_TP = 'Increase damage done by |cFFFFFF20|r% when you attack an enemy from behind.';
    LUIE_STRING_SKILL_HARDENED_CARAPACE_TP = 'Reduce damage taken by |cFFFFFF<<1>>|r% for each stack remaining.\n\nLose one stack upon taking any damage.';
    LUIE_STRING_SKILL_CLEAVE_STANCE_TP = 'Cleaving with wild abandon for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DEFENSIVE_WARD_TP = 'Reduce damage taken by |cFFFFFF75|r% for |cFFFFFF<<1>>|r seconds as long as the channel is maintained.';
    LUIE_STRING_SKILL_SOUL_TETHER_NPC_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF8|r seconds.\n\nStunned for |cFFFFFF2|r seconds.';
    --LUIE_STRING_SKILL_FOCUSED_HEALING_TP =                   "Healing every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds while the channel is maintained.\n\nHealing doubles in power after |cFFFFFF2|r seconds.",
    LUIE_STRING_SKILL_RITE_OF_PASSAGE_NPC_TP = 'Reduce damage taken by |cFFFFFF80|r% while the channel is maintained.';
    LUIE_STRING_SKILL_INJECT_LARVA_TP = 'You have been injected with a wasp larva. At the end of its |cFFFFFF<<1>>|r second gestation, it will burst out of you, dealing Physical Damage and spawning a Young Wasp.';
    LUIE_STRING_SKILL_THROW_DAGGER_TP = 'Afflicted with Bleed Damage every |cFFFFFF1|r second for |cFFFFFF8|r seconds.\n\nMovement Speed reduced by |cFFFFFF40|r% for |cFFFFFF4|r seconds.';
    LUIE_STRING_SKILL_AGONY_TP = 'Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen this effect ends you will be afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF7|r seconds.';
    LUIE_STRING_SKILL_HARMONY_TP = 'Reduce damage taken by |cFFFFFF20|r% for |cFFFFFF<<1>>|r seconds as long as another Lamia is nearby.';
    LUIE_STRING_SKILL_SUMMON_SPECTRAL_LAMIA_TP = 'A Spectral Lamia fights at your side. The lamia remains for |cFFFFFF2|r minutes or until killed.';
    LUIE_STRING_SKILL_WEAKNESS_NPC_SUMMON_TP = 'Reduce damage done by |cFFFFFF50|r% as long as a summoned creature fights at your side.';
    LUIE_STRING_SKILL_WEAKNESS_LION_TP = 'Reduce damage done by |cFFFFFF15|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DEEP_SLASH_NPC_TP = 'Reduce damage done by |cFFFFFF15|r% and Movement Speed by |cFFFFFF60|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_ICE_BARRIER_TP = 'Intercepting frontal projectile attacks directed at the caster for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DEVOUR_CLANNFEAR_TP = 'Afflicted with Bleed Damage every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds. \n\nEach time this effect deals damage it heals the clannfear.';
    LUIE_STRING_SKILL_AURA_OF_PROTECTION_TP = 'The Shaman and allies within the radius of the aura take |cFFFFFF25|r% less damage for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_AURA_OF_PROTECTION_OTHER_TP = 'Reduce damage taken by |cFFFFFF25|r% while in proximity of the Aura of Protection.';
    LUIE_STRING_SKILL_AGONIZING_FURY_TP = 'Movement Speed reduced by |cFFFFFF10|r% for |cFFFFFF<<1>>|r seconds.\n\nThis effect stacks up to |cFFFFFF5|r times, to a maximum of |cFFFFFF50|r% Movement Speed reduction.';
    LUIE_STRING_SKILL_GRASPING_VINES_TP = 'Afflicted with Bleed Damage every |cFFFFFF0.5|r seconds and immobilized for |cFFFFFF<<1>>|r seconds.\n\nThe vines explode at the end of the duration, dealing Flame Damage if you do not move away.';
    LUIE_STRING_SKILL_RETALIATION_NPC_TP = 'Deal physical damage after |cFFFFFF<<1>>|r <<1[second/seconds]>> while actively bracing for attack, reducing damage taken by |cFFFFFF80|r% and granting immunity to Stun and Knockback effects.\n\nEnemies that deal damage with a melee Medium or Heavy Attack will be staggered, stunned for |cFFFFFF1|r second, and set Off Balance.';
    LUIE_STRING_SKILL_BRIARHEART_RESURRECTION_TP = 'A Hagraven has restarted the beating briarheart of this enemy, restoring them to life.';
    LUIE_STRING_SKILL_ENRAGE_DEVOTED_TP = 'Increase damage done by |cFFFFFF20|r% for |cFFFFFF2|r minutes.';
    LUIE_STRING_SKILL_ICE_PILLAR_TP = "Enemies within |cFFFFFF3|r meters of the pillar are chilled, reducing their Movement Speed by |cFFFFFF60|r%.\n\nThe Ogre Shaman's Frost Bolts will freeze any chilled targets, inflicting them with a |cFFFFFF4|r second immobilize.";
    LUIE_STRING_SKILL_SUMMON_BEAST_TP = 'A beast fights at your side. The beast remains for |cFFFFFF2|r minutes or until killed.';
    LUIE_STRING_SKILL_CONTROL_BEAST_TP = 'Increase damage done by |cFFFFFF83|r% for |cFFFFFF<<1>>|r seconds while the channel is maintained.';
    LUIE_STRING_SKILL_HEALING_SALVE_TP = 'Healing every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds while the channel is maintained.\n\nHealing doubles in power after |cFFFFFF2|r seconds, leading into a stronger burst heal at the end of the channel.';
    LUIE_STRING_SKILL_LATCH_ON_TP = 'Afflicted with Bleed Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach time this effect deals damage it heals the hoarvor.';
    LUIE_STRING_SKILL_KOTU_GAVA_SWARM_TP = 'Afflicted with Poison Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nAfter |cFFFFFF<<2>>|r <<2[second/seconds]>>, a swarm of Kotu Gava will spawn around you.';
    LUIE_STRING_SKILL_HARDENED_SHELL_TP = 'Chance when hit to reduce damage taken by |cFFFFFF50|r%.';
    LUIE_STRING_SKILL_UNCANNY_DODGE_TP = 'You are unable to be caught off guard and will dodge any single target attacks directed at you before entering combat.';
    LUIE_STRING_SKILL_BLOCK_NPC_TP = 'Brace for attack, reducing damage taken by |cFFFFFF80|r% and granting immunity to Stun and Knockback effects.\n\nEnemies that deal damage with a melee Medium or Heavy Attack will be staggered, stunned for |cFFFFFF3|r seconds, and set Off Balance for |cFFFFFF7|r seconds.';
    LUIE_STRING_SKILL_BLOCK_NPC_THEATER_TP = 'Brace for attack, reducing damage taken by |cFFFFFF80|r% and granting immunity to Stun and Knockback effects.';
    LUIE_STRING_SKILL_CALL_ALLY_TP = 'A summoned beast ally fights at your side. The beast remains for |cFFFFFF2|r minutes or until killed.';
    LUIE_STRING_SKILL_VAMPIRIC_DRAIN_NPC_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach time this effect deals damage it heals the vampire.';
    LUIE_STRING_SKILL_DEVOUR_HUNGER_TP = 'Stunned and afflicted with Bleed Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends you will be knocked back for |cFFFFFF1.5|r seconds.';
    LUIE_STRING_SKILL_TORPOR_TP = 'You are hallucinating.';
    LUIE_STRING_SKILL_COLONIZE_TP = 'After |cFFFFFF5|r seconds this Fetcherfly Colony will turn into a nest.';
    LUIE_STRING_SKILL_FERAL_GUARDIAN_NPC_TP = 'A grizzly fights at your side. The grizzly remains for |cFFFFFF1|r minute or until killed.';
    LUIE_STRING_SKILL_SHADOWY_DUPLICATE_TP = 'Detonating after |cFFFFFF<<1>>|r seconds, dealing Magic Damage to nearby enemies and stunning them for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_SHADOWY_BARRIER_TP = 'Absorbing damage for |cFFFFFF5|r seconds.';
    LUIE_STRING_SKILL_FIENDISH_HEALING_TP = 'Healing every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds while the channel is maintained.\n\nHealing doubles in power after |cFFFFFF2|r seconds.\n\nEach tick enrages the Skaafin, increasing damage done by |cFFFFFF20|r%.';
    LUIE_STRING_SKILL_SLASH_CLIFF_STRIDER_TP = 'Afflicted with Bleed Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_WAR_HORN_NPC_TP = 'Increase Max Health by |cFFFFFF15|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_RADIANT_MAGELIGHT_NPC_TP = 'Revealing nearby stealthed and invisible enemies.\n\nReduce damage taken from stealth attacks by |cFFFFFF50|r%.';
    LUIE_STRING_SKILL_SUMMON_SPIDERLING_TP = 'A spiderling fights at your side. The spiderling remains for |cFFFFFF2|r minutes or until killed.';
    LUIE_STRING_SKILL_UNYIELDING_MACE_TP = 'Afflicted with Bleed Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF8|r seconds.\n\nStunned for |cFFFFFF1.5|r seconds.';
    LUIE_STRING_SKILL_REFLECTIVE_SHADOWS_TP = 'Reflecting projectiles for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_STEAL_ESSENCE_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Magic Damage if the channel is finished.';
    LUIE_STRING_SKILL_DAMPEN_MAGIC_TP = 'Absorbing |cFFFFFF40|r% of incoming Flame, Frost, Shock, and Magic Damage for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_FLAME_RAY_TP = 'Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Flame Damage if the channel is finished.';
    LUIE_STRING_SKILL_FROST_RAY_TP = 'Afflicted with Frost Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDeals additional Frost Damage if the channel is finished.';
    LUIE_STRING_SKILL_LACERATE_GARGOYLE_TP = 'Afflicted with Bleed Damage every |cFFFFFF2.5|r seconds for |cFFFFFF16.5|r seconds.\n\nKnocked down for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_VAMPIRIC_TOUCH_GARGOYLE_TP = 'Single target direct damage attacks restore Health.';
    LUIE_STRING_SKILL_SUMMON_THE_DEAD_TP = 'A risen undead companion fights at your side. The undead remains for |cFFFFFF2|r minutes or until killed.';
    LUIE_STRING_SKILL_BURDENING_EYE_TP = 'The Burdening Eye seeks out a nearby enemy and explodes, dealing Magic Damage and reducing the targets Movement Speed by |cFFFFFF80|r% for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_SPELL_ABSORPTION_TP = 'Reduce Flame, Frost, Shock, and Magic Damage taken by |cFFFFFF90|r% for |cFFFFFF<<1>>|r seconds while the channel is maintained.';
    LUIE_STRING_SKILL_SHARD_SHIELD_TP = 'Absorbing damage for |cFFFFFF5|r minutes.\n\nWhen the shield takes damage, as long as absorption remains, your attacker takes Physical Damage and is stunned for |cFFFFFF1.2|r seconds.';
    LUIE_STRING_SKILL_TIL_DEATH_TP = 'Protected from death by a bodyguard. When you take lethal damage the bodyguard will swap places with you and absorb the killing blow, providing you with immunity to damage and all negative effects for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_TIL_DEATH_SELF_TP = 'Protecting a nearby ally from death. When your ally takes lethal damage, swap places with them and absorb the killing blow, providing you with immunity to damage and all negative effects for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_ELEMENTAL_WEAPON_NPC_TP = 'Augment your next |cFFFFFF3|r uses of Chop or Cleave for |cFFFFFF40|r seconds.\n\nChop creates an elemental pool on the ground that deals Flame Damage every |cFFFFFF0.7|r seconds for |cFFFFFF5.5|r seconds.\n\nCleave fires |cFFFFFF3|r elemental waves, dealing Flame Damage to enemies in the path.';
    LUIE_STRING_SKILL_BALEFUL_CALL_TP = 'Increase Max Health and damage done by |cFFFFFF33|r%.';
    LUIE_STRING_SKILL_REGENERATION_TROLL_TP = 'Regenerating Health every |cFFFFFF2.5|r seconds.';
    LUIE_STRING_SKILL_CONSUMING_OMEN_TP = 'Dealing Magic Damage to nearby allies every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_CONSUMING_OMEN_SNARE_TP = 'Movement speed reduced by |cFFFFFF50|r% for |cFFFFFF1.5|r seconds.';
    LUIE_STRING_SKILL_CLOSE_WOUNDS_TP = 'Healing every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds while the channel is maintained, leading into a stronger burst heal at the end of the channel.';
    LUIE_STRING_SKILL_STATIC_FIELD_TP = 'Enemies in the field take Shock Damage every |cFFFFFF1|r second while allied Dwemer can draw power from the field to |cFFFFFFOvercharge|r, increasing their damage done by |cFFFFFF25|r%.';
    LUIE_STRING_SKILL_SHOCK_BARRAGE_TP = 'Being targeted and bombarded by Shock Barrage, taking Shock Damage every |cFFFFFF0.75|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_POLARIZING_FIELD_TP = 'While active, the Polarizing Field returns Shock Damage to attackers.';
    LUIE_STRING_SKILL_STATIC_SHIELD_TP = 'Absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nIf the shield is not destroyed it will detonate at the end of the duration, dealing Shock Damage to nearby enemies.';
    LUIE_STRING_SKILL_TURRET_MODE_TP = 'Charged by a power conduit, enabling the Sentry to shield itself with |cFFFFFFStatic Shield|r and use the |cFFFFFFThunderbolt|r ability.';
    LUIE_STRING_SKILL_STATIC_CHARGE_TP = 'Residual static energy from the Dolmen is suppressing your Health Recovery and you will be targeted by Static Charge, taking Oblivion damage.\n\nMove to reduce to the static buildup.';
    LUIE_STRING_SKILL_INCAPACITATING_TERROR_TP = 'Feared and afflicted with Frost Damage every |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILL_SPIRITUAL_CLOAK_TP = 'A spiritual cloak prevents Soul Thirsters from pulling you into the spirit realm for |cFFFFFF1|r minute.';
    LUIE_STRING_SKILL_AETHERIAL_SHIFT_TP = 'Stunned and shifting into the spirit realm over |cFFFFFF<<1>>|r <<1[second/seconds]>>.';
    LUIE_STRING_SKILL_BLESSING_GATHWEN_TP = 'Reduce damage taken by |cFFFFFF3|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_MAIM_NPC_TP = 'Reduce damage done by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SUMMON_DARK_PROXY_TP = 'A shadowy Clannfear fights at your side. The clannfear remains for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SUMMON_CLANNFEAR_TP = 'A Clannfear fights at your side. The clannfear remains for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_POOL_OF_FIRE = 'Pool of Fire';
    LUIE_STRING_SKILL_SISTERS_BOND = "Sister's Bond";
    LUIE_STRING_SKILL_CURSE_OF_SUFFERING_TP = 'Afflicted with with Magic Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF40|r%.\n\nEnter the Red Sigil to remove the curse.';
    LUIE_STRING_SKILL_CURSE_OF_DOMINANCE_TP = 'Afflicted with with Magic Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF40|r%.\n\nEnter the Black Sigil to remove the curse.';
    LUIE_STRING_SKILL_HEAL_SPORES = 'Healing Spores';
    LUIE_STRING_SKILL_SUMMON_STRANGLER_SAPLINGS = 'Summon Strangler Saplings';
    LUIE_STRING_SKILL_SIPHON_MAGICKA = 'Siphon Magicka';
    LUIE_STRING_SKILL_SIPHON_MAGICKA_TP = 'Draining |cFFFFFF5|r% Max Magicka every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SIPHON_STAMINA = 'Siphon Stamina';
    LUIE_STRING_SKILL_SIPHON_STAMINA_TP = 'Draining |cFFFFFF5|r% Max Stamina every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DARK_ROOT_STAMINA_TP = 'Dramatically increase Max Stamina and Stamina Recovery.';
    LUIE_STRING_SKILL_DARK_ROOT_MAGICKA_TP = 'Dramatically increase Max Magicka and Magicka Recovery.';
    LUIE_STRING_SKILL_SHADOW_TENDRIL = 'Shadow Tendril';
    LUIE_STRING_SKILL_NOVA_TENDRIL = 'Nova Tendril';
    LUIE_STRING_SKILL_BLAZING_ARROW_TP = 'Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nPut out the flames by jumping in the water.';
    LUIE_STRING_SKILL_BLAZING_EMBERS_TP = 'Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF5|r seconds.\n\nPut out the flames by jumping in the water.';
    LUIE_STRING_SKILL_OBLIVION_GATE = 'Oblivion Gate';
    LUIE_STRING_SKILL_ENRAGED_FORTITUDE = 'Enraged Fortitude';
    LUIE_STRING_SKILL_ENRAGE_HORVANTUD = 'Increase damage done by |cFFFFFF5|r%, stacking up to |cFFFFFF3|r times.';
    LUIE_STRING_SKILL_FLAME_TSUNAMI = 'Flame Tsunami';
    LUIE_STRING_SKILL_FLAME_TSUNAMI_TP = 'Afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF2|r seconds.\n\nStunned for |cFFFFFF1.5|r seconds.';
    LUIE_STRING_SKILL_IGNORE_PAIN = 'Ignore Pain';
    LUIE_STRING_SKILL_IGNORE_PAIN_TP = 'Reduce damage taken by |cFFFFFF95|r%.';
    LUIE_STRING_SKILL_MAGMA_PRISON_TP = 'Stunned and afflicted with Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_VOLCANIC_SHIELD = 'Volcanic Shield';
    LUIE_STRING_SKILL_VOLCANIC_SHIELD_TP = 'Absorbing damage and launching bolts of fire at all nearby enemies every |cFFFFFF1|r second while the shield holds.';
    LUIE_STRING_SKILL_SIGIL_OF_HASTE_TP = 'Increase Movement Speed by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SIGIL_OF_POWER_TP = 'Increase Weapon and Spell Damage by |cFFFFFF<<1>>|r for |cFFFFFF30|r seconds.';
    LUIE_STRING_SKILL_SIGIL_OF_HEALING_TP = 'Healing for |cFFFFFF10|r% of your Max Health every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SIGIL_OF_DEFENSE_TP = 'Reduce damage taken by |cFFFFFF50|r% and reflect all projectiles cast at you for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DEFILED_GRAVE_TP = 'Immobilized and taking Magic Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_SUDDEN_STORM = 'Sudden Storm';
    LUIE_STRING_SKILL_BACKSTAB_TP = 'Afflicted with Bleed Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF60|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_CALL_STORM_ATRONACH = 'Call Storm Atronach';
    LUIE_STRING_SKILL_CALL_STORM_ATRONACHS = 'Call Storm Atronachs';
    LUIE_STRING_SKILL_ENERVATING_STONE_TP = 'Stunned and taking Shock Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_ETHEREAL_CHAIN_TP = 'Levitated and afflicted with Magic Damage every |cFFFFFF1.5|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_PRIMAL_SWARM = 'Primal Swarm';
    LUIE_STRING_SKILL_ENSNARE_TP = 'Stunned for |cFFFFFF4|r seconds.\n\nMovement Speed reduced by |cFFFFFF50|r% for |cFFFFFF8|r seconds.';
    LUIE_STRING_SKILL_MIRROR_WARD_TP = 'Reflect all projectiles cast at you.';
    LUIE_STRING_SKILL_POISON_SHOT_TP = 'Afflicted with Poison Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds, stacking indefinitely.';
    LUIE_STRING_SKILL_VENOMOUS_BURST_TP = 'You and allies within |cFFFFFF<<2>>|r meters take Poison Damage every |cFFFFFF<<3>>|r <<3[second/seconds]>> for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SELENES_ROSE = "Selene's Roses";
    LUIE_STRING_SKILL_WEB_WRAP_TP = 'Wrapped in webs and unable to take any action for |cFFFFFF<<1>>|r seconds.\n\nAn ally near you can activate the |cFFFFFFFree Ally|r synergy to free you.';
    LUIE_STRING_SKILL_CHATTERING_WEB_TP = 'Wrapped in webs, taking Poison Damage from Spider Bites every |cFFFFFF1|r second and preventing you from taking any action for |cFFFFFF<<1>>|r seconds.\n\nAn ally near you can activate the |cFFFFFFFree Ally|r synergy to free you.';
    LUIE_STRING_SKILL_CONSTRICTING_WEBS_TP = 'Wrapped in webs and unable to take any action for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_PRIMAL_MAUL = 'Primal Maul';
    LUIE_STRING_SKILL_ROOT_GUARD = 'Root Guard';
    LUIE_STRING_SKILL_EARTH_MENDER = 'Earth Mender';
    LUIE_STRING_SKILL_TRUE_SHOT = 'True Shot';
    LUIE_STRING_SKILL_SENCHE_SPIRIT = 'Senche Spirit';
    LUIE_STRING_SKILL_INJECT_POISON_TP = 'Afflicted with Poison Damage every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.\n\nKnocked back for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_SPAWN_HATCHLINGS = 'Spawn Hatchlings';
    LUIE_STRING_SKILL_FIGHTERS_BOON_TP = 'Increase Armor by |cFFFFFF559|r for |cFFFFFF2|r minutes.';
    LUIE_STRING_SKILL_ENERVATING_SEAL_TP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds. Each tick drains |cFFFFFF15|r% of your Max Stamina and Magicka.';
    LUIE_STRING_SKILL_BLOOD_POOL_TP = 'Taking Physical Damage every |cFFFFFF<<2>>|r <<2[second/seconds]>>. Each time this effect deals damage it heals the Vampire.';
    LUIE_STRING_SKILL_WRACKING_PAIN = 'Wracking Pain';
    LUIE_STRING_SKILL_METEORIC_STRIKE = 'Meteoric Strike';

    LUIE_STRING_SKILL_EXPERT_HUNTER_NPC_TP = '|cFFFFFF20|r% chance on hit to deal additional Magic Damage to Undead and Daedric enemies for |cFFFFFF<<1>>|r seconds.\n\nKilling an Undead or Daedric enemy increases the duration by |cFFFFFF15|r seconds.';
    LUIE_STRING_SKILL_CIRCLE_OF_PROTECTION_NPC_TP = 'Healing every |cFFFFFF1|r second and damage taken reduced by |cFFFFFF55|r%.';
    LUIE_STRING_SKILL_PIERCE_ARMOR_NPC_TP = 'Reduce Physical and Spell Resistance by |cFFFFFF43|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BITING_COLD_TP = 'Taking Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF10|r%.\n\nThis effect stacks up to |cFFFFFF8|r times, to a maximum of |cFFFFFF80|r% Movement Speed reduction.';
    LUIE_STRING_SKILL_BITING_COLD_VET_TP = 'Taking increasing Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF10|r%.\n\nDamage taken increased by |cFFFFFF22|r% per stack.\n\nThe snare stacks up to |cFFFFFF8|r times, to a maximum of |cFFFFFF80|r% Movement Speed reduction.';
    LUIE_STRING_SKILL_FROST_CLENCH_NPC_TP = 'Stunned for |cFFFFFF0.5|r seconds.\n\nImmobilized for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_UWOF_NPC_TP = 'Taking Frost Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF60|r%.\n\nThe wall explodes when it expires, dealing additional Frost Damage.';
    LUIE_STRING_SKILL_ELEMENTAL_SUSCEPTIBILITY_NPC_TP = 'Reduce Spell Resistance by |cFFFFFF30|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_EMBER_EXPLOSION_TP = '|cFFFFFF40|r% chance to miss all attacks for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_THUNDERING_PRESENCE_NPC_TP = 'Increase Physical and Spell Resistance by |cFFFFFF23100|r and enemies within |cFFFFFF5|r meters take Shock Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_BOUND_AEGIS_NPC_TP = 'Reduce damage taken by |cFFFFFF20|r%.';
    LUIE_STRING_SKILL_MARK_TARGET_NPC_TP = 'Reduce Physical and Spell Resistance by |cFFFFFF75|r% for |cFFFFFF<<1>>|r seconds.\n\nThe Nightblade heals for |cFFFFFF40|r% of their Max Health if you die under this effect.';
    LUIE_STRING_SKILL_ENSLAVEMENT_TP = 'Afflicted with Magic Damage every |cFFFFFF1|r second and Movement Speed gradually reduced over time by up to |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_MOLTEN_ARMAMENTS_NPC_TP = 'Increase Weapon and Spell Damage for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_CINDER_STORM_NPC_TP = 'Taking Flame Damage every |cFFFFFF1|r second, |cFFFFFF30|r% chance to miss all attacks, and Movement Speed reduced by |cFFFFFF70|r%.';
    LUIE_STRING_SKILL_CAUSTIC_ARMOR = 'Caustic Armor';
    LUIE_STRING_SKILL_CORROSIVE_ARMOR_NPC_TP = 'Incoming damage is limited to |cFFFFFF3|r% of your Max Health and nearby enemies suffer |cFFFFFF34|r% reduced Weapon Damage and take Flame Damage and every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_CORROSIVE_ARMOR_NPC_DEBUFF_TP = 'Taking Flame Damage every |cFFFFFF1|r second and Weapon Damage reduced by |cFFFFFF34|r%.';
    LUIE_STRING_SKILL_PETRIFY_NPC_TP = 'Stunned and absorbing damage for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nThe stun breaks after taking enough damage.';
    LUIE_STRING_SKILL_CELESTIAL_WARD_TP = 'While standing in the ward you are protected from Celestial Blast.\n\nHealing every |cFFFFFF0.25|r seconds.';
    LUIE_STRING_SKILL_CELESTIAL_BLAST_TP = 'Targeted by Celestial Blast, after |cFFFFFF<<1>>|r seconds you will take a massive amount of Unmitigable Damage and be stunned for |cFFFFFF4|r seconds.\n\nEnter the lit Celestial Rune to protect yourself.';
    LUIE_STRING_SKILL_STANDARD_OF_MIGHT_NPC_TP = 'Increase damage done and reduce damage taken by |cFFFFFF35|r% while standing within the radius of the standard.';
    LUIE_STRING_SKILL_STANDARD_OF_MIGHT_NPC_GROUND_TP = 'Taking Flame Damage every |cFFFFFF1|r second and healing received reduced by |cFFFFFF50|r%.';
    LUIE_STRING_SKILL_DRAINING_POISON_TP = 'Afflicted with Poison Damage every |cFFFFFF1|r second and Magicka and Stamina Recovery reduced for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_NATURES_BLESSING = "Nature's Blessing";
    LUIE_STRING_SKILL_NATURES_BLESSING_TP = "Nature's Blessing deals increased Unmitigable Damage for each stack for |cFFFFFF<<1>>|r seconds.";
    LUIE_STRING_SKILL_NATURES_BLESSING_GROUND_TP = 'Restoring |cFFFFFF13|r% of your Max Stamina and Magicka every |cFFFFFF1|r second.\n\nTaking stacking Unmitigable Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_ACID_SPRAY_NPC_TP = 'Afflicted with Poison Damage every |cFFFFFF1|r second and Movement Speed reduced by |cFFFFFF40|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_SUMMON_DAEDRIC_TITAN = 'Summon Daedric Titan';
    LUIE_STRING_SKILL_DARK_FLARE_NPC_TP = 'Reduce healing received by |cFFFFFF40%|r.';
    LUIE_STRING_SKILL_PURIFYING_LIGHT_NPC_TP = '|cFFFFFF33|r% of all damage taken for the next |cFFFFFF<<1>>|r seconds will be copied and released as Magic Damage when the effect ends.\n\nWhen the effect ends, a pool of sunlight remains on the ground, healing the Templar and their allies if they are nearby every |cFFFFFF2|r seconds for |cFFFFFF6|r seconds.';
    LUIE_STRING_SKILL_UNSTABLE_CORE_NPC_TP = 'Your single target ranged abilities are reflected back on you for |cFFFFFF<<1>>|r seconds.\n\nThe core explodes when this effect ends, dealing Magic Damage to you and nearby allies.';
    LUIE_STRING_SKILL_SEARING_LIGHT_TP = '|cFFFFFF50|r% chance to miss all attacks for |cFFFFFF4|r seconds.\n\nStunned for |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_SOLAR_DISTURBANCE_NPC_TP = 'Taking Magic Damage every |cFFFFFF1|r second, damage done reduced by |cFFFFFF25|r%, and Movement Speed reduced by |cFFFFFF60|r%.';
    LUIE_STRING_SKILL_DARK_DEAL_NPC_TP = 'Increase Physical and Spell Resistance, and heal every |cFFFFFF1|r second after |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_ICE_CHARGE_TP = 'You and nearby allies take Frost Damage every |cFFFFFF2|r seconds, and Movement Speed reduced by |cFFFFFF90|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_POISON_MIST_TP = 'Reduce damage taken by |cFFFFFF75|r% and enemies within |cFFFFFF5|r meters take Poison Damage every |cFFFFFF1.5|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_DRAIN_ESSENCE_VAMP_NPC_TP = 'Stunned and afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nEach time this effect deals damage it heals the vampire.';
    LUIE_STRING_SKILL_DEVOURING_SWARM_TP = 'Enemies within |cFFFFFF10|r meters take Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nThe bats heal you for each enemy they damage.';
    LUIE_STRING_SKILL_DEVOURING_SWARM_GROUND_TP = 'Taking Magic Damage every |cFFFFFF1|r second.\n\nEach time this effect deals damage it heals the Vampire.';
    LUIE_STRING_SKILL_MALEFIC_WREATH_TP = 'Stunned for |cFFFFFF<<1>>|r seconds.\n\nTake Magic Damage when the effect ends, increased for each second the effect lasts.\n\nThe stun breaks after taking damage.';
    LUIE_STRING_SKILL_CRIPPLING_GRASP_NPC_TP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds and Movement Speed reduced by |cFFFFFF20|r% for |cFFFFFF8|r seconds.\n\nImmobilized for |cFFFFFF3|r seconds.';
    LUIE_STRING_SKILLPOWER_EXTRACTION_NPC_TP = 'Increase damage done by |cFFFFFF10|r% for each enemy hit by Power Extraction.';
    LUIE_STRING_SKILL_MARKED_FOR_DEATH_TP = 'You and nearby allies take Flame Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nWhen the effect ends, a deadly pool of fire will drop on the ground beneath your feet.';
    LUIE_STRING_SKILL_ENRAGE_FG_GLADIATOR_TP = 'Increase damage done by |cFFFFFF100|r% and increase damage taken by |cFFFFFF20|r% per stack.';
    LUIE_STRING_SKILL_EMPOWERED_BY_THE_LIGHT = 'Empowered by the Light';
    LUIE_STRING_SKILL_ARENA_TORCH = 'Arena Torch';
    LUIE_STRING_SKILL_TORCH_GRAB_TP = 'Carrying a torch and silenced for |cFFFFFF<<1>>|r seconds, you can use the torch to reignite a bonfire.';
    LUIE_STRING_SKILL_WARMING_AURA_TP = 'Protected from Biting Cold by the warmth of a bonfire.';
    LUIE_STRING_SKILL_GROWING_TORMENT_TP = 'Increase damage done by |cFFFFFF6|r% per stack.';
    LUIE_STRING_SKILL_DEFENSIVE_PROTOCOL = 'Defensive Protocol';
    LUIE_STRING_SKILL_DEFENSIVE_PROTOCOL_TP = 'Absorbing damage and unable to take any action, while nearby enemies take Shock Damage every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_OVERCHARGED_DWEMER_TP = 'Striking distant enemies with bolts, dealing Shock Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_OVERHEATED_DWEMER_TP = 'Venting flames, dealing Flame Damage to nearby enemies every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_OVERHEATED_DWEMER_VET_TP = 'Venting flames, dealing Flame Damage to nearby enemies every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nDistant enemies will be bombarded with a volley of flames every |cFFFFFF2|r seconds.';
    LUIE_STRING_SKILL_VENTING_FLAMES = 'Venting Flames';
    LUIE_STRING_SKILL_VOLTAIC_OVERLOAD_TP = 'Nearby enemies take Shock Damage every |cFFFFFF0.5|r seconds for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_FRIGID_WATERS_TP = 'Taking increasing Frost Damage every |cFFFFFF1|r second.\n\nDamage taken increased by |cFFFFFF100|r% per stack.';
    LUIE_STRING_SKILL_COLD_SNAP_TP = 'Increase damage taken from Cold Snap by |cFFFFFF<<2>>|r% per stack.';
    LUIE_STRING_SKILL_SUMMON_DEATHLESS_WOLF = 'Summon Deathless Wolf';
    LUIE_STRING_SKILL_BLADE_TRAP_VMA = 'Afflicted with Bleed Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nThis effect stacks up to |cFFFFFF25|r times, dealing |cFFFFFF5|r% increased damage per stack.';
    LUIE_STRING_SKILL_ENERGIZE = 'Energize';
    LUIE_STRING_SKILL_REFLECTIVE_SCALE = 'Reflective Scale';
    LUIE_STRING_SKILL_FETCHERFLY_SWARM = 'Fetcherfly Swarm';
    LUIE_STRING_SKILL_WING_GUST_STUN = 'Knocked back for |cFFFFFF<<1>>|r seconds.\n\nMovement speed reduced by |cFFFFFF45|r% for |cFFFFFF<<2>>|r seconds.';
    LUIE_STRING_SKILL_WING_GUST_SNARE = 'Knocked back for |cFFFFFF<<2>>|r seconds.\n\nMovement speed reduced by |cFFFFFF45|r% for |cFFFFFF<<1>>|r seconds.';
    LUIE_STRING_SKILL_ENTROPY_NPC_TP = 'Afflicted with Magic Damage every |cFFFFFF2|r seconds for |cFFFFFF<<1>>|r seconds.\n\nYour attacker heals every |cFFFFFF6|r seconds while Entropy remains active.';

    LUIE_STRING_SKILL_BECKON_GATHWEN = 'Beckon Gathwen';
    --LUIE_STRING_SKILL_DRAINING_BITE_TP =                     "Afflicted with Bleed Damage every |cFFFFFF0.2|r seconds for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nYour attacker heals at the end of this duration.",
    LUIE_STRING_SKILL_MOLTEN_PILLAR_INCALESCENCE = 'Molten Pillar Incalescence';
    LUIE_STRING_SKILL_MOLTEN_PILLAR_TP = "Enemies within |cFFFFFF3|r meters of the pillar are hindered by sweltering heat, reducing their Movement Speed by |cFFFFFF60|r%.\n\nThe Ogre Shaman's Blazing Bolts will shackle any hindered targets, inflicting them with a |cFFFFFF4|r second immobilize.";

    LUIE_STRING_SKILL_DISGUISE_ALTMER_GLAMOUR_TP = 'Disguised as an Altmer Noble.';
    LUIE_STRING_SKILL_WILDERKINGS_PROTECTION_TP = 'The blessing of the Wilderking makes you appear less threatening to the creatures in Greenheart, preventing some of them from attacking you.';

    LUIE_STRING_SKILL_DISPERSE_CORRUPTION = 'Disperse Corruption';
    LUIE_STRING_SKILL_ANCIENT_WRATH_TP = 'Ancient Wrath returns Flame Damage to any enemy that attacks you.';
    LUIE_STRING_SKILL_NECROTIC_CIRCLE_STUN_TP = 'Stunned for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen this effect ends or you break free, you are afflicted with a |cFFFFFF1.2|r second unbreakable stun.';
    LUIE_STRING_SKILL_TRAPPING_BOLT_WORLD_TP = 'Pinned to the ground for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nAn ally near you can activate the |cFFFFFFRemove Bolt|r synergy to free you.\n\nWhen this effect ends or you break free, you are afflicted with a |cFFFFFF1.3|r second unbreakable immobilize.';

    LUIE_STRING_SKILL_POISON_SPIT_TP = 'Targeted by poison spit for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nEvery |cFFFFFF3.33|r seconds a volley of poison will be lauched at you, creating a |cFFFFFF4|r meter pool of poison on the ground for |cFFFFFF10|r seconds.';
    LUIE_STRING_SKILL_GRAVEN_SLASH_TP = 'Afflicted with Bleed Damage every |cFFFFFF2.5|r seconds for |cFFFFFF15|r seconds.\n\nStunned for |cFFFFFF2|r seconds.';

    LUIE_STRING_SKILL_REND_SOUL_TP = 'Levitated and afflicted with Magic Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds.\n\nYour allies must disable the Daedric Altars in the room or you will suffer Oblivion damage equal to |cFFFFFF100|r% of your Max Health at the end of this duration.';
    LUIE_STRING_SKILL_SCORCHING_FLAMES_TP = 'Feared and ignited for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nEvery |cFFFFFF1|r second, a |cFFFFFF4|r meter pool of flame drops at your feet for |cFFFFFF30|r seconds.';
    LUIE_STRING_SKILL_ESCAPED_SOULS = 'Escaped Souls';
    LUIE_STRING_SKILL_CALL_CORRUPT_LURCHERS = 'Call Corrupt Lurchers';
    LUIE_STRING_SKILL_IMMOLATE_COLOSSUS_TP = 'Augments Backhand, Paralyzing Slam, and Trample.\n\nBackhand ignites the target, dealing Flame Damage every |cFFFFFF1|r second for |cFFFFFF4|r seconds.\n\nParalyzing Slam deals additional Flame Damage and knocks the target back for |cFFFFFF2.5|r seconds.\n\nTrample leaves behind a Fire Trail that deals Flame Damage every |cFFFFFF0.5|r seconds.';
    LUIE_STRING_SKILL_OVERWHELMING_BLOW = 'Overwhelming Blow';
    LUIE_STRING_SKILL_LIGHTNING_EMPOWERMENT_TP = 'Empowered by storm, granting the use of |cFFFFFFElectric Prison|r.';
    LUIE_STRING_SKILL_LIGHTNING_EMPOWERMENT_ENRAGE_TP = 'Enraged and empowered by storm, granting the use of |cFFFFFFElectric Prison|r and |cFFFFFFCall Lightning|r.';
    LUIE_STRING_SKILL_INCENSED_TP = 'Empowered by flame, granting the use of |cFFFFFFPyroclasm|r.';
    LUIE_STRING_SKILL_INCENSED_ENRAGE_TP = 'Enraged and empowered by flame, granting the use of |cFFFFFFPyroclasm|r and |cFFFFFFRain Fire|r.';
    LUIE_STRING_SKILL_DAEDRIC_CHAOS = 'Daedric Chaos';
    LUIE_STRING_SKILL_CHAOTIC_DISPERSION = 'Chaotic Dispersion';
    LUIE_STRING_SKILL_CHAOTIC_RETURN = 'Chaotic Return';
    LUIE_STRING_SKILL_RESILIENCE = 'Resilience';
    LUIE_STRING_SKILL_RESILIENCE_TP = 'Reduce damage taken from area of effect and damage over time abilities by |cFFFFFF85|r%.';
    LUIE_STRING_SKILL_WHIRLING_AXE = 'Whirling Axe';
    LUIE_STRING_SKILL_REANIMATE_SKELETONS = 'Reanimate Skeletons';
    LUIE_STRING_SKILL_LEVITATE_SUFFERING_TP = 'Levitated for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends, you will be afflicted with |cFFFFFFCurse of Suffering|r.';
    LUIE_STRING_SKILL_LEVITATE_DOMINANCE_TP = 'Levitated for |cFFFFFF<<1>>|r seconds.\n\nWhen this effect ends, you will be afflicted with |cFFFFFFCurse of Dominance|r.';
    LUIE_STRING_SKILL_SUMMON_FLAME_ATRONACHS = 'Summon Flame Atronachs';
    LUIE_STRING_SKILL_FLAME_BARRIER = 'Flame Barrier';
    LUIE_STRING_SKILL_PRECISION_STRIKE = 'Precision Strike';
    LUIE_STRING_SKILL_FLAME_AURA = 'Enemies within |cFFFFFF11.5|r meters take Flame Damage every |cFFFFFF1|r second.';
    LUIE_STRING_SKILL_STAR_HAVEN_DRAGONHORN = 'Star Haven Dragonhorn';
    LUIE_STRING_SKILL_CHARGE_WIRE = 'Charge-Wire';
    LUIE_STRING_SKILL_STEAM_VENT = 'Steam Vent';
    LUIE_STRING_SKILL_VISION_OF_THE_PAST_TP = 'You are currently experiencing a vision of the past through the eyes of Targoth.';
    LUIE_STRING_SKILL_PIERCING_DAGGER = 'Piercing Dagger';
    LUIE_STRING_SKILL_FREEZING_VINES = 'Freezing Vines';
    LUIE_STRING_SKILL_FREEZING_VINEBURST = 'Freezing Vineburst';
    LUIE_STRING_SKILL_FREEZING_VINES_TP = 'Afflicted with Bleed Damage every |cFFFFFF0.5|r seconds and immobilized for |cFFFFFF<<1>>|r seconds.\n\nThe vines shatter at the end of the duration, dealing Frost Damage if you do not move away.';
    LUIE_STRING_SKILL_SUMMON_SPIDERKITH = 'Summon Spiderkith';
    LUIE_STRING_SKILL_SUMMON_DEATH_SPIDER = 'Summon Death Spider';
    LUIE_STRING_SKILL_SUMMON_DEATH_SPIDER_TP = 'A death spider fights at your side. The death spider remains for |cFFFFFF2|r minutes or until killed.';
    LUIE_STRING_SKILL_FIRE_FORM_TP = 'Imbued with fire, enabling the use of Split Flare, Rain Fire, and the ability to raise detonating Skeletons.';
    LUIE_STRING_SKILL_SHOCK_FORM_TP = 'Imbued with lightning, enabling the use of Split Bolt, Thunder Fist, Call Lightning, and the ability to raise caster Skeletons.';
    LUIE_STRING_SKILL_SPLIT_FLARE = 'Split Flare';
    LUIE_STRING_SKILL_VOID_GRIP = 'Void Grip';
    LUIE_STRING_SKILL_VOID_GRIP_TP = 'Levitated for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen this effect ends you will be engulfed by a Fulminating Void, afflicting you with an unbreakable |cFFFFFF50|r% snare for |cFFFFFF1.5|r seconds that detonates at the end of its duration, dealing Magic Damage and afflicting you with a |cFFFFFF2.5|r second unbreakable knockdown.\n\nIf you take damage more than once from Fulminating Void you will instantly die.';
    LUIE_STRING_SKILL_COLD_STRIKE_TP = 'Movement Speed reduced by |cFFFFFF50|r% for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nWhen this effect ends, you take Magic Damage and are afflicted with a |cFFFFFF2.5|r second unbreakable knockdown.\n\nIf you take damage more than once from Fulminating Void you will instantly die.';
    LUIE_STRING_SKILL_SKULL_VOLLEY = 'Skull Volley';
    LUIE_STRING_SKILL_CHILLING_BOLT = 'Chilling Bolt';
    LUIE_STRING_SKILL_DRAW_THE_EBONY_BLADE = 'Draw the Ebony Blade';
    LUIE_STRING_SKILL_EBONY_SHIELD = 'Mage Barrier';
    LUIE_STRING_SKILL_BLOOD_LUST_TP = "Levitated and afflicted with Oblivion Damage every |cFFFFFF1|r second for |cFFFFFF<<1>>|r seconds. Each time this effect deals damage Nerien'eth is healed.\n\nYou must break Nerienth's Ebony Barrier in order to avoid being executed.";
    LUIE_STRING_SKILL_RESIST_NECROSIS_TP = "Resisting the life draining power of the Ebony Blade, preventing Blood Lust from draining your life and healing Nerien'eth.";
    LUIE_STRING_SKILL_MIGHTY_SWING = 'Mighty Swing';
    LUIE_STRING_SKILL_FLAME_WRAITH = 'Flame Wraith';
    LUIE_STRING_SKILL_GARGOYLE_LEAP = 'Gargoyle Leap';
    LUIE_STRING_SKILL_EXPLOSIVE_BOLT_TP = 'After |cFFFFFF<<1>>|r <<1[second/seconds]>>, the explosive bolt detonates, dealing Flame Damage to you and allies within |cFFFFFF5|r meters.';
    LUIE_STRING_SKILL_HEMORRHAGING_TEAR_TP = 'Afflicted with Bleed Damage every |cFFFFFF<<2>>|r <<2[second/seconds]>> for |cFFFFFF<<1>>|r <<1[second/seconds]>>.\n\nStacks up to |cFFFFFF3|r times, dealing |cFFFFFF50|r% more damage for each stack above the initial application.';
    LUIE_STRING_SKILL_WALL_OF_SOULS_TP = 'A wall of souls protects you from death.\n\nIf any enemy crosses the threshold they take massive damage.';
    LUIE_STRING_SKILL_EYE_OF_THE_SENTINEL_TP = 'You are paralyzed by the gaze of the Coldharbour Sentinel.';

    -- Mounted
    LUIE_STRING_SKILL_MOUNTED = 'Верхом';
    LUIE_STRING_SKILL_MOUNTED_TP = 'You are mounted.';
    LUIE_STRING_SKILL_MOUNTED_PASSENGER = 'Mounted (Passenger)';
    LUIE_STRING_SKILL_MOUNTED_PASSENGER_TP = 'You are mounted as a passenger.';

    -- Keep Upgrade
    LUIE_STRING_KEEP_UPGRADE_FOOD_GUARD_RANGE = 'Longer Range on Ranged Guards';
    LUIE_STRING_KEEP_UPGRADE_FOOD_GUARD_RANGE_TP = 'Increase the range of Mage and Archer Guards.';
    LUIE_STRING_KEEP_UPGRADE_FOOD_HEARTIER_GUARDS = 'Heartier Guards';
    LUIE_STRING_KEEP_UPGRADE_FOOD_HEARTIER_GUARDS_TP = 'Increase the Maximum Health of Guards.';
    LUIE_STRING_KEEP_UPGRADE_FOOD_RESISTANT_GUARDS = 'More Resistant Guards';
    LUIE_STRING_KEEP_UPGRADE_FOOD_RESISTANT_GUARDS_TP = 'Increase the Spell Resistance of Guards and reduce damage taken from Siege Weapons.';
    LUIE_STRING_KEEP_UPGRADE_FOOD_STRONGER_GUARDS = 'Stronger Guards';
    LUIE_STRING_KEEP_UPGRADE_FOOD_STRONGER_GUARDS_TP = 'Guards deal more damage.';
    LUIE_STRING_KEEP_UPGRADE_ORE_ARMORED_GUARDS = 'Heavily Armored Guards';
    LUIE_STRING_KEEP_UPGRADE_ORE_ARMORED_GUARDS_TP = 'Increase the Physical Resistance of Guards.';
    LUIE_STRING_KEEP_UPGRADE_ORE_CORNER_BUILD = 'Corner Build out Upgrade';
    LUIE_STRING_KEEP_UPGRADE_ORE_CORNER_BUILD_TP = 'Add an extra build out section to Keep Corners.';
    LUIE_STRING_KEEP_UPGRADE_ORE_SIEGE_PLATFORM = 'Wall Siege Platform';
    LUIE_STRING_KEEP_UPGRADE_ORE_SIEGE_PLATFORM_TP = 'Various Keep Wall sections have more protective locations.';
    LUIE_STRING_KEEP_UPGRADE_ORE_STRONGER_WALLS = 'Stronger Walls';
    LUIE_STRING_KEEP_UPGRADE_ORE_STRONGER_WALLS_TP = 'Increase the Maximum Health of Keep Walls by |cFFFFFF100500|r.';
    LUIE_STRING_KEEP_UPGRADE_ORE_WALL_REGENERATION = 'Enable Wall Regeneration';
    LUIE_STRING_KEEP_UPGRADE_ORE_WALL_REGENERATION_TP = 'Keep Walls regenerate health when not in combat.';
    LUIE_STRING_KEEP_UPGRADE_WOOD_ARCHER_GUARD = 'Upgrade Archer Guard Abilities';
    LUIE_STRING_KEEP_UPGRADE_WOOD_ARCHER_GUARD_TP = 'Archer Guards gain more powerful versions of some of their abilities.';
    LUIE_STRING_KEEP_UPGRADE_WOOD_DOOR_REGENERATION = 'Door Regeneration';
    LUIE_STRING_KEEP_UPGRADE_WOOD_DOOR_REGENERATION_TP = 'Doors regenerate health when not in combat.';
    LUIE_STRING_KEEP_UPGRADE_WOOD_SIEGE_CAP = 'Higher Defensive Siege Cap';
    LUIE_STRING_KEEP_UPGRADE_WOOD_SIEGE_CAP_TP = 'Increase the number of Siege Weapons that can be placed in defense of this Keep.';
    LUIE_STRING_KEEP_UPGRADE_WOOD_STRONGER_DOORS = 'Stronger Doors';
    LUIE_STRING_KEEP_UPGRADE_WOOD_STRONGER_DOORS_TP = 'Increase the Maximum Health of Doors by |cFFFFFF45000|r.';
    LUIE_STRING_KEEP_UPGRADE_FOOD_MENDER_ABILITIES = 'Upgrade Mender Abilities';
    LUIE_STRING_KEEP_UPGRADE_FOOD_MENDER_ABILITIES_TP = 'Menders gain more powerful versions of some of their abilities.';
    LUIE_STRING_KEEP_UPGRADE_FOOD_HONOR_GUARD_ABILITIES = 'Upgrade Honor Guard Abilities';
    LUIE_STRING_KEEP_UPGRADE_FOOD_HONOR_GUARD_ABILITIES_TP = 'Honor Guards gain more powerful versions of some of their abilities.';
    LUIE_STRING_KEEP_UPGRADE_FOOD_MAGE_ABILITIES = 'Upgrade Mage Abilities';
    LUIE_STRING_KEEP_UPGRADE_FOOD_MAGE_ABILITIES_FIX = 'Upgrade Mage Guard Abilities';
    LUIE_STRING_KEEP_UPGRADE_FOOD_MAGE_ABILITIES_TP = 'Mage Guards gain more powerful versions of some of their abilities.';
    LUIE_STRING_KEEP_UPGRADE_FOOD_GUARD_ABILITIES = 'Upgrade Guard Abilities';
    LUIE_STRING_KEEP_UPGRADE_FOOD_GUARD_ABILITIES_TP = 'Guards gain more powerful versions of some of their abilities.';
};

for stringId, stringValue in pairs(strings) do
    ZO_CreateStringId(stringId, stringValue);
    SafeAddVersion(stringId, 1);
end;
