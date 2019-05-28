--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SCB = LUIE.SpellCastBuffs

local strformat = zo_strformat

local optionsDataBuffsDebuffs = {}

local g_BuffsMovingEnabled = false -- Helper local flag

local rotationOptions     = { "Horizontal", "Vertical" }
local rotationOptionsKeys = { ["Horizontal"] = 1, ["Vertical"] = 2 }

-- Variables for custom generated tables
local PromBuffs, PromBuffsValues = {}
local PromDebuffs, PromDebuffsValues = {}
local Blacklist, BlackListValues = {}

-- Create a list of abilityId's / abilityName's to use for Blacklist
local function GenerateCustomList(input)
    local options, values = {}, {}
    local counter = 0
    for id in pairs(input) do
        counter = counter + 1
        -- If the input is a numeric value then we can pull this abilityId's info.
        if type(id) == "number" then
            options[counter] = zo_iconFormat(GetAbilityIcon(id), 16, 16) .. " [" .. id .. "] " .. strformat("<<C:1>>", GetAbilityName(id))
        -- If the input is not numeric then add this as a name only.
        else
            options[counter] = id
        end
        values[counter] = id
    end
    return options, values
end

function SCB.CreateSettings()
    -- Load LibAddonMenu
    local LAM = _G["LibAddonMenu2"]

    -- Get fonts
    local FontsList = {}
    for f in pairs(LUIE.Fonts) do
        table.insert(FontsList, f)
    end

    -- Get statusbar textures
    local StatusbarTexturesList = {}
    for key, _ in pairs(LUIE.StatusbarTextures) do
        table.insert(StatusbarTexturesList, key)
    end

    local panelDataBuffsDebuffs = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_BUFFSDEBUFFS)),
        displayName = strformat("<<1>> <<2>>", LUIE.name, GetString(SI_LUIE_LAM_BUFFSDEBUFFS)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        feedback = LUIE.feedback,
        translation = LUIE.translation,
        donation = LUIE.donation,
        slashCommand = "/luiscb",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    -- Buffs & Debuffs Description
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_BUFFS_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    -- Buffs Window Unlock
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_BUFF_UNLOCKWINDOW),
        tooltip = GetString(SI_LUIE_LAM_BUFF_UNLOCKWINDOW_TP),
        getFunc = function() return g_BuffsMovingEnabled end,
        setFunc = function(value)
            g_BuffsMovingEnabled = value
            SCB.SetMovingState(value)
            end,
        width = "half",
        default = false,
        resetFunc = SCB.ResetTlwPosition,
    }

    -- Buffs Window Reset position
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RESETPOSITION),
        tooltip = GetString(SI_LUIE_LAM_BUFF_RESETPOSITION_TP),
        func = SCB.ResetTlwPosition,
        width = "half",
    }

    -- Buffs&Debuffs - Position and Display Options Submenu
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_HEADER_POSITION),
        controls = {
            {
                -- Hard-Lock Position to Unit Frames
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_HARDLOCK),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HARDLOCK_TP),
                getFunc = function() return SCB.SV.lockPositionToUnitFrames end,
                setFunc = function(value) SCB.SV.lockPositionToUnitFrames = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_BUFF_HARDLOCK_WARNING),
                default = SCB.D.lockPositionToUnitFrames,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF_TP),
                getFunc = function() return SCB.SV.HidePlayerBuffs end,
                setFunc = function(value) SCB.SV.HidePlayerBuffs = value end,
                width = "full",
                default = SCB.D.HidePlayerBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF_TP),
                getFunc = function() return SCB.SV.HidePlayerDebuffs end,
                setFunc = function(value) SCB.SV.HidePlayerDebuffs = value end,
                width = "full",
                default = SCB.D.HidePlayerDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF_TP),
                getFunc = function() return SCB.SV.HideTargetBuffs end,
                setFunc = function(value) SCB.SV.HideTargetBuffs = value end,
                width = "full",
                default = SCB.D.HideTargetBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF_TP),
                getFunc = function() return SCB.SV.HideTargetDebuffs end,
                setFunc = function(value) SCB.SV.HideTargetDebuffs = value end,
                width = "full",
                default = SCB.D.HideTargetDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF_TP),
                getFunc = function() return SCB.SV.HideGroundEffects end,
                setFunc = function(value) SCB.SV.HideGroundEffects = value end,
                width = "full",
                default = SCB.SV.HideGroundEffects,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Ground Damage Auras
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_SHOW_GROUND_DAMAGE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOW_GROUND_DAMAGE_TP),
                getFunc = function() return SCB.SV.GroundDamageAura end,
                setFunc = function(value) SCB.SV.GroundDamageAura = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.SV.GroundDamageAura,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                 -- Add Extra
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_ADD_EXTRA_BUFFS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_ADD_EXTRA_BUFFS_TP),
                getFunc = function() return SCB.SV.ExtraBuffs end,
                setFunc = function(value) SCB.SV.ExtraBuffs = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.SV.ExtraBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Consolidate
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_CONSOLIDATE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_CONSOLIDATE_TP),
                getFunc = function() return SCB.SV.ExtraConsolidate end,
                setFunc = function(value) SCB.SV.ExtraConsolidate = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.SV.ExtraConsolidate,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Extra Expanded
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_EXTEND_EXTRA)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_EXTEND_EXTRA_TP),
                getFunc = function() return SCB.SV.ExtraExpanded end,
                setFunc = function(value) SCB.SV.ExtraExpanded = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.SV.ExtraExpanded,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.ExtraBuffs or SCB.SV.ExtraConsolidate ) ) end,
            },
            {
                -- Reduce
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_REDUCE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_REDUCE_TP),
                getFunc = function() return SCB.SV.HideReduce end,
                setFunc = function(value) SCB.SV.HideReduce = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.SV.HideReduce,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
        },
    }

    -- Buffs&Debuffs - Icon Options Submenu
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_ICON_HEADER),
        controls = {
            {
                -- Buff Icon Size
                type = "slider",
                name = GetString(SI_LUIE_LAM_BUFF_ICONSIZE),
                tooltip = GetString(SI_LUIE_LAM_BUFF_ICONSIZE_TP),
                min = 30, max = 60, step = 2,
                getFunc = function() return SCB.SV.IconSize end,
                setFunc = function(value) SCB.SV.IconSize = value SCB.Reset() end,
                width = "full",
                default = SCB.D.IconSize,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Show Remaining Time Label
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL_TP),
                getFunc = function() return SCB.SV.RemainingText end,
                setFunc = function(value) SCB.SV.RemainingText = value SCB.Reset() end,
                width = "full",
                default = SCB.D.RemainingText,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Label Position
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LABEL_POSITION_TP),
                min = -64, max = 64, step = 2,
                getFunc = function() return SCB.SV.LabelPosition end,
                setFunc = function(value) SCB.SV.LabelPosition = value SCB.Reset() end,
                width = "full",
                default = SCB.D.LabelPosition,
                disabled = function() return not (SCB.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Label Font
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return SCB.SV.BuffFontFace end,
                setFunc = function(var) SCB.SV.BuffFontFace = var SCB.ApplyFont() end,
                width = "full",
                default = SCB.D.BuffFontFace,
                disabled = function() return not (SCB.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Font Size
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return SCB.SV.BuffFontSize end,
                setFunc = function(value) SCB.SV.BuffFontSize = value SCB.ApplyFont() end,
                width = "full",
                default = SCB.D.BuffFontSize,
                disabled = function() return not (SCB.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Font Style
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return SCB.SV.BuffFontStyle end,
                setFunc = function(var) SCB.SV.BuffFontStyle = var SCB.ApplyFont() end,
                width = "full",
                default = SCB.D.BuffFontStyle,
                disabled = function() return not (SCB.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Colored Label
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LABELCOLOR_TP),
                getFunc = function() return SCB.SV.RemainingTextColoured end,
                setFunc = function(value) SCB.SV.RemainingTextColoured = value SCB.Reset() end,
                width = "full",
                default = SCB.D.RemainingTextColoured,
                disabled = function() return not (SCB.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Show Seconds Fractions
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
                getFunc = function() return SCB.SV.RemainingTextMillis end,
                setFunc = function(value) SCB.SV.RemainingTextMillis = value end,
                width = "full",
                default = SCB.D.RemainingTextMillis,
                disabled = function() return not (SCB.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Alignment
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return SCB.SV.Alignment end,
                setFunc = SCB.SetIconsAlignment,
                width = "full",
                default = SCB.D.Alignment,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Sort Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT_TP),
                choices = {"Left to Right", "Right to Left"},
                getFunc = function() return SCB.SV.SortDirection end,
                setFunc = SCB.SetSortDirection,
                width = "full",
                default = SCB.D.SortDirection,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Glow Icon Border
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER_TP),
                getFunc = function() return SCB.SV.GlowIcons end,
                setFunc = function(value) SCB.SV.GlowIcons = value SCB.Reset() end,
                width = "full",
                default = SCB.D.GlowIcons,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Show Border Cooldown
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN_TP),
                getFunc = function() return SCB.SV.RemainingCooldown end,
                setFunc = function(value) SCB.SV.RemainingCooldown = value SCB.Reset() end,
                width = "full",
                default = SCB.D.RemainingCooldown,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Fade Expiring Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON_TP),
                getFunc = function() return SCB.SV.FadeOutIcons end,
                setFunc = function(value) SCB.SV.FadeOutIcons = value end,
                width = "full",
                default = SCB.D.FadeOutIcons,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
        },
    }

    -- Buffs&Debuffs - Tooltip Options Submenu
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_HEADER),
        controls = {
            {
                -- Tooltip Enable
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_ENABLE),
                tooltip = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_ENABLE_TP),
                getFunc = function() return SCB.SV.TooltipEnable end,
                setFunc = function(value) SCB.SV.TooltipEnable = value end,
                width = "full",
                default = SCB.D.TooltipEnable,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Sticky Tooltip Slider
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_TOOLTIP_STICKY)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_STICKY_TP),
                min = 0, max = 5000, step = 100,
                getFunc = function() return SCB.SV.TooltipSticky end,
                setFunc = function(value) SCB.SV.TooltipSticky = value end,
                width = "full",
                default = SCB.D.TooltipSticky,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },

        },
    }

    -- Buffs&Debuffs - Long Term Effects Options Submenu
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_HEADER),
        controls = {
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SELF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SELF_TP),
                getFunc = function() return SCB.SV.LongTermEffects_Player end,
                setFunc = function(value) SCB.SV.LongTermEffects_Player = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.D.LongTermEffects_Player,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET_TP),
                getFunc = function() return SCB.SV.LongTermEffects_Target end,
                setFunc = function(value) SCB.SV.LongTermEffects_Target = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.D.LongTermEffects_Target,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Seperate control for player effects
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL_TP),
                getFunc = function() return SCB.SV.LongTermEffectsSeparate end,
                setFunc = function(value) SCB.SV.LongTermEffectsSeparate = value SCB.Reset() end,
                width = "full",
                default = SCB.D.LongTermEffectsSeparate,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.LongTermEffects_Player ) end,
            },
            {
                -- Container orientation
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER_TP),
                choices = rotationOptions,
                getFunc = function() return rotationOptions[SCB.SV.LongTermEffectsSeparateAlignment] end,
                setFunc = function(value) SCB.SV.LongTermEffectsSeparateAlignment = rotationOptionsKeys[value] SCB.Reset() end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = rotationOptions[2],
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.LongTermEffects_Player and SCB.SV.LongTermEffectsSeparate ) end,
            },
            {
                -- Vertical Long Term Icons Alignment
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERT)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERT_TP),
                choices = { "Top", "Middle", "Bottom" },
                getFunc = function() return SCB.SV.AlignmentLongVert end,
                setFunc = SCB.SetIconsAlignmentLongVert,
                width = "full",
                default = SCB.D.AlignmentLongVert,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.LongTermEffects_Player and SCB.SV.LongTermEffectsSeparate and SCB.SV.LongTermEffectsSeparateAlignment == 2 ) end,
            },
            {
                -- Horizontal Long Term Icons Alignment
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_HORIZ)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_HORIZ_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return SCB.SV.AlignmentLongHorz end,
                setFunc = SCB.SetIconsAlignmentLongHorz,
                width = "full",
                default = SCB.D.AlignmentLongHorz,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.LongTermEffects_Player and SCB.SV.LongTermEffectsSeparate and SCB.SV.LongTermEffectsSeparateAlignment == 1) end,
            },
            {
                -- Long Term Reverse Sort Order
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER_TP),
                getFunc = function() return SCB.SV.LongTermEffectsReverse end,
                setFunc = function(value) SCB.SV.LongTermEffectsReverse = value SCB.Reset() end,
                width = "full",
                default = SCB.D.LongTermEffectsReverse,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.LongTermEffects_Player ) end,
            },
        },
    }

    -- Buffs&Debuffs - Long Term Effect Filters Options Submenu
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_FILTER_LONG_HEADER),
        controls = {
            {
                -- Long Term - Disguises
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_DISGUISE),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_DISGUISE_TP),
                getFunc = function() return not SCB.SV.IgnoreDisguise end,
                setFunc = function(value) SCB.SV.IgnoreDisguise = not value SCB.OnPlayerActivated() end,
                width = "full",
                default = not SCB.D.IgnoreDisguise,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Assistants
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT_TP),
                getFunc = function() return not SCB.SV.IgnoreAssistant end,
                setFunc = function(value) SCB.SV.IgnoreAssistant = not value SCB.OnPlayerActivated() end,
                width = "full",
                default = not SCB.D.IgnoreAssistant,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mounts
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_TP),
                getFunc = function() return not SCB.SV.IgnoreMount end,
                setFunc = function(value) SCB.SV.IgnoreMount = not value SCB.OnPlayerActivated() end,
                width = "full",
                default = not SCB.D.IgnoreMount,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Use Generic Mount Icon
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_ICON)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_ICON_TP),
                getFunc = function() return SCB.SV.MountGenericIcon end,
                setFunc = function(value) SCB.SV.MountGenericIcon = value SCB.OnPlayerActivated() end,
                width = "full",
                default = not SCB.D.MountGenericIcon,
                disabled = function() return SCB.SV.IgnoreMount and not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Pets
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET_TP),
                getFunc = function() return not SCB.SV.IgnorePet end,
                setFunc = function(value) SCB.SV.IgnorePet = not value SCB.OnPlayerActivated() end,
                width = "full",
                default = not SCB.D.IgnorePet,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mundus - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreMundusPlayer end,
                setFunc = function(value) SCB.SV.IgnoreMundusPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreMundusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mundus - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreMundusTarget end,
                setFunc = function(value) SCB.SV.IgnoreMundusTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreMundusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Food & Drink - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreFoodPlayer end,
                setFunc = function(value) SCB.SV.IgnoreFoodPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreFoodPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Food & Drink - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreFoodTarget end,
                setFunc = function(value) SCB.SV.IgnoreFoodTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreFoodTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Experience - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCEPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreExperiencePlayer end,
                setFunc = function(value) SCB.SV.IgnoreExperiencePlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreExperiencePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Experience - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCETARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreExperienceTarget end,
                setFunc = function(value) SCB.SV.IgnoreExperienceTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreExperienceTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Vamp Stage - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreVampPlayer end,
                setFunc = function(value) SCB.SV.IgnoreVampPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreVampPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Vamp Stage - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreVampTarget end,
                setFunc = function(value) SCB.SV.IgnoreVampTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreVampTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Lycanthrophy - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreLycanPlayer end,
                setFunc = function(value) SCB.SV.IgnoreLycanPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreLycanPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Lycanthrophy - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreLycanTarget end,
                setFunc = function(value) SCB.SV.IgnoreLycanTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreLycanTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Disease - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreDiseasePlayer end,
                setFunc = function(value) SCB.SV.IgnoreDiseasePlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreDiseasePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Disease - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreDiseaseTarget end,
                setFunc = function(value) SCB.SV.IgnoreDiseaseTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreDiseaseTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Timers - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreBitePlayer end,
                setFunc = function(value) SCB.SV.IgnoreBitePlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreBitePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Timers - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreBiteTarget end,
                setFunc = function(value) SCB.SV.IgnoreBiteTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreBiteTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Battle Spirit - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreBattleSpiritPlayer end,
                setFunc = function(value) SCB.SV.IgnoreBattleSpiritPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") SCB.ArtificialEffectUpdate() end,
                width = "full",
                default = not SCB.D.IgnoreBattleSpiritPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Battle Spirit - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreBattleSpiritTarget end,
                setFunc = function(value) SCB.SV.IgnoreBattleSpiritTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreBattleSpiritTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Cyrodiil - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreCyrodiilPlayer end,
                setFunc = function(value) SCB.SV.IgnoreCyrodiilPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreCyrodiilPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Crodiil - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreCyrodiilTarget end,
                setFunc = function(value) SCB.SV.IgnoreCyrodiilTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreCyrodiilTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - ESO Plus - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreEsoPlusPlayer end,
                setFunc = function(value) SCB.SV.IgnoreEsoPlusPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreEsoPlusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - ESO Plus - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreEsoPlusTarget end,
                setFunc = function(value) SCB.SV.IgnoreEsoPlusTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreEsoPlusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Soul Summons - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreSoulSummonsPlayer end,
                setFunc = function(value) SCB.SV.IgnoreSoulSummonsPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreSoulSummonsPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Soul Summons - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreSoulSummonsTarget end,
                setFunc = function(value) SCB.SV.IgnoreSoulSummonsTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreSoulSummonsTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Set ICD - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER_TP),
                getFunc = function() return not SCB.SV.IgnoreSetICDPlayer end,
                setFunc = function(value) SCB.SV.IgnoreSetICDPlayer = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreSetICDPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Set ICD - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDTARGET_TP),
                getFunc = function() return not SCB.SV.IgnoreSetICDTarget end,
                setFunc = function(value) SCB.SV.IgnoreSetICDTarget = not value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = not SCB.D.IgnoreSetICDTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( SCB.SV.LongTermEffects_Player or SCB.SV.LongTermEffects_Target ) ) end,
            },
        },
    }

    -- Buffs&Debuffs - Short Term Effect Filters Options Submenu
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_MISC_HEADER),
        controls = {
            {
                -- Show Sprint Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT_TP),
                getFunc = function() return SCB.SV.ShowSprint end,
                setFunc = function(value) SCB.SV.ShowSprint = value end,
                width = "full",
                default = SCB.D.ShowSprint,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Gallop Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP_TP),
                getFunc = function() return SCB.SV.ShowGallop end,
                setFunc = function(value) SCB.SV.ShowGallop = value end,
                width = "full",
                default = SCB.D.ShowGallop,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Rezz Immunity Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ_TP),
                getFunc = function() return SCB.SV.ShowResurrectionImmunity end,
                setFunc = function(value) SCB.SV.ShowResurrectionImmunity = value end,
                width = "full",
                default = SCB.D.ShowResurrectionImmunity,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Recall Cooldown Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL_TP),
                getFunc = function() return SCB.SV.ShowRecall end,
                setFunc = function(value) SCB.SV.ShowRecall = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.D.ShowRecall,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Werewolf Timer Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWWEREWOLF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWWEREWOLF_TP),
                getFunc = function() return SCB.SV.ShowWerewolf end,
                setFunc = function(value) SCB.SV.ShowWerewolf = value SCB.RegisterWerewolfEvents() SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.D.ShowWerewolf,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Block Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER_TP),
                getFunc = function() return SCB.SV.ShowBlockPlayer end,
                setFunc = function(value) SCB.SV.ShowBlockPlayer = value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.D.ShowBlockPlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Block Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET_TP),
                getFunc = function() return SCB.SV.ShowBlockTarget end,
                setFunc = function(value) SCB.SV.ShowBlockTarget = value SCB.UpdateContextHideList() SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.D.ShowBlockTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Stealth Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER_TP),
                getFunc = function() return SCB.SV.StealthStatePlayer end,
                setFunc = function(value) SCB.SV.StealthStatePlayer = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.D.StealthStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Stealth Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET_TP),
                getFunc = function() return SCB.SV.StealthStateTarget end,
                setFunc = function(value) SCB.SV.StealthStateTarget = value SCB.ReloadEffects("reticleover") end,
                width = "full",
                default = SCB.D.StealthStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Disguise Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER_TP),
                getFunc = function() return SCB.SV.DisguiseStatePlayer end,
                setFunc = function(value) SCB.SV.DisguiseStatePlayer = value SCB.ReloadEffects("player") end,
                width = "full",
                default = SCB.D.DisguiseStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Disguise Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET_TP),
                getFunc = function() return SCB.SV.DisguiseStateTarget end,
                setFunc = function(value) SCB.SV.DisguiseStateTarget = value SCB.ReloadEffects("reticleover") end,
                width = "full",
                default = SCB.D.DisguiseStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
        },
    }

    -- Buffs&Debuffs - Prominent Buffs & Debuffs Options Submenu
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_PROM_HEADER),
        controls = {
            {
                -- Prominent Buffs & Debuffs Description
                type = "description",
                text = GetString(SI_LUIE_LAM_BUFF_PROM_DESCRIPTION),
            },
            {
                -- Prominent Buffs Label Toggle
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_LABEL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_LABEL_TP),
                getFunc = function() return SCB.SV.ProminentLabel end,
                setFunc = function(value) SCB.SV.ProminentLabel = value SCB.Reset() end,
                width = "full",
                default = SCB.D.ProminentLabel,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Buffs Label Font Face
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_FONTFACE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_FONTFACE_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return SCB.SV.ProminentLabelFontFace end,
                setFunc = function(var) SCB.SV.ProminentLabelFontFace = var SCB.ApplyFont() end,
                width = "full",
                default = SCB.D.ProminentLabelFontFace,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.ProminentLabel ) end,
            },
            {
                -- Prominent Buffs Label Font Size
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_FONTSIZE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return SCB.SV.ProminentLabelFontSize end,
                setFunc = function(value) SCB.SV.ProminentLabelFontSize = value SCB.ApplyFont() end,
                width = "full",
                default = SCB.D.ProminentLabelFontSize,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.ProminentLabel ) end,
            },
            {
                -- Prominent Buffs Label Font Style
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_FONTSTYLE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return SCB.SV.ProminentLabelFontStyle end,
                setFunc = function(var) SCB.SV.ProminentLabelFontStyle = var SCB.ApplyFont() end,
                width = "full",
                default = SCB.D.ProminentLabelFontStyle,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.ProminentLabel ) end,
            },
            {
                -- Prominent Buffs Progress Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR_TP),
                getFunc = function() return SCB.SV.ProminentProgress end,
                setFunc = function(value) SCB.SV.ProminentProgress = value SCB.Reset() end,
                width = "full",
                default = SCB.D.ProminentProgress,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Buffs Progress Bar Texture
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR_TEXTURE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR_TEXTURE_TP),
                choices = StatusbarTexturesList,
                sort = "name-up",
                getFunc = function() return SCB.SV.ProminentProgressTexture end,
                setFunc = function(value) SCB.SV.ProminentProgressTexture = value SCB.Reset() end,
                width = "full",
                default = SCB.D.ProminentProgressTexture,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.ProminentProgress ) end,
            },
            {
                -- Prominent Buffs Gradient Color 1
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF1)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF1_TP),
                getFunc = function() return unpack(SCB.SV.ProminentProgressBuffC1) end,
                setFunc = function(r, g, b, a) SCB.SV.ProminentProgressBuffC1 = { r, g, b, a } SCB.Reset() end,
                width = "half",
                default = {r=SCB.SV.ProminentProgressBuffC1[1], g=SCB.SV.ProminentProgressBuffC1[2], b=SCB.SV.ProminentProgressBuffC1[3]},
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.ProminentProgress ) end,
            },
            {
                -- Prominent Buffs Gradient Color 2
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF2)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF2_TP),
                getFunc = function() return unpack(SCB.SV.ProminentProgressBuffC2) end,
                setFunc = function(r, g, b, a) SCB.SV.ProminentProgressBuffC2 = { r, g, b, a } SCB.Reset() end,
                width = "half",
                default = {r=SCB.SV.ProminentProgressBuffC2[1], g=SCB.SV.ProminentProgressBuffC2[2], b=SCB.SV.ProminentProgressBuffC2[3]},
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.ProminentProgress ) end,
            },
            {
                -- Prominent Debuffs Gradient Color 1
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF1)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF1_TP),
                getFunc = function() return unpack(SCB.SV.ProminentProgressDebuffC1) end,
                setFunc = function(r, g, b, a) SCB.SV.ProminentProgressDebuffC1 = { r, g, b, a } SCB.Reset() end,
                width = "half",
                default = {r=SCB.SV.ProminentProgressDebuffC1[1], g=SCB.SV.ProminentProgressDebuffC1[2], b=SCB.SV.ProminentProgressDebuffC1[3]},
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.ProminentProgress ) end,
            },
            {
                -- Prominent Debuffs Gradient Color 2
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF2)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF2_TP),
                getFunc = function() return unpack(SCB.SV.ProminentProgressDebuffC2) end,
                setFunc = function(r, g, b, a) SCB.SV.ProminentProgressDebuffC2 = { r, g, b, a } SCB.Reset() end,
                width = "half",
                default = {r=SCB.SV.ProminentProgressDebuffC2[1], g=SCB.SV.ProminentProgressDebuffC2[2], b=SCB.SV.ProminentProgressDebuffC2[3]},
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and SCB.SV.ProminentProgress ) end,
            },
            {
                -- Prominent Buffs Label/Progress Bar Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFLABELDIRECTION),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFLABELDIRECTION_TP),
                choices = { "Right", "Left" },
                sort = "name-up",
                getFunc = function() return SCB.SV.ProminentBuffLabelDirection end,
                setFunc = function(var) SCB.SV.ProminentBuffLabelDirection = var SCB.Reset() end,
                width = "full",
                default = SCB.D.ProminentBuffLabelDirection,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and (SCB.SV.ProminentLabel or SCB.SV.ProminentProgress) ) end,
            },
            {
                -- Prominent Debuffs Label/Progress Bar Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFLABELDIRECTION),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFLABELDIRECTION_TP),
                choices = { "Right", "Left" },
                sort = "name-up",
                getFunc = function() return SCB.SV.ProminentDebuffLabelDirection end,
                setFunc = function(var) SCB.SV.ProminentDebuffLabelDirection = var SCB.Reset() end,
                width = "full",
                default = SCB.D.ProminentDebuffLabelDirection,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and (SCB.SV.ProminentLabel or SCB.SV.ProminentProgress) ) end,
            },
            {
                -- Prominent Buffs Alignment
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFALIGNMENT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFALIGNMENT_TP),
                choices = { "Top", "Middle", "Bottom" },
                sort = "name-up",
                getFunc = function() return SCB.SV.ProminentBuffAlignment end,
                setFunc = SCB.SetIconsAlignmentProminentBuff,
                width = "full",
                default = SCB.D.ProminentBuffAlignment,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Debuffs Alignment
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFALIGNMENT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFALIGNMENT_TP),
                choices = { "Top", "Middle", "Bottom" },
                sort = "name-up",
                getFunc = function() return SCB.SV.ProminentDebuffAlignment end,
                setFunc = SCB.SetIconsAlignmentProminentDebuff,
                width = "full",
                default = SCB.D.ProminentDebuffAlignment,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Buffs Reverse Sort Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFREVERSESORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFREVERSESORT),
                getFunc = function() return SCB.SV.ProminentBuffReverseSort end,
                setFunc = function(value) SCB.SV.ProminentBuffReverseSort = value SCB.Reset() end,
                width = "full",
                default = SCB.D.ProminentBuffReverseSort,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Debuffs Reverse Sort Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFREVERSESORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFREVERSESORT),
                getFunc = function() return SCB.SV.ProminentDebuffReverseSort end,
                setFunc = function(value) SCB.SV.ProminentDebuffReverseSort = value SCB.Reset() end,
                width = "full",
                default = SCB.D.ProminentDebuffReverseSort,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_BUFF_PROM_DIALOGUE_DESCRIPT),
            },
            {
                -- Prominent Buffs List (Add)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFF_ADDLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFF_ADDLIST_TP),
                getFunc = function() end,
                setFunc = function(value) SCB.AddToCustomList(SCB.SV.PromBuffTable, value) LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(SCB.SV.PromBuffTable)) end,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Buffs List (Remove)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFF_REMLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFF_REMLIST_TP),
                choices = PromBuffs,
                choicesValues = PromBuffsValues,
                scrollable = true,
                sort = "name-up",
                getFunc = function() LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(SCB.SV.PromBuffTable)) end,
                setFunc = function(value) SCB.RemoveFromCustomList(SCB.SV.PromBuffTable, value) LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(SCB.SV.PromBuffTable)) end,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
                reference = "LUIE_Prominent_Buffs_List"
            },
            {
                -- Prominent Debuffs List (Add)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFF_ADDLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFF_ADDLIST_TP),
                getFunc = function() end,
                setFunc = function(value) SCB.AddToCustomList(SCB.SV.PromDebuffTable, value) LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(SCB.SV.PromDebuffTable)) end,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Debuffs List (Remove)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFF_REMLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFF_REMLIST_TP),
                choices = PromDebuffs,
                choicesValues = PromDebuffsValues,
                scrollable = true,
                sort = "name-up",
                getFunc = function() LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(SCB.SV.PromDebuffTable)) end,
                setFunc = function(value) SCB.RemoveFromCustomList(SCB.SV.PromDebuffTable, value) LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(SCB.SV.PromDebuffTable)) end,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
                reference = "LUIE_Prominent_Debuffs_List"
            },
       },
    }

    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_HEADER),
        controls = {
            {
                -- Buffs & Debuffs Blacklist Description
                type = "description",
                text = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_DESCRIPT),
            },
            {
                -- Buffs & Debuffs Blacklist (Add)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADDLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADDLIST_TP),
                getFunc = function() end,
                setFunc = function(value) SCB.AddToCustomList(SCB.SV.BlacklistTable, value) LUIE_Blacklist:UpdateChoices(GenerateCustomList(SCB.SV.BlacklistTable)) end,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Buffs & Debuffs Blacklist (Remove)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_REMLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_REMLIST_TP),
                choices = Blacklist,
                choicesValues = BlacklistValues,
                scrollable = true,
                sort = "name-up",
                getFunc = function() LUIE_Blacklist:UpdateChoices(GenerateCustomList(SCB.SV.BlacklistTable)) end,
                setFunc = function(value) SCB.RemoveFromCustomList(SCB.SV.BlacklistTable, value) LUIE_Blacklist:UpdateChoices(GenerateCustomList(SCB.SV.BlacklistTable)) end,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
                reference = "LUIE_Blacklist"
            },
        },
    }

    -- Debug Options
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "header",
        name = "Debug Options",
        width = "full",
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Show AbilityId on Buffs & Debuffs",
        tooltip = "Toggle the display of AbilityId on buffs and debuffs - useful for adding auras to Prominent Buffs & Debuffs or the Aura Blacklist.",
        getFunc = function() return SCB.SV.ShowDebugAbilityId end,
        setFunc = function(value) SCB.SV.ShowDebugAbilityId = value SCB.Reset() end,
        width = "full",
        default = SCB.D.ShowDebugAbilityId,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Show Debug for Combat Events",
        tooltip = "Display debug information for combat events - used for development.",
        getFunc = function() return SCB.SV.ShowDebugCombat end,
        setFunc = function(value) SCB.SV.ShowDebugCombat = value SCB.RegisterDebugEvents() end,
        width = "full",
        default = SCB.D.ShowDebugCombat,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Show Debug for Effect Change Events",
        tooltip = "Display debug information for effect change events - used for development.",
        getFunc = function() return SCB.SV.ShowDebugEffect end,
        setFunc = function(value) SCB.SV.ShowDebugEffect = value SCB.RegisterDebugEvents() end,
        width = "full",
        default = SCB.D.ShowDebugEffect,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Filter Debug Events & Effects",
        tooltip = "Filter out events and effects that have already been processed - used for development.",
        getFunc = function() return SCB.SV.ShowDebugFilter end,
        setFunc = function(value) SCB.SV.ShowDebugFilter = value end,
        width = "full",
        default = SCB.D.ShowDebugFilter,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Register the settings panel
    if LUIE.SV.SpellCastBuff_Enable then
        LAM:RegisterAddonPanel('LUIEBuffsAndDebuffsOptions', panelDataBuffsDebuffs)
        LAM:RegisterOptionControls('LUIEBuffsAndDebuffsOptions', optionsDataBuffsDebuffs)
    end
end
