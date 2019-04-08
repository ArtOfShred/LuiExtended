--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local CI = LUIE.CombatInfo

local strformat = zo_strformat

local optionsDataCombatInfo = {}

l_CastBarMovingEnable = false -- Helper local flag
l_AlertFrameMovingEnabled = false -- Helper local flag

-- TEMP -- TODO: REMOVE
local CT = LUIE.CombatText
local CTC = LUIE.CombatTextConstants

-- Get fonts
local FontsList = {}
for f in pairs(LUIE.Fonts) do
    table.insert(FontsList, f)
end

-- Get sounds
local SoundsList = {}
for sound, _ in pairs(LUIE.Sounds) do
    table.insert(SoundsList, sound)
end

-- Get statusbar textures
local StatusbarTexturesList = {}
for key, _ in pairs(LUIE.StatusbarTextures) do
    table.insert(StatusbarTexturesList, key)
end

local globalMethodOptions     = { "Ascending", "Descending", "Radial" }
local globalMethodOptionsKeys = { ["Ascending"] = 1, ["Descending"] = 2, ["Radial"] = 3 }

function CI.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibStub("LibAddonMenu-2.0")

    local panelDataCombatInfo = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CI)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_CI), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        slashCommand = "/luici",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    -- Combat Info Description
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_CI_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    -- Combat Info - Global Cooldown Options Submenu
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CI_HEADER_GCD),
        controls = {
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_GCD_SHOW),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_SHOW_TP),
                getFunc = function() return CI.SV.GlobalShowGCD end,
                setFunc = function(value) CI.SV.GlobalShowGCD = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_CI_GCD_SHOW_WARN),
                default = CI.D.GlobalShowGCD,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_QUICK)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_QUICK_TP),
                getFunc = function() return CI.SV.GlobalPotion end,
                setFunc = function(value) CI.SV.GlobalPotion = value end,
                width = "full",
                default = CI.D.GlobalPotion,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and CI.SV.GlobalShowGCD) end,
            },
            {
                -- Show GCD Ready Flash
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_FLASH)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_FLASH_TP),
                getFunc = function() return CI.SV.GlobalFlash end,
                setFunc = function(value) CI.SV.GlobalFlash = value end,
                width = "full",
                default = CI.D.GlobalFlash,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and CI.SV.GlobalShowGCD) end,
            },
            {
                -- GCD - Desaturate Icons on GCD
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_DESAT)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_DESAT_TP),
                getFunc = function() return CI.SV.GlobalDesat end,
                setFunc = function(value) CI.SV.GlobalDesat = value end,
                width = "full",
                default = CI.D.GlobalDesat,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and CI.SV.GlobalShowGCD) end,
            },
            {
                -- GCD - Color Slot Label Red
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_COLOR_TP),
                getFunc = function() return CI.SV.GlobalLabelColor end,
                setFunc = function(value) CI.SV.GlobalLabelColor = value end,
                width = "full",
                default = CI.D.GlobalLabelColor,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and CI.SV.GlobalShowGCD) end,
            },
            {
                -- GCD - Animation Method
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_ANIMATION)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_ANIMATION_TP),
                choices = globalMethodOptions,
                getFunc = function() return globalMethodOptions[CI.SV.GlobalMethod] end,
                setFunc = function(value) CI.SV.GlobalMethod = globalMethodOptionsKeys[value] end,
                width = "full",
                default = CI.D.GlobalMethod,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and CI.SV.GlobalShowGCD) end,
            },
        },
    }

    -- Combat Info - Ultimate Tracking Options Submenu
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CI_HEADER_ULTIMATE),
        controls = {
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ULTIMATE_SHOW_VAL),
                tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_SHOW_VAL_TP),
                getFunc = function() return CI.SV.UltimateLabelEnabled end,
                setFunc = function(value) CI.SV.UltimateLabelEnabled = value CI.RegisterCombatInfo() CI.OnSlotsFullUpdate() end,
                width = "full",
                default = CI.D.UltimateLabelEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ULTIMATE_SHOW_PCT),
                tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_SHOW_PCT_TP),
                getFunc = function() return CI.SV.UltimatePctEnabled end,
                setFunc = function(value) CI.SV.UltimatePctEnabled = value CI.RegisterCombatInfo() CI.OnSlotsFullUpdate() end,
                width = "full",
                default = CI.D.UltimatePctEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_POSITION_TP),
                min = -72, max = 40, step = 2,
                getFunc = function() return CI.SV.UltimateLabelPosition end,
                setFunc = function(value) CI.SV.UltimateLabelPosition = value CI.ResetUltimateLabel() end,
                width = "full",
                default = CI.D.UltimateLabelPosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.UltimatePctEnabled ) end,
            },
            {
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return CI.SV.UltimateFontFace end,
                setFunc = function(var) CI.SV.UltimateFontFace = var CI.ApplyFont() end,
                width = "full",
                default = CI.D.UltimateFontFace,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.UltimatePctEnabled ) end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return CI.SV.UltimateFontSize end,
                setFunc = function(value) CI.SV.UltimateFontSize = value CI.ApplyFont() end,
                width = "full",
                default = CI.D.UltimateFontSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.UltimatePctEnabled ) end,
            },
            {
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return CI.SV.UltimateFontStyle end,
                setFunc = function(var) CI.SV.UltimateFontStyle = var CI.ApplyFont() end,
                width = "full",
                default = CI.D.UltimateFontStyle,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.UltimatePctEnabled ) end,
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL)),
                tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL_TP),
                getFunc = function() return CI.SV.UltimateHideFull end,
                setFunc = function(value) CI.SV.UltimateHideFull = value CI.OnSlotsFullUpdate() end,
                width = "full",
                default = CI.D.UltimateHideFull,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.UltimatePctEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ULTIMATE_TEXTURE),
                tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_TEXTURE_TP),
                getFunc = function() return CI.SV.UltimateGeneration end,
                setFunc = function(value) CI.SV.UltimateGeneration = value end,
                width = "full",
                default = CI.D.UltimateGeneration,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
        },
    }

    -- Combat Info - Bar Ability Highlight Options Submenu
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CI_HEADER_BAR),
        controls = {
            {
                -- Highlight Ability Bar Icon for Active Procs
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_BAR_PROC),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_PROC_TP),
                getFunc = function() return CI.SV.ShowTriggered end,
                setFunc = function(value) CI.SV.ShowTriggered = value CI.UpdateBarHighlightTables() CI.OnSlotsFullUpdate() end,
                width = "full",
                default = CI.D.ShowTriggered,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                -- Bar Proc Sound
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_PROCSOUND)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_PROCSOUND_TP),
                getFunc = function() return CI.SV.ProcEnableSound end,
                setFunc = function(value) CI.SV.ProcEnableSound = value end,
                width = "full",
                default = CI.D.ProcEnableSound,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },
            {
                -- Bar Proc Sound Choice
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_PROCSOUNDCHOICE)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_PROCSOUNDCHOICE_TP),
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.ProcSoundName end,
                setFunc = function(value) CI.SV.ProcSoundName = value CI.ApplyProcSound(true) end,
                width = "full",
                default = CI.D.ProcSoundName,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },
            {
                -- Highlight Ability Bar Icon for Active Effects
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_BAR_EFFECT),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_EFFECT_TP),
                getFunc = function() return CI.SV.ShowToggled end,
                setFunc = function(value) CI.SV.ShowToggled = value CI.UpdateBarHighlightTables() CI.OnSlotsFullUpdate() end,
                width = "full",
                default = CI.D.ShowToggled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                -- Show Toggled Secondary
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_SECONDARY)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_SECONDARY_TP),
                getFunc = function() return CI.SV.ShowToggledSecondary end,
                setFunc = function(value) CI.SV.ShowToggledSecondary = value CI.UpdateBarHighlightTables() CI.OnSlotsFullUpdate() end,
                width = "full",
                default = CI.D.ShowToggledSecondary,
                disabled = function() return not (CI.SV.ShowToggled and LUIE.SV.CombatInfo_Enabled) end,
            },
            {
                -- Show Toggled Ultimate
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_ULTIMATE)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_ULTIMATE_TP),
                getFunc = function() return CI.SV.ShowToggledUltimate end,
                setFunc = function(value) CI.SV.ShowToggledUltimate = value CI.UpdateBarHighlightTables() CI.OnSlotsFullUpdate() end,
                width = "full",
                default = CI.D.ShowToggledUltimate,
                disabled = function() return not (CI.SV.ShowToggled and LUIE.SV.CombatInfo_Enabled) end,
            },
            {
                -- Show Label On Bar Highlight
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_LABEL)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_LABEL_TP),
                getFunc = function() return CI.SV.BarShowLabel end,
                setFunc = function(value) CI.SV.BarShowLabel = value CI.ResetBarLabel() end,
                width = "full",
                default = CI.D.BarShowLabel,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and ( CI.SV.ShowTriggered or CI.SV.ShowToggled) ) end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_POSITION_TP),
                min = -72, max = 40, step = 2,
                getFunc = function() return CI.SV.BarLabelPosition end,
                setFunc = function(value) CI.SV.BarLabelPosition = value CI.ResetBarLabel() end,
                width = "full",
                default = CI.D.BarLabelPosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.BarShowLabel and ( CI.SV.ShowTriggered or CI.SV.ShowToggled)) end,
            },
            {
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return CI.SV.BarFontFace end,
                setFunc = function(var) CI.SV.BarFontFace = var CI.ApplyFont() end,
                width = "full",
                default = CI.D.BarFontFace,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.BarShowLabel and ( CI.SV.ShowTriggered or CI.SV.ShowToggled)) end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return CI.SV.BarFontSize end,
                setFunc = function(value) CI.SV.BarFontSize = value CI.ApplyFont() end,
                width = "full",
                default = CI.D.BarFontSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.BarShowLabel and ( CI.SV.ShowTriggered or CI.SV.ShowToggled)) end,
            },
            {
                type = "dropdown",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return CI.SV.BarFontStyle end,
                setFunc = function(var) CI.SV.BarFontStyle = var CI.ApplyFont() end,
                width = "full",
                default = CI.D.BarFontStyle,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.BarShowLabel and ( CI.SV.ShowTriggered or CI.SV.ShowToggled)) end,
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
                getFunc = function() return CI.SV.BarMiilis end,
                setFunc = function(value) CI.SV.BarMiilis = value end,
                width = "full",
                default = CI.D.BarMiilis,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.BarShowLabel and ( CI.SV.ShowTriggered or CI.SV.ShowToggled)) end,
            },
        },
    }

    -- Combat Info - Quickslot Cooldown Timer Option Submenu
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CI_HEADER_POTION),
        controls = {
            {
                -- Show Cooldowns (Potion Only when I get finished) -- TODO
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_POTION),
                tooltip = GetString(SI_LUIE_LAM_CI_POTION_TP),
                getFunc = function() return CI.SV.PotionTimerShow end,
                setFunc = function(value) CI.SV.PotionTimerShow = value end,
                width = "full",
                default = CI.D.PotionTimerShow,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_POSITION_TP),
                min = -72, max = 40, step = 2,
                getFunc = function() return CI.SV.PotionTimerLabelPosition end,
                setFunc = function(value) CI.SV.PotionTimerLabelPosition = value CI.ResetPotionTimerLabel() end,
                width = "full",
                default = CI.D.PotionTimerLabelPosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.PotionTimerShow ) end,
            },
            {
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return CI.SV.PotionTimerFontFace end,
                setFunc = function(var) CI.SV.PotionTimerFontFace = var CI.ApplyFont() end,
                width = "full",
                default = CI.D.PotionTimerFontFace,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.PotionTimerShow ) end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return CI.SV.PotionTimerFontSize end,
                setFunc = function(value) CI.SV.PotionTimerFontSize = value CI.ApplyFont() end,
                width = "full",
                default = CI.D.PotionTimerFontSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.PotionTimerShow ) end,
            },
            {
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return CI.SV.PotionTimerFontStyle end,
                setFunc = function(var) CI.SV.PotionTimerFontStyle = var CI.ApplyFont() end,
                width = "full",
                default = CI.D.PotionTimerFontStyle,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.PotionTimerShow ) end,
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CI_POTION_COLOR_TP),
                getFunc = function() return CI.SV.PotionTimerColor end,
                setFunc = function(value) CI.SV.PotionTimerColor = value end,
                width = "full",
                default = CI.D.PotionTimerColor,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.PotionTimerShow ) end,
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
                getFunc = function() return CI.SV.PotionTimerMillis end,
                setFunc = function(value) CI.SV.PotionTimerMillis = value end,
                width = "full",
                default = CI.D.PotionTimerMillis,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.PotionTimerShow ) end,
            },
        },
    }
    -- Combat Info -- Cast Bar Option Submenu
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CI_HEADER_CASTBAR),
        controls = {

            -- Cast Bar Unlock
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_MOVE),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_MOVE_TP),
                getFunc = function() return l_CastBarMovingEnabled end,
                setFunc = CI.SetMovingState,
                width = "half",
                default = false,
                resetFunc = CI.ResetCastBarPosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.CastBarEnable ) end,
            },
            -- Cast Bar Unlock Reset position
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_RESETPOSITION),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_RESET),
                func = CI.ResetCastBarPosition,
                width = "half",
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.CastBarEnable ) end,
            },
            {
                -- Enable Cast Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_ENABLE),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_ENABLE_TP),
                getFunc = function() return CI.SV.CastBarEnable end,
                setFunc = function(value) CI.SV.CastBarEnable = value CI.RegisterCombatInfo() end,
                width = "full",
                default = CI.D.CastBarEnable,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                -- Cast Bar Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_SIZEW),
                min = 100, max = 500, step = 5,
                getFunc = function() return CI.SV.CastBarSizeW end,
                setFunc = function(value) CI.SV.CastBarSizeW = value CI.ResizeCastBar() end,
                width = "full",
                default = CI.D.CastBarSizeW,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                -- Cast Bar Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_SIZEH),
                min = 16, max = 64, step = 2,
                getFunc = function() return CI.SV.CastBarSizeH end,
                setFunc = function(value) CI.SV.CastBarSizeH = value CI.ResizeCastBar() end,
                width = "full",
                default = CI.D.CastBarSizeH,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                -- Cast Bar Icon Size
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_ICONSIZE),
                min = 16, max = 64, step = 2,
                getFunc = function() return CI.SV.CastBarIconSize end,
                setFunc = function(value) CI.SV.CastBarIconSize = value CI.ResizeCastBar() end,
                width = "full",
                default = CI.D.CastBarIconSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                -- Display Label
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_LABEL)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_LABEL_TP),
                getFunc = function() return CI.SV.CastBarLabel end,
                setFunc = function(value) CI.SV.CastBarLabel = value end,
                width = "full",
                default = CI.D.CastBarLabel,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.CastBarEnable ) end,
            },
            {
                -- Display Timer
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_TIMER)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_TIMER_TP),
                getFunc = function() return CI.SV.CastBarTimer end,
                setFunc = function(value) CI.SV.CastBarTimer = value end,
                width = "full",
                default = CI.D.CastBarTimer,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.CastBarEnable ) end,
            },
            {
                -- Cast Bar Font Face
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_FONTFACE)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_FONTFACE_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return CI.SV.CastBarFontFace end,
                setFunc = function(var) CI.SV.CastBarFontFace = var CI.ApplyFont() CI.UpdateCastBar() end,
                width = "full",
                default = CI.D.CastBarFontFace,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and CI.SV.CastBarEnable and (CI.SV.CastBarTimer or CI.SV.CastBarLabel) ) end,
            },
            {
                -- Cast Bar Font Size
                type = "slider",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_FONTSIZE)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return CI.SV.CastBarFontSize end,
                setFunc = function(value) CI.SV.CastBarFontSize = value CI.ApplyFont() CI.UpdateCastBar() end,
                width = "full",
                default = CI.D.CastBarFontSize,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and CI.SV.CastBarEnable and (CI.SV.CastBarTimer or CI.SV.CastBarLabel) ) end,
            },
            {
                -- Cast Bar Font Style
                type = "dropdown",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_FONTSTYLE)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return CI.SV.CastBarFontStyle end,
                setFunc = function(var) CI.SV.CastBarFontStyle = var CI.ApplyFont() CI.UpdateCastBar() end,
                width = "full",
                default = CI.D.CastBarFontStyle,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and CI.SV.CastBarEnable and (CI.SV.CastBarTimer or CI.SV.CastBarLabel) ) end,
            },
            {
                -- Cast Bar Texture
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_TEXTURE)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_TEXTURE_TP),
                choices = StatusbarTexturesList,
                sort = "name-up",
                getFunc = function() return CI.SV.CastBarTexture end,
                setFunc = function(value) CI.SV.CastBarTexture = value CI.UpdateCastBar() end,
                width = "full",
                default = CI.D.CastBarTexture,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.CastBarEnable ) end,
            },
            {
                -- Cast Bar Gradient Color 1
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_GRADIENTC1)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_GRADIENTC1_TP),
                getFunc = function() return unpack(CI.SV.CastBarGradientC1) end,
                setFunc = function(r, g, b, a) CI.SV.CastBarGradientC1 = { r, g, b, a } CI.UpdateCastBar() end,
                width = "half",
                default = {r=CI.SV.CastBarGradientC1[1], g=CI.SV.CastBarGradientC1[2], b=CI.SV.CastBarGradientC1[3]},
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.CastBarEnable ) end,
            },
            {
                -- Cast Bar Gradient Color 2
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_GRADIENTC2)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_GRADIENTC2_TP),
                getFunc = function() return unpack(CI.SV.CastBarGradientC2) end,
                setFunc = function(r, g, b, a) CI.SV.CastBarGradientC2 = { r, g, b, a } CI.UpdateCastBar() end,
                width = "half",
                default = {r=CI.SV.CastBarGradientC2[1], g=CI.SV.CastBarGradientC2[2], b=CI.SV.CastBarGradientC2[3]},
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and CI.SV.CastBarEnable ) end,
            },
        },
    }

    -- Active Combat Alerts
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CI_HEADER_ACTIVE_COMBAT_ALERT),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CI_NOTIFICATION_ALERTS_DESC),
            },
            {
                -- Alerts Font
                type     = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE) .. "TODO: REMOVE",
                tooltip = GetString(SI_LUIE_LAM_CI_FONT_NOTIFICATION_ALERT_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.alert end,
                setFunc = function(size) CT.SV.fontSizes.alert = size end,
                default = CT.D.fontSizes.alert,
            },

            -- Cast Bar Unlock
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_MOVE),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_MOVE_TP),
                getFunc = function() return l_AlertFrameMovingEnabled end,
                setFunc = CI.SetMovingStateAlert,
                width = "half",
                default = false,
                resetFunc = CI.ResetAlertFramePosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            -- Cast Bar Unlock Reset position
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_RESETPOSITION),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_RESET),
                func = CI.ResetAlertFramePosition,
                width = "half",
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },

            {
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = "TODO",
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return CI.SV.AlertFontFace end,
                setFunc = function(var) CI.SV.AlertFontFace = var CI.ApplyFontAlert() end,
                width = "full",
                default = CI.D.AlertFontFace,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = "TODO",
                min = 16, max = 64, step = 1,
                getFunc = function() return CI.SV.AlertFontSize end,
                setFunc = function(value) CI.SV.AlertFontSize = value CI.ApplyFontAlert() end,
                width = "full",
                default = CI.D.AlertFontSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = "TODO",
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return CI.SV.AlertFontStyle end,
                setFunc = function(var) CI.SV.AlertFontStyle = var CI.ApplyFontAlert() end,
                width = "full",
                default = CI.D.AlertFontStyle,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },


            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT),
                width = "full",
            },
            {
                -- Exploit Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_EXPLOIT_TP),
                getFunc = function() return CT.SV.toggles.showAlertExploit end,
                setFunc = function(v) CT.SV.toggles.showAlertExploit = v end,
                default = CT.D.toggles.showAlertExploit,
            },
            {
                -- Exploit  Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPLOIT_TP),
                getFunc = function() return CT.SV.formats.alertExploit end,
                setFunc = function(v) CT.SV.formats.alertExploit = v end,
                isMultiline = false,
                default = CT.D.formats.alertExploit,
            },
            {
                -- Exploit Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPLOIT_TP),
                getFunc = function() return unpack(CT.SV.colors.alertExploit) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertExploit = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertExploit[1], g=CT.D.colors.alertExploit[2], b=CT.D.colors.alertExploit[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_INCOMING_ABILITY_ALERTS),
                width = "full",
            },
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_DESCRIPTION),
            },
            {
                -- Hide Ingame Tips
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_INGAME_TIPS),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_INGAME_TIPS_TP),
                getFunc = function() return CT.SV.toggles.hideIngameTips end,
                setFunc = function(v) CT.SV.toggles.hideIngameTips = v; ZO_ActiveCombatTips:SetHidden(v) end,
                default = CT.D.toggles.hideIngameTips,
            },
            {
                -- Mitigation Alerts
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_TP),
                getFunc = function() return CT.SV.toggles.showAlertMitigation end,
                setFunc = function(v) CT.SV.toggles.showAlertMitigation = v end,
                default = CT.D.toggles.showAlertMitigation,
            },
            {
                -- Hide Mitigation Grouped Alerts
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_HIDE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_HIDE_TP),
                getFunc = function() return CT.SV.toggles.hideMitigation end,
                setFunc = function(v) CT.SV.toggles.hideMitigation = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.hideMitigation,
            },
            {
                -- Mitigation Prefix (No Name)
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationPrefix end,
                setFunc = function(v) CT.SV.toggles.mitigationPrefix = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationPrefix,
            },
            {
                -- Mitigation Prefix (Name)
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationPrefixN end,
                setFunc = function(v) CT.SV.toggles.mitigationPrefixN = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationPrefixN,
            },
            {
                -- Mitigation Suffix
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX_TP),
                getFunc = function() return CT.SV.toggles.mitigationDefaultSuffix end,
                setFunc = function(v) CT.SV.toggles.mitigationDefaultSuffix = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationDefaultSuffix,
            },
            {
                -- Mitigation Aura
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA_TP),
                getFunc = function() return CT.SV.toggles.mitigationAura end,
                setFunc = function(v) CT.SV.toggles.mitigationAura = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationAura,
            },
            {
                -- Mitigation Rank 3
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3_TP),
                getFunc = function() return CT.SV.toggles.mitigationRank3 end,
                setFunc = function(v) CT.SV.toggles.mitigationRank3 = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationRank3,
            },
            {
                -- Mitigation Rank 2
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2_TP),
                getFunc = function() return CT.SV.toggles.mitigationRank2 end,
                setFunc = function(v) CT.SV.toggles.mitigationRank2 = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationRank2,
            },
            {
                -- Mitigation Rank 1
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1_TP),
                getFunc = function() return CT.SV.toggles.mitigationRank1 end,
                setFunc = function(v) CT.SV.toggles.mitigationRank1 = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationRank1,
            },
            {
                -- Mitigation Dungeon
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON_TP),
                getFunc = function() return CT.SV.toggles.mitigationDungeon end,
                setFunc = function(v) CT.SV.toggles.mitigationDungeon = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationDungeon,
            },
            {
                -- Shared Label Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BASE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BASE_TP),
                getFunc = function() return unpack(CT.SV.colors.alertShared) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertShared = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertShared[1], g=CT.D.colors.alertShared[2], b=CT.D.colors.alertShared[3]}
            },
            {
                type = "header",
                name = "MITGATION ALERTS",
                width = "full",
            },

            {
                -- Block Enable
                type    = "checkbox",
                name    = "ENABLE MITIGATION ALERTS (TODO)",
                tooltip = "TODO ADD A TP",
                getFunc = function() return CT.SV.toggles.showAlertMitigate end,
                setFunc = function(v) CT.SV.toggles.showAlertMitigate = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertMitigate,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK),
                width = "full",
            },
            {
                -- Block Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_TP),
                getFunc = function() return CT.SV.formats.alertBlock end,
                setFunc = function(v) CT.SV.formats.alertBlock = v end,
                isMultiline = false,
                default = CT.D.formats.alertBlock,
            },
            {
                -- Block Stagger Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK_S)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_S_TP),
                getFunc = function() return CT.SV.formats.alertBlockStagger end,
                setFunc = function(v) CT.SV.formats.alertBlockStagger = v end,
                isMultiline = false,
                default = CT.D.formats.alertBlockStagger,
            },
            {
                -- Block Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BLOCK_TP),
                getFunc = function() return unpack(CT.SV.colors.alertBlockA) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertBlockA = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertBlockA[1], g=CT.D.colors.alertBlockA[2], b=CT.D.colors.alertBlockA[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE),
                width = "full",
            },
            {
                -- Dodge  Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DODGE_TP),
                getFunc = function() return CT.SV.formats.alertDodge end,
                setFunc = function(v) CT.SV.formats.alertDodge = v end,
                isMultiline = false,
                default = CT.D.formats.alertDodge,
            },
            {
                -- Dodge Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DODGE_TP),
                getFunc = function() return unpack(CT.SV.colors.alertDodgeA) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertDodgeA = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertDodgeA[1], g=CT.D.colors.alertDodgeA[2], b=CT.D.colors.alertDodgeA[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID),
                width = "full",
            },
            {
                -- Avoid Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_AVOID_TP),
                getFunc = function() return CT.SV.formats.alertAvoid end,
                setFunc = function(v) CT.SV.formats.alertAvoid = v end,
                isMultiline = false,
                default = CT.D.formats.alertAvoid,
            },
            {
                -- Avoid Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_AVOID_TP),
                getFunc = function() return unpack(CT.SV.colors.alertAvoidB) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertAvoidB = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertAvoidB[1], g=CT.D.colors.alertAvoidB[2], b=CT.D.colors.alertAvoidB[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT),
                width = "full",
            },
            {
                -- Interrupt Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_INTERRUPT_TP),
                getFunc = function() return CT.SV.formats.alertInterrupt end,
                setFunc = function(v) CT.SV.formats.alertInterrupt = v end,
                isMultiline = false,
                default = CT.D.formats.alertInterrupt,
            },
            {
                -- Interrupt Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_INTERRUPT_TP),
                getFunc = function() return unpack(CT.SV.colors.alertInterruptB) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertInterruptB = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertInterruptB[1], g=CT.D.colors.alertInterruptB[2], b=CT.D.colors.alertInterruptB[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_UNMIT),
                width = "full",
            },
            {
                -- Unmit Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_UNMIT)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_UNMIT_TP),
                getFunc = function() return CT.SV.toggles.showAlertUnmit end,
                setFunc = function(v) CT.SV.toggles.showAlertUnmit = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertUnmit,
            },
            {
                -- Unmit Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_UNMIT_TP),
                getFunc = function() return CT.SV.formats.alertUnmit end,
                setFunc = function(v) CT.SV.formats.alertUnmit = v end,
                isMultiline = false,
                default = CT.D.formats.alertUnmit,
            },
            {
                -- Unmit Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_UNMIT_TP),
                getFunc = function() return unpack(CT.SV.colors.alertUnmit) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertUnmit = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertUnmit[1], g=CT.D.colors.alertUnmit[2], b=CT.D.colors.alertUnmit[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_POWER),
                width = "full",
            },
            {
                -- Power Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_POWER)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_POWER_TP),
                getFunc = function() return CT.SV.toggles.showAlertPower end,
                setFunc = function(v) CT.SV.toggles.showAlertPower = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertPower,
            },
            {
                -- Power Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_POWER_TP),
                getFunc = function() return CT.SV.formats.alertPower end,
                setFunc = function(v) CT.SV.formats.alertPower = v end,
                isMultiline = false,
                default = CT.D.formats.alertPower,
            },
            {
                -- Prefix Power (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationPowerPrefix end,
                setFunc = function(v) CT.SV.toggles.mitigationPowerPrefix = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertPower) end,
                default = CT.D.toggles.mitigationPowerPrefix,
            },
            {
                -- Prefix Power (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationPowerPrefixN end,
                setFunc = function(v) CT.SV.toggles.mitigationPowerPrefixN = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertPower) end,
                default = CT.D.toggles.mitigationPowerPrefixN,
            },
            {
                -- Power Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POWER_TP),
                getFunc = function() return unpack(CT.SV.colors.alertPower) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertPower = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertPower[1], g=CT.D.colors.alertPower[2], b=CT.D.colors.alertPower[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DESTROY),
                width = "full",
            },
            {
                -- Destroy Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DESTROY)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_DESTROY_TP),
                getFunc = function() return CT.SV.toggles.showAlertDestroy end,
                setFunc = function(v) CT.SV.toggles.showAlertDestroy = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertDestroy,
            },
            {
                -- Destroy Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DESTROY_TP),
                getFunc = function() return CT.SV.formats.alertDestroy end,
                setFunc = function(v) CT.SV.formats.alertDestroy = v end,
                isMultiline = false,
                default = CT.D.formats.alertDestroy,
            },
            {
                -- Prefix Destroy (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationDestroyPrefix end,
                setFunc = function(v) CT.SV.toggles.mitigationDestroyPrefix = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertDestroy) end,
                default = CT.D.toggles.mitigationDestroyPrefix,
            },
            {
                -- Prefix Destroy (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationDestroyPrefixN end,
                setFunc = function(v) CT.SV.toggles.mitigationDestroyPrefixN = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertDestroy) end,
                default = CT.D.toggles.mitigationDestroyPrefixN,
            },
            {
                -- Destroy Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DESTROY_TP),
                getFunc = function() return unpack(CT.SV.colors.alertDestroy) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertDestroy = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertDestroy[1], g=CT.D.colors.alertDestroy[2], b=CT.D.colors.alertDestroy[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_SUMMON),
                width = "full",
            },
            {
                -- Summon Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_SUMMON)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_SUMMON_TP),
                getFunc = function() return CT.SV.toggles.showAlertSummon end,
                setFunc = function(v) CT.SV.toggles.showAlertSummon = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertSummon,
            },
            {
                -- Summon Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_SUMMON_TP),
                getFunc = function() return CT.SV.formats.alertSummon end,
                setFunc = function(v) CT.SV.formats.alertSummon = v end,
                isMultiline = false,
                default = CT.D.formats.alertSummon,
            },
            {
                -- Prefix Summon (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationSummonPrefix end,
                setFunc = function(v) CT.SV.toggles.mitigationSummonPrefix = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertSummon) end,
                default = CT.D.toggles.mitigationSummonPrefix,
            },
            {
                -- Prefix Summon (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationSummonPrefixN end,
                setFunc = function(v) CT.SV.toggles.mitigationSummonPrefixN = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertSummon) end,
                default = CT.D.toggles.mitigationSummonPrefixN,
            },
            {
                -- Summon Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_SUMMON_TP),
                getFunc = function() return unpack(CT.SV.colors.alertSummon) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertSummon = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertSummon[1], g=CT.D.colors.alertSummon[2], b=CT.D.colors.alertSummon[3]}
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.CombatInfo_Enabled then
        LAM:RegisterAddonPanel('LUIECombatInfoOptions', panelDataCombatInfo)
        LAM:RegisterOptionControls('LUIECombatInfoOptions', optionsDataCombatInfo)
    end
end
