--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SpellCastBuffs = LUIE.SpellCastBuffs
local BlacklistPresets = LUIE.Data.AbilityBlacklistPresets

local zo_strformat = zo_strformat

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
            options[counter] = zo_iconFormat(GetAbilityIcon(id), 16, 16) .. " [" .. id .. "] " .. zo_strformat("<<C:1>>", GetAbilityName(id))
        -- If the input is not numeric then add this as a name only.
        else
            options[counter] = id
        end
        values[counter] = id
    end
    return options, values
end

function SpellCastBuffs.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibAddonMenu2
    if LAM == nil then return end

    local Defaults = SpellCastBuffs.Defaults
    local Settings = SpellCastBuffs.SV

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
        name = zo_strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_BUFFSDEBUFFS)),
        displayName = zo_strformat("<<1>> <<2>>", LUIE.name, GetString(SI_LUIE_LAM_BUFFSDEBUFFS)),
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

    local optionsDataBuffsDebuffs = {}

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
            SpellCastBuffs.SetMovingState(value)
            end,
        width = "half",
        default = false,
        resetFunc = SpellCastBuffs.ResetTlwPosition,
    }

    -- Buffs Window Reset position
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RESETPOSITION),
        tooltip = GetString(SI_LUIE_LAM_BUFF_RESETPOSITION_TP),
        func = SpellCastBuffs.ResetTlwPosition,
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
                getFunc = function() return Settings.lockPositionToUnitFrames end,
                setFunc = function(value) Settings.lockPositionToUnitFrames = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_BUFF_HARDLOCK_WARNING),
                default = Defaults.lockPositionToUnitFrames,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF_TP),
                getFunc = function() return Settings.HidePlayerBuffs end,
                setFunc = function(value) Settings.HidePlayerBuffs = value end,
                width = "full",
                default = Defaults.HidePlayerBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF_TP),
                getFunc = function() return Settings.HidePlayerDebuffs end,
                setFunc = function(value) Settings.HidePlayerDebuffs = value end,
                width = "full",
                default = Defaults.HidePlayerDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF_TP),
                getFunc = function() return Settings.HideTargetBuffs end,
                setFunc = function(value) Settings.HideTargetBuffs = value end,
                width = "full",
                default = Defaults.HideTargetBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF_TP),
                getFunc = function() return Settings.HideTargetDebuffs end,
                setFunc = function(value) Settings.HideTargetDebuffs = value end,
                width = "full",
                default = Defaults.HideTargetDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF_TP),
                getFunc = function() return Settings.HideGroundEffects end,
                setFunc = function(value) Settings.HideGroundEffects = value end,
                width = "full",
                default = Settings.HideGroundEffects,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Ground Damage Auras
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_SHOW_GROUND_DAMAGE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOW_GROUND_DAMAGE_TP),
                getFunc = function() return Settings.GroundDamageAura end,
                setFunc = function(value) Settings.GroundDamageAura = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Settings.GroundDamageAura,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                 -- Add Extra
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_ADD_EXTRA_BUFFS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_ADD_EXTRA_BUFFS_TP),
                getFunc = function() return Settings.ExtraBuffs end,
                setFunc = function(value) Settings.ExtraBuffs = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Settings.ExtraBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Consolidate
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_CONSOLIDATE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_CONSOLIDATE_TP),
                getFunc = function() return Settings.ExtraConsolidate end,
                setFunc = function(value) Settings.ExtraConsolidate = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Settings.ExtraConsolidate,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Extra Expanded
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_EXTEND_EXTRA)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_EXTEND_EXTRA_TP),
                getFunc = function() return Settings.ExtraExpanded end,
                setFunc = function(value) Settings.ExtraExpanded = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Settings.ExtraExpanded,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.ExtraBuffs or Settings.ExtraConsolidate ) ) end,
            },
            {
                -- Reduce
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_BUFF_REDUCE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_REDUCE_TP),
                getFunc = function() return Settings.HideReduce end,
                setFunc = function(value) Settings.HideReduce = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Settings.HideReduce,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },

            {
                -- Always Show Shared Debuffs
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_ALWAYS_SHARED_EFFECTS),
                tooltip = GetString(SI_LUIE_LAM_BUFF_ALWAYS_SHARED_EFFECTS_TP),
                getFunc = function() return Settings.ShowSharedEffects end,
                setFunc = function(value) Settings.ShowSharedEffects = value SpellCastBuffs.UpdateDisplayOverrideIdList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.ShowSharedEffects,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },

            {
                -- Always Show Major/Minor Debuffs
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_ALWAYS_MAJOR_MINOR_EFFECTS),
                tooltip = GetString(SI_LUIE_LAM_BUFF_ALWAYS_MAJOR_MINOR_EFFECTS_TP),
                getFunc = function() return Settings.ShowSharedMajorMinor end,
                setFunc = function(value) Settings.ShowSharedMajorMinor = value SpellCastBuffs.UpdateDisplayOverrideNameList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.ShowSharedMajorMinor,
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
                getFunc = function() return Settings.IconSize end,
                setFunc = function(value) Settings.IconSize = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.IconSize,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Show Remaining Time Label
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL_TP),
                getFunc = function() return Settings.RemainingText end,
                setFunc = function(value) Settings.RemainingText = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.RemainingText,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Label Position
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LABEL_POSITION_TP),
                min = -64, max = 64, step = 2,
                getFunc = function() return Settings.LabelPosition end,
                setFunc = function(value) Settings.LabelPosition = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.LabelPosition,
                disabled = function() return not (Settings.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Label Font
                type = "dropdown",
                scrollable = true,
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return Settings.BuffFontFace end,
                setFunc = function(var) Settings.BuffFontFace = var SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = Defaults.BuffFontFace,
                disabled = function() return not (Settings.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Font Size
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return Settings.BuffFontSize end,
                setFunc = function(value) Settings.BuffFontSize = value SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = Defaults.BuffFontSize,
                disabled = function() return not (Settings.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Font Style
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return Settings.BuffFontStyle end,
                setFunc = function(var) Settings.BuffFontStyle = var SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = Defaults.BuffFontStyle,
                disabled = function() return not (Settings.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Colored Label
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LABELCOLOR_TP),
                getFunc = function() return Settings.RemainingTextColoured end,
                setFunc = function(value) Settings.RemainingTextColoured = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.RemainingTextColoured,
                disabled = function() return not (Settings.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Show Seconds Fractions
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
                getFunc = function() return Settings.RemainingTextMillis end,
                setFunc = function(value) Settings.RemainingTextMillis = value end,
                width = "full",
                default = Defaults.RemainingTextMillis,
                disabled = function() return not (Settings.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Alignment
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return Settings.Alignment end,
                setFunc = SpellCastBuffs.SetIconsAlignment,
                width = "full",
                default = Defaults.Alignment,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Sort Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT_TP),
                choices = {"Left to Right", "Right to Left"},
                getFunc = function() return Settings.SortDirection end,
                setFunc = SpellCastBuffs.SetSortDirection,
                width = "full",
                default = Defaults.SortDirection,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Glow Icon Border
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER_TP),
                getFunc = function() return Settings.GlowIcons end,
                setFunc = function(value) Settings.GlowIcons = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.GlowIcons,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Show Border Cooldown
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN_TP),
                getFunc = function() return Settings.RemainingCooldown end,
                setFunc = function(value) Settings.RemainingCooldown = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.RemainingCooldown,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Fade Expiring Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON_TP),
                getFunc = function() return Settings.FadeOutIcons end,
                setFunc = function(value) Settings.FadeOutIcons = value end,
                width = "full",
                default = Defaults.FadeOutIcons,
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
                getFunc = function() return Settings.TooltipEnable end,
                setFunc = function(value) Settings.TooltipEnable = value end,
                width = "full",
                default = Defaults.TooltipEnable,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Tooltip Ability Id
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_ABILITY_ID),
                tooltip = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_ABILITY_ID_TP),
                getFunc = function() return Settings.TooltipAbilityId end,
                setFunc = function(value) Settings.TooltipAbilityId = value end,
                width = "full",
                default = Defaults.TooltipAbilityId,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Tooltip Buff Type
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_BUFF_TYPE),
                tooltip = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_BUFF_TYPE_TP),
                getFunc = function() return Settings.TooltipBuffType end,
                setFunc = function(value) Settings.TooltipBuffType = value end,
                width = "full",
                default = Defaults.TooltipBuffType,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Sticky Tooltip Slider
                type = "slider",
                name = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_STICKY),
                tooltip = GetString(SI_LUIE_LAM_BUFF_TOOLTIP_STICKY_TP),
                min = 0, max = 5000, step = 100,
                getFunc = function() return Settings.TooltipSticky end,
                setFunc = function(value) Settings.TooltipSticky = value end,
                width = "full",
                default = Defaults.TooltipSticky,
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
                getFunc = function() return Settings.LongTermEffects_Player end,
                setFunc = function(value) Settings.LongTermEffects_Player = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.LongTermEffects_Player,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET_TP),
                getFunc = function() return Settings.LongTermEffects_Target end,
                setFunc = function(value) Settings.LongTermEffects_Target = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.LongTermEffects_Target,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Seperate control for player effects
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL_TP),
                getFunc = function() return Settings.LongTermEffectsSeparate end,
                setFunc = function(value) Settings.LongTermEffectsSeparate = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.LongTermEffectsSeparate,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.LongTermEffects_Player ) end,
            },
            {
                -- Container orientation
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER_TP),
                choices = rotationOptions,
                getFunc = function() return rotationOptions[Settings.LongTermEffectsSeparateAlignment] end,
                setFunc = function(value) Settings.LongTermEffectsSeparateAlignment = rotationOptionsKeys[value] SpellCastBuffs.Reset() end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = rotationOptions[2],
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.LongTermEffects_Player and Settings.LongTermEffectsSeparate ) end,
            },
            {
                -- Vertical Long Term Icons Alignment
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERT)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERT_TP),
                choices = { "Top", "Middle", "Bottom" },
                getFunc = function() return Settings.AlignmentLongVert end,
                setFunc = SpellCastBuffs.SetIconsAlignmentLongVert,
                width = "full",
                default = Defaults.AlignmentLongVert,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.LongTermEffects_Player and Settings.LongTermEffectsSeparate and Settings.LongTermEffectsSeparateAlignment == 2 ) end,
            },
            {
                -- Horizontal Long Term Icons Alignment
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_HORIZ)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_HORIZ_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return Settings.AlignmentLongHorz end,
                setFunc = SpellCastBuffs.SetIconsAlignmentLongHorz,
                width = "full",
                default = Defaults.AlignmentLongHorz,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.LongTermEffects_Player and Settings.LongTermEffectsSeparate and Settings.LongTermEffectsSeparateAlignment == 1) end,
            },
            {
                -- Long Term Reverse Sort Order
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER_TP),
                getFunc = function() return Settings.LongTermEffectsReverse end,
                setFunc = function(value) Settings.LongTermEffectsReverse = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.LongTermEffectsReverse,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.LongTermEffects_Player ) end,
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
                getFunc = function() return not Settings.IgnoreDisguise end,
                setFunc = function(value) Settings.IgnoreDisguise = not value SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not Defaults.IgnoreDisguise,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Assistants
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT_TP),
                getFunc = function() return not Settings.IgnoreAssistant end,
                setFunc = function(value) Settings.IgnoreAssistant = not value SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not Defaults.IgnoreAssistant,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mounts
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_TP),
                getFunc = function() return not Settings.IgnoreMount end,
                setFunc = function(value) Settings.IgnoreMount = not value SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not Defaults.IgnoreMount,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Use Generic Mount Icon
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_ICON)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_ICON_TP),
                getFunc = function() return Settings.MountGenericIcon end,
                setFunc = function(value) Settings.MountGenericIcon = value SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not Defaults.MountGenericIcon,
                disabled = function() return Settings.IgnoreMount and not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Pets
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET_TP),
                getFunc = function() return not Settings.IgnorePet end,
                setFunc = function(value) Settings.IgnorePet = not value SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not Defaults.IgnorePet,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Set ICD - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER_TP),
                getFunc = function() return not Settings.IgnoreSetICDPlayer end,
                setFunc = function(value) Settings.IgnoreSetICDPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreSetICDPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mundus - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER_TP),
                getFunc = function() return not Settings.IgnoreMundusPlayer end,
                setFunc = function(value) Settings.IgnoreMundusPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreMundusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mundus - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET_TP),
                getFunc = function() return not Settings.IgnoreMundusTarget end,
                setFunc = function(value) Settings.IgnoreMundusTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreMundusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Food & Drink - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODPLAYER_TP),
                getFunc = function() return not Settings.IgnoreFoodPlayer end,
                setFunc = function(value) Settings.IgnoreFoodPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreFoodPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Food & Drink - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODTARGET_TP),
                getFunc = function() return not Settings.IgnoreFoodTarget end,
                setFunc = function(value) Settings.IgnoreFoodTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreFoodTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Experience - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCEPLAYER_TP),
                getFunc = function() return not Settings.IgnoreExperiencePlayer end,
                setFunc = function(value) Settings.IgnoreExperiencePlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreExperiencePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Experience - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCETARGET_TP),
                getFunc = function() return not Settings.IgnoreExperienceTarget end,
                setFunc = function(value) Settings.IgnoreExperienceTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreExperienceTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Vamp Stage - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER_TP),
                getFunc = function() return not Settings.IgnoreVampPlayer end,
                setFunc = function(value) Settings.IgnoreVampPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreVampPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Vamp Stage - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET_TP),
                getFunc = function() return not Settings.IgnoreVampTarget end,
                setFunc = function(value) Settings.IgnoreVampTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreVampTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Lycanthrophy - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER_TP),
                getFunc = function() return not Settings.IgnoreLycanPlayer end,
                setFunc = function(value) Settings.IgnoreLycanPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreLycanPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Lycanthrophy - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET_TP),
                getFunc = function() return not Settings.IgnoreLycanTarget end,
                setFunc = function(value) Settings.IgnoreLycanTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreLycanTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Disease - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER_TP),
                getFunc = function() return not Settings.IgnoreDiseasePlayer end,
                setFunc = function(value) Settings.IgnoreDiseasePlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreDiseasePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Disease - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET_TP),
                getFunc = function() return not Settings.IgnoreDiseaseTarget end,
                setFunc = function(value) Settings.IgnoreDiseaseTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreDiseaseTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Timers - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER_TP),
                getFunc = function() return not Settings.IgnoreBitePlayer end,
                setFunc = function(value) Settings.IgnoreBitePlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreBitePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Timers - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET_TP),
                getFunc = function() return not Settings.IgnoreBiteTarget end,
                setFunc = function(value) Settings.IgnoreBiteTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreBiteTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Battle Spirit - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER_TP),
                getFunc = function() return not Settings.IgnoreBattleSpiritPlayer end,
                setFunc = function(value) Settings.IgnoreBattleSpiritPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") SpellCastBuffs.ArtificialEffectUpdate() end,
                width = "full",
                default = not Defaults.IgnoreBattleSpiritPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Battle Spirit - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET_TP),
                getFunc = function() return not Settings.IgnoreBattleSpiritTarget end,
                setFunc = function(value) Settings.IgnoreBattleSpiritTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreBattleSpiritTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Cyrodiil - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER_TP),
                getFunc = function() return not Settings.IgnoreCyrodiilPlayer end,
                setFunc = function(value) Settings.IgnoreCyrodiilPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreCyrodiilPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Crodiil - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET_TP),
                getFunc = function() return not Settings.IgnoreCyrodiilTarget end,
                setFunc = function(value) Settings.IgnoreCyrodiilTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreCyrodiilTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - ESO Plus - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER_TP),
                getFunc = function() return not Settings.IgnoreEsoPlusPlayer end,
                setFunc = function(value) Settings.IgnoreEsoPlusPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreEsoPlusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - ESO Plus - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET_TP),
                getFunc = function() return not Settings.IgnoreEsoPlusTarget end,
                setFunc = function(value) Settings.IgnoreEsoPlusTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreEsoPlusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Soul Summons - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER_TP),
                getFunc = function() return not Settings.IgnoreSoulSummonsPlayer end,
                setFunc = function(value) Settings.IgnoreSoulSummonsPlayer = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreSoulSummonsPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Soul Summons - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET_TP),
                getFunc = function() return not Settings.IgnoreSoulSummonsTarget end,
                setFunc = function(value) Settings.IgnoreSoulSummonsTarget = not value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not Defaults.IgnoreSoulSummonsTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( Settings.LongTermEffects_Player or Settings.LongTermEffects_Target ) ) end,
            },
        },
    }

    -- Buffs&Debuffs - Short Term Effect Filters Options Submenu
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_MISC_HEADER),
        controls = {
            --[[
            {
                -- Show Sprint Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT_TP),
                getFunc = function() return Settings.ShowSprint end,
                setFunc = function(value) Settings.ShowSprint = value end,
                width = "full",
                default = Defaults.ShowSprint,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Gallop Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP_TP),
                getFunc = function() return Settings.ShowGallop end,
                setFunc = function(value) Settings.ShowGallop = value end,
                width = "full",
                default = Defaults.ShowGallop,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            ]]--
            {
                -- Show Rezz Immunity Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ_TP),
                getFunc = function() return Settings.ShowResurrectionImmunity end,
                setFunc = function(value) Settings.ShowResurrectionImmunity = value end,
                width = "full",
                default = Defaults.ShowResurrectionImmunity,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Recall Cooldown Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL_TP),
                getFunc = function() return Settings.ShowRecall end,
                setFunc = function(value) Settings.ShowRecall = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.ShowRecall,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Werewolf Timer Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWWEREWOLF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWWEREWOLF_TP),
                getFunc = function() return Settings.ShowWerewolf end,
                setFunc = function(value) Settings.ShowWerewolf = value SpellCastBuffs.RegisterWerewolfEvents() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.ShowWerewolf,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Block Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER_TP),
                getFunc = function() return Settings.ShowBlockPlayer end,
                setFunc = function(value) Settings.ShowBlockPlayer = value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.ShowBlockPlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Block Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET_TP),
                getFunc = function() return Settings.ShowBlockTarget end,
                setFunc = function(value) Settings.ShowBlockTarget = value SpellCastBuffs.UpdateContextHideList() SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.ShowBlockTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Stealth Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER_TP),
                getFunc = function() return Settings.StealthStatePlayer end,
                setFunc = function(value) Settings.StealthStatePlayer = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.StealthStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Stealth Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET_TP),
                getFunc = function() return Settings.StealthStateTarget end,
                setFunc = function(value) Settings.StealthStateTarget = value SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = Defaults.StealthStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Disguise Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER_TP),
                getFunc = function() return Settings.DisguiseStatePlayer end,
                setFunc = function(value) Settings.DisguiseStatePlayer = value SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.DisguiseStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Disguise Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET_TP),
                getFunc = function() return Settings.DisguiseStateTarget end,
                setFunc = function(value) Settings.DisguiseStateTarget = value SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = Defaults.DisguiseStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
        },
    }

    -- Buffs&Debuffs - Custom Icon & Normalization Options
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_NORMALIZE_HEADER),
        controls = {
            {
                -- Potion - Use Major/Minor Icons
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_GENERIC_POTION),
                tooltip = GetString(SI_LUIE_LAM_GENERIC_POTION_TP),
                getFunc = function() return Settings.GenericPotion end,
                setFunc = function(value) Settings.GenericPotion = value SpellCastBuffs.UpdatePotionList(true) SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.GenericPotion,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Posion - Use Major/Minor Icons
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_GENERIC_POISON),
                tooltip = GetString(SI_LUIE_LAM_GENERIC_POISON_TP),
                getFunc = function() return Settings.GenericPoison end,
                setFunc = function(value) Settings.GenericPoison = value SpellCastBuffs.UpdatePoisonList(true) SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.GenericPoison,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Status Effects - Use Major/Minor Icons
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_GENERIC_STATUS),
                tooltip = GetString(SI_LUIE_LAM_GENERIC_STATUS_TP),
                getFunc = function() return Settings.GenericStatusEffect end,
                setFunc = function(value) Settings.GenericStatusEffect = value SpellCastBuffs.UpdateStatusEffectList(true) SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.GenericStatusEffect,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Slayer/Courage Etc Use Default
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_GENERIC_MAJOR_MINOR),
                tooltip = GetString(SI_LUIE_LAM_GENERIC_MAJOR_MINOR_TP),
                getFunc = function() return Settings.GenericMajorMinor end,
                setFunc = function(value) Settings.GenericMajorMinor = value SpellCastBuffs.UpdateMajorMinorList(true) SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = Defaults.GenericMajorMinor,
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
                getFunc = function() return Settings.ProminentLabel end,
                setFunc = function(value) Settings.ProminentLabel = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.ProminentLabel,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Buffs Label Font Face
                type = "dropdown",
                scrollable = true,
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_FONTFACE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_FONTFACE_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return Settings.ProminentLabelFontFace end,
                setFunc = function(var) Settings.ProminentLabelFontFace = var SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = Defaults.ProminentLabelFontFace,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentLabel ) end,
            },
            {
                -- Prominent Buffs Label Font Size
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_FONTSIZE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return Settings.ProminentLabelFontSize end,
                setFunc = function(value) Settings.ProminentLabelFontSize = value SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = Defaults.ProminentLabelFontSize,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentLabel ) end,
            },
            {
                -- Prominent Buffs Label Font Style
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_FONTSTYLE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return Settings.ProminentLabelFontStyle end,
                setFunc = function(var) Settings.ProminentLabelFontStyle = var SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = Defaults.ProminentLabelFontStyle,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentLabel ) end,
            },
            {
                -- Prominent Buffs Progress Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR_TP),
                getFunc = function() return Settings.ProminentProgress end,
                setFunc = function(value) Settings.ProminentProgress = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.ProminentProgress,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Buffs Progress Bar Texture
                type = "dropdown",
                scrollable = true,
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR_TEXTURE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR_TEXTURE_TP),
                choices = StatusbarTexturesList,
                sort = "name-up",
                getFunc = function() return Settings.ProminentProgressTexture end,
                setFunc = function(value) Settings.ProminentProgressTexture = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.ProminentProgressTexture,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentProgress ) end,
            },
            {
                -- Prominent Buffs Gradient Color 1
                type    = "colorpicker",
                name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF1)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF1_TP),
                getFunc = function() return unpack(Settings.ProminentProgressBuffC1) end,
                setFunc = function(r, g, b, a) Settings.ProminentProgressBuffC1 = { r, g, b, a } SpellCastBuffs.Reset() end,
                width = "half",
                default = {r=Settings.ProminentProgressBuffC1[1], g=Settings.ProminentProgressBuffC1[2], b=Settings.ProminentProgressBuffC1[3]},
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentProgress ) end,
            },
            {
                -- Prominent Buffs Gradient Color 2
                type    = "colorpicker",
                name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF2)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF2_TP),
                getFunc = function() return unpack(Settings.ProminentProgressBuffC2) end,
                setFunc = function(r, g, b, a) Settings.ProminentProgressBuffC2 = { r, g, b, a } SpellCastBuffs.Reset() end,
                width = "half",
                default = {r=Settings.ProminentProgressBuffC2[1], g=Settings.ProminentProgressBuffC2[2], b=Settings.ProminentProgressBuffC2[3]},
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentProgress ) end,
            },
            {
                -- Prominent Debuffs Gradient Color 1
                type    = "colorpicker",
                name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF1)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF1_TP),
                getFunc = function() return unpack(Settings.ProminentProgressDebuffC1) end,
                setFunc = function(r, g, b, a) Settings.ProminentProgressDebuffC1 = { r, g, b, a } SpellCastBuffs.Reset() end,
                width = "half",
                default = {r=Settings.ProminentProgressDebuffC1[1], g=Settings.ProminentProgressDebuffC1[2], b=Settings.ProminentProgressDebuffC1[3]},
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentProgress ) end,
            },
            {
                -- Prominent Debuffs Gradient Color 2
                type    = "colorpicker",
                name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF2)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF2_TP),
                getFunc = function() return unpack(Settings.ProminentProgressDebuffC2) end,
                setFunc = function(r, g, b, a) Settings.ProminentProgressDebuffC2 = { r, g, b, a } SpellCastBuffs.Reset() end,
                width = "half",
                default = {r=Settings.ProminentProgressDebuffC2[1], g=Settings.ProminentProgressDebuffC2[2], b=Settings.ProminentProgressDebuffC2[3]},
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentProgress ) end,
            },
            {
                -- Prominent Buffs Label/Progress Bar Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFLABELDIRECTION),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFLABELDIRECTION_TP),
                choices = { "Right", "Left" },
                sort = "name-up",
                getFunc = function() return Settings.ProminentBuffLabelDirection end,
                setFunc = function(var) Settings.ProminentBuffLabelDirection = var SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.ProminentBuffLabelDirection,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and (Settings.ProminentLabel or Settings.ProminentProgress) ) end,
            },
            {
                -- Prominent Debuffs Label/Progress Bar Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFLABELDIRECTION),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFLABELDIRECTION_TP),
                choices = { "Right", "Left" },
                sort = "name-up",
                getFunc = function() return Settings.ProminentDebuffLabelDirection end,
                setFunc = function(var) Settings.ProminentDebuffLabelDirection = var SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.ProminentDebuffLabelDirection,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and (Settings.ProminentLabel or Settings.ProminentProgress) ) end,
            },
			{
                -- Prominent Buff container orientation
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFCONTAINER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFCONTAINER_TP),
                choices = rotationOptions,
                getFunc = function() return rotationOptions[Settings.ProminentBuffContainerAlignment] end,
                setFunc = function(value) Settings.ProminentBuffContainerAlignment = rotationOptionsKeys[value] SpellCastBuffs.Reset() end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = rotationOptions[2],
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Buffs Vertical Alignment
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_BUFF_PROM_BUFFALIGNMENT_VERT)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFALIGNMENT_VERT_TP),
                choices = { "Top", "Middle", "Bottom" },
                sort = "name-up",
                getFunc = function() return Settings.ProminentBuffAlignmentVertical end,
                setFunc = SpellCastBuffs.SetIconsAlignmentProminentBuffVert,
                width = "full",
                default = Defaults.ProminentBuffAlignmentVertical,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentBuffContainerAlignment == 2) end,
            },
			{
                -- Prominent Buffs Horizontal Alignment
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_BUFFALIGNMENT_HORIZ)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFALIGNMENT_HORIZ_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return Settings.ProminentBuffAlignmentHorizontal end,
                setFunc = SpellCastBuffs.SetIconsAlignmentProminentBuffHoriz,
                width = "full",
                default = Defaults.ProminentBuffAlignmentHorizontal,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentBuffContainerAlignment == 1) end,
            },
			{
                -- Prominent Debuff container orientation
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFCONTAINER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFCONTAINER_TP),
                choices = rotationOptions,
                getFunc = function() return rotationOptions[Settings.ProminentDebuffContainerAlignment] end,
                setFunc = function(value) Settings.ProminentDebuffContainerAlignment = rotationOptionsKeys[value] SpellCastBuffs.Reset() end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = rotationOptions[2],
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Debuffs Vertical Alignment
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFALIGNMENT_VERT)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFALIGNMENT_VERT_TP),
                choices = { "Top", "Middle", "Bottom" },
                sort = "name-up",
                getFunc = function() return Settings.ProminentDebuffAlignmentVertical end,
                setFunc = SpellCastBuffs.SetIconsAlignmentProminentDebuffVert,
                width = "full",
                default = Defaults.ProminentDebuffAlignmentVertical,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentDebuffContainerAlignment == 2) end,
            },
			{
                -- Prominent Debuffs Horizontal Alignment
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFALIGNMENT_HORIZ)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFALIGNMENT_HORIZ_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return Settings.ProminentDebuffAlignmentHorizontal end,
                setFunc = SpellCastBuffs.SetIconsAlignmentProminentDebuffHoriz,
                width = "full",
                default = Defaults.ProminentDebuffAlignmentHorizontal,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and Settings.ProminentDebuffContainerAlignment == 1) end,
            },
            {
                -- Prominent Buffs Reverse Sort Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFREVERSESORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFREVERSESORT),
                getFunc = function() return Settings.ProminentBuffReverseSort end,
                setFunc = function(value) Settings.ProminentBuffReverseSort = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.ProminentBuffReverseSort,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Debuffs Reverse Sort Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFREVERSESORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFREVERSESORT),
                getFunc = function() return Settings.ProminentDebuffReverseSort end,
                setFunc = function(value) Settings.ProminentDebuffReverseSort = value SpellCastBuffs.Reset() end,
                width = "full",
                default = Defaults.ProminentDebuffReverseSort,
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
                setFunc = function(value) SpellCastBuffs.AddToCustomList(Settings.PromBuffTable, value) LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(Settings.PromBuffTable)) end,
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
                getFunc = function() LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(Settings.PromBuffTable)) end,
                setFunc = function(value) SpellCastBuffs.RemoveFromCustomList(Settings.PromBuffTable, value) LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(Settings.PromBuffTable)) end,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
                reference = "LUIE_Prominent_Buffs_List"
            },
            {
                -- Prominent Debuffs List (Add)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFF_ADDLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFF_ADDLIST_TP),
                getFunc = function() end,
                setFunc = function(value) SpellCastBuffs.AddToCustomList(Settings.PromDebuffTable, value) LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(Settings.PromDebuffTable)) end,
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
                getFunc = function() LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(Settings.PromDebuffTable)) end,
                setFunc = function(value) SpellCastBuffs.RemoveFromCustomList(Settings.PromDebuffTable, value) LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(Settings.PromDebuffTable)) end,
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
            -- Add Minor Buffs
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADD_MINOR_BUFF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADD_MINOR_BUFF_TP),
                func = function() SpellCastBuffs.AddBulkToCustomList(Settings.BlacklistTable, BlacklistPresets.MinorBuffs) LUIE_Blacklist:UpdateChoices(GenerateCustomList(Settings.BlacklistTable)) end,
                width = "half",
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            -- Add Major Buffs
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADD_MAJOR_BUFF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADD_MAJOR_BUFF_TP),
                func = function() SpellCastBuffs.AddBulkToCustomList(Settings.BlacklistTable, BlacklistPresets.MajorBuffs) LUIE_Blacklist:UpdateChoices(GenerateCustomList(Settings.BlacklistTable)) end,
                width = "half",
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            -- Add Minor Debuffs
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADD_MINOR_DEBUFF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADD_MINOR_DEBUFF_TP),
                func = function() SpellCastBuffs.AddBulkToCustomList(Settings.BlacklistTable, BlacklistPresets.MinorDebuffs) LUIE_Blacklist:UpdateChoices(GenerateCustomList(Settings.BlacklistTable)) end,
                width = "half",
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            -- Add Major Debuffs
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADD_MAJOR_DEBUFF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADD_MAJOR_DEBUFF_TP),
                func = function() SpellCastBuffs.AddBulkToCustomList(Settings.BlacklistTable, BlacklistPresets.MajorDebuffs) LUIE_Blacklist:UpdateChoices(GenerateCustomList(Settings.BlacklistTable)) end,
                width = "half",
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Clear Blacklist
                type = "button",
                name = GetString(SI_LUIE_LAM_UF_BLACKLIST_CLEAR),
                tooltip = GetString(SI_LUIE_LAM_UF_BLACKLIST_CLEAR_TP),
                func = function() SpellCastBuffs.ClearCustomList(Settings.BlacklistTable) LUIE_Blacklist:UpdateChoices(GenerateCustomList(Settings.BlacklistTable)) end,
                width = "half",
            },
            {
                -- Buffs & Debuffs Blacklist (Add)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADDLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_BLACKLIST_ADDLIST_TP),
                getFunc = function() end,
                setFunc = function(value) SpellCastBuffs.AddToCustomList(Settings.BlacklistTable, value) LUIE_Blacklist:UpdateChoices(GenerateCustomList(Settings.BlacklistTable)) end,
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
                getFunc = function() LUIE_Blacklist:UpdateChoices(GenerateCustomList(Settings.BlacklistTable)) end,
                setFunc = function(value) SpellCastBuffs.RemoveFromCustomList(Settings.BlacklistTable, value) LUIE_Blacklist:UpdateChoices(GenerateCustomList(Settings.BlacklistTable)) end,
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
        getFunc = function() return Settings.ShowDebugAbilityId end,
        setFunc = function(value) Settings.ShowDebugAbilityId = value SpellCastBuffs.Reset() end,
        width = "full",
        default = Defaults.ShowDebugAbilityId,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Show Debug for Combat Events",
        tooltip = "Display debug information for combat events - used for development.",
        getFunc = function() return Settings.ShowDebugCombat end,
        setFunc = function(value) Settings.ShowDebugCombat = value SpellCastBuffs.RegisterDebugEvents() end,
        width = "full",
        default = Defaults.ShowDebugCombat,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Show Debug for Effect Change Events",
        tooltip = "Display debug information for effect change events - used for development.",
        getFunc = function() return Settings.ShowDebugEffect end,
        setFunc = function(value) Settings.ShowDebugEffect = value SpellCastBuffs.RegisterDebugEvents() end,
        width = "full",
        default = Defaults.ShowDebugEffect,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Filter Debug Events & Effects",
        tooltip = "Filter out events and effects that have already been processed - used for development.",
        getFunc = function() return Settings.ShowDebugFilter end,
        setFunc = function(value) Settings.ShowDebugFilter = value end,
        width = "full",
        default = Defaults.ShowDebugFilter,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Register the settings panel
    if LUIE.SV.SpellCastBuff_Enable then
        LAM:RegisterAddonPanel(LUIE.name .. 'BuffsAndDebuffsOptions', panelDataBuffsDebuffs)
        LAM:RegisterOptionControls(LUIE.name .. 'BuffsAndDebuffsOptions', optionsDataBuffsDebuffs)
    end
end
