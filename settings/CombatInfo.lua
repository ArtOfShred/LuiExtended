--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local CI = LUIE.CombatInfo

local strformat = zo_strformat

local optionsDataCombatInfo = {}

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

    -- Register the settings panel
    if LUIE.SV.CombatInfo_Enabled then
        LAM:RegisterAddonPanel('LUIECombatInfoOptions', panelDataCombatInfo)
        LAM:RegisterOptionControls('LUIECombatInfoOptions', optionsDataCombatInfo)
    end
end
