--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE;

---@class Effects
local Effects = LUIE.Data.Effects;

local Tooltips = LUIE.Data.Tooltips;
local Unitnames = LUIE.Data.UnitNames;
local Zonenames = LUIE.Data.ZoneNames;
local Abilities = LUIE.Data.Abilities;

local zo_strformat = zo_strformat;


--------------------------------------------------------------------------------------------------------------------------------
-- Override various information displayed for Effect auras
--------------------------------------------------------------------------------------------------------------------------------
--[[
    Basic Changes:
    - icon = "iconpath.dds" -- Change icon
    - name = Abilities.AbilityName -- Change name
    - type = BUFF_EFFECT_TYPE_BUFF or BUFF_EFFECT_TYPE_DEBUFF -- Fix/change effect type (Mostly used for making undispellable debuffs show properly)
    - unbreakable = 1 -- Set this effect to display as unbreakable (unremoveable debuff)
    - forcedContainer = "short" or "long" -- Forces this buff to appear in one of these containers (long only applies when the long container exists)
    - groundLabel = "true" -- Display a "G" ground label on this effect to indicate it is the result of standing in a ground aura
    - toggle = "true" -- Display a "T" toggle label on this effect to indicate it is a toggled effect

    Stack Tracking:
    - stack = *number* -- Set a static stack count (or starting stack count - if the values below are also set)
    - stackAdd = *number* -- When this effect triggers add a stack to its count (this can start at the value of "stack = *number*" or otherwise will start at & increment by this value)
    - stackMax = *number* -- Cap the stacks of this effect at this value

    Hide Effect:
    - hide = true -- Hide this aura from displaying
    - hideGround = true -- Hide this aura from displaying if ground effect damaging aurs are set to show - we want damage to always prioritize so that the aura always shows even if the player is immune to a snare or other effect of the ability
    - hideReduce = true -- Hide this aura if the "HIDE PAIRED AURAS" menu setting is enabled. Merging similar effects so as not to clutter the UI such as the snare from the NPC Throw Dagger ability

    Duration or Modification:
    - duration = *number* -- Modify the duration display of this effect. Option 1 - Set a negative value - to subtract x seconds from the duration of the effect. Option 2 - Set to 0 to display the buff for an unlimited amount of time until an action result of fade occurs.
    - noDuplicate = true -- Adds to a table that uses an expensive function - in some cases effects like Shuffle add a new aura every time the effect is cast. This will flag the effect to only show the latest casted one and hide the others.
    - refreshOnly = true -- Only show this effect when the duration is updated/refreshed - Toggle this to hide some goofy effects that have a travel time aura for their projectile before the actual effect applies.

    Tooltip Functionality:
    - tooltip = Tooltips.AbilityName -- Set a custom tooltip to display for this ability
    - tooltipOther = Tooltips.AbilityName -- Set a custom tooltip for display for this ability when this effect is NOT on the player
    - tooltipVeteran = Tooltips.AbilityName -- Set a custom tooltip to use for this ability on Veteran Difficulty only (for abilities that are shared in dungeons and apply additional or different effects on Veteran Difficulty)
    - tooltipValue2 = *number* or *string* -- Set a value to use for the 2nd input field of a tooltip that has a 2nd input field
    - tooltipValue3 = *number* or *string* -- Set a value to use for the 2nd input field of a tooltip that has a 3rd input field
    - tooltipValue2Mod = *number* -- Needed in some cases to derive a value on an ability tooltip. This value is used for effects like the snare from Sun Fire, when the duration needs to be derived from either buff since one can potentially be hidden.
    - dynamicTooltip = true -- This uses a custom dynamic tooltip function for this ability id (note that a dynamic function for this AbilityId needs to exist and no other tooltip data should be set on this id)

    CC Icon Functionality:
    - cc = LUIE_CC_TYPE_* -- Set a CC type for this ability
    - ccMergedType = LUIE_CC_TYPE_* -- Set this ability to show this CC type ONLY when "merged" (hideReduce) effects are enabled. This would mean for example the dot for throw dagger would show as a snare since the effects are merged.
    - isPlayerAbility = true -- Set this ability to be a "Player Ability" for the purpose of determining if a generic CC icon should be used for the ability
--]]
Effects.EffectOverride =
{

    -- TEMP MOVE LATER
    [54119] = { forcedContainer = 'short' }; -- Remembrance (The Anger of a King)

    -- Craglorn buffs
    [82294] = { icon = '/esoui/art/icons/achievement_craglorn_001.dds' }; -- Magicka Attunement
    [81894] = { icon = '/esoui/art/icons/achievement_craglorn_002.dds' }; -- Yokudan Might
    [82499] = { icon = '/esoui/art/icons/achievement_craglorn_003.dds' }; -- Nirncrux Infusion

    ----------------------------------------------------------------
    -- PLAYER INNATE ABILITIES -------------------------------------
    ----------------------------------------------------------------

    ----------------------------------------------------------------
    -- MAJOR / MINOR EFFECTS
    ----------------------------------------------------------------

    -- Major / Minor Buffs
    [61693] = { tooltip = Tooltips.Skill_Minor_Resolve }; -- Minor Resolve
    [61694] = { tooltip = Tooltips.Skill_Major_Resolve }; -- Major Resolve
    [61697] = { tooltip = Tooltips.Skill_Minor_Fortitude }; -- Minor Fortitude
    [61698] = { tooltip = Tooltips.Skill_Major_Fortitude }; -- Major Fortitude
    [61704] = { tooltip = Tooltips.Skill_Minor_Endurance }; -- Minor Endurance
    [61705] = { tooltip = Tooltips.Skill_Major_Endurance }; -- Major Endurance
    [61706] = { tooltip = Tooltips.Skill_Minor_Intellect }; -- Minor Intellect
    [61707] = { tooltip = Tooltips.Skill_Major_Intellect }; -- Major Intellect
    [61685] = { tooltip = Tooltips.Skill_Minor_Sorcery }; -- Minor Sorcery
    [61687] = { tooltip = Tooltips.Skill_Major_Sorcery }; -- Major Sorcery
    [61691] = { tooltip = Tooltips.Skill_Minor_Prophecy }; -- Minor Prophecy
    [61689] = { tooltip = Tooltips.Skill_Major_Prophecy }; -- Major Prophecy
    [61662] = { tooltip = Tooltips.Skill_Minor_Brutality }; -- Minor Brutality
    [61665] = { tooltip = Tooltips.Skill_Major_Brutality }; -- Major Brutality
    [61666] = { tooltip = Tooltips.Skill_Minor_Savagery }; -- Minor Savagery
    [61667] = { tooltip = Tooltips.Skill_Major_Savagery }; -- Major Savagery
    [61744] = { tooltip = Tooltips.Skill_Minor_Berserk }; -- Minor Berserk
    [61745] = { tooltip = Tooltips.Skill_Major_Berserk }; -- Major Berserk
    [61746] = { tooltip = Tooltips.Skill_Minor_Force }; -- Minor Force
    [61747] = { tooltip = Tooltips.Skill_Major_Force }; -- Major Force
    [61549] = { tooltip = Tooltips.Skill_Minor_Vitality }; -- Minor Vitality
    [61713] = { tooltip = Tooltips.Skill_Major_Vitality }; -- Major Vitality
    [61710] = { tooltip = Tooltips.Skill_Minor_Mending }; -- Minor Mending
    [61711] = { tooltip = Tooltips.Skill_Major_Mending }; -- Major Mending
    [61721] = { tooltip = Tooltips.Skill_Minor_Protection }; -- Minor Protection
    [61722] = { tooltip = Tooltips.Skill_Major_Protection }; -- Major Protection
    [61715] = { tooltip = Tooltips.Skill_Minor_Evasion }; -- Minor Evasion
    [61716] = { tooltip = Tooltips.Skill_Major_Evasion }; -- Major Evasion
    [61735] = { tooltip = Tooltips.Skill_Minor_Expedition }; -- Minor Expedition
    [61736] = { tooltip = Tooltips.Skill_Major_Expedition }; -- Major Expedition
    [63569] = { tooltip = Tooltips.Skill_Major_Gallop }; -- Major Gallop
    [61708] = { tooltip = Tooltips.Skill_Minor_Heroism }; -- Minor Heroism
    [61709] = { tooltip = Tooltips.Skill_Major_Heroism }; -- Major Heroism
    [88490] = { tooltip = Tooltips.Skill_Minor_Toughness }; -- Minor Toughness
    [147417] = { tooltip = Tooltips.Skill_Minor_Courage }; -- Minor Courage
    [109966] = { tooltip = Tooltips.Skill_Major_Courage }; -- Major Courage

    -- Major / Minor Debuffs
    [61742] = { tooltip = Tooltips.Skill_Minor_Breach }; -- Minor Breach
    [61743] = { tooltip = Tooltips.Skill_Major_Breach }; -- Major Breach
    [79717] = { tooltip = Tooltips.Skill_Minor_Vulnerability }; -- Minor Vulnerability
    [106754] = { tooltip = Tooltips.Skill_Major_Vulnerability }; -- Major Vulnerability
    [61723] = { tooltip = Tooltips.Skill_Minor_Maim }; -- Minor Maim
    [61725] = { tooltip = Tooltips.Skill_Major_Maim }; -- Major Maim
    [61726] = { tooltip = Tooltips.Skill_Minor_Defile }; -- Minor Defile
    [61727] = { tooltip = Tooltips.Skill_Major_Defile }; -- Major Defile
    [88401] = { tooltip = Tooltips.Skill_Minor_Magickasteal; tooltipOther = Tooltips.Skill_Minor_Magickasteal_Other }; -- Minor Magickasteal
    [86304] = { tooltip = Tooltips.Skill_Minor_Lifesteal; tooltipOther = Tooltips.Skill_Minor_Lifesteal_Other }; -- Minor Lifesteal
    [79907] = { tooltip = Tooltips.Skill_Minor_Enveration }; -- Minor Enervation
    [79895] = { tooltip = Tooltips.Skill_Minor_Uncertainty }; -- Minor Uncertainty
    [79867] = { tooltip = Tooltips.Skill_Minor_Cowardice }; -- Minor Cowardice
    [147643] = { tooltip = Tooltips.Skill_Major_Cowardice }; -- Major Cowardice
    [61733] = { tooltip = Tooltips.Skill_Minor_Mangle }; -- Minor Mangle
    [140699] = { tooltip = Tooltips.Skill_Minor_Timidity }; -- Minor Timidity
    [145975] = { tooltip = Tooltips.Skill_Minor_Brittle }; -- Minor Brittle
    [145977] = { tooltip = Tooltips.Skill_Major_Brittle }; -- Major Brittle

    -- Slayer / Aegis
    [76618] = { tooltip = Tooltips.Skill_Minor_Aegis }; -- Minor Aegis
    [93123] = { tooltip = Tooltips.Skill_Major_Aegis }; -- Major Aegis
    [76617] = { tooltip = Tooltips.Skill_Minor_Slayer }; -- Minor Slayer
    [93109] = { tooltip = Tooltips.Skill_Major_Slayer }; -- Major Slayer

    -- Empower
    [61737] = { tooltip = Tooltips.Skill_Empower }; -- Empower

    ----------------------------------------------------------------
    -- STATUS EFFECT PROCS
    ----------------------------------------------------------------

    -- Magic Status Effects
    [18084] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_burning.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Burning (Fire Status Effect)
    [130804] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_burning.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Burning (Fire Status Effect - Siege)
    [21481] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_chill.dds' }; -- Chill (Frost Status Effect)
    [95136] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_chill.dds' }; -- Chill (Frost Status Effect)
    [130814] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_chill.dds' }; -- Chill (Frost Status Effect)
    [130816] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_chill.dds' }; -- Chill (Frost Status Effect)
    [21487] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_concussion.dds' }; -- Concussion (Shock Status Effect)
    [95134] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_concussion.dds' }; -- Concussion (Shock Status Effect)
    [130808] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_concussion.dds' }; -- Concussion (Shock Status Effect - Siege)
    [130810] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_concussion.dds' }; -- Concussion (Shock Status Effect - Siege)
    [148797] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_overcharged.dds' }; -- Overcharged (Magic Status Effect)
    [178118] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_overcharged.dds' }; -- Overcharged (Magic Status Effect)

    -- Martial Status Effects
    [21925] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_diseased.dds' }; -- Diseased (Disease Status Effect)
    [178127] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_diseased.dds' }; -- Diseased (Disease Status Effect)
    [148801] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_hemorrhaging.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Hemorrhaging (Bleed Status Effect)
    [21929] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_poisoned.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Poisoned (Poison Status Effect)
    [148800] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_sundered.dds' }; -- Sundered (Physical Status Effect)
    [178123] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_sundered.dds' }; -- Sundered (Physical Status Effect)
    [149573] = { icon = 'LuiExtended/media/icons/abilities/ability_proc_sundered.dds' }; -- Sundered (Physical Status Effect - Siege)

    ----------------------------------------------------------------
    -- MUNDUS STONE
    ----------------------------------------------------------------

    -- Mundus Stone Interaction
    [14031] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mundus_use.dds'; name = Abilities.Innate_Receiving_Boon; unbreakable = 1 }; -- Mundus Use

    -- Boons
    [13940] = { tooltip = Tooltips.Boon_Warrior }; -- Boon: The Warrior
    [13943] = { tooltip = Tooltips.Boon_Mage }; -- Boon: The Mage
    [13974] = { tooltip = Tooltips.Boon_Serpent }; -- Boon: The Serpent
    [13975] = { tooltip = Tooltips.Boon_Thief }; -- Boon: The Thief
    [13976] = { tooltip = Tooltips.Boon_Lady }; -- Boon: The Lady
    [13977] = { tooltip = Tooltips.Boon_Steed }; -- Boon: The Steed
    [13978] = { tooltip = Tooltips.Boon_Lord }; -- Boon: The Lord
    [13979] = { tooltip = Tooltips.Boon_Apprentice }; -- Boon: The Apprentice
    [13980] = { tooltip = Tooltips.Boon_Ritual }; -- Boon: The Ritual
    [13981] = { tooltip = Tooltips.Boon_Lover }; -- Boon: The Lover
    [13982] = { tooltip = Tooltips.Boon_Atronach }; -- Boon: The Atronach
    [13984] = { tooltip = Tooltips.Boon_Shadow }; -- Boon: The Shadow
    [13985] = { tooltip = Tooltips.Boon_Tower }; -- Boon: The Tower

    ----------------------------------------------------------------
    -- INNATE ABILITIES
    ----------------------------------------------------------------

    -- Test
    [16415] = { tooltip = Tooltips.Generic_Test }; -- Test

    -- Roll Dodge
    [29721] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_roll_dodge.dds'; tooltip = Tooltips.Innate_Immobilize_Immunity }; -- Immobilize Immunity
    [119068] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_roll_dodge.dds'; tooltip = Tooltips.Innate_Immobilize_Immunity }; -- Immobilize Immunity
    [69143] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_dodge_fatigue.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Innate_Dodge_Fatigue }; -- Dodge Fatigue

    -- Crouch
    [20299] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds'; dynamicTooltip = true }; -- Sneak
    [20309] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_invisible.dds'; tooltip = Tooltips.Innate_Invisible }; -- Hidden
    [26245] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Sneak, Abilities.Innate_Stun); tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Slam Stun (Stun from crouch attack)

    -- Mount
    [37059] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds' }; -- Mount Up (Mount)
    [999017] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds'; name = Abilities.Innate_Mounted }; -- Mounted FAKE
    [115607] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Knockdown; cc = LUIE_CC_TYPE_KNOCKDOWN }; -- Hard Dismount (Mount)

    -- Passenger Mount
    [141013] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds' }; -- Mount Up (Passenger Mount)
    [141004] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Knockdown; cc = LUIE_CC_TYPE_KNOCKDOWN }; -- Hard Dismount (Passenger Mount)

    -- Block
    [974] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds'; name = Abilities.Innate_Brace; dynamicTooltip = true }; -- Brace
    [86310] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Block, Abilities.Innate_Stun); hide = true; tooltip = Tooltips.Generic_Stagger; cc = LUIE_CC_TYPE_STAGGER }; -- Stagger (Player blocks NPC charged attack)
    [86309] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Block, Abilities.Innate_Stun); tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Stun (Player blocks NPC charged attack)
    [86312] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Block, Abilities.Innate_Stun); tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Stun (Player blocks Ogrim Body Slam)
    [45902] = { name = Abilities.Skill_Off_Balance; tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off-Balance

    -- Bash
    [21970] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_bash.dds' }; -- Bash
    [21973] = { icon = '' }; -- Bash (Hides icon for interrupt)
    [21972] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = Abilities.Innate_Bash_Stun; tooltip = Tooltips.Generic_Stagger; cc = LUIE_CC_TYPE_STAGGER }; -- Stagger
    [21971] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Bash Stun (Stun from bashing cast)
    [48416] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = Abilities.Innate_Bash_Stun }; -- Uber Attack (3 sec duration but no aura - when bashing cast when NPC is pinned against an obstacle)
    [45982] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Bash Stun (Stun from bashing cast when NPC is pinned against an obstacle)

    -- Off-Balance Exploit
    [16825] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_off-balance_exploit.dds'; tooltip = Tooltips.Generic_Knockdown; cc = LUIE_CC_TYPE_KNOCKDOWN }; -- Off-Balance Exploit

    -- Death/Resurrection
    [14644] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_resurrection_immunity.dds'; name = Abilities.Innate_Revive }; -- Revive (Death Dialogue)
    [14646] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_resurrection_immunity.dds'; name = Abilities.Innate_Resurrection_Immunity; tooltip = Tooltips.Innate_Resurrection_Immunity }; -- Recently Revived
    [123970] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_resurrection_immunity.dds'; name = Abilities.Innate_Resurrection_Immunity; tooltip = Tooltips.Innate_Resurrection_Immunity }; -- Lesser Reincarnate

    -- Basic Attacks
    [16593] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pin.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 25; cc = LUIE_CC_TYPE_SNARE }; -- Melee Snare
    [48532] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pin.dds'; hide = true }; -- Charge Snare
    [55080] = { hide = true }; -- Pet Hidden
    [28301] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds'; tooltip = Tooltips.Generic_CC_Immunity }; -- Crowd Control Immunity
    [38117] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds'; tooltip = Tooltips.Generic_CC_Immunity }; -- Crowd Control Immunity

    -- Taunt Effects
    [38254] = { icon = '/esoui/art/icons/ability_warrior_010.dds'; tooltip = Tooltips.Innate_Taunt; tooltipOther = Tooltips.Innate_Taunt_Other }; -- Taunt

    -- Disguise Effects
    [50602] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_disguised.dds'; tooltip = Tooltips.Innate_Disguised }; -- Disguised
    [13371] = { hide = true }; -- Acting Suspicious
    [999020] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds'; name = Abilities.Innate_Disguise }; -- Disguise FAKE

    -- Pet Effects
    [43963] = { hide = true }; -- Player Pet Threat
    [63794] = { hide = true }; -- Taunt

    -- Death Achieve Check (Veteran Dungeons)
    [55883] = { hide = true }; -- Death Achieve Check
    [55884] = { hide = true }; -- Death Achieve Check
    [58955] = { hide = true }; -- Death Achieve Check
    [58963] = { hide = true }; -- Death Achieve Check
    [66271] = { hide = true }; -- Death Achieve Check
    [66272] = { hide = true }; -- Death Achieve Check
    [75612] = { hide = true }; -- Death Achieve Check
    [75615] = { hide = true }; -- Death Achieve Check
    [76264] = { hide = true }; -- Death Achieve Check
    [76265] = { hide = true }; -- Death Achieve Check

    -- Artificial
    [999014] = { icon = '/esoui/art/icons/artificialeffect_battle-spirit.dds'; name = Abilities.Skill_Battle_Spirit }; -- Battle Spirit FAKE
    -- Misc
    [999018] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_pet.dds'; name = Abilities.Innate_Vanity_Pet }; -- Pet FAKE BUFf
    [999019] = { icon = 'LuiExtended/media/icons/assistants/assistant_nuzhimeh.dds'; name = Abilities.Innate_Assistant }; -- Assistant FAKE BUFF


    [15594] = { hide = true }; -- Bonus vs off Balance
    [10950] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fall_snare.dds'; name = Abilities.Innate_Fall_Damage }; -- Fall Snare
    [999016] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recall_cooldown.dds'; name = Abilities.Innate_Recall_Penalty; tooltip = Tooltips.Innate_Recall_Penalty }; -- Recall Penalty FAKE
    [6811] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recall.dds' }; -- Recall
    [31221] = { hide = true }; -- Skyshard Collect (Aura on Skyshard when player collects it)
    [32346] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_absorbing_skyshard.dds'; name = Abilities.Innate_Absorbing_Skyshard }; -- Skyshard Collect

    [2727] = { icon = '/esoui/art/icons/ability_debuff_offbalance.dds'; name = Abilities.Skill_Off_Balance; tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off-Balance
    [134599] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_off_balance_immunity.dds'; type = BUFF_EFFECT_TYPE_BUFF; tooltip = Tooltips.Generic_Off_Balance_Immunity }; -- Off Balance Immunity
    [132831] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_major_vulnerability_immunity.dds'; name = Abilities.Skill_Major_Vulnerability_Immunity; type = BUFF_EFFECT_TYPE_BUFF; tooltip = Tooltips.Generic_Major_Vulnerability_Immunity }; -- Major Vulnerability Invulnerability
    [85701] = { hide = true }; -- Dueling Flag
    [21263] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_ayleid_well.dds'; name = Abilities.Innate_Ayleid_Well; tooltip = Tooltips.Innate_Ayleid_Well }; -- Ayleid Health Bonus
    [100862] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_ayleid_well.dds'; name = Abilities.Innate_Ayleid_Well_Fortified; tooltip = Tooltips.Innate_Ayleid_Well_Fortified }; -- Ayleid Health Bonus

    [151928] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_aetherial_well.dds' }; -- Aetherial Well (Aetherial Well)
    [151935] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_aetherial_well.dds'; name = Abilities.Innate_Aetherial_Well }; -- Aetherial Well Restore (Aetherial Well)
    [151942] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_aetherial_well.dds'; name = Abilities.Innate_Aetherial_Well }; -- Aetherial Well Restore (Aetherial Well)
    [151931] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_aetherial_well.dds'; name = Abilities.Innate_Aetherial_Well }; -- Aetherial Well Restore (Aetherial Well)
    [151934] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_aetherial_well.dds'; name = Abilities.Innate_Aetherial_Well }; -- Aetherial Well Restore (Aetherial Well)

    ----------------------------------------------------------------
    -- CHAMPION POINTS ---------------------------------------------
    ----------------------------------------------------------------

    -- Craft
    [152360] = { hide = true }; -- Friends in Low Places
    [151860] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_craft_shadowstrike.dds'; tooltip = Tooltips.Champion_Shadowstrike }; -- Shadowstrike

    -- Warfare
    [155981] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warfare_salve_of_renewal.dds' }; -- Salve of Renewal
    [156020] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warfare_from_the_brink.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- From the Brink
    [156012] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warfare_enlivening_overflow.dds'; tooltip = Tooltips.Champion_Enlivening_Overflow }; -- Enlivening Overflow
    [59530] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warfare_foresight.dds'; tooltip = Tooltips.Champion_Foresight }; -- Foresight
    [60230] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warfare_riposte.dds'; tooltip = Tooltips.Champion_Riposte }; -- Riposte
    [135653] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warfare_reinforced.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Reinforced
    [142013] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warfare_cutting_defense.dds' }; -- Cutting Defense
    [142008] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warfare_reaving_blows.dds' }; -- Reaving Blows
    [142011] = { icon = '/esoui/art/icons/ability_mage_013.dds' }; -- Occult Overload

    -- Fitness
    [151113] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_fitness_expert_evasion.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Champion_Expert_Evasion, Abilities.Set_Cooldown); tooltip = Tooltips.Champion_Expert_Evasion; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Expert Evasion
    [141994] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_fitness_bloody_renewal.dds' }; -- Bloody Renewal
    [141992] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_fitness_siphoning_spells.dds' }; -- Siphoning Spells
    [134254] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_fitness_winded.dds'; tooltip = Tooltips.Champion_Winded; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Winded
    [98316] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_fitness_unchained.dds'; dynamicTooltip = true }; -- Unchained
    [160201] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_fitness_soothing_shield.dds' }; -- Soothing Shield

    ----------------------------------------------------------------
    -- ITEMS -------------------------------------------------------
    ----------------------------------------------------------------

    ----------------------------------------------------------------
    -- GLYPHS
    ----------------------------------------------------------------

    -- Jewelry Glyphs
    [46739] = { hide = true }; -- Bracing Enchant (Glyph of Bracing)

    -- Weapon Glyphs
    [28919] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds' }; -- Life Drain (Glyph of Absorb Health)
    [28921] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds' }; -- Life Drain (Glyph of Absorb Health)
    [46743] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds' }; -- Absorb Magicka (Glyph of Absorb Magicka)
    [46744] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds' }; -- Absorb Magicka (Glyph of Absorb Magicka)
    [46746] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds' }; -- Absorb Stamina (Glyph of Absorb Stamina)
    [46747] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds' }; -- Absorb Stamina (Glyph of Absorb Stamina)
    [17906] = { icon = 'LuiExtended/media/icons/glyphs/glyph_crushing.dds'; tooltip = Tooltips.Generic_Reduce_Physical_Spell_Resist }; -- Crusher (Glyph of Crushing)
    [46749] = { icon = 'LuiExtended/media/icons/glyphs/glyph_decrease_health.dds' }; -- Decrease Health (Glyph of Decrease Health)
    [17895] = { icon = 'LuiExtended/media/icons/glyphs/glyph_flame.dds' }; -- Fiery Weapon (Glyph of Flame)
    [17904] = { icon = 'LuiExtended/media/icons/glyphs/glyph_foulness.dds' }; -- Befouled Weapon (Glyph of Foulness)
    [17897] = { icon = 'LuiExtended/media/icons/glyphs/glyph_frost.dds' }; -- Frozen Weapon (Glyph of Frost)
    [21578] = { icon = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Hardening (Glyph of Hardening)
    [17902] = { icon = 'LuiExtended/media/icons/glyphs/glyph_poison.dds' }; -- Poisoned Weapon (Glyph of Poison)
    [40337] = { icon = 'LuiExtended/media/icons/glyphs/glyph_prismatic.dds' }; -- Primatic Weapon (Glyph of Prismatic Onslaught)
    [17899] = { icon = 'LuiExtended/media/icons/glyphs/glyph_shock.dds' }; -- Charged Weapon (Glyph of Shock)
    [17945] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weakening.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Item_Glyph_of_Weakening }; -- Weakening (Glyph of Weakening)
    [21230] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds'; name = Abilities.Item_Glyph_of_Weapon_Damage; tooltip = Tooltips.Generic_Weapon_Spell_Damage_Duration }; -- Berserker (Glyph of Weapon Damage) (Added in case ever needed)

    ----------------------------------------------------------------
    -- POTIONS
    ----------------------------------------------------------------

    -- Crafted Potions (2 Traits)
    [64564] = { icon = 'LuiExtended/media/icons/potions/potion_007.dds'; tooltip = Tooltips.Skill_Physical_Resistance_Potion }; -- of Armor (Physical Resistance Potion)
    [79709] = { icon = 'LuiExtended/media/icons/potions/potion_014r.dds'; tooltip = Tooltips.Generic_Gradual_Ravage_Health_Potion }; -- of Creeping Ravage Health (Creeping Ravage Health)
    [45236] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds'; tooltip = Tooltips.Generic_Detection }; -- of Detection (Increase Detection)
    [45221] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }; -- .. of Health (Restore Health)
    [45237] = { icon = 'LuiExtended/media/icons/potions/potion_011.dds'; name = Abilities.Potion_Invisiblity; tooltip = Tooltips.Generic_Invisibility }; -- of Invisibility (Vanish)
    [79705] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- of Lingering Health (Lingering Restore Health)
    [45223] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }; -- of Magicka (Restore Magicka)
    [46208] = { icon = 'LuiExtended/media/icons/potions/potion_021.dds'; tooltip = Tooltips.Skill_Ravage_Armor_Potion }; -- of Ravage Armor (Physical Resistance Reduction)
    [46111] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds' }; -- of Ravage Health (Ravage Health)
    [46113] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds'; name = Abilities.Potion_Ravage_Health; tooltip = Tooltips.Generic_Ravage_Health_Potion }; -- of Ravage Health (Health Potion Poison)
    [46193] = { icon = 'LuiExtended/media/icons/potions/potion_016.dds'; tooltip = Tooltips.Generic_Ravage_Magicka_Poison }; -- of Ravage Magicka (Ravage Magicka)
    [46206] = { icon = 'LuiExtended/media/icons/potions/potion_018.dds'; tooltip = Tooltips.Skill_Ravage_Spell_Protection_Potion }; -- of Ravage Spell Protection (Spell Resistance Reduction)
    [46199] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds'; tooltip = Tooltips.Generic_Ravage_Stamina_Poison }; -- of Ravage Stamina (Ravage Stamina)
    [46210] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- of Hindering (Hindrance)
    [64562] = { icon = 'LuiExtended/media/icons/potions/potion_004.dds'; tooltip = Tooltips.Skill_Spell_Resistance_Potion }; -- of Spell Protection (Spell Resistance Potion)
    [45225] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }; -- of Stamina (Restore Stamina)
    [68565] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds'; tooltip = Tooltips.Generic_Stun }; -- of Entrapment (Stun)

    -- Crafted Potions (3 Traits)
    [64565] = { icon = 'LuiExtended/media/icons/potions/potion_007.dds'; tooltip = Tooltips.Skill_Physical_Resistance_Potion }; -- of Armor (Physical Resistance Potion)
    [79710] = { icon = 'LuiExtended/media/icons/potions/potion_014r.dds'; tooltip = Tooltips.Generic_Gradual_Ravage_Health_Potion }; -- of Creeping Ravage Health (Creeping Ravage Health)
    [45382] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }; -- of Health (Restore Health)
    [45458] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds'; tooltip = Tooltips.Generic_Detection }; -- of Detection (Increase Detection)
    [45460] = { icon = 'LuiExtended/media/icons/potions/potion_011.dds'; name = Abilities.Potion_Invisiblity; tooltip = Tooltips.Generic_Invisibility }; -- of Invisibility (Vanish)
    [79706] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- of Lingering Health (Lingering Restore Health)
    [45385] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }; -- of Magicka (Restore Magicka)
    [46250] = { icon = 'LuiExtended/media/icons/potions/potion_021.dds'; tooltip = Tooltips.Skill_Ravage_Armor_Potion }; -- of Ravage Armor (Physical Resistance Reduction)
    [46215] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds'; name = Abilities.Potion_Ravage_Health }; -- of Ravage Health (Damage Health)
    [46217] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds'; name = Abilities.Potion_Ravage_Health; tooltip = Tooltips.Generic_Ravage_Health_Potion }; -- of Ravage Health (Health Potion Linger Effect) (Different name than 2 trait)
    [46237] = { icon = 'LuiExtended/media/icons/potions/potion_016.dds'; tooltip = Tooltips.Generic_Ravage_Magicka_Poison }; -- of Ravage Magicka (Ravage Magicka)
    -- No ... of Ravage Spell Critical
    [46248] = { icon = 'LuiExtended/media/icons/potions/potion_018.dds'; tooltip = Tooltips.Skill_Ravage_Spell_Protection_Potion }; -- of Ravage Spell Protection (Spell Resistance Reduction)
    [46240] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds'; tooltip = Tooltips.Generic_Ravage_Stamina_Poison }; -- of Ravage Stamina (Ravage Stamina)
    [46252] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- of Hindering (Hindrance)
    [64563] = { icon = 'LuiExtended/media/icons/potions/potion_004.dds'; tooltip = Tooltips.Skill_Spell_Resistance_Potion }; -- of Spell Protection (Spell Resistance Potion)
    [45388] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }; -- of Stamina (Restore Stamina)
    -- No ... of Stun

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [17302] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }; -- Restore Health (Vendor)
    [17323] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }; -- Restore Magicka (Vendor)
    [17328] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }; -- Restore Stamina (Vendor)
    [72934] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }; -- Restore Stamina (Alliance Battle Draught)
    [72927] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds' }; -- Restore Health (Alliance Health Draught)
    [72930] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds'; tooltip = Tooltips.Generic_CC_Immunity }; -- Alliance Health Draught (Unstoppable )
    [137002] = { icon = 'LuiExtended/media/icons/potions/potion_ava_purple.dds'; tooltip = Tooltips.Generic_Invisibility }; -- Alliance Health Draught (Invisibility)
    [72931] = { icon = 'LuiExtended/media/icons/potions/potion_ava_blue.dds' }; -- Restore Magicka (Alliance Spell Draught)
    [78053] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }; -- Restore Stamina (Roguish Stealth Draught)
    [78058] = { icon = 'LuiExtended/media/icons/potions/potion_ava_purple.dds'; name = Abilities.Potion_Invisiblity; tooltip = Tooltips.Generic_Invisibility }; -- Roguish Stealth Draught (Vanish)
    [78079] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }; -- Restore Stamina (Roguish Escape Draught)

    -- Crown Store Potions
    [68401] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds'; name = Abilities.Potion_Restore_Health }; -- Restore All Resources (Crown Tri-Restoration Potion)
    [68407] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds' }; -- Restore Magicka (Crown Tri-Restoration Potion)
    [68409] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds' }; -- Restore Stamina (Crown Tri-Restoration Potion)
    [86780] = { icon = 'LuiExtended/media/icons/potions/potion_crown_pink.dds'; tooltip = Tooltips.Generic_Invisibility }; -- Crown Invisibility Potion (Invisibility)
    [86682] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds'; name = Abilities.Potion_Restore_Magicka }; -- Gold Coast Spellcaster Elixir (Gold Coast Spellcaster Elixir)
    [86696] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds'; name = Abilities.Potion_Restore_Health }; -- Gold Coast Survivor Elixir (Gold Coast Survivor Elixir)
    [86698] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds'; tooltip = Tooltips.Generic_CC_Immunity }; -- Gold Coast Survivor Elixir (Unstoppable)
    [86699] = { icon = 'LuiExtended/media/icons/potions/potion_crown_pink_alt.dds'; tooltip = Tooltips.Generic_Invisibility }; -- Gold Coast Survivor Elixir (Invisibility)
    [86692] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds'; name = Abilities.Potion_Restore_Stamina }; -- Gold Coast Warrior Elixir (Gold Coast Warrior Elixir)
    [92414] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds'; name = Abilities.Potion_Restore_Health }; -- Gold Coast Survivor Elixir (Gold Coast Swift Survivor Elixir)
    [92416] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds'; tooltip = Tooltips.Generic_CC_Immunity }; -- Unstoppable (Gold Coast Swift Survivor Elixir)

    ----------------------------------------------------------------
    -- POSIONS
    ----------------------------------------------------------------

    -- Crafted Poisons (2 Traits)
    [79133] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Drain Health (Drain Health Poison) DEBUFF
    [79134] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Restore Health (Drain Health Poison) BUFF
    [79025] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Ravage Health (Damage Health Poison) DEBUFF
    [79137] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds'; tooltip = Tooltips.Generic_Ravage_Magicka_Poison }; -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79138] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds'; tooltip = Tooltips.Generic_Magicka_Regen; tooltipValue2 = 1 }; -- Restore Magicka (Drain Magicka Poison) BUFF
    [79037] = { icon = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds'; tooltip = Tooltips.Generic_Ravage_Magicka_Poison }; -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79141] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds'; tooltip = Tooltips.Generic_Ravage_Stamina_Poison }; -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79142] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds'; tooltip = Tooltips.Generic_Stamina_Regen; tooltipValue2 = 1 }; -- Restore Stamina (Drain Stamina Poison) BUFF
    [79045] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds'; tooltip = Tooltips.Generic_Ravage_Stamina_Poison }; -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79284] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds'; tooltip = Tooltips.Skill_Ravage_Spell_Protection_Potion }; -- Spell Resistance Reduction (Ward-Draining Poison) DEBUFF
    [79285] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds'; tooltip = Tooltips.Skill_Spell_Resistance_Poison }; -- Spell Resistance (Ward-Draining Poison) BUFF
    [79087] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds'; tooltip = Tooltips.Skill_Ravage_Spell_Protection_Potion }; -- Spell Resistance Reduction (Breaching Poison) DEBUFF
    [79309] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds'; tooltip = Tooltips.Skill_Ravage_Armor_Potion }; -- Physical Resistance Reduction (Resolve-Draining Poison) DEBUFF
    [79310] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds'; tooltip = Tooltips.Skill_Physical_Resistance_Poison }; -- Physical Resistance (Resolve-Draining Poison) BUFF
    [79090] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds'; tooltip = Tooltips.Skill_Ravage_Armor_Potion }; -- Physical Resistance Reduction (Fracturing Poison) DEBUFF
    [79457] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Immobilize (Escapist's Poison) DEBUFF
    [79458] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds'; tooltip = Tooltips.Generic_CC_Immunity }; -- Unstoppable (Escapist's Poison) BUFF
    [79122] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Immobilize (Entrapping Poison) DEBUFF
    [79996] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80003] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_marked.dds'; name = Abilities.Skill_Marked; tooltip = Tooltips.Generic_Marked }; -- Marking Poison (Conspicuous Poison) DEBUFF
    [79367] = { name = Abilities.Skill_Hindrance; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Minor Hindrance (Speed-Draining Poison) DEBUFF
    [79094] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Hindrance (Hindering Poison) DEBUFF
    [79699] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds'; name = Abilities.Poison_Creeping_Drain_Health; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79700] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds'; name = Abilities.Poison_Lingering_Restore_Health; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Restore Health (Gradual Health Drain Poison) BUFF
    [79707] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Creeping Ravage Health (Gradual Ravage Health Poison) DEBUFF
    [125203] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds'; tooltip = Tooltips.Generic_Trauma }; -- Trauma (Traumatic Poison) DEBUFF

    -- Crafted Poisons (3 Traits)
    [79135] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Drain Health (Drain Health Poison) DEBUFF
    [79136] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds';
        tooltip = Tooltips.Generic_HoT;
        tooltipValue2 = 1;
    }; -- Restore Health (Drain Health Poison) BUFF
    [78922] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Ravage Health (Damage Health Poison) DEBUFF
    [79139] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds';
        tooltip = Tooltips.Generic_Ravage_Magicka_Poison;
    }; -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79140] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds';
        tooltip = Tooltips.Generic_Magicka_Regen;
        tooltipValue2 = 1;
    }; -- Restore Magicka (Drain Magicka Poison) BUFF
    [79044] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds';
        tooltip = Tooltips.Generic_Ravage_Magicka_Poison;
    }; -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79143] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds';
        tooltip = Tooltips.Generic_Ravage_Stamina_Poison;
    }; -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79144] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds';
        tooltip = Tooltips.Generic_Stamina_Regen;
        tooltipValue2 = 1;
    }; -- Restore Stamina (Drain Stamina Poison) BUFF
    [79046] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds';
        tooltip = Tooltips.Generic_Ravage_Stamina_Poison;
    }; -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79306] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds';
        tooltip = Tooltips.Skill_Ravage_Spell_Protection_Potion;
    }; -- Spell Resistance Reduction (Ward-Draining Poison) DEBUFF
    [79307] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds';
        tooltip = Tooltips.Skill_Spell_Resistance_Poison;
    }; -- Spell Resistance (Ward-Draining Poison) BUFF
    [79086] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds';
        tooltip = Tooltips.Skill_Ravage_Spell_Protection_Potion;
    }; -- Spell Resistance Reduction (Breaching Poison) DEBUFF
    [79311] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds';
        tooltip = Tooltips.Skill_Ravage_Armor_Potion;
    }; -- Physical Resistance Reduction (Resolve-Draining Poison) DEBUFF
    [79312] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds';
        tooltip = Tooltips.Skill_Physical_Resistance_Poison;
    }; -- Physical Resistance (Resolve-Draining Poison) BUFF
    [79091] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds';
        tooltip = Tooltips.Skill_Physical_Resistance_Poison;
    }; -- Physical Resistance Reduction (Fracturing Poison) DEBUFF
    -- No Uncertainty
    [79459] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Immobilize (Escapist's Poison) DEBUFF
    [79460] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds'; tooltip = Tooltips.Generic_CC_Immunity }; -- Unstoppable (Escapist's Poison)
    -- No Entrapping
    [80002] =
    {
        icon = '/esoui/art/icons/ability_debuff_reveal.dds';
        name = Abilities.Skill_Revealed;
        tooltip = Tooltips.Generic_Reveal;
    }; -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80004] =
    {
        icon = 'LuiExtended/media/icons/abilities/ability_debuff_marked.dds';
        name = Abilities.Skill_Marked;
        tooltip = Tooltips.Generic_Marked;
    }; -- Marking Poison (Conspicuous Poison) DEBUFF
    [79369] = { name = Abilities.Skill_Hindrance; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Minor Hindrance (Speed-Draining Poison) DEBUFF
    [79102] = { name = Abilities.Skill_Hindrance; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Minor Hindrance (Hindering Poison) DEBUFF
    [79701] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79702] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds';
        tooltip = Tooltips.Generic_HoT;
        tooltipValue2 = 1;
    }; -- Restore Health (Gradual Health Drain Poison) BUFF
    [79708] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Creeping Ravage Health (Gradual Ravage Health Poison) DEBUFF
    [125205] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds'; tooltip = Tooltips.Generic_Trauma }; -- Trauma (Traumatic Poison) DEBUFF

    -- Vendor Poisons
    [81553] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Ravage Health (Cloudy Damage Health Poison) DEBUFF
    [81551] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison) DEBUFF
    [81554] =
    {
        icon = '/esoui/art/icons/ability_debuff_minor_hindrance.dds';
        tooltip = Tooltips.Generic_Snare;
        tooltipValue2 = 40;
    }; -- Hindrance (Cloudy Hindering Poison) DEBUFF

    -- Crown Poisons
    [88476] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Creeping Ravage Health (Gold Coast Debilitating Poison)
    [88477] =
    {
        icon = '/esoui/art/icons/ability_debuff_minor_hindrance.dds';
        tooltip = Tooltips.Generic_Snare;
        tooltipValue2 = 40;
    }; -- Hindrance (Gold Coast Debilitating Poison)
    [88471] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_crown_blue_r.dds';
        tooltip = Tooltips.Generic_Ravage_Magicka_Poison;
    }; -- Drain Magicka (Gold Coast Draining Poison)
    [88475] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds';
        tooltip = Tooltips.Generic_Ravage_Stamina_Poison;
    }; -- Drain Stamina (Gold Coast Draining Poison)
    [88473] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_crown_blue_g.dds';
        tooltip = Tooltips.Generic_Magicka_Regen;
        tooltipValue2 = 1;
    }; -- Restore Magicka (Gold Coast Draining Poison)
    [88474] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_crown_green_g.dds';
        tooltip = Tooltips.Generic_Stamina_Regen;
        tooltipValue2 = 1;
    }; -- Restore Stamina (Gold Coast Draining Poison)
    [88462] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Immobilize (Gold Coast Trapping Poison)
    [88463] =
    {
        icon = '/esoui/art/icons/ability_debuff_minor_hindrance.dds';
        tooltip = Tooltips.Generic_Snare;
        tooltipValue2 = 40;
    }; -- Hindrance (Gold Coast Trapping Poison)
    [81274] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Ravage Health (Crown Lethal Poison) DEBUFF
    [81275] =
    {
        icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds';
        tooltip = Tooltips.Generic_Poison;
        tooltipValue2 = 1;
    }; -- Creeping Ravage Health (Crown Lethal Poison) DEBUFF

    ----------------------------------------------------------------
    -- FOOD & DRINK
    ----------------------------------------------------------------

    -- Crafted Food
    [61256] = { hide = true }; -- Magicka Consumable (Health + Stamina Food)
    [61259] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds'; tooltip = Tooltips.Food_Crafted_Health; forcedContainer = 'long' }; -- Health Food
    [61260] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds'; tooltip = Tooltips.Food_Crafted_Magicka; forcedContainer = 'long' }; -- Magicka Food
    [61261] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds'; tooltip = Tooltips.Food_Crafted_Stamina; forcedContainer = 'long' }; -- Stamina Food
    [61294] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds'; tooltip = Tooltips.Food_Crafted_Magicka_Stamina; forcedContainer = 'long' }; -- Magicka + Stamina Food
    [61255] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds'; tooltip = Tooltips.Food_Crafted_Health_Stamina; forcedContainer = 'long' }; -- Health + Stamina Food
    [61257] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds'; tooltip = Tooltips.Food_Crafted_Health_Magicka; forcedContainer = 'long' }; -- Health + Magicka Food
    [61218] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_purple.dds'; tooltip = Tooltips.Food_Crafted_Triple; forcedContainer = 'long' }; -- Triple Food
    [72819] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_tripe_trifle_pocket.dds'; name = Abilities.Food_Orzorgas_Tripe_Trifle_Pocket; tooltip = Tooltips.Food_Crafted_Orzorgas_Tripe; forcedContainer = 'long' }; -- Orzorga's Tripe Trifle Pocket
    [72822] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_blood_price_pie.dds'; name = Abilities.Food_Orzorgas_Blood_Price_Pie; tooltip = Tooltips.Food_Crafted_Orzorgas_Blood_Price; forcedContainer = 'long' }; -- Orzorga's Blood Price Pie
    [72824] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_bear_haunch.dds'; name = Abilities.Food_Orzorgas_Smoked_Bear_Haunch; tooltip = Tooltips.Food_Crafted_Orzorgas_Smoked_Bear; forcedContainer = 'long' }; -- Orzorga's Smoked Bear Haunch
    [100502] = { icon = 'LuiExtended/media/icons/consumables/consumable_deregulated_mushroom_stew.dds'; tooltip = Tooltips.Food_Crafted_Deregulated_Mushroom_Stew; forcedContainer = 'long' }; -- Deregulated Mushroom Stew
    [100498] = { icon = 'LuiExtended/media/icons/consumables/consumable_clockwork_citrus_filet.dds'; tooltip = Tooltips.Food_Crafted_Clockwork_Citrus_Filet; forcedContainer = 'long' }; -- Clockwork Citrus Filet
    [107789] = { icon = 'LuiExtended/media/icons/consumables/consumable_artaeum_takeaway_broth.dds'; tooltip = Tooltips.Food_Crafted_Artaeum_Takeaway_Broth; forcedContainer = 'long' }; -- Artaeum Takeaway Broth
    [107748] = { icon = 'LuiExtended/media/icons/consumables/consumable_artaeum_pickled_fish_bowl.dds'; name = Abilities.Food_Artaeum_Pickled_Fish_Bowl; tooltip = Tooltips.Food_Crafted_Artaeum_Pickled_Fish_Bowl; forcedContainer = 'long' }; -- Lure Allure (Artaeum Pickled Fish Bowl)-- Crafted Drink
    [61322] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Health_Recovery); tooltip = Tooltips.Drink_Crafted_Health; forcedContainer = 'long' }; -- Health Drink
    [61323] = { hide = true }; -- Well Fed
    [61325] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Magicka_Recovery); tooltip = Tooltips.Drink_Crafted_Magicka; forcedContainer = 'long' }; -- Magicka Drink
    [61326] = { hide = true }; -- Well Fed
    [61328] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Stamina_Recovery); tooltip = Tooltips.Drink_Crafted_Stamina; forcedContainer = 'long' }; -- Stamina Drink
    [61329] = { hide = true }; -- Well Fed
    [61345] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Magicka_Stamina_Recovery); tooltip = Tooltips.Drink_Crafted_Magicka_Stamina; forcedContainer = 'long' }; -- Magicka + Stamina Drink
    [61346] = { hide = true }; -- Well Fed
    [61348] = { hide = true }; -- Well Fed
    [61340] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Health_Stamina_Recovery); tooltip = Tooltips.Drink_Crafted_Health_Stamina; forcedContainer = 'long' }; -- Health + Stamina Drink
    [61341] = { hide = true }; -- Well Fed
    [61344] = { hide = true }; -- Well Fed
    [61335] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Health_Magicka_Recovery); tooltip = Tooltips.Drink_Crafted_Health_Magicka; forcedContainer = 'long' }; -- Health + Magicka Drink
    [61336] = { hide = true }; -- Well Fed
    [61339] = { hide = true }; -- Well Fed
    [61350] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_purple.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Primary_Stat_Recovery); tooltip = Tooltips.Drink_Crafted_Triple; forcedContainer = 'long' }; -- Triple Drink
    [72816] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_red_frothgar.dds'; name = Abilities.Drink_Orzorgas_Red_Frothgar; tooltip = Tooltips.Drink_Crafted_Orzorgas_Red_Frothgar; forcedContainer = 'long' }; -- Orzorga's Red Frothgar
    [61354] = { hide = true }; -- Well Fed: Magicka Regen
    [100488] = { icon = 'LuiExtended/media/icons/consumables/consumable_spring-loaded_infusion.dds'; tooltip = Tooltips.Drink_Crafted_Spring_Loaded_Infusion; forcedContainer = 'long' }; -- Spring-Loaded Infusion
    [100490] = { hide = true }; -- Magicka Consumable
    [100489] = { hide = true }; -- Stamina Consumable-- Crafted Seasonal Food
    [84681] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_crisp_and_crunchy_pumpkin.dds'; name = Abilities.Food_Pumpkin_Snack_Skewer; tooltip = Tooltips.Food_Crafted_Pumpkin_Snack_Skewer; forcedContainer = 'long' }; -- Crisp and Crunchy Pumpkin Snack Skewer
    [84709] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_crunchy_spider_skewer.dds'; tooltip = Tooltips.Food_Crafted_Crunchy_Spider_Skewer; forcedContainer = 'long' }; -- Crunchy Spider Skewer
    [84725] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_frosted_brains.dds'; name = Abilities.Food_Frosted_Brains; tooltip = Tooltips.Food_Crafted_Frosted_Brains; forcedContainer = 'long' }; -- Frosted Brains
    [84678] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds'; tooltip = Tooltips.Food_Crafted_Sweet_Sanguine_Apples; forcedContainer = 'long' }; -- Sweet Sanguine Apples (Generic shared id for other seasonal magicka food)
    [86789] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_alcaire_festival_sword-pie.dds'; tooltip = Tooltips.Food_Crafted_Alcaire_Festival_Sword_Pie; forcedContainer = 'long' }; -- Alcaire Festival Sword-Pie
    [86749] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_jagga-drenched_mud_ball.dds'; name = Abilities.Food_Jagga_Drenched_Mud_Ball; tooltip = Tooltips.Food_Crafted_Jagga_Drenched_Mud_Ball; forcedContainer = 'long' }; -- Jagga-Drenched "Mud Ball"
    [86673] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_lava_foot_soup-and-saltrice.dds'; name = Abilities.Food_Lava_Foot_Soup; tooltip = Tooltips.Food_Crafted_Lava_Foot_Soup; forcedContainer = 'long' }; -- Lava Foot Soup-and-Saltrice
    [86787] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_rajhins_sugar_claws.dds'; tooltip = Tooltips.Food_Crafted_Rajhins_Sugar_Claws; forcedContainer = 'long' }; -- Rajhin's Sugar Claws
    [89955] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_candied_jesters_coins.dds'; tooltip = Tooltips.Food_Crafted_Candied_Jesters_Coins; forcedContainer = 'long' }; -- Candied Jester's Coins
    [89971] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_jewels_of_misrule.dds'; tooltip = Tooltips.Food_Crafted_Jewels_of_Misrule; forcedContainer = 'long' }; -- Jewels of Misrule
    [127596] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bewitched_sugar_skulls.dds'; tooltip = Tooltips.Food_Crafted_Bewitched_Sugar_Skulls; forcedContainer = 'long' }; -- Bewitched Sugar Skulls-- Crafted Seasonal Drink
    [84700] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bowl_of_peeled_eyeballs.dds'; name = Abilities.Drink_Bowl_of_Peeled_Eyeballs; tooltip = Tooltips.Drink_Crafted_Bowl_of_Peeled_Eyeballs; forcedContainer = 'long' }; -- Bowl of "Peeled Eyeballs"
    [84735] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_purifying_bloody_mara.dds'; tooltip = Tooltips.Drink_Double_Bloody_Mara; forcedContainer = 'long' }; -- Purifying Bloody Mara
    [84720] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_ghastly_eye_bowl.dds'; name = Abilities.Drink_Ghastly_Eye_Bowl; tooltip = Tooltips.Drink_Crafted_Ghastly_Eye_Bowl; forcedContainer = 'long' }; -- Ghastly Eye Bowl
    [84704] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_party_punch.dds'; tooltip = Tooltips.Drink_Crafted_Witchmothers_Party_Punch; forcedContainer = 'long' }; -- Witchmother's Party Punch
    [84731] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_potent_brew.dds'; tooltip = Tooltips.Drink_Crafted_Witchmothers_Potent_Brew; forcedContainer = 'long' }; -- Witchmother's Potent Brew
    [86677] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bergama_warning_fire.dds'; name = Abilities.Drink_Bergama_Warning_Fire; tooltip = Tooltips.Drink_Crafted_Bergama_Warning_Fire; forcedContainer = 'long' }; -- Bergama Warning Fire
    [86746] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_betnikh_twice-spiked_ale.dds'; name = Abilities.Drink_Betnikh_Twice_Spiked_Ale; tooltip = Tooltips.Drink_Crafted_Betnikh_Twice_Spiked_Ale; forcedContainer = 'long' }; -- Betnikh Twice-Spiked Ale
    [86559] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_hissmir_fish-eye_rye.dds'; name = Abilities.Drink_Hissmir_Fish_Eye_Rye; tooltip = Tooltips.Drink_Hissmir; forcedContainer = 'long' }; -- Hissmir Fish-Eye Rye
    [86791] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_snow_bear_glow-wine.dds'; name = Abilities.Drink_Snow_Bear_Glow_Wine; tooltip = Tooltips.Drink_Crafted_Snow_Bear_Glow_Wine; forcedContainer = 'long' }; -- Snow Bear Glow-Wine
    [89957] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_dubious_camoran_throne.dds'; tooltip = Tooltips.Drink_Crafted_Dubious_Camoran_Throne; forcedContainer = 'long' }; -- Dubious Camoran Throne
    [127531] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_corrupting_bloody_mara.dds'; tooltip = Tooltips.Drink_Crafted_Disastrously_Bloody_Mara; forcedContainer = 'long' }; -- Corrupting Bloody Mara
    [127572] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_pack_leaders_bone_broth.dds'; tooltip = Tooltips.Drink_Crafted_Pack_Leaders_Bone_Broth; forcedContainer = 'long' }; -- Pack Leader's Bone Broth-- Vendor Food & Drink
    [66551] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds'; tooltip = Tooltips.Food_Vendor_Health; forcedContainer = 'long' }; -- Vendor Health Food
    [66568] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds'; tooltip = Tooltips.Food_Vendor_Magicka; forcedContainer = 'long' }; -- Vendor Magicka Food
    [66576] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds'; tooltip = Tooltips.Food_Vendor_Stamina; forcedContainer = 'long' }; -- Vendor Stamina Food
    [66586] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Health_Recovery); tooltip = Tooltips.Drink_Vendor_Health; forcedContainer = 'long' }; -- Vendor Health Drink
    [66590] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Magicka_Recovery); tooltip = Tooltips.Drink_Vendor_Magicka; forcedContainer = 'long' }; -- Vendor Magicka Drink
    [66594] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Stamina_Recovery); tooltip = Tooltips.Drink_Vendor_Stamina; forcedContainer = 'long' }; -- Vendor Stamina Drink-- AVA Food & Drink
    [72961] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_bar.dds'; name = Abilities.Food_Magicka_Stamina_Increase; tooltip = Tooltips.Food_Cyrodilic_Field_Bar; forcedContainer = 'long' }; -- Cyrodilic Field Bar
    [72956] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tack.dds'; name = Abilities.Food_Health_Stamina_Increase; tooltip = Tooltips.Food_Cyrodilic_Field_Tack; forcedContainer = 'long' }; -- Cyrodilic Field Tack
    [72959] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_treat.dds'; name = Abilities.Food_Health_Magicka_Increase; tooltip = Tooltips.Food_Cyrodilic_Field_Treat; forcedContainer = 'long' }; -- Cyrodilic Field Treat
    [72971] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tonic.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Magicka_Stamina_Recovery); tooltip = Tooltips.Drink_Cyrodilic_Field_Tonic; forcedContainer = 'long' }; -- Cyrodilic Field Tonic
    [72965] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_brew.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Health_Stamina_Recovery); tooltip = Tooltips.Drink_Cyrodilic_Field_Brew; forcedContainer = 'long' }; -- Cyrodilic Field Brew
    [72968] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tea.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Drink_Increase, Abilities.Drink_Health_Magicka_Recovery); tooltip = Tooltips.Drink_Cyrodilic_Field_Tea; forcedContainer = 'long' }; -- Cyrodilic Field Tea-- Crown Food & Drink
    [85484] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_crate_food.dds'; name = Abilities.Food_Crown_Crate_Meal; tooltip = Tooltips.Food_Crown_Crate_Meal; forcedContainer = 'long' }; -- Crown Crate Fortifying Meal
    [68411] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_food.dds'; name = Abilities.Food_Crown_Meal; tooltip = Tooltips.Food_Crown_Meal; forcedContainer = 'long' }; -- Crown Fortifying Meal
    [85497] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_crate_drink.dds'; name = Abilities.Drink_Crown_Crate_Drink; tooltip = Tooltips.Drink_Crown_Crate_Drink; forcedContainer = 'long' }; -- Crown Crate Refreshing Drink
    [68416] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_drink.dds'; name = Abilities.Drink_Crown_Drink; tooltip = Tooltips.Drink_Crown_Drink; forcedContainer = 'long' }; -- Crown Refreshing Drink
    [92435] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_magickahealth_food.dds'; name = Abilities.Food_Crown_Combat_Mystics_Stew; tooltip = Tooltips.Food_Crown_Combat_Mystics_Stew; forcedContainer = 'long' }; -- Crown Combat Mystic's Stew
    [92474] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_staminahealth_food.dds'; name = Abilities.Food_Crown_Vigorous_Ragout; tooltip = Tooltips.Food_Crown_Vigorous_Ragout; forcedContainer = 'long' }; -- Crown Vigorous Ragout
    [92433] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_magickahealth_drink.dds'; name = Abilities.Drink_Crown_Stout_Magic_Liqueur; tooltip = Tooltips.Drink_Crown_Stout_Magic_Liqueur; forcedContainer = 'long' }; -- Crown Stout Magic Liqueur
    [92476] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_staminahealth_drink.dds'; name = Abilities.Drink_Crown_Vigorous_Tincture; tooltip = Tooltips.Drink_Crown_Vigorous_Tincture; forcedContainer = 'long' }; -- Crown Vigorous Tincture
    ----------------------------------------------------------------
    -- Experience Consunables
    ----------------------------------------------------------------

    -- Experience Bonuses

    [64210] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_psijic_ambrosia.dds'; name = Abilities.Experience_Psijic_Ambrosia; tooltip = Tooltips.Experience_Psijic_Ambrosia; forcedContainer = 'long' }; -- Psijic Ambrosia
    [89683] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_aetherial_ambrosia.dds'; name = Abilities.Experience_Aetherial_Ambrosia; tooltip = Tooltips.Experience_Aetherial_Ambrosia; forcedContainer = 'long' }; -- Aetherial Ambrosia
    [88445] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_mythic_aetherial_ambrosia.dds'; name = Abilities.Experience_Mythic_Ambrosia; tooltip = Tooltips.Experience_Mythic_Aetherial_Ambrosia; forcedContainer = 'long' }; -- Mythic Aetherial Ambrosia
    [66776] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_scroll.dds'; name = Abilities.Experience_Crown_Scroll; tooltip = Tooltips.Experience_Crown; forcedContainer = 'long' }; -- Crown Experience Scroll
    [85501] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_1.dds'; name = Abilities.Experience_Crown_Crate_Scroll_1; tooltip = Tooltips.Experience_Gold_Coast; forcedContainer = 'long' }; -- Gold Coast Experience Scroll
    [85502] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_2.dds'; name = Abilities.Experience_Crown_Crate_Scroll_2; tooltip = Tooltips.Experience_Major_Gold_Coast; forcedContainer = 'long' }; -- Major Gold Coast Experience Scroll
    [85503] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_3.dds'; name = Abilities.Experience_Crown_Crate_Scroll_3; tooltip = Tooltips.Experience_Grand_Gold_Coast; forcedContainer = 'long' }; -- Grand Gold Coast Experience Scroll-- Alliance War Bonuses
    [147466] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_alliance_war_1.dds'; name = Abilities.Experience_Alliance_War_Skill_1; tooltip = Tooltips.Experience_Alliance_War_Skill; forcedContainer = 'long' }; -- Alliance Skill Gain (Alliance War Skill Line Scroll)
    [137733] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_alliance_war_2.dds'; name = Abilities.Experience_Alliance_War_Skill_2; tooltip = Tooltips.Experience_Alliance_War_Skill_Major; forcedContainer = 'long' }; -- Alliance Skill Gain (Alliance War Skill Line Scroll, Major)
    [147467] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_alliance_war_3.dds'; name = Abilities.Experience_Alliance_War_Skill_3; tooltip = Tooltips.Experience_Alliance_War_Skill_Grand; forcedContainer = 'long' }; -- Alliance Skill Gain (Alliance War Skill Line Scroll, Grand)
    [147687] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_alliance_war_torte_1.dds'; name = Abilities.Experience_Alliance_War_Torte_1; tooltip = Tooltips.Experience_Colovian_War_Torte; forcedContainer = 'long' }; -- Alliance Skill Gain 50% Boost (Colovian War Torte)
    [147733] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_alliance_war_torte_2.dds'; name = Abilities.Experience_Alliance_War_Torte_2; tooltip = Tooltips.Experience_Molten_War_Torte; forcedContainer = 'long' }; -- Alliance Skill Gain 100% Boost (Molten War Torte)
    [147734] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_alliance_war_torte_3.dds'; name = Abilities.Experience_Alliance_War_Torte_3; tooltip = Tooltips.Experience_White_Gold_War_Torte; forcedContainer = 'long' }; -- Alliance Skill Gain 150% Boost (White-Gold War Torte)

    ----------------------------------------------------------------
    -- Housing Items
    ----------------------------------------------------------------

    -- Target Dummy
    [89977] = { hide = true }; -- Target Skeleton (Target Dummy)

    -- Attunable Crafting Station
    [206063] = { icon = 'LuiExtended/media/icons/abilities/ability_item_create_station_jewelry.dds'; name = Abilities.Innate_Create_Station }; -- CreateAttunableStation (Attunable Crafting Station)

    ----------------------------------------------------------------
    -- Target Iron Atronach, Trial
    ----------------------------------------------------------------

    -- Debuffs
    [120007] = { icon = 'LuiExtended/media/icons/glyphs/glyph_crushing.dds'; tooltip = Tooltips.Generic_Reduce_Physical_Spell_Resist_No_Dur }; -- Crusher (Target Iron Atronach, Trial)
    [120011] = { tooltip = Tooltips.Skill_Engulfing_Flames_Dummy }; -- Engulfing Flames (Target Iron Atronach, Trial)
    [120018] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds'; name = Abilities.Set_Line_Breaker; tooltip = Tooltips.Generic_Reduce_Physical_Spell_Resist_No_Dur_Value; tooltipValue2 = 3010 }; -- Roar of Alkosh (Target Iron Atronach, Trial)
    [120014] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Target Iron Atronach, Trial)-- Buffs
    [120020] = { hide = true }; -- Minor Toughness (Target Iron Atronach, Trial)
    [120021] = { tooltip = Tooltips.Skill_War_Horn_Dummy }; -- Aggressive Horn (Target Iron Atronach, Trial)
    [120024] = { icon = 'LuiExtended/media/icons/abilities/ability_set_worm_cult.dds'; tooltip = Tooltips.Generic_Increase_Magicka_Recovery_No_Dur; tooltipValue2 = 145 }; -- Worm's Raiment (Target Iron Atronach, Trial)
    [120026] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds'; tooltip = Tooltips.Generic_Increase_Stamina_Recovery_No_Dur; tooltipValue2 = 145 }; -- Hircine's Veneer (Target Iron Atronach, Trial)
    ----------------------------------------------------------------
    -- Misc Items
    ----------------------------------------------------------------

    -- Item Combination
    [88449] = { hide = true }; -- Create Super Psijic Ambrosia (Aetheric Cipher)
    [88451] = { icon = 'LuiExtended/media/icons/abilities/ability_item_aetheric_cipher.dds'; name = Abilities.Innate_Aetheric_Cipher }; -- 88449 Stun (Aetheric Cipher)

    --[[ -- TODO: Big-Eared Ginger Kitten Casts replaced - check later
    [-----] = { icon = "LuiExtended/media/icons/abilities/ability_item_big_eared_ginger_kitten.dds", name = Abilities.Innate_Big_Eared_Ginger_Kitten, },
    ]]

    [148050] = { hide = true }; -- Alliance Breton Terrier (Breton Terrier Mammoth Bone)
    [148052] = { icon = 'LuiExtended/media/icons/abilities/ability_item_breton_terrier_mammoth_bone.dds'; name = Abilities.Innate_Breton_Terrier_Mammoth_Bone }; -- 68235 Stun (Breton Terrier Mammoth Bone)
    [147793] = { hide = true }; -- Create 100% AvA Skill Boost R (Chef Arquitius's Torte Dissertation)
    [147795] = { icon = 'LuiExtended/media/icons/abilities/ability_item_chef_arquitius_torte_dissertation.dds'; name = Abilities.Innate_Chef_Arquitius_Torte_Dissertation }; -- 88449 Stun (Chef Arquitius's Torte Dissertation)
    [147841] = { hide = true }; -- Create 150% AvA Skill Boost R (Chef Arquitius's Lost Thesis)
    [147850] = { icon = 'LuiExtended/media/icons/abilities/ability_item_chef_arquitius_lost_thesis.dds'; name = Abilities.Innate_Chef_Arquitius_Lost_Thesis }; -- 88449 Stun (Chef Arquitius's Lost Thesis)

    --[[ -- TODO: Dwarven Theodolite Casts replaced - check later
    [-----] = { icon = "LuiExtended/media/icons/abilities/ability_item_dwarven_theodolite.dds", name = Abilities.Innate_Dwarven_Theodolite, },
    ]]

    [117532] = { icon = 'LuiExtended/media/icons/abilities/ability_item_guar_stomp.dds'; name = Abilities.Innate_Guar_Stomp }; -- 68235 Stun (Guar Stomp Elucidating Hand-Sculpture)
    [117558] = { icon = 'LuiExtended/media/icons/abilities/ability_item_guar_stomp.dds'; name = Abilities.Innate_Guar_Stomp }; -- 68235 Stun (Guar Stomp History in Street Theatre)
    [117554] = { icon = 'LuiExtended/media/icons/abilities/ability_item_guar_stomp.dds'; name = Abilities.Innate_Guar_Stomp }; -- 68235 Stun (Guar Stomp Illustrated Reports)
    [117550] = { icon = 'LuiExtended/media/icons/abilities/ability_item_guar_stomp.dds'; name = Abilities.Innate_Guar_Stomp }; -- 68235 Stun (Guar Stomp Noise Reports)
    [117545] = { icon = 'LuiExtended/media/icons/abilities/ability_item_guar_stomp.dds'; name = Abilities.Innate_Guar_Stomp }; -- 68235 Stun (Guar Stomp Rehearsal Tuning Fork)
    [117562] = { icon = 'LuiExtended/media/icons/abilities/ability_item_guar_stomp.dds'; name = Abilities.Innate_Guar_Stomp }; -- 68235 Stun (Guar Stomp Skeletal Reconstruction)
    [117541] = { icon = 'LuiExtended/media/icons/abilities/ability_item_guar_stomp.dds'; name = Abilities.Innate_Guar_Stomp }; -- 68235 Stun (Guar Stomp Steps-Practice Rug)
    [70582] = { hide = true }; -- Roll 1d1000 (Merethic Restorative Resin)
    [70584] = { icon = 'LuiExtended/media/icons/abilities/ability_item_merethic_restorative_resin.dds'; name = Abilities.Innate_Merethic_Restorative_Resin }; -- 68235 Stun (Merethic Restorative Resin)
    [123110] = { icon = 'LuiExtended/media/icons/abilities/ability_item_mummified_alfiq_parts.dds'; name = Abilities.Innate_Mummified_Alfiq_Parts }; -- 68235 Stun (Mummified Alfiq Parts)
    [123115] = { icon = 'LuiExtended/media/icons/abilities/ability_item_plague_drenched_fabric.dds'; name = Abilities.Innate_Plague_Drenched_Fabric }; -- 68235 Stun (Plague-Drenched Fabric)
    [68259] = { icon = 'LuiExtended/media/icons/abilities/ability_item_psijic_ambrosia_fragment.dds'; name = Abilities.Innate_Create_Psijic_Ambrosia_Recipe }; -- 68235 Stun (Psijic Ambrosia Recipe, Fragment I)
    [68263] = { icon = 'LuiExtended/media/icons/abilities/ability_item_psijic_ambrosia_fragment.dds'; name = Abilities.Innate_Create_Psijic_Ambrosia_Recipe }; -- 68235 Stun (Psijic Ambrosia Recipe, Fragment II)
    [68267] = { icon = 'LuiExtended/media/icons/abilities/ability_item_psijic_ambrosia_fragment.dds'; name = Abilities.Innate_Create_Psijic_Ambrosia_Recipe }; -- 68235 Stun (Psijic Ambrosia Recipe, Fragment III)
    [68271] = { icon = 'LuiExtended/media/icons/abilities/ability_item_psijic_ambrosia_fragment.dds'; name = Abilities.Innate_Create_Psijic_Ambrosia_Recipe }; -- 68235 Stun (Psijic Ambrosia Recipe, Fragment IV)
    [68275] = { icon = 'LuiExtended/media/icons/abilities/ability_item_psijic_ambrosia_fragment.dds'; name = Abilities.Innate_Create_Psijic_Ambrosia_Recipe }; -- 68235 Stun (Psijic Ambrosia Recipe, Fragment V)
    [68279] = { icon = 'LuiExtended/media/icons/abilities/ability_item_psijic_ambrosia_fragment.dds'; name = Abilities.Innate_Create_Psijic_Ambrosia_Recipe }; -- 68235 Stun (Psijic Ambrosia Recipe, Fragment VI)
    [68283] = { icon = 'LuiExtended/media/icons/abilities/ability_item_psijic_ambrosia_fragment.dds'; name = Abilities.Innate_Create_Psijic_Ambrosia_Recipe }; -- 68235 Stun (Psijic Ambrosia Recipe, Fragment VII)
    --[[ -- TODO: Psijic Glowglobe Casts replaced - check later
    [-----] = { icon = "LuiExtended/media/icons/abilities/ability_item_psijic_glowglobe.dds", name = Abilities.Innate_Psijic_Glowglobe, },
    ]]

    --[[ -- TODO: Sixth House Robe Casts replaced - check later
    [-----] = { icon = "LuiExtended/media/icons/abilities/ability_item_sixth_house_robe.dds", name = Abilities.Innate_Sixth_House_Robe, },
    ]]
    --

    [140542] = { hide = true }; -- Stone Warrior Target Dummy (Stone Husk Fragment)
    [140544] = { icon = 'LuiExtended/media/icons/abilities/ability_item_stone_husk_fragment.dds'; name = Abilities.Innate_Stone_Husk_Fragment }; -- 68235 Stun (Stone Husk Fragment)
    [111141] = { icon = 'LuiExtended/media/icons/abilities/ability_item_swamp_jelly.dds'; name = Abilities.Innate_Swamp_Jelly }; -- 68235 Stun (Swamp Jelly Carrying Jar)
    [111129] = { icon = 'LuiExtended/media/icons/abilities/ability_item_swamp_jelly.dds'; name = Abilities.Innate_Swamp_Jelly }; -- 68235 Stun (Swamp Jelly Fine-Mesh Net)
    [111153] = { icon = 'LuiExtended/media/icons/abilities/ability_item_swamp_jelly.dds'; name = Abilities.Innate_Swamp_Jelly }; -- 68235 Stun (Swamp Jelly Hunter's Lense)
    [111133] = { icon = 'LuiExtended/media/icons/abilities/ability_item_swamp_jelly.dds'; name = Abilities.Innate_Swamp_Jelly }; -- 68235 Stun (Swamp Jelly Luminous Fishmeal)
    [111137] = { icon = 'LuiExtended/media/icons/abilities/ability_item_swamp_jelly.dds'; name = Abilities.Innate_Swamp_Jelly }; -- 68235 Stun (Swamp Jelly Luring Flute)
    [111149] = { icon = 'LuiExtended/media/icons/abilities/ability_item_swamp_jelly.dds'; name = Abilities.Innate_Swamp_Jelly }; -- 68235 Stun (Swamp Jelly Moss Bedding)
    [111145] = { icon = 'LuiExtended/media/icons/abilities/ability_item_swamp_jelly.dds'; name = Abilities.Innate_Swamp_Jelly }; -- 68235 Stun (Swamp Jelly Spawning Mud)
    [110871] = { hide = true }; -- Roll 1d10000 (Welkynar Binding)
    [110890] = { icon = 'LuiExtended/media/icons/abilities/ability_item_welkynar_binding.dds'; name = Abilities.Innate_Welkynar_Binding }; -- 68235 Stun (Welkynar Binding)-- Collectible Fragment Combination
    [151843] = { icon = 'LuiExtended/media/icons/abilities/ability_item_deadlands_firewalker.dds'; name = Abilities.Innate_Deadlands_Firewalker }; -- 68235 Stun (Deadlands Firewalker)
    [113432] = { icon = 'LuiExtended/media/icons/abilities/ability_item_indrik_nascent.dds'; name = Abilities.Innate_Indrik_Nascent }; -- 68235 Stun (Nascent Indrik)
    [130394] = { icon = 'LuiExtended/media/icons/abilities/ability_item_indrik_spectral.dds'; name = Abilities.Innate_Indrik_Spectral }; -- 68235 Stun (Spectral Indrik)
    [131536] = { icon = 'LuiExtended/media/icons/abilities/ability_item_pet_sovereign_sow.dds'; name = Abilities.Innate_Sovereign_Sow }; -- Generic Stun & Combine (Sovereign Sow)
    [148079] = { icon = 'LuiExtended/media/icons/abilities/ability_item_unstable_morpholith.dds'; name = Abilities.Innate_Unstable_Morpholith }; -- 68235 Stun (Unstable Morpholith)-- Item Combination - Arena Gladiator's Proofs
    [111188] = { hide = true }; -- Arena Gladiator Costume (Arena Gladiator's Exultation)
    [111190] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Arena_Gladiators_Exultation }; -- 68235 Stun (Arena Gladiator's Exultation)
    [115062] = { hide = true }; -- Arena Gladiator Emote (Arena Gladiator's Mockery)
    [115064] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Arena_Gladiators_Mockery }; -- 68235 Stun (Arena Gladiator's Mockery)
    [106173] = { hide = true }; -- Arena Gladiator Helm (Arena Gladiator's Recognition)
    [106174] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Arena_Gladiators_Recognition }; -- 68235 Stun (Arena Gladiator's Recognition)
    [116414] = { hide = true }; -- Arena Gladiator Pet (Arena Gladiator's Roar)
    [116416] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Arena_Gladiators_Roar }; -- 68235 Stun (Arena Gladiator's Roar)
    [134882] = { hide = true }; -- Knights of the Circle Weapon Style Page (Knight's Rebuke)
    [134883] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Knights_Rebuke }; -- 68235 Stun (Knight's Rebuke)
    [134850] = { hide = true }; -- Knights of the Circle Armor Style Page (Knight's Resolve)
    [134851] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Knights_Resolve }; -- 68235 Stun (Knight's Resolve)
    [140620] = { hide = true }; -- Reach-Mage Ceremonial Skullcap (Reach-Mage's Ferocity)
    [140622] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Reach_Mages_Ferocity }; -- 68235 Stun (Reach-Mage's Ferocity)
    [124622] = { hide = true }; -- Alliance Standard-Bearer Emote (Alliance Standard-Bearer's License)
    [124624] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Alliance_Standard_Bearers }; -- 68235 Stun (Alliance Standard-Bearer's License)-- Item Combination - Siege of Cyrodiil Merits
    [148419] = { hide = true }; -- Reachman Emote (Siege of Cyrodiil Commendation)
    [148421] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Siege_of_Cyrodiil_Commendation }; -- 68235 Stun (Siege of Cyrodiil Commendation)
    [145214] = { hide = true }; -- Siegemaster Costume (Siege of Cyrodiil Distinction)
    [145216] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Siege_of_Cyrodiil_Distinction }; -- 68235 Stun (Siege of Cyrodiil Distinction)
    [124788] = { hide = true }; -- Arena Gladiator Helm (Siege of Cyrodiil Recognition)
    [124789] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Siege_of_Cyrodiil_Recognition }; -- 68235 Stun (Siege of Cyrodiil Recognition)
    [126708] = { hide = true }; -- Siegemaster Costume (Siege of Cyrodiil Recommendation)
    [126710] = { icon = 'LuiExtended/media/icons/abilities/ability_item_arena_gladiator.dds'; name = Abilities.Innate_Siege_of_Cyrodiil_Recommendation }; -- 68235 Stun (Siege of Cyrodiil Recommendation)

    -- Key Fragments
    [65947] = { hide = true }; -- Tooth Key (Bone Shard Trophy Vault)
    [67825] = { hide = true }; -- Tooth key (Monstrous Tooth Trophy Vault)
    [67019] = { hide = true }; -- Tiny Claw Key (Clawed Trophy Vault)
    [67033] = { hide = true }; -- Take dark ether (Ethereal Trophy Vault)
    [67034] = { hide = true }; -- Dark Ether Key (Ethereal Trophy Vault)
    [67799] = { hide = true }; -- Tiny Claw Key (Planar Armor Trophy Vault)
    [67713] = { hide = true }; -- Mark Key (Legionary Trophy Vault)
    [70301] = { hide = true }; -- Create Key (Daedric Embers Trophy Vault)
    [70283] = { hide = true }; -- Create Key (Daedric Shackle Vault)

    -- PTS Items
    [89338] = { hide = true }; -- Exquisite Furniture Tome (ALL Furniture Plan Book)
    [115175] = { hide = true }; -- Murkmire Furniture Tome (Murkmire Furniture Plan Book)

    -- Other Items
    [63427] = { icon = 'LuiExtended/media/icons/abilities/ability_item_fillet_fish.dds'; name = Abilities.Innate_Fillet_Fish }; -- Clean Fish
    [78052] = { icon = 'LuiExtended/media/icons/abilities/ability_item_pardon_edict_low.dds'; name = Abilities.Innate_Pardon_Edict_Low }; -- Minor Pardon
    [76350] = { icon = 'LuiExtended/media/icons/abilities/ability_item_pardon_edict_medium.dds'; name = Abilities.Innate_Pardon_Edict_Medium }; -- Moderate Pardon
    [76349] = { icon = 'LuiExtended/media/icons/abilities/ability_item_pardon_edict_high.dds'; name = Abilities.Innate_Pardon_Edict_High }; -- Full Pardon
    [69293] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recall.dds'; name = Abilities.Innate_Recall }; -- Sigil of Imperial Retreat
    [47270] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_ritual_of_mara.dds'; hide = true }; -- Ritual of Mara-- Seasonal Event Items
    [86792] = { icon = 'LuiExtended/media/icons/abilities/ability_item_festival_mints.dds'; name = Abilities.Consumable_Festival_Mints }; -- Eating (High Hrothgar Festival Mints)
    [86794] = { icon = 'LuiExtended/media/icons/abilities/ability_item_festival_mints.dds'; name = Abilities.Consumable_Festival_Mints; tooltip = Tooltips.Event_Festival_Mints; unbreakable = 1 }; -- Very Cold (High Hrothgar Festival Mints)
    [86739] = { icon = 'LuiExtended/media/icons/abilities/ability_item_festival_grog.dds'; name = Abilities.Consumable_Sailors_Grog }; -- Drinking (Sailor's Warning Festival Grog)
    [86740] = { icon = 'LuiExtended/media/icons/abilities/ability_item_festival_grog.dds'; name = Abilities.Consumable_Sailors_Grog; tooltip = Tooltips.Event_Festival_Grog; unbreakable = 1 }; -- Very Drunk (Sailor's Warning Festival Grog)
    [87964] = { icon = 'LuiExtended/media/icons/abilities/ability_item_dazzler_1.dds'; name = Abilities.Consumable_Sparkwreath_Dazzler }; -- Jester's Festival Illusion Daz (Sparkwreath Dazzler)
    [87965] = { icon = 'LuiExtended/media/icons/abilities/ability_item_dazzler_1.dds'; name = Abilities.Consumable_Plume_Dazzler }; -- Jester's Festival Illusion Daz (Plume Dazzler)
    [87966] = { icon = 'LuiExtended/media/icons/abilities/ability_item_dazzler_1.dds'; name = Abilities.Consumable_Spiral_Dazzler }; -- Jester's Festival Illusion Daz (Spiral Dazzler)
    [88374] = { icon = 'LuiExtended/media/icons/abilities/ability_item_dazzler_2.dds'; name = Abilities.Skill_Sparkly_Hat_Dazzler }; -- Jester's Festival Illusion Daz (Sparkly Hat Dazzler)
    [116879] = { icon = '/esoui/art/icons/event_jestersday_pie1.dds'; name = Abilities.Consumable_Revelry_Pie }; -- Alliance Pie (Revelry Pie)
    [116933] = { hide = true }; -- Covered in Pie (Revelry Pie)
    [116942] = { tooltip = Tooltips.Event_Revelry_Pie; stack = 0; unbreakable = 1 }; -- Covered in Pie (Revelry Pie)
    [116944] = { tooltip = Tooltips.Event_Revelry_Pie; stack = 0; unbreakable = 1 }; -- Covered in Pie (Revelry Pie)
    [116943] = { tooltip = Tooltips.Event_Revelry_Pie; stack = 0; unbreakable = 1 }; -- Covered in Pie (Revelry Pie)
    --[[ -- TODO: Removed at some point, did this get replaced with another ID?
    [92232] = { icon = "LuiExtended/media/icons/mementos/memento_pelinals_ferocity.dds", tooltip = Tooltips.Experience_Seasonal_Pelinal, forcedContainer = "long", }, -- Pelinal's Ferocity (Scroll of Pelinal's Ferocity)
    ]]
    --

    ----------------------------------------------------------------
    -- MEMENTOS ----------------------------------------------------
    ----------------------------------------------------------------

    ----------------------------------------------------------------
    -- EVENTS
    ----------------------------------------------------------------

    -- Annual Jubilee
    [77027] = { hide = true }; -- Anniversary Cake - Forreals (Jubilee Cake)
    [87998] = { hide = true }; -- Anniversary Cake (2nd Annual Jubilee Cake)
    [102009] = { hide = true }; -- Anniversary Cake (3rd Annual Jubilee Cake)
    [77123] = { icon = 'LuiExtended/media/icons/mementos/memento_jubilee_cake.dds'; name = Abilities.Memento_Jubliee_Cake; tooltip = Tooltips.Experience_Seasonal_Event; forcedContainer = 'long' }; -- Anniversary EXP Buff (Other Jubilee Cake)
    [118985] = { icon = 'LuiExtended/media/icons/mementos/memento_jubilee_cake.dds'; name = Abilities.Memento_Jubliee_Cake; tooltip = Tooltips.Experience_Seasonal_Event; forcedContainer = 'long' }; -- Anniversary EXP Buff (Jubilee Cake 2019)
    [136348] = { icon = 'LuiExtended/media/icons/mementos/memento_jubilee_cake.dds'; name = Abilities.Memento_Jubliee_Cake; tooltip = Tooltips.Experience_Seasonal_Event; forcedContainer = 'long' }; -- Anniversary EXP Buff (Jubilee Cake 2020)
    [152514] = { icon = 'LuiExtended/media/icons/mementos/memento_jubilee_cake.dds'; name = Abilities.Memento_Jubliee_Cake; tooltip = Tooltips.Experience_Seasonal_Event; forcedContainer = 'long' }; -- Anniversary EXP Buff (Jubilee Cake 2021)-- Jester's Festival
    [87963] = { icon = 'LuiExtended/media/icons/mementos/memento_cherry_blossom_branch.dds'; name = Abilities.Memento_Cherry_Blossom_Branch }; -- Bestowed Cherry Blossoms (Cherry Blossom Branch)
    [115681] = { icon = '/esoui/art/icons/achievement_jestersfestival_memento_noisemaker.dds'; name = Abilities.Memento_Festive_Noise_Maker }; -- Party Noise Maker (Festive Noise Maker)
    [129550] = { icon = '/esoui/art/icons/achievement_jestersfestival_memento_popper.dds'; name = Abilities.Memento_Jesters_Festival_Joke_Popper }; -- Stunned (Jester's Festival Joke Popper)
    [102077] = { icon = 'LuiExtended/media/icons/mementos/memento_jesters_scintillator.dds'; name = Abilities.Memento_Jesters_Scintillator; unbreakable = 1 }; -- Jester's Festival Scintillator (Jester's Scintillator)
    [149874] = { icon = 'LuiExtended/media/icons/mementos/memento_playful_pranksters_surprise_box.dds' }; -- Playful Prankster's Surprise Box (Playful Prankster's Surprise Box)
    [91369] = { icon = 'LuiExtended/media/icons/mementos/memento_the_pie_of_misrule.dds'; name = Abilities.Memento_The_Pie_of_Misrule; tooltip = Tooltips.Experience_Seasonal_Event; forcedContainer = 'long' }; -- Jester's Experience Boost Pie (The Pie of Misrule)
    -- New Life Festival
    --[[ -- TODO: Removed at some point, see if there is a new ID
    [-----] = { icon = "LuiExtended/media/icons/mementos/memento_bredas_magnificent_mead.dds", tooltip = Tooltips.Experience_Seasonal_Event, forcedContainer = "long", }, -- Breda's Magnificent Mead (Breda's Bottomless Mead Mug)
    ]]
    --
    [85355] = { icon = 'LuiExtended/media/icons/mementos/memento_fire_breathers_torches.dds'; name = Abilities.Memento_Fire_Breathers_Torches; unbreakable = 1 }; -- Flame Juggling (Fire-Breather's Torches)
    [85354] = { icon = 'LuiExtended/media/icons/mementos/memento_jugglers_knives.dds'; name = Abilities.Memento_Jugglers_Knives; unbreakable = 1 }; -- Dagger Juggling (Juggler's Knives)
    [86774] = { icon = '/esoui/art/icons/achievement_newlifefestival_001.dds'; name = Abilities.Memento_Mud_Ball }; -- Mudball (Mud Ball Pouch)
    [85353] = { icon = 'LuiExtended/media/icons/mementos/memento_sword_swallowers_blade.dds'; name = Abilities.Memento_Sword_Swallowers_Blade; unbreakable = 1 }; -- Sword Swallowing (Sword-Swallower's Blade)-- Tribunal Celebration Event
    [146657] = { icon = 'LuiExtended/media/icons/mementos/memento_thetys_ramarys_bait_kit.dds'; name = Abilities.Memento_Thetys_Ramarys_Bait_Kit }; -- Memento Cliff Racer Bait (Thetys Ramary's Bait Kit)
    [147634] = { hide = true }; -- Anchor (Thetys Ramary's Bait Kit)-- Witches Festival
    [111458] = { icon = 'LuiExtended/media/icons/mementos/memento_apple_bobbing_cauldron.dds' }; -- Apple-Bobbing Cauldron (Apple-Bobbing Cauldron)
    [111459] = { icon = 'LuiExtended/media/icons/mementos/memento_apple_bobbing_cauldron.dds' }; -- Apple-Bobbing Cauldron (Apple-Bobbing Cauldron)
    [125820] = { icon = 'LuiExtended/media/icons/mementos/memento_skeletal_marionette.dds'; name = Abilities.Memento_Skeletal_Marionette }; -- Witches Festival 2019 Marionette (Skeletal Marionette)
    [144790] = { icon = 'LuiExtended/media/icons/mementos/memento_throwing_bones.dds'; name = Abilities.Memento_Throwing_Bones }; --  Throw Bones (Throwing Bones)
    [144791] = { icon = 'LuiExtended/media/icons/mementos/memento_throwing_bones.dds'; name = Abilities.Memento_Throwing_Bones }; --  Throw Bones (Throwing Bones)
    [81575] = { icon = 'LuiExtended/media/icons/mementos/memento_witchmothers_whistle.dds'; name = Abilities.Memento_Witchmothers_Whistle; hide = true }; -- Event - WitchFest Cauldron (Witchmother's Whistle)
    [96118] = { icon = 'LuiExtended/media/icons/mementos/memento_witchmothers_brew.dds'; tooltip = Tooltips.Experience_Seasonal_Event; forcedContainer = 'long' }; -- Witchmother's Boon (Witchmother's Whistle)
    [84364] = { icon = '/esoui/art/icons/achievement_witchesfestival_01.dds'; unbreakable = 1; forcedContainer = 'long'; tooltip = Tooltips.Memento_Witchmothers_Brew }; -- Witchmother's Brew (Witchmother's Whistle)
    [84365] = { icon = '/esoui/art/icons/achievement_witchesfestival_01.dds'; unbreakable = 1; forcedContainer = 'long'; tooltip = Tooltips.Memento_Witchmothers_Brew }; -- Witchmother's Brew (Witchmother's Whistle)
    [84366] = { icon = '/esoui/art/icons/achievement_witchesfestival_01.dds'; unbreakable = 1; forcedContainer = 'long'; tooltip = Tooltips.Memento_Witchmothers_Brew }; -- Witchmother's Brew (Witchmother's Whistle)
    [84367] = { icon = '/esoui/art/icons/achievement_witchesfestival_01.dds'; unbreakable = 1; forcedContainer = 'long'; tooltip = Tooltips.Memento_Witchmothers_Brew }; -- Witchmother's Brew (Witchmother's Whistle)
    [84368] = { icon = '/esoui/art/icons/achievement_witchesfestival_01.dds'; unbreakable = 1; forcedContainer = 'long'; tooltip = Tooltips.Memento_Witchmothers_Brew }; -- Witchmother's Brew (Witchmother's Whistle)
    [84369] = { icon = '/esoui/art/icons/achievement_witchesfestival_01.dds'; unbreakable = 1; forcedContainer = 'long'; tooltip = Tooltips.Memento_Witchmothers_Brew }; -- Witchmother's Brew (Witchmother's Whistle)

    ----------------------------------------------------------------
    -- FACTION & PROLOGUE QUESTS
    ----------------------------------------------------------------

    -- Aldmeri Dominion
    [39245] = { icon = 'LuiExtended/media/icons/mementos/memento_discourse_amaranthine.dds'; name = Abilities.Memento_Discourse_Amaranthine; unbreakable = 1; tooltip = Tooltips.Memento_Discourse_Amaranthine }; -- Glimpse of the Forbidden (Discourse Amaranthine)
    [41948] = { icon = 'LuiExtended/media/icons/mementos/memento_glanirs_smoke_bomb.dds' }; -- Glanir's Smoke Bomb (Glanir's Smoke Bomb)
    [42105] = { icon = 'LuiExtended/media/icons/mementos/memento_nanwens_sword.dds' }; -- Nanwen's Sword (Nanwen's Sword)
    [42008] = { icon = 'LuiExtended/media/icons/mementos/memento_token_of_root_sunder.dds'; name = Abilities.Memento_Token_of_Root_Sunder; unbreakable = 1; tooltip = Tooltips.Memento_Token_of_Root_Sunder }; -- Blessing of Root Sunder (Token of Root Sunder)-- Daggerfall Covenant
    [41988] = { icon = 'LuiExtended/media/icons/mementos/memento_bonesnap_binding_stone.dds'; unbreakable = 1; tooltip = Tooltips.Memento_Bonesnap_Binding_Talisman }; -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [41950] = { icon = 'LuiExtended/media/icons/mementos/memento_fetish_of_anger.dds'; tooltip = Tooltips.Memento_Fetish_of_Anger; unbreakable = 1 }; -- Fetish of Anger (Fetish of Anger)
    [21226] = { icon = 'LuiExtended/media/icons/mementos/memento_finvirs_trinket.dds'; tooltip = Tooltips.Memento_Finvirs_Trinket; unbreakable = 1 }; -- Finvir's Trinket (Finvir's Trinket)
    [42053] = { icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds'; name = Abilities.Memento_Yokudan_Totem; unbreakable = 1 }; -- Yokudan Salute (Yokudan Totem)-- Ebonheart Pact
    [26829] = { icon = 'LuiExtended/media/icons/mementos/memento_almalexias_enchanted_lantern.dds'; name = Abilities.Memento_Almalexias_Lantern; unbreakable = 1; tooltip = Tooltips.Memento_Almalexias_Lantern }; -- Light of the Tribunal (Almalexia's Enchanted Lantern)
    [16846] = { icon = 'LuiExtended/media/icons/mementos/memento_blackfeather_court_whistle.dds'; hide = true }; -- Blackfeather Court Whistle (Blackfeather Court Whistle)
    [25703] = { hide = true }; -- Justal's Falcon (Justal's Falcon)
    [43700] = { hide = true; icon = 'LuiExtended/media/icons/mementos/memento_lenas_wand_of_finding.dds'; name = Abilities.Menento_Lenas_Wand_of_Finding }; -- Wand of Finding (Lena's Wand of Finding)
    [43702] = { hide = true }; -- Invis Chicken Delay (Lena's Wind of Finding)
    [43703] = { hide = true }; -- Extracting... (Lena's Wind of Finding)
    [43704] = { hide = true }; -- Extracting... (Lena's Wind of Finding)
    [43701] = { hide = true }; -- Extracting... (Lena's Wind of Finding)
    [26339] = { icon = 'LuiExtended/media/icons/mementos/memento_questionable_meat_sack.dds'; name = Abilities.Memento_Mystery_Meat; unbreakable = 1; tooltip = Tooltips.Memento_Mystery_Meat }; -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = { icon = 'LuiExtended/media/icons/mementos/memento_sanguines_goblet.dds'; name = Abilities.Memento_Sanguines_Goblet; unbreakable = 1; tooltip = Tooltips.Memento_Sanguines_Goblet }; -- Sanguine's Goblet (Sanguine's Goblet)-- Coldharbour
    [42076] = { icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds'; name = Abilities.Memento_Sealing_Amulet; unbreakable = 1 }; -- Tear (Mezha-dro's Sealing Amulet)-- Cyrodiil
    [34578] = { icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds'; unbreakable = 1 }; -- Nirnroot Wine (Nirnroot Wine)-- Prologue Quests
    [149879] = { icon = 'LuiExtended/media/icons/mementos/memento_daedric_unwarding_amulet.dds' }; -- Daedric Unwarding Amulet (Daedric Unwarding Amulet)
    [125817] = { icon = 'LuiExtended/media/icons/mementos/memento_dragonhorn_curio.dds'; name = Abilities.Memento_Dragonhorn_Curio }; -- U24 Teaser Dragon Horn (Dragonhorn Curio)
    [89550] = { icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds'; name = Abilities.Memento_Twilight_Shard; unbreakable = 1 }; -- TROPHY Azura's Light (Twilight Shard)
    [143495] = { icon = 'LuiExtended/media/icons/mementos/memento_reliquary_of_dark_designs.dds' }; -- Reliquary of Dark Designs (Reliquary of Dark Designs)
    [144417] = { hide = true }; -- Reliquary of Dark Designs (Reliquary of Dark Designs)

    ----------------------------------------------------------------
    -- DLC & CHAPTERS
    ----------------------------------------------------------------

    -- Orsinium
    [73685] = { hide = true }; -- Rkindaleft Trophy (Hidden Pressure Vent)
    [74151] = { icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds'; name = Abilities.Memento_Hidden_Pressure_Vent; unbreakable = 1 }; -- Stun (Hidden Pressure Vent)
    [73686] = { hide = true; icon = 'LuiExtended/media/icons/mementos/memento_malacaths_wrathful_flame.dds'; name = Abilities.Memento_Malacaths_Wrathful_Flame }; -- Old Orsinium Trophy (Malacath's Wrathful Flame)
    [74232] = { hide = true }; -- Stun (Malacath's Wrathful Flame)-- Thieves Guild
    [77785] = { hide = true }; -- Rain of Coins (Coin of Illusory Riches)
    [77786] = { icon = 'LuiExtended/media/icons/mementos/memento_coin_of_illusory_riches.dds'; name = Abilities.Memento_Coin_of_Illusory_Riches; unbreakable = 1 }; -- Stun (Coin of Illusory Riches)-- Dark Brotherhood
    [79510] = { icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds'; name = Abilities.Memento_Blade_of_the_Blood_Oath; unbreakable = 1 }; -- TROPHY Blood Oath (Blade of the Blood Oath)-- Morrowind
    [92862] = { hide = true; icon = 'LuiExtended/media/icons/mementos/memento_dreamers_chime.dds'; name = Abilities.Memento_Dreamers_Chime; unbreakable = 1 }; -- Dreamers Chime (Ringing Bell)
    [92863] = { hide = true }; -- Dreamers Chime (Stun)-- Elsweyr
    [119099] = { icon = 'LuiExtended/media/icons/mementos/memento_brittle_burial_urn.dds' }; -- Brittle Burial Urn (Brittle Burial Urn)
    [119107] = { icon = 'LuiExtended/media/icons/mementos/memento_winnowing_plague_decoction.dds'; hide = true; name = Abilities.Memento_Winnowing_Plague_Decoction }; -- NAME ME Infect Brew (Winnowing Plague Decoction)-- Scalebreaker
    [125816] = { icon = 'LuiExtended/media/icons/mementos/memento_corruption_of_maarselok.dds'; name = Abilities.Memento_Corruption_of_Maarselok }; -- Maarselok Corruption Memento (Corruption of Maarselok)-- Greymoor
    [136120] = { icon = 'LuiExtended/media/icons/mementos/memento_ritual_circle_totem.dds' }; -- Ritual Circle Totem (Ritual Circle Totem)-- Stonethorn
    [137919] = { icon = 'LuiExtended/media/icons/mementos/memento_mostly_stable_juggling_potions.dds'; name = Abilities.Memento_Mostly_Stable_Juggling_Potions }; -- Juggling Potion Bottles (Mostly Stable Juggling Potions)-- Markarth
    [147598] = { icon = 'LuiExtended/media/icons/mementos/memento_void_shard.dds' }; --  Void Shard (Void Shard)
    [147688] = { hide = true }; -- Void Shard (Void Shard)-- Flames of Ambition
    [149881] = { icon = 'LuiExtended/media/icons/mementos/memento_illusory_salamander_stone.dds' }; -- Illusory Salamander Stone (Illusory Salamander Stone)
    [151256] = { hide = true }; -- Illusory Salamander Stone (Illusory Salamander Stone)-- Blackwood
    [153758] = { icon = 'LuiExtended/media/icons/mementos/memento_full_scale_golden_anvil_replica.dds'; name = Abilities.Memento_Full_Scale_Golden_Anvil_Replica }; -- Golden Anvil Replica (Full-Scale Golden Anvil Replica)
    [146744] = { icon = 'LuiExtended/media/icons/mementos/memento_temperamental_grimoire.dds' }; -- Temperamental Grimoire (Temperamental Grimoire)
    [153760] = { icon = 'LuiExtended/media/icons/mementos/memento_wilting_weed_killer_phial.dds' }; -- Wilting Weed Killer Phial (Wilting Weed Killer Phial)

    ----------------------------------------------------------------
    -- CROWN CRATES
    ----------------------------------------------------------------

    -- Crown Crates - Storm Atronach Crate
    [85344] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_aura.dds'; name = Abilities.Memento_Storm_Atronach_Aura; tooltip = Tooltips.Memento_Storm_Atronach_Aura; unbreakable = 1 }; -- Atronach Aura (Storm Atronach Aura)
    [85349] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_transform.dds'; name = Abilities.Memento_Storm_Atronach_Transform; tooltip = Tooltips.Memento_Storm_Atronach_Transform; unbreakable = 1 }; -- Storm Atronach Transform (Atronach Transformation)
    [85347] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds'; name = Abilities.Memento_Storm_Orb_Juggle; unbreakable = 1 }; -- Storm Orb Juggle (Atronach Juggling)-- Crown Crates - Wild Hunt Crate
    [86976] = { icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_leaf-dance_aura.dds'; name = Abilities.Memento_Wild_Hunt_Aura; tooltip = Tooltips.Memento_Wild_Hunt_Leaf_Dance_Aura; unbreakable = 1 }; -- Spriggan Aura (Wild Hunt Leaf-Dance Aura)
    [86977] = { icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_transform.dds'; name = Abilities.Memento_Wild_Hunt_Transform; tooltip = Tooltips.Memento_Wild_Hunt_Transform; unbreakable = 1 }; -- Spriggan Transformation (Wild Hunt Transform)
    [86978] = { icon = 'LuiExtended/media/icons/mementos/memento_floral_swirl_aura.dds'; name = Abilities.Memento_Floral_Swirl_Aura; tooltip = Tooltips.Memento_Floral_Swirl_Aura; unbreakable = 1 }; -- Grand Spriggan Aura (Floral Swirl Aura)
    -- Crown Crates - Dwarven Crate
    [92866] = { icon = 'LuiExtended/media/icons/mementos/memento_dwarven_puzzle_orb.dds'; name = Abilities.Memento_Dwarven_Puzzle_Orb; unbreakable = 1; tooltip = Tooltips.Memento_Dwarven_Puzzle_Orb }; -- Dwarven Globe (Dwarven Puzzle Orb)
    [92867] = { icon = 'LuiExtended/media/icons/mementos/memento_dwarven_tonal_forks.dds'; name = Abilities.Memento_Dwarven_Tonal_Forks; unbreakable = 1; tooltip = Tooltips.Memento_Dwarven_Tonal_Forks }; -- Dwarven Tuning Forks (Dwarven Tonal Forks)
    [92868] = { icon = 'LuiExtended/media/icons/mementos/memento_dwemervamidium_mirage.dds'; name = Abilities.Memento_Dwemervamidium_Mirage; unbreakable = 1; tooltip = Tooltips.Memento_Dwemervamidium_Mirage }; -- Dwarven Transformation (Dwemervamidium Mirage)
    -- Crown Crates - Reaper's Harvest Crate
    [97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds'; name = Abilities.Memento_Crows_Calling; unbreakable = 1 }; -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [97274] = { icon = '/esoui/art/icons/achievement_update16_017.dds'; name = Abilities.Memento_Swarm_of_Crows; unbreakable = 1; tooltip = Tooltips.Memento_Swarm_of_Crows }; -- Swarm of Crows (Swarm of Crows)
    [98378] = { hide = true }; -- Murderous Strike (Murderous Strike)-- Crown Crates - Flame Atronach Crate
    [99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds'; name = Abilities.Memento_Fiery_Orb; unbreakable = 1 }; -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    [99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds'; name = Abilities.Memento_Flame_Pixie; unbreakable = 1 }; -- Flame Crate Memento 2 (Flame Pixie)
    [99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds'; name = Abilities.Memento_Flame_Eruption; unbreakable = 1 }; -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    -- Crown Crates - Scalecaller Crate
    [101874] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_frost_shard.dds'; name = Abilities.Memento_Frost_Shard; unbreakable = 1 }; -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    [101877] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_rune_of_levitation.dds'; name = Abilities.Memento_Rune_of_Levitation; unbreakable = 1 }; -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    [101872] = { icon = 'LuiExtended/media/icons/mementos/memento_bone_dragon_summons_focus.dds'; name = Abilities.Memento_Dragon_Summons_Focus; unbreakable = 1 }; -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    -- Crown Crates - Psijic Vault Crate
    [104324] = { icon = 'LuiExtended/media/icons/mementos/memento_psijic_celestial_orb.dds'; name = Abilities.Memento_Psijic_Celestial_Orb; unbreakable = 1 }; -- Psijic Pearl Summon (Psijic Celestial Orb)
    [104323] = { icon = 'LuiExtended/media/icons/mementos/memento_psijic_tautology_glass.dds'; name = Abilities.Memento_Psijic_Tautology_Glass; unbreakable = 1 }; -- Psijic Hourglass (Psijic Tautology Glass)
    [104325] = { icon = 'LuiExtended/media/icons/mementos/memento_sapiarchic_discorporation_lens.dds'; name = Abilities.Memento_Sapiarchic_Discorporation; unbreakable = 1; hide = true }; -- Psijic Disintegrate (Sapiarchic Discorporation Lens)
    -- Crown Crates - Hollowjack Crate
    [110482] = { icon = 'LuiExtended/media/icons/mementos/memento_rind_renewing_pumpkin.dds'; unbreakable = 1 }; -- Rind-Renewing Pumpkin (Rind-Renewing Pumpkin)
    [116543] = { icon = 'LuiExtended/media/icons/mementos/memento_gourd_gallows_stump.dds'; unbreakable = 1 }; -- Gourd-Gallows Stump (Gourd-Gallows Stump)
    [110481] = { icon = 'LuiExtended/media/icons/mementos/memento_gourd_gallows_stump.dds'; unbreakable = 1 }; -- Gourd-Gallows Stump (Gourd-Gallows Stump)
    [110483] = { icon = 'LuiExtended/media/icons/mementos/memento_ghost_lantern.dds'; name = Abilities.Memento_Ghost_Lantern; unbreakable = 1; tooltip = Tooltips.Memento_Ghost_Lantern }; -- Ghost Lantern (Ghost Lantern)
    -- Crown Crates - Xanmeer Crate
    [113288] = { icon = 'LuiExtended/media/icons/mementos/memento_mire_drum.dds'; name = Abilities.Memento_Mire_Drum; unbreakable = 1 }; -- U20 Crown Memento 1 (Mire Drum)
    [113291] = { icon = 'LuiExtended/media/icons/mementos/memento_vossa_satl.dds'; name = Abilities.Memento_Vossa_Satl; unbreakable = 1 }; -- U20 Crown Memento 2 (Vossa-satl)
    -- Crown Crates - Ayleid Crate
    [151489] = { icon = 'LuiExtended/media/icons/mementos/memento_painters_easel_and_canvas.dds' }; -- Painter's Easel and Canvas (Painter's Easel and Canvas)
    [151490] = { icon = 'LuiExtended/media/icons/mementos/memento_painters_easel_and_canvas.dds' }; -- Painter's Easel and Canvas (Painter's Easel and Canvas)
    [151491] = { icon = 'LuiExtended/media/icons/mementos/memento_painters_easel_and_canvas.dds' }; -- Painter's Easel and Canvas (Painter's Easel and Canvas)
    [146752] = { icon = 'LuiExtended/media/icons/mementos/memento_phial_of_clockwork_lubricant.dds' }; -- Phial of Clockwork Lubricant (Phial of Clockwork Lubricant)

    ----------------------------------------------------------------
    -- Non-Combat Pets
    ----------------------------------------------------------------

    [76364] = { hide = true }; -- _CRWN_5s (Echalette)
    [76365] = { hide = true }; -- _CRWN_Echalette_Buck (Echalette)
    [76367] = { hide = true }; -- _CRWN_ResetPosture (Echalette)
    [76368] = { hide = true }; -- _CRWN_1s (Turquoise Nixad)
    [78642] = { hide = true }; -- _CRWN_Jackal_Mouse (Jackal)
    [78643] = { hide = true }; -- _CRWN_Jackal_Digging (Jackal)

    [72955] = { hide = true }; -- _CRWN Pet Goat,Black (Sanguine's Black Goat)
    [81352] = { hide = true }; -- _CRWN_12.5s (Spotted Snow Senche-Leopard)
    [127179] = { hide = true }; -- _Crwn Pet Doom Spawn (Mudcrab of Eternal Doom)
    [79693] = { hide = true }; -- _CRWN_ChubLoon_Bellyflop (Chub Loon)

    ----------------------------------------------------------------
    -- Other Collectibles
    ----------------------------------------------------------------

    [77645] = { hide = true }; -- Stealth (Pirharri the Smuggler)

    ----------------------------------------------------------------
    -- ITEM SETS ---------------------------------------------------
    ----------------------------------------------------------------

    ----------------------------------------------------------------
    -- Ability Altering Weapons
    ----------------------------------------------------------------

    -- Asylum Weapons
    [100474] = { icon = 'LuiExtended/media/icons/abilities/ability_set_chaotic_whirlwind.dds'; tooltip = Tooltips.Set_Asylum_Dual_Wield }; -- Chaotic Whirlwind (Asylum Dual Wield)
    [140223] = { icon = 'LuiExtended/media/icons/abilities/ability_set_chaotic_whirlwind.dds' }; -- Chaotic Whirlwind (Asylum Dual Wield)
    [100302] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_piercing_spray.dds'; tooltip = Tooltips.Set_Asylum_Bow }; -- Piercing Spray (Asylum Bow)
    [100294] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_disciplined_slash.dds' }; -- Disciplined Slash (Asylum 2H)
    [100462] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }; -- Defensive Position (Asylum 1H + Shield)
    [100464] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }; -- Defensive Position (Asylum 1H + Shield)
    [100308] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_timeless_blessing.dds'; tooltip = Tooltips.Set_Aslyum_Restoration_Staff }; -- Timeless Blessing (Asylum Restoration Staff)
    [100306] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_concentrated_force.dds'; tooltip = Tooltips.Set_Asylum_Destruction_Staff }; -- Concentrated Force (Asylum Destruction Staff)-- Maelstrom Weapons
    [99806] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_cruel_flurry.dds'; tooltip = Tooltips.Set_Maelstrom_DW }; -- Cruel Flurry (Maelstrom Dual Wield)
    [99851] = { hide = true }; -- Thunderous Volley (Maelstrom Bow)
    [99789] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_merciless_charge.dds'; tooltip = Tooltips.Set_Maelstrom_2H }; -- Merciless Charge (Maelstrom 2H)
    [100588] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds'; tooltip = Tooltips.Set_Maelstrom_1H }; -- Rampaging Slash (Maelstrom 1H + Shield)
    [100587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }; -- Rampaging Slash (Maelstrom 1H + Shield)
    [100589] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }; -- Rampaging Slash (Maelstrom 1H + Shield)
    [99887] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_precise_regeneration.dds' }; -- Precise Regeneration (Maelstrom Restoration Staff)-- Master Weapons
    [99761] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_puncturing_remedy.dds' }; -- Puncturing Remedy (Master 1H + shield)
    [100575] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_puncturing_remedy.dds'; tooltip = Tooltips.Set_Master_1H }; -- Puncturing Remedy (Master 1H + shield)
    [140334] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_destructive_impact.dds'; tooltip = Tooltips.Generic_Spell_Damage_Duration_Value; tooltipValue2 = 600 }; -- Destructive Impact (Master Destruction Staff)
    [99781] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_grand_rejuvenation.dds'; tooltip = Tooltips.Set_Master_Resto }; -- Grand Rejuvenation (Master Restoration Staff)
    [131489] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_grand_rejuvenation.dds' }; -- Grand Rejuvenation (Master Restoration Staff)-- Blackrose Weapons
    [113617] = { icon = 'LuiExtended/media/icons/abilities/ability_set_spectral_cloak.dds'; tooltip = Tooltips.Set_Blackrose_Dual_Wield }; -- Spectral Cloak (Blackrose DW)
    [113619] = { hide = true }; -- Virulent Shot (Blackrose Bow) -- SHOWS ONLY ON TARGET PLAYERS
    [113627] = { icon = 'LuiExtended/media/icons/abilities/ability_set_virulent_shot.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Virulent Shot (Blackrose Bow)
    [113553] = { icon = 'LuiExtended/media/icons/abilities/ability_set_radial_uppercut.dds' }; -- Radial Uppercut (Blackrose 2H)
    [113608] = { icon = 'LuiExtended/media/icons/abilities/ability_set_gallant_charge.dds'; tooltip = Tooltips.Set_Blackrose_1H }; -- Gallant Charge (Blackrose 1H)
    [115003] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds'; tooltip = Tooltips.Set_Blackrose_Destro_Staff }; -- Wild Impulse (Blackrose Destruction Staff)
    [114988] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }; -- Wild Impulse (Blackrose Destruction Staff)
    [115005] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }; -- Wild Impulse (Blackrose Destruction Staff)
    [115006] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }; -- Wild Impulse (Blackrose Destruction Staff)-- Vateshran Weapons
    [149423] = { icon = 'LuiExtended/media/icons/abilities/ability_set_executioners_blade.dds' }; -- Executioner's Blade (Vateshran Dual Wield)
    [147701] = { icon = 'LuiExtended/media/icons/abilities/ability_set_frenzied_momentum.dds'; tooltip = Tooltips.Set_Vateshran_2H }; -- Frenzied Momentum (Vateshran 2H)
    [147703] = { icon = 'LuiExtended/media/icons/abilities/ability_set_frenzied_momentum.dds' }; -- Frenzied Momentum (Vateshran 2H)
    [147747] = { icon = 'LuiExtended/media/icons/abilities/ability_set_void_bash.dds'; tooltip = Tooltips.Set_Vateshran_1H }; -- Call of the Void (Vateshran 1H)
    [147744] = { icon = 'LuiExtended/media/icons/abilities/ability_set_void_bash.dds' }; -- Void Bash (Vateshran 1H)
    [147743] = { icon = 'LuiExtended/media/icons/abilities/ability_set_void_bash.dds' }; -- Void Bash (Vateshran 1H)
    [147843] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wrath_of_elements.dds'; tooltip = Tooltips.Set_Vateshran_Destro_Staff; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Wrath of Elements (Vateshran Destruction Staff)
    [149413] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wrath_of_elements.dds'; tooltip = Tooltips.Set_Vateshran_Destro_Staff_Buff; stackAdd = 1; stackMax = 20 }; -- Wrath of Elements (Vateshran Destruction Staff)
    [147847] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wrath_of_elements.dds' }; -- Wrath of Elements (Vateshran Destruction Staff)
    [147844] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wrath_of_elements.dds' }; -- Wrath of Elements (Vateshran Destruction Staff)
    [147846] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wrath_of_elements.dds' }; -- Wrath of Elements (Vateshran Destruction Staff)
    [147872] = { icon = 'LuiExtended/media/icons/abilities/ability_set_force_overflow.dds'; tooltip = Tooltips.Set_Vateshran_Resto_Staff; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Force Overflow (Vateshran Restoration Staff)
    [149878] = { icon = 'LuiExtended/media/icons/abilities/ability_set_force_overflow.dds' }; -- Force Overflow (Vateshran Restoration Staff)
    [149877] = { icon = 'LuiExtended/media/icons/abilities/ability_set_force_overflow.dds' }; -- Force Overflow (Vateshran Restoration Staff)
    [147873] = { icon = 'LuiExtended/media/icons/abilities/ability_set_force_overflow.dds' }; -- Force Overflow (Vateshran Restoration Staff)
    [147879] = { icon = 'LuiExtended/media/icons/abilities/ability_set_force_overflow.dds' }; -- Force Overflow (Vateshran Restoration Staff)

    ----------------------------------------------------------------
    -- Monster Helms
    ----------------------------------------------------------------

    -- Balorgh
    [111505] = { icon = 'LuiExtended/media/icons/abilities/ability_set_balorgh.dds'; tooltip = Tooltips.Set_Balorgh }; -- Balorgh (Balorgh)
    -- Blood Spawn
    [59517] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_blood_spawn.dds'; tooltip = Tooltips.Generic_Physical_Spell_Resist_Value; tooltipValue2 = 3731 }; -- Blood Spawn (Blood Spawn)
    [61274] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_blood_spawn.dds' }; -- Blood Spawn (Blood Spawn)
    -- Bogdan the Nightflame
    [59590] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bogdan.dds'; name = Abilities.Set_Bogdan_the_Nightflame; tooltip = Tooltips.Set_Bogdan_the_Nightflame }; -- Imperial Prison Item Set (Bogdan the Nightflame)
    [59591] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bogdan.dds'; name = Abilities.Set_Bogdan_the_Nightflame; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Bogdan Totem (Bogdan the Nightflame)
    -- Chokethorn
    [81069] = { hide = true }; -- Chokethorn (Chokethorn)
    [81077] = { icon = '/esoui/art/icons/mh_hedgeguardian_strang.dds'; tooltip = Tooltips.Generic_HoT_Channel; tooltipValue2 = 1 }; -- Chokethorn (Chokethorn)
    -- Domihaus
    [97882] = { icon = 'LuiExtended/media/icons/abilities/ability_set_domihaus_fire.dds'; tooltip = Tooltips.Set_Domihaus_Damage }; -- Domihaus (Domihaus) -- TODO: Make a combined icon for this set (possibly)
    [97896] = { icon = 'LuiExtended/media/icons/abilities/ability_set_domihaus_fire.dds'; forcedContainer = 'short'; groundLabel = true; tooltip = Tooltips.Set_Domihaus_Buff }; -- Domihaus (Domihaus) -- TODO: Make a combined icon for this set (possibly)
    [97883] = { icon = 'LuiExtended/media/icons/abilities/ability_set_domihaus_fire.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Domihaus (Domihaus)
    [97899] = { icon = 'LuiExtended/media/icons/abilities/ability_set_domihaus_stone.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 1 }; -- Domihaus (Domihaus)
    -- Earthgore
    [97855] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds'; tooltip = Tooltips.Set_Earthgore }; -- Earthgore (Earthgore)
    [97857] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Earthgore (Earthgore)
    -- Grothdarr
    [84504] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_grothdarr.dds'; tooltip = Tooltips.Set_Grothdarr }; -- Grothdarr (Grothdarr)
    [84502] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_grothdarr.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Grothdarr (Grothdarr)
    -- Grundwulf
    [126529] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grundwulf_stamina.dds' }; -- Grundwulf (Grundwulf)
    [126687] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grundwulf_magicka.dds' }; -- Grundwulf (Grundwulf)
    [126688] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grundwulf_stamina.dds' }; -- Grundwulf (Grundwulf)
    [126528] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grundwulf_magicka.dds' }; -- Grundwulf (Grundwulf)
    -- Iceheart
    [80562] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_iceheart.dds'; tooltip = Tooltips.Set_Iceheart }; -- Iceheart (Iceheart)
    [80561] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_iceheart.dds' }; -- Iceheart (Iceheart)-- Ilambris
    [80527] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris.dds'; tooltip = Tooltips.Set_Ilambris }; -- Ilambris (Ilambris)
    [80526] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris.dds'; groundLabel = true; tooltip = Tooltips.Set_Ilambris_Ground; tooltipValue2 = 1 }; -- Ilambris (Ilambris)
    [80525] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris.dds' }; -- Ilambris (Ilambris)
    -- Infernal Guardian
    [83405] = { icon = 'LuiExtended/media/icons/abilities/ability_set_infernal_guardian.dds'; hide = true }; -- Infernal Guardian (Infernal Guardian)
    [83409] = { icon = 'LuiExtended/media/icons/abilities/ability_set_infernal_guardian.dds' }; -- Infernal Guardian (Infernal Guardian)
    -- Kjalnar's Nightmare
    [133505] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kjalnars_nightmare_bone.dds'; tooltip = Tooltips.Set_Kjalnars_Nightmare }; -- Bone (Kjalnar's Nightmare)
    [133538] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kjalnars_nightmare.dds' }; -- Kjalnar's Nightmare (Kjalnar's Nightmare)
    [134908] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kjalnars_nightmare.dds' }; -- Kjalnar's Nightmare (Kjalnar's Nightmare)
    [133506] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kjalnars_nightmare.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Kjalnar's Nightmare (Kjalnar's Nightmare)
    -- Kra'gh
    [80566] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_kragh.dds'; hide = true }; -- Kra'gh (Kra'gh)
    [80565] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_kragh.dds' }; -- Kra'gh (Kra'gh)
    -- Lady Thorn
    [142305] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hollowfang.dds' }; -- Sanguine Burst (Lady Thorn)
    -- Lord Warden
    [59586] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds'; name = Abilities.Set_Lord_Warden_Dusk; duration = 0; forcedContainer = 'short'; groundLabel = true; tooltip = Tooltips.Generic_Physical_Spell_Resist_No_Dur_Value; tooltipValue2 = 3180 }; -- Lord Warden (Lord Warden)
    [59587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds'; name = Abilities.Set_Lord_Warden_Dusk; tooltip = Tooltips.Set_Lord_Warden_Buff }; -- Lord Warden (Lord Warden)
    -- Malubeth
    [59568] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds'; name = Abilities.Set_Scourge_Harvester; tooltip = Tooltips.Set_Malubeth_Damage }; -- Scourge Harvest (Malubeth)
    [59573] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds'; name = Abilities.Set_Scourge_Harvester }; -- Scourge Harvest (Malubeth)-- Maarselok
    [126941] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_maarselok.dds'; tooltip = Tooltips.Set_Maarselok }; -- Maarselok (Maarselok)
    -- Maw of the Infernal
    [59508] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maw_of_the_infernal.dds'; name = Abilities.Set_Maw_of_the_Infernal; tooltip = Tooltips.Set_Maw_of_the_Infernal }; -- Banished Cells Item Set (Maw of the Infernal)
    [60974] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw_fire.dds' }; -- Jagged Claw (Maw of the Infernal)
    [60972] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Maw of the Infernal)
    [60973] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds' }; -- Fiery Jaws (Maw of the Infernal)
    -- Molag Kena
    [66808] = { icon = 'LuiExtended/media/icons/abilities/ability_set_molag_kena.dds'; tooltip = Tooltips.Set_Molag_Kena }; -- Molag Kena (Molag Kena)
    [66812] = { icon = 'LuiExtended/media/icons/abilities/ability_set_molag_kena.dds'; tooltip = Tooltips.Set_Molag_Kena_Overkill }; -- Overkill (Molag Kena)
    -- Mother Ciannait
    [133381] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mother_ciannait.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Mother Ciannait (Mother Ciannait)
    [137313] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mother_ciannait.dds' }; -- Mother Ciannait (Mother Ciannait)
    -- Nerien'eth
    [59594] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds'; name = Abilities.Set_Nerieneth; tooltip = Tooltips.Set_Nerieneth }; -- Crypt of Hearts Item Set (Nerien'eth)
    [59593] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds'; name = Abilities.Set_Nerieneth }; -- Lich Crystal (Nerien'eth)
    -- Pirate Skeleton
    [98421] = { icon = '/esoui/art/icons/achievement_housing_038.dds'; tooltip = Tooltips.Set_Pirate_Skeleton }; -- Pirate Skeleton
    [98419] = { icon = '/esoui/art/icons/achievement_housing_038.dds'; tooltip = Tooltips.Set_Pirate_Skeleton }; -- Pirate Skeleton
    [98420] = { icon = '/esoui/art/icons/achievement_housing_038.dds'; tooltip = Tooltips.Set_Pirate_Skeleton }; -- Pirate Skeleton
    [81675] = { icon = '/esoui/art/icons/achievement_housing_038.dds'; tooltip = Tooltips.Set_Pirate_Skeleton }; -- Pirate Skeleton
    [83288] = { icon = '/esoui/art/icons/achievement_housing_038.dds'; tooltip = Tooltips.Set_Pirate_Skeleton }; -- Pirate Skeleton
    [83287] = { icon = '/esoui/art/icons/achievement_housing_038.dds'; tooltip = Tooltips.Set_Pirate_Skeleton }; -- Pirate Skeleton
    -- Selene
    [80606] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_primal_maul.dds' }; -- Selene (Selene)
    [80607] = { hide = true }; -- Dummy (Selene)
    [80609] = { hide = true }; -- Dummy (Selene)-- Sellistrix
    [80545] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sellistrix.dds'; tooltip = Tooltips.Set_Sellistrix }; -- Sellistrix (Sellistrix)
    [80544] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sellistrix.dds' }; -- Sellistrix (Sellistrix)
    [80549] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sellistrix.dds'; tooltip = Tooltips.Generic_Stun }; -- Sellistrix (Sellistrix)
    -- Sentinel of Rkugamz
    [81036] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds'; hide = true; tooltip = Tooltips.Set_Sentinel_of_Rkugamz }; -- Sentinel of Rkugamz
    [81038] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds'; groundLabel = true; tooltip = Tooltips.Set_Sentinel_of_Rkugamz_Ground }; -- Sentinel of Rkugamz
    [81041] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds' }; -- Sentinel of Rkugamz
    [133239] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds' }; -- Sentinel of Rkugamz
    -- Shadowrend
    [80955] = { hide = true }; -- Shadowrend (Shadowrend)
    [80954] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_shadow_proxy.dds'; name = Abilities.Set_Shadowrend; hide = true; tooltip = Tooltips.Set_Shadowrend }; -- Shadowrend Summon (Shadowrend)
    [80980] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt_shadowrend.dds'; name = Abilities.Skill_Headbutt }; -- Shadowrend (Shadowrend)
    [80990] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_shadow_proxy.dds'; tooltip = Tooltips.Generic_Reduce_Damage_Done; tooltipValue2 = 5 }; -- Shadowrend (Shadowrend)
    [80989] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike_shadowrend.dds'; name = Abilities.Skill_Tail_Spike }; -- Shadowrend (Shadowrend)
    [81034] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_shadow_proxy.dds'; tooltip = Tooltips.Generic_Reduce_Damage_Done; tooltipValue2 = 5 }; -- Shadowrend (Shadowrend)
    -- Spawn of Mephala
    [59497] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_white.dds'; tooltip = Tooltips.Set_Spawn_of_Mephala }; -- Spawn of Mephala (Spawn of Mephala)
    [59498] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_white.dds'; name = Abilities.Set_Spawn_of_Mephala; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Poison; tooltipValue2 = 1; tooltipValue3 = 50 }; -- Mephala's Web (Spawn of Mephala)
    [59499] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_white.dds'; name = Abilities.Set_Spawn_of_Mephala; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Poison; tooltipValue2 = 1; tooltipValue3 = 50; hideGround = true }; -- Mephala's Web (Spawn of Mephala)
    -- Stonekeeper
    [116839] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stonekeeper.dds'; name = Abilities.Set_Energy_Charge; tooltip = Tooltips.Set_Energy_Charge }; -- Charging (Stonekeeper)
    [116847] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stonekeeper.dds' }; -- Stonekeeper (Stonekeeper)
    [116877] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stonekeeper.dds' }; -- Stonekeeper (Stonekeeper)
    [116878] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stonekeeper.dds' }; -- Stonekeeper (Stonekeeper)
    [116880] = { hide = true }; -- Stonekeeper (Stonekeeper)
    -- Stone Husk
    [143032] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stone_husk.dds'; tooltip = Tooltips.Set_Stone_Husk_DOT; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Stone Husk (Stone Husk)
    [143077] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stone_husk.dds' }; -- Stone Husk (Stone Husk)
    [145199] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stone_husk.dds'; tooltip = Tooltips.Set_Stone_Husk_Drain; forcedContainer = 'short' }; -- Husk Drain (Stone Husk)
    [144908] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stone_husk.dds'; tooltip = Tooltips.Set_Stone_Husk_Buff }; -- Stone Husk (Stone Husk)
    -- Stormfist
    [80523] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_enervating_stone.dds'; tooltip = Tooltips.Set_Stormfist }; -- Stormfist (Stormfist)
    [80522] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_enervating_stone.dds'; groundLabel = true; tooltip = Tooltips.Skill_Stormfist_Ground }; -- Stormfist (Stormfist)
    [80521] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_enervating_stone.dds' }; -- Stormfist (Stormfist)
    -- Swarm Mother
    [84419] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grappling_web.dds'; name = Abilities.Set_Swarm_Mother }; -- Swarm Mother Mask (Swarm Mother)
    [80593] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grappling_web.dds'; name = Abilities.Set_Swarm_Mother }; -- Swarm Mother Mask (Swarm Mother)
    -- Symphony of Blades
    [117111] = { icon = '/esoui/art/icons/achievement_depthsofmalatar_killmonstersb.dds'; tooltip = Tooltips.Set_Meridias_Favor }; -- Meridia's Favor (Symphony of Blades)
    [117118] = { icon = '/esoui/art/icons/achievement_depthsofmalatar_killmonstersb.dds' }; -- Meridia's Favor (Symphony of Blades)
    [117119] = { icon = '/esoui/art/icons/achievement_depthsofmalatar_killmonstersb.dds' }; -- Meridia's Favor (Symphony of Blades)
    -- The Engine Guardian
    [59522] = { hide = true }; -- Engine Guardian
    [59540] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_stamina.dds'; tooltip = Tooltips.Set_Engine_Guardian_Stamina }; -- Robust Engine Guardian
    [59533] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_magicka.dds'; tooltip = Tooltips.Set_Engine_Guardian_Magicka }; -- Arcane Engine Guardian
    [59543] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_health.dds'; tooltip = Tooltips.Set_Engine_Guardian_Health }; -- Healthy Engine Guardian
    -- The Troll King
    [80504] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_regeneration.dds'; name = Abilities.Set_The_Troll_King; tooltip = Tooltips.Set_The_Troll_King }; -- The Troll King
    -- Thurvokun
    [102094] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds'; groundLabel = true; tooltip = Tooltips.Set_Thurvokun_Ground }; -- Thurvokun
    [102093] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds'; tooltip = Tooltips.Set_Thurvokun }; -- Thurvokun (Thurvokun)
    -- Tremorscale
    [80865] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds' }; -- Tremorscale
    [80866] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds'; tooltip = Tooltips.Generic_Reduce_Physical_Resist_Value; tooltipValue2 = 2395 }; -- Tremorscale
    -- Valkyn Skoria
    [59596] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_meteor.dds' }; -- Valkyn Skoria
    [61273] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_meteor.dds' }; -- Valkyn Skoria
    -- Velidreth
    [80490] = { icon = 'LuiExtended/media/icons/abilities/ability_set_velidreth.dds' }; -- Velidreth
    -- Zaan
    [102136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_zaan.dds'; tooltip = Tooltips.Set_Zaan }; -- Zaan
    [102142] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_zaan.dds'; hide = true }; -- Zaan

    ----------------------------------------------------------------
    -- Mythic Items
    ----------------------------------------------------------------

    [139552] = { icon = 'LuiExtended/media/icons/abilities/ability_set_snow_treaders.dds'; tooltip = Tooltips.Set_Snow_Treaders }; -- Snow Treaders (Snow Treaders)
    [139903] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bloodlords_embrace.dds'; tooltip = Tooltips.Set_Bloodlords_Embrace }; -- Blood Curse (Bloodlord's Embrace)
    [139914] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bloodlords_embrace.dds'; name = Abilities.Set_Blood_Curse }; -- Bloodlord's Embrace (Bloodlord's Embrace)
    [136123] = { tooltip = Tooltips.Set_Thrassian_Stranglers }; -- Sload's Call (Thrassian Stranglers)
    [147415] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ring_of_the_pale_order.dds' }; -- Ring of the Pale Order (Ring of the Pale Order)
    [147462] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pearls_of_ehlnofey.dds' }; -- Pearls of Ehlnofey (Pearls of Ehlnofey)

    ----------------------------------------------------------------
    -- Armor Sets
    ----------------------------------------------------------------

    -- Crafted Sets
    [34502] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ashen_grip.dds' }; -- Ashen Grip
    [34592] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; tooltip = Tooltips.Generic_Reduce_Weapon_Damage_Duration_Value; tooltipValue2 = 300 }; -- Alessia's Bulwark
    [75746] = { icon = 'LuiExtended/media/icons/abilities/ability_set_clever_alchemist.dds'; tooltip = Tooltips.Generic_Weapon_Spell_Damage_Duration_Value; tooltipValue2 = 675 }; -- Clever Alchemist
    [33764] = { icon = 'LuiExtended/media/icons/abilities/ability_set_deaths_wind.dds'; cc = LUIE_CC_TYPE_KNOCKBACK; isPlayerAbility = true }; -- Death's Wind
    [52289] = { icon = 'LuiExtended/media/icons/abilities/ability_set_deaths_wind.dds'; tooltip = Tooltips.Generic_Knockback; cc = LUIE_CC_TYPE_KNOCKBACK; isPlayerAbility = true }; -- Death's Wind
    [75930] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds'; name = Abilities.Set_Eternal_Hunt; tooltip = Tooltips.Set_Eternal_Hunt }; -- Eternal Hunt
    [75929] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds' }; -- Eternal Hunt
    [76533] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Eternal Hunt
    [57207] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kagrenacs_hope.dds'; hide = true }; -- Kagrenac's Hope
    [99204] = { icon = '/esoui/art/icons/achievement_update16_003.dds'; tooltip = Tooltips.Set_Mechanical_Acuity }; -- Mechanical Acuity (of Mechanical Acuity)
    [71671] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_summon.dds'; hide = true; tooltip = Tooltips.Set_Morkuldin }; -- Morkuldin (Morkuldin)
    [71678] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_light_attack.dds' }; -- Morkuldin (Morkuldin)
    [71679] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_cleave.dds' }; -- Morkuldin Cleave (Morkuldin)
    [148882] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_oblivion_blue.dds'; tooltip = Tooltips.Generic_Magic; tooltipValue2 = 2 }; -- Oblivion's Foe (of Oblivion's Foe)
    [61784] = { icon = 'LuiExtended/media/icons/abilities/ability_set_redistributor.dds'; hide = true }; -- Redistributor (Redistribution)
    [49126] = { icon = 'LuiExtended/media/icons/abilities/ability_set_shalidors_curse.dds' }; -- Shalidor's Curse
    [75726] = { icon = 'LuiExtended/media/icons/abilities/ability_set_tavas_favor.dds'; tooltip = Tooltips.Set_Tavas_Favor }; -- Tava's Favor
    [61851] = { hide = true }; -- Armor Master (the Armor Master)
    [61870] = { icon = 'LuiExtended/media/icons/abilities/ability_set_armor_master.dds'; tooltip = Tooltips.Generic_Physical_Spell_Resist_Value; tooltipValue2 = 5940 }; -- Armor Master (the Armor Master)
    [61781] = { icon = 'LuiExtended/media/icons/abilities/ability_set_nobles_conquest.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Noble's Conquest
    [34587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_song_of_lamae.dds' }; -- Song of Lamae
    [34588] = { icon = 'LuiExtended/media/icons/abilities/ability_set_song_of_lamae.dds' }; -- Song of Lamae
    [79089] = { icon = '/esoui/art/icons/achievement_ic_survival.dds'; name = Abilities.Set_Varens_Legacy; tooltip = Tooltips.Set_Varens_Legacy }; -- Varen's Wall (Varen's Legacy)
    [79093] = { hide = true }; -- Remove Trigger (Varen's Legacy)
    [57170] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vampires_kiss.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Vampire's Kiss
    [49236] = { icon = 'LuiExtended/media/icons/abilities/ability_set_whitestrake.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Whitestake's Retribution (Whitestrake's)
    [106804] = { name = Abilities.Set_Nocturnals_Favor; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Nocturnal's Heal (Nocturnal's Favor)
    [106798] = { icon = '/esoui/art/icons/achievement_su_mainquest_2.dds'; tooltip = Tooltips.Set_Sloads }; -- Sload's Semblance (Sload's)
    [113092] = { icon = '/esoui/art/icons/achievement_su_mainquest_2.dds'; name = Abilities.Set_Sloads_Semblance }; -- Sload's Projectile (Sloads)
    [113181] = { icon = '/esoui/art/icons/mm_teaser.dds'; tooltip = Tooltips.Set_Grave_Stake_Collector }; -- Grave-Stake Collector (Grave-Stake Collector)
    [113185] = { icon = '/esoui/art/icons/mm_teaser.dds' }; -- Grave-Stake Collector (Grave-Stake Collector)
    [113237] = { icon = '/esoui/art/icons/mm_teaser.dds' }; -- Grave-Stake Collector (Grave-Stake Collector)--
    [124303] = { icon = '/esoui/art/icons/achievement_els_lrgzone_groupboss4.dds'; tooltip = Tooltips.Set_Senche_Rahts_Grit }; -- Senche-Raht's Grit (Senche-Raht's)
    [121915] = { icon = 'LuiExtended/media/icons/abilities/ability_set_honors_scorn.dds'; name = Abilities.Set_Honors_Scorn; tooltip = Tooltips.Set_Coldharbours_Favorite_Damage }; -- Coldharbour's Favorite (Coldharbour's Favorite)
    [121917] = { icon = 'LuiExtended/media/icons/abilities/ability_set_honors_scorn.dds'; tooltip = Tooltips.Generic_Magic; tooltipValue2 = 1 }; -- Honor's Scorn (Coldharbour's Favorite)
    [121912] = { icon = 'LuiExtended/media/icons/abilities/ability_set_honors_love.dds'; name = Abilities.Set_Honors_Love; tooltip = Tooltips.Set_Coldharbours_Favorite_Heal }; -- Coldharbour's Favorite (Coldharbour's Favorite)
    [121913] = { icon = 'LuiExtended/media/icons/abilities/ability_set_honors_love.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Honor's Love (Coldharbour's Favorite)
    [123717] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vastaries_tutelage.dds'; tooltip = Tooltips.Set_Vastaries_Tutelage }; -- Vastarie's Tutelage (Vastarie's Tutelage)
    [123715] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vastaries_tutelage.dds'; tooltip = Tooltips.Set_Vastaries_Tutelage }; -- Vastarie's Tutelage (Vastarie's Tutelage)
    [141916] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stuhns_favor.dds'; tooltip = Tooltips.Set_Stuhns_Favor; tooltipValue2 = 5312 }; -- Stuhn's Favor (Stuhn's)
    [135919] = { icon = '/esoui/art/icons/crownstore_skillline_vampire.dds' }; -- Spell Parasite (Spell Parasite's)
    [137126] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dragons_appetite.dds'; tooltip = Tooltips.Set_Dragons_Appetite; forcedContainer = 'short' }; -- Dragon's Appetite (of Dragon's Appetite)
    [135878] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dragons_appetite.dds' }; -- Dragon's Appetite (of Dragon's Appetite)
    [147390] = { icon = 'LuiExtended/media/icons/abilities/ability_set_legacy_of_karth.dds'; name = Abilities.Set_Legacy_of_Karth }; -- Karth's Rot (Karth's)-- Overland Sets (Light)
    [135938] = { icon = 'LuiExtended/media/icons/abilities/ability_set_queens_elegance.dds'; tooltip = Tooltips.Set_Queens_Elegance_LA }; -- Queen's Elegance (Elegant)
    [135939] = { icon = 'LuiExtended/media/icons/abilities/ability_set_queens_elegance.dds'; tooltip = Tooltips.Set_Queens_Elegance_HA }; -- Queen's Elegance (Elegant)
    [75691] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds'; tooltip = Tooltips.Set_Bahrahas_Curse }; -- Bahraha's Curse
    [75707] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds' }; -- Bahraha's Curse
    [75692] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds'; groundLabel = true; tooltip = Tooltips.Skill_Bahrahas_Curse_Ground }; -- Bahraha's Curse
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds'; tooltip = Tooltips.Skill_Bahrahas_Curse_Ground; groundLabel = true; hideGround = true }; -- Bahraha's Curse
    [34522] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bloodthorns_touch.dds' }; -- Bloodthorn's Touch (Bloodthorn)
    [57177] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bloodthorns_touch.dds' }; -- Bloodthorn's Touch (Bloodthorn)
    [31213] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds' }; -- Dreamer's Mantle (Dreamer's)
    [48913] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds'; tooltip = Tooltips.Generic_Knockback }; -- Dreamer's Mantle (Dreamer's)
    [57133] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds' }; -- Dreamer's Mantle (Dreamer's)
    [85776] = { icon = 'LuiExtended/media/icons/abilities/ability_set_robes_of_the_hist.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Robes of the Hist (of Hist Sap)
    [127070] = { icon = 'LuiExtended/media/icons/abilities/ability_set_martial_knowledge.dds'; tooltip = Tooltips.Generic_Increase_Damage_Taken; tooltipValue2 = 8 }; -- Way of Martial Knowledge (of Martial Knowledge)
    [85825] = { icon = 'LuiExtended/media/icons/abilities/ability_set_prisoners_rags.dds' }; -- Prisoner's Rags (Prisoner's)
    [34506] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syrabane.dds' }; -- Syrabane's Grip (of Syrabane)
    [122755] = { icon = 'LuiExtended/media/icons/abilities/ability_set_withered_hand.dds' }; -- Robes of the Withered Hand
    [122756] = { icon = 'LuiExtended/media/icons/abilities/ability_set_withered_hand.dds' }; -- Robes of the Withered Hand
    [71657] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds' }; -- Trinimac's Valor
    [71664] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds'; tooltip = Tooltips.Set_Trinimacs_Valor }; -- Trinimac's Valor
    [71658] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds' }; -- Trinimac's Valor
    [93026] = { hide = true }; -- Mad Tinkerer (Mad Tinkerer's)
    [92982] = { hide = true }; -- Mad Tinkerer (Mad Tinkerer's)
    [93002] = { icon = '/esoui/art/icons/achievement_update16_029.dds' }; -- Mad Tinkerer (Mad Tinkerer's)
    [93003] = { icon = '/esoui/art/icons/achievement_update16_029.dds'; hide = true }; -- Mad Tinkerer (Mad Tinkerer's)
    [93001] = { icon = '/esoui/art/icons/achievement_update16_029.dds'; tooltip = Tooltips.Generic_Knockback }; -- Mad Tinkerer (Mad Tinkerer's)
    [129389] = { icon = 'LuiExtended/media/icons/abilities/ability_set_marauders_haste.dds'; tooltip = Tooltips.Generic_Movement_Speed; tooltipValue2 = 20 }; -- Marauder's Haste (Marauder's Haste)
    [135659] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winters_respite.dds'; tooltip = Tooltips.Set_Winters_Respite }; -- Winter's Respite (of Winter's Respite)
    [135658] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winters_respite.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Winter's Respite (of Winter's Respite)
    [147141] = { icon = 'LuiExtended/media/icons/abilities/ability_set_voidcaller.dds'; tooltip = Tooltips.Set_Voidcaller }; -- Voidcaller (of the Voidcaller)
    [147140] = { icon = 'LuiExtended/media/icons/abilities/ability_set_voidcaller.dds'; tooltip = Tooltips.Set_Voidcaller }; -- Voidcaller (of the Voidcaller)-- Overland Sets (Medium)
    [71106] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }; -- Briarheart
    [71107] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds'; tooltip = Tooltips.Set_Briarheart }; -- Briarheart
    [93308] = { hide = true }; -- Defiler
    [93307] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }; -- Defiler
    [93305] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds'; tooltip = Tooltips.Generic_Stun }; -- Defiler
    [34875] = { icon = 'LuiExtended/media/icons/abilities/ability_set_night_terror.dds' }; -- Night Terror (of Night Terror)
    [127192] = { icon = 'LuiExtended/media/icons/abilities/ability_set_senches_bite.dds'; tooltip = Tooltips.Generic_Critical_Damage; tooltipValue2 = 15 }; -- Senche's Bite (Senche's)
    [144480] = { icon = 'LuiExtended/media/icons/abilities/ability_set_stygian.dds'; tooltip = Tooltips.Generic_Spell_Damage_Duration_Value; tooltipValue2 = 369 }; -- Stygian (Stygian)
    [76344] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syvarras_scales.dds'; name = Abilities.Set_Syvarras_Scales; hide = true }; -- Serpent's Spirit (Syvarra's Scales)
    [75718] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syvarras_scales.dds'; name = Abilities.Set_Syvarras_Scales; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Serpent's Spirit (Syvarra's Scales)
    [52709] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_razor_flourish.dds'; tooltip = Tooltips.Generic_Weapon_Spell_Damage_Duration_Value; tooltipValue2 = 391 }; -- Way of Air (of the Air)
    [34383] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava_trap.dds' }; -- Shadow of the Red Mountain (of the Red Mountain)
    [34817] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twin_sisters.dds'; name = Abilities.Set_Twin_Sisters; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Twin Sisters Bleed
    [34870] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wilderqueen.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 15 }; -- Wilderqueen's Arch (of the Wilderqueen)
    [141867] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wilderqueen.dds'; name = Abilities.Set_Wilderqueens_Arch; tooltip = Tooltips.Generic_Movement_Speed; tooltipValue2 = 15 }; -- Marauder's Haste (of the Wilderqueen)
    [99268] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unfathomable_darkness.dds'; tooltip = Tooltips.Set_Unfathomable_Darknesss }; -- Unfathomable Darkness (of Unfathomable Darkness)
    [99267] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unfathomable_darkness.dds'; hide = true }; -- Unfathomable Darkness (of Unfathomable Darkness)
    [34508] = { icon = '/esoui/art/icons/crownstore_skillline_werewolf.dds' }; -- Hide of the Werewolf (Werewolf Hide)
    [18993] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bloodthorns_touch.dds' }; -- Witchman Armor (Witchman's)
    [85818] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bloodthorns_touch.dds' }; -- Witchman Armor (Witchman's)
    [141869] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bloodthorns_touch.dds' }; -- Witchman Armor (Witchman's)
    [114977] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dead_waters_guile.dds' }; -- Dead-Water's Guile (Dead-Water's Guile)
    [121615] = { icon = 'LuiExtended/media/icons/abilities/ability_set_darloc_brae.dds' }; -- Vesture of Darloc Brae (Darloc Brae's)
    [121602] = { icon = 'LuiExtended/media/icons/abilities/ability_set_darloc_brae.dds' }; -- Vesture of Darloc Brae (Darloc Brae's)
    [121618] = { icon = 'LuiExtended/media/icons/abilities/ability_set_darloc_brae.dds' }; -- Vesture of Darloc Brae (Darloc Brae's)
    [129407] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dragonguard_tactics.dds'; tooltip = Tooltips.Set_Dragonguard_Tactics }; -- Dragonguard Tactics (Dragonguard Elite's)
    [135690] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hunters_venom.dds'; tooltip = Tooltips.Set_Hunters_Venom }; -- Hunter's Venom (Venomous)
    [137526] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hunters_venom.dds' }; -- Hunter's Venom (Venomous)-- Overland Sets (Heavy)
    [34711] = { icon = 'LuiExtended/media/icons/abilities/ability_set_meridias.dds'; tooltip = Tooltips.Set_Meridias_Blessed_Armor }; -- Meridia's Blessed Armor (Blessed)
    [57298] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds' }; -- Draugr's Heritage
    [57296] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds'; tooltip = Tooltips.Generic_Knockback }; -- Draugr's Heritage
    [57297] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds' }; -- Draugr's Heritage
    [99286] = { icon = 'LuiExtended/media/icons/abilities/ability_set_livewire.dds' }; -- Livewire
    [79123] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morihaus.dds' }; -- Hide of Morihaus (of Morihaus)
    [79112] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morihaus.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Hide of Morihaus (of Morihaus)
    [127270] = { icon = 'LuiExtended/media/icons/abilities/ability_set_seventh_legion.dds'; tooltip = Tooltips.Set_Seventh_Legion }; -- Seventh Legion Brute (Seventh Legion)
    [144478] = { icon = 'LuiExtended/media/icons/abilities/ability_set_soulshine.dds'; tooltip = Tooltips.Generic_Spell_Damage_Duration_Value; tooltipValue2 = 369 }; -- Soulshine (of Soulshine)
    [52711] = { icon = 'LuiExtended/media/icons/abilities/ability_set_way_of_fire.dds' }; -- Way of Fire (Way of Fire)
    [112523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hatchlings_shell.dds'; tooltip = Tooltips.Set_Hatchlings_Shell }; -- Hatchling's Shell (of the Hatchling's Shell)
    [57210] = { icon = 'LuiExtended/media/icons/abilities/ability_set_storm_knight.dds'; tooltip = Tooltips.Set_Storm_Knight }; -- Storm Knight's Plate (of the Storm Knight)
    [57209] = { icon = 'LuiExtended/media/icons/abilities/ability_set_storm_knight.dds' }; -- Storm Knight's Plate (of the Storm Knight)
    [127275] = { icon = 'LuiExtended/media/icons/abilities/ability_set_veiled_heritance.dds'; tooltip = Tooltips.Generic_Weapon_Damage_Duration_Value; tooltipValue2 = 516 }; -- Armor of the Veiled Heritance (of the Veiled Heritance)
    [33497] = { icon = 'LuiExtended/media/icons/abilities/ability_set_thunderbug.dds' }; -- Thunderbug's Carapace (Thunderbug's)
    [106867] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grace_of_gloom.dds'; name = Abilities.Set_Grace_of_Gloom; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Major Evasion (Gloom-Graced)
    [106868] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grace_of_gloom.dds' }; -- Grace of Gloom (Gloom-Graced)
    [129442] = { icon = 'LuiExtended/media/icons/abilities/ability_set_senchals_duty.dds'; tooltip = Tooltips.Set_Senchals_Duty; forcedContainer = 'short' }; -- Senchal's Duty (Senchal Defender's)
    [129509] = { icon = 'LuiExtended/media/icons/abilities/ability_set_senchals_duty.dds'; name = Abilities.Set_Senchals_Duty }; -- Senchal Defender (Senchal Defender's)
    [129523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_senchals_duty.dds'; name = Abilities.Set_Senchals_Duty }; -- Senchal Defender (Senchal Defender's)
    [147221] = { icon = 'LuiExtended/media/icons/abilities/ability_set_radiant_bastion.dds'; hide = true }; -- Radiant Bastion (of the Radiant Bastion)-- Dungeon Sets (Light)
    [61459] = { icon = 'LuiExtended/media/icons/abilities/ability_set_burning_spellweave.dds'; tooltip = Tooltips.Generic_Spell_Damage_Duration_Value; tooltipValue2 = 490 }; -- Burning Spellweave
    [102027] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_fire.dds'; hide = true }; -- Caluurion's Legacy (Fire)
    [102032] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_frost.dds'; hide = true }; -- Caluurion's Legacy (Frost)
    [102033] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds'; hide = true }; -- Caluurion's Legacy (Disease)
    [102034] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_shock.dds'; hide = true }; -- Caluurion's Legacy (Shock)
    [97538] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds'; tooltip = Tooltips.Set_Draugrs_Rest }; -- Draugr's Rest (Draugr's Rest)
    [97539] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Draugr's Rest
    [97574] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_blossom.dds' }; -- Flame Blossom
    [85610] = { icon = 'LuiExtended/media/icons/abilities/ability_set_song_of_lamae.dds' }; -- Lamia's Song (Lamia's)
    [143097] = { icon = 'LuiExtended/media/icons/abilities/ability_set_song_of_lamae.dds' }; -- Lamia's Song (Lamia's)
    [143098] = { icon = 'LuiExtended/media/icons/abilities/ability_set_song_of_lamae.dds' }; -- Lamia's Song (Lamia's)
    [67129] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds'; tooltip = Tooltips.Set_Overwhelming_Surge }; -- Overwhelming Surge (Overwhelming)
    [67136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds' }; -- Overwhelming Surge (Overwhelming)
    [127131] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds' }; -- Overwhelming Surge (Overwhelming)
    [34504] = { icon = 'LuiExtended/media/icons/abilities/ability_set_prayer.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Prayer Shawl (of Prayer)
    [32834] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds'; tooltip = Tooltips.Generic_Increase_Healing_Received_No_Dur; tooltipValue2 = 10 }; -- Sanctuary (of Sanctuary)
    [67098] = { icon = 'LuiExtended/media/icons/abilities/ability_set_combat_physician.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Combat Physician (of the Combat Physician)
    [57164] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_teleport.dds'; tooltip = Tooltips.Generic_Magicka_Recovery_Duration_Value; tooltipValue2 = 1032 }; -- Shroud of the Lich (of the Lich)
    [34813] = { icon = 'LuiExtended/media/icons/abilities/ability_set_magicka_furnace.dds' }; -- Magicka Furnace (of the Magicka Furnace)
    [34373] = { name = Abilities.Set_Noble_Duelist; tooltip = Tooltips.Generic_LA_HA_Damage_Duration_Value; tooltipValue2 = 1811 }; -- Noble Duelist's Silks (Noble Duelist)
    [67288] = { icon = 'LuiExtended/media/icons/abilities/ability_set_scathing_mage.dds'; tooltip = Tooltips.Generic_Spell_Damage_Duration_Value; tooltipValue2 = 516 }; -- Scathing Mage (of the Scathing Mage)
    [59676] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_unweaver.dds'; tooltip = Tooltips.Generic_LA_HA_Damage_Duration_Value; tooltipValue2 = 1685 }; -- Undaunted Unweaver (of the Undaunted Unweaver)
    [57163] = { icon = 'LuiExtended/media/icons/abilities/ability_set_warlock.dds' }; -- Robes of the Warlock (of the Warlock)
    [47367] = { icon = 'LuiExtended/media/icons/abilities/ability_set_worm_cult.dds'; tooltip = Tooltips.Generic_Increase_Magicka_Recovery_No_Dur; tooltipValue2 = 145 }; -- Worm's Raiment (of the Worm Cult)
    [111204] = { icon = '/esoui/art/icons/achievement_thievesguild_003.dds'; tooltip = Tooltips.Generic_Spell_Damage_Duration_Value; tooltipValue2 = 547 }; -- Moon Hunter (Moon Hunter)
    [117666] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds' }; -- Icy Conjuror
    [116727] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds'; tooltip = Tooltips.Generic_Freeze; tooltipValue2 = 1 }; -- Icy Conjuror (Icy Conjuror)
    [116884] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aurorans_thunder.dds'; tooltip = Tooltips.Set_Aurorans_Thunder }; -- Auroran's Thunder (Auroran's Thunder)
    [116920] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aurorans_thunder.dds' }; -- Auroran's Thunder (Auroran's Thunder)
    [126924] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hollowfang.dds'; tooltip = Tooltips.Set_Hollowfang_Thirst }; -- Hollowfang Thirst (Hollowfang Thirst)
    [126938] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hollowfang.dds' }; -- Hollowfang Thirst (Hollowfang Thirst)
    [126597] = { icon = 'LuiExtended/media/icons/abilities/ability_set_touch_of_zen.dds'; tooltip = Tooltips.Set_Touch_of_Zen }; -- Touch of Z'en (Z'en's)
    [133210] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hiti.dds'; tooltip = Tooltips.Set_Hitis_Hearth }; -- Warming Aura (Hiti's)
    [133211] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hiti.dds'; name = Abilities.Set_Warming_Aura }; -- Hiti's Hearth (Hiti's)
    [135130] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hiti.dds'; name = Abilities.Set_Warming_Aura; forcedContainer = 'short'; groundLabel = true; tooltip = Tooltips.Set_Hitis_Hearth_Ground }; -- Hiti's Hearth (Hiti's)
    [133406] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrkins_grip.dds'; tooltip = Tooltips.Set_Draugrkin }; -- Draugrkin's Grip (Draugrkin)
    [142610] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_fire.dds'; tooltip = Tooltips.Set_Elemental_Catalyst }; -- Flame Weakness (of the Catalyst)
    [142652] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_frost.dds'; tooltip = Tooltips.Set_Elemental_Catalyst }; -- Frost Weakness (of the Catalyst)
    [142653] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_shock.dds'; tooltip = Tooltips.Set_Elemental_Catalyst }; -- Shock Weakness (of the Catalyst)

    -- Dungeon Sets (Medium)
    [85977] = { icon = 'LuiExtended/media/icons/abilities/ability_set_barkskin.dds' }; -- Barkskin
    [85978] = { icon = 'LuiExtended/media/icons/abilities/ability_set_barkskin.dds' }; -- Barkskin
    [47365] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds'; tooltip = Tooltips.Generic_Increase_Stamina_Recovery_No_Dur; tooltipValue2 = 145 }; -- Hircine's Veneer (Hircine's)
    [34612] = { hide = true }; -- Oblivion's Edge (of Oblivion)
    [57206] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_oblivion_blue.dds' }; -- Oblivion's Edge (of Oblivion)
    [97716] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pillar_of_nirn.dds' }; -- Pillar of Nirn
    [97743] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pillar_of_nirn.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Pillar of Nirn
    [102106] = { icon = '/esoui/art/icons/achievement_bossflavoreasy.dds'; name = Abilities.Set_Plague_Slinger; tooltip = Tooltips.Set_Plague_Slinger }; -- Skeever Corpse (Plague Slinger)
    [102113] = { icon = 'LuiExtended/media/icons/abilities/ability_set_plague_slinger.dds' }; -- Plague Slinger
    [67141] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sheer_venom.dds'; tooltip = Tooltips.Set_Sheer_Venom }; -- Sheer Venom
    [60060] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sunderflame.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1 }; -- Sunderflame
    [85635] = { icon = 'LuiExtended/media/icons/abilities/ability_set_spelunker.dds' }; -- Spelunker (Spelunker's)
    [143136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_spelunker.dds' }; -- Spelunker (Spelunker's)
    [70298] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_shock.dds'; tooltip = Tooltips.Generic_LA_HA_Damage_Duration_Value; tooltipValue2 = 1542 }; -- Storm Master (Storm Master's)
    [49220] = { hide = true }; -- Extra dodge (of the Crusader)
    [67334] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds'; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 10 }; -- Essence Thief (of the Essence Thief)
    [70284] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }; -- Essence Thief (of the Essence Thief)
    [70290] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }; -- Essence Thief (of the Essence Thief)
    [59667] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_infiltrator.dds'; tooltip = Tooltips.Generic_LA_HA_Damage_Duration_Value; tooltipValue2 = 1685 }; -- Undaunted Infiltrator (of the Undaunted Infiltrator)
    [33691] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vipers_sting.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Viper's Sting
    [101970] = { icon = 'LuiExtended/media/icons/abilities/ability_set_invigoration.dds' }; -- Trappings of Invigoration
    [84350] = { icon = 'LuiExtended/media/icons/abilities/ability_set_velidreth.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Widowmaker
    [111387] = { icon = '/esoui/art/icons/mos_dagrund_upheavel.dds'; tooltip = Tooltips.Set_Blood_Moon_Scent }; -- Blood Scent (Blood Moon)
    [111386] = { icon = 'LuiExtended/media/icons/abilities/ability_set_frenzied.dds'; tooltip = Tooltips.Set_Blood_Moon_Frenzied }; -- Frenzied (Blood Moon)
    [111216] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_bleed.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Savage Werewolf (Savage Werewolf)
    [116742] = { icon = 'LuiExtended/media/icons/abilities/ability_set_tzogvins_warband.dds'; tooltip = Tooltips.Set_Tzogvins_Warband }; -- Precision (Tzogvin's Warband)
    [116954] = { hide = true }; -- Stalked (Scavenging Demise)
    [116991] = { icon = 'LuiExtended/media/icons/abilities/ability_set_scavenging_demise.dds'; name = Abilities.Set_Scavenging_Demise }; -- Stalked (Scavenging Demise)
    [126631] = { icon = 'LuiExtended/media/icons/abilities/ability_set_blight_seed.dds'; tooltip = Tooltips.Set_Blight_Seed; unbreakable = 1 }; -- Blight Seed (Azureblight)
    [126633] = { icon = 'LuiExtended/media/icons/abilities/ability_set_blight_seed.dds'; tooltip = Tooltips.Set_Blight_Seed }; -- Blight Seed (Azureblight)
    [133493] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aegis_caller.dds'; name = Abilities.Set_Aegis_Caller; tooltip = Tooltips.Set_Aegis_Caller }; -- Lesser Aegis (Aegis Caller's)
    [133494] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_symphony_of_blades.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Bleed; tooltipValue2 = 1 }; -- Aegis Caller (Aegis Caller's)
    [142816] = { name = Abilities.Set_Heed_the_Call }; -- Kraglen's Howl (Kraglen's)
    [141204] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unleashed_terror.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Unleashed Terror (Terror)-- Dungeon Sets (Heavy)
    [102023] = { icon = 'LuiExtended/media/icons/abilities/ability_set_curse_of_doylemish.dds' }; -- Curse of Doylemish
    [134930] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dunerippers_scales.dds'; tooltip = Tooltips.Set_Dunerippers_Scales; toggle = true }; -- Duneripper's Scales
    [47362] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ebon.dds'; tooltip = Tooltips.Set_Ebon_Armory }; -- Ebon Armory (Ebon)
    [59695] = { icon = 'LuiExtended/media/icons/abilities/ability_set_embershield.dds'; tooltip = Tooltips.Set_Embershield }; -- Embershield (Embershield)
    [59696] = { icon = 'LuiExtended/media/icons/abilities/ability_set_embershield.dds' }; -- Embershield (Embershield)
    [97908] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hagravens_garden.dds'; tooltip = Tooltips.Set_Hagravens_Garden }; -- Hagraven's Garden (Hagraven's)
    [34404] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ice_furnace.dds'; name = Abilities.Set_Ice_Furnace }; -- Frostfire (Ice Furnace)
    [97627] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ironblood.dds'; tooltip = Tooltips.Set_Ironblood }; -- Ironblood
    [67078] = { icon = 'LuiExtended/media/icons/abilities/ability_set_jolting_arms.dds'; tooltip = Tooltips.Set_Jolting_Arms }; -- Jolting Arms (Jolting)
    [85620] = { icon = 'LuiExtended/media/icons/abilities/ability_set_knight_errant.dds' }; -- Knight-Errant's Mail (Knight-Errant's)
    [67205] = { icon = 'LuiExtended/media/icons/abilities/ability_set_leeching_plate.dds'; tooltip = Tooltips.Set_Leeching_Plate }; -- Leeching Plate (of Leeching)
    [69345] = { icon = 'LuiExtended/media/icons/abilities/ability_set_leeching_plate.dds' }; -- Leeching Plate (of Leeching)
    [67204] = { icon = 'LuiExtended/media/icons/abilities/ability_set_leeching_plate.dds'; groundLabel = true; tooltip = Tooltips.Skill_Leeching_Plate_Ground }; -- Leeching Plate (of Leeching)
    [84277] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aspect_of_mazzatun.dds' }; -- Aspect of Mazzatun (of Mazzatun)
    [84278] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aspect_of_mazzatun.dds' }; -- Aspect of Mazzatun (of Mazzatun)
    [84279] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aspect_of_mazzatun.dds' }; -- Aspect of Mazzatun (of Mazzatun)
    [84354] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_green.dds'; tooltip = Tooltips.Set_Hand_of_Mephala }; -- Hand of Mephala (Mephala's Hand)
    [84357] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_green.dds'; name = Abilities.Set_Hand_of_Mephala; duration = 0; tooltip = Tooltips.Skill_Hand_of_Mephala_Ground; groundLabel = true }; -- Hand of Mephala Webbing (of Mephala's Hand)
    [84355] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_green.dds' }; -- Hand of Mephala (of Mephala's Hand)
    [32735] = { hide = true }; -- Major Brutality (Dreugh King Slayer)
    [66887] = { icon = 'LuiExtended/media/icons/abilities/ability_set_imperium.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Brands of the Imperium (of the Imperium)
    [67283] = { icon = 'LuiExtended/media/icons/abilities/ability_set_tormentor.dds'; name = Abilities.Set_Tormentor; tooltip = Tooltips.Generic_Physical_Spell_Resist_Value; tooltipValue2 = 3642 }; -- Tormentor Resistance (of the Tormentor)
    [61200] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_bastion.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Undaunted Bastion (of the Undaunted Bastion)
    [86070] = { icon = '/esoui/art/icons/achievement_thievesguild_034.dds'; tooltip = Tooltips.Generic_Weapon_Damage_Duration_Value; tooltipValue2 = 460 }; -- Armor of Truth (of Truth)
    [112414] = { icon = 'LuiExtended/media/icons/abilities/ability_set_haven_of_ursus.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Ursus's Blessing (Haven of Ursus)
    [117082] = { icon = '/esoui/art/icons/ability_wrothgar_bitingcold.dds'; tooltip = Tooltips.Set_Frozen_Watcher; toggle = true }; -- Frozen Watcher (Frozen Watcher)
    [117060] = { icon = '/esoui/art/icons/ability_wrothgar_bitingcold.dds' }; -- Frozen Watcher (Frozen Watcher)
    [126535] = { icon = 'LuiExtended/media/icons/abilities/ability_set_renalds_resolve.dds'; tooltip = Tooltips.Set_Renalds_Resolve }; -- Resolve (Renald's)
    [126682] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dragons_defilement.dds'; tooltip = Tooltips.Set_Dragons_Defilement }; -- Dragon's Defilement (Defiled Dragon's)
    [135554] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grave_guardian.dds'; tooltip = Tooltips.Set_Grave_Guardian; toggle = true }; -- Grave Guardian (Grave Guardian's)
    [133451] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grave_guardian.dds'; groundLabel = true; tooltip = Tooltips.Generic_Physical_Spell_Resist_No_Dur_Value; tooltipValue2 = 4430; forcedContainer = 'short' }; -- Grave Guardian (Grave Guardian's)
    [141638] = { icon = 'LuiExtended/media/icons/abilities/ability_set_crimson_twilight.dds'; tooltip = Tooltips.Set_Crimson_Twilight }; -- Crimson Twilight (Crimson)
    [141642] = { icon = 'LuiExtended/media/icons/abilities/ability_set_crimson_twilight.dds' }; -- Crimson Twilight (Crimson)
    [141865] = { icon = 'LuiExtended/media/icons/abilities/ability_set_crimson_twilight.dds' }; -- Crimson Twilight (Crimson)
    [142660] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arkasis.dds'; hide = true }; -- Arkasis' Genius (Arkasis)

    -- Trial Sets (Hel Ra Citadel)
    [50978] = { icon = 'LuiExtended/media/icons/abilities/ability_set_berserking_warrior.dds'; tooltip = Tooltips.Set_Berserking_Warrior }; -- Berserking Warrior (Advancing Yokeda)
    [129477] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Set_Immortal_Warrior, Abilities.Set_Cooldown); tooltip = Tooltips.Generic_Set_ICD; tooltipValue2 = Abilities.Set_Immortal_Warrior; unbreakable = 1 }; -- Major Protection (Immortal Yokeda)
    [86907] = { icon = 'LuiExtended/media/icons/abilities/ability_set_defending_warrior.dds' }; -- Defending Warrior (Resilient Yokeda)
    [50992] = { icon = 'LuiExtended/media/icons/abilities/ability_set_defending_warrior.dds' }; -- Defending Warrior (Resilient Yokeda)
    [127235] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_warrior.dds' }; -- Eternal Warrior (Eternal Yokeda)
    [127236] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_warrior.dds' }; -- Eternal Warrior (Eternal Yokeda)
    -- Trial Sets (Aetherian Archive)
    [51315] = { icon = 'LuiExtended/media/icons/abilities/ability_set_destructive_mage.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Set_Destructive_Mage }; -- Destructive Mage (Aether... of Destruction)
    [51320] = { icon = 'LuiExtended/media/icons/abilities/ability_set_destructive_mage.dds'; name = Abilities.Set_Destructive_Mage }; -- Mage Destruction Bomb (Aether... of Destruction)
    -- Trial Sets (Sanctum Ophidia)
    [51241] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vipers_sting.dds' }; -- Poisonous Serpent (Ophidian ... of Venom)
    [51176] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twice_fanged_serpent.dds'; tooltip = Tooltips.Set_Twice_Fanged_Serpent }; -- Twice-Fanged Serpent (of the Two-Fanged Snake)
    [57159] = { icon = 'LuiExtended/media/icons/abilities/ability_set_quick_serpent.dds' }; -- Quick Serpent (Ophidian.. of Celerity)
    [81522] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicious_serpent.dds' }; -- Vicious Serpent (of the Vicious Ophidian)
    -- Trial Sets (Maw of Lorkhaj)
    [75801] = { icon = 'LuiExtended/media/icons/abilities/ability_set_moondancer_lunar.dds'; tooltip = Tooltips.Generic_Magicka_Recovery_Duration_Value; tooltipValue2 = 474 }; -- Lunar Blessing (Moondancer)
    [75804] = { icon = 'LuiExtended/media/icons/abilities/ability_set_moondancer_shadow.dds'; tooltip = Tooltips.Generic_Spell_Damage_Duration_Value; tooltipValue2 = 474 }; -- Shadow Blessing (Moondancer)
    [75752] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds' }; -- Roar of Alkosh (of Alkosh)
    [75753] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds'; tooltip = Tooltips.Set_Roar_of_Alkosh }; -- Line Breaker (of Alkosh)
    [76667] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds'; tooltip = Tooltips.Generic_Physical; tooltipValue2 = 1 }; -- Roar of Alkosh (of Alkosh)
    [75814] = { icon = 'LuiExtended/media/icons/abilities/ability_set_lunar_bastion.dds'; tooltip = Tooltips.Set_Lunar_Bastion }; -- Lunar Bastion (of the Lunar Bastion)
    [75815] = { icon = 'LuiExtended/media/icons/abilities/ability_set_lunar_bastion.dds'; tooltip = Tooltips.Set_Lunar_Bastion_Ground }; -- Lunar Bastion (of the Lunar Bastion)
    [75770] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Twilight Remedy (of Twilight Remedy)
    -- Trial Sets (Cloudrest)
    [107141] = { icon = 'LuiExtended/media/icons/abilities/ability_set_olorime.dds'; name = Abilities.Set_Vestment_of_Olorime; tooltip = Tooltips.Set_Vestment_of_Olorime }; -- Vestment of Olirime (Olorime's)
    [109084] = { icon = 'LuiExtended/media/icons/abilities/ability_set_olorime.dds'; name = Abilities.Set_Vestment_of_Olorime; tooltip = Tooltips.Set_Vestment_of_Olorime }; -- Ideal Vestment of Olirime (Olorime's Perfect)
    [107095] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds'; tooltip = Tooltips.Set_Mantle_of_Siroria }; -- Mantle of Siroria (Siroria's)
    [110118] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_ring.dds'; tooltip = Tooltips.Set_Sirorias_Boon }; -- Siroria's Boon (Siroria's)
    [109081] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds'; name = Abilities.Set_Mantle_of_Siroria; tooltip = Tooltips.Set_Mantle_of_Siroria }; -- Ideal Mantle of Siroria (Siroria's)
    [110142] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_ring.dds'; tooltip = Tooltips.Set_Sirorias_Boon }; -- Siroria's Boon (Perfect Siroria's)
    [110504] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds'; name = Abilities.Set_Harmful_Winds; tooltip = Tooltips.Set_Relequen }; -- Arms of Relequen (Perfect Relequen's)
    [107203] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds'; name = Abilities.Set_Harmful_Winds }; -- Arms of Relequen (Perfect Relequen's)
    [110512] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds'; name = Abilities.Set_Harmful_Winds; tooltip = Tooltips.Set_Relequen }; -- Ideal Arms of Relequen (Relequen's)
    [109086] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds'; name = Abilities.Set_Harmful_Winds }; -- Ideal Arms of Relequen (Relequen's)
    -- Trial Sets (Sunspire)
    [121829] = { icon = 'LuiExtended/media/icons/abilities/ability_set_false_gods_devotion.dds' }; -- False God's Devotion (False God's Devotion)
    [124800] = { icon = 'LuiExtended/media/icons/abilities/ability_set_false_gods_devotion.dds'; name = Abilities.Set_False_Gods_Devotion }; -- False God's Devotion (Perfected False God's Devotion)
    [121898] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eye_of_nahviintaas.dds'; tooltip = Tooltips.Set_Eye_of_Nahviintaas }; -- Eye of Nahviintaas (Nahviintaas')
    [122812] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eye_of_nahviintaas.dds'; tooltip = Tooltips.Set_Eye_of_Nahviintaas }; -- Eye of Nahviintaas (Nahviintaas')
    -- Trial Sets (Kyne's Aegis)
    [136098] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds'; tooltip = Tooltips.Set_Kynes_Blessing }; -- Kyne's Blessing (of Kyne's Wind)
    [136101] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds'; name = Abilities.Set_Kynes_Blessing }; -- Kyne's Wind (of Kyne's Wind)
    [136099] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds'; name = Abilities.Set_Kynes_Blessing }; -- Kyne's Wind (of Kyne's Wind)
    [137995] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds'; tooltip = Tooltips.Set_Kynes_Blessing }; -- Kyne's Blessing (of Kyne's Wind (Perfect))
    [137996] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds'; name = Abilities.Set_Kynes_Blessing }; -- Kyne's Blessing (of Kyne's Wind (Perfect))
    [137993] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_blessing.dds'; name = Abilities.Set_Kynes_Blessing }; -- Kyne's Blessing (of Kyne's Wind (Perfect))
    [135950] = { icon = 'LuiExtended/media/icons/abilities/ability_set_giants_endurance.dds'; tooltip = Tooltips.Set_Giants_Endurance; forcedContainer = 'short' }; -- Giant's Endurance (Yandir's)
    [135951] = { icon = 'LuiExtended/media/icons/abilities/ability_set_giants_might.dds'; tooltip = Tooltips.Set_Giants_Might }; -- Giant's Might (Yandir's)
    [138013] = { icon = 'LuiExtended/media/icons/abilities/ability_set_giants_endurance.dds'; tooltip = Tooltips.Set_Giants_Endurance; forcedContainer = 'short' }; -- Giant's Endurance (Yandir's Perfect)
    [138019] = { icon = 'LuiExtended/media/icons/abilities/ability_set_giants_might.dds'; tooltip = Tooltips.Set_Giants_Might }; -- Giant's Might (Yandir's Perfect)
    -- Set ICD's (Fake Id's)
    [999010] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_warrior_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Set_Eternal_Warrior, Abilities.Set_Cooldown); tooltip = Tooltips.Generic_Set_ICD_Minutes; tooltipValue2 = Abilities.Set_Eternal_Warrior; tooltipValue3 = 1; unbreakable = 1 }; -- Eternal Warrior (Fake Id)
    [999011] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Set_Phoenix, Abilities.Set_Cooldown); tooltip = Tooltips.Generic_Set_ICD_Minutes; tooltipValue2 = Abilities.Set_Phoenix; tooltipValue3 = 1; unbreakable = 1 }; -- Phoenix (Fake Id)
    [999012] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_juggernaut_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Set_Juggernaut, Abilities.Set_Cooldown); tooltip = Tooltips.Generic_Set_ICD_Minutes; tooltipValue2 = Abilities.Set_Juggernaut; tooltipValue3 = 1; unbreakable = 1 }; -- Juggernaut (Fake Id)
    -- Battleground Sets
    [93104] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_oblivion_purple.dds' }; -- Knight Slayer
    [92916] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vanguards_challenge.dds'; tooltip = Tooltips.Set_Vanguards_Challenge }; -- Vanguard's Challenge
    -- Imperial City Sets
    [79421] = { icon = 'LuiExtended/media/icons/abilities/ability_set_galerions_revenge.dds'; tooltip = Tooltips.Set_Galerions_Revenge }; -- Mark of Revenge (Galerion's)
    [79420] = { icon = 'LuiExtended/media/icons/abilities/ability_set_galerions_revenge.dds' }; -- Galerion's Revenge (Galerion's)
    [65706] = { icon = '/esoui/art/icons/crownstore_skillline_alliancewar_support.dds'; tooltip = Tooltips.Generic_Physical_Spell_Resist_Value; tooltipValue2 = 3540 }; -- Meritorious Service (of Meritorious Service)
    [61771] = { icon = '/esoui/art/icons/crownstore_skillline_alliancewar_assault.dds'; tooltip = Tooltips.Generic_Weapon_Spell_Damage_Duration_Value; tooltipValue2 = 307 }; -- Powerful Assault (of the Powerful Assault)
    [79363] = { icon = '/esoui/art/icons/achievement_029.dds' }; -- Thews of the Harbinger (of the Harbinger)
    [79469] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicecanon_of_venom.dds'; name = Abilities.Set_Vicecannon_of_Venom; tooltip = Tooltips.Set_Vicecanon_of_Venom }; -- Deadly Venom (the Vicecanon's)
    [79471] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicecanon_of_venom.dds'; name = Abilities.Set_Vicecannon_of_Venom }; -- Deadly Venom (the Vicecanon's)
    [127032] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Phoenix (of the Phoenix)
    [127036] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds'; name = Abilities.Set_Phoenix }; -- Phoenix's Flame (of the Phoenix)
    [69567] = { icon = 'LuiExtended/media/icons/abilities/ability_set_reactive_armor.dds'; name = Abilities.Set_Reactive_Armor; tooltip = Tooltips.Generic_Reduce_Damage_Taken; tooltipValue2 = 33 }; -- Reactive Armor Effects (Reactive)
    -- Cyrodiil Sets (Light)
    [34605] = { icon = 'LuiExtended/media/icons/abilities/ability_set_almalexias_mercy.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Almalexia's Mercy (of Almalexia's Mercy)
    [70392] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arch-mage.dds'; tooltip = Tooltips.Generic_Magicka_Recovery_Duration_Value; tooltipValue2 = 506 }; -- The Arch-Mage (of the Arch-Mage)
    [117359] = { icon = 'LuiExtended/media/icons/abilities/ability_set_curse_eater.dds' }; -- Curse-Eater (Curse-Eating)
    [111550] = { icon = 'LuiExtended/media/icons/abilities/ability_set_light_of_cyrodiil.dds'; tooltip = Tooltips.Set_Light_of_Cyrodiil }; -- Light of Cyrodiil (of Cyrodiil's Light)
    [33498] = { icon = 'LuiExtended/media/icons/abilities/ability_set_desert_rose.dds' }; -- Desert Rose (of the Desert Rose)
    -- Cyrodiil Sets (Medium)
    [34509] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_kiss.dds' }; -- Kyne's Kiss (of Kyne's Kiss)
    [70492] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_kiss.dds' }; -- Kyne's Kiss (of Kyne's Kiss)
    [34384] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morag_tong.dds'; tooltip = Tooltips.Set_Morag_Tong }; -- The Morag Tong (of the Morag Tong)
    [117391] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sentry.dds'; tooltip = Tooltips.Set_Sentry }; -- Sentry (of the Sentry)
    [117397] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sentry_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Set_Sentry, Abilities.Set_Cooldown); tooltip = Tooltips.Generic_Set_ICD; tooltipValue2 = Abilities.Set_Sentry; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Exhausted Sentry (of the Sentry)
    [57180] = { icon = '/esoui/art/icons/achievement_thievesguild_011.dds' }; -- Shadow Walker (of the Shadow Walker)
    [57181] = { icon = '/esoui/art/icons/achievement_thievesguild_011.dds' }; -- Shadow Walker (of the Shadow Walker)
    [47358] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vengeance_leech.dds' }; -- Vengeance Leech (of Vengeance Leech)
    [47359] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vengeance_leech.dds' }; -- Vengeance Leech (of Vengeance Leech)
    [47360] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vengeance_leech.dds' }; -- Vengeance Leech (of Vengeance Leech)
    -- Cyrodiil Sets (Heavy)
    [34787] = { icon = 'LuiExtended/media/icons/abilities/ability_set_affliction.dds' }; -- Affliction (Afflicted)
    [29122] = { icon = 'LuiExtended/media/icons/abilities/ability_set_beckoning_steel.dds'; tooltip = Tooltips.Set_Beckoning_Steel }; -- Beckoning Steel (Beckoning Steel)
    [111575] = { icon = 'LuiExtended/media/icons/abilities/ability_set_crest_of_cyrodiil.dds' }; -- Crest of Cyrodiil (Cyrodiil's Crest)
    [127280] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_ravager.dds'; tooltip = Tooltips.Set_Ravager }; -- The Ravager (Ravaging)
    [127284] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_ravager.dds'; tooltip = Tooltips.Set_Ravager }; -- The Ravager (Ravaging)
    [34512] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_juggernaut.dds' }; -- The Juggernaut (of the Juggernaut)
    [142401] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_juggernaut.dds'; tooltip = Tooltips.Generic_Physical_Spell_Resist_Value; tooltipValue2 = 20000 }; -- The Juggernaut (of the Juggernaut)
    -- Rewards for the Worthy Sets
    [113523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_battalion_defender.dds' }; -- Battalion Defender (Battalion Defender)
    [113461] = { icon = '/esoui/art/icons/achievement_murkmire_rescue_villagers.dds'; name = Abilities.Set_Soldier_of_Anguish; tooltip = Tooltips.Set_Soldier_of_Anguish }; -- Heal Absorption (Soldier of Anguish)
    [113382] = { icon = '/esoui/art/icons/achievement_blackrose_boss_5.dds'; tooltip = Tooltips.Set_Spell_Strategist }; -- Spell Strategist (Spell Strategist)
    [113417] = { hide = true }; -- Spell Strategist (Spell Strategist)
    [76950] = { icon = 'LuiExtended/media/icons/abilities/ability_set_warriors_fury.dds'; tooltip = Tooltips.Set_Warriors_Fury }; -- Warrior's Fury (of Fury)
    [128494] = { icon = 'LuiExtended/media/icons/abilities/ability_set_warriors_fury.dds'; tooltip = Tooltips.Set_Warriors_Fury }; -- Warrior's Fury (of Fury)
    [76936] = { icon = 'LuiExtended/media/icons/abilities/ability_set_transmutation.dds'; tooltip = Tooltips.Set_Robes_of_Transmutation }; -- Transmutation (of Transmutation)
    [76938] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicious_death.dds' }; -- Vicious Death (of Vicious Death)
    -- Maelstrom Arena Sets
    [127081] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_fire.dds'; tooltip = Tooltips.Set_Succession_Flame }; -- Flame Succession (of Succession)
    [127084] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_shock.dds'; tooltip = Tooltips.Set_Succession_Shock }; -- Shock Succession (of Succession)
    [127088] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_frost.dds'; tooltip = Tooltips.Set_Succession_Frost }; -- Frost Succession (of Succession)
    [73296] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_pillar.dds'; name = Abilities.Set_Winterborn; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 50 }; -- Winterborn Snare (Winterborn)
    [71646] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_pillar.dds' }; -- Winterborn (Winterborn)
    [71188] = { icon = '/esoui/art/icons/ability_rogue_019.dds'; name = Abilities.Set_Glorious_Defender; tooltip = Tooltips.Set_Glorious_Defender }; -- Glorious Defense (of Glory)
    [71605] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_bear.dds' }; -- Hunt Leader (of the Hunt)
    [74106] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_bear.dds' }; -- Hunt Leader (of the Hunt)
    [71193] = { icon = 'LuiExtended/media/icons/abilities/ability_set_para_bellum.dds'; name = Abilities.Set_Para_Bellum; tooltip = Tooltips.Set_Para_Bellum }; -- Para Bellum Shield (Para Bellum)
    -- Vatesharn Hollows Sets
    [147675] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hex_siphon.dds'; tooltip = Tooltips.Set_Hex_Siphon }; -- Hex Siphon (Hex Siphoner's)
    [147677] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hex_siphon.dds' }; -- Hex Siphon (Hex Siphoner's)
    [147686] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pestilent_host.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Pestilent Host (of the Pestilent Host)
    [147692] = { icon = 'LuiExtended/media/icons/abilities/ability_set_explosive_rebuke.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Set_Explosive_Rebuke }; -- Explosive Rebuke (of Explosive Rebuke)
    [147694] = { icon = 'LuiExtended/media/icons/abilities/ability_set_explosive_rebuke.dds' }; -- Explosive Rebuke (of Explosive Rebuke)

    -- Disguises
    [46281] = { tooltip = Tooltips.Disguise_Bloodthorn }; -- Necromancer Disguise (Bloodthorn Disguise)
    [30879] = { tooltip = Tooltips.Disguise_Kollopi_Essence }; -- Shimmering Glow (Kollopi Essence)
    [43716] = { tooltip = Tooltips.Disguise_Phaer_Mercenary }; -- Phaer Mercenary Disguise (Phaer Mercenary Disguise)
    [43719] = { tooltip = Tooltips.Disguise_Quendeluun }; -- Quendeluun Pact Disguise (Quendeluun Veiled Heritance Disguise)
    [33534] = { tooltip = Tooltips.Disguise_Sea_Viper_Armor }; -- Seaside Disguise (Sea Viper Armor)
    [27457] = { tooltip = Tooltips.Disguise_Seadrake }; -- Seadrake Disguise (Seadrake Disguise)
    [32045] = { tooltip = Tooltips.Disguise_Servants_Robes }; -- Servant Costume (Servant's Robes)
    [43722] = { tooltip = Tooltips.Disguise_Vulkhel_Guard }; -- First Auridon Marine Disguise (Vulkhel Guard Marcine Disguise)
    [82631] = { icon = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds'; name = Abilities.Disguise_Monks_Disguise }; -- Monk Disguise Timer (Monk's Disguise)

    ----------------------------------------------------------------
    -- WORLD EVENTS  -----------------------------------------------
    ----------------------------------------------------------------

    -- Dark Anchor
    [86717] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_anchor_drop.dds'; name = Abilities.Innate_Anchor_Drop }; -- Drop Anchor
    [46690] = { hide = true }; -- Power of the Daedra
    [46689] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_power_of_the_daedra.dds'; name = Abilities.Innate_Power_of_the_Daedra }; -- Vitality of the Daedra
    [51632] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_power_of_the_daedra.dds'; name = Abilities.Innate_Power_of_the_Daedra }; -- Vitality of the Daedra
    [51633] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_power_of_the_daedra.dds'; name = Abilities.Innate_Power_of_the_Daedra }; -- Vitality of the Daedra
    [95820] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_static_charge.dds' }; -- Static Charge
    [95841] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_static_charge.dds' }; -- Static Charge
    [95813] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_static_charge.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; duration = 0; unbreakable = 1; tooltip = Tooltips.Skill_Static_Charge; groundLabel = true }; -- Static Charge
    [46291] = { hide = true }; -- Rain of Doom
    [46293] = { hide = true }; -- Stun-- Dark Anchor Bosses
    [89249] = { hide = true }; -- Summon Daedra (Ozozzachar)
    [89251] = { hide = true }; -- Summon Daedra (Ozozzachar)-- Misc World + Theater
    [822] = { hide = true }; -- Ward
    [48899] = { icon = '/esoui/art/icons/achievement_newlifefestival_007.dds'; tooltip = Tooltips.Innate_Firelight }; -- Firelight

    ----------------------------------------------------------------
    -- DRAGONKNIGHT PASSIVES ---------------------------------------
    ----------------------------------------------------------------

    -- Ardent Flame
    [29424] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_combustion.dds' }; -- Combustion (Combustion - Rank 1)
    [108806] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }; -- Combustion (Combustion - Rank 1)
    [108809] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }; -- Combustion (Combustion - Rank 1)
    [45011] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_combustion.dds' }; -- Combustion (Combustion - Rank 2)
    [108816] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }; -- Combustion (Combustion - Rank 2)
    [108815] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }; -- Combustion (Combustion - Rank 2)
    [160949] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Warmth -- TODO: Maybe find a way to determine rank for the 15% or 30% snare tooltip

    [29455] = { icon = '/esoui/art/icons/passive_dragonknight_007.dds' }; -- Iron Skin (Iron Skin - Rank 1)
    [44922] = { icon = '/esoui/art/icons/passive_dragonknight_007.dds' }; -- Iron Skin (Iron Skin - Rank 2)

    [29451] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_world_in_ruin.dds' }; -- World in Ruin (World in Ruin - Rank 1)
    [45029] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_world_in_ruin.dds' }; -- World in Ruin (World in Ruin - Rank 2)

    -- Earthen Heart
    [29465] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }; -- Battle Roar (Battle Roar - Rank 1)
    [29466] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }; -- Battle Roar (Battle Roar - Rank 1)
    [29467] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }; -- Battle Roar (Battle Roar - Rank 1)
    [44986] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }; -- Battle Roar (Battle Roar - Rank 2)
    [44987] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }; -- Battle Roar (Battle Roar - Rank 2)
    [44988] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }; -- Battle Roar (Battle Roar - Rank 2)
    [29468] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_eternal_mountain.dds' }; -- Eternal Mountain (Eternal Mountain - Rank 1)
    [44996] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_eternal_mountain.dds' }; -- Eternal Mountain (Eternal Mountain - Rank 2)
    [29474] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds' }; -- Mountain's Blessing (Mountain's Blessing - Rank 1)
    [45005] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds' }; -- Mountain's Blessing (Mountain's Blessing - Rank 2)
    [29475] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_helping_hands.dds' }; -- Helping Hands (Helping Hands - Rank 1)
    [29476] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds' }; -- Helping Hands (Helping Hands - Rank 1)
    [45009] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_helping_hands.dds' }; -- Helping Hands (Helping Hands - Rank 2)
    [45010] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds' }; -- Helping Hands (Helping Hands - Rank 2)

    ----------------------------------------------------------------
    -- DRAGONKNIGHT ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------

    -- Lava Whip / Molten Whip / Flame Lash
    [23808] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Lava Whip)
    [20806] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Molten Whip)
    [122658] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_seething_fury.dds'; tooltip = Tooltips.Skill_Seething_Fury }; -- Seething Fury (Molten Whip)
    [34117] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Flame Lash)
    [20824] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds' }; -- Power Lash (Flame Lash)
    [23105] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds' }; -- Power Lash (Flame Lash)

    -- Searing Strike / Venomous Claw /Burning Embers
    [44363] = { tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Searing Strike (Searing Strike)
    [44369] = { tooltip = Tooltips.Skill_Venomous_Claw }; -- Venomous Claw (Venomous Claw)
    [44373] = { tooltip = Tooltips.Skill_Burning_Embers }; -- Burning Embers (Burning Embers)

    -- Fiery Breath / Noxious Breath / Engulfing Flames
    [31102] = { tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Fiery Breath (Fiery Breath)
    [31103] = { tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Noxious Breath (Noxious Breath)
    [31104] = { tooltip = Tooltips.Skill_Engulfing_Flames }; -- Engulfing Flames (Engulfing Flames)

    -- Fiery Grip / Empowering Chains / Unrelenting Grip
    [62004] = { hide = true }; -- Unrelenting Grip (Unrelenting Grip)
    [77105] = { icon = '/esoui/art/icons/ability_dragonknight_005_a.dds' }; -- Unrelenting Grip (Unrelenting Grip)

    -- Inferno / Flames of Oblivion / Cauterize
    [28967] = { tooltip = Tooltips.Skill_Inferno_Active }; -- Inferno (Inferno)
    [32853] = { tooltip = Tooltips.Skill_Flames_of_Oblivion_Active }; -- Flames of Oblivion (Flames of Oblivion)
    [32881] = { tooltip = Tooltips.Skill_Cauterize_Active }; -- Cauterize (Cauterize)

    -- Dragonknight Standard / Shifting Standard / Standard of Might
    [98438] = { name = Abilities.Skill_Shackle }; -- Shackle Damage (Dragonknight Standard - Shackle Synergy)
    [98447] = { name = Abilities.Skill_Shackle; tooltip = Tooltips.Generic_Immobilize }; -- Shackle Snare (Dragonknight Standard - Shackle Synergy)
    [28988] = { tooltip = Tooltips.Skill_Dragonknight_Standard }; -- Dragonknight Standard (Dragonknight Standard)
    [32958] = { tooltip = Tooltips.Skill_Shifting_Standard }; -- Shifting Standard (Shifting Standard)
    [70735] = { hide = true }; -- Shifting Standard (Shifting Standard)
    [32947] = { tooltip = Tooltips.Skill_Dragonknight_Standard }; -- Standard of Might (Standard of Might)
    [32956] = { icon = '/esoui/art/icons/ability_dragonknight_006_b.dds'; tooltip = Tooltips.Skill_Standard_of_Might_Buff; groundLabel = true }; -- Standard of Might (Standard of Might)

    [28995] = { groundLabel = true; tooltip = Tooltips.Skill_Dragonknight_Standard_Ground; tooltipValue2 = 1 }; -- Dragonknight Standard
    [32960] = { groundLabel = true; tooltip = Tooltips.Skill_Dragonknight_Standard_Ground; tooltipValue2 = 1 }; -- Shifting Standard
    [32964] = { groundLabel = true; tooltip = Tooltips.Skill_Dragonknight_Standard_Ground; tooltipValue2 = 1 }; -- Shifting Standard
    [32948] = { groundLabel = true; tooltip = Tooltips.Skill_Dragonknight_Standard_Ground; tooltipValue2 = 1 }; -- Standard of Might

    -- Spiked Armor / Hardened Armor / Volatile Armor
    [20319] = { tooltip = Tooltips.Skill_Spiked_Armor }; -- Spiked Armor (Spiked Armor)
    [20328] = { tooltip = Tooltips.Skill_Hardened_Armor }; -- Hardened Armor (Hardened Armor)
    [31808] = { tooltip = Tooltips.Generic_Damage_Shield_Duration; hideReduce = true }; -- Hardened Armor (Hardened Armor)
    [20323] = { tooltip = Tooltips.Skill_Spiked_Armor }; -- Volatile Armor (Volatile Armor)
    [20326] = { tooltip = Tooltips.Generic_Magic; tooltipValue2 = 2 }; -- Volatile Armor (Volatile Armor)

    -- Dark Talons / Burning Talons / Choking Talons
    [20527] = { tooltip = Tooltips.Generic_Immobilize }; -- Dark Talons (Dark Talons)
    [31898] = { tooltip = Tooltips.Skill_Burning_Talons }; -- Burning Talons (Burning Talons)
    [20253] = { hideReduce = true; tooltip = Tooltips.Skill_Burning_Talons }; -- Burning Talons (Burning Talons)
    [20528] = { tooltip = Tooltips.Generic_Immobilize }; -- Choking Talons (Choking Talons)

    -- Protective Scale / Protective Plate / Dragon Fire Scale
    [21007] = { tooltip = Tooltips.Skill_Protective_Scale }; -- Protective Scale (Protective Scale)
    [21014] = { tooltip = Tooltips.Skill_Protective_Plate }; -- Protective Plate (Protective Plate)
    [108798] = { tooltip = Tooltips.Skill_Protective_Plate; hideReduce = true; noDuplicate = true }; -- Protective Plate (Protective Plate)
    [21017] = { tooltip = Tooltips.Skill_Dragon_Fire_Scale }; -- Dragon Fire Scale (Dragon Fire Scale)

    -- Inhale / Deep Breath / Draw Essence
    [31841] = { icon = '/esoui/art/icons/ability_dragonknight_012.dds'; tooltip = Tooltips.Skill_Inhale }; -- Inhale (Inhale)
    [31859] = { icon = '/esoui/art/icons/ability_dragonknight_012.dds'; name = Abilities.Skill_Inhale }; -- Inhale Heal (Inhale)
    [32796] = { icon = '/esoui/art/icons/ability_dragonknight_012_a.dds'; tooltip = Tooltips.Skill_Inhale }; -- Deep Breath (Deep Breath)
    [32795] = { icon = '/esoui/art/icons/ability_dragonknight_012_a.dds' }; -- Deep Breath (Deep Breath)
    [32797] = { icon = '' }; -- Deep Breath (Deep Breath) -- Hide for Interrupt notification on Combat Text
    [32788] = { icon = '/esoui/art/icons/ability_dragonknight_012_b.dds'; tooltip = Tooltips.Skill_Draw_Essence }; -- Draw Essence (Draw Essence)
    [32786] = { icon = '/esoui/art/icons/ability_dragonknight_012_b.dds' }; -- Draw Essence (Draw Essence)
    [32789] = { icon = '/esoui/art/icons/ability_dragonknight_012_b.dds' }; -- Draw Essence (Draw Essence)

    -- Dragon Leap / Take Flight / Ferocious Leap
    [29016] = { icon = '/esoui/art/icons/ability_dragonknight_009.dds' }; -- Dragon Leap (Dragon Leap)
    [114590] = { name = Abilities.Skill_Dragon_Leap; tooltip = Tooltips.Generic_Knockback }; -- Stun (Dragon Leap)
    [118928] = { icon = '/esoui/art/icons/ability_dragonknight_009.dds'; hide = true }; -- Dragon Leap (Dragon Leap)
    [114600] = { name = Abilities.Skill_Take_Flight; tooltip = Tooltips.Generic_Knockback }; -- Stun (Take Flight)
    [118936] = { icon = '/esoui/art/icons/ability_dragonknight_009_b.dds'; hide = true }; -- Take Flight (Take Flight)
    [61814] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Ferocious Leap (Ferocious Leap)
    [114601] = { name = Abilities.Skill_Ferocious_Leap; tooltip = Tooltips.Generic_Knockback }; -- Stun (Ferocious Leap)
    [118938] = { icon = '/esoui/art/icons/ability_dragonknight_009_a.dds'; hide = true }; -- Ferocious Leap (Ferocious Leap)

    -- Stonefist / Obsidian Shard / Stone Giant
    [29032] = { tooltip = Tooltips.Skill_Stonefist }; -- Stonefist (Stonefist)
    [134009] = { tooltip = Tooltips.Generic_Knockdown }; -- Stonefist (Stonefist)

    [68763] = { icon = '/esoui/art/icons/ability_dragonknight_013_b.dds' }; -- Obsidian Shard (Obsidian Shard)

    [31816] = { tooltip = Tooltips.Skill_Stone_Giant }; -- Stone Giant (Stone Giant)
    [134336] = { tooltip = Tooltips.Skill_Stagger }; -- Stagger (Stone Giant)
    [134355] = { tooltip = Tooltips.Generic_Knockdown }; -- Stone Giant (Stone Giant)

    -- Molten Weapons / Igneous Weapons / Molten Armaments
    [76537] = { tooltip = Tooltips.Skill_Molten_Armaments }; -- Molten Armaments (Molten Armaments)

    -- Obsidian Shield / Igneous Shield / Fragmented Shield
    [29071] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Obsidian Shield (Obsidian Shield)
    [29224] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Igneous Shield (Igneous Shield)
    [32673] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Fragmented Shield (Fragmented Shield)

    -- Petrify / Fossilize / Shattering Rocks
    [29037] = { tooltip = Tooltips.Skill_Petrify_Stun }; -- Petrify (Petrify)
    [32685] = { tooltip = Tooltips.Skill_Fossilize_Stun }; -- Fossilize (Fossilize)
    [61785] = { tooltip = Tooltips.Generic_Immobilize }; -- Fossilize (Fossilize)
    [32678] = { tooltip = Tooltips.Skill_Shattering_Rocks_Stun }; -- Shattering Rocks (Shattering Rocks)

    -- Ash Cloud / Cinder Storm / Eruption
    [29059] = { tooltip = Tooltips.Skill_Ash_Cloud }; -- Ash Cloud (Ash Cloud)
    [29126] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 70 }; -- Ash Cloud (Ash Cloud)
    [20779] = { tooltip = Tooltips.Skill_Ash_Cloud }; -- Cinder Storm (Cinder Storm)
    [20780] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 70 }; -- Cinder Storm (Cinder Storm)
    [32710] = { tooltip = Tooltips.Skill_Eruption }; -- Eruption (Eruption)
    [32712] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 1; tooltipValue3 = 70; hideGround = true }; -- Eruption (Eruption)

    [61772] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Ash Cloud (Ash Cloud)
    [34791] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Cinder Storm (Cinder Storm)
    [32711] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 1; tooltipValue3 = 70 }; -- Eruption (Eruption)

    -- Magma Armor / Magma Shell / Corrosive Armor
    [15957] = { tooltip = Tooltips.Skill_Magma_Armor }; -- Magma Armor (Magma Armor)
    [17874] = { tooltip = Tooltips.Skill_Magma_Armor }; -- Magma Shell (Magma Shell)
    [76483] = { refreshOnly = true; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Magma Shell (Magma Shell)
    [17878] = { tooltip = Tooltips.Skill_Corrosive_Armor }; -- Corrosive Armor (Corrosive Armor)

    ----------------------------------------------------------------
    -- NIGHTBLADE PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    -- Assassination
    [36616] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_master_assassin.dds' };
    [45038] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_master_assassin.dds' };
    [36630] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_executioner.dds' }; -- Executioner (Executioner - Rank 1)
    [101435] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }; -- Executioner (Executioner - Rank 1)
    [36633] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }; -- Executioner (Executioner - Rank 1)
    [45048] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_executioner.dds' }; -- Executioner (Executioner - Rank 2)
    [101436] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }; -- Executioner (Executioner - Rank 2)
    [45050] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }; -- Executioner (Executioner - Rank 2)
    [36636] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_pressure_points.dds' };
    [45053] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_pressure_points.dds' };
    [36641] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_hemorrhage.dds' };
    [45060] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_hemorrhage.dds' };

    -- Shadow
    [36549] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_refreshing_shadows.dds' };
    [45103] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_refreshing_shadows.dds' };
    [18866] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_shadow_barrier.dds' };
    [45071] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_shadow_barrier.dds' };
    [36532] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_vigor.dds' };
    [45084] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_vigor.dds' };
    [36552] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_veil.dds' };
    [45115] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_veil.dds' };

    -- Siphoning
    [36560] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_catalyst.dds' }; -- Catalyst (Catalyst - Rank 1)
    [63705] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds' }; -- Amphibious Regen (Catalyst - Rank 1)
    [45135] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_catalyst.dds' }; -- Catalyst (Catalyst - Rank 2)
    [63707] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds' }; -- Amphibious Regen (Catalyst - Rank 2)
    [36595] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_magicka_flood.dds' };
    [45150] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_magicka_flood.dds' };
    [36603] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_soul_siphoner.dds' };
    [45155] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_soul_siphoner.dds' };
    [36587] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_transfer.dds' }; -- Transfer (Transfer - Rank 1)
    [36589] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds' }; -- Transfer (Transfer - Rank 1)
    [45145] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_transfer.dds' }; -- Transfer (Transfer - Rank 2)
    [45146] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds' }; -- Transfer (Transfer - Rank 2)

    ----------------------------------------------------------------
    -- NIGHTBLADE ACTIVES ------------------------------------------
    ----------------------------------------------------------------

    -- Assassin's Blade / Killer's Blade / Impale
    [61787] = { icon = '/esoui/art/icons/ability_nightblade_017_a.dds' }; -- Killer's Blade (Killer's Blade)

    -- Teleport Strike / Lotus Fan / Ambush
    [35336] = { tooltip = Tooltips.Generic_Magic; tooltipValue2 = 2 }; -- Lotus Fan (Lotus Fan)

    -- Blur / Mirage / Phantasmal Escape
    [125314] = { tooltip = Tooltips.Innate_Snare_Immobilize_Immunity }; -- Phantasmal Escape (Phantasmal Escape)

    -- Mark Target / Piercing Mark / Reaper's Mark
    [33357] = { tooltip = Tooltips.Skill_Mark_Target }; -- Mark Target (Mark Target)
    [33373] = { icon = '/esoui/art/icons/ability_nightblade_014.dds' }; -- Mark Target (Mark Target)
    [36968] = { tooltip = Tooltips.Skill_Mark_Target }; -- Piercing Mark (Piercing Mark)
    [36994] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_marked.dds'; name = Abilities.Skill_Marked; tooltip = Tooltips.Generic_Marked }; -- Piercing Mark (Piercing Mark)
    [36983] = { icon = '/esoui/art/icons/ability_nightblade_014_b.dds' }; -- Mark Target (Piercing Mark)
    [36967] = { tooltip = Tooltips.Skill_Reapers_Mark }; -- Reaper's Mark (Reaper's Mark)
    [36975] = { icon = '/esoui/art/icons/ability_nightblade_014_a.dds' }; -- Reaper's Mark (Reaper's Mark)

    -- Grim Focus / Relentless Focus / Merciless Resolve
    [61905] = { icon = '/esoui/art/icons/ability_nightblade_005.dds' }; -- Grim Focus (Grim Focus)
    [122585] = { tooltip = Tooltips.Skill_Grim_Focus_Defense }; -- Grim Focus (Grim Focus)

    [107054] = { icon = '/esoui/art/icons/ability_nightblade_005_a.dds' }; -- Relentless Focus (Relentless Focus)
    [122587] = { tooltip = Tooltips.Skill_Grim_Focus_Defense }; -- Relentless Focus (Relentless Focus)

    [107055] = { icon = '/esoui/art/icons/ability_nightblade_005_b.dds' }; -- Merciless Resolve (Merciless Resolve)
    [122586] = { tooltip = Tooltips.Skill_Grim_Focus_Defense }; -- Merciless Resolve (Merciless Resolve)

    -- Death Stroke / Incapacitating Strike / Soul Harvest
    [61389] = { icon = '/esoui/art/icons/ability_nightblade_007.dds'; name = Abilities.Skill_Death_Stroke; tooltip = Tooltips.Skill_Death_Stroke_Debuff }; -- Damage Taken Increased (Death Stroke)
    [125922] = { icon = '/esoui/art/icons/ability_nightblade_007_a.dds' }; -- Reave (Incapacitating Strike)
    [125923] = { icon = '/esoui/art/icons/ability_nightblade_007_a.dds' }; -- Reave (Incapacitating Strike)
    [61393] = { name = Abilities.Skill_Incapacitating_Strike; tooltip = Tooltips.Skill_Death_Stroke_Debuff }; -- Damage Taken Increased (Incapacitating Strike)
    [113107] = { icon = '/esoui/art/icons/ability_nightblade_007_c.dds'; name = Abilities.Skill_Incapacitating_Strike; tooltip = Tooltips.Skill_Incapacitating_Strike }; -- Damage Taken Increased (Incapacitating Strike)
    [126444] = { icon = '/esoui/art/icons/ability_nightblade_007_c.dds'; tooltip = Tooltips.Skill_Incapacitating_Strike; hideReduce = true }; -- Incapacitating Strike (Incapacitating Strike)
    [61400] = { name = Abilities.Skill_Soul_Harvest; tooltip = Tooltips.Skill_Death_Stroke_Debuff }; -- Damage Taken Increased (Soul Harvest)
    [36519] = { icon = '/esoui/art/icons/ability_nightblade_007_b.dds'; name = Abilities.Skill_Soul_Harvest }; -- Rapid Stroke Passive (Soul Harvest)

    -- Veiled Strike / Surprised Attack / Concealed Weapon
    [25256] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Veiled Strike)
    [34733] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Surprise Attack)
    [34737] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Concealed Weapon)
    [34736] = { tooltip = Tooltips.Generic_Stun }; -- Concealed Weapon (Concealed Weapon)

    -- Shadow Cloak / Shadowy Disguise / Dark Cloak
    [25375] = { hide = true }; -- Shadow Cloak (Shadow Cloak)
    [25376] = { tooltip = Tooltips.Generic_Invisibility }; -- Shadow Cloak (Shadow Cloak)
    [25380] = { hide = true }; -- Shadowy Disguise (Shadowy Disguise)
    [25381] = { hide = true }; -- Shadowy Disguise (Shadowy Disguise)
    [62141] = { tooltip = Tooltips.Skill_Shadowy_Disguise }; -- Shadowy Disguise (Shadowy Disguise)
    [25377] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Dark Cloak (Dark Cloak)

    -- Path of Darkness / Twisting Path / Refreshing Path
    [33195] = { tooltip = Tooltips.Skill_Path_of_Darkness }; -- Path of Darkness (Path of Darkness)
    [36049] = { tooltip = Tooltips.Skill_Twisting_Path }; -- Twisting Path (Twisting Path)
    [36052] = { tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1; groundLabel = true }; -- Twisting Path (Twisting Path)
    [36028] = { tooltip = Tooltips.Skill_Refreshing_Path }; -- Refreshing Path (Refreshing Path)
    [64006] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Refreshing Path (Refreshing Path)

    -- Aspect of Terror / Mass Hysteria / Manifestation of Terror
    [25352] = { tooltip = Tooltips.Generic_Fear }; -- Aspect of Terror (Aspect of Terror)
    [37470] = { tooltip = Tooltips.Generic_Fear }; -- Mass Hysteria (Mass Hysteria)
    [37475] = { tooltip = Tooltips.Skill_Manifestation_of_Terror }; -- Manifestation of Terror (Manifestation of Terror)
    [76639] = { tooltip = Tooltips.Generic_Fear }; -- Manifestation of Terror (Manifestation of Terror)
    [76635] = { hide = true }; -- Remove Trap (Manifestation of Terror)
    [38208] = { hide = true }; -- Birth Manifestation of Terror (Manifestation of Terror)
    [76632] = { hide = true }; -- Manifestation of Terror (Manifestation of Terror)

    -- Summon Shade / Dark Shade / Shadow Image
    [65269] = { hide = true }; -- Shade Initialize (Summon Shade - All Morphs)
    [33219] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds' }; -- Corrosive Strike (Shade) (Summon Shade - Summon Shade/Dark Shade)
    [38517] = { hide = true; tooltip = Tooltips.Skill_Summon_Shade }; -- Summon Shade (Summon Shade)
    [88662] = { hide = true; tooltip = Tooltips.Skill_Summon_Shade }; -- Summon Shade (Summon Shade) -- Khajiit
    [88663] = { hide = true; tooltip = Tooltips.Skill_Summon_Shade }; -- Summon Shade (Summon Shade) -- Argonian

    [35438] = { hide = true; tooltip = Tooltips.Skill_Dark_Shade }; -- Summon Shade (Dark Shade)
    [88677] = { hide = true; tooltip = Tooltips.Skill_Dark_Shade }; -- Summon Shade (Dark Shade) -- Khajiit
    [88678] = { hide = true; tooltip = Tooltips.Skill_Dark_Shade }; -- Summon Shade (Dark Shade) -- Argonian
    [123945] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds'; name = Abilities.Skill_Corrosive_Strike }; -- Corrosive Flurry (Dark Shade)
    [108936] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_whirlwind.dds'; name = Abilities.Skill_Corrosive_Spin }; -- Corrosive Slash (Dark Shade)

    [38528] = { name = Abilities.Skill_Shadow_Image; hide = true; tooltip = Tooltips.Skill_Shadow_Image }; -- Shadow (Shadow Image)
    [88696] = { name = Abilities.Skill_Shadow_Image; hide = true; tooltip = Tooltips.Skill_Shadow_Image }; -- Shadow (Shadow Image) -- Khajiit
    [88697] = { name = Abilities.Skill_Shadow_Image; hide = true; tooltip = Tooltips.Skill_Shadow_Image }; -- Shadow (Shadow Image) -- Argonian
    [35445] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadow_image_teleport.dds' }; -- Shadow Image Teleport (Shadow Image)
    [51556] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode_ranged.dds' }; -- Corrosive Arrow (Shadow Image)

    -- Consuming Darkness / Bolstering Darkness / Veil of Blades
    [37729] = { tooltip = Tooltips.Skill_Hidden_Refresh; hideReduce = true }; -- Hidden Refresh (Hidden Refresh)
    [37732] = { tooltip = Tooltips.Skill_Hidden_Refresh }; -- Hidden Refresh (Hidden Refresh)
    [25411] = { tooltip = Tooltips.Skill_Consuming_Darkness }; -- Consuming Darkness (Consuming Darkness)
    [25412] = { tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 70; groundLabel = true }; -- Consuming Darkness (Consuming Darkness)
    [36493] = { tooltip = Tooltips.Skill_Bolstering_Darkness }; -- Bolstering Darkness (Bolstering Darkness)
    [36495] = { tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 70; groundLabel = true }; -- Bolstering Darkness (Bolstering Darkness)
    [36485] = { tooltip = Tooltips.Skill_Veil_of_Blades }; -- Veil of Blades (Veil of Blades)
    [36490] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Magic; tooltipValue2 = 1; tooltipValue3 = 70 }; -- Veil of Blades (Veil of Blades)
    [36487] = { tooltip = Tooltips.Generic_AOE_Snare_Magic; tooltipValue2 = 1; tooltipValue3 = 70; groundLabel = true; hideGround = true }; -- Veil of Blades (Veil of Blades)

    -- Strife / Funnel Health / Swallow Soul
    [33292] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Strife (Strife)
    [34841] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Funnel Health (Funnel Health)
    [34836] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Swallow Soul (Swallow Soul)

    -- Malevolent Offering / Shrewd Offering / Healthy Offering
    [108925] = { unbreakable = 1; tooltip = Tooltips.Skill_Malevolent_Offering }; -- Malevolent Offering (Malevolent Offering)
    [108927] = { unbreakable = 1; tooltip = Tooltips.Skill_Malevolent_Offering }; -- Shrewd Offering (Shrewd Offering)
    [108932] = { unbreakable = 1; tooltip = Tooltips.Skill_Malevolent_Offering }; -- Healthy Offering (Healthy Offering)

    -- Cripple / Debilitate / Crippling Grasp
    [33333] = { tooltip = Tooltips.Skill_Cripple; tooltipValue2 = 30 }; -- Cripple (Cripple)
    [33327] = { icon = '/esoui/art/icons/ability_nightblade_006.dds'; tooltip = Tooltips.Skill_Cripple; tooltipValue2 = 30; hideReduce = true }; -- Cripple (Cripple)
    [36947] = { tooltip = Tooltips.Skill_Debilitate; tooltipValue2 = 50 }; -- Debilitate (Debilitate)
    [36945] = { icon = '/esoui/art/icons/ability_nightblade_006_a.dds'; tooltip = Tooltips.Skill_Debilitate; tooltipValue2 = 50; hideReduce = true }; -- Debilitate (Debilitate)
    [36960] = { tooltip = Tooltips.Skill_Crippling_Grasp }; -- Crippling Grasp (Crippling Grasp)
    [36958] = { icon = '/esoui/art/icons/ability_nightblade_006_b.dds'; tooltip = Tooltips.Skill_Crippling_Grasp; hideReduce = true }; -- Crippling Grasp (Crippling Grasp)
    [36963] = { icon = '/esoui/art/icons/ability_nightblade_006_b.dds' }; -- Crippling Grasp (Crippling Grasp)
    [36964] = { tooltip = Tooltips.Skill_Crippling_Grasp; hideReduce = true }; -- Crippling Grasp (Crippling Grasp)

    -- Siphoning Strikes / Leeching Strikes / Siphoning Attacks
    [33319] = { tooltip = Tooltips.Skill_Siphoning_Strikes }; -- Siphoning Strikes (Siphoning Strikes)
    [33321] = { icon = '/esoui/art/icons/ability_nightblade_003.dds' }; -- Siphoning Strikes (Siphoning Strikes)
    [114957] = { icon = '/esoui/art/icons/ability_nightblade_003.dds' }; -- Siphoning Strikes (Siphoning Strikes)
    [36908] = { tooltip = Tooltips.Skill_Leeching_Strikes }; -- Leeching Strikes (Leeching Strikes)
    [36935] = { tooltip = Tooltips.Skill_Siphoning_Attacks }; -- Siphoning Attacks (Siphoning Attacks)

    -- Drain Power / Power Extraction / Sap Essence
    [36899] = { icon = '/esoui/art/icons/ability_nightblade_013_a.dds'; name = Abilities.Skill_Sap_Essence }; -- Sap Will (Sap Essence)

    -- Soul Shred / Soul Siphon / Soul Tether
    [25171] = { icon = '/esoui/art/icons/ability_nightblade_018.dds' }; -- Soul Leech (Synergy - Soul Shred)
    [25093] = { tooltip = Tooltips.Generic_Stun }; -- Soul Shred (Soul Shred)
    [35508] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 0.5 }; -- Soul Siphon (Soul Siphon)
    [35613] = { hide = true }; -- Soul Leech (Soul Siphon)
    [35466] = { tooltip = Tooltips.Skill_Soul_Tether; hideReduce = true }; -- Soul Tether (Soul Tether)
    [129384] = { icon = '/esoui/art/icons/ability_nightblade_018_a.dds' }; -- Soul Tether (Soul Tether)
    [36606] = { icon = '/esoui/art/icons/ability_nightblade_018_a.dds' }; -- Soul Tether (Soul Tether)
    [35462] = { tooltip = Tooltips.Skill_Soul_Tether }; -- Soul Tether (Soul Tether)
    [35461] = { hide = true }; -- Soul Leech (Soul Tether)

    ----------------------------------------------------------------
    -- SORCERER PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    -- Dark Magic
    --[31386] = { icon = 'esoui/art/icons/ability_sorcerer_030.dds' }, -- Unholy Knowledge
    --[45176] = { icon = 'esoui/art/icons/ability_sorcerer_030.dds' }, -- Unholy Knowledge

    [31378] = { icon = '/esoui/art/icons/ability_sorcerer_024.dds' }; -- Persistance
    [45165] = { icon = '/esoui/art/icons/ability_sorcerer_024.dds' }; -- Persistance
    [108858] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_persistence.dds'; name = Abilities.Passive_Persistence; tooltip = Tooltips.Skill_Persistence_Rank_1 }; -- Persistance Cost Reduction (Persistence - Rank 1)
    [108862] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_persistence.dds'; name = Abilities.Passive_Persistence; tooltip = Tooltips.Skill_Persistence_Rank_2 }; -- Persistance Cost Reduction (Persistence - Rank 2)

    [31384] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds' }; -- Blood Magic (Blood Magic - Rank 1)
    [45173] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds' }; -- Blood Magic (Blood Magic - Rank 2)

    -- Daedric Summoning

    [31398] = { icon = '/esoui/art/icons/ability_sorcerer_054.dds' }; -- Rebate (Rebate - Rank 1)
    [45198] = { icon = '/esoui/art/icons/ability_sorcerer_054.dds' }; -- Rebate (Rebate - Rank 2)

    [64849] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds' }; -- Rebate (Rebate - Rank 1)
    [143500] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds' }; -- Rebate (Rebate - Rank 2)

    [31417] = { icon = '/esoui/art/icons/ability_sorcerer_056.dds' }; -- Daedric Protection (Daedric Protection - Rank 1)
    [45200] = { icon = '/esoui/art/icons/ability_sorcerer_056.dds' }; -- Daedric Protection (Daedric Protection - Rank 2)

    [31412] = { icon = '/esoui/art/icons/ability_sorcerer_044.dds' }; -- Expert Summoner (Expert Summoner - Rank 1)
    [45199] = { icon = '/esoui/art/icons/ability_sorcerer_044.dds' }; -- Expert Summoner (Expert Summoner - Rank 2)

    -- Storm Calling

    [31419] = { icon = 'LuiExtended/media/icons/abilities/passive_sorcerer_capacitor.dds' }; -- Capacitor
    [45188] = { icon = 'LuiExtended/media/icons/abilities/passive_sorcerer_capacitor.dds' }; -- Capacitor

    [31421] = { icon = '/esoui/art/icons/ability_sorcerer_068.dds' }; -- Energized (Energized - Rank 1)
    [45190] = { icon = '/esoui/art/icons/ability_sorcerer_068.dds' }; -- Energized (Energized - Rank 2)

    --[31422] = { icon = 'esoui/art/icons/ability_sorcerer_054.dds' }, -- Amplitude (Amplitude - Rank 1)
    --[45192] = { icon = 'esoui/art/icons/ability_sorcerer_054.dds' }, -- Amplitude (Amplitude - Rank 2)

    [31425] = { icon = '/esoui/art/icons/ability_sorcerer_070.dds' }; -- Expert Mage (Expert Mage - Rank 1)
    [45195] = { icon = '/esoui/art/icons/ability_sorcerer_070.dds' }; -- Expert Mage (Expert Mage - Rank 2)

    ----------------------------------------------------------------
    -- SORCERER ACTIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Crystal Shard / Crystal Weapon / Crystal Fragments
    [143744] = { tooltip = Tooltips.Skill_Crystal_Weaver }; -- Crystal Weaver (Crystal Shard)

    [46331] = { tooltip = Tooltips.Skill_Crystal_Weapon }; -- Crystal Weapon (Crystal Weapon)
    [143808] = { tooltip = Tooltips.Generic_Reduce_Physical_Spell_Resist_Value; tooltipValue2 = 1000 }; -- Crystal Weapon (Crystal Weapon)

    [46327] = { name = Abilities.Skill_Crystal_Fragments; tooltip = Tooltips.Skill_Crystal_Fragments }; -- Crystal Fragments Proc (Crystal Fragments)

    -- Encase / Shattering Prison / Restraining Prison
    [28025] = { tooltip = Tooltips.Generic_Immobilize }; -- Encase (Encase)
    [28308] = { tooltip = Tooltips.Skill_Shattering_Prison }; -- Shattering Prison (Shattering Prison)
    [28311] = { tooltip = Tooltips.Generic_Immobilize }; -- Restraining Prison (Restraining Prison)

    -- Encase  + Morphs Resource Restore
    [143659] = { icon = '/esoui/art/icons/ability_sorcerer_cyclone.dds' }; -- Encase (Encase)
    [143663] = { icon = '/esoui/art/icons/ability_sorcerer_twister.dds' }; -- Shattering Prison (Shattering Prison)
    [143668] = { icon = '/esoui/art/icons/ability_sorcerer_crushing_winds.dds' }; -- Restraining Prison (Restraining Prison)

    -- Rune Prison / Rune Cage / Defensive Rune
    [24371] = { hide = true }; -- Rune Prison (Rune Prison)
    [24559] = { tooltip = Tooltips.Generic_Stun }; -- Rune Prison (Rune Prison)
    [24578] = { hide = true }; -- Rune Cage (Rune Cage)
    [24581] = { tooltip = Tooltips.Skill_Rune_Cage }; -- Rune Cage (Rune Cage)
    [24574] = { tooltip = Tooltips.Skill_Defensive_Rune }; -- Defensive Rune (Defensive Rune)
    [114602] = { hide = true }; -- Defensive Rune Constrict (Defensive Rune)
    [24576] = { tooltip = Tooltips.Generic_Stun }; -- Defensive Rune (Defensive Rune)

    -- Dark Exchange / Dark Deal / Dark Conversion
    [114903] = { tooltip = Tooltips.Generic_Magicka_Regen_Value; tooltipValue2 = 1; tooltipValue3 = 120 }; -- Dark Exchange (Dark Exchange)
    [114908] = { tooltip = Tooltips.Generic_Stamina_Regen_Value; tooltipValue2 = 1; tooltipValue3 = 120 }; -- Dark Deal (Dark Deal)
    [114909] = { tooltip = Tooltips.Generic_Magicka_Regen_Value; tooltipValue2 = 1; tooltipValue3 = 120 }; -- Dark Conversion (Dark Conversion)

    -- Daedric Mines / Daedric Tomb / Daedric Minefield
    [24830] = { icon = '/esoui/art/icons/ability_sorcerer_daedric_mines.dds'; tooltip = Tooltips.Skill_Daedric_Mines }; -- Daedric Mines (Daedric Mines)
    [27935] = { tooltip = Tooltips.Generic_Immobilize }; -- Daedric Mines (Daedric Mines)
    [24847] = { icon = '/esoui/art/icons/ability_sorcerer_daedric_tomb.dds'; name = Abilities.Skill_Daedric_Tomb; tooltip = Tooltips.Skill_Daedric_Mines }; -- Daedric Mines (Daedric Tomb)
    [28452] = { tooltip = Tooltips.Generic_Immobilize }; -- Daedric Tomb (Daedric Tomb)
    [25158] = { icon = '/esoui/art/icons/ability_sorcerer_daedric_minefield.dds'; name = Abilities.Skill_Daedric_Minefield; tooltip = Tooltips.Skill_Daedric_Mines }; -- Daedric Mines (Daedric Minefield)
    [28454] = { tooltip = Tooltips.Generic_Immobilize }; -- Daedric Minefield (Daedric Minefield)

    -- Negate Magic / Suppression Field / Absorption Field
    [27706] = { tooltip = Tooltips.Skill_Negate_Magic }; -- Negate Magic (Negate Magic)
    [29824] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Silence_No_Dur }; -- Negate Magic (Negate Magic)
    [47147] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Stun_No_Dur }; -- Negate Magic (Negate Magic)
    [28341] = { tooltip = Tooltips.Skill_Suppression_Field }; -- Suppression Field (Suppression Field)
    [47160] = { duration = 0; groundLabel = true; tooltip = Tooltips.Skill_Suppression_Field_Silence; hideGround = true }; -- Suppression Field (Suppression Field)
    [47159] = { duration = 0; groundLabel = true; tooltip = Tooltips.Skill_Suppression_Field_Stun }; -- Suppression Field (Suppression Field)
    [80435] = { groundLabel = true; tooltip = Tooltips.Skill_Suppression_Field_Silence }; -- Suppression Field (Suppression Field)
    [28348] = { tooltip = Tooltips.Skill_Absorption_Field }; -- Absorption Field (Absorption Field)
    [47168] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Silence_No_Dur }; -- Absorption Field (Absorption Field)
    [47167] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Stun_No_Dur }; -- Absorption Field (Absorption Field)
    [80405] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 0.5 }; -- Absorption Field (Absorption Field)

    -- Summon Unstable Familiar / Summon Unstable Clannfear / Summon Volatile Familiar
    [27287] = { hide = true }; -- Birth Unstable Familiar (Summon Unstable Familiar - All Morphs)
    [23304] = { tooltip = Tooltips.Skill_Unstable_Familiar; toggle = true }; -- Summon Unstable Familiar (Summon Unstable Familiar)
    [27850] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_familiar_melee.dds'; name = Abilities.Skill_Entropic_Touch }; -- Familiar Melee (Summon Unstable Familiar + Summon Volatile Familiar)
    [108840] = { icon = '/esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds' }; -- Summon Unstable Familiar (Summon Unstable Familiar)
    [108842] = { name = Abilities.Skill_Unstable_Pulse; tooltip = Tooltips.Skill_Familiar_Damage_Pulse; icon = '/esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds' }; -- Volatile Familiar Damage Pulsi (Summon Unstable Familiar)
    [108843] = { name = Abilities.Skill_Unstable_Pulse; tooltip = Tooltips.Skill_Familiar_Damage_Pulse_Self; icon = '/esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds' }; -- Volatile Familiar (Summon Unstable Familiar)
    [108844] = { name = Abilities.Skill_Unstable_Pulse; icon = '/esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds' }; -- Familiar Damage Pulse (Summon Unstable Familiar)
    [23319] = { tooltip = Tooltips.Skill_Unstable_Clannfear; toggle = true }; -- Summon Unstable Clannfear (Summon Unstable Clannfear)
    [29528] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_headbutt.dds'; name = Abilities.Skill_Headbutt }; -- Claw (Summon Unstable Clannfear)
    [29529] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_tail_spike.dds' }; -- Tail Spike (Summon Unstable Clannfear)
    [23316] = { tooltip = Tooltips.Skill_Volatile_Familiar; toggle = true }; -- Summon Volatile Familiar (Summon Volatile Familiar)
    [77187] = { name = Abilities.Skill_Volatile_Pulse; tooltip = Tooltips.Skill_Familiar_Stun_Pulse }; -- Volatile Familiar Damage Pulsi (Summon Volatile Familiar)
    [88933] = { name = Abilities.Skill_Volatile_Pulse; tooltip = Tooltips.Skill_Familiar_Stun_Pulse_Self }; -- Volatile Familiar (Summon Volatile Familiar)
    [77186] = { name = Abilities.Skill_Volatile_Pulse }; -- Familiar Damage Pulse (Summon Volatile Familiar)
    [77243] = { tooltip = Tooltips.Generic_Stun; name = Abilities.Skill_Volatile_Pulse }; -- Volatile Familiar Stun (Summon Volatile Familiar)
    [117255] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_familiar_melee.dds'; name = Abilities.Skill_Entropic_Touch }; -- Volatile Familiar Melee (Summon Volatile Familiar)

    -- Daedric Curse / Daedric Prey / Haunting Curse
    [24326] = { tooltip = Tooltips.Skill_Daedric_Curse }; -- Daedric Curse (Daedric Curse)
    [24328] = { tooltip = Tooltips.Skill_Daedric_Prey }; -- Daedric Prey (Daedric Prey)
    [24330] = { tooltip = Tooltips.Skill_Haunting_Curse; stack = 2 }; -- Haunting Curse (Haunting Curse)
    [89491] = { tooltip = Tooltips.Skill_Haunting_Curse; stack = 1 }; -- Haunting Curse (Haunting Curse)

    -- Summon Winged Twilight / Summon Twilight Tormentor / Summon Twilight Matriarch
    [24617] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_zap.dds'; name = Abilities.Skill_Zap }; -- Zap (Summon Winged Twilight - All Morphs)
    [28027] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_kick.dds'; name = Abilities.Skill_Kick }; -- Kick (Summon Winged Twilight - All Morphs)
    [24613] = { tooltip = Tooltips.Skill_Winged_Twilight; toggle = true }; -- Summon Winged Twilight (Summon Winged Twilight)
    [24739] = { hide = true }; -- Summon Winged Twilight (Summon Winged Twilight)
    [108845] = { icon = '/esoui/art/icons/ability_sorcerer_lightning_prey_summoned.dds' }; -- Winged Twilight Restore (Summon Winged Twilight)
    [108847] = { icon = '/esoui/art/icons/ability_sorcerer_lightning_prey_summoned.dds' }; -- Winged Twilight Restore (Summon Winged Twilight)
    [108846] = { icon = '/esoui/art/icons/ability_sorcerer_lightning_prey_summoned.dds' }; -- Winged Twilight Restore (Summon Winged Twilight)
    [24636] = { tooltip = Tooltips.Skill_Twilight_Tormentor; toggle = true }; -- Summon Twilight Tormentor (Summon Twilight Tormentor)
    [24741] = { hide = true }; -- Twilight Tormentor (Summon Twilight Tormentor)
    [77354] = { tooltip = Tooltips.Skill_Tormentor_Damage_Boost }; -- Twilight Tormentor Enrage (Summon Twilight Tormentor)
    [88937] = { tooltip = Tooltips.Skill_Tormentor_Damage_Boost_Self }; -- Twilight Tormentor Enrage (Summon Twilight Tormentor)
    [117274] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_zap.dds'; name = Abilities.Skill_Zap }; -- Twilight Tormentor Zap (Summon Twilight Tormentor)
    [117273] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_kick.dds'; name = Abilities.Skill_Kick }; -- Twilight Tormentor Kick (Summon Twilight Tormentor)
    [24639] = { tooltip = Tooltips.Skill_Twilight_Matriarch; toggle = true }; -- Summon Twilight Matriarch (Summon Twilight Matriarch)
    [24742] = { hide = true }; -- Twilight Matriarch (Summon Twilight Matriarch)
    [117321] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_zap.dds'; name = Abilities.Skill_Zap }; -- Twilight Matriarch Zap (Summon Twilight Matriarch)
    [117320] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_kick.dds'; name = Abilities.Skill_Kick }; -- Twilight Matriarch Kick (Summon Twilight Matriarch)

    -- Conjured Ward / Hardened Ward / Empowered Ward
    [28418] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Conjured Ward (Conjured Ward)
    [28421] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Conjured Ward (Conjured Ward)
    [28832] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Conjured Ward (Conjured Ward)
    [29489] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Hardened Ward (Hardened Ward)
    [29490] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Hardened Ward (Hardened Ward)
    [29491] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Hardened Ward (Hardened Ward)
    [29482] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Empowered Ward (Empowered Ward)
    [29483] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Empowered Ward (Empowered Ward)
    [29484] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Empowered Ward (Empowered Ward)

    -- Bound Armor / Bound Armaments / Bound Aegis
    [24158] = { tooltip = Tooltips.Skill_Bound_Armor; tooltipValue2 = 36 }; -- Bound Armor (Bound Armor)
    [24165] = { tooltip = Tooltips.Skill_Bound_Armaments_Skill }; -- Bound Armaments (Bound Armaments)
    [203447] = { tooltip = Tooltips.Skill_Bound_Armaments_Stack }; -- Bound Armaments (Bound Armaments)
    [108855] = { hide = true }; -- Bound Aegis (Bound Aegis)
    [24163] = { tooltip = Tooltips.Skill_Bound_Armor; tooltipValue2 = 40 }; -- Bound Aegis (Bound Aegis)

    -- Summon Storm Atronach / Greater Storm Atronach / Summon Charged Atronach
    [23428] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_atronach_zap.dds'; tooltip = Tooltips.Generic_Shock; tooltipValue2 = 1 }; -- Atronach Zap (Summon Storm Atronach - All Morphs)
    [23636] = { tooltip = Tooltips.Skill_Storm_Atronach }; -- Summon Storm Atronach (Summon Storm Atronach)
    [80459] = { tooltip = Tooltips.Skill_Storm_Atronach }; -- Summon Storm Atronach (Summon Storm Atronach)
    [23659] = { name = Abilities.Skill_Summon_Storm_Atronach }; -- Storm Atronach Impact (Summon Storm Atronach)
    [23658] = { tooltip = Tooltips.Generic_Stun }; -- Summon Storm Atronach (Summon Storm Atronach)
    [23665] = { tooltip = Tooltips.Skill_Storm_Atronach }; -- Greater Storm Atronach (Greater Storm Atronach)
    [80463] = { tooltip = Tooltips.Skill_Storm_Atronach }; -- Greater Storm Atronach (Greater Storm Atronach)
    [23664] = { name = Abilities.Skill_Greater_Storm_Atronach }; -- Greater Storm Atronach Impact (Greater Storm Atronach)
    [23662] = { tooltip = Tooltips.Generic_Stun }; -- Greater Storm Atronach (Greater Storm Atronach)
    [23668] = { tooltip = Tooltips.Skill_Charged_Atronach }; -- Summon Charged Atronach (Summon Charged Atronach)
    [80468] = { tooltip = Tooltips.Skill_Charged_Atronach }; -- Summon Charged Atronach (Summon Charged Atronach)
    [23667] = { name = Abilities.Skill_Summon_Charged_Atronach }; -- Charged Atronach Impact (Summon Charged Atronach)
    [23666] = { tooltip = Tooltips.Generic_Stun }; -- Summon Charged Atronach (Summon Charged Atronach)
    [29806] = { hide = true }; -- Lightning Strike (Summon Charged Atronach)
    [43764] = { hide = true }; -- Lightning Strike (Summon Charged Atronach)
    [43767] = { hide = true }; -- Lightning Strike (Summon Charged Atronach)
    [43765] = { hide = true }; -- Lightning Strike (Summon Charged Atronach)
    [43766] = { hide = true }; -- Lightning Strike (Summon Charged Atronach)
    [29809] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_lightning_strike.dds' }; -- Lightning Strike (Summon Charged Atronach)

    -- Mages' Fury, Mages' Wrath, Endless Fury
    [18746] = { tooltip = Tooltips.Skill_Mages_Fury }; -- Mages' Fury (Mages' Fury)
    [19125] = { tooltip = Tooltips.Skill_Mages_Fury }; -- Mages' Wrath (Mages' Wrath)
    [19118] = { tooltip = Tooltips.Skill_Endless_Fury }; -- Endless Fury (Endless Fury)

    -- Lightning Form / Hurricane / Boundless Storm
    [23210] = { tooltip = Tooltips.Skill_Lightning_Form }; -- Lightning Form (Lightning Form)
    [23231] = { tooltip = Tooltips.Skill_Hurricane }; -- Hurricane (Hurricane)
    [23213] = { tooltip = Tooltips.Skill_Lightning_Form }; -- Boundless Storm (Boundless Storm)

    -- Lightning Splash / Liquid Lightning / Lightning Flood
    [23182] = { tooltip = Tooltips.Skill_Lightning_Splash; tooltipValue2 = 4 }; -- Lightning Splash (Lightning Splash)
    [23200] = { tooltip = Tooltips.Skill_Lightning_Splash; tooltipValue2 = 4 }; -- Liquid Lightning (Liquid Lightning)
    [23205] = { tooltip = Tooltips.Skill_Lightning_Splash; tooltipValue2 = 6 }; -- Lightning Flood (Lightning Flood)
    [23189] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Lightning Splash (Lightning Splash)
    [23202] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Liquid Lightning (Liquid Lightning)
    [23208] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Lightning Flood (Lightning Flood)

    -- Surge / Power Surge / Critical Surge
    [23670] = { tooltip = Tooltips.Skill_Surge }; -- Surge (Surge)
    [23674] = { tooltip = Tooltips.Skill_Power_Surge }; -- Power Surge (Power Surge)
    [23678] = { tooltip = Tooltips.Skill_Surge }; -- Critical Surge (Critical Surge)

    -- Bolt Escape
    [51392] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Bolt_Escape_Fatigue }; -- Bolt Escape Fatigue (Bolt Escape - All Morphs)
    [23235] = { tooltip = Tooltips.Generic_Stun }; -- Bolt Escape (Bolt Escape)
    [28482] = { tooltip = Tooltips.Generic_Stun }; -- Streak (Streak)
    [132946] = { tooltip = Tooltips.Generic_Stun }; -- Streak (Streak)
    [131383] = { tooltip = Tooltips.Innate_Snare_Immobilize_Immunity }; -- Ball of Lightning (Ball of Lightning)
    [23283] = { hide = true }; -- Summoned Ball of Lightning (Ball of Lightning)
    [23279] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_intercept.dds'; name = Abilities.Skill_Intercept; hide = true; tooltip = Tooltips.Skill_Intercept }; -- Ball of Lightning (Ball of Lightning)

    -- Overload / Power Overload / Energy Overload
    [24785] = { tooltip = Tooltips.Skill_Overload; toggle = true }; -- Overload (Overload)
    [24806] = { tooltip = Tooltips.Skill_Overload; toggle = true }; -- Power Overload (Power Overload)
    [114769] = { icon = '/esoui/art/icons/ability_sorcerer_power_overload.dds' }; -- Power Overload Light Attack (Power Overload)
    [24804] = { tooltip = Tooltips.Skill_Energy_Overload; toggle = true }; -- Energy Overload (Energy Overload)
    [114773] = { icon = '/esoui/art/icons/ability_sorcerer_energy_overload.dds' }; -- Energy Overload Light Attack (Energy Overload)
    [29740] = { icon = '/esoui/art/icons/ability_sorcerer_energy_overload.dds' }; -- Energy Overload (Energy Overload)

    ----------------------------------------------------------------
    -- TEMPLAR PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Aedric Spear
    [80153] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }; -- Burning Light (Burning Light - Rank 1)
    [80170] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }; -- Burning Light (Burning Light - Rank 2)
    [31565] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_balanced_warrior.dds' }; -- Balanced Warrior
    [44732] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_balanced_warrior.dds' }; -- Balanced Warrior

    -- Dawn's Wrath
    [31746] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds' }; -- Prism (Prism - Rank 1)
    [45217] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds' }; -- Prism (Prism - Rank 2)
    [31721] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_restoring_spirit.dds' }; -- Restoring Spirt
    [45212] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_restoring_spirit.dds' }; -- Restoring Spirt

    -- Restoring Light
    [31757] = { icon = '/esoui/art/icons/ability_templar_032.dds' }; -- Sacred Ground
    [45207] = { icon = '/esoui/art/icons/ability_templar_032.dds' }; -- Sacred Ground
    [31759] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds'; forcedContainer = 'short'; groundLabel = true; tooltip = Tooltips.Skill_Sacred_Ground }; -- Minor Mending (Sacred Ground - Rank 1 & 2)
    --[80195] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0, groundLabel = true, tooltip = Tooltips.Generic_Snare_No_Dur, tooltipValue2 = 40 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    --[80230] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0, groundLabel = true, tooltip = Tooltips.Generic_Snare_No_Dur, tooltipValue2 = 40 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    --[80261] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0, groundLabel = true, tooltip = Tooltips.Generic_Snare_No_Dur, tooltipValue2 = 40 }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [31760] = { icon = '/esoui/art/icons/ability_templar_014.dds' }; -- Light Weaver
    [45208] = { icon = '/esoui/art/icons/ability_templar_014.dds' }; -- Light Weaver
    [52703] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_light_weaver.dds'; name = Abilities.Passive_Light_Weaver }; -- Light Weaver Ultimate (Light Weaver - Rank 1 & 2)

    ----------------------------------------------------------------
    -- TEMPLAR ACTIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- Puncturing Strikes / Biting Jabs / Puncturing Sweep
    [76908] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Puncturing Strikes (Puncturing Strikes)
    [76912] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Biting Jabs (Biting Jabs)
    [55183] = { icon = '/esoui/art/icons/ability_templar_reckless_attacks.dds'; name = Abilities.Skill_Puncturing_Sweep }; -- Puncturing Sweep Heal (Puncturing Sweep)
    [144127] = { icon = '/esoui/art/icons/ability_templar_reckless_attacks.dds'; name = Abilities.Skill_Puncturing_Sweep }; -- Puncturing Sweep Heal (Puncturing Sweep)
    [76916] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Puncturing Sweep (Puncturing Sweep)

    -- Piercing Javelin / Aurora Javelin / Binding Javelin
    [37409] = { tooltip = Tooltips.Generic_Knockback }; -- Piercing Javelin (Piercing Javelin)
    [37414] = { name = Abilities.Skill_Aurora_Javelin; tooltip = Tooltips.Generic_Knockback }; -- Piercing Javelin (Aurora Javelin)
    [32099] = { tooltip = Tooltips.Generic_Knockdown }; -- Binding Javelin (Binding Javelin)

    -- Focused Charge / Explosive Charge / Toppling Charge
    [26508] = { icon = '' }; -- Charge (Focused Charge) -- Hide for Interrupt notification on Combat Text
    [49204] = { icon = '/esoui/art/icons/ability_templar_focused_charge.dds' }; -- Focused Charge (Focused Charge)
    [49205] = { icon = '/esoui/art/icons/ability_templar_focused_charge.dds'; tooltip = Tooltips.Generic_Stun }; -- Focused Charge (Focused Charge)
    [26522] = { hide = true; icon = '' }; -- Charge (Explosive Charge)
    [49213] = { tooltip = Tooltips.Generic_Stun }; -- Explosive Charge (Explosive Charge)
    [15546] = { tooltip = Tooltips.Generic_Stun }; -- Toppling Charge (Toppling Charge)
    [26518] = { icon = '' }; -- Charge (Toppling Charge)

    -- Spear Shards / Luminous Shards / Blazing Spear
    [95933] = { icon = '/esoui/art/icons/ability_templar_sun_strike.dds'; tooltip = Tooltips.Skill_Spear_Shards }; -- Spear Shards (Spear Shards)
    [95931] = { icon = '/esoui/art/icons/ability_templar_sun_strike.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1 }; -- Spear Shards (Spear Shards)
    [95957] = { icon = '/esoui/art/icons/ability_templar_light_strike.dds'; tooltip = Tooltips.Skill_Luminous_Shards }; -- Luminous Shards (Luminous Shards)
    [95955] = { icon = '/esoui/art/icons/ability_templar_light_strike.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1 }; -- Luminous Shards (Luminous Shards)
    [26880] = { icon = '/esoui/art/icons/ability_templarsun_thrust.dds'; tooltip = Tooltips.Skill_Spear_Shards }; -- Blazing Spear (Blazing Spear)
    [26879] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1 }; -- Blazing Spear

    -- Sun Shield / Radiant Ward / Blazing Shield
    [22179] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Sun Shield (Sun Shield)
    [26724] = { hide = true }; -- Sun Shield Hit Bonus (Sun Shield)
    [22183] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Radiant Ward (Radiant Ward)
    [26732] = { hide = true }; -- Sun Shield Hit Bonus (Radiant Ward)
    [49091] = { tooltip = Tooltips.Skill_Blazing_Shield }; -- Blazing Shield (Blazing Shield)
    [49090] = { hide = true }; -- Sun Shield Hit Bonus (Blazing Shield)
    [22181] = { hide = true }; -- Blazing Shield (Blazing Shield)

    -- Radial Sweep /  Empowering Sweep / Crescent Sweep
    [62593] = { tooltip = Tooltips.Skill_Radial_Sweep }; -- Radial Sweep (Radial Sweep)
    [62599] = { tooltip = Tooltips.Skill_Radial_Sweep }; -- Empowering Sweep (Empowering Sweep)
    [62607] = { icon = '/esoui/art/icons/ability_templar_crescent_sweep.dds'; name = Abilities.Skill_Crescent_Sweep; tooltip = Tooltips.Skill_Radial_Sweep }; -- Crescent Sweep (Crescent Sweep)
    [62606] = { icon = '/esoui/art/icons/ability_templar_crescent_sweep.dds' }; -- Radial Sweep (Crescent Sweep)

    -- Dawn's Wrath

    -- Sun Fire / Vampire's Bane / Reflective Light
    [21728] = { tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Sun Fire (Sun Fire)
    [21731] = { tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Vampire's Bane (Vampire's Bane)
    [21733] = { icon = '/esoui/art/icons/ability_templar_reflective_light.dds'; tooltip = Tooltips.Skill_Sun_Fire_Snare; tooltipValue2Mod = 7; hideReduce = true }; -- Reflective Light (Reflective Light)
    [21734] = { tooltip = Tooltips.Skill_Sun_Fire; tooltipValue2Mod = -7 }; -- Reflective Light (Reflective Light)

    -- Solar Flare / Dark Flare / Solar Barrage
    [22095] = { tooltip = Tooltips.Skill_Solar_Barrage }; -- Solar Barrage (Solar Barrage)

    -- Backlash / Purifying Light / Power of the Light
    [21761] = { tooltip = Tooltips.Skill_Backlash }; -- Backlash (Backlash)
    [21765] = { tooltip = Tooltips.Skill_Purifying_Light }; -- Purifying Light (Purifying Light)
    [21908] = { icon = '/esoui/art/icons/ability_templar_purifying_light.dds' }; -- Purifying Light (Purifying Light)
    [21763] = { tooltip = Tooltips.Skill_Power_of_the_Light }; -- Power of the Light (Power of the Light)

    -- Eclipse / Total Dark / Unstable Core
    [21776] = { tooltip = Tooltips.Skill_Eclipse }; -- Eclipse (Eclipse)
    [127769] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_snare.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Eclipse (Eclipse)
    [127771] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_root.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Eclipse (Eclipse)
    [127772] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_stun.dds'; tooltip = Tooltips.Generic_Stun }; -- Eclipse (Eclipse)
    [22006] = { tooltip = Tooltips.Skill_Living_Dark }; -- Living Dark (Living Dark)
    [127795] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_snare.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 60 }; -- Living Dark (Living Dark)
    [22004] = { tooltip = Tooltips.Skill_Unstable_Core }; -- Unstable Core (Unstable Core)
    [127787] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_snare.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Unstable Core (Unstable Core)
    [127790] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_root.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Unstable Core (Unstable Core)
    [127788] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_stun.dds'; tooltip = Tooltips.Generic_Stun }; -- Unstable Core (Unstable Core)

    -- Radiant Destruction / Radiant Glory / Radiant Oppression
    [63029] = { tooltip = Tooltips.Skill_Radiant_Destruction }; -- Radiant Destruction (Radiant Destruction)
    [63044] = { tooltip = Tooltips.Skill_Radiant_Destruction }; -- Radiant Glory (Radiant Glory)
    [69118] = { icon = '/esoui/art/icons/ability_templar_under_exposure.dds'; name = Abilities.Skill_Radiant_Glory }; -- Radiant Glory Heal (Radiant Glory)
    [63956] = { icon = '/esoui/art/icons/ability_templar_under_exposure.dds' }; -- Radiant Glory (Radiant Glory)
    [63046] = { tooltip = Tooltips.Skill_Radiant_Destruction }; -- Radiant Oppression (Radiant Oppresion)
    [63961] = { icon = '/esoui/art/icons/ability_templar_stendarr_aura.dds' }; -- Radiant Destruction (Radiant Oppression)

    -- Nova / Solar Prison / Solar Disturbance
    [31562] = { tooltip = Tooltips.Generic_Stun }; -- Supernova (Nova - Supernova Synergy)
    [21976] = { icon = '/esoui/art/icons/ability_templar_nova.dds'; tooltip = Tooltips.Skill_Nova }; -- Nova (Nova)
    [21754] = { hide = true }; -- Nova (Nova)
    [34443] = { tooltip = Tooltips.Generic_Stun }; -- Gravity Crush (Solar Prison - Gravity Crush Synergy)
    [22003] = { icon = '/esoui/art/icons/ability_templar_solar_prison.dds'; tooltip = Tooltips.Skill_Solar_Prison }; -- Solar Prison (Solar Prison)
    [21757] = { hide = true }; -- Solar Prison (Solar Prison)
    [22001] = { icon = '/esoui/art/icons/ability_templar_solar_disturbance.dds'; tooltip = Tooltips.Skill_Solar_Disturbance; tooltipValue2Id = 21760 }; -- Solar Disturbance (Solar Disturbance)
    [21760] = { hide = true }; -- Solar Disturbance (Solar Disturbance)

    [21753] = { groundLabel = true; tooltip = Tooltips.Skill_Nova_Ground }; -- Nova
    [21756] = { groundLabel = true; tooltip = Tooltips.Skill_Nova_Ground }; -- Solar Prison
    [21759] = { groundLabel = true; tooltip = Tooltips.Skill_Solar_Disturbance_Ground; tooltipValue2Id = 21760 }; -- Solar Disturbance

    -- Restoring Light
    [35632] = { tooltip = Tooltips.Generic_Magicka_Regen; tooltipValue2 = 2 }; -- Honor the Dead (Honor the Dead)
    [44391] = { icon = '/esoui/art/icons/ability_templar_breath_of_life.dds' }; -- Breath of Life (Breath of Life)

    -- Healing Ritual
    [88456] = { icon = '/esoui/art/icons/ability_templar_ritual_of_rebirth.dds' }; -- Ritual of Rebirth (Ritual of Rebirth)

    -- Restoring Aura / Radiant Aura / Cleansing Ritual
    [26823] = { icon = '/esoui/art/icons/ability_templar_persistant_sigil.dds' }; -- Repentance Magicka Restore (Repentance)
    [26824] = { icon = '/esoui/art/icons/ability_templar_persistant_sigil.dds' }; -- Repentance Heal (Repentance)

    -- Cleansing Ritual / Ritual of Retribution / Extended Ritual
    [44013] = { icon = '/esoui/art/icons/ability_templar_cleansing_ritual.dds' }; -- Purify (Cleansing Ritual - Purify Synergy)
    [26286] = { name = Abilities.Skill_Cleansing_Ritual; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 2 }; -- Healing Ritual (Cleansing Ritual)
    [22265] = { tooltip = Tooltips.Skill_Cleansing_Ritual }; -- Cleansing Ritual (Cleansing Ritual)
    [80172] = { icon = '/esoui/art/icons/ability_templar_purifying_ritual.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 2 }; -- Ritual of Retribution (Ritual of Retribution)
    [22259] = { tooltip = Tooltips.Skill_Ritual_of_Retribution }; -- Ritual of Retribution (Ritual of Retribution)
    [26303] = { icon = '/esoui/art/icons/ability_templar_extended_ritual.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 2 }; -- Extended Ritual (Extended Ritual)
    [22262] = { tooltip = Tooltips.Skill_Cleansing_Ritual }; -- Extended Ritual (Extended Ritual)

    -- Rune Focus / Channeled Focus / Restoring Focus
    [22234] = { tooltip = Tooltips.Skill_Rune_Focus }; -- Rune Focus (Rune Focus)
    [112145] = { tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; forcedContainer = 'short'; groundLabel = true }; -- Rune Focus (Rune Focus)
    [37009] = { tooltip = Tooltips.Skill_Channeled_Focus }; -- Channeled Focus (Channeled Focus)
    [112166] = { icon = '/esoui/art/icons/ability_templar_channeled_focus.dds'; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; forcedContainer = 'short'; groundLabel = true }; -- Channeled Focus (Channeled Focus)
    [114842] = { tooltip = Tooltips.Skill_Restoring_Focus }; -- Restoring Focus (Restoring Focus)
    [112167] = { icon = '/esoui/art/icons/ability_templar_uninterrupted_focus.dds'; name = Abilities.Skill_Restoring_Focus; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; forcedContainer = 'short'; groundLabel = true }; -- Rune Focus Circle Bonus (Restoring Focus)

    -- Rite of Passage / Remembrance / Practiced Incantation
    [22223] = { tooltip = Tooltips.Skill_Rite_of_Passage }; -- Rite of Passage (Rite of Passage)
    [22225] = { icon = '/esoui/art/icons/ability_templar_rite_of_passage.dds'; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; groundLabel = true }; -- Rite of Passage (Rite of Passage)
    [22229] = { tooltip = Tooltips.Skill_Rite_of_Passage }; -- Remembrance (Remembrance)
    [22231] = { icon = '/esoui/art/icons/ability_templar_remembrance.dds'; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; groundLabel = true }; -- Remembrance (Remembrance)
    [22226] = { tooltip = Tooltips.Skill_Rite_of_Passage }; -- Practiced Incantation (Practiced Incantation)
    [22228] = { icon = '/esoui/art/icons/ability_templar_practiced_incantation.dds'; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; groundLabel = true }; -- Practiced Incantation (Practiced Incantation)

    ----------------------------------------------------------------
    -- WARDEN PASSIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- Animal Companions
    [86064] = { name = Abilities.Passive_Bond_with_Nature }; -- Bond With Nature (Bond With Nature - Rank 1)
    [86065] = { name = Abilities.Passive_Bond_with_Nature }; -- Bond With Nature (Bond With Nature - Rank 2)
    [88515] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_bond_with_nature.dds'; name = Abilities.Passive_Bond_with_Nature }; -- Bond With Nature Trigger
    [88512] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_savage_beast.dds'; name = Abilities.Passive_Savage_Beast }; -- Savage Beast Ultimate (Savage Beast - Rank 1)
    [88513] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_savage_beast.dds'; name = Abilities.Passive_Savage_Beast }; -- Transfer (Savage Beast - Rank 2)

    -- Green Balance
    [88483] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds'; name = Abilities.Passive_Natures_Gift }; -- Nature's Give (Nature's Gift - Rank 1)
    [93054] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds' }; -- Nature's Gift (Nature's Gift - Rank 1)
    [93072] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds'; name = Abilities.Passive_Natures_Gift }; -- Nature's Give (Nature's Gift - Rank 2)
    [93073] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds' }; -- Nature's Gift (Nature's Gift - Rank 2)

    ----------------------------------------------------------------
    -- WARDEN ACTIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- ANIMAL COMPANIONS

    -- Dive / Cutting Dive / Screaming Cliff Racer
    [130129] = { name = Abilities.Skill_Off_Balance; tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off-Balance (Dive)
    [130145] = { name = Abilities.Skill_Off_Balance; tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off-Balance (Screaming Cliff Racer)
    [130139] = { name = Abilities.Skill_Off_Balance; tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off-Balance (Cutting Dive)
    [130140] = { tooltip = Tooltips.Skill_Cutting_Dive }; -- Cutting Dive (Cutting Dive)

    -- Scorch / Subterranean Assault / Deep Fissure
    [86009] = { tooltip = Tooltips.Skill_Scorch; stack = 2 }; -- Scorch (Scorch)
    [178020] = { tooltip = Tooltips.Skill_Scorch; stack = 1 }; -- Scorch (Scorch)
    [86019] = { tooltip = Tooltips.Skill_Subterranean_Assault_Echo; stack = 2 }; -- Subterranean Assault (Subterranean Assault)
    [146919] = { tooltip = Tooltips.Skill_Subterranean_Assault; stack = 1 }; -- Subterranean Assault (Subterranean Assault)
    [86015] = { tooltip = Tooltips.Skill_Deep_Fissure; stack = 2 }; -- Deep Fissure (Deep Fissure)
    [178028] = { tooltip = Tooltips.Skill_Deep_Fissure; stack = 1 }; -- Deep Fissure (Deep Fissure)
    [94424] = { icon = '/esoui/art/icons/ability_warden_015_a.dds' }; -- Deep Fissure (Deep Fissure)

    -- Swarm / Fetcher Infection / Growing Swarm
    [101703] = { tooltip = Tooltips.Generic_Magic; tooltipValue2 = 2 }; -- Swarm (Swarm)
    [91416] = { forcedContainer = 'short'; tooltip = Tooltips.Skill_Fetcher_Infection_Bonus }; -- Fetcher Infection Bonus Damage (Fetcher Infection)
    [101904] = { tooltip = Tooltips.Generic_Magic; tooltipValue2 = 2 }; -- Fetcher Infection (Fetcher Infection)
    [101944] = { tooltip = Tooltips.Skill_Growing_Swarm }; -- Growing Swarm (Growing Swarm)

    -- Betty Netch / Blue Betty / Bull Netch
    [86050] = { tooltip = Tooltips.Skill_Betty_Netch }; -- Betty Netch (Betty Netch)
    [86054] = { tooltip = Tooltips.Skill_Blue_Betty }; -- Blue Betty (Blue Betty)
    [114854] = { icon = '/esoui/art/icons/ability_warden_017.dds' }; -- Betty Netch (Blue Betty)
    [86058] = { tooltip = Tooltips.Skill_Bull_Netch }; -- Bull Netch (Bull Netch)
    [89109] = { hide = true }; -- Bull Netch (Bull Netch)
    [114853] = { icon = '/esoui/art/icons/ability_warden_017_b.dds' }; -- Bull Netch (Bull Netch)

    -- Feral Guardian / Eternal Guardian / Wild Guardian
    [101438] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds'; name = Abilities.Innate_CC_Immunity; tooltip = Tooltips.Generic_CC_Immunity }; -- Bear Immunity (Feral Guardian - All Morphs)
    [85982] = { tooltip = Tooltips.Skill_Feral_Guardian; toggle = true }; -- Feral Guardian (Feral Guardian)
    [89135] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds'; name = Abilities.Skill_Bite }; -- Swipe (Feral Guardian)
    [89128] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }; -- Crushing Swipe (Feral Guardian)
    [89129] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Crushing Swipe (Feral Guardian)
    [90284] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Guardians_Wrath }; -- Guardian's Wrath (Feral Guardian)
    [93144] = { hide = true }; -- Guardian's Wrath Trigger (Feral Guardian)
    [85986] = { tooltip = Tooltips.Skill_Eternal_Guardian; toggle = true }; -- Eternal Guardian (Eternal Guardian)
    [109982] = { hide = true }; -- Eternal Guardian (Eternal Guardian)
    [105906] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds'; name = Abilities.Skill_Bite }; -- Swipe (Eternal Guardian)
    [105907] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }; -- Crushing Swipe (Eternal Guardian)
    [105908] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Crushing Swipe (Eternal Guardian)
    [94625] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Guardians_Wrath }; -- Guardian's Wrath (Eternal Guardian)
    [94626] = { hide = true }; -- Guardian's Wrath Trigger (Eternal Guardian)
    [109983] = { hide = true }; -- Eternal Guardian Revive (Eternal Guardian)
    [110384] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_eternal_guardian_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Eternal_Guardian, Abilities.Set_Cooldown); tooltip = Tooltips.Skill_Eternal_Guardian_Cooldown; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Eternal Guardian (Eternal Guardian)
    [85990] = { tooltip = Tooltips.Skill_Wild_Guardian; toggle = true }; -- Wild Guardian (Wild Guardian)
    [89219] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds'; name = Abilities.Skill_Bite }; -- Swipe (Wild Guardian)
    [89220] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }; -- Crushing Swipe (Wild Guardian)
    [92666] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Crushing Swipe (Wild Guardian)
    [92163] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Guardians_Savagery }; -- Guardian's Savagery (Wild Guardian)
    [93233] = { hide = true }; -- Guardian's Savagery Trigger (Wild Guardian)

    -- GREEN BALANCE

    -- Healing Seed / Budding Seeds / Corrupting Pollen
    [85577] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Harvest (Healing Seed - Harvest Synergy)
    [85578] = { tooltip = Tooltips.Skill_Healing_Seed }; -- Healing Seed (Healing Seed)
    [85840] = { tooltip = Tooltips.Skill_Budding_Seeds }; -- Budding Seeds (Budding Seeds)
    [129434] = { tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; groundLabel = true }; -- Budding Seeds (Budding Seeds)
    [85845] = { tooltip = Tooltips.Skill_Corrupting_Pollen }; -- Corrupting Pollen (Corrupting Pollen)

    -- Living Vines / Leeching Vines / Living Trellis
    [85552] = { tooltip = Tooltips.Skill_Living_Vines }; -- Living Vines (Living Vines)
    [85850] = { tooltip = Tooltips.Skill_Leeching_Vines }; -- Leeching Vines (Leeching Vines)
    [85851] = { tooltip = Tooltips.Skill_Living_Trellis }; -- Living Trellis (Living Trellis)
    [88723] = { icon = '/esoui/art/icons/ability_warden_010_b.dds' }; -- Living Trellis (Living Trellis)

    -- Lotus Flower / Green Lotus / Lotus Blossom
    [85539] = { tooltip = Tooltips.Skill_Lotus_Flower }; -- Lotus Flower (Lotus Flower)
    [85854] = { tooltip = Tooltips.Skill_Lotus_Flower }; -- Green Lotus (Green Lotus)
    [85855] = { tooltip = Tooltips.Skill_Lotus_Flower }; -- Lotus Blossom (Lotus Blossom)
    [88695] = { name = Abilities.Skill_Lotus_Blossom }; -- Lotus Blossom Heal (Lotus Blossom)
    [94590] = { icon = '/esoui/art/icons/ability_warden_009_b.dds'; name = Abilities.Skill_Lotus_Blossom }; -- Lotus Blossum Heal (Lotus Blossom)

    -- Nature's Grasp / Bursting Vines / Nature's Embrace
    [90266] = { tooltip = Tooltips.Skill_Natures_Grasp }; -- Nature's Grasp (Nature's Grasp)
    [108943] = { icon = '/esoui/art/icons/ability_warden_011.dds'; name = Abilities.Skill_Natures_Grasp }; -- Nature's Grasp Ultimate Restor (Nature's Grasp)
    [108947] = { icon = '/esoui/art/icons/ability_warden_011_a.dds'; name = Abilities.Skill_Bursting_Vines }; -- Bursting Vines Ultimate Rest (Bursting Vines)
    [88726] = { tooltip = Tooltips.Skill_Natures_Grasp }; -- Nature's Embrace (Nature's Embrace)
    [87074] = { tooltip = Tooltips.Skill_Natures_Grasp_Self }; -- Nature's Embrace (Nature's Embrace)
    [108945] = { icon = '/esoui/art/icons/ability_warden_011_b.dds'; name = Abilities.Skill_Natures_Embrace }; -- Nature's Embrace Ultimate Rest (Nature's Embrace)
    [86356] = { hide = true }; -- Nature's Grasp (Nature's Grasp)
    [85860] = { hide = true }; -- Bursting Vines (Bursting Vines)
    [88729] = { hide = true }; -- Nature's Embrace (Nature's Embrace)

    -- Secluded Grove / Enchanted Forest / Healing Thicket
    [85532] = { tooltip = Tooltips.Skill_Secluded_Grove }; -- Secluded Grove (Secluded Grove)
    [85534] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Secluded Grove (Secluded Grove)
    [85804] = { tooltip = Tooltips.Skill_Secluded_Grove }; -- Enchanted Forest (Enchanted Forest)
    [86357] = { icon = '/esoui/art/icons/ability_warden_012_a.dds' }; -- Enchanted Forest (Enchanted Forest)
    [88747] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Enchanted Forest (Enchanted Forest)
    [85807] = { tooltip = Tooltips.Skill_Healing_Thicket }; -- Healing Thicket (Healing Thicket)
    [91819] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Healing Thicket (Healing Thicket)

    -- WINTER'S EMBRACE

    -- Impaling Shards / Gripping Shards / Winter's Revenge
    [86161] = { tooltip = Tooltips.Skill_Impaling_Shards }; -- Impaling Shards (Impaling Shards)
    [86238] = { tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 30; duration = 0; groundLabel = true; hideGround = true }; -- Impaling Shards (Impaling Shards)
    [86165] = { tooltip = Tooltips.Skill_Impaling_Shards }; -- Gripping Shards (Gripping Shards)
    [87443] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_root_frost.dds'; name = Abilities.Skill_Frozen; tooltip = Tooltips.Generic_Immobilize }; -- Gripping Shards (Gripping Shards)
    [87448] = { tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 30; duration = 0; groundLabel = true; hideGround = true }; -- Gripping Shards (Gripping Shards)
    [86169] = { tooltip = Tooltips.Skill_Impaling_Shards }; -- Winter's Revenge (Winter's Revenge)
    [88801] = { tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 30; duration = 0; groundLabel = true; hideGround = true }; -- Winter's Revenge (Winter's Revenge)

    [88783] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 30 }; -- Impaling Shards (Impaling Shards)
    [88791] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 30 }; -- Gripping Shards (Gripping Shards)
    [88802] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 30 }; -- Winter's Revenge (Winter's Revenge)

    -- Arctic Wind / Polar Wind / Arctic Blast
    [90833] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Arctic Wind (Arctic Wind)
    [90835] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Polar Wind (Polar Wind)
    [176422] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Polar Wind (Polar Wind)
    [90834] = { tooltip = Tooltips.Skill_Arctic_Blast }; -- Arctic Blast (Arctic Blast)
    [130406] = { icon = '/esoui/art/icons/ability_warden_003_b.dds'; tooltip = Tooltips.Skill_Arctic_Blast_Ground; groundLabel = true }; -- Arctic Blast (Arctic Blast)
    [130409] = { icon = '/esoui/art/icons/ability_warden_003_b.dds'; tooltip = Tooltips.Generic_Stun }; -- Arctic Blast (Arctic Blast)

    -- Crystallized Shield / Crystallized Slab / Shimmering Shield
    [86135] = { stack = 3; tooltip = Tooltips.Skill_Crystallized_Shield }; -- Crystallized Shield (Crystallized Shield)
    [87224] = { icon = '/esoui/art/icons/ability_warden_002.dds' }; -- Combat Restore Crystalized Shi (Crystallized Shield)
    [86139] = { stack = 3; tooltip = Tooltips.Skill_Crystallized_Slab }; -- Crystallized Slab (Crystallized Slab)
    [93175] = { hide = true }; -- Crystallized Slab (Crystallized Slab)
    [86143] = { stack = 3; Tooltips.Skill_Shimmering_Shield }; -- Shimmering Shield (Shimmering Shield)
    [88771] = { icon = '/esoui/art/icons/ability_warden_002_b.dds'; name = Abilities.Skill_Shimmering_Shield }; -- Shimmering Shield Restore (Shimmering Shield)

    -- Frozen Gate / Frozen Device / Frozen Retreat
    [86175] = { tooltip = Tooltips.Skill_Frozen_Gate }; -- Frozen Gate (Frozen Gate)
    [87560] = { tooltip = Tooltips.Generic_Immobilize }; -- Frozen Gate (Frozen Gate)
    [86179] = { tooltip = Tooltips.Skill_Frozen_Device }; -- Frozen Device (Frozen Device)
    [92039] = { name = Abilities.Skill_Frozen_Device; tooltip = Tooltips.Generic_Immobilize }; -- Frozen Gate Root (Frozen Device)
    [86183] = { tooltip = Tooltips.Skill_Frozen_Retreat }; -- Frozen Retreat (Frozen Retreat)
    [92060] = { tooltip = Tooltips.Generic_Immobilize }; -- Frozen Retreat (Frozen Retreat)

    -- Sleet Storm / Northern Storm / Permafrost
    [86109] = { tooltip = Tooltips.Skill_Sleet_Storm }; -- Sleet Storm (Sleet Storm)
    [86250] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 40; hideGround = true }; -- Sleet Storm (Sleet Storm)
    [86113] = { tooltip = Tooltips.Skill_Sleet_Storm }; -- Northern Storm (Northern Storm)
    [132429] = { tooltip = Tooltips.Generic_Increase_Max_Magicka_Duration_Percentage; tooltipValue2 = 15 }; -- Northern Storm (Northern Storm)
    [88858] = { duration = 0; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 40; hideGround = true }; -- Northern Storm (Northern Storm)
    [86117] = { tooltip = Tooltips.Skill_Permafrost }; -- Permafrost (Permafrost)
    [88861] = { duration = 0; groundLabel = true; tooltip = Tooltips.Skill_Permafrost_Ground; hideGround = true }; -- Permafrost (Permafrost)

    [86247] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 40 }; -- Sleet Storm (Sleet Storm)
    [88860] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 40 }; -- Northern Storm (Northern Storm)
    [88863] = { groundLabel = true; tooltip = Tooltips.Skill_Permafrost_Ground; stack = 1; stackAdd = 1; stackMax = 3 }; -- Permafrost (Permafrost)

    ----------------------------------------------------------------
    -- NECROMANCER PASSIVE ABILITIES -------------------------------
    ----------------------------------------------------------------

    -- Grave Lord
    [116187] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_reusable_parts.dds'; tooltip = Tooltips.Skill_Reusable_Parts_Rank_1 }; -- Reusable Parts (Reusable Parts - Rank 1)
    [116189] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_reusable_parts.dds'; tooltip = Tooltips.Skill_Reusable_Parts_Rank_2 }; -- Reusable Parts (Reusable Parts - Rank 2)

    -- Bone Tyrant
    [119156] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_death_gleaning.dds' }; -- Death Gleaning (Death Gleaning - Rank 1)
    [119158] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_death_gleaning.dds' }; -- Death Gleaning (Death Gleaning - Rank 1)
    [119164] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_death_gleaning.dds' }; -- Death Gleaning (Death Gleaning - Rank 2)
    [119165] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_death_gleaning.dds' }; -- Death Gleaning (Death Gleaning - Rank 2)

    -- Living Death
    [120611] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_corpse_consumption.dds' }; -- Corpse Consumption (Rank 1)
    [120612] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_corpse_consumption.dds' }; -- Corpse Consumption (Rank 2)

    ----------------------------------------------------------------
    -- NECROMANCER ACTIVE ABILITIES --------------------------------
    ----------------------------------------------------------------

    -- GRAVE LORD

    -- Flame Skull / Venom Skull / Ricochet Skull
    [114131] = { tooltip = Tooltips.Skill_Flame_Skull; tooltipValue2 = GetAbilityName(114108); forcedContainer = 'short' }; -- Flame Skull (Flame Skull)
    [117625] = { tooltip = Tooltips.Skill_Flame_Skull; tooltipValue2 = GetAbilityName(117629); forcedContainer = 'short' }; -- Venom Skull (Venom Skull)
    [117638] = { tooltip = Tooltips.Skill_Ricochet_Skull; forcedContainer = 'short' }; -- Ricochet Skull (Ricochet Skull)

    -- Blastbones / Blighted Blastbones / Stalking Blastbones
    [116149] = { hide = true }; -- Blastbones Model FX (Blastbones)
    [114861] = { icon = '/esoui/art/icons/ability_necromancer_002.dds'; tooltip = Tooltips.Skill_Blastbones }; -- Blastbones (Blastbones)
    [114863] = { tooltip = Tooltips.Skill_Blastbones }; -- Blastbones (Blastbones)
    [124849] = { hide = true }; -- Blastbones ActionList (Blastbones)
    [117718] = { hide = true }; -- Blighted Blastbones Model FX (Blighted Blastbones)
    [117692] = { icon = '/esoui/art/icons/ability_necromancer_002_a.dds'; tooltip = Tooltips.Skill_Blighted_Blastbones }; -- Blighted Blastbones (Blighted Blastbones)
    [117691] = { tooltip = Tooltips.Skill_Blighted_Blastbones }; -- Blighted Blastbones (Blighted Blastbones)
    [124851] = { hide = true }; -- Blighted Blastbones ActionList (Blighted  Blastbones)
    [117759] = { hide = true }; -- Stalking Blastbones (Stalking Blastbones)
    [117751] = { icon = '/esoui/art/icons/ability_necromancer_002_b.dds'; tooltip = Tooltips.Skill_Stalking_Blastbones }; -- Stalking Blastbones (Stalking Blastbones)
    [117750] = { tooltip = Tooltips.Skill_Stalking_Blastbones }; -- Stalking Blastbones (Stalking Blastbones)
    [124853] = { hide = true }; -- Stalking Blastbones ActionList (Stalking Blastbones)

    -- Boneyard / Unnerving Boneyard / Avid Boneyard
    [115252] = { tooltip = Tooltips.Skill_Boneyard }; -- Boneyard (Boneyard)
    [115254] = { tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1; groundLabel = true }; -- Boneyard (Boneyard)
    [117805] = { tooltip = Tooltips.Skill_Unnerving_Boneyard }; -- Unnerving Boneyard (Unnerving Boneyard)
    [117809] = { tooltip = Tooltips.Skill_Unnerving_Boneyard_Ground; tooltipValue2 = 1; groundLabel = true }; -- Unnerving Boneyard (Unnerving Boneyard)
    [117850] = { tooltip = Tooltips.Skill_Avid_Boneyard }; -- Avid Boneyard (Avid Boneyard)
    [117854] = { tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1; groundLabel = true }; -- Avid Boneyard (Avid Boneyard)

    -- Skeletal Mage / Skeletal Archer / Skeletal Arcanist
    [114317] = { tooltip = Tooltips.Skill_Skeletal_Mage }; -- Skeletal Mage (Skeletal Mage)
    [114322] = { icon = '/esoui/art/icons/ability_necromancer_003.dds'; name = Abilities.Skill_Skeletal_Mage; tooltip = Tooltips.Skill_Skeletal_Mage }; -- Skeletal Mage Summon (Skeletal Mage)
    [114461] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_deathbolt.dds' }; -- Deathbolt (Skeletal Mage)
    [118680] = { tooltip = Tooltips.Skill_Skeletal_Archer }; -- Skeletal Archer (Skeletal Archer)
    [118681] = { icon = '/esoui/art/icons/ability_necromancer_003_a.dds'; tooltip = Tooltips.Skill_Skeletal_Archer }; -- Skeletal Archer (Skeletal Archer)
    [122774] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_deathbolt_archer.dds' }; -- Deathbolt (Skeletal Archer)
    [118726] = { tooltip = Tooltips.Skill_Skeletal_Arcanist }; -- Skeletal Arcanist (Skeletal Arcanist)
    [118738] = { icon = '/esoui/art/icons/ability_necromancer_003_b.dds'; name = Abilities.Skill_Skeletal_Arcanist; tooltip = Tooltips.Skill_Skeletal_Arcanist }; -- Exploding Mage (Skeletal Arcanist)
    [118746] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_deathbolt.dds' }; -- Deathbolt (Skeletal Arcanist)
    [124468] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_deathbolt.dds' }; -- Deathbolt (Skeletal Arcanist)

    -- Shocking Siphon / Detonating Siphon / Mystic Siphon
    [115924] = { hide = true }; -- Shocking Siphon (Shocking Siphon)
    [116445] = { hide = true; tooltip = Tooltips.Skill_Shocking_Siphon }; -- Shocking Siphon (Shocking Siphon)
    [116410] = { groundLabel = true; tooltip = Tooltips.Skill_Shocking_Siphon_Ground }; -- Shocking Siphon (Shocking Siphon)
    [118763] = { hide = true }; -- Detonating Siphon (Detonating Siphon)
    [118764] = { hide = true; tooltip = Tooltips.Skill_Detonating_Siphon }; -- Detonating Siphon (Detonating Siphon)
    [118766] = { groundLabel = true; tooltip = Tooltips.Skill_Detonating_Siphon_Ground }; -- Detonating Siphon (Detonating Siphon)
    [118008] = { hide = true }; -- Mystic Siphon (Mystic Siphon)
    [118009] = { hide = true; tooltip = Tooltips.Skill_Mystic_Siphon }; -- Mystic (Mystic Siphon)
    [118011] = { groundLabel = true; tooltip = Tooltips.Skill_Shocking_Siphon_Ground }; -- Mystic Siphon (Mystic Siphon)

    -- Frozen Colossus / Pestilent Colossus / Glacial Colossus
    [122174] = { tooltip = Tooltips.Skill_Frozen_Colossus }; -- Frozen Colossus (Frozen Colossus)
    [122178] = { tooltip = Tooltips.Skill_Frozen_Colossus_Ground; tooltipValue2 = 1; groundLabel = true }; -- Frozen Colossus (Frozen Colossus)
    [122395] = { tooltip = Tooltips.Skill_Pestilent_Colossus }; -- Pestilent Colossus (Pestilent Colossus)
    [122399] = { tooltip = Tooltips.Skill_Pestilent_Colossus_Ground; tooltipValue2 = 1; groundLabel = true }; -- Pestilent Colossus (Pestilent Colossus)
    [122400] = { tooltip = Tooltips.Skill_Pestilent_Colossus_Ground; tooltipValue2 = 1; groundLabel = true }; -- Pestilent Colossus (Pestilent Colossus)
    [122401] = { tooltip = Tooltips.Skill_Pestilent_Colossus_Ground; tooltipValue2 = 1; groundLabel = true }; -- Pestilent Colossus (Pestilent Colossus)
    [122388] = { tooltip = Tooltips.Skill_Glacial_Colossus; tooltipValue2Id = 122394 }; -- Glacial Colossus (Glacial Colossus)
    [122392] = { tooltip = Tooltips.Skill_Glacial_Colossus_Ground; groundLabel = true }; -- Glacial Colossus (Glacial Colossus)
    [122394] = { tooltip = Tooltips.Generic_Stun }; -- Glacial Colossus (Glacial Colossus)

    -- BONE TYRANT

    -- Death Scythe / Ruinous Scythe / Hungry Scythe
    [125750] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Ruinous Scythe)
    [122625] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Hungry Scythe (Hungry Scythe)

    -- Bone Armor / Beckoning Armor / Summoner's Armor
    [115206] = { tooltip = Tooltips.Skill_Bone_Armor }; -- Bone Armor (Bone Armor)
    [122661] = { hide = true }; -- Corpse Spawn (Bone Armor)
    [123911] = { hide = true }; -- Bone Armor (Bone Armor
    [118237] = { tooltip = Tooltips.Skill_Beckoning_Armor }; -- Beckoning Armor (Beckoning Armor)
    [122679] = { hide = true }; -- Corpse Spawn (Beckoning Armor)
    [123929] = { hide = true }; -- Bone Armor (Beckoning Armor
    [118241] = { icon = '/esoui/art/icons/ability_necromancer_008_a.dds' }; -- Beckoning Armor (Beckoning Armor)
    [118242] = { icon = '/esoui/art/icons/ability_necromancer_008_a.dds'; tooltip = Tooltips.Generic_Stun }; -- Beckoning Armor (Beckoning Armor)
    [118244] = { tooltip = Tooltips.Skill_Summoners_Armor }; -- Summoner's Armor (Summoner's Armor)
    [122680] = { hide = true }; -- Corpse Spawn (Summoner's Armor)
    [123965] = { hide = true }; -- Bone Armor (Summoner's Armor

    -- Bitter Harvest / Deaden Pain / Necrotic Potency
    [124136] = { icon = '/esoui/art/icons/ability_necromancer_011.dds'; name = Abilities.Skill_Bitter_Harvest }; -- Necrotic Potency (Bitter Harvest)
    [115240] = { icon = '/esoui/art/icons/ability_necromancer_011.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Bitter Harvest (Bitter Harvest)
    [124166] = { icon = '/esoui/art/icons/ability_necromancer_011_a.dds'; name = Abilities.Skill_Deaden_Pain }; -- Necrotic Potency (Deaden Pain)
    [124165] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Deaden Pain (Deaden Pain)
    [124192] = { icon = '/esoui/art/icons/ability_necromancer_011_b.dds' }; -- Necrotic Potency (Necrotic Potency)
    [124193] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Necrotic Potency (Necrotic Potency)

    -- Bone Totem / Remote Totem / Agony Totem
    [115093] = { tooltip = Tooltips.Skill_Bone_Totem }; -- Bone Totem (Bone Totem)
    [115106] = { tooltip = Tooltips.Generic_Fear }; -- Bone Totem (Bone Totem)
    [118380] = { tooltip = Tooltips.Skill_Bone_Totem }; -- Remote Totem (Remote Totem)
    [118386] = { tooltip = Tooltips.Generic_Fear }; -- Remote Totem (Remote Totem)
    [118618] = { tooltip = Tooltips.Generic_Magic; tooltipValue2 = 1 }; -- Pure Agony (Agony Totem - Pure Agony Synergy)
    [118404] = { tooltip = Tooltips.Skill_Agony_Totem }; -- Agony Totem (Agony Totem)
    [118411] = { tooltip = Tooltips.Generic_Fear }; -- Agony Totem (Agony Totem)

    -- Grave Grasp / Ghostly Embrace / Empowering Grasp
    [121513] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Grave Grasp (Grave Grasp)
    [143915] = { icon = '/esoui/art/icons/ability_necromancer_009.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Grave Grasp (Grave Grasp)
    [143917] = { icon = '/esoui/art/icons/ability_necromancer_009.dds'; tooltip = Tooltips.Generic_Stun }; -- Grave Grasp (Grave Grasp)

    [118309] = { icon = '/esoui/art/icons/ability_necromancer_009_b.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Ghostly Embrace (Ghostly Embrace)
    [118325] = { icon = '/esoui/art/icons/ability_necromancer_009_b.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Ghostly Embrace (Ghostly Embrace)
    [143945] = { icon = '/esoui/art/icons/ability_necromancer_009_b.dds'; tooltip = Tooltips.Generic_Stun }; -- Ghostly Embrace (Ghostly Embrace)

    [118369] = { icon = '/esoui/art/icons/ability_necromancer_009_a.dds'; hide = true }; -- Empowering Grasp (Empowering Grasp)
    [118354] = { icon = '/esoui/art/icons/ability_necromancer_009_a.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Empowering Grasp (Empowering Grasp)
    [143948] = { tooltip = Tooltips.Generic_Immobilize }; -- Empowering Grasp (Empowering Grasp)
    [143949] = { tooltip = Tooltips.Generic_Stun }; -- Empowering Grasp (Empowering Grasp)

    -- Bone Goliath Transformation / Pummeling Goliath / Ravenous Goliath
    [115001] = { tooltip = Tooltips.Skill_Bone_Goliath_Transformation }; -- Bone Goliath Transformation (Bone Goliath Transformation)
    [115286] = { icon = '/esoui/art/icons/ability_necromancer_012.dds'; name = Abilities.Skill_Bone_Goliath_Transformation }; -- Bone Goliath (Bone Goliath Transformation)
    [115478] = { icon = '/esoui/art/icons/ability_necromancer_012.dds'; name = Abilities.Skill_Bone_Goliath_Transformation }; -- Bone Goliath Self Snare (Bone Goliath Transformation)
    [118664] = { tooltip = Tooltips.Skill_Pummeling_Goliath }; -- Pummeling Goliath (Pummeling Goliath)
    [118665] = { icon = '/esoui/art/icons/ability_necromancer_012_a.dds' }; -- Pummeling Goliath (Pummeling Goliath)
    [118673] = { icon = '/esoui/art/icons/ability_necromancer_012_a.dds'; name = Abilities.Skill_Pummeling_Goliath }; -- Pummeling Goliath Self Snare (Pummeling Goliath)
    [118666] = { icon = '/esoui/art/icons/ability_necromancer_012_a.dds' }; -- Pummeling Goliath (Pummeling Goliath)
    [118667] = { icon = '/esoui/art/icons/ability_necromancer_012_a.dds' }; -- Pummeling Goliath (Pummeling Goliath)
    [118720] = { icon = '/esoui/art/icons/ability_necromancer_012_a.dds' }; -- Pummeling Goliath Bash (Pummeling Goliath)
    [118279] = { tooltip = Tooltips.Skill_Ravenous_Goliath }; -- Ravenous Goliath (Ravenous Goliath)
    [118280] = { icon = '/esoui/art/icons/ability_necromancer_012_b.dds' }; -- Ravenous Goliath (Ravenous Goliath)
    [118287] = { icon = '/esoui/art/icons/ability_necromancer_012_b.dds'; name = Abilities.Skill_Ravenous_Goliath }; -- Ravenous Goliath Self Snare (Ravenous Goliath)
    [118281] = { icon = '/esoui/art/icons/ability_necromancer_012_b.dds' }; -- Ravenous Goliath (Ravenous Goliath)
    [118282] = { icon = '/esoui/art/icons/ability_necromancer_012_b.dds' }; -- Ravenous Goliath (Ravenous Goliath)
    [118289] = { icon = '/esoui/art/icons/ability_necromancer_012_b.dds'; groundLabel = true; tooltip = Tooltips.Skill_Ravenous_Goliath_Ground }; -- Ravenous Goliath (Ravenous Goliath)
    [118292] = { icon = '/esoui/art/icons/ability_necromancer_012_b.dds' }; -- Ravenous Goliath (Ravenous Goliath)

    -- LIVING DEATH

    -- Render Flesh / Resistant Flesh / Blood Sacrifice
    [117886] = { tooltip = Tooltips.Skill_Resistant_Flesh }; -- Resistant Flesh (Resistant Flesh)

    -- Life amid Death / Renewing Undeath / Enduring Undeath
    [115326] = { icon = '/esoui/art/icons/ability_necromancer_016.dds'; tooltip = Tooltips.Skill_Life_amid_Death }; -- Life amid Death (Life amid Death)
    [115385] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Life amid Death (Life amid Death)
    [118022] = { icon = '/esoui/art/icons/ability_necromancer_016_a.dds'; tooltip = Tooltips.Skill_Life_amid_Death }; -- Renewing Undeath (Renewing Undeath)
    [118021] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Renewing Undeath (Renewing Undeath)
    [118814] = { icon = '/esoui/art/icons/ability_necromancer_016_b.dds'; tooltip = Tooltips.Skill_Life_amid_Death }; -- Enduring Undeath (Enduring Undeath)
    [118813] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Enduring Undeath (Enduring Undeath)

    -- Spirit Mender / Spirit Guardian / Intensive Mender
    [115710] = { tooltip = Tooltips.Skill_Spirit_Mender }; -- Spirit Mender (Spirit Mender)
    [115732] = { icon = '/esoui/art/icons/ability_necromancer_015.dds'; tooltip = Tooltips.Skill_Spirit_Mender }; -- Spirit Mender (Spirit Mender)
    [118912] = { tooltip = Tooltips.Skill_Spirit_Guardian }; -- Spirit Guardian (Spirit Guardian)
    [118913] = { icon = '/esoui/art/icons/ability_necromancer_015_a.dds'; tooltip = Tooltips.Skill_Spirit_Guardian }; -- Spirit Guardian (Spirit Guardian)
    [118840] = { tooltip = Tooltips.Skill_Spirit_Mender }; -- Spirit Mender (Spirit Mender)
    [118843] = { icon = '/esoui/art/icons/ability_necromancer_015_b.dds'; tooltip = Tooltips.Skill_Spirit_Mender }; -- Intensive Mender (Intensive Mender)

    -- Restoring Tether / Braided Tether / Mortal Coil
    [115926] = { hide = true }; -- Restoring Tether (Restoring Tether)
    [116450] = { tooltip = Tooltips.Skill_Restoring_Tether }; -- Restoring Tether (Restoring Tether)
    [118070] = { hide = true }; -- Braided Tether (Braided Tether)
    [118071] = { tooltip = Tooltips.Skill_Braided_Tether }; -- Braided Tether (Braided Tether)
    [118122] = { hide = true }; -- Mortal Coil (Mortal Coil)
    [118123] = { tooltip = Tooltips.Skill_Mortal_Coil }; -- Mortal Coil (Mortal Coil)

    -- Reanimate / Renewing Animation / Animate Blastbones
    [118397] = { icon = '/esoui/art/icons/ability_necromancer_002.dds'; tooltip = Tooltips.Skill_Blastbones }; -- Blastbones (Blastbones)
    [118448] = { icon = '/esoui/art/icons/ability_necromancer_002_a.dds'; tooltip = Tooltips.Skill_Blighted_Blastbones }; -- Blighted Blastbones (Blighted Blastbones)
    [118450] = { icon = '/esoui/art/icons/ability_necromancer_002_b.dds'; tooltip = Tooltips.Skill_Stalking_Blastbones }; -- Stalking Blastbones (Stalking Blastbones)

    ----------------------------------------------------------------
    -- ARCANIST PASSIVE ABILITIES --------------------------------
    ----------------------------------------------------------------

    -- Placeholder, need to add data for passives

    ----------------------------------------------------------------
    -- ARCANIST ACTIVE ABILITIES --------------------------------
    ----------------------------------------------------------------

    -- Placeholder, need to add data for abilities

    ----------------------------------------------------------------
    -- PLAYER WEAPON ATTACKS ---------------------------------------
    ----------------------------------------------------------------

    -- Unarmed
    [23604] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_unarmed_light.dds' }; -- Light Attack (Unarmed)
    [18429] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_unarmed_heavy.dds' }; -- Heavy Attack (Unarmed)
    [18430] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_unarmed_medium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Unarmed, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (Unarmed)
    [18431] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_unarmed_heavy.dds' }; -- Heavy Attack (Unarmed)
    [60772] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_unarmed_restore.dds' }; -- Heavy Attack (Unarmed)

    -- Two Handed
    [16037] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_two_handed_light.dds' }; -- Light Attack (Two Handed)
    [16041] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_two_handed_heavy.dds' }; -- Heavy Attack (Two Handed)
    [17162] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_two_handed_medium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Two_Handed, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (Two Handed)
    [17163] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_two_handed_heavy.dds' }; -- Heavy Attack (Two Handed)
    [60757] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_two_handed_restore.dds' }; -- Heavy Attack (Two Handed)

    -- One Hand and Shield
    [15435] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_melee_light.dds' }; -- Light Attack (One Handed)
    [15279] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_melee_heavy.dds' }; -- Heavy Attack (One Handed)
    [15282] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_melee_medium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_One_Handed, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (One Handed)
    [15829] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_melee_heavy.dds' }; -- Heavy Attack (One Handed)
    [60759] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_melee_restore.dds' }; -- Heavy Attack (One Handed)

    -- Dual Wield
    [16499] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_melee_light.dds' }; -- Light Attack (Dual Wield)
    [16420] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_dual_wield_heavy.dds' }; -- Heavy Attack (Dual Wield)
    [17170] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_melee_medium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Dual_Wield, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (Dual Wield)
    [17169] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_dual_wield_heavy.dds' }; -- Heavy Attack (Dual Wield)
    [18622] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_dual_wield_heavy.dds' }; -- Heavy Attack (Dual Wield)
    [60758] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_dual_wield_restore.dds' }; -- Heavy Attack (Dual Wield)

    -- Bow
    [16688] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_bow_light.dds' }; -- Light Attack (Bow)
    [16691] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_bow_heavy.dds' }; -- Heavy Attack (Bow)
    [17174] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_bow_medium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Bow, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (Bow)
    [17173] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_bow_heavy.dds' }; -- Heavy Attack (Bow)
    [60761] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_bow_restore.dds' }; -- Heavy Attack (Bow)

    -- Destruction Staff (Frost)
    [16277] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_frost_light.dds' }; -- Light Attack (Ice)
    [16261] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_frost_heavy.dds' }; -- Heavy Attack (Ice)
    [18405] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_frost_medium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Ice, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (Ice)
    [18406] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_frost_heavy.dds' }; -- Heavy Attack (Ice)
    [60762] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_restore.dds' }; -- Heavy Attack Heavy Attack (Ice)

    -- Destruction Staff (Flame)
    [16165] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_flame_light.dds' }; -- Light Attack (Inferno)
    [15383] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_flame_heavy.dds' }; -- Heavy Attack (Inferno)
    [15385] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_flame_medium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Inferno, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (Inferno)
    [16321] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_flame_heavy.dds' }; -- Heavy Attack (Inferno)
    [60763] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_restore.dds' }; -- Heavy Attack (Inferno)

    -- Destruction Staff (Shock)
    [18350] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_lightning_light.dds' }; -- Light Attack (Lightning)
    [18396] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_lightning_heavy.dds'; tooltip = Tooltips.Skill_Heavy_Attack_Lightning }; -- Heavy Attack (Lightning)
    [19277] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_lightning_heavy.dds'; hide = true }; -- Heavy Attack (Lightning)
    [60764] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_restore.dds' }; -- Heavy Attack (Lightning)

    -- Restoration Staff
    [16145] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_restoration_light.dds' }; -- Light Attack (Restoration)
    [16212] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_restoration_heavy.dds'; tooltip = Tooltips.Skill_Heavy_Attack_Restoration }; -- Heavy Attack (Restoration)
    [67022] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_restoration_heavy.dds' }; -- Heavy Attack (Restoration)
    [32760] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_staff_restore.dds' }; -- Heavy Attack (Restoration)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WEAPONS -------------------------------------
    ----------------------------------------------------------------

    -- Two Handed
    [30821] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_forceful.dds' }; -- Forceful (Rank 1)
    [45445] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_forceful.dds' }; -- Forceful (Rank 2)
    [29375] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_heavy_weapons.dds' }; -- Heavy Weapons (Rank 1)
    [45430] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_heavy_weapons.dds' }; -- Heavy Weapons (Rank 2)
    [29388] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_balanced_blade.dds' }; -- Balanced Blade (Rank 1)
    [45443] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_balanced_blade.dds' }; -- Balanced Blade (Rank 2)
    [29389] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_follow_up.dds' }; -- Follow Up (Follow Up - Rank 1)
    [60860] = { icon = '/esoui/art/icons/ability_warrior_018.dds'; tooltip = Tooltips.Skill_Follow_Up_Rank_1 }; -- Bonus Damage (Follow Up - Rank 1)
    [45446] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_follow_up.dds' }; -- Follow Up (Follow Up - Rank 2)
    [60888] = { icon = '/esoui/art/icons/ability_warrior_018.dds'; name = Abilities.Passive_Follow_Up; tooltip = Tooltips.Skill_Follow_Up_Rank_2 }; -- Bonus Damage (Follow Up - Rank 2)
    [29392] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_battle_rush.dds'; tooltip = Tooltips.Skill_Battle_Rush_Rank_1 }; -- Battle Rush (Battle Rush - Rank 1)
    [45450] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_battle_rush.dds'; tooltip = Tooltips.Skill_Battle_Rush_Rank_2 }; -- Battle Rush (Battle Rush - Rank 2)

    -- One Hand and Shield
    [29420] = { icon = '/esoui/art/icons/ability_weapon_029.dds' }; -- Fortress (Fortress - Rank 1)
    [45471] = { icon = '/esoui/art/icons/ability_weapon_029.dds'; hide = true }; -- Fortress (Fortress - Rank 2)
    [29397] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_sword_and_board.dds' }; -- Sword and Board (Sword and Board - Rank 1)
    [45452] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_sword_and_board.dds' }; -- Sword and Board (Sword and Board - Rank 2)
    [29415] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_deadly_bash.dds' }; -- Deadly Bash (Deadly Bash - Rank 1)
    [45469] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_deadly_bash.dds' }; -- Deadly Bash (Deadly Bash - Rank 2)
    [29399] = { icon = '/esoui/art/icons/ability_weapon_003.dds' }; -- Deflect Bolts (Deflect Bolts - Rank 1)
    [45472] = { icon = '/esoui/art/icons/ability_weapon_003.dds' }; -- Deflect Bolts (Deflect Bolts - Rank 2)
    [29422] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_battlefield_mobility.dds' }; -- Battlefield Mobility (Battlefield Mobility - Rank 1)
    [45473] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_battlefield_mobility.dds' }; -- Battlefield Mobility (Battlefield Mobility - Rank 2)

    -- Dual Wield
    [30872] = { icon = '/esoui/art/icons/ability_weapon_020.dds' }; -- Controlled Fury (Controlled Fury - Rank 1)
    [45478] = { icon = '/esoui/art/icons/ability_weapon_020.dds' }; -- Controlled Fury (Controlled Fury - Rank 2)
    [21114] = { icon = '/esoui/art/icons/ability_weapon_012.dds' }; -- Ruffian (Ruffian - Rank 1)
    [45481] = { icon = '/esoui/art/icons/ability_weapon_012.dds' }; -- Ruffian (Ruffian - Rank 2)

    -- Bow
    [30930] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_accuracy.dds' }; -- Accuracy (Accuracy - Rank 1)
    [45492] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_accuracy.dds' }; -- Accuracy (Accuracy - Rank 2)
    [30942] = { icon = '/esoui/art/icons/ability_weapon_024.dds' }; -- Ranger (Ranger) - Rank 1)
    [45493] = { icon = '/esoui/art/icons/ability_weapon_024.dds' }; -- Ranger (Ranger) - Rank 2)
    [30936] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_hawk_eye.dds' }; -- Hawk Eye (Hawk Eye - Rank 1)
    [78854] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_hawk_eye.dds'; tooltip = Tooltips.Skill_Hawk_Eye_Rank_1 }; -- Hawk Eye (Hawk Eye - Rank 1)
    [45497] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_hawk_eye.dds' }; -- Hawk Eye (Hawk Eye - Rank 2)
    [78855] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_hawk_eye.dds'; tooltip = Tooltips.Skill_Hawk_Eye_Rank_2 }; -- Hawk Eye (Hawk Eye - Rank 2)
    [30923] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_hasty_retreat.dds' }; -- Hasty Retreat (Hasty Retreat - Rank 1)
    [45498] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_hasty_retreat.dds' }; -- Hasty Retreat (Hasty Retreat - Rank 2)

    -- Destruction Staff
    [30948] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_tri_focus_shield.dds' }; -- Tri Focus (Tri Focus - Rank 1)
    [69774] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_tri_focus_shield.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Tri Focus (Tri Focus - Rank 1)
    [45500] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_tri_focus_shield.dds' }; -- Tri Focus (Tri Focus - Rank 2)
    [69773] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_tri_focus_shield.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Tri Focus (Tri Focus - Rank 2)
    [30951] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_tri_focus_damage.dds' }; -- Shock (Tri Focus - Rank 1)
    [45505] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_tri_focus_damage.dds' }; -- Shock (Tri Focus - Rank 2)
    [30959] = { icon = '/esoui/art/icons/ability_weapon_007.dds' }; -- Ancient Knowledge (Ancient Knowledge - Rank 1)
    [45513] = { icon = '/esoui/art/icons/ability_weapon_007.dds'; hide = true }; -- Ancient Knowledge (Ancient Knowledge - Rank 2)
    [30966] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_destruction_expert.dds' }; -- Magicka Restore (Destruction Expert - Rank 1)
    [146324] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_destruction_expert.dds'; name = Abilities.Passive_Destruction_Expert }; -- Magicka Restore (Destruction Expert - Rank 1)
    [45514] = { hide = true }; -- Destruction Expert (Destruction Expert - Rank 2)
    [45515] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_destruction_expert.dds'; name = Abilities.Passive_Destruction_Expert }; -- Magicka Restore (Destruction Expert - Rank 2)
    [146323] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_destruction_expert.dds'; name = Abilities.Passive_Destruction_Expert }; -- Magicka Restore (Destruction Expert - Rank 2)

    -- Restoration Staff
    [30973] = { icon = '/esoui/art/icons/ability_weapon_002.dds' }; -- Essence Drain (Essence Drain -  Rank 1)
    [30978] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_essence_drain.dds' }; -- Essence Drain (Essence Drain -  Rank 1)
    [45517] = { icon = '/esoui/art/icons/ability_weapon_002.dds' }; -- Essence Drain (Essence Drain -  Rank 2)
    [45518] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_essence_drain.dds' }; -- Essence Drain (Essence Drain -  Rank 2)
    [30971] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_absorb.dds' }; -- Absorb (Absorb - Rank 1)
    [45522] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_absorb.dds' }; -- Absorb (Absorb - Rank 2)
    [30981] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_restoration_master.dds' }; -- Restoration Master
    [45524] = { icon = 'LuiExtended/media/icons/abilities/passive_weapon_restoration_master.dds' }; -- Restoration Master

    -----------------------------------------
    -- TWO HANDED ACTIVES -------------------
    -----------------------------------------

    -- Uppercut / Dizzying Swing / Wrecking Blow
    [131562] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Dizzying Swing)
    [137807] = { icon = '/esoui/art/icons/ability_2handed_001_a.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Dizzying Swing (Dizzying Swing)

    -- Critical Charge / Stampede / Critical Rush
    [38791] = { tooltip = Tooltips.Skill_Stampede }; -- Stampede (Stampede)
    [126474] = { tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 1; groundLabel = true }; -- Stampede (Stampede)

    -- Cleave / Carve / Brawler
    [38747] = { tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Carve Bleed (Carve)
    [38763] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Brawler (Brawler)

    -- Reverse Slash / Reverse Slice / Executioner
    [38827] = { icon = '/esoui/art/icons/ability_2handed_004_b.dds' }; -- Reverse Slice (Reverse Slice)

    -- Momentum / Forward Momentum / Rally
    [38797] = { tooltip = Tooltips.Innate_Snare_Immobilize_Immunity }; -- Forward Momentum (Forward Momentum)
    [38802] = { tooltip = Tooltips.Skill_Rally }; -- Rally (Rally)

    -- Berserker Strike / Onslaught / Berserker Rage
    [83217] = { tooltip = Tooltips.Skill_Berserker_Strike }; -- Berserker Strike (Berserker Strike)
    [126497] = { icon = '/esoui/art/icons/ability_2handed_006_a.dds' }; -- Onslaught (Onslaught)
    [83230] = { tooltip = Tooltips.Skill_Onslaught }; -- Onslaught (Onslaught)
    [126492] = { icon = '/esoui/art/icons/ability_2handed_006_b.dds' }; -- Berserker Rage (Berserker Rage)
    [83239] = { tooltip = Tooltips.Skill_Berserker_Rage }; -- Berserker Rage (Berserker Rage)

    -----------------------------------------
    -- ONE HAND AND SHIELD ACTIVES ----------
    -----------------------------------------

    -- Low Slash / Deep Slash / Heroic Slash
    [38271] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Deep Slash (Deep Slash)

    -- Defensive Posture / Defensive Stance / Absorb Magic
    [28727] = { tooltip = Tooltips.Skill_Defensive_Posture }; -- Defensive Posture (Defensive Posture)
    [38312] = { tooltip = Tooltips.Skill_Defensive_Posture }; -- Defensive Stance (Defensive Stance)
    [38317] = { tooltip = Tooltips.Skill_Absorb_Missile }; -- Absorb Missile (Absorb Missile)
    [38398] = { icon = '/esoui/art/icons/ability_1handed_004_b.dds' }; -- Absorb Missile (Absorb Missile)

    -- Shield Charge / Shielded Assault / Invasion
    [28720] = { tooltip = Tooltips.Generic_Knockdown }; -- Shield Charge (Shield Charge)
    [38404] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Shielded Assault (Shielded Assault)
    [38403] = { tooltip = Tooltips.Generic_Knockdown }; -- Shielded Assault (Shielded Assault)
    [38407] = { name = Abilities.Skill_Invasion; tooltip = Tooltips.Generic_Knockdown }; -- Invasion (Invasion)

    -- Power Bash / Reverberating Bash / Power Slam
    [83446] = { tooltip = Tooltips.Skill_Reverberating_Bash }; -- Reverberating Bash (Reverberating Bash)
    [80625] = { tooltip = Tooltips.Skill_Resentment }; -- Resentment (Power Slam)

    -- Shield Wall / Spell Wall / Shield Discipline
    [83272] = { tooltip = Tooltips.Skill_Shield_Wall }; -- Shield Wall (Shield Wall)
    [83292] = { tooltip = Tooltips.Skill_Spell_Wall }; -- Spell Wall (Spell Wall)
    [83310] = { tooltip = Tooltips.Skill_Shield_Discipline }; -- Shield Discipline (Shield Discipline)

    -----------------------------------------
    -- DUAL WIELD ACTIVES -------------------
    -----------------------------------------

    -- Twin Slashes / Rending Slashes / Blood Craze
    [29293] = { icon = '/esoui/art/icons/ability_dualwield_001.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Twin Slashes Bleed (Twin Slashes)
    [38841] = { icon = '/esoui/art/icons/ability_dualwield_001_a.dds'; tooltip = Tooltips.Skill_Rending_Slashes }; -- Rending Slashes Bleed (Rending Slashes)
    [38848] = { icon = '/esoui/art/icons/ability_dualwield_001_a.dds'; tooltip = Tooltips.Skill_Blood_Craze }; -- Blood Craze Bleed (Blood Craze)
    [38852] = { tooltip = Tooltips.Skill_Blood_Craze_Heal }; -- Blood Craze (Blood Craze)

    -- Blade Cloak / Quick Cloak / Deadly Cloak
    [28613] = { tooltip = Tooltips.Skill_Blade_Cloak; tooltipValue2 = 2 }; -- Blade Cloak (Blade Cloak)
    [38901] = { tooltip = Tooltips.Skill_Blade_Cloak; tooltipValue2 = 2 }; -- Quick Cloak (Quick Cloak)
    [38906] = { tooltip = Tooltips.Skill_Blade_Cloak; tooltipValue2 = 2 }; -- Deadly Cloak (Deadly Cloak)

    -- Hidden Blade / Shrouded Daggers / Flying Blade
    [126641] = { icon = '' }; -- Hidden Blade (Hidden Blade)
    [126640] = { icon = '/esoui/art/icons/ability_dualwield_003.dds'; name = Abilities.Skill_Hidden_Blade; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Hidden Blade)
    [126639] = { tooltip = Tooltips.Generic_Stun }; -- Hidden Blade (Hidden Blade)

    [126649] = { icon = ''; name = Abilities.Skill_Shrouded_Daggers }; -- Shrouded Dagger (Shrouded Daggers)
    [126650] = { icon = '/esoui/art/icons/ability_dualwield_003_b.dds'; name = Abilities.Skill_Shrouded_Daggers; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Shrouded Daggers)
    [126651] = { tooltip = Tooltips.Generic_Stun; name = Abilities.Skill_Shrouded_Daggers }; -- Shrouded Daggers (Shrouded Daggers)

    [126667] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_flying_blade_jump.dds'; tooltip = Tooltips.Skill_Flying_Blade }; -- Flying Blade (Flying Blade)
    [126659] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_flying_blade_jump.dds' }; -- Flying Blade (Flying Blade)
    [126666] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_flying_blade_jump.dds' }; -- Flying Blade (Flying Blade)
    [126658] = { icon = '' }; -- Flying Blade (Flying Blade)
    [126655] = { icon = '/esoui/art/icons/ability_dualwield_003_a.dds'; name = Abilities.Skill_Flying_Blade; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Flying Blade)
    [126654] = { icon = '/esoui/art/icons/ability_dualwield_003_a.dds'; tooltip = Tooltips.Generic_Stun }; -- Flying Blade (Flying Blade)

    -- Lacerate / Rend / Thrive in Chaos
    [85156] = { tooltip = Tooltips.Skill_Lacerate }; -- Lacerate (Lacerate)
    [85192] = { tooltip = Tooltips.Skill_Lacerate }; -- Rend (Rend)
    [85182] = { tooltip = Tooltips.Skill_Lacerate }; -- Thrive in Chaos (Thrive in Chaos)
    [85184] = { tooltip = Tooltips.Skill_Thrive_in_Chaos }; -- Thrive in Chaos (Thrive in Chaos)

    -----------------------------------------
    -- BOW ACTIVES --------------------------
    -----------------------------------------

    -- Volley / Endless Hail / Arrow Barrage
    [28876] = { tooltip = zo_strformat(Tooltips.Skill_Volley, 5) }; -- Volley (Volley)
    [28877] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 1 }; -- Volley (Volley)
    [38689] = { tooltip = zo_strformat(Tooltips.Skill_Volley, 5) }; -- Endless Hail (Endless Hail)
    [38690] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 1 }; -- Endless Hail (Endless Hail)
    [38695] = { tooltip = zo_strformat(Tooltips.Skill_Volley, 7) }; -- Arrow Barrage (Arrow Barrage)
    [38696] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 1 }; -- Arrow Barrage (Arrow Barrage)

    -- Scatter Shot / Magnum Shot / Draining Shot
    [28887] = { tooltip = Tooltips.Generic_Knockback }; -- Scatter Shot (Scatter Shot)
    [38674] = { tooltip = Tooltips.Generic_Knockback }; -- Magnum Shot (Magnum Shot)
    [131688] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 60 }; -- Draining Shot (Draining Shot)
    [80764] = { name = Abilities.Skill_Draining_Shot }; -- Draining Shot Heal (Draining Shot)

    -- Arrow Spray / Bombarb / Acid Spray
    [38707] = { tooltip = Tooltips.Generic_Immobilize }; -- Bombard (Bombard)
    [38703] = { tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Acid Spray (Acid Spray)

    -- Poison Arrow / Venom Arrow / Poison Injection
    [44540] = { tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Poison Arrow (Venom Arrow)
    [44545] = { tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Venom Arrow (Venom Arrow)
    [38648] = { icon = '' }; -- Poison Arrow (Venom Arrow)
    [38649] = { icon = '/esoui/art/icons/ability_bow_002_a.dds'; name = Abilities.Skill_Venom_Arrow; tooltip = Tooltips.Generic_Stagger }; -- Poison Arrow (Venom Arrow)
    [38650] = { name = Abilities.Skill_Venom_Arrow; tooltip = Tooltips.Generic_Stun }; -- Poison Arrow (Venom Arrow)
    [44549] = { tooltip = Tooltips.Skill_Poison_Injection }; -- Poison Injection (Poison Injection)

    -- Rapid Fire / Toxic Barrage / Ballista
    [85261] = { tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Toxic Barrage (Toxic Barrage)
    [85458] = { tooltip = Tooltips.Skill_Ballista }; -- Ballista (Ballista)

    -----------------------------------------
    -- DESTRUCTION STAFF ACTIVES ------------
    -----------------------------------------

    -- Force Shock / Crushing Shock / Force Pulse
    [48010] = { icon = '' }; -- Force Shock (Destruction) (Crushing Shock)
    [48009] = { icon = '/esoui/art/icons/ability_destructionstaff_001a.dds'; name = Abilities.Skill_Crushing_Shock; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Crushing Shock)
    [48011] = { name = Abilities.Skill_Crushing_Shock; tooltip = Tooltips.Generic_Stun }; -- Uber Attack (Crushing Shock)
    [48016] = { icon = '/esoui/art/icons/ability_destructionstaff_001b.dds' }; -- Force Pulse (Force Pulse)
    [48022] = { icon = '/esoui/art/icons/ability_destructionstaff_001b.dds' }; -- Force Pulse (Force Pulse)

    -- Wall of Elements / Unstable Wall of Elements / Elemental Blockade
    [68719] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_root_frost.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Frozen (Wall of Elements) -- Frost
    [28807] = { tooltip = Tooltips.Skill_Wall_of_Elements_Fire }; -- Wall of Fire (Wall of Fire)
    [28854] = { tooltip = Tooltips.Skill_Wall_of_Elements_Shock }; -- Wall of Storms (Wall of Storms)
    [62968] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Wall of Storms)
    [28849] = { tooltip = Tooltips.Skill_Wall_of_Elements_Frost }; -- Wall of Frost (Wall of Frost)
    [146169] = { tooltip = Tooltips.Skill_Wall_of_Elements_Frost_Shield }; -- Frost Shield (Wall of Frost)
    [39053] = { tooltip = Tooltips.Skill_U_Wall_of_Elements_Fire }; -- Unstable Wall of Fire (Unstable Wall of Fire)
    [39073] = { tooltip = Tooltips.Skill_U_Wall_of_Elements_Shock }; -- Unstable Wall of Storms (Unstable Wall of Storms)
    [39077] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Unstable Wall of Storms)
    [39067] = { tooltip = Tooltips.Skill_U_Wall_of_Elements_Frost }; -- Unstable Wall of Frost (Unstable Wall of Frost)
    [146276] = { tooltip = Tooltips.Skill_Wall_of_Elements_Frost_Shield }; -- Unstable Frost Shield (Unstable Wall of Frost)
    [146279] = { tooltip = Tooltips.Skill_Wall_of_Elements_Frost_Shield }; -- Unstable Frost Shield (Unstable Wall of Frost)
    [39012] = { tooltip = Tooltips.Skill_Wall_of_Elements_Fire }; -- Blockade of Fire (Blockade of Fire)
    [39018] = { tooltip = Tooltips.Skill_Wall_of_Elements_Shock }; -- Blockade of Storms (Blockade of Storms)
    [62988] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Blockade of Storms)
    [39028] = { tooltip = Tooltips.Skill_Wall_of_Elements_Frost }; -- Blockade of Frost (Blockade of Frost)
    [146311] = { tooltip = Tooltips.Skill_Wall_of_Elements_Frost_Shield }; -- Frost Safeguard (Blockade of Frost)

    [62896] = { groundLabel = true; tooltip = Tooltips.Skill_Wall_of_Elements_Ground_Fire }; -- Wall of Fire
    [62971] = { groundLabel = true; tooltip = Tooltips.Skill_Wall_of_Elements_Ground_Shock }; -- Wall of Storms
    [62931] = { groundLabel = true; tooltip = Tooltips.Skill_Wall_of_Elements_Ground_Frost }; -- Wall of Frost
    [39054] = { groundLabel = true; tooltip = Tooltips.Skill_U_Wall_of_Elements_Ground_Fire }; -- Unstable Wall of Fire
    [39079] = { groundLabel = true; tooltip = Tooltips.Skill_U_Wall_of_Elements_Ground_Shock }; -- Unstable Wall of Storms
    [39071] = { groundLabel = true; tooltip = Tooltips.Skill_U_Wall_of_Elements_Ground_Frost }; -- Unstable Wall of Frost
    [62912] = { groundLabel = true; tooltip = Tooltips.Skill_Wall_of_Elements_Ground_Fire }; -- Blockade of Fire
    [62990] = { groundLabel = true; tooltip = Tooltips.Skill_Wall_of_Elements_Ground_Shock }; -- Blockade of Storms
    [62951] = { groundLabel = true; tooltip = Tooltips.Skill_Wall_of_Elements_Ground_Frost }; -- Blockade of Frost

    -- Destructive Touch / Destructive Clench / Destructive Reach
    [62648] = { name = Abilities.Skill_Flame_Touch; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Fire Touch (Destructive Touch) -- Fire
    [62722] = { tooltip = Tooltips.Generic_Shock; tooltipValue2 = 2 }; -- Shock Touch (Destructive Touch)
    [62692] = { tooltip = Tooltips.Generic_Freeze; tooltipValue2 = 2 }; -- Frost Touch (Destructive Touch)
    [38987] = { icon = '/esoui/art/icons/ability_destructionstaff_007_a.dds'; name = Abilities.Skill_Flame_Clench; tooltip = Tooltips.Generic_Knockback }; -- Stun After Knockback Movement (Destructive Clench) -- Fire
    [38986] = { icon = '/esoui/art/icons/ability_destructionstaff_007_a.dds'; name = Abilities.Skill_Flame_Clench }; -- Fire Touch (destruction) (Destructive Clench) -- Fire
    [62734] = { name = Abilities.Skill_Shock_Clench }; -- Shock Clench Explosion (Destructive Clench) -- Shock
    [38990] = { name = Abilities.Skill_Frost_Clench; tooltip = Tooltips.Generic_Immobilize }; -- Deep Freeze (Destructive Clench) -- Frost
    [62682] = { tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Flame Reach (Destructive Reach)
    [62745] = { tooltip = Tooltips.Generic_Shock; tooltipValue2 = 2 }; -- Shock Reach (Destructive Reach) -- Shock
    [62712] = { tooltip = Tooltips.Generic_Freeze; tooltipValue2 = 2 }; -- Frost Reach (Destructive Reach)

    -- Elemental Storm / Elemental Rage / Eye of the Storm
    [83625] = { tooltip = Tooltips.Skill_Fire_Storm }; -- Fire Storm (Elemental Storm)
    [83630] = { tooltip = Tooltips.Skill_Thunder_Storm }; -- Thunder Storm (Elemental Storm)
    [83628] = { tooltip = Tooltips.Skill_Ice_Storm }; -- Ice Storm (Elemental Storm)
    [85126] = { tooltip = Tooltips.Skill_Fiery_Rage }; -- Fiery Rage (Elemental Rage)
    [85130] = { tooltip = Tooltips.Skill_Thunder_Storm }; -- Thunderous Rage (Elemental Rage)
    [85128] = { tooltip = Tooltips.Skill_Icy_Rage }; -- Icy Rage (Elemental Rage)
    [104825] = { tooltip = Tooltips.Generic_Immobilize }; -- Icy Rage (Elemental Rage)
    [83682] = { tooltip = Tooltips.Skill_Eye_of_Flame }; -- Eye of Flame (Eye of the Storm)
    [83686] = { tooltip = Tooltips.Skill_Eye_of_Lightning }; -- Eye of Lightning (Eye of the Storm)
    [83684] = { tooltip = Tooltips.Skill_Eye_of_Frost }; -- Eye of Frost (Eye of the Storm)

    [83626] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; --Fire Storm
    [83631] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; --Thunder Storm
    [83629] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1 }; --Ice Storm

    [85127] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; --Fiery Rage
    [85131] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; --Thunderous Rage
    [85129] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1 }; --Icy Rage

    [83683] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; --Eye of Flame
    [83687] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; --Eye of Lightning
    [83685] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1 }; --Eye of Frost

    -----------------------------------------
    -- RESTORATION STAFF ACTIVES ------------
    -----------------------------------------

    -- Grand Healing / Illustrious Healing / Healing Springs
    [28385] = { tooltip = Tooltips.Skill_Grand_Healing; tooltipValue2 = 8 }; -- Grand Healing (Grand Healing)
    [28386] = { icon = '/esoui/art/icons/ability_restorationstaff_004.dds'; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; groundLabel = true }; -- Grand Healing (Grand Healing)
    [40058] = { tooltip = Tooltips.Skill_Grand_Healing; tooltipValue2 = 8 }; -- Illustrious Healing (Illustrious Healing)
    [40059] = { icon = '/esoui/art/icons/ability_restorationstaff_004b.dds'; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; groundLabel = true }; -- Illustrious Healing (Illustrious Healing)
    [40060] = { tooltip = Tooltips.Skill_Healing_Springs; tooltipValue2 = 8 }; -- Healing Springs (Healing Springs)
    [40061] = { icon = '/esoui/art/icons/ability_restorationstaff_004a.dds'; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; groundLabel = true }; -- Healing Springs (Healing Springs)
    [40062] = { icon = '/esoui/art/icons/ability_restorationstaff_004a.dds' }; -- Healing Springs (Healing Springs)

    -- Regeneration / Rapid Regeneration / Mutagen
    [28536] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Regeneration (Regeneration)
    [40076] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Rapid Regeneration (Rapid Regeneration)
    [40079] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Radiating Regeneration (Radiating Regeneration)

    -- Blessing of Protection / Blessing of Restoration / Combat Prayer
    [40103] = { name = Abilities.Skill_Blessing_of_Restoration }; -- Blessing of Restoration (Blessing of Restoration)

    -- Steadfast Ward / Ward Ally / Healing Ward
    [37232] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Steadfast Ward (Steadfast Ward)
    [40130] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Ward Ally (Ward Ally)
    [40132] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Ward Ally (Ward Ally)
    [40126] = { tooltip = Tooltips.Skill_Healing_Ward }; -- Healing Ward (Healing Ward)

    -- Panacea / Life Giver / Light's Champion
    [83552] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Panacea (Panacea)
    [83850] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Life Giver (Life Giver)
    [85132] = { tooltip = Tooltips.Skill_Lights_Champion }; -- Light's Champion (Light's Champion)

    ----------------------------------------------------------------
    -- ARMOR PASSIVES ----------------------------------------------
    ----------------------------------------------------------------

    -- Light Armor
    [29668] = { icon = '/esoui/art/icons/passive_armor_001.dds' }; -- Prodigy (Prodigy - Rank 1)
    [45561] = { icon = '/esoui/art/icons/passive_armor_001.dds' }; -- Prodigy (Prodigy - Rank 2)

    -- Heavy Armor
    [29825] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }; -- Resolve (Resolve - Rank 1)
    [45531] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }; -- Resolve (Resolve - Rank 2)
    [45533] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }; -- Resolve (Resolve - Rank 3)
    [29769] = { icon = '/esoui/art/icons/ability_armor_013.dds' }; -- Constitution (Constitution - Rank 1)
    [58428] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }; -- Constitution (Constitution - Rank 1)
    [58503] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }; -- Constitution (Constitution - Rank 1)
    [45526] = { icon = '/esoui/art/icons/ability_armor_013.dds' }; -- Constitution (Constitution - Rank 2)
    [58430] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }; -- Constitution (Constitution - Rank 2)
    [58431] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }; -- Constitution (Constitution - Rank 2)
    [29773] = { icon = '/esoui/art/icons/passive_armor_014.dds' }; -- Revitalize (Revitalize - Rank 1)
    [45528] = { icon = '/esoui/art/icons/passive_armor_014.dds' }; -- Revitalize (Revitalize - Rank 2)

    ----------------------------------------------------------------
    -- ARMOR ACTIVES -----------------------------------------------
    ----------------------------------------------------------------

    -- LIGHT ARMOR
    [29338] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Annulment (Annulment)
    [39186] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Dampen Magic (Dampen Magic)
    [39182] = { tooltip = Tooltips.Skill_Harness_Magicka }; -- Harness Magicka (Harness Magicka)

    -- MEDIUM ARMOR
    [150057] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_medium_armor_evasion.dds'; dynamicTooltip = true }; -- Medium Armor Evasion (Medium Armor Bonuses)

    [39196] = { tooltip = Tooltips.Innate_Snare_Immobilize_Immunity }; -- Shuffle (Shuffle)
    [126958] = { icon = '/esoui/art/icons/ability_armor_002_b.dds'; tooltip = Tooltips.Skill_Elude }; -- Elude (Elude)

    -- HEAVY ARMOR
    [126581] = { tooltip = Tooltips.Skill_Unstoppable }; -- Unstoppable (Unstoppable)
    [126582] = { name = Abilities.Skill_Unstoppable_Brute; dynamicTooltip = true }; -- Unstoppable Brute (Unstoppable Brute)
    [126583] = { dynamicTooltip = true }; -- Immovable (Immovable)

    ----------------------------------------------------------------
    -- SOUL MAGIC PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    [39266] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }; -- Soul Shatter (Soul Shatter - Rank 1)
    [39267] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds' }; -- Soul Shatter (Soul Shatter - Rank 1)
    [45583] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }; -- Soul Shatter (Soul Shatter - Rank 2)
    [45584] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds' }; -- Soul Shatter (Soul Shatter - Rank 2)
    [39269] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_summons.dds' }; -- Soul Summons
    [45590] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_summons.dds' }; -- Soul Summons
    [43752] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_summons_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Passive_Soul_Summons, Abilities.Set_Cooldown); tooltip = Tooltips.Skill_Soul_Summons; forcedContainer = 'long' }; -- Soul Summons
    [39263] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_lock.dds' }; -- Soul Lock
    [39264] = { hide = true }; -- Soul Trap (Soul Lock - Rank 1)
    [45580] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_lock.dds' }; -- Soul Lock
    [45582] = { hide = true }; -- Soul Trap (Soul Lock - Rank 2)

    ----------------------------------------------------------------
    -- SOUL MAGIC ACTIVES ------------------------------------------
    ----------------------------------------------------------------

    [126890] = { tooltip = Tooltips.Skill_Soul_Trap }; -- Soul Trap (Soul Trap)
    [26769] = { hide = true }; -- Soul Trap (Soul Trap)

    [126895] = { icon = '/esoui/art/icons/ability_otherclass_001_a.dds'; tooltip = Tooltips.Skill_Soul_Trap }; -- Soul Splitting Trap (Soul Splitting Trap)
    [40329] = { hide = true }; -- Soul Splitting Trap (Soul Splitting Trap)

    [126897] = { icon = '/esoui/art/icons/ability_otherclass_001_b.dds'; name = Abilities.Skill_Consuming_Trap; tooltip = Tooltips.Skill_Consuming_Trap }; -- Consuming Trap (Consuming Trap)

    [40319] = { hide = true }; -- Consuming Trap (Consuming Trap)
    [40323] = { icon = '/esoui/art/icons/ability_otherclass_001_b.dds' }; -- Consuming Trap (Consuming Trap)
    [40321] = { icon = '/esoui/art/icons/ability_otherclass_001_b.dds' }; -- Consuming Trap (Consuming Trap)
    [40326] = { icon = '/esoui/art/icons/ability_otherclass_001_b.dds' }; -- Consuming Trap (Consuming Trap)

    ----------------------------------------------------------------
    -- VAMPIRE PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Vampire Precursor
    [39472] = { tooltip = Tooltips.Skill_Noxiphilic_Sanguivoria; type = BUFF_EFFECT_TYPE_BUFF }; -- Vampirism (Blood Ritual)
    [40360] = { tooltip = Tooltips.Skill_Noxiphilic_Sanguivoria; type = BUFF_EFFECT_TYPE_BUFF }; -- Vampirism (Blood Ritual)

    -- Base Vampire
    [135397] = { stack = 1; tooltip = Tooltips.Skill_Vampirism_Stage_1; forcedContainer = 'long' }; -- Vampire Stage 1
    [135399] = { stack = 2; tooltip = Tooltips.Skill_Vampirism_Stage_2; forcedContainer = 'long' }; -- Vampire Stage 2
    [135400] = { stack = 3; tooltip = Tooltips.Skill_Vampirism_Stage_3; forcedContainer = 'long' }; -- Vampire Stage 3
    [135402] = { stack = 4; tooltip = Tooltips.Skill_Vampirism_Stage_4; forcedContainer = 'long' }; -- Vampire Stage 4
    [135412] = { stack = 5; tooltip = Tooltips.Skill_Vampirism_Stage_5; forcedContainer = 'long' }; -- Vampire Stage 5

    -- Feed
    [33182] = { icon = '/esoui/art/icons/ability_u26_vampire_synergy_feed.dds' }; -- Feed (Feed)
    [33175] = { icon = '/esoui/art/icons/ability_u26_vampire_synergy_feed.dds' }; -- Feed (Feed)
    [138780] = { icon = '/esoui/art/icons/ability_u26_vampire_synergy_feed.dds' }; -- Feed (Feed)

    -- Strike from the Shadows
    [135189] =
    {
        icon = 'LuiExtended/media/icons/abilities/ability_vampire_strike_from_the_shadows.dds';
        tooltip = Tooltips.Generic_Weapon_Spell_Damage_Duration_Value;
        tooltipValue2 = 150;
    }; -- Strike from the Shadows (Strike from the Shadows - Rank 1)
    [135190] =
    {
        icon = 'LuiExtended/media/icons/abilities/ability_vampire_strike_from_the_shadows.dds';
        tooltip = Tooltips.Generic_Weapon_Spell_Damage_Duration_Value;
        tooltipValue2 = 300;
    }; -- Strike from the Shadows (Strike from the Shadows - Rank 2)

    -- Blood Ritual
    [40349] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Feed (Blood Ritual - Rank 1)
    [40350] = { icon = '/esoui/art/icons/ability_u26_vampire_synergy_feed.dds' }; -- Feed (Blood Ritual - Rank 1)
    [40359] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_ritual_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Passive_Blood_Ritual, Abilities.Set_Cooldown); tooltip = Tooltips.Skill_Blood_Ritual; forcedContainer = 'long' }; -- Fed on ally (Blood Ritual)

    -- Unnatural Movement
    [132849] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_unnatural_movement.dds'; tooltip = Tooltips.Skill_Unnatural_Movement; forcedContainer = 'short' }; -- Unnatural Movement (Unnatural Movement - Rank 1)
    [135226] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_unnatural_movement.dds'; tooltip = Tooltips.Skill_Unnatural_Movement; forcedContainer = 'short' }; -- Unnatural Movement (Unnatural Movement - Rank 2)

    ----------------------------------------------------------------
    -- VAMPIRE ACTIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Blood for Blood
    [145002] = { icon = '/esoui/art/icons/ability_u26_vampire_01_a.dds'; tooltip = Tooltips.Skill_Blood_for_Blood; unbreakable = 1 }; -- Blood for Blood (Blood for Blood)

    -- Blood Frenzy/Simmering Frenzy/Sated Fury
    [172418] = { forcedContainer = 'short'; tooltip = Tooltips.Skill_Blood_Frenzy; toggle = true }; -- Blood Frenzy (Blood Frenzy)
    [134166] = { forcedContainer = 'short'; tooltip = Tooltips.Skill_Simmering_Frenzy; toggle = true }; -- Simmering Frenzy (Simmering Frenzy)
    [172648] = { forcedContainer = 'short'; tooltip = Tooltips.Skill_Sated_Fury; toggle = true }; -- Sated Fury (Sated Fury)

    -- Vampiric Drain/Drain Vigor/Exhilarating Drain
    [134583] = { tooltip = Tooltips.Skill_Vampiric_Drain }; -- Vampiric Drain (Vampiric Drain)
    [135905] = { tooltip = Tooltips.Skill_Drain_Vigor }; -- Drain Vigor (Drain Vigor)
    [137259] = { tooltip = Tooltips.Skill_Exhilarating_Drain }; -- Exhilarating Drain (Exhilarating Drain)

    -- Mesmerize/Hypnosis/Stupefy
    [128712] = { tooltip = Tooltips.Generic_Stun }; -- Mesmerize (Mesmerize)
    [137865] = { tooltip = Tooltips.Generic_Stun }; -- Hypnosis (Hypnosis)
    [138098] = { tooltip = Tooltips.Skill_Stupefy }; -- Stupefy (Stupefy)
    [138130] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 53 }; -- Stupefy (Stupefy)

    -- Mist Form
    [32986] = { tooltip = Tooltips.Skill_Mist_Form; forcedContainer = 'short'; toggle = true }; -- Mist Form
    [38963] = { tooltip = Tooltips.Skill_Mist_Form; forcedContainer = 'short'; toggle = true }; -- Elusive Mist
    [38965] = { tooltip = Tooltips.Skill_Blood_Mist; forcedContainer = 'short'; toggle = true }; -- Blood Mist
    [38968] = { icon = '/esoui/art/icons/ability_u26_vampire_05_b.dds' }; -- Blood Mist (Blood Mist)
    [135427] = { icon = '/esoui/art/icons/ability_u26_vampire_05_b.dds' }; -- Blood Mist (Blood Mist)

    [32624] = { tooltip = Tooltips.Skill_Blood_Scion }; -- Blood Scion (Blood Scion)
    [138565] = { icon = '/esoui/art/icons/ability_u26_vampire_06.dds' }; -- Blood Scion (Blood Scion)
    [138568] = { icon = '/esoui/art/icons/ability_u26_vampire_06.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Remove, Abilities.Skill_Blood_Scion) }; -- Blood Scion (Blood Scion)

    [38932] = { tooltip = Tooltips.Skill_Swarming_Scion }; -- Swarming Scion (Swarming Scion)
    [138614] = { icon = '/esoui/art/icons/ability_u26_vampire_06_a.dds' }; -- Swarming Scion (Swarming Scion)
    [38935] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1 }; -- Swarming Scion
    [138615] = { icon = '/esoui/art/icons/ability_u26_vampire_06_a.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Remove, Abilities.Skill_Swarming_Scion) }; -- Swarming Scion (Swarming Scion)

    [38931] = { tooltip = Tooltips.Skill_Blood_Scion }; -- Perfect Scion (Perfect Scion)
    [138618] = { icon = '/esoui/art/icons/ability_u26_vampire_06_b.dds' }; -- Swarming Scion (Swarming Scion)
    [138619] = { icon = '/esoui/art/icons/ability_u26_vampire_06_b.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Remove, Abilities.Skill_Perfect_Scion) }; -- Swarming Scion (Swarming Scion)

    ----------------------------------------------------------------
    -- VAMPIRE QUEST ---------------------------------------------
    ----------------------------------------------------------------

    [39507] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_profane_symbol.dds'; name = Abilities.Skill_Profane_Symbol }; -- VampInitStun_Profane
    [44222] = { hide = true }; -- VampireInitiation_Lamae
    [39728] = { icon = '/esoui/art/icons/ability_u26_vampire_synergy_feed.dds'; name = Abilities.Skill_Feed }; -- VampInit_TheaterFeed
    [39509] = { icon = '/esoui/art/icons/ability_u26_vampire_03.dds'; name = Abilities.Skill_Vampirism }; -- VampInit_PC Becomes a Vampire

    [135533] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_lamaes_blessing.dds' }; -- Lamae's Blessing

    [39422] = { hide = true }; -- Mist Form
    [56684] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_dagger_1h_light.dds' }; -- Quick Strike

    ----------------------------------------------------------------
    -- WEREWOLF PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    [35658] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_lycanthrophy.dds'; tooltip = Tooltips.Skill_Lycanthrophy }; -- Lycanthrophy
    [31068] = { icon = '/esoui/art/icons/crownstore_skillline_werewolf.dds'; tooltip = Tooltips.Skill_Sanies_Lupinus }; -- Sanies Lupinus (from NPC Bite)
    [40521] = { icon = '/esoui/art/icons/crownstore_skillline_werewolf.dds'; tooltip = Tooltips.Skill_Sanies_Lupinus }; -- Sanies Lupinus (from Player Bite)

    [32464] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }; -- Light Attack (Werewolf)
    [32477] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }; -- Heavy Attack (Werewolf)
    [32479] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackmedium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Werewolf, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (Werewolf)
    [32480] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }; -- Heavy Attack (Werewolf)
    [32494] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }; -- Heavy Attack (Werewolf)
    [60773] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackrestore.dds' }; -- Heavy Attack (Werewolf)

    [33208] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds'; hide = true }; -- Devour (Devour)
    [33209] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }; -- Devour (Devour)
    [40515] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }; -- Devour (Blood Moon)
    [40520] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds'; name = Abilities.Skill_Devour; unbreakable = 1; tooltip = Tooltips.Generic_Knockdown }; -- Q3047 - Knockdown (Blood Moon - Rank 1)
    [40525] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_bloodmoon_icd.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Passive_Bloodmoon, Abilities.Set_Cooldown); tooltip = Tooltips.Skill_Blood_Moon; forcedContainer = 'long' }; -- Bit an Ally (Blood Moon)

    [32636] = { icon = 'LuiExtended/media/icons/abilities/passive_werewolf_pursuit.dds' }; -- Pursuit (Rank 1)
    [46142] = { icon = 'LuiExtended/media/icons/abilities/passive_werewolf_pursuit.dds' }; -- Pursuit (Rank 2)

    ----------------------------------------------------------------
    -- WEREWOLF ACTIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Pounce / Brutal Pounce / Feral Pounce
    [137157] = { tooltip = Tooltips.Skill_Carnage_Proc; tooltipValue2 = Abilities.Skill_Carnage }; -- Carnage (Pounce)
    [137156] = { tooltip = Tooltips.Skill_Carnage }; -- Carnage (Pounce)
    [137186] = { tooltip = Tooltips.Skill_Carnage_Proc; tooltipValue2 = Abilities.Skill_Brutal_Carnage }; -- Brutal Carnage (Brutal Pounce)
    [137184] = { tooltip = Tooltips.Skill_Carnage }; -- Brutal Carnage (Brutal Pounce)
    [137189] = { tooltip = Tooltips.Skill_Brutal_Carnage_Buff }; -- Brutal Carnage (Brutal Pounce)
    [137165] = { tooltip = Tooltips.Skill_Carnage_Proc; tooltipValue2 = Abilities.Skill_Feral_Carnage }; -- Feral Carnage (Feral Pounce)
    [137164] = { tooltip = Tooltips.Skill_Feral_Carnage }; -- Feral Carnage (Feral Pounce)

    -- Hircine's Bounty / Hircine's Rage / Hircine's Fortitude
    [137202] = { icon = '/esoui/art/icons/ability_werewolf_004_a.dds' }; -- Hircine's Bounty (Hircine's Bounty)

    [137204] = { icon = '/esoui/art/icons/ability_werewolf_004_b.dds' }; -- Hircine's Rage (Hircine's Rage)
    [137206] = { icon = '/esoui/art/icons/ability_werewolf_004_b.dds'; name = Abilities.Skill_Hircines_Rage; unbreakable = 1; tooltip = Tooltips.Generic_Increase_Damage_Taken; tooltipValue2 = 5 }; -- Major Berserk (Hircine's Rage)

    [137209] = { icon = '/esoui/art/icons/ability_werewolf_004_c.dds' }; -- Hircine's Fortitude (Hircine's Fortitude)
    [137210] = { tooltip = Tooltips.Skill_Hircines_Fortitude }; -- Hircine's Fortitude (Hircine's Fortitude)

    -- Roar / Ferocious Roar / Deafening Roar
    [32633] = { tooltip = Tooltips.Generic_Fear }; -- Roar (Roar)
    [137257] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Roar)

    [39113] = { tooltip = Tooltips.Generic_Fear }; -- Ferocious Roar (Ferocious Roar)
    [45834] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Ferocious Roar)
    [137287] = { tooltip = Tooltips.Skill_Ferocious_Roar }; -- Ferocious Roar (Ferocious Roar)

    [39114] = { tooltip = Tooltips.Generic_Fear }; -- Deafening Roar (Deafening Roar)
    [137312] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Deafening Roar)

    -- Infectious Claws / Claws of Anguish / Claws of Life
    [58856] = { tooltip = Tooltips.Generic_Disease; tooltipValue2 = 2 }; -- Infection (Infectious Claws)
    [58865] = { tooltip = Tooltips.Generic_Disease; tooltipValue2 = 2 }; -- Infection (Claws of Anguish)
    [58880] = { tooltip = Tooltips.Skill_Claws_of_Life }; -- Infection (Claws of Life)

    -- Werewolf Transformation / Pack Leader / Werewolf Berserker
    [39477] = { hide = true }; -- De-Werewolf (Werewolf Transformation - All Morphs)
    [32455] = { tooltip = Tooltips.Skill_Werewolf_Transformation }; -- Werewolf Transformation (Werewolf Transformation)
    [111832] = { tooltip = Tooltips.Generic_Fear }; -- Werewolf Transformation
    [39075] = { tooltip = Tooltips.Skill_Pack_Leader }; -- Pack Leader (Pack Leader)
    [111843] = { tooltip = Tooltips.Generic_Fear }; -- Pack Leader
    [80180] = { hide = true }; -- Birth Direwolf (Pack Leader)
    [80177] = { hide = true }; -- Pack Leader (Pack Leader)
    [80178] = { hide = true }; -- Pack Leader (Pack Leader)
    [80184] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_lunge.dds' }; -- Lunge (Pack Leader)
    [127161] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_lunge.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Lunge (Pack Leader)
    [80189] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_gnash.dds' }; -- Gnash (Pack Leader)
    [80190] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_gnash.dds' }; -- Gnash (Pack Leader)

    [39076] = { tooltip = Tooltips.Skill_Werewolf_Berserker }; -- Werewolf Berserker (Werewolf Berserker)
    [111844] = { tooltip = Tooltips.Generic_Fear }; -- Werewolf Berserker
    [89147] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackbleed.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Werewolf Berserker Bleed (Werewolf Bleed)

    ----------------------------------------------------------------
    -- WEREWOLF QUEST ABILITIES ------------------------------------
    ----------------------------------------------------------------

    [55885] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds'; name = Abilities.Skill_Light_Attack_Werewolf }; -- Light Attack
    [55886] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds'; name = Abilities.Skill_Heavy_Attack_Werewolf }; -- Heavy Attack (Were)
    [55888] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackmedium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Werewolf, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack
    [55891] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds'; name = Abilities.Skill_Heavy_Attack_Werewolf }; -- Heavy Attack Werewolf
    [55890] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds'; name = Abilities.Skill_Heavy_Attack_Werewolf }; -- Heavy Attack
    [40124] = { hide = true }; -- Devour
    [40125] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }; -- Devour

    ----------------------------------------------------------------
    -- DARK BROTHERHOOD PASSIVES -----------------------------------
    ----------------------------------------------------------------

    [76325] = { icon = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds' }; -- Blade of Woe

    ----------------------------------------------------------------
    -- FIGHTERS GUILD PASSIVES -------------------------------------
    ----------------------------------------------------------------

    [29062] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_intimidating_presence.dds' };
    [35803] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' };
    [45595] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' };
    [45596] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' };
    [35800] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }; -- Banish the Wicked (Banish the Wicked - Rank 1)
    [35801] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }; -- Banish the Wicked (Banish the Wicked - Rank 1)
    [45597] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }; -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45598] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }; -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45599] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }; -- Banish the Wicked (Banish the Wicked - Rank 3)
    [45600] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }; -- Banish the Wicked (Banish the Wicked - Rank 3)
    [40393] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_skilled_tracker.dds' };
    [35804] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_bounty_hunter.dds' };

    ----------------------------------------------------------------
    -- FIGHTERS GUILD ACTIVE ABILITIES -----------------------------
    ----------------------------------------------------------------

    -- Silver Bolts / Silver Shards / Silver Leash
    [40340] = { icon = '/esoui/art/icons/ability_fightersguild_003_b.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Silver Leash (Silver Leash)
    [109354] = { icon = '/esoui/art/icons/ability_fightersguild_003_b.dds' }; -- Silver Leash (Silver Leash

    -- Circle of Protection / Turn Evil / Ring of Preservation
    [35737] = { tooltip = Tooltips.Skill_Circle_of_Protection }; -- Circle of Protection
    [40181] = { tooltip = Tooltips.Skill_Circle_of_Protection }; -- Turn Evil
    [40187] = { tooltip = Tooltips.Generic_Fear }; -- Turn Evil (Turn Evil)
    [40169] = { tooltip = Tooltips.Skill_Ring_of_Preservation }; -- Ring of Preservation
    [80293] = { tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 0.5; groundLabel = true }; -- Ring of Preservation (Ring of Preservation)

    -- Expert Hunter / Evil Hunter / Camouflaged Hunter
    [35762] = { tooltip = Tooltips.Skill_Expert_Hunter }; -- Expert Hunter (Expert Hunter)
    [80307] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Expert Hunter (Expert Hunter)
    [40194] = { tooltip = Tooltips.Skill_Evil_Hunter }; -- Evil Hunter (Evil Hunter)
    [80381] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Evil Hunter (Evil Hunter)
    [40195] = { tooltip = Tooltips.Skill_Expert_Hunter }; -- Camouflaged Hunter (Camouflaged Hunter)
    [80338] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Camouflaged Hunter (Camouflaged Hunter)

    -- Trap Beast / Barbed Trap / Lightweight Beast Trap
    [35750] = { tooltip = Tooltips.Skill_Trap_Beast; stack = 1 }; -- Trap Beast (Trap Beast)
    [35756] = { tooltip = Tooltips.Skill_Trap_Beast_Debuff }; -- Trap Beast (Trap Beast)
    [35753] = { hideReduce = true; tooltip = Tooltips.Skill_Trap_Beast_Debuff }; -- Trap Beast (Trap Beast)

    [40382] = { tooltip = Tooltips.Skill_Barbed_Trap; stack = 1 }; -- Barbed Trap (Barbed Trap)
    [40385] = { tooltip = Tooltips.Skill_Barbed_Trap_Debuff }; -- Barbed Trap (Barbed Trap)
    [40384] = { hideReduce = true; tooltip = Tooltips.Skill_Barbed_Trap_Debuff }; -- Barbed Trap (Barbed Trap)

    [40372] = { tooltip = Tooltips.Skill_Trap_Beast; stack = 1 }; -- Lightweight Beast Trap (Lightweight Beast Trap)
    [40375] = { tooltip = Tooltips.Skill_Trap_Beast_Debuff }; -- Lightweight Beast Trap (Lightweight Beast Trap)
    [40374] = { hideReduce = true; tooltip = Tooltips.Skill_Trap_Beast_Debuff }; -- Lightweight Beast Trap (Lightweight Beast Trap)

    -- Dawnbreaker / Flawless Dawnbreaker / Dawnbreaker of Smiting
    [62305] = { tooltip = Tooltips.Generic_Physical; tooltipValue2 = 2 }; -- Dawnbreaker
    [126312] = { name = Abilities.Skill_Flawless_Dawnbreaker; tooltip = Tooltips.Skill_Flawless_Dawnbreaker }; -- Flawless Dawnbreaker Passive (Flawless Dawnbreaker)
    [62310] = { tooltip = Tooltips.Generic_Physical; tooltipValue2 = 2 }; -- Flawless Dawnbreaker
    [40160] = { tooltip = Tooltips.Skill_Dawnbreaker_of_Smiting; hideReduce = true }; -- Dawnbreaker of Smiting
    [62314] = { tooltip = Tooltips.Skill_Dawnbreaker_of_Smiting }; -- Dawnbreaker of Smiting

    ----------------------------------------------------------------
    -- MAGES GUILD PASSIVES ----------------------------------------
    ----------------------------------------------------------------

    [29061] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_persuasive_will.dds' }; -- Persuasive Will
    [40436] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_mage_adept.dds' }; -- Mage Adept (Rank 1)
    [45601] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_mage_adept.dds' }; -- Mage Adept (Rank 2)
    [40437] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_everlasting_magic.dds' }; -- Everlasting Magic (Rank 1)
    [45602] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_everlasting_magic.dds' }; -- Everlasting Magic (Rank 2)
    [40438] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_magicka_controller.dds' }; -- Magicka Controller (Rank 1)
    [45603] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_magicka_controller.dds' }; -- Magicka Controller (Rank 2)
    [43561] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_might_of_the_guild.dds' }; -- Might of the Guild (Rank 1)
    [45607] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_might_of_the_guild.dds' }; -- Might of the Guild (Rank 2)

    ----------------------------------------------------------------
    -- MAGES GUILD ACTIVE ABILITIES --------------------------------
    ----------------------------------------------------------------

    -- Magelight / Radiant Magelight / Inner Light
    [30920] = { tooltip = Tooltips.Skill_Expert_Hunter }; -- Magelight (Magelight)
    [31079] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Magelight (Magelight)
    [40478] = { tooltip = Tooltips.Skill_Expert_Hunter }; -- Inner Light (Inner Light)
    [40480] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Reveal }; -- Inner Light (Inner Light)
    [40483] = { tooltip = Tooltips.Skill_Radiant_Magelight }; -- Radiant Magelight (Radiant Magelight)
    [40484] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Radiant Magelight (Radiant Magelight)

    -- Entropy / Degeneration / Structured Entropy
    [126370] = { tooltip = Tooltips.Generic_Magic; tooltipValue2 = 2 }; -- Entropy
    [126374] = { tooltip = Tooltips.Generic_Magic; tooltipValue2 = 2 }; -- Degeneration
    [126371] = { tooltip = Tooltips.Skill_Structured_Entropy }; -- Structured Entropy

    -- Fire Rune / Volcanic Rune / Scalding Rune
    [31632] = { tooltip = Tooltips.Skill_Fire_Rune }; -- Fire Rune (Fire Rune)
    [31633] = { hide = true }; -- Fire Rune (Fire Rune)
    [40470] = { tooltip = Tooltips.Skill_Volcanic_Rune }; -- Volcanic Rune (Volcanic Rune)
    [40477] = { icon = '/esoui/art/icons/ability_mageguild_001_a.dds'; hide = true }; -- Volcanic Rune (Volcanic Rune)
    [40476] = { tooltip = Tooltips.Generic_Knockback }; -- Volcanic Rune (Volcanic Rune)
    [40472] = { hide = true }; -- Volcanic Rune (Volcanic Rune)
    [40465] = { tooltip = Tooltips.Skill_Scalding_Rune }; -- Scaling Rune (Scalding Rune)
    [40468] = { tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Scalding Rune (Scalding Rune)
    [40467] = { hide = true }; -- Scalding Rune (Scalding Rune)

    -- Equilibrium / Spell Symmetry / Balance
    [48131] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Equilibrium }; -- Equilibrium (Equilibrium)
    [48136] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Equilibrium }; -- Spell Symmetry (Spell Symmetry)
    [40449] = { tooltip = Tooltips.Skill_Spell_Symmetry }; -- Spell Symmetry (Spell Symmetry)
    [48141] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Equilibrium }; -- Balance (Balance)

    -- Meteor / Ice Comet / Shooting Star
    [63430] = { icon = '/esoui/art/icons/ability_mageguild_005.dds'; tooltip = Tooltips.Skill_Meteor }; -- Meteor
    [16538] = { icon = '/esoui/art/icons/ability_mageguild_005.dds'; name = Abilities.Skill_Meteor }; -- Meteor Knockback (Meteor)
    [63429] = { tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1; groundLabel = true }; -- Meteor (Meteor)
    [114701] = { name = Abilities.Skill_Meteor; tooltip = Tooltips.Generic_Knockdown }; -- Stun (Meteor)
    [63456] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds'; tooltip = Tooltips.Skill_Ice_Comet }; -- Ice Comet
    [40492] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Ice Comet
    [63457] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds' }; -- Ice Comet (Ice Comet)
    [63455] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds'; name = Abilities.Skill_Ice_Comet }; -- Ice Comet Knockback (Ice Comet)
    [63454] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds'; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1; groundLabel = true }; -- Ice Comet (Ice Comet)
    [114714] = { name = Abilities.Skill_Ice_Comet; tooltip = Tooltips.Generic_Knockdown }; -- Stun (Ice Comet)
    [63473] = { icon = '/esoui/art/icons/ability_mageguild_005_a.dds'; tooltip = Tooltips.Skill_Meteor }; -- Shooting Star
    [63472] = { icon = '/esoui/art/icons/ability_mageguild_005_a.dds' }; -- Shooting Star (Shooting Star)
    [40495] = { icon = '/esoui/art/icons/ability_mageguild_005_a.dds' }; -- Shooting Star (Shooting Star)
    [63471] = { tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1; groundLabel = true }; -- Shooting Star (Shooting Star)
    [114715] = { name = Abilities.Skill_Shooting_Star; tooltip = Tooltips.Generic_Knockdown }; -- Shooting Star (Shooting Star)

    ----------------------------------------------------------------
    -- PSIJIC ORDER PASSIVES ---------------------------------------
    ----------------------------------------------------------------

    [103820] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds'; tooltip = Tooltips.Skill_Spell_Orb }; -- Spell Orb (Spell Orb - Rank 1)
    [103827] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds'; hide = true }; -- Spell Orb (Spell Orb - Rank 1)
    [103879] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds'; tooltip = Tooltips.Skill_Spell_Orb }; -- Spell Orb (Spell Orb - Rank 2)
    [103880] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds'; hide = true }; -- Spell Orb (Spell Orb - Rank 2)
    [103923] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_concentrated_barrier.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_Concentrated_Barrier; toggle = true }; -- Concentrated Barrier (Concentrated Barrier - Rank 1)
    [103966] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_concentrated_barrier.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_Concentrated_Barrier; toggle = true }; -- Concentrated Barrier (Concentrated Barrier - Rank 2)

    ----------------------------------------------------------------
    -- PSIJIC ORDER ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------

    -- Time Stop / Borrowed Time / Time Freeze
    [103538] = { tooltip = Tooltips.Skill_Time_Stop; groundLabel = true }; -- Time Stop (Time Stop)
    [104007] = { tooltip = Tooltips.Skill_Time_Stop; groundLabel = true }; -- Time Stop (Time Stop)
    [104009] = { tooltip = Tooltips.Skill_Time_Stop; groundLabel = true }; -- Time Stop (Time Stop)
    [104050] = { tooltip = Tooltips.Generic_Stun }; -- Time Stop (Time Stop)
    [104071] = { tooltip = Tooltips.Skill_Borrowed_Time; groundLabel = true }; -- Borrowed Time (Borrowed Time)
    [104072] = { tooltip = Tooltips.Skill_Borrowed_Time; groundLabel = true }; -- Borrowed Time (Borrowed Time)
    [104073] = { tooltip = Tooltips.Skill_Borrowed_Time; groundLabel = true }; -- Borrowed Time (Borrowed Time)
    [104075] = { hideReduce = true; tooltip = Tooltips.Skill_Borrowed_Time_Stun }; -- Borrowed Time (Borrowed Time)
    [104078] = { tooltip = Tooltips.Skill_Borrowed_Time_Stun }; -- Borrowed Time (Borrowed Time)
    [104079] = { tooltip = Tooltips.Skill_Time_Freeze_Ground }; -- Time Freeze (Time Freeze)
    [104080] = { tooltip = Tooltips.Skill_Time_Freeze; groundLabel = true }; -- Time Freeze (Time Freeze)
    [104081] = { tooltip = Tooltips.Skill_Time_Freeze; groundLabel = true }; -- Time Freeze (Time Freeze)
    [104082] = { tooltip = Tooltips.Skill_Time_Freeze; groundLabel = true }; -- Time Freeze (Time Freeze)
    [104083] = { tooltip = Tooltips.Skill_Time_Freeze; groundLabel = true }; -- Time Freeze (Time Freeze)
    [104085] = { tooltip = Tooltips.Generic_Stun }; -- Time Freeze (Time Freeze)

    -- Imbue Weapon / Elemental Weapon / Crushing Weapon
    [103483] = { tooltip = Tooltips.Skill_Imbue_Weapon }; -- Imbue Weapon (Imbue Weapon)
    [110420] = { icon = '/esoui/art/icons/ability_psijic_003.dds'; name = Abilities.Skill_Imbue_Weapon }; -- Imbue Weapon Restore (Imbue Weapon)
    [103571] = { tooltip = Tooltips.Skill_Elemental_Weapon }; -- Elemental Weapon (Elemental Weapon)
    [110421] = { icon = '/esoui/art/icons/ability_psijic_003_a.dds'; name = Abilities.Skill_Elemental_Weapon }; -- Elemental Weapon Restore (Elemental Weapon)
    [103623] = { tooltip = Tooltips.Skill_Crushing_Weapon }; -- Crushing Weapon (Crushing Weapon)
    [110422] = { icon = '/esoui/art/icons/ability_psijic_003_b.dds'; name = Abilities.Skill_Crushing_Weapon }; -- Crushing Weapon Restore (Crushing Weapon)

    -- Accelerate / Channeled Acceleration / Race Against Time
    [122260] = { icon = '/esoui/art/icons/ability_psijic_005_b.dds'; tooltip = Tooltips.Innate_Snare_Immobilize_Immunity }; -- Race Against Time (Race Against Time)

    -- Mend Wounds / Mend Spirit / Symbiosis
    [103543] = { tooltip = Tooltips.Skill_Mend_Wounds; toggle = true }; -- Mend Wounds (Mend Wounds)
    [107583] = { hide = true }; -- Mend Wounds (Mend Wounds)
    [118617] = { icon = '/esoui/art/icons/ability_psijic_006.dds' }; -- Mend Wounds (Mend Wounds)
    [103747] = { tooltip = Tooltips.Skill_Mend_Spirit; toggle = true }; -- Mend Spirit (Mend Spirit)
    [107629] = { hide = true }; -- Mend Spirit (Mend Spirit)
    [118638] = { icon = '/esoui/art/icons/ability_psijic_006_a.dds' }; -- Mend Spirit (Mend Spirit)
    [103755] = { tooltip = Tooltips.Skill_Symbiosis; toggle = true }; -- Symbiosis (Symbiosis)
    [107636] = { hide = true }; -- Symbiosis (Symbiosis)
    [118645] = { icon = '/esoui/art/icons/ability_psijic_006_b.dds' }; -- Symbiosis (Symbiosis)

    -- Meditate / Deep Thoughts / Introspection
    [103492] = { forcedContainer = 'short'; tooltip = Tooltips.Skill_Meditate; toggle = true }; -- Meditate (Meditate)
    [103500] = { icon = '/esoui/art/icons/ability_psijic_004.dds' }; -- Meditate (Meditate)
    [103501] = { icon = '/esoui/art/icons/ability_psijic_004.dds' }; -- Meditate (Meditate)
    [103652] = { forcedContainer = 'short'; tooltip = Tooltips.Skill_Meditate; toggle = true }; -- Deep Thoughts (Deep Thoughts)
    [103655] = { icon = '/esoui/art/icons/ability_psijic_004_a.dds' }; -- Deep Thoughts (Deep Thoughts)
    [103656] = { icon = '/esoui/art/icons/ability_psijic_004_a.dds' }; -- Deep Thoughts (Deep Thoughts)
    [103665] = { forcedContainer = 'short'; tooltip = Tooltips.Skill_Introspection; toggle = true }; -- Introspection (Introspection)
    [103668] = { icon = '/esoui/art/icons/ability_psijic_004_b.dds' }; -- Introspection (Introspection)
    [103669] = { icon = '/esoui/art/icons/ability_psijic_004_b.dds' }; -- Introspection (Introspection)

    ----------------------------------------------------------------
    -- UNDAUNTED PASSIVES ------------------------------------------
    ----------------------------------------------------------------

    [55584] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_command.dds' }; -- Undaunted Command (Undaunted Command - Rank 1)
    [55606] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds' }; -- Undaunted Command (Undaunted Command - Rank 1)
    [55607] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds'; name = Abilities.Passive_Undaunted_Command }; -- Undaunted Command Magicka Rest (Undaunted Command - Rank 1)
    [55608] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds'; name = Abilities.Passive_Undaunted_Command }; -- Undaunted Command Stamina Rest (Undaunted Command - Rank 1)
    [55676] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_command.dds' }; -- Undaunted Command (Undaunted Command - Rank 2)
    [55677] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds' }; -- Undaunted Command (Undaunted Command - Rank 2)
    [55678] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds'; name = Abilities.Passive_Undaunted_Command }; -- Undaunted Command Stamina Rest (Undaunted Command - Rank 2)
    [55679] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds'; name = Abilities.Passive_Undaunted_Command }; -- Undaunted Command Magicka Rest (Undaunted Command - Rank 2)
    [55366] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_mettle.dds' }; -- Undaunted Mettle (Undaunted Mettle - Rank 1)
    [55386] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_mettle.dds' }; -- Undaunted Mettle (Undaunted Mettle - Rank 2)

    ----------------------------------------------------------------
    -- UNDAUNTED ACTIVES -------------------------------------------
    ----------------------------------------------------------------

    -- Blood Altar / Sanguine Altar / Overflowing Altar
    [39501] = { icon = '/esoui/art/icons/ability_undaunted_001.dds' }; -- Blood Funnel (Blood Altar - Blood Funnel Synergy)
    [41964] = { icon = '/esoui/art/icons/ability_undaunted_001_a.dds' }; -- Blood Feast (Overflowing Altar)
    [39489] = { tooltip = Tooltips.Skill_Blood_Altar }; -- Blood Altar (Blood Altar)
    [41967] = { tooltip = Tooltips.Skill_Blood_Altar }; -- Sanguine Altar (Sanguine Altar)
    [41958] = { tooltip = Tooltips.Skill_Overflowing_Altar }; -- Overflowing Altar (Overflowing Altar)

    -- Trapping Webs / Shadow Silk / Tangling Webs
    [39430] = { icon = '/esoui/art/icons/ability_undaunted_003.dds'; tooltip = Tooltips.Skill_Spawn_Broodling }; -- Spawn Broodling (Trapping Webs - Spawn Broodling Synergy)
    [77245] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_bite.dds' }; -- Bite (Trapping Webs - Spawn Broodling Synergy)
    [39425] = { tooltip = Tooltips.Skill_Trapping_Webs }; -- Trapping Webs (Trapping Webs)
    [80079] = { duration = 0; tooltip = Tooltips.Skill_Trapping_Webs_Snare; groundLabel = true }; -- Trapping Webs (Trapping Webs)
    [41994] = { icon = '/esoui/art/icons/ability_undaunted_003_a.dds' }; -- Black Widow (Shadow Silk - Black Widow Synergy)
    [41998] = { icon = '/esoui/art/icons/ability_undaunted_003_a.dds'; tooltip = Tooltips.Skill_Spawn_Broodling }; -- Spawn Broodling (Shadow Silk - Black Widow Synergy)
    [42000] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_black_widow_poison.dds' }; -- Black Widow Poison (Shadow Silk - Black Widow Synergy)
    [42007] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_black_widow_poison.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Black Widow Poison (Shadow Silk - Black Widow Synergy)
    [41990] = { tooltip = Tooltips.Skill_Shadow_Silk }; -- Shadow Silk (Shadow Silk)
    [80108] = { icon = '/esoui/art/icons/ability_undaunted_003_a.dds'; duration = 0; tooltip = Tooltips.Skill_Trapping_Webs_Snare; groundLabel = true }; -- Shadow Silk (Shadow Silk)
    [126720] = { icon = '/esoui/art/icons/ability_undaunted_003_a.dds' }; -- Shadow Silk (Shadow Silk)
    [80107] = { icon = '/esoui/art/icons/ability_undaunted_003_a.dds' }; -- Shadow Silk (Shadow Silk)
    [42016] = { icon = '/esoui/art/icons/ability_undaunted_003_b.dds' }; -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [42023] = { icon = '/esoui/art/icons/ability_undaunted_003_b.dds'; tooltip = Tooltips.Generic_Fear }; -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [42020] = { tooltip = Tooltips.Skill_Spawn_Broodling }; -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [42012] = { tooltip = Tooltips.Skill_Tangling_Webs }; -- Tangling Webs (Tangling Webs)
    [80130] = { icon = '/esoui/art/icons/ability_undaunted_003_b.dds'; duration = 0; tooltip = Tooltips.Skill_Trapping_Webs_Snare; groundLabel = true }; --  Tangling Webs (Tangling Webs)
    [126722] = { icon = '/esoui/art/icons/ability_undaunted_003_b.dds' }; --  Tangling Webs (Tangling Webs)
    [80129] = { icon = '/esoui/art/icons/ability_undaunted_003_b.dds' }; --  Tangling Webs (Tangling Webs)

    -- Inner Fire / Inner Rage / Inner Beast
    [42062] = { tooltip = Tooltips.Skill_Inner_Beast }; -- Inner Beast (Inner Beast)
    [41838] = { tooltip = Tooltips.Skill_Radiate }; -- Radiate (Inner Fire - Radiate Synergy)

    -- Bone Shield / Spiked Bone Shield / Bone Surge
    [39379] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Bone Wall (Bone Shield - Bone Wall Synergy)
    [42198] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Spinal Surge (Bone Surge - Spinal Surge Synergy)
    [39369] = { tooltip = Tooltips.Skill_Bone_Shield }; -- Bone Shield
    [42138] = { tooltip = Tooltips.Skill_Spiked_Bone_Shield }; -- Spiked Bone Shield
    [42176] = { tooltip = Tooltips.Skill_Bone_Surge }; -- Bone Surge

    -- Necrotic Orb / Mystic Orb / Energy Orb
    [85432] = { icon = '/esoui/art/icons/ability_undaunted_004.dds' }; -- Combustion (Necrotic Orb - Combustion Synergy)
    [95041] = { icon = '/esoui/art/icons/ability_undaunted_004b.dds' }; -- Combustion (Energy Orb - Healing Combustion Synergy)
    [95042] = { icon = '/esoui/art/icons/ability_undaunted_004b.dds' }; -- Combustion (Energy Orb - Healing Combustion Synergy)
    [63511] = { icon = '/esoui/art/icons/ability_undaunted_004b.dds' }; -- Combustion (Energy Orb - Healing Combustion Synergy)

    [39298] = { tooltip = Tooltips.Skill_Necrotic_Orb }; -- Necrotic Orb (Necrotic Orb)
    [39299] = { tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1; groundLabel = true }; -- Necrotic Orb (Necrotic Orb)
    [42028] = { tooltip = Tooltips.Skill_Necrotic_Orb }; -- Mystic Orb (Mystic Orb)
    [42029] = { tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1; groundLabel = true }; -- Mystic Orb (Mystic Orb)
    [42038] = { tooltip = Tooltips.Skill_Energy_Orb }; -- Energy Orb (Energy Orb)
    [42039] = { tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1; groundLabel = true }; -- Energy Orb (Energy Orb)

    ----------------------------------------------------------------
    -- ASSAULT PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39248] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }; -- Continuous Attack (Continuous Attack - Rank 1)
    [39249] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds'; tooltip = Tooltips.Skill_Continuous_Attack_Rank_1 }; -- Continuous Attack (Continuous Attack - Rank 1)
    [45614] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }; -- Continuous Attack (Continuous Attack - Rank 2)
    [45617] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds'; tooltip = Tooltips.Skill_Continuous_Attack_Rank_2 }; -- Continuous Attack (Continuous Attack - Rank 2)
    [39254] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_reach.dds' }; -- Reach
    [45621] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_reach.dds' }; -- Reach
    [39252] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_frenzy.dds' }; -- Combat Frenzy (Combat Frenzy - Rank 1)
    [39253] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds' }; -- Combat Frenzy (Combat Frenzy - Rank 1)
    [45619] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_frenzy.dds' }; -- Combat Frenzy (Combat Frenzy - Rank 2)
    [45620] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds' }; -- Combat Frenzy (Combat Frenzy - Rank 2)

    ----------------------------------------------------------------
    -- ASSAULT ACTIVES ---------------------------------------------
    ----------------------------------------------------------------

    -- Rapid Manuever / Retreating Maneuver / Charging Maneuver
    [40211] = { tooltip = Tooltips.Skill_Retreating_Maneuver }; -- Retreating Maneuver (Retreating Maneuver)

    -- Vigor / Echoing Vigor / Resolving Vigor
    [61504] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Vigor (Vigor)
    [61506] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Echoing Vigor (Echoing Vigor)
    [61509] = { tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Resolving Vigor (Resolving Vigor)

    -- Caltrops / Anti-Cavalry Caltrops / Razor Caltrops
    [38549] = { icon = '/esoui/art/icons/ability_ava_001.dds'; tooltip = Tooltips.Skill_Caltrops }; -- Caltrops (Caltrops)
    [38561] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Physical; tooltipValue2 = 1; tooltipValue3 = 50 }; -- Caltrops (Caltrops)
    [113769] = { tooltip = Tooltips.Generic_AOE_Snare_Physical; tooltipValue2 = 1; tooltipValue3 = 50; groundLabel = true; hideGround = true }; -- Caltrops (Caltrops)

    [40265] = { icon = '/esoui/art/icons/ability_ava_001_a.dds'; tooltip = Tooltips.Skill_Anti_Cavalry_Caltrops }; -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40267] = { groundLabel = true; tooltip = Tooltips.Skill_Anti_Cavalry_Caltrops_Debuff }; -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [113770] = { tooltip = Tooltips.Skill_Anti_Cavalry_Caltrops_Debuff; groundLabel = true; hideGround = true }; -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)

    [40251] = { icon = '/esoui/art/icons/ability_ava_001_b.dds'; name = Abilities.Skill_Razor_Caltrops; tooltip = Tooltips.Skill_Razor_Caltrops }; -- Caltrops (Razor Caltrops)
    [113771] = { tooltip = Tooltips.Skill_Razor_Caltrops_Debuff; groundLabel = true; hideGround = true }; -- Razor Caltrops (Razor Caltrops)
    [40252] = { groundLabel = true; tooltip = Tooltips.Skill_Razor_Caltrops_Debuff }; -- Razor Caltrops (Razor Caltrops)

    -- Magicka Detonation/ Inevitable Detonation / Proximity Detonation
    [61487] = { tooltip = Tooltips.Skill_Magicka_Detonation }; -- Magicka Detonation (Magicka Detonation)
    [66482] = { hide = true }; -- Magicka Detonation (Magicka Detonation)
    [61491] = { tooltip = Tooltips.Skill_Inevitable_Detonation }; -- Magicka Detonation (Inevitable Detonation)
    [66491] = { hide = true }; -- Magicka Detonation (Inevitable Detonation)
    [61500] = { tooltip = Tooltips.Skill_Proximity_Detonation }; -- Magicka Detonation (Proximity Detonation)
    [66499] = { hide = true }; -- Magicka Detonation (Proximity Detonation)

    -- War Horn
    [38564] = { tooltip = Tooltips.Skill_War_Horn }; -- War Horn (War Horn)
    [40224] = { tooltip = Tooltips.Skill_War_Horn }; -- Aggresive Horn (Aggresive Horn)
    [40221] = { tooltip = Tooltips.Skill_Study_Horn }; -- Sturdy Horn (Sturdy Horn)
    [63571] = { tooltip = Tooltips.Skill_Study_Horn; icon = '/esoui/art/icons/ability_ava_003_b.dds'; hideReduce = true }; -- Sturdy Horn (Sturdy Horn)

    ----------------------------------------------------------------
    -- SUPPORT PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39255] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_magicka_aid.dds' }; -- Magicka Aid
    [45622] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_magicka_aid.dds' }; -- Magicka Aid
    [39259] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_medic.dds' }; -- Combat Medic
    [45624] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_medic.dds' }; -- Combat Medic
    [39261] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_battle_resurrection.dds' }; -- Battle Resurrection
    [45625] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_battle_resurrection.dds' }; -- Battle Resurrection

    ----------------------------------------------------------------
    -- SUPPORT ACTIVES ---------------------------------------------
    ----------------------------------------------------------------

    -- Siege Shield / Siege Weapon Shield / Propelling Shield
    [38570] = { tooltip = Tooltips.Skill_Siege_Shield_Ground }; -- Siege Shield (Siege Shield)
    [39844] = { duration = 0; forcedContainer = 'short'; groundLabel = true; tooltip = Tooltips.Skill_Siege_Shield }; -- Siege Shield (Siege Shield)
    [40229] = { tooltip = Tooltips.Skill_Siege_Weapon_Shield_Ground }; -- Siege Weapon Shield (Siege Weapon Shield)
    [40231] = { duration = 0; forcedContainer = 'short'; groundLabel = true; tooltip = Tooltips.Skill_Siege_Weapon_Shield }; -- Siege Weapon Shield (Siege Weapon Shield)
    [40226] = { tooltip = Tooltips.Skill_Propelling_Shield_Ground }; -- Propelling Shield (Siege Weapon Shield)
    [40227] = { duration = 0; forcedContainer = 'short'; groundLabel = true; tooltip = Tooltips.Skill_Propelling_Shield }; -- Propelling Shield (Siege Weapon Shield)

    -- Purge / Efficient Purge / Cleanse
    [40234] = { hide = true }; -- Cleanse (Cleanse)

    -- Guard / Mystic Guard / Stalwart Guard
    [61511] = { duration = 0; forcedContainer = 'short'; tooltip = Tooltips.Skill_Guard_Other }; -- Guard (Guard)
    [80923] = { duration = 0; tooltip = Tooltips.Skill_Guard_Self; toggle = true }; -- Guard (Guard)
    [78338] = { icon = '/esoui/art/icons/ability_ava_guard.dds' }; -- Guard (Guard)
    [61536] = { duration = 0; forcedContainer = 'short'; tooltip = Tooltips.Skill_Guard_Other }; -- Mystic Guard (Mystic Guard)
    [80947] = { duration = 0; tooltip = Tooltips.Skill_Guard_Self; toggle = true }; -- Mystic Guard (Mystic Guard)
    [81415] = { icon = '/esoui/art/icons/ability_ava_mystic_guard.dds' }; -- Mystic Guard (Mystic Guard)
    [61529] = { duration = 0; forcedContainer = 'short'; tooltip = Tooltips.Skill_Guard_Other }; -- Stalwart Guard (Stalwart Guard)
    [80983] = { duration = 0; tooltip = Tooltips.Skill_Guard_Self; toggle = true }; -- Stalwart Guard (Stalwart Guard)
    [81420] = { icon = '/esoui/art/icons/ability_ava_stalwart_guard.dds' }; -- Stalwart Guard (Stalwart Guard)

    -- Skill_Revealing_Flare

    -- Revealing Flare / Lingering Flare / Blinding Flare
    [61498] = { tooltip = Tooltips.Skill_Revealing_Flare }; -- Revealing Flare (Revealing Flare)
    [61496] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Revealing Flare (Revealing Flare)
    [61522] = { name = Abilities.Skill_Lingering_Flare; tooltip = Tooltips.Skill_Revealing_Flare }; -- Nova (Lingering Flare)
    [61521] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Lingering Flare (Lingering Flare)
    [61526] = { tooltip = Tooltips.Skill_Blinding_Flare }; -- Blinding Flare (Blinding Flare)
    [61528] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; name = Abilities.Skill_Revealed; tooltip = Tooltips.Generic_Reveal }; -- Blinding Flare Reveal (Blinding Flare)
    [77974] = { tooltip = Tooltips.Generic_Stun }; -- Blinding Flare (Blinding Flare)

    -- Barrier / Reviving Barrier / Replenishing Barrier
    [38573] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Barrier (Barrier)
    [40237] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Reviving Barrier (Reviving Barrier)
    [40238] = { name = Abilities.Skill_Reviving_Barrier; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 1 }; -- Reviving Barrier Heal (Reviving Barrier)
    [40239] = { tooltip = Tooltips.Skill_Replenishing_Barrier }; -- Replenishing Barrier (Replenishing Barrier)
    [40240] = { icon = '/esoui/art/icons/ability_ava_006_a.dds' }; -- Replenishing Barrier (Replenishing Barrier)
    [40241] = { icon = '/esoui/art/icons/ability_ava_006_a.dds' }; -- Replenishing Barrier (Replenishing Barrier)

    ----------------------------------------------------------------
    -- EMPEROR PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39625] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_monarch.dds' }; -- Monarch
    [39630] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_authority.dds' }; -- Authority
    [39644] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_domination.dds' }; -- Domination
    [39647] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_tactician.dds' }; -- Tactician
    [39641] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_emperor.dds' }; -- Emperor

    ----------------------------------------------------------------
    -- PLAYER PASSIVES RACIAL --------------------------------------
    ----------------------------------------------------------------

    -- Breton
    [36247] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_opportunist.dds' }; -- Opportunist
    [35995] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }; -- Gift of Magnus (Rank 1)
    [45259] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }; -- Gift of Magnus (Rank 2)
    [45260] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }; -- Gift of Magnus (Rank 3)
    [36266] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }; -- Spell Resistance (Rank 1)
    [45261] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }; -- Spell Resistance (Rank 2)
    [45262] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }; -- Spell Resistance (Rank 3)
    [36303] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }; -- Magicka Mastery (Rank 1)
    [45263] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }; -- Magicka Mastery (Rank 2)
    [45264] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }; -- Magicka Mastery (Rank 3)

    -- Orc (Orsimer)
    [33293] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_craftsman.dds' }; -- Craftsman
    [33301] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }; -- Brawny (Rank 1)
    [45307] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }; -- Brawny (Rank 2)
    [45309] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }; -- Brawny (Rank 3)
    [84668] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }; -- Unflinching Rage (Rank 1)
    [118195] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }; -- Unflinching Rage (Rank 1)
    [118196] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }; -- Unflinching Rage (Rank 1)
    [84670] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }; -- Unflinching Rage (Rank 2)
    [118202] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }; -- Unflinching Rage (Rank 2)
    [118203] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }; -- Unflinching Rage (Rank 2)
    [84672] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }; -- Unflinching Rage (Rank 3)
    [118205] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }; -- Unflinching Rage (Rank 3)
    [118206] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }; -- Unflinching Rage (Rank 3)
    [33304] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }; -- Swift Warrior (Rank 1)
    [45311] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }; -- Swift Warrior (Rank 2)
    [45312] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }; -- Swift Warrior (Rank 3)

    -- Redguard
    [84680] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_wayfarer.dds' }; -- Wayfarer
    [36009] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }; -- Martial Training (Rank 1)
    [45277] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }; -- Martial Training (Rank 2)
    [45278] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }; -- Martial Training (Rank 3)
    [117752] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }; -- Conditioning (Rank 1)
    [117753] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }; -- Conditioning (Rank 2)
    [117754] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }; -- Conditioning (Rank 3)
    [36546] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }; -- Adrenaline Rush (Rank 1)
    [36548] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }; -- Adrenaline Rush (Adrenaline Rush - Rank 1)
    [45313] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }; -- Adrenaline Rush (Rank 2)
    [45314] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }; -- Adrenaline Rush (Adrenaline Rush - Rank 2)
    [45315] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }; -- Adrenaline Rush (Rank 3)
    [45316] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }; -- Adrenaline Rush (Adrenaline Rush - Rank 3)

    -- High Elf (Altmer)
    [35965] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_highborn.dds' }; -- Highborn
    [35993] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 1)
    [118110] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 1)
    [118111] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 1)
    [45273] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 2)
    [118113] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 2)
    [118114] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 2)
    [45274] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 3)
    [118116] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 3)
    [118117] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }; -- Spell Recharge (Rank 3)
    [117968] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_syrabanes_boon.dds' }; -- Syrabane's Boon (Rank 1)
    [117969] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_syrabanes_boon.dds' }; -- Syrabane's Boon (Rank 2)
    [117970] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_syrabanes_boon.dds' }; -- Syrabane's Boon (Rank 3)
    [35998] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }; -- Elemental Talent (Rank 1)
    [45275] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }; -- Elemental Talent (Rank 2)
    [45276] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }; -- Elemental Talent (Rank 3)

    -- Wood Elf (Bosmer)
    [36008] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_acrobat.dds'; hide = true }; -- Acrobat -- SHOWS ONLY ON TARGET PLAYERS
    [36022] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_hunters_eye.dds' }; -- Hunter's Eye (Rank 1)
    [45295] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_hunters_eye.dds' }; -- Hunter's Eye (Rank 2)
    [45296] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_hunters_eye.dds' }; -- Hunter's Eye (Rank 3)
    [64279] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }; -- Y'ffre's Endurance (Rank 1)
    [64280] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }; -- Y'ffre's Endurance (Rank 2)
    [64281] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }; -- Y'ffre's Endurance (Rank 3)
    [36011] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }; -- Resist Affliction (Rank 1)
    [45317] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }; -- Resist Affliction (Rank 2)
    [45319] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }; -- Resist Affliction (Rank 3)

    -- Khajiit
    [36063] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_cutpurse.dds' }; -- Cutpurse
    [70386] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }; -- Nimble (Rank 1)
    [70388] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }; -- Nimble (Rank 2)
    [70390] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }; -- Nimble (Rank 3)
    [117846] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_lunar_blessings.dds' }; -- Lunar Blessings (Rank 1)
    [117847] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_lunar_blessings.dds' }; -- Lunar Blessings (Rank 2)
    [117848] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_lunar_blessings.dds' }; -- Lunar Blessings (Rank 3)
    [36067] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }; -- Carnage (Rank 1)
    [45299] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }; -- Carnage (Rank 2)
    [45301] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }; -- Carnage (Rank 3)

    -- Argonian
    [36582] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_amphibian.dds' }; -- Amphibian
    [36568] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }; -- Resourceful (Rank 1)
    [45243] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }; -- Resourceful (Rank 2)
    [45247] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }; -- Resourceful (Rank 3)
    [36583] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }; -- Argonian Resistance (Rank 1)
    [45253] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }; -- Argonian Resistance (Rank 2)
    [45255] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }; -- Argonian Resistance (Rank 3)
    [36585] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }; -- Quick to Mend (Rank 1)
    [45257] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }; -- Quick to Mend (Rank 2)
    [45258] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }; -- Quick to Mend (Rank 3)

    -- Dark Elf (Dunmer)
    [36588] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_ashlander.dds' }; -- Ashlander
    [36591] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }; -- Dynamic (Rank 1)
    [45265] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }; -- Dynamic (Rank 2)
    [45267] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }; -- Dynamic (Rank 3)
    [36593] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }; -- Resist Flame (Rank 1)
    [45269] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }; -- Resist Flame (Rank 2)
    [45270] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }; -- Resist Flame (Rank 3)
    [36598] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }; -- Destructive Ancestry (Rank 1)
    [45271] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }; -- Destructive Ancestry (Rank 2)
    [45272] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }; -- Destructive Ancestry (Rank 3)

    -- Nord
    [36626] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_reveler.dds' }; -- Reveler
    [36064] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }; -- Stalwart (Rank 1)
    [118182] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_stalwart.dds' }; -- Stalwart (Rank 1)
    [45297] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }; -- Stalwart (Rank 2)
    [118184] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_stalwart.dds' }; -- Stalwart (Rank 2)
    [45298] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }; -- Stalwart (Rank 3)
    [118186] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_stalwart.dds' }; -- Stalwart (Rank 3)
    [36627] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }; -- Resist Frost (Rank 1)
    [45303] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }; -- Resist Frost (Rank 2)
    [45304] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }; -- Resist Frost
    [36628] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }; -- Rugged (Rank 1)
    [45305] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }; -- Rugged (Rank 2)
    [45306] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }; -- Rugged (Rank 3)

    -- Imperial
    [36312] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_diplomat.dds' }; -- Diplomat
    [50903] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }; -- Tough (Rank 1)
    [50906] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }; -- Tough (Rank 2)
    [50907] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }; -- Tough (Rank 3)
    [36153] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_imperial_mettle.dds' }; -- Imperial Mettle (Rank 1)
    [45279] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_imperial_mettle.dds' }; -- Imperial Mettle (Rank 2)
    [45280] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_imperial_mettle.dds' }; -- Imperial Mettle (Rank 3)
    [36155] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }; -- Red Diamond (Rank 1)
    [45291] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }; -- Red Diamond (Rank 2)
    [45293] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }; -- Red Diamond (Rank 3)
    [63694] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 1)
    [63695] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 1)
    [63696] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 1)
    [63697] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 2)
    [63698] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 2)
    [63699] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 2)
    [63701] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 3)
    [63702] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 3)
    [63703] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }; -- Resourceful (Resourceful - Rank 3)

    ----------------------------------------------------------------
    -- CRAFTING PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    [48160] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_metallurgy.dds' }; -- Metallurgy (Metallurgy - Rank 1)
    [48161] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_metallurgy.dds' }; -- Metallurgy (Metallurgy - Rank 2)
    [48162] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_metallurgy.dds' }; -- Metallurgy (Metallurgy - Rank 3)
    [58784] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_metallurgy.dds' }; -- Metallurgy (Metallurgy - Rank 4)

    [48190] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_stitching.dds' }; -- Stitching (Stitching - Rank 1)
    [48191] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_stitching.dds' }; -- Stitching (Stitching - Rank 2)
    [48192] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_stitching.dds' }; -- Stitching (Stitching - Rank 3)
    [58782] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_stitching.dds' }; -- Stitching (Stitching - Rank 4)

    [48181] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_carpentry.dds' }; -- Carpentry (Carpentry - Rank 1)
    [48182] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_carpentry.dds' }; -- Carpentry (Carpentry - Rank 2)
    [48183] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_carpentry.dds' }; -- Carpentry (Carpentry - Rank 3)
    [58783] = { icon = 'LuiExtended/media/icons/abilities/passive_crafting_carpentry.dds' }; -- Carpentry (Carpentry - Rank 4)

    --[[
    [88480] = { hide = true }, -- Trap Triggerer (Various)
    [65854] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spike Trap Snare (Spike Trap) (Orsinium - To Save a Chief)
    [65855] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Trap Sprung (Spike Trap) (Orsinium - To Save a Chief)
    [65856] = { hide = true }, -- Spike Trap (Spike Trap) (Orsinium - To Save a Chief)
    [73103] = { hide = true }, -- Lava (Orsinium - The Hand of Morkul) (Lava)
    ]]
    --

    -- New Listing
    [73095] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds'; name = Abilities.Trap_Lava }; -- In Lava (Vvardenfell - Nchuleftingth - Public Dungeon)
    --[[
    [89481] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Flame Jet (Vvardenfell -- An Armiger's Duty)
    [88403] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Flame Jet (Vvardenfell -- Ancestral Adversity)
    [88491] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Searing Flame (Vvardenfell -- Ancestral Adversity)
    [88510] = { name = Abilities.Innate_Stagger, hide = true }, -- Staggered (Vvardenfell -- Ancestral Adversity)
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
    ]]
    --

    ----------------------------------------------------------------
    -- JUSTICE NPCS ------------------------------------------------
    ----------------------------------------------------------------

    [63153] = { hide = true }; -- Guard Immunities (Justice Guard)
    [63174] = { hide = true }; -- Guard Speed Boost (Justice Guard)
    [63168] = { tooltip = Tooltips.Generic_Immobilize }; -- Cage Talons (Justice Guard 1H + 2H)
    [63095] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_focused_strike.dds' }; -- Focused Strike (Justice Guard)
    [63157] = { icon = '/esoui/art/icons/ability_1handed_005.dds'; name = Abilities.Skill_Power_Bash }; -- Heavy Blow (Justice Guard)
    [63268] = { icon = '/esoui/art/icons/ability_1handed_005.dds'; name = Abilities.Skill_Power_Bash }; -- Uppercut (Justice Guard)
    [63160] = { icon = '/esoui/art/icons/ability_1handed_005.dds'; name = Abilities.Skill_Power_Bash; tooltip = Tooltips.Generic_Knockback }; -- Heavy Blow Knockdown (Justice Guard)
    [63094] = { tooltip = Tooltips.Generic_Stun }; -- Shield Charge (Justice Guard)
    [63261] = { icon = '/esoui/art/icons/ability_2handed_001.dds'; name = Abilities.Skill_Uppercut }; -- Heavy Blow (Justice Guard)
    [63265] = { icon = '/esoui/art/icons/ability_2handed_001.dds' }; -- Uppercut (Justice Guard)
    [63263] = { icon = '/esoui/art/icons/ability_2handed_001.dds'; name = Abilities.Skill_Uppercut; tooltip = Tooltips.Generic_Knockback }; -- Heavy Blow Knockdown (Justice Guard)
    [63093] = { name = Abilities.Skill_Shield_Charge }; -- Charge (Justice Guard 1H)
    [63259] = { name = Abilities.Skill_Mighty_Charge }; -- Charge (Justice Guard 2H)
    [63260] = { icon = '/esoui/art/icons/ability_2handed_003.dds'; name = Abilities.Skill_Mighty_Charge; tooltip = Tooltips.Generic_Stun }; -- Charge (Justice Guard 2H)
    [63198] = { name = Abilities.Skill_Fiery_Grip }; -- Fiery Chain (Justice Guard)
    [63200] = { name = Abilities.Skill_Fiery_Grip }; -- Firey Chain (Justice Guard)
    [64139] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_piercing_bolt.dds' }; -- Piercing Bolt (Justice Guard)
    [64267] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_focused_shot.dds' }; -- Piercing Bolt (Justice Guard)
    [63911] = { hide = true }; -- Guard Stacking Damage
    [78804] = { hide = true }; -- Seek
    [78802] = { hide = true }; -- Seek
    [78760] = { hide = true }; -- Confusion
    [78764] = { hide = true }; -- Confusion
    [78775] = { hide = true }; -- Confusion
    [78767] = { hide = true }; -- Confusion
    [78768] = { hide = true }; -- Confusion
    [78769] = { hide = true }; -- Confusion
    [78770] = { hide = true }; -- Confusion
    [78766] = { hide = true }; -- Confusion
    [78772] = { hide = true }; -- Confusion
    [78771] = { hide = true }; -- Confusion
    [63179] = { icon = '/esoui/art/icons/ability_dragonknight_013.dds'; name = Abilities.Skill_Stonefist }; -- Flame Shard (Justice Guard 2H)
    [63194] = { icon = '/esoui/art/icons/ability_dragonknight_013.dds'; name = Abilities.Skill_Stonefist; tooltip = Tooltips.Generic_Stun }; -- Flame Shard (Justice Guard 2H)
    [78743] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_reveal.dds' }; -- Flare (Guard)
    [78789] = { hide = true }; -- Flare (Guard)
    [78750] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; tooltip = Tooltips.Generic_Reveal }; -- Revealed (Guard)
    [78744] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_reveal.dds' }; -- Flare (Guard)
    [75613] = { hide = true }; -- Shadowcloak Immunity (Mage Guard)
    [77919] = { hide = true }; -- Clairvoyance Tutorial (Mage Guard)
    [77937] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds'; name = Abilities.Skill_Detection; tooltip = Tooltips.Generic_Detection_NPC }; -- Clairvoyance (Mage Guard)
    [77941] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; duration = 0; unbreakable = 1; groundLabel = true; tooltip = Tooltips.Generic_Reveal_No_Dur }; -- Revealed (Mage Guard)
    [77917] = { hide = true }; -- Empower Weapon: Flame (Mage Guard)
    [74502] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_focused_strike.dds' }; -- Focused Strike (Mage Guard)
    [74503] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_focused_strike.dds' }; -- Focused Strike (Mage Guard)
    [74504] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_focused_strike.dds' }; -- Focused Strike (Mage Guard)
    [74862] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_teleport_trap.dds' }; -- Teleport Trap (Mage Guard)
    [74870] = { hide = true }; -- Teleport Trap (Mage Guard)
    [74864] = { hide = true }; -- Teleport Trap (Mage Guard)
    [74863] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_teleport_trap.dds' }; -- Teleport Trap (Mage Guard)
    [74510] = { tooltip = Tooltips.Generic_Immobilize }; -- Encase
    [77449] = { hide = true }; -- Clairvoyance Tutorial (Mage Guard - Instanced)
    [72694] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds'; name = Abilities.Skill_Detection; tooltip = Tooltips.Generic_Detection_NPC }; -- Clairvoyance (Mage Guard - Instanced)
    [72695] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; duration = 0; unbreakable = 1; groundLabel = true; tooltip = Tooltips.Generic_Reveal_No_Dur }; -- Revealed (Mage Guard - Instanced)
    [78060] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Reveal }; -- Revealed (Mage Guard - Instanced)
    [75809] = { hide = true }; -- Guard Speed Boost (Mage Guard - Instanced)
    [64647] = { hide = true }; -- Remove Effects (Guard)
    [73226] = { hide = true }; -- Hurried Ward (DB Guard)
    [77452] = { hide = true }; -- Shadow Cloak Immunity (Basic Justice NPC)
    [78012] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds' }; -- Quick Strike (Basic Justice NPC)
    [62472] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_stab.dds' }; -- Stab (Justice Rogue)
    [62506] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_throw_dagger.dds'; name = Abilities.Skill_Throw_Dagger; hide = true }; -- Thrown Dagger (Justice Rogue)
    [78013] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quick_shot.dds'; hide = true }; -- Quick Shot (Justice Archer)
    [62408] = { hide = true }; -- Bound Weapon (Justice Mage)
    [62409] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flames.dds' }; -- Fiery Wind (Justice Mage)
    [62502] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flames.dds' }; -- Fiery Wind (Justice Mage)
    [62407] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_alt.dds' }; -- Fiery Touch (Justice Mage)
    [61984] = { hide = true }; -- Invisibility Potion (Justice Mage)
    [78265] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_alarm.dds'; hide = true }; -- Alarm (Estate Marshal - DB)
    [78266] = { hide = true }; -- Alarm (Estate Marshal - DB)
    [73229] = { icon = '/esoui/art/icons/ability_mage_030.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Hurried Ward (Mage Guard - DB)

    ----------------------------------------------------------------
    -- NPC(Basic) --------------------------------------------------
    ----------------------------------------------------------------

    -- Shared NPC Passives
    [33097] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boss_immunities.dds'; name = Abilities.Skill_Boss_CC_Immunity; tooltip = Tooltips.Generic_Scary_Immunities }; -- Scary Immunities
    [44176] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_flying_immunities.dds'; tooltip = Tooltips.Generic_Flying_Immunities }; -- Flying Immunities
    [13739] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_backstabber.dds'; tooltip = Tooltips.Skill_Backstabber }; -- Backstabber
    [73768] = { hide = true }; -- GEN 5 Hits
    [79147] = { hide = true }; -- GEN 3 Hits
    [73916] = { hide = true }; -- GEN 2 Hits

    -- Shared NPC Active Events
    [8239] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hamstrung.dds'; name = Abilities.Skill_Hamstring; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 30 }; -- Hamstrung

    -- Standard NPC Abilities
    [2874] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Staggered (Generic Stagger applied to player by many different NPC abilities)

    -- Critter events
    [79544] = { hide = true }; -- Mischievous Dodge (Nixad)
    [79555] = { hide = true }; -- Mischievous Dodge (Nixad)
    [40165] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds'; name = Abilities.Innate_Brace; duration = 0; tooltip = Tooltips.Skill_Block_NPC_Theater; toggle = true }; -- Scene Choreo Brace (Monster Fight)

    -- Friendly NPC Abilities
    [48330] = { hide = true }; -- Aspect of Terror (Abnur Tharn)
    [48331] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aspect_of_terror.dds' }; -- Aspect of Terror (Abnur Tharn)
    [48337] = { hide = true }; -- Burning Arrow (Elolir - City of Ash I)
    [42905] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds'; tooltip = Tooltips.Skill_Recover }; -- Recover
    [42937] = { hide = true }; -- TargetPriorityException

    [4197] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds'; name = Abilities.Skill_Recover; hide = true }; -- Recovering
    [4198] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds'; name = Abilities.Skill_Recover }; -- PC Duel Heal

    -- Human NPC Abilities
    [18386] = { hide = true }; -- Run Away! (Used by various creatures)
    [10618] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds' }; -- Quick Strike (Shared Human NPC)
    [12437] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quick_shot.dds'; hide = true }; -- Quick Shot (Shared Human NPC)
    [12456] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; hide = true }; -- Ice Arrow (Shared Human NPC)
    [10639] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds'; hide = true }; -- Flare (Shared Human NPC)
    [39058] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }; -- Bear Trap (Shared Human NPC)
    [39060] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Immobilize }; -- Bear Trap (Shared Human NPC)
    [39065] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }; -- Bear Trap (Shared Human NPC)
    [11039] = { hide = true }; -- Spread Out Sound (Synergy)
    [10650] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_oil_snare.dds'; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 50; groundLabel = true }; -- Oil Drenched (Synergy)
    [12439] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_arrow.dds'; name = Abilities.Skill_Ignite }; -- Burning Arrow (Synergy - Archer)
    [14068] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Ignite (Synergy - Archer)
    [10805] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ignite.dds' }; -- Ignite (Synergy - Fire Mage)
    [10813] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.5 }; -- Ignite (Synergy - Fire Mage)
    [38260] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Ignite (Synergy - Fire Mage)
    [31387] = { hide = true }; -- Necromancer Snergy Kill Self

    -- Footsoldier (1H)
    [14096] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds' }; -- Heavy Attack (Footsoldier)
    [28499] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_throw_dagger.dds'; hide = true }; -- Throw Dagger (Footsoldier)
    [28502] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_throw_dagger.dds'; tooltip = Tooltips.Skill_Throw_Dagger }; -- Throw Dagger (Footsoldier)
    [28504] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_throw_dagger.dds'; hideReduce = true; tooltip = Tooltips.Skill_Throw_Dagger }; -- Throw Dagger (Footsoldier)

    -- Guard (1H + Shield)
    [29400] = { icon = '/esoui/art/icons/ability_1handed_005.dds' }; -- Power Bash (Guard)
    [29401] = { icon = '/esoui/art/icons/ability_1handed_005.dds'; tooltip = Tooltips.Generic_Disorient }; -- Power Bash (Guard)
    [29402] = { icon = '/esoui/art/icons/ability_1handed_005.dds'; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Power Bash (Guard)
    [29761] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds'; duration = 0; tooltip = Tooltips.Skill_Block_NPC; toggle = true }; -- Brace (Guard)
    [29762] = { hide = true }; -- Blocked Stack (Guard)
    [29757] = { hide = true }; -- Remove block (Guard)
    [84351] = { hide = true }; -- Remove block (Guard)
    [29766] = { hide = true }; -- Blocked Stack (Guard)
    [29765] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Block, Abilities.Innate_Stun); hide = true; tooltip = Tooltips.Generic_Stagger }; -- Uber Attack (Guard)
    [29767] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Block, Abilities.Innate_Stun); tooltip = Tooltips.Generic_Stun }; -- Uber Attack (Guard)
    [84346] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Block, Abilities.Innate_Stun); tooltip = Tooltips.Generic_Stun }; -- Uber Attack (Guard)

    -- Brute (1H + Shield)
    [34919] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 60 }; -- Low Slash (Brute)
    [13701] = { icon = '/esoui/art/icons/ability_warrior_011.dds'; name = Abilities.Skill_Shield_Rush }; -- Focused Charge (Brute)
    [48542] = { hide = true }; -- Focused Charge (Brute)
    [14924] = { hide = true }; -- Focused Charge (Brute)
    [14925] = { icon = '/esoui/art/icons/ability_warrior_011.dds'; name = Abilities.Skill_Shield_Rush }; -- Charge (Brute)
    [14926] = { icon = '/esoui/art/icons/ability_warrior_011.dds'; name = Abilities.Skill_Shield_Rush; tooltip = Tooltips.Generic_Knockdown }; -- Charge (Brute)

    -- Ravager (2H)
    [29379] = { icon = '/esoui/art/icons/ability_2handed_001.dds'; tooltip = Tooltips.Generic_Knockback; cc = LUIE_CC_TYPE_KNOCKBACK }; -- Uppercut (Ravager)
    [29380] = { icon = '/esoui/art/icons/ability_2handed_001.dds'; hide = true; cc = LUIE_CC_TYPE_KNOCKBACK }; -- Uppercut (Ravager)

    -- Skirmisher (DW)
    [29035] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds' }; -- Quick Strike (Rogue/Skirmisher)
    [28408] = { icon = '/esoui/art/icons/ability_dualwield_005.dds' }; -- Whirlwind (Rogue/Skirmisher)
    [12381] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_assassinate.dds' }; -- Assassinate (Rogue/Skirmisher)
    [35164] = { hide = true }; -- Agony (Pointless projectile travel time aura)

    -- Berserker (Dual Wield)
    [76328] = { tooltip = Tooltips.Skill_Agony }; -- Agony (Berserker)
    [35165] = { tooltip = Tooltips.Generic_Magic; tooltipValue2 = 1 }; -- Agony (Berserker)
    [10735] = { icon = '/esoui/art/icons/ability_dualwield_001_b.dds' }; -- Blood Craze (Berserker)
    [49252] = { icon = '/esoui/art/icons/ability_dualwield_001_b.dds' }; -- Blood Craze (Berserker)
    [49253] = { icon = '/esoui/art/icons/ability_dualwield_001_b.dds'; tooltip = Tooltips.Skill_Blood_Craze_Heal }; -- Blood Craze (Berserker)
    [49254] = { icon = '/esoui/art/icons/ability_dualwield_001_b.dds'; tooltip = Tooltips.Skill_Blood_Craze }; -- Blood Craze (Berserker)

    -- Dragonknight (NPC)
    [34742] = { icon = '/esoui/art/icons/ability_dragonknight_004.dds' }; -- Fiery Breath (Dragonknight)
    [34647] = { icon = '/esoui/art/icons/ability_debuff_offbalance.dds'; name = Abilities.Skill_Off_Balance; tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Lava Whip (Dragonknight)
    [74472] = { icon = '/esoui/art/icons/ability_dragonknight_010.dds' }; -- Dark Talons (Dragonknight)
    [34706] = { tooltip = Tooltips.Generic_Immobilize }; -- Dark Talons (Dragonknight)
    [44227] = { icon = '/esoui/art/icons/ability_dragonknight_006.dds' }; -- Dragonknight Standard (Dragonknight - Elite)
    [44228] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Dragonknight Standard (Dragonknight - Elite)
    [52041] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blink_strike.dds' }; -- Blink Strike (Dragonknight  - Elite)
    [52051] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blink_strike.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Blink Strike (Dragonknight  - Elite)
    [136500] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blink_strike.dds' }; -- Blink Strike (Dragonknight  - Elite)

    -- Thundermaul
    [29510] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_thunder_hammer.dds' }; -- Thunder Hammer (Thundermaul)
    [29511] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_thunder_hammer.dds' }; -- Thunder Hammer (Thundermaul)
    [17867] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_shock_aura.dds' }; -- Shock Aura (Thundermaul)
    [44407] = { tooltip = Tooltips.Skill_Lightning_Form }; -- Lightning Form (Thundermaul)
    [44408] = { icon = '/esoui/art/icons/ability_sorcerer_lightning_form.dds' }; -- Lightning Form (Thundermaul -- Boss)
    [81219] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_large.dds'; hide = true }; -- Shock (Thundermaul -- Boss)
    [81215] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_shock_aura.dds'; name = Abilities.Skill_Shock_Blast }; -- Shock Aura (Thundermaul -- Boss)
    [77906] = { icon = '/esoui/art/icons/ability_debuff_knockback.dds'; name = Abilities.Skill_Knockback; tooltip = Tooltips.Generic_Knockback }; -- Stun (Thundermaul -- Boss)
    [81193] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_agonizing_strike.dds'; hide = true }; -- Agonizing Strike (Thundermaul -- Boss)
    [81195] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_snare.dds' }; -- Agonizing Fury (Thundermaul -- Boss)
    [81196] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_snare.dds'; displayStacks = true; maxStacks = 5; stack = 1; tooltip = Tooltips.Skill_Agonizing_Fury }; -- Agonizing Fury (Thundermaul -- Boss)
    [81197] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_snare.dds' }; -- Agonizing Fury (Thundermaul -- Boss)
    [81217] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_thunder_hammer.dds' }; -- Thunder Hammer (Thundermaul -- Boss)
    [81218] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_thunder_hammer.dds' }; -- Thunder Hammer (Thundermaul -- Boss)

    -- Nightblade (NPC)
    [73712] = { hide = true }; -- Shadow Cloak (Nightblade NPC)
    [73713] = { icon = '/esoui/art/icons/ability_nightblade_004.dds'; tooltip = Tooltips.Generic_Invisibility }; -- Shadow Cloak (Nightblade)
    [36471] = { icon = '/esoui/art/icons/ability_nightblade_002.dds'; tooltip = Tooltips.Generic_Stun }; -- Veiled Strike (Nightblade)

    [137148] = { icon = '/esoui/art/icons/ability_nightblade_002.dds'; hide = true }; -- Veiled Strike (Nightblade)
    [137152] = { icon = '/esoui/art/icons/ability_nightblade_002.dds'; tooltip = Tooltips.Generic_Stun }; -- Veiled Strike (Nightblade)
    [138382] = { hide = true }; -- Shadow Cloak (Nightblade NPC)
    [137150] = { hide = true }; -- Shadow Cloak (Nightblade)

    [63822] = { icon = '/esoui/art/icons/ability_nightblade_008.dds'; tooltip = Tooltips.Generic_Stun }; -- Teleport Strike (Nightblade)
    [44345] = { icon = '/esoui/art/icons/ability_nightblade_018_a.dds'; hide = true }; -- Soul Tether (Nightblade - Elite)
    [44349] = { icon = '/esoui/art/icons/ability_nightblade_018_a.dds' }; -- Soul Tether (Nightblade - Elite)
    [44352] = { icon = '/esoui/art/icons/ability_nightblade_018_a.dds'; hideReduce = true; tooltip = Tooltips.Skill_Soul_Tether_NPC }; -- Soul Tether (Nightblade - Elite)
    [44350] = { icon = '/esoui/art/icons/ability_nightblade_018_a.dds'; tooltip = Tooltips.Skill_Soul_Tether_NPC }; -- Soul Tether (Nightblade - Elite)

    -- Archer
    [37108] = { icon = '/esoui/art/icons/ability_bow_005.dds' }; -- Arrow Spray (Archer)
    [37109] = { icon = '/esoui/art/icons/ability_bow_005.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 75 }; -- Arrow Spray (Archer)
    [28628] = { icon = '/esoui/art/icons/ability_bow_003.dds' }; -- Volley (Archer)
    [28629] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 0.5 }; -- Volley (Archer)
    [74978] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_taking_aim.dds'; hide = true }; -- Taking Aim (Archer)
    [74980] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_taking_aim.dds' }; -- Taking Aim (Archer)

    -- Pet Ranger
    [89460] = { hide = true }; -- Set Area (Pet Ranger)
    [36499] = { hide = true }; -- Roll Dodge (Pet Ranger)
    [44301] = { icon = '/esoui/art/icons/ability_fightersguild_004_b.dds'; name = Abilities.Skill_Lightweight_Beast_Trap }; -- Trap Beast (Pet Ranger)
    [44305] = { icon = '/esoui/art/icons/ability_fightersguild_004_b.dds'; name = Abilities.Skill_Lightweight_Beast_Trap; tooltip = Tooltips.Generic_Immobilize }; -- Trap Beast (Pet Ranger)
    [44307] = { icon = '/esoui/art/icons/ability_fightersguild_004_b.dds'; name = Abilities.Skill_Lightweight_Beast_Trap }; -- Trap Beast (Pet Ranger)
    [88251] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_wolf.dds'; tooltip = Tooltips.Skill_Call_Ally }; -- Call Ally (Pet Ranger)
    [88248] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_durzog.dds'; tooltip = Tooltips.Skill_Call_Ally }; -- Call Ally (Pet Ranger)
    [89425] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_ally_kwama.dds'; tooltip = Tooltips.Skill_Call_Ally }; -- Call Ally (Pet Ranger)
    [88288] = { hide = true }; -- Call Ally (Pet Ranger)
    [88281] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; name = Abilities.Skill_Weakness; duration = -120; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Weakness_NPC_Summon }; -- Call Ally (Pet Ranger)
    [88227] = { hide = true }; -- Call Ally (Pet Ranger)
    [88252] = { hide = true }; -- Call Ally (Pet Ranger)

    -- Fire Mage
    [15164] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_heat_wave.dds' }; -- Heat Wave (Fire Mage)
    [16588] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_heat_wave.dds'; hide = true }; -- Heat Wave (Fire Mage)
    [47095] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_rune.dds' }; -- Fire Rune (Fire Mage)
    [47102] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_rune.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.9 }; -- Fire Rune (Fire Mage)

    -- Storm Mage
    [14524] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_large.dds'; hide = true }; -- Shock (Storm Mage)
    [29471] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunder_thrall.dds' }; -- Thunder Thrall (Storm Mage)
    [29470] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunder_thrall.dds' }; -- Thunder Thrall (Storm Mage)
    [29472] = { hide = true }; -- Thunder Thrall (Storm Mage) (self snare shows as buff)

    -- Frost Mage
    [12459] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_winters_reach.dds' }; -- Winter's Reach (Frost Mage)
    [12460] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_winters_reach.dds' }; -- Winter's Reach (Frost Mage)
    [14550] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_winters_reach.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Winter's Reach (Frost Mage)
    [14194] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_barrier.dds'; tooltip = Tooltips.Skill_Ice_Barrier }; -- Ice Barrier (Frost Mage)
    [7145] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 20 }; -- Ice Barrier (Frost Mage)

    -- Spirit Mage
    [35151] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_spell_absorption.dds'; tooltip = Tooltips.Skill_Spell_Absorption }; -- Spell Absorption (Spirit Mage)
    [14472] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burdening_eye.dds'; tooltip = Tooltips.Skill_Burdening_Eye }; -- Burdening Eye (Spirit Mage)
    [37200] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burdening_eye.dds' }; -- Burden (Spirit Mage)
    [35142] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burdening_eye.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 80 }; -- Burden (Spirit Mage)
    [89057] = { hide = true }; -- Burdening Eye (Spirit Mage)
    [89042] = { hide = true }; -- Burdening Eye (Spirit Mage)
    [14477] = { hide = true }; -- Burdening (Spirit Mage)
    [35149] = { hide = true }; -- Burdening Eye (Spirit Mage)

    -- Battlemage
    [37150] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Flare (Battlemage)
    [37028] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_strike.dds'; name = Abilities.Skill_Staff_Strike }; -- Quick Strike (Battlemage)
    [37029] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_strike.dds'; name = Abilities.Skill_Staff_Strike }; -- Quick Strike (Battlemage)
    [37030] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_strike.dds'; name = Abilities.Skill_Staff_Strike }; -- Quick Strike (Battlemage)
    [37021] = { hide = true }; -- Empower Weapon: Flame (Battlemage)
    [37087] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_onslaught.dds' }; -- Lightning Onslaught (Battlemage)
    [37156] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_onslaught.dds' }; -- Lightning Onslaught (Battlemage)
    [37129] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_cage.dds' }; -- Ice Cage (Battlemage)
    [37131] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_cage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 0.7; tooltipValue3 = 60 }; -- Ice Cage (Battlemage)
    [37132] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_cage.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 0.7; tooltipValue3 = 60; hideGround = true }; -- Ice Cage (Battlemage)
    [44216] = { icon = '/esoui/art/icons/ability_sorcerer_monsoon.dds' }; -- Negate Magic (Battlemage)
    [50108] = { icon = '/esoui/art/icons/ability_sorcerer_monsoon.dds'; duration = 0; tooltip = Tooltips.Generic_Silence_No_Dur; groundLabel = true }; -- Negate Magic (Battlemage)
    [50107] = { icon = '/esoui/art/icons/ability_sorcerer_monsoon.dds'; duration = 0; tooltip = Tooltips.Generic_Stun_No_Dur; groundLabel = true }; -- Negate Magic (Battlemage)

    -- Time Bomb Mage
    [37126] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_flare.dds' }; -- Entropic Flare (Timb Bomb Mage)
    [36985] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_void.dds'; name = Abilities.Skill_Void_Burst }; -- Void (Time Bomb Mage)
    [36987] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_void.dds'; hide = true }; -- Void Burst (Time Bomb Mage)
    [36986] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_void.dds'; name = Abilities.Skill_Void_Burst; hide = true }; -- Void (Time Bomb Mage)

    -- Fear Mage
    [56828] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fright_force.dds'; hide = true }; -- Fright Force (Fear Mage)
    [14350] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aspect_of_terror.dds'; hide = true }; -- Aspect of Terror (Fear Mage)
    [37084] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aspect_of_terror.dds'; tooltip = Tooltips.Generic_Fear }; -- Aspect of Terror (Fear Mage)
    [35865] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vanish.dds'; name = Abilities.Skill_Vanish; tooltip = Tooltips.Generic_Disorient }; -- Shadow Cloak (Fear Mage)

    -- Dreadweaver
    [44247] = { hide = true }; -- Dark Shade (Dreadweaver)
    [89005] = { hide = true }; -- Dark Shade (Dreadweaver)
    [89006] = { hide = true }; -- Dark Shade (Dreadweaver)
    [89008] = { hide = true }; -- Dark Shade (Dreadweaver)
    [39729] = { hide = true }; -- TargetPriorityException (Dreadweaver)
    [44250] = { hide = true; icon = '/esoui/art/icons/ability_nightblade_001.dds'; name = Abilities.Skill_Summon_Shade }; -- Dark Shade (Dreadweaver)
    [89017] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; name = Abilities.Skill_Weakness; duration = -23; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Weakness_NPC_Summon }; -- Dark Shade (Dreadweaver)
    [89010] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds'; name = Abilities.Skill_Corrosive_Strike }; -- Corrode (Dreadweaver)

    -- Soulbrander
    [44323] = { icon = '/esoui/art/icons/ability_armor_003_a.dds'; tooltip = Tooltips.Skill_Dampen_Magic }; -- Dampen Magic (Soulbrander)
    [44258] = { icon = '/esoui/art/icons/ability_mageguild_002.dds'; name = Abilities.Skill_Magelight; tooltip = Tooltips.Skill_Radiant_Magelight_NPC; toggle = true }; -- Radiant Magelight (Soulbrander)
    [44263] = { hide = true }; -- Radiant Magelight (Soulbrander)
    [44259] = { icon = '/esoui/art/icons/ability_mageguild_002.dds'; hide = true }; -- Magelight (Soulbrander)

    -- Necromancer
    [29372] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds'; hide = true }; -- Necrotic Spear (Necromancer)
    [88554] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_zombie.dds'; tooltip = Tooltips.Skill_Summon_the_Dead }; -- Summon the Dead (Necromancer)
    [88555] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_zombie.dds'; tooltip = Tooltips.Skill_Summon_the_Dead }; -- Summon the Dead (Necromancer)
    [88556] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_zombie.dds'; tooltip = Tooltips.Skill_Summon_the_Dead }; -- Summon the Dead (Necromancer)
    [88561] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; name = Abilities.Skill_Weakness; duration = -120; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Weakness_NPC_Summon }; -- Summon the Dead (Necromancer)
    [13397] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_empower_atronach.dds' }; -- Empower Undead (Necromancer)
    [31848] = { hide = true }; -- Summon the Dead (Necromancer)
    [88582] = { hide = true }; -- Summon the Dead (Necromancer)
    [88583] = { hide = true }; -- Summon the Dead (Necromancer)
    [88599] = { hide = true }; -- Summon the Dead (Necromancer)
    [88590] = { hide = true }; -- Summon the Dead (Necromancer)
    [88591] = { hide = true }; -- Summon the Dead (Necromancer)
    [88592] = { hide = true }; -- Summon the Dead (Necromancer)
    [88586] = { hide = true }; -- Summon the Dead (Necromancer)
    [88589] = { hide = true }; -- Summon the Dead (Necromancer)
    [88600] = { hide = true }; -- Summon the Dead (Necromancer)
    [88602] = { hide = true }; -- Summon the Dead (Necromancer)
    [88618] = { hide = true }; -- Summon the Dead (Necromancer)
    [88611] = { hide = true }; -- Summon the Dead (Necromancer)
    [88607] = { hide = true }; -- Summon the Dead (Necromancer)
    [88613] = { hide = true }; -- Summon the Dead (Necromancer)
    [88621] = { hide = true }; -- Summon the Dead (Necromancer)
    [88615] = { hide = true }; -- Summon the Dead (Necromancer)
    [88610] = { hide = true }; -- Summon the Dead (Necromancer)
    [88608] = { hide = true }; -- Summon the Dead (Necromancer)
    [88614] = { hide = true }; -- Summon the Dead (Necromancer)
    [88622] = { hide = true }; -- Summon the Dead (Necromancer)
    [88616] = { hide = true }; -- Summon the Dead (Necromancer)
    [88626] = { hide = true }; -- Summon the Dead (Necromancer)
    [88627] = { hide = true }; -- Summon the Dead (Necromancer)
    [88601] = { hide = true }; -- Summon the Dead (Necromancer)
    [88593] = { hide = true }; -- Summon the Dead (Necromancer)
    [88617] = { hide = true }; -- Summon the Dead (Necromancer)
    [88594] = { hide = true }; -- Summon the Dead (Necromancer)
    [88595] = { hide = true }; -- Summon the Dead (Necromancer)
    [88596] = { hide = true }; -- Summon the Dead (Necromancer)
    [88612] = { hide = true }; -- Summon the Dead (Necromancer)
    [88566] = { hide = true }; -- Summon the Dead (Necromancer)
    [88597] = { hide = true }; -- Summon the Dead (Necromancer)
    [88598] = { hide = true }; -- Summon the Dead (Necromancer)

    -- Bonelord
    [7590] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_bolt.dds' }; -- Entropic Bolt (Bonelord)
    [35387] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds' }; -- Bone Cage (Bonelord)
    [88322] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds' }; -- Bone Cage (Bonelord)
    [35391] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds'; name = Abilities.Skill_Bone_Cage; tooltip = Tooltips.Generic_Immobilize }; -- Defiled Grave (Bonelord)
    [88504] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; name = Abilities.Skill_Weakness; duration = -120; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Summon Abomination (Bonelord)
    [88506] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_flesh_atronach.dds' }; -- Summon Abomination (Bonelord)
    [88507] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_flesh_atronach.dds' }; -- Summon Abomination (Bonelord)
    [44339] = { icon = '/esoui/art/icons/ability_undaunted_005a.dds' }; -- Bone Surge (Bonelord)
    [10601] = { icon = '/esoui/art/icons/ability_templar_sun_fire.dds'; name = Abilities.Skill_Sun_Fire; hide = true }; -- Minor Wound (Healer)
    [57534] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_focused_healing.dds'; hide = true }; -- Focused Healing (Healer)
    [57537] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_focused_healing.dds' }; -- Focused Healing (Healer)
    [57538] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_focused_healing.dds' }; -- Focused Healing (Healer)
    [50966] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_defensive_ward.dds'; name = Abilities.Skill_Defensive_Ward; tooltip = Tooltips.Skill_Defensive_Ward }; -- Healer Immune (Healer)
    [50931] = { hide = true }; -- Healer Immune (Healer)
    [50975] = { hide = true }; -- Healer Immune (Healer)
    [50998] = { hide = true }; -- Rite of Passage (Healer)
    [44328] = { icon = '/esoui/art/icons/ability_templar_rite_of_passage.dds'; hide = true }; -- Rite of Passage (Healer)
    [44329] = { icon = '/esoui/art/icons/ability_templar_rite_of_passage.dds'; duration = 0; tooltip = Tooltips.Skill_Rite_of_Passage_NPC }; -- Rite of Passage (Healer)
    [29669] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_coiled_lash.dds'; hide = true }; -- Coiled Lash (Shaman)
    [29520] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aura_of_protection.dds'; tooltip = Tooltips.Skill_Aura_of_Protection }; -- Aura of Protection (Shaman)
    [29521] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aura_of_protection.dds'; tooltip = Tooltips.Skill_Aura_of_Protection_Other }; -- Aura of Protection (Shaman)
    [29597] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Generic_Stun }; -- Combustion (Shaman)
    [29598] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Shaman)
    [65314] = { hide = true }; -- Aura of Protection (Shaman)
    [65432] = { hide = true }; -- Aura of Protection (Shaman)
    [83073] = { hide = true }; -- Summon Died (Shaman)
    [68866] = { icon = '/esoui/art/icons/ability_ava_003.dds'; tooltip = Tooltips.Skill_War_Horn_NPC }; -- Warhorn (Faction NPCs)
    [68867] = { hide = true }; -- War Horn Battlecry (Faction NPC)
    [68868] = { hide = true }; -- War Horn Battlecry (Faction NPC)
    [68869] = { hide = true }; -- War Horn Battlecry (Faction NPC)
    [43644] = { hide = true; icon = '/esoui/art/icons/ability_ava_001.dds'; name = Abilities.Skill_Caltrops }; -- Barrier[monster synergy]  (Faction NPCs)
    [43645] = { hide = true; icon = '/esoui/art/icons/ability_ava_001.dds'; name = Abilities.Skill_Caltrops }; -- Barrier[monster synergy]  (Faction NPCs)
    [43646] = { hide = true; icon = '/esoui/art/icons/ability_ava_001.dds'; name = Abilities.Skill_Caltrops }; -- Barrier[monster synergy]  (Faction NPCs)
    [38119] = { icon = '/esoui/art/icons/ability_ava_001.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Physical; tooltipValue2 = 0.5; tooltipValue3 = 60; hideGround = true }; -- Caltrops  (Faction NPCs)
    [38125] = { icon = '/esoui/art/icons/ability_ava_001.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Physical; tooltipValue2 = 0.5; tooltipValue3 = 60 }; -- Caltrops  (Faction NPCs)
    [65033] = { icon = '/esoui/art/icons/ability_warrior_014.dds'; hide = true }; -- Retaliation (Winterborn Warrior)
    [69158] = { icon = '/esoui/art/icons/ability_warrior_014.dds'; tooltip = Tooltips.Skill_Retaliation_NPC }; -- Retaliation (Winterborn Warrior)
    [67114] = { icon = '/esoui/art/icons/ability_warrior_014.dds' }; -- Retaliation (Winterborn Warrior)
    [69157] = { icon = '/esoui/art/icons/ability_warrior_014.dds'; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Retaliation (Winterborn Warrior)
    [69153] = { icon = '/esoui/art/icons/ability_warrior_014.dds'; tooltip = Tooltips.Generic_Stun }; -- Retaliation (Winterborn Warrior)
    [1347] = { icon = '/esoui/art/icons/ability_debuff_offbalance.dds'; name = Abilities.Skill_Off_Balance; tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off-Balance (Winterborn Warrior)
    [70070] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds'; name = Abilities.Skill_Heavy_Attack }; -- Heavy Strike (Winterborn Warrior)
    [64980] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_javelin.dds'; hide = true }; -- Javelin (Winterborn Warrior)
    [14883] = { hide = true }; -- Off-Balance (Winterborn Warrior)
    [69282] = { hide = true }; -- Roll Dodge Back (Winterborn Warrior)
    [54593] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Flare (Winterborn Mage)
    [55909] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grasping_vines.dds' }; -- Grasping Vines (Winterborn Mage)
    [55911] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grasping_vines.dds'; hideReduce = true; tooltip = Tooltips.Skill_Grasping_Vines }; -- Grasping Vines (Winterborn Mage)
    [55918] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grasping_vines.dds'; tooltip = Tooltips.Skill_Grasping_Vines }; -- Grasping Vines (Winterborn Mage)
    [55916] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grasping_vineburst.dds' }; -- Grasping Vineburst (Winterborn Mage)
    [64704] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flames.dds'; hide = true }; -- Flames (Winterborn Mage)
    [64711] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flames.dds'; hide = true }; -- Flames (Winterborn Mage)
    [54184] = { hide = true }; -- Revenge 2 (Vosh Rakh Devoted)
    [54397] = { hide = true }; -- Rally (Vosh Rakh Devoted)
    [53987] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_inspire.dds'; name = Abilities.Skill_Inspire; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 5 }; -- Rally (Vosh Rakh Devoted)
    [65235] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; tooltip = Tooltips.Skill_Enrage_Devoted }; -- Enrage (Vosh Rakh Devoted)
    [54027] = { icon = '/esoui/art/icons/ability_warrior_032.dds' }; -- Divine Leap (Vosh Rakh Devoted)
    [67272] = { hide = true }; -- Invisible No Target (Vosh Rakh Devoted)
    [54028] = { icon = '/esoui/art/icons/ability_warrior_032.dds' }; -- Divine Leap (Vosh Rakh Devoted)
    [67593] = { icon = '/esoui/art/icons/ability_warrior_032.dds'; name = Abilities.Skill_Divine_Leap; hide = true }; -- Divine Leap Stagger (Vosh Rakh Devoted)
    [54050] = { icon = '/esoui/art/icons/ability_warrior_032.dds'; name = Abilities.Skill_Divine_Leap; hide = true; tooltip = Tooltips.Generic_Stun }; -- Divine Leap Stun (Vosh Rakh Devoted)

    -- Dremora Caitiff (Craglorn)
    [51000] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_cleave_stance.dds'; tooltip = Tooltips.Skill_Cleave_Stance }; -- Cleave Stance (Dremora Caitiff)
    [51923] = { icon = '/esoui/art/icons/ability_2handed_002.dds'; name = Abilities.Skill_Cleave }; -- Cleave Stance (Dremora Caitiff)
    [51940] = { icon = '/esoui/art/icons/ability_2handed_002.dds'; name = Abilities.Skill_Cleave }; -- Cleave Stance (Dremora Caitiff)
    [51942] = { icon = '/esoui/art/icons/ability_2handed_002.dds'; name = Abilities.Skill_Cleave }; -- Cleave Stance (Dremora Caitiff)

    -- Sentinel (TG DLC)
    [74487] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 60 }; -- Low Slash (Sentinel) (TG DLC)
    [74480] = { icon = '/esoui/art/icons/ability_dragonknight_005.dds'; hide = true }; -- Fiery Grip (Sentinel) (TG DLC)
    [74483] = { icon = '/esoui/art/icons/ability_dragonknight_005.dds'; tooltip = Tooltips.Generic_Stun }; -- Fiery Grip (Sentinel) (TG DLC)
    [72725] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 25 }; -- Fool Me Once (Sentinel) (TG DLC)
    [72723] = { hide = true }; -- Fool Me Once (Sentinel) (TG DLC)
    [77468] = { hide = true }; -- Fool Me Once (Sentinel) (TG DLC)

    -- Archer (TG DLC)
    [74630] = { hide = true }; -- Flare Trap Proxy (Archer) (TG DLC)
    [72716] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_uncanny_dodge.dds'; tooltip = Tooltips.Skill_Uncanny_Dodge }; -- Uncanny Dodge (Archer) (TG DLC)
    [72719] = { hide = true }; -- Uncanny Dodge SUC REM (Archer) (TG DLC)
    [72214] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_poisoned_arrow.dds' }; -- Poisoned Arrow (Archer) (TG DLC)
    [72217] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_poisoned_arrow.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Poisoned Arrow (Archer) (TG DLC)
    [72222] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds'; name = Abilities.Skill_Hide_in_Shadows; tooltip = Tooltips.Generic_Invisibility }; -- Shadow Cloak (Archer) (TG DLC)
    [76089] = { icon = '/esoui/art/icons/ability_bow_001.dds'; hide = true }; -- Snipe (Archer) (TG DLC)
    [72220] = { icon = '/esoui/art/icons/ability_bow_001.dds'; hide = true }; -- Snipe (Archer) (TG DLC)
    [74619] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flare_blue.dds'; hide = true }; -- Flare Trap (Archer) (TG DLC)
    [74621] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Reveal }; -- Revealed (Archer) (TG DLC)
    [74618] = { hide = true }; -- Flare Trap
    [74627] = { hide = true }; -- Flare Trap
    [74620] = { hide = true }; -- Flare Trap REM

    -- Bodyguard (DB DLC)
    [77472] = { icon = '/esoui/art/icons/ability_warrior_030.dds'; tooltip = Tooltips.Skill_Til_Death }; -- 'Til Death (Bodyguard) (DB DLC)
    [79523] = { icon = '/esoui/art/icons/ability_warrior_030.dds'; tooltip = Tooltips.Skill_Til_Death_Self }; -- 'Til Death (Bodyguard) (DB DLC)
    [77554] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds'; hide = true }; -- Shard Shield (Bodyguard) (DB DLC)
    [77555] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds'; duration = 863700; tooltip = Tooltips.Skill_Shard_Shield }; -- Shard Shield (Bodyguard) (DB DLC)
    [77473] = { icon = '/esoui/art/icons/ability_1handed_003.dds' }; -- Shield Charge (Bodyguard) (DB DLC)
    [77815] = { icon = '/esoui/art/icons/ability_1handed_003.dds' }; -- Shield Charge (Bodyguard) (DB DLC)
    [77927] = { name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Staggered (Bodyguard) (DB DLC)
    [77748] = { hide = true }; -- 'Til Death (Bodyguard) (DB DLC)
    [77778] = { hide = true }; -- 'Til Death (Bodyguard) (DB DLC)
    [77765] = { hide = true }; -- 'Til Death (Bodyguard) (DB DLC)
    [77750] = { hide = true }; -- 'Til Death (Bodyguard) (DB DLC)
    [77838] = { hide = true }; -- Shield Charge (Bodyguard) (DB DLC)
    [77672] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds'; name = Abilities.Skill_Recover; tooltip = Tooltips.Generic_Immunity }; -- 'Til Death (Bodyguard) (DB DLC)
    [77742] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds'; name = Abilities.Skill_Recover; tooltip = Tooltips.Generic_Immunity }; -- 'Til Death (Bodyguard) (DB DLC)

    -- Cyrodiil
    [47717] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds' }; -- Quick Strike (Cyrodiil Guard T1)
    [46221] = { tooltip = Tooltips.Generic_Increase_Damage_Taken; tooltipValue2 = 30 }; -- Puncture (Cyrodiil Guard T1 & T2)
    [46830] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_bleed.dds' }; -- Bleeding Strike (Cyrodiil Guard T2)
    [46832] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_bleed.dds'; name = Abilities.Skill_Bleeding_Strike; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Bleeding (Cyrodiil Guard T2)
    [46831] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_bleed.dds'; name = Abilities.Skill_Bleeding_Strike }; -- Bleeding (Cyrodiil Guard T2)
    [36304] = { tooltip = Tooltips.Skill_Razor_Armor }; -- Razor Armor (Cyrodiil Guard T2)
    [36306] = { hide = true }; -- Razor Armor (Cyrodiil Guard T2)
    [36305] = { name = Abilities.Skill_Razor_Armor }; -- Spike Armor Damage Return (Cyrodiil Guard T2)
    [7880] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_torrent.dds'; name = Abilities.Skill_Shock_Torrent; hide = true }; -- Light Attack (Cyrodiil Mage T1)
    [46336] = { name = Abilities.Skill_Crystal_Shard; tooltip = Tooltips.Generic_Stun }; -- Crystal Shard Stun (Cyrodiil Mage T1)
    [7883] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_guardian_storm.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Guardian Storm
    [21629] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_essence_siphon.dds'; name = Abilities.Skill_Essence_Siphon }; -- Mage's Lifesteal (Cyrodiil Mage T1)
    [46711] = { hide = true }; -- Bound Aegis (Cyrodiil Mage T2)
    [46726] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_torrent.dds'; name = Abilities.Skill_Improved_Shock_Torrent; hide = true }; -- Shock Torrent (Cyrodiil Mage T2)
    [46730] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_torrent.dds'; name = Abilities.Skill_Improved_Shock_Torrent; tooltip = Tooltips.Generic_Shock; tooltipValue2 = 1 }; -- Shock Torrent (Cyrodiil Mage T2)
    [46819] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_guardian_storm.dds'; name = Abilities.Skill_Lasting_Storm; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Storm Damage (Cyrodiil Mage T2)
    [46704] = { icon = '/esoui/art/icons/ability_sorcerer_thunder_burst.dds' }; -- Crystal Blast (Cyrodiil Mage T2)
    [46705] = { icon = '/esoui/art/icons/ability_sorcerer_thunder_burst.dds' }; -- Crystal Blast (Cyrodiil Mage T2)
    [46706] = { icon = '/esoui/art/icons/ability_sorcerer_thunder_burst.dds'; name = Abilities.Skill_Crystal_Blast; tooltip = Tooltips.Generic_Knockdown }; -- Crystal Shard Stun (Cyrodiil Mage T2)
    [46716] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_essence_siphon.dds'; name = Abilities.Skill_Essence_Siphon }; -- Stolen Essence (Cyrodiil Mage T2)
    [46719] = { hide = true }; -- Stolen Essence (Cryodiil Mage T2) (Pointless aura)
    [52806] = { tooltip = Tooltips.Skill_Unstable_Core_Cyrodiil }; -- Unstable Core (Cyrodiil Mage T2)
    [75397] = { hide = true }; -- Unstable Core (Cryodiil Mage T2) (Pointless aura)
    [75395] = { hide = true }; -- Reflected FX (Cryodiil Mage T2) (Pointless aura)
    [57962] = { icon = '/esoui/art/icons/ability_templar_sun_fire.dds'; name = Abilities.Skill_Sun_Fire; hide = true }; -- Minor Wound (Cyrodiil Mender T1)
    [46272] = { duration = 0; groundLabel = true; tooltip = Tooltips.Skill_Rune_Focus_Cyrodiil }; -- Rune Focus (Cyrodiil Mender T1)
    [21638] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_telekinetic_disorient.dds'; name = Abilities.Skill_Telekinetic_Prison; tooltip = Tooltips.Generic_Disorient }; -- Telekinetic Disorient (Cyrodiil Mender T1)
    [46839] = { icon = '/esoui/art/icons/ability_templar_sun_fire.dds'; name = Abilities.Skill_Sun_Fire; hide = true }; -- Major Wound (Cyrodiil Mender T2)
    [46904] = { icon = '/esoui/art/icons/ability_templar_rune_focus.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Skill_Rune_Focus_Cyrodiil }; -- Rune Focus (Cyrodiil Mender T2)
    [46906] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_telekinetic_disorient.dds'; name = Abilities.Skill_Shattering_Prison; tooltip = Tooltips.Skill_Shattering_Prison_Cyrodiil }; -- Telekinetic Disorient (Cyrodiil Mender T2)
    [46910] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_telekinetic_disorient.dds' }; -- Shattering Prison (Cyrodiil Mender T2)
    [52862] = { hide = true }; -- Health Boon (Cyrodiil Mender T2)
    [22469] = { hide = true }; -- Siege Shield (Cyrodiil Mender T1 + T2)
    [22489] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_siege_bubble.dds'; name = Abilities.Skill_Siege_Barrier; tooltip = Tooltips.Skill_Siege_Shield_Cyrodiil }; -- Siege Bubble (Cyrodiil Mender T1 + T2)
    [51893] = { icon = '/esoui/art/icons/ability_sorcerer_monsoon.dds'; duration = 0; tooltip = Tooltips.Generic_Stun_No_Dur; groundLabel = true }; -- Negate Magic (Cyrodiil Mender T1 + T2)
    [51894] = { duration = 0; tooltip = Tooltips.Generic_Silence_No_Dur; groundLabel = true }; -- Negate Magic (Cyrodiil Mender T1 + T2)
    [52864] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quick_shot.dds' }; -- Quick Shot (Cyrodiil Archer T1 + T2)
    [52866] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 0.5 }; -- Volley (Cyrodiil Archer T1)
    [54258] = { name = Abilities.Skill_Improved_Volley; groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 0.5 }; -- Upgraded Volley (Cyrodiil Archer T2)
    [54264] = { icon = '/esoui/art/icons/ability_bow_001_a.dds'; hide = true }; -- Lethal Arrow (Cryodiil Archer T2)
    [54265] = { icon = '/esoui/art/icons/ability_bow_001_a.dds'; tooltip = Tooltips.Generic_Reduce_Healing_Received; tooltipValue2 = 50 }; -- Lethal Arrow (Cryodiil Archer T2)
    [54259] = { icon = '/esoui/art/icons/ability_bow_004_a.dds'; hide = true }; -- Draining Shot (Cryodiil Archer T2)
    [54261] = { icon = '/esoui/art/icons/ability_bow_004_a.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Draining Shot (Cryodiil Archer T2)
    [70414] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage.dds'; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.5; groundLabel = true }; -- Ignite (Synergy - Fire Mage)
    [16510] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_torrent.dds'; name = Abilities.Skill_Fire_Torrent; hide = true }; -- Fire Salvo (Cyrodiil Honor Guard T1)
    [15780] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_honor_guard_rage.dds' }; -- Honor Guard Rage (Cyrodiil Honor Guard T1)
    [32446] = { icon = '/esoui/art/icons/ability_dragonknight_011.dds'; name = Abilities.Skill_Dragon_Blood; tooltip = Tooltips.Generic_Health_Recovery }; -- Guardian Heal (Cyrodiil Honor Guard T1)
    [35113] = { name = Abilities.Skill_Fiery_Grip; hide = true }; -- Extended Chains (Cyrodiil Honor Guard T1)
    [35115] = { name = Abilities.Skill_Fiery_Grip; hide = true; tooltip = Tooltips.Generic_Stun }; -- Pull (Cyrodiil Honor Guard T1)
    [46992] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_honor_guard_rage.dds' }; -- Crippling Rage (Cyrodiil Honor Guard T2)
    [47001] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_snare.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Crippling Rage (Cyrodiil Honor Guard T2)
    [47004] = { icon = '/esoui/art/icons/ability_dragonknight_011.dds'; name = Abilities.Skill_Dragon_Blood; tooltip = Tooltips.Generic_Health_Recovery }; -- Guardian Heal (Cyrodiil Honor Guard T2)
    [47019] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_puncturing_chains.dds'; hide = true }; -- Puncturing Chains (Cyrodiil Honor Guard T2)
    [47023] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_puncturing_chains.dds'; name = Abilities.Skill_Puncturing_Chains; tooltip = Tooltips.Generic_Increase_Damage_Taken; tooltipValue2 = 21.5 }; -- Puncture (Cyrodiil Honor Guard T2)
    [47020] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_puncturing_chains.dds'; name = Abilities.Skill_Puncturing_Chains; hide = true; tooltip = Tooltips.Generic_Stun }; -- Pull (Cyrodiil Honor Guard T2)
    [15783] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_triple_strike.dds' }; -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [15782] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_triple_strike.dds' }; -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [46990] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_torrent.dds'; hide = true }; -- Improved Fire Torrent (Cyrodiil Honor Guard T2)
    [46991] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_torrent.dds'; name = Abilities.Skill_Improved_Fire_Torrent; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1 }; -- Fire Torrent Burning (Cryodiil Honor Guard T2)

    -- Animals
    [5451] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_bite.dds' }; -- Bite (Alit)
    [5452] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }; -- Lacerate (Alit)
    [84356] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }; -- Lacerate (Alit)
    [56984] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds'; name = Abilities.Skill_Lacerate; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Laceration (Alit)
    [56983] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds'; name = Abilities.Skill_Lacerate }; -- Laceration (Alit)
    [4413] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds'; name = Abilities.Skill_Bite }; -- Swipe (Bear)
    [4415] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }; -- Crushing Swipe (Bear)
    [38772] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }; -- Crushing Swipe (Bear)
    [18273] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Crushing Swipe (Bear)
    [139956] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }; -- Savage Blow (Bear)
    [139957] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }; -- Savage Blow (Bear)
    [139963] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds'; name = Abilities.Skill_Savage_Blow; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Savage Bleeding (Bear)
    [139958] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds'; name = Abilities.Skill_Savage_Blow }; -- Savage Bleeding (Bear)
    [70355] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds' }; -- Bite (Great Bear)
    [70357] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }; -- Lunge (Great Bear)
    [70359] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }; -- Lunge (Great Bear)
    [70366] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }; -- Slam (Great Bear)
    [89189] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }; -- Slam (Great Bear)
    [69073] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds'; name = Abilities.Skill_Slam; tooltip = Tooltips.Generic_Knockdown }; -- Knockdown (Great Bear)
    [70376] = { hide = true }; -- Ferocity (Great Bear)
    [70374] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_ferocity.dds'; tooltip = Tooltips.Generic_Scary_Immunities_Duration }; -- Ferocity (Great Bear)

    -- Crocodile
    [4583] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }; -- Bite (Crocodile)
    [9642] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }; -- Bite (Crocodile)
    [4587] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_crushing_chomp.dds' }; -- Crushing Chomp (Crocodile)
    [4591] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }; -- Sweep (Crocodile)
    [32051] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }; -- Sweep (Crocodile)
    [4594] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_ancient_skin.dds'; tooltip = Tooltips.Skill_Ancient_Skin }; -- Ancient Skin (Crocodile)

    -- Duneripper
    [8971] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }; -- Bite (Duneripper)
    [9643] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }; -- Bite (Duneripper)
    [8972] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_crushing_chomp.dds' }; -- Crushing Chomp (Duneripper)
    [8977] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }; -- Sweep (Duneripper)
    [32461] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }; -- Sweep (Duneripper)

    -- Durzog
    [7214] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }; -- Bite (Durzog)
    [7221] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rend.dds' }; -- Rend (Durzog)
    [7227] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds'; name = Abilities.Skill_Rip_and_Tear }; -- Rotbone (Durzog)
    [16878] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds'; name = Abilities.Skill_Rip_and_Tear; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Rotbone (Durzog)

    -- Dreugh
    [6304] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_swipe.dds' }; -- Swipe (Dreugh)
    [18002] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }; -- Slash (Dreugh)
    [18003] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }; -- Slash (Dreugh)
    [18005] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }; -- Slash (Dreugh)
    [6308] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_touch.dds' }; -- Shocking Touch (Dreugh)
    [6328] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }; -- Shocking Rake (Dreugh)
    [27100] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }; -- Shocking Rake (Dreugh)

    -- Echatere
    [54374] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_tusks.dds' }; -- Tusks (Echatere)
    [54375] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }; -- Shockwave (Echatere)
    [54378] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }; -- Shockwave (Echatere)
    [68971] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Staggered (Echatere - Shockwave)
    [54380] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }; -- Headbutt (Echatere)
    [54382] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }; -- Headbutt (Echatere)
    [54381] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Headbutt (Echatere)

    -- Giant Bat
    [60920] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_scrape.dds' }; -- Scrape (Giant Bat)
    [4632] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }; -- Screech (Giant Bat)
    [47321] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }; -- Screech (Giant Bat)
    [18319] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds'; tooltip = Tooltips.Generic_Stun }; -- Screech (Giant Bat)
    [4630] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_draining_bite.dds'; hide = true }; -- Draining Bite (Giant Bat)

    -- Giant Snake
    [8540] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_strike.dds' }; -- Strike (Giant Snake)
    [5240] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }; -- Lash (Giant Snake)
    [30214] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }; -- Lash (Giant Snake)
    [5242] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds' }; -- Kiss of Poison (Giant Snake)
    [21826] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 0.5 }; -- Kiss of Poison (Giant Snake)
    [5244] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_shed_skin.dds'; tooltip = Tooltips.Generic_HoT_Channel; tooltipValue2 = 0.5 }; -- Shed Skin (Giant Snake)

    -- Guar
    [5440] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_bite.dds' }; -- Bite (Guar)
    [5443] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_headbutt.dds' }; -- Headbutt (Guar)
    [5441] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds' }; -- Dive (Guar)
    [84359] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds' }; -- Dive (Guar)
    [5363] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }; -- Chomp (Kagouti)
    [5926] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }; -- Toss (Kagouti)
    [42889] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }; -- Toss (Kagouti)
    [42888] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds'; hide = true }; -- Toss (Kagouti)
    [18198] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds'; tooltip = Tooltips.Generic_Knockback }; -- Toss (Kagouti)
    [14202] = { hide = true }; -- Charge (Kagouti)
    [14196] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds'; name = Abilities.Skill_Rush; hide = true }; -- Charge (Kagouti)
    [14819] = { hide = true }; -- Charge (Kagouti)
    [14825] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds'; name = Abilities.Skill_Rush }; -- Charge (Kagouti)
    [14828] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds'; name = Abilities.Skill_Rush; tooltip = Tooltips.Generic_Knockdown }; -- Charge (Kagouti)
    [14829] = { hide = true }; -- Charge (Kagouti)
    [18751] = { hide = true }; -- Charge (Kagouti)
    [87310] = { hide = true }; -- Run Away! (Kagouti Whelp)
    [87312] = { hide = true }; -- Run Away! (Kagouti Whelp)
    [87276] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }; -- Chomp (Kagouti Whelp)
    [7170] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }; -- Rend (Lion)
    [60630] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }; -- Rend (Lion)
    [60641] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_claw.dds' }; -- Claw (Lion)
    [7158] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }; -- Bite (Lion)
    [7161] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_double_strike.dds' }; -- Double Strike (Lion)
    [8705] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; tooltip = Tooltips.Skill_Weakness_Lion }; -- Weakness (Lion)
    [8601] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_mammoth_vigorous_swipes.dds'; name = Abilities.Skill_Vigorus_Swipes }; -- Vigorous Swipe (Mammoth)
    [75633] = { hide = true }; -- Vigorous Swipe (Mammoth)
    [75634] = { hide = true }; -- Vigorous Swipes (Mammoth)
    [8596] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_swipe.dds' }; -- Swipe (Mammoth)
    [8604] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_vigorous_swipes.dds'; name = Abilities.Skill_Vigorus_Swipes }; -- Vigorous Swipe (Mammoth)
    [8600] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }; -- Stomp (Mammoth)
    [23164] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }; -- Stomp (Mammoth)
    [23230] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds'; name = Abilities.Skill_Stampede }; -- Charge (Mammoth)
    [48551] = { hide = true }; -- Focused Charge (Mammoth)
    [23222] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds'; name = Abilities.Skill_Stampede }; -- Charge (Mammoth)
    [23227] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds'; name = Abilities.Skill_Stampede; tooltip = Tooltips.Generic_Knockdown }; -- Charge (Mammoth)
    [23225] = { hide = true }; -- Charge (Mammoth) (Pointless aura that does nothing)
    [4192] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_pincer.dds' }; -- Pincer (Mudcrab)
    [4224] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }; -- Double Claw Strike (Mudcrab)
    [4226] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }; -- Double Claw Strike (Mudcrab)
    [4200] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }; -- Unforgiving Claws (Mudcrab)
    [85082] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }; -- Unforgiving Claws (Mudcrab)
    [42841] = { hide = true }; -- Scuttle (Mudcrab)
    [16667] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_slap.dds' }; -- Slap (Netch)
    [16690] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_thrust.dds' }; -- Thrust (Netch)
    [16697] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds' }; -- Poisonbloom (Netch)
    [16698] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 1 }; -- Poisonbloom (Netch)

    -- Nix-Hound
    [7266] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }; -- Strike (Nix-Hound)
    [13416] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }; -- Strike (Nix-Hound)
    [7268] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }; -- Leech (Nix-Hound)
    [12303] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }; -- Leech (Nix-Hound)
    [18344] = { hide = true }; -- Leech (Nix-Hound)
    [7273] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }; -- Dampworm (Nix-Hound)
    [38635] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }; -- Dampworm (Nix-Hound)
    [38640] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 45 }; -- Dampworm (Nix-Hound)

    -- Skeever
    [5362] = { icon = 'LuiExtended/media/icons/abilities/ability_skeever_slam.dds' }; -- Slam (Skeever)
    [21904] = { icon = 'LuiExtended/media/icons/abilities/ability_skeever_rend.dds' }; -- Rend (Skeever)

    -- Wamasu
    [21947] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_bite.dds' }; -- Bite (Wamasu)
    [21949] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }; -- Sweep (Wamasu)
    [46833] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }; -- Sweep (Wamasu)
    [37178] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Sweep (Wamasu)
    [21951] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds'; hide = true }; -- Repulsion Shock (Wamasu)
    [21952] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds' }; -- Repulsion Shock (Wamasu)
    [22045] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_static.dds'; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 20 }; -- Static (Wamasu)
    [21957] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds'; name = Abilities.Skill_Barreling_Charge }; -- Charge (Wamasu)
    [48556] = { hide = true }; -- Focused Charge (Wamasu)
    [21961] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds'; name = Abilities.Skill_Barreling_Charge }; -- Charge (Wamasu)
    [21967] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds'; name = Abilities.Skill_Barreling_Charge; tooltip = Tooltips.Generic_Knockdown }; -- Charge (Wamasu)
    [21963] = { hide = true }; -- Charge (Wamasu) (Pointless aura that does nothing)

    -- Wamasu (Boss)
    [55868] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }; -- Sweep (Wamasu)
    [55870] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }; -- Sweep (Wamasu)
    [55869] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Sweep (Wamasu)
    [55866] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds'; hide = true }; -- Repulsion Shock (Wamasu)
    [55867] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds' }; -- Repulsion Shock (Wamasu)
    [55850] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_impending_storm.dds' }; -- Impending Storm (Wamasu - Boss)
    [55856] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_impending_storm.dds' }; -- Impending Storm (Wamasu - Boss)
    [55860] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds'; name = Abilities.Skill_Storm_Bound }; -- Ball Lightning (Wamasu - Boss)
    [55864] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds'; internalStack = 0 }; -- Storm Bound (Wamasu - Boss)
    [55862] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds'; tooltip = Tooltips.Skill_Storm_Bound; internalStack = 0 }; -- Storm Bound (Wamasu - Boss)
    [55863] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds'; hideReduce = true; tooltip = Tooltips.Skill_Storm_Bound }; -- Storm Bound (Wamasu - Boss)
    [55861] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds' }; -- Storm Bound (Wamasu - Boss)

    -- Welwa
    [44781] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_swipe.dds'; name = Abilities.Skill_Bite }; -- Swipe (Welwa)
    [45937] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_cleave.dds'; name = Abilities.Skill_Swipe }; -- Cleave (Welwa)
    [44791] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }; -- Rear Kick (Welwa)
    [44792] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }; -- Rear Kick (Welwa)
    [50714] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds'; name = Abilities.Skill_Blitz }; -- Charge (Welwa)
    [45986] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds'; name = Abilities.Skill_Blitz }; -- Charge (Welwa)
    [45991] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds'; name = Abilities.Skill_Blitz; tooltip = Tooltips.Generic_Knockdown }; -- Charge (Welwa)
    [45984] = { hide = true }; -- Charge (Welwa)
    [4022] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_bite.dds' }; -- Bite (Wolf)
    [42844] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_rotbone.dds' }; -- Rotbone (Wolf)
    [14523] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Helljoint (Wolf)
    [75818] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds' }; -- Helljoint (Wolf)
    [14272] = { hide = true; icon = '/esoui/art/icons/mh_second_wolf.dds' }; -- Call of the Pack (Wolf)
    [14273] = { hide = true }; -- Call of the Pack (Wolf)
    [26658] = { hide = true; icon = '/esoui/art/icons/achievement_thievesguild_043.dds' }; -- Call of the Pack (Jackal)
    [26659] = { hide = true }; -- Call of the Pack (Jackal)
    [72803] = { icon = '/esoui/art/icons/achievement_summerset_boss_006.dds'; tooltip = Tooltips.Skill_Hardened_Shell }; -- Hardened Shell (Haj Mota)
    [74123] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_claw.dds' }; -- Claw (Haj Mota)
    [72787] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }; -- Horn Strike (Haj Mota)
    [73481] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }; -- Horn Strike (Haj Mota)
    [74272] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds'; hide = true }; -- Bite (Haj Mota)
    [76578] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Bite (Haj Mota)
    [72793] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds'; hide = true }; -- Toxic Mucus (Haj Mota)
    [76577] = { hide = true }; -- Toxic Mucous (Haj Mota)
    [72815] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_snare_alt.dds'; name = Abilities.Skill_Toxic_Mucus; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Toxic Mucous (Haj Mota)
    [72794] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_damage.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.7 }; -- Toxic Pool (Haj Mota)
    [72796] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'; hide = true }; -- Bog Burst (Haj Mota)
    [72799] = { hide = true }; -- Bog Burst (Haj Mota)
    [76183] = { hide = true }; -- Bog Burst (Haj Mota)
    [72800] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds' }; -- Bog Burst (Haj Mota)
    [74336] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'; tooltip = Tooltips.Generic_Knockback }; -- Bog Burst (Haj Mota)
    [74337] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds' }; -- Bog Burst (Haj Mota)
    [76184] = { hide = true }; -- Bog Burst (Haj Mota)
    [72789] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Shockwave (Haj Mota)
    [73494] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds'; hide = true }; -- Shockwave (Haj Mota)

    -- Dire Wolf
    [76319] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_backstabber.dds'; name = Abilities.Skill_Backstabber; tooltip = Tooltips.Skill_Backstabber }; -- Backstabber (Dire Wolf)
    [80382] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }; -- Bite (Dire Wolf)
    [80383] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }; -- Bite (Dire Wolf)
    [76307] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds' }; -- Lunge (Dire Wolf)
    [76308] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Lunge (Dire Wolf)
    [76303] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds' }; -- Nip (Dire Wolf)
    [76304] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Nip (Dire Wolf)
    [76305] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }; -- Gnash (Dire Wolf)
    [76306] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }; -- Gnash (Dire Wolf)
    [76311] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_harry.dds' }; -- Harry (Dire Wolf)
    [85656] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_harry.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 60 }; -- Harry (Dire Wolf)
    [76312] = { hide = true }; -- Harry (Dire Wolf)
    [76324] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_baleful_call.dds'; tooltip = Tooltips.Skill_Baleful_Call }; -- Baleful Call (Dire Wolf)
    [76322] = { hide = true }; -- Baleful Call (Dire Wolf)

    -- Nix Ox
    [85200] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_scythe.dds' }; -- Scythe (Nix-Ox)
    [85198] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_snap.dds' }; -- Snap (Nix-Ox)
    [85201] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_gore.dds'; name = Abilities.Skill_Gore }; -- Bite (Nix-Ox)
    [85202] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_gore.dds' }; -- Gore (Nix-Ox)
    [85084] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_shriek.dds'; hide = true }; -- Shriek (Nix-Ox)
    [85085] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_shriek.dds'; hide = true }; -- Shriek (Nix-Ox)
    [90765] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds'; hide = true }; -- Acid Spray (Nix-Ox)
    [90776] = { hide = true }; -- Acid Spray (Nix-Ox)
    [90780] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds' }; -- Acid Spray (Nix-Ox)
    [90778] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_poison_damage.dds'; hide = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.5; groundLabel = true }; -- Acid Pool (Nix-Ox)
    [90809] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds'; hide = true }; -- Acid Spray (Nix-Ox)
    [90811] = { hide = true }; -- Acid Spray (Nix-Ox)
    [90812] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds' }; -- Acid Spray (Nix-Ox)
    [90815] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_poison_damage.dds'; hide = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.5; groundLabel = true }; -- Acid Pool (Nix-Ox)
    [85172] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }; -- Winnow (Nix-Ox)
    [85175] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }; -- Winnow (Nix-Ox)
    [85186] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds'; tooltip = Tooltips.Generic_Knockback }; -- Winnow (Nix-Ox)
    [85173] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }; -- Winnow (Nix-Ox)
    [85203] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; hide = true; name = Abilities.Skill_Enrage }; -- Nix-Call (Nix-Ox)
    [95389] = { hide = true }; -- Nix-Call (Nix-Ox)
    [90187] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 10 }; -- Nix-Call (Nix-Ox)
    [90190] = { hide = true }; -- Nix-Call (Nix-Ox)
    [89940] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds'; name = Abilities.Skill_Bile_Spit }; -- Turret (Nix Hound)
    [85387] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_snap.dds' }; -- Snap (Cliff Strider)
    [85388] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_stab.dds' }; -- Stab (Cliff Strider)
    [93516] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_tail_lash.dds' }; -- Tail Lash (Cliff Strider)
    [85395] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }; -- Dive (Cliff Strider)
    [92085] = { hide = true }; -- Dive (Cliff Strider)
    [85398] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }; -- Dive (Cliff Strider)
    [90319] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds'; tooltip = Tooltips.Generic_Knockback }; -- Dive (Cliff Strider)
    [90320] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }; -- Dive (Cliff Strider)
    [85399] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch.dds' }; -- Retch (Cliff Strider)
    [85420] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch.dds' }; -- Retch (Cliff Strider)
    [85421] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch_aoe.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.5 }; -- Retch (Cliff Strider)
    [85448] = { hide = true }; -- Frenzied Feast (Cliff Strider)
    [85390] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }; -- Slash (Cliff Strider Matriach)
    [85391] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }; -- Slash (Cliff Strider Matriach)
    [85394] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds'; tooltip = Tooltips.Skill_Slash_Cliff_Strider }; -- Slash (Cliff Strider Matriach)
    [85392] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds'; hideReduce = true; tooltip = Tooltips.Skill_Slash_Cliff_Strider }; -- Slash (Cliff Strider Matriach)
    [85393] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }; -- Slash (Cliff Strider Matriach)

    -- Daedra
    [51256] = { hide = true }; -- Siphon (Atronach Passive)
    [31115] = { icon = '/esoui/art/icons/achievement_089.dds'; name = Abilities.Skill_Summon_Daedric_Arch; hide = true }; -- Summon Dark Anchor (Daedric Synergy)
    [59129] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boss_immunities.dds'; name = Abilities.Skill_Boss_CC_Immunity; tooltip = Tooltips.Generic_Scary_Immunities }; -- Generic Status Immune (Daedric Synergy)
    [94481] = { hide = true }; -- Summon Dark Anchor (Daedric Synergy)
    [68453] = { hide = true }; -- Explosive Charge (Daedric Synergy)
    [68449] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }; -- Explosive Charge (Daedric Synergy)
    [68452] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }; -- Explosive Charge (Daedric Synergy)

    -- Air Atronach
    [48092] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }; -- Swipe (Air Atronach)
    [48093] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }; -- Swipe (Air Atronach)
    [48096] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare.dds' }; -- Flare (Air Atronach)
    [48121] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_heavy_attack.dds' }; -- Heavy Attack (Air Atronach)
    [48137] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_tornado.dds' }; -- Tornado (Air Atronach)
    [51269] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_frost.dds'; name = Abilities.Skill_Empower_Atronach_Frost; tooltip = Tooltips.Skill_Empower_Atronach_Frost; hide = true }; -- Air Atronach Flame  (Air Atronach - Frost)
    [51267] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_frost.dds'; name = Abilities.Skill_Empower_Atronach_Frost; tooltip = Tooltips.Skill_Empower_Atronach_Frost }; -- Air Atronach Flame (Air Atronach - Frost)
    [50021] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds' }; -- Ice Vortex (Air Atronach - Frost)
    [50022] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 70 }; -- Ice Vortex (Air Atronach - Frost)
    [51262] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_flame.dds'; name = Abilities.Skill_Empower_Atronach_Flame; hide = true }; -- Air Atronach Flame (Air Atronach - Flame)
    [51265] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_flame.dds'; name = Abilities.Skill_Empower_Atronach_Flame; tooltip = Tooltips.Skill_Empower_Atronach_Flame }; -- Air Atronach Flame (Air Atronach - Flame)
    [51281] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }; -- Flame Tornado (Air Atronach)
    [51282] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }; -- Flame Tornado (Air Atronach)
    [51271] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_storm.dds'; name = Abilities.Skill_Empower_Atronach_Storm; tooltip = Tooltips.Skill_Empower_Atronach_Storm; hide = true }; -- Air Atronach Flame (Air Atronach - Storm)
    [51270] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_storm.dds'; name = Abilities.Skill_Empower_Atronach_Storm; tooltip = Tooltips.Skill_Empower_Atronach_Storm }; -- Air Atronach Flame (Air Atronach - Storm)
    [50023] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_zap.dds'; tooltip = Tooltips.Skill_Lightning_Rod }; -- Lightning Rod (Air Atronach)
    [88902] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_zap.dds' }; -- Lightning Rod (Air Atronach)
    [50026] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_zap_pulse.dds' }; -- Lightning Rod (Air Atronach)

    -- Banekin
    [9743] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_entropic_touch.dds' }; -- Entropic Touch (Banekin)
    [9747] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_dire_wound.dds' }; -- Dire Wound (Banekin)
    [9748] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }; -- Envelop (Banekin)
    [9749] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1 }; -- Envelop (Banekin)

    -- Clannfear
    [4798] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt.dds' }; -- Headbutt (Clannfear)
    [4799] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike.dds' }; -- Tail Spike (Clannfear)
    [84443] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike.dds' }; -- Tail Spike (Clannfear)
    [93745] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }; -- Rending Leap (Clannfear)
    [93750] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }; -- Rending Leap (Clannfear)
    [93748] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds'; name = Abilities.Skill_Rending_Leap; tooltip = Tooltips.Generic_Knockdown }; -- Rending Leap Ranged (Clannfear)
    [91395] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds'; hide = true }; -- Devour (Clannfear)
    [91398] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds' }; -- Devour (Clannfear)

    -- Daedric Titan
    [26551] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_strike.dds' }; -- Strike (Daedric Titan)
    [32852] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_scourge_bolt.dds' }; -- Scourge Bolt (Daedric Titan)
    [26641] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds' }; -- Soul Flame (Daedric Titan)
    [32696] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds' }; -- Soul Flame (Daedric Titan)
    [35280] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds'; tooltip = Tooltips.Generic_Stun }; -- Soul Flame (Daedric Titan)
    [73437] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burning_field_blue.dds'; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 1; tooltipValue3 = 80; groundLabel = true }; -- Soul Flame (Daedric Titan)
    [35278] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burning_field_blue.dds'; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 1; tooltipValue3 = 80; hideGround = true; duration = 0; groundLabel = true }; -- Soul Flame (Daedric Titan)
    [34405] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_swallowing_souls.dds' }; -- Swallowing Souls (Daedric Titan)
    [34406] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_swallowing_souls.dds' }; -- Swallowing Souls (Daedric Titan)
    [26554] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds'; tooltip = Tooltips.Skill_Wing_Gust_Stun; tooltipValue2Id = 33085; hideReduce = true }; -- Wing Gust (Daedric Titan)
    [33085] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds'; tooltip = Tooltips.Skill_Wing_Gust_Snare; tooltipValue2Id = 26554 }; -- Wing Gust (Daedric Titan)
    [33086] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds' }; -- Wing Gust (Daedric Titan)

    -- Daedroth
    [4750] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw.dds' }; -- Jagged Claw (Daedroth)
    [4778] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds' }; -- Fiery Jaws (Daedroth)
    [4771] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'; hide = true }; -- Fiery Breath (Daedroth)
    [4772] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'; hide = true }; -- Fiery Breath (Daedroth)
    [91946] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_tremor.dds'; hide = true }; -- Ground Tremor (Daedroth)
    [91953] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_tremor.dds' }; -- Ground Tremor (Daedroth)
    [91949] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shattered_ground.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Ground Tremor (Daedroth)
    [91937] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds' }; -- Burst of Embers (Daedroth)
    [91941] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds'; hide = true }; -- Burst of Embers (Daedroth)
    [91940] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds'; hide = true }; -- Burst of Embers (Daedroth)
    [91943] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds'; tooltip = Tooltips.Generic_Knockback }; -- Burst of Embers (Daedroth)
    [91938] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.5 }; -- Burst of Embers (Daedroth)

    -- Flame Atronach
    [15157] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Flare (Flame Atronach)
    [12254] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Flare (Flame Atronach)
    [26324] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_geyser.dds'; name = Abilities.Skill_Flame_Geyser }; -- Lava Geyser (Flame Atronach)
    [26325] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_geyser.dds'; name = Abilities.Skill_Flame_Geyser }; -- Lava Geyser (Flame Atronach)
    [4891] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_radiance.dds'; tooltip = Tooltips.Skill_Radiance }; -- Radiance (Flame Atronach)
    [4491] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_radiance.dds' }; -- Radiance (Flame Atronach)
    [26319] = { hide = true }; -- Combustion (Flame Atronach)
    [50216] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_combustion.dds' }; -- Combustion (Flame Atronach)
    [50215] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_combustion.dds' }; -- Combustion (Flame Atronach)

    -- Flesh Colossus
    [67123] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_tremor.dds' }; -- Tremor (Flesh Colossus)
    [67636] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_falling_debris.dds' }; -- Falling Debris (Flesh Colossus)
    [66869] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds' }; -- Pin (Flesh Colossus)
    [65709] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds' }; -- Pin (Flesh Colossus)
    [65735] = { hide = true }; -- Miasma Channel (Flesh Colossus)
    [53233] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_disease_damage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Disease; tooltipValue2 = 0.5; hide = true }; -- Miasma Pool (Flesh Colossus)
    [67872] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds'; hide = true }; -- Sweep (Flesh Colossus)
    [68824] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds'; tooltip = Tooltips.Generic_Knockback }; -- Sweep (Flesh Colossus)
    [68813] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds'; name = Abilities.Skill_Sweep }; -- Sweep Knockback (Flesh Colossus)
    [68826] = { name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Staggered (Flesh Colossus - Block Sweep)
    [67842] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds'; hide = true }; -- Sweep Shockwave (Flesh Colossus)
    [76129] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_stumble_forward.dds' }; -- Stumble Forward (Flesh Colossus)
    [65755] = { icon = '/esoui/art/icons/ability_debuff_stagger.dds'; name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Staggered (Flesh Colossus)
    [76133] = { icon = '/esoui/art/icons/ability_debuff_stagger.dds'; name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Stumble Forward (Flesh Colossus)
    [49430] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_smash.dds' }; -- Smash (Flesh Colossus)
    [49429] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_claw.dds' }; -- Claw (Flesh Colossus)
    [76128] = { hide = true }; -- Stumble Forward (Flesh Colossus)
    [76139] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_stumble_forward.dds'; hide = true }; -- Stumble Forward (Flesh Colossus)
    [76140] = { hide = true }; -- Stumble Forward (Flesh Colossus)
    [76130] = { hide = true }; -- Stumble Forward (Flesh Colossus)
    [76131] = { hide = true }; -- Stumble Forward (Flesh Colossus)
    [67772] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; hide = true }; -- Enraged (Flesh Colossus)

    -- Flesh Atronach
    [63275] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_claw.dds' }; -- Claw (Flesh Atronach)
    [63276] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_stomp.dds' }; -- Stomp (Flesh Atronach)
    [4829] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_fire_brand.dds' }; -- Fire Brand (Flesh Atronach)
    [35413] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_fire_brand.dds' }; -- Fire Brand (Flesh Atronach)
    [4817] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds' }; -- Unyielding Mace (Flesh Atronach)
    [20226] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds'; hideReduce = true; name = Abilities.Skill_Unyielding_Mace; tooltip = Tooltips.Skill_Unyielding_Mace }; -- Stun (Flesh Atronach)
    [27326] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds'; hideReduce = true; tooltip = Tooltips.Skill_Unyielding_Mace }; -- Unyielding Mace (Flesh Atronach)
    [23077] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds'; name = Abilities.Skill_Unyielding_Mace; tooltip = Tooltips.Skill_Unyielding_Mace }; -- Bleeding (Flesh Atronach)

    -- Frost Atronach
    [17069] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_spear.dds' }; -- Ice Spear (Frost Atronach)
    [5009] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_shards.dds' }; -- Ice Shards (Frost Atronach)
    [33549] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds'; tooltip = Tooltips.Skill_Chilling_Aura }; -- Chilling Aura (Frost Atronach)
    [33551] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds'; duration = 0; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 20; groundLabel = true }; -- Chilling Aura (Frost Atronach)
    [5017] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }; -- Hoarfrost Fist (Frost Atronach)
    [44906] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }; -- Hoarfrost Fist (Frost Atronach)
    [44907] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds'; hide = true }; -- Hoarfrost Fist (Frost Atronach)
    [44908] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds'; tooltip = Tooltips.Generic_Knockback }; -- Hoarfrost Fist (Frost Atronach)
    [33502] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_snare.dds' }; -- Frozen Ground (Frost Atronach)
    [51645] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_snare.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 70 }; -- Frozen Ground (Frost Atronach)
    [51646] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_snare.dds'; internalStack = 0; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 1; tooltipValue3 = 70; hideGround = true }; -- Frozen Ground (Frost Atronach)

    -- Grevious Twilight
    [65926] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_slash.dds' }; -- Slash (Grevious Twilight)
    [65845] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds' }; -- Rend (Grevious Twilight)
    [66643] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds' }; -- Rend (Grevious Twilight)
    [50596] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_shadow.dds' }; -- Shadow Bolt (Grevious Twilight)
    [50626] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }; -- Shadow Strike (Grevious Twilight)
    [50628] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }; -- Shadow Strike (Grevious Twilight)
    [65889] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }; -- Shadow Strike (Grevious Twilight)
    [65891] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }; -- Shadow Strike (Grevious Twilight)

    -- Harvester
    [11076] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_chasten.dds'; hide = true }; -- Chasten (Harvester)
    [11079] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_black_winter.dds'; hide = true }; -- Black Winter (Harvester)
    [26008] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_black_winter.dds'; hide = true }; -- Black Winter (Harvester)
    [74794] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Black Winter (Harvester)
    [11083] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds' }; -- The Feast (Harvester)
    [26110] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds'; tooltip = Tooltips.Generic_Levitate }; -- The Feast (Harvester)
    [26017] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_the_feast.dds'; name = Abilities.Skill_The_Feast; hide = true }; -- Creeping Doom (The Feast)
    [26018] = { hide = true }; -- Creeping Doom (The Feast)
    [88070] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_summon_daedroth.dds'; name = Abilities.Skill_Summon_Daedroth; hide = true }; -- Creeping Doom (The Feast)

    -- Ogrim
    [8204] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_strike.dds' }; -- Strike (Ogrim)
    [8205] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_regeneration.dds'; tooltip = Tooltips.Generic_HoT_Channel; tooltipValue2 = 0.5 }; -- Regeneration (Ogrim)
    [24690] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds' }; -- Body Slam (Ogrim)
    [48553] = { hide = true }; -- Focused Charge (Ogrim)
    [24699] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds' }; -- Body Slam (Ogrim)
    [24693] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds'; hide = true }; -- Body Slam (Ogrim)
    [24700] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Body Slam (Ogrim)
    [91848] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }; -- Stomp (Ogrim)
    [91850] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }; -- Stomp (Ogrim)
    [91851] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shattered_ground.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 35 }; -- Stomp (Ogrim)
    [91855] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Ogrim)
    [127630] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Ogrim)

    -- Scamp
    [6158] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_alt.dds' }; -- Flare (Scamp)
    [6166] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_heat_wave.dds' }; -- Heat Wave (Scamp)
    [6167] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_heat_wave.dds' }; -- Heat Wave (Scamp)
    [6160] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rain_of_fire.dds' }; -- Rain of Fire (Scamp)
    [6162] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rain_of_fire.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Rain of Fire (Scamp)

    -- Spider Daedra
    [8778] = { icon = 'LuiExtended/media/icons/abilities/ability_spiderdaedra_strike.dds' }; -- Strike (Spider Daedra)
    [8808] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds'; hide = true }; -- Spit (Spider Daedra)
    [8779] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_onslaught.dds' }; -- Lightning Onslaught (Spider Daedra)
    [38658] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_onslaught.dds' }; -- Lightning Onslaught (Spider Daedra)
    [8773] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_spiderling.dds'; tooltip = Tooltips.Skill_Summon_Spiderling }; -- Summon Spiderling (Spider Daedra)
    [89303] = { hide = true }; -- Summon Spiderling (Spider Daedra)
    [89301] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; name = Abilities.Skill_Weakness; duration = -120; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Weakness_NPC_Summon }; -- Summon Spiderling (Spider Daedra)
    [89306] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds' }; -- Web (Spider Daedra - Spiderling)
    [89307] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 60 }; -- Web (Spider Daedra - Spiderling)
    [8782] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike_daedra.dds' }; -- Lightning Storm (Spider Daedra)
    [20530] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike_daedra.dds' }; -- Lightning Storm (Spider Daedra)

    -- Storm Atronach
    [4858] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_bash.dds' }; -- Bash (Storm Atronach)
    [13898] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_strike.dds' }; -- Strike (Storm Atronach)
    [35220] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_impending_storm.dds' }; -- Impending Storm (Storm Atronach)
    [35222] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_impending_storm.dds' }; -- Impending Storm (Storm Atronach)
    [4864] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds' }; -- Storm Bound (Storm Atronach)
    [35240] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds' }; -- Storm Bound (Storm Atronach)
    [12287] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds'; tooltip = Tooltips.Skill_Storm_Bound }; -- Storm Bound (Storm Atronach)
    [12288] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds'; hideReduce = true; tooltip = Tooltips.Skill_Storm_Bound }; -- Storm Bound (Storm Atronach)
    [12286] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_storm_bound.dds' }; -- Storm Bound (Storm Atronach)

    -- Xivilai
    [7095] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_xivilai_heavy.dds' }; -- Heavy Attack (Xivilai)
    [83072] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_xivilai_frost.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Freezing Edge (Xivilai)
    [49203] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frost_root.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Frozen Weapon (Xivilai)
    [88947] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_grasp.dds' }; -- Lightning Grasp (Xivilai)
    [88949] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_grasp.dds' }; -- Lightning Grasp (Xivilai)
    [7100] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hand_of_flame.dds' }; -- Hand of Flame (Xivilai)
    [25728] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hand_of_flame.dds' }; -- Hand of Flame (Xivilai)
    [25726] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_clannfear.dds' }; -- Summon Daedra (Xivilai)

    -- Watcher
    [4652] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gaze.dds' }; -- Gaze (Watcher)
    [4653] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }; -- Shockwave (Watcher)
    [43817] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave_snare.dds'; name = Abilities.Skill_Shockwave; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 45 }; -- Shockwave Snare (Watcher)
    [95855] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds'; tooltip = Tooltips.Generic_Knockback }; -- Shockwave (Watcher)
    [95856] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds'; hide = true }; -- Shockwave (Watcher)
    [53880] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }; -- Shockwave (Watcher)
    [9219] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds'; hide = true }; -- Doom-Truth's Gaze (Watcher)
    [9220] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }; -- Doom-Truth's Gaze (Watcher)
    [14518] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds'; tooltip = Tooltips.Generic_Stun }; -- Doom-Truth's Gaze (Watcher)
    [14425] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds'; hide = true }; -- Doom-Truth's Gaze (Watcher)
    [14426] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }; -- Doom-Truth's Gaze (Watcher)
    [14546] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds'; tooltip = Tooltips.Generic_Stun }; -- Doom-Truth's Gaze (Watcher)

    -- Winged Twilight
    [12062] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds' }; -- Kick (Winged Twilight)
    [13690] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds' }; -- Kick (Winged Twilight)
    [6410] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_tail_clip.dds' }; -- Tail Clip (Winged Twilight)
    [63612] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_tail_clip.dds' }; -- Tail Clip (Winged Twilight)
    [6412] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_dusks_howl.dds'; tooltip = Tooltips.Generic_Stun }; -- Dusk's Howl (Winged Twilight)

    -- Daedric Hunger
    [84825] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_slash.dds' }; -- Slash (Hunger)
    [84826] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_slash.dds' }; -- Slash (Hunger)
    [84827] = { hide = true }; -- Rake (Hunger)
    [84834] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_rake.dds' }; -- Rake (Hunger)
    [94903] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds' }; -- Spring (Hunger)
    [94908] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds'; hide = true }; -- Spring (Hunger)
    [94907] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Spring (Hunger)
    [87237] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds' }; -- Spring (Hunger)
    [87242] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds'; hide = true }; -- Spring (Hunger)
    [87241] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Spring (Hunger)
    [87988] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }; -- Devour (Hunger)
    [87252] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds'; tooltip = Tooltips.Skill_Devour_Hunger }; -- Devour (Hunger)
    [87253] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }; -- Devour (Hunger)
    [87251] = { hide = true }; -- Devour (Hunger)
    [87385] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds'; hide = true }; -- Devour (Hunger)
    [87386] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds'; tooltip = Tooltips.Generic_Knockback }; -- Devour (Hunger)
    [87987] = { hide = true }; -- Devour (Hunger)
    [84944] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }; -- Hollow (Hunger)
    [91440] = { hide = true }; -- Hollow (Hunger)
    [91439] = { hide = true }; -- Hollow (Hunger)
    [84967] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }; -- Hollow (Hunger)
    [84988] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds'; tooltip = Tooltips.Generic_Knockback }; -- Hollow (Hunger)
    [84990] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }; -- Hollow (Hunger)
    [87269] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds'; hide = true }; -- Torpor (Hunger)
    [87270] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor_aura.dds'; tooltip = Tooltips.Skill_Torpor }; -- Torpor (Hunger)
    [87538] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }; -- Torpor (Hunger)
    [87536] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds'; tooltip = Tooltips.Generic_Stun }; -- Torpor (Hunger)
    [89751] = { hide = true }; -- Dispel Illusion (Hunger)
    [87271] = { hide = true }; -- Torpor (Hunger)
    [87273] = { hide = true }; -- Torpor (Hunger)
    [87639] = { hide = true }; -- Fade (Hunger)
    [91433] = { hide = true }; -- Fade (Voracity - Hunger Boss)

    -- Iron Atronach
    [89030] = { hide = true }; -- Subduction (Iron Atronach)
    [88246] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_iron_hand.dds' }; -- Iron Hand (Iron Atronach)
    [88247] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_eruption.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Eruption (Iron Atronach)
    [88282] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp.dds' }; -- Rock Stomp (Iron Atronach)
    [88286] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp.dds' }; -- Rock Stomp (Iron Atronach)
    [88295] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp_ranged.dds' }; -- Rock Stomp (Iron Atronach)
    [88261] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds' }; -- Lava Wave (Iron Atronach)
    [88266] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds'; hide = true }; -- Lava Wave (Iron Atronach)
    [95281] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds'; hide = true }; -- Lava Wave (Iron Atronach)
    [89258] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_subduction.dds'; hide = true }; -- Subduction (Iron Atronach)
    [88297] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blast_furnace.dds'; hide = true }; -- Blast Furnace (Iron Atronach)
    [88323] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blast_furnace.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.5 }; -- Blast Furnace (Iron Atronach)

    -- Dwemer

    -- Dwemer Sphere
    [7484] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_blade.dds' }; -- Blade (Dwemer Sphere)
    [7485] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_dart.dds' }; -- Dart (Dwemer Sphere)
    [16031] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Richochet Wave (Dwemer Sphere)
    [29832] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Richochet Wave (Dwemer Sphere)
    [7520] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_steam_wall.dds' }; -- Steam Wall (Dwemer Sphere)
    [84216] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_steam_wall.dds' }; -- Steam Wall (Dwemer Sphere)
    [7544] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_quake.dds' }; -- Quake (Dwemer Sphere)
    [46053] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_quake.dds' }; -- Quake (Dwemer Sphere)

    -- Dwemer Centurion
    [11245] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_axe.dds' }; -- Axe (Dwemer Centurion)
    [13783] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_hammer.dds' }; -- Hammer (Dwemer Centurion)
    [11247] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }; -- Sweeping Spin (Dwemer Centurion)
    [43554] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }; -- Sweeping Spin (Dwemer Centurion)
    [11262] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Sweeping Spin (Dwemer Centurion)
    [11246] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds'; hide = true }; -- Steam Breath (Dwemer Centurion)
    [11282] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds' }; -- Steam Breath (Dwemer Centurion)

    -- Dwemer Spider
    [7719] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }; -- Shocking Touch (Dwemer Spider)
    [20507] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_double_strike.dds' }; -- Double Strike (Dwemer Spider)
    [20508] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_double_strike.dds' }; -- Double Strike (Dwemer Spider)
    [7717] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_combustion.dds' }; -- Detonation (Dwemer Spider)
    [15206] = { hide = true }; -- Detonation (Dwemer Spider)
    [84019] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_combustion.dds' }; -- Detonation (Dwemer Spider)
    [13536] = { hide = true }; -- Detonation (Dwemer Spider)

    -- Dwemer Sentry
    [64423] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sparks.dds'; hide = true }; -- Sparks (Dwemer Sentry)
    [84312] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds'; tooltip = Tooltips.Skill_Static_Shield }; -- Static Shield (Dwemer Sentry)
    [70133] = { hide = true }; -- Static Shield
    [64556] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds'; name = Abilities.Skill_Static_Shield }; -- Static Eruption (Dwemer Sentry)
    [64460] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds'; tooltip = Tooltips.Skill_Static_Shield }; -- Static Shield (Dwemer Sentry)
    [70134] = { hide = true }; -- Static Shield (Dwemer Sentry)
    [68790] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds'; name = Abilities.Skill_Static_Shield }; -- Static Shield Explosion (Dwemer Sentry)
    [64479] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderbolt.dds' }; -- Thunderbolt (Dwemer Sentry)
    [64543] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderbolt.dds'; hide = true }; -- Thunderbolt (Dwemer Sentry)
    [64489] = { hide = true }; -- Find Turret (Dwemer Sentry)
    [64508] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_turret_mode.dds'; name = Abilities.Skill_Turret_Mode; tooltip = Tooltips.Skill_Turret_Mode }; -- Turret Mode (Dwemer Sentry)

    -- Dwemer Arquebus
    [85242] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_dart.dds'; name = Abilities.Skill_Dart; hide = true }; -- Quick Shot (Dwemer Arquebus)
    [85255] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_shock_blast.dds' }; -- Shock Blast (Dwemer Arquebus)
    [88668] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_impulse_mine.dds' }; -- Impulse Mine (Dwemer Arquebus)
    [88728] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_impulse_mine.dds' }; -- Impulse Mine (Dwemer Arquebus)
    [85270] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_barrage.dds'; tooltip = Tooltips.Skill_Shock_Barrage }; -- Shock Barrage (Dwemer Arquebus)
    [85288] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_barrage.dds'; hide = true }; -- Shock Barrage (Dwemer Arquebus)
    [91013] = { hide = true }; -- Shock Barrage (Dwemer Arquebus)
    [85319] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds'; name = Abilities.Skill_Split_Bolt; hide = true }; -- Siege Ballista (Dwemer Arquebus)
    [91093] = { hide = true }; -- Split Bolt (Dwemer Arquebus)
    [91094] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.5 }; -- Split Bolt (Dwemer Arquebus)
    [91095] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.5 }; -- Split Bolt (Dwemer Arquebus)
    [91096] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.5 }; -- Split Bolt (Dwemer Arquebus)
    [85326] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_polarizing_field.dds'; hide = true }; -- Polarizing Field (Dwemer Arquebus)
    [85327] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_polarizing_field.dds'; duration = 0; tooltip = Tooltips.Skill_Polarizing_Field }; -- Polarizing Field (Dwemer Arquebus)
    [85334] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds'; hide = true }; -- Polarizing Field (Dwemer Arquebus)

    -- Dwemer Synergies
    [20238] = { hide = true }; -- Move Back (Dwemer Spider - Overcharge Synergy)
    [19970] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_static_field.dds'; tooltip = Tooltips.Skill_Static_Field }; -- Static Field (Dwemer Spider)
    [19997] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_static_field.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Static Field (Dwemer Spider)
    [20506] = { hide = true }; -- Overcharge Trigger (Dwemer Spider - Overcharge Synergy)
    [27333] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds'; tooltip = Tooltips.Generic_Enrage_No_Dur; tooltipValue2 = 25 }; -- Overcharge Trigger (Dwemer Spider - Overcharge Synergy)
    [27458] = { hide = true }; -- tell others (Dwemer Spider - Overcharge Synergy)--
    [20207] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }; -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20206] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds'; tooltip = Tooltips.Generic_Enrage_No_Dur; tooltipValue2 = 25 }; -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20221] = { hide = true }; -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20505] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds'; hide = true }; -- Overcharge (Overcharge)
    [20222] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds'; hide = true }; -- Overcharge (Overcharge)
    [20504] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    [20220] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    [52679] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    [52680] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    -- Insects
    [5278] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_bite.dds' }; -- Bite (Assassin Beetle)
    [6137] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds'; name = Abilities.Skill_Lacerate }; -- Laceration (Assassin Beetle)
    [51736] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds'; name = Abilities.Skill_Lacerate; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Bleeding (Assassin Beetle)
    [51735] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds'; name = Abilities.Skill_Lacerate }; -- Bleeding (Assassin Beetle)
    [5268] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_collywobbles.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 20 }; -- Collywobbles (Assassin Beetle)
    [91789] = { hide = true }; -- Ambush (Assassin Beetle)
    [91791] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_feast.dds'; hide = true }; -- Feast (Assassin Beetle)
    [13680] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_poison_damage.dds'; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.5; groundLabel = true }; -- Acid Blood (Assassin Beetle)
    [6754] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_pincer.dds' }; -- Pincer (Giant Scorpion)
    [6755] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds' }; -- Sting (Giant Scorpion)
    [13671] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1.5 }; -- Sting (Giant Scorpion)
    [6757] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }; -- Blurred Strike (Giant Scorpion)
    [9040] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }; -- Blurred Strike (Giant Scorpion)
    [6756] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds' }; -- Paralyze (Giant Scorpion)
    [12312] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds'; name = Abilities.Skill_Paralyze; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 55 }; -- Snare (Giant Scorpion)
    [6758] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_hardened_carapace.dds'; tooltip = Tooltips.Skill_Hardened_Carapace }; -- Hardened Carapace (Giant Scorpion)
    [4731] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_bite.dds' }; -- Bite (Giant Spider)
    [5789] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_poison.dds' }; -- Poisonous Burst (Giant Spider)
    [5790] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_poison.dds' }; -- Poisonous Burst (Giant Spider)
    [5685] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds' }; -- Corrosive Bite (Giant Spider)
    [8087] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }; -- Poison Spray (Giant Spider)
    [8088] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }; -- Poison Spray (Giant Spider)
    [4730] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_poison.dds' }; -- Spit (Giant Spider)
    [4737] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds'; name = Abilities.Skill_Web }; -- Encase (Giant Spider)
    [47318] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds'; name = Abilities.Skill_Web; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 60 }; -- Encase (Giant Spider)
    [13382] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_devour.dds' }; -- Devour (Giant Spider)

    -- Giant Wasp
    [9225] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_bite.dds' }; -- Bite (Giant Wasp)
    [9226] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_sting.dds' }; -- Sting (Giant Wasp)
    [9229] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds' }; -- Inject Larva (Giant Wasp)
    [9237] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds'; name = Abilities.Skill_Inject_Larva; unbreakable = 1; tooltip = Tooltips.Skill_Inject_Larva }; -- Larva Gestation (Giant Wasp)
    [9238] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_larva_burst.dds' }; -- Larva Burst (Giant Wasp)
    [25110] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds'; name = Abilities.Skill_Zoom }; -- Charge (Giant Wasp)
    [48559] = { hide = true }; -- Focused Charge (Giant Wasp)
    [25119] = { hide = true }; -- Charge (Giant Wasp)
    [25113] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds'; name = Abilities.Skill_Zoom }; -- Charge (Giant Wasp)
    [25120] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds'; name = Abilities.Skill_Zoom; tooltip = Tooltips.Generic_Knockdown }; -- Charge (Giant Wasp)
    [25112] = { hide = true }; -- Charge (Giant Wasp)

    -- Hoarvor
    [6788] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bite.dds' }; -- Bite (Hoarvor)
    [6800] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }; -- Bloodletting (Hoarvor)
    [42292] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }; -- Bloodletting (Hoarvor)
    [6795] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds'; tooltip = Tooltips.Skill_Latch_On }; -- Latch On (Hoarvor)
    [13585] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds' }; -- Latch On (Hoarvor)

    -- Necrotic Hoarvor (DLC)
    [61243] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds' }; -- Vile Bite (Hoarvor DLC)
    [69392] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds'; name = Abilities.Skill_Vile_Bite; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Vile Bite Poison (Hoarvor DLC)
    [61244] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds' }; -- Fevered Retch (Hoarvor DLC)
    [61245] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1 }; -- Fevered Retch (Hoarvor DLC)
    [61360] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }; -- Infectious Swarm (Hoarvor DLC)
    [61377] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }; -- Infectious Swarm (Hoarvor DLC)
    [61372] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds'; tooltip = Tooltips.Skill_Venomous_Burst; tooltipValue2 = 2.5; tooltipValue3 = 0.5 }; -- Infectious Swarm (Hoarvor DLC)
    [61374] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }; -- Infectious Swarm (Hoarvor DLC)
    [61376] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds'; hide = true }; -- Infectious Swarm (Hoarvor DLC)
    [61375] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_poison_snare.dds'; name = Abilities.Skill_Infectious_Swarm; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 75 }; -- Infectious Swarm (Hoarvor DLC)
    [61427] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds' }; -- Necrotic Explosion (Hoarvor DLC)
    [61249] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds'; hide = true }; -- Necrotic Explosion (Hoarvor DLC)
    [61388] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds'; name = Abilities.Skill_Necrotic_Explosion; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Necrotic Explosion Snare (Hoarvor DLC)

    -- Kwama Scrib
    [83977] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamascrib_bite.dds' }; -- Bite (Kwama Scrib)
    [8272] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds'; name = Abilities.Skill_Contagion; hide = true }; -- Spit (Kwama Scrib)
    [47838] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_snare_alt.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Contagion (Kwama Scrib)
    [42869] = { hide = true }; -- Burrow (Kwama Scrib)

    -- Kwama Worker
    [9287] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_bite.dds' }; -- Bite (Kwama Worker)
    [9291] = { hide = true }; -- Pounce (Kwama Worker)
    [83953] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_pounce.dds' }; -- Pounce (Kwama Worker)
    [14839] = { hide = true }; -- Charge (Kwama Worker)
    [14841] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds'; name = Abilities.Skill_Plow; hide = true }; -- Charge (Kwama Worker)
    [48539] = { hide = true }; -- Focused Charge (Kwama Worker)
    [14846] = { hide = true }; -- Charge (Kwama Worker)
    [18808] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds'; name = Abilities.Skill_Plow; hide = true }; -- Charge (Kwama Worker)
    [18810] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds'; name = Abilities.Skill_Plow; tooltip = Tooltips.Generic_Knockdown }; -- Charge (Kwama Worker)
    [14844] = { hide = true }; -- Charge (Kwama Worker)
    [14845] = { hide = true }; -- Charge (Kwama Worker)
    [18814] = { hide = true }; -- Charge (Kwama Worker)
    [18546] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shattered_ground.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 50 }; -- Shattered Ground (Kwama Worker)

    -- Kwama Warrior
    [15011] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_swipe.dds' }; -- Swipe -- Kwama Warrior
    [9763] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }; -- Smash -- Kwama Warrior
    [9764] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }; -- Smash -- Kwama Warrior
    [9769] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds' }; -- Excavation -- Kwama Warrior
    [18585] = { hide = true }; -- Excavation -- Kwama Warrior
    [27463] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds' }; -- Excavation -- Kwama Warrior
    [49192] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_kwama_scrib.dds'; name = Abilities.Skill_Call_Scribs; hide = true }; -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)
    [18567] = { hide = true }; -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)

    -- Shalk
    [6127] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_bite.dds' }; -- Bite (Shalk)
    [5260] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds'; name = Abilities.Skill_Fiery_Breath }; -- Fiery Breath (Shalk)
    [10947] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds' }; -- Fiery Breath (Shalk)
    [5252] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds' }; -- Fire Bite (Shalk)
    [6129] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1 }; -- Fire Bite (Shalk)
    [5262] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_burning_ground.dds' }; -- Burning Ground (Shalk)
    [5265] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_burning_ground.dds'; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1; groundLabel = true }; -- Burning Ground (Shalk)

    -- Thunderbug
    [5308] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunder_bite.dds' }; -- Thunder Bite (Thunderbug)
    [8429] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds'; tooltip = Tooltips.Skill_Lightning_Rod }; -- Zap (Thunderbug)
    [65079] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds' }; -- Zap (Thunderbug)
    [26379] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_zap_pulse_thunderbug.dds' }; -- Zap (Thunderbug)
    [26382] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_small.dds' }; -- Bolt (Thunderbug)
    [26412] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderstrikes.dds' }; -- Thunderstrikes (Thunderbug)
    [34980] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderstrikes.dds' }; -- Thunderstrikes (Thunderbug)

    -- Kotu Gava
    [73166] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds'; name = Abilities.Skill_Leeching_Bite }; -- Bite (Kotu Gava)
    [73214] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds'; name = Abilities.Skill_Leeching_Bite; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Bite (Kotu Gava)
    [73215] = { hide = true }; -- Bite (Kotu Gava)

    -- Kotu Gava Broodmother
    [73184] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds'; hide = true }; -- Vile Spit (Kotu Gava Broodmother)
    [73172] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds' }; -- Swarm (Kotu Gava Broodmother)
    [73173] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'; tooltip = Tooltips.Skill_Kotu_Gava_Swarm; tooltipValue2Mod = -1 }; -- Swarm (Kotu Gava Broodmother)
    [73193] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Swarm (Kotu Gava Broodmother)
    [73177] = { hide = true }; -- Swarmburst (Kotu Gava Broodmother)
    [73174] = { hide = true }; -- Swarm (Kotu Gava Broodmother)
    [73175] = { hide = true }; -- Swarm (Kotu Gava Broodmother)
    [73176] = { hide = true }; -- Swarm (Kotu Gava Broodmother)
    [76579] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds'; name = Abilities.Skill_Leeching_Bite }; -- Bite (Kotu Gava Spawn)
    [76580] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds'; name = Abilities.Skill_Leeching_Bite; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Bite (Kotu Gava Spawn)
    [76581] = { hide = true }; -- Bite (Kotu Gava Spawn)
    [73199] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarmburst.dds' }; -- Swarmburst (Kotu Gava Broodmother)
    [73194] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_snare_alt.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Swarmburst (Kotu Gava Broodmother)
    [73198] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarmburst.dds'; tooltip = Tooltips.Skill_Kotu_Gava_Swarm; tooltipValue2 = 1 }; -- Swarmburst (Kotu Gava Broodmother)
    [87022] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds'; name = Abilities.Skill_Fetcherfly_Swarm; hide = true }; -- Summon Swarm (Fetcherfly Nest)
    [85524] = { hide = true }; -- Ashen Wind (Fetcherfly Swarm)
    [85525] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }; -- Ashen Wind (Fetcherfly Swarm)
    [85526] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }; -- Ashen Cloud (Fetcherfly Swarm)
    [85645] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_bombard.dds' }; -- Bombard (Fectherfly Nest)
    [85646] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_bombard.dds'; name = Abilities.Skill_Bombard }; -- Bomb (Fectherfly Nest)
    [87125] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_heat_vents.dds'; hide = true }; -- Heat Vents (Fetcherfly Nest)
    [87126] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_heat_vents.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.5 }; -- Heat Vents (Fetcherfly Nest)
    [92083] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_slam.dds' }; -- Slam (Fetcherfly Hive Golem)
    [87095] = { hide = true }; -- Colonize (Fetcherfly Hive Golem)
    [92078] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_colonize.dds'; name = Abilities.Skill_Fetcherfly_Colony }; -- Colonize (Fetcherfly Hive Golem)
    [92079] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_colonize.dds'; tooltip = Tooltips.Skill_Colonize }; -- Colonize (Fetcherfly Hive Golem)
    [92081] = { hide = true }; -- Colonize (Fetcherfly Hive Golem)
    [87062] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }; -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [92075] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }; -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [87087] = { tooltip = Tooltips.Generic_Silence }; -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [87030] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_focused_swarm.dds' }; -- Focused Swarm (Fetcherfly Hive Golem)
    [87031] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_focused_swarm.dds' }; -- Focused Swarm (Fetcherfly Hive Golem)

    -- Monsters

    -- Gargoyle
    [10259] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }; -- Double Swipe (Gargoyle)
    [32672] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }; -- Double Swipe (Gargoyle)
    [10270] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds' }; -- Quake (Gargoyle)
    [10271] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds' }; -- Quake (Gargoyle)
    [10256] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds' }; -- Lacerate (Gargoyle)
    [25716] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds'; name = Abilities.Skill_Lacerate; tooltip = Tooltips.Skill_Lacerate_Gargoyle; hideReduce = true }; -- Stun (Gargoyle)
    [25718] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds'; name = Abilities.Skill_Lacerate; tooltip = Tooltips.Skill_Lacerate_Gargoyle }; -- Stun (Gargoyle)
    [25714] = { icon = '/esoui/art/icons/achievement_update11_dungeons_029.dds'; tooltip = Tooltips.Skill_Vampiric_Touch_Gargoyle }; -- Vampiric Touch (Gargoyle)
    [51352] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_petrify.dds'; hide = true }; -- Petrify (Gargoyle)
    [51365] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_petrify.dds'; tooltip = Tooltips.Skill_Petrify_NPC }; -- Petrify (Gargoyle)
    [51353] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_petrify.dds' }; -- Petrify (Gargoyle)
    [51354] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_petrify.dds'; tooltip = Tooltips.Generic_Stun }; -- Petrify (Gargoyle)

    -- Giant
    [46845] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_sweep.dds' }; -- Sweep (Giant)
    [8674] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_kick.dds' }; -- Sweep (Giant)
    [26124] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds' }; -- Shatter (Giant)
    [26129] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds'; hide = true }; -- Shatter (Giant)
    [127904] = { hide = true }; -- Crushing Quake (Giant)
    [127910] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds'; name = Abilities.Skill_Obliterate }; -- Giant's Maul (Giant)
    [127908] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds' }; -- Obliterate (Giant)

    -- Hag
    [2901] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_strike.dds' }; -- Staff Strike (Hag)
    [2786] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_steal_essence.dds'; tooltip = Tooltips.Skill_Steal_Essence }; -- Steal Essence (Hag)
    [21642] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_steal_essence.dds' }; -- Steal Essence (Hag)
    [3349] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_reflective_shadows.dds'; tooltip = Tooltips.Skill_Reflective_Shadows }; -- Reflective Shadows (Hag)
    [2821] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_luring_snare.dds'; hide = true }; -- Luring Snare (Hag)
    [32267] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_luring_snare.dds'; name = Abilities.Skill_Luring_Snare; tooltip = Tooltips.Generic_Stun }; -- Grapple (Hag)

    -- Hagraven
    [10611] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_alt.dds' }; -- Flare (Hagraven)
    [10615] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_raven_storm.dds' }; -- Raven Storm (Hagraven)
    [10616] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_raven_storm.dds' }; -- Raven Storm (Hagraven)
    [12426] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Raven Storm (Hagraven)
    [10613] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_combustion.dds' }; -- Fire Bomb (Hagraven)
    [10614] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_combustion.dds' }; -- Fire Bomb (Hagraven)
    [64806] = { hide = true }; -- Briarheart Resurrection (Hagraven)
    [64808] = { icon = '/esoui/art/icons/ability_healer_028.dds'; duration = 2.5; tooltip = Tooltips.Skill_Briarheart_Resurrection }; -- Briarheart Resurrection (Hagraven)
    [65027] = { icon = '/esoui/art/icons/ability_healer_028.dds'; tooltip = Tooltips.Skill_Briarheart_Resurrection }; -- Briarheart Resurrection (Hagraven)

    [4112] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_talon.dds' }; -- Talon (Harpy)
    [4125] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_kick.dds' }; -- Kick (Harpy)
    [4684] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bolt.dds' }; -- Bolt (Harpy)
    [4123] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wing_slice.dds' }; -- Wing Slice (Harpy)
    [24369] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wing_slice.dds' }; -- Wing Slice (Harpy)
    [13515] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds' }; -- Wind Gust (Harpy)
    [13516] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds' }; -- Wind Gust (Harpy)
    [13517] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Wind Gust (Harpy)
    [24604] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_charged_ground.dds' }; -- Charged Ground (Harpy)
    [8628] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_charged_ground.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.75 }; -- Charged Ground (Harpy)
    [4689] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_impending_storm.dds' }; -- Impending Storm (Harpy)
    [4690] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_impending_storm.dds' }; -- Impending Storm (Harpy)
    [9846] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_bite.dds' }; -- Bite (Ice Wraith)
    [43809] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds'; tooltip = Tooltips.Generic_Immunity }; -- Shard Burst (Ice Wraith)
    [43810] = { hide = true }; -- Shard Burst (Ice Wraith)
    [38920] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds'; tooltip = Tooltips.Generic_Stun }; -- Shard Burst (Ice Wraith)
    [24877] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds' }; -- Shard Burst (Ice Wraith)
    [24866] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds'; name = Abilities.Skill_Assault }; -- Blood in the Water (Ice Wraith)
    [48549] = { hide = true }; -- Focused Charge (Ice Wraith)
    [24869] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds'; name = Abilities.Skill_Assault }; -- Blood in the Water (Ice Wraith)
    [46563] = { icon = '/esoui/art/icons/ability_mage_020.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 70 }; -- Blood in the Water (Ice Wraith)

    -- Imp
    [14801] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_small.dds'; hide = true }; -- Flare (Imp - Fire)
    [14802] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fireball.dds'; hide = true }; -- Fireball (Imp - Fire)
    [17703] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_ray.dds'; tooltip = Tooltips.Skill_Flame_Ray }; -- Flame Ray (Imp - Fire)
    [65078] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_ray.dds' }; -- Flame Ray (Imp - Fire)
    [17706] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_bomb.dds' }; -- Flame Ray (Imp - Fire)
    [7732] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_small.dds'; hide = true }; -- Bolt (Imp - Lightning)
    [13648] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_spark.dds'; hide = true }; -- Spark (Imp - Lightning)
    [8884] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_zap_imp.dds'; tooltip = Tooltips.Skill_Lightning_Rod }; -- Zap (Imp - Lightning)
    [65077] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_zap_imp.dds' }; -- Zap (Imp - Lightning)
    [14666] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_zap_pulse_imp.dds' }; -- Zap (Imp - Lightning)
    [88906] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow_small.dds'; hide = true }; -- Frost Bolt (Imp - Frost)
    [88918] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; hide = true }; -- Frostball (Imp - Frost)
    [81794] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frost_ray.dds'; tooltip = Tooltips.Skill_Frost_Ray }; -- Frost Ray (Imp - Frost)
    [88907] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frost_ray.dds'; hide = true }; -- Frost Ray (Imp - Frost)
    [88915] = { hide = true }; -- Frost Ray (Imp - Frost)
    [88908] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_pillar.dds' }; -- Frost Ray (Imp - Frost)
    [9670] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_strike.dds' }; -- Strike (Lamia)
    [9671] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_howling_strike.dds' }; -- Howling Strike (Lamia)
    [89382] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_howling_strike.dds' }; -- Howling Strike (Lamia)
    [9674] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_resonate.dds' }; -- Resonate (Lamia)
    [23281] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_resonate.dds' }; -- Resonate (Lamia)
    [7830] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_shockwave.dds'; hide = true }; -- Shockwave (Lamia)
    [12074] = { hide = true }; -- Summon Spectral Lamia (Lamia)
    [9680] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_spectral_lamia.dds'; tooltip = Tooltips.Skill_Summon_Spectral_Lamia }; -- Summon Spectral Lamia (Lamia)
    [89399] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; name = Abilities.Skill_Weakness; duration = -120; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Weakness_NPC_Summon }; -- Summon Spectral Lamia (Lamia)
    [7835] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_convalescence.dds'; hide = true }; -- Convalescence (Lamia)
    [7831] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_harmony.dds' }; -- Harmony (Lamia)
    [24745] = { hide = true }; -- Harmony (Lamia)
    [23358] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_harmony.dds'; tooltip = Tooltips.Skill_Harmony }; -- Harmony (Lamia)
    [24814] = { hide = true }; -- Harmony (Lamia)
    [3757] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw.dds' }; -- Claw (Lurcher)
    [3860] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize.dds' }; -- Pulverize (Lurcher)
    [32698] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Pulverize (Lurcher)
    [3855] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs.dds' }; -- Crushing Limbs (Lurcher)
    [38554] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs.dds'; name = Abilities.Skill_Crushing_Limbs; tooltip = Tooltips.Generic_Stun }; -- Crushing Limbs (Lurcher)
    [3767] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen.dds'; hide = true }; -- Choking Pollen (Lurcher)
    [4769] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.5 }; -- Choking Pollen (Lurcher)
    [5520] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; hide = true }; -- Frost Bolt (Nereid)
    [5559] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds' }; -- Icy Geyser (Nereid)
    [11024] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds' }; -- Icy Geyser (Nereid)
    [5540] = { icon = '/esoui/art/icons/ability_wrothgar_chillingwind.dds'; hide = true }; -- Hurricane (Nereid)
    [16040] = { icon = '/esoui/art/icons/ability_wrothgar_chillingwind.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 0.5; tooltipValue3 = 60 }; -- Hurricane (Nereid)
    [95288] = { icon = '/esoui/art/icons/ability_wrothgar_chillingwind.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Frost; tooltipValue2 = 0.5; tooltipValue3 = 60; hideGround = true }; -- Hurricane (Nereid)
    [5254] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_punch.dds' }; -- Punch (Ogre)
    [5257] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_backhand.dds' }; -- Backhand (Ogre)
    [5881] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Smash (Ogre)
    [24948] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Smash (Ogre)
    [34627] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Smash (Ogre)
    [24949] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Smash (Ogre)
    [34614] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Smash (Ogre)
    [5256] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }; -- Shockwave (Ogre)
    [34616] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }; -- Shockwave (Ogre)
    [5349] = { hide = true; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Ogre - Shockwave)
    [6150] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Ogre)
    [8069] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds'; tooltip = Tooltips.Generic_Fear }; -- Intimidating Roar (Ogre)
    [24985] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 30 }; -- Intimidating Roar (Ogre)
    [53136] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frostbolt.dds' }; -- Frost Bolt (Ogre Shaman)
    [65434] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frostbolt.dds' }; -- Frost Bolt (Ogre Shaman)
    [53773] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frostbolt.dds' }; -- Frost Bolt (Ogre Shaman)
    [53774] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frostbolt.dds' }; -- Frost Bolt (Ogre Shaman)
    [65469] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frostbolt.dds' }; -- Frost Bolt (Ogre Shaman)
    [65470] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frostbolt.dds' }; -- Frost Bolt (Ogre Shaman)
    [53142] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_pillar.dds'; tooltip = Tooltips.Skill_Ice_Pillar }; -- Ice Pillar (Ogre Shaman)
    [74457] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_pillar.dds'; tooltip = Tooltips.Skill_Ice_Pillar }; -- Ice Pillar (Ogre Shaman)
    [34385] = { hide = true }; -- Generic AOE (Ogre Shaman)
    [53966] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_pillar.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 60 }; -- Ice Pillar Chill (Ogre Shaman)
    [54327] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frost_root.dds'; name = Abilities.Skill_Frozen; tooltip = Tooltips.Generic_Immobilize }; -- Winter's Reach (Ogre Shaman)
    [64540] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_freeze_wounds.dds' }; -- Freeze Wounds (Ogre Shaman)
    [53137] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_freeze_wounds.dds' }; -- Freeze Wounds (Ogre Shaman)
    [2986] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_lacerate.dds' }; -- Lacerate (Spriggan)
    [21582] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm.dds' }; -- Nature's Swarm (Spriggan)
    [31699] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm.dds' }; -- Nature's Swarm (Spriggan)
    [13475] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_healing_salve.dds'; tooltip = Tooltips.Skill_Healing_Salve }; -- Healing Salve (Spriggan)
    [89083] = { hide = true }; -- Healing Salve (Spriggan)
    [89084] = { hide = true }; -- Healing Salve (Spriggan)
    [89085] = { hide = true }; -- Healing Salve (Spriggan)
    [89143] = { hide = true }; -- Summon Beast (Spriggan)
    [89119] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_bear.dds'; tooltip = Tooltips.Skill_Summon_Beast }; -- Summon Beast (Spriggan)
    [89102] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_beast_tiger.dds'; tooltip = Tooltips.Skill_Summon_Beast }; -- Summon Beast (Spriggan)
    [89157] = { hide = true }; -- Summon Beast (Spriggan)
    [89158] = { hide = true }; -- Summon Beast (Spriggan)
    [89159] = { hide = true }; -- Summon Beast (Spriggan)
    [89151] = { hide = true }; -- Summon Beast (Spriggan)
    [89154] = { hide = true }; -- Summon Beast (Spriggan)
    [89160] = { hide = true }; -- Summon Beast (Spriggan)
    [89168] = { hide = true }; -- Summon Beast (Spriggan)
    [89170] = { hide = true }; -- Summon Beast (Spriggan)
    [89127] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; name = Abilities.Skill_Weakness; duration = -120; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Weakness_NPC_Summon }; -- Summon Beast (Spriggan)
    [21570] = { hide = true }; -- Backstep (Spriggan)
    [13477] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_control_beast.dds'; tooltip = Tooltips.Skill_Control_Beast }; -- Control Beast (Spriggan)
    [42793] = { hide = true }; -- Strangler: (Strangler)
    [42794] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = Abilities.Innate_Bash_Stun; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Generic_Stun }; -- Strangler: (Strangler)
    [9320] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_strike.dds' }; -- Strike (Strangler)
    [14219] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds' }; -- Spit (Strangler)
    [9346] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_strangle.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Strangle (Strangler)
    [42211] = { hide = true }; -- Strangle (Strangler)
    [9322] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_poisoned_ground.dds' }; -- Poisoned Ground (Strangler)
    [9323] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_poisoned_ground.dds' }; -- Poisoned Ground (Strangler)
    [9321] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds' }; -- Grapple (Strangler)
    [9707] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds'; tooltip = Tooltips.Generic_Stun }; -- Grapple (Strangler)
    [64132] = { hide = true }; -- Grapple Immunity (Strangler)
    [8926] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_regeneration.dds'; tooltip = Tooltips.Skill_Regeneration_Troll }; -- Regeneration (Troll)
    [61225] = { hide = true }; -- Regeneration (Troll)
    [8925] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_slap.dds' }; -- Slap (Troll)
    [44736] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds'; hide = true }; -- Swinging Cleave (Troll)
    [44737] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds' }; -- Swinging Cleave (Troll)
    [9009] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds'; hide = true }; -- Tremor (Troll)
    [9011] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds' }; -- Tremor (Troll)
    [76266] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_rip.dds' }; -- Rip (River Troll)
    [76268] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }; -- Lope (River Troll)
    [78834] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }; -- Lope (River Troll)
    [76274] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shattered_ground.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Lope (River Troll)
    [76277] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_close_wounds.dds'; tooltip = Tooltips.Skill_Close_Wounds }; -- Close Wounds (River Troll)
    [76295] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_crab_toss.dds' }; -- Crab Toss (River Troll)
    [80506] = { hide = true }; -- Crab Toss (River Troll)
    [76297] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_crab_toss.dds' }; -- Crab Toss (River Troll)
    [76298] = { hide = true }; -- Crab Toss (River Troll)
    [81045] = { hide = true }; -- Crab Toss (River Troll)
    [76300] = { hide = true }; -- Scuttle (River Troll)
    [48253] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rock_toss.dds' }; -- Rock Toss (Troll - Ranged)
    [60549] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rock_toss.dds' }; -- Rock Toss (Troll - Ranged)
    [48256] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Troll - Ranged)
    [48257] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Troll - Ranged)
    [50387] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds'; tooltip = Tooltips.Generic_Knockdown; noDuplicate = true }; -- Boulder Toss (Troll - Ranged) -- TODO: Check this still duplicates auras
    [48282] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_consuming_omen.dds' }; -- Consuming Omen (Troll - Ranged)

    [48287] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_consuming_omen.dds'; hide = true; tooltip = Tooltips.Skill_Consuming_Omen_Snare }; -- Consuming Omen (Troll - Ranged)
    [48294] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_consuming_omen.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Consuming_Omen }; -- Consuming Omen (Troll - Ranged)
    [48297] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_consuming_omen.dds' }; -- Consuming Omen (Troll - Ranged)

    [4304] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_assault.dds' }; -- Assault (Wisp)
    [18634] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_assault.dds' }; -- Assault (Wisp)
    [4309] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_dying_blast.dds' }; -- Dying Blast (Wisp)
    [64221] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_dying_blast.dds' }; -- Dying Blast (Wisp)

    [7976] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rain_of_wisps.dds' }; -- Rain of Wisps (Wispmother)
    [64211] = { hide = true }; -- Summon Wisp (Wispmother)
    [8025] = { hide = true }; -- Rain of Wisps (Wispmother)
    [19043] = { hide = true }; -- Rain of Wisps (Wispmother)
    [19050] = { hide = true }; -- Rain of Wisps (Wispmother)
    [19056] = { hide = true }; -- Rain of Wisps (Wispmother)
    [61204] = { hide = true }; -- Rain of Wisps Tracker (Wispmother)
    [19061] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rain_of_wisps.dds' }; -- Rain of Wisps (Wispmother)
    [18040] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_wispmother_clone.dds' }; -- Clone (Wispmother)
    [18049] = { hide = true }; -- Clone (Wispmother)
    [18060] = { hide = true }; -- Clone (Wispmother)

    -- Minotaur
    [75863] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_chop.dds' }; -- Chop (Minotaur)
    [75865] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_cleave.dds' }; -- Cleave (Minotaur)
    [75867] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_clobber.dds' }; -- Clobber (Minotaur)
    [80440] = { hide = true }; -- Clobber (Minotaur)
    [80014] = { hide = true }; -- Clobber (Minotaur)
    [75868] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_clobber.dds'; tooltip = Tooltips.Generic_Stun }; -- Clobber (Minotaur)
    [75917] = { icon = '/esoui/art/icons/achievement_update15_015.dds' }; -- Ram (Minotaur)
    [75921] = { icon = '/esoui/art/icons/achievement_update15_015.dds' }; -- Ram (Minotaur)
    [75919] = { icon = '/esoui/art/icons/achievement_update15_015.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Ram (Minotaur)
    [75922] = { icon = '/esoui/art/icons/achievement_update15_015.dds' }; -- Ram (Minotaur)
    [79541] = { icon = '/esoui/art/icons/achievement_update15_022.dds'; hide = true }; -- Flying Leap (Minotaur)
    [79539] = { icon = '/esoui/art/icons/achievement_update15_022.dds' }; -- Flying Leap (Minotaur)
    [75925] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_elemental_weapon.dds'; tooltip = Tooltips.Skill_Elemental_Weapon_NPC }; -- Elemental Weapon (Minotaur)
    [75928] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage_alt.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.7 }; -- Elemental Pool (Minotaur)
    [75933] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_heat_wave.dds'; hide = true }; -- Elemental Wave (Minotaur)

    -- Minotaur Shaman
    [75949] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fiery_surge.dds'; hide = true }; -- Fiery Surge (Minotaur Shaman)
    [77989] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fiery_surge.dds'; name = Abilities.Skill_Fiery_Surge; hide = true }; -- Flame Wave (Minotaur Shaman)
    [75951] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_brimstone_hailfire.dds' }; -- Brimstone Hailfire (Minotaur Shaman)
    [75953] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_brimstone_hailfire.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 0.7; tooltipValue3 = 60 }; -- Brimstone Hailfire (Minotaur Shaman)
    [75954] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_brimstone_hailfire.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 0.7; tooltipValue3 = 60; hideGround = true }; -- Brimstone Hailfire (Minotaur Shaman)
    [75955] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pillars_of_nirn.dds' }; -- Pillars of Nirn (Minotaur Shaman)
    [75980] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pillars_of_nirn.dds'; name = Abilities.Skill_Pillars_of_Nirn }; -- Pillars Eruption (Minotaur Shaman)
    [75976] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pillars_of_nirn.dds'; name = Abilities.Skill_Pillars_of_Nirn; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.7 }; -- Pillar of Nirn (Minotaur Shaman)
    [75978] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pillars_of_nirn.dds'; name = Abilities.Skill_Pillars_of_Nirn }; -- Pillar Explosion (Minotaur Shaman)
    [75994] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_armor.dds'; tooltip = Tooltips.Generic_Damage_Shield_Percent_Duration; tooltipValue2 = 75 }; -- Molten Armor (Minotaur Shaman)
    [49395] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_punch.dds'; name = Abilities.Skill_Claw }; -- Punch (Mantikora)
    [49397] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_sweep.dds' }; -- Spear Sweep (Mantikora)
    [49499] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds' }; -- Spear Throw (Mantikora)
    [49505] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds' }; -- Spear Throw (Mantikora)
    [49500] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Spear Throw (Mantikora)
    [49404] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_rear_up.dds' }; -- Rear Up (Mantikora)
    [49406] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_rear_up.dds' }; -- Rear Up (Mantikora)
    [49405] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Rear Up (Mantikora)
    [49402] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_tail_whip.dds' }; -- Tail Whip (Mantikora)
    [49403] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_tail_whip.dds' }; -- Tail Whip (Mantikora)
    [51242] = { hide = true }; -- Enrage (Mantikora)
    [50187] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; tooltip = Tooltips.Generic_Enrage_No_Dur; tooltipValue2 = 20 }; -- Enrage (Mantikora)
    [56687] = { hide = true }; -- Enrage (Mantikora)
    [56688] = { hide = true }; -- Enrage (Mantikora)
    [87712] = { hide = true }; -- Enraged (Mantikora)
    [56689] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; tooltip = Tooltips.Generic_Enrage_No_Dur; tooltipValue2 = 20 }; -- Enraged (Mantikora)

    -- Yaghra Strider
    [103777] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds' }; -- Lacerate (Yaghra Strider)
    [103778] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds' }; -- Lacerate (Yaghra Strider)
    [105432] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds' }; -- Lacerate (Yaghra Strider)
    [105433] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds' }; -- Lacerate (Yaghra Strider)
    [103780] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds'; name = Abilities.Skill_Lacerate; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 0.5 }; -- Bleeding Laceratation (Yaghra Strider)
    [104479] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_reave.dds' }; -- Reave (Yaghra Strider)
    [104509] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_reave.dds'; hide = true }; -- Reave (Yaghra Strider)
    [104508] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_reave.dds'; tooltip = Tooltips.Generic_Knockback }; -- Reave (Yaghra Strider)
    [105214] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lunge.dds' }; -- Lunge (Yaghra Strider)
    [105285] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lunge.dds' }; -- Lunge (Yaghra Strider)
    [105330] = { icon = '/esoui/art/icons/ability_warrior_025.dds' }; -- Frenzy (Yaghra Strider)

    -- Yaghra Spewer
    [103776] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_slash.dds' }; -- Slash (Yaghra Spewer)
    [103775] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_chop.dds' }; -- Chop (Yaghra Spewer)
    [103784] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pin.dds'; tooltip = Tooltips.Skill_Agonizing_Fury }; -- Dazed Snare (Yaghra Spewer)
    [103786] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds' }; -- Purge (Yaghra Spewer)
    [103804] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_damage.dds'; hide = true }; -- Deluge (Yaghra Spewer)
    [103862] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_damage.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.7; groundLabel = true }; -- Deluge (Yaghra Spewer)
    [103864] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_snare.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Deluge (Yaghra Spewer)
    [103931] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds' }; -- Luminescent Mark (Yaghra Spewer)
    [103958] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds'; hide = true }; -- Luminescent Mark (Yaghra Spewer)
    [103957] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds'; tooltip = Tooltips.Generic_Knockback }; -- Luminescent Mark (Yaghra Spewer)
    [103992] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_magic.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.7; groundLabel = true }; -- Luminescent Burn (Yaghra Spewer)

    -- Undead
    [38829] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_defile_damage.dds'; name = Abilities.Skill_Desecrated_Ground; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 2 }; -- Desecrated Ground Bonus
    [38834] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_defile_snare.dds'; name = Abilities.Skill_Desecrated_Ground; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Magic; tooltipValue2 = 2; tooltipValue3 = 85; hideGround = true }; -- Desecrated Ground Snare (Desecrated Ground - Undead Synergy)
    [69950] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_defile_snare.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Magic; tooltipValue2 = 2; tooltipValue3 = 85 }; -- Desecrated Ground (Desecrated Ground - Undead Synergy)
    [8550] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_slash.dds' }; -- Slash (Bloodfiend)
    [8551] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_slash.dds' }; -- Slash (Bloodfiend)
    [8564] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_rending_slash.dds' }; -- Rending Slash (Bloodfiend)
    [8554] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_flurry.dds' }; -- Flurry (Bloodfiend)
    [9194] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_flurry.dds' }; -- Flurry (Bloodfiend)
    [8569] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_devastating_leap.dds' }; -- Devastating Leap (Bloodfiend)
    [32023] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Generic Stagger Enemy (Bloodfiend)

    -- Bone Colossus
    [5028] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_strike.dds' }; -- Strike (Bone Colossus)
    [5050] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds'; name = Abilities.Skill_Colossal_Stomp }; -- Bone Saw (Bone Colossus)
    [30590] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds'; name = Abilities.Skill_Colossal_Stomp }; -- Bone Saw (Bone Colossus)
    [17206] = { name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Bone Saw (Bone Colossus)
    [5044] = { hide = true }; -- Risen Dead (Bone Colossus)
    [5030] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_voice_to_wake_the_dead.dds' }; -- Voice to Wake the Dead (Bone Colossus)
    [17221] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }; -- Slap (Bone Colossus - Risen Dead)
    [17207] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds'; hide = true }; -- Necromantic Implosion (Bone Colossus - Risen Dead)
    [88828] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds' }; -- Necromantic Implosion (Bone Colossus - Risen Dead)
    [89533] = { hide = true }; -- Necromantic Implosion (Bone Colossus - Risen Dead)

    -- Ghost
    [8812] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds' }; -- Double Strike (Ghost)
    [8813] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds' }; -- Double Strike (Ghost)
    [18514] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_chill_touch.dds' }; -- Chill Touch (Ghost)
    [18515] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_chill_touch.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Chill Touch (Ghost)
    [18765] = { hide = true }; -- Haunting Spectre (Ghost)
    [19137] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds' }; -- Haunting Spectre (Ghost)
    [19138] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds' }; -- Haunting Spectre (Ghost)
    [19140] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds'; tooltip = Tooltips.Generic_Fear }; -- Haunting Spectre (Ghost)
    [9541] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_bolt.dds' }; -- Necrotic Spear (Lich)
    [22521] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds' }; -- Defiled Ground (Lich)
    [20812] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Magic; tooltipValue2 = 1; tooltipValue3 = 70 }; -- Defiled Ground (Lich)
    [22525] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Magic; tooltipValue2 = 1; tooltipValue3 = 70; hideGround = true }; -- Defiled Ground (Lich)
    [73925] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds'; hide = true }; -- Soul Cage (Lich)
    [73929] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Soul Cage (Lich)
    [73931] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds' }; -- Soul Rupture (Lich)
    [73926] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds'; name = Abilities.Skill_Soul_Rupture; tooltip = Tooltips.Generic_Stun }; -- Soul Cage (Lich)
    [73937] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Soul Cage (Lich)
    [73939] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds' }; -- Soul Rupture (Lich)
    [73934] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds'; name = Abilities.Skill_Soul_Rupture; tooltip = Tooltips.Generic_Stun }; -- Soul Cage (Lich)
    [49702] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_flare.dds' }; -- Entropic Flare (Spellfiend)
    [50456] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_flare.dds' }; -- Entropic Flare (Spellfiend)
    [50182] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_consuming_energy.dds' }; -- Consuming Energy (Spellfiend)
    [50183] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_consuming_energy.dds' }; -- Consuming Energy (Spellfiend)
    [52398] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_consuming_energy.dds'; tooltip = Tooltips.Generic_Stun }; -- Consuming Energy (Spellfiend)
    [68735] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds'; tooltip = Tooltips.Skill_Vampiric_Drain_NPC }; -- Vampiric Drain (Vampire)
    [68750] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds'; hide = true }; -- Vampiric Drain (Vampire)
    [68765] = { hide = true }; -- Vampiric Drain (Vampire)
    [68771] = { hide = true }; -- Vampiric Drain (Vampire)
    [68772] = { hide = true }; -- Vampiric Drain (Vampire)
    [2849] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_claw_slash.dds' }; -- Claw Slash (Werewolf)
    [4651] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_claw_slash.dds' }; -- Claw Slash (Werewolf)
    [2850] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }; -- Swipe (Werewolf)
    [2867] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_crushing_leap.dds' }; -- Crushing Leap (Werewolf)
    [45576] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Generic Stagger Enemy (Werewolf)
    [3415] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds'; hide = true }; -- Flurry (Werewolf)
    [13950] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Flurry (Werewolf)
    [9467] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }; -- Flurry (Werewolf)
    [60636] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }; -- Flurry (Werewolf)
    [44055] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds'; tooltip = Tooltips.Generic_HoT_Channel; tooltipValue2 = 1 }; -- Devour (Werewolf)
    [5785] = { icon = '/esoui/art/icons/mos_dagrund_upheavel.dds' }; -- Blood Scent (Werewolf)

    -- Wraith
    [4323] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow_small.dds' }; -- Ice Bolt (Wraith)
    [4337] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_winters_reach.dds' }; -- Winter's Reach (Wraith)
    [4346] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_winters_reach.dds' }; -- Winter's Reach (Wraith)
    [43146] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_winters_reach.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Winter's Reach (Wraith)

    -- Zombie
    [2954] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }; -- Swipe (Zombie)
    [13972] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }; -- Swipe (Zombie)
    [63614] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }; -- Swipe (Zombie)
    [2969] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }; -- Pound (Zombie)
    [2960] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }; -- Vomit (Zombie)
    [30347] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }; -- Vomit (Zombie)
    [72980] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_singing_strike.dds' }; -- Singing Strike (Defiled Aegis)
    [72981] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_singing_strike.dds' }; -- Singing Strike (Defiled Aegis)
    [72979] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_dissonant_blow.dds' }; -- Dissonant Blow (Defiled Aegis)
    [72995] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_symphony_of_blades.dds' }; -- Symphony of Blades (Defiled Aegis)
    [72996] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_symphony_of_blades.dds'; hide = true }; -- Symphony of Blades (Defiled Aegis)
    [73020] = { hide = true }; -- Shattered Harmoney (Defiled Aegis)
    [73021] = { hide = true }; -- Shattered Harmony (Defiled Aegis)
    [76180] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_summon_defiled_aegis.dds' }; -- Shattered Harmony (Defiled Aegis)
    [73025] = { hide = true }; -- Tomb Guardian (Defiled Aegis)
    [73322] = { hide = true }; -- Shattered Harmony (Defiled Aegis)
    [74993] = { hide = true }; -- Shattered Harmony (Defiled Aegis)

    -- Vvardenfell NPC'S
    [88361] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fright_force_orange.dds'; hide = true }; -- Vile Flare (Skaafin Masquer)
    [88327] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadeway_orange.dds' }; -- Shadeway (Skaafin Masquer)
    [88339] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadeway_orange.dds'; hide = true }; -- Shadeway (Skaafin Masquer)
    [88341] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadeway_orange.dds'; tooltip = Tooltips.Generic_Stun }; -- Shadeway (Skaafin Masquer)
    [88325] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pool_of_shadow_orange.dds'; hide = true }; -- Pool of Shadow (Skaafin Masquer)
    [88336] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pool_of_shadow_orange.dds' }; -- Pool of Shadow (Skaafin Masquer)
    [88330] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pool_of_shadow_orange.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Pool of Shadow (Skaafin Masquer)
    [88335] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pool_of_shadow_orange.dds' }; -- Pool of Shadow (Skaafin Masquer)
    [88334] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pool_of_shadow_orange.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Pool of Shadow (Skaafin Masquer)
    [88353] = { hide = true }; -- Shadowy Duplicate (Skaafin Masquer)
    [88358] = { hide = true }; -- Shadowy Duplicate (Skaafin Masquer)
    [88348] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowy_duplicate_orange.dds'; tooltip = Tooltips.Skill_Shadowy_Duplicate }; -- Shadowy Duplicate (Skaafin Masquer)
    [88350] = { hide = true }; -- Shadowy Duplicate (Skaafin Masquer)
    [88346] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowy_barrier_orange.dds'; name = Abilities.Skill_Shadowy_Barrier; duration = 295; tooltip = Tooltips.Skill_Shadowy_Barrier }; -- Shadowy Duplicate (Skaafin Masquer)
    [88342] = { hide = true }; -- Shadowy Duplicate (Skaafin Masquer)
    [88383] = { hide = true }; -- Shadowy Duplicate (Skaafin Masquer)
    [88351] = { hide = true }; -- Shadowy Duplicate (Skaafin Masquer)
    [88349] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowy_barrier_orange.dds' }; -- Shadowy Duplicate (Skaafin Masquer)
    [88354] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowy_barrier_orange.dds'; tooltip = Tooltips.Generic_Stun }; -- Shadowy Duplicate (Skaafin Masquer)
    [81545] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fright_force.dds'; hide = true }; -- Fright Force (Malacath Voidbringer)
    [76621] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadeway_red.dds' }; -- Shadeway (Malacath Voidbringer)
    [76784] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadeway_red.dds'; hide = true }; -- Shadeway (Malacath Voidbringer)
    [76619] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pool_of_shadow_red.dds'; hide = true }; -- Pool of Shadow (Malacath Voidbringer)
    [76624] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pool_of_shadow_red.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Pool of Shadow (Malacath Voidbringer)
    [76728] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pool_of_shadow_red.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Pool of Shadow (Malacath Voidbringer)
    [77005] = { hide = true }; -- Shadowy Duplicate (Malacath Voidbringer)
    [76979] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowy_duplicate_red.dds'; tooltip = Tooltips.Skill_Shadowy_Duplicate }; -- Shadowy Duplicate (Malacath Voidbringer)
    [76995] = { hide = true }; -- Shadowy Duplicate (Malacath Voidbringer)
    [76955] = { hide = true }; -- Shadowy Duplicate (Malacath Voidbringer)
    [76996] = { hide = true }; -- Shadowy Duplicate (Malacath Voidbringer)
    [76985] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowy_barrier_red.dds' }; -- Shadowy Duplicate (Malacath Voidbringer)
    [77009] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowy_barrier_red.dds'; tooltip = Tooltips.Generic_Stun }; -- Shadowy Duplicate (Malacath Voidbringer)
    [84817] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_skaafin_flare.dds' }; -- Skaafin Flare (Skaafin Witchling)
    [84815] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_skaafin_flare.dds' }; -- Skaafin Flare (Skaafin Witchling)
    [84818] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fiendish_healing.dds'; tooltip = Tooltips.Skill_Fiendish_Healing }; -- Fiendish Healing (Skaafin Witchling)
    [84829] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 20 }; -- Fiendish Healing (Skaafin Witchling)
    [84833] = { hide = true }; -- Fiendish Healing (Skaafin Witchling)
    [84835] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_broken_pact.dds' }; -- Broken Pact (Skaafin Witchling)
    [84837] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_broken_pact.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Broken Pact (Skaafin Witchling)
    [77020] = { hide = true }; -- Basilisk Powder (Tracker)
    [77089] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_basilisk_powder.dds' }; -- Basilisk Powder (Tracker)
    [77087] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_basilisk_powder.dds'; hide = true }; -- Basilisk Powder (Tracker)
    [79954] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_basilisk_powder.dds'; tooltip = Tooltips.Generic_Stun }; -- Basilisk Powder (Tracker)
    [77019] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pin.dds'; hide = true }; -- Pin (Tracker)
    [77030] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pin.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Pin (Tracker)
    [78432] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lunge.dds' }; -- Lunge (Tracker)
    [79955] = { hide = true }; -- Lunge (Tracker)
    [78435] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lunge.dds' }; -- Lunge (Tracker)
    [79930] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lunge.dds'; tooltip = Tooltips.Generic_Knockback }; -- Lunge (Tracker)
    [79929] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lunge.dds' }; -- Lunge (Tracker)
    [88481] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_spectral_claw.dds' }; -- Spectral Claw (Beastcaller)
    [88478] = { icon = '/esoui/art/icons/ability_warden_014.dds'; hide = true }; -- Swarm (Beastcaller)
    [88371] = { icon = '/esoui/art/icons/ability_warden_013.dds' }; -- Dive (Beastcaller)
    [88393] = { icon = '/esoui/art/icons/ability_warden_013.dds' }; -- Dive (Beastcaller)
    [88394] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_gore.dds' }; -- Gore (Beastcaller)
    [88400] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_gore.dds'; hide = true }; -- Gore (Beastcaller)
    [88409] = { icon = '/esoui/art/icons/ability_warden_018.dds'; name = Abilities.Skill_Feral_Guardian; tooltip = Tooltips.Skill_Feral_Guardian_NPC }; -- Raise the Earth (Beastcaller)
    [92303] = { hide = true }; -- Despawn Override (Beastcaller)
    [92158] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds'; name = Abilities.Skill_Weakness; duration = -60; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Weakness_NPC_Summon }; -- Raise the Earth (Beastcaller)
    [87854] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quick_shot.dds'; hide = true }; -- Quick Shot
    [87855] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_arrow_stab.dds' }; -- Arrow Stab (Arbalest)
    [87901] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bombard.dds' }; -- Bombard (Arbalest)
    [90399] = { hide = true }; -- Bombard (Arbalest)
    [87902] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bombard.dds'; hide = true }; -- Bombard (Arbalest)
    [87713] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quakeshot.dds' }; -- Quakeshot (Arbalest)
    [87837] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_quakeshot.dds' }; -- Quakeshot (Arbalest)
    [87852] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_quakeshot.dds' }; -- Quakeshot (Arbalest)
    [87422] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frost_arrow.dds' }; -- Chilled Ground (Arbalest)
    [87491] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_snare.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 40 }; -- Chilled Ground (Arbalest)
    [86881] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }; -- Hack (Sixth House Supplicant)
    [86882] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }; -- Hack (Sixth House Supplicant)
    [86883] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }; -- Slash (Sixth House Supplicant)
    [86884] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }; -- Slash (Sixth House Supplicant)
    [85342] = { icon = '/esoui/art/icons/ability_dualwield_001.dds' }; -- Twin Slashes (Sixth House Supplicant)
    [85343] = { icon = '/esoui/art/icons/ability_dualwield_001.dds' }; -- Twin Slashes (Sixth House Supplicant)
    [85368] = { icon = '/esoui/art/icons/ability_dualwield_001.dds'; name = Abilities.Skill_Twin_Slashes; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Twin Slashes Bleed (Sixth House Supplicant)
    [86879] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_light.dds' }; -- Chop (Drudge)
    [86880] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_light.dds' }; -- Hack (Drudge)
    [85359] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_heavy.dds'; name = Abilities.Skill_Clobber }; -- Reverse Slash (Drudge)
    [85365] = { hide = true }; -- Assassinate Bonus (Drudge)
    [86704] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_pickaxe_light.dds' }; -- Chop (Hleran Noble)
    [86705] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_pickaxe_light.dds' }; -- Lop (Hleran Noble)
    [85361] = { icon = '/esoui/art/icons/ability_1handed_002.dds' }; -- Puncture (Hleran Noble)
    [87064] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris (Fire-Binder)
    [87065] = { hide = true }; -- Volcanic Debris (Fire-Binder)
    [92647] = { hide = true }; -- Volcanic Debris (Fire-Binder)
    [87069] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds'; hide = true }; -- Volcanic Debris (Fire-Binder)
    [87068] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds'; tooltip = Tooltips.Generic_Knockback }; -- Volcanic Debris (Fire-Binder)
    [87066] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris (Fire-Binder)
    [88845] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_empower_atronach.dds'; tooltip = Tooltips.Generic_HoT_Channel; tooltipValue2 = 1 }; -- Empower Atronach (Fire-Binder)

    ----------------------------------------------------------------
    -- EVENT QUESTS ------------------------------------------------
    ----------------------------------------------------------------

    ----------------------------------------------------------------
    -- Jester's Festival
    ----------------------------------------------------------------

    -- Springtime Flair
    [87474] = { icon = 'LuiExtended/media/icons/mementos/memento_cherry_blossom_branch.dds'; name = Abilities.Event_Petal_Pelters }; -- Flower Garland -- Springtime Flair

    -- Royal Revelry
    [88095] = { icon = 'LuiExtended/media/icons/abilities/ability_item_dazzler_3.dds'; name = Abilities.Event_Sparkle_Dazzler }; -- Illusion Dazzler - Royal Revelry
    [88123] = { icon = 'LuiExtended/media/icons/abilities/ability_item_dazzler_2.dds'; name = Abilities.Event_Burst_Dazzler }; -- Illusion Dazzler - Royal Revelry
    [88124] = { icon = 'LuiExtended/media/icons/abilities/ability_item_dazzler_1.dds'; name = Abilities.Event_Flash_Dazzler }; -- Illusion Dazzler - Royal Revelry

    -- A Foe Most Porcine
    [127194] = { hide = true }; -- Uproot (King Boar) - A Foe Most Porcine
    [145282] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grease_slip.dds'; name = Abilities.Skill_Grease_Slip }; -- Grease Shake (King Boar) - A Foe Most Porcine
    [146018] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grease_slip.dds'; name = Abilities.Skill_Grease_Slip }; -- Grease Shake (King Boar) - A Foe Most Porcine
    [143695] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grease_slip.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Grease Slip (King Boar) - A Foe Most Porcine
    [144135] = { hide = true }; -- Greased Hands (King Boar) - A Foe Most Porcine
    [145861] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_grease_snare.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Greased Footing (King Boar) - A Foe Most Porcine

    [126947] = { hide = true }; -- Thrash (Prince Boar) - A Foe Most Porcine
    [144351] = { hide = true }; -- Thrash (Prince Boar) - A Foe Most Porcine

    --[144340] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds' }, -- Thrash (Prince Boar) - A Foe Most Porcine
    --[144338] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = Abilities.Skill_Thrash }, -- Knockback (Prince Boar) - A Foe Most Porcine
    --[144337] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = Abilities.Skill_Thrash, tooltip = Tooltips.Generic_Knockback }, -- Stun (Prince Boar) - A Foe Most Porcine
    --[144339] = { name = Abilities.Innate_Stagger, tooltip = Tooltips.Generic_Stagger, cc = LUIE_CC_TYPE_STAGGER }, -- Staggered (Prince Boar) - A Foe Most Porcine

    ----------------------------------------------------------------
    -- New Life Festival
    ----------------------------------------------------------------

    -- Stonetooth Bash
    [84847] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_celebratory_belch.dds'; name = Abilities.Skill_Celebratory_Belch; unbreakable = 1 }; -- Celebratory Belch (Stonetooth Bash)

    -- Snow Bear Plunge
    [83523] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_frigid_waters.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Event_Freezing }; -- Freezing (Snow Bear Plunge)
    [83522] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_warmth.dds'; forcedContainer = 'short'; tooltip = Tooltips.Event_Warm }; -- Warm (Snow Bear Plunge)

    -- Lava Foot Stomp
    [84125] = { icon = '/esoui/art/icons/achievement_newlifefestival_002.dds'; name = Abilities.Skill_Lava_Foot_Stomp; unbreakable = 1 }; -- Breton Male Dance (Lava Foot Stomp)
    [84126] = { icon = '/esoui/art/icons/achievement_newlifefestival_002.dds'; name = Abilities.Skill_Lava_Foot_Stomp; unbreakable = 1 }; -- Breton Female Dance (Lava Foot Stomp)
    [84127] = { icon = '/esoui/art/icons/achievement_newlifefestival_002.dds'; name = Abilities.Skill_Lava_Foot_Stomp; unbreakable = 1 }; -- Dunmer Male Dance (Lava Foot Stomp)
    [84128] = { icon = '/esoui/art/icons/achievement_newlifefestival_002.dds'; name = Abilities.Skill_Lava_Foot_Stomp; unbreakable = 1 }; -- Dunmer Female Dance (Lava Foot Stomp)
    [84130] = { icon = '/esoui/art/icons/achievement_newlifefestival_002.dds'; name = Abilities.Skill_Lava_Foot_Stomp; unbreakable = 1 }; -- Altmer Male Dance (Lava Foot Stomp)
    [84131] = { icon = '/esoui/art/icons/achievement_newlifefestival_002.dds'; name = Abilities.Skill_Lava_Foot_Stomp; unbreakable = 1 }; -- Altmer Female Dance (Lava Foot Stomp)
    [84133] = { icon = '/esoui/art/icons/achievement_newlifefestival_002.dds'; name = Abilities.Skill_Lava_Foot_Stomp; unbreakable = 1 }; -- Nord Dance (Lava Foot Stomp)

    -- Castle Charm Challenge
    [84528] = { icon = 'LuiExtended/media/icons/mementos/memento_fire_breathers_torches.dds'; name = Abilities.Skill_Torch_Juggling; unbreakable = 1 }; -- Flame Juggling (Castle Charm Challenge)
    [84506] = { icon = 'LuiExtended/media/icons/mementos/memento_jugglers_knives.dds'; name = Abilities.Skill_Knife_Juggling; unbreakable = 1 }; -- Dagger Juggling (Castle Charm Challenge)
    [84533] = { icon = 'LuiExtended/media/icons/mementos/memento_sword_swallowers_blade.dds'; name = Abilities.Skill_Sword_Swallowing; unbreakable = 1 }; -- Sword Swallowing (Castle Charm Challenge)

    -- Mud Ball Merriment
    [84330] = { icon = '/esoui/art/icons/achievement_newlifefestival_001.dds'; name = Abilities.Memento_Mud_Ball }; -- Mudball (Mud Ball Merriment)

    ----------------------------------------------------------------
    -- Witches Festival
    ----------------------------------------------------------------

    -- The Witchmother's Bargain
    [83775] = { icon = 'LuiExtended/media/icons/mementos/memento_witchmothers_whistle.dds'; name = Abilities.Event_Crow_Caller }; -- Event - Q5742 WitchFest Intro (The Witchmother's Bargain)

    ----------------------------------------------------------------
    -- Pan-Elsweyr Celebration
    ----------------------------------------------------------------

    -- Misc - Dragon Attacks
    [120954] = { hide = true }; -- JusticeDragon-Flee
    [120956] = { hide = true }; -- JusticeDragon-Flee
    [120957] = { hide = true }; -- RUNJusticeDragon1
    [120958] = { hide = true }; -- COWERJusticeDragon2
    [120960] = { hide = true }; -- JusticeDragon-REG WPTReach
    [120961] = { hide = true }; -- JusticeDragon-REG WPTReach
    [120977] = { hide = true }; -- COWERJusticeDragon2
    [120980] = { hide = true }; -- JusticeDragon-Flee
    [120981] = { hide = true }; -- JusticeDragon-Flee

    ----------------------------------------------------------------
    -- CYRODIIL ----------------------------------------------------
    ----------------------------------------------------------------

    [39671] = { icon = '/esoui/art/icons/achievement_ic_024.dds'; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_emperorship_alliance_bonus.dds'; tooltip = Tooltips.Skill_Emperorship_Alliance_Bonus_I }; -- Emperorship Alliance Bonus I
    [182782] = { icon = '/esoui/art/icons/achievement_ic_024.dds'; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_emperorship_alliance_bonus.dds'; tooltip = Tooltips.Skill_Emperorship_Alliance_Bonus_II }; -- Emperorship Alliance Bonus II
    [182783] = { icon = '/esoui/art/icons/achievement_ic_024.dds'; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_emperorship_alliance_bonus.dds'; tooltip = Tooltips.Skill_Emperorship_Alliance_Bonus_III }; -- Emperorship Alliance Bonus III
    [182784] = { icon = '/esoui/art/icons/achievement_ic_024.dds'; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_emperorship_alliance_bonus.dds'; tooltip = Tooltips.Skill_Emperorship_Alliance_Bonus_IV }; -- Emperorship Alliance Bonus IV
    [182785] = { icon = '/esoui/art/icons/achievement_ic_024.dds'; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_emperorship_alliance_bonus.dds'; tooltip = Tooltips.Skill_Emperorship_Alliance_Bonus_V }; -- Emperorship Alliance Bonus V
    [182786] = { icon = '/esoui/art/icons/achievement_ic_024.dds'; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_emperorship_alliance_bonus.dds'; tooltip = Tooltips.Skill_Emperorship_Alliance_Bonus_VI }; -- Emperorship Alliance Bonus VI
    [11346] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_home_keep_bonus.dds'; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_home_keep_bonus.dds'; tooltip = Tooltips.Skill_Home_Keep_Bonus }; -- Home Keep Bonus
    [11341] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_I }; -- Enemy Keep Bonus I
    [11343] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_II }; -- Enemy Keep Bonus II
    [11345] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_III }; -- Enemy Keep Bonus III
    [11347] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_IV }; -- Enemy Keep Bonus IV
    [11348] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_V }; -- Enemy Keep Bonus V
    [11350] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_VI }; -- Enemy Keep Bonus VI
    [11352] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_VII }; -- Enemy Keep Bonus VII
    [11353] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_VIII }; -- Enemy Keep Bonus VIII
    [11356] = { icon = '/esoui/art/icons/achievement_midyearevent_008.dds'; hide = true; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds'; tooltip = Tooltips.Skill_Enemy_Keep_Bonus_IX }; -- Enemy Keep Bonus IX
    [15060] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_defensive_scroll_bonus.dds'; stack = 1; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_defensive_scroll_bonus.dds'; tooltip = Tooltips.Skill_Defensive_Scroll_Bonus_I }; -- Defensive Scroll Bonus I
    [16350] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_defensive_scroll_bonus.dds'; stack = 2; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_defensive_scroll_bonus.dds'; tooltip = Tooltips.Skill_Defensive_Scroll_Bonus_II }; -- Defensive Scroll Bonus II
    [15058] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_offensive_scroll_bonus.dds'; stack = 1; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_offensive_scroll_bonus.dds'; tooltip = Tooltips.Skill_Offensive_Scroll_Bonus_I }; -- Offensive Scroll Bonus I
    [16348] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_offensive_scroll_bonus.dds'; stack = 2; passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_offensive_scroll_bonus.dds'; tooltip = Tooltips.Skill_Offensive_Scroll_Bonus_II }; -- Offensive Scroll Bonus II
    [111549] = { name = Abilities.Skill_Edge_Keep_Bonus_I; tooltip = Tooltips.Skill_Edge_Keep_Bonus_I }; -- Edge Keep Bonus 1
    [111552] = { name = Abilities.Skill_Edge_Keep_Bonus_II; tooltip = Tooltips.Skill_Edge_Keep_Bonus_II }; -- Edge Keep Bonus 2
    [111553] = { name = Abilities.Skill_Edge_Keep_Bonus_III; tooltip = Tooltips.Skill_Edge_Keep_Bonus_III }; -- Edge Keep Bonus 3
    [66282] = { icon = '/esoui/art/icons/achievement_ic_007_c.dds'; tooltip = Tooltips.Skill_Blessing_of_War; forcedContainer = 'long' }; -- Blessing of War
    [15177] = { icon = '/esoui/art/icons/achievement_068.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_Elder_Scroll_Altadoon }; -- Elder Scroll of Altadoon
    [15178] = { icon = '/esoui/art/icons/achievement_068.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_Elder_Scroll_Mnem }; -- Elder Scroll of Mnem
    [22282] = { icon = '/esoui/art/icons/achievement_068.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_Elder_Scroll_Ghartok }; -- Elder Scroll of Ghartok
    [22295] = { icon = '/esoui/art/icons/achievement_068.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_Elder_Scroll_Chim }; -- Elder Scroll of Chim
    [22297] = { icon = '/esoui/art/icons/achievement_068.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_Elder_Scroll_Ni_Mohk }; -- Elder Scroll of Ni-Mohk
    [22299] = { icon = '/esoui/art/icons/achievement_068.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_Elder_Scroll_Alma_Ruma }; -- Elder Scroll of Alma Ruma
    [109862] = { hide = true }; -- Stronger Walls
    [109944] = { hide = true }; -- Stronger Doors
    [64674] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_vigilance.dds'; name = Abilities.Skill_Guard_Detection; tooltip = Tooltips.Skill_Guard_Detection }; -- Cyrodiil Guard See Stealth
    [8077] = { hide = true }; -- Increased Guard Health
    [8639] = { hide = true }; -- Increased Damage
    [43754] = { hide = true }; -- Heavily Resistant Guards
    [8657] = { hide = true }; -- Heavily Armored Guards
    [8658] = { hide = true }; -- Eagle Eye Guards
    [25873] = { hide = true }; -- heal
    [64197] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_sanctuary.dds'; forcedContainer = 'short'; tooltip = Tooltips.Skill_AvA_Sanctuary }; -- Sanctuary Cyrodiil passive is considered unlimited duration, but the effect is only while the player is in the area. Should show up under short buffs.
    [52291] = { hide = true }; -- Chain Pull Range Suppression
    [96091] = { hide = true }; -- Frozen Gate Suppression
    [97414] = { hide = true }; -- Nature Grasp Suppression
    [90095] = { hide = true }; -- Falling Damage Reduction

    -- Siege Weapons

    [12256] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_pack_siege.dds'; name = Abilities.Skill_Stow_Siege_Weapon }; -- Pack Siege (Generic Siege)
    [29673] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Ballista) }; -- Create Ballista Bolt... (Ballista)
    [29672] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Ballista) }; -- Create Ballista Bolt... (Ballista)
    [29671] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Ballista) }; -- Create Ballista Bolt... (Ballista)
    [7468] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_ballista_bolt.dds'; name = Abilities.Skill_Ballista }; -- Ballista Bolt (Ballista)
    [7469] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_ballista_bolt.dds'; name = Abilities.Skill_Ballista }; -- Ballista Bolt (Ballista)
    [13043] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_ballista_bolt.dds'; name = Abilities.Skill_Ballista }; -- Ballista Bolt (Ballista)
    [30611] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Fire_Ballista) }; -- Create Ballista Fire Bolt... (Fire Ballista)
    [30607] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Fire_Ballista) }; -- Create Ballista Fire Bolt... (Fire Ballista)
    [16751] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Fire_Ballista) }; -- Create Ballista Fire Bolt... (Fire Ballista)
    [16775] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_fire_ballista_bolt.dds'; name = Abilities.Skill_Fire_Ballista }; -- Fire Ballista Bolt (Fire Ballista)
    [28480] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_fire_ballista_bolt.dds'; name = Abilities.Skill_Fire_Ballista; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Fire Ballista Bolt (Fire Ballista)
    [14367] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_fire_ballista_bolt.dds'; name = Abilities.Skill_Fire_Ballista }; -- Fire Ballista Bolt (Fire Ballista)
    [30612] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Lightning_Ballista) }; -- Create Ballista Lightning Bolt ... (Lightning Ballista)
    [30608] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Lightning_Ballista) }; -- Create Ballista Lightning Bolt ... (Lightning Ballista)
    [16752] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Lightning_Ballista) }; -- Create Ballista Lightning Bolt ... (Lightning Ballista)
    [14363] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_lightning_ballista_bolt.dds'; name = Abilities.Skill_Lightning_Ballista }; -- Lightning Ballista Bolt (Lightning Ballista)
    [14364] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_lightning_ballista_bolt.dds'; name = Abilities.Skill_Lightning_Ballista; tooltip = Tooltips.Skill_Lightning_Ballista_Bolt; cc = LUIE_CC_TYPE_SNARE }; -- Lightning Ballista Bolt (Lightning Ballista)
    [16776] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_lightning_ballista_bolt.dds'; name = Abilities.Skill_Lightning_Ballista }; -- Lightning Ballista Bolt (Lightning Ballista)
    [76103] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_lightning_ballista_bolt.dds'; name = Abilities.Skill_Lightning_Ballista }; -- Magicka Hit (Lightning Ballista)
    [30454] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_lightning_ballista_bolt.dds'; name = Abilities.Skill_Lightning_Ballista }; -- Lightning Ballista Bolt (Lightning Ballista)
    [39914] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Stone_Trebuchet) }; -- Create Trebuchet... (Stone Trebuchet)
    [39917] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Stone_Trebuchet) }; -- Create Trebuchet... (Stone Trebuchet)
    [39910] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Stone_Trebuchet) }; -- Create Trebuchet... (Stone Trebuchet)
    [14159] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_stone_trebuchet.dds' }; -- Stone Trebuchet (Stone Trebuchet)
    [64109] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_stone_trebuchet.dds' }; -- Stone Trebuchet (Stone Trebuchet)
    [14160] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_stone_trebuchet.dds' }; -- Stone Trebuchet (Stone Trebuchet)
    [39913] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Iceball_Trebuchet) }; -- Create Trebuchet... (Iceball Trebuchet)
    [39916] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Iceball_Trebuchet) }; -- Create Trebuchet... (Iceball Trebuchet)
    [39909] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Iceball_Trebuchet) }; -- Create Trebuchet... (Iceball Trebuchet)
    [13551] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_iceball_trebuchet.dds' }; -- Iceball Trebuchet (Iceball Trebuchet)
    [64105] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_iceball_trebuchet.dds' }; -- Iceball Trebuchet (Iceball Trebuchet)
    [13588] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_iceball_trebuchet.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50; cc = LUIE_CC_TYPE_SNARE }; -- Iceball Trebuchet (Iceball Trebuchet)
    [13552] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_iceball_trebuchet.dds' }; -- Iceball Trebuchet (Iceball Trebuchet)
    [13665] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Firepot_Trebuchet) }; -- Create Trebuchet... (Firepot Trebuchet)
    [13664] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Firepot_Trebuchet) }; -- Create Trebuchet... (Firepot Trebuchet)
    [13663] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Firepot_Trebuchet) }; -- Create Trebuchet... (Firepot Trebuchet)
    [7010] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_firepot_trebuchet.dds' }; -- Firepot Trebuchet (Firepot Trebuchet)
    [7429] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_firepot_trebuchet.dds' }; -- Firepot Trebuchet (Firepot Trebuchet)
    [28483] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_firepot_trebuchet.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Firepot Trebuchet (Firepot Trebuchet)
    [25869] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_firepot_trebuchet.dds' }; -- Firepot Trebuchet (Firepot Trebuchet)
    [30613] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Meatbag_Catapult) }; -- Create Catapult Meatbag (Meatbag Catapult)
    [30609] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Meatbag_Catapult) }; -- Create Catapult Meatbag (Meatbag Catapult)
    [16755] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Meatbag_Catapult) }; -- Create Catapult Meatbag (Meatbag Catapult)
    [88714] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds'; name = Abilities.Skill_Meatbag_Catapult; tooltip = Tooltips.Skill_Meatbag_Catapult_Ground }; -- Meatbag (Meatbag Catapult)
    [14774] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds' }; -- Meatbag Catapult (Meatbag Catapult)
    [104693] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds'; tooltip = Tooltips.Skill_Meatbag_Catapult_AOE; groundLabel = true }; -- Meatbag Catapult (Meatbag Catapult)
    [32035] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds'; tooltip = Tooltips.Generic_Reduce_Healing_Received; tooltipValue2 = 50 }; -- Meatbag Catapult (Meatbag Catapult)

    [36408] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds' }; -- Meatbag Catapult (Meatbag Catapult)
    [30614] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Oil_Catapult) }; -- Create Catapult Oil Jar... (Oil Catapult)
    [30610] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Oil_Catapult) }; -- Create Catapult Oil Jar... (Oil Catapult)
    [16754] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Oil_Catapult) }; -- Create Catapult Oil Jar... (Oil Catapult)
    [104700] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_oil_snare.dds'; name = Abilities.Skill_Oil_Catapult; tooltip = Tooltips.Skill_Oil_Catapult_Ground }; -- Twisting Path (Oil Catapult)
    [16789] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_oil_catapult.dds' }; -- Oil Catapult (Oil Catapult)
    [104699] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_oil_snare.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50; cc = LUIE_CC_TYPE_SNARE }; -- Oil Catapult (Oil Catapult)
    [64108] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_oil_catapult.dds' }; -- Oil Catapult (Oil Catapult)
    [76105] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_oil_catapult.dds'; name = Abilities.Skill_Oil_Catapult }; -- Stamina Hit (Oil Catapult)
    [16790] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_oil_catapult.dds' }; -- Oil Catapult (Oil Catapult)
    [39915] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Scattershot_Catapult) }; -- Create Catapult Meatbag (Scattershot Catapult)
    [39918] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Scattershot_Catapult) }; -- Create Catapult Oil Jar... (Scattershot Catapult)
    [39911] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_catapult.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Scattershot_Catapult) }; -- Create Trebuchet... (Scattershot Catapult)
    [104690] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_scattershot_catapult.dds'; name = Abilities.Skill_Scattershot_Catapult; tooltip = Tooltips.Skill_Scattershot_Catapult_Ground }; -- Twisting Path (Scattershot Catapult)
    [14611] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_scattershot_catapult.dds' }; -- Scattershot Catapult (Scattershot Catapult)
    [104695] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_scattershot_catapult.dds'; tooltip = Tooltips.Skill_Scattershot_Catapult_AOE; groundLabel = true }; -- Scattershot Catapult (Scattershot Catapult)
    [104696] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_scattershot_catapult.dds'; tooltip = Tooltips.Generic_Increase_Damage_Taken; tooltipValue2 = 25 }; -- Scattershot Catapult (Scattershot Catapult)
    [66438] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_stone_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Cold_Stone_Trebuchet) }; -- Create Trebuchet... (Cold Stone Trebuchet)
    [66439] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_stone_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Cold_Stone_Trebuchet) }; -- Create Trebuchet... (Cold Stone Trebuchet)
    [66440] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_stone_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Cold_Stone_Trebuchet) }; -- Create Trebuchet... (Cold Stone Trebuchet)
    [66250] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_stone_trebuchet_shot.dds'; name = Abilities.Skill_Cold_Stone_Trebuchet }; -- Stone Cold Trebuchet (Cold Stone Trebuchet)
    [66251] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_stone_trebuchet_shot.dds'; name = Abilities.Skill_Cold_Stone_Trebuchet }; -- Stone Cold Trebuchet (Cold Stone Trebuchet)
    [66252] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_stone_trebuchet_shot.dds'; name = Abilities.Skill_Cold_Stone_Trebuchet }; -- Stone Cold Trebuchet (Cold Stone Trebuchet)
    [66434] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_fire_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Cold_Fire_Trebuchet) }; -- Create Trebuchet... (Cold Fire Trebuchet)
    [66388] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_fire_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Cold_Fire_Trebuchet) }; -- Create Trebuchet... (Cold Fire Trebuchet)
    [66387] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_fire_trebuchet.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Cold_Fire_Trebuchet) }; -- Create Trebuchet... (Cold Fire Trebuchet)
    [66246] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_fire_trebuchet_shot.dds'; name = Abilities.Skill_Cold_Fire_Trebuchet }; -- Firepot Trebuchet (Cold Fire Trebuchet)
    [66247] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_fire_trebuchet_shot.dds'; name = Abilities.Skill_Cold_Fire_Trebuchet }; -- Firepot Trebuchet (Cold Fire Trebuchet)
    [66248] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_fire_trebuchet_shot.dds'; name = Abilities.Skill_Cold_Fire_Trebuchet }; -- Firepot Trebuchet (Cold Fire Trebuchet)
    [66245] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_fire_trebuchet_shot.dds'; name = Abilities.Skill_Cold_Fire_Trebuchet; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Cold Harbor Trebuchet (Cold Fire Trebuchet)
    [66437] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_fire_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Cold_Fire_Ballista) }; -- Create Ballista... (Cold Fire Ballista)
    [66436] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_fire_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Cold_Fire_Ballista) }; -- Create Ballista... (Cold Fire Ballista)
    [66435] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_cold_fire_ballista.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Cold_Fire_Ballista) }; -- Create Ballista... (Cold Fire Ballista)
    [66242] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_fire_ballista_bolt.dds'; name = Abilities.Skill_Cold_Fire_Ballista }; -- Fire Ballista Bolt (Cold Fire Ballista)
    [66244] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_fire_ballista_bolt.dds'; name = Abilities.Skill_Cold_Fire_Ballista }; -- Fire Ballista Bolt (Cold Fire Ballista)
    [66243] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_cold_fire_ballista_bolt.dds'; name = Abilities.Skill_Cold_Fire_Ballista; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Cold Harbor Ballista Bolt (Cold Fire Ballista)
    [135862] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_shock_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Shock_Lancer) }; -- Create Lance Cannon... (Shock Lancer)
    [135861] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_shock_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Shock_Lancer) }; -- Create Lance Cannon... (Shock Lancer)
    [135860] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_shock_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Shock_Lancer) }; -- Create Lance Cannon... (Shock Lancer)
    [138556] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_shock_lancer.dds' }; -- Shock Lancer (Shock Lancer)
    [138558] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_shock_lancer.dds' }; -- Shock Lancer (Shock Lancer)
    [138557] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_shock_lancer.dds' }; -- Shock Lancer (Shock Lancer)
    [135859] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_fire_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Fire_Lancer) }; -- Create Lance Cannon... (Fire Lancer)
    [135858] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_fire_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Fire_Lancer) }; -- Create Lance Cannon... (Fire Lancer)
    [135836] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_fire_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Fire_Lancer) }; -- Create Lance Cannon... (Fire Lancer)
    [138434] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_fire_lancer.dds' }; -- Shock Lancer (Fire Lancer)
    [138436] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_fire_lancer.dds' }; -- Shock Lancer (Fire Lancer)
    [138435] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_fire_lancer.dds' }; -- Shock Lancer (Fire Lancer)
    [135868] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_frost_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Frost_Lancer) }; -- Create Lance Cannon... (Frost Lancer)
    [135867] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_frost_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Frost_Lancer) }; -- Create Lance Cannon... (Frost Lancer)
    [135866] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_frost_lancer.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Frost_Lancer) }; -- Create Lance Cannon... (Frost Lancer)
    [138552] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_frost_lancer.dds' }; -- Frost Lancer (Fire Lancer)
    [138554] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_frost_lancer.dds' }; -- Frost Lancer (Fire Lancer)
    [138553] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_frost_lancer.dds' }; -- Frost Lancer (Fire Lancer)
    [22570] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_flaming_oil.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Deploy, Abilities.Skill_Flaming_Oil) }; -- Create Boiling Oil... (Flaming Oil)
    [15775] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_burning_oil.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Flaming Oil (Flaming Oil)
    [15776] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_burning_oil.dds'; name = Abilities.Skill_Flaming_Oil; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Flaming oil (Flaming Oil)
    [15876] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ram.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Covenant, Abilities.Skill_Battering_Ram) }; -- Create Large Ram... (Battering Ram)
    [16171] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ram.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Pact, Abilities.Skill_Battering_Ram) }; -- Create Large Ram... (Battering Ram)
    [16170] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_ram.dds'; name = zo_strformat('<<1>> <<2>> <<3>>', Abilities.Skill_Deploy, Abilities.Skill_Dominion, Abilities.Skill_Battering_Ram) }; -- Create Large Ram... (Battering Ram)
    [12355] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_trap_fire.dds' }; -- Destroy Siege Weapon
    [13853] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_repair_kit_wall.dds'; name = Abilities.Skill_Keep_Wall_Repair_Kit }; -- Wall Repair Kit
    [16723] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_repair_kit_door.dds'; name = Abilities.Skill_Keep_Door_Repair_Kit }; -- Door Repair Kit
    [13601] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_repair_kit_siege.dds'; name = Abilities.Skill_Siege_Repair_Kit }; -- Advanced Siege Repair Kit
    [112975] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_repair_kit_bridge.dds'; name = Abilities.Skill_Bridge_Repair_Kit }; -- Wall Repair Kit (Bridge and Milegate Repair Kit)
    [19039] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_forward_camp_ep.dds'; name = Abilities.Skill_Pact_Forward_Camp }; -- Ebonheart Forward Camp
    [19040] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_forward_camp_ad.dds'; name = Abilities.Skill_Dominion_Forward_Camp }; -- Aldmeri Forward Camp
    [19041] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_forward_camp_dc.dds'; name = Abilities.Skill_Covenant_Forward_Camp }; -- Daggerfall Forward Camp

    -- Volendrung
    [118500] = { icon = 'LuiExtended/media/icons/abilities/ability_volendrung_passive.dds' }; -- Volendrung (Volendrung)
    [116762] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_volendrung_attack_light.dds' }; -- Light Attack (Volendrung)
    [116763] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_volendrung_attack_heavy.dds' }; -- Heavy Attack (Volendrung)
    [116765] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_volendrung_attack_medium.dds'; name = zo_strgsub(Abilities.Skill_Heavy_Attack_Volendrung, Abilities.Skill_Heavy_Attack, Abilities.Skill_Medium_Attack) }; -- Heavy Attack (Volendrung)
    [116767] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_volendrung_attack_heavy.dds' }; -- Heavy Attack (Volendrung)
    [116766] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_volendrung_attack_restore.dds' }; -- Heavy Attack (Volendrung)
    [118501] = { icon = 'LuiExtended/media/icons/abilities/ability_volendrung_damage_shield.dds'; name = Abilities.Skill_Consume_Lifeforce }; -- Damage Shield (Volendrung)
    [118504] = { icon = 'LuiExtended/media/icons/abilities/ability_volendrung_damage_shield.dds'; name = Abilities.Skill_Consume_Lifeforce; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Damage Shield (Volendrung)
    [116366] = { tooltip = Tooltips.Innate_Snare_Immobilize_Immunity }; -- Pariah's Resolve (Pariah's Resolve)
    [116365] = { icon = '/esoui/art/icons/ability_artifact_volendrung_001.dds' }; -- Rourken's Rebuke (Rourken's Rebuke)
    [116364] = { tooltip = Tooltips.Generic_Knockback }; -- Rourken's Rebuke (Rourken's Rebuke)
    [116096] = { tooltip = Tooltips.Skill_Ruinous_Cyclone }; -- Ruinous Cyclone (Ruinous Cyclone)
    [116669] = { icon = '/esoui/art/icons/ability_artifact_volendrung_006.dds'; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 0.5; groundLabel = true }; -- Ruinous Cyclone (Ruinous Cyclone)
    [116680] = { icon = '/esoui/art/icons/ability_artifact_volendrung_006.dds' }; -- Ruinous Cyclone (Ruinous Cyclone)
    [21675] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molag_bals_favor.dds'; tooltip = Tooltips.Generic_Damage_Immunity_Permanent }; -- Molag Bal's Favor
    [21677] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_wall_of_souls.dds'; tooltip = Tooltips.Skill_Wall_of_Souls }; -- Wall of Souls (Dremora Channeler)
    [21707] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_wall_of_souls.dds'; name = Abilities.Skill_Wall_of_Souls }; -- Imperial Law (Player)
    -- Siege Warfare
    [35106] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_firepot_trebuchet.dds'; name = Abilities.Skill_Firepot_Trebuchet }; -- Fire (Firepot Trebuchet)
    [35103] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_firepot_trebuchet.dds'; name = Abilities.Skill_Firepot_Trebuchet; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Fire (Firepot Trebuchet)
    [35099] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_iceball_trebuchet.dds'; name = Abilities.Skill_Iceball_Trebuchet }; -- Ice Damage (Iceball Trebuchet)
    [35100] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_iceball_trebuchet.dds'; name = Abilities.Skill_Iceball_Trebuchet; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 70 }; -- Iceball Snare (Iceball Trebuchet)
    [35112] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_stone_trebuchet.dds'; name = Abilities.Skill_Stone_Trebuchet }; -- Stoneball (Stone Trebuchet)
    [35094] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_ballista_bolt.dds'; name = Abilities.Skill_Ballista }; -- Bolt (Ballista)
    [35055] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_fire_ballista_bolt.dds'; name = Abilities.Skill_Fire_Ballista; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Fire (Firebolt Ballista)
    [35080] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_lightning_ballista_bolt.dds'; name = Abilities.Skill_Lightning_Ballista; tooltip = Tooltips.Generic_Shock_Snare; tooltipValue2 = 2; tooltipValue3 = 50 }; -- Bolt (Lightning Ballista)
    [35078] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_lightning_ballista_bolt.dds'; name = Abilities.Skill_Lightning_Ballista }; -- Snare (Lightning Ballista)
    [35121] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_scattershot_catapult.dds'; name = Abilities.Skill_Scattershot_Catapult }; -- Ice Damage (Scattershot Catapult)
    [35119] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_scattershot_catapult.dds'; name = Abilities.Skill_Scattershot_Catapult; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Scatter Snare (Scattershot Catapult)
    [35136] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds'; name = Abilities.Skill_Meatbag_Catapult; tooltip = Tooltips.Generic_Disease; tooltipValue2 = 2 }; -- Meatbag (Meatbag Catapult)
    [35138] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_meatbag_catapult.dds'; name = Abilities.Skill_Meatbag_Catapult; tooltip = Tooltips.Generic_Reduce_Healing_Received; tooltipValue2 = 75 }; -- Diseased (Meatbag Catapult)
    [35132] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_oil_catapult.dds'; name = Abilities.Skill_Oil_Catapult }; -- Oil Pot (Oil Catapult)
    [35131] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_oil_catapult.dds'; name = Abilities.Skill_Oil_Catapult; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 75 }; -- Oil Pot (Oil Catapult)
    [35365] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_siege_burning_oil.dds'; name = Abilities.Skill_Flaming_Oil; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Fire (Flaming Oil)
    [33348] = { icon = 'LuiExtended/media/icons/abilities/ability_item_ava_repair_kit_practice_siege.dds' }; -- Practice Siege Repair Kit (Practice Siege Repair Kit)

    ----------------------------------------------------------------
    -- BATTLEGROUNDS -------------------------------------------------------
    ----------------------------------------------------------------

    [95826] = { icon = '/esoui/art/icons/achievement_042.dds'; name = Abilities.Skill_Mark_of_the_Worm; unbreakable = 1; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Mark_of_the_Worm }; -- Worm Cult Curse
    [95829] = { hide = true }; -- FX Dummy
    [95830] = { hide = true }; -- Mark of the Worm
    [95831] = { icon = '/esoui/art/icons/achievement_042.dds' }; -- Mark of the Worm
    [87949] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds' }; -- Lava (Foyada Quarry)
    [87948] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds'; name = Abilities.Trap_Lava; duration = 0; groundLabel = true; unbreakable = 1; tooltip = Tooltips.Generic_AOE_Fire_Stacking }; -- Lava Snare (Foyada Quarry)
    [92757] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap }; -- Spinning Blade (Blade Trap)
    [92759] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Serrated Blade (Blade Trap)

    ----------------------------------------------------------------
    -- TRAPS -------------------------------------------------------
    ----------------------------------------------------------------

    -- Traps & World Hazards

    -- Coldharbour Flames (Flame Trap) (Coldharbor)
    [62230] = { hide = true }; -- Coldharbour Flames (Flame Trap)
    [62771] = { hide = true }; -- Coldharbour Flames (Flame Trap)
    [62769] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds'; name = Abilities.Trap_Cold_Fire_Trap; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Coldharbour Flames (Flame Trap)
    [62770] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds'; name = Abilities.Trap_Cold_Fire_Trap }; -- Coldharbour Flames (Flame Trap)
    [20888] = { icon = '/esoui/art/icons/ability_wrothgar_avalanche.dds' }; -- Falling Rocks (Falling Rocks)
    [27479] = { icon = '/esoui/art/icons/ability_wrothgar_avalanche.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Falling Rocks (Falling Rocks)
    [21940] = { hide = true }; -- Spike Trap (Spike Trap)
    [21943] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds'; hide = true }; -- Spike Trap (Spike Trap)
    [21941] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds'; name = Abilities.Trap_Spike_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Spike_Trap }; -- Spike Trap Snare (Spike Trap)
    [21942] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds'; name = Abilities.Trap_Spike_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Spike_Trap; hideReduce = true }; -- Trap Sprung (Spike Trap)-- Spike Trap (Dragonstar Arena)
    [53166] = { hide = true }; -- Spike Trap (Spike Trap)
    [53169] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds'; hide = true }; -- Spike Trap (Spike Trap)
    [53167] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds'; name = Abilities.Trap_Spike_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Spike_Trap }; -- Spike Trap Snare (Spike Trap)
    [53168] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds'; name = Abilities.Trap_Spike_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Spike_Trap; hideReduce = true }; -- Trap Sprung (Spike Trap)
    [53172] = { hide = true }; -- Spike Trap (Spike Trap)
    [20482] = { hide = true }; -- Mistwatch Collapse (Cave-In)
    [20483] = { icon = '/esoui/art/icons/ability_wrothgar_avalanche.dds' }; -- Falling Rocks (Cave-In)
    [29602] = { icon = '/esoui/art/icons/ability_wrothgar_avalanche.dds'; tooltip = Tooltips.Generic_Stun }; -- Falling Rocks (Cave-In)
    [17198] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire_trap.dds' }; -- Fire Trap (Player)
    [31606] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire_trap.dds'; groundLabel = true; unbreakable = 1; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 0.75; tooltipValue3 = 50; hideGround = true }; -- Fire Trap (Player)
    [17314] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire_trap.dds'; groundLabel = true; unbreakable = 1; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 0.75; tooltipValue3 = 50 }; -- Fire Trap (Player)
    [72888] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire_trap.dds'; name = Abilities.Trap_Fire_Trap; hide = true; groundLabel = true; unbreakable = 1; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 1.5; tooltipValue3 = 50 }; -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire_trap.dds'; name = Abilities.Trap_Fire_Trap; groundLabel = true; unbreakable = 1; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 1.5; tooltipValue3 = 50 }; -- Fire Attack 2 (Fire) -- Banished Cells II
    [72890] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire_trap.dds'; name = Abilities.Trap_Fire_Trap; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 1.5; tooltipValue3 = 50; groundLabel = true; unbreakable = 1; hideGround = true }; -- Laser Snare (Fire) -- Banished Cells II
    [26530] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Bear Trap (Bear Trap)
    [26531] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }; -- Bear Trap (Bear Trap)
    [31085] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds'; name = Abilities.Skill_Bear_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Immobilize }; -- Trap (Longclaw)
    [31086] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds'; name = Abilities.Skill_Bear_Trap }; -- Trap (Longclaw)
    [20260] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_sigil_of_frost.dds'; name = Abilities.Trap_Sigil_of_Frost }; -- Rune Burst
    [20259] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_sigil_of_frost.dds'; name = Abilities.Trap_Sigil_of_Frost; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 75 }; -- Sigil of Frost Snare
    [33594] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire_trap.dds'; name = Abilities.Skill_Flames; unbreakable = 1; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 0.66; tooltipValue3 = 50 }; -- Fire (Fire) -- Throne of the Wilderking
    [49897] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire_trap.dds'; name = Abilities.Skill_Flames; unbreakable = 1; groundLabel = true; hideGround = true; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 0.66; tooltipValue3 = 50 }; -- Fire (Fire) -- Throne of the Wilderking

    -- Laser Trap (Stros M'Kai - Buried Secrets)
    [27939] = { hide = true }; -- Bthzark Laser Beam (Generic Flame Wave Target) -- Stros M'Kai
    [27940] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds'; name = Abilities.Trap_Charge_Wire; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.25; groundLabel = true }; -- Laser Damage (Generic Flame Wave Shooter) -- Stros M'Kai
    [27943] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_snare.dds'; name = Abilities.Trap_Charge_Wire; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 70 }; -- Laser Snare (Generic Flame Wave Shooter) -- Stros M'Kai

    -- Steam Trap (Stroks M'Kai - Buried Secrets)
    [32245] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds'; name = Abilities.Trap_Steam_Vent; groundLabel = true; unbreakable = 1; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 0.75; tooltipValue3 = 50 }; -- Searing Steam (Steam Trap) -- Stros M'Kai
    [32246] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds'; name = Abilities.Trap_Steam_Vent; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 0.75; tooltipValue3 = 50; groundLabel = true; unbreakable = 1; hideGround = true }; -- Searing Steam (Steam Trap) -- Stros M'Kai
    [26039] = { hide = true }; -- Vent Steam (Steam Vent) -- Volenfell
    [26040] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_pipe.dds'; name = Abilities.Trap_Steam_Vent; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Steam Blast (Steam Vent) -- Volenfell
    [26088] = { hide = true }; -- Vent Steam (Steam Vent) -- Volenfell
    [26089] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_pipe.dds'; name = Abilities.Trap_Steam_Vent; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Steam Blast (Steam Vent) -- Volenfell
    [26090] = { hide = true }; -- Vent Steam (Steam Vent) -- Volenfell
    [26091] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds'; name = Abilities.Trap_Steam_Vent; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Steam Blast (Steam Vent) -- Volenfell
    [26076] = { hide = true }; -- Vent Steam (Steam Vent) -- Volenfell
    [26077] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds'; name = Abilities.Trap_Steam_Vent; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Steam Blast (Steam Vent) -- Volenfell
    [110416] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_gas_blossom.dds'; name = Abilities.Trap_Gas_Blossom; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 1 }; -- Putrid Cloud (Gas Blossom) -- Housing
    [110542] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_static_pitcher.dds'; name = Abilities.Trap_Static_Pitcher; groundLabel = true; tooltip = Tooltips.Skill_Trap_Static_Pitcher; tooltipValue2 = 0.5 }; -- Stunted Current (Static Pitcher) -- Housing
    [111229] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_stunted_current.dds'; tooltip = Tooltips.Skill_Trap_Stunted_Current }; -- Stunted Current (Static Pitcher) -- Housing
    [110576] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_static_pitcher.dds'; name = Abilities.Trap_Static_Pitcher }; -- Stunted Current (Static Pitcher) -- Housing
    [110578] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_static_pitcher.dds'; name = Abilities.Trap_Static_Pitcher }; -- Stunted Current (Static Pitcher) -- Housing
    [111258] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lantern_mantis.dds'; name = Abilities.Trap_Lantern_Mantis }; -- Surprise Attack (Lantern Mantis) -- Housing
    [111261] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lantern_mantis.dds'; name = Abilities.Trap_Lantern_Mantis }; -- Surprise Attack (Lantern Mantis) -- Housing

    -- Elinhir Private Arena
    [117428] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava_trap.dds'; name = Abilities.Trap_Lava_Trap }; -- Lava Eruption (Lava Trap)
    [118438] = { tooltip = Abilities.Trap_Lava_Trap }; -- Lava Eruption (Lava Trap)
    [117508] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds'; name = Abilities.Trap_Lightning_Trap }; -- Shock Wall (Lightning Trap)
    [117480] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds'; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 70; name = Abilities.Trap_Lightning_Trap; duration = 0; groundLabel = true }; -- Shock Wall (Lightning Trap) -- TODO: Get snare %
    [117622] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds'; name = Abilities.Trap_Lightning_Trap }; -- Shock Wall (Lightning Trap)
    [117617] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds'; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 70; name = Abilities.Trap_Lightning_Trap; duration = 0; groundLabel = true }; -- Shock Wall (Lightning Trap) -- TODO: Get snare %
    [117598] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds'; name = Abilities.Trap_Lightning_Trap }; -- Shock Wall (Lightning Trap)
    [117599] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds'; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 70; name = Abilities.Trap_Lightning_Trap; duration = 0; groundLabel = true }; -- Shock Wall (Lightning Trap) -- TODO: Get snare %
    [117139] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap }; -- Spinning Blade (Blade Trap), -- Spinning Blade
    [117145] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 0.5 }; -- Spinning Blade (Blade Trap), -- Serrated Blade

    -- Lava & Slaughterfish
    [44029] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Slaughterfish_Attack; groundLabel = true }; -- Slaughterfish Attack (Slaughterfish)
    [44034] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds' }; -- Slaughterfish Attack (Slaughterfish)
    [113080] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Slaughterfish_Attack; groundLabel = true }; -- Slaughterfish Attack (Slaughterfish)
    [113082] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds' }; -- Slaughterfish Attack (Slaughterfish)
    [19224] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds'; name = Abilities.Trap_Lava }; -- In Lava (Lava - Halls of Torment)
    [11338] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds'; name = Abilities.Trap_Lava; tooltip = Tooltips.Generic_AOE_Snare_Fire; tooltipValue2 = 1; tooltipValue3 = 30; unbreakable = 1; groundLabel = true }; -- In Lava (Lava - The Earth Forge)
    [56277] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds' }; -- Lava (City of Ash II)
    [55925] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds'; tooltip = Tooltips.Generic_AOE_Fire_Stacking; tooltipValue2 = 0.75; tooltipValue3 = 75; unbreakable = 1; groundLabel = true; stackAdd = 1 }; -- Lava (City of Ash II)
    [5139] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds'; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.75; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; groundLabel = true }; -- Lava (Dragonstar Arena)
    [5140] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds' }; -- Lava (Dragonstar Arena)

    -- Hiding Spot
    [72711] = { hide = true }; -- Hidden (Hiding Spot)
    [77335] = { hide = true }; -- Threat Drop (Hiding Spot)
    [77336] = { hide = true }; -- Threat Drop (Hiding Spot)
    [77337] = { hide = true }; -- Threat Drop (Hiding Spot)
    [77338] = { hide = true }; -- Threat Drop (Hiding Spot)
    [77339] = { hide = true }; -- Threat Drop (Hiding Spot)
    [75670] = { hide = true }; -- Threat Drop (Hiding Spot)
    [75747] = { hide = true }; -- Hiding Spot (Hiding Spot)

    ----------------------------------------------------------------
    -- MAIN QUEST --------------------------------------------------
    ----------------------------------------------------------------

    -- Tutorial - Soul Shriven in Coldharbour
    [75527] = { hide = true }; -- Ultimate Protection (Tutorial)
    [64091] = { hide = true }; -- Power Bash (Tutorial - Used on Lyris)
    [61748] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds' }; -- Heavy Attack (Tutorial)
    [63737] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds' }; -- Heavy Attack (Dremora Churl)
    [63685] = { icon = '/esoui/art/icons/ability_2handed_001.dds'; name = Abilities.Skill_Uppercut; tooltip = Tooltips.Generic_Knockback; cc = LUIE_CC_TYPE_KNOCKBACK }; -- Uppercut Stun (Dremora Caitiff)
    [63686] = { icon = '/esoui/art/icons/ability_2handed_001.dds' }; -- Uppercut (Dremora Caitiff)
    [63761] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }; -- Pound (Feral Soul Shriven)
    [63752] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }; -- Vomit (Feral Soul Shriven)
    [63753] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }; -- Vomit (Feral Soul Shriven)
    [64072] = { icon = '/esoui/art/icons/ability_debuff_reveal.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; duration = 0; unbreakable = 1; tooltip = Tooltips.Skill_Eye_of_the_Sentinel; stack = 0; cc = LUIE_CC_TYPE_STUN }; -- Eye of the Sentinel (CH Tutorial)
    [48345] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_focused_healing.dds' }; -- Focused Healing (The Prophet)
    [48346] = { hide = true }; -- Minor Wound (The Prophet)
    [63521] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw_tutorial.dds'; name = Abilities.Skill_Stomp }; -- Bone Crush (Child of Bones)
    [63522] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw_tutorial.dds'; name = Abilities.Skill_Stomp }; -- Bone Saw (Child of Bones)
    [61646] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_incapacitating_terror.dds'; duration = 0; tooltip = Tooltips.Skill_Incapacitating_Terror; cc = LUIE_CC_TYPE_FEAR }; -- Incapacitating Terror
    [64074] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_incapacitating_terror.dds' }; -- Incapacitating Terror
    [75514] = { hide = true }; -- Greater Protection - CH Tutorial pointless aura
    [1718] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds'; name = Abilities.Skill_Light_Attack }; -- Attack
    [64772] = { hide = true }; -- MQ1 Input Lock LAtk - CH Tutorial pointless aura
    [63883] = { hide = true }; -- Major Protection - CH Tutorial pointless aura
    [64784] = { hide = true }; -- MQ1 Tutorial Block Heavy - CH Tutorial pointless aura
    [64798] = { hide = true }; -- MQ1 Heat Wave (Tutorial) - CH Tutorial pointless aura
    [61961] = { hide = true }; -- Perma Set Off Balance Target - CH Tutorial pointless aura
    [64677] = { hide = true }; -- MQ1 Tutorial Perma Off-Balance - CH Tutorial pointless aura
    [64069] = { hide = true }; -- Sentinel Barrier
    [64166] = { hide = true }; -- Major Protection - CH Tutorial pointless aura

    -- Daughter of Giants
    [29994] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_inferno.dds' }; -- Inferno (Manifestation of Solitude)
    [27767] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }; -- Rending Leap (Ancient Clannfear)
    [27769] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }; -- Rending Leap (Ancient Clannfear)
    [27774] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds'; tooltip = Tooltips.Generic_Knockdown; name = Abilities.Skill_Rending_Leap }; -- Knockdown (Ancient Clannfear)
    [27776] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds'; name = Abilities.Skill_Devour; hide = true }; -- Feeding (Ancient Clannfear)
    [28718] = { hide = true }; -- Spawn (Manifestation of Terror)
    [28792] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gaze_alt.dds' }; -- Gaze (Manifestation of Terror)
    [28788] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds'; name = Abilities.Skill_Doom_Truths_Gaze }; -- MQ2_Boss_1_Doom-Truth'sGaze (Manifestation of Terror)
    [49958] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds'; name = Abilities.Skill_Doom_Truths_Gaze }; -- Fire Runes (Manifestation of Terror)
    [49961] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds' }; -- Doom-Truth's Gaze (Manifestation of Terror)
    [28723] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gravity_well.dds' }; -- Gravity Well (Manifestation of Terror)
    [28730] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gravity_well.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Gravity Well (Manifestation of Terror)
    [28745] = { hide = true }; -- Tentacle Whip (Manifestation of Terror)
    [28746] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_tentacle_whip.dds' }; -- Tentacle Whip (Manifestation of Terror)

    -- Castle of the Worm
    [41852] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_oblivion_blue.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Necrotic, Abilities.Skill_Barrier) }; -- Necrotic
    [16019] = { hide = true }; -- Bone Pile Explosion
    [33597] = { hide = true }; -- Invisible Underground
    [35794] = { hide = true }; -- Material Effect
    [33540] = { hide = true }; -- Intro Explosion
    [31244] = { hide = true }; -- Consuming Darkness
    [32563] = { hide = true }; -- Skeleton Stun Targetable
    [32561] = { hide = true }; -- Skeleton Stun
    [31232] = { hide = true }; -- Skeleton Stun Targetable
    [31222] = { hide = true }; -- Skeleton Stun
    [32557] = { hide = true }; -- Skeleton Stun Targetable
    [32555] = { hide = true }; -- Skeleton Stun
    [32558] = { hide = true }; -- Delay
    [32554] = { hide = true }; -- Delay
    [32564] = { hide = true }; -- Delay
    [32562] = { hide = true }; -- Ravager Weapons
    [32553] = { hide = true }; -- Ravager Weapons
    [32556] = { hide = true }; -- Fire Mage Weapons
    [34484] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds' }; -- Soul Cage (Mannimarco)
    [34470] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds'; name = Abilities.Skill_Soul_Rupture }; -- Soul Cage (Mannimarco)
    [34463] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds'; name = Abilities.Skill_Soul_Rupture }; -- Soul Cage (Mannimarco)
    [34458] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds' }; -- Soul Cage (Mannimarco)
    [34460] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds' }; -- Soul Cage (Mannimarco)
    [70409] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_oblivion_purple.dds' }; -- Necromantic Barrier
    [31321] = { hide = true }; -- Disruption
    [31334] = { hide = true }; -- Oblivion
    [31480] = { type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Overwhelming Power
    [31341] = { hide = true }; -- Unleashed Oblivion
    [14972] = { icon = '/esoui/art/icons/ability_debuff_knockback.dds'; name = Abilities.Skill_Knockback; unbreakable = 1 }; -- CON_Knockback&Knockdown
    [14973] = { name = Abilities.Skill_Knockback }; -- Fire Backlash

    -- Halls of Torment
    [36672] = { hide = true }; -- Summon Sword Saint
    [36858] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }; -- Swordstorm (Tharn Doppleganger)
    [36860] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds'; name = Abilities.Skill_Swordstorm }; -- Swordstorm damage (Tharn Doppleganger)
    [44561] = { icon = '/esoui/art/icons/ability_debuff_knockback.dds'; name = Abilities.Skill_Knockback; unbreakable = 1 }; -- FGQ4 RGT Event Knockback
    [44563] = { name = Abilities.Skill_Knockback }; -- Fire Backlash
    [37015] = { hide = true }; -- Lash of Torment
    [37173] = { icon = '/esoui/art/icons/ability_mage_010.dds' }; -- Flame Shield (Duchess of Anguish)
    [37176] = { hide = true }; -- Register (Duchess of Anguish)
    [37175] = { icon = '/esoui/art/icons/ability_mage_010.dds'; name = Abilities.Skill_Flame_Shield }; -- Flare Up (Duchess of Anguish)
    [38729] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_royal_strike.dds' }; -- Royal Strike (Duchess of Anguish)
    [38741] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_royal_strike.dds'; name = Abilities.Skill_Royal_Strike }; -- Royal Snare (Duchess of Anguish)
    [38728] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_flame_atronach_red.dds' }; -- Summon Daedra (Duchess of Anguish)

    -- Shadow of Sancre Tor
    [41021] = { hide = true }; -- Mannimarco's Triumph
    [39302] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_necromantic_revival.dds' }; -- Necromantic Revival
    [39367] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_consecrate_shrine.dds'; name = Abilities.Skill_Consecrate_Shrine }; -- Altar Use
    [37827] = { hide = true; icon = '/esoui/art/icons/achievement_housing_033.dds'; name = Abilities.Skill_Remove_Ward }; -- Stendarr's Protection
    [46816] = { hide = true }; -- Shake
    [38207] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds'; hide = true }; -- Death Bolt (Mannimarco)
    [41067] = { hide = true }; -- Dummy (Mannimarco)
    [40401] = { hide = true }; -- Daedric Step (Mannimarco)
    [40400] = { hide = true }; -- Daedric Step (Mannimarco)
    [40399] = { hide = true }; -- Daedric Step (Mannimarco)
    [38215] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_deaths_gaze.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Death's Gaze (Mannimarco)
    [38217] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_deaths_gaze.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; duration = 0 }; -- Death's Gaze (Mannimarco)
    [40425] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_shock_nova.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Shock, Abilities.Skill_Nova) }; -- Impending Doom (Mannimarco)
    [40427] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_shock_nova.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Shock, Abilities.Skill_Nova) }; -- Doom (Mannimarco)
    [40430] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_shock_nova.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Shock, Abilities.Skill_Nova) }; -- Doom (Mannimarco)
    [41022] = { hide = true }; -- Nova (Mannimarco)
    [40429] = { icon = '/esoui/art/icons/ability_debuff_knockback.dds'; name = Abilities.Skill_Knockback; unbreakable = 1 }; -- IntroKB (Mannimarco)
    [40426] = { icon = '/esoui/art/icons/ability_debuff_knockback.dds'; name = Abilities.Skill_Knockback }; -- Staggering Roar (Mannimarco)
    [40973] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds'; name = Abilities.Skill_Unstable_Portal }; -- Portal Spawn (Mannimarco)
    [40978] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds'; name = Abilities.Skill_Unstable_Portal }; -- Portal Spawn (Mannimarco)
    [40981] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds'; name = Abilities.Skill_Unstable_Portal }; -- Portal Spawn (Mannimarco)
    [40976] = { hide = true }; -- dummy (Mannimarco)
    [44083] = { hide = true }; -- Ghostly (Mannimarco)
    [42083] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_stabilize.dds'; name = Abilities.Skill_Stabilize_Portal }; -- PortalHoldstun (Mannimarco)
    [40573] = { hide = true }; -- StopPortalStun (Mannimarco)
    [40980] = { hide = true }; -- dummy (Mannimarco)
    [40983] = { hide = true }; -- dummy (Mannimarco)
    [41196] = { hide = true }; -- Smash (Molag Bal)
    [41198] = { icon = '/esoui/art/icons/ability_debuff_knockback.dds'; name = Abilities.Skill_Knockback; unbreakable = 1 }; -- IntroKB (Mannimarco)
    [41197] = { icon = '/esoui/art/icons/ability_debuff_knockback.dds'; name = Abilities.Skill_Knockback }; -- Staggering Roar (Mannimarco)
    [41385] = { hide = true }; -- Dummystun (Molag Bal)-- Council of the Five Companions
    [36543] = { hide = true }; -- Portal Cast
    [36421] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_drink_mead.dds'; name = Abilities.Skill_Drink_Mead }; -- Drink with Lyris-- The Weight of Three Crowns
    [47186] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_close_unstable_rift.dds'; name = Abilities.Skill_Close_Unstable_Rift }; -- CHT Portal Killer

    ----------------------------------------------------------------
    -- QUESTS - FIGHTERS GUILD -------------------------------------
    ----------------------------------------------------------------

    -- The Prismatic Core
    [39357] = { hide = true }; -- Necrobomb Camerashake
    [39577] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds' }; -- Palolel's Rage (Queen Palolel)
    [39579] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds'; name = Abilities.Skill_Palolels_Rage }; -- CON_Knockback&Knockdown (Queen Palolel)
    [39578] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds'; name = Abilities.Skill_Palolels_Rage }; -- Staggering Roar (Queen Palolel)

    -- Proving the Deed
    [25979] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds'; name = Abilities.Skill_Prismatic_Light; unbreakable = 1 }; -- FG4 RGT Event Knockback
    [25980] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds'; name = Abilities.Skill_Prismatic_Light }; -- FGQ4 RGT Event Knockback
    [25984] = { hide = true }; -- Subversion (Aelif)
    [64217] = { hide = true }; -- Damage Immunity Under 50% (Aelif)
    [64218] = { hide = true }; -- Combat Regen (Aelif)
    [64220] = { hide = true }; -- Base Damage Reduction (Aelif)

    -- Will of the Council
    [28939] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_blossom.dds'; name = Abilities.Skill_Flame_Blossom }; -- Heat Wave (Sees-All-Colors)
    [28946] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_blossom.dds'; name = Abilities.Skill_Flame_Blossom }; -- Heat Wave (Sees-All-Colors)
    [47758] = { hide = true }; -- Imprisonment
    [64111] = { hide = true }; -- Transformation

    ----------------------------------------------------------------
    -- QUESTS - MAGES GUILD ----------------------------------------
    ----------------------------------------------------------------

    -- Simply Misplaced
    [26406] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence.dds'; name = Abilities.Skill_Essence; stack = 1; stackAdd = 1 }; -- MG2 Captured Essence
    [26634] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence_greater.dds'; name = Abilities.Skill_Sahdinas_Essence }; -- MG2 Captured Sahdina Essence
    [26581] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence_greater.dds'; name = Abilities.Skill_Rashomtas_Essence }; -- MG2 Captured Rashomta Essence
    [31502] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Rock, Abilities.Skill_Barrier); unbreakable = 1 }; -- MGQ2 Asakala Sahdina Barrier
    [31503] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Rock, Abilities.Skill_Barrier); unbreakable = 1 }; -- MGQ2 Asakala Rashomta Barrier

    -- Circus of Cheerful Slaughter
    [29814] = { hide = true }; -- Ansei Ward
    [29815] = { hide = true }; -- Ansei Ward 3

    -- The Mad God's Bargain
    [39555] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_scamp.dds'; hide = true }; -- Summon Scamp (Haskill)
    [39527] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_polymorph.dds'; name = Abilities.Skill_Polymorph_Skeleton }; -- Skeleton Trap (Haskill)
    [39533] = { hide = true }; -- Polymorph (Haskill)
    [40851] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_polymorph.dds'; name = Abilities.Skill_Polymorph_Skeleton }; -- Polymorph Snare (Haskill)
    [35533] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_drain_vitality.dds'; name = Abilities.Skill_Drain_Vitality }; -- Polymorph (Haskill)
    [39556] = { hide = true }; -- Transform Scamp
    [39558] = { hide = true }; -- Rabbit
    [39559] = { hide = true }; -- Atronach
    [39560] = { hide = true }; -- Netch
    [39391] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_pig.dds'; name = Abilities.Skill_Ungulate_Ordnance }; -- Summon Pig
    [39393] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_pig.dds' }; -- Ungulate Ordnance

    --------------------------------------
    -- QUEST / ZONES - ALDMERI DOMINION --
    --------------------------------------

    --------------------
    -- Khenarthi's Roost
    --------------------

    -- Cast Adrift
    [35192] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds'; name = Abilities.Skill_Drain_Energy }; -- Q4620 Use Lodestone

    -- Tears of the Two Moons
    [32766] = { hide = true }; -- 4625 Uldor's Possession
    [31649] = { hide = true }; -- 4625 Ward 1
    [31665] = { hide = true }; -- 4625 Ward 2
    [33233] = { icon = '/esoui/art/icons/perks_mages_guild_004.dds'; name = Abilities.Skill_Beckon_Gathwen }; -- 4625 Stun for Beckon 1.5s
    [31652] = { hide = true }; -- 4625 Gathwen Destory Ward
    [33231] = { hide = true }; -- 4625 Ward Destory
    [33136] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_heal.dds'; tooltip = Tooltips.Skill_Blessing_Gathwen }; -- Blessing (Gathwen)
    [35185] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_heal.dds'; name = Abilities.Skill_Blessing; hide = true }; -- 4625 Heal (Gathwen)
    [32063] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Feedback
    [35195] = { hide = true }; -- No Heal Check
    [31709] = { hide = true }; -- 4625 Gathwen Beam Ritual
    [33278] = { hide = true }; -- Increased Speed
    [32060] = { hide = true }; -- Shocked
    [33285] = { hide = true }; -- 4625 Uldor Banish
    [32705] = { hide = true }; -- 4625 No Yell
    [31969] = { hide = true }; -- Wrath (Uldor)
    [31970] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds'; hide = true }; -- Wrath (Uldor)
    [33449] = { hide = true }; -- 4625 Stop Bolts
    [33403] = { hide = true }; -- Wrath (Uldor)
    [33404] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds'; hide = true }; -- Wrath (Uldor)

    -- The Perils of Diplomacy
    [32264] = { hide = true }; -- Unconscious

    -- The Tempest Unleashed
    [34567] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds'; name = Abilities.Skill_Drain_Energy }; -- Q4621 PC Storm Drain
    [34701] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds'; name = Abilities.Skill_Disruption }; -- Q4621 Destory Horn
    [34747] = { hide = true }; -- a

    -- Dark Knowledge
    [35265] = { hide = true }; -- Q4667 Stun
    [35268] = { hide = true }; -- Sahira Screams

    -- The Root of the Problem
    [31948] = { hide = true }; -- Burrow
    [31947] = { hide = true }; -- Burrow

    -- A Pinch of Sugar
    [32335] = { hide = true }; -- Q4692 Thunderthrow

    --------------------
    -- Auridon
    --------------------

    -- Rites of the Queen
    [48921] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_summon_ancestral_spirit.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Summon, Abilities.Skill_Ancestral_Spirit) }; -- Ancestral Spirit
    [48924] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_summon_ancestral_spirit.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Summon, Abilities.Skill_Ancestral_Spirit) }; -- Ancestral Spirit
    [48927] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_summon_ancestral_spirit.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Summon, Abilities.Skill_Ancestral_Spirit) }; -- Ancestral Spirit

    -- The Unveiling
    [22718] = { hide = true }; -- Knock Out

    -- Lifting the Veil
    [23392] = { icon = 'LuiExtended/media/icons/disguises/disguise_altmer_glamour.dds'; isDisguise = true; tooltip = Tooltips.Skill_Disguise_Altmer_Glamour }; -- Altmer Glamour
    [23540] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_drink_mead.dds'; name = Abilities.Skill_Drinking }; -- Teleport

    -- Through the Ashes
    [48646] = { hide = true }; -- Magefire
    [2379] = { hide = true }; -- On Fire

    -- Breaking the Barrier
    [21876] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds'; name = Abilities.Skill_Barrier_Rebuke; tooltip = Tooltips.Generic_Stun; unbreakable = 1 }; -- Q4260 West Barrier Teleport
    [21878] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds'; name = Abilities.Skill_Barrier_Rebuke; tooltip = Tooltips.Generic_Stun; unbreakable = 1 }; -- Q4260 East Barrier Teleport

    -- Sever All Ties
    [22395] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds'; name = Abilities.Skill_Barrier_Rebuke; tooltip = Tooltips.Generic_Stun; unbreakable = 1 }; -- Q4261 ROD Barrier Teleport
    [44138] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave_radial.dds'; name = Abilities.Skill_Shockwave }; -- Q4261 Estre Knockback
    [49224] = { hide = true }; -- Q4868 Aulus Knockback
    [44136] = { hide = true }; -- RobS Stun Perm

    -- The Great Ree
    [46762] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_drink_mead.dds'; name = Abilities.Skill_Drinking }; -- Drinking Contest

    -- The Serpent's Beacon
    [21364] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_maormer_rune.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Dispel, Abilities.Skill_Barrier) }; -- Casting...
    [21409] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_teleport_scroll.dds'; name = Abilities.Skill_Teleport_Scroll }; -- Reading...

    -- Corruption Stones
    [22889] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_altmer_holy_symbol.dds'; name = Abilities.Skill_Purify; hide = true }; -- Purifying...

    -- The First Patient
    [22448] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bind_hands.dds'; name = Abilities.Skill_Bind_Hands }; -- Q4266 Tie up Hendil

    -- Depths of Madness
    [22158] = { hide = true }; -- Collecting with Magic Jar...
    [22141] = { hide = true }; -- Collecting...
    [22160] = { hide = true }; -- Collecting...
    [22187] = { hide = true }; -- Throwing Spore Potion
    [22271] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_teleport_scroll.dds'; name = Abilities.Skill_Teleport_Scroll }; -- Teleport Scroll AB

    -- Silent Village
    [21968] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_binding_gem.dds'; name = Abilities.Skill_Bind_Bear }; -- Binding Bear...
    [45784] = { hide = true }; -- Generic Spawn Fire Atronach AM

    -- The Mallari-Mora
    [28771] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_atherial_shift.dds'; name = Abilities.Skill_Aetherial_Shift; unbreakable = 1; tooltip = Tooltips.Skill_Aetherial_Shift }; -- Q4220 Thirster Stun (The Mallari-Mora)
    [21393] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_atherial_shift.dds'; name = Abilities.Skill_Aetherial_Shift }; -- Q4220 Spirit Layer Ability
    [21403] = { icon = '/esoui/art/icons/ability_mage_054.dds'; tooltip = Tooltips.Skill_Spiritual_Cloak }; -- Spiritual Cloak

    -- An Act of Kindness
    [22931] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_micro_etched_crystal.dds'; name = Abilities.Skill_Free_Spirit }; -- Freeing Spirit...
    [21315] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds' }; -- Spike Trap
    [21313] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds'; name = Abilities.Trap_Spike_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Spike_Trap_Auridon }; -- Crippled!
    [21314] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds'; name = Abilities.Trap_Spike_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Spike_Trap_Auridon; hideReduce = true; noDuplicate = true }; -- Trap Sprung!

    -- The Veiled Choice
    [23187] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bind_hands.dds'; name = Abilities.Skill_Unbind }; -- Q4236 PC Untie Palith

    -- Preventative Measure
    [23606] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback_crystal.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Crystal, Abilities.Skill_Backfire); unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Q4326 Crystal Backfire
    [24535] = { hide = true }; -- Disrupting...

    -- Blessings of the Eight
    [47149] = { hide = true }; -- Magefire
    [23159] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_divine_speed.dds'; tooltip = Tooltips.Skill_Divine_Speed }; -- Divine Speed
    [22728] = { hide = true }; -- Water Beam
    [23217] = { hide = true }; -- Fire Beam

    -- Rightful Inheritance
    [24826] = { hide = true }; -- Spiteful Essence

    --------------------
    -- Grahtwood
    --------------------

    -- World Events
    [40035] = { hide = true }; -- GW CTen Swinging Axe (Peacemaker Achievement Location)

    -- Public Dungeon - Root Sunder Ruins
    [34176] = { hide = true }; -- Blue Flam (The Bonemonger)

    -- Public Dungeon - Root Sunder Ruins -- Forgotten Soul
    [91627] = { hide = true }; -- Root Sunder's Favor

    -- The Grips of Madness
    [37276] = { hide = true }; -- Q4868 Beast Person
    [37296] = { hide = true }; -- Q4868 Change Beast Person
    [37297] = { hide = true }; -- Q4868 Change Beast Person
    [37295] = { hide = true }; -- Q4868 Change Beast Person
    [38499] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds'; name = Abilities.Skill_Lightning_Strike }; -- Wrath
    [38500] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds'; name = Abilities.Skill_Lightning_Strike }; -- Wrath
    [37438] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds'; name = Abilities.Skill_Lightning_Strike; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockdown }; -- Shocked
    [38516] = { hide = true }; -- Q4868 Rufinus Is Lightning
    [47720] = { hide = true }; -- RobS Stun 1 Sec
    [37463] = { icon = '/esoui/art/icons/achievement_wrothgar_044.dds'; name = Abilities.Skill_Push }; -- Q4868 Push NPC
    [37465] = { hide = true }; -- Q4842 Despawn Self
    [38942] = { hide = true }; -- Q4868 Rufinus Is Shocked
    [38596] = { hide = true }; -- Q4842 Stun
    [37583] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_old_scroll.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Dispel, Abilities.Skill_Barrier) }; -- Q4868 Unlock Chapel
    [38744] = { hide = true }; -- Q4868 Sheo Teleports Player
    [38720] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lightning_fury.dds'; tooltip = Tooltips.Skill_Lightning_Fury }; -- Lightning Fury
    [47710] = { hide = true }; -- Lightning Fury
    [38748] = { icon = '/esoui/art/icons/ability_mage_036.dds'; hide = true }; -- Aulus's Tongue
    [63710] = { icon = '/esoui/art/icons/ability_mage_036.dds'; tooltip = Tooltips.Generic_Stun }; -- Aulus's Tongue
    [40702] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave_radial.dds'; name = Abilities.Skill_Shockwave }; -- Q4868 Aulus Knockback
    [44100] = { hide = true }; -- Q4868 Aulus Knockback
    [47709] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave_radial.dds'; name = Abilities.Skill_Shockwave }; -- Q4868 Aulus Knockback

    -- A Lasting Winter
    [38394] = { hide = true }; -- Shatter
    [38413] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_mantles_shadow.dds'; name = Abilities.Skill_Mantles_Shadow }; -- Spawn Clone (General Endare)
    [47762] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boss_immunities.dds'; name = Abilities.Skill_Boss_CC_Immunity; tooltip = Tooltips.Generic_Scary_Immunities_Duration; duration = 3 }; -- Spawn Clone (General Endare)
    [47768] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boss_immunities.dds'; name = Abilities.Skill_Boss_CC_Immunity; tooltip = Tooltips.Generic_Scary_Immunities_Duration }; -- RobS Immunities 6 Sec (General Endare)
    [38441] = { hide = true }; -- Become
    [47783] = { hide = true }; -- Become

    -- Heart of the Matter
    [45997] = { hide = true }; -- Q4386 Ukaezai Split 3
    [46188] = { hide = true }; -- Q4386 Ukaezai Faints
    [45998] = { hide = true }; -- Q4386 Ukaezai Book Summon
    [40849] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_oblivion_blue.dds' }; -- Annihilation
    [39956] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_heart_of_anumaril.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Skill_Absorb, Abilities.Skill_Essence); hide = true }; -- Heart of Anumaril
    [46036] = { hide = true }; -- Q4386 Ukaezai Split 2
    [46037] = { hide = true }; -- Q4386 Ukaezai Split 1-- The Orrery of Elden Root
    [41979] = { hide = true }; -- RobS Despawn Me Flag
    [40504] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_quest_mantles_shadow.dds'; name = Abilities.Skill_Mantles_Shadow }; -- Q4922 Use Mantle on Device
    [40557] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_quest_mantles_shadow.dds'; name = Abilities.Skill_Mantles_Shadow }; -- (12127) CFX_4922 Mantle Cast S
    [41863] = { hide = true }; -- Q4922 Orrery Rumble
    [14568] = { hide = true }; -- TEST_Ritual Arcane
    [40394] = { hide = true }; -- CFX_4922 Naemon Ogre Glow
    [43820] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }; -- Quaking Stomp (Prince Naemon)
    [43822] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }; -- Quaking Stomp (Prince Naemon)
    [43823] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds'; name = Abilities.Skill_Quaking_Stomp; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- IntroKB (Prince Naemon)
    [43821] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds'; name = Abilities.Skill_Quaking_Stomp }; -- Staggering Roar (Prince Naemon)
    [43827] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_projectile_vomit.dds'; hide = true }; -- Projectile Vomit (Prince Naemon)
    [43828] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_projectile_vomit.dds'; name = Abilities.Skill_Projectile_Vomit }; -- Belch (Prince Naemon)
    [40396] = { hide = true }; -- Q4922 Ayrenn Divine Glow

    -- Passage Denied
    [47301] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_ayleid_wand_of_blockade.dds'; name = Abilities.Skill_Close_Portal }; -- Stunned

    -- The Blacksap's Hold
    [39247] = { hide = true }; -- RobS Stun .5 Sec
    [39244] = { icon = '/esoui/art/icons/achievement_wrothgar_044.dds'; name = Abilities.Skill_Push }; -- Q4917 Push Player Back
    [39260] = { icon = '/esoui/art/icons/achievement_wrothgar_044.dds'; name = Abilities.Skill_Push; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Q4917 Push Player Back
    [41342] = { hide = true }; -- 10 Second Timer
    [39312] = { hide = true }; -- CON_Portal Perm
    [39308] = { hide = true }; -- Stun
    [39384] = { hide = true }; -- Q4917 Lurcher Construct Ground
    [41325] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_blacksaps_brew.dds'; tooltip = Tooltips.Skill_Blacksaps_Brew; forcedContainer = 'long' }; -- Blacksap's Brew

    -- Luck of the Albatross
    [35984] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_captains_whistle.dds'; name = Abilities.Skill_Call_for_Help }; -- Q4436 Summon Pirate

    -- Scars Never Fade
    [41339] = { hide = true }; -- RobS Stun 3 Sec
    [43151] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bucket_of_water.dds'; name = Abilities.Skill_Throw_Water }; -- Q4768 Use Bucket

    -- Keeper of the Bones
    [35854] = { hide = true }; -- Q4773 Dringoth Splode
    [35862] = { hide = true }; -- Possessed
    [35857] = { hide = true }; -- Q4773 Dringoth Proxy Splode

    -- Bosmer Insight
    [36438] = { hide = true }; -- Q4833
    [36544] = { hide = true }; -- Fast Jumper
    [35991] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_vision_journey.dds'; tooltip = Tooltips.Skill_Vision_Journey; forcedContainer = 'long' }; -- Vision Journey
    [36883] = { hide = true }; -- Q4833 Teleport into Tree
    [36882] = { hide = true }; -- Q4833 Teleport into Tree
    [36710] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_snake_scales.dds'; name = Abilities.Skill_Snake_Scales }; -- Q4833 Apply Snake Buff
    [36713] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_snake_scales.dds'; tooltip = Tooltips.Skill_Snakes_Scales; forcedContainer = 'long' }; -- Snake Scales
    [36841] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wolfs_pelt.dds'; name = Abilities.Skill_Wolfs_Pelt }; -- Q4833 Apply Wolf Buff
    [36843] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wolfs_pelt.dds'; tooltip = Tooltips.Skill_Wolfs_Pelt; forcedContainer = 'long' }; -- Wolf's Pelt
    [36824] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tigers_fur.dds'; name = Abilities.Skill_Tigers_Fur }; -- Q4833 Apply Tiger Buff
    [36828] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tigers_fur.dds'; tooltip = Tooltips.Skill_Tigers_Fur; forcedContainer = 'long' }; -- Tiger's Fur

    -- The Unquiet Dead
    [37062] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bone_scepter.dds'; hide = true }; -- Exorcise
    [36887] = { hide = true }; -- Kithshade Stun
    [36766] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds'; name = Abilities.Skill_Feedback; tooltip = Tooltips.Generic_Stun; unbreakable = 1 }; -- Q4842 Stun Headgrab Knockback
    [36998] = { hide = true }; -- Bind Spirit
    [36996] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bone_scepter.dds' }; -- Bind Spirit
    [37365] = { hide = true }; -- Q4842 Stun

    -- Eyes of Azura
    [37205] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds'; name = Abilities.Skill_Soul_Binding; tooltip = Tooltips.Skill_Soul_Binding }; -- Animus Geode
    [37677] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds'; name = Abilities.Skill_Soul_Binding }; -- Geodesic Corruption
    [37211] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds'; name = Abilities.Skill_Empower_Heart }; -- Q4854 Empower Heart
    [37386] = { hide = true }; -- Vas out
    [38246] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds'; name = Abilities.Skill_Soul_Binding }; -- Animus Geode
    [37585] = { hide = true }; -- Q4854 Culanwe Fire B

    -- Flipping the Coin
    [39309] = { hide = true }; -- Q4983 Stone Cats

    --------------------
    -- Greenshade
    --------------------

    -- Public Dungeon - Rulanyil's Fall
    [33581] = { hide = true }; -- DUN-RF_Event_Blue_Fire

    -- Audience with the Wilderking
    [37759] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_spirit_armor.dds'; tooltip = Tooltips.Skill_Spirit_Armor; forcedContainer = 'long' }; -- Spirit Armor

    -- The Witch of Silatar
    [33384] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grasping_vines.dds'; name = Abilities.Skill_Restricting_Vines; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Q4586 Aranias Vine Stun
    [33066] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_change_clothes.dds'; name = Abilities.Skill_Change_Clothes; tooltip = Tooltips.Skill_Fancy_Clothing }; -- Q4586_ChangeClothes
    [34842] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_change_clothes.dds'; name = Abilities.Skill_Change_Clothes; tooltip = Tooltips.Skill_Fancy_Clothing }; -- Q4586_ChangeClothesFEMALE
    [49116] = { hide = true }; -- Q4586_HugeTree

    -- Throne of the Wilderking
    [35014] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wilderkings_protection.dds'; tooltip = Tooltips.Skill_Wilderkings_Protection; forcedContainer = 'long' }; -- Wilderking's Protection
    [33701] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds'; name = Abilities.Skill_Burrow; hide = true }; -- BurrowEND
    [33727] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds'; name = Abilities.Skill_Emerge; hide = true }; -- BurrowEND
    [33829] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds'; name = Abilities.Skill_Burrow; tooltip = Tooltips.Skill_Burrow }; -- Burrowing
    [37506] = { hide = true }; -- Stealth

    -- Pelidil's End
    [33577] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blast_furnace.dds' }; -- Maormer Fire
    [48049] = { hide = true }; -- Q4765 Block Dummy Fire
    [48054] = { hide = true }; -- Q475 Impact Increment
    [50765] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_damage.dds'; name = Abilities.Skill_Serpent_Spit }; -- CON_AOE_Template1
    [35697] = { icon = 'LuiExtended/media/icons/abilities/ability_serpent_chomp.dds' }; -- Serpent Chomp (Maormer Serpent)

    -- Retaking the Pass
    [45650] = { hide = true }; -- Indaenir's Spell
    --[29504] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_shadow_wood.dds', name = Abilities.Skill_Shadow_Wood, tooltip = Tooltips.Skill_Shadow_Wood }, -- Q4546 Shade Layer

    -- The Blight of the Bosmer
    [34499] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_absorb_corruption.dds'; name = Abilities.Skill_Disperse_Corruption }; -- Corruption Beam (Generic Invisible Target)

    -- Right of Theft
    [34346] = { icon = '/esoui/art/icons/achievement_u23_dun1_killmonstersa.dds'; tooltip = Tooltips.Skill_Ancient_Wrath; stack = 0 }; -- Ancient Wrath (Player)
    [34824] = { icon = '/esoui/art/icons/achievement_u23_dun1_killmonstersa.dds' }; -- Ancient Wrath (Player)

    -- Striking at the Heart
    [48491] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_corrupt_lurchers.dds'; name = Abilities.Skill_Call_Corrupt_Lurchers }; -- Q4960 Naemon Shield Shade (Shade of Naemon)
    [48498] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_skeleton.dds'; name = Abilities.Skill_Undead_Legion }; -- Q4960 Necor Skele Rise ((Shade of Naemon)

    --------------------------------------
    -- QUEST / ZONES - DAGGERFALL COVENANT --
    --------------------------------------

    --------------------
    -- Stros M'Kai
    --------------------

    -- Main Quest - Buried Secrets
    [26535] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_control_rod.dds'; name = Abilities.Skill_Neramos_Control_Rod }; -- Control Rod (Neramo's Spider)

    -- Main Quest - Like Moths to a Candle
    [27755] = { hide = true }; -- Sea Drake Disguise (Crafty Lerisa)
    [26895] = { hide = true }; -- Sea Drake Uniform (Crafty Leris)
    [28246] = { hide = true }; -- Sea Drake Uniform (Mekag gro-Bug)
    [28244] = { hide = true }; -- Sea Drake Uniform (Haerdon)
    [28242] = { hide = true }; -- Sea Drake Uniform (Crenard Doretene)
    [79989] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_mercy_kill.dds' }; -- Mercy Kill

    -- Main Quest - Tip of the Spearhead
    [27649] = { hide = true }; -- Servant Disguise (Crafty Lerisa)

    -- Side Quest - Washed Ashore
    [45950] = { hide = true }; -- Dirt Clods (Sand-Covered Blade)

    --------------------
    -- Betnikh
    --------------------

    -- Main Quest - Unearthing the Past
    [26948] = { hide = true }; -- Bloodthorn Uniform (Crafty Lerisa)
    [44189] = { hide = true }; -- RobS Stun 2.25 Sec (Abomination of Wrath/Fear/Hate)
    [28358] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_time.dds'; name = Abilities.Skill_Vision_of_the_Past; tooltip = Tooltips.Skill_Vision_of_the_Past }; -- Q4468 Orc Raider Disguise

    -- Main Quest - Tormented Souls
    [30929] = { hide = true }; -- Magicka (Neramo)

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
    ]]
    --

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    --[[
    [74875] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Catapult (The Hidden Harvest)
    [64734] = { name = 'Harpy Swoop', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Q5318 - Harpy Swoop In (The Hidden Harvest)
    [74104] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grasping_vines.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Grasping Vines (The Hidden Harvest)
    [74105] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grasping_vines.dds' }, -- Grasping Vines (The Hidden Harvest)
    [64316] = { icon = 'LuiExtended/media/icons/abilities/ability_frost_fortress.dds' }, -- Frost Fortress (For King and Glory - Urfon Ice-Heart)
    [64363] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds' }, -- Savage Winds (For King and Glory - Urfon Ice-Heart)
    [66277] = { icon = 'LuiExtended/media/icons/equipment_disguise.dds', name = 'Vosh Rakh Illusion' }, -- Vosh Rakh Recruit Disg (The Anger of a King)
    [66397] = { icon = 'esoui/art/icons/ability_healer_027.dds' }, -- Avalian's Speed (The Anger of a King)
    [66399] = { icon = 'esoui/art/icons/ability_warrior_012.dds' }, -- Usunok's Strength (The Anger of a King)
    [66415] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Gust' }, -- Uppercut Stun (The Anger of a King)
    [53291] = { icon = 'esoui/art/icons/ability_destructionstaff_001a.dds', name = Abilities.Skill_Crushing_Shock }, -- Uber Attack (The Anger of a King - Talviah Aliaria)
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
    ]]
    --

    ----------------------------------------------------------------
    -- ELSWEYR     -------------------------------------------------
    ----------------------------------------------------------------

    -- Main Quest - Tutorial - Bright Moons, Warm Sands
    [124493] = { hide = true }; -- Sparring Stamina
    [121005] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_heavy.dds' }; -- Heavy Attack (Grand Adept Ma'hja-dro)
    [121018] = { hide = true }; -- Block Me (Grand Adept Ma'hja-dro)
    [121024] = { hide = true }; -- Off-Balance (Grand Adept Ma'hja-dro)
    [126526] = { hide = true }; -- Off-Balance (Grand Adept Ma'hja-dro)
    [126569] = { hide = true }; -- Off-Balance Exploit (Grand Adept Ma'hja-dro)
    [121032] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; tooltip = Tooltips.Generic_Stun_No_Dur; cc = LUIE_CC_TYPE_STUN }; -- Bash (Grand Adept Ma'hja-dro)
    [126501] = { hide = true }; -- Bash (Grand Adept Ma'hja-dro)
    [121039] = { hide = true }; -- Dagger Toss (Grand Adept Ma'hja-dro)
    [121040] = { hide = true }; -- Off-Balance (Grand Adept Ma'hja-dro)
    [126573] = { hide = true }; -- Off-Balance (Grand Adept Ma'hja-dro)
    [126572] = { hide = true }; -- Off-Balance Exploit (Grand Adept Ma'hja-dro)
    [121475] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_devastating_leap.dds' }; -- Devastating Leap (Bone Flayer)
    [121476] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger; cc = LUIE_CC_TYPE_STAGGER }; -- Devastating Leap (Bone Flayer)
    [121473] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }; -- Flurry (Bone Flayer)
    [121474] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }; -- Flurry (Bone Flayer)
    [121456] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear_euraxian.dds'; hide = true }; -- Necrotic Spear (Euraxian Necromancer)
    [121643] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_damage.dds' }; -- Defiled Ground (Euraxian Necromancer)
    [121644] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_damage.dds'; tooltip = Tooltips.Generic_AOE_Magic; groundLabel = true; tooltipValue2 = 0.7 }; -- Defiled Ground (Euraxian Necromancer)
    [121645] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_stun.dds'; tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Defiled Ground (Euraxian Necromancer)
    [121402] = { hide = true }; -- Sum Necro Skeleton (Euraxian Necromancer)
    [121458] = { hide = true }; -- Sum Necro Skeleton (Euraxian Necromancer)
    [119292] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_dragonhorn.dds'; name = Abilities.Skill_Star_Haven_Dragonhorn; hide = true }; -- Stun (Player)
    [121354] = { hide = true }; -- Boss (Bahlokdaan)
    [121294] = { tooltip = Tooltips.Generic_Knockdown_No_Dur; cc = LUIE_CC_TYPE_KNOCKDOWN }; -- Unrelenting Force (Bahlokdaan)
    [121349] = { hide = true }; -- Unrelenting Force (Bahlokdaan)
    [121351] = { hide = true }; -- Unrelenting Force (Bahlokdaan)
    [124337] = { hide = true }; -- Unrelenting Force (Bahlokdaan)
    [124351] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_flame_aura.dds'; name = Abilities.Skill_Flame_Aura; tooltip = Tooltips.Skill_Flame_Aura }; -- Dragon Aura (Bahlokdaan)
    [124352] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_flame_aura.dds' }; -- Dragon Aura (Bahlokdaan)
    [125281] = { icon = '/esoui/art/icons/ability_u24_drg_breath_flame.dds' }; -- Sweeping Breath (Bahlokdaan)
    [125287] = { hide = true }; -- Sweeping Breath (Bahlokdaan)
    [125285] = { hide = true }; -- Sweeping Breath (Bahlokdaan)
    [122194] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_bite.dds' }; -- Bite (Bahlokdaan)
    [125244] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_headbutt.dds'; name = Abilities.Skill_Headbutt }; -- Head Strike (Bahlokdaan)
    [125270] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_headbutt.dds' }; -- Headbutt (Bahlokdaan)
    [125271] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_headbutt.dds' }; -- Headbutt (Bahlokdaan)
    [125268] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_headbutt.dds'; tooltip = Tooltips.Generic_Knockback; cc = LUIE_CC_TYPE_KNOCKBACK }; -- Headbutt (Bahlokdaan)
    [125272] = { name = Abilities.Innate_Stagger }; -- Headbutt (Bahlokdaan)
    [125269] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_headbutt.dds'; tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Headbutt (Bahlokdaan)
    [125570] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_chomp.dds' }; -- Chomp (Bahlokdaan)
    [122200] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_chomp.dds' }; -- Chomp (Bahlokdaan)
    [122201] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_chomp.dds' }; -- Chomp (Bahlokdaan)
    [122199] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_chomp.dds' }; -- Chomp (Bahlokdaan)
    [117192] = { icon = 'LuiExtended/media/icons/abilities/ability_dragon_chomp.dds'; tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Chomp (Bahlokdaan)
    [125241] = { icon = '/esoui/art/icons/ability_u24_drg_tailswipe.dds' }; -- Tail Whip (Bahlokdaan)
    [125575] = { hide = true }; -- Tail Swipe (Bahlokdaan)
    [125266] = { icon = '/esoui/art/icons/ability_u24_drg_tailswipe.dds' }; -- Tail Whip (Bahlokdaan)
    [125263] = { tooltip = Tooltips.Generic_Knockback; cc = LUIE_CC_TYPE_KNOCKBACK }; -- Tail Whip (Bahlokdaan)
    [125267] = { name = Abilities.Innate_Stagger }; -- Tail Whip (Bahlokdaan)
    [125264] = { tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Tail Whip (Bahlokdaan)
    [125242] = { icon = '/esoui/art/icons/ability_u24_drg_wingthrash.dds' }; -- Wing Thrash (Bahlokdaan)
    [125277] = { hide = true }; -- Wing Swipe (Bahlokdaan)
    [125250] = { icon = '/esoui/art/icons/ability_u24_drg_wingthrash.dds' }; -- Wing Thrash (Bahlokdaan)
    [125245] = { tooltip = Tooltips.Generic_Knockback; cc = LUIE_CC_TYPE_KNOCKBACK }; -- Wing Thrash (Bahlokdaan)
    [125249] = { icon = '/esoui/art/icons/ability_debuff_stagger.dds'; name = Abilities.Innate_Stagger }; -- Wing Swipe (Bahlokdaan)
    [125246] = { name = Abilities.Skill_Wing_Thrash; tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Wing Swipe (Bahlokdaan)
    [125243] = { icon = '/esoui/art/icons/ability_u24_drg_wingthrash.dds' }; -- Wing Thrash (Bahlokdaan)
    [125274] = { hide = true }; -- Wing Swipe (Bahlokdaan)
    [125256] = { icon = '/esoui/art/icons/ability_u24_drg_wingthrash.dds' }; -- Wing Thrash (Bahlokdaan)
    [125253] = { tooltip = Tooltips.Generic_Knockback; cc = LUIE_CC_TYPE_KNOCKBACK }; -- Wing Thrash (Bahlokdaan)
    [125257] = { icon = '/esoui/art/icons/ability_debuff_stagger.dds'; name = Abilities.Innate_Stagger }; -- Wing Swipe (Bahlokdaan)
    [125254] = { name = Abilities.Skill_Wing_Thrash; tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Wing Swipe (Bahlokdaan)
    [123118] = { hide = true }; -- Takeoff (Bahlokdaan)
    [124286] = { hide = true }; -- Set Area (grand Adept Ma'hja-dro)
    [124283] = { hide = true }; -- Roll Dodge (grand Adept Ma'hja-dro)
    [124272] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_focused_healing.dds' }; -- Focused Healing (Grand Adept Ma'hja-dro)
    [124310] = { icon = '/esoui/art/icons/ability_restorationstaff_001.dds'; name = Abilities.Skill_Steadfast_Ward; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Master's Shield (Grand Adept Ma'hja-dro)

    ----------------------------------------------------------------
    -- GREYMOOR     ------------------------------------------------
    ----------------------------------------------------------------

    [136859] = { hide = true }; -- Pushback (Player)
    [113262] = { hide = true }; -- CVFHeal CombatDet NOB InCombat (Fennorian)
    [113273] = { hide = true }; -- CVFHeal CombatDet STN Start (Fennorian)
    [113275] = { hide = true }; -- CVFHeal CombatDet STN End (Fennorian)
    [113261] = { hide = true }; -- CVFHEAL CombatDet Root (Fennorian)
    [113278] = { hide = true }; -- Damage (Fennorian)
    [113271] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_heal.dds'; hide = true }; -- Heal (Fennorian)
    [131865] = { icon = '/esoui/art/icons/ability_2handed_001.dds'; hide = true }; -- Uppercut (Vitrus the Bloody)
    [131864] = { icon = '/esoui/art/icons/ability_2handed_001.dds'; tooltip = Tooltips.Generic_Knockback; cc = LUIE_CC_TYPE_KNOCKBACK }; -- Uppercut (Vitrus the Bloody)
    [131861] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_throw_dagger_tutorial.dds'; name = Abilities.Skill_Piercing_Dagger; hide = true }; -- Throw Dagger (Vitrus the Bloody)
    [131862] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_throw_dagger_tutorial.dds'; name = Abilities.Skill_Piercing_Dagger; tooltip = Tooltips.Generic_Stun; cc = LUIE_CC_TYPE_STUN }; -- Stunned (Vitrus the Bloody)
    [135039] = { hide = true }; -- Drop In (Frostbite Spider)
    [99566] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_spawn_hatchlings.dds' }; -- Falling Spiders (Frostbite Spider)
    [135773] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; name = Abilities.Skill_Frostbolt }; -- Flare (Matron Urgala)
    [135612] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frost_wave.dds'; hide = true }; -- Frost Wave (Matron Urgala)
    [135627] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frost_wave.dds'; hide = true }; -- Frost Wave (Matron Urgala)
    [135672] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_frost_wave.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 25; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; noDuplicate = true; cc = LUIE_CC_TYPE_SNARE }; -- Frost Wave (Matron Urgala)
    [135718] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_freezing_vines.dds'; name = Abilities.Skill_Freezing_Vines }; -- Frost Vines (Matron Urgala)
    [135721] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_freezing_vines.dds'; name = Abilities.Skill_Freezing_Vines; hideReduce = true; tooltip = Tooltips.Skill_Freezing_Vines; cc = LUIE_CC_TYPE_ROOT }; -- Frost Vines (Matron Urgala)
    [135720] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_freezing_vines.dds'; name = Abilities.Skill_Freezing_Vines; tooltip = Tooltips.Skill_Freezing_Vines; cc = LUIE_CC_TYPE_ROOT }; -- Frost Vines (Matron Urgala)
    [135723] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_freezing_vineburst.dds'; name = Abilities.Skill_Freezing_Vineburst }; -- Frost Vines (Matron Urgala)

    ----------------------------------------------------------------
    -- VVARDENFELL     ---------------------------------------------
    ----------------------------------------------------------------

    -- SQ (An Armiger's Duty)
    [90073] = { hide = true }; -- Blinding Light
    [89753] = { hide = true }; -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [89754] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }; -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [86865] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_powered_up.dds' }; -- Powered Up (Centurion Mthgrazzen - A Melodic Mistake)
    [86633] = { hide = true }; -- Barrier Break (A Melodic Mistake)
    [85264] = { hide = true }; -- Sacrifice (Divine Inquiries)
    [85265] = { hide = true }; -- Sacrifice (Divine Inquiries)
    [85266] = { hide = true }; -- Sacrifice (Divine Inquiries)
    [92580] = { hide = true }; -- Q5887 - AshurStealthOut (Fleeing the Past)
    [95123] = { hide = true }; -- Q5933 - NaryuStuckProtection (A Purposeful Writ)
    [86981] = { hide = true }; -- Summon Skaafin (Vvardenfell - Various Quest NPC's)
    [85105] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_unstable_reaction.dds'; hide = true }; -- Unstable Reaction (Reclaiming Vos)
    [85537] = { hide = true }; -- Summon Personal Guard (Reclaiming Vos)
    [92720] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds' }; -- Necrotic Wave (Vvardenfell -- Ancestral Adversity)
    [92722] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds'; name = 'Necrotic Wave' }; -- Stomp of Flame (Vvardenfell -- Ancestral Adversity)
    [92723] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds'; name = 'Necrotic Wave'; hide = true }; -- Fire Backlash (Vvardenfell -- Ancestral Adversity)
    [92721] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds'; name = 'Necrotic Wave' }; -- CON_Knockback&Knockdown (Vvardenfell -- Ancestral Adversity)
    [86743] = { icon = '/esoui/art/icons/achievement_morrowind_031.dds'; hide = true }; -- Accelerated Transposition (Like Blood from a Stone)
    [90511] = { icon = '/esoui/art/icons/achievement_morrowind_031.dds'; hide = true }; -- Accelerated Transposition (Like Blood from a Stone)
    [88425] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shattered_ground.dds' }; -- Shattered Ground (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88416] = { hide = true }; -- Awaken the Colony (Th'krak the Tunnel-King -- Delve -- Matus-Akin Egg Mine)
    [88417] = { hide = true }; -- Awaken the Colony (Th'krak the Tunnel-King -- Delve -- Matus-Akin Egg Mine)
    [88419] = { hide = true }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88422] = { hide = true }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88427] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds'; name = Abilities.Skill_Plow; hide = true }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88431] = { hide = true }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88432] = { hide = true }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88426] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds'; name = Abilities.Skill_Plow }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88433] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds'; name = Abilities.Skill_Plow; hide = true }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88435] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = 'Charge Stun'; hide = true }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88437] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = 'Charge Stun'; hide = true }; -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [14374] = { hide = true }; -- Generic Dwemer Smoke Plume
    [93221] = { hide = true }; -- Surprise!
    [16910] = { hide = true }; -- Corruption Aura (Objections and Obstacles)
    [89756] = { icon = '/esoui/art/icons/achievement_wrothgar_006.dds'; name = 'Centurion Drop'; unbreakable = 1 }; -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [89757] = { icon = '/esoui/art/icons/achievement_wrothgar_006.dds'; name = 'Centurion Drop' }; -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [84273] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }; -- Sweeping Spin (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [87738] = { hide = true }; -- Powder Bomb (The Heart of a Telvanni)
    [89564] = { hide = true }; -- Knockout (The Heart of a Telvanni)
    [88244] = { hide = true }; -- The Slavemaster's Chains (The Heart of a Telvanni)
    [77541] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds'; name = 'Mighty Strike' }; -- Brand's Cleave (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [77542] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds'; name = 'Mighty Strike' }; -- Brand's Cleave (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82276] = { hide = true }; -- Dark Reach (The Heart of a Telvanni)
    [82274] = { icon = '/esoui/art/icons/ability_dragonknight_005.dds'; name = Abilities.Skill_Fiery_Grip }; -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82275] = { name = Abilities.Skill_Fiery_Grip }; -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [89266] = { hide = true }; -- Summon Spider
    [89269] = { hide = true }; -- Summon Spider
    [89276] = { hide = true }; -- Summon Exploder
    [89278] = { hide = true }; -- Summon Exploder
    [89277] = { hide = true }; -- Summon Exploder
    [89268] = { hide = true }; -- Summon Spider
    [89282] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds'; hide = true }; -- Spider Explosion
    [89274] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds'; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Spider Explosion
    [87958] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_snare.dds' }; -- Ash Storm (Divine Delusions)
    [87959] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_snare.dds' }; -- Ash Storm (Divine Delusions)
    [86972] = { hide = true }; -- Q5888 Chodala Magic Shield FX (Divine Delusions)
    [90630] = { hide = true }; -- Frenzy (Divine Delusions)
    [86353] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_mechanical_possession.dds' }; -- Mechanical Possession (Vvardenfell -- Divine Intervention)
    [86417] = { hide = true }; -- Mechanical Possession (Divine Intervention)
    [86349] = { hide = true }; -- Inactive Centurion (Divine Intervention)

    -- Vvardenfell MQ -- Divine Intervention
    [91006] = { hide = true }; -- Chodala's Shield
    [86815] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Daedric Bolt
    [90140] = { hide = true }; -- Sunder's Echo
    [90148] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pillars_of_nirn.dds' }; -- Sunder's Echo
    [90146] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pillars_of_nirn.dds'; hide = true }; -- Sunder's Echo
    [90147] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pillars_of_nirn.dds' }; -- Sunder's Echo
    [90139] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blink_strike.dds' }; -- Empowered Strike
    [90141] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blink_strike.dds' }; -- Empowered Strike
    [90142] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blink_strike.dds' }; -- Empowered Strike
    [88963] = { hide = true }; -- Delay

    -- VVARDENFELL MQ - Divine Disaster
    [88466] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_volcano_meteor.dds' }; -- Skyfall
    [88467] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_volcano_meteor.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Skyfall
    [92536] = { hide = true }; -- Vulnerability to Meteors

    -- VVARDENFELL MQ - Divine Restoration
    [87104] = { hide = true }; -- Stun (Blade Trap - Divine Restoration)
    [87102] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = 'Spinning Blade Trap' }; -- Spinning Blade
    [91970] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = 'Spinning Blade Trap'; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Serrated Blade
    [91969] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = 'Spinning Blade Trap' }; -- Serrated Blade
    [89330] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_torrent.dds'; hide = true }; -- Defensive Flare
    [89750] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_damage.dds' }; -- Pulse
    [92213] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sparks.dds'; hide = true }; -- Sparks
    [92229] = { hide = true }; -- Pulse
    [92227] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_damage.dds' }; -- Pulse
    [92225] = { icon = '/esoui/art/icons/achievement_vvardenfel_013.dds' }; -- Repair
    [89761] = { hide = true }; -- Fabricate Beetle
    [90528] = { hide = true }; -- Loyal Hound
    [87038] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_spinning_blades.dds' }; -- Spinning Blades
    [87040] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_spinning_blades.dds'; name = 'Spinning Blades'; hide = true }; -- Pinning Blades
    [87039] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_spinning_blades.dds'; name = 'Spinning Blades' }; -- Pinning Blades
    [87047] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lunge.dds' }; -- Lunge
    [87051] = { hide = true }; -- Lunge
    [87048] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lunge.dds' }; -- Lunge
    [87050] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lunge.dds'; hide = true }; -- Lunge
    [87049] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lunge.dds' }; -- Lunge
    [87090] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds'; hide = true }; -- Barbs
    [87096] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Barbs
    [90599] = { hide = true }; -- Daedric Vigor
    [92284] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_planar_shear.dds' }; -- Planar Shear
    [90627] = { hide = true }; -- targetable
    [90566] = { hide = true }; -- Loyal Hound
    [90567] = { hide = true }; -- Loyal Hound
    [90568] = { hide = true }; -- Loyal Hound
    [90569] = { hide = true }; -- Loyal Hound
    [87503] = { icon = '/esoui/art/icons/achievement_vvardenfel_012.dds'; name = 'Divine Energy' }; -- Divine Hijack
    [90616] = { icon = '/esoui/art/icons/achievement_vvardenfel_012.dds'; name = 'Divine Energy' }; -- Divine Hijack
    [87525] = { hide = true }; -- Divine Hijack
    [87522] = { icon = '/esoui/art/icons/achievement_vvardenfel_012.dds'; name = 'Divine Energy' }; -- Divine Hijack
    [90524] = { hide = true }; -- Divine Hijack
    [92413] = { hide = true }; -- Contrived Portal

    -- Tutorial
    [92245] = { hide = true }; -- MQ1 Input Lock LAtk
    [83416] = { icon = 'LuiExtended/media/icons/abilities/ability_attack_unarmed_heavy.dds' }; -- Heavy Attack
    [93577] = { hide = true }; -- MQ1 Tutorial Block Heavy
    [92263] = { hide = true }; -- Perma Set Off Balance Target
    [92266] = { hide = true }; -- MQ1 Tutorial Perma Off-Balance
    [92238] = { hide = true }; -- MQ1 Heat Wave (Tutorial)
    [92668] = { icon = '/esoui/art/icons/ability_dualwield_005.dds' }; -- Whirlwind
    [88904] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds'; name = Abilities.Skill_Bear_Trap; tooltip = Tooltips.Generic_Stun_No_Dur; cc = LUIE_CC_TYPE_STUN }; -- Metal Trap
    [88905] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds'; name = Abilities.Skill_Bear_Trap }; -- Metal Trap

    -- The Forgotten Wastes (Public Dungeon)
    [91659] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds'; hide = true }; -- Falling Rocks -- Deadfall
    [88030] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds'; name = Abilities.Trap_Falling_Rocks }; -- Falling Rocks -- Deadfall
    [92671] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_volcano_meteor.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Pyroclast -- Meteor
    [92672] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_volcano_meteor.dds' }; -- Pyroclast -- Meteor
    [86983] = { icon = '/esoui/art/icons/ability_mage_018.dds'; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Succubus Touch
    [86984] = { hide = true }; -- Succubus Touch
    [86930] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris
    [86932] = { hide = true }; -- Volcanic Debris
    [90500] = { hide = true }; -- Volcanic Debris
    [86934] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris
    [86939] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris
    [86938] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris
    [92702] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris
    [92709] = { hide = true }; -- Volcanic Debris
    [92703] = { hide = true }; -- Volcanic Debris
    [92707] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris
    [92706] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris
    [92704] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_debris.dds' }; -- Volcanic Debris

    -- Nchuleftingth (Public Dungeon)
    [84527] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds' }; -- Searing Steam
    [90271] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }; -- Charge-Wire Shock (Dwarven Charge-Wire)
    [90269] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }; -- Charge-Wire Shock (Dwarven Charge-Wire)
    [90268] = { hide = true }; -- Charge Whire Shock -- Generic Flame Wave Target
    [92135] = { hide = true }; -- Nchuleftingth Electricity (Dwarven Charge-Wire)
    [86634] = { hide = true }; -- Swinging Cleave (Mud-Tusk)
    [86635] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds' }; -- Swinging Cleave (Mud-Tusk)
    [89210] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Mud-Tusk)
    [89240] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Mud-Tusk)
    [89239] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Mud-Tusk)
    [94935] = { hide = true }; -- Tremor (Mud-Tusk)
    [94936] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds' }; -- Tremor (Mud-Tusk)
    [86613] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds'; name = 'Steam Piston' }; -- Piston Thrust (Dwarven Piston)
    [86623] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds'; name = 'Steam Piston' }; -- Piston Thrust (Dwarven Piston)
    [90860] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds'; name = 'Steam Piston' }; -- Spike Trap (Dwarven Piston)
    [90859] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds'; name = 'Steam Piston' }; -- Swinging Blades (Dwarven Piston)
    [86591] = { hide = true }; -- Piston Thrust
    [86592] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }; -- Piston Thrust
    [86596] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }; -- Piston Thrust
    [86595] = { hide = true }; -- Piston Thrust
    [69284] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_whirlwind_function.dds' }; -- Whirlwind Function (Guardian of Bthark)
    [86606] = { hide = true }; -- Steam Breath (Guardian of Bthark)
    [86607] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds' }; -- Steam Breath (Guardian of Bthark)
    [90192] = { hide = true }; -- Overcharge (Nchuleftingth)
    [90212] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }; -- Overcharge (Nchuleftingth)
    [90214] = { hide = true }; -- Overcharge (Nchuleftingth)
    [90215] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }; -- Overcharge (Nchuleftingth)
    [90216] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }; -- Overcharge (Nchuleftingth)
    [90217] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }; -- Overcharge (Nchuleftingth)
    [71919] = { hide = true }; -- Turret Occupied (Nchuleftingth)
    [71920] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_turret_mode.dds' }; -- Turret Occupied (Nchuleftingth)
    [86566] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_rune.dds' }; -- Fire Runes (Friar Hadelar)
    [86575] = { icon = '/esoui/art/icons/ability_1handed_003.dds' }; -- Shield Charge (Renduril the Hammer)
    [86570] = { icon = '/esoui/art/icons/ability_1handed_003.dds' }; -- Shield Charge (Renduril the Hammer)
    [86576] = { name = Abilities.Innate_Stagger; hide = true }; -- Staggered (Renduril the Hammer)
    [86574] = { hide = true }; -- Shield Charge -- Renduril the Hammer
    [51634] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }; -- Shocking Touch (Steamreaver - Nchuleftingth)
    [86680] = { hide = true }; -- Auditory Signal (Steamreaver)
    [86691] = { hide = true }; -- Overcharge (Nchuleftingth)
    [86690] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }; -- Overcharge (Nchuleftingth)
    [86688] = { hide = true }; -- Overcharge (Nchuleftingth)
    [86689] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Nchuleftingth)
    [92136] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds'; name = 'Overcharged Shock'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Laser Snare (Dwarven Charge-Wire)
    [92138] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds'; name = 'Overcharged Shock' }; -- Laser Damage (Dwarven Charge-Wire)
    [89998] = { hide = true }; -- Auditory Command (Artisan Lenarmen)
    [90004] = { hide = true }; -- Auditory Command (Artisan Lenarmen)
    [90005] = { hide = true }; -- Auditory Command (Artisan Lenarmen)
    [90006] = { hide = true }; -- Auditory Command (Artisan Lenarmen)
    [90007] = { hide = true }; -- Auditory Command (Artisan Lenarmen)
    [90008] = { hide = true }; -- Auditory Command (Artisan Lenarmen)
    [90009] = { hide = true }; -- Auditory Command (Artisan Lenarmen)
    [90010] = { hide = true }; -- Auditory Command (Artisan Lenarmen)
    [84333] = { icon = '/esoui/art/icons/achievement_vvardenfel_013.dds' }; -- Demolish (Nchulaeon the Eternal)
    [84336] = { icon = '/esoui/art/icons/achievement_vvardenfel_013.dds'; hide = true }; -- Demolish (Nchulaeon the Eternal)
    [90788] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [84739] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [84755] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [91407] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [90821] = { hide = true }; -- Enable (Nchulaeon the Eternal)
    [90863] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [90867] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [91485] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [90870] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [90874] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [91486] = { hide = true }; -- Indominable (Nchulaeon the Eternal)
    [84606] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_damage.dds'; hide = true }; -- Momentum
    [84616] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_damage.dds' }; -- Momentum
    [90597] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderbolt.dds' }; -- Overcharge Explusion
    [90598] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderbolt.dds'; hide = true }; -- Overcharge Explusion

    ----------------------------------------------------------------
    -- SUMMERSET     -----------------------------------------------
    ----------------------------------------------------------------

    [100678] = { hide = true }; -- Major Protection (The Mind Trap)
    [100671] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_heavy.dds' }; -- Heavy Attack (The Mind Trap)
    [100683] = { hide = true }; -- Block Me (The Mind Trap)
    [100677] = { hide = true }; -- Block Me (The Mind Trap)
    [100687] = { hide = true }; -- Off-Balance (The Mind Trap)
    [100690] = { hide = true }; -- Off-Balance (The Mind Trap)
    [100733] = { hide = true }; -- Heat Wave (The Mind Trap)

    [105498] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghralarva_flog.dds' }; -- Flog (Yaghra Larva)
    [105540] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghralarva_body_bash.dds' }; -- Body Bash (Yaghra Larva)
    [105561] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghralarva_momentous_discharge.dds'; hide = true }; -- Momentous Discharge (Yaghra Larva)

    [105601] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds' }; -- Explosive Toxins (Yaghra Larva)
    [108773] = { hide = true }; -- Explosive Toxins (Yaghra Larva)
    [105604] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds' }; -- Explosive Toxins (Yaghra Larva)

    [105737] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_stab.dds' }; -- Stab (Yaghra Nightmare)
    [105739] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_stab.dds' }; -- Stab (Yaghra Nightmare)
    [107282] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_impale.dds' }; -- Impale (Yaghra Nightmare)
    [107299] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_impale.dds' }; -- Impale (Yaghra Nightmare)

    [105867] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_damage.dds' }; -- Pustulant Eruption (Yaghra Nightmare)
    [105889] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_damage.dds' }; -- Pustulant Eruption (Yaghra Nightmare)
    [105912] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_snare_alt.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50; cc = LUIE_CC_TYPE_SNARE }; -- Pustulant Eruption (Yaghra Nightmare)
    [105893] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_damage.dds'; name = Abilities.Skill_Pustulant_Eruption }; -- Pustulant Film (Yaghra Nightmare)

    ----------------------------------------------------------------
    -- ARENA    ----------------------------------------------------
    ----------------------------------------------------------------

    -- Dragonstar Arena (Stage 1)
    [52733] = { icon = '/esoui/art/icons/ability_fightersguild_003_a.dds'; hide = true }; -- Silver Shards (Fighters Guild Swordmaster)
    [52735] = { icon = '/esoui/art/icons/ability_fightersguild_003_a.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Silver Shards (Fighters Guild Swordmaster)
    [75845] = { icon = '/esoui/art/icons/ability_fightersguild_003_a.dds' }; -- Silver Shards (Fighters Guild Swordmaster)
    [52729] = { tooltip = Tooltips.Skill_Expert_Hunter_NPC }; -- Expert Hunter (Fighters Guild Swordmaster)
    [52738] = { name = Abilities.Skill_Circle_of_Protection_NPC }; -- Circle of Protection (Fighters Guild Gladiator)
    [52744] = { name = Abilities.Skill_Circle_of_Protection_NPC; duration = 0; groundLabel = true; tooltip = Tooltips.Skill_Circle_of_Protection_NPC }; -- Circle of Protection (Fighters Guild Gladiator)
    [60417] = { name = Abilities.Skill_Empowered_by_the_Light; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 50 }; -- Empowered By the Light (Fighter's Guild Gladiator)
    [82996] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; tooltip = Tooltips.Skill_Enrage_FG_Gladiator; duration = 0 }; -- Enrage (Fighter's Guild Gladiator)
    [52746] = { name = Abilities.Skill_Dawnbreaker }; -- Flawless Dawnbreaker (Champion Marcauld)

    -- Dragonstar Arena (Stage 2) - The Frozen Ring
    [53329] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_warmth.dds'; name = Abilities.Skill_Warmth; duration = 0; forcedContainer = 'short'; groundLabel = true; tooltip = Tooltips.Skill_Warming_Aura }; -- Warming Aura
    [56755] = { name = Abilities.Skill_Puncture }; -- Pierce Armor (Sovngarde Brawler)
    [56757] = { tooltip = Tooltips.Skill_Pierce_Armor_NPC }; -- Puncture (Sovngarde Brawler)
    [56758] = { icon = '/esoui/art/icons/ability_1handed_001_b.dds' }; -- Deep Slash (Sovngarde Brawler)
    [56759] = { icon = '/esoui/art/icons/ability_1handed_001_b.dds'; tooltip = Tooltips.Skill_Deep_Slash_NPC }; -- Deep Slash (Sovngarde Brawler)
    [56760] = { icon = '/esoui/art/icons/ability_1handed_001_b.dds'; tooltip = Tooltips.Skill_Deep_Slash_NPC; hideReduce = true }; -- Deep Slash (Sovngarde Brawler)

    --[53341] = { icon = "/esoui/art/icons/ability_wrothgar_bitingcold.dds" }, -- Biting Cold (Biting Cold)
    [53342] = { icon = '/esoui/art/icons/ability_wrothgar_bitingcold.dds' }; -- Biting Cold (Biting Cold)
    [53341] = { icon = '/esoui/art/icons/ability_wrothgar_bitingcold.dds'; unbreakable = 1; stack = 1; stackAdd = 1; stackMax = 8; tooltip = Tooltips.Skill_Biting_Cold; groundLabel = true }; -- Biting Cold (Biting Cold)
    [60421] = { icon = '/esoui/art/icons/ability_wrothgar_bitingcold.dds'; unbreakable = 1; stack = 1; stackAdd = 1; tooltip = Tooltips.Skill_Biting_Cold_Vet; groundLabel = true }; -- Biting Cold (Biting Cold)
    [53832] = { icon = 'LuiExtended/media/icons/mementos/memento_fire_breathers_torches.dds'; name = Abilities.Skill_Arena_Torch; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Torch_Grab }; -- Torch Grab (Player)
    [53264] = { icon = '/esoui/art/icons/ability_2handed_005_b.dds' }; -- Rally (Sovngarde Slayer)
    [53259] = { icon = '/esoui/art/icons/ability_2handed_004_b.dds' }; -- Reverse Slice (Sovngarde Slayer)
    [53262] = { hide = true }; -- Reverse Slice (Sovngarde Slayer)
    [53261] = { icon = '/esoui/art/icons/ability_2handed_004_b.dds' }; -- Reverse Slice (Sovngarde Slayer)
    [53313] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_volley.dds'; name = Abilities.Skill_Flame_Volley }; -- Volley (Sovngarde Ranger)
    [53340] = { hide = true }; -- CLDA - Volley (Sovngarde Ranger)
    [53314] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_volley.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 1 }; -- Flame Volley (Sovngarde Ranger)
    [53286] = { icon = '/esoui/art/icons/ability_destructionstaff_001a.dds' }; -- Crushing Shock (Sovngarde Icemage)
    [53288] = { icon = '/esoui/art/icons/ability_destructionstaff_001a.dds' }; -- Crushing Shock (Sovngarde Icemage)
    [53287] = { icon = '/esoui/art/icons/ability_destructionstaff_001a.dds' }; -- Crushing Shock (Sovngarde Icemage)
    [53289] = { icon = '' }; -- Force Shock (Destruction (Sovngarde Icemage)
    [53290] = { icon = '/esoui/art/icons/ability_destructionstaff_001a.dds'; name = Abilities.Skill_Crushing_Shock; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Sovngarde Icemage)
    [53291] = { icon = '/esoui/art/icons/ability_destructionstaff_001a.dds'; name = Abilities.Skill_Crushing_Shock; tooltip = Tooltips.Generic_Stun }; -- Uber Attack (Sovngarde Icemage)
    [53270] = { icon = '/esoui/art/icons/ability_destructionstaff_005_a.dds'; hide = true }; -- Frost Clench (Sovngarde Icemage)
    [53272] = { icon = '/esoui/art/icons/ability_destructionstaff_005_a.dds' }; -- Frost Clench (Sovngarde Icemage)
    [53271] = { icon = '/esoui/art/icons/ability_destructionstaff_005_a.dds'; name = Abilities.Skill_Frost_Clench; tooltip = Tooltips.Skill_Frost_Clench_NPC }; -- Deep Freeze (Sovngarde Icemage)
    [53274] = { icon = '/esoui/art/icons/ability_destructionstaff_002a.dds' }; -- Unstable Wall of Frost (Sovngarde Icemage)
    [53280] = { icon = '/esoui/art/icons/ability_destructionstaff_002a.dds'; groundLabel = true; tooltip = Tooltips.Skill_U_Wall_of_Frost_NPC }; -- Unstable Wall of Frost (Sovngarde Icemage)
    [53278] = { icon = '/esoui/art/icons/ability_destructionstaff_002a.dds'; duration = 0; groundLabel = true; hideGround = true; tooltip = Tooltips.Skill_U_Wall_of_Frost_NPC }; -- Unstable Wall of Frost (Sovngarde Icemage)
    [53275] = { icon = '/esoui/art/icons/ability_destructionstaff_002a.dds' }; -- Unstable Wall of Frost (Sovngarde Icemage)
    [57022] = { hide = true }; -- CLDA - Normal Arena Duo Power
    [53240] = { icon = '/esoui/art/icons/ability_2handed_002_b.dds' }; -- Brawler (Yavni Frost-Skin)
    [53241] = { icon = '/esoui/art/icons/ability_2handed_002_b.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Brawler (Yavni Frost-Skin)
    [53243] = { icon = '/esoui/art/icons/ability_2handed_002_b.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Brawler (Yavni Frost-Skin)
    [53250] = { icon = '/esoui/art/icons/ability_2handed_001_b.dds' }; -- Wrecking Blow (Yavni Frost-Skin)
    [53252] = { icon = '/esoui/art/icons/ability_2handed_001_b.dds' }; -- Wrecking Blow (Yavni Frost-Skin)
    [53253] = { icon = '/esoui/art/icons/ability_2handed_001_b.dds'; tooltip = Tooltips.Generic_Knockback }; -- Wrecking Blow (Yavni Frost-Skin)
    [53255] = { hide = true }; -- Wrecking Blow (Yavni Frost-Skin)
    [53256] = { hide = true }; -- Wrecking Blow (Yavni Frost-Skin)
    [53292] = { name = Abilities.Skill_Weakness_to_Elements; tooltip = Tooltips.Skill_Elemental_Susceptibility_NPC }; -- Elemental Susceptibility (Katti Ice-Turner)
    [53301] = { icon = '/esoui/art/icons/ability_destructionstaff_008_b.dds'; name = Abilities.Skill_Frost_Pulsar }; -- Icy Pulsar (Katti Ice-Turner)
    [53302] = { icon = '/esoui/art/icons/ability_debuff_minor_mangle.dds'; name = Abilities.Skill_Minor_Mangle; tooltip = Tooltips.Skill_Minor_Mangle }; -- Icy Pulsar (Katti Ice-Turner)
    [8243] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }; -- Strike (Corprus Husk)
    [8244] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }; -- Devastate (Corprus Husk)
    [8247] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }; -- Vomit (Corprus Husk)
    [30616] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }; -- Vomit (Corprus Husk)
    [30615] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_wither.dds'; tooltip = Tooltips.Generic_Increase_Damage_Taken; tooltipValue2 = 10 }; -- Wither (Corprus Husk)
    [22109] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds' }; -- Contaminate (Corprus Husk)
    [22108] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds' }; -- Contaminate (Corprus Husk)
    [56798] = { icon = '/esoui/art/icons/ability_sorcerer_daedric_curse.dds'; name = Abilities.Skill_Daedric_Curse; tooltip = Tooltips.Skill_Daedric_Curse }; -- Explosive Curse (Dragonclaw Conjurer)
    [34966] = { hide = true }; -- Daedric Curse Hack (Dragonclaw Conjurer)
    [56802] = { icon = '/esoui/art/icons/ability_sorcerer_daedric_curse.dds'; name = Abilities.Skill_Daedric_Curse }; -- Explosive Curse (Dragonclaw Conjurer)
    [56799] = { icon = '/esoui/art/icons/ability_sorcerer_daedric_curse.dds'; name = Abilities.Skill_Daedric_Curse }; -- Explosive Curse (Dragonclaw Conjurer)
    [83493] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_poison_cloud.dds'; name = Abilities.Skill_Poison_Cloud }; -- Poisonous Cloud (Poison Cloud)
    [83495] = { hide = true }; -- False (Poison Cloud)
    [83498] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_poison_cloud.dds'; name = Abilities.Skill_Poison_Cloud; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.5 }; -- Poisonous Cloud (Poison Cloud)
    [83496] = { hide = true }; -- Poisonous Cloud (Poison Cloud)
    [56796] = { tooltip = Tooltips.Skill_Bound_Aegis_NPC }; -- Bound Aegis (Dragonclaw Hedge Wizard)
    [75609] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heated_blades.dds' }; -- Ember Explosion (Shilia)
    [75608] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heated_blades.dds'; tooltip = Tooltips.Skill_Ember_Explosion }; -- Ember Explosion (Shilia)
    [53703] = { name = Abilities.Skill_Hidden_Blade }; -- Flying Blade (Shilia)
    [53704] = { name = Abilities.Skill_Hidden_Blade; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Flying Blade (Shilia)
    [53698] = { icon = '/esoui/art/icons/ability_dualwield_005_b.dds' }; -- Steel Tornado (Shilia)
    [53692] = { name = Abilities.Skill_Flurry }; -- Rapid Strikes (Shilia)
    [53693] = { name = Abilities.Skill_Flurry; icon = '/esoui/art/icons/ability_dualwield_002.dds' }; -- Rapid Strikes (Shilia)
    [53694] = { hide = true }; -- Rapid Strikes (Shilia)
    [53613] = { icon = '/esoui/art/icons/ability_sorcerer_lightning_form.dds'; name = Abilities.Skill_Lightning_Form; tooltip = Tooltips.Skill_Thundering_Presence_NPC }; -- Thundering Presence (Nak'tah)
    [53614] = { icon = '/esoui/art/icons/ability_sorcerer_lightning_form.dds'; name = Abilities.Skill_Lightning_Form }; -- Thundering Presence (Nak'tah)
    [53625] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.5 }; -- Lightning Flood (Nak'tah)
    [53659] = { hide = true }; -- Power Overload Heavy Attack (Nak'tah)
    [53675] = { icon = '/esoui/art/icons/ability_sorcerer_power_overload.dds'; tooltip = Tooltips.Generic_Stun }; -- Power Overload Heavy Attack (Nak'tah)
    [53610] = { name = Abilities.Skill_Mages_Wrath }; -- Mages' Wrath Explosion (Nak'tah)
    [53609] = { name = Abilities.Skill_Mages_Wrath }; -- Mages' Wrath Explosion (Nak'tah)
    -- Dragonstar Arena (Stage 4) - The Slave Pit
    [56838] = { tooltip = Tooltips.Skill_Mark_Target_NPC }; -- Mark Target (House Dres Nightblade)
    [56843] = { hide = true }; -- Mark Target (House Dres Nightblade)
    [56827] = { icon = '/esoui/art/icons/ability_templar_reckless_attacks.dds' }; -- Puncturing Sweep (House Dres Templar)
    [27920] = { icon = '/esoui/art/icons/ability_templar_reckless_attacks.dds'; name = Abilities.Skill_Puncturing_Sweep; tooltip = Tooltips.Generic_Knockback }; -- Generic Knockback Stun (House Dres Templar)
    [54156] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds' }; -- Quick Strike (House Dres Slaver)
    [54160] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }; -- Berserker Frenzy (House Dres Slaver)
    [54161] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }; -- Berserker Frenzy (House Dres Slaver)
    [54122] = { hide = true }; -- Enslavement Chk (House Dres Slaver)
    [83774] = { icon = '/esoui/art/icons/achievement_manacles.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Enslavement }; -- Enslavement (House Dres Slaver)
    [54123] = { icon = '/esoui/art/icons/achievement_manacles.dds'; name = Abilities.Skill_Enslavement }; -- Lingering Death (House Dres Slaver)
    [54124] = { icon = '/esoui/art/icons/achievement_manacles.dds'; name = Abilities.Skill_Enslavement }; -- Lingering Death (House Dres Slaver)
    [54056] = { icon = '/esoui/art/icons/ability_dragonknight_015.dds'; name = Abilities.Skill_Molten_Weapons; tooltip = Tooltips.Skill_Molten_Armaments_NPC }; -- Molten Armaments (Earthen Heart Knight)
    [54065] = { tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Igneous Shield (Earth Heart Knight)
    [54081] = { duration = 0; groundLabel = true; hideGround = true; tooltip = Tooltips.Skill_Cinder_Storm_NPC }; -- Cinder Storm (Earthen Heart Knight)
    [54078] = { name = Abilities.Skill_Cinder_Storm; hide = true }; -- Eruption Snare (Earthen Heart Knight)
    [54080] = { groundLabel = true; tooltip = Tooltips.Skill_Cinder_Storm_NPC }; -- Cinder Storm (Earthen Heart Knight)
    [54054] = { tooltip = Tooltips.Generic_Physical_Resist }; -- Stone Giant (Earthen Heart Knight)
    [54055] = { tooltip = Tooltips.Generic_Knockdown }; -- Stone Giant (Earthen Heart Knight)
    [54083] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_corrosive_armor_npc.dds'; name = Abilities.Skill_Caustic_Armor; tooltip = Tooltips.Skill_Corrosive_Armor_NPC };
    [54085] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_corrosive_armor_npc.dds'; name = Abilities.Skill_Caustic_Armor; duration = 0; groundLabel = true; tooltip = Tooltips.Skill_Corrosive_Armor_Debuff_NPC; type = BUFF_EFFECT_TYPE_DEBUFF };
    [54084] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_corrosive_armor_npc.dds'; name = Abilities.Skill_Caustic_Armor };
    [54067] = { icon = '/esoui/art/icons/ability_dragonknight_014.dds'; name = Abilities.Skill_Petrify; tooltip = Tooltips.Skill_Petrify_NPC }; -- Fossilize (Earthen Heart Knight)
    [54069] = { icon = '/esoui/art/icons/ability_dragonknight_014.dds'; name = Abilities.Skill_Petrify }; -- Fossilize (Earthen Heart Knight)
    [54068] = { icon = '/esoui/art/icons/ability_dragonknight_014.dds'; name = Abilities.Skill_Petrify; tooltip = Tooltips.Generic_Stun }; -- Fossilize (Earthen Heart Knight)

    -- Dragonstar Arena (Stage 5) - The Celestial Ring
    [52879] = { tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 5 }; -- Empowering Chains (Anka-Ra Blademaster)
    [52878] = { name = Abilities.Skill_Empowering_Chains }; -- Pull (Anka-Ra Blademaster)
    [54411] = { icon = '/esoui/art/icons/ability_mage_013.dds'; hide = true }; -- Celestial Blast (Anka-Ra Shadowcaster)
    [54415] = { hide = true }; -- Celestial Blast (Anka-Ra Shadowcaster)
    [54404] = { icon = '/esoui/art/icons/ability_mage_013.dds'; tooltip = Tooltips.Skill_Celestial_Blast; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Celestial Blast (Anka-Ra Shadowcaster)
    [54314] = { hide = true }; -- Celestial Ward (Tile Ward)
    [54405] = { icon = '/esoui/art/icons/ability_mage_013.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Celestial Blast (Anka-Ra Shadowcaster)
    [83441] = { icon = '/esoui/art/icons/ability_mage_013.dds'; hide = true }; -- Celestial Blast (Anka-Ra Shadowcaster)
    [54315] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_celestial_ward.dds'; tooltip = Tooltips.Skill_Celestial_Ward; duration = 0; forcedContainer = 'short'; groundLabel = true }; -- Celestial Ward (Tile Ward)
    [56255] = { hide = true }; -- CLDA - Tile Ward Buff (Tile Ward)
    [54403] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_celestial_ward.dds'; name = Abilities.Skill_Celestial_Ward }; -- Healing Ward (Tile Ward)
    [52887] = { tooltip = Tooltips.Skill_Engulfing_Flames }; -- Engulfing Flames (Anal'a Tu'wha)
    [52882] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_unstable_flame.dds' }; -- Unstable Flame (Anal'a Tu'wha)
    [52884] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_unstable_flame.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 2 }; -- Unstable Flame (Anal'a Tu'wha)
    [52901] = { icon = '/esoui/art/icons/ability_dragonknight_006_b.dds'; tooltip = Tooltips.Skill_Standard_of_Might_NPC; duration = 0; groundLabel = true }; -- Standard of Might (Anal'a Tu'wha)
    [52903] = { tooltip = Tooltips.Skill_Standard_of_Might_NPC_Ground; groundLabel = true }; -- Standard of Might (Anal'a Tu'wha)
    [52891] = { icon = '/esoui/art/icons/ability_dragonknight_002.dds'; name = Abilities.Skill_Inferno }; -- Flames of Oblivion (Anal'a Tu'wha)
    [52892] = { icon = '/esoui/art/icons/ability_dragonknight_002.dds'; name = Abilities.Skill_Inferno; hide = true }; -- Flames of Oblivion (Anal'a Tu'wha)

    -- Stage 6 - The Grove
    [54608] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_draining_poison.dds'; name = Abilities.Skill_Draining_Poison; hide = true }; -- Drain Resource (Pacthunter Ranger)
    [60442] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_draining_poison.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Draining_Poison }; -- Draining Poison (Pacthunter Ranger)

    --[54512] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_natures_blessing.dds', name = Abilities.Skill_Natures_Blessing }, -- Regeneration Aura (Nature's Blessing)
    [54513] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_natures_blessing.dds'; name = Abilities.Skill_Natures_Blessing }; -- Restore Stamina (Nature's Blessing)
    [54514] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_natures_blessing.dds'; name = Abilities.Skill_Natures_Blessing }; -- Restore Magicka (Nature's Blessing)
    [56575] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_natures_blessing.dds'; name = Abilities.Skill_Natures_Blessing; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Natures_Blessing }; -- Nature's Grasp (Nature's Blessing)
    [83468] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_natures_blessing.dds'; name = Abilities.Skill_Natures_Blessing; tooltip = Tooltips.Skill_Natures_Blessing_Ground; groundLabel = true }; -- Restoring Nature (Nature's Blessing)
    [52820] = { icon = '/esoui/art/icons/ability_bow_005_b.dds' }; -- Acid Spray (Pishna Longshot)
    [52823] = { icon = '/esoui/art/icons/ability_bow_005_b.dds' }; -- Acid Spray (Pishna Longshot)
    [52821] = { icon = '/esoui/art/icons/ability_bow_005_b.dds'; tooltip = Tooltips.Skill_Acid_Spray_NPC; hideReduce = true }; -- Acid Spray (Pishna Longshot)
    [52822] = { icon = '/esoui/art/icons/ability_bow_005_b.dds'; tooltip = Tooltips.Skill_Acid_Spray_NPC }; -- Acid Spray (Pishna Longshot)
    [52803] = { icon = '/esoui/art/icons/ability_bow_002_b.dds' }; -- Poison Injection (Pishna Longshot)
    [52805] = { icon = '/esoui/art/icons/ability_bow_002_b.dds'; tooltip = Tooltips.Skill_Poison_Injection }; -- Poison Injection (Pishna Longshot)
    [52825] = { icon = '/esoui/art/icons/ability_bow_001_a.dds' }; -- Lethal Arrow (Pishna Longshot)
    [52826] = { icon = '/esoui/art/icons/ability_bow_001_a.dds'; tooltip = Tooltips.Generic_Reduce_Healing_Received; tooltipValue2 = 50 }; -- Lethal Arrow (Pishna Longshot)

    -- Stage 7 - Circle of Rituals
    [56946] = { icon = '/esoui/art/icons/ability_dragonknight_008.dds'; name = Abilities.Skill_Reflective_Scale; tooltip = Tooltips.Skill_Reflective_Shadows }; -- Dragon Fire Scale (Bloodwraith Kynval)
    [56599] = { hide = true }; -- CLDA - Captured Animation (Daedric Sacrifice)
    [55635] = { hide = true }; -- CLDA - Daedric Sac Check (Daedric Sacrifice)
    [54634] = { hide = true; icon = '/esoui/art/icons/achievement_ic_018.dds'; name = Abilities.Skill_Summon_Harvester }; -- CLDA - Sacrifice (Daedric Sacrifice)
    [54635] = { hide = true; icon = '/esoui/art/icons/achievement_ic_telvarscamp.dds'; name = Abilities.Skill_Summon_Scamp }; -- CLDA - Sacrifice (Daedric Sacrifice)
    [54612] = { hide = true; icon = '/esoui/art/icons/achievement_wrothgar_001.dds'; name = Abilities.Skill_Summon_Daedric_Titan }; -- CLDA - Sacrifice (Daedric Sacrifice)
    [55356] = { hide = true }; -- Intro (Daedric Sacrifice)
    [52910] = { name = Abilities.Skill_Dark_Flare; tooltip = Tooltips.Skill_Dark_Flare_NPC; unbreakable = 1 }; -- Dark Flare Trauma (Shadow Knight)
    [52909] = { icon = '/esoui/art/icons/ability_templar_dark_flare.dds' }; -- Dark Flare (Shadow Knight)
    [22094] = { icon = '/esoui/art/icons/ability_templar_dark_flare.dds'; name = Abilities.Skill_Dark_Flare; hide = true }; -- Solar Flare Weaken (Shadow Knight)
    [52922] = { tooltip = Tooltips.Skill_Searing_Light }; -- Searing Light (Shadow Knight)
    [52962] = { tooltip = Tooltips.Skill_Searing_Light; hideReduce = true }; -- Searing Light (Shadow Knight)
    [52906] = { tooltip = Tooltips.Skill_Sun_Fire; tooltipValue2Id = 52905 }; -- Vampire's Bane (Shadow Knight)
    [52905] = { icon = '/esoui/art/icons/ability_templar_vampire_bane.dds' }; -- Vampire's Bane (Shadow Knight)
    [52912] = { tooltip = Tooltips.Skill_Purifying_Light_NPC }; -- Purifying Light (Shadow Knight)
    [52920] = { tooltip = Tooltips.Skill_Unstable_Core_NPC }; -- Unstable Core (Shadow Knight)
    [52933] = { groundLabel = true; tooltip = Tooltips.Skill_Solar_Disturbance_NPC }; -- Solar Disturbance (Shadow Knight)
    [52932] = { icon = '/esoui/art/icons/ability_templar_solar_disturbance.dds'; name = Abilities.Skill_Solar_Disturbance }; -- Solar Disturbance Snare (Shadow Knight)
    [54792] = { icon = '/esoui/art/icons/ability_sorcerer_thunder_burst.dds' }; -- Crystal Blast (Dark Mage)
    [54794] = { icon = '/esoui/art/icons/ability_sorcerer_thunder_burst.dds'; name = Abilities.Skill_Crystal_Blast; tooltip = Tooltips.Generic_Knockdown }; -- Crystal Shard Stun (Dark Mage)
    [54793] = { icon = '/esoui/art/icons/ability_sorcerer_thunder_burst.dds' }; -- Crystal Blast (Dark Mage)
    [54795] = { tooltip = Tooltips.Skill_Shattering_Prison }; -- Shattering Prison (Dark Mage)
    [54833] = { icon = '/esoui/art/icons/ability_sorcerer_crushing_monsoon.dds'; name = Abilities.Skill_Suppression_Field; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Silence_No_Dur }; -- Negate Magic (Dark Mage)
    [54831] = { icon = '/esoui/art/icons/ability_sorcerer_crushing_monsoon.dds'; name = Abilities.Skill_Suppression_Field; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Spell_Resist_No_Dur }; -- Supression Field (Dark Mage)
    [54824] = { tooltip = Tooltips.Generic_Immobilize }; -- Daedric Minefield (Dark Mage)
    [54809] = { tooltip = Tooltips.Skill_Dark_Dark_NPC }; -- Dark Deal (Dark Mage)

    -- Stage 8 - Steamworks
    [25211] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_whirlwind_function.dds' }; -- Whirlwind Function (Dwarven Fire Centurion)
    [25213] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_whirlwind_function.dds' }; -- Whirlwind Function (Dwarven Fire Centurion)
    [54841] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_ice_charge.dds' }; -- Ice Charge (Dwarven Ice Centurion)
    [55022] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_ice_charge.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Ice Charge (Dwarven Ice Centurion)
    [58900] = { hide = true }; -- Ice Charge (Dwarven Ice Centurion)
    [56065] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_snare.dds'; unbreakable = 1; tooltip = Tooltips.Skill_Ice_Charge }; -- Ice Charge (Dwarven Ice Centurion)
    [55981] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_snare.dds' }; -- Ice Charge (Dwarven Ice Centurion)
    [55982] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_frost_snare.dds'; hide = true }; -- Ice Charge (Dwarven Ice Centurion)
    [72180] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds' }; -- Electric Wave (Dwarven Sphere)
    [72181] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds' }; -- Electric Wave (Dwarven Sphere)
    [52758] = { hide = true; name = Abilities.Skill_Entropy; icon = '/esoui/art/icons/ability_mageguild_004.dds' }; -- Degeneration (Mavus Talnarith)
    [52761] = { name = Abilities.Skill_Entropy; icon = '/esoui/art/icons/ability_mageguild_004.dds'; tooltip = Tooltips.Skill_Entropy_NPC }; -- Degeneration (Mavus Talnarith)
    [83491] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds' }; -- Ice Comet (Mavus Talnarith)
    [18032] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds'; name = Abilities.Skill_Ice_Comet; tooltip = Tooltips.Generic_Knockdown }; -- Stun (Mavus Talnarith)
    [83489] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds'; name = Abilities.Skill_Ice_Comet }; -- Ice Comet Knockback (Mavus Talnarith)
    [83490] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Ice Comet (Mavus Talnarith)
    [52765] = { icon = '/esoui/art/icons/ability_mageguild_001_a.dds' }; -- Volcanic Rune (Mavus Talnarith)
    [83480] = { icon = '/esoui/art/icons/ability_mageguild_001_a.dds' }; -- Volcanic Rune (Mavus Talnarith)
    [83477] = { tooltip = Tooltips.Generic_Knockback }; -- Volcanic Rune (Mavus Talnarith)

    -- Stage 9 - Crypts of the Lost
    [55034] = { hide = true }; -- CLDA - Sucked Under (CLDA - Sucked Under)
    [55221] = { hide = true }; -- Sucked Under (CLDA - Sucked Under)
    [56739] = { hide = true }; -- Damage Shield (CLDA - Sucked Under)
    [55228] = { hide = true }; -- Sucked Under (CLDA - Sucked Under)
    [55915] = { hide = true }; -- Sucked Under Fall Bonus (CLDA - Sucked Under)
    [55035] = { hide = true }; -- Sucked Under (CLDA - Sucked Under)
    [55311] = { hide = true }; -- Sucked Under (CLDA - Sucked Under)
    [58426] = { hide = true }; -- CLDA - Drop Hate (CLDA - Sucked Under)

    [56985] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_hurricane.dds'; hide = true }; -- Spirit Shield (Zackael/Rubyn Jonnicent)
    [56990] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_hurricane.dds'; name = Abilities.Skill_Spirit_Shield }; -- Spirit Shield (Zackael/Rubyn Jonnicent)

    [55085] = { hide = true }; -- Poison Mist (Vampire Lord Thisa)
    [55089] = { tooltip = Tooltips.Skill_Poison_Mist }; -- Poison Mist (Vampire Lord Thisa)
    [55086] = { groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 1.5 }; -- Poison Mist (Vampire Lord Thisa)

    [55081] = { tooltip = Tooltips.Skill_Drain_Essence_Vamp_NPC }; -- Drain Essence (Vampire Lord Thisa)
    [21911] = { hide = true }; -- Stun (Vampire Lord Thisa)

    [55090] = { tooltip = Tooltips.Skill_Devouring_Swarm }; -- Devouring Swarm (Vampire Lord Thisa)
    [55092] = { groundLabel = true; tooltip = Tooltips.Skill_Devouring_Swarm_Ground }; -- Devouring Swarm (Vampire Lord Thisa)

    -- Stage 10 - The Champion's Arena
    [55478] = { icon = '/esoui/art/icons/ability_nightblade_012.dds'; tooltip = Tooltips.Generic_HoT; tooltipValue2 = 2 }; -- Strife (Hiath the Battlemaster)

    [55479] = { tooltip = Tooltips.Skill_Malefic_Wreath }; -- Malefic Wreath (Hiath the Battlemaster)

    [55493] = { name = Abilities.Skill_Crippling_Grasp; tooltip = Tooltips.Skill_Crippling_Grasp_NPC }; -- Cripple (Hiath the Battlemaster)
    [55486] = { name = Abilities.Skill_Crippling_Grasp }; -- Cripple (Hiath the Battlemaster)
    [55487] = { hide = true }; -- Cripple (Hiath the Battlemaster)
    [55488] = { name = Abilities.Skill_Crippling_Grasp }; -- Cripple (Hiath the Battlemaster)
    [55491] = { icon = '/esoui/art/icons/ability_nightblade_006_b.dds' }; -- Crippling Grasp (Hiath the Battlemaster)

    [55494] = { hide = true }; -- Power Extraction (Hiath the Battlemaster)
    [55496] = { tooltip = Tooltips.Skill_Power_Extraction_NPC }; -- Power Extraction (Hiath the Battlemaster)

    [58196] = { hide = true }; -- Hiath's Fury (Hiath the Battlemaster)
    [55099] = { hide = true }; -- Marked for Death (Hiath the Battlemaster)
    [55174] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; refreshOnly = true; tooltip = Tooltips.Skill_Marked_for_Death }; -- Marked for Death (Hiath the Battlemaster)
    [55104] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire.dds' }; -- Marked for Death (Hiath the Battlemaster)
    [58459] = { hide = true }; -- Marked for Death (Hiath the Battlemaster)
    [55181] = { hide = true }; -- Marked for Death (Hiath the Battlemaster)
    [55182] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage.dds'; name = Abilities.Skill_Blazing_Fire; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1; groundLabel = true }; -- Marked for Death (Hiath the Battlemaster)

    [59803] = { hide = true }; -- CLDA - Hiath Summon Tracker (Hiath the Battlemaster)
    [55592] = { hide = true }; -- CLDA - Swap Actions 75 (Hiath the Battlemaster)
    [55617] = { hide = true }; -- CLDA - Swap Actions 50 (Hiath the Battlemaster)
    [55621] = { hide = true }; -- CLDA - Swap Actions 25 (Hiath the Battlemaster)
    [55602] = { hide = true }; -- CLDA10 - Spawn West (Hiath the Battlemaster)
    [55615] = { hide = true }; -- CLDA10 - Spawn East (Hiath the Battlemaster)
    [55616] = { hide = true }; -- CLDA10 - Spawn North (Hiath the Battlemaster)

    [55670] = { hide = true }; -- Levitate Speak 1 (Light of Boethia)
    [55649] = { hide = true }; -- CLDA - Boethia Levitate (Light of Boethia)

    -- Maelstrom Arena (Shared)
    [43882] = { hide = true }; -- CON_Portal 3 Seconds
    [72059] = { hide = true }; -- Portal Spawn

    [71957] = { hide = true }; -- Sigil of Speed
    [67257] = { hide = true }; -- Speed Used
    [71947] = { hide = true }; -- Sigil of Health
    [67227] = { hide = true }; -- Healing Used
    [71900] = { hide = true }; -- Sigil of Power
    [71912] = { hide = true }; -- Sigil of Power
    [67210] = { hide = true }; -- Power Used
    [71955] = { hide = true }; -- Sigil of Defense
    [67239] = { hide = true }; -- Defense Used

    [67240] = { tooltip = Tooltips.Skill_Sigil_of_Defense }; -- Sigil of Defense
    [67253] = { tooltip = Tooltips.Skill_Sigil_of_Haste }; -- Sigil of Haste
    [67209] = { tooltip = Tooltips.Skill_Sigil_of_Power }; -- Sigil of Power
    [66920] = { tooltip = Tooltips.Skill_Sigil_of_Healing }; -- Sigil of Healing
    [66921] = { icon = '/esoui/art/icons/sigil_healing_001.dds'; name = Abilities.Skill_Sigil_of_Healing }; -- Healing Aura (Sigil of Healing)

    [72471] = { icon = ''; name = '' }; -- DUN-MA Grant Resources (End of Round Heal & Resource Restore)
    [72472] = { icon = ''; name = '' }; -- DUN-MA Grant Resources (End of Round Heal & Resource Restore)
    [72474] = { icon = ''; name = '' }; -- DUN-MA Grant Resources (End of Round Heal & Resource Restore)

    [70928] = { hide = true }; -- Is Essential Mob
    [73924] = { hide = true }; -- DUN-MA Increased Gold
    [72433] = { hide = true }; -- FNH Portal Spawn

    -- Stage 1 - Vale of the Surreal
    [70885] = { hide = true }; -- Miasma

    [68195] = { hide = true }; -- Necrotic Orb (Necrotic Orb)
    [68197] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_essence.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1 }; -- Necrotic Essence (Necrotic Orb)
    [68198] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_essence.dds' }; -- Necrotic Explosion (Necrotic Orb)

    [44622] = { hide = true }; -- Break Free (Clones)

    [67765] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_multiply_male.dds' }; -- Multiply (Maxus the Many)
    [67656] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_multiply_male.dds' }; -- Multiply (Maxus the Many)
    [69515] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_multiply_male.dds' }; -- Multiply (Maxus the Many)

    [67691] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_reunite_male.dds' }; -- Reunite (Maxus the Many)
    [67683] = { hide = true }; -- Absorb Clones (Maxus the Many)
    [67694] = { hide = true }; -- Reunite (Maxus the Many)
    [67690] = { hide = true }; -- Set Clone CD (Maxus the Many)

    [70891] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_bolt.dds' }; -- Entropic Bolt (Maxus the Many)
    [70892] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds'; name = Abilities.Skill_Defiled_Grave }; -- Bone Cage (Maxus the Many)
    [70893] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds'; tooltip = Tooltips.Skill_Defiled_Grave; groundLabel = true; duration = 0; hideGround = true }; -- Defiled Grave (Maxus the Many)
    [70901] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds'; tooltip = Tooltips.Skill_Defiled_Grave; groundLabel = true }; -- Defiled Grave (Maxus the Many)
    [72148] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds'; name = Abilities.Skill_Defiled_Grave }; -- Bone Cage (Maxus the Many)
    [72152] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds'; tooltip = Tooltips.Skill_Defiled_Grave; groundLabel = true; duration = 0; hideGround = true }; -- Defiled Grave (Maxus the Many)
    [72149] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_cage.dds'; tooltip = Tooltips.Skill_Defiled_Grave; groundLabel = true }; -- Defiled Grave (Maxus the Many)
    [72086] = { hide = true }; -- Shadow Strength (Maxus the Many)

    -- Round 2 - Seht's Balcony
    [69018] = { hide = true }; -- Generator (Generator)
    [69101] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_damage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.5 }; -- Shock (Generator)
    [72690] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_overcharge.dds' }; -- Overload (Generator)
    [72686] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_overcharge.dds'; hide = true }; -- Overload (Generator)
    [72736] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_overcharge.dds'; name = Abilities.Skill_Overload; tooltip = Tooltips.Generic_Knockback }; -- Overload 2 (Generator)
    [71198] = { hide = true }; -- Stun (Blade Trap)
    [66797] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 0.25 }; -- Spinning Blade (Blade Trap)
    [72414] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; stack = 0; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Serrated Blade (Blade Trap)
    [72413] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap }; -- Serrated Blade (Blade Trap)
    [72194] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Blade_Trap_VMA }; -- Serrated Blade (Blade Trap)
    [72199] = { icon = '/esoui/art/icons/achievement_vvardenfel_047.dds'; name = Abilities.Trap_Blade_Trap }; -- Serrated Blade (Blade Trap)
    [72489] = { hide = true }; -- Heal (Generator)
    [69149] = { hide = true }; -- Reset Switches (Generator)
    [69102] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_generator_heal.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 0.5 }; -- Heal (Generator)
    [73119] = { hide = true }; -- NPC 50% Speed (Clockwork Sentry)--
    [71047] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderbolt.dds' }; -- Thunderbolt (Clockwork Sentry)
    [71048] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderbolt.dds' }; -- Thunderbolt (Clockwork Sentry)
    [72067] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_energizing.dds'; name = Abilities.Skill_Energize; stack = 0; tooltip = Tooltips.Generic_Enrage_No_Dur; tooltipValue2 = 75 }; -- Energizing (Clockwork Sentry)
    [72591] = { hide = true }; -- Portal Spawn
    [72602] = { hide = true }; -- Portal Spawn
    [72605] = { hide = true }; -- Portal Spawn
    [69364] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_barrage_function.dds'; hide = true }; -- Barrage Function (Centurion Champion)
    [69366] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_barrage_function.dds' }; -- Barrage Function (Centurion Champion)
    [66904] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_defensive_protocol.dds'; name = Abilities.Skill_Defensive_Protocol; tooltip = Tooltips.Skill_Defensive_Protocol }; -- Full Defense (Centurion Champion)
    [69317] = { hide = true }; -- Sheild (Centurion Champion)
    [66905] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_defensive_protocol.dds'; name = Abilities.Skill_Defensive_Protocol }; -- Full Defense (Centurion Champion)
    [69316] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_defensive_protocol.dds'; name = Abilities.Skill_Defensive_Protocol; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.5 }; -- Electric Shield (Centurion Champion)
    [68819] = { hide = true }; -- Full Defense (Centurion Champion)

    -- Stage 3 - The Drome of Toxic Shock
    [67625] = { hide = true }; -- Lamia Spawn (Lamia Queen)
    [67635] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_electrified_water.dds'; name = Abilities.Skill_Electrified_Water }; -- Shock Water (Lamia Queen)
    [67871] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_electrified_water.dds'; name = Abilities.Skill_Electrified_Water; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 0.5 }; -- Shock (Water)
    [73879] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds'; name = Abilities.Skill_Call_Lightning }; -- Call Lightning (Lamia Queen)
    [73880] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds' }; -- Call Lightning (Lamia Queen)
    [73882] = { hide = true }; -- Lightning g (Lamia Queen)
    [67757] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_poison.dds' }; -- Queen's Poison (Lamia Queen)
    [67758] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_poison.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.5 }; -- Queen's Poison (Lamia Queen)
    [76094] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds' }; -- Spit (Strangler)
    [76147] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_snare_alt.dds'; name = Abilities.Skill_Spit; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 70 }; -- Snared (Srangler)
    [68357] = { icon = 'LuiExtended/media/icons/abilities/ability_set_almalexias_mercy.dds' }; -- Queen's Radiance (Lamia Queen)
    [68358] = { icon = 'LuiExtended/media/icons/abilities/ability_set_almalexias_mercy.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Heal; tooltipValue2 = 1 }; -- Queen's Radiance (Lamia Queen)
    [21646] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_strike.dds' }; -- Clawed Swipe (Lamia Queen)
    [73876] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_sonic_scream.dds' }; -- Piercing Shriek (Lamia Queen)
    [73878] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_sonic_scream.dds' }; -- Piercing Shriek (Lamia Queen)
    [73877] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_sonic_scream.dds'; tooltip = Tooltips.Generic_Stun }; -- Piercing Shriek (Lamia Queen)
    [71044] = { hide = true }; -- Turret Occupied (Sentry Base)
    [71045] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_turret_mode.dds'; duration = 0; tooltip = Tooltips.Skill_Turret_Mode }; -- Turret Mode (Clockwork Sentry)
    [71050] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds'; tooltip = Tooltips.Skill_Static_Shield }; -- Static Shield (Clockwork Sentry)
    [71052] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds'; name = Abilities.Skill_Static_Shield }; -- Static Shield Explosion (Clockwork Sentry)
    [73847] = { hide = true }; -- Charged (Clockwork Sentry)
    [73850] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds'; tooltip = Tooltips.Skill_Static_Shield }; -- Static Shield (Clockwork Sentry)
    [73851] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds'; name = Abilities.Skill_Static_Shield }; -- Static Shield Explosion (Clockwork Sentry)
    [69268] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; tooltip = Tooltips.Generic_Enrage_Damage_Taken_No_Dur; tooltipValue2 = 100; tooltipValue3 = 20 }; -- Enrage (Achelir)
    [72157] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_static_field.dds' }; -- Static Field (Dwarven Spider)
    [72159] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_static_field.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Static Field (Dwarven Spider)
    [72163] = { hide = true }; -- Overcharge (Dwarven Spider)
    [72178] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds'; tooltip = Tooltips.Generic_Enrage_Damage_Reduce_No_Dur; tooltipValue2 = 125; tooltipValue3 = 50 }; -- Overcharge (Dwarven Spider)
    [72179] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds'; tooltip = Tooltips.Generic_Enrage_Damage_Reduce_No_Dur; tooltipValue2 = 125; tooltipValue3 = 50 }; -- Overcharge (Dwarven Spider)
    [72166] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    [72174] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    [72167] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    [72175] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    [72176] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_shock.dds' }; -- Overcharge (Overcharge)
    [68662] = { hide = true }; -- Intro Stun (The Control Guardian)
    [68665] = { hide = true }; -- Recovery (The Control Guardian)
    [68524] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharged.dds'; tooltip = Tooltips.Skill_Overcharged }; -- Overcharged (The Control Guardian)
    [68537] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }; -- Overcharged Bolt (The Control Guardian)
    [70829] = { hide = true }; -- Overcharged Cooldown (The Control Guardian)
    [68539] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overheated.dds'; tooltip = Tooltips.Skill_Overheated; tooltipVet = Tooltips.Skill_Overheated_VET; duration = 4 }; -- Overheated (The Control Guardian)
    [71109] = { hide = true }; -- Fire FX (The Control Guardian)
    [72208] = { hide = true }; -- Rooted (The Control Guardian)
    [70860] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overheated.dds'; name = Abilities.Skill_Venting_Flames; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Overheated Flame (The Control Guardian)
    [68558] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_overheated_volley.dds' }; -- Overheated Volley
    [68543] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_overheated_volley.dds' }; -- Overheated Volley
    [72197] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds' }; -- Quick Strike (Scavenger Thunder-Smith)
    [72195] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_thunder_hammer.dds' }; -- Thunder Hammer (Scavenger Thunder-Smith)
    [72196] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammer_2h_thunder_hammer.dds' }; -- Thunder Hammer (Scavenger Thunder-Smith)
    [72198] = { icon = '/esoui/art/icons/ability_2handed_001_b.dds' }; -- Wrecking Blow (Scavenger Thunder-Smith)
    [72200] = { icon = '/esoui/art/icons/ability_2handed_001_b.dds' }; -- Wrecking Blow (Scavenger Thunder-Smith)
    [72201] = { icon = '/esoui/art/icons/ability_2handed_001_b.dds'; tooltip = Tooltips.Generic_Knockback }; -- Wrecking Blow (Scavenger Thunder-Smith)
    [72202] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_overcharge.dds'; name = Abilities.Skill_Voltaic_Overload; tooltip = Tooltips.Skill_Voltaic_Overload }; -- Overcharge (Scavenger Thunder-Smith)
    [72203] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_overcharge.dds'; name = Abilities.Skill_Voltaic_Overload }; -- Overcharge (Scavenger Thunder-Smith)

    -- Stage 5 - Rink of Frozen Blood
    [72525] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_frigid_waters.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Skill_Frigid_Waters; stack = 1; stackAdd = 1 }; -- Frigid Waters (Player)
    [67808] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_frigid_waters.dds'; groundLabel = true; tooltip = Tooltips.Skill_Frigid_Waters; stack = 1; stackAdd = 1 }; -- Frigid Waters (Player)
    [72418] = { tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Poison Arrow (Huntsman Heartfinder)
    [70898] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_deathless_wolf.dds'; name = Abilities.Skill_Summon_Deathless_Wolf; hide = true }; -- Call Ally (Huntsman Chillbane)
    [71939] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_frost_breath.dds' }; -- Frost Breath (Huntsman Chillbane)
    [98062] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_frost_breath.dds' }; -- Frost Breath (Huntsman Chillbane)
    [71940] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_frost_breath.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Frost Breath (Huntsman Chillbane)
    [71937] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_frost_nova.dds' }; -- Frost Nova (Huntsman Chillbane)
    [71938] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Frost Nova (Huntsman Chillbane)
    [71692] = { hide = true }; -- Ready to Smash (Troll Breaker)
    [72446] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds'; hide = true }; -- Smash Iceberg (Troll Breaker)
    [72450] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = Abilities.Innate_Bash_Stun; tooltip = Tooltips.Generic_Stun; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Interrupted (Troll Breaker)
    [72494] = { hide = true }; -- Go To Closests Iceberg (Troll Breaker)
    [72011] = { hide = true }; -- Stagger (Iceberg)
    [72013] = { hide = true }; -- Stagger (Iceberg)
    [72012] = { tooltip = Tooltips.Generic_Stagger }; -- Stagger (Iceberg)
    [72703] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; name = Abilities.Skill_Cold_Snap; hide = true }; -- Cold Snap Bolt (Leimenid Oracle)
    [72705] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; unbreakable = 1; tooltip = Tooltips.Skill_Cold_Snap; tooltipValue2 = 7; stackAdd = 1 }; -- Cold Snap (Leimenid Oracle)
    [71994] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; name = Abilities.Skill_Cold_Snap; hide = true }; -- Cold Snap Bolt (Leimenid Oracle)
    [71997] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; unbreakable = 1; tooltip = Tooltips.Skill_Cold_Snap; tooltipValue2 = 27; stackAdd = 1 }; -- Cold Snap (Leimenid Oracle)
    [71926] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_triple_strike.dds' }; -- Frenzy of Blows (Angirgoth)
    [71930] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_triple_strike.dds' }; -- Frenzy of Blows (Angirgoth)
    [71929] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_triple_strike.dds' }; -- Frenzy of Blows (Angirgoth)
    [71931] = { name = Abilities.Skill_Flurry; hide = true }; -- Rapid Strikes (Angirgoth)
    [71932] = { name = Abilities.Skill_Flurry }; -- Rapid Strikes (Angirgoth)
    [71933] = { hide = true }; -- Rapid Strikes (Angirgoth)
    [71935] = { hide = true }; -- Steel Tornado (Angirgoth)
    [71934] = { icon = '/esoui/art/icons/ability_dualwield_005_b.dds' }; -- Steel Tornado (Angirgoth)
    [71897] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow.dds'; hide = true }; -- Frost Bolt (Leimenid)
    [71915] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_shards.dds' }; -- Uppercut (Frost Atronach)
    [72438] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds' }; -- Shatter (Giant)
    [72439] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds'; hide = true }; -- Shatter (Giant)
    [68439] = { tooltip = Tooltips.Generic_Enrage_Damage_Reduce_No_Dur; tooltipValue2 = 25; tooltipValue3 = 20 }; -- Enrage (Aki/Vigi)
    [74130] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds' }; -- Intimidating Roar (Aki/Vigi)
    [74131] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds'; tooltip = Tooltips.Generic_Fear }; -- Intimidating Roar (Aki/Vigi)
    [66378] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds' }; -- Sweep (Matriarch Runa)
    [66379] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds' }; -- Sweep (Matriarch Runa)
    [66381] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds'; name = Abilities.Skill_Sweep }; -- Obliterate (Matriach Runa)
    [66380] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds'; name = Abilities.Skill_Sweep; tooltip = Tooltips.Generic_Knockback }; -- Obliterate (Matriach Runa)
    [72749] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_freezing_stomp.dds' }; -- Freezing Stomp (Matriarch Runa)
    [72751] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_freezing_stomp.dds' }; -- Freezing Stomp (Matriarch Runa)
    [72750] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Freezing Stomp (Matriarch Runa)
    [67088] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds' }; -- Intimidating Roar (Matriarch Runa)
    [67091] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds'; tooltip = Tooltips.Generic_Fear }; -- Intimidating Roar (Matriarch Runa)
    [66325] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds' }; -- Shatter (Matriarch Runa)
    [66326] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds'; hide = true }; -- Shatter (Matriarch Runa)
    [71696] = { hide = true }; -- Enerage (Matriarch Runa)
    [72409] = { icon = '/esoui/art/icons/ability_wrothgar_chillingwind.dds'; name = Abilities.Skill_Iceberg_Calving; hide = true }; -- Taunt (Matriarch Runa)
    [71701] = { hide = true }; -- Can Quake (Matriarch Runa)
    [71702] = { hide = true }; -- Iceberg Calving (Matriarch Runa)
    [71710] = { hide = true }; -- Iceberg Calving (Matriarch Runa)
    [71705] = { hide = true }; -- Iceberg Calving (Matriarch Runa)
    [71706] = { icon = '/esoui/art/icons/ability_wrothgar_chillingwind.dds' }; -- Iceberg Calving (Matriarch Runa)
    [72707] = { icon = '/esoui/art/icons/ability_wrothgar_chillingwind.dds'; hide = true }; -- Iceberg Calving (Matriarch Runa)
    [71721] = { icon = '/esoui/art/icons/ability_wrothgar_chillingwind.dds'; name = Abilities.Skill_Iceberg_Calving; hide = true }; -- Knockback (Matriarch Runa)
    [71720] = { icon = '/esoui/art/icons/ability_wrothgar_chillingwind.dds'; name = Abilities.Skill_Iceberg_Calving; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Stun (Matriarch Runa)
    [72005] = { hide = true }; -- DUN-MA GM Stop Slam Trolls (Troll Breaker)

    ----------------------------------------------------------------
    -- WORLD BOSSES    ---------------------------------------------
    ----------------------------------------------------------------

    -- AURIDON

    -- World Boss - Seaside Scarp Camp
    [84048] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds' }; -- Defiled Ground (Quenyas)
    [84047] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds'; groundLabel = true; duration = 0; tooltip = Tooltips.Generic_AOE_Snare_Magic; tooltipValue2 = 0.5; tooltipValue3 = 70; hideGround = true }; -- Defiled Ground (Quenyas)
    [84045] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_necrotic_snare.dds'; name = Abilities.Skill_Defiled_Ground; groundLabel = true; tooltip = Tooltips.Generic_AOE_Snare_Magic; tooltipValue2 = 0.5; tooltipValue3 = 70 }; -- Seal of Defilement (Quenyas)
    [83782] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_strike.dds' }; -- Staff Strike (Quenyas)
    [83783] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_staff_strike.dds' }; -- Bash (Quenyas)
    [83776] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_zombie.dds'; hide = true }; -- Dark Summons (Quenyas)
    [84283] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds'; name = Abilities.Skill_Colossal_Stomp }; -- Coursing Bones (Oskana)
    [84285] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds'; name = Abilities.Skill_Colossal_Stomp }; -- Coursing Bones (Oskana)
    [84284] = { name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Coursing Bones (Oskana)
    [84286] = { name = Abilities.Skill_Voice_to_Wake_the_Dead; icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_voice_to_wake_the_dead.dds' }; -- -- Wake the Dead (Oskana)

    -- World Boss - Heretic's Summons
    [82934] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_shrieking_summons.dds'; hide = true }; -- Shrieking Summons
    [83013] = { hide = true }; -- Daedric Explosion
    [82935] = { hide = true }; -- Summon Brood
    [82937] = { hide = true }; -- Summon Brood
    [83151] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt.dds'; name = Abilities.Skill_Headbutt }; -- Savage Claw (Snapjaw)
    [83150] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_whip.dds' }; -- Savage Claw (Snapjaw)
    [83009] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }; -- Rending Leap (Snapjaw)
    [83011] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }; -- Rending Leap (Snapjaw)
    [87989] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Rending Leap (Snapjaw)
    [83012] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds'; hide = true }; -- Devour (Snapjaw)
    [85649] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds' }; -- Devour (Snapjaw)
    [83049] = { hide = true }; -- Charge (Clannfear)
    [83033] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_ferocious_charge.dds'; name = Abilities.Skill_Ferocious_Charge }; -- Focused Charge (Clannfear)
    [83039] = { hide = true }; -- Ferocious Charge (Clannfear)
    [83035] = { hide = true }; -- Ferocious Charge (Clannfear)
    [83042] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_ferocious_charge.dds' }; -- Ferocious Charge (Clannfear)
    [83016] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_coldfire.dds'; name = Abilities.Skill_Daedric_Explosion }; -- Necrotic Explosion
    [83017] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_coldfire.dds'; hide = true }; -- Daedric Explosion
    [83018] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aoe_coldfire.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Daedric Explosion

    -- World Boss - Heritance Proving Ground
    [47259] = { hide = true }; -- Frostarrows

    -- GRAHTWOOD

    -- World Boss - Nindaeril's Perch
    [83515] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }; -- Hunter's Pounce (Bavura the Blizzard)
    [83517] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }; -- Hunter's Pounce (Bavura the Blizzard)
    [84018] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds'; tooltip = Tooltips.Generic_Knockback }; -- Hunter's Pounce (Bavura the Blizzard)
    [83521] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }; -- Hunter's Pounce (Bavura the Blizzard)
    [83832] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge_white.dds' }; -- Frenzied Charge (Nindaeril the Monsoon)
    [83833] = { hide = true }; -- Frenzied Charge (Nindaeril the Monsoon)
    [83846] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge_white.dds' }; -- Frenzied Charge (Nindaeril the Monsoon)
    [83855] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge_white.dds'; tooltip = Tooltips.Generic_Knockback }; -- Frenzied Charge (Nindaeril the Monsoon)
    [83852] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge_white.dds' }; -- Frenzied Charge (Nindaeril the Monsoon)
    [83548] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_mighty_roar_white.dds' }; -- Mighty Roar (Nindaeril the Monsoon)
    [83549] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_mighty_roar_white.dds'; tooltip = Tooltips.Generic_Fear }; -- Mighty Roar (Nindaeril the Monsoon)

    -- GREENSHADE

    -- World Boss -- Rootwater's Spring
    [47084] = { hide = true }; -- Rootwater Healing Spring
    [47086] = { hide = true }; -- Rootwater Life Spring

    -- World Boss - Gathongor's Mine
    [84205] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_damage.dds' }; -- Stinging Sputum (Gathongor the Mauler)
    [84206] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_slime_damage.dds'; hide = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 0.5; groundLabel = true }; -- Stinging Sputum (Gathongor the Mauler)
    [84196] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Marsh Masher (Gathongor the Mauler)
    [84203] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds'; hide = true }; -- Marsh Masher (Gathongor the Mauler)
    [84197] = { name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Marsh Masher (Gathongor the Mauler)
    [84208] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_savage_swipe.dds' }; -- Savage Swipe (Gathongor the Mauler)
    [84209] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds'; tooltip = Tooltips.Generic_Stun }; -- Wrecking Jaws (Gathongor the Mauler)
    [84211] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds' }; -- Wrecking Jaws (Gathongor the Mauler)
    [84210] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Wrecking Jaws (Gathongor the Mauler)
    [84138] = { hide = true }; -- Minion of Stone (Gathongor the Mauler)
    [84139] = { hide = true }; -- Minion of Stone (Gathongor the Mauler)
    [84212] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds' }; -- Bog Slam (Gathongor the Mauler)
    [84214] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Generic_Knockdown }; -- Bog Slam (Gathongor the Mauler)
    [84213] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds' }; -- Bog Slam (Gathongor the Mauler)

    -- World Boss - Thodundor's View
    [83164] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_punch.dds' }; -- Clobber (Thodundor of the Hill)
    [83165] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_backhand.dds' }; -- Sweeping Backhand (Thodundor of the Hill)
    [83124] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds'; tooltip = Tooltips.Generic_Fear }; -- Ferocious Bellow (Thodundor of the Hill)
    [83155] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Thunderous Smash (Thodundor of the Hill)
    [83156] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Thunderous Smash (Thodundor of the Hill)
    [83159] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Thunderous Smash (Thodundor of the Hill)
    [83157] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Thunderous Smash (Thodundor of the Hill)
    [83160] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }; -- Stone Crusher (Thodundor of the Hill)
    [83163] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }; -- Stone Crusher (Thodundor of the Hill)
    [83162] = { name = Abilities.Skill_Off_Balance; tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Stone Crusher (Thodundor of the Hill)
    [83161] = { name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Stone Crusher (Thodundor of the Hill)
    [83136] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds'; hide = true }; -- Ground Shock (Thodundor of the Hill)
    [83140] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Ground Shock (Thodundor of the Hill)
    [83141] = { name = Abilities.Innate_Stagger; hide = true; tooltip = Tooltips.Generic_Stagger }; -- Ground Shock (Thodundor of the Hill)
    [83137] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shattered_ground.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Ground Shock (Thodundor of the Hill)
    [83777] = { icon = '/esoui/art/icons/ability_dragonknight_005.dds'; name = Abilities.Skill_Fiery_Grip; hide = true }; -- Iron Grip (Thodundor of the Hill)
    [83780] = { icon = '/esoui/art/icons/ability_dragonknight_005.dds'; name = Abilities.Skill_Fiery_Grip; tooltip = Tooltips.Generic_Stun }; -- Iron Grip (Thodundor of the Hill)

    -- World Boss - Windshriek Strand
    [87283] = { hide = true }; -- Regeneration (Skullbreaker)
    [87284] = { hide = true }; -- Regeneration (Skullbreaker)
    [52024] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rock_toss.dds' }; -- Rock Toss (Skullbreaker)
    [84066] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Ground Shock (Skullbreaker)
    [84075] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Ground Shock (Skullbreaker)
    [83651] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds'; hide = true }; -- Feral Impact (Skullbreaker)
    [83668] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds'; hide = true }; -- Feral Impact (Skullbreaker)
    [83671] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds'; hide = true }; -- Feral Impact (Skullbreaker)
    [84076] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_carrion_call.dds' }; -- Carrion Call (Skullbreaker)
    [84338] = { hide = true }; -- Swoop (Harpy)

    -- World Boss - Reaper's Henge
    [58966] = { hide = true }; -- RM-GB1 Flesh Atronach Boss (Varien)

    -- World Boss - Big Ozur's Valley
    [85070] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_bolt.dds' }; -- Blazing Bolt (Big Ozur)
    [85071] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_bolt.dds' }; -- Blazing Bolt (Big Ozur)
    [83180] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_pillar.dds' }; -- Molten Pillar (Ice Pillar)
    [83182] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_pillar.dds'; tooltip = Tooltips.Skill_Molten_Pillar }; -- Molten Pillar (Ice Pillar)
    [83185] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_pillar.dds'; name = Abilities.Skill_Molten_Pillar_Incalescence; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 60 }; -- Molten Shackles (Ice Pillar)
    [83184] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_shackles.dds'; tooltip = Tooltips.Generic_Immobilize }; -- Molten Shackles (Ice Pillar)
    [83206] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_impact.dds'; name = Abilities.Skill_Molten_Impact; hide = true }; -- Molten Shackles (Ice Pillar)
    [83203] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_impact.dds' }; -- Molten Impact (Ice Pillar)
    [83191] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Shaman Smash (Big Ozur)
    [83196] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Shaman Smash (Big Ozur)
    [83192] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Shaman Smash (Big Ozur)
    [83193] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Shaman Smash (Big Ozur)
    [83194] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shattered_ground.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Shaman Smash (Big Ozur)

    -- World Boss - The Wolf's Camp
    [10149] = { icon = '/esoui/art/icons/ability_werewolf_001.dds'; name = Abilities.Skill_Werewolf_Transformation }; -- Guards Transform (Lieutenant Bran, Annyce)

    -- World Boss - Trapjaw's Cove
    [83945] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }; -- Tail Sweep (Trapjaw)
    [83947] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }; -- Tail Sweep (Trapjaw)
    [83948] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds'; hide = true }; -- Tail Sweep (Trapjaw)
    [83951] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds'; tooltip = Tooltips.Generic_Knockback }; -- Tail Sweep (Trapjaw)
    [84028] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_impending_storm.dds' }; -- Impending Storm (Trapjaw)
    [84030] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_impending_storm.dds' }; -- Impending Storm (Trapjaw)
    [84175] = { hide = true }; -- Focused Charge (Trapjaw)
    [84177] = { hide = true }; -- Charge (Trapjaw)
    [84169] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds' }; -- Rolling Thunder (Wamasu)
    [84179] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds' }; -- Rolling Thunder (Wamasu)
    [84173] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Rolling Thunder (Wamasu)
    [84172] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Block, Abilities.Innate_Stun); tooltip = Tooltips.Generic_Stun; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Charge (Trapjaw)
    [83925] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_trapping_bolt.dds'; hide = true }; -- Trapping Bolt (Trapjaw)
    [83930] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_trapping_bolt.dds'; tooltip = Tooltips.Skill_Trapping_Bolt }; -- Trapping Bolt (Trapjaw)
    [83928] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_root.dds'; name = Abilities.Skill_Trapping_Bolt; tooltip = Tooltips.Generic_Immobilize; unbreakable = 1; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Arx_boss2_KDrecover
    [25763] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_trapping_bolt.dds' }; -- Remove Bolt (Trapjaw)

    -- World Boss - Spider Nest
    [84150] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_brood.dds'; hide = true }; -- Call of the Brood (Old Widow Silk)
    [84564] = { hide = true }; -- Summon Swarm (Old Widow Silk)
    [84563] = { hide = true }; -- Summon Swarm (Old Widow Silk)
    [84151] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_web_wrap.dds'; hide = true }; -- Constricting Webs (Old Widow Silk)
    [84155] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_web_wrap.dds'; tooltip = Tooltips.Skill_Constricting_Webs }; -- Constricting Webs (Old Widow Silk)
    [84608] = { hide = true }; -- Web Wrap
    [84548] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }; -- Venom Spray (Old Widow Silk)
    [84549] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }; -- Venom Spray (Old Widow Silk)
    [84159] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_spit_poison.dds'; name = Abilities.Skill_Poison_Spit; hide = true }; -- Spit Poison (Old Widow Silk)
    [84162] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_spit_poison.dds'; name = Abilities.Skill_Poison_Spit; tooltip = Tooltips.Skill_Poison_Spit; unbreakable = 1; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Spit Poison (Old Widow Silk)
    [84161] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_poison_damage_alt.dds'; name = Abilities.Skill_Poison_Spit }; -- Spit Poison (Old Widow Silk)
    [84160] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_poison_damage_alt.dds'; name = Abilities.Skill_Poison_Spit; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 2 }; -- Spit Poison (Old Widow Silk)

    -- World Boss - Mudcrab Beach
    [82965] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_crab_toss.dds'; hide = true }; -- Crabuchet (Titanclaw)
    [82983] = { hide = true }; -- Crabuchet (Titanclaw)
    [83000] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_rocks_ground.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 0.5 }; -- Crabuchet (Titanclaw)
    [83021] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_crab_toss.dds' }; -- Crabuchet (Titanclaw)-- World Boss - Valewatch Tower
    [84039] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_stone_swipe.dds' }; -- Stone Swipe (Menhir Stoneskin)
    [84040] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_stone_swipe.dds' }; -- Stone Swipe (Menhir Stoneskin)
    [84041] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_stone_swipe.dds'; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 0.5 }; -- Stone Swipe (Menhir Stoneskin)
    [84037] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_petrifying_bellow.dds' }; -- Petrifying Bellow (Menhir Stoneskin)
    [84038] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_petrifying_bellow.dds'; tooltip = Tooltips.Generic_Stun; noDuplicate = true }; -- Petrifying Bellow (Menhir Stoneskin)
    [84580] = { hide = true }; -- Petrifing Bellow (Menhir Stoneskin)
    [84292] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds' }; -- Graven Slash (Menhir Stoneskin)
    [84293] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds'; name = Abilities.Skill_Graven_Slash; tooltip = Tooltips.Skill_Graven_Slash; hideReduce = true }; -- Graven Slash (Menhir Stoneskin)
    [84294] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds'; tooltip = Tooltips.Skill_Graven_Slash }; -- Graven Slash (Menhir Stoneskin)
    [84014] = { icon = '/esoui/art/icons/achievement_els_pubdun1_groupevent.dds' }; -- Awaken (Menhir Stoneskin)
    [84029] = { icon = '/esoui/art/icons/achievement_els_pubdun1_groupevent.dds' }; -- Awaken (Menhir Stoneskin)
    [84417] = { icon = '/esoui/art/icons/achievement_els_pubdun1_groupevent.dds' }; -- Awaken (Menhir Stoneskin)
    [85461] = { hide = true }; -- Awaken (Menhir Stoneskin)

    -- World Boss - Magdelena's Haunt
    [83924] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fright_force.dds' }; -- Shadow Bolt (Magdelena)
    [83922] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aspect_of_terror.dds' }; -- Curse of Terror (Magdelena)
    [83923] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_aspect_of_terror.dds'; tooltip = Tooltips.Generic_Fear }; -- Curse of Terror (Magdelena)
    [83880] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_reflective_shadows.dds'; tooltip = Tooltips.Skill_Reflective_Shadows }; -- Reflective Shadows (Magdelena)
    [83227] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_zombie.dds' }; -- Dark Resurrection (Magdelena)
    [83886] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_shadow_flare.dds'; tooltip = Tooltips.Generic_Knockback }; -- Shadow Flare (Magdelena)
    [83883] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_shadow_flare.dds' }; -- Shadow Flare (Magdelena)

    ----------------------------------------------------------------
    -- DUNGEONS    -------------------------------------------------
    ----------------------------------------------------------------

    -- Banished Cells I
    [19028] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_drain_essence.dds'; hide = true }; -- Drain Essence (Cell Haunter)
    [46258] = { hide = true }; -- Clannfear Arrives (Shadowrend)
    [18725] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt_shadowrend.dds' }; -- Spiked Headbutt (Shadowrend)
    [47587] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike_shadowrend.dds' }; -- Tail Smite (Shadowrend)
    [47608] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike_shadowrend.dds'; name = Abilities.Skill_Tail_Smite; tooltip = Tooltips.Generic_Knockdown }; -- Knocked Down (Shadowrend)
    [21886] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_shadow_proxy.dds'; name = zo_strformat('<<1>> <<2>>', Abilities.Innate_Summon, Abilities.Skill_Shadow_Proxy); tooltip = Tooltips.Skill_Summon_Dark_Proxy }; -- Summon Dark Proxy (Shadowrend)
    [21887] = { hide = true }; -- Forward Charge (Dark Proxy)
    [35625] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap_shadowrend.dds' }; -- Pounce (Shadowrend)
    [18772] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour_shadowrend.dds'; name = Abilities.Skill_Devour; hide = true }; -- Feeding (Shadowrend)
    [18759] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap_shadowrend.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Pounce (Shadowrend)
    [18708] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_clannfear.dds'; tooltip = Tooltips.Skill_Summon_Clannfear }; -- Summon Clannfear (Angata the Clannfear Handler)
    [18709] = { hide = true }; -- Summon Appearance (Angata the Clannfear Handler)
    [19025] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_dead_zone.dds' }; -- Dead Zone (Skeletal Destroyer)
    [19027] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_dead_zone.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1.5; groundLabel = true }; -- Dead Zone (Skeletal Destroyer)
    [18961] = { hide = true }; -- Ghostly Summon (Generic Invisible Target)
    [18798] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Slash (High Kinlord Rilis)
    [33189] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_crushing_blow.dds'; name = Abilities.Skill_Overpower }; -- Crushing Blow (High Kinlord Rilis)
    [33190] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_crushing_blow.dds'; name = Abilities.Skill_Overpower; hide = true }; -- Crushing Blow (High Kinlord Rilis)
    [33191] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_crushing_blow.dds'; name = Abilities.Skill_Overpower; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Crushing Blow (High Kinlord Rilis)
    [18795] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_the_feast.dds'; name = Abilities.Skill_The_Feast }; -- CON_Invisible_30%_Speed_Debuff (The Feast)
    [33172] = { hide = true }; -- Oblivion Restoration (The Feast)
    [33165] = { hide = true }; -- Despawn Self (The Feast)
    [18840] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_blast.dds'; hide = true }; -- Soul Blast (High Kinlord Rilis)
    [18846] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_blast.dds'; hide = true }; -- Soul Blast (High Kinlord Rilis)
    [18847] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_blast.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Soul Blast (High Kinlord Rilis)
    [18875] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_tempest.dds'; hide = true }; -- Daedric Tempest (High Kinlord Rilis)
    [33437] = { hide = true }; -- Daedric Tempest (High Kinlord Rilis)
    [33174] = { hide = true }; -- Daedric Tempest (High Kinlord Rilis)
    [33188] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_tempest.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1.5; groundLabel = true }; -- Daedric Tempest (High Kinlord Rilis)
    [36522] = { hide = true }; -- Daedric Flames (High Kinlord Rilis)
    [46296] = { hide = true }; -- Crystals (Binding Stones)

    -- Banished Cells II
    [64490] = { hide = true }; -- Shatter
    [46715] = { hide = true }; -- DUN_BCH Cruelty One Shot
    [28902] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw.dds' }; -- Swipe (Maw of the Infernal)
    [48271] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Breath of Flame (Maw of the Infernal)
    [49149] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Breath of Flame (Maw of the Infernal)
    [35680] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Immolating Bite (Maw of the Infernal)
    [28904] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage.dds'; name = Abilities.Skill_Pool_of_Fire; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire_Stacking; tooltipValue2 = 1.5; tooltipValue3 = 10; stack = 1; stackAdd = 1 }; -- Immolating Bite (Maw of the Infernal)
    [47127] = { hide = true }; -- Nocom
    [48281] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Slash (Keeper Voranil)
    [27826] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_crushing_blow.dds'; name = Abilities.Skill_Overpower }; -- Crushing Blow (Keeper Voranil)
    [27827] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_crushing_blow.dds'; name = Abilities.Skill_Overpower; hide = true }; -- Crushing Blow (Keeper Voranil)
    [27828] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_2h_crushing_blow.dds'; name = Abilities.Skill_Overpower; tooltip = Tooltips.Generic_Knockback }; -- Crushing Blow (Keeper Voranil)
    [29018] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_berserker_frenzy.dds' }; -- Berserker Frenzy (Keeper Voranil)
    [29020] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_berserker_frenzy.dds' }; -- Berserker Frenzy (Keeper Voranil)
    [28750] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_essence_siphon.dds'; hide = true }; -- Essence Siphon (Keeper Voranil)
    [28759] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_essence_siphon.dds'; tooltip = Tooltips.Generic_Enrage_Stack_Permanent; tooltipValue2 = 10; stack = 1 }; -- Essence Siphon (Keeper Voranil)
    [64518] = { hide = true }; -- Shatter
    [30734] = { hide = true }; -- Portal (Daedric Chaos)
    [31713] = { hide = true }; -- Root (Daedric Chaos)
    [31726] = { hide = true }; -- Corruption (Daedric Chaos)
    [32054] = { hide = true }; -- SpawnRun (Banekin)
    [32038] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_chaotic_dispersion.dds'; name = Abilities.Skill_Chaotic_Dispersion; hide = true }; -- Into Portal (Keeper Imiril)
    [36631] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_chaotic_dispersion.dds'; name = Abilities.Skill_Chaotic_Return; hide = true }; -- ExitPortal (Keeper Imiril)
    [31727] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_chaos.dds'; groundLabel = true; name = Abilities.Skill_Daedric_Chaos; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1 }; -- Corruption (Daedric Chaos)
    [28916] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Slash (Keeper Imiril)
    [29143] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_blast.dds' }; -- Daedric Blast (Keeper Imiril)
    [64526] = { hide = true }; -- Shatter
    [28962] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sisters_bond.dds'; name = Abilities.Skill_Sisters_Bond }; -- Sister's Love (Sister Sihna / Sister Vera)
    [35847] = { hide = true }; -- Dummy
    [999013] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_enraged_fortitude.dds'; name = Abilities.Skill_Resilience; tooltip = Tooltips.Skill_Resilience }; -- FAKE AURA FOR DAEDROTH DAMAGE REDUCTION TO AOE
    [28570] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_levitate_blue.dds'; name = Abilities.Skill_Levitate; unbreakable = 1; tooltip = Tooltips.Skill_Levitating_Dominance }; -- Levitate (High Kinlord Rilis)
    [28462] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_levitate_red.dds'; name = Abilities.Skill_Levitate; unbreakable = 1; tooltip = Tooltips.Skill_Levitate_Suffering }; -- Levitate (High Kinlord Rilis)
    [28715] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_shock.dds' }; -- Daedric Bolt (High Kinlord Rilis)
    [28475] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_curse_of_suffering.dds'; tooltip = Tooltips.Skill_Curse_of_Suffering; unbreakable = 1; duration = 0 }; -- Curse of Suffering (High Kinlord Rilis)
    [48308] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_curse_of_suffering.dds' }; -- Curse of Suffering (High Kinlord Rilis)
    [28571] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_curse_of_dominance.dds'; tooltip = Tooltips.Skill_Curse_of_Dominance; unbreakable = 1; duration = 0 }; -- Curse of Dominance (High Kinlord Rilis)
    [48507] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_curse_of_dominance.dds' }; -- Curse of Dominance (High Kinlord Rilis)
    [46967] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_step.dds'; hide = true }; -- Daedric Step (High Kinlord Rilis)
    [46964] = { hide = true }; -- Daedric Step (High Kinlord Rilis)
    [46965] = { hide = true }; -- Daedric Step (High Kinlord Rilis)
    [48909] = { hide = true }; -- The Feast (High Kinlord Rilis)
    [26070] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_the_feast.dds' }; -- The Feast
    [48799] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_tempest.dds' }; -- Daedric Tempest (High Kinlord Rilis)
    [48814] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_tempest.dds' }; -- Daedric Tempest (High Kinlord Rilis)
    [48800] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_tempest.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1.5; groundLabel = true }; -- Daedric Tempest (High Kinlord Rilis)
    [48815] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_tempest.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1.5; groundLabel = true }; -- Daedric Tempest (High Kinlord Rilis)
    [28362] = { hide = true }; -- Black Sigil (High Kinlord Rilis)
    [36020] = { hide = true }; -- Black Sigil (High Kinlord Rilis)
    [28088] = { hide = true }; -- Red Sigil (High Kinlord Rilis)
    [36030] = { hide = true }; -- Red Sigil (High Kinlord Rilis)

    -- Elden Hollow I
    [14905] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_hacking_strike.dds'; name = Abilities.Skill_Quick_Strike }; -- Hacking Strike (Akash gra-Mal)
    [16834] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_executioners_strike.dds' }; -- Executioner's Strike (Akash gra-Mal)
    [25309] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_executioners_strike.dds'; name = Abilities.Skill_Executioners_Strike; hide = true }; -- Fire Backlash (Akash gra-Mal)
    [25310] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_executioners_strike.dds'; name = Abilities.Skill_Executioners_Strike; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Akash gra-Mal)
    [15999] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_leaping_strike.dds' }; -- Leaping Strike (Akash gra-Mal)
    [16003] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_leaping_strike.dds' }; -- Leaping Strike (Akash gra-Mal)
    [9936] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_battlecry.dds' }; -- Battlecry (Akash gra-Mal)
    [44093] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Battlecry (Akash gra-Mal)
    [16016] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_whirling_axe.dds'; name = Abilities.Skill_Whirling_Axe }; -- Berserker Frenzy (Akash gra-Mal)
    [16017] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_whirling_axe.dds'; name = Abilities.Skill_Whirling_Axe }; -- Berserker Frenzy (Akash gra-Mal)
    [25300] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_whirling_axe.dds'; name = Abilities.Skill_Whirling_Axe }; -- Berserker Frenzy (Akash gra-Mal)
    [25301] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_whirling_axe.dds'; name = Abilities.Skill_Whirling_Axe }; -- Berserker Frenzy (Akash gra-Mal)
    [25302] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_2h_whirling_axe.dds'; name = Abilities.Skill_Whirling_Axe }; -- Berserker Frenzy (Akash gra-Mal)
    [15116] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_strike.dds' }; -- Piercing Strike (Chokethorn)
    [15114] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds'; tooltip = Tooltips.Generic_Stun }; -- Pulling Grasp (Chokethorn)
    [25528] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds'; tooltip = Tooltips.Generic_Stun }; -- Pulling Grasp (Chokethorn)
    [9910] = { icon = '/esoui/art/icons/mh_hedgeguardian_strang.dds'; name = Abilities.Skill_Summon_Saplings }; -- Summon Saplings (Chokethorn)
    [9930] = { icon = '/esoui/art/icons/mh_hedgeguardian_strang.dds'; name = Abilities.Skill_Heal_Spores; tooltip = Tooltips.Generic_HoT_Channel; tooltipValue2 = 1.5 }; -- Heal Spores (Chokethorn)
    [9875] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_fungal_burst.dds' }; -- Fungal Burst (Chokethorn)
    [44092] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Generic Stagger Enemy (Chokethorn)
    [44223] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_inhale.dds' }; -- Inhale (Leafseether)
    [44225] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_inhale.dds'; hide = true }; -- Inhale (Leafseether)
    [15120] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_bolt.dds' }; -- Phantasmal Bolt (Canonreeve Oraneth)
    [9845] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rotting_bolt.dds'; hide = true }; -- Rotting Bolt (Canonreeve Oraneth)
    [9852] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rotting_bolt.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2 }; -- Rotting Bolt (Canonreeve Oraneth)
    [16262] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_circle.dds' }; -- Necrotic Circle (Canonreeve Oraneth)
    [25348] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_circle_stun.dds'; tooltip = Tooltips.Skill_Necrotic_Circle_Stun }; -- Necrotic Circle (Canonreeve Oraneth)
    [42601] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_circle.dds'; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 0.5; groundLabel = true }; -- Necrotic Circle (Canonreeve Oraneth)
    [25370] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_circle_stun.dds' }; -- Necrotic Circle (Canonreeve Oraneth)
    [46800] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_circle_stun.dds'; tooltip = Tooltips.Generic_Stun; unbreakable = 1 }; -- Necrotic Circle (Canonreeve Oraneth)
    [25820] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_skeleton_warrior.dds'; name = Abilities.Skill_Reanimate_Skeletons }; -- Necrotic Circle (Canonreeve Oraneth)
    [9944] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_explosion.dds' }; -- Necrotic Burst (Canonreeve Oraneth)
    [15682] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_explosion.dds'; tooltip = Tooltips.Generic_Knockback }; -- Necrotic Burst (Canonreeve Oraneth)
    [15681] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_explosion.dds' }; -- Necrotic Burst (Canonreeve Oraneth)
    [9839] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_bone_hurricane.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Bone Hurricane (Canonreeve Oraneth)
    [27891] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_circle_stun.dds'; tooltip = Tooltips.Skill_Necrotic_Circle_Stun }; -- Darkness Below (Elden Hollow)
    [27892] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_circle_stun.dds' }; -- Darkness Below (Elden Hollow)
    [27890] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_circle_stun.dds'; tooltip = Tooltips.Generic_Stun; unbreakable = 1; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Darkness Below (Elden Hollow)
    [28886] = { hide = true }; -- Darkness Below

    -- Elden Hollow II
    [31114] = { hide = true }; -- EHH_Striker_Invis (Dremora Fearkyn)
    [34376] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Flame Geyser (Dubroze the Infestor)
    [34377] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Flame Geyser (Dubroze the Infestor)
    [34378] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'; tooltip = Tooltips.Generic_Fear }; -- Flame Geyser (Dubroze the Infestor)
    [40753] = { hide = true }; -- PortalIntro (Portal)
    [32709] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_lacerate_dark.dds' }; -- Lacerate (Dark Root)
    [32569] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammering_light.dds'; hide = true }; -- Hammering Light (Dark Root)
    [32583] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammering_light.dds'; hide = true }; -- Hammering Light (Dark Root)
    [32587] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammering_light.dds'; hide = true }; -- Hammering Light (Dark Root)
    [32591] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_hammering_light.dds'; hide = true }; -- Hammering Light (Dark Root)
    [32707] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_guardians.dds' }; -- Summon Guardians (Dark Root)
    [33334] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_stamina.dds'; name = Abilities.Skill_Siphon_Stamina; tooltip = Tooltips.Skill_Siphon_Stamina }; -- Latch On Stamina (Frenzied Guardian)
    [33335] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_stamina.dds'; name = Abilities.Skill_Siphon_Stamina }; -- Latch On Stamina (Frenzied Guardian)
    [33337] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_magicka.dds'; name = Abilities.Skill_Siphon_Magicka; tooltip = Tooltips.Skill_Siphon_Magicka }; -- Latch On Magicka (Mystic Guardian)
    [33338] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_magicka.dds'; name = Abilities.Skill_Siphon_Magicka }; -- Latch On MAgicka (Mystic Guardian)
    [32655] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fortified_ground.dds'; name = Abilities.Skill_Fortified_Ground; groundLabel = true; tooltip = Tooltips.Skill_Dark_Root_Stamina }; -- Fortification (Fortified Guardian)
    [32614] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_empowered_ground.dds'; name = Abilities.Skill_Empowered_Ground; groundLabel = true; tooltip = Tooltips.Skill_Dark_Root_Magicka }; -- Empowered (Mystic Guardian)
    [32890] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_gleaming_light.dds'; hide = true }; -- Gleaming Light (Dark Root)
    [33533] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_gleaming_light.dds'; hide = true }; -- Glaring Light (Dark Root)
    [33535] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_gleaming_light.dds' }; -- Brightening Light (Dark Root)
    [33170] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_shadow_tendril.dds'; name = Abilities.Skill_Shadow_Tendril }; -- Hate (Shadow Tendril)
    [33164] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_incite_fear.dds'; tooltip = Tooltips.Generic_Fear }; -- Incite Fear (Shadow Tendril)
    [47087] = { hide = true }; -- Incite Fear (Shadow Tendril)
    [33499] = { hide = true }; -- EHH_Boss_02_Shadow_Effect
    [32811] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_dark.dds' }; -- Double Slam (Murklight)
    [32817] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw_dark.dds' }; -- Double Slam (Murklight)
    [33052] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize_dark.dds' }; -- Shadow Stomp (Murklight)
    [32832] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shadow_damage.dds' }; -- Consuming Shadow (Murklight)
    [32972] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shadow_damage.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5; groundLabel = true }; -- Consuming Shadow (Murklight)
    [33049] = { hide = true }; -- Eclipse (Murklight)
    [32975] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_eclipse.dds' }; -- Eclipse (Murklight)
    [33050] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_eclipse.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 0.5 }; -- Eclipse (Murklight)
    [33102] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shadow_damage.dds'; hide = true }; -- Spout Shadow (The Shadow Guard)
    [33104] = { hide = true }; -- Spout Shadow (The Shadow Guard)
    [33103] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shadow_damage.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1.5; groundLabel = true }; -- Spout Shadow (The Shadow Guard)
    [35371] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_pulverize_bogdan.dds' }; -- Emerge (Bogdan the Nightflame)
    [35372] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_pulverize_bogdan.dds'; tooltip = Tooltips.Generic_Knockback; unbreakable = 1 }; -- Emerge (Bogdan the Nightflame)
    [33313] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_strike_bogdan.dds' }; -- Swipe (Bogdan the Nightflame)
    [33359] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame_bogdan.dds' }; -- Swipe (Bogdan the Nightflame)
    [33432] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_daedric_flame_bogdan.dds' }; -- Daedric Flame (Bogdan the Nightflame)
    [33434] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_daedric_flame_bogdan.dds'; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1.5; groundLabel = true }; -- Daedric Flame (Bogdan the Nightflame)
    [33480] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_pulverize_bogdan.dds' }; -- Pulverize (Bogdan the Nightflame)
    [33492] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_pulverize_bogdan.dds' }; -- Pulverize (Bogdan the Nightflame)
    [33494] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_pulverize_bogdan.dds' }; -- Pulverize (Bogdan the Nightflame)
    [34260] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_nova_tendril.dds'; name = Abilities.Skill_Nova_Tendril }; -- Shadow (Nova Tendril)
    [34348] = { hide = true }; -- Dummy (The Opus of Torment)
    [30455] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds'; name = Abilities.Skill_Wracking_Pain; tooltip = Tooltips.Generic_Stun; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Arachnophobia (The Opus of Torment)

    -- City of Ash I
    [34245] = { hide = true }; -- Fireball (Invis)
    [29501] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_1h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Jab (Golor the Banekin Handler)
    [31101] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_steel_cyclone.dds'; name = Abilities.Skill_Steel_Cyclone }; -- Cleave (Golor the Banekin Handler)
    [25034] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace1h_crushing_blow.dds'; name = Abilities.Skill_Slam }; -- Crushing Blow (Golor the Banekin Handler)
    [25035] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace1h_crushing_blow.dds'; name = Abilities.Skill_Slam }; -- Crushing Blow (Golor the Banekin Handler)
    [25036] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace1h_crushing_blow.dds'; name = Abilities.Skill_Slam; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Crushing Blow (Golor the Banekin Handler)
    [33604] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_banekin.dds' }; -- Summon Banekin (Golor the Banekin Handler)
    [33612] = { hide = true }; -- Scampintro (Banekin)
    [34956] = { hide = true }; -- Intro (Warden of the Shrine)
    [34589] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_1h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Light Swing (Warden of the Shrine)
    [34607] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_macedw_crushing_blow.dds' }; -- Measured Uppercut (Warden of the Shrine)
    [34608] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_macedw_crushing_blow.dds'; hide = true }; -- Measured Uppercut (Warden of the Shrine)
    [34609] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_macedw_crushing_blow.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Measured Uppercut (Warden of the Shrine)
    [46568] = { icon = '/esoui/art/icons/ability_nightblade_008.dds'; tooltip = Tooltips.Generic_Stun }; -- Teleport Strike (Warden of the Shrine)
    [34654] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_ring.dds' }; -- Fan of Flames (Warden of the Shrine)
    [34620] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_ring.dds' }; -- Fan of Flames (Warden of the Shrine)
    [34960] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_ring.dds'; name = Abilities.Skill_Fan_of_Flames; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1.5; groundLabel = true }; -- Blazing Fire (Warden of the Shrine)
    [34352] = { hide = true }; -- Fire Tornado (Infernal Guardian)
    [34168] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_claw.dds' }; -- Double Slam (Infernal Guardian)
    [34169] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_claw.dds' }; -- Double Slam (Infernal Guardian)
    [34190] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_thorny_backhand.dds' }; -- Thorny Backhand (Infernal Guardian)
    [8398] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_thorny_backhand.dds'; name = Abilities.Skill_Thorny_Backhand; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 1 }; -- Bleeding (Infernal Guardian)
    [23074] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_thorny_backhand.dds'; name = Abilities.Skill_Thorny_Backhand }; -- Bleeding (Infernal Guardian)
    [34189] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_crushing_limbs.dds' }; -- Ground Slam (Infernal Guardian)
    [44079] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_crushing_limbs.dds' }; -- Ground Slam (Infernal Guardian)
    [44090] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Generic Stagger Enemy (Infernal Guardian)
    [35061] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_consuming_fire.dds' }; -- Consuming Fire (Infernal Guardian)
    [35144] = { icon = 'LuiExtended/media/icons/abilities/ability_set_infernal_guardian.dds' }; -- Fiery Explosion (Infernal Guardian)
    [35145] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_fire_consuming_fire.dds' }; -- Consuming Fire (Infernal Guardian)
    [34183] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_tunneling_roots.dds'; hide = true }; -- Tunneling Roots (Infernal Guardian)
    [34187] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_tunneling_roots.dds' }; -- Tunneling Roots (Infernal Guardian)
    [44089] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Generic Stagger Enemy (Infernal Guardian)
    [44278] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_eruption.dds'; hide = true }; -- Lava Geyser (Dark Ember)
    [44274] = { hide = true }; -- Lava Geyser (Dark Ember)
    [44276] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_eruption.dds' }; -- Lava Geyser (Dark Ember)
    [35409] = { hide = true }; -- Dummy (Rothariel Flameheart)
    [34198] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burning_field.dds'; hide = true }; -- Burning Field (Rothariel Flameheart)
    [34204] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burning_field.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Burning Field
    [34222] = { hide = true }; -- Spiderexplosion (Rothariel Flameheart)
    [34205] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_inferno.dds'; name = Abilities.Skill_Fiery_Deception }; -- Deception (Rothariel Flameheart)
    [34226] = { hide = true }; -- Dummy (Rothariel Flameheart)
    [49136] = { hide = true }; -- Oblivion Portal
    [49138] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds'; name = Abilities.Skill_Oblivion_Gate; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Oblivion Portal
    [49137] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds'; name = Abilities.Skill_Oblivion_Gate }; -- Oblivion Portal
    [34788] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quick_shot.dds'; name = Abilities.Skill_Quick_Shot }; -- Quick Dark (Razor Master Erthas)
    [34805] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds'; name = Abilities.Skill_Blazing_Embers }; -- Release Flame (Razor Master Erthas)
    [34901] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_arrow.dds' }; -- Burning Embers (Razor Master Erthas)
    [34948] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_arrow.dds'; name = Abilities.Skill_Blazing_Arrow; unbreakable = 1; tooltip = Tooltips.Skill_Blazing_Arrow; internalStack = 0 }; -- Burning Embers (Razor Master Erthas)
    [34949] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_arrow.dds'; name = Abilities.Skill_Blazing_Arrow }; -- Burning Embers (Razor Master Erthas)
    [34799] = { hide = true }; -- Lava Pitch (Release Flame)
    [34820] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds'; name = Abilities.Skill_Blazing_Embers }; -- Lava Pitch (Release Flame)
    [34953] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Blazing_Embers; duration = 20 }; -- Blazing Embers (Release Flame)
    [34951] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds' }; -- Blazing Embers (Release Flame)
    [34623] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_flame_atronach_red.dds'; name = Abilities.Skill_Summon_Flame_Atronach; hide = true }; -- Summon Flame Atronach (Razor Master Erthas)
    [35379] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Flare (Flame Atronach)
    [34780] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_flame_atronach_red.dds'; name = Abilities.Skill_Summon_Flame_Atronachs; hide = true }; -- Summon Flame Atranach (Razor Master Erthas)
    [34892] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_body_of_flame.dds' }; -- Body of Flame (Razor Master Erthas)
    [70113] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds'; name = Abilities.Skill_Wracking_Pain; tooltip = Tooltips.Generic_Stun; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Soul Scream (Scroll of Glorious Battle)

    -- City of Ash II
    [53999] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_flame_atronach_red.dds'; name = Abilities.Skill_Summon_Flame_Atronach }; -- Summon (Flame Atronach)
    [54126] = { icon = '/esoui/art/icons/ability_templar_sun_fire.dds'; name = Abilities.Skill_Sun_Fire; hide = true }; -- Minor Wound (Akezel)
    [54025] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_spell_absorption.dds'; tooltip = Tooltips.Skill_Spell_Absorption }; -- Spell Absorption (Akezel)
    [53994] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_focused_healing.dds' }; -- Focused Healing (Akezel)
    [53996] = { hide = true }; -- Health Boon (Akezel)
    [53988] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quick_shot.dds'; name = Abilities.Skill_Quick_Shot }; -- Quick Draw (Marruz)
    [54021] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds'; name = Abilities.Skill_Blazing_Embers }; -- Release Flame (Marruz)
    [54139] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1 }; -- Blazing Embers (Marruz)
    [54133] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds' }; -- Blazing Embers (Marruz)
    [53976] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_arrow.dds' }; -- Blazing Arrow (Marruz)
    [53978] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_arrow.dds'; name = Abilities.Skill_Blazing_Arrow; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1 }; -- Blazing Arrow (Marruz)
    [53977] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_arrow.dds'; name = Abilities.Skill_Blazing_Arrow }; -- Blazing Arrow (Marruz)
    [54129] = { name = Abilities.Skill_Fiery_Grip }; -- Fire Chain (Rukhan)
    [54145] = { name = Abilities.Skill_Fiery_Grip; tooltip = Tooltips.Generic_Stun }; -- Fire Chain (Rukhan)
    [54096] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm }; -- Pyrocasm (Rukhan)
    [54098] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Rukhan)
    [54097] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm }; -- Fire Backlash (Rukhan)
    [56811] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm }; -- Pyrocasm (Xivilai Ravager)
    [56813] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Xivilai Ravager)
    [56812] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm }; -- Fire Backlash (Xivilai Ravager)
    [55654] = { hide = true }; -- Venomous Explosion (Venomous Skeleton)
    [55655] = { hide = true }; -- Venomous Explosion (Venomous Skeleton)
    [55658] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_venomous_explosion.dds' }; -- Venomous Explosion (Venomous Skeleton)
    [55657] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Venomous Explosion (Venomous Skeleton)
    [55184] = { hide = true }; -- Urata Spawn In
    [56419] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Flare (Urata the Legion)
    [56414] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_rune.dds'; name = Abilities.Skill_Fire_Rune }; -- Fire Runes (Urata the Legion)
    [56415] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_rune.dds'; name = Abilities.Skill_Fire_Rune; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1; groundLabel = true }; -- Fire Runes (Urata the Legion)
    [54272] = { hide = true }; -- Clone Spawn FX (Clones)
    [54273] = { hide = true }; -- Clone Spawn In (Clones)
    [72285] = { hide = true }; -- No Damage While Spawning (Clones)
    [54455] = { hide = true }; -- Clone Less DMG (Clones)
    [54453] = { hide = true }; -- Absorb Clones (Urata the Legion)
    [56420] = { hide = true }; -- Reunite (Urata the Legion)
    [56440] = { hide = true }; -- Set Clone CD (Urata the Legion)
    [54225] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_multiply_female.dds' }; -- Multiply (Urata the Legion)
    [56098] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_multiply_female.dds' }; -- Multiply (Urata the Legion)
    [56104] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_multiply_female.dds' }; -- Multiply (Urata the Legion)
    [56131] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_reunite_female.dds' }; -- Reunite (Urata the Legion)
    [61201] = { hide = true }; -- Melt Up
    [56178] = { hide = true }; -- Gaunt NPC Add Threat
    [56186] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_voice_to_wake_the_dead.dds' }; -- Voice to Wake the Dead (Flame Colossus)
    [86753] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_torrent.dds'; name = Abilities.Skill_Split_Flare }; -- Bone Flare (Flame Colossus)
    [55744] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_torrent.dds'; name = Abilities.Skill_Split_Flare }; -- Bone Flare (Flame Colossus)
    [56055] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw.dds' }; -- Jagged Claw (Horvantud the Fire Maw)
    [56054] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds' }; -- Fiery Jaws (Horvantud the Fire Maw)
    [56307] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1 }; -- Fiery Jaws (Horvantud the Fire Maw)
    [55203] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_tremor.dds' }; -- Seismic Tremor (Horvantud the Fire Maw)
    [56043] = { hide = true }; -- Seismic Tremor (Horvantud the Fire Maw)
    [56034] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_tremor.dds'; name = Abilities.Skill_Seismic_Tremor; hide = true }; -- Ground Tremor (Horvantud the Fire Maw)
    [56264] = { hide = true; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Horvantud the Fire Maw)
    [56265] = { hide = true }; -- Tremor (Horvantud the Fire Maw)
    [56002] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_quake.dds'; hide = true }; -- Ground Quake (Horvantud the Fire Maw)
    [56006] = { hide = true }; -- VDUN_CoA_B_GroundQuake (Horvantud the Fire Maw)
    [56003] = { hide = true }; -- Ground Quake (Horvantud the Fire Maw)
    [56004] = { hide = true }; -- Ground Quake (Horvantud the Fire Maw)
    [56007] = { hide = true }; -- Ground Quake (Horvantud the Fire Maw)
    [56008] = { hide = true }; -- Ground Quake (Horvantud the Fire Maw)
    [56010] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_quake.dds' }; -- Ground Quake (Horvantud the Fire Maw)
    [55312] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'; name = Abilities.Skill_Fiery_Breath }; -- Slag Breath (Horvantud the Fire Maw)
    [55314] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'; name = Abilities.Skill_Fiery_Breath }; -- Slag Breath (Horvantud the Fire Maw)
    [55333] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55334] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55320] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55321] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55335] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55336] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55326] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55327] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55337] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55338] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }; -- Fiery Breath (Horvantud the Fire Maw)
    [55315] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; tooltip = Tooltips.Skill_Enrage_Horvantud; stack = 1 }; -- Slag Breath (Horvantud the Fire Maw)
    [55319] = { hide = true }; -- Slag Breath (Horvantud the Fire Maw)
    [55318] = { hide = true }; -- Slag Breath (Horvantud the Fire Maw)
    [55324] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; tooltip = Tooltips.Skill_Enrage_Horvantud; stack = 2 }; -- Enrage 2 (Horvantud the Fire Maw)
    [55325] = { hide = true }; -- Enrage 2 Tracker (Horvantud the Fire Maw)
    [55332] = { hide = true }; -- Remove Enrage 1 (Horvantud the Fire Maw)
    [55330] = { hide = true }; -- Remove Enrage 1 (Horvantud the Fire Maw)
    [55323] = { hide = true }; -- Can Enrage Go 3 (Horvantud the Fire Maw)
    [55329] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; name = Abilities.Skill_Enrage; tooltip = Tooltips.Skill_Enrage_Horvantud; stack = 3 }; -- Enrage 3 (Horvantud the Fire Maw)
    [55331] = { hide = true }; -- Remove Enrage 2 (Horvantud the Fire Maw)
    [57618] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_enraged_fortitude.dds'; name = Abilities.Skill_Enraged_Fortitude; duration = 0; tooltip = Tooltips.Generic_Damage_Shield_No_Duration }; -- Damage Shield (Horvantud the Fire Maw)
    [55724] = { hide = true }; -- Clean Up (Horvantud the Fire Maw)
    [54763] = { hide = true }; -- VDUN-CoA-B2 Fly In Intro (Ash Titan - Theater)
    [54764] = { hide = true }; -- Backdraft (Ash Titan - Theater)
    [54767] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_backdraft.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Backdraft
    [54768] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_backdraft.dds'; unbreakable = 1 }; -- Backdraft
    [54218] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_monstrous_cleave.dds' }; -- Monstrous Cleave (Ash Titan)
    [54224] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_monstrous_cleave.dds'; unbreakable = 1 }; -- Monstrous Cleave (Ash Titan)
    [54223] = { hide = true }; -- Monstrous Cleave (Ash Titan)
    [54222] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_monstrous_cleave.dds'; tooltip = Tooltips.Generic_Knockback; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Monstrous Cleave (Ash Titan)
    [61214] = { hide = true }; -- Monstrous Cleave (Ash Titan)
    [54221] = { hide = true; name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Monstrous Cleave (Ash Titan)
    [54266] = { hide = true }; -- Cleave (Ash Titan)
    [54267] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame_ash.dds' }; -- Lava Bolt (Ash Titan)
    [54270] = { hide = true }; -- Lava Bolt (Ash Titan)
    [56151] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burning_field.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1 }; -- Ethereal Flame (Ash Titan)
    [56152] = { hide = true }; -- Ethereal Flame (Ash Titan)
    [54895] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_rain.dds' }; -- Molten Rain (Ash Titan)
    [54913] = { hide = true }; -- Molten Rain (Ash Titan)
    [56096] = { hide = true }; -- Molten Rain (Ash Titan)
    [54973] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_rain.dds' }; -- Molten Rain (Ash Titan)
    [55179] = { hide = true }; -- Molten Rain (Ash Titan)
    [55128] = { hide = true }; -- Molten Rain (Ash Titan)
    [55175] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_molten_rain.dds' }; -- Molten Rain (Ash Titan)
    [54698] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_flame_tsunami.dds'; name = Abilities.Skill_Flame_Tsunami; hide = true }; -- Fire Swarm (Ash Titan)
    [54857] = { hide = true }; -- Random Target (Ash Titan)
    [54858] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_backdraft.dds'; name = Abilities.Skill_Wing_Gust; hide = true }; -- Knockback
    [54873] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_backdraft.dds'; name = Abilities.Skill_Wing_Gust; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Heavy Slash
    [54856] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_backdraft.dds'; name = Abilities.Skill_Wing_Gust; hide = true }; -- Wing Burst (Ash Titan)
    [54855] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_backdraft.dds'; name = Abilities.Skill_Wing_Gust; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 20 }; -- Shockwave (Ash Titan)
    [54859] = { hide = true; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Ash Titan)
    [54874] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_backdraft.dds'; name = Abilities.Skill_Wing_Gust; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 20 }; -- Shockwave (Ash Titan)
    [56145] = { hide = true }; -- Shockwave (Ash Titan)
    [56144] = { hide = true }; -- Shockwave (Ash Titan)
    [54699] = { hide = true }; -- Fire Swarm (Ash Titan)
    [54648] = { hide = true }; -- Fire Swarm (Ash Titan)
    [54861] = { hide = true }; -- Fire Swarm (Ash Titan)
    [54654] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_flame_tsunami.dds'; name = Abilities.Skill_Flame_Tsunami }; -- Fire Swarm (Ash Titan)
    [56375] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_flame_tsunami.dds'; name = Abilities.Skill_Flame_Tsunami }; -- Fire Swarm (Ash Titan)
    [56309] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_flame_tsunami.dds'; name = Abilities.Skill_Flame_Tsunami }; -- Fire Swarm (Ash Titan)
    [56357] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_flame_tsunami.dds'; name = Abilities.Skill_Flame_Tsunami; tooltip = Tooltips.Skill_Flame_Tsunami }; -- Fire Swarm (Ash Titan)
    [56358] = { hide = true }; -- Fire Swarm (Ash Titan)
    [56369] = { hide = true }; -- Fire Swarm (Ash Titan)
    [58468] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_ignore_pain.dds'; name = Abilities.Skill_Ignore_Pain; tooltip = Tooltips.Skill_Ignore_Pain; duration = 0 }; -- Shadow Cloak (Ash Titan)
    [54779] = { hide = true }; -- Air Take Flame (Air Atronach)
    [54786] = { hide = true }; -- VDUN_CoA_B2_Air Take Flame (Air Atronach)
    [54783] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_flame.dds'; name = Abilities.Skill_Empower_Atronach_Flame; tooltip = Tooltips.Skill_Empower_Atronach_Flame_Unlimited; duration = 0 }; -- Air Atronach Flame (Air Atronach)
    [54788] = { hide = true }; -- Remove Blood Lust (Air Atronach)
    [56318] = { hide = true }; -- Cooldowns (Ash Titan)
    [56319] = { hide = true }; -- Cooldowns2 (Ash Titan)
    [54366] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds'; hide = true }; -- Flame Tornado (Air Atronach)
    [56312] = { hide = true }; -- Flame Tornado (Air Atronach)
    [60683] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_barrier.dds'; name = Abilities.Skill_Flame_Barrier; tooltip = Tooltips.Generic_Damage_Shield_Percent_Duration; tooltipValue2 = 35 }; -- Flame Tornado (Air Atronach)
    [54367] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }; -- Flame Tornado (Air Atronach)
    [54370] = { hide = true }; -- Flame Tornado Snare (Air Atronach)
    [54790] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }; -- Swipe (Air Atronach)
    [54791] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }; -- Swipe (Air Atronach)
    [58280] = { icon = '/esoui/art/icons/ability_sorcerer_storm_atronach.dds'; name = Abilities.Skill_Call_Storm_Atronach }; -- Scary Summon 1 (Xivilai Fulminator / Boltaic)
    [56601] = { icon = '/esoui/art/icons/ability_sorcerer_storm_atronach.dds'; name = Abilities.Skill_Call_Storm_Atronachs }; -- Scary Summon 2 (Xivilai Fulminator / Boltaic)
    [56651] = { hide = true }; -- Flame Shield (Gilrean)
    [55879] = { hide = true }; -- Lava Spout IdleFX
    [55783] = { hide = true }; -- Slag Geyser
    [55800] = { hide = true }; -- Slag Geyser
    [55792] = { hide = true }; -- Slag Geyser
    [55784] = { hide = true }; -- Slag Geyser
    [55801] = { hide = true }; -- Slag Geyser
    [55793] = { hide = true }; -- Slag Geyser
    [56068] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_eruption.dds' }; -- Slag Geyser (Valkyn Skoria)
    [55513] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_bolt.dds' }; -- Flame Bolt (Valkyn Skoria)
    [55573] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_bolt.dds'; name = Abilities.Skill_Flame_Bolt; hide = true }; -- Flame Bolt Knockdown (Valkyn Skoria)
    [55574] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_bolt.dds'; name = Abilities.Skill_Flame_Bolt; hide = true }; -- Meteor Strike (Valkyn Skoria)
    [55575] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flame_bolt.dds'; name = Abilities.Skill_Flame_Bolt; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Meteor Strike (Valkyn Skoria)
    [55387] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_meteor_strike.dds'; name = Abilities.Skill_Meteoric_Strike }; -- Meteor Strike (Valkyn Skoria)
    [55758] = { hide = true }; -- Meteor Strike (Valkyn Skoria)
    [56167] = { hide = true }; -- Meteor Strike (Valkyn Skoria)
    [55391] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_meteor_strike.dds'; name = Abilities.Skill_Meteoric_Strike; hide = true; unbreakable = 1 }; -- Meteor Strike (Valkyn Skoria)
    [55390] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_meteor_strike.dds'; name = Abilities.Skill_Meteoric_Strike; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Meteor Strike (Valkyn Skoria)
    [55506] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_meteor.dds' }; -- Meteor (Valkyn Skoria)
    [55502] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_meteor.dds'; name = Abilities.Skill_Meteor; tooltip = Tooltips.Generic_Stun }; -- Meteor (Valkyn Skoria)
    [55382] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_strike.dds' }; -- Flame Strike (Valkyn Skoria)
    [55383] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_strike.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1 }; -- Flame Strike (Valkyn Skoria)
    [55559] = { hide = true }; -- Call the Flames (Valkyn Skoria)
    [55755] = { hide = true }; -- Call the Flames (Valkyn Skoria)
    [55572] = { hide = true }; -- Heat Wave (Fire Stab)
    [55514] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds' }; -- Call the Flames (Valkyn Skoria)
    [55756] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_blazing_embers.dds'; name = Abilities.Skill_Call_the_Flames; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1.5; unbreakable = 1 }; -- Burning (Fire Stab)
    [55426] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_petrify.dds' }; -- Magma Prison (Valkyn Skoria)
    [55463] = { hide = true }; -- Magma Prison (Valkyn Skoria)
    [55464] = { hide = true }; -- Magma Prison Track (Valkyn Skoria)
    [55458] = { hide = true }; -- Magma Prison (Valkyn Skoria)
    [55429] = { hide = true }; -- Magma Prison (Valkyn Skoria)
    [55468] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_petrify.dds'; hide = true }; -- Magma Prison (Valkyn Skoria)
    [56296] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_petrify.dds'; tooltip = Tooltips.Skill_Magma_Prison }; -- Magma Prison (Valkyn Skoria)
    [56383] = { hide = true }; -- Magma Prison (Valkyn Skoria)
    [60644] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_petrify.dds' }; -- Magma Prison (Valkyn Skoria)
    [55469] = { hide = true }; -- Magma Prison (Valkyn Skoria)
    [56297] = { hide = true }; -- Magma Prison (Valkyn Skoria)
    [55031] = { hide = true }; -- Can Quake (Valkyn Skoria)
    [55024] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_platform_detonation.dds'; name = Abilities.Skill_Platform_Detonation }; -- Lava Quake (Valkyn Skoria)
    [55032] = { hide = true }; -- Lava Quake (Valkyn Skoria)
    [55134] = { hide = true }; -- Test (Valkyn Skoria)
    [56549] = { hide = true }; -- Lava Quake (Valkyn Skoria)
    [56242] = { hide = true }; -- Block Spout (Valkyn Skoria)
    [58506] = { hide = true }; -- Expl Sound (Valkyn Skoria)
    [55133] = { hide = true }; -- Can Teleport (Valkyn Skoria)
    [55593] = { hide = true }; -- Can Flame Shield (Valkyn Skoria)
    [55497] = { hide = true }; -- Rock Shield (Valkyn Skoria)
    [55500] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_volcanic_shield.dds'; name = Abilities.Skill_Volcanic_Shield; tooltip = Tooltips.Skill_Volcanic_Shield; duration = 0 }; -- Rock Shield (Valkyn Skoria)
    [55632] = { hide = true }; -- Add Ticking (Valkyn Skoria)
    [55622] = { hide = true }; -- Rock Shield (Flame Atronach)
    [55499] = { hide = true }; -- Rock Shield (Valkyn Skoria)
    [55498] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_fiery_surge.dds' }; -- Flame Spit (Valkyn Skoria)
    [55501] = { hide = true }; -- Rock Shield (Valkyn Skoria)
    [56239] = { hide = true }; -- Rock Shield (Valkyn Skoria)
    [56240] = { hide = true }; -- Rock Shield (Valkyn Skoria)
    [56241] = { hide = true }; -- Rock Shield (Valkyn Skoria)
    [56548] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_platform_detonation.dds' }; -- Platform Detonation (Valkyn Skoria)
    [56551] = { hide = true; name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Lava Quake (Valkyn Skoria)
    [55623] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_flame_atronach_red.dds'; name = Abilities.Skill_Summon_Flame_Atronachs }; -- Flame Atronach (Valkyn Skoria)
    [55059] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_body_of_flame.dds' }; -- Body of Flame (Razor Master Erthas)
    [56563] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds'; name = Abilities.Skill_Wracking_Pain; tooltip = Tooltips.Generic_Stun; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Book (Frigid Tome)

    -- Tempest Island
    [28012] = { hide = true }; -- Fireball
    [43049] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Fireball (Lamia Curare)
    [46732] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_sonic_scream.dds' }; -- Sonic Scream (Sonolia the Matriarch)
    [46738] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_sonic_scream.dds'; name = Abilities.Skill_Sonic_Scream }; -- Piercing Shriek (Sonolia the Matriarch)
    [46737] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Piercing Shriek (Sonolia the Matriarch)
    [26676] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds'; name = Abilities.Skill_Lightning_Strike; tooltip = Tooltips.Generic_Stun; unbreakable = 1 }; -- IntroKB (Valaran Stormcaller)
    [26678] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_strike.dds'; name = Abilities.Skill_Lightning_Strike }; -- Staggering Roar (Valaran Stormcaller)
    [26604] = { hide = true }; -- Storm (Sudden Storm)
    [26619] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sudden_storm.dds'; name = Abilities.Skill_Sudden_Storm; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Shock (Sudden Storm)
    [26332] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Slash (Valaran Stormcaller)
    [26370] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_crushing_blow.dds'; name = Abilities.Skill_Heavy_Slash }; -- Crushing Blow (Valaran Stormcaller)
    [26371] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_crushing_blow.dds'; name = Abilities.Skill_Heavy_Slash; hide = true }; -- Crushing Blow (Valaran Stormcaller)
    [26372] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_crushing_blow.dds'; name = Abilities.Skill_Heavy_Slash; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Crushing Blow (Valaran Stormcaller)
    [26628] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_enervating_bolt.dds'; tooltip = Tooltips.Generic_Stun }; -- Enervating Bolt
    [26631] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_enervating_bolt.dds' }; -- Enervating Bolt
    [26592] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_avatar.dds' }; -- Lightning Avatar (Valaran Stormcaller)
    [28391] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback.dds'; name = Abilities.Skill_Feedback; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Q4538 Stoen Explosion (Conduit Stone)
    [32451] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback.dds'; name = Abilities.Skill_Feedback }; -- Fire Backlash (Conduit Stone)
    [5699] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowstep.dds'; name = Abilities.Skill_Shadowstep }; -- Backstab (Yalorasse the Speaker)
    [5698] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowstep.dds'; name = Abilities.Skill_Shadowstep; tooltip = Tooltips.Skill_Backstab }; -- Backstab (Yalorasse the Speaker)
    [5697] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shadowstep.dds'; name = Abilities.Skill_Shadowstep }; -- Backstab (Yalorasse the Speaker)
    [6106] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_storm.dds' }; -- Lightning Storm (Yalorasse the Speaker)
    [6108] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_storm.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1 }; -- Lightning Storm (Yalorasse the Speaker)
    [6107] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_shock_snare.dds'; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 25 }; -- Lightning Storm (Yalorasse the Speaker)
    [29063] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_poisoned_blade.dds'; hide = true }; -- Poisoned Blade (Yalorasse the Speaker)
    [29064] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_poisoned_blade.dds'; name = Abilities.Skill_Poisoned_Blade; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 1.5; stack = 0 }; -- Crimson Web Poison (Yalorasse the Speaker)
    [26743] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_bash.dds' }; -- Left Cross (Stormfist)
    [26714] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_skyward_slam.dds' }; -- Skyward Slam (Stormfist)
    [26716] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_skyward_slam.dds'; tooltip = Tooltips.Generic_Knockback; unbreakable = 1 }; -- Skyward Slam (Stormfist)
    [26715] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_skyward_slam.dds' }; -- Skyward Slam (Stormfist)
    [27263] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_thunderbolt.dds'; hide = true }; -- Skyward Slam (Stormfist)
    [26748] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_enervating_stone.dds' }; -- Enervating Stone (Stormfist)
    [46122] = { hide = true }; -- Enervating Stone (Stormfist)
    [26752] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_enervating_stone.dds'; groundLabel = true; tooltip = Tooltips.Skill_Enervating_Stone }; -- Enervating Stone (Stormfist)
    [26938] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_enervating_stone.dds'; tooltip = Tooltips.Generic_Stun_No_Dur; hideGround = true; groundLabel = true }; -- Enervating Stone (Stormfist)
    [26833] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_storm_atronach.dds'; name = Abilities.Skill_Call_Storm_Atronachs }; -- Summon Storm Atronach (Stormfist)
    [26851] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_storm_atronach.dds'; name = Abilities.Skill_Call_Storm_Atronachs; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Summon Storm Atronach (Stormfist)
    [26836] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_storm_atronach.dds'; name = Abilities.Skill_Call_Storm_Atronachs; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Summon Storm Atronach (Stormfist)
    [26838] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_call_storm_atronach.dds'; name = Abilities.Skill_Call_Storm_Atronachs }; -- Summon Storm Atronach (Stormfist)
    [26790] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_unstable_explosion.dds' }; -- Unstable Explosion (Stormfist)
    [27039] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ethereal_chain.dds'; tooltip = Tooltips.Skill_Ethereal_Chain }; -- Ethereal Chain (Commodore Ohmanil)
    [27058] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ethereal_chain.dds' }; -- Ethereal Chain (Commodore Ohmanil)
    [27624] = { hide = true }; -- Wind Storm
    [26534] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sparks.dds'; hide = true }; -- Sparking Strike (Stormreeve Neider)
    [27596] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_agonizing_strike.dds' }; -- Lightning Strike (Stormreeve Neider)
    [26741] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_wind_charge.dds'; name = Abilities.Skill_Wind_Charge }; -- Swift Wind (Stormreeve Neider)
    [26746] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_wind_charge.dds'; name = Abilities.Skill_Wind_Charge; hide = true }; -- Wind Charge (Stormreeve Neider)
    [26759] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_wind_charge.dds'; name = Abilities.Skill_Wind_Charge }; -- Swift Wind (Stormreeve Neider)
    [26712] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave_radial.dds'; name = Abilities.Skill_Shockwave }; -- Gust of Wind (Stormreeve Neider)
    [46810] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave_radial.dds'; name = Abilities.Skill_Shockwave; hide = true }; -- Gust of Wind (Stormreeve Neider)
    [46809] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave_radial.dds'; name = Abilities.Skill_Shockwave; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Gust of Wind (Stormreeve Neider)
    [26514] = { hide = true }; -- Twister (Twister)
    [26517] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_twister.dds'; name = Abilities.Skill_Twister }; -- Twister (Twister)
    [46808] = { hide = true; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Twister)

    -- Selene's Web
    [32428] = { hide = true }; -- Climb Away
    [30909] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_ensnare.dds'; tooltip = Tooltips.Skill_Ensnare; unbreakable = 1; hideReduce = true }; -- Ensnare
    [31247] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_ensnare.dds'; tooltip = Tooltips.Skill_Ensnare; unbreakable = 1; hideReduce = true }; -- Ensnare
    [49275] = { hide = true }; -- Ensnare (Treethane Kerninn)
    [31248] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_mace_2h_ensnare.dds'; tooltip = Tooltips.Skill_Ensnare; unbreakable = 1 }; -- Ensnare
    [64171] = { hide = true }; -- SW_Boss3_WebGrip (Treethane Kerninn)
    [30907] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_summon_primal_swarm.dds'; name = Abilities.Skill_Primal_Swarm; hide = true }; -- Summon Primal Swarm (Treethane Kerninn)
    [30908] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_summon_primal_swarm.dds'; name = Abilities.Skill_Primal_Swarm; groundLabel = true; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1 }; -- Summon Primal Swarm (Treethane Kerninn)
    [30781] = { icon = '/esoui/art/icons/ability_healer_022.dds'; tooltip = Tooltips.Skill_Mirror_Ward }; -- Mirror Ward (Longclaw)
    [30785] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quick_shot.dds'; name = Abilities.Skill_Quick_Shot }; -- Quick Shot (Longclaw)
    [30772] = { icon = '/esoui/art/icons/ability_bow_003.dds'; name = Abilities.Skill_Volley }; -- Arrow Rain (Longclaw)
    [30773] = { icon = '/esoui/art/icons/ability_bow_003.dds'; name = Abilities.Skill_Volley; groundLabel = true; tooltip = Tooltips.Generic_AOE_Physical; tooltipValue2 = 0.5 }; -- Arrow Rain (Longclaw)
    [30779] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_senche_spirit.dds'; name = Abilities.Skill_Senche_Spirit; hide = true }; -- Spirit Form (Senche Spirit)
    [30801] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_poisoned_arrow.dds' }; -- Poison Shot (Longclaw)
    [30802] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_poisoned_arrow.dds'; tooltip = Tooltips.Skill_Poison_Shot }; -- Poison Shot (Longclaw)
    [30803] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_poisoned_arrow.dds' }; -- Poison Shot (Longclaw)
    [60670] = { hide = true }; -- Poison Shot (Longclaw)
    [31096] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_basilisk_powder.dds' }; -- Poison Burst (Longclaw)
    [31154] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_basilisk_powder.dds'; tooltip = Tooltips.Generic_Stun }; -- Poison Burst (Longclaw)
    [31150] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_poison_damage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Poison; tooltipValue2 = 1 }; -- Poison Burst (Longclaw)
    [34520] = { hide = true }; -- Q4733_Locked_Door_Effect
    [31202] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_poison.dds'; hide = true }; -- Venomous Burst (Queen Aklayah)
    [31205] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_venomous_burst.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Venomous_Burst; tooltipValue2 = 5; tooltipValue3 = 1 }; -- Venomous Burst (Queen Aklayah)
    [31203] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_venomous_burst.dds' }; -- Venomous Burst (Queen Aklayah)
    [30982] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds'; name = Abilities.Skill_Bite }; -- Swipe (Foulhide)
    [31002] = { hide = true; icon = '/esoui/art/icons/mh_hedgeguardian_strang.dds'; name = Abilities.Skill_Selenes_Rose }; -- Intro (Selene's Rose)
    [31003] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_lash.dds'; name = Abilities.Skill_Lash }; -- Lunge (Selene's Rose)
    [9039] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds'; name = Abilities.Skill_Grappling_Web; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 40 }; -- Snare (Selene's Rose)
    [30996] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds'; name = Abilities.Skill_Vicious_Maul }; -- Vicious Maul (Foulhide)
    [46879] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds'; name = Abilities.Skill_Vicious_Maul; hide = true }; -- Fire Backlash (Foulhide)
    [46878] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds'; name = Abilities.Skill_Vicious_Maul; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Foulhide)
    [31001] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_horrifying_roar.dds'; tooltip = Tooltips.Generic_Fear }; -- Horrifying Roar (Foulhide)
    [30812] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_trampling_charge.dds' }; -- Trampling Charge (Foulhide)
    [30813] = { hide = true }; -- Trampling Charge (Foulhide)
    [30986] = { hide = true }; -- Trampling Charge (Foulhide)
    [31368] = { hide = true }; -- Stun (Foulhide)
    [30987] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_trampling_charge.dds' }; -- Trampling Charge (Foulhide)
    [46895] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_trampling_charge.dds'; name = Abilities.Skill_Trampling_Charge; tooltip = Tooltips.Generic_Knockdown }; -- Knocked Down (Foulhide)
    [31366] = { hide = true }; -- Emboldened (Foulhide)
    [31241] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_spawn_hatchlings.dds' }; -- Summon Spiders (Mennir Many-Legs)
    [31189] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_bite.dds' }; -- Bite (Selene)
    [31183] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds' }; -- Rending Venom (Selene)
    [31186] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds'; tooltip = Tooltips.Generic_Poison; tooltipValue2 = 2; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Rending Venom (Selene)
    [31048] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_web_wrap.dds'; hide = true }; -- Web Wrap (Selene)
    [31052] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_web_wrap.dds'; tooltip = Tooltips.Skill_Web_Wrap }; -- Web Wrap (Selene)
    [31469] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_web_wrap.dds' }; -- Web Wrap (Selene)
    [31180] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_free_ally.dds' }; -- Free Ally (Selene)
    [59486] = { hide = true }; -- Shield (Selene)
    [59487] = { hide = true }; -- Shield (Selene)
    [35558] = { hide = true }; -- Exoburst (Selene)
    [35561] = { hide = true }; -- Encase (Selene)
    [35598] = { hide = true }; -- Dummy (Selene)
    [35826] = { hide = true }; -- Webmove (Selene)
    [58521] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web_white.dds'; tooltip = Tooltips.Generic_Stun; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Web (Selene)
    [35824] = { hide = true }; -- DUN_SW_Boss3_Pullplayer (Selene)
    [33347] = { hide = true }; -- Webbreakfx (Webbreakdummy)
    [59488] = { hide = true }; -- Remove Shield (Selene)
    [31191] = { hide = true }; -- Transform into Bosmer (Selene)
    [31218] = { hide = true }; -- Spiderexplosion (Selene)
    [30731] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_primal_maul.dds'; name = Abilities.Skill_Primal_Maul; hide = true }; -- Summon Primal Spirit (Selene)
    [30725] = { hide = true }; -- Dummy (Ghostbear)
    [30724] = { hide = true }; -- Dummy (Ghostbear)
    [30730] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_primal_maul.dds'; name = Abilities.Skill_Primal_Maul }; -- Summon Primal Spirit (Selene)
    [30970] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_primal_maul.dds'; name = Abilities.Skill_Primal_Maul; hide = true }; -- Summon Primal Spirit (Selene)
    [30969] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_primal_maul.dds'; name = Abilities.Skill_Primal_Maul; tooltip = Tooltips.Generic_Knockback; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Summon Primal Spirit (Selene)
    [30968] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Bash (Selene)
    [30896] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_primal_leap.dds'; name = Abilities.Skill_Primal_Leap; hide = true }; -- Summon Senche Spirit (Selene)
    [30905] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_primal_leap.dds'; name = Abilities.Skill_Primal_Leap; tooltip = Tooltips.Generic_Stun; unbreakable = 1 }; -- IntroKB (Spectral Senche-Tiger)
    [30901] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_primal_leap.dds' }; -- IntroKB (Spectral Senche-Tiger)
    [31986] = { icon = 'LuiExtended/media/icons/abilities/ability_dungeon_root_guard.dds'; name = Abilities.Skill_Root_Guard }; -- Summon Melee (Selene)
    [31984] = { icon = '/esoui/art/icons/ava_siege_hookpoint_001.dds'; name = Abilities.Skill_Earth_Mender }; -- Summon Healer (Selene)
    [31985] = { icon = '/esoui/art/icons/ava_siege_hookpoint_003.dds'; name = Abilities.Skill_True_Shot }; -- Summon Archer (Selene)

    -- Spindleclutch I
    [46147] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_brood.dds'; name = Abilities.Skill_Summon_Swarm }; -- Summon Swarm (Spindlekin)
    [17957] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_bite.dds' }; -- Bite (Swarm Mother)
    [22034] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds' }; -- Inject Poison (Swarm Mother)
    [22035] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Inject_Poison }; -- Inject Poison (Swarm Mother)
    [22087] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Inject_Poison; hideReduce = true }; -- Inject Poison (Swarm Mother)
    [22086] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds' }; -- Inject Poison (Swarm Mother)
    [17964] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds'; hide = true }; -- Impeding Webs (Swarm Mother)
    [17965] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds'; duration = 0; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 60 }; -- Impeding Webs (Swarm Mother)
    [17960] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_arachnid_leap.dds' }; -- Arachnid Leap (Swarm Mother)
    [20642] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_arachnid_leap.dds'; name = Abilities.Skill_Arachnid_Leap }; -- Poisoned Fang (Swarm Mother)
    [18559] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_spawn_hatchlings.dds'; name = Abilities.Skill_Spawn_Hatchlings }; -- Spawn Broodling (Swarm Mother)
    [18690] = { icon = '/esoui/art/icons/achievement_fightersguilddailies_003.dds'; tooltip = Tooltips.Skill_Fighters_Boon; stack = 0 }; -- Fighter's Boon
    [18363] = { icon = '/esoui/art/icons/ability_dragonknight_005.dds'; name = Abilities.Skill_Fiery_Grip }; -- Fiery Reach (Big Rabbu)
    [18365] = { icon = '/esoui/art/icons/ability_dragonknight_005.dds'; name = Abilities.Skill_Fiery_Grip; tooltip = Tooltips.Generic_Stun }; -- Grapple (Big Rabbu)
    [18076] = { icon = 'LuiExtended/media/icons/abilities/ability_spiderdaedra_strike.dds' }; -- Impale (The Whisperer)
    [18111] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_arachnophobia.dds' }; -- Arachnophobia (The Whisperer)
    [18116] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_arachnophobia.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Arachnophobia (The Whisperer)
    [18078] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_web_blast.dds' }; -- Web Blast (The Whisperer)
    [46218] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_web_blast.dds'; name = Abilities.Skill_Web_Blast }; -- Fire Backlash (The Whisperer)
    [46219] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_web_blast.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Web Blast (The Whisperer)
    [35572] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grappling_web.dds' }; -- Grappling Web (The Whisperer)
    [35575] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grappling_web.dds'; tooltip = Tooltips.Generic_Stun }; -- Grappling Web (The Whisperer)
    [18058] = { icon = '/esoui/art/icons/achievement_ic_021.dds' }; -- Daedric Explosion (The Whisperer)
    [22033] = { icon = '/esoui/art/icons/achievement_ic_021.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Daedric Explosion (The Whisperer)
    [22032] = { icon = '/esoui/art/icons/achievement_ic_021.dds'; name = Abilities.Skill_Daedric_Explosion }; -- Daedric Explosion Knockback (The Whisperer)

    -- Spindleclutch II
    [28749] = { hide = true }; -- Intro (Blood Spawn)
    [27922] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }; -- Claw (Blood Spawn)
    [27923] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }; -- Claw (Blood Spawn)
    [28093] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_vicious_smash.dds' }; -- Vicious Smash (Blood Spawn)
    [47139] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_vicious_smash.dds'; name = Abilities.Skill_Vicious_Smash }; -- Knockdown (Blood Spawn)
    [47140] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_vicious_smash.dds'; name = Abilities.Skill_Vicious_Smash; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Knockdown (Blood Spawn)
    [47145] = { hide = true }; -- Has Charged (Blood Spawn)
    [27995] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds'; name = Abilities.Skill_Quake }; -- Cave-In (Blood Spawn)
    [28006] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds'; name = Abilities.Skill_Quake }; -- Cave In (Blood Spawn)
    [47198] = { icon = '/esoui/art/icons/ability_wrothgar_avalanche.dds'; name = Abilities.Skill_Cave_In; hide = true }; -- Falling Rocks (Cave In)
    [47331] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds'; name = Abilities.Skill_Quake }; -- Cave-In (Blood Spawn)
    [47332] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds'; name = Abilities.Skill_Quake }; -- Cave In (Blood Spawn)
    [31611] = { icon = '/esoui/art/icons/ability_wrothgar_avalanche.dds'; name = Abilities.Skill_Cave_In }; -- Crushing Rocks (Cave In)
    [87373] = { icon = '/esoui/art/icons/ability_wrothgar_avalanche.dds' }; -- Cave In (Collapsed Ceiling)
    [28438] = { icon = '/esoui/art/icons/achievement_update16_033.dds'; name = Abilities.Skill_Praxins_Nightmare }; -- Dummy (Praxin Douare)
    [47122] = { hide = true }; -- Praxin's Nightmare (Praxin Douare)
    [18036] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grappling_web.dds' }; -- Grappling Web (The Whisperer Nightmare)
    [18054] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds'; name = Abilities.Skill_Grappling_Web; unbreakable = 1; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 50 }; -- Entangled (The Whisperer Nightmare)
    [18051] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grappling_web.dds'; name = Abilities.Skill_Grappling_Web; tooltip = Tooltips.Generic_Stun }; -- Encased (The Whisperer Nightmare)
    [18039] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_grappling_web.dds' }; -- Grappling Web (The Whisperer Nightmare)
    [27750] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_distorted_bolt.dds' }; -- Distorted Bolt (Praxin Douare)
    [27965] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_despair.dds' }; -- Despair (Praxin Douare)
    [27979] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_despair.dds' }; -- Despair (Praxin Douare)
    [27741] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_enervating_seal.dds' }; -- Enervating Seal (Praxin Douare)
    [27748] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_enervating_seal.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; tooltip = Tooltips.Skill_Enervating_Seal }; -- Enervating Seal (Praxin Douare)
    [27743] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_enervating_seal.dds' }; -- Enervating Seal (Praxin Douare)
    [27744] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_enervating_seal.dds' }; -- Enervating Seal (Praxin Douare)
    [27742] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_enervating_seal.dds' }; -- Enervating Seal (Praxin Douare)
    [27703] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_harrowing_ring.dds' }; -- Harrowing Ring (Praxin Douare)
    [61443] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_harrowing_ring.dds'; hide = true }; -- Harrowing Ring (Praxin Douare)
    [61442] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_harrowing_ring.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Harrowing Ring (Praxin Douare)
    [28406] = { hide = true }; -- Dummy (Blood Essence)
    [61445] = { hide = true }; -- Dummy (Blood Essence)
    [73016] = { hide = true }; -- Dummy (Blood Essence)
    [86418] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_harrowing_ring.dds' }; -- Harrowing Ring (Blood Essence)
    [27655] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_harrowing_ring.dds' }; -- Harrowing Ring (Blood Essence)
    [43176] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_harrowing_ring.dds'; name = Abilities.Skill_Harrowing_Ring; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Shocked (Blood Essence)
    [61444] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_harrowing_ring.dds'; name = Abilities.Skill_Harrowing_Ring; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Shocked (Blood Essence)
    [43173] = { hide = true }; -- DUN_SCH_RingBurst (Blood Essence)
    [27435] = { tooltip = Tooltips.Generic_Enrage_No_Dur; tooltipValue2 = 40 }; -- Monstrous Growth (Flesh Atronach)
    [27437] = { tooltip = Tooltips.Generic_Enrage_No_Dur; tooltipValue2 = 125 }; -- Monstrous Growth (Flesh Atronach)
    [27600] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_pool.dds'; hide = true }; -- Blood Pool (Urvan Veleth)
    [27603] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_pool.dds'; groundLabel = true; tooltip = Tooltips.Skill_Blood_Pool; tooltipValue2 = 1 }; -- Blood Pool (Urvan Veleth)
    [32100] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds'; name = Abilities.Skill_Wracking_Pain; tooltip = Tooltips.Generic_Stun; unbreakable = 1 }; -- Arachnophobia (Vorenor Winterbourne)
    [28632] = { hide = true }; -- Intro (Vorenor Winterbourne)
    [27660] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_drain.dds' }; -- Blood Drain (Vorenor Winterbourne)
    [27905] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_pool.dds'; hide = true }; -- Blood Pool (Vorenor Winterbourne)
    [27906] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_pool.dds'; groundLabel = true; tooltip = Tooltips.Skill_Blood_Pool; tooltipValue2 = 1.5 }; -- Blood Pool (Vorenor Winterbourne)
    [27897] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_open_wounds.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Magic; tooltipValue2 = 2; stack = 0 }; -- Open Wounds (Vorenor Winterbourne)
    [27898] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_open_wounds.dds' }; -- Open Wounds (Vorenor Winterbourne)
    [27791] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_frenzy.dds' }; -- Blood Frenzy (Vorenor Winterbourne)
    [27799] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_frenzy.dds' }; -- Blood Frenzy (Vorenor Winterbourne)
    [31672] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }; -- Thrall Feast (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [34846] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_primal_sweep.dds' }; -- Primal Sweep (Slimecraw)
    [34847] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_primal_sweep.dds' }; -- Primal Sweep (Slimecraw)
    [34848] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_primal_sweep.dds'; tooltip = Tooltips.Generic_Knockback }; -- Primal Sweep (Slimecraw)
    [34849] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_primal_sweep.dds' }; -- Primal Sweep (Slimecraw)
    [14946] = { hide = true }; -- Tormented summoning (WRBoss3 Invisible Man)
    [11712] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_flare.dds' }; -- Death's Embrace (Investigator Garron)
    [9441] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds' }; -- Dark Lance (Investigator Garron)
    [48933] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds'; name = Abilities.Skill_Dark_Lance; hide = true }; -- Backlash (Investigator Garron)
    [48932] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_spear.dds'; name = Abilities.Skill_Dark_Lance; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Backlash (Investigator Garron)
    [25593] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_essence.dds' }; -- Necrotic Essence (Investigator Garron)
    [25586] = { hide = true }; -- Seeking Orb (Necrotic Orb)
    [25591] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_essence.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1 }; -- Necrotic Essence (Necrotic Orb)
    [25616] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_essence.dds' }; -- Necrotic Explosion (Necrotic Orb)
    [9740] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_restless_souls.dds'; name = Abilities.Skill_Summon_Restless_Souls; hide = true }; -- Summon Restless Souls (Investigator Garron)
    [9481] = { icon = '/esoui/art/icons/ability_mage_003.dds'; tooltip = Tooltips.Skill_Growing_Torment }; -- Growing Torment (Restless Soul)
    [12247] = { hide = true }; -- Terrifying Roar (Uulgarg the Hungry)
    [58528] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_intimidating_roar.dds'; tooltip = Tooltips.Generic_Fear }; -- Terrifying Roar (Uulgarg the Hungry)
    [14969] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Slash (Varaine Pellingare)
    [25548] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds'; name = Abilities.Skill_Crushing_Blow }; -- Smite (Varaine Pellingare)
    [25550] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds'; name = Abilities.Skill_Crushing_Blow; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Varaine Pellingare)
    [25549] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds'; name = Abilities.Skill_Crushing_Blow; hide = true }; -- Fire Backlash (Varaine Pellingare)
    [9648] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds' }; -- Spinning Cleave (Varaine Pellingare)
    [9651] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Spinning Cleave (Varaine Pellingare)
    [36435] = { icon = '/esoui/art/icons/ability_warrior_004.dds' }; -- Tidal Slash (Varaine Pellingare)
    [25531] = { icon = '/esoui/art/icons/ability_warrior_004.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Tidal Slash (Varaine Pellingare)
    [25530] = { icon = '/esoui/art/icons/ability_warrior_004.dds' }; -- Tidal Slash (Varaine Pellingare)
    [36442] = { icon = '/esoui/art/icons/ability_warrior_004.dds' }; -- Tidal Slash (Varaine Pellingare)
    [36444] = { icon = '/esoui/art/icons/ability_warrior_004.dds' }; -- Tidal Slash (Varaine Pellingare)
    [9656] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_poisoned_blade.dds'; hide = true }; -- Poisoned Blade (Varaine Pellingare)
    [11739] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds'; name = Abilities.Skill_Quick_Strike }; -- Strike (Allene Pellingare)
    [11752] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_measured_uppercut.dds'; name = Abilities.Skill_Measured_Uppercut }; -- Penetrating Daggers (Allene Pellingare)
    [35051] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_measured_uppercut.dds'; name = Abilities.Skill_Measured_Uppercut; tooltip = Tooltips.Generic_Knockback; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Penetrating Daggers (Allene Pellingare)
    [35050] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_measured_uppercut.dds'; name = Abilities.Skill_Measured_Uppercut; hide = true }; -- Penetrating Daggers (Allene Pellingare)
    [11747] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_razor_flourish.dds' }; -- Razor Flourish
    [34991] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35006] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_hallucinogenic_fumes.dds' }; -- Hallucinogenic Fumes (Allene Pellingare)
    [34992] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35012] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [34994] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [34995] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [73034] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35015] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35021] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_hallucinogenic_fumes.dds'; name = Abilities.Skill_Hallucinogenic_Fumes }; -- Mind-Bending Mist (Allene Pellingare)
    [35025] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35320] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35017] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35022] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [73035] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35028] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35041] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_hallucinogenic_fumes.dds'; name = Abilities.Skill_Hallucinogenic_Fumes }; -- Mind-Bending Mist (Allene Pellingare)
    [35033] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35322] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35029] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35030] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [73036] = { hide = true }; -- Mind-Bending Mist (Allene Pellingare)
    [35107] = { icon = '/esoui/art/icons/ability_rogue_053.dds' }; -- Ghost Burst (Allene Pellingare)

    -- Wayrest Sewers II
    [47257] = { hide = true }; -- Rend Soul (Altar Dummy)
    [36412] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_shockwave.dds' }; -- Ethereal Bolt (Malubeth the Scourger)
    [36613] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_scourging_spark.dds' }; -- Scourging Spark (Malubeth the Scourger)
    [36625] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_scourging_spark.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1.5; groundLabel = true }; -- Scourging Spark (Malubeth the Scourger)
    [36433] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_rend_soul.dds' }; -- Rend Soul (Malubeth the Scourger)
    [36431] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_rend_soul.dds'; unbreakable = 1; tooltip = Tooltips.Skill_Rend_Soul }; -- Rend Soul (Malubeth the Scourger)
    [47267] = { hide = true }; -- Rend Soul2 (Altar Dummy)
    [36533] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_oblivion_purple.dds' }; -- Rend Soul (Malubeth the Scourger)
    [36951] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_voice_to_wake_the_dead.dds' }; -- Voice to Wake the Dead (Skull Reaper)
    [36966] = { hide = true }; -- Channel Energy (Risen Dead)
    [48773] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds'; name = Abilities.Skill_Necromantic_Implosion }; -- Necromantic Burst (Risen Dead)
    [36870] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_scorching_flames.dds'; tooltip = Tooltips.Skill_Scorching_Flames }; -- Scorching Flames (Uulgarg the Risen)
    [36869] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_gtaoe_fire_damage.dds'; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1.5; groundLabel = true }; -- Scorching Flames (Uulgarg the Risen)
    [36792] = { hide = true }; -- Yahyif runs to Doom (Yahyif)
    [36709] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_bolt.dds' }; -- Necrotic Bolt (Garron the Returned)
    [36904] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_necrotic_barrage.dds' }; -- Necrotic Barrage (Garron the Returned)
    [36944] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_necrotic_barrage.dds' }; -- Necrotic Barrage (Garron the Returned)
    [36761] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds'; name = Abilities.Skill_Soul_Rupture; hide = true }; -- Summon Minion (Garron the Returned)
    [36776] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds' }; -- Necrotic Spike (Garron the Returned)
    [36779] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds'; name = Abilities.Skill_Soul_Rupture }; -- Necrotic Burst (Garron the Returned)
    [36782] = { hide = true }; -- Transform (Escaped Soul)
    [36780] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_restless_souls.dds'; name = Abilities.Skill_Escaped_Souls; hide = true }; -- Summon Minion (Escaped Soul)
    [36838] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_teleport.dds' }; -- Deceptive Teleport (Garron the Returned)
    [36873] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_consume_life.dds' }; -- Consume Life (Garron the Returned)
    [36878] = { icon = 'LuiExtended/media/icons/abilities/ability_necromancer_consume_life.dds' }; -- Consume Life (Garron the Returned)
    [36895] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds' }; -- Haunting Spectre (The Forgotten One)
    [36897] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds' }; -- Haunting Spectre (The Forgotten One)
    [36900] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Lower_Max_HP; tooltipValue2 = 25 }; -- Haunting Spectre (The Forgotten One)
    [47007] = { hide = true }; -- Nocom (Allene & Varaine Pellingare)
    [36413] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds' }; -- Quick Strike (Varaine Pellingare)
    [49159] = { icon = '/esoui/art/icons/ability_warrior_004.dds'; name = Abilities.Skill_Overhead_Smash }; -- Cone of Rot (Varaine Pellingare)
    [49160] = { icon = '/esoui/art/icons/ability_warrior_004.dds'; name = Abilities.Skill_Overhead_Smash }; -- Cone of Rot (Varaine Pellingare)
    [36534] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds' }; -- Spinning Cleave (Varaine Pellingare)
    [36535] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Spinning Cleave (Varaine Pellingare)
    [36396] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds'; name = Abilities.Skill_Crushing_Blow }; -- Bludgeon (Varaine Pellingare)
    [36397] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds'; name = Abilities.Skill_Crushing_Blow }; -- Bludgeon (Varaine Pellingare)
    [36398] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_heavy.dds'; name = Abilities.Skill_Crushing_Blow; tooltip = Tooltips.Generic_Knockback; unbreakable = 1 }; -- Bludgeon (Varaine Pellingare)
    [36378] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_quick_shot.dds'; name = Abilities.Skill_Quick_Shot }; -- Quick Draw (Allene Pellingare)
    [35838] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_necrotic_arrow.dds' }; -- Necrotic Arrow (Allene Pellingare)
    [35839] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_necrotic_arrow.dds'; tooltip = Tooltips.Generic_Magic; tooltipValue2 = 1.5; unbreakable = 1 }; -- Necrotic Arrow (Allene Pellingare)
    [36537] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shield_sibling.dds' }; -- Shield Sibling (Allene & Varaine Pellingare)
    [49060] = { hide = true }; -- PrisonCast (Allene Pellingare)
    [49074] = { hide = true }; -- PrisonCast (Allene Pellingare)
    [49052] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_pellingare_prison.dds'; tooltip = Tooltips.Generic_Stun; unbreakable = 1; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Pellingare Prison (Allene Pellingare)
    [49053] = { hide = true; icon = 'LuiExtended/media/icons/abilities/ability_spell_hallucinogenic_fumes.dds'; name = Abilities.Skill_Hallucinogenic_Fumes }; -- Toxic Fumes (Allene Pellingare)

    -- Crypt of Hearts I
    [39126] = { hide = true }; -- Soul Prison (Shard of Alanwe)
    [22341] = { icon = '/esoui/art/icons/ability_warrior_025.dds'; tooltip = Tooltips.Generic_Enrage; tooltipValue2 = 5 }; -- Frenzy (Zombie Stalker)
    [39827] = { hide = true }; -- Capture (Zombie)
    [22666] = { hide = true }; -- Dead (Zombie)
    [22713] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_bolt.dds' }; -- Phantasmal Bolt (Archmaster Siniel)
    [22714] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_ritual.dds' }; -- Necrotic Ritual (Archmaster Siniel) -- TODO: BETTER ICON
    [22716] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_ritual.dds'; tooltip = Tooltips.Generic_AOE_Magic; tooltipValue2 = 1.5; groundLabel = true }; -- Necrotic Ritual (Archmaster Siniel) -- TODO: BETTER ICON
    [22768] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds' }; -- Induce Horror (Archmaster Siniel)
    [22770] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds'; tooltip = Tooltips.Generic_Fear }; -- Induce Horror (Archmaster Siniel)
    [35979] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_haunting_spectre.dds' }; -- Induce Horror (Archmaster Siniel)
    [46581] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_step.dds'; hide = true }; -- Daedric Step (Archmaster Siniel)
    [46580] = { hide = true }; -- Daedric Step (Archmaster Siniel)
    [46579] = { hide = true }; -- Daedric Step (Archmaster Siniel)
    [46585] = { hide = true }; -- Wall of Souls (Archmaster Siniel)
    [22668] = { hide = true }; -- Awaken Dead (Archmaster Siniel)
    [22779] = { hide = true }; -- Corpse Shield (Archmaster Siniel)
    [22808] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_corpse_shield.dds'; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Corpse Shield (Archmaster Siniel)
    [22787] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_explosion_beam.dds'; hide = true }; -- Corpse Explosion (Archmaster Siniel)
    [22806] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_explosion_beam.dds' }; -- Corpse Explosion (Archmaster Siniel)
    [22807] = { hide = true }; -- Corpse Explosion (Archmaster Siniel)
    [22702] = { hide = true }; -- Get Up (Zombie)
    [22704] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }; -- Swipe (Zombie)
    [22488] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_strike.dds' }; -- Backhand (Death's Leviathan)
    [111957] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_trample.dds' }; -- Trample (Death's Leviathan)
    [46953] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_trample.dds' }; -- Trample (Death's Leviathan)
    [46952] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_trample.dds'; name = Abilities.Skill_Trample; tooltip = Tooltips.Generic_Knockdown }; -- Trample (Death's Leviathan)
    [22527] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam.dds' }; -- Paralyzing Slam (Death's Leviathan)
    [22535] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam.dds' }; -- Paralyzing Slam (Death's Leviathan)
    [46680] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_immolate.dds'; name = Abilities.Skill_Immolate; tooltip = Tooltips.Skill_Immolate_Colossus }; -- Immolate Colossus (Death's Leviathan)
    [46950] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_fire.dds'; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 0.5; groundLabel = true }; -- Fire Trail (Death's Leviathan)
    [22576] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds' }; -- Paralyzing Slam (Death's Leviathan)
    [23685] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds' }; -- Paralyzing Slam (Death's Leviathan)
    [46674] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds'; hide = true }; -- Paralyzing Slam (Death's Leviathan)
    [46673] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds'; tooltip = Tooltips.Generic_Knockback; unbreakable = 1; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Paralyzing Slam (Death's Leviathan)
    [46677] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds'; hide = true }; -- Paralyzing Slam (Death's Leviathan)
    [46675] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds'; tooltip = Tooltips.Generic_Knockback; unbreakable = 1; type = BUFF_EFFECT_TYPE_DEBUFF }; -- Paralyzing Slam (Death's Leviathan)
    [22491] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_strike_fire.dds'; tooltip = Tooltips.Generic_Burn; tooltipValue2 = 1 }; -- Ignited (Death's Leviathan)
    [39286] = { hide = true }; -- Tormenting Blade (Rulanir)

    -- Ilambris-Athor
    [22301] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_xivilai_shock.dds' }; -- Cleaving Swing (Ilambris-Athor)
    [22450] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_electric_prison.dds'; name = Abilities.Skill_Electric_Prison; hide = true }; -- Summon Lightning Rod (Ilambris-Athor)
    [22431] = { hide = true }; -- Lightning Rod (Lightning Rod)
    [22432] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_electric_prison.dds'; tooltip = Tooltips.Generic_AOE_Shock; tooltipValue2 = 1.5; groundLabel = true }; -- Electric Prison (Ilambris-Athor)
    [22338] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_xivilai_heavy.dds'; name = Abilities.Skill_Overwhelming_Blow }; -- Axe Strike (Ilambris-Athor)
    [46691] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_xivilai_heavy.dds'; name = Abilities.Skill_Overwhelming_Blow }; -- Fire Backlash (Ilambris-Athor)
    [46692] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_xivilai_heavy.dds'; name = Abilities.Skill_Overwhelming_Blow; tooltip = Tooltips.Generic_Knockback; unbreakable = 1 }; -- CON_Knockback&Knockdown (Ilambris-Athor)
    [32425] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_empowerment.dds'; tooltip = Tooltips.Skill_Lightning_Empowerment }; -- Lightning Empowerment (Ilambris-Athor)
    [22456] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_empowerment.dds'; tooltip = Tooltips.Skill_Lightning_Empowerment_Enrage }; -- Lightning Omnipotence (Ilambris-Athor)
    [33299] = { hide = true }; -- Center Picker (Generic Invisible Target)
    [33297] = { hide = true }; -- Center of Room (Generic Invisible Target)
    [22397] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_shock.dds'; hide = true }; -- Call Lightning (Ilambris-Athor)
    [22398] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_shock.dds' }; -- Call Lightning (Ilambris-Athor)
    [22401] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_shock.dds' }; -- Call Lightning (Ilambris-Athor)
    [22403] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_shock.dds' }; -- Call Lightning (Ilambris-Athor)

    -- Ilambris-Zaven
    [22302] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fiery_surge.dds'; hide = true }; -- Fire Bolt (Ilambris-Zaven)
    [22342] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rolling_fire.dds' }; -- Rolling Fire (Ilambris-Zaven)
    [22344] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rolling_fire.dds' }; -- Rolling Fire (Ilambris-Zaven)
    [22390] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm }; -- Pyrocasm (Ilambris-Zaven)
    [44087] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm }; -- Fire Backlash (Ilambris-Zaven)
    [44088] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_pyroclasm.dds'; name = Abilities.Skill_Pyroclasm; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Ilambris-Zaven)
    [32424] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_incensed.dds'; tooltip = Tooltips.Skill_Incensed }; -- Incensed (Ilambris-Zaven)
    [22457] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_incensed.dds'; tooltip = Tooltips.Skill_Incensed_Enrage }; -- Emit Flames (Ilambris-Zaven)
    [22383] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_fire.dds'; hide = true }; -- Rain Fire (Ilambris-Zaven)
    [22388] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_fire.dds'; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1.5; groundLabel = true }; -- Rain Fire (Ilambris-Zaven)

    -- Crypt of Hearts II

    -- Trash
    [52270] = { hide = true }; -- VDUN_CoH_Alanwe Knockback
    [51746] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_death_spider.dds'; name = Abilities.Skill_Summon_Death_Spider; tooltip = Tooltips.Skill_Summon_Death_Spider }; -- Voice to Wake the Spiders (Spiderkith Broodnurse)
    [51753] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_death_spider.dds'; name = Abilities.Skill_Summon_Death_Spider; tooltip = Tooltips.Skill_Summon_Death_Spider }; -- Reanimate Skeleton (Spiderkith Broodnurse)
    [51751] = { hide = true }; -- VO Sound (Spiderkith Broodnurse)
    [52040] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_summon_flesh_atronach.dds' }; -- Summon Atronach (Ibelgast's Broodnurse)
    [52160] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_summon_flesh_atronach.dds'; name = Abilities.Skill_Summon_Atronach }; -- Flesh Atronach Rises (Ibelgast's Broodnurse)
    [53285] = { icon = '/esoui/art/icons/achievement_update11_dungeons_025.dds'; name = Abilities.Skill_Summon_Spiderkith }; -- Summon (Ogrim)

    -- Ruzozuzalpamaz
    [52954] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ranged_slime.dds' }; -- Spit (Ruzozuzalpamaz)
    [51882] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_guardian_storm.dds'; hide = true }; -- Ruzozuzalpamaz (Creeping Storm)
    [51881] = { hide = true }; -- Creeping Storm (Creeping Storm)
    [51895] = { hide = true }; -- Creeping Storm (Creeping Storm)
    [51883] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_guardian_storm.dds'; hide = true; groundLabel = true; tooltip = Tooltips.Generic_AOE_Shock_Stacking; tooltipValue2 = 1; tooltipValue3 = 25; stack = 1; stackAdd = 1 }; -- Creeping Storm (Creeping Storm)
    [52017] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_onslaught.dds' }; -- Lightning Onslaught (Ruzozuzalpamaz)
    [52018] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_lightning_onslaught.dds' }; -- Lightning Onslaught (Ruzozuzalpamaz)
    [53779] = { icon = 'LuiExtended/media/icons/abilities/ability_summon_spawn_hatchlings.dds'; name = Abilities.Skill_Spider_Swarm }; -- Webdrop (Ruzozuzalpamaz)
    [51381] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_web_wrap.dds'; hide = true }; -- Chattering Web (Ruzozuzalpamaz)
    [51386] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_web_wrap.dds'; name = Abilities.Skill_Chattering_Web; tooltip = Tooltips.Skill_Chattering_Web; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Web Wrap (Ruzozuzalpamaz)
    [51385] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_spider_bites.dds' }; -- Spider Bites (Ruzozuzalpamaz)
    [51389] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_free_ally.dds' }; -- Free Ally (Ruzozuzalpamaz)
    [56566] = { hide = true }; -- VDUN_CoH_Boss1 RemoveWeb (Ruzozuzalpamaz)
    [56567] = { hide = true }; -- Remove Web (Ruzozuzalpamaz)
    [54622] = { icon = '/esoui/art/icons/ability_2handed_001.dds' }; -- Uppercut (Chamber Guardian)
    [54621] = { icon = '/esoui/art/icons/ability_2handed_001.dds'; name = Abilities.Skill_Uppercut; tooltip = Tooltips.Generic_Knockback }; -- Uppercut Stun (Chamber Guardian)
    [51719] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_consuming_horror.dds' }; -- Consuming Horror (Chamber Guardian)
    [51722] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_consuming_horror.dds'; tooltip = Tooltips.Generic_Fear }; -- Consuming Horror (Chamber Guardian)
    [51721] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_consuming_horror.dds' }; -- Consuming Horror (Chamber Guardian)
    [51728] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_reanimate_skeletons.dds'; name = Abilities.Skill_Reanimate_Skeletons; hide = true }; -- Consuming Horror (Chamber Guardian)

    -- Trash
    [52298] = { hide = true }; -- Skeletons Emerge (Spiderkith Broodnurse)

    -- Ilambris Amalgam
    [52064] = { hide = true }; -- Untargetdummy (Ilambris-Athor)
    [52060] = { hide = true }; -- Dummy (Ilambris-Athor)
    [52062] = { hide = true }; -- dummy (Ilambris-Athor)
    [52071] = { hide = true }; -- Untargetdummy (Ilambris-Zaven)
    [52067] = { hide = true }; -- Dummy (Ilambris-Zaven)
    [52069] = { hide = true }; -- dummy (Ilambris-Zaven)
    [52167] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_shock_stomp.dds'; name = Abilities.Skill_Shock_Stomp }; -- Shock Form (Ilambris Amalgam)
    [53599] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_shock_stomp.dds' }; -- Shock Stomp (Ilambris Amalgam)
    [53598] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_shock_stomp.dds'; name = Abilities.Skill_Shock_Stomp; unbreakable = 1; tooltip = Tooltips.Generic_Knockdown }; -- CON_Knockback&Knockdown (Ilambris Amalgam)
    [53600] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_shock_form.dds'; name = Abilities.Skill_Shock_Form; hide = true; tooltip = Tooltips.Skill_Shock_Form }; -- Summon Shock Skeleton (Ilambris Amalgam)
    [53601] = { hide = true }; -- Summon Shock Skeleton (Ilambris Amalgam)
    [52278] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_shock.dds'; hide = true }; -- Call Lightning (Ilambris Amalgam)
    [52279] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_shock.dds' }; -- Call Lightning (Ilambris Amalgam)
    [53475] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_strike.dds' }; -- Strike (Ilambris Amalgam)
    [52269] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shock_torrent.dds'; name = Abilities.Skill_Split_Bolt }; -- Bone Shock (Ilambris Amalgam)
    [52491] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_thunder_fist.dds' }; -- Thunder Fist (Ilambris Amalgam)
    [52492] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_thunder_fist.dds' }; -- Thunder Fist (Ilambris Amalgam)
    [53403] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger; hide = true }; -- Thunder Fist (Ilambris Amalgam)
    [52166] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds'; name = Abilities.Skill_Fire_Stomp }; -- Fire Form (Ilambris Amalgam)
    [53592] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds'; name = Abilities.Skill_Fire_Stomp }; -- Pyrocasm Stomp (Ilambris Amalgam)
    [53591] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_paralyzing_slam_fire.dds'; name = Abilities.Skill_Fire_Stomp; unbreakable = 1; tooltip = Tooltips.Generic_Knockdown }; -- CON_Knockback&Knockdown (Ilambris Amalgam)
    [53593] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_immolate.dds'; name = Abilities.Skill_Fire_Form; hide = true; tooltip = Tooltips.Skill_Fire_Form }; -- Summon Flame Skeleton (Ilambris Amalgam)
    [53594] = { hide = true }; -- Summon Flame Skeleton (Ilambris Amalgam)
    [52266] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fire_torrent.dds'; name = Abilities.Skill_Split_Flare }; -- Bone Flare (Ilambris Amalgam)
    [52285] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_fire.dds'; hide = true }; -- Rain Fire (Ilambris Amalgam)
    [52286] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_fire.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1.2 }; -- Rain Fire (Ilambris Amalgam)
    [53495] = { hide = true }; -- Fiery Explosion (Ilambris Amalgam)
    [53497] = { hide = true }; -- VDUN_COH_B2 Telegraph (Ilambris Amalgam)
    [53426] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_fiery_explosion.dds' }; -- Fiery Explosion (Ilambris Amalgam)
    [53428] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_fiery_explosion.dds'; tooltip = Tooltips.Generic_Knockback }; -- Fiery Explosion (Ilambris Amalgam)
    [53427] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_fiery_explosion.dds' }; -- Fiery Explosion (Ilambris Amalgam)
    [52334] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_final_storm.dds' }; -- Final Storm (Ilambris Amalgam)
    [52335] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_fire.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1.2 }; -- Rain Fire (Ilambris Amalgam)
    [52339] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ilambris_shock.dds' }; -- Call Lightning (Ilambris Amalgam)
    [52585] = { hide = true }; -- Skeletons Emerge (Mezeluth)
    [52586] = { hide = true }; -- Skeletons Emerge (Mezeluth)
    [52590] = { hide = true }; -- Skeleton Stun Targetable (Mezeluth)
    [55954] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_flare_large.dds' }; -- Flare (Mezeluth)
    [51090] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_void_grip.dds'; name = Abilities.Skill_Void_Grip }; -- Rise and Fall (Mezeluth)
    [51111] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_void_grip.dds'; name = Abilities.Skill_Void_Grip; tooltip = Tooltips.Skill_Void_Grip; unbreakable = 1 }; -- Rise and Fall (Mezeluth)
    [55961] = { hide = true }; -- VDUN_COH_Dark Betrayal
    [55962] = { hide = true }; -- VDUN_COH_Dark Betrayal
    [55960] = { hide = true }; -- VDUN_COH_Dark Betrayal
    [53200] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fulminating_void.dds'; name = Abilities.Skill_Fulminating_Void; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Cold_Strike; duration = 0.5 }; -- Fulminating Void (Mezeluth)
    [51799] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fulminating_void.dds' }; -- Fulminating Void (Mezeluth)
    [51824] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fulminating_void.dds'; name = Abilities.Skill_Fulminating_Void; unbreakable = 1; tooltip = Tooltips.Generic_Knockdown }; -- Fulminating Void (Mezeluth)
    [53349] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fulminating_void.dds' }; -- Fulminating Void (Mezeluth)
    [51804] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_fulminating_void.dds' }; -- Fulminating Void (Mezeluth)
    [55947] = { hide = true }; -- Rise and Fall Far (Mezeluth)
    [17204] = { hide = true }; -- Goblin Path (Alanwe)
    [52613] = { hide = true }; -- Stop Healing (Ebony Blade)
    [52610] = { hide = true }; -- Soul Lust (Ebony Blade)
    [53097] = { hide = true }; -- Blade Obj React (Ebony Blade)
    [52611] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_soul_lust.dds' }; -- Soul Lust (Ebony Blade)
    [52620] = { hide = true }; -- Soul Lust (Ebony Blade)
    [52606] = { hide = true }; -- Binding (Ebony Blade)
    [52618] = { hide = true }; -- Binding (Ebony Blade)
    [51877] = { hide = true }; -- Necrotic Speed (Nerien'eth)
    [51792] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_skull_volley.dds'; name = Abilities.Skill_Skull_Volley }; -- Necrotic Spear (Nerien'eth)
    [51953] = { hide = true }; -- Skull Swarm (Nerien'eth)
    [52080] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_swarm.dds'; hide = true }; -- Necrotic Swarm (Nerien'eth)
    [52084] = { hide = true }; -- Necrotic Swarm (Nerien'eth)
    [52081] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_entropic_bolt.dds'; hide = true }; -- Necrotic Swarm (Nerien'eth)
    [52082] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1.5 }; -- Cursed Ground (Nerien'eth)
    [52093] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds' }; -- Soul Surge (Nerien'eth)
    [51539] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_blast.dds' }; -- Necrotic Blast (Nerien'eth)
    [51542] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_blast.dds'; unbreakable = 1 }; -- Necrotic Blast (Nerien'eth)
    [51541] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_blast.dds'; tooltip = Tooltips.Generic_Knockback; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1 }; -- Necrotic Blast (Nerien'eth)
    [51545] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_blast.dds' }; -- Necrotic Blast (Nerien'eth)
    [52942] = { hide = true }; -- Necrotic Blast (Nerien'eth)
    [51543] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger; hide = true }; -- Necrotic Blast (Nerien'eth)
    [52935] = { hide = true }; -- Charged Skull (Nerien'eth)
    [51853] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_step.dds'; name = Abilities.Skill_Daedric_Step; hide = true }; -- Soul Pulse (Nerien'eth)
    [51864] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_necrotic_explosion.dds'; name = Abilities.Skill_Soul_Pulse }; -- Force Pulse (Nerien'eth)
    [51867] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Force Pulse (Nerien'eth)
    [51943] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_step.dds'; name = Abilities.Skill_Daedric_Step }; -- Soul Summon (Nerien'eth)
    [55054] = { hide = true }; -- Soul Sacrifice (Nerien'eth)
    [52856] = { hide = true }; -- Soul Sacrifice (Nerien'eth)
    [60632] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_summon.dds'; name = Abilities.Skill_Soul_Sacrifice; tooltip = Tooltips.Generic_Reduce_Damage_Taken; tooltipValue2 = 15 }; -- Shadow Cloak (Nerien'eth)
    [51886] = { hide = true }; -- Tainted Soul (Student / Wraith)
    [51936] = { hide = true }; -- Tainted Soul (Student / Wraith)
    [53122] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow_small.dds'; name = Abilities.Skill_Chilling_Bolt }; -- Ice Bolt (Wraith)
    [53123] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_ice_arrow_small.dds'; name = Abilities.Skill_Chilling_Bolt; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 25 }; -- Cold Strike (Wraith)
    [51878] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_cold_strike.dds' }; -- Cold Strike (Wraith)
    [51879] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_cold_strike.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Snare; tooltipValue2 = 25 }; -- Cold Strike (Wraith)
    [51880] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_cold_strike.dds'; name = Abilities.Skill_Cold_Strike }; -- Double Strike (Wraith)
    [52945] = { hide = true }; -- Clean Up (Player)
    [52635] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_step.dds'; name = Abilities.Skill_Daedric_Step }; -- Teleport (Nerien'eth)
    [52642] = { hide = true }; -- VDUN_CoH_Boss3 Take Blade (Nerien'eth)
    [52647] = { hide = true }; -- VDUN_CoH_Boss3 Take Blade (Nerien'eth)
    [52652] = { hide = true }; -- VDUN_CoH_Boss3 Take Blade (Nerien'eth)
    [60631] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_soul_lust.dds'; name = Abilities.Skill_Draw_the_Ebony_Blade; tooltip = Tooltips.Generic_Immunity }; -- Shadow Cloak (Nerien'eth)
    [52669] = { hide = true }; -- Damage Shield (Nerien'eth)
    [52990] = { hide = true }; -- VDUN_CoH_Boss3 Take Blade (Nerien'eth)
    [53161] = { hide = true }; -- VDUN_CoH_Boss3 Take Blade (Nerien'eth)
    [53173] = { hide = true }; -- Post Process (Nerien'eth)
    [52643] = { hide = true }; -- VDUN_CoH_Boss3 Take Blade (Nerien'eth)
    [53133] = { hide = true }; -- Soul Cage (Soul Cage)
    [53174] = { hide = true }; -- Post Process (Player)
    [52119] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_enervating_sheen.dds'; hide = true }; -- Enervating Sheen (Nerien'eth)
    [52872] = { hide = true }; -- Enervating Sheen (Nerien'eth)
    [52164] = { hide = true }; -- Enervating Sheen (Nerien'eth)
    [52165] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_enervating_sheen.dds' }; -- Enervating Sheen (Nerien'eth)
    [52120] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_enervating_sheen.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Enervating Sheen (Nerien'eth)
    [52126] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_daedric_step.dds'; name = Abilities.Skill_Daedric_Step; hide = true }; -- Teleport (Nerien'eth)
    [52132] = { hide = true }; -- Blood Lust (Nerien'eth)
    [52138] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_bloodlust.dds'; hide = true }; -- Blood Lust (Nerien'eth)
    [52143] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_bloodlust.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Blood_Lust }; -- Blood Lust (Nerien'eth)
    [52181] = { hide = true }; -- Remove Blood Lust (Nerien'eth)
    [52397] = { hide = true }; -- Tracker (Nerien'eth)
    [53761] = { hide = true }; -- Kneel Track (Nerien'eth)
    [52514] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_ebony_shield.dds'; name = Abilities.Skill_Ebony_Shield; tooltip = Tooltips.Generic_Damage_Shield_Duration }; -- Damage Shield (Nerien'eth)
    [52516] = { hide = true }; -- Damage Shield (Nerien'eth)
    [52517] = { hide = true }; -- Damage Shield (Nerien'eth)
    [53185] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_resist_necrosis.dds'; duration = 0; tooltip = Tooltips.Skill_Resist_Necrosis; forcedContainer = 'short' }; -- Resist Necrosis (Nerien'eth)
    [53258] = { hide = true }; -- Rage (Nerien'eth)
    [52513] = { hide = true }; -- Remove Blood Lust (Nerien'eth)
    [52512] = { hide = true }; -- Remove Blood Lust (Nerien'eth)
    [52687] = { hide = true }; -- Remove Blood Lust (Nerien'eth)
    [52142] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_blood_execution.dds'; hide = true }; -- Blood Execution (Nerien'eth)
    [52750] = { hide = true }; -- Remove Blood Lust (Nerien'eth)
    [59572] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_bloodlust.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Stun }; -- Blood Lust (Nerien'eth)
    [53157] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_cage.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Frost; tooltipValue2 = 1.5 }; -- Cursed Ground (Nerien'eth)
    [53152] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_soul_rupture.dds' }; -- Soul Surge (Nerien'eth)
    [51988] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_lethal_stab.dds'; hide = true }; -- Lethal Stab (Nerien'eth)
    [52412] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_lethal_stab.dds' }; -- Lethal Stab (Nerien'eth)
    [53442] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_lethal_stab.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Oblivion_Snare; tooltipValue2 = 1; tooltipValue3 = 80 }; -- Lethal Stab (Nerien'eth)
    [53446] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_lethal_stab.dds'; name = Abilities.Skill_Lethal_Stab }; -- Lethal Cut (Nerien'eth)
    [53181] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_keen_strike.dds' }; -- Keen Strike (Nerien'eth)
    [51993] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_heavy_slash.dds' }; -- Heavy Slash (Nerien'eth)
    [51994] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_heavy_slash.dds'; hide = true; unbreakable = 1 }; -- Heavy Slash (Nerien'eth)
    [51995] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_heavy_slash.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Heavy Slash (Nerien'eth)
    [51997] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_ebony_whirlwind.dds' }; -- Ebony Whirlwind (Nerien'eth)
    [53127] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_ebony_whirlwind.dds' }; -- Ebony Whirlwind (Nerien'eth)
    [52495] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_ebony_whirlwind.dds' }; -- Ebony Whirlwind (Nerien'eth)
    [52494] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger }; -- Ebony Whirlwind (Nerien'eth)
    [53134] = { icon = 'LuiExtended/media/icons/abilities/ability_ebony_blade_tortured_souls.dds'; groundLabel = true; tooltip = Tooltips.Generic_AOE_Oblivion; tooltipValue2 = 0.5 }; -- Tortured Souls (Nerien'eth)
    [54142] = { hide = true }; -- Soul Cages Opened (Soul Cage)

    -- Volenfell
    [25649] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_debilitating_roar.dds'; tooltip = Tooltips.Generic_Fear }; -- Debilitating Roar (Desert Lion)
    [25038] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_axe_xivilai_light.dds' }; -- Slash (Quintus Verres)
    [25029] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_twisted_steel.dds' }; -- Twisted Steel (Quintus Verres)
    [25030] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_twisted_steel.dds' }; -- Twisted Steel (Quintus Verres)
    [25142] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burning_field.dds'; name = Abilities.Skill_Burning_Ground }; -- Burning Ground (Quintus Verres)
    [25143] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_burning_field.dds'; tooltip = Tooltips.Generic_AOE_Fire; tooltipValue2 = 1.5; groundLabel = true }; -- Burning Ground (Quintus Verres)
    [25151] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_wraith_flame.dds'; name = Abilities.Skill_Flame_Wraith; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Fear }; -- Flame Wraith (Quintus Verres)
    [25149] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_firebolt.dds' }; -- Firebolt (Quintus Verres)
    [46313] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_leap.dds'; name = Abilities.Skill_Gargoyle_Leap; unbreakable = 1 }; -- Fire Backlash (Monstrous Gargoyle)
    [46314] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_leap.dds'; name = Abilities.Skill_Gargoyle_Leap; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Monstrous Gargoyle)
    [25218] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }; -- Double Swipe (Monstrous Gargoyle)
    [25219] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }; -- Double Swipe (Monstrous Gargoyle)
    [25227] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_petrifying_bellow.dds' }; -- Petrifying Bellow (Monstrous Gargoyle)
    [42930] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_petrifying_bellow.dds'; tooltip = Tooltips.Generic_Stun }; -- Petrifying Bellow (Monstrous Gargoyle)
    [25222] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds' }; -- Heaving Quake (Monstrous Gargoyle)
    [25223] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds' }; -- Heaving Quake (Monstrous Gargoyle)
    [24930] = { hide = true }; -- Tail Swipe (Tremorscale)
    [25672] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_flame_burst.dds' }; -- Flame Burst (Boilbite)
    [25674] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_flame_burst.dds' }; -- Flame Burst (Boilbite)
    [25675] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_flame_burst.dds' }; -- Flame Burst (Boilbite)
    [25676] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_flame_burst.dds' }; -- Flame Burst (Boilbite)
    [25677] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_flame_burst.dds' }; -- Flame Burst (Boilbite)
    [25655] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_explosive_bolt.dds'; hide = true }; -- Explosive Bolt (Unstable Construct)
    [25659] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_explosive_bolt.dds'; name = Abilities.Skill_Explosive_Bolt; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Explosive_Bolt }; -- Countdown (Unstable Construct)
    [25660] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_explosive_bolt_explosion.dds'; name = Abilities.Skill_Explosive_Bolt }; -- Explosion (Unstable Construct)
    [24857] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_crushing_chomp.dds' }; -- Bite (Tremorscale)
    [24744] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_hemorrhaging_tear.dds' }; -- Hemorrhaging Tear (Tremorscale)
    [24748] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_hemorrhaging_tear.dds'; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Skill_Hemorrhaging_Tear; tooltipValue2 = 2; stackMax = 3 }; -- Hemorrhaging Tear (Tremorscale)
    [24777] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }; -- Tail Swipe (Tremorscale)
    [24780] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds'; name = Abilities.Skill_Tail_Swipe; unbreakable = 1; hide = true }; -- Fire Backlash (Tremorscale)
    [24781] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds'; name = Abilities.Skill_Tail_Swipe; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Tremorscale)
    [29165] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds' }; -- Rupture (Tremorscale)
    [29164] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds' }; -- Rupture (Tremorscale)
    [29167] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds'; name = Abilities.Skill_Rupture }; -- Dummy (Tremorscale)
    [29163] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds'; name = Abilities.Skill_Rupture; unbreakable = 1 }; -- Staggering Roar (Tremorscale)
    [29166] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds'; name = Abilities.Skill_Rupture; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- CON_Knockback&Knockdown (Tremorscale)
    [25229] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_barrage_function.dds'; hide = true }; -- Barrage Function (The Guardian's Spark)
    [44113] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_barrage_function.dds' }; -- Barrage Function (The Guardian's Spark)
    [25262] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_hammer_strike.dds' }; -- Hammer Strike (The Guardian's Soul)
    [58657] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_hammer_strike.dds' }; -- Hammer Strike (The Guardian's Soul)
    [25263] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_decapitation.dds' }; -- Decapitation Function (The Guardian's Soul)
    [25265] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_decapitation.dds'; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Decapitation Function (The Guardian's Soul)
    [25264] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_decapitation.dds'; unbreakable = 1 }; -- Decapitation Function (The Guardian's Soul)

    -- temporary gap here just for ease of editing
    -- temporary gap here just for ease of editing
    -- temporary gap here just for ease of editing
    -- temporary gap here just for ease of editing
    -- temporary gap here just for ease of editing

    -- Frostvault
    [117286] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_bleed.dds'; hide = true }; -- Rending Bleed (Coldsnap Goblin - Shared)
    [117486] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_bleed.dds'; name = Abilities.Skill_Rending_Bleed; unbreakable = 1; tooltip = Tooltips.Generic_Bleed; tooltipValue2 = 2 }; -- Bleed (Coldsnap Goblin - Shared)
    [109574] = { name = Abilities.Skill_Rapid_Fire }; -- Fire Power (Coldsnap Harrier)
    [102945] = { icon = '/esoui/art/icons/ability_bow_006.dds'; name = Abilities.Skill_Rapid_Fire }; -- Firepower (Coldsnap Harrier)
    [117298] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_sword_1h_light.dds' }; -- Quick Strike (Coldsnap Snowstalker)
    [117352] = { icon = '/esoui/art/icons/ability_dualwield_005.dds' }; -- Whirlwind (Coldsnap Snowstalker)
    [117295] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }; -- Bite (Coldsnap Durzog)
    [117296] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rend.dds' }; -- Rend (Coldsnap Durzog)
    [117289] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_backhand.dds' }; -- Backhand (Coldsnap Ogre)
    [117290] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }; -- Shockwave (Coldsnap Ogre)
    [118491] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }; -- Shockwave (Coldsnap Ogre)
    [117292] = { tooltip = Tooltips.Generic_Off_Balance; unbreakable = 1 }; -- Off Balance (Coldsnap Ogre)
    [117291] = { hide = true; tooltip = Tooltips.Generic_Stagger }; -- Stagger (Coldsnap Ogre)
    [117287] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }; -- Crushing Blow (Coldsnap Ogre)
    [117288] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Crushing Blow (Coldsnap Ogre)
    [117316] = { icon = '/esoui/art/icons/ability_mage_009.dds'; hide = true }; -- Ice Arrow (Coldsnap Skysplitter)
    [117326] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds' }; -- Ice Comet (Coldsnap Skysplitter)
    [117327] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds' }; -- Ice Comet (Coldsnap Skysplitter)
    [117324] = { icon = '/esoui/art/icons/ability_mageguild_005_b.dds'; tooltip = Tooltips.Generic_Knockdown }; -- Ice Comet (Coldsnap Skysplitter)
    [117309] = { icon = '/esoui/art/icons/ability_2handed_002.dds' }; -- Cleave (Coldsnap Frostbiter)
    [117346] = { tooltip = Tooltips.Generic_Snare; tooltipValue2 = 60 }; -- Low Slash (Coldsnap Toothbreaker)
    [114490] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_maim.dds'; tooltip = Tooltips.Skill_Maim }; -- Maim (Coldsnap Toothbreaker)
    [109821] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rock_toss.dds' }; -- Rock Toss (Icestalker)
    [109822] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_rock_toss.dds' }; -- Rock Toss (Icestalker)
    [109803] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }; -- Leaping Crush (Icestalker)
    [109802] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }; -- Leaping Crush (Icestalker)
    [109804] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }; -- Leaping Crush (Icestalker)
    [109805] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }; -- Leaping Crush (Icestalker)
    --[[ -- TODO: Removed at some point - did these get replaced by new ID's?
    [116667] = {
        icon = "LuiExtended/media/icons/abilities/ability_troll_lope.dds",
        name = Abilities.Skill_Leaping_Crush,
    }, -- Skeletal Smash (Icestalker)
    [116666] = {
        icon = "LuiExtended/media/icons/abilities/ability_troll_lope.dds",
        name = Abilities.Skill_Leaping_Crush,
        tooltip = Tooltips.Generic_Knockback,
        type = BUFF_EFFECT_TYPE_DEBUFF,
        unbreakable = 1,
    }, -- Skeletal Smash (Icestalker)
    ]]
    --

    [109827] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Icestalker)
    [109828] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_boulder_toss.dds' }; -- Boulder Toss (Icestalker)
    [109811] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Ground Slam (Icestalker)
    [109819] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Ground Slam (Icestalker)
    [116684] = { icon = 'LuiExtended/media/icons/abilities/ability_spell_shockwave.dds' }; -- Ground Slam (Icestalker)
    [109800] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_slap.dds' }; -- Slap (Icestalker)
    [109833] = { icon = '/esoui/art/icons/achievement_frostvault_flavor_boss_1a.dds'; name = Abilities.Skill_Lifting_Strike }; -- Frenzied Pummeling (Icestalker)
    [109834] = { icon = '/esoui/art/icons/achievement_frostvault_flavor_boss_1a.dds' }; -- Lifting Strike (Icestalker)
    [109835] = { icon = '/esoui/art/icons/achievement_frostvault_flavor_boss_1a.dds'; name = Abilities.Skill_Lifting_Strike; type = BUFF_EFFECT_TYPE_DEBUFF; unbreakable = 1; tooltip = Tooltips.Generic_Knockback }; -- Frenzied Pummeling (Icestalker)
    [109837] = { icon = '/esoui/art/icons/achievement_frostvault_flavor_boss_2a.dds'; name = Abilities.Skill_Frenzied_Pummeling }; -- Frenzied Pummeling (Icestalker)
    [118489] = { icon = '/esoui/art/icons/achievement_frostvault_flavor_boss_2a.dds' }; -- Frenzied Pummeling (Icestalker)
    [121824] = { icon = '/esoui/art/icons/achievement_frostvault_flavor_boss_2a.dds' }; -- Frenzied Pummeling (Icestalker)
    [109838] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds'; name = Abilities.Skill_Recover }; -- End Stun (Icestalker)
    [109806] = { icon = '/esoui/art/icons/ability_wrothgar_bitingcold.dds' }; -- Frozen Aura (Icestalker)
    [109808] = { icon = '/esoui/art/icons/ability_wrothgar_bitingcold.dds'; name = Abilities.Skill_Frozen_Aura; groundLabel = true; tooltip = Tooltips.Generic_Snare_No_Dur; tooltipValue2 = 50 }; -- Frostbite (Icestalker)
    [109810] = { name = Abilities.Innate_Stagger; tooltip = Tooltips.Generic_Stagger; hide = true }; -- Frozen Aura (Icestalker)
    [83430] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds' }; -- Skeletal Smash (Ice Wraith)
    [83454] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds' }; -- Skeletal Smash (Ice Wraith)
    [83453] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds'; tooltip = Tooltips.Generic_Knockback }; -- Skeletal Smash (Ice Wraith)
    [116683] = { hide = true }; -- U23-DUN1 B N Intro (Skeevaton)
};
